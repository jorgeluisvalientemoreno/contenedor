declare
    
  SBRUTA       VARCHAR2(4000) := '/smartfiles/Construcciones/Contratos_fijos';
  SBLINEA      VARCHAR2(4000) := NULL;
  SBNEWLINEA   VARCHAR2(4000) := NULL;
  SBARCHI      VARCHAR2(4000) := NULL;
  SBMESSAGE    VARCHAR2(4000);
  ARCH         UTL_FILE.FILE_TYPE;
  ASBA         UTL_FILE.FILE_TYPE;
  INCO         UTL_FILE.FILE_TYPE;
  nuPadre      open.or_order.order_id%type;
  nuEstaPadre  open.or_order_Status.order_status_id%type;
  nuCausPadre  open.ge_causal.causal_id%type;
  nuContratoAsignar  number;
  nuOk               number;
  sbError            varchar2(4000);
  
  cursor cuOrden is
  with tipogara as(select 10074  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10077  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10088  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 10093  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10094  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10256  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10529  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10833  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10916  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10924  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10925  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10926  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 10933  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10951  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10952  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10953  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10954  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 10955  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 12137  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12270  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12271  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12272  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 10075  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12190  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12135  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12150  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12150  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 12147  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 12187  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12188  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10450  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10836  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12149  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12149  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10714  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10721  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10716  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12138  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12161  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12155  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12148  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 12142  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10622  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12152  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12152  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 12151  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12151  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 12189  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 10718  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12140  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12143  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10722  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 10835  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10834  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12475  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10339  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 12139  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12130  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10720  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12162  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12457  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12460  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10717  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12141  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10719  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12146  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10259  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12112  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12136  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12153  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12153  titr, 4   codigo, 'ACOMETIDA' tipo from dual union all
 select 10495  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10495  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10611  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 12164  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10715  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12487  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 12347  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12134  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12384  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10857  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12385  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12107  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12106  titr, 5   codigo, 'OTRO' tipo from dual union all
 select 12154  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10895  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual  union all
 select 10894  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10894  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10764  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual  union all
 select 10624  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10623  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select 10610  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10609  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select  10608  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select 10607  titr, 1   codigo, 'CENTRO DE MEDICION' tipo from dual union all
 select  10606  titr, 2   codigo, 'INTERNA' tipo from dual union all
 select  10011  titr, 2   codigo, 'INTERNA' tipo from dual UNION ALL
 select  10935  titr, 3   codigo, 'GASODOMESTICO' tipo from dual union all
 select 10127   titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10643   titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10671   titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10672   titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10729   titr, 5   codigo, 'OTRO' tipo from dual union all
 select 10730   titr, 5   codigo, 'OTRO' tipo from dual
),
proceso as(
select 10074 titr, 'MTTO' PROCESO FROM DUAL union all
 select 10075 titr, 'MTTO' PROCESO FROM DUAL union all
 select 10077 titr, 'MTTO' PROCESO FROM DUAL union all
 select 10088 titr, 'MTTO' PROCESO FROM DUAL union all
 select 10093 titr, 'MTTO' PROCESO FROM DUAL union all
 select 10094 titr, 'MTTO' PROCESO FROM DUAL union all
 select 10722 titr, 'RP' PROCESO FROM DUAL union all
 select 10723 titr, 'RP' PROCESO FROM DUAL union all
 select 10951 titr, 'SV' PROCESO FROM DUAL union all
 select 10952 titr, 'SV' PROCESO FROM DUAL union all
 select 10953 titr, 'SV' PROCESO FROM DUAL union all
 select 10716 titr, 'RP' PROCESO FROM DUAL union all
 select 10720 titr, 'RP' PROCESO FROM DUAL union all
 select 10721 titr, 'RP' PROCESO FROM DUAL union all
 select 10933 titr, 'RP' PROCESO FROM DUAL union all
 select 10764 titr, 'MTTO' PROCESO FROM DUAL union all
 select 10833 titr, 'RP' PROCESO FROM DUAL union all
 select 10923 titr, 'SV' PROCESO FROM DUAL union all
 select 10954 titr, 'SV' PROCESO FROM DUAL union all
 select 10955 titr, 'SV' PROCESO FROM DUAL union all
 select 10925 titr, 'RP' PROCESO FROM DUAL union all
 select 10926 titr, 'RP' PROCESO FROM DUAL union all
 select 10916 titr, 'RP' PROCESO FROM DUAL union all
 select 10714 titr, 'RP' PROCESO FROM DUAL union all
 select 10924 titr, 'RP' PROCESO FROM DUAL 
)
,localidades as(
select /*+ INDEX(de GEOGRAP_LOCATION_ID, lo IX_GE_GEOGRA_LOCATION06)) */
    de.geograp_location_id depa,
    de.description desc_depa,
    lo.geograp_location_id loca,
    lo.description desc_loca
from open.ge_geogra_location lo
inner join open.ge_geogra_location de on de.geograp_location_id=lo.geo_loca_father_id
where lo.geog_loca_area_type=3
  and de.geog_loca_area_type=2)
