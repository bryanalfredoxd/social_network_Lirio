<?php
// Incluir el archivo que maneja la conexión a la base de datos
include("../models/data_perfil.php");

// Verificar si el usuario está accediendo a un perfil específico
if (isset($_GET['usuario_id'])) {
    $usuario_id = $_GET['usuario_id'];

    // Consultar la base de datos para obtener los datos del usuario
    $query = "SELECT * FROM usuarios WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $usuario_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        // Almacenar los datos del usuario en variables
        $nombre_usuario = $user['nombre'];
        $apellido_usuario = $user['apellido'];
        $correo_usuario = $user['email'];
        $foto_perfil = $user['foto_perfil'] ? $user['foto_perfil'] : 'default_profile.jpg';
        $carrera_usuario = $user['carrera'];
        $semestre_usuario = $user['semestre'];
    } else {
        // Si no se encuentra el usuario
        echo "Usuario no encontrado.";
        exit;
    }
} else {
    // Si no se pasa un usuario_id
    echo "No se ha seleccionado un usuario.";
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Perfil de Usuario">
    <title>Perfil de Usuario</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../public/css/perfil.css">
</head>
<body>
    <!-- Barra lateral izquierda de navegación -->
    <?php include("../includes/partials/navbar.php"); ?>

    <div class="container profile-container" style="margin-left: 100px;">
        <!-- Imagen de perfil -->
        <img src="<?php echo htmlspecialchars($foto_perfil); ?>" alt="Foto de perfil" class="profile-pic">

        <div class="profile-info">
            <h1><?php echo htmlspecialchars($nombre_usuario . ' ' . $apellido_usuario); ?></h1>
            <p><?php echo htmlspecialchars($correo_usuario); ?></p>
            <p class="user-bio">¡Hola! soy <?php echo htmlspecialchars($nombre_usuario); ?>, estudiante de <?php echo htmlspecialchars($carrera_usuario); ?>, semestre <?php echo htmlspecialchars($semestre_usuario); ?>. Bienvenid@ a mi perfil</p>
        </div>
        <div class="tabs">
            <div class="tab">Publicaciones</div>
            <div class="tab">Comentarios</div>
            <div class="tab">Compartidos</div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
