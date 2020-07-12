<?php

session_start();

switch ($_GET["op"]) {

    case 'Save':

    require_once "../model/Movimiento.php";

    $obj= new Movimiento();

        $idUsuario = $_POST["idUsuario"];
        $idSucursal = $_POST["idSucursal"];
        $idproveedor = $_POST["idproveedor"];
        $idlaboratorio = $_POST["idlaboratorio"];
        $tipo_comprobante = trim($_POST["tipo_comprobante"]);
        $serie_comprobante = $_POST["serie_comprobante"];
        $num_comprobante = $_POST["num_comprobante"];
        $impuesto = $_POST["impuesto"];
        $total = $_POST["total"];
        $referencia = $_POST["referencia"];
        $observacion = $_POST["observacion"];

        if(empty($idlaboratorio)){
            $idlaboratorio=14;
        }

        if(empty($_POST["idIngreso"])){
            $hosp = $obj->Registrar($idUsuario, $idSucursal, $idproveedor,$idlaboratorio, $tipo_comprobante, $serie_comprobante, $num_comprobante, $impuesto, $total, $_POST["detalle"]);
                if ($hosp) {
                    echo "Movimiento Registrado";
                } else {
                    echo "No se ha podido registrar el Movimiento";
                }
        } else {
            $hosp1=$obj->modificar($_POST["idIngreso"],$referencia,$observacion,$idUsuario,  $_POST["detalle"]);
            
            
            if($hosp1){
                echo "Movimiento Modificada";
            } else {
                echo "No se ha podido modificar la Movimiento";
            }
        }
                
        break;

    case "list":
        require_once "../model/Movimiento.php";

        $objIngreso = new Movimiento();

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
                    "6"=>$reg->fecha,
                    //$reg->estado,

                    "7"=>'<button class="btn btn-success" data-toggle="tooltip" title="Ver Detalle" 
                        onclick="cargarDataMovimiento('.$reg->idmovimiento.',
                                                    \''.$reg->serie_comprobante.'\',
                                                    \''.$reg->num_comprobante.'\',
                                                  
                                                    \''.$reg->proveedor.'\',
                                                    \''.$reg->laboratorio.'\',
                                                    \''.$reg->tipo_comprobante.'\',
                                                    \''.$reg->referencia.'\',
                                                    \''.$reg->observacion.'\')" >
                    <i class="fa fa-eye"></i> </button>'
                    
                                );
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
        require_once "../model/Movimiento.php";

        $objIngreso = new Movimiento();

        $idIngreso = $_POST["idIngreso"];

        $query_prov = $objIngreso->GetDetalleArticulo($idIngreso);

        $i = 1;
            while ($reg = $query_prov->fetch_object()) {
                 echo '<tr>
                        <td>'.$reg->articulo." (".$reg->laboratorioa.")".'</td>
                        <td>'.$reg->unidad.'</td>
                        <td>'.$reg->nlote.'</td>
                        <td>'.$reg->rsanitario.'</td>
                        <td>'.$reg->abreviacionff.'</td>
                        <td>'.$reg->abreviacionp.'</td>
                        <td>'.$reg->abreviacionca.'</td>
                        <td>'.$reg->stockact_antes.'</td>
                        <td>'.$reg->stockact_despues.'</td>
                        <td>'.$reg->stockuni_antes.'</td>
                        <td>'.$reg->stockuni_despues.'</td>
                        <td>S/.'.$reg->ventapublico_antes.'</td>
                        <td>S/.'.$reg->ventapublico_despues.'</td>

                       </tr>';
                       //<td><input type="radio" name="optProveedorBusqueda" data-nombre="'.$reg->nombre.'" id="'.$reg->idpersona.'" value="'.$reg->idpersona.'" /></td>
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

            require_once "../model/Movimiento.php";

            $objIngreso = new Movimiento();

            $query_Categoria = $objIngreso->ListarTipoDocumento();

            //echo '<option value="">--Seleccione Comprobante--</option>';
            while ($reg = $query_Categoria->fetch_object()) {
                echo '<option value=' . $reg->nombre . '>' . $reg->nombre . '</option>';
            }

            break;

    case "GetTipoDocSerieNum":

            require_once "../model/Movimiento.php";

            $objIngreso = new Movimiento();

            $nombre = $_REQUEST["nombre"];

            $query_Categoria = $objIngreso->GetTipoDocSerieNum($nombre);

            $reg = $query_Categoria->fetch_object();

            echo json_encode($reg);

            break;

}
	