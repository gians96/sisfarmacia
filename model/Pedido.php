<?php
	require "Conexion.php";
	
	class Pedido{
	
		public function Registrar($idcliente, $idusuario, $idsucursal, $tipo_pedido, $numero, $detalle){
			global $conexion;
			$sw = true;
			try {
				
			
				$sql = "INSERT INTO pedido(idcliente, idusuario, idsucursal, tipo_pedido, fecha, numero, estado) 
						VALUES($idcliente, $idusuario, $idsucursal, '$tipo_pedido', CURRENT_TIMESTAMP(), $numero, 'A')";
				//var_dump($sql);
				$conexion->query($sql);	
				$idpedido=$conexion->insert_id;

				$conexion->autocommit(true);
				foreach($detalle as $indice => $valor){
					$sql_detalle = "INSERT INTO detalle_pedido(idpedido, iddetalle_ingreso, cantidad, precio_venta, descuento)
											VALUES($idpedido, ".$valor[0].", ".$valor[3].", ".$valor[2].", ".$valor[4].")";
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
			$sql = "select p.*, c.nombre as Cliente, c.email,v.tipo_comprobante,v.serie_comprobante,v.num_comprobante 
from pedido p inner join persona c on p.idcliente = c.idpersona 
	INNER JOIN venta v on p.idpedido=v.idpedido where p.idsucursal = $idsucursal 
			and c.tipo_persona = 'Cliente' and p.tipo_pedido = 'Venta' order by idpedido desc limit 0,2999";
			$query = $conexion->query($sql);
			return $query;
		}

		public function VerVenta($idpedido){
			global $conexion;
			$sql = "select * from venta where idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function TotalPedido($idpedido){
			global $conexion;
			$sql = "select sum((cantidad * precio_venta) - descuento) as Total
	from detalle_pedido where idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function CambiarEstado($idpedido, $detalle){
			global $conexion;
			$sw = true;
			try {
				
				$sql = "UPDATE pedido set estado = 'C'
						WHERE idpedido = $idpedido";
				//var_dump($sql);
				$conexion->query($sql);

				$sql2 = "UPDATE venta set impuesto = '0.00',total='0.00'
						WHERE idpedido = $idpedido";
				//var_dump($sql);
				$conexion->query($sql2);

				$sql3 = "UPDATE credito set total_pago = '0.00'
						WHERE idventa = (select idventa from venta where idpedido=$idpedido)";
				//var_dump($sql);
				$conexion->query($sql3);	

				$conexion->autocommit(true);
				foreach($detalle as $indice => $valor){
					$sql_detalle = "UPDATE detalle_ingreso SET stock_unidad = stock_unidad + ".$valor[1]." WHERE iddetalle_ingreso = ".$valor[0]."";
					$conexion->query($sql_detalle) or $sw = false;
				}
				////////////////////////////////////////////////////////////////////////////////////////////
				foreach($detalle as $indice => $valor){
					// $sql_detalle = "UPDATE detalle_ingreso set stock_unidad = ".$valor[1]." - ".$valor[2]." where iddetalle_ingreso = ".$valor[0]."";
					$sql = "SELECT di.stock_unidad from detalle_ingreso di WHERE di.iddetalle_ingreso= ".$valor[0]."";

					$query_result = $conexion->query($sql);
					$stockUnidad;

					while ($reg = $query_result->fetch_object()) {$stockUnidad= $reg->stock_unidad; }

					///////////////////////////////////////////////////////////////////








					////////////////////////////////////////////////////////////////////////////////
					$sql = "SELECT a.unidad from detalle_ingreso di INNER JOIN articulo a on a.idarticulo=di.idarticulo  where di.iddetalle_ingreso= ".$valor[0]."";
					$query_result=$conexion->query($sql);

					$unidad;
					while ($reg = $query_result->fetch_object()) {$unidad= $reg->unidad; }


					$sql_detalle = "UPDATE detalle_ingreso set stock_actual = (select($stockUnidad div $unidad)) where iddetalle_ingreso = ".$valor[0]."";
					//////////////////////////////////////////////////////////////////////////////////////////////////////////
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

		public function EliminarPedido($idpedido){
			global $conexion;
			$sql = "DELETE FROM detalle_pedido
						WHERE idpedido = $idpedido";
			$query = $conexion->query($sql);
			
			$sql = "DELETE FROM pedido
						WHERE idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function GetPrimerCliente()
		{
			global $conexion;
			$sql = "select idpersona,nombre from persona where tipo_persona='Cliente' order by idpersona limit 0,1";
			$query = $conexion->query($sql);
			return $query;
		}

		
		public function TraerCantidad($idpedido){
			global $conexion;
			$sql = "select iddetalle_ingreso, cantidad from detalle_pedido where idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}
		

		public function GetDetallePedido($idpedido){
			global $conexion;
			$sql = "select a.nombre as articulo,a.descripcion as nombreGeneral,dg.descripcion as descripcion, dg.codigo, dg.serie, dp.*
			from pedido p inner join detalle_pedido dp on p.idpedido = dp.idpedido
			inner join detalle_ingreso dg on dp.iddetalle_ingreso = dg.iddetalle_ingreso
			inner join articulo a on dg.idarticulo = a.idarticulo
			where dp.idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function GetDetalleCantStock($idpedido){
			global $conexion;
			$sql = "select di.iddetalle_ingreso, di.stock_actual, dp.cantidad 
	from detalle_pedido dp inner join detalle_ingreso di on dp.iddetalle_ingreso = di.iddetalle_ingreso
	where dp.idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarTipoPedidoPedido($idsucursal){
			global $conexion;
			$sql = "select p.*, c.nombre as Cliente, c.email from pedido p inner join persona c 
			on p.idcliente = c.idpersona where p.estado = 'A' and p.idsucursal = $idsucursal and p.tipo_pedido <> 'Venta' 
			order by idpedido desc";
			$query = $conexion->query($sql);
			return $query;
		}

		public function GetTotal($idpedido){
			global $conexion;
			$sql = "select sum((cantidad * precio_venta) - descuento) as total from detalle_pedido where idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function GetIdPedido(){
			global $conexion;
			$sql = "select max(idpedido) as idpedido from pedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function GetNextNumero($idsucursal){
			global $conexion;
			$sql = "select max(numero) + 1 as numero from pedido where idsucursal = $idsucursal";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarClientes(){
			global $conexion;
			$sql = "select * from persona where tipo_persona = 'Cliente'";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarDetalleIngresos($idsucursal){
			global $conexion;
			$sql = "select s.razon_social as sucursal,
		s.num_documento as RUC,
        p1.nombre as proveedor,
        p2.nombre	 as laboratorio,
		di.iddetalle_ingreso as iddetalle_ingreso,

        a.nombre as Articulo,
        a.descripcion as nombreGeneral, 
        di.codigo as nlote,
        di.serie as regsanitario,
        di.descripcion,
        di.stock_actual,
        di.stock_unidad,
        di.precio_ventapublico as precio_ventapublico,
        di.fecha_vencimiento as fecha,
        ff.descripcion as descripcionf,
        ff.abreviacion as abreviacionf,
        
        p.descripcion as descripcionp,
        p.abreviacion as abreviacionp,
       
        ca.descripcion as descripcionc,
        ca.abreviacion as abreviacionc
   FROM detalle_ingreso di,
   		articulo a,
        ingreso i,
        forma_farmaceutica ff,
        presentacion p,
        condicion_almacenamiento ca, 
        persona p1,
        persona p2,
        sucursal s
   WHERE di.idingreso=i.idingreso and 
   		di.idarticulo=a.idarticulo  AND
        di.idforma_farmaceutica=ff.idforma_farmaceutica AND
        di.idpresentacion=p.idpresentacion AND
        di.idcondicion_almacenamiento=ca.idcondicion_almacenamiento AND
        i.idsucursal = s.idsucursal AND
        i.idproveedor=p1.idpersona AND
        i.idlaboratorio=p2.idpersona and
        i.idsucursal=$idsucursal and di.stock_unidad>0
        
ORDER BY `di`.`idingreso` ASC";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarProveedor(){
			global $conexion;
			$sql = "select * from persona where tipo_persona = 'Proveedor' and estado = 'A'";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarTipoDocumento($idsucursal){
			global $conexion;
			$sql = "select dds.*, td.nombre 
	from detalle_documento_sucursal dds inner join tipo_documento td on dds.idtipo_documento = td.idtipo_documento
	where dds.idsucursal = $idsucursal and operacion = 'Comprobante'";
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

		public function GetClienteSucursalPedido($idpedido){
			global $conexion;
			$sql = "select p.*, ped.fecha, s.razon_social, ped.numero, s.tipo_documento, s.num_documento as num_sucursal, s.direccion, s.telefono as telefono_suc, s.email as email_suc, s.representante, s.logo, ped.tipo_pedido,p.tipo_documento as doc
	from persona p inner join pedido ped on ped.idcliente = p.idpersona 
	inner join sucursal s on ped.idsucursal = s.idsucursal
	where ped.idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function GetVenta($idpedido){
			global $conexion;
			$sql = "select p.*, ped.fecha, s.razon_social, v.num_comprobante, v.serie_comprobante, s.tipo_documento, s.num_documento as num_sucursal, s.direccion, s.telefono as telefono_suc, s.email as email_suc, s.representante, s.logo, ped.tipo_pedido,v.impuesto,p.tipo_documento as doc
	from persona p inner join pedido ped on ped.idcliente = p.idpersona 
	inner join sucursal s on ped.idsucursal = s.idsucursal
	inner join venta v on v.idpedido = ped.idpedido
	where ped.idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}
		public function GetComprobanteTipo($idpedido){
			global $conexion;
			$sql = "select v.tipo_comprobante from venta v inner join pedido p on p.idpedido=v.idpedido
			where p.idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ImprimirDetallePedido($idpedido){
			global $conexion;
			$sql = "select di.codigo,di.serie, a.nombre as articulo, dp.*, (dp.cantidad * dp.precio_venta) - dp.descuento as sub_total
	from detalle_pedido dp inner join pedido p on dp.idpedido = p.idpedido
	inner join detalle_ingreso di on dp.iddetalle_ingreso = di.iddetalle_ingreso
	inner join articulo a on di.idarticulo = a.idarticulo where p.idpedido = $idpedido";
			$query = $conexion->query($sql);
			return $query;
		}

	}	