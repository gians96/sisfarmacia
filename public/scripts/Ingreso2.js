$(document).on("ready", init);

var objinit = new init();

var bandera = 1;


 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
 * @name DoubleScroll
 * @desc displays scroll bar on top and on the bottom of the div
 * @requires jQuery
 *
 * @author Pawel Suwala - http://suwala.eu/
 * @author Antoine Vianey - http://www.astek.fr/
 * @version 0.5 (11-11-2015)
 *
 * Dual licensed under the MIT and GPL licenses:
 * https://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * 
 * Usage:
 * https://github.com/avianey/jqDoubleScroll
 */

// function doublescroll_detalleingreso() {
//     // body...
//      $(document).ready(function() {
//     $('.double-scroll').doubleScroll();
//     $('#div_table_det_ingreso').doubleScroll({
//         resetOnWindowResize: true
//     });
//  });

// }



(function( $ ) {

    jQuery.fn.doubleScroll = function(userOptions) {

        // Default options
        var options = {
            contentElement: undefined, // Widest element, if not specified first child element will be used
            scrollCss: {                
                'overflow-x': 'auto',
                'overflow-y': 'hidden'
            },
            contentCss: {
                'overflow-x': 'auto',
                'overflow-y': 'hidden'
            },
            onlyIfScroll: true, // top scrollbar is not shown if the bottom one is not present
            resetOnWindowResize: false, // recompute the top ScrollBar requirements when the window is resized
            timeToWaitForResize: 30 // wait for the last update event (usefull when browser fire resize event constantly during ressing)
        };
        
        $.extend(true, options, userOptions);
        
        // do not modify
        // internal stuff
        $.extend(options, {
            topScrollBarMarkup: '<div class="doubleScroll-scroll-wrapper" style="height: 20px;"><div class="doubleScroll-scroll" style="height: 20px;"></div></div>',
            topScrollBarWrapperSelector: '.doubleScroll-scroll-wrapper',
            topScrollBarInnerSelector: '.doubleScroll-scroll'
        });

        var _showScrollBar = function($self, options) {

            if (options.onlyIfScroll && $self.get(0).scrollWidth <= $self.width()) {
                // content doesn't scroll
                // remove any existing occurrence...
                $self.prev(options.topScrollBarWrapperSelector).remove();
                return;
            }
            
            // add div that will act as an upper scroll only if not already added to the DOM
            var $topScrollBar = $self.prev(options.topScrollBarWrapperSelector);
            
            if ($topScrollBar.length == 0) {

                // creating the scrollbar
                // added before in the DOM
                $topScrollBar = $(options.topScrollBarMarkup);
                $self.before($topScrollBar);

                // apply the css
                $topScrollBar.css(options.scrollCss);
                $self.css(options.contentCss);

                // bind upper scroll to bottom scroll
                $topScrollBar.bind('scroll.doubleScroll', function() {
                    $self.scrollLeft($topScrollBar.scrollLeft());
                });

                // bind bottom scroll to upper scroll
                var selfScrollHandler = function() {
                    $topScrollBar.scrollLeft($self.scrollLeft());
                };
                $self.bind('scroll.doubleScroll', selfScrollHandler);
            }

            // find the content element (should be the widest one)  
            var $contentElement;        
            
            if (options.contentElement !== undefined && $self.find(options.contentElement).length !== 0) {
                $contentElement = $self.find(options.contentElement);
            } else {
                $contentElement = $self.find('>:first-child');
            }
            
            // set the width of the wrappers
            $(options.topScrollBarInnerSelector, $topScrollBar).width($contentElement.outerWidth());
            $topScrollBar.width($self.width());
            $topScrollBar.scrollLeft($self.scrollLeft());
            
        }
        
        return this.each(function() {

            var $self = $(this);
            
            _showScrollBar($self, options);
            
            // bind the resize handler 
            // do it once
            if (options.resetOnWindowResize) {

                var id;
                var handler = function(e) {
                    _showScrollBar($self, options);
                };
                
                $(window).bind('resize.doubleScroll', function() {
                    // adding/removing/replacing the scrollbar might resize the window
                    // so the resizing flag will avoid the infinite loop here...
                    clearTimeout(id);
                    id = setTimeout(handler, options.timeToWaitForResize);
                });

            }

        });

    }

}( jQuery ));


 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////
 elementos = new Array();

 elementosReg = new Array(); 

 var forma_farmaceuticac;
 var presentacionc;
 var cond_almacenamientoc;

 function init() {
    sessionStorage.idSucursal = $("#txtIdSucursal").val();
    sessionStorage.Sucursal = $("#txtSucursal").val();

    $.post("./ajax/ArticuloAjax.php?op=listForma_Farmaceutica", function(r){ forma_farmaceuticac=r; return r});
    $.post("./ajax/ArticuloAjax.php?op=listPresentacion", function(r){ presentacionc=r; return r});
    $.post("./ajax/ArticuloAjax.php?op=listCondicion_Almacenamiento", function(r){ cond_almacenamientoc=r; return r});
    
    
    $('#tblIngresos').dataTable({
        dom: 'Bfrtip',
        buttons: [
        'copyHtml5',
        'excelHtml5',
        'csvHtml5',
        'pdfHtml5'
        ]
    });
    
    var tabla = $('#tblArticulosIng').dataTable({
        "iDisplayLength": 4,
        "aLengthMenu": [2, 4]
    });



    ComboTipoDoc();
    ListadoIngresos();
    GetImpuesto();
    ToolTip();
    $("#VerForm").hide();

   // $("#btnAgregar").click(AgregarDetalleIngreso)
   // $("#cboTipoComprobanteIng").change(VerNumSerie);
   $("#btnBuscarProveedor").click(AbrirModalProveedor);
   $("#btnBuscarLaboratorio").click(AbrirModalLaboratorio);
   $("#btnBuscarSucursal").click(AbrirModalSucursal);
   $("#btnBuscarSucursal2").click(AbrirModalSucursal);
   $("#btnBuscarArt").click(AbrirModalArticulo);
   $("#btnBuscarArtProveedor").click(AbrirModalArticuloProveedor);

   $("#frmIngresos").submit(GuardarIngreso);

   $("#btnAgregarProveedor").click(function(e){
      e.preventDefault();

      var opt = $("input[type=radio]:checked");
      $("#txtIdProveedor").val(opt.val());
      $("#txtProveedor").val(opt.attr("data-nombre"));

      $("#modalListadoProveedor").modal("hide");
  });

   $("#btnAgregarLaboratorio").click(function(e){
    e.preventDefault();

    var opt = $("input[type=radio]:checked");
    $("#txtIdLaboratorio").val(opt.val());
    $("#txtLaboratorio").val(opt.attr("data-nombre"));
        // alert($("#txtIdLaboratorio").val());
        $("#modalListadoLaboratorio").modal("hide");
    });

   $("#btnAgregarSucursal").click(function(e){
    e.preventDefault();

    var opt = $("input[type=radio]:checked");
    $("#txtIdSucursal").val(opt.val());
    $("#txtSucursal").val(opt.attr("data-nombre"));

    $("#txtIdSucursal2").val(opt.val());
    $("#txtSucursal2").val(opt.attr("data-nombre"));

    $("#modalListadoSucursal").modal("hide");
});


   $("#btnAgregarArt").click(function(e){
      e.preventDefault();

      var opt =  tabla.$("input[name='optArtBusqueda[]']:checked", {"page": "all"});

      opt.each(function() {

       AgregarDetalle($(this).val(), $(this).attr("data-nombre"), "", "", "","","","","", "1", "1", "1","1", "1");
   })

      $("#modalListadoArticulos").modal("hide");
  });

   $("#txtStockIng").keypress(function total_suma(){
    var suma = 0;
    alert("s");
    $("#txtTotal").val("23");
});

   function ToolTip() {

    $(document).ready(function(){
        $("#TT_USTOCK").tooltip({title: "", container: ".parent"});

    });
}

function Agregar(){
    var idArt = document.getElementsByName("txtIdArticulo");
    var iddetingreso = document.getElementsByName("txtIdDetalleIngreso");
    var cod = document.getElementsByName("txtCodgo");
    var serie = document.getElementsByName("txtSeries");
    var desc = document.getElementsByName("txtUnidad");
    var stock_ing = document.getElementsByName("txtStockIng");
    var stock_act = document.getElementsByName("txtStockAct");
    var stock_uni = document.getElementsByName("txtStockUnidad");
    var prec_comp = document.getElementsByName("txtPrecioComp");
    var prec_ventaD = document.getElementsByName("txtPrecioVentD");
    var utilidad = document.getElementsByName("txtUtilidad");
    var prec_ventaP = document.getElementsByName("txtPrecioVentaP");
        // alert('entra a funcion Agregar');

        var f_farmaceutica = document.getElementsByName("cboFormaFarmaceutica");
        var present = document.getElementsByName("cboPresentacion");
        var c_almacenamiento = document.getElementsByName("cboCondicion_Almacenamiento");

        var fecha_vencimiento = document.getElementsByName("txtFecha_Vencimiento");

        // var prec_ventaP = document.getElementsByName("txtNumero_Lote");
        // var prec_ventaP = document.getElementsByName("txtRegistro_Sanitario");
        /*
		var idArt = document.frmIngresos.elements["txtIdArticulo[]"];
		var cod = document.frmIngresos.elements["txtCodgo[]"];
        var serie = document.frmIngresos.elements["txtSerie[]"];
        var desc = document.frmIngresos.elements["txtDescripcion[]"];
        var stock_ing = document.frmIngresos.elements["txtStockIng[]"];
        //var stock_act = document.frmIngresos.elements["txtStockAct[]"];
        var prec_comp = document.frmIngresos.elements["txtPrecioComp[]"];
        var prec_ventaD = document.frmIngresos.elements["txtPrecioVentD[]"];
        var prec_ventaP = document.frmIngresos.elements["txtPrecioVentaP[]"];
        */


        for (var i = 0; i < stock_ing.length; i++) {
            if (stock_ing[i].value !== "") {
                AgregarDetalleRegistrar(idArt[i].value, 
                    cod[i].value, 
                    serie[i].value, 
                    desc[i].value, 
                    fecha_vencimiento[i].value,
                    f_farmaceutica[i].value,
                    present[i].value,
                    c_almacenamiento[i].value,
                    stock_ing[i].value,
                    stock_act[i].value,
                    prec_comp[i].value,
                    stock_uni[i].value,

                    prec_ventaD[i].value,
                    utilidad[i].value,
                    prec_ventaP[i].value,
                    iddetingreso[i].value
                    );
            }
        }

    }
    
    function GuardarIngreso(e){
      e.preventDefault();

      if ($("#txtIdProveedor").val() != "") {
        if ($("#cboTipoComprobanteIng").val() != "") {
            if (elementos.length > 0) {
                Agregar();
                var detalle =  JSON.parse(consultarReg());

                var data = { 
                    idUsuario : $("#txtIdUsuario").val(),
                    idSucursal : $("#txtIdSucursal").val(),
                    idIngreso : $("#txtIdIngreso").val(),
                    referencia : $("#txtReferencia").val(),
                    observacion : $("#txtObservacion").val(),
                    idproveedor : $("#txtIdProveedor").val(),
                    idlaboratorio : $("#txtIdLaboratorio").val(),

                    tipo_comprobante : $("#cboTipoComprobanteIng").val(),
                    serie_comprobante : $("#txtSerie").val(),
                    num_comprobante : $("#txtNumero").val(),
                    impuesto : $("#txtImpuesto").val(),
                    total : $("#txtTotal").val(),
                    detalle : detalle
                };

                $.post("./ajax/IngresoAjax.php?op=Save", data, function(r){
                    swal("Mensaje del Sistema", r, "success");
                    // alert(r);
                    Limpiar();
                    OcultarForm();
                    ListadoIngresos();
                });
            } else {
                bootbox.alert("Debe agregar articulos al detalle");
            }
        } else {
            bootbox.alert("Debe seleccionar un tipo de comprobante");
        }
    } else {
        bootbox.alert("Debe elegir un Proveedor");
    }
}

function Limpiar(){
    $("#txtIdSucursal").val(sessionStorage.idSucursal);
    $("#txtSucursal").val(sessionStorage.Sucursal);
    $("#txtIdProveedor").val("");
    $("#txtProveedor").val("");
    $("#txtIdLaboratorio").val("");
    $("#txtLaboratorio").val("");
       // $("#cboTipoComprobanteIng").val("");
       $("#txtSerie").val("");
       $("#txtNumero").val("");
       $("#txtSubTotal").val("");
       $("#txtIgv").val("");
       $("#txtTotal").val("");
       elementosReg.length = 0;
       elementos.length = 0;
       $("#tblDetalleIngreso tbody").html("");
   }

   function ComboTipoDoc() {

    $.get("./ajax/IngresoAjax.php?op=listTipoDoc", function(r) {
        $("#cboTipoComprobanteIng").html(r);

    })
}

function GetImpuesto() {

    $.getJSON("./ajax/GlobalAjax.php?op=GetImpuesto", function(r) {
        $("#txtImpuesto").val(r.porcentaje_impuesto);
        $("#SubTotal").html(r.simbolo_moneda + " Sub Total:");
        $("#IGV").html(r.simbolo_moneda + " IGV %:");
        $("#Total").html(r.simbolo_moneda + " Total:");                
    })
}

function VerForm(){
    $("#VerForm").show();
    $("#btnNuevo").hide();
    $("#VerListado").hide();

}

function OcultarForm(){
    $("#VerForm").hide();
    $("#btnNuevo").show();
    $("#VerListado").show();
}

function AbrirModalProveedor(){
  $("#tblProveedores").DataTable().destroy();
  $("#modalListadoProveedor").modal("show");
  $.post("./ajax/IngresoAjax.php?op=listProveedor", function(r){

    $("#Proveedor").html(r);
    $("#tblProveedores").DataTable( {
        "lengthMenu": [[8, 25, 50, -1], [8, 25, 50, "All"]]
    } );
});
}

function AbrirModalLaboratorio(){
  $("#tblLaboratorio").DataTable().destroy();

  $("#modalListadoLaboratorio").modal("show");
  $.post("./ajax/IngresoAjax.php?op=listLaboratorio", function(r){
    $("#Laboratorio").html(r);
    $("#tblLaboratorio").DataTable( {
        "lengthMenu": [[8, 25, 50, -1], [8, 25, 50, "All"]]
    } );
});
}
function AbrirModalSucursal(){
    $("#modalListadoSucursal").modal("show");

    $.post("./ajax/IngresoAjax.php?op=listSucursal", function(r){
        $("#Sucursales").html(r);
        $("#tblSucursales").DataTable();
    });
}

function AbrirModalArticulo(){
        // $("#btnVerArticulosProveedor").show();

        $("#modalListadoArticulos").modal("show");
        var tabla = $('#tblArticulosIng').dataTable(
            {   "aProcessing": true,
            "aServerSide": true,
            "iDisplayLength": 4,
                //"aLengthMenu": [0, 4],
                "aoColumns":[
                {   "mDataProp": "0"},
                {   "mDataProp": "1"},
                {   "mDataProp": "2"},
                {   "mDataProp": "3"},
                {   "mDataProp": "4"},
                {   "mDataProp": "5"}

                ],"ajax": 
                {
                    url: './ajax/ArticuloAjax.php?op=listArtElegir',
                    type : "get",
                    dataType : "json",

                    error: function(e){
                        console.log(e.responseText);    
                    }
                },
                "bDestroy": true

            }).DataTable();
    }

    function AbrirModalArticuloProveedor(){
        // alert($("#txtIdIngreso").val());

        $("#modalListadoArticulosProveedor").modal("show");
        var tabla = $('#tblArticulosIngProveedor').dataTable(
            {   "aProcessing": true,
            "aServerSide": true,
            "iDisplayLength": 4,
                //"aLengthMenu": [0, 4],
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
                {   "mDataProp": "15"}

                ],"ajax": 
                {
                    url: './ajax/IngresoAjax.php?op=ListGetDetalleArticulo',
                    type : "post",
                    data:{
                        idIngreso:$("#txtIdIngreso").val()
                    },
                    dataType : "json",

                    error: function(jqXHR,txtStatus,errorthrown){
                        // callback.error();
                       console.log(errorthrown);
                        console.log(jqXHR.responseText+txtStatus.responseText+errorthrown.responseText);    
    
                    }
                },
                "bDestroy": true

            }).DataTable();

    }

    
    /*

    function GuardarIngreso(e) {
        e.preventDefault();
        var detalle = JSON.parse(consultar());

        var data;

        if(bandera === 1){
            data = {
                idCategoria: $("#cboCategoria").val(),
                titulo: $("#txtTitulo").val(),
                descripcion: $("#txtDescripcion").val(),
                slide: $("#cboSlide").val(),
                imagen_principal: $("#txtRutaImagenPrinc").val(),
                detalle: detalle
            };
        } else {
            data = {
                idIngreso : $("#txtIdIngreso").val(),
                idCategoria: $("#cboCategoria").val(),
                titulo: $("#txtTitulo").val(),
                descripcion: $("#txtDescripcion").val(),
                slide: $("#cboSlide").val(),
                imagen_principal: $("#txtRutaImagenPrinc").val()
            };
        }
        
        $.post("./ajax/IngresoAjax.php?op=Save", data,  function(r) {
            alert(r);
            location.reload();
        });
        
    }

    */

    function AgregarDetalle(idart, nombre, codigo, serie, descripcion,f_vencimiento,forma_farmaceutica,presentacion,cond_almacenamiento, stock_ing, stock_act, p_compra, p_ventaD, p_ventaP) {
        var detalles = new Array(idart, nombre, codigo, serie, descripcion,f_vencimiento,forma_farmaceutica,presentacion,cond_almacenamiento, stock_ing, stock_act, p_compra, p_ventaD, p_ventaP);
        elementos.push(detalles);
        ConsultarDetalles();
    }

    function AgregarDetalleRegistrar(idart, codigo, serie, descripcion,f_vencimiento,forma_farmaceutica,presentacion,cond_almacenamiento, stock_ing, stock_act,stock_uni, p_compra, p_ventaD,utilidad, p_ventaP,iddeta_ingreso) {
        var detallesReg = new Array(idart, codigo, serie, descripcion,f_vencimiento,forma_farmaceutica,presentacion,cond_almacenamiento, stock_ing, stock_act,stock_uni, p_compra, p_ventaD, utilidad,p_ventaP,iddeta_ingreso);
        elementosReg.push(detallesReg);
    }

    

    function consultar() {
        return JSON.stringify(elementos);
    }

    function consultarReg() {
        return JSON.stringify(elementosReg);
    }

    this.eliminar = function(pos){
        //var pos = elementos[].indexOf( 'c' );
        console.log(pos);
        
        pos > -1 && elementos.splice(parseInt(pos),1);
        console.log(elementos);
        
        //this.elementos.splice(pos, 1);
        //console.log(this.elementos);
    };

    this.consultar = function(){
        /*
        for(i=0;i<this.elementos.length;i++){
            for(j=0;j<this.this.elementos[i].length;j++){
                console.log("Elemento: "+this.elementos[i][j]);
            }
        }
        */
        return JSON.stringify(elementos);
    };

    this.consultarReg = function(){
        /*
        for(i=0;i<this.elementos.length;i++){
            for(j=0;j<this.this.elementos[i].length;j++){
                console.log("Elemento: "+this.elementos[i][j]);
            }
        }
        */
        return JSON.stringify(elementosReg);
    };

};

