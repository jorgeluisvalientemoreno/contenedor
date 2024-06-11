CREATE OR REPLACE PROCEDURE ldc_prAbrirActaCerrada(nuacta    in     open.ge_acta.id_acta%type,
                                                   sbComment in     varchar2,
                                                   nuError   out    number,
                                                   sbError   out    varchar2,
                                                   sbAbrirContrato  in varchar2 default 'N') IS
/************************************************************************
Metodo:       ldc_prAbrirActaCerrada
   Descripcion:  Procedimiento que realiza el cambio de estado de un acta 
                 de cerrado a abierta

   Autor:        dsaltarin
   Fecha:        25/07/2022
   Parametros:
    nuacta      : numero del acta a abrir
    sbComment   : comentario para el log 
    nuError     : codigo de error si no hay error devuelve 0
    sbError     : mensaje de error si no hay error devuelve vacio 
    sbAbrirContrato : S/N indica si se debe abrir el contrato, por default N
   Historia de Modificaciones

*************************************************************************/
    
    nuActualizaEstado       NUMBER := 0;
    nuActualizaValLiq       NUMBER := 0;
    nuActualizaAntAmo       NUMBER := 0;
    nuActualizaFonGara      NUMBER := 0;
    VALOR_ANTIPO_ACTA       NUMBER := 0;
    VALOR_FONDO             NUMBER := 0;
    nuActaAnticipo          NUMBER := 0;
    nuEnvioSap              NUMBER := 0;
    nuNuevoValorliquidado   NUMBER;
    nuNuevoValorAmortizado  NUMBER;
    nuNuevoFondoGaran       NUMBER;
    nuNuevoVAlorTotal       NUMBER;
    sbLog                   VARCHAR2(2000);
    

    nuItemDescFondoGar      constant NUMBER:=102007;
    nuItemDescAnticipo      constant NUMBER:=102006;
    nuCodigoError           constant NUMBER:=2701;

    CURSOR cuActas is
    SELECT a.*
    FROM open.ge_acta a
    WHERE a.id_acta =nuacta
    AND a.id_tipo_acta in (1,2);

    CURSOR cuContratos(nuContrato NUMBER) is
    SELECT c.*
    FROM open.ge_contrato c
    WHERE c.id_contrato = nucontrato;
    
    CURSOR cuActaAnticipo is
    SELECT COUNT(1)
    FROM  OPEN.ge_detalle_acta d
    WHERE d.id_acta=nuacta
      and d.id_items = nuItemDescAnticipo;

    CURSOR cuEnvioSap is
    SELECT COUNT(1)
      FROM OPEN.LDCI_FACTEACTASENV
     WHERE FACEAEIDACTA = nuacta;

    rwContrato                cuContratos%rowtype;
    rwActa                    cuActas%rowtype;



  
