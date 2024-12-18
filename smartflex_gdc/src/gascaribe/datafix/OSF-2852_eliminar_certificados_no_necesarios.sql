column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1661');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  cursor cuPoblacion is
    select pc.certificate_id,
           pc.product_id,
           pc.package_id,
           pc.order_act_certif_id,
           pc.order_act_cancel_id,
           pc.register_date,
           pc.review_date,
           pc.estimated_end_date,
           pc.end_date,
           pc.order_act_review_id
      from open.PR_CERTIFICATE pc
     where pc.product_id in (select sesunuse
                               from open.servsusc
                              where sesususc in (48240113,
                                                 66284764,
                                                 66500302,
                                                 66500386,
                                                 66503544,
                                                 66573101,
                                                 66574613,
                                                 66574616,
                                                 66575436,
                                                 66657889,
                                                 66667827,
                                                 66675298,
                                                 66684653,
                                                 66694571,
                                                 66700171,
                                                 66709241,
                                                 66716395,
                                                 66716992,
                                                 66718693,
                                                 66734282,
                                                 66734293,
                                                 66780583,
                                                 66843647,
                                                 66846673,
                                                 66863723,
                                                 66864297,
                                                 66871899,
                                                 66896980,
                                                 66910423)
                                and sesuserv = 7014);

  reg_poblacion cuPoblacion%rowtype;

BEGIN
  dbms_output.put_line('---- Inicia OSF-2852 ----');

  FOR reg_poblacion IN cuPoblacion LOOP
  
    --Elimina certificado
    BEGIN
    
      DELETE OPEN.PR_CERTIFICATE C
       where C.CERTIFICATE_ID = reg_poblacion.CERTIFICATE_ID
         AND C.PRODUCT_ID = reg_poblacion.product_id;
    
      COMMIT;
    
      DBMS_OUTPUT.PUT_LINE('El certificado del Producto [' ||
                           reg_poblacion.product_id || '] fue retirado.');
    
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('ERROR [PR_CERTIFICATE] - ' || ' Producto [' ||
                             reg_poblacion.product_id ||
                             '] eliminando el certificado' ||
                             ' Error --> ' || sqlerrm);
    END;
  
  END LOOP;

  dbms_output.put_line('---- Fin OSF-2852 ----');

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-2852 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/