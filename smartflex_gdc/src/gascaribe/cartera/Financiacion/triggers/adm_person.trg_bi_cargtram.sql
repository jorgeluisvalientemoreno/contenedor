CREATE OR REPLACE TRIGGER adm_person.TRG_BI_CARGTRAM AFTER INSERT OR UPDATE OR DELETE ON CARGTRAM
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
/*****************************************************************
    Propiedad intelectual de GDC.
    Unidad         : TRG_BI_CARGTRAM
    Caso           : 
    Descripcion    : Trigger para guardar log sobre operaciones CRUD sobre CARGTRAM
    Autor          : 
    Fecha          : 

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    17/10/2024      lubin.pineda		OSF-3450: Se migra a ADM_PERSON  	
  ******************************************************************/
DECLARE

CATRCONS NUMBER(15);
OPERATION VARCHAR2(1);

BEGIN

IF INSERTING THEN
  CATRCONS := :new.CATRCONS;
  OPERATION := 'I';
ELSIF UPDATING THEN
  CATRCONS := :new.CATRCONS;
  OPERATION := 'U';
ELSE
  CATRCONS := :old.CATRCONS;
  OPERATION := 'D';
END IF;

INSERT INTO OPEN.LDCBI_CARGTRAM (
  CATRCONS,
  OPERATION
)
VALUES (
  CATRCONS,
  OPERATION
);

EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000,
                            'Error en TRG_BI_CARGTRAM por -->' || sqlcode ||
                            chr(13) || sqlerrm);
END;
/