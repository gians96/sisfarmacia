<?php
	require "Conexion.php";

	class Presentacion{
	
		
		public function __construct(){
		}

		public function Registrar($descripcion,$abreviacion){
			global $conexion;
			$sql = "INSERT INTO presentacion(descripcion, abreviacion)
						VALUES('$descripcion', '$abreviacion')";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Modificar($idpresentacion, $descripcion ,$abreviacion){
			global $conexion;
			$sql = "UPDATE presentacion set descripcion = '$descripcion',abreviacion='$abreviacion'
						WHERE idpresentacion = $idpresentacion";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Eliminar($idPresentacion){
			global $conexion;
			$sql = "DELETE FROM presentacion WHERE idpresentacion = $idPresentacion";
			$query = $conexion->query($sql);
			return $query;
		}

		public function Listar(){
			global $conexion;
			$sql = "SELECT * FROM presentacion order by idpresentacion desc";
			$query = $conexion->query($sql);
			return $query;
		}
		public function Reporte(){
			global $conexion;
			$sql = "SELECT * FROM presentacion order by descripcion asc";
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
