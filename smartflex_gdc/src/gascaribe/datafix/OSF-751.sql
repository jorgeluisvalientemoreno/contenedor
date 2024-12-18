column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    --<< Datos Falla 193469582  
    nuIdFalla_1                 NUMBER := 193469582;
    nuTiempoCompensado_1        NUMBER := 400;
    dtNuevaFechaFin_Atencion_1  DATE := to_date('17/11/2022 19:05:00', 'DD/MM/YYYY HH24:MI:SS');
    dtNuevaFechaAtencion_1      DATE := to_date('17/11/2022 19:06:00', 'DD/MM/YYYY HH24:MI:SS');
    -->>
    
    --<< Datos Falla 193747008 
    nuIdFalla_2                 NUMBER := 193747008;
    nuTiempoCompensado_2        NUMBER := 1442;
    dtNuevaFechaFin_Atencion_2  DATE := to_date('26/11/2022 12:30:00', 'DD/MM/YYYY HH24:MI:SS');
    dtNuevaFechaAtencion_2      DATE := to_date('26/11/2022 12:31:00', 'DD/MM/YYYY HH24:MI:SS');
    -->>
    
    -- Poblacion a la que aplica el Datafix
    cursor cuData_TTDamage(inuIdFalla number)
    is
    SELECT * FROM OPEN.TT_DAMAGE WHERE PACKAGE_ID = inuIdFalla;
    
    cursor cuData_TTDamageProd(inuIdFalla number)
    is    
    SELECT * FROM OPEN.TT_DAMAGE_PRODUCT WHERE PACKAGE_ID = inuIdFalla;

    cursor cuData_Timeout_Comp(inuIdFalla number)
    is    
    SELECT * FROM OPEN.PR_TIMEOUT_COMPONENT WHERE PACKAGE_ID = inuIdFalla;

    cursor cuData_Solicitud(inuIdFalla number)
    is
    SELECT  mo_packages.*
    FROM    OPEN.mo_packages, 
            OPEN.tt_damage    
    WHERE   tt_damage.package_id = mo_packages.package_id
    AND     mo_packages.package_id = inuIdFalla 
    AND     mo_packages.package_type_id = 57;
    
