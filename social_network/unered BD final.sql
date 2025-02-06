-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-01-2025 a las 18:49:46
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
(6, 14, '../uploads/threads/docs/docsGrabación (7).m4a'),
(7, 17, '../uploads/threads/docs/docsvideo gerencia modulo IV.pdf'),
(8, 20, '../uploads/threads/docs/docsvideo gerencia modulo IV.pdf');

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
(79, 19, 6, 'prueba de funcionamiento', '2025-01-23 06:22:40'),
(80, 19, 6, 'otro comentario', '2025-01-23 06:23:50'),
(81, 19, 6, 'otro comentario', '2025-01-23 06:23:50'),
(82, 18, 6, 'a', '2025-01-23 13:24:52'),
(83, 18, 6, 'b', '2025-01-23 13:25:01'),
(84, 18, 6, 'enter\n\n\n', '2025-01-23 13:42:58'),
(85, 18, 6, 'enter\n\n\n', '2025-01-23 13:42:58'),
(86, 18, 6, 'enter\n\n\n', '2025-01-23 13:42:58'),
(87, 18, 6, 'comentario sin duplicar\n\n', '2025-01-23 13:46:46'),
(88, 18, 6, 'otra prueba', '2025-01-23 13:51:58'),
(89, 18, 6, 'oo', '2025-01-23 13:53:03'),
(90, 18, 6, 'as', '2025-01-23 13:53:08'),
(91, 19, 6, 'klk', '2025-01-23 14:14:54'),
(92, 19, 6, 'ggggggggggg', '2025-01-23 15:08:30'),
(93, 19, 6, 'mnmnmnmnm', '2025-01-23 15:59:26'),
(94, 19, 6, 'mnmmnmnmnmn\n', '2025-01-23 19:07:20'),
(95, 17, 6, 'visual\n', '2025-01-23 23:54:04'),
(96, 19, 6, 'vnvnvnvnvnv', '2025-01-24 00:29:01'),
(97, 19, 6, 'asmfsjdfjsfdsldjfsdkfjslkdjflksdjfs', '2025-01-24 00:33:25'),
(98, 19, 6, 'xcvxcvsdsdfasfsdf', '2025-01-24 00:37:35'),
(99, 19, 6, 'asdasda', '2025-01-24 00:37:47'),
(100, 19, 6, 'bbbbbbbbbbbbbbbb', '2025-01-24 00:41:02'),
(101, 19, 6, 'xc', '2025-01-24 00:41:13'),
(102, 19, 6, 'fghgfhf', '2025-01-24 00:41:27'),
(103, 19, 6, 'ccccccccccccc', '2025-01-24 00:49:02'),
(104, 19, 6, 'SADAS', '2025-01-24 00:49:51'),
(105, 19, 6, 'CCCCCCCCCCC', '2025-01-24 00:51:08'),
(106, 19, 6, 'dddddddddddd', '2025-01-24 00:51:45'),
(107, 19, 6, 'asda', '2025-01-24 00:51:59'),
(108, 19, 6, 'dfgdf', '2025-01-24 00:57:54'),
(109, 19, 6, 'asda', '2025-01-24 00:58:18'),
(110, 19, 6, 'fgfgfgfgdfg', '2025-01-24 00:58:35'),
(111, 19, 6, 'vvvvvvvv', '2025-01-24 00:58:58'),
(112, 19, 6, 'asd', '2025-01-24 00:59:22'),
(113, 19, 6, 'sdsdsd', '2025-01-24 00:59:36'),
(114, 19, 9, 'dsfsdf', '2025-01-24 01:28:28'),
(115, 19, 6, 'sda', '2025-01-24 01:30:39'),
(116, 20, 6, 'asda', '2025-01-24 02:11:55'),
(117, 20, 6, 'sdfs', '2025-01-24 02:19:55'),
(118, 23, 9, 'mm', '2025-01-24 16:57:51'),
(119, 20, 9, 'asdas', '2025-01-24 21:35:59'),
(120, 24, 9, 'f', '2025-01-24 21:57:06'),
(121, 24, 9, 'hola', '2025-01-24 22:18:25'),
(122, 24, 9, 'hol', '2025-01-24 22:53:28'),
(123, 18, 9, 'bd notificacion', '2025-01-25 04:06:03'),
(124, 21, 9, 'hola', '2025-01-25 04:09:13'),
(125, 25, 9, 'mm', '2025-01-25 04:10:47'),
(126, 21, 9, 'cdc', '2025-01-25 04:12:09'),
(127, 21, 9, 'sdf', '2025-01-25 04:12:20'),
(128, 26, 6, 'hola ', '2025-01-25 04:29:21'),
(129, 20, 9, 'vbcvbc', '2025-01-25 04:36:37'),
(130, 26, 6, 'gg', '2025-01-25 04:45:34'),
(131, 26, 6, 'sdfsdf', '2025-01-25 15:35:27'),
(132, 26, 10, 'hola k hace', '2025-01-25 15:40:11');

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
(1, 7, '../uploads/threads/imagesNiño Rata.jpg'),
(2, 8, '../uploads/threads/imagesainz3.jpg'),
(3, 10, '../uploads/threads/imagesLogo_CDC.png'),
(4, 11, '../uploads/threads/images/imagesIMG-20240607-WA0100.jpg'),
(5, 12, '../uploads/threads/images/imagesNiño Rata.jpg'),
(6, 13, '../uploads/threads/images/imagescentralcash.png'),
(7, 14, '../uploads/threads/images/imagesLirio XD.jpg'),
(8, 16, '../uploads/threads/images/imagesNiño Rata.jpg'),
(9, 17, '../uploads/threads/images/imagesvlcsnap-2024-05-01-20h58m06s915.png'),
(10, 18, '../uploads/threads/images/imagesManuel.jpg'),
(11, 19, '../uploads/threads/images/imagesFM.jpg'),
(12, 20, '../uploads/threads/images/imagesCaptura de pantalla 2024-03-31 210412.png'),
(13, 21, '../uploads/threads/images/imagesSin título.png'),
(14, 27, '../uploads/threads/images/imagesR.jpeg');

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
(13, 9, 'Comentario', 6, 26, 'El usuario Manuellll comentó en tu proyecto.', 1, '2025-01-25 04:45:34'),
(14, 9, 'Retweet', 6, 26, 'El usuario Manuellll dio Retweet a tu proyecto.', 1, '2025-01-25 15:35:23'),
(15, 9, 'Me gusta', 6, 26, 'El usuario Manuellll dio \"Me gusta\" a tu proyecto.', 1, '2025-01-25 15:35:24'),
(16, 9, 'Comentario', 6, 26, 'El usuario Manuellll comentó en tu proyecto.', 1, '2025-01-25 15:35:27'),
(17, 9, 'Retweet', 6, 25, 'El usuario Manuellll dio Retweet a tu proyecto.', 1, '2025-01-25 15:35:33'),
(18, 9, 'Retweet', 10, 26, 'El usuario Bryan dio Retweet a tu proyecto.', 1, '2025-01-25 15:39:47'),
(19, 9, 'Me gusta', 10, 26, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-01-25 15:39:48'),
(20, 9, 'Comentario', 10, 26, 'El usuario Bryan comentó en tu proyecto.', 1, '2025-01-25 15:40:11'),
(21, 10, 'Me gusta', 10, 27, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-01-25 15:44:46'),
(22, 9, 'Me gusta', 10, 25, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-01-25 15:44:47'),
(23, 9, 'Me gusta', 10, 23, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 1, '2025-01-25 15:44:49'),
(24, 6, 'Me gusta', 10, 21, 'El usuario Bryan dio \"Me gusta\" a tu proyecto.', 0, '2025-01-25 15:44:50'),
(25, 10, 'Retweet', 9, 27, 'El usuario liriooo dio Retweet a tu proyecto.', 1, '2025-01-25 17:48:01'),
(26, 10, 'Me gusta', 9, 27, 'El usuario liriooo dio \"Me gusta\" a tu proyecto.', 1, '2025-01-25 17:48:01');

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
(15, 9, 'lklklklkl', 'lklklkklklk', '2025-01-22 02:32:00'),
(16, 9, 'visualizacion', 'esperemos se vea bien ', '2025-01-22 21:07:19'),
(17, 9, ' otra prueba visualización', 'ajsdkasdkasd', '2025-01-22 21:33:30'),
(18, 6, 'Usuario de manuel', 'esperemos funcione', '2025-01-22 22:39:11'),
(19, 6, 'lklklklklklllklklk', 'hdsjfhsdjfhsjdhf', '2025-01-22 23:45:29'),
(20, 6, 'antiduplicado', 'esperemos que ya no se dupliquen', '2025-01-24 02:11:26'),
(21, 6, 'prueba de imagen', 'esperemos no se descuadre', '2025-01-24 02:23:45'),
(22, 9, 'asdasdasdasdfsdfczxx', 'zxczxczxasdzxz', '2025-01-24 03:31:19'),
(23, 9, 'movido', 'que funciona asi este movido', '2025-01-24 16:57:37'),
(24, 9, 'ggggggggggggggggg', 'gggggggggggggggg', '2025-01-24 21:36:30'),
(25, 9, 'buscador', 'funcional', '2025-01-25 03:00:32'),
(26, 9, 'navbar', 'navbar', '2025-01-25 03:27:00'),
(27, 10, 'purbliacion bryan', 'bryan', '2025-01-25 15:44:23');

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
(11, 15, 14),
(12, 16, 5),
(13, 17, 16),
(14, 18, 30),
(15, 19, 5),
(16, 20, 12),
(17, 21, 12),
(18, 22, 12),
(19, 23, 12),
(20, 24, 12),
(21, 25, 5),
(22, 26, 27),
(23, 27, 18);

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
(103, 6, 17, '2025-01-23 13:39:50'),
(116, 9, 19, '2025-01-24 01:26:42'),
(119, 6, 19, '2025-01-24 02:09:32'),
(120, 6, 20, '2025-01-24 02:11:47'),
(121, 9, 17, '2025-01-24 15:31:29'),
(122, 9, 20, '2025-01-24 21:36:02'),
(129, 9, 5, '2025-01-24 22:59:20'),
(134, 9, 24, '2025-01-25 01:45:34'),
(135, 9, 25, '2025-01-25 03:00:38'),
(136, 9, 21, '2025-01-25 03:53:35'),
(137, 9, 18, '2025-01-25 04:05:51'),
(139, 6, 26, '2025-01-25 15:35:23'),
(140, 6, 25, '2025-01-25 15:35:33'),
(141, 10, 26, '2025-01-25 15:39:47'),
(142, 9, 27, '2025-01-25 17:48:01');

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
(5, '', '', '', '', '../uploads/profiles/lirioselequedaapliciones@gmail.com.png', '', '', '2025-01-21 19:22:45'),
(6, 'Manuellll', 'Méndez', 'Ingeniería en Informática', 'II', '../uploads/profiles/manuel@gmail.com.jpg', 'manuel@gmail.com', '$2y$10$vfh9N0IbdxfpN7SvBLrLmuqJd4BEvGQ536UCn4sCHOKRWWet6qP7K', '2025-01-21 22:09:04'),
(7, 'exau', 'serrano', 'Ingeniería en Informática', 'VII', '../uploads/profiles/exau@gmail.com.png', 'exau@gmail.com', '$2y$10$eo87JQNaH2A1VTrEpxvuLe7.E.6fPUi45Fj2hIUPgRQT9DcB4qxw2', '2025-01-22 01:20:31'),
(8, 'lisandro', 'corro', 'Ingeniería en Informática', 'VIII', '../uploads/profiles/lisandro@gmail.com.jpg', 'lisandro@gmail.com', '$2y$10$hIVINuxusGzVnVW5yMgILOWbzdPYIBmPrcm9BJfygXrpQfZ2gpq5u', '2025-01-22 01:28:19'),
(9, 'liriooo', 'loca', 'Ingeniería en Informática', 'III', '../uploads/profiles/latipaesta@gmail.com.jpg', 'latipaesta@gmail.com', '$2y$10$tpslixlU1kzXBwES0BFnku1YiXiSL4WHdxypDEyu4NKlN6HW0WvDu', '2025-01-22 02:17:35'),
(10, 'Bryan', 'Moreno', 'Ingeniería en Informática', 'VIII', '../uploads/profiles/bryanalfredoxd@gmail.com.jpg', 'bryanalfredoxd@gmail.com', '$2y$10$KAvcPqM81BYkn808P5jaHeRWN9pJvwyEdr4vsmbwTCpWWHUhxRlGq', '2025-01-25 15:38:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_categorias`
--

CREATE TABLE `usuarios_categorias` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios_categorias`
--

INSERT INTO `usuarios_categorias` (`id`, `usuario_id`, `categoria_id`) VALUES
(4, 9, 2),
(5, 9, 3),
(6, 9, 5);

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
(33, 17, 6, 'Me gusta', '2025-01-23 13:38:48'),
(52, 19, 9, 'Me gusta', '2025-01-24 01:28:26'),
(62, 18, 6, 'Me gusta', '2025-01-24 02:10:00'),
(63, 15, 6, 'Me gusta', '2025-01-24 02:10:15'),
(64, 16, 6, 'Me gusta', '2025-01-24 02:10:17'),
(65, 20, 6, 'Me gusta', '2025-01-24 02:11:38'),
(67, 19, 6, 'Me gusta', '2025-01-24 02:13:15'),
(69, 20, 9, 'Me gusta', '2025-01-24 21:36:01'),
(75, 23, 9, 'Me gusta', '2025-01-24 22:21:35'),
(82, 5, 9, 'Me gusta', '2025-01-24 23:09:09'),
(89, 24, 6, 'Me gusta', '2025-01-25 00:22:04'),
(94, 24, 9, 'Me gusta', '2025-01-25 01:50:33'),
(97, 25, 9, 'Me gusta', '2025-01-25 03:00:36'),
(98, 21, 9, 'Me gusta', '2025-01-25 03:53:37'),
(100, 18, 9, 'Me gusta', '2025-01-25 04:05:09'),
(102, 26, 6, 'Me gusta', '2025-01-25 15:35:24'),
(103, 26, 10, 'Me gusta', '2025-01-25 15:39:48'),
(104, 27, 10, 'Me gusta', '2025-01-25 15:44:46'),
(105, 25, 10, 'Me gusta', '2025-01-25 15:44:47'),
(106, 23, 10, 'Me gusta', '2025-01-25 15:44:49'),
(107, 21, 10, 'Me gusta', '2025-01-25 15:44:50'),
(108, 27, 9, 'Me gusta', '2025-01-25 17:48:01');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT de la tabla `imagenes_proyectos`
--
ALTER TABLE `imagenes_proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `proyectos_categorias`
--
ALTER TABLE `proyectos_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `retweets`
--
ALTER TABLE `retweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- AUTO_INCREMENT de la tabla `seguidores_categorias`
--
ALTER TABLE `seguidores_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios_categorias`
--
ALTER TABLE `usuarios_categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `valoraciones`
--
ALTER TABLE `valoraciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

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
