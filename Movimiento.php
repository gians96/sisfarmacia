<?php

	session_start();

	if(isset($_SESSION["idusuario"]) && $_SESSION["mnu_compras"] == 1){

		if ($_SESSION["superadmin"] != "S") {
			include "view/header.html";
			include "view/Movimiento.html";
		} else {
			include "view/headeradmin.html";
			include "view/Movimiento.html";
		}

		include "view/footer.html";
	} else {
		header("Location:index.html");
	}
		

