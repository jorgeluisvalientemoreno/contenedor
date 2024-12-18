CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROGENERANOVELTYCARTERA(nupaacta ge_acta.id_acta%TYPE) IS
/**************************************************************************************

   Propiedad intelectual de JM GESTIONINFORMATICA S.A.

    Unidad         : ldc_progeneranoveltycartera
    Descripcion    : Procedimiento para generar las novedades
                    de las unidades operativas de cartera.

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 28-08-2017

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    27/11/2018        F.Castro            Se cambia la fecha para hallar la tarifa vigente
                                          colocandole la fecha final del acta en el cursor
                                          cuRangos (CA-200-2296)
    19/03/2019        F.Castro            Se modifica para que se halle el a?o y mes a procesar
                                          con la fecha final del acta y no con la fecha inicial
                                          (CA-200-2499)
    02/09/2019        Antonio Benitez     Cambio 77 GLPI  se modifico el cursor curesumenliquidacion
                                          para que tambien se liquide por items
    17/10/2019        F.Castro            Cambio 211. Se modifica primera parte del cursor curesumenliquidacion
                                          para que filtre tambien por la unidad operativa que recibe por parametro.
                                          Esto porque si un acta tiene ordenes de mas de una unidad operativa se estaban
                                          duplicando las noverdades creadas
    15/02/2020       HB                   Cambio 242 Se implementa manejo de unidades operativas padre/hijas y
                                          actividades padres/hijas
	27/10/2020		 dsaltarin|			  554: Se debe tomar la activida de ofertado de cada tipo de trabajo. Ademas se
										  corrige la forma de obtener el person_id
****************************************************************************************/
---

dtfechainiacta        DATE;
dtfechafinacta        DATE;
nucantlegaliz         number;
nuactiv               or_order_activity.activity_id%type;

sbEntrega varchar2(30):='OSS_OL_0000077_5';

--554
sbEntrega554	varchar2(1);
--554

CURSOR cuordernesacta(nuparcussion ldc_uni_act_ot.nussesion%TYPE,nucurpacta ldc_uni_act_ot.nro_acta%TYPE) IS
-- se modifica cursor (Cambio 242)
  select t_unidad_operativa unidad_operativa, t_actividad actividad, t_item item, t_liquidacion liquidacion, t_zona_ofertados zona_ofertados, t_cantidad cantidad,
       (select t2.actividad_novedad_ofertados
          from ldc_uni_act_ot2 t2
         where t2.unidad_operativa = t_unidad_operativa
           and t2.actividad = t_actividad
           and t2.item = t_item
           and t2.zona_ofertados = t_zona_ofertados) actividad_novedad_ofertada
from
(select unidad_operativa t_unidad_operativa, decode(actividad_padre,null,actividad,actividad_padre) t_actividad, item t_item, liquidacion t_liquidacion, zona_ofertados t_zona_ofertados, sum(cantidad) t_cantidad
 from(
SELECT t.unidad_operativa
        ,t.actividad
        ,(select actividad_padre from ldc_act_father_act_hija where actividad_hija = t.actividad) actividad_padre
        ,t.item
        ,t.liquidacion
        ,t.zona_ofertados
        ,t.actividad_novedad_ofertados actividad_novedad_ofertada
        ,nvl(t.cantidad_item_legalizada,0) cantidad
    FROM ldc_uni_act_ot2 t
   WHERE t.nussesion = nuparcussion
     AND t.nro_acta  = nucurpacta
	 and sbEntrega554 = 'N'
     )
group by unidad_operativa, decode(actividad_padre,null,actividad,actividad_padre), item, liquidacion, zona_ofertados   )
union all
select unidad_operativa, decode(actividad_padre,null,actividad,actividad_padre) actividad, item, liquidacion, zona_ofertados, sum(cantidad) cantidad, actividad_novedad_ofertada
 from(
SELECT t.unidad_operativa
        ,t.actividad
        ,(select actividad_padre from ldc_act_father_act_hija where actividad_hija = t.actividad) actividad_padre
        ,t.item
        ,t.liquidacion
        ,t.zona_ofertados
        ,t.actividad_novedad_ofertados actividad_novedad_ofertada
        ,nvl(t.cantidad_item_legalizada,0) cantidad
    FROM ldc_uni_act_ot2 t
   WHERE t.nussesion = nuparcussion
     AND t.nro_acta  = nucurpacta
	 and sbEntrega554 = 'S'
     )
