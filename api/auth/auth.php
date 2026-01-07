<?php

$token = $_SERVER['HTTP_X_ROLE'] ?? '';
$auth = validateToken($token);

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
