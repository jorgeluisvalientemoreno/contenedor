CREATE OR REPLACE PACKAGE ADM_PERSON.UT_EAN IS
/************************************************************************************
Propiedad intelectual de Open International Systems (c).
Unidad       : UT_EAN
Descripcion  : Crear  Archivos EAN para grandes superficies
Autor        : ANIETO
Fecha        : 11/15/2013 10:07:32 AM

Historia de Modificaciones
Fecha         Autor              Modificacion
===========   ===============    ===================================================
02/03/2015    Mmejia.NC4922      Se modifica metodo <<Connect_FTP>>
12/02/2015    Mmejia.ARA140668   Se modifica metodo <<GetConfigDataFTP>>
20/11/2014    KCienfuegos.NC3878 Se modifica metodo <<CreateEAN_Exito>>
21/11/2013    anietoSAO224535    1 - Cambio orden de parametros de conexion al FTP
11/15/2013    ANIETO SAO223475   Creacion
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
    FUNCTION FSBVERSION
    RETURN VARCHAR2;

    /*************************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      : CreateEAN_Exito
    Descripcion : logica de creacion del archivo EAN para exito
    ***************************************************************************************/
    PROCEDURE CreateEAN_Exito(inuPackageID   IN MO_PACKAGES.PACKAGE_ID%TYPE,
                              inuValueSale   IN NUMBER);


    /*************************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      : CreateFileEANOlimpica
    Descripcion : Crea archivo plano para el proceso de Olimpica
    ***************************************************************************************/
    PROCEDURE CreateFileEAN_Exito(isbContent  IN VARCHAR2,
                                  isbFileName IN VARCHAR2,
                                  ioFile      IN OUT NOCOPY utl_file.file_type);

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
                               itbDataFtp    OUT typtabFTP );

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



   FUNCTION GetEquiPosID(inuSupplierID IN ge_contratista.id_contratista%TYPE) RETURN ld_pos_settings.equivalence%TYPE;


  /*************************************************************************************
  Propiedad intelectual de Open International Systems (c).
  Unidad      : Connect_FTP
  Descripcion :
  Autor       : ANIETO
  ***************************************************************************************/
  PROCEDURE CopyToFTP(isbDiIP IN VARCHAR2,
                      isbUsua IN VARCHAR2,
                      isbPawd IN VARCHAR2,
                      isbArch IN VARCHAR2,
                      isbPath IN VARCHAR2);

