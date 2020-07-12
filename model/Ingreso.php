<?php
require "Conexion.php";

class Ingreso{
	
	public function Registrar($idusuario, $idsucursal, $idproveedor,$idlaboratorio, $tipo_comprobante, $serie_comprobante, $num_comprobante, $impuesto, $total,$fecha_emision, $detalle){
		global $conexion;
		$sw = true;
		try {

			
			$sql = "INSERT INTO ingreso(idusuario, idsucursal, idproveedor,idlaboratorio, tipo_comprobante, serie_comprobante, num_comprobante, fecha, impuesto,
			total,fecha_emision, estado) 
			VALUES($idusuario, $idsucursal, $idproveedor, $idlaboratorio,'$tipo_comprobante', '$serie_comprobante', '$num_comprobante', curdate(), $impuesto, $total,'$fecha_emision', 'A')";
				//var_dump($sql);
			$conexion->query($sql);	
			$idingreso=$conexion->insert_id;		

			$conexion->autocommit(true);
			foreach($detalle as $indice => $valor){
				$sql_detalle = "INSERT INTO detalle_ingreso(idingreso, 
				idarticulo,
				codigo, 
				serie, 

				fecha_vencimiento,
				idforma_farmaceutica,
				idpresentacion,
				idcondicion_almacenamiento,
				stock_ingreso,
				stock_actual,
				stock_unidad,
				precio_compra,
				precio_ventadistribuidor,
				idlaboratorio,
				precio_ventapublico)
				VALUES($idingreso, 
				".$valor[0].", 
				'".$valor[1]."', 
				'".$valor[2]."', 

				'".$valor[4]."', 
				".$valor[5].", 
				".$valor[6].", 
				".$valor[7].",
				".$valor[8].", 
				".$valor[9].", 
				".$valor[11].", 
				".$valor[10].",
				".$valor[12].",
				".$valor[13].",
				".$valor[14].")";
				$conexion->query($sql_detalle) or $sw = false;
			}
			if ($conexion != null) {
				$conexion->close();
			}
		} catch (Exception $e) {
			$conexion->rollback();
		}
		return $sw;
	}


	public function modificar($idingreso,$referencia,$observacion,$idusuario, $detalle){
		global $conexion;
		$sw = true;
		try {



			$sql = "INSERT INTO movimiento_stock(
			idingreso,
			referencia,
			observacion, 
			fecha, 
			idusuario,
			estado) 
			VALUES ($idingreso,
			'$referencia',
			'$observacion',
			CURRENT_TIMESTAMP,
			$idusuario,
			'1')";
				//var_dump($sql);
			$conexion->query($sql);	
			$idmovimiento=$conexion->insert_id;		

			$conexion->autocommit(true);
			foreach($detalle as $indice => $valor){
				$sql_detalle = "INSERT INTO detalle_movimiento_stock(idmovimiento,
				iddetalle_ingreso,
				stockact_antes,
				stockact_despues, 
				ventapublico_antes, 
				ventapublico_despues,
				stockuni_antes,
				stockuni_despues
				) 
				VALUES ($idmovimiento,
				".$valor[15].",
				(select stock_actual from detalle_ingreso WHERE iddetalle_ingreso= ".$valor[15]."),
				".$valor[9].",
				(select precio_ventapublico from detalle_ingreso WHERE iddetalle_ingreso= ".$valor[15]."),
				".$valor[14].",
				(select stock_unidad from detalle_ingreso WHERE iddetalle_ingreso= ".$valor[15]."),
				".$valor[11]."
			)";
			$conexion->query($sql_detalle) or $sw = false;
		}

		foreach($detalle as $indice => $valor){
			$sql_detalle = "UPDATE detalle_ingreso
			SET 
			stock_actual=".$valor[9].",
			stock_unidad=".$valor[11].",
			
			precio_ventapublico=".$valor[14]."
			WHERE `iddetalle_ingreso`=".$valor[15].";";
			$conexion->query($sql_detalle) or $sw = false;
		}



		if ($conexion != null) {
			$conexion->close();
		}
	} catch (Exception $e) {
		$conexion->rollback();
	}
	return $sw;
}

public function Listar($idsucursal){
	global $conexion;
	$sql = "


	select i.idingreso,
	i.idusuario,
	i.idsucursal,
	s.razon_social,
	i.idproveedor,
	p1.nombre as proveedor,
	i.idlaboratorio,
	p2.nombre as laboratorio,
	i.tipo_comprobante,
	i.serie_comprobante,
	i.num_comprobante,
	i.fecha_emision,
	i.impuesto,
	i.total,
	i.estado 
	FROM ingreso i INNER JOIN persona p1  on i.idproveedor=p1.idpersona
	inner join persona p2 on i.idlaboratorio=p2.idpersona
	inner join sucursal s on i.idsucursal=s.idsucursal

	WHERE i.idsucursal=$idsucursal 
	order by i.fecha DESC";
	$query = $conexion->query($sql);
	return $query;
}

