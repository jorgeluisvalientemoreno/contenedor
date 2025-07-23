column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  TYPE typrejcope IS TABLE OF procejec.prejcope%TYPE;
  TYPE typrejfech IS TABLE OF procejec.prejfech%TYPE;

  tbprejcope    typrejcope;
  tbprejfech    typrejfech;
begin
  dbms_output.put_line('Inicia OSF-4659!');

    DELETE 
    FROM    procejec
    WHERE   prejprog = 'FGCC'
    AND     prejcope IN   (    
                            SELECT prejcope 
                            FROM (
                                    SELECT prejcope, count(prejprog) cont
                                    FROM procejec
                                    WHERE prejprog = 'FGCC'
                                    GROUP BY prejcope
                                  ) 
                            WHERE   cont >1
                          ) 
    AND prejfech >= '28/06/2025 01:00:00'
    RETURNING prejcope, prejfech BULK COLLECT INTO tbprejcope, tbprejfech;

    FOR i IN 1 .. tbprejcope.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('Proceso eliminado: prejcope=' || tbprejcope(i) || ', prejfech=' || tbprejfech(i));
    END LOOP;
    
  dbms_output.put_line('Fin OSF-4659!');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/