<?php

// Allow CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Database connection
$host = 'localhost';
$dbname = 'users';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    // Return 500 Internal Server Error if database connection fails
    http_response_code(500);
    die("Database connection failed: " . $e->getMessage());
}

// Login process
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve form data
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Check if the username exists
    $stmt = $pdo->prepare("SELECT * FROM signup WHERE username = :username");
    $stmt->execute(['username' => $username]);
    $user = $stmt->fetch();

    if ($user) {
        // Username exists, check password
        if (password_verify($password, $user['password'])) {
            // Password is correct, login successful
            http_response_code(200); // OK
            echo "Login successful!";
        } else {
            // Password is incorrect
            http_response_code(401); // Unauthorized
            echo "Incorrect password!";
        }
    } else {
        // Username does not exist
        http_response_code(404); // Not Found
        echo "Username not found!";
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    // Respond to preflight requests
    header("HTTP/1.1 200 OK");
    exit;
}
