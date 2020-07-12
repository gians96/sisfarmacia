$(document).on("ready", init);// Inciamos el jquery

var objC = new init();

function init(){


	var tabla = $('#tblForma_Farmaceutica').dataTable({
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
	
	ListadoForma_Farmaceutica();// Ni bien carga la pagina que cargue el metodo
	$("#VerForm").hide();// Ocultamos el formulario
	$("form#frmForma_Farmaceutica").submit(SaveOrUpdate);// Evento submit de jquery que llamamos al metodo SaveOrUpdate para poder registrar o modificar datos
	
	$("#btnNuevo").click(VerForm);// evento click de jquery que llamamos al metodo VerForm

	//$("#liCatRed").click(function(event) {
      //    $("#Cargar").load('view/Categoria.html');
        //  $.getScript("public/js/Categoria.js");
    //});

	function SaveOrUpdate(e){
		e.preventDefault();// para que no se recargue la pagina
        $.post("./ajax/Forma_FarmaceuticaAjax.php?op=SaveOrUpdate", $(this).serialize(), function(r){// llamamos la url por post. function(r). r-> llamada del callback
            
            Limpiar();
            //$.toaster({ priority : 'success', title : 'Mensaje', message : r});
            swal("Mensaje del Sistema", r, "success");
			  ListadoForma_Farmaceutica();
			  OcultarForm();
	        
        });
	};

	function Limpiar(){
		// Limpiamos las cajas de texto
		$("#txtIdForma").val("");
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

function ListadoForma_Farmaceutica(){ 
	var tabla = $('#tblForma_Farmaceutica').dataTable(
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
	        		url: './ajax/Forma_FarmaceuticaAjax.php?op=list',
					type : "get",
					dataType : "json",
					
					error: function(e){
				   		console.log(e.responseText);	
					}
	        	},
	        "bDestroy": true

    	}).DataTable();

};


function eliminarForma_Farmaceutica(id){// funcion que llamamos del archivo ajax/CategoriaAjax.php?op=delete linea 53
	bootbox.confirm("¿Esta Seguro de eliminar la Forma Farmaceutica?", function(result){ // confirmamos con una pregunta si queremos eliminar
		if(result){// si el result es true
			$.post("./ajax/Forma_FarmaceuticaAjax.php?op=delete", {id : id}, function(e){// llamamos la url de eliminar por post. y mandamos por parametro el id 
                
				console.log(e);	
				swal("Mensaje del Sistema", e, "success");
				//alert('entra');
				ListadoForma_Farmaceutica();
            });
		}
		
	})
}

function cargarDataForma_Farmaceutica(id, descripcion,abreviacion){// funcion que llamamos del archivo ajax/CategoriaAjax.php linea 52
		$("#VerForm").show();// mostramos el formulario
		$("#btnNuevo").hide();// ocultamos el boton nuevo
		$("#VerListado").hide();

		$("#txtIdForma").val(id);// recibimos la variable id a la caja de texto txtIdCategoria
	    $("#txtDescripcion").val(descripcion);// recibimos la variable nombre a la caja de texto txtNombre
	    $("#txtAbreviacion").val(abreviacion);// recibimos la variable nombre a la caja de texto txtNombre
}