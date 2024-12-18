CREATE OR REPLACE PACKAGE ldci_ProcesosInterfazSap
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package  : ldci_ProcesosInterfazSap
    Descripcion  : Descripcion de la funcionalidad que realiza este paquete.

    Autor  : Nombre del creador de este paquete.
    Fecha  : DD-MM-YYYY (Fecha Creacion Paquete)  SAO (No Orden de Produccion.)

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
    -----------  -------------------    -------------------------------------

    ******************************************************************/
    --------------------------------------------
    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    --------------------------------------------
    -- Variables GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------
    type tyrcDocumentos IS record
    (
        nuInterfaz number,
        sbTipoInterfaz varchar2(2000),
        dtFechaConta date,
        nuDocumentos number,
        nuValorDb    number,
        nuValorCr    number
    );
    rcDocumentos tyrcDocumentos;


    --------------------------------------------
    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
    --------------------------------------------

    FUNCTION FSBVERSION    RETURN VARCHAR2;
    PROCEDURE ExecuteAll (sbSentencia varchar2);
    FUNCTION ValidaInterfazRecaudo(idtFechaMovimiento IN DATE,
                nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)  RETURN NUMBER;
    FUNCTION ValidaInterfazControlReinte(idtFechaMovimiento IN DATE,
                nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)  RETURN NUMBER;
    --<<
    -- heiberb 27-11-2014
    --se adicionan las funciones ValidaInterfazRecaudoRO y ValidaInterfazControlReinteRO para generar los comprobantes con diferencias
    -->>
    FUNCTION ValidaInterfazRecaudoRO(idtFechaMovimiento IN DATE,
                nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)  RETURN NUMBER;
    FUNCTION ValidaInterfazControlReinteRO(idtFechaMovimiento IN DATE,
                nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)  RETURN NUMBER;
    FUNCTION fnuValidaRecaudoResurecaRO(idtFechaMovimiento DATE, vFile utl_file.file_type) RETURN NUMBER;
    FUNCTION fnuValidaHechosRegistrosRO(idtFechaMovimiento DATE, nuTipoComprobante in IC_TICOCONT.TCCOCODI%type, vFile utl_file.file_type) RETURN NUMBER;

    PROCEDURE ActualizaFechaTrama;

    PROCEDURE proGenMailInterfaz (inuTrama       number,
                              isbtipointe    varchar2,
                              isbRemite      VARCHAR2,
                              nuError      out number);

    PROCEDURE proGenMailErrorInterfaz (isbOrError       varchar2,
                                   isbtipointe      varchar2,
                                   idtfecini        date,
                                   idtfecfin        date ,
                                   inuano           number,
                                   inumes           number,
                                   isbsender        varchar2,
                                   nuError          out number);

    PROCEDURE PROENVIARCHIVO(sbRemite      VARCHAR2,
                    sbRecibe      VARCHAR2,
                    sbAsunto      VARCHAR2 ,
                    sbTipoArchivo VARCHAR2 ,
                    sbMens        VARCHAR2 DEFAULT NULL,
                    nuError      out number);

    PROCEDURE ReporteRecaudoHERC (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                                    dtFechaRegistro date);
    PROCEDURE ReporteControlReinteHERC (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                                    dtFechaRegistro date);
    PROCEDURE ReporteTramaRecaudo
                            (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                            dtFechaRegistro date
                            );
    PROCEDURE ReporteTramaReintegro
                                (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                                dtFechaRegistro date
                                );

    FUNCTION NumeroDocumentos (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type)
    return tyrcDocumentos;

    FUNCTION fnuValidaHR(idtFechaMovimiento DATE, nuTipoComprobante in IC_TICOCONT.TCCOCODI%type) return number;
    
    FUNCTION fnuValidaHR_LA(idtFechaMovimiento DATE, nuTipoComprobante in IC_TICOCONT.TCCOCODI%type) return number;

