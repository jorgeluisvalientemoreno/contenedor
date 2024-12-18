column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    nuClassCausal     NUMBER;
    nuErrorCode       NUMBER;
    sbErrorMessage    VARCHAR2(4000);

  -- Poblacion DataFix
  CURSOR cuPoblacion IS
    SELECT  wf.EXTERNAL_ID AS solicitud,
            mp.request_date AS fecha_registro,
            wf.INSTANCE_ID AS instacia_error,
            wf.parent_id AS instancia_atributo,
            (select description from open.wf_instance where instance_id = wf.parent_id) AS desc_insta_padre,
            (select unit_type_id from open.wf_instance where instance_id = wf.parent_id) AS tipo_unid_padre,
            (select instance_attrib_id from open.WF_INSTANCE_ATTRIB a where a.instance_id = wf.parent_id) AS id_atributo,
            (select attribute_id from open.WF_INSTANCE_ATTRIB a where a.instance_id = wf.parent_id) AS atributo,
            (select value from open.WF_INSTANCE_ATTRIB a where a.instance_id = wf.parent_id) AS valor_atributo,                      
            wf.DESCRIPTION,
            wf.STATUS_ID||' - '||wis.description AS Estado_Instancia,
            el.status AS Estad_excepción,
            el.EXCEPTION_LOG_ID,
            el.EXCEPTION_TYPE_ID ||' - '||gt.description AS Tipo_Excepcion,
            el.MESSAGE_ID,
            el.MESSAGE_DESC
    FROM    open.wf_instance wf
            JOIN open.wf_exception_log el on wf.instance_id = el.instance_id
            JOIN open.mo_packages mp on mp.package_id = wf.external_id
            JOIN open.mo_motive mt on mp.package_id = mt.package_id
            JOIN OPEN.WF_INSTANCE_STATUS wis on wf.status_id = wis.instance_status_id
            JOIN OPEN.GE_EXCEPTION_TYPE gt on el.EXCEPTION_TYPE_ID = gt.EXCEPTION_TYPE_ID
    WHERE   wf.status_id = 9            --> Excepción
    AND     el.status = 1               --> Estado de la excepción: (1) pendiente, (2) resuelta
    AND     mp.package_type_id = 288
    AND     mp.MOTIVE_STATUS_ID = 13    --> Registrado
    AND     el.EXCEPTION_TYPE_ID = 8;    --> 8 - Error resolviendo una tarea que termino de ejecutarse

   -- tomar la ultima orden generada del flujo
   CURSOR cuUltimaOrden (inuSolicitud open.mo_packages.package_id%type)
   IS
    SELECT *
    FROM (
          select   gc.CLASS_CAUSAL_ID
          from    open.or_order_activity oa 
                  join open.or_order oo on oa.order_id = oo.order_id
                  join open.ge_causal gc on oo.causal_id = gc.causal_id
          where package_id = inuSolicitud
          order by legalization_date desc)
    WHERE rownum = 1;

BEGIN
  dbms_output.put_line('-------------------  Inicio OSF-1064 ------------------- ');

  FOR regPoblacion IN cuPoblacion
  LOOP
      nuClassCausal := null;

      DBMS_OUTPUT.PUT_LINE('----> Inicio Solicitud ['||regPoblacion.solicitud||']');
      
      open cuUltimaOrden(regPoblacion.solicitud);
      fetch cuUltimaOrden into nuClassCausal;
      close cuUltimaOrden;

      DBMS_OUTPUT.PUT_LINE('-> nuClassCausal ['||nuClassCausal||']');

      BEGIN
          UPDATE  open.WF_INSTANCE_ATTRIB a
          SET     a.value = nuClassCausal
          WHERE   a.instance_attrib_id = regPoblacion.id_atributo;
          COMMIT;
          DBMS_OUTPUT.PUT_LINE('-> OK [WF_INSTANCE_ATTRIB] instance_attrib_id ['||regPoblacion.id_atributo ||'] - nuClassCausal: '||nuClassCausal);
      EXCEPTION
          WHEN OTHERS THEN
            rollback;
            DBMS_OUTPUT.PUT_LINE('FALLO [WF_INSTANCE_ATTRIB] instance_attrib_id ['||regPoblacion.id_atributo ||'] - nuClassCausal: '||nuClassCausal);
            DBMS_OUTPUT.PUT_LINE('fallo: --> '||sqlerrm);
      END;

      -- Empujar Flujo
      BEGIN
          dbms_output.put_line('--> inicia actualizacion de la instancia:'|| regPoblacion.instacia_error);
          errors.Initialize;
          ut_trace.Init;
          ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
          ut_trace.SetLevel(0);
          ut_trace.Trace('INICIO');

          WF_BOEIFINSTANCE.RecoverInstance(regPoblacion.instacia_error);
          COMMIT;
          dbms_output.put_line('--> Fin actualizacion de la instancia:'|| regPoblacion.instacia_error);
      EXCEPTION
          when ex.CONTROLLED_ERROR then
              Errors.getError(nuErrorCode, sbErrorMessage);
              dbms_output.put_line('ERROR CONTROLLED ');
              dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
              dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
			  ROLLBACK;
          when OTHERS then
              Errors.setError;
              Errors.getError(nuErrorCode, sbErrorMessage);
              dbms_output.put_line('ERROR OTHERS ');
              dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
              dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
			  ROLLBACK;
      END;
      DBMS_OUTPUT.PUT_LINE('----> Fin Solicitud ['||regPoblacion.solicitud||']');
  END LOOP;
  
  COMMIT;

  dbms_output.put_line('------------------- Fin OSF-1064 ------------------- ');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1064 ----');
    DBMS_OUTPUT.PUT_LINE('OSF-1064-Error General: --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/