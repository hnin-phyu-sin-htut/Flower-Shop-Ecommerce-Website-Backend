<?php
require_once "../../config/database.php";
include_once "../../config/cors.php";

$db = (new Database())->connect();

$sql = "
SELECT 
    p.id,
    p.name,
    p.price,
    p.quantity,
    p.image,
    c.id AS categoryId,
    c.name AS categoryName
FROM products p
JOIN categories c ON p.category_id = c.id
";

$stmt = $db->prepare($sql);
$stmt->execute();

echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
