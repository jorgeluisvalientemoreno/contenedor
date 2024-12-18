column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1445');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  CURSOR cuvalores IS
   SELECT *--max(CONSECUTIVO)
   FROM OPEN.ldc_optole
    ORDER BY 1;
  nuconta NUMBER := 1;
BEGIN
  FOR reg IN  cuvalores LOOP
     UPDATE ldc_optole SET consecutivo = nuconta
     WHERE consecutivo = reg.consecutivo;
     IF MOD(nuconta,100) = 0 THEN
        COMMIT;
     END IF;
     nuconta := nuconta + 1;
  END LOOP;
 COMMIT;
 dbms_output.put_line(' nuconta '||nuconta);
    EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_LDC_OPTOLE';
    EXECUTE IMMEDIATE 'CREATE SEQUENCE  SEQ_LDC_OPTOLE  MINVALUE 1 MAXVALUE 999999999999999 INCREMENT BY 1 START WITH '||nuconta||' NOCACHE  NOORDER  NOCYCLE' ;
    EXECUTE IMMEDIATE 'GRANT SELECT ON SEQ_LDC_OPTOLE TO SYSTEM_OBJ_PRIVS_ROLE';
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/