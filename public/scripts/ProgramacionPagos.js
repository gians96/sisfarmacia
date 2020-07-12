$(document).on("ready", init);

function init(){

	var tabla = $('#tblProgramacionPagos').dataTable({
		dom: 'Bfrtip',
		buttons: [
		'copyHtml5',
		'excelHtml5',
		'csvHtml5',
		'pdfHtml5'
		]
	});


	$("#VerForm").hide();
	$("#txtRutaImgArt").hide();
	$("form#frmProgramacionPagos").submit(SaveOrUpdate);
	$("#btnNuevo").click(VerForm);
	ListadoProgramacionPagos();

	function SaveOrUpdate(e){
		e.preventDefault();

		var formData = new FormData($("#frmProgramacionPagos")[0]);

		$.ajax({

			url: "./ajax/ProgramacionPagosAjax.php?op=SaveOrUpdate",

			type: "POST",

			data: formData,

			contentType: false,

			processData: false,

			success: function(datos)

			{

				swal("Mensaje del Sistema", datos, "success");
				ListadoProgramacionPagos();
				OcultarForm();
				$('#frmProgramacionPagos').trigger("reset");
			}

		});
	};



	function Limpiar(){
		$("#txtIdSucursal").val("");
		$("#txtProgramacionPagos").val("");
		$("#txtNReferencia").val("");
		$("#txtProveedor").val("");
		$("#txtFecha_Pago").val("");
		$("#txtBanco").val("");
		$("#txtCodigoBanco").val("");
		$("#txtImporte").val("");
	}

	function VerForm(){
		$("#VerForm").show();
		$("#btnNuevo").hide();
		$("#VerListado").hide();
	}

			function OcultarForm(){
		$("#VerForm").hide();// Mostramos el formulario
		$("#btnNuevo").show();// ocultamos el boton nuevo
		$("#VerListado").show();
		}
}
function ListadoProgramacionPagos(){ 
	var tabla = $('#tblProgramacionPagos').dataTable(
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
		{   "mDataProp": "id"},
		{   "mDataProp": "1"},
		{   "mDataProp": "2"},
		{   "mDataProp": "3"},
		{   "mDataProp": "4"},
		{   "mDataProp": "5"},
		{   "mDataProp": "6"},
		{   "mDataProp": "7"}

		],"ajax": 
		{
			url: './ajax/ProgramacionPagosAjax.php?op=list',
			type : "get",
			dataType : "json",

			error: function(e,f,g){
				console.log(e.responseText+"  "+f+"   "+g);	
			}
		},
		"bDestroy": true

	}).DataTable();
	// console.log("entra a listado");	

};
function eliminarProgramacionPagos(id){
	bootbox.confirm("¿Esta Seguro de eliminar la Articulo?", function(result){
		if(result){
			$.post("./ajax/ProgramacionPagosAjax.php?op=delete", {id : id}, function(e){

				swal("Mensaje del Sistema", e, "success");
				ListadoProgramacionPagos();

			});
		}

	})
}

function cargarDataProgramacionPagos(idSucursal,idProgramacionPagos, nreferencia,idproveedor,proveedor,fechapago, banco, codigo_unico,importe,estado){
	$("#VerForm").show();
	$("#btnNuevo").hide();
	$("#VerListado").hide();

	$("#txtIdSucursal").val(idSucursal);
	$("#txtProgramacionPagos").val(idProgramacionPagos);
	$("#txtNReferencia").val(nreferencia);
	$("#txtIdProveedor").val(idproveedor);
	$("#txtProveedor").val(proveedor);
	$("#txtFecha_Pago").val(fechapago);
	$("#txtBanco").val(banco);
	$("#txtCodigoBanco").val(codigo_unico);
	$("#txtImporte").val(importe);
	$("#cbEstadoPP").val(estado);

}