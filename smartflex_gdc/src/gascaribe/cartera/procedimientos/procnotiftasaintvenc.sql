CREATE OR REPLACE PROCEDURE PROCNOTIFTASAINTVENC
IS
    /*******************************************************************************
    Propiedad intelectual Horbath.

    Autor         : DVALIENTE
    Fecha         : 13-08-2021
    DESCRIPCION   : Procedimiento para notificar via mail las tasas de intereses vencidas.
    CASO          : 814

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================
    30/04/2024      OSF-2581            Se reemplaza ldc_sendemail por pkg_Correo.prcEnviaCorreo
    *******************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) :=  'PROCNOTIFTASAINTVENC';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);     
    
    nuparano             NUMBER (4);
    nuparmes             NUMBER (2);
    nutsess              NUMBER;
    sbparuser            VARCHAR2 (30);
    nuDiasVenc           NUMBER
        := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('PARDIASPARAVENCTI');
    sbTasa               VARCHAR2 (1000);
    dtFechaTasa          DATE;
    sbPorcentaje         VARCHAR2 (20);

    CURSOR curTasas IS
        SELECT t.taincodi || ' - ' || t.taindesc,
               TO_CHAR (c.cotifefi, 'dd-mm-yyyy'),
               TO_CHAR (c.cotiporc, '00.000'),
               TRUNC (c.cotifefi) - TRUNC (SYSDATE)
          FROM tasainte t, conftain c
         WHERE     t.taincodi = c.cotitain
               AND TRUNC (c.cotifefi) - TRUNC (SYSDATE) BETWEEN 1
                                                            AND nuDiasVenc;

    sbTablaMail          VARCHAR2 (4000);
    sbDestinatariosmail   ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena ('PARDESTINATARIOSVTI');

    sbMsg                VARCHAR2 (4000) := NULL;
    nuCont               NUMBER := 0;
    
    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
        
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    -- Consultamos datos para inicializar el proceso
    nuparano    :=  TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
    nuparmes    :=  TO_NUMBER (TO_CHAR (SYSDATE, 'MM'));
    nutsess     :=  USERENV ('SESSIONID');
    sbparuser   :=  USER;

    -- Inicializamos el proceso
    ldc_proinsertaestaprog (nuparano,
                            nuparmes,
                            'PROCNOTIFTASAINTVENC',
                            'En ejecucion',
                            nutsess,
                            sbparuser);
 
    sbTablaMail := NULL;
    
    OPEN curTasas;

    LOOP
        FETCH curTasas
            INTO sbTasa,
                 dtFechaTasa,
                 sbPorcentaje,
                 nuDiasVenc;

        EXIT WHEN curTasas%NOTFOUND;
        sbTablaMail :=
               '<tr><td align=center>'
            || sbTasa
            || '</td><td align=center>'
            || dtFechaTasa
            || '</td><td align=center>'
            || sbPorcentaje
            || '</td><td align=center>'
            || nuDiasVenc
            || '</td></tr>';
    END LOOP;

    CLOSE curTasas;

    IF sbTablaMail IS NOT NULL
    THEN
        sbMsg :=
               '<html><head><title>Tasas de Interes a Vencer</title><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head><body>Se notifica que proximamente se venceran las siguientes tasas de interes. Por favor gestionar la configuracion:<br><table border=1 width=100%><tr><td>TASA</td><td>FECHA FINAL</td><td>VALOR</td><td>DIAS A VENCER</td></tr>'
            || sbTablaMail
            || '</table></body></html>';

                           
        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbDestinatariosmail,
            isbAsunto           => 'Tasas de interes a vencer',
            isbMensaje          => sbMsg
        );
                           
    END IF;

    ldc_proactualizaestaprog (
        nutsess,
           'Solicitud Alerta Vencimiento Tasas de Interes - Se enviaron '
        || nuCont
        || ' correos electronicos',
        'PROCNOTIFTASAINTVENC',
        'Ok');
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        ldc_proactualizaestaprog (
            nutsess,
            'Solicitud Alerta Vencimiento Tasas de Interes',
            'PROCNOTIFTASAINTVENC',
            'Error en el Envio del Mail');
        RAISE;
    WHEN OTHERS
    THEN
        RAISE pkg_Error.CONTROLLED_ERROR;
END PROCNOTIFTASAINTVENC;
/