<?php
require_once "../../config/database.php";
include_once "../../config/cors.php";

$items = json_decode(file_get_contents("php://input"), true);

$db = (new Database())->connect();

foreach ($items as $item) {
    $stmt = $db->prepare(
        "INSERT INTO orders (product_id, quantity, total_price)
         VALUES (?, ?, ?)"
    );
    $stmt->execute([
        $item['id'],
        $item['quantity'],
        $item['totalPrice']
    ]);
}

echo json_encode(["message" => "Checkout successful."]);
