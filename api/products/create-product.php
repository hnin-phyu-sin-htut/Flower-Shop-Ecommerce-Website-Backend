<?php
require_once "../../config/database.php";
include_once "../../config/cors.php";

$db = (new Database())->connect();

$name = $_POST['name'];
$price = $_POST['price'];
$quantity = $_POST['quantity'];
$categoryId = $_POST['categoryId'];

$imagePath = null;

if (!empty($_FILES['image']['name'])) {
    $fileName = time() . "_" . $_FILES['image']['name'];
    $target = "../../uploads/products/" . $fileName;
    move_uploaded_file($_FILES['image']['tmp_name'], $target);
    $imagePath = "/uploads/products/" . $fileName;
}

$sql = "INSERT INTO products (name, price, quantity, image, category_id)
        VALUES (?, ?, ?, ?, ?)";

$stmt = $db->prepare($sql);
$stmt->execute([$name, $price, $quantity, $imagePath, $categoryId]);

echo json_encode(["message" => "Product created successfully."]);
