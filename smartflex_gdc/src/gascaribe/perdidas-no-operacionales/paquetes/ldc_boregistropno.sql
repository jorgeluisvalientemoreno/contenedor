create or replace PACKAGE ldc_boRegistroPNO IS
/***************************************************************************
<Package Fuente="Propiedad Intelectual de Gases del Caribe">
<Unidad> ldc_boRegistroPNO </Unidad>
<Autor>  Lubin Pineda </Autor>
<Fecha> 23-11-2022 </Fecha>
<Descripcion>
    Paquete con los objetos del negocio para el registro de posibles
    perdidad no operacionales PNO
</Descripcion>
<Historial>
    <Modificacion Autor="maria-carval" Fecha="19-04-2023" Caso="OSF-950">
        Se corrige la consulta para obtener los valores del parámetro LDC_TITRADICOME, debido a que este puede recibir más de un valor.
    </Modificacion>
	<Modificacion Autor="jhinestroza" Fecha="03-04-2023" Caso="OSF-950">
        Se modifica pRegeneraOrden, se agrega la logica para registar comentario
        de legalizacion en la orden que se regenera.
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="04-01-2023" Caso="OSF-691">
        Se modifica pCreaRegistroPNO
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="03-01-2023" Caso="OSF-691">
        Se modifica pCreaRegistroPNO
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="23-12-2022" Caso="OSF-691">
        Se modifica pCreaRegistroPNO
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="23-11-2022" Caso="OSF-691">
        Creacion
    </Modificacion>
</Historial>
</Package>
***************************************************************************/

    -- Retona la ultima WO que hizo cambios en el paquete
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Registra variables y crea registro de PNO
    PROCEDURE pCreaRegistroPNO;

    -- Registra variables y crea registro de PNO
    PROCEDURE pRegeneraOrdenPNO;

