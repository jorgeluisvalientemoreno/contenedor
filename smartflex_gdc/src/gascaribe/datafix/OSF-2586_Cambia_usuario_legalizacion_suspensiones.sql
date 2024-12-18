column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuOrdenes
    IS
    SELECT * FROM LDC_ORDEASIGPROC, or_order 
    WHERE   orapsoge =  order_id
    AND     oraopele = 13754
    AND     order_status_id in (0,5,7)
    AND     oraoproc = 'ENCOCARTRP';
BEGIN
  UPDATE parametros set valor_numerico = 46717, fecha_actualizacion = sysdate
  WHERE codigo = 'PERSONA_LEGALIZA_CARTERA';

  FOR rcOrdenes  IN cuOrdenes LOOP
      dbms_output.put_line('Actualizando Orden: '|| rcOrdenes.orapsoge);
      UPDATE LDC_ORDEASIGPROC
      SET  oraopele = 46717
      WHERE ORAOPROC = 'ENCOCARTRP' and orapsoge =rcOrdenes.orapsoge;
      dbms_output.put_line('Fin Orden: '|| rcOrdenes.orapsoge);
  END LOOP;
  
  COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/