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
    vsbsolici := 203722330;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -17578825
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 203722330
       and l.concepto = 4
       and rownum = 1;
    commit;
    --
    vsbsolici := 203753930;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -29532426
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 203753930
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 203818297;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -687827
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 203818297
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 201975403;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -7734683
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 201975403
       and l.concepto = 4;
    commit;
    --  
    vsbsolici := 203360962;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -5920000
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 203360962
       and l.concepto = 19;
    commit;
    --     
    vsbsolici := 201483428;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -14063060
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 201483428
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 194066594;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -176640000
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 194066594
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 194065261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -45120000
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud = 194065261
       and l.concepto = 19;
    commit;
    -- CEBE 4104
    vsbsolici :=  195980358;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -25725000
     where l.nuano = 2023
       and l.numes = 10
       and l.solicitud =  195980358
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