$(document).on("ready", init);// Inciamos el jquery

var objC = new init();

function init(){


	var tabla = $('#tblCondicion_Almacenamiento').dataTable({
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5', 
            'excelHtml5',
            'csvHtml5',
            'pdfHtml5'
        ]
    });

	/*
		{
			"iDisplayLength": 2,
        "aLengthMenu": [10, 15, 20]
		}
	*/
	
	ListadoCondicion_Almacenamiento();// Ni bien carga la pagina que cargue el metodo
	$("#VerForm").hide();// Ocultamos el formulario
	$("form#frmCondicion_Almacenamiento").submit(SaveOrUpdate);// Evento submit de jquery que llamamos al metodo SaveOrUpdate para poder registrar o modificar datos
	
	$("#btnNuevo").click(VerForm);// evento click de jquery que llamamos al metodo VerForm

	//$("#liCatRed").click(function(event) {
      //    $("#Cargar").load('view/Presentacion.html');
        //  $.getScript("public/js/Presentacion.js");
    //});

	function SaveOrUpdate(e){
		e.preventDefault();// para que no se recargue la pagina
        $.post("./ajax/Condicion_AlmacenamientoAjax.php?op=SaveOrUpdate", $(this).serialize(), function(r){// llamamos la url por post. function(r). r-> llamada del callback
            
            Limpiar();
            //$.toaster({ priority : 'success', title : 'Mensaje', message : r});
            swal("Mensaje del Sistema", r, "success");
			  ListadoCondicion_Almacenamiento();
			  OcultarForm();
	        
        });
	};

	function Limpiar(){
		// Limpiamos las cajas de texto
		$("#txtIdCondicion").val("");
	    $("#txtDescripcion").val("");
	    $("#txtAbreviacion").val("");
	}

	function VerForm(){
		$("#VerForm").show();// Mostramos el formulario
		$("#btnNuevo").hide();// ocultamos el boton nuevo
		$("#VerListado").hide();// ocultamos el listado
	}

	function OcultarForm(){
		$("#VerForm").hide();// Mostramos el formulario
		$("#btnNuevo").show();// ocultamos el boton nuevo
		$("#VerListado").show();// ocultamos el listado
	}
	
}

function ListadoCondicion_Almacenamiento(){ 
	var tabla = $('#tblCondicion_Almacenamiento').dataTable(
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
                    {   "mDataProp": "3"}

        	],"ajax": 
	        	{
	        		url: './ajax/Condicion_AlmacenamientoAjax.php?op=list',
					type : "get",
					dataType : "json",
					
					error: function(e){
				   		console.log(e.responseText);	
					}
	        	},
	        "bDestroy": true

    	}).DataTable();

};


function eliminarCondicion_Almacenamiento(id){// funcion que llamamos del archivo ajax/Condicion_AlmacenamientoAjax.php?op=delete linea 53
	bootbox.confirm("¿Esta Seguro de eliminar la Condicion de Almacenamiento ?", function(result){ // confirmamos con una pregunta si queremos eliminar
		if(result){// si el result es true
			$.post("./ajax/Condicion_AlmacenamientoAjax.php?op=delete", {id : id}, function(e){// llamamos la url de eliminar por post. y mandamos por parametro el id 
                
				console.log(e);	
				swal("Mensaje del Sistema", e, "success");
				//alert('entra');
				ListadoCondicion_Almacenamiento();
            });
		}
		
	})
}

function cargarDataCondicion_Almacenamiento(id, descripcion,abreviacion){// funcion que llamamos del archivo ajax/Condicion_AlmacenamientoAjax.php linea 52
		$("#VerForm").show();// mostramos el formulario
		$("#btnNuevo").hide();// ocultamos el boton nuevo
		$("#VerListado").hide();

		$("#txtIdCondicion").val(id);// recibimos la variable id a la caja de texto txtIdCategoria
	    $("#txtDescripcion").val(descripcion);// recibimos la variable nombre a la caja de texto txtNombre
	    $("#txtAbreviacion").val(abreviacion);// recibimos la variable nombre a la caja de texto txtNombre
}