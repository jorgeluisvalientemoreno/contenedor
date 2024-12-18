column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

    Cursor CuServSusc is
      select sesunuse
        from open.servsusc 
      where sesuesco = 1
        and sesufere < to_date('01-10-2024', 'dd/mm/yyyy');
    
    vsbproducto varchar2(15);
    
    Begin
      --
      FOR reg IN CuServSusc LOOP
        --
        Begin
          vsbproducto := reg.sesunuse;
          --
          update open.servsusc s
            set s.sesufere = to_date('31/12/4732', 'dd/mm/yyyy')
          where s.sesunuse = reg.sesunuse;
          --
        Exception
          when others then
              ROLLBACK;
                DBMS_OUTPUT.PUT_LINE('Error en producto : ' || vsbproducto ||'   ' || SQLERRM);
        End
        --    
        commit;
        --
      End loop;
      --   
      DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
      --
    Exception
      when others then
          ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error general en producto : ' || vsbproducto ||'   ' || SQLERRM);
  End;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/