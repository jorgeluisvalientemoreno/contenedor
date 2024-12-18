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
    -- DICIEMBRE
    vsbsolici := 194065261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = 0
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 194065261
       and l.concepto = 19
       and l.tipo = 'PROD_CONSTRUC';
    commit;
    --
    vsbsolici := 204684760;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3300000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 204684760
       and l.concepto = 19;
    commit;    
    -- ENERO
    vsbsolici := 194065261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -77091440
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 194065261
       and l.concepto = 19;
    commit;
    -- 
    vsbsolici := 204684760;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3300000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 204684760
       and l.concepto = 19;
    commit;
    -- PROVISIONES
    -- 
    vsbsolici := 184235056;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -45640000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 184235056
       and l.concepto = 19;
    commit;    
    -- 
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -185398
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 184235056
       and l.concepto = 4;
    commit;      
    -- 
    vsbsolici := 189554700;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1205087
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 189554700
       and l.concepto = 400;
    commit;    
    -- 
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -8080787
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 189554700
       and l.concepto = 4;
    commit;     
    -- 
    vsbsolici := 194363503;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = (nvl(l.interna,0) + nvl(l.carg_x_conex,0) + nvl(l.cert_previa,0)) * -1
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 194363503;
    commit;    
    --     
    vsbsolici := 198627603;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -29223000
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 198627603;
    commit;    
    --
    vsbsolici := 204058619;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -7031530
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 204058619
       and l.concepto = 4;
    commit;    
    --
    vsbsolici := 204683177;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -11250448
     where l.nuano = 2024
       and l.numes = 1
       and l.solicitud = 204683177
       and l.concepto = 4;
    commit;    
    --
    vsbsolici := 194066594;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -263116661
     where l.nuano = 2024
       and l.numes = 1
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