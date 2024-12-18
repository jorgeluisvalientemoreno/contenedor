
CREATE OR REPLACE PACKAGE LDC_UTILIDADES_FACT
IS
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : ldc_utilidades_fact
    Descripcion    : Paquete que contiene las funciones o procedimientos
                     que ser?n usados en todas las gaseras
    Autor          : Llozada
    Fecha          : 06/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    07/11/2024        felipe.valencia   OSF-3568: Se modifica la función fsb_valida_imprime_factura
    13/12/2023        felipe.valencia   OSF-1939: se modifca para agregar función
                                        fsb_valida_imprime_factura y se modfican estandares tecnicos 
	01/06/2017		  KCienfuegos		CA200-875: Se modifica el metodo <<fsbgetEncabezadoEfigasConc2>>
    14/03/2017        KCienfuegos       CA200-875: Se modifican los metodos: <<validaDirCobroInst>>
                                                                             <<fsbgetEncabezadoEfigasConc2>>
    06/06/2014        llozada           Creaci?n
  ******************************************************************/

  FUNCTION validaDirCobroInst
    RETURN number;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbgetEncabezadoEfigas
    Descripcion    : Funci?n que devuelve el encabezado de EFIGAS
    Autor          : Llozada
    Fecha          : 09/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    09/06/2014        llozada           Creaci?n
    ******************************************************************/
    FUNCTION fsbgetEncabezadoEfigas
    RETURN VARCHAR2;


    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbgetEncabezadoEfigasConc1
    Descripcion    : Funci?n que devuelve el encabezado de EFIGAS
    Autor          : Llozada
    Fecha          : 09/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    09/06/2014        llozada           Creaci?n
    ******************************************************************/


    FUNCTION fsbgetEncabezadoEfigasConc1
    RETURN VARCHAR2;

        /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbgetEncabezadoEfigasConc2
    Descripcion    : Funci?n que devuelve el encabezado de EFIGAS
    Autor          : Llozada
    Fecha          : 09/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    09/06/2014        llozada           Creaci?n
    ******************************************************************/
    FUNCTION fsbgetEncabezadoEfigasConc2
    RETURN VARCHAR2;



    FUNCTION fsbGenDeliveryOrder
    return varchar2;

    FUNCTION fsb_valida_imprime_factura 
    (
        inuContrato     IN   suscripc.susccodi%TYPE
    )
    RETURN VARCHAR2;

