CREATE OR REPLACE PACKAGE adm_person.ldc_pkgenvenformasi AS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKGENVENFORMASI
  Descripcion    : Paquete para el PB LDCVEFM el cual procesa un archivo plano para generacion
                   masiva de ventas por formulario
                   El proceso lee el archivo plano y genera las solicitudes de ventas
  Autor          : Karem Baquero
  Fecha          : 22/08/2016 ERS 200-465

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  13-07-2017    SEBASTIAN TAPIAS         Caso 200-1283 || Se corrigen tamaño de variables,
                                         Se agrega nuevo procedimiento RegErrXml
  23-04-2018    Eduardo Cerón            Caso 200-1559. Se modifica <ProcArmaXMLVenta>
  24-01-2024    jpinedc                  OSF-2017: En Generateventfor se reemplaza
                                         el código por NULL
  26/06/2024    Adrianavg                OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
  ******************************************************************/
  ------------------
  -- Constantes
  ------------------
  csbYes constant varchar2(1) := 'Y';
  csbNo  constant varchar2(1) := 'N';
  -- cnuValorTopeAjuste constant number := 1;
  -- Error en la configuracion normal de cuotas
  -- cnuERROR_CUOTA constant number(6) := 10381;

  -----------------------
  -- Variables
  -----------------------

  nuDepa cuencobr.cucodepa%type;
  nuLoca cuencobr.cucoloca%type;
  --------------------Variables a extraer

  sbdtfecsol           varchar2(100);
  nuId                 varchar2(100);
  nuOPERUNITID         varchar2(100);
  nuDOCUMENTTYPEID     varchar2(100);
  nuDOCUMENTKEY        varchar2(100);
  sbPROJECTID          varchar2(100);
  sbCOMMENT_           varchar2(2000); --Se cambia de 100 a 2000 || Ca 200-1283
  nuDIRECCION          varchar2(100);
  nuCategoria          varchar2(100);
  nuSubcategoria       varchar2(100);
  nuTIPOIDENTIFICACION varchar2(100);
  nuIDENTIFICATION     varchar2(100);
  sbSUBSCRIBER_NAME    varchar2(100);
  sbAPELLIDO           varchar2(100);
  nuCOMPANY            varchar2(100);
  sbTITLE              varchar2(100);
  sbmail               varchar2(100);
  nuPERSONQUANTITY     varchar2(100);
  nuOLDOPERATOR        varchar2(100);
  sbVENTAEMPAQUETADA   varchar2(100);
  sbTELEFONOSCONTACTO  varchar2(100);
  sbREFERENCIAS        varchar2(100);
  nuCOMMERCIALPLAN     varchar2(100);
  sbPROMOCIONES        varchar2(2000); --Se cambia de 1000 a 2000 || Ca 200-1283
  nuTOTALVALUE         varchar2(100);
  nuPLANFINANCIACION   varchar2(100);
  nuNUMEROCUOTAS       varchar2(100);
  nuCUOTAMENSUAL       varchar2(100);
  nuINITPAYMENT        varchar2(100);
  nuUSAGE              varchar2(100);
  sbINSTALLTYPE        varchar2(100);
  sbInit_Payment_Mode  varchar2(100);
  sbInit_Pay_Received  varchar2(100);

  --INICIO CA 200-2437
  sbTecnicoVenta         varchar2(100);
  sbUnidadInstaladora    varchar2(100);
  sbUnidadCertificadora  varchar2(100);
  sbTipoPredio           varchar2(100);
  sbPredioConstruccion   varchar2(100);
  sbPredioIndependi      varchar2(100);
  sbNumeroContrato       varchar2(100);
  sbNumeroMedidor        varchar2(100);
  sbestadoLey            varchar2(100);
  --FIN CA 200-2437

  ErrorXml             varchar2(12000); --Se agrega para registro de errores del xml || Ca 200-1283
  -----------------------
  -- Elementos Packages
  -----------------------
  FUNCTION fboGetIsNumber(isbValor varchar2) return boolean;

  PROCEDURE procinserinfref(sbcadena        in ld_parameter.value_chain%type,
                            nuRefGP         in number,
                            onuErrorCode    out number,
                            osbErrorMessage out varchar2);

  PROCEDURE Generateventfor(onupack         out mo_packages.package_id%type,
                            onuErrorCode    out number,
                            osbErrorMessage out varchar2);

  PROCEDURE ReadTextFile;

  PROCEDURE LDCVEFM;
  --Se agrega para registro de errores del xml || Ca 200-1283
  procedure RegErrXml(sequence  number,
                      sbline varchar2);
  --

