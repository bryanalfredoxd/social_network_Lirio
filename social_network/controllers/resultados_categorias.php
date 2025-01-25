<link rel="stylesheet" href="../public/css/post_users.css">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- Modal de comentario -->
<div class="modal" id="commentModal" tabindex="-1" aria-labelledby="commentModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="commentModalLabel">Agregar Comentario</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Título y Descripción del Proyecto -->
        <h5 class="titulodeproyecto" id="projectTitle"></h5>
        <p class="descripciondeproyecto" id="projectDescription"></p>

        <!-- Cuadro de Texto para Comentarios -->
        <textarea id="commentText" class="form-control" rows="3" placeholder="Escribe tu comentario..."></textarea>
      </div>
      <div class="modal-footer">
        
        <button type="button" id="submitComment" class="btn btn-primary">Comentar</button>
      </div>
    </div>
  </div>
</div>

<style>

    /* Botones generales */
.retweet-btn, .like-btn, .comment-btn, .comment-btn2 {
    background-color: transparent; /* Fondo transparente */
    color: black; /* Color del texto */
    border: none; /* Sin bordes visibles */
    border-radius: 20px; /* Bordes redondeados */
    padding: 5px 10px; /* Espaciado interno */
    font-size: 14px; /* Tamaño de fuente */
    transition: all 0.3s ease; /* Transición suave */
}

/* Estilo para el botón de retweet */
.retweet-btn:hover {
    background-color: rgba(0, 255, 0, 0.129); /* Fondo verde claro */
    border: none; /* Sin bordes */
    color: rgb(0, 255, 0); /* Texto verde */
}

.retweeted {
    color: rgb(0, 255, 0); /* Texto verde */
    background-color: rgba(0, 255, 0, 0.129); /* Fondo verde claro */
}

/* Estilo para los botones de "Me gusta" */
.like-btn:hover {
    background-color: rgba(255, 0, 0, 0.129); /* Fondo rojo claro */
    border: none; /* Sin bordes */
    color: rgb(255, 0, 0); /* Texto rojo */
}

.liked {
    color: rgb(255, 0, 0); /* Texto rojo */
    background-color: rgba(255, 0, 0, 0.129); /* Fondo rojo claro */
}

/* Estilo para los botones de comentarios */
.comment-btn:hover, .comment-btn2:hover {
    background-color: rgba(17, 0, 255, 0.129); /* Fondo azul claro */
    color: rgb(17, 0, 255); /* Texto azul */
    border: none; /* Sin bordes */
}

/* Alineación de los botones en una fila */
.d-flex {
    display: flex;
    justify-content: space-between;
    gap: 10px; /* Espaciado entre los botones */
    align-items: center;
}

.d-flex, .btn, .btn2 {
    flex: 1; /* Asegura que los botones ocupen un espacio equitativo */
}
</style>

<?php
    echo "<body>";

        include '../includes/partials/navbar.php';

        if (!isset($_SESSION)) {
            session_start();
        }

        if (!isset($_SESSION['id'])) {
            header("Location: ../index.html");
            exit;
        }

        $user_id = $_SESSION['id'];

        // Archivo de conexión
        include('../includes/config/database.php');

        // Obtener el ID de la categoría desde la URL
        $categoria_id = isset($_GET['categoria_id']) ? intval($_GET['categoria_id']) : null;

        // Validar si se recibió un ID de categoría
        if ($categoria_id === null) {
            echo "<p>Error: No se ha proporcionado una categoría válida.</p>";
            exit;
        }

        // Obtener el nombre de la categoría
$categoria_nombre = "";
$query_categoria = "SELECT nombre FROM categorias WHERE id = ?";
$stmt_categoria = $conn->prepare($query_categoria);
$stmt_categoria->bind_param("i", $categoria_id);
$stmt_categoria->execute();
$resultado_categoria = $stmt_categoria->get_result();
if ($resultado_categoria->num_rows > 0) {
    $categoria_nombre = $resultado_categoria->fetch_assoc()['nombre'];
} else {
    echo "<p>Error: La categoría no existe.</p>";
    exit;
}
$stmt_categoria->close();

