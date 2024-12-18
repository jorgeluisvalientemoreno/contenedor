CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRBINCRITICA
  BEFORE INSERT ON OR_ORDER_ACTIVITY
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
when ((NEW.PRODUCT_ID IS NOT NULL ) AND (NEW.TASK_TYPE_ID IS NOT NULL ) AND NEW.TASK_TYPE_ID=12619)
Declare

  /*****************************************************************

    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRBINCRITICA

    Descripcion    : Valida si es una orden de critica y marca los cambios de medidor
					           como procesados en la tabla LDC_CTRLLECTURA
    Autor          : DIANA SALTARIN
    Fecha          : 02/05/2022

    Historia de Modificaciones

      Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  sbTraza varchar2(4000);
Begin
  If FBLAPLICAENTREGAXCASO('0000875') Then
     UPDATE LDC_CTRLLECTURA T
        SET FLAG_PROCESADO = 'S',t.PROCESO='OT', t.FEHAPROCESO=sysdate
      WHERE T.NUM_PRODUCTO = :NEW.PRODUCT_ID and t.flag_procesado='N';
  END IF;
Exception
  When ex.controlled_error THEN
    RAISE ex.controlled_error;
  When Others Then
    errors.seterror;
    RAISE ex.controlled_error;
End LDC_TRBINCRITICA;
/
