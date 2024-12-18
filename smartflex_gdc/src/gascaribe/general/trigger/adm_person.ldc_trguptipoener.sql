CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGUPTIPOENER
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_TRGUPTIPOENER
  Descripcion : trigger que actualiza usuasio y fecha del registro de la tabla ldc_tipo_energetico
  Autor       : Horbath
  Ticket      : 542
  Fecha       : 05-01-2020

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========          ====================
18/10/2024          jpinedc             OSF-3383: Se migra a ADM_PERSON
**************************************************************************/
BEFORE UPDATE
ON ldc_tipo_energetico
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (new.estado <> old.estado or new.desc_energ <> old.desc_energ )
DECLARE
sbmensa varchar2(4000);



BEGIN
 UT_TRACE.TRACE('INICIA LDC_TRGUPTIPOENER', 10);

 IF FBLAPLICAENTREGAXCASO('0000542') THEN

	:new.USUARIO := LDC_BOPROCESRUTEROS.FNUUSUARIOLOG;

	:new.FECHA := sysdate;

 END IF;

 ------------------------------------------
UT_TRACE.TRACE('FIN LDC_TRGUPTIPOENER', 10);

EXCEPTION
  When ex.controlled_error Then
   Raise ex.controlled_error;
  WHEN OTHERS THEN

      sbmensa := sbmensa ||SQLERRM;
      ERRORS.SETERROR;
      Raise ex.controlled_error;
END LDC_TRGUPTIPOENER;
/
