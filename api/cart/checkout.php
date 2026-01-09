<?php
header("Access-Control-Allow-Origin: http://localhost:5173");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: X-Role, Content-Type");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once "../../config/database.php";

$token = $_SERVER['HTTP_X_ROLE'] ?? '';
$auth = validateToken($token);

if (!$auth) {
    http_response_code(401);
    echo json_encode(["error" => "Unauthorized"]);
    exit;
}

if ($auth['role'] !== "ROLE_CUSTOMER") {
    http_response_code(403);
    echo json_encode(["error" => "Only customers can place orders."]);
    exit;
}

$userId = $auth['userId'];

$data = json_decode(file_get_contents("php://input"), true);
if (!$data || !is_array($data) || count($data) === 0) {
    http_response_code(400);
    echo json_encode(["error" => "Cart is empty!"]);
    exit;
}

try {
    $db = new Database();
    $pdo = $db->connect();
    $pdo->beginTransaction();

    $totalPrice = 0;
    foreach ($data as $item) {
        if (!isset($item['id'], $item['quantity'], $item['totalPrice'])) {
            throw new Exception("Invalid cart item structure: " . json_encode($item));
        }
        $totalPrice += $item['totalPrice'];
    }

    $orderNumber = "ORD-" . time();
    $stmt = $pdo->prepare("INSERT INTO orders (order_number, user_id, total_price) VALUES (?, ?, ?)");
    $stmt->execute([$orderNumber, $userId, $totalPrice]);
    $orderId = $pdo->lastInsertId();

    $itemStmt = $pdo->prepare("INSERT INTO order_items (order_id, product_id, quantity, sub_total) VALUES (?, ?, ?, ?)");
    foreach ($data as $item) {
        $itemStmt->execute([$orderId, $item['id'], $item['quantity'], $item['totalPrice']]);
    }

    $pdo->commit();

    echo json_encode([
        "id" => $orderId,
        "orderNumber" => $orderNumber,
        "orderDate" => date("Y-m-d H:i:s"),
        "totalPrice" => $totalPrice,
        "products" => $data
    ]);

} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo json_encode([
        "error" => "Checkout failed!",
        "message" => $e->getMessage()
    ]);
}

function validateToken($token) {
    if ($token === "ROLE_CUSTOMER") {
        return [
            "userId" => 1,
            "role" => "ROLE_CUSTOMER"
        ];
    } elseif ($token === "ROLE_ADMIN") {
        return [
            "userId" => 2,
            "role" => "ROLE_ADMIN"
        ];
    }
    return false;
}