function eliminarDetalle(ele){
    console.log("Elimina "+ele);
    objinit.eliminar(ele);
    ConsultarDetalles();
    calcularIgv();
    calcularSubTotal();
    regresarValoresUnidadCaja();
}

function AgregarFila(pos){
        //<td> <input class='form-control' type='hidden' name='txtIdArticulo' id='txtIdArticulo[]' value='1' /></td><td><input class='form-control' type='text' name='txtCodgo' id='txtCodgo[]' value='1' /></td><td><input class='form-control' type='text' name='txtSerie' id='txtSerie[]'  value='1' /></td><td><input class='form-control' type='text' name='txtDescripcion' id='txtDescripcion[]' value='1' /></td><td><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtStockIng' id='txtStockIng[]'   value='1' onkeyup='calcularTotal(" + pos + ");' required /></td><td><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioComp' id='txtPrecioComp[]'  value='1' onkeyup='calcularTotal(" + pos + ");' required /></td><td><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioVentD' id='txtPrecioVentD[]'  value='1' required /></td><td><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioVentaP' id='txtPrecioVentaP[]' value='1' required /></td><td WIDTH='100'><button type='button' data-toggle='tooltip' title='Quitar Articulo del detalle' onclick='eliminarDetalle(" + pos + ")' class='btn btn-danger'><i class='fa fa-remove' ></i> </button> <button type='button' data-toggle='tooltip' title='Pulse aqui para agregar mas filas de este articulo' onclick='AgregarFila(" + pos + ")' class='btn btn-success'><i class='fa fa-plus' ></i> </button></td>
        $("#tblDetalleIngreso tbody tr:eq(" + pos + ")").clone().appendTo("#tblDetalleIngreso tbody");
       //$("#tblDetalleIngreso tbody tr:last").after("<tr><td> <input class='form-control' type='hidden' name='txtIdArticulo' id='txtIdArticulo[]' value='1' /></td><td><input class='form-control' type='text' name='txtCodgo' id='txtCodgo[]' value='1' /></td><td><input class='form-control' type='text' name='txtSerie' id='txtSerie[]'  value='1' /></td><td><input class='form-control' type='text' name='txtDescripcion' id='txtDescripcion[]' value='1' /></td><td><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtStockIng' id='txtStockIng[]'   value='1' onkeyup='calcularTotal(" + pos + ");' required /></td><td><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioComp' id='txtPrecioComp[]'  value='1' onkeyup='calcularTotal(" + pos + ");' required /></td><td><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioVentD' id='txtPrecioVentD[]'  value='1' required /></td><td><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioVentaP' id='txtPrecioVentaP[]' value='1' required /></td><td WIDTH='100'><button type='button' data-toggle='tooltip' title='Quitar Articulo del detalle' onclick='eliminarDetalle(" + pos + ")' class='btn btn-danger'><i class='fa fa-remove' ></i> </button> <button type='button' data-toggle='tooltip' title='Pulse aqui para agregar mas filas de este articulo' onclick='AgregarFila(" + pos + ")' class='btn btn-success'><i class='fa fa-plus' ></i> </button></td></tr>");
   }


