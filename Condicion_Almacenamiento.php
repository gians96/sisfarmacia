<?php

	session_start();

	if(isset($_SESSION["idusuario"]) && $_SESSION["mnu_almacen"] == 1){
		
		if ($_SESSION["superadmin"] != "S") {
			include "view/header.html";
			include "view/Condicion_Almacenamiento.html";
		} else {
			include "view/headeradmin.html";
			include "view/Condicion_Almacenamiento.html";
		}

		include "view/footer.html";
	} else {
		header("Location:index.html");
	}
		

