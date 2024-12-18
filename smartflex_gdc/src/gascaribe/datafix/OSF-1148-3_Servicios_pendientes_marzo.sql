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
  -- CEBE 4158
  vsbsolici := 197113361;
  vsbclasif := 19;   
  insert into open.ldc_osf_serv_pendiente
  select * from open.ldc_osf_serv_pendiente l
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 192695604
     and l.concepto = 19;
  --
  update open.ldc_osf_serv_pendiente l
     set l.interna = 29920000,
         l.solicitud = 197113361,
         l.ingreso_report = 0
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 192695604
     and l.concepto = 19
     and rownum = 1;
  commit;
  -- END 4158
  -- CEBE 4121
  vsbsolici := 179342664;
  vsbclasif := 4;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -21775388
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 179342664
     and p.concepto = 4;
  --
  vsbsolici := 179342664;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -22960000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 179342664
     and p.concepto = 19;
  --
  vsbsolici := 179342664;
  vsbclasif := 400;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -3257258
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 179342664
     and p.concepto = 400;     
  commit;
  -- END 4121
  --
  -- CEBE 4106
  --
  vsbsolici := 176339488;
  vsbclasif := 19;  
  DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 176339488
     and p.concepto = 19
     and ROWNUM = 1;
  --
  vsbsolici := 176339488;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.interna = 44080000,
         p.ingreso_report = -3520000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 176339488
     and p.concepto = 19;
  commit;
  --END 4106
  --
  -- CEBE 4127
  vsbsolici := 191454110;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -65151640
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 191454110
     and p.concepto = 400;
  commit;
  --
  vsbsolici := 188198596;
  vsbclasif := 19;  
  DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 188198596
     and p.tipo = 'Ing_Osf';
  --
  vsbsolici := 188198596;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 188198596; 
  commit;
  --
  -- CEBE 4101
  vsbsolici := 187578605;
  vsbclasif := 400;  
  DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 187578605
     and p.tipo = 'Ing_Osf';
  --
  vsbsolici := 187578605;
  vsbclasif := 4;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -26728757
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 187578605
     and p.concepto = 4;
  --
  vsbsolici := 187578605;
  vsbclasif := 400;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -p.cert_previa
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 187578605
     and p.concepto = 400;     
  commit;  
  --
  vsbsolici := 192695604;
  vsbclasif := 400;   
  update open.ldc_osf_serv_pendiente l
     set l.interna = 0
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 192695604
     and l.concepto = 400;
  commit;
  --
  vsbsolici := 194101711;
  vsbclasif := 400;   
  insert into open.ldc_osf_serv_pendiente
  select * from open.ldc_osf_serv_pendiente l
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 194101711
     and l.concepto = 19;
  --
  update open.ldc_osf_serv_pendiente l
     set l.cert_previa = 215000,
         l.concepto = 400,
         l.ingreso_report = 0
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 194101711
     and l.concepto = 19
     and rownum = 1;
  commit;
  --
  vsbsolici := 10644178;
  vsbclasif := 400;   
  update open.ldc_osf_serv_pendiente l
     set l.ingreso_report = l.ingreso_report * -1
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 10644178
     and l.tipo = 'Ing_Mig';
  commit;
  --
  vsbsolici := 175331403;
  vsbclasif := 19;   
  update open.ldc_osf_serv_pendiente l
     set l.ingreso_report = l.interna * -1
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 175331403;
  commit;
  --
  vsbsolici := 189051233;
  vsbclasif := 19;  
  delete OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 189051233
     and p.tipo = 'Ing_Osf';
  --
  vsbsolici := 189051233;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -285935540
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 189051233
     and p.concepto = 4;
  --
  vsbsolici := 189051233;
  vsbclasif := 4;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -96250000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 189051233
     and p.concepto = 19;
  --
  vsbsolici := 189051233;
  vsbclasif := 4;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -42641540
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 189051233
     and p.concepto = 400;     
  commit;
  --
  vsbsolici := 10667110;
  vsbclasif := 19;  
  delete OPEN.LDC_OSF_SERV_PENDIENTE p
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 10667110
     and p.tipo = 'Ing_Mig';
  commit;
  --  
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