group by unidad_operativa, decode(actividad_padre,null,actividad,actividad_padre), item, liquidacion, zona_ofertados,actividad_novedad_ofertada
;

 CURSOR curangos(
                 nucuunidadoper or_operating_unit.operating_unit_id%TYPE
                ,nucuactividad  or_order_activity.activity_id%TYPE
                ,nucuitems      ge_items.items_id%TYPE
                ,nucuzonaofer   ldc_zona_ofer_cart.id_zona_oper%TYPE
                 ) IS
  SELECT lq.cantidad_inicial,lq.cantidad_final,lq.valor_liquidar
    FROM open.ldc_const_liqtarran lq
   WHERE lq.unidad_operativa                                = nucuunidadoper
     AND lq.actividad_orden                                 = nucuactividad
     AND lq.items                                           = nucuitems
     AND lq.zona_ofertados                                  = nucuzonaofer
    -- AND trunc(SYSDATE)      BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
    AND trunc(dtfechafinacta)  BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
   ORDER BY cantidad_inicial;

 cursor cuZonaOfertados (nuUnidOper or_operating_unit.operating_unit_id%type) is
   SELECT COUNT(1)
     FROM open.ldc_const_liqtarran bv
    WHERE bv.unidad_operativa = nuUnidOper
      AND bv.zona_ofertados   = -1
      AND dtfechafinacta BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige;

 CURSOR cuunidadescontra(nucuacta NUMBER) IS
  SELECT xu.unidad_operativa unit_oper,COUNT(1) cantidad
    FROM open.ge_acta ga
        ,open.ge_detalle_acta da
        ,open.ge_items i
        ,open.or_order o
        ,open.ldc_const_unoprl xu
   WHERE ga.id_acta          = nucuacta
     AND i.item_classif_id   <> 23
     AND xu.tipo_ofertado    = 2
     AND ga.id_acta          = da.id_acta
     AND da.id_items         = i.items_id
     AND da.id_orden         = o.order_id
     AND o.operating_unit_id = xu.unidad_operativa
   GROUP BY xu.unidad_operativa;

nuvalordescontar      ldc_const_liqtarran.valor_liquidar%TYPE;
nuvalordescontarxcant ldc_const_liqtarran.valor_liquidar%TYPE;
nunovedadgenera       ldc_const_liqtarran.novedad_generar%TYPE;
nureg                 NUMBER(2);
eerror                EXCEPTION;
nuorderid             or_order.order_id%TYPE DEFAULT NULL;
nupersona             ge_person.person_id%TYPE;
nuidenregi            ldc_const_liqtarran.iden_reg%TYPE;
nuccano               NUMBER(4);
nuccmes               NUMBER(2);
nusession             NUMBER;
sbuser                VARCHAR2(30);
nucontanov            NUMBER(10) DEFAULT 0;
sbmensaje             VARCHAR2(1000);
nuvalfinal            ldc_const_liqtarran.cantidad_final%TYPE;
nucontarang           NUMBER(8);
nucontarangmenos1     NUMBER(8);
nuvarunidad           or_operating_unit.operating_unit_id%TYPE;
nusw                  NUMBER(1) DEFAULT 0;
sbcompletobser        VARCHAR2(100);
nucantidadnovgen      NUMBER(8) DEFAULT 0;
nutotalvalornov       NUMBER(15,2) DEFAULT 0;
nucantidad            NUMBER(8);
swencontro            NUMBER(2);
nuvaanoper            NUMBER(4);
nuvamesper            NUMBER(2);
nucontratoacta        ge_acta.id_contrato%TYPE;
nudireccgene          ab_address.address_id%TYPE;
nulocalidaddirgen     ab_address.geograp_location_id%TYPE;

nuZonaOfertados       ldc_const_liqtarran.zona_ofertados%type;



