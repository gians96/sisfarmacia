$(document).on("ready", init);// Inciamos el jquery

var objC = new init();

function init(){
 // $(document).ready(function() {
 //    $('.double-scroll').doubleScroll();
 //    $('#VerListado').doubleScroll({
 //        resetOnWindowResize: true
 //    });
 // });

 $("#tblVentaFechas").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });
 $("#tblVentasDetalladas").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });
 $("#tblVentasPendientes").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });
 $("#tblVentasContado").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });
 $("#tblVentasCredito").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });
 $("#tblVentasCliente").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });
 $("#tblVentaEmp").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });
 $("#tblVentaEmpDet").dataTable({
 	dom: 'Bfrtip',
 	buttons: [
 	'copyHtml5',
 	'excelHtml5',
 	'csvHtml5',
 	'pdfHtml5'
 	]
 });

 $("#cboFechaDesdeVent").change(ListadoVentasFechas);
 $("#cboFechaHastaVent").change(ListadoVentasFechas);

 $("#cboFechaDesdeDetVent").change(ListadoVentasDetalladas);
 $("#cboFechaHastaDetVent").change(ListadoVentasDetalladas);

 $("#cboFechaDesdeVentPend").change(ListadoVentasPendientes);
 $("#cboFechaHastaVentPend").change(ListadoVentasPendientes);

 $("#cboFechaDesdeVentCont").change(ListadoVentasContados);
 $("#cboFechaHastaVentCont").change(ListadoVentasContados);

 $("#cboFechaDesdeVentCred").change(ListadoVentasCredito);
 $("#cboFechaHastaVentCred").change(ListadoVentasCredito);

 $("#txtIdCliente").change(ListadoVentasCliente);
 $("#cboFechaDesdeCli").change(ListadoVentasCliente);
 $("#cboFechaHastaCli").change(ListadoVentasCliente);

 $("#cboFechaDesdeVentEmp").change(ListadoVentasEmpleado);
 $("#cboFechaHastaVentEmp").change(ListadoVentasEmpleado);

 $("#cboFechaDesdeVentEmpDet").change(ListadoVentasEmpleadoDet);
 $("#cboFechaHastaVentEmpDet").change(ListadoVentasEmpleadoDet);
}
function ListadoVentasFechas(){

	if($("#cboFechaDesdeVent").val() != "" && $("#cboFechaHastaVent").val() != ""){
		var fecha_desde = $("#cboFechaDesdeVent").val(), fecha_hasta = $("#cboFechaHastaVent").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblVentaFechas').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[
			{   "mDataProp": "0"},
			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"},
			{   "mDataProp": "11"}

			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasFechas',
				type : "get",
				dataType : "json",
				data:{fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},

				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();

	}
}

