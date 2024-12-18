create or replace TRIGGER ADM_PERSON.TRG_LDC_OT_DOBLES BEFORE UPDATE
  ON OPEN.GE_ACTA FOR EACH ROW
/************************************************************************************************************
  Autor       : jhinestroza
  Fecha       : 02-02-2023
  Proceso     : TRG_LDC_OT_DOBLES
  Ticket      : OSF-895
  Descripcion : Trigger para no permitir el cierre de un acta si esta presenta ordenes que se encuentran
                vinculadas a una o varias actas

  Historia de Modificaciones
  Fecha               Autor                             Modificacion
  =========           =========                      ====================
  02-02-2023          jhinestroza                    CREACION
 *************************************************************************************************************/  
DECLARE
    nuCantidadOtActas number;
    
    cursor cuOtActas(inuIdActa OPEN.GE_ACTA.ID_ACTA%TYPE)  is
    select  *
    from    open.ct_order_certifica
    where   certificate_id = inuIdActa;
    
    cursor cuValidacion(nuOrderId number) is
    select  count(certificate_id) as cantidad
    from    open.ct_order_certifica
    where   order_id = nuOrderId;
        
BEGIN
    ut_trace.trace('INICIA LOG TRG_LDC_OT_DOBLES ',5);
    IF updating THEN
        IF (:OLD.ESTADO = 'A') AND (:NEW.ESTADO = 'C') THEN
            FOR reg in cuOtActas(:NEW.ID_ACTA)
            LOOP
                -- reset de variables
                nuCantidadOtActas := 0;
                
                OPEN cuValidacion(reg.order_id);
                FETCH cuValidacion into nuCantidadOtActas;
                IF (cuValidacion%notfound) THEN
                    nuCantidadOtActas := 0;
                END IF;
                CLOSE cuValidacion;
                
                IF (nuCantidadOtActas > 1) THEN
                    ge_boerrors.seterrorcodeargument(2741, 'El Acta presenta Ordenes que se encuentran vinculadas a una o varias Actas, Ejemplo de una de ellas OT ('||reg.order_id||').');
                    ERRORS.SETERROR(2741, 'El Acta presenta Ordenes que se encuentran vinculadas a una o varias Actas, Ejemplo de una de ellas OT ('||reg.order_id||').');
                END IF; 
            END LOOP;
        END IF;
    END IF;
    ut_trace.trace('FINALIZA LOG TRG_LDC_OT_DOBLES ',5);
EXCEPTION
	WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END TRG_LDC_OT_DOBLES;
/