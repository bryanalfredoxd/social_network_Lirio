<?php
// Inicia la sesión
session_start();

// Verifica si el usuario ha iniciado sesión, de lo contrario, redirige a la página de inicio de sesión
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("Location: login.html");
    exit;
}

// Incluye el archivo de configuración de la base de datos
require_once '../includes/config/database.php';

// Obtiene el nombre de usuario de la sesión
$nombre_usuario = $_SESSION["nombre_usuario"];
?>