END ldci_ProcesosInterfazSap;
/
CREATE OR REPLACE PACKAGE BODY ldci_ProcesosInterfazSap
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	: <MnemonicoModulo_BONombrePaquete>
    Descripcion	: Descripcion de la funcionalidad que realiza este paquete.

    Autor	: Nombre del creador de este paquete.
    Fecha	: DD-MM-YYYY (Fecha Creacion Paquete)  SAO (No Orden de Produccion.)

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
    20-06-2014  cdominguez  Se adicionan los metodos ReporteRecaudoHERC,
    ReporteControlReinteHERC, ReporteTramaRecaudo, ReporteTramaReintegro,
    NumeroDocumentos. Para generar los soportes de tramas, HE y RC.

    FCastro    15-11-2016    200-86. Se envia correo notificando que se envio la interfaz o
                             si hubo errores en el proceso.
                           
    Horbath     24/04/2020   CA-0000398 - Se modifica la interfaz de Control Reintegro, funcion fnuInterfazReintegroRO,  
                             para corregir la validacion del cuadre del movimiento el tipomovi 65 debe ser con signo CR 
                             para que cuadre.
                                
    -----------  -------------------    -------------------------------------

    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION      CONSTANT VARCHAR2(10) := 'Ara_4091';



    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------
    NoHechos          EXCEPTION;
    NoRegistros       EXCEPTION;
    NoResureca        EXCEPTION;

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------
    sbErrorMessage VARCHAR2(2000);
    nuErrorCode     number;
    sender          varchar2(2000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
    sbE_MAIL        varchar2(2000);
    sbAsunto        varchar2(2000);
    sbMensaje       varchar2(2000);
    csbSeparador    CONSTANT varchar2(2) := ';';
    vFile           UTL_FILE.file_type; -- Archivo de salida
    sbLineaDeta     varchar2(2000);
    cnuMAXLENGTH    CONSTANT number := 32000;
    sbPath          VARCHAR2(250);
    sbFile          VARCHAR2(250);

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FSBVERSION
    Descripcion :  Obtiene la version del paquete

    Autor       :  <Nombre del desarrollador que creo el procedimiento>
    Fecha       :  DD-MM-YYYY
    Parametros  :  Ninguno

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    DD-MM-YYYY   Autor<SAONNNN>     Descripcion de la modificacion
    ***************************************************************/
    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : fnuValidaHechosRegistros
  AUTOR       : Arquitecsoft S.A.S - Diego Fernando Oviedo
  FECHA       : 15-05-2014
  DESCRIPCION : Aranda 3550: Funcion que valida si existen Hechos Economicos y Registros Contables.
                Valida si existen diferencias entre Hechos Economicos y Registros Contables a nivel
                de Entidad, Punto de Pago y Clasificador. Escribe en un archivo plano las diferencias.

  Parametros de Entrada

  - idfFechaMovimiento

  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION fnuValidaHechosRegistros(idtFechaMovimiento DATE,
                        nuTipoComprobante in IC_TICOCONT.TCCOCODI%type,
                        vFile utl_file.file_type)
  RETURN NUMBER

   IS

    --<<
    --Variables
    -->>
    nuExisteHechos    NUMBER := 0;
    nuExisteRegistros NUMBER := 0;
    vaCuentasBanco    VARCHAR2(2000);
    vaCuentaCartera   VARCHAR2(2000);
    vaLineInco        VARCHAR2(10000);


    --<<
    -- Cursor para valdiar si existen Hechos Economicos de Recaudo
    -->>
    CURSOR cuExisteHechos IS
      SELECT COUNT(1)
        FROM open.ic_movimien
       WHERE movitido = 72
         AND movifeco = TRUNC(idtFechaMovimiento)
         AND ROWNUM < 2;

    --<<
    -- Cursor para valdiar si existen Registros Contables de Recaudo
    -->>
    CURSOR cuExisteRegistros IS
      SELECT COUNT(1)
        FROM open.ic_ticocont a, open.ic_compcont b, open.ic_encoreco c
       WHERE a.tccocodi = b.cocotcco
         AND b.cococodi = c.ecrccoco
         AND a.tccocodi = nuTipoComprobante
         AND c.ecrcfech = TRUNC(idtFechaMovimiento)
         AND ROWNUM < 2;

    type tyrcDiferencia IS record
    (
        Fecha_Contable date,
        Cod_Entidad number,
        Desc_Entidad varchar2(250),
        Cod_Punto_Pago number,
        Cod_Clasificador number,
        Desc_Clasificador varchar2(250),
        Total number
    );

    rcDiferencia tyrcDiferencia;

    --<<
    -- Cursor para valdiar diferencias entre Hechos Economicos y Registros Contables
    -->>
    TYPE tyDiferencias IS TABLE OF tyrcDiferencia INDEX BY BINARY_INTEGER;
    vtycuDiferencias tyDiferencias;

    cuDiferencias SYS_REFCURSOR;

  BEGIN


    OPEN  cuExisteHechos;
    FETCH cuExisteHechos INTO nuExisteHechos;
    CLOSE cuExisteHechos;

    IF (nuExisteHechos < 1) THEN
        RAISE NoRegistros;
    END IF;

    OPEN  cuExisteRegistros;
    FETCH cuExisteRegistros INTO nuExisteRegistros;
    CLOSE cuExisteRegistros;

    IF (nuExisteRegistros < 1) THEN
        RAISE NoHechos;
    END IF;

    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentasBanco', vaCuentasBanco, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentaCartera', vaCuentaCartera, sbErrorMessage);

    OPEN  cuDiferencias for
      SELECT a.movifeco Fecha_Contable,
             to_char(a.movibanc) Cod_Entidad,
             d.bancnomb Desc_Entidad,
             trim(to_char(a.movisuba)) Cod_Punto_Pago,
             c.clcocodi Cod_Clasificador,
             c.clcodesc Desc_Clasificador,
             SUM(DECODE(a.movisign, 'D', a.movivalo, -a.movivalo)) Total
        FROM ic_movimien a, ic_clascont c, banco d, concepto b
       WHERE a.moviconc = b.conccodi(+)
         AND a.movibanc = d.banccodi
         AND b.concclco = c.clcocodi
         AND a.movifeco BETWEEN idtFechaMovimiento AND idtFechaMovimiento
       GROUP BY a.movifeco,
                a.movibanc,
                d.bancnomb,
                a.movisuba,
                c.clcocodi,
                c.clcodesc
      MINUS
      SELECT Fecha_Contable,
             Cod_Entidad,
             Desc_Entidad,
             Cod_Punto_Pago,
             Cod_Clasificador,
             Desc_Clasificador,
             SUM(valor) Total
        FROM (SELECT c.ecrcfech Fecha_Contable,
                     ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|') Cod_Entidad,
                     pktblbanco.fsbgetbancnomb(ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|')) Desc_Entidad,
                     trim(ldci_pkinterfazsap.fvagetdata(29, dcrcinad, '|')) Cod_Punto_Pago,
                     h.clcocodi Cod_Clasificador,
                     h.clcodesc Desc_Clasificador,
                     DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) valor
                FROM ic_decoreco,
                     (SELECT *
                        FROM ic_encoreco
                       WHERE ecrccoge IN (SELECT cogecons
                                            FROM ic_compgene
                                           WHERE cogecoco IN
                                                 (SELECT cococodi
                                                    FROM ic_compcont
                                                   WHERE cocotcco = nuTipoComprobante)
                                             AND cogefein >= TRUNC(idtFechaMovimiento)
                                             AND cogefefi <= TRUNC(idtFechaMovimiento))) c,
                     ic_clascore p,
                     ic_clascont h
               WHERE dcrcecrc = c.ecrccons
                 AND dcrcclcr = p.clcrcons
                 AND p.clcrclco = h.clcocodi
                 AND (dcrccuco LIKE vaCuentasBanco OR dcrccuco LIKE vaCuentaCartera))
       GROUP BY Fecha_Contable,
                Cod_Entidad,
                Desc_Entidad,
                Cod_Punto_Pago,
                Cod_Clasificador,
                Desc_Clasificador;
    FETCH cuDiferencias BULK COLLECT INTO vtycuDiferencias;
    CLOSE cuDiferencias;

    vaLineInco := 'FECHA INICIAL: '||idtFechaMovimiento||' FECHA FINAL: '||idtFechaMovimiento;
    utl_file.put_line(vFile, vaLineInco);

    IF (vtycuDiferencias.count = 0) THEN
      vaLineInco := 'NO EXISTEN DIFERENCIAS ENTRE HECHOS ECONOMICOS Y REGISTROS CONTABLES PARA LA FECHA: '|| idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN(0);
    END IF;

    vaLineInco := 'DIFERENCIAS ENTRE HECHOS Y REGISTROS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);

    vaLineInco := 'FECHA CONTABLE;CODIGO ENTIDAD;DESCRIPCION DE LA ENTIDAD;CODIGO DEL PUNTO DE PAGO;CODIGO DEL CLASIFICADOR;DESCRIPCION CLASIFICADOR;TOTAL';
    utl_file.put_line(vFile, vaLineInco);

    FOR i IN vtycuDiferencias.First .. vtycuDiferencias.Last LOOP

        vaLineInco := TRUNC(vtycuDiferencias(i).Fecha_Contable) || csbSeparador ||
                      vtycuDiferencias(i).Cod_Entidad || csbSeparador ||
                      vtycuDiferencias(i).Desc_Entidad || csbSeparador ||
                      vtycuDiferencias(i).Cod_Punto_Pago || csbSeparador ||
                      vtycuDiferencias(i).Cod_Clasificador || csbSeparador ||
                      vtycuDiferencias(i).Desc_Clasificador || csbSeparador ||
                      vtycuDiferencias(i).Total ||csbSeparador;

        utl_file.put_line(vFile, vaLineInco);

    END LOOP;

    RETURN(0);

  EXCEPTION

    WHEN NoHechos THEN

      vaLineInco := 'NO EXISTEN HECHOS ECONOMICOS DE RECAUDO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN 0;

    WHEN NoRegistros THEN

      vaLineInco := 'NO EXISTEN REGISTROS CONTABLES DE RECAUDO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN 0;

    WHEN OTHERS THEN

      vaLineInco := 'ERROR EN LA VALIDACION DE HECHOS ECONOMICOS Y REGISTROS CONTABLES PARA LA FECHA: ' || idtfechamovimiento || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      RETURN(0);

  END fnuValidaHechosRegistros;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : fnuValidaHechosRegistrosRO
  AUTOR       : Arquitecsoft S.A.S - Diego Fernando Oviedo
  FECHA       : 15-05-2014
  DESCRIPCION : Aranda 3550: Funcion que valida si existen Hechos Economicos y Registros Contables.
                Valida si existen diferencias entre Hechos Economicos y Registros Contables a nivel
                de Entidad, Punto de Pago y Clasificador. Escribe en un archivo plano las diferencias.

  Parametros de Entrada

  - idfFechaMovimiento

  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION fnuValidaHechosRegistrosRO(idtFechaMovimiento DATE,
                        nuTipoComprobante in IC_TICOCONT.TCCOCODI%type,
                        vFile utl_file.file_type)
  RETURN NUMBER

   IS

    --<<
    --Variables
    -->>
    nuExisteHechos    NUMBER := 0;
    nuExisteRegistros NUMBER := 0;
    vaCuentasBanco    VARCHAR2(2000);
    vaCuentaCartera   VARCHAR2(2000);
    vaLineInco        VARCHAR2(10000);


    --<<
    -- Cursor para valdiar si existen Hechos Economicos de Recaudo
    -->>
    CURSOR cuExisteHechos IS
      SELECT COUNT(1)
        FROM open.ic_movimien
       WHERE movitido = 72
         AND movifeco = TRUNC(idtFechaMovimiento)
         AND ROWNUM < 2;

    --<<
    -- Cursor para valdiar si existen Registros Contables de Recaudo
    -->>
    CURSOR cuExisteRegistros IS
      SELECT COUNT(1)
        FROM open.ic_ticocont a, open.ic_compcont b, open.ic_encoreco c
       WHERE a.tccocodi = b.cocotcco
         AND b.cococodi = c.ecrccoco
         AND a.tccocodi = nuTipoComprobante
         AND c.ecrcfech = TRUNC(idtFechaMovimiento)
         AND ROWNUM < 2;

    type tyrcDiferencia IS record
    (
        Fecha_Contable date,
        Cod_Entidad number,
        Desc_Entidad varchar2(250),
        Cod_Punto_Pago number,
        Cod_Clasificador number,
        Desc_Clasificador varchar2(250),
        Total number
    );

    rcDiferencia tyrcDiferencia;

    --<<
    -- Cursor para valdiar diferencias entre Hechos Economicos y Registros Contables
    -->>
    TYPE tyDiferencias IS TABLE OF tyrcDiferencia INDEX BY BINARY_INTEGER;
    vtycuDiferencias tyDiferencias;

    cuDiferencias SYS_REFCURSOR;

  BEGIN


    OPEN  cuExisteHechos;
    FETCH cuExisteHechos INTO nuExisteHechos;
    CLOSE cuExisteHechos;

    IF (nuExisteHechos < 1) THEN
        RAISE NoRegistros;
    END IF;

    OPEN  cuExisteRegistros;
    FETCH cuExisteRegistros INTO nuExisteRegistros;
    CLOSE cuExisteRegistros;

    IF (nuExisteRegistros < 1) THEN
        RAISE NoHechos;
    END IF;

    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentasBanco', vaCuentasBanco, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentaCartera', vaCuentaCartera, sbErrorMessage);

    OPEN  cuDiferencias for
      SELECT a.movifeco Fecha_Contable,
             to_char(a.movibanc) Cod_Entidad,
             d.bancnomb Desc_Entidad,
             trim(to_char(a.movisuba)) Cod_Punto_Pago,
             c.clcocodi Cod_Clasificador,
             c.clcodesc Desc_Clasificador,
             SUM(DECODE(a.movisign, 'D', a.movivalo, -a.movivalo)) Total
        FROM ic_movimien a, ic_clascont c, banco d, concepto b
       WHERE a.moviconc = b.conccodi
         AND a.movibanc = d.banccodi
         AND b.concclco = c.clcocodi(+)
         AND a.movifeco BETWEEN idtFechaMovimiento AND idtFechaMovimiento
       GROUP BY a.movifeco,
                a.movibanc,
                d.bancnomb,
                a.movisuba,
                c.clcocodi,
                c.clcodesc
      MINUS
      SELECT Fecha_Contable,
             Cod_Entidad,
             Desc_Entidad,
             Cod_Punto_Pago,
             Cod_Clasificador,
             Desc_Clasificador,
             SUM(valor) Total
        FROM (SELECT c.ecrcfech Fecha_Contable,
                     ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|') Cod_Entidad,
                     pktblbanco.fsbgetbancnomb(ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|')) Desc_Entidad,
                     trim(ldci_pkinterfazsap.fvagetdata(29, dcrcinad, '|')) Cod_Punto_Pago,
                     h.clcocodi Cod_Clasificador,
                     h.clcodesc Desc_Clasificador,
                     DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) valor
                FROM ic_decoreco,
                     (SELECT *
                        FROM ic_encoreco
                       WHERE ecrccoge IN (SELECT cogecons
                                            FROM ic_compgene
                                           WHERE cogecoco IN
                                                 (SELECT cococodi
                                                    FROM ic_compcont
                                                   WHERE cocotcco = nuTipoComprobante)
                                             AND TRUNC(cogefein) >= idtFechaMovimiento
                                             AND TRUNC(cogefefi) <= idtFechaMovimiento)) c,
                     ic_clascore p,
                     ic_clascont h
               WHERE dcrcecrc = c.ecrccons
                 AND dcrcclcr = p.clcrcons
                 AND p.clcrclco = h.clcocodi
                 AND (dcrccuco LIKE vaCuentasBanco OR dcrccuco LIKE vaCuentaCartera))
       GROUP BY Fecha_Contable,
                Cod_Entidad,
                Desc_Entidad,
                Cod_Punto_Pago,
                Cod_Clasificador,
                Desc_Clasificador;
    FETCH cuDiferencias BULK COLLECT INTO vtycuDiferencias;
    CLOSE cuDiferencias;

    vaLineInco := 'FECHA INICIAL: '||idtFechaMovimiento||' FECHA FINAL: '||idtFechaMovimiento;
    utl_file.put_line(vFile, vaLineInco);

    IF (vtycuDiferencias.count = 0) THEN
      vaLineInco := 'NO EXISTEN DIFERENCIAS ENTRE HECHOS ECONOMICOS Y REGISTROS CONTABLES PARA LA FECHA: '|| idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN(0);
    END IF;

    vaLineInco := 'DIFERENCIAS ENTRE HECHOS Y REGISTROS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);

    vaLineInco := 'FECHA CONTABLE;CODIGO ENTIDAD;DESCRIPCION DE LA ENTIDAD;CODIGO DEL PUNTO DE PAGO;CODIGO DEL CLASIFICADOR;DESCRIPCION CLASIFICADOR;TOTAL';
    utl_file.put_line(vFile, vaLineInco);

    FOR i IN vtycuDiferencias.First .. vtycuDiferencias.Last LOOP

        vaLineInco := TRUNC(vtycuDiferencias(i).Fecha_Contable) || csbSeparador ||
                      vtycuDiferencias(i).Cod_Entidad || csbSeparador ||
                      vtycuDiferencias(i).Desc_Entidad || csbSeparador ||
                      vtycuDiferencias(i).Cod_Punto_Pago || csbSeparador ||
                      vtycuDiferencias(i).Cod_Clasificador || csbSeparador ||
                      vtycuDiferencias(i).Desc_Clasificador || csbSeparador ||
                      vtycuDiferencias(i).Total ||csbSeparador;

        utl_file.put_line(vFile, vaLineInco);

    END LOOP;

    RETURN(0);

  EXCEPTION

    WHEN NoHechos THEN

      vaLineInco := 'NO EXISTEN HECHOS ECONOMICOS DE RECAUDO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN 0;

    WHEN NoRegistros THEN

      vaLineInco := 'NO EXISTEN REGISTROS CONTABLES DE RECAUDO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN 0;

    WHEN OTHERS THEN

      vaLineInco := 'ERROR EN LA VALIDACION DE HECHOS ECONOMICOS Y REGISTROS CONTABLES PARA LA FECHA: ' || idtfechamovimiento || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      RETURN(0);

  END fnuValidaHechosRegistrosRO;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : fnuValidaRecaudoResureca
  AUTOR       : Arquitecsoft S.A.S - Diego Fernando Oviedo
  FECHA       : 15-05-2014
  DESCRIPCION : Aranda 3550: Funcion que valida si existe Resumen de Recaudo.
                Valida si existen diferencias entre Recaudo y Resumen de Recaudo,
                escribe en un archivo plano las diferencias.

  Parametros de Entrada

  - idfFechaMovimiento

  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION fnuValidaRecaudoResureca(idtFechaMovimiento DATE, vFile utl_file.file_type)
  RETURN NUMBER

   IS

    --<<
    --Variables
    -->>
    nuExisteResureca  NUMBER;
    vaLineInco        VARCHAR2(10000);
    dtFechaIni        DATE;
    dtFechaFin        DATE;

    --<<
    -- Cursor para valdiar si existe Resumen de Recaudo
    -->>
    CURSOR cuExisteResureca(dtFechaIni date) IS
      SELECT COUNT(1)
        FROM open.resureca
       WHERE TRUNC(rerefegr) = TRUNC(dtFechaIni)
         AND ROWNUM < 2;

    --<<
    -- Cursor para valdiar diferencias entre Recaudo y Resumen de Recaudo
    -->>
    CURSOR cuDiferencias (dtFechaIni date, dtFechaFin date) IS
      SELECT a.rerefegr fecha_grabacion,
             (SELECT cupotipo FROM cupon WHERE cuponume = a.pagocupo) tipo,
             a.pagobanc banco,
             a.pagosuba sucursal,
             a.pagocupo cupon,
             a.valorpago valor_pago,
             a.rerebanc banco_resureca,
             a.reresuba sucursal_resureca,
             a.rerecupo cupon_resureca,
             a.valorresu valor_resureca,
             (a.valorpago - a.valorresu) diferencia
        FROM (SELECT /*+ rule*/
                     rerefegr,
                     pagobanc,
                     pagosuba,
                     pagocupo,
                     pagovapa valorpago,
                     rerebanc,
                     reresuba,
                     rerecupo,
                     SUM(rerevalo) valorresu
                FROM open.pagos, open.resureca
               WHERE pagofegr BETWEEN dtFechaIni AND dtFechaFin
                 AND pagocupo = rerecupo(+)
                 AND NOT EXISTS (SELECT 'X'
                                   FROM open.rc_pagoanul
                                  WHERE paancupo = pagocupo)
               GROUP BY rerefegr,
                        pagobanc,
                        pagosuba,
                        pagovapa,
                        pagocupo,
                        rerebanc,
                        reresuba,
                        rerecupo) a
       WHERE (nvl(valorpago, 0) - nvl(valorresu, 0)) <> 0;

    TYPE tycuDiferencias IS TABLE OF cuDiferencias%ROWTYPE INDEX BY BINARY_INTEGER;
    vtycuDiferencias tycuDiferencias;

  BEGIN

    dtFechaIni := trunc(idtFechaMovimiento);
    dtFechaFin := to_date(to_char(to_date(idtFechaMovimiento),'DD')||to_char(to_date(idtFechaMovimiento),'MM')||'-'||to_char(to_date(idtFechaMovimiento),'YYYY')||'23:59:59');
    vtycuDiferencias.delete;

   vaLineInco := 'FECHA INICIAL: '||idtFechaMovimiento||' FECHA FINAL: '||idtFechaMovimiento;
    utl_file.put_line(vFile, vaLineInco);

    OPEN  cuExisteResureca(dtFechaIni);
    FETCH cuExisteResureca INTO nuExisteResureca;
    CLOSE cuExisteResureca;

    IF (nuExisteResureca < 1) THEN
        RAISE NoResureca;
    END IF;

    OPEN  cuDiferencias(dtFechaIni, dtFechaFin) ;
    FETCH cuDiferencias BULK COLLECT INTO vtycuDiferencias;
    CLOSE cuDiferencias;

    IF (vtycuDiferencias.count = 0) THEN
        vaLineInco := 'NO EXISTEN DIFERENCIAS ENTRE RECAUDO Y RESUMEN DE RECAUDO PARA LA FECHA: '|| idtfechamovimiento;
        utl_file.put_line(vFile, vaLineInco);
        RETURN(0);
    END IF;

    vaLineInco := 'FECHA GRABACION;TIPO;BANCO;SUCURSAL;CUPON;VALOR PAGO;BANCO RESURECA;SUCURSAL RESURECA;CUPON RESURECA;VALOR PAGO RESURECA;DIFERENCIA';
    utl_file.put_line(vFile, vaLineInco);

    FOR i IN vtycuDiferencias.First .. vtycuDiferencias.Last LOOP
        vaLineInco := vtycuDiferencias(i).fecha_grabacion || csbSeparador ||
                      vtycuDiferencias(i).tipo || csbSeparador ||
                      vtycuDiferencias(i).banco || csbSeparador ||
                      vtycuDiferencias(i).sucursal || csbSeparador ||
                      vtycuDiferencias(i).cupon || csbSeparador ||
                      vtycuDiferencias(i).valor_pago || csbSeparador ||
                      vtycuDiferencias(i).banco_resureca || csbSeparador ||
                      vtycuDiferencias(i).sucursal_resureca || csbSeparador ||
                      vtycuDiferencias(i).cupon_resureca || csbSeparador ||
                      vtycuDiferencias(i).valor_resureca || csbSeparador ||
                      vtycuDiferencias(i).diferencia || csbSeparador;

        utl_file.put_line(vFile, vaLineInco);
    END LOOP;

    RETURN(0);

  EXCEPTION

    WHEN NoResureca THEN

      vaLineInco := 'NO EXISTEN RESUMEN DE RECAUDO PARA LA FECHA: ' || idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN 0;

    WHEN OTHERS THEN

      vaLineInco := 'ERROR EN LA VALIDACION DE RECAUDO Y RESUMEN DE RECAUDO PARA LA FECHA: ' || idtfechamovimiento || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      RETURN(0);

  END fnuValidaRecaudoResureca;

    /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : fnuValidaRecaudoResurecaRO
  AUTOR       : Arquitecsoft S.A.S - Diego Fernando Oviedo
  FECHA       : 15-05-2014
  DESCRIPCION : Aranda 3550: Funcion que valida si existe Resumen de Recaudo.
                Valida si existen diferencias entre Recaudo y Resumen de Recaudo,
                escribe en un archivo plano las diferencias.

  Parametros de Entrada

  - idfFechaMovimiento

  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION fnuValidaRecaudoResurecaRO(idtFechaMovimiento DATE, vFile utl_file.file_type)
  RETURN NUMBER

   IS

    --<<
    --Variables
    -->>
    nuExisteResureca  NUMBER;
    vaLineInco        VARCHAR2(10000);
    dtFechaIni        DATE;
    dtFechaFin        DATE;

    --<<
    -- Cursor para valdiar si existe Resumen de Recaudo
    -->>
    CURSOR cuExisteResureca(dtFechaIni date) IS
      SELECT COUNT(1)
        FROM open.resureca
       WHERE TRUNC(rerefegr) = TRUNC(dtFechaIni)
         AND ROWNUM < 2;

    --<<
    -- Cursor para valdiar diferencias entre Recaudo y Resumen de Recaudo
    -->>
    CURSOR cuDiferencias (dtFechaIni date, dtFechaFin date) IS
      SELECT a.rerefegr fecha_grabacion,
             (SELECT cupotipo FROM cupon WHERE cuponume = a.pagocupo) tipo,
             a.pagobanc banco,
             a.pagosuba sucursal,
             a.pagocupo cupon,
             a.valorpago valor_pago,
             a.rerebanc banco_resureca,
             a.reresuba sucursal_resureca,
             a.rerecupo cupon_resureca,
             a.valorresu valor_resureca,
             (a.valorpago - a.valorresu) diferencia
        FROM (SELECT /*+ rule*/
                     rerefegr,
                     pagobanc,
                     pagosuba,
                     pagocupo,
                     pagovapa valorpago,
                     rerebanc,
                     reresuba,
                     rerecupo,
                     SUM(rerevalo) valorresu
                FROM open.pagos, open.resureca
               WHERE pagofegr BETWEEN dtFechaIni AND dtFechaFin
                 AND pagocupo = rerecupo(+)
                 AND NOT EXISTS (SELECT 'X'
                                   FROM open.rc_pagoanul
                                  WHERE paancupo = pagocupo)
               GROUP BY rerefegr,
                        pagobanc,
                        pagosuba,
                        pagovapa,
                        pagocupo,
                        rerebanc,
                        reresuba,
                        rerecupo) a
       WHERE (nvl(valorpago, 0) - nvl(valorresu, 0)) <> 0;

    TYPE tycuDiferencias IS TABLE OF cuDiferencias%ROWTYPE INDEX BY BINARY_INTEGER;
    vtycuDiferencias tycuDiferencias;

  BEGIN

    dtFechaIni := trunc(idtFechaMovimiento);
    dtFechaFin := to_date(to_char(to_date(idtFechaMovimiento),'DD')||to_char(to_date(idtFechaMovimiento),'MM')||'-'||to_char(to_date(idtFechaMovimiento),'YYYY')||'23:59:59');
    vtycuDiferencias.delete;

   vaLineInco := 'FECHA INICIAL: '||idtFechaMovimiento||' FECHA FINAL: '||idtFechaMovimiento;
    utl_file.put_line(vFile, vaLineInco);

    OPEN  cuDiferencias(dtFechaIni, dtFechaFin) ;
    FETCH cuDiferencias BULK COLLECT INTO vtycuDiferencias;
    CLOSE cuDiferencias;

    IF (vtycuDiferencias.count = 0) THEN
        vaLineInco := 'NO EXISTEN DIFERENCIAS ENTRE RECAUDO Y RESUMEN DE RECAUDO PARA LA FECHA: '|| idtfechamovimiento;
        utl_file.put_line(vFile, vaLineInco);
        RETURN(0);

    END IF;

    vaLineInco := 'FECHA GRABACION;TIPO;BANCO;SUCURSAL;CUPON;VALOR PAGO;BANCO RESURECA;SUCURSAL RESURECA;CUPON RESURECA;VALOR PAGO RESURECA;DIFERENCIA';
    utl_file.put_line(vFile, vaLineInco);

    FOR i IN vtycuDiferencias.First .. vtycuDiferencias.Last LOOP
        vaLineInco := vtycuDiferencias(i).fecha_grabacion || csbSeparador ||
                      vtycuDiferencias(i).tipo || csbSeparador ||
                      vtycuDiferencias(i).banco || csbSeparador ||
                      vtycuDiferencias(i).sucursal || csbSeparador ||
                      vtycuDiferencias(i).cupon || csbSeparador ||
                      vtycuDiferencias(i).valor_pago || csbSeparador ||
                      vtycuDiferencias(i).banco_resureca || csbSeparador ||
                      vtycuDiferencias(i).sucursal_resureca || csbSeparador ||
                      vtycuDiferencias(i).cupon_resureca || csbSeparador ||
                      vtycuDiferencias(i).valor_resureca || csbSeparador ||
                      vtycuDiferencias(i).diferencia || csbSeparador;

        utl_file.put_line(vFile, vaLineInco);
    END LOOP;

    RETURN(0);

  EXCEPTION

    WHEN NoResureca THEN

      vaLineInco := 'NO EXISTEN RESUMEN DE RECAUDO PARA LA FECHA: ' || idtfechamovimiento;
      utl_file.put_line(vFile, vaLineInco);
      RETURN 0;

    WHEN OTHERS THEN

      vaLineInco := 'ERROR EN LA VALIDACION DE RECAUDO Y RESUMEN DE RECAUDO PARA LA FECHA: ' || idtfechamovimiento || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      RETURN(0);

  END fnuValidaRecaudoResurecaRO;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : fnuValidaCuentasConta
  AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
  FECHA       : 11-06-2014
  DESCRIPCION : Valida la existencia de todas las cuentas configuradas

  Parametros de Entrada

  - idfFechaMovimiento

  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION fnuValidaCuentasConta(nuTipoComprobante in IC_TICOCONT.TCCOCODI%type, vFile in utl_file.file_type)
  RETURN NUMBER
   IS
    --<<
    --Variables
    -->>
    vaLineInco        VARCHAR2(10000);
    sbSentencia VARCHAR2(2000);
    rcLDCI_CTACADMI LDCI_CTACADMI%rowtype;
    type tyCuentas IS TABLE OF varchar2(2000) INDEX BY VARCHAR2(250);
    tbCuentas tyCuentas;
    sbIndice varchar2(250);

    --<<
    -- Cursor para valdiar Existencia de cuentas
    -->>
    CURSOR cuExisteCts (nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)  IS
    SELECT unique  COD_TIPCOMPROBANTE,
           COD_COMPROBANTE,
           tidccodi COD_TIPOMOVIMIENTO,
           COD_CLASCONT,
           CUENTA,
           PORC_PARTICIPA
      FROM (SELECT A.COCOCODI COD_COMPROBANTE,
                   B.TCCOCODI COD_TIPCOMPROBANTE,
                   tidccodi,
                   E.TIMOCODI COD_TIPOMOVIMIENTO,
                   F.CLCRCONS,
                   G.CLCOCODI COD_CLASCONT,
                   I.RCCCCUCO CUENTA,
                   I.RCCCPOPA PORC_PARTICIPA
              FROM OPEN.IC_COMPCONT A,
                   OPEN.IC_TICOCONT B,
                   OPEN.IC_CONFRECO C,
                   OPEN.IC_TIPODOCO D,
                   OPEN.IC_TIPOMOVI E,
                   OPEN.IC_CLASCORE F,
                   OPEN.IC_CLASCONT G,
                   OPEN.IC_RECOCLCO I,
                   open.IC_CRCORECO J
             WHERE B.TCCOCODI = nuTipoComprobante
               AND J.CCRCCLCR(+) = F.CLCRCONS
               AND A.COCOCODI = C.CORCCOCO
               AND C.CORCTIDO = D.TIDCCODI
               AND C.CORCTIMO = E.TIMOCODI
               AND C.CORCCONS = F.CLCRCORC
               AND F.CLCRCLCO = G.CLCOCODI
               AND F.CLCRCONS = I.RCCCCLCR
               AND A.COCOTCCO = B.TCCOCODI
               )
               ORDER BY cod_comprobante;

    TYPE tyExisteCts IS TABLE OF cuExisteCts%ROWTYPE INDEX BY BINARY_INTEGER;
    tbExisteCts tyExisteCts;

  BEGIN

    OPEN  cuExisteCts (nuTipoComprobante) ;
    FETCH cuExisteCts BULK COLLECT INTO tbExisteCts;
    CLOSE cuExisteCts;

    IF (tbExisteCts.count = 0) THEN
        vaLineInco := 'NO EXISTEN DIFERENCIAS ENTRE EN CONFIGURACION DE CUENTAS PARA TIPO COMPROBANTE: '||nuTipoComprobante;
        utl_file.put_line(vFile, vaLineInco);
        RETURN(0);
    END IF;

    vaLineInco := 'VALIDACION DE CUENTAS QUE NO ESTAN CONFIGURADAS';
    utl_file.put_line(vFile, vaLineInco);

    if nuTipoComprobante in ( 1, 3, 5, 6, 7 ) then
        sbSentencia := 'select * FROM LDCI_CTACADMI WHERE CTCACODI = :nucuctcodi AND CTACLCO = :nuClasificador AND ROWNUM = 1';
        tbCuentas('1') := sbSentencia;
    elsif nuTipoComprobante in( 2, 8 ) then
        sbSentencia := 'select * FROM LDCI_CTACADMI WHERE CTCACODI = :nucuctcodi AND CTACLCO = :nuClasificador AND CTCPORC = :nuPorcen';
        tbCuentas('1') := sbSentencia;
    END if;

    FOR i IN tbExisteCts.First .. tbExisteCts.Last LOOP
        -- Tipo de comprobante INGRESOS, RECAUDOS, PROVISON CONSUMO, AUTORETENCION, RECLASIFICACION CARTEA, PROVISION CARTERA
        if nuTipoComprobante in ( 1, 3, 5, 6, 7 ) then
            begin
                execute immediate sbSentencia INTO rcLDCI_CTACADMI using tbExisteCts(i).CUENTA, tbExisteCts(i).COD_CLASCONT;
            EXCEPTION
                when others then
                sbIndice := tbExisteCts(i).CUENTA||csbSeparador||tbExisteCts(i).COD_CLASCONT;
                tbCuentas(sbIndice) := 'Comprobante: '||tbExisteCts(i).COD_COMPROBANTE||'  valores '||tbExisteCts(i).CUENTA||csbSeparador||tbExisteCts(i).COD_CLASCONT;
            END;
        END if;

        -- Tipo de comprobante RECAUDOS, REINTEGRO
        if nuTipoComprobante in( 2, 8 ) then
            begin
                execute immediate sbSentencia INTO rcLDCI_CTACADMI using tbExisteCts(i).CUENTA, tbExisteCts(i).COD_CLASCONT, tbExisteCts(i).PORC_PARTICIPA;
            EXCEPTION
                when others then
                sbIndice := tbExisteCts(i).CUENTA||csbSeparador||tbExisteCts(i).COD_CLASCONT;
                tbCuentas(sbIndice) := 'Comprobante: '||tbExisteCts(i).COD_COMPROBANTE||'  valores '||tbExisteCts(i).CUENTA||csbSeparador||tbExisteCts(i).COD_CLASCONT||csbSeparador||tbExisteCts(i).PORC_PARTICIPA;
            END;
        END if;

    END LOOP;

    sbIndice := tbCuentas.first;
    loop
        exit when sbIndice IS null;
        utl_file.put_line(vFile, tbCuentas(sbIndice));
        sbIndice := tbCuentas.next(sbIndice);
    END loop;
    -- elimina posicion de sentencia
    tbCuentas.delete('1');

    RETURN(tbCuentas.count);

  EXCEPTION

    WHEN OTHERS THEN

      vaLineInco := 'ERROR EN LA VALIDACION DE CUENTAS PARA TIPO COMPROBANTE: ' || nuTipoComprobante || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      RETURN(-1);

  END fnuValidaCuentasConta;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : ValidaInterfazRecaudo
  AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
  FECHA       : 11-06-2014
  DESCRIPCION : Validacion de la interfaz

  Parametros de Entrada


  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION ValidaInterfazRecaudo(idtFechaMovimiento IN DATE, nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)
  RETURN NUMBER
   IS
    --<<
    --Variables
    -->>
    vaLineInco      VARCHAR2(10000);
    nuSalida        numbeR;
    sbComando       varchar2(250);
  BEGIN

    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CorreoReporte', sbE_MAIL, sbErrorMessage);

    sbFile := sbFile || '_RE_' ||to_char(idtFechaMovimiento,'MONDD_YY') ||'.csv';
    vFile  := utl_file.fopen(sbPath, sbFile, 'W');

    vaLineInco := '** INCIA VALIDACION RESUMEN DE CARTERA';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaRecaudoResureca(idtFechaMovimiento, vFile);
    vaLineInco := '*** FINALIZA VALIDACION RESUMEN DE CARTERA';
    utl_file.put_line(vFile, vaLineInco);

    vaLineInco := '** INCIA VALIDACION HECHOS Y REGISTROS';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaHechosRegistros(idtFechaMovimiento,nuTipoComprobante, vFile);
    vaLineInco := '*** FINALIZA VALIDACION HECHOS Y REGISTROS';
    utl_file.put_line(vFile, vaLineInco);

    /*
    vaLineInco := '** INCIA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaCuentasConta(nuTipoComprobante, vFile);
    vaLineInco := '*** FINALIZA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    */

    utl_file.put_line(vFile, 'Finaliza Validaciones');
    utl_file.fclose(vFile);

    sbAsunto := 'Interfaz recaudos: '||to_char(idtFechaMovimiento,'DD-MON-YYYY');
    sbMensaje := 'Reporte de validacion de la interfaz de recaudos.  Fecha: '||
            to_char(idtFechaMovimiento,'DD-MON-YYYY')||' Tipo Comprobante: '||nuTipoComprobante||
            chr(10)||'Usuario: '||ut_session.getuser||' Terminal:'||ut_session.getterminal;

    LDC_ManagementEmailFNB.PROENVIARCHIVO (sender,
                           sbE_MAIL,
                           sbAsunto ,
                           sbFile ,
                           'text/plain',
                           sbMensaje,
                           sbPath,
       			     	   nuErrorCode);

    RETURN(0);
  EXCEPTION
    WHEN OTHERS THEN
      vaLineInco := 'ERROR EN LA VALIDACION : ' || nuTipoComprobante || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      utl_file.fclose(vFile);
      RETURN(-1);
  END ValidaInterfazRecaudo;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : ValidaInterfazRecaudoRO
  AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
  FECHA       : 11-06-2014
  DESCRIPCION : Validacion de la interfaz

  Parametros de Entrada


  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION ValidaInterfazRecaudoRO(idtFechaMovimiento IN DATE, nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)
  RETURN NUMBER
   IS
    --<<
    --Variables
    -->>
    vaLineInco      VARCHAR2(10000);
    nuSalida        numbeR;
    sbComando       varchar2(250);
  BEGIN

    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CorreoReporte', sbE_MAIL, sbErrorMessage);

    sbFile := sbFile || '_RE_' ||to_char(idtFechaMovimiento,'MONDD_YY') ||'.csv';
    vFile  := utl_file.fopen(sbPath, sbFile, 'W');

    vaLineInco := '** INCIA VALIDACION RESUMEN DE CARTERA';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaRecaudoResurecaRO(idtFechaMovimiento, vFile);
    vaLineInco := '*** FINALIZA VALIDACION RESUMEN DE CARTERA';
    utl_file.put_line(vFile, vaLineInco);

    vaLineInco := '** INCIA VALIDACION HECHOS Y REGISTROS';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaHechosRegistrosRO(idtFechaMovimiento,nuTipoComprobante, vFile);
    vaLineInco := '*** FINALIZA VALIDACION HECHOS Y REGISTROS';
    utl_file.put_line(vFile, vaLineInco);
    /*
    vaLineInco := '** INCIA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaCuentasConta(nuTipoComprobante, vFile);
    vaLineInco := '*** FINALIZA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    */

    utl_file.put_line(vFile, 'Finaliza Validaciones');
    utl_file.fclose(vFile);

    sbAsunto := 'Interfaz recaudos: '||to_char(idtFechaMovimiento,'DD-MON-YYYY');
    sbMensaje := 'Reporte de validacion de la interfaz de recaudos.  Fecha: '||
            to_char(idtFechaMovimiento,'DD-MON-YYYY')||' Tipo Comprobante: '||nuTipoComprobante||
            chr(10)||'Usuario: '||ut_session.getuser||' Terminal:'||ut_session.getterminal;

    LDC_ManagementEmailFNB.PROENVIARCHIVO (sender,
                           sbE_MAIL,
                           sbAsunto ,
                           sbFile ,
                           'text/plain',
                           sbMensaje,
                           sbPath,
       			     	   nuErrorCode);

    RETURN(0);
  EXCEPTION
    WHEN OTHERS THEN
      vaLineInco := 'ERROR EN LA VALIDACION : ' || nuTipoComprobante || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      utl_file.fclose(vFile);
      RETURN(-1);
  END ValidaInterfazRecaudoRO;


