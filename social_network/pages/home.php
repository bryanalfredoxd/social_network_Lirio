<?php include("../includes/config/verificacion.php"); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Página Principal">
    <title>Página Principal</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    

    <link rel="stylesheet" href="../public/css/home.css">

</head>
<body>
    
    <?php include("../includes/partials/navbar.php"); ?>

    <div class="container mt-5" style="margin-left: 80px;">
        <div class="jumbotron">
            <!-- Mostrar nombre completo -->
            <h1 class="display-4">¡Bienvenido, <?php echo htmlspecialchars($nombre_completo); ?>!</h1>
        </div>
    </div>

    <!-- Bootstrap JS (opcional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

