create or replace PACKAGE ldc_pkgOSFFacture
/**********************************************************************************
    Propiedad intelectual de CSC. (C).

    Package     : ldc_pkgOSFFacture
    Descripción : Paquete con la logica para el Copiado de los Archivos Plano
                  Facturación Recurrente y duplicados en las rutas definidaas
                  como parametro

    Autor     : Carlos Humberto Gonzalez V
    Fecha     : 22-08-2017

    Historia de Modificaciones
    DD-MM-YYYY    <Autor>               Modificacion
    -----------  -------------------    -------------------------------------
    22-08-2017    cgonzalezv            Creacion.
    22-05-2018    STapias               REQ.2001859 - Se modifican los metodos:
                                        <<proExeCopyArchFIDF>>
                                        <<proCopiaArchFIDF>>
                                        <<proListArchFIDF>>
                                        <<proComparaArchFIDF>>
	26/07/2021    Horbath               caso:802. se modifica funciOn PRGENACTIIMPCAR, se modifica prodecimiento proExeCopyArchFIDF
												 se crea funcion fnuCreaReporte, se crea procedimiento PrDetalleReporte . 			
    24/01/2023    lfvalencia            OSF-827 Se modifica el procedimiento
                                        PRGENACTIIMPCAR	
    26/10/2023    jpinedc               OSF-1701: 
                                        * Se crean
                                        ** cnuSERVICIO_GAS_CLM
                                        ** csbESCO_NO_IMPR_CART_RP
                                        ** cuProdSinFactConNotiRP
                                        ** ftbProdSinFactConNotiRP
                                        ** pgenRegSpoolCartasContSinFact
                                        ** pgenSpoolCartasContSinFact
                                        ** fnuTipoNotificacion
                                        * Se modifica
                                        ** proExeCopyArchFIDF                                        
    20/03/2024    jpinedc               OSF-1701: Se ajusta cursor 
                                        cuProdSinFactConNotiRP
                                        * Se borra csbESCO_NO_IMPR_CART_RP
    18/04/2024    jpinedc               OSF-1701: Se cambia csSep a pipe                                        
    17/05/2024    jpinedc               OSF-2581: Se ajusta proEnviaCorreo
    05/06/2024    GDGuevara             OSF-2788: Se ajusta el cursor cuProdSinFactConNotiRP.productos,
                                        para que tenga en cuenta solo los productos activos y no castigados
    23/09/2024    jpinedc               OSF-3309: Se ajusta pgenSpoolCartasContSinFact(Mini Spool)
                                        * fblProcesoEjecutado: Nuevo
**********************************************************************************/
 IS
  -- Public type declarations
  -- type <TypeName> is <Datatype>;

  --CASO 200-2033
  NuLOG     number := 0;
  SbLOG     varchar2(4000) := null;
  NuControl number := 0;
  SbControl varchar2(4000) := null;
  --CASO 200-2033

    -- Tipo de producto Gas
    cnuSERVICIO_GAS_CLM CONSTANT NUMBER := pkg_parametros.fnuGetValorNumerico('SERVICIO_GAS_CLM');
      
    csbFGCC CONSTANT procesos.proccodi%TYPE := 'FGCC';
    
    CURSOR cuProdSinFactConNotiRP( inuPeriodo NUMBER)
    IS
    WITH PeFaCiclo AS
    (
        SELECT pf.pefacicl, pf.pefacodi
        FROM perifact pf
        WHERE pf.pefacodi = inuPeriodo
    ) ,
    contratos AS
    (        
        SELECT  sc.susccodi, sc.suscclie, sc.susciddi
        FROM PeFaCiclo pc, suscripc sc
        WHERE sc.susccicl = pc.pefacicl
        AND NOT EXISTS
        (
            SELECT '1'
            FROM factura fa
            WHERE fa.factsusc = sc.susccodi
            AND fa.factpefa = pc.pefacodi
            AND fa.factprog = 6
        )
    ),
    productos AS
    (
        SELECT ct.susccodi sesususc, pr.product_id sesunuse, ct.suscclie, ct.susciddi, pr.category_id sesucate, pr.subcategory_id sesusuca
        FROM contratos ct, pr_product pr, servsusc ss
        WHERE pr.subscription_id = ct.susccodi
          AND pr.product_type_id = cnuSERVICIO_GAS_CLM
          AND pr.product_status_id IN
              (
                SELECT ps.product_status_id
                FROM ps_product_status ps
                WHERE ps.prod_status_type_id = 1
                  AND ps.is_active_product = 'Y'
                  AND ps.is_final_status= 'Y'
              )
          AND ss.sesunuse = pr.product_id
          AND ss.sesuesfn NOT IN ('C')
    ),
    ult_medidor as
    ( 	 
        SELECT es.EMSSSESU, es.emsscoem,  RANK() OVER (PARTITION BY es.emsssesu ORDER BY es.emssfere DESC) posicion
        FROM elmesesu es
    ) 
                
    SELECT inuPeriodo Periodo,
           pr.sesususc Contrato,
           pr.sesunuse Producto,
           sr.subscriber_name || ' ' || sr.subs_last_name nombre_cliente,
           ad.ADDRESS_PARSED Direccion_Cobro,
           -1 TipoNotificacion,
           ad.geograp_location_id Localidad, 
           gl.description Nombre_Localidad,
           dp.description Nombre_Departamento,
           -1 EdadCertificado,
           um.emsscoem medidor,
           pr.sesucate categoria,
           pr.sesusuca subcategoria
    FROM    productos pr, ge_subscriber sr,
            ab_address ad,
            ge_geogra_location gl,            
            ge_geogra_location dp,
            ult_medidor um
    WHERE sr.subscriber_id = pr.suscclie
    AND ad.address_id = pr.susciddi
    AND gl.geograp_location_id = ad.geograp_location_id
    AND dp.geograp_location_id =  gl.GEO_LOCA_FATHER_ID
    AND um.emsssesu(+) = pr.sesunuse
    AND um.posicion(+) = 1;

    TYPE tytbProdSinFactConNotiRP IS TABLE OF cuProdSinFactConNotiRP%ROWTYPE
    INDEX BY BINARY_INTEGER;  

  -- Public constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  --<VariableName> <Datatype>;

  -- Public function and procedure declarations
  /**********************************************************************************
    Propiedad intelectual de CSC. (C).
  
    Unidad      : proApplyPayment
    Descripción : procedimiento encargado de la aplicacion de los pagos que fueron cargados
                  por la forma LDCARGPAG tabla LDC_LOTEPAGOPRODUCT.
  
    Autor     : Carlos Humberto Gonzalez
    Fecha     : 08-08-2017
  
    Historia de Modificaciones
    DD-MM-YYYY    <Autor>               Modificacion
    -----------  -------------------    -------------------------------------
    08-08-2017    cgonzalezv            Creacion.
  **********************************************************************************/
  --<<
  -- Variables Globales
  -->>

  /**********************************************************************
    Propiedad intelectual de CSC
    Nombre   progenduplifac
    Autor    Carlos Gonzalez
    Fecha    29/08/2017
  
    Descripcion: lógica de seleccionar los cupones recaudados desde las
                 ceros (0) horas hasta la fecha de ejecución
                 ('FECHA 00:00:00','DD-MM-YYYY HH24:MI:SS hasta SYSDATE)
  
    Historia de Modificaciones
    Fecha             Autor             Modificacion
    ============    ============       ========================
    29/08/2017       cgonzalezv        1. Creacion
  ***********************************************************************/
  PROCEDURE ldc_proPagosDia(idtfechagen DATE DEFAULT SYSDATE);

  /**********************************************************************
    Propiedad intelectual de CSC
    Nombre   progenduplifac
    Autor    Carlos Gonzalez
    Fecha   28/08/2017
  
    Descripcion: Procedimiento que Crea el Archivo Plano de los
                 Duplicados Generados
  
    Historia de Modificaciones
    Fecha             Autor             Modificacion
   ============    ============       ========================
   28/08/2017       cgonzalezv        1. Creacion
  ***********************************************************************/
  PROCEDURE progenduplifac;

  /**************************************************************************
  Propiedad intelectual de CSC. (C).
  Funcion     :  proComparaArchFIDF
  Descripcion :  procedimiento encargado de comparar los archivos de facturacion
                 copiados.
  
  Autor       : Carlos Humberto Gonzalez V
  Fecha       : 28-08-2017
  
  Historia de Modificaciones
    Fecha               Autor                Modificación
  =========           =========          ====================
  28-08-2017          cgonzalezv              Creacion.
  **************************************************************************/
  PROCEDURE proComparaArchFIDF;

  /**************************************************************************
  Propiedad intelectual de CSC. (C).
  Funcion     :  proExeCopyArchFIDF
  Descripcion :  procedimiento encargado de recibir los periodos de facturacion en
                 formato cadena para el copiado
  
  Autor       : Carlos Humberto Gonzalez V
  Fecha       : 22-08-2017
  
  Historia de Modificaciones
    Fecha               Autor                Modificación
  =========           =========          ====================
  22-08-2017          cgonzalezv              Creacion.
  **************************************************************************/
  PROCEDURE proExeCopyArchFIDF;

  PROCEDURE proCopiaArchUnificadoFIDF;
  
  /**************************************************************************
  Propiedad intelectual de GDC.
  Funcion     :  PRGENACTIIMPCAR
  Descripcion :  proceso que se encarga de generar ordenes de impresion a usuarios
                 marcados en la tabla LDC_INFOPRNOR  
  Autor       : Horbath
  Ticket      : 27
  Fecha       : 19/12/2019
  
  Parametros Entrada
    inuPeriodo periodo de facturacion

  Valor de salida
  
  Historia de Modificaciones
    Fecha               Autor                Modificación
  =========           =========          ====================
  24/01/2023          lfvalencia          OSF-827: Se agregan los siguientes
                                          parámetros:
                                          LDC_MES_NOTIFICA_INI_RP - Mes en que se
                                          realiza la notificación inicial de RP
                                          LDC_MES_SEGUNDA_NOTI_RP - Mes en que 
                                          se realiza la segunda notificación de RP
                                          y se modifica el nombre de los parametros de 
                                          las actividades.
                                          LDC_ACTICARM55
                                          LDC_ACTICARM57
  **************************************************************************/
  PROCEDURE PRGENACTIIMPCAR(isbPeriodo IN VARCHAR2);

 PROCEDURE proEnviaCorreo(  inuPeriodo IN NUMBER,
                            nuOk OUT NUMBER,
                            sbErrorMessage OUT VARCHAR2
                            );
 /**************************************************************************
        Autor       :  Horbath
        Fecha       : 2019-12-19
        Ticket      : 27
        Descripcion : se envia correo.

        Parametros Entrada
        inuPeriodo  Periodo de facturacion

        Valor de salida
         nuOk  -1. Error, 0. Exito
       sbErrorMessage mensaje de error.

        nuError  codigo del error
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
      ***************************************************************************/
      
    -- Retorna una tabla pl con los productos de gas que no tuvieron factura en el período  
    FUNCTION ftbProdSinFactConNotiRP( inuPeriodo NUMBER)
    RETURN tytbProdSinFactConNotiRP;
    
    -- Genera un registro en el spool de cartas para el periodo
    PROCEDURE pgenRegSpoolCartasContSinFact( inuConsecutivo NUMBER, ircProducto cuProdSinFactConNotiRP%ROWTYPE, isbFechaProceso VARCHAR2, inuPeriodo NUMBER );

    -- Genera los archivos de spool de cartas para la lista de periodos     
    PROCEDURE pgenSpoolCartasContSinFact(isbPeriodos VARCHAR2);
    
    -- Retorna el tipo de notificación de acuerdo con la edad del certificado
    FUNCTION fnuTipoNotificacion( inuEdadCertificado NUMBER)
    RETURN NUMBER;
    
    -- Retorna verdadero si el proceso fue ejecutado para el periodo
    FUNCTION fblProcesoEjecutado
    (
        inuPeriodo  perifact.pefacodi%TYPE, 
        isbProceso  procesos.proccodi%TYPE
    ) RETURN BOOLEAN;        
              							
END ldc_pkgOSFFacture;
/

create or replace PACKAGE BODY ldc_pkgOSFFacture
IS

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza   CONSTANT NUMBER(2)  	:= pkg_traza.fnuNivelTrzDef;      
 
    NuEncabezado         number := 0;
    NuEncabezadoRegistro number := 0;
    filehandler          utl_file.file_type;
    linedata             varchar2(32767);
    linetype             varchar2(2);
    SBNOMARCUNI VARCHAR2(4000) := null; --'FIDF_63599_18052018_133651_Z0_ATLANTICO';

    SBNOMDEPAR VARCHAR2(4000) := null;

    filePeriodo   UTL_FILE.FILE_TYPE; -- archivo peridoo de facturacio
    fileUnificado UTL_FILE.FILE_TYPE; -- archivo de unificacion de achicos de periodo de facturacion
    lfile         varchar2(4000);


    -- Variables globales privadas
    gnuCantArhPeri NUMBER := 0; -- Cantidad de archivos por periodos seleccionados
    gvarutarch     VARCHAR2(2000);-- ruta o directorio donde se encuentran los archivos origen
    gvaMensaje     VARCHAR2(4000); -- Mensaje de error
    fileCtrl       UTL_FILE.FILE_TYPE; -- archivo de control
    fileLog        UTL_FILE.FILE_TYPE; -- archivo de log
    gvanomfileLog  VARCHAR2(400); -- archivo de log

    -- Tabla PL para almacenar el nombre del archivo sin la ruta
    TYPE typNombArch IS TABLE OF VARCHAR2(200) INDEX BY BINARY_INTEGER;
    tbtypNombArch     typNombArch;
    tbtypNombArchPeri typNombArch;
    --------------------------------------------------------------
    --REQ.2001859 -->
    /*Obs: Se crea variable espejo para almacenar departamentos.*/
    --------------------------------------------------------------
    tbtypNombArchPeriDepa typNombArch;
    -----------------
    --REQ.2001859 <--
    -----------------
    --caso 200-2033
    tbtypNombArchPeriDepaUnificado typNombArch;
    NuUnificado                    number := 0;
    NuPeriodo                      number := 0;
    NuPeriodoP                     number := 0;
    --Manejo de Finales de Archivo
    tbtUnificado typNombArch;
    TYPE typNombArch1 IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;
    tbtLinea     typNombArch1;
    NuIndice     number := 0;
    Templinedata varchar2(32767);
    --
  
    csbSep          CONSTANT VARCHAR2(1) := '|';
  
    TYPE tygtblListArchCartasFIDF IS TABLE OF pkg_gestionArchivos.styArchivo INDEX BY VARCHAR2(100);
  
    gtblListArchCartasFIDF tygtblListArchCartasFIDF;
 
    TYPE tytbConfMensRP  IS TABLE OF LDC_CONFIMENSRP%rowtype INDEX BY BINARY_INTEGER;
    
    gtbConfMensRP tytbConfMensRP;
    
    csbTERMINADO    CONSTANT VARCHAR2(1) := 'T';
    
    PROCEDURE proEnviaCorreo(  inuPeriodo IN NUMBER,
                            nuOk OUT NUMBER,
                            sbErrorMessage OUT VARCHAR2
                            ) is

    /**************************************************************************
        Autor       :  Horbath
        Fecha       : 2019-12-19
        Ticket      : 27
        Descripcion : se envia correo.

        Parametros Entrada
        inuPeriodo  Periodo de facturacion

        Valor de salida
         nuOk  -1. Error, 0. Exito
       sbErrorMessage mensaje de error.

        nuError  codigo del error
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR          DESCRIPCION
         21/10/2020  HT             CA 465 se coloca parametro NOTIFICAOTIMPRESION para validar 
                                    envio de correo
        18/04/2024    jpinedc       OSF-2581: Se cambian programas de envio de correo
                                    por pkg_Correo                                
    ***************************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proEnviaCorreo';

    sbNombreArchivo VARCHAR2(250):='InforOrdenes_'||to_char(sysdate,'DDMMYYYY_HH24MISS'); -- se almacena el nombre del archivo
    archivo utl_file.file_type;

    sbMensaje  VARCHAR2(200):= 'Proceso termino, por favor valide archivo adjunto';

    --  Archivo
    BLFILE  Bfile;

    nuarchexiste  Number; -- valida si creo algun archivo en el disco

    sbfromdisplay Varchar2(4000) := 'Open SmartFlex'; -- Nombre del emisor

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

    sbtodisplay Varchar2(4000) := '';
    sbcc        ut_string.tytb_string;
    sbccdisplay ut_string.tytb_string;
    sbbcc       ut_string.tytb_string;
    
    -- asunto
    sbsubject Varchar2(255) ;
    sbmsg Varchar2(10000) := sbMensaje;
    sbcontenttype Varchar2(100) := 'text/html';

    sbfilename    Varchar2(255) := sbNombreArchivo;
    sbfileext     Varchar2(10) := 'txt'; -- especifica el tipo de archivo que se enviará. ZIP o CSV
    nutam_archivo Number;-- tamano del archivo a enviar

	sbEncabezado VARCHAR2(4000) := 'PRODUCTO|ORDEN DE IMPRESION|FECHA DE REGISTRO|FECHA DE ASIGNACION|INCOSISTENCIA';
    --  Se consulta infromacion de ordenes 
    CURSOR cuOrdenes IS
    SELECT 
			PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO ((SELECT L.GEO_LOCA_FATHER_ID
          FROM GE_GEOGRA_LOCATION l 
          where l.GEOGRAP_LOCATION_ID =  PKG_BCDIRECCIONES.FNUGETLOCALIDAD(OA.ADDRESS_ID) ))||'|'||
       
        (SELECT replace(L.GEOGRAP_LOCATION_ID||' - '||L.DESCRIPTION,'|','')
          FROM GE_GEOGRA_LOCATION l where l.GEOGRAP_LOCATION_ID =  PKG_BCDIRECCIONES.FNUGETLOCALIDAD(OA.ADDRESS_ID)) ||'|'||
        OA.SUBSCRIPTION_ID||'|'||
        INPNSESU||'|'||
        (select replace(S.SUBSCRIBER_NAME||' '||S.SUBS_LAST_NAME||' '||S.SUBS_SECOND_LAST_NAME,'|','') from GE_SUBSCRIBER s where s.SUBSCRIBER_ID = Oa.SUBSCRIBER_ID) ||'|'||
       INPNORIM||'|'|| o.CREATED_DATE||'|'|| o.ASSIGNED_DATE||'|'|| oa.product_id||'|'||o.OPERATING_UNIT_ID||'|'||o.task_type_id||' '||
         replace(daor_task_type.fsbgetdescription(o.task_type_id,null),'|','')||'|'||oa.activity_id||'|'||PKG_BCDIRECCIONES.FSBGETDIRECCIONPARSEADA(OA.ADDRESS_ID)||'|'||INPNFERE||'|'||INPNINCO  datos	
    FROM LDC_INFOPRNORP
	    left join or_order o on INPNORIM = o.order_id
		left join or_order_activity oa on o.order_id = oa.order_id
    WHERE INPNPEFA = inuPeriodo	  
     AND (INPNORIM IS NOT NULL OR INPNINCO IS NOT NULL) ;

    sbEmailFunc VARCHAR2(4000) :=pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_EMAIFUNO'); --Se almacena email de funcionarios
    nuUnidadOpera NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_UNOPDISP'); --Se almacena unidad operativa de dispapeles
    
    --  Se consulta correo
    CURSOR cuCorreo IS
    SELECT *
    FROM (
            SELECT e_mail
            FROM or_operating_unit
            WHERE operating_unit_id = nuUnidadOpera
            union all
            SELECT REGEXP_SUBSTR (sbEmailFunc,'[^,]+',1,LEVEL)    e_mail
            FROM DUAL
            CONNECT BY REGEXP_SUBSTR (sbEmailFunc,'[^,]+',1,LEVEL) IS NOT NULL
        )
    WHERE e_mail IS NOT NULL
    ;

    sbDato    VARCHAR2(4000);
    adjunto       Blob;-- file type del archivo final a enviar   
 
    directorio    Varchar2(255) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_RUTAARORD'); -- se consulta directorio del archivo

    erNoExiste EXCEPTION; -- Excepcion si no existe indicadores
    
    sbEnviaEmail VARCHAR2(1) := DALDC_PARAREPE.FSBGETPARAVAST('NOTIFICAOTIMPRESION', NULL);


        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores'; 
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
                    
            IF cuOrdenes%ISOPEN THEN
                CLOSE cuOrdenes;
            END IF;
            
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;     
	
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        	  
        pkg_Traza.trace('PERIODO ['||inuPeriodo||']', 10);
        
        pCierraCursores;

        IF sbEnviaEmail = 'N' THEN
            RETURN;
        END IF;

        OPEN cuOrdenes;
        FETCH cuOrdenes INTO sbDato;
        IF cuOrdenes%FOUND THEN
            CLOSE cuOrdenes;
            
            sbsubject := 'Informacion de Ordenes de Impresion Generadas';
            
            -- se abre archivo para su escritura
            Begin               
                archivo := utl_file.fopen(directorio, sbNombreArchivo || '.' || sbfileext, 'w', 32767);
            Exception
              When Others Then
                NULL;
            End;
             
            utl_file.new_line(archivo);
            utl_file.put(archivo, 'Informacion de Ordenes de Impresion ');
            utl_file.new_line(archivo);
            utl_file.put(archivo, sbEncabezado);

           -- se cargan los datos para el indicador
            FOR reg IN cuOrdenes LOOP
                utl_file.new_line(archivo);
                utl_file.put(archivo, reg.datos);
            END LOOP;

            -- se escribe en el archivo
            blfile       := bfilename(directorio, sbNombreArchivo || '.' || sbfileext);
            nuarchexiste := dbms_lob.fileexists(blfile);  -- se valida si existe archivo

            utl_file.fclose(archivo);  -- se cierra archivo

            dbms_lob.open(blfile, dbms_lob.file_readonly);
            nutam_archivo := dbms_lob.getlength(blfile);
            dbms_lob.createtemporary(adjunto, True);
            dbms_lob.loadfromfile(adjunto, blfile, nutam_archivo);
            dbms_lob.close(blfile);

            -- si existe archivo se procede a enviar correo
            IF    nutam_archivo >= 1 THEN
                begin
                    FOR regco IN cuCorreo LOOP

                        pkg_Correo.prcEnviaCorreo
                        (
                            isbRemitente        => sbRemitente,
                            isbDestinatarios    => regco.e_mail,
                            isbAsunto           => sbsubject,
                            isbMensaje          => sbmsg,
                            isbArchivos         => directorio || '/' || sbNombreArchivo || '.' || sbfileext,
                            isbDescRemitente    => sbfromdisplay
                        );
                        
                    END LOOP;
                EXCEPTION
                   WHEN OTHERS THEN
                      FOR regco IN cuCorreo LOOP
                            
                            pkg_Correo.prcEnviaCorreo
                            (
                                isbRemitente        => sbRemitente,
                                isbDestinatarios    => regco.e_mail,
                                isbAsunto           => sbsubject,
                                isbMensaje          => 'Se creo archivo plano con el nombre de ['||sbfilename||'] e la ruta['||directorio||']'
                            );
                            
                     END LOOP;
              
                END;
            ELSE
                sbErrorMessage := 'No se pudo crear archivo';
                nuOk := -1;
            END IF;
        else
            CLOSE cuOrdenes;
        END IF;

        if sbErrorMessage is null then
            nuOk := 0;
        end if;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN erNoExiste THEN
            sbErrorMessage   := 'Error no Controlado, en ldc_pkgOSFFacture.proEnviaCorreo '||SQLERRM;
            nuOk := -1;
            pkg_Traza.trace('ERROR ENVIO CORREO erNoExiste ['||sbErrorMessage||']', 10);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);            
        WHEN OTHERS THEN
            ROLLBACK;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);            
            sbErrorMessage   := 'Error no Controlado, en ldc_pkgOSFFacture.proEnviaCorreo '||SQLERRM;
            nuOk := -1;
            pCierraCursores;
            pkg_Traza.trace('ERROR ENVIO CORREO OTHERS ['||sbErrorMessage||']', 10);
    END proEnviaCorreo;
      
	FUNCTION fnuCreaReporte
    return number
    IS
	/**************************************************************************
	  Propiedad intelectual de GDC.
	  Funcion     :  fnuCreaReporte
	  Descripcion :  funcion que que registra en la tabla Reportes y retorna el id del reporte
	  Autor       : Horbath
	  Ticket      : 802
	  Fecha       : 26/07/2019

	  Parametros Entrada
        

      Valor de salida

	  Historia de Modificaciones
		Fecha               Autor                Modificación
    =========           =========          ====================
    **************************************************************************/
        PRAGMA AUTONOMOUS_TRANSACTION;
        
        rcRecord Reportes%rowtype;

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuCreaReporte'; 
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
		
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
    --{
        -- Fill record
        rcRecord.REPOAPLI := 'COPYFACT';
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := pkg_Session.fsbGetTerminal;
        rcRecord.REPODESC := 'Proceso que se encarga de generar ordenes de impresion' ;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);
		commit;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        return rcRecord.Reponume;
               
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);            
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
            RAISE pkg_error.Controlled_Error;        
    --}
    END fnuCreaReporte;
	
	PROCEDURE PrDetalleReporte(
        inuIdReporte    in repoinco.reinrepo%type,
        inuPeriodo      in repoinco.reinval1%type,
        isbPerStatus        in repoinco.reinobse%type,
        inuSeq         in repoinco.reincodi%type
    )
    IS
	
	/**************************************************************************
		  Propiedad intelectual de GDC.
		  Funcion     :  PrDetalleReporte
		  Descripcion :  procedimiento que registra en la tabla repoinco
		  Autor       : Horbath
		  Ticket      : 802
		  Fecha       : 26/07/2019

		  Parametros Entrada
			inuPeriodo periodo de facturacion

		  Valor de salida

		  Historia de Modificaciones
			Fecha               Autor                Modificación
			=========           =========          ====================
	**************************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PrDetalleReporte';  
        	
        PRAGMA AUTONOMOUS_TRANSACTION;
        rcRepoinco repoinco%rowtype;
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
                
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuPeriodo;        
        rcRepoinco.reinobse := isbPerStatus;
        rcRepoinco.reincodi := inuSeq;

        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);
		commit;
		
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        		
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);            
            RAISE pkg_error.Controlled_Error;
    END PrDetalleReporte;
  
    PROCEDURE ldc_proPagosDia(idtfechagen DATE DEFAULT SYSDATE)
    /**********************************************************************
      Propiedad intelectual de CSC
      Nombre   progenduplifac
      Autor    Carlos Gonzalez
      Fecha    29/08/2017

      Descripcion: lógica de seleccionar los cupones recaudados desde las
                   ceros (0) horas hasta la fecha de ejecución
                   ('FECHA 00:00:00','DD-MM-YYYY HH24:MI:SS hasta SYSDATE)

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      ============    ============       ========================
      29/08/2017       cgonzalezv        1. Creacion
    ***********************************************************************/
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_proPagosDia';  
            
        -- Variables
        dtFechaIni     DATE; -- Fecha inicial para el rango de pagos
        dtFechaFin     DATE; -- Fecha final para el rango de pagos
        fileCtrPagos   UTL_FILE.FILE_TYPE; -- archivo de control de pagos
        fileLogPagos   UTL_FILE.FILE_TYPE; -- archivo de log de pagos
        filePagos      UTL_FILE.FILE_TYPE; -- archivo de pagos
        vaRutArchPag   VARCHAR2(3000); -- Ruta destino para el archivo de pagos
        vaNomArchPag   VARCHAR(400); -- Nombre del archivo de pagos
        vaLogPagos     VARCHAR(400); -- Nombre del archivo de log para pagos
        vacontrolPagos VARCHAR(400); -- Nombre del archivo de control para pagos
        dtfechaproc    DATE; -- fecha de generacion del proceso
        vaCadenaPagos  VARCHAR(4000); -- Cadena para escritura del archivo
        sbError        VARCHAR(4000); -- Cadena para los errrores
        nucupon        NUMBER; -- cupon procesado
        nuTotalCupones NUMBER := 0; -- total cupones procesados

        -- Obtiene los pagos del dia
        CURSOR cuPagos IS
          SELECT pagocupo,
                 pagovapa,
                 pagofepa,
                 pagofegr,
                 pagobanc,
                 pagosuba,
                 trunc(SYSDATE) fecha_proc
            FROM pagos pg
           WHERE (pagofegr BETWEEN dtFechaIni AND dtFechaFin)
             AND NOT EXISTS (SELECT 1
                    FROM ldc_proPagosDia pr
                   WHERE pr.cupon = pg.pagocupo
                     AND pr.flag_proc = 'N');

        -- Obtiene la ruta para escribir el archivo
        CURSOR cuRutaDest IS
        SELECT REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ARCH_PAGOS_FACTURE'),'[^,]+',1,LEVEL)    tipo_not
        FROM DUAL
        CONNECT BY REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ARCH_PAGOS_FACTURE'),'[^,]+',1,LEVEL) IS NOT NULL;

        -- Obtiene los cupones para la generacion del archivo
        CURSOR cuCuponesDia IS
          SELECT pd.*, pd.rowid idxp
            FROM ldc_proPagosDia pd
           WHERE fecha_proc = dtfechaproc
             AND flag_proc = 'N';

        nuError     NUMBER;
        
        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores'; 
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
 
           IF cuRutaDest%ISOPEN THEN
                CLOSE cuRutaDest;
            END IF;
                        
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;     
        
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pCierraCursores;
        
        -- Fecha inicial para el rango de pagos
        IF idtfechagen IS NULL THEN
          dtFechaIni := trunc(SYSDATE);
        ELSE
          dtFechaIni := trunc(idtfechagen);
        END IF;

        dtFechaFin  := SYSDATE;
        dtfechaproc := trunc(SYSDATE);

        -----
        -- - Manejo escritura de archivos
        ------
        -- Nombres de los archivos Control
        vaNomArchPag   := 'pagos_facture_' ||
                          to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.csv';
        vaLogPagos     := 'Log_pagos_facture_' ||
                          to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.log';
        vacontrolPagos := 'control_pagosfacture_ ' ||
                          to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.txt';

        -- Obtiene la ruta
        OPEN cuRutaDest;
        FETCH cuRutaDest
          INTO vaRutArchPag;
        IF vaRutArchPag IS NULL THEN
          -- muestra error en pantalla
          pkg_error.setErrorMessage( isbMsgErrr => 'No existe parametro de ruta --> LDC_RUTA_ARCH_PAGOS_FACTURE');
        END IF;
        
        CLOSE cuRutaDest;

        -- Apertura de archivos
        fileCtrPagos := UTL_FILE.FOPEN(vaRutArchPag, vacontrolPagos, 'W');
        fileLogPagos := UTL_FILE.FOPEN(vaRutArchPag, vaLogPagos, 'W');
        filePagos    := UTL_FILE.FOPEN(vaRutArchPag, vaNomArchPag, 'W');

        -- se elimina los registros menor a la fecha del proceso
        DELETE ldc_proPagosDia WHERE fecha_proc < dtfechaproc;
        COMMIT;

        -- Se consulta los pagos del dia
        FOR rc_cuPagos IN cuPagos LOOP

          BEGIN

            -- inserta los pagos del dia
            INSERT INTO ldc_proPagosDia
            VALUES
              (rc_cuPagos.pagocupo,
               rc_cuPagos.pagovapa,
               rc_cuPagos.pagofepa,
               rc_cuPagos.pagofegr,
               rc_cuPagos.pagobanc,
               rc_cuPagos.pagosuba,
               rc_cuPagos.fecha_proc,
               'N');
            COMMIT;
          EXCEPTION
            WHEN OTHERS THEN
              sbError := (SUBSTR(SQLERRM, 1, 510) ||
                         '- Error insertando cupon en ldc_proPagosDia ' ||
                         rc_cuPagos.pagocupo);
              utl_file.put_line(fileLogPagos, sbError);
              pkg_Traza.trace(sbError);

          END; -- fin almacenamiento cupones

        END LOOP; -- fin selecciona pagos dia

        -- Generacion de archivo
        BEGIN

          FOR rc_cuCuponesDia IN cuCuponesDia LOOP
            nucupon := rc_cuCuponesDia.cupon;
            -- Armado de la cadena para la escritura del archivo de pagos
            vaCadenaPagos := (rc_cuCuponesDia.cupon || '|' ||
                             rc_cuCuponesDia.valor || '|' ||
                             rc_cuCuponesDia.fecha_pago || '|' ||
                             rc_cuCuponesDia.fecha_grab || '|' ||
                             rc_cuCuponesDia.enti_pago || '|' ||
                             rc_cuCuponesDia.subc_pago);

            utl_file.put_line(filePagos, vaCadenaPagos);

            -- cambia el estado del proceso
            UPDATE ldc_proPagosDia
               SET flag_proc = 'S'
             WHERE ROWID = rc_cuCuponesDia.Idxp;

            -- Total cupones procesados
            nuTotalCupones := nuTotalCupones + 1;

          END LOOP;
          utl_file.put_line(fileCtrPagos, nuTotalCupones);
          UTL_FILE.FCLOSE_ALL;
        EXCEPTION
          WHEN UTL_FILE.INVALID_PATH THEN
            utl_file.put_line(fileLogPagos,
                              '-20051-La ubicación del archivo o el nombre del archivo no son válidos.');

          WHEN UTL_FILE.READ_ERROR THEN
            utl_file.put_line(fileLogPagos,
                              '-20053 Se produjo un error del sistema operativo durante la operación de lectura.');

          WHEN UTL_FILE.INVALID_OPERATION THEN
            utl_file.put_line(fileLogPagos,
                              '-20054-No se pudo abrir ni operar el archivo como se solicitó. Validar permisos');

          WHEN UTL_FILE.INVALID_FILEHANDLE THEN
            utl_file.put_line(fileLogPagos,
                              '-20055-El identificador de archivo no es válido.');

          WHEN UTL_FILE.WRITE_ERROR THEN
            utl_file.put_line(fileLogPagos,
                              '-20056-Se produjo un error del sistema operativo durante la operación de escritura.');

          WHEN OTHERS THEN
            sbError := (SUBSTR(SQLERRM, 1, 510) ||
                       ' Error escribiendo archivo con el cupon ' || nucupon);
            utl_file.put_line(fileLogPagos, sbError);
            pkg_Traza.trace(sbError);

        END; --fin insercion controlada

        UTL_FILE.FCLOSE_ALL;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);        

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;        
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                         
            RAISE pkg_error.Controlled_Error;        
    END ldc_proPagosDia;

    PROCEDURE progenduplifac
    /**********************************************************************
      Propiedad intelectual de CSC
      Nombre   progenduplifac
      Autor    Carlos Gonzalez
      Fecha   28/08/2017

      Descripcion: Procedimiento que Crea el Archivo Plano de los
                   Duplicados Generados

      Historia de Modificaciones
      Fecha             Autor             Modificacion
     ============    ============       ========================
     28/08/2017       cgonzalezv        1. Creacion
    ***********************************************************************/
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'progenduplifac';  
        
        nuCont     number := 0;
        dtFechaIni date;
        nuCupon    number;
        nuValor    number;
        sbCliente  varchar2(200);
        sbIdent    varchar2(20);
        sbError    VARCHAR2(4000);

        vanomfileDupli VARCHAR2(2000); -- Archivo de control de duplicados
        fileDuplicados UTL_FILE.FILE_TYPE; -- archivo de duplicados
        fileLogDupl    UTL_FILE.FILE_TYPE; -- archivo log de duplicados
        fileCtrDupl    UTL_FILE.FILE_TYPE; -- archivo de control de duplicados
        vaRutaDestDupl VARCHAR2(3000); -- Ruta destino de duplicados
        vaLogDupli     VARCHAR2(2000); -- Archivo de log de duplicados
        sbcadenadupl   VARCHAR2(2000); -- cadena archivo de duplicados
        vacontroldupl  VARCHAR2(2000); -- Archivo de control de duplicados
        nuCantCupones  NUMBER := 0; -- Cantidad de cupones procesados

        -- cursor solicitudes duplicado
        CURSOR cuSolicitudes is
          select mo_packages.package_id, subscription_id
            from mo_packages, mo_motive
           where mo_packages.package_id = mo_motive.package_id
             and request_date >= dtFechaIni
             and request_date <= sysdate
             and package_type_id in
             (
                SELECT TO_NUMBER( REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_TRAMITES_FACTURE'),'[^,]+',1,LEVEL))
                FROM DUAL
                CONNECT BY REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_TRAMITES_FACTURE'),'[^,]+',1,LEVEL) IS NOT NULL             
            ) 
             and not exists (select 1
                    from ldc_duplifact
                   where solicitud = mo_packages.package_id
                     and Flag = 'S');

        -- Cursor, consulta los cupones del contrato
        cursor cuCupon(inuContrato number) is
          select max(cuponume)
            from cupon
           where cuposusc = inuContrato
             and cupotipo = 'FA'
             and cupoprog = 'FIDF';

        -- consulta los datos del cliente
        cursor cuDatos(inuContrato number) is
          select subscriber_name || ' ' || subs_last_name, identification
            from ge_subscriber, suscripc
           where suscclie = subscriber_id
             and susccodi = inuContrato
             and rownum < 2;

        -- Obtiene la ruta del archivo
        CURSOR cuRutaDest IS
            SELECT REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ARCH_DUPLICA_FACTURE'),'[^,]+',1,LEVEL)
            FROM DUAL
            CONNECT BY REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ARCH_DUPLICA_FACTURE'),'[^,]+',1,LEVEL) IS NOT NULL;

        -- Cursor de cupones por duplicados sin procesar
        CURSOR cuCupones IS
          SELECT contrato,
                 identificacion,
                 usuario,
                 cupon,
                 valor_cupon,
                 ROWID idxdupl
            FROM ldc_duplifact
           WHERE flag = 'N';
           
        nuError     NUMBER;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);   
        
        dtFechaIni := to_Date(to_char(trunc(sysdate)), 'dd/mm/yyyy hh24:mi:ss');

        --<<
        -- Para el manejo del archivo plano
        -->>
        -- Nombres de los archivos Control
        vanomfileDupli := 'duplicados_' ||
                          to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.csv';
        vaLogDupli     := 'log_duplicados_' ||
                          to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.log';
        vacontroldupl  := 'control_duplicados_' ||
                          to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.txt';

        -- Obtiene la ruta
        OPEN cuRutaDest;
        FETCH cuRutaDest
          INTO vaRutaDestDupl;
        IF vaRutaDestDupl IS NULL THEN
          -- muestra error en pantalla
          pkg_error.setErrorMessage( isbMsgErrr => 'No existe parametro de ruta --> LDC_RUTA_DEST_ARCH_FACTURAS');
        END IF;
        CLOSE cuRutaDest;

        -- Apertura de archivos
        fileDuplicados := UTL_FILE.FOPEN(vaRutaDestDupl, vanomfileDupli, 'W');
        fileLogDupl    := UTL_FILE.FOPEN(vaRutaDestDupl, vaLogDupli, 'W');
        fileCtrDupl    := UTL_FILE.FOPEN(vaRutaDestDupl, vacontroldupl, 'W');

        -- consultar las soliciutdes de duplicado
        FOR rc IN cuSolicitudes LOOP

          -- consultar los cupones
          open cuCupon(rc.subscription_id);
          fetch cuCupon
            into nuCupon;
          if cuCupon%NOTFOUND THEN
            nuCupon := null;
          end if;
          close cuCupon;

          -- consultar valor cupon
          if (nuCupon is not null) then
            nuValor := pktblcupon.fnugetcupovalo(nuCupon);

            -- consultar datos cliente
            open cuDatos(rc.subscription_id);
            fetch cuDatos
              into sbCliente, sbIdent;
            if cuDatos%NOTFOUND THEN
              sbIdent   := '-1';
              sbCliente := null;
            end if;
            close cuDatos;

            -- Se registran los datos en la tabla proceso
            begin
              insert into LDC_DUPLIFACT
              values
                (rc.package_id,
                 rc.subscription_id,
                 sbCliente,
                 sbIdent,
                 nuCupon,
                 nuValor,
                 sysdate,
                 'N');

            EXCEPTION
              WHEN OTHERS THEN
                sbError := (SUBSTR(SQLERRM, 1, 510) || ' package_id ' ||
                           rc.package_id || ' subscription_id ' ||
                           rc.subscription_id);
                utl_file.put_line(fileLogDupl, sbError);
                pkg_Traza.trace(sbError);
            end;

            nuCont := nuCont + 1;

            if MOD(nuCont, 100) = 0 then
              commit;
            end if;
          end if;

        END LOOP;
        commit;

        -- Generacion archivo plano
        -- crea los archivos
        FOR rccuCupones IN cuCupones LOOP

          -- arma la cadena de escritura
          sbcadenadupl := rccuCupones.contrato || '|' ||
                          rccuCupones.identificacion || '|' ||
                          rccuCupones.usuario || '|' || rccuCupones.cupon || '|' ||
                          rccuCupones.valor_cupon;

          BEGIN
            -- Escritura del archivo
            utl_file.put_line(fileDuplicados, sbcadenadupl);

            -- Actualiza como procesado
            UPDATE ldc_duplifact
               SET flag = 'S'
             WHERE ROWID = rccuCupones.Idxdupl;

            -- Cantidad de cupones procesados
            nuCantCupones := nuCantCupones + 1;

          EXCEPTION
            WHEN UTL_FILE.INVALID_PATH THEN
              utl_file.put_line(fileLogDupl,
                                '-20051-La ubicación del archivo o el nombre del archivo no son válidos.');

            WHEN UTL_FILE.READ_ERROR THEN
              utl_file.put_line(fileLogDupl,
                                '-20053 Se produjo un error del sistema operativo durante la operación de lectura.');

            WHEN UTL_FILE.INVALID_OPERATION THEN
              utl_file.put_line(fileLogDupl,
                                '-20054-No se pudo abrir ni operar el archivo como se solicitó. Validar permisos');

            WHEN UTL_FILE.INVALID_FILEHANDLE THEN
              utl_file.put_line(fileLogDupl,
                                '-20055-El identificador de archivo no es válido.');

            WHEN UTL_FILE.WRITE_ERROR THEN
              utl_file.put_line(fileLogDupl,
                                '-20056-Se produjo un error del sistema operativo durante la operación de escritura.');

            WHEN OTHERS THEN
              sbError := SUBSTR(SQLERRM, 1, 510);
              utl_file.put_line(fileLogDupl, sbError);
              pkg_Traza.trace(sbError);

          END; -- Fin escritura del archivo plano

        END LOOP;

        -- escritura del archivo de control
        utl_file.put_line(fileCtrDupl, nuCantCupones);
        UTL_FILE.FCLOSE_ALL;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);           

    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);                    
            sbError := SUBSTR(sbError, 1, 510);
            utl_file.put_line(fileLogDupl, sbError);
            UTL_FILE.FCLOSE_ALL;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);                    
            sbError := SUBSTR(sbError, 1, 510);
            utl_file.put_line(fileLogDupl, sbError);
            UTL_FILE.FCLOSE_ALL;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END progenduplifac;

    FUNCTION fnuValEstadoFIDF(ivaPerifact VARCHAR2)
    /**********************************************************************************
     Propiedad intelectual de CSC. (C).

     Unidad      : fnuValEstadoFIDF
     Descripcion : funcion encargado de validar los archivos de la facturacion
                   recurrente si estan en ejecucion para los periodos
                   ingresados.

     Autor     : Carlos Humberto Gonzalez
     Fecha     : 28-08-2017

     Historia de Modificaciones
     DD-MM-YYYY    <Autor>               Modificacion
     -----------  -------------------    -------------------------------------
     28-08-2017    cgonzalezv            Creacion.
    **********************************************************************************/
    RETURN NUMBER IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuValEstadoFIDF';  
        
        --<<
        -- Variables
        nuPeriodoFact perifact.pefacodi%TYPE; -- periodo de facturacion
        nuCantHiloEje NUMBER; -- Cantidad de hilos en ejecuiocn
        nuTotaHiloEje NUMBER; -- Total de hilos en ejecuiocn
        --<<
        -- Obtiene los periodos de facturacion
        -->>
        CURSOR cuPeriodos IS
          SELECT pefacodi
            FROM perifact
           WHERE ',' || ivaPerifact || ',' LIKE '%,' || pefacodi || ',%';

        -- Cantidad de hilos en ejecucion por periodo
        CURSOR cuArchEjec(inuPeriodo IN perifact.pefacodi%TYPE) IS
          SELECT Count(*) cantejec
            FROM estaprog es
           WHERE es.esprpefa = inuPeriodo
             AND es.esprprog LIKE ('FIDF%')
             AND es.esprporc <> 100;

        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores'; 
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
 
           IF cuPeriodos%ISOPEN THEN
                CLOSE cuPeriodos;
            END IF;

           IF cuArchEjec%ISOPEN THEN
                CLOSE cuArchEjec;
            END IF;
                                                
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;                
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pCierraCursores;  

        -- inicia los hilos en ejecucion por periodo
        nuTotaHiloEje := 0;
        nuCantHiloEje := 0;
        gvaMensaje    := NULL;

        -- Obtiene los periodo de facturacion
        OPEN cuPeriodos;
        LOOP
          FETCH cuPeriodos
            INTO nuPeriodoFact;
          EXIT WHEN cuPeriodos%NOTFOUND;

          OPEN cuArchEjec(nuPeriodoFact);
          FETCH cuArchEjec
            INTO nuCantHiloEje;
          IF nuCantHiloEje IS NULL THEN
            nuCantHiloEje := 0;
          END IF;
          CLOSE cuArchEjec;

          IF nuCantHiloEje > 0 THEN

            gvaMensaje := gvaMensaje || nuPeriodoFact || ', ';
          END IF;

          -- hilos en ejecucion
          nuTotaHiloEje := nuTotaHiloEje + nuCantHiloEje;

        END LOOP; -- fin cantidad de periodos
        CLOSE cuPeriodos;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN(nuTotaHiloEje);
        
      EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Periodo: ' || nuPeriodoFact, csbNivelTraza);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Periodo: ' || nuPeriodoFact, csbNivelTraza);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error; 
    END fnuValEstadoFIDF;

    PROCEDURE proCopiaArchFIDF
    /**********************************************************************************
     Propiedad intelectual de CSC. (C).

     Unidad      : proCopiaArchFIDF
     Descripcion : procedimiento encargado de copiar los archivo en las rutas definidas
                   en parametros.


     Autor     : Carlos Humberto Gonzalez
     Fecha     : 25-08-2017

     Historia de Modificaciones
     DD-MM-YYYY    <Autor>               Modificacion
     -----------  -------------------    -------------------------------------
     25-08-2017    cgonzalezv            Creacion.
     22-05-2018    STapias              REQ.2001859 - Se implementa modificacion para
                                        que al copiar los archivos se concatene el nombre
                                        del departamento al que pertenece el PERIFACT
    25/07/2018    Jorge Valiente        CASO 200-2033: Establecer logica para unificar los archivo
                                                       generados por el proceso de copiado a un ruta del
                                                       FTP
    17/08/2018    Daniel Valiente       Caso 200-2033: Se agrego el nombre del departamento al unificado
    19/09/2018    Daniel Valiente       Caso 200-2033: Se agrego modifica para soportar la creacion de
                                                       varios unificados
    31-10-18      Daniel Valiente       Caso 200-2203: Correccion Encabezado por unificado
	12-05-2022     LJLB                  CA OSF-295 se modifica forma de consultar el periodo de facturacion del nombre del archivo
	                                     con el fin que obtenga correctamente el periodo sin importar el tamaño.
    26/10/2023      jpinedc             OSF-1701: Se reemplaza UNIFICADO en el nombre del
                                        archivo la posición 5 del nombre del archivo es 
                                        CARTAS  
    **********************************************************************************/
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proCopiaArchFIDF';  
        
        --<<
        -- Variables
        -->>
        vaRutaDestino VARCHAR2(4000); -- Ruta destino para el copiado de archivos

        --<<
        -- Cursor para obtener las rutas destinos
        --->>
        --2033 10.09.18 Se creara el unificado en la ruta de Origen
        CURSOR cuRutaDest IS
            SELECT REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS'),'[^,]+',1,LEVEL)
            FROM DUAL
            CONNECT BY REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS'),'[^,]+',1,LEVEL) IS NOT NULL;

        dtFechaEje date := to_date('01/01/1900','dd/mm/yyyy'); 
        dtFechaEjep date;
        TBSTRING   ut_string.TYTB_STRING;
        sbSeparador VARCHAR2(1) := '_';
 
        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores'; 
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
 
            IF cuRutaDest%ISOPEN THEN
                CLOSE cuRutaDest;
            END IF;
                         
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;                
           
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        pCierraCursores;
        
        gvaMensaje := ('ldc_pkgOSFFacture.proCopiaArchFIDF');

        --<<
        -- Ruta de los archivos
        -->>
        pkg_Traza.trace('Ruta de Archivos');
        OPEN cuRutaDest;
        LOOP
          FETCH cuRutaDest
            INTO vaRutaDestino;
          EXIT WHEN cuRutaDest%NOTFOUND;

          -- Realiza el proceso de seleccion de archivos por periodo
          -- Archivos a copiar
          FOR idx IN 1 .. tbtypNombArchPeri.count LOOP

            gvaMensaje := ('ldc_pkgOSFFacture.proCopiaArchFIDF  ->' ||
                          tbtypNombArchPeri(idx));
            -----------------
            --REQ.2001859 -->
            /*Obs: Se comenta el servicio anterior
            y se llama al mismo servicio pero con el nuevo valor del archivo de destino
            haciendo uso de la nueva variable con el nombre de departamento*/
            -----------------

            -- Copiado de Archivos
            pkg_Traza.trace('Copiado de Archivos. Ruta:' || gvarutarch ||
                                 ' - ' || tbtypNombArchPeri(idx));
            pkg_Traza.trace('Destino de Archivos. Ruta:' || vaRutaDestino ||
                                 ' - ' || tbtypNombArchPeriDepa(idx));
            utl_file.fcopy(src_location  => gvarutarch,
                           src_filename  => tbtypNombArchPeri(idx),
                           dest_location => vaRutaDestino,
                           dest_filename => tbtypNombArchPeriDepa(idx) --Nuevo Nombre
                           );
            pkg_Traza.trace('Fin de Copiado');
            -----------------
          --REQ.2001859 <--
          -----------------

          END LOOP;
        END LOOP;
        CLOSE cuRutaDest;

        --Inicio UNIFICACION DE ARCHIVOS DEL PERIODO DE FACTURACION
        ------Inicio CASO 200-2033

        OPEN cuRutaDest;
        LOOP
          FETCH cuRutaDest
            INTO vaRutaDestino;
          EXIT WHEN cuRutaDest%NOTFOUND;

          NuEncabezado := 0;
          pkg_Traza.trace('NuEncabezado[' || NuEncabezado || ']');
          FOR idx IN 1 .. tbtypNombArchPeri.count LOOP
             
            TBSTRING.DELETE;
            ut_string.EXTSTRING(tbtypNombArchPeriDepa(idx), sbSeparador , TBSTRING);
             
            
            NuPeriodoP := TBSTRING(2);
            dtFechaEjep := to_date(TBSTRING(3), 'DD/MM/YYYY');
            pkg_Traza.trace(' NuPeriodoP '||NuPeriodoP||' dtFechaEjep '||dtFechaEjep,10);
            --FIN CA OSF-295
            if NuPeriodo <> NuPeriodoP or ( NuPeriodo =  NuPeriodoP  and dtFechaEje <> dtFechaEjep) then
              --Caso 200-2203 - DVM Encabezado por archivo unificado
              NuEncabezado := 0;
              --
              pkg_Traza.trace(' NuPeriodo '||NuPeriodo||' dtFechaEje '||dtFechaEje,10);
              NuPeriodo := NuPeriodoP;
              dtFechaEje := dtFechaEjep;
              
              --Caso 200-2033 Daniel Valiente
              SBNOMDEPAR := SubStr(tbtypNombArchPeriDepa(idx),
                                   instr(tbtypNombArchPeriDepa(idx), '_', 1, 6) + 1,
                                   length(tbtypNombArchPeriDepa(idx)));
              --
              SBNOMARCUNI := SubStr(tbtypNombArchPeriDepa(idx),
                                    1,
                                    instr(tbtypNombArchPeriDepa(idx), '_', 1, 4)) ||
                             'UNIFICADO_' || SBNOMDEPAR; --Caso 200-2033 Daniel Valiente: Agrego el nombre del Departamento
              
              IF TBSTRING(5) = 'CARTAS' THEN
                SBNOMARCUNI := REPLACE( SBNOMARCUNI, 'UNIFICADO', 'CARTAS' );
              END IF; 
              
              NuUnificado := NuUnificado + 1;
              tbtypNombArchPeriDepaUnificado(NuUnificado) := SBNOMARCUNI;
              --tbtypNombArchPeriDepa(tbtypNombArchPeri.count + 1) := SBNOMARCUNI;
              pkg_Traza.trace('Creacion Unificado 1');
              if utl_file.is_open(FILEUNIFICADO) then
                UTL_FILE.FCLOSE(FILEUNIFICADO);
                pkg_Traza.trace('File Closed FILEUNIFICADO');
              end if;
              FILEUNIFICADO := UTL_FILE.FOPEN(vaRutaDestino,
                                              SBNOMARCUNI,
                                              'W',
                                              32767);
              pkg_Traza.trace('Ruta Unificado[' || vaRutaDestino ||
                                   '] - Archivo[' || SBNOMARCUNI || ']');
              --Indice para vector de unificados
              if (NuIndice > 0) then
                tbtLinea(NuIndice) := Templinedata;
              end if;
              NuIndice := NuIndice + 1;
              tbtUnificado(NuIndice) := SBNOMARCUNI;
              --
            end if;

            pkg_Traza.trace('Ruta Contenedor[' || vaRutaDestino ||
                                 '] - Archivo[' || tbtypNombArchPeriDepa(idx) || ']');
            filehandler := utl_file.fopen(vaRutaDestino,
                                          tbtypNombArchPeriDepa(idx),
                                          'R',
                                          32767);

            pkg_Traza.trace('File Opened');
            if utl_file.is_open(filehandler) then
              pkg_Traza.trace('File is open');
              NuEncabezadoRegistro := 0;
              loop
                begin
                  linedata := null;
                  utl_file.get_line(filehandler, linedata, 32767);
                  IF TRIM(linedata) IS NOT NULL THEN
                    if NuEncabezadoRegistro = 0 then
                      if NuEncabezado = 0 then
                        UTL_FILE.PUT_LINE(FILEUNIFICADO, linedata);
                        NuEncabezado := 1;
                      end if;
                      NuEncabezadoRegistro := 1;
                    else
                      UTL_FILE.PUT_LINE(FILEUNIFICADO, linedata);
                      Templinedata := linedata;
                    end if;
                  END IF;
                exception
                  when no_data_found then
                    pkg_Traza.trace('No Data Found');
                    exit;
                  when others then
                    pkg_Traza.trace(sqlerrm);
                end;
              end loop;

              utl_file.fclose(filehandler);
              pkg_Traza.trace('File Closed filehandler');

            end if;
            --------------
          END LOOP;

        END LOOP;

        --vector de comparacion
        if (NuIndice > 0) then
          tbtLinea(NuIndice) := Templinedata;
        end if;

        if utl_file.is_open(FILEUNIFICADO) then
          UTL_FILE.FCLOSE(FILEUNIFICADO);
          pkg_Traza.trace('File Closed FILEUNIFICADO');
        end if;

        CLOSE cuRutaDest;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);      

  EXCEPTION

    WHEN UTL_FILE.INVALID_PATH THEN
      pkg_Traza.trace('Error 1');
      fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
      utl_file.put_line(fileLog,
                        '-20051-La ubicación del archivo o el nombre del archivo no son válidos.');
      utl_file.fclose(fileLog);
      UTL_FILE.FCLOSE_ALL;
      NuLOG := -1;
      pCierraCursores;

    WHEN UTL_FILE.READ_ERROR THEN
      pkg_Traza.trace('Error 2');
      fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
      utl_file.put_line(fileLog,
                        '-20053 Se produjo un error del sistema operativo durante la operación de lectura.');
      utl_file.fclose(fileLog);
      UTL_FILE.FCLOSE_ALL;
      NuLOG := -1;
      pCierraCursores;      

    WHEN UTL_FILE.INVALID_OPERATION THEN
      pkg_Traza.trace('Error 3');
      fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
      utl_file.put_line(fileLog,
                        '-20054- No se pudo abrir ni operar el archivo como se solicitó.');
      utl_file.fclose(fileLog);
      UTL_FILE.FCLOSE_ALL;
      NuLOG := -1;
      pCierraCursores;      

    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
      pkg_Traza.trace('Error 4');
      fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
      utl_file.put_line(fileLog,
                        '-20055-El identificador de archivo no es válido.');
      utl_file.fclose(fileLog);
      UTL_FILE.FCLOSE_ALL;
      NuLOG := -1;
      pCierraCursores;      

    WHEN UTL_FILE.WRITE_ERROR THEN
        pkg_Traza.trace('Error 5');
        fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
        utl_file.put_line(fileLog,
                        '-20056-Se produjo un error del sistema operativo durante la operación de escritura.');
        utl_file.fclose(fileLog);
        UTL_FILE.FCLOSE_ALL;
        NuLOG := -1;
        pCierraCursores;        

    WHEN Others THEN
        pkg_Traza.trace('Error 6');
        fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
        utl_file.put_line(fileLog,
                        'Error copiando archivo ' || gvaMensaje || ' ' ||
                        SQLERRM);
        utl_file.fclose(fileLog);
        UTL_FILE.FCLOSE_ALL;
        NuLOG := -1;
        pCierraCursores;        
    END proCopiaArchFIDF;

    PROCEDURE proObjecArch(ivadirectorio IN OUT VARCHAR2,
                         ovanombrarch  out sys_refcursor)
    /**********************************************************************************
     Propiedad intelectual de CSC. (C).

     Unidad      : proObjecArch
     Descripcion : procedimiento encargado instanciar los archivos.

     Autor     : Carlos Humberto Gonzalez
     Fecha     : 22-08-2017

     Historia de Modificaciones
     DD-MM-YYYY    <Autor>               Modificacion
     -----------  -------------------    -------------------------------------
     22-08-2017    cgonzalezv            Creacion.
    **********************************************************************************/
    IS
   
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proObjecArch';    

        --<<
        -- Variables
        -->>
        ofiles VARCHAR2(1024); -- variable para el majeno de archivos
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);      

        ofiles       := NULL;
        ovanombrarch := NULL;

        -- se obtiene el nombre de los archivos
        SYS.DBMS_BACKUP_RESTORE.searchFiles(ivadirectorio, ofiles);
        OPEN ovanombrarch FOR
          SELECT FNAME_KRBMSFT FROM sys.ldc_files order by FNAME_KRBMSFT;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
        
      EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Directorio: ' || ivadirectorio, csbNivelTraza);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Directorio: ' || ivadirectorio, csbNivelTraza);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error; 
    END proObjecArch;

    PROCEDURE proListArchFIDF(ivaPerifact VARCHAR2)
  /**********************************************************************************
     Propiedad intelectual de CSC. (C).

     Unidad      : proListArchFIDF
     Descripcion : procedimiento encargado de listar los archivos de la facturacion
                   recurrente.

     Autor     : Carlos Humberto Gonzalez
     Fecha     : 22-08-2017

     Historia de Modificaciones
     DD-MM-YYYY    <Autor>               Modificacion
     -----------  -------------------    -------------------------------------
     22-08-2017    cgonzalezv            Creacion.
     22-05-2018    STapias              REQ.2001859 - Se implementa modificacion para
                                        que al copiar los archivos se concatene el nombre
                                        del departamento al que pertenece el PERIFACT
    **********************************************************************************/
   IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proListArchFIDF';  
        
        --<<
        -- Variables
        -->>
        rfcArch       SYS_REFCURSOR; -- Obtiene nombre archivo con la ruta
        varchnomb     VARCHAR2(2000); -- contiene el nombre del archivo al momento de extraer la ruta
        nulongRuta    NUMBER; -- longitud de cadena para la ruta
        nuPosDirec    NUMBER; -- cantidad de caracteres hasta el ultimo directorio
        nuPeriodoFact perifact.pefacodi%TYPE; -- periodo de facturacion

        nuCantReg NUMBER := 0; -- cantidad de registros
        -----------------
        --REQ.2001859 -->
        --Obs: Variables.
        -----------------
        sbDepartamento ge_geogra_location.description%TYPE := NULL;
        -----------------
        --REQ.2001859 <--
        -----------------

        --<<
        -- Obtiene los periodos de facturacion
        -->>
        CURSOR cuPeriodos IS
          SELECT pefacodi
            FROM perifact
           WHERE ',' || ivaPerifact || ',' LIKE '%,' || pefacodi || ',%';
           
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
        
        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores'; 
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
 
            IF cuPeriodos%ISOPEN THEN
                CLOSE cuPeriodos;
            END IF;
                         
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;          

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        pCierraCursores;
        
        gvarutarch := dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS');

        -- Instancia los archivos para listarlos
        proObjecArch(gvarutarch, rfcArch);

        -- A partir -del nombre de los archivos con la ruta completa
        LOOP
          FETCH rfcArch
            INTO varchnomb;
          EXIT WHEN rfcArch%NOTFOUND;

          -- Cantidad de archivos
          nuCantReg := nuCantReg + 1;

          -- Obtiene la cantidad de caracteres de toda la cadena
          nulongRuta := length(varchnomb);

          -- cantidad de caracteres hasta el ultimo directorio
          nuPosDirec := Length(RTRIM(varchnomb,
                                     'ABCDEFGHIJKLMNOPQRSTXYZabcdefghijklmnopqrstxyz._0123456789'));

          -- Extrae el nombre del archivo
          tbtypNombArch(nuCantReg) := SubStr(varchnomb, nuPosDirec + 1);

        END LOOP;

        -- Obtiene los periodo de facturacion
        OPEN cuPeriodos;
        LOOP
          FETCH cuPeriodos
            INTO nuPeriodoFact;
          EXIT WHEN cuPeriodos%NOTFOUND;
          -----------------
          --REQ.2001859 -->
          /*Obs: Se obtiene el nombre del departamento
          Segun el periodo de facturacion.*/
          -----------------
          sbDepartamento := Ldc_FsbDeptoPeriFact(nuPeriodoFact);
          pkg_Traza.trace('ldc_pkgOSFFacture.proListArchFIDF --> sbDepartamento[' ||
                         sbDepartamento || ']',
                         10);
          -----------------
          --REQ.2001859 <--
          -----------------
          -- Obtiene el nombre de los archivos segun el periodo y se almacena en memoria tbtypNombArchPeri
          FOR idx1 IN 1 .. tbtypNombArch.count LOOP

            IF tbtypNombArch(idx1) LIKE 'FIDF_' || nuPeriodoFact || '%' THEN

              gnuCantArhPeri := gnuCantArhPeri + 1;
              tbtypNombArchPeri(gnuCantArhPeri) := TRIM(tbtypNombArch(idx1));
              -----------------
              --REQ.2001859 -->
              /*Obs: Se asigna el nombre a la variable espejo,
              se concatena el nombre del departamento*/
              -----------------
              tbtypNombArchPeriDepa(gnuCantArhPeri) := TRIM(tbtypNombArch(idx1)) || '_' ||
                                                       sbDepartamento;
              -----------------
              --REQ.2001859 <--
              -----------------

            END IF;
          END LOOP; -- fin obtiene nombre periodo

        END LOOP; -- fin cantidad de periodos
        CLOSE cuPeriodos;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);          
 
      EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Directorio: ' || gvarutarch, csbNivelTraza);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Directorio: ' || gvarutarch, csbNivelTraza);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error;  
    END proListArchFIDF;

    PROCEDURE proComparaArchFIDF
    /**********************************************************************************
     Propiedad intelectual de CSC. (C).

     Unidad      : proComparaArchFIDF
     Descripcion : procedimiento encargado de comparar los archivo en las rutas definidas
                   en parametros.


     Autor     : Carlos Humberto Gonzalez
     Fecha     : 28-08-2017

     Historia de Modificaciones
     DD-MM-YYYY    <Autor>               Modificacion
     -----------  -------------------    -------------------------------------
     28-08-2017    cgonzalezv            Creacion.
     22-05-2018    STapias              REQ.2001859 - Se implementa modificacion para
                                        que al verificar los archivos se tenga en cuenta el nombre
                                        del departamento al que pertenece el PERIFACT
    25/07/2018    Jorge Valiente        CASO 200-2033: Varoable de control para mostrar mensaje de error.
    **********************************************************************************/
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proComparaArchFIDF';  
        
        --<<
        -- Variables
        -->>
        vaRutaDestino VARCHAR2(4000); -- Ruta destino para el copiado de archivos
        vaRutaOrigen  VARCHAR2(4000); -- Ruta origen para el copiado de archivos

        vanomfileCtrl VARCHAR2(400); -- archivo de control

        -- Variables requeridas para el UTL destino
        l_file_dest_exists BOOLEAN;
        l_file_dest_len    NUMBER;
        l_dest_blocksize   BINARY_INTEGER;

        -- Variables requeridas para el UTL origen
        l_file_orig_exists BOOLEAN;
        l_file_orig_len    NUMBER;
        l_orig_blocksize   BINARY_INTEGER;

        --<<
        -- Cursor para obtener las rutas destinos
        --->>
        CURSOR cuRutaDest IS
            SELECT REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS'),'[^,]+',1,LEVEL)
            FROM DUAL
            CONNECT BY REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS'),'[^,]+',1,LEVEL) IS NOT NULL;

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
 
            IF cuRutaDest%ISOPEN THEN
                CLOSE cuRutaDest;
            END IF;
            
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;   

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        pCierraCursores; 
        
        -- Ruta Origen
        vaRutaOrigen := dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS');

        -- Nombres de los archivos Control
        vanomfileCtrl := 'CONTROL_FIDF_FACTURE' ||
                         to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.csv';


        FOR idx IN 1 .. tbtypNombArchPeri.count LOOP
          pkg_Traza.trace('COMPARA ARCHIVO _1');

          gvaMensaje := ('ldc_pkgOSFFacture.proComparaArchFIDF Archivo ->' ||
                        tbtypNombArchPeri(idx));

          --<<
          -- Ruta de los archivos Destinos
          -->>
          OPEN cuRutaDest;
          LOOP
            FETCH cuRutaDest
              INTO vaRutaDestino;
            EXIT WHEN cuRutaDest%NOTFOUND;
            pkg_Traza.trace('COMPARA ARCHIVO _2');

            -----------------------------------------------------------------
            --REQ.2001859 -->
            /*Obs: Se comentan servicios y se llama al mismo servicio,
            pero con el nuevo valor del archivo de destino
            haciendo uso de la nueva variable con el nombre de departamento*/
            -----------------------------------------------------------------

            -- Obtiene las propiedas del archivo copiado
            utl_file.fgetattr(location    => vaRutaDestino,
                              filename    => tbtypNombArchPeriDepa(idx), --Nueva variable.
                              fexists     => l_file_dest_exists,
                              file_length => l_file_dest_len,
                              block_size  => l_dest_blocksize);

            -- Obtiene las propiedas del archivo origen
            utl_file.fgetattr(location    => vaRutaOrigen,
                              filename    => tbtypNombArchPeri(idx),
                              fexists     => l_file_orig_exists,
                              file_length => l_file_orig_len,
                              block_size  => l_orig_blocksize);

            IF l_file_dest_exists THEN

              pkg_Traza.trace('COMPARA ARCHIVO _3');

              pkg_Traza.trace('archivo existe', 10);
            ELSE
              pkg_Traza.trace('COMPARA ARCHIVO _4');
              fileCtrl := UTL_FILE.FOPEN(vaRutaDestino, vanomfileCtrl, 'W');

              pkg_Traza.trace('File not found.');

              utl_file.put_line(fileCtrl,
                                tbtypNombArchPeriDepa(idx) || '|' || 1); --Nueva variable

              UTL_FILE.FCLOSE(fileCtrl);

              NuControl := -1;

            END IF;
            -----------------
            --REQ.2001859 <--
            -----------------
          END LOOP; -- fin rutas destinos
          CLOSE cuRutaDest;
        END LOOP; -- fin cantidad de arhchivos
        UTL_FILE.FCLOSE_ALL;
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);      

    EXCEPTION
        WHEN UTL_FILE.INVALID_PATH THEN
            --UTL_FILE.FCLOSE(fileLog);
            fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
            utl_file.put_line(fileLog,
                            '-20051-La ubicación del archivo o el nombre del archivo no son válidos.');
            utl_file.fclose(fileLog);
            UTL_FILE.FCLOSE_ALL;
            NuControl := -1;
            pCierraCursores;

        WHEN UTL_FILE.READ_ERROR THEN
            fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
            utl_file.put_line(fileLog,
                            '-20053 Se produjo un error del sistema operativo durante la operación de lectura.');
            utl_file.fclose(fileLog);
            UTL_FILE.FCLOSE_ALL;
            NuLOG := -1;
            pCierraCursores;

        WHEN UTL_FILE.INVALID_OPERATION THEN
            fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
            utl_file.put_line(fileLog,
                            '-20054-No se pudo abrir ni operar el archivo como se solicitó.');
            utl_file.fclose(fileLog);
            UTL_FILE.FCLOSE_ALL;
            NuLOG := -1;
            pCierraCursores;

        WHEN UTL_FILE.INVALID_FILEHANDLE THEN
            fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
            utl_file.put_line(fileLog,
                            '-20055-El identificador de archivo no es válido.');
            utl_file.fclose(fileLog);
            UTL_FILE.FCLOSE_ALL;
            NuLOG := -1;
            pCierraCursores;

        WHEN UTL_FILE.WRITE_ERROR THEN
            fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
            utl_file.put_line(fileLog,
                            '-20056-Se produjo un error del sistema operativo durante la operación de escritura.');
            utl_file.fclose(fileLog);
            UTL_FILE.FCLOSE_ALL;
            NuLOG := -1;
            pCierraCursores;

        WHEN Others THEN
            fileLog := UTL_FILE.FOPEN(vaRutaDestino, gvanomfileLog, 'A');
            utl_file.put_line(fileLog, SQLERRM);
            utl_file.fclose(fileLog);
            UTL_FILE.FCLOSE_ALL;
            NuLOG := -1;
            pCierraCursores;

    END proComparaArchFIDF;

    PROCEDURE proExeCopyArchFIDF
    /**********************************************************************************
     Propiedad intelectual de CSC. (C).

     Unidad      : proExeCopyArchFIDF
     Descripcion : procedimiento encargado de recibir los periodos de facturacion en
                   formato cadena.


     Autor     : Carlos Humberto Gonzalez
     Fecha     : 22-08-2017

     Historia de Modificaciones
     DD-MM-YYYY    <Autor>               Modificacion
     -----------  -------------------    -------------------------------------
     22-08-2017    cgonzalezv            Creacion.
     18-05-2018    STapias               REQ.2001859 Formateo de variable temporal.
     25/07/2018    Jorge Valiente        CASO 200-2033: Establecer logica para mostrar mensajes de error
     10-09-2018    Daniel Valiente       Caso 200-2033: Se agrego el procedimiento que copia el unificado en las rutas
                                         especificada en el parametro
     10-09-2018    Daniel Valiente       Se bloqueo la rutina de proComparaArchivos
	 19/12/2019    Horbath               ca 27 se llama a proceso PRGENACTIIMPCAR el cual genera orden 
	                                     orden de impresion de cartas.
	 26/07/2021    Horbath               caso:802 se eliman el llamdo al procedimiento proEnviaCorreo.									 
	 26/10/2023    Jpinedc               OSF-1701: Ejecuta pgenSpoolCartasContSinFact
    **********************************************************************************/
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proExeCopyArchFIDF';  
        
        --<<
        -- Variables
        nuCantHilosEjec NUMBER; -- Cantidad de hilos en ejecucion
        vaErrorHiloEjec VARCHAR2(4000); --mensaje de error cuando hay archivos en proceso de generacion
        sbPERIODO       VARCHAR2(4000); -- instancia el periodo de facturacion
        
        --INICIO CA 27
        nujob NUMBER;
        sbWhat VARCHAR2(4000);
        --FIN CA 27
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);        

        -- Obtener de instancias en el proceso
        sbPERIODO := ge_boInstanceControl.fsbGetFieldValue('CC_FILE',
                                                           'OBSERVATION');

        -- Cantidad de archivos por periodo
        tbtypNombArch.delete; -- tabla en memorio donde estan los nombres de los archivos
        tbtypNombArchPeri.delete; -- tabla en memorio donde estan los nombres de los archivos por periodo
        ------------------------------------------------
        --REQ.2001859 -->
        --Obs: Tabla espejo con nombres de departamento.
        ------------------------------------------------
        tbtypNombArchPeriDepa.delete; -- Se setea la variable.
        -----------------
        --REQ.2001859 <--
        -----------------
        gvarutarch     := NULL; -- ruta origen
        gnuCantArhPeri := 0; -- cantidad de registros por periodo

        -- Valida la cantidad de hilos en ejecucion
        nuCantHilosEjec := fnuValEstadoFIDF(sbPERIODO);

        IF nuCantHilosEjec = 0 THEN

          -- Genera los spools de cartas de productos sin factura
          ldc_pkgOSFFacture.pgenSpoolCartasContSinFact(sbPERIODO);
          
          -- instancia los archivos del servidor
          proListArchFIDF(sbPERIODO);

          -- Llama al proceso de copiado
          proCopiaArchFIDF;

          --Inicio CASO 200-2033
          --Mesaje para establecer mensaje en alugun punto de error
          pkg_Traza.trace('NuLOG[' || NuLOG || ']');
          pkg_Traza.trace('NuControl[' || NuControl || ']');

          if NuLOG = -1 then
            vaErrorHiloEjec := 'Se genero archivo LOG con inconsistencias.';
            pkg_error.setErrorMessage( isbMsgErrr => vaErrorHiloEjec );
          end if;
          if NuControl = -1 then
            vaErrorHiloEjec := 'Se genero archivo CONTROL con inconsistencias.';
            pkg_error.setErrorMessage( isbMsgErrr => vaErrorHiloEjec );
          end if;
          --Fin CASO 200-2033

          --2033 10.09.18 copia del archivo en cada una de las rutas
          proCopiaArchUnificadoFIDF;
          
              pkg_Traza.trace('INICIA PRGENACTIIMPCAR', 10);

          sbWhat := ' DECLARE '||
              chr(10) ||' nuOk NUMBER; '||
              chr(10) ||' sbErrorMessage VARCHAR2(4000); '||
              chr(10) || ' BEGIN ' || 
              chr(10) || '   SetSystemEnviroment; '||
              chr(10) || '   pkg_Error.Initialize; '||
              chr(10) || '   ldc_pkgOSFFacture.PRGENACTIIMPCAR('''|| sbPERIODO ||''');' ||				 
              chr(10) || ' exception when others then  pkg_error.setError; '||
              chr(10) || 'END;';

              dbms_job.submit(nujob, sbWhat, sysdate +  1/ 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
               commit;
              pkg_Traza.trace('TERMINA PRGENACTIIMPCAR'||nujob, 10);


        ELSE

            vaErrorHiloEjec := 'NO se puede continuar con el proceso, archivos FIDF en ejecucion. Periodos de facturacion --> ' ||
                             gvaMensaje;

            -- NO Cambia el estado del Flag a Procesado
            pkg_Traza.trace('LDC_PkPagosConsig.proExeCopyArchFIDF ERROR  -->' ||
                         vaErrorHiloEjec,
                         10);
                             
            pkg_error.setErrorMessage( isbMsgErrr => vaErrorHiloEjec );

        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
 
        WHEN Others THEN
            -- NO Cambia el estado del Flag a Procesado
            pkg_Traza.trace('LDC_PkPagosConsig.proExeCopyArchFIDF ERROR  -->' ||
                         vaErrorHiloEjec || ' - ' || SQLERRM,
                         10);
            pkg_Traza.trace(vaErrorHiloEjec || SQLERRM);
            if NuLOG = -1 then
                vaErrorHiloEjec := 'Se genero archivo LOG con inconsistencias.';
                -- NO Cambia el estado del Flag a Procesado
                pkg_Traza.trace(vaErrorHiloEjec);
                pkg_error.setErrorMessage( isbMsgErrr => vaErrorHiloEjec );    
            end if;
            if NuControl = -1 then
                vaErrorHiloEjec := 'Se genero archivo CONTROL con inconsistencias.';
                -- NO Cambia el estado del Flag a Procesado
                pkg_Traza.trace(vaErrorHiloEjec);
                pkg_error.setErrorMessage( isbMsgErrr => vaErrorHiloEjec );
            end if;
            if NuLOG = -2 then
                pkg_error.setErrorMessage( isbMsgErrr => SbLOG );
            end if;            
    END proExeCopyArchFIDF;

    PROCEDURE proCopiaArchUnificadoFIDF
    /**********************************************************************************
     Propiedad intelectual de CSC. (C).

     Unidad      : proCopiaArchUnificadoFIDF
     Descripcion : procedimiento para copiar el unificado en cada una de las carpetas destino


     Autor     : Daniel Valiente
     Fecha     : 10-09-2018

     Historia de Modificaciones
     DD-MM-YYYY    <Autor>               Modificacion
     -----------  -------------------    -------------------------------------
     19-09-2018   Daniel Valiente        Se agrego la rutina de eliminar archivos de unificacion
                                         Se anexo archivo de Control
    **********************************************************************************/
   IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proCopiaArchUnificadoFIDF';  
        
        vaRutaOrigen VARCHAR2(4000); -- Ruta origen para el copiado de archivos

        vanomfileCtrl VARCHAR2(400); -- archivo de control
        vaRutaDestino VARCHAR2(4000);

        vaRegistro VARCHAR2(2) := 'N';

        CURSOR cuRutaOrig IS
            SELECT REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS'),'[^,]+',1,LEVEL)
            FROM DUAL
            CONNECT BY REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS'),'[^,]+',1,LEVEL) IS NOT NULL;
                    
        CURSOR cuRutaDest IS
            SELECT REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_DEST_ARCH_FACTURAS'),'[^,]+',1,LEVEL)
            FROM DUAL
            CONNECT BY REGEXP_SUBSTR (dald_parameter.fsbGetValue_Chain('LDC_RUTA_DEST_ARCH_FACTURAS'),'[^,]+',1,LEVEL) IS NOT NULL;

        -- Variables requeridas para el UTL destino
        l_file_dest_exists BOOLEAN;
        l_file_dest_len    NUMBER;
        l_dest_blocksize   BINARY_INTEGER;

        -- Variables requeridas para el UTL origen
        l_file_orig_exists BOOLEAN;
        l_file_orig_len    NUMBER;
        l_orig_blocksize   BINARY_INTEGER;
        
        nuError            NUMBER;
        sbError            VARCHAR2(4000);
        
        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
                    
            IF cuRutaOrig%ISOPEN THEN
                CLOSE cuRutaOrig;
            END IF;
 
            IF cuRutaDest%ISOPEN THEN
                CLOSE cuRutaDest;
            END IF;
            
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;          

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pCierraCursores;   
        
        -- Ruta Origen
        vaRutaOrigen := dald_parameter.fsbGetValue_Chain('LDC_RUTA_ORIG_ARCH_FACTURAS');

        -- Nombres de los archivos Control
        vanomfileCtrl := 'CONTROL_FIDF_FACTURE_' ||
                         to_char(SYSDATE, 'YYYYMMDD-HH24-MI-SS') || '.csv';

        OPEN cuRutaDest;
        LOOP
          FETCH cuRutaDest
            INTO vaRutaDestino;
          EXIT WHEN cuRutaDest%NOTFOUND;

          pkg_Traza.trace('Numero de Archivos Unificados: ' ||
                               NuUnificado);
          FOR idx IN 1 .. NuUnificado LOOP

            pkg_Traza.trace('Comparacion de Ultima Linea');
            pkg_Traza.trace('Ultima Linea Registrada en el Unificado [' ||
                                 tbtUnificado(idx) || '] [' ||
                                 tbtypNombArchPeriDepaUnificado(idx) || '] ' ||
                                 tbtLinea(idx));
            linedata := '';
            --ciclo de verificacion de archivos
            LOOP
              pkg_Traza.trace('Ciclo Repetitivo de Verificacion');
              linedata     := null;
              Templinedata := null;
              filehandler  := utl_file.fopen(gvarutarch,
                                             tbtypNombArchPeriDepaUnificado(idx),
                                             'R',
                                             32767);
              --obtencion de la ultim linea del archivo Unificado
              if utl_file.is_open(filehandler) then
                loop
                  begin
                    utl_file.get_line(filehandler, Templinedata, 32767);
                    IF Templinedata is not null then
                      linedata := Templinedata;
                    end if;
                  exception
                    when no_data_found then
                      exit;
                  end;
                end loop;
              end if;
              utl_file.fclose(filehandler);
              pkg_Traza.trace('Ultima Linea Archivo a Copiar ' ||
                                   linedata);
              --si las lineas son distintas se genera una espera de 5 Segundos
              if (linedata <> tbtLinea(idx)) then
                pkg_Traza.trace('Sleep - 5 sg');
                DBMS_LOCK.Sleep(5);
              else
                exit;
              end if;
            END LOOP;
            --validacion de tamaños
            loop
              begin
                --copiado del archivo
                utl_file.fcopy(src_location  => gvarutarch,
                               src_filename  => tbtypNombArchPeriDepaUnificado(idx),
                               dest_location => vaRutaDestino,
                               dest_filename => tbtypNombArchPeriDepaUnificado(idx));
                -- Obtiene las propiedas del archivo copiado
                utl_file.fgetattr(location    => vaRutaDestino,
                                  filename    => tbtypNombArchPeriDepaUnificado(idx),
                                  fexists     => l_file_dest_exists,
                                  file_length => l_file_dest_len,
                                  block_size  => l_dest_blocksize);
                -- Obtiene las propiedas del archivo origen
                utl_file.fgetattr(location    => gvarutarch,
                                  filename    => tbtypNombArchPeriDepaUnificado(idx),
                                  fexists     => l_file_orig_exists,
                                  file_length => l_file_orig_len,
                                  block_size  => l_orig_blocksize);
                IF l_file_dest_exists THEN
                  pkg_Traza.trace('COMPARA ARCHIVOS ' ||
                                       tbtypNombArchPeriDepaUnificado(idx));
                  IF l_file_orig_len = l_file_dest_len THEN
                    pkg_Traza.trace('ARCHIVOS IGUALES' ||
                                         tbtypNombArchPeriDepaUnificado(idx));
                    exit;
                  else
                    pkg_Traza.trace('Sleep - 5 sg');
                    DBMS_LOCK.Sleep(5);
                  end if;
                end if;
              end;
            end loop;
            pkg_Traza.trace('Fin de Copiado de Archivo Unificado en: ' ||
                                 vaRutaDestino || ' - ' ||
                                 tbtypNombArchPeriDepaUnificado(idx));
            --
            --Daniel Valiente 19.09.18 - se restringe el registro de un solo indicador, para que no duplique nombres en el archivo
            if vaRegistro = 'N' then
              fileCtrl := UTL_FILE.FOPEN(gvarutarch, vanomfileCtrl, 'A');

              utl_file.put_line(fileCtrl,
                                tbtypNombArchPeriDepaUnificado(idx) || '|0');
              --vaRutaDestino || '/' || tbtypNombArchPeriDepaUnificado(idx)); --Nueva variable

              UTL_FILE.FCLOSE(fileCtrl);
            end if;
          end loop;
          vaRegistro := 'S';
        END LOOP;
        CLOSE cuRutaDest;
        --Copia de Archivo de Control
        OPEN cuRutaDest;
        LOOP
          FETCH cuRutaDest
            INTO vaRutaDestino;
          EXIT WHEN cuRutaDest%NOTFOUND;

          utl_file.fcopy(src_location  => gvarutarch,
                         src_filename  => vanomfileCtrl,
                         dest_location => vaRutaDestino,
                         dest_filename => vanomfileCtrl);
          pkg_Traza.trace('Fin de Copiado de Archivo de Control en: ' ||
                               vaRutaDestino || ' - ' || vanomfileCtrl);
        END LOOP;
        CLOSE cuRutaDest;

        ---
        OPEN cuRutaOrig;
        LOOP
          FETCH cuRutaOrig
            INTO vaRutaDestino;
          EXIT WHEN cuRutaOrig%NOTFOUND;
          FOR idx IN 1 .. tbtypNombArchPeri.count LOOP

            utl_file.fremove(vaRutaDestino, tbtypNombArchPeriDepa(idx));
            pkg_Traza.trace('File remove: ' || vaRutaDestino || ' - ' ||
                                 tbtypNombArchPeriDepa(idx));

          END LOOP;
        END LOOP;
        CLOSE cuRutaOrig;
        ---

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error;                   
    END proCopiaArchUnificadoFIDF;

    PROCEDURE PRGENACTIIMPCAR(isbPeriodo IN VARCHAR2) IS
    /**************************************************************************
      Propiedad intelectual de GDC.
      Funcion     :  PRGENACTIIMPCAR
      Descripcion :  proceso que se encarga de generar ordenes de impresion a usuarios
            marcados en la tabla LDC_INFOPRNOR  
      Autor       : Horbath
      Ticket      : 27
      Fecha       : 19/12/2019
      
      Parametros Entrada
          inuPeriodo periodo de facturacion

        Valor de salida
          
      Historia de Modificaciones
      Fecha               Autor                Modificación
      =========           =========          ====================
      24/01/2023          lfvalencia          OSF-827: Se agregan los siguientes
                                            parámetros:
                                            LDC_MES_NOTIFICA_INI_RP - Mes en que se
                                            realiza la notificación inicial de RP
                                            LDC_MES_SEGUNDA_NOTI_RP - Mes en que 
                                            se realiza la segunda notificación de RP
                                            y se modifica el nombre de los parametros de 
                                            las actividades.
                                            LDC_ACTICARM55 por LDC_ACTICAR_NOTI_INI
                                            LDC_ACTICARM57 por LDC_MES_SEGUNDA_NOTI_RP
                                            Se elimina validación de aplica entrega
    **************************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proCopiaArchUnificadoFIDF';  
        
        nuActivImprIni NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_ACTICAR_NOTI_INI', NULL);--se almacena actividad a generar 54 meses
        nuActivImprSeg NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_ACTICAR_SEG_NOTI', NULL);--se almacena actividad a generar 57 meses
        nuError NUMBER; --codigo de error
        sbError VARCHAR2(4000);--mensaje de error
        nuUnidadOper NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_UNOPDISP', NULL);--se almacena codigo de unidad
        nuActivGene NUMBER;
        nuOrderId NUMBER; --se almacena orden generada
        --caso:802----------
        nuCodReporte number; 
        nuOrdenAct  or_order_activity.order_activity_id%TYPE;
        sbErrorMessage VARCHAR2(4000);
        nuOk           NUMBER;
        sbErrorCrea    VARCHAR2(4000);
        nuErrorCrea    NUMBER;
        --caso:802----------
        
        -- Mes de notificación de RP
        nuMesNotiIni NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_MES_NOTIFICA_INI_RP', NULL);
        nuMesSegNoti NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_MES_SEGUNDA_NOTI_RP', NULL);
        
        --se obtienen productos pendiente del periodo que se esta procesando
          CURSOR cuGetProductos (nuPeriodo number) IS
          SELECT i.rowid, i.INPNMERE, p.address_id direccion,
                p.subscription_id contrato, 
                p.product_id producto,
                s.suscclie cliente,
                (select se.operating_sector_id
                  from ab_address di 
                  inner join ab_segments se on se.segments_id=di.segment_id
                  where di.address_id=p.address_id) sector_oper
          FROM LDC_INFOPRNORP i, pr_product p, suscripc s
          WHERE i.INPNPEFA = nuPeriodo
          AND i.INPNSESU = p.product_id
          AND s.susccodi = p.subscription_id
          AND i.INPNORIM is null;
        
        CURSOR CuPeriodo IS
        SELECT TO_NUMBER(REGEXP_SUBSTR (isbPeriodo,'[^,]+',1,LEVEL)) periodo, rownum
        FROM DUAL
        CONNECT BY REGEXP_SUBSTR (isbPeriodo,'[^,]+',1,LEVEL) IS NOT NULL;
 
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        	
        nuCodReporte := fnuCreaReporte();
        
        FOR rPeriodos IN CuPeriodo LOOP	
          BEGIN
            FOR reg IN cuGetProductos(rPeriodos.periodo) LOOP
                nuActivGene := null;
                nuError := null;
                sbError := null;
                nuOrderId := null;
                nuOrdenAct:= null;
                nuErrorCrea :=null;
                sbErrorCrea :=null;
                
                IF REG.INPNMERE = nuMesNotiIni THEN
                  nuActivGene := nuActivImprIni;
                ELSIF REG.INPNMERE = nuMesSegNoti THEN
                  nuActivGene := nuActivImprSeg;
                END IF;
                
                IF nuActivGene IS NOT NULL THEN
                    SAVEPOINT ORDENES;
       
                    BEGIN
                        API_CREATEORDER(inuitemsid         => nuActivGene,
                                        inupackageid        => null,
                                        inumotiveid         => null,
                                        inucomponentid      => NULL,
                                        inuinstanceid       => NULL,
                                        inuaddressid        => reg.direccion,
                                        inuelementid        => NULL,
                                        inusubscriberid     => reg.cliente,
                                        inusubscriptionid   => reg.contrato,
                                        inuproductid        => reg.producto,               
                                        inuoperunitid       => NULL,
                                        idtexecestimdate    => NULL,
                                        inuprocessid        => NULL,
                                        isbcomment          => 'ORDEN GENERADA POR PROCESO DE SPOOL',
                                        iblprocessorder     => FALSE,
                                        inupriorityid       => NULL,
                                        inuordertemplateid  => NULL,
                                        isbcompensate       => NULL,
                                        inuconsecutive      => NULL,
                                        inurouteid          => NULL,
                                        inurouteconsecutive => NULL,
                                        inulegalizetrytimes => 0,
                                        isbtagname          => NULL,
                                        iblisacttogroup     => FALSE,
                                        inurefvalue         => NULL,
                                        ionuorderid         => nuOrderId,
                                        ionuorderactivityid => nuOrdenAct,
                                        onuErrorCode        => nuErrorCrea,
                                        osbErrorMessage     => sbErrorCrea        
                                        );
                  EXCEPTION    
                    WHEN others then
                        pkg_error.setError;
                        pkg_error.getError(nuErrorCrea, sbErrorCrea);
                  END;
                  IF nuOrderId is null THEN
                    ROLLBACK to ORDENES;
                    UPDATE  LDC_INFOPRNORP 
                    SET     INPNINCO = 'No se pudo generar la orden de la actividad'||nuActivGene||'.'||sbErrorCrea, 
                            INPNFEIN = SYSDATE
                    WHERE   ROWID = REG.ROWID;
                  ELSE
                    nuError := NULL;
                    sbError := NULL;
                    --se asigna orden de trabajo
                    API_ASSIGN_ORDER( nuOrderId, nuUnidadOper, nuError, sbError);
                    IF nuError <> 0 THEN				  
                      ROLLBACK to ORDENES;				
                      UPDATE LDC_INFOPRNORP SET INPNINCO = sbError, INPNFEIN = SYSDATE
                      WHERE ROWID = REG.ROWID;
                    ELSE					  
                      UPDATE LDC_INFOPRNORP SET INPNORIM = nuOrderId,
                                  INPNINCO = NULL, 
                                  INPNFEIN = NULL
                      WHERE ROWID = REG.ROWID;
                      
                      UPDATE  or_order_activity oa 
                      SET     oa.product_id = reg.producto , 
                              oa.subscriber_id = reg.cliente,
                              oa.subscription_id = reg.contrato 
                      WHERE   order_id = nuOrderId;
                    END IF;			
                  END IF;
                  COMMIT;
                END IF;
              END LOOP;  -- productos
              
              ldc_pkgOSFFacture.proEnviaCorreo(rPeriodos.periodo,nuOk, sbErrorMessage); 
              PrDetalleReporte(nuCodReporte,rPeriodos.periodo,'Termino Correctamente',rPeriodos.rownum); --  CASO:802
          EXCEPTION
            WHEN OTHERS THEN 
              PrDetalleReporte(nuCodReporte,rPeriodos.periodo,SUBSTR('Termino Con Errores: '||sqlerrm,0,1999),rPeriodos.rownum);--  CASO:802
          END;  
        END LOOP; -- periodos		
        PKTBLREPORTES.updrepostej(nuCodReporte,'Termino.');
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    END PRGENACTIIMPCAR;           

    /**************************************************************************
    Propiedad intelectual de GdC.
    Funcion     :   fnuTipoNotificacion
    Descripcion :   Retorna el tipo de notificación de acuerdo con la edad del 
                    certificado
    Autor       :   jpinedc
    Ticket      :   OSF-1701
    Fecha       :   27/10/2023

    Parametros Entrada
      inuEdadCertificado: Edad del certificado

    Valor de salida
      
    Historia de Modificaciones
    Fecha               Autor                Modificación
    =========           =========          ====================
    27/10/2023          jpinedc             Creción
**************************************************************************/    
    FUNCTION fnuTipoNotificacion( inuEdadCertificado NUMBER)
    RETURN NUMBER
    IS
        csbMetodo           CONSTANT VARCHAR2(30) := 'fnuTipoNotificacion';      
    
        nuTipoNotificacion  NUMBER;
        
        nuError             NUMBER;
        sbError             VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        pkg_traza.trace('inuEdadCertificado|' || inuEdadCertificado, csbNivelTraza);  
        
        IF inuEdadCertificado IS NOT NULL THEN             
    
            IF NOT gtbConfMensRP.Exists( inuEdadCertificado ) THEN

                gtbConfMensRP( inuEdadCertificado ) := ldc_pkgprocrevperfact.frcConfMensRP( inuEdadCertificado );
                
            END IF;
            
            IF gtbConfMensRP.Exists( inuEdadCertificado ) THEN
            
                IF NVL(gtbConfMensRP( inuEdadCertificado).MERPIMCN,'N')  = 'S' THEN
                    nuTipoNotificacion := gtbConfMensRP( inuEdadCertificado).MERPTINO;
                END IF;
                
            END IF;
        
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);   
            
        RETURN nuTipoNotificacion;

     EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error;     
    END fnuTipoNotificacion;

    /**************************************************************************
    Propiedad intelectual de GdC.
    Funcion     :   ftbProdSinFactConNotiRP
    Descripcion :   Retorna una tabla pl con los productos de gas que no tuvieron 
                    factura en el período pero deben ser notificados por RP
    Autor       :   jpinedc
    Ticket      :   OSF-1701
    Fecha       :   27/10/2023

    Parametros Entrada
        inuPeriodo: Periodo de facturación

    Valor de salida
      
    Historia de Modificaciones
    Fecha               Autor                Modificación
    =========           =========          ====================
    27/10/2023          jpinedc             Creción
    **************************************************************************/  
    FUNCTION ftbProdSinFactConNotiRP( inuPeriodo NUMBER)
    RETURN tytbProdSinFactConNotiRP
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ftbProdSinFactConNotiRP';  
                    
        tbProdSinFactConNotiRP      tytbProdSinFactConNotiRP;
        
        tbProdSinFactConNotiRPOut   tytbProdSinFactConNotiRP;
        
        nuEdadCertificado           NUMBER;
        
        nuTipoNotificacion          NUMBER;
        
        sbDescLocalidad             ge_geogra_location.description%TYPE;
        
        nuError                     NUMBER;
        sbError                     VARCHAR2(4000);

        PROCEDURE pCierraCursores
        IS
            csbMetodo1        CONSTANT VARCHAR2(100) := csbMetodo || '.pCierraCursores';
        BEGIN

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  
                    
            IF cuProdSinFactConNotiRP%ISOPEN THEN
                CLOSE cuProdSinFactConNotiRP;
            END IF;

            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN); 
               
        END pCierraCursores;          
                                       
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        pCierraCursores;
                        
        OPEN cuProdSinFactConNotiRP( inuPeriodo);
        FETCH cuProdSinFactConNotiRP BULK COLLECT INTO tbProdSinFactConNotiRP;
        CLOSE cuProdSinFactConNotiRP;
        
        FOR ind IN 1..tbProdSinFactConNotiRP.Count LOOP
            
            nuEdadCertificado := ldc_pkgprocrevperfact.fnuEdadCertificadoSpool( tbProdSinFactConNotiRP(ind).producto );
        
            nuTipoNotificacion := fnuTipoNotificacion( nuEdadCertificado );
            
            IF nuTipoNotificacion IS NOT NULL THEN

                pkg_traza.trace('nuTipoNotificacion|' || nuTipoNotificacion, csbNivelTraza );
                                
                pkg_traza.trace('nuEdadCertificado|' || nuEdadCertificado, csbNivelTraza );
                                            
                sbDescLocalidad := tbProdSinFactConNotiRP(ind).Nombre_Localidad || ' - ' || substr(tbProdSinFactConNotiRP(ind).Nombre_Departamento,1,3);
                
                tbProdSinFactConNotiRP(ind).Nombre_Localidad := sbDescLocalidad;

                tbProdSinFactConNotiRP(ind).TipoNotificacion := nuTipoNotificacion;
                
                tbProdSinFactConNotiRP(ind).EdadCertificado  := nuEdadCertificado;
                
                tbProdSinFactConNotiRPOut(tbProdSinFactConNotiRPOut.count+1) := tbProdSinFactConNotiRP(ind);
        
            END IF;
            
        END LOOP;
                                         
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         
        
        RETURN tbProdSinFactConNotiRPOut;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraCursores;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error;  
    END ftbProdSinFactConNotiRP;

    /**************************************************************************
    Propiedad intelectual de GdC.
    Funcion     :   pgenRegSpoolCartasContSinFact
    Descripcion :   Genera un registro en el spool de cartas para el periodo
    Autor       :   jpinedc
    Ticket      :   OSF-1701
    Fecha       :   27/10/2023

    Parametros Entrada
        ircProducto             :   Datos del producto a notificar
        isbFechaProceso         :   Fecha de generación del spool

    Valor de salida
      
    Historia de Modificaciones
    Fecha               Autor                Modificación
    =========           =========          ====================
    27/10/2023          jpinedc             Creción
    **************************************************************************/  
    PROCEDURE pgenRegSpoolCartasContSinFact( inuConsecutivo NUMBER, ircProducto cuProdSinFactConNotiRP%ROWTYPE, isbFechaProceso VARCHAR2, inuPeriodo NUMBER )
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pgenRegSpoolCartasContSinFact';  
            
        sbArchivoCartas     VARCHAR2(100);
        
        sbLinea             VARCHAR2(32767);
        
        sbDepartamento      ge_geogra_location.description%TYPE := NULL;
        
        nuEdadProd          NUMBER;
        
        rcConfMensRP      LDC_CONFIMENSRP%ROWTYPE;
        
        FECH_MAXIMA       VARCHAR2 (50);
        FECH_SUSP         VARCHAR2 (50);
        
        sbPeriodo           VARCHAR2(200);
        sbUso               VARCHAR2(200);
        
        rcPerifact          perifact%ROWTYPE;
        
        nuError             NUMBER;
        sbError             VARCHAR2(4000);                       
           
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);        
            
        sbDepartamento := 'DPTO';
    
        sbArchivoCartas := 'CARTAS_' || ircProducto.Periodo || '_' || isbFechaProceso ||'_' || Ldc_FsbDeptoPeriFact(inuPeriodo);
    
        IF gvarutarch IS NULL THEN
            gvarutarch := pkg_BCLD_Parameter.fsbOBTIENEValorCadena('LDC_RUTA_ORIG_ARCH_FACTURAS'); 
        END IF;

        IF NOT gtblListArchCartasFIDF.exists( sbArchivoCartas)  THEN
                                
            gtblListArchCartasFIDF( sbArchivoCartas ) := pkg_gestionArchivos.ftAbrirArchivo_SMF( gvarutarch, sbArchivoCartas, 'W');
            
			sbLinea := NULL;
			
            sbLinea := sbLinea || 'NUMERO_FACT' 	|| csbSep;
			sbLinea := sbLinea || 'TIPO_NOTI' 		|| csbSep;
			sbLinea := sbLinea || 'NOMBRE_SUSC' 	|| csbSep;
			sbLinea := sbLinea || 'DIR_ENTREGA'		|| csbSep;
			sbLinea := sbLinea || 'CONTRATO'		|| csbSep;	
			sbLinea := sbLinea || 'LOCALIDAD'		|| csbSep;
			sbLinea := sbLinea || 'COD_DE_SERVICIO'	|| csbSep;
			sbLinea := sbLinea || 'MENSGNRAL1'		|| csbSep;
			sbLinea := sbLinea || 'FECH_MAXIMA'		|| csbSep;
			sbLinea := sbLinea || 'FECH_SUSP' 		|| csbSep;
			sbLinea := sbLinea || 'NO_MEDIDOR'		|| csbSep;
			sbLinea := sbLinea || 'PERIODO_FACT'	|| csbSep;
			sbLinea := sbLinea || 'USO' 			|| csbSep;
			sbLinea := sbLinea || 'ESTRATO'; 
                    
            pkg_gestionArchivos.prcEscribirLinea_SMF( gtblListArchCartasFIDF( sbArchivoCartas ), sbLinea );
            
                        
        END IF; 
    
        nuEdadProd := ldc_pkgprocrevperfact.fnuEdadCertificadoSpool( ircProducto.Producto );
        
        FECH_MAXIMA := NULL;
        FECH_SUSP := NULL;


        rcConfMensRP := ldc_pkgprocrevperfact.frcConfMensRP(nuEdadProd);

        -- En caso que la configuración indique que se imprime la fecha máxima
        IF (rcConfMensRP.MERPIMFM = 'S')
        THEN
            FECH_MAXIMA :=
                TO_CHAR (ldc_pkgprocrevperfact.LDC_GETFECHMAXIMARP (ircProducto.Producto),
                         'DD Month YYYY',
                         'nls_date_language=spanish');
        END IF;

        -- En caso que la configuración indique que se imprime la fecha de suspensión
        IF (rcConfMensRP.MERPIMFS = 'S')
        THEN
            FECH_SUSP :=
                TO_CHAR (ldc_pkgprocrevperfact.LDC_GETFECHSUSPRP (ircProducto.Producto),
                         'DD Month YYYY',
                         'nls_date_language=spanish');
        END IF;

        IF TRUNC (
               TO_DATE (FECH_MAXIMA,
                        'DD Month YYYY',
                        'nls_date_language=spanish')) <
           TRUNC (SYSDATE)
        THEN
            FECH_SUSP := 'INMEDIATO';
        END IF;
        
        rcPerifact := pktblPeriFact.frcGetRecord( inuPeriodo );
        
        sbPeriodo   := TO_CHAR( TO_DATE( rcPerifact.pefames||'/'||rcPerifact.pefaano,'mm/yyyy'), 'MON') || ' ' || rcPerifact.pefaano;
        
        sbUso       := pktblCategori.fsbGetDescription( ircProducto.Categoria );
  
        pkg_traza.trace('sbPeriodo|' || sbPeriodo, csbNivelTraza ); 

        pkg_traza.trace('sbUso|' || sbUso, csbNivelTraza ); 
            
        sbLinea := NULL;
        sbLinea := sbLinea      || inuConsecutivo 	    ||  csbSep;		
        sbLinea := sbLinea      || ircProducto.TipoNotificacion ||  csbSep;
        sbLinea := sbLinea      || ircProducto.Nombre_Cliente   ||  csbSep;
        sbLinea := sbLinea      || ircProducto.Direccion_Cobro  ||  csbSep  ;
        sbLinea := sbLinea      || ircProducto.Contrato         ||  csbSep ;
        sbLinea := sbLinea      || ircProducto.Nombre_Localidad ||  csbSep ; 
        sbLinea := sbLinea      || ircProducto.Producto         ||  csbSep ;
        sbLinea := sbLinea      || rcConfMensRP.MERPMENS        ||  csbSep ;
        sbLinea := sbLinea      || FECH_MAXIMA                  ||  csbSep ;
        sbLinea := sbLinea      || FECH_SUSP                    ||  csbSep ;
        sbLinea := sbLinea      || ircProducto.Medidor          ||  csbSep ;
        sbLinea := sbLinea      || sbPeriodo                    ||  csbSep ;
        sbLinea := sbLinea      || sbUso                        ||  csbSep ;
        sbLinea := sbLinea      || ircProducto.SubCategoria      ;
        
        pkg_gestionArchivos.prcEscribirLinea_SMF( gtblListArchCartasFIDF( sbArchivoCartas ), sbLinea );
                
        ldc_pkgprocrevperfact.pInsUpdRegNotiRP
        (
            ircProducto.Producto,
            ircProducto.Contrato,
            ircProducto.Periodo,
            ircProducto.EdadCertificado
        );
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error;                    
    END pgenRegSpoolCartasContSinFact;
    
    PROCEDURE pCierraSpoolsCartasContSinFact
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pCierraSpoolsCartasContSinFact';
        
        sbArchivo       VARCHAR2(100);

        nuError         NUMBER;
        sbError         VARCHAR2(4000);
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);      
    
        IF gtblListArchCartasFIDF.COUNT > 0 THEN
        
            sbArchivo := gtblListArchCartasFIDF.FIRST;
            
            LOOP
            
                EXIT WHEN sbArchivo IS NULL;
                
                IF pkg_gestionArchivos.fblArchivoAbierto_SMF( gtblListArchCartasFIDF(sbArchivo) ) THEN
                    pkg_gestionArchivos.prcCerrarArchivo_SMF( gtblListArchCartasFIDF(sbArchivo) );
                END IF;
                
                sbArchivo := gtblListArchCartasFIDF.Next(sbArchivo);
                
            END LOOP;
        
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN         
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                                     
            RAISE pkg_error.Controlled_Error;     
    END pCierraSpoolsCartasContSinFact;


    /**************************************************************************
    Propiedad intelectual de GdC.
    Funcion     :   pgenSpoolCartasContSinFact
    Descripcion :   Genera los archivos de spool de cartas para la lista de 
                    periodos
    Autor       :   jpinedc
    Ticket      :   OSF-1701
    Fecha       :   27/10/2023

    Parametros Entrada
        isbPeriodos             :   Lista de periodos separada por coma

    Valor de salida
      
    Historia de Modificaciones
    Fecha           Autor               Modificación
    =========       =========           ====================
    27/10/2023      jpinedc             Creción
    23/09/2024      jpinedc             OSF-3309: Se ejecuta 
                                        pkexecutedprocessmgr.getlastexecutedproc
                                        para ejecutar el proceso solo si ya se
                                        ejecutó FGCC
    **************************************************************************/          
    PROCEDURE pgenSpoolCartasContSinFact(isbPeriodos VARCHAR2)
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pgenSpoolCartasContSinFact';  
            
        CURSOR cuPeriodos
        IS
        SELECT *
        FROM perifact pf
        WHERE INSTR( ',' || isbPeriodos || ',' , ',' || pefacodi || ',' ) > 0;
                        
        sbFechaProceso  VARCHAR2(30);
        
        tbProdSinFactConNotiRP  tytbProdSinFactConNotiRP;
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blFGCCEjecutado        BOOLEAN;        
                         
    BEGIN
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        pkg_traza.trace('isbPeriodos|' || isbPeriodos, csbNivelTraza );
                
        sbFechaProceso := TO_CHAR(SYSDATE, 'ddmmyyyy_hh24miss');
        
        pkg_traza.trace('sbFechaProceso|' || sbFechaProceso, csbNivelTraza );
        
        gtblListArchCartasFIDF.Delete;
        
        FOR rgPeriodo IN cuPeriodos LOOP

            pkg_traza.trace('rgPeriodo.pefacodi|' || rgPeriodo.pefacodi, csbNivelTraza );
                        
            blFGCCEjecutado := ldc_pkgOSFFacture.fblProcesoEjecutado
            (
                rgPeriodo.pefacodi,
                csbFGCC
            );

            IF blFGCCEjecutado THEN

                pkg_traza.trace('Periodo ' || rgPeriodo.pefacodi  || ': Sí se ejecuta pgenSpoolCartasContSinFact ya que sí se ha ejecutado FGCC' , csbNivelTraza ); 
            
                tbProdSinFactConNotiRP.Delete;
            
                tbProdSinFactConNotiRP := ldc_pkgOSFFacture.ftbProdSinFactConNotiRP ( rgPeriodo.pefacodi );
            
                pkg_traza.trace('tbProdSinFactConNotiRP.Count|' || tbProdSinFactConNotiRP.Count, csbNivelTraza ); 

                IF tbProdSinFactConNotiRP.COUNT > 0 THEN
                
                    FOR indTbPr IN 1..tbProdSinFactConNotiRP.COUNT LOOP
                                                                                            
                        pgenRegSpoolCartasContSinFact
                        ( 
                            indTbPr,
                            tbProdSinFactConNotiRP(indTbPr),
                            sbFechaProceso, 
                            rgPeriodo.pefacodi                         
                        );
                        
                        COMMIT;
                        
                    END LOOP;
                                
                END IF;

            ELSE

                pkg_traza.trace('Periodo ' || rgPeriodo.pefacodi  || ': No se ejecuta pgenSpoolCartasContSinFact ya que no se ha ejecutado FGCC' , csbNivelTraza ); 
                        
            END IF;
                                                              
        END LOOP;
        
        pCierraSpoolsCartasContSinFact;
                       
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);        
            pCierraSpoolsCartasContSinFact;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pCierraSpoolsCartasContSinFact;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);                      
            RAISE pkg_error.Controlled_Error;                    
    END pgenSpoolCartasContSinFact;

    /**************************************************************************
    Propiedad intelectual de GdC.
    Funcion     :   fblProcesoEjecutado
    Descripcion :   Retorna verdadero si el proceso fue ejecutado para el periodo
    Autor       :   jpinedc
    Ticket      :   OSF-3309
    Fecha       :   25/09/2024

    Parametros Entrada
        inuPeriodo             :   Periodo de facturación
        isbProceso             :   Proceso. Ej: FGCC 

    Valor de salida
      
    Historia de Modificaciones
    Fecha           Autor               Modificación
    =========       =========           ====================
    25/09/2024      jpinedc             Creción

    **************************************************************************/         
    FUNCTION fblProcesoEjecutado
    (
        inuPeriodo  perifact.pefacodi%TYPE, 
        isbProceso  procesos.proccodi%TYPE
    ) RETURN BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblProcesoEjecutado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        CURSOR cuProcEjec
        IS
        SELECT pe.prejidpr
        FROM procejec pe
        WHERE pe.prejcope = inuPeriodo
        AND pe.prejprog = isbProceso
        AND pe.prejespr = csbTERMINADO;
        
        nuPrEjIdpr      procejec.prejidpr%TYPE;
        
        blProcesoEjecutado  BOOLEAN;
              
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);   

        pkg_traza.trace('inuPeriodo|' || inuPeriodo, csbNivelTraza);  
        pkg_traza.trace('isbProceso|' || isbProceso, csbNivelTraza);
        
        OPEN cuProcEjec;
        FETCH cuProcEjec INTO nuPrEjIdpr;
        CLOSE cuProcEjec;

        pkg_traza.trace('nuPrEjIdpr|' || nuPrEjIdpr, csbNivelTraza);  
        
        blProcesoEjecutado := nuPrEjIdpr IS NOT NULL;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blProcesoEjecutado;       

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blProcesoEjecutado;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN blProcesoEjecutado;            
    END fblProcesoEjecutado;
                 
END ldc_pkgOSFFacture;
/

Prompt Otorgando permisos sobre ldc_pkgOSFFacture
BEGIN
    pkg_utilidades.prAplicarPermisos( 'ldc_pkgOSFFacture', 'OPEN');
END;
/

