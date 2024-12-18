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
    vsbsolici := 189051233;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = p.ingreso_report/2
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 189051233
      and p.tipo = 'Ing_Osf';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
    set p.ingreso_report = -141250000
  where p.nuano = 2023
    and p.numes in (5) 
    and p.solicitud = 189051233
    and p.concepto = 19;   
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = p.ingreso_report/2
    where p.nuano = 2023
      and p.numes in (5) 
      and p.solicitud = 191454110
      and p.tipo = 'Ing_Osf'
      and p.ingreso_report = -1243198;
    commit;
    --
    vsbsolici := 192843976;
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (5) 
      and p.solicitud = 192843976
      and p.tipo = 'Ing_Osf';
    commit;
    --
    vsbsolici := 198888652;
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (5) 
      and p.solicitud = 198888652
      and p.tipo = 'Ing_Osf';
    commit;  
    --
    vsbsolici := 199110672;
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (5) 
      and p.solicitud = 199110672
      and p.tipo = 'Ing_Osf';
    commit;
    --
    vsbsolici := 199237665;
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (5) 
      and p.solicitud = 199237665
      and p.tipo = 'Ing_Osf';
    commit;
    --
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