/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : ValidaInterfazControlReinte
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Validacion de la interfaz Control Reintegro

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/
FUNCTION ValidaInterfazControlReinte(idtFechaMovimiento IN DATE, nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)
  RETURN NUMBER
   IS
    --<<
    --Variables
    -->>
    vaLineInco      VARCHAR2(10000);
    nuSalida        number;
    nuExisteHechos    NUMBER := 0;
    nuExisteRegistros NUMBER := 0;
    sbComando       varchar2(250);

    --<<
    -- Cursor para valdiar si existen Hechos Economicos de Recaudo
    -->>
    CURSOR cuExisteHechos IS
        SELECT COUNT(1)
          FROM open.ic_movimien
         WHERE movitido = 74
           AND movifeco = TRUNC(idtFechaMovimiento)
           AND ROWNUM < 2
         GROUP BY movifeco;

    --<<
    -- Cursor para valdiar si existen Registros Contables de Recaudo
    -->>
    CURSOR cuExisteRegistros IS
        SELECT COUNT(1)
          FROM open.ic_ticocont a, open.ic_compcont b, open.ic_encoreco c
         WHERE a.tccocodi = b.cocotcco
           AND a.tccocodi = nuTipoComprobante
           AND c.ecrcfech = TRUNC(idtFechaMovimiento)
           AND b.cococodi = c.ecrccoco
         ORDER BY a.tccocodi, c.ecrcfech, b.cococodi;

  BEGIN

    sbFile := sbFile || '_CR_' ||to_char(idtFechaMovimiento,'MONDD_YY') ||'.csv';
    vFile  := utl_file.fopen(sbPath, sbFile, 'W');

    OPEN  cuExisteHechos;
    FETCH cuExisteHechos INTO nuExisteHechos;
    CLOSE cuExisteHechos;

    vaLineInco := '** INCIA VALIDACION HECHOS ECONOMICOS';
    utl_file.put_line(vFile, vaLineInco);

    IF (nuExisteHechos < 1) THEN
        vaLineInco := 'NO EXISTEN HECHOS ECONOMICOS DE CONTROL REINTEGRO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
        utl_file.put_line(vFile, vaLineInco);
    END IF;
    vaLineInco := '*** FINALIZA VALIDACION HECHOS ECONOMICOS';
    utl_file.put_line(vFile, vaLineInco);

    OPEN  cuExisteRegistros;
    FETCH cuExisteRegistros INTO nuExisteRegistros;
    CLOSE cuExisteRegistros;

    vaLineInco := '** INCIA VALIDACION REGISTROS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);

    IF (nuExisteRegistros < 1) THEN
        vaLineInco := 'NO EXISTEN REGISTROS CONTABLES DE CONTROL REINTEGRO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
        utl_file.put_line(vFile, vaLineInco);
    END IF;
    vaLineInco := '*** FINALIZA VALIDACION REGISTROS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);

    /*
    vaLineInco := '** INCIA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaCuentasConta(nuTipoComprobante, vFile);
    vaLineInco := '*** FINALIZA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    */

    utl_file.put_line(vFile, 'Finaliza Validaciones');
    utl_file.fclose(vFile);

    sbAsunto := 'Interfaz control reintegro: '||to_char(idtFechaMovimiento,'DD-MON-YYYY');
    sbMensaje := 'Reporte de validacion de la interfaz de control reintegro. Fecha: '||
            to_char(idtFechaMovimiento,'DD-MON-YYYY')||' Tipo Comprobante: '||nuTipoComprobante||
            chr(10)||'Usuario: '||ut_session.getuser||' Terminal:'||ut_session.getterminal;

    LDC_ManagementEmailFNB.PROENVIARCHIVO (sender,
                           sbE_MAIL,
                           sbAsunto ,
                           sbFile ,
                           'text/plain',
                           sbMensaje,
                           sbPath,
       			     	   nuErrorCode);

    RETURN(0);
  EXCEPTION
    WHEN OTHERS THEN
      vaLineInco := 'ERROR EN LA VALIDACION : ' || nuTipoComprobante || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      utl_file.fclose(vFile);
      RETURN(-1);
  END ValidaInterfazControlReinte;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : ValidaInterfazControlReinteRO
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Validacion de la interfaz Control Reintegro

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/
FUNCTION ValidaInterfazControlReinteRO(idtFechaMovimiento IN DATE, nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)
  RETURN NUMBER
   IS
    --<<
    --Variables
    -->>
    vaLineInco      VARCHAR2(10000);
    nuSalida        number;
    nuExisteHechos    NUMBER := 0;
    nuExisteRegistros NUMBER := 0;
    sbComando       varchar2(250);

    --<<
    -- Cursor para valdiar si existen Hechos Economicos de Recaudo
    -->>
    CURSOR cuExisteHechos IS
        SELECT COUNT(1)
          FROM open.ic_movimien
         WHERE movitido = 74
           AND movifeco = TRUNC(idtFechaMovimiento)
           AND ROWNUM < 2
         GROUP BY movifeco;

    --<<
    -- Cursor para valdiar si existen Registros Contables de Recaudo
    -->>
    CURSOR cuExisteRegistros IS
        SELECT COUNT(1)
          FROM open.ic_ticocont a, open.ic_compcont b, open.ic_encoreco c
         WHERE a.tccocodi = b.cocotcco
           AND a.tccocodi = nuTipoComprobante
           AND c.ecrcfech = TRUNC(idtFechaMovimiento)
           AND b.cococodi = c.ecrccoco
         ORDER BY a.tccocodi, c.ecrcfech, b.cococodi;

  BEGIN

    sbFile := sbFile || '_CR_' ||to_char(idtFechaMovimiento,'MONDD_YY') ||'.csv';
    vFile  := utl_file.fopen(sbPath, sbFile, 'W');

    OPEN  cuExisteHechos;
    FETCH cuExisteHechos INTO nuExisteHechos;
    CLOSE cuExisteHechos;

    vaLineInco := '** INCIA VALIDACION HECHOS ECONOMICOS';
    utl_file.put_line(vFile, vaLineInco);

    IF (nuExisteHechos < 1) THEN
        vaLineInco := 'NO EXISTEN HECHOS ECONOMICOS DE CONTROL REINTEGRO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
        utl_file.put_line(vFile, vaLineInco);
    END IF;
    vaLineInco := '*** FINALIZA VALIDACION HECHOS ECONOMICOS';
    utl_file.put_line(vFile, vaLineInco);

    OPEN  cuExisteRegistros;
    FETCH cuExisteRegistros INTO nuExisteRegistros;
    CLOSE cuExisteRegistros;

    vaLineInco := '** INCIA VALIDACION REGISTROS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);

    IF (nuExisteRegistros < 1) THEN
        vaLineInco := 'NO EXISTEN REGISTROS CONTABLES DE CONTROL REINTEGRO GENERADOS PARA LA FECHA: ' || idtfechamovimiento;
        utl_file.put_line(vFile, vaLineInco);
    END IF;
    vaLineInco := '*** FINALIZA VALIDACION REGISTROS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);

    /*
    vaLineInco := '** INCIA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    nuSalida := fnuValidaCuentasConta(nuTipoComprobante, vFile);
    vaLineInco := '*** FINALIZA VALIDACION CUENTAS CONTABLES';
    utl_file.put_line(vFile, vaLineInco);
    */

    utl_file.put_line(vFile, 'Finaliza Validaciones');
    utl_file.fclose(vFile);

    sbAsunto := 'Interfaz control reintegro: '||to_char(idtFechaMovimiento,'DD-MON-YYYY');
    sbMensaje := 'Reporte de validacion de la interfaz de control reintegro. Fecha: '||
            to_char(idtFechaMovimiento,'DD-MON-YYYY')||' Tipo Comprobante: '||nuTipoComprobante||
            chr(10)||'Usuario: '||ut_session.getuser||' Terminal:'||ut_session.getterminal;

    LDC_ManagementEmailFNB.PROENVIARCHIVO (sender,
                           sbE_MAIL,
                           sbAsunto ,
                           sbFile ,
                           'text/plain',
                           sbMensaje,
                           sbPath,
       			     	   nuErrorCode);

    RETURN(0);
  EXCEPTION
    WHEN OTHERS THEN
      vaLineInco := 'ERROR EN LA VALIDACION : ' || nuTipoComprobante || '. Error: ' || SQLERRM;
      utl_file.put_line(vFile, vaLineInco);
      utl_file.fclose(vFile);
      RETURN(-1);
  END ValidaInterfazControlReinteRO;

