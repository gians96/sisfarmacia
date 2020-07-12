<?php
	require "Conexion.php";

	class Forma_Farmaceutica{
	
		
		public function __construct(){
		}

		public function Registrar($descripcion,$abreviacion){
			global $conexion;
			$sql = "INSERT INTO forma_farmaceutica(descripcion, abreviacion)
						VALUES('$descripcion', '$abreviacion')";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Modificar($idforma, $descripcion ,$abreviacion){
			global $conexion;
			$sql = "UPDATE forma_farmaceutica set descripcion = '$descripcion',abreviacion='$abreviacion'
						WHERE idforma_farmaceutica = $idforma";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Eliminar($idForma){
			global $conexion;
			$sql = "DELETE FROM forma_farmaceutica WHERE idforma_farmaceutica = $idForma";
			$query = $conexion->query($sql);
			return $query;
		}

		public function Listar(){
			global $conexion;
			$sql = "SELECT * FROM forma_farmaceutica order by idforma_farmaceutica desc";
			$query = $conexion->query($sql);
			return $query;
		}
		public function Reporte(){
			global $conexion;
			$sql = "SELECT * FROM forma_farmaceutica order by descripcion asc";
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
