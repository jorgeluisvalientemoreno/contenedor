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
    -- Ingreso que se provisiono en meses anteriores
    -- CEBE 4158
    --
    vsbsolici := 192184974;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -p.interna
    where p.nuano = 2023
      and p.numes = 04 
      and p.solicitud = 192184974;
    commit;
    --
    vsbsolici := 192616388;
    vsbclasif := 19;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -p.interna
    where p.nuano = 2023
      and p.numes = 04 
      and p.solicitud = 192616388
      and p.concepto = 19;
    commit;
    --
    vsbsolici := 196505852;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -p.carg_x_conex
    where p.nuano = 2023
      and p.numes = 04
      and p.solicitud = 196505852;
    commit;  
    --
    -- CEBE 4101
    vsbsolici := 193798094;
    vsbclasif := 4;  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -p.carg_x_conex
    where p.nuano = 2023
      and p.numes = 04
      and p.solicitud = 193798094;
    commit;
    --
    -- FIN Ingreso que se provisiono en meses anteriores
    --  
    --
    vsbsolici := 197165944;
    vsbclasif := 4;  
    DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 04 
      and p.solicitud = 197165944
      and p.tipo = 'Ing_Osf';  
    --
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -66096382
    where p.nuano = 2023
      and p.numes = 04
      and p.solicitud = 197165944;
    commit;
    --
    vsbsolici := 189051233;
    vsbclasif := 4;  
    DELETE OPEN.LDC_OSF_SERV_PENDIENTE p
    where p.nuano = 2023
      and p.numes = 04 
      and p.solicitud = 189051233
      and p.tipo = 'Ing_Osf';  
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -48018082
    where p.nuano = 2023
      and p.numes = 04
      and p.solicitud = 189051233
      and p.concepto = 400;
    --  
    update OPEN.LDC_OSF_SERV_PENDIENTE p
      set p.ingreso_report = -131250000
    where p.nuano = 2023
      and p.numes = 04
      and p.solicitud = 189051233
      and p.concepto = 19;     
    commit;
    --
    update open.cargos c
      set c.cargunid = 400
    where cargcuco = 3032905666
      and cargdoso = 'PP-189051233' 
      and cargconc in (30);
    commit;
    --
    vsbsolici := 191454110;
    vsbclasif := 19;  
    update open.cargos c
      set c.cargunid = 253
    where cargcuco = 3033188010
      and cargdoso = 'PP-191454110' 
      and cargconc in (30);
    --
    update open.cargos c
      set c.cargunid = 140
    where cargcuco = 3033188010
      and cargdoso = 'PP-191454110' 
      and cargconc in (674); 
    --
    update open.cargos c
       set c.cargunid = 220
     where cargcuco = 3041281082
       and cargdoso = 'PP-191454110' 
       and cargconc in (674);           
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