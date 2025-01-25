<?php

require '../includes/config/database.php';

// Verifica que el usuario ha iniciado sesión correctamente
if (!isset($_SESSION["nombre_usuario"])) {
    header("Location: login.php");
    exit();
}

// Obtén los datos del usuario
$email_usuario = $_SESSION["nombre_usuario"];
$query = "SELECT nombre, apellido, foto_perfil FROM usuarios WHERE email = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("s", $email_usuario);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if (!$user) {
    die("Error: No se encontraron datos de usuario.");
}

// Asignar los datos del usuario a las variables
$nombre_completo = $user['nombre'] . ' ' . $user['apellido'];
$foto_perfil_path = !empty($user['foto_perfil']) ? $user['foto_perfil'] : '../public/images/profile-default.png';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <!-- Bootstrap CSS -->
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .profile-header {
            border-top: 2px solid #ddd;
            border-bottom: 2px solid #ddd;
            padding: 10px 0;
            margin-bottom: 20px;
        }
        .profile-picture {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        .post-box {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
        }
        .post-list .post-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Encabezado del perfil -->
        <div class="row justify-content-center">
            <div class="col-md-8 text-center profile-header">
                <img src="<?php echo htmlspecialchars($foto_perfil_path); ?>" alt="Foto de perfil" class="profile-picture">
                <span class="h5 ms-2"><?php echo htmlspecialchars($nombre_completo); ?></span>
            </div>
        </div>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Publicaciones de Proyectos</h1>

        <!-- Incluir los posts -->
        <?php include("../models/post_users.php"); ?>

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
