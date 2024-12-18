BEGIN
  update OPEN.SA_TAB A
     set CONDITION = '1 = (select count(1)
  from open.pr_product b
 where b.product_id in (select a.product_id
                          from open.pr_prod_suspension a
                         where a.suspension_type_id = 14
                           and a.active = ''Y''
                           and a.product_id = :PRODUCT_ID:
                           and rownum = 1)
                           and b.product_status_id = 2
                           and rownum = 1)'
   where TAB_ID = 336470
     and TAB_NAME = 'PRODUCT'
     and PROCESS_NAME = 'P_CERTIFICACION_POR_SERVICIOS_NUEVOS_100314'
     and APLICA_EXECUTABLE = 'CNCRM';

  COMMIT;

  DBMS_OUTPUT.put_line('Actualizacion de la visualizacion Ok.');

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('No se pudo actualizar la condicion de visualizacion');
END;
/
