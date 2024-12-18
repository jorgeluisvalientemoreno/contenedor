CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LD_SECURE_SALE
  BEFORE INSERT OR UPDATE ON LD_SECURE_SALE
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRG_LD_SECURE_SALE
    Descripcion    : Trigger para garantizar que no se registre una póliza con un tipo de póliza
                     que no esté asociada a la correspondiente línea de producto, de acuerdo a lo configurado
                     en LDCTL.
    Autor          : KCienfuegos
    Fecha          : 21-04-2015

    Historia de Modificaciones
    Fecha           Autor                        Modificacion
    =========      =========                    ====================
    21-04-2015     KCienfuegos.SAO310516        Creación.
  ******************************************************************/

DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    cnuNULL_ATTRIBUTE          CONSTANT NUMBER := 2741;
    NUCONT                     NUMBER := 0;
    NUPRODUCTLINE              LD_POLICY_TYPE.PRODUCT_LINE_ID%TYPE;
    NUPOLICYTYPE               LD_POLICY_TYPE.POLICY_TYPE_ID%TYPE;

    CURSOR CUPOLTYPE_BY_PROD_LINE(NUPRODLINE LD_POLICY_TYPE.PRODUCT_LINE_ID%TYPE,
                                  NUPOLICYTYPE LD_POLICY_TYPE.POLICY_TYPE_ID%TYPE) IS
      SELECT COUNT(1)
       FROM LD_POLICY_TYPE P
      WHERE P.POLICY_TYPE_ID = NUPOLICYTYPE
        AND P.PRODUCT_LINE_ID = NUPRODLINE;

BEGIN

     IF (INSERTING OR UPDATING) THEN
       DBMS_OUTPUT.put_line('INSERTING');
       NUPRODUCTLINE := :NEW.PRODUCT_LINE_ID;
       NUPOLICYTYPE := :NEW.POLICY_TYPE_ID;

       OPEN CUPOLTYPE_BY_PROD_LINE(NUPRODUCTLINE, NUPOLICYTYPE);
       FETCH CUPOLTYPE_BY_PROD_LINE INTO NUCONT;
       CLOSE CUPOLTYPE_BY_PROD_LINE;

       IF NUCONT = 0 THEN
          errors.seterror(cnuNULL_ATTRIBUTE, 'El tipo de póliza '||:NEW.POLICY_TYPE_ID||'-' ||dald_policy_type.fsbGetDESCRIPTION(:NEW.POLICY_TYPE_ID,0)
                                             ||' no está configurada para la línea de producto '||:NEW.PRODUCT_LINE_ID||'-'||dald_product_line.fsbGetDescription(:NEW.PRODUCT_LINE_ID,0)||'.');
          RAISE ex.controlled_error;
       END IF;
     END IF;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR
    THEN RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END LDC_TRG_LD_SECURE_SALE;
/
