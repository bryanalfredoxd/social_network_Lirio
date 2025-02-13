-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-02-2025 a las 09:36:21
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `unered`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_proyectos`
--

CREATE TABLE `archivos_proyectos` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `archivo_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `archivos_proyectos`
--

INSERT INTO `archivos_proyectos` (`id`, `proyecto_id`, `archivo_url`) VALUES
(1, 2, '../uploads/threads/docs/docsmedicina documento.pdf.crdownload'),
(2, 3, '../uploads/threads/docs/docsProyecto redes y comunicaciones II.docx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(2, 'Agronomía y Ciencias del Agro'),
(12, 'Arte y Diseño'),
(25, 'Astronomía y Ciencias Espaciales'),
(5, 'Ciencias de la Salud'),
(21, 'Conservación de Recursos Naturales'),
(11, 'Cultura y Patrimonio Local'),
(22, 'Deportes y Recreación'),
(17, 'Derecho y Ciencias Jurídicas'),
(13, 'Desarrollo Comunitario'),
(1, 'Desarrollo de Software'),
(8, 'Economía y Finanzas'),
(6, 'Educación y Formación Docente'),
(20, 'Emprendimiento Estudiantil'),
(9, 'Energías Renovables'),
(28, 'Estudios Sociales y Políticos'),
(3, 'Gestión Ambiental'),
(4, 'Ingeniería Civil'),
(18, 'Ingeniería en Sistemas'),
(7, 'Investigación Científica'),
(27, 'Literatura y Escritura Creativa'),
(29, 'Marketing Digital para Proyectos Estudiantiles'),
(15, 'Producción Agroindustrial'),
(26, 'Producción Audiovisual y Fotografía'),
(24, 'Proyectos de Vinculación Social'),
(19, 'Proyectos Innovadores para el Campo'),
(10, 'Proyectos Sociales'),
(23, 'Psicología y Bienestar'),
(30, 'Sistemas Hidráulicos y Gestión del Agua'),
(16, 'Tecnología de los Alimentos'),
(14, 'Turismo Sostenible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colaboradores`
--

CREATE TABLE `colaboradores` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha_comentario` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id`, `proyecto_id`, `usuario_id`, `comentario`, `fecha_comentario`) VALUES
(1, 1, 1, 'Yo asistiré.', '2025-02-06 07:59:44'),
(2, 4, 4, 'Muy interesante', '2025-02-06 08:30:27'),
(3, 2, 4, 'Iré ', '2025-02-06 08:31:26'),
(4, 4, 1, 'Creo que es bastante peculiar.', '2025-02-06 08:32:24');

--
-- Disparadores `comentarios`
--
DELIMITER $$
CREATE TRIGGER `after_comment` AFTER INSERT ON `comentarios` FOR EACH ROW BEGIN
    INSERT INTO notificaciones (usuario_id, accion, origen_usuario_id, proyecto_id, mensaje, leido)
    VALUES (
        (SELECT usuario_id FROM proyectos WHERE id = NEW.proyecto_id), -- Receptor (dueño del proyecto)
        'Comentario', -- Acción
        NEW.usuario_id, -- Emisor (usuario que comenta)
        NEW.proyecto_id, -- Proyecto relacionado
        CONCAT('El usuario ', (SELECT nombre FROM usuarios WHERE id = NEW.usuario_id), ' comentó en tu proyecto.'), -- Mensaje
        0 -- Notificación no leída
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes_proyectos`
--

CREATE TABLE `imagenes_proyectos` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `imagen_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `imagenes_proyectos`
--

INSERT INTO `imagenes_proyectos` (`id`, `proyecto_id`, `imagen_url`) VALUES
(1, 1, '../uploads/threads/images/imagesgerencia y m.jpg'),
(2, 2, '../uploads/threads/images/imagesmedicina.jpg'),
(3, 3, '../uploads/threads/images/imagesredes.avif'),
(4, 4, '../uploads/threads/images/imagesvrigen.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` enum('Retweet','Me gusta','Comentario') NOT NULL,
  `origen_usuario_id` int(11) NOT NULL,
  `proyecto_id` int(11) DEFAULT NULL,
  `mensaje` text NOT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha_notificacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id`, `usuario_id`, `accion`, `origen_usuario_id`, `proyecto_id`, `mensaje`, `leido`, `fecha_notificacion`) VALUES
(1, 1, 'Retweet', 1, 1, 'El usuario Abdiel dio Retweet a tu proyecto.', 1, '2025-02-06 07:59:16'),
(2, 1, 'Me gusta', 1, 1, 'El usuario Abdiel dio \"Me gusta\" a tu proyecto.', 1, '2025-02-06 07:59:18'),
(3, 1, 'Comentario', 1, 1, 'El usuario Abdiel comentó en tu proyecto.', 1, '2025-02-06 07:59:44'),
(4, 2, 'Retweet', 2, 2, 'El usuario Lirio dio Retweet a tu proyecto.', 0, '2025-02-06 08:18:24'),
(5, 4, 'Retweet', 4, 4, 'El usuario Bryant dio Retweet a tu proyecto.', 0, '2025-02-06 08:29:52'),
(6, 4, 'Me gusta', 4, 4, 'El usuario Bryant dio \"Me gusta\" a tu proyecto.', 0, '2025-02-06 08:29:56'),
(7, 4, 'Comentario', 4, 4, 'El usuario Bryant comentó en tu proyecto.', 0, '2025-02-06 08:30:27'),
(8, 2, 'Me gusta', 4, 2, 'El usuario Bryant dio \"Me gusta\" a tu proyecto.', 0, '2025-02-06 08:30:42'),
(9, 2, 'Comentario', 4, 2, 'El usuario Bryant comentó en tu proyecto.', 0, '2025-02-06 08:31:26'),
(10, 4, 'Retweet', 1, 4, 'El usuario Abdiel dio Retweet a tu proyecto.', 0, '2025-02-06 08:31:57'),
(11, 4, 'Comentario', 1, 4, 'El usuario Abdiel comentó en tu proyecto.', 0, '2025-02-06 08:32:24'),
(12, 4, 'Me gusta', 1, 4, 'El usuario Abdiel dio \"Me gusta\" a tu proyecto.', 0, '2025-02-06 08:32:29'),
(13, 2, 'Me gusta', 1, 2, 'El usuario Abdiel dio \"Me gusta\" a tu proyecto.', 0, '2025-02-06 08:32:37'),
(14, 3, 'Me gusta', 1, 3, 'El usuario Abdiel dio \"Me gusta\" a tu proyecto.', 0, '2025-02-06 08:32:38'),
(15, 2, 'Retweet', 1, 2, 'El usuario Abdiel dio Retweet a tu proyecto.', 0, '2025-02-06 08:32:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id`, `usuario_id`, `titulo`, `descripcion`, `fecha_publicacion`) VALUES
(1, 1, '!Te invitamos a nuestro Tercer ciclo de ponencias!', 'Los estudiantes de la carrera Ingeneria Informatica te invitamos a que asistas a nuestro tercer ciclo de ponencias', '2025-02-06 07:59:06'),
(2, 2, 'Seminario sobre las ramas de la medicina', 'En este seminario se verán las ramas de medicina y su importancia para cada área.', '2025-02-06 08:18:14'),
(3, 3, 'MEJORA Y DISEÑO DE NUEVA ARQUITECTURA DE RED PARA EL AREA DE VICERECTORADO ACADEMICO DE LA UNELLEZ BARINAS', 'El área de vicerrectorado académico de la Unellez Barinas tiene un diseño de arquitectura que ha prevalecido igual durante años, lo cual, a falta de mantenimiento reorganización y atención a posibles mejoras puede terminar en fallas cotidianas, poca escalabilidad, y presenta serias deficiencias en su infraestructura de red que afectan la eficiencia y efectividad de las actividades académicas y administrativas.', '2025-02-06 08:25:00'),
(4, 4, 'La Devoción Llanera: El Encierro de la Virgen del Pilar en Barina', 'En el corazón del llano venezolano, Barinas celebra con fervor una de sus tradiciones más representativas: el encierro de la Virgen del Pilar. Esta festividad, que data de generaciones pasadas, es una mezcla de fe, cultura y tradición que moviliza a toda la comunidad. Cada año, cientos de devotos, vestidos con atuendos típicos llaneros, se congregan para acompañar la imagen en una procesión que recorre caminos polvorientos, bajo el ardiente sol de los llanos. A caballo, en carretas o a pie, los fieles avanzan al ritmo de rezos y cánticos, mientras el repique de campanas anuncia la solemnidad del evento. Durante el recorrido, la imagen es custodiada con respeto, mientras la música tradicional llanera—el arpa, el cuatro y las maracas—le imprimen un carácter festivo y emotivo a la celebración. Es un momento de conexión entre lo terrenal y lo divino, donde la fe trasciende lo religioso para convertirse en un pilar de la identidad barinesa.', '2025-02-06 08:29:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos_categorias`
--

CREATE TABLE `proyectos_categorias` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos_categorias`
--

INSERT INTO `proyectos_categorias` (`id`, `proyecto_id`, `categoria_id`) VALUES
(1, 1, 18),
(2, 2, 5),
(3, 3, 7),
(4, 4, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retweets`
--

CREATE TABLE `retweets` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `fecha_retweet` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `retweets`
--

INSERT INTO `retweets` (`id`, `usuario_id`, `proyecto_id`, `fecha_retweet`) VALUES
(1, 1, 1, '2025-02-06 07:59:16'),
(3, 4, 4, '2025-02-06 08:29:52'),
(4, 1, 4, '2025-02-06 08:31:57'),
(5, 1, 2, '2025-02-06 08:32:43');

--
-- Disparadores `retweets`
--
DELIMITER $$
CREATE TRIGGER `after_retweet` AFTER INSERT ON `retweets` FOR EACH ROW BEGIN
    INSERT INTO notificaciones (usuario_id, accion, origen_usuario_id, proyecto_id, mensaje, leido)
    VALUES (
        (SELECT usuario_id FROM proyectos WHERE id = NEW.proyecto_id), -- Receptor (dueño del proyecto)
        'Retweet', -- Acción
        NEW.usuario_id, -- Emisor (usuario que realiza el retweet)
        NEW.proyecto_id, -- Proyecto relacionado
        CONCAT('El usuario ', (SELECT nombre FROM usuarios WHERE id = NEW.usuario_id), ' dio Retweet a tu proyecto.'), -- Mensaje
        0 -- Notificación no leída
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguidores_categorias`
--

CREATE TABLE `seguidores_categorias` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `carrera` varchar(100) NOT NULL,
  `semestre` varchar(10) NOT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `carrera`, `semestre`, `foto_perfil`, `email`, `contrasena`, `fecha_registro`) VALUES
(1, 'Abdiel', 'Asad', 'Ingeniería en Informática', 'VIII', '../uploads/profiles/abdiel12052003@gmail.com.jpg', 'abdiel12052003@gmail.com', '$2y$10$zNakDDQzJ2DcuZCMs2pZ7e807Xq3mi359wd8uJK4cjLTApkuoaCAq', '2025-02-06 07:55:02'),
(2, 'Lirio', 'Pérez', 'Ingeniería en Informática', 'VIII', '../uploads/profiles/liriodanely020903@gmail.com.jpg', 'liriodanely020903@gmail.com', '$2y$10$pSnYPAhJOqRn3c8NUI8SyeU8F5JkVUX3UPEFE5aDyS2P.B3nOrZp2', '2025-02-06 08:10:07'),
(3, 'Beiker', 'Daza', 'Ingeniería en Informática', 'VIII', '../uploads/profiles/beiker.eduardo@gmail.com.jpg', 'beiker.eduardo@gmail.com', '$2y$10$Gfy58ndt9S20Xj.2v5j8lOvaBb83R/PH8yN4tODNwqNSwCpOUQLYa', '2025-02-06 08:19:49'),
(4, 'Bryant', 'Roa', 'Ingeniería en Informática', 'VIII', '../uploads/profiles/bryant123@gmailcom.jpg', 'bryant123@gmailcom', '$2y$10$IA24vPlM.WfYDmFekxNDu.FuvLMLE.wITnyz7l5WzVwj1KhISQBYC', '2025-02-06 08:26:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_categorias`
--

CREATE TABLE `usuarios_categorias` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoraciones`
--

CREATE TABLE `valoraciones` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `valoracion` enum('Me gusta','No me gusta') NOT NULL,
  `fecha_valoracion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valoraciones`
--

INSERT INTO `valoraciones` (`id`, `proyecto_id`, `usuario_id`, `valoracion`, `fecha_valoracion`) VALUES
(1, 1, 1, 'Me gusta', '2025-02-06 07:59:18'),
(2, 4, 4, 'Me gusta', '2025-02-06 08:29:56'),
(3, 2, 4, 'Me gusta', '2025-02-06 08:30:42'),
(4, 4, 1, 'Me gusta', '2025-02-06 08:32:29'),
(5, 2, 1, 'Me gusta', '2025-02-06 08:32:37'),
(6, 3, 1, 'Me gusta', '2025-02-06 08:32:38');

--
-- Disparadores `valoraciones`
--
DELIMITER $$
CREATE TRIGGER `after_like` AFTER INSERT ON `valoraciones` FOR EACH ROW BEGIN
    INSERT INTO notificaciones (usuario_id, accion, origen_usuario_id, proyecto_id, mensaje, leido)
    VALUES (
        (SELECT usuario_id FROM proyectos WHERE id = NEW.proyecto_id), -- Receptor (dueño del proyecto)
        'Me gusta', -- Acción
        NEW.usuario_id, -- Emisor (usuario que da "Me gusta")
        NEW.proyecto_id, -- Proyecto relacionado
        CONCAT('El usuario ', (SELECT nombre FROM usuarios WHERE id = NEW.usuario_id), ' dio "Me gusta" a tu proyecto.'), -- Mensaje
        0 -- Notificación no leída
    );
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `archivos_proyectos`
--
ALTER TABLE `archivos_proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `imagenes_proyectos`
--
ALTER TABLE `imagenes_proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `origen_usuario_id` (`origen_usuario_id`),
  ADD KEY `proyecto_id` (`proyecto_id`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `proyectos_categorias`
--
ALTER TABLE `proyectos_categorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `retweets`
--
ALTER TABLE `retweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `proyecto_id` (`proyecto_id`);

--
-- Indices de la tabla `seguidores_categorias`
--
ALTER TABLE `seguidores_categorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `usuarios_categorias`
--
ALTER TABLE `usuarios_categorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `archivos_proyectos`
--
ALTER TABLE `archivos_proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `imagenes_proyectos`
--
ALTER TABLE `imagenes_proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `proyectos_categorias`
--
ALTER TABLE `proyectos_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `retweets`
--
ALTER TABLE `retweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `seguidores_categorias`
--
ALTER TABLE `seguidores_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios_categorias`
--
ALTER TABLE `usuarios_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivos_proyectos`
--
ALTER TABLE `archivos_proyectos`
  ADD CONSTRAINT `archivos_proyectos_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`);

--
-- Filtros para la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD CONSTRAINT `colaboradores_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `colaboradores_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `imagenes_proyectos`
--
ALTER TABLE `imagenes_proyectos`
  ADD CONSTRAINT `imagenes_proyectos_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `notificaciones_ibfk_2` FOREIGN KEY (`origen_usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `notificaciones_ibfk_3` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`);

--
-- Filtros para la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD CONSTRAINT `proyectos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `proyectos_categorias`
--
ALTER TABLE `proyectos_categorias`
  ADD CONSTRAINT `proyectos_categorias_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `proyectos_categorias_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `retweets`
--
ALTER TABLE `retweets`
  ADD CONSTRAINT `retweets_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `retweets_ibfk_2` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `seguidores_categorias`
--
ALTER TABLE `seguidores_categorias`
  ADD CONSTRAINT `seguidores_categorias_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `seguidores_categorias_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `usuarios_categorias`
--
ALTER TABLE `usuarios_categorias`
  ADD CONSTRAINT `usuarios_categorias_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `usuarios_categorias_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  ADD CONSTRAINT `valoraciones_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`),
  ADD CONSTRAINT `valoraciones_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