begin
  dbms_output.put_line('---- Inicio OSF-751 ----');

  dbms_output.put_line(' ---------------------------->> FALLA # 1 - INICIO'); 
  for reg_1 in cuData_TTDamage(nuIdFalla_1)
  loop
    update  OPEN.TT_DAMAGE 
    set     TT_DAMAGE.END_DATE = dtNuevaFechaFin_Atencion_1
    WHERE   PACKAGE_ID = reg_1.PACKAGE_ID;
    dbms_output.put_line('[OPEN.TT_DAMAGE.END_DATE] Se actualiza la Fecha de Fin de Afectacion para la falla '||nuIdFalla_1||' - Fecha Actual ['||reg_1.END_DATE||'] Nueva Fecha ['||dtNuevaFechaFin_Atencion_1||']');
  end loop;
  commit;
  dbms_output.put_line('');
  
  for reg_2 in cuData_TTDamageProd(nuIdFalla_1)
  loop
    update  OPEN.TT_DAMAGE_PRODUCT
    set     TT_DAMAGE_PRODUCT.ATENTION_DATE = dtNuevaFechaFin_Atencion_1,
            TT_DAMAGE_PRODUCT.COMPENSATED_TIME = nuTiempoCompensado_1
    WHERE   PACKAGE_ID = reg_2.PACKAGE_ID
    AND     PRODUCT_ID = reg_2.PRODUCT_ID;
    dbms_output.put_line('[OPEN.TT_DAMAGE_PRODUCT] Se actualiza la FECHA DE ATENCIÓN para la falla '||nuIdFalla_1||' y el producto ['||reg_2.PRODUCT_ID||'] - Fecha Actual ['||reg_2.ATENTION_DATE||'] Nueva Fecha ['||dtNuevaFechaFin_Atencion_1||'] - tiempo compensado actual ['||reg_2.COMPENSATED_TIME||'] - Nuevo tiempo compensado ['||nuTiempoCompensado_1||']');
  end loop;
  commit;  
  dbms_output.put_line('');
  
  for reg_3 in cuData_Timeout_Comp(nuIdFalla_1)
  loop
    update  OPEN.PR_TIMEOUT_COMPONENT
    set     pr_timeout_component.FINAL_DATE = dtNuevaFechaFin_Atencion_1,
            pr_timeout_component.COMPENSATED_TIME = nuTiempoCompensado_1
    WHERE   PACKAGE_ID = reg_3.PACKAGE_ID
    AND     COMPONENT_ID = reg_3.COMPONENT_ID;
    dbms_output.put_line('[OPEN.PR_TIMEOUT_COMPONENT] Se actualiza la FECHA FINAL DEL RANGO para la falla '||nuIdFalla_1||' y el componente ['||reg_3.COMPONENT_ID||'] - Fecha Actual ['||reg_3.FINAL_DATE||'] Nueva Fecha ['||dtNuevaFechaFin_Atencion_1||'] tiempo compensado actual ['||reg_3.COMPENSATED_TIME||'] - Nuevo tiempo compensado ['||nuTiempoCompensado_1||']');
  end loop;
  commit;
  dbms_output.put_line('');
  
  for reg_4 in cuData_Solicitud(nuIdFalla_1)
  loop
    update  OPEN.MO_PACKAGES
    set     MO_PACKAGES.ATTENTION_DATE = dtNuevaFechaAtencion_1
    WHERE   MO_PACKAGES.PACKAGE_ID = reg_4.PACKAGE_ID;
    dbms_output.put_line('[OPEN.MO_PACKAGES] Se actualiza la FECHA FINAL DE ATENCION para la falla '||nuIdFalla_1||' - Fecha Actual ['||reg_4.ATTENTION_DATE||'] Nueva Fecha ['||dtNuevaFechaAtencion_1||']');
  end loop;
  commit;
  dbms_output.put_line(' ---------------------------->> FALLA # 1 - FIN');
  
  dbms_output.put_line('');
  dbms_output.put_line('');

  dbms_output.put_line(' ---------------------------->> FALLA # 2 - INICIO');
  for reg_1 in cuData_TTDamage(nuIdFalla_2)
  loop
    update  OPEN.TT_DAMAGE 
    set     TT_DAMAGE.END_DATE = dtNuevaFechaFin_Atencion_2
    WHERE   PACKAGE_ID = reg_1.PACKAGE_ID;
    dbms_output.put_line('[OPEN.TT_DAMAGE.END_DATE] Se actualiza la Fecha de Fin de Afectacion para la falla '||nuIdFalla_2||' - Fecha Actual ['||reg_1.END_DATE||'] Nueva Fecha ['||dtNuevaFechaFin_Atencion_2||']');
  end loop;
  commit;
  dbms_output.put_line('');
  
  for reg_2 in cuData_TTDamageProd(nuIdFalla_2)
  loop
    update  OPEN.TT_DAMAGE_PRODUCT
    set     TT_DAMAGE_PRODUCT.ATENTION_DATE = dtNuevaFechaFin_Atencion_2,
            TT_DAMAGE_PRODUCT.COMPENSATED_TIME = nuTiempoCompensado_2
    WHERE   PACKAGE_ID = reg_2.PACKAGE_ID
    AND     PRODUCT_ID = reg_2.PRODUCT_ID;
    dbms_output.put_line('[OPEN.TT_DAMAGE_PRODUCT] Se actualiza la FECHA DE ATENCIÓN para la falla '||nuIdFalla_2||' y el producto ['||reg_2.PRODUCT_ID||'] - Fecha Actual ['||reg_2.ATENTION_DATE||'] Nueva Fecha ['||dtNuevaFechaFin_Atencion_2||'] - tiempo compensado actual ['||reg_2.COMPENSATED_TIME||'] - Nuevo tiempo compensado ['||nuTiempoCompensado_2||']');
  end loop;
  commit;  
  dbms_output.put_line('');
  
  for reg_3 in cuData_Timeout_Comp(nuIdFalla_2)
  loop
    update  OPEN.PR_TIMEOUT_COMPONENT
    set     pr_timeout_component.FINAL_DATE = dtNuevaFechaFin_Atencion_2,
            pr_timeout_component.COMPENSATED_TIME = nuTiempoCompensado_2
    WHERE   PACKAGE_ID = reg_3.PACKAGE_ID
    AND     COMPONENT_ID = reg_3.COMPONENT_ID;
    dbms_output.put_line('[OPEN.PR_TIMEOUT_COMPONENT] Se actualiza la FECHA FINAL DEL RANGO para la falla '||nuIdFalla_2||' y el componente ['||reg_3.COMPONENT_ID||'] - Fecha Actual ['||reg_3.FINAL_DATE||'] Nueva Fecha ['||dtNuevaFechaFin_Atencion_2||'] tiempo compensado actual ['||reg_3.COMPENSATED_TIME||'] - Nuevo tiempo compensado ['||nuTiempoCompensado_2||']');
  end loop;
  commit;
  dbms_output.put_line('');
  
  for reg_4 in cuData_Solicitud(nuIdFalla_2)
  loop
    update  OPEN.MO_PACKAGES
    set     MO_PACKAGES.ATTENTION_DATE = dtNuevaFechaAtencion_2
    WHERE   MO_PACKAGES.PACKAGE_ID = reg_4.PACKAGE_ID;
    dbms_output.put_line('[OPEN.MO_PACKAGES] Se actualiza la FECHA FINAL DE ATENCION para la falla '||nuIdFalla_2||' - Fecha Actual ['||reg_4.ATTENTION_DATE||'] Nueva Fecha ['||dtNuevaFechaAtencion_2||']');
  end loop;
  commit;
  dbms_output.put_line(' ---------------------------->> FALLA # 2 - FIN');
  COMMIT;
  dbms_output.put_line('---- Fin OSF-751 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-751 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/