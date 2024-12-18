column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  CURSOR cuDatos IS
    SELECT
    a.package_id,
    a.product_id,
    a.subscription_id,
    o.order_id,
    o.created_date,
    o.order_status_id,
    o.operating_unit_id
FROM
    open.or_order_activity a,
    open.or_order          o
WHERE
    a.order_id IN ( 325549054, 325550291, 325550290, 325550288, 327231938,
                    330146937, 325550277, 325550287, 325550278, 328918838,
                    192198175, 325550289, 328918842, 332055435, 327229974,
                    325550285, 192198184, 325550280, 192198181, 192198177,
                    192198180, 192198185, 192198182, 325550286, 327230970,
                    327231953, 328918836, 192198179, 327231948, 328918834,
                    330146945, 192198178, 192198183, 192198176, 333733788,
                    192198174, 333733793, 335410072, 335410079, 335410082,
                    335410091, 334677022, 327230970, 327229974, 325549812,
                    332055435, 328922563, 325549812, 327230980, 325547324,
                    327229305, 328918337, 328918341, 325547325, 327229306,
                    327229694, 325547323, 327229304, 327229984, 327230980,
                    327229984, 335407851, 330145890, 330146308, 330145890,
                    285762266, 285762207, 285762127, 285762249, 285762020,
                    315542709, 313920043, 285762025, 285761990, 285762094,
                    285762018, 285762159, 285762121, 285761962, 285762086 )
    AND a.order_id = o.order_id
ORDER BY
    package_id;

  sbOrderCommen varchar2(4000) := 'Se cambia estado a anulado por caso OSF-3194';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);
BEGIN

  FOR reg IN cudatos LOOP
    BEGIN
      dbms_output.put_line('Orden: ' || reg.order_id);
      
	  or_boanullorder.anullorderwithoutval(reg.order_id, SYSDATE);
    
      OS_ADDORDERCOMMENT(reg.order_id, nuCommentType, sbOrderCommen, nuErrorCode, sbErrorMesse);
	  
      IF (nuErrorCode = 0) THEN
        COMMIT;
        dbms_output.put_line('Se anulo OK orden: ' || reg.order_id);
      ELSE
        ROLLBACK;
        dbms_output.put_line('Error anulando orden: ' || reg.order_id || ' : ' || sbErrorMesse);
      END IF;
    
	EXCEPTION
      WHEN OTHERS THEN
        dbms_output.put_line('Error OTHERS anulando orden: ' || reg.order_id || ' : ' || sqlerrm);
        ROLLBACK;
    END;
  END LOOP;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/