,clasificador as
(select distinct cc.clcttitr,
       cc.clctclco,
       c.cuencosto,
       substr(ccc.ccbgceco, 5, 2) ceco
 from open.ic_clascott cc
inner join open.ldci_cugacoclasi c on c.cuenclasifi=cc.clctclco
inner join open.ldci_cecoubigetra ccc on ccc.ccbgtitr=cc.clcttitr
where  CLCTTITR in (10074,10075,10077,10088,10093,10094,10714,10716,10720,10721,10722,10723,10764,10833,10916,10923,10924,10925,10926,10933,10951,10952,10953,10954,10955,12135,12137,12138,12143,12147,12148,12155,12187,12188,12189,12190,12487, 12705, 12292, 12333, 12194, 12182)
  
  
  ----and substr(ccc.ccbgceco, 5, 2) in ('08','09')
  and substr(ccc.ccbgceco, 5, 2) = DECODE('-1','-1',substr(ccc.ccbgceco, 5, 2),'-1')
)
,clasificador2 as
(select distinct cc.clcttitr,
       cc.clctclco,
       c.cuencosto,
       substr(ccc.ccbgceco, 5, 2) ceco
 from open.ic_clascott cc
inner join open.ldci_cugacoclasi c on c.cuenclasifi=cc.clctclco
inner join open.ldci_cecoubigetra ccc on ccc.ccbgtitr=cc.clcttitr
where --c.cuencosto='7540140100'
    CLCTTITR in (10074,10075,10077,10088,10093,10094,10714,10716,10720,10721,10722,10723,10764,10833,10916,10923,10924,10925,10926,10933,10951,10952,10953,10954,10955,12135,12137,12138,12143,12147,12148,12155,12187,12188,12189,12190,12487, 12705, 12292, 12333, 12194, 12182)
  --and substr(ccc.ccbgceco, 5, 2) in ('08','09')
  and substr(ccc.ccbgceco, 5, 2) = DECODE('-1','-1',substr(ccc.ccbgceco, 5, 2),'-1')
  and cc.clcttitr in (SELECT G.TTIVTITR FROM OPEN.ldci_titrindiva G WHERE  G.TTIVCICO IS NULL)
)
,base as (
select /*+ index ( o IDX_OR_ORDER_012 ) index ( o IDX_OR_ORDER16  ) index ( u PK_OR_OPERATING_UNIT  ) */
      o.order_id,
      o.task_type_id,
      o.operating_unit_id,
      u.name,
      u.es_externa,
      o.created_date,
      o.legalization_date,
      o.order_value precio,
      o.external_address_id,
      cl.ceco,
      cl.clctclco,
      cl.cuencosto,
      decode(o.charge_status,1,0,3, o.order_value)  order_value,
      o.charge_status,
      (select di.geograp_location_id from open.ab_address di where di.address_id=o.external_address_id) loca,
      p.proceso
from open.or_order o
inner join clasificador cl on cl.clcttitr=o.task_type_id 
inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id
left join proceso p on p.titr=o.task_type_id
where o.order_status_id=8
  and trunc(o.legalization_date) >='01/08/2019'
  and trunc(o.legalization_date) < '01/09/2019'
    --and o.order_id in (96948089  , 98416454, 128474452)
union all
select  /*+ index ( o IDX_OR_ORDER_012 ) index ( o IDX_OR_ORDER16  ) index ( u PK_OR_OPERATING_UNIT  ) */
      o.order_id,
      o.task_type_id,
      o.operating_unit_id,
      u.name,
      u.es_externa,
      o.created_date,
      o.legalization_date,
      o.order_value precio,
      o.external_address_id,
      cl.ceco,
      cl.clctclco,
      cl.cuencosto,      
      decode(o.charge_status,1,0,3, o.order_value)  order_value,
      o.charge_status,
      (select di.geograp_location_id from open.ab_address di where di.address_id=o.external_address_id) loca,
      p.proceso
from open.or_order o
inner join clasificador cl on cl.clcttitr=o.task_type_id 
inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id
left join proceso p on p.titr=o.task_type_id
where o.order_status_id=8
  and trunc(o.created_Date) >= '01/08/2019'
  and trunc(o.created_Date) < '01/09/2019'
  and trunc(o.legalization_date)< '01/08/2019'
  --and o.order_id in (96948089  , 98416454, 128474452)
  )
