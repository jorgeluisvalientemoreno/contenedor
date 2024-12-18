create or replace TRIGGER ADM_PERSON.TRG_ULT_OT_RP  BEFORE INSERT
ON MO_PACKAGES
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : TRG_ULT_OT_RP
  Descripcion : trigger que permitirá establecer la última orden 10833 o 10723 
                legalizada y validar si causal legalización y obtener su 
                unidad operativa siempre que la solicitud creada sea del tipo 
                100294
  Autor       : Horbath
  Ticket      : 213
  Fecha       : 08-07-2020

Historia de Modificaciones
Fecha               Autor               Modificacion
=========           =========           ====================
27/09/2021          GDC                 CAMBIO 836. Creacion de subproceso para recupra la DATA de la nueva entidad LDC_CONDEFRP
                                                   Reemplazar el servicio LDC_PRUODEFECTO por el nuevo subproceso
30/09/2024          jpinedc             OSF-3368: * Ajustes por últimos estandares
                                        * Sólo se se ejecuta LDC_PROCREAREGASIUNIOPREVPER
                                        si no existe registro en Ldc_Asigna_Unidad_Rev_Per
                                        para la solicitud
**************************************************************************/
DECLARE

    csbMetodo                   CONSTANT VARCHAR2(70) := 'TRG_ULT_OT_RP';
    csbNivelTraza               CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;    
    nuError                     NUMBER;
    sbError                     VARCHAR2(4000);

    nuProduct                   pr_product.product_id%type; --caso: 213
    nuUnidadOpe                 or_operating_unit.OPERATING_UNIT_ID%type;

    nuCantReparaciones          number;

    sbTitrCausal                ld_parameter.value_chain%type := pkg_BCLD_Parameter.fsbObtieneValorCadena('TITR_CAUSAL_LEGALIZA_REPA');
    sbMensajeCausal             varchar2(4000):='GENERA TRAMITE REPARACION PRP XML AL LEGALIZAR ORDEN';
    sbMensajeCausal2            varchar2(4000):='CON CAUSAL :';
    sbOrdenPadre                mo_packages.comment_%type;
    nuOrdenPadre                or_order.order_id%type;
    nuPosComRegSolRepXMLxLega   number;
    nuTITR_CAUSAL_LEGALIZA_REPA number;
    nuTitrPadre                 or_order.task_type_id%type;
    nuCausPadre                 or_order.causal_id%type;
    
    csbCOD_ACTI_DEF             CONSTANT LD_Parameter.Value_Chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_ACTI_DEF');
    csbCOD_CAU_DEF              CONSTANT LD_Parameter.Value_Chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_CAU_DEF');
 
    CURSOR CUCANTIDADOT ( PRODUCTO number, FECHALEGLIZACION date ) IS
    SELECT count(*) FROM OR_ORDER O, OR_ORDER_ACTIVITY OA
    WHERE O.ORDER_ID = OA.ORDER_ID
    AND OA.PRODUCT_ID=PRODUCTO
    and trunc(O.LEGALIZATION_DATE) >= trunc(FECHALEGLIZACION)
    AND O.ORDER_STATUS_ID = 8
    AND NOT EXISTS(SELECT NULL FROM CT_ITEM_NOVELTY N WHERE N.ITEMS_ID=OA.ACTIVITY_ID)
    and OA.ACTIVITY_ID in 
    (
        SELECT to_number(regexp_substr(csbCOD_ACTI_DEF,'[^,]+', 1,LEVEL))
        FROM dual
        CONNECT BY regexp_substr(csbCOD_ACTI_DEF, '[^,]+', 1, LEVEL) IS NOT NULL
    )
    and O.CAUSAL_ID in 
    (
        SELECT to_number(regexp_substr(csbCOD_CAU_DEF,'[^,]+', 1,LEVEL))
        FROM dual
        CONNECT BY regexp_substr(csbCOD_CAU_DEF, '[^,]+', 1, LEVEL) IS NOT NULL
    );

    sbInstance VARCHAR2(4000);
    sbproducto VARCHAR2(4000);
    sbOutAtri  varchar2(4000):='1';
    
    CURSOR cuLdc_Asigna_Unidad_Rev_Per( inuSolicitud mo_packages.package_id%TYPE)
    IS
    SELECT Solicitud_Generada
    FROM Ldc_Asigna_Unidad_Rev_Per
    WHERE Solicitud_Generada = inuSolicitud;
    
    nuSolicitud_Generada Ldc_Asigna_Unidad_Rev_Per.Solicitud_Generada%TYPE;
    
    --Procedimiento para establecer el producto y la actividad asociada a la orden
    PROCEDURE LDC_PRREPACAIONDEFECTO(inuProducto  NUMBER,
                            onuCONTEO OUT NUMBER,
                            onuUNIOPE OUT NUMBER) 
    IS
        
        CURSOR cuLDC_CONDEFRP
        IS
        select reparacion,unidad_operativa 
        from LDC_CONDEFRP 
        where PRODUCTO = inuProducto;

    BEGIN
    
        onuCONTEO := 0;
        onuUNIOPE := 0;

        OPEN cuLDC_CONDEFRP;
        FETCH cuLDC_CONDEFRP INTO onuCONTEO, onuUNIOPE;
        CLOSE cuLDC_CONDEFRP;

        onuCONTEO := nvl(onuCONTEO,0);
        onuUNIOPE := nvl(onuUNIOPE,-1);

    EXCEPTION
        WHEN others THEN
            onuCONTEO := 0;
            onuUNIOPE := -1;
    END LDC_PRREPACAIONDEFECTO;


BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 

    pkg_traza.trace('NEW.PACKAGE_ID|' || :NEW.PACKAGE_ID, csbNivelTraza);  
    pkg_traza.trace('NEW.PACKAGE_TYPE_ID|' || :NEW.PACKAGE_TYPE_ID, csbNivelTraza);  
                
	IF :NEW.PACKAGE_TYPE_ID = 100294  THEN

        sbInstance:='M_MOTIVO_SOLICITUD_REPARACION_PRP_100289-2';
        if GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK('WORK_INSTANCE', NULL, 'PR_PRODUCT', 'PRODUCT_ID',sbOutAtri) =  CONSTANTS_PER.getTrue then
           prc_ObtieneValorInstancia('WORK_INSTANCE', NULL, 'PR_PRODUCT', 'PRODUCT_ID', sbproducto);
        else

           if GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, NULL, 'MO_MOTIVE', 'PRODUCT_ID', sbOutAtri) =  CONSTANTS_PER.getTrue then
              prc_ObtieneValorInstancia(sbInstance, NULL, 'MO_MOTIVE', 'PRODUCT_ID', sbproducto);
           end if;
        end if;
    
        if sbproducto is not null then
            nuProduct := to_number(sbproducto);
            pkg_traza.trace('nuProduct|' || nuProduct, csbNivelTraza);             
        end if;
    
        sbOrdenPadre := null;
        nuOrdenPadre    := null;
        nuPosComRegSolRepXMLxLega       := 0;
        nuTITR_CAUSAL_LEGALIZA_REPA       := 0;
        nuTitrPadre     := null;
        nuCausPadre     := null;

        pkg_traza.trace('sbTitrCausal|' || sbTitrCausal, csbNivelTraza); 
                
        if sbTitrCausal is not null then
            nuPosComRegSolRepXMLxLega := instr(:NEW.COMMENT_,sbMensajeCausal);

            pkg_traza.trace('nuPosComRegSolRepXMLxLega|' || nuPosComRegSolRepXMLxLega, csbNivelTraza);
                    
            if nuPosComRegSolRepXMLxLega > 0 then
                sbOrdenPadre :=trim(replace(substr(:NEW.COMMENT_,  nuPosComRegSolRepXMLxLega +55 ),substr(:NEW.COMMENT_, instr(:NEW.COMMENT_,sbMensajeCausal2,nuPosComRegSolRepXMLxLega)),''));
                begin
                       nuOrdenPadre := to_number(sbOrdenPadre);
                       nuTitrPadre  := pkg_BCOrdenes.fnuObtieneTipoTrabajo(nuOrdenPadre);
                       nuCausPadre  := pkg_BCOrdenes.fnuObtieneCausal (nuOrdenPadre);
                       nuTITR_CAUSAL_LEGALIZA_REPA := instr(sbTitrCausal,nuTitrPadre||'|'||nuCausPadre||',');
                exception
                  when others then
                       nuOrdenPadre:=0;
                end;
            end if;
        else
            nuTITR_CAUSAL_LEGALIZA_REPA := 0;
        end if;

        LDC_PRREPACAIONDEFECTO(nuProduct,nuCantReparaciones,nuUnidadOpe);

        pkg_traza.trace('nuCantReparaciones|' || nuCantReparaciones, csbNivelTraza);  
        pkg_traza.trace('nuUnidadOpe|' || nuUnidadOpe, csbNivelTraza);
                
        IF nuUnidadOpe <> -1 and nuTITR_CAUSAL_LEGALIZA_REPA = 0 THEN
        
            OPEN cuLdc_Asigna_Unidad_Rev_Per(:NEW.PACKAGE_ID);
            FETCH cuLdc_Asigna_Unidad_Rev_Per INTO nuSolicitud_Generada;
            CLOSE cuLdc_Asigna_Unidad_Rev_Per;

            pkg_traza.trace('nuSolicitud_Generada|' || nuSolicitud_Generada, csbNivelTraza);  
    
            -- Se inserta solo si no existe ya un registro para la nueva solicitud
            IF nuSolicitud_Generada IS NULL THEN
            
                LDC_PROCREAREGASIUNIOPREVPER(
                              nuUnidadOpe,
                              nuProduct,
                              nuTitrPadre,
                              nuOrdenPadre,
                              :NEW.PACKAGE_ID  );

            END IF;
            
        END IF;

        :NEW.COMMENT_ := 'Reparacion Nro : '||(nuCantReparaciones+1)||'. '||:NEW.COMMENT_;

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
END TRG_ULT_OT_RP ;
/