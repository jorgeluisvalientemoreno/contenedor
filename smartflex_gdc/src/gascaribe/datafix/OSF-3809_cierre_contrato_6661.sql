column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuContrato    NUMBER := 6661;
  onuerror      NUMBER;
  osberror      VARCHAR2(4000);
  nucodigoerror CONSTANT NUMBER := 2701;

BEGIN

  UPDATE ge_contrato
     SET status       = 'CE',
         fecha_cierre = TO_DATE('31/10/2024 15:59:45',
                                'DD/MM/YYYY HH24:MI:SS')
   WHERE id_contrato = nuContrato;

  INSERT INTO ct_process_log
    (process_log_id,
     log_date,
     contract_id,
     period_id,
     break_date,
     error_code,
     error_message)
  
  VALUES
    (seq_ct_process_log_109639.NEXTVAL,
     sysdate,
     nuContrato,
     NULL,
     NULL,
     nucodigoerror,
     'SOLICITADO POR EL CASO OSF-3809 - SE CIERRA CONTRATO ' || nuContrato ||
     ' DE UN ESTADO AB A UN NUEVO ESTADO CE Y FECHA DE CIERRE 31/10/2024 15:59:45');

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ERRORS.seterror();
    ERRORS.geterror(onuerror, osberror);
    ROLLBACK;
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/