PROCEDURE ExecuteAll (sbSentencia varchar2)
IS
BEGIN
    execute immediate sbSentencia;
    dbms_output.put_Line('Finaliza Ok');
exception
    when others then
    dbms_output.put_Line(sqlerrm);
end ExecuteAll;


--******************************************************************************************************
PROCEDURE proGenMailInterfaz (inuTrama       number,
                              isbtipointe    varchar2,
                              isbRemite      VARCHAR2,
                              nuError      out number) IS


cursor cuCorreos is
 select distinct(correo)
  from LDCI_CORTINTE b, IC_TICOCONT a
 where a.tccocodi = b.tipointe
   and substr(a.tccodesc,1,2) = isbtipointe
   and activo = 'S';

begin


  rcDocumentos := ldci_ProcesosInterfazSap.NumeroDocumentos(inuTrama);

  sbAsunto := 'Notificacion de Envio de Interfaz Contable ' || rcDocumentos.sbTipoInterfaz ||
              'Trama ' || inuTrama;

  sbMensaje := 'Se notifica que se ha enviado la interfaz contable ' || rcDocumentos.sbTipoInterfaz ||
               ' del dia ' || to_char(trunc(rcDocumentos.dtFechaConta),'dd/mm/yyyy') || chr(13) ||
               'Con trama numero ' || inuTrama || chr(13) ||
               'Con un total de ' || rcDocumentos.nuDocumentos || ' documentos' || chr(13) ||
               'Total Debito ' || rcDocumentos.nuValorDb || chr(13) ||
               'Total Credito ' || rcDocumentos.nuValorCr;

  for rg in cuCorreos loop
    ldci_ProcesosInterfazSap.PROENVIARCHIVO (isbRemite,
                                             rg.correo, -- sbE_MAIL,
                                             sbAsunto ,
                                             'text/plain',
                                             sbMensaje,
                                             nuErrorCode);
  end loop;

   nuError := 0;

