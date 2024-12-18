CREATE OR REPLACE PACKAGE LDC_PKGENERAESTRPB IS
    /**************************************************************************
      Autor       : 
      Fecha       : 
      Ticket      : 
      Descripcion : Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos
      Parametros Entrada
      Valor de salida
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
	  20/03/2024   JSOTO	   OSF-2387 Ajustes en todo el paquete para reemplazar algunos objetos de producto
							   por objetos personalizados para disminuir el impacto en la migracion a 8.0
								se reemplaza uso de	utl_file.fopen	por	pkg_gestionarchivos.ftabrirarchivo_smf
								se reemplaza uso de	utl_file.new_line	por	pkg_gestionarchivos.prcescribetermlinea_smf
								se reemplaza uso de	userenv('sessionid')	por	pkg_session.fnugetsesion
								se reemplaza uso de	utl_file.fclose	por	pkg_gestionarchivos.prccerrararchivo_smf
								se reemplaza uso de	ut_trace.trace	por	pkg_traza.trace
								se reemplaza uso de	utl_file.file_type	por	pkg_gestionarchivos.styarchivo
								Se ajusta el manejo de errores y trazas de acuerdo a las pautas tecnicas de desarrollo
    ***************************************************************************/

   sbto           VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_EMAIL_INDCAEQ');
   sbMensajeError VARCHAR2(4000);

    --Ticket 200-625 LJLB-- se consulta los correos a los cuales se enviara la NOTificacion

   CURSOR cuCorreos IS
   SELECT TRIM(correo) correo
   FROM (
      SELECT DISTINCT 1 id , regexp_substr(sbto ,'[^,]+', 1, LEVEL )  as correo
       , LEVEL
      FROM DUAL A
      CONNECT BY regexp_substr(sbto, '[^,]+', 1, LEVEL)
          IS NOT NULL
      ORDER BY id, LEVEL);

    CURSOR cuMensaje(inuCod_mensaje ge_message.message_id%TYPE) IS
    SELECT description
	FROM ge_message
	where message_id = inuCod_mensaje;
	
   PROCEDURE LDC_LDCINGCEI;

    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-11-23
      Ticket      : 200-625
      Descripcion : Validacion de los Parametros del PB LDCINGCEI [Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos]
      Parametros Entrada
      Valor de salida
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

   PROCEDURE LDC_NOVALIDATE;

    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-11-23
      Ticket      : 200-625
      Descripcion : Proceso para PB que no validan datos.
 
      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

   PROCEDURE LDC_PROCINGCEI( nuAnio IN NUMBER,
                             nuMess IN NUMBER
                            );

   /**************************************************************************

      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-11-23
      Ticket      : 200-625
      Descripcion : Generamos informacion del reporte LDRINGCEIR  [Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos].

      Parametros Entrada
      nuano A?o
      numes Mes

      Valor de salida
      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    FUNCTION FRFGETORDERLOCK RETURN constants_per.tyrefcursor;

    /**************************************************************************

      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Funcion para devolver las ordenes para bloqueo PB [LDCORBMO]


      Parametros Entrada

      Valor de salida


     HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    PROCEDURE PROPROCCESLOCK( nuOrden   IN OR_ORDER.ORDER_ID%TYPE,
                              nuCausal  IN OR_ORDER.CAUSAL_ID%TYPE,
                              nuTiCo    IN NUMBER,
                              sbComentario IN VARCHAR2
                              );

   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Proceso para el bloqueo de  las ordenes PB [LDCORBMO]

      Parametros Entrada

      sbOrden     Codigo de la orden
      nuCurrent   Current
      nuTotal     Total
      Valor de salida
       nuCodError Codigo de error
       sbMensaje mensaje de error

      HISTORIA DE MODIFICACIONES

      FECHA         AUTOR       			DESCRIPCION
	  21/05/2019	Miguel Ballesteros		Caso 200-2530 - se eliminaron las acciones de COMMIT y rollback, porque al ser una
															forma de tipo reporte no son necesarias estas acciones.

    ***************************************************************************/

     FUNCTION FRFGETORDERUNLOCK 
	     RETURN constants_per.tyrefcursor;

    /**************************************************************************

      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Funcion para devolver las ordenes para desbloqueo PB [LDCORDMO]


      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/


    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Proceso para el DESbloqueo de  las ordenes PB [LDCORDMO]
    ***************************************************************************/
    PROCEDURE PROPROCCESUNLOCK( nuOrden   IN or_order.order_id%TYPE,
                                nuTipoCo  IN NUMBER,
                                sbComentario   IN VARCHAR2,
								nuMedRec  IN NUMBER);

