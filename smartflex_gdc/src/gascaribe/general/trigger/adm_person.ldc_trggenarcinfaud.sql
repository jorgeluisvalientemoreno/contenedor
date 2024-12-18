CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGGENARCINFAUD
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_TRGGENARCINFAUD
  Descripcion : trigger  para generar un archivo plano.
  Autor       : Horbath
  Ticket      : 863
  Fecha       : 27-10-2021

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========          ====================
18/10/2024          jpinedc             OSF-3383: Se migra a ADM_PERSON
**************************************************************************/
AFTER  UPDATE
ON LDC_REGINFAUD
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN ( old.HILO1 <> new.HILO1 or  old.HILO2 <> new.HILO2  )
DECLARE
 sbmensa    VARCHAR2(10000);


BEGIN
 UT_TRACE.TRACE('INICIA LDC_TRGGENARCINFAUD', 10);

	IF FBLAPLICAENTREGAXCASO('0000863') THEN

		if :new.HILO2=1 and :new.HILO1=1 then

			ldc_pkInfoAuditoria.PRGENARCHINFAUD (:new.Ano, :new.Mes, :new.Ruta,:new.PERSON_ID );

		end if;

	END IF;


UT_TRACE.TRACE('FIN LDC_TRGGENARCINFAUD', 10);

EXCEPTION
  When ex.controlled_error Then
        Raise ex.controlled_error;

  WHEN OTHERS THEN
      sbmensa := sbmensa ||SQLERRM;
      ERRORS.SETERROR;
      Raise ex.controlled_error;

END LDC_TRGGENARCINFAUD;
/
