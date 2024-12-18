CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCCONCDIFE  BEFORE INSERT OR UPDATE OR DELETE
ON LDC_CONCDIFE
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : TRG_LDCCONCDIFE
  Descripcion : trigger que genera log de la tabla LDC_CONCDIFE
  Autor       : Luis Javier Lopez Barrios / Horbath
  Ticket      :
  Fecha       : 29-03-2020

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========          ====================
**************************************************************************/
DECLARE
  nuError        NUMBER;
  sbError        VARCHAR2(4000);
  nuConcepto     NUMBER;
  sbFlagActual   VARCHAR2(1);
  sbFlagAnte     VARCHAR2(1);
  sbOpera        VARCHAR2(1);
BEGIN

 IF INSERTING THEN
   :NEW.CODIFERE := SYSDATE;
   :NEW.CODIFEUM := SYSDATE;
   sbFlagActual  := :new.CODIFLAG;
   nuConcepto    := :NEW.CODICODI;
   sbOpera       := 'I';
 END IF;

 IF UPDATING THEN
   :NEW.CODIFEUM := SYSDATE;
   sbFlagActual := :new.CODIFLAG;
   sbFlagAnte   := :old.CODIFLAG;
   nuConcepto    := :NEW.CODICODI;
   sbOpera       := 'U';
 END IF;

 IF DELETING THEN
    sbFlagActual := :OLD.CODIFLAG;
    sbFlagAnte   := :old.CODIFLAG;
    nuConcepto    := :OLD.CODICODI;
   sbOpera       := 'D';
 END IF;

 INSERT INTO LDC_LOGCONCDIFE
  (
    LCDICODI,    LCDIFLAC,    LCDIFLAN,    LDCIFERE, LCDIOPER,    LCDIUSER,    LCDITERM
  )
  VALUES
  (    nuConcepto,   sbFlagActual, sbFlagAnte, sysdate,  sbOpera,    USER,    USERENV('TERMINAL')  );


EXCEPTION
  When ex.controlled_error Then
     ERRORS.GETERROR(nuError,sbError);
  WHEN OTHERS THEN
      ERRORS.SETERROR;
      Raise ex.controlled_error;
END;
/
