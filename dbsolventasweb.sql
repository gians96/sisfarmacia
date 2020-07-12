-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 04-04-2018 a las 10:50:47
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbsolventasweb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `idunidad_medida` int(11) NOT NULL,
  `nombre` varchar(50) CHARACTER SET latin1 NOT NULL,
  `descripcion` text CHARACTER SET latin1,
  `unidad` int(5) NOT NULL,
  `idforma_farmaceutica` int(11) NOT NULL,
  `idpresentacion` int(11) NOT NULL,
  `idcondicion_almacenamiento` int(11) NOT NULL,
  `idlaboratorio` int(11) NOT NULL,
  `imagen` varchar(150) NOT NULL,
  `estado` char(1) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `idunidad_medida`, `nombre`, `descripcion`, `unidad`, `idforma_farmaceutica`, `idpresentacion`, `idcondicion_almacenamiento`, `idlaboratorio`, `imagen`, `estado`) VALUES
(4561, 18, 1, 'Amoxidal', 'Antibiotico', 0, 1, 2, 2, 10, '', 'A'),
(4562, 2, 1, 'Impresora Epson', 'Impresora Epson', 0, 0, 0, 0, 11, '', 'A'),
(4563, 18, 1, 'Asdasddasd', 'asd', 0, 4, 2, 3, 12, '', 'A'),
(4564, 17, 2, 'Paracetamol', 'CABEAZAASDASD', 0, 3, 2, 2, 13, '', 'A'),
(4565, 18, 8, 'PANADOL', 'CASI IGUAL', 100, 0, 0, 0, 13, '', 'A'),
(4566, 18, 1, 'NUEVO ARITUCLO LAB', 'DESCRIPCION NUEVO ARTICULO LABORATRIO', 1, 0, 0, 0, 10, '', 'A'),
(4567, 18, 1, 'Alcohool', 'ALcohool sopropi', 3, 0, 0, 0, 16, '', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `estado`) VALUES
(2, 'Impresoras', 'A'),
(17, 'Proyectores', 'A'),
(18, 'Farmaco', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condicion_almacenamiento`
--

CREATE TABLE `condicion_almacenamiento` (
  `idcondicion_almacenamiento` mediumint(9) NOT NULL,
  `descripcion` varchar(20) NOT NULL,
  `abreviacion` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `condicion_almacenamiento`
--

INSERT INTO `condicion_almacenamiento` (`idcondicion_almacenamiento`, `descripcion`, `abreviacion`) VALUES
(1, 'Temperatura Ambiente', 'TA'),
(2, 'Temperatura Controla', 'TC'),
(3, 'Producto Refrigerado', 'PR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credito`
--

CREATE TABLE `credito` (
  `idcredito` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `fecha_pago` date NOT NULL,
  `total_pago` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_documento_sucursal`
--

CREATE TABLE `detalle_documento_sucursal` (
  `iddetalle_documento_sucursal` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idtipo_documento` int(11) NOT NULL,
  `ultima_serie` varchar(7) NOT NULL,
  `ultimo_numero` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_documento_sucursal`
--

INSERT INTO `detalle_documento_sucursal` (`iddetalle_documento_sucursal`, `idsucursal`, `idtipo_documento`, `ultima_serie`, `ultimo_numero`) VALUES
(1, 1, 3, '001', '000027'),
(2, 1, 6, '001', '0002'),
(3, 1, 7, '001', '0002'),
(4, 1, 9, '001', '00002');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `serie` varchar(50) NOT NULL,
  `descripcion` varchar(1024) DEFAULT NULL,
  `stock_ingreso` int(11) NOT NULL,
  `stock_actual` int(11) NOT NULL,
  `stock_unidad` int(11) NOT NULL,
  `precio_compra` decimal(8,2) NOT NULL,
  `precio_ventadistribuidor` decimal(8,2) NOT NULL,
  `precio_ventapublico` decimal(8,2) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `idforma_farmaceutica` int(11) NOT NULL,
  `idpresentacion` int(11) NOT NULL,
  `idcondicion_almacenamiento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_movimiento_stock`
--

CREATE TABLE `detalle_movimiento_stock` (
  `idmovimiento` int(11) DEFAULT NULL,
  `iddetalle_movimiento` int(11) NOT NULL,
  `iddetalle_ingreso` int(11) DEFAULT NULL,
  `stockact_antes` int(11) DEFAULT NULL,
  `stockact_despues` int(11) DEFAULT NULL,
  `ventapublico_antes` decimal(8,2) NOT NULL,
  `ventapublico_despues` decimal(8,2) NOT NULL,
  `stockuni_antes` int(11) NOT NULL,
  `stockuni_despues` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `iddetalle_pedido` int(11) NOT NULL,
  `idpedido` int(11) NOT NULL,
  `iddetalle_ingreso` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(8,2) NOT NULL,
  `descuento` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idempleado` int(11) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(70) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `foto` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `clave` varchar(32) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idempleado`, `apellidos`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `fecha_nacimiento`, `foto`, `login`, `clave`, `estado`) VALUES
(1, 'Arias Bonifacio', 'Gianmar', 'DNI', '76251607', 'Lima - Los Olivos -Av.  Universitaria', '954030965', 'gians96@gmail.com', '1996-04-09', 'Files/Empleado/carlos.jpg', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'S'),
(3, 'cruz', 'Ivan', 'DNI', '48771577', 'Iquitos 1345', '987459344', 'ivancruz@incanatoit.com', '2016-12-02', 'Files/Empleado/ivan.jpg', 'cruz', '202cb962ac59075b964b07152d234b70', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `forma_farmaceutica`
--

CREATE TABLE `forma_farmaceutica` (
  `idforma_farmaceutica` int(11) NOT NULL,
  `descripcion` varchar(20) NOT NULL,
  `abreviacion` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `forma_farmaceutica`
--

INSERT INTO `forma_farmaceutica` (`idforma_farmaceutica`, `descripcion`, `abreviacion`) VALUES
(1, 'Tableta', 'Tb'),
(3, 'Pastilla', 'Pst'),
(4, 'Capsula', 'Cap');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `global`
--

CREATE TABLE `global` (
  `idglobal` int(11) NOT NULL,
  `empresa` varchar(100) NOT NULL,
  `nombre_impuesto` varchar(5) NOT NULL,
  `porcentaje_impuesto` decimal(5,2) NOT NULL,
  `simbolo_moneda` varchar(5) NOT NULL,
  `logo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `global`
--

INSERT INTO `global` (`idglobal`, `empresa`, `nombre_impuesto`, `porcentaje_impuesto`, `simbolo_moneda`, `logo`) VALUES
(1, 'Farmacia Rezola S.A.C', 'IGV', '18.00', 'S/', 'Files/Global/mem.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idlaboratorio` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha` date NOT NULL,
  `impuesto` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento_stock`
--

CREATE TABLE `movimiento_stock` (
  `idmovimiento` int(11) NOT NULL,
  `idingreso` int(11) DEFAULT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  `observacion` varchar(1024) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `estado` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `idpedido` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `tipo_pedido` varchar(20) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numero` int(11) DEFAULT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tipo_documento` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `num_documento` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `direccion_departamento` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `direccion_provincia` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `direccion_distrito` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `direccion_calle` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `telefono` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `numero_cuenta` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `estado` char(1) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion_departamento`, `direccion_provincia`, `direccion_distrito`, `direccion_calle`, `telefono`, `email`, `numero_cuenta`, `estado`) VALUES
(1, 'Proveedor', 'Importaciones Santa Ana S.A.C.', 'NIC', '12581369852', 'Lambayeque', 'Chiclayo', 'Chiclayo', 'Chiclayo', '257896', 'carlos@gmail.com', '305871596336', 'A'),
(2, 'Cliente', 'CLIENTE COMUN', 'DNI', '12465789', 'LIMA', 'CAÃ‘ETE', 'SAN VICENTE DE CAÃ‘ETE', 'SN', 'SN', 'SN', '', 'A'),
(3, 'Proveedor', 'Inversiones Nuevo Leon S.A.C.', 'RUC', '2', 'Mexico', 'Guadalajara', 'Jalisco', 'Nuevo leon 1351', '9874565889', 'nuevomexico@gmail.com', '678646546546546548', 'A'),
(14, 'Laboratorio', '(NINGUNO)', 'RUC', '00000000000', '', '', '', '', '', '', '', 'C'),
(16, 'Laboratorio', '***', 'RUC', 'NA', '', '', '', '0', '5239629__3945092', '', '', 'A'),
(17, 'Laboratorio', 'ABBOTT LABORATORIOS S.A', 'RUC', 'NA', '', '', '', 'AV.BRASIL 2730-PUEBLO LIBRE LIMA 21', '4614791', '', '', 'A'),
(18, 'Laboratorio', 'ABL PHARMA INTERNACIONAL', 'RUC', 'NA', '', '', '', 'MARCO ARAMBURU 366 MAGDALENA DEL MAR', '610204', '', '', 'A'),
(19, 'Laboratorio', 'AC FARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(20, 'Laboratorio', 'ADROFA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(21, 'Laboratorio', 'AJANTA PHARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(22, 'Laboratorio', 'AKORN OPHTHALMICS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(23, 'Laboratorio', 'ALEMBIC CHEMICAL WORKS CO.LTDA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(24, 'Laboratorio', 'LABORATORIO ALFA S.A.', 'RUC', 'NA', '', '', '', 'CARLOS VILLARAN 508,3ER PISO.STA.CATALIN', '705252FAX 705220', '', '', 'A'),
(25, 'Laboratorio', 'ALFA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(26, 'Laboratorio', 'ALGOTEC S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(27, 'Laboratorio', 'ALLERGAN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(28, 'Laboratorio', 'ALMOL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(29, 'Laboratorio', 'CORPORACION ALM S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(30, 'Laboratorio', 'ALTANA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(31, 'Laboratorio', 'ANA FRANCIA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(32, 'Laboratorio', 'ANDREU', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(33, 'Laboratorio', 'SAN ANTONIO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(34, 'Laboratorio', 'AJANTA PHARMA LIMITED', 'RUC', 'NA', '', '', '', 'AV.PRODUCCION NACIONAL 100 CHORILL.LIMA', '232634', '', '', 'A'),
(35, 'Laboratorio', 'APOTEX', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(36, 'Laboratorio', 'APOYO A PROGRAMAS DE POBLACION', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(37, 'Laboratorio', 'APROPO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(38, 'Laboratorio', 'AQATEC PHARMA S.A.C.', 'RUC', 'NA', '', '', '', 'AV.PRESCOTT 463  SAN ISIDRO', '0', '', '', 'A'),
(39, 'Laboratorio', 'NORDIC PHARMACEUTICAL COMPANY', 'RUC', 'NA', '', '', '', 'JR.LARRABURE UNANUE 188 0F.31 LIMA PERU', '(511) 4248182', '', '', 'A'),
(40, 'Laboratorio', 'AQUARIUS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(41, 'Laboratorio', 'ARBO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(42, 'Laboratorio', 'ARTICULOS PARA BEBE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(43, 'Laboratorio', 'ARENS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(44, 'Laboratorio', 'ARFAL S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(45, 'Laboratorio', 'ARION MASON', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(46, 'Laboratorio', 'LAB ARK FARMACEUTICAS SAC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(47, 'Laboratorio', 'ARTICULOS DE TOCADOR', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(48, 'Laboratorio', 'ASTRAL PHARMACEUTICAL SAC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(49, 'Laboratorio', 'ASTRAZENECA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(50, 'Laboratorio', 'A.S. SURGICAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(51, 'Laboratorio', 'LABORATORIO ATRAL S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(52, 'Laboratorio', 'REPRESENTACIONES ATM E.I.R.L.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(53, 'Laboratorio', 'ATRAL-CIPAN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(54, 'Laboratorio', 'AUDIO-VISUAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(55, 'Laboratorio', 'AVENTIS PHARMA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(56, 'Laboratorio', 'AVENE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(57, 'Laboratorio', 'AVSA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(58, 'Laboratorio', 'LAB AXXSYSS S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(59, 'Laboratorio', 'LABORATORIO BAGO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(60, 'Laboratorio', 'BAUSCH & LOMB', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(61, 'Laboratorio', 'BAYER PERU S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(62, 'Laboratorio', 'DROGUERIA BBICOSA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(63, 'Laboratorio', 'LAB BECTON DICKINSON', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(64, 'Laboratorio', 'BEIERSDORF S A PERU', 'RUC', 'NA', '', '', '', 'AV CARLOS IZAGUIRRE 126 LIMA 28', '0', '', '', 'A'),
(65, 'Laboratorio', 'BD-PERU', 'RUC', 'NA', '', '', '', 'C.IND.LAS PRACERAS DE LURIN CALLE KONTIK', '0', '', '', 'A'),
(66, 'Laboratorio', 'BEIERSDORF S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(67, 'Laboratorio', 'BELUSA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(68, 'Laboratorio', 'BERNA', 'RUC', 'NA', '', '', '', 'PSJE.LOS NEGOCIOS #163 SURQUILLO', '410999', '', '', 'A'),
(69, 'Laboratorio', 'BESTPHARMA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(70, 'Laboratorio', 'LABORATORIO BIOS PERU S.A.C.', 'RUC', 'NA', '', '', '', 'AV.LA UNIVERSIDAD 1810 LA MOLINA', '368-1915', '', '', 'A'),
(71, 'Laboratorio', 'BIOBASAL S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(72, 'Laboratorio', 'BIODERMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(73, 'Laboratorio', 'BIOPAS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(74, 'Laboratorio', 'BIORGA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(75, 'Laboratorio', 'BIO REG PHARMA SRL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(76, 'Laboratorio', 'BIOS PERU S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(77, 'Laboratorio', 'BIOS PERU S. A. C.', 'RUC', 'NA', '', '', '', 'AV. LA UNIVERSIDAD 1810 OF.14 URB SAUCE', '3681915', '', '', 'A'),
(78, 'Laboratorio', 'BIOTOSCANA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(79, 'Laboratorio', 'ABEEFE-BRISTOL MYER SQUIBB', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(80, 'Laboratorio', 'BOERHINGER INGELHEIM', 'RUC', 'NA', '', '', '', 'JAVIER PRADO OESTE 640 SAN ISIDRO.LIMA27,404718', '401120', '', '', 'A'),
(81, 'Laboratorio', 'BOEH.INGEL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(82, 'Laboratorio', 'BOLIVAR FARMA S.R.LTDA.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(83, 'Laboratorio', 'BOLIVAR FARMA SRL', 'RUC', 'NA', '', '', '', '4412015', '0', '', '', 'A'),
(84, 'Laboratorio', 'B. BRAUN PERUANA S.A.', 'RUC', 'NA', '', '', '', '0', '3261825', '', '', 'A'),
(85, 'Laboratorio', 'CHAMPU AMMEN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(86, 'Laboratorio', 'BRITANIA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(87, 'Laboratorio', 'BRIFARMA S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(88, 'Laboratorio', 'BRISAFARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(89, 'Laboratorio', 'BRUGUERA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(90, 'Laboratorio', 'BAUSCH & LOMB', 'RUC', 'NA', '', '', '', 'CURAZAO 647 LIMA 12 BEEP.499499 AB.4740', 'TELEFAX 358227', '', '', 'A'),
(91, 'Laboratorio', 'LABORATORIO CAMSA', 'RUC', 'NA', '', '', '', 'URB.30 DE AGOSTO MZ. LT.11 LIMA 35', '0', '', '', 'A'),
(92, 'Laboratorio', 'CARRION S.A. LABORATORIOS', 'RUC', 'NA', '', '', '', 'SERGIO BERNALES #595 SURQUILLO', '31-0541--46-9329', '', '', 'A'),
(93, 'Laboratorio', 'CARDIO PERFUS EIRL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(94, 'Laboratorio', 'CATALYSIS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(95, 'Laboratorio', 'LABORATORIO CAVIAL S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(96, 'Laboratorio', 'LINEA CCIAL CHINA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(97, 'Laboratorio', 'CELSIUS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(98, 'Laboratorio', 'CORPORACION FARMACEUTICA BRIFA', 'RUC', 'NA', '', '', '', 'AV.ROBLES 249-CALLAO', '5681375', '', '', 'A'),
(99, 'Laboratorio', 'CHALVER', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(100, 'Laboratorio', 'CHESTON', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(101, 'Laboratorio', 'CHEMNOVA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(102, 'Laboratorio', 'CHICCO S.A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(103, 'Laboratorio', 'CHENICALS NOVA S.A.C.', 'RUC', 'NA', '', '', '', '', '', '', '', 'A'),
(104, 'Laboratorio', 'CONSORCIO INDUSTRIAL AREQUIPA', 'RUC', 'NA', '', '', '', 'JR.TACNA 751 MAGDALENA', '2630844-2631089', '', '', 'A'),
(105, 'Laboratorio', 'CIBA VISION', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(106, 'Laboratorio', 'CIFARMA S.A.', 'RUC', 'NA', '', '', '', 'CARRET.CENTRAL KM 3 N?1315-STA ANITA', '0', '', '', 'A'),
(107, 'Laboratorio', 'CYNTIA EVELYN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(108, 'Laboratorio', 'CINFA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(109, 'Laboratorio', 'CIPA S.A.', 'RUC', 'NA', '', '', '', 'JR.RODRIGUEZ DE MENDOZA 135 PUEBLO LIBRE', '631212 FAX AN 50', '', '', 'A'),
(110, 'Laboratorio', 'CIPLA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(111, 'Laboratorio', 'ALGODON CKF', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(112, 'Laboratorio', 'CLARIS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(113, 'Laboratorio', 'BRISTOL COSMETICA CLEIROL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(114, 'Laboratorio', 'CONSORCIO CONFIANZA S.A.C.', 'RUC', 'NA', '', '', '', 'AV.AREQUIPA 4446 MIRAFLORES LIMA', '4445521', '', '', 'A'),
(115, 'Laboratorio', 'CODEPLAM', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(116, 'Laboratorio', 'COFANA S.A', 'RUC', 'NA', '', '', '', 'SAN JOSE #150 PUEBLO LIBRE', '461-8987-62-1796', '', '', 'A'),
(117, 'Laboratorio', 'CORPORACION FARMACEUT.GABBLAN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(118, 'Laboratorio', 'COLLIERE S.A.', 'RUC', 'NA', '', '', '', 'AV.BOLIVAR #2636 LIMA 100', '63-01-01', '', '', 'A'),
(119, 'Laboratorio', 'CORPORACION MEDCO S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(120, 'Laboratorio', 'COMIESA DRUC S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(121, 'Laboratorio', 'CONTINENTAL S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(122, 'Laboratorio', 'CORFARMA LABORATORIOS S.A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(123, 'Laboratorio', 'CORNATURE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(124, 'Laboratorio', 'COSMETICOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(125, 'Laboratorio', 'CIRUGIA PERUANA COSMETICOS.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(126, 'Laboratorio', 'CREVANI', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(127, 'Laboratorio', 'CRESPAL DEL PERU', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(128, 'Laboratorio', 'CRISTALIA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(129, 'Laboratorio', 'CORPORACION DE REPRESEN.S.A.', 'RUC', 'NA', '', '', '', 'AV.ARENALES 714-JESUS MARIA', '0', '', '', 'A'),
(130, 'Laboratorio', 'CLEMENTS PERUANA S.A.', 'RUC', 'NA', '', '', '', 'LUIS CASTRO RONCEROS 742 LIMA 1', '3366691', '', '', 'A'),
(131, 'Laboratorio', 'CONSUMO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(132, 'Laboratorio', 'CURE BAND', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(133, 'Laboratorio', 'DANY SRL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(134, 'Laboratorio', 'DUBONP S.A.', 'RUC', 'NA', '', '', '', 'AV.RIVERA NAVARRETE 770 OFIC.301', '221-1588', '', '', 'A'),
(135, 'Laboratorio', 'DCONTINENTAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(136, 'Laboratorio', 'DISTRIBUIDORA DELGAR S.R.L.', 'RUC', 'NA', '', '', '', 'JR GONZALES PRADA 460 OF.301-LIMA', '4456015', '', '', 'A'),
(137, 'Laboratorio', 'DELUXE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(138, 'Laboratorio', 'DELFARMA SAC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(139, 'Laboratorio', 'DEMSA S. A.', 'RUC', 'NA', '', '', '', 'CARRETERA CENTRAL KM 10.5 ATE-VITARTE', '3560053', '', '', 'A'),
(140, 'Laboratorio', 'DENTAID SAC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(141, 'Laboratorio', 'DENTI-LAB', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(142, 'Laboratorio', 'IMPORTACIONES DEUTSCHE PHARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(143, 'Laboratorio', 'DIAGNOLAB DEL PERU SRL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(144, 'Laboratorio', 'DISTRIBUIDORA LAYNE S.A.C.', 'RUC', 'NA', '', '', '', 'LOS GEOGRAFOS MZ.L.LTE.13 LA MOLINA', '3483189', '', '', 'A'),
(145, 'Laboratorio', 'DIMEPHARMA SRL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(146, 'Laboratorio', 'DISPOLAB FARMACEUTICA PERU', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(147, 'Laboratorio', 'DISPERSA ALBIS', 'RUC', 'NA', '', '', '', 'LOS NEGOCIOS 185 SURQUILLO', '410999 412919', '', '', 'A'),
(148, 'Laboratorio', 'DROKASA IMPORTACIONES', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(149, 'Laboratorio', 'DROG.LAB.BAXLEY GROUP S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(150, 'Laboratorio', 'DLEOS S.R.L.', 'RUC', 'NA', '', '', '', 'CALLE 26 810-A MZ R LT.32 URB.EL TREBOL', 'LOS OLIVOS', '', '', 'A'),
(151, 'Laboratorio', 'DNM SAC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(152, 'Laboratorio', 'DOLLDER', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(153, 'Laboratorio', 'DOLAPHARM', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(154, 'Laboratorio', 'DOSA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(155, 'Laboratorio', 'DR.A STROE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(156, 'Laboratorio', 'DROGERIA ORBIS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(157, 'Laboratorio', 'DROG.SALUD FARMA', 'RUC', 'NA', '', '', '', 'AV.EL SOL 113 DPTO.205 URB.SAN ROQUE S.', '4261478', '', '', 'A'),
(158, 'Laboratorio', 'DONG SHIN MEDI-TECH CO.', 'RUC', 'NA', '', '', '', 'RUFINO TORRICO 642-402 LIMA', '96636847', '', '', 'A'),
(159, 'Laboratorio', 'DURRACELL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(160, 'Laboratorio', 'LABORATORIOS DELFARMA S.A.C.', 'RUC', 'NA', '', '', '', 'JR.SAN LORENZO 882 LIMA 34-PERU', '4475277', '', '', 'A'),
(161, 'Laboratorio', 'LABORATORIO ELIFARMA S.A.', 'RUC', 'NA', '', '', '', 'AV.LA MARINA 2665', '522337 FAX319764', '', '', 'A'),
(162, 'Laboratorio', 'ETHICALPHARMA S.A.C.', 'RUC', 'NA', '', '', '', 'AV.GUARDIA PERUANA 1032-CHORRILLOS', '2524444', '', '', 'A'),
(163, 'Laboratorio', 'I.E ESKE S.R.L.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(164, 'Laboratorio', 'LABORATORIO EUROQUIM S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(165, 'Laboratorio', 'EVAN PLUS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(166, 'Laboratorio', 'EVEX', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(167, 'Laboratorio', 'FAES FARMA ALBIS S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(168, 'Laboratorio', 'LABORATORIO FARMO-ANDINA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(169, 'Laboratorio', 'FARMA QUIMICA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(170, 'Laboratorio', 'FARPASA', 'RUC', 'NA', '', '', '', 'REPUBLICA DE PANANA 4825-LIMA 34', '4493177', '', '', 'A'),
(171, 'Laboratorio', 'DROGUERIA FARMEDIC S.A.C', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(172, 'Laboratorio', 'FAVEL S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(173, 'Laboratorio', 'FARBIOQUIMSA S.A.', 'RUC', 'NA', '', '', '', 'CALLE D MZ F LOT 13 LOS PORTALES DE J P', '510383', '', '', 'A'),
(174, 'Laboratorio', 'FARMACHIF', 'RUC', 'NA', '', '', '', 'AV.LA MAR 316 MIRAFLORES-LIMA', '4219020', '', '', 'A'),
(175, 'Laboratorio', 'FERRER', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(176, 'Laboratorio', 'FARMINDUSTRIA ACSESORIOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(177, 'Laboratorio', 'FARMINDUSTRIA S.A', 'RUC', 'NA', '', '', '', 'MARISCAL MILLER #2151 LINCE', '70-00-11', '', '', 'A'),
(178, 'Laboratorio', 'FARMACEUTICA LATINA S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(179, 'Laboratorio', 'FARMUR', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(180, 'Laboratorio', 'FARTENE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(181, 'Laboratorio', 'GALENICOS EN GENERAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(182, 'Laboratorio', 'GAMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(183, 'Laboratorio', 'GENERICO AMPOLLETAJE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(184, 'Laboratorio', 'GARFIELD', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(185, 'Laboratorio', 'GENERICOS CREMAS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(186, 'Laboratorio', 'GENERICOS JARABES', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(187, 'Laboratorio', 'GEN-FAR PERU SA', 'RUC', 'NA', '', '', '', 'SAN FERNANDO 154-MIRAFLORES', '476017', '', '', 'A'),
(188, 'Laboratorio', 'GENA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(189, 'Laboratorio', 'GEMINI PHARMACEUTICAL INC.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(190, 'Laboratorio', 'GARDEN HOUSE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(191, 'Laboratorio', 'LABORATORIO GIANFARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(192, 'Laboratorio', 'LABORATORIO GILSA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(193, 'Laboratorio', 'GENERICOS INHALADORES', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(194, 'Laboratorio', 'LABORATORIO GLAXO DEL PERU', 'RUC', 'NA', '', '', '', 'AV JAVIER PRADO OESTE 995.SAN ISIDRO', '408603-403316', '', '', 'A'),
(195, 'Laboratorio', 'GENRICOS OVULOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(196, 'Laboratorio', 'PRO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(197, 'Laboratorio', 'GENERICOS PASTILLAJE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(198, 'Laboratorio', 'GRUPO FARMA', 'RUC', 'NA', '', '', '', 'AV A.BENAVIDES 330-303 LIMA', '0', '', '', 'A'),
(199, 'Laboratorio', 'GEDEON', 'RUC', 'NA', '', '', '', '2DO PISO.SAN MIGUEL', '0', '', '', 'A'),
(200, 'Laboratorio', 'GROUP', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(201, 'Laboratorio', 'GRUNENTHAL PERUANA S.A.', 'RUC', 'NA', '', '', '', 'AV.P.DE LA REP.#2242 LINCE', '413487 - 228004', '', '', 'A'),
(202, 'Laboratorio', 'GRUPO SPECTRA', 'RUC', 'NA', '', '', '', 'CALLE TASSO 213 SAN BORJA PERU', '2250323', '', '', 'A'),
(203, 'Laboratorio', 'GILLETTE S A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(204, 'Laboratorio', 'HELEN CURTIS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(205, 'Laboratorio', 'HENO DE PRAVIA.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(206, 'Laboratorio', 'HERSIL', 'RUC', 'NA', '', '', '', 'AV.RECOLECTOR INDUSTRIAL 140 ATE LIMA 3', '359377 - 321402', '', '', 'A'),
(207, 'Laboratorio', 'HOFARM', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(208, 'Laboratorio', 'HIGUIENE PERSONAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(209, 'Laboratorio', 'HENKEL PERUANA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(210, 'Laboratorio', 'ALMACENERA MEDICA S.R.LTDA.', 'RUC', 'NA', '', '', '', 'AV.UNIVERSITARIA 586-URB.PANDO SAN MIGUE', '(511)4608645', '', '', 'A'),
(211, 'Laboratorio', 'HOECHST MARION ROUSSEL S.A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(212, 'Laboratorio', 'HELP PHARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(213, 'Laboratorio', 'HELP PHARMA S.A.C.', 'RUC', 'NA', '', '', '', 'JR.SAN CARLOS 1696 LIMA 10', '327-7953', '', '', 'A'),
(214, 'Laboratorio', 'INDUSTRIA DELITE INTERNACIONAL', 'RUC', 'NA', '', '', '', 'CALLE LA GARDENIAS MZ.J LT.11A-CHORRILLS', '2543880', '', '', 'A'),
(215, 'Laboratorio', 'INDUQUIMICA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(216, 'Laboratorio', 'INTRADEVCO DIVISION INTRALAB', 'RUC', 'NA', '', '', '', 'AV.PRODUCCION NACIONAL 188 LIMA 9', '467-4999', '', '', 'A'),
(217, 'Laboratorio', 'IMPROVENG', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(218, 'Laboratorio', 'INDUFARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(219, 'Laboratorio', 'INFERMED', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(220, 'Laboratorio', 'CORPORACION INFARMASA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(221, 'Laboratorio', 'LABORATORIO INPER S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(222, 'Laboratorio', 'INTRADEVCO INDUSTRIAL S.A.', 'RUC', 'NA', '', '', '', 'AV.PRODUCCION NACIONAL 188 CHORRILLOS', '467-4999', '', '', 'A'),
(223, 'Laboratorio', 'INTIPHARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(224, 'Laboratorio', 'INVELAP E.I.R.L.', 'RUC', 'NA', '', '', '', 'SAN MARTIN 515 MIRAFLORES', '4440627', '', '', 'A'),
(225, 'Laboratorio', 'INSTITUTO QUIMIOTERAPICO S.A.', 'RUC', 'NA', '', '', '', 'AV.STA.ROSA 345 STA.ANITA', '0', '', '', 'A'),
(226, 'Laboratorio', 'IQFARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(227, 'Laboratorio', 'DERMEX', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(228, 'Laboratorio', 'INSTITUTO SEROTERAPICO PERUANO', 'RUC', 'NA', '', '', '', 'AV.MANUEL C.DE LA TORRE 142-SANTA ANITA', '0', '', '', 'A'),
(229, 'Laboratorio', 'INTAS PHARMACEUTICALS LTDA.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(230, 'Laboratorio', 'IVAX PERU S.A.', 'RUC', 'NA', '', '', '', 'CALLAO', '0', '', '', 'A'),
(231, 'Laboratorio', 'JALYSON E.I.R.L.', 'RUC', 'NA', '', '', '', 'JR.AMSTERDAM 169 UR.PORTALES ATE VITARTE', '351 3566', '', '', 'A'),
(232, 'Laboratorio', 'JANSSEN PHARMACEUTICA', 'RUC', 'NA', '', '', '', 'CARRETERA CENTRAL KM 4.7 ATE-VITARTE', '359141 FAX364857', '', '', 'A'),
(233, 'Laboratorio', 'JHONSONS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(234, 'Laboratorio', 'JHONSONS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(235, 'Laboratorio', 'JUEGOS Y JUGUETES', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(236, 'Laboratorio', 'JUMAN E.I.R.L.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(237, 'Laboratorio', 'KOLYNOS COLGATE PALMOLIVE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(238, 'Laboratorio', 'KIP MEHECO PERU S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(239, 'Laboratorio', 'KNOLL A.G. INTERPHARMA', 'RUC', 'NA', '', '', '', 'PSJE.LOS NEGOS.#163-SURQUILLO', '410999 FAX416908', '', '', 'A'),
(240, 'Laboratorio', 'LABORATORIO KARBART H.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(241, 'Laboratorio', 'LABORATORIO KOPRAN.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(242, 'Laboratorio', 'LABORATORIO GALDERMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(243, 'Laboratorio', 'LABORATORIO ALCON', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(244, 'Laboratorio', 'LABORATORIO PANALAB', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(245, 'Laboratorio', 'LABORATORIO ASTRAZENECA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(246, 'Laboratorio', 'LABORATORIO CEFARM E.I.L.R.', 'RUC', 'NA', '', '', '', 'AV LOS CHASQUIS 769 URB.ZARATE S.J.L.', '376-0735', '', '', 'A'),
(247, 'Laboratorio', 'LACTEOS', 'RUC', 'NA', '', '', '', '0', '5346447-3470071', '', '', 'A'),
(248, 'Laboratorio', 'LABORATORIO LABOFAR.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(249, 'Laboratorio', 'LABORATORIO LANSIER', 'RUC', 'NA', '', '', '', 'JR.NAPO # 450 - LIMA', '0', '', '', 'A'),
(250, 'Laboratorio', 'LABORATORIO PORTUGAL S.R.L.', 'RUC', 'NA', '', '', '', 'MIGUEL GRAU 313 C.COLORADO AREQUIPA', '0', '', '', 'A'),
(251, 'Laboratorio', 'DROG. AGRIPINO SARMIENTO COSCO', 'RUC', 'NA', '', '', '', 'JR.CAHUIDE MZA D LT 17 2DO PISO CHORRIL.', '2519607', '', '', 'A'),
(252, 'Laboratorio', 'LABORATORIO FARMACEU.LASAR S.A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(253, 'Laboratorio', 'LABORATORIO FARMASUR', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(254, 'Laboratorio', 'LABORATORIO BIONATURE EIRL.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(255, 'Laboratorio', 'LABAROTORIO TERBOL S.A.', 'RUC', 'NA', '', '', '', 'MACHAYOUITO #115 SAN ISIDRO-LIMA-PERU', '4402729', '', '', 'A'),
(256, 'Laboratorio', 'LABORATORIO CAVIAL S.A.C.', 'RUC', 'NA', '', '', '', 'AV.JOSE PARDO 620 OF.508 LIMA 18', '2416238', '', '', 'A'),
(257, 'Laboratorio', 'LAB.CINTHYA EVELYN S.R.L.', 'RUC', 'NA', '', '', '', 'AV.BERLIN MZ.Q LT.1 AS.DE VI.VIRGEN DEL', 'CARMEN ATE VITA.', '', '', 'A'),
(258, 'Laboratorio', 'LABORATORIO CHILE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(259, 'Laboratorio', 'LABORATORIO CHILE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(260, 'Laboratorio', 'LABORATORIO DISFLOZA S.A.C.', 'RUC', 'NA', '', '', '', 'AV.BOLIVAR 561 AV.PASO DE LOS ANDES 740', 'PUEBLO LIBRE', '', '', 'A'),
(261, 'Laboratorio', 'LABORATORIO DR.ZAIDMAN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(262, 'Laboratorio', 'CREMA LECHUGA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(263, 'Laboratorio', 'LABORATORIO LEDERLE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(264, 'Laboratorio', 'LENCERIA PADULTOS Y NI?OS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(265, 'Laboratorio', 'LEO PHARMA', 'RUC', 'NA', '', '', '', 'PRIMAVERA 2081 MONTERRICO', '4372119', '', '', 'A'),
(266, 'Laboratorio', 'HEALTH COMPLEMENTS S.A.C.', 'RUC', 'NA', '', '', '', 'AV.PACIFICO 189 CALLAO 4', '4204594', '', '', 'A'),
(267, 'Laboratorio', 'LABORATORIO FARMA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(268, 'Laboratorio', 'LA FRANCOL LABORATORIO', 'RUC', 'NA', '', '', '', 'AV.BOLIVAR 795 P.LIBRE', '0', '', '', 'A'),
(269, 'Laboratorio', 'LINEA COMERCIAL GENERICA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(270, 'Laboratorio', 'LAB.GENCOPHARMACEUTICAL S.A.C.', 'RUC', 'NA', '', '', '', 'URB.EL EXITO MZ C LT 11-ATE VITARTE', '356-0937', '', '', 'A'),
(271, 'Laboratorio', 'LABORATORIO GROSSMAN', 'RUC', 'NA', '', '', '', 'MEXICO', '0', '', '', 'A'),
(272, 'Laboratorio', 'LIBRERIA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(273, 'Laboratorio', 'LIFARMAQUIMICA S.A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(274, 'Laboratorio', 'ELI LILLY INTERAMERICANA INC', 'RUC', 'NA', '', '', '', 'LAS BEGONIAS 451,2DO PISO.SAN ISIDRO', '422626 FAX421378', '', '', 'A'),
(275, 'Laboratorio', 'LABORATORIO LABOT', 'RUC', 'NA', '', '', '', 'CALLE DOS 195 SAN ISIDRO LIMA PERU', '2126022', '', '', 'A'),
(276, 'Laboratorio', 'LABORATORIO LIONS', 'RUC', 'NA', '', '', '', '0', '5263298', '', '', 'A'),
(277, 'Laboratorio', 'LABORATORIOS MAZALY S.A.C.', 'RUC', 'NA', '', '', '', 'AV.LA PAZ 1411 SAN MIGUEL', '0', '', '', 'A'),
(278, 'Laboratorio', 'LMB H. COLICHON S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(279, 'Laboratorio', 'LABORATORIO MEDCO S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(280, 'Laboratorio', 'LABORATORIO MGROSSI S.A.', 'RUC', 'NA', '', '', '', 'JR.CHAVIN DE HUANTAR 666-URB.ZARATE', '0', '', '', 'A'),
(281, 'Laboratorio', 'LABORATORIO ROSTERS S.A.', 'RUC', 'NA', '', '', '', 'PARQUE CHICAMA 1425', '701730-718406', '', '', 'A'),
(282, 'Laboratorio', 'LABORATORIO LA SANTE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(283, 'Laboratorio', 'CIA.LUCCAST E.I.R.L.', 'RUC', 'NA', '', '', '', 'INANBARI 747 - A  LIMA', '4282994', '', '', 'A'),
(284, 'Laboratorio', 'LUKOLL S.A.C.', 'RUC', 'NA', '', '', '', 'GRL.PEZET 1970 LIMA 17', '2643322', '', '', 'A'),
(285, 'Laboratorio', 'LUPASA S.R.L.TDA.', 'RUC', 'NA', '', '', '', 'CALLE RAUL PORRAS BARRENECHEA 157-RIMAC', '381-3619', '', '', 'A'),
(286, 'Laboratorio', 'LABORATORIO UNIDOS S.A.', 'RUC', 'NA', '', '', '', 'AV.PAS.D LOS ANDES 740-P.LIBRE', '63-64-70', '', '', 'A'),
(287, 'Laboratorio', 'LUITPOLD', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(288, 'Laboratorio', 'DROGUERIA MACRISNEY S.R.L.', 'RUC', 'NA', '', '', '', 'AV.SALAVERRY 2415 SAN ISIDRO', '0', '', '', 'A'),
(289, 'Laboratorio', 'LABORATORIO MADRID S.R.L.', 'RUC', 'NA', '', '', '', 'AV.CAMINO REAL 1801 PQUE IND.PEDRITO SUR', '4777563', '', '', 'A'),
(290, 'Laboratorio', 'MAGMA S.A.', 'RUC', 'NA', '', '', '', 'AV.D`EJERCITO #490-SAN ISIDRO', '41-38-48', '', '', 'A'),
(291, 'Laboratorio', 'LABORATORIO MALDONADO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(292, 'Laboratorio', 'CONCHA NACAR', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(293, 'Laboratorio', 'MATERIAL MEDICO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(294, 'Laboratorio', 'MATERIAL MEDICO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(295, 'Laboratorio', 'MAQUIFARMA E.I.R.L.', 'RUC', 'NA', '', '', '', 'CALLE JAVIER CORREA ELIAS 195 SAN MIGUEL', '0', '', '', 'A'),
(296, 'Laboratorio', 'MARKOS S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(297, 'Laboratorio', 'MASON NATURAL ARION INTERNAC.', 'RUC', 'NA', '', '', '', 'PSJE. UMACHIRI 120-SAN MIGUEL', '447-1502', '', '', 'A'),
(298, 'Laboratorio', 'LABORATORIO MAVER', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(299, 'Laboratorio', 'MEDICO BIOLOGICO COLICHON', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(300, 'Laboratorio', 'MACRISNEY S.R.L.', 'RUC', 'NA', '', '', '', 'AV.SALAVERRY 2415 OF.207-208', 'SAN ISIDRO', '', '', 'A'),
(301, 'Laboratorio', 'MEDICRAFT S.A.C.', 'RUC', 'NA', '', '', '', 'CALLE CHIMU 162 PEUBLO LIBRE-LIMA', '4614778', '', '', 'A'),
(302, 'Laboratorio', 'MEDIFARMA S.A.', 'RUC', 'NA', '', '', '', 'AV.ARGENTINA #1082 LIMA,PERU', '9329002', '', '', 'A'),
(303, 'Laboratorio', 'MEAD JHONSONS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(304, 'Laboratorio', 'MEPHA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(305, 'Laboratorio', 'MERCK PERUANA S.A', 'RUC', 'NA', '', '', '', 'P.DE LOS ANDES #621-P.LIBRE', '631212- 415848', '', '', 'A'),
(306, 'Laboratorio', 'MIDAG CARE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(307, 'Laboratorio', 'MIMO S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(308, 'Laboratorio', 'MISSION PHARMACEUTICAL S.A.C.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(309, 'Laboratorio', 'MKS UNIDOS S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(310, 'Laboratorio', 'MONSANTI S.R.L.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(311, 'Laboratorio', 'MERCUR', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(312, 'Laboratorio', 'MARFAN', 'RUC', 'NA', '', '', '', '0', '9415512', '', '', 'A'),
(313, 'Laboratorio', 'MIERUX PASTEUR', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(314, 'Laboratorio', 'MERK SHARP AND DONE.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(315, 'Laboratorio', 'NATURALFA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(316, 'Laboratorio', 'NATUMED', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(317, 'Laboratorio', 'NEUTROGENA.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(318, 'Laboratorio', 'HEINZ NUTRICION', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(319, 'Laboratorio', 'NINET', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(320, 'Laboratorio', 'NIPRO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(321, 'Laboratorio', 'NEWPHARM S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(322, 'Laboratorio', 'NOVARTIS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(323, 'Laboratorio', 'LINEA OFTALMOLOGICA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(324, 'Laboratorio', 'OKASA', 'RUC', 'NA', '', '', '', 'JR CA?ETE 468-201 LIMA 1', '425-0704', '', '', 'A'),
(325, 'Laboratorio', 'OLGER DISTRIBUCIONES', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(326, 'Laboratorio', 'OM PERU S.A.', 'RUC', 'NA', '', '', '', 'REY BASADRE #385-MAGDALENA DEL MAR', '4615690', '', '', 'A'),
(327, 'Laboratorio', 'OMDICA S A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(328, 'Laboratorio', 'OMNIUM IMPORT', 'RUC', 'NA', '', '', '', 'STA LUISA 155 SAN ISIDRO', 'FAX - 4426374', '', '', 'A'),
(329, 'Laboratorio', 'OMNILIFE PERU S.A.C.', 'RUC', 'NA', '', '', '', 'AV.ARENALES 711 JESUS MARIA', '0', '', '', 'A'),
(330, 'Laboratorio', 'ORAL B', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(331, 'Laboratorio', 'ORGANON INTERNACIONAL BV', 'RUC', 'NA', '', '', '', 'JR.CAMANA #993 -A- OF.404-LIMA', '246192- 708484', '', '', 'A'),
(332, 'Laboratorio', 'OSN FARMACEUTICA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(333, 'Laboratorio', 'OYSA LABORATORIO', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(334, 'Laboratorio', 'PA?ALES DESECHABLES', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(335, 'Laboratorio', 'PACOCHA INDUSTRIAS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(336, 'Laboratorio', 'PHARMADIX', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(337, 'Laboratorio', 'PALU S.A.C.', 'RUC', 'NA', '', '', '', 'PARQUE INDUSTRIAL MZ.E LT.12 B TACNA', '0', '', '', 'A'),
(338, 'Laboratorio', 'PANASONIC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(339, 'Laboratorio', 'PARKE-DAVIS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(340, 'Laboratorio', 'PAVIL S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(341, 'Laboratorio', 'PHARMA CARE S.A.C.', 'RUC', 'NA', '', '', '', 'AV.RICARDO ELIAS APARICIO 141 LIMA', '3683718', '', '', 'A'),
(342, 'Laboratorio', 'PHARMED CORPORATION E.S.C.', 'RUC', 'NA', '', '', '', 'PROLG.REYNALDO VIVANCO 678 SURCO', '0', '', '', 'A'),
(343, 'Laboratorio', 'PERFUMERIA BEBE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(344, 'Laboratorio', 'PELUCHES', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(345, 'Laboratorio', 'PENTACOOP GENERICOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(346, 'Laboratorio', 'NESTLE PERU S.A.', 'RUC', 'NA', '', '', '', 'CALLE LOS CASTILLOS CDA 3 ATE VITARTE', '4364040', '', '', 'A'),
(347, 'Laboratorio', 'PERFUMERIA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(348, 'Laboratorio', 'PAK FARMA', 'RUC', 'NA', '', '', '', '0', '261 1408', '', '', 'A'),
(349, 'Laboratorio', 'PFIZER  FARMACEUTICA', 'RUC', 'NA', '', '', '', 'AV.VENEZUELA #5415-SAN MIGUEL', '51-25-70', '', '', 'A'),
(350, 'Laboratorio', 'IMPORTADORA-PROFARMA', 'RUC', 'NA', '', '', '', 'AV. BOLIVAR 2100 LIMA 21', '0', '', '', 'A'),
(351, 'Laboratorio', 'PERUANO GERMANO', 'RUC', 'NA', '', '', '', 'AV.REPUBLI.D PANAMA #1773 LIMA', '72-04-97', '', '', 'A'),
(352, 'Laboratorio', 'PROCTER & GAMBLE DEL PERU', 'RUC', 'NA', '', '', '', 'A. POSTAL 3848 LIMA 100', '0', '', '', 'A'),
(353, 'Laboratorio', 'PHARMALAB', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(354, 'Laboratorio', 'PHARMACHEMICAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(355, 'Laboratorio', 'PHARMA INVESTI', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(356, 'Laboratorio', 'RHO NE POLLENC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(357, 'Laboratorio', 'PAPELES HIGENICOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(358, 'Laboratorio', 'PLACENTA LABORATORIOS E.I.R.L.', 'RUC', 'NA', '', '', '', 'AV.CORDILLERA CENTRAL MZ.C-13 LT.2 LMA', '0', '', '', 'A'),
(359, 'Laboratorio', 'PERSONAL PRODUCTS S.A.', 'RUC', 'NA', '', '', '', 'CALLE LOS MELONES URB.RSD.MONTERRICO LI', '0', '', '', 'A'),
(360, 'Laboratorio', 'PRECISION', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(361, 'Laboratorio', 'PREMIER', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(362, 'Laboratorio', 'PERUGEN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(363, 'Laboratorio', 'QUALATEM', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(364, 'Laboratorio', 'QUIMICA HINDU SAC', 'RUC', 'NA', '', '', '', 'AV.JAVIER PRADO ESTE 3415 LIMA 41 PERU', '3462521', '', '', 'A'),
(365, 'Laboratorio', 'QUIMICA MEDICAL LAB.FARMACEUT.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(366, 'Laboratorio', 'QUALICONT LABORATORIOS SAC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(367, 'Laboratorio', 'QUILAB', 'RUC', 'NA', '', '', '', 'CARRETERA CENTRAL KM 3 1315 LIMA', '4941010', '', '', 'A'),
(368, 'Laboratorio', 'RED BULL GMBH', 'RUC', 'NA', '', '', '', 'AUSTRIA', '0', '', '', 'A'),
(369, 'Laboratorio', 'REFASA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(370, 'Laboratorio', 'REGALOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(371, 'Laboratorio', 'RECAMIER DISTRIB.MULTINACIONAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(372, 'Laboratorio', 'REVLON', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(373, 'Laboratorio', 'REX PERUANA S.A.', 'RUC', 'NA', '', '', '', 'POMABAMBA 740 LIMA 05', '4245720', '', '', 'A'),
(374, 'Laboratorio', 'RHONE-PONLENC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(375, 'Laboratorio', 'RICHARD O.CUSTER S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(376, 'Laboratorio', 'INST.BIOQUIM.DR.F.REMY S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(377, 'Laboratorio', 'ROBINS', 'RUC', 'NA', '', '', '', 'PJE:CHINCAMA 1243-1425', '701730-718406', '', '', 'A'),
(378, 'Laboratorio', 'ROPA PARA BEBE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(379, 'Laboratorio', 'ROCHE Q.F.', 'RUC', 'NA', '', '', '', 'COD-USU 112780.CLA.PER 56757', 'CTA CLIE 127936', '', '', 'A'),
(380, 'Laboratorio', 'ROEMMERS S.A.', 'RUC', 'NA', '', '', '', 'PRESCOTT 308-SAN ISIDRO', '99570966', '', '', 'A'),
(381, 'Laboratorio', 'COMERCIALIZADORA RONALD & CO.S', 'RUC', 'NA', '', '', '', 'JR.DE LOS HEREOS 148-BELLAVISTA CALLAO', '4535675', '', '', 'A'),
(382, 'Laboratorio', 'ROWA', 'RUC', 'NA', '', '', '', 'MIGUEL SEMINARIO 220 SAN ISIDRO', '4421940', '', '', 'A'),
(383, 'Laboratorio', 'ROWE LABORATORIOS', 'RUC', 'NA', '', '', '', 'IMPORTADO POR ROEMMERS', '0', '', '', 'A'),
(384, 'Laboratorio', 'MARION ROUSSEL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(385, 'Laboratorio', 'RUDIVAN S.R.L.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(386, 'Laboratorio', 'RHOVIC PHARMACEUTICAL SA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(387, 'Laboratorio', 'RYMCO JERINGAS Y EQUIPOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(388, 'Laboratorio', 'SANOFI', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(389, 'Laboratorio', 'SANOFI-SYNTHELABO DEL PERU S A', 'RUC', 'NA', '', '', '', 'AV.REP. PANAMA 4825 SURQUILLO LIMA', '0', '', '', 'A'),
(390, 'Laboratorio', 'SANITAS S.P.S.A.', 'RUC', 'NA', '', '', '', 'J.PABLO.FERNAND.#1140-P.LIBRE', '32-70-40', '', '', 'A'),
(391, 'Laboratorio', 'SAAOTO Y CIA.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(392, 'Laboratorio', 'SISTEMAS ANALITICOS S.R.L.', 'RUC', 'NA', '', '', '', 'DOMINGO CUETO 539 LINCE', '2659288', '', '', 'A'),
(393, 'Laboratorio', 'LABORATORIO SAVAL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(394, 'Laboratorio', 'SCHIC', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(395, 'Laboratorio', 'SCHERING PLOUGH INT.', 'RUC', 'NA', '', '', '', 'AV.PAS.D L.REPU.#3156 S.ISIDRO MADELENE', 'RINA A.VELASQUEZ', '', '', 'A'),
(396, 'Laboratorio', 'SANDERSON', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(397, 'Laboratorio', 'SCHERING FARMACEUTICA PERUANA', 'RUC', 'NA', '', '', '', 'PASEO DE LA REPUB 3153.SAN ISID.LIMA 27', '421800 FAX423330', '', '', 'A'),
(398, 'Laboratorio', 'SIEGFRIED CHEMIE AG', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(399, 'Laboratorio', 'SHERFARMA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(400, 'Laboratorio', 'SUNSHINE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(401, 'Laboratorio', 'LABORATORIO SIFI', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(402, 'Laboratorio', 'LABORATORIO SILESIA S.A.', 'RUC', 'NA', '', '', '', 'CHILE', '0', '', '', 'A'),
(403, 'Laboratorio', 'LABORATORIO SINSIN PHARM.LTD.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(404, 'Laboratorio', 'SIU', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(405, 'Laboratorio', 'SAN JOAQUIN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(406, 'Laboratorio', 'S.J.ROXFARMA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(407, 'Laboratorio', 'SMITHKLINE BEECHAM  SB', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(408, 'Laboratorio', 'SOLCO - INTERPHARMA', 'RUC', 'NA', '', '', '', 'PJSE.NEGOCIOS #163-SURQUILLO', '41-55-60', '', '', 'A'),
(409, 'Laboratorio', 'SHANGHAI SINE PHARM LTDA.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(410, 'Laboratorio', 'STIEFEL', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(411, 'Laboratorio', 'SUIPHAR DEL PERU S.A.', 'RUC', 'NA', '', '', '', 'PLAZA AROSPIDE N 9 SAN ISIDRO', '222-4593', '', '', 'A'),
(412, 'Laboratorio', 'SUNDOWN VITAMINS.', 'RUC', 'NA', '', '', '', 'FRAY LUIS DE LEON 398 URB.SAN BORJA LIMA', '4769383', '', '', 'A'),
(413, 'Laboratorio', 'TECNOFARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(414, 'Laboratorio', 'TECO DIAGNOSTICS', 'RUC', 'NA', '', '', '', 'USA', '0', '', '', 'A'),
(415, 'Laboratorio', 'TERUMO NEEDLE', 'RUC', 'NA', '', '', '', 'USA', '0', '', '', 'A'),
(416, 'Laboratorio', 'NUTRICIONALE', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(417, 'Laboratorio', 'TIA NENA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(418, 'Laboratorio', 'LAB.FARMAC.T.N.REPRESENT.S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(419, 'Laboratorio', 'TRIFARMA S.A.', 'RUC', 'NA', '', '', '', 'ESQ.DLAS AVASTA.ROSA,STA.MARIA', '31-64-26', '', '', 'A'),
(420, 'Laboratorio', 'UNION FARMACEUTICA NACIONAL', 'RUC', 'NA', '', '', '', 'CALLE 16 LA FLORIDA RIMAC', '481-1690', '', '', 'A'),
(421, 'Laboratorio', 'UNIFARMA LABORATORIO', 'RUC', 'NA', '', '', '', 'CALLE DOMINGO ORUE LIMA 34', '241-2694', '', '', 'A'),
(422, 'Laboratorio', 'D.Y S.CONSORCIOS UNIDOS S.A.', 'RUC', 'NA', '', '', '', 'CALLE 3 MZ.D LOTE 1-SURCO', '3450645', '', '', 'A'),
(423, 'Laboratorio', 'UNIMED DEL PERU S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(424, 'Laboratorio', 'UPJOHN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(425, 'Laboratorio', 'LAB.UNION QUIMICA PERUANA S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(426, 'Laboratorio', 'USV S.A', 'RUC', 'NA', '', '', '', 'AV.JAVI.PRADO O.#995 S.ISIDRO', '41-22-72', '', '', 'A'),
(427, 'Laboratorio', 'VAJILLAS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(428, 'Laboratorio', 'VALFARMA MEDICAL S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(429, 'Laboratorio', 'VARIOS', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(430, 'Laboratorio', 'VARIOS BAZAR', 'RUC', 'NA', '', '', '', 'COMPRAS EN LIMA', '0', '', '', 'A'),
(431, 'Laboratorio', 'VITROFARMA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(432, 'Laboratorio', 'VITALIS PERU S.A.C.', 'RUC', 'NA', '', '', '', 'CALLE CAMINO REAL 1801-SURCO', '0', '', '', 'A'),
(433, 'Laboratorio', 'LINEA ALBERTO BO5', 'RUC', 'NA', '', '', '', 'AV J.A PEZET 1483 SAN ISIDRO', '220459', '', '', 'A'),
(434, 'Laboratorio', 'VITAMINICA S.A.', 'RUC', 'NA', '', '', '', 'PRESCOTT 308 2.PISO 4405963 FAX4404364', 'DIFESA DROKASA', '', '', 'A'),
(435, 'Laboratorio', 'WELFARK', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(436, 'Laboratorio', 'WELLA', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(437, 'Laboratorio', 'WYETH S.A.', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(438, 'Laboratorio', 'YICHANG & CIA.S.A.', 'RUC', 'NA', '', '', '', 'AV.NICOLAS DE PIEROLA 1658 LIMA', '4283040-4287490', '', '', 'A'),
(439, 'Laboratorio', 'ZENECA FARMA S A', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(440, 'Laboratorio', 'ZAMBAN', 'RUC', 'NA', '', '', '', '0', '0', '', '', 'A'),
(441, 'Proveedor', 'nuevo proveedor', 'RUC', 'ss', 'ss', 's', 's', 's', '', 's', 's', 'C'),
(442, 'Proveedor', 'QUIMICA SUIZA', 'RUC', '', '', '', '', 'AV.REP.DE PANAMA 2577 SURQUILLO', '4708484/4709870', '', '', 'A'),
(443, 'Proveedor', 'RICHARD O.CUSTER', 'RUC', '', '', '', '', 'AV BOLIVAR 2100 - PUEBLO LIBRE', '4619991/4616535', '', '', 'A'),
(444, 'Proveedor', 'CONTINENTAL DISTRIB.', 'RUC', '', '', '', '', 'LUIS GALVANI 498 ATE LIMA', '4360711/4374088', '', '', 'A'),
(445, 'Proveedor', 'LUSA LAB.UNIDOS S.A.', 'RUC', '', '', '', '', 'AV.BOLIVAR 561 PUEBLO LIBRE', '4630505/4634000', '', '', 'A'),
(446, 'Proveedor', 'DROGUERIA LIDAR S.A.', 'RUC', '', '', '', '', 'AV.SAN BORJA NORTE 813', '4763425 4762865', '', '', 'A'),
(447, 'Proveedor', 'FARBIOQUIMSA', 'RUC', '', '', '', '', 'CALLE D MZ F LOTE 13 ATE VITARTE', '451-0383', '', '', 'A'),
(448, 'Proveedor', 'BIOPLIX', 'RUC', '', '', '', '', 'PARDO Y ALIAGA 472 SAN ISIDRO', '22-0872', '', '', 'A'),
(449, 'Proveedor', 'CONSORCIO FARMACEUTICO SA', 'RUC', '', '', '', '', 'JR SAN AURELIO 829 URB AZCARRUNZ S.J.L.', '481-8923', '', '', 'A'),
(450, 'Proveedor', 'MADFARMA', 'RUC', '', '', '', '', 'AV. FRANCISCO PIZARRO NO 345', '81-4189 82-2729', '', '', 'A'),
(451, 'Proveedor', 'INDUSTRIAS PACOCHA', 'RUC', '', '', '', '', '', '71-0706', '', '', 'A'),
(452, 'Proveedor', 'ADROFA', 'RUC', '', '', '', '', 'AV. J PEZET NO 1483      SAN ISIDRO', '638228 631931', '', '', 'A'),
(453, 'Proveedor', 'PERUFARMA', 'RUC', '', '', '', '', 'STA.FRANCISCA ROMANA 1092 - LIMA', '5640900 640866', '', '', 'A'),
(454, 'Proveedor', 'ALBIS DISTRIBUIDORA', 'RUC', '', '', '', '', 'PJE LOS NEGOCIOS 185 - SURQUILLO', '4410999', '', '', 'A'),
(455, 'Proveedor', 'INTERPHARMA', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(456, 'Proveedor', 'IPSA IMPORT.PROD.FARM.', 'RUC', '', '', '', '', 'ELMER FAUCETT 282 MARANGA - SAN MIGUEL', '4517630-4511219', '', '', 'A'),
(457, 'Proveedor', 'DROKASA PERU', 'RUC', '', '', '', '', 'MIGUEL IGLESIAS 2124 LINCE', '4701111 700012', '', '', 'A'),
(458, 'Proveedor', 'ALFARO', 'RUC', '', '', '', '', 'AV.VENEZUELA 1847 CALLAO BELLAVISTA LIMA', '4519511 4647666', '', '', 'A'),
(459, 'Proveedor', 'PROMOTORA DIST. METRO', 'RUC', '', '', '', '', 'AV STA.CATALINA 021 - LA VICTORIA', '470-8777', '', '', 'A'),
(460, 'Proveedor', 'REYES DROGUERIA', 'RUC', '', '', '', '', 'MIGUEL SEMINARIO 220 SAN ISIDRO', '42-1940', '', '', 'A'),
(461, 'Proveedor', 'CHILDRENS IMPORT', 'RUC', '', '', '', '', 'MARISCAL LA MAR NO 945     SANTA CRUZ', '41-1353', '', '', 'A'),
(462, 'Proveedor', 'DECO REPRESENTACIONES', 'RUC', '', '', '', '', 'CALLE 3 NRO.141 URB.LOS HUERTOS-SURCO', '3440217/3440241', '', '', 'A'),
(463, 'Proveedor', 'OMEGA CORPORACION', 'RUC', '', '', '', '', 'AV SEP.IND.MZ I LT 9 URB LOS ALAMOS LIMA', '435-2543', '', '', 'A'),
(464, 'Proveedor', 'GUIAS VARIAS', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(465, 'Proveedor', 'FARMO ANDINA', 'RUC', '', '', '', '', 'JOSE COSSSIO 305 MAGDALENA DEL MAR', '2640242 640213', '', '', 'A'),
(466, 'Proveedor', 'FARMUR LABORAT.', 'RUC', '', '', '', '', 'JR. BOLOGNESI NO 235  SAN MIGUEL', '61-0681', '', '', 'A'),
(467, 'Proveedor', 'DROGUERIA SAN JUAN', 'RUC', '', '', '', '', 'AV. LA MAR 1005 - 1027 MIRAFLORES /LIMA', '4418217 4426357', '', '', 'A'),
(468, 'Proveedor', 'FARMACEUTICA MODERNA', 'RUC', '', '', '', '', 'JR CHICLAYO 1006 - MIRAFLORES', '477669/F-440382', '', '', 'A'),
(469, 'Proveedor', 'ALONGA LABORAT.', 'RUC', '', '', '', '', 'AV. PARDO 620 OF-203   MIRAFLORES', '46-9131', '', '', 'A'),
(470, 'Proveedor', 'PROMOCIONES FARMACEUT.', 'RUC', '', '', '', '', 'REP./RICHARD O COUSTER', '461-9991', '', '', 'A'),
(471, 'Proveedor', 'VC INDUSTRIAS', 'RUC', '', '', '', '', 'PASAJE TEJADA # 171 LIMA 18', 'TELEFAX 45-7959', '', '', 'A'),
(472, 'Proveedor', 'REFASA', 'RUC', '', '', '', '', 'ESQ.CALLE 1 Y MORRO SOLAR-SURCO', '4493177 4482737', '', '', 'A'),
(473, 'Proveedor', 'GEN-FAR PERU', 'RUC', '', '', '', '', 'CALLE SAN FERNANDO 154 MIRAFLORES.', '476017', '', '', 'A'),
(474, 'Proveedor', 'LAQUIFAZA', 'RUC', '', '', '', '', 'AUTOPISTA PAN.SUR KM.25.5', '423519', '', '', 'A'),
(475, 'Proveedor', 'QUIRURGICA PERUANA', 'RUC', '', '', '', '', 'AV. COLONIAL 1255 LIMA.', '245830 - 249145', '', '', 'A'),
(476, 'Proveedor', 'FAPIET EIRL', 'RUC', '', '', '', '', 'HIPOLITO BERNARDEST 105 BARRANCO.', '774015', '', '', 'A'),
(477, 'Proveedor', 'ARION INTERNATIONAL', 'RUC', '', '', '', '', 'FRANCISCO OLCAY 427 MIRAFLORES', '458663', '', '', 'A'),
(478, 'Proveedor', 'NATURTEC', 'RUC', '', '', '', '', 'PASEO DE LA REPUBLICA 3557 S.ISIDRO', '', '', '', 'A'),
(479, 'Proveedor', 'TECNOFARMA', 'RUC', '', '', '', '', 'CALLE COSTA RICA 260 - JESUS MARIA', '4630930/4630923', '', '', 'A'),
(480, 'Proveedor', 'TRACKER DROGUERIA', 'RUC', '', '', '', '', 'AV.TOMAS MARZANO 2566.MIRAFLORES', '483802', '', '', 'A'),
(481, 'Proveedor', 'SALAZAR DROGUERIA', 'RUC', '', '', '', '', 'LAS COLINAS 360 S.J. DE LURIGANCHO.', '994080 - 558141', '', '', 'A'),
(482, 'Proveedor', 'MAZALY', 'RUC', '', '', '', '', 'AV LA PAZ #1411 S/MIGUEL', '517818', '', '', 'A'),
(483, 'Proveedor', 'INTERNATIONAL DISTRIB.', 'RUC', '', '', '', '', 'CALLE UNO 461  CORPAC SAN ISIDRO', 'FAX(5114)417127', '', '', 'A'),
(484, 'Proveedor', 'MASTER VISION EIRL', 'RUC', '', '', '', '', 'JR CRUZADO 647 - LIMA 12', '437-4563', '', '', 'A'),
(485, 'Proveedor', 'KEMI FARMA', 'RUC', '', '', '', '', 'AV AVIACION 1516 LA VICTORIA', '751042-712973', '', '', 'A'),
(486, 'Proveedor', 'BIABIC EIRL', 'RUC', '', '', '', '', 'DIEZ CANSECO 150 OF.403-404 MIRAFLORES', '444-4653', '', '', 'A'),
(487, 'Proveedor', 'OMNIUN IMPORT EXPORT SRL', 'RUC', '', '', '', '', 'SAN ISIDRO', '423869/426374', '', '', 'A'),
(488, 'Proveedor', 'IVAX PERU S.A.', 'RUC', '', '', '', '', 'CALLE CAPPA 193 - PQ.INTERN.IND.Y COMER.', '4510485/4647640', '', '', 'A'),
(489, 'Proveedor', 'IBESA', 'RUC', '', '', '', '', 'AV BOLIVAR 1337 PUEBLO LIBRE', '61-4620', '', '', 'A'),
(490, 'Proveedor', 'UNITED PHARMACEUTICAL DEL PERU', 'RUC', '', '', '', '', 'AV ROCA Y BOLOGNA 809 - URB LA AURORA', '4476391-4462903', '', '', 'A'),
(491, 'Proveedor', 'UNION FARMACEUTICA NACIONAL', 'RUC', '', '', '', '', 'CALLE 16 LA FLORIDA RIMAC', '811690', '', '', 'A'),
(492, 'Proveedor', 'SUNDOWN DROGUERIA', 'RUC', '', '', '', '', 'STO DOMINGO 110 JESUS MARIA', '634499', '', '', 'A'),
(493, 'Proveedor', 'NUTRI SPORT', 'RUC', '', '', '', '', 'AV BUENA VISTA 101 CHACARILLA S.BORJA', '436-6639', '', '', 'A'),
(494, 'Proveedor', 'CIA ARBO', 'RUC', '', '', '', '', 'AV.SANTA CRUZ 781 LIMA', '462206', '', '', 'A'),
(495, 'Proveedor', 'ATS REPRESENTACIONES', 'RUC', '', '', '', '', 'AV CONDE DE LA MONCLOVA 193 S.ISIDRO', '4456351-4991199', '', '', 'A'),
(496, 'Proveedor', 'REPRESENTAC.GENERALES', 'RUC', '', '', '', '', 'AV MARIATEGUI 1579 - JESUS MARIA', '', '', '', 'A'),
(497, 'Proveedor', 'ABAFAR DISTRIBUIDORA', 'RUC', '', '', '', '', 'GRAL.IGLESIAS 330 MIRAFLORES', '2421388 2413719', '', '', 'A'),
(498, 'Proveedor', 'VARIOS', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(499, 'Proveedor', 'COMERCIO EXTERIOR DIST.', 'RUC', '', '', '', '', 'PJE CONOCOCHA 1807 - LINCE', '471-4686', '', '', 'A');
INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion_departamento`, `direccion_provincia`, `direccion_distrito`, `direccion_calle`, `telefono`, `email`, `numero_cuenta`, `estado`) VALUES
(500, 'Proveedor', 'DICOSA', 'RUC', '', '', '', '', 'CALLE INBA RIPAC 395 - JESUS MARIA', '4638228-4631931', '', '', 'A'),
(501, 'Proveedor', 'NUK PRODUCTOS.P/BEBES', 'RUC', '', '', '', '', 'GERMANY/', '', '', '', 'A'),
(502, 'Proveedor', 'EDCEISA', 'RUC', '', '', '', '', 'URB LAS ACACIAS LA MOLINA', '435-4169', '', '', 'A'),
(503, 'Proveedor', 'LAFARCOSA', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(504, 'Proveedor', 'VICENTE MORALES DIST.', 'RUC', '', '', '', '', 'JR JUNIN 299 - MIRAFLORES', '4445135-4456083', '', '', 'A'),
(505, 'Proveedor', 'DROGUERIA DEL SUR', 'RUC', '', '', '', '', 'LOS OLMOS 102 - RESID.SAN FELIPE', 'TELFAX 463-2100', '', '', 'A'),
(506, 'Proveedor', 'NORDIGESA', 'RUC', '20133550292', '', '', '', 'AV. AMERICA OESTE N 201-URB. LOS CEDROS', '254762/254334', '', '', 'A'),
(507, 'Proveedor', 'EMPRESA COMERCIAL DEL PERU', 'RUC', '', '', '', '', 'AV JOSE PARDO 620 OF 203 MIRAFLORES', '4469747/4469131', '', '', 'A'),
(508, 'Proveedor', 'RSP PHARMA', 'RUC', '', '', '', '', 'LA MOLINA URB. CAPILLA F-15', '365-0952', '', '', 'A'),
(509, 'Proveedor', 'TRANSF.QUIMICA DEL PERU S.R.L', 'RUC', '', '', '', '', 'AV. LOS PROCERES N.125 RIMAC', '381-4246', '', '', 'A'),
(510, 'Proveedor', 'LAS PONCIANAS S.A', 'RUC', '', '', '', '', 'AV. AREQUIPA 4499 MIRAFLORES', '444-8330', '', '', 'A'),
(511, 'Proveedor', 'PERFUMERIAS UNIDAS', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(512, 'Proveedor', 'RAMELI E.I.R.L', 'RUC', '', '', '', '', 'CORONEL NORIEGA 141 CHORILLOS', '467-5956', '', '', 'A'),
(513, 'Proveedor', 'BRISTOL CONSUMO', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(514, 'Proveedor', 'DIMESI S.A.', 'RUC', '', '', '', '', 'JR. PEDRO RUIZ GALLO 251 PUEBLO LIBRE', '4232993/4234300', '', '', 'A'),
(515, 'Proveedor', 'DICONOR E.I.R.L.', 'RUC', '', '', '', '', 'PADEREWSKY 775 URB. PRIMAVERA', '26-1197/24-2040', '', '', 'A'),
(516, 'Proveedor', 'PROQUIFARMA S.C.R.L.', 'RUC', '', '', '', '', 'AV. NICOLAS DE PIEROLA 1080', '263163/205225', '', '', 'A'),
(517, 'Proveedor', 'DISFARMA S.A', 'RUC', '', '', '', '', 'AV.LARCO 640 URB SAN ANDRES TRUJILLO', '261540/261412', '', '', 'A'),
(518, 'Proveedor', 'DIST. SAN JUAN S.R.LTDA', 'RUC', '', '', '', '', 'MZ. 52 L-12 URB LA RINCONADA', '216990', '', '', 'A'),
(519, 'Proveedor', 'DIST FARM. TRUJILLO S.R.L.', 'RUC', '', '', '', '', 'AYACUCHO 952', '245381', '', '', 'A'),
(520, 'Proveedor', 'CODIZA S.A.C.', 'RUC', '', '', '', '', 'MARCELO CORNE 287 URB SAN ANDRES', '203175', '', '', 'A'),
(521, 'Proveedor', 'ASA ALIMENTOS S.A', 'RUC', '', '', '', '', 'GRAU 555 URB CAMPODONICO CHICLAYO', '226484', '', '', 'A'),
(522, 'Proveedor', 'INKAS FARMA', 'RUC', '', '', '', '', 'JR. GAMARRA 770 - TRUJILLO', '201619', '', '', 'A'),
(523, 'Proveedor', 'BOTICA ARCANGEL', 'RUC', '', '', '', '', 'JR. BOLIVAR', '', '', '', 'A'),
(524, 'Proveedor', 'CASTRO RODRIGUEZ JOSE', 'RUC', '', '', '', '', 'JR. JOAQUIN OLMEDO 331 - TRUJILLO', '254513', '', '', 'A'),
(525, 'Proveedor', 'MEDICAMENTOS POR VENCER', 'RUC', '10179901671', '', '', '', 'BOTICA VIGEN DEL CARMEN-EUCALPITOS N 131', '433351-433214', '', '', 'A'),
(526, 'Proveedor', 'FARMACOS DEL NORTE', 'RUC', '', '', '', '', 'AV. FATIMA N 542 - URB. CALIFORNIA', '283323 - 284136', '', '', 'A'),
(527, 'Proveedor', 'COMERCIALIZADORA "LANDER"', 'RUC', '', '', '', '', 'URB. LOS CEDROS - TRUJILLO', '201424', '', '', 'A'),
(528, 'Proveedor', 'DIPROFAN EIRL', 'RUC', '', '', '', '', 'CAL.MEAVE SEMINARIO 624 LAS QUINTANA', '250244/', '', '', 'A'),
(529, 'Proveedor', 'DIST. MONSANTI S.A.C.', 'RUC', '', '', '', '', 'SANTOS CHOCANO # 611 PALERMO', 'FAX 293690', '', '', 'A'),
(530, 'Proveedor', 'DISA E.I.R.L.', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(531, 'Proveedor', 'MARFAN S.A.C.', 'RUC', '', '', '', '', 'TUPAC AMARU 2746 PUEBLO LIBRE LIMA PERU', '4602295', '', '', 'A'),
(532, 'Proveedor', 'DIFARLIB SRL', 'RUC', '', '', '', '', 'LAS MORAS 150 SAN ANDRES QUINTA ETAP', '288230', '', '', 'A'),
(533, 'Proveedor', 'LAB.FARM. PERUANO GERMANO', 'RUC', '', '', '', '', 'AV.REPUBLICA DE PANAMA 1773', '472-0497', '', '', 'A'),
(534, 'Proveedor', 'OM PERU S.A.', 'RUC', '', '', '', '', 'RICARDO REY BASADRE 385 LIMA 17', '4615690', '', '', 'A'),
(535, 'Proveedor', 'LAFISA', 'RUC', '', '', '', '', 'MZ C3 LOTE 6 MONSERRATE 4TA ETAPA', '294467', '', '', 'A'),
(536, 'Proveedor', 'DROGUERIA ELIFARMA', 'RUC', '', '', '', '', 'LAS TURQUESAS 364 BALCONCILLO-LA VIC', '2654145/2653271', '', '', 'A'),
(537, 'Proveedor', 'DIST.CARRILLO E.I.R.L', 'RUC', '2035423346', '', '', '', 'AV.VICTOR RAUL 464-A VISTA ALEGRE', '281719', '', '', 'A'),
(538, 'Proveedor', 'DISVAC S.A.C.', 'RUC', '2044014394', '', '', '', 'SAN MATEO 326 URB. SAN ANDRES', 'TELEFAX 420268', '', '', 'A'),
(539, 'Proveedor', 'JPS DISTRIBUCIONES E.I.R.L.', 'RUC', '20440180044', '', '', '', 'JR. AYACUCHO 952 2DO PISO-OFICINA 3', '297187', '', '', 'A'),
(540, 'Proveedor', 'DMP DIMEFARNOR E.I.R.L.', 'RUC', '', '', '', '', 'URB.MANUEL AREVALO MZ"C17"LTE"54"IIIETAP', '271587-9668159', '', '', 'A'),
(541, 'Proveedor', 'J.A.C. REPRESENT. S.C.R.LTA', 'RUC', '', '', '', '', 'LOS CANARIOS B5 ALAMEDA SAN ANDRES', '281489', '', '', 'A'),
(542, 'Proveedor', 'LABORATORIOS PAVIL', 'RUC', '', '', '', '', 'SANTIAGO DE SURCO 3381 CHAMA-SURCO', '4485582/4486608', '', '', 'A'),
(543, 'Proveedor', 'MILENIUM REPRESENT S.R.L.', 'RUC', '2043913433', '', '', '', 'APURIMAC 164-166 PALERMO', '213943', '', '', 'A'),
(544, 'Proveedor', 'MEDCO SAC', 'RUC', '', '', '', '', 'AV.FATIMA 542-URB CALIFORNIA/TRUJILL', '', '', '', 'A'),
(545, 'Proveedor', 'DEUTSCHE PHARMA S.A.', 'RUC', '', '', '', '', 'JR.LAS AGATAS 129 BALCONCILLO', '472-0497', '', '', 'A'),
(546, 'Proveedor', 'RAMBAXY P.R.P.PERU SAC', 'RUC', '2045982165', '', '', '', 'AV.JUAN DE ARONA 761-765 SAN ISIDRO', '441-4553', '', '', 'A'),
(547, 'Proveedor', 'MONSANTI SAC.', 'RUC', '', '', '', '', 'SANTOS CHOCANO 611 PALERMO', '044-293690', '', '', 'A'),
(548, 'Proveedor', 'DROG. JALYSON EIRL', 'RUC', '2043128892', '', '', '', 'URB. PORTALES DE JAVIER PRADO ATE', 'FAX 351-3566', '', '', 'A'),
(549, 'Proveedor', 'FARMAVAL PERU S.A.', 'RUC', '', '', '', '', 'AV.OLAVEGOYA 1879-JESUS MARIA', '', '', '', 'A'),
(550, 'Proveedor', 'GUZMAN DISTBUCIONES SAC', 'RUC', '', '', '', '', 'CESAR VALLEJO 449-451 PALERMO', '232616', '', '', 'A'),
(551, 'Proveedor', 'DROGUERIA LABORATORIO FARVET', 'RUC', '', '', '', '', 'VICTORIANO CASTILLO 141-MIRAFLORES', '273-0979', '', '', 'A'),
(552, 'Proveedor', 'M.G.ROCSA S.A.', 'RUC', '2042791911', '', '', '', 'AV.BOLIVAR 2100-PUEBLO LIBRE', '', '', '', 'A'),
(553, 'Proveedor', 'PHARBAL S.A.', 'RUC', '2015777796', '', '', '', 'TRINIDAD MORAN 1268 LIMA 14', '440-7962', '', '', 'A'),
(554, 'Proveedor', 'LABORATORIOS COLLIERE S.A.', 'RUC', '', '', '', '', 'AV.BOLIVAR 613 PUEBLO LIBRE', '4630101', '', '', 'A'),
(555, 'Proveedor', 'MKS UNIDOS S.A.', 'RUC', '', '', '', '', 'AV.SEPARADORA INDUSTRIAL 487 ATE VIT', '326-5780', '', '', 'A'),
(556, 'Proveedor', 'BVC EUCALIPTOS', 'RUC', '10179901671', '', '', '', 'EUCALIPTOS 131 CAA GRANDE', '433351-433214', '', '', 'A'),
(557, 'Proveedor', 'BVC CHOCOPE', 'RUC', '10179901671', '', '', '', 'DIEGO DE MORA 204 CHOCOPE', '044-316070', '', '', 'A'),
(558, 'Proveedor', 'BVC CALLE TREN', 'RUC', '10179901671', '', '', '', '', '', '', '', 'A'),
(559, 'Proveedor', 'BVC', 'RUC', '', '', '', '', '', '', '', '', 'A'),
(560, 'Proveedor', 'AR DISTRIBUCIONES', 'RUC', '20398058390', '', '', '', 'LAS ESMERALDAS 165 LA RINCONADA TRUJ', '425094', '', '', 'A'),
(561, 'Proveedor', 'EMBOTELLADORA RIVERA S.A.', 'RUC', '20102725647', '', '', '', 'PAN. SUR KM 604 CHOCOPE', '542100', '', '', 'A'),
(562, 'Proveedor', 'HERSIL S.A.', 'RUC', '10100060150', '', '', '', 'AV.LOS FRUTALS 220 ATE VITARTE LIMA', '4359377/4359604', '', '', 'A'),
(563, 'Proveedor', 'LAB.STIEFEL PERU S.A.', 'RUC', '20297616391', '', '', '', 'AV. PRIMAVERA 1245  SURCO LIMA', '437-1899', '', '', 'A'),
(564, 'Proveedor', 'DISTRIBUIDORA DIESSA', 'RUC', '', '', '', '', 'PSJE STA ROSA 186-TRUJILLO', '299199', '', '', 'A'),
(565, 'Proveedor', 'REPREX SAC', 'RUC', '20439047799', '', '', '', 'HUASCAR 252 STA MARIA', '292723', '', '', 'A'),
(566, 'Proveedor', 'DIMEPHARMA SRL', 'RUC', '', '', '', '', 'OSCAR BENAVIDES 3386A BELLAVIS CALLA', '4526357 FAX', '', '', 'A'),
(567, 'Proveedor', 'GOLONORTE SA', 'RUC', '20391165883', '', '', '', 'TUMALINA 901 LOS CEDROS TRUJILLO', '', '', '', 'A'),
(568, 'Proveedor', 'COPYVENTAS SRL', 'RUC', '20132051322', '', '', '', 'COLON 202/GAMARRA 731/J.OLMEDO 204', '260479/252382', '', '', 'A'),
(569, 'Proveedor', 'CONSORCIO AMERICA SAC', 'RUC', '20440363536', '', '', '', 'JOAQUIN OLMEDO 375 PALERMO', '290218/221519', '', '', 'A'),
(570, 'Proveedor', 'TEMY SAC', 'RUC', '20506196991', '', '', '', 'PASAJE LARREA 100 MOCHE TRUJILLO', '207692', '', '', 'A'),
(571, 'Proveedor', 'BOTIQUIN STA CLARA', 'RUC', '', '', '', '', 'STA CLARA', '', '', '', 'A'),
(572, 'Proveedor', 'DILVISA', 'RUC', '20183040406', '', '', '', 'JUAQUIN OLMEDO N 239-PALERMO', '202511-201039', '', '', 'A'),
(573, 'Proveedor', 'ALMAPO S.R.L.', 'RUC', '20132345237', '', '', '', 'AV. CESAR VALLEJO N  278', '205635 - 246056', '', '', 'A'),
(574, 'Proveedor', 'KEY MARK S.A.C.', 'RUC', '20439253852', '', '', '', 'JR. LEONIDAS YEROVI N  268', '246056', '', '', 'A'),
(575, 'Proveedor', 'DRODICOME', 'RUC', '20105352477', '', '', '', 'JR LOS PINOS 139 MIGUEL GRAU PIURA', '304499', '', '', 'A'),
(576, 'Proveedor', 'COMERCIALLIZADORA SALEM S.A.C.', 'RUC', '20504208843', '', '', '', 'AV.METROPOLITANA S/N SAN ISIDRO', '203511-292842', '', '', 'A'),
(577, 'Proveedor', 'LABOT. DROGUERIA INTI PERU', 'RUC', '20475592272', '', '', '', 'AV. CAMINOS DEL INCA N 1643-SURCO', '051-1-279-0543', '', '', 'A'),
(578, 'Proveedor', 'LABORATORIO TRIFARMA S.A.', 'RUC', '', '', '', '', 'AV. STA ROSA N 390-URB.AURORA VITART', '3261202-3261449', '', '', 'A'),
(579, 'Proveedor', 'FARMAQUIL PERU S.A.C', 'RUC', '', '', '', '', 'JR. MATEO AGUILAR N 220-S.M.P', '5341219', '', '', 'A'),
(580, 'Proveedor', 'DISMAR E.I.R.L.', 'RUC', '20314388535', '', '', '', 'AV. MIRAFLORES N 1810-URB.STA AVILA', '215111', '', '', 'A'),
(581, 'Proveedor', 'OMNILIFE PERU S.A.C.', 'RUC', '20290314799', '', '', '', 'AV JOSE GALVEZ BARRENECHEA 298 LIMA', '4115200', '', '', 'A'),
(582, 'Proveedor', 'ASBLUNET S.A.C.', 'RUC', '20503917107', '', '', '', 'AV ESPAÃ‘A N 2212 of 202', '291767', '', '', 'A'),
(584, 'Proveedor', 'M.D.P. MEDIPHARLIB', 'RUC', '10182245114', '', '', '', 'CONDORCANQUI N 2090-LA ESPERANZA', '323474', '', '', 'A'),
(585, 'Proveedor', 'ALMACEN VENCIDOS-BVC', 'RUC', '10179901671', '', '', '', 'EUCALIPTOS 131-B CASA GRANDE', '433351-433214', '', '', 'A'),
(586, 'Proveedor', 'INVELAP E.I.R.L.', 'RUC', '20395693027', '', '', '', 'CALLE LETICIA 207-CHICLAYO', '014-440627', '', '', 'A'),
(587, 'Proveedor', 'CODINSA S.A.C.', 'RUC', '20439505924', '', '', '', 'AV. ESPAÃ‘A 2524 2DO PISO TRUJILLO', '207959-298014', '', '', 'A'),
(588, 'Proveedor', 'PHARMACEUTICAL CORPORATION SAC', 'RUC', '20502184491', '', '', '', 'PJE PROVENIR 150 OF 401 MIRAFLORES', '445-6467', '', '', 'A'),
(589, 'Proveedor', 'NORTFARMA SAC (BOT. FELICIDAD)', 'RUC', '20399497257', '', '', '', 'BOLOGNESI 678 TRUJILLO', '', '', '', 'A'),
(590, 'Proveedor', 'ALFARO DISTRIBUIDORA', 'RUC', '', '', '', '', 'URB. SAN ANDRES SAN MATEO 326', '420268-9663077', '', '', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presentacion`
--

CREATE TABLE `presentacion` (
  `idpresentacion` mediumint(9) NOT NULL,
  `descripcion` varchar(20) NOT NULL,
  `abreviacion` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `presentacion`
--

INSERT INTO `presentacion` (`idpresentacion`, `descripcion`, `abreviacion`) VALUES
(2, 'Tubo', 'Tbo'),
(3, 'Caja', 'Caj');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `idsucursal` int(11) NOT NULL,
  `razon_social` varchar(150) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(70) DEFAULT NULL,
  `representante` varchar(150) DEFAULT NULL,
  `logo` varchar(50) DEFAULT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`idsucursal`, `razon_social`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `representante`, `logo`, `estado`) VALUES
(1, 'Farmacia Rezola S.A.C. - San Vicente', 'RUC', '477157771', 'Lima - CaÃ±ete - San Vicente', '96358745', 'rezola@gmail.com', 'Eduardo', 'Files/Sucursal/suc-mexicodf.png', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `idtipo_documento` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `operacion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`idtipo_documento`, `nombre`, `operacion`) VALUES
(1, 'RUC', 'Persona'),
(2, 'DNI', 'Persona'),
(3, 'TICKET', 'Comprobante'),
(5, 'NIC', 'Persona'),
(6, 'FACTURA', 'Comprobante'),
(7, 'BOLETA', 'Comprobante'),
(8, 'CEDULA', 'Persona'),
(9, 'GUIA-REMISION', 'Comprobante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medida`
--

CREATE TABLE `unidad_medida` (
  `idunidad_medida` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `prefijo` varchar(5) NOT NULL,
  `estado` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `unidad_medida`
--

INSERT INTO `unidad_medida` (`idunidad_medida`, `nombre`, `prefijo`, `estado`) VALUES
(1, 'Unidad', 'Und', 'A'),
(2, 'Caja', 'Cja', 'A'),
(3, 'Paquete', 'Pqt', 'A'),
(4, 'Metro', 'Mt', 'A'),
(5, 'Docena', 'Doc', 'A'),
(6, 'Decena', 'Dec', 'A'),
(7, 'Ciento', 'Cto', 'A'),
(8, 'Tableta', 'Tab', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idempleado` int(11) NOT NULL,
  `tipo_usuario` varchar(20) NOT NULL,
  `fecha_registro` date NOT NULL,
  `mnu_almacen` varchar(1) NOT NULL,
  `mnu_compras` varchar(1) NOT NULL,
  `mnu_ventas` varchar(1) NOT NULL,
  `mnu_mantenimiento` varchar(1) NOT NULL,
  `mnu_seguridad` varchar(1) NOT NULL,
  `mnu_consulta_compras` varchar(1) NOT NULL,
  `mnu_consulta_ventas` varchar(1) NOT NULL,
  `mnu_admin` varchar(1) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `idsucursal`, `idempleado`, `tipo_usuario`, `fecha_registro`, `mnu_almacen`, `mnu_compras`, `mnu_ventas`, `mnu_mantenimiento`, `mnu_seguridad`, `mnu_consulta_compras`, `mnu_consulta_ventas`, `mnu_admin`, `estado`) VALUES
(22, 1, 1, 'Administrador', '2016-03-03', '1', '1', '1', '1', '1', '1', '1', '1', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idpedido` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_venta` varchar(20) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `impuesto` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`),
  ADD KEY `fk_articulo_unidad_medida_idx` (`idunidad_medida`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indices de la tabla `condicion_almacenamiento`
--
ALTER TABLE `condicion_almacenamiento`
  ADD PRIMARY KEY (`idcondicion_almacenamiento`);

--
-- Indices de la tabla `credito`
--
ALTER TABLE `credito`
  ADD PRIMARY KEY (`idcredito`),
  ADD KEY `fk_credito_venta1_idx` (`idventa`);

--
-- Indices de la tabla `detalle_documento_sucursal`
--
ALTER TABLE `detalle_documento_sucursal`
  ADD PRIMARY KEY (`iddetalle_documento_sucursal`),
  ADD KEY `fk_documento_sucursal_idx` (`idtipo_documento`),
  ADD KEY `fk_detalle_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_articulo_idx` (`idarticulo`),
  ADD KEY `fk_detalle_ingreso_idx` (`idingreso`);

--
-- Indices de la tabla `detalle_movimiento_stock`
--
ALTER TABLE `detalle_movimiento_stock`
  ADD PRIMARY KEY (`iddetalle_movimiento`),
  ADD KEY `iddetalle_movimiento` (`iddetalle_movimiento`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`iddetalle_pedido`),
  ADD KEY `fk_detalle_venta_ingreso_idx` (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_venta_idx` (`idpedido`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idempleado`);

--
-- Indices de la tabla `forma_farmaceutica`
--
ALTER TABLE `forma_farmaceutica`
  ADD PRIMARY KEY (`idforma_farmaceutica`);

--
-- Indices de la tabla `global`
--
ALTER TABLE `global`
  ADD PRIMARY KEY (`idglobal`),
  ADD UNIQUE KEY `empresa_UNIQUE` (`empresa`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_proveedor_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`),
  ADD KEY `fk_ingreso_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `movimiento_stock`
--
ALTER TABLE `movimiento_stock`
  ADD PRIMARY KEY (`idmovimiento`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`idpedido`),
  ADD KEY `fk_venta_cliente_idx` (`idcliente`),
  ADD KEY `fk_venta_trabajador_idx` (`idusuario`),
  ADD KEY `fk_pedido_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `presentacion`
--
ALTER TABLE `presentacion`
  ADD PRIMARY KEY (`idpresentacion`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`idsucursal`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`idtipo_documento`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  ADD PRIMARY KEY (`idunidad_medida`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD KEY `fk_usuario_empleado_idx` (`idempleado`),
  ADD KEY `fk_usuario_sucursal_idx` (`idsucursal`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_pedido_idx` (`idpedido`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4568;
--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT de la tabla `condicion_almacenamiento`
--
ALTER TABLE `condicion_almacenamiento`
  MODIFY `idcondicion_almacenamiento` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `credito`
--
ALTER TABLE `credito`
  MODIFY `idcredito` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `detalle_documento_sucursal`
--
ALTER TABLE `detalle_documento_sucursal`
  MODIFY `iddetalle_documento_sucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT de la tabla `detalle_movimiento_stock`
--
ALTER TABLE `detalle_movimiento_stock`
  MODIFY `iddetalle_movimiento` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `iddetalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idempleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `forma_farmaceutica`
--
ALTER TABLE `forma_farmaceutica`
  MODIFY `idforma_farmaceutica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `global`
--
ALTER TABLE `global`
  MODIFY `idglobal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT de la tabla `movimiento_stock`
--
ALTER TABLE `movimiento_stock`
  MODIFY `idmovimiento` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `idpedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=591;
--
-- AUTO_INCREMENT de la tabla `presentacion`
--
ALTER TABLE `presentacion`
  MODIFY `idpresentacion` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `idsucursal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `idtipo_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  MODIFY `idunidad_medida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_articulo_unidad_medida` FOREIGN KEY (`idunidad_medida`) REFERENCES `unidad_medida` (`idunidad_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `credito`
--
ALTER TABLE `credito`
  ADD CONSTRAINT `fk_credito_venta1` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_documento_sucursal`
--
ALTER TABLE `detalle_documento_sucursal`
  ADD CONSTRAINT `fk_detalle_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_documento_sucursal` FOREIGN KEY (`idtipo_documento`) REFERENCES `tipo_documento` (`idtipo_documento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `fk_detalle_pedido` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_pedido_ingreso` FOREIGN KEY (`iddetalle_ingreso`) REFERENCES `detalle_ingreso` (`iddetalle_ingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_proveedor` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_trabajador` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_empleado` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_pedido` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
