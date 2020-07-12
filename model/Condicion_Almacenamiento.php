<?php
	require "Conexion.php";

	class Condicion_Almacenamiento{
	
		
		public function __construct(){
		}

		public function Registrar($descripcion,$abreviacion){
			global $conexion;
			$sql = "INSERT INTO condicion_almacenamiento(descripcion, abreviacion)
						VALUES('$descripcion', '$abreviacion')";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Modificar($idcondicion_almacenamiento, $descripcion ,$abreviacion){
			global $conexion;
			$sql = "UPDATE condicion_almacenamiento set descripcion = '$descripcion',abreviacion='$abreviacion'
						WHERE idcondicion_almacenamiento = $idcondicion_almacenamiento";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Eliminar($idCondicion_Almacenameinto){
			global $conexion;
			$sql = "DELETE FROM condicion_almacenamiento WHERE idcondicion_almacenamiento = $idCondicion_Almacenameinto";
			$query = $conexion->query($sql);
			return $query;
		}

		public function Listar(){
			global $conexion;
			$sql = "SELECT * FROM condicion_almacenamiento order by idcondicion_almacenamiento desc";
			$query = $conexion->query($sql);
			return $query;
		}
		public function Reporte(){
			global $conexion;
			$sql = "SELECT * FROM condicion_almacenamiento order by descripcion asc";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarUM(){
			global $conexion;
			$sql = "SELECT * FROM unidad_medida";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarSucursal(){
			global $conexion;
			$sql = "SELECT * FROM sucursal";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarEmpleado(){
			global $conexion;
			$sql = "SELECT * FROM empleado";
			$query = $conexion->query($sql);
			return $query;
		}

		public function VerNoticiaCategoria(){
			global $conexion;
			$sql = "select * from categoria
	where nombre = 'Noticias' or nombre = 'Noticia' or nombre = 'noticia' or nombre = 'noticias'";
			$query = $conexion->query($sql);
			return $query;
		}

	}
