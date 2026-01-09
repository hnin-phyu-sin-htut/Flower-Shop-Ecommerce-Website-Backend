<?php
require_once "../../config/database.php";
require_once "../../config/cors.php";

$data = json_decode(file_get_contents("php://input"), true);
$db = (new Database())->connect();

$stmt = $db->query("SELECT * FROM categories");
$categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

$categories = array_map(fn($c) => [
    "id" => $c['id'],
    "categoryName" => $c['name']
], $categories);

if (in_array($data['categoryName'], array_column($categories, 'categoryName'))) {
    http_response_code(400);
    echo json_encode(["error" => "Category already exists!"]);
    exit;
}

$stmt = $db->prepare("INSERT INTO categories (name) VALUES (:name)");
if (!$stmt->execute(["name" => $data['categoryName']])) {
    http_response_code(500);
    echo json_encode(["error" => "Failed to create category!"]);
    exit;
}

echo json_encode(["message" => "Category created successfully!"]);
