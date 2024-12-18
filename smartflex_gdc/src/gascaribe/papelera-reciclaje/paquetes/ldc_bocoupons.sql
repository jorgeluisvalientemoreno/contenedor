CREATE OR REPLACE PACKAGE ldc_bocoupons
IS
   -- Variables
    sbCouponAttribs      VARCHAR2(3000);

  -- Declaracion de variables publicas

  -- Declaracion de metodos publicos

    /**************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad       : fsbVersion
    Descripcion   : Retorna la version del paquete.
    ***************************************************************************/
    FUNCTION fsbVersion return varchar2;

    PROCEDURE FillCouponAtt;

    PROCEDURE GetCoupons
    (
        inuPackage in mo_packages.package_id%type,
        ocuCursor  out constants.tyRefCursor
    );

  /**************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Unidad       : GetCoupon
    Descripcion   : Obtiene la informacion de los cupones de una suscripcion.
    ***************************************************************************/
    PROCEDURE GetCoupon
    (
        INUSUBSCRIPTION IN VARCHAR2, OCUCURSOR OUT CONSTANTS.TYREFCURSOR
    );

    PROCEDURE GetSuscriptionIdByCupon
    (
        inuCoupon     in  cupon.cuponume%type,
        onuSuscriptionId  out suscripc.susccodi%type
    );