EXCEPTION
   when others then
        Rollback;
        nuError := -1;
        Errors.setError;
      -----------  Errors.getError(nuError,sbError);
     --------   DBMS_OUTPUT.PUT_LINE('ERROR : [' || nuError || '] ->> [' || Substr(sbError,1,210) || ']');
END proGenMailInterfaz;

--******************************************************************************************************
PROCEDURE proGenMailErrorInterfaz (isbOrError       varchar2,
                                   isbtipointe      varchar2,
                                   idtfecini        date,
                                   idtfecfin        date ,
                                   inuano           number,
                                   inumes           number,
                                   isbsender        varchar2,
                                   nuError          out number) IS

nuErrorCode  number;

cursor cuCorreos is
 select distinct(correo)
  from LDCI_CORTINTE b, IC_TICOCONT a
 where a.tccocodi = b.tipointe
   and substr(a.tccodesc,1,2) = isbtipointe
   and activo = 'S';

begin

  if isbOrError = 'F' then
    sbAsunto := 'Notificacion de Error en Envio de Interfaz Contable ' || isbtipointe ||
              ' para el periodo del ' || to_char(trunc(idtfecini),'dd/mm/yyyy') || ' al ' ||
              to_char(trunc(idtfecfin),'dd/mm/yyyy');

     sbMensaje := 'Se presento un error en el envio de la interfaz contable ' || isbtipointe ||
                ' para el periodo del ' || to_char(trunc(idtfecini),'dd/mm/yyyy') || ' al ' ||
                to_char(trunc(idtfecfin),'dd/mm/yyyy') || chr(13) ||  chr(13) || 'Ver tabla LDCI_LOGSPROC';

  else
    sbAsunto := 'Notificacion de Error en Envio de Interfaz Contable ' || isbtipointe ||
              ' para el A?o ' || inuano || ' Mes ' || inumes;

    sbMensaje := 'Se presento un error en el envio de la interfaz contable ' || isbtipointe ||
                ' para el A?o ' || inuano || ' Mes ' || inumes || chr(13) ||  chr(13) || 'Ver tabla LDCI_LOGSPROC';

  end if;



  for rg in cuCorreos loop
    ldci_ProcesosInterfazSap.PROENVIARCHIVO (isbsender,
                                             rg.correo, -- sbE_MAIL,
                                             sbAsunto ,
                                             'text/plain',
                                             sbMensaje,
                                             nuErrorCode);
  end loop;

  nuError := 0;

EXCEPTION
   when others then
        nuError := -1;
        Rollback;
        Errors.setError;
      ----  Errors.getError(nuError,sbError);
      ----  DBMS_OUTPUT.PUT_LINE('ERROR : [' || nuError || '] ->> [' || Substr(sbError,1,210) || ']');
END proGenMailErrorInterfaz;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : PROENVIARCHIVO
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Envio de correo

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/

PROCEDURE PROENVIARCHIVO(sbRemite      VARCHAR2,
                        sbRecibe      VARCHAR2,
                        sbAsunto      VARCHAR2 ,
                        sbTipoArchivo VARCHAR2 ,
                        sbMens        VARCHAR2 DEFAULT NULL,
                        nuError      out number)IS

    conn utl_smtp.connection;

AttachmentFile  VARCHAR2(4000);

sbError     VARCHAR2(2000) := Null;
sbHost      VARCHAR2(2000) := Null;


begin
   IF sbRemite IS NULL THEN
      raise_application_error(-20501,'El correo origen no puede ser nulo. '||SQLERRM);
   ELSIF sbRecibe IS NULL THEN
      raise_application_error(-20501,'El correo destino no puede ser nulo.'||SQLERRM);
   ELSIF sbAsunto IS NULL THEN
      raise_application_error(-20501,'El asunto no puede ser nulo.'||SQLERRM);
   ELSIF sbTipoArchivo IS NULL THEN
      raise_application_error(-20501,'El tipo de archivo no puede ser nulo.'||SQLERRM);
   ELSIF sbMens IS NULL THEN
      raise_application_error(-20501,'El mensaje no puede ser nulo.'||SQLERRM);
  END IF;

   DBMS_OUTPUT.PUT_LINE('INICIO CORREO');
   /*DBMS_OUTPUT.PUT_LINE('sbRemite:' || sbRemite);
   DBMS_OUTPUT.PUT_LINE('sbRecibe:' || sbRecibe);
   DBMS_OUTPUT.PUT_LINE('sbAsunto:' || sbAsunto);
   DBMS_OUTPUT.PUT_LINE('sbMensaje:' || sbMens);*/

   sbHost := GE_BOParameter.fsbGet('HOST_MAIL');

   UT_Mail.setTo(sbRecibe);                   -- para (real)
   UT_Mail.setFrom(sbRemite);     -- de    (ficticio)
   UT_Mail.setHost(sbHost);
   UT_Mail.setSubject(sbAsunto);     -- asunto

   UT_Mail.setMessage(sbMens);
   UT_Mail.sendMessage(nuError, sbError);
   UT_Java.ValidateError(nuError, sbError);

   DBMS_OUTPUT.PUT_LINE('FINAL CORREO');
EXCEPTION
   when others then
        Rollback;
        Errors.setError;
        Errors.getError(nuError,sbError);
        DBMS_OUTPUT.PUT_LINE('ERROR : [' || nuError || '] ->> [' || Substr(sbError,1,210) || ']');
END PROENVIARCHIVO;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : ActualizaFechaTrama
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Actualiza fecha de tramas

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/
PROCEDURE ActualizaFechaTrama
IS
    sbCOD_INTERFAZLDC ge_boInstanceControl.stysbValue;
    sbFECHCONT ge_boInstanceControl.stysbValue;

    cnuNULL_ATTRIBUTE constant number := 2126;
    nuInterfaz number;
    dtFecha date;

BEGIN
    sbCOD_INTERFAZLDC := ge_boInstanceControl.fsbGetFieldValue ('LDCI_ENCAINTESAP', 'COD_INTERFAZLDC');
    sbFECHCONT := ge_boInstanceControl.fsbGetFieldValue ('LDCI_ENCAINTESAP', 'FECHCONT');

    ------------------------------------------------
    -- User code
    ------------------------------------------------

    if (sbCOD_INTERFAZLDC is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Codigo de Trama');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbFECHCONT is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Fecha para Actualizar');
        raise ex.CONTROLLED_ERROR;
    end if;

    nuInterfaz := to_number(sbCOD_INTERFAZLDC);
    dtFecha := trunc(to_Date(sbFECHCONT));

    UPDATE open.ldci_encaintesap SET fechcont = dtFecha WHERE cod_interfazldc = nuInterfaz;
    UPDATE open.ldci_detaintesap SET fechbase = dtFecha WHERE cod_interfazldc = nuInterfaz;

    commit;

EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        errors.seterror;
        raise ex.controlled_error;
end ActualizaFechaTrama;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : ReporteRecaudoHERC
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Reporte diario de recaudos

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/
PROCEDURE ReporteRecaudoHERC (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                                dtFechaRegistro date)
IS
/*
4_Reporte_Detallado_diario_rc_cupon.sql
*/
    dtFechaIni date;
    dtFechaFin date;
    rcDocumentos tyrcDocumentos;

    CURSOR cuDatosdiario (dtInicial date, dtFinal date) IS
    SELECT NVL(open.ldci_pkinterfazsap.fvagetcebenew(a.moviubg3, a.movicate), 0) cebe,
           a.movifeco FechaContable,
           TO_CHAR(a.movibanc) cod_entidad,
           d.bancnomb desc_entidad,
           a.movinibr nit_entidad,
           TO_CHAR(a.movisuba) cod_puntopago,
           a.movicupo cupon,
           (SELECT cupotipo FROM open.cupon e WHERE e.cuponume = a.movicupo) tipo_cupon,
           open.pktblcupon.fnugetcuposusc(a.movicupo) contrato,
           replace(REPLACE((SELECT subscriber_name || ' ' || subs_last_name descr
                     FROM open.ge_subscriber, open.suscripc
                    WHERE susccodi = open.pktblcupon.fnugetcuposusc(a.movicupo)
                      AND subscriber_id = suscclie),
                   CHR(13),
                   NULL),';','N') desc_suscripc,
           c.clcocodi cod_clasificador,
           c.clcodesc desc_clasificador,
           a.moviconc concepto,
           open.pktblconcepto.fsbgetconcdesc(a.moviconc) desc_concepto,
           a.movifetr fecha_pago,
           SUM(DECODE(a.movisign, 'D', a.movivalo, -a.movivalo)) total,
           a.movitimo tipo_movimiento,
           e.timodesc descripcion_movimiento
      FROM open.ic_movimien a,
           open.concepto    b,
           open.ic_clascont c,
           open.banco       d,
           open.ic_tipomovi e
     WHERE (a.movitido, a.movinudo, a.movifeco) IN
           (SELECT dogetido, dogenudo, dogefemo
              FROM open.ic_docugene
             WHERE dogetido = 72
               AND dogefemo BETWEEN dtInicial AND dtFinal)
       AND a.movitimo IN (23, 25)
       AND a.movibanc = d.banccodi
       AND a.moviconc = b.conccodi
       AND b.concclco = c.clcocodi(+)
    --AND a.movibanc = 119
      AND a.movitimo = e.timocodi
     GROUP BY a.movifeco,
              a.movibanc,
              d.bancnomb,
              a.movisuba,
              c.clcocodi,
              c.clcodesc,
              a.movicupo,
              a.moviubg3,
              a.movicate,
              a.movinibr,
              a.moviconc,
              a.movifetr,
              a.movitimo,
              e.timodesc;

-----------------------------------------------------------------------------

    CURSOR cuDatosRc_Cupon (dtInicial date, dtFinal date) IS
SELECT fechacreacion,
       cod_entidad,
       desc_entidad,
       cod_sucuban,
       cod_clasificador,
       des_clasificador,
       cuenta,
       cupon,
       SUM(valor) valor
       ,ecrccoco Comprobante
  FROM (SELECT c.ecrcfech fechacreacion,
               open.ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|') cod_entidad,
               open.pktblbanco.fsbgetbancnomb(open.ldci_pkinterfazsap.fvagetdata(7, dcrcinad, '|')) desc_entidad,
               open.ldci_pkinterfazsap.fvagetdata(29, dcrcinad, '|') cod_sucuban,
               h.clcocodi cod_clasificador,
               h.clcodesc des_clasificador,
               dcrccuco cuenta,
               open.ldci_pkinterfazsap.fvagetdata(37, dcrcinad, '|') cupon,
               DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) valor
               ,ecrccoco
          FROM open.ic_decoreco,
               (SELECT *
                  FROM open.ic_encoreco
                 WHERE ecrccoge IN (SELECT cogecons
                                      FROM open.ic_compgene
                                     WHERE cogecoco IN (SELECT cococodi
                                                          FROM open.ic_compcont
                                                         WHERE cocotcco = 2)
                                       AND cogefein >= dtInicial
                                       AND cogefefi <= dtFinal)) c,
               open.ic_clascore p,
               open.ic_clascont h
         WHERE dcrcecrc = c.ecrccons
           AND dcrcclcr = p.clcrcons
           AND p.clcrclco = h.clcocodi)
 GROUP BY fechacreacion,
          cod_entidad,
          desc_entidad,
          cod_sucuban,
          cod_clasificador,
          des_clasificador,
          cuenta,
          cupon
          ,ecrccoco
 ORDER BY cod_entidad, cod_sucuban, cod_clasificador;

