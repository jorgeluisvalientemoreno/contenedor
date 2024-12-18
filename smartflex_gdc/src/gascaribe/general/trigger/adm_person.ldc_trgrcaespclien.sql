CREATE OR REPLACE trigger ADM_PERSON.LDC_TRGRCAESPCLIEN BEFORE
INSERT OR  UPDATE   OF Subscriber_Name , Subs_last_Name  ON ge_subscriber
FOR EACH ROW
/*****************************************************************
    Propiedad intelectual de GDC.
    Unidad         : LDC_TRGRCAESPCLIEN
    Caso           : 538
    Descripcion    : Trigger para remover caracteres especiales al nombre y apellido del cliente
    Autor          : Olsoftware
    Fecha          : 26/10/2020

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    21/10/2024      jpinedc             OSF-3450: Se migra a ADM_PERSON
  ******************************************************************/
DECLARE
   sbCaracteres VARCHAR2(40) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CARAESPREMO', NULL);
   sbNombre ge_subscriber.Subscriber_Name%TYPE := :NEW.Subscriber_Name;
   sbApellido ge_subscriber.Subs_last_Name%TYPE := :NEW.Subs_last_Name;

begin
  IF FBLAPLICAENTREGAXCASO('0000538') THEN
     IF (sbNombre IS NOT NULL OR sbApellido IS NOT NULL) AND sbCaracteres IS NOT NULL  THEN
       for i in 1..length(sbCaracteres) loop
          sbNombre := REPLACE(sbNombre,substr(sbCaracteres, i,1),'');
          sbApellido := REPLACE(sbApellido,substr(sbCaracteres, i,1),'');
       end loop;
     END IF;
     :NEW.Subscriber_Name := sbNombre;
     :NEW.Subs_last_Name := sbApellido;
  END IF;
EXCEPTION
WHEN ex.CONTROLLED_ERROR THEN
  raise ex.CONTROLLED_ERROR;
WHEN OTHERS THEN
  Errors.setError;
  raise ex.CONTROLLED_ERROR;
END LDC_TRGRCAESPCLIEN;
/
