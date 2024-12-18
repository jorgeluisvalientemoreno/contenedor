column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  CURSOR cuTransicionExiste(inuorigin_id wf_instance_trans.origin_id%type,
                            inutarget_id wf_instance_trans.target_id%type) IS
    SELECT count(1)
      FROM wf_instance_trans
     WHERE wf_instance_trans.origin_id = inuorigin_id
       and wf_instance_trans.target_id = inutarget_id;

  nuTransicionExiste number;

BEGIN

  DBMS_OUTPUT.PUT_LINE('Incia OSF-3313');

  nuTransicionExiste := 0;
  OPEN cuTransicionExiste(228928086, 228928087);
  FETCH cuTransicionExiste
    INTO nuTransicionExiste;
  CLOSE cuTransicionExiste;

  if nuTransicionExiste = 0 then
    dbms_output.put_line('Proceso [Instalación Servicio] - Espera Instalacion Origen [228928086] - Orden Visita Destino [228928087]');
  
    --/*
    Insert into OPEN.WF_INSTANCE_TRANS
      (INST_TRAN_ID,
       ORIGIN_ID,
       TARGET_ID,
       GEOMETRY,
       GROUP_ID,
       EXPRESSION,
       EXPRESSION_TYPE,
       DESCRIPTION,
       TRANSITION_TYPE_ID,
       ORIGINAL,
       STATUS)
    Values
      (-1754694448,
       228928086,
       228928087,
       null,
       0,
       null,
       0,
       null,
       1,
       'Y',
       1);
    --*/
    COMMIT;
  end if;

  nuTransicionExiste := 0;
  OPEN cuTransicionExiste(228928087, 228928084);
  FETCH cuTransicionExiste
    INTO nuTransicionExiste;
  CLOSE cuTransicionExiste;

  if nuTransicionExiste = 0 then
    dbms_output.put_line('Proceso [Instalación Servicio] - Orden Visita Origen [228928087] - Fin Destino [228928084]');
  
    --/*
    Insert into OPEN.WF_INSTANCE_TRANS
      (INST_TRAN_ID,
       ORIGIN_ID,
       TARGET_ID,
       GEOMETRY,
       GROUP_ID,
       EXPRESSION,
       EXPRESSION_TYPE,
       DESCRIPTION,
       TRANSITION_TYPE_ID,
       ORIGINAL,
       STATUS)
    Values
      (-1754694449,
       228928087,
       228928084,
       null,
       0,
       null,
       0,
       null,
       1,
       'Y',
       1);
    --*/
    COMMIT;
  end if;

  DBMS_OUTPUT.PUT_LINE('Termina OSF-3313');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
END;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/