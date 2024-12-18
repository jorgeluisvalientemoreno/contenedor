CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_LLENACOSTOINGRESOSOCIERRE(
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2016-01-08
  Descripcion : Generamos informacion de costo vs ingresos a cierre

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

 15-09-2016     EDMLAR  Se modifica la consulta donde se obtiene el numero de aptos de una constructora
                        para contemple el nuevo esquema de venta de solo interna.

 20-10-2017     EDMLAR  CA-200-1403 Se modifica la busqueda del IVA quitando de la consulta la tabla G_ITEMS,
                        pues no hace asociacion con otra tabla generando que este salga mal.

 12-12-2017     EDMLAR  CA-200-1621 Se modifica la consulta del ingreso de las conexiones nuevas y se elimina
                        la busqueda en la tabla ldc_osf_costingr en el cursor cu_notas_varias.

 22-11-2018    HORBART  CA-200-2238 Corregir el ingreso de los servicios nuevo para tener en cuenta las ventas
                        de solo interna y de las ventas interna a constructora y CXC y CP a cada pruducto,
                        ademas modificar el ingreso generado por notas.


 18-12-2018    HORBART  CA-200-2364 Se corrie el proceso general para que el costo ingreso se pueda generar por
                        orden de trabajo.
 27-03-2019    dsaltarin ca-200-2508. Se modifica para agregar mejoras de rendimiento. Para que solo tome ordenes en estado 8.
						 para que tome ordenes de otros meses con fecha de creacion del mes. para que muestre el iva para las cuentas
						 de servicios nuevos.
 06-05-2019    dsaltarin ca-200-2624 Se corrige el numero de caracteres que se toma para identificar el numero de la solicitud.
 19-06-2024     jpinedc OSF-2605: * Se usa pkg_Correo
                        * Ajustes por estándares
***************************************************************************/
                                              nupano  IN NUMBER,
                                              nupmes  IN NUMBER,
                                              sbmensa OUT VARCHAR2,
                                              error   OUT NUMBER
                                             ) IS

CURSOR cu_ge_costingrFRA1(dtcurfein DATE,dtcurfefi DATE) IS
with tabla as(
select
       'ACTA_FRA' TIPO,
       o.product_id,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       (select catedesc from pr_product p, categori where p.product_id=o.product_id and catecodi=category_id) Nom_cate,
       acta acta,
       o.task_type_id titr,
       o.concept,
       (select sum(d.valor_total) from ge_detalle_acta d, ge_items i where  d.id_acta=acta and  d.id_orden=o.order_id and d.id_items=i.items_id and i.item_classif_id!=23) Costo,
       (select sum(d.valor_total) from ge_detalle_acta d where d.id_acta=acta and d.id_orden=o.order_id and id_items=4001293 ) Iva,
       o.clctclco,
       o.clcodesc,
       co.id_contratista contratista,
       (select con.nombre_contratista from ge_contratista con where con.id_contratista=co.id_contratista) nombre,
       o.legalization_date fec_lega,
       o.actividad,
       o.order_id orden,
       a.extern_invoice_num factura,
       a.extern_pay_date  fecha,
       o.cuenta,
       package_id,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = o.cuenta) Nom_Cuenta,
       (CASE WHEN o.concept IS NOT null and o.package_id is not null
               --<< CA-200-1403
               --
               AND
               (o.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = o.actividad))
               -->>
               THEN
          (CASE WHEN o.concept NOT IN (19,30,291,674) THEN
              (CASE WHEN o.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                   (SELECT nvl(SUM(cargvalo),0)
                      FROM cargos ca, cuencobr co, factura fa
                     WHERE cargnuse = product_id
                       AND cargconc = o.concept
                       AND cargcaca IN (41,53)
                       AND cargsign = 'DB'
                       AND cargcuco = cucocodi
                       AND cucofact = fa.factcodi
                       AND fa.factfege >= dtcurfein AND fa.factfege <=dtcurfefi
					   AND substr(cargdoso,4,1000) = (o.package_id)--200-2624
                       AND ca.cargcodo= o.order_id
                       AND cargtipr = 'A')
                   ELSE
                     0
                     END)
               ELSE
                 0
                 END)
          ELSE
            0
       END) Ingreso
from ldc_ordenes_costo_ingreso o, ge_acta a, ge_contrato co
where o.nuano=NUPANO
  and o.numes=NUPMES
  and o.acta is not null
  and a.id_acta=acta
  and co.id_contrato=a.id_contrato
  and a.extern_pay_date>=dtcurfein
  and a.extern_pay_date<=dtcurfefi

)
select TIPO,
       product_id,
       cate,
       Nom_cate,
       acta,
       titr,
       concept,
       Costo,
       Iva,
       clctclco,
       clcodesc,
       contratista,
       nombre,
       fec_lega,
       actividad,
       orden,
       factura,
       fecha,
       cuenta,
       package_id,
       Nom_Cuenta,
(CASE WHEN TABLA.INGRESO=0 THEN
      CASE WHEN tabla.concept IS NOT  null and tabla.package_id is not null
               --<< CA-200-1403
               --
               AND
               (tabla.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = tabla.actividad))
               -->>
        THEN
          (CASE WHEN concept NOT IN (19,30,291,674) THEN
              (CASE WHEN TABLA.TITR NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                   (SELECT nvl(SUM(cargvalo),0)
                      FROM cargos ca, cuencobr co, factura fa
                     WHERE cargnuse = product_id
                       AND cargconc = tabla.concept
                       AND cargcaca IN (41,53)
                       AND cargsign = 'DB'
                       AND cargcuco = cucocodi
                       AND cucofact = fa.factcodi
                       AND fa.factfege >= dtcurfein AND fa.factfege <= dtcurfefi
					   AND substr(cargdoso,4,1000) = (tabla.package_id)--200-2624
                       AND cargtipr = 'A')
                   ELSE
                     0 END)
               ELSE
                 0 END)
          ELSE
            0 END
        ELSE
            TABLA.INGRESO
        END) Ing_Otro,
        (select 'CONECTADO' from hicaesco h
         where h.hcecfech >= dtcurfein --to_date('01/04/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
           and h.hcecfech <= dtcurfefi --to_date('30/04/2016 23:59:59','dd/mm/yyyy hh24:mi:ss'
           and h.hcecserv = 7014 and h.hcecnuse = product_id and h.hcececan = 96 and h.hcececac = 1) Estado
from tabla;


CURSOR cu_ge_costingrSINF1(dtcurfein DATE,dtcurfefi DATE) IS
-- INGRESO vs COSTO - SERVICIOS VARIOS
 with tabla as(
select
       'ACTA_S_F' TIPO,
       o.product_id,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       (select catedesc from pr_product p, categori where p.product_id=o.product_id and catecodi=category_id) Nom_cate,
       acta acta,
       o.task_type_id titr,
       o.concept,
       (select sum(d.valor_total) from ge_detalle_acta d, ge_items i where  d.id_acta=acta and  d.id_orden=o.order_id and d.id_items=i.items_id and i.item_classif_id!=23) Costo,
       (select sum(d.valor_total) from ge_detalle_acta d where d.id_acta=acta and d.id_orden=o.order_id and id_items=4001293 ) Iva,
       o.clctclco,
       o.clcodesc,
       co.id_contratista contratista,
       (select con.nombre_contratista from ge_contratista con where con.id_contratista=co.id_contratista) nombre,
       o.legalization_date fec_lega,
       o.actividad,
       o.order_id orden,
       null factura,
       null  fecha,
       o.cuenta,
       package_id,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = o.cuenta) Nom_Cuenta,
       (CASE WHEN o.concept IS NOT null and o.package_id is not null
               --<< CA-200-1403
               --
               AND
               (o.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = o.actividad))
               -->>
         THEN
          (CASE WHEN o.concept NOT IN (19,30,291,674) THEN
              (CASE WHEN o.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                   (SELECT nvl(SUM(cargvalo),0)
                      FROM cargos ca, cuencobr co, factura fa
                     WHERE cargnuse = product_id
                       AND cargconc = o.concept
                       AND cargcaca IN (41,53)
                       AND cargsign = 'DB'
                       AND cargcuco = cucocodi
                       AND cucofact = fa.factcodi
                       AND fa.factfege >= dtcurfein AND fa.factfege <=dtcurfefi
					   AND substr(cargdoso,4,1000) = (o.package_id)--200-2624
                       AND ca.cargcodo= o.order_id
                       AND cargtipr = 'A')
                   ELSE
                     0 END)
               ELSE
                 0 END)
          ELSE
            0 END) Ingreso
from ldc_ordenes_costo_ingreso o, ge_acta a, ge_contrato co
where o.nuano=NUPANO
  and o.numes=NUPMES
  and o.acta is not null
  and a.id_acta=acta
  and co.id_contrato=a.id_contrato
  and (a.extern_pay_date is null or a.extern_pay_date > dtcurfefi)
)
select TIPO,
       product_id,
       cate,
       Nom_cate,
       acta,
       titr,
       concept,
       Costo,
       Iva,
       clctclco,
       clcodesc,
       contratista,
       nombre,
       fec_lega,
       actividad,
       orden,
       factura,
       fecha,
       cuenta,
       package_id,
       Nom_Cuenta,
