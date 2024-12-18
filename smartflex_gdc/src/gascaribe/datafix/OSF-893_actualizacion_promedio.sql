set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
declare
  sbWhat varchar2(4000);
  nujob  number;
begin
sbWhat := ' DECLARE '||
                 chr(10) ||' nuOk NUMBER; '||
           chr(10) ||' sbErrorMessage VARCHAR2(4000); '||
           chr(10) ||' CURSOR cuGetActualizaInfo IS
                        SELECT DISTINCT TRUNC(PREJFECH) fecha
                        FROM OPEN.PERICOSE, OPEN.PERIFACT, OPEN.PROCEJEC
                        WHERE PECSFECF >=  to_date(''01/01/2023'')
                        AND PEFACICL = PECSCICO
                        AND PEFAFIMO BETWEEN PERICOSE.PECSFECI AND PECSFECF
                        AND PROCEJEC.PREJCOPE = PEFACODI
                        AND PROCEJEC.PREJPROG = ''FGCC''
                      ORDER BY 1;'||
           chr(10) || ' BEGIN ' ||
           chr(10) || '   SetSystemEnviroment; '||
           chr(10) || '   Errors.Initialize; '||
           chr(10) || '   FOR reg IN cuGetActualizaInfo LOOP
                          LDC_PKACTCOPRSUCA.prActualiza(reg.fecha);
                          commit;
                        END LOOP; '||
           chr(10) || ' exception when others then  Errors.SetError; '||
           chr(10) || 'END;';

      dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
      commit;
 DBMS_OUTPUT.put_line('numero de job '||nujob);
 exception
   when others then
     rollback;
     DBMS_OUTPUT.put_line('error no controlado '||sqlerrm);
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/