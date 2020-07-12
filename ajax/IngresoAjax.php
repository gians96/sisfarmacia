<?php

session_start();

switch ($_GET["op"]) {

    case 'Save':

    require_once "../model/Ingreso.php";

    $obj= new Ingreso();

        $idUsuario = $_POST["idUsuario"];
        $idSucursal = $_POST["idSucursal"];
        $idproveedor = $_POST["idproveedor"];
        $idlaboratorio = $_POST["idlaboratorio"];

        $tipo_comprobante = trim($_POST["tipo_comprobante"]);
        $serie_comprobante = $_POST["serie_comprobante"];
        $num_comprobante = $_POST["num_comprobante"];
        $impuesto = $_POST["impuesto"];
        $total = $_POST["total"];
        $fecha_emision = $_POST["fecha_emision"];
        $referencia = $_POST["referencia"];
        $observacion = $_POST["observacion"];

        if(empty($idlaboratorio)){
            $idlaboratorio=14;
        }

        if(empty($_POST["idIngreso"])){
            $hosp = $obj->Registrar($idUsuario, $idSucursal, $idproveedor,$idlaboratorio, $tipo_comprobante, $serie_comprobante, $num_comprobante, $impuesto, $total,$fecha_emision, $_POST["detalle"]);
                if ($hosp) {
                    echo "Ingreso Registrado";
                } else {
                    echo "No se ha podido registrar el Ingreso";
                }
        } else {
            $hosp1=$obj->modificar($_POST["idIngreso"],$referencia,$observacion,$idUsuario,  $_POST["detalle"]);
            
            
            if($hosp1){
                echo "Ingreso Modificada";
            } else {
                echo "No se ha podido modificar la Ingreso";
            }
        }
                
        break;

    case "CambiarEstado" :
        require_once "../model/Ingreso.php";

        $obj= new Ingreso();

        $idIngreso = $_POST["idIngreso"];

        $hosp = $obj->CambiarEstado($idIngreso);
                if ($hosp) {
                    echo "Ingreso Anulado";
                } else {
                    echo "No se ha podido Anular el Ingreso";
                }
        break;


    case "list":
        require_once "../model/Ingreso.php";

        $objIngreso = new Ingreso();

        $query_Ingreso = $objIngreso->Listar($_SESSION["idsucursal"]);

        $data = Array();
        $i = 1;
            while ($reg = $query_Ingreso->fetch_object()) {
                $data[] = array(
                    "0"=>$i,
                    "1"=>$reg->proveedor,
                    "2"=>$reg->laboratorio,
                    "3"=>$reg->tipo_comprobante,
                    "4"=>$reg->serie_comprobante,
                    "5"=>$reg->num_comprobante,
                    "6"=>$reg->fecha_emision,
                    "7"=>$reg->impuesto,
                    "8"=>$reg->total,
                    //$reg->estado,

                    "9"=>($reg->estado=="A")?'<span class="badge bg-green">ACEPTADO</span>':'<span class="badge bg-red">CANCELADO</span>',
                    "10"=>($reg->estado=="A")?
                    '<button class="btn btn-success" data-toggle="tooltip" title="Ver Detalle" 
                        onclick="cargarDataIngreso('.$reg->idingreso.',
                                                    \''.$reg->serie_comprobante.'\',
                                                    \''.$reg->num_comprobante.'\',
                                                    \''.$reg->impuesto.'\',
                                                    \''.$reg->total.'\',
                                                    \''.$reg->idingreso.'\',
                                                    \''.$reg->proveedor.'\',
                                                    \''.$reg->laboratorio.'\',
                                                    \''.$reg->tipo_comprobante.'\')" >
                    <i class="fa fa-eye"></i> </button>&nbsp'.
                    

                    '<button class="btn btn-warning" data-toggle="tooltip" title="Editar" 
                        onclick="cargarDataIngresoProveedor ('.$reg->idingreso.',
                                                    \''.$reg->serie_comprobante.'\',
                                                    \''.$reg->num_comprobante.'\',
                                                    \''.$reg->impuesto.'\',
                                                    \''.$reg->total.'\',
                                                    \''.$reg->idingreso.'\',
                                                    \''.$reg->idproveedor.'\',
                                                    \''.$reg->proveedor.'\',
                                                    \''.$reg->idlaboratorio.'\',
                                                    \''.$reg->laboratorio.'\',
                                                    \''.$reg->tipo_comprobante.'\')" >
                    <i class="glyphicon glyphicon-edit"></i> </button>&nbsp'.

                    '<button class="btn btn-danger" data-toggle="tooltip" title="Anular Ingreso" onclick="cancelarIngreso('.$reg->idingreso.')" ><i class="fa fa-times-circle"></i> </button>&nbsp'.

                    '<a href="./Reportes/exIngreso.php?id='.$reg->idingreso.'" class="btn btn-primary" data-toggle="tooltip" title="Imprimir" target="blanck" ><i class="fa fa-file-text"></i> </a>':'<button class="btn btn-success" data-toggle="tooltip" title="Ver Detalle" onclick="cargarDataIngreso('.$reg->idingreso.',\''.$reg->serie_comprobante.'\',\''.$reg->num_comprobante.'\',\''.$reg->impuesto.'\',\''.$reg->total.'\',\''.$reg->idingreso.'\',\''.$reg->proveedor.'\',\''.$reg->laboratorio.'\',\''.$reg->tipo_comprobante.'\')" ><i class="fa fa-eye"></i> </button>&nbsp'.
                    '<a href="./Reportes/exIngreso.php?id='.$reg->idingreso.'" class="btn btn-primary" data-toggle="tooltip" title="Imprimir" target="blanck" ><i class="fa fa-file-text"></i> </a>');
                $i++;
            }
            $results = array(
            "sEcho" => 1,
            "iTotalRecords" => count($data),
            "iTotalDisplayRecords" => count($data),
            "aaData"=>$data);
            echo json_encode($results);
            
            break;
            

        break;

    case "GetDetalleArticulo":
        require_once "../model/Ingreso.php";

        $objIngreso = new Ingreso();

        $idIngreso = $_POST["idIngreso"];

        $query_prov = $objIngreso->GetDetalleArticulo($idIngreso);

        $i = 1;
            while ($reg = $query_prov->fetch_object()) {
                if($reg->unidad=="1"){
                    echo '<tr>
                        <td>'.$reg->articulo.'</td>
                        <td>'.$reg->codigo.'</td>
                        <td>'.$reg->serie.'</td>
                        <td>'.$reg->unidad.'</td>
                        <td>'.$reg->fecha_vencimiento.'</td>
                        <td>'.$reg->forma_farmaceutica.'</td>
                        <td>'.$reg->presentacion.'</td>
                        <td>'.$reg->condicion_almacenamiento.'</td>
                        <td>'.'0'.'</td>
                        <td>'.$reg->stock_ingreso.'</td>
                        <td>'.'0'.'</td>
                        <td>'.$reg->stock_unidad.'</td>
                        <td>'.$reg->precio_compra.'</td>
                        <td>'.$reg->precio_ventadistribuidor.'</td>
                        <td>'.$reg->laboratorioas.'</td>
                        <td>'.$reg->precio_ventapublico.'</td>
                        
                       </tr>';
                }else{
                    echo '<tr>
                        <td>'.$reg->articulo.'</td>
                        <td>'.$reg->codigo.'</td>
                        <td>'.$reg->serie.'</td>
                        <td>'.$reg->unidad.'</td>
                        <td>'.$reg->fecha_vencimiento.'</td>
                        <td>'.$reg->forma_farmaceutica.'</td>
                        <td>'.$reg->presentacion.'</td>
                        <td>'.$reg->condicion_almacenamiento.'</td>
                        <td>'.floor($reg->stock_ingreso/$reg->unidad).'</td>
                        <td>'.($reg->stock_ingreso-(floor($reg->stock_ingreso/$reg->unidad)*$reg->unidad)).'</td>
                        <td>'.$reg->stock_actual.'</td>
                        <td>'.($reg->stock_unidad-(floor($reg->stock_unidad/$reg->unidad)*$reg->unidad)).'</td>
                        <td>'.$reg->precio_compra.'</td>
                        <td>'.$reg->precio_ventadistribuidor.'</td>
                        <td>'.$reg->laboratorioas.'</td>
                        <td>'.$reg->precio_ventapublico.'</td>
                        
                       </tr>';
                }
                 
                       //<td><input type="radio" name="optProveedorBusqueda" data-nombre="'.$reg->nombre.'" id="'.$reg->idpersona.'" value="'.$reg->idpersona.'" /></td>
                 $i++; 
            }

        break;

    case "GetDetalleArticuloConsulta":
        require_once "../model/Ingreso.php";

        $objIngreso = new Ingreso();

        $idIngreso = $_POST["idIngreso"];

        $query_prov = $objIngreso->GetDetalleArticulo($idIngreso);

        $i = 1;
            while ($reg = $query_prov->fetch_object()) {
                 echo '<tr>
                        <td>'.$reg->articulo.'</td>
                        <td>'.$reg->nombreGeneral.'</td>
                        <td>'.$reg->laboratorioa.'</td>
                        <td>'.$reg->codigo.'</td>
                        <td>'.$reg->serie.'</td>
                        <td>'.$reg->unidad.'</td>
                        <td>'.$reg->fecha_vencimiento.'</td>
                        <td>'.$reg->forma_farmaceutica.'</td>
                        <td>'.$reg->presentacion.'</td>
                        <td>'.$reg->condicion_almacenamiento.'</td>
                        <td>'.$reg->stock_ingreso.'</td>
                        <td>'.$reg->stock_actual.'</td>
                        <td>'.$reg->stock_unidad.'</td>
                        <td>'.$reg->precio_compra.'</td>
                        <td>'.$reg->precio_ventadistribuidor.'</td>
                        <td>'.$reg->porcentaje_utilidad.'</td>
                        <td>'.$reg->precio_ventapublico.'</td>
                        
                       </tr>';
                       //<td><input type="radio" name="optProveedorBusqueda" data-nombre="'.$reg->nombre.'" id="'.$reg->idpersona.'" value="'.$reg->idpersona.'" /></td>
                 $i++; 
            }

        break;
        

    case "ListGetDetalleArticulo":
        require_once "../model/Ingreso.php";

        $objIngreso = new Ingreso();

        $idIngreso = $_POST["idIngreso"];

        $query_prov = $objIngreso->GetDetalleArticulo($idIngreso);

        $i = 1;
            while ($reg = $query_prov->fetch_object()) {
                if($reg->unidad=="1"){
                     $data[] = array(
                    "0"=>'<button type="button" class="btn btn-warning" data-toggle="tooltip" title="Agregar al detalle" onclick="AgregarDetProveedor('.$reg->idarticulo.',
                                    \''.$reg->articulo.'\',
                                    \''.$reg->laboratorioa.'\',
                                    \''.$reg->codigo.'\',
                                    \''.$reg->serie.'\',
                                    \''.$reg->unidad.'\',
                                    \''.$reg->fecha_vencimiento.'\',
                                    \''.$reg->forma_farmaceutica.'\',
                                    \''.$reg->presentacion.'\',
                                    \''.$reg->condicion_almacenamiento.'\',
                                    \''.$reg->stock_ingreso.'\',
                                    \''.$reg->stock_actual.'\',
                                    \''.$reg->stock_unidad.'\',
                                    \''.$reg->precio_compra.'\',
                                    \''.$reg->precio_ventadistribuidor.'\',
                                    \''.$reg->laboratorioas.'\',
                                    \''.$reg->precio_ventapublico.'\',
                                    \''.$reg->iddetalle_ingreso.'\')" name="optArtBusqueda[]" data-nombre="'.$reg->articulo.'" id="'.$reg->idarticulo.'" value="'.$reg->idarticulo.'" ><i class="fa fa-check" ></i> </button>',
                    "1"=>$reg->articulo." (".$reg->laboratorioa.")",
                    "2"=>$reg->codigo,
                    "3"=>$reg->serie,
                    "4"=>$reg->unidad,
                    "5"=>$reg->fecha_vencimiento,
                    "6"=>$reg->forma_farmaceutica,
                    "7"=>$reg->presentacion,
                    "8"=>$reg->condicion_almacenamiento,
                    "9"=>"0 , ".$reg->stock_ingreso,
                    "10"=>$reg->stock_actual,
                    "11"=>$reg->stock_unidad,
                    "12"=>$reg->precio_compra,
                    "13"=>$reg->precio_ventadistribuidor,
                    "14"=>$reg->laboratorioas,
                    "15"=>$reg->precio_ventapublico);
                }else{
                    $data[] = array(
                    "0"=>'<button type="button" class="btn btn-warning" data-toggle="tooltip" title="Agregar al detalle" onclick="AgregarDetProveedor('.$reg->idarticulo.',
                                    \''.$reg->articulo.'\',
                                    \''.$reg->laboratorioa.'\',
                                    \''.$reg->codigo.'\',
                                    \''.$reg->serie.'\',
                                    \''.$reg->unidad.'\',
                                    \''.$reg->fecha_vencimiento.'\',
                                    \''.$reg->forma_farmaceutica.'\',
                                    \''.$reg->presentacion.'\',
                                    \''.$reg->condicion_almacenamiento.'\',
                                    \''.$reg->stock_ingreso.'\',
                                    \''.$reg->stock_actual.'\',
                                    \''.$reg->stock_unidad.'\',
                                    \''.$reg->precio_compra.'\',
                                    \''.$reg->precio_ventadistribuidor.'\',
                                    \''.$reg->laboratorioas.'\',
                                    \''.$reg->precio_ventapublico.'\',
                                    \''.$reg->iddetalle_ingreso.'\')" name="optArtBusqueda[]" data-nombre="'.$reg->articulo.'" id="'.$reg->idarticulo.'" value="'.$reg->idarticulo.'" ><i class="fa fa-check" ></i> </button>',
                    "1"=>$reg->articulo." (".$reg->laboratorioa.")",
                    "2"=>$reg->codigo,
                    "3"=>$reg->serie,
                    "4"=>$reg->unidad,
                    "5"=>$reg->fecha_vencimiento,
                    "6"=>$reg->forma_farmaceutica,
                    "7"=>$reg->presentacion,
                    "8"=>$reg->condicion_almacenamiento,
                    "9"=>floor($reg->stock_ingreso/$reg->unidad)." , ".($reg->stock_ingreso-(floor($reg->stock_ingreso/$reg->unidad)*$reg->unidad)),
                    "10"=>$reg->stock_actual,
                    "11"=>($reg->stock_unidad-(floor($reg->stock_unidad/$reg->unidad)*$reg->unidad)),
                    "12"=>$reg->precio_compra,
                    "13"=>$reg->precio_ventadistribuidor,
                    "14"=>$reg->laboratorioas,
                    "15"=>$reg->precio_ventapublico);

                }
                    $i++;

                 // echo '<tr>
                 //        <td>'.$reg->articulo." (".$reg->laboratorioa.")".'</td>
                 //        <td>'.$reg->codigo.'</td>
                 //        <td>'.$reg->serie.'</td>
                 //        <td>'.$reg->descripcion.'</td>
                 //        <td>'.$reg->fecha_vencimiento.'</td>
                 //        <td>'.$reg->forma_farmaceutica.'</td>
                 //        <td>'.$reg->presentacion.'</td>
                 //        <td>'.$reg->condicion_almacenamiento.'</td>
                 //        <td>'.$reg->stock_ingreso.'</td>
                 //        <td>'.$reg->stock_actual.'</td>
                 //        <td>'.$reg->precio_compra.'</td>
                 //        <td>'.$reg->precio_ventadistribuidor.'</td>
                 //        <td>'.$reg->precio_ventapublico.'</td>
                        
                 //       </tr>';
                       //<td><input type="radio" name="optProveedorBusqueda" data-nombre="'.$reg->nombre.'" id="'.$reg->idpersona.'" value="'.$reg->idpersona.'" /></td>
                 // $i++; 
            }


            // $query_Tipo = $objArticulo->Listar();
            // $data = Array();
            // $i = 1;
            // while ($reg = $query_Tipo->fetch_object()) {

            //     $data[] = array(
            //         "0"=>'<button type="button" class="btn btn-warning" data-toggle="tooltip" title="Agregar al detalle" onclick="Agregar('.$reg->IdArticulo.',\''.$reg->Nombre.'\',\''.$reg->laboratorio.'\')" name="optArtBusqueda[]" data-nombre="'.$reg->Nombre.'" id="'.$reg->IdArticulo.'" value="'.$reg->IdArticulo.'" ><i class="fa fa-check" ></i> </button>',
            //         "1"=>$i,
            //         "2"=>$reg->Nombre,
            //         "3"=>$reg->Descripcion,
            //         "4"=>$reg->laboratorio);
            //     $i++;
            // }
            
            $results = array(
            "sEcho" => 1,
            "iTotalRecords" => count($data),
            "iTotalDisplayRecords" => count($data),
            "aaData"=>$data);
            echo json_encode($results);




        break;

    case "listProveedor":
        require_once "../model/Ingreso.php";

        $objIngreso = new Ingreso();

        $query_prov = $objIngreso->ListarProveedor();

        $i = 1;
            while ($reg = $query_prov->fetch_object()) {
                 echo '<tr>
                        <td><input type="radio" name="optProveedorBusqueda" data-nombre="'.$reg->nombre.'" id="'.$reg->idpersona.'" value="'.$reg->idpersona.'" /></td>
                        <td>'.$i.'</td>
                        <td>'.$reg->nombre.'</td>
                        <td>'.$reg->tipo_documento.'</td>
                        <td>'.$reg->num_documento.'</td>
                        <td>'.$reg->email.'</td>
                        <td>'.$reg->numero_cuenta.'</td>
                       </tr>';
                 $i++; 
            }

        break;
    case "listLaboratorio":
        require_once "../model/Ingreso.php";

        $objIngreso = new Ingreso();

        $query_prov = $objIngreso->ListarLaboratorio();

        $i = 1;
            while ($reg = $query_prov->fetch_object()) {
                 echo '<tr>
                        <td><input type="radio" name="optProveedorBusqueda" data-nombre="'.$reg->nombre.'" id="'.$reg->idpersona.'" value="'.$reg->idpersona.'" /></td>
                        <td>'.$i.'</td>
                        <td>'.$reg->nombre.'</td>
                        <td>'.$reg->tipo_documento.'</td>
                        <td>'.$reg->num_documento.'</td>
                        <td>'.$reg->email.'</td>
                        <td>'.$reg->numero_cuenta.'</td>
                       </tr>';
                 $i++; 
            }

        break;

    case "listSucursal":
        require_once "../model/Sucursal.php";

        $objSucursal = new Sucursal();

        $query_prov = $objSucursal->Listar();

        $i = 1;
            while ($reg = $query_prov->fetch_object()) {
                 echo '<tr>
                        <td><input type="radio" name="optSucursalBusqueda" data-nombre="'.$reg->razon_social.'" id="'.$reg->idsucursal.'" value="'.$reg->idsucursal.'" /></td>
                        <td>'.$i.'</td>
                        <td>'.$reg->razon_social.'</td>
                        <td>'.$reg->tipo_documento.' - '.$reg->num_documento.'</td>
                        <td>'.$reg->direccion.'</td>
                        <td>'.$reg->email.'</td>
                        <td> <img width=100px height=100px src='.$reg->logo.' /></td>
                       </tr>';
                 $i++; 
            }

        break;

     case "listTipoDoc":

            require_once "../model/Ingreso.php";

            $objIngreso = new Ingreso();

            $query_Categoria = $objIngreso->ListarTipoDocumento();

            //echo '<option value="">--Seleccione Comprobante--</option>';
            while ($reg = $query_Categoria->fetch_object()) {
                echo '<option value=' . $reg->nombre . '>' . $reg->nombre . '</option>';
            }

            break;

    case "GetTipoDocSerieNum":

            require_once "../model/Ingreso.php";

            $objIngreso = new Ingreso();

            $nombre = $_REQUEST["nombre"];

            $query_Categoria = $objIngreso->GetTipoDocSerieNum($nombre);

            $reg = $query_Categoria->fetch_object();

            echo json_encode($reg);

            break;
    case "listCb_Laboratorio":
            require_once "../model/Ingreso.php";

            $objIngreso = new Ingreso();

            $query_prov = $objIngreso->ListarLaboratorio();

            while ($reg = $query_prov->fetch_object()) {
                echo '<option value=' . $reg->idpersona . '>' . $reg->nombre . '</option>';
            }
/////////////
       

        // $i = 1;
        //     while ($reg = $query_prov->fetch_object()) {
        //          echo '<tr>
        //                 <td><input type="radio" name="optProveedorBusqueda" data-nombre="'.$reg->nombre.'" id="'.$reg->idpersona.'" value="'.$reg->idpersona.'" /></td>
        //                 <td>'.$i.'</td>
        //                 <td>'.$reg->nombre.'</td>
        //                 <td>'.$reg->tipo_documento.'</td>
        //                 <td>'.$reg->num_documento.'</td>
        //                 <td>'.$reg->email.'</td>
        //                 <td>'.$reg->numero_cuenta.'</td>
        //                </tr>';
        //          $i++; 
        //     }
//////////////////
            break;


}
	