function ConsultarDetalles() {
    $("table#tblDetalleIngreso tbody").html("");
    var data = JSON.parse(objinit.consultar());
        // $('#trDI th:nth-child(11)').hide();
        // doublescroll_detalleingreso();
        // alert('entra consltar detalle('+$("#txtIdIngreso").val()+")");
        if ($("#txtIdIngreso").val() != "") {//Cuando se edita la factura los productos como cantidad precio
            
            for (var pos in data) {
                if(data[pos][4]=="1"){//Es cuando los productos vienen por unidad
                     $("table#tblDetalleIngreso").append("<tr><td>" + data[pos][1]+ " <input class='form-control' type='hidden' name='txtIdArticulo' id='txtIdArticulo[]' value='" + data[pos][0] + "' /><input class='form-control'  name='txtIdDetalleIngreso' type='hidden' id='txtIdDetalleIngreso[]' value='" + data[pos][16]+ "' /></td>"+
                    "<td><input class='form-control' type='text' disabled onkeyup='Modificar(" + pos + ");' name='txtCodgo' id='txtCodgo[]' value='" + data[pos][2] + "' /></td>"+
                    "<td><input class='form-control' type='text' disabled name='txtSeries' onkeyup='Modificar(" + pos + ");' id='txtSeries[]'  value='" + data[pos][3] + "' /></td>"+
                    "<td><input class='form-control' type='text' disabled name='txtUnidad' onkeyup='Modificar(" + pos + ");' id='txtUnidad[]' value='" + data[pos][4] + "' /></td>"+

                    "<td><input class='form-control' type='date' disabled name='txtFecha_Vencimiento'  id='txtFecha_Vencimiento[]' value='" + data[pos][5] + "' /></td>"+

                    "<td><div hidden=''><select  id='cboFormaFarmaceutica[]' name='cboFormaFarmaceutica' class='form-control'></select></div>"+data[pos][6] +"</td>"+
                    "<td><div hidden=''><select   id='cboPresentacion[]' name='cboPresentacion' class='form-control'></select></div>"+data[pos][7] +"</td>"+
                    "<td><div hidden=''><select   id='cboCondicion_Almacenamiento[]' name='cboCondicion_Almacenamiento' class='form-control'></select></div>"+data[pos][8] +"</td>"+


                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeypress='return justNumbers(event);' name='txtCajaIngreso' id='txtCajaIngreso["+pos+"]'   value='0' onkeyup='calcularTotal(" + pos + ");' required /></td>"+
                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeypress='return justNumbers(event);' name='txtUniIngreso' id='txtUniIngreso["+pos+"]'   value='" + data[pos][9]+ "' onkeyup='calcularTotal(" + pos + ");' required />"+
                    "<input class='form-control' disabled type='hidden' onkeypress='return justNumbers(event);' name='txtStockIng' id='txtStockIng[]'   value='" + data[pos][9] + "' onkeyup='calcularTotal(" + pos + ");' required /></td>"+
                    
                    "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtStockAct' id='txtStockAct[]'   value='" + data[pos][10] + "' onkeyup='calcularStockUnidad(" + pos + ");calcularTotal(" + pos + ");' onkeypress='calcularStockUnidad(" + pos + ");' required disabled /></td>"+
                    "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtStockUnidadM' id='txtStockUnidadM["+pos+"]'   value='" + data[pos][11] + "' onkeyup='Modificar(" + pos + ");calcularTotal(" + pos + ");' required />"+
                    "<input class='form-control' type='hidden' onkeypress='return justNumbers(event);' name='txtStockUnidad' id='txtStockUnidad[]'   value='" + data[pos][11] + "' required /></td>"+

                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioComp' id='txtPrecioComp[]'  value='" + data[pos][12] + "' onkeyup='calcularTotal(" + pos + ");' required /></td>"+
                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeyup='Modificar(" + pos + ");' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioVentD' id='txtPrecioVentD[]'  value='" + data[pos][13] + "' required /></td>"+
                    "<td WIDTH='20'><input class='form-control'  type='text' onkeyup='Modificar(" + pos + ");' onkeypress='return onKeyDecimal(event,this);' name='txtUtilidad' id='txtUtilidad[]'  value='" + data[pos][14] + "' required /></td>"+
                    "<td WIDTH='20'><input class='form-control'  type='text' onkeypress='return onKeyDecimal(event,this);' onkeyup='Modificar(" + pos + ");' name='txtPrecioVentaP' id='txtPrecioVentaP[]' value='" + data[pos][15] + "' required /></td>"+
                    "<td WIDTH='20'><button type='button' data-toggle='tooltip' title='Quitar Articulo del detalle' onclick='eliminarDetalle(" + pos + ")' class='btn btn-danger'><i class='fa fa-remove' ></i> </button> </td></tr>");
                }else{//cuando esta tie

                $("table#tblDetalleIngreso").append("<tr><td>" + data[pos][1]+ " <input class='form-control' type='hidden' name='txtIdArticulo' id='txtIdArticulo[]' value='" + data[pos][0] + "' /><input class='form-control'  name='txtIdDetalleIngreso' type='hidden' id='txtIdDetalleIngreso[]' value='" + data[pos][16]+ "' /></td>"+
                    "<td><input class='form-control' type='text' disabled onkeyup='Modificar(" + pos + ");' name='txtCodgo' id='txtCodgo[]' value='" + data[pos][2] + "' /></td>"+
                    "<td><input class='form-control' type='text' disabled name='txtSeries' onkeyup='Modificar(" + pos + ");' id='txtSeries[]'  value='" + data[pos][3] + "' /></td>"+
                    "<td><input class='form-control' type='text' disabled name='txtUnidad' onkeyup='Modificar(" + pos + ");' id='txtUnidad[]' value='" + data[pos][4] + "' /></td>"+

                    "<td><input class='form-control' type='date' disabled name='txtFecha_Vencimiento'  id='txtFecha_Vencimiento[]' value='" + data[pos][5] + "' /></td>"+

                    "<td><div hidden=''><select  id='cboFormaFarmaceutica[]' name='cboFormaFarmaceutica' class='form-control'></select></div>"+data[pos][6] +"</td>"+
                    "<td><div hidden=''><select   id='cboPresentacion[]' name='cboPresentacion' class='form-control'></select></div>"+data[pos][7] +"</td>"+
                    "<td><div hidden=''><select   id='cboCondicion_Almacenamiento[]' name='cboCondicion_Almacenamiento' class='form-control'></select></div>"+data[pos][8] +"</td>"+


                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeypress='return justNumbers(event);' name='txtCajaIngreso' id='txtCajaIngreso["+pos+"]'   value='" +(Math.floor(data[pos][9]/data[pos][4]))+ "' onkeyup='calcularTotal(" + pos + ");' required /></td>"+
                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeypress='return justNumbers(event);' name='txtUniIngreso' id='txtUniIngreso["+pos+"]'   value='" + (data[pos][9]%data[pos][4]) + "' onkeyup='calcularTotal(" + pos + ");' required />"+
                    "<input class='form-control' disabled type='hidden' onkeypress='return justNumbers(event);' name='txtStockIng' id='txtStockIng[]'   value='" + data[pos][9] + "' onkeyup='calcularTotal(" + pos + ");' required /></td>"+
                    
                    "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtStockAct' id='txtStockAct[]'   value='" + data[pos][10] + "' onkeyup='calcularStockUnidad(" + pos + ");calcularTotal(" + pos + ");' onkeypress='calcularStockUnidad(" + pos + ");'  required /></td>"+
                    "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtStockUnidadM' id='txtStockUnidadM["+pos+"]'   value='" + (data[pos][11]%data[pos][4]) + "' onkeyup='Modificar(" + pos + ");calcularTotal(" + pos + ");' required />"+
                    "<input class='form-control' type='hidden' onkeypress='return justNumbers(event);' name='txtStockUnidad' id='txtStockUnidad[]'   value='" + data[pos][11] + "' required /></td>"+

                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioComp' id='txtPrecioComp[]'  value='" + data[pos][12] + "' onkeyup='calcularTotal(" + pos + ");' required /></td>"+
                    "<td WIDTH='20'><input class='form-control' disabled type='text' onkeyup='Modificar(" + pos + ");' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioVentD' id='txtPrecioVentD[]'  value='" + data[pos][13] + "' required /></td>"+
                    "<td WIDTH='20'><input class='form-control'  type='text' onkeyup='Modificar(" + pos + ");' onkeypress='return onKeyDecimal(event,this);' name='txtUtilidad' id='txtUtilidad[]'  value='" + data[pos][14] + "' required /></td>"+
                    "<td WIDTH='20'><input class='form-control'  type='text' onkeypress='return onKeyDecimal(event,this);' onkeyup='Modificar(" + pos + ");' name='txtPrecioVentaP' id='txtPrecioVentaP[]' value='" + data[pos][15] + "' required /></td>"+
                    "<td WIDTH='20'><button type='button' data-toggle='tooltip' title='Quitar Articulo del detalle' onclick='eliminarDetalle(" + pos + ")' class='btn btn-danger'><i class='fa fa-remove' ></i> </button> </td></tr>");
                }

            }

        }else{
            for (var pos in data) {

            $("table#tblDetalleIngreso").append("<tr><td>" + data[pos][1]+ " <input class='form-control' type='hidden' name='txtIdArticulo' id='txtIdArticulo[]' value='" + data[pos][0] + "' /><input class='form-control'  name='txtIdDetalleIngreso' type='hidden' id='txtIdDetalleIngreso[]' value='" + data[pos][16] +"' /></td>"+
            "<td><input class='form-control' type='text' onkeyup='Modificar(" + pos + ");' name='txtCodgo' id='txtCodgo[]' value='" + data[pos][2] + "' /></td>"+
            "<td><input class='form-control' type='text' name='txtSeries' onkeyup='Modificar(" + pos + ");' id='txtSeries[]'  value='" + data[pos][3] + "' /></td>"+
            "<td><input class='form-control' type='text' disabled name='txtUnidad' onkeyup='Modificar(" + pos + ");' id='txtUnidad[]' value='" + data[pos][4] + "' /></td>"+
            "<td  WIDTH='20px'><input class='form-control' type='date' name='txtFecha_Vencimiento'  id='txtFecha_Vencimiento[]' value='" + data[pos][5] + "' /></td>"+

            "<td><select id='cboFormaFarmaceutica["+pos+"]' onclick='Modificar(" + pos + ");' name='cboFormaFarmaceutica' class='form-control'>"+forma_farmaceuticac+"</select></td>"+
            "<td><select id='cboPresentacion["+pos+"]' onclick='Modificar(" + pos + ");' name='cboPresentacion' class='form-control'>"+presentacionc+"</select></td>"+
            "<td><select id='cboCondicion_Almacenamiento["+pos+"]' onclick='Modificar(" + pos + ");' name='cboCondicion_Almacenamiento' class='form-control'>"+cond_almacenamientoc+"</select></td>"+


            "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtCajaIngreso' id='txtCajaIngreso["+pos+"]'  onkeypress='calcularStockUnidadIngreso(" + pos + ");' value='0' onkeyup='calcularTotal(" + pos + ");calcularStockUnidadIngreso(" + pos + ");calcularPrecioUnidadDistribuidor(" + pos + ");' required /></td>"+
            "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtUniIngreso' id='txtUniIngreso["+pos+"]' onkeypress='calcularStockUnidadIngreso(" + pos + ");'  value='0' onkeyup='calcularTotal(" + pos + ");calcularStockUnidadIngreso(" + pos + ");calcularPrecioUnidadDistribuidor(" + pos + ");' required />"+
            "<input class='form-control' type='hidden' onkeypress='return justNumbers(event);' name='txtStockIng' id='txtStockIng[]'   value='" + data[pos][9] + "' onkeyup='calcularTotal(" + pos + ");calcularStockUnidadIngreso(" + pos + ");' required /></td>"+


            "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return justNumbers(event);' name='txtStockAct' id='txtStockAct["+pos+"]'   value='" + data[pos][10] + "'  onkeyup='calcularStockUnidad(" + pos + ");calcularTotal(" + pos + ");' onkeypress='calcularStockUnidad(" + pos + ");' required /></td>"+
            "<td><input class='form-control' type='text'  onkeypress='return justNumbers(event);'  name='txtStockUnidadM' onkeyup='Modificar(" + pos + ");calcularTotal(" + pos + ");' id='txtStockUnidadM["+pos+"]' value='0' />"+
            "<input class='form-control' type='hidden'  onkeypress='return justNumbers(event);'  name='txtStockUnidad' onkeyup='Modificar(" + pos + ");' id='txtStockUnidad["+pos+"]' value='" + data[pos][11] + "' /></td>"+

            "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' name='txtPrecioComp' id='txtPrecioComp[]' onkeypress='calcularPrecioUnidadDistribuidor(" + pos + ");calcularPorcentajeUtilidad(" + pos + ");'  onkeyup='calcularPrecioUnidadDistribuidor(" + pos + ");calcularPorcentajeUtilidad(" + pos + ");' value='" + data[pos][12] + "' onkeyup='calcularTotal(" + pos + ");' required /></td>"+
            "<td WIDTH='20'><input class='form-control' disabled type='text' onkeyup='Modificar(" + pos + ");' onkeypress='return onKeyDecimal(event,this);calcularPorcentajeUtilidad(" + pos + ");'onkeyup='calcularPorcentajeUtilidad(" + pos + ");'   name='txtPrecioVentD' id='txtPrecioVentD[]'  value='" + data[pos][13] + "' required /></td>"+
            "<td WIDTH='20'><input class='form-control' type='text' onkeyup='Modificar(" + pos + ");' onkeypress='return onKeyDecimal(event,this);' name='txtUtilidad' id='txtUtilidad[]'  value='" + data[pos][14] + "' required /></td>"+
            "<td WIDTH='20'><input class='form-control' type='text' onkeypress='return onKeyDecimal(event,this);' onkeyup='Modificar(" + pos + ");' name='txtPrecioVentaP' id='txtPrecioVentaP[]' value='" + data[pos][15] + "' required /></td>"+
            "<td WIDTH='20'><button type='button' data-toggle='tooltip' title='Quitar Articulo del detalle' onclick='eliminarDetalle(" + pos + ")' class='btn btn-danger'><i class='fa fa-remove' ></i> </button> </td></tr>");
                    if(data[pos][4]==1){
                        $("input[id='txtCajaIngreso["+pos+"]']").prop('disabled', 'true');
                        $("input[id='txtStockAct["+pos+"]']").prop('disabled', 'true');

                    }

            }
           
        }

        console.log("1");
        regresarValoresUnidadCaja();
        console.log("22");
        calcularIgv();
        calcularSubTotal();
        calcularTotal();
}

