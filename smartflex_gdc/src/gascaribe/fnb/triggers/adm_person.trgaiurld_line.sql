CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_LINE
    AFTER INSERT OR UPDATE
    ON LD_LINE
    REFERENCING OLD AS old NEW AS new
    FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger      : trgaiurLD_LINE
Descripcion  : Trigger para envío de notificacion al aprobar o crear lineas (después de
               realizar el registro en la entidad).
Autor        : Jorge Alejandro Carmona Duque
Fecha        : 12/09/2013

    Historia de Modificaciones
    Fecha       IDEntrega               Modificación
    16-09-2013  emontenegro SAO216944   Se modifica, para que se notifique por correo
                                        el cambio estado que hace el funcionario de
                                        la línea.
    06/06/2024  jpinedc                 OSF-2601: Ajustes por estandares                                     
**************************************************************/
DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) := 'trgaiurLD_LINE';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);

    sbMensaje           VARCHAR2 (2000);
    sbStatus            VARCHAR (20);

    /* Constante para formulario GEPPB */
    csbGEPPB   CONSTANT VARCHAR2 (5) := 'GEPPB';

    sbDestinatarios            ge_contratista.correo_electronico%TYPE;
    sbRemitente           ld_parameter.value_chain%TYPE
        := dald_Parameter.fsbGetValue_Chain ('EMAIL_ENV_FNB');
    nuPerson            ld_brand.person_id%TYPE;
    sbEmailPerson       ge_person.e_mail%TYPE;

    --Cursor para obtener el email de la persona (Proveedor) que registro la línea.
    CURSOR cuPerson IS
        SELECT e_mail
          FROM ge_person
         WHERE person_id = nuPerson;

    -- Cursor para la unidad operativa de la persona conectada, para de este modo obtener el
    -- contratista y capturar el mail del mismo. Se valida que dentro de la unidad operativa
    -- el campo del contratista no sea nulo, y se valida que solo devuelva un registro ya que
    -- en teoria, una persona solo debe estar configurada para una sola unidad operativa, pero
    -- no hay restriccion para esto y puede que exista una persona con varias unidades operativas
    -- configuradas. Se supone que si una persona se encuentra configurada en muchas unidades
    -- operativas, en estos registros debe estar el mismo contratista.
    CURSOR cuUnitPerson IS
        SELECT dage_contratista.fsbGetCorreo_Electronico (
                   or_operating_unit.CONTRACTOR_ID,
                   NULL)    email
          FROM or_oper_unit_persons, or_operating_unit
         WHERE     or_oper_unit_persons.person_id =
                   pkg_BOPersonal.fnuGetPersonaId      -- 1 --Usuario con correo
               AND or_oper_unit_persons.operating_unit_id =
                   or_operating_unit.operating_unit_id
               AND or_operating_unit.contractor_id IS NOT NULL
               AND ROWNUM = 1;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    IF UPDATING
    THEN
        --Si el estado cambia, se envía correo notificando el cambio de estado de la línea
        IF :new.approved <> :old.approved
        THEN
            IF :new.approved = 'Y'
            THEN
                sbStatus := 'Aprobada';
            ELSE
                sbStatus := 'No aprobada';
            END IF;

            nuPerson := :old.person_id;

            FOR rcPerson IN cuPerson
            LOOP
                sbEmailPerson := rcPerson.e_mail;
            END LOOP;

            --Se envía correo notificando el cambio de estado de la línea, que hizo el funcionario.
            sbMensaje :=
                   'La Línea de Artículos: '
                || :old.line_id
                || '-'
                || :old.description
                || ', se encuentra: '
                || sbStatus;
                
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbEmailPerson,
                isbAsunto           => 'Estado de la Línea: ' || :old.description,
                isbMensaje          => sbMensaje,
                isbDescRemitente    => 'Aprobación línea de artículos'
            );
                
        END IF;
    END IF;

    IF INSERTING
    THEN
        IF (pkg_Session.fsbObtenerModulo = csbGEPPB)
        THEN
            -- Se obtiene la unidad operativa de la persona conectada, para de este modo obtener el
            -- contratista y capturar el mail del mismo. Se valida que dentro de la unidad operativa
            -- el campo del contratista no sea nulo, y se valida que solo devuelva un registro ya que
            -- en teoria, una persona solo debe estar configurada para una sola unidad operativa, pero
            -- no hay restriccion para esto y puede que exista una persona con varias unidades operativas
            -- configuradas. Se supone que si una persona se encuentra configurada en muchas unidades
            -- operativas, en estos registros debe estar el mismo contratista.
            FOR rcUnitPerson IN cuUnitPerson
            LOOP
                sbDestinatarios := rcUnitPerson.email;
            END LOOP;

            --Se envía correo al funcionario, notificando que se creo una nueva línea
            sbMensaje :=
                   'Se ha creado la Línea de Artículos: '
                || :new.line_id
                || '-'
                || :new.description
                || ', y esta se encuentra en estado ''PENDIENTE''';
                
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbDestinatarios,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => 'Nueva Línea: ' || :new.description,
                isbMensaje          => sbMensaje,
                isbDescRemitente    => 'Nueva línea de artículos'
            );
                
        END IF;
    END IF;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
END TRGAIURLD_LINE;
/