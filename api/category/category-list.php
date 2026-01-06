<?php
require_once "../../config/database.php";
require_once "../../config/cors.php";

$db = (new Database())->connect();
$stmt = $db->query("SELECT * FROM categories");
$categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

$categories = array_map(fn($c) => [
    "id" => $c['id'],
    "categoryName" => $c['name']
], $categories);

echo json_encode($categories);