BEGIN

    dtFechaIni := trunc(dtFechaRegistro);
    dtFechaFin := to_date(to_char(to_date(dtFechaRegistro),'DD')||to_char(to_date(dtFechaRegistro),'MM')||'-'||to_char(to_date(dtFechaRegistro),'YYYY')||'23:59:59');
    sbFile := 'Recaudo_HE_'||to_char(dtFechaIni,'MONDD_YY')||'.csv';

    vFile := UTL_FILE.FOPEN( sbPath, sbFile, 'W', cnuMAXLENGTH );

    rcDocumentos := NumeroDocumentos (nucod_interfazldc);

    sbLineaDeta := '[NUM_INTERFAZ: '||nucod_interfazldc||'] [CANTIDAD DOCUMENTOS: '||
                     rcDocumentos.nuDocumentos ||'] FECHA INICIO: '||dtFechaIni||' - FECHA FIN: '||
                     dtFechaFin;
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    sbLineaDeta := '"CEBE";"FECHA_CONTABLE";"COD_ENTIDAD";"DESC_ENTIDAD";"NIT_ENTIDAD";"COD_PUNTOPAGO";"CUPON";"TIPO_CUPON";"CONTRATO";"DESC_SUSCRIPC";"COD_CLASIFICADOR";"DESC_CLASIFICADOR";"CONCEPTO";"DESC_CONCEPTO";"FECHA_PAGO";"TOTAL";"TIPO_MOVIMIENTO";"DESCRIPCION_MOVIMIENTO"';
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    dbms_output.put_Line(dtFechaIni||'   '||dtFechaFin);
    for rcDatos in cuDatosdiario (dtFechaIni, dtFechaFin )  loop
    	sbLineaDeta :=
                        rcDatos.cebe||csbSeparador||
                        rcDatos.FechaContable||csbSeparador||
                        rcDatos.cod_entidad||csbSeparador||
                        rcDatos.desc_entidad||csbSeparador||
                        rcDatos.nit_entidad||csbSeparador||
                        rcDatos.cod_puntopago||csbSeparador||
                        rcDatos.cupon||csbSeparador||
                        rcDatos.tipo_cupon||csbSeparador||
                        rcDatos.contrato||csbSeparador||
                        rcDatos.desc_suscripc||csbSeparador||
                        rcDatos.cod_clasificador||csbSeparador||
                        rcDatos.desc_clasificador||csbSeparador||
                        rcDatos.concepto||csbSeparador||
                        rcDatos.desc_concepto||csbSeparador||
                        rcDatos.fecha_pago||csbSeparador||
                        rcDatos.total||csbSeparador||
                        rcDatos.tipo_movimiento||csbSeparador||
                        rcDatos.descripcion_movimiento
                        ;
        UTL_FILE.PUT_LINE( vFile, sbLineaDeta );
    END loop;
    dtFechaIni := dtFechaIni +1;

    -- Cierra archivo de impresion
    UTL_FILE.FCLOSE( vFile );

--------------------------------- RC CUPON -------------------------------------

    dtFechaIni := trunc(dtFechaRegistro);
    dtFechaFin := to_date(to_char(to_date(dtFechaRegistro),'DD')||to_char(to_date(dtFechaRegistro),'MM')||'-'||to_char(to_date(dtFechaRegistro),'YYYY')||'23:59:59');
    sbFile := 'Recaudo_RC_'||to_char(dtFechaIni,'MONDD_YY')||'.csv';

    vFile := UTL_FILE.FOPEN( sbPath, sbFile, 'W', cnuMAXLENGTH );


    sbLineaDeta := '[NUM_INTERFAZ: '||nucod_interfazldc||'] FECHA INICIO: '||dtFechaIni||' - FECHA FIN: '|| dtFechaFin;
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    sbLineaDeta := '"FECHACREACION";"COD_ENTIDAD";"DESC_ENTIDAD";"COD_SUCUBAN";"COD_CLASIFICADOR";"DES_CLASIFICADOR";"CUENTA";"CUPON";"VALOR";"COMPROBANTE"';
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    dbms_output.put_Line(dtFechaIni||'   '||dtFechaFin);
    for rcDatos in cuDatosRc_Cupon (dtFechaIni, dtFechaFin )  loop
    	sbLineaDeta :=

                        rcDatos.fechacreacion||csbSeparador||
                        rcDatos.cod_entidad||csbSeparador||
                        rcDatos.desc_entidad||csbSeparador||
                        rcDatos.cod_sucuban||csbSeparador||
                        rcDatos.cod_clasificador||csbSeparador||
                        rcDatos.des_clasificador||csbSeparador||
                        rcDatos.cuenta||csbSeparador||
                        rcDatos.cupon||csbSeparador||
                        rcDatos.valor||csbSeparador||
                        rcDatos.Comprobante;

        UTL_FILE.PUT_LINE( vFile, sbLineaDeta );
    END loop;
    dtFechaIni := dtFechaIni +1;

    -- Cierra archivo de impresion
    UTL_FILE.FCLOSE( vFile );


EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        errors.seterror;
        raise ex.controlled_error;
END ReporteRecaudoHERC;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : ReporteControlReinteHERC
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Reporte diario de contro reintegro hechos y registros

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      		Fecha       Descripcion
Oscar Restrepo		10/12/2014	Aranda 5656 : Modificacion para permitir tipo de movimiento de Cheque devuelto
************************************************************************/

PROCEDURE ReporteControlReinteHERC (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                                    dtFechaRegistro date)
IS
    dtFechaIni date;
    dtFechaFin date;
    rcDocumentos tyrcDocumentos;

    CURSOR cuDatosHechos (dtInicial date, dtFinal date) IS
        SELECT a.MOVIFECO FechaContabilizacion,
               a.movinudo DocmentoSoporte,
               a.movifetr FechaTransaccion,
               a.MOVITIMO || '-' || g.timodesc TipoMovmiento,
               a.MOVISIGN Signo,
               a.MOVIVALO Valor,
               a.MOVIBACO EntidadConciliacion,
               d.bancnomb Desc_Entidad,
               a.movicuba Cod_Cuenta,
               e.CUBANUCB CuentaBancaria,
               a.movinibr NitBancoTransaccion,
               a.movitihe TipoHecho
          FROM open.ic_movimien a, open.banco d, open.tipoenre f, open.cuenbanc e, open.ic_tipomovi g
         WHERE MOVITIDO = 74
           --AND MOVITIMO IN (38,65,66) --Aranda 5656
					 AND ((MOVITIMO IN (38, 65)) OR (MOVITIMO = 66 AND MOVITDSR  =4)) --Aranda 5656
           AND a.MOVIFECO >= dtInicial
           AND a.MOVIFECO <= dtFinal
           AND a.MOVIBACO = d.banccodi
           AND a.movitibr = f.tiercodi
           AND a.movicuba = e.cubacodi
           AND g.timocodi = a.movitimo;

------------------------------------------------------------------------
    CURSOR cuDatosRegistros (dtInicial date, dtFinal date) IS
        SELECT z.TipoInterfaz,
           z.cod_tipoentidad,
           z.FechaContabilizacion,
           z.FechaTransaccion,
           x.tierdesc Desc_TipoEntidad,
           z.Cod_EntidadConciliacion,
           y.bancnomb Desc_Entidad,
           z.Nit_Bancorecauda,
           z.Nit_BancoTransaccion,
           Cod_BancoTransaccion,
           (SELECT bancnomb FROM open.banco WHERE banccodi = Cod_BancoTransaccion) Desc_BancoTransaccion,
           z.Conciliacion,
           z.CuentaContable,
           Z.SIGNO,
           NVL(SUM(DECODE(Z.SIGNO, 'D', VALOR)), 0) DEBITO,
           NVL(SUM(DECODE(Z.SIGNO, 'C', -VALOR)), 0) CREDITO,
           DocumentoSoporte
        FROM (SELECT e.tipointerfaz TipoInterfaz,
                   c.ecrcfech FechaContabilizacion,
                   open.ldci_pkinterfazsap.fvaGetData(14, d.dcrcinad, '|') DocumentoSoporte,
                   open.ldci_pkinterfazsap.fvaGetData(30, dcrcinad, '|') FechaTransaccion,
                   d.dcrcsign SIGNO,
                   d.dcrcvalo VALOR,
                   open.ldci_pkinterfazsap.fvaGetData(35, d.dcrcinad, '|') Cod_TipoEntidad,
                   open.ldci_pkinterfazsap.fvaGetData(45, d.dcrcinad, '|') Cod_EntidadConciliacion,
                   open.ldci_pkinterfazsap.fvaGetData(34, d.dcrcinad, '|') Nit_Bancorecauda,
                   open.ldci_pkinterfazsap.fvaGetData(36, d.dcrcinad, '|') Nit_BancoTransaccion,
                   open.ldci_pkinterfazsap.fvaGetData(8, d.dcrcinad, '|') Cod_BancoTransaccion,
                   open.ldci_pkinterfazsap.fvaGetData(13, d.dcrcinad, '|') Conciliacion,
                   DCRCCUCO CuentaContable
              FROM open.ic_ticocont       a,
                   open.ic_compcont       b,
                   open.ic_encoreco       c,
                   open.ic_decoreco       d,
                   open.ldci_tipointerfaz e,
                   open.ic_confreco       f
             WHERE c.ecrcfech BETWEEN dtInicial AND dtFinal
               AND a.TCCOCODI = b.COCOTCCO
               AND a.TCCOCODI = 8
               AND b.COCOCODI = c.ECRCCOCO
               AND c.ecrccons = d.dcrcecrc
               AND b.COCOCODI = e.cod_comprobante
               AND d.dcrccorc = f.corccons
            ) z,
           open.tipoenre x,
           open.banco y
        WHERE Cod_TipoEntidad = x.tiercodi
        AND z.Cod_EntidadConciliacion = y.banccodi
        GROUP BY z.TipoInterfaz,
              z.cod_tipoentidad,
              x.tierdesc,
              z.Cod_EntidadConciliacion,
              z.Cod_BancoTransaccion,
              y.bancnomb,
              z.Nit_Bancorecauda,
              z.Nit_BancoTransaccion,
              z.Conciliacion,
              z.CuentaContable,
              Z.SIGNO,
              z.FechaTransaccion,
              z.FechaContabilizacion,
              DocumentoSoporte;

BEGIN
    ------------------------------------ HECHOS ECONOMICOS -------------------------
    dtFechaIni := trunc(dtFechaRegistro);
    dtFechaFin := to_date(to_char(to_date(dtFechaRegistro),'DD')||to_char(to_date(dtFechaRegistro),'MM')||'-'||to_char(to_date(dtFechaRegistro),'YYYY')||'23:59:59');
    sbFile := 'ControlReinte_HE_'||to_char(dtFechaRegistro,'MONDD_YY')||'.csv';
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'RutaRepoRecaudo', sbPath, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'NombreArchValida', sbFile, sbErrorMessage);


    vFile := UTL_FILE.FOPEN( sbPath, sbFile, 'W', cnuMAXLENGTH );

    rcDocumentos := NumeroDocumentos (nucod_interfazldc);

    sbLineaDeta := '[NUM_INTERFAZ: '||nucod_interfazldc||'] [CANTIDAD DOCUMENTOS: '||
                     rcDocumentos.nuDocumentos ||'] FECHA INICIO: '||dtFechaIni||' - FECHA FIN: '||
                     dtFechaFin;
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    sbLineaDeta := '"FECHACONTABILIZACION";"DOCMENTOSOPORTE";"FECHATRANSACCION";"TIPOMOVMIENTO";"SIGNO";"VALOR";"ENTIDADCONCILIACION";"DESC_ENTIDAD";"COD_CUENTA";"CUENTABANCARIA";"NITBANCOTRANSACCION";"TIPOHECHO"';
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    dbms_output.put_Line(dtFechaIni||'   '||dtFechaFin);
    for rcDatos in cuDatosHechos (dtFechaIni, dtFechaFin )  loop
    	sbLineaDeta :=
                    rcDatos.FechaContabilizacion||csbSeparador||
                    rcDatos.DocmentoSoporte||csbSeparador||
                    rcDatos.FechaTransaccion||csbSeparador||
                    rcDatos.TipoMovmiento||csbSeparador||
                    rcDatos.Signo||csbSeparador||
                    rcDatos.Valor||csbSeparador||
                    rcDatos.EntidadConciliacion||csbSeparador||
                    rcDatos.Desc_Entidad||csbSeparador||
                    rcDatos.Cod_Cuenta||csbSeparador||
                    rcDatos.CuentaBancaria||csbSeparador||
                    rcDatos.NitBancoTransaccion||csbSeparador||
                    rcDatos.TipoHecho;

        UTL_FILE.PUT_LINE( vFile, sbLineaDeta );
        --dbms_output.put_Line(sbLineaDeta);
    END loop;

    UTL_FILE.FCLOSE( vFile );

    ---------------------------- REGISTROS CONTABLES ------------------------------
    dtFechaIni := dtFechaRegistro;
    dtFechaFin := to_date(to_char(to_date(dtFechaRegistro),'DD')||to_char(to_date(dtFechaRegistro),'MM')||'-'||to_char(to_date(dtFechaRegistro),'YYYY')||'23:59:59');
    sbFile := 'ControlReinte_RC_'||to_char(dtFechaIni,'MONDD_YY')||'.csv';

    vFile := UTL_FILE.FOPEN( sbPath, sbFile, 'W', cnuMAXLENGTH );

    sbLineaDeta := '[NUM_INTERFAZ: '||nucod_interfazldc||'] FECHA INICIO: '||dtFechaIni||' - FECHA FIN: '|| dtFechaFin;
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    sbLineaDeta := '"TIPOINTERFAZ";"COD_TIPOENTIDAD";"FECHACONTABILIZACION";"FECHATRANSACCION";"DESC_TIPOENTIDAD";"COD_ENTIDADCONCILIACION";"DESC_ENTIDAD";"NIT_BANCORECAUDA";"NIT_BANCOTRANSACCION";"COD_BANCOTRANSACCION";"DESC_BANCOTRANSACCION";"CONCILIACION";"CUENTACONTABLE";"SIGNO";"DEBITO";"CREDITO";"DOCUMENTOSOPORTE"';
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );

    dbms_output.put_Line(dtFechaIni||'   '||dtFechaFin);
    for rcDatos in cuDatosRegistros (dtFechaIni, dtFechaFin )  loop

    	sbLineaDeta :=
                rcDatos.TipoInterfaz||csbSeparador||
                rcDatos.cod_tipoentidad||csbSeparador||
                rcDatos.FechaContabilizacion||csbSeparador||
                rcDatos.FechaTransaccion||csbSeparador||
                rcDatos.Desc_TipoEntidad||csbSeparador||
                rcDatos.Cod_EntidadConciliacion||csbSeparador||
                rcDatos.Desc_Entidad||csbSeparador||
                rcDatos.Nit_Bancorecauda||csbSeparador||
                rcDatos.Nit_BancoTransaccion||csbSeparador||
                rcDatos.Cod_BancoTransaccion||csbSeparador||
                rcDatos.Desc_BancoTransaccion||csbSeparador||
                rcDatos.Conciliacion||csbSeparador||
                rcDatos.CuentaContable||csbSeparador||
                rcDatos.SIGNO||csbSeparador||
                rcDatos.DEBITO||csbSeparador||
                rcDatos.CREDITO||csbSeparador||
                rcDatos.DocumentoSoporte;

        UTL_FILE.PUT_LINE( vFile, sbLineaDeta );
        --dbms_output.put_Line(sbLineaDeta);
    END loop;
    -- Cierra archivo de impresion
    UTL_FILE.FCLOSE( vFile );

EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        errors.seterror;
        raise ex.controlled_error;
END ReporteControlReinteHERC;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : ReporteTramaRecaudo
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Reporte tramas de recaudos

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/
PROCEDURE ReporteTramaRecaudo
                            (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                            dtFechaRegistro date
                            )
IS
    CURSOR cuTrama (nuTrama number) IS
        SELECT *
          FROM OPEN.LDCI_DETAINTESAP
         WHERE cod_interfazldc = nuTrama;
BEGIN

    sbFile := 'TRAMA_Recaudo_'||to_char(dtFechaRegistro,'MON_DD')||'_'||nucod_interfazldc||'.csv';

    vFile := UTL_FILE.FOPEN( sbPath, sbFile, 'W', cnuMAXLENGTH );

    sbLineaDeta := '"COD_INTERFAZLDC";"NUM_DOCUMENTOSAP";"CLAVCONT";"CLASECTA";"INDICCME";"IMPOMTRX";"IMPOMSOC";"INDICIVA";"CONDPAGO";"FECHBASE";"REFFACTR";"BASEIMPT";"CENTROCO";"ORDENINT";"CANTIDAD";"ASIGNACN";"TXTPOSCN";"CENTROBE";"SEGMENTO";"OBJCOSTO";"CLAVREF1";"CLAVREF2";"CLAVREF3";"SOCIEDGL";"MATERIAL";"TIPORETC";"INDRETEC";"BASERETC";"FECHVALOR";"CTADIV";"COD_CENTROBENEF";"COD_CLASIFCONTA";"IDENTIFICADOR"';
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );


    for rcDatos in cuTrama (nucod_interfazldc)  loop
        sbLineaDeta :=
                rcDatos.COD_INTERFAZLDC||csbSeparador||
                rcDatos.NUM_DOCUMENTOSAP||csbSeparador||
                rcDatos.CLAVCONT||csbSeparador||
                rcDatos.CLASECTA||csbSeparador||
                rcDatos.INDICCME||csbSeparador||
                rcDatos.IMPOMTRX||csbSeparador||
                rcDatos.IMPOMSOC||csbSeparador||
                rcDatos.INDICIVA||csbSeparador||
                rcDatos.CONDPAGO||csbSeparador||
                rcDatos.FECHBASE||csbSeparador||
                rcDatos.REFFACTR||csbSeparador||
                rcDatos.BASEIMPT||csbSeparador||
                rcDatos.CENTROCO||csbSeparador||
                rcDatos.ORDENINT||csbSeparador||
                rcDatos.CANTIDAD||csbSeparador||
                rcDatos.ASIGNACN||csbSeparador||
                rcDatos.TXTPOSCN||csbSeparador||
                rcDatos.CENTROBE||csbSeparador||
                rcDatos.SEGMENTO||csbSeparador||
                rcDatos.OBJCOSTO||csbSeparador||
                rcDatos.CLAVREF1||csbSeparador||
                rcDatos.CLAVREF2||csbSeparador||
                rcDatos.CLAVREF3||csbSeparador||
                rcDatos.SOCIEDGL||csbSeparador||
                rcDatos.MATERIAL||csbSeparador||
                rcDatos.TIPORETC||csbSeparador||
                rcDatos.INDRETEC||csbSeparador||
                rcDatos.BASERETC||csbSeparador||
                rcDatos.FECHVALOR||csbSeparador||
                rcDatos.CTADIV||csbSeparador||
                rcDatos.COD_CENTROBENEF||csbSeparador||
                rcDatos.COD_CLASIFCONTA||csbSeparador||
                rcDatos.IDENTIFICADOR;
        UTL_FILE.PUT_LINE( vFile, sbLineaDeta );
        --dbms_output.put_Line(sbLineaDeta);
    END loop;
    -- Cierra archivo de impresion
    UTL_FILE.FCLOSE( vFile );

EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        errors.seterror;
        raise ex.controlled_error;
END ReporteTramaRecaudo;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : ReporteTramaReintegro
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Reporte tramas de control reintegro

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/
PROCEDURE ReporteTramaReintegro
                                (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type,
                                dtFechaRegistro date
                                )
IS
    CURSOR cuTrama (nuTrama number) IS
        SELECT *
          FROM OPEN.LDCI_DETAINTESAP
         WHERE cod_interfazldc = nuTrama;

    type tyTrama IS TABLE OF number INDEX BY BINARY_INTEGER;
    tbTrama tyTrama;

BEGIN
    sbFile := 'TRAMA_ControlReinte_'||to_char(dtFechaRegistro,'MON_DD')||'_'||nucod_interfazldc||'.csv';

    vFile := UTL_FILE.FOPEN( sbPath, sbFile, 'W', cnuMAXLENGTH );

    sbLineaDeta := '"COD_INTERFAZLDC";"NUM_DOCUMENTOSAP";"CLAVCONT";"CLASECTA";"INDICCME";"IMPOMTRX";"IMPOMSOC";"INDICIVA";"CONDPAGO";"FECHBASE";"REFFACTR";"BASEIMPT";"CENTROCO";"ORDENINT";"CANTIDAD";"ASIGNACN";"TXTPOSCN";"CENTROBE";"SEGMENTO";"OBJCOSTO";"CLAVREF1";"CLAVREF2";"CLAVREF3";"SOCIEDGL";"MATERIAL";"TIPORETC";"INDRETEC";"BASERETC";"FECHVALOR";"CTADIV";"COD_CENTROBENEF";"COD_CLASIFCONTA";"IDENTIFICADOR"';
    UTL_FILE.PUT_LINE( vFile, sbLineaDeta );


    for rcDatos in cuTrama (nucod_interfazldc)  loop
    	sbLineaDeta :=
                rcDatos.COD_INTERFAZLDC||csbSeparador||
                rcDatos.NUM_DOCUMENTOSAP||csbSeparador||
                rcDatos.CLAVCONT||csbSeparador||
                rcDatos.CLASECTA||csbSeparador||
                rcDatos.INDICCME||csbSeparador||
                rcDatos.IMPOMTRX||csbSeparador||
                rcDatos.IMPOMSOC||csbSeparador||
                rcDatos.INDICIVA||csbSeparador||
                rcDatos.CONDPAGO||csbSeparador||
                rcDatos.FECHBASE||csbSeparador||
                rcDatos.REFFACTR||csbSeparador||
                rcDatos.BASEIMPT||csbSeparador||
                rcDatos.CENTROCO||csbSeparador||
                rcDatos.ORDENINT||csbSeparador||
                rcDatos.CANTIDAD||csbSeparador||
                rcDatos.ASIGNACN||csbSeparador||
                rcDatos.TXTPOSCN||csbSeparador||
                rcDatos.CENTROBE||csbSeparador||
                rcDatos.SEGMENTO||csbSeparador||
                rcDatos.OBJCOSTO||csbSeparador||
                rcDatos.CLAVREF1||csbSeparador||
                rcDatos.CLAVREF2||csbSeparador||
                rcDatos.CLAVREF3||csbSeparador||
                rcDatos.SOCIEDGL||csbSeparador||
                rcDatos.MATERIAL||csbSeparador||
                rcDatos.TIPORETC||csbSeparador||
                rcDatos.INDRETEC||csbSeparador||
                rcDatos.BASERETC||csbSeparador||
                rcDatos.FECHVALOR||csbSeparador||
                rcDatos.CTADIV||csbSeparador||
                rcDatos.COD_CENTROBENEF||csbSeparador||
                rcDatos.COD_CLASIFCONTA||csbSeparador||
                rcDatos.IDENTIFICADOR;
        UTL_FILE.PUT_LINE( vFile, sbLineaDeta );
        --dbms_output.put_Line(sbLineaDeta);
    END loop;
    -- Cierra archivo de impresion
    UTL_FILE.FCLOSE( vFile );

EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        errors.seterror;
        raise ex.controlled_error;
END ReporteTramaReintegro;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : fnuValidaHR
  AUTOR       : Arquitecsoft S.A.S - Heiber Barco
  FECHA       : 27-11-2014
  DESCRIPCION : Aranda 3550: Funcion que valida si existen Hechos Economicos y Registros Contables.
                Valida si existen diferencias entre Hechos Economicos y Registros Contables a nivel
                general.
                Heiberb - 26-02-2015 Aranda 6227: Se Corrige la funcion que valida hechos vs registros
                para que tome los comprobantes que estan configurados con el libro.

  Parametros de Entrada

  - idfFechaMovimiento

  Parametros de Salida

  Historia de Modificaciones
  Autor      Fecha       Descripcion
  ************************************************************************/
FUNCTION fnuValidaHR(idtFechaMovimiento DATE,
                        nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)
  RETURN NUMBER

   IS

    --<<
    --Variables
    -->>
    nuExisteHechos    NUMBER := 0;
    nuExisteRegistros NUMBER := 0;
    vaCuentasBanco    VARCHAR2(2000);
    vaCuentaCartera   VARCHAR2(2000);
    vaLineInco        VARCHAR2(10000);
    nuTotalDif        number;
    nuTotalDifRE        number;
    vaTolerancia      varchar2(2000);

