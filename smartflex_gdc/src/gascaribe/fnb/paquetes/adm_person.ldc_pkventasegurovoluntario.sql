CREATE OR REPLACE PACKAGE  ADM_PERSON.LDC_PKVENTASEGUROVOLUNTARIO is
  TYPE tyRefCursor IS REF CURSOR;

  /**************************************************************************
  Funcion     :  FNUSEGUROVOLUNTARIO
  Descripcion :  Retorna un valor indicado si el articulo esta configurado
                 en al forma LDCPTSV como seguro de venta voluntario
                 0 - FALLO que NO existe este articulo como seguro voluntaio
                 1 - EXITO que existe este articulo como seguro voluntaio
  Autor       :  Jorge Valiente
  Fecha       :  08-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  18/02/2020    Innovacion         CA-325 --> Se modifican los metodos PRREGISTROVENTASEGURO
  **************************************************************************/
  FUNCTION FNUSEGUROVOLUNTARIO(InuArticulo in number) return number;

  /**************************************************************************
  Funcion     :  FNUEXISTESEGUROVOLUNTARIO
  Descripcion :  Valida si el serguro voluntario ya lo tiene relacionado el
                 suscriptor en otra venta BRILLA
  Autor       :  Jorge Valiente
  Fecha       :  09-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUEXISTESEGUROVOLUNTARIO(InuSUSCCODI NUMBER) RETURN NUMBER;

  /**************************************************************************
  Funcion     :  FNUTARIFASEGUROVOLUNTARIO
  Descripcion :  Retorna el valor de tarifa relacionada con el seguro voluntario
                 seleccionado en la venta de articulo BRILLA
  Autor       :  Jorge Valiente
  Fecha       :  09-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRREGISTROSEGUROVOLUNTARIO(InuSUSCCODI   NUMBER,
                                       InuPACKAGE_ID NUMBER);

  /**************************************************************************
  Funcion     :  PRREGISTROVENTASEGURO
  Descripcion :  Registra el artiuclo vendido en FIFAP de seguro voluntario
  Autor       :  Jorge Valiente
  Fecha       :  16-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRREGISTROVENTASEGURO(InuPACKAGE_ID NUMBER);

  /**************************************************************************
  Funcion     :  FNUEDADVALIDASEGURO
  Descripcion :  Retorna un valor indicado si la edad del deudor es valida para
                 obtener el seguro
                 0 - FALLO que NO es valido para utilizar el seguro
                 1 - EXITO que es valido para utilizar el seguro
  Autor       :  Jorge Valiente
  Fecha       :  22-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUEDADVALIDASEGURO(yearsDeudorSeguro in varchar2) RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROGENOTANULASEGUROVOLUNTARIO
  Descripcion    : Procedimiento para la generacion de la orden de anulacion
                   del seguro voluntario en un venta FIFAP.
  Autor          : Jorge Valiente
  Fecha          : 26/05/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  09/11/2016  KBaquero C200-854    Creacion
  ******************************************************************/

  PROCEDURE PROGENOTANULASEGUROVOLUNTARIO(inuPackage in OPEN.mo_packages.package_id%type);

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROESTADOSEGUROVOLUNTARIO
  Descripcion    : Procedimiento para realizar el cambio de estado del
                   seguro voluntario en un venta FIFAP.
  Autor          : Jorge Valiente
  Fecha          : 30/05/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  ******************************************************************/

  PROCEDURE PROESTADOSEGUROVOLUNTARIO;

  /**************************************************************************
  Funcion     :  FNUDIFERIDOSEGURO
  Descripcion :  Retorna el diferido asociado a un seguro voluntario relacionado a una
                 venta en FIFAP
                 0 - FALLO que NO existe defido asociado
  Autor       :  Jorge Valiente
  Fecha       :  31-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUDIFERIDOSEGURO(nuSolicitudVenta in number,
                             nuarticle_id     in number) RETURN NUMBER;

  /**************************************************************************
  Funcion     :  FNUDIFERIDOSEGURO
  Descripcion :  Valida si la orden desplegada en FLOTE tiene o no un articulo
                 de seguro voluntario en la venta BRILLA
                 0 - La orden NO tiene relacion con articulo de seguro volunatio
                 1 - La orden tiene relacion con articulo de seguro volunatio
  Autor       :  Jorge Valiente
  Fecha       :  07-06-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUORDENSEGUROVOLUNTARIO(nuorder_activity_id in number)
    RETURN NUMBER;

  /**************************************************************************
  Funcion     :  FNUCAUSALANUDEV
  Descripcion :  Valida si la causal es para identificar las ordenes de
                 seguro voluntario existentes en FNBCR
                 0 - La causal NO tiene relacion con articulo de seguro volunatio
                 1 - La causal tiene relacion con articulo de seguro volunatio
  Autor       :  Jorge Valiente
  Fecha       :  07-06-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUCAUSALANUDEV(nuCausal in number) RETURN NUMBER;

  /**************************************************************************
  Funcion     :  PRACTUALIZAVENTASEGURO
  Descripcion :  Actualiza estado del artiuclo vendido en FIFAP de seguro voluntario
  Autor       :  Jorge Valiente
  Fecha       :  16-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRACTUALIZAVENTASEGURO(InuPACKAGE_ID NUMBER,
                                   IsbEstado     VARCHAR2,
                                   InuActividad  NUMBER);

  /**************************************************************************
  Funcion     :  FSBSERGUROVOLUNTARIO
  Descripcion :  Servicio para retornar datos relacionados con el articulo
                 de seguro voluntario
  Autor       :  Jorge Valiente
  Fecha       :  19-06-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FSBSERGUROVOLUNTARIO(InuPACKAGE_ID NUMBER) RETURN VARCHAR2;

  ---Inicio CASO 200-1378
  /**************************************************************************
  Funcion     :  FNUDIFERIDOANUDEV
  Descripcion :  Retorna el diferido asociado al artiuclo relacionado a una
                 venta en FIFAP anulado o devuleto
                 0 - FALLO que NO existe defido asociado
  Autor       :  Jorge Valiente
  Fecha       :  26-07-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUDIFERIDOANUDEV(nuSolicitudVenta in number,
                             nuarticle_id     in number) RETURN NUMBER;

  /**************************************************************************
  Funcion     :  FNUVALORDIFERIDOANUDEV
  Descripcion :  Retorna el valor del diferido asociado al artiuclo relacionado a una
                 venta en FIFAP anulado o devuleto
                 0 - FALLO que NO existe defido asociado
  Autor       :  Jorge Valiente
  Fecha       :  26-07-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUVALORDIFERIDOANUDEV(nuSolicitudVenta in number,
                                  nuarticle_id     in number) RETURN NUMBER;

---Inicio CASO 200-1378

End LDC_PKVENTASEGUROVOLUNTARIO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_PKVENTASEGUROVOLUNTARIO AS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKVENTAPAGOUNICO
  Descripcion    : Paquete para validar la venta de seguro voluntario
  Autor          : Jorge Valiente
  Fecha          : 08/05/2017 CASO 200-1164

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  01/10/2018    Edmundo Lara            Se modifica servicio <<FNUEDADVALIDASEGURO>>
  ******************************************************************/

  /**************************************************************************
  Funcion     :  FNUSEGUROVOLUNTARIO
  Descripcion :  Retorna un valor indicado si el articulo esta configurado
                 en al forma LDCPTSV como seguro de venta voluntario
                 0 - FALLO que NO existe este articulo como seguro voluntaio
                 1 - EXITO que existe este articulo como seguro voluntaio
  Autor       :  Jorge Valiente
  Fecha       :  08-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUSEGUROVOLUNTARIO(InuArticulo in number) RETURN NUMBER

   IS

    nuEXITOFALLO number := 0;

    --VALIDA SI SELECCIONO EL SEGURO VOLUNTARIO
    /*
    cursor culdc_protarsegvol is
      select count(1) cantidad
        from ldc_protarsegvol lptsv
       where lptsv.article_id = inuArticulo;

    rfculdc_protarsegvol culdc_protarsegvol%rowtype;
    */
    CURSOR CUSEGUROVOLUNTARIO IS
      select COUNT(1) CANTIDAD
        from ld_article d
       where D.ARTICLE_ID = InuArticulo
         AND d.concept_id IN
             (select nvl(to_number(column_value), 0)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                         NULL),
                                                        ',')));
    RFCUSEGUROVOLUNTARIO CUSEGUROVOLUNTARIO%ROWTYPE;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUSEGUROVOLUNTARIO',
                   10);

    ut_trace.trace('Articulo[' || inuArticulo || ']', 10);

    open CUSEGUROVOLUNTARIO;
    fetch CUSEGUROVOLUNTARIO
      into RFCUSEGUROVOLUNTARIO;
    if CUSEGUROVOLUNTARIO%found then
      if nvl(RFCUSEGUROVOLUNTARIO.cantidad, 0) > 0 then
        --is not null then
        nuEXITOFALLO := 1;
      else
        nuEXITOFALLO := 0;
      end if;
    else
      nuEXITOFALLO := 0;
    end if;
    close CUSEGUROVOLUNTARIO;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUSEGUROVOLUNTARIO',
                   10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return - 1;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return - 1;
  END FNUSEGUROVOLUNTARIO;

  /**************************************************************************
  Funcion     :  FNUEXISTESEGUROVOLUNTARIO
  Descripcion :  Valida si el serguro voluntario ya lo tiene relacionado el
                 suscriptor en otra venta BRILLA
  Autor       :  Jorge Valiente
  Fecha       :  09-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUEXISTESEGUROVOLUNTARIO(InuSUSCCODI NUMBER) RETURN NUMBER

   IS

    nuExisteSeguro number := 0;

    --Cursor para identificar si tiene algun articulo de seguro voluntario
    --asociado auna venta sin legalizar
    cursor cuValidaExistenciaSeguro is
      SELECT --df.difenuse, df.difecodi, difesape
       count(oa.package_id) Cantidad
        FROM open.mo_packages        p,
             open.or_order           o,
             open.or_order_activity  oa,
             OPEN.LD_ITEM_WORK_ORDER MDF
       where oa.package_id = p.package_id
         and oa.order_id = o.order_id
         and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
         and o.task_type_id = 12590
         AND MDF.state <> 'AN'
         AND (select COUNT(1)
                from ld_article d
               where D.ARTICLE_ID = MDF.ARTICLE_ID
                 AND D.SUPPLIER_ID = MDF.Supplier_Id
                 AND d.concept_id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ',')))) > 0
         and o.order_status_id in (0, 5)
         and oa.subscription_id = InuSUSCCODI;

    rfcuValidaExistenciaSeguro cuValidaExistenciaSeguro%rowtype;

    --Cursor para identificar si el articulo seguro tiene cuentas de cobro pendientes del diferido o el diferido
    cursor cuValidaDiferidoSeguro is
      SELECT COUNT(1) Cart_No_Corriente
        FROM open.mo_packages        p,
             open.or_order           o,
             open.or_order_activity  oa,
             OPEN.LD_ITEM_WORK_ORDER MDF,
             open.diferido           d
       where oa.package_id = p.package_id
         and oa.order_id = o.order_id
         and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
         and o.task_type_id = 12590
         AND MDF.state <> 'AN'
         and (SELECT /*+ index (L PK_LD_ARTICLE IX_LD_ARTICLE_04) */
               count(1)
                FROM LD_ARTICLE L
               WHERE L.Concept_Id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))
                       where l.article_id = MDF.ARTICLE_ID
                         and l.supplier_id = MDF.Supplier_Id)) > 0
         and oa.subscription_id = InuSUSCCODI
         and d.difecodi = mdf.difecodi
         AND D.DIFESAPE > 0;

    /*select difenuse "Producto",
         difecodi "Diferido",
         no_corriente Cart_No_Corriente,
         (pm + d30 + d60 + d90 + d120 + m120) Cart_Corriente,
         (pm + d30 + d60 + d90 + d120 + m120 + no_corriente) Cart_Total
    from (select nvl(difenuse,0) difenuse,
                 nvl(difecodi,0) difecodi,
                 nvl(to_number(OPEN.pkexpreg.fsbObCad(edades, ';', 1)),0) PM,
                 nvl(to_number(OPEN.pkexpreg.fsbObCad(edades, ';', 2)),0) D30,
                 nvl(to_number(OPEN.pkexpreg.fsbObCad(edades, ';', 3)),0) D60,
                 nvl(to_number(OPEN.pkexpreg.fsbObCad(edades, ';', 4)),0) D90,
                 nvl(to_number(OPEN.pkexpreg.fsbObCad(edades, ';', 5)),0) D120,
                 nvl(to_number(OPEN.pkexpreg.fsbObCad(edades, ';', 6)),0) M120,
                 nvl(no_corriente,0) no_corriente
            from (SELECT df.difenuse,
                         df.difecodi,
                         (select pm.holder_bill
                            from open.ld_promissory pm
                           where pm.package_id = p.package_id
                             and rownum = 1) titular,
                         OPEN.fsbEdadCartDiferidos(df.difenuse,
                                                   df.difecodi) edades,
                         difesape no_corriente
                    FROM open.mo_packages        p,
                         open.or_order           o,
                         open.or_order_activity  oa,
                         OPEN.LD_ITEM_WORK_ORDER MDF,
                         OPEN.DIFERIDO           DF
                   where oa.package_id = p.package_id
                     and oa.order_id = o.order_id
                     and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
                     AND DF.DIFECODI = MDF.DIFECODI
                     and o.task_type_id = 12590
                     and o.order_status_id = 8
                        ---
                     and df.difecodi in
                         (SELECT mdf.difecodi
                            FROM open.mo_packages        p,
                                 open.or_order           o,
                                 open.or_order_activity  oa,
                                 OPEN.LD_ITEM_WORK_ORDER MDF,
                                 open.diferido           d
                           where oa.package_id = p.package_id
                             and oa.order_id = o.order_id
                             and MDF.ORDER_ACTIVITY_ID =
                                 OA.ORDER_ACTIVITY_ID
                             and o.task_type_id = 12590
                             AND MDF.state <> 'AN'
                             and (SELECT \*+ index (L PK_LD_ARTICLE IX_LD_ARTICLE_04) *\
                                   count(1)
                                    FROM LD_ARTICLE L
                                   WHERE L.Concept_Id IN
                                         (select nvl(to_number(column_value),
                                                     0)
                                            from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                                     NULL),
                                                                                    ','))
                                           where l.article_id =
                                                 MDF.ARTICLE_ID
                                             and l.supplier_id =
                                                 MDF.Supplier_Id)) > 0
                             and oa.subscription_id = InuSUSCCODI
                             and d.difecodi = mdf.difecodi)
                  -----
                  ));*/

    rfcuValidaDiferidoSeguro cuValidaDiferidoSeguro%rowtype;

    sbsqldiferido varchar2(4000);

  BEGIN

    ut_trace.trace('Contrato[' || InuSUSCCODI || ']', 10);

    open cuValidaExistenciaSeguro;
    fetch cuValidaExistenciaSeguro
      into rfcuValidaExistenciaSeguro;
    if cuValidaExistenciaSeguro%found then
      if nvl(rfcuValidaExistenciaSeguro.Cantidad, 0) > 0 then
        --is not null then
        nuExisteSeguro := 1;
      end if;
    end if;
    close cuValidaExistenciaSeguro;

    open cuValidaDiferidoSeguro;
    fetch cuValidaDiferidoSeguro
      into rfcuValidaDiferidoSeguro;
    if cuValidaDiferidoSeguro%found then
      if nvl(rfcuValidaDiferidoSeguro.Cart_No_Corriente, 0) > 0 then
        --is not null then
        nuExisteSeguro := 2;
      end if;
    end if;
    close cuValidaDiferidoSeguro;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUEXISTESEGUROVOLUNTARIO',
                   10);

    return nuExisteSeguro;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return - 1;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return - 1;
  END FNUEXISTESEGUROVOLUNTARIO;

  /**************************************************************************
  Funcion     :  FNUTARIFASEGUROVOLUNTARIO
  Descripcion :  Retorna el valor de tarifa relacionada con el seguro voluntario
                 seleccionado en la venta de articulo BRILLA
  Autor       :  Jorge Valiente
  Fecha       :  09-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRREGISTROSEGUROVOLUNTARIO(InuSUSCCODI   NUMBER,
                                       InuPACKAGE_ID NUMBER) IS

    cursor cuexisteventaarticulo is
      SELECT MDF.*, o.operating_unit_id Asesor_Venta
        FROM open.or_order           o,
             open.or_order_activity  oa,
             OPEN.LD_ITEM_WORK_ORDER MDF,
             OPEN.DIFERIDO           DF
       where oa.package_id = InuPACKAGE_ID
         and oa.order_id = o.order_id
         and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
         AND DF.DIFECODI = MDF.DIFECODI
         and o.task_type_id = 12590
         and MDF.Article_Id in
             (SELECT l.article_id
                FROM LD_ARTICLE L
               WHERE L.Concept_Id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))));

    rfcuexisteventaarticulo cuexisteventaarticulo%rowtype;

    cursor cudatosventa is
      SELECT *
        FROM LD_NON_BA_FI_REQU L, LD_PROMISSORY LP
       WHERE L.NON_BA_FI_REQU_ID = InuPACKAGE_ID
         AND LP.PACKAGE_ID = L.NON_BA_FI_REQU_ID
         AND LP.PROMISSORY_TYPE = 'D';

    rfcudatosventa cudatosventa%ROWTYPE;

    cursor cucontrato is
      select * from suscripc s where s.susccodi = InuSUSCCODI;

    rfcucontrato cucontrato%ROWTYPE;

    nuSEGUROVOLUNTARIO_ID NUMBER;

    nuGEOGRAP_LOCATION_DEPA NUMBER;
    nuGEOGRAP_LOCATION_LOCA NUMBER;
    --nuCICLO                 NUMBER;
    --nuSUSCCODI              NUMBER;
    --nuPACKAGE_ID            NUMBER;
    nuPRODUCT_ID NUMBER;
    nuARTICLE_ID NUMBER;
    nuDIFECODI   NUMBER;
    --nuCONTRACTOR_ID         NUMBER;
    --nuOPERATING_UNIT_ID     NUMBER;
    nuTARIFA NUMBER;
    --nuDIRECCION      NUMBER;
    NUiniciovigencia NUMBER;
    NUfinvigencia    NUMBER;

    DTiniciovigencia DATE;
    DTfinvigencia    DATE;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.PRREGISTROSEGUROVOLUNTARIO',
                   10);

    open cuexisteventaarticulo;
    fetch cuexisteventaarticulo
      into rfcuexisteventaarticulo;
    --if cuexisteventaarticulo%found then
    if 1 = 0 then

      OPEN cudatosventa;
      FETCH cudatosventa
        INTO rfcudatosventa;
      CLOSE cudatosventa;

      OPEN cucontrato;
      FETCH cucontrato
        INTO RFcucontrato;
      CLOSE cucontrato;

      nuGEOGRAP_LOCATION_LOCA := nvl(daab_address.fnugetgeograp_location_id(rfcudatosventa.address_id,
                                                                            null),
                                     0);
      nuGEOGRAP_LOCATION_DEPA := Ge_Bogeogra_Location.Fnugetge_Geogra_Location(nuGEOGRAP_LOCATION_LOCA,
                                                                               Ab_Boconstants.Csbtoken_Departamento);

      nuSEGUROVOLUNTARIO_ID := seq_ldc_segurovoluntario.nextval;
      ut_trace.trace('Secuencia[' || nuSEGUROVOLUNTARIO_ID || ']', 10);

    end if;
    close cuexisteventaarticulo;

    NUiniciovigencia := TO_NUMBER(TO_CHAR(rfcudatosventa.Sale_Date,
                                          'DDMMYYYY'));
    NUfinvigencia    := TO_CHAR(ADD_MONTHS(SYSDATE,
                                           rfcuexisteventaarticulo.credit_fees) +
                                NVL(DALD_PARAMETER.fnuGetNumeric_Value('CANT_DIAS_FECH_VIG_SEG_VOL',
                                                                       NULL),
                                    0),
                                'DDMMYYYY');

    DTiniciovigencia := rfcudatosventa.Sale_Date;
    DTfinvigencia    := ADD_MONTHS(SYSDATE,
                                   rfcuexisteventaarticulo.credit_fees) +
                        NVL(DALD_PARAMETER.fnuGetNumeric_Value('CANT_DIAS_FECH_VIG_SEG_VOL',
                                                               NULL),
                            0);

    insert into ldc_segurovoluntario
      (segurovoluntario_id,
       geograp_location_depa,
       geograp_location_loca,
       susccodi,
       package_id,
       product_id,
       article_id,
       difecodi,
       contractor_id,
       tarifa,
       codproducto,
       iniciovigencia,
       finvigencia,
       plancardif,
       tipoidasegurado,
       idasegurado,
       primerapellidoasegurado,
       segundoapellidoasegurado,
       primernombreasegurado,
       segundonombreasegurado,
       genero_asegurado,
       estado_civil,
       fecnacimientoasegurado,
       telasegurado,
       celasegurado,
       direccionasegurado,
       ciudadasegurado,
       nacionalidad,
       pais_residencia,
       pais_nacimiento_asegurado,
       emailasegurado,
       prima_antes_iva,
       prima_iva_incluido,
       codigoproductobancario,
       numeroproductocrediticio,
       plazocredito,
       valorcredito,
       valorcuotacredito,
       canal,
       codigoasesor,
       documentoasesor,
       nombreasesor,
       sucursal)
    values
      (nusegurovoluntario_id,
       nugeograp_location_depa,
       nugeograp_location_loca,
       InuSUSCCODI,
       InuPACKAGE_ID,
       nuproduct_id,
       nuarticle_id,
       nudifecodi,
       daor_operating_unit.fnugetcontractor_id(rfcuexisteventaarticulo.asesor_venta),
       nutarifa,
       DALD_PARAMETER.fnuGetNumeric_Value('COD_TIPO_SERV_CARDIF', null), --6201,
       DTiniciovigencia, --NUiniciovigencia,
       DTfinvigencia, --NUfinvigencia,
       1,
       rfcudatosventa.ident_type_id, --v_tipoidasegurado,
       SUBSTR(rfcudatosventa.identification, 1, 12), --v_idasegurado,
       null, --v_primerapellidoasegurado,
       null, --v_segundoapellidoasegurado,
       null, --v_primernombreasegurado,
       null, --v_segundonombreasegurado,
       rfcudatosventa.gender, --v_genero_asegurado,
       rfcudatosventa.civil_state_id, --v_estado_civil,
       rfcudatosventa.forwardingdate, --v_fecnacimientoasegurado,
       rfcudatosventa.phone1_id, --v_telasegurado,
       rfcudatosventa.movilphone_id, --v_celasegurado,
       rfcudatosventa.address_id, --v_direccionasegurado,
       nugeograp_location_depa, --v_ciudadasegurado,
       NULL, --v_nacionalidad,
       NULL, --v_pais_residencia,
       NULL, --v_pais_nacimiento_asegurado,
       NULL, --v_emailasegurado,
       rfcudatosventa.Quota_Aprox_Month, --v_prima_antes_iva,
       rfcudatosventa.Quota_Aprox_Month, --v_prima_iva_incluido,
       NULL, --v_codigoproductobancario,
       NULL, --v_numeroproductocrediticio,
       NULL, --v_plazocredito,
       NULL, --rfcudatosventa.Used_Quote,--v_valorcredito,
       NULL, --rfcudatosventa.Used_Quote,--v_valorcuotacredito,
       NULL, --v_canal,
       rfcuexisteventaarticulo.asesor_venta, --v_codigoasesor,
       NULL, --v_documentoasesor,
       NULL, --v_nombreasesor,
       NULL --v_sucursal
       );

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.PRREGISTROSEGUROVOLUNTARIO',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
      --return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
      --return 0;
  END PRREGISTROSEGUROVOLUNTARIO;

  /**************************************************************************
  Funcion     :  PRREGISTROVENTASEGURO
  Descripcion :  Registra el artiuclo vendido en FIFAP de seguro voluntario
  Autor       :  Jorge Valiente
  Fecha       :  16-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  18/02/2020      INNOVACION               CA 235 cambio para televenta
  04/10/2017      SEBTAP                   Ca 200-1485 se agrega modificacion para separar
                                           nombres y apellidos segun estandar cardiff
  27/10/2017      RONCOL                   Ca 200-1537 Se excluye del valor de la venta el palor de la prima
                                           asi como para el calculo de la cuota en el indert ldc_segurovoluntario
  05/12/2018      DANVAL                   Se modifico el campo asociado a la longitud
  **************************************************************************/
  PROCEDURE PRREGISTROVENTASEGURO(InuPACKAGE_ID NUMBER) IS

    cursor cuexisteventaarticulo is
      SELECT MDF.*, o.operating_unit_id Punto_Venta
        FROM open.or_order           o,
             open.or_order_activity  oa,
             OPEN.LD_ITEM_WORK_ORDER MDF
       where oa.package_id = InuPACKAGE_ID
         and oa.order_id = o.order_id
         and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
         and o.task_type_id = 12590
         and MDF.Article_Id in
             (SELECT l.article_id
                FROM LD_ARTICLE L
               WHERE L.Concept_Id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))));

    rfcuexisteventaarticulo cuexisteventaarticulo%rowtype;

    cursor cudatosventa is
      SELECT *
        FROM LD_NON_BA_FI_REQU L, LD_PROMISSORY LP
       WHERE L.NON_BA_FI_REQU_ID = InuPACKAGE_ID
         AND LP.PACKAGE_ID = L.NON_BA_FI_REQU_ID
         AND LP.PROMISSORY_TYPE = 'D';

    rfcudatosventa cudatosventa%ROWTYPE;

    cursor cucontrato is
      select *
        from suscripc s
       where s.susccodi = nvl(damo_packages.fnugetsubscription_pend_id(InuPACKAGE_ID,
                                                                       null),
                              0);

    rfcucontrato cucontrato%ROWTYPE;

    cursor cugeperson(InuPerson_ID number) is
      select gp.* from ge_person gp where gp.person_id = InuPerson_ID;
    --.user_id = GE_BOPersonal.fnuGetPersonId;

    rfcugeperson cugeperson%ROWTYPE;

    cursor cucodigoDANE(Inuaddress_id number) is
      select dane.municipio codigo, dane.municipio nombre
        from open.ab_address dir, open.ldc_equiva_localidad dane
       where dir.address_id = (Inuaddress_id)
         and dir.geograp_location_id = dane.geograp_location_id
         and rownum = 1;

    rfcucodigoDANE cucodigoDANE%ROWTYPE;

    --------------------------
    -- CAMBIO 235 -->
    --------------------------
    cursor cuValorVentas(InuContract number, InuPACKAGE number) is
      select nvl(sum(df.difesape), 0) total
        from open.mo_packages mo
       inner join open.or_order_activity or_order
          on or_order.package_id = mo.package_id
       inner join open.ld_item_work_order ld_item
          on ld_item.order_activity_id = or_order.order_activity_id
       inner join open.ld_article ld_article
          on ld_item.article_id = ld_article.article_id
       inner join open.diferido df
          on df.difecodi = ld_item.difecodi
       where mo.subscription_pend_id = InuContract
         and or_order.activity_id = 4000822
         and mo.package_id <> InuPACKAGE
         and df.difesape > 0;

    nuValorTV NUMBER(15, 2);

    cursor cuTeleVentas(InuPACKAGE number) is
      SELECT count(1) nuExistsTV
        FROM open.or_order           o,
             open.or_order_activity  oa,
             OPEN.LD_ITEM_WORK_ORDER MDF
       where oa.package_id = InuPACKAGE
         and oa.order_id = o.order_id
         and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
         and o.task_type_id = 12590
         and MDF.Article_Id not in
             (SELECT l.article_id
                FROM open.LD_ARTICLE L
               WHERE L.Concept_Id IN
                     (select nvl(to_number(column_value), 0)
                        from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                           NULL),
                                                                     ','))));

    nuExistsTV NUMBER;

    --------------------------
    -- CAMBIO 235 <--
    --------------------------

    nuSEGUROVOLUNTARIO_ID NUMBER;

    nuGEOGRAP_LOCATION_DEPA NUMBER;
    nuGEOGRAP_LOCATION_LOCA NUMBER;
    --nuCICLO                 NUMBER;
    nuSUSCCODI NUMBER;
    --nuPACKAGE_ID            NUMBER;
    nuPRODUCT_ID NUMBER;
    nuARTICLE_ID NUMBER;
    nuDIFECODI   NUMBER;
    --nuCONTRACTOR_ID         NUMBER;
    --nuOPERATING_UNIT_ID     NUMBER;
    nuTARIFA NUMBER;
    --nuDIRECCION      NUMBER;
    NUiniciovigencia  NUMBER;
    NUfinvigencia     NUMBER;
    NUnacionalidad    NUMBER;
    NUPagare          varchar2(30);
    nuCIUDADASEGURADO number; --codigodane

    DTiniciovigencia DATE;
    DTfinvigencia    DATE;

    nuPerson_ID number;
    sbSucursal  ldc_segurovoluntario.sucursal%type;

    -----Nuevo Nombre, Apellido, Identificacion
    sbNombre         open.LDC_DATOS_ACTUALIZAR.new_name%type;
    sbApellido       open.LDC_DATOS_ACTUALIZAR.new_lastname%type;
    sbIdentificacion open.LDC_DATOS_ACTUALIZAR.new_ident%type;
    --------------------------------------------------

    -----PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido
    --Ca 200-1485
    sbP_Nombre   OPEN.LDC_SEGUROVOLUNTARIO.PRIMERNOMBREASEGURADO%TYPE := null;
    sbS_Nombre   OPEN.LDC_SEGUROVOLUNTARIO.SEGUNDONOMBREASEGURADO%TYPE := null;
    sbP_Apellido OPEN.LDC_SEGUROVOLUNTARIO.PRIMERAPELLIDOASEGURADO%TYPE := null;
    sbS_Apellido OPEN.LDC_SEGUROVOLUNTARIO.SEGUNDOAPELLIDOASEGURADO%TYPE := null;
    --------------------------------------------------
  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.PRREGISTROVENTASEGURO',
                   10);

    nuSUSCCODI := nvl(damo_packages.fnugetsubscription_pend_id(InuPACKAGE_ID,
                                                               null),
                      0);

    nuPerson_ID := nvl(damo_packages.fnugetperson_id(InuPACKAGE_ID, null),
                       0);

    sbSucursal := substr(substr(daor_operating_unit.fsbgetname(damo_packages.fnugetsale_channel_id(InuPACKAGE_ID,
                                                                                                   null),
                                                               null),
                                7),
                         1,
                         10);

    open cuexisteventaarticulo;
    fetch cuexisteventaarticulo
      into rfcuexisteventaarticulo;
    if cuexisteventaarticulo%found then

      OPEN cudatosventa;
      FETCH cudatosventa
        INTO rfcudatosventa;
      CLOSE cudatosventa;

      OPEN cucontrato;
      FETCH cucontrato
        INTO RFcucontrato;
      CLOSE cucontrato;

      nuGEOGRAP_LOCATION_LOCA := nvl(daab_address.fnugetgeograp_location_id(rfcudatosventa.address_id,
                                                                            null),
                                     0);
      nuGEOGRAP_LOCATION_DEPA := Ge_Bogeogra_Location.Fnugetge_Geogra_Location(nuGEOGRAP_LOCATION_LOCA,
                                                                               Ab_Boconstants.Csbtoken_Departamento);

      nuSEGUROVOLUNTARIO_ID := seq_ldc_segurovoluntario.nextval;
      ut_trace.trace('Secuencia[' || nuSEGUROVOLUNTARIO_ID || ']', 10);

      NUiniciovigencia := TO_NUMBER(TO_CHAR(rfcudatosventa.Sale_Date,
                                            'DDMMYYYY'));
      NUfinvigencia    := TO_CHAR(ADD_MONTHS(SYSDATE,
                                             rfcuexisteventaarticulo.credit_fees) +
                                  NVL(DALD_PARAMETER.fnuGetNumeric_Value('CANT_DIAS_FECH_VIG_SEG_VOL',
                                                                         NULL),
                                      0),
                                  'DDMMYYYY');

      DTiniciovigencia := rfcudatosventa.Sale_Date;
      DTfinvigencia    := ADD_MONTHS(SYSDATE,
                                     rfcuexisteventaarticulo.credit_fees) +
                          NVL(DALD_PARAMETER.fnuGetNumeric_Value('CANT_DIAS_FECH_VIG_SEG_VOL',
                                                                 NULL),
                              0);

      NUnacionalidad := dage_geogra_location.fnugetgeo_loca_father_id(dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id(rfcudatosventa.address_id,
                                                                                                                                                           null),
                                                                                                                    null));

      if rfcudatosventa.digital_prom_note_cons is not null then
        NUPagare := rfcudatosventa.digital_prom_note_cons;
      else
        NUPagare := rfcudatosventa.manual_prom_note_cons;
      end if;

      open cugeperson(nuPerson_ID);
      fetch cugeperson
        into rfcugeperson;
      close cugeperson;

      nuarticle_id := NVL(rfcuexisteventaarticulo.article_id, 0);
      nutarifa     := NVL(rfcuexisteventaarticulo.value, 0);

      open cucodigoDANE(rfcudatosventa.address_id);
      fetch cucodigoDANE
        into rfcucodigoDANE;
      if cucodigoDANE%found then
        nuCIUDADASEGURADO := rfcucodigoDANE.codigo;
      end if;
      close cucodigoDANE;

      ----------Nuevo Nombre, Nuevo Apellido, Nueva Identifcacion-------
      IF rfcudatosventa.debtorname IS NULL THEN

        begin
          select nvl(lda.new_name, rfcudatosventa.debtorname)
            into sbNombre
            from LDC_DATOS_ACTUALIZAR lda
           where lda.package_id = InuPACKAGE_ID
             and rownum = 1;
        exception
          when others then
            sbNombre := rfcudatosventa.debtorname;
        end;

      ELSE
        sbNombre := rfcudatosventa.debtorname;
      END IF;

      IF rfcudatosventa.last_name IS NULL THEN
        begin
          select nvl(lda.new_lastname, rfcudatosventa.last_name)
            into sbApellido
            from LDC_DATOS_ACTUALIZAR lda
           where lda.package_id = InuPACKAGE_ID
             and rownum = 1;
        exception
          when others then
            sbApellido := rfcudatosventa.last_name;
        end;

      ELSE
        sbApellido := rfcudatosventa.last_name;
      END IF;

      IF rfcudatosventa.identification IS NULL THEN
        begin
          select nvl(lda.new_ident, rfcudatosventa.identification)
            into sbIdentificacion
            from LDC_DATOS_ACTUALIZAR lda
           where lda.package_id = InuPACKAGE_ID
             and rownum = 1;
        exception
          when others then
            sbIdentificacion := rfcudatosventa.identification;
        end;

      ELSE
        sbIdentificacion := rfcudatosventa.identification;
      END IF;
      ------------------------------------------------------------------

      --------------------Separar Nombres y Apellidos-------------------
      --Cambio requerido en el caso 200-1485
      begin
        SELECT TRIM(SUBSTR(sbNombre, 0, INSTR(sbNombre, ' ')))
          INTO sbP_Nombre
          FROM DUAL; --Primer Nombre
        SELECT TRIM(SUBSTR(sbNombre, INSTR(sbNombre, ' ') + 1))
          INTO sbS_Nombre
          FROM DUAL; --Segundo Nombre
        SELECT TRIM(SUBSTR(sbApellido, 0, INSTR(sbApellido, ' ')))
          INTO sbP_Apellido
          FROM DUAL; --Primer Apellido
        SELECT TRIM(SUBSTR(sbApellido, INSTR(sbApellido, ' ') + 1))
          INTO sbS_Apellido
          FROM DUAL; --Segundo Apellido
        IF (sbP_Nombre is null) THEN
          sbP_Nombre := sbS_Nombre;
          sbS_Nombre := null;
        END IF;
        IF (sbS_Nombre is null) THEN
          sbS_Nombre := 'N/A';
        END IF;
        IF (sbP_Apellido is null) THEN
          sbP_Apellido := sbS_Apellido;
          sbS_Apellido := null;
        END IF;
        IF (sbS_Apellido is null) THEN
          sbS_Apellido := 'N/A';
        END IF;
      end;
      ------------------------------------------------------------------
      ------------------------------------
      -- CAMBIO 235
      -- Este cambio valida si el codigo de producto cardif a registrar
      -- es televenta o no (Se identifica una televenta si tiene un articulo cargado a parte de cardif).
      -- Si lo es, modifica el valor del credito a guardar en la tabla
      -- Si no, guarda los valores de manera habitual.
      ------------------------------------
      open cuTeleVentas(InuPACKAGE_ID);
      fetch cuTeleVentas
        into nuExistsTV;
      close cuTeleVentas;
      if nuExistsTV > 0 then
        insert into ldc_segurovoluntario
          (segurovoluntario_id,
           geograp_location_depa,
           geograp_location_loca,
           susccodi,
           package_id,
           product_id,
           article_id,
           difecodi,
           contractor_id,
           tarifa,
           codproducto,
           iniciovigencia,
           finvigencia,
           plancardif,
           tipoidasegurado,
           idasegurado,
           primerapellidoasegurado,
           segundoapellidoasegurado,
           primernombreasegurado,
           segundonombreasegurado,
           genero_asegurado,
           estado_civil,
           fecnacimientoasegurado,
           telasegurado,
           celasegurado,
           direccionasegurado,
           ciudadasegurado,
           nacionalidad,
           pais_residencia,
           pais_nacimiento_asegurado,
           emailasegurado,
           prima_antes_iva,
           prima_iva_incluido,
           codigoproductobancario,
           numeroproductocrediticio,
           plazocredito,
           valorcredito,
           valorcuotacredito,
           canal,
           codigoasesor,
           documentoasesor,
           nombreasesor,
           sucursal,
           ORDER_ACTIVITY_ID)
        values
          (nusegurovoluntario_id,
           nugeograp_location_depa,
           nugeograp_location_loca,
           nuSUSCCODI,
           InuPACKAGE_ID,
           nuproduct_id,
           nuarticle_id,
           nudifecodi,
           daor_operating_unit.fnugetcontractor_id(rfcuexisteventaarticulo.punto_venta),
           nutarifa,
           DALD_PARAMETER.fnuGetNumeric_Value('COD_TIPO_SERV_CARDIF', null), --6201,
           DTiniciovigencia, --NUiniciovigencia,
           DTfinvigencia, --NUfinvigencia,
           1,
           rfcudatosventa.ident_type_id, --v_tipoidasegurado,
           SUBSTR(sbIdentificacion /*rfcudatosventa.identification*/, 1, 12), --v_idasegurado,
           --SUBSTR(sbApellido /*rfcudatosventa.last_name*/, 1, 30), --null, --v_primerapellidoasegurado,
           --null, --v_segundoapellidoasegurado,
           --SUBSTR(sbNombre /*rfcudatosventa.debtorname*/, 1, 30), --null, --v_primernombreasegurado,
           --null, --v_segundonombreasegurado,
           SUBSTR(sbP_Apellido, 1, 30), --Primer Apellido CA 200-1485
           SUBSTR(sbS_Apellido, 1, 30), --Segundo Apellido CA 200-1485
           SUBSTR(sbP_Nombre, 1, 30), --Primer Nombre CA 200-1485
           SUBSTR(sbS_Nombre, 1, 30), --Segundo Nombre CA 200-1485
           rfcudatosventa.gender, --v_genero_asegurado,
           rfcudatosventa.civil_state_id, --v_estado_civil,
           rfcudatosventa.birthdaydate, --v_fecnacimientoasegurado,
           rfcudatosventa.propertyphone_id, --v_telasegurado,
           rfcudatosventa.movilphone_id, --v_celasegurado,
           --daab_address.fsbgetaddress(rfcudatosventa.address_id, null), --v_direccionasegurado,
           --Caso 200-2162 Restriccion de la Longitud del Campo
           --la longitud maxima del campo esta determinada por el parametro PAR_LONG_DIR_CARDIF
           SUBSTR(daab_address.fsbgetaddress(rfcudatosventa.address_id,
                                             null),
                  1,
                  open.dald_parameter.fnuGetNumeric_Value('PAR_LONG_DIR_CARDIF')), --v_direccionasegurado,
           --
           nuCIUDADASEGURADO, --v_ciudadasegurado,
           170, --NUnacionalidad, --NULL, --v_nacionalidad,
           170, --NUnacionalidad, --NULL, --v_pais_residencia,
           170, --NUnacionalidad, --NULL, --v_pais_nacimiento_asegurado,
           rfcudatosventa.email, --NULL, --v_emailasegurado,
           nutarifa, --rfcudatosventa.Quota_Aprox_Month, --v_prima_antes_iva,
           nutarifa, --rfcudatosventa.Quota_Aprox_Month, --v_prima_iva_incluido,
           3, --NULL, --v_codigoproductobancario,
           NUPagare, -- NULL, --v_numeroproductocrediticio,
           rfcuexisteventaarticulo.credit_fees, --NULL, --v_plazocredito,
           rfcudatosventa.value_total - nutarifa, --NULL, --rfcudatosventa.Used_Quote,--v_valorcredito,
           null, /*((rfcudatosventa.value_total - nutarifa) /
                                                                                                                                                       nvl(rfcuexisteventaarticulo.credit_fees, 1))*/ --NULL, --rfcudatosventa.Used_Quote,--v_valorcuotacredito,
           1, --NULL, --v_canal,
           nuPerson_ID, --rfcugeperson.user_id, --v_codigoasesor,
           rfcugeperson.number_id, --v_documentoasesor,
           SUBSTR(rfcugeperson.name_, 1, 35), --NULL, --v_nombreasesor,
           sbSucursal, --substr(substr(sbSucursal, 7), 1, 10), --NULL --v_sucursal
           rfcuexisteventaarticulo.Order_Activity_Id --ACTIVIDAD DE ORDEN ASOCIADA A SEGURO VOLUNTARIO
           );
      elsif nuExistsTV = 0 then
        open cuValorVentas(nuSUSCCODI, InuPACKAGE_ID);
        fetch cuValorVentas
          into nuValorTV;
        close cuValorVentas;
        insert into ldc_segurovoluntario
          (segurovoluntario_id,
           geograp_location_depa,
           geograp_location_loca,
           susccodi,
           package_id,
           product_id,
           article_id,
           difecodi,
           contractor_id,
           tarifa,
           codproducto,
           iniciovigencia,
           finvigencia,
           plancardif,
           tipoidasegurado,
           idasegurado,
           primerapellidoasegurado,
           segundoapellidoasegurado,
           primernombreasegurado,
           segundonombreasegurado,
           genero_asegurado,
           estado_civil,
           fecnacimientoasegurado,
           telasegurado,
           celasegurado,
           direccionasegurado,
           ciudadasegurado,
           nacionalidad,
           pais_residencia,
           pais_nacimiento_asegurado,
           emailasegurado,
           prima_antes_iva,
           prima_iva_incluido,
           codigoproductobancario,
           numeroproductocrediticio,
           plazocredito,
           valorcredito,
           valorcuotacredito,
           canal,
           codigoasesor,
           documentoasesor,
           nombreasesor,
           sucursal,
           ORDER_ACTIVITY_ID)
        values
          (nusegurovoluntario_id,
           nugeograp_location_depa,
           nugeograp_location_loca,
           nuSUSCCODI,
           InuPACKAGE_ID,
           nuproduct_id,
           nuarticle_id,
           nudifecodi,
           daor_operating_unit.fnugetcontractor_id(rfcuexisteventaarticulo.punto_venta),
           nutarifa,
           DALD_PARAMETER.fnuGetNumeric_Value('COD_TIPO_SERV_CARDIF', null),
           DTiniciovigencia,
           DTfinvigencia,
           1,
           rfcudatosventa.ident_type_id,
           SUBSTR(sbIdentificacion, 1, 12),
           SUBSTR(sbP_Apellido, 1, 30),
           SUBSTR(sbS_Apellido, 1, 30),
           SUBSTR(sbP_Nombre, 1, 30),
           SUBSTR(sbS_Nombre, 1, 30),
           rfcudatosventa.gender,
           rfcudatosventa.civil_state_id,
           rfcudatosventa.birthdaydate,
           rfcudatosventa.propertyphone_id,
           rfcudatosventa.movilphone_id,
           SUBSTR(daab_address.fsbgetaddress(rfcudatosventa.address_id,
                                             null),
                  1,
                  open.dald_parameter.fnuGetNumeric_Value('PAR_LONG_DIR_CARDIF')),
           nuCIUDADASEGURADO,
           170,
           170,
           170,
           rfcudatosventa.email,
           nutarifa,
           nutarifa,
           3,
           NUPagare,
           rfcuexisteventaarticulo.credit_fees,
           nuValorTV,
           null,
           1,
           nuPerson_ID,
           rfcugeperson.number_id,
           SUBSTR(rfcugeperson.name_, 1, 35),
           sbSucursal,
           rfcuexisteventaarticulo.Order_Activity_Id);
      else
        null;
      end if;

    end if;
    close cuexisteventaarticulo;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.PRREGISTROVENTASEGURO',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
      --return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
      --return 0;
  END PRREGISTROVENTASEGURO;

  ---CASO 200-1164 ETAPA 3
  /**************************************************************************
  Funcion     :  FNUEDADVALIDASEGURO
  Descripcion :  Retorna un valor indicado si la edad del deudor es valida para
                 obtener el seguro
                 0 - FALLO que NO es valido para utilizar el seguro
                 1 - EXITO que es valido para utilizar el seguro
  Autor       :  Jorge Valiente
  Fecha       :  22-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  01/10/2018      ELara                   Se le agregan dos decimales al round para obtener la edad del deudor.
  **************************************************************************/
  FUNCTION FNUEDADVALIDASEGURO(yearsDeudorSeguro in varchar2) RETURN NUMBER

   IS

    nuEXITOFALLO number := 0;

    nuYearEdadSeguro number := nvl(DALD_PARAMETER.fnuGetNumeric_Value('EDAD_MINI_SEGU_VOLU_FIFAP',
                                                                      null),
                                   0);
    nuDiasEdadSeguro number := nvl(DALD_PARAMETER.fnuGetNumeric_Value('CANT_DIAS_SEGU_VOL_FIFAP',
                                                                      null),
                                   0);

    nuYearsDeudor number;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUEDADVALIDASEGURO',
                   10);

    -----

    dbms_output.put_line('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUEDADVALIDASEGURO');

    dbms_output.put_line('Fecha nacimiento Deudor FIFAP[' ||
                         yearsDeudorSeguro || ']');
    /*nuYearsDeudor := round(months_between(trunc(sysdate),
    to_date(yearsDeudorSeguro,
            'DD/MM/YYYY')) / 12);*/
    --REQ.200-2172 := Se agrega al round, dos decimales para realizar el calculo con mas exactitud.
    nuYearsDeudor := round(months_between(trunc(sysdate),
                                          to_date(yearsDeudorSeguro,
                                                  'DD/MM/YYYY')) / 12,
                           2);
    dbms_output.put_line('Edad Deudor FIFAP[' || nuYearsDeudor || ']');
    dbms_output.put_line('Edad Valida Deudor Parametro EDAD_MINI_SEGU_VOLU_FIFAP[' ||
                         nuYearEdadSeguro || '] FIFAP');
    dbms_output.put_line('Dias Valido Deudor Parametro CANT_DIAS_SEGU_VOL_FIFAP[' ||
                         nuDiasEdadSeguro || '] FIFAP');

    --validar que la edad del deudor desde el a?o de nacimiento del deudor hasta la fecha en que
    --se ejecuta ese servicio (SYSDATE) no sea mayor a la del parametro para articulo seguro
    --Valida EDAD
    if nuYearsDeudor > nuYearEdadSeguro then
      --is not null then
      nuEXITOFALLO := 0;
      dbms_output.put_line('1');

    else
      --Valida EDAD
      if nuYearsDeudor = nuYearEdadSeguro then
        --VALIDA MES
        dbms_output.put_line('2');
        if to_number(TO_CHAR(SYSDATE, 'MM')) >
           TO_NUMBER(TO_CHAR(trunc(to_date(yearsDeudorSeguro)), 'MM')) then
          dbms_output.put_line('3');
          nuEXITOFALLO := 0;
        else
          --VALIDA MES
          if to_number(TO_CHAR(SYSDATE, 'MM')) =
             TO_NUMBER(TO_CHAR(trunc(to_date(yearsDeudorSeguro)), 'MM')) then
            --Valida DIA
            dbms_output.put_line('4');
            dbms_output.put_line('DIA FECHA ACTUAL ' ||
                                 to_number(TO_CHAR(SYSDATE, 'DD')));
            dbms_output.put_line('DIA FECHA NACIMIENTO ' ||
                                 TO_NUMBER(TO_CHAR(trunc(to_date(yearsDeudorSeguro)),
                                                   'DD')));
            if to_number(TO_CHAR(SYSDATE, 'DD')) >=
               (TO_NUMBER(TO_CHAR(trunc(to_date(yearsDeudorSeguro)), 'DD')) -
                nuDiasEdadSeguro) then
              dbms_output.put_line('5');
              nuEXITOFALLO := 0;
            else
              --if to_number(TO_CHAR(SYSDATE, 'DD')) =
              --   (TO_NUMBER(TO_CHAR(trunc(to_date(yearsDeudorSeguro)), 'DD')) -
              --    nuDiasEdadSeguro) then
              --  dbms_output.put_line('5.1');
              --  nuEXITOFALLO := 0;
              --else
              --  dbms_output.put_line('5.2');
              nuEXITOFALLO := 1;
              --end if;
            end if;
          else
            dbms_output.put_line('7');
            nuEXITOFALLO := 1;
          end if;
        end if;
      else
        dbms_output.put_line('8');
        nuEXITOFALLO := 1;
      end if;
    end if;

    dbms_output.put_line(nuEXITOFALLO);

    -------

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUEDADVALIDASEGURO',
                   10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return - 1;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return - 1;
  END FNUEDADVALIDASEGURO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROGENOTANULASEGUROVOLUNTARIO
  Descripcion    : Procedimiento para la generacion de la orden de anulacion
                   del seguro voluntario en un venta FIFAP.
  Autor          : Jorge Valiente
  Fecha          : 26/05/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  ******************************************************************/

  PROCEDURE PROGENOTANULASEGUROVOLUNTARIO(inuPackage in OPEN.mo_packages.package_id%type) IS

    nuOrderId         number;
    nuOrderActivityId number;
    nuOrdervis        number;
    rcMoPackage       OPEN.damo_packages.styMO_packages;
    nuMotive          number;
    product_id        number;
    suscription_id    OPEN.suscripc.susccodi%type;
    onuerrorcode      number;
    osberrormessage   varchar2(2000);

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.PROGENOTANULASEGUROVOLUNTARIO',
                   10);

    /*
    damo_packages.getRecord(inupackage, rcMopackage);

    nuMotive := OPEN.mo_bopackages.fnuGetInitialMotive(inupackage);

    product_id     := OPEN.mo_bomotive.fnugetproductid(nuMotive);
    suscription_id := OPEN.mo_bomotive.fnugetsubscription(nuMotive);

    \* Se crea la orden de visita tecnica *\
    nuOrderId         := null;
    nuOrderActivityId := null;
    nuOrdervis        := to_number(OPEN.DALD_PARAMETER.fnuGetNumeric_Value('COD_ANU_SEG_VOL_BRILLA_FIFAP'));

    or_boorderactivities.CreateActivity(nuOrdervis,
                                        inuPackage,
                                        nuMotive,
                                        null,
                                        null,
                                        rcMoPackage.Address_id,
                                        null,
                                        null,
                                        suscription_id,
                                        product_id,
                                        null,
                                        null,
                                        null,
                                        null,
                                        'Orden de Revisi?n de documentos pagare unico',
                                        null,
                                        null,
                                        nuOrderId,
                                        nuOrderActivityId,
                                        null,
                                        null,
                                        null,
                                        null,
                                        null,
                                        null,
                                        null,
                                        null,
                                        null);

    \*
    --Se asigna a la unidad operativa
    if (rcMoPackage.POS_OPER_UNIT_ID is not null) then

      os_assign_order(TO_NUMBER(nuOrderId),
                      rcMoPackage.POS_OPER_UNIT_ID,
                      sysdate,
                      sysdate,
                      onuerrorcode,
                      osberrormessage);
    end if;
    *\

    DBMS_OUTPUT.put_line('Orden generada[' || nuOrderId || ']');
    */

    ut_trace.Trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.PROGENOTANULASEGUROVOLUNTARIO',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROGENOTANULASEGUROVOLUNTARIO;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : PROESTADOSEGUROVOLUNTARIO
  Descripcion    : Procedimiento para realizar el cambio de estado del
                   seguro voluntario en un venta FIFAP.
  Autor          : Jorge Valiente
  Fecha          : 30/05/2017

  Parametros         Descripcion
  ============  ===================
  inuPackage:    Numero del paquete


  Historia de Modificaciones
  Fecha            Autor          Modificacion
  ==========  =================== =======================
  ******************************************************************/

  PROCEDURE PROESTADOSEGUROVOLUNTARIO IS

    nuOrderId         number;
    nuOrderActivityId number;
    nuOrdervis        number;
    rcMoPackage       OPEN.damo_packages.styMO_packages;
    nuMotive          number;
    product_id        number;
    suscription_id    OPEN.suscripc.susccodi%type;
    onuerrorcode      number;
    osberrormessage   varchar2(2000);

  BEGIN

    ut_trace.Trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.PROESTADOSEGUROVOLUNTARIO',
                   10);

    --ORDEN LEGALIZADA DE LA INSTANCIA
    nuOrderId := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER;
    ut_trace.Trace('Orden a legalizar[' || nuOrderId || ']', 10);

    ut_trace.Trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.PROESTADOSEGUROVOLUNTARIO',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end PROESTADOSEGUROVOLUNTARIO;

  /**************************************************************************
  Funcion     :  FNUDIFERIDOSEGURO
  Descripcion :  Retorna el diferido asociado a un seguro voluntario relacionado a una
                 venta en FIFAP
                 0 - FALLO que NO existe defido asociado
  Autor       :  Jorge Valiente
  Fecha       :  31-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUDIFERIDOSEGURO(nuSolicitudVenta in number,
                             nuarticle_id     in number) RETURN NUMBER

   IS

    cursor cudiferidoseguro is
      select distinct nvl(l1.difecodi, 0) diferido
        from ld_item_work_order l1
       where l1.order_activity_id in
             (select ooa.order_activity_id
                from open.Or_Order_Activity ooa
               where ooa.package_id = nuSolicitudVenta)
         and l1.article_id = nuarticle_id
         and (SELECT /*+ index (L PK_LD_ARTICLE IX_LD_ARTICLE_04) */
               count(1)
                FROM LD_ARTICLE L
               WHERE l.concept_id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))
                       where l.article_id = l1.ARTICLE_ID)) > 0
         and l1.difecodi is not null
         and rownum = 1;

    rfcudiferidoseguro cudiferidoseguro%rowtype;

    nuEXITOFALLO number := 0;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUDIFERIDOSEGURO',
                   10);

    open cudiferidoseguro;
    fetch cudiferidoseguro
      into rfcudiferidoseguro;
    close cudiferidoseguro;

    nuEXITOFALLO := rfcudiferidoseguro.diferido;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUDIFERIDOSEGURO', 10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return 0;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return 0;
  END FNUDIFERIDOSEGURO;

  /**************************************************************************
  Funcion     :  FNUDIFERIDOSEGURO
  Descripcion :  Valida si la orden desplegada en FLOTE tiene o no un articulo
                 de seguro voluntario en la venta BRILLA
                 0 - La orden NO tiene relacion con articulo de seguro volunatio
                 1 - La orden tiene relacion con articulo de seguro volunatio
  Autor       :  Jorge Valiente
  Fecha       :  07-06-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUORDENSEGUROVOLUNTARIO(nuorder_activity_id in number)
    RETURN NUMBER

   IS

    cursor cuexistesegurovoluntario is
      select count(1) cantidad
        from ld_item_work_order ld
       where ld.order_activity_id = nuorder_activity_id
         and (SELECT /*+ index (L PK_LD_ARTICLE IX_LD_ARTICLE_04) */
               count(1)
                FROM LD_ARTICLE L
               WHERE l.concept_id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))
                       where l.article_id = ld.ARTICLE_ID)) > 0;

    rfcuexistesegurovoluntario cuexistesegurovoluntario%rowtype;

    nuEXITOFALLO number := 0;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUORDENSEGUROVOLUNTARIO',
                   10);
    ut_trace.trace('nuorder_activity_id[' || nuorder_activity_id || ']',
                   10);

    open cuexistesegurovoluntario;
    fetch cuexistesegurovoluntario
      into rfcuexistesegurovoluntario;

    ut_trace.trace('rfcuexistesegurovoluntario.cantidad[' ||
                   rfcuexistesegurovoluntario.cantidad || ']',
                   10);

    if rfcuexistesegurovoluntario.cantidad = 0 then
      nuEXITOFALLO := 0;
    else
      nuEXITOFALLO := 1;
    end if;
    close cuexistesegurovoluntario;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUORDENSEGUROVOLUNTARIO',
                   10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return 0;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return 0;
  END FNUORDENSEGUROVOLUNTARIO;

  /**************************************************************************
  Funcion     :  FNUCAUSALANUDEV
  Descripcion :  Valida si la causal es para identificar las ordenes de
                 seguro voluntario existentes en FNBCR
                 0 - La causal NO tiene relacion con articulo de seguro volunatio
                 1 - La causal tiene relacion con articulo de seguro volunatio
  Autor       :  Jorge Valiente
  Fecha       :  07-06-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUCAUSALANUDEV(nuCausal in number) RETURN NUMBER

   IS

    cursor cuexistecausal is
      SELECT count(1) cantidad
        from CC_CAUSAL cc
       WHERE cc.causal_id = nuCausal
         and (SELECT count(1) cantidad
                FROM DUAL
               WHERE cc.causal_type_id IN
                     (select to_number(column_value)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TIPO_CAUS_ANUL_DEVO_FNBCR',
                                                                                                 NULL),

                                                                ',')))) > 0;

    rfcuexistecausal cuexistecausal%rowtype;

    --Inicio CASO 200-1378
    cursor cuexistecausaltodos is
      SELECT count(1) cantidad
        FROM DUAL
       WHERE nuCausal IN
             (select to_number(column_value)
                from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAUS_ANUL_DEVO_TOTAL_FNBCR',
                                                                                         NULL),

                                                        ',')));

    rfcuexistecausaltodos cuexistecausaltodos%rowtype;
    --Fin CASO 200-1378

    nuEXITOFALLO number := 0;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUCAUSALANUDEV',
                   10);

    open cuexistecausal;
    fetch cuexistecausal
      into rfcuexistecausal;
    if rfcuexistecausal.cantidad = 0 then
      nuEXITOFALLO := 0;
    else
      nuEXITOFALLO := 1;
    end if;
    close cuexistecausal;

    --Inicio CASO 200-1378
    --Cursor para identificar si la causal seleccionada permtira al funcionario
    --seleccionar todas las ordenes par asu anluacion o devolucion
    open cuexistecausaltodos;
    fetch cuexistecausaltodos
      into rfcuexistecausaltodos;
    if rfcuexistecausaltodos.cantidad = 1 then
      nuEXITOFALLO := -1;
    end if;
    close cuexistecausaltodos;
    --Fin CASO 200-1378

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUCAUSALANUDEV', 10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return 0;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return 0;
  END FNUCAUSALANUDEV;

  /**************************************************************************
  Funcion     :  PRACTUALIZAVENTASEGURO
  Descripcion :  Actualiza estado del artiuclo vendido en FIFAP de seguro voluntario
  Autor       :  Jorge Valiente
  Fecha       :  16-05-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  PROCEDURE PRACTUALIZAVENTASEGURO(InuPACKAGE_ID NUMBER,
                                   IsbEstado     VARCHAR2,
                                   InuActividad  NUMBER) AS

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.PRACTUALIZAVENTASEGURO',
                   10);

    update ldc_segurovoluntario ls
       set ls.estado_seguro = IsbEstado
     where package_id = InuPACKAGE_ID;
    --and ORDER_ACTIVITY_ID = InuActividad;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.PRACTUALIZAVENTASEGURO',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
      --return 0;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
      --return 0;
  END PRACTUALIZAVENTASEGURO;

  /**************************************************************************
  Funcion     :  FSBSERGUROVOLUNTARIO
  Descripcion :  Servicio para retornar datos relacionados con el articulo
                 de seguro voluntario
  Autor       :  Jorge Valiente
  Fecha       :  19-06-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FSBSERGUROVOLUNTARIO(InuPACKAGE_ID NUMBER) RETURN VARCHAR2 IS

    cursor cusegurovoluntario is
      SELECT 'Orden[' ||
             daor_order_activity.fnugetorder_id(lsv.order_activity_id, null) ||
             '] - Actividad[' || lsv.order_activity_id || '] - Aticulo[' ||
             lsv.article_id || ' - ' ||
             dald_article.fsbGetDescription(lsv.article_id, null) || ']' SeguroVoluntario
        from ldc_segurovoluntario lsv
       WHERE lsv.package_id = InuPACKAGE_ID;

    rfcusegurovoluntario cusegurovoluntario%rowtype;

    sbEXITOFALLO varchar2(4000) := 'NO TIENE SEGURO VOLUNTARIO';

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FSBSERGUROVOLUNTARIO',
                   10);

    open cusegurovoluntario;
    fetch cusegurovoluntario
      into rfcusegurovoluntario;
    if cusegurovoluntario%found then
      sbEXITOFALLO := rfcusegurovoluntario.segurovoluntario;
    end if;
    close cusegurovoluntario;
    --and ORDER_ACTIVITY_ID = InuActividad;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FSBSERGUROVOLUNTARIO',
                   10);

    return sbEXITOFALLO;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return sbEXITOFALLO;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return sbEXITOFALLO;
  END FSBSERGUROVOLUNTARIO;

  ---FIN CASO 200-1164

  ---Inicio CASO 200-1378
  /**************************************************************************
  Funcion     :  FNUDIFERIDOANUDEV
  Descripcion :  Retorna el diferido asociado al artiuclo relacionado a una
                 venta en FIFAP anulado o devuleto
                 0 - FALLO que NO existe defido asociado
  Autor       :  Jorge Valiente
  Fecha       :  26-07-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUDIFERIDOANUDEV(nuSolicitudVenta in number,
                             nuarticle_id     in number) RETURN NUMBER

   IS

    cursor cuDIFERIDOANUDEV is
      select distinct nvl(l1.difecodi, 0) diferido
        from ld_item_work_order l1
       where l1.order_activity_id in
             (select ooa.order_activity_id
                from open.Or_Order_Activity ooa
               where ooa.package_id = nuSolicitudVenta)
         and l1.article_id = nuarticle_id
         and l1.difecodi is not null
         and rownum = 1;

    rfcuDIFERIDOANUDEV cuDIFERIDOANUDEV%rowtype;

    nuEXITOFALLO number := 0;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUDIFERIDOANUDEV',
                   10);

    open cuDIFERIDOANUDEV;
    fetch cuDIFERIDOANUDEV
      into rfcuDIFERIDOANUDEV;
    close cuDIFERIDOANUDEV;

    nuEXITOFALLO := rfcuDIFERIDOANUDEV.diferido;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUDIFERIDOANUDEV', 10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return 0;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return 0;
  END FNUDIFERIDOANUDEV;

  /**************************************************************************
  Funcion     :  FNUVALORDIFERIDOANUDEV
  Descripcion :  Retorna el valor del diferido asociado al artiuclo relacionado a una
                 venta en FIFAP anulado o devuleto
                 0 - FALLO que NO existe defido asociado
  Autor       :  Jorge Valiente
  Fecha       :  26-07-2017

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/
  FUNCTION FNUVALORDIFERIDOANUDEV(nuSolicitudVenta in number,
                                  nuarticle_id     in number) RETURN NUMBER

   IS

    cursor cuVALORDIFERIDOANUDEV is
      select distinct nvl(d.difevatd, 0) VALOR_DIFERIDO
        from diferido d
       where d.difecodi = (select distinct nvl(l1.difecodi, 0)
                             from ld_item_work_order l1
                            where l1.order_activity_id in
                                  (select ooa.order_activity_id
                                     from open.Or_Order_Activity ooa
                                    where ooa.package_id = nuSolicitudVenta)
                              and l1.article_id = nuarticle_id
                              and l1.difecodi is not null
                              and rownum = 1)
         and rownum = 1;

    rfcuVALORDIFERIDOANUDEV cuVALORDIFERIDOANUDEV%rowtype;

    nuEXITOFALLO number := 0;

  BEGIN

    ut_trace.trace('INICIO LDC_PKVENTASEGUROVOLUNTARIO.FNUVALORDIFERIDOANUDEV',
                   10);

    open cuVALORDIFERIDOANUDEV;
    fetch cuVALORDIFERIDOANUDEV
      into rfcuVALORDIFERIDOANUDEV;
    close cuVALORDIFERIDOANUDEV;

    nuEXITOFALLO := rfcuVALORDIFERIDOANUDEV.VALOR_DIFERIDO;

    ut_trace.trace('FIN LDC_PKVENTASEGUROVOLUNTARIO.FNUVALORDIFERIDOANUDEV',
                   10);

    return nuEXITOFALLO;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      --raise;
      return 0;
    when others then
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
      return 0;
  END FNUVALORDIFERIDOANUDEV;
  ---Fin CASO 200-1378

END LDC_PKVENTASEGUROVOLUNTARIO;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKVENTASEGUROVOLUNTARIO', 'ADM_PERSON'); 
END;
/
GRANT EXECUTE on ADM_PERSON.LDC_PKVENTASEGUROVOLUNTARIO to EXEBRILLAAPP;
GRANT EXECUTE on ADM_PERSON.LDC_PKVENTASEGUROVOLUNTARIO to REXEINNOVA;
/
