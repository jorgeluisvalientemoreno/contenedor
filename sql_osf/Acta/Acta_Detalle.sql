--Acta
select gct.id_contratista || ' - ' || gct.descripcion Contratista,
       --gc.id_tipo_contrato Tipo_Contrato,
       ga.id_acta,
       ga.nombre,
       decode(ga.id_tipo_acta,
              1,
              '1 - Liquidacion de Trabajos',
              2,
              '2 - Facturacion de Contratistas',
              3,
              '3 - Acta de Suspension',
              4,
              '4 - Acta de Reactivacion',
              5,
              '5 - Acta de Apertura',
              6,
              '6 - Acta de Modificacion',
              7,
              '7 - Acta de Anulacion',
              8,
              '8 - Acta de Inactivacion',
              ga.id_tipo_acta || ' - No esta definido') Tipo_Acta,
       gc.id_tipo_contrato || ' - ' || gtc.descripcion Tipo_Contrato,
       ga.valor_total,
       ga.fecha_creacion,
       ga.fecha_cierre,
       ga.fecha_inicio,
       ga.fecha_fin,
       ga.estado,
       ga.id_base_administrativa,
       ga.id_contrato || ' - ' || gc.descripcion Contrato,
       ga.id_periodo,
       ga.numero_fiscal,
       ga.id_consecutivo,
       ga.fecha_ult_actualizac,
       ga.person_id,
       ga.is_pending,
       ga.contractor_id,
       ga.operating_unit_id,
       ga.value_advance,
       ga.terminal,
       ga.comment_type_id,
       ga.comment_,
       ga.extern_pay_date,
       ga.extern_invoice_num,
       ga.valor_liquidado
  from open.ge_acta ga
  left join open.ge_contrato gc
    on gc.id_contrato = ga.id_contrato
  left join open.ge_contratista gct
    on gct.id_contratista = gc.id_contratista
 inner join open.GE_TIPO_CONTRATO gtc
    on gtc.id_tipo_contrato = gc.id_tipo_contrato
 inner join multiempresa.contratista mc
    on mc.contratista = gct.id_contratista
   and mc.empresa = 'GDGU'
   and mc.contratista not in (2790)
   and ga.id_tipo_acta = 1
 where 1 = 1
      --and ga.id_acta in (228830)
   and ga.fecha_creacion >= '06/07/2026'
 order by ga.fecha_creacion desc;

--Contrato - Acta - -Localidad - Departamento
select DISTINCT a.Certificate_Id Acta,
                GGL.GEOGRAP_LOCATION_ID || ' - ' || GGL.DESCRIPTION Localidad,
                GGL.GEO_LOCA_FATHER_ID || ' - ' || GGD.DESCRIPTION Departmento,
                GA.FECHA_CREACION,
                ga.terminal,
                ga.id_contrato
--ga.person_id || ' - ' || gp.name_
  from OPEN.CT_ORDER_CERTIFICA a
 INNER JOIN open.ge_acta ga
    ON a.certificate_id = ga.id_acta
      --AND ga.Id_Contrato = 9441
   and ga.id_acta = 274428
 INNER JOIN OPEN.OR_ORDER OO
    ON OO.ORDER_ID = A.ORDER_ID
 INNER JOIN OPEN.OR_ORDER_ACTIVITY OOA
    ON OOA.ORDER_ID = A.ORDER_ID
 INNER JOIN OPEN.AB_ADDRESS AA
    ON AA.ADDRESS_ID = OOA.ADDRESS_ID
 INNER JOIN OPEN.GE_GEOGRA_LOCATION GGL
    ON GGL.GEOGRAP_LOCATION_ID = AA.GEOGRAP_LOCATION_ID
 INNER JOIN OPEN.GE_GEOGRA_LOCATION GGD
    ON GGD.GEOGRAP_LOCATION_ID = GGL.GEO_LOCA_FATHER_ID
--INNER JOIN open.GE_PERSON gp on gp.person_id = ga.person_id
;

--Detalle acta
select ga.*, rowid from open.ge_detalle_acta ga where ga.id_acta = 274428;

--Detalle acta
select a.*, rowid
  from OPEN.CT_ORDER_CERTIFICA a
 where 1 = 1
      --and a.order_id in (392075988, 392076000, 392075970, 392076004)
   and a.certificate_id = 274428;

--Detalle acta de cada orden
select oo.order_id Orden,
       oo.task_type_id || ' - ' || ott.description Tipo_Trabajo,
       ooa.activity_id || ' - ' || gi.description Actividad,
       aa.address_id || ' - ' || aa.address Direccion,
       gel.geograp_location_id || ' - ' || gel.description Localidad,
       gel.geo_loca_father_id || ' - ' || gelDepartamento.Description Departamento
  from OPEN.CT_ORDER_CERTIFICA a
 inner join open.or_order oo
    on oo.order_id = a.order_id
 inner join open.or_order_activity ooa
    on oo.order_id = ooa.order_id
 inner join open.ge_items gi
    on gi.items_id = ooa.activity_id
 inner join open.or_task_type ott
    on ott.task_type_id = oo.task_type_id
 inner join open.ab_address aa
    on aa.address_id = ooa.address_id
 inner join open.ge_geogra_location gel
    on gel.geograp_location_id = aa.geograp_location_id
 inner join open.ge_geogra_location gelDepartamento
    on gelDepartamento.geograp_location_id = gel.geo_loca_father_id
 where 1 = 1
      --and a.order_id in (392075988, 392076000, 392075970, 392076004)
   and a.certificate_id = 274428 --255431
--group by aa.geograp_location_id, gel.description
 order by aa.geograp_location_id;
