CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIUDRSinLocaMere
AFTER INSERT OR UPDATE OR DELETE ON FA_LOCAMERE
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/****************************************************************************
	Propiedad intelectual de Open International Systems. (c).

	Trigger:		trgaiurSinLocaMere

	Descripcion:	Sincroniza la infomación de las entidades LD_REL_MAR_GEO_LOC y
					FA_LOCAMERE.

	Autor:			Erika Alejandra Montenegro Gaviria
	Fecha:			12-12-2012

	Historia de Modificaciones
	Fecha			Autor					Modificación
	12-12-2012		Erika Montenegro		Creación trigger
	16-05-2013		Andrés Esguerra			Se añade acción en delete
****************************************************************************/

DECLARE

BEGIN
	--Si inserta en  FA_LOCAMERE
	IF INSERTING THEN
		INSERT INTO LD_REL_MAR_GEO_LOC(rel_mar_geo_loc_id,relevant_market_id,geograp_location_id)
		VALUES (:new.lomrcodi,:new.lomrmeco,:new.lomrloid);
	END IF;

	--Si actualiza en FA_LOCAMERE
	IF UPDATING THEN
		UPDATE LD_REL_MAR_GEO_LOC
		SET relevant_market_id = :new.lomrmeco,
		geograp_location_id = :new.lomrloid
		WHERE rel_mar_geo_loc_id = :old.lomrcodi;
	END IF;

	--Si elimina en FA_LOCAMERE
	IF DELETING THEN
		DELETE FROM LD_REL_MAR_GEO_LOC
		WHERE rel_mar_geo_loc_id = :old.lomrcodi;
	END IF;

	EXCEPTION
		when ex.CONTROLLED_ERROR then
			raise;
		when OTHERS then
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
End;
/
