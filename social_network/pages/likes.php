<?php include("../includes/config/verificacion.php"); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Página Principal">
    <title>Reacciones</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    /* Cambios responsive */
@media (max-width: 767.5px)  {
    .navbar {
        top: auto;
        bottom: 0; /* Mueve el navbar a la parte inferior */
        left: 0;
        height: 70px; /* Reduce la altura del navbar */
        width: 100%; /* Ocupa todo el ancho de la pantalla */
        flex-direction: row !important; /* Cambia a una fila horizontal */
        justify-content: space-around; /* Espaciado uniforme entre ítems */
        align-items: center;
        padding: 0;
    }

    .navbar-nav {
        width: 100%;
        padding: 0;
        margin: 0;
        list-style: none;
        display: flex;
        flex-direction: row !important;
    }
    .main-content {
        margin-left: 0 !important; /* Elimina el margen en móviles */
        margin-bottom: 80px !important; /* Espacio para la barra en la parte inferior */
    }

    .nav-item {
        margin: 0; /* Elimina márgenes extra */
    }

    .nav-link {
        font-size: 1.8rem; /* Íconos ligeramente más pequeños en móviles */
    }
}

</style>
<body>
    
    

    <?php include("../models/like_post.php"); ?>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

