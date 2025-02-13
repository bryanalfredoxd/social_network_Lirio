-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-02-2025 a las 02:09:06
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

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
(1, 56, '../uploads/threads/docs/docsCurrículum Bryan Moreno.pdf'),
(4, 57, '../uploads/threads/docs/docsCurrículum Bryan Moreno.pdf');

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
(1, 57, 22, 'hola', '2025-02-12 15:26:09'),
(2, 57, 21, 'sdf', '2025-02-12 17:46:51');

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
(1, 56, '../uploads/threads/images/imagesperfil.jpg'),
(7, 57, '../uploads/threads/images/images108713185_p0.jpg');

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
(1, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 15:23:23'),
(2, 21, 'Retweet', 21, 57, 'El usuario Bryan dio Retweet a tu proyecto.', 1, '2025-02-12 15:23:38'),
(3, 21, 'Me gusta', 22, 57, 'El usuario Lirio dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 15:25:37'),
(4, 21, 'Retweet', 22, 57, 'El usuario Lirio dio Retweet a tu proyecto.', 1, '2025-02-12 15:26:01'),
(5, 21, 'Comentario', 22, 57, 'El usuario Lirio comentó en tu proyecto.', 1, '2025-02-12 15:26:09'),
(6, 21, 'Me gusta', 22, 57, 'El usuario Lirio dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:01:59'),
(7, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:02:28'),
(8, 21, 'Retweet', 21, 57, 'El usuario Bryan dio Retweet a tu proyecto.', 1, '2025-02-12 16:26:39'),
(9, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:26:41'),
(10, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:30:27'),
(11, 21, 'Retweet', 21, 57, 'El usuario Bryan dio Retweet a tu proyecto.', 1, '2025-02-12 16:30:31'),
(12, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:40:35'),
(13, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:41:36'),
(14, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:47:05'),
(15, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:50:58'),
(16, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 16:51:25'),
(17, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 17:29:08'),
(18, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-02-12 17:29:50'),
(19, 20, 'Retweet', 21, 56, 'El usuario Bryan compartió tu proyecto.', 0, '2025-02-12 17:40:08'),
(20, 21, 'Retweet', 21, 57, 'El usuario Bryan compartió tu proyecto.', 1, '2025-02-12 17:40:24'),
(21, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 0, '2025-02-12 17:43:26'),
(22, 21, 'Retweet', 21, 57, 'El usuario Bryan compartió tu proyecto.', 0, '2025-02-12 17:44:46'),
(23, 21, 'Comentario', 21, 57, 'El usuario Bryan comentó en tu proyecto.', 0, '2025-02-12 17:46:51'),
(24, 21, 'Me gusta', 21, 57, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 0, '2025-02-12 18:07:13');

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
(56, 20, 'asd', 'asd', '2025-02-06 01:28:10'),
(57, 21, 'Holasssss', 'ghfg', '2025-02-12 15:22:32');

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
(1, 56, 3),
(11, 57, 10);

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
(2, 22, 57, '2025-02-12 15:26:01'),
(5, 21, 56, '2025-02-12 17:40:08'),
(7, 21, 57, '2025-02-12 17:44:46');

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
        CONCAT('El usuario ', (SELECT nombre FROM usuarios WHERE id = NEW.usuario_id), ' compartió tu proyecto.'), -- Mensaje
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
  `codigo_recuperacion` varchar(255) DEFAULT NULL,
  `fecha_expiracion_codigo` datetime DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `carrera`, `semestre`, `foto_perfil`, `email`, `contrasena`, `codigo_recuperacion`, `fecha_expiracion_codigo`, `fecha_registro`) VALUES
(20, 'exau', 'serrano', 'Ingeniería en Informática', 'I', '../uploads/profiles/exau@gmail.com.png', 'exau@gmail.com', '$2y$10$dSfJhnVJ/.90lYDjHWSgKux411e9yr4dqjaVybGv4zWY5DXmWxzZ2', NULL, NULL, '2025-02-06 01:27:37'),
(21, 'Bryan', 'Moreno', 'Ingeniería en Informática', 'IX', '../uploads/profiles/bryanalfredoxd@gmail.com.jpg', 'bryanalfredoxd@gmail.com', '$2y$10$ydy8NI1nBqIrmZuUf.ThYe1OCdM5T4hFfo1GPcvfSqhYZMgAnX2r2', NULL, NULL, '2025-02-12 14:28:03'),
(22, 'Lirio', 'Perez', 'Ingeniería en Informática', 'IX', '../uploads/profiles/lirioselequedaapliciones@gmail.com.jpg', 'lirioselequedaapliciones@gmail.com', '$2y$10$p2T0Guvoit5sG2n.MyDBmexkbCY9SVfCuPYV2IMsUiLsx3JbNskB2', NULL, NULL, '2025-02-12 15:24:51');

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
(3, 57, 22, 'Me gusta', '2025-02-12 16:01:59'),
(15, 57, 21, 'Me gusta', '2025-02-12 18:07:13');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `imagenes_proyectos`
--
ALTER TABLE `imagenes_proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `proyectos_categorias`
--
ALTER TABLE `proyectos_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `retweets`
--
ALTER TABLE `retweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `seguidores_categorias`
--
ALTER TABLE `seguidores_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `usuarios_categorias`
--
ALTER TABLE `usuarios_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
