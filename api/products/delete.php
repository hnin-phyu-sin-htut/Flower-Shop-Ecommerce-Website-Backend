<?php
require_once "../../config/database.php";
include_once "../../config/cors.php";

$id = $_GET['id'];
$db = (new Database())->connect();

$stmt = $db->prepare("DELETE FROM products WHERE id=?");
$stmt->execute([$id]);

echo json_encode(["message" => "Product deleted!"]);