-----------------------------------------------------------------------------------------------
-- Cambio 242
FUNCTION ldc_getactividadPadre (nuActHija in ldc_act_father_act_hija.actividad_hija%type) return number is

cursor cuGetActPadre is
 select actividad_padre
  from ldc_act_father_act_hija
where actividad_hija = nuActHija;

nuActPadre ldc_act_father_act_hija.actividad_padre%type;

begin
 open cuGetActPadre;
 fetch cuGetActPadre into nuActPadre;
 if cuGetActPadre%notfound then
   nuActPadre := nuActHija;
 end if;
 close cuGetActPadre;

 return (nuActPadre);
exception when others then
  return (nuActHija);
end;

-----------------------------------------------------------------------------------------------
FUNCTION ldc_getUnidPadre (nuUnidHija in ldc_unid_oper_hija_mod_tar.unidad_operativa_hija%type) return number is
-- Cambio 242
cursor cuGetUnidPadre is
 select uh.unidad_operativa_padre
  from ldc_unid_oper_hija_mod_tar uh
where uh.unidad_operativa_hija = nuUnidHija;

nuUnidPadre ldc_unid_oper_hija_mod_tar.unidad_operativa_padre%type;

begin
 open cuGetUnidPadre;
 fetch cuGetUnidPadre into nuUnidPadre;
 if cuGetUnidPadre%notfound then
   nuUnidPadre := nuUnidHija;
 end if;
 close cuGetUnidPadre;

 return (nuUnidPadre);
exception when others then
  return (nuUnidHija);
end;
-----------------------------------------------------------------------------------------------
PROCEDURE ldcprollenaldcuniactot(
                                 nuparacta      ge_acta.id_acta%TYPE
                                ,nuparano       number
                                ,nuparmes       number
                                ,dtpasfechaacta DATE
                                ,nuparsesion    ldc_uni_act_ot.nussesion%TYPE) IS

/* Se crea procedimiento  para hallar cantidades legalizadas por unidad operativa, activiad y zona (Cambio 242)           */

 CURSOR cuordenesgenerarnovedadact(nucurtacta ge_acta.id_acta%TYPE) IS
  select operating_unit_id unidad_operativa, actividad, nuitemss, task_type_id, actividad_novedad_ofertados,
       liquidacion, id_zona_oper, sum(cantidad_legalizada) cantidad_legalizada
