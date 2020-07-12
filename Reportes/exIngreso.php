<?php
// (c) Xavier Nicolay
// Exemple de génération de devis/facture PDF

require('Ingreso.php');

session_start();

$lo = $_SESSION["logo"];

require_once "../model/Configuracion.php";

      $objConf = new Configuracion();

      $query_conf = $objConf->Listar();

      $regConf = $query_conf->fetch_object();

require_once "../model/Ingreso.php";

$obIngreso = new Ingreso();

$query_cli = $obIngreso->GetProveedorSucursalIngreso($_GET["id"]);

        $reg_cli = $query_cli->fetch_object();



$f = "";

      if ($_SESSION["superadmin"] == "S") {
        $f = $regConf->logo;
      } else {
        $f = $reg_cli->logo;
      }

      $archivo = $f; 
      $trozos = explode(".", $archivo); 
      $extension = end($trozos); 

$pdf = new PDF_Invoice( 'P', 'mm', 'A4' );
$pdf->AddPage();
$pdf->addSociete( $reg_cli->razon_social,
                  "$reg_cli->documento_sucursal: $reg_cli->num_sucursal\n" .
                  "Dirección:".utf8_decode( "$reg_cli->direccion")."\n".
                  "Teléfono:".utf8_decode(" $reg_cli->telefono_suc")."\n" .
                  "email : $reg_cli->email_suc ","../$f","$extension");
$pdf->fact_dev( "$reg_cli->tipo_comprobante ", "$reg_cli->serie_comprobante-$reg_cli->num_comprobante" );
$pdf->temporaire( "" );
$pdf->addDate( $reg_cli->fecha);
//$pdf->addClient("CL01");
//$pdf->addPageNumber("1");
$pdf->addClientAdresse("Razón Social: ".utf8_decode($reg_cli->proveedor),"Domicilio: ".utf8_decode($reg_cli->direccion_callep)." - ".$reg_cli->departamentop,$reg_cli->tipo_documentop.": ".$reg_cli->num_documentop,"Email: ".$reg_cli->emailp,"Telefono: ".$reg_cli->telefonop);
$pdf->addLaboratorioAdresse("Razón Social: ".utf8_decode($reg_cli->laboratorio),"Domicilio: ".utf8_decode($reg_cli->direccion_callel)." - ".$reg_cli->departamentol,$reg_cli->tipo_documentol.": ".$reg_cli->num_documentol,"Email: ".$reg_cli->emaill,"Telefono: ".$reg_cli->telefonol);
//$pdf->addReglement("Soluciones Innovadoras Perú S.A.C.");
//$pdf->addEcheance("RUC","2147715777");
//$pdf->addNumTVA("Chongoyape, José Gálvez 1368");
//$pdf->addReference("Devis ... du ....");
$cols=array( "N"    => 4,
             "DESCRIPCION"  => 40,
             "NLOTE"=>14,
             "R. SANI"=>14,
             "F.VENCI"     => 23,
             "F.F."     => 11,
             "P"     => 11,
             "C.A."     => 11,
             "CANT"     => 11,
             "P.COST"      => 15,
             "P.VENTA" => 18,
             "SUBTOTAL"          => 18 );
$pdf->addCols( $cols);
$cols=array( "N"    => "L",
             "DESCRIPCION"  => "L",
             "NLOTE"=>"C",
             "R. SANI"=>"C",
             "F.VENCI"     => "C",
             "F.F."     => "C",
             "P"     => "C",
             "C.A."     => "C",
             "CANT"     => "C",
             "P.COST"      => "R",
             "P.VENTA" => "R",
             "SUBTOTAL"          => "C" );
$pdf->addLineFormat( $cols);
$pdf->addLineFormat($cols);

$y    = 89;
$TOTAL=0;
$query_ped = $obIngreso->GetDetalleArticulo($_GET["id"]);
      $i=0;
        while ($reg = $query_ped->fetch_object()) {

          if ($reg->codigo != "") {
            $nlote = $reg->codigo;
          } else {
            $nlote = "-";
          }
          if ($reg->serie != "") {
            $rsani = $reg->serie;
          } else {
            $rsani = "-";
          }
            $line = array( "N"    => ($i+1),
                           "DESCRIPCION"  => utf8_decode("$reg->articulo $reg->descripcion"),
                           "NLOTE"=>"$nlote",
                           "R. SANI"=>"$rsani",
                           "F.VENCI"     => "$reg->fecha_vencimiento",
                           "F.F."     => "$reg->abrevivacionff",
                           "P"     => "$reg->abreviacionp",
                           "C.A."     => "$reg->abreviacionca",
                           "CANT"     => "$reg->stock_ingreso",
                           "P.COST"      => "$reg->precio_compra",
                           "P.VENTA" => "$reg->precio_ventadistribuidor",
                           "SUBTOTAL"          => "$reg->sub_total");
            $size = $pdf->addLine( $y, $line );
            $y   += $size + 2;
            $i++;

            $TOTAL=$TOTAL+$reg->sub_total;

        }
            if($reg_cli->tipo_comprobante =="FACTURA"){
            $TOTAL=$TOTAL+($TOTAL*$reg_cli->impuesto/100);

            }
require_once "../ajax/Letras.php";

 $V=new EnLetras(); 
 $con_letra=strtoupper($V->ValorEnLetras($TOTAL,"NUEVOS SOLES")); 

$pdf->addCadreTVAs("---".$con_letra);

require_once "../model/Configuracion.php";

$objConfiguracion = new Configuracion();


$query_global = $objConfiguracion->Listar();

$reg_igv = $query_global->fetch_object();

$pdf->addTVAs( $reg_cli->impuesto, $TOTAL,"$reg_igv->simbolo_moneda ");
$pdf->addCadreEurosFrancs("$reg_igv->nombre_impuesto"." $reg_cli->impuesto%");
$pdf->Output('Reporte de Ingreso','I');
?>