BEGIN
    nuError:=0;
    sbError:=null;
    IF nuacta is null THEN
        nuError := -1;
        sbError := 'El acta no puede ser nula';
        return;
    END IF;
    IF sbComment is null or sbComment='' THEN
        nuError := -1;
        sbError := 'El Comentario no puede ser nulo';
        return;
    END IF;
    IF cuActas%ISOPEN THEN
        CLOSE cuActas;
    END IF;
    OPEN cuActas;
    FETCH cuActas INTO rwActa;
    IF cuActas%NOTFOUND THEN
        nuError := -1;
        sbError := 'No se encontró el acta';
        return;
    END IF;
    CLOSE cuActas;
    IF nvl(rwActa.estado,'A') != 'C' THEN
        nuError := -1;
        sbError := 'El estado del acta no es cerrado';
        return;
    END IF;
    ---SI SE REQUIERE ABRIR EL ACTA AUNQUE TENGA FACTURA,
    --CAMBIAR PRIMERO POR FUERA DEL SCRIPT EL CAMBIO DE LA FACTURA Y FECHA DE PAGO A NULL
    IF rwActa.extern_invoice_num is not null or rwActa.extern_pay_date is not null THEN
        nuError := -1;
        sbError := 'El acta tiene factura';
        return;
    END IF;
    
    IF rwActa.id_tipo_acta = 2 THEN
        IF cuActaAnticipo%ISOPEN THEN
            CLOSE cuActaAnticipo;
        END IF;
        --NUNCA SE DEBE PODER ABRIR UN ACTA DE COBRO DE ANTICIPO DEJADO DE FACTURAR
        OPEN cuActaAnticipo;
        FETCH cuActaAnticipo INTO nuActaAnticipo;
        IF nuActaAnticipo > 0 THEN
            nuError := -1;
            sbError := 'El acta es un acta de anticipo no se puede abrir';
            return;
        END IF;
        CLOSE cuActaAnticipo;
        --SE DEBE VALIDAR C
        OPEN cuEnvioSap;
        FETCH cuEnvioSap INTO nuEnvioSap;
        CLOSE cuEnvioSap;
        --Si el acta ya fue enviada a sap 
        IF nuEnvioSap > 0 THEN
            nuError := -1;
            sbError := 'El acta ya fue enviada a sap, validar con contabilidad si se puede abrir';
            return;
        END IF;
    ELSIF rwActa.id_tipo_acta = 1 AND rwActa.nombre like 'ENTREGA DE ANTICIPO%' THEN
        nuError := -1;
        sbError := 'El acta es un acta de anticipo no se puede abrir';
        return;
    END IF;
    
    OPEN    cuContratos(rwActa.id_contrato);
    FETCH   cuContratos INTO rwContrato;
    CLOSE   cuContratos;
    IF rwContrato.STATUS = 'CE' AND sbAbrirContrato = 'N' THEN
        nuError := -1;
        sbError := 'El contrato se encuentra cerrado';
        return;
    END IF;
    
    --Se actualiza el estado
    UPDATE open.ge_acta
        SET estado = 'A',
            fecha_cierre = null
        WHERE id_acta = rwActa.id_acta;

    --Se deja log con los datos del acta modificada
    sbLog := 'SE MODIFICA EL ACTA ' || rwActa.ID_ACTA || 
            ' SEGUN CON LA SIGTE OBSERVACION' || sbComment || ' PARA ABRIRLA.'||
            ' VALOR_TOTAL_ANT=' || rwActa.VALOR_TOTAL ||
            ' VALOR LIQUIDADO_ANT: ' || rwActa.VALOR_LIQUIDADO ||
            'FECHA CIERRE ANT: ' || rwActa.FECHA_CIERRE;
    INSERT INTO open.ct_process_log
            (process_log_id,
            log_date,
            contract_id,
            period_id,
            break_date,
            error_code,
            error_message)

            VALUES
            (seq_ct_process_log_109639.nextval,
            sysdate,
            rwActa.id_contrato,
            null,
            null,
            nuCodigoError,
            sbLog);
    --Se validan los datos a actualizar en el contrato
    IF rwContrato.STATUS = 'CE' then
        nuActualizaEstado := 1;
    ELSE
        nuActualizaEstado := 0;
    END IF;
    IF rwActa.id_tipo_acta = 1  THEN 

        --VALIDAR SI EL CONTRATO TIENE ANTICIPO
        IF rwContrato.anticipo_amortizado is not null then
            
            nuActualizaAntAmo := 1;
            
            BEGIN
                SELECT nvl(sum(valor_total), 0)
                INTO valor_antipo_acta
                FROM open.ge_detalle_acta
                WHERE id_acta = rwActa.id_acta
                AND id_items = nuItemDescAnticipo;
            
            EXCEPTION
                WHEN OTHERS THEN
                valor_antipo_acta := 0;
            END;
            
            nuNuevoValorAmortizado := rwContrato.anticipo_amortizado + valor_antipo_acta;
            
        ELSE
            
            nuActualizaAntAmo := 0;
            nuNuevoValorAmortizado := null;
            
        END IF;  

        --VALIDAR SI TIENE FONDO DE GARANTIA
        IF rwContrato.acumul_fondo_garant IS NOT NULL THEN

            nuActualizaFonGara := 1;

            BEGIN

                SELECT nvl(sum(valor_total), 0)
                INTO valor_fondo
                FROM open.ge_detalle_acta
                WHERE id_acta = rwActa.id_acta
                AND id_items = nuItemDescFondoGar;
            
            EXCEPTION
            WHEN OTHERS THEN
            VALOR_FONDO := 0;
            END;

            nuNuevoFondoGaran := rwContrato.ACUMUL_FONDO_GARANT + VALOR_FONDO;

        ELSE

            nuActualizaFonGara := 0;
            nuNuevoFondoGaran := null;

        END IF; --FONDO

        nuNuevoVAlorTotal := rwContrato.VALOR_TOTAL_PAGADO -
                            NVL(rwActa.VALOR_LIQUIDADO, rwActa.VALOR_TOTAL);

    END IF; --IF rwActa.id_tipo_acta = 1  then
    IF  nuActualizaestado = 1 OR  nuActualizaantamo =1 OR nuActualizaFonGara =1 THEN
        UPDATE open.ge_contrato
        SET  status 		= decode(nuActualizaestado, 1, 'AB', status),
            fecha_cierre = decode(nuActualizaestado, 1, null, fecha_cierre),
            anticipo_amortizado = decode(nuActualizaantamo, 1,nunuevovaloramortizado,anticipo_amortizado),
            acumul_fondo_garant = decode(nuActualizaFonGara,1,nunuevofondogaran,acumul_fondo_garant),
            valor_total_pagado = nunuevovalortotal
        WHERE id_contrato = rwActa.id_contrato;

        INSERT INTO OPEN.CT_PROCESS_LOG
        (PROCESS_LOG_ID,
        LOG_DATE,
        CONTRACT_ID,
        PERIOD_ID,
        BREAK_DATE,
        ERROR_CODE,
        ERROR_MESSAGE)

        VALUES
        (SEQ_CT_PROCESS_LOG_109639.NEXTVAL,
        SYSDATE,
        rwActa.ID_CONTRATO,
        NULL,
        NULL,
        nuCodigoError,
        'SE MODIFICA EL ACTA ' || rwActa.ID_ACTA || ' SEGUN CASO ' || sbComment ||
        ' PARA ABRIRLA. ESTADO_ANT_CONTRATO=' || rwContrato.status ||
        ' FECHA_CIERRE_ANT: ' || rwContrato.FECHA_CIERRE ||
        ' VALOR_TOTAL_PAGADO ANT: ' || rwContrato.VALOR_TOTAL_PAGADO ||
        ' VALOR_LIQUIDADO ANT: ' || rwContrato.VALOR_LIQUIDADO ||
        ' ANTICIPO_AMORTIZADO ANT: ' || rwContrato.ANTICIPO_AMORTIZADO ||
        ' ACUMUL_FONDO_GARANT ANT: ' || rwContrato.ACUMUL_FONDO_GARANT ||
        DECODE(nuActualizaEstado, 1, ' ESTADO_NUE_CONTRATO= AB', '') ||
        DECODE(nuActualizaEstado, 1, ' FECHA_CIERRE_NUE= NULL', '') ||
        ' VALOR_TOTAL_PAGADO NUE: ' || nuNuevoVAlorTotal ||
        DECODE(nuActualizaAntAmo,1,' ANTICIPO_AMORTIZADO NUE: ' || nuNuevoValorAmortizado,'') ||
        DECODE(nuActualizaFonGara,1,' ACUMUL_FONDO_GARANT NUE: ' || nuNuevoFondoGaran));

    END IF;--Actualizar contrato
    IF nuError = 0 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
    

EXCEPTION
  WHEN OTHERS THEN
    errors.setError();
    errors.getError(nuError, sbError);
    rollback;
END;
/
GRANT EXECUTE ON ldc_prAbrirActaCerrada TO SYSTEM_OBJ_PRIVS_ROLE;
/