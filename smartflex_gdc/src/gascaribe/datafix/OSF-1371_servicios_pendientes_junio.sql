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
    vsbsolici := 179080527;  
    vsbclasif := 400;
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 223775640,
          p.interna = 0,
          p.ingreso_report = -223775640
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 4;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 0,
          p.cert_previa = 33371640,
          p.ingreso_report = -33371640
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 400;
    commit;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -621599
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 188757464
      and p.product_id = 52636118
      and p.concepto = 4;  
    commit;
    --
    vsbsolici := 198888652;  
    vsbclasif := '';  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -101254032
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 198888652
      and p.concepto = 4;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -14149584
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 198888652
      and p.concepto = 400;
    commit;
    --
    vsbsolici := 196014667;
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -20634810
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196014667
      and p.concepto = 400;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -154693660
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196014667
      and p.concepto = 4;
    commit;  
    --
    vsbsolici := 189051233;
    vsbclasif := '';
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 130000000,
          p.ingreso_report = -151250000
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.concepto = 19;  
    commit;  
    --
    vsbsolici := 192843976;
    vsbclasif := '';  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 192843976
      and p.concepto = 4
      and rownum < 128;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -78943073,
          p.carg_x_conex = 79564672
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 192843976
      and p.concepto = 4;
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