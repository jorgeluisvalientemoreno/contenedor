column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);

  CURSOR c_escenario1 IS 
        select cargos.rowid as cargoID from open.cargos where 
        cargvalo=35975 and cargcaca = 3 and cargconc = 19 and cargdoso like 'NC-%' and cargtipr = 'P';

       
BEGIN
  DBMS_OUTPUT.PUT_LINE ('Inicia OSF-1781 Actualizacion de causales de cargos');

  BEGIN                                                          -- bloque 1
  DBMS_OUTPUT.PUT_LINE ('Inicia Escenario 1..............');
  -- Para cada registo
  FOR v_escenario1 IN c_escenario1
    LOOP
    
      --modifica el cargo
      update cargos 
      set cargcaca  = 80
      where rowid= v_escenario1.cargoID;
     

      dbms_output.put_line('Luego update ' ||v_escenario1.cargoID);
      END LOOP;
       commit;
     DBMS_OUTPUT.PUT_LINE ('..............Finaliza Escenario 1');
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR CONTR' || osbMensError);
        when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR NCONT|' || osbMensError );
        DBMS_OUTPUT.PUT_LINE ('Termina OSF-1274 escenario 1');
    END;
END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/