,base2 as(
select base.order_id,
       base.task_type_id,
      (SELECT open.ldc_dsor_task_type.fsbgetdescription(base.task_type_id)  FROM DUAL) /*t.description*/ desc_titr,
      (select open.daor_task_type.fnugetconcept(base.task_type_id,null) from dual ) concepto,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value precio,
      base.charge_status,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      'N' MATERIAL,
      'N' NOVEDAD,
      'N' INTERNA,
      sum(oi.value) valor_contratista
from base
inner join open.or_order_items oi on oi.order_id=base.order_id 
inner join open.ge_items i on oi.items_id=i.items_id and i.item_classif_id not in (3,8,21)
where base.es_externa='Y'
  and not exists(select null from open.ct_item_novelty n where i.items_id=n.items_id)
group by base.order_id,
      base.task_type_id,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      base.charge_status
union all
select base.order_id,
      base.task_type_id,
      (SELECT open.ldc_dsor_task_type.fsbgetdescription(base.task_type_id)  FROM DUAL) /*t.description*/ desc_titr,
      (select open.daor_task_type.fnugetconcept(base.task_type_id,null) from dual ) concepto,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value precio,
      base.charge_status,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      'S' MATERIAL,
      'N' NOVEDAD,
      'N' INTERNA,
      sum(oi.value+oi.value*0.19) valor_contratista
from base
inner join open.or_order_items oi on oi.order_id=base.order_id 
inner join open.ge_items i on oi.items_id=i.items_id and i.item_classif_id  in (3,8,21)
group by base.order_id,
      base.task_type_id,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      base.charge_status
-------------------------------------------------------------
union all
select base.order_id,
      base.task_type_id,
      (SELECT open.ldc_dsor_task_type.fsbgetdescription(base.task_type_id)  FROM DUAL) /*t.description*/ desc_titr,
      (select open.daor_task_type.fnugetconcept(base.task_type_id,null) from dual ) concepto,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value precio,
      base.charge_status,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      'N' MATERIAL,
      'N' NOVEDAD,
      'S' INTERNA,
      sum(oi.value) valor_contratista
from base
inner join open.or_order_items oi on oi.order_id=base.order_id 
inner join open.ge_items i on oi.items_id=i.items_id and i.item_classif_id  not in (3,8,21)
where base.es_externa='N'
group by base.order_id,
      base.task_type_id,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      base.charge_status
-------------------------------------------------------------
union all
select base.order_id,
      base.task_type_id,
      (SELECT open.ldc_dsor_task_type.fsbgetdescription(base.task_type_id)  FROM DUAL) /*t.description*/ desc_titr,
      (select open.daor_task_type.fnugetconcept(base.task_type_id,null) from dual ) concepto,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value precio,
      base.charge_status,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      'N' MATERIAL,
      'S' NOVEDAD,
      'N' INTERNA,
      sum(to_number(a.value_reference)*n.liquidation_sign*nvl((select -1 from open.or_related_order r where r.related_order_id=base.order_id and r.rela_order_type_id=15),1)) valor_contratista
from base
inner join open.or_order_activity  a on a.order_id=base.order_id 
inner join open.ct_item_novelty n on n.items_id=a.activity_id
where base.es_externa='Y'
  and base.created_Date >= '01/08/2019'
  and base.created_Date < '01/09/2019'
group by base.order_id,
      base.task_type_id,
      base.operating_unit_id,
      base.name,
      base.es_externa,
      base.created_date,
      base.legalization_date,
      base.order_value,
      base.loca,
      base.ceco,
      base.cuencosto,
      base.proceso,
      base.clctclco,
      base.charge_status
)
,base3 as(
select base2.*,
       (select  a.product_id from open.or_order_activity a where a.order_id  = base2.order_id and rownum=1) producto,
       (select a.package_id from open.or_order_activity a where a.order_id  = base2.order_id and rownum=1) solicitud
from base2
)
,base4 as(
select base3.order_id,
      base3.task_type_id,
      base3.desc_titr,
      base3.concepto,
      base3.operating_unit_id,
      base3.name,
      base3.es_externa,
      base3.created_date,
      base3.legalization_date,
      base3.precio,
      base3.charge_status,
      base3.loca,
      base3.ceco,
      base3.cuencosto,
      base3.proceso,
      base3.clctclco,
      base3.MATERIAL,
      base3.NOVEDAD,
      base3.INTERNA,
      base3.valor_contratista,
      base3.producto,
      (select sesufein from open.servsusc where sesunuse=base3.producto) fecha_instalacion,
      nvl(tc.codigo, 5) codigo,
      nvl(tc.tipo,'OTRO') tipo,
      (select certificate_id from open.ct_order_certifica c where c.order_id=base3.order_id) acta,
      base3.solicitud
from base3
left join tipogara tc on tc.titr=base3.task_type_id
      
)
,acta as (
/*select  id_acta, nombre, fecha_creacion, extern_pay_date
from open.ge_acta a
where a.id_tipo_Acta=1
and a.extern_pay_date>=To_Date(:FechaIni, 'dd/mm/yyyy')
and a.extern_pay_date<To_Date(:FechaFin, 'dd/mm/yyyy') + 1*/
select /*+ index ( a IDX_GE_ACTA02 ) index ( c IDX_GE_DETALLE_ACTA_01 )*/ 
        a.id_acta, 
        a.fecha_creacion, 
        a.extern_pay_date,
        c.id_orden,
        c.valor_total costo,
        c.geograp_location_id loca
from open.ge_acta a
inner join open.ge_detalle_acta c on a.id_Acta=c.id_acta and c.id_items=4001293
where a.id_tipo_Acta=1
and a.extern_pay_date>='01/08/2019'
and a.extern_pay_date<'01/09/2019'
) 
,detalle as(
--select /*+ index ( c IDX_CT_ORDER_CERTIFICA03 ) index ( o PK_OR_ORDER ) */  
 /*     o.order_id,
      o.task_type_id,
      (SELECT open.ldc_dsor_task_type.fsbgetdescription(o.task_type_id)  FROM DUAL)  desc_titr,
      (select open.daor_task_type.fnugetconcept(o.task_type_id,null) from dual ) concepto,
      o.operating_unit_id,
      u.name,
      u.es_externa,
      o.created_date,
      o.legalization_date,
      o.order_value precio,
      (select d.valor_t                                              otal from open.ge_detalle_Acta d where d.id_acta=a.id_acta and d.id_orden=o.order_id and d.id_items=4001293) costo,
      (select di.geograp_location_id from open.ab_address di where di.address_id=o.external_address_id) loca,
      cl.ceco,
      p.proceso,
      cl.clctclco,
      cl.cuencosto,
      a.id_acta,
      a.extern_pay_date,
      (select a.product_id from open.or_order_activity a where a.order_id=o.order_id and rownum=1) producto
from open.ct_order_certifica c
 inner join open.acta a on a.id_Acta=c.certificate_id
 inner join open.or_order o on o.order_id=c.order_id
 inner join clasificador cl on cl.clcttitr=o.task_type_id 
 inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id
 left join proceso p on p.titr=o.task_type_id
 where o.order_status_id=8
   and o.task_type_id in (SELECT G.TTIVTITR FROM OPEN.ldci_titrindiva G WHERE  G.TTIVCICO IS NULL)
   --and o.order_id in (96948089  , 98416454, 128474452)*/
   select /*+  index ( o PK_OR_ORDER ) index ( u PK_OR_OPERATING_UNIT  )*/  
      o.order_id,
      o.task_type_id,
      (SELECT open.ldc_dsor_task_type.fsbgetdescription(o.task_type_id)  FROM DUAL) desc_titr,
      (select open.daor_task_type.fnugetconcept(o.task_type_id,null) from dual ) concepto,
      o.operating_unit_id,
      u.name,
      u.es_externa,
      o.created_date,
      o.legalization_date,
      0 precio,
      o.charge_status,
      a.costo costo,--(select d.valor_total from open.ge_detalle_Acta d where d.id_acta=a.id_acta and d.id_orden=o.order_id and d.id_items=4001293) costo,
      a.loca loca,--(select di.geograp_location_id from open.ab_address di where di.address_id=o.external_address_id) loca,
      cl.ceco,
      p.proceso,
      cl.clctclco,
      cl.cuencosto,
      a.id_acta,
      a.extern_pay_date,
      (select a.product_id from open.or_order_activity a where a.order_id=o.order_id and rownum=1) producto,
      (select a.package_id from open.or_order_activity a where a.order_id=o.order_id and rownum=1) solicitud
from acta a 
 inner join open.or_order o on o.order_id=a.id_orden
 inner join clasificador2 cl on cl.clcttitr=o.task_type_id 
 inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id
 left join proceso p on p.titr=o.task_type_id
 where o.order_status_id=8
   )
