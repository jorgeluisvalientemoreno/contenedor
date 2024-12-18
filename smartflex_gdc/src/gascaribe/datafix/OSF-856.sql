column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  CURSOR cuOrdenes
  IS
  SELECT  * 
  FROM     or_order
  WHERE order_id in (
    155516859,
    155516863,
    155516864,
    155516865,
    155516867,
    155516868,
    155516870,
    155516871,
    155516872,
    155516873,
    155516875,
    155516876,
    155516878,
    155516879,
    155516880,
    155516881,
    155516883,
    155516884,
    155516885,
    155516887,
    155516888,
    155516890,
    155516891,
    155516892,
    155516895,
    155516896,
    155516898,
    155516899,
    155516900,
    155516903,
    155516904,
    155516905,
    155516906,
    155516907,
    155516908,
    155516909,
    155516911,
    155516912,
    155516913,
    155516916,
    155516917,
    155516918,
    155516919,
    155516920,
    155516921,
    155516924,
    155516925,
    155516926,
    155575212,
    155575227,
    155575231,
    155575232,
    155575238,
    155575241,
    168195612,
    168196004,
    168196299,
    168191295,
    168191388,
    168191486,
    168191611,
    168191668,
    168191717,
    168191738,
    168191755,
    168191832,
    168191894,
    168191943
       );

    CURSOR cuDOCUORDER
    (
      inuOrder  or_order.order_id%TYPE
    )
    IS
    SELECT count(order_id)
    FROM LDC_DOCUORDER
    WHERE order_id = inuOrder;

    nuCantidad NUMBER;
   
begin
  
  FOR reg in cuOrdenes LOOP

    OPEN cuDOCUORDER(reg.order_id);
    FETCH cuDOCUORDER INTO nuCantidad;
    CLOSE cuDOCUORDER;

    IF (nuCantidad = 0) THEN
      INSERT INTO LDC_DOCUORDER
        (ORDER_ID, STATUS_DOCU, FILE_DATE)
      Values
        (reg.order_id, 'AR', SYSDATE);

      INSERT INTO LDC_AUDOCUORDER
          (usuario,
           terminal,
           fecha_cambio,
           order_id,
           estado_anterior,
           nuevo_estado)
        VALUES
          ('OSF-856',
           'DATAFIX',
           sysdate,
           reg.order_id,
           'AR',
           'AR');
    END IF;
  END LOOP;
  
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/