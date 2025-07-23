column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
BEGIN
update factura set factfege = to_date('18/06/2025 15:22:18','dd/mm/yyyy hh24:mi:ss' )
where factcodi = 2152201226;

update factura_electronica set estado = 2,
    xml_factelect = '<?xml version="1.0" encoding="UTF-8"?>
<ns1:enviarDocumento>
<felCabezaDocumento>
<aplicafel>SI</aplicafel>
<cantidadLineas>1</cantidadLineas>
<codigoPlantillaPdf>1</codigoPlantillaPdf>
<prefijo>FPGC</prefijo>
<tipoOperacion>10</tipoOperacion>
<tipodocumento>1</tipodocumento>
<idEmpresa>1196</idEmpresa>
<usuario>UGASESDELCARIBESA</usuario>
<contrasenia>PWG4535D3LC4R1B354</contrasenia>
<token>ae5efc9e0ee0dbd3de5335b8a2ae0cf75dde1c7d</token>
<codigovendedor/>
<consecutivo>140</consecutivo>
<fechaexpedicion>2025-06-18T03:22:18</fechaexpedicion>
<fechafacturacion>2025-06-18T03:22:18</fechafacturacion>
<listaAdquirentes>
<ciudad>08001</ciudad>
<departamento>08</departamento>
<descripcionCiudad>BARRANQUILLA</descripcionCiudad>
<digitoverificacion>0</digitoverificacion>
<direccion>KR 64 CL 86 - 61</direccion>
<email>jardincaritasalegres@hotmail.com</email>
<nombreCompleto>JARDIN INFANTIL CARITAS ALEGRES RIOMAR </nombreCompleto>
<nombredepartamento>ATLANTICO</nombredepartamento>
<numeroIdentificacion>326299112</numeroIdentificacion>
<pais>CO</pais>
<paisnombre>Colombia</paisnombre>
<tipoIdentificacion>13</tipoIdentificacion>
<tipoPersona>1</tipoPersona>
</listaAdquirentes>
<listaDetalle>
<cantidad>2776</cantidad>
<codigoproducto>983</codigoproducto>
<descripcion>GENERACIÓN ENERGÍA SOLAR</descripcion>
<muestracomercial>0</muestracomercial>
<muestracomercialcodigo>0</muestracomercialcodigo>
<nombreProducto>GENERACIÓN ENERGÍA SOLAR</nombreProducto>
<posicion>0</posicion>
<preciosinimpuestos>1637840</preciosinimpuestos>
<preciototal>1637840</preciototal>
<tamanio>0</tamanio>
<tipoImpuesto>3</tipoImpuesto>
<tipocodigoproducto>999</tipocodigoproducto>
<unidadmedida>KWH</unidadmedida>
<valorUnitarioPorCantidad>1637840</valorUnitarioPorCantidad>
<valorunitario>590</valorunitario>
</listaDetalle>
<listaMediosPagos>
<medioPago>ZZZ</medioPago>
</listaMediosPagos>
<pago>
<moneda>COP</moneda>
<tipocompra>2</tipocompra>
<periododepagoa>29</periododepagoa>
<fechavencimiento>2025-07-17T12:07:00</fechavencimiento>
<totalbaseconimpuestos>1637840</totalbaseconimpuestos>
<totalbaseimponible>0</totalbaseimponible>
<totalfactura>1637840</totalfactura>
<totalimportebruto>1637840</totalimportebruto>
</pago>
<listaCodigoBarras>
<cadenaACodificar>(415)7707232377896(8020)0904234299(3900)0000000000(96)20350717</cadenaACodificar>
<tipoModelo>recaudo</tipoModelo>
<orden>1</orden>
<tipoCodificacion>UCC-128</tipoCodificacion>
<descripcion>Pague hasta el: 2035-07-17</descripcion>
<fecha>2035-07-17T00:00:00 -05:00</fecha>
</listaCodigoBarras>
</felCabezaDocumento>
</ns1:enviarDocumento>'
where FACTURA= 2152201226;

commit;

end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/