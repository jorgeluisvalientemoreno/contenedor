CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKFACTURACION AS

  /*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

   PROCEDIMIENTO : LDCI_PKFACTURACION
           AUTOR : OLSoftware / Carlos E. Virgen Londono
           FECHA : 11/04/2013
          RICEF : I032

   DESCRIPCION : Paquete de interfaz con SAP(PI), este paquete se encarga de
                 recibir informacion de centros de costos.

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
   Sandra Mu?oz 07-09-2015  ARA8613. Se modifica proconsultacontrato
   carlosvl     09-04-2013  Creacion del paquete
  */

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  -- procedimiento que notifica el registro de centro de costo
  PROCEDURE proChargetoBill(icXmlChargetoBillData IN CLOB,
                            onuErrorCode          OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                            osbErrorMessage       OUT GE_ERROR_LOG.DESCRIPTION%TYPE);

  -- retorna la informacion del suscriptor
  PROCEDURE proConsultaContrato(inuSERVCODI         IN NUMBER,
                                isbCateList         IN VARCHAR2,
                                isbSuCaList         IN VARCHAR2,
                                orfSubscriptionData OUT LDCI_PKREPODATATYPE.tyRefcursor,
                                onuErrorCode        OUT NUMBER,
                                osbErrorMessage     OUT VARCHAR2);

  -- retorna el periodo de facturacion
  PROCEDURE proConsPeriodoFact(inuCycle        IN CICLO.CICLCODI%TYPE,
                               onuYear         OUT NUMBER,
                               onuMonth        OUT NUMBER,
                               onuPeriod       OUT NUMBER,
                               onuErrorCode    OUT NUMBER,
                               osbErrorMessage OUT VARCHAR2);

  -- retorna la definicion de un ciclo
  PROCEDURE proConsultaCiclo(isbCycleList    IN VARCHAR2,
                             inuCICLDEPA     IN CICLO.CICLDEPA%TYPE,
                             inuCICLLOCA     IN CICLO.CICLLOCA%TYPE,
                             orfCycleData    OUT LDCI_PKREPODATATYPE.tyRefcursor,
                             onuErrorCode    OUT NUMBER,
                             osbErrorMessage OUT VARCHAR2);

  -- registra el consumo de un elemento de medicion
  PROCEDURE proRegConsElemMedi(isbMeasElemCode     IN VARCHAR2,
                               inuConsumptionType  IN NUMBER,
                               idtConsumptionDate  IN DATE,
                               inuConsumptionUnits IN NUMBER,
                               onuErrorCode        OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                               osbErrorMessage     OUT GE_ERROR_LOG.DESCRIPTION%TYPE);

  -- actualiza el consumo de un elemento de medicion
  PROCEDURE proUpdConsElemMedi(isbMeasElemCode     IN VARCHAR2,
                               inuConsumptionType  IN NUMBER,
                               idtConsumptionDate  IN DATE,
                               inuConsumptionUnits IN NUMBER,
                               onuErrorCode        OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                               osbErrorMessage     OUT GE_ERROR_LOG.DESCRIPTION%TYPE);

  -- registra las variables del factor de correcion
  PROCEDURE proRegVarFacCorr(inuRefType      IN NUMBER,
                             iclXMLReference IN CLOB,
                             iclXmlInfoVar   IN CLOB,
                             oclXmlOutput    OUT CLOB,
                             onuErrorCode    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                             osbErrorMessage OUT GE_ERROR_LOG.DESCRIPTION%TYPE);

  -- registra la provision de consumo
  PROCEDURE proRegiProvCons(iclXMLProvCons IN CLOB,
                            orfMensProc    OUT LDCI_PKREPODATATYPE.tyRefcursor);

  procedure proGetProvCons(iboExcepcion    in boolean,
                           inuPROCCODI     in LDCI_ESTAPROC.PROCCODI%type,
                           orfMensProc     out LDCI_PKMESAWS.tyRefcursor,
                           onuErrorCode    out NUMBER,
                           osbErrorMessage out VARCHAR2);

  -- funcion que busca un valor en una cadena
  FUNCTION fsbBuscaToken(sbValores   VARCHAR2, --Listado de valores
                         sbClave     VARCHAR2, --Palabra a buscar
                         sbSeparador VARCHAR2 --Caracter separador
                         ) RETURN VARCHAR2;

  -- retorna el promedio de consumo para un servicio suscrito
  FUNCTION fnuGetAverageCons(inuCOSSSESU CONSSESU.COSSSESU%TYPE,
                             inuROWNUM   NUMBER) RETURN NUMBER;

  -- genera el XML del consumos
  FUNCTION fclGetXMLAverage(inuCOSSSESU CONSSESU.COSSSESU%TYPE,
                            inuROWNUM   NUMBER) RETURN CLOB;

  -- genera el XML de lecturas
  FUNCTION fclGetXMLLecture(inuLEEMSESU LECTELME.LEEMSESU%TYPE,
                            inuROWNUM   NUMBER) RETURN CLOB;

