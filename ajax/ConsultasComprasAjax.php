<?php

	session_start();

	require_once "../model/ConsultasCompras.php";

	$objCategoria = new ConsultasCompras();

	switch ($_GET["op"]) {
		
		case "listKardexValorizado":
               if ( !isset($_REQUEST['idsucursal'])) $_REQUEST['idsucursal'] = 1;
               $idsucursal = $_REQUEST["idsucursal"];

			$query_Tipo = $objCategoria->ListarKardexValorizado($idsucursal);
               $data = Array();
			while ($reg = $query_Tipo->fetch_object()) {
				$data[] = array(
                    "0"=>$reg->sucursal,
                    "1"=>$reg->articulo,
                    "2"=>$reg->categoria,
                    "3"=>$reg->unidad,
                    "4"=>$reg->totalingreso."x,".$reg->totalingresounidad."u",
                    "5"=>$reg->valorizadoingreso,
                    "6"=>$reg->totalstock."x,".$reg->totalstockunidad."u",
                    "7"=>$reg->valorizadostock,
                    "8"=>$reg->totalventa."x,".$reg->totalventaunidad."u",
                    "9"=>$reg->valorizadoventaunidad,
                    "10"=>$reg->utilidadvalorizada
                    );
			}
               $results = array(
               "sEcho" => 1,
               "iTotalRecords" => count($data),
               "iTotalDisplayRecords" => count($data),
               "aaData"=>$data);
               echo json_encode($results);

			break;

		case "listStockArticulos":
           if ( !isset($_REQUEST['idsucursal'])) $_REQUEST['idsucursal'] = 1;
          $idsucursal = $_REQUEST["idsucursal"];
          $data =Array();

			$query_Tipo = $objCategoria->ListarStockArticulos($idsucursal);

			while ($reg = $query_Tipo->fetch_object()) {

				$data[] = array(
                    "0"=>$reg->sucursal,
                    "1"=>$reg->articulo,
                    "2"=>$reg->descripcion,
                    "3"=>$reg->laboratorioa,
                    "4"=>$reg->abreviacionff,
                    "5"=>$reg->abreviacionp,
                    "6"=>$reg->abreviacionca,
                    "7"=>$reg->codigo,
                    "8"=>$reg->serie,
                    "9"=>$reg->precioventadistribuidorxunidad,
                    "10"=>$reg->precioventapublicoxunidad,
                    "11"=>$reg->totalingreso."x,".$reg->totalingresounidad."u",
                    "12"=>$reg->valorizadoingreso,
                    "13"=>$reg->totalstock."x,".$reg->totalstockunidad."u",
                    "14"=>$reg->valorizadostock,
                    "15"=>$reg->totalventa."x,".$reg->totalventaunidad."u",
                    "16"=>$reg->valorizadoventaunidad,
                    "17"=>$reg->utilidadvalorizada
                    );
			}
               $results = array(
               "sEcho" => 1,
               "iTotalRecords" => count($data),
               "iTotalDisplayRecords" => count($data),
               "aaData"=>$data);
               echo json_encode($results);
            
			break;

          case "listComprasFechas":

               $fecha_desde = $_REQUEST["fecha_desde"];
               $fecha_hasta = $_REQUEST["fecha_hasta"];
               $idsucursal = $_REQUEST["idsucursal"];
               $data = Array();
               $query_Tipo = $objCategoria->ListarComprasFechas($idsucursal, $fecha_desde, $fecha_hasta);

               while ($reg = $query_Tipo->fetch_object()) {

                    $data[] = array(
                         "0"=>$reg->fecha,
                         "1"=>$reg->sucursal,
                         "2"=>$reg->empleado,
                         "3"=>$reg->proveedor,
                         "4"=>$reg->laboratorio,
                         "5"=>$reg->comprobante,
                         "6"=>$reg->serie,
                         "7"=>$reg->numero,
                         "8"=>$reg->impuesto,
                         "9"=>$reg->subtotal,
                         "10"=>$reg->totalimpuesto,
                         "11"=>$reg->total,
                         "12"=>'<button class="btn btn-success" data-toggle="tooltip" title="Ver Detalle" onclick="cargarDataIngreso('.$reg->idingreso.',\''.$reg->serie.'\',\''.$reg->numero.'\',\''.$reg->impuesto.'\',\''.$reg->total.'\',\''.$reg->idingreso.'\',\''.$reg->proveedor.'\',\''.$reg->laboratorio.'\',\''.$reg->comprobante.'\')" ><i class="fa fa-eye"></i> </button>&nbsp'.
                    '<a href="./Reportes/exIngreso.php?id='.$reg->idingreso.'" class="btn btn-primary" data-toggle="tooltip" title="Imprimir" target="blanck" ><i class="fa fa-file-text"></i> </a>'
                    );
               }
            
               $results = array(
               "sEcho" => 1,
               "iTotalRecords" => count($data),
               "iTotalDisplayRecords" => count($data),
               "aaData"=>$data);
               echo json_encode($results);
            
               break;

          case "listComprasDetalladas":

               $fecha_desde = $_REQUEST["fecha_desde"];
               $fecha_hasta = $_REQUEST["fecha_hasta"];
               //if ( !isset($_REQUEST['idsucursal'])) $_REQUEST['idsucursal'] = 1;
               $idsucursal = $_REQUEST["idsucursal"];
               $data = Array();
               $query_Tipo = $objCategoria->ListarComprasDetalladas($idsucursal, $fecha_desde, $fecha_hasta);

               while ($reg = $query_Tipo->fetch_object()) {

                    $data[] = array(
                         "0"=>$reg->fecha,
                         "1"=>$reg->sucursal,
                         "2"=>$reg->empleado,
                         "3"=>$reg->proveedor,
                         "4"=>$reg->comprobante,
                         "5"=>$reg->serie,
                         "6"=>$reg->numero,
                         "7"=>$reg->articulo." - ".$reg->unidad."u",
                         "8"=>$reg->descripcion,
                         "9"=>$reg->laboratorioa,
                         "10"=>$reg->codigo,
                         "11"=>$reg->serie_art,
                         "12"=>$reg->stock_ingreso,
                         "13"=>$reg->stock_actual,
                         "14"=>$reg->stock_vendido."x - ".$reg->stock_uvendido."u",
                         "15"=>$reg->precio_compra,
                         "16"=>$reg->precio_ventapublico,
                         "17"=>$reg->precio_ventadistribuidor
                    );
               }
            
               $results = array(
               "sEcho" => 1,
               "iTotalRecords" => count($data),
               "iTotalDisplayRecords" => count($data),
               "aaData"=>$data);
               echo json_encode($results);
            
               break;

          case "listComprasProveedor":

               $idProveedor = $_REQUEST["idProveedor"];
               $fecha_desde = $_REQUEST["fecha_desde"];
               $fecha_hasta = $_REQUEST["fecha_hasta"];
               // if ( !isset($_REQUEST['idsucursal'])) $_REQUEST['idsucursal'] = 1;
               $idsucursal = $_REQUEST["idsucursal"];
               $data = Array();

               $query_Tipo = $objCategoria->ListarComprasProveedor($idsucursal, $idProveedor, $fecha_desde, $fecha_hasta);

               while ($reg = $query_Tipo->fetch_object()) {

                    $data[] = array(
                         "0"=>$reg->fecha,
                         "1"=>$reg->sucursal,
                         "2"=>$reg->empleado,
                         "3"=>$reg->proveedor,
                         "4"=>$reg->comprobante,
                         "5"=>$reg->serie,
                         "6"=>$reg->numero,
                         "7"=>$reg->impuesto,
                         "8"=>$reg->subtotal,
                         "9"=>$reg->totalimpuesto,
                         "10"=>$reg->total
                    );
               }
               $results = array(
               "sEcho" => 1,
               "iTotalRecords" => count($data),
               "iTotalDisplayRecords" => count($data),
               "aaData"=>$data);
               echo json_encode($results);
            
               break;

          case "listComprasDetProveedor":

               $idProveedor = $_REQUEST["idProveedor"];
               $fecha_desde = $_REQUEST["fecha_desde"];
               $fecha_hasta = $_REQUEST["fecha_hasta"];
               // if ( !isset($_REQUEST['idsucursal'])) $_REQUEST['idsucursal'] = 1;
               $idsucursal = $_REQUEST["idsucursal"];
               $data = Array();
               $query_Tipo = $objCategoria->ListarComprasDetProveedor($idsucursal, $idProveedor, $fecha_desde, $fecha_hasta);

               while ($reg = $query_Tipo->fetch_object()) {

                    $data[] = array(
                         "0"=>$reg->fecha,
                         "1"=>$reg->sucursal,
                         "2"=>$reg->empleado,
                         "3"=>$reg->proveedor,
                         "4"=>$reg->comprobante,
                         "5"=>$reg->serie,
                         "6"=>$reg->numero,
                         "7"=>$reg->articulo." - ".$reg->unidad."u",
                         "8"=>$reg->descripcion,
                         "9"=>$reg->laboratorioa,
                         "10"=>$reg->codigo,
                         "11"=>$reg->serie,
                         "12"=>$reg->stock_ingreso,
                         "13"=>$reg->stock_actual,
                         "14"=>$reg->stock_vendido."x - ".$reg->stock_uvendido."u",
                         "15"=>$reg->precio_compra,
                         "16"=>$reg->precio_ventapublico,
                         "17"=>$reg->precio_ventadistribuidor
                    );
               }
            
               $results = array(
               "sEcho" => 1,
               "iTotalRecords" => count($data),
               "iTotalDisplayRecords" => count($data),
               "aaData"=>$data);
               echo json_encode($results);
            
               break;


	}
	