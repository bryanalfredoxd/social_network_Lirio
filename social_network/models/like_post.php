<link rel="stylesheet" href="../public/css/post_users.css">
<link rel="stylesheet" href="../public/css/likes.css">

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

<div class='container d-flex align-items-start justify-content-center py-4 w-100'>
<?php

echo "<div class='postLikes card p-4'>";

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

// Consulta para obtener únicamente los proyectos a los que el usuario les ha dado "Me gusta"
$query = "SELECT p.id, p.titulo, p.descripcion, p.fecha_publicacion, u.nombre, u.apellido, u.foto_perfil, 
    GROUP_CONCAT(DISTINCT a.archivo_url) AS archivos, 
    GROUP_CONCAT(DISTINCT i.imagen_url) AS imagenes, 
    AVG(v.valoracion) AS valoracion_promedio,
    GROUP_CONCAT(DISTINCT c.nombre) AS categorias,
    (SELECT COUNT(*) FROM retweets r WHERE r.proyecto_id = p.id) AS retweet_count,
    (SELECT COUNT(*) FROM retweets r WHERE r.proyecto_id = p.id AND r.usuario_id = $user_id) AS user_retweeted,
    (SELECT COUNT(*) FROM valoraciones v2 WHERE v2.proyecto_id = p.id AND v2.valoracion = 'Me gusta') AS like_count,
    (SELECT COUNT(*) FROM comentarios c2 WHERE c2.proyecto_id = p.id) AS comment_count,
    u.id AS usuario_id
FROM valoraciones v
JOIN proyectos p ON v.proyecto_id = p.id
JOIN usuarios u ON p.usuario_id = u.id
LEFT JOIN archivos_proyectos a ON p.id = a.proyecto_id
LEFT JOIN imagenes_proyectos i ON p.id = i.proyecto_id
LEFT JOIN proyectos_categorias pc ON p.id = pc.proyecto_id
LEFT JOIN categorias c ON pc.categoria_id = c.id
WHERE v.usuario_id = ? AND v.valoracion = 'Me gusta'
GROUP BY p.id
ORDER BY p.fecha_publicacion DESC";

$stmt = $conn->prepare($query);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$resultado = $stmt->get_result();

// Verificar si hay resultados
if ($resultado->num_rows > 0) {
    while ($row = $resultado->fetch_assoc()) {
        // Generación dinámica de publicaciones (igual que antes)
        echo "<div class='post card mb-3' onclick=\"window.location.href='../controllers/publicacion_detalle.php?post_id=" . $row['id'] . "'\" style='cursor: pointer;'>";
        echo "<div class='card-body'>";

        echo "<div class='align-items-center mb-2 postProfileCard'>";
        echo "<a href='../pages/usuarios_perfil.php?usuario_id=" . $row['usuario_id'] . "'>";
        echo "<img src='" . ($row['foto_perfil'] ? $row['foto_perfil'] : 'default_profile.jpg') . "' alt='Foto de perfil' class='rounded-circle me-2' style='width: 40px; height: 40px;'>";
        echo "<span><strong>" . htmlspecialchars($row['nombre']) . " " . htmlspecialchars($row['apellido']) . "</strong></span>";
        echo "</a>";
        echo "</div>";

        echo "<h5 class='card-title'><i class='bi bi-card-heading'></i> " . htmlspecialchars($row['titulo']) . "</h5>";
        echo "<p class='card-text'><i class='bi bi-text-left'></i> " . nl2br(htmlspecialchars($row['descripcion'])) . "</p>";
        echo "<p><i class='bi bi-calendar'></i> Publicado el " . $row['fecha_publicacion'] . "</p>";

        if ($row['categorias']) {
            echo "<p><i class='bi bi-tags'></i> <strong>Categorías:</strong> " . htmlspecialchars($row['categorias']) . "</p>";
        }

        if ($row['archivos']) {
            echo "<h6><i class='bi bi-file-earmark'></i> Archivos:</h6>";
            $archivos = explode(",", $row['archivos']);
            foreach ($archivos as $archivo) {
                echo "<a href='$archivo' target='_blank' class='postFileButton'><i class='bi bi-download'></i> Ver archivo</a><br>";
            }
        }

        if ($row['imagenes']) {
            echo "<h6><i class='bi bi-image'></i> Imágenes:</h6>";
            $imagenes = explode(",", $row['imagenes']);
            foreach ($imagenes as $imagen) {
                echo "<img src='$imagen' class='img-fluid mb-2' alt='Imagen del proyecto'><br>";
            }
        }
                    // Botones de interacción (retweet, me gusta, comentarios)
                    echo "<div class='d-flex align-items-center postActionButtonsContainer'>";

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
                echo "<p>No hay publicaciones.</p>";
            }

        $conn->close(); // Cierra la conexión
    echo "</div>";
?>
</div>

<!--En este archivo se maneja el proceso de hacer retweet-->
<script src="../public/js/retweet.js"></script>
<script src="../public/js/like.js"></script>
<script src="../public/js/comentario.js"></script>
