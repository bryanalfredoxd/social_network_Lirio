<?php include("../models/data_perfil.php");?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Perfil de Usuario">
    <title>Perfil de Usuario</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../public/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="../public/css/perfil.css">
</head>
<body>
    <!-- Barra lateral izquierda de navegacion -->
<?php include("../includes/partials/navbar.php"); ?>

    <div class="container profile-container" style="margin-left: 100px;">
        <img src="<?php echo htmlspecialchars($foto_perfil_path); ?>" alt="Foto de perfil" class="profile-pic">
        <div class="profile-info">
            <h1><?php echo htmlspecialchars($nombre_usuario); ?></h1>
            <p><?php echo htmlspecialchars($correo_usuario); ?></p>
            <p class="user-bio">¡Hola! soy el/la usuario/a <?php echo htmlspecialchars($nombre_usuario); ?>. Bienvenid@ a mi perfil</p>
            <div class="profile-buttons">
                <button class="btn-custom">
                    <i class="bi bi-pencil-square btn-icon"></i>Editar perfil
                </button> 
                <button class="btn-custom-sesion" onclick="location.href='../includes/config/logout.php'"> <!-- Boton de cierre de sesion -->
                    <i class="bi bi-box-arrow-right btn-icon"></i>Cerrar sesión
                </button>
            </div>
        </div>
        <div class="tabs">
            <div class="tab">Publicaciones</div>
            <div class="tab">Comentarios</div>
            <div class="tab">Compartidos</div>
        </div>
    </div>

    <!-- Bootstrap JS (opcional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../public/js/main.js"></script>
</body>
</html>
