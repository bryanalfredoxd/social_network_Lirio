<?php

    session_start();
    require '../includes/config/database.php';

    // Obtiene el nombre de usuario de la sesión
    $nombre_usuario = $_SESSION["nombre_usuario"];

    // Se puede agregar la obtención de datos adicionales del usuario desde la base de datos si es necesario
    $query = "SELECT correo, foto_perfil FROM usuarios WHERE nombre_usuario = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $nombre_usuario); // "s" indica que el parámetro es una cadena
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    // Se asegura de que el usuario exista
    if (!$user) {
        header("location: ../index.html");
        exit;
    }

    $correo_usuario = $user['correo']; 
    $foto_perfil = !empty($user['foto_perfil']) ? $user['foto_perfil'] : 'profile-default.jpg'; // Valor por defecto si no tiene foto
    $foto_perfil_path = '../uploads/profiles/' . $nombre_usuario . '.jpg'; // Ruta de la imagen de perfil

    // Verifica si la imagen de perfil existe, si no, usa la imagen por defecto
    if (!file_exists($foto_perfil_path)) {
        $foto_perfil_path = '../uploads/profiles/profile-default.jpg';
    }

?>