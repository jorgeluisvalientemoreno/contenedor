column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  CURSOR cuInvalidos IS
    SELECT  owner, object_type, object_name
    FROM    dba_objects
    WHERE   status = 'INVALID'
    AND     owner IN ('OPEN','PERSONALIZACIONES','ADM_PERSON','MULTIEMPRESA','HOMOLOGACION','MIGRAGG');

  TYPE tytbObjetosInvalidos IS TABLE OF cuInvalidos%ROWTYPE INDEX BY BINARY_INTEGER;

  tbObjetosInvalidos tytbObjetosInvalidos;
  nuCantidad  NUMBER;
  nuIndex     BINARY_INTEGER;

BEGIN
  
  OPEN cuInvalidos;
  FETCH cuInvalidos BULK COLLECT INTO tbObjetosInvalidos;
  CLOSE cuInvalidos;

  nuCantidad := tbObjetosInvalidos.COUNT;

  dbms_output.put_line('Hay '||nuCantidad||' objetos invalidos.');

  IF (nuCantidad > 0) THEN
    
    dbms_output.put_line('OWNER|TIPO|NOMBRE');
    
    nuIndex := tbObjetosInvalidos.first;
    LOOP
        EXIT WHEN nuIndex IS NULL;
        dbms_output.put_line(tbObjetosInvalidos(nuIndex).owner||'|'||tbObjetosInvalidos(nuIndex).object_type||'|'||tbObjetosInvalidos(nuIndex).object_name);

        nuIndex := tbObjetosInvalidos.NEXT(nuIndex);
    END LOOP;
  END IF;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/