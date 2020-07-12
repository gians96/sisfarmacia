<?php

	session_start();

	require_once "../model/ProgramacionPagos.php";

	$objProgramacionPagos = new ProgramacionPagos();

	switch ($_GET["op"]) {

		case 'SaveOrUpdate':			
				
			$idSucursal = $_POST["txtIdSucursal"];
			$idProgramacionPagos = $_POST["txtProgramacionPagos"];
			$NReferencia = $_POST["txtNReferencia"];
			$idProveedor = $_POST["txtIdProveedor"];
			$fechaPago = $_POST["txtFecha_Pago"];
			$banco = $_POST["txtBanco"];
			$codigoBanco = $_POST["txtCodigoBanco"];
			$importe = $_POST["txtImporte"];
			$estado = $_POST["cbEstadoPP"];

	
			if(empty($_POST["txtProgramacionPagos"])){
				
				if($objProgramacionPagos->Registrar($idSucursal, $NReferencia, $idProveedor, $fechaPago,$banco,$codigoBanco,$importe,$estado)){
					echo "Programacion de Pagos Registrado";
				}else{
					echo "Programacion de Pagos no ha podido ser registado.-".$estado."-".$idProveedor;
				}
			}else{
				
				$idProgramacionPagos = $_POST["txtProgramacionPagos"];
				if($objProgramacionPagos->Modificar($idProgramacionPagos ,$NReferencia, $idProveedor, $fechaPago,$banco,$codigoBanco,$importe,$estado)){
					echo "Informacion del Programacion de Pagos ha sido actualizada";
				}else{
					echo "Informacion del Programacion de Pagos no ha podido ser actualizada.";
				}
			}
		

			break;

		case "delete":			
			
			$idProgramacionPagos = $_POST["id"];
			$result = $objProgramacionPagos->Eliminar($idProgramacionPagos);
			if ($result) {
				echo "Eliminado Exitosamente";
			} else {
				echo "No fue Eliminado";
			}
			break;
		
		case "list":
			$query_Tipo = $objProgramacionPagos->Listar();
			$data = Array();
            $i = 1;
     		while ($reg = $query_Tipo->fetch_object()) {
				$es=$reg->estado;
				if($es=='1'){
					$es='<span class="badge bg-green">PAGO</span>';
				}if ($es=='0') {
					$es='<span class="badge bg-red">FALTA PAGAR</span>';
				}
     			$data[] = array("id"=>$i,
					"1"=>$reg->nreferencia,
					"2"=>$reg->nombre,
					"3"=>$reg->fecha_pago,
					"4"=>$reg->banco,
					"5"=>$reg->importe,
					"6"=>$es,
					'<button class="btn btn-warning" data-toggle="tooltip" title="Editar" onclick="cargarDataProgramacionPagos('.$reg->idsucursal.',\''.$reg->idprogramacion_pagos.'\',\''.$reg->nreferencia.'\',\''.$reg->idproveedor.'\',\''.$reg->nombre.'\',\''.$reg->fecha_pago.'\',\''.$reg->banco.'\',\''.$reg->codigo_unico.'\',\''.$reg->importe.'\',\''.$reg->estado.'\')"><i class="fa fa-pencil"></i> </button>&nbsp;'.
					'<button class="btn btn-danger" data-toggle="tooltip" title="Eliminar" onclick="eliminarProgramacionPagos('.$reg->idprogramacion_pagos.')"><i class="fa fa-trash"></i> </button>');
				$i++;
			}
			$results = array(
            "sEcho" => 1,
        	"iTotalRecords" => count($data),
        	"iTotalDisplayRecords" => count($data),
            "aaData"=>$data);
			echo json_encode($results);
            
			break;
		

	}
	