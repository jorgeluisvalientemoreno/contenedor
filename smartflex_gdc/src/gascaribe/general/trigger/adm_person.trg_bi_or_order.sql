CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_OR_ORDER 
AFTER INSERT OR UPDATE OR DELETE ON OPEN.OR_ORDER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

   t_ejecucion VARCHAR2(8);
   i_ejecucion TIMESTAMP(6);
   f_ejecucion TIMESTAMP(6);
   d_ejecucion NUMBER;

ORDER_ID NUMBER(15);
IS_DELETE VARCHAR(1);

BEGIN
  i_ejecucion:=systimestamp;
    IF DELETING THEN
      t_ejecucion := 'DELETE';
      ORDER_ID := :old.order_id;
      IS_DELETE := 'Y';
    ELSE
      ORDER_ID := :new.order_id;
      IS_DELETE := 'N';
      IF INSERTING THEN
        t_ejecucion := 'INSERT';
      ELSE
        t_ejecucion := 'UPDATE';
      END IF;
    END IF;


INSERT INTO LDCBI_OR_ORDER (
 ORDER_ID,
 IS_DELETE
)
VALUES (
 ORDER_ID,
 IS_DELETE
);

	/*f_ejecucion := systimestamp;
        d_ejecucion := TO_NUMBER (EXTRACT(SECOND FROM f_ejecucion - i_ejecucion));
        INSERT INTO OPEN.LDCBI_CAPTURA_METRICAS (nombre_tabla, inicio_ejecucion, fin_ejecucion, tipo_ejecucion, diferencia)
        VALUES('OR_ORDER', i_ejecucion, f_ejecucion, t_ejecucion, d_ejecucion);*/

EXCEPTION
   WHEN OTHERS THEN
       RAISE EX.CONTROLLED_ERROR;
END;
/
