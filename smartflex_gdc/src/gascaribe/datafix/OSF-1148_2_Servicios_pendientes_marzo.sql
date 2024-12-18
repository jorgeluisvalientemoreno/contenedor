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
  vsbsolici := 179342664;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -21775388
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 179342664
     and p.carg_x_conex > 0;
  commit;
  --
  vsbsolici := 179342664;
  vsbclasif := 400;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -3257258
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 179342664
     and p.concepto = 4;
  commit;  
  --
  vsbsolici := 179342664;
  vsbclasif := 400;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -21840000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 179342664
     and p.interna > 0;
  commit;
  --
  vsbsolici := 184224811;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -32000000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 184224811
     and p.interna > 0;
  commit;
  --
  vsbsolici := 184224811;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -32000000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 184224811
     and p.interna > 0;
  commit;
  --
  vsbsolici := 185318391;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -34020000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 185318391
     and p.interna > 0;
  commit;
  --
  vsbsolici := 185318391;
  vsbclasif := 4;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -p.carg_x_conex
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 185318391
     and p.carg_x_conex > 0
     and p.ingreso_report = 0;
  commit;
  --
  vsbsolici := 185318391;
  vsbclasif := 400;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -p.cert_previa
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 185318391
     and p.cert_previa > 0
     and p.ingreso_report = 0;
  commit;  
  --
  vsbsolici := 188198596;
  vsbclasif := 4;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -87023860
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 188198596
     and p.carg_x_conex > 0;
  commit;  
  --
  vsbsolici := 188198596;
  vsbclasif := 4;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -13348656
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 188198596
     and p.cert_previa > 0;
  commit;
  --
  vsbsolici := 188198596;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -45560000
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 188198596
     and p.interna > 0;
  commit;
  --
  vsbsolici := 189593158;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = (p.carg_x_conex + p.cert_previa) * -1
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 189593158
     and p.ingreso_report = 0;
  commit;
  --
  vsbsolici := 191116700;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -p.interna
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 191116700
     and p.ingreso_report = 0;
  commit;
  --
  vsbsolici := 191628089;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -p.interna
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 191628089
     and p.concepto = 19;
  commit;
  --
  vsbsolici := 192695604;
  vsbclasif := 19;   
  insert into open.ldc_osf_serv_pendiente
  select * from open.ldc_osf_serv_pendiente l
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 192695604;
  --
  update open.ldc_osf_serv_pendiente l
     set l.concepto = 400,
         l.cert_previa = 179625
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 192695604
     and rownum = 1;
  --
  update open.ldc_osf_serv_pendiente l
     set l.ingreso_report = -l.interna
   where l.nuano = 2023
     and l.numes = 03
     and l.solicitud = 192695604
     and l.concepto = 19;
  --       
  commit;
  --
  vsbsolici := 192980100;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 192980100;
  commit;
  --
  vsbsolici := 193125608;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -p.interna
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 193125608
     and p.concepto = 19;
  commit;
  --
  vsbsolici := 194101711;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = -p.interna
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 194101711
     and p.concepto = 19;
  commit;
  --
  vsbsolici := 194363561;
  vsbclasif := 19;  
  update OPEN.LDC_OSF_SERV_PENDIENTE p
     set p.ingreso_report = (p.carg_x_conex + p.cert_previa) * -1
   where p.nuano = 2023
     and p.numes = 03 
     and p.solicitud = 194363561;
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

  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/