column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  Cursor Cupagos is
      select pagocupo, pagofegr, (pagofegr + 50/1440) fecha --, cargfecr
      from  open.pagos, open.cargos
      where pagocupo in (893759441,893759444,893759519,893759887,893762372,893753479,893753510,893754050,893754050,893753981,893754050,893756436,893756576,893759296,893759769)
      and cargcodo = pagocupo
      and cargsign = 'PA';
      
  vnucupon pagos.pagocupo%type;
  
  Begin
  
      For reg in Cupagos loop
        --
        Begin
            -- 
            vnucupon := reg.pagocupo;
            -- Actualizamos la fecha de los pagos de la tabla CARGOS
            update open.cargos
              set cargfecr = reg.fecha
            where cargcodo = reg.pagocupo
              and cargsign = 'PA'
              and cargfecr >= trunc(reg.pagofegr)
              and cargfecr <  reg.fecha;
              
            -- Actualiza la fecha de los pagos de la tabla PAGOS
            update open.pagos
              set pagofegr = reg.fecha
            where pagocupo = reg.pagocupo;
            --
            commit;
            --

        Exception
          when others then
              ROLLBACK;
              DBMS_OUTPUT.PUT_LINE('Error cupon : ' || vnucupon ||'   ' || SQLERRM);
        End;
        --
      End loop;
        
      DBMS_OUTPUT.PUT_LINE('Proceso terminado correctamente');    
        
  Exception
      when others then
          ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error cupon : ' || vnucupon ||'   ' || SQLERRM);
  End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/