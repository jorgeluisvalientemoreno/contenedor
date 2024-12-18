CREATE OR REPLACE TRIGGER TRG_LOG_DELETE_CARGOS AFTER DELETE ON OPEN.CARGOS
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

BEGIN
  
IF DELETING THEN

  INSERT INTO LDC_CARGOS_LOG_DELETE (
    cargcuco,
    cargnuse,
    cargconc,
    cargcaca,
    cargsign,
    cargpefa,
    cargvalo,
    cargdoso,
    cargcodo,
    cargusua,
    cargtipr,
    cargunid,
    cargfecr,
    cargprog,
    cargcoll,
    cargpeco,
    cargtico,
    cargvabl,
    cargtaco,
    Usuario_elimina,
    Fecha_Elimina,
    Terminal_Elimina,
    programa
  )
  VALUES (
    :old.cargcuco,
    :old.cargnuse,
    :old.cargconc,
    :old.cargcaca,
    :old.cargsign,
    :old.cargpefa,
    :old.cargvalo,
    :old.cargdoso,
    :old.cargcodo,
    :old.cargusua,
    :old.cargtipr,
    :old.cargunid,
    :old.cargfecr,
    :old.cargprog,
    :old.cargcoll,
    :old.cargpeco,
    :old.cargtico,
    :old.cargvabl,
    :old.cargtaco,
    USER,
    sysdate,
    userenv('TERMINAL'),
    ut_session.getmodule
  );

END IF;

EXCEPTION
  WHEN OTHERS THEN
    RAISE EX.CONTROLLED_ERROR;
END;
/
