column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  /* 
    Se eliminan los registros de pagos que estan en la tabla de CARGOS y que no tienen un registro
    en la tabla de PAGOS.
  */
  Declare

  Cursor Cucupones is
      select cuco, cupon 
      from 
      (
          select 3081177113 cuco, 901211687 cupon from dual union
          select 3081120516 cuco, 901154613 cupon from dual union
          select 3079826425 cuco, 901675885 cupon from dual union
          select 3079826430 cuco, 901675885 cupon from dual union
          select 3080967576 cuco, 901047461 cupon from dual union
          select 3080967578 cuco, 901047461 cupon from dual union
          select 3081474830 cuco, 901413475 cupon from dual union
          select 3079613165 cuco, 901416230 cupon from dual union
          select 3081440863 cuco, 901416230 cupon from dual union
          select 3081391862 cuco, 901357019 cupon from dual union
          select 3081391887 cuco, 901357019 cupon from dual union
          select 3080221884 cuco, 900467259 cupon from dual union
          select 3080221885 cuco, 900467259 cupon from dual union
          select 3081148333 cuco, 901183090 cupon from dual union
          select 3081148335 cuco, 901183090 cupon from dual union
          select 3081091252 cuco, 901124166 cupon from dual union
          select 3081460989 cuco, 901411290 cupon from dual union
          select 3081614325 cuco, 901548809 cupon from dual union
          select 3080702632 cuco, 900831064 cupon from dual union
          select 3081000859 cuco, 901448426 cupon from dual union
          select 3081087825 cuco, 901139279 cupon from dual union
          select 3081427676 cuco, 901391469 cupon from dual union
          select 3080972309 cuco, 901041263 cupon from dual union
          select 3080223732 cuco, 900428775 cupon from dual
      )
      where  not exists (select 1 from open.pagos
                          where pagocupo = cupon);
      
  vnucupon number;
  vnucuco  number;
  vdtdate  date := to_date('23/04/2025','dd/mm/yyyy');
  
  Begin

    For reg in cucupones loop
      --
      Begin
          vnucupon := reg.cupon;
          vnucuco  := reg.cuco;
          --
          delete open.cargos
            where cargcuco = vnucuco
              and cargcodo = vnucupon
              and cargsign = 'PA'
              and trunc(cargfecr) = vdtdate;
          --
          commit;
      --
      Exception
        when others then
          rollback;
          dbms_output.put_line('Error cupon : ' || vnucupon || '  Cuenta de cobro: '  || vnucuco || '  Error  ' ||   SQLERRM);
      End;
      -- 
    End Loop;

  Exception
    when others then
        rollback;
        dbms_output.put_line('Error cupon : ' || vnucupon || '  Cuenta de cobro: '  || vnucuco || '  Error  ' ||   SQLERRM);
  End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/