CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_BU_LDCI_TRANSOMA
    BEFORE UPDATE OF TRSMESTA, TRSMACTI
    ON LDCI_TRANSOMA
    /*******************************************************************************
        Propiedad intelectual de CSC

        Trigger  : TGR_AU_LDCI_TRANSOMA

        Descripcion : Trigger que se encarga de la logica cuando se aprueban o rechazan
                      solicitudes de materiales

        Autor    : Eduardo Cerón
        Fecha    : 30/06/2019
     Caso    : 128 (200-2321)

      Historia de Modificaciones
      Fecha       Autor                   Modificación
      =========   =========               ====================
      06/06/2024  jpinedc                 OSF-2601: Ajustes por estandares
    *******************************************************************************/
    FOR EACH ROW

DECLARE
    csbMetodo           CONSTANT VARCHAR2(70) := 'TGR_BU_LDCI_TRANSOMA';
    csbNivelTraza       CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError             NUMBER;
    sbError             VARCHAR2(4000);
    
    sbEntrega2321   VARCHAR2 (100) := 'OSS_CON_EEC_200_2321_GDC_10';
    sbNameAPP       sa_executable.name%TYPE;
    nuEstado        LDCI_TRANSOMA.trsmesta%TYPE;
    sbComment       LDCI_TRANSOMA.trsmobse%TYPE;
    sbUser          sa_user.mask%TYPE;
    sbUserGen       sa_user.mask%TYPE;
    sbRecept        ge_person.e_mail%TYPE;
    sbAprobador     ge_person.e_mail%TYPE;
    sbNombre        ge_person.name_%TYPE;
    sbAsunto       VARCHAR2 (200);
    sbMensaje       VARCHAR2 (2000);
    sbDescEsta      VARCHAR2 (50);
    sbAccion        VARCHAR2 (1) := 'A';
    sbErrorMsg      ge_message.description%TYPE;

    CURSOR cuEmail IS
        SELECT ge_person.e_mail, name_
          FROM ge_person
         WHERE ge_person.person_id = ge_bopersonal.fnugetpersonid;

    CURSOR cuEstado (inuEstado IN LDCI_TRANESTA.codigo%TYPE)
    IS
        SELECT descripcion
          FROM LDCI_TRANESTA
         WHERE codigo = inuEstado;

BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    -- Se obtiene el nombre de la aplicación que los está ejecutando

    sbNameAPP := ut_session.getmodule ();

    pkg_Traza.Trace ('TGR_BU_LDCI_TRANSOMA - ' || sbNameAPP, csbNivelTraza);

    -- Si aplica la entrega y si la aplicion que ejecuta el trigger es LDCAPSOMA se reaaliza el proceso
    IF fblaplicaentrega (sbEntrega2321)
    THEN
        pkg_Traza.Trace ('Aplica la entrega ', csbNivelTraza);

        IF NVL (:OLD.TRSMESTA, 0) != :NEW.TRSMESTA
        THEN
           pkg_Traza.Trace ('Estado anterior:' || :OLD.TRSMESTA, csbNivelTraza);
           pkg_Traza.Trace ('Estado NUEVO:' || :new.TRSMESTA, csbNivelTraza);

            INSERT INTO LDC_RESULT_PROCESS_PEDIDOVENTA (RESULT_PROCESS_ID,
                                                        REQUEST_MATERIAL_ID,
                                                        ESTADO_ANTERIOR,
                                                        ESTADO_NUEVO,
                                                        USER_,
                                                        REGISTER_DATE,
                                                        COMMENT_,
                                                        TERMINAL)
                 VALUES (SEQ_LDC_RESULT_PROCESS.NEXTVAL,
                         :new.TRSMCODI,
                         NVL (:OLD.TRSMESTA, 0),
                         :NEW.TRSMESTA,
                         USER,
                         SYSDATE,
                         NVL (:NEW.TRSMCOME, '-'),
                         NVL (USERENV ('TERMINAL'), '--'));
        END IF;

        IF UPPER (sbNameAPP) = 'LDCAPSOMA'
        THEN
            IF :NEW.TRSMESTA != :OLD.TRSMESTA
            THEN
                sbUser := USER;

                nuEstado := :NEW.TRSMESTA;
                sbComment := :NEW.TRSMCOME;

                IF nuEstado IS NULL
                THEN
                    sbErrorMsg := 'El estado no puede ser nulo.';
                    pkg_error.setErrorMessage( isbMsgErrr =>  sbErrorMsg);
                END IF;

                pkg_Traza.Trace (
                       'TGR_BU_LDCI_TRANSOMA - nuEstado: '
                    || nuEstado
                    || ' - sbComment: '
                    || sbComment,
                    csbNivelTraza);

                -- Si el estado final es "Anulado"
                IF nuEstado IN (4, 7, 8) AND sbComment IS NULL
                THEN
                    sbErrorMsg :=
                        'El comentario de rechazo no puede ser nulo.';
                    pkg_error.setErrorMessage( isbMsgErrr => sbErrorMsg);
                END IF;

                -- Si el estado final es devuelto
                IF nuEstado = 7
                THEN
                    :NEW.TRSMACTI := 'N';
                END IF;

                -- Si el estado final es rechazado
                pkg_Traza.Trace (
                       'REQUEST_MATERIAL_ID: '
                    || :new.TRSMCODI
                    || ' STATUS: '
                    || sbAccion
                    || ' USER_: '
                    || sbUser
                    || ' REGISTER_DATE: '
                    || SYSDATE
                    || ' COMMENT: '
                    || sbComment,
                    csbNivelTraza);

                -- Se realiza el registro en LDC_RESULT_PROCESS

                -- Despues del proceso, se envía el email
                sbUserGen := :OLD.TRSMUSMO;

                sbRecept :=
                    daor_operating_unit.fsbgete_mail (:NEW.TRSMUNOP,
                                                           NULL);

                OPEN cuEstado (:NEW.TRSMESTA);
                FETCH cuEstado INTO sbDescEsta;
                CLOSE cuEstado;

                sbAsunto :=
                       'Solicitud de material ['
                    || :NEW.TRSMCODI
                    || '] '
                    || :NEW.TRSMESTA
                    || ' - '
                    || sbDescEsta;

                OPEN cuEmail;
                FETCH cuEmail INTO sbAprobador, sbNombre;
                CLOSE cuEmail;

                IF TO_CHAR (SYSDATE, 'HH24') < 12
                THEN
                    sbMensaje := 'Buenos dias,' || '<br>' || '<br>';
                ELSE
                    sbMensaje := 'Buenas tardes,' || '<br>' || '<br>';
                END IF;

                sbMensaje :=
                       sbMensaje
                    || 'Su solicitud de material fue '
                    || sbDescEsta
                    || ' por '
                    || sbNombre
                    || ' por la siguiente razon: '
                    || sbComment
                    || '<br>'
                    || '<br>';

                sbMensaje :=
                       sbMensaje
                    || '<br>'
                    || 'Si tiene algun comentario, comuniquese con su administrador de contrato.';
                sbMensaje := sbMensaje || '<br>';
                sbMensaje := sbMensaje || '<br>' || 'Saludos.';

                IF sbRecept IS NOT NULL
                THEN
                    pkg_Traza.Trace ('sbRecept ' || sbRecept, csbNivelTraza);
                    pkg_Traza.Trace ('sbAsunto ' || sbAsunto, csbNivelTraza);
                    pkg_Traza.Trace ('sbMensaje ' || sbMensaje, csbNivelTraza);                    
                    
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbDestinatarios    => sbRecept,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje
                    );
                    
                ELSE
                    pkg_Traza.Trace ('sbAprobador ' || sbAprobador, csbNivelTraza);

                    IF sbAprobador IS NOT NULL
                    THEN
                        IF TO_CHAR (SYSDATE, 'HH24') < 12
                        THEN
                            sbMensaje :=
                                'Buenos dias,' || '<br>' || '<br>';
                        ELSE
                            sbMensaje :=
                                'Buenas tardes,' || '<br>' || '<br>';
                        END IF;

                        sbMensaje :=
                               sbMensaje
                            || 'La unidad operativa '
                            || :NEW.TRSMUNOP
                            || '-'
                            || pkg_BCUnidadOperativa.fsbGetNombre(:NEW.TRSMUNOP)
                            || ' no tiene correo configurado en la forma ORCOR, favor validar';
                        sbMensaje := sbMensaje || '<br>';
                        sbMensaje := sbMensaje || '<br>';
                        sbMensaje := sbMensaje || 'Saludos.';
                        pkg_Traza.Trace ('sbAprobador ' || sbAprobador, csbNivelTraza);
                        pkg_Traza.Trace ('sbAsunto ' || sbAsunto, csbNivelTraza);
                        pkg_Traza.Trace ('sbMensaje ' || sbMensaje, csbNivelTraza);

                        pkg_Correo.prcEnviaCorreo
                        (
                            isbDestinatarios    => sbAprobador,
                            isbAsunto           => sbAsunto,
                            isbMensaje          => sbMensaje
                        );                        
                    END IF;
                END IF;
            ELSIF :NEW.TRSMACTI != :OLD.TRSMACTI
            THEN
                IF :NEW.TRSMACTI = 'S'
                THEN
                    NULL;
                END IF;
            END IF;
        ELSIF UPPER (sbNameAPP) = 'LDCISOMA'
        THEN
            IF     :NEW.TRSMACTI != :OLD.TRSMACTI
               AND :NEW.TRSMACTI = 'S'
               AND :OLD.TRSMESTA IN (1, 7)
            THEN
                :NEW.TRSMESTA := 5;
                :NEW.TRSMCOME := NULL;

                IF NVL (:OLD.TRSMESTA, 0) != :NEW.TRSMESTA
                THEN
                    pkg_Traza.Trace ('Estado anterior:' || :OLD.TRSMESTA, csbNivelTraza);
                    pkg_Traza.Trace ('Estado NUEVO:' || :new.TRSMESTA, csbNivelTraza);

                    INSERT INTO LDC_RESULT_PROCESS_PEDIDOVENTA (
                                    RESULT_PROCESS_ID,
                                    REQUEST_MATERIAL_ID,
                                    ESTADO_ANTERIOR,
                                    ESTADO_NUEVO,
                                    USER_,
                                    REGISTER_DATE,
                                    COMMENT_,
                                    TERMINAL)
                         VALUES (SEQ_LDC_RESULT_PROCESS.NEXTVAL,
                                 :new.TRSMCODI,
                                 NVL (:OLD.TRSMESTA, 0),
                                 :NEW.TRSMESTA,
                                 USER,
                                 SYSDATE,
                                 :NEW.TRSMCOME,
                                 NVL (USERENV ('TERMINAL'), '--'));
                END IF;

                IF :NEW.TRSMOBSE IS NULL
                THEN
                    sbErrorMsg := 'El comentario no puede ser nulo.';

                    pkg_error.setErrorMessage( isbMsgErrr => sbErrorMsg);
                END IF;
            END IF;
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
END TGR_BU_LDCI_TRANSOMA;
/