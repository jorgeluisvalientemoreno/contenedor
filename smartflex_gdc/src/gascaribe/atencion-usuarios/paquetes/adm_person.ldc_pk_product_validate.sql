CREATE OR REPLACE PACKAGE adm_person.LDC_PK_PRODUCT_VALIDATE IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PK_PRODUCT_VALIDATE
    Descripcion    : Servicios para gestionar el proceso de la forma LDC - Impresion de pagos parciales
    Autor          : Eduardo Cerón
    Fecha          : 08/02/2018

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    07/07/2024        PAcosta           OSF-2889: Cambio de esquema ADM_PERSON 
  ******************************************************************/

/*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : LDC_PK_PRODUCT_VALIDATE
    Descripcion    : Servicios para gestionar el proceso de la forma LDC - Impresion de pagos parciales
******************************************************************/

/*Servicio Get Products By Contract*/
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GETPRODUCTSBYCONTRACT
    Descripcion    : Servicio encargado de obtener la información de los productos asociados al contrato
    Autor          : Eduardo Cerón
    Fecha          : 08/02/2018

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuSesususc   Codigo del contrato
    orfProducts   Cursor con los productos de un contrato especifico

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/
PROCEDURE GETPRODUCTSBYCONTRACT
(
    inuSesususc  in          servsusc.sesususc%type,
    orfProducts  out  nocopy pkconstante.tyRefCursor
);

/*Servicio VALIDATE_EXECUTE_PARCIAL_PAY*/
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : VALIDATE_EXECUTE_PARCIAL_PAY
    Descripcion    : Servicio encargado de validar los valores del producto y cree el trámite "Impresión de pago parcial"
    Autor          : Eduardo Cerón
    Fecha          : 08/02/2018

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============    ===================
    inuValorTotal   Valor del cargo
    inuSubscription Consecutivo de producto por suscriptor
    inuProductId    Consecutivo del producto
    osbOk           Flag que indica si se puede realizar el pago o no

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/
PROCEDURE VALIDATE_EXECUTE_PARCIAL_PAY
(
    inuValorTotal       in          cargos.cargvalo%type,
    inuSubscription     in          mo_motive.subscription_id%type,
    inuProductId        in          pr_product.product_id%type,
    osbOk               out         varchar2
);

END LDC_PK_PRODUCT_VALIDATE;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PK_PRODUCT_VALIDATE IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PK_PRODUCT_VALIDATE
    Descripcion    : Servicios para gestionar el proceso de la forma LDC - Impresion de pagos parciales
    Autor          : Eduardo Cerón
    Fecha          : 08/02/2018

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    02/07/2024        PAcosta           OSF-2889: Cambio de esquema ADM_PERSON 
  ******************************************************************/

/*****************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : LDC_PK_PRODUCT_VALIDATE
    Descripcion    : Servicios para gestionar el proceso de la forma LDC - Impresion de pagos parciales
******************************************************************/

/*Servicio Get Products By Contract*/
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GETPRODUCTSBYCONTRACT
    Descripcion    : Servicio encargado de obtener la información de los productos asociados al contrato
    Autor          : Eduardo Cerón
    Fecha          : 08/02/2018

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuSesususc   Codigo del contrato
    orfProducts   Cursor con los productos de un contrato especifico

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/
PROCEDURE GETPRODUCTSBYCONTRACT(inuSesususc  in   servsusc.sesususc%type,
        orfProducts  out  nocopy pkconstante.tyRefCursor)
IS
BEGIN

        ut_trace.Trace('INICIO: LDC_PK_PRODUCT_VALIDATE.GETPRODUCTSBYCONTRACT', 8);

        open orfProducts for
            SELECT  /*+ leading( servsusc )
                        index( servsusc IX_SERVSUSC024 )
                        index( cuencobr IX_CUENCOBR13 )
                        index( servicio PK_SERVICIO )
                        use_nl( servsusc ) */
                    sesunuse Producto,
                    servcodi ||' - '|| servdesc "Tipo Producto",
                    sum(CASE WHEN ( cucofeve >= ut_date.fdtSysdate )
                             then nvl(cucosacu,0)
                             ELSE 0
                        END) sumaCorriente,
                    sum(CASE WHEN ( cucofeve >= ut_date.fdtSysdate - 30
                             AND cucofeve < ut_date.fdtSysdate )
                             then nvl(cucosacu,0)
                             ELSE 0
                        END) suma30,
                    sum(CASE WHEN ( cucofeve >= ut_date.fdtSysdate - 60
                             AND cucofeve < ut_date.fdtSysdate - 30 )
                             then nvl(cucosacu,0)
                             ELSE 0
                        END) suma60,
                    sum(CASE WHEN ( cucofeve >= ut_date.fdtSysdate - 90
                             AND cucofeve < ut_date.fdtSysdate - 60 )
                             then nvl(cucosacu,0)
                             ELSE 0
                        END) suma90,
                    sum(CASE WHEN ( cucofeve < ut_date.fdtSysdate - 90 )
                             then nvl(cucosacu,0)
                             ELSE 0
                        END) suma91
                    FROM    servsusc, cuencobr, servicio
                    WHERE   sesususc = inuSesususc
                    AND     sesunuse = cuconuse
                    AND     sesuserv = servcodi
                    GROUP BY sesunuse, servcodi, servdesc;

        ut_trace.Trace('FIN: LDC_PK_PRODUCT_VALIDATE.GETPRODUCTSBYCONTRACT', 8);
    --}
EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;

END GETPRODUCTSBYCONTRACT;

/*Servicio VALIDATE_EXECUTE_PARCIAL_PAY*/
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : VALIDATE_EXECUTE_PARCIAL_PAY
    Descripcion    : Servicio encargado de validar los valores del producto y cree el trámite "Impresión de pago parcial"
    Autor          : Eduardo Cerón
    Fecha          : 08/02/2018

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============    ===================
    inuValorTotal   Valor del cargo
    inuSubscription Consecutivo de producto por suscriptor
    inuProductId    Consecutivo del producto
    osbOk           Flag que indica si se puede realizar el pago o no

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

PROCEDURE VALIDATE_EXECUTE_PARCIAL_PAY
(
    inuValorTotal       in          cargos.cargvalo%type,
    inuSubscription     in          mo_motive.subscription_id%type,
    inuProductId        in          pr_product.product_id%type,
    osbOk               out         varchar2
)
IS
    sbReturnValue   varchar2(1);
    nuValorMinimo   ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('MIN_VALOR_PARCIAL_PAGO',0);
    sbUser          sa_user.mask%type;
    nuExisteUsuario number := 0;
    nuValorFactura  cuencobr.cucosacu%type;

    cursor  cuExisteUsuario(isbUser sa_user.mask%type)
    is
        select  count(1) cantidad
        from    LDC_PERFIL_ABONO_PROD
        where   upper(usuario) = upper(isbUser);


    cursor cuValorFactura
    is
        select t.valor
        from (select  factura.factcodi fact,sum(cuencobr.cucosacu) valor
              from    factura, cuencobr
              where   factura.factcodi = cuencobr.cucofact
              and     cuencobr.cucosacu > 0
              and     factura.factsusc = inuSubscription
              and     cuencobr.cuconuse = inuProductId
              group by factura.factcodi) t
        order by t.fact desc;

BEGIN

    ut_trace.trace('Inicia LDC_PK_PRODUCT_VALIDATE.VALIDATE_EXECUTE_PARCIAL_PAY',10);
    -- Se obtiene el usuario
    select  user
    into    sbUser
    from    dual;
    ut_trace.trace('VALIDATE_EXECUTE_PARCIAL_PAY sbUser - '||sbUser,10);
    -- Se valida si el usuario es registrado
    open cuExisteUsuario(sbUser);
    fetch cuExisteUsuario into nuExisteUsuario;
    close cuExisteUsuario;

    ut_trace.trace('VALIDATE_EXECUTE_PARCIAL_PAY nuExisteUsuario - '||nuExisteUsuario,10);
    -- Si el usuario no está registrado se realizan las validaciones
    if nuExisteUsuario = 0 then
        ut_trace.trace('VALIDATE_EXECUTE_PARCIAL_PAY inuValorTotal - '||inuValorTotal||' - nuValorMinimo - '||nuValorMinimo,10);
        -- Se valida que el valor sea mayor a cero
        if inuValorTotal < 0  then
            gi_boerrors.seterrorcodeargument(2741,'El valor debe ser mayor a cero.');
        END IF;

        -- Si el valor es menor
        if inuValorTotal < nuValorMinimo then

            open cuValorFactura;
            fetch cuValorFactura into nuValorFactura;
            close cuValorFactura;
            ut_trace.trace('VALIDATE_EXECUTE_PARCIAL_PAY inuValorTotal - '||inuValorTotal||' - nuValorFactura - '||nuValorFactura,10);
            -- Se debe validar el valor de la factura
            if inuValorTotal < nuValorFactura then
                -- Levantar excepcion
                gi_boerrors.seterrorcodeargument(2741,'El valor autorizado a pagar no es correcto. Favor validar.');
            end if;
        end if;

    end if;

    osbOk := 'Y';
    ut_trace.trace('Fin LDC_PK_PRODUCT_VALIDATE.VALIDATE_EXECUTE_PARCIAL_PAY - '||osbOk,10);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

END VALIDATE_EXECUTE_PARCIAL_PAY;


END LDC_PK_PRODUCT_VALIDATE;
/
PROMPT Otorgando permisos de ejecucion a LDC_PK_PRODUCT_VALIDATE
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PK_PRODUCT_VALIDATE', 'ADM_PERSON');
END;
/