function ListadoVentasDetalladas(){
	// var table = $('#example')
	// .DataTable(	{
	// 	"fnInitComplete": function(){
 //                // Disable TBODY scoll bars
 //                $('.dataTables_scrollBody').css({
 //                	'overflow': 'hidden',
 //                	'border': '0'
 //                });

 //                // Enable TFOOT scoll bars
 //                $('.dataTables_scrollFoot').css('overflow', 'auto');

 //                $('.dataTables_scrollHead').css('overflow', 'auto');

 //                // Sync TFOOT scrolling with TBODY
 //                $('.dataTables_scrollFoot').on('scroll', function () {
 //                	$('.dataTables_scrollBody').scrollLeft($(this).scrollLeft());
 //                });      

 //                $('.dataTables_scrollHead').on('scroll', function () {
 //                	$('.dataTables_scrollBody').scrollLeft($(this).scrollLeft());
 //                });
 //            },
 //            "scrollX": true,
 //            "scrollCollapse": true,
 //            "dom": 'Zlrtip',
 //            "colResize": {
 //            	"tableWidthFixed": false,
 //                //"handleWidth": 10,
 //                "resizeCallback": function(column)
 //                {

 //                }
 //            },
 //            "searching":   false,
 //            "paging":   false,
 //            "info":     false,
 //            "deferRender": true,
 //            "sScrollX": "190%"
 //        });


 if($("#cboFechaDesdeDetVent").val() != "" && $("#cboFechaHastaDetVent").val() != ""){
 	var fecha_desde = $("#cboFechaDesdeDetVent").val(), fecha_hasta = $("#cboFechaHastaDetVent").val(), idsucursal = $("#txtIdSucursal").val();

 	var tabla = $('#tblVentasDetalladas').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[
			{   "mDataProp": "0"},
			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"},
			{   "mDataProp": "11"},
			{   "mDataProp": "12"},
			{   "mDataProp": "13"},
			{   "mDataProp": "14"},

			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasDetalladas',
				type : "get",
				dataType : "json",
				data:{fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},														
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();
 	$.ajax({
 		type: 'POST',
 		url: './ajax/ConsultasVentasAjax.php?op=listVentasDetalladasCaja',
 		dataType: 'json',
 		data: {fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
 		success: function (msg) {
 			console.log("retorno de valor"+msg);
 			$("#cajaDetallada").val(msg);
				// callback(null, data);
			},
			error: function (errorThrown) {callback(errorThown);}
		});



		// var cajaDetallada;
		// $.ajax({
		// 	url: './ajax/ConsultasVentasAjax.php?op=listVentasDetalladasCaja',
		// 	type: 'get',
		// 	dataType: 'json',
		// 	data: {fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
		// 	success: function(msg) { //add a success notice 
		// 		// showNotice("success",msg); 
		// 		console.log("retorno de valor"+msg);
		// 	/*clearForm(); */}, 
		// 	error: function(obj,text,error) { //show error 
		// 		showNotice("error",obj.responseText); }, 
		// 	complete: function(obj,text) { //remove whatever user feedback was shown in beforeSend 
		// 		// removeProcessing(); }

		// 	})
		// .done(function() {
		// 	console.log("success");
		// })
		// .fail(function() {
		// 	console.log("error");
		// })
		// .always(function() {
		// 	console.log("complete");
		// });
		

	}
}

function ListadoVentasPendientes(){

	if($("#cboFechaDesdeVentPend").val() != "" && $("#cboFechaHastaVentPend").val() != ""){
		var fecha_desde = $("#cboFechaDesdeVentPend").val(), fecha_hasta = $("#cboFechaHastaVentPend").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblVentasPendientes').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[
			{   "mDataProp": "0"},
			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"},
			{   "mDataProp": "11"},
			{   "mDataProp": "12"}

			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasPendientes',
				type : "get",
				dataType : "json",
				data:{fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();

	}
}

function ListadoVentasContados(){

	if($("#cboFechaDesdeVentCont").val() != "" && $("#cboFechaHastaVentCont").val() != ""){
		var fecha_desde = $("#cboFechaDesdeVentCont").val(), fecha_hasta = $("#cboFechaHastaVentCont").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblVentasContado').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[
			{   "mDataProp": "0"},
			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"}
			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasContado',
				type : "get",
				dataType : "json",
				data:{fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();


	}
}

function ListadoVentasCredito(){

	if($("#cboFechaDesdeVentCred").val() != "" && $("#cboFechaHastaVentCred").val() != ""){
		var fecha_desde = $("#cboFechaDesdeVentCred").val(), fecha_hasta = $("#cboFechaHastaVentCred").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblVentasCredito').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[
			{   "mDataProp": "0"},
			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"},
			{   "mDataProp": "11"},
			{   "mDataProp": "12"}

			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasCredito',
				type : "get",
				dataType : "json",
				data:{fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();
	}
}

function ListadoVentasCliente(){

	if($("#cboFechaDesdeCli").val() != "" && $("#cboFechaHastaCli").val() != "" && $("#txtIdCliente").val() != ""){
		var idCliente = $("#txtIdCliente").val(), fecha_desde = $("#cboFechaDesdeCli").val(), fecha_hasta = $("#cboFechaHastaCli").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblVentasCliente').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[
			{   "mDataProp": "0"},
			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"}

			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasCliente',
				type : "get",
				dataType : "json",
				data:{idCliente: idCliente, fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();
	}
}
function ListadoComprasDetProveedor(){

	if($("#cboFechaDesdeDetProv").val() != "" && $("#cboFechaHastaDetProv").val() != "" && $("#txtIdProveedor").val() != ""){
		var idProveedor = $("#txtIdProveedor").val(), fecha_desde = $("#cboFechaDesdeDetProv").val(), fecha_hasta = $("#cboFechaHastaDetProv").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblComprasDetProveedor').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[
			{   "mDataProp": "0"},
			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"},
			{   "mDataProp": "11"},
			{   "mDataProp": "12"},
			{   "mDataProp": "13"},
			{   "mDataProp": "14"},
			{   "mDataProp": "15"},
			{   "mDataProp": "16"}

			],"ajax": 
			{
				url: './ajax/ConsultasComprasAjax.php?op=listComprasDetProveedor',
				type : "get",
				dataType : "json",
				data:{idProveedor: idProveedor, fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();
	}
}

function ListadoVentasEmpleado(){

	if($("#cboFechaDesdeVentEmp").val() != "" && $("#cboFechaHastaVentEmp").val() != ""){
		var fecha_desde = $("#cboFechaDesdeVentEmp").val(), fecha_hasta = $("#cboFechaHastaVentEmp").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblVentaEmp').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[

			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"},
			{   "mDataProp": "11"}

			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasEmpleado',
				type : "get",
				dataType : "json",
				data:{fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();		
	}
}

function ListadoVentasEmpleadoDet(){

	if($("#cboFechaDesdeVentEmpDet").val() != "" && $("#cboFechaHastaVentEmpDet").val() != ""){
		var fecha_desde = $("#cboFechaDesdeVentEmpDet").val(), fecha_hasta = $("#cboFechaHastaVentEmpDet").val(), idsucursal = $("#txtIdSucursal").val();
		var tabla = $('#tblVentaEmpDet').dataTable(
			{   "aProcessing": true,
			"aServerSide": true,
			dom: 'Bfrtip',
			buttons: [
			'copyHtml5',
			'excelHtml5',
			'csvHtml5',
			'pdfHtml5'
			],
			"aoColumns":[

			{   "mDataProp": "1"},
			{   "mDataProp": "2"},
			{   "mDataProp": "3"},
			{   "mDataProp": "4"},
			{   "mDataProp": "5"},
			{   "mDataProp": "6"},
			{   "mDataProp": "7"},
			{   "mDataProp": "8"},
			{   "mDataProp": "9"},
			{   "mDataProp": "10"},
			{   "mDataProp": "11"},
			{   "mDataProp": "12"},
			{   "mDataProp": "13"},
			{   "mDataProp": "14"},
			{   "mDataProp": "15"}


			],"ajax": 
			{
				url: './ajax/ConsultasVentasAjax.php?op=listVentasEmpleadoDet',
				type : "get",
				dataType : "json",
				data:{fecha_desde: fecha_desde, fecha_hasta: fecha_hasta, idsucursal: idsucursal},
				error: function(e){
					console.log(e.responseText);	
				}
			},
			"bDestroy": true

		}).DataTable();			

	}
}