(CASE WHEN TABLA.INGRESO=0 THEN
      CASE WHEN tabla.concept IS NOT  null and tabla.package_id is not null
             --<< CA-200-1403
             --
             AND
             (tabla.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = tabla.actividad))
             -->>
         THEN
          (CASE WHEN concept NOT IN (19,30,291,674) THEN
              (CASE WHEN TABLA.TITR NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                   (SELECT nvl(SUM(cargvalo),0)
                      FROM cargos ca, cuencobr co, factura fa
                     WHERE cargnuse = product_id
                       AND cargconc = tabla.concept
                       AND cargcaca IN (41,53)
                       AND cargsign = 'DB'
                       AND cargcuco = cucocodi
                       AND cucofact = fa.factcodi
                       AND fa.factfege >= dtcurfein AND fa.factfege <= dtcurfefi
					   AND substr(cargdoso,4,1000) = (tabla.package_id)--200-2624
                       AND cargtipr = 'A')
                   ELSE
                     0 END)
               ELSE
                 0 END)
          ELSE
            0 END
        ELSE
            TABLA.INGRESO
        END) Ing_Otro,
        (select 'CONECTADO' from hicaesco h
         where h.hcecfech >= dtcurfein --to_date('01/04/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
           and h.hcecfech <= dtcurfefi --to_date('30/04/2016 23:59:59','dd/mm/yyyy hh24:mi:ss'
           and h.hcecserv = 7014 and h.hcecnuse = product_id and h.hcececan = 96 and h.hcececac = 1) Estado
from tabla;




CURSOR cu_ge_costingrSINA1(dtcurfein DATE,dtcurfefi DATE) IS
-- INGRESO vs COSTO - SERVICIOS VARIOS
with tabla as(
select /*+ INDEX (o IDX_ORDENES_COSTO_INGRESO)  */
       o.order_id, o.task_type_id,o.operating_unit_id, o.legalization_date, o.clctclco,
       o.clcodesc, o.concept, o.product_id, o.package_id, o.actividad, o.cuenta,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       u.es_externa,
       u.contractor_id,
       u.name,
       sum(oi.value) costo
from ldc_ordenes_costo_ingreso o, or_order_items oi, or_operating_unit u
where o.nuano=nupano
  and o.numes=nupmes
  and oi.order_id=o.order_id
  and oi.value!=0
  and u.operating_unit_id=o.operating_unit_id
  and not exists(select null from ct_order_certifica c where c.order_id=o.order_id)
 group by o.order_id, o.task_type_id,o.operating_unit_id, o.legalization_date, o.clctclco,
       o.clcodesc, o.concept, o.product_id, o.package_id, o.actividad, o.cuenta,  u.es_externa,
       u.contractor_id,  u.name)
select 'SIN_ACTA' tipo,
       tabla.order_id orden, tabla.task_type_id titr,
       decode(tabla.es_externa,'Y',tabla.contractor_id, tabla.operating_unit_id) contratista,
       nvl((select con.nombre_contratista from ge_contratista con where con.id_contratista=tabla.contractor_id),tabla.name) nombre,
       tabla.legalization_date fec_lega, tabla.clctclco,
       tabla.clcodesc, tabla.concept, tabla.product_id,tabla.package_id, tabla.actividad, tabla.cuenta,
       tabla.cate,
       decode(tabla.es_externa,'Y', tabla.costo,0) costo, 0 Iva,
       (select catedesc from  categori where catecodi=tabla.cate) Nom_cate,
       null factura,
       null  fecha,
       null acta,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = tabla.cuenta) Nom_Cuenta,
       (CASE WHEN tabla.concept IS NOT null and tabla.package_id is not null
               --<< CA-200-1403
               --
               AND
               (tabla.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = tabla.actividad))
               -->>
         THEN
          (CASE WHEN tabla.concept NOT IN (19,30,291,674) THEN
              (CASE WHEN tabla.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                   (SELECT nvl(SUM(cargvalo),0)
                      FROM cargos ca, cuencobr co, factura fa
                     WHERE cargnuse = product_id
                       AND cargconc = tabla.concept
                       AND cargcaca IN (41,53)
                       AND cargsign = 'DB'
                       AND cargcuco = cucocodi
                       AND cucofact = fa.factcodi
                       AND fa.factfege >= dtcurfein AND fa.factfege <=dtcurfefi
					   AND substr(cargdoso,4,1000) = to_char(tabla.package_id)--200-2624
                       AND ca.cargcodo= tabla.order_id
                       AND cargtipr = 'A')
                   ELSE
                     0 END)
               ELSE
                 0 END)
          ELSE
            0 END) Ingreso,
            (CASE WHEN tabla.concept IS NOT  null and tabla.package_id is not null
                 --<< CA-200-1403
                 --
                 AND
                 (tabla.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = tabla.actividad))
                 -->>
             THEN
                (CASE WHEN tabla.concept NOT IN (19,30,291,674) THEN
                    (CASE WHEN tabla.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                         (SELECT nvl(SUM(cargvalo),0)
                            FROM cargos ca, cuencobr co, factura fa
                           WHERE cargnuse = product_id
                             AND cargconc = tabla.concept
                             AND cargcaca IN (41,53)
                             AND cargsign = 'DB'
                             AND cargcuco = cucocodi
                             AND cucofact = fa.factcodi
                             AND fa.factfege >= dtcurfein AND fa.factfege <= dtcurfefi
							 AND substr(cargdoso,4,1000) = to_char(tabla.package_id)--200-2624
                             AND cargtipr = 'A')
                         ELSE
                           0 END)
                     ELSE
                       0 END)
          ELSE
            0 END) Ing_Otro,
            (select 'CONECTADO' from hicaesco h
         where h.hcecfech >= dtcurfein --to_date('01/04/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
           and h.hcecfech <= dtcurfefi --to_date('30/04/2016 23:59:59','dd/mm/yyyy hh24:mi:ss'
           and h.hcecserv = 7014 and h.hcecnuse = product_id and h.hcececan = 96 and h.hcececac = 1) Estado
from tabla;



CURSOR cu_ge_costingrSINA2(dtcurfein DATE,dtcurfefi DATE) IS

select /*+ INDEX (o IDX_ORDENES_COSTO_INGRESO)  */
       'SIN_ACTA' TIPO,
       o.product_id,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       (select catedesc from pr_product p, categori where p.product_id=o.product_id and catecodi=category_id) Nom_cate,
       null acta,
       o.task_type_id titr,
       o.concept,
       sum(nvl(d.value_reference * cn.liquidation_sign* nvl((select -1 from or_related_order where related_order_id=o.order_id and RELA_ORDER_TYPE_ID=15),1),0)) Costo,
       0 Iva,
       o.clctclco,
       o.clcodesc,
       decode(co.contractor_id, null, co.operating_unit_id, co.contractor_id) contratista,
       case when co.contractor_id is not null then
     (select con.nombre_contratista from ge_contratista con where con.id_contratista=co.contractor_id)
     else
    co.name
     end nombre,
       o.legalization_date fec_lega,
       o.actividad,
       o.order_id orden,
       null factura,
       null  fecha,
       o.cuenta,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = o.cuenta) Nom_Cuenta,
       (CASE WHEN o.concept IS NOT null and o.package_id is not null
           AND
           (o.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = o.actividad))
         THEN
          (CASE WHEN o.concept NOT IN (19,30,291,674) THEN
              (CASE WHEN o.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                   (SELECT nvl(SUM(cargvalo),0)
                      FROM cargos ca, cuencobr co, factura fa
                     WHERE cargnuse = o.product_id
                       AND cargconc = o.concept
                       AND cargcaca IN (41,53)
                       AND cargsign = 'DB'
                       AND cargcuco = cucocodi
                       AND cucofact = fa.factcodi
                       AND fa.factfege >= dtcurfein AND fa.factfege <=dtcurfefi
					   AND substr(cargdoso,4,1000) = to_char(o.package_id)--200-2624
                       AND ca.cargcodo= o.order_id
                       AND cargtipr = 'A')
                   ELSE
                     0 END)
               ELSE
                 0 END)
          ELSE
            0 END) Ingreso,
          (CASE WHEN o.concept IS NOT  null and o.package_id is not null
               AND
               (o.actividad not in (select itn.items_id from ct_item_novelty itn where itn.items_id = o.actividad))
             THEN
              (CASE WHEN concept NOT IN (19,30,291,674) THEN
                  (CASE WHEN o.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) THEN
                       (SELECT nvl(SUM(cargvalo),0)
                          FROM cargos ca, cuencobr co, factura fa
                         WHERE cargnuse = o.product_id
                           AND cargconc = o.concept
                           AND cargcaca IN (41,53)
                           AND cargsign = 'DB'
                           AND cargcuco = cucocodi
                           AND cucofact = fa.factcodi
                           AND fa.factfege >= dtcurfein AND fa.factfege <= dtcurfefi
						   AND substr(cargdoso,4,1000) = to_char(o.package_id)--200-2624
                           AND cargtipr = 'A')
                       ELSE
                         0 END)
                   ELSE
                     0 END)
          ELSE
            0
            END
         ) Ing_Otro,
            (select 'CONECTADO' from hicaesco h
         where h.hcecfech >= dtcurfein --to_date('01/04/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
           and h.hcecfech <= dtcurfefi --to_date('30/04/2016 23:59:59','dd/mm/yyyy hh24:mi:ss'
           and h.hcecserv = 7014 and h.hcecnuse = o.product_id and h.hcececan = 96 and h.hcececac = 1) Estado
from ldc_ordenes_costo_ingreso o, or_order_activity d, or_operating_unit co,  ct_item_novelty cn
where o.nuano=nupano
  and o.numes=nupmes
  and o.order_id=d.order_id
  and cn.items_id=d.activity_id
  and d.value_reference!=0
 and not exists(select null from ct_order_certifica c where c.order_id=o.order_id)
 and co.operating_unit_id=o.operating_unit_id
 group by o.package_id, o.product_id, o.order_id, legalization_date, o.concept, null, o.task_type_id, null, null,
       o.clctclco,
       o.clcodesc,
       co.contractor_id,
       o.actividad,
       o.cuenta,
       co.operating_unit_id,
       co.name;



/*** CURSOR DEL INGRESO CUMPLIDO MIGRADO Y CONSTRUCTORAS ***/
CURSOR cu_ge_ingreso(dtcurfein DATE,dtcurfefi DATE) IS
-- SERVICIOS CUMPLIDOS UNIFICADOS
    select invmsesu, sesucate, /*concclco,*/ invmconc conc,
           (select distinct ctt.clctclco from ic_clascott ctt
             where ctt.clcttitr in (select ott.task_type_id from or_task_type ott
                                     where ott.concept = invmconc and rownum = 1))  Clasitt,
           (case when tipo in ('Ing_Mig','Int_Mig') and invmconc = 30 then
                 Contabilizar
                 else
                   0 end) Int_Migrada,
           (case when tipo in ('Ing_Mig','Int_Mig') and invmconc = 19 then
                 Contabilizar
                 else
                   0 end) cxc_Migrada,
           (case when tipo in ('Ing_Mig','Int_Mig') and invmconc = 674 then
                 Contabilizar
                 else
                   0 end) rp_Migrada,
           (case when tipo in ('Ing_Osf'/*,'Ing_Interna_Osf','Ing_Red_Matriz'*/) and invmconc in (30, 291) then -- Ing_Red_Matriz
                 Contabilizar
                 else
                   0 end) Int_osf,
           (case when tipo in ('Ing_Osf'/*,'Ing_Interna_Osf'*/) and invmconc = 19 then
                 Contabilizar
                 else
                   0 end) cxc_osf,
           (case when tipo in ('Ing_Osf'/*,'Ing_Interna_Osf','Ing_Red_Matriz'*/) and invmconc = 674 then
                 Contabilizar
                 else
                   0 end) Rp_osf,
           (case when tipo in ('Ing_Const','Int_Const') and invmconc in (30, 291) then
                 Contabilizar
                 else
                   0 end) Int_Const,
           (case when tipo in ('Ing_Const','Int_Const') and invmconc = 19 then
                 Contabilizar
                 else
                   0 end) cxc_Const,
           (case when tipo in ('Ing_Const','Int_Const') and invmconc = 674 then
                 Contabilizar
                 else
                   0 end) Rp_Const,
           orden
 from (

 -- MIGRADAS ANULADAS
SELECT 'Anu_Mig' Tipo, M.INVMSESU, s.sesucate, M.INVMCONC, o.concdesc, M.INVMVAIN Contabilizar, 0 Orden
  from ldci_ingrevemi m, servsusc s, ab_address, suscripc, ge_subscriber g,
       ldci_centbenelocal l, concepto o
 where m.invmsesu in (SELECT distinct hcecnuse FROM hicaesco h
                       WHERE hcececac in (110)
                         AND hcecserv = 7014
                         AND hcecfech >= dtcurfein and hcecfech <= dtcurfefi)
   AND M.INVMSESU = s.sesunuse
   AND sesususc = susccodi
   AND suscclie = g.subscriber_id
   AND g.address_id = ab_address.address_id
   AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
--
UNION ALL
--
-- Internas MIGRADAS
SELECT 'Int_Mig' Tipo, m.invmsesu, sesucate, invmconc, o.concdesc, sum(invmvain) contabilizar, orden
  from Ldci_Ingrevemi m, servsusc s, ab_address, suscripc, ge_subscriber g,
       ldci_centbenelocal l, concepto o,
      (SELECT DISTINCT OR_order_activity.product_id PRODUCTO, OR_order.order_id orden
         FROM OR_order_activity, or_order , mo_packages
        WHERE OR_order_activity.package_id = mo_packages.package_id
          AND mo_packages.package_type_id in (100271)
          AND OR_order.order_id = OR_order_activity.order_id
          AND or_order.task_type_id in (12149, 12151) -- (10622, 10624)
          AND OR_order.legalization_date >= dtcurfein          -- FECHA INICIAL
          AND OR_order.legalization_date <= dtcurfefi
          AND OR_order.CAUSAL_ID IN (select c.causal_id from ge_causal c where c.class_causal_id = 1)
          AND OR_order_activity.product_id not in (select act.product_id
                                                     from or_order_activity act, or_order oo
                                                    where act.product_id = OR_order_activity.product_id
                                                      and oo.task_type_id in (10622, 10624)
                                                      and act.order_id = oo.order_id
                                                      and oo.legalization_date < '01/06/2018')
          AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                     FROM hicaesco h
                                                    WHERE H.HCECNUSE = OR_order_activity.product_id
                                                      AND hcececan = 96
                                                      AND hcececac = 1
                                                      AND hcecserv = 7014
                                                      AND hcecfech < dtcurfein)
          AND OR_order_activity.order_id not in (select oo.related_order_id
                                                   from OR_related_order oo
                                                  where oo.related_order_id = OR_order_activity.order_id
                                                    and oo.rela_order_type_id = 14)
       )  uu
 WHERE m.invmsesu = producto
   AND m.invmsesu = s.sesunuse
   AND sesususc = susccodi
   AND suscclie = g.subscriber_id
   AND g.address_id = ab_address.address_id
   AND ab_address.geograp_location_id = l.celoloca AND invmconc = conccodi
   AND m.invmconc in (30)
Group by m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', l.celocebe, orden
--
--
UNION ALL
--
-- INGRESOS MIGRADOS - Ultima consulta
select 'Ing_Mig' Tipo, invmsesu, sesucate, invmconc, concdesc, (sum(Total) - sum(nvl(reportada,0))) Contabilizar, orden
  from (
          SELECT  /*+
                      index (cargos, IX_CARGOS02)
                      index (ab_address, PK_AB_ADDRESS)
                      index (servsusc, PK_SERVSUSC)
                  */
                  m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', sum(invmvain) total, ac.order_id orden,
                  (SELECT sum(invmvain)
                     from Ldci_Ingrevemi x
                    where x.invmsesu = m.invmsesu
                      and x.invmsesu in (SELECT DISTINCT  OR_order_activity.product_id
                                              FROM OR_order_activity, or_order, mo_packages
                                             WHERE OR_order.order_id = OR_order_activity.order_id
                                               AND OR_order_activity.package_id = mo_packages.package_id
                                               AND (
                                                    or_order.task_type_id in (10622, 10624)    AND
                                                    OR_order.legalization_date >= '09/02/2015' AND
                                                    OR_order.legalization_date <= '31/05/2018 23:59:59' -- Fecha Fija
                                                  OR
                                                    -- Nuevo esquema de reportar Ingreso de Interna
                                                    or_order.task_type_id in (12149, 12151)    AND
                                                    OR_order.legalization_date >= '01/06/2018' AND    -- Fecha Fija - Nuevo esquema de reportar Interna
                                                    OR_order.legalization_date <= dtcurfefi -- Fecha cierre mes anterior
                                                   )
                                               AND OR_order.CAUSAL_ID IN (select c.causal_id from ge_causal c where c.class_causal_id = 1)
                                        )

                      AND x.invmconc = 30
                      AND x.invmconc = m.invmconc
                    group by x.invmsesu) Reportada,
                   l.celocebe
          from Ldci_Ingrevemi m, servsusc s, ab_address, suscripc, ge_subscriber g,
               ldci_centbenelocal l, concepto o, or_order_Activity ac, or_task_type ot, mo_packages mp
          where m.invmsesu in (SELECT distinct hcecnuse
                                 FROM hicaesco h
                                WHERE hcececan = 96
                                  AND hcececac = 1
                                  AND hcecserv = 7014
                                  AND hcecfech >= dtcurfein and hcecfech <= dtcurfefi)
          AND m.invmsesu = ac.product_id
          AND ac.package_id = mp.package_id
          AND mp.package_type_id = 100271
          AND ac.task_type_id = ot.task_type_id
          AND m.invmconc = ot.concept
          AND m.invmsesu = s.sesunuse
          AND sesususc = susccodi
          AND suscclie = g.subscriber_id
          AND g.address_id = ab_address.address_id
          AND ab_address.geograp_location_id = l.celoloca
          AND invmconc = conccodi
          AND ac.order_id not in (select oo.order_id from or_order oo, ge_causal gc
                                   where oo.order_id = ac.order_id and oo.causal_id = gc.causal_id and gc.class_causal_id = 1)
          AND ac.order_id not in (select oo.related_order_id from or_related_order oo where oo.related_order_id = ac.order_id)
         group by m.invmsesu, sesucate, invmconc, o.concdesc, 'DB', l.celocebe, ac.order_id
         ORDER BY INVMSESU, INVMCONC
      )
group by invmsesu, sesucate, invmconc, concdesc, 'DB', celocebe, orden
having (sum(Total) - sum(nvl(reportada,0))) != 0
--
--
UNION ALL
--
-- Ingreso OSF ventas con formulario
select tipo, producto, sesucate, conc, concdesc, total,
       (select ac.order_id from or_order_activity ac, or_task_type tt, or_order oo
         where ac.product_id = producto and ac.package_id = solicitud and ac.order_id = oo.order_id and oo.order_status_id = 8
           and oo.causal_id in (select gc.causal_id from ge_Causal gc where gc.causal_id = oo.causal_id and gc.class_causal_id = 1)
           and ac.task_type_id = tt.task_type_id and tt.concept = conc
           AND oo.order_id not in (select oo.related_order_id from or_related_order oo where oo.related_order_id = oo.order_id)
           AND rownum = 1
       ) orden
from
(
select 'Ing_Osf' Tipo, cargnuse producto, sesucate, cargconc conc, concdesc,
       sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) total, substr(cargdoso, 4, 1000)/*substr(cargdoso, 4,8) --200-2624*/ solicitud
 from cargos c, CUENCOBR, FACTURA, servsusc ss, concepto o
where FACTFEGE >= dtcurfein
  and FACTFEGE <= dtcurfefi
  and factcodi = CUCOfact
  and CARGCUCO = CUCOCODI
  and cargnuse = sesunuse
  and sesuserv = 7014
  AND cargfecr <= dtcurfefi
  and cargconc = conccodi
  and concclco in (4,19,400)
  and cargtipr = 'A'
  and cargcaca in (41,53)
  and cargsign = 'DB'
Group by cargnuse, sesucate, concclco, cargconc, concdesc, --substr(cargdoso, 4,8)--200-2624
		  substr(cargdoso, 4,1000)--200-2624
)
--
--
UNION ALL
--
-- INGRESOS OSF NUEVA 03/05/2015
select *
  from
(
select 'Ing_Const' Tipo, producto, SESUCATE, CARGCONC, CONCDESC, (SUM(VALOR) - sum(nvl(reportada,0))) Contabilizar, orden
FROM (
      select producto, package_type_id, sesucate, sesusuca, cargconc, concdesc, (cargvalo/ventas) Valor,
             (select GEOGRAP_LOCATION_ID from AB_ADDRESS where address_id = susciddi) LOCA,
             -- Ingreso Reportado
             (select sum(vr_unitario/ventas) vr_unitario
               from (select cargconc, product_id, vr_unitario
                       from
                            (select cargconc, product_id, (cargvalo) Vr_Unitario, package_id
                               from cargos c,
                                    (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id
                                       FROM OR_order_activity, or_order, mo_packages
                                      WHERE OR_order_activity.package_id = mo_packages.package_id

                                        AND (
                                              or_order.task_type_id in (10622, 10624)    AND
                                              OR_order.legalization_date >= '09/02/2015' AND
                                              OR_order.legalization_date <= '31/05/2018 23:59:59' -- Fecha Fija
                                            OR
                                              -- Nuevo esquema de reportar Ingreso de Interna
                                              or_order.task_type_id in (12149, 12151)    AND
                                              OR_order.legalization_date >= '01/06/2018' AND    -- Fecha Fija - Nuevo esquema de reportar Interna
                                              OR_order.legalization_date <= dtcurfefi -- Fecha cierre mes anterior
                                            )
                                        AND mo_packages.package_type_id in (323)
                                        AND OR_order.order_id = OR_order_activity.order_id
                                        AND OR_order_activity.Status = 'F'
                                        AND OR_order.CAUSAL_ID IN (select c.causal_id from ge_causal c where c.class_causal_id = 1)
                                    )

                     where cargdoso = 'PP-' || package_id
                       and cargconc in (30, 291)
                       ) u
                  ) ux
              where ux.product_id = uu.producto --uu.product_id
                and ux.cargconc = uu.cargconc
             ) Reportada,
             orden
        ----
        from (
              select cargconc, cargvalo, package_id, package_type_id, producto, --u.product_id,
                     cargunid VENTAS, orden
                from cargos, concepto o,
                     (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id producto, tt.concept, a.order_id orden
                        from or_order_activity a, mo_packages m, or_task_type tt
                       where a.product_id in (SELECT distinct hcecnuse
                                               FROM hicaesco h
                                              WHERE hcecfech >= dtcurfein and hcecfech <= dtcurfefi
                                                AND h.hcecnuse = a.product_id
                                                AND hcececan = 96
                                                AND hcececac = 1
                                                AND hcecserv = 7014)
                        and a.package_id = m.package_id and m.package_type_id in (323/*, 100229*/)
                        and a.task_type_id = tt.task_type_id
                        and a.order_id not in (select oo.related_order_id from or_related_order oo where oo.related_order_id = a.order_id)) u
               where cargdoso in 'PP-'||package_id
                 and cargconc =  conccodi
                 and concept  =  cargconc
                 and concclco in (4,19,400)
                 and cargcaca in (41,53)
             ) uu, concepto, servsusc, suscripc
        where sesunuse = producto
          and sesususc = susccodi
          and cargconc = conccodi
     )
      GROUP BY loca, producto, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, package_type_id, orden
)
--
--
UNION ALL
--
-- Internas OSF Legalizadas
select 'Int_Const' Tipo, product_id, SESUCATE, CARGCONC, CONCDESC, (VALOR) Contabilizar, orden
  FROM (
select (select l.celocebe
          from GE_GEOGRA_LOCATION t, ldci_centbenelocal l
         where geograp_location_id = (select GEOGRAP_LOCATION_ID from AB_ADDRESS
                                       where address_id = susciddi)
          and t.geo_loca_father_id = l.celodpto
          and t.geograp_location_id = celoloca) CEBE,
       (select GEOGRAP_LOCATION_ID from AB_ADDRESS where address_id = susciddi) LOCA,
       (select g.description from ge_geogra_location g
         where g.geograp_location_id =  (select GEOGRAP_LOCATION_ID from AB_ADDRESS where address_id = susciddi)) DESCRIPCION,
       product_id, package_type_id, orden, sesucate, sesusuca, cargconc, concdesc, Vr_Unitario Valor
 from  servsusc, suscripc,
       (select cargconc, o.concdesc, product_id, m.package_type_id, u.order_id orden,
               (cargvalo/cargunid) Vr_Unitario
          from cargos c, concepto o, mo_packages m,
               (SELECT DISTINCT to_char(mo_packages.package_id) package_id, OR_order_activity.product_id, OR_order.order_id
                  FROM OR_order_activity, or_order, mo_packages
                 WHERE OR_order.legalization_date >= dtcurfein                     -- FECHA INICIAL
                   AND OR_order.legalization_date <= dtcurfefi                     -- FECHA FINAL
                   AND or_order.order_id = OR_order_activity.order_id
                   AND OR_order_activity.Status = 'F'
                   AND OR_order_activity.package_id = mo_packages.package_id
                   AND mo_packages.package_type_id in (323)
                   AND or_order.task_type_id in (12149, 12151) -- (10622, 10624)
                   AND OR_order.CAUSAL_ID IN (select c.causal_id from ge_causal c where c.class_causal_id = 1)
                   AND OR_order_activity.order_id = or_order.order_id
                   AND OR_order_activity.product_id not in (select act.product_id
                                                              from or_order_activity act, or_order oo, mo_packages mp,
                                                                   OR_related_order oro
                                                             where act.product_id = OR_order_activity.product_id
                                                               and act.order_id = oo.order_id
                                                               and oro.related_order_id = oo.order_id
                                                               and oro.rela_order_type_id in (4, 13)
                                                               and oo.task_type_id in (10622, 10624)
                                                               AND act.package_id = mp.package_id
                                                               AND mp.package_type_id in (323)
                                                               and oo.legalization_date < '01/06/2018' -- Fecha Fija, comienza nuevo proceso interna
                                                               AND oo.CAUSAL_ID IN (select ca.causal_id from ge_causal ca
                                                                                     where ca.causal_id = oo.CAUSAL_ID
                                                                                       and ca.class_causal_id = 1))
                   AND OR_order_activity.product_id not in (SELECT distinct hcecnuse
                                                              FROM hicaesco h
                                                             WHERE h.hcecnuse = OR_order_activity.product_id
                                                               AND hcececan = 96
                                                               AND hcececac = 1
                                                               AND hcecserv = 7014
                                                               AND hcecfech < dtcurfein)
                   AND OR_order_activity.order_id not in (select oo.related_order_id
                                                            from OR_related_order oo
                                                           where oo.related_order_id = OR_order_activity.order_id
                                                             and oo.rela_order_type_id = 14)
               ) u
         where cargconc in (30, 291)
           and cargconc = o.conccodi
           and cargdoso = 'PP-'||u.package_id
           and u.package_id = m.package_id)
  where sesunuse = product_id
    and sesususc = susccodi
 )

--
UNION ALL
--
-- Ingreso Red Matriz
--
select 'Ing_Red_Matriz' Tipo, producto, SESUCATE, CARGCONC conc, CONCDESC, SUM(VALOR) TOTAL, orden
  FROM (
select package_id Solicitud, producto, package_type_id, sesucate, sesusuca, cargconc, concdesc, cargvalo Valor, order_id orden
  ----
  from (
        select cargconc, cargvalo, package_id, package_type_id, producto, order_id --u.product_id,
          from cargos,
               (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id producto, a.order_id
                  from or_order_activity a, mo_packages m, or_order o
                 where a.order_id = o.order_id
                   and a.package_id = m.package_id
                   and m.package_type_id in (323)
                   and a.task_type_id in (10268)
                   and o.order_status_id = 8
                   and o.causal_id in (select gc.causal_id from ge_causal gc where gc.causal_id = o.causal_id and gc.class_causal_id = 1)
                   and o.legalization_date >= dtcurfein
                   and o.legalization_date <= dtcurfefi
                   AND o.order_id not in (select oo.related_order_id from or_related_order oo where oo.related_order_id = o.order_id)
               ) u
         where cargnuse = producto
           and cargdoso in 'PP-'||package_id
           and cargconc in (674, 30)
           and cargcaca in (41,53)
       ) uu, concepto, servsusc, suscripc
  where sesunuse = producto
    and sesususc = susccodi
    and cargconc = conccodi
)
GROUP BY producto, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, orden

);