END LDCI_PKFACTURACION;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKFACTURACION AS

  function fnuGetAverageCons(inuCOSSSESU CONSSESU.COSSSESU%type,
                             inuROWNUM   NUMBER) return NUMBER is
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.fnuGetAverageCons
     * Tiquete : I032
     * Autor   : OLSoftware / Carlos E. Virgen Londo??o
     * Fecha   : 09-04-2013
     * Descripcion : Retorna el promedio de consumo
     *
     * Historia de Modificaciones
     * Autor          Fecha  Descripcion
    **/
    -- Cursor del promedio de consumo
    cursor cuPromedioConsumo(inuCOSSSESU CONSSESU.COSSSESU%type,
                             inuROWNUM   NUMBER) is
      select 'AVERAGECONS' AVERAGECONS,
             REGISTROS,
             SUMA / REGISTROS PROMEDIO
        from (select sum(COSSCOCA) SUMA, count(*) REGISTROS
                from CONSSESU
               where COSSSESU = inuCOSSSESU
                 and ROWNUM <= inuROWNUM
               order by COSSFERE desc);
    rePromedioConsumo cuPromedioConsumo%rowtype;

  begin
    -- abre el cursor
    open cuPromedioConsumo(inuCOSSSESU, inuROWNUM);
    fetch cuPromedioConsumo
      into rePromedioConsumo;

    -- valida que encontro registos
    if (cuPromedioConsumo%NOTFOUND) then
      close cuPromedioConsumo;
      return - 1;
    else
      return rePromedioConsumo.PROMEDIO;
    end if;

  end fnuGetAverageCons;

  function fclGetXMLAverage(inuCOSSSESU CONSSESU.COSSSESU%type,
                            inuROWNUM   NUMBER) return CLOB is
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.fclGetXMLAverage
     * Tiquete : I032
     * Autor   : OLSoftware / Carlos E. Virgen Londo??o
     * Fecha   : 09-04-2013
     * Descripcion : Retorna el promedio de consumo
     *
     * Historia de Modificaciones
     * Autor          Fecha  Descripcion
    **/
    -- Cursor del promedio de consumo
    cursor cuConsumo(inuCOSSSESU CONSSESU.COSSSESU%type, inuROWNUM NUMBER) is
      select *
        from (select 'CONSUMPTION' || ROWNUM FILA,
                     COSSCOCA CONSUMO,
                     COSSCONS CONSECUTIVO
                from CONSSESU
               where COSSSESU = inuCOSSSESU
                 and ROWNUM <= inuROWNUM
               order by COSSFERE desc)
       order by FILA;

    oclXMLAverage CLOB;

  begin

    oclXMLAverage := null;
    for reConsumo in cuConsumo(inuCOSSSESU, inuROWNUM) loop
      oclXMLAverage := oclXMLAverage || '<' || reConsumo.FILA || '>' ||
                       reConsumo.CONSUMO || '</' || reConsumo.FILA || '>' ||
                       chr(13);
    end loop;

    return oclXMLAverage;
  end fclGetXMLAverage;

  function fclGetXMLLecture(inuLEEMSESU LECTELME.LEEMSESU%type,
                            inuROWNUM   NUMBER) return CLOB is
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.fclGetXMLAverage
     * Tiquete : I032
     * Autor   : OLSoftware / Carlos E. Virgen Londo??o
     * Fecha   : 09-04-2013
     * Descripcion : Retorna el promedio de consumo
     *
     * Historia de Modificaciones
     * Autor          Fecha  Descripcion
    **/
    -- Cursor del promedio de consumo
    cursor cuLecturas(inuLEEMSESU LECTELME.LEEMSESU%type, inuROWNUM NUMBER) is
      select *
        from (select 'LECTURE' || ROWNUM FILA, LEEMLETO LECTURA
                from LECTELME
               where LEEMSESU = inuLEEMSESU
                 and ROWNUM <= inuROWNUM
               order by LEEMFELE desc)
       order by FILA;

    oclXMLLecture CLOB;

  begin
    oclXMLLecture := null;
    for reLecturas in cuLecturas(inuLEEMSESU, inuROWNUM) loop
      oclXMLLecture := oclXMLLecture || '<' || reLecturas.FILA || '>' ||
                       reLecturas.LECTURA || '</' || reLecturas.FILA || '>' ||
                       chr(13);
    end loop;

    return oclXMLLecture;
  end fclGetXMLLecture;

  function fsbBuscaToken(sbValores   VARCHAR2, --Listado de valores
                         sbClave     VARCHAR2, --Palabra a buscar
                         sbSeparador VARCHAR2 --Caracter separador
                         ) return VARCHAR2
  /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.fsbBuscaToken
     * Tiquete : I032
     * Autor   : OLSoftware / Carlos E. Virgen Londo??o
     * Fecha   : 09-04-2013
     * Descripcion : Busca una clave incluida dentro de una cadena separada por comas('12,33,233...').
     *               -Convierte la cadena a una arreglo
     *               -Busca la palabra clave dentro del arreglo
     *
     * Historia de Modificaciones
     * Autor          Fecha  Descripcion
    **/
   is

    sbEncuentra VARCHAR2(1) := 'N';
    sbListValor VARCHAR2(2000);
    nuLongitud  NUMBER;
    sbValor     VARCHAR2(2000);

  begin

    sbListValor := trim(sbValores);
    nuLongitud  := Length(sbListValor);

    if (nulongitud = length(REPLACE(sbListValor, sbSeparador))) then
      if (sbClave = sbListValor) then
        sbEncuentra := 'S';
      end if;
    else
      --Se obtienen los datos parametrizados
      for i in 1 .. length(sbListValor) + 1 loop

        if (trim(substr(sbListValor, i, 1)) <> trim(sbSeparador)) then
          sbValor := sbValor || substr(sbListValor, i, 1);
        else

          if (sbClave = sbValor) then
            sbEncuentra := 'S';

            exit;
          end if;
          sbValor := null;
        end if;
      end loop;
    end if;

    return sbEncuentra;
  end fsbBuscaToken;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del Paquete: sbAplicaEntrega
  Descripcion:        Indica si la entrega aplica para la gasera

  Autor : Sandra Mu?oz
  Fecha : 07-09-2015 Aranda 8657

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  07-09-2015    Sandra Mu?oz          Creacion
  ******************************************************************/
  FUNCTION fsbAplicaEntrega(isbEntrega VARCHAR2) RETURN CHAR IS
    blGDO      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDO(isbEntrega);
    blEFIGAS   BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaEfigas(isbEntrega);
    blSURTIGAS BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaSurtigas(isbEntrega);
    blGDC      BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDC(isbEntrega);
  BEGIN
    -- Valida si la entrega aplica para la gasera
    IF blGDO = TRUE OR blEFIGAS = TRUE OR blSURTIGAS = TRUE OR blGDC = TRUE THEN
      RETURN 'S';
    ELSE
      RETURN 'N';
    END IF;
  END;

  PROCEDURE proConsultaContrato(inuSERVCODI         IN NUMBER,
                                isbCateList         IN VARCHAR2,
                                isbSuCaList         IN VARCHAR2,
                                orfSubscriptionData OUT LDCI_PKREPODATATYPE.tyRefcursor,
                                onuErrorCode        OUT NUMBER,
                                osbErrorMessage     OUT VARCHAR2) AS
    /*
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
         PAQUETE       : LDCI_PKFACTURACION.proConsultaContrato
         AUTOR         : OLSoftware / Carlos E. Virgen
         FECHA         : 19/03/2013
         RICEF : I032
         DESCRIPCION: Metodo que retorna un listado de suscriptores dependiendo de un listado de categorias

        Historia de Modificaciones
        Autor                                        Fecha      Descripcion
        Sandra Mu?oz                                 07-09-2015 ARA8613. Solo se obtiene la informacion
                                                                del elemento de medicion activo de cada
                                                                producto procesado
        carlos.virgen<casrlos.virgen@olsoftware.com> 21-02-2014 #VIN_CEV_2882_1 Se agrega "outer join"
    */

    sbSQL VARCHAR2(4000);

    -- variables
    nuSERVCODI SERVICIO.SERVCODI%TYPE;
    sbCateList VARCHAR2(1000);
    sbSuCaList VARCHAR2(1000);

    -- exceptciones
    EXCEP_SIN_PARAMETROS_ENTRADA EXCEPTION;

  BEGIN
    -- valida los parametros de entrada
    nuSERVCODI := nvl(inuSERVCODI, 7014);

    -- valida que se haya ingresado los parametros de busqueda
    IF ((isbCateList IS NULL OR isbCateList = '') OR
       (isbSuCaList IS NULL OR isbSuCaList = '')) THEN
      RAISE EXCEP_SIN_PARAMETROS_ENTRADA;
    END IF; --if (isbCateList is null or isbCateList = '') Then

    sbCateList := REPLACE(isbCateList, ';', ',');
    sbSuCaList := REPLACE(isbSuCaList, ';', ',');

    -- genera sentencia SQL
    sbSQL := 'select
                    Cont.SUSCCODI CONTRATO,
                    SeSu.SESUNUSE NRO_SERVICIO,
                    Cont.SUSCCLIE CODIGO_CLIENTE,
                    Clie.SUBSCRIBER_NAME || chr(32) || Clie.SUBS_LAST_NAME CLIENTE,
                    Clie.IDENTIFICATION IDENTIFICACION,
                    LocPred.GEO_LOCA_FATHER_ID CODIGO_DEPTO,
                    LocPred.GEOGRAP_LOCATION_ID CODIGO_LOCALIDAD,
                    Cont.SUSCCICL CICLO_FACTURACION,
                    SeSu.SESUCATE CODIGO_CATEGORIA,
                    SeSu.SESUSUCA CODIGO_SUBCATEGORIA,
                    ElemMedi.EMSSELME ELEMENTO_MEDICION,
                    ElemMedi.EMSSCOEM CODIGO_ELEMENTO
             from   SUSCRIPC Cont,
                    SERVSUSC SeSu,
                    GE_SUBSCRIBER Clie,
                    AB_ADDRESS Pred,
                    GE_GEOGRA_LOCATION LocPred,
                    ELMESESU ElemMedi
            where   SeSu.SESUSUSC = Cont.SUSCCODI
            and     SeSu.SESUSERV = ' || to_char(nuSERVCODI) || '
            and     SeSu.SESUCATE in ' || '(' || sbCateList || ') ' || '
            and     SeSu.SESUSUCA in ' || '(' || sbSuCaList || ') ' || '
            and     Cont.SUSCCLIE = Clie.SUBSCRIBER_ID
            and     Cont.SUSCCODI = SeSu.SESUSUSC
            and     Pred.ADDRESS_ID = Cont.SUSCIDDI
            and     Pred.GEOGRAP_LOCATION_ID = LocPred.GEOGRAP_LOCATION_ID
            and     SeSu.SESUNUSE = ElemMedi.EMSSSESU(+)
            and     SeSu.SESUSERV = ElemMedi.EMSSSERV(+)'; --#VIN_CEV_2882_1: carlos.virgen: 21-02-2014: Se agrega "outer join"

    /* #VIN_CEV_2882_1: carlos.virgen: 21-02-2014: Se comenta la version anterior
    and ElemMedi.EMSSSESU = SeSu.SESUNUSE
    and ElemMedi.EMSSSERV = SeSu.SESUSERV';*/

    -- carga el cusor referenciado

    -- ARA8613. Solo se obtiene la informacion del elemento de medicion
    -- activo de cada producto procesado

    IF fsbAplicaEntrega('BSS_SMS_ARA_8613') = 'S' THEN
      sbSQL := sbSQL || ' and elemmedi.emssfere(+) >= sysdate';
    END IF;

    OPEN orfSubscriptionData FOR sbSQL;

    onuErrorCode := 0;

  EXCEPTION
    WHEN EXCEP_SIN_PARAMETROS_ENTRADA THEN
      ROLLBACK;
      OPEN orfSubscriptionData FOR
        SELECT * FROM DUAL WHERE 1 = 2;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKFACTURACION.proConsultaContrato.EXCEP_SIN_PARAMETROS_ENTRADA]: ' ||
                         chr(13) ||
                         'No ingreso par?!metros de b??squeda (Listado de Categor?-as separadas por a??;a?? [111;222;22;22;]).';
      Errors.seterror(onuErrorCode, osbErrorMessage);

    WHEN OTHERS THEN
      ROLLBACK;
      OPEN orfSubscriptionData FOR
        SELECT * FROM DUAL WHERE 1 = 2;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);

  END proConsultaContrato;

  PROCEDURE proConsPeriodoFact(inuCycle        in CICLO.CICLCODI%type,
                               onuYear         out NUMBER,
                               onuMonth        out NUMBER,
                               onuPeriod       out NUMBER,
                               onuErrorCode    out NUMBER,
                               osbErrorMessage out VARCHAR2) AS
    /*
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
         PAQUETE       : LDCI_PKFACTURACION.proConsPeriodoFact
         AUTOR         : OLSoftware / Carlos E. Virgen
         FECHA         : 19/03/2013
         RICEF : I032
         DESCRIPCION: Retorna el periodo de facturacion segun un ciclo de facturacion ingresado

        Historia de Modificaciones
        Autor   Fecha      Descripcion

    */
    -- definicion de variables
    -- cursor que determina el periodo de consumo
    cursor cuPERICOSE(inuPECSCICO PERICOSE.PECSCICO%type,
                      inuPEFACODI PERIFACT.PEFACODI%type) is
      select /*+ first_rows(1) index_desc(pericose ix_pericose02)*/
       PECSCONS
        from PERICOSE
       where PERICOSE.PECSCICO = inuPECSCICO -- ciclo de consumo
         and PECSFECF <
             (select PEFAFFMO from PERIFACT where PEFACODI = inuPEFACODI) -- per?-odo de facturaci??n actual
         and rownum = 1;

    -- exceptciones
    EXCEP_SIN_PARAMETROS_ENTRADA exception;
    EXCEP_CURRENTPERIOD          exception;

  BEGIN

    onuErrorCode := 0;

    if (inuCycle is null or inuCycle = 0) then
      raise EXCEP_SIN_PARAMETROS_ENTRADA;
    end if; --if (inuCycle is null or inuCycle = 0) then

    -- ejecuta el API para determinar el periodo de facturacion
    PKBILLINGPERIOD.ACCCURRENTPERIOD(INUCYCLE        => inuCycle,
                                     ONUYEAR         => onuYear,
                                     ONUMONTH        => onuMonth,
                                     ONUPERIOD       => onuPeriod,
                                     ONUERRORCODE    => onuErrorCode,
                                     OSBERRORMESSAGE => osbErrorMessage);

    -- valida la ejecuci??n del API que retorna el periodo
    if (onuErrorCode <> 0) then
      raise EXCEP_CURRENTPERIOD;
    end if;

  EXCEPTION
    WHEN EXCEP_CURRENTPERIOD THEN
      rollback;
      onuYear   := -1;
      onuMonth  := -1;
      onuPeriod := -1;

    WHEN EXCEP_SIN_PARAMETROS_ENTRADA THEN
      rollback;
      onuYear         := -1;
      onuMonth        := -1;
      onuPeriod       := -1;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKFACTURACION.proConsPeriodoFact.EXCEP_SIN_PARAMETROS_ENTRADA]: ' ||
                         chr(13) ||
                         'No ingreso par?!metros de b??squeda. Debe Ingresar el c??digo del ciclo del suscriptor.';
    WHEN OTHERS THEN
      rollback;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKFACTURACION.proConsPeriodoFact.OTHERS]: ' ||
                         chr(13) || SQLERRM;
  END proConsPeriodoFact;

  PROCEDURE proConsultaCiclo(isbCycleList    in VARCHAR2,
                             inuCICLDEPA     in CICLO.CICLDEPA%type,
                             inuCICLLOCA     in CICLO.CICLLOCA%type,
                             orfCycleData    out LDCI_PKREPODATATYPE.tyRefcursor,
                             onuErrorCode    out NUMBER,
                             osbErrorMessage out VARCHAR2) AS
    /*
         PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
         PAQUETE       : LDCI_PKFACTURACION.proConsultaCiclo
         AUTOR         : OLSoftware / Carlos E. Virgen
         FECHA         : 19/03/2013
         RICEF : I032
         DESCRIPCION: Metodo que retorna un listado de suscriptores dependiendo de un listado de categorias

        Historia de Modificaciones
        Autor   Fecha      Descripcion

    */
    -- variables
    nuCICLDEPA CICLO.CICLDEPA%type;
    nuCICLLOCA CICLO.CICLLOCA%type;

  BEGIN
    nuCICLDEPA := nvl(inuCICLDEPA, -1);
    nuCICLLOCA := nvl(inuCICLLOCA, -1);

    if (isbCycleList is not null) then
      -- abre el cursor del ciclo
      open orfCycleData for
        select CICLCODI CODIGO_CICLO,
               CICLDEPA DEPARTAMENTO,
               CICLLOCA LOCALIDAD,
               CICLDESC CICLO_DESC,
               CICLSIST EMPRESA,
               CICLCICO CICLO_DE_CONSUMO
          from CICLO
         where trim(LDCI_PKFACTURACION.fsbBuscaToken(isbCycleList,
                                                     trim(to_char(CICLCODI)),
                                                     ';')) = 'S'
           and CICLDEPA = decode(nuCICLDEPA, -1, CICLDEPA, nuCICLDEPA)
           and CICLLOCA = decode(nuCICLLOCA, -1, CICLLOCA, nuCICLLOCA);
    else
      -- abre el cursor del ciclo
      open orfCycleData for
        select CICLCODI CODIGO_CICLO,
               CICLDEPA DEPARTAMENTO,
               CICLLOCA LOCALIDAD,
               CICLDESC CICLO_DESC,
               CICLSIST EMPRESA,
               CICLCICO CICLO_DE_CONSUMO
          from CICLO
         where CICLDEPA = decode(nuCICLDEPA, -1, CICLDEPA, nuCICLDEPA)
           and CICLLOCA = decode(nuCICLLOCA, -1, CICLLOCA, nuCICLLOCA);

    end if;

    onuErrorCode := 0;
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      OPEN orfCycleData FOR
        SELECT * FROM DUAL WHERE 1 = 2;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);

  END proConsultaCiclo;

  PROCEDURE proChargetoBill(icXmlChargetoBillData in clob,
                            onuErrorCode          out GE_ERROR_LOG.ERROR_LOG_ID%type,
                            osbErrorMessage       out GE_ERROR_LOG.DESCRIPTION%type) AS

    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.proChargetoBill
     * Tiquete : I046
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 09/04/2013
     * Descripcion : Procesa los cargos a facturar de un suscriptor
     *
     * Parametros:
     * icXmlChargetoBillData: Xml con la informaci??n de los cargos a facturar
                                                                                                                <?xml version="1.0" encoding="UTF-8"?>
                                                                                                            <CHARGETOBILLDATA>
                                                                                                                    <INUSUBSCRIBERSERVICE>111</INUSUBSCRIBERSERVICE>
                                                                                                                    <INPERIOD>1312312</INPERIOD>
                                                                                                                    <CHARGES>
                                                                                                                            <CHARGE>
                                                                                                                                    <INUCONCEPT>2</INUCONCEPT>
                                                                                                                                    <INUUNITS>1</INUUNITS>
                                                                                                                                    <INUCHARGECAUSE>17</INUCHARGECAUSE>
                                                                                                                                    <INUVALUE>200000</INUVALUE>
                                                                                                                                    <ISBSUPPORTDOCUMENT>CO-YYYYMM-TC-1 </ISBSUPPORTDOCUMENT>
                                                                                                                                </CHARGE>
                                                                                                                            <CHARGE>
                                                                                                                                    <INUCONCEPT>20</INUCONCEPT>
                                                                                                                                    <INUUNITS>2</INUUNITS>
                                                                                                                                    <INUCHARGECAUSE>28</INUCHARGECAUSE>
                                                                                                                                    <INUVALUE>300000</INUVALUE>
                                                                                                                                    <ISBSUPPORTDOCUMENT>CN-YYYYMM</ISBSUPPORTDOCUMENT>
                                                                                                                            </CHARGE>
                                                                                                                    </CHARGES>
                                                                                                            </CHARGETOBILLDATA>
     * onuErrorCode: Codigo de la excepcion
     * osbErrorMessage: Descripcion de la excepcion

     * Autor              Fecha         Descripcion
     * carlosvl           09-04-2013    Creacion del procedimiento
    **/
    -- definicion de cursores
    -- cursor de los cargos
    cursor cuChargetoBillData(clXML in CLOB) is
      SELECT PRODUCT.*, CHARGES.*
        FROM XMLTable('CHARGETOBILLDATA/CHARGES/CHARGE' PASSING
                      XMLType(clXML) COLUMNS "INUCONCEPT" NUMBER PATH
                      'INUCONCEPT',
                      "INUUNITS" NUMBER PATH 'INUUNITS',
                      "INUCHARGECAUSE" NUMBER PATH 'INUCHARGECAUSE',
                      "INUVALUE" NUMBER PATH 'INUVALUE',
                      "ISBSUPPORTDOCUMENT" VARCHAR2(30) PATH
                      'ISBSUPPORTDOCUMENT') AS CHARGES,
             XMLTable('CHARGETOBILLDATA' PASSING XMLType(clXML) COLUMNS
                      "INUSUBSCRIBERSERVICE" NUMBER PATH
                      'INUSUBSCRIBERSERVICE',
                      "INPERIOD" NUMBER PATH 'INPERIOD') AS PRODUCT;
    -- excepciones
    EXCEP_OS_CHARGETOBILL exception;
  BEGIN
    onuErrorCode := 0;
    --SetSystemEnviroment;
    -- recorre los cargos del suscriptor
    for reChargetoBillData in cuChargetoBillData(icXmlChargetoBillData) loop
      -- ejecuta el API para procesar los cargos por suscriptor

      OS_CHARGETOBILL(INUSUBSCRIBERSERVICE => reChargetoBillData.INUSUBSCRIBERSERVICE,
                      INUCONCEPT           => reChargetoBillData.INUCONCEPT,
                      INUUNITS             => reChargetoBillData.INUUNITS,
                      INUCHARGECAUSE       => reChargetoBillData.INUCHARGECAUSE,
                      INUVALUE             => reChargetoBillData.INUVALUE,
                      ISBSUPPORTDOCUMENT   => reChargetoBillData.ISBSUPPORTDOCUMENT,
                      INUCONSPERIOD        => reChargetoBillData.INPERIOD,
                      ONUERRORCODE         => onuErrorCode,
                      OSBERRORMSG          => osbErrorMessage);

      -- valida la ejecucion del API     OS_CHARGETOBILL
      if (onuErrorCode <> 0) then
        raise EXCEP_OS_CHARGETOBILL;
      end if;
    end loop;

    -- confirma los datos
    commit;
  EXCEPTION
    WHEN EXCEP_OS_CHARGETOBILL THEN
      rollback;
      --Errors.setError(onuErrorCode, osbErrorMessage);

    WHEN OTHERS THEN
      rollback;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);
  END proChargetoBill;

  PROCEDURE proRegConsElemMedi(isbMeasElemCode     in VARCHAR2,
                               inuConsumptionType  in NUMBER,
                               idtConsumptionDate  in DATE,
                               inuConsumptionUnits in NUMBER,
                               onuErrorCode        out GE_ERROR_LOG.ERROR_LOG_ID%type,
                               osbErrorMessage     out GE_ERROR_LOG.DESCRIPTION%type) AS

    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.proRegConsElemMedi
     * Tiquete : I049
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 09/04/2013
     * Descripcion : Registra la informacion del consumo del elemento de medicion
     *
     * Parametros:
        * IN: isbMeasElemCode: Codigo del elemento de medicion
        * IN: inuConsumptionType: Tipo de consumo ver definici??n tabla TIPOCONS
        * IN: idtConsumptionDate: Fecha del consumo
        * IN: inuConsumptionUnits: Unidades
     * OUT: onuErrorCode: Codigo de la excepcion
     * OUT: osbErrorMessage: Descripcion de la excepcion
     * PAMECODI in ('BIL_TIPO_CONS_SIC', 'BIL_MECC_SIC')
     * Autor              Fecha         Descripcion
     * carlosvl           09-04-2013    Creacion del procedimiento
    **/
    -- definicion de cursores
    -- cursor de los cargos
    -- excepciones
    EXCEP_REGCONSELEMMEDI exception;
  BEGIN
    onuErrorCode := 0;
    OS_REGTELEMEASCONSUMPTION(ISBMEASELEMCODE     => isbMeasElemCode,
                              INUCONSUMPTIONTYPE  => inuConsumptionType,
                              IDTCONSUMPTIONDATE  => idtConsumptionDate,
                              INUCONSUMPTIONUNITS => inuConsumptionUnits,
                              ONUERRORCODE        => onuErrorCode,
                              OSBERRORMESSAGE     => osbErrorMessage);

    -- valida la ejecucion del API     OS_REGTELEMEASCONSUMPTION
    if (onuErrorCode <> 0) then
      raise EXCEP_REGCONSELEMMEDI;
    end if;
    -- confirma los datos
    commit;
  EXCEPTION
    WHEN EXCEP_REGCONSELEMMEDI THEN
      rollback;
      --Errors.setError(onuErrorCode, osbErrorMessage);

    WHEN OTHERS THEN
      rollback;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);
  END proRegConsElemMedi;

  PROCEDURE proUpdConsElemMedi(isbMeasElemCode     in VARCHAR2,
                               inuConsumptionType  in NUMBER,
                               idtConsumptionDate  in DATE,
                               inuConsumptionUnits in NUMBER,
                               onuErrorCode        out GE_ERROR_LOG.ERROR_LOG_ID%type,
                               osbErrorMessage     out GE_ERROR_LOG.DESCRIPTION%type) AS

    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.proUpdConsElemMedi
     * Tiquete : I049
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 09/04/2013
     * Descripcion : Actualiza la informacion del consumo del elemento de medicion
     *
     * Parametros:
        * IN: isbMeasElemCode: Codigo del elemento de medicion
        * IN: inuConsumptionType: Tipo de consumo ver definici??n tabla TIPOCONS
        * IN: idtConsumptionDate: Fecha del consumo
        * IN: inuConsumptionUnits: Unidades
     * OUT: onuErrorCode: Codigo de la excepcion
     * OUT: osbErrorMessage: Descripcion de la excepcion

     * Autor              Fecha         Descripcion
     * carlosvl           09-04-2013    Creacion del procedimiento
    **/
    -- definicion de cursores
    -- cursor de los cargos
    -- excepciones
    EXCEP_UPDCONSELEMMEDI exception;
  BEGIN
    onuErrorCode := 0;
    OS_UPDTELEMEASCONSUMPTION(ISBMEASELEMCODE     => isbMeasElemCode,
                              INUCONSUMPTIONTYPE  => inuConsumptionType,
                              IDTCONSUMPTIONDATE  => idtConsumptionDate,
                              INUCONSUMPTIONUNITS => inuConsumptionUnits,
                              ONUERRORCODE        => onuErrorCode,
                              OSBERRORMESSAGE     => osbErrorMessage);

    -- valida la ejecucion del API     OS_REGTELEMEASCONSUMPTION
    if (onuErrorCode <> 0) then
      raise EXCEP_UPDCONSELEMMEDI;
    end if; --if (onuErrorCode <> 0)     then
    -- confirma los datos
    commit;
  EXCEPTION
    WHEN EXCEP_UPDCONSELEMMEDI THEN
      rollback;
      --Errors.setError(onuErrorCode, osbErrorMessage);

    WHEN OTHERS THEN
      rollback;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);
  END proUpdConsElemMedi;

  PROCEDURE proRegVarFacCorr(inuRefType      in NUMBER,
                             iclXMLReference in CLOB,
                             iclXmlInfoVar   in CLOB,
                             oclXmlOutput    out CLOB,
                             onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%type,
                             osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%type) AS

    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.proRegVarFacCorr
     * Tiquete : I050
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 09/04/2013
     * Descripcion : Registra la informacion del consumo del elemento de medicion
     *
     * Parametros:
        * IN: inuRefType: Tipo de referencia: 1 Localidad, 2 Elemento de medici??n, 3 Producto
        * IN: iclXMLReference: Referencia de variable:
                                                                                    Cuando inuReferenceType es 1:
                                                                                                    <RegVarsFactCorrecc_Ref>
                                                                                                        <Localidad></Localidad>
                                                                                                    </RegVarsFactCorrecc_Ref>

                                                                                    Cuando inuReferenceType es 2:
                                                                                                    <RegVarsFactCorrecc_Ref>
                                                                                                        <CodigoMedidor></CodigoMedidor>
                                                                                                    </RegVarsFactCorrecc_Ref>

                                                                                    Cuando inuReferenceType es 3:
                                                                                                    <RegVarsFactCorrecc_Ref>
                                                                                                        <Producto></Producto>
                                                                                                    </RegVarsFactCorrecc_Ref>

        * IN: iclXmlInfoVar: Informacion de variable
                                                                                    <RegVarsFactCorrecc_InfoVar>
                                                                                            <Fecha></Fecha>
                                                                                            <NombreVariable></NombreVariable>
                                                                                            <ValorVariable></ValorVariable>
                                                                                    </RegVarsFactCorrecc_InfoVar>

        * OUT: oclXmlOutput: XML de salida
     * OUT: onuErrorCode: Codigo de la excepcion
     * OUT: osbErrorMessage: Descripcion de la excepcion

     * Autor              Fecha         Descripcion
     * carlosvl           09-04-2013    Creacion del procedimiento
    **/
    -- definicion de cursores
    -- cursor de los cargos
    -- excepciones
    EXCEP_REGVARFACCORR exception;
  BEGIN
    onuErrorCode := 0;

    -- ejecucion del api de factor de correcion
    OS_REGVARSFACTCORRECC(INUREFTYPE      => inuRefType,
                          ICLXMLREFERENCE => iclXMLReference,
                          ICLXMLINFOVAR   => iclXmlInfoVar,
                          OCLXMLOUTPUT    => oclXmlOutput,
                          ONUERRORCODE    => onuErrorCode,
                          OSBERRORMESSAGE => osbErrorMessage);

    -- valida la ejecucion del API     OS_REGVARSFACTCORRECC
    if (onuErrorCode <> 0) then
      raise EXCEP_REGVARFACCORR;
    end if; --if (onuErrorCode <> 0)     then

    -- confirma los datos
    commit;
  EXCEPTION
    WHEN EXCEP_REGVARFACCORR THEN
      rollback;
      --Errors.setError(onuErrorCode, osbErrorMessage);

    WHEN OTHERS THEN
      rollback;
      --pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
    --Errors.seterror;
    --Errors.geterror (onuErrorCode, osbErrorMessage);
  END proRegVarFacCorr;

  procedure proRegiProvCons(iclXMLProvCons in CLOB,
                            orfMensProc    out LDCI_PKREPODATATYPE.tyRefcursor) as
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKFACTURACION.proRegiProvCons
     * Tiquete : I058 Provisi??n de consumo
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 24/06/2013
     * Descripcion : Registra la informacion de la provisi??n de consumo en la tabla IC_MOVIMIEN
     *
     * Parametros:
        * IN: iclXMLProvCons: Codigo del elemento de medicion
                                    <!-- mensaje para el paquete de integracion -->
                                    <!-- nuevo dise??o -->
                                    <?xml version="1.0" encoding="UTF-8" ?>
                                    <LISTA_PRVSNS>
                                        <PROVISIONCONSUMO>
                                                    <!-- No enviado -->
                                                    <CODIGO_DOCUMENTO>NUMBER(4,0)</CODIGO_DOCUMENTO>
                                                    <!-- No enviado -->
                                                    <NUMERO_DOCUMENTO>NUMBER(9,0)</NUMERO_DOCUMENTO>
                                                    <!-- No enviado -->
                                                    <TIPO_MOVIMIENTO>NUMBER(4,0)</TIPO_MOVIMIENTO>
                                                    <!-- No enviado -->
                                                    <FECHA_CONTABILIZACION>DATE</FECHA_CONTABILIZACION>
                                                    <!-- No enviado -->
                                                    <SIGNO_MOVIMIENTO>VARCHAR2(2 BYTE)</SIGNO_MOVIMIENTO>
                                                    <CICLO>NUMBER(4,0)</CICLO>
                                                    <DEPARTAMENTO>NUMBER(4,0)</DEPARTAMENTO>
                                                    <LOCALIDAD>NUMBER(6,0)</LOCALIDAD>
                                                    <CATEGORIA>NUMBER(2,0)</CATEGORIA>
                                                    <SUBCATEGORIA>NUMBER(2,0)</SUBCATEGORIA>
                                                    <FECHA_TRANSACCION>DATE</FECHA_TRANSACCION>
                                                    <CONTRATO>NUMBER(9,0)</CONTRATO>
                                                    <ANO>NUMBER(4,0)</ANO>
                                                    <MES>NUMBER(2,0)</MES>
                                                    <PERIODO_CONSUMO>NUMBER(15,0)</PERIODO_CONSUMO>
                                                    <!-- No enviado -->
                                                    <CONSECUTIVO>NUMBER(15,0)</CONSECUTIVO>
                                                    <!-- informaci??n de los conceptos  -->
                                                    <CONCEPTOS>
                                                            <CONCEPTO>
                                                                            <SERVICIO>NUMBER(4,0)</SERVICIO>
                                                                            <ID_CONCEPTO>NUMBER(4,0)</ID_CONCEPTO>
                                                                            <CAUSA_CARGO>NUMBER(2,0)</CAUSA_CARGO>
                                                                            <PERIODO_CONSUMO>NUMBER(15,0)</PERIODO_CONSUMO>
                                                                            <UNIDADES>NUMBER(14,4)</UNIDADES>
                                                                            <VALOR>NUMBER(13,2)</VALOR>
                                                            </CONCEPTO>
                                                    </CONCEPTOS>
                                        </PROVISIONCONSUMO>
                                    </LISTA_PRVSNS>
     * OUT: onuMessageCode: C??digo del mensaje de respuesta
     * OUT: osbMessageText: Texto del mensaje de respuesta
     * Autor              Fecha         Descripcion
     * carlosvl           09-04-2013    Creacion del procedimiento
        * carlosvl           11-09-2013    Se implementa la nueva definicion del XML que llega en la variable iclXMLProvCons
        * carlosvl           22-01-2014    #NC-INTERNA: Se ajusta la captura del sysdate con trunc(sysdate) para la creacion del documento y de los movimientos
    **/
    -- definicion de variables
    sbTIPO_DOCUMENTO       LDCI_CARASEWE.CASEVALO%type;
    sbTIPO_HECHO_ECONOMICO LDCI_CARASEWE.CASEVALO%type;
    sbOBSERV_DOCUMENTO     LDCI_CARASEWE.CASEVALO%type;
    sbTIPO_MOVIMIENTO      LDCI_CARASEWE.CASEVALO%type;
    sbSIGN_MOVIMIENTO      LDCI_CARASEWE.CASEVALO%type;
    sbCASECODI             LDCI_CARASEWE.CASEDESE%type := 'WS_PROVISION_CONSUMO';
    nuMOVICONS             IC_MOVIMIEN.MOVICONS%type := 0;
    onuMessageCode         GE_ERROR_LOG.ERROR_LOG_ID%type;
    osbMessageText         GE_ERROR_LOG.DESCRIPTION%type;
    boExcepcion            boolean;

    -- variables para el manejo del proceso LDCI_ESTAPROC
    sbPROCDEFI LDCI_ESTAPROC.PROCDEFI%type;
    cbPROCPARA LDCI_ESTAPROC.PROCPARA%type;
    dtPROCFEIN LDCI_ESTAPROC.PROCFEIN%type;
    sbPROCESTA LDCI_ESTAPROC.PROCESTA%type;
    nuPROCCODI LDCI_ESTAPROC.PROCCODI%type;

    -- variables para la creacion de los mensajes LDCI_MESAENVWS
    nuMESACODI LDCI_MESAENVWS.MESACODI%type;
    -- definicion de cursores
    --cursor que extrae la informacion del XML de entrada
    cursor cuLISTA_PRVSNS(clXML in CLOB) is
      SELECT LISTA_PRVSNS.*, DETALLE.*
        FROM XMLTable('LISTA_PRVSNS/PROVISIONCONSUMO' PASSING
                      XMLType(clXML) COLUMNS CICLO NUMBER PATH 'CICLO',
                      DEPARTAMENTO NUMBER PATH 'DEPARTAMENTO',
                      LOCALIDAD NUMBER PATH 'LOCALIDAD',
                      CATEGORIA NUMBER PATH 'CATEGORIA',
                      SUBCATEGORIA NUMBER PATH 'SUBCATEGORIA',
                      FECHA_TRANSACCION DATE PATH 'FECHA_TRANSACCION',
                      CONTRATO NUMBER PATH 'CONTRATO',
                      ANO NUMBER PATH 'ANO',
                      MES NUMBER PATH 'MES',
                      PERIODO_CONSUMO NUMBER PATH 'PERIODO_CONSUMO') AS LISTA_PRVSNS,
             XMLTable('LISTA_PRVSNS/PROVISIONCONSUMO/CONCEPTOS/CONCEPTO'
                      PASSING XMLType(clXML) COLUMNS SERVICIO NUMBER PATH
                      'SERVICIO',
                      ID_CONCEPTO NUMBER PATH 'ID_CONCEPTO',
                      CAUSA_CARGO NUMBER PATH 'CAUSA_CARGO',
                      UNIDADES NUMBER PATH 'UNIDADES',
                      VALOR NUMBER(13, 2) PATH 'VALOR') AS DETALLE;

    -- cursor que determina si ya se ha generado un documento para la fecha
    cursor cuIC_DOCUGENE(inuDOGETIDO IC_DOCUGENE.DOGENUDO%type) is
      select *
        from IC_DOCUGENE
       where DOGETIDO = inuDOGETIDO
         and trunc(DOGEFEGE) = trunc(sysdate);

    -- definicion de variables tipo registro
    reIC_DOCUGENE IC_DOCUGENE%rowtype;

    -- excepciones
    excep_PROCARASERVWEB exception;

  begin
    -- inicializa el mensaje de salida
    onuMessageCode := 0;
    osbMessageText := null;
    boExcepcion    := false;

    -- realiza la creacion del proceso
    cbPROCPARA := '    <PARAMETROS><PARAMETRO><NOMBRE>iclXMLProvCons</NOMBRE><VALOR>' ||
                  iclXMLProvCons || '</VALOR></PARAMETRO></PARAMETROS>';

    LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbCASECODI,
                                  ICBPROCPARA     => cbProcPara,
                                  IDTPROCFEIN     => SYSDATE,
                                  ISBPROCESTA     => 'P',
                                  ISBPROCUSUA     => null,
                                  ISBPROCTERM     => null,
                                  ISBPROCPROG     => null,
                                  ONUPROCCODI     => nuPROCCODI,
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);

    -- confirma encabezado de procesamiento

    -- carga los parametos de la interfaz
    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbCASECODI,
                                       'TIPO_DOCUMENTO',
                                       sbTIPO_DOCUMENTO,
                                       osbMessageText);
    if (osbMessageText != '0') then
      boExcepcion := true;
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => osbMessageText,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if; --if(osbMessageText != '0') then

    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbCASECODI,
                                       'OBSERV_DOCUMENTO',
                                       sbOBSERV_DOCUMENTO,
                                       osbMessageText);
    if (osbMessageText != '0') then
      boExcepcion := true;
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => osbMessageText,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbCASECODI,
                                       'TIPO_MOVIMIENTO',
                                       sbTIPO_MOVIMIENTO,
                                       osbMessageText);
    if (osbMessageText != '0') then
      boExcepcion := true;
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => osbMessageText,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbCASECODI,
                                       'SIGN_MOVIMIENTO',
                                       sbSIGN_MOVIMIENTO,
                                       osbMessageText);
    if (osbMessageText != '0') then
      boExcepcion := true;
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => osbMessageText,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if;

    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbCASECODI,
                                       'TIPO_HECHO_ECONOMICO',
                                       sbTIPO_HECHO_ECONOMICO,
                                       osbMessageText);
    if (osbMessageText != '0') then
      boExcepcion := true;
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => osbMessageText,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
    end if;

    -- determina si debe crear un nuevo documento
    open cuIC_DOCUGENE(to_number(sbTIPO_DOCUMENTO));
    fetch cuIC_DOCUGENE
      into reIC_DOCUGENE;
    if (cuIC_DOCUGENE%NOTFOUND) then

      -- genera el documento IC_DOCUGENE
      pkbcic_docugene.createdocument(to_number(sbTIPO_DOCUMENTO),
                                     trunc(sysdate), --#NC-INTERNA
                                     trunc(sysdate), --#NC-INTERNA
                                     sbOBSERV_DOCUMENTO);
      -- obtiene el registro de IC_DOCUGENE creado
      pkbcic_docugene.getdocument(reIC_DOCUGENE);
    end if; --if (cuIC_DOCUGENE%NOTFOUND) then
    close cuIC_DOCUGENE;

    -- recorres el listado de provisiones
    for reLISTA_PRVSNS in cuLISTA_PRVSNS(iclXMLProvCons) loop

      -- realiza la insercion de los registros de prodivision en la tabla IC_MOVIMIEN
      /*
      DBMS_OUTPUT.PUT_LINE('VALOR: ' || reLISTA_PRVSNS.VALOR);
      DBMS_OUTPUT.PUT_LINE('CICLO: ' || reLISTA_PRVSNS.CICLO);
      DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: ' || reLISTA_PRVSNS.DEPARTAMENTO);
      DBMS_OUTPUT.PUT_LINE('LOCALIDAD: ' || reLISTA_PRVSNS.LOCALIDAD);
      DBMS_OUTPUT.PUT_LINE('CATEGORIA: ' || reLISTA_PRVSNS.CATEGORIA);
      DBMS_OUTPUT.PUT_LINE('SUBCATEGORIA: ' || reLISTA_PRVSNS.SUBCATEGORIA);
      DBMS_OUTPUT.PUT_LINE('FECHA_TRANSACCION: ' || to_char(reLISTA_PRVSNS.FECHA_TRANSACCION,'dd/mm/yyyy'));
      DBMS_OUTPUT.PUT_LINE('CONTRATO: ' || reLISTA_PRVSNS.CONTRATO);
      DBMS_OUTPUT.PUT_LINE('ANO: ' || reLISTA_PRVSNS.ANO);
      DBMS_OUTPUT.PUT_LINE('MES: ' || reLISTA_PRVSNS.MES);
      DBMS_OUTPUT.PUT_LINE('UNIDADES: ' || reLISTA_PRVSNS.UNIDADES);
      DBMS_OUTPUT.PUT_LINE('SERVICIO: ' || reLISTA_PRVSNS.SERVICIO);
      DBMS_OUTPUT.PUT_LINE('ID_CONCEPTO: ' || reLISTA_PRVSNS.ID_CONCEPTO);
      DBMS_OUTPUT.PUT_LINE('CAUSA_CARGO: ' || reLISTA_PRVSNS.CAUSA_CARGO);
      DBMS_OUTPUT.PUT_LINE('PERIODO_CONSUMO: ' || reLISTA_PRVSNS.PERIODO_CONSUMO);*/

      if (reLISTA_PRVSNS.VALOR is null or reLISTA_PRVSNS.VALOR = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo VALOR no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.VALOR is null or reLISTA_PRVSNS.VALOR = 0) then

      if (reLISTA_PRVSNS.CICLO is null or reLISTA_PRVSNS.CICLO = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo CICLO no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.CICLO is null or reLISTA_PRVSNS.CICLO = 0) then

      if (reLISTA_PRVSNS.DEPARTAMENTO is null or
         reLISTA_PRVSNS.DEPARTAMENTO = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo DEPARTAMENTO no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.DEPARTAMENTO is null or reLISTA_PRVSNS.DEPARTAMENTO = 0) then

      if (reLISTA_PRVSNS.LOCALIDAD is null or reLISTA_PRVSNS.LOCALIDAD = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo LOCALIDAD no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.LOCALIDAD is null or reLISTA_PRVSNS.LOCALIDAD = 0) then

      if (reLISTA_PRVSNS.CATEGORIA is null or reLISTA_PRVSNS.CATEGORIA = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo CATEGORIA no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.CATEGORIA is null or reLISTA_PRVSNS.CATEGORIA = 0) then

      if (reLISTA_PRVSNS.SUBCATEGORIA is null or
         reLISTA_PRVSNS.SUBCATEGORIA = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo SUBCATEGORIA no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.SUBCATEGORIA is null or reLISTA_PRVSNS.SUBCATEGORIA = 0) then

      if (reLISTA_PRVSNS.FECHA_TRANSACCION is null) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo FECHA_TRANSACCION no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.FECHA_TRANSACCION is null) then

      if (reLISTA_PRVSNS.FECHA_TRANSACCION is null) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo FECHA_TRANSACCION no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.FECHA_TRANSACCION is null) then

      if (reLISTA_PRVSNS.CONTRATO is null or reLISTA_PRVSNS.CONTRATO = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo CONTRATO no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.CONTRATO is null or reLISTA_PRVSNS.CONTRATO = 0) then

      if (reLISTA_PRVSNS.ANO is null or reLISTA_PRVSNS.ANO = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo ANO no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.ANO is null or reLISTA_PRVSNS.ANO = 0) then

      if (reLISTA_PRVSNS.MES is null or reLISTA_PRVSNS.MES = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo MES no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.MES is null or reLISTA_PRVSNS.MES = 0) then

      /*if (reLISTA_PRVSNS.UNIDADES is null or reLISTA_PRVSNS.UNIDADES = 0) then
                      boExcepcion := true;
                      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC => nuPROCCODI,
                                                                                                                                              ISBMESADESC => 'Procesando contrato: ' || reLISTA_PRVSNS.CONTRATO || '> El campo UNIDADES no puede ser nulo',
                                                                                                                                              ISBMESATIPO => 'E',
                                                                                                                                              IDTMESAFECH => sysdate,
                                                                                                                                              ONUMESACODI => nuMESACODI,
                                                                                                                                              ONUERRORCODE => onuMessageCode,
                                                                                                                                              OSBERRORMESSAGE => osbMessageText);
      end if;*/ --if (reLISTA_PRVSNS.UNIDADES is null or reLISTA_PRVSNS.UNIDADES = 0) then

      if (reLISTA_PRVSNS.UNIDADES is null or
         reLISTA_PRVSNS.PERIODO_CONSUMO = 0) then
        boExcepcion := true;
        LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                      ISBMESADESC     => 'Procesando contrato: ' ||
                                                         reLISTA_PRVSNS.CONTRATO ||
                                                         '> El campo PERIODO_CONSUMO no puede ser nulo',
                                      ISBMESATIPO     => 'E',
                                      IDTMESAFECH     => sysdate,
                                      ONUMESACODI     => nuMESACODI,
                                      ONUERRORCODE    => onuMessageCode,
                                      OSBERRORMESSAGE => osbMessageText);
      end if; --if (reLISTA_PRVSNS.PERIODO_CONSUMO is null or reLISTA_PRVSNS.PERIODO_CONSUMO = 0) then

      if (boExcepcion = false) then

        --determina el consecutivo del movimiento
        select SQ_IC_MOVIMIEN_175553.NEXTVAL into nuMOVICONS from dual;

        -- realiza la insercion en la tabla  IC_MOVIMIEN
        insert into IC_MOVIMIEN
          (MOVITIDO,
           MOVINUDO,
           MOVITIMO,
           MOVIFECO,
           MOVISIGN,
           MOVIVALO,
           MOVICONS,
           MOVICICL,
           MOVIDEPA,
           MOVILOCA,
           MOVICATE,
           MOVISUCA,
           MOVIFETR,
           MOVISUSC,
           MOVIANCB,
           MOVIMECB,
           MOVIUNID,
           MOVIPECO,
           MOVITIHE,
           MOVISERV,
           MOVICONC,
           MOVICACA,
           MOVIUBG3) --#NC-INTERNA: Se agrega columna para ingresar la localidad
        values
          (reIC_DOCUGENE.DOGETIDO,
           reIC_DOCUGENE.DOGENUDO,
           to_number(sbTIPO_MOVIMIENTO),
           trunc(sysdate), --#NC-INTERNA
           sbSIGN_MOVIMIENTO,
           reLISTA_PRVSNS.VALOR,
           nuMOVICONS,
           reLISTA_PRVSNS.CICLO,
           reLISTA_PRVSNS.DEPARTAMENTO,
           reLISTA_PRVSNS.LOCALIDAD,
           reLISTA_PRVSNS.CATEGORIA,
           reLISTA_PRVSNS.SUBCATEGORIA,
           reLISTA_PRVSNS.FECHA_TRANSACCION,
           reLISTA_PRVSNS.CONTRATO,
           reLISTA_PRVSNS.ANO,
           reLISTA_PRVSNS.MES,
           reLISTA_PRVSNS.UNIDADES,
           reLISTA_PRVSNS.PERIODO_CONSUMO,
           sbTIPO_HECHO_ECONOMICO,
           reLISTA_PRVSNS.SERVICIO,
           reLISTA_PRVSNS.ID_CONCEPTO,
           reLISTA_PRVSNS.CAUSA_CARGO,
           reLISTA_PRVSNS.LOCALIDAD); --#NC-INTERNA: Se agrega columna para ingresar la localidad

      end if; --if(boExcepcion = false) then

    end loop; --for cuLISTA_PRVSNS in cuLISTA_PRVSNS() loop

    -- finaliza el procesamiento
    LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => nuPROCCODI,
                                  IDTPROCFEFI     => sysdate,
                                  ISBPROCESTA     => 'F',
                                  ONUERRORCODE    => onuMessageCode,
                                  OSBERRORMESSAGE => osbMessageText);
    if (boExcepcion = false) then
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'Proceso ha terminado satisfactoriamente.',
                                    ISBMESATIPO     => 'S',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
      -- confirma los datos procesados
      commit;
    else
      rollback;
    end if;

    -- retorna la pila de mensajes
    LDCI_PKMESAWS.PROGETMENSPROC(INUPROCCODI     => nuPROCCODI,
                                 ORFMENSPROC     => orfMensProc,
                                 ONUERRORCODE    => onuMessageCode,
                                 OSBERRORMESSAGE => osbMessageText);

    proGetProvCons(iboExcepcion    => boExcepcion,
                   inuPROCCODI     => nuPROCCODI,
                   orfMensProc     => orfMensProc,
                   onuErrorCode    => onuMessageCode,
                   osbErrorMessage => osbMessageText);

  exception
    when others then
      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'SQLCODE: ' ||
                                                       SQLCODE || ' : ' ||
                                                       SQLERRM,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);

      --registra los mensajes de error
      LDCI_PKMESAWS.PROCREAMENSPROC(INUMESAPROC     => nuPROCCODI,
                                    ISBMESADESC     => 'TRACE: ' ||
                                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
                                    ISBMESATIPO     => 'E',
                                    IDTMESAFECH     => sysdate,
                                    ONUMESACODI     => nuMESACODI,
                                    ONUERRORCODE    => onuMessageCode,
                                    OSBERRORMESSAGE => osbMessageText);
      -- retorna la pila de mensajes
      LDCI_PKMESAWS.PROGETMENSPROC(INUPROCCODI     => nuPROCCODI,
                                   ORFMENSPROC     => orfMensProc,
                                   ONUERRORCODE    => onuMessageCode,
                                   OSBERRORMESSAGE => osbMessageText);
      rollback;

  end proRegiProvCons;

  procedure proGetProvCons(iboExcepcion    in boolean,
                           inuPROCCODI     in LDCI_ESTAPROC.PROCCODI%type,
                           orfMensProc     out LDCI_PKMESAWS.tyRefcursor,
                           onuErrorCode    out NUMBER,
                           osbErrorMessage out VARCHAR2) as
    /*
     * Propiedad Intelectual Gases del cariba
     *
     * Script  : LDCI_PKMESAWS.proGetProvCons
     * Tiquete : 200-145
     * Autor   : AAcuna (JM)
     * Fecha   : 27/04/2017
     * Descripcion : Procedimiento encargado de tomar las
      *
      Parametros:

      IN :inuPROCCODI: For?!nea de LDCI_ESTAPROC, para identificar el proceso al que pertenece
      OUT: orfMensProc: Cursor con la informaic??n de los mensajes de salida
      OUT:onuErrorCode: C??digo de error
      OUT:osbErrorMessage: Mensaje de excepci??n

     * Historia de Modificaciones
     * Autor              Fecha         Descripcion
     * AAcuna (JM)           127/04/2017    Creacion del paquete
    **/
  begin
    -- carga la pila de mensajes para un proceso detemrindado
    if (iboExcepcion = true) then
      open orfMensProc for
        select MESAPROC, -1 AS MESACODI, MESADESC, MESATIPO
          from LDCI_MESAPROC
         where MESAPROC = inuPROCCODI;

    else

      open orfMensProc for
        select MESAPROC, 0 AS MESACODI, MESADESC, MESATIPO
          from LDCI_MESAPROC
         where MESAPROC = inuPROCCODI;

    end if;
  exception
    when others then
      rollback;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKMESAWS.proGetMensProc] Error no controlado: ' ||
                         SQLERRM || chr(13) ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      LDCI_pkWebServUtils.Procrearerrorlogint('ESTAPROC',
                                              1,
                                              osbErrorMessage,
                                              null,
                                              null);
  end proGetProvCons;

END LDCI_PKFACTURACION;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKFACTURACION
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKFACTURACION','ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTURACION to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTURACION to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKFACTURACION to REXEINNOVA;
/