END LDC_PKGENERAESTRPB;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKGENERAESTRPB IS

	  
	-- Para el control de traza:
    csbSP_NAME  CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';


   PROCEDURE proEnviaCorreo( nuano IN NUMBER,
                            numes IN NUMBER,
                            nuOk OUT NUMBER,
                            sbErrorMessage OUT VARCHAR2
                            ) 
   IS

   /**************************************************************************

        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2016-11-23
        Ticket      : 200-625
        Descripcion : Generamos Informe de Indicador y se envia correo.

        Parametros Entrada
        nuano A?o
        numes Mes

        Valor de salida
         nuOk  -1. Error, 0. Exito
         sbErrorMessage mensaje de error.
         nuError  codigo del error

       HISTORIA DE MODIFICACIONES

        FECHA        AUTOR       DESCRIPCION

      ***************************************************************************/

    sbNombreArchivo VARCHAR2(250):='IndiGe_'||TO_CHAR(SYSDATE,'DDMMYYYY_HH24MISS'); --Ticket 200-625 LJLB-- se almacena el nombre del archivo
    csbDEFAULT_PATH	VARCHAR2(100) := '/tmp'; --Ticket 200-625 LJLB-- se almacena la ruta del archivo
    archivo PKG_GESTIONARCHIVOS.STYARCHIVO;
    sbMensaje  VARCHAR2(200):= 'El proceso que genera el reporte de de Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos ha finalizado. Por favor revise el reporte LDRINGCEIR';

    --Ticket 200-625 LJLB--  Archivo

    BLFILE  BFILE;
    nuarchexiste  NUMBER; --Ticket 200-625 LJLB-- valida si creo algun archivo en el disco
    sbfrom        VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_SMTP_SENDER'); --Ticket 200-625 LJLB--  se coloca el emisor del correo
    sbfromdisplay VARCHAR2(4000) := 'Open SmartFlex'; --Ticket 200-625 LJLB-- Nombre del emisor

   --Ticket 200-625 LJLB-- Destinatarios
    sbtodisplay VARCHAR2(4000) := '';
    sbcc        ut_string.tytb_string;
    sbccdisplay ut_string.tytb_string;
    sbbcc       ut_string.tytb_string;

   --Ticket 200-625 LJLB-- asunto

    sbsubject VARCHAR2(255) := 'Indicadores de Gesti?n de la Calibraci?n de  Equipos e Instrumentos';
    sbmsg VARCHAR2(10000) := sbMensaje;
    sbcontenttype VARCHAR2(100) := 'text/html';
    sBFILEname    VARCHAR2(255) := sbNombreArchivo;
    sBFILEext     VARCHAR2(10) := 'HTML'; --Ticket 200-625 LJLB-- especifica el tipo de archivo que se enviar?. ZIP o CSV
    nutam_archivo NUMBER;--Ticket 200-625 LJLB-- tamano del archivo a enviar
	sbInstanciaBD VARCHAR2(30); -- Base de datos
	conn          utl_smtp.connection; -- 

    --Ticket 200-625 LJLB--  Se consulta el indicador de a?o y mes

    CURSOR cuIndicadores IS
    SELECT *
    FROM LDC_INDIEQCA
    WHERE IDEQANO = nuano
     AND IDEQMES = numes;

   --Ticket 200-625 LJLB-- se consulta los correos a los cuales se enviara la NOTificacion

   CURSOR cuCorreos IS

   SELECT TRIM(correo) correo
   FROM (
      SELECT DISTINCT 1 id , regexp_substr(sbto ,'[^,]+', 1, LEVEL )  as correo
       , LEVEL
      FROM DUAL A
      CONNECT BY regexp_substr(sbto, '[^,]+', 1, LEVEL)
          IS NOT NULL
      ORDER BY id, LEVEL);

    rcDatos LDC_INDIEQCA%ROWTYPE; --Ticket 200-625 LJLB-- se crea variable tipo registro de la tabla LDC_INDIEQCA
    adjunto       BLOB;--Ticket 200-625 LJLB-- file TYPE del archivo final a enviar
    sbHtml VARCHAR2(4000); --Ticket 200-625 LJLB--  se almacena estructura HTML.
    directorio    VARCHAR2(255) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_WF_DIRECTORY_ACTIVDET'); --Ticket 200-625 LJLB-- se consulta directorio del archivo
    
	oerrorNumber number;
	oerrorMessage varchar2(4000);
	csbMetodo VARCHAR2(100) := 'proEnviaCorreo';
	
  BEGIN
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      --Ticket 200-625 LJLB-- se abre archivo para su escritura
      BEGIN
          archivo := PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF(csbDEFAULT_PATH, sbNombreArchivo || '.' || sBFILEext, 'w');
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
       END;

     --Ticket 200-625 LJLB-- se cargan los datos para el indicador
      OPEN cuIndicadores;
      FETCH cuIndicadores INTO rcDatos;
      IF cuIndicadores%NOTFOUND THEN
        RAISE pkg_error.controlled_error;
      END IF;
      CLOSE cuIndicadores;

      --Ticket 200-625 LJLB-- se construye estructura del HTML  a enviar
      sbHtml := 
	         '<!DOCTYPE html>
  <html lang="es">
    <head>
      <title>Indicadores de Gestion de la Calibracion de  Equipos e Instrumentos</title>
      <meta charset="utf-8" />
      <link rel="stylesheet" href="estilos.css" />
      <link rel="shortcut icon" href="/favicon.ico" />
      <link rel="alternate" title="Pozoler?a RSS" TYPE="application/rss+xml" href="/feed.rss" />
    </head>

    <body>
        <header>
        </header>
        <section>
           <TABLE border="0">
              <thead>
                <tr>
                  <td colspan="2" height="35"><center><b>Resumen General de Calibraciones de equipos mes'|| rcDatos.IDEQMES||' aoo '||rcDatos.IDEQANO||'</b></center></td>
                  <td><center><b>Ecuaciones</b></center></td>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Numero de calibraciones realizadas en el periodo</td>
                  <td>'||rcDatos.IDEQNCRP||'</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Promedio de los equipos calibrados</td>
                  <td>'||rcDatos.IDIDEPRCE||'</td>
                  <td>Sumatoria (Fecha recepcion - Fecha Legalizacion de las ordenes) / (Cantidad de equipos calibrado)</td>
                </tr>
                <tr>
                  <td>Numero de equipos programados en el periodo</td>
                  <td>'||rcDatos.IDEQNEPP||'</td>
                  <td></td>
                </tr>
                <tr>
                  <td height="35"><b>Eficiencia de verificaion de equipos de medicion: </b></td>
                  <td><b>'||rcDatos.IDEQEVEM||'%</b></td>
                  <td>Numero de equipos calibrados / Numero de equipos programados</td>
                </tr>
                <tr>
                  <td>Numero de equipos calibrados que se encontraron dentro de programacion</td>
                  <td>'||rcDatos.IDEQNECP||'</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Numero de equipos programados en el periodo que no llegaron para calibracion</td>
                  <td>'||rcDatos.IDEQNEPNC||'</td>
                  <td></td>
                </tr>
                <tr>
                  <td>Numero de equipos no programados en el periodo que fueron calibrados</td>
                  <td>'||rcDatos.IDEQNCNPP||'</td>
                  <td></td>
                </tr>
                <tr>
                  <td height="35"><b>Cumplimiento del programa de calibracion de equipos:</b> </td>
                  <td><b>'||rcDatos.IDEQNCPCE||'%</b></td>
                  <td> Numero de equipos calibrados que se encontraron dentro de programacion / Total de equipos programados</td>
                </tr>
                <tr>
                   <td colspan="2"><center><b>Discriminacion de calibracion de equipos</b></center></td>
                </tr>
                <tr>
                  <td>Numero de equipos calibrados area presion</b> </td>
                  <td>'||rcDatos.IDEQNECAP||' </td>
                </tr>
                <tr>
                  <td>Numero de equipos calibrados area concentracion de gas</b> </td>
                  <td>'||rcDatos.IDEQNECAC||'</td>
                </tr>
                <tr>
                  <td>Numero de equipos calibrados area temperatura</b> </td>
                  <td>'||rcDatos.IDEQNECAT||'</td>
                </tr>
                <tr>
                  <td>Numero de equipos calibrados area termo fusion</b> </td>
                  <td>'||rcDatos.IDEQNECTF||'</td>
                </tr>
                <tr>
                  <td>Numero de equipos calibrados area volumen</b> </td>
                  <td>'||rcDatos.IDEQNECAV||'</td>
                </tr>
              </tbody>
           </TABLE>
        </section>

      </body>
    </html>';
     --Ticket 200-625 LJLB-- se escribe en el archivo
    PKG_GESTIONARCHIVOS.PRCESCRIBETERMLINEA_SMF(archivo);
    PKG_GESTIONARCHIVOS.PRCESCRIBIRLINEASINTERM_SMF(archivo, 'Indicadores de Gestion de la calibracion de  Equipos e Instrumentos');
    PKG_GESTIONARCHIVOS.PRCESCRIBETERMLINEA_SMF(archivo);
    PKG_GESTIONARCHIVOS.PRCESCRIBETERMLINEA_SMF(archivo);
    PKG_GESTIONARCHIVOS.PRCESCRIBIRLINEASINTERM_SMF(archivo, sbHtml);
	
    blfile       := BFILEname(directorio, sbNombreArchivo || '.' || sBFILEext);
    nuarchexiste := dbms_lob.fileexists(blfile);  --Ticket 200-625 LJLB-- se valida si existe archivo
	
	pkg_traza.trace('nuarchexiste: '||nuarchexiste);

     PKG_GESTIONARCHIVOS.prcCerrarArchivo_smf(archivo);  --Ticket 200-625 LJLB-- se cierra archivo
	 
     dbms_lob.fileOPEN(blfile, dbms_lob.file_readonly);

     nutam_archivo := dbms_lob.getlength(blfile);
	 
	 pkg_traza.trace('nutam_archivo: '||nutam_archivo);
     
	 dbms_lob.createtemporary(adjunto, TRUE);
     
	 dbms_lob.loadfromfile(adjunto, blfile, nutam_archivo);
     
	 dbms_lob.close(blfile);

     --Ticket 200-625 LJLB-- si existe archivo se procede a enviar correo
    IF    nutam_archivo >= 1 THEN
		FOR reg IN cuCorreos LOOP
		
		   pkg_Correo.prcEnviaCorreo(
										isbRemitente        => sbfrom,
										isbDestinatarios    => TRIM(reg.correo),
										isbAsunto           => sbsubject,
										isbMensaje          => sbmsg,
										isbArchivos         => directorio||'/'||sBFILEname ||'.'|| sBFILEext

									);
		
		END LOOP;
    ELSE
       sbErrorMessage := 'No se pudo crear archivo';
     nuOk := -1;
    END IF;

    nuOk := 0;

 	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_error.getError(oerrorNumber, oerrorMessage);
    nuOk := -1;
	pkg_traza.trace(csbMetodo||' '||oerrorMessage);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
    ROLLBACK;
    nuOk := -1;
	pkg_error.setError;
	pkg_error.getError(oerrorNumber, oerrorMessage);
	pkg_traza.trace(csbMetodo||' '||oerrorMessage);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	RAISE pkg_error.controlled_error;

  END;

   PROCEDURE LDC_LDCINGCEI IS

    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-11-23
      Ticket      : 200-625
      Descripcion : Validacion de los Parametros del PB LDCINGCEI [Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos]

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    cnuNULL_ATTRIBUTE CONSTANT NUMBER := 2126;
    sbPEFAANO   ge_boInstanceControl.stysbValue; --Ticket 200-625  LJLB -- Se almacena el a?o para el proceso
    sbPEFAMES   ge_boInstanceControl.stysbValue; --Ticket 200-625  LJLB -- Se almacena el mes para el proceso
	nuMes       NUMBER; --Ticket 200-625  LJLB -- Se almacena el mes para el proceso
    nuAno       NUMBER; --Ticket 200-625  LJLB -- Se almacena el a?o para el proceso
    sbMensError VARCHAR2(100); --Ticket 200-625  LJLB -- Se almacena el mensaje de error
    nuErrorCode NUMBER;  --Ticket 200-625 LJLB-- se almacena codigo de error
    sbMensaje   VARCHAR2(100); --Ticket 200-625  LJLB -- Se almacena el mensaje de error
	csbMetodo VARCHAR2(100) := csbSP_NAME||'LDC_LDCINGCEI';

   BEGIN
       
   		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

       sbPEFAANO     := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAANO'); --Ticket 200-625  LJLB -- Se obtiene el a?o ingresado
       sbPEFAMES     := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAMES'); --Ticket 200-625  LJLB -- Se obtiene el mes ingresado
       --Ticket 200-625  LJLB -- Se valida que los campos no sea nulos

       IF (sbPEFAANO IS NULL) THEN
           pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'A?o');
       END IF;

       IF (sbPEFAMES IS NULL) THEN
	       pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Mes');
       END IF;

       nuMes := TO_NUMBER(sbPEFAMES);
        --Ticket 200-625  LJLB -- Se valida que el mes ingresado sea valido

       IF nuMes <= 0 OR nuMes > 12 THEN
          sbMensError := 'Error Mes Invalido';
          RAISE PKG_ERROR.CONTROLLED_ERROR;
       END IF;

       nuAno := TO_NUMBER(sbPEFAANO);
       --Ticket 200-625  LJLB -- Se valida que el a?o ingresado sea valido
       IF nuAno <= 0 THEN
          sbMensError := 'Error A?o Invalido';
          RAISE PKG_ERROR.CONTROLLED_ERROR;
       END IF;

       pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
		WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_error.getError(nuErrorCode, sbMensaje);
		pkg_traza.trace(csbMetodo||' sbMensaje: '||sbMensaje|| ' sbMensError: '||sbMensError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,sbMensError);
		WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuErrorCode, sbMensaje);
		pkg_traza.trace(csbMetodo||' sbMensaje: '||sbMensaje|| ' sbMensError: '||sbMensError);
		pkg_traza.trace(csbMetodo||' '||sbMensError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,sbMensError);
    END LDC_LDCINGCEI;



   PROCEDURE LDC_PROCINGCEI( nuAnio IN NUMBER,
                             nuMess IN NUMBER
                             ) IS

   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-11-23
      Ticket      : 200-625
      Descripcion : Generamos informacion del reporte LDRINGCEIR  [Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos].

      Parametros Entrada
      nuano A?o
      numes Mes
      Valor de salida
      sbmen  mensaje
      nuError  codigo del error

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

  dtFechIni DATE; --Ticket 200-625 LJLB-- se almacena la fecha inicial
  dtFechFin DATE; --Ticket 200-625 LJLB-- se almacena la fecha final
  nuAno    NUMBER; --Ticket 200-625 LJLB-- se almacena el a?o
  nuMes    NUMBER; --Ticket 200-625 LJLB-- se almacena el mes
  nuOk     NUMBER;

  --Ticket 200-625 LJLB-- se crea registro de equipos programados
  TYPE array_equiprog IS RECORD(
                                nuAnio    LDC_EQUIPROG.eqprano%TYPE  ,
                                nuMes      LDC_EQUIPROG.eqprmes%TYPE  ,
                                nuItem     LDC_EQUIPROG.eqpritem%TYPE ,
                                nuItse     LDC_EQUIPROG.eqpritse%TYPE ,
                                dtFechPrg  LDC_EQUIPROG.eqprfepr%TYPE
                            );

   TYPE t_array_equiprog IS TABLE OF array_equiprog; --Ticket 200-625 LJLB-- se crea  TABLE pl de equipos programados
   v_array_equiprog  t_array_equiprog; --Ticket 200-625 LJLB-- se crea variable tipo TABLE pl

  TYPE t_array_equicali IS TABLE OF LDC_EQUICALI%ROWTYPE; --Ticket 200-625 LJLB-- se crea  TABLE pl de equipos calibrados
  v_array_equicali  t_array_equicali; --Ticket 200-625 LJLB-- se crea variable tipo TABLE pl

  --Ticket 200-625 LJLB-- se consulta equipos programados en el mes actual
  CURSOR cuEquiProg IS
  SELECT nuAno anio,
         nuMes mes,
         i.items_id ITEM,
         ob.ID_ITEMS_SERIADO ITEM_SERIADO,
         ch.valid_until certificado_hasta
  FROM  or_item_pattern ch,
        GE_ITEMS_SERIADO ob,
        ge_items i,
        GE_ITEMS_TIPO t,
        IF_MAINT_ITEMSER ma,
        ge_items dac
  WHERE ch.id_items_seriado = ob.id_items_seriado
    AND ob.items_id = i.items_id
    AND i.ID_ITEMS_TIPO = t.ID_ITEMS_TIPO
    AND t.seriado = 'Y'
    AND i.items_id = ma.item_id
    AND ma.activity = dac.items_id
    AND UPPER(dac.description) LIKE '%CALIBRACI%'
    AND ch.valid_until >= dtFechIni
    AND ch.valid_until <=  dtFechFin;

  --Ticket 200-625 LJLB-- se consulta equipos calibrados del mes anterior

  CURSOR cuEquiCali IS
  WITH CALIBRADOS AS(
  SELECT DISTINCT
        I.id_items_tipo id_tipo_instrumento,
        i.items_id id_item,
        ob.id_items_seriado item_seriado,
        o.order_id orden,
        ob.id_items_estado_inv  estado,
        ob.id_items_estado_inv || ' - ' || es.descripcion estado_equipo,
        ob.serie serie_item,
        o.assigned_date fecha_recepcion,
        o.legalization_date fecha_calibracion,
        ch.valid_until fecha_certificacion
  FROM   OR_ORDER_ACTIVITY ac,
       ge_items dac,
       or_order o,
       or_order_items io ,
       GE_ITEMS_SERIADO ob,
       ge_items i,
       ge_items_estado_inv es,
       IF_MAINT_ITEMSER ma,
       or_item_pattern ch
  WHERE ac.activity_id = dac.items_id
      AND ac.order_id = o.order_id
      AND o.order_id = io.order_id
      AND ac.serial_items_id = ob.id_items_seriado(+)
      AND ob.items_id = i.items_id(+)
      AND o.ORDER_STATUS_ID IN (8)
      AND ob.id_items_estado_inv = es.id_items_estado_inv(+)
      AND ((ac.ACTIVITY_ID = ma.ACTIVITY
      AND io.items_id = ma.item_id)
            OR (o.task_type_id IN (  SELECT TIPO_TRABAJO
                                    FROM (
                                       SELECT DISTINCT 1 id , TO_NUMBER(regexp_substr( PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_TITR_CALIBRA') ,'[^,]+', 1, LEVEL ) ) as tipo_trabajo
                                             , LEVEL
                                        FROM DUAL A
                                        CONNECT BY regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_TITR_CALIBRA'), '[^,]+', 1, LEVEL)
                                                  IS NOT NULL
                                        ORDER BY id, LEVEL))))

            AND ob.id_items_seriado = ch.id_items_seriado(+)
            AND o.legalization_date >= dtFechIni
            AND o.legalization_date <= dtFechFin
        )
  SELECT nuAno anio,
         nuMes mes,
         id_tipo_instrumento,
         id_item,
         item_seriado,
         orden,
         estado,
         serie_item,
         fecha_recepcion,
         fecha_calibracion,
         fecha_certificacion
  FROM CALIBRADOS C
  WHERE (C.ESTADO_EQUIPO = ' - ' AND (SELECT COUNT(*) FROM CALIBRADOS CC WHERE CC.orden = C.orden) <= 1) OR
        (C.ESTADO_EQUIPO <> ' - ');

  --Ticket 200-625 LJLB-- se consulta cantidad de equipos programados y calibrados

  CURSOR cuCantCali IS
  SELECT /*+ ordered
            INDEX   (ep,      idx_LDC_EQUIPROGA)
            INDEX   (ec,      idx_LDC_EQUICALI) */
        ep.EQPRANO anio,
        ep.EQPRMES mes,
        ep.EQPRITEM item,
        ep.EQPRITSE item_seriado,
        COUNT(*) cantidad,
          ROUND(AVG(EQCALFCAL - EQCALFREC),2) PROMEDIO
  FROM LDC_EQUIPROG ep
   JOIN LDC_EQUICALI ec ON ec.EQCALANO = ep.EQPRANO  AND ec.EQCALMES = ep.EQPRMES AND eqcalitemid = ep.EQPRITEM AND eqcalitser = ep.EQPRITSE
  WHERE   ep.EQPRANO = nuAno AND ep.EQPRMES = numes
  GROUP BY ep.EQPRANO, ep.EQPRMES, ep.EQPRITEM, ep.EQPRITSE
  UNION
  SELECT /*+ ordered
              INDEX   (ep,      idx_LDC_EQUIPROGA)
              INDEX   (ec,      idx_LDC_EQUICALI) */
          ep.EQPRANO anio,
          ep.EQPRMES mes,
          ep.EQPRITEM ,
          ep.EQPRITSE,
          0 cantidad,
          0 PROMEDIO
  FROM LDC_EQUIPROG ep
  WHERE   ep.EQPRANO = nuAno AND ep.EQPRMES = numes
     AND NOT EXISTS ( SELECT 1
                       FROM LDC_EQUICALI ec
                       WHERE ec.EQCALANO = ep.EQPRANO  AND ec.EQCALMES = ep.EQPRMES AND eqcalitemid = ep.EQPRITEM AND eqcalitser = ep.EQPRITSE);


  --Ticket 200-625 LJLB-- se consulta los indicadores de equipos e instrumento

  CURSOR cuResuIndi IS
   WITH CantProg AS
   ( SELECT COUNT(*) cantidad
    FROM LDC_EQUIPROG ep
    WHERE ep.EQPRANO = nuAno AND ep.EQPRMES = numes
    )
   , cantCali AS
   (
    SELECT SUM(CANTIDAD) CANTIDAD,
           SUM(PROMEDIO) PROMEDIO,
           SUM(NUME_CALI) NUME_CALI,
           SUM(nume_caap) nume_caap,
           SUM(nume_caacg) nume_caacg,
           SUM(nume_caat) nume_caat,
           SUM(nume_catf) nume_catf,
           SUM(nume_cavo) nume_cavo
    FROM (
           SELECT COUNT(*) cantidad,
                  ROUND(AVG(EQCALFCAL - EQCALFREC),2) PROMEDIO,
                  0 nume_cali,
                  (SELECT COUNT(*)
                    FROM LDC_EQUICALI ec1
                    WHERE ec.EQCALANO = ec1.EQCALANO  AND ec.EQCALMES = ec1.EQCALMES AND ec1.EQCALTINS = 17) nume_caap,
                    (SELECT COUNT(*)
                    FROM LDC_EQUICALI ec1
                    WHERE ec.EQCALANO = ec1.EQCALANO  AND ec.EQCALMES = ec1.EQCALMES AND ec1.EQCALTINS = 19) nume_caacg,
                     (SELECT COUNT(*)
                    FROM LDC_EQUICALI ec1
                    WHERE ec.EQCALANO = ec1.EQCALANO  AND ec.EQCALMES = ec1.EQCALMES AND ec1.EQCALTINS = 18) nume_caat,
                     (SELECT COUNT(*)
                    FROM LDC_EQUICALI ec1
                    WHERE ec.EQCALANO = ec1.EQCALANO  AND ec.EQCALMES = ec1.EQCALMES AND ec1.EQCALTINS = 25) nume_catf,
                   (SELECT COUNT(*)
                    FROM LDC_EQUICALI ec1
                    WHERE ec.EQCALANO = ec1.EQCALANO  AND ec.EQCALMES = ec1.EQCALMES AND ec1.EQCALTINS = 26) nume_cavo
           FROM LDC_EQUICALI ec
           WHERE ec.EQCALANO = nuAno  AND ec.EQCALMES = numes
           GROUP BY ec.EQCALANO, ec.EQCALMES
           UNION
           SELECT 0 cantidad,
                  0 PROMEDIO,
                  COUNT(*) nume_cali,
                  0,
                  0,
                  0,
                  0,
                  0
           FROM LDC_EQUICALI ec
           WHERE ec.EQCALANO = nuAno  AND ec.EQCALMES = numes
                AND NOT EXISTS 
				        (SELECT 1 
						 FROM LDC_EQUIPROG ep 
						 WHERE ec.EQCALANO = ep.EQPRANO  
						 AND ec.EQCALMES = ep.EQPRMES 
						 AND eqcalitemid = ep.EQPRITEM 
						 AND eqcalitser = ep.EQPRITSE)
           )
   )
   , Calibraciones AS (
     SELECT  c.cantidad  nume_cali,
             c.PROMEDIO PROMEDIO,
             (SELECT cantidad FROM CantProg) nume_prog,
             (SELECT COUNT(*) FROM ldc_equiprog WHERE EQPRANO = nuAno AND EQPRMES = numes AND EQPRNECP > 0 ) equi_cali_prog,
             (SELECT COUNT(*) FROM ldc_equiprog WHERE EQPRANO = nuAno AND EQPRMES = numes AND EQPRNECP <= 0 ) equi_no_cali,
             nume_cali  nume_cali_no_prog,
             C.nume_caap,
             C.nume_caacg,
             C.nume_caat,
             C.nume_catf,
             C.nume_cavo
    FROM cantCali c

   )
   SELECT nuAno anio,
          nuMes mes,
          nume_cali,
          PROMEDIO,
          nume_prog,
          ROUND(( DECODE(nume_prog,0,0, nume_cali / nume_prog ) * 100) , 2) efic_eq,
          equi_cali_prog,
          equi_no_cali,
          nume_cali_no_prog,
          ROUND(( DECODE(nume_prog,0,0,equi_cali_prog / nume_prog ) * 100) , 2) cump_prog,
          nume_caap,
          nume_caacg,
          nume_caat,
          nume_catf,
          nume_cavo
  FROM  Calibraciones;

  CURSOR cuSesion IS
    SELECT PKG_SESSION.FNUGETSESION,
      USER
    FROM dual;
	
  
  isbCorreo VARCHAR2(4000);
  inLimit  NUMBER(4) := 1000; --Ticket 200-625 LJLB-- se almacena la cantidad de registros a procesar
  nuDia     NUMBER;         --Ticket 200-625 LJLB-- se almacena el dia del sistema
  nusession NUMBER;         --Ticket 200-625 LJLB-- se almacena la session conectada
  sbuser    VARCHAR2(4000); --Ticket 200-625 LJLB-- se almacena el usuario conectado
  nuErrorCode     NUMBER;  --Ticket 200-625 LJLB-- se almacena codigo de error
  sbErrorMessage  VARCHAR2(200);  --Ticket 200-625 LJLB-- se almacena el mensaje de error
  nuTotalJobs NUMBER;  --Ticket 200-625 LJLB-- se almacena erl total de jobs ejecutANDo
  nuConta NUMBER := 0;  --Ticket 200-625 LJLB-- se almacena la cantidad de registros procesados
  sbfrom        VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_SMTP_SENDER');
  sbAsunsto     VARCHAR2(4000);
  sbMensaje		VARCHAR2(4000);
  sbProceso     VARCHAR2(70) := 'LDC_PROCINGCEI'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
  
  csbMetodo VARCHAR2(100) := csbSP_NAME||'LDC_PROCINGCEI';



BEGIN

 	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    nuAno := TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')); --Ticket 200-625 LJLB-- se consulta el a?o actual
    nuMes := TO_NUMBER(TO_CHAR(SYSDATE,'MM'));   --Ticket 200-625 LJLB-- se consulta el mes actual
    --Ticket 200-625 LJLB -- se consulta session y usuario conectado

    IF cuSesion%ISOPEN THEN
       CLOSE cuSesion;
	END IF;

	OPEN cuSesion;
	FETCH cuSesion INTO nusession,sbuser;
	CLOSE cuSesion;

	pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

    --Ticket 200-625 LJLB -- se eliminan datos de la tabla para el a?o y mes ingresado
    DELETE
    FROM LDC_EQUIPROG
    WHERE eqprano = nuAno
     AND eqprmes   = nuMes;
    COMMIT;

    dtFechIni := TO_DATE('01/'||nuMes||'/'||nuAno||' 00:00:00','DD/MM/YYYY HH24:MI:SS'); --Ticket 200-625 LJLB -- se calcula la fecha inical del a?o y mes ingresado
    dtFechFin := TO_DATE(TO_CHAR(LAST_DAY(dtFechIni),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS'); --Ticket 200-625 LJLB -- se calcula la fecha final del a?o y mes ingresado
    --Ticket 200-625 LJLB -- se procesan los equipos programados del mes actual
    OPEN cuEquiProg;
    LOOP
    FETCH cuEquiProg   BULK COLLECT INTO  v_array_equiprog LIMIT inLimit ;
     FOR i IN 1..v_array_equiprog.count LOOP
        INSERT INTO LDC_EQUIPROG ( eqprano,
                                   eqprmes,
                                   eqpritem,
                                   eqpritse,
                                   eqprfepr)
                   VALUES ( v_array_equiprog(i).nuAnio,
                            v_array_equiprog(i).nuMes,
                            v_array_equiprog(i).nuItem,
                            v_array_equiprog(i).nuItse,
                            v_array_equiprog(i).dtFechPrg);
     END LOOP;
     COMMIT;
     EXIT WHEN cuEquiProg%NOTFOUND;
    END LOOP;
    CLOSE cuEquiProg;


    dtFechIni := TO_DATE('01/'||TO_CHAR(ADD_MONTHS(SYSDATE, -1),'MM')||'/'||TO_CHAR(ADD_MONTHS(SYSDATE, -1),'YYYY')||' 00:00:00','DD/MM/YYYY HH24:MI:SS'); --Ticket 200-625 LJLB -- se calcula la fecha inical del mes anterior al a?o y mes ingresado
    dtFechFin := TO_DATE(TO_CHAR(LAST_DAY(dtFechIni),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS'); --Ticket 200-625 LJLB -- se calcula la fecha final del mes anterior al a?o y mes ingresado
    nuAno := TO_NUMBER(TO_CHAR(dtFechIni,'YYYY')); --Ticket 200-625 LJLB-- se consulta el a?o de la fecha anterior
    nuMes := TO_NUMBER(TO_CHAR(dtFechIni,'MM')); --Ticket 200-625 LJLB-- se consulta el mes de la fecha anterior

    --Ticket 200-625 LJLB-- se procesan los equipos calibrados en el mes anterior
    OPEN cuEquiCali;
    LOOP
    FETCH cuEquiCali BULK COLLECT INTO  v_array_equicali LIMIT inLimit ;
     FORALL i IN 1 .. v_array_equicali.COUNT
        INSERT INTO LDC_EQUICALI
        VALUES v_array_equicali(i);
     EXIT WHEN cuEquiCali%NOTFOUND;
    END LOOP;
    COMMIT;

    CLOSE cuEquiCali;

    --Ticket 200-625 LJLB-- se actualizan el numero de calibraciones y promedio por equipo programado
    FOR reg IN cuCantCali LOOP
       UPDATE LDC_EQUIPROG ep
	   SET ep.EQPRPRCE = reg.PROMEDIO,
           ep.EQPRNECP = reg.cantidad
       WHERE ep.EQPRANO = reg.anio  AND
             ep.EQPRMES = reg.mes   AND
             ep.EQPRITEM = reg.item AND
             ep.EQPRITSE = reg.item_seriado;

      nuConta := nuConta + 1;

       IF nuConta = 1000 THEN
          COMMIT;
          nuConta := 0;
       END IF;
    END LOOP;
    COMMIT;

    --Ticket 200-625 LJLB-- se realiza proceso de calculo de indicadores

    FOR reg IN cuResuIndi LOOP
       INSERT INTO LDC_INDIEQCA 
	                           (ideqano, 
							   ideqmes, 
							   ideqncrp, 
							   idideprce, 
							   ideqnepp, 
							   ideqevem,
							   ideqnecp,
                               ideqnepnc, 
							   ideqncnpp, 
							   ideqncpce, 
							   ideqnecap, 
							   ideqnecac, 
							   ideqnecat, 
							   ideqnectf, 
							   ideqnecav)
              VALUES (  reg.ANIO, 
						reg.MES, 
						reg.NUME_CALI, 
						reg.PROMEDIO, 
						reg.NUME_PROG, 
						reg.EFIC_EQ, 
						reg.EQUI_CALI_PROG,   
						reg.EQUI_NO_CALI,
						reg.NUME_CALI_NO_PROG, 
						reg.CUMP_PROG, 
						reg.NUME_CAAP, 
						reg.NUME_CAACG, 
						reg.NUME_CAAT, 
						reg.NUME_CATF, 
						reg.NUME_CAVO);
     COMMIT;
    END LOOP;

   --Ticket 200-625 LJLB-- se realiza proceso de envio de correo
   proEnviaCorreo(nuAno, nuMes, nuOk, sbErrorMessage);
   IF nuOk = 0 THEN
      --Ticket 200-625 LJLB-- se actualiza proceso como terminado ok
    	pkg_estaproc.prActualizaEstaproc(sbProceso,'OK',sbErrorMessage);
   ELSE
   
     FOR reg IN cuCorreos LOOP 

			 sbAsunsto := 'Error Generandoo archivo de reporte de Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos';
			 sbMensaje := 	'Se produjo un error generar el archivo del reporte de de Indicadores de Gesti?n de la calibraci?n de  Equipos e Instrumentos. 
							Por favor revise el reporte LDRINGCEIR';
			
			   pkg_Correo.prcEnviaCorreo
										(
											isbRemitente        => sbfrom,
											isbDestinatarios    => TRIM(reg.correo),
											isbAsunto           => sbAsunsto,
											isbMensaje          => sbMensaje
										);


     END LOOP;
    END IF;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION

	WHEN OTHERS THEN
	ROLLBACK;
	pkg_error.setError;
	pkg_error.getError(nuErrorCode, sbErrorMessage);
	sbErrorMessage   := 'Error no Controlado, A?O: '||nuAnio||' MES: '||nuMess||' '||sbErrorMessage;
    pkg_estaproc.prActualizaEstaproc(sbProceso,'Error ',sbErrorMessage);
	pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	RAISE pkg_error.controlled_error;
  
 END LDC_PROCINGCEI;

 PROCEDURE LDC_NOVALIDATE IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-11-23
      Ticket      : 200-625
      Descripcion : Proceso para PB que no validan datos.
     Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

   BEGIN
     NULL;
  END LDC_NOVALIDATE;

   FUNCTION FRFGETORDERLOCK RETURN constants_per.tyrefcursor IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Funcion para devolver las ordenes para bloqueo

     Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    csbversion       CONSTANT VARCHAR2(10) := 'OSF-2602';

    -- Cache Unidad de Trabajo con la que se realizo la busqueda
    gnuselectedunit or_operating_unit.operating_unit_id%TYPE;

    TYPE tytbcachedata IS TABLE OF ge_boinstancecontrol.stysbvalue INDEX BY VARCHAR2(50);

    -- Cache de estados asociados a productos
    gtbproducstatusid tytbcachedata;
    -- Mensaje de error: no hay criterio de busqueda
    cnu_NOT_search_crit CONSTANT ge_message.message_id%TYPE := 900619;
   -- Mensaje de error: no se selecciono subcategoria
    cnu_NOT_subcategory CONSTANT ge_message.message_id%TYPE := 900620;
    -- tipos de trabajo que requieren CICLO
    csbtipotrabajoorama ld_parameter.value_chain%TYPE := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('TIPO_TRABAJO_ORAMA_CICLO');

    /* Mensaje que indica que falta un parametro requerido */
    cnunull_attribute CONSTANT ge_message.message_id%TYPE := 2126;
    /* Formato con que el PB instancia la fecha */
    sbdateformat ge_boutilities.stystatementattribute;
    /* Zona */
    sboperating_zone_id ge_boinstancecontrol.stysbvalue;
    /* Unidad de Trabajo */
    sboperating_unit_id ge_boinstancecontrol.stysbvalue;
    /* Orden */
    sborder_id ge_boinstancecontrol.stysbvalue;
    /* Tipo de trabajo */
    sbtask_type_id ge_boinstancecontrol.stysbvalue;
    /* Actividad */
    sbactivity_id ge_boinstancecontrol.stysbvalue;
    /* Solicitud */
    sbpackage_id ge_boinstancecontrol.stysbvalue;
    /* Tipo de solicitud */
    sbpackage_type_id ge_boinstancecontrol.stysbvalue;
    /* Departamento */
    sbdepartment_id ge_boinstancecontrol.stysbvalue;
    /* Localidad */
    sblocality_id ge_boinstancecontrol.stysbvalue;
    /* Direccion */
    sbaddress_id ge_boinstancecontrol.stysbvalue;
    /* Sector Operativo */
    sboperating_sector_id ge_boinstancecontrol.stysbvalue;
    /* Ruta */
    sbroute_id ge_boinstancecontrol.stysbvalue;
    /* Itinerario */
    sbroute_itinerary_id ge_boinstancecontrol.stysbvalue;
    /* Fecha de creacion, rango inferior */
    sbcreated_date_ini ge_boinstancecontrol.stysbvalue;
    /* Fecha de creacion, rango superior */
    sbcreated_date_fin ge_boinstancecontrol.stysbvalue;
    /* Categoria */
    sbsesucate ge_boinstancecontrol.stysbvalue;
    /* Subcategoria */
    sbsesusuca ge_boinstancecontrol.stysbvalue;
    /* Ciclo de fecturacion */
    sbsesucicl ge_boinstancecontrol.stysbvalue;
    /* Ciclo de consumo */
    sbsesucico ge_boinstancecontrol.stysbvalue;
    /* Numero de cuentas con saldo */
    sbaccount_num ge_boinstancecontrol.stysbvalue;
    /* Numero maximo de ordenes */
    sborder_count ge_boinstancecontrol.stysbvalue;
    /* Plan Comercial */
    sbcommercial_plan_id ge_boinstancecontrol.stysbvalue;
    /* Fecha Inicial de Asignacion */
    sbfechainiasig ge_boinstancecontrol.stysbvalue;
    /* Fecha Final de Asignacion */
    sbfechafinasig ge_boinstancecontrol.stysbvalue;

   /* Hint de acceso a tabla de ordenes */
    sbhintorders ge_boutilities.stystatement;
    /* Hint auxiliar de acceso a tabla de ordenes */
    sbhintaux ge_boutilities.stystatement;
    /* Atributos de la consulta de ordenes */
    sbattributesorders ge_boutilities.stystatement;
    /* Tablas de la consulta */
    sbfrom ge_boutilities.stystatement;
    /* Criterios de consulta de ordenes */
     sbwherorders ge_boutilities.stystatement;
    /* Consulta de ordenes */
    sbsqlorders ge_boutilities.stystatement;
    /* Criterios de consulta del resultado de ordenes */
    sbwherglobal ge_boutilities.stystatement;
    /* La zona maneja rutas */
    sbmanagezone or_operating_zone.manage_route%TYPE;
    /* Itinerario */
    rcrouteitinerary daor_route_itinerary.styor_route_itinerary;
    bousepackage BOOLEAN := FALSE;
    /* CURSOR referenciado con datos de la consulta */
    rfresult constants_per.tyrefcursor;
    /* Requiere acceso a la tabla ServSusc */
    bouseservsusc BOOLEAN := FALSE;
    /* Requiere acceso a la tabla PR_Product */
    bousepr_product BOOLEAN := FALSE;
	sbMensaje varchar2(100);
	
	nuErrorCode number;
	sbErrorMessage varchar2(4000);
	csbMetodo VARCHAR2(100) := csbSP_NAME||'FRFGETORDERLOCK';

  BEGIN
  
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

  
	sbdateformat := ldc_boConsGenerales.fsbGetFormatoFecha;
    sboperating_zone_id   := ge_boinstancecontrol.fsbgetfieldvalue('OR_OPERATING_ZONE',
                                                                   'OPERATING_ZONE_ID');
    sboperating_unit_id   := ge_boinstancecontrol.fsbgetfieldvalue('OR_OPERATING_UNIT',
                                                                   'OPERATING_UNIT_ID');
    sborder_id            := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY', 'ORDER_ID');
    sbtask_type_id        := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'TASK_TYPE_ID');
    sbactivity_id         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'ACTIVITY_ID');
    sbpackage_id          := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'PACKAGE_ID');
    sbpackage_type_id     := ge_boinstancecontrol.fsbgetfieldvalue('MO_PACKAGES', 'PACKAGE_TYPE_ID');
    sbdepartment_id       := ge_boinstancecontrol.fsbgetfieldvalue('GE_GEOGRA_LOCATION',
                                                                   'GEO_LOCA_FATHER_ID');
    sblocality_id         := ge_boinstancecontrol.fsbgetfieldvalue('GE_GEOGRA_LOCATION',
                                                                   'GEOGRAP_LOCATION_ID');
    sbaddress_id          := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'ADDRESS_ID');
    sboperating_sector_id := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'OPERATING_SECTOR_ID');
    sbroute_id            := ge_boinstancecontrol.fsbgetfieldvalue('OR_ROUTE', 'ROUTE_ID');
    sbroute_itinerary_id  := ge_boinstancecontrol.fsbgetfieldvalue('OR_ROUTE_ITINERARY',
                                                                   'ROUTE_ITINERARY_ID');
    sbcreated_date_ini    := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'ASSIGNED_DATE');
    sbcreated_date_fin    := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'CREATED_DATE');
    sbsesucate            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUCATE');
    sbsesusuca            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUSUCA');
    sbsesucicl            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUCICL');
    sbsesucico            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUCICO');
    sbactivity_id         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'ACTIVITY_ID');
    sbcommercial_plan_id  := ge_boinstancecontrol.fsbgetfieldvalue('PR_PRODUCT',
                                                                   'COMMERCIAL_PLAN_ID');
    sbaccount_num         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'SEQUENCE');
    sborder_count         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'PRIOR_ORDER_ID');
    sbfechainiasig        := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'MAX_DATE_TO_LEGALIZE');
	sbfechafinasig        := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXEC_ESTIMATE_DATE');
	

   IF (sbtask_type_id IS NOT NULL) THEN
    IF sboperating_unit_id IS NOT NULL THEN
	   -- Se coloca la Unidad seleccionada en la instancia
		gnuselectedunit := TO_NUMBER(sboperating_unit_id);
    END IF;
    -- Se limpia cache
    gtbproducstatusid.delete;
    /* Se define forma de ingresar a la consulta */
    IF (sborder_id IS NULL) AND (sbtask_type_id IS NULL) AND (sbpackage_type_id IS NULL) AND
       (sbpackage_id IS NULL) THEN
      /* Se debe seleccionar alguno de los siguientes criterios: Orden, Solicitud o Tipo de Trabajo */
      
       IF cuMensaje%ISOPEN THEN
	       CLOSE cuMensaje;
	   END IF;
	   
	   OPEN cuMensaje(cnu_NOT_search_crit);
	   FETCH cuMensaje INTO sbMensajeError;
	   CLOSE cuMensaje;

	  pkg_error.setErrorMessage(cnu_NOT_search_crit,sbMensajeError);

    END IF;
    sbfrom := ' or_order ';
    IF Sboperating_unit_id IS NOT NULL THEN
        sbwherorders := sbwherorders 
		||'  (or_order.OPERATING_UNIT_ID = '
		||sboperating_sector_id
		||CHR(10) 
		||' AND or_order.ORDER_STATUS_ID IN ( '
		||pkg_gestionordenes.CNUORDENPROGRAMADA
		||','
		||CHR(10) 
		||pkg_gestionordenes.CNUORDENASIGNADA
		||'))';
    ELSE
        sbwherorders := 
		sbwherorders 
		||'  or_order.ORDER_STATUS_ID IN ('
		|| pkg_gestionordenes.CNUORDENREGISTRADA
		||','
		||CHR(10) 
		||pkg_gestionordenes.CNUORDENPROGRAMADA
		||','
		||CHR(10) 
		||pkg_gestionordenes.CNUORDENASIGNADA
		||')';
    END IF;

    -- Se obtiene la zona de la unidad operativa*/
    IF (sboperating_zone_id IS NULL AND sboperating_unit_id IS NOT NULL) THEN
      sboperating_zone_id := pkg_bcunidadoperativa.fnugetzonaoperativa(sboperating_unit_id);
    END IF;

    /* Tipo de zona */

    IF sboperating_zone_id IS NOT NULL THEN
      /* Tipo de zona */
      sbmanagezone := daor_operating_zone.fsbgetmanage_route(sboperating_zone_id);
    END IF;

    /* Filtro por sectores o zonas */
    IF (sbmanagezone = constants_per.csbno) THEN
      /* Acceso a tabla de ordenes por sectores */
      sbhintorders := '    INDEX ( or_order idx_or_order_09 )';
      /* La zona no maneja rutas */
      IF (sboperating_sector_id IS NULL) THEN
        /* Si no esta definido el sector operativo y la zona no maneja rutas, la orden debe estar en uno
        de los sectores de la zona */
        IF sboperating_zone_id IS NOT NULL THEN
          sbwherorders := sbwherorders 
		                  ||'    AND or_order.operating_sector_id = ge_sectorope_zona.id_sector_operativo ' 
						  || '    AND ge_sectorope_zona.id_zona_operativa = ' 
						  ||sboperating_zone_id 
						  || CHR(10);				
          /* Adiciona la tabla de sectores por zona*/
          sbfrom := ' ge_sectorope_zona, or_order';
          /* Acceso a tabla de ordenes por sectores */
          sbhintorders := '    INDEX ( ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_01 ) ' || CHR(10) ||
                          sbhintorders;
          sbhintaux    := '    INDEX ( ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02 ) ' || CHR(10);
        END IF;
      END IF;
    ELSE
      IF sboperating_sector_id IS NULL THEN
         sbhintorders := '    INDEX ( or_order idx_or_order_012 )';
      ELSE
          /* Acceso a tabla de ordenes por rutas */
          sbhintorders := '    INDEX ( or_order idx_or_order19 )';
      END IF;
      /* La zona maneja rutas */
      IF (sbroute_id IS NULL) THEN
        /* Si no esta definida la ruta y la zona maneja rutas, la orden debe estar en una
        de las rutas de la zona */
        IF sboperating_zone_id IS NOT NULL THEN
          sbwherorders := sbwherorders 
		                  || '    AND or_order.route_id = or_route_zone.route_id ' 
						  || '    AND or_route_zone.operating_zone_id = ' 
						  || sboperating_zone_id 
                          || CHR (10);
          /* Adiciona la tabla de sectores por zona*/
          sbfrom := ' or_route_zone, or_order';
          /* Acceso a tabla de ordenes por sectores */
          sbhintorders := '    INDEX ( or_route_zone IX_OR_ROUTE_ZONE01 ) ' 
		                || CHR(10) 
                        || sbhintorders;

          sbhintaux    := '    INDEX ( or_route_zone IX_OR_ROUTE_ZONE02 ) ' || CHR(10);
        END IF;
      ELSE
        sbwherorders := sbwherorders 
		                || '    AND or_order.route_id = ' 
						|| sbroute_id 
						|| ' ' 
                        || CHR (10);

        IF (sbroute_itinerary_id IS NOT NULL) THEN
          daor_route_itinerary.getrecord(TO_NUMBER(sbroute_itinerary_id), rcrouteitinerary);
          sbwherorders := sbwherorders 
		                  || '    AND or_order.consecutive between ' 
						  || rcrouteitinerary.start_ 
						  || ' AND ' 
						  || rcrouteitinerary.END_ 
						  || ' ' 
                          || CHR (10);

        END IF;
      END IF;
    END IF;

    /* Filtro por orden */
    IF (sborder_id IS NOT NULL) THEN
      /* Acceso a tabla de ordenes por pk */
      sbhintorders := '    
	                  INDEX ( or_order pk_or_order ) ' 
                 	  || CHR(10) 
					  || sbhintaux;
					  
      sbwherorders := sbwherorders
	                  ||'    AND or_order.order_id = ' 
					  || sborder_id 
					  || ' ' 
					  || CHR(10);

    END IF;

    /* Filtro por solicitud */

    IF (sbpackage_id IS NOT NULL) THEN
      sbhintorders := '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_06 ) ' || CHR(10) ||
                      '    INDEX ( or_order pk_or_order ) ' || CHR(10) || sbhintaux;
      sbfrom       := ' or_order_activity,' || sbfrom;
      sbwherorders := sbwherorders
	                  ||'    AND or_order.order_id = or_order_activity.order_id ' 
					  || CHR(10) 
					  || '    AND or_order_activity.package_id = ' 
					  || sbpackage_id 
                      || CHR (10);

    END IF;

    /* Filtro por tipo de trabajo */
    IF (sbtask_type_id IS NOT NULL) THEN
      sbwherorders := sbwherorders 
	                  || '    AND or_order.task_type_id = ' 
					  || sbtask_type_id 
					  || ' ' 
                      || CHR (10);
    END IF;
    /* Filtro por tipo de solicitud */
    IF (sbpackage_type_id IS NOT NULL) THEN
	  -- se valida que la solicitud sea nula para que no repita la tabla or_order_activity
	  IF sbpackage_id IS NULL THEN
	      sbfrom       := sbfrom || ', or_order_activity, mo_packages';
	  ELSE
	     sbfrom       := sbfrom || ', mo_packages';
	  END IF;
      sbhintorders := sbhintorders || CHR(10) ||
                      '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_05 )' || CHR(10) ||
                      '    INDEX ( mo_packages PK_MO_PACKAGES )';

      sbwherorders := 
	        sbwherorders
	        || '    AND or_order_activity.order_id = or_order.order_id ' 
			|| CHR(10) 
			|| '    AND mo_packages.package_id = or_order_activity.package_id ' 
			|| CHR(10) 
			|| '    AND mo_packages.package_type_id = ' 
			|| sbpackage_type_id 
			|| CHR(10);
    END IF;

    /* Filtro por Actividad */
    -- Si ya se concateno or_order_activity ingresANDo el paquete
    IF (sbactivity_id IS NOT NULL) AND (sbpackage_id IS NOT NULL) AND (sborder_id IS NULL) THEN
      sbwherorders := 
	          sbwherorders 
			  || '    AND or_order_activity.activity_id = ' 
			  || sbactivity_id 
			  || ' ' 
			  || CHR(10);

      -- Si no se ha concatenado or_order_activity ingresANDo el paquete */
    ELSIF (sbactivity_id IS NOT NULL) AND (sbpackage_id IS NULL) AND (sborder_id IS NULL) THEN
      sbhintorders := '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_06 ) ' || CHR(10) ||
                      '    INDEX ( or_order pk_or_order ) ' || CHR(10) || sbhintaux;
      sbfrom       := ' or_order_activity,' || sbfrom;
      sbwherorders := 
	          sbwherorders
			  || '    AND or_order.order_id = or_order_activity.order_id ' 
			  || CHR(10) 
			  || '    AND or_order_activity.activity_id = ' 
			  || sbactivity_id 
			  || CHR(10);
    END IF;

    /* Filtro por fecha de creacion */

    IF (sbcreated_date_ini IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango inferior */
      sbwherorders := 
	         sbwherorders 
			 || '    AND or_order.created_date >= to_date(''' 
			 || sbcreated_date_ini 
			 || ''',''' 
			 || sbdateformat 
			 || ''')' 
			 || CHR(10);
    END IF;

    IF (sbcreated_date_fin IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango superior */
      sbwherorders := 
	         sbwherorders 
   	         || '    AND or_order.created_date <= to_date(''' 
			 || sbcreated_date_fin 
			 || ''',''' 
			 || sbdateformat 
			 || ''')' 
			 || CHR(10);
    END IF;
	/* Filtro por fecha de asignacion */

    IF (sbfechainiasig IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango inferior */
      sbwherorders := 
	          sbwherorders 
			  || '    AND or_order.ASSIGNED_DATE >= to_date(''' 
			  || sbfechainiasig 
			  || ''',''' 
			  || sbdateformat 
			  || ''')' 
			  || CHR(10);
    END IF;
    IF (sbfechafinasig IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango superior */
      sbwherorders := 
	          sbwherorders 
			  || '    AND or_order.ASSIGNED_DATE <= to_date(''' 
			  || sbfechafinasig 
			  || ''',''' 
			  || sbdateformat 
			  || ''')' 
			  || CHR(10);
    END IF;
    /* Filtro por numero de ordenes */
    IF (sborder_count IS NOT NULL) THEN
      sborder_count := 'WHERE ROWNUM <= ' || sborder_count || ' ' || CHR(10);
    END IF;
    /* Filtro por direccion, localidad o departamento */
    IF (sbaddress_id IS NOT NULL) THEN
      sbwherorders := 
	       sbwherorders 
		   || '    AND or_order.external_address_id = ' 
		   || sbaddress_id 
		   || ' ' 
		   || CHR(10);
    ELSIF (sblocality_id IS NOT NULL) THEN
      sbwherglobal := 
	        sbwherglobal 
			|| '  AND ab_address.geograp_location_id = ' 
			|| sblocality_id 
			|| ' ' 
			|| CHR(10);
			
    ELSIF (sbdepartment_id IS NOT NULL) THEN
      sbwherglobal := 
	       sbwherglobal 
		   || '  AND GE_BCGeogra_Location.fnuGetDepartment(ab_address.geograp_location_id) = ' 
		   || sbdepartment_id 
		   || ' ' 
		   || CHR(10);
    END IF;


    IF (sbaccount_num IS NOT NULL) THEN
      IF ((sbpackage_id IS NULL) AND (sbpackage_type_id IS NULL)) THEN
        sbhintorders := 
		       sbhintorders 
			   || CHR(10) 
			   || '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_05 )';
        sbfrom       := sbfrom || ', or_order_activity ';
        sbwherorders := 
		        sbwherorders 
				|| '    AND or_order_activity.order_id = or_order.order_id ' 
				|| CHR(10);
      END IF;
      /* Se necesita validar cantidad de cuentas con saldo */
      sbwherorders := 
	          sbwherorders 
			  || '    AND ' 
			  || sbaccount_num 
			  || ' = ' 
			  || '( SELECT count(1) FROM cuencobr ' 
			  || 'WHERE cuconuse = or_order_activity.product_id AND ' 
			  || '(nvl(cucosacu,0) - nvl(cucovrap,0) - ' 
			  || '( CASE WHEN cucovare > 0 THEN cucovare ELSE 0 END )) > 0 )' || CHR(10);
    END IF;

    IF ((sbsesucate IS NOT NULL AND sbsesusuca IS NULL) OR
       (sbsesucate IS NULL AND sbsesusuca IS NOT NULL)) THEN
	   
	   IF cuMensaje%ISOPEN THEN
	       CLOSE cuMensaje;
	   END IF;
	   
	   OPEN cuMensaje(cnu_NOT_subcategory);
	   FETCH cuMensaje INTO sbMensajeError;
	   CLOSE cuMensaje;

	  pkg_error.setErrorMessage(cnu_NOT_subcategory,sbMensajeError);
	  
    ELSIF (sbsesusuca IS NOT NULL) THEN
      /* Se filtra por categoria y subcategoria */
      sbwherorders  := 
	       sbwherorders 
		   || '    AND servsusc.sesusuca = ' 
		   || sbsesusuca 
		   || ' ' 
		   || CHR(10) || '    AND servsusc.sesucate = ' 
		   || sbsesucate 
		   || ' ' 
		   || CHR(10);
      bouseservsusc := TRUE;
    END IF;
    IF (sbsesucico IS NOT NULL) THEN
      /* Se filtra por ciclo de consumo */
      sbwherorders  := 
	         sbwherorders 
			 || '    AND servsusc.sesucico = ' 
			 || sbsesucico 
			 || ' ' 
			 || CHR(10);
      bouseservsusc := TRUE;
    END IF;

    /* Filtro por Plan de Comercial */
   IF (sbcommercial_plan_id IS NOT NULL) THEN
      sbwherorders := 
	        sbwherorders 
			|| '    AND pr_product.commercial_plan_id = ' 
			|| sbcommercial_plan_id 
			|| ' ' 
			|| CHR(10);
      bousepr_product := TRUE;
    END IF;

    -- si se requiere acceso a producto o se ingresa CICLO , se debe adicionar OR_ORDER_ACTIVITY
    IF (bouseservsusc OR bousepr_product OR (sbsesucicl IS NOT NULL)) THEN
      IF ((sbpackage_id IS NULL) AND (sbpackage_type_id IS NULL) AND (sbaccount_num IS NULL) AND
         (sbactivity_id IS NULL)) THEN
        sbhintorders := 
		      sbhintorders 
			  || CHR(10) 
			  || '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_05 )';
        sbfrom       := sbfrom || ', or_order_activity ';
        sbwherorders := 
		     sbwherorders
			 ||'    AND or_order_activity.order_id = or_order.order_id '
                      ;
      END IF;
    END IF;

    /* Se necesita acceso a servsusc */
    IF (bouseservsusc) THEN
      sbhintorders := sbhintorders || CHR(10) ||
                      '    INDEX ( servsusc PK_SERVSUSC ) use_nl( servsusc )';
      sbfrom       := sbfrom || ',  servsusc ';
      sbwherorders := sbwherorders || '    AND servsusc.sesunuse = or_order_activity.product_id';
    END IF;

    /* Se necesita acceso a pr_product */
    IF (bousepr_product) THEN
      sbhintorders := sbhintorders || CHR(10) ||
                      '    INDEX ( pr_product PK_PR_PRODUCT ) use_nl( pr_product )';
      sbfrom       := sbfrom || ',  pr_product ';
      sbwherorders := sbwherorders ||
                      '    AND pr_product.product_id = or_order_activity.product_id';
    END IF;

    -- Se modIFica para que consulte sobre la tabla de contratos y no sobre el producto
    -- las ordenes que se desean consultar por ciclo de facturacion no tienen producto asociado

    IF (sbsesucicl IS NOT NULL) THEN
      /* Se filtra por ciclo de facturacion */

        sbwherorders := sbwherorders || '    AND suscripc.susccicl = ' || sbsesucicl || ' ' ||
                        CHR(10);
        sbhintorders := sbhintorders || CHR(10) ||
                        '    INDEX ( suscripc PK_SUSCRIPC ) use_nl( suscripc )';
        sbfrom       := sbfrom || ', suscripc ';
        sbwherorders := sbwherorders ||
                        '    AND suscripc.susccodi = or_order_activity.subscription_id ';
     
	 END IF;
    
	END IF;

    /* Atributos de la consulta */
    ge_boutilities.addattribute('    ordenes.order_id', '"Orden"', sbattributesorders);
    ge_boutilities.addattribute('    ordenes.numeconu', '"Numerador"', sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetTaskTypeDesc(ordenes.task_type_id)',
                                '"Tipo_de_trabajo"',
                                sbattributesorders);

    ge_boutilities.addattribute('   DECODE(ordenes.estado_orden, NULL, ''NO TIENE ESTADO'',DAOR_ORDER_STATUS.FSBGETDESCRIPTION(ordenes.estado_orden))',
                                '"Estado_Orden"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetActOrden(ordenes.order_id)',
                                '"Actividad"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetOperSectorDesc(ordenes.operating_sector_id)',
                                '"Sector_operativo"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbDepartmentDesc(ab_address.geograp_location_id)',
                                '"Departamento"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbLocalityDesc(ab_address.geograp_location_id)',
                                '"Localidad"',
                                sbattributesorders);
    ge_boutilities.addattribute('    ab_address.address', '"Direccion"', sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetServiceNumber(ordenes.order_id)',
                                '"Numero_de_servicio"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetProductStatus(ordenes.order_id)',
                                '"Estado_Producto"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetComercialPlan(ordenes.order_id)',
                                '"Plan_Comercial"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetStatusCutting(ordenes.order_id)',
                                '"Estado_de_Corte"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetSerialElement(ordenes.order_id)',
                                '"Elemento_de_Medicion"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetObsOrden(ordenes.order_id)',
                                '"Observacion_Orden"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetObsSolicitud(ordenes.order_id)',
                                '"Observacion_Soli"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetNameClient(ordenes.order_id)',
                                '"Cliente"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbRouteDesc(ordenes.route_id)',
                                '"Ruta"',
                                sbattributesorders);

    ge_boutilities.addattribute('    ordenes.consecutive',

                                '"Consecutivo_de_ruta"',

                                sbattributesorders);

    ge_boutilities.addattribute('    ordenes.created_date',

                                '"Fecha_de_creacion"',

                                sbattributesorders);


    /* Finalmente se arma la consulta */

    sbsqlorders := 'SELECT * FROM (WITH ordenes AS (' 
	    || 'SELECT ' 
		|| CHR(10) 
		|| '/*+ ' 
		|| CHR(10) 
		|| '    ordered ' 
		|| CHR(10) 
		|| sbhintorders 
		|| CHR(10) 
		|| '*/ DISTINCT ' 
		|| CHR(10) 
		|| '    or_order.order_id ORDER_ID,' 
		|| CHR(10) 
		|| '    or_order.numerator_id
		|| '' - '' 
		|| or_order.sequence NUMECONU,' 
		|| CHR(10) 
		|| '    or_order.task_type_id TASK_TYPE_ID,' 
		|| CHR(10) 
		|| '    or_order.operating_sector_id operating_sector_id,' 
		|| CHR(10) 
		|| '    or_order.external_address_id external_address_id,' 
		|| CHR(10) 
		|| '    or_order.route_id route_id,' 
		|| CHR(10) 
		|| '    or_order.consecutive consecutive,' 
		|| CHR(10) 
		|| '    or_order.ORDER_STATUS_ID estado_orden,' 
		|| CHR(10) 
		|| '    or_order.created_date created_date' 
		|| CHR(10) 
		|| 'FROM ' 
		|| CHR(10) 
		|| sbfrom 
		|| CHR(10) 
		|| 'WHERE '
		|| CHR(10) 
		|| sbwherorders 
		|| ') ' 
		|| CHR(10) 
		|| 'SELECT ' 
		|| sbattributesorders 
		|| CHR(10) 
		|| 'FROM   ordenes, ab_address ' 
		|| CHR(10) 
		|| 'WHERE  ab_address.address_id(+) = ordenes.external_address_id' ;

    sbsqlorders := sbsqlorders|| sbwherglobal || ') ' || CHR(10) || sborder_count;
    pkg_traza.trace('sbSqlOrders:[' || CHR(10) || sbsqlorders || ']');
    OPEN rfresult FOR sbsqlorders;
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN rfresult;

  EXCEPTION

    WHEN pkg_error.CONTROLLED_ERROR THEN
		pkg_error.getError(nuErrorCode, sbErrorMessage);
		pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		RAISE pkg_error.controlled_error;
	WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuErrorCode, sbErrorMessage);
		pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		RAISE pkg_error.controlled_error;
  END FRFGETORDERLOCK;



  PROCEDURE PROPROCCESLOCK( nuOrden   IN OR_ORDER.ORDER_ID%TYPE,
                            nuCausal  IN OR_ORDER.CAUSAL_ID%TYPE,
                            nuTiCo    IN NUMBER,
                            sbComentario IN VARCHAR2) IS
							
	onuErrorCode    NUMBER;
	osbErrorMessage VARCHAR2(100);

   /**************************************************************************

      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Proceso para el bloqueo de  las ordenes

      Parametros Entrada

      sbOrden     Codigo de la orden
      nuCurrent   Current
      nuTotal     Total

      Valor de salida
       nuCodError Codigo de error
       sbMensaje mensaje de error

      HISTORIA DE MODIFICACIONES

      FECHA         AUTOR       			DESCRIPCION
	  21/05/2019	Miguel Ballesteros		Caso 200-2530 - se eliminaron las acciones de COMMIT y rollback, porque al ser una
															forma de tipo reporte no son necesarias estas acciones.
    ***************************************************************************/

	nuErrorCode number;
	sbErrorMessage varchar2(4000);
	csbMetodo VARCHAR2(100) := csbSP_NAME||'PROPROCCESLOCK';

    BEGIN
	
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

        --Ticket 200-558 LJLB -- se realiza llamado al proceso de bloqueo de la orden
        api_lockorder(
                      nuOrden,
                      nuTiCo,
                      sbComentario,
                      SYSDATE,
					  onuErrorCode,
					  osbErrorMessage
                      );

        --Ticket 200-558 LJLB -- se actualiza causal de bloqueo a la orden
        UPDATE or_order SET causal_id = nuCausal WHERE order_id = nuOrden;
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

		
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE;
        WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.CONTROLLED_ERROR;
			
    END PROPROCCESLOCK;

      FUNCTION FRFGETORDERUNLOCK RETURN constants_per.tyrefcursor IS
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Funcion para devolver las ordenes para desbloqueo PB [LDCORDMO]

      Parametros Entrada
      Valor de salida
      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    csbversion       CONSTANT VARCHAR2(10) := 'OSF-2602';
    -- Cache Unidad de Trabajo con la que se realizo la busqueda
    gnuselectedunit or_operating_unit.operating_unit_id%TYPE;

    TYPE tytbcachedata IS TABLE OF ge_boinstancecontrol.stysbvalue INDEX BY VARCHAR2(50);
    -- Cache de estados asociados a productos
    gtbproducstatusid tytbcachedata;
    -- Mensaje de error: no hay criterio de busqueda
    cnu_NOT_search_crit CONSTANT ge_message.message_id%TYPE := 900619;
    -- Mensaje de error: no se selecciono subcategoria
    cnu_NOT_subcategory CONSTANT ge_message.message_id%TYPE := 900620;
    -- tipos de trabajo que requieren CICLO
    csbtipotrabajoorama ld_parameter.value_chain%TYPE := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('TIPO_TRABAJO_ORAMA_CICLO');

   /* Mensaje que indica que falta un parametro requerido */
    cnunull_attribute CONSTANT ge_message.message_id%TYPE := 2126;
    /* Formato con que el PB instancia la fecha */
    sbdateformat ge_boutilities.stystatementattribute;
    /* Zona */
    sboperating_zone_id ge_boinstancecontrol.stysbvalue;
    /* Unidad de Trabajo */
    sboperating_unit_id ge_boinstancecontrol.stysbvalue;
    /* Orden */
    sborder_id ge_boinstancecontrol.stysbvalue;
    /* Tipo de trabajo */
    sbtask_type_id ge_boinstancecontrol.stysbvalue;
    /* Actividad */
    sbactivity_id ge_boinstancecontrol.stysbvalue;
    /* Solicitud */
    sbpackage_id ge_boinstancecontrol.stysbvalue;
    /* Tipo de solicitud */
    sbpackage_type_id ge_boinstancecontrol.stysbvalue;
    /* Departamento */
    sbdepartment_id ge_boinstancecontrol.stysbvalue;
    /* Localidad */
    sblocality_id ge_boinstancecontrol.stysbvalue;
    /* Direccion */
    sbaddress_id ge_boinstancecontrol.stysbvalue;
    /* Sector Operativo */
    sboperating_sector_id ge_boinstancecontrol.stysbvalue;
    /* Ruta */
    sbroute_id ge_boinstancecontrol.stysbvalue;
    /* Itinerario */
    sbroute_itinerary_id ge_boinstancecontrol.stysbvalue;
    /* Fecha de creacion, rango inferior */
    sbcreated_date_ini ge_boinstancecontrol.stysbvalue;
    /* Fecha de creacion, rango superior */
    sbcreated_date_fin ge_boinstancecontrol.stysbvalue;
    /* Categoria */
    sbsesucate ge_boinstancecontrol.stysbvalue;
    /* Subcategoria */
    sbsesusuca ge_boinstancecontrol.stysbvalue;
    /* Ciclo de fecturacion */
    sbsesucicl ge_boinstancecontrol.stysbvalue;
    /* Ciclo de consumo */
    sbsesucico ge_boinstancecontrol.stysbvalue;
    /* Numero de cuentas con saldo */
    sbaccount_num ge_boinstancecontrol.stysbvalue;
    /* Numero maximo de ordenes */
    sborder_count ge_boinstancecontrol.stysbvalue;
    /* Plan Comercial */
    sbcommercial_plan_id ge_boinstancecontrol.stysbvalue;
    /* Fecha Inicial de Asignacion */
    sbfechainiasig ge_boinstancecontrol.stysbvalue;
    /* Fecha Final de Asignacion */
    sbfechafinasig ge_boinstancecontrol.stysbvalue;
    /* Causal de Bloqueo */
    sbCausal     ge_boinstancecontrol.stysbvalue;
    /* Fecha Inicial de Bloqueo */
    sbfechainibloq ge_boinstancecontrol.stysbvalue;
    /* Fecha Final de Bloqueo */
    sbfechafinbloq ge_boinstancecontrol.stysbvalue;
    /* Hint de acceso a tabla de ordenes */
    sbhintorders ge_boutilities.stystatement;
    /* Hint auxiliar de acceso a tabla de ordenes */
    sbhintaux ge_boutilities.stystatement;
    /* Atributos de la consulta de ordenes */
    sbattributesorders ge_boutilities.stystatement;
    /* Tablas de la consulta */
    sbfrom ge_boutilities.stystatement;
    /* Criterios de consulta de ordenes */
    sbwherorders ge_boutilities.stystatement;
    /* Consulta de ordenes */
    sbsqlorders ge_boutilities.stystatement;
    /* Criterios de consulta del resultado de ordenes */
    sbwherglobal ge_boutilities.stystatement;
    /* La zona maneja rutas */
    sbmanagezone or_operating_zone.manage_route%TYPE;
    /* Itinerario */
    rcrouteitinerary daor_route_itinerary.styor_route_itinerary;
    bousepackage BOOLEAN := FALSE;
    /* CURSOR referenciado con datos de la consulta */
    rfresult constants_per.tyrefcursor;
   /* Requiere acceso a la tabla ServSusc */
    bouseservsusc BOOLEAN := FALSE;
    /* Requiere acceso a la tabla PR_Product */
    bousepr_product BOOLEAN := FALSE;
	
	nuErrorCode number;
	sbErrorMessage varchar2(4000);
	csbMetodo VARCHAR2(100) := csbSP_NAME||'FRFGETORDERUNLOCK';

  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    sbdateformat := ldc_boConsGenerales.fsbGetFormatoFecha;
    sboperating_zone_id   := ge_boinstancecontrol.fsbgetfieldvalue('OR_OPERATING_ZONE',
                                                                   'OPERATING_ZONE_ID');
    sboperating_unit_id   := ge_boinstancecontrol.fsbgetfieldvalue('OR_OPERATING_UNIT',
                                                                   'OPERATING_UNIT_ID');
    sborder_id            := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY', 'ORDER_ID');
    sbtask_type_id        := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'TASK_TYPE_ID');
    sbactivity_id         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'ACTIVITY_ID');
    sbpackage_id          := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'PACKAGE_ID');
    sbpackage_type_id     := ge_boinstancecontrol.fsbgetfieldvalue('MO_PACKAGES', 'PACKAGE_TYPE_ID');
    sbdepartment_id       := ge_boinstancecontrol.fsbgetfieldvalue('GE_GEOGRA_LOCATION',
                                                                   'GEO_LOCA_FATHER_ID');
    sblocality_id         := ge_boinstancecontrol.fsbgetfieldvalue('GE_GEOGRA_LOCATION',
                                                                   'GEOGRAP_LOCATION_ID');
    sbaddress_id          := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'ADDRESS_ID');
    sboperating_sector_id := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'OPERATING_SECTOR_ID');
    sbroute_id            := ge_boinstancecontrol.fsbgetfieldvalue('OR_ROUTE', 'ROUTE_ID');
    sbroute_itinerary_id  := ge_boinstancecontrol.fsbgetfieldvalue('OR_ROUTE_ITINERARY',
                                                                   'ROUTE_ITINERARY_ID');
    sbcreated_date_ini    := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'ASSIGNED_DATE');
    sbcreated_date_fin    := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'CREATED_DATE');
    sbsesucate            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUCATE');
    sbsesusuca            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUSUCA');
    sbsesucicl            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUCICL');
    sbsesucico            := ge_boinstancecontrol.fsbgetfieldvalue('SERVSUSC', 'SESUCICO');
    sbactivity_id         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY',
                                                                   'ACTIVITY_ID');
    sbcommercial_plan_id  := ge_boinstancecontrol.fsbgetfieldvalue('PR_PRODUCT',
                                                                   'COMMERCIAL_PLAN_ID');
    sbaccount_num         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'SEQUENCE');
    sborder_count         := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'PRIOR_ORDER_ID');
    sbfechainiasig        := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'MAX_DATE_TO_LEGALIZE');
  	sbfechafinasig        := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXEC_ESTIMATE_DATE');
    sbCausal              := ge_boinstancecontrol.fsbgetfieldvalue ('OR_TASK_TYPE_CAUSAL', 'CAUSAL_ID');
    sbfechainibloq        := ge_boinstancecontrol.fsbgetfieldvalue ('OR_ORDER', 'EXEC_INITIAL_DATE');
    sbfechafinbloq        := ge_boinstancecontrol.fsbgetfieldvalue ('OR_ORDER', 'LEGALIZATION_DATE');

    IF sboperating_unit_id IS NOT NULL THEN
	   -- Se coloca la Unidad seleccionada en la instancia
		gnuselectedunit := TO_NUMBER(sboperating_unit_id);
    END IF;

   -- Se limpia cache
    gtbproducstatusid.delete;
    /* Se define forma de ingresar a la consulta */
    IF (sborder_id IS NULL) AND (sbtask_type_id IS NULL) AND (sbpackage_type_id IS NULL) AND
       (sbpackage_id IS NULL) THEN
       
       	   IF cuMensaje%ISOPEN THEN
   	          CLOSE cuMensaje;
   	       END IF;
	   
	       OPEN cuMensaje(cnu_NOT_search_crit);
	       FETCH cuMensaje INTO sbMensajeError;
	       CLOSE cuMensaje;

      /* Se debe seleccionar alguno de los siguientes criterios: Orden, Solicitud o Tipo de Trabajo */
	  pkg_error.setErrorMessage(cnu_NOT_search_crit,sbMensajeError);

    END IF;

    sbfrom := ' or_order ';
    IF Sboperating_unit_id IS NOT NULL THEN
        sbwherorders := sbwherorders ||'  or_order.OPERATING_UNIT_ID = '||sboperating_sector_id||CHR(10) ||
                                        ' AND or_order.ORDER_STATUS_ID IN ( '||pkg_gestionordenes.CNUORDENBLOQUEADA||')';
    ELSE
       sbwherorders := sbwherorders ||'  or_order.ORDER_STATUS_ID IN ('||  pkg_gestionordenes.CNUORDENBLOQUEADA ||')';
    END IF;

    -- Se obtiene la zona de la unidad operativa*/
    IF (sboperating_zone_id IS NULL AND sboperating_unit_id IS NOT NULL) THEN
      sboperating_zone_id := pkg_bcunidadoperativa.fnugetzonaoperativa(sboperating_unit_id);
    END IF;

   /* Tipo de zona */
    IF sboperating_zone_id IS NOT NULL THEN
      /* Tipo de zona */
      sbmanagezone := daor_operating_zone.fsbgetmanage_route(sboperating_zone_id);
    END IF;

    /* Filtro por sectores o zonas */
    IF (sbmanagezone = constants_per.csbno) THEN
      /* Acceso a tabla de ordenes por sectores */
      sbhintorders := '    INDEX ( or_order idx_or_order_09 )';
      /* La zona no maneja rutas */
      IF (sboperating_sector_id IS NULL) THEN
        /* Si no esta definido el sector operativo y la zona no maneja rutas, la orden debe estar en uno
        de los sectores de la zona */
        IF sboperating_zone_id IS NOT NULL THEN
          sbwherorders := 
		        sbwherorders 
				|| '    AND or_order.operating_sector_id = ge_sectorope_zona.id_sector_operativo ' 
				|| '    AND ge_sectorope_zona.id_zona_operativa = ' 
				|| sboperating_zone_id 
				|| CHR(10);
          /* Adiciona la tabla de sectores por zona*/
          sbfrom := ' ge_sectorope_zona, or_order';
          /* Acceso a tabla de ordenes por sectores */
          sbhintorders := '    INDEX ( ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_01 ) ' || CHR(10) ||
                          sbhintorders;
          sbhintaux    := '    INDEX ( ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02 ) ' || CHR(10);
        END IF;
      END IF;
    ELSE
      IF sboperating_sector_id IS NULL THEN
         sbhintorders := '    INDEX ( or_order idx_or_order_012 )';
      ELSE
          /* Acceso a tabla de ordenes por rutas */
          sbhintorders := '    INDEX ( or_order idx_or_order19 )';
      END IF;
      /* La zona maneja rutas */
      IF (sbroute_id IS NULL) THEN
        /* Si no esta definida la ruta y la zona maneja rutas, la orden debe estar en una
        de las rutas de la zona */
        IF sboperating_zone_id IS NOT NULL THEN
          sbwherorders := 
		        sbwherorders 
		        || '    AND or_order.route_id = or_route_zone.route_id ' 
				|| ' AND or_route_zone.operating_zone_id = ' 
				|| sboperating_zone_id 
                || CHR (10);

          /* Adiciona la tabla de sectores por zona*/
          sbfrom := ' or_route_zone, or_order';
         /* Acceso a tabla de ordenes por sectores */
          sbhintorders := '    INDEX ( or_route_zone IX_OR_ROUTE_ZONE01 ) ' || CHR(10) ||
                          sbhintorders;
          sbhintaux    := '    INDEX ( or_route_zone IX_OR_ROUTE_ZONE02 ) ' || CHR(10);
        END IF;
      ELSE
        sbwherorders := sbwherorders || '    AND or_order.route_id = ' || sbroute_id || ' ' ||
                        CHR(10);
        IF (sbroute_itinerary_id IS NOT NULL) THEN
          daor_route_itinerary.getrecord(TO_NUMBER(sbroute_itinerary_id), rcrouteitinerary);
          sbwherorders := sbwherorders || '    AND or_order.consecutive between ' ||
                          rcrouteitinerary.start_ || ' AND ' || rcrouteitinerary.END_ || ' ' ||
                          CHR(10);
        END IF;
      END IF;
    END IF;

    /* Filtro por orden */
    IF (sborder_id IS NOT NULL) THEN
      /* Acceso a tabla de ordenes por pk */
      sbhintorders := '    INDEX ( or_order pk_or_order ) ' 
	        || CHR(10) 
			|| sbhintaux;
      
	  sbwherorders := 
	        sbwherorders
			||'    AND or_order.order_id = ' 
			|| sborder_id 
			|| ' ' 
			|| CHR(10);
    END IF;
    /* Filtro por solicitud */
    IF (sbpackage_id IS NOT NULL) THEN
      sbhintorders := '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_06 ) ' 
	  || CHR(10) 
	  || '    INDEX ( or_order pk_or_order ) ' 
	  || CHR(10) 
	  || sbhintaux;
      sbfrom       := ' or_order_activity,' || sbfrom;
      sbwherorders := 
	       sbwherorders
		   || '    AND or_order.order_id = or_order_activity.order_id ' 
		   || CHR(10) 
		   || '    AND or_order_activity.package_id = ' 
		   || sbpackage_id 
		   || CHR(10);
    END IF;
    /* Filtro por tipo de trabajo */
    IF (sbtask_type_id IS NOT NULL) THEN
      sbwherorders := 
	         sbwherorders 
			 || '    AND or_order.task_type_id = ' 
			 || sbtask_type_id 
			 || ' ' 
			 || CHR(10);
    END IF;
    /* Filtro por tipo de solicitud */
    IF (sbpackage_type_id IS NOT NULL) THEN
	  -- se valida que la solicitud sea nula para que no repita la tabla or_order_activity
	  IF sbpackage_id IS NULL THEN
	      sbfrom       := sbfrom || ', or_order_activity, mo_packages';
	  ELSE
	     sbfrom       := sbfrom || ', mo_packages';
	  END IF;
      sbhintorders := 
	        sbhintorders 
			|| CHR(10) 
			|| '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_05 )' 
			|| CHR(10) 
			|| '    INDEX ( mo_packages PK_MO_PACKAGES )';

      sbwherorders := 
	         sbwherorders
			 || '    AND or_order_activity.order_id = or_order.order_id ' 
			 || CHR(10) 
			 || '    AND mo_packages.package_id = or_order_activity.package_id ' 
			 || CHR(10) 
			 || '    AND mo_packages.package_type_id = ' 
			 || sbpackage_type_id 
			 || CHR(10);
    END IF;

    /* Filtro por Actividad */

    -- Si ya se concateno or_order_activity ingresando el paquete
    IF (sbactivity_id IS NOT NULL) AND (sbpackage_id IS NOT NULL) AND (sborder_id IS NULL) THEN
       sbwherorders := 
	          sbwherorders 
			  || '    AND or_order_activity.activity_id = ' 
			  || sbactivity_id 
			  || ' ' 
			  || CHR(10);

      -- Si no se ha concatenado or_order_activity ingresando el paquete */
    ELSIF (sbactivity_id IS NOT NULL) AND (sbpackage_id IS NULL) AND (sborder_id IS NULL) THEN
      sbhintorders := '    INDEX ( or_order_activity IDX_OR_ORDER_ACTIVITY_06 ) ' 
	       || CHR(10) 
		   || '    INDEX ( or_order pk_or_order ) ' 
		   || CHR(10) 
		   || sbhintaux;

      sbfrom       := ' or_order_activity,' || sbfrom;
      sbwherorders := 
	         sbwherorders
			 || '    AND or_order.order_id = or_order_activity.order_id ' 
			 || CHR(10) 
			 || '    AND or_order_activity.activity_id = ' 
			 || sbactivity_id 
			 || CHR(10);
    END IF;
    /* Filtro por fecha de creacion */
    IF (sbcreated_date_ini IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango inferior */
      sbwherorders := 
	         sbwherorders 
			 || '    AND or_order.created_date >= to_date(''' 
			 || sbcreated_date_ini 
			 || ''',''' 
			 || sbdateformat 
			 || ''')' 
			 || CHR(10);
    END IF;
    IF (sbcreated_date_fin IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango superior */
      sbwherorders := 
	         sbwherorders 
			 || '    AND or_order.created_date <= to_date(''' 
			 || sbcreated_date_fin 
			 || ''',''' 
			 || sbdateformat 
			 || ''')' 
			 || CHR(10);
    END IF;
  	/* Filtro por fecha de asignacion */
    IF (sbfechainiasig IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango inferior */
      sbwherorders := 
	        sbwherorders 
			|| '    AND or_order.ASSIGNED_DATE >= to_date(''' 
			|| sbfechainiasig 
			|| ''',''' 
			|| sbdateformat 
			|| ''')' 
			|| CHR(10);
    END IF;
    IF (sbfechafinasig IS NOT NULL) THEN
      /* Filtro por fecha de creacion de la orden, rango superior */
      sbwherorders := 
	         sbwherorders 
			 || '    AND or_order.ASSIGNED_DATE <= to_date(''' 
			 || sbfechafinasig 
			 || ''',''' 
			 || sbdateformat 
			 || ''')' 
			 || CHR(10);
    END IF;

    /* Filtro por fecha de bloqueo */
    IF (sbfechainibloq IS NOT NULL AND sbfechafinbloq IS NOT NULL ) THEN
      /* Filtro por fecha de creacion de la orden, rango inferior */
      sbwherorders := 
	         sbwherorders 
			 || ' AND  (SELECT  max(STAT_CHG_DATE)
                                              FROM or_order_stat_change ce
                                              WHERE ce.ORDER_ID =or_order.order_id
                                                AND FINAL_STATUS_ID IN ('
						   || pkg_gestionordenes.CNUORDENBLOQUEADA
						   || '))    BETWEEN to_date(''' 
						   || sbfechainibloq 
						   || ''',''' 
						   || sbdateformat 
						   || ''')' 
						   || CHR(10)
                           || ' AND  to_date('''
						   || sbfechafinbloq 
						   || ''',''' 
						   || sbdateformat 
						   || ''')' 
						   || CHR(10);
    ELSE
       IF (sbfechainibloq IS NOT NULL AND sbfechafinbloq IS NULL ) THEN
           sbwherorders := 
		          sbwherorders 
				  || ' AND  (SELECT  max(STAT_CHG_DATE)
                                              FROM or_order_stat_change ce
                                              WHERE ce.ORDER_ID =or_order.order_id
                                                AND FINAL_STATUS_ID IN ('
							 || pkg_gestionordenes.CNUORDENBLOQUEADA
							 || '))    >= to_date(''' 
							 || sbfechainibloq 
							 || ''',''' 
							 || sbdateformat 
							 || ''')' 
							 || CHR(10) ;
       ELSE
           IF (sbfechainibloq IS  NULL AND sbfechafinbloq IS NOT NULL ) THEN
               sbwherorders := 
			          sbwherorders 
					  || ' AND  (SELECT  max(STAT_CHG_DATE)
                                              FROM or_order_stat_change ce
                                              WHERE ce.ORDER_ID =or_order.order_id
                                                AND FINAL_STATUS_ID IN ('
							     || pkg_gestionordenes.CNUORDENBLOQUEADA
								 || '))    <= to_date(''' 
								 || sbfechainibloq 
								 || ''',''' 
								 || sbdateformat 
								 || ''')' 
								 || CHR(10)
								 || ' AND to_date('''
								 ||sbfechafinbloq 
								 || ''',''' 
								 || sbdateformat 
								 || ''')' 
								 || CHR(10);

           END IF;
       END IF;
    END IF;
    /*Filtro por causal de bloqueo*/
   IF sbCausal IS NOT NULL THEN
      sbwherorders := 
	       sbwherorders 
		   || ' AND or_order.causal_id = DECODE('
		   || sbCausal
		   || ',-1, or_order.causal_id ,'
		   || sbCausal||')';
   END IF;
    /* Filtro por numero de ordenes */
    IF (sborder_count IS NOT NULL) THEN
      sborder_count := 'WHERE ROWNUM <= ' || sborder_count || ' ' || CHR(10);
    END IF;

    /* Filtro por direccion, localidad o departamento */
        IF (sbaddress_id IS NOT NULL)
        THEN
            sbwherorders :=
                   sbwherorders
                || '    AND or_order.external_address_id = '
                || sbaddress_id
                || ' '
                || CHR (10);
        ELSIF (sblocality_id IS NOT NULL)
        THEN
            sbwherglobal :=
                   sbwherglobal
                || '  AND ab_address.geograp_location_id = '
                || sblocality_id
                || ' '
                || CHR (10);
        ELSIF (sbdepartment_id IS NOT NULL)
        THEN
            sbwherglobal :=
                   sbwherglobal
                || '  AND GE_BCGeogra_Location.fnuGetDepartment(ab_address.geograp_location_id) = '
                || sbdepartment_id
                || ' '
                || CHR (10);
        END IF;

        IF (sbaccount_num IS NOT NULL)
        THEN
            IF ((sbpackage_id IS NULL) AND (sbpackage_type_id IS NULL))
            THEN
                sbhintorders :=
                       sbhintorders
                    || CHR (10)
                    || '    index ( or_order_activity IDX_OR_ORDER_ACTIVITY_05 )';

                sbfrom := sbfrom || ', or_order_activity ';

                sbwherorders :=
                       sbwherorders
                    || '    AND or_order_activity.order_id = or_order.order_id '
                    || CHR (10);
            END IF;

            /* Se necesita validar cantidad de cuentas con saldo */

            sbwherorders :=
                   sbwherorders
                || '    AND '
                || sbaccount_num
                || ' = '
                || '( SELECT count(1) FROM cuencobr '
                || 'WHERE cuconuse = or_order_activity.product_id AND '
                || '(nvl(cucosacu,0) - nvl(cucovrap,0) - '
                || '( CASE WHEN cucovare > 0 THEN cucovare ELSE 0 END )) > 0 )'
                || CHR (10);
        END IF;
    IF ((sbsesucate IS NOT NULL AND sbsesusuca IS NULL) OR
       (sbsesucate IS NULL AND sbsesusuca IS NOT NULL)) THEN
       
              	   IF cuMensaje%ISOPEN THEN
   	          CLOSE cuMensaje;
   	       END IF;
	   
	       OPEN cuMensaje(cnu_NOT_subcategory);
	       FETCH cuMensaje INTO sbMensajeError;
	       CLOSE cuMensaje;

      /* No puede seleccionar el campo "Categoria" sin seleccionar "Subcategoria" */
	  pkg_error.setErrorMessage(cnu_NOT_subcategory,sbMensajeError);
   
    ELSIF (sbsesusuca IS NOT NULL) THEN
            /* Se filtra por categoria y subcategoria */

            sbwherorders :=
                   sbwherorders
                || '    AND servsusc.sesusuca = '
                || sbsesusuca
                || ' '
                || CHR (10)
                || '    AND servsusc.sesucate = '
                || sbsesucate
                || ' '
                || CHR (10);

            bouseservsusc := TRUE;
    END IF;

    IF (sbsesucico IS NOT NULL) THEN
            /* Se filtra por ciclo de consumo */

            sbwherorders :=
                   sbwherorders
                || '    AND servsusc.sesucico = '
                || sbsesucico
                || ' '
                || CHR (10);

            bouseservsusc := TRUE;
    END IF;

    /* Filtro por Plan de Comercial */

        IF (sbcommercial_plan_id IS NOT NULL)
        THEN
            sbwherorders :=
                   sbwherorders
                || '    AND pr_product.commercial_plan_id = '
                || sbcommercial_plan_id
                || ' '
                || CHR (10);



            bousepr_product := TRUE;
        END IF;
    -- si se requiere acceso a producto o se ingresa CICLO , se debe adicionar OR_ORDER_ACTIVITY
        IF (bouseservsusc OR bousepr_product OR (sbsesucicl IS NOT NULL))
        THEN
            IF (    (sbpackage_id IS NULL)
                AND (sbpackage_type_id IS NULL)
                AND (sbaccount_num IS NULL)
                AND (sbactivity_id IS NULL))
            THEN
                sbhintorders :=
                       sbhintorders
                    || CHR (10)
                    || '    index ( or_order_activity IDX_OR_ORDER_ACTIVITY_05 )';

                sbfrom := sbfrom || ', or_order_activity ';

                sbwherorders :=
                       sbwherorders
                    || '    AND or_order_activity.order_id = or_order.order_id ';
						 
            END IF;
        END IF;
 /* Se necesita acceso a servsusc */
        IF (bouseservsusc)
        THEN
            sbhintorders :=
                   sbhintorders
                || CHR (10)
                || '    index ( servsusc PK_SERVSUSC ) use_nl( servsusc )';

            sbfrom := sbfrom || ',  servsusc ';

            sbwherorders :=
                   sbwherorders
                || '    AND servsusc.sesunuse = or_order_activity.product_id';
        END IF;
    /* Se necesita acceso a pr_product */
        IF (bousepr_product)
        THEN
            sbhintorders :=
                   sbhintorders
                || CHR (10)
                || '    index ( pr_product PK_PR_PRODUCT ) use_nl( pr_product )';

            sbfrom := sbfrom || ',  pr_product ';

            sbwherorders :=
                   sbwherorders
                || '    AND pr_product.product_id = or_order_activity.product_id';
        END IF;
    -- Se modIFica para que consulte sobre la tabla de contratos y no sobre el producto
    -- las ordenes que se desean consultar por ciclo de facturacion no tienen producto asociado
    IF (sbsesucicl IS NOT NULL) THEN
      /* Se filtra por ciclo de facturacion */

        sbwherorders := 
		     sbwherorders 
			 || '    AND suscripc.susccicl = ' 
			 || sbsesucicl 
			 || ' ' 
			 || CHR(10);
        sbhintorders := 
		     sbhintorders 
		     || CHR(10) ||
			 '    INDEX ( suscripc PK_SUSCRIPC ) use_nl( suscripc )';
        sbfrom       := sbfrom || ', suscripc ';
        sbwherorders := 
		      sbwherorders 
			  || '    AND suscripc.susccodi = or_order_activity.subscription_id ';
    END IF;

   /* Atributos de la consulta */
    ge_boutilities.addattribute('    ordenes.order_id', '"Orden"', sbattributesorders);
    ge_boutilities.addattribute('    ordenes.numeconu', '"Numerador"', sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetTaskTypeDesc(ordenes.task_type_id)',
                                '"Tipo_de_trabajo"',
                                sbattributesorders);
    ge_boutilities.addattribute('  DECODE(ordenes.estado_orden, NULL, ''NO TIENE ESTADO'',DAOR_ORDER_STATUS.FSBGETDESCRIPTION(ordenes.estado_orden)) ',
                                '"Estado_Orden"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetActOrden(ordenes.order_id)',
                                '"Actividad"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetOperSectorDesc(ordenes.operating_sector_id)',
                                '"Sector_operativo"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbDepartmentDesc(ab_address.geograp_location_id)',
                                '"Departamento"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbLocalityDesc(ab_address.geograp_location_id)',
                                '"Localidad"',
                                sbattributesorders);
    ge_boutilities.addattribute('    ab_address.address', '"Direccion"', sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetServiceNumber(ordenes.order_id)',
                                '"Numero_de_servicio"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetProductStatus(ordenes.order_id)',
                                '"Estado_Producto"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetComercialPlan(ordenes.order_id)',
                                '"Plan_Comercial"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetStatusCutting(ordenes.order_id)',
                                '"Estado_de_Corte"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetSerialElement(ordenes.order_id)',
                                '"Elemento_de_Medicion"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetObsOrden(ordenes.order_id)',
                                '"Observacion_Orden"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetObsSolicitud(ordenes.order_id)',
                                '"Observacion_Soli"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbGetNameClient(ordenes.order_id)',
                                '"Cliente"',
                                sbattributesorders);
    ge_boutilities.addattribute('    or_bofwassignorder.fsbRouteDesc(ordenes.route_id)',
                                '"Ruta"',
                                sbattributesorders);
    ge_boutilities.addattribute('    ordenes.consecutive',
                                '"Consecutivo_de_ruta"',
                                sbattributesorders);
     ge_boutilities.addattribute('    DECODE(ordenes.causal, NULL, ''NO EXISTE CAUSAL'',DAGE_CAUSAL.FSBGETDESCRIPTION(ordenes.causal))',
                                '"Causal_Bloqueo"',
                                sbattributesorders);
    ge_boutilities.addattribute('    ordenes.created_date',
                                '"Fecha_de_creacion"',
                                sbattributesorders);

   /* Finalmente se arma la consulta */
        sbsqlorders :=
               'SELECT * FROM (WITH ordenes AS ('
            || 'SELECT '
            || CHR (10)
            || '/*+ '
            || CHR (10)
            || '    ordered '
            || CHR (10)
            || sbhintorders
            || CHR (10)
            || '*/ DISTINCT '
            || CHR (10)
            || '    or_order.order_id ORDER_ID,'
            || CHR (10)
            || '    or_order.numerator_id||'' - '' ||or_order.sequence NUMECONU,'
            || CHR (10)
            || '    or_order.task_type_id TASK_TYPE_ID,'
            || CHR (10)
            || '    or_order.operating_sector_id operating_sector_id,'
            || CHR (10)
            || '    or_order.external_address_id external_address_id,'
            || CHR (10)
            || '    or_order.route_id route_id,'
            || CHR (10)
            || '    or_order.consecutive consecutive,'
            || CHR (10)
            || '    or_order.ORDER_STATUS_ID estado_orden,'
            || CHR (10)
            || '    or_order.created_date created_date'
            || CHR (10)
            || 'FROM '
            || CHR (10)
            || sbfrom
            || CHR (10)
            || 'WHERE '
            || CHR (10)
            || sbwherorders
            || ') '
            || CHR (10)
            || 'SELECT '
            || sbattributesorders
            || CHR (10)
            || 'FROM   ordenes, ab_address '
            || CHR (10)
            || 'WHERE  ab_address.address_id(+) = ordenes.external_address_id';

    sbsqlorders := sbsqlorders|| sbwherglobal || ') ' || CHR(10) || sborder_count;

    pkg_traza.trace('sbSqlOrders:[' || CHR(10) || sbsqlorders || ']');

    OPEN rfresult FOR sbsqlorders;
	
 	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    
	RETURN rfresult;
	
  EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
			RAISE;
        WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.controlled_error;
		
  END FRFGETORDERUNLOCK;
  
  
  PROCEDURE PROPROCCESUNLOCK( nuOrden   IN or_order.order_id%TYPE,
                                nuTipoCo  IN NUMBER,
                                sbComentario   IN VARCHAR2,
								nuMedRec  IN NUMBER) IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2016-12-21
      Ticket      : 200-558
      Descripcion : Proceso para el bloqueo de  las ordenes

      Parametros Entrada
      nuOrden   ORDEN DE TRABAJO
      nuTipoCo  TIPO DE COMENTARIO
      sbComentario   COMENTARIO
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        	AUTOR       			DESCRIPCION
	  07/05/2019	Miguel Ballesteros		Caso 200-2530 - desbloqueo de ordenes, asignacion und operativa dummy siempre y
															generacion de solicitud automatica que queda atendida de inmediato
	  15/05/2019	Miguel Ballesteros		Caso 200-2530 - se agrego una nueva validacion despues de la API de asignacion
															para que validar? si habria un mensaje de error o no, y procediera
															a la creacion de la solicitud.
	  21/05/2019	Miguel Ballesteros		Caso 200-2530 - se eliminaron las acciones de COMMIT y rollback, porque al ser una
															forma de tipo reporte no son necesarias estas acciones.
	  13/08/2019    DSALTARIN				Caso 83 		se modifica el encoding de "utf-8" a "ISO-8859-1"
	  13/09/2019    HORBATH					Caso 37 		se agrego medio de recepcion al momento de desbloquear una orden
      20/01/2020    HORBATH         Caso 330    se modifico la estructura para generar una sola solicitud por producto y por dia
      06/05/2021    OLSOFTWARE       CA 742 se valida que la orden se encuentre bloqueada antes de desbloquearla
	***************************************************************************/
    RCORDER DAOR_ORDER.STYOR_ORDER; --Ticket 200-558 LJLB --  se almacena registro de la orden de trabajo

    nuInitialOperUni      or_operating_unit.operating_unit_id%TYPE;
    nuEndOperUni          or_operating_unit.operating_unit_id%TYPE;
    nuOrderFatherId       or_order.order_id%TYPE;
    nuErrorCode           ge_error_log.error_log_id%TYPE;
    sbErrorMessage        ge_error_log.description%TYPE;

    --- nuevas variables caso 200-2530 ---
    sbRequestXML          constants_per.tipo_xml_sol%TYPE;
    nuOrderId             or_order.order_id%TYPE;
    nuOrderActId          or_order_activity.order_activity_id%TYPE;
    nuPackageId           mo_packages.package_id%TYPE;
    nuProductId           pr_product.product_id%TYPE;
    nuAddressId           ab_address.address_id%TYPE;
    nuSuscripc            suscripc.susccodi%TYPE;
    nuSubscriber          ge_subscriber.subscriber_id%TYPE;
    nuContactId           ge_subscriber.identification%TYPE;
    onuPackageId          mo_packages.package_id%TYPE;
    onuMotiveId           mo_motive.motive_id%TYPE;
    SbMess                VARCHAR2(2000);
    nuStatusOt            or_order.order_status_id%TYPE;
	csbMetodo 			  VARCHAR2(100) := csbSP_NAME||'PROPROCCESUNLOCK';

    CURSOR cuOrderAssigend(inuOrderId   or_order.order_id%TYPE)
    IS
        SELECT  or_order_stat_change.final_oper_unit_id unidad_trabajo
        FROM    or_order_stat_change
        WHERE   or_order_stat_change.order_id = inuOrderId
        AND     or_order_stat_change.final_status_id = pkg_gestionordenes.CNUORDENASIGNADA
        AND     or_order_stat_change.final_oper_unit_id IS NOT NULL;

    CURSOR cuEndOperUniAssigend(inuOrderId   or_order.order_id%TYPE)
    IS
        SELECT  or_order_opeuni_chan.target_oper_unit_id
        FROM    or_order_opeuni_chan
        WHERE   or_order_opeuni_chan.order_id = inuOrderId
        AND     or_order_opeuni_chan.target_oper_unit_id IS NOT NULL
        ORDER BY or_order_opeuni_chan.register_date DESC;

    CURSOR cuOrderFather(inuOrderId   or_order.order_id%TYPE)
    IS
        SELECT  or_related_order.order_id
        FROM    or_related_order, or_order
        WHERE   or_related_order.related_order_id = or_order.order_id
        AND     or_order.order_id = inuOrderId;

    CURSOR cu_Valproducto(ORDEN or_order.order_id%TYPE) IS
      SELECT 1
        FROM mo_packages p, mo_motive m
       WHERE p.package_id = m.package_id
         AND package_type_id = 100366
         AND p.request_date >= trunc(SYSDATE)
         AND p.request_date < trunc(SYSDATE + interval '1' day)
         AND m.product_id = (SELECT ooa.product_id
                               FROM Or_Order_Activity ooa
                              WHERE ooa.order_id = ORDEN
                                AND ROWNUM = 1);

   	nuvalprorduc  NUMBER:=0;

    CURSOR cuEstadoOrden(inuOrden or_order.order_id%TYPE) IS
		SELECT order_status_id
		FROM or_order
		WHERE order_id=inuOrden;

    BEGIN

		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


        DAOR_ORDER.CLEARMEMORY;
        DAOR_ORDER.LOCKBYPK(nuOrden, RCORDER); --Ticket 200-558 LJLB --  se obtiene informacion de la orden seleccioANDa
        RCORDER.ARRANGED_HOUR := NULL;

			IF cuEstadoOrden%ISOPEN THEN
			   CLOSE cuEstadoOrden;
			END IF;
			
			OPEN cuEstadoOrden(nuOrden);
			FETCH cuEstadoOrden INTO nuStatusOt;
			CLOSE cuEstadoOrden;

     	    IF nuStatusOt <> 11 THEN
			   SbMess := sbErrorMessage;
			   pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,
			                             'Orden de trabajo ['||RCORDER.order_id||'] no se encuentra en un estado valido para el proceso');
			END IF;

        --CA 2000-2530 se desasigna orden de trabajo
        IF RCORDER.OPERATING_UNIT_ID IS NOT NULL THEN
		    api_unassignorder(RCORDER.order_id,nuTipoCo,NULL,SYSDATE,nuErrorCode,sbErrorMessage);
        ELSE
			--FIN CA 742
			--Ticket 200-558 LJLB --  se hace llamado al proceso que desbloquea la orden
            api_unlockorder ( nuOrden,
                              nuTipoCo,
                              sbComentario,
							  sysdate,
							  nuErrorCode,
							  sbErrorMessage);
        END IF;

        --Ticket 200-558 LJLB --  se valida estado de la oorden haber si esta asignada
        IF (RCORDER.ORDER_STATUS_ID IN ( pkg_gestionordenes.CNUORDENASIGNADA,
                                         pkg_gestionordenes.CNUORDENENESPERA,
                                         pkg_gestionordenes.CNUORDENENEJECUCION,
                                         pkg_gestionordenes.CNUORDENMOVILIZANDO)) THEN

          NULL;

        ELSIF (RCORDER.ORDER_STATUS_ID = pkg_gestionordenes.CNUORDENPROGRAMADA) THEN
           --Ticket 200-558 LJLB --  se hace lalmado al proceso que desprograma la orden
           api_unprogramorder(RCORDER.ORDER_ID, nuTipoCo, NULL, SYSDATE,nuErrorCode,sbErrorMessage);
        END IF;

        --Ticket 200-558 LJLB --  se setea causal de legalizacion a NULL
        UPDATE or_order SET causal_id = NULL WHERE order_id = nuOrden;

    -- Ajustes entregable 200-1280
        -- Se valida si el tipo de trabajo est? en el par?metro
        IF INSTR(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('TASK_TYPES_LDRORDMO'), RCORDER.TASK_TYPE_ID) > 0 THEN
            SbMess := NULL;
            -- CASO 200-2530 ---

                      -- Se valida si la orden estuvo asignada
                  OPEN cuOrderAssigend(nuOrden);
                  FETCH cuOrderAssigend INTO nuInitialOperUni;
                  CLOSE cuOrderAssigend;

                  IF nuInitialOperUni IS NOT NULL THEN
                      -- Se Obtiene la ?ltima unidad a la que estuvo asignada
                      OPEN cuEndOperUniAssigend(nuOrden);
                      FETCH cuEndOperUniAssigend INTO nuEndOperUni;
                      CLOSE cuEndOperUniAssigend;

                      IF nuEndOperUni IS NULL THEN
                          nuEndOperUni := nuInitialOperUni;
                      END IF;

                  ELSE

                      OPEN cuOrderFather(nuOrden);
                      FETCH cuOrderFather INTO nuOrderFatherId;
                      CLOSE cuOrderFather;

                      nuEndOperUni := pkg_bcordenes.fnuObtieneUnidadOperativa(nuOrderFatherId);

                      IF nuEndOperUni IS NULL THEN
                          nuEndOperUni := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('UNI_OPER_DUMMY_LDRORDMO');
                      END IF;

                  END IF;

                  -- Se asigna la orden
                  api_assign_order
                  (
                      nuOrden,
                      nuEndOperUni,
                      nuErrorCode,
                      sbErrorMessage
                  );

                  -- Si es diferente de 0 fue porque gener? error de asignaci?n
                  IF nuErrorCode <> 0 THEN
                      nuEndOperUni := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('UNI_OPER_DUMMY_LDRORDMO');
                      api_assign_order
                      (
                          nuOrden,
                          nuEndOperUni,
                          nuErrorCode,
                          sbErrorMessage
                      );
                  END IF;

    ELSE
      nuErrorCode := 0;
    END IF; 

    OPEN cu_Valproducto(nuOrden);
    FETCH cu_Valproducto INTO nuvalprorduc;
    CLOSE cu_Valproducto;

    -- Se VALIDA QUE NO EXISTA UNA  SOLICITUD 10366
    IF nuvalprorduc <>1 THEN
        -- SI NO HAY NINGUN ERROR EN LA ASIGNACION, ENTONCES PROCEDE A CREAR LA SOLICITUD
        IF nuErrorCode = 0  THEN
             nuErrorCode := NULL;
             sbErrorMessage := NULL;

               -- se definen las variables las cuales se establecer¿¿n en el codigo XML del tr¿¿mite
             --Obtener identificador de or_order_activity
             nuOrderActId := ldc_bcfinanceot.fnuGetActivityId(nuOrden);
             if nuOrderActId IS NULL THEN
                     SbMess := 'No se encontr? Actividad de la orden '||TO_CHAR(nuOrderActId);
                     RAISE PKG_ERROR.CONTROLLED_ERROR;
                 END if;

             --Obtener el producto de la orden
             nuProductId := pkg_bcordenes.fnuObtieneProducto(nuOrden);
             if nuProductId IS NULL THEN
                     SbMess := 'No se encontr? producto de la orden '||TO_CHAR(nuProductId);
                     RAISE PKG_ERROR.CONTROLLED_ERROR;
                 END if;

             --Obtener direcci?n del producto
             nuAddressId := pkg_bcproducto.fnuIdDireccInstalacion(nuProductId);
             if nuAddressId IS NULL THEN
                     SbMess := 'No se encontr? la direccion del producto '||TO_CHAR(nuAddressId);
                     RAISE PKG_ERROR.CONTROLLED_ERROR;
                 END if;

             --Obtener contrato para el producto
             nuSuscripc := pkg_bcproducto.fnuContrato(nuProductId);
             if nuSuscripc IS NULL THEN
                     SbMess := 'No se encontr? el contrato para el contrato '||TO_CHAR(nuSuscripc);
                     RAISE PKG_ERROR.CONTROLLED_ERROR;
                 END if;

             --Obtener suscriptor para el contrato
             nuSubscriber := pkg_bccontrato.fnuidcliente(nuSuscripc);
             if nuSubscriber IS NULL THEN
                     SbMess := 'No se encontr? suscriptor para el contrato '||TO_CHAR(nuSubscriber);
                     RAISE PKG_ERROR.CONTROLLED_ERROR;
                 END if;
           --------------------------------------------------------------------------------------------------------------------------------------
           -- se guarda en una variable el codigo XML del reporte creado, este XML se toma del tramite abierto en la forma PSCRE
           -- el nombre del tramite creado es "LDC - Informaci¿¿n de desbloqueo de Ordenes" y en sbRequest est¿¿ su codigo XML
			 sbRequestXML :=	 pkg_xml_soli_serv_nuevos.getSolicitudDesbloqueoOrdenes(SYSDATE,
																						nuMedRec,
																						nuSubscriber,
																						nuAddressId,
																						sbComentario,
																						nuSubscriber,
																						nuProductId,
																						nuSuscripc
																						);

            /*Ejecuta el XML creado, la solicitud se atender¿¿a con la accion del tramite creado*/
            api_registerRequestByXml(Isbrequestxml =>  sbRequestXML,
                        Onupackageid  =>  onupackageid,
                        Onumotiveid  =>   onumotiveid,
                        Onuerrorcode =>   nuErrorCode,
                        Osberrormessage => sbErrorMessage);
             -- Si es diferente de 0 fue porque gener¿¿ error de asignaci¿¿n
            IF nuErrorCode <> 0 THEN
               SbMess := sbErrorMessage;
                pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,SbMess);
            END IF;
        ELSE
          SbMess := sbErrorMessage;
          pkg_error.setErrorMessage(ld_boconstans.cnuGeneric_Error,SbMess);
        END IF; 
    END IF; 
	
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    EXCEPTION
	  WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMetodo||' '||sbErrorMessage);
			pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.CONTROLLED_ERROR;

    END PROPROCCESUNLOCK;


END LDC_PKGENERAESTRPB;
/