// Mostrar el nombre de la categoría como título
echo "<h2 class='text-center my-4'>Categoría: " . htmlspecialchars($categoria_nombre) . "</h2>";


        // Consulta para obtener los proyectos filtrados por categoría
        $query = "
            SELECT 
                p.id, p.titulo, p.descripcion, p.fecha_publicacion, u.nombre, u.apellido, u.foto_perfil, 
                GROUP_CONCAT(DISTINCT a.archivo_url) AS archivos, 
                GROUP_CONCAT(DISTINCT i.imagen_url) AS imagenes, 
                AVG(v.valoracion) AS valoracion_promedio,
                GROUP_CONCAT(DISTINCT c.nombre) AS categorias,
                (SELECT COUNT(*) FROM retweets r WHERE r.proyecto_id = p.id) AS retweet_count,
                (SELECT COUNT(*) FROM retweets r WHERE r.proyecto_id = p.id AND r.usuario_id = $user_id) AS user_retweeted,
                (SELECT COUNT(*) FROM valoraciones v2 WHERE v2.proyecto_id = p.id AND v2.valoracion = 'Me gusta') AS like_count,
                (SELECT COUNT(*) FROM comentarios c2 WHERE c2.proyecto_id = p.id) AS comment_count,
                u.id AS usuario_id
            FROM proyectos p
            JOIN usuarios u ON p.usuario_id = u.id
            LEFT JOIN archivos_proyectos a ON p.id = a.proyecto_id
            LEFT JOIN imagenes_proyectos i ON p.id = i.proyecto_id
            LEFT JOIN valoraciones v ON p.id = v.proyecto_id
            LEFT JOIN proyectos_categorias pc ON p.id = pc.proyecto_id
            LEFT JOIN categorias c ON pc.categoria_id = c.id
            WHERE pc.categoria_id = ? -- Filtrar por ID de categoría
            GROUP BY p.id
            ORDER BY p.fecha_publicacion DESC";

        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $categoria_id);
        $stmt->execute();
        $resultado = $stmt->get_result();

        // Verificar si hay resultados
        if ($resultado->num_rows > 0) {
            while ($row = $resultado->fetch_assoc()) {

                

                // Generación dinámica de publicaciones
                echo "<div class='post card mb-3' onclick=\"window.location.href='../controllers/publicacion_detalle.php?post_id=" . $row['id'] . "'\" style='cursor: pointer;'>";
                echo "<div class='card-body'>";

                // Sección del usuario
                echo "<div class='align-items-center mb-2'>";
                echo "<a href='../pages/usuarios_perfil.php?usuario_id=" . $row['usuario_id'] . "'>";
                echo "<img src='" . ($row['foto_perfil'] ? $row['foto_perfil'] : 'default_profile.jpg') . "' alt='Foto de perfil' class='rounded-circle me-2' style='width: 40px; height: 40px;'>";
                echo "<span><strong>" . htmlspecialchars($row['nombre']) . " " . htmlspecialchars($row['apellido']) . "</strong></span>";
                echo "</a>";
                echo "</div>";

                // Título y descripción
                echo "<h5 class='card-title'><i class='bi bi-card-heading'></i> " . htmlspecialchars($row['titulo']) . "</h5>";
                echo "<p class='card-text'><i class='bi bi-text-left'></i> " . nl2br(htmlspecialchars($row['descripcion'])) . "</p>";
                echo "<p class='text-muted'><i class='bi bi-calendar'></i> Publicado el " . $row['fecha_publicacion'] . "</p>";

                // Categorías
                if ($row['categorias']) {
                    echo "<p><i class='bi bi-tags'></i> <strong>Categorías:</strong> " . htmlspecialchars($row['categorias']) . "</p>";
                }

                // Mostrar archivos
                if ($row['archivos']) {
                    echo "<h6><i class='bi bi-file-earmark'></i> Archivos:</h6>";
                    $archivos = explode(",", $row['archivos']);
                    foreach ($archivos as $archivo) {
                        echo "<a href='$archivo' target='_blank' class='btn btn-link'><i class='bi bi-download'></i> Ver archivo</a><br>";
                    }
                }

                // Mostrar imágenes
                if ($row['imagenes']) {
                    echo "<h6><i class='bi bi-image'></i> Imágenes:</h6>";
                    $imagenes = explode(",", $row['imagenes']);
                    foreach ($imagenes as $imagen) {
                        echo "<img src='$imagen' class='img-fluid mb-2' alt='Imagen del proyecto'><br>";
                    }
                }

                    echo "<p><i></i> <strong>_____________________________________________________________________________________</strong></p>";

                    // Botones de interacción (retweet, me gusta, comentarios)
                    echo "<div class='d-flex align-items-center'>";

                    // Verifica si el usuario ya ha retweeteado el post
                    $isRetweeted = $row['user_retweeted'] > 0 ? 'retweeted' : '';  // La clase 'retweeted' es para el color verde
                    $btnText = $row['user_retweeted'] > 0 ? '' : '';  // Texto dinámico

                    // Botón de retweet
                    echo "<button class='btn retweet-btn d-flex align-items-center $isRetweeted' data-user-id='$user_id' data-post-id='" . $row['id'] . "' onclick='event.stopPropagation()'>
                        <i class='bi bi-arrow-repeat me-1'></i> 
                        <span class='retweet-count'>" . $row['retweet_count'] . "</span>
                        <span class='retweet-text ms-1'>$btnText</span>
                    </button>";

                    // Lógica para verificar si el usuario ha dado "Me gusta"
                    $projectId = $row['id'];  // ID del proyecto
                    $userId = $user_id;  // ID del usuario (debería ser proporcionado dinámicamente)

                    $sql = "SELECT COUNT(*) AS like_count FROM valoraciones WHERE proyecto_id = ? AND usuario_id = ? AND valoracion = 'Me gusta'";
                    $stmt = $conn->prepare($sql);
                    $stmt->bind_param("ii", $projectId, $userId);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    $rowLike = $result->fetch_assoc();
                    $likeCount = $rowLike['like_count'];  // Número de "Me gusta" del proyecto
                    $hasLiked = $likeCount > 0;  // Si el usuario ya ha dado "Me gusta"

                    $likeButtonClass = $hasLiked ? 'liked' : '';  // Agregar clase 'liked' si el usuario ya dio "Me gusta"
                    $likeButtonText = $hasLiked ? '' : '';  // Texto dinámico para "Me gusta"

                    // Mostrar el botón de "Me gusta"
                    echo "<button class='btn like-btn d-flex align-items-center $likeButtonClass' data-user-id='$userId' data-post-id='$projectId' onclick='event.stopPropagation()'>
                        <i class='bi bi-heart me-1'></i> 
                        <span class='like-count'>" . $likeCount . "</span>
                        <span class='like-text ms-1'>$likeButtonText</span>
                    </button>";

                    // Lógica para obtener la cantidad de comentarios
                    $sql = "SELECT COUNT(*) AS comment_count FROM comentarios WHERE proyecto_id = ?";
                    $stmt = $conn->prepare($sql);
                    $stmt->bind_param("i", $projectId);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    $rowComment = $result->fetch_assoc();
                    $commentCount = $rowComment['comment_count'];  // Número de comentarios del proyecto

                    // Mostrar el botón de comentarios
                    echo "<button class='btn comment-btn2 d-flex align-items-center' data-post-id='$projectId' onclick='event.stopPropagation()'>
                        <i class='bi bi-chat-left-text me-1'></i> 
                        <span class='comment-count'>" . $commentCount . "</span>
                        <span class='comment-text ms-1'></span>
                    </button>";

                    echo "</div>"; // Cierra la fila de botones
                    echo "</div>"; // Cierra card-body


                    
                    echo "</div>"; // Cierra post card

                }
            } else {
                echo "<p class='text-center my-4'>No hay publicaciones.</p>";
            }

        $conn->close(); // Cierra la conexión
    echo "</body>";
?>

<!--En este archivo se maneja el proceso de hacer retweet-->
<script src="../public/js/retweet.js"></script>
<script src="../public/js/like.js"></script>
<script src="../public/js/comentario.js"></script>