public function CambiarEstado($idingreso){
	global $conexion;
	$sql = "UPDATE ingreso set estado = 'C'
	WHERE idingreso = $idingreso";
	$query = $conexion->query($sql);
	return $query;
}

public function GetDetalleArticulo($idingreso){
	global $conexion;
	$sql = "select di.iddetalle_ingreso, 
	di.idingreso, 
	di.idarticulo,
	a.nombre as articulo,
	a.descripcion as nombreGeneral,
	a.unidad ,
	pe.nombre as laboratorioa,
	di.codigo, 
	di.serie,
	di.descripcion,
	di.stock_ingreso,
	di.stock_actual,
	di.stock_unidad,
	di.precio_compra,
	di.precio_ventadistribuidor,
	pe1.nombre as laboratorioas,
	
	di.precio_ventapublico,
	di.fecha_vencimiento,
	di.idforma_farmaceutica,
	ff.descripcion as forma_farmaceutica,
	ff.abreviacion as abrevivacionff ,
	di.idpresentacion,
	p.descripcion as presentacion,
	p.abreviacion as abreviacionp,
	di.idcondicion_almacenamiento,
	ca.descripcion as condicion_almacenamiento,
	ca.abreviacion as abreviacionca,
	(di.stock_ingreso*di.precio_compra) as sub_total 

	FROM detalle_ingreso di,
	articulo a,
	forma_farmaceutica ff,
	presentacion p,
	condicion_almacenamiento ca,
	persona pe,
	persona pe1
	WHERE di.idarticulo=a.idarticulo and  
	di.idforma_farmaceutica=ff.idforma_farmaceutica AND
	di.idpresentacion=p.idpresentacion AND 
	pe1.idpersona=di.idlaboratorio and
	di.idcondicion_almacenamiento=ca.idcondicion_almacenamiento AND 
	a.idlaboratorio = pe.idpersona AND
	di.idingreso=$idingreso 
	";
	$query = $conexion->query($sql);
	return $query;
}

public function GetProveedorSucursalIngreso($idingreso){
	global $conexion;
	$sql = "select s.razon_social, s.tipo_documento as documento_sucursal, s.num_documento as num_sucursal, s.direccion, s.telefono as telefono_suc,s.email as email_suc, s.representante, s.logo,i.idingreso,i.idusuario,i.idsucursal,i.idproveedor,p1.nombre as proveedor,p1.tipo_documento as tipo_documentop,p1.num_documento as num_documentop,p1.direccion_departamento as departamentop,p1.direccion_provincia as provinciap,p1.direccion_distrito as distritop,p1.direccion_calle as direccion_callep,p1.telefono as telefonop,p1.email as emailp,i.idlaboratorio,p2.nombre as laboratorio,p2.tipo_documento as tipo_documentol,p2.num_documento as num_documentol,p2.direccion_departamento as departamentol,p2.direccion_provincia as provincial,p2.direccion_distrito as distritol,p2.direccion_calle as direccion_callel,p2.telefono as telefonol,p2.email as emaill,i.tipo_comprobante,i.serie_comprobante,i.num_comprobante,i.fecha,i.impuesto,i.total,i.estado FROM ingreso i , persona p1, persona p2 ,sucursal s WHERE i.idingreso=$idingreso and i.idproveedor=p1.idpersona and i.idlaboratorio=p2.idpersona and s.idsucursal=i.idsucursal";
	$query = $conexion->query($sql);
	return $query;
}

public function ListarProveedor(){
	global $conexion;
	$sql = "select * from persona where tipo_persona = 'Proveedor' and estado = 'A'";
	$query = $conexion->query($sql);
	return $query;
}

public function ListarLaboratorio(){
	global $conexion;
	$sql = "select * from persona where tipo_persona = 'Laboratorio' and estado = 'A'";
	$query = $conexion->query($sql);
	return $query;
}

public function ListarTipoDocumento(){
	global $conexion;
	$sql = "select * from tipo_documento where operacion = 'Comprobante'";
	$query = $conexion->query($sql);
	return $query;
}

public function GetTipoDocSerieNum($nombre){
	global $conexion;
	$sql = "select ultima_serie, ultimo_numero from tipo_documento where operacion = 'Comprobante' and nombre = '$nombre'";
	$query = $conexion->query($sql);
	return $query;
}

public function ListarProveedores(){
	global $conexion;
	$sql = "select * from persona where tipo_perssona = 'Proveedor'";
	$query = $conexion->query($sql);
	return $query;
}

}	