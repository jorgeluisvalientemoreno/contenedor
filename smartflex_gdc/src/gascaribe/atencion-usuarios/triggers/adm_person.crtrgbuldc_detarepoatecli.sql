CREATE OR REPLACE TRIGGER ADM_PERSON.CRTRGBULDC_DETAREPOATECLI
/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Trigger     :   crTRGBULDC_DETAREPOATECLI
    Descripcion	:   Valida actualización detalle de reporte de atención al cliente

    Autor       :   Carlos Andrés Dominguez Naranjo
    Fecha       :   18-10-2013

    Historia de Modificaciones
    Fecha       IDEntrega

    18-10-2013  cdominguez
    Creacion.
*******************************************************************************/
BEFORE INSERT OR UPDATE on LDC_DETAREPOATECLI
referencing old as old new as new for each row
DECLARE
    sbMensaje       VARCHAR2(100);
    nuCodigoError   NUMBER;
    sbMensajeError  VARCHAR2(2000);
    rcLDC_ATECLIREPO DALDC_ATECLIREPO.styLDC_ATECLIREPO;
BEGIN

    if ( UPDATING ) then
	   rcLDC_ATECLIREPO := DALDC_ATECLIREPO.frcGetRecord(:new.ATECLIREPO_ID);
	   if (rcLDC_ATECLIREPO.APROBADO = 'S') then
            Errors.SetError(612, 'LDC_DETAREPOATECLI - El reporte ya se encuentra aprobado y no puede ser modificado');
            RAISE ex.CONTROLLED_ERROR;
        END if;
    end if;

EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
      WHEN others THEN
            errors.seterror;
            RAISE EX.CONTROLLED_ERROR;
END;
/
