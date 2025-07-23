column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuErrorCode      NUMBER;
  sbErrorMessage   VARCHAR2(4000);
  nuEjecucionFlujo NUMBER := 0;

  CURSOR cuSolicitudes is
    select solicitud, instancia
      from (select 124430245 solicitud, 1581268741 instancia
              from dual
            union all
            select 141207176 solicitud, 1661382271 instancia
              from dual
            union all
            select 181894832 solicitud, 170629128 instancia
              from dual
            union all
            select 183442125 solicitud, 267898350 instancia
              from dual
            union all
            select 183442247 solicitud, 267900810 instancia
              from dual
            union all
            select 183442820 solicitud, 267914430 instancia
              from dual
            union all
            select 184769786 solicitud, 320682616 instancia
              from dual
            union all
            select 184769826 solicitud, 320683676 instancia
              from dual
            union all
            select 184770465 solicitud, 320704546 instancia
              from dual
            union all
            select 184779601 solicitud, 321066834 instancia
              from dual
            union all
            select 185301284 solicitud, 339551568 instancia
              from dual
            union all
            select 186190066 solicitud, 376191276 instancia
              from dual
            union all
            select 186193755 solicitud, 376301492 instancia
              from dual
            union all
            select 186206457 solicitud, 376703568 instancia
              from dual
            union all
            select 186429700 solicitud, -2146185028 instancia
              from dual
            union all
            select 192031055 solicitud, -1993077538 instancia
              from dual
            union all
            select 198570519 solicitud, -1872186612 instancia
              from dual
            union all
            select 199328134 solicitud, -1863755283 instancia
              from dual
            union all
            select 199328335 solicitud, -1863756042 instancia
              from dual
            union all
            select 201377464 solicitud, -1842395174 instancia
              from dual
            union all
            select 202345423 solicitud, -1832086886 instancia
              from dual
            union all
            select 202345544 solicitud, -1832089430 instancia
              from dual
            union all
            select 202345856 solicitud, -1832084254 instancia
              from dual
            union all
            select 212634208 solicitud, -1741152030 instancia
              from dual
            union all
            select 215349829 solicitud, -1719047474 instancia
              from dual
            union all
            select 215349863 solicitud, -1719047674 instancia
              from dual
            union all
            select 215350159 solicitud, -1719046439 instancia
              from dual
            union all
            select 218852176 solicitud, -1688326074 instancia
              from dual)
     Order by solicitud asc;

  rfcuSolicitudes cuSolicitudes%rowtype;

BEGIN

  ---1
  BEGIN
  
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(0);
    ut_trace.Trace('INICIO');
  
    FOR rfcuSolicitudes in cuSolicitudes LOOP
    
      BEGIN
      
        WF_BOAnswer_Receptor.AnswerReceptor(rfcuSolicitudes.instancia, -- Código de la instancia del flujo
                                            MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
      
        commit;
      
        dbms_output.put_line('Ejecucion de instancia ' ||
                             rfcuSolicitudes.instancia ||
                             ' de la solicitud ' ||
                             rfcuSolicitudes.solicitud);
      
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          dbms_output.put_line('Error ejecutando Instancia de flujo: ' ||
                               sqlerrm);
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          dbms_output.put_line('ERROR OTHERS ');
          dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
          dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
      END;
    
    END LOOP;
  
    BEGIN
    
      update open.mo_packages mp
         set mp.motive_status_id = 14
       where mp.package_id = 10670569;
    
      commit;
    
      dbms_output.put_line('Actualiza estado de solicitud 10670569 a estado 14 - Atendido');
    
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error No Actualiza estado de solicitud 10670569 a estado 14 - Atendido: ' ||
                             sqlerrm);
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
        dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
      
    END;
  
  END;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