/** Incluimos ingreso de Servicios cumplidos Migrados, Constructoras y Osf **/
CURSOR cu_va_ingreso(vnuse number, vconc number) IS
select 'x'
  from ldc_osf_costingr l
 where l.nuano = nupano
   and l.numes = nupmes
   and l.product_id = vnuse
   and l.concept = vconc;

/** Incluimos Notas de productos sin costo y sin conexion **/
CURSOR cu_notas_varias(dtcurfein DATE,dtcurfefi DATE) IS
select cargnuse, sesucate, cargconc,
      (select distinct ctt.clctclco from ic_clascott ctt
                   where ctt.clcttitr in (select ott.task_type_id from or_task_type ott
                                           where ott.concept = cargconc and rownum = 1))  Clasitt,
       sum(decode(cargsign, 'DB',cargvalo, cargvalo*-1)) Tot
  from cargos c, servsusc ss, concepto oo
 where cargnuse =  sesunuse
   and cargcuco >  1
   and cargconc =  conccodi
   and concclco in (4, 19, 400, -- Conceptos de la venta
                    17,         -- Reconexion.
                    27,         -- S.A. Red Interna.
                    28, 89,     -- Mtto Industrial y modif. centro de medicion.
                    81, 118,    -- Serv Varios Grabados.
                    401         -- Revision Periodica
                    )
   and sesuserv =  7014
   and cargfecr >= dtcurfein and cargfecr <= dtcurfefi
   and cargtipr = 'P'
   and cargcaca IN
                   (SELECT CACACODI
                      FROM CAUSCARG
                     WHERE ',' || (SELECT casevalo
                                      FROM ldci_carasewe
                                     WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
   and cargsign IN ('DB','CR')
   and cargdoso like 'N%'
Group by cargnuse, cargconc, sesucate;

Cursor cuOrdenes(dtcurfein date, dtcurfefi date) is
--200-2508------------------------------------------------------------------------
select /*+index(o IDX_OR_ORDER16) */ order_id, task_type_id, legalization_date, operating_unit_id, tt.clctclco,
(select icc.clcodesc  from ic_clascont icc where clctclco = clcocodi) clcodesc,
       (select t.concept from or_task_type t where t.task_type_id=o.task_type_id) concept,
       (select oa.product_id from or_order_activity oa where oa.order_id=o.order_id and rownum=1) product_id,
       (select oa.package_id from or_order_activity oa where oa.order_id=o.order_id and rownum=1) solicitud,
       (select oa.activity_id from or_order_activity oa where oa.order_id=o.order_id and LDC_BcFinanceOt.fnuGetActivityId(oa.order_id)=oa.order_activity_id) actividad,
       (select lg.cuencosto from ldci_cugacoclasi lg where lg.cuenclasifi = clctclco) Cuenta,
       (select certificate_id from ct_order_certifica c where c.order_id=o.order_id) acta
from or_order o, ge_causal c, ic_clascott tt
where trunc(legalization_date)>=dtcurfein
  and trunc(legalization_date)<=dtcurfefi
  and o.order_status_id=8
  and o.causal_id=c.causal_id
  and c.class_causal_id=1
  and tt.clcttitr=o.task_type_id
  and task_type_id!=10336
  and clctclco not in (311,246,303,252,253,245,314,411,413)
  and trunc(o.created_date)<=dtcurfefi;


cursor cuOrdenes2(dtcurfein date, dtcurfefi date) is

select /*+index(o IDX_OR_ORDER_012) */ order_id, real_task_type_id task_type_id, created_date legalization_date, operating_unit_id, tt.clctclco,
(select icc.clcodesc  from ic_clascont icc where clctclco = clcocodi) clcodesc,
       (select t.concept from or_task_type t where t.task_type_id=o.real_task_type_id) concept,
       (select oa.product_id from or_order_activity oa where oa.order_id=o.order_id and rownum=1) product_id,
       (select oa.package_id from or_order_activity oa where oa.order_id=o.order_id and rownum=1) solicitud,
       (select oa.activity_id from or_order_activity oa where oa.order_id=o.order_id and LDC_BcFinanceOt.fnuGetActivityId(oa.order_id)=oa.order_activity_id) actividad,
       (select lg.cuencosto from ldci_cugacoclasi lg where lg.cuenclasifi = clctclco) Cuenta,
       (select certificate_id from ct_order_certifica c where c.order_id=o.order_id) acta
from or_order o, ge_causal c, ic_clascott tt
where --<< CA-200-1403
   o.order_status_id = 8
  and task_type_id=10336
  -->>
  and trunc(created_date)>=dtcurfein
  and trunc(created_date)<=dtcurfefi
  and trunc(legalization_date)<dtcurfefi
  and o.causal_id=c.causal_id
  and c.class_causal_id=1
  and tt.clcttitr=o.real_task_type_id
  and clctclco not in (311,246,303,252,253,245,314,411,413);

cursor cuOrdenesOtrosMeses1(dtcurfein date, dtcurfefi date) is
select /*+index(o IDX_OR_ORDER04) */ order_id, task_type_id, legalization_date, operating_unit_id, tt.clctclco,
(select icc.clcodesc  from ic_clascont icc where clctclco = clcocodi) clcodesc,
       (select t.concept from or_task_type t where t.task_type_id=o.task_type_id) concept,
       (select oa.product_id from or_order_activity oa where oa.order_id=o.order_id and rownum=1) product_id,
       (select oa.package_id from or_order_activity oa where oa.order_id=o.order_id and rownum=1) solicitud,
       (select oa.activity_id from or_order_activity oa where oa.order_id=o.order_id and LDC_BcFinanceOt.fnuGetActivityId(oa.order_id)=oa.order_activity_id) actividad,
       (select lg.cuencosto from ldci_cugacoclasi lg where lg.cuenclasifi = clctclco) Cuenta,
       (select certificate_id from ct_order_certifica c where c.order_id=o.order_id) acta
from or_order o, ge_causal c, ic_clascott tt
where trunc(o.created_date)>=dtcurfein
  and trunc(o.created_date)<=dtcurfefi
  and trunc(legalization_date)<dtcurfein
  and o.order_status_id=8
  and o.causal_id=c.causal_id
  and c.class_causal_id=1
  and tt.clcttitr=o.task_type_id
  and task_type_id!=10336
  and clctclco not in (311,246,303,252,253,245,314,411,413);


CURSOR cu_ge_costingrFRA1v2(dtcurfein DATE,dtcurfefi DATE) IS
select
       'ACTA_FRA' TIPO,
       o.product_id,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       (select catedesc from pr_product p, categori where p.product_id=o.product_id and catecodi=category_id) Nom_cate,
       acta acta,
       o.task_type_id titr,
       o.concept,
       (select sum(d.valor_total) from ge_detalle_acta d, ge_items i where  d.id_acta=acta and  d.id_orden=o.order_id and d.id_items=i.items_id and i.item_classif_id!=23) Costo,
       (select sum(d.valor_total) from ge_detalle_acta d where d.id_acta=acta and d.id_orden=o.order_id and id_items=4001293 ) Iva,
       o.clctclco,
       o.clcodesc,
       co.id_contratista contratista,
       (select con.nombre_contratista from ge_contratista con where con.id_contratista=co.id_contratista) nombre,
       o.legalization_date fec_lega,
       o.actividad,
       o.order_id orden,
       a.extern_invoice_num factura,
       a.extern_pay_date  fecha,
       o.cuenta,
       package_id,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = o.cuenta) Nom_Cuenta,
       0 Ing_Otro,
	   null Estado
from ldc_ordenes_costo_ingreso o, ge_acta a, ge_contrato co
where o.nuano=NUPANO
  and o.numes=NUPMES
  and o.acta is not null
  and a.id_acta=acta
  and co.id_contrato=a.id_contrato
  and a.extern_pay_date>=dtcurfein
  and a.extern_pay_date<=dtcurfefi;


CURSOR cu_ge_costingrSINF1V2(dtcurfein DATE,dtcurfefi DATE) IS
select
       'ACTA_S_F' TIPO,
       o.product_id,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       (select catedesc from pr_product p, categori where p.product_id=o.product_id and catecodi=category_id) Nom_cate,
       acta acta,
       o.task_type_id titr,
       o.concept,
       (select sum(d.valor_total) from ge_detalle_acta d, ge_items i where  d.id_acta=acta and  d.id_orden=o.order_id and d.id_items=i.items_id and i.item_classif_id!=23) Costo,
       (select sum(d.valor_total) from ge_detalle_acta d where d.id_acta=acta and d.id_orden=o.order_id and id_items=4001293 ) Iva,
       o.clctclco,
       o.clcodesc,
       co.id_contratista contratista,
       (select con.nombre_contratista from ge_contratista con where con.id_contratista=co.id_contratista) nombre,
       o.legalization_date fec_lega,
       o.actividad,
       o.order_id orden,
       null factura,
       null  fecha,
       o.cuenta,
       package_id,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = o.cuenta) Nom_Cuenta,
       0 Ing_Otro,
	 NULL Estado
