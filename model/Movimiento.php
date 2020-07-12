<?php
	require "Conexion.php";
	
	class Movimiento{
	
		public function Registrar($idusuario, $idsucursal, $idproveedor,$idlaboratorio, $tipo_comprobante, $serie_comprobante, $num_comprobante, $impuesto, $total, $detalle){
			global $conexion;
			$sw = true;
			try {
				
			
				$sql = "INSERT INTO ingreso(idusuario, idsucursal, idproveedor,idlaboratorio, tipo_comprobante, serie_comprobante, num_comprobante, fecha, impuesto,
						total, estado) 
						VALUES($idusuario, $idsucursal, $idproveedor, $idlaboratorio,'$tipo_comprobante', '$serie_comprobante', '$num_comprobante', curdate(), $impuesto, $total, 'A')";
				//var_dump($sql);
				$conexion->query($sql);	
				$idingreso=$conexion->insert_id;		

				$conexion->autocommit(true);
				foreach($detalle as $indice => $valor){
					$sql_detalle = "INSERT INTO detalle_ingreso(idingreso, idarticulo, codigo, serie, descripcion, fecha_vencimiento,idforma_farmaceutica,idpresentacion,idcondicion_almacenamiento,stock_ingreso, stock_actual, precio_compra, precio_ventadistribuidor, precio_ventapublico)
											VALUES($idingreso, ".$valor[0].", '".$valor[1]."', '".$valor[2]."', '".$valor[3]."', '".$valor[4]."', ".$valor[5].", ".$valor[6].", ".$valor[7].", ".$valor[8].", ".$valor[9].", ".$valor[10].", ".$valor[11].", ".$valor[12].")";
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
						        now(),
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
									    ventapublico_despues) 
                   VALUES ($idmovimiento,
                           ".$valor[13].",
                          	(select stock_actual from detalle_ingreso WHERE iddetalle_ingreso= ".$valor[13]."),
                            ".$valor[9].",
                            (select precio_ventapublico from detalle_ingreso WHERE iddetalle_ingreso= ".$valor[13]."),
                            ".$valor[12]."
                          )";
					$conexion->query($sql_detalle) or $sw = false;
				}

				foreach($detalle as $indice => $valor){
					$sql_detalle = "UPDATE detalle_ingreso
										SET 
										 	stock_actual=".$valor[9].",
										 	precio_ventapublico=".$valor[12]."
										WHERE `iddetalle_ingreso`=".$valor[13].";";
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


select m.idmovimiento, 
		i.idingreso,
        i.idsucursal,
        s.razon_social,
        s.num_documento,
        i.idusuario,
        e.nombre,
        e.apellidos,
        
        i.idproveedor,
        p1.nombre as proveedor,
        i.idlaboratorio,
        p2.nombre as laboratorio,
        i.tipo_comprobante,
        i.serie_comprobante,
        i.num_comprobante,
		m.idingreso, 
        m.referencia, 
        m.observacion, 
       DATE_FORMAT( m.fecha, '%d-%m-%Y %k:%i:%s') as fecha,
        m.estado
FROM movimiento_stock m INNER JOIN ingreso i on m.idingreso=i.idingreso
	INNER JOIN usuario u on m.idusuario=u.idusuario
    INNER JOIN empleado e on u.idempleado =e.idempleado 
    INNER JOIN persona p1 on i.idproveedor=p1.idpersona
    INNER JOIN persona p2 on i.idlaboratorio=p2.idpersona
    INNER JOIN sucursal s on i.idsucursal=s.idsucursal
ORDER by m.fecha DESC";
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

		public function GetDetalleArticulo($idMovimiento){
			global $conexion;
			$sql = "select dm.idmovimiento,
		dm.iddetalle_movimiento, 
        dm.iddetalle_ingreso,
        a.nombre as articulo,
        a.unidad,
        pe.nombre as laboratorioa,
        di.codigo as nlote,
        di.serie as rsanitario,
        ff.abreviacion as abreviacionff,
        p.abreviacion as abreviacionp,
        ca.abreviacion as abreviacionca,
        dm.stockact_antes,
        dm.stockact_despues,
        dm.ventapublico_antes,
        dm.ventapublico_despues,
        dm.stockuni_antes,
        dm.stockuni_despues

FROM detalle_movimiento_stock dm 
	INNER JOIN detalle_ingreso di on dm.iddetalle_ingreso=di.iddetalle_ingreso
    INNER JOIN articulo a on di.idarticulo=a.idarticulo
    INNER JOIN forma_farmaceutica ff on di.idforma_farmaceutica=ff.idforma_farmaceutica
    INNER JOIN presentacion p on di.idpresentacion=p.idpresentacion
   INNER JOIN condicion_almacenamiento ca on di.idcondicion_almacenamiento=ca.idcondicion_almacenamiento
	INNER JOIN persona pe on a.idlaboratorio=pe.idpersona
	WHERE dm.idmovimiento=$idMovimiento
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