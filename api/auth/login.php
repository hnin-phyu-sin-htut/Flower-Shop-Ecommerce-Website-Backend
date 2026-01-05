<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once "../../config/database.php";
require_once "../../utils/response.php";

$data = json_decode(file_get_contents("php://input"), true);

if (empty($data['username']) || empty($data['password'])) {
    jsonResponse(["message" => "Invalid Credentials!"], 400);
}

try {
    $db = (new Database())->connect();

    $stmt = $db->prepare("
        SELECT username, email, password, role
        FROM users
        WHERE username = :value OR email = :value
        LIMIT 1
    ");

    $stmt->execute([
        ":value" => $data['username']
    ]);

    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$user || !password_verify($data['password'], $user['password'])) {
        jsonResponse(["message" => "Invalid username or password."], 401);
    }

    jsonResponse([
        "username" => $user['username'],
        "roleName" => $user['role']
    ]);

} catch (PDOException $e) {
    jsonResponse([
        "message" => "Login failed",
        "error" => $e->getMessage()
    ], 500);
}