,base5 as
(select d.order_id,
       d.task_type_id,
       d.desc_titr,
       d.concepto,
       d.operating_unit_id,
       d.name,
       d.es_externa,
       d.created_date,
       d.legalization_date,
       d.precio,
       d.charge_status,
       d.loca,
       d.ceco,
       d.cuencosto,
       d.proceso,
       d.clctclco,
       d.costo,
       d.producto,
      (select sesufein from open.servsusc where sesunuse=d.producto) fecha_instalacion,
      d.id_acta acta,
      d.extern_pay_date,
      'N' MATERIAL,
      'N' NOVEDAD,
      'S' IVA_FRA,
      'N' INTERNA,
      d.solicitud
from detalle d
union all
select base4.order_id,
      base4.task_type_id,
      base4.desc_titr,
      base4.concepto,
      base4.operating_unit_id,
      base4.name,
      base4.es_externa,
      base4.created_date,
      base4.legalization_date,
      base4.precio,
      base4.charge_status,
      base4.loca,
      base4.ceco,
      base4.cuencosto,
      base4.proceso,
      base4.clctclco,
      base4.valor_contratista costo,
      base4.producto,
      base4.fecha_instalacion,
     
      base4.acta,
      (select a.extern_pay_date from open.ge_acta a where a.id_acta=base4.acta) extern_pay_date,
      base4.MATERIAL,
      base4.NOVEDAD,
      'N' IVA_FRA,
      base4.INTERNA,
      base4.solicitud
from base4)
select base5.order_id,
      base5.task_type_id,
      base5.desc_titr,
      base5.concepto,
      base5.operating_unit_id,
      base5.name,
      base5.es_externa,
      base5.created_date,
      base5.legalization_date,
      base5.precio,
      base5.charge_status,
      base5.ceco,
      base5.cuencosto,
      (select CUCTDESC FROM OPEN.LDCI_CUENTACONTABLE l where l.CUCTCODI=base5.cuencosto) desc_cuenta,
      base5.proceso,
      base5.clctclco,
      base5.costo,
      base5.producto,
      base5.fecha_instalacion,
      base5.acta,
      base5.extern_pay_date,
      base5.MATERIAL,
      base5.NOVEDAD,
      base5.IVA_FRA,
      base5.INTERNA,
      lo.depa,
      lo.desc_depa,
      lo.loca,
      lo.desc_loca,
      base5.solicitud,
      (select t.package_type_id||'-'||t.description from open.mo_packages p, open.ps_package_type t where t.package_type_id=p.package_type_id and p.package_id=base5.solicitud) tipo_sol,
      (select open.daor_task_type.fnugetconcept(base5.task_type_id) from dual) concepto2
