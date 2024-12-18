CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_LEGALVISITASFNB(nuparsoli mo_packages.package_id%TYPE) IS
  nuDias            NUMBER := dald_parameter.fnugetnumeric_value('LDC_DIAS_VALIDACION_FECHA');
 CURSOR cursorsolicituderegvisfnb(nucursoli mo_packages.package_id%TYPE) IS
  SELECT mp.package_id solicitud
        ,mp.package_type_id tipo_solicitud
        ,(SELECT ps.description FROM ps_package_type ps WHERE ps.package_type_id = mp.package_type_id) desc_tipo_solicitud
        ,mp.subscription_pend_id contrato
        ,mp.request_date
    FROM mo_packages mp
   WHERE mp.package_id = decode(nucursoli,-1,mp.package_id,nucursoli)
     AND mp.motive_status_id = 13
     AND mp.package_type_id IN(
                               dald_parameter.fnugetnumeric_value('LDC_TIPO_SOL_VISITA')
                              ,dald_parameter.fnugetnumeric_value('LDC_TIPO_SOL_VISITA_XML')
                               );
 CURSOR cursorsolicitudventafnb(nucurcontrato suscripc.susccodi%TYPE, dtFecha mo_packages.request_date%TYPE) IS
  SELECT mp.request_date
        ,mp.package_id solicitud_venta
    FROM mo_packages mp
   WHERE mp.package_type_id      = dald_parameter.fnugetnumeric_value('TIPO_SOL_VENTA_FNB')
     AND mp.subscription_pend_id = nucurcontrato
     AND mp.request_date >=  trunc(dtFecha)
   ORDER BY mp.request_date
     ;

 CURSOR cuotsolvisi(nucursolici mo_packages.package_id%TYPE/*,nucurcausal ge_causal.causal_id%TYPE,sbcoment or_order_comment.order_comment%TYPE*/) IS
  SELECT o.order_id orden_trabajo
   FROM  open.or_order o
        ,open.or_order_activity a
   WHERE a.package_id = nucursolici
     AND o.order_status_id NOT IN  (8,0)
     AND o.order_id   = a.order_id;


 nucausal          ge_causal.causal_id%TYPE;
 sborder_comment   or_order_comment.order_comment%TYPE;
-- sbcadena          VARCHAR2(2000);
 onuErrorCode      NUMBER;
 osbErrorMessage   VARCHAR2(1000);
 nucano            NUMBER(4);
 nucmes            NUMBER(2);
 nusession         NUMBER;
 sbuser            VARCHAR2(100);
 sbmensa           VARCHAR2(100);
 nuconta           NUMBER(10) DEFAULT 0;
 sw                NUMBER(1) DEFAULT 0;
 sbtable           VARCHAR2(1000);
 nuOrden           or_order.order_id%type;

BEGIN
 SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER INTO nucano,nucmes,nusession,sbuser FROM dual;
 ldc_proinsertaestaprog(nucano,nucmes,'LDC_LEGALVISITASFNB','En ejecucion..',nusession,sbuser);
 nuconta := 0;
 sbtable := 'TRUNCATE TABLE log_error_err';
 EXECUTE IMMEDIATE sbtable;
 FOR i IN cursorsolicituderegvisfnb(nuparsoli) LOOP
   nucausal        := NULL;
   FOR j IN cursorsolicitudventafnb(i.contrato, i.request_date) LOOP
   -- DBMS_OUTPUT.PUT_LINE('Entro aqui1');
    nucausal := dald_parameter.fnuGetNumeric_Value('CAUSAL_LEGA_EXITO_VIFNB',NULL);
    sborder_comment := 'Legalizacion Automatica por Venta FNB No. '||to_char(j.solicitud_venta);
  END LOOP;

  IF nucausal IS NULL AND  ( ROUND((TRUNC(SYSDATE)- TRUNC(i.request_date)), 0) >= nuDias ) THEN
   nucausal        := dald_parameter.fnuGetNumeric_Value('CAUSAL_LEGA_INCUMPL_VIFNB',NULL);
   sborder_comment := 'Legalizacion Automatica por incumplimiento por parte del proveedor';
  END IF;

  IF nucausal IS NOT NULL THEN
    FOR j IN cuotsolvisi(i.solicitud/*,nucausal,sborder_comment*/) LOOP
     os_legalizeorderallactivities(
                                  j.orden_trabajo
                                 ,nucausal
                                 ,dald_parameter.fnugetnumeric_value('PARAM_PERSO_LEGA_NOTI')
                                 ,SYSDATE
                                 ,SYSDATE
                                 ,sborder_comment
                                 ,SYSDATE
                                 ,onuErrorCode
                                 ,osbErrorMessage
                                 );
     /*os_legalizeorders(
                      j.sbcadena
                     ,SYSDATE
                     ,SYSDATE
                     ,SYSDATE
                     ,onuErrorCode
                     ,osbErrorMessage
                     );  */
     IF nvl(onuErrorCode,0) >= 1 THEN
   --  DBMS_OUTPUT.PUT_LINE('Entro aqui4'||osbErrorMessage||j.orden_trabajo);
      ROLLBACK;
      sw := 0;
      ldc_prolenalogerror(i.solicitud,1,'Error : '||osbErrorMessage,'LDC_LEGALVISITASFNB');
      --EXIT;
     ELSE
      COMMIT;

     END IF;
    END LOOP;
  END IF;

  OPEN cuotsolvisi(i.solicitud);
  FETCH cuotsolvisi INTO nuOrden;
  IF cuotsolvisi%NOTFOUND THEN
     sw := 1;
  ELSE
     sw := 0;
  END IF;
  CLOSE cuotsolvisi;

  IF sw = 1 THEN
   cf_boactions.attendrequest(i.solicitud);
   nuconta := nuconta + 1;
   sw := 0;
    COMMIT;
  END IF;
 END LOOP;
 COMMIT;
  sbmensa := 'Proceso termino Ok. Se procesaron '||to_char(nuconta)||' registros.';
  ldc_proactualizaestaprog(nusession,nvl(sbmensa,'Ok'),'LDC_LEGALVISITASFNB','Termino '||onuErrorCode);
EXCEPTION
 WHEN OTHERS THEN
   osbErrorMessage := 'Error no controlado'||sqlerrm;
    ldc_proactualizaestaprog(nusession,nvl(osbErrorMessage,'Ok'),'LDC_LEGALVISITASFNB','Termino '||onuErrorCode);
END;
/
PROMPT Otorgando permisos de ejecucion a LDC_LEGALVISITASFNB
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_LEGALVISITASFNB','ADM_PERSON');
END;
/


