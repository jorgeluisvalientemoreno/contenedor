column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

  Declare
    vsbsolici varchar2(15);
    vsbclasif varchar2(4);
  Begin
    --
    vsbsolici := 197165944;
    vsbclasif := 4;  
    DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (3,4)
      and p.product_id = 52172988
      and p.tipo = 'NOTA_MES';  
    commit;
    --
    DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (4)
      and p.product_id = 52452287
      and p.tipo = 'NOTA_MES'
      and p.ingreso_report = -27280000;
    commit;
    --
    DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (3,4)
      and p.product_id = 52219526
      and p.tipo = 'NOTA_MES'
      and p.ingreso_report = -13244000;
    commit;  
    --
    vsbsolici := 187578605;
    vsbclasif := 19;  
    DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 4 
      and p.solicitud = 187578605
      and p.tipo = 'Ing_Osf';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 44080000,
          p.ingreso_report = -p.carg_x_conex
    where p.nuano = 2023
      and p.numes = 4 
      and p.solicitud = 187578605
      and p.concepto = 4;
    commit;     
    
    DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
    --
  Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error solicitud : ' || vsbsolici || '  clasificador : ' || vsbclasif ||'   ' || SQLERRM);
  End;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/