column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
	nuContrato 		number := 67512536;
	nuConsecutivo   number := 417004158;
	nuFactura		number := 2131561096;
	nuEstado		number := 1;
	nuIntento		number := 0;
	
	xmlFactura clob := '<?xml version="1.0" encoding="UTF-8"?>
<ns1:enviarDocumento>
	<felCabezaDocumento>
		<aplicafel>SI</aplicafel>
		<cantidadLineas>1</cantidadLineas>
		<codigoPlantillaPdf>1</codigoPlantillaPdf>
		<prefijo>NC</prefijo>
		<tipoOperacion>20</tipoOperacion>
		<tipodocumento>2</tipodocumento>
		<tiponota>2</tiponota>
		<idEmpresa>1196</idEmpresa>
		<usuario>UGASESDELCARIBESA</usuario>
		<contrasenia>PWG4535D3LC4R1B354</contrasenia>
		<token>ae5efc9e0ee0dbd3de5335b8a2ae0cf75dde1c7d</token>
		<codigovendedor/>
		<consecutivo>417004158</consecutivo>
		<fechafacturacion>2024-04-15T04:04:13</fechafacturacion>
		<listaAdquirentes>
			<ciudad>8001</ciudad>
			<departamento>8</departamento>
			<descripcionCiudad>BARRANQUILLA</descripcionCiudad>
			<digitoverificacion>0</digitoverificacion>
			<direccion>KR 43 CL 80 - 60</direccion>
			<email>notiene@correo.com</email>
			<nombreCompleto>INVERSIONES Y GASTRONOMIA SAS </nombreCompleto>
			<nombredepartamento>ATLANTICO</nombredepartamento>
			<numeroIdentificacion>9011998775</numeroIdentificacion>
			<pais>CO</pais>
			<paisnombre>Colombia</paisnombre>
			<tipoIdentificacion>31</tipoIdentificacion>
			<tipoPersona>2</tipoPersona>
		</listaAdquirentes>
		<listaDetalle>
			<cantidad>1843</cantidad>
			<codigoproducto>983</codigoproducto>
			<descripcion>GENERACION ENERGIA SOLAR</descripcion>
			<muestracomercial>0</muestracomercial>
			<muestracomercialcodigo>0</muestracomercialcodigo>
			<nombreProducto>GENERACION ENERGIA SOLAR</nombreProducto>
			<posicion>0</posicion>
			<preciosinimpuestos>1105800</preciosinimpuestos>
			<preciototal>1105800</preciototal>
			<tamanio>0</tamanio>
			<tipoImpuesto>3</tipoImpuesto>
			<tipocodigoproducto>999</tipocodigoproducto>
			<unidadmedida>KWH</unidadmedida>
			<valorUnitarioPorCantidad>1105800</valorUnitarioPorCantidad>
			<valorunitario>600</valorunitario>
		</listaDetalle>
		<listaMediosPagos>
			<medioPago>ZZZ</medioPago>
		</listaMediosPagos>
		<pago>
			<moneda>COP</moneda>
			<tipocompra>2</tipocompra>
			<periododepagoa>3688</periododepagoa>
			<fechavencimiento>2034-05-22T12:05:00</fechavencimiento>
			<totalbaseconimpuestos>1105800</totalbaseconimpuestos>
			<totalbaseimponible>0</totalbaseimponible>
			<totalfactura>1105800</totalfactura>
			<totalimportebruto>1105800</totalimportebruto>
		</pago>
		<listaCodigoBarras>
			<cadenaACodificar>(415)7707232377896(8020)0233778793(3900)0001105800(96)20340522</cadenaACodificar>
			<tipoModelo>recaudo</tipoModelo>
			<orden>1</orden>
			<tipoCodificacion>UCC-128</tipoCodificacion>
			<descripcion>Pague hasta el: 2034-05-22</descripcion>
			<fecha>2034-05-22T00:00:00 -05:00</fecha>
		</listaCodigoBarras>
		<listaFacturasModificadas>
			<tipoDocumentoFacturaModificada>1</tipoDocumentoFacturaModificada>
			<prefijoFacturaModificada>FPGC</prefijoFacturaModificada>
			<consecutivoFacturaModificada>3</consecutivoFacturaModificada>
		</listaFacturasModificadas>
	</felCabezaDocumento>
</ns1:enviarDocumento>';
begin
  insert into personalizaciones.factura_electronica(CONTRATO,CONSFAEL,FACTURA,ESTADO,NUMERO_INTENTO,XML_FACTELECT, FECHA_REGISTRO)
     values(nuContrato, nuConsecutivo, nuFactura, nuEstado, nuIntento, xmlFactura, sysdate);
  commit;
  dbms_output.put_line('Insertado OK');
exception
	when others then
	  rollback;
	  dbms_output.put_line(sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/