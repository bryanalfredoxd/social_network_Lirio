-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-01-2025 a las 04:31:27
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
(1, 7, '../uploads/threads/docsunered.sql'),
(2, 8, '../uploads/threads/docsvideo gerencia modulo IV.pdf'),
(3, 10, '../uploads/threads/docsredes.xcf'),
(4, 12, '../uploads/threads/docs/docsunered.sql'),
(5, 13, '../uploads/threads/docs/docsver_transaciones_empleado.php'),
(6, 14, '../uploads/threads/docs/docsGrabación (7).m4a');

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
(1, 7, '../uploads/threads/imagesNiño Rata.jpg'),
(2, 8, '../uploads/threads/imagesainz3.jpg'),
(3, 10, '../uploads/threads/imagesLogo_CDC.png'),
(4, 11, '../uploads/threads/images/imagesIMG-20240607-WA0100.jpg'),
(5, 12, '../uploads/threads/images/imagesNiño Rata.jpg'),
(6, 13, '../uploads/threads/images/imagescentralcash.png'),
(7, 14, '../uploads/threads/images/imagesLirio XD.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha_notificacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(5, 5, 'prueba', 'asdas', '2025-01-22 00:50:13'),
(6, 5, 'prueba n2', 'dasdasdasda', '2025-01-22 00:51:08'),
(7, 5, 'esperemos funciona', 'jaskdashdkjashda', '2025-01-22 00:53:49'),
(8, 5, 'otra prueba de funcionamiento', 'ajshdjahsdj', '2025-01-22 00:55:32'),
(9, 5, 'xcxcxc', 'xcxcxc', '2025-01-22 01:01:51'),
(10, 5, 'xcvxczxcs', 'sdfsdfs', '2025-01-22 01:06:25'),
(11, 5, 'asdasdasdasda', 'asdasdasdasdas', '2025-01-22 01:07:24'),
(12, 5, 'Ahora si funciona', 'ya funciona esta porqueria', '2025-01-22 01:09:07'),
(13, 5, 'sssssssssssssssssssssssss', 'sssssssssssssssssssssssss', '2025-01-22 01:11:44'),
(14, 9, 'jakjdajskdj', 'kajsdkajskdas', '2025-01-22 02:20:58'),
(15, 9, 'lklklklkl', 'lklklkklklk', '2025-01-22 02:32:00');

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
(1, 5, 2),
(2, 6, 1),
(3, 7, 15),
(4, 8, 25),
(5, 9, 12),
(6, 10, 12),
(7, 11, 25),
(8, 12, 7),
(9, 13, 25),
(10, 14, 6),
(11, 15, 14);

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
  `intereses` text DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `carrera`, `semestre`, `intereses`, `foto_perfil`, `email`, `contrasena`, `fecha_registro`) VALUES
(2, 'Bryan', 'Moreno', 'Ingeniería en Informática', 'IX', '', '../uploads/profiles/bryanalfredoxd@gmail.com.jpg', 'bryanalfredoxd@gmail.com', '', '2025-01-21 16:45:17'),
(5, '', '', '', '', NULL, '../uploads/profiles/lirioselequedaapliciones@gmail.com.png', '', '', '2025-01-21 19:22:45'),
(6, 'Manuel', 'Méndez', 'Ingeniería en Informática', 'VI', NULL, '../public/images/profile-default.png', 'manuel@gmail.com', '$2y$10$vfh9N0IbdxfpN7SvBLrLmuqJd4BEvGQ536UCn4sCHOKRWWet6qP7K', '2025-01-21 22:09:04'),
(7, 'exau', 'serrano', 'Ingeniería en Informática', 'VII', NULL, '../uploads/profiles/exau@gmail.com.png', 'exau@gmail.com', '$2y$10$eo87JQNaH2A1VTrEpxvuLe7.E.6fPUi45Fj2hIUPgRQT9DcB4qxw2', '2025-01-22 01:20:31'),
(8, 'lisandro', 'corro', 'Ingeniería en Informática', 'VIII', NULL, '../uploads/profiles/lisandro@gmail.com.jpg', 'lisandro@gmail.com', '$2y$10$hIVINuxusGzVnVW5yMgILOWbzdPYIBmPrcm9BJfygXrpQfZ2gpq5u', '2025-01-22 01:28:19'),
(9, 'lirio', 'loca', 'Ingeniería en Informática', 'V', '', '../uploads/profiles/latipaesta@gmail.com.jpg', 'latipaesta@gmail.com', '$2y$10$tpslixlU1kzXBwES0BFnku1YiXiSL4WHdxypDEyu4NKlN6HW0WvDu', '2025-01-22 02:17:35');

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
  ADD KEY `usuario_id` (`usuario_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `imagenes_proyectos`
--
ALTER TABLE `imagenes_proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `proyectos_categorias`
--
ALTER TABLE `proyectos_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `seguidores_categorias`
--
ALTER TABLE `seguidores_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

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
-- Filtros para la tabla `seguidores_categorias`
--
ALTER TABLE `seguidores_categorias`
  ADD CONSTRAINT `seguidores_categorias_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `seguidores_categorias_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);

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