END ldc_boRegistroPNO;
/
create or replace PACKAGE BODY ldc_boRegistroPNO IS

    -- Identificador de la ultima WO que hizo cambios en el paquete
    csbVersion                 VARCHAR2(15) := 'OSF-691';

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(100)         := 'ldc_boRegistroPNO.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;

    -- Clase de causal de exito
    cnuCAUSAL_EXITO             ge_causal.class_causal_id%TYPE:= 1;

    csbLDC_CONF_REGE_ACTI_PNO   CONSTANT ld_parameter.value_chain%TYPE := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CONF_REGE_ACTI_PNO',
                                                                                         null);


    TYPE tytbConfRegenera IS TABLE OF OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE INDEX BY VARCHAR2(100);

    gtbConfRegenera     tytbConfRegenera;

    /***************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe">
    <Unidad> pCreaRegistroPNO </Unidad>
    <Descripcion>
        Crea un registro de PNO en FM_POSSIBLE_NTL
    </Descripcion>
    <Autor> Lubin Pineda - MVM </Autor>
    <Fecha> 23-11-2022 </Fecha>
    <Historial>
	<Modificacion Autor="jhinestroza" Fecha="03-04-2023" Caso="OSF-950">
        Se modifica pRegeneraOrden, se agrega la logica para registar comentario
        de legalizacion en la orden que se regenera.
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="04-01-2023" Caso="OSF-691">
        Se quita la condicion de los estados en cuPNO_Activo
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="03-01-2023" Caso="OSF-691">
        Se quita la condicion de causal de exito
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="23-12-2022" Caso="OSF-691">
        Se modifica para realizar el registro de PNO con la primera orden
        relacionada con la actual
    </Modificacion>
    <Modificacion Autor="jpinedc" Fecha="23-11-2022" Caso="OSF-691">
        Creacion.
    </Modificacion>
    </Historial>
    </Procedure>
    ***************************************************************************/
    PROCEDURE pCreaRegistroPNO
    IS
        -- Nombre de este metodo
        csbMT_NAME  VARCHAR2(30) := 'pCreaRegistroPNO';

        nuOrden     or_order.order_id%TYPE;

        nuCausal    or_order.causal_id%TYPE;

        nuOrdenPNO  or_order.order_id%TYPE;

        rcFM_Possible_NTL    DAFM_Possible_NTL.styFM_Possible_NTL;

        CURSOR cuDatosProducto( inuOrden     or_order_activity.order_id%TYPE)
        IS
        SELECT
            oa.product_id,
            pr.product_Type_Id,
            ad.Geograp_Location_id,
            ad.Address_Id
        FROM    or_order_activity   oa,
                pr_product          pr,
                ab_address          ad
        WHERE
                oa.order_id = inuOrden
        AND pr.product_id   = oa.product_id
        AND ad.address_id   = oa.address_id;

        rcDatosProducto cuDatosProducto%ROWTYPE;

        CURSOR cuPNO_Activo
        (
            inuProducto     or_order_activity.product_id%TYPE,
            inuOrden        or_order_activity.order_id%TYPE
        )
        IS
        SELECT *
        FROM fm_possible_ntl
        WHERE
            product_id = inuProducto
        AND order_id = inuOrden;

        rcPNO_Activo cuPNO_Activo%ROWTYPE;

    BEGIN

        ut_trace.trace('Inicia ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

        -- Obtiene la orden que se esta procesando
        nuOrden := or_bolegalizeorder.fnuGetCurrentOrder();

        ut_trace.trace('nuOrden|' || nuOrden, cnuNVLTRC);

        nuCausal := daor_order.fnuGetCausal_Id( nuOrden );

        ut_trace.trace('nuCausal|' || nuCausal, cnuNVLTRC);

        -- Busca en las ordenes de PNO relacionadas con la actual
		nuOrdenPNO := OR_BORelatedOrder.fnuGetPathErOrderId(nuOrden);

        ut_trace.trace('nuOrdenPNO|' || nuOrdenPNO, cnuNVLTRC);

        OPEN cuDatosProducto( nuOrden );
        FETCH cuDatosProducto INTO rcDatosProducto;
        CLOSE cuDatosProducto;

        OPEN cuPNO_Activo ( rcDatosProducto.product_id, nuOrdenPNO );
        FETCH cuPNO_Activo INTO rcPNO_Activo;
        CLOSE cuPNO_Activo;

		-- Si no hay ordenes relacionadas con registro en PNO se crea registro
        IF rcPNO_Activo.Possible_NTL_Id IS NULL THEN

			rcFM_Possible_NTL.Possible_NTL_Id    := SEQ_FM_POSSIBLE_NTL_123873.NextVal;
			rcFM_Possible_NTL.Status             := 'R';
			rcFM_Possible_NTL.Product_Id         := rcDatosProducto.Product_Id;
			rcFM_Possible_NTL.Product_Type_Id    := rcDatosProducto.Product_Type_Id;
			rcFM_Possible_NTL.Geograp_Location_Id:= rcDatosProducto.Geograp_Location_Id;
			rcFM_Possible_NTL.Address_Id         := rcDatosProducto.Address_Id;
			rcFM_Possible_NTL.Register_Date      := SYSDATE;
			rcFM_Possible_NTL.Discovery_Type_Id  := 4;
			rcFM_Possible_NTL.Order_id           := nuOrdenPNO;
			rcFM_Possible_NTL.Comment_           := 'GENERADO POR ACTIVDAD DE PNO';
			rcFM_Possible_NTL.Value_             := 0;

			DAFM_Possible_NTL.InsRecord( rcFM_Possible_NTL );

		END IF;

        ut_trace.trace('Termina ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

    EXCEPTION
        WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR OR pkConstante.exERROR_LEVEL2 THEN
            ut_trace.trace('Error Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            RAISE;
        WHEN OTHERS THEN
            ut_trace.trace('Error No Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END pCreaRegistroPNO;

    PROCEDURE pCargaConfRegeneracion
    IS
        -- Nombre de este metodo
        csbMT_NAME  VARCHAR2(30) := 'pCargaConfRegeneracion';

        tbConfRegenera      LDC_PKBOCargaPeriodos.tyTabla;

        tbRegConfRegenera   LDC_PKBOCargaPeriodos.tyTabla;

        sbIndice            VARCHAR2(100);

    BEGIN

        ut_trace.trace('Inicia ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

        LDC_PKBOCargaPeriodos.ParseString( csbLDC_CONF_REGE_ACTI_PNO , ';', tbConfRegenera );

        ut_trace.trace('tbConfRegenera.Count|' || tbConfRegenera.Count, cnuNVLTRC);

        IF tbConfRegenera.Count > 0 THEN

            FOR indTb IN 1..tbConfRegenera.Count LOOP

                tbRegConfRegenera.Delete;

                LDC_PKBOCargaPeriodos.ParseString( tbConfRegenera(indTb) , '|', tbRegConfRegenera );

                sbIndice := tbRegConfRegenera(1) || '|' || tbRegConfRegenera(2);

                gtbConfRegenera( sbIndice ) := tbRegConfRegenera(3);

            END LOOP;

        END IF;

        ut_trace.trace('Termina ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

    EXCEPTION
        WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR OR pkConstante.exERROR_LEVEL2 THEN
            ut_trace.trace('Error Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            RAISE;
        WHEN OTHERS THEN
            ut_trace.trace('Error No Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END pCargaConfRegeneracion;

    PROCEDURE pRegeneraOrden
    IS

        -- Nombre de este metodo
        csbMT_NAME  VARCHAR2(30) := 'pRegeneraOrden';

        nuOrden     or_order.order_id%TYPE;

        CURSOR cuDatosOrden
        IS
        SELECT
        od.causal_id,
        oa.activity_id,
        oa.product_id
        from or_order_activity oa,
        or_order od
        where od.order_id = nuOrden
        AND od.order_id = oa.order_id;

        rcDatosOrden cuDatosOrden%ROWTYPE;

        sbIndice       VARCHAR2(100);

        nuActividadRegenerar        or_order_activity.activity_id%type;
        nuAddress_id                fm_possible_ntl.address_id%type;
        nuInformer_id               fm_possible_ntl.informer_subs_id%type;
        nuProduct_id                fm_possible_ntl.product_id%type;
        sbComment                   fm_possible_ntl.comment_%type;
        pnoOperating_unit_id        OR_operating_unit.operating_unit_id%type;
        
        --<< OSF-950
        sbTitrHijo      VARCHAR2(4000) := OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRADICOME', NULL);
        nuTipoTrabajo   open.or_order.task_type_id%type;
        nuerrorcode     NUMBER;
        sberrormessage  VARCHAR2(4000);
        nuOrdernFMCAP   open.or_order.order_id%type;        
        nuExiste        NUMBER;

                
        CURSOR curGetTaskType(nuOrder open.or_order.task_type_id%type)
        IS
            SELECT  OO.TASK_TYPE_ID
            FROM    OPEN.OR_ORDER OO
            WHERE   OO.ORDER_ID = nuOrder;

        CURSOR cuGetComments(nuOrder open.or_order.task_type_id%type)
        IS
            SELECT  ORDER_COMMENT comentarioot,
                    COMMENT_TYPE_ID TIPO
            FROM    open.or_order_comment
            WHERE   order_id = nuOrder
            and     legalize_comment='Y';
        -->>

    BEGIN

        ut_trace.trace('Inicia ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

        nuOrden := or_bolegalizeorder.fnugetcurrentorder;

        OPEN cuDatosOrden;
        FETCH cuDatosOrden INTO rcDatosOrden;
        CLOSE cuDatosOrden;

        ut_trace.trace('Orden en legalizacion|' || nuOrden || 'Producto|' || rcDatosOrden.product_Id || '|Actividad|' || rcDatosOrden.Activity_Id || '|Causal|' || rcDatosOrden.Causal_Id, cnuNVLTRC);

        sbIndice    := rcDatosOrden.Activity_Id || '|' || rcDatosOrden.Causal_Id;

        ut_trace.trace('sbIndice|' || sbIndice , cnuNVLTRC);

        IF gtbConfRegenera.Exists( sbIndice ) THEN


            nuActividadRegenerar    := gtbConfRegenera( sbIndice );
            nuProduct_id            := rcDatosOrden.product_Id;

            ut_trace.trace('nuActividadRegenerar|' || nuActividadRegenerar , cnuNVLTRC);

            sbComment := 'Regenerada por legalizacion orden '|| nuOrden;

            LDC_REGISTERNTL.PBREGISTER_NTL
            (
                nuActivity_id        => nuActividadRegenerar,
                nuAddress_id         => nuAddress_id,
                nuInformer_id        => nuInformer_id,
                nuProduct2_id        => nuProduct_id,
                sbComment            => sbComment,
                pnoOperating_unit_id => pnoOperating_unit_id,
                nuoIdOrderFmcap      => nuOrdernFMCAP
            );
            
            IF (nuOrdernFMCAP IS NOT NULL) THEN
            
                OPEN curGetTaskType(nuOrdernFMCAP);
                FETCH curGetTaskType INTO nuTipoTrabajo;
                CLOSE curGetTaskType;

                SELECT COUNT(1)
                INTO nuExiste
                FROM (SELECT TO_NUMBER(regexp_substr(sbTitrHijo,'[^,]+',1,level)) AS TipoTrabajo
                                       from dual
                                       connect by regexp_substr(sbTitrHijo, '[^,]+', 1,level) is not null)
                WHERE nuTipoTrabajo = TipoTrabajo;
                                
                IF nuExiste != 0 THEN
                    FOR rfcucomentarios IN cuGetComments(nuOrden) LOOP
                      os_addordercomment( nuOrdernFMCAP,
                                          rfcucomentarios.TIPO,
                                          rfcucomentarios.comentarioot,
                                          nuerrorcode,
                                          sberrormessage);
                      IF nuerrorcode <> 0 THEN
                         ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'os_addordercomment: Error asignando comentarios a la orden ['||nuOrdernFMCAP||'], error '||nuerrorcode||'-'||sberrormessage);
                      END IF;
                    END LOOP;
                END IF;
            END IF;

        END IF;

        ut_trace.trace('Termina ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

    EXCEPTION
        WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR OR pkConstante.exERROR_LEVEL2 THEN
            ut_trace.trace('Error Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            RAISE;
        WHEN OTHERS THEN
            ut_trace.trace('Error No Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END pRegeneraOrden;

    /***************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe">
    <Unidad> pRegeneraOrdenPNO </Unidad>
    <Descripcion>
        Regenera ordenes de PNO
    </Descripcion>
    <Autor> Lubin Pineda - MVM </Autor>
    <Fecha> 19-01-2023 </Fecha>
    <Historial>
    <Modificacion Autor="jpinedc" Fecha="19-01-2023" Caso="OSF-691">
        Creacion.
    </Modificacion>
    </Historial>
    </Procedure>
    ***************************************************************************/
    PROCEDURE pRegeneraOrdenPNO
    IS
        -- Nombre de este metodo
        csbMT_NAME  VARCHAR2(30) := 'pRegeneraOrdenPNO';

    BEGIN

        ut_trace.trace('Inicia ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

        pCargaConfRegeneracion;

        pRegeneraOrden;

        ut_trace.trace('Termina ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

    EXCEPTION
        WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR OR pkConstante.exERROR_LEVEL2 THEN
            ut_trace.trace('Error Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            RAISE;
        WHEN OTHERS THEN
            ut_trace.trace('Error No Controlado|' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
            Errors.SetError;
            RAISE ex.CONTROLLED_ERROR;
    END pRegeneraOrdenPNO;

    /***************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe">
    <Unidad> fsbVersion </Unidad>
    <Descripcion>
        Retona la ultima WO que hizo cambios en el paquete
    </Descripcion>
    <Autor> Lubin Pineda - MVM </Autor>
    <Fecha> 23-11-2022 </Fecha>
    <Historial>
    <Modificacion Autor="jpinedc" Fecha="23-11-2022" Caso="OSF-691">
        Creacion
    </Modificacion>
    </Historial>
    </Procedure>
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

END ldc_boRegistroPNO;
/