--<<
--Heiberb - 26-02-2015 Aranda 6227:
--Se Corrige la funcion que valida hechos vs registros
--para que tome los comprobantes que estan configurados con el libro.
-->>
    cursor cuTotalDiferencias is
      SELECT abs(SUM(nvl(VALOR,0))) FROM (
      SELECT to_number(Cod_Entidad) banco,
             Desc_Entidad,
             Sucursal,
             FechaCreacion,
             Cod_Clasificador,
             Des_Clasificador,
             SUM(VALOR) VALOR,
             'RC' Tipo
        FROM (SELECT c.ecrcfech FechaCreacion,
                     open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|') Cod_Entidad,
                     open.pktblbanco.fsbgetbancnomb(open.ldci_pkinterfazsap.fvaGetData(7, dcrcinad, '|')) Desc_Entidad,
                     open.ldci_pkinterfazsap.fvaGetData(29, dcrcinad, '|') Sucursal,
                     h.clcocodi Cod_Clasificador,
                     h.clcodesc Des_Clasificador,
                     DCRCCUCO Cuenta,
                     DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo) VALOR
                FROM OPEN.IC_DECORECO,
                     (SELECT *
                        FROM OPEN.IC_ENCORECO
                       WHERE ECRCCOGE IN
                             (SELECT COGECONS
                                FROM OPEN.IC_COMPGENE
                               WHERE COGECOCO IN (SELECT COD_COMPROBANTE FROM open.LDCI_TIPOINTERFAZ WHERE TIPOINTERFAZ ='L2')
                                 AND COGEFEIN >= idtFechaMovimiento
                                 AND COGEFEFI <= idtFechaMovimiento)) C,
                     open.ic_clascore p,
                     open.ic_clascont h
               WHERE DCRCECRC = C.ECRCCONS
                 AND DCRCCLCR = p.clcrcons
                 AND p.clcrclco = h.clcocodi
                 AND (dcrccuco LIKE vaCuentaCartera OR dcrccuco LIKE vaCuentasBanco)
              )
       GROUP BY FechaCreacion,
                Cod_Entidad,
                Desc_Entidad,
                Sucursal,
                Cod_Clasificador,
                Des_Clasificador,
                Cuenta
      UNION
      SELECT movibanc banco, open.pktblbanco.fsbgetbancnomb(movibanc) Desc_Entidad,
             movisuba sucursal, movifeco fecha, clasificador,
             (SELECT clcodesc FROM open.ic_clascont WHERE clcocodi = clasificador) desc_clas,
             (sum(decode(movisign, 'C', movivalo*-1, movivalo))*-1) valor, 'HE' tipo
        FROM
      (
      SELECT movibanc, movisuba, movifeco, (SELECT concclco FROM open.concepto WHERE conccodi = moviconc) clasificador,
             movisign, movivalo
        FROM open.ic_movimien
       WHERE movitido = 72
         AND movifeco >= idtFechaMovimiento
         AND movifeco <= idtFechaMovimiento
         AND moviconc IS NOT NULL
      )
      GROUP BY movibanc, movisuba, movifeco, clasificador
      );

   cursor cuPagosResu is
   select abs(sum(valor)) valor  from (
    SELECT pagobanc banco, trunc(pagofegr) fecha, COUNT(1)cantidad, SUM(pagovapa) valor, 'P' tipo
      FROM open.pagos
     WHERE trunc(pagofegr) >= idtFechaMovimiento
       AND trunc(pagofegr) <= idtFechaMovimiento
     GROUP BY pagobanc, trunc(pagofegr)
    UNION
    SELECT pagobanc banco, paanfech fecha, COUNT(1) cantidad, (SUM(pagovapa)*-1) valor, 'PE' tipo
      FROM open.rc_pagoanul a, open.pagos p
     WHERE a.paancupo = p.pagocupo
       AND paanfech >= idtFechaMovimiento
       AND paanfech <= idtFechaMovimiento
     GROUP BY pagobanc, paanfech
    UNION
    SELECT rerebanc banco, rerefegr fecha, count(1) cantidad, (sum(rerevalo)*-1) valor, 'RR' Tipo
      FROM open.resureca
     WHERE rerefegr >= idtFechaMovimiento
       AND rerefegr <= idtFechaMovimiento
     GROUP BY rerebanc, rerefegr);


  BEGIN

    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentasBanco', vaCuentasBanco, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentaCartera', vaCuentaCartera, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'VALORHOLGURA', vaTolerancia, sbErrorMessage);

    nuTotalDif := 0;
    nuTotalDifRE := 0;

    OPEN  cuTotalDiferencias;
    FETCH cuTotalDiferencias into nuTotalDif;
    CLOSE cuTotalDiferencias;

    OPEN  cuPagosResu;
    FETCH cuPagosResu into nuTotalDifRE;
    CLOSE cuPagosResu;

    IF to_number(vaTolerancia) < nuTotalDifRE THEN

        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuSeqICLINUDO,'Interfaz ['||ldci_pkinterfazsap.nuSeqICLINUDO||'] Existe una diferencia considerable entre pagos y el resumen de recaudo: ['||ldci_pkinterfazsap.nuSeqICLINUDO||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.vaCODINTINTERFAZ,USER,USERENV('TERMINAL'));

        RETURN -1;

    else

        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuSeqICLINUDO,'Interfaz ['||ldci_pkinterfazsap.nuSeqICLINUDO||'] no hay diferencia en la interfaz o es tolerable : ['||ldci_pkinterfazsap.nuSeqICLINUDO||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.vaCODINTINTERFAZ,USER,USERENV('TERMINAL'));

    end if;

    IF to_number(vaTolerancia) < nuTotalDif THEN

        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuSeqICLINUDO,'Interfaz ['||ldci_pkinterfazsap.nuSeqICLINUDO||'] Existe una diferencia considerable en la interfaz: ['||ldci_pkinterfazsap.nuSeqICLINUDO||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.vaCODINTINTERFAZ,USER,USERENV('TERMINAL'));

        RETURN -1;

    else

        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuSeqICLINUDO,'Interfaz ['||ldci_pkinterfazsap.nuSeqICLINUDO||']  no hay diferencia en la interfaz o es tolerable: ['||ldci_pkinterfazsap.nuSeqICLINUDO||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.vaCODINTINTERFAZ,USER,USERENV('TERMINAL'));

    end if;

  RETURN(0);

  EXCEPTION
  WHEN OTHERS THEN
       ldci_pkinterfazsap.vaMensError :=  '[fnuValidaHR] - error por diferencias en la interfaz  '||SQLERRM||' '||DBMS_UTILITY.format_error_backtrace;
       ldci_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.vaCodintinterfaz,ldci_pkinterfazsap.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));
       RETURN(-1);

  END fnuValidaHR;

  /************************************************************************
  PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
  FUNCION     : fnuValidaHR
  AUTOR       : Horbart Tecnologies
  FECHA       : 18/09/2018
  DESCRIPCION : CA-200-2006 
                Funcion que valida si existen Hechos Economicos y Registros Contables.
                Valida si existen diferencias entre Hechos Economicos y Registros Contables a nivel
                general.

  Parametros de Entrada

  - idfFechaMovimiento

  Parametros de Salida

  Historia de Modificaciones
  Autor       Fecha       Descripcion
  HORBATH   20/09/2019    CA-99 Se modifica el parametro utilizado para la cuentas banco que se 
                          deben bucar en la interfaz de ingresos, esto con el fin de omitir las 
                          cuentas de caja de GDCA.
                          Para Efigas se crea el mismo parametro con el mismo valor que contiene
                          el anterior.
                          
  Horbath   24/04/2020    CA-0000398 - Se modifica la interfaz de Control Reintegro, funcion fnuInterfazReintegroRO,  
                          para corregir la validacion del cuadre del movimiento el tipomovi 65 debe ser con signo CR 
                          para que cuadre.
  
  ************************************************************************/
FUNCTION fnuValidaHR_LA(idtFechaMovimiento DATE,
                        nuTipoComprobante in IC_TICOCONT.TCCOCODI%type)
  RETURN NUMBER

   IS

    --<<
    --Variables
    -->>
    nuExisteHechos    NUMBER := 0;
    nuExisteRegistros NUMBER := 0;
    vaCuentasBanco    VARCHAR2(2000);
    vaCuentaCartera   VARCHAR2(2000);
    vaLineInco        VARCHAR2(10000);
    nuTotalDif        number;
    nuTotalDifRE        number;
    vaTolerancia      varchar2(2000);

--<<
-->>
    cursor cuTotalDiferencias is
      SELECT abs(SUM(nvl(VALOR,0)))
      FROM 
      (
          SELECT ENTIDAD, SUM(VALOR) VALOR
          FROM
          (
          SELECT (select it.bancclco from open.banco it where it.banccodi = a.MOVIBACO) entidad,
          --       d.bancnomb Desc_Entidad,
                 -- << CA-398
                 CASE WHEN MOVITIMO = 65 THEN
                     sum(a.MOVIVALO*-1) 
                   ELSE
                     sum(a.MOVIVALO*1)
                 END Valor   
                 --SUM(DECODE(a.movisign, 'D', a.movivalo, -a.movivalo)) Valor          
                 -- CA-398
                 -->>
            
            FROM open.ic_movimien a, open.banco d, open.tipoenre f, open.cuenbanc e, open.ic_tipomovi g
           WHERE MOVITIDO = 74
             AND MOVITIMO IN (38, 65)
             AND a.MOVIFECO >= idtFechaMovimiento
             AND a.MOVIFECO <= idtFechaMovimiento
             AND a.MOVIBACO = d.banccodi
             AND d.banctier = 2
             AND a.movitibr = f.tiercodi
             AND a.movicuba = e.cubacodi
             AND g.timocodi = a.movitimo
          GROUP BY a.MOVIBACO, MOVITIMO
          ) GROUP BY ENTIDAD
          --
          MINUS
          --
          SELECT h.clcocodi ENTIDAD,
          --       h.clcodesc Des_Clasificador,
                 SUM(DECODE(dcrcsign, 'D', dcrcvalo, -dcrcvalo)) VALOR
            FROM OPEN.IC_DECORECO,
                 (SELECT *
                    FROM OPEN.IC_ENCORECO
                   WHERE ECRCCOGE IN
                         (SELECT COGECONS
                            FROM OPEN.IC_COMPGENE
                           WHERE COGECOCO IN (SELECT COD_COMPROBANTE FROM open.LDCI_TIPOINTERFAZ WHERE TIPOINTERFAZ ='LA')
                             AND COGEFEIN >= idtFechaMovimiento
                             AND COGEFEFI <= idtFechaMovimiento)) C,
                 open.ic_clascore p,
                 open.ic_clascont h
           WHERE DCRCECRC = C.ECRCCONS
             AND DCRCCLCR = p.clcrcons
             AND p.clcrclco = h.clcocodi
             AND (dcrccuco LIKE vaCuentaCartera OR dcrccuco LIKE vaCuentasBanco)
          GROUP BY h.clcocodi
      );
      

  BEGIN
   
    --<<
    -- CA-99
    --ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentasBanco', vaCuentasBanco, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CuentasBancoLA', vaCuentasBanco, sbErrorMessage);
    --
    -->>
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'CUENTAFIDUCIA', vaCuentaCartera, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'VALORHOLGURA', vaTolerancia, sbErrorMessage);

    nuTotalDif := 0;
    nuTotalDifRE := 0;

    OPEN  cuTotalDiferencias;
    FETCH cuTotalDiferencias into nuTotalDif;
    CLOSE cuTotalDiferencias;

    IF to_number(vaTolerancia) < nuTotalDif THEN

        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuSeqICLINUDO,'Interfaz ['||ldci_pkinterfazsap.nuSeqICLINUDO||'] Existe diferencia en la interfaz: ['||ldci_pkinterfazsap.nuSeqICLINUDO||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.vaCODINTINTERFAZ,USER,USERENV('TERMINAL'));

        RETURN -1;

    else

        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuSeqICLINUDO,'Interfaz ['||ldci_pkinterfazsap.nuSeqICLINUDO||']  no hay diferencia en la interfaz: ['||ldci_pkinterfazsap.nuSeqICLINUDO||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.vaCODINTINTERFAZ,USER,USERENV('TERMINAL'));

    end if;

  RETURN(0);

  EXCEPTION
  WHEN OTHERS THEN
       ldci_pkinterfazsap.vaMensError :=  '[fnuValidaHR_LA] - error por diferencias en la interfaz  '||SQLERRM||' '||DBMS_UTILITY.format_error_backtrace;
       ldci_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.vaCodintinterfaz,ldci_pkinterfazsap.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));
       RETURN(-1);

  END fnuValidaHR_LA;

/************************************************************************
PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
FUNCION     : NumeroDocumentos
AUTOR       : Arquitecsoft S.A.S - Carlos Andres Dominguez N
FECHA       : 11-06-2014
DESCRIPCION : Reporte numero de documentos generados

Parametros de Entrada


Parametros de Salida

Historia de Modificaciones
Autor      Fecha       Descripcion
************************************************************************/
FUNCTION NumeroDocumentos (nucod_interfazldc LDCI_DETAINTESAP.cod_interfazldc%type)
return tyrcDocumentos
IS
rcDatos tyrcDocumentos;

    CURSOR cuDocumentos (nuTrama number) IS
        /*SELECT a.cod_interfazldc interfaz,
           DECODE(a.clasedoc,'L2', 'RECAUDO', 'LC', 'RECAUDO', 'LA', 'REINTEGRO', '') tipo_interfaz,
           TRUNC(a.fechcont) fecha_contabilizacion,
           COUNT(a.num_documentosap) numero_documentos
        FROM open.ldci_encaintesap a
        WHERE a.cod_interfazldc = nuTrama
        GROUP BY a.cod_interfazldc, a.clasedoc, TRUNC(a.fechcont)
        ORDER BY a.clasedoc, TRUNC(a.fechcont) ASC;*/
    SELECT a.cod_interfazldc interfaz,
          -- DECODE(a.clasedoc,'L2', 'RECAUDO', 'LC', 'RECAUDO', 'LA', 'REINTEGRO', '') tipo_interfaz,
          (select i.tccodesc from IC_TICOCONT i where substr(i.tccodesc,1,2) =  a.clasedoc and rownum=1) tipo_interfaz,
           TRUNC(a.fechcont) fecha_contabilizacion,
           COUNT(distinct a.num_documentosap) numero_documentos,
           sum(decode(c.clavoper,'S',d.impomtrx,0)) valordb,
           sum(decode(c.clavoper,'H',d.impomtrx,0)) valorcr
        FROM open.ldci_encaintesap a, open.ldci_detaintesap d, LDCI_CLAVECONTA c
        WHERE a.cod_interfazldc = nuTrama
          and a.cod_interfazldc = d.cod_interfazldc
          and d.clavcont = c.clavcodi
          AND A.NUM_DOCUMENTOSAP = D.NUM_DOCUMENTOSAP
        GROUP BY a.cod_interfazldc, a.clasedoc, TRUNC(a.fechcont)
        ORDER BY a.clasedoc, TRUNC(a.fechcont) ASC;


BEGIN
    rcDatos := null;

    open cuDocumentos (nucod_interfazldc);
    fetch cuDocumentos INTO rcDatos;
    close cuDocumentos;

    return rcDatos;

EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        errors.seterror;
        raise ex.controlled_error;
END NumeroDocumentos;

BEGIN
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'RutaRepoRecaudo', sbPath, sbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'NombreArchValida', sbFile, sbErrorMessage);
END ldci_ProcesosInterfazSap;
/
