<?php

	session_start();

	require_once "../model/Articulo.php";

	$objArticulo = new Articulo();

	switch ($_GET["op"]) {

		case 'SaveOrUpdate':			

			$idcategoria = $_POST["cboCategoria"];
			$idunidad_medida = $_POST["cboUnidadMedida"];

			// $idforma_farmaceutica = $_POST["cboFormaFarmaceutica"];
			// $idpresentacion = $_POST["cboPresentacion"];
			// $idcondicion_almacenamiento = $_POST["cboCondicionAlmacenamiento"];

			$idlaboratorio = $_POST["txtIdLaboratorio"];

			$nombre = $_POST["txtNombre"];
			$descripcion = $_POST["txtDescripcion"];
			$unidad = $_POST["txtUnidad"];
			// $imagen = $_FILES["imagenArt"]["tmp_name"];
			// $ruta = $_FILES["imagenArt"]["name"];

			// if(move_uploaded_file($imagen, "../Files/Articulo/".$ruta)){

			if(empty($_POST["txtIdArticulo"])){
				
				if($objArticulo->Registrar($idcategoria, $idunidad_medida, $nombre, $descripcion,$idlaboratorio,$unidad)){
					echo "Articulo Registrado";
				}else{
					echo "Articulo no ha podido ser registado.";
				}
			}else{
				
				$idarticulo = $_POST["txtIdArticulo"];
				if($objArticulo->Modificar($idarticulo, $idcategoria, $idunidad_medida, $nombre, $descripcion,$idlaboratorio,$unidad)){
					echo "Informacion del Articulo ha sido actualizada";
				}else{
					echo "Informacion del Articulo no ha podido ser actualizada.";
				}
			}
			// } else {
				// $ruta_img = $_POST["txtRutaImgArt"];
				// if(empty($_POST["txtIdArticulo"])){
					
				// 	if($objArticulo->Registrar($idcategoria, $idunidad_medida, $nombre, $descripcion, $ruta_img)){
				// 		echo "Articulo Registrado";
				// 	}else{
				// 		echo "Articulo no ha podido ser registado.";
				// 	}
				// }else{
					
				// 	$idarticulo = $_POST["txtIdArticulo"];
				// 	if($objArticulo->Modificar($idarticulo, $idcategoria, $idunidad_medida, $nombre, $descripcion, $ruta_img)){
				// 		echo "Informacion del Articulo ha sido actualizada";
				// 	}else{
				// 		echo "Informacion del Articulo no ha podido ser actualizada.";
				// 	}
				// }
			// }

			break;

		case "delete":			
			
			$id = $_POST["id"];
			$result = $objArticulo->Eliminar($id);
			if ($result) {
				echo "Eliminado Exitosamente";
			} else {
				echo "No fue Eliminado";
			}
			break;
		
		case "list":
			$query_Tipo = $objArticulo->Listar();
			$data = Array();
            $i = 1;
     		while ($reg = $query_Tipo->fetch_object()) {

     			$data[] = array("id"=>$reg->IdArticulo,
					"1"=>$reg->Nombre,
					"2"=>$reg->Descripcion,
					"3"=>$reg->Categoria,
					"4"=>$reg->Unidad_Medida,
					"5"=>$reg->laboratorio,
					"6"=>$reg->unidad,
					'<button class="btn btn-warning" data-toggle="tooltip" title="Editar" onclick="cargarDataArticulo('.$reg->IdArticulo.',\''.$reg->idcategoria.'\',\''.$reg->IdUnidad_Medida.'\',\''.$reg->idlaboratorio.'\',\''.$reg->laboratorio.'\',\''.$reg->Nombre.'\',\''.$reg->Descripcion.'\',\''.$reg->unidad.'\')"><i class="fa fa-pencil"></i> </button>&nbsp;'.
					'<button class="btn btn-danger" data-toggle="tooltip" title="Eliminar" onclick="eliminarArticulo('.$reg->IdArticulo.')"><i class="fa fa-trash"></i> </button>');
				$i++;
			}
			$results = array(
            "sEcho" => 1,
        	"iTotalRecords" => count($data),
        	"iTotalDisplayRecords" => count($data),
            "aaData"=>$data);
			echo json_encode($results);
            
			break;
		case "listArtElegir":
			$query_Tipo = $objArticulo->Listar();
			$data = Array();
            $i = 1;
     		while ($reg = $query_Tipo->fetch_object()) {

     			$data[] = array(
     				"0"=>'<button type="button" class="btn btn-warning" data-toggle="tooltip" title="Agregar al detalle" onclick="Agregar('.$reg->IdArticulo.',\''.$reg->Nombre.'\',\''.$reg->laboratorio.'\',\''.$reg->unidad.'\')" name="optArtBusqueda[]" data-nombre="'.$reg->Nombre.'" id="'.$reg->IdArticulo.'" value="'.$reg->IdArticulo.'" ><i class="fa fa-check" ></i> </button>',
     				"1"=>$i,
					"2"=>$reg->Nombre,
					"3"=>$reg->Descripcion,
					"4"=>$reg->laboratorio,
					"5"=>$reg->unidad
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

		case "listCategoria":
	        require_once "../model/Categoria.php";

	        $objCategoria = new Categoria();

	        $query_Categoria = $objCategoria->Listar();

	        while ($reg = $query_Categoria->fetch_object()) {
	            echo '<option value=' . $reg->idcategoria . '>' . $reg->nombre . '</option>';
	        }

	        break;
/*
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
*/
        case "listForma_Farmaceutica":
	        require_once "../model/Forma_Farmaceutica.php";

	        $objForma_Farmaceutica = new Forma_Farmaceutica();

	        $query_FormaFarmaceutica = $objForma_Farmaceutica->Listar();

	        while ($reg = $query_FormaFarmaceutica->fetch_object()) {
	            echo '<option value=' . $reg->idforma_farmaceutica . '>' . $reg->descripcion . '</option>';
	        }

	        break;

        case "listPresentacion":
	        require_once "../model/Presentacion.php";

	        $objPresentacion = new Presentacion();

	        $query_presentacion = $objPresentacion->Listar();

	        while ($reg = $query_presentacion->fetch_object()) {
	            echo '<option value=' . $reg->idpresentacion . '>' . $reg->descripcion . '</option>';
	        }

	        break;

		case "listCondicion_Almacenamiento":
	        require_once "../model/Condicion_Almacenamiento.php";

	        $objCondicion_Almacenamiento = new Condicion_Almacenamiento();

	        $queryCondicion_Almacenamiento = $objCondicion_Almacenamiento->Listar();

	        while ($reg = $queryCondicion_Almacenamiento->fetch_object()) {
	            echo '<option value=' . $reg->idcondicion_almacenamiento . '>' . $reg->descripcion ."	- ".$reg->abreviacion. '</option>';
	        }

	        break;
/*
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
*/
	    case "listUM":

	    	require_once "../model/Categoria.php";

	        $objCategoria = new Categoria();

	        $query_Categoria = $objCategoria->ListarUM();

	        while ($reg = $query_Categoria->fetch_object()) {
	            echo '<option value=' . $reg->idunidad_medida . '>' . $reg->nombre . '</option>';
	        }

	        break;


	}
	