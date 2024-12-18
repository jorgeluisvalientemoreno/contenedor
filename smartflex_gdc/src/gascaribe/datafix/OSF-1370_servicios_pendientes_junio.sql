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
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 179080527 
      and concepto = 400
      and rownum < 281;
    commit;  
    --
    vsbsolici := 191226013;  
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 191226013 
      and p.tipo = 'Ing_Osf';
    commit;
    --
    vsbsolici := 188723076;  
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 188723076 
      and concepto = 4
      and rownum < 100;
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 58852400,
          p.ingreso_report = -58263876
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 188723076 
      and concepto = 4;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 188723076 
      and concepto = 400
      and rownum < 100;  
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.cert_previa = 8803400,
          p.ingreso_report = -8715366
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 188723076 
      and concepto = 400;            
    commit;
    --
    vsbsolici := 193125608;  
    vsbclasif := 400;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 193125608
      and p.tipo = 'Ing_Osf';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -8435609
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 193125608
      and p.concepto = 400;
    commit;
    --
    vsbsolici := 196014667;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196014667
      and p.tipo = 'Ing_Osf';
    --  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196014667
      and p.concepto = 400
      and rownum < 2;
    --  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196014667
      and p.concepto = 4
      and rownum < 2;     
    --    
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -13658279,
          p.cert_previa = 17686980
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196014667
      and p.concepto = 400;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -111801327,
          p.carg_x_conex = 126567540
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196014667
      and p.concepto = 4;
    commit;
    --
    vsbsolici := 196014667;  
    vsbclasif := '';  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -10612188
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 198888652
      and p.concepto = 4;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -90003584
    where p.nuano = 2023 
      and p.numes in (6) 
      and p.solicitud = 198888652
      and p.concepto = 400;
    commit;
    --
    vsbsolici := 199947301;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 199947301;
    commit;
    --
    vsbsolici := 188198596;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 188198596
      and p.tipo = 'Ing_Osf';
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -72360000
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 188198596
      and p.concepto = 19;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -40045968
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 188198596
      and p.concepto = 400;   
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -268530768
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 188198596
      and p.concepto = 4;        
    commit;
    --
    vsbsolici := 191454110;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.tipo = 'Ing_Osf';
    --  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 19
      and rownum = 1;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 81720000,
          p.ingreso_report = -81720000
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 19;    
    --  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 4
      and rownum = 1;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 223775640,
          p.ingreso_report = -223775640
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 4;
    --  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 400
      and rownum = 1;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 33371640,
          p.ingreso_report = -33371640
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 191454110
      and p.concepto = 400;
    commit;
    --
    vsbsolici := 196636703;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 196636703;
    commit;
    --
    vsbsolici := 181882394;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 181882394;
    commit;
    -- 
    vsbsolici := 199110672;  
    vsbclasif := '';  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -54845934
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 199110672
      and p.concepto = 4
      and p.carg_x_conex = 27422967;
    commit;
    --
    vsbsolici := 189051233;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.tipo = 'Ing_Osf';
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.concepto = 4
      and rownum = 1;
    -- 
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 323231480,
          p.ingreso_report = -323231480
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.concepto = 4;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.concepto = 19
      and rownum = 1; 
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 130000000,
          p.ingreso_report = -141250000
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.concepto = 19;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.concepto = 400
      and rownum = 1;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.cert_previa = 48203480,
          p.ingreso_report = -48203480
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189051233
      and p.concepto = 400;
    commit;
    --
    vsbsolici := 190499453;  
    vsbclasif := '';
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -62370000
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 190499453
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 194066594;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 194066594
      and p.concepto = 19
      and rownum < 3;
    commit;
    --
    vsbsolici := 181882394;  
    vsbclasif := '';
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 181882394;
    commit;
    --
    vsbsolici := 189563328;  
    vsbclasif := '';
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -621599
    where p.nuano = 2023 
      and p.numes in (6)
      and p.solicitud = 189563328
      and p.concepto = 4
      and p.product_id = 52480814;
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