END LDC_PKGENVENFORMASI;
/
CREATE OR REPLACE package body adm_person.LDC_PKGENVENFORMASI AS
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKGENVENFORMASI
  Descripcion    : Paquete para el PB LDCVEFM el cual procesa un archivo plano para generacion
                   masiva de ventas por formulario
                   El proceso lee el archivo plano y genera las solicitudes de ventas
  Autor          : Karem Baquero
  Fecha          : 22/08/2016 ERS 200-465

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  13-07-2017    SEBASTIAN TAPIAS        cambios realizados bajo el caso 200-1283.
                                        Se corrigen valores de variables,
                                        Se agregan validaciones para datos nulos,
                                        Se crea nueno servicio RegErrXml
  23-04-2018    Eduardo Cerón           Caso 200-1559. Se modifica <Generateventfor>
  ******************************************************************/

  ------------------
  -- Constantes
  ------------------
  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  --csbVersion CONSTANT VARCHAR2(250) := 'CA200465';
  csbVersion CONSTANT VARCHAR2(250) := 'CA2001559';

  -- Nombre del programa ejecutor Generate Invoice
  csbPROGRAMA constant varchar2(4) := 'ANDM';

  -- Maximo numero de registros Hash para Parametros o cadenas
  cnuHASH_MAX_RECORDS constant number := 100000;

  -- Constante de error de no Aplicacion para el API OS_generateInvoice
  cnuERRORNOAPLI number := 500;

  cnuNivelTrace constant number(2) := 5;
  -----------------------
  -- Variables
  -----------------------
  sbErrMsg varchar2(2000); -- Mensajes de Error

  -- Programa
  sbApplication varchar2(10);

  sbgUser     varchar2(50); -- Nombre usuario
  sbgTerminal varchar2(50); -- Terminal
  gnuPersonId ge_person.person_id%type; -- Id de la persona

  sbPath varchar2(500);
  sbFile varchar2(500);

  --********************************************************************************************
  --------------------------------------------------------------

  FUNCTION fboGetIsNumber(isbValor varchar2) return boolean is

    blResult boolean := TRUE;
    nuRes    number;

  BEGIN
    begin
      nuRes := to_number(isbValor);
    exception
      when others then
        blResult := FALSE;
    end;

    return(blResult);

  EXCEPTION
    when others then
      return(FALSE);
  END fboGetIsNumber;

  --********************************************************************************************
  --------------------------------------------------------------

  PROCEDURE procinserinfphon
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Generateventfor
    Descripcion    : Procedimiento que inserta los valores de telefonos en la tabla
    Autor          : Karem Baquero
    Fecha          : 27/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
  (sbcadena        in ld_parameter.value_chain%type,
   nuTelG          in number,
   onuErrorCode    out number,
   osbErrorMessage out varchar2) IS

    /*se inserta en la tabla los valores de */
  begin

    insert into LDC_VENFORMASITELE

      (SELECT nuTelG,
              substr(sbcadena, 1, instr(sbcadena, ',', 1, 1) - 1) phone_id,
              substr(sbcadena, instr(sbcadena, ',', 1, 1) + 1) phone
         from dual);
    /*commit;*/

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      raise ex.CONTROLLED_ERROR;
    when others then
      rollback;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end procinserinfphon;

  --********************************************************************************************
  --------------------------------------------------------------

  PROCEDURE procinserinfref
  /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Generateventfor
    Descripcion    : Procedimiento que inserta los valores de referencia en la tabla
    Autor          : Karem Baquero
    Fecha          : 27/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
  (sbcadena        in ld_parameter.value_chain%type,
   nuRefGP         in number,
   onuErrorCode    out number,
   osbErrorMessage out varchar2) IS

    /*se inserta en la tabla los valores de */
  begin
    insert into LDC_VENFORMASIREF
      (SELECT nuRefGP,
              substr(sbcadena, 1, instr(sbcadena, ',', 1, 1) - 1) ref,
              substr(sbcadena,
                     instr(sbcadena, ',', 1, 1) + 1,
                     (instr(sbcadena, ',', 1, 2)) -
                     (instr(sbcadena, ',', 1, 1) + 1)) nombre,

              substr(sbcadena,
                     instr(sbcadena, ',', 1, 2) + 1,
                     (instr(sbcadena, ',', 1, 3)) -
                     (instr(sbcadena, ',', 1, 2) + 1)) apellido,
              substr(sbcadena,
                     instr(sbcadena, ',', 1, 3) + 1,
                     (instr(sbcadena, ',', 1, 4)) -
                     (instr(sbcadena, ',', 1, 3) + 1)) direccion,
              substr(sbcadena, instr(sbcadena, ',', 1, 4) + 1) telefono

         FROM dual);
    /*commit;*/

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      raise ex.CONTROLLED_ERROR;
    when others then
      rollback;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end procinserinfref;

  --********************************************************************************************
  --------------------------------------------------------------

    PROCEDURE Generateventfor
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : Generateventfor
    Descripcion    : Procedimiento que genera todo el proceso para cada venta de formulario leido
                     en el archivo plano
    Autor          : Karem Baquero
    Fecha          : 25/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    13-07-2017    SEBTAP               Se modifica valor de variables y se crea un nuevo xml
                                       para referencias de error.
    23-04-2018    Eduardo Cerón        Se adicionan los campos UNIDAD_DE_TRABAJO_INSTALADORA y
                                       UNIDAD_DE_TRABAJO_CERTIFICADORA
    05/04/2019    ELAL                  CA 200-2437 se agregan nuevos campos numero de medidor, predio en construccion, predio de independizacion
                                        contrato, estado de ley
    24-01-2024    jpinedc               OSF-2017: En Generateventfor se reemplaza
                                        el código por NULL
    ******************************************************************/
    (onupack         out mo_packages.package_id%type,
   onuErrorCode    out number,
   osbErrorMessage out varchar2) IS

    begin
        NULL;
    END Generateventfor;

  --********************************************************************************************

  PROCEDURE LDCVEFM IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LDCVEFM
    Descripcion    : Procedimiento llamado por el PB
    Autor          : Karem Baquero
    Fecha          : 22/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/

    sbSISTDIRE        ge_boInstanceControl.stysbValue;
    sbFileManagementr utl_file.file_type;

  BEGIN

    UT_TRACE.TRACE('**************** Inicio LDC_PKGENVENFORMASI.LDCVEFM',
                   10);

    sbSISTDIRE := ge_boInstanceControl.fsbGetFieldValue('SISTEMA','SISTDIRE');

    if (sbSISTDIRE is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'El Nombre de Achivo no debe ser nulo');
      raise ex.CONTROLLED_ERROR;
    end if;

    sbPath := dald_parameter.fsbGetValue_Chain('RUTA_ARCH_VENFORM_MASIVAS'); -- '/smartfiles/cartera';
    sbFile := sbSISTDIRE;

    -- valida que exista el archivo
    begin
      sbFileManagementr :=pkUtlFileMgr.fOpen(sbPath, sbFile, 'r');
    exception
      when others then
        pkUtlFileMgr.fClose(sbFileManagementr);
        Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                        'Error ... Archivo no Existe o no se pudo abrir '||sqlerrm);
        raise ex.CONTROLLED_ERROR;

    end;

    ReadTextFile;

    UT_TRACE.TRACE('**************** Fin LDC_PKGENVENFORMASI.ldcvefm', 10);

  END LDCVEFM;

  --********************************************************************************************
  PROCEDURE ReadTextFile IS

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ReadTextFile
    Descripcion    : Procedimiento que recorre el archivo plano, valida los campos
                     y genera las ventas por formulario que se encuentran en este archivo
    Fecha          : 25/08/2016 ERS 200-465

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============   ===================
    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================
    13/05/2019    ELAL                    CA 200-2437 se agrega lectura de los campos nuevos de la venta de gas por formulario
                                          Unidad instaladora, unidad certificadora, tipo de predio, predio en construccion, predio en independizacion
                                          numero de contrato, numero de medidor, estado de ley.

    13-07-2017    SEBTAP                  Se crean variables para manejo de error,
                                          Se agrengan lineas de error al LOG
                                          Se valida que las referencias y las promociones no sean nulas.
    ******************************************************************/

    cnuZERO constant number := pkBillConst.CERO;
    cnuONE  constant number := LD_BOConstans.cnuonenumber;

    sbFileGl varchar2(100);
    sbExt    varchar2(10);
    sbOnline varchar2(5000);

    /* Variables para conexion*/

    sbFileManagement  utl_file.file_type;
    sbFileManagementd utl_file.file_type;
    nuLinea           number;
    nuCodigo          number;

    cnuend_of_file constant number := 1;

    nuerror   number;
    sbmessage varchar2(2000);

    /*Variables de archivo de log*/

    sbLog          varchar2(500); -- Log de errores
    sbLineLog      varchar2(1000);
    /*Cambio 200-1283*/
    sbLineLog_2    varchar2(1000);
    sequence_id  number;
    /*Fin Cambio 200-1283*/
    sbTimeProc     varchar2(500);
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuMonth        number;

    ------------ Variables del archivo
    sbLineFile   varchar2(1000);
    vnuexito     number := 0;
    vnunoexito   number := 0;
    sbAsunto     varchar2(2000);
    vsbmessage   varchar2(2000);
    vsbSendEmail ld_parameter.value_chain%TYPE; --Direccion de email quine firma el email
    vsbrecEmail  ld_parameter.value_chain%TYPE; --Direccion de email que recibe

    nuContador number := 1;
    nuIndex    number;
    onupackg   number;

    ------------------------

  BEGIN

    sbTimeProc := TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss');

    /* Arma nombre del archivo LOG */
    sbLog := sbFile || '_' || sbTimeProc || '.LOG';

    /* Crea archivo Log */
    sbFileManagementd := pkUtlFileMgr.Fopen(sbPath, sbLog, 'w');

    begin
      sbFileManagement := pkUtlFileMgr.fOpen(sbPath, sbFile, 'r');
    exception
      when others then
        sbLineLog := '     Error ... No se pudo abrir archivo ' || sbPath || ' ' ||
                     sbFile || ' ' || chr(13) || sqlerrm;
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO FinProceso;
    end;

    nuLinea := 0;

    -- ciclo de lectura de lineas del archivo
    loop
      sbLineLog := NULL;
      nuLinea   := nuLinea + 1;
      nuCodigo  := pkUtlFileMgr.get_line(sbFileManagement, sbOnline);
      exit when(nuCodigo = cnuend_of_file);

      /*Obtiene la frecha de la solicitud*/
      /*sbdtfecsol := substr(sbOnline,
                            1,
                            instr(sbOnline, '|', 1, 1) - 1);*/

       sbdtfecsol := substr(sbOnline,
                     instr(sbOnline, '|', 1, 1) + 1,
                     (instr(sbOnline, '|', 1, 2)) -
                     (instr(sbOnline, '|', 1, 1) + 1));

      /*Obtiene el person ID*/
      nuId := substr(sbOnline,
                     instr(sbOnline, '|', 1, 2) + 1,
                     (instr(sbOnline, '|', 1, 3)) -
                     (instr(sbOnline, '|', 1, 2) + 1));

      /*Obtiene la unidad operativa*/
      nuOPERUNITID := substr(sbOnline,
                             instr(sbOnline, '|', 1, 3) + 1,
                             (instr(sbOnline, '|', 1, 4)) -
                             (instr(sbOnline, '|', 1, 3) + 1));

      /*Obtien el tipo de documento*/
      nuDOCUMENTTYPEID := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 4) + 1,
                                 (instr(sbOnline, '|', 1, 5)) -
                                 (instr(sbOnline, '|', 1, 4) + 1));

      /*Obtiene el documento*/
      nuDOCUMENTKEY := substr(sbOnline,
                              instr(sbOnline, '|', 1, 5) + 1,
                              (instr(sbOnline, '|', 1, 6)) -
                              (instr(sbOnline, '|', 1, 5) + 1));

      /**/
      sbPROJECTID := substr(sbOnline,
                            instr(sbOnline, '|', 1, 6) + 1,
                            (instr(sbOnline, '|', 1, 7)) -
                            (instr(sbOnline, '|', 1, 6) + 1));

      /*Obtiene la observacion*/
      sbCOMMENT_ := substr(sbOnline,
                           instr(sbOnline, '|', 1, 7) + 1,
                           (instr(sbOnline, '|', 1, 8)) -
                           (instr(sbOnline, '|', 1, 7) + 1));

      /*Obtiene la direccion*/
      nuDIRECCION := substr(sbOnline,
                            instr(sbOnline, '|', 1, 8) + 1,
                            (instr(sbOnline, '|', 1, 9)) -
                            (instr(sbOnline, '|', 1, 8) + 1));

      nuCategoria := substr(sbOnline,
                            instr(sbOnline, '|', 1, 9) + 1,
                            (instr(sbOnline, '|', 1, 10)) -
                            (instr(sbOnline, '|', 1, 9) + 1));

      nuSubcategoria := substr(sbOnline,
                               instr(sbOnline, '|', 1, 10) + 1,
                               (instr(sbOnline, '|', 1, 11)) -
                               (instr(sbOnline, '|', 1, 10) + 1));

      /*Obtien el tipo de identificacion*/
      nuTIPOIDENTIFICACION := substr(sbOnline,
                                     instr(sbOnline, '|', 1, 11) + 1,
                                     (instr(sbOnline, '|', 1, 12)) -
                                     (instr(sbOnline, '|', 1, 11) + 1));

      nuIDENTIFICATION := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 12) + 1,
                                 (instr(sbOnline, '|', 1, 13)) -
                                 (instr(sbOnline, '|', 1, 12) + 1));

      sbSUBSCRIBER_NAME := substr(sbOnline,
                                  instr(sbOnline, '|', 1, 13) + 1,
                                  (instr(sbOnline, '|', 1, 14)) -
                                  (instr(sbOnline, '|', 1, 13) + 1));

      sbAPELLIDO := substr(sbOnline,
                           instr(sbOnline, '|', 1, 14) + 1,
                           (instr(sbOnline, '|', 1, 15)) -
                           (instr(sbOnline, '|', 1, 14) + 1));

      nuCOMPANY := substr(sbOnline,
                          instr(sbOnline, '|', 1, 15) + 1,
                          (instr(sbOnline, '|', 1, 16)) -
                          (instr(sbOnline, '|', 1, 15) + 1));

      sbTITLE := substr(sbOnline,
                        instr(sbOnline, '|', 1, 16) + 1,
                        (instr(sbOnline, '|', 1, 17)) -
                        (instr(sbOnline, '|', 1, 16) + 1));

      sbmail := substr(sbOnline,
                       instr(sbOnline, '|', 1, 17) + 1,
                       (instr(sbOnline, '|', 1, 18)) -
                       (instr(sbOnline, '|', 1, 17) + 1));

      nuPERSONQUANTITY := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 18) + 1,
                                 (instr(sbOnline, '|', 1, 19)) -
                                 (instr(sbOnline, '|', 1, 18) + 1));

      nuOLDOPERATOR := substr(sbOnline,
                              instr(sbOnline, '|', 1, 19) + 1,
                              (instr(sbOnline, '|', 1, 20)) -
                              (instr(sbOnline, '|', 1, 19) + 1));

      sbVENTAEMPAQUETADA := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 20) + 1,
                                   (instr(sbOnline, '|', 1, 21)) -
                                   (instr(sbOnline, '|', 1, 20) + 1));

      sbTELEFONOSCONTACTO := substr(sbOnline,
                                    instr(sbOnline, '|', 1, 21) + 1,
                                    (instr(sbOnline, '|', 1, 22)) -
                                    (instr(sbOnline, '|', 1, 21) + 1));

      sbREFERENCIAS := substr(sbOnline,
                              instr(sbOnline, '|', 1, 22) + 1,
                              (instr(sbOnline, '|', 1, 23)) -
                              (instr(sbOnline, '|', 1, 22) + 1));

      nuCOMMERCIALPLAN := substr(sbOnline,
                                 instr(sbOnline, '|', 1, 23) + 1,
                                 (instr(sbOnline, '|', 1, 24)) -
                                 (instr(sbOnline, '|', 1, 23) + 1));

      sbPROMOCIONES := substr(sbOnline,
                              instr(sbOnline, '|', 1, 24) + 1,
                              (instr(sbOnline, '|', 1, 25)) -
                              (instr(sbOnline, '|', 1, 24) + 1));

      nuTOTALVALUE := substr(sbOnline,
                             instr(sbOnline, '|', 1, 25) + 1,
                             (instr(sbOnline, '|', 1, 26)) -
                             (instr(sbOnline, '|', 1, 25) + 1));

      nuPLANFINANCIACION := substr(sbOnline,
                                   instr(sbOnline, '|', 1, 26) + 1,
                                   (instr(sbOnline, '|', 1, 27)) -
                                   (instr(sbOnline, '|', 1, 26) + 1));

      nuNUMEROCUOTAS := substr(sbOnline,
                               instr(sbOnline, '|', 1, 27) + 1,
                               (instr(sbOnline, '|', 1, 28)) -
                               (instr(sbOnline, '|', 1, 27) + 1));

      nuCUOTAMENSUAL := substr(sbOnline,
                               instr(sbOnline, '|', 1, 28) + 1,
                               (instr(sbOnline, '|', 1, 29)) -
                               (instr(sbOnline, '|', 1, 28) + 1));

      nuINITPAYMENT := substr(sbOnline,
                              instr(sbOnline, '|', 1, 29) + 1,
                              (instr(sbOnline, '|', 1, 30)) -
                              (instr(sbOnline, '|', 1, 29) + 1));

      sbInit_Payment_Mode := substr(sbOnline,
                                    instr(sbOnline, '|', 1, 30) + 1,
                                    (instr(sbOnline, '|', 1, 31)) -
                                    (instr(sbOnline, '|', 1, 30) + 1));

      sbInit_Pay_Received := substr(sbOnline,
                                    instr(sbOnline, '|', 1, 31) + 1,
                                    (instr(sbOnline, '|', 1, 32)) -
                                    (instr(sbOnline, '|', 1, 31) + 1));

      nuUSAGE := substr(sbOnline,
                        instr(sbOnline, '|', 1, 32) + 1,
                        (instr(sbOnline, '|', 1, 33)) -
                        (instr(sbOnline, '|', 1, 32) + 1));

      sbINSTALLTYPE := substr(sbOnline,
                              instr(sbOnline, '|', 1, 33) + 1,
                              (instr(sbOnline, '|', 1, 34)) -
                              (instr(sbOnline, '|', 1, 33) + 1));

      --INICIO CA 200-2437

      sbTecnicoVenta    := substr(sbOnline,
                              instr(sbOnline, '|', 1, 34) + 1,
                              (instr(sbOnline, '|', 1, 35)) -
                              (instr(sbOnline, '|', 1, 34) + 1));

      sbUnidadInstaladora := substr(sbOnline,
                              instr(sbOnline, '|', 1, 35) + 1,
                              (instr(sbOnline, '|', 1, 36)) -
                              (instr(sbOnline, '|', 1, 35) + 1));

      sbUnidadCertificadora := substr(sbOnline,
                              instr(sbOnline, '|', 1, 36) + 1,
                              (instr(sbOnline, '|', 1, 37)) -
                              (instr(sbOnline, '|', 1, 36) + 1));

      sbTipoPredio := substr(sbOnline,
                              instr(sbOnline, '|', 1, 37) + 1,
                              (instr(sbOnline, '|', 1, 38)) -
                              (instr(sbOnline, '|', 1, 37) + 1));

      sbPredioConstruccion := substr(sbOnline,
                              instr(sbOnline, '|', 1, 38) + 1,
                              (instr(sbOnline, '|', 1, 39)) -
                              (instr(sbOnline, '|', 1, 38) + 1));

      sbPredioIndependi := substr(sbOnline,
                              instr(sbOnline, '|', 1, 39) + 1,
                              (instr(sbOnline, '|', 1, 40)) -
                              (instr(sbOnline, '|', 1, 39) + 1));

      sbNumeroContrato := substr(sbOnline,
                              instr(sbOnline, '|', 1, 40) + 1,
                              (instr(sbOnline, '|', 1, 41)) -
                              (instr(sbOnline, '|', 1, 40) + 1));

      sbNumeroMedidor := substr(sbOnline,
                              instr(sbOnline, '|', 1, 41) + 1,
                              (instr(sbOnline, '|', 1, 42)) -
                              (instr(sbOnline, '|', 1, 41) + 1));

      sbestadoLey := substr(sbOnline,
                              instr(sbOnline, '|', 1, 42) + 1,
                              (instr(sbOnline, '|', 1, 43)) -
                              (instr(sbOnline, '|', 1, 42) + 1));
      --FIN CA 200-2437

      ----------------- validaciones  ----------------------

      if sbdtfecsol is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Fecha de la solicitud Nula' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuId is null or not fboGetIsNumber(nuId) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'person id  Nula o no numerica' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuOPERUNITID is null or not fboGetIsNumber(nuOPERUNITID) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'person id  Nula o no numerica' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuDOCUMENTTYPEID is null or not fboGetIsNumber(nuDOCUMENTTYPEID) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'tipo de documento  Nulo o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuDOCUMENTKEY is null or not fboGetIsNumber(nuDOCUMENTKEY) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'documento  Nulo o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      /*revisar si es numerico o no*/
      /*  if trim(sbPROJECTID) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Observacion Nula' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;*/

      if trim(sbCOMMENT_) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Observacion Nula' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuDIRECCION is null or not fboGetIsNumber(nuDIRECCION) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Direcci?n  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuTIPOIDENTIFICACION is null or
         not fboGetIsNumber(nuTIPOIDENTIFICACION) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Direcci?n  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(nuIDENTIFICATION) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'identificacion  Nula' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbSUBSCRIBER_NAME) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Nombre  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbAPELLIDO) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Apellido  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(nuCOMPANY) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'empresa  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbTITLE) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'titulo  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbmail) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'correo electronico  Nulo' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuPERSONQUANTITY is null or not fboGetIsNumber(nuPERSONQUANTITY) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Personas a cargo  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuCOMMERCIALPLAN is null or not fboGetIsNumber(nuCOMMERCIALPLAN) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'plan comercial  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuPLANFINANCIACION is null or
         not fboGetIsNumber(nuPLANFINANCIACION) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'plan de financiaci?n  Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuTOTALVALUE is null or not fboGetIsNumber(nuTOTALVALUE) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor total de la venta  Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuCUOTAMENSUAL is null or not fboGetIsNumber(nuCUOTAMENSUAL) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor de la cuota mensual Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if nuINITPAYMENT is null or not fboGetIsNumber(nuINITPAYMENT) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'cuota inicial Nula o no numerico' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if trim(sbTELEFONOSCONTACTO) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Telefonos de contacto  Nulo' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;
      /*Cambio 200-1283*/
      if trim(sbREFERENCIAS) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'Informaci?n de referencia  Nulo' || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

     if trim(sbPROMOCIONES) is null then
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'promociones  Nulo' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;
      /*Cambio 200-1283*/
      -- nuOLDOPERATOR varchar2(100);
      --sbVENTAEMPAQUETADA varchar2(100);

      --INICIO CA 200-2437
      if sbTecnicoVenta is null or not fboGetIsNumber(sbTecnicoVenta) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor del tecnico de venta es Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if sbUnidadInstaladora is null or not fboGetIsNumber(sbUnidadInstaladora) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor de la unidad instaladora es Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if sbUnidadCertificadora is null or not fboGetIsNumber(sbUnidadCertificadora) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor de la unidad certificadora es Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if sbestadoLey is null or not fboGetIsNumber(sbestadoLey) then
        sbLineLog := ' Linea ' || nuLinea || '. ' ||
                     'valor del estado de ley es Nula o no numerico' ||
                     chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
        GOTO nextLine;
      end if;

      if sbTipoPredio is not null then
        if not fboGetIsNumber(sbTipoPredio) then
            sbLineLog := ' Linea ' || nuLinea || '. ' ||
                         'valor del tipo de predio no numerico' ||
                         chr(13);
            pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
            GOTO nextLine;
        end if;
      end if;

      if sbPredioConstruccion is not null then
        if sbPredioConstruccion not in ('N','Y') then
            sbLineLog := ' Linea ' || nuLinea || '. ' ||
                         'valor del predio en construccion solo permite (N/Y)' ||
                         chr(13);
            pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
            GOTO nextLine;
        end if;
      end if;

      if sbPredioIndependi is not null then
        if sbPredioIndependi not in ('N','Y') then
            sbLineLog := ' Linea ' || nuLinea || '. ' ||
                         'valor del predio de  independizacion solo permite (N/Y)' ||
                         chr(13);
            pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
            GOTO nextLine;
        end if;

        if sbPredioIndependi = 'Y' AND (sbNumeroContrato IS NULL or not fboGetIsNumber(sbNumeroContrato)) THEN
          sbLineLog := ' Linea ' || nuLinea || '. ' ||
                         'valor del numero de contrato es nulo o no numerico, y el flag de predio de independizacion esta en Y' ||
                         chr(13);
            pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
            GOTO nextLine;
        END IF;

        if sbPredioIndependi = 'N' AND sbNumeroContrato IS NOT NULL  THEN
          sbLineLog := ' Linea ' || nuLinea || '. ' ||
                         'valor del numero de contrato debe ser nulo porque flag de predio de independizacion esta en N' ||
                         chr(13);
            pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
            GOTO nextLine;
        END IF;

        if sbPredioIndependi = 'Y' AND sbNumeroContrato IS not NULL and sbNumeroMedidor is null THEN
          sbLineLog := ' Linea ' || nuLinea || '. ' ||
                         'valor del numero de medidor es nulo y el flag de predio de Independizacion esta en Y' ||
                         chr(13);
            pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
            GOTO nextLine;
        END IF;

        if sbPredioIndependi = 'N' and sbNumeroMedidor is NOT null THEN
          sbLineLog := ' Linea ' || nuLinea || '. ' ||
                         'valor del numero de medidor debe ser nulo, porque el flag de predio de Independizacion esta en N' ||
                         chr(13);
            pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
            GOTO nextLine;
        END IF;


      end if;

      --FIN CA 200-2437

      ------------------------------------------------------

      Generateventfor(onupackg, nuErrorCode, sbErrorMessage);

      if nuErrorCode != 0 then
        rollback;
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Error ' ||
                     nuErrorCode || ' ' || sbErrorMessage || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
         /*Cambio 200-1283*/
         --- Se obtiene la siguiente secuencia de la tabla Ge_Error_Log
        sequence_id := pkgeneralservices.fnugetnextsequenceval('SEQ_GE_ERROR_LOG');
        --- Se Construye la linea que agregaremos al Log.
        sbLineLog_2 := ' Linea ' || nuLinea || '. ' || 'Error ' ||
                     nuErrorCode || ' ' ||' Error con info Xml --> ' || sequence_id || chr(13);
        --- Se ejecuta procedimiento para insertar registro en la tabla Ge_Error_Log
       RegErrXml(sequence_id, sbLineLog); -- Se envia la secuencia y la linea de error proveniente del API
       --- Insertamos en el LOG la linea con la descripcion del error.
       pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog_2);
       /*Fin Cambio 200-1283*/
      else
        commit;
        sbLineLog := ' Linea ' || nuLinea || '. ' || 'Solicitud creada N?:' ||
                     onupackg || chr(13);
        pkUtlFileMgr.Put_Line(sbFileManagementd, sbLineLog);
      end if;

      <<nextLine>>
      null;
    end loop;
    <<FinProceso>>
    pkUtlFileMgr.fClose(sbFileManagement);
    pkUtlFileMgr.fClose(sbFileManagementd);



  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      raise ex.CONTROLLED_ERROR;
    when others then
      rollback;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ReadTextFile;
/*Cambio 200-1283*/
/*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : RegErrXml
    Descripcion    : Se crea para registrar en la tabla ge_error_log informacion con xml en caso de error
    Fecha          : 13-07-2017 ERS 200-1283

    Historia de Modificaciones
    Fecha         Autor                   Modificacion
    =========     =========               ====================

    ******************************************************************/
  procedure RegErrXml(sequence  number,
                      sbline varchar2) is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    insert into ge_error_log
          (error_log_id,
           message_id,
           time_stamp,
           db_user,
           os_user,
           session_id,
           application,
           call_stack,
           machine,
           terminal,
           client_ip)
        values
          (sequence,
           999,
           SYSDATE,
           ut_session.getUSER,
           ut_session.getosuser,
           ut_session.getsessionid,
           'LDCVEFM',
           'Informacion de error -> ' || sbLine ||
           ' Xml'||chr(13)||ErrorXml,
           ut_session.Getmachine,
           ut_session.getTERMINAL,
           ut_session.Getip);
    commit;
  end RegErrXml;
  /*Fin Cambio 200-1283*/
END LDC_PKGENVENFORMASI;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGENVENFORMASI
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGENVENFORMASI', 'ADM_PERSON'); 
END;
/
