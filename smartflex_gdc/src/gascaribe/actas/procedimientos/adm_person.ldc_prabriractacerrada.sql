CREATE OR REPLACE PROCEDURE adm_person.ldc_prabriractacerrada( inuacta           IN     ge_acta.id_acta%TYPE,
                                                               isbcomment        IN     VARCHAR2,
                                                               onuerror          OUT    NUMBER,
                                                               osberror          OUT    VARCHAR2,
                                                               isbabrircontrato  IN VARCHAR2 DEFAULT 'N') 
IS
    /************************************************************************
    Metodo:       ldc_prAbrirActaCerrada
    Descripcion:  Procedimiento que realiza el cambio de estado de un acta 
                  de cerrado a abierta
    
    Autor:        dsaltarin
    Fecha:        25/07/2022
    Parametros:
    inuacta      : numero del acta a abrir
    isbComment   : comentario para el log 
    onuError     : codigo de error si no hay error devuelve 0
    osbError     : mensaje de error si no hay error devuelve vacio 
    isbAbrirContrato : S/N indica si se debe abrir el contrato, por default N
    
    Historia de Modificaciones  
    Fecha           Autor           Comentario
    ---------       ---------       --------------------------------------------       
    24/01/2024      DSALTARIN       OSF-2242: Se modifica paa que siempre actualice el valo del contrato y no haga commit
    15/04/2024      PACOSTA         OSF-2532: Se retita el llamado al esquema OPEN (open.)                                   
                                    Se crea el objeto en el esquema adm_person 
    *************************************************************************/
    nuactualizaestado       NUMBER := 0;
    nuactualizavalliq       NUMBER := 0;
    nuactualizaantamo       NUMBER := 0;
    nuactualizafongara      NUMBER := 0;
    valor_antipo_acta       NUMBER := 0;
    valor_fondo             NUMBER := 0;
    nuactaanticipo          NUMBER := 0;
    nuenviosap              NUMBER := 0;
    nunuevovalorliquidado   NUMBER;
    nunuevovaloramortizado  NUMBER;
    nunuevofondogaran       NUMBER;
    nunuevovalortotal       NUMBER;
    sblog                   VARCHAR2(2000);    

    nuitemdescfondogar      CONSTANT NUMBER:=102007;
    nuitemdescanticipo      CONSTANT NUMBER:=102006;
    nucodigoerror           CONSTANT NUMBER:=2701;

    CURSOR cuactas IS
    SELECT A.*
    FROM ge_acta A
    WHERE A.id_acta =inuacta
    AND A.id_tipo_acta IN (1,2);

    CURSOR cucontratos(nucontrato NUMBER) IS
    SELECT C.*
    FROM ge_contrato C
    WHERE C.id_contrato = nucontrato;
    
    CURSOR cuactaanticipo IS
    SELECT COUNT(1)
    FROM  ge_detalle_acta D
    WHERE D.id_acta=inuacta
      AND D.id_items = nuitemdescanticipo;

    CURSOR cuenviosap IS
    SELECT COUNT(1)
      FROM ldci_facteactasenv
     WHERE faceaeidacta = inuacta;

    rwcontrato                cucontratos%rowtype;
    rwacta                    cuactas%rowtype;  
