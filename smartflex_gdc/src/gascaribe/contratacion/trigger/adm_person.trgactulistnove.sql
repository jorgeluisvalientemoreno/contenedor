CREATE OR REPLACE TRIGGER ADM_PERSON.TRGACTULISTNOVE
BEFORE INSERT OR UPDATE  ON GE_UNIT_COST_ITE_LIS 
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
 /**************************************************************************
    Autor       :  OLSOFTWARE
    Fecha       : 2020-02-20
    Ticket      : 350
    Proceso     : TRGACTULISTNOVE
    Descripcion : trigger que actualiza informacion de lista de costo de
        pagos de contratista

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR              DESCRIPCION
    27/02/2023   felipe.valencia    OSF898 -Se modifica el trigger para validar 
                                    solo cuando se esten actualizando actividades
                                    principales. Tambien se modifica procedimiento
                                    de envio de correo por ldc_sendemail
    25/04/2024   lubin.pineda    OSF-2581 - Se cambia ldc_sendemail por
                                    pkg_Correo.prcEnviaCorreo
  ***************************************************************************/
  --se valida si existe tarifa de pago de contratista
DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) := 'TRGACTULISTNOVE';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError          NUMBER;
    sbError          VARCHAR2(4000);    
        
    CURSOR cuExistLista IS
    SELECT t.ROWID ,unidad_oper, tipo_trabajo
    FROM ldc_tarifas_otgepacont t, ge_list_unitary_cost l, OR_TASK_TYPES_ITEMS TI
    WHERE unidad_oper = l.operating_unit_id
    AND l.list_unitary_cost_id = :NEW.list_unitary_cost_id
    AND t.TIPO_TRABAJO = TI.TASK_TYPE_ID
    AND TI.ITEMS_ID = :NEW.items_id;
    
    CURSOR cuNoEsNovedad
    (
        inuItemId   IN  ge_items.items_id%TYPE
    )
    IS
    SELECT  items_id
    FROM    ge_items gi
    WHERE   gi.item_classif_id = 2
    AND NOT EXISTS (SELECT c.items_id FROM CT_ITEM_NOVELTY c where c.items_id = gi.items_id)
    AND     gi.items_id = inuItemId;
   
    sbRowId         VARCHAR2(2000);
    nuUnidad        NUMBER;
    nuTipoTrabajo   or_task_type.task_type_id%TYPE;
    nuItem          ge_items.items_id%TYPE;

    -- Destinatarios
    sbto        Varchar2(4000) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_EMALNOTLINO');
    sbsubject   Varchar2(4000) := 'Sincronizacion de Tarifa para Novedad de pago por gestion de contratista';
    sbsmessage  Varchar2(4000);
    
    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');


BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    OPEN cuExistLista;
    FETCH cuExistLista INTO sbRowId, nuUnidad, nuTipoTrabajo;
    
    pkg_traza.trace('sbRowId|' || sbRowId, csbNivelTraza);  
    pkg_traza.trace('nuUnidad|' || nuUnidad, csbNivelTraza);
    pkg_traza.trace('nuTipoTrabajo|' || nuTipoTrabajo, csbNivelTraza);
    
    IF cuExistLista%FOUND THEN
    
        pkg_traza.trace('cuExistLista%FOUND', csbNivelTraza);    
    
        OPEN cuNoEsNovedad(:NEW.items_id);
        FETCH cuNoEsNovedad INTO nuItem;
        CLOSE cuNoEsNovedad;

        pkg_traza.trace( 'nuItem|' || nuItem, csbNivelTraza);
            
        IF (nuItem IS NOT NULL) THEN
            UPDATE ldc_tarifas_otgepacont SET VALOR_NOVEDAD = :NEW.PRICE
            WHERE ROWID = sbRowId;

            sbsmessage := 'Se actualizó precio al items ['||:NEW.items_id
                            ||'] de la unidad operativa ['||nuUnidad||'] '||
                            'y tipo de trabajo ['||nuTipoTrabajo||']';
                            
            --se envia correo                
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbto,
                isbAsunto           => sbsubject,
                isbMensaje          => sbsmessage
            );
                                            
        END IF;
                        
    END IF;
    CLOSE cuExistLista;
    
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
END TRGACTULISTNOVE;
/