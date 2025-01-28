<?php

include("../models/data_perfil.php");

$buttonSelected = 'posts';
if(isset($_POST["tab"]) && $_POST["tab"] == 'comments') $buttonSelected = 'comments';
if(isset($_POST["tab"]) && $_POST["tab"] == 'shared') $buttonSelected = 'shared';

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

    <style>

.notification-icon {
    position: relative;
    font-size: 24px;
}

.notification-icon .badge {
    position: absolute;
    top: -5px;
    right: -5px;
    padding: 0.3em 0.7em;
    font-size: 12px;
}


    </style>

</head>
<body>
    <script>
        if ( window.history.replaceState ) {
            window.history.replaceState( null, null, window.location.href );
        }
    </script>
    <!-- Barra lateral izquierda de navegación -->
    <?php include("../includes/partials/navbar.php"); 
            include("../models/number_notification.php");
    ?>

    <div class="container profile-container" style="margin-left: 100px;">
        <!-- Imagen de perfil (clicable para actualizar) -->
        <form action="" method="POST" enctype="multipart/form-data">
            <label for="new_profile_picture">
                <img src="<?php echo htmlspecialchars($foto_perfil); ?>" alt="Foto de perfil" class="profile-pic" style="cursor: pointer;">
            </label>
            <input type="file" id="new_profile_picture" name="new_profile_picture" style="display: none;" onchange="this.form.submit()">
        </form>

        
        <div class="profile-info">
            <h1><?php echo htmlspecialchars($nombre_usuario . ' ' . $apellido_usuario); ?></h1>
            <p><?php echo htmlspecialchars($correo_usuario); ?></p>
            <p class="user-bio">¡Hola! soy <?php echo htmlspecialchars($nombre_usuario); ?>, estudiante de <?php echo htmlspecialchars($carrera_usuario); ?>, semestre <?php echo htmlspecialchars($semestre_usuario); ?>. Bienvenid@ a mi perfil</p>

            <div class="profile-buttons">
                <!-- Botón para abrir la ventana modal de edición -->
                <button class="btn-custom" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                    <i class="bi bi-pencil-square btn-icon"></i>Editar perfil
                </button> 

                <!-- Botón de cierre de sesión -->
                <button class="btn-custom-sesion" onclick="location.href='../includes/config/logout.php'">
                    <i class="bi bi-box-arrow-right btn-icon"></i>Cerrar sesión
                </button>
                
                <!-- Icono de campana con notificaciones no leídas -->
                <a href="./notificaciones.php" class="notification-icon">
                    <i class="bi bi-bell"></i>
                    <?php if ($total_notificaciones > 0): ?>
                        <span class="badge bg-danger"><?php echo $total_notificaciones; ?></span>
                    <?php endif; ?>
                </a>
            </div>
        </div>
        <form method="POST" class="tabs">
            <button type="submit" name="tab" value="posts" class="btn <?php if($buttonSelected == 'posts') echo 'btn-warning text-white' ?> tab">Publicaciones</button>
            <button type="submit" name="tab" value="comments" class="btn <?php if($buttonSelected == 'comments') echo 'btn-warning text-white' ?> tab">Comentarios</button>
            <button type="submit" name="tab" value="shared" class="btn <?php if($buttonSelected == 'shared') echo 'btn-warning text-white' ?> tab">Compartidos</button>
        </form>

        <!-- Incluir los posts -->
        <?php
            if($buttonSelected == 'comments') {
                include_once("../models/comment_my_user.php");
            } elseif($buttonSelected == 'shared') {
                include_once("../models/post_shared.php");
            } else {
                include_once("../models/post_my_user.php");
            }
        ?>
    </div>

    <!-- Modal de Edición de Perfil -->
    <div style="color: black;" class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">Editar Perfil</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Formulario para editar los datos -->
                    <form action="" method="POST">
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" value="<?php echo htmlspecialchars($nombre_usuario); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="apellido" class="form-label">Apellido</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" value="<?php echo htmlspecialchars($apellido_usuario); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Correo Electrónico</label>
                            <input type="email" class="form-control" id="email" name="email" value="<?php echo htmlspecialchars($correo_usuario); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="contrasena" class="form-label">Nueva Contraseña</label>
                            <input type="password" class="form-control" id="contrasena" name="contrasena" value="<?php echo htmlspecialchars($contrasena_usuario); ?>">
                            <small class="form-text text-muted">Dejar en blanco si no desea cambiar la contraseña.</small>
                        </div>
                        <div class="mb-3">
                            <label for="carrera" class="form-label">Carrera</label>
                            <input type="text" class="form-control" id="carrera" name="carrera" value="<?php echo htmlspecialchars($carrera_usuario); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label for="semestre" class="form-label">Semestre</label>
                            <select class="form-control" id="semestre" name="semestre" required>
                                <option value="I" <?php echo ($semestre_usuario == 'I') ? 'selected' : ''; ?>>I</option>
                                <option value="II" <?php echo ($semestre_usuario == 'II') ? 'selected' : ''; ?>>II</option>
                                <option value="III" <?php echo ($semestre_usuario == 'III') ? 'selected' : ''; ?>>III</option>
                                <option value="IV" <?php echo ($semestre_usuario == 'IV') ? 'selected' : ''; ?>>IV</option>
                                <option value="V" <?php echo ($semestre_usuario == 'V') ? 'selected' : ''; ?>>V</option>
                                <option value="VI" <?php echo ($semestre_usuario == 'VI') ? 'selected' : ''; ?>>VI</option>
                                <option value="VII" <?php echo ($semestre_usuario == 'VII') ? 'selected' : ''; ?>>VII</option>
                                <option value="VIII" <?php echo ($semestre_usuario == 'VIII') ? 'selected' : ''; ?>>VIII</option>
                                <option value="IX" <?php echo ($semestre_usuario == 'IX') ? 'selected' : ''; ?>>IX</option>
                                <option value="X" <?php echo ($semestre_usuario == 'X') ? 'selected' : ''; ?>>X</option>
                            </select>
                        </div>

                        <button type="submit" name="update_profile" class="btn btn-primary">Guardar cambios</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>