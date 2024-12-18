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
    vsbsolici := 194066594;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -241036661
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 194066594
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 194065261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -77091440
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 194065261
       and l.concepto = 19;
    commit;
    --   
    vsbsolici := 197444261;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -28700000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 197444261
       and l.concepto = 19;
    commit;
    --     
    -- INgreso REAL
    --
    vsbsolici := 188194601;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -54700712
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 188194601
       and l.concepto = 4;
    commit;
    --       
    vsbsolici := 195263154;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3021180
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 195263154
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 196110115;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -2634051
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 196110115
       and l.concepto = 19;
    commit;
    --    
    vsbsolici := 198134848;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -11250480
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 198134848
       and l.concepto = 4;
    commit;
    --     
    vsbsolici := 198837749;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -4800000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 198837749
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 199768407;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -113207633
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 199768407
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 200715315;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -35750000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 200715315
       and l.concepto = 19;
    commit;
    --    
    vsbsolici := 200715350;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -250000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 200715350
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 202574399;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3032000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 202574399
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 203098446;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -17578825
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 203098446
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -3537396
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 203098446
       and l.concepto = 400;       
    commit;
    --
    vsbsolici := 203360962;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -11250448
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 203360962
       and l.concepto = 4;
    --
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1572176
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 203360962
       and l.concepto = 400;       
    commit;
    --
    vsbsolici := 203879836;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -578338
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 203879836
       and l.concepto = 4;
    commit;
    --
    vsbsolici := 204058619;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -982610
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 204058619
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 204150734;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -1866959
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 204150734
       and l.concepto = 400;
    commit;
    --    
    vsbsolici := 204172968;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -4160000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 204172968
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 204683177;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -4800000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 204683177
       and l.concepto = 19;
    commit;
    --
    vsbsolici := 204684760;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -2640000
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 204684760
       and l.concepto = 19;
    commit;
    --  
    vsbsolici := 206458609;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.Ingreso_Report = -23204049
     where l.nuano = 2023
       and l.numes = 12
       and l.solicitud = 206458609
       and l.concepto = 4;
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