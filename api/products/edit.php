<?php
require_once "../../config/database.php";
include_once "../../config/cors.php";

$id = $_GET['id'] ?? null;
if (!$id) {
    http_response_code(400);
    echo json_encode(["error" => "Product ID is required."]);
    exit;
}

$db = (new Database())->connect();

$name = $_POST['name'] ?? '';
$price = $_POST['price'] ?? 0;
$quantity = $_POST['quantity'] ?? 0;
$categoryId = $_POST['categoryId'] ?? null;

$imagePath = null;

if (!empty($_FILES['image']['name'])) {
    $uploadDir = __DIR__ . "/../../uploads/products/";

    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    $fileName = time() . "_" . basename($_FILES['image']['name']);
    $target = $uploadDir . $fileName;

    if (move_uploaded_file($_FILES['image']['tmp_name'], $target)) {
        $imagePath = "/Flower-Shop-Ecommerce-Website-Backend/uploads/products/" . $fileName;
    }
}

if ($imagePath) {
    $sql = "UPDATE products 
            SET name=?, price=?, quantity=?, category_id=?, image=?
            WHERE id=?";
    $stmt = $db->prepare($sql);
    $stmt->execute([$name, $price, $quantity, $categoryId, $imagePath, $id]);
} else {
    $sql = "UPDATE products 
            SET name=?, price=?, quantity=?, category_id=?
            WHERE id=?";
    $stmt = $db->prepare($sql);
    $stmt->execute([$name, $price, $quantity, $categoryId, $id]);
}

echo json_encode(["message" => "Product updated successfully."]);