END ldc_bocoupons;
/
CREATE OR REPLACE PACKAGE BODY ldc_bocoupons IS

   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO178143';

   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;

    /***************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Unidad: FillCouponAtt

    Descripcion:   Arma el sql y llena la tabla de atributos para la seleccion
                    de registros de cupones


    Historia de Modificaciones
    Fecha       Autor               Modificacion
    =========   =========           ====================
    08-03-2013  Ocossio.SAO203915   Se modifican los Atributos para mejorar la
                                    presentacion de los datos
    01-03-2013  Ocossio.SAO202727   Creacion
    ****************************************************************************/
    PROCEDURE FillCouponAtt
    IS
      SBVALOID     VARCHAR2( 500 );
    BEGIN

         if sbCouponAttribs IS not null then
            return;
        END if;

        SBVALOID := 'c.CUPONUME||'';''||c.CUPOSUSC';
        cc_boBossUtil.AddAttribute ('c.CUPONUME', 'CUPONUME',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOTIPO', 'CUPOTIPO',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPODOCU', 'CUPODOCU',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOVALO', 'CUPOVALO',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOFECH', 'CUPOFECH',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOPROG', 'CUPOPROG',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOCUPA', 'CUPOCUPA',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('c.CUPOSUSC', 'CUPOSUSC',  sbCouponAttribs);
        cc_boBossUtil.AddAttribute ('decode(c.CUPOFLPA,'''||'S'||''','''||'SI'||''','''||'NO'||''')', 'CUPOFLPA',  sbCouponAttribs);

        cc_boBossUtil.AddAttribute( SBVALOID, 'Id', sbCouponAttribs );

        cc_boBossUtil.AddAttribute (':parent_id', 'parent_id', sbCouponAttribs);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END FillCouponAtt;


    PROCEDURE GetCoupons
    (
        inuPackage in mo_packages.package_id%type,
        ocuCursor  out constants.tyRefCursor
    )
    IS
        ----------------------------------------------------------------------------
        --  Variables
        ----------------------------------------------------------------------------
        --cuCursor        constants.tyRefCursor;
        sbSql           varchar2(4000);

    BEGIN
          ut_trace.trace('Inicia ldc_bocoupons.GetCoupon',6 );

          /* Obtiene los atributos del cupon */
          FillCouponAtt;

          /* Construye el sql */
          sbSql     :=  'SELECT /*+ leading( pp ) use_nl(pp mp c) '                                     ||chr(10)||
                        '       index( pp IDX_MO_PACKAGE_PAYMENT )'                                     ||chr(10)||
                        '       index( mp IDX_MO_MOTIVE_PAYMENT_05 )'                                   ||chr(10)||
                        '       index( c PK_CUPON ) */'                                                 ||chr(10)||
                                sbCouponAttribs                                                         ||chr(10)||
                        'FROM   mo_package_payment pp, mo_motive_payment mp, cupon c'                   ||chr(10)||
                        '       /*+ cc_boCoupon.GetCoupons */'                                          ||chr(10)||
                        'WHERE  pp.package_id  = :inuPackage'                                           ||chr(10)||
                        'AND    pp.package_payment_id = mp.package_payment_id'                          ||chr(10)||
                        'AND    c.cuponume = mp.coupon_id'                                              ||chr(10)||
                        'AND    mp.active = ''' || cc_boBossUtil.csbYES || ''''                         ||chr(10)||
                        'AND    c.cupotipo <> '||chr(39)|| pkbillconst.csbTOKEN_SOLICITUD ||chr(39)     ||chr(10)||

                        'UNION ALL'                                                                     ||chr(10)||

                        'SELECT /*+ leading( pp ) use_nl(pp mp c) '                                     ||chr(10)||
                        '       index( pp IDX_MO_PACKAGE_PAYMENT )'                                     ||chr(10)||
                        '       index( mp IDX_MO_MOTIVE_PAYMENT_05 )'                                   ||chr(10)||
                        '       index( c IX_CUPO_DOCU_TIPO ) */ '                                       ||chr(10)||
                                sbCouponAttribs||''                                                     ||chr(10)||
                        'FROM   mo_package_payment pp, mo_motive_payment mp, cupon c'                   ||chr(10)||
                        'WHERE  pp.package_id = :inuPackage '                                           ||chr(10)||
                        'AND    pp.package_payment_id = mp.package_payment_id '                         ||chr(10)||
                        'AND    mp.support_document = c.cupodocu '                                      ||chr(10)||
                        'AND    mp.coupon_id IS null'                                                   ||chr(10)||
                        'AND    c.cupotipo in ('||chr(39)|| pkbillconst.csbTOKEN_APLICA_FACTURA ||chr(39)||', '||
                                                  chr(39)|| pkbillconst.csbTOKEN_FACTURA ||chr(39) ||')'||chr(10)||
                        'AND    mp.active = '||chr(39)|| cc_boBossUtil.csbYES ||chr(39)                 ||chr(10)||

                        'UNION ALL'                                                                     ||chr(10)||

                        'SELECT /*+ leading( pp ) use_nl(pp mp c)'                                      ||chr(10)||
                        '       index( pp IDX_MO_PACKAGE_PAYMENT )'                                     ||chr(10)||
                        '       index( mp IDX_MO_MOTIVE_PAYMENT_05 )'                                   ||chr(10)||
                        '       index( c IX_CUPO_DOCU_TIPO ) */ '                                       ||chr(10)||
                                sbCouponAttribs||''                                                     ||chr(10)||
                        'FROM   mo_package_payment pp, cupon c'                                         ||chr(10)||
                        'WHERE  pp.package_id  = :inuPackage '                                          ||chr(10)||
                        'AND    c.cupodocu = to_char(pp.package_id)'                                    ||chr(10)||
                        'AND    c.cupotipo = '||chr(39)|| pkbillconst.csbTOKEN_SOLICITUD ||chr(39)      ||chr(10)||

                        'UNION ALL'                                                                     ||chr(10)||

                        'SELECT /*+ index (c IX_CUPO_DOCU_TIPO)*/ '                                     ||chr(10)||
                                sbCouponAttribs||''                                                     ||chr(10)||
                        'FROM   cupon c'                                                                ||chr(10)||
                        'WHERE  c.cupodocu = to_char(:inuPackage)'                                      ||chr(10)||
                        'AND    c.cupotipo = '||chr(39)|| pkbillconst.DEPOSITO ||chr(39)||'';

                       ut_trace.Trace('SENTENCIA['||sbSql||']', 20);

        OPEN ocuCursor FOR sbSql using inuPackage, inuPackage, inuPackage, inuPackage, inuPackage, inuPackage, inuPackage, inuPackage;

        ut_trace.trace('Termina ldc_bocoupons.GetCoupon',6 );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END GetCoupons;


   PROCEDURE GetCoupon( INUSUBSCRIPTION IN VARCHAR2,
                         OCUCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      SBSQL VARCHAR2( 10000 );
    BEGIN

    UT_TRACE.TRACE( 'Begin ldc_bocoupons.GetCoupons', 10 );

    FillCouponAtt;

    sbSql := ' SELECT '||sbCouponAttribs||' '                ||chr(10)||
          'FROM  /*+ cc_boCoupon.GetCoupon */ cupon c '  ||chr(10)||
          'WHERE  c.cuposusc = :INUSUBSCRIPTION';

   -- open ocuCursor for sbSql using cc_bobossutil.cnuNULL, INUSUBSCRIPTION;
    open ocuCursor for sbSql using INUSUBSCRIPTION, INUSUBSCRIPTION;

    UT_TRACE.TRACE( 'Sentencia: ' || SBSQL, 10 );
    UT_TRACE.TRACE( 'End ldc_bocoupons.GetCoupons', 10 );

    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;

    PROCEDURE GetSuscriptionIdByCupon
    (
        inuCoupon     in  cupon.cuponume%type,
        onuSuscriptionId  out suscripc.susccodi%type
    )
    IS
      --rcCupon             cupon%rowtype;
      NUCONTRATO NUMBER;
    BEGIN

        ut_trace.trace('Inicia ldc_bocoupons.GetSuscriptionIdByCupon',6 );

      IF inuCoupon IS NULL THEN
         onuSuscriptionId := NULL;
         RETURN;
       ELSE
         NUCONTRATO := TO_NUMBER( UT_STRING.EXTSTRFIELD( inuCoupon, ';', 2 ) );
         onuSuscriptionId := NUCONTRATO;
         UT_TRACE.TRACE( 'Entro If. nuContrato: ' || NUCONTRATO, 10 );
      END IF;
      TD( 'contrato: ' || NUCONTRATO );
      UT_TRACE.TRACE( 'Fin de ldc_boPayment.GetSubscriptionId Contrato[' || onuSuscriptionId || ']', 5 );

/*        \* Valida que el cupon ingresado no sea nulo *\
        IF inuCoupon IS NULL THEN
            onuSuscriptionId := NULL;
            RETURN;
        END IF;

        \* Obtiene el registro del cupon *\
        rcCupon := pktblcupon.frcGetRecord(inuCoupon);

        \* Si el cupon es de tipo DE o PP, la solicitud es igual al documento soporte del cupon *\
        IF (rcCupon.cuposusc IS NOT NULL) THEN
            onuSuscriptionId := to_number(rcCupon.cuposusc);
        END IF;
*/
        ut_trace.trace('Fin ldc_bocoupons.GetSuscriptionIdByCupon',6 );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            onuSuscriptionId := NULL;
        when others then
            ERRORS.seterror;
            raise ex.CONTROLLED_ERROR;
    END GetSuscriptionIdByCupon;


END ldc_bocoupons;
/
GRANT EXECUTE on LDC_BOCOUPONS to SYSTEM_OBJ_PRIVS_ROLE;
/
