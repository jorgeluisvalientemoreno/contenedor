CREATE OR REPLACE PROCEDURE adm_person.ldcorgescobprejucond(nuvarparano NUMBER,nuvarparmes NUMBER) IS
/**************************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2017-02-24
    Descripcion : Generamos ordenes de gestion de cobro por condiciones configuradas

    Parametros Entradao pre-juridico
      nuano A?o
      numes Mes

   HISTORIA DE MODIFICACIONES
     FECHA              AUTOR               DESCRIPCION
     02/05/2024         PACOSTA             OSF-2638: Se retita el llamado al esquema OPEN (open.)                                   
                                            Se crea el objeto en el esquema adm_person
*************************************************************************************************************************************************/
TYPE t_array_unidad_operativa IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
v_array_unidad_operativa t_array_unidad_operativa;

CURSOR cupoductos(nucupaano NUMBER,nucupames NUMBER,sbcupatied VARCHAR2,nucurtipoeje NUMBER) IS
 SELECT *
   FROM(
        SELECT s.tipo_producto
              ,'LDCGECOJU' exec_process_name
              ,dald_parameter.fnuGetNumeric_Value('CRITERIO_GEST_COBRO_PRE_JUR',NULL) AS coll_mgmt_proc_cr_id
              ,'N' AS is_level_main
              ,s.cliente subscriber_id
              ,s.contrato subscription_id
              ,s.producto product_id
              ,decode(cg.tipo_edad,'M',s.edad,'D',s.edad_deuda) debt_age
              ,nvl(cg.dias_asignacion,1) dias_configurado_asignacion
              ,(
                SELECT nvl(MAX(trunc(cicofech) - trunc(k.caccfeve)),0)
                  FROM ldc_ciercome,ic_cartcoco k
                 WHERE cicoano         = nucupaano
                   AND cicomes         = nucupames
                   AND caccnuse        = s.producto
                   AND trunc(cicofech) = caccfege
               ) dias_mora
              ,(
                SELECT nvl(MAX(trunc(cicofech) - trunc(factfege)),0)
                  FROM ldc_ciercome,ic_cartcoco k,cuencobr,factura
                 WHERE cicoano         = nucupaano
                   AND cicomes         = nucupames
                   AND k.caccnuse      = s.producto
                   AND trunc(cicofech) = k.caccfege
                   AND cacccuco        = cucocodi
                   AND cucofact        = factcodi
               ) dias_deuda
              ,s.sesusape+s.deuda_no_corriente total_debt
              ,s.deuda_corriente_no_vencida outstanding_debt
              ,s.deuda_corriente_vencida overdue_debt
              ,s.deuda_no_corriente deferred_debt
              ,nvl(s.valor_castigado,0) puni_over_debt
              ,decode(s.ultimo_plan_fina,-1,NULL,0,NULL,s.ultimo_plan_fina) financing_plan_id
              ,s.sesusape total_debt_current
              ,s.edad edad_mora
              ,s.edad_deuda edad_deuda
              ,s.localidad localidad
              ,s.segmento_predio
              ,(SELECT d.address_id FROM pr_product d WHERE d.product_id = s.producto) direccion
              ,s.categoria
              ,s.subcategoria
              ,s.estado_corte
              ,(SELECT d.commercial_plan_id FROM pr_product d WHERE d.product_id = s.producto) plan_comercial
              ,s.nro_ctas_con_saldo
              ,s.estado_financiero
              ,s.ultimo_plan_fina
              ,cg.tipo_edad
              ,cg.unidad_operativa
              ,po.prioridad
         FROM ldc_osf_sesucier s,ldc_config_gest_cobr cg,ldc_prio_tipo_prod_gestcobr po
        WHERE s.nuano          = nucupaano
          AND s.numes          = nucupames
          AND cg.tipo_edad     = sbcupatied
          AND s.tipo_producto  = decode(cg.tipo_producto,-1,s.tipo_producto,cg.tipo_producto)
          AND s.tipo_producto  = po.tipo_producto
          AND s.ciclo          = decode(cg.ciclo,-1,s.ciclo,cg.ciclo)
          AND s.estado_corte   = decode(cg.estado_corte,-1,s.estado_corte,cg.estado_corte)
          AND s.estado_tecnico = decode(cg.estado_producto,-1,s.estado_tecnico,cg.estado_producto)
          AND s.categoria      = decode(cg.categoria,-1,s.categoria,cg.categoria)
          AND s.categoria      IN(SELECT to_number(column_value)
                                    FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CATEGORIAS_GESCOBR',NULL),',')))
          AND 0                = (
                                 SELECT COUNT(1)
                                   FROM or_order_activity agc,or_order ogc
                                  WHERE agc.product_id      = s.producto
                                    AND ogc.task_type_id    = 5005
                                    AND ogc.order_status_id IN(0,5)
                                    AND agc.order_id        = ogc.order_id
                                  )
          AND decode(cg.estado_financiero,'C',nvl(s.valor_castigado,0),decode(dald_parameter.fsbgetvalue_chain('PARAMETRO_REALIZA_ASIGNACION',NULL),'T',(s.sesusape+s.deuda_no_corriente),s.deuda_corriente_vencida)) BETWEEN cg.rango_inicial_$ AND cg.rango_final_$
          AND decode(cg.tipo_edad,'M',s.edad,s.edad_deuda) BETWEEN cg.edad_inicial AND cg.edad_final
          AND s.nro_ctas_con_saldo BETWEEN cg.rango_ctas_ini AND cg.rango_ctas_fin
          AND s.estado_financiero IN(SELECT esfin
                                       FROM(
                                            SELECT 'C' esfin FROM dual
                                            )
                                      WHERE esfin = cg.estado_financiero
                                      UNION
                                      SELECT esfin
                                        FROM(
                                             SELECT 'A' esfin FROM dual
                                             UNION ALL
                                             SELECT 'M' FROM dual
                                             UNION ALL
                                             SELECT 'D' FROM dual
                                             )
                                       WHERE esfin = decode(cg.estado_financiero,'-',esfin,cg.estado_financiero))
          AND s.departamento = decode(nvl(cg.departamento,-1),-1,s.departamento,nvl(cg.departamento,-1))
          AND s.localidad    = decode(nvl(cg.localidad,-1),-1,s.localidad,nvl(cg.localidad,-1))
          )
    WHERE decode(tipo_edad,'M',dias_mora,dias_deuda) >= dias_configurado_asignacion
	ORDER BY decode(nucurtipoeje,1,prioridad,debt_age) DESC;
 nuvaano                       NUMBER(4);
 nuvames                       NUMBER(2);
 nuorderid                     or_order.order_id%TYPE;
 nuorderactivityid             or_order_activity.order_activity_id%TYPE;
 nuvaactgene                   ld_parameter.numeric_value%TYPE;
 cnusecond                     CONSTANT NUMBER := 1/24/60/60;
 nuerror                       NUMBER(10);
 sberror                       VARCHAR2(1000);
 nutsess                       NUMBER;
 sbparuser                     VARCHAR2(30);
 nuconta                       NUMBER(10) DEFAULT 0;
 sbtipoedad                    VARCHAR2(2);
 nuconproh                     NUMBER(5);
 nucontidadreg                 NUMBER(8);
 nucatnptog                    NUMBER(8);
 nucodigoreg                   gc_coll_mgmt_pro_det.coll_mgmt_pro_det_id%TYPE;
 cantidad_ref_ultimos_12_meses NUMBER(8);
 dtfechainicial                DATE;
 dtfechafinal                  DATE;
 nuplanfinanmayprior           plandife.pldicodi%TYPE DEFAULT NULL;
 nuproductopadre               pr_product.product_id%TYPE;
 blcommit                      BOOLEAN DEFAULT FALSE;
 nuunidadoperativa             or_operating_unit.operating_unit_id%TYPE;
 nuvartipogeneracion           ld_parameter.numeric_value%TYPE;
 sbnomarchres                  VARCHAR2(100);
 sbmensajeinco                 VARCHAR2(4000);
 sbruradirectorio              ge_directory.path%TYPE;
 vfileinco                     utl_file.file_type;
BEGIN
-- se obtiene parametros
 nuvaano := nuvarparano;
 nuvames := nuvarparmes;
  -- Se inicia log del programa
 SELECT  USERENV('SESSIONID')
        ,USER INTO nutsess,sbparuser
   FROM dual;
 ldc_proinsertaestaprog(nuvaano,nuvames,'LDCORGESCOBPREJUCOND','En ejecucion',nutsess,sbparuser);
 nucatnptog          := 0;
 dtfechainicial      := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
 dtfechafinal        := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
 nuvartipogeneracion := dald_parameter.fnuGetNumeric_Value('FLAG_GESCOBR_EDAD_PRIO_GAS');
 SELECT COUNT(1) INTO nucatnptog
   FROM estaprog ep
  WHERE ep.esprprog = 'LDCGECOJU';
    IF nucatnptog = 0 THEN
     INSERT INTO estaprog(esprprog,esprfein) VALUES('LDCGECOJU',SYSDATE);
    END IF;
 nuvaactgene := dald_parameter.fnuGetNumeric_Value('LDC_ACTIGCPGC');
 sbnomarchres     := 'resultado_gest_cobr_archivo'||to_char(SYSDATE, 'YYYY_MM_DD_HH_MI_SS')||'.txt';
 sbruradirectorio := TRIM(dald_parameter.fsbGetValue_Chain('RUTA_PROY_CAST_INCLUSI',NULL));
 vfileinco        := utl_file.fopen(sbruradirectorio,sbnomarchres,'W');
 nuconta := 0;
 sbmensajeinco := 'CONTRATO'||'|'||'PRODUCTO       '||'|'||' OBSERVACION';
 utl_file.put_line(vfileinco,sbmensajeinco);
 FOR datos IN 1..2 LOOP
  IF datos = 1 THEN
    sbtipoedad := dald_parameter.fsbGetValue_Chain('PARAMETRO_EDAD_PRIORIDAD_UNO',NULL);
  ELSE
    sbtipoedad := dald_parameter.fsbGetValue_Chain('PARAMETRO_EDAD_PRIORIDAD_DOS',NULL);
  END IF;
  FOR j IN cupoductos(nuvaano,nuvames,sbtipoedad,nuvartipogeneracion) LOOP
   nucontidadreg := 0;
   nuproductopadre := j.product_id;
   SELECT COUNT(1) INTO nucontidadreg
     FROM or_order_activity agc,or_order ogc
    WHERE agc.product_id      = j.product_id
      AND ogc.task_type_id    = 5005
      AND ogc.order_status_id IN(0,5)
      AND agc.order_id        = ogc.order_id;
   IF nucontidadreg = 0 THEN
    nuconta := nuconta + 1;
    -- se crea la orden y su actividad
    nuorderid         := NULL;
    nuorderactivityid := NULL;
    BEGIN
     SAVEPOINT primera;
     or_boorderactivities.createactivity
                                       (
                                        nuvaactgene,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        j.direccion,
                                        NULL,
                                        j.subscriber_id,
                                        j.subscription_id,
                                        j.product_id,
                                        NULL,
                                        NULL,
                                        NULL,
                                        or_boconstants.cnuprocess_manual_charges,
                                        NULL,
                                        FALSE,
                                        NULL,
                                        nuorderid,
                                        nuorderactivityid,
                                        NULL,
                                        ge_boconstants.csbyes,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        TRUE,
                                        j.total_debt
                                       );
    EXCEPTION
      WHEN OTHERS THEN
       nuorderid := NULL;
       sberror   := SQLERRM;
    END;
    -- Asignacion de ordenes
      IF nuorderid IS NOT NULL THEN
       nuerror           := 0;
       sberror           := NULL;
       nuunidadoperativa := NULL;
       IF v_array_unidad_operativa.exists(j.subscription_id) THEN
        nuunidadoperativa := v_array_unidad_operativa(j.subscription_id);
       ELSE
        v_array_unidad_operativa(j.subscription_id) := j.unidad_operativa;
        nuunidadoperativa := v_array_unidad_operativa(j.subscription_id);
       END IF;
       os_assign_order(
                       nuorderid
                      ,nuunidadoperativa
                      ,SYSDATE+cnusecond
                      ,SYSDATE
                      ,nuerror
                      ,sberror
                      );
         IF nuerror = 0 THEN
          nuconproh := 0;
          nucodigoreg := seq_gc_coll_mgmt_pr_275315.nextval;
          cantidad_ref_ultimos_12_meses := 0;
          SELECT COUNT(DISTINCT(d.difecofi)) INTO cantidad_ref_ultimos_12_meses
            FROM diferido d
            WHERE d.difenuse = j.product_id
              AND d.difefein BETWEEN  dtfechainicial AND dtfechafinal
              AND d.difeprog = 'GCNED';
              nuplanfinanmayprior := ldc_retornaplanfinmayprior(
                                                                j.product_id
                                                               ,j.localidad
                                                               ,j.segmento_predio
                                                               ,j.direccion
                                                               ,j.categoria
                                                               ,j.subcategoria
                                                               ,j.estado_corte
                                                               ,j.plan_comercial
                                                               ,cantidad_ref_ultimos_12_meses
                                                               ,j.nro_ctas_con_saldo
                                                               ,j.estado_financiero
                                                               ,j.ultimo_plan_fina
                                                               );
               INSERT INTO gc_coll_mgmt_pro_det
                                              (
                                               coll_mgmt_pro_det_id
                                              ,order_id
                                              ,exec_process_name
                                              ,coll_mgmt_proc_cr_id
                                              ,is_level_main
                                              ,subscriber_id
                                              ,subscription_id
                                              ,product_id
                                              ,debt_age
                                              ,total_debt
                                              ,outstanding_debt
                                              ,overdue_debt
                                              ,deferred_debt
                                              ,puni_over_debt
                                              ,refinanci_times
                                              ,financing_plan_id
                                              ,total_debt_current
                                              )
                                        VALUES
                                              (
                                               nucodigoreg
                                              ,nuorderid
                                              ,j.exec_process_name
                                              ,j.coll_mgmt_proc_cr_id
                                              ,j.is_level_main
                                              ,j.subscriber_id
                                              ,j.subscription_id
                                              ,j.product_id
                                              ,j.debt_age
                                              ,j.total_debt
                                              ,j.outstanding_debt
                                              ,j.overdue_debt
                                              ,j.deferred_debt
                                              ,j.puni_over_debt
                                              ,cantidad_ref_ultimos_12_meses
                                              ,nuplanfinanmayprior
                                              ,j.total_debt_current
                                              );
          blcommit := TRUE;
       COMMIT;
      ELSE
       ROLLBACK TO primera;
       blcommit := FALSE;
       sbmensajeinco := to_char(j.subscription_id,'00000000')||'|'||to_char(j.product_id,'000000000000000')||'|'||' Error al generar ord?n de trabajo : '||sberror;
       utl_file.put_line(vfileinco,sbmensajeinco);
     END IF;
    ELSE
     blcommit := FALSE;
     sbmensajeinco := to_char(j.subscription_id,'00000000')||'|'||to_char(j.product_id,'000000000000000')||'|'||' Error al generar ord?n de trabajo : '||sberror;
     utl_file.put_line(vfileinco,sbmensajeinco);
     ROLLBACK TO primera;
    END IF;
   END IF;
   IF blcommit = TRUE THEN
    COMMIT;
   END IF;
  END LOOP;
END LOOP;
 sberror := 'Proceso termino, se procesaron : '||to_char(nuconta)||' registros.';
 IF nucatnptog = 0 THEN
   UPDATE estaprog h
      SET h.esprfefi = SYSDATE
    WHERE h.esprprog = 'LDCGECOJU'
      AND h.esprfefi IS NULL;
      COMMIT;
 END IF;
 COMMIT;
 utl_file.fclose(vfileinco);
 ldc_proactualizaestaprog(nutsess,sberror,'LDCORGESCOBPREJUCOND','Ok');
EXCEPTION
 WHEN OTHERS THEN
  ldc_proactualizaestaprog(nutsess,SQLERRM,'LDCORGESCOBPREJUCOND','con errores');
  Errors.setError;
  RAISE ex.controlled_error;
END LDCORGESCOBPREJUCOND;
/
PROMPT Otorgando permisos de ejecucion a LDCORGESCOBPREJUCOND
BEGIN
    pkg_utilidades.praplicarpermisos('LDCORGESCOBPREJUCOND', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDCORGESCOBPREJUCOND para reportes
GRANT EXECUTE ON adm_person.LDCORGESCOBPREJUCOND TO rexereportes;
/
