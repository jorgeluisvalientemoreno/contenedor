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
    vsbsolici := 188403015;
    vsbclasif := '';   
    insert into open.ldc_osf_serv_pendiente
    select * from open.ldc_osf_serv_pendiente l
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 192695604
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.carg_x_conex = 3729594,
           l.solicitud = 188403015,
           l.ingreso_report = -3729594
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 192695604
       and l.concepto = 4
       and rownum = 1;
    commit;
    --
    vsbsolici := 190499453;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -35431143
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 190499453
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -5932736
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 190499453
       and l.concepto = 400;       
    commit;
    --  
    vsbsolici := 190694186;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -52835915
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 190694186
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -42240000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 190694186
       and l.concepto = 19;       
    commit;
    --      
    vsbsolici := 195377220;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -82051068
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 195377220
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -86450000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 195377220
       and l.concepto = 19;       
    commit;    
    --      
    vsbsolici := 196604951;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -67980000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 196604951
       and l.concepto = 19;       
    commit;
    --      
    vsbsolici := 197400101;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -30938732
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 197400101
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -4323484
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 197400101
       and l.concepto = 400;
    --  
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -15400000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 197400101
       and l.concepto = 19;       
    commit;    
    --      
    vsbsolici := 197702969;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -111098174
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 197702969
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -43520000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 197702969
       and l.concepto = 19;       
    commit;
    --      
    vsbsolici := 198867258;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -7369575
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 198867258
       and l.concepto = 400;
    --
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -34960000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 198867258
       and l.concepto = 19;       
    commit;
    --
    vsbsolici := 199962065;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -22500896
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 199962065
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 200566759;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -13600000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 200566759
       and l.concepto = 19;       
    commit;
    --    
    vsbsolici := 201483428;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1965220
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 201483428
       and l.concepto = 400;
    commit;
    --    
    vsbsolici := 201643344;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1965220
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 201643344
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 194065261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -22560000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 194065261
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 186304647;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -41580000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 186304647
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 191226013;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -68461000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 191226013
       and l.concepto = 19;
    commit;     
    --
    vsbsolici := 194066594;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -132480000
     where l.nuano = 2023
       and l.numes = 9
       and l.solicitud = 194066594
       and l.concepto = 19;
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