<?php
	require "Conexion.php";

	class ConsultasCompras{
	
		
		public function __construct(){

		}

		public function ListarKardexValorizado($idsucursal){
			global $conexion;
			$sql = "select s.razon_social as sucursal,a.nombre as articulo,
				c.nombre as categoria,
				u.nombre as unidad,
				sum(di.stock_ingreso) as totalingreso,
				sum(di.stock_ingreso*a.unidad) as totalingresounidad,
				sum(di.stock_ingreso*di.precio_compra) as valorizadoingreso,
				sum(di.stock_actual) as totalstock,
				sum(di.stock_unidad) as totalstockunidad,
				sum(di.stock_unidad*di.precio_ventadistribuidor) as valorizadostock,
				sum(di.stock_ingreso-di.stock_actual) as totalventa,
				sum(di.stock_ingreso*a.unidad-di.stock_unidad) as totalventaunidad,
				sum((di.stock_ingreso-di.stock_actual)*di.precio_ventapublico) as valorizadoventa,
				sum((di.stock_ingreso*a.unidad-di.stock_unidad)*di.precio_ventapublico) as valorizadoventaunidad,
				sum((di.precio_ventapublico-di.precio_ventadistribuidor)*di.stock_ingreso*a.unidad) as utilidadvalorizada
				from articulo a inner join detalle_ingreso di
				on di.idarticulo=a.idarticulo
				inner join ingreso i on di.idingreso=i.idingreso
				inner join sucursal s on i.idsucursal=s.idsucursal
				inner join categoria c on a.idcategoria=c.idcategoria
				inner join unidad_medida u on a.idunidad_medida=u.idunidad_medida
				where s.idsucursal='$idsucursal'  and i.estado='A'
				group by a.nombre,c.nombre,u.nombre
				order by a.nombre asc
				";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarStockArticulos($idsucursal){
			global $conexion;
		// 	$sql = "select s.razon_social as sucursal,
		// a.nombre as articulo,di.descripcion,pe.nombre as laboratorioa,
		// 		c.nombre as categoria,
  //               ff.abreviacion as abreviacionff,
		// 		p.abreviacion as abreviacionp,
		// 		ca.abreviacion as abreviacionca,
  //               di.codigo,di.serie,
		// 		u.nombre as unidad,
		// 		sum(di.stock_ingreso) as totalingreso,
		// 		sum(di.stock_ingreso*a.unidad) as totalingresounidad,
		// 		sum(di.stock_ingreso*di.precio_compra) as valorizadoingreso,
		// 		sum(di.stock_actual) as totalstock,
		// 		sum(di.stock_unidad) as totalstockunidad,
		// 		sum(di.stock_unidad*di.precio_ventadistribuidor) as valorizadostock,
		// 		sum(di.stock_ingreso-di.stock_actual) as totalventa,
		// 		sum(di.stock_ingreso*a.unidad-di.stock_unidad) as totalventaunidad,
		// 		sum((di.stock_ingreso-di.stock_actual)*di.precio_ventapublico) as valorizadoventa,
		// 		sum((di.stock_ingreso*a.unidad-di.stock_unidad)*di.precio_ventapublico) as valorizadoventaunidad,
		// 		sum((di.precio_ventapublico-di.precio_ventadistribuidor)*di.stock_ingreso*a.unidad) as utilidadvalorizada,
		// 		di.precio_ventadistribuidor as precioventadistribuidorxunidad,
		// 		di.precio_ventapublico as precioventapublicoxunidad
		// 		from articulo a inner join detalle_ingreso di on di.idarticulo=a.idarticulo
		// 		inner join ingreso i on di.idingreso=i.idingreso
		// 		inner join sucursal s on i.idsucursal=s.idsucursal
		// 		inner join categoria c on a.idcategoria=c.idcategoria
		// 		inner join unidad_medida u on a.idunidad_medida=u.idunidad_medida
  //               inner join forma_farmaceutica ff on di.idforma_farmaceutica=ff.idforma_farmaceutica
		// 		inner join presentacion p on di.idpresentacion=p.idpresentacion
		// 		inner join condicion_almacenamiento ca on di.idcondicion_almacenamiento=ca.idcondicion_almacenamiento				
  //               inner join persona pe on pe.idpersona=a.idlaboratorio
		// 		where di.stock_actual>'0' and s.idsucursal=$idsucursal and i.estado='A'
		// 		group by a.nombre,c.nombre,u.nombre,di.serie,di.codigo
		// 		order by a.nombre asc
		// 		";


				$sql = "select s.razon_social as sucursal,
		a.nombre as articulo,di.descripcion,pe.nombre as laboratorioa,
				c.nombre as categoria,
                ff.abreviacion as abreviacionff,
				p.abreviacion as abreviacionp,
				ca.abreviacion as abreviacionca,
                di.codigo,di.serie,
				u.nombre as unidad,
				sum(di.stock_ingreso) as totalingreso,
				sum(di.stock_ingreso*a.unidad) as totalingresounidad,
				sum(di.stock_ingreso*di.precio_compra) as valorizadoingreso,
				sum(di.stock_actual) as totalstock,
				sum(di.stock_unidad) as totalstockunidad,
				sum(di.stock_unidad*di.precio_ventadistribuidor) as valorizadostock,
				sum(di.stock_ingreso-di.stock_actual) as totalventa,
				sum(di.stock_ingreso*a.unidad-di.stock_unidad) as totalventaunidad,
				sum((di.stock_ingreso-di.stock_actual)*di.precio_ventapublico) as valorizadoventa,
				sum((di.stock_ingreso*a.unidad-di.stock_unidad)*di.precio_ventapublico) as valorizadoventaunidad,
				sum((di.precio_ventapublico-di.precio_ventadistribuidor)*di.stock_ingreso*a.unidad) as utilidadvalorizada,
				di.precio_ventadistribuidor as precioventadistribuidorxunidad,
				di.precio_ventapublico as precioventapublicoxunidad
				from articulo a inner join detalle_ingreso di on di.idarticulo=a.idarticulo
				inner join ingreso i on di.idingreso=i.idingreso
				inner join sucursal s on i.idsucursal=s.idsucursal
				inner join categoria c on a.idcategoria=c.idcategoria
				inner join unidad_medida u on a.idunidad_medida=u.idunidad_medida
                inner join forma_farmaceutica ff on di.idforma_farmaceutica=ff.idforma_farmaceutica
				inner join presentacion p on di.idpresentacion=p.idpresentacion
				inner join condicion_almacenamiento ca on di.idcondicion_almacenamiento=ca.idcondicion_almacenamiento				
                inner join persona pe on pe.idpersona=a.idlaboratorio
				where  s.idsucursal=$idsucursal and i.estado='A'
				group by a.nombre,c.nombre,u.nombre,di.serie,di.codigo
				order by a.nombre asc
				";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarComprasFechas($idsucursal, $fecha_desde, $fecha_hasta){
			global $conexion;
			$sql = "select i.idingreso, i.fecha,s.razon_social as sucursal,
				concat(e.apellidos,' ',e.nombre) as empleado,
				p.nombre as proveedor,p1.nombre as laboratorio,i.tipo_comprobante as comprobante,
				i.serie_comprobante as serie,i.num_comprobante as numero,
				i.impuesto,
				format((i.total-(i.impuesto*i.total/(100+i.impuesto))),2) as subtotal,
				format((i.impuesto*i.total/(100+i.impuesto)),2) as totalimpuesto,
				i.total
				from ingreso i inner join sucursal s on i.idsucursal=s.idsucursal
				inner join usuario u on i.idusuario=u.idusuario
				inner join empleado e on u.idempleado=e.idempleado
				inner join persona p on i.idproveedor=p.idpersona
                inner join persona p1 on i.idlaboratorio=p1.idpersona
				where i.fecha>='$fecha_desde' and i.fecha<='$fecha_hasta'
				and s.idsucursal= $idsucursal  and i.estado='A'
				order by i.fecha desc
				";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarComprasDetalladas($idsucursal, $fecha_desde, $fecha_hasta){
			global $conexion;
			$sql = "select i.fecha,s.razon_social as sucursal,
				concat(e.apellidos,' ',e.nombre) as empleado,
				p.nombre as proveedor,p1.nombre as laboratorio,i.tipo_comprobante as comprobante,
				i.serie_comprobante as serie,i.num_comprobante as numero,
				i.impuesto,
				a.nombre as articulo,
				a.descripcion,
				a.unidad,
                p3.nombre as laboratorioa,
                di.codigo,di.serie as serie_art,
                di.stock_ingreso,
				di.stock_actual,
				(di.stock_ingreso-di.stock_actual)as stock_vendido,
				((di.stock_ingreso*a.unidad)-di.stock_unidad) as stock_uvendido,
				di.precio_compra,di.precio_ventapublico,
				di.precio_ventadistribuidor
				from detalle_ingreso di inner join articulo a
				on di.idarticulo=a.idarticulo
				inner join ingreso i on di.idingreso=i.idingreso
				inner join sucursal s on i.idsucursal=s.idsucursal
				inner join usuario u on i.idusuario=u.idusuario
				inner join empleado e on u.idempleado=e.idempleado
				inner join persona p on i.idproveedor=p.idpersona				
                inner join persona p1 on i.idlaboratorio=p1.idpersona
                inner JOIN persona p3	on a.idlaboratorio=p3.idpersona
				where i.fecha>='$fecha_desde' and i.fecha<='$fecha_hasta'
				and s.idsucursal= $idsucursal and i.estado='A'
				order by i.fecha desc
				";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarComprasProveedor($idsucursal, $idproveedor, $fecha_desde, $fecha_hasta){
			global $conexion;
			$sql = "select i.fecha,s.razon_social as sucursal,
				concat(e.apellidos,' ',e.nombre) as empleado,
				p.nombre as proveedor,i.tipo_comprobante as comprobante,
				i.serie_comprobante as serie,i.num_comprobante as numero,
				i.impuesto,
				format((i.total-(i.impuesto*i.total/(100+i.impuesto))),2) as subtotal,
				format((i.impuesto*i.total/(100+i.impuesto)),2) as totalimpuesto,
				i.total
				from ingreso i inner join sucursal s on i.idsucursal=s.idsucursal
				inner join usuario u on i.idusuario=u.idusuario
				inner join empleado e on u.idempleado=e.idempleado
				inner join persona p on i.idproveedor=p.idpersona
				where i.fecha>='$fecha_desde' and i.fecha<='$fecha_hasta' and i.estado='A'
				and p.idpersona= $idproveedor and s.idsucursal=$idsucursal
				order by p.nombre asc
				";
			$query = $conexion->query($sql);
			return $query;
		}

		public function ListarComprasDetProveedor($idsucursal, $idproveedor, $fecha_desde, $fecha_hasta){
			global $conexion;
			$sql = "select i.fecha,s.razon_social as sucursal,
					concat(e.apellidos,' ',e.nombre) as empleado,
					p.nombre as proveedor,i.tipo_comprobante as comprobante,
					i.serie_comprobante as serie,i.num_comprobante as numero,
					i.impuesto,
					a.nombre as articulo,
					a.descripcion,
					a.unidad,
					p1.nombre as laboratorioa,di.codigo,di.serie,di.stock_ingreso,
					di.stock_actual,
					(di.stock_ingreso-di.stock_actual)as stock_vendido,
					((di.stock_ingreso*a.unidad)-di.stock_unidad) as stock_uvendido,
					di.precio_compra,di.precio_ventapublico,
					di.precio_ventadistribuidor
					from detalle_ingreso di inner join articulo a
					on di.idarticulo=a.idarticulo
					inner join ingreso i on di.idingreso=i.idingreso
					inner join sucursal s on i.idsucursal=s.idsucursal
					inner join usuario u on i.idusuario=u.idusuario
					inner join empleado e on u.idempleado=e.idempleado
					inner join persona p on i.idproveedor=p.idpersona					
                    inner join persona p1 on a.idlaboratorio=p1.idpersona
					where i.fecha>='$fecha_desde' and i.fecha<='$fecha_hasta'
				and p.idpersona=$idproveedor and s.idsucursal= $idsucursal and i.estado='A'
					order by p.nombre asc
				";
			$query = $conexion->query($sql);
			return $query;
		}


	}
