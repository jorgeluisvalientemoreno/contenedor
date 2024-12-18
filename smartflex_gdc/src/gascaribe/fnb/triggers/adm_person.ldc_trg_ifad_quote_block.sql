CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_IFAD_QUOTE_BLOCK
BEFORE INSERT OR UPDATE OR DELETE OF QUOTA_BLOCK_ID ON  LD_QUOTA_BLOCK
FOR EACH ROW
DECLARE
/*
    Propiedad intelectual de REDI
    Trigger     : LDC_TRG_IFAD_QUOTE_BLOCK
    Descripci?n : Permite validar si el usuario es 1-Open Obtener el usuario y terminal correcta.
    Autor       : Agordillo Caso.200-749
    Fecha       : 26/09/2016

    Historia de Modificaciones

    Fecha             Autor                Modificacion
    =========     ===================      ===============================================
    26/09/2016    Agordillo Caso.200-749   Creaci?n
    03/03/2017    leidyc                   Se modifica la validación inicial
*/
    sbUserDB        sa_user.mask%type;
    nuUser          sa_user.user_id%TYPE;
    sbUser          VARCHAR2(100);
    sbTerminal      varchar2(100);

     CURSOR cuConsultaUsuario (par1 sa_user.user_id%TYPE)
    IS
      SELECT SubStr(a.user_id||' - '||b.name_,1,100)
      FROM sa_user a,ge_person b
      WHERE a.user_id = par1 AND b.user_id = a.user_id;
BEGIN

    -- valida si el usuario no ha sido actualizado desde el paquete LDC_CALCULACUPOBRILLA, si ya se modifico alí se deja igual
    -- si no ha sido modificado(FORMA), lo actualiza
    IF :new.username not like '%-%' then
    --IF :new.terminal IS NULL OR :new.terminal = 'UNKNOWN' THEN
      -- captura la mascara del usuario oracle
      sbUserDB   := UT_SESSION.GETUSER;
      -- si la mascara no es vacia averigua el id de conexion
      IF sbUserDB IS NOT NULL THEN
        nuUser := SA_BOUSER.FNUGETUSERID(sbUserDB);
        UT_TRACE.TRACE('Id Del usuario conectado:['||sbUserDB||'] ['||nuUser||']',10);
      ELSE
        nuUser := SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER);
        UT_TRACE.TRACE('Corrige Id Del usuario conectado:['||sbUserDB||'] ['||nuUser||']',10);
      END IF;
      -- con el id del usuario de la base de datos averiguamos el nombre del usuario
      -- nombre del usuario conectado
      IF nuUser>0 THEN
        OPEN cuConsultaUsuario (nuUser);
        FETCH cuConsultaUsuario INTO sbUser;
        IF cuConsultaUsuario%NOTFOUND THEN
          sbUser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
        END IF;
        CLOSE cuConsultaUsuario;
      ELSE
        sbUser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
      END IF;

      sbTerminal  := AU_BOSystem.getsystemuserterminal;

      :new.username := sbUser;
      :new.terminal := sbTerminal;
    END IF;


EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
            errors.seterror;
      WHEN others THEN
            errors.seterror;
END;
/
