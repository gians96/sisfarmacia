$(document).on("ready", init);// Inciamos el jquery

var objC = new init();

function init(){


	var tabla = $('#tblPresentacion').dataTable({
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
	
	ListadoPresentacion();// Ni bien carga la pagina que cargue el metodo
	$("#VerForm").hide();// Ocultamos el formulario
	$("form#frmPresentacion").submit(SaveOrUpdate);// Evento submit de jquery que llamamos al metodo SaveOrUpdate para poder registrar o modificar datos
	
	$("#btnNuevo").click(VerForm);// evento click de jquery que llamamos al metodo VerForm

	//$("#liCatRed").click(function(event) {
      //    $("#Cargar").load('view/Presentacion.html');
        //  $.getScript("public/js/Presentacion.js");
    //});

	function SaveOrUpdate(e){
		e.preventDefault();// para que no se recargue la pagina
        $.post("./ajax/PresentacionAjax.php?op=SaveOrUpdate", $(this).serialize(), function(r){// llamamos la url por post. function(r). r-> llamada del callback
            
            Limpiar();
            //$.toaster({ priority : 'success', title : 'Mensaje', message : r});
            swal("Mensaje del Sistema", r, "success");
			  ListadoPresentacion();
			  OcultarForm();
	        
        });
	};

	function Limpiar(){
		// Limpiamos las cajas de texto
		$("#txtIdPresentacion").val("");
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

function ListadoPresentacion(){ 
	var tabla = $('#tblPresentacion').dataTable(
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
	        		url: './ajax/PresentacionAjax.php?op=list',
					type : "get",
					dataType : "json",
					
					error: function(e){
				   		console.log(e.responseText);	
					}
	        	},
	        "bDestroy": true

    	}).DataTable();

};


function eliminarPresentacion(id){// funcion que llamamos del archivo ajax/PresentacionAjax.php?op=delete linea 53
	bootbox.confirm("¿Esta Seguro de eliminar la Presentación Farmaceutica?", function(result){ // confirmamos con una pregunta si queremos eliminar
		if(result){// si el result es true
			$.post("./ajax/PresentacionAjax.php?op=delete", {id : id}, function(e){// llamamos la url de eliminar por post. y mandamos por parametro el id 
                
				console.log(e);	
				swal("Mensaje del Sistema", e, "success");
				//alert('entra');
				ListadoPresentacion();
            });
		}
		
	})
}

function cargarDataPresentacion(id, descripcion,abreviacion){// funcion que llamamos del archivo ajax/PresentacionAjax.php linea 52
		$("#VerForm").show();// mostramos el formulario
		$("#btnNuevo").hide();// ocultamos el boton nuevo
		$("#VerListado").hide();

		$("#txtIdPresentacion").val(id);// recibimos la variable id a la caja de texto txtIdCategoria
	    $("#txtDescripcion").val(descripcion);// recibimos la variable nombre a la caja de texto txtNombre
	    $("#txtAbreviacion").val(abreviacion);// recibimos la variable nombre a la caja de texto txtNombre
}