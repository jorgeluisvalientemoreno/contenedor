CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_AS_MAN_QUOTA
  BEFORE INSERT OR UPDATE OR DELETE OF MANUAL_QUOTA_ID ON LD_MANUAL_QUOTA
  FOR EACH ROW
DECLARE
  /*
      Propiedad intelectual de REDI
      Trigger     : LDC_TRG_AS_MAN_QUOTA
      Descripci?n : Permite almacenar informacion adicional de la asignacion de cupo
                    Manual en la tabla LDC_ASCUPOAD
      Autor       : Agordillo Caso.200-749
      Fecha       : 26/09/2016

      Historia de Modificaciones
      AUTOR          FECHA        MODIFICACION
   SEBTAP || JM    15-05-2017     Se valida que hacer en caso de insert, update o delete.
                                  Esta modificacion tambien esta comtemplada dentro del caso 200-749

  */

  sbUserDB   sa_user.mask%type;
  nuUser     sa_user.user_id%TYPE;
  sbUser     VARCHAR2(100);
  sbTerminal varchar2(100);

  CURSOR cuConsultaUsuario(par1 sa_user.user_id%TYPE) IS
    SELECT SubStr(a.user_id || ' - ' || b.name_, 1, 100)
      FROM sa_user a, ge_person b
     WHERE a.user_id = par1
       AND b.user_id = a.user_id;

BEGIN

  -- captura la mascara del usuario oracle
  sbUserDB := UT_SESSION.GETUSER;
  -- si la mascara no es vacia averigua el id de conexion
  IF sbUserDB IS NOT NULL THEN
    nuUser := SA_BOUSER.FNUGETUSERID(sbUserDB);
    UT_TRACE.TRACE('Id Del usuario conectado:[' || sbUserDB || '] [' ||
                   nuUser || ']',
                   10);
  ELSE
    nuUser := SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER);
    UT_TRACE.TRACE('Corrige Id Del usuario conectado:[' || sbUserDB ||
                   '] [' || nuUser || ']',
                   10);
  END IF;
  -- con el id del usuario de la base de datos averiguamos el nombre del usuario
  -- nombre del usuario conectado
  IF nuUser > 0 THEN
    OPEN cuConsultaUsuario(nuUser);
    FETCH cuConsultaUsuario
      INTO sbUser;
    IF cuConsultaUsuario%NOTFOUND THEN
      sbUser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
    END IF;
    CLOSE cuConsultaUsuario;
  ELSE
    sbUser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
  END IF;

  sbTerminal := AU_BOSystem.getsystemuserterminal;
--- SEBTAP || JM || 15-05-2017
 /*Se valida que hacer en caso de insert, update o delete*/
  IF inserting THEN
    INSERT INTO LDC_ASCUPOAD
      (ascucodi, ascuuser, ascuterm, ascufech)
    VALUES
      (:new.MANUAL_QUOTA_ID, sbUser, sbTerminal, sysdate);
  ELSIF updating then
    UPDATE LDC_ASCUPOAD
       SET ascuuser = sbUser, ascuterm = sbTerminal, ascufech = sysdate
     WHERE ascucodi = :new.MANUAL_QUOTA_ID;
  ELSE
    DELETE FROM LDC_ASCUPOAD WHERE ascucodi = :new.MANUAL_QUOTA_ID;
  END IF;
---

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    errors.seterror;
  WHEN others THEN
    errors.seterror;
END;
/
