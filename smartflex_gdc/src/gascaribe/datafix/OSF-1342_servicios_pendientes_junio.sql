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
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -22080000,
          p.interna = 99360000
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 194066594
      and p.concepto = 19;
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 194066594
      and p.tipo = 'Ing_Osf';
    --       
    commit;
    --
    vsbsolici := 194831746;
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (6)
      and p.solicitud = 194831746
      and rownum < 232;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -109401424,
          p.carg_x_conex = 144210968
    where p.nuano = 2023
      and p.numes in (6)
      and p.solicitud = 194831746;
    --
    commit; -- ok
    --  
    vsbsolici := 179080527;
    vsbclasif := 19;  
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (6)
      and p.solicitud = 179080527
      and p.concepto is NULL;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.interna = 147500000,
          p.ingreso_report = -147500000
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 179080527
      and p.concepto = 19;
    --
    vsbclasif := 4;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano >= 2022 
      and p.numes in (6) 
      and p.solicitud = 179080527 
      and concepto = 4 
      and rownum < 462;
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex = 188916204,
          p.ingreso_report = -82981484
    where p.nuano >= 2022 
      and p.numes in (6) 
      and p.solicitud = 179080527 
      and concepto = 4;
    --
    vsbclasif := 400;
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano >= 2022 
      and p.numes in (6) 
      and p.solicitud = 179080527 
      and concepto = 400
      and rownum < 221;
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.carg_x_conex =  28258914,
          p.ingreso_report = -24737554
    where p.nuano >= 2022 
      and p.numes in (6) 
      and p.solicitud = 179080527 
      and concepto = 400;
    --
    commit;
    -- 
    -- Ingreso Real
    vsbsolici := 198888652;
    vsbclasif := 4;  
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 198888652
      and p.tipo = 'Ing_Osf';
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -33751344
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 198888652
      and p.concepto = 4;
    --
    vsbclasif := 400;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -4716528
    where p.nuano >= 2022 
      and p.numes in (6) 
      and p.solicitud = 198888652 
      and concepto = 400;     
    commit;  
    --
    vsbsolici := 199110672;
    vsbclasif := 4;  
    --
    delete OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 199110672
      and p.tipo = 'Ing_Osf';
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -55567590
    where p.nuano = 2023
      and p.numes in (6) 
      and p.solicitud = 199110672
      and p.concepto = 4
      and p.carg_x_conex = 27422967;
    commit;
    --
    vsbsolici := 199237665;
    vsbclasif := 19;
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -p.interna
    where p.nuano = 2023
      and p.numes in (6) 
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