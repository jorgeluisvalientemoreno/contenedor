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
    vsbsolici := 'Elimina';
    vsbclasif := null;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud in (184224811,185318391,188198596,191116700,191628089,192980100,194363561);
    commit;
    --
    vsbsolici := 190246557;
    vsbclasif := 19;
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -17480000
    where p.nuano = 2023
      and p.numes = 02
      and p.solicitud = 190246557
      and p.interna > 0;
    commit;
    --
    vsbsolici := 179342664;
    vsbclasif := 19;
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 26495408
    where p.nuano = 2023
      and p.numes = 01 
      and p.solicitud = 179342664
      and p.interna > 0;
    commit;
    --
    vsbsolici := 179342664;
    vsbclasif := 400;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 179342664
      and p.concepto = 400;
    commit;
    --
    -- Ing. Real
    --
    vsbsolici := 176339488;
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = (p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 176339488
      and p.concepto != 19;
    commit;
    --
    vsbsolici := 182219074;
    vsbclasif := null;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 182219074;
    commit;
    --
    vsbsolici := 183799546;
    vsbclasif := null;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 183799546
      and p.concepto != 19;
    commit;
    --  
    vsbsolici := 183799745;
    vsbclasif := null;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 183799745;
    commit;
    --   
    vsbsolici := 183800007;
    vsbclasif := null;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 183800007
      and p.concepto != 19;
    commit;
    --   
    vsbsolici := 185280342;
    vsbclasif := null;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 185280342;
    commit;
    --     
    vsbsolici := 188194601;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 188194601
      and p.concepto  = 19;
    commit;
    --  
    vsbsolici := 188194601;
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 188194601
      and p.concepto  = 400
      and p.product_id != 52549065;
    commit;
    --    
    vsbsolici := 188699402;
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 188699402
      and p.concepto  = 400;
    commit;
    --  
    vsbsolici := 188699402;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -185858101
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 188699402
      and p.concepto  = 4
      and p.tipo = 'SIN_PRODUCTOS';
    commit;
    -- 
    vsbsolici := 188699402;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -93240000
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 188699402
      and p.concepto  = 19;
    commit;
    -- 
    vsbsolici := 188979361;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 188979361;
    commit;
    --
    vsbsolici := 189051233;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -149183760
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189051233
      and p.concepto = 4;
    commit;
    --  
    vsbsolici := 189051233;
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = -22247760
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189051233
      and p.concepto = 400;
    commit;
    --  
    vsbsolici := 189495322;
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189495322;
    commit;
    --  
    vsbsolici := 189554700;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189554700;
    commit;
    --
    vsbsolici := 189563328;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189563328
      and p.carg_x_conex > 0;
    commit;
    --
    vsbsolici := 189985765;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189985765
      and p.carg_x_conex > 0;
    commit;
    --
    vsbsolici := 189985765;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 189985765
      and p.carg_x_conex > 0;
    commit;
    --
    vsbsolici := 190200929;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 190200929
      and p.ingreso_report = 0;
    commit;
    --
    vsbsolici := 190686635;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 190686635
      and p.product_id != 52492449;
    commit;
    --
    vsbsolici := 190693973;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 190693973;
    commit;
    --  
    vsbsolici := 190752887;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 190752887;
    commit;
    --  
    vsbsolici := 191084645;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 191084645;
    commit;
    --
    vsbsolici := 191645343;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 191645343
      and p.ingreso_report = 0;
    commit;
    --
    vsbsolici := 192024730;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 192024730
      and p.ingreso_report = 0;
    commit;
    --
    vsbsolici := 192024730;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 192024730
      and p.ingreso_report = 0;
    commit;
    --
    vsbsolici := 192028549;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 192028549
      and p.ingreso_report = 0;
    commit;
    --
    vsbsolici := 192079862;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 192079862
      and p.ingreso_report = 0
      and p.product_id not in (52504611, 52504688, 52504691);
    commit;
    --
    vsbsolici := 192283560;
    vsbclasif := 4;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p  
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 192283560
      and rownum < 16;
    commit;
    --
    vsbsolici := 192283560;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 192283560;
    commit;
    --     
    vsbsolici := 192483462;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 192483462;
    commit;
    --
    vsbsolici := 192546153;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 2 
      and p.solicitud = 192546153
      and (
            p.concepto in (19,400)
            OR
            p.concepto = 4 and
            p.product_id != 52517926
          );
    commit;
    --
    vsbsolici := 192790886;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 2 
      and p.solicitud = 192790886
      and p.product_id not in (52529712, 52529730, 52529791, 52529794);
    commit;
    --
    vsbsolici := 193185071;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 2 
      and p.solicitud = 193185071;
    commit;
    --  
    vsbsolici := 193185071;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 2 
      and p.solicitud = 193638382;
    commit;
    --    
    vsbsolici := 194368425;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 194368425
      and p.ingreso_report = 0
      and p.product_id not in (52546832);
    commit;
    --
    vsbsolici := 194380218;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 194380218
      and p.ingreso_report = 0
      and p.product_id not in (52544175,52544198);
    commit;  
    --
    vsbsolici := 194533704;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 194533704;
    commit;
    --
    vsbsolici := 195160412;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p  
      set p.ingreso_report = (p.interna + p.carg_x_conex + p.cert_previa) * -1
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 195160412;
    commit;

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