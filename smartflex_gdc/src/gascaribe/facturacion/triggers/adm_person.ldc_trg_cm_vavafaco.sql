CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_CM_VAVAFACO
AFTER INSERT OR UPDATE OR DELETE ON CM_VAVAFACO

REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE
SBACCION   varchar2(1);
sbUser     varchar2(200)  := pkGeneralServices.fsbGetUserName;
sbTerminal varchar2(200)  := pkGeneralServices.fsbGetTerminal;
nuPersonId  NUMBER(15)    := GE_BOPersonal.fnuGetPersonId;
sbPrograOSF VARCHAR2(200) := pkErrors.fsbGetApplication;

BEGIN

IF DELETING THEN
  SBACCION := 'E';
  INSERT INTO LDC_LOG_VAVAFACO (producto,         localidad,     variable,       fechaini,         fechafin,       valor,
                              usuario,          personid,      terminal,       programa,         fechaproc,      accion)
                      VALUES (:old.vvfcsesu,   :old.vvfcubge, :old.vvfcvafc,   :old.vvfcfeiv,   :old.vvfcfefv,   :old.vvfcvalo,
                               sbUser,         nuPersonId,    sbTerminal,      sbPrograOSF,     sysdate,         SBACCION);
ELSIF UPDATING THEN
  SBACCION := 'M';
  INSERT INTO LDC_LOG_VAVAFACO (producto,         localidad,     variable,       fechaini,         fechafin,       valor,
                              usuario,          personid,      terminal,       programa,         fechaproc,      accion)
                      VALUES (:new.vvfcsesu,   :new.vvfcubge, :new.vvfcvafc,   :new.vvfcfeiv,   :new.vvfcfefv,   :new.vvfcvalo,
                               sbUser,         nuPersonId,    sbTerminal,      sbPrograOSF,     sysdate,         SBACCION);
ELSE
  SBACCION := 'I';
  INSERT INTO LDC_LOG_VAVAFACO (producto,         localidad,     variable,       fechaini,         fechafin,       valor,
                              usuario,          personid,      terminal,       programa,         fechaproc,      accion)
                      VALUES (:new.vvfcsesu,   :new.vvfcubge, :new.vvfcvafc,   :new.vvfcfeiv,   :new.vvfcfefv,   :new.vvfcvalo,
                               sbUser,         nuPersonId,    sbTerminal,      sbPrograOSF,     sysdate,         SBACCION);
END IF;


EXCEPTION
    WHEN OTHERS THEN
        RAISE EX.CONTROLLED_ERROR;
END;
/