function changeCbComprobante() {
        var data = JSON.parse(objinit.consultar());
        for (var pos in data) {
            Modificar(pos);
            calcularIgv(pos);
            calcularSubTotal(pos);
            calcularTotal(pos);
        }
}

function ListadoIngresos(){ 
    var tabla = $('#tblIngresos').dataTable(
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

        ],"ajax": 
        {
            url: './ajax/IngresoAjax.php?op=list',
            type : "get",
            dataType : "json",

            error: function(e){
                console.log(e.responseText);    
            }
        },
        "bDestroy": true

    }).DataTable();
 };

    function cargarDataIngreso(id, serie, numero, impuesto, total, idIngreso, Proveedor,Laboratorio, tipo_comprobante){
            bandera = 2;
            $("#VerForm").show();
            $("#btnNuevo").hide();
            $("#VerListado").hide();

            $("#btnRegistrarIng").hide();
            //$("#btnBuscarProveedor").hide();
            $("#btnVerArticulos").hide();

            // $("#VerMod").show();
            $("#txtProveedor").val(Proveedor);
            $("#txtLaboratorio").val(Laboratorio);
            $("#txtImpuesto").val(impuesto);
            $("#cboTipoComprobanteIng").html("<option>" + tipo_comprobante + "</option>");
            $("#txtSerie").val(serie);
            $("#txtTotal").val(Math.round(total*100)/100);
            var totalIgv=total * impuesto/(100+parseInt(impuesto));
            $("#txtIgv").val(Math.round(totalIgv*100)/100);
            var subTotal=total - (total * impuesto/(100+parseInt(impuesto)));
            $("#txtSubTotal").val(Math.round(subTotal*100)/100);
            $("#txtNumero").val(numero);
            CargarDetalleIngreso(idIngreso);
            CargarDetalleIngresoConsulta(idIngreso);
            //$('button[type="submit"]').attr('disabled','disabled');
            //$("#btnBuscarArt").prop("disabled", true);
            $("#btnBuscarProveedor").prop("disabled", true);
            $("#btnBuscarLaboratorio").prop("disabled", true);

            $("#btnBuscarSucursal").prop("disabled", true);

            $("#cboFechaDesde").hide();
            $("#cboFechaHasta").hide();
            $("#btnBuscarSucursal2").hide();
            $("#txtSucursal2").hide();
            $("#lblSucursal2").hide();
            $("#lblDesde").hide();
            $("#lblHasta").hide();
    }

    function cargarDataIngresoProveedor(id, serie, numero, impuesto, total, idIngreso,idProveedor, Proveedor,idLaboratorio,Laboratorio, tipo_comprobante){
        bandera = 2;
        $("#VerForm").show();
        $("#btnNuevo").hide();
        $("#VerListado").hide();
        $("#tblDetalleIngreso tbody").html("");

       // $("#VerMod").show();
       $("#btnVerArticulosProveedor").show();
       $("#VerMovimiento").show();

       $("#btnRegistrarIng").show();
        //$("#btnBuscarProveedor").hide();
        $("#btnVerArticulos").hide();

       // $("#VerMod").show();
       $("#txtIdProveedor").val(idProveedor);
       $("#txtProveedor").val(Proveedor);
       $("#txtIdLaboratorio").val(idLaboratorio);
       $("#txtLaboratorio").val(Laboratorio);

       $("#txtImpuesto").val(impuesto);
       $("#cboTipoComprobanteIng").html("<option>" + tipo_comprobante + "</option>");
       $("#txtSerie").val(serie);
       $("#txtIdIngreso").val(id);
       $("#txtTotal").val(Math.round(total*100)/100);
       var totalIgv=total * impuesto/(100+parseInt(impuesto));
       $("#txtIgv").val(Math.round(totalIgv*100)/100);
       var subTotal=total - (total * impuesto/(100+parseInt(impuesto)));
       $("#txtSubTotal").val(Math.round(subTotal*100)/100);
       $("#txtNumero").val(numero);
       CargarDetalleIngreso(idIngreso);
        //$('button[type="submit"]').attr('disabled','disabled');
        //$("#btnBuscarArt").prop("disabled", true);
        $("#btnBuscarProveedor").prop("disabled", true);
        $("#btnBuscarLaboratorio").prop("disabled", true);

        $("#btnBuscarSucursal").prop("disabled", true);

        $("#cboFechaDesde").hide();
        $("#cboFechaHasta").hide();
        $("#btnBuscarSucursal2").hide();
        $("#txtSucursal2").hide();
        $("#lblSucursal2").hide();
        $("#lblDesde").hide();
        $("#lblHasta").hide();
    }

    function cancelarIngreso(idIngreso){
        bootbox.confirm("¿Esta Seguro de Anular el ingreso?", function(result){
            if(result){
                $.post("./ajax/IngresoAjax.php?op=CambiarEstado", {idIngreso : idIngreso}, function(e){

                    swal("Mensaje del Sistema", e, "success");
                    ListadoIngresos();
                    
                });
            }
            
        })
    }

    function CargarDetalleIngreso(idIngreso) {
        // $('th:nth-child(12)').hide();
        // $('#trDI th:nth-child(16)').hide();
        $('#trDI th:nth-child(17)').hide();
        // $('#trDI th:nth-child(11)').hide();

        $.post("./ajax/IngresoAjax.php?op=GetDetalleArticulo", {idIngreso: idIngreso}, function(r) {
            $("table#tblDetalleIngreso tbody").html(r);

            
        })
    }

    function CargarDetalleIngresoConsulta(idIngreso) {
        // $('th:nth-child(12)').hide();
        // $('#trDI th:nth-child(16)').hide();
        $('#trDI th:nth-child(17)').hide();
        // $('#trDI th:nth-child(11)').hide();

        $.post("./ajax/IngresoAjax.php?op=GetDetalleArticuloConsulta", {idIngreso: idIngreso}, function(r) {
            $("table#tblDetalleIngresoConsulta tbody").html(r);

            
        })
    }


    function calcularIgv(){
        var suma = 0;

        var data = JSON.parse(objinit.consultar());


        if ($("#cboTipoComprobanteIng option:selected").val()=="FACTURA") {
            for (var pos in data) {
                // suma += parseFloat(data[pos][9] * data[pos][12]);
                suma += parseFloat(data[pos][9] * (data[pos][13]*100)/(100+parseInt($("#txtImpuesto").val())));
            }
            var totalIgv=suma*parseInt($("#txtImpuesto").val())/100 ;
            $("#txtIgv").val(Math.round(totalIgv*100)/100);


        } else {
            for (var pos in data) {
                // suma += parseFloat(data[pos][9] * data[pos][12]);
                suma += parseFloat(data[pos][9] * data[pos][13]);
            }
            var totalIgv=suma * parseInt($("#txtImpuesto").val())/(100+ parseInt($("#txtImpuesto").val())) ;
            $("#txtIgv").val(Math.round(totalIgv*100)/100);
        }
    }

    function calcularSubTotal(){
        var suma = 0;
        var data = JSON.parse(objinit.consultar());


        if ($("#cboTipoComprobanteIng option:selected").val()=="FACTURA") {
            for (var pos in data) {
                suma += parseFloat(data[pos][9] * (data[pos][13]*100)/(100+parseInt($("#txtImpuesto").val())));
                // suma += parseFloat(data[pos][9] * data[pos][12]);
            }
            var subTotal=suma;
            $("#txtSubTotal").val(Math.round(subTotal*100)/100);
        } 
        else {
            for (var pos in data) {
                // suma += parseFloat(data[pos][9] * data[pos][12]);
                suma += parseFloat(data[pos][9] * data[pos][13]);
            }
            var subTotal=suma - (suma * parseInt($("#txtImpuesto").val()) /(100+ parseInt($("#txtImpuesto").val())));
            $("#txtSubTotal").val(Math.round(subTotal*100)/100);
        }
    }

    function calcularTotal(posi){

        var suma = 0;
        var data = JSON.parse(objinit.consultar());



        if ($("#cboTipoComprobanteIng option:selected").val()=="FACTURA") {
            for (var pos in data) {
                suma += parseFloat(data[pos][9] * (data[pos][13]*100)/(100+parseInt($("#txtImpuesto").val())));
                // suma += parseFloat(data[pos][9] * data[pos][12]);
            }
            calcularIgv();
            calcularSubTotal();
            var total=suma+ suma*parseInt($("#txtImpuesto").val())/100;
            $("#txtTotal").val(Math.round(total*100)/100);



            if(posi != null){
              Modificar(posi);
            //alert(pos);
        }
        } else {
            for (var pos in data) {
            // suma += parseFloat(data[pos][9] * data[pos][12]);
            suma += parseFloat(data[pos][9] * data[pos][13]);
           // data[pos][11] = parseFloat(data[pos][10] * data[pos][4]);
           // data[pos][13] = parseFloat(data[pos][12] / data[pos][11]);
           // $("[name=txtStockUnidad]:eq("+pos+")").val(data[pos][11]); 
           // $("[name=txtPrecioVentD]:eq("+pos+")").val( data[pos][13]); 

            // var stock = document.getElementsByName("txtStockUnidad");
            // elementos[pos][11] =  data[pos][11];
            }   
        calcularIgv();
        calcularSubTotal();
        $("#txtTotal").val(Math.round(suma*100)/100);



        // // alert(data[posi][11]+"-"+data[posi][4]+"-"+data[posi][9]);
        // var unidad=parseFloat(data[posi][4]);
        // var stockunidad=parseFloat(data[posi][9]);
        // var totalstock=unidad*stockunidad;
        // $("#txtStockUnidad[]").val(totalstock);
        // alert(totalstock);
      // calcularTotal().off();
            if(posi != null){
          Modificar(posi);
            //alert(pos);
            }
        }
    }