from ldc_ordenes_costo_ingreso o, ge_acta a, ge_contrato co
where o.nuano=NUPANO
  and o.numes=NUPMES
  and o.acta is not null
  and a.id_acta=acta
  and co.id_contrato=a.id_contrato
  and (a.extern_pay_date is null or a.extern_pay_date > dtcurfefi)
;

CURSOR cu_ge_costingrSINA1V2(dtcurfein DATE,dtcurfefi DATE) IS
-- INGRESO vs COSTO - SERVICIOS VARIOS
with tabla as(
select /*+ INDEX (o IDX_ORDENES_COSTO_INGRESO)  */
       o.order_id, o.task_type_id,o.operating_unit_id, o.legalization_date, o.clctclco,
       o.clcodesc, o.concept, o.product_id, o.package_id, o.actividad, o.cuenta,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       u.es_externa,
       u.contractor_id,
       u.name,
       sum(oi.value) costo
from ldc_ordenes_costo_ingreso o, or_order_items oi, or_operating_unit u
where o.nuano=nupano
  and o.numes=nupmes
  and oi.order_id=o.order_id
  and oi.value!=0
  and u.operating_unit_id=o.operating_unit_id
  and not exists(select null from ct_order_certifica c where c.order_id=o.order_id)
 group by o.order_id, o.task_type_id,o.operating_unit_id, o.legalization_date, o.clctclco,
       o.clcodesc, o.concept, o.product_id, o.package_id, o.actividad, o.cuenta,  u.es_externa,
       u.contractor_id,  u.name)
select 'SIN_ACTA' tipo,
       tabla.order_id orden, tabla.task_type_id titr,
       decode(tabla.es_externa,'Y',tabla.contractor_id, tabla.operating_unit_id) contratista,
       nvl((select con.nombre_contratista from ge_contratista con where con.id_contratista=tabla.contractor_id),tabla.name) nombre,
       tabla.legalization_date fec_lega, tabla.clctclco,
       tabla.clcodesc, tabla.concept, tabla.product_id,tabla.package_id, tabla.actividad, tabla.cuenta,
       tabla.cate,
       decode(tabla.es_externa,'Y', tabla.costo,0) costo, 0 Iva,
       (select catedesc from  categori where catecodi=tabla.cate) Nom_cate,
       null factura,
       null  fecha,
       null acta,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = tabla.cuenta) Nom_Cuenta,
       0 Ingreso,
       0 Ing_Otro,
       NULL Estado
from tabla;


CURSOR cu_ge_costingrSINA2V2(dtcurfein DATE,dtcurfefi DATE) IS
/*-- INGRESO vs COSTO - SERVICIOS VARIOS*/

select /*+ INDEX (o IDX_ORDENES_COSTO_INGRESO)*/
       'SIN_ACTA' TIPO,
       o.product_id,
       (select category_id from pr_product p where p.product_id=o.product_id) cate,
       (select catedesc from pr_product p, categori where p.product_id=o.product_id and catecodi=category_id) Nom_cate,
       null acta,
       o.task_type_id titr,
       o.concept,
       sum(nvl(d.value_reference * cn.liquidation_sign* nvl((select -1 from or_related_order where related_order_id=o.order_id and RELA_ORDER_TYPE_ID=15),1),0)) Costo,
       0 Iva,
       o.clctclco,
       o.clcodesc,
       decode(co.contractor_id, null, co.operating_unit_id, co.contractor_id) contratista,
       case when co.contractor_id is not null then
     (select con.nombre_contratista from ge_contratista con where con.id_contratista=co.contractor_id)
     else
    co.name
     end nombre,
       o.legalization_date fec_lega,
       o.actividad,
       o.order_id orden,
       null factura,
       null  fecha,
       o.cuenta,
       (select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = o.cuenta) Nom_Cuenta,
       0 Ingreso,
       0 Ing_Otro,
       NULL Estado
from ldc_ordenes_costo_ingreso o, or_order_activity d, or_operating_unit co,  ct_item_novelty cn
where o.nuano=nupano
  and o.numes=nupmes
  and o.order_id=d.order_id
  and cn.items_id=d.activity_id
  and d.value_reference!=0
 and not exists(select null from ct_order_certifica c where c.order_id=o.order_id)
 and co.operating_unit_id=o.operating_unit_id
 group by o.package_id, o.product_id, o.order_id, legalization_date, o.concept, null, o.task_type_id, null, null,
       o.clctclco,
       o.clcodesc,
       co.contractor_id,
       o.actividad,
       o.cuenta,
       co.operating_unit_id,
       co.name;
	cursor cuIngCosto(dtcurfein DATE,dtcurfefi DATE) is
		with factu as(
				select factcodi
				from factura fa
				where  fa.factfege >= dtcurfein
				   AND fa.factfege <=dtcurfefi
			),
			cuentas as(
				select cucocodi, product_id, package_id, order_id, concept
				from factu
				inner join cuencobr co on factu.factcodi=co.cucofact
				inner join ldc_ordenes_costo_ingreso c on c.nuano=nupano and c.numes=nupmes and c.product_id=co.cuconuse and  c.concept not in (19,30,291,674) and c.task_type_id not in (10495,12149,12151,10622,10624,12150,12152,12153)
			)
			select cuentas.product_id, cuentas.concept, cuentas.package_id, cuentas.order_id, sum(case when cargcodo=order_id then cargvalo else 0 end) ingreso, sum(case when cargcodo=order_id then 0 else cargvalo end) ing_otro
			from cuentas
			inner join cargos ca on  ca.cargcuco=cuentas.cucocodi and ca.cargconc=cuentas.concept and ca.cargcaca IN (41,53) AND ca.cargsign = 'DB'  AND ca.cargtipr = 'A' AND substr(ca.cargdoso,4,1000) /*substr(ca.cargdoso,4,10) --200-2624*/ = (cuentas.package_id) and ca.cargnuse=cuentas.product_id
			group by cuentas.product_id, cuentas.concept, cuentas.package_id, cuentas.order_id;

CURSOR cu_ge_IVAFACTURADO(dtcurfein DATE,dtcurfefi DATE, sbCuentas ld_parameter.value_chain%type) IS
	with cuentas as(
		select tt.clctclco,
		tt.clcttitr,
		lg.cuencosto
		from ic_clascott tt
		inner join ldci_cugacoclasi lg on lg.cuenclasifi = clctclco
		where instr(sbCuentas, lg.cuencosto,1)>0
		and NVL((SELECT CASE WHEN G.TTIVCICO IS NULL THEN 'S' ELSE 'N' END FROM ldci_titrindiva G WHERE G.TTIVTITR=tt.clcttitr),'N')='S'),
	base as(
		select
		'IVA_FRA' TIPO,
		a.id_acta acta,
		a.extern_invoice_num factura,
		a.extern_pay_date  fecha,
		de.id_orden orden,
		de.valor_total Costo,
		0 Iva,
		co.id_contratista contratista,
		(select con.nombre_contratista from ge_contratista con where con.id_contratista=co.id_contratista) nombre
		from  ge_acta a
		inner join ge_contrato co on co.id_contrato=a.id_contrato
		inner join ge_detalle_Acta de on de.id_Acta = a.id_acta and de.id_items=4001293
		where a.extern_pay_date>= dtcurfein
		and a.extern_pay_date<=dtcurfefi
		and de.valor_total!=0
		and exists(select null from ct_tasktype_contype tc, cuentas
		where (tc.contract_type_id=co.id_tipo_contrato or co.id_contrato=tc.contract_id)
		and tc.task_type_id=cuentas.clcttitr)
	)
	select base.tipo,
	base.acta,
	base.factura,
	base.fecha,
	base.orden,
	o.legalization_date fec_lega,
	base.costo,
	base.iva,
	base.contratista,
	base.nombre,
	cuentas.clctclco,
	(select cl.clcodesc from ic_clascont cl where cl.clcocodi=cuentas.clctclco) clcodesc,
	cuentas.cuencosto cuenta,
	(select lc.cuctdesc from ldci_cuentacontable lc where lc.cuctcodi = cuentas.cuencosto) Nom_Cuenta,
	o.task_type_id titr,
	0 Ing_Otro,
	a.package_id,
	a.product_id,
	(select category_id from pr_product p where p.product_id=a.product_id) cate,
	(select catedesc from pr_product p, categori where p.product_id=a.product_id and catecodi=category_id) Nom_cate,
	a.activity_id actividad,
	(select concept from or_task_type t where task_type_id=o.task_type_id) concept
	from base
	inner join or_order o on o.order_id=Base.orden
	inner join cuentas on o.task_type_id=cuentas.clcttitr
	inner join or_order_activity a on a.order_id=o.order_id;


	Type TABORDEN is TABLE OF cuOrdenes%ROWTYPE;
	Type TABACFRA is TABLE OF cu_ge_costingrFRA1v2%ROWTYPE;
	Type TABSINAC is TABLE OF cu_ge_costingrSINA1V2%ROWTYPE;
	Type TABNOVSINAC is TABLE OF cu_ge_costingrSINA2V2%ROWTYPE;
	Type TABINGRESO	is TABLE OF cuIngCosto%ROWTYPE;
	Type TABIVAFACT	is TABLE OF cu_ge_IVAFACTURADO%ROWTYPE;
	tyORDEN       TABORDEN  := TABORDEN();
	tyACFRA       TABACFRA := TABACFRA();
	tySINAC       TABSINAC := TABSINAC();
	tyNOVSINAC    TABNOVSINAC := TABNOVSINAC();
	tyIngreso	  TABINGRESO := TABINGRESO();
	tyIVAFACT	  TABIVAFACT :=TABIVAFACT();
	sbMes         varchar2(200);
	sbModifica	  ld_parameter.value_chain%type:=nvl(pkg_BCLD_Parameter.fsbObtieneValorCadena('MODI_COSTO_ING_MEJOR'),'N');
	sbIvaFActu	  ld_parameter.value_chain%type:=nvl(pkg_BCLD_Parameter.fsbObtieneValorCadena('MODI_COSTO_ING_IVA'),'N');
	sbCuentaIVA     ld_parameter.value_chain%type:=pkg_BCLD_Parameter.fsbObtieneValorCadena('CTAS_IVA_MAYOR_COSTO_INGRESO');
	sbOtrosMeses	ld_parameter.value_chain%type:=nvl(pkg_BCLD_Parameter.fsbObtieneValorCadena('OT_OTROS_MESES_COSTO_INGRESO'),'N');