from base5
left join localidades lo on lo.loca=base5.loca;



      

begin
  SBARCHI      := 'AGOSTO.CSV';
  INCO := UTL_FILE.FOPEN(SBRUTA, SBARCHI, 'W');
  SBMESSAGE:='order_id|task_type_id|desc_titr|concepto|operating_unit_id|name|es_externa|created_date|legalization_date|precio|charge_status|ceco|cuencosto|desc_cuenta|proceso|clctclco|costo|producto|fecha_instalacion|acta|extern_pay_date|MATERIAL|NOVEDAD|IVA_FRA|INTERNA|lo.depa|lo.desc_depa|lo.loca|lo.desc_loca|solicitud|tipo_sol|concepto2';
  UTL_FILE.PUT_LINE(INCO, SBMESSAGE);
  for reg in cuOrden loop
    SBMESSAGE:=reg.order_id||'|'||reg.task_type_id||'|'||reg.desc_titr||'|'||reg.concepto||'|'||reg.operating_unit_id||'|'||reg.name||'|'||reg.es_externa||'|'||reg.created_date||'|'||reg.legalization_date||'|'||reg.precio||'|'||reg.charge_status||'|'||reg.ceco||'|'||reg.cuencosto||'|'||reg.desc_cuenta||'|'||reg.proceso||'|'||reg.clctclco||'|'||reg.costo||'|'||reg.producto||'|'||reg.fecha_instalacion||'|'||reg.acta||'|'||reg.extern_pay_date||'|'||reg.MATERIAL||'|'||reg.NOVEDAD||'|'||reg.IVA_FRA||'|'||reg.INTERNA||'|'||reg.depa||'|'||reg.desc_depa||'|'||reg.loca||'|'||reg.desc_loca||'|'||reg.solicitud||'|'||reg.tipo_sol||'|'||reg.concepto2;
    UTL_FILE.PUT_LINE(INCO, SBMESSAGE);
  end loop;
  UTL_FILE.FCLOSE(INCO);
end;
