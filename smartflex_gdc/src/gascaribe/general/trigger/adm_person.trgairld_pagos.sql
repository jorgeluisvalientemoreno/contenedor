CREATE OR REPLACE TRIGGER ADM_PERSON.trgairLD_Pagos
after INSERT ON pagos
for each row
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger	:  trgairLD_Pagos

Descripcion	:   Despues de insertar un pago se valida si el pago corresponde a
                la totalidad del cupón, y si es así trata de notificar al flujo
                de venta FNB para que continúe

Autor	: Luis E. Fernández
Fecha	: 05-07-2013

Historia de Modificaciones
Fecha       IDEntrega               Modificación
DD-MM-YYYY  Autor.SAONNNN           Descripcion de la Modificacion
----------  ----------------------- --------------------------------------------
05-07-2013  lfernandez.SAOxxxxx     Creación
**************************************************************/
DECLARE
    ------------------------------------------------------------------------
    --  Constantes
    ------------------------------------------------------------------------
    cnuPACK_TYPE_FNB    constant ps_package_type.package_type_id%type := 100264;
    ------------------------------------------------------------------------
    --  Variables
    ------------------------------------------------------------------------
    nuJob               binary_integer;
    sbWhat              varchar2(32000);
    rcCoupon            cupon%rowtype;
    rcAccount           cuencobr%rowtype;
    rcPackage           DAMO_Packages.styMO_Packages;
    nuPackage           mo_package_payment.package_id%type;

    CURSOR cuPackByBill( inuBill mo_motive_payment.account%type )
    IS  SELECT  /*+ leading( mp )
                    index( pp PK_MO_PACKAGE_PAYMENT )
                    index( mp IDX_MO_MOTIVE_PAYMENT_04 ) */
                pp.package_id
        FROM    mo_package_payment pp, mo_motive_payment mp
        WHERE   pp.package_payment_id = mp.package_payment_id
        AND     pp.active = GE_BOConstants.csbYES
        AND     mp.active = GE_BOConstants.csbYES
        AND     mp.account = inuBill;

BEGIN

    UT_Trace.Trace( 'trgaiLD_Pagos', 15 );

    --  Obtiene la información del cupón
    rcCoupon := pkTblCupon.frcGetRecord( :new.pagocupo );

    --  Si el valor del pago es menor al valor del cupón
    if ( :new.pagovapa < rcCoupon.cupovalo ) then

        UT_Trace.Trace( 'Valor del pago menor al valor del cupón, se sale', 3 );
        return;

    end if;

    --  Si el tipo de cupón no es cuenta de cobro
    if ( rcCoupon.cupotipo <> pkBillConst.CSBTOKEN_SOLICITUD ) then

        UT_Trace.Trace( 'No es tipo de cupón anticipo, se sale', 3 );
        return;

    END if;

    /*--  Obtiene la información de la cuenta de cobro
    rcAccount := pkTblCuencobr.frcGetRecord( rcCoupon.cupodocu );


    --  Obtiene la solicitud a partir de la factura
    open  cuPackByBill( rcAccount.cucofact );
    fetch cuPackByBill INTO nuPackage;
    close cuPackByBill;
    */
    nuPackage := rcCoupon.cupodocu;
    --  Si no encontró solicitud
    if ( nuPackage IS null ) then

        UT_Trace.Trace( 'No se encontró solicitud asociada a la factura, se sale', 3 );
        return;

    end if;

    --  Obtiene la información de la solicitud
    rcPackage := DAMO_Packages.frcGetRecord( nuPackage );

    --  Si no se trata de una venta FNB
    if ( rcPackage.package_type_id <> cnuPACK_TYPE_FNB ) then

        UT_Trace.Trace( 'No es venta FNB, se sale', 3 );
        return;

    end if;

    sbWhat :=
        'BEGIN'                                                     || chr(10) ||
        '   SetSystemEnviroment;'                                   || chr(10) ||
        --  Hace avanzar el flujo de la venta FNB
        '   MO_BOWF_Pack_Interfac.PrepNotToWfPack( '                || chr(10) ||
        '           ' ||to_char( nuPackage ) || ','                 || chr(10) ||
        '           CC_BOConstants.cnuActionWaitByPay,'             || chr(10) ||
        '           MO_BOCausal.fnuGetSuccess,'                     || chr(10) ||
        '           MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY,'  || chr(10) ||
        '           FALSE );'                                       || chr(10) ||
        'END;';

    --  Crea el jub para que se ejecute un minuto después
    dbms_job.submit( nuJob,
                     sbWhat,
                     sysdate + UT_Date.cnuFACTOR_MINUTE_DATE );

    UT_Trace.Trace( 'Fin trgaiLD_Pagos', 15 );

EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Errors.SetError;
        raise ex.CONTROLLED_ERROR;
END trgairLD_Pagos;
/
