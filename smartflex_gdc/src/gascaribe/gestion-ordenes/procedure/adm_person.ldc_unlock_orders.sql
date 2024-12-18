create or replace PROCEDURE ADM_PERSON.LDC_UNLOCK_ORDERS IS
/* ****************************************************************
Propiedad intelectual de Gases del caribe

Objeto: ADM_PERSON.LDC_UNLOCK_ORDERS
Descripcion: 

Autor  : 

Historial de Modificaciones
Caso           Fecha            Autor       Modificacion
OSF-2606        26/06/2024      jpinedc     * Se usa pkg_Correo
                                            * Ajustes por  estándares
*/

    csbMetodo        CONSTANT VARCHAR2(70) :=  'ADM_PERSON.LDC_UNLOCK_ORDERS';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
    cuOrdersLock     constants.tyRefCursor;
    rwOrdersLock     or_order_activity.order_id%type;
    sbActivaOts      ld_parameter.value_chain%type;
    sbTaskType       ld_parameter.value_chain%type;
    sbDestinatarios         ld_parameter.value_chain%type;
    nuOrder          or_order.order_id%type;
    nuPackageId      or_order_activity.package_id%type;
    nucontrato       or_order_activity.subscription_id%type;
    nuproducto       or_order_activity.product_id%type;
    sbLocalidad      ge_geogra_location.description%type;
    sbDireccion      ab_address.address%type;
    sbOrderUnlock    varchar2(400);
    sbComment        or_order_activity.comment_%type;
    sbQuery          varchar2(1000);
    nuTipoComentario number;

    cursor cuPacakge(inuOrderId in or_order_activity.package_id%type) is
    select package_id, subscription_id, product_id
      from or_order_activity
     where order_id = inuOrderId
       and rownum = 1;

    sbMensaje   VARCHAR2(4000);
        
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
    
    sbActivaOts      := pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_ACTIVA_DESBLOQ_OTS');
    sbComment        := 'ORDEN DESBLOQUEADA POR PLUGIN LDC_UNLOCK_ORDERS';
    nuTipoComentario := 3;
    IF sbActivaOts = 'Y' THEN

        pkg_Traza.Trace('Se obtiene la orden de la instancia', csbNivelTraza);

        nuOrder := or_bolegalizeorder.fnuGetCurrentOrder;

        pkg_Traza.Trace('Orden a legalizar ' || nuOrder, csbNivelTraza);

        pkg_Traza.Trace('Se obtiene la solicitud asociada a la orden', csbNivelTraza);

        open cuPacakge(nuOrder);
        fetch cuPacakge
          into nuPackageId, nucontrato, nuproducto;
        close cuPacakge;

        pkg_Traza.Trace('Solicitud asociada a la orden ' || nuPackageId, csbNivelTraza);

        sbTaskType := pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_TASK_TYPE_BLOQ');

        IF nuPackageId is not null THEN

            sbOrderUnlock := '';

            pkg_Traza.Trace('Se recorre cursor que obtiene las ordenes bloqueadas', csbNivelTraza);

            sbQuery := 'select distinct ooa.order_id
                            from or_order_activity ooa,or_order oo
                            where ooa.order_id = oo.order_id
                            and ooa.package_id = :inPackageId
                            and ooa.order_id <> :inOrderId
                            and oo.order_status_id = 11
                            and oo.task_type_id in (' ||
                     sbTaskType || ')';

            OPEN cuOrdersLock for sbQuery
            using nuPackageId, nuOrder;
            LOOP
                FETCH cuOrdersLock
                  INTO rwOrdersLock;
                EXIT WHEN cuOrdersLock%NOTFOUND;
 
                API_UNLOCKORDER (   inuOrderId => rwOrdersLock,
                                    inuTipoComentario => nuTipoComentario,
                                    isbComentario => sbComment,
                                    onuErrorCode => nuError,
                                    osbErrorMessage => sbError
                                );
                                    
                IF nuError <> 0 THEN
                    RAISE pkg_Error.CONTROLLED_ERROR;
                END IF;

                sbOrderUnlock := sbOrderUnlock || to_char(rwOrdersLock) || ',';

            END LOOP;
            CLOSE cuOrdersLock;

            sbDestinatarios := pkg_BCLD_Parameter.fsbObtieneValorCadena('LD_MAIL_NOTIF_OT_BLOQ');
            sbDestinatarios := replace(sbDestinatarios, '|', ';');

            --Obtiene direccion
            BEGIN
                SELECT g.geograp_location_id || ' - ' || g.description "LOCALIDAD",
                   a.address "DIRECCION"
                INTO sbLocalidad, sbDireccion
                FROM pr_product p, ab_address a, ge_geogra_location g
                WHERE p.address_id = a.address_id
                AND a.geograp_location_id = g.geograp_location_id
                AND p.product_id = nuproducto;
            EXCEPTION
                WHEN OTHERS THEN
                    sbLocalidad := ' ';
                    sbDireccion := ' ';
            END;

            IF sbDestinatarios is not null THEN

                pkg_Traza.Trace('Envio de correos por medio del servicio pkg_Correo.prcEnviaCorreo', csbNivelTraza);
                               
                sbMensaje := 'El contrato: ' || nucontrato || ', solicitud: ' ||
                               nuPackageId || ' de las ordenes ' || sbOrderUnlock ||
                               ' fueron desbloqueadas por causal Direccion Errada [Direccion: ' ||
                               sbDireccion || ', Localidad: ' || sbLocalidad ||
                               '], mediante el plugin LDC_UNLOCK_ORDERS';
                                              
                pkg_Traza.Trace( sbMensaje, csbNivelTraza);
                               
                pkg_Correo.prcEnviaCorreo
                (
                    isbDestinatarios    => sbDestinatarios,
                    isbAsunto           => 'Desbloqueo de ordenes',
                    isbMensaje          => sbMensaje
                );
                
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
END LDC_UNLOCK_ORDERS;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_UNLOCK_ORDERS', 'ADM_PERSON');
END;
/

