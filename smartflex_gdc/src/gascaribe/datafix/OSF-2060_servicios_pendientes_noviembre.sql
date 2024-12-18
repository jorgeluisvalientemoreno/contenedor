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
    vsbsolici := 194101711;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.interna = 0
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 194101711
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 194828248;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -47863123
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 194828248
       and l.concepto = 4;
    commit;
    --    
    vsbsolici := 196110115;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -137898
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 196110115
       and l.concepto = 400;
    commit;
    --    
    vsbsolici := 196604951;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -12970452
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 196604951
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 198134848;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -3144352
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 198134848
       and l.concepto = 400;
    commit;
    -- 
    vsbsolici := 198645312;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -18400000
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 198645312
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 198867258;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -52033322
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 198867258
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 200310781;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -28420000
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 200310781
       and l.concepto = 19;
    commit;
    --     
    vsbsolici := 200747716;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -16975000
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 200747716
       and l.concepto = 19;
    commit;
    -- 
    vsbsolici :=  202551324;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10400000
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud =  202551324
       and l.concepto = 19;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -27422967
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 202551324
       and l.concepto = 4;       
    commit;      
    -- 
    vsbsolici := 204150734;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8820000
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 204150734
       and l.concepto = 19;
    commit;
    --   
    vsbsolici := 204584188;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -589566
     where l.nuano = 2023
       and l.numes = 11
       and l.solicitud = 204584188
       and l.concepto = 400;
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