<?php
class Database {
    private $host = "localhost";
    private $db_name = "flowershop_db";
    private $username = "root";
    private $password = "";
    public $conn;

    public function connect() {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host={$this->host};dbname={$this->db_name}",
                $this->username,
                $this->password
            );
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            http_response_code(500);
            echo json_encode([
                "message" => "Database connection failed!",
                "error" => $e->getMessage()
            ]);
            exit;
        }
        return $this->conn;
    }
}
