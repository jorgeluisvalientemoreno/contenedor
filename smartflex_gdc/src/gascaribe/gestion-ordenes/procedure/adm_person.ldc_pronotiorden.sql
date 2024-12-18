CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRONOTIORDEN
IS
    /**************************************************************************
        Autor       : Miguel Angel Ballesteros Gomez / Horbath
        Fecha       : 2019-03-27
        Ticket      : 200-2402
        Descripcion : Procedimiento que envia correos de acuerdo con la causal
                      que se este legalizando

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA            AUTOR             DESCRIPCION
        14/05/2024       jpinedc           OSF-2581:  Se cambia ldc_sendemail por
                                            pkg_Correo.prcEnviaCorreo
        24/04/2024       PACOSTA           OSF-2596: Se retira el llamado al esquema OPEN (open.)
                                           Se crea el objeto en el esquema adm_person
        17/06/2020       OLSOFTWARE        CASO 300 - Se modifica el plugin para poder agregar los campos
                                           (Medio de Recepcion, Unidad operativa, Departamento y localidad)
   ***************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) :=  'LDC_PRONOTIORDEN';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    nuOrden                         or_order.order_id%type;
    nuCausalId                      ge_causal.causal_id%type;
    nuTaskTypeId                    or_order.task_type_id%type;
    osbErrorMessage                 VARCHAR2(2000);
    cadenaXSL                       VARCHAR2(3000);
    subject                         varchar2(3000); --- asunto del correo a enviar

    cursor cuTTCausal(nuTipoTrabajo IN or_order.task_type_id%type, nuCausal IN or_order.causal_id%type) is
      select conf.NOTIFICATION_ID notificacion, conf.DESTINATARIOS emails
      from LDCCONFORD conf
      where conf.TASK_TYPE_ID = nuTipoTrabajo
      and   conf.CAUSAL_ID = nuCausal;

    cursor cuGetPackIdTyProd(OrdenId IN or_order.order_id%type) is
        select oo.CAUSAL_ID ||' - '|| ge.DESCRIPTION causal,
               oo.TASK_TYPE_ID||' - '||DAOR_TASK_TYPE.FSBGETDESCRIPTION(OO.TASK_TYPE_ID, NULL) TIPO_TRAB,
               act.package_id solicitud,
               mo.PACKAGE_TYPE_ID ||' - '|| mops.DESCRIPTION tipo_solicitud,
               act.PRODUCT_ID producto,
               -- MODIFICACION CASO 300 --
               mo.reception_type_id||' - '||dage_reception_type.fsbgetdescription(mo.reception_type_id, null) medio_recepcion,
               oo.operating_unit_id||' - '||daor_operating_unit.fsbgetname(oo.operating_unit_id, null) unidad_operativa,
               daab_address.fnugetgeograp_location_id(act.address_id)||' - '||
               DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION(daab_address.fnugetgeograp_location_id(act.address_id),NULL) Localidad,
               dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(act.address_id))||' - '||
               decode(dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(act.address_id)),2,  'CESAR', 3, 'ATLANTICO', 'MAGDALENA') Departamento
               -- FIN MODIFICACION CASO 300 --
        from OR_ORDER_ACTIVITY act,
             or_order oo,
             MO_PACKAGES mo,
             PS_PACKAGE_TYPE mops,
             ge_causal ge
        where oo.order_id = act.ORDER_ID
        and   act.PACKAGE_ID = mo.PACKAGE_ID
        and   mo.PACKAGE_TYPE_ID = mops.PACKAGE_TYPE_ID
        and   ge.CAUSAL_ID = oo.CAUSAL_ID
        and   act.order_id = OrdenId;

    InfoOrden_rec                 cuGetPackIdTyProd%ROWTYPE;
    notiEmails_rec                cuTTCausal%ROWTYPE;

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

    subject:= 'Legalizacion de Orden';

    nuOrden       := or_bolegalizeorder.fnuGetCurrentOrder; -- se obtiene el id de la orden que se intenta legalizar

    nuCausalId := daor_order.fnugetcausal_id(nuOrden,null); -- se obtiene el causal con el que se legaliza la orden
    nuTaskTypeId := daor_order.FNUGETTASK_TYPE_ID(nuOrden);

    -- se recorre el cursor para obtener los valores de la orden
    OPEN cuGetPackIdTyProd(nuOrden);
    FETCH cuGetPackIdTyProd into InfoOrden_rec;
    CLOSE cuGetPackIdTyProd;

    -- este cursor obtiene la notificacion y el email de los valores del tipo de trabajo y el causal
    OPEN cuTTCausal(nuTaskTypeId, nuCausalId);
    FETCH cuTTCausal INTO notiEmails_rec;
    CLOSE cuTTCausal;

    if(notiEmails_rec.notificacion > 0 and notiEmails_rec.notificacion is not null) then

        select t.TEMPLATE_SOURCE into cadenaXSL
        from GE_NOTIFICATION n, GE_XSL_TEMPLATE t
        where  n.XSL_TEMPLATE_ID = t.XSL_TEMPLATE_ID
        and n.NOTIFICATION_ID = notiEmails_rec.notificacion;

        -- el reemplazo de los valores se toma de una consulta que me trae cada dato, esto es solo de prueba, hay que saber como trae los datos de la orden cuando se dispara el plugin
        cadenaXSL := replace(cadenaXSL, '<COD_ORDEN>', nuOrden);
        cadenaXSL := replace(cadenaXSL, '<CAUSAL>', InfoOrden_rec.causal);
        cadenaXSL := replace(cadenaXSL, '<TIPO_TRABAJO>', InfoOrden_rec.TIPO_TRAB);
        cadenaXSL := replace(cadenaXSL, '<SOLICITUD>', InfoOrden_rec.solicitud);
        cadenaXSL := replace(cadenaXSL, '<TIPO_SOLICITUD>', InfoOrden_rec.tipo_solicitud);
        cadenaXSL := replace(cadenaXSL, '<PRODUCTO>', InfoOrden_rec.producto);
        cadenaXSL := replace(cadenaXSL, '<DEPART>', InfoOrden_rec.Departamento);  -- CASO 300
        cadenaXSL := replace(cadenaXSL, '<LOCALIDAD>', InfoOrden_rec.Localidad);  -- CASO 300
        cadenaXSL := replace(cadenaXSL, '<UNIDAD_TRABAJO>', InfoOrden_rec.unidad_operativa); -- CASO 300
        cadenaXSL := replace(cadenaXSL, '<MED_RECEP>', InfoOrden_rec.medio_recepcion);  -- CASO 300

        pkg_Traza.Trace(cadenaXSL);

        if(notiEmails_rec.emails is not null)then

            DECLARE

              cursor cuEmails is
              select column_value
              from table(ldc_boutilities.splitstrings(notiEmails_rec.emails, ','));

            BEGIN

                FOR item IN cuEmails
                LOOP
                    pkg_Traza.Trace ('Emails = ' || item.column_value);

                    pkg_Correo.prcEnviaCorreo
                    (
                        isbRemitente        => sbRemitente,
                        isbDestinatarios    => item.column_value,
                        isbAsunto           => subject,
                        isbMensaje          => cadenaXSL
                    );                             

                END LOOP;

            END;

        end if;

    end if;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

EXCEPTION
    when pkg_Error.CONTROLLED_ERROR then
        IF osbErrorMessage IS NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'ERROR PLUGIN LDC_PRONOTIORDEN' );
        ELSE
            pkg_error.setErrorMessage( isbMsgErrr => osbErrorMessage );
        END IF;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
END LDC_PRONOTIORDEN;
/
