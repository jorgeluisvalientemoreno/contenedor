CREATE OR REPLACE PACKAGE "ADM_PERSON"."UT_EAN_CARDIF" IS
  /************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad       : UT_EAN_CARDIF
  Descripcion  : Crear  Archivos EAN para gran superficie (CARDIF) se toma como base el paquete UT_EAN
  Autor        : RCOLPAS
  Fecha        : 18/11/2016

  Historia de Modificaciones
  Fecha         Autor              Modificacion
  ===========   ===============    ===================================================
  22/12/2022	cgonzalez		   OSF-583: Se modifican los metodos CreateEAN_CARDIF_Anul y CreateEAN_CARDIF_Anul_EFI
											para obtener el tipo de causal mediante la parametrizacion de ldc_tipocausalcardif
  20/05/2020    Innovacion         CA-405 --> Se modifican los metodos CreateEAN_CARDIF y CreateEAN_CARDIF_EFI
  18/02/2020    Innovacion         CA-325 --> Se modifican los metodos CreateEAN_CARDIF_Anul y CreateEAN_CARDIF_Anul_EFI
  18/11/2019    Innovacion         CA-238 --> Se modifican los metodos CreateEAN_CARDIF_Anul y CreateEAN_CARDIF_Anul_EFI
  04/07/2018   KARBAQ             200-2023 -> modificaci?n en los procesos <<CreateEAN_CARDIF_Anul>><<CreateEAN_CARDIF>>
  ************************************************************************************/

  --------------------------------------------
  -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
  --------------------------------------------
  TYPE recFTP IS RECORD(
    DIIP VARCHAR2(20), --IP
    USUA VARCHAR2(100), --Usuario
    PAWD VARCHAR2(100), --Password
    RUTA VARCHAR2(500), --Ruta
    DIPE VARCHAR2(20), --IP entrega
    USUE VARCHAR2(100), --Usuario entrega
    PWDE VARCHAR2(100), --Password entrega
    RUTE VARCHAR2(500) --Ruta entrega
    );

  TYPE typtabFTP IS TABLE OF recFTP INDEX BY PLS_INTEGER;
  vtabFTP typtabFTP;
  --------------------------------------------
  -- Variables GLOBALES Y PUBLICAS DEL PAQUETE
  --------------------------------------------

  /*****************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      :  fsbVersion
  Descripcion :  Retorna el numero del sao en que se trabaja el desarrollo
  *******************************************************************************/
  FUNCTION FSBVERSION RETURN VARCHAR2;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : CloseFile
  Descripcion : Cierra el archivo abierto
  ***************************************************************************************/
  PROCEDURE CloseFile(ioFile IN OUT NOCOPY utl_file.file_type);

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : GetConfigDataFTP
  Descripcion : Obtiene la configuracion de conexion con el FTP
  ***************************************************************************************/
  PROCEDURE GetConfigDataFTP(inuSupplierID IN ld_suppli_settings.supplier_id%TYPE,
                             itbDataFtp    OUT typtabFTP);

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : fsbObCad
  Descripcion : Obtiene cadena
  ***************************************************************************************/
  FUNCTION fsbObCad(isbCad IN VARCHAR2,
                    isbDel IN VARCHAR2,
                    inuIn  IN NUMBER) RETURN VARCHAR2;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : Connect_FTP
  Descripcion : Establece conexion con el FTP
  ***************************************************************************************/
  PROCEDURE Connect_FTP(itbDataFtp  IN typtabFTP,
                        inuIndexFtp IN NUMBER,
                        ftpConn     OUT utl_tcp.connection);

  FUNCTION GetEquiPosID(inuSupplierID IN ge_contratista.id_contratista%TYPE)
    RETURN ld_pos_settings.equivalence%TYPE;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : Connect_FTP
  Descripcion :
  ***************************************************************************************/
  PROCEDURE CopyToFTP(isbDiIP IN VARCHAR2,
                      isbUsua IN VARCHAR2,
                      isbPawd IN VARCHAR2,
                      isbArch IN VARCHAR2,
                      isbPath IN VARCHAR2);

  PROCEDURE CreateFileEAN_CARDIF(isbContent  IN VARCHAR2,
                                 isbFileName IN VARCHAR2,
                                 ioFile      IN OUT NOCOPY utl_file.file_type);

  PROCEDURE CreateEAN_CARDIF;
  PROCEDURE CreateEAN_CARDIF_Anul;

  --caso 200-2645(Inicio)
  PROCEDURE CreateEAN_CARDIF_EFI;

  PROCEDURE CreateEAN_CARDIF_Anul_EFI;
  --caso 200-2645(Fin)
