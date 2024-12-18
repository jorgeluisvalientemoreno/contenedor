CREATE OR REPLACE PROCEDURE adm_person.ldc_procrevnovedadesnueesliq(nuparaacta ct_order_certifica.certificate_id%TYPE) IS
/*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A.

    Unidad         : ldc_procrevnovedadesnueesliq
    Descripcion    : Anula las ordenes de novedad nuevo esquema de liquidaci?n,
                     cuando se reversa el acta

    Autor          : John Jairo Jimenez Marim?n
    Fecha          : 15-07-2016

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    08/05/2024        Adrianavg            OSF-2668: Se migra del esquema OPEN al esquema ADM_PERSON
****************************************************************************/
 CURSOR cuordeneanular(nucurpacta ct_order_certifica.certificate_id%TYPE) IS
  SELECT DISTINCT(oc.order_id) orden
    FROM open.or_order_comment  oc
        ,open.or_order          ot
        ,open.ldc_const_unoprl  uo
   WHERE oc.order_comment LIKE 'ACTA_OFERTADOS%'
     AND to_number(TRIM(substr(oc.order_comment,19,15))) = nucurpacta
     AND oc.comment_type_id   = 1400
     AND ot.order_status_id   = 8
     AND oc.order_id          = ot.order_id
     AND ot.operating_unit_id = uo.unidad_operativa;
nuparano   NUMBER(4);
nuparmes   NUMBER(2);
nutsess    NUMBER;
sbparuser  VARCHAR2(100);
sbmensa    VARCHAR2(100);
nucantanul NUMBER(10) DEFAULT 0;
BEGIN
 SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER
   INTO nuparano
       ,nuparmes
       ,nutsess
       ,sbparuser
   FROM dual;
 ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PROCREVNOVEDADESNUEESLIQ','En ejecucion',nuparaacta,TRIM(sbparuser));
 nucantanul := 0;
 FOR i IN cuordeneanular(nuparaacta) LOOP
  or_boanullorder.anullorderwithoutval(i.orden,SYSDATE);
  UPDATE open.or_order o
     SET o.is_pending_liq = NULL
   WHERE o.order_id       = i.orden;
  nucantanul := nucantanul + 1;
 END LOOP;
 -- Se elimina informacion para reporte de escalonados
 DELETE ldc_reporte_ofert_escalo re WHERE re.nro_acta = nuparaacta;
 sbmensa := 'Proceso termin? Ok. Se anular?n : '||to_char(nucantanul)||' novedades de ofertados. ACTA : '||to_char(nuparaacta);
 ldc_proactualizaestaprog(nuparaacta,sbmensa,'LDC_PROCREVNOVEDADESNUEESLIQ','Termino Ok.');
EXCEPTION
 WHEN OTHERS THEN
  sbmensa := SQLERRM;
  ldc_proactualizaestaprog(nuparaacta,sbmensa,'LDC_PROCREVNOVEDADESNUEESLIQ','Termino con errores.');
END LDC_PROCREVNOVEDADESNUEESLIQ;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_PROCREVNOVEDADESNUEESLIQ
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCREVNOVEDADESNUEESLIQ', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REXEREPORTES sobre procedimiento LDC_PROCREVNOVEDADESNUEESLIQ
GRANT EXECUTE ON ADM_PERSON.LDC_PROCREVNOVEDADESNUEESLIQ TO REXEREPORTES;
/
