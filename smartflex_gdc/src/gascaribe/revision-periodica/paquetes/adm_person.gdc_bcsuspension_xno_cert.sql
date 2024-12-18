CREATE OR REPLACE PACKAGE adm_person.gdc_bcsuspension_xno_cert AS
--{
    /***********************************************************
        Propiedad intelectual de GDC.

        Descripcion     :   Business Object - SUSPENSION XNO CERT
        Autor           :   GDC
        Fecha           :   Viernes, Ago. 02, 2019 a las 08:56:42 AM GMT-05:00

        Metodos
        Nombre :
        Parametros      Descripcion
        ============    ===================

        Historia de Modificaciones
        Fecha       Autor       Modificacion
        =========   ========    ====================
        02-Ago-2019 GDC         Created
		12/08/2021  HORBATH     CA 767 se modifica la consulta del cursor CUNOTIFICA omitiendo las consultas que quitaban los productos con alguna suspension por RP
        18/06/2024  Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
    ************************************************************/
    -- Types
    TYPE styServsusc IS RECORD(
        sesunuse             servsusc.sesunuse%TYPE
    );
    TYPE tbtyServsuscTable IS TABLE OF styServsusc INDEX BY BINARY_INTEGER;
    tbServsusc tbtyServsuscTable;

    FUNCTION fsbVersion  RETURN VARCHAR2;

    PROCEDURE GetProductsToSuspend (
        inuThreadNumber                 in  number, -- Thread number
        inuThreadsQuantity              in  number, -- Threads Quantity
        inuDias_Anti_Notf               in  number,
        inuDias_repa_OIA                in  number,
        inuDias                         in  number,
        inuDias_dif_repa                in  number,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type,
        otbServsusc                     out nocopy GDC_BCSuspension_XNO_Cert.tbtyServsuscTable
    );

    PROCEDURE GetDataGeographic (
        inuAddress_id           in  ab_address.address_id%type,
        onuOperating_sector_id  out ab_segments.operating_sector_id%type,
        onuGeograp_location_id  out ab_address.geograp_location_id%type,
        onuGeo_loca_father_id   out ge_geogra_location.geo_loca_father_id%type,
        osbAddress_parsed       out ab_address.address_parsed%type
    );

    FUNCTION fnuInge (
        inuProduct_id           in  pr_product.product_id%type
    )
    return number;

    FUNCTION fnuExistRequest (
        inuProduct_id                   in  pr_product.product_id%type,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type
    )
    return number;

    FUNCTIOn fblProdHasPackActives(
        inuProduct  in  pr_product.product_id%type,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type
    ) return boolean;

    FUNCTION fnuAcometidFall (
        inuProduct_id   in  pr_product.product_id%type,
        isbCausal       in  ld_parameter.value_chain%type
    )
    return number;

    PROCEDURE GetProductsToNotifica (
        inuThreadNumber                 in  number, -- Thread number
        inuThreadsQuantity              in  number, -- Threads Quantity
        inuDias_Anti_Notf               in  number,
        inuDias_repa_OIA                in  number,
        inuDias                         in  number,
        inuDias_dif_repa                in  number,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type,
        otbServsusc                     out nocopy GDC_BCSuspension_XNO_Cert.tbtyServsuscTable
    );

    FUNCTION fsbMeasurementCode (
        inuProduct_id   in  pr_product.product_id%type
    )
    return varchar2;

--}
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.GDC_BCSuspension_XNO_Cert AS
--{
    /***********************************************************
        Propiedad intelectual de GDC.

        Descripcion     :   Business Object - SUSPENSION XNO CERT
        Autor           :   GDC
        Fecha           :   Viernes, Ago. 02, 2019 a las 08:56:42 AM GMT-05:00

        Metodos
        Nombre :
        Parametros      Descripcion
        ============    ===================

        Historia de Modificaciones
        Fecha       Autor          Modificacion
        =========   ========    ====================
        02-Ago-2019 GDC         Created
        14/05/2020  HORBATH     CASO 383: Agregar comando MINUS al cursor cuSuspend y cuNotifica
		09/12/2020   ljlb       CA 337 se coloca validacion de producto excluido
		12/08/2021  HORBATH     CA 767 se modifica la consulta del cursor CUNOTIFICA omitiendo las consultas que quitaban los productos con alguna suspension por RP
        18/10/2022  Jorge Val   OSF-582: modificar los cursores cuNotifica y cuSuspend del paquete GDC_BCSuspension_XNO_Cert para que no tengan en cuenta los productos en estado de producto 3-Retirado y 16-Retirado sin instalacion.
    ************************************************************/
    -- Variables
    csbVersion              constant varchar2(250) := '20190802v1.0';
    sbErrMsg                ge_error_log.description%type;
    nuCodError              ge_error_log.error_log_id%type;
    gsbProgram              estaprog.esprprog%type := 'XNO_CERT';
    gnuDias                 NUMBER;
    gnuDias_dif             NUMBER;
    gnuDias_dif_repa        NUMBER;
    gnuDias_Anti_Notf       NUMBER := nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0);
    gnuDias_repa_OIA        NUMBER;

    -- Constantes
    CSBDIVISION             CONSTANT VARCHAR2(20) := PKCONSTANTE.CSBDIVISION;
    CSBMODULE               CONSTANT VARCHAR2(20) := PKCONSTANTE.CSBMOD_BIL;

    -- Cursor
    CURSOR cuSuspend (
        inuThreadNumber                 in  number, -- Thread number
        inuThreadsQuantity              in  number, -- Threads Quantity
        inuDias_Anti_Notf               in  number,
        inuDias_repa_OIA                in  number,
        inuDias                         in  number,
        inuDias_dif_repa                in  number,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type
    ) IS
    SELECT id_producto
    FROM
        (
            (
                (
                    (
                        SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                                a.ID_PRODUCTO
                        FROM   ldc_plazos_cert a
                        WHERE  plazo_min_suspension <= SYSDATE + inuDias_Anti_Notf --nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                        AND    is_notif IN ('YV', 'YR')
                        UNION
                        SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */ a.id_producto
                        FROM   ldc_marca_producto a, ldc_plazos_cert    B
                        WHERE  fecha_ultima_actu <= (CASE WHEN a.medio_recepcion = 'E' THEN
                                                        SYSDATE - (inuDias_repa_OIA)  --open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL)
                                                     ELSE
                                                        SYSDATE - (inuDias +         -- open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                                                                   inuDias_dif_repa  -- open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL)
                                                                   )
    							                     END)
                        AND    register_por_defecto = 'Y'
                        AND    is_notif IN ('YV', 'YR')
                        AND    a.id_producto = b.id_producto
                    )
                    INTERSECT
                        SELECT mo.PRODUCT_ID
                        FROM   mo_packages m, mo_motive mo, or_order_activity oa, or_order o
                        WHERE  m.package_id = oa.package_id
                        AND    m.PACKAGE_ID = mo.package_id
                        AND    oa.order_id = o.order_id
                        AND    m.PACKAGE_TYPE_ID = 100246   -- Notificacion Suspension x Ausencia de Certificado
                        AND    o.task_type_id = 10450       -- Suspension desde cm revisiones periodicas
                        AND    o.order_status_id = 20       -- Planeada
                )
                UNION
                (
                    (
                        SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                                a.id_producto
                        FROM   ldc_plazos_cert a
                        WHERE  plazo_min_suspension <= SYSDATE + inuDias_Anti_Notf       -- nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                        AND    is_notif IN ('YV', 'YR')
                        UNION
                        SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */
                                a.id_producto
                        FROM   ldc_marca_producto a, ldc_plazos_cert    B
                        WHERE  fecha_ultima_actu <= (CASE WHEN a.medio_recepcion = 'E' THEN
                                                            SYSDATE - (inuDias_repa_OIA) -- Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL)
                                                        ELSE
                                                            SYSDATE - (inuDias           -- Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                                                                            +
                                                                       inuDias_dif_repa) -- Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL)
                                                     END)
                        AND    REGISTER_POR_DEFECTO = 'Y'
                        AND    is_notif IN ('YV', 'YR')
                        AND    a.id_producto = b.id_producto
    				)
    				MINUS
                        SELECT PRODUCT_ID
                        FROM   mo_packages m, ps_motive_status c, mo_motive x
                        WHERE  InStr(isbCOD_PKG_TYPE_ID_FILTRO_SUSP, ','||m.package_type_id||',') > 0   -- 265,266,100270,100156,100246,100153,100014,100237,100013,100294,100295,100321,100293
                        AND    c.MOTIVE_STATUS_ID = m.MOTIVE_STATUS_ID
                        AND    c.MOTI_STATUS_TYPE_ID = 2                -- Estado paquete
                        AND    c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)   -- 14-Atendido 32-Anulado 51-Cancelada
                        AND    x.PACKAGE_ID = m.PACKAGE_ID
    			)
                UNION
                (
                    SELECT /*+ index (a IDX_LDC_PLAZOS_CERT01) */
                           a.ID_PRODUCTO
                    FROM   ldc_plazos_cert a
                    WHERE  plazo_min_suspension <= sysdate + inuDias_Anti_Notf -- nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                    AND    is_notif in ('YV', 'YR')
                    INTERSECT
                    SELECT product_id
                    FROM  or_order_activity oa, or_order o
                    WHERE oa.order_id = o.order_id
                    AND   o.task_type_id = 10445    -- Visita validacion de trabajos reparacion
                    AND   o.order_status_id = 11    -- Bloqueada
                )
            )
            MINUS
                (
                    SELECT PRODUCT_ID
                    FROM   pr_prod_suspension
                    WHERE  suspension_type_id IN (101, 102, 103, 104)
                    AND   active = 'Y'
                )
            --Inicio CASO 383
            MINUS
                (
                    SELECT ID_PRODUCTO
                    FROM PLAZOS_CERT_PREV_COVID19
                    WHERE trunc(sysdate) < trunc(FECHA_EXCLUSI)
                )
            --Fin CASO 383
            --Inicio  OSF-582
            MINUS(
                    SELECT ab.PRODUCT_ID
                    FROM pr_product ab
                    WHERE ab.PRODUCT_STATUS_ID in (3,16)
                 )
            --Fin OSF-582
        )
    WHERE mod (id_producto, inuThreadsQuantity) + 1 = inuThreadNumber
	    --inicio ca 337
		and LDC_PKGESTPREXCLURP.FUNVALEXCLURP(id_producto) = 0;
		--fin ca 337



    CURSOR cuNotifica (
        inuThreadNumber                 in  number, -- Thread number
        inuThreadsQuantity              in  number, -- Threads Quantity
        inuDias_Anti_Notf               in  number,
        inuDias_repa_OIA                in  number,
        inuDias                         in  number,
        inuDias_dif_repa                in  number,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type
    ) IS
    SELECT id_producto
    FROM  (
            (
                (
                    SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                            a.ID_PRODUCTO
                    FROM   ldc_plazos_cert a
                    WHERE  plazo_min_suspension <= SYSDATE + inuDias_Anti_Notf --nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                    AND    (is_notif NOT IN ('YV', 'YR') OR is_notif IS NULL)
                    UNION
                    SELECT /*+ index (a IDX_LDC_MARCA_PRODUCTO02) */
                            a.ID_PRODUCTO
                    FROM   ldc_marca_producto a, ldc_plazos_cert    B
                    WHERE  fecha_ultima_actu <= SYSDATE - inuDias        -- Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL)
                    AND    REGISTER_POR_DEFECTO = 'Y'
                    AND    (is_notif NOT IN ('YV', 'YR') OR is_notif IS NULL)
                    AND    a.id_producto = b.id_producto
                )
                MINUS
                (
                    /* caso: 767
					SELECT PRODUCT_ID
                    FROM   pr_prod_suspension
                    WHERE  suspension_type_id IN (101, 102, 103, 104)
                    AND    active = 'Y'
                    UNION*/
                    SELECT PRODUCT_ID
                    FROM   mo_packages m, ps_motive_status c, mo_motive x
                    WHERE  InStr(isbCOD_PKG_TYPE_ID_FILTRO_SUSP, ','||m.package_type_id||',') > 0   -- 265,266,100270,100156,100246,100153,100014,100237,100013,100294,100295,100321,100293
                    AND    c.MOTIVE_STATUS_ID = m.MOTIVE_STATUS_ID
                    AND    c.MOTI_STATUS_TYPE_ID = 2
                    AND    c.MOTIVE_STATUS_ID NOT IN (14, 32, 51)
                    AND    x.PACKAGE_ID = m.PACKAGE_ID
                )
            )
            UNION
            (
                (
                    SELECT /*+ index (a IDX_LDC_PLAZOS_CERT03) */
                            a.ID_PRODUCTO
                    FROM   ldc_plazos_cert a
                    WHERE  plazo_min_suspension <= sysdate + inuDias_Anti_Notf --nvl(Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0)
                    AND    is_notif in ('YV', 'YR')
                    INTERSECT
                    SELECT PRODUCT_ID
                       FROM or_order_activity oa, or_order o
                      WHERE oa.order_id = o.order_id
                        AND o.task_type_id = 10445
                        AND o.order_status_id = 11
                )
                /* caso: 767
				MINUS
                    SELECT PRODUCT_ID
                    FROM  pr_prod_suspension
                    WHERE suspension_type_id in (101, 102, 103, 104)
                    AND   active = 'Y'*/
            )
        --Inicio CASO 383
        --Inicio ca 472 se quita tabla PLAZOS_CERT_PREV_COVID19
        /*MINUS
            (
                SELECT ID_PRODUCTO
                FROM PLAZOS_CERT_PREV_COVID19
                WHERE trunc(sysdate) < trunc(FECHA_EXCLUSI)
            )*/
        --Inicio CASO 383
        --Inicio  OSF-582
        MINUS(
                SELECT ab.PRODUCT_ID
                FROM pr_product ab
                WHERE ab.PRODUCT_STATUS_ID in (3,16)
             )
        --Fin OSF-582
        )
        where mod (id_producto, inuThreadsQuantity) + 1 = inuThreadNumber;

    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN ( CSBVERSION );
    END;

    /*
        Metodo      :   GetProductsToSuspend
        Descripcion :   Get Products To Suspend

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */


    PROCEDURE GetProductsToSuspend (
        inuThreadNumber                 in  number, -- Thread number
        inuThreadsQuantity              in  number, -- Threads Quantity
        inuDias_Anti_Notf               in  number,
        inuDias_repa_OIA                in  number,
        inuDias                         in  number,
        inuDias_dif_repa                in  number,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type,
        otbServsusc                     out nocopy GDC_BCSuspension_XNO_Cert.tbtyServsuscTable
    )
    IS
        -- Variables
    BEGIN
    --{
        -- Open cursor
        open  cuSuspend(inuThreadNumber,
                        inuThreadsQuantity,
                        inuDias_Anti_Notf,
                        inuDias_repa_OIA,
                        inuDias,
                        inuDias_dif_repa,
                        isbCOD_PKG_TYPE_ID_FILTRO_SUSP);

        -- Get data
        fetch cuSuspend BULK COLLECT INTO otbServsusc;

        -- Close cursor
        close cuSuspend;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;

    /*
        Metodo      :   GetDataGeographic
        Descripcion :   Get Data Geographic

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    PROCEDURE GetDataGeographic (
        inuAddress_id           in  ab_address.address_id%type,
        onuOperating_sector_id  out ab_segments.operating_sector_id%type,
        onuGeograp_location_id  out ab_address.geograp_location_id%type,
        onuGeo_loca_father_id   out ge_geogra_location.geo_loca_father_id%type,
        osbAddress_parsed       out ab_address.address_parsed%type
    )
    IS
        -- CURSOR
        CURSOR cuData IS
        SELECT seg.operating_sector_id,dir.geograp_location_id,loc.geo_loca_father_id,dir.address_parsed
        FROM   ab_address dir, ab_segments seg, ge_geogra_location loc --or_operating_sector so
        WHERE  dir.address_id = inuAddress_id
        AND    dir.segment_id = seg.segments_id
        AND    dir.geograp_location_id = loc.geograp_location_id;
    BEGIN
    --{
        -- Open cursor
        open  cuData;

        -- Get data
        fetch cuData INTO onuOperating_sector_id,
                          onuGeograp_location_id,
                          onuGeo_loca_father_id,
                          osbAddress_parsed;

        -- Close cursor
        close cuData;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;

    /*
        Metodo      :   fnuInge
        Descripcion :   Inge

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    FUNCTION fnuInge (
        inuProduct_id           in  pr_product.product_id%type
    )
    return number
    IS
        -- CURSOR
        CURSOR cuData IS
        SELECT /*+ ORDERED use_nl(or_order_activity, or_order) */
                COUNT(1)
        FROM   or_order_activity, or_order
        WHERE  or_order_activity.product_id = inuProduct_id
        AND    or_order_activity.order_id = or_order.order_id
        AND    or_order.order_status_id IN (0, 5, 7)    -- 0-Registrada 5-Asignada 7-Ejecutada
        AND    exists (SELECT 'x' FROM ldc_trab_cert WHERE id_trabcert = or_order.task_type_id);

        -- Variables
        nuCount     number:=0;
    BEGIN
    --{
        -- Open cursor
        open  cuData;

        -- Get data
        fetch cuData INTO nuCount;

        -- Close cursor
        close cuData;

        return nvl(nuCount,0);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;

    /*
        Metodo      :   fnuExistRequest
        Descripcion :   Exist Request

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    FUNCTION fnuExistRequest (
        inuProduct_id                   in  pr_product.product_id%type,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type
    )
    return number
    IS
        -- CURSOR
        CURSOR cuData IS
        SELECT count(1)
        FROM   mo_motive x, mo_packages m, ps_motive_status c
        WHERE  x.product_id = inuProduct_id
        AND    InStr(isbCOD_PKG_TYPE_ID_FILTRO_SUSP, ','||m.package_type_id||',') > 0
        AND    c.motive_status_id = m.motive_status_id
        AND    c.moti_status_type_id = 2
        AND    c.motive_status_id not in (14,32,51)
        AND    x.package_id = m.package_id;

        -- Variables
        nuCount     number:=0;
    BEGIN
    --{
        -- Open cursor
        open  cuData;

        -- Get data
        fetch cuData INTO nuCount;

        -- Close cursor
        close cuData;

        return nvl(nuCount,0);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;

    FUNCTION fblProdHasPackActives(
        inuProduct  in  pr_product.product_id%type,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type
    ) return boolean
    IS
        -- Variables
        sbTag_Name  ps_package_type.tag_name%type;

        -- Cursor
        CURSOR cuPackType is
        SELECT t.package_type_id, t.tag_name
        FROM   ps_package_type t
        WHERE  InStr(isbCOD_PKG_TYPE_ID_FILTRO_SUSP, ','||t.package_type_id||',') > 0;

        CURSOR cuData is
        SELECT /*+ index(a pk_mo_packages) */
                a.*, a.ROWID
        FROM   mo_packages a
        WHERE  EXISTS ( SELECT/*+ index(b ix_mo_motive01) */ 'x'
                        FROM  mo_motive b
                        WHERE b.product_id = inuProduct
                        AND   b.package_id = a.package_id )
        AND    a.tag_name = sbTag_Name
        AND    exists (SELECT 'x'
                       FROM   ps_motive_status ps
                       WHERE  ps.moti_status_type_id = 2
                       AND    ps.is_final_status = 'N'
                       AND    ps.motive_status_id = a.motive_status_id)
        AND   rownum = 1;

        -- Variables
        blExiste boolean:= false;
    BEGIN
    --{
        for rc in cuPackType loop
        --{
            -- Set tag name
            sbTag_Name := rc.tag_name;

            for reg in cuData loop
            --{
                blExiste :=true;
            --}
            end loop;

            if (blExiste) then
            --{
                exit;
            --}
            end if;
        --}
        end loop;

        return blExiste;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;

    /*
        Metodo      :   fnuAcometidFall
        Descripcion :   AcometidFall

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    FUNCTION fnuAcometidFall (
        inuProduct_id   in  pr_product.product_id%type,
        isbCausal       in  ld_parameter.value_chain%type
    )
    return number
    IS
        -- CURSOR
        CURSOR cuData IS
        SELECT /*+ ORDERED use_nl(a,o,c) */
                count(1)
            FROM or_order_activity a, or_order o , ge_causal c
           WHERE o.order_id = a.order_id
             AND o.task_type_id = 12457
             AND o.causal_id = c.causal_id
             AND c.class_causal_id = 2
             AND a.product_id = inuProduct_id
             AND instr(isbCausal, o.causal_id||',')>0;

        -- Variables
        nuCount     number:=0;
    BEGIN
    --{
        -- Open cursor
        open  cuData;

        -- Get data
        fetch cuData INTO nuCount;

        -- Close cursor
        close cuData;

        return nvl(nuCount,0);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;

    /*
        Metodo      :   GetProductsToNotifica
        Descripcion :   Get Products To Notifica

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
        19/03/2021  ca 472 con el fin de quitar la restriccion de no tener en cuenta lo usuarios
                          que estan en la tabla PLAZOS_CERT_PREV_COVID19
    */
    PROCEDURE GetProductsToNotifica (
        inuThreadNumber                 in  number, -- Thread number
        inuThreadsQuantity              in  number, -- Threads Quantity
        inuDias_Anti_Notf               in  number,
        inuDias_repa_OIA                in  number,
        inuDias                         in  number,
        inuDias_dif_repa                in  number,
        isbCOD_PKG_TYPE_ID_FILTRO_SUSP  in  ld_parameter.value_chain%type,
        otbServsusc                     out nocopy GDC_BCSuspension_XNO_Cert.tbtyServsuscTable
    )
    IS
    BEGIN
    --{
        -- Open cursor
        open  cuNotifica(inuThreadNumber,
                        inuThreadsQuantity,
                        inuDias_Anti_Notf,
                        inuDias_repa_OIA,
                        inuDias,
                        inuDias_dif_repa,
                        isbCOD_PKG_TYPE_ID_FILTRO_SUSP);

        -- Get data
        fetch cuNotifica BULK COLLECT INTO otbServsusc;

        -- Close cursor
        close cuNotifica;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;

    /*
        Metodo      :   fsbMeasurementCode
        Descripcion :   Measurement Code

        Autor       :   GDC
        Fecha       :   02-Ago-2019

        Historia de Modificaciones
        Fecha       IDEntrega
        02-Ago-2019 Created
    */
    FUNCTION fsbMeasurementCode (
        inuProduct_id   in  pr_product.product_id%type
    )
    return varchar2
    IS
        -- CURSOR
        CURSOR cuData IS
        SELECT em.emsscoem
        FROM   elmesesu em
        WHERE  em.emsssesu = inuProduct_id
        AND   (SYSDATE BETWEEN em.emssfein and em.emssfere);

        -- Variables
        sbEmsscoem      elmesesu.emsscoem%type;
    BEGIN
    --{
        -- Open cursor
        open  cuData;

        -- Get data
        fetch cuData INTO sbEmsscoem;

        -- Close cursor
        close cuData;

        return nvl(sbEmsscoem,'-1');
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    --}
    END;
--}
END GDC_BCSUSPENSION_XNO_CERT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre GDC_BCSUSPENSION_XNO_CERT
BEGIN
    pkg_utilidades.prAplicarPermisos('GDC_BCSUSPENSION_XNO_CERT', 'ADM_PERSON'); 
END;
/
