CREATE OR REPLACE TRIGGER adm_person.LDCTRG_BSS_SUCUBANC
    AFTER INSERT
    ON SUCUBANC
    REFERENCING OLD AS old NEW AS new
    FOR EACH ROW
/**************************************************************
Propiedad intelectual PETI.

Trigger  :  LDCTRG_BSS_SUCUBANC

Descripción  : Envia correo al momento de adicionar una
               nueva sucursal bancaria (Punto de Venta).

Autor  : Jorge valiente
Fecha  : 14-02-2013

Historia de Modificaciones
jpinedc     29/04/2024      OSF-2581: Se reemplaza ldc_sendemail
                            por pkg_Correo.prcEnviaCorreo
jpinedc		17/10/2024		OSF-3450: Se migra a ADM_PERSON							
**************************************************************/

DECLARE

    csbMetodo        CONSTANT VARCHAR2(70) :=  'LDCTRG_BSS_SUCUBANC';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);  
    
    nuErrCode   NUMBER;
    sbErrMsg    VARCHAR2 (2000);
    sbIssue     VARCHAR2 (4000);
    sbMessage   VARCHAR2 (4000);
    
    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    sbDestinatario  ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena ('PAR_EMAIL_SUCUBANC');
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    IF NVL (UPPER (:new.subanomb), NULL) = 'PENDIENTE POR DEFINIR'
    THEN
        sbIssue :=
               'Nueva Sucursal (Punto de Venta) en el Banco ['
            || :new.SUBABANC
            || '-'
            || dabanco.fsbgetbancnomb (:new.SUBABANC)
            || ']';

        sbMessage :=
               'De la entidad de recaudo '
            || :new.SUBABANC
            || '-'
            || dabanco.fsbgetbancnomb (:new.SUBABANC)
            || ', se recibieron cupones recaudados en la sucursal '
            || :new.subacodi
            || ' PENDIENTE POR DEFINIR  la cual no se encontraba creada en la base de datos. Esta sucursal se creó con la información bÃ¡sica. Por favor complemente dicha información';

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbDestinatario,
            isbAsunto           => sbIssue,
            isbMensaje          => sbMessage
        );
            
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
EXCEPTION
    WHEN OTHERS
    THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);     
        pkg_Error.setError;
        pkg_Error.getError (nuErrCode, sbErrMsg);
        pkg_traza.trace('sbErrMsg => ' || sbErrMsg , csbNivelTraza);         
        sbIssue := 'Error en SUCUBANC ';
        sbMessage :=
               'Codigo Error: '
            || nuErrCode
            || CHR (10)
            || 'Descripción'
            || sbErrMsg;

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbDestinatario,
            isbAsunto           => sbIssue,
            isbMensaje          => sbMessage
        );
        
END LDCTRG_BSS_SUCUBANC;
/