END UT_EAN_CARDIF;
/
CREATE OR REPLACE PACKAGE BODY "ADM_PERSON"."UT_EAN_CARDIF" IS
  /************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad       : UT_EAN_CARDIF
  Descripcion  : Crear  Archivos EAN para gran superficie (CARDIF) se toma como base el paquete UT_EAN
  Autor        : RCOLPAS
  Fecha        : 11/15/2013 10:07:32 AM

  Historia de Modificaciones
  Fecha         Autor              Modificacion
  ===========   ================   ===================================================
  22/12/2022	cgonzalez		   OSF-583: Se modifican los metodos CreateEAN_CARDIF_Anul y CreateEAN_CARDIF_Anul_EFI
											para obtener el tipo de causal mediante la parametrizacion de ldc_tipocausalcardif
  20/05/2020    Innovacion         CA-405 --> Se modifican los metodos CreateEAN_CARDIF y CreateEAN_CARDIF_EFI
  18/11/2019    Innovacion         CA-238 --> Se modifican los metodos CreateEAN_CARDIF_Anul y CreateEAN_CARDIF_Anul_EFI
  04/07/2018   KARBAQ             200-2023 -> Se modifica para colocarle RWSegVol.Codproducto, en vez del tipo de producto
                                  en los procesos <<CreateEAN_CARDIF_Anul>><<CreateEAN_CARDIF>>

  ************************************************************************************/

  --------------------------------------------
  -- Constantes VERSION DEL PAQUETE
  --------------------------------------------
  csbVERSION      CONSTANT VARCHAR2(10) := 'OSF-583';
  csbFolderOracle CONSTANT VARCHAR2(50) := '/tmp';
  MI_DIR          CONSTANT VARCHAR2(30) := 'DI_RATING_DIRECTORY';
  --------------------------------------------
  -- Constantes PRIVADAS DEL PAQUETE
  --------------------------------------------

  --------------------------------------------
  -- Variables PRIVADAS DEL PAQUETE
  --------------------------------------------

  --------------------------------------------
  -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
  --------------------------------------------

  FUNCTION FSBVERSION RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : CreateEAN_CARDIF
  Descripcion : Crea archivo plano para el proceso de CARDIF
  Autor       : RCOLPAS
  Fecha       : 17/11/2016

  Parametros  :
  Entrada
   isbContent  ==>    Contenido a quemar en el archivo plano
   isbFileName ==>    Nombre del Archivo Plano
   ioPathFile  ==>    Ruta de salida del archivo

  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  20/05/2020   Innovacion         Ca 405 -- Se incluyen nuevos campos cardif
  17/05/2018   JOSDON             200-1927 -> Se modifica la columna 25 donde se enviaba el n?mero de producto crediticio con el dato de n?mero de pagar?
                                  para enviar el c?digo de contrato donde se realiz? la venta del seguro voluntario reportado.
  10/10/2018   Daniel Valiente    Se Agregara la validacion de los Diferidos y se establecera el
                                  envio de correo para las ordenes no validas (200-2193)
  30/10/2018   Daniel Valiente    Se valida los mensajes de Error por Conexion y secuencias especificas
                                  (200-2193)
  26/12/2018   Daniel Valiente    Se agrego el control para el tama?o de la direccion del asegurado (200-2162)
  14/02/2019   Jorge Valiente     CASO 200-2422 Modificar el proceso de para estblecer el cursor para consultar en la entidad
                                                cc_grace_peri_defe si el articulo CARDIF fue vendida en un periodo de gracia.
                                                Por solicitud del Ing Samuel Pacheco se acualiza el campo FINVIGENCIA de la entidad
                                                LDC_SEGUROVOLUNTARIO par aactuaalizar el campo de fecha de vigencia del periodo de CARDIF
  ***************************************************************************************/
  PROCEDURE CreateEAN_CARDIF IS
    FileLines             VARCHAR2(4000) := '';
    csbApplicationPOS     VARCHAR2(4) := '9865';
    csbDateNow            VARCHAR2(6) := to_char(SYSDATE, 'YYMMDD');
    csbFileNameEAN_CARDIF VARCHAR2(100) := '520CO87PR062' ||
                                           to_char(SYSDATE, 'YYYYMMDD');
    nuOrderDel            or_order.order_id%type;
    vrgOrdetrab           daor_order.styOR_order;
    nuSupplierID          ld_suppli_settings.supplier_id%TYPE;
    ftpConn               utl_tcp.connection;
    ioRecordFile          utl_file.file_type;
    inuCodeEquiPOS        LD_POS_SETTINGS.EQUIVALENCE%TYPE;

    nuType    Number := 6201;
    nuTypeDoc Number := 1;
    nuIdent   ld_promissory.identification%type;
    sbName    ld_promissory.debtorname%type;
    sbPhone   ld_promissory.propertyphone_id%type;
    sbPagare  ld_non_ba_fi_requ.digital_prom_note_cons%type;
    -- sbCodConvenio       LD_parameter.Value_Chain%type := dald_parameter.fsbGetValue_Chain('COD_INTERNO_CARDIF_CONV_FNB');
    nuSequence_id       ld_bine_cencosud.sequence_id%type;
    nusale_value_financ ld_bine_cencosud.sale_value_financ%type;
    nuOperUnit          OR_Order.Operating_Unit_Id%type;
    sbSalePoint         OR_Operating_Unit.Name%type;
    VNUTIPOCED          NUMBER;
    VNUtidocaid         NUMBER;
    v_archivo           utl_file.file_type;
    sw                  NUMBER := 0;
    sw2                 NUMBER := 0;
    vnucon              NUMBER := 1;
    vexar               NUMBER := 1;

    --200-2193
    contador         number;
    continuarL       number := 0;
    list_ventas1     varchar2(4000) := NULL;
    list_ventas2     varchar2(4000) := NULL;
    list_ventas3     varchar2(4000) := NULL;
    list_ventas4     varchar2(4000) := NULL;
    list_ventas5     varchar2(4000) := NULL;
    temp_list_ventas varchar2(200) := NULL;
    Vcorreo          ld_parameter.value_chain%TYPE;
    vsbSendEmail     ld_parameter.value_chain%TYPE;
    --
    continuarE    number := 0;
    list_err1     varchar2(4000) := NULL;
    list_err2     varchar2(4000) := NULL;
    list_err3     varchar2(4000) := NULL;
    list_err4     varchar2(4000) := NULL;
    list_err5     varchar2(4000) := NULL;
    temp_list_err varchar2(200) := NULL;
    swIngreso     number := 0;
    msj_err       varchar2(4000) := NULL;
    --
    --

    CURSOR cuSegVol IS
      SELECT *
        FROM OPEN.LDC_SEGUROVOLUNTARIO
       WHERE FILE_NAME_VENTA IS NULL
         AND DIFECODI IS NOT NULL
         and estado_seguro = 'RE'
      /*and rownum < 10*/
      ;
    /*and segurovoluntario_id in
    (11, 12, 13, 14, 15, 16, 17, 18, 19, 20)*/

    -- (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

    /*Caso 200-1537 Consulta de valor de la cuota credito*/
    cursor cuvalorcuotacredito(InuPACKAGE_ID ldc_segurovoluntario.package_id%type) is
      SELECT NVL(SUM(di.difevacu), 0)
        FROM open.or_order_activity  oa,
             open.ld_item_work_order li,
             open.diferido           di
       WHERE oa.activity_id =
             open.dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB') --4000822
         AND oa.order_activity_id = li.order_activity_id
         AND oa.package_id = InuPACKAGE_ID
         AND li.article_id NOT IN
             (SELECT l.article_id
                FROM open.LD_ARTICLE L
               WHERE L.Concept_Id IN
                     (select nvl(to_number(column_value), 0)
                        from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                           NULL),
                                                                     ','))))
         AND di.difecodi = li.difecodi;

    --PRAGMA AUTONOMOUS_TRANSACTION;

    --CASO 200-2422
    cursor cucc_grace_peri_defe(Inudeferred_id cc_grace_peri_defe.deferred_id%type) is
      select d.*,
             round(MONTHS_BETWEEN(trunc(end_date), trunc(initial_date)), 0) MESES
        from cc_grace_peri_defe d
       where d.deferred_id = Inudeferred_id;

    rfcucc_grace_peri_defe cucc_grace_peri_defe%rowtype;

    --------------------------
    -- CAMBIO 235 -->
    --------------------------
    cursor cuCuotaVenta(InuContract number, InuPACKAGE number) is
      select nvl(sum(df.difevacu), 0) cuota
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

    --------------------------
    -- CAMBIO 405 -->
    --------------------------
    cursor cuDatosContratista(inuVenta ldc_segurovoluntario.package_id%type) is
      select SUBSTR(cont.nombre_contratista, 1, 26) contratista,
             SUBSTR(su.identification, 1, 12) nit
        from open.ge_contratista cont
        left join open.ge_subscriber su
          on su.subscriber_id = cont.subscriber_id
       where cont.id_contratista =
             daor_operating_unit.fnugetcontractor_id(damo_packages.fnugetoperating_unit_id(inuVenta,
                                                                                         0),
                                                     0);

    sbDepartamento varchar2(12);
    sbNitProveedor varchar2(12);
    sbSucursal     varchar2(26);

    --------------------------
    -- CAMBIO 405 <--
    --------------------------

    sbFechaVigencia varchar2(4000);
    dtFechaVigencia date;
    --CASO 200-2422

    --200-2389
    DTinicioVigencia date;
    plazoCredito     number;

  BEGIN
    ut_trace.trace('INICIA UT_EAN.CreateEAN_CARDIF', 2);
    --valida el consecutivo del archivo a envier

    SELECT count(*)
      into vexar
      FROM LDC_SEGUROVOLUNTARIO
     where trunc(date_file_name_venta) = trunc(sysdate)
       and DIFECODI IS NOT NULL
       and estado_seguro = 'RE';

    if vexar <> 0 then
      SELECT max(substr(FILE_NAME_VENTA, length(FILE_NAME_VENTA) - 5, 2)) + 1
        into vnucon
        FROM LDC_SEGUROVOLUNTARIO
       where trunc(date_file_name_venta) = trunc(sysdate)
         and DIFECODI IS NOT NULL
         and estado_seguro = 'RE';

    elsif vexar = 0 then
      vnucon := 0;
    end if;

    FOR RWSegVol IN cuSegVol LOOP

      nuExistsTV := null;

      --200-2193 - Validacion de errores en el DIFECODI
      SELECT count(*)
        into contador
        FROM LDC_SEGUROVOLUNTARIO sv, diferido di
       WHERE sv.segurovoluntario_id = RWSegVol.segurovoluntario_id
         and sv.difecodi = di.difecodi;

      if contador = 1 then

        Dbms_Output.Put_Line('Venta Valida: ' ||
                             RWSegVol.segurovoluntario_id);
        --codigo original del paquete
        --Establece conexion con el FTP
        swIngreso := 1;
        -- sw := 0;
        begin
          if sw = 0 then
            --Obtiene el idenficador del proveedor CARDIF
            nuSupplierID := RWSegVol.Contractor_Id;
            --Obtiene configuracion para conexion con el FTP
            GetConfigDataFTP(nuSupplierID, vtabFTP);
            --Establece conexion con el FTP
            Connect_FTP(vtabFTP, nuSupplierID, ftpConn);
            --NomArchivo:=csbFileNameEAN_CARDIF;
            v_archivo := utl_file.fopen(csbFolderOracle,
                                        csbFileNameEAN_CARDIF ||
                                        lpad(vnucon, 2, 0) || '.txt',
                                        'w');

            sw := 1;
          end if;

          FileLines := null;
          --   segurovoluntario_id, geograp_location_depa, geograp_location_loca, susccodi, package_id, product_id, article_id, difecodi, contractor_id, tarifa, codproducto,,,,,,,,,,,,,,,,,

          /*open cuDeudoFNB(inuPackageID);
          fetch cuDeudoFNB
            INTO nuIdent, sbName, sbPhone;
          close cuDeudoFNB;*/

          --Hallamos el numero de pagare
          /*      sbPagare := nvl(dald_non_ba_fi_requ.fsbgetdigital_prom_note_cons(inuPackageID),
          dald_non_ba_fi_requ.fsbGetManual_Prom_Note_Cons(inuPackageID));*/

          ----
          -- unidad operativa
          /* nuOperUnit := DAOR_Order.fnuGetOperating_Unit_Id(nuOrderDel);*/

          --  Punto de venta
          /*sbSalePoint := DAOR_Operating_Unit.fsbGetName(nuOperUnit);*/
          ----
          /*Hallar la sequencia del documento BINE para la solicitud*/
          /* select sequence_id, sale_value_financ
           into nuSequence_id, nusale_value_financ
           from ld_bine_cencosud
          where package_id = inuPackageID;*/

          select escicaid
            INTO VNUTIPOCED
            from ldc_eq_esta_civi_cardif D
           WHERE D.esciosfid = nvl(RWSegVol.estado_civil, 1)
             AND ROWNUM = 1;

          select tidocaid
            INTO VNUtidocaid
            from ldc_eq_tipo_docu_cardif
           WHERE tidosfid = nvl(RWSegVol.tipoidasegurado, 1)
             AND ROWNUM = 1;

          -------------------------
          -- CAMBIO 325 -->
          -------------------------
          --Se restablece logica bajo el cambio 405
          ------------------------------------
          -- CAMBIO 405
          -- Este cambio valida si la venta a registrar es televenta o no
          -- (Se identifica una televenta si tiene al menos un articulo cargado diferente de cardif).
          -- Si lo es, modifica el valor de la cuota de credito a cargar en el archivo.
          -- Si no, guarda los valores de manera habitual.
          ------------------------------------

          open cuTeleVentas(RWSegVol.package_id);
          fetch cuTeleVentas
            into nuExistsTV;
          close cuTeleVentas;

          if nuExistsTV > 0 then
            /*Caso 200-1537*/
            open cuvalorcuotacredito(RWSegVol.package_id);
            fetch cuvalorcuotacredito
              into RWSegVol.valorcuotacredito;
            close cuvalorcuotacredito;
            --Configura Linea para agregar al documento
          elsif nuExistsTV = 0 then
            open cuCuotaVenta(RWSegVol.Susccodi, RWSegVol.package_id);
            fetch cuCuotaVenta
              into RWSegVol.valorcuotacredito;
            close cuCuotaVenta;
          else
            null;
          end if;
          -------------------------
          -- CAMBIO 325 <--
          -------------------------

          --caso 200-2389 - Cambio de inicio y fin de vigencia, plazo de Crdeito
          SELECT o.legalization_date, mdf.credit_fees
            into DTinicioVigencia, plazoCredito
            FROM open.or_order           o,
                 open.or_order_activity  oa,
                 OPEN.LD_ITEM_WORK_ORDER MDF
           where oa.package_id = RWSegVol.package_id
             and oa.order_id = o.order_id
             and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
             and o.task_type_id =
                 dald_parameter.fnuGetNumeric_Value('CODI_TITR_EFNB')
             and MDF.Article_Id in (RWSegVol.Article_Id)
          --and o.operating_unit_id = 2512 --retirado de la consulta principal por solicitud del ing samuel pacheco
          ;

          --CASO 200-2422
          --200-2389 cambio de inicio y fin de vigencia
          sbFechaVigencia := to_char(DTinicioVigencia, 'DDMMYYYY'); --to_char(RWSegVol.finvigencia, 'DDMMYYYY');
          dtFechaVigencia := ADD_MONTHS(DTinicioVigencia, plazoCredito) +
                             NVL(DALD_PARAMETER.fnuGetNumeric_Value('CANT_DIAS_FECH_VIG_SEG_VOL',
                                                                    NULL),
                                 0); --RWSegVol.finvigencia;
          --Cursor para validar si el diferido fue definido en un periodo de gracia
          open cucc_grace_peri_defe(RWSegVol.Difecodi);
          fetch cucc_grace_peri_defe
            into rfcucc_grace_peri_defe;
          if cucc_grace_peri_defe%found then
            if rfcucc_grace_peri_defe.initial_date is not null and
               rfcucc_grace_peri_defe.end_date is not null then
              sbFechaVigencia := to_char(ADD_MONTHS(dtFechaVigencia, --RWSegVol.finvigencia,
                                                    rfcucc_grace_peri_defe.meses),
                                         'DDMMYYYY');
              dtFechaVigencia := ADD_MONTHS(dtFechaVigencia, --RWSegVol.finvigencia,
                                            rfcucc_grace_peri_defe.meses);
            end if;
          end if;
          close cucc_grace_peri_defe;
          --CASO 200-2422

          -------------------------
          -- CAMBIO 405 -->
          -------------------------
          --Se obtienen datos del contratista para incluir al archivo
          open cuDatosContratista(RWSegVol.Package_Id);
          fetch cuDatosContratista
            into sbSucursal, sbNitProveedor;
          close cuDatosContratista;
          --Se obtiene nombre del departamento para incluir al archivo.
          sbDepartamento := SUBSTR(dage_geogra_location.fsbgetdescription(RWSegVol.Geograp_Location_Depa),
                                   1,
                                   12);
          -------------------------
          -- CAMBIO 405 <--
          -------------------------

          FileLines := RWSegVol.Codproducto /*nuType se cambio en caso 200-2023*/
                       || ';' ||
                      --200-2389 cambio
                       to_char(DTinicioVigencia, 'DDMMYYYY') || ';' || --to_char(RWSegVol.iniciovigencia, 'DDMMYYYY') || ';' ||
                      /*to_char(RWSegVol.finvigencia, 'DDMMYYYY')*/
                       to_char(dtFechaVigencia, 'DDMMYYYY') || ';' ||
                       RWSegVol.plancardif || ';' || VNUtidocaid || ';' ||
                       RWSegVol.idasegurado || ';' ||
                       RWSegVol.primerapellidoasegurado || ';' ||
                       RWSegVol.segundoapellidoasegurado || ';' ||
                       RWSegVol.primernombreasegurado || ';' ||
                       RWSegVol.segundonombreasegurado || ';' ||
                       RWSegVol.genero_asegurado || ';' || VNUTIPOCED || ';' ||
                       to_char(RWSegVol.fecnacimientoasegurado, 'DDMMYYYY') || ';' ||
                       RWSegVol.telasegurado || ';' ||
                       RWSegVol.celasegurado || ';' ||
                      --RWSegVol.direccionasegurado || ';' ||
                      --Caso 200-2162 Restriccion de la Longitud del Campo
                      --La longitud maxima del campo lo define el parametro PAR_LONG_DIR_CARDIF
                       SUBSTR(RWSegVol.direccionasegurado,
                              1,
                              open.dald_parameter.fnuGetNumeric_Value('PAR_LONG_DIR_CARDIF')) || ';' ||
                      --
                       RWSegVol.ciudadasegurado || ';' ||
                       RWSegVol.nacionalidad || ';' ||
                       RWSegVol.pais_residencia || ';' ||
                       RWSegVol.pais_nacimiento_asegurado || ';' ||
                       RWSegVol.emailasegurado || ';' ||
                       RWSegVol.prima_antes_iva || ';' ||
                       RWSegVol.prima_iva_incluido || ';' ||
                       RWSegVol.codigoproductobancario || ';' ||
                       RWSegVol.SUSCCODI || ';' || --Modificado en el caso 200-1927
                       RWSegVol.package_id || ';;;' ||
                       RWSegVol.plazocredito || ';' ||
                       RWSegVol.valorcredito || ';' ||
                       RWSegVol.valorcuotacredito || ';' || RWSegVol.canal || ';' ||
                       RWSegVol.codigoasesor || ';' ||
                       RWSegVol.documentoasesor || ';' ||
                       RWSegVol.nombreasesor || ';' || --RWSegVol.sucursal;
                      ---NUEVOS CAMPOS CAMBIO 405
                       sbSucursal || ';' || sbDepartamento || ';' ||
                       sbNitProveedor;
          --31/10/18 DVM Se pasa al final de la secuencia para control de validacion
          --utl_file.put_line(v_archivo, FileLines);
          update ldc_segurovoluntario
             set /* segurovoluntario_id = v_segurovoluntario_id,
                  geograp_location_depa = v_geograp_location_depa,
                 geograp_location_loca = v_geograp_location_loca,
                 susccodi = v_susccodi,
                 package_id = v_package_id,*/ product_id = pktbldiferido.fnugetdifenuse(difecodi),
                 /* article_id = v_article_id,
                 difecodi = v_difecodi,
                 contractor_id = v_contractor_id,
                 tarifa = v_tarifa,
                 codproducto = v_codproducto,
                 iniciovigencia = v_iniciovigencia,*/
                 --CASO 200-2422
                 --finvigencia = dtFechaVigencia, --v_finvigencia,
                 --CASO 200-2422
                 --200-2389 actualizacion fecha
                 iniciovigencia = DTinicioVigencia,
                 finvigencia    = dtFechaVigencia,
                 /*
                 plancardif = v_plancardif,
                 tipoidasegurado = v_tipoidasegurado,
                 idasegurado = v_idasegurado,
                 primerapellidoasegurado = v_primerapellidoasegurado,
                 segundoapellidoasegurado = v_segundoapellidoasegurado,
                 primernombreasegurado = v_primernombreasegurado,
                 segundonombreasegurado = v_segundonombreasegurado,
                 genero_asegurado = v_genero_asegurado,
                 estado_civil = v_estado_civil,
                 fecnacimientoasegurado = v_fecnacimientoasegurado,
                 telasegurado = v_telasegurado,
                 celasegurado = v_celasegurado,
                 direccionasegurado = v_direccionasegurado,
                 ciudadasegurado = v_ciudadasegurado,
                 nacionalidad = v_nacionalidad,
                 pais_residencia = v_pais_residencia,
                 pais_nacimiento_asegurado = v_pais_nacimiento_asegurado,
                 emailasegurado = v_emailasegurado,
                 prima_antes_iva = v_prima_antes_iva,
                 prima_iva_incluido = v_prima_iva_incluido,
                 codigoproductobancario = v_codigoproductobancario,
                 numeroproductocrediticio = v_numeroproductocrediticio,
                 plazocredito = v_plazocredito,
                 valorcredito = v_valorcredito,*/
                 valorcuotacredito    = RWSegVol.valorcuotacredito, /*
                                                                                                      canal = v_canal,
                                                                                                      codigoasesor = v_codigoasesor,
                                                                                                      documentoasesor = v_documentoasesor,
                                                                                                      nombreasesor = v_nombreasesor,
                                                                                                      sucursal = v_sucursal,
                                                                                                      estado_seguro = v_estado_seguro,
                                                                                                      package_anu_dev = v_package_anu_dev,*/
                 file_name_venta      = csbFileNameEAN_CARDIF ||
                                        lpad(vnucon, 2, 0) || '.txt',
                 date_file_name_venta = sysdate
          /*file_name_anul = v_file_name_anul,
          date_file_name_anul = v_date_file_name_anul,
          causal_anulacion_devolucion = v_causal_anulacion_devolucion,
          refinanciado = v_refinanciado,
          order_activity_id = v_order_activity_id*/
           where segurovoluntario_id = RWSegVol.segurovoluntario_id;

          --Agrega linea en documento
          --CreateFileEAN_CARDIF(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
          --  LD_BOPACKAGEFNB.proWriteFile(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
          --
          /*if RWSegVol.segurovoluntario_id > 76 then
            vexar := 10 / 0;
          else*/
          utl_file.put_line(v_archivo, FileLines);
          /*end if;*/

        EXCEPTION
          WHEN OTHERS THEN
            Dbms_Output.Put_Line('Venta Con Error: ' ||
                                 RWSegVol.segurovoluntario_id);
            /*Dbms_Output.Put_Line('Error al procesar la Venta: Venta [' || RWSegVol.segurovoluntario_id ||
            '] Solicitud [' || RWSegVol.package_id ||
            '] Suscripcion [' || RWSegVol.SUSCCODI ||
            '] Diferido [' || RWSegVol.DIFECODI || ']<br>');*/
            continuarE := 1;
            if list_err1 IS NOT NULL then
              if length(list_err1) > 3900 then
                continuarE := 2;
              end if;
            end if;
            if list_err2 IS NOT NULL then
              if length(list_err2) > 3900 then
                continuarE := 3;
              end if;
            end if;
            if list_err3 IS NOT NULL then
              if length(list_err3) > 3900 then
                continuarE := 4;
              end if;
            end if;
            if list_err4 IS NOT NULL then
              if length(list_err4) > 3900 then
                continuarE := 5;
              end if;
            end if;
            if sw = 0 then
              temp_list_err := 'Error [Problemas al Conectar con el Servidor FTP.] al procesar la Venta: Venta [' ||
                               RWSegVol.segurovoluntario_id ||
                               '] Solicitud [' || RWSegVol.package_id ||
                               '] Suscripcion [' || RWSegVol.SUSCCODI ||
                               '] Diferido [' || RWSegVol.DIFECODI ||
                               ']<br>';
            else
              temp_list_err := 'Error al procesar la Venta: Venta [' ||
                               RWSegVol.segurovoluntario_id ||
                               '] Solicitud [' || RWSegVol.package_id ||
                               '] Suscripcion [' || RWSegVol.SUSCCODI ||
                               '] Diferido [' || RWSegVol.DIFECODI ||
                               ']<br>';
            end if;
            if continuarE = 1 then
              list_err1 := list_err1 || temp_list_err;
            end if;
            if continuarE = 2 then
              list_err2 := list_err2 || temp_list_err;
            end if;
            if continuarE = 3 then
              list_err3 := list_err3 || temp_list_err;
            end if;
            if continuarE = 4 then
              list_err4 := list_err4 || temp_list_err;
            end if;
            if continuarE = 5 then
              list_err5 := list_err5 || temp_list_err;
            end if;
            --Errors.setError;
          --raise ex.CONTROLLED_ERROR;
          --null;
        end;
      else
        Dbms_Output.Put_Line('Venta No Valida: ' ||
                             RWSegVol.segurovoluntario_id);
        --codigo de registro del error (requerido para la Parte II)
        continuarL := 1;
        if list_ventas1 IS NOT NULL then
          if length(list_ventas1) > 3900 then
            continuarL := 2;
          end if;
        end if;
        if list_ventas2 IS NOT NULL then
          if length(list_ventas2) > 3900 then
            continuarL := 3;
          end if;
        end if;
        if list_ventas3 IS NOT NULL then
          if length(list_ventas3) > 3900 then
            continuarL := 4;
          end if;
        end if;
        if list_ventas4 IS NOT NULL then
          if length(list_ventas4) > 3900 then
            continuarL := 5;
          end if;
        end if;
        temp_list_ventas := 'Venta con Diferido No Valido: Venta [' ||
                            RWSegVol.segurovoluntario_id || '] Solicitud [' ||
                            RWSegVol.package_id || '] Suscripcion [' ||
                            RWSegVol.SUSCCODI || '] Diferido [' ||
                            RWSegVol.DIFECODI || ']<br>';
        if continuarL = 1 then
          list_ventas1 := list_ventas1 || temp_list_ventas;
          --Dbms_Output.Put_Line(list_ventas1);
        end if;
        if continuarL = 2 then
          list_ventas2 := list_ventas2 || temp_list_ventas;
        end if;
        if continuarL = 3 then
          list_ventas3 := list_ventas3 || temp_list_ventas;
        end if;
        if continuarL = 4 then
          list_ventas4 := list_ventas4 || temp_list_ventas;
        end if;
        if continuarL = 5 then
          list_ventas5 := list_ventas5 || temp_list_ventas;
        end if;
        --modificacion del registro DIFECODI a NULO de la venta
        UPDATE LDC_SEGUROVOLUNTARIO sv
           SET sv.difecodi = NULL
         WHERE sv.segurovoluntario_id = RWSegVol.segurovoluntario_id;

      end if;
      sw2 := 1;
    END LOOP;
    -- Modificacion Caso 200-2645 (Inicio) En caso de que no ayan soluciotudes se enviara un correo
    if (sw2 = 0) then
      Dbms_Output.Put_Line('Envio de Correo');
      Dbms_Output.Put_Line('Mensaje: ' ||
                           'No hay registro de venta CARDIF');
      --Envio de correo con los erroneos
      Vcorreo := dald_parameter.fsbGetValue_Chain('PAR_MAIL_CARDIF_ED');
      --identifica parametro de correo de envio osf
      vsbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');

      if Vcorreo is not null or vsbSendEmail is not null then
        --SE ENVIA CORREO DE NOTIFICACION
        ld_bopackagefnb.prosendemail(isbsender     => vsbSendEmail,
                                     isbrecipients => Vcorreo,
                                     isbsubject    => 'No hay registro de venta CARDIF- ' ||
                                                      to_char(SYSDATE,
                                                              'DD-MM-YYYY HH24:MI:SS'),
                                     isbmessage    => 'No hay registro de venta CARDIF',
                                     isbfilename   => null);
      else
        Dbms_Output.Put_Line('Error al Enviar el Correo');
      end if;

    end if;
    -- Modificacion Caso 200-2645 (Fin)

    if list_ventas1 IS NOT NULL or list_err1 IS NOT NULL then
      /*Dbms_Output.Put_Line('Mensaje: ' || list_ventas1 ||
      list_ventas2 ||
      list_ventas3 ||
      list_ventas4 ||
      list_ventas5 ||
      list_err1 ||
      list_err2 ||
      list_err3 ||
      list_err4 ||
      list_err5);*/
      --Envio de correo con los registros erroneos
      Vcorreo := dald_parameter.fsbGetValue_Chain('PAR_MAIL_CARDIF_ED');
      --identifica parametro de correo de envio osf
      vsbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');
      --SE ENVIA CORREO DE NOTIFICACION
      if Vcorreo is not null and vsbSendEmail is not null then
        Dbms_Output.Put_Line('Envio de Correo');
        ld_bopackagefnb.prosendemail(isbsender     => vsbSendEmail,
                                     isbrecipients => Vcorreo,
                                     isbsubject    => 'Ventas Erroneas en CARDIF - ' ||
                                                      to_char(SYSDATE,
                                                              'DD-MM-YYYY HH24:MI:SS'),
                                     isbmessage    => list_ventas1 ||
                                                      list_ventas2 ||
                                                      list_ventas3 ||
                                                      list_ventas4 ||
                                                      list_ventas5 ||
                                                      list_err1 || list_err2 ||
                                                      list_err3 || list_err4 ||
                                                      list_err5,
                                     isbfilename   => null);
      else
        Dbms_Output.Put_Line('Error al Enviar el Correo');
      end if;
    end if;

    if sw != 0 then
      Dbms_Output.Put_Line('Copia de archivo EAN a FTP Externo');
      utl_file.fclose(v_archivo);
      ftp.logout(ftpConn);
      utl_tcp.close_all_connections;

      --Copia el archivo EAN a Ftp Externo
      CopyToFTP(vtabFTP(nuSupplierID).DIIP,
                vtabFTP(nuSupplierID).USUA,
                vtabFTP(nuSupplierID).PAWD,
                csbFileNameEAN_CARDIF || lpad(vnucon, 2, 0) || '.txt',
                vtabFTP(nuSupplierID).RUTA);

    end if;
    ut_trace.trace('FIN UT_EAN.CreateEAN_CARDIF', 2);

  EXCEPTION
    WHEN OTHERS THEN
      msj_err := DBMS_UTILITY.FORMAT_ERROR_STACK || '<br>' ||
                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '<br>' || sqlerrm;
      IF sw = 0 and swIngreso = 1 then
        msj_err := msj_err ||
                   '<br>Problemas al Conectar con el Servidor FTP.';
      end if;
      Dbms_Output.Put_Line('Envio de Correo');
      Dbms_Output.Put_Line('Mensaje: ' || msj_err);
      --Envio de correo con los erroneos
      Vcorreo := dald_parameter.fsbGetValue_Chain('PAR_MAIL_CARDIF_ED');
      --identifica parametro de correo de envio osf
      vsbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');
      --SE ENVIA CORREO DE NOTIFICACION
      if Vcorreo is not null or vsbSendEmail is not null then
        ld_bopackagefnb.prosendemail(isbsender     => vsbSendEmail,
                                     isbrecipients => Vcorreo,
                                     isbsubject    => 'Errores en el CARDIF - ' ||
                                                      to_char(SYSDATE,
                                                              'DD-MM-YYYY HH24:MI:SS'),
                                     isbmessage    => msj_err,
                                     isbfilename   => null);
      else
        Dbms_Output.Put_Line('Error al Enviar el Correo');
      end if;
      --
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
  END CreateEAN_CARDIF;

  PROCEDURE CreateEAN_CARDIF_Anul IS
    FileLines             VARCHAR2(4000) := '';
    csbApplicationPOS     VARCHAR2(4) := '9865';
    csbDateNow            VARCHAR2(6) := to_char(SYSDATE, 'YYMMDD');
    csbFileNameEAN_CARDIF VARCHAR2(100) := '520CO87NR062' ||
                                           to_char(SYSDATE, 'YYYYMMDD');
    nuOrderDel            or_order.order_id%type;
    vrgOrdetrab           daor_order.styOR_order;
    nuSupplierID          ld_suppli_settings.supplier_id%TYPE;
    ftpConn               utl_tcp.connection;
    ioRecordFile          utl_file.file_type;
    inuCodeEquiPOS        LD_POS_SETTINGS.EQUIVALENCE%TYPE;

    nuType    Number := 6201;
    nuTypeDoc Number := 1;
    nuIdent   ld_promissory.identification%type;
    sbName    ld_promissory.debtorname%type;
    sbPhone   ld_promissory.propertyphone_id%type;
    sbPagare  ld_non_ba_fi_requ.digital_prom_note_cons%type;
    -- sbCodConvenio       LD_parameter.Value_Chain%type := dald_parameter.fsbGetValue_Chain('COD_INTERNO_CARDIF_CONV_FNB');
    nuSequence_id       ld_bine_cencosud.sequence_id%type;
    nusale_value_financ ld_bine_cencosud.sale_value_financ%type;
    nuOperUnit          OR_Order.Operating_Unit_Id%type;
    sbSalePoint         OR_Operating_Unit.Name%type;
    VNUTIPOCED          NUMBER;
    VNUtidocaid         NUMBER;
    v_archivo           utl_file.file_type;
    sw                  NUMBER := 0;
    sw2                 NUMBER := 0;
    vnucon              NUMBER := 1;
    vexar               NUMBER := 1;

    CURSOR cuSegVol IS
      SELECT *
        FROM LDC_SEGUROVOLUNTARIO
       WHERE file_name_anul IS NULL
         AND DIFECODI IS NOT NULL
         and estado_seguro in ('DE', 'AN')
      /*and segurovoluntario_id in
      (11, 12, 13, 14, 15, 16, 17, 18, 19, 20)*/
      ;
    -- (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

    ---cursor para identificar causal y fecha de atencion
    --de solicitud de anulacion o devolucion
    cursor cusolicitudAD(inupackage_sale number) is
      SELECT mo_motive.causal_id IdCausal, --DVM 200-2389 Se retorna la causal para validar su nuevo valor --decode(mo_motive.causal_id, 274, 22, 21) IdCausal,
             to_char(damo_packages.fdtgetattention_date(ld_return_item.package_id),
                     'YYYYMMDD') Fecha_Atencion_SolicitudAD,
             ld_return_item.package_id SolicitudAD
        FROM ld_item_work_order,
             ld_return_item_detail,
             ld_return_item,
             OR_order_activity,
             ld_article,
             mo_motive,
             cc_causal,
             ld_non_ban_fi_item
       WHERE ld_item_work_order.order_activity_id =
             ld_return_item_detail.activity_delivery_id
         AND ld_return_item_detail.return_item_id =
             ld_return_item.return_item_id
         AND ld_article.article_id = ld_return_item_detail.article_id
         AND ld_item_work_order.article_id =
             ld_return_item_detail.article_id
         AND OR_order_activity.order_activity_id =
             ld_item_work_order.order_activity_id
         AND OR_order_activity.activity_id =
             dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB')
         AND ld_return_item.package_id = mo_motive.package_id
         AND cc_causal.causal_id = mo_motive.causal_id
         AND ld_non_ban_fi_item.non_ba_fi_requ_id =
             ld_return_item.package_sale
         AND ld_non_ban_fi_item.article_id =
             ld_return_item_detail.article_id
         and ld_return_item.package_sale = inupackage_sale
         and damo_packages.fnugetmotive_status_id(ld_return_item.package_id) =
             dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO')
         and (SELECT /*+ index (L PK_LD_ARTICLE IX_LD_ARTICLE_04) */
               count(1)
                FROM LD_ARTICLE L
               WHERE l.concept_id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))
                       where l.article_id = ld_return_item_detail.article_id)) > 0
         and LD_ITEM_WORK_ORDER.STATE = 'AN'
         and rownum = 1
       GROUP BY mo_motive.causal_id,
                damo_packages.fdtgetattention_date(ld_return_item.package_id),
                ld_return_item.package_id;

    rfcusolicitudAD cusolicitudAD%rowtype;

    -------------------
    -- Cambio 238 -->
    -------------------
    --Cursor para verificar si existe orden de anulacion/devolucion sobre la venta
    cursor cusolicitudAD_SB(inufindvalue number) is
      select m.package_id
        from open.mo_packages m
       where m.package_type_id = 100264 --Venta FNB
         and m.package_id = inufindvalue
         and exists (select *
                from open.or_order_activity oa, open.or_order o
               where oa.package_id = m.package_id
                 and oa.order_id = o.order_id
                 and o.Order_Status_Id in (8) --Orden Cerrada
                 and o.causal_id = 1 --Legalizada con estado exito
                 and oa.task_type_id in (12702)); --ACEPTACION DE ANULACION DE VENTA - FNB
    nusolicitudAD_SB NUMBER := null;
    -------------------
    -- Cambio 238 <--
    -------------------

    --DVM 200-2389 Causal ha aplicar basado en LDC_CAUSALHOMOL
    nuCausalID number(4) := NULL;
	
	nuTipoCausal 	NUMBER(4) := NULL;

  BEGIN
    ut_trace.trace('INICIA UT_EAN.CreateEAN_CARDIF', 2);
    --valida el consecutivo del archivo a envier

    SELECT count(*)
      into vexar
      FROM LDC_SEGUROVOLUNTARIO
     where trunc(date_file_name_anul) = trunc(sysdate)
       and DIFECODI IS NOT NULL
       and estado_seguro = 'AN';

    if vexar <> 0 then
      SELECT max(substr(file_name_anul, length(file_name_anul) - 5, 2)) + 1
        into vnucon
        FROM LDC_SEGUROVOLUNTARIO
       where trunc(date_file_name_anul) = trunc(sysdate)
         and DIFECODI IS NOT NULL
         and estado_seguro = 'AN';

    elsif vexar = 0 then
      vnucon := 1;
    end if;

    FOR RWSegVol IN cuSegVol LOOP
      ------------------------
      --Cambio 238 -->
      --Seteo de variable.
      ------------------------
      nusolicitudAD_SB := null;
      ------------------------
      --Cambio 238 <--
      ------------------------
      --Establece conexion con el FTP

      if sw = 0 then
        --Obtiene el idenficador del proveedor CARDIF
        nuSupplierID := RWSegVol.Contractor_Id;
        --Obtiene configuracion para conexion con el FTP
        GetConfigDataFTP(nuSupplierID, vtabFTP);
        --Establece conexion con el FTP
        Connect_FTP(vtabFTP, nuSupplierID, ftpConn);
        --NomArchivo:=csbFileNameEAN_CARDIF;
        v_archivo := utl_file.fopen(csbFolderOracle,
                                    csbFileNameEAN_CARDIF ||
                                    lpad(vnucon, 2, 0) || '.txt',
                                    'w');

        sw := 1;
      end if;

      FileLines := null;
      --   segurovoluntario_id, geograp_location_depa, geograp_location_loca, susccodi, package_id, product_id, article_id, difecodi, contractor_id, tarifa, codproducto,,,,,,,,,,,,,,,,,

      /*open cuDeudoFNB(inuPackageID);
      fetch cuDeudoFNB
        INTO nuIdent, sbName, sbPhone;
      close cuDeudoFNB;*/

      --Hallamos el numero de pagare
      /*      sbPagare := nvl(dald_non_ba_fi_requ.fsbgetdigital_prom_note_cons(inuPackageID),
      dald_non_ba_fi_requ.fsbGetManual_Prom_Note_Cons(inuPackageID));*/

      ----
      -- unidad operativa
      /* nuOperUnit := DAOR_Order.fnuGetOperating_Unit_Id(nuOrderDel);*/

      --  Punto de venta
      /*sbSalePoint := DAOR_Operating_Unit.fsbGetName(nuOperUnit);*/
      ----
      /*Hallar la sequencia del documento BINE para la solicitud*/
      /* select sequence_id, sale_value_financ
       into nuSequence_id, nusale_value_financ
       from ld_bine_cencosud
      where package_id = inuPackageID;*/

      /*      select escicaid
        INTO VNUTIPOCED
        from ldc_eq_esta_civi_cardif D
       WHERE D.esciosfid = nvl(RWSegVol.tipoidasegurado, 1)
         AND ROWNUM = 1;

      select tidocaid
        INTO VNUtidocaid
        from ldc_eq_tipo_docu_cardif
       WHERE tidosfid = nvl(RWSegVol.estado_civil, 1)
         AND ROWNUM = 1;*/

      --Configura Linea para agregar al documento

      open cusolicitudAD(RWSegVol.PACKAGE_ID);
      fetch cusolicitudAD
        into rfcusolicitudAD;

      --if nvl(rfcusolicitudAD.Fecha_Atencion_Solicitudad,0) <> 0 then
      if cusolicitudAD%found then

        --DVM 200-2389 Determinar la Causal ha aplicar
        SELECT CH.CAUSAL_CARDIF
          INTO nuCausalID
          FROM LDC_CAUSALHOMOL CH
         WHERE CH.CAUSAL_OSF = rfcusolicitudAD.Idcausal;

        if nuCausalID is null then
          nuCausalID := dald_parameter.fnuGetNumeric_Value('PAR_CAUSAL_CARDIF_DEF');
        end if;
        ---
		
		nuTipoCausal := DALDC_TIPOCAUSALCARDIF.fnuGetTIPO_CAUSAL(nuCausalID, 0);
		
		IF (nuTipoCausal IS NULL) THEN
			nuTipoCausal := dald_parameter.fnuGetNumeric_Value('PAR_TIPOCAUSAL_CARDIF_DEF');
		END IF;
		
        FileLines := RWSegVol.Codproducto /*nuType se cambio en caso 200-2023*/
                     || ';' || nuTipoCausal || ';' || nuCausalID || ';' || --DVM 200-2389 Se reemplazo la Causal rfcusolicitudAD.Idcausal
                     rfcusolicitudAD.Fecha_Atencion_Solicitudad || ';' ||
                     RWSegVol.idasegurado || ';' || RWSegVol.Susccodi || ';' ||
                    -- RWSegVol.numeroproductocrediticio || ';' || se cambio en caso 200-2023
                     RWSegVol.PACKAGE_ID;

        /*FileLines := nuType || ';' || 2 || ';' ||
        RWSegVol.causal_anulacion_devolucion || ';' ||
        to_char(sysdate, 'YYYYMMDD') || ';' ||
        RWSegVol.idasegurado || ';' ||
        RWSegVol.numeroproductocrediticio || ';' ||
        RWSegVol.PACKAGE_ID;*/

        utl_file.put_line(v_archivo, FileLines);
        update ldc_segurovoluntario
           set /* segurovoluntario_id = v_segurovoluntario_id,
                geograp_location_depa = v_geograp_location_depa,
               geograp_location_loca = v_geograp_location_loca,
               susccodi = v_susccodi,
               package_id = v_package_id,*/ product_id = pktbldiferido.fnugetdifenuse(difecodi),
               /* article_id = v_article_id,
               difecodi = v_difecodi,
               contractor_id = v_contractor_id,
               tarifa = v_tarifa,
               codproducto = v_codproducto,
               iniciovigencia = v_iniciovigencia,
               finvigencia = v_finvigencia,
               plancardif = v_plancardif,
               tipoidasegurado = v_tipoidasegurado,
               idasegurado = v_idasegurado,
               primerapellidoasegurado = v_primerapellidoasegurado,
               segundoapellidoasegurado = v_segundoapellidoasegurado,
               primernombreasegurado = v_primernombreasegurado,
               segundonombreasegurado = v_segundonombreasegurado,
               genero_asegurado = v_genero_asegurado,
               estado_civil = v_estado_civil,
               fecnacimientoasegurado = v_fecnacimientoasegurado,
               telasegurado = v_telasegurado,
               celasegurado = v_celasegurado,
               direccionasegurado = v_direccionasegurado,
               ciudadasegurado = v_ciudadasegurado,
               nacionalidad = v_nacionalidad,
               pais_residencia = v_pais_residencia,
               pais_nacimiento_asegurado = v_pais_nacimiento_asegurado,
               emailasegurado = v_emailasegurado,
               prima_antes_iva = v_prima_antes_iva,
               prima_iva_incluido = v_prima_iva_incluido,
               codigoproductobancario = v_codigoproductobancario,
               numeroproductocrediticio = v_numeroproductocrediticio,
               plazocredito = v_plazocredito,
               valorcredito = v_valorcredito,
               valorcuotacredito = v_valorcuotacredito,
               canal = v_canal,
               codigoasesor = v_codigoasesor,
               documentoasesor = v_documentoasesor,
               nombreasesor = v_nombreasesor,
               sucursal = v_sucursal,
               estado_seguro = v_estado_seguro,*/
               package_anu_dev     = rfcusolicitudAD.Solicitudad,
               file_name_anul      = csbFileNameEAN_CARDIF ||
                                     lpad(vnucon, 2, 0) || '.txt',
               date_file_name_anul = sysdate,
               /*file_name_anul = v_file_name_anul,
               date_file_name_anul = v_date_file_name_anul,*/
               causal_anulacion_devolucion = nuCausalID --DVM 200-2389 Se reemplazo la Causal rfcusolicitudAD.Idcausal
        /*refinanciado = v_refinanciado,
        order_activity_id = v_order_activity_id*/
         where segurovoluntario_id = RWSegVol.segurovoluntario_id;
        sw2 := 1;
      else
        ------------------
        -- Cambio 238 -->
        ------------------
        --Verifica si existe orden de anulacion/devolucion sobre la venta
        open cusolicitudAD_SB(RWSegVol.PACKAGE_ID);
        fetch cusolicitudAD_SB
          into nusolicitudAD_SB;
        close cusolicitudAD_SB;
        --Si existe procedemos a agregar el archivo con la misma logica original
        --Se quitan comentarios para simplificar codigo
        if nusolicitudAD_SB is not null then
          nuCausalID := RWSegVol.Causal_Anulacion_Devolucion;
          --Determinar la Causal a aplicar
          /* BEGIN
            SELECT CH.CAUSAL_CARDIF
              INTO nuCausalID
              FROM LDC_CAUSALHOMOL CH
             WHERE CH.CAUSAL_OSF = RWSegVol.Causal_Anulacion_Devolucion;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              nuCausalID := null;
          END;*/

          if nuCausalID is null then
            nuCausalID := dald_parameter.fnuGetNumeric_Value('PAR_CAUSAL_CARDIF_DEF');
          end if;
          ---
		  
		  nuTipoCausal := DALDC_TIPOCAUSALCARDIF.fnuGetTIPO_CAUSAL(nuCausalID, 0);
		
		  IF (nuTipoCausal IS NULL) THEN
			  nuTipoCausal := dald_parameter.fnuGetNumeric_Value('PAR_TIPOCAUSAL_CARDIF_DEF');
		  END IF;

          FileLines := RWSegVol.Codproducto || ';' || nuTipoCausal || ';' ||
                       nuCausalID || ';' ||
                       to_char(trunc(RWSegVol.Anuldev_Date), 'YYYYMMDD') || ';' ||
                       RWSegVol.idasegurado || ';' || RWSegVol.Susccodi || ';' ||
                       RWSegVol.PACKAGE_ID;

          utl_file.put_line(v_archivo, FileLines);
          update ldc_segurovoluntario
             set product_id                  = pktbldiferido.fnugetdifenuse(difecodi),
                 package_anu_dev             = rfcusolicitudAD.Solicitudad,
                 file_name_anul              = csbFileNameEAN_CARDIF ||
                                               lpad(vnucon, 2, 0) || '.txt',
                 date_file_name_anul         = sysdate,
                 causal_anulacion_devolucion = nuCausalID
           where segurovoluntario_id = RWSegVol.segurovoluntario_id;
          sw2 := 1;
        end if;
        ------------------
        -- Cambio 238 <--
        ------------------
      end if;
      close cusolicitudAD;
      --Agrega linea en documento
    --CreateFileEAN_CARDIF(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
    --  LD_BOPACKAGEFNB.proWriteFile(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
    END LOOP;
    if sw != 0 then
      utl_file.fclose(v_archivo);
      ftp.logout(ftpConn);
      utl_tcp.close_all_connections;

      if (sw2 = 1) then
        --Copia el archivo EAN a Ftp Externo
        CopyToFTP(vtabFTP(nuSupplierID).DIIP,
                  vtabFTP(nuSupplierID).USUA,
                  vtabFTP(nuSupplierID).PAWD,
                  csbFileNameEAN_CARDIF || lpad(vnucon, 2, 0) || '.txt',
                  vtabFTP(nuSupplierID).RUTA);
      end if;
    end if;
    ut_trace.trace('FIN UT_EAN.CreateEAN_CARDIF', 2);

  EXCEPTION
    WHEN OTHERS THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END CreateEAN_CARDIF_Anul;
  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : CreateFileEAN_CARDIF
  Descripcion : Crea archivo plano para el proceso de Olimpica
  Autor       : RCOLPAS
  Fecha       : 18/11/2016

  Parametros  :
  Entrada
   isbContent  ==>    Contenido a quemar en el archivo plano
   isbFileName ==>    Nombre del Archivo Plano
   ioPathFile  ==>    Ruta de salida del archivo

  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  ***************************************************************************************/
  PROCEDURE CreateFileEAN_CARDIF(isbContent  IN VARCHAR2,
                                 isbFileName IN VARCHAR2,
                                 ioFile      IN OUT NOCOPY utl_file.file_type) IS
  BEGIN
    ut_trace.trace('INICIA UT_EAN.CreateFileEAN_CARDIF', 2);

    IF (NOT utl_file.is_open(ioFile)) THEN
      ioFile := utl_file.fopen(csbFolderOracle, isbFileName, 'w');
      utl_file.put_line(ioFile, isbContent);
      CloseFile(ioFile);
    END IF;
    ut_trace.trace('FIN UT_EAN.CreateFileEAN_CARDIF', 2);
  EXCEPTION
    WHEN OTHERS THEN
      CloseFile(ioFile);

      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END CreateFileEAN_CARDIF;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : CloseFile
  Descripcion : Cierra el archivo abierto
  Autor       : RCOLPAS
  Fecha       : 11/15/2013 10:15:57 AM
  Parametros  :
  Entrada
   ioPathFile  ==>    Ruta de salida del archivo

  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  ***************************************************************************************/
  PROCEDURE CloseFile(ioFile IN OUT NOCOPY utl_file.file_type) IS
  BEGIN
    IF (utl_file.is_open(ioFile)) THEN
      --cerrar el archivo
      pkUtlFileMgr.fClose(ioFile);
    END IF;
  END CloseFile;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : GetConfigDataFTP
  Descripcion :
  Autor       : ANIETO
  Fecha       : 11/15/2013 10:15:57 AM
  Parametros  :
  Entrada


  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  ***************************************************************************************/
  PROCEDURE GetConfigDataFTP(inuSupplierID IN ld_suppli_settings.supplier_id%TYPE,
                             itbDataFtp    OUT typtabFTP) IS

    CURSOR cuServFTP(supplierID IN ld_suppli_settings.supplier_id%TYPE) IS
      SELECT fsbObCad(s.connect_info, '|', 1) DIIP,
             fsbObCad(s.connect_info, '|', 2) USUA,
             fsbObCad(s.connect_info, '|', 3) PAWD,
             fsbObCad(s.connect_info, '|', 4) RUTA,
             fsbObCad(s.connect_info, '|', 5) DIPE,
             fsbObCad(s.connect_info, '|', 6) USUE,
             fsbObCad(s.connect_info, '|', 7) PWDE,
             fsbObCad(s.connect_info, '|', 8) RUTE
        FROM ld_suppli_settings s
       WHERE Regexp_Substr(s.connect_info, '[^|]+', 1, Rownum) IS NOT NULL
         AND supplier_id = supplierID;

    vrgServFTP cuServFTP%ROWTYPE;
    csbLLave CONSTANT VARCHAR2(30) := '101001011011110110101101010011';
    sbClave LD_SUPPLI_SETTINGS.CONNECT_INFO%TYPE;
  BEGIN
    ut_trace.trace('INICIA UT_EAN.GetConfigDataFTP', 2);
    ut_trace.trace(' inuSupplierID ' || inuSupplierID, 2);

    OPEN cuServFTP(inuSupplierID);
    FETCH cuServFTP
      INTO vrgServFTP;

    IF (cuServFTP%ISOPEN) THEN
      CLOSE cuServFTP;
    END IF;

    --Servidor de venta
    itbDataFtp(inuSupplierID).DIIP := vrgServFTP.DIIP;
    itbDataFtp(inuSupplierID).USUA := vrgServFTP.USUA;
    itbDataFtp(inuSupplierID).PAWD := vrgServFTP.PAWD;
    itbDataFtp(inuSupplierID).RUTA := vrgServFTP.RUTA;

    --Servidor de Entrega
    itbDataFtp(inuSupplierID).DIPE := vrgServFTP.DIPE;
    itbDataFtp(inuSupplierID).USUE := vrgServFTP.USUE;
    itbDataFtp(inuSupplierID).PWDE := vrgServFTP.PWDE;
    itbDataFtp(inuSupplierID).RUTE := vrgServFTP.RUTE;

    -->>
    --Mmejia
    --ARA140668
    --Descriptacion de claves de conexion
    -->>
    --Desencripta clave de lectura
    pkControlConexion.encripta(vrgServFTP.PAWD, sbClave, csbLLave, 1);
    --Dbms_Output.Put_Line('Clave lectura:'||sbClave);
    ut_trace.trace(' Clave lectura:' || sbClave, 2);
    itbDataFtp(inuSupplierID).PAWD := sbClave;

    --Desencripta clave de escritura
    pkControlConexion.encripta(vrgServFTP.PWDE, sbClave, csbLLave, 1);
    --Dbms_Output.Put_Line('Clave escritura:'||sbClave);
    ut_trace.trace(' Clave escritura:' || sbClave, 2);
    itbDataFtp(inuSupplierID).PWDE := sbClave;

    ut_trace.trace('FIN UT_EAN.GetConfigDataFTP', 2);
  EXCEPTION
    WHEN OTHERS THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetConfigDataFTP;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : Connect_FTP
  Descripcion :
  Autor       : ANIETO
  Fecha       : 11/15/2013 10:15:57 AM
  Parametros  :
  Entrada


  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  ***************************************************************************************/
  PROCEDURE Connect_FTP(itbDataFtp  IN typtabFTP,
                        inuIndexFtp IN NUMBER,
                        ftpConn     OUT utl_tcp.connection) IS
  BEGIN
    ut_trace.trace('INICIA UT_EAN.Connect_FTP', 2);
    ut_trace.trace(' itbDataFtp(inuIndexFtp).DIPE ' || itbDataFtp(inuIndexFtp).DIPE,
                   2);
    ut_trace.trace(' itbDataFtp(inuIndexFtp).USUE ' || itbDataFtp(inuIndexFtp).USUE,
                   2);
    ut_trace.trace(' itbDataFtp(inuIndexFtp).PWDE ' || itbDataFtp(inuIndexFtp).PWDE,
                   2);

    ftpConn := ftp.login(itbDataFtp(inuIndexFtp).DIPE,
                         '21',
                         itbDataFtp(inuIndexFtp).USUE,
                         itbDataFtp(inuIndexFtp).PWDE);

    ut_trace.trace('FIN UT_EAN.Connect_FTP', 2);
  EXCEPTION
    WHEN OTHERS THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END Connect_FTP;

  FUNCTION fsbObCad(isbCad IN VARCHAR2,
                    isbDel IN VARCHAR2,
                    inuIn  IN NUMBER) RETURN VARCHAR2 /*DETERMINISTIC*/
   IS
    /************************************************************************
          DESCRIPCION  : Extrae una subcadena entre un delimitador especial
          Parametros de Entrada
                         OsbCad   Cadena.
                         osbDel   Delimitador.
                         onuIn    Indice.
          Retorna la subcadena entre el delimitador especial.
          Ej: si la cadena es sbCad y el delimitador es '|' entonces
          sbCade varchar2(50):='LI|1010|Nombre|Apellido';
          fsbObCad(sbCade,'|',1)); return=>LI
          fsbObCad(sbCade,'|',2)); return=>1010
          fsbObCad(sbCade,'|',3)); return=>Nombre
          fsbObCad(sbCade,'|',4)); return=>Apellido
          fsbObCad(sbCade,'|',5)); return=>'No devuelve Nada'
    */
  BEGIN

    RETURN REGEXP_SUBSTR(IsbCad, '[^' || IsbDel || ']+', 1, InuIn);
  EXCEPTION
    WHEN OTHERS THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END fsbObCad;

  FUNCTION GetEquiPosID(inuSupplierID IN ge_contratista.id_contratista%TYPE)
    RETURN ld_pos_settings.equivalence%TYPE IS
    sbEqui ld_pos_settings.equivalence%TYPE;
  BEGIN
    ut_trace.trace('INICIA UT_EAN.GetEquiPosID', 2);
    SELECT ps.equivalence
      INTO sbEqui
      FROM ld_pos_settings ps
     WHERE ps.supplier_id = inuSupplierID
       AND rownum = 1;

    ut_trace.trace('FIN UT_EAN.GetEquiPosID', 2);
    RETURN sbEqui;
  EXCEPTION
    WHEN OTHERS THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END GetEquiPosID;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : Connect_FTP
  Descripcion :
  Autor       : ANIETO
  Fecha       : 11/15/2013 10:15:57 AM
  Parametros  :
  Entrada

  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  ***************************************************************************************/
  PROCEDURE CopyToFTP(isbDiIP IN VARCHAR2,
                      isbUsua IN VARCHAR2,
                      isbPawd IN VARCHAR2,
                      isbArch IN VARCHAR2,
                      isbPath IN VARCHAR2) IS
    vTconn UTL_TCP.connection;

  BEGIN
    ut_trace.Trace('INICIO UT_EAN.CopyFTP_External', 10);
    dbms_output.put_line('isbDiIP: ' || isbDiIP || ' isbUsua: ' || isbUsua ||
                         ' isbPawd: ' || isbPawd || ' isbArch: ' ||
                         isbArch || ' isbPath: ' || isbPath);
    ut_trace.Trace('isbDiIP: ' || isbDiIP || ' isbUsua: ' || isbUsua ||
                   ' isbPawd: ' || isbPawd || ' isbArch: ' || isbArch ||
                   ' isbPath: ' || isbPath,
                   10);

    vTconn := ftp.login(isbDiIP, '21', isbUsua, isbPawd); -- Conexion FTP
    ftp.ascii(p_conn => vTconn);

    --Copia al ftpExterno
    ftp.put(p_conn      => vTconn,
            p_from_dir  => MI_DIR,
            p_from_file => isbArch,
            p_to_file   => isbPath || isbArch);

    dbms_output.put_Line('OK, archivo subido?');
    ftp.logout(vTconn);

    ut_trace.Trace('FIN UT_EAN.CopyFTP_External', 10);
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm);
      ut_trace.Trace('ERROR Others UT_EAN.CopyFTP_External: ' || sqlerrm,
                     10);
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END CopyToFTP;

  --Caso 200-2645(Inicio)

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : CreateEAN_CARDIF_EFI
  Descripcion : Crea archivo plano para el proceso de CARDIF Para Efigas
  Autor       : ROBPAR- JM
  Fecha       : 29/05/2019

  Parametros  :
  Entrada
   isbContent  ==>    Contenido a quemar en el archivo plano
   isbFileName ==>    Nombre del Archivo Plano
   ioPathFile  ==>    Ruta de salida del archivo

  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  20/05/2020   Innovacion         Ca 405 -- Se incluyen nuevos campos cardif
  29/05/2019   ROBPAR             200-2645 -> Crearcion del procedimeinto
  ***************************************************************************************/
  PROCEDURE CreateEAN_CARDIF_EFI IS
    FileLines             VARCHAR2(4000) := '';
    csbApplicationPOS     VARCHAR2(4) := '9865';
    csbDateNow            VARCHAR2(6) := to_char(SYSDATE, 'YYMMDD');
    csbFileNameEAN_CARDIF VARCHAR2(100) := '531CO98PR065' ||
                                           to_char(SYSDATE, 'YYYYMMDD');
    nuOrderDel            or_order.order_id%type;
    vrgOrdetrab           daor_order.styOR_order;
    nuSupplierID          ld_suppli_settings.supplier_id%TYPE;
    ftpConn               utl_tcp.connection;
    ioRecordFile          utl_file.file_type;
    inuCodeEquiPOS        LD_POS_SETTINGS.EQUIVALENCE%TYPE;

    nuType    Number := 6501;
    nuTypeDoc Number := 1;
    nuIdent   ld_promissory.identification%type;
    sbName    ld_promissory.debtorname%type;
    sbPhone   ld_promissory.propertyphone_id%type;
    sbPagare  ld_non_ba_fi_requ.digital_prom_note_cons%type;
    -- sbCodConvenio       LD_parameter.Value_Chain%type := dald_parameter.fsbGetValue_Chain('COD_INTERNO_CARDIF_CONV_FNB');
    nuSequence_id       ld_bine_cencosud.sequence_id%type;
    nusale_value_financ ld_bine_cencosud.sale_value_financ%type;
    nuOperUnit          OR_Order.Operating_Unit_Id%type;
    sbSalePoint         OR_Operating_Unit.Name%type;
    VNUTIPOCED          NUMBER;
    VNUtidocaid         NUMBER;
    v_archivo           utl_file.file_type;
    sw                  NUMBER := 0;
    sw2                 NUMBER := 0;
    vnucon              NUMBER := 1;
    vexar               NUMBER := 1;

    --200-2193
    contador         number;
    continuarL       number := 0;
    list_ventas1     varchar2(4000) := NULL;
    list_ventas2     varchar2(4000) := NULL;
    list_ventas3     varchar2(4000) := NULL;
    list_ventas4     varchar2(4000) := NULL;
    list_ventas5     varchar2(4000) := NULL;
    temp_list_ventas varchar2(200) := NULL;
    Vcorreo          ld_parameter.value_chain%TYPE;
    vsbSendEmail     ld_parameter.value_chain%TYPE;
    --
    continuarE    number := 0;
    list_err1     varchar2(4000) := NULL;
    list_err2     varchar2(4000) := NULL;
    list_err3     varchar2(4000) := NULL;
    list_err4     varchar2(4000) := NULL;
    list_err5     varchar2(4000) := NULL;
    temp_list_err varchar2(200) := NULL;
    swIngreso     number := 0;
    msj_err       varchar2(4000) := NULL;
    --
    --

    CURSOR cuSegVol IS
      SELECT *
        FROM OPEN.LDC_SEGUROVOLUNTARIO
       WHERE FILE_NAME_VENTA IS NULL
         AND DIFECODI IS NOT NULL
         and estado_seguro = 'RE'
      /*and rownum < 10*/
      ;
    /*and segurovoluntario_id in
    (11, 12, 13, 14, 15, 16, 17, 18, 19, 20)*/

    -- (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

    /*Caso 200-1537 Consulta de valor de la cuota credito*/
    cursor cuvalorcuotacredito(InuPACKAGE_ID ldc_segurovoluntario.package_id%type) is
      SELECT NVL(SUM(di.difevacu), 0)
        FROM open.or_order_activity  oa,
             open.ld_item_work_order li,
             open.diferido           di
       WHERE oa.activity_id =
             open.dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB') --4000822
         AND oa.order_activity_id = li.order_activity_id
         AND oa.package_id = InuPACKAGE_ID
         AND li.article_id NOT IN
             (SELECT l.article_id
                FROM open.LD_ARTICLE L
               WHERE L.Concept_Id IN
                     (select nvl(to_number(column_value), 0)
                        from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                           NULL),
                                                                     ','))))
         AND di.difecodi = li.difecodi;

    --PRAGMA AUTONOMOUS_TRANSACTION;

    --CASO 200-2422
    cursor cucc_grace_peri_defe(Inudeferred_id cc_grace_peri_defe.deferred_id%type) is
      select d.*,
             round(MONTHS_BETWEEN(trunc(end_date), trunc(initial_date)), 0) MESES
        from cc_grace_peri_defe d
       where d.deferred_id = Inudeferred_id;

    rfcucc_grace_peri_defe cucc_grace_peri_defe%rowtype;

    --------------------------
    -- CAMBIO 235 -->
    --------------------------
    cursor cuCuotaVenta(InuContract number, InuPACKAGE number) is
      select nvl(sum(df.difevacu), 0) cuota
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

    --------------------------
    -- CAMBIO 405 -->
    --------------------------
    cursor cuDatosContratista(inuVenta ldc_segurovoluntario.package_id%type) is
      select SUBSTR(cont.nombre_contratista, 1, 26) contratista,
             SUBSTR(su.identification, 1, 12) nit
        from open.ge_contratista cont
        left join open.ge_subscriber su
          on su.subscriber_id = cont.subscriber_id
       where cont.id_contratista =
             daor_operating_unit.fnugetcontractor_id(damo_packages.fnugetoperating_unit_id(inuVenta,
                                                                                         0),
                                                     0);

    sbDepartamento varchar2(12);
    sbNitProveedor varchar2(12);
    sbSucursal     varchar2(26);

    --------------------------
    -- CAMBIO 405 <--
    --------------------------

    sbFechaVigencia varchar2(4000);
    dtFechaVigencia date;
    --CASO 200-2422

    --200-2389
    DTinicioVigencia date;
    plazoCredito     number;

  BEGIN
    ut_trace.trace('INICIA UT_EAN.CreateEAN_CARDIF_EFI', 2);
    --valida el consecutivo del archivo a envier

    SELECT count(*)
      into vexar
      FROM LDC_SEGUROVOLUNTARIO
     where trunc(date_file_name_venta) = trunc(sysdate)
       and DIFECODI IS NOT NULL
       and estado_seguro = 'RE';

    if vexar <> 0 then
      SELECT max(substr(FILE_NAME_VENTA, length(FILE_NAME_VENTA) - 5, 2)) + 1
        into vnucon
        FROM LDC_SEGUROVOLUNTARIO
       where trunc(date_file_name_venta) = trunc(sysdate)
         and DIFECODI IS NOT NULL
         and estado_seguro = 'RE';

    elsif vexar = 0 then
      vnucon := 0;
    end if;

    FOR RWSegVol IN cuSegVol LOOP

      nuExistsTV := null;

      --200-2193 - Validacion de errores en el DIFECODI
      SELECT count(*)
        into contador
        FROM LDC_SEGUROVOLUNTARIO sv, diferido di
       WHERE sv.segurovoluntario_id = RWSegVol.segurovoluntario_id
         and sv.difecodi = di.difecodi;

      if contador = 1 then

        Dbms_Output.Put_Line('Venta Valida: ' ||
                             RWSegVol.segurovoluntario_id);
        --codigo original del paquete
        --Establece conexion con el FTP
        swIngreso := 1;
        -- sw := 0;
        begin
          if sw = 0 then
            --Obtiene el idenficador del proveedor CARDIF
            nuSupplierID := RWSegVol.Contractor_Id;
            --Obtiene configuracion para conexion con el FTP
            GetConfigDataFTP(nuSupplierID, vtabFTP);
            --Establece conexion con el FTP
            Connect_FTP(vtabFTP, nuSupplierID, ftpConn);
            --NomArchivo:=csbFileNameEAN_CARDIF;
            v_archivo := utl_file.fopen(csbFolderOracle,
                                        csbFileNameEAN_CARDIF ||
                                        lpad(vnucon, 2, 0) || '.txt',
                                        'w');

            sw := 1;
          end if;

          FileLines := null;
          --   segurovoluntario_id, geograp_location_depa, geograp_location_loca, susccodi, package_id, product_id, article_id, difecodi, contractor_id, tarifa, codproducto,,,,,,,,,,,,,,,,,

          /*open cuDeudoFNB(inuPackageID);
          fetch cuDeudoFNB
            INTO nuIdent, sbName, sbPhone;
          close cuDeudoFNB;*/

          --Hallamos el numero de pagare
          /*      sbPagare := nvl(dald_non_ba_fi_requ.fsbgetdigital_prom_note_cons(inuPackageID),
          dald_non_ba_fi_requ.fsbGetManual_Prom_Note_Cons(inuPackageID));*/

          ----
          -- unidad operativa
          /* nuOperUnit := DAOR_Order.fnuGetOperating_Unit_Id(nuOrderDel);*/

          --  Punto de venta
          /*sbSalePoint := DAOR_Operating_Unit.fsbGetName(nuOperUnit);*/
          ----
          /*Hallar la sequencia del documento BINE para la solicitud*/
          /* select sequence_id, sale_value_financ
           into nuSequence_id, nusale_value_financ
           from ld_bine_cencosud
          where package_id = inuPackageID;*/

          select escicaid
            INTO VNUTIPOCED
            from ldc_eq_esta_civi_cardif D
           WHERE D.esciosfid = nvl(RWSegVol.estado_civil, 1)
             AND ROWNUM = 1;

          select tidocaid
            INTO VNUtidocaid
            from ldc_eq_tipo_docu_cardif
           WHERE tidosfid = nvl(RWSegVol.tipoidasegurado, 1)
             AND ROWNUM = 1;

          -------------------------
          -- CAMBIO 325 -->
          -------------------------
          --Se restablece logica bajo el cambio 405
          ------------------------------------
          -- CAMBIO 405
          -- Este cambio valida si la venta a registrar es televenta o no
          -- (Se identifica una televenta si tiene al menos un articulo cargado diferente de cardif).
          -- Si lo es, modifica el valor de la cuota de credito a cargar en el archivo.
          -- Si no, guarda los valores de manera habitual.
          ------------------------------------

          open cuTeleVentas(RWSegVol.package_id);
          fetch cuTeleVentas
            into nuExistsTV;
          close cuTeleVentas;

          if nuExistsTV > 0 then
            /*Caso 200-1537*/
            open cuvalorcuotacredito(RWSegVol.package_id);
            fetch cuvalorcuotacredito
              into RWSegVol.valorcuotacredito;
            close cuvalorcuotacredito;
            --Configura Linea para agregar al documento
          elsif nuExistsTV = 0 then
            open cuCuotaVenta(RWSegVol.Susccodi, RWSegVol.package_id);
            fetch cuCuotaVenta
              into RWSegVol.valorcuotacredito;
            close cuCuotaVenta;
          else
            null;
          end if;
          -------------------------
          -- CAMBIO 325 <--
          -------------------------

          --caso 200-2389 - Cambio de inicio y fin de vigencia, plazo de Crdeito
          SELECT o.legalization_date, mdf.credit_fees
            into DTinicioVigencia, plazoCredito
            FROM open.or_order           o,
                 open.or_order_activity  oa,
                 OPEN.LD_ITEM_WORK_ORDER MDF
           where oa.package_id = RWSegVol.package_id
             and oa.order_id = o.order_id
             and MDF.ORDER_ACTIVITY_ID = OA.ORDER_ACTIVITY_ID
             and o.task_type_id =
                 dald_parameter.fnuGetNumeric_Value('CODI_TITR_EFNB')
             and MDF.Article_Id in (RWSegVol.Article_Id)
          --and o.operating_unit_id = 2512 --retirado de la consulta principal por solicitud del ing samuel pacheco
          ;

          --CASO 200-2422
          --200-2389 cambio de inicio y fin de vigencia
          sbFechaVigencia := to_char(DTinicioVigencia, 'DDMMYYYY'); --to_char(RWSegVol.finvigencia, 'DDMMYYYY');
          dtFechaVigencia := ADD_MONTHS(DTinicioVigencia, plazoCredito) +
                             NVL(DALD_PARAMETER.fnuGetNumeric_Value('CANT_DIAS_FECH_VIG_SEG_VOL',
                                                                    NULL),
                                 0); --RWSegVol.finvigencia;
          --Cursor para validar si el diferido fue definido en un periodo de gracia
          open cucc_grace_peri_defe(RWSegVol.Difecodi);
          fetch cucc_grace_peri_defe
            into rfcucc_grace_peri_defe;
          if cucc_grace_peri_defe%found then
            if rfcucc_grace_peri_defe.initial_date is not null and
               rfcucc_grace_peri_defe.end_date is not null then
              sbFechaVigencia := to_char(ADD_MONTHS(dtFechaVigencia, --RWSegVol.finvigencia,
                                                    rfcucc_grace_peri_defe.meses),
                                         'DDMMYYYY');
              dtFechaVigencia := ADD_MONTHS(dtFechaVigencia, --RWSegVol.finvigencia,
                                            rfcucc_grace_peri_defe.meses);
            end if;
          end if;
          close cucc_grace_peri_defe;
          --CASO 200-2422

          -------------------------
          -- CAMBIO 405 -->
          -------------------------
          --Se obtienen datos del contratista para incluir al archivo
          open cuDatosContratista(RWSegVol.Package_Id);
          fetch cuDatosContratista
            into sbSucursal, sbNitProveedor;
          close cuDatosContratista;
          --Se obtiene nombre del departamento para incluir al archivo.
          sbDepartamento := SUBSTR(dage_geogra_location.fsbgetdescription(RWSegVol.Geograp_Location_Depa),
                                   1,
                                   12);
          -------------------------
          -- CAMBIO 405 <--
          -------------------------

          FileLines := nuType /* RWSegVol.Codproducto se cambio en caso 200-2645*/
                       || ';' ||
                      --200-2389 cambio
                       to_char(DTinicioVigencia, 'DDMMYYYY') || ';' || --to_char(RWSegVol.iniciovigencia, 'DDMMYYYY') || ';' ||
                      /*to_char(RWSegVol.finvigencia, 'DDMMYYYY')*/
                       to_char(dtFechaVigencia, 'DDMMYYYY') || ';' ||
                       RWSegVol.plancardif || ';' || VNUtidocaid || ';' ||
                       RWSegVol.idasegurado || ';' ||
                       RWSegVol.primerapellidoasegurado || ';' ||
                       RWSegVol.segundoapellidoasegurado || ';' ||
                       RWSegVol.primernombreasegurado || ';' ||
                       RWSegVol.segundonombreasegurado || ';' ||
                       RWSegVol.genero_asegurado || ';' || VNUTIPOCED || ';' ||
                       to_char(RWSegVol.fecnacimientoasegurado, 'DDMMYYYY') || ';' ||
                       RWSegVol.telasegurado || ';' ||
                       RWSegVol.celasegurado || ';' ||
                      --RWSegVol.direccionasegurado || ';' ||
                      --Caso 200-2162 Restriccion de la Longitud del Campo
                      --La longitud maxima del campo lo define el parametro PAR_LONG_DIR_CARDIF
                       SUBSTR(RWSegVol.direccionasegurado,
                              1,
                              open.dald_parameter.fnuGetNumeric_Value('PAR_LONG_DIR_CARDIF')) || ';' ||
                      --
                       RWSegVol.ciudadasegurado || ';' ||
                       RWSegVol.nacionalidad || ';' ||
                       RWSegVol.pais_residencia || ';' ||
                       RWSegVol.pais_nacimiento_asegurado || ';' ||
                       RWSegVol.emailasegurado || ';' ||
                       RWSegVol.prima_antes_iva || ';' ||
                       RWSegVol.prima_iva_incluido || ';' ||
                       RWSegVol.codigoproductobancario || ';' ||
                       RWSegVol.SUSCCODI || ';' || --Modificado en el caso 200-1927
                       RWSegVol.package_id || ';;;' ||
                       RWSegVol.plazocredito || ';' ||
                       RWSegVol.valorcredito || ';' ||
                       RWSegVol.valorcuotacredito || ';' || RWSegVol.canal || ';' ||
                       RWSegVol.codigoasesor || ';' ||
                       RWSegVol.documentoasesor || ';' ||
                       RWSegVol.nombreasesor || ';' || --RWSegVol.sucursal;
                       ---NUEVOS CAMPOS CAMBIO 405
                       sbSucursal || ';' || sbDepartamento || ';' ||
                       sbNitProveedor;
          --31/10/18 DVM Se pasa al final de la secuencia para control de validacion
          --utl_file.put_line(v_archivo, FileLines);
          update ldc_segurovoluntario
             set /* segurovoluntario_id = v_segurovoluntario_id,
                  geograp_location_depa = v_geograp_location_depa,
                 geograp_location_loca = v_geograp_location_loca,
                 susccodi = v_susccodi,
                 package_id = v_package_id,*/ product_id = pktbldiferido.fnugetdifenuse(difecodi),
                 /* article_id = v_article_id,
                 difecodi = v_difecodi,
                 contractor_id = v_contractor_id,
                 tarifa = v_tarifa,
                 codproducto = v_codproducto,
                 iniciovigencia = v_iniciovigencia,*/
                 --CASO 200-2422
                 --finvigencia = dtFechaVigencia, --v_finvigencia,
                 --CASO 200-2422
                 --200-2389 actualizacion fecha
                 iniciovigencia = DTinicioVigencia,
                 finvigencia    = dtFechaVigencia,
                 /*
                 plancardif = v_plancardif,
                 tipoidasegurado = v_tipoidasegurado,
                 idasegurado = v_idasegurado,
                 primerapellidoasegurado = v_primerapellidoasegurado,
                 segundoapellidoasegurado = v_segundoapellidoasegurado,
                 primernombreasegurado = v_primernombreasegurado,
                 segundonombreasegurado = v_segundonombreasegurado,
                 genero_asegurado = v_genero_asegurado,
                 estado_civil = v_estado_civil,
                 fecnacimientoasegurado = v_fecnacimientoasegurado,
                 telasegurado = v_telasegurado,
                 celasegurado = v_celasegurado,
                 direccionasegurado = v_direccionasegurado,
                 ciudadasegurado = v_ciudadasegurado,
                 nacionalidad = v_nacionalidad,
                 pais_residencia = v_pais_residencia,
                 pais_nacimiento_asegurado = v_pais_nacimiento_asegurado,
                 emailasegurado = v_emailasegurado,
                 prima_antes_iva = v_prima_antes_iva,
                 prima_iva_incluido = v_prima_iva_incluido,
                 codigoproductobancario = v_codigoproductobancario,
                 numeroproductocrediticio = v_numeroproductocrediticio,
                 plazocredito = v_plazocredito,
                 valorcredito = v_valorcredito,*/
                 valorcuotacredito    = RWSegVol.valorcuotacredito, /*
                                                                                                      canal = v_canal,
                                                                                                      codigoasesor = v_codigoasesor,
                                                                                                      documentoasesor = v_documentoasesor,
                                                                                                      nombreasesor = v_nombreasesor,
                                                                                                      sucursal = v_sucursal,
                                                                                                      estado_seguro = v_estado_seguro,
                                                                                                      package_anu_dev = v_package_anu_dev,*/
                 file_name_venta      = csbFileNameEAN_CARDIF ||
                                        lpad(vnucon, 2, 0) || '.txt',
                 date_file_name_venta = sysdate
          /*file_name_anul = v_file_name_anul,
          date_file_name_anul = v_date_file_name_anul,
          causal_anulacion_devolucion = v_causal_anulacion_devolucion,
          refinanciado = v_refinanciado,
          order_activity_id = v_order_activity_id*/
           where segurovoluntario_id = RWSegVol.segurovoluntario_id;

          --Agrega linea en documento
          --CreateFileEAN_CARDIF(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
          --  LD_BOPACKAGEFNB.proWriteFile(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
          --
          /*if RWSegVol.segurovoluntario_id > 76 then
            vexar := 10 / 0;
          else*/
          utl_file.put_line(v_archivo, FileLines);
          /*end if;*/

        EXCEPTION
          WHEN OTHERS THEN
            Dbms_Output.Put_Line('Venta Con Error: ' ||
                                 RWSegVol.segurovoluntario_id);
            /*Dbms_Output.Put_Line('Error al procesar la Venta: Venta [' || RWSegVol.segurovoluntario_id ||
            '] Solicitud [' || RWSegVol.package_id ||
            '] Suscripcion [' || RWSegVol.SUSCCODI ||
            '] Diferido [' || RWSegVol.DIFECODI || ']<br>');*/
            continuarE := 1;
            if list_err1 IS NOT NULL then
              if length(list_err1) > 3900 then
                continuarE := 2;
              end if;
            end if;
            if list_err2 IS NOT NULL then
              if length(list_err2) > 3900 then
                continuarE := 3;
              end if;
            end if;
            if list_err3 IS NOT NULL then
              if length(list_err3) > 3900 then
                continuarE := 4;
              end if;
            end if;
            if list_err4 IS NOT NULL then
              if length(list_err4) > 3900 then
                continuarE := 5;
              end if;
            end if;
            if sw = 0 then
              temp_list_err := 'Error [Problemas al Conectar con el Servidor FTP.] al procesar la Venta: Venta [' ||
                               RWSegVol.segurovoluntario_id ||
                               '] Solicitud [' || RWSegVol.package_id ||
                               '] Suscripcion [' || RWSegVol.SUSCCODI ||
                               '] Diferido [' || RWSegVol.DIFECODI ||
                               ']<br>';
            else
              temp_list_err := 'Error al procesar la Venta: Venta [' ||
                               RWSegVol.segurovoluntario_id ||
                               '] Solicitud [' || RWSegVol.package_id ||
                               '] Suscripcion [' || RWSegVol.SUSCCODI ||
                               '] Diferido [' || RWSegVol.DIFECODI ||
                               ']<br>';
            end if;
            if continuarE = 1 then
              list_err1 := list_err1 || temp_list_err;
            end if;
            if continuarE = 2 then
              list_err2 := list_err2 || temp_list_err;
            end if;
            if continuarE = 3 then
              list_err3 := list_err3 || temp_list_err;
            end if;
            if continuarE = 4 then
              list_err4 := list_err4 || temp_list_err;
            end if;
            if continuarE = 5 then
              list_err5 := list_err5 || temp_list_err;
            end if;
            --Errors.setError;
          --raise ex.CONTROLLED_ERROR;
          --null;
        end;
      else
        Dbms_Output.Put_Line('Venta No Valida: ' ||
                             RWSegVol.segurovoluntario_id);
        --codigo de registro del error (requerido para la Parte II)
        continuarL := 1;
        if list_ventas1 IS NOT NULL then
          if length(list_ventas1) > 3900 then
            continuarL := 2;
          end if;
        end if;
        if list_ventas2 IS NOT NULL then
          if length(list_ventas2) > 3900 then
            continuarL := 3;
          end if;
        end if;
        if list_ventas3 IS NOT NULL then
          if length(list_ventas3) > 3900 then
            continuarL := 4;
          end if;
        end if;
        if list_ventas4 IS NOT NULL then
          if length(list_ventas4) > 3900 then
            continuarL := 5;
          end if;
        end if;
        temp_list_ventas := 'Venta con Diferido No Valido: Venta [' ||
                            RWSegVol.segurovoluntario_id || '] Solicitud [' ||
                            RWSegVol.package_id || '] Suscripcion [' ||
                            RWSegVol.SUSCCODI || '] Diferido [' ||
                            RWSegVol.DIFECODI || ']<br>';
        if continuarL = 1 then
          list_ventas1 := list_ventas1 || temp_list_ventas;
          --Dbms_Output.Put_Line(list_ventas1);
        end if;
        if continuarL = 2 then
          list_ventas2 := list_ventas2 || temp_list_ventas;
        end if;
        if continuarL = 3 then
          list_ventas3 := list_ventas3 || temp_list_ventas;
        end if;
        if continuarL = 4 then
          list_ventas4 := list_ventas4 || temp_list_ventas;
        end if;
        if continuarL = 5 then
          list_ventas5 := list_ventas5 || temp_list_ventas;
        end if;
        --modificacion del registro DIFECODI a NULO de la venta
        UPDATE LDC_SEGUROVOLUNTARIO sv
           SET sv.difecodi = NULL
         WHERE sv.segurovoluntario_id = RWSegVol.segurovoluntario_id;

      end if;
      sw2 := 1;
    END LOOP;
    -- Modificacion Caso 200-2645 (Inicio) En caso de que no ayan soluciotudes se enviara un correo
    if (sw2 = 0) then
      Dbms_Output.Put_Line('Envio de Correo');
      Dbms_Output.Put_Line('Mensaje: ' ||
                           'No hay registro de venta CARDIF');
      --Envio de correo con los erroneos
      Vcorreo := dald_parameter.fsbGetValue_Chain('PAR_MAIL_CARDIF_ED');
      --identifica parametro de correo de envio osf
      vsbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');

      if Vcorreo is not null or vsbSendEmail is not null then
        --SE ENVIA CORREO DE NOTIFICACION
        ld_bopackagefnb.prosendemail(isbsender     => vsbSendEmail,
                                     isbrecipients => Vcorreo,
                                     isbsubject    => 'No hay registro de venta CARDIF- ' ||
                                                      to_char(SYSDATE,
                                                              'DD-MM-YYYY HH24:MI:SS'),
                                     isbmessage    => 'No hay registro de venta CARDIF',
                                     isbfilename   => null);
      else
        Dbms_Output.Put_Line('Error al Enviar el Correo');
      end if;

    end if;
    -- Modificacion Caso 200-2645 (Fin)
    if list_ventas1 IS NOT NULL or list_err1 IS NOT NULL then
      /*Dbms_Output.Put_Line('Mensaje: ' || list_ventas1 ||
      list_ventas2 ||
      list_ventas3 ||
      list_ventas4 ||
      list_ventas5 ||
      list_err1 ||
      list_err2 ||
      list_err3 ||
      list_err4 ||
      list_err5);*/
      --Envio de correo con los registros erroneos
      Vcorreo := dald_parameter.fsbGetValue_Chain('PAR_MAIL_CARDIF_ED');
      --identifica parametro de correo de envio osf
      vsbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');
      --SE ENVIA CORREO DE NOTIFICACION
      if Vcorreo is not null and vsbSendEmail is not null then
        Dbms_Output.Put_Line('Envio de Correo');
        ld_bopackagefnb.prosendemail(isbsender     => vsbSendEmail,
                                     isbrecipients => Vcorreo,
                                     isbsubject    => 'Ventas Erroneas en CARDIF - ' ||
                                                      to_char(SYSDATE,
                                                              'DD-MM-YYYY HH24:MI:SS'),
                                     isbmessage    => list_ventas1 ||
                                                      list_ventas2 ||
                                                      list_ventas3 ||
                                                      list_ventas4 ||
                                                      list_ventas5 ||
                                                      list_err1 || list_err2 ||
                                                      list_err3 || list_err4 ||
                                                      list_err5,
                                     isbfilename   => null);
      else
        Dbms_Output.Put_Line('Error al Enviar el Correo');
      end if;
    end if;

    if sw != 0 then
      Dbms_Output.Put_Line('Copia de archivo EAN a FTP Externo');
      utl_file.fclose(v_archivo);
      ftp.logout(ftpConn);
      utl_tcp.close_all_connections;

      --Copia el archivo EAN a Ftp Externo
      CopyToFTP(vtabFTP(nuSupplierID).DIIP,
                vtabFTP(nuSupplierID).USUA,
                vtabFTP(nuSupplierID).PAWD,
                csbFileNameEAN_CARDIF || lpad(vnucon, 2, 0) || '.txt',
                vtabFTP(nuSupplierID).RUTA);

    end if;
    ut_trace.trace('FIN UT_EAN.CreateEAN_CARDIF_EFI', 2);

  EXCEPTION
    WHEN OTHERS THEN
      msj_err := DBMS_UTILITY.FORMAT_ERROR_STACK || '<br>' ||
                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '<br>' || sqlerrm;
      IF sw = 0 and swIngreso = 1 then
        msj_err := msj_err ||
                   '<br>Problemas al Conectar con el Servidor FTP.';
      end if;
      Dbms_Output.Put_Line('Envio de Correo');
      Dbms_Output.Put_Line('Mensaje: ' || msj_err);
      --Envio de correo con los erroneos
      Vcorreo := dald_parameter.fsbGetValue_Chain('PAR_MAIL_CARDIF_ED');
      --identifica parametro de correo de envio osf
      vsbSendEmail := dald_Parameter.fsbGetValue_Chain('LDC_SMTP_SENDER');
      --SE ENVIA CORREO DE NOTIFICACION
      if Vcorreo is not null or vsbSendEmail is not null then
        ld_bopackagefnb.prosendemail(isbsender     => vsbSendEmail,
                                     isbrecipients => Vcorreo,
                                     isbsubject    => 'Errores en el CARDIF - ' ||
                                                      to_char(SYSDATE,
                                                              'DD-MM-YYYY HH24:MI:SS'),
                                     isbmessage    => msj_err,
                                     isbfilename   => null);
      else
        Dbms_Output.Put_Line('Error al Enviar el Correo');
      end if;
      --
      Errors.setError;
      --raise ex.CONTROLLED_ERROR;
  END CreateEAN_CARDIF_EFI;

  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : CreateEAN_CARDIF_Anul_EFI
  Descripcion : Crea archivo plano para el proceso anulacion de CARDIF Para Efigas
  Autor       : ROBPAR- JM
  Fecha       : 29/05/2019

  Parametros  :
  Entrada
   isbContent  ==>    Contenido a quemar en el archivo plano
   isbFileName ==>    Nombre del Archivo Plano
   ioPathFile  ==>    Ruta de salida del archivo

  Historia de Modificaciones
  Fecha        Autor              Modificacion
  =========    ================   ======================================================
  29/05/2019   ROBPAR             200-2645 -> Crearcion del procedimeinto
  ***************************************************************************************/
  PROCEDURE CreateEAN_CARDIF_Anul_EFI IS
    FileLines             VARCHAR2(4000) := '';
    csbApplicationPOS     VARCHAR2(4) := '9865';
    csbDateNow            VARCHAR2(6) := to_char(SYSDATE, 'YYMMDD');
    csbFileNameEAN_CARDIF VARCHAR2(100) := '531CO98NR065' ||
                                           to_char(SYSDATE, 'YYYYMMDD');
    nuOrderDel            or_order.order_id%type;
    vrgOrdetrab           daor_order.styOR_order;
    nuSupplierID          ld_suppli_settings.supplier_id%TYPE;
    ftpConn               utl_tcp.connection;
    ioRecordFile          utl_file.file_type;
    inuCodeEquiPOS        LD_POS_SETTINGS.EQUIVALENCE%TYPE;

    nuType    Number := 6501;
    nuTypeDoc Number := 1;
    nuIdent   ld_promissory.identification%type;
    sbName    ld_promissory.debtorname%type;
    sbPhone   ld_promissory.propertyphone_id%type;
    sbPagare  ld_non_ba_fi_requ.digital_prom_note_cons%type;
    -- sbCodConvenio       LD_parameter.Value_Chain%type := dald_parameter.fsbGetValue_Chain('COD_INTERNO_CARDIF_CONV_FNB');
    nuSequence_id       ld_bine_cencosud.sequence_id%type;
    nusale_value_financ ld_bine_cencosud.sale_value_financ%type;
    nuOperUnit          OR_Order.Operating_Unit_Id%type;
    sbSalePoint         OR_Operating_Unit.Name%type;
    VNUTIPOCED          NUMBER;
    VNUtidocaid         NUMBER;
    v_archivo           utl_file.file_type;
    sw                  NUMBER := 0;
    sw2                 NUMBER := 0;
    vnucon              NUMBER := 1;
    vexar               NUMBER := 1;

    CURSOR cuSegVol IS
      SELECT *
        FROM LDC_SEGUROVOLUNTARIO
       WHERE file_name_anul IS NULL
         AND DIFECODI IS NOT NULL
         and estado_seguro in ('DE', 'AN')
      /*and segurovoluntario_id in
      (11, 12, 13, 14, 15, 16, 17, 18, 19, 20)*/
      ;
    -- (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

    ---cursor para identificar causal y fecha de atencion
    --de solicitud de anulacion o devolucion
    cursor cusolicitudAD(inupackage_sale number) is
      SELECT mo_motive.causal_id IdCausal, --DVM 200-2389 Se retorna la causal para validar su nuevo valor --decode(mo_motive.causal_id, 274, 22, 21) IdCausal,
             to_char(damo_packages.fdtgetattention_date(ld_return_item.package_id),
                     'YYYYMMDD') Fecha_Atencion_SolicitudAD,
             ld_return_item.package_id SolicitudAD
        FROM ld_item_work_order,
             ld_return_item_detail,
             ld_return_item,
             OR_order_activity,
             ld_article,
             mo_motive,
             cc_causal,
             ld_non_ban_fi_item
       WHERE ld_item_work_order.order_activity_id =
             ld_return_item_detail.activity_delivery_id
         AND ld_return_item_detail.return_item_id =
             ld_return_item.return_item_id
         AND ld_article.article_id = ld_return_item_detail.article_id
         AND ld_item_work_order.article_id =
             ld_return_item_detail.article_id
         AND OR_order_activity.order_activity_id =
             ld_item_work_order.order_activity_id
         AND OR_order_activity.activity_id =
             dald_parameter.fnuGetNumeric_Value('ACTIVITY_TYPE_FNB')
         AND ld_return_item.package_id = mo_motive.package_id
         AND cc_causal.causal_id = mo_motive.causal_id
         AND ld_non_ban_fi_item.non_ba_fi_requ_id =
             ld_return_item.package_sale
         AND ld_non_ban_fi_item.article_id =
             ld_return_item_detail.article_id
         and ld_return_item.package_sale = inupackage_sale
         and damo_packages.fnugetmotive_status_id(ld_return_item.package_id) =
             dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ATENDTIDO')
         and (SELECT /*+ index (L PK_LD_ARTICLE IX_LD_ARTICLE_04) */
               count(1)
                FROM LD_ARTICLE L
               WHERE l.concept_id IN
                     (select nvl(to_number(column_value), 0)
                        from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                 NULL),
                                                                ','))
                       where l.article_id = ld_return_item_detail.article_id)) > 0
         and LD_ITEM_WORK_ORDER.STATE = 'AN'
         and rownum = 1
       GROUP BY mo_motive.causal_id,
                damo_packages.fdtgetattention_date(ld_return_item.package_id),
                ld_return_item.package_id;

    rfcusolicitudAD cusolicitudAD%rowtype;

    -------------------
    -- Cambio 238 -->
    -------------------
    --Cursor para verificar si existe orden de anulacion/devolucion sobre la venta
    cursor cusolicitudAD_SB(inufindvalue number) is
      select m.package_id
        from open.mo_packages m
       where m.package_type_id = 100264 --Venta FNB
         and m.package_id = inufindvalue
         and exists (select *
                from open.or_order_activity oa, open.or_order o
               where oa.package_id = m.package_id
                 and oa.order_id = o.order_id
                 and o.Order_Status_Id in (8) --Orden Cerrada
                 and o.causal_id = 1 --Legalizada con estado exito
                 and oa.task_type_id in (12702)); --ACEPTACION DE ANULACION DE VENTA - FNB
    nusolicitudAD_SB NUMBER := null;
    -------------------
    -- Cambio 238 <--
    -------------------

    --DVM 200-2389 Causal ha aplicar basado en LDC_CAUSALHOMOL
    nuCausalID number(4) := NULL;
	
	nuTipoCausal 	NUMBER(4) := NULL;

  BEGIN
    ut_trace.trace('INICIA UT_EAN.CreateEAN_CARDIF_Anul_EFI', 2);
    --valida el consecutivo del archivo a envier

    SELECT count(*)
      into vexar
      FROM LDC_SEGUROVOLUNTARIO
     where trunc(date_file_name_anul) = trunc(sysdate)
       and DIFECODI IS NOT NULL
       and estado_seguro = 'AN';

    if vexar <> 0 then
      SELECT max(substr(file_name_anul, length(file_name_anul) - 5, 2)) + 1
        into vnucon
        FROM LDC_SEGUROVOLUNTARIO
       where trunc(date_file_name_anul) = trunc(sysdate)
         and DIFECODI IS NOT NULL
         and estado_seguro = 'AN';

    elsif vexar = 0 then
      vnucon := 1;
    end if;

    FOR RWSegVol IN cuSegVol LOOP
      ------------------------
      --Cambio 238 -->
      --Seteo de variable.
      ------------------------
      nusolicitudAD_SB := null;
      ------------------------
      --Cambio 238 <--
      ------------------------
      --Establece conexion con el FTP

      if sw = 0 then
        --Obtiene el idenficador del proveedor CARDIF
        nuSupplierID := RWSegVol.Contractor_Id;
        --Obtiene configuracion para conexion con el FTP
        GetConfigDataFTP(nuSupplierID, vtabFTP);
        --Establece conexion con el FTP
        Connect_FTP(vtabFTP, nuSupplierID, ftpConn);
        --NomArchivo:=csbFileNameEAN_CARDIF;
        v_archivo := utl_file.fopen(csbFolderOracle,
                                    csbFileNameEAN_CARDIF ||
                                    lpad(vnucon, 2, 0) || '.txt',
                                    'w');

        sw := 1;
      end if;

      FileLines := null;
      --   segurovoluntario_id, geograp_location_depa, geograp_location_loca, susccodi, package_id, product_id, article_id, difecodi, contractor_id, tarifa, codproducto,,,,,,,,,,,,,,,,,

      /*open cuDeudoFNB(inuPackageID);
      fetch cuDeudoFNB
        INTO nuIdent, sbName, sbPhone;
      close cuDeudoFNB;*/

      --Hallamos el numero de pagare
      /*      sbPagare := nvl(dald_non_ba_fi_requ.fsbgetdigital_prom_note_cons(inuPackageID),
      dald_non_ba_fi_requ.fsbGetManual_Prom_Note_Cons(inuPackageID));*/

      ----
      -- unidad operativa
      /* nuOperUnit := DAOR_Order.fnuGetOperating_Unit_Id(nuOrderDel);*/

      --  Punto de venta
      /*sbSalePoint := DAOR_Operating_Unit.fsbGetName(nuOperUnit);*/
      ----
      /*Hallar la sequencia del documento BINE para la solicitud*/
      /* select sequence_id, sale_value_financ
       into nuSequence_id, nusale_value_financ
       from ld_bine_cencosud
      where package_id = inuPackageID;*/

      /*      select escicaid
        INTO VNUTIPOCED
        from ldc_eq_esta_civi_cardif D
       WHERE D.esciosfid = nvl(RWSegVol.tipoidasegurado, 1)
         AND ROWNUM = 1;

      select tidocaid
        INTO VNUtidocaid
        from ldc_eq_tipo_docu_cardif
       WHERE tidosfid = nvl(RWSegVol.estado_civil, 1)
         AND ROWNUM = 1;*/

      --Configura Linea para agregar al documento

      open cusolicitudAD(RWSegVol.PACKAGE_ID);
      fetch cusolicitudAD
        into rfcusolicitudAD;

      --if nvl(rfcusolicitudAD.Fecha_Atencion_Solicitudad,0) <> 0 then
      if cusolicitudAD%found then

        --DVM 200-2389 Determinar la Causal ha aplicar
        SELECT CH.CAUSAL_CARDIF
          INTO nuCausalID
          FROM LDC_CAUSALHOMOL CH
         WHERE CH.CAUSAL_OSF = rfcusolicitudAD.Idcausal;

        if nuCausalID is null then
          nuCausalID := dald_parameter.fnuGetNumeric_Value('PAR_CAUSAL_CARDIF_DEF');
        end if;
        ---

		nuTipoCausal := DALDC_TIPOCAUSALCARDIF.fnuGetTIPO_CAUSAL(nuCausalID, 0);
		
		 IF (nuTipoCausal IS NULL) THEN
			nuTipoCausal := dald_parameter.fnuGetNumeric_Value('PAR_TIPOCAUSAL_CARDIF_DEF');
		 END IF;

        FileLines := nuType /* RWSegVol.Codproducto se cambio en caso 200-2645*/
                     || ';' || nuTipoCausal || ';' || nuCausalID || ';' || --DVM 200-2389 Se reemplazo la Causal rfcusolicitudAD.Idcausal
                     rfcusolicitudAD.Fecha_Atencion_Solicitudad || ';' ||
                     RWSegVol.idasegurado || ';' || RWSegVol.Susccodi || ';' ||
                    -- RWSegVol.numeroproductocrediticio || ';' || se cambio en caso 200-2023
                     RWSegVol.PACKAGE_ID;

        /*FileLines := nuType || ';' || 2 || ';' ||
        RWSegVol.causal_anulacion_devolucion || ';' ||
        to_char(sysdate, 'YYYYMMDD') || ';' ||
        RWSegVol.idasegurado || ';' ||
        RWSegVol.numeroproductocrediticio || ';' ||
        RWSegVol.PACKAGE_ID;*/

        utl_file.put_line(v_archivo, FileLines);
        update ldc_segurovoluntario
           set /* segurovoluntario_id = v_segurovoluntario_id,
                geograp_location_depa = v_geograp_location_depa,
               geograp_location_loca = v_geograp_location_loca,
               susccodi = v_susccodi,
               package_id = v_package_id,*/ product_id = pktbldiferido.fnugetdifenuse(difecodi),
               /* article_id = v_article_id,
               difecodi = v_difecodi,
               contractor_id = v_contractor_id,
               tarifa = v_tarifa,
               codproducto = v_codproducto,
               iniciovigencia = v_iniciovigencia,
               finvigencia = v_finvigencia,
               plancardif = v_plancardif,
               tipoidasegurado = v_tipoidasegurado,
               idasegurado = v_idasegurado,
               primerapellidoasegurado = v_primerapellidoasegurado,
               segundoapellidoasegurado = v_segundoapellidoasegurado,
               primernombreasegurado = v_primernombreasegurado,
               segundonombreasegurado = v_segundonombreasegurado,
               genero_asegurado = v_genero_asegurado,
               estado_civil = v_estado_civil,
               fecnacimientoasegurado = v_fecnacimientoasegurado,
               telasegurado = v_telasegurado,
               celasegurado = v_celasegurado,
               direccionasegurado = v_direccionasegurado,
               ciudadasegurado = v_ciudadasegurado,
               nacionalidad = v_nacionalidad,
               pais_residencia = v_pais_residencia,
               pais_nacimiento_asegurado = v_pais_nacimiento_asegurado,
               emailasegurado = v_emailasegurado,
               prima_antes_iva = v_prima_antes_iva,
               prima_iva_incluido = v_prima_iva_incluido,
               codigoproductobancario = v_codigoproductobancario,
               numeroproductocrediticio = v_numeroproductocrediticio,
               plazocredito = v_plazocredito,
               valorcredito = v_valorcredito,
               valorcuotacredito = v_valorcuotacredito,
               canal = v_canal,
               codigoasesor = v_codigoasesor,
               documentoasesor = v_documentoasesor,
               nombreasesor = v_nombreasesor,
               sucursal = v_sucursal,
               estado_seguro = v_estado_seguro,*/
               package_anu_dev     = rfcusolicitudAD.Solicitudad,
               file_name_anul      = csbFileNameEAN_CARDIF ||
                                     lpad(vnucon, 2, 0) || '.txt',
               date_file_name_anul = sysdate,
               /*file_name_anul = v_file_name_anul,
               date_file_name_anul = v_date_file_name_anul,*/
               causal_anulacion_devolucion = nuCausalID --DVM 200-2389 Se reemplazo la Causal rfcusolicitudAD.Idcausal
        /*refinanciado = v_refinanciado,
        order_activity_id = v_order_activity_id*/
         where segurovoluntario_id = RWSegVol.segurovoluntario_id;
        sw2 := 1;
      else
        ------------------
        -- Cambio 238 -->
        ------------------
        --Verifica si existe orden de anulacion/devolucion sobre la venta
        open cusolicitudAD_SB(RWSegVol.PACKAGE_ID);
        fetch cusolicitudAD_SB
          into nusolicitudAD_SB;
        close cusolicitudAD_SB;
        --Si existe procedemos a agregar el archivo con la misma logica original
        --Se quitan comentarios para simplificar codigo
        if nusolicitudAD_SB is not null then
          nuCausalID := RWSegVol.Causal_Anulacion_Devolucion;
          /* --Determinar la Causal a aplicar
          BEGIN
            SELECT CH.CAUSAL_CARDIF
              INTO nuCausalID
              FROM LDC_CAUSALHOMOL CH
             WHERE CH.CAUSAL_OSF = RWSegVol.Causal_Anulacion_Devolucion;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              nuCausalID := null;
          END;*/

          if nuCausalID is null then
            nuCausalID := dald_parameter.fnuGetNumeric_Value('PAR_CAUSAL_CARDIF_DEF');
          end if;
          ---

		  nuTipoCausal := DALDC_TIPOCAUSALCARDIF.fnuGetTIPO_CAUSAL(nuCausalID, 0);
		
		   IF (nuTipoCausal IS NULL) THEN
			  nuTipoCausal := dald_parameter.fnuGetNumeric_Value('PAR_TIPOCAUSAL_CARDIF_DEF');
		  END IF;

          FileLines := RWSegVol.Codproducto || ';' || nuTipoCausal || ';' ||
                       nuCausalID || ';' ||
                       to_char(trunc(RWSegVol.Anuldev_Date), 'YYYYMMDD') || ';' ||
                       RWSegVol.idasegurado || ';' || RWSegVol.Susccodi || ';' ||
                       RWSegVol.PACKAGE_ID;

          utl_file.put_line(v_archivo, FileLines);
          update ldc_segurovoluntario
             set product_id                  = pktbldiferido.fnugetdifenuse(difecodi),
                 package_anu_dev             = rfcusolicitudAD.Solicitudad,
                 file_name_anul              = csbFileNameEAN_CARDIF ||
                                               lpad(vnucon, 2, 0) || '.txt',
                 date_file_name_anul         = sysdate,
                 causal_anulacion_devolucion = nuCausalID
           where segurovoluntario_id = RWSegVol.segurovoluntario_id;
          sw2 := 1;
        end if;
        ------------------
        -- Cambio 238 <--
        ------------------
      end if;

      close cusolicitudAD;
      --Agrega linea en documento
    --CreateFileEAN_CARDIF(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
    --  LD_BOPACKAGEFNB.proWriteFile(FileLines, csbFileNameEAN_CARDIF, ioRecordFile);
    END LOOP;
    if sw != 0 then
      utl_file.fclose(v_archivo);
      ftp.logout(ftpConn);
      utl_tcp.close_all_connections;

      if (sw2 = 1) then
        --Copia el archivo EAN a Ftp Externo
        CopyToFTP(vtabFTP(nuSupplierID).DIIP,
                  vtabFTP(nuSupplierID).USUA,
                  vtabFTP(nuSupplierID).PAWD,
                  csbFileNameEAN_CARDIF || lpad(vnucon, 2, 0) || '.txt',
                  vtabFTP(nuSupplierID).RUTA);
      end if;
    end if;
    ut_trace.trace('FIN UT_EAN.CreateEAN_CARDIF_Anul_EFI', 2);

  EXCEPTION
    WHEN OTHERS THEN
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END CreateEAN_CARDIF_Anul_EFI;
  --Caso 200-2645(Fin)

END UT_EAN_CARDIF;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('UT_EAN_CARDIF', 'ADM_PERSON'); 
END;
/