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
    -- FEBRERO --
    vsbsolici := 10667110;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p  
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 10667110
      and p.tipo = 'Ing_Mig';
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p  
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 191454110
      and p.tipo = 'Ing_Osf';
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -22473000
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 191454110
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -87023860
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 191454110
      and p.concepto = 4;
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -55881740
    where p.nuano = 2023
      and p.numes = 02 
      and p.solicitud = 191454110
      and p.concepto = 400;
    commit;  
    --  
    -- MARZO 
    --
    vsbsolici := 191454110;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p  
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 191454110
      and p.tipo = 'Ing_Osf';
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -45400000
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 191454110
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -124319800
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 191454110
      and p.concepto = 4;
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -72104065
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 191454110
      and p.concepto = 400;
    commit; 
    /**/
    --  
    vsbsolici := 179342664;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 179342664
      and p.interna = 560000;
    commit;
    --
    vsbsolici := 179342664;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 179342664
      and p.tipo = 'Ing_Osf'
      and p.ingreso_report = -24129484;
    commit;
    --
    vsbsolici := 179342664;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 27055408,
          p.ingreso_report = -3559776 
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 179342664
      and p.interna > 0;
    commit;  
    --
    vsbsolici := 179342664;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -21775388
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 1793426640
      and p.carg_x_conex > 0;
    commit;   
    --
    vsbsolici := 189051233;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -381969200
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 189051233
      and p.carg_x_conex > 0;
    commit;   
    --
    vsbsolici := 193798094;
    vsbclasif := '';  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 193798094;
    commit;
    --
    vsbsolici := 196505852;
    vsbclasif := '';  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 196505852;
    commit;
    --
    vsbsolici := 190656698;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 190656698;
    commit;
    --
    vsbsolici := 187578605;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -58087513
    where p.nuano = 2023
      and p.numes = 03 
      and p.solicitud = 187578605
      and p.carg_x_conex > 0;
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