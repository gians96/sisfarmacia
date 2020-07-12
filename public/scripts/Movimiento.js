$(document).on("ready", init);

var objinit = new init();

var bandera = 1;


elementos = new Array();

elementosReg = new Array(); 

var forma_farmaceuticac;
var presentacionc;
var cond_almacenamientoc;

function init() {
    sessionStorage.idSucursal = $("#txtIdSucursal").val();
    sessionStorage.Sucursal = $("#txtSucursal").val();

  
    
    $('#tblMovimiento').dataTable({
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5',
            'pdfHtml5'
        ]
    });
    

ListadoMovimiento();

    $("#VerForm").hide();

  




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
        $("#tblDetalleMovimiento tbody").html("");
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
};




function ListadoMovimiento(){ 
        var tabla = $('#tblMovimiento').dataTable(
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

            ],"ajax": 
                {
                    url: './ajax/MovimientoAjax.php?op=list',
                    type : "get",
                    dataType : "json",
                    
                    error: function(e){
                        console.log(e.responseText);    
                    }
                },
            "bDestroy": true

        }).DataTable();
    };

    function cargarDataMovimiento(idMovimiento, serie, numero, Proveedor,Laboratorio, tipo_comprobante,referencia,observacion){
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
        $("#txtReferencia_Movimiento").val(referencia);
        $("#txtObservacion_Movimiento").val(observacion);
        $("#cboTipoComprobanteIng").html("<option>" + tipo_comprobante + "</option>");
        $("#txtSerie").val(serie);
        $("#txtNumero").val(numero);
        CargarDetalleMovimiento(idMovimiento);
        //$('button[type="submit"]').attr('disabled','disabled');
        //$("#btnBuscarArt").prop("disabled", true);
        $("#txtSerie").prop("disabled", true);
        $("#txtNumero").prop("disabled", true);
        $("#txtReferencia_Movimiento").prop("disabled", true);
        $("#txtObservacion_Movimiento").prop("disabled", true);
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

    

    function CargarDetalleMovimiento(idIngreso) {
        // $('th:nth-child(12)').hide();
        $('#trDI th:nth-child(16)').hide();

        $.post("./ajax/MovimientoAjax.php?op=GetDetalleArticulo", {idIngreso: idIngreso}, function(r) {
                $("table#tblDetalleMovimiento tbody").html(r);
            
        })
    }

