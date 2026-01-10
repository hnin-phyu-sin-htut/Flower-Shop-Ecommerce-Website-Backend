<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, X-USER-ID");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once "../../config/database.php";

$userId = $_SERVER['HTTP_X_USER_ID'] ?? null;
if (!$userId || !is_numeric($userId)) {
    http_response_code(401);
    echo json_encode(["error" => "Unauthorized: missing or invalid user ID"]);
    exit;
}

$input = file_get_contents("php://input");
$data = json_decode($input, true);

if (!$data || !is_array($data) || count($data) === 0) {
    http_response_code(400);
    echo json_encode(["error" => "Cart is empty!"]);
    exit;
}

$totalPrice = 0;
foreach ($data as &$item) {
    $item['id'] = intval($item['id'] ?? 0);
    $item['price'] = floatval($item['price'] ?? 0);
    $item['quantity'] = intval($item['quantity'] ?? 0);

    if ($item['id'] <= 0 || $item['quantity'] <= 0 || $item['price'] <= 0) {
        http_response_code(400);
        echo json_encode(["error" => "Invalid item data", "item" => $item]);
        exit;
    }

    $item['subTotal'] = $item['price'] * $item['quantity'];
    $totalPrice += $item['subTotal'];
}

try {
    $db = new Database();
    $pdo = $db->connect();
    $pdo->beginTransaction();

    $orderNumber = "ORD-" . time();
    $stmt = $pdo->prepare("
        INSERT INTO orders (order_number, user_id, total_price, order_date)
        VALUES (?, ?, ?, NOW())
    ");
    $stmt->execute([$orderNumber, $userId, $totalPrice]);
    $orderId = $pdo->lastInsertId();

    if (!$orderId) {
        throw new Exception("Failed to create order.");
    }

    $itemStmt = $pdo->prepare("
        INSERT INTO order_items (order_id, product_id, quantity, sub_total)
        VALUES (?, ?, ?, ?)
    ");

    foreach ($data as $item) {
        $itemStmt->execute([$orderId, $item['id'], $item['quantity'], $item['subTotal']]);
    }

    $pdo->commit();

    $response = [
        "id" => (int)$orderId,
        "orderNumber" => $orderNumber,
        "orderDate" => date("Y-m-d H:i:s"),
        "totalPrice" => $totalPrice,
        "products" => array_map(function($item) {
            return [
                "id" => $item['id'],
                "productName" => $item['name'] ?? "Unknown",
                "quantity" => $item['quantity'],
                "subTotal" => $item['subTotal']
            ];
        }, $data)
    ];

    echo json_encode($response);

} catch (Exception $e) {
    if ($pdo && $pdo->inTransaction()) {
        $pdo->rollBack();
    }

    http_response_code(500);
    echo json_encode([
        "error" => "Checkout failed!",
        "message" => $e->getMessage()
    ]);
}
