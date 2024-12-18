CREATE OR REPLACE TRIGGER ADM_PERSON.CRTRGBIULDC_EQUIVALENCIA_SSPD
/*******************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Trigger     :   crTRGBIULDC_EQUIVALENCIA_SSPD
    Descripcion	:   Completa informacion de la tabla LDC_EQUIVALENCIA_SSPD

    Autor       :   Carlos Andrés Dominguez Naranjo
    Fecha       :   18-10-2013

    Historia de Modificaciones
    Fecha       IDEntrega

    18-10-2013  cdominguez
    Creacion.
*******************************************************************************/
BEFORE INSERT OR UPDATE on LDC_EQUIVALENCIA_SSPD
referencing old as old new as new for each row
DECLARE
    sbMensaje       VARCHAR2(100);
    nuCodigoError   NUMBER;
    sbMensajeError  VARCHAR2(2000);
    sbUsuario varchar2(250);
BEGIN
     sbUsuario := ut_session.getuser;
    :new.USUARIO := sa_boUser.fnugetuserid(sbUsuario);
    :new.FECHA_REGISTRO := sysdate;
    :new.TERMINAL := UT_SESSION.getterminal;
EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
      WHEN others THEN
            errors.seterror;
            RAISE EX.CONTROLLED_ERROR;
END;
/