BEGIN    
    onuerror:=0;
    osberror:=NULL;
    IF inuacta IS NULL THEN
        onuerror := -1;
        osberror := 'El acta no puede ser nula';
        RETURN;
    END IF;
    IF isbcomment IS NULL OR isbcomment='' THEN
        onuerror := -1;
        osberror := 'El Comentario no puede ser nulo';
        RETURN;
    END IF;
    IF cuactas%isopen THEN
        CLOSE cuactas;
    END IF;
    OPEN cuactas;
    FETCH cuactas INTO rwacta;
    IF cuactas%notfound THEN
        onuerror := -1;
        osberror := 'No se encontró el acta';
        RETURN;
    END IF;
    CLOSE cuactas;
    IF nvl(rwacta.estado,'A') != 'C' THEN
        onuerror := -1;
        osberror := 'El estado del acta no es cerrado';
        RETURN;
    END IF;
    ---SI SE REQUIERE ABRIR EL ACTA AUNQUE TENGA FACTURA,
    --CAMBIAR PRIMERO POR FUERA DEL SCRIPT EL CAMBIO DE LA FACTURA Y FECHA DE PAGO A NULL
    IF rwacta.extern_invoice_num IS NOT NULL OR rwacta.extern_pay_date IS NOT NULL THEN
        onuerror := -1;
        osberror := 'El acta tiene factura';
        RETURN;
    END IF;
    
    IF rwacta.id_tipo_acta = 2 THEN
        IF cuactaanticipo%isopen THEN
            CLOSE cuactaanticipo;
        END IF;
        --NUNCA SE DEBE PODER ABRIR UN ACTA DE COBRO DE ANTICIPO DEJADO DE FACTURAR
        OPEN cuactaanticipo;
        FETCH cuactaanticipo INTO nuactaanticipo;
        IF nuactaanticipo > 0 THEN
            onuerror := -1;
            osberror := 'El acta es un acta de anticipo no se puede abrir';
            RETURN;
        END IF;
        CLOSE cuactaanticipo;
        --SE DEBE VALIDAR C
        OPEN cuenviosap;
        FETCH cuenviosap INTO nuenviosap;
        CLOSE cuenviosap;
        --Si el acta ya fue enviada a sap 
        IF nuenviosap > 0 THEN
            onuerror := -1;
            osberror := 'El acta ya fue enviada a sap, validar con contabilidad si se puede abrir';
            RETURN;
        END IF;
    ELSIF rwacta.id_tipo_acta = 1 AND rwacta.nombre LIKE 'ENTREGA DE ANTICIPO%' THEN
        onuerror := -1;
        osberror := 'El acta es un acta de anticipo no se puede abrir';
        RETURN;
    END IF;
    
    OPEN    cucontratos(rwacta.id_contrato);
    FETCH   cucontratos INTO rwcontrato;
    CLOSE   cucontratos;
    IF rwcontrato.status = 'CE' AND isbabrircontrato = 'N' THEN
        onuerror := -1;
        osberror := 'El contrato se encuentra cerrado';
        RETURN;
    END IF;
    
    --Se actualiza el estado
    UPDATE ge_acta
        SET estado = 'A',
            fecha_cierre = NULL
        WHERE id_acta = rwacta.id_acta;

    --Se deja log con los datos del acta modificada
    sblog := 'SE MODIFICA EL ACTA ' || rwacta.id_acta || 
            ' SEGUN CASO' || isbcomment || ' PARA ABRIRLA.'||
            ' VALOR_TOTAL_ANT=' || rwacta.valor_total ||
            ' VALOR LIQUIDADO_ANT: ' || rwacta.valor_liquidado ||
            'FECHA CIERRE ANT: ' || rwacta.fecha_cierre;
    INSERT INTO ct_process_log
            (process_log_id,
            log_date,
            contract_id,
            period_id,
            break_date,
            error_code,
            error_message)

            VALUES
            (seq_ct_process_log_109639.NEXTVAL,
            sysdate,
            rwacta.id_contrato,
            NULL,
            NULL,
            nucodigoerror,
            sblog);
    --Se validan los datos a actualizar en el contrato
    IF rwcontrato.status = 'CE' THEN
        nuactualizaestado := 1;
    ELSE
        nuactualizaestado := 0;
    END IF;
    IF rwacta.id_tipo_acta = 1  THEN 

        --VALIDAR SI EL CONTRATO TIENE ANTICIPO
        IF rwcontrato.anticipo_amortizado IS NOT NULL THEN
            
            nuactualizaantamo := 1;
            
            BEGIN
                SELECT nvl(SUM(valor_total), 0)
                INTO valor_antipo_acta
                FROM ge_detalle_acta
                WHERE id_acta = rwacta.id_acta
                AND id_items = nuitemdescanticipo;
            
            EXCEPTION
                WHEN OTHERS THEN
                valor_antipo_acta := 0;
            END;
            
            nunuevovaloramortizado := rwcontrato.anticipo_amortizado + valor_antipo_acta;
            
        ELSE
            
            nuactualizaantamo := 0;
            nunuevovaloramortizado := NULL;
            
        END IF;  

        --VALIDAR SI TIENE FONDO DE GARANTIA
        IF rwcontrato.acumul_fondo_garant IS NOT NULL THEN

            nuactualizafongara := 1;

            BEGIN

                SELECT nvl(SUM(valor_total), 0)
                INTO valor_fondo
                FROM ge_detalle_acta
                WHERE id_acta = rwacta.id_acta
                AND id_items = nuitemdescfondogar;
            
            EXCEPTION
            WHEN OTHERS THEN
            valor_fondo := 0;
            END;

            nunuevofondogaran := rwcontrato.acumul_fondo_garant + valor_fondo;

        ELSE

            nuactualizafongara := 0;
            nunuevofondogaran := NULL;

        END IF; --FONDO

        nunuevovalortotal := rwcontrato.valor_total_pagado -
                            nvl(rwacta.valor_liquidado, rwacta.valor_total);

    END IF; --IF rwActa.id_tipo_acta = 1  then
    
    UPDATE ge_contrato
    SET  status 		= decode(nuactualizaestado, 1, 'AB', status),
        fecha_cierre = decode(nuactualizaestado, 1, NULL, fecha_cierre),
        anticipo_amortizado = decode(nuactualizaantamo, 1,nunuevovaloramortizado,anticipo_amortizado),
        acumul_fondo_garant = decode(nuactualizafongara,1,nunuevofondogaran,acumul_fondo_garant),
        valor_total_pagado = nunuevovalortotal
    WHERE id_contrato = rwacta.id_contrato;

    INSERT INTO ct_process_log
    (process_log_id,
    log_date,
    contract_id,
    period_id,
    break_date,
    error_code,
    error_message)

    VALUES
    (seq_ct_process_log_109639.NEXTVAL,
    sysdate,
    rwacta.id_contrato,
    NULL,
    NULL,
    nucodigoerror,
    'SE MODIFICA EL ACTA ' || rwacta.id_acta || ' SEGUN CASO ' || isbcomment ||
    ' PARA ABRIRLA. ESTADO_ANT_CONTRATO=' || rwcontrato.status ||
    ' FECHA_CIERRE_ANT: ' || rwcontrato.fecha_cierre ||
    ' VALOR_TOTAL_PAGADO ANT: ' || rwcontrato.valor_total_pagado ||
    ' VALOR_LIQUIDADO ANT: ' || rwcontrato.valor_liquidado ||
    ' ANTICIPO_AMORTIZADO ANT: ' || rwcontrato.anticipo_amortizado ||
    ' ACUMUL_FONDO_GARANT ANT: ' || rwcontrato.acumul_fondo_garant ||
    decode(nuactualizaestado, 1, ' ESTADO_NUE_CONTRATO= AB', '') ||
    decode(nuactualizaestado, 1, ' FECHA_CIERRE_NUE= NULL', '') ||
    ' VALOR_TOTAL_PAGADO NUE: ' || nunuevovalortotal ||
    decode(nuactualizaantamo,1,' ANTICIPO_AMORTIZADO NUE: ' || nunuevovaloramortizado,'') ||
    decode(nuactualizafongara,1,' ACUMUL_FONDO_GARANT NUE: ' || nunuevofondogaran)); 

EXCEPTION
    WHEN OTHERS THEN
    ERRORS.seterror();
    ERRORS.geterror(onuerror, osberror);
    ROLLBACK;  
END ldc_prabriractacerrada;
/
PROMPT Otorgando permisos de ejecucion a LDC_PCOMPRESSFILE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRABRIRACTACERRADA', 'ADM_PERSON');
END;
/