CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_PKVENTAFNB is

  TYPE tyRefCursor IS REF CURSOR;

  /*****************************************************************

  Propiedad intelectual de GDO (c).



  Unidad         : LDC_PRGETINFOCODEUDOR

  Descripcion    : Funci?n para consultar la identificacion nueva y anterior.

  Autor          : Jorge Valiente

  Fecha          : 17/02/2016



  Parametros              Descripcion

  ============         ===================



  Fecha             Autor                Modificacion

  =========       =========             ====================

  ******************************************************************/

  PROCEDURE LDC_PRGETINFOCODEUDOR(isbIdentification_old in ge_subscriber.identification%type,

                                  isbIdentification_new in ge_subscriber.identification%type,

                                  onuSubscriberId_old out ge_subscriber.subscriber_id%type,

                                  onuSubscriberId_new out ge_subscriber.subscriber_id%type,

                                  onuCodigoError out number,

                                  osbMensajeError out varchar2);

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  fblValidNumFactMin

  Descripcion :  Valida si el contrato cumple con el numero de facturas minimas

                 para permitir la venta en FIFAP.

  Autor       :  Jorge Valiente

  Fecha       :  13-07-2015



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION fblValidCanFact(inuSubscription in suscripc.susccodi%type)

   RETURN BOOLEAN;

  --Inicio 200-310

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FNUCANTVENTSINCANC

  Descripcion :  Valida si el CODEUDOR esta asociado a solicitudes de ventas FNB aun activas.

                 Es decir aun no an terminado de ser canceladas por el DEUDOR en FIFAP.

  Autor       :  Jorge Valiente

  Fecha       :  21-10-2016



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FNUCANTVENTSINCANC(inuIdentTypeCodeudor in ldc_codeudor.iden_type_codeudor%type,

                              inuIdentCodeudor in ldc_codeudor.iden_codeudor%type)

   RETURN number;

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FRTCODEUDORACTUALIZADO

  Descripcion :  Retorna los datos GENERALES para mostrar en LDCIF.

  Autor       :  Jorge Valiente

  Fecha       :  21-10-2016



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FRTDATOSGENERALES(inufindvalue in ld_non_ban_fi_item.NON_BA_FI_REQU_ID%type)

   RETURN tyRefCursor;

  --Fin 200-310

  --Inicio 200-468

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FNUPROVEEDORVENTAMATERIALES

  Descripcion :  Valida si el PROVEEDOR puede realizar venta de materiales sin CODEUDOR en FIFAP

                 mediante la configuracion registrada en al tabal LDC_PROVSINCODE.

  Autor       :  Jorge Valiente

  Fecha       :  05-01-2017



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FNUPROVEEDORVENTAMATERIALES(INSUPPLIER IN NUMBER) RETURN number;

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FNUARTISUBLPROV

  Descripcion :  Valida si el ARTICULO a registrar en la venta de FIFAP es del proveedor y esta configurados

                 en una de las sublineas configurados en el forma LDCPSC registrada en al tabal LDC_PROVSINCODE.

  Autor       :  Jorge Valiente

  Fecha       :  06-01-2017



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FNUARTISUBLPROV(INSUPPLIER IN NUMBER, INARTICLE IN NUMBER)

   RETURN number;

  --Fin 200-468

  --Inicio CASO 200-750
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  FNUVALIDADIRECCION
  Descripcion :  Valida si la direccion no se encuetra condifurada en un paremtro
                 EN CASO DE EXISTIR EN EL PAREMTRO EL CODIGO DE ESTA DIRECCION.
  Autor       :  Jorge Valiente
  Fecha       :  11-04-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/

  FUNCTION FNUVALIDADIRECCION(NUADDRESS_ID AB_ADDRESS.ADDRESS_ID%TYPE)
    RETURN number;
  --Fin CASO 200-750

  --Inicic CASO 200-755
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : ldc_fnucupomanual
  Descripcion : Funcion que retona (1) --> Para los contratos que tienen cupo manual
                o (0) --> Para aquellos que NO.
  Autor       : Jorge Valiente
  Fecha       : 12-04-2017

  ---------------------
  ***Variables de Entrada***
  v_subscription_id -- Ingresa el codigo del contrato a consultar.
  ***Variables de Salida***
  v_cupomanual -- Regresa 1(Si el contrato tiene cupo manual) o 0 (En caso conctrario)

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FNUCUPOMANUAL(v_subscription_id ld_manual_quota.subscription_id%TYPE)
    RETURN NUMBER;
  --Fin CASO 200-755

