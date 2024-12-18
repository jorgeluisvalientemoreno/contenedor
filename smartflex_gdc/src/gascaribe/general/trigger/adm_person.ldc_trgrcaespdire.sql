CREATE OR REPLACE trigger ADM_PERSON.LDC_TRGRCAESPDIRE BEFORE
INSERT OR  UPDATE   OF Address , Address_Parsed   ON AB_ADDRESS
FOR EACH ROW
/*****************************************************************
    Propiedad intelectual de GDC.
    Unidad         : LDC_TRGRCAESPDIRE
    Caso           : 538
    Descripcion    : Trigger para remover caracteres especiales A dirección
    Autor          : Olsoftware
    Fecha          : 26/10/2020

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/
DECLARE
   sbCaracteres VARCHAR2(40) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CARAESPREMO', NULL);
   sbDireccion    AB_ADDRESS.Address%TYPE := :NEW.Address;
   sbDireccionPar AB_ADDRESS.Address_Parsed%TYPE := :NEW.Address_Parsed;

begin
  IF FBLAPLICAENTREGAXCASO('0000538') THEN
     IF (sbDireccion IS NOT NULL OR sbDireccionPar IS NOT NULL) AND sbCaracteres IS NOT NULL  THEN
       for i in 1..length(sbCaracteres) loop
          sbDireccion := REPLACE(sbDireccion,substr(sbCaracteres, i,1),'');
          sbDireccionPar := REPLACE(sbDireccionPar,substr(sbCaracteres, i,1),'');
       end loop;
     END IF;
     :NEW.Address := sbDireccion;
     :NEW.Address_Parsed := sbDireccionPar;
  END IF;
EXCEPTION
WHEN ex.CONTROLLED_ERROR THEN
  raise ex.CONTROLLED_ERROR;
WHEN OTHERS THEN
  Errors.setError;
  raise ex.CONTROLLED_ERROR;
END LDC_TRGRCAESPDIRE;
/
