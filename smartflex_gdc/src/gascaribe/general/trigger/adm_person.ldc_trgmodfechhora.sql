CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGMODFECHHORA
BEFORE INSERT OR UPDATE ON GE_LIST_UNITARY_COST FOR EACH ROW

/*******************************************************************************
    Metodo:       LDC_TRGMODFECHHORA
    Descripcion:  TRIGGER que se encarga de modificar la fecha de la tabla GE_LIST_UNITARY_COST
				  para no tener en cuenta la hora asociada, sino solo la fecha

    Autor:        GDC/Miguel Ballesteros
    Fecha:        09/02/2021

    Historia de Modificaciones
    FECHA           AUTOR                       DESCRIPCION
    21/10/2024      jpinedc                     OSF-3450: Se migra a ADM_PERSON
*******************************************************************************/

    -- Se lanzara despues de cada fila actualizada
DECLARE
	nuCaso 		   	 varchar2(30):='0000645';

BEGIN

	ut_trace.Trace('Inicio: LDC_TRGMODFECHHORA', 10);

	if(fblAplicaEntregaxCaso(nuCaso))then

		:NEW.VALIDITY_START_DATE := TRUNC(:NEW.VALIDITY_START_DATE);

		:NEW.VALIDITY_FINAL_DATE := TRUNC(:NEW.VALIDITY_FINAL_DATE);

	end if;


	ut_trace.Trace('FIN: LDC_TRGMODFECHHORA', 10);


EXCEPTION
	   WHEN EX.CONTROLLED_ERROR THEN
		 raise;
	   WHEN OTHERS THEN
		 ERRORS.SETERROR;
	   RAISE EX.CONTROLLED_ERROR;

END LDC_TRGMODFECHHORA;
/
