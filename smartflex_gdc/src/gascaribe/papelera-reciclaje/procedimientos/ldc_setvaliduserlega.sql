CREATE OR REPLACE PROCEDURE LDC_SETVALIDUSERLEGA(  nuOrden          in   OR_ORDER.ORDER_ID%TYPE, --Orden de la instancia
                                                nuTipotrabajoId   in or_order.task_type_id%type,--Id del tipo de trabajo
                                                nuCausalId      in   or_order.causal_id%type--Identificador de la causal
)  AS
  /**************************************************************************

  UNIDAD      :  LDC_PRVALUSERLEGA
  Descripcion :  Plugin para validar usuario de legalizacion
  Autor       :  Antonio Benitez Llorente
  Fecha       :  26-11-2019

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  **************************************************************************/
  PRAGMA AUTONOMOUS_TRANSACTION;
  sbEntrega varchar2(30):='OSS_OL_0000197_2';
BEGIN
  IF fblaplicaentrega(sbEntrega) THEN
  ut_trace.trace('INICIA PROCEDIMIENDO  LDC_SETVALIDUSERLEGA ',5);
    insert into LDC_LOGORPELEGAVALUSER values(SEQ_VALIDUSERLEGA.nextval,nuOrden,nuTipotrabajoId,nuCausalId,sysdate);
    commit;
  ut_trace.trace('FINALIZA  PROCEDIMIENDO  LDC_SETVALIDUSERLEGA ',5);
  END IF;
EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
END LDC_SETVALIDUSERLEGA;
/
