column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
	nuContrato 		number := 67519525;
	nuConsecutivo   number := 417003899;
	nuFactura		number := 2127514861;
	nuEstado		number := 1;
	nuIntento		number := 0;
	
	xmlFactura clob := '<?xml version="1.0" encoding="UTF-8"?>
<ns1:enviarDocumento>
	<felCabezaDocumento>
		<aplicafel>SI</aplicafel>
		<cantidadLineas>1</cantidadLineas>
		<codigoPlantillaPdf>1</codigoPlantillaPdf>
		<codigovendedor/>
		<consecutivo>'||nuConsecutivo||'</consecutivo>
		<contrasenia>PWG4535D3LC4R1B354</contrasenia>
		<fechafacturacion>2024-01-22T09:01:45</fechafacturacion>
		<idEmpresa>1196</idEmpresa>
		<prefijo>NC</prefijo>
		<tipoOperacion>20</tipoOperacion>
		<tipodocumento>2</tipodocumento>
		<tiponota>2</tiponota>
		<token>ae5efc9e0ee0dbd3de5335b8a2ae0cf75dde1c7d</token>
		<usuario>UGASESDELCARIBESA</usuario>
		<listaAdquirentes>
			<ciudad>8001</ciudad>
			<departamento>8</departamento>
			<descripcionCiudad>BARRANQUILLA</descripcionCiudad>
			<digitoverificacion>2</digitoverificacion>
			<direccion>KR 54 CL 59 - 144</direccion>
			<email>notiene@gascaribe.com</email>
			<nombreCompleto>GASES DEL CARIBE  S.A. E.S.P.</nombreCompleto>
			<nombredepartamento>ATLANTICO</nombredepartamento>
			<numeroIdentificacion>890101691</numeroIdentificacion>
			<pais>CO</pais>
			<paisnombre>Colombia</paisnombre>
			<tipoIdentificacion>31</tipoIdentificacion>
			<tipoPersona>2</tipoPersona>
		</listaAdquirentes>
		<listaDetalle>
			<cantidad>17668</cantidad>
			<codigoproducto>983</codigoproducto>
			<descripcion>GENERACION ENERGIA SOLAR</descripcion>
			<muestracomercial>0</muestracomercial>
			<muestracomercialcodigo>0</muestracomercialcodigo>
			<nombreProducto>GENERACION ENERGIA SOLAR</nombreProducto>
			<posicion>0</posicion>
			<preciosinimpuestos>7685450</preciosinimpuestos>
			<preciototal>7685450</preciototal>
			<tamanio>0</tamanio>
			<tipoImpuesto>3</tipoImpuesto>
			<tipocodigoproducto>999</tipocodigoproducto>
			<unidadmedida>94</unidadmedida>
			<valorUnitarioPorCantidad>7685450</valorUnitarioPorCantidad>
			<valorunitario>434.99</valorunitario>
		</listaDetalle>
		<listaMediosPagos>
			<medioPago>ZZZ</medioPago>
		</listaMediosPagos>
		<pago>
			<moneda>COP</moneda>
			<tipocompra>2</tipocompra>
			<periododepagoa>3684</periododepagoa>
			<fechavencimiento>2034-02-22T12:02:00</fechavencimiento>
			<totalbaseconimpuestos>7685450</totalbaseconimpuestos>
			<totalbaseimponible>0</totalbaseimponible>
			<totalfactura>7685450</totalfactura>
			<totalimportebruto>7685450</totalimportebruto>
		</pago>
		<listaCodigoBarras>
			<cadenaACodificar>(415)7707232377896(8020)0229844584(3900)0007685450(96)20340222</cadenaACodificar>
			<tipoModelo>recaudo</tipoModelo>
			<orden>1</orden>
			<tipoCodificacion>UCC-128</tipoCodificacion>
			<descripcion>Pague hasta el: 2034-02-22</descripcion>
			<fecha>2034-02-22T00:00:00 -05:00</fecha>
		</listaCodigoBarras>
		<listaFacturasModificadas>
			<tipoDocumentoFacturaModificada>1</tipoDocumentoFacturaModificada>
			<prefijoFacturaModificada>FPGC</prefijoFacturaModificada>
			<consecutivoFacturaModificada>2</consecutivoFacturaModificada>
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