END ldc_utilidades_fact;
/
CREATE OR REPLACE PACKAGE BODY LDC_UTILIDADES_FACT IS
    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : ldc_utilidades_fact
      Descripcion    : Paquete que contiene las funciones o procedimientos
                       que ser?n usados en todas las gaseras
      Autor          : Llozada
      Fecha          : 06/06/2014

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      13/12/2023        felipe.valencia   OSF-1939: se modifca para agregar función
                                          fsb_valida_imprime_factura y se modfican estandares tecnicos 
      01/06/2017        KCienfuegos       CA200-875: Se modifica el metodo <<fsbgetEncabezadoEfigasConc2>>
      14/03/2017        KCienfuegos       CA200-875: Se modifican los metodos: <<validaDirCobroInst>>
                                                                               <<fsbgetEncabezadoEfigasConc2>>
      06/06/2014        llozada           Creaci?n
    ******************************************************************/

    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';--constante nombre del paquete    
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;--Nivel de traza para este paquete. 


    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : validaDirCobroInst
    Descripcion    : Funcion para validar direccion de cobro o instalacion
    Autor          : Llozada
    Fecha          : 09/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    14/03/2017        KCienfuegos       CA200-875: Se valida que cuando sbSusc sea nulo, obtenga
                                        el contrato de la entidad base Suscripc.
    09/06/2014        llozada           Creaci?n
    ******************************************************************/
    FUNCTION validaDirCobroInst RETURN NUMBER AS
        sbSusc     ge_boInstanceControl.stysbValue;
        nuSusc     factura.factcodi%TYPE;
        nuDirCobro suscripc.susciddi%TYPE;
        nuDirInsta pr_product.address_id%TYPE;
        nuZone     OR_ROUTE_ZONE.operating_zone_id%TYPE;

        CURSOR cuDir IS
            SELECT susciddi, pr.address_id, ro.operating_zone_id
            FROM suscripc      co,
                 pr_product    pr,
                 ab_ADDRESS    ab,
                 ab_segments   seg,
                 OR_ROUTE_ZONE ro
            WHERE co.susccodi = nuSusc
                  AND co.susccodi = pr.subscription_id
                  AND co.susciddi = ab.address_id
                  AND ab.segment_id = seg.segments_id
                  AND seg.route_id = ro.route_id
                  AND rownum < 2;

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'validaDirCobroInst';

    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        -- Obtiene el identificador de la factura instanciada

        sbSusc := api_obtenervalorinstancia('FACTURA', 'FACTSUSC');

        -- CA200-875
        IF (sbSusc IS NULL) THEN
            sbSusc := api_obtenervalorinstancia('SUSCRIPC', 'SUSCCODI');
        END IF;
        --Fin CA200-875

        nuSusc := to_number(sbSusc);

        IF cuDir%ISOPEN THEN
            CLOSE cuDir;
        END IF;

        OPEN cuDir;
        FETCH cuDir
            INTO nuDirCobro, nuDirInsta, nuZone;
        CLOSE cuDir;

        IF nuDirCobro IS NOT NULL
           AND nuDirInsta IS NOT NULL THEN
            --IF nuDirCobro != nuDirInsta THEN
            RETURN nuZone;
            --END IF;
        END IF;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN 0;

    END validaDirCobroInst;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : getEncabezadoEfigas
    Descripcion    : Funci?n que devuelve el encabezado de EFIGAS
    Autor          : Llozada
    Fecha          : 09/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    09/06/2014        llozada           Creaci?n
    ******************************************************************/
    FUNCTION fsbgetEncabezadoEfigas RETURN VARCHAR2 IS
        sbEncabezado VARCHAR2(4000);

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbgetEncabezadoEfigas';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        sbEncabezado := 'FACTURA|CUPON|CONTRATO|NOMBRE|DIRECCION_COBRO|DIRECCION_PREDIO|DESC_BARRIO|LOCALIDAD|CATEGORIA|ESTRATO|' ||
                        'CICLO|INTERES_MORA|PAGO_HASTA|FECHA_SUSPENSION|PERIODO_FACTURADO|TOTAL_FACTURA|LECTURA_ANTERIOR|LECTURA_ACTUAL|' ||
                        'OBS_LECTURA|CONSUMO_ACTUAL|FECHA_EXPEDICION|MEDIDOR|PODER_CALORIFICO|FACTOR_CORRECCION|CONSUMO_K_W_H|' ||
                        'CONSUMO_MES_1|FECHA_CONS_MES_1|CONSUMO_MES_2|FECHA_CONS_MES_2|CONSUMO_MES_3|FECHA_CONS_MES_3|' ||
                        'CONSUMO_MES_4|FECHA_CONS_MES_4|CONSUMO_MES_5|FECHA_CONS_MES_5|CONSUMO_MES_6|FECHA_CONS_MES_6|CONSUMO_PROMEDIO|CONSECUTIVO|' ||
                        'OBS_PROMOCION|TIJERA|MSJ_FACTURA|PERIODO_COBRO|COD_BARRA_1|COD_BARRA_2|COD_BARRA_3|COD_BARRA_4|' ||
                        'CODIGO_BARRAS|C_SERVICIO|TOTAL_SERVICIO_CARGOS|TOTAL_AMORTIZACION|TOTAL_DIFERIDOS|CUPO_DISPONIBLE|' ||
                        'TARIFA_GM|TARIFA_TM|TARIFA_DM|TARIFA_CV|TARIFA_CC|TARIFA_CVARIABLE|TARIFA_AS|TARIFA_PORCSU|' ||
                        'TARIFA_SUBSIDIADA|TARIFA_DS|TARIFA_CFIJO|TOTAL_GAS|TOTAL_BRILLA|TOTAL_OTROS|TOTAL_RECLAMO|TOTAL_RECONEXION|' ||
                        'TOTAL_REINSTALACION|TOTAL_REV_PERIODICA|MSJ_REV_SEGURA|TIPO_NOTIFICACION|FECHA_REVISION|CUPON_1|VAL_CUPON_1|' ||
                        'CUPON_2|VAL_CUPON_2|NUM_HOJAS|NUM_CARGOS|' ||
                        'CONCEPTO_1|VAL_CARGO_1|VAL_AMORTIZACION_1|VAL_DIFE_1|CUOTAS_PENDIE_1|' ||
                        'CONCEPTO_2|VAL_CARGO_2|VAL_AMORTIZACION_2|VAL_DIFE_2|CUOTAS_PENDIE_2|' ||
                        'CONCEPTO_3|VAL_CARGO_3|VAL_AMORTIZACION_3|VAL_DIFE_3|CUOTAS_PENDIE_3|' ||
                        'CONCEPTO_4|VAL_CARGO_4|VAL_AMORTIZACION_4|VAL_DIFE_4|CUOTAS_PENDIE_4|' ||
                        'CONCEPTO_5|VAL_CARGO_5|VAL_AMORTIZACION_5|VAL_DIFE_5|CUOTAS_PENDIE_5|' ||
                        'CONCEPTO_6|VAL_CARGO_6|VAL_AMORTIZACION_6|VAL_DIFE_6|CUOTAS_PENDIE_6|' ||
                        'CONCEPTO_7|VAL_CARGO_7|VAL_AMORTIZACION_7|VAL_DIFE_7|CUOTAS_PENDIE_7|' ||
                        'CONCEPTO_8|VAL_CARGO_8|VAL_AMORTIZACION_8|VAL_DIFE_8|CUOTAS_PENDIE_8|' ||
                        'CONCEPTO_9|VAL_CARGO_9|VAL_AMORTIZACION_9|VAL_DIFE_9|CUOTAS_PENDIE_9|' ||
                        'CONCEPTO_10|VAL_CARGO_10|VAL_AMORTIZACION_10|VAL_DIFE_10|CUOTAS_PENDIE_10';

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN sbEncabezado;

    END fsbgetEncabezadoEfigas;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbgetEncabezadoEfigasConc1
    Descripcion    : Funci?n que devuelve el encabezado de EFIGAS
    Autor          : Llozada
    Fecha          : 09/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    09/06/2014        llozada           Creaci?n
    ******************************************************************/
    FUNCTION fsbgetEncabezadoEfigasConc1 RETURN VARCHAR2 IS
        sbEncabezado VARCHAR2(4000);

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbgetEncabezadoEfigasConc1';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        sbEncabezado := '|CONCEPTO_11|VAL_CARGO_11|VAL_AMORTIZACION_11|VAL_DIFE_11|CUOTAS_PENDIE_11|' ||
                        'CONCEPTO_12|VAL_CARGO_12|VAL_AMORTIZACION_12|VAL_DIFE_12|CUOTAS_PENDIE_12|' ||
                        'CONCEPTO_13|VAL_CARGO_13|VAL_AMORTIZACION_13|VAL_DIFE_13|CUOTAS_PENDIE_13|' ||
                        'CONCEPTO_14|VAL_CARGO_14|VAL_AMORTIZACION_14|VAL_DIFE_14|CUOTAS_PENDIE_14|' ||
                        'CONCEPTO_15|VAL_CARGO_15|VAL_AMORTIZACION_15|VAL_DIFE_15|CUOTAS_PENDIE_15|' ||
                        'CONCEPTO_16|VAL_CARGO_16|VAL_AMORTIZACION_16|VAL_DIFE_16|CUOTAS_PENDIE_16|' ||
                        'CONCEPTO_17|VAL_CARGO_17|VAL_AMORTIZACION_17|VAL_DIFE_17|CUOTAS_PENDIE_17|' ||
                        'CONCEPTO_18|VAL_CARGO_18|VAL_AMORTIZACION_18|VAL_DIFE_18|CUOTAS_PENDIE_18|' ||
                        'CONCEPTO_19|VAL_CARGO_19|VAL_AMORTIZACION_19|VAL_DIFE_19|CUOTAS_PENDIE_19|' ||
                        'CONCEPTO_20|VAL_CARGO_20|VAL_AMORTIZACION_20|VAL_DIFE_20|CUOTAS_PENDIE_20|' ||
                        'CONCEPTO_21|VAL_CARGO_21|VAL_AMORTIZACION_21|VAL_DIFE_21|CUOTAS_PENDIE_21|' ||
                        'CONCEPTO_22|VAL_CARGO_22|VAL_AMORTIZACION_22|VAL_DIFE_22|CUOTAS_PENDIE_22|' ||
                        'CONCEPTO_23|VAL_CARGO_23|VAL_AMORTIZACION_23|VAL_DIFE_23|CUOTAS_PENDIE_23|' ||
                        'CONCEPTO_24|VAL_CARGO_24|VAL_AMORTIZACION_24|VAL_DIFE_24|CUOTAS_PENDIE_24|' ||
                        'CONCEPTO_25|VAL_CARGO_25|VAL_AMORTIZACION_25|VAL_DIFE_25|CUOTAS_PENDIE_25|' ||
                        'CONCEPTO_26|VAL_CARGO_26|VAL_AMORTIZACION_26|VAL_DIFE_26|CUOTAS_PENDIE_26|' ||
                        'CONCEPTO_27|VAL_CARGO_27|VAL_AMORTIZACION_27|VAL_DIFE_27|CUOTAS_PENDIE_27|' ||
                        'CONCEPTO_28|VAL_CARGO_28|VAL_AMORTIZACION_28|VAL_DIFE_28|CUOTAS_PENDIE_28|' ||
                        'CONCEPTO_29|VAL_CARGO_29|VAL_AMORTIZACION_29|VAL_DIFE_29|CUOTAS_PENDIE_29|' ||
                        'CONCEPTO_30|VAL_CARGO_30|VAL_AMORTIZACION_30|VAL_DIFE_30|CUOTAS_PENDIE_30|' ||
                        'CONCEPTO_31|VAL_CARGO_31|VAL_AMORTIZACION_31|VAL_DIFE_31|CUOTAS_PENDIE_31|' ||
                        'CONCEPTO_32|VAL_CARGO_32|VAL_AMORTIZACION_32|VAL_DIFE_32|CUOTAS_PENDIE_32|' ||
                        'CONCEPTO_33|VAL_CARGO_33|VAL_AMORTIZACION_33|VAL_DIFE_33|CUOTAS_PENDIE_33|' ||
                        'CONCEPTO_34|VAL_CARGO_34|VAL_AMORTIZACION_34|VAL_DIFE_34|CUOTAS_PENDIE_34|' ||
                        'CONCEPTO_35|VAL_CARGO_35|VAL_AMORTIZACION_35|VAL_DIFE_35|CUOTAS_PENDIE_35';

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN sbEncabezado;

    END fsbgetEncabezadoEfigasConc1;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbgetEncabezadoEfigasConc2
    Descripcion    : Funci?n que devuelve el encabezado de EFIGAS
    Autor          : Llozada
    Fecha          : 09/06/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    01/06/2017        KCienfuegos       CA200-875 Se quita el encabezado del saldo a favor por solicitud del N1 JSoto.
    13/03/2017        KCienfuegos       CA200-875 Se agrega el campo SALDO_FAVOR
    09/06/2014        llozada           Creaci?n
    ******************************************************************/
    FUNCTION fsbgetEncabezadoEfigasConc2 RETURN VARCHAR2 IS
        sbEncabezado VARCHAR2(4000);

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbgetEncabezadoEfigasConc2';
    BEGIN

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        sbEncabezado := '|CONCEPTO_36|VAL_CARGO_36|VAL_AMORTIZACION_36|VAL_DIFE_36|CUOTAS_PENDIE_36|' ||
                        'CONCEPTO_37|VAL_CARGO_37|VAL_AMORTIZACION_37|VAL_DIFE_37|CUOTAS_PENDIE_37|' ||
                        'CONCEPTO_38|VAL_CARGO_38|VAL_AMORTIZACION_38|VAL_DIFE_38|CUOTAS_PENDIE_38|' ||
                        'CONCEPTO_39|VAL_CARGO_39|VAL_AMORTIZACION_39|VAL_DIFE_39|CUOTAS_PENDIE_39|' ||
                        'CONCEPTO_40|VAL_CARGO_40|VAL_AMORTIZACION_40|VAL_DIFE_40|CUOTAS_PENDIE_40|' ||
                        'CONCEPTO_41|VAL_CARGO_41|VAL_AMORTIZACION_41|VAL_DIFE_41|CUOTAS_PENDIE_41|' ||
                        'CONCEPTO_42|VAL_CARGO_42|VAL_AMORTIZACION_42|VAL_DIFE_42|CUOTAS_PENDIE_42|' ||
                        'CONCEPTO_43|VAL_CARGO_43|VAL_AMORTIZACION_43|VAL_DIFE_43|CUOTAS_PENDIE_43|' ||
                        'CONCEPTO_44|VAL_CARGO_44|VAL_AMORTIZACION_44|VAL_DIFE_44|CUOTAS_PENDIE_44|' ||
                        'CONCEPTO_45|VAL_CARGO_45|VAL_AMORTIZACION_45|VAL_DIFE_45|CUOTAS_PENDIE_45|' ||
                        'CONCEPTO_46|VAL_CARGO_46|VAL_AMORTIZACION_46|VAL_DIFE_46|CUOTAS_PENDIE_46|' ||
                        'CONCEPTO_47|VAL_CARGO_47|VAL_AMORTIZACION_47|VAL_DIFE_47|CUOTAS_PENDIE_47|' ||
                        'CONCEPTO_48|VAL_CARGO_48|VAL_AMORTIZACION_48|VAL_DIFE_48|CUOTAS_PENDIE_48|' ||
                        'CONCEPTO_49|VAL_CARGO_49|VAL_AMORTIZACION_49|VAL_DIFE_49|CUOTAS_PENDIE_49|' ||
                        'CONCEPTO_50|VAL_CARGO_50|VAL_AMORTIZACION_50|VAL_DIFE_50|CUOTAS_PENDIE_50|' ||
                        'CONCEPTO_51|VAL_CARGO_51|VAL_AMORTIZACION_51|VAL_DIFE_51|CUOTAS_PENDIE_51|' ||
                        'CONCEPTO_52|VAL_CARGO_52|VAL_AMORTIZACION_52|VAL_DIFE_52|CUOTAS_PENDIE_52|' ||
                        'CONCEPTO_53|VAL_CARGO_53|VAL_AMORTIZACION_53|VAL_DIFE_53|CUOTAS_PENDIE_53|' ||
                        'CONCEPTO_54|VAL_CARGO_54|VAL_AMORTIZACION_54|VAL_DIFE_54|CUOTAS_PENDIE_54|' ||
                        'CONCEPTO_55|VAL_CARGO_55|VAL_AMORTIZACION_55|VAL_DIFE_55|CUOTAS_PENDIE_55|' ||
                        'CONCEPTO_56|VAL_CARGO_56|VAL_AMORTIZACION_56|VAL_DIFE_56|CUOTAS_PENDIE_56|' ||
                        'CONCEPTO_57|VAL_CARGO_57|VAL_AMORTIZACION_57|VAL_DIFE_57|CUOTAS_PENDIE_57|' ||
                        'CONCEPTO_58|VAL_CARGO_58|VAL_AMORTIZACION_58|VAL_DIFE_58|CUOTAS_PENDIE_58|' ||
                        'CONCEPTO_59|VAL_CARGO_59|VAL_AMORTIZACION_59|VAL_DIFE_59|CUOTAS_PENDIE_59|' ||
                        'CONCEPTO_60|VAL_CARGO_60|VAL_AMORTIZACION_60|VAL_DIFE_60|CUOTAS_PENDIE_60';
        --'SALDO_FAVOR';

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN sbEncabezado;

    END fsbgetEncabezadoEfigasConc2;

    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  GenDeliveryOrder
    Descripcion : Generar la orden de reparto de factura
    Autor       : Sergio Mejia - Optima COnsulting
    Fecha       : 2-12-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    2-12-2013           smejia              Creacion.
		06/07/2017          Luis Fren G.        Se modifica la consulta principal
		                                        Segun la recomendacion del N1
    **************************************************************************/
    FUNCTION fsbGenDeliveryOrder RETURN VARCHAR2 IS

        rcSubscription          suscripc%ROWTYPE;
        nuSesuserv              servsusc.sesuserv%TYPE;
        nuItemBarriosIguales    NUMBER := 4000803;
        nuItemBarriosDiferentes NUMBER := 4000998;
        sbReturn                VARCHAR2(2000);

        sbEnviaDigital          VARCHAR2(2);

        sbFactcodi  ge_boInstanceControl.stysbValue;
        nuPeriodo   factura.factcodi%TYPE;

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbGenDeliveryOrder';

        sbError             VARCHAR2(4000);
        nuError             NUMBER;   

        CURSOR cuTipoServicio
        IS
        SELECT sesuserv
        FROM (SELECT sesuserv
                FROM servsusc, factura, confesco
                WHERE factcodi = sbFactcodi
                    AND sesususc = factsusc
                    AND coecserv = sesuserv
                    AND coeccodi = sesuesco
                    AND coecfact = 'S'
                    AND sesuserv NOT IN (3)
                    ORDER BY sesuserv)
        WHERE rownum = 1;

        CURSOR cuPeriodoFactura
        (
            inuFactura IN factura.factcodi%TYPE
        )
        IS
        SELECT factpefa
        FROM    factura 
        WHERE   factcodi = inuFactura;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        -- Obtiene el registro del contrato
        pkBOInstancePrintingData.GetContract(rcSubscription);

        sbEnviaDigital := ldc_utilidades_fact.fsb_valida_imprime_factura(rcSubscription.susccodi);

        -- Obtiene el identificador de la factura instanciada
        sbFactcodi := api_obtenervalorinstancia('FACTURA', 'FACTCODI');

        IF cuPeriodoFactura%ISOPEN THEN
            CLOSE cuPeriodoFactura;
        END IF;

        OPEN cuPeriodoFactura(to_number(sbFactcodi));
        FETCH cuPeriodoFactura INTO nuPeriodo;
        CLOSE  cuPeriodoFactura;

        pkg_detalle_envio_fact_digital.prc_borra_envio_fact_digital(rcSubscription.susccodi,to_number(sbFactcodi),nuPeriodo);

        -- Obtiene cualquiera de los productos del contrato. Se ordenan de modo que se trate de obtener primero el de gas
        BEGIN

            IF cuTipoServicio%ISOPEN THEN
                CLOSE cuTipoServicio;
            END IF;

            OPEN cuTipoServicio;
            FETCH cuTipoServicio INTO nuSesuserv;

            IF cuTipoServicio%NOTFOUND THEN
                CLOSE cuTipoServicio;
                PKG_ERROR.seterrormessage(isbMsgErrr=>'No se encontro un producto asociado al contrato');
            END IF;

            CLOSE cuTipoServicio;

        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
                RAISE pkg_Error.Controlled_Error;
            --Validación de error no controlado
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
                RAISE pkg_Error.Controlled_Error;    
        END;
        -- Se genera la orden de raparto
        IF (sbEnviaDigital = 'S') THEN
            sbReturn := PKBOBILLPRINTUTILITIES.FSBGENDELIVERYORDER(nuSesuserv, nuItemBarriosIguales, nuItemBarriosDiferentes);
        ELSE
            pkg_detalle_envio_fact_digital.prc_reg_envio_fact_digital(rcSubscription.susccodi,to_number(sbFactcodi),nuPeriodo);
        END IF;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN sbReturn;
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        --Validación de error no controlado
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;      
    END fsbGenDeliveryOrder;

    FUNCTION fsb_valida_imprime_factura 
    (
        inuContrato     IN   suscripc.susccodi%TYPE
    )
    RETURN VARCHAR2 
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbNOMPKG||'fsb_valida_imprime_factura';

        sbError                 VARCHAR2(4000);
        nuError                 NUMBER;   
        sbFlagImpre              ld_parameter.value_chain%TYPE;

        nuEnvioDigital          NUMBER(4);
        nuCartera               NUMBER(4);
        sbRespuesta             VARCHAR2(2) := 'S';

        CURSOR cuObtieneFlagFactDigital
        (
            inuContratoCliente      IN   suscripc.susccodi%TYPE
        )
        IS
        SELECT COUNT(1)
        FROM    suscripc s
        WHERE   s.susccodi = inuContratoCliente
        AND     suscefce   = 'S'
        AND     suscdeco IS NOT NULL;

        CURSOR cuObtieneMoraNoventa
        (
            inuContratoCliente      IN   suscripc.susccodi%TYPE
        )
        IS
        SELECT COUNT(1)
        FROM ldc_cartdiaria cd
        WHERE cd.contrato = inuContratoCliente
        AND cd.edad_mora >= 90;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        sbFlagImpre := pkg_bcld_parameter.fsbobtienevalorcadena('VALIDAIMPRFACTFISICASPOOL');

        IF sbFlagImpre = 'S' THEN

            IF cuObtieneFlagFactDigital%ISOPEN THEN
                CLOSE cuObtieneFlagFactDigital;
            END IF;
            -- Se valida si el usuario esta marcado para envio de factura digital
            OPEN  cuObtieneFlagFactDigital (inuContrato);
            FETCH cuObtieneFlagFactDigital INTO  nuEnvioDigital;
            CLOSE cuObtieneFlagFactDigital;

            IF cuObtieneMoraNoventa%ISOPEN THEN
                CLOSE cuObtieneMoraNoventa;
            END IF;

            -- Se valida si el usuario esta mayor a 90 dias
            OPEN  cuObtieneMoraNoventa (inuContrato);
            FETCH cuObtieneMoraNoventa INTO  nuCartera;
            CLOSE cuObtieneMoraNoventa;

            -- Se validan las condiciones
            IF nuEnvioDigital >= 1 AND nuCartera = 0 THEN
                sbRespuesta := 'N';
            ELSE
                sbRespuesta := 'S';
            END IF;
        ELSE
            sbRespuesta := 'S';
        END IF;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN sbRespuesta;
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        --Validación de error no controlado
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;      
    END fsb_valida_imprime_factura;

END ldc_utilidades_fact;
/