<?php

	session_start();

	require_once "../model/Condicion_Almacenamiento.php";

	$objCondicion_Almacenamiento = new Condicion_Almacenamiento();

	switch ($_GET["op"]) {

		case 'SaveOrUpdate':			

			$descripcion = $_POST["txtDescripcion"]; // Llamamos al input txtDescripcion
			$abreviacion = $_POST["txtAbreviacion"]; // Llamamos al input txtabreviacion

			if(empty($_POST["txtIdCondicion"])){
				
				if($objCondicion_Almacenamiento->Registrar($descripcion,$abreviacion)){
					echo "Condicion de Almacenamiento Registrada";
				}else{
					echo "Condicion de Almacenamiento no ha podido ser registado.";
				}
			}else{
				
				$idCondicion_Almacenamiento = $_POST["txtIdCondicion"];
				if($objCondicion_Almacenamiento->Modificar($idCondicion_Almacenamiento, $descripcion,$abreviacion)){
					echo "Condicion de Almacenamiento actualizada";
				}else{
					echo "Informacion de la Condicion de Almacenamiento no ha podido ser actualizada.";
				}
			}
			break;

		case "delete":			
			
			$id = $_POST["id"];// Llamamos a la variable id del js que mandamos por $.post (Forma Farmaceutica.js (Linea 62))
			$result = $objCondicion_Almacenamiento->Eliminar($id);
			if ($result) {
				echo "Eliminado Exitosamente";
			} else {
				echo "No fue Eliminado";
			}
			break;
		
		case "list":

			$query_Tipo = $objCondicion_Almacenamiento->Listar();
			$data = Array();
			$i = 1;
			while ($reg = $query_Tipo->fetch_object()) {
				$data[] = array(
					"id"=>$i,
					"1"=>$reg->descripcion,
					"2"=>$reg->abreviacion,
					"3"=>'<button class="btn btn-warning" data-toggle="tooltip" title="Editar" onclick="cargarDataCondicion_Almacenamiento('.$reg->idcondicion_almacenamiento.',\''.$reg->descripcion.'\',\''.$reg->abreviacion.'\')"><i class="fa fa-pencil"></i> </button>&nbsp;'.
					'<button class="btn btn-danger" data-toggle="tooltip" title="Eliminar" onclick="eliminarCondicion_Almacenamiento('.$reg->idcondicion_almacenamiento.')"><i class="fa fa-trash"></i> </button>');
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
	