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
    WHERE a.order_id IN (318647946)
      and a.order_id = o.order_id
    order by package_id;

   -- Cursor para validar que la OT no este en acta
    CURSOR cuacta(nuorden NUMBER) is
    SELECT d.id_acta
    FROM  ge_detalle_acta d
    WHERE d.id_orden = nuorden
    AND rownum = 1;

    sbOrderCommen   VARCHAR2(4000) := 'Se cambia estado a anulado por caso OSF-2509';
    nuCommentType   NUMBER := 1277;
    nuErrorCode     NUMBER;
    sbErrorMesse    VARCHAR2(4000);
    nuacta          NUMBER;

    RCITEMMOV           DAOR_UNI_ITEM_BALA_MOV.STYOR_UNI_ITEM_BALA_MOV;
    RCSERIALITEM        DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;

    NUDOCUMENTO         GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE;
    NUUNIITEMMOVID      OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE;
    INUOPERATINGUNIT    OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE := 799;

    CURSOR cuMovimiento
    (
        inuItemsSeriado IN OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO%TYPE,
        inuSolicitud    IN GE_ITEMS_DOCUMENTO.PACKAGE_ID%TYPE
    )
    IS
    SELECT  B.*, B.ROWID
    FROM    GE_ITEMS_DOCUMENTO A,
            OR_UNI_ITEM_BALA_MOV B
    WHERE   B.ID_ITEMS_DOCUMENTO = A.ID_ITEMS_DOCUMENTO
    AND     A.PACKAGE_ID = inuSolicitud
    AND     A.DOCUMENT_TYPE_ID = 107
    AND     B.MOVEMENT_TYPE = 'I'
    AND     B.ID_ITEMS_SERIADO = inuItemsSeriado;
BEGIN

	dbms_output.put_line('Inicia OSF-2509');

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

              WF_BOAnswer_Receptor.AnswerReceptor(-1749711879,MO_BOCausal.fnuGetSuccess); 
              UPDATE ge_items_seriado set id_items_estado_inv = 1 where id_items_seriado in (2083974);

              DELETE FROM GE_TECH_SERVICE_DET WHERE tech_service_det_id = 6397;

              UPDATE or_order_activity set package_id = NULL, serial_items_id = NULL WHERE order_id = reg.order_id;

              OPEN cuMovimiento(2083974,211618055);
              FETCH cuMovimiento INTO RCITEMMOV;
              CLOSE cuMovimiento;

              RCSERIALITEM := DAGE_ITEMS_SERIADO.FRCGETRECORD(2083974);

              IF (RCITEMMOV.TARGET_OPER_UNIT_ID <> RCITEMMOV.OPERATING_UNIT_ID) THEN
                    OR_BOITEMSMOVE.REGISTERITEMSMOVE
                    (
                        RCITEMMOV.TARGET_OPER_UNIT_ID,
                        INUOPERATINGUNIT,
                        RCSERIALITEM.ITEMS_ID,
                        RCSERIALITEM,
                        OR_BOITEMSMOVE.CSBINCREASEMOVETYPE,
                        GE_BOITEMSCONSTANTS.CNUMOVCAUSAINGTECSER,
                        NUDOCUMENTO,
                        1,
                        RCSERIALITEM.COSTO,
                        NULL,
                        RCITEMMOV.INIT_INV_STAT_ITEMS,
                        NUUNIITEMMOVID
                    );
                END IF;

                OR_BOITEMSMOVE.REGISTERITEMSMOVE
                (
                    INUOPERATINGUNIT,
                    RCITEMMOV.TARGET_OPER_UNIT_ID,
                    RCSERIALITEM.ITEMS_ID,
                    RCSERIALITEM,
                    OR_BOITEMSMOVE.CSBDECREASEMOVETYPE,
                    GE_BOITEMSCONSTANTS.CNUMOVCAUSASALTECSER,
                    NUDOCUMENTO,
                    1,
                    RCSERIALITEM.COSTO,
                    NULL,
                    RCITEMMOV.INIT_INV_STAT_ITEMS,
                    NUUNIITEMMOVID
                );

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
  
	dbms_output.put_line('Inicia OSF-2509');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/