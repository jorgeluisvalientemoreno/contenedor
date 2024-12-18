CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIUDRSinMercRele
AFTER INSERT OR UPDATE OR DELETE ON FA_MERCRELE
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/****************************************************************************
	Propiedad intelectual de Open International Systems. (c).

	Trigger:		trgaiurSinMercRele

	Descripcion:	Sincroniza la infomación de las entidades LD_RELEVANT_MARKET y
					FA_MERCRELE.

	Autor:			Erika Alejandra Montenegro Gaviria
	Fecha:			12-12-2012

	Historia de Modificaciones
	Fecha			Autor					Modificación
	12-12-2012		Erika Montenegro		Creación trigger
	16-05-2013		Andrés Esguerra			Se añade acción en delete
****************************************************************************/

DECLARE

BEGIN
	--Si inserta en  FA_MERCRELE
	IF INSERTING THEN
		INSERT INTO LD_RELEVANT_MARKET(relevant_market_id,relevant_market,description)
		VALUES (:new.merecodi,''||:new.merecodi,:new.meredesc);
	END IF;

	--Si actualiza en FA_MERCRELE
	IF UPDATING THEN
		UPDATE LD_RELEVANT_MARKET
		SET description = :new.meredesc
		WHERE relevant_market_id = :old.merecodi;
	END IF;

	--Si se elimina en FA_MERCRELE
	IF DELETING THEN
		DELETE FROM LD_RELEVANT_MARKET
		WHERE relevant_market_id = :old.merecodi;
	END IF;

	EXCEPTION
		when ex.CONTROLLED_ERROR then
			raise;
		when OTHERS then
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
End;
/