from (
SELECT ot.operating_unit_id
       ,ot.order_id                      orden
       ,ot.task_type_id
       ,(select cx.actividad_novedad_ofertados from open.ldc_tipo_trab_x_nov_ofertados cx where cx.tipo_trabajo = ot.task_type_id) actividad_novedad_ofertados
       ,oa.activity_id                   actividad
       ,-1                               nuitemss
       ,iu.liquidacion                   liquidacion

       ,CASE WHEN (
                          SELECT COUNT(1)
                            FROM open.ldc_const_liqtarran bv
                           WHERE bv.unidad_operativa = ot.operating_unit_id
                             AND bv.zona_ofertados   = -1
                             AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
                -1
               ELSE
                zo.id_zona_oper
               END id_zona_oper

       ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ct_order_certifica oc
        ,open.ldc_const_unoprl xu
        ,open.ab_address ab
        ,open.ldc_zona_loc_ofer_cart zo
   WHERE oc.certificate_id    = nuparacta
     AND oi.value            > 0
     AND iu.liquidacion       = 'A'
     AND xu.tipo_ofertado     = 2
     AND ot.order_id          = oc.order_id
     AND ot.order_id          = oa.order_id
     AND oa.order_activity_id = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id          = oi.order_id
     AND ot.operating_unit_id = iu.unidad_operativa
     AND oa.activity_id       = iu.actividad
     AND oi.items_id          = decode(iu.item,-1,oi.items_id,iu.item)
     AND ot.operating_unit_id = xu.unidad_operativa
     AND ot.external_address_id  = ab.address_id
     AND ab.geograp_location_id  = zo.localidad
   GROUP BY ot.operating_unit_id
           ,ot.order_id
           ,ot.task_type_id
           ,oa.activity_id
           ,oi.items_id
           ,iu.liquidacion
           ,zo.id_zona_oper

  UNION ALL

  SELECT ot.operating_unit_id
        ,ot.order_id orden
        ,ot.task_type_id
        ,(select cx.actividad_novedad_ofertados from open.ldc_tipo_trab_x_nov_ofertados cx where cx.tipo_trabajo = ot.task_type_id) actividad_novedad_ofertados
        ,oa.activity_id actividad
       , oi.items_id nuitemss
       ,iu.liquidacion

        ,CASE WHEN (
                          SELECT COUNT(1)
                            FROM open.ldc_const_liqtarran bv
                           WHERE bv.unidad_operativa = ot.operating_unit_id
                             AND bv.zona_ofertados   = -1
                             AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                          ) >= 1 THEN
                -1
               ELSE
                zo.id_zona_oper
               END id_zona_oper

        ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ct_order_certifica oc
        ,open.ldc_const_unoprl xu
        ,open.ab_address ab
        ,open.ldc_zona_loc_ofer_cart zo
   WHERE oc.certificate_id    = nuparacta
     AND oi.value             > 0
     AND iu.liquidacion       = 'I'
     AND xu.tipo_ofertado     = 2
     AND iu.actividad         = -1
     AND ot.order_id          = oc.order_id
     AND ot.order_id          = oa.order_id
     AND oa.order_activity_id = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id          = oi.order_id
     AND ot.operating_unit_id = iu.unidad_operativa
     AND oa.activity_id       = decode(iu.actividad,-1,oa.activity_id,iu.actividad)
     AND oi.items_id          = iu.item
     AND ot.operating_unit_id = xu.unidad_operativa
     AND ot.external_address_id  = ab.address_id
     AND ab.geograp_location_id  = zo.localidad
   GROUP BY ot.operating_unit_id
           ,ot.order_id
           ,ot.task_type_id
           ,oa.activity_id
           ,oi.items_id
           ,iu.liquidacion
           ,zo.id_zona_oper

UNION ALL

SELECT  unidad_operativa operating_unit_id
        ,orden
        ,task_type_id
        ,actividad_novedad_ofertados
        ,actividad
        ,nuitemss
        ,liquidacion
        ,zona_ofertado id_zona_oper
        ,nvl(SUM(cantidad_legalizada),0) cantidad_legalizada

          FROM(
               SELECT orden
                     ,task_type_id
                     ,unidad_operativa
                     ,CASE WHEN actividad IS NULL THEN
                       actividad_
                      ELSE
                       actividad
                      END actividad
                     ,actividad_novedad_ofertados
                     ,nuitemss
                     ,liquidacion
                     ,zona_ofertado
                     ,cantidad_legalizada

                 FROM(
                      SELECT sca.orden
                            ,sca.tipo_rabajo task_type_id
                            ,sca.unidad_operativa
                            ,sca.actividad_
                            ,actividad_novedad_ofertados
                            ,-1                   nuitemss
                            ,iu.liquidacion       liquidacion
                            ,CASE WHEN (
                                          SELECT COUNT(1)
                                            FROM open.ldc_const_liqtarran bv
                                           WHERE bv.unidad_operativa = sca.unidad_operativa
                                             AND bv.zona_ofertados = -1
                                             AND trunc(dtpasfechaacta) BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige
                                          ) >= 1 THEN
                                -1
                             ELSE
                              zona_ofertado
                             END zona_ofertado
                            ,cantidad_ord_gepaco      cantidad_legalizada
                            , sca.actividad_ actividad
                        FROM(
                             SELECT r.orden_nov_generada orden
                                   ,r.tipo_rabajo
                                   ,r.unidad_operativa
                                   ,r.actividad_orden actividad_
                                   ,cx.actividad_novedad_ofertados
                                   ,zo.id_zona_oper zona_ofertado
                                   ,r.cantidad_ord_gepaco
                               FROM open.ldc_resumen_ord_ofer_car r
                                   ,ldc_zona_loc_ofer_cart zo
                                   ,open.ldc_tipo_trab_x_nov_ofertados cx
                              WHERE r.nuano            = nuparano
                                AND r.numes            = nuparmes
                                AND r.unidad_operativa in (select distinct od.operating_unit_id
                                                             from open.ct_order_certifica oct , open.or_order od
                                                            where oct.order_id = od.order_id
                                                              and oct.certificate_id=nuparacta)
                                AND r.localidad        = zo.localidad
                                AND r.tipo_rabajo      = cx.tipo_trabajo
                            ) sca,open.ldc_item_uo_lr iu
                       WHERE sca.unidad_operativa = iu.unidad_operativa
                         AND sca.actividad_       = iu.actividad
                         AND iu.item              = -1
                         AND iu.liquidacion       = 'A'
                      )
              )
      GROUP BY unidad_operativa,orden,task_type_id, actividad_novedad_ofertados, actividad, nuitemss,liquidacion,zona_ofertado)

group by operating_unit_id, actividad, nuitemss, task_type_id, actividad_novedad_ofertados,
         liquidacion, id_zona_oper  ;

 nucontaotnove    NUMBER(6);
 nuitems          ge_items.items_id%TYPE;
 nucontaconfigura NUMBER(4) DEFAULT 0;
BEGIN
 DELETE ldc_uni_act_ot2 lk WHERE /*lk.nussesion = nuparsesion AND*/ lk.nro_acta = nuparacta;

 FOR i IN cuordenesgenerarnovedadact(nuparacta) LOOP
  nucontaotnove    := 0;
  nuitems          := i.nuitemss;

  IF i.actividad_novedad_ofertados is not null THEN
   BEGIN
     INSERT INTO ldc_uni_act_ot2(
                                nussesion
                               ,unidad_operativa
                               ,actividad
                               ,item
                               ,cantidad_item_legalizada
                               ,liquidacion
                               ,nro_acta
                               ,actividad_novedad_ofertados
                               ,zona_ofertados
                               )
                        VALUES(
                               nuparsesion
                              ,i.unidad_operativa
                              ,i.actividad
                              ,nuitems
                              ,i.cantidad_legalizada
                              ,i.liquidacion
                              ,nuparacta
                              ,i.actividad_novedad_ofertados/*-1*/
                              ,i.id_zona_oper
                              );
    EXCEPTION
     WHEN dup_val_on_index THEN
      NULL;
    END;
  END IF;
 END LOOP;
END;

-----------------------------------------------------------------------------------------------
BEGIN
	IF fblaplicaentregaxcaso('0000554') THEN
		sbEntrega554 := 'S';
	else
		sbEntrega554 := 'N';
	End if;

 IF fblaplicaentrega(sbEntrega) THEN
 nucantidadnovgen := 0;
 nutotalvalornov  := 0;
 -- Consultamos datos para registrar inicio del proceso
 SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER INTO nuccano,nuccmes,nusession,sbuser
   FROM dual;
  -- Registramos inicio del proceso
 ldc_proinsertaestaprog(nuccano,nuccmes,'LDC_PROGENERANOVELTYCARTERA','En ejecucion..',nupaacta,sbuser);
 -- Obtenemos la fecha inicio y fin del acta
 BEGIN
  SELECT k.fecha_inicio,k.fecha_fin,k.id_contrato INTO dtfechainiacta,dtfechafinacta,nucontratoacta
    FROM open.ge_acta k
   WHERE k.id_acta = nupaacta;
 EXCEPTION
  WHEN no_data_found THEN
   sbmensaje := 'No existe un acta con el id : '||nupaacta;
   ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYCARTERA','Termino con errores.');
   RETURN;
 END;
  -- Validamos que la fecha inicio no sea null
 IF /*dtfechainiacta*/ dtfechafinacta IS NULL THEN
  sbmensaje := 'No se encontr? fecha final al acta nro : '||nupaacta;
  ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYCARTERA','Termino con errores.');
  RETURN;
 END IF;
 /*dtfechainiacta*/ dtfechafinacta := to_date(to_char(dtfechafinacta,'DD/MM/YYYY')||' 00:00:00','DD/MM/YYYY HH24:MI:SS');
 -- Obtenemos el periodo contable
 BEGIN
  SELECT cc.cicoano,cc.cicomes INTO nuvaanoper,nuvamesper
    FROM open.ldc_ciercome cc
   WHERE /*dtfechainiacta*/ dtfechafinacta BETWEEN cc.cicofein AND cc.cicofech;
 EXCEPTION
  WHEN no_data_found THEN
   sbmensaje := 'La fecha inicial del acta, no esta contenida en un periodo contable';
   ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYCARTERA','Termino con errores.');
   RETURN;
 END;

  -- Llenamos la tabla con las ordenes las supuestas a generar novedades
 ldcprollenaldcuniactot(nupaacta,nuvaanoper,nuvamesper,dtfechafinacta,nusession);

 -- Recorremos las actividades de las ots en el acta por unidad de trabajo
 nusw := 0;
 FOR i IN cuordernesacta(nusession,nupaacta) LOOP
   --Halla la zona de ofertados de la unidad operativa
   open cuZonaOfertados (i.unidad_operativa);
   fetch cuZonaOfertados into nuZonaOfertados;
   if cuZonaOfertados%notfound then
     nuZonaOfertados := 0;
   end if;
   close cuZonaOfertados;

   if nvl(nuZonaOfertados,0) >= 1  then
     nuZonaOfertados := -1;
   else
     nuZonaOfertados := i.zona_ofertados;
   end if;

   -- Consultamos los rangos configurados para la unidad en especifica
   SELECT COUNT(1) INTO nucontarang
     FROM ldc_const_liqtarran k
    WHERE k.unidad_operativa = i.unidad_operativa;
   -- Consultamos los rangos configurados para la unidad de trabajo -1
   SELECT COUNT(1) INTO nucontarangmenos1
     FROM ldc_const_liqtarran k
    WHERE k.unidad_operativa = -1;
    -- Validamos si la unidad operativa tiene rangos configurados en caso contrario se tomaria el valor -1 para la unidad de trabajo
   IF nucontarang >= 1 THEN
     nuvarunidad := i.unidad_operativa;
   ELSIF nucontarangmenos1 >= 1 THEN
     nuvarunidad := -1;
   ELSE
     nuvarunidad := 0;
   END IF;
  -- Consultamos la cantidad asignada en el mes que se esta liquidando
  nucantidad := 0;

 -- se modifica logica para hallar cantidades asignadas (Cambio 242)
  IF nuZonaOfertados <> -1 THEN
    -- Obtenemos la cantidad de actividades asignadas con zonas
   BEGIN
    SELECT nvl(SUM(cantidad_asignada),0) INTO nucantidad
      FROM(
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM open.ldc_cant_asig_ofer_cart sa
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND sa.actividad            in (select i.actividad from dual union select af.actividad_hija from ldc_act_father_act_hija af where af.actividad_padre = i.actividad)
              AND sa.zona_ofertados       = i.zona_ofertados
              AND sa.reg_activo           = 'Y'
            UNION ALL
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM ldc_cant_asig_ofer_cart sa, open.ldc_unid_oper_hija_mod_tar uh
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND i.unidad_operativa      = uh.unidad_operativa_padre
              AND uh.unidad_operativa_hija = sa.unidad_operatva_cart
              AND sa.actividad            in (select i.actividad from dual union select af.actividad_hija from ldc_act_father_act_hija af where af.actividad_padre = i.actividad)
              AND sa.zona_ofertados       = i.zona_ofertados
              AND sa.reg_activo           = 'Y'
          );
   EXCEPTION
    WHEN no_data_found THEN
     nucantidad := 0;
   END;
  ELSE
       -- Obtenemos la cantidad de actividades asignadas sin zonas
   BEGIN
    SELECT nvl(SUM(cantidad_asignada),0) INTO nucantidad
      FROM(
            SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM open.ldc_cant_asig_ofer_cart sa
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND sa.actividad            in (select i.actividad from dual union select af.actividad_hija from ldc_act_father_act_hija af where af.actividad_padre = i.actividad)
              AND sa.zona_ofertados       = sa.zona_ofertados
              AND sa.reg_activo           = 'Y'
            UNION ALL
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM ldc_cant_asig_ofer_cart sa, open.ldc_unid_oper_hija_mod_tar uh
            WHERE sa.nuano                = nuvaanoper
              AND sa.numes                = nuvamesper
              AND sa.unidad_operatva_cart = nuvarunidad
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND i.unidad_operativa      = uh.unidad_operativa_padre
              AND uh.unidad_operativa_hija = sa.unidad_operatva_cart
              AND sa.actividad            in (select i.actividad from dual union select af.actividad_hija from ldc_act_father_act_hija af where af.actividad_padre = i.actividad)
              AND sa.zona_ofertados       = sa.zona_ofertados
              AND sa.reg_activo           = 'Y'
          );
   EXCEPTION
    WHEN no_data_found THEN
     nucantidad := 0;
   END;
  END IF;

   -- Consultamos los rangos
  nureg      := -1;
  nuvalfinal := NULL;
  if i.liquidacion = 'A' then
     nuactiv := i.actividad;
  else
     nuactiv := -1;
  end if;

  FOR j IN curangos(nuvarunidad,nuactiv,i.item,i.zona_ofertados) LOOP
   nureg            := -1;
   nuvalfinal       := j.cantidad_final;
   nuvalordescontar := nvl(j.valor_liquidar,0);
   -- Validamos si la cantidad esta en un rango
   IF nucantidad BETWEEN j.cantidad_inicial AND j.cantidad_final THEN
     nureg := 0;
     EXIT;
   END IF;
  END LOOP;
  -- Si la cantidad no esta en ningun rango, validamos si es mayor al ultimo rango
  IF nureg = -1 THEN
   IF nucantidad > nuvalfinal AND nuvalfinal IS NOT NULL THEN
      nureg := 0;
   END IF;
  END IF;
  -- Si es mayor al ultimo rango, generamos las novedades
  IF nureg = 0 THEN
   -- Generamos las novedades para cada una de las ordenes
    nuorderid := NULL;
    BEGIN
     /*SELECT pe.person_id INTO nupersona
       FROM sa_user us,ge_person pe
      WHERE us.mask = user
        AND us.user_id = pe.user_id;*/
	nupersona := ge_bopersonal.fnugetpersonid();
    EXCEPTION
     WHEN no_data_found THEN
           nupersona := NULL;
    END;

    IF nvl(nuvalordescontar,0) >= 1 THEN
       nuvalordescontarxcant := nvl(nuvalordescontar,0) * i.cantidad;
       sbmensaje    := NULL;
       -- Obtenemos la novedad asociada al tipo de trabajo
       nunovedadgenera := i.actividad_novedad_ofertada;
       -- Validamos si la orden tiene una novedad para que no genere otra
       swencontro := 0;
       sbcompletobser := 'Unidad operativa padre : '||to_char(i.unidad_operativa);
      IF nunovedadgenera IS NOT NULL THEN
       nucantidadnovgen := nvl(nucantidadnovgen,0) + 1;
       nutotalvalornov  := nvl(nutotalvalornov,0) + nvl(nuvalordescontarxcant,0);
       IF swencontro = 0 THEN
       -- IF j.cantidad_legalizada = 1 THEN
         or_boorder.closeorderwithproduct(
                                          nunovedadgenera
                                         ,i.unidad_operativa
                                         ,1
                                         ,nupersona
                                         ,NULL
                                         ,SYSDATE
                                         ,1
                                         ,nvl(nuvalordescontarxcant,0)
                                         ,1400
                                         ,'ACTA_OFERTADOS : '||to_char(nupaacta,'000000000000000')||' [RFACTA] Se genera novedad valor a desconta por rango y tarifa. Registro '||to_char(nuidenregi)||' '||sbcompletobser
                                         ,NULL
                                         ,14
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,nuorderid
                                        );
        IF nuorderid IS NOT NULL THEN
         nucontanov := nucontanov + 1;
         BEGIN
          SELECT xc.direccion_gen_nov,df.geograp_location_id INTO nudireccgene,nulocalidaddirgen
            FROM open.ldc_const_unoprl xc,open.ab_address df
           WHERE xc.unidad_operativa  = i.unidad_operativa
             AND xc.tipo_ofertado     = 2
             AND xc.direccion_gen_nov = df.address_id;
         EXCEPTION
          WHEN no_data_found THEN
           sbmensaje := 'La unidad operativa : '||to_char(i.unidad_operativa)||' no existe.';
           ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYCARTERA','Termino con errores.');
           RETURN;
         END;
         IF nudireccgene IS NULL THEN
           sbmensaje := 'La unidad operativa : '||to_char(i.unidad_operativa)||' no tiene o no tiene direccion asociada.';
           ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYCARTERA','Termino con errores.');
           RETURN;
         END IF;
         UPDATE open.or_order v
            SET v.defined_contract_id  = nucontratoacta
               ,v.legalization_date    = dtfechafinacta
               ,v.exec_initial_date    = dtfechafinacta
               ,v.execution_final_date = dtfechafinacta
               ,v.exec_estimate_date   = dtfechafinacta
               ,v.is_pending_liq       = NULL
               ,v.external_address_id  = nudireccgene
               ,v.geograp_location_id  = nulocalidaddirgen
          WHERE v.order_id             = nuorderid;
          UPDATE open.or_order_activity gh
             SET gh.comment_   = 'Orden de novedad generada ACTIVIDAD : '||to_char(i.actividad)||' ITEM : '||to_char(i.item)||' ZONA_OFERTADOS : '||to_char(i.zona_ofertados)||' CANTIDAD : '||to_char(i.cantidad)
                ,gh.address_id = nudireccgene
           WHERE gh.order_id = nuorderid;
          INSERT INTO ct_order_certifica(order_id,certificate_id) VALUES(nuorderid,nupaacta);
          nusw := 1;
        END IF;
        END IF;
       END IF;
    END IF;
  END IF;
 END LOOP;

 IF nusw = 1 THEN
  UPDATE ge_acta s
     SET s.is_pending = 1
   WHERE s.id_acta = nupaacta;
 END IF;
 DELETE ldc_uni_act_ot2 lk WHERE /*lk.nussesion = nusession AND*/ lk.nro_acta = nupaacta;
 INSERT INTO ldc_actas_aplica_proc_ofert(
                                         acta
                                        ,procejec
                                        ,novgenera
                                        ,total_nove
                                        ,usuario
                                        ,fecha
                                        )
                                 VALUES(
                                        nupaacta
                                       ,'LDC_PROGENERANOVELTYCARTERA'
                                       ,nucantidadnovgen
                                       ,nutotalvalornov
                                       ,USER
                                       ,SYSDATE
                                       );
    -- Actualizamos registro de ordenes asignadas
   /*UPDATE ldc_cant_asig_ofer_cart sa
      SET sa.nro_acta             = nupaacta
    WHERE sa.nuano                = nuvaanoper
      AND sa.numes                = nuvamesper
      AND sa.unidad_operatva_cart = nuvarunidad;*/
    -- se modifica update (cambio 242)
      UPDATE ldc_cant_asig_ofer_cart sa
      SET sa.nro_acta             = nupaacta
    WHERE sa.nuano                = nuvaanoper
      AND sa.numes                = nuvamesper
      and sa.reg_activo           =  'Y'
      AND sa.nro_acta             = -1
      AND sa.unidad_operatva_cart in (select distinct od.operating_unit_id
                                                             from open.ct_order_certifica oct , open.or_order od
                                                            where oct.order_id = od.order_id
                                                              and oct.certificate_id=nupaacta);
 sbmensaje := 'Se procesaron : '||to_char(nucontanov)||' registros.';
 ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYCARTERA','Termino Ok.');
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  sbmensaje := SQLERRM;
  ldc_proactualizaestaprog(nupaacta,nvl(sbmensaje,'Ok'),'LDC_PROGENERANOVELTYCARTERA','Termino con errores.');
  DELETE ldc_uni_act_ot2 lk WHERE /*lk.nussesion = nusession AND*/ lk.nro_acta = nupaacta;
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
  ut_trace.trace('LDC_PROGENERANOVELTYCARTERA '||' '||SQLERRM, 11);
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROGENERANOVELTYCARTERA', 'ADM_PERSON');
END;
/
