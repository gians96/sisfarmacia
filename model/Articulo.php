<?php
	require "Conexion.php";

	class Articulo{
	
		
		public function __construct(){
		}

		public function Registrar($idcategoria, $idunidad_medida, $nombre, $descripcion,$idlaboratorio,$unidad){
			global $conexion;
			$sql = "INSERT INTO articulo(idcategoria, idunidad_medida, nombre, descripcion, estado,idlaboratorio,unidad) VALUES($idcategoria, $idunidad_medida, '$nombre', '$descripcion', 'A',$idlaboratorio,$unidad)";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Modificar($idarticulo, $idcategoria, $idunidad_medida, $nombre, $descripcion,$idlaboratorio,$unidad){
			global $conexion;
			$sql = "UPDATE articulo set idcategoria = $idcategoria, idunidad_medida = $idunidad_medida, nombre = '$nombre',
						descripcion = '$descripcion'  ,idlaboratorio=$idlaboratorio,unidad=$unidad
						WHERE idarticulo = $idarticulo";
			$query = $conexion->query($sql);
			return $query;
		}
		
		public function Eliminar($idarticulo){
			global $conexion;
			$sql = "UPDATE articulo set estado = 'N' WHERE idarticulo = $idarticulo";
			$query = $conexion->query($sql);
			return $query;
		}

	// 	public function Listar(){
	// 		global $conexion;
	// 		$sql = "select a.*, c.nombre as categoria, um.nombre as unidadMedida 
	// from articulo a inner join categoria c on a.idcategoria = c.idcategoria
	// inner join unidad_medida um on a.idunidad_medida = um.idunidad_medida where a.estado = 'A' order by idarticulo desc";
	// 		$query = $conexion->query($sql);
	// 		return $query;
	// 	}


		public function Listar(){//nueva lista
			global $conexion;



			$sql = 	"SELECT 	a.idarticulo as IdArticulo,     
		a.nombre as Nombre,     
        a.descripcion as Descripcion,
        a.unidad,    
        a.idcategoria as idcategoria,
        a.idlaboratorio as idlaboratorio,
        p.nombre as laboratorio,
        c.nombre as Categoria,    
        a.idunidad_medida as IdUnidad_Medida,     
        um.nombre as Unidad_Medida,    
        um.prefijo as Prefijo,  
        a.estado as estado 
FROM 	`articulo` a, 		
		categoria c,         
        unidad_medida um,
        persona p
WHERE a.`idcategoria`=c.idcategoria and	  
	a.`idunidad_medida`=um.idunidad_medida and 
    a.idlaboratorio=p.idpersona and
    p.tipo_persona='Laboratorio' and
    a.estado='A'      
order by a.idarticulo ASC  ";
			$query = $conexion->query($sql);

			return $query;
		}

		public function Reporte(){
			global $conexion;
			$sql = "select a.*, c.nombre as categoria, um.nombre as unidadMedida 
	from articulo a inner join categoria c on a.idcategoria = c.idcategoria
	inner join unidad_medida um on a.idunidad_medida = um.idunidad_medida where a.estado = 'A' order by a.nombre asc";
			$query = $conexion->query($sql);
			return $query;
		}

	}
