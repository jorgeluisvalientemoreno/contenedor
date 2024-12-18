CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGGEHISTCERT
  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : LDC_TRGGEHISTCERT
  Descripcion    : Disparador que inserta o actualiza informacion en la tabla LDC_PLAZOS_CERTANT
  Autor          : Luis Javier Lopez / Horbath
  Ticket         : 534
  Fecha          : 14/10/2020


  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  18/10/2024        jpinedc           OSF-3383: Se migra a ADM_PERSON
  ******************************************************************/
  AFTER INSERT OR UPDATE  ON ldc_plazos_cert
  FOR EACH ROW
  DECLARE
    sbExiste VARCHAR2(1);

    CURSOR cuExisteCert IS
    SELECT 'X'
    FROM LDC_PLAZOS_CERTANT
    WHERE  ID_PRODUCTO = :NEW.ID_PRODUCTO;

    nuContrato      LDC_PLAZOS_CERTANT.ID_CONTRATO%type;
    nuProducto      LDC_PLAZOS_CERTANT.ID_PRODUCTO%type;
    dtPlazoMinRev   LDC_PLAZOS_CERTANT.PLAZO_MIN_REVISION%type;
    dtPlazoMinSusp  LDC_PLAZOS_CERTANT.PLAZO_MIN_SUSPENSION%type;
    dtPlazoMaxi    LDC_PLAZOS_CERTANT.PLAZO_MAXIMO%type;
    sbNoti          LDC_PLAZOS_CERTANT.IS_NOTIF%type;

  BEGIN

   --Inicio CAMBIO 836
    IF FBLAPLICAENTREGAXCASO('0000836') THEN
      IF (updating AND :new.plazo_maximo > :old.plazo_maximo) OR inserting THEN
          BEGIN
               delete from LDC_CONDEFRP where LDC_CONDEFRP.PRODUCTO = :new.id_producto;
          EXCEPTION
            WHEN OTHERS THEN
                 null;
          END;
      END IF;
    END IF;
   --Fin CAMBIO 836


   IF :NEW.PLAZO_MIN_REVISION IS NOT NULL OR :OLD.PLAZO_MIN_REVISION IS NOT NULL THEN
      IF INSERTING THEN
         nuContrato := :NEW.ID_CONTRATO;
         nuProducto  := :NEW.ID_PRODUCTO;
         dtPlazoMinRev := :NEW.PLAZO_MIN_REVISION;
         dtPlazoMinSusp := :NEW.PLAZO_MIN_SUSPENSION;
         dtPlazoMaxi := :NEW.PLAZO_MAXIMO;
         sbNoti := :NEW.IS_NOTIF;
      ELSE
         nuContrato := :OLD.ID_CONTRATO;
         nuProducto  := :OLD.ID_PRODUCTO;
         dtPlazoMinRev := :OLD.PLAZO_MIN_REVISION;
         dtPlazoMinSusp := :OLD.PLAZO_MIN_SUSPENSION;
         dtPlazoMaxi := :OLD.PLAZO_MAXIMO;
         sbNoti := :OLD.IS_NOTIF;
      END IF;

      --se valida si existe historial
      OPEN cuExisteCert;
      FETCH cuExisteCert INTO sbExiste;
      IF cuExisteCert%NOTFOUND THEN
         INSERT INTO LDC_PLAZOS_CERTANT
                      (
                        ID_CONTRATO,
                        ID_PRODUCTO,
                        PLAZO_MIN_REVISION,
                        PLAZO_MIN_SUSPENSION,
                        PLAZO_MAXIMO,
                        IS_NOTIF
                      )
                      VALUES
                      (
                       nuContrato,
                       nuProducto,
                       dtPlazoMinRev,
                       dtPlazoMinSusp,
                        dtPlazoMaxi,
                        sbNoti
                      );

      ELSE
        UPDATE LDC_PLAZOS_CERTANT SET
                        PLAZO_MIN_REVISION = dtPlazoMinRev,
                        PLAZO_MIN_SUSPENSION =dtPlazoMinSusp ,
                        PLAZO_MAXIMO = dtPlazoMaxi,
                        IS_NOTIF = sbNoti
        WHERE  ID_PRODUCTO = nuProducto;
      END IF;
      CLOSE cuExisteCert;
    END IF;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
  END;
/
