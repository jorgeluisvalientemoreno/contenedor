CREATE OR REPLACE TRIGGER PERSONALIZACIONES.trgbidurAB_ADDRESS
BEFORE INSERT OR UPDATE OR DELETE ON AB_ADDRESS
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger:     trgbidurAB_ADDRESS
Autor:       Héctor Cruz
Fecha:       10-07-2012
Descripcion: Verifica que el usuario que puede insertar, modificar o borrar
             registros en la entidad AB_ADDRESS, sea el definido en la constante
             csbUSER.

Historia de Modificaciones
Fecha          	IDEntrega           Modificación

02-Febero-2014	Jorge Valiente		  Se creo un cursor que permita identificar el nombre del programa
                                                      que activa el TRIGGER. Ya que el servicio de OPEN UT_SESSION, no
                                                      identifica de forma a decuada la aplicacion que esta realizando
                                                      el llamado de este TRIGGER.

23-08-2013    	jsoto               Se agrega el parametro PACK_PERMITE_ING_DIRECCION
                                                      en ld_parameter para permitir registrar direccion
                                                      a algunos tipos de package

08-09-2012    	hcruzSAO189882      Modificación del usuario

10-07-2012    	hcruzSAO185353      Creación

14-03-2014      EMIROL              ARANDA 3110.  se quito toda la logica de creacion de la orden de trabajo para GIS
                                    Y SE PASO A UN JOB (LDC_ProGenOtDirVisita)

18-11-2013      ALVZAPATA           Adición condición que valida si el programa que intenta registrar
                                    es SIGGAS.exe, adicionalmente se inclute API para crear una orden sin
                                    relacionarse a ninguna solicitud.

26-08-2024      jpadilla            PESP-2329: Se mueve el trigger al schema PERSONALIZACIONES.
                                               Se refactorizó el trigger.

**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
    cnuUSER_NO_ALLOW CONSTANT ge_message.message_id%TYPE := 901343;
    csbINSERT_ACTION CONSTANT VARCHAR(15) := 'inserción';
    csbUPDATE_ACTION CONSTANT VARCHAR(15) := 'actualización';
    csbDELETE_ACTION CONSTANT VARCHAR(15) := 'borrado';
    csbENTITY        CONSTANT VARCHAR(15) := 'AB_ADDRESS';

    sbAccion         VARCHAR(15);

    -- Tener en cuenta que el usuario debe ir mayúscula sostenida.
    csbUSER          CONSTANT sa_user.mask%TYPE := pkg_bcld_parameter.fsbObtieneValorCadena('USER_CONN_GIS');
    sbCurrentUser    sa_user.mask%TYPE;
    nuPackageType    ps_package_type.package_type_id%TYPE;
    sbProgram        VARCHAR2(48);
    sbParamModu      VARCHAR2(48) := pkg_bcld_parameter.fsbObtieneValorCadena('NOM_APLICATIVO_GIS');

BEGIN
    sbAccion := CASE
        WHEN INSERTING THEN csbINSERT_ACTION
        WHEN UPDATING THEN csbUPDATE_ACTION
        WHEN DELETING THEN csbDELETE_ACTION
        ELSE ''
    END;

    sbProgram := pkg_session.fsbObtieneProgramaActual;

    -- Si el programa que intenta registrar es SIGGAS.exe, se permite la modificación
    IF (UPPER(sbProgram) = UPPER(sbParamModu)) THEN
        RETURN;
    END IF;

    sbCurrentUser := pkg_session.getUser;

    -- Si el usuario es el definido en la constante csbUSER (GISOSF), se permite la modificación
    IF (sbCurrentUser = csbUSER) THEN
        RETURN;
    END IF;

    -- Obtiene el tipo de solicitud de la instancia actual
    nuPackageType := pkg_session.fnuTipoSolicitudInstancia;

    -- Si el tipo de solicitud permite la inserción de direcciones, se permite la modificación
    IF (fblPackPermiteIngDireccion(nuPackageType)) THEN
        RETURN;
    END IF;

    pkg_error.setErrorMessage(cnuUSER_NO_ALLOW,
                              sbCurrentUser || '|' || sbAccion || '|' || csbENTITY || '-' || sbProgram);
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_error.setError;
        RAISE pkg_error.Controlled_Error;
END trgbidurAB_ADDRESS;
/
PROMPT "Trigger trgbidurAB_ADDRESS creado"