--200-2508------------------------------------------------------------------------


vasbcuin        varchar2(1);
dtfefein        ldc_ciercome.cicofein%TYPE;
dtfefefin       ldc_ciercome.cicofech%TYPE;
pmensa          VARCHAR2(1000);
nuok            NUMBER(2);
nucontareg      NUMBER(15) DEFAULT 0;
nucantiregcom   NUMBER(15) DEFAULT 0;
nucantiregtot   NUMBER(15) DEFAULT 0;
nuvalnotas      cargos.cargvalo%TYPE DEFAULT 0;
nuvalingre      cargos.cargvalo%TYPE DEFAULT 0;
sbmail          ld_parameter.value_chain%type;
SBINSTANCIA     varchar2(200);
nutsess         NUMBER;
sbparuser       VARCHAR2(30);

-----
BEGIN
	--
	sbmensa := NULL;
	error := 0;
	nucantiregcom := 0;
	nucantiregtot := 0;
	nucontareg    := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_CANTIDAD_REG_GUARDAR');
	sbmail    := pkg_BCLD_Parameter.fsbObtieneValorCadena('CORREO_COSTO_INGRESO');
	ldc_cier_prorecupaperiodocont(nupano,nupmes,dtfefein,dtfefefin,pmensa,nuok);
	--
	DELETE ldc_osf_costingr l WHERE l.nuano = nupano AND l.numes = nupmes;
	DELETE ldc_ordenes_costo_ingreso  o where o.nuano=nupano and o.numes=nupmes;
	COMMIT;
	SELECT USERENV('SESSIONID'),USER INTO nutsess,sbparuser FROM dual;
	-- Se adiciona al log de procesos
	ldc_proinsertaestaprog(nupano,nupmes,'LDC_PROCCOSTINGR','En ejecucion',nutsess,sbparuser);
	-- Se inicia log del programa
	ldc_proinsertaestaprog(nupano,nupmes,'LDC_LLENACOSTOINGRESOSOCIERRE','En ejecucion',nutsess,sbparuser);
	nucantiregcom:=0;
	BEGIN
		SBINSTANCIA:=ut_dbinstance.fsbgetcurrentinstancetype;
		IF SBINSTANCIA = 'Q' THEN
			SBINSTANCIA :='PRUEBAS';
		ELSIF SBINSTANCIA ='P' THEN
			SBINSTANCIA := 'PRODUCCION';
		ELSIF SBINSTANCIA='B' THEN
			SBINSTANCIA := 'DESARROLLO';
		ELSE
			SBINSTANCIA := 'DESCONOCIDO';
		END IF;
	EXCEPTION
		WHEN OTHERS THEN
			SBINSTANCIA :=NULL;
	END;
	IF sbModifica='S' THEN
		if nupmes = 1 then
			sbMes :='Enero';
		elsif nupmes = 2 then
			sbMes :='Febrero';
		elsif nupmes = 3 then
			sbMes :='Marzo';
		elsif nupmes = 4 then
			sbMes :='Abril';
		elsif nupmes = 5 then
			sbMes :='Mayo';
		elsif nupmes = 6 then
			sbMes :='Junio';
		elsif nupmes = 7 then
			sbMes :='Julio';
		elsif nupmes = 8 then
			sbMes :='Agosto';
		elsif nupmes = 9 then
			sbMes :='Septiembre';
		elsif nupmes = 10 then
			sbMes :='Octubre';
		elsif nupmes = 11 then
			sbMes :='Noviembre';
		elsif nupmes = 12 then
			sbMes :='Diciembre';
		end if ;
		sbMes := sbMes||' '||nupano;
		SBINSTANCIA:=SBINSTANCIA||' '||sbMes;
	END IF;
	pkg_Correo.prcEnviaCorreo( isbDestinatarios =>sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza ORDENES');
	IF sbModifica='S' THEN
		OPEN cuOrdenes(dtfefein,dtfefefin);
			LOOP
				tyORDEN.DELETE;
				FETCH cuOrdenes BULK COLLECT
				INTO tyORDEN LIMIT 1000;
					FOR  nuindice IN 1 .. tyORDEN.COUNT LOOP
						insert into ldc_ordenes_costo_ingreso(nuano, numes , order_id ,task_type_id, operating_unit_id ,legalization_date, clctclco , clcodesc  ,concept ,product_id ,package_id , actividad , cuenta,acta)
						values(nupano, nupmes, tyORDEN(nuindice).order_id, tyORDEN(nuindice).task_type_id,  tyORDEN(nuindice). operating_unit_id, tyORDEN(nuindice).legalization_date,tyORDEN(nuindice).clctclco, tyORDEN(nuindice).clcodesc, tyORDEN(nuindice).concept, tyORDEN(nuindice).product_id, tyORDEN(nuindice).solicitud, tyORDEN(nuindice).actividad, tyORDEN(nuindice).Cuenta, tyORDEN(nuindice).acta);
						nucantiregcom := nucantiregcom + 1;
						IF nucantiregcom >= nucontareg THEN
							COMMIT;
							nucantiregtot := nucantiregtot + nucantiregcom;
							nucantiregcom := 0;
						END IF;
					END LOOP;
				EXIT WHEN cuOrdenes%NOTFOUND;
			END LOOP;
	ELSE
		for reg in cuOrdenes(dtfefein,dtfefefin) loop
			insert into ldc_ordenes_costo_ingreso(nuano, numes , order_id ,task_type_id, operating_unit_id ,legalization_date, clctclco , clcodesc  ,concept ,product_id ,package_id , actividad , cuenta,acta)
			values(nupano, nupmes, reg.order_id, reg.task_type_id,  reg. operating_unit_id, reg.legalization_date,reg.clctclco, reg.clcodesc, reg.concept, reg.product_id, reg.solicitud, reg.actividad, reg.Cuenta, reg.acta);
			nucantiregcom := nucantiregcom + 1;
			IF nucantiregcom >= nucontareg THEN
				COMMIT;
				nucantiregtot := nucantiregtot + nucantiregcom;
				nucantiregcom := 0;
			END IF;
		end loop;
	END IF;

	pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza cuOrdenes2');
	IF sbModifica='S' THEN
		OPEN cuOrdenes2(dtfefein,dtfefefin);
			LOOP
				tyORDEN.DELETE;
				FETCH cuOrdenes2 BULK COLLECT
				INTO tyORDEN LIMIT 1000;
					FOR  nuindice IN 1 .. tyORDEN.COUNT LOOP
						insert into ldc_ordenes_costo_ingreso(nuano, numes , order_id ,task_type_id, operating_unit_id ,legalization_date, clctclco , clcodesc  ,concept ,product_id ,package_id , actividad , cuenta,acta)
						values(nupano, nupmes, tyORDEN(nuindice).order_id, tyORDEN(nuindice).task_type_id,  tyORDEN(nuindice). operating_unit_id, tyORDEN(nuindice).legalization_date,tyORDEN(nuindice).clctclco, tyORDEN(nuindice).clcodesc, tyORDEN(nuindice).concept, tyORDEN(nuindice).product_id, tyORDEN(nuindice).solicitud, tyORDEN(nuindice).actividad, tyORDEN(nuindice).Cuenta, tyORDEN(nuindice).acta);
						nucantiregcom := nucantiregcom + 1;
						IF nucantiregcom >= nucontareg THEN
							COMMIT;
							nucantiregtot := nucantiregtot + nucantiregcom;
							nucantiregcom := 0;
						END IF;
					END LOOP;
				EXIT WHEN cuOrdenes2%NOTFOUND;
			END LOOP;
	ELSE
		for reg in cuOrdenes2(dtfefein,dtfefefin) loop
			insert into ldc_ordenes_costo_ingreso(nuano, numes , order_id ,task_type_id, operating_unit_id ,legalization_date, clctclco , clcodesc  ,concept ,product_id ,package_id , actividad , cuenta, acta, costo, ingreso)
			values(nupano, nupmes, reg.order_id, reg.task_type_id,  reg. operating_unit_id, reg.legalization_date,reg.clctclco, reg.clcodesc, reg.concept, reg.product_id, reg.solicitud, reg.actividad, reg.Cuenta,reg.acta, 0, 0);
			nucantiregcom := nucantiregcom + 1;
			IF nucantiregcom >= nucontareg THEN
				COMMIT;
				nucantiregtot := nucantiregtot + nucantiregcom;
				nucantiregcom := 0;
			END IF;
		end loop;
	END IF;
	--200-2508------------------------------------------------------------------------
	IF sbOtrosMeses='S' THEN
		pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza cuOrdenesOtrosMeses1');
		OPEN cuOrdenesOtrosMeses1(dtfefein,dtfefefin);
			LOOP
				tyORDEN.DELETE;
				FETCH cuOrdenesOtrosMeses1 BULK COLLECT
				INTO tyORDEN LIMIT 1000;
					FOR  nuindice IN 1 .. tyORDEN.COUNT LOOP
						insert into ldc_ordenes_costo_ingreso(nuano, numes , order_id ,task_type_id, operating_unit_id ,legalization_date, clctclco , clcodesc  ,concept ,product_id ,package_id , actividad , cuenta,acta)
						values(nupano, nupmes, tyORDEN(nuindice).order_id, tyORDEN(nuindice).task_type_id,  tyORDEN(nuindice). operating_unit_id, tyORDEN(nuindice).legalization_date,tyORDEN(nuindice).clctclco, tyORDEN(nuindice).clcodesc, tyORDEN(nuindice).concept, tyORDEN(nuindice).product_id, tyORDEN(nuindice).solicitud, tyORDEN(nuindice).actividad, tyORDEN(nuindice).Cuenta, tyORDEN(nuindice).acta);
						nucantiregcom := nucantiregcom + 1;
						IF nucantiregcom >= nucontareg THEN
							COMMIT;
							nucantiregtot := nucantiregtot + nucantiregcom;
							nucantiregcom := 0;
						END IF;
					END LOOP;
				EXIT WHEN cuOrdenesOtrosMeses1%NOTFOUND;
			END LOOP;
	END IF;
	--200-2508------------------------------------------------------------------------
	pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza Costo con Factura');
	IF sbModifica='N' THEN
		-- Recorremos los costos e insertamos..
		FOR i IN cu_ge_costingrfra1(dtfefein,dtfefefin) LOOP
			-- Consultamos las notas
			nuvalnotas := 0;
			BEGIN
			  SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
			  FROM cargos c, servsusc SC
			  WHERE cargnuse   = i.product_id
			  AND cargnuse   = sesunuse
			  AND cargconc   = i.concept
			  AND c.cargfecr BETWEEN dtfefein AND dtfefefin
			  AND cargcuco >= 1
			  AND cargtipr = 'P'
			  AND cargsign in ('DB', 'CR')
			  AND cargcaca in -- NOT IN (50,51,20,23,56,73)
						(SELECT CACACODI
						   FROM CAUSCARG
						  WHERE ',' || (SELECT casevalo
										  FROM ldci_carasewe
										 WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
			  AND cargsign NOT IN ('SA','AS','PA','AP');
			EXCEPTION
			  WHEN no_data_found THEN
				   nuvalnotas := 0;
			END;

			-- Consulta Ingreso mes.
			nuvalingre   := 0;

			-- Insertamos registro
			INSERT INTO ldc_osf_costingr
							 (
							  nuano
							 ,numes
				  --           ,estado
							 ,product_id
							 ,cate -- xxxxx
							 ,tipo
							 ,acta
							 ,factura
							 ,fecha
							 ,contratista
							 ,nombre
							 ,titr
							 ,cuenta
							 ,nom_cuenta
							 ,clasificador
							 ,actividad
							 ,concept
							 ,costo
							 ,iva
							 ,ing_otro
							 ,notas
							 ,ing_int_mig
							 ,ing_cxc_mig
							 ,ing_rp_mig
							 ,ing_int_osf
							 ,ing_cxc_osf
							 ,ing_rp_osf
							 ,ing_int_con
							 ,ing_cxc_con
							 ,ing_rp_con
							 ,total_ingreso
							 ,utilidad
							 ,margen
							 ,order_id
							 )
					  VALUES
							(
							nupano
						   ,nupmes
						   ,i.product_id
						   ,i.cate -- xxxxxx
						   ,i.tipo
						   ,i.acta
						   ,i.factura
						   ,i.fecha
						   ,i.contratista
						   ,i.nombre
						   ,i.titr
						   ,i.cuenta
						   ,i.nom_cuenta
						   ,i.clctclco
						   ,i.actividad
						   ,i.concept
						   ,i.costo
						   ,i.iva
						   ,I.Ing_Otro
						   ,nuvalnotas
						   ,0 --i.ing_int_mig
						   ,0 --i.ing_cxc_mig
						   ,0 --i.ing_rp_mig
						   ,0 --i.ing_int_osf
						   ,0 --i.ing_cxc_osf
						   ,0 --i.ing_rp_osf
						   ,0 --i.ing_int_con
						   ,0 --i.ing_cxc_con
						   ,0 --i.ing_rp_con
						   ,0 --i.total_ingreso
						   ,0 --i.utilidad
						   ,0 --round(i.margen,2)
						   ,I.orden --
						   );
			--
			nucantiregcom := nucantiregcom + 1;
			IF nucantiregcom >= nucontareg THEN
				COMMIT;
				nucantiregtot := nucantiregtot + nucantiregcom;
				nucantiregcom := 0;
			END IF;
			--
		END LOOP;
	ELSE
		OPEN cu_ge_costingrFRA1v2(dtfefein,dtfefefin);
		LOOP
		tyACFRA.DELETE;
		FETCH cu_ge_costingrFRA1v2 BULK COLLECT
		INTO tyACFRA LIMIT 1000;
			FOR  nuindice IN 1 .. tyACFRA.COUNT LOOP
				nuvalnotas := 0;
				BEGIN
					SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
					FROM cargos c, servsusc SC
					WHERE cargnuse   = tyACFRA(nuindice).product_id
					AND cargnuse   = sesunuse
					AND cargconc   = tyACFRA(nuindice).concept
					AND c.cargfecr BETWEEN dtfefein AND dtfefefin
					AND cargcuco >= 1
					AND cargtipr = 'P'
					AND cargsign in ('DB', 'CR')
					AND cargcaca in -- NOT IN (50,51,20,23,56,73)
							(SELECT CACACODI
							   FROM CAUSCARG
							  WHERE ',' || (SELECT casevalo
											  FROM ldci_carasewe
											 WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
					AND cargsign NOT IN ('SA','AS','PA','AP');
				EXCEPTION
					WHEN no_data_found THEN
						nuvalnotas := 0;
				END;
				-- Consulta Ingreso mes.
				nuvalingre   := 0;
				-- Insertamos registro
				INSERT INTO ldc_osf_costingr
								 (
								  nuano
								 ,numes
								 ,product_id
								 ,cate -- xxxxx
								 ,tipo
								 ,acta
								 ,factura
								 ,fecha
								 ,contratista
								 ,nombre
								 ,titr
								 ,cuenta
								 ,nom_cuenta
								 ,clasificador
								 ,actividad
								 ,concept
								 ,costo
								 ,iva
								 ,ing_otro
								 ,notas
								 ,ing_int_mig
								 ,ing_cxc_mig
								 ,ing_rp_mig
								 ,ing_int_osf
								 ,ing_cxc_osf
								 ,ing_rp_osf
								 ,ing_int_con
								 ,ing_cxc_con
								 ,ing_rp_con
								 ,total_ingreso
								 ,utilidad
								 ,margen
								 ,order_id
								 )
						  VALUES
								(
								nupano
							   ,nupmes
							   ,tyACFRA(nuindice).product_id
							   ,tyACFRA(nuindice).cate
							   ,tyACFRA(nuindice).tipo
							   ,tyACFRA(nuindice).acta
							   ,tyACFRA(nuindice).factura
							   ,tyACFRA(nuindice).fecha
							   ,tyACFRA(nuindice).contratista
							   ,tyACFRA(nuindice).nombre
							   ,tyACFRA(nuindice).titr
							   ,tyACFRA(nuindice).cuenta
							   ,tyACFRA(nuindice).nom_cuenta
							   ,tyACFRA(nuindice).clctclco
							   ,tyACFRA(nuindice).actividad
							   ,tyACFRA(nuindice).concept
							   ,tyACFRA(nuindice).costo
							   ,tyACFRA(nuindice).iva
							   ,tyACFRA(nuindice).Ing_Otro
							   ,nuvalnotas
							   ,0 --i.ing_int_mig
							   ,0 --i.ing_cxc_mig
							   ,0 --i.ing_rp_mig
							   ,0 --i.ing_int_osf
							   ,0 --i.ing_cxc_osf
							   ,0 --i.ing_rp_osf
							   ,0 --i.ing_int_con
							   ,0 --i.ing_cxc_con
							   ,0 --i.ing_rp_con
							   ,0 --i.total_ingreso
							   ,0 --i.utilidad
							   ,0 --round(i.margen,2)
							   ,tyACFRA(nuindice).orden --
							   );
				--
				nucantiregcom := nucantiregcom + 1;
				IF nucantiregcom >= nucontareg THEN
					COMMIT;
					nucantiregtot := nucantiregtot + nucantiregcom;
					nucantiregcom := 0;
				END IF;
				--
			END LOOP;
			EXIT WHEN cu_ge_costingrFRA1v2%NOTFOUND;
		END LOOP;
	END IF;

	pkg_Correo.prcEnviaCorreo(isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza Costo sin Factura');
	IF sbModifica='N' THEN
		FOR i IN cu_ge_costingrSINF1(dtfefein,dtfefefin) LOOP

			-- Consultamos las notas
			nuvalnotas := 0;
			BEGIN
				SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
				 FROM cargos c, servsusc SC
				WHERE cargnuse   = i.product_id
				  AND cargnuse   = sesunuse
				  AND cargconc   = i.concept
				  AND c.cargfecr BETWEEN dtfefein AND dtfefefin
				  AND cargcuco >= 1
				  AND cargtipr = 'P'
				  AND cargsign in ('DB', 'CR')
				  AND cargcaca IN --NOT IN (50,51,20,23,56,73)
								  (SELECT CACACODI
									 FROM CAUSCARG
									WHERE ',' || (SELECT casevalo
													FROM ldci_carasewe
												   WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
				  AND cargsign NOT IN ('SA','AS','PA','AP');
			EXCEPTION
				WHEN no_data_found THEN
					nuvalnotas := 0;
			END;
			-- Consulta Ingreso mes.
			nuvalingre   := 0;

			-- Insertamos registro
			INSERT INTO ldc_osf_costingr
									 (
									  nuano
									 ,numes
						  --           ,estado
									 ,product_id
									 ,cate -- xxxxx
									 ,tipo
									 ,acta
									 ,factura
									 ,fecha
									 ,contratista
									 ,nombre
									 ,titr
									 ,cuenta
									 ,nom_cuenta
									 ,clasificador
									 ,actividad
									 ,concept
									 ,costo
									 ,iva
									 ,ing_otro
									 ,notas
									 ,ing_int_mig
									 ,ing_cxc_mig
									 ,ing_rp_mig
									 ,ing_int_osf
									 ,ing_cxc_osf
									 ,ing_rp_osf
									 ,ing_int_con
									 ,ing_cxc_con
									 ,ing_rp_con
									 ,total_ingreso
									 ,utilidad
									 ,margen
									 ,order_id
									 )
							  VALUES
									(
									nupano
								   ,nupmes
								   ,i.product_id
								   ,i.cate -- xxxxxx
								   ,i.tipo
								   ,i.acta
								   ,i.factura
								   ,i.fecha
								   ,i.contratista
								   ,i.nombre
								   ,i.titr
								   ,i.cuenta
								   ,i.nom_cuenta
								   ,i.clctclco
								   ,i.actividad
								   ,i.concept
								   ,i.costo
								   ,i.iva
								   ,I.Ing_Otro
								   ,nuvalnotas
								   ,0 --i.ing_int_mig
								   ,0 --i.ing_cxc_mig
								   ,0 --i.ing_rp_mig
								   ,0 --i.ing_int_osf
								   ,0 --i.ing_cxc_osf
								   ,0 --i.ing_rp_osf
								   ,0 --i.ing_int_con
								   ,0 --i.ing_cxc_con
								   ,0 --i.ing_rp_con
								   ,0 --i.total_ingreso
								   ,0 --i.utilidad
								   ,0 --round(i.margen,2)
								   ,I.orden
								   );
			--
			nucantiregcom := nucantiregcom + 1;
			IF nucantiregcom >= nucontareg THEN
				COMMIT;
				nucantiregtot := nucantiregtot + nucantiregcom;
				nucantiregcom := 0;
			END IF;
			--
		END LOOP;
	ELSE
		OPEN cu_ge_costingrSINF1V2(dtfefein,dtfefefin);
		LOOP
		tyACFRA.DELETE;
		FETCH cu_ge_costingrSINF1V2 BULK COLLECT
		INTO tyACFRA LIMIT 1000;
			FOR  nuindice IN 1 .. tyACFRA.COUNT LOOP

				-- Consultamos las notas
				nuvalnotas := 0;
				BEGIN
					SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
					 FROM cargos c, servsusc SC
					WHERE cargnuse   = tyACFRA(nuindice).product_id
					  AND cargnuse   = sesunuse
					  AND cargconc   = tyACFRA(nuindice).concept
					  AND c.cargfecr BETWEEN dtfefein AND dtfefefin
					  AND cargcuco >= 1
					  AND cargtipr = 'P'
					  AND cargsign in ('DB', 'CR')
					  AND cargcaca IN --NOT IN (50,51,20,23,56,73)
									  (SELECT CACACODI
										 FROM CAUSCARG
										WHERE ',' || (SELECT casevalo
														FROM ldci_carasewe
													   WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
					  AND cargsign NOT IN ('SA','AS','PA','AP');
				EXCEPTION
					WHEN no_data_found THEN
						nuvalnotas := 0;
				END;
				-- Consulta Ingreso mes.
				nuvalingre   := 0;
				INSERT INTO ldc_osf_costingr
										 (
										  nuano
										 ,numes
										 ,product_id
										 ,cate -- xxxxx
										 ,tipo
										 ,acta
										 ,factura
										 ,fecha
										 ,contratista
										 ,nombre
										 ,titr
										 ,cuenta
										 ,nom_cuenta
										 ,clasificador
										 ,actividad
										 ,concept
										 ,costo
										 ,iva
										 ,ing_otro
										 ,notas
										 ,ing_int_mig
										 ,ing_cxc_mig
										 ,ing_rp_mig
										 ,ing_int_osf
										 ,ing_cxc_osf
										 ,ing_rp_osf
										 ,ing_int_con
										 ,ing_cxc_con
										 ,ing_rp_con
										 ,total_ingreso
										 ,utilidad
										 ,margen
										 ,order_id
										 )
								  VALUES
										(
										nupano
									   ,nupmes
									   ,tyACFRA(nuindice).product_id
									   ,tyACFRA(nuindice).cate -- xxxxxx
									   ,tyACFRA(nuindice).tipo
									   ,tyACFRA(nuindice).acta
									   ,tyACFRA(nuindice).factura
									   ,tyACFRA(nuindice).fecha
									   ,tyACFRA(nuindice).contratista
									   ,tyACFRA(nuindice).nombre
									   ,tyACFRA(nuindice).titr
									   ,tyACFRA(nuindice).cuenta
									   ,tyACFRA(nuindice).nom_cuenta
									   ,tyACFRA(nuindice).clctclco
									   ,tyACFRA(nuindice).actividad
									   ,tyACFRA(nuindice).concept
									   ,tyACFRA(nuindice).costo
									   ,tyACFRA(nuindice).iva
									   ,tyACFRA(nuindice).Ing_Otro
									   ,nuvalnotas
									   ,0 --i.ing_int_mig
									   ,0 --i.ing_cxc_mig
									   ,0 --i.ing_rp_mig
									   ,0 --i.ing_int_osf
									   ,0 --i.ing_cxc_osf
									   ,0 --i.ing_rp_osf
									   ,0 --i.ing_int_con
									   ,0 --i.ing_cxc_con
									   ,0 --i.ing_rp_con
									   ,0 --i.total_ingreso
									   ,0 --i.utilidad
									   ,0 --round(i.margen,2)
									   ,tyACFRA(nuindice).orden
									   );
				--
				nucantiregcom := nucantiregcom + 1;
				IF nucantiregcom >= nucontareg THEN
					COMMIT;
					nucantiregtot := nucantiregtot + nucantiregcom;
					nucantiregcom := 0;
				END IF;
				--
			END LOOP;
			EXIT WHEN cu_ge_costingrSINF1V2%NOTFOUND;
		END LOOP;
	END IF;

	pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza Costo OT sin Acta');

	IF sbModifica='N' then

		FOR i IN cu_ge_costingrSINA1(dtfefein,dtfefefin) LOOP

			-- Consultamos las notas
			nuvalnotas := 0;
			BEGIN
				SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
				 FROM cargos c, servsusc SC
				WHERE cargnuse   = i.product_id
				  AND cargnuse   = sesunuse
				  AND cargconc   = i.concept
				  AND c.cargfecr BETWEEN dtfefein AND dtfefefin
				  AND cargcuco >= 1
				  AND cargtipr = 'P'
				  AND cargsign in ('DB', 'CR')
				  AND cargcaca IN --NOT IN (50,51,20,23,56,73)
								  (SELECT CACACODI
									 FROM CAUSCARG
									WHERE ',' || (SELECT casevalo
													FROM ldci_carasewe
												   WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
				  AND cargsign NOT IN ('SA','AS','PA','AP');
			EXCEPTION
				WHEN no_data_found THEN
					nuvalnotas := 0;
			END;

			-- Consulta Ingreso mes.
			nuvalingre   := 0;

			-- Insertamos registro
			INSERT INTO ldc_osf_costingr
									 (
									  nuano
									 ,numes
						  --           ,estado
									 ,product_id
									 ,cate -- xxxxx
									 ,tipo
									 ,acta
									 ,factura
									 ,fecha
									 ,contratista
									 ,nombre
									 ,titr
									 ,cuenta
									 ,nom_cuenta
									 ,clasificador
									 ,actividad
									 ,concept
									 ,costo
									 ,iva
									 ,ing_otro
									 ,notas
									 ,ing_int_mig
									 ,ing_cxc_mig
									 ,ing_rp_mig
									 ,ing_int_osf
									 ,ing_cxc_osf
									 ,ing_rp_osf
									 ,ing_int_con
									 ,ing_cxc_con
									 ,ing_rp_con
									 ,total_ingreso
									 ,utilidad
									 ,margen
									 ,order_id
									 )
							  VALUES
									(
									nupano
								   ,nupmes
								   ,i.product_id
								   ,i.cate -- xxxxxx
								   ,i.tipo
								   ,i.acta
								   ,i.factura
								   ,i.fecha
								   ,i.contratista
								   ,i.nombre
								   ,i.titr
								   ,i.cuenta
								   ,i.nom_cuenta
								   ,i.clctclco
								   ,i.actividad
								   ,i.concept
								   ,i.costo
								   ,i.iva
								   ,decode(i.Ingreso,0,i.ing_otro,i.Ingreso)
								   ,nuvalnotas
								   ,0 --i.ing_int_mig
								   ,0 --i.ing_cxc_mig
								   ,0 --i.ing_rp_mig
								   ,0 --i.ing_int_osf
								   ,0 --i.ing_cxc_osf
								   ,0 --i.ing_rp_osf
								   ,0 --i.ing_int_con
								   ,0 --i.ing_cxc_con
								   ,0 --i.ing_rp_con
								   ,0 --i.total_ingreso
								   ,0 --i.utilidad
								   ,0 --round(i.margen,2)
								   ,I.orden
								   );
			--
			nucantiregcom := nucantiregcom + 1;
			IF nucantiregcom >= nucontareg THEN
				COMMIT;
				nucantiregtot := nucantiregtot + nucantiregcom;
				nucantiregcom := 0;
			END IF;
		 --
		END LOOP;
	ELSE
		OPEN cu_ge_costingrSINA1V2(dtfefein,dtfefefin);
		LOOP
		tySINAC.DELETE;
		FETCH cu_ge_costingrSINA1V2 BULK COLLECT
		INTO tySINAC LIMIT 1000;
			FOR  nuindice IN 1 .. tySINAC.COUNT LOOP

				-- Consultamos las notas
				nuvalnotas := 0;
				BEGIN
					SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
					 FROM cargos c, servsusc SC
					WHERE cargnuse   = tySINAC(nuindice).product_id
					  AND cargnuse   = sesunuse
					  AND cargconc   = tySINAC(nuindice).concept
					  AND c.cargfecr BETWEEN dtfefein AND dtfefefin
					  AND cargcuco >= 1
					  AND cargtipr = 'P'
					  AND cargsign in ('DB', 'CR')
					  AND cargcaca IN --NOT IN (50,51,20,23,56,73)
									  (SELECT CACACODI
										 FROM CAUSCARG
										WHERE ',' || (SELECT casevalo
														FROM ldci_carasewe
													   WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
					  AND cargsign NOT IN ('SA','AS','PA','AP');
				EXCEPTION
					WHEN no_data_found THEN
						nuvalnotas := 0;
				END;


				-- Consulta Ingreso mes.
				nuvalingre   := 0;

				-- Insertamos registro
				INSERT INTO ldc_osf_costingr
										 (
										  nuano
										 ,numes
							  --           ,estado
										 ,product_id
										 ,cate -- xxxxx
										 ,tipo
										 ,acta
										 ,factura
										 ,fecha
										 ,contratista
										 ,nombre
										 ,titr
										 ,cuenta
										 ,nom_cuenta
										 ,clasificador
										 ,actividad
										 ,concept
										 ,costo
										 ,iva
										 ,ing_otro
										 ,notas
										 ,ing_int_mig
										 ,ing_cxc_mig
										 ,ing_rp_mig
										 ,ing_int_osf
										 ,ing_cxc_osf
										 ,ing_rp_osf
										 ,ing_int_con
										 ,ing_cxc_con
										 ,ing_rp_con
										 ,total_ingreso
										 ,utilidad
										 ,margen
										 ,order_id
										 )
								  VALUES
										(
										nupano
									   ,nupmes
									   ,tySINAC(nuindice).product_id
									   ,tySINAC(nuindice).cate -- xxxxxx
									   ,tySINAC(nuindice).tipo
									   ,tySINAC(nuindice).acta
									   ,tySINAC(nuindice).factura
									   ,tySINAC(nuindice).fecha
									   ,tySINAC(nuindice).contratista
									   ,tySINAC(nuindice).nombre
									   ,tySINAC(nuindice).titr
									   ,tySINAC(nuindice).cuenta
									   ,tySINAC(nuindice).nom_cuenta
									   ,tySINAC(nuindice).clctclco
									   ,tySINAC(nuindice).actividad
									   ,tySINAC(nuindice).concept
									   ,tySINAC(nuindice).costo
									   ,tySINAC(nuindice).iva
									   ,tySINAC(nuindice).Ingreso
									   ,nuvalnotas
									   ,0 --i.ing_int_mig
									   ,0 --i.ing_cxc_mig
									   ,0 --i.ing_rp_mig
									   ,0 --i.ing_int_osf
									   ,0 --i.ing_cxc_osf
									   ,0 --i.ing_rp_osf
									   ,0 --i.ing_int_con
									   ,0 --i.ing_cxc_con
									   ,0 --i.ing_rp_con
									   ,0 --i.total_ingreso
									   ,0 --i.utilidad
									   ,0 --round(i.margen,2)
									   ,tySINAC(nuindice).orden
									   );
				--
				nucantiregcom := nucantiregcom + 1;
				IF nucantiregcom >= nucontareg THEN
					COMMIT;
					nucantiregtot := nucantiregtot + nucantiregcom;
					nucantiregcom := 0;
				END IF;
			END LOOP;
			EXIT WHEN cu_ge_costingrSINA1V2%NOTFOUND;
		END LOOP;
	END IF;
	--
	--
	pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza Costo Novedades sin Acta');
	IF sbModifica='N' THEN
		FOR i IN cu_ge_costingrSINA2(dtfefein,dtfefefin) LOOP

			-- Consultamos las notas
			nuvalnotas := 0;
			BEGIN
				SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
				 FROM cargos c, servsusc SC
				WHERE cargnuse   = i.product_id
				  AND cargnuse   = sesunuse
				  AND cargconc   = i.concept
				  AND c.cargfecr BETWEEN dtfefein AND dtfefefin
				  AND cargcuco >= 1
				  AND cargtipr = 'P'
				  AND cargsign in ('DB', 'CR')
				  AND cargcaca IN --NOT IN (50,51,20,23,56,73)
								  (SELECT CACACODI
									 FROM CAUSCARG
									WHERE ',' || (SELECT casevalo
													FROM ldci_carasewe
												   WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
				  AND cargsign NOT IN ('SA','AS','PA','AP');
			EXCEPTION
				WHEN no_data_found THEN
					nuvalnotas := 0;
			END;


			-- Consulta Ingreso mes.
			nuvalingre   := 0;

			-- Insertamos registro
			INSERT INTO ldc_osf_costingr
									 (
									  nuano
									 ,numes
						  --           ,estado
									 ,product_id
									 ,cate -- xxxxx
									 ,tipo
									 ,acta
									 ,factura
									 ,fecha
									 ,contratista
									 ,nombre
									 ,titr
									 ,cuenta
									 ,nom_cuenta
									 ,clasificador
									 ,actividad
									 ,concept
									 ,costo
									 ,iva
									 ,ing_otro
									 ,notas
									 ,ing_int_mig
									 ,ing_cxc_mig
									 ,ing_rp_mig
									 ,ing_int_osf
									 ,ing_cxc_osf
									 ,ing_rp_osf
									 ,ing_int_con
									 ,ing_cxc_con
									 ,ing_rp_con
									 ,total_ingreso
									 ,utilidad
									 ,margen
									 ,order_id
									 )
							  VALUES
									(
									nupano
								   ,nupmes
								   ,i.product_id
								   ,i.cate -- xxxxxx
								   ,i.tipo
								   ,i.acta
								   ,i.factura
								   ,i.fecha
								   ,i.contratista
								   ,i.nombre
								   ,i.titr
								   ,i.cuenta
								   ,i.nom_cuenta
								   ,i.clctclco
								   ,i.actividad
								   ,i.concept
								   ,i.costo
								   ,i.iva
								   ,decode(i.Ingreso,0,i.ing_otro,i.Ingreso)
								   ,nuvalnotas
								   ,0 --i.ing_int_mig
								   ,0 --i.ing_cxc_mig
								   ,0 --i.ing_rp_mig
								   ,0 --i.ing_int_osf
								   ,0 --i.ing_cxc_osf
								   ,0 --i.ing_rp_osf
								   ,0 --i.ing_int_con
								   ,0 --i.ing_cxc_con
								   ,0 --i.ing_rp_con
								   ,0 --i.total_ingreso
								   ,0 --i.utilidad
								   ,0 --round(i.margen,2)
								   ,I.orden
								   );
			--
			nucantiregcom := nucantiregcom + 1;
			IF nucantiregcom >= nucontareg THEN
				COMMIT;
				nucantiregtot := nucantiregtot + nucantiregcom;
				nucantiregcom := 0;
			END IF;
			--
		END LOOP;
	ELSE
		OPEN cu_ge_costingrSINA2V2(dtfefein,dtfefefin);
		LOOP
		tyNOVSINAC.DELETE;
		FETCH cu_ge_costingrSINA2V2 BULK COLLECT
		INTO tyNOVSINAC LIMIT 1000;
			FOR  nuindice IN 1 .. tyNOVSINAC.COUNT LOOP


				-- Consultamos las notas
				nuvalnotas := 0;
				BEGIN
					SELECT nvl(SUM(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)),0) INTO nuvalnotas
					 FROM cargos c, servsusc SC
					WHERE cargnuse   = tyNOVSINAC(nuindice).product_id
					  AND cargnuse   = sesunuse
					  AND cargconc   = tyNOVSINAC(nuindice).concept
					  AND c.cargfecr BETWEEN dtfefein AND dtfefefin
					  AND cargcuco >= 1
					  AND cargtipr = 'P'
					  AND cargsign in ('DB', 'CR')
					  AND cargcaca IN --NOT IN (50,51,20,23,56,73)
									  (SELECT CACACODI
										 FROM CAUSCARG
										WHERE ',' || (SELECT casevalo
														FROM ldci_carasewe
													   WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
					  AND cargsign NOT IN ('SA','AS','PA','AP');
				EXCEPTION
					WHEN no_data_found THEN
						nuvalnotas := 0;
				END;


				-- Consulta Ingreso mes.
				nuvalingre   := 0;

				-- Insertamos registro
				INSERT INTO ldc_osf_costingr
										 (
										  nuano
										 ,numes
							  --           ,estado
										 ,product_id
										 ,cate -- xxxxx
										 ,tipo
										 ,acta
										 ,factura
										 ,fecha
										 ,contratista
										 ,nombre
										 ,titr
										 ,cuenta
										 ,nom_cuenta
										 ,clasificador
										 ,actividad
										 ,concept
										 ,costo
										 ,iva
										 ,ing_otro
										 ,notas
										 ,ing_int_mig
										 ,ing_cxc_mig
										 ,ing_rp_mig
										 ,ing_int_osf
										 ,ing_cxc_osf
										 ,ing_rp_osf
										 ,ing_int_con
										 ,ing_cxc_con
										 ,ing_rp_con
										 ,total_ingreso
										 ,utilidad
										 ,margen
										 ,order_id
										 )
								  VALUES
										(
										nupano
									   ,nupmes
									   ,tyNOVSINAC(nuindice).product_id
									   ,tyNOVSINAC(nuindice).cate -- xxxxxx
									   ,tyNOVSINAC(nuindice).tipo
									   ,tyNOVSINAC(nuindice).acta
									   ,tyNOVSINAC(nuindice).factura
									   ,tyNOVSINAC(nuindice).fecha
									   ,tyNOVSINAC(nuindice).contratista
									   ,tyNOVSINAC(nuindice).nombre
									   ,tyNOVSINAC(nuindice).titr
									   ,tyNOVSINAC(nuindice).cuenta
									   ,tyNOVSINAC(nuindice).nom_cuenta
									   ,tyNOVSINAC(nuindice).clctclco
									   ,tyNOVSINAC(nuindice).actividad
									   ,tyNOVSINAC(nuindice).concept
									   ,tyNOVSINAC(nuindice).costo
									   ,tyNOVSINAC(nuindice).iva
									   ,tyNOVSINAC(nuindice).Ingreso
									   ,nuvalnotas
									   ,0 --i.ing_int_mig
									   ,0 --i.ing_cxc_mig
									   ,0 --i.ing_rp_mig
									   ,0 --i.ing_int_osf
									   ,0 --i.ing_cxc_osf
									   ,0 --i.ing_rp_osf
									   ,0 --i.ing_int_con
									   ,0 --i.ing_cxc_con
									   ,0 --i.ing_rp_con
									   ,0 --i.total_ingreso
									   ,0 --i.utilidad
									   ,0 --round(i.margen,2)
									   ,tyNOVSINAC(nuindice).orden
									   );
				--
				nucantiregcom := nucantiregcom + 1;
				IF nucantiregcom >= nucontareg THEN
					COMMIT;
					nucantiregtot := nucantiregtot + nucantiregcom;
					nucantiregcom := 0;
				END IF;
				--
			END LOOP;
			EXIT WHEN cu_ge_costingrSINA2V2%NOTFOUND;
		END LOOP;
	END IF;

	IF sbModifica='S' THEN
		pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza INGRESO ');
		OPEN cuIngCosto(dtfefein,dtfefefin);
			LOOP
				tyIngreso.DELETE;
				FETCH cuIngCosto BULK COLLECT
				INTO tyIngreso LIMIT 1000;
					FOR  nuindice IN 1 .. tyIngreso.COUNT LOOP
						UPDATE LDC_OSF_COSTINGR C SET ing_otro=DECODE(nvl(tyIngreso(nuindice).ingreso,0),0,nvl(tyIngreso(nuindice).ing_otro,0),nvl(tyIngreso(nuindice).ingreso,0))
						  WHERE C.NUANO=nupano
						    AND C.NUMES=nupmes
							AND C.PRODUCT_ID=tyIngreso(nuindice).PRODUCT_ID
							AND C.ORDER_ID=tyIngreso(nuindice).ORDER_ID;
					END LOOP;
					COMMIT;
				EXIT WHEN cuIngCosto%NOTFOUND;
			END LOOP;
	END IF;

	IF sbIvaFActu='S' THEN
		pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza IVA FACTURADO ');
		OPEN cu_ge_IVAFACTURADO(dtfefein,dtfefefin,sbCuentaIVA);
			LOOP
				tyIVAFACT.DELETE;
				FETCH cu_ge_IVAFACTURADO BULK COLLECT
				INTO tyIVAFACT LIMIT 1000;
					FOR  nuindice IN 1 .. tyIVAFACT.COUNT LOOP
						INSERT INTO ldc_osf_costingr
									 (
									  nuano
									 ,numes
						  --           ,estado
									 ,product_id
									 ,cate -- xxxxx
									 ,tipo
									 ,acta
									 ,factura
									 ,fecha
									 ,contratista
									 ,nombre
									 ,titr
									 ,cuenta
									 ,nom_cuenta
									 ,clasificador
									 ,actividad
									 ,concept
									 ,costo
									 ,iva
									 ,ing_otro
									 ,notas
									 ,ing_int_mig
									 ,ing_cxc_mig
									 ,ing_rp_mig
									 ,ing_int_osf
									 ,ing_cxc_osf
									 ,ing_rp_osf
									 ,ing_int_con
									 ,ing_cxc_con
									 ,ing_rp_con
									 ,total_ingreso
									 ,utilidad
									 ,margen
									 ,order_id
									 )
							  VALUES
									(
									nupano
								   ,nupmes
								   ,tyIVAFACT(nuindice).product_id
								   ,tyIVAFACT(nuindice).cate -- xxxxxx
								   ,tyIVAFACT(nuindice).tipo
								   ,tyIVAFACT(nuindice).acta
								   ,tyIVAFACT(nuindice).factura
								   ,tyIVAFACT(nuindice).fecha
								   ,tyIVAFACT(nuindice).contratista
								   ,tyIVAFACT(nuindice).nombre
								   ,tyIVAFACT(nuindice).titr
								   ,tyIVAFACT(nuindice).cuenta
								   ,tyIVAFACT(nuindice).nom_cuenta
								   ,tyIVAFACT(nuindice).clctclco
								   ,tyIVAFACT(nuindice).actividad
								   ,tyIVAFACT(nuindice).concept
								   ,tyIVAFACT(nuindice).costo
								   ,tyIVAFACT(nuindice).iva
								   ,0
								   ,0
								   ,0 --i.ing_int_mig
								   ,0 --i.ing_cxc_mig
								   ,0 --i.ing_rp_mig
								   ,0 --i.ing_int_osf
								   ,0 --i.ing_cxc_osf
								   ,0 --i.ing_rp_osf
								   ,0 --i.ing_int_con
								   ,0 --i.ing_cxc_con
								   ,0 --i.ing_rp_con
								   ,0 --i.total_ingreso
								   ,0 --i.utilidad
								   ,0 --round(i.margen,2)
								   ,tyIVAFACT(nuindice).orden
								   );
					END LOOP;
					COMMIT;
				EXIT WHEN cu_ge_IVAFACTURADO%NOTFOUND;
			END LOOP;
	END IF;

 COMMIT;
  --
  -- Fin Costos -----------------------------------------------
  --

  -- Ingresos Servicios cumplidos Migrados, OSF y Constructoras
  nucantiregcom := 0;
  --
  pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza cu_ge_ingreso');
  FOR j IN cu_ge_ingreso(dtfefein, dtfefefin) LOOP
      --
      nuvalnotas := 0;
      BEGIN
       SELECT nvl(SUM(decode(cargsign,'DB',cargvalo,'AS',cargvalo,'TS',cargvalo,'DV',cargvalo,cargvalo*-1)),0)
              INTO nuvalnotas
         FROM cargos c, servsusc SC
        WHERE cargnuse   = j.invmsesu
          AND cargnuse   = sesunuse
          AND cargconc   = j.conc
          AND c.cargfecr BETWEEN dtfefein AND dtfefefin
          AND cargcuco >= 1
          AND cargtipr = 'P'
          AND cargsign in ('DB', 'CR')
          AND cargcaca IN  --NOT IN (50,51,20,23,56,73)
                          (SELECT CACACODI
                             FROM CAUSCARG
                            WHERE ',' || (SELECT casevalo
                                            FROM ldci_carasewe
                                           WHERE casecodi = 'CACA_INGRESO_COSTO') || ',' LIKE '%,' || CACACODI || ',%')
          AND cargsign NOT IN ('SA','AS','PA','AP');
      EXCEPTION
       WHEN no_data_found THEN
        nuvalnotas := 0;
      END;
      --
      open cu_va_ingreso(j.invmsesu, j.conc);
      fetch cu_va_ingreso into vasbcuin;
      If cu_va_ingreso%found then
        update ldc_osf_costingr l
           set l.notas       = l.notas + nuvalnotas,
               l.ing_int_mig = l.ing_int_mig + j.int_migrada,
               l.ing_cxc_mig = l.ing_cxc_mig + j.cxc_migrada,
               l.ing_rp_mig  = l.ing_rp_mig  + j.rp_migrada,
               L.ING_INT_CON = L.ING_INT_CON + j.int_const,
               L.ING_CXC_CON = L.ING_CXC_CON + j.cxc_const,
               l.ing_rp_con  = l.ing_rp_con  + j.rp_const,
               L.ING_INT_osf = L.ING_INT_osf + j.int_osf,
               L.ING_CXC_osf = L.ING_CXC_osf + j.cxc_osf,
               l.ing_rp_osf  = l.ing_rp_osf  + j.rp_osf
         where l.nuano = nupano
           and l.numes = nupmes
           and l.product_id = j.invmsesu
           and l.concept = j.conc
           and l.order_id = j.orden;
      --
      Elsif cu_va_ingreso%notfound then
      --
        INSERT INTO ldc_osf_costingr
                                   (
                                    nuano
                                   ,numes
                        --           ,estado
                                   ,product_id
                                   ,cate -- xxxxx
                                   ,tipo
                                   ,acta
                                   ,factura
                                   ,fecha
                                   ,contratista
                                   ,nombre
                                   ,titr
                                   ,cuenta
                                   ,nom_cuenta
                                   ,clasificador
                                   ,actividad
                                   ,concept
                                   ,costo
                                   ,iva
                                   ,ing_otro
                                   ,notas
                                   ,ing_int_mig
                                   ,ing_cxc_mig
                                   ,ing_rp_mig
                                   ,ing_int_osf
                                   ,ing_cxc_osf
                                   ,ing_rp_osf
                                   ,ing_int_con
                                   ,ing_cxc_con
                                   ,ing_rp_con
                                   ,total_ingreso
                                   ,utilidad
                                   ,margen
                                   ,order_id
                                   )
                            VALUES
                                  (
                                    nupano
                                   ,nupmes
                                   ,j.invmsesu
                                   ,j.sesucate-- i.cate -- xxxxxx
                                   ,'INGRESO' --'ACTA_FRA' --i.tipo
                                   ,null --i.acta
                                   ,null --i.factura
                                   ,null --i.fecha
                                   ,null --i.contratista
                                   ,null --i.nombre
                                   ,null --i.titr
                                   ,null --i.cuenta
                                   ,null --i.nom_cuenta
                                   ,j.clasitt
                                   ,null --i.actividad
                                   ,j.conc -- i.concept
                                   ,0   --i.costo
                                   ,0   --i.iva
                                   ,0   --i.ing_otro
                                   ,nuvalnotas
                                   ,j.int_migrada   --i.ing_int_mig
                                   ,j.cxc_migrada   --i.ing_cxc_mig
                                   ,j.rp_migrada    --i.ing_rp_mig
                                   ,j.int_osf       --i.ing_int_osf
                                   ,j.cxc_osf       --i.ing_cxc_osf
                                   ,j.rp_osf        --i.ing_rp_osf
                                   ,j.int_const     --i.ing_int_con
                                   ,j.cxc_const     --i.ing_cxc_con
                                   ,j.rp_const      --i.ing_rp_con
                                   ,0   --i.total_ingreso
                                   ,0   --i.utilidad
                                   ,0   --round(i.margen,2)
                                   ,j.orden
                                   );
      End if;
      --
      close cu_va_ingreso;
      --
      nucantiregcom := nucantiregcom + 1;
      IF nucantiregcom >= nucontareg THEN
          COMMIT;
          nucantiregcom := 0;
      END IF;
      --
  End Loop;
  --
  commit;
  --
  -- Fin Ingresos Serv. Cumplidos. -----------------------------------
  ---
  --
  pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Empieza cu_notas_varias');
  FOR j in cu_notas_varias(dtfefein, dtfefefin) LOOP
     --
     open cu_va_ingreso(j.cargnuse, j.cargconc);
     fetch cu_va_ingreso into vasbcuin;
     If cu_va_ingreso%found then
       update ldc_osf_costingr l
          set l.notas = l.notas + j.tot
        where l.nuano = nupano
          and l.numes = nupmes
          and l.product_id = j.cargnuse
          and l.concept = j.cargconc;
     --
     Elsif cu_va_ingreso%notfound then
     --
        INSERT INTO ldc_osf_costingr
                                   (
                                    nuano
                                   ,numes
                        --           ,estado
                                   ,product_id
                                   ,cate -- xxxxx
                                   ,tipo
                                   ,acta
                                   ,factura
                                   ,fecha
                                   ,contratista
                                   ,nombre
                                   ,titr
                                   ,cuenta
                                   ,nom_cuenta
                                   ,clasificador
                                   ,actividad
                                   ,concept
                                   ,costo
                                   ,iva
                                   ,ing_otro
                                   ,notas
                                   ,ing_int_mig
                                   ,ing_cxc_mig
                                   ,ing_rp_mig
                                   ,ing_int_osf
                                   ,ing_cxc_osf
                                   ,ing_rp_osf
                                   ,ing_int_con
                                   ,ing_cxc_con
                                   ,ing_rp_con
                                   ,total_ingreso
                                   ,utilidad
                                   ,margen
                                   )
                            VALUES
                                  (
                                    nupano
                                   ,nupmes
                                   ,j.cargnuse
                                   ,j.sesucate-- i.cate -- xxxxxx
                                   ,'NOTAS' --'ACTA_FRA' --i.tipo
                                   ,null --i.acta
                                   ,null --i.factura
                                   ,null --i.fecha
                                   ,null --i.contratista
                                   ,null --i.nombre
                                   ,null --i.titr
                                   ,null --i.cuenta
                                   ,null --i.nom_cuenta
                                   ,j.clasitt
                                   ,null --i.actividad
                                   ,j.cargconc -- i.concept
                                   ,0   --i.costo
                                   ,0   --i.iva
                                   ,0   --i.ing_otro
                                   ,j.tot
                                   ,0   --i.ing_int_mig
                                   ,0   --i.ing_cxc_mig
                                   ,0   --i.ing_rp_mig
                                   ,0   --i.ing_int_osf
                                   ,0   --i.ing_cxc_osf
                                   ,0   --i.ing_rp_osf
                                   ,0   --i.ing_int_con
                                   ,0   --i.ing_cxc_con
                                   ,0   --i.ing_rp_con
                                   ,0   --i.total_ingreso
                                   ,0   --i.utilidad
                                   ,0   --round(i.margen,2)
                                   );
      End if;
      --
      close cu_va_ingreso;
      --
      nucantiregcom := nucantiregcom + 1;
      IF nucantiregcom >= nucontareg THEN
          COMMIT;
          nucantiregcom := 0;
      END IF;
      --
  End Loop;
  --
  commit;
  -- Fin Notas Varias. -----------------------------------
  --
  pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Termino Costo Ingreso');

  nucantiregtot := nucantiregtot + nucantiregcom;
  sbmensa := 'Proceso termino Ok : se procesaron '||to_char(nucantiregtot)||' registros.';
  error := 0;
  ldc_proactualizaestaprog(nutsess, sbmensa,'LDC_LLENACOSTOINGRESOSOCIERRE','Ok.');
  ldc_proactualizaestaprog(nutsess,'Termino '||to_char(error),'LDC_PROCCOSTINGR','Ok.');
  DELETE ldc_ordenes_costo_ingreso  o where o.nuano=nupano and o.numes=nupmes;
  commit;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenacostoingresosocierre error code : '||TO_CHAR(SQLCODE)||' MENSAJE '||SQLERRM;
  error := -1;
  sbmensa := to_char(error)||' Error en LDC_PROCCOSTINGR..lineas error '||to_char(error)|| ' ' || sqlerrm;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCCOSTINGR','Termino con error.');
  pkg_Correo.prcEnviaCorreo( isbDestinatarios => sbmail, isbAsunto => 'Costo Ingreso  '||SBINSTANCIA, isbMensaje => 'Error Costo Ingreso'||sqlerrm);
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_LLENACOSTOINGRESOSOCIERRE', 'ADM_PERSON');
END;
/
