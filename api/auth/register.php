<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once "../../config/database.php";
require_once "../../utils/response.php";

$data = json_decode(file_get_contents("php://input"), true);

// Validate input
if (
    empty($data['username']) ||
    empty($data['password']) ||
    empty($data['email']) ||
    empty($data['userType'])
) {
    jsonResponse(["message" => "Invalid Input!"], 400);
}

$role = $data['userType'] === "ADMIN"
    ? "ROLE_ADMIN"
    : "ROLE_CUSTOMER";

try {
    $db = (new Database())->connect();

    // Check existing user
    $check = $db->prepare(
        "SELECT id FROM users WHERE username = :username OR email = :email"
    );
    $check->execute([
        ":username" => $data['username'],
        ":email" => $data['email']
    ]);

    if ($check->rowCount() > 0) {
        jsonResponse(["message" => "User already exists"], 401);
    }

    // Insert user
    $stmt = $db->prepare("
        INSERT INTO users (username, email, password, phone, address, role)
        VALUES (:username, :email, :password, :phone, :address, :role)
    ");

    $success = $stmt->execute([
        ":username" => $data['username'],
        ":email" => $data['email'],
        ":password" => password_hash($data['password'], PASSWORD_BCRYPT),
        ":phone" => $data['phone'] ?? null,
        ":address" => $data['address'] ?? null,
        ":role" => $role
    ]);

    if ($success) {
        jsonResponse(["message" => "Registered Successfully."], 201);
    } else {
        jsonResponse(["message" => "Failed to register!"], 500);
    }

} catch (PDOException $e) {
    jsonResponse([
        "message" => "Registration failed!",
        "error" => $e->getMessage()
    ], 500);
}
?>