End LDC_PKVENTAFNB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_PKVENTAFNB AS

  --INICIO CA 200-85

  /*****************************************************************

  Propiedad intelectual de GDO (c).



  Unidad         : LDC_PRGETINFOCODEUDOR

  Descripcion    : Funci?n para consultar la identificacion nueva y anterior.

  Autor          : Jorge Valiente

  Fecha          : 17/02/2016



  Parametros              Descripcion

  ============         ===================



  Fecha             Autor                Modificacion

  =========       =========             ====================

  ******************************************************************/

  PROCEDURE LDC_PRGETINFOCODEUDOR(isbIdentification_old in ge_subscriber.identification%type,

                                  isbIdentification_new in ge_subscriber.identification%type,

                                  onuSubscriberId_old out ge_subscriber.subscriber_id%type,

                                  onuSubscriberId_new out ge_subscriber.subscriber_id%type,

                                  onuCodigoError out number,

                                  osbMensajeError out varchar2) is

    CURSOR CUGE_SUBSCRIBEROLD is

      select *

        from GE_SUBSCRIBER t

       WHERE T.IDENTIFICATION = isbIdentification_old;

    rgGE_SUBSCRIBEROLD CUGE_SUBSCRIBEROLD%rowtype;

    CURSOR CUGE_SUBSCRIBERNEW is

      select *

        from GE_SUBSCRIBER t

       WHERE T.IDENTIFICATION = isbIdentification_new;

    rgGE_SUBSCRIBERNEW CUGE_SUBSCRIBERNEW%rowtype;

    sbVAL_IDE_COD_FIFAP ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('VAL_IDE_COD_FIFAP',

                                                                                          null);

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTAFNB.LDC_PRGETINFOCODEUDOR', 10);

    onuSubscriberId_old := 0;

    onuSubscriberId_new := 0;

    onuCodigoError := 0;

    osbMensajeError := 'OK';

    if nvl(sbVAL_IDE_COD_FIFAP, 'N') = 'S' then

      --

      open CUGE_SUBSCRIBEROLD;

      fetch CUGE_SUBSCRIBEROLD

        into rgGE_SUBSCRIBEROLD;

      if CUGE_SUBSCRIBEROLD%found then

        onuSubscriberId_old := rgGE_SUBSCRIBEROLD.Subscriber_Id;

        --

        open CUGE_SUBSCRIBERNEW;

        fetch CUGE_SUBSCRIBERNEW

          into rgGE_SUBSCRIBERNEW;

        if CUGE_SUBSCRIBERNEW%found then

          onuSubscriberId_new := rgGE_SUBSCRIBERNEW.Subscriber_Id;

          onuCodigoError := -1;

          osbMensajeError := 'La nueva identificacion ya existe en OSF';

        ELSE

          onuSubscriberId_new := 0;

          onuCodigoError := 0;

          osbMensajeError := 'OK';

        end if;

        close CUGE_SUBSCRIBERNEW;

        --

      else

        onuCodigoError := -1;

        osbMensajeError := 'El DEUDOR no tiene codigo de cliente';

      end if;

      close CUGE_SUBSCRIBEROLD;

    end if; --fin validacion sbVAL_IDE_COD_FIFAP

    ut_trace.trace('FIN LDC_PKVENTAFNB.LDC_PRGETINFOCODEUDOR', 10);

  END LDC_PRGETINFOCODEUDOR;

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  fblValidCanFact

  Descripcion :  Valida si el contrato cumple con el numero de facturas minimas

                 para permitir la venta en FIFAP.

  Autor       :  Jorge Valiente

  Fecha       :  13-07-2015



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================
  12/Abril/2017   Jorge Valiente           CASO 200-882: * Manejo de codigo de tipo de producto
                                                         mediante un parametro para identificar
                                                         m?s de un servicio en las cuenta de cobro
                                                         de las facturas del suscriptor
                                                         * Se debe aprovechara este caso para corregir
                                                         el condicional de > a >= en la parte del COUNT.
                                                         Solicitado por el Funcional y N1 en el documento
                                                         del CASO.
  **************************************************************************/

  FUNCTION fblValidCanFact(inuSubscription in suscripc.susccodi%type)

   RETURN BOOLEAN

   IS

    nuContFact number := 0;

    nuMinFact number := dald_parameter.fnuGetNumeric_Value('FACT_MIN_VENTAFNB',

                                                           0);

    nuProdGas number := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',

                                                           0);

    nuMesValFact number := nvl(dald_parameter.fnuGetNumeric_Value('NUM_MESES_VAFA_FNB'),

                               0);

    blResult boolean := false;

    --Obtiene el numero de facturas

    cursor cuObtNumFact is

      SELECT COUNT(*)

        FROM cuencobr c, factura f

       WHERE f.factsusc = inuSubscription

         AND c.cucofact = f.factcodi

         AND C.CUCONUSE = (SELECT sesunuse

                             FROM servsusc s

                            WHERE s.sesususc = inuSubscription

                                 --Inicio CASO 200-882
                                 --AND sesuserv = nuProdGas
                              AND sesuserv IN
                                  (select to_number(column_value)
                                     from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TIP_SER_CAN_FAC_MIN_FIFAP',
                                                                                                              NULL),

                                                                             ',')))
                                 --Fin CASO 200-882

                              AND rownum = 1)

         AND abs(months_between(F.FACTFEGE, ut_date.fdtsysdate)) <=

             nuMesValFact

         AND trunc(c.cucofeve) < trunc(ut_date.fdtsysdate) having

       COUNT(*) >= nuMinFact;

    --AND ROWNUM >= nuMinFact;

    sbFNB_BR_JLVM_CA_200_85 CONSTANT varchar2(100) := 'FNB_BR_JLVM_CA_200_85';

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTAFNB.fblValidCanFact', 10);

    -- Se verifica si la entrega aplica o no

    --If fblAplicaEntrega('FNB_BR_JLVM_200_85_4') Then

    IF LDC_CONFIGURACIONRQ.aplicaParaGDC(sbFNB_BR_JLVM_CA_200_85) or

       LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbFNB_BR_JLVM_CA_200_85) then

      open cuObtNumFact;

      fetch cuObtNumFact

        into nuContFact;

      close cuObtNumFact;

      if nvl(nuContFact, 0) >= nuMinFact then

        blResult := true;

      else

        blResult := false;

      end if;

    else

      blResult := true;

    end if;

    ut_trace.trace('FIN LDC_PKVENTAFNB.fblValidCanFact', 10);

    return blResult;

  EXCEPTION

    when ex.CONTROLLED_ERROR then

      raise;

    when others then

      Errors.setError;

      raise ex.CONTROLLED_ERROR;

  END fblValidCanFact;

  --FIN CA 200-85

  --INICIO 200-310

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FNUCANTVENTSINCANC

  Descripcion :  Valida si el CODEUDOR esta asociado a solicitudes de ventas FNB aun activas.

                 Es decir aun no an terminado de ser canceladas por el DEUDOR en FIFAP.

  Autor       :  Jorge Valiente

  Fecha       :  21-10-2016



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FNUCANTVENTSINCANC(inuIdentTypeCodeudor in ldc_codeudor.iden_type_codeudor%type,

                              inuIdentCodeudor in ldc_codeudor.iden_codeudor%type)

   RETURN number

   IS

    --Obtiene las ventas avaladas por el CODEUDOR

    cursor cuventasfnb is

      select LP.PACKAGE_ID SOLICITUD,

             NVL(DAMO_PACKAGES.FNUGETMOTIVE_STATUS_ID(LP.PACKAGE_ID, NULL),

                 0) ESTADO_SOLICITUD,

             DAMO_PACKAGES.Fdtgetattention_Date(LP.PACKAGE_ID, NULL) FECHA_ATENCION

        from LD_PROMISSORY lp

       where lp.ident_type_id = inuIdentTypeCodeudor

         and lp.identification = inuIdentCodeudor

         AND UPPER(LP.PROMISSORY_TYPE) = 'C'

       order by DAMO_PACKAGES.Fdtgetattention_Date(LP.PACKAGE_ID, NULL) desc;

    rfcuventasfnb cuventasfnb%rowtype;

    --Obtiene lso DIFESAPE de las ventas atendidas para valida si aun tiene Saldo Pendiente een el diferido

    --por solciitud de la funcionaria Julia gonzalez se validaran todas la ventas avaldas pro el CODEUDOR

    cursor cudifesape(inuventa number) is

      select df.difecodi, df.difesape

        from or_order_Activity oa,

             OPEN.LD_ITEM_WORK_ORDER MDF,

             OPEN.DIFERIDO DF

       where oa.package_id = inuventa

         AND MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID

         and DF.DIFECODI = MDF.DIFECODI;

    rfcudifesape cudifesape%rowtype;

    --obtener el total de caos de CUCOSACU

    cursor cucucosacu(inudiferido number) is

      select sum(nvl(cc.cucosacu, 0)) total

        from cargos c, cuencobr cc

       where c.cargdoso like 'DF-' || inudiferido

         and cc.cucocodi = c.cargcuco;

    rfcucucosacu cucucosacu%rowtype;

    nucantidad number;

    nuvalorretornar number := 0;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTAFNB.FNUCANTVENTSINCANC', 10);

    ut_trace.trace('Parametro CANT_VENT_AVAL_CODE_FIFAP[' ||

                   nvl(dald_parameter.fnuGetNumeric_Value('CANT_VENT_AVAL_CODE_FIFAP',

                                                          null),

                       0) || ']',

                   10);

    --si el paremtro es 0 o NULL no se realiza la validacion de ventas avaladas por el CODEUDOR

    if nvl(dald_parameter.fnuGetNumeric_Value('CANT_VENT_AVAL_CODE_FIFAP',

                                              null),

           0) > 0 then

      nucantidad := 0;

      for rfcuventasfnb in cuventasfnb loop

        ut_trace.trace('******Solicitud[' || rfcuventasfnb.SOLICITUD || ']',

                       10);

        if rfcuventasfnb.estado_solicitud = 13 and nuvalorretornar = 0 then

          nucantidad := nucantidad + 1;

        elsif rfcuventasfnb.estado_solicitud = 14 and nuvalorretornar = 0 then

          --ciclo para confirmar que su saldo diferido esta en 0

          for rfcudifesape in cudifesape(rfcuventasfnb.solicitud) loop

            if nvl(rfcudifesape.difesape, 0) > 0 then

              nucantidad := nucantidad + 1;

              ut_trace.trace('************DIFERIDO[' ||

                             rfcudifesape.difecodi ||

                             '] - Total DIFESAPE[' ||

                             rfcudifesape.difesape || ']',

                             10);

            else

              --validar que la saldo de la cuenta de cobro ascoiada al diferido sea 0

              open cucucosacu(rfcudifesape.difecodi);

              fetch cucucosacu

                into rfcucucosacu;

              close cucucosacu;

              if nvl(rfcucucosacu.total, 0) > 0 then

                nucantidad := nucantidad + 1;

                ut_trace.trace('************DIFERIDO[' ||

                               rfcudifesape.difecodi ||

                               '] - Total CUCOSACU[' || rfcucucosacu.total || ']',

                               10);

              end if;

            end if;

          end loop;

        end if;

        if nucantidad >=

           dald_parameter.fnuGetNumeric_Value('CANT_VENT_AVAL_CODE_FIFAP',

                                              null) THEN

          nuvalorretornar := 2;

        end if;

      end loop;

    end if;

    ut_trace.trace('FIN LDC_PKVENTAFNB.FNUCANTVENTSINCANC', 10);

    return nuvalorretornar;

  EXCEPTION

    when ex.CONTROLLED_ERROR then

      raise;

    when others then

      Errors.setError;

      raise ex.CONTROLLED_ERROR;

  END FNUCANTVENTSINCANC;

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FRTDATOSGENERALES

  Descripcion :  Retorna los datos GENERALES para mostrar en LDCIF.

  Autor       :  Jorge Valiente

  Fecha       :  21-10-2016



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FRTDATOSGENERALES(inufindvalue in ld_non_ban_fi_item.NON_BA_FI_REQU_ID%type)

   RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTAFNB.FRTCODEUDORACTUALIZADO', 10);

    open rfQuery for

      select (select nvl(l.new_name, l.old_name) || ' ' ||

                     nvl(l.new_lastname, l.old_lastname)

                from ldc_Datos_actualizar l

               where l.tipo_cambio = 'Nombre y/o ID'

                 and l.package_id = inufindvalue

                 and rownum = 1) Nombre,

             --identificacion

             (select nvl(l.new_ident, l.old_ident)

                from ldc_Datos_actualizar l

               where l.tipo_cambio = 'Nombre y/o ID'

                 and l.package_id = inufindvalue

                 and rownum = 1) ident,

             --cuota extra usada

             (select nvl(LNBFR.USED_EXTRA_QUOTE, 0)

                from LD_NON_BA_FI_REQU LNBFR

               where LNBFR.NON_BA_FI_REQU_ID = inufindvalue

                 and rownum = 1) USED_EXTRA_QUOTE,

             --cuota manual usada

             (select nvl(LNBFR.MANUAL_QUOTA_USED, 0)

                from LD_NON_BA_FI_REQU LNBFR

               where LNBFR.NON_BA_FI_REQU_ID = inufindvalue

                 and rownum = 1) MANUAL_QUOTA_USED,

             --deudor solidario

             (select nvl(lp.solidarity_debtor, 'N')

                from ld_promissory lp

               where lp.package_id = inufindvalue

                 and lp.promissory_type = 'C'

                 and rownum = 1) solidarity_debtor,

             --causal de deudor solidario

             (select (SELECT gc.causal_id || ' - ' || gc.description

                        FROM ge_causal gc

                       WHERE gc.causal_type_id =

                             dald_parameter.fnuGetNumeric_Value('FNB_CAUSAL_DEUDOR_SOL')

                         and gc.causal_id = lp.causal_id

                         and rownum = 1)

                from ld_promissory lp

               where lp.package_id = inufindvalue

                 and lp.promissory_type = 'C'

                 and rownum = 1) causal_id

        from dual;

    /*select nvl(l.new_name, l.old_name) || ' ' ||

          nvl(l.new_lastname, l.old_lastname) Nombre,

          nvl(l.new_ident, l.old_ident) ident,

          nvl(LNBFR.USED_EXTRA_QUOTE, 0) USED_EXTRA_QUOTE,

          nvl(LNBFR.MANUAL_QUOTA_USED, 0) MANUAL_QUOTA_USED,

          nvl(lp.solidarity_debtor, 'N') solidarity_debtor,

          --nvl(lp.causal_id,0) causal_id

          (SELECT gc.causal_id || ' - ' || gc.description

             FROM ge_causal gc

            WHERE gc.causal_type_id =

                  dald_parameter.fnuGetNumeric_Value('FNB_CAUSAL_DEUDOR_SOL')

              and gc.causal_id = lp.causal_id

              and rownum = 1) causal_id

     from ldc_Datos_actualizar l,

          LD_NON_BA_FI_REQU    LNBFR,

          ld_promissory        lp

    where l.tipo_cambio = 'Nombre y/o ID'

      and l.package_id = inufindvalue

      and LNBFR.NON_BA_FI_REQU_ID = l.package_id

      and l.package_id = lp.package_id

      and rownum = 1;*/

    /*

    select nvl(l.new_name, l.old_name) || ' ' ||

           nvl(l.new_lastname, l.old_lastname) Nombre,

           nvl(l.new_ident, l.old_ident) ident

      from ldc_Datos_actualizar l

     where l.tipo_cambio = 'Nombre y/o ID'

       and l.package_id = inufindvalue;

     */

    ut_trace.trace('FIN LDC_PKVENTAFNB.FRTCODEUDORACTUALIZADO', 10);

    return(rfQuery);

  EXCEPTION

    when ex.CONTROLLED_ERROR then

      raise;

    when others then

      Errors.setError;

      raise ex.CONTROLLED_ERROR;

  END FRTDATOSGENERALES;

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FNUCANTVENTCONTDEUD

  Descripcion :  Valida la cantidad de CONTRATOS en FIFAP en los que el suscriptor puede

                 ser ?Es Titular de la Factura? y Validar la cantidad de ventas autorizadas en FIFAP

  Autor       :  Jorge Valiente

  Fecha       :  22-10-2016



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FNUCANTVENTCONTDEUD(inuIdentTypeCodeudor in ldc_codeudor.iden_type_codeudor%type,

                               inuIdentCodeudor in ldc_codeudor.iden_codeudor%type)

   RETURN number

   IS

    --Obtiene las ventas avaladas por el CODEUDOR

    cursor cuventasfnb is

      select LP.PACKAGE_ID SOLICITUD,

             NVL(DAMO_PACKAGES.FNUGETMOTIVE_STATUS_ID(LP.PACKAGE_ID, NULL),

                 0) ESTADO_SOLICITUD,

             DAMO_PACKAGES.Fdtgetattention_Date(LP.PACKAGE_ID, NULL) FECHA_ATENCION

        from LD_PROMISSORY lp

       where lp.ident_type_id = inuIdentTypeCodeudor

         and lp.identification = inuIdentCodeudor

         AND UPPER(LP.PROMISSORY_TYPE) = 'C'

       order by DAMO_PACKAGES.Fdtgetattention_Date(LP.PACKAGE_ID, NULL) desc;

    rfcuventasfnb cuventasfnb%rowtype;

    --Obtiene lso DIFESAPE de las ventas atendidas para valida si aun tiene Saldo Pendiente een el diferido

    --por solciitud de la funcionaria Julia gonzalez se validaran todas la ventas avaldas pro el CODEUDOR

    cursor cudifesape(inuventa number) is

      select df.difecodi, df.difesape

        from or_order_Activity oa,

             OPEN.LD_ITEM_WORK_ORDER MDF,

             OPEN.DIFERIDO DF

       where oa.package_id = inuventa

         AND MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID

         and DF.DIFECODI = MDF.DIFECODI;

    rfcudifesape cudifesape%rowtype;

    --obtener el total de caos de CUCOSACU

    cursor cucucosacu(inudiferido number) is

      select sum(nvl(cc.cucosacu, 0)) total

        from cargos c, cuencobr cc

       where c.cargdoso like 'DF-' || inudiferido

         and cc.cucocodi = c.cargcuco;

    rfcucucosacu cucucosacu%rowtype;

    nucantidad number;

    nuvalorretornar number := 0;

    nuvalorventa number;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTAFNB.FNUCANTVENTCONTDEUD', 10);

    ut_trace.trace('Parametro CANT_VENT_AVAL_CODE_FIFAP[' ||

                   nvl(dald_parameter.fnuGetNumeric_Value('CANT_VENT_AVAL_CODE_FIFAP',

                                                          null),

                       0) || ']',

                   10);

    --si el paremtro es 0 o NULL no se realiza la validacion de ventas avaladas por el CODEUDOR

    if nvl(dald_parameter.fnuGetNumeric_Value('CANT_VENT_AVAL_CODE_FIFAP',

                                              null),

           0) > 0 then

      nucantidad := 0;

      for rfcuventasfnb in cuventasfnb loop

        ut_trace.trace('******Solicitud[' || rfcuventasfnb.SOLICITUD || ']',

                       10);

        nuvalorventa := 0;

        if rfcuventasfnb.estado_solicitud = 13 and nuvalorretornar = 0 then

          nucantidad := nucantidad + 1;

        elsif rfcuventasfnb.estado_solicitud = 14 and nuvalorretornar = 0 then

          --ciclo para confirmar que su saldo diferido esta en 0

          for rfcudifesape in cudifesape(rfcuventasfnb.solicitud) loop

            if nvl(rfcudifesape.difesape, 0) > 0 then

              nuvalorventa := nuvalorventa + rfcudifesape.difesape;

              --nucantidad := nucantidad + 1;

              ut_trace.trace('************DIFERIDO[' ||

                             rfcudifesape.difecodi ||

                             '] - Total DIFESAPE[' ||

                             rfcudifesape.difesape || ']',

                             10);

            else

              --validar que la saldo de la cuenta de cobro ascoiada al diferido sea 0

              open cucucosacu(rfcudifesape.difecodi);

              fetch cucucosacu

                into rfcucucosacu;

              close cucucosacu;

              if nvl(rfcucucosacu.total, 0) > 0 then

                nuvalorventa := nuvalorventa + rfcucucosacu.total;

                --nucantidad := nucantidad + 1;

                ut_trace.trace('************DIFERIDO[' ||

                               rfcudifesape.difecodi ||

                               '] - Total CUCOSACU[' || rfcucucosacu.total || ']',

                               10);

              end if;

            end if;

          end loop;

        end if;

        if nuvalorventa > 0 then

          nucantidad := nucantidad + 1;

        end if;

        if nucantidad >=

           dald_parameter.fnuGetNumeric_Value('CANT_VENT_AVAL_CODE_FIFAP',

                                              null) THEN

          nuvalorretornar := 2;

        end if;

      end loop;

    end if;

    ut_trace.trace('FIN LDC_PKVENTAFNB.FNUCANTVENTCONTDEUD', 10);

    return nuvalorretornar;

  EXCEPTION

    when ex.CONTROLLED_ERROR then

      raise;

    when others then

      Errors.setError;

      raise ex.CONTROLLED_ERROR;

  END FNUCANTVENTCONTDEUD;

  --FIN 200-310

  --Inicio 200-468

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FNUPROVEEDORVENTAMATERIALES

  Descripcion :  Valida si el PROVEEDOR puede realizar venta de materiales sin CODEUDOR en FIFAP

                 mediante la configuracion registrada en al tabal LDC_PROVSINCODE.

  Autor       :  Jorge Valiente

  Fecha       :  05-01-2017



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FNUPROVEEDORVENTAMATERIALES(INSUPPLIER IN NUMBER) RETURN number

   IS

    nuvalorretornar number := 0;

    --cursor

    cursor cuPROVSINCODE is

      select count(t.supplier_id) cantidad

        from LDC_PROVSINCODE t

       where t.supplier_id = INSUPPLIER;

    rfcuPROVSINCODE cuPROVSINCODE%rowtype;

    --cursor

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTAFNB.FNUPROVEEDORVENTAMATERIALES', 10);

    open cuPROVSINCODE;

    fetch cuPROVSINCODE

      into rfcuPROVSINCODE;

    close cuPROVSINCODE;

    if nvl(rfcuPROVSINCODE.Cantidad, 0) > 0 then

      nuvalorretornar := 1;

    end if;

    ut_trace.trace('FIN LDC_PKVENTAFNB.FNUPROVEEDORVENTAMATERIALES', 10);

    return nuvalorretornar;

  EXCEPTION

    when ex.CONTROLLED_ERROR then

      return 0;

    --raise;

    when others then

      return 0;

    --Errors.setError;

    --raise ex.CONTROLLED_ERROR;

  END FNUPROVEEDORVENTAMATERIALES;

  /**************************************************************************

  Propiedad Intelectual de PETI

  Funcion     :  FNUARTISUBLPROV

  Descripcion :  Valida si el ARTICULO a registrar en la venta de FIFAP es del proveedor y esta configurados

                 en una de las sublineas configurados en el forma LDCPSC registrada en al tabal LDC_PROVSINCODE.

  Autor       :  Jorge Valiente

  Fecha       :  06-01-2017



  Historia de Modificaciones

    Fecha          Autor                   Modificacion

  =========       =========                ====================

  **************************************************************************/

  FUNCTION FNUARTISUBLPROV(INSUPPLIER IN NUMBER, INARTICLE IN NUMBER)

   RETURN number

   IS

    nuvalorretornar number := 0;

    --cursor

    cursor cuARTICLE is

      select count(la.subline_id) cantidad

        from ld_article la, LDC_PROVSINCODE lp

       where la.SUPPLIER_ID = INSUPPLIER

         and la.article_id = INARTICLE

         and la.subline_id = lp.subline_id

         and la.supplier_id = lp.supplier_id;

    rfcuARTICLE cuARTICLE%rowtype;

    --cursor

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTAFNB.FNUARTISUBLPROV', 10);

    open cuARTICLE;

    fetch cuARTICLE

      into rfcuARTICLE;

    close cuARTICLE;

    if nvl(rfcuARTICLE.Cantidad, 0) > 0 then

      nuvalorretornar := 1;

    end if;

    ut_trace.trace('Valor retornado[' || nuvalorretornar || ']', 10);

    ut_trace.trace('FIN LDC_PKVENTAFNB.FNUARTISUBLPROV', 10);

    return nuvalorretornar;

  EXCEPTION

    when ex.CONTROLLED_ERROR then

      return 0;

    --raise;

    when others then

      return 0;

    --Errors.setError;

    --raise ex.CONTROLLED_ERROR;

  END FNUARTISUBLPROV;

  --Fin 200-468

  --Inicio CASO 200-750
  /**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  FNUVALIDADIRECCION
  Descripcion :  Valida si la direccion no se encuetra condifurada en un paremtro
                 EN CASO DE EXISTIR EN EL PAREMTRO EL CODIGO DE ESTA DIRECCION.
  Autor       :  Jorge Valiente
  Fecha       :  11-04-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/

  FUNCTION FNUVALIDADIRECCION(NUADDRESS_ID AB_ADDRESS.ADDRESS_ID%TYPE)
    RETURN number IS
    nuvalorretornar number := 0;
    --cursor

    cursor cuEXISTE is
      SELECT count(1) cantidad
        FROM DUAL
       WHERE NUADDRESS_ID IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_DIR_INV_FIFAP',
                                                                                         NULL),
                                                        ',')));
    RFcuEXISTE cuEXISTE%rowtype;
    --cursor
  BEGIN
    ut_trace.trace('INICIO LDC_PKVENTAFNB.FNUVALIDADIRECCION', 10);
    open cuEXISTE;
    fetch cuEXISTE
      into RFcuEXISTE;
    close cuEXISTE;
    if nvl(RFcuEXISTE.Cantidad, 0) > 0 then
      nuvalorretornar := 1;
    end if;
    ut_trace.trace('FIN LDC_PKVENTAFNB.FNUVALIDADIRECCION', 10);
    return nuvalorretornar;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      return 0;
      --raise;
    when others then
      return 0;
      --Errors.setError;
    --raise ex.CONTROLLED_ERROR;
  END FNUVALIDADIRECCION;
  --Fin CASO 200-750

  --Inicic CASO 200-755
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : ldc_fnucupomanual
  Descripcion : Funcion que retona (1) --> Para los contratos que tienen cupo manual
                o (0) --> Para aquellos que NO.
  Autor       : Jorge Valiente
  Fecha       : 12-04-2017

  ---------------------
  ***Variables de Entrada***
  v_subscription_id -- Ingresa el codigo del contrato a consultar.
  ***Variables de Salida***
  v_cupomanual -- Regresa 1(Si el contrato tiene cupo manual) o 0 (En caso conctrario)

  ---------------------
  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  FUNCTION FNUCUPOMANUAL(v_subscription_id ld_manual_quota.subscription_id%TYPE)
    RETURN NUMBER IS
    v_cupomanual         NUMBER; -- Variable de Retorno
    vt_subscription_id   NUMBER; -- Varibale temporal para almacenar el resultado de la consulta 1 .
    vt_subscription_id_2 NUMBER; -- Varibale temporal para almacenar el resultado de la consulta 2.
  BEGIN
    BEGIN

      ut_trace.trace('INICIO LDC_PKVENTAFNB.FNUCUPOMANUAL', 10);

      /*Consulto si el (subscription_id) ingresado se encuentra en la tabla (ld_manual_quota)
      luego lo almaceno en la variable temporal (vt_subscription_id)*/
      SELECT subscription_id
        INTO vt_subscription_id
        FROM ld_manual_quota
       WHERE final_date > = sysdate
         AND subscription_id = v_subscription_id;
      /*Comparo si el (subscription_id) ingresado es igual al obtenido (vt_subscription_id)
      Si es (SI) ->
      Procedo a consultar si el (subscription_id) existe en la tabla (ld_quota_historic)
      y su observacion contenga ("Asignacion de cupo de manual")
      Si es (NO) ->
      Le asigno a la variable de retorno el valor de (0) indicando que NO se han cumplido las condiciones
      y el (subscription_id) NO TIENE "Cupo Manual" */
      IF vt_subscription_id = v_subscription_id THEN
        SELECT subscription_id
          INTO vt_subscription_id_2
          FROM (SELECT *
                  FROM ld_quota_historic
                 WHERE observation like '%Asignacion de cupo de manual%'
                   AND subscription_id = v_subscription_id
                 ORDER BY quota_historic_id DESC)
         WHERE ROWNUM <= 1;
        /*Comparo si el (subscription_id) ingresado es igual al obtenido en la consulta 2 (vt_subscription_id_2)
        Si es (SI) ->
        Le asigno a la variable de retorno el valor de (1) indicando que SI se han cumplido las condiciones
        y el (subscription_id) SI TIENE "Cupo Manual"
        Si es (NO) ->
        Le asigno a la variable de retorno el valor de (0) */
        IF vt_subscription_id_2 = v_subscription_id THEN
          -- Inicio segunda condicion
          v_cupomanual := 1;
        ELSE
          v_cupomanual := 0; -- SiNo segunda condicion
        END IF; -- Fin segunda condicion
      ELSE
        v_cupomanual := 0; -- SiNo Primera condicion.
      END IF; -- Fin Primera condicion.
      /*EXCEPTION ->
      En caso de que no se encuentren registros se retornara el valor de (0)
      Indicando que el contrato ingresado no tiene cupo manual*/
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_cupomanual := 0;
    END;

    ut_trace.trace('FIN LDC_PKVENTAFNB.FNUCUPOMANUAL', 10);

    --Retorno la Variable.
    RETURN v_cupomanual;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN - 1;
  END fnucupomanual;
  --Fin CASO 200-755

END LDC_PKVENTAFNB;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKVENTAFNB', 'ADM_PERSON'); 
END;
/
GRANT EXECUTE on ADM_PERSON.LDC_PKVENTAFNB to REXEREPORTES;
/