//Consultar el stock de unidad debe ser solo para el ingreso y el stock actual va interactuar con las ventas y esta va a variar
function calcularStockUnidad(posi){
 var StockActUnidad = document.getElementsByName("txtStockUnidadM");

 var data = JSON.parse(objinit.consultar());

 
    for (var pos in data) {
        x=0;//unidad actucal
        y=0;//caja actual
        if(StockActUnidad[pos].value==""){
            x=0;
         }else{
            x=parseInt(StockActUnidad[pos].value);
         }
         if(data[pos][10]==""){
            y=0;
         }else{
            y=data[pos][10];
         }
         
        data[pos][11] = parseFloat((y * data[pos][4])+parseInt(x));//unidad total=stock actual caja/paq* stockUnidad +unidad suelto

        $("[name=txtStockUnidad]:eq("+pos+")").val(data[pos][11]); 
         
       }

   if(posi != null){
      Modificar(posi);
            //alert(pos);
        }
    }

function calcularStockUnidadIngreso(posi){
    var cajaIngreso = document.getElementsByName("txtCajaIngreso");
    var unidadIngreso = document.getElementsByName("txtUniIngreso");
    var data = JSON.parse(objinit.consultar());
        for (var pos in data) {
            x=0;//Caja
            y=0;//Unidad
            if(cajaIngreso[pos].value==""){
                x=0;
             }else{
                x=parseInt(cajaIngreso[pos].value);
             }
             if(unidadIngreso[pos].value==""){
                y=0;
             }else{
                y=parseInt(unidadIngreso[pos].value);
             }
           data[pos][9] = parseFloat((parseInt(x)* data[pos][4])+parseInt(y));//unidad total=stock actual * stockUnidad 
           $("[name=txtStockIng]:eq("+pos+")").val(data[pos][9]); 
        }



        if(posi != null){
      Modificar(posi);
            //alert(pos);
        }
}

