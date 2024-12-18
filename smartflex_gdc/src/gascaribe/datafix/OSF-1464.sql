DECLARE
  CURSOR c_escenario1 IS 
    SELECT * FROM pericose where pecscons in 
    (108876,108877,108878,108879,108880,108881);

begin
  DBMS_OUTPUT.PUT_LINE ('Inicia OSF-1464...');
  FOR v_escenario1 IN c_escenario1
  LOOP
    DBMS_OUTPUT.PUT_LINE ('pecscons: '||v_escenario1.pecscons||' PECSFECI: '||v_escenario1.PECSFECI ||' PECSPROC: '||v_escenario1.PECSPROC ||' PECSFLAV: '||v_escenario1.PECSFLAV ||' PECSCICO: '||v_escenario1.PECSCICO );
  END LOOP;      
  DBMS_OUTPUT.PUT_LINE ('Actualiza...');

  UPDATE pericose SET PECSPROC='S', PECSFLAV='S' where pecscons in 
  (108876,108877,108878,108879,108880,108881);
  commit;

  FOR v_escenario1 IN c_escenario1
  LOOP
    DBMS_OUTPUT.PUT_LINE ('pecscons: '||v_escenario1.pecscons||' PECSFECI: '||v_escenario1.PECSFECI ||' PECSPROC: '||v_escenario1.PECSPROC ||' PECSFLAV: '||v_escenario1.PECSFLAV ||' PECSCICO: '||v_escenario1.PECSCICO );
  END LOOP;    
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/