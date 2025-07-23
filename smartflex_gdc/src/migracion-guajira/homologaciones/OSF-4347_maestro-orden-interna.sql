begin
insert into ldci_ordeninterna
with base as(
select '65000012' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - SAN JUAN DEL CESA' desc_orden from dual union all
select '65000013' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - URUMITA' desc_orden from dual union all
select '61000010' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO PREVENTIVO DE REDES DE ACERO' desc_orden from dual union all
select '61000011' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO PREVENTIVO ERM' desc_orden from dual union all
select '61000012' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO PREVENTIVO USUARIOS ESPECIALES' desc_orden from dual union all
select '61000015' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO CORRECTIVO DE REDES DE ACERO' desc_orden from dual union all
select '61000016' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO CORRECTIVO ERM' desc_orden from dual union all
select '61000017' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO CORRECTIVO USUARIOS ESPECIALES' desc_orden from dual union all
select '64000003' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6102' cod_cebe,'CONSTRUCCION GASODUCTO ALBANIA-MAICAO' desc_orden from dual union all
select '65000004' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - VILLANUEVA' desc_orden from dual union all
select '65000002' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - FONSECA' desc_orden from dual union all
select '6000' codigo, 'Z999' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '6999' cod_cebe,'CIERRE FI GDGU' desc_orden from dual union all
select '6904010' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'SUBGERENTE COMERCIAL' desc_orden from dual union all
select '64000001' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'ACTUALIZACION GIS' desc_orden from dual union all
select '61000022' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'ODORIZACION' desc_orden from dual union all
select '65000022' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'CERRAMIENTO CALLE 15 NO. 12C - 06' desc_orden from dual union all
select '65000011' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - DIBULLA' desc_orden from dual union all
select '64000007' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'SERVICIOS PROFESIONALES - PROYECTO MIGRA' desc_orden from dual union all
select '65000020' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'ESTACION REGULADORA - DIBULLA' desc_orden from dual union all
select '65000023' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'NO' desc_orden from dual union all
select '6902310' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'TESORERIA' desc_orden from dual union all
select '6902210' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COMPRAS Y SUMINISTROS' desc_orden from dual union all
select '6903010' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'SUBGERENCIA TECNICA' desc_orden from dual union all
select '62000001' codigo, 'Z602' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COMERCIAL' desc_orden from dual union all
select '62000002' codigo, 'Z602' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'INDUSTRIAL REGULADO' desc_orden from dual union all
select '65000000' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - RIOHACHA' desc_orden from dual union all
select '65000001' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - HATONUEVO' desc_orden from dual union all
select '61000004' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO COMISION ACOMET-INTERNA RESIDENCIA' desc_orden from dual union all
select '64000004' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'LICENCIAS - PROYECTO MIGRACION OSF' desc_orden from dual union all
select '6902140' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'FACTURACION' desc_orden from dual union all
select '6903210' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'CONSTRUCCIONES E INSTALACIONES' desc_orden from dual union all
select '6902020' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'PLANEACION Y PRESUPUESTO' desc_orden from dual union all
select '6903310' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'SISTEMA DE INFORMACION GEOGRAFICA GIS' desc_orden from dual union all
select '61000018' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO CORRECTIVO CITY GATE' desc_orden from dual union all
select '6902220' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'SERVICIOS GENERALES' desc_orden from dual union all
select '6902040' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'INFORMATICA' desc_orden from dual union all
select '6902060' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'GESTION HUMANA' desc_orden from dual union all
select '65000003' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - EL MOLINO' desc_orden from dual union all
select '65000007' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - BARRANCAS' desc_orden from dual union all
select '6902030' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'JURIDICO' desc_orden from dual union all
select '6902120' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'ATENCION AL USUARIO' desc_orden from dual union all
select '6902010' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'SUB ADMINISTRATIVA Y FINANCIERA' desc_orden from dual union all
select '6902510' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'CONTROL DE CALIDAD' desc_orden from dual union all
select '64000006' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'INFRAESTRUCTURA - PROYECTO MIGRACION OSF' desc_orden from dual union all
select '6902410' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'CONTABILIDAD' desc_orden from dual union all
select '6903110' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'OPERACION Y MANTENIMIENTO' desc_orden from dual union all
select '65000017' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'ESTACION REGULADORA - ALBANIA' desc_orden from dual union all
select '6902110' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'VENTAS' desc_orden from dual union all
select '6902130' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'CARTERA' desc_orden from dual union all
select '65000015' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'ESTACION REGULADORA - RIOHACHA' desc_orden from dual union all
select '61000000' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO ACOMETIDA-INTERNA RESIDENCIAL' desc_orden from dual union all
select '61000001' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO ACOMETIDA-INTERNA NO RESIDENCIAL' desc_orden from dual union all
select '61000002' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO MEDICION RESIDENCIAL' desc_orden from dual union all
select '61000003' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO MEDICION NO RESIDENCIAL' desc_orden from dual union all
select '61000009' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO PREVENTIVO DE REDES DE POLIETILENO' desc_orden from dual union all
select '61000013' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO PREVENTIVO CITY GATE' desc_orden from dual union all
select '61000014' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO CORRECTIVO DE REDES DE POLIETILENO' desc_orden from dual union all
select '61000019' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO DE INTERNAS' desc_orden from dual union all
select '61000020' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO CENTRO DE MEDICION' desc_orden from dual union all
select '61000021' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MTTO REDES' desc_orden from dual union all
select '6902050' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'FNB' desc_orden from dual union all
select '61000005' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO COMISION ACOMET-INTERNA NO RESIDEN' desc_orden from dual union all
select '61000006' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO INTERVEN ACOMET-INTERNA RESIDENCIA' desc_orden from dual union all
select '61000007' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'COSTO INTERVENTO ACOMET-INTERNA NO RESID' desc_orden from dual union all
select '61000008' codigo, 'Z601' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'ANALISIS DE CONSUMO E INTERVENTORIA OPER' desc_orden from dual union all
select '6902520' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'GESTION DOCUMENTAL' desc_orden from dual union all
select '65000008' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - MAICAO' desc_orden from dual union all
select '65000025' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'BANCO DE PRUEBA' desc_orden from dual union all
select '65000018' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'PROYECTO GASODUCTO MAICAO-ALBANIA POLIET' desc_orden from dual union all
select '65000009' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - MANAURE' desc_orden from dual union all
select '65000019' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'PROYECTO GASODUCTO ESTACION ALBANIA' desc_orden from dual union all
select '65000010' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - URIBIA' desc_orden from dual union all
select '65000005' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - DISTRACCION' desc_orden from dual union all
select '65000024' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'CENTRO DE MEDICION EDS 24 OCTUBRE' desc_orden from dual union all
select '65000006' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - ALBANIA' desc_orden from dual union all
select '65000016' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'ESTACION REGULADORA - MAICAO' desc_orden from dual union all
select '62000004' codigo, 'Z602' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'PROYECTO ON-BASE' desc_orden from dual union all
select '64000005' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'SAM - PROYECTO MIGRACION OSF' desc_orden from dual union all
select '64000008' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'VIATICOS Y TRASLADOS - PROYECTO MIGRACIO' desc_orden from dual union all
select '62000000' codigo, 'Z602' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'RESIDENCIAL' desc_orden from dual union all
select '65000014' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'REDES DE POLIETILENO - LA JAGUA DEL PILA' desc_orden from dual union all
select '65000176' codigo, 'Z305' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'TRASL RED DE PE - BELEN DE UMBRIA' desc_orden from dual union all
select '6901010' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'GERENCIA GENERAL' desc_orden from dual union all
select '6901110' codigo, 'Z603' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'AUDITORIA INTERNA' desc_orden from dual union all
select '65000021' codigo, 'Z605' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'TERRENO CALLE 15 NO. 12C - 06' desc_orden from dual union all
select '62000005' codigo, 'Z602' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'INDUSTRIAL NO REGULADO' desc_orden from dual union all
select '64000000' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'SAP - SOFTWARE CONTABLE' desc_orden from dual union all
select '64000002' codigo, 'Z604' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, '' tipo_estadistica, '6900' cod_cebe,'CONVENIO 003 - GOBERNACION DE LA GUAJIRA' desc_orden from dual union all
select '62000003' codigo, 'Z602' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'PROYECTO DE REINGENIERIA DE PROCESOS' desc_orden from dual union all
select '62000006' codigo, 'Z602' clas_orden, '' esta_abierta,'X' est_liberada,'' est_cerradatec,'' est_cerrada, 'X' tipo_estadistica, '' cod_cebe,'MERCADO SECUNDARIO' desc_orden from dual 
)
select *
from base
where not exists(select null from open.ldci_ordeninterna o where o.codi_ordeinterna=base.codigo);
    dbms_output.put_line('Se insertaron '||sql%rowcount||' registros');
    commit;
exception
  when others then
    rollback;
    dbms_output.put_line('Error '||sqlerrm);


end;
/