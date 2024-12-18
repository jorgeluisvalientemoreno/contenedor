CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_ARTICLE
    AFTER INSERT OR UPDATE
    ON LD_ARTICLE
    REFERENCING OLD AS old NEW AS new
    FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  trgAiurLd_Article

Descripcion   : Trigger que envÍa notificación cuando se crea o se modifica un artÍculo

Autor         : Evelio Sanjuanelo
Fecha         : 18-06-2013

    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    06/06/2024          jpinedc             OSF-2601: Ajustes por estandares
**************************************************************/
DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) := 'TRGAIURLD_ARTICLE';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
    UserType       VARCHAR2 (2);
    sbNombreProveedor   ge_contratista.nombre_contratista%TYPE;
    sbEstadoAnterior       VARCHAR2 (15);
    sbEstadoNuevo       VARCHAR2 (15);
    sbMensaje      VARCHAR2 (2000);
    sbDestinatarios       ge_contratista.correo_electronico%TYPE;

    --Parámetro que contiene el correo del funcionario encargado de la forma
    sbRemitente      ld_parameter.value_chain%TYPE
                       := pkg_BCLD_Parameter.fsbObtieneValorCadena ('EMAIL_ENV_FNB');
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    UserType := ld_bopackagefnb.fsbGetTypeUser;

    IF (INSERTING)
    THEN
        --Si el usuario conectado es un proveedor
        IF (UserType = 'C')
        THEN
            --Se obtiene el Nombre y Mail del Proveedor Conectado
            ld_bcportafolio.FnuGetMailNameSupplier (sbDestinatarios, sbNombreProveedor);

            IF (sbDestinatarios IS NOT NULL)
            THEN
                sbMensaje :=
                       'El proveedor '
                    || sbNombreProveedor
                    || ' ha creado el Artículo: '
                    || :new.article_id
                    || '- '
                    || :new.description;
    
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => sbDestinatarios,
                    isbDestinatarios    => sbRemitente,
                    isbAsunto           => 'Nuevo Artículo: ' || :new.description,
                    isbMensaje          => sbMensaje,
                    isbDescRemitente    => 'Se ha creado un nuevo Artículo'
                );                    
                    
            END IF;
        END IF;

        IF (UserType = 'F')
        THEN
            IF (:new.approved = 'Y')
            THEN
                sbEstadoNuevo := 'APROBADO';
            ELSIF (:new.approved = 'N')
            THEN
                sbEstadoNuevo := 'NO APROBADO';
            ELSE
                sbEstadoNuevo := 'PENDIENTE';
            END IF;

            --Si un funcionario crea un articulo, con el proveedor X, validamos el mail del X, y le
            --Enviamos un mail informandole que se le ha configurado Y Articulo
            --Se consulta el correo electronico del proveedor del articulo creado
            sbDestinatarios := DAGE_CONTRATISTA.fsbGetCorreo_Electronico (inuId_Contratista   => :new.supplier_id);

            IF (sbDestinatarios IS NOT NULL)
            THEN
                sbMensaje :=
                       'Se ha creado el Artículo '
                    || :new.article_id
                    || '- '
                    || :new.description
                    || ' en estado '
                    || sbEstadoNuevo;

                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => sbRemitente,
                    isbDestinatarios    => sbDestinatarios,
                    isbAsunto           => 'Nuevo Artículo: ' || :new.article_id || '- '|| :new.description,
                    isbMensaje          => sbMensaje,
                    isbDescRemitente    => 'Nuevo Artículo configurado'
                );

            END IF;
        END IF;
    END IF;

    IF (UPDATING)
    THEN
        IF (UserType = 'F')
        THEN
            IF (:new.approved <> :old.approved)
            THEN
                IF (:old.approved = 'Y')
                THEN
                    sbEstadoAnterior := 'APROBADO';
                ELSIF (:old.approved = 'N')
                THEN
                    sbEstadoAnterior := 'NO APROBADO';
                ELSE
                    sbEstadoAnterior := 'PENDIENTE';
                END IF;

                IF (:new.approved = 'Y')
                THEN
                    sbEstadoNuevo := 'APROBADO';
                ELSIF (:new.approved = 'N')
                THEN
                    sbEstadoNuevo := 'NO APROBADO';
                ELSE
                    sbEstadoNuevo := 'PENDIENTE';
                END IF;

                --Si un funcionario crea un articulo, con el proveedor X, validamos el mail del X, y le
                --Enviamos un mail informandole que se le ha configurado Y Articulo
                --Se consulta el correo electronico del proveedor del articulo creado
                sbDestinatarios := DAGE_CONTRATISTA.fsbGetCorreo_Electronico (inuId_Contratista   => :new.supplier_id);

                IF (sbDestinatarios IS NOT NULL)
                THEN

                    sbMensaje :=
                           'El Artículo '
                        || :old.article_id
                        || '- '
                        || :old.description
                        || ' ha cambiado su estado de '
                        || sbEstadoAnterior
                        || ' a '
                        || sbEstadoNuevo;

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => sbDestinatarios,
                        isbAsunto           => 'Nuevo estado, Artículo: '|| :old.article_id|| '- '|| :old.description,
                        isbMensaje          => sbMensaje,
                        isbDescRemitente    => 'Nuevo estado de Artículo'
                    );                        
                        
                END IF;
            END IF;
        END IF;

        -------------------------------------------------------------------------
        -------------------------------------------------------------------------
        IF (UserType = 'C')
        THEN
            IF    (:new.active <> :old.active)
               OR (:new.avalible <> :old.avalible)
               OR (:new.brand_id <> :old.brand_id)
               OR (:new.concept_id <> :old.concept_id)
               OR (:new.description <> :old.description)
               OR (:new.equivalence <> :old.equivalence)
               OR (:new.financier_id <> :old.financier_id)
               OR (:new.installation <> :old.installation)
               OR (:new.observation <> :old.observation)
               OR (:new.price_control <> :old.price_control)
               OR (:new.reference <> :old.reference)
               OR (:new.subline_id <> :old.subline_id)
               OR (:new.vat <> :old.vat)
               OR (:new.warranty <> :old.warranty)
            THEN
                --Se obtiene el Nombre y Mail del Proveedor Conectado
                ld_bcportafolio.FnuGetMailNameSupplier (sbDestinatarios,
                                                        sbNombreProveedor);

                IF (sbDestinatarios IS NOT NULL)
                THEN
                    sbMensaje :=
                           'El proveedor '
                        || sbNombreProveedor
                        || ' ha modificado el Artículo: '
                        || :new.article_id
                        || '- '
                        || :new.description;

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbDestinatarios,
                        isbDestinatarios    => sbRemitente,
                        isbAsunto           => 'Artículo actualizado: ' || :new.description,
                        isbMensaje          => sbMensaje,
                        isbDescRemitente    => 'Artículo actualizado'
                    );
                        
                END IF;
            END IF;
        END IF;
    -------------------------------------------------------------------------
    -------------------------------------------------------------------------

    END IF;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
END trgAiurLd_Article;
/