END UT_EAN;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.UT_EAN IS
/************************************************************************************
Propiedad intelectual de Open International Systems (c).
Unidad       : UT_EAN
Descripcion  : Crear  Archivos EAN para grandes superficies
Autor        : ANIETO
Fecha        : 11/15/2013 10:07:32 AM

Historia de Modificaciones
Fecha         Autor              Modificacion
===========   ================   ===================================================
02/03/2015    Mmejia.NC4922      Se modifica metodo <<Connect_FTP>>
12/02/2015    Mmejia.ARA140668   Se modifica metodo <<GetConfigDataFTP>>
20/11/2014    KCienfuegos.NC3878 Se modifica metodo <<CreateEAN_Exito>>
21/11/2013    anietoSAO224535    1 - Cambio orden de parametros de conexion al FTP
15/11/2013    ANIETOSAO223475    1 - Creacion
************************************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION       CONSTANT VARCHAR2(10) := 'SAO224535';
    csbFolderOracle  CONSTANT VARCHAR2(4) := '/tmp';
    MI_DIR           CONSTANT VARCHAR2(30) := 'DI_RATING_DIRECTORY';
    --------------------------------------------
    -- Constantes PRIVADAS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;



    /*************************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      : CreateFileEANOlimpica
    Descripcion : Crea archivo plano para el proceso de Olimpica
    Autor       : ANIETO
    Fecha       : 11/15/2013 10:15:57 AM

    Parametros  :
    Entrada
     isbContent  ==>    Contenido a quemar en el archivo plano
     isbFileName ==>    Nombre del Archivo Plano
     ioPathFile  ==>    Ruta de salida del archivo

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    ================   ======================================================
    20/11/2014   KCienfuegos.NC3878 Se agrega obtiene el codigo del convenio del parametro
                                    COD_INTERNO_EXITO_CONV_FNB. Adicionalmente, se cambia la
                                    longitud de la dependencia de 3 a 4 y del valor de credito
                                    de 9 a 8. Se modifica el proceso para que obtenga la equivalencia
                                    teniendo en cuenta tambien el punto de venta, ya que solo esta
                                    teniendo en cuenta el proveedor.
    21/11/2013   ANIETOSAO224535    2 - Modificacion de parametros de conexion.
    11/15/2013   ANIETOSAO223475    1 - creacion
    ***************************************************************************************/
    PROCEDURE CreateEAN_Exito(inuPackageID   IN MO_PACKAGES.PACKAGE_ID%TYPE,
                              inuValueSale   IN NUMBER)
    IS
    FileLines            VARCHAR2(4000) := '';
    csbApplicationPOS    VARCHAR2(4) := '9865';
    csbBrillaAgreement   VARCHAR2(2) := dald_parameter.fsbGetValue_Chain('COD_INTERNO_EXITO_CONV_FNB'); --'02'
    csbDateNow           VARCHAR2(6) := to_char(SYSDATE,'YYMMDD');
    csbFileNameEAN_EXITO VARCHAR2(100):= 'EAN_EXITO_'||to_char(SYSDATE,'DDMMYYYY_HH24MISS')||'.txt';
    nuOrderDel            or_order.order_id%type;
    vrgOrdetrab           daor_order.styOR_order;
    nuSupplierID         ld_suppli_settings.supplier_id%TYPE;
    ftpConn              utl_tcp.connection;
    ioRecordFile         utl_file.file_type;
    inuCodeEquiPOS       LD_POS_SETTINGS.EQUIVALENCE%TYPE;

      CURSOR cuGetQuivalunit(inuSupplierId in ge_contratista.id_contratista%type,
                             inuUnidad    in or_operating_unit.operating_unit_id%type
                              )  IS
          SELECT EQUIVALENCE
              FROM ld_pos_settings
              WHERE   supplier_id = inuSupplierId
                      AND pos_id = inuUnidad
          AND rownum = 1;

    BEGIN
       ut_trace.trace('INICIA UT_EAN.CreateEAN_Exito',2);
       --Obtiene el idenficador del proveedor exito
       nuSupplierID   := Dald_parameter.fnuGetNumeric_Value('CODI_CUAD_EXITO');
       --inuCodeEquiPOS := GetEquiPosID(nuSupplierID);
       nuOrderDel := LD_BCNONBANKFINANCING.FrfGetOrderEnt(inuPackageID);
       vrgOrdetrab := daor_order.frcGetRecord(inuOrder_Id => nuOrderDel);

       open cuGetQuivalunit(nuSupplierID, vrgOrdetrab.operating_unit_id);
       fetch cuGetQuivalunit INTO inuCodeEquiPOS;
       close cuGetQuivalunit;

       inuCodeEquiPOS := nvl(inuCodeEquiPOS,vrgOrdetrab.operating_unit_id);

       --Configura Linea para agregar al documento
       FileLines := csbApplicationPOS||
                    lpad(to_char(to_number(inuCodeEquiPOS)),4,'0')|| --Se cambia 3 por 4
                    lpad(to_char(inuPackageID),8,'0')||
                    csbBrillaAgreement||
                    csbDateNow||
                    lpad(to_char(inuValueSale),8,'0'); --Se cambia 9 por 8

       --Obtiene configuracion para conexion con el FTP
       GetConfigDataFTP(nuSupplierID,vtabFTP);
       --Establece conexion con el FTP
       Connect_FTP(vtabFTP,nuSupplierID,ftpConn);
       --Agrega linea en documento
       CreateFileEAN_Exito(FileLines,csbFileNameEAN_EXITO,ioRecordFile);
       ftp.logout(ftpConn);
       utl_tcp.close_all_connections;

       --Copia el archivo EAN a Ftp Externo
       CopyToFTP(vtabFTP(nuSupplierID).DIIP,
                 vtabFTP(nuSupplierID).USUA,
                 vtabFTP(nuSupplierID).PAWD,
                 csbFileNameEAN_EXITO,
                 vtabFTP(nuSupplierID).RUTA);

        ut_trace.trace('FIN UT_EAN.CreateEAN_Exito',2);
    EXCEPTION
     WHEN OTHERS THEN
     --cierra conexion
      utl_tcp.close_all_connections;
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
    END CreateEAN_Exito;

    /*************************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      : CreateFileEANOlimpica
    Descripcion : Crea archivo plano para el proceso de Olimpica
    Autor       : ANIETO
    Fecha       : 11/15/2013 10:15:57 AM

    Parametros  :
    Entrada
     isbContent  ==>    Contenido a quemar en el archivo plano
     isbFileName ==>    Nombre del Archivo Plano
     ioPathFile  ==>    Ruta de salida del archivo

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    ================   ======================================================
    11/15/2013   ANIETOSAO223475    1 - creacion
    ***************************************************************************************/
    PROCEDURE CreateFileEAN_Exito(isbContent  IN VARCHAR2,
                                  isbFileName IN VARCHAR2,
                                  ioFile      IN OUT NOCOPY utl_file.file_type) IS
    BEGIN
        ut_trace.trace('INICIA UT_EAN.CreateFileEAN_Exito',2);

    IF (NOT utl_file.is_open(ioFile)) THEN
      ioFile := utl_file.fopen(csbFolderOracle,isbFileName, 'w');
      utl_file.put_line(ioFile, isbContent);
      CloseFile(ioFile);
    END IF;
        ut_trace.trace('FIN UT_EAN.CreateFileEAN_Exito',2);
    EXCEPTION
     WHEN OTHERS THEN
       CloseFile(ioFile);

       Errors.setError;
       raise ex.CONTROLLED_ERROR;
    END CreateFileEAN_Exito;


    /*************************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      : CloseFile
    Descripcion : Cierra el archivo abierto
    Autor       : ANIETO
    Fecha       : 11/15/2013 10:15:57 AM
    Parametros  :
    Entrada
     ioPathFile  ==>    Ruta de salida del archivo

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    ================   ======================================================
    11/15/2013   ANIETOSAO223475    1 - creacion
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
    11/15/2013   ANIETOSAO223475    1 - creacion
    12-02-2015   Mmejia.ARA140668   Modificacion del proceso para que desencripte los datos
                                    de la cadena de conexion.
    ***************************************************************************************/
    PROCEDURE GetConfigDataFTP(inuSupplierID IN ld_suppli_settings.supplier_id%TYPE,
                               itbDataFtp    OUT typtabFTP ) IS

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
    csbLLave       CONSTANT VARCHAR2( 30 ) := '101001011011110110101101010011';
    sbClave LD_SUPPLI_SETTINGS.CONNECT_INFO%TYPE;
    BEGIN
    ut_trace.trace('INICIA UT_EAN.GetConfigDataFTP',2);
      ut_trace.trace(' inuSupplierID '||inuSupplierID,2);

          OPEN cuServFTP(inuSupplierID);
          FETCH cuServFTP INTO vrgServFTP;

          IF(cuServFTP%ISOPEN) THEN
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
          pkControlConexion.encripta( vrgServFTP.PAWD, sbClave, csbLLave, 1 );
          --Dbms_Output.Put_Line('Clave lectura:'||sbClave);
          ut_trace.trace(' Clave lectura:'||sbClave,2);
          itbDataFtp(inuSupplierID).PAWD := sbClave;

          --Desencripta clave de escritura
          pkControlConexion.encripta( vrgServFTP.PWDE, sbClave, csbLLave, 1 );
          --Dbms_Output.Put_Line('Clave escritura:'||sbClave);
          ut_trace.trace(' Clave escritura:'||sbClave,2);
          itbDataFtp(inuSupplierID).PWDE := sbClave;

    ut_trace.trace('FIN UT_EAN.GetConfigDataFTP',2);
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
    02/03/2015   Mmejia.NC4922      Se modifica el proceso para que realice la conexion a la
                                    configurada como IP de escritura DIPE en la tabla ld_suppli_settings
    11/15/2013   ANIETOSAO223475    1 - creacion
    ***************************************************************************************/
    PROCEDURE Connect_FTP(itbDataFtp  IN typtabFTP,
                          inuIndexFtp IN NUMBER,
                          ftpConn     OUT utl_tcp.connection ) IS
    BEGIN
     ut_trace.trace('INICIA UT_EAN.Connect_FTP',2);
     ut_trace.trace(' itbDataFtp(inuIndexFtp).DIPE '||itbDataFtp(inuIndexFtp).DIPE,2);
     ut_trace.trace(' itbDataFtp(inuIndexFtp).USUE '||itbDataFtp(inuIndexFtp).USUE,2);
     ut_trace.trace(' itbDataFtp(inuIndexFtp).PWDE '||itbDataFtp(inuIndexFtp).PWDE,2);

      ftpConn := ftp.login(itbDataFtp(inuIndexFtp).DIPE,
                           '21',
                           itbDataFtp(inuIndexFtp).USUE,
                           itbDataFtp(inuIndexFtp).PWDE);

     ut_trace.trace('FIN UT_EAN.Connect_FTP',2);
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


  FUNCTION GetEquiPosID(inuSupplierID IN ge_contratista.id_contratista%TYPE) RETURN ld_pos_settings.equivalence%TYPE
  IS
     sbEqui ld_pos_settings.equivalence%TYPE;
  BEGIN
  ut_trace.trace('INICIA UT_EAN.GetEquiPosID',2);
       SELECT
             ps.equivalence INTO sbEqui
       FROM ld_pos_settings ps
       WHERE ps.supplier_id = inuSupplierID
       AND rownum = 1;

  ut_trace.trace('FIN UT_EAN.GetEquiPosID',2);
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
  11/15/2013   ANIETOSAO223475    1 - creacion
  ***************************************************************************************/
  PROCEDURE CopyToFTP(isbDiIP IN VARCHAR2,
                      isbUsua IN VARCHAR2,
                      isbPawd IN VARCHAR2,
                      isbArch IN VARCHAR2,
                      isbPath IN VARCHAR2)
  IS
    vTconn UTL_TCP.connection;

  BEGIN
    ut_trace.Trace('INICIO UT_EAN.CopyFTP_External', 10);
    dbms_output.put_line('isbDiIP: '||isbDiIP||' isbUsua: '||isbUsua||' isbPawd: '||isbPawd||' isbArch: '||isbArch||' isbPath: '||isbPath);
    ut_trace.Trace('isbDiIP: '||isbDiIP||' isbUsua: '||isbUsua||' isbPawd: '||isbPawd||' isbArch: '||isbArch||' isbPath: '||isbPath, 10);


    vTconn := ftp.login(isbDiIP, '21', isbUsua, isbPawd); -- Conexion FTP
    ftp.ascii(p_conn => vTconn);

    --Copia al ftpExterno
    ftp.put(p_conn      => vTconn,
            p_from_dir  => MI_DIR,
            p_from_file => isbArch,
            p_to_file => isbPath || isbArch
            );

    dbms_output.put_Line('OK, archivo subido?');
    ftp.logout(vTconn);



    ut_trace.Trace('FIN UT_EAN.CopyFTP_External', 10);
  EXCEPTION
    WHEN OTHERS THEN
     utl_tcp.close_all_connections;
      dbms_output.put_line(sqlerrm);
      ut_trace.Trace('ERROR Others UT_EAN.CopyFTP_External: ' || sqlerrm, 10);
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
  END CopyToFTP;


END UT_EAN;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('UT_EAN', 'ADM_PERSON'); 
END;
/