function calcularPrecioUnidadDistribuidor(posi){

     var data = JSON.parse(objinit.consultar());
     if ($("#cboTipoComprobanteIng option:selected").val()=="FACTURA") {

        for (var pos in data) {

           data[pos][13] = parseFloat((data[pos][12]*(1+($("#txtImpuesto").val()/100)))/data[pos][4]);//precio distribuidor=precio compra*stock actual/unidad total
           $("[name=txtPrecioVentD]:eq("+pos+")").val(data[pos][13]); 
       }
   } else {
    for (var pos in data) {
        
           
           data[pos][13] = parseFloat(data[pos][12]/ data[pos][4]);//precio distribuidor=precio compra*stock actual/unidad total
           $("[name=txtPrecioVentD]:eq("+pos+")").val(data[pos][13]); 
       
       }
   }


   if(posi != null){
      Modificar(posi);
            //alert(pos);
        }
    }


    function calcularPorcentajeUtilidad(posi){

//         var data = JSON.parse(objinit.consultar());
//         for (var pos in data) {
//            data[pos][15] = parseFloat(data[pos][13])+parseFloat(data[pos][14]/100 * data[pos][13]);//porcentaje de utilidad
//            data[pos][15] = data[pos][15].toFixed(1)
//            $("[name=txtPrecioVentaP]:eq("+pos+")").val(data[pos][15]); 
//            // $("[name=txtPrecioVentD]:eq("+pos+")").val( data[pos][13]); 
//            // alert('entra '+ parseFloat(data[pos][13]) +$("[name=cboFormaFarmaceutica] > option[value="+ data[pos][6] +"]").val());
//        }

//        if(posi != null){
//           Modificar(posi);
//             //alert(pos);
//         }
}

    function Modificar(pos){

     var data = JSON.parse(objinit.consultar());
     var idArt = document.getElementsByName("txtIdArticulo");
     var cod = document.getElementsByName("txtCodgo");
     var serie = document.getElementsByName("txtSeries");
     var desc = document.getElementsByName("txtUnidad");

     var f_vencimiento=document.getElementsByName("txtFecha_Vencimiento");
     var forma_farmaceutica=document.getElementsByName("cboFormaFarmaceutica");
     var presentacion=document.getElementsByName("cboPresentacion");
     var cond_almacenamiento=document.getElementsByName("cboCondicion_Almacenamiento");
        // $("[name=cboFormaFarmaceutica] > option[value="+ data[pos][6].value +"]").attr("selected",true);
        // alert(forma_farmaceutica[pos].value +forma_farmaceutica[pos].innerHTML );
        var stock_ing = document.getElementsByName("txtStockIng");
        var stock_act = document.getElementsByName("txtStockAct");
        var stock_uni = document.getElementsByName("txtStockUnidad");
        var prec_comp = document.getElementsByName("txtPrecioComp");
        var prec_ventaD = document.getElementsByName("txtPrecioVentD");
        var utilidad = document.getElementsByName("txtUtilidad");
        var prec_ventaP = document.getElementsByName("txtPrecioVentaP");
        
        elementos[pos][2] = cod[pos].value;
        elementos[pos][3] = serie[pos].value;
        elementos[pos][4] = desc[pos].value;
        
        elementos[pos][5] = f_vencimiento[pos].value;
        elementos[pos][6] = forma_farmaceutica[pos].value;
        elementos[pos][7] = presentacion[pos].value;
        elementos[pos][8] = cond_almacenamiento[pos].value;

        elementos[pos][9] = stock_ing[pos].value;
        elementos[pos][10] = stock_act[pos].value;
        elementos[pos][11] = stock_uni[pos].value;

        elementos[pos][12] = prec_comp[pos].value;
        elementos[pos][13] = prec_ventaD[pos].value;
        elementos[pos][14] = utilidad[pos].value;
        elementos[pos][15] = prec_ventaP[pos].value;
       // alert(elementos[pos][3] + " " + serie[pos].value);
       calcularIgv();
       calcularSubTotal();
       calcularTotal();
       calcularStockUnidad();
       calcularPorcentajeUtilidad();
       calcularPrecioUnidadDistribuidor();
        //ConsultarDetalles();
    }

    function justNumbers(e) {
        var keynum = window.event ? window.event.keyCode : e.which;
        if ((keynum == 8 || keynum == 48))
            return true;
        if (keynum <= 47 || keynum >= 58) return false;
        return /\d/.test(String.fromCharCode(keynum));
    }

    function onKeyDecimal(e, field) {
        key = e.keyCode ? e.keyCode : e.which
        if (key == 8) return true
            if (key > 47 && key < 58) {
              if (field.value == "") return true
                  regexp = /.[0-9]{5}$/
              return !(regexp.test(field.value))
          }
          if (key == 46) {
              if (field.value == "") return false
                  regexp = /^[0-9]+$/
              return regexp.test(field.value)
          }
          return false
      }

      function AgregarDetalles(id1, id2, id3, id4, id5, id6, id7, id8, id9, id10){
        alert(id1 + " "+ id2 + " " + id3 + " " + id4 + " "+ id5 + " "+ id6 + " " + id7 + " " + id8 + " " + id9 + " " + id10);
    }

    function AgregarDetalle(idart, nombre, codigo, serie, descripcion, stock_ing, stock_act, p_compra, p_ventaD, p_ventaP, pos) {
        var cant = prompt("¿Cuantas series necesita?", "");
        for (var i = 1; i <= cant; i++) {
            var serie = prompt("Serie " + i + ":", "");
            if (serie != null) {
                var detalles = new Array(idart, nombre, elementos[pos][2], serie, elementos[pos][4], elementos[pos][5], 
                  elementos[pos][6], elementos[pos][7], elementos[pos][8], elementos[pos][9]);
                elementos.push(detalles);
                ConsultarDetalles();
            }
        }
        
    }

    function AgregarDetalleCarrito(idart, nombre, codigo, serie, unidad,f_vencimiento,forma_farm,presentacion,cond_almacenamiento, stock_ing, stock_act,stock_unidad, p_compra, p_ventaD,utilidad, p_ventaP) {
        var detalles = new Array(idart, nombre, codigo, serie, unidad,f_vencimiento,forma_farm,presentacion,cond_almacenamiento, stock_ing, stock_act,stock_unidad, p_compra, p_ventaD,utilidad, p_ventaP);
        elementos.push(detalles);
        ConsultarDetalles();
    }

    function AgregarDetalleCarritoProveedor(idart, nombre, codigo, serie, unidad,f_vencimiento,presentacion,cond_almacenamiento, stock_ing, stock_act,stock_unidad, p_compra, p_ventaD,utilidad, p_ventaP,iddet_ingreso,s) {
        var detalles = new Array(idart, nombre, codigo, serie, unidad,f_vencimiento,presentacion,cond_almacenamiento, stock_ing, stock_act ,stock_unidad,p_compra, p_ventaD,utilidad, p_ventaP,iddet_ingreso,s);
        elementos.push(detalles);
        ConsultarDetalles();
    }

    function Agregar(id, art,lab,unidad){

        art=art+"-"+lab;
        AgregarDetalleCarrito(id, art, "", "", unidad, "",null, null, null, "0", "0","0", "1", "1","0", "1");
        var data = JSON.parse(objinit.consultar());

        for (var pos in data) {
            if(unidad==1){
            x=data[pos][9];//unidad total de ingreso
            x1=Math.floor(x/unidad);
            x2=x%unidad;
            y=data[pos][11];//unidad total actual
            y1=Math.floor(y/unidad);
            y2=y%unidad;
            // $("input[id='txtCajaIngreso["+pos+"]']").val(x1);
            $("input[id='txtUniIngreso["+pos+"]']").val(x1);
           
             // $("input[id='txtStockAct["+pos+"]']").val(y1);
            $("input[id='txtStockUnidadM["+pos+"]']").val(y1);
            }else{
                  x=data[pos][9];//unidad total de ingreso
            x1=Math.floor(x/unidad);
            x2=x%unidad;
            y=data[pos][11];//unidad total actual
            y1=Math.floor(y/unidad);
            y2=y%unidad;
            $("input[id='txtCajaIngreso["+pos+"]']").val(x1);
            $("input[id='txtUniIngreso["+pos+"]']").val(x2);
           
             $("input[id='txtStockAct["+pos+"]']").val(y1);
            $("input[id='txtStockUnidadM["+pos+"]']").val(y2);
            }
          

            $("select[id='cboFormaFarmaceutica["+pos+"]']").find("option[value='"+elementos[pos][6]+"']").attr("selected",true);
            $("select[id='cboPresentacion["+pos+"]']").find("option[value='"+elementos[pos][7]+"']").attr("selected",true);
            $("select[id='cboCondicion_Almacenamiento["+pos+"]']").find("option[value='"+elementos[pos][8]+"']").attr("selected",true);


        }

    }

    function regresarValoresUnidadCaja() {
        var data = JSON.parse(objinit.consultar());

        for (var pos in data) {
            if(data[pos][4]==1){
                x=data[pos][9];//unidad total de ingreso
                x1=Math.floor(x/data[pos][4]);
                x2=x%data[pos][4];
                y=data[pos][11];//unidad total actual
                y1=Math.floor(y/data[pos][4]);
                y2=y%data[pos][4];
                // $("input[id='txtCajaIngreso["+pos+"]']").val(x1);
                $("input[id='txtUniIngreso["+pos+"]']").val(x1);
               
                 // $("input[id='txtStockAct["+pos+"]']").val(y1);
                $("input[id='txtStockUnidadM["+pos+"]']").val(y1);
            }else{
                x=data[pos][9];//unidad total de ingreso
                x1=Math.floor(x/data[pos][4]);
                x2=x%data[pos][4];
                y=data[pos][11];//unidad total actual
                y1=Math.floor(y/data[pos][4]);
                y2=y%data[pos][4];
                $("input[id='txtCajaIngreso["+pos+"]']").val(x1);
                $("input[id='txtUniIngreso["+pos+"]']").val(x2);
               
                 $("input[id='txtStockAct["+pos+"]']").val(y1);
                $("input[id='txtStockUnidadM["+pos+"]']").val(y2);
            }
           

        }// body...
    }

    function AgregarDetProveedor(idarticulo,articulo,laboratorioa,codigo,serie,descripcion,fecha_vencimiento,forma_farmaceutica,presentacion,condicion_almacenamiento,stock_ingreso,stock_actual,stock_unidad,precio_compra, precio_ventadistribuidor,utilidad,precio_ventapublico,iddet_ingreso){
        $('#trDI th:nth-child(17)').show();

        articulo=articulo+" ("+laboratorioa+")";
        AgregarDetalleCarritoProveedor(idarticulo, articulo, codigo, serie, descripcion, fecha_vencimiento,forma_farmaceutica, presentacion, condicion_almacenamiento, stock_ingreso, stock_actual,stock_unidad,precio_compra, precio_ventadistribuidor,utilidad, precio_ventapublico,iddet_ingreso,"1");

    }


// Agregar(){

// }
//     function getMachine(color, qty) {
//     $("#getMachine li").each(function() {
//         var thisArray = $(this).text().split("~");
//         if(thisArray[0] == color&& qty>= parseInt(thisArray[1]) && qty<= parseInt(thisArray[2])) {
//             return thisArray[3];
//         }
//     });

// }

// var retval = getMachine(color, qty);



