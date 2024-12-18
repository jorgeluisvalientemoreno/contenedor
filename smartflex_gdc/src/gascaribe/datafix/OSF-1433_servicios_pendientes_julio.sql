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
    vsbsolici := 178044449;  
    vsbclasif := 400;
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -32000000,
          p.concepto = 19
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 178044449
      and p.interna > 0;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 178044449
      and p.ingreso_report = -2080000000;
    commit;
    --
    vsbsolici := 179080527;  
    vsbclasif := '';
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -28258914,
          p.cert_previa = 28258914,
          p.carg_x_conex = 0,
          p.tipo = 'SIN_PRODUCTOS'
    where p.nuano = 2023
      and p.numes in (7)
      and p.solicitud = 179080527
      and p.concepto = 400
      and p.carg_x_conex > 0
      and p.tipo = 'Ing_Osf';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.tipo = 'SIN_PRODUCTOS'
    where p.nuano = 2023
      and p.numes in (7)
      and p.solicitud = 179080527
      and p.concepto = 19
      and p.interna > 0
      and p.tipo = 'Ing_Osf';
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.tipo = 'SIN_PRODUCTOS',
          p.ingreso_report = -130063404
    where p.nuano = 2023
      and p.numes in (7)
      and p.solicitud = 179080527
      and p.concepto = 4
      and p.carg_x_conex > 0
      and p.tipo = 'Ing_Osf';
    --    
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 179080527
      and p.tipo = 'Ing_Osf';
    --    
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 179080527
      and p.tipo = 'SIN_PRODUCTOS'
      and p.concepto = 4
      and p.carg_x_conex = 588524;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 179080527
      and p.tipo = 'SIN_PRODUCTOS'
      and p.concepto = 400
      and p.cert_previa = 88034;
    commit;
    --
    vsbsolici := 185280342;  
    vsbclasif := '';  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 185280342
      and p.concepto = 19
      and rownum < 42;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna =  17220000,
          p.ingreso_report = -5740000
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 185280342
      and p.concepto = 19;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 185280342
      and p.concepto = 4
      and p.carg_x_conex != 5594391;
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 8702386,
          p.ingreso_report = -13053579
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 185280342
      and p.concepto = 4;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 185280342
      and p.concepto = 400
      and p.cert_previa != 834291;
    --        
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.cert_previa = 1297786,
          p.ingreso_report = -1946679
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 185280342
      and p.concepto = 400;
    commit;
    --
    vsbsolici := 186394999;  
    vsbclasif := '';  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 186394999       
      and p.concepto = 19;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -52800000,
          p.concepto = 19
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 186394999
      and p.interna > 0;
    commit;
    --  
    vsbsolici := 188580142;  
    vsbclasif := '';  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -53200000
    where p.nuano = 2023 
      and p.numes in (7)
      and p.solicitud = 188580142;
    commit;
    --
    vsbsolici := 190656698;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = p.cert_previa * -1
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 190656698
      and p.concepto = 400
      and p.ingreso_report = -4449552;  
    commit;
    --
    vsbsolici := 190694186;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -92699
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 190694186
      and p.concepto = 400
      and p.ingreso_report = -3986057;
    commit;
    --
    vsbsolici := 193125608;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex =  91375053,
          p.ingreso_report = -93861449
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 193125608
      and p.concepto = 4
      and p.carg_x_conex = 37295940;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex =  5654639,
          p.ingreso_report = -14831840
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 193125608
      and p.concepto = 400
      and p.cert_previa = 5561940;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 193125608
      and p.concepto in (4)
      and p.carg_x_conex < 37295940;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 193125608
      and p.concepto in (400)
      and p.cert_previa < 37295940;
    commit;
    --  
    vsbsolici := 193206355;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 193206355;
    commit;
    --
    vsbsolici := 194066594;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 242880000,
          p.ingreso_report = -88380000
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194066594
      and p.concepto = 19
      and p.interna = 55200000;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194066594
      and p.concepto = 19
      and p.interna < 55200000;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 74591880,
          p.ingreso_report = -65889494
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194066594
      and p.concepto = 4
      and p.carg_x_conex = 59673504;
    --  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194066594
      and p.concepto = 4
      and p.carg_x_conex < 59673504;
    --    
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -9084502
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194066594
      and p.concepto = 400
      and p.cert_previa = 8899104;
    --    
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194066594
      and p.concepto = 400
      and p.cert_previa < 8899104;
    commit;
    --
    vsbsolici := 194826516;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -91996652
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194826516
      and p.concepto = 4
      and p.tipo = 'SIN_PRODUCTOS';
    --  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194826516
      and p.concepto = 4
      and p.tipo = 'Ing_Osf';
    commit;
    --
    vsbsolici := 194831746;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 144210968,
          p.ingreso_report = -144210968
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194831746
      and p.concepto = 4
      and p.tipo = 'SIN_PRODUCTOS'
      and rownum = 1;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194831746
      and p.concepto = 4
      and p.carg_x_conex < 144210968;
    commit;
    --
    vsbsolici := 195160412;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -13053579
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 195160412
      and p.concepto = 4
      and p.tipo = 'SIN_PRODUCTOS';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -1946679
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 195160412
      and p.concepto = 400
      and p.tipo = 'SIN_PRODUCTOS'; 
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 195160412
      and p.tipo = 'Ing_Osf';   
    commit;
    --
    vsbsolici := 195377220;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 195377220;
    commit;
    --
    vsbsolici := 197399572;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 197399572;
    commit;
    --  
    vsbsolici := 197875978;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -23040000
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 197875978;
    commit;
    --
    vsbsolici := 198888652;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 198888652
      and p.tipo = 'Ing_Osf';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -201101758
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 198888652
      and p.concepto = 4;
    --    
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -28299168
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 198888652
      and p.concepto = 400;
    commit;
    --
    vsbsolici := 199110672;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 199110672
      and p.carg_x_conex < 27422967;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 28829273,
          p.ingreso_report = -83008113
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 199110672
      and p.concepto = 4
      and p.carg_x_conex = 27422967;
    commit;
    --
    vsbsolici := 199630784;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 199630784;
    commit;
    --     
    vsbsolici := 199630784;  
    vsbclasif := '';   
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 201178015;
    commit;
    --  
    vsbsolici := 201291278;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 4900000,
          p.ingreso_report = -4900000
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 201291278;
    commit;  
    --
    -- Ingreso real
    --
    vsbsolici := 201291278;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -82051068
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194825000
      and p.tipo = 'SIN_PRODUCTOS';
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 194825000
      and p.concepto = 4
      and p.tipo = 'Ing_Osf';     
    commit;
    --
    vsbsolici := 199237665;  
    vsbclasif := '';   
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -2500000
    where p.nuano = 2023 
      and p.numes in (7) 
      and p.solicitud = 199237665
      and p.concepto = 19;
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