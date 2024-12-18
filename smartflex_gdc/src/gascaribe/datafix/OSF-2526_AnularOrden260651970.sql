column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuDatos IS
    SELECT a.package_id,
          a.product_id,
          a.subscription_id,
          o.order_id,
          o.created_date,
          o.order_status_id,
          o.operating_unit_id
    FROM or_order_activity a, or_order o
    WHERE a.order_id IN (260651970)
      and a.order_id = o.order_id
    order by package_id;

   -- Cursor para validar que la OT no este en acta
    CURSOR cuacta(nuorden NUMBER) is
    SELECT d.id_acta
    FROM  ge_detalle_acta d
    WHERE d.id_orden = nuorden
    AND rownum = 1;

    sbOrderCommen   VARCHAR2(4000) := 'Se cambia estado a anulado por caso OSF-2526';
    nuCommentType   NUMBER := 1277;
    nuErrorCode     NUMBER;
    sbErrorMesse    VARCHAR2(4000);
    nuacta          NUMBER;
BEGIN

	dbms_output.put_line('Inicia OSF-2526');

	FOR reg IN cudatos LOOP

      IF cuacta%isopen THEN
        CLOSE cuacta;
      END IF;

      OPEN cuacta(reg.order_id);
      FETCH cuacta INTO nuacta;
      CLOSE cuacta;

      IF nuacta is not null THEN
          dbms_output.put_line('Orden esta en acta ' || reg.order_id|| ' Acta : ' || nuacta);
      ELSE
          BEGIN
            dbms_output.put_line('Orden: ' || reg.order_id);
            
            api_anullorder(reg.order_id,
                    nuCommentType,
                    sbOrderCommen,
                    nuErrorCode,
                    sbErrorMesse
                    );
            
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
      END IF;
	  END LOOP;
  
	dbms_output.put_line('Inicia OSF-2526');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/