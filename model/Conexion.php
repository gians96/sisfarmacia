<?php

	//$conexion = new mysqli("192.168.1.41", "urezola", "urezola", "bdrezola");
	// $conexion = new mysqli("192.168.1.36", "urezola", "urezola", "bdrezola");
	// $conexion = new mysqli("localhost", "root", "", "bdrezola_clean");

	 // $conexion = new mysqli("192.168.35.11", "urezola", "urezola", "bdrezola");
	 $conexion = new mysqli("localhost", "jfpexivs_urezola", "Gianmarcos96GG#0904", "jfpexivs_bdrezola");
	// $conexion = new mysqli("ip o calhost lugar donde esta ubicado ", "nombre de usuario en la bd", "contrañsea en la bd", "nombre de la base de datos");

	
	if (mysqli_connect_errno()) {
	    printf("Connect failed: %s\n", mysqli_connect_error());
	    exit();
	}
// Nombre de Usuario: jfpexivs
// Contraseña: 4G5Uen5qy7
// Dirección de CPanel: http://www.sisfarmacia.com:2082/
// Dirección de Cpanel Opcional: http://158.69.248.110:2082/
// Servidor FTP: ftp.sisfarmacia.com
// Servidor FTP Opcional: 158.69.248.110