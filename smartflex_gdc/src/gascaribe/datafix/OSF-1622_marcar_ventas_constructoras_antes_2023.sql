column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  -- Created on 29/09/2023 by EDMUNDO LARA 
  declare 

  -- Cursor con la poblacion de solicitudes a marcar
  Cursor CuMo_Packages is
    select m.package_id, mo.motive_id
      from open.mo_packages m, open.mo_motive mo
    where m.package_type_id = 323
      --and m.package_id = 10745151 
      and m.motive_status_id = 13
      and m.request_date < '01-01-2023'
      and m.package_id not in (SELECT mc.PACKAGE_ID FROM OPEN.MO_COMMENT mc WHERE mc.PACKAGE_ID = m.package_id AND mc.COMMENT_ = 'IGNORAR CARGOS AVANCE OBRA')
      and mo.package_id = m.package_id
      and mo.product_type_id = 6121;
      
  VnuReg number := 0;
  
  
  BEGIN
    
    FOR reg_s IN CuMo_Packages LOOP
  
      MO_BOCOMMENT.ADDCOMMENT(2, REG_S.PACKAGE_ID, 'IGNORAR CARGOS AVANCE OBRA', REG_S.MOTIVE_ID, NULL);
      VnuReg := VnuReg + 1;

    END LOOP;
    --
    commit;
    --
    DBMS_OUTPUT.PUT_LINE('Proceso termina ok - ' || VnuReg || '  SOlicitudes Marcadas');
    --
  EXCEPTION
    WHEN others THEN
    ROLLBACK;
    ERRORS.SETERROR();
    RAISE EX.CONTROLLED_ERROR;

  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/