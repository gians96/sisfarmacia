<?php
require "Conexion.php";

class ProgramacionPagos{
	

	public function __construct(){
	}

	public function Registrar($idSucursal, $NReferencia, $idProveedor, $fechaPago,$banco,$codigoBanco,$importe,$estado){
		global $conexion;
		$sql = "INSERT INTO programacion_pagos(idsucursal,nreferencia, idproveedor, fecha_pago, banco,codigo_unico,importe,estado) VALUES($idSucursal, '$NReferencia', $idProveedor, '$fechaPago', '$banco','$codigoBanco',$importe,'$estado')";
		$query = $conexion->query($sql);
		return $query;
	}

	public function Modificar($idProgramacionPagos ,$NReferencia, $idProveedor, $fechaPago,$banco,$codigoBanco,$importe,$estado){
		global $conexion;
		$sql = "UPDATE programacion_pagos set 
		nreferencia = '$NReferencia', 
		idproveedor = $idProveedor, 
		fecha_pago = '$fechaPago',
		banco = '$banco'  ,
		codigo_unico='$codigoBanco',
		importe=$importe,
		estado='$estado'
		WHERE idprogramacion_pagos = $idProgramacionPagos";
		$query = $conexion->query($sql);
		return $query;
	}

	public function Eliminar($idProgramacionPagos){
		global $conexion;
		$sql = "UPDATE programacion_pagos set estado = 'N' WHERE idprogramacion_pagos = $idProgramacionPagos";
		$query = $conexion->query($sql);
		return $query;
	}



		public function Listar(){//nueva lista
			global $conexion;



			$sql = 	"SELECT p.idsucursal, 
			p.idprogramacion_pagos, 

			p.nreferencia, 
			p.idproveedor, 
			p1.nombre,
			p.fecha_pago,
			p.banco,
			p.codigo_unico, 
			p.importe, 
			p.estado
			FROM programacion_pagos p INNER JOIN persona p1 on p.idproveedor=p1.idpersona
			WHERE p.estado!='N'
			order by p.fecha_pago DESC  ";
			$query = $conexion->query($sql);

			return $query;
		}

		// public function Reporte(){
		// 	global $conexion;
		// 	$sql = "select a.*, c.nombre as categoria, um.nombre as unidadMedida 
		// 	from articulo a inner join categoria c on a.idcategoria = c.idcategoria
		// 	inner join unidad_medida um on a.idunidad_medida = um.idunidad_medida where a.estado = 'A' order by a.nombre asc";
		// 	$query = $conexion->query($sql);
		// 	return $query;
		// }

	}
