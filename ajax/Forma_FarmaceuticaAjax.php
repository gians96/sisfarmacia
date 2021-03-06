<?php

	session_start();

	require_once "../model/Forma_Farmaceutica.php";

	$objForma_Farmaceutica = new Forma_Farmaceutica();

	switch ($_GET["op"]) {

		case 'SaveOrUpdate':			

			$descripcion = $_POST["txtDescripcion"]; // Llamamos al input txtDescripcion
			$abreviacion = $_POST["txtAbreviacion"]; // Llamamos al input txtabreviacion

			if(empty($_POST["txtIdForma"])){
				
				if($objForma_Farmaceutica->Registrar($descripcion,$abreviacion)){
					echo "Forma Farmaceutica Registrada";
				}else{
					echo "Forma Farmaceutica no ha podido ser registado.";
				}
			}else{
				
				$idForma = $_POST["txtIdForma"];
				if($objForma_Farmaceutica->Modificar($idForma, $descripcion,$abreviacion)){
					echo "Forma Farmaceutica actualizada";
				}else{
					echo "Informacion de la Forma Farmaceutica no ha podido ser actualizada.";
				}
			}
			break;

		case "delete":			
			
			$id = $_POST["id"];// Llamamos a la variable id del js que mandamos por $.post (Forma Farmaceutica.js (Linea 62))
			$result = $objForma_Farmaceutica->Eliminar($id);
			if ($result) {
				echo "Eliminado Exitosamente";
			} else {
				echo "No fue Eliminado";
			}
			break;
		
		case "list":

			$query_Tipo = $objForma_Farmaceutica->Listar();
			$data = Array();
			$i = 1;
			while ($reg = $query_Tipo->fetch_object()) {
				$data[] = array(
					"id"=>$i,
					"1"=>$reg->descripcion,
					"2"=>$reg->abreviacion,
					"3"=>'<button class="btn btn-warning" data-toggle="tooltip" title="Editar" onclick="cargarDataForma_Farmaceutica('.$reg->idforma_farmaceutica.',\''.$reg->descripcion.'\',\''.$reg->abreviacion.'\')"><i class="fa fa-pencil"></i> </button>&nbsp;'.
					'<button class="btn btn-danger" data-toggle="tooltip" title="Eliminar" onclick="eliminarForma_Farmaceutica('.$reg->idforma_farmaceutica.')"><i class="fa fa-trash"></i> </button>');
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
	