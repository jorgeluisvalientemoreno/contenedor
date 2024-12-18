CREATE OR REPLACE PACKAGE adm_person.LDC_GENERAVTINGVIS IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_GENERAVTINGVIS
    Descripcion    : Paquete donde se implementa la lógica para Venta Ingeniería
    Autor          : Luis Javier Lopez Barrios / Horbath
    Fecha          : 01/04/2017

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha               Autor               Modificacion
    =========           =========           ====================
    14/06/2024          jsoto               OSF-2604: * Se migra a adm_person
    11/06/2024          jpinedc             OSF-2604: * Se usa pkg_Correo.
                                            * Se usa pkg_gestionArchivos en lugar de ge_boFileManager
                                            * Ajustes por estándares 
                                            * Se hace público proEnviaCorreo para prueba por tester   
	08/03/2024			jsoto				OSF-2381: Ajustes:
											Se reemplaza el uso de GE_BOPERSONAL.FNUGETPERSONID por PKG_BOPERSONAL.FNUGETPERSONAID
											Se reemplaza el uso de USERENV('SESSIONID') por PKG_SESSION.FNUGETSESION 
											Se reemplaza el uso de CONSTANTS.TYREFCURSOR por CONSTANTS_PER.TYREFCURSOR
											Se adiciona al asunto de los correos el nombre de la instancia (sbInstanciaBD) de la BD.
											Se ajusta el manejo de errores y trazas por los personalizados
											Se reemplaza el uso deutl_file.file_type por pkg_GestionArchivos.styArchivo
											Se reemplaza el uso deutl_file.fopen por pkg_GestionArchivos.ftAbrirArchivo_Ut
											Se reemplaza el uso deutl_file.new_line por pkg_GestionArchivos.prcEscribeTermLinea_Ut
											Se reemplaza el uso deutl_file.put por pkg_GestionArchivos.prcEscribirLineaSinTerm_Ut
											Se reemplaza el uso deutl_file.fclose por pkg_GestionArchivos.prcCerrarArchivo_Ut
											Se elimina la función FNUVALIDAENTREGA (Se está suprimiendo los "aplicaentrega" de los desarrollos
											                                        se hace la validación y no está siendo usada)
											
    17/07/2023          jcatuchemvm         OSF-1258: Ajuste por encapsulamiento de
                                            procedimientos open
                                              [proGeneraSolicitudVSI]  
                                              [proprocesaSolicitudVSI]                                     
                                            Se actualizan llamados a métodos errors por los
                                            correspondientes en pkg_error
                                            Se eliminan los esquemas en llamados a métodos o tablas de open.
    01/04/2017          Luis Javier Lopez     Creación
  ******************************************************************/
 PROCEDURE PROCVENING(sbCadena IN VARCHAR2,
                      nuLinea IN NUMBER,
                      nuCantReg IN NUMBER,
                      nuOk   OUT NUMBER,
                      sbError OUT VARCHAR2
                      ) ;
 /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : proceso que lee cadena de texto y procesa la venta de servicio de ingenieria

        Parametros Entrada
        sbCadena Cadena separado por coma.
        nuLinea  linea del archivo
        nucantreg   cantidad de registro del archivo

        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
 sbflago varchar2(1);
 PROCEDURE proGeneraSolicitudVSI ( nuProducto IN LDC_DAVEINGTEMP.VETEPROD%TYPE,
                                   nuPerson   IN LDC_DAVEINGTEMP.VETEUSUA%TYPE,
                                   dtFechaGene  IN DATE,
                   nuLinea    IN NUMBER,
                   sbRowId    IN VARCHAR2,
                                   nuOk       OUT NUMBER,
                                   sberror    OUT VARCHAR2) ;

   /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : proceso que genera las ventas de ingenieria

        Parametros Entrada
        nuProducto producto
        nuPerson   persona
        nuLinea    Linea a procesar

        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
		15/12/2018   HORBATH     caso 374: Se modifica para eliminar la validación de la instancia.
   ***************************************************************************/

 PROCEDURE PROCVENTAING;
 /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : proceso de vents de ingenia PB LDCREVEINVIS

        Parametros Entrada


        Valor de salida


        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

 FUNCTION fnuValidaEntrega RETURN NUMBER;
   /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : funcion que se encarga de validar si la entrega palica para la gasera

        Parametros Entrada


        Valor de salida


        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

  PROCEDURE proprocesaSolicitudVSI ( sbRowId   IN VARCHAR2,
                                     nuProducto IN LDC_DAVEINGTEMP.VETEPROD%TYPE,
                                     nuLinea    IN NUMBER,
                                     nuOk       OUT NUMBER,
                                     sberror    OUT VARCHAR2);

   /**************************************************************************
        Autor       : Horbath
        Fecha       : 2018-12-17
        Ticket      : 200-2260
        Descripcion : proceso que genera las ventas de ingenieria (reprocesadas)

        Parametros Entrada
		sbRowId    Identificador de la tabla
        nuProducto producto
        nuLinea    Linea a procesar

        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        18/12/2018   HORBATH     200-2260 Creacion procedimiento
   ***************************************************************************/

    PROCEDURE proEnviaCorreo(   sbUsuario IN VARCHAR2,
                                nuSesion IN NUMBER,
                                nuOk OUT NUMBER,
                                sbErrorMessage OUT VARCHAR2
                                );
END LDC_GENERAVTINGVIS;
/

CREATE OR REPLACE PACKAGE BODY adm_person.LDC_GENERAVTINGVIS IS

csbNOMPKG   CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.'; 

PROCEDURE proEnviaCorreo(   sbUsuario IN VARCHAR2,
                            nuSesion IN NUMBER,
                            nuOk OUT NUMBER,
                            sbErrorMessage OUT VARCHAR2
                            ) is

   /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : se envia correo.

        Parametros Entrada
        sbUsuario Usuario
        nuSesion   Sesion

        Valor de salida
         nuOk  -1. Error, 0. Exito
       sbErrorMessage mensaje de error.

        nuError  codigo del error
        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
		
	  04/09/2019    dsaltarin	caso:108.  Se cambia cursro cuCorreo para consultar el person_id
							    y no el user_id.
      ***************************************************************************/



    sbNombreArchivo VARCHAR2(250):='ErrorVenta_'||to_char(sysdate,'DDMMYYYY_HH24MISS'); --Ticket 200-991 LJLB-- se almacena el nombre del archivo
    csbDEFAULT_PATH VARCHAR2(100) := '/tmp'; --Ticket 200-991 LJLB-- se almacena la ruta del archivo
    archivo pkg_GestionArchivos.styArchivo;


    sbMensaje  VARCHAR2(200):= 'El proceso que genera la Venta de Servicio de Ingenieria genero los siguientes errores, por favor valide archivo adjunto';

    --Ticket 200-991 LJLB--  Archivo
    BLFILE  Bfile;

    nuarchexiste  		Number; --Ticket 200-991 LJLB-- valida si creo algun archivo en el disco

    sbfrom        		Varchar2(4000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER'); --Ticket 200-991 LJLB--  se coloca el emisor del correo
    sbfromdisplay 		Varchar2(4000) := 'Open SmartFlex'; --Ticket 200-991 LJLB-- Nombre del emisor
  
    sbtodisplay 		Varchar2(4000) := '';
    sbcc        		ut_string.tytb_string;
    sbccdisplay 		ut_string.tytb_string;
    sbbcc       		ut_string.tytb_string;
   --Ticket 200-991 LJLB-- asunto
    sbsubject 			Varchar2(255) := 'Error al momento de procesar ventas de Ingenieria';
    sbmsg 				Varchar2(10000) := sbMensaje;
    sbcontenttype 		Varchar2(100) := 'text/html';

    sbfilename    		Varchar2(255) := sbNombreArchivo;
    sbfileext     		Varchar2(10) := 'txt'; --Ticket 200-991 LJLB-- especifica el tipo de archivo que se enviar?. ZIP o CSV
    nutam_archivo 		Number;--Ticket 200-991 LJLB-- tamano del archivo a enviar

    --Ticket 200-991 LJLB--  Se consulta log de errores
    CURSOR cuErrores IS
    SELECT 'PRODUCTO: '||LOPRPROD||'| ERROR: '||LOPRERRO||'| FECHA: '||LOPRFEGE||'| PROCESO: '||LOPRPROC datos
    FROM LDC_LOGPROC
    WHERE LOPRUSUA =  sbUsuario
     AND LOPRSESI =  nuSesion;

    --Ticket 200-991 LJLB--  Se consulta correo
    CURSOR cuCorreo IS
    SELECT P.E_MAIL CORREO
    FROM ge_person p
    WHERE P.person_id = PKG_BOPERSONAL.FNUGETPERSONAID;

    sbDato    			VARCHAR2(4000);
    adjunto       		Blob;--Ticket 200-991 LJLB-- file type del archivo final a enviar
    sbCorreo      		ge_person.E_MAIL%type;
    directorio    		Varchar2(255) := dald_parameter.fsbgetvalue_chain('LDC_WF_DIRECTORY_ACTIVDET'); --Ticket 200-991 LJLB-- se consulta directorio del archivo
	csbMetodo 			varchar2(100) := csbNOMPKG||'proEnviaCorreo'; 
	NUERRORCODE			number;
	
  BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
		
      OPEN cuErrores;
      FETCH cuErrores INTO sbDato;
      IF cuErrores%FOUND THEN
        CLOSE cuErrores;

        --Ticket 200-991 LJLB-- se abre archivo para su escritura
        Begin
            archivo := pkg_GestionArchivos.ftAbrirArchivo_Ut(csbDEFAULT_PATH, sbNombreArchivo || '.' || sbfileext, 'w');
        Exception
          When Others Then
            NULL;
         End;
        pkg_GestionArchivos.prcEscribeTermLinea_Ut(archivo);
        pkg_GestionArchivos.prcEscribirLineaSinTerm_Ut(archivo, 'Error al Procesar Venta de Servicio de Ingenieria');

       --Ticket 200-991 LJLB-- se cargan los datos para el indicador
        FOR reg IN cuErrores LOOP

            pkg_GestionArchivos.prcEscribeTermLinea_Ut(archivo);
            pkg_GestionArchivos.prcEscribeTermLinea_Ut(archivo);
            pkg_GestionArchivos.prcEscribirLineaSinTerm_Ut(archivo, reg.datos);
        END LOOP;


       --Ticket 200-991 LJLB-- se escribe en el archivo
      blfile       := bfilename(directorio, sbNombreArchivo || '.' || sbfileext);
      nuarchexiste := dbms_lob.fileexists(blfile);  --Ticket 200-991 LJLB-- se valida si existe archivo


       pkg_GestionArchivos.prcCerrarArchivo_Ut(archivo);  --Ticket 200-991 LJLB-- se cierra archivo

       dbms_lob.open(blfile, dbms_lob.file_readonly);
       nutam_archivo := dbms_lob.getlength(blfile);
       dbms_lob.createtemporary(adjunto, True);
       dbms_lob.loadfromfile(adjunto, blfile, nutam_archivo);
       dbms_lob.close(blfile);

       --Ticket 200-991 LJLB-- si existe archivo se procede a enviar correo
      IF    nutam_archivo >= 1 THEN
           OPEN cuCorreo;
           FETCH cuCorreo INTO sbCorreo;
           IF cuCorreo%FOUND THEN
/*                ut_mailpost.sendmailblobattachsmtp(sbfrom,
                                                sbfromdisplay,
                                                sbCorreo ,
                                                sbtodisplay,
                                                sbcc,
                                                sbccdisplay,
                                                sbbcc,
                                                sbsubject,
                                                sbmsg,
                                                sbcontenttype,
                                                sbfilename,
                                                sbfileext,
                                                adjunto);
*/


            pkg_Correo.prcEnviaCorreo
            (
                isbDestinatarios    => sbCorreo,
                isbAsunto           => sbsubject,
                isbMensaje          => sbmsg,
                isbArchivos         => csbDEFAULT_PATH || '/'|| sbNombreArchivo || '.' || sbfileext,
                isbDescRemitente    => sbfromdisplay
            );                                                
          ELSE
		    sbErrorMessage := 'No se encontro email para enviar correo';
            nuOk := -1;
		  END IF;
          CLOSE cuCorreo;

      ELSE
         sbErrorMessage := 'No se pudo crear archivo';
       nuOk := -1;
      END IF;
   ELSE
     CLOSE cuErrores;
   END IF;


     if sbErrorMessage is null then
      nuOk := 0;
	 end if;

	  pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
	  
  EXCEPTION
    WHEN pkg_error.controlled_error THEN
		pkg_error.getError(NUERRORCODE, SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo||' '||SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		nuOk := -1;
    WHEN OTHERS THEN
      ROLLBACK;
		pkg_error.setError;
		pkg_error.getError(NUERRORCODE, SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo||' '||SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		nuOk := -1;
  END proEnviaCorreo;

PROCEDURE proRegistraLog(sbProceso  IN LDC_LOGPROC.LOPRPROC%TYPE,
                          dtFecha    IN LDC_LOGPROC.LOPRFEGE%TYPE,
                          nuProducto IN LDC_LOGPROC.LOPRPROD%TYPE,
                          sbError    IN LDC_LOGPROC.LOPRERRO%TYPE,
                          nuSesion   IN LDC_LOGPROC.LOPRSESI%TYPE,
                          sbUsuario  IN LDC_LOGPROC.LOPRUSUA%TYPE
                          ) IS
   /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : Proceso que genera log de errores

        Parametros Entrada
        sbProceso  nombre del proceso
        dtFecha    fecha de generacion
        nuProducto producto
        sbError    mensaje de error
        nuSesion   numero de sesion
        sbUsuario  usuario

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
  sbError1 VARCHAR2(4000);
  PRAGMA AUTONOMOUS_TRANSACTION;
  csbMetodo 		varchar2(100) := csbNOMPKG||'proRegistraLog'; 
  NUERRORCODE       number;
  SBERRORMESSAGE    varchar2(4000);
  
 BEGIN
 
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    INSERT INTO LDC_LOGPROC
                        (
                          LOPRPROC,
                          LOPRFEGE,
                          LOPRPROD,
                          LOPRERRO,
                          LOPRSESI,
                          LOPRUSUA
                        )
                VALUES
                (
                  sbProceso,
                  dtFecha,
                  nuProducto,
                  substr(sbError,1,3999),
                  nuSesion,
                  sbUsuario
                );
				
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

   COMMIT;

EXCEPTION
  WHEN OTHERS THEN
  		pkg_error.setError;
		pkg_error.getError(NUERRORCODE, SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo||' '||SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);

		sbError1 := substr(sbError||' Error no controlado '||SBERRORMESSAGE,1,3999);
		
    INSERT INTO LDC_LOGPROC
                        (
                          LOPRPROC,
                          LOPRFEGE,
                          LOPRPROD,
                          LOPRERRO,
                          LOPRSESI,
                          LOPRUSUA
                        )
                VALUES
                (
                  sbProceso,
                  dtFecha,
                  nuProducto,
                  sbError1,
                  nuSesion,
                  sbUsuario
                );
   COMMIT;
 END proRegistraLog;

 PROCEDURE PROCVALIDATOVING ( nuTiso      IN  LDC_DAVEINGTEMP.VETETISO%TYPE,
                              nuTire      IN  LDC_DAVEINGTEMP.VETETIRE%TYPE,
                              nuProducto  IN  LDC_DAVEINGTEMP.VETEPROD%TYPE,
                              nuPuntAte   IN  LDC_DAVEINGTEMP.VETEPATE%TYPE,
                              nuContrato  IN  LDC_DAVEINGTEMP.VETECONT%TYPE,
                              sbObse      IN  LDC_DAVEINGTEMP.VETEOBSE%TYPE,
                              nuCliente   IN  LDC_DAVEINGTEMP.VETECLIE%TYPE,
                              nuDireccion IN  LDC_DAVEINGTEMP.VETEIDDI%TYPE,
                              nuUnidad    IN  LDC_DAVEINGTEMP.VETEUNID%TYPE,
                              nuActividad IN  LDC_DAVEINGTEMP.VETEACTI%TYPE,
                              nuCausal    IN  LDC_DAVEINGTEMP.VETECAUS%TYPE,
                              sbItem      IN  LDC_DAVEINGTEMP.VETEITEM%TYPE,
                              sbDatAdi    IN  LDC_DAVEINGTEMP.VETEDAAD%TYPE,
                              sdComLeg    IN  LDC_DAVEINGTEMP.VETECOLE%TYPE,
                              dtFecha     IN  LDC_DAVEINGTEMP.VETEFEGE%TYPE,
                              nuPersonaLeg   IN  LDC_DAVEINGTEMP.VETEPERS%TYPE,
                              nulinea       IN NUMBER,
                              nuOk        OUT NUMBER,
                              sbError     OUT VARCHAR2) IS
    /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : Validacion de estructura de los campos

        Parametros Entrada
        nuTiso      tipo de solicitud
        nuTire      tipo de recepcion
        nuProducto  producto
        nuPuntAte   punto de atencion
        nuContrato  contrato
        sbObse      observacion de la solicitud
        nuCliente   cliente
        nuDireccion direccion
        nuUnidad    unidad operativa
        nuActividad actividad
        nuCausal    causal de legalizacion
        sbItem      item
        sbDatAdi    datos adicionales
        sdComLeg    comentario
        dtFecha     fecha
        nuPersonaLeg persona que legaliza
        nulinea     numero de linea del archivo.


        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

   nuPersona    LDC_DAVEINGTEMP.VETEUSUA%TYPE := PKG_BOPERSONAL.FNUGETPERSONAID;
   --TICKET 200-991 LJLB -- validar si existe tipo de solicitud
   CURSOR cuExisTiso IS
   SELECT 'X'
   FROM ps_package_type
   WHERE package_type_id = nuTiso;

   --TICKET 200-991 LJLB -- validar si existe tipo de recepcion
   CURSOR cuExisTire IS
   SELECT 'X'
   FROM GE_RECEPTION_TYPE
   WHERE RECEPTION_TYPE_ID =  nuTire;

   --TICKET 200-991 LJLB -- validar si existe producto
   CURSOR cuExiProd IS
   SELECT 'X'
   FROM PR_PRODUCT
   WHERE PRODUCT_ID =  nuProducto;

   --TICKET 200-991 LJLB -- validar si existe punto de atencion
   CURSOR cuExisPuat IS
   SELECT 'X'
   FROM CC_ORGA_AREA_SELLER s, GE_ORGANIZAT_AREA a
   WHERE a.ORGANIZAT_AREA_ID = nuPuntAte
      AND  s.organizat_area_id=a.organizat_area_id
      AND s.PERSON_ID = nuPersona ;

   --TICKET 200-991 LJLB -- validar si existe contrato
   CURSOR cuExisCont IS
   SELECT 'X'
   FROM suscripc
   WHERE susccodi = nuContrato;

   --TICKET 200-991 LJLB -- validar si existe cliente
   CURSOR cuExisClie IS
    SELECT 'X'
    FROM GE_SUBSCRIBER
    WHERE SUBSCRIBER_ID =  nuCliente;

   --TICKET 200-991 LJLB -- validar si existe direccion
   CURSOR cuExisDire IS
   SELECT 'X'
   FROM ab_address
   WHERE ADDRESS_ID =  nuDireccion;

   --TICKET 200-991 LJLB -- validar si existe unidad operativa
   CURSOR cuExisUnidad IS
   SELECT 'X'
   FROM or_operating_unit
   WHERE OPERATING_UNIT_ID =  nuUnidad;

   --TICKET 200-991 LJLB -- validar si existe actividad
   CURSOR cuExisActi IS
   SELECT 'X'
   FROM ge_items
   WHERE ITEMS_ID =  nuActividad;

    --TICKET 200-991 LJLB -- validar si existe causal de legaliacion
   CURSOR cuExisCausal IS
   SELECT 'X'
   FROM ge_causal
   WHERE causal_id = nuCausal;

   --TICKET 200-991 LJLB -- validar si existe la persona
   CURSOR cuPersona IS
   SELECT 'X'
   FROM ge_person
   WHERE person_id = nuPersonaLeg;

   --TICKET 200-991 LJLB -- validar si el producto estasociado al contrato y al cliente
   CURSOR cuValProdCont IS
   SELECT 'X'
   FROM servsusc p, suscripc c, ge_subscriber cl
   WHERE p.sesususc = c.susccodi AND c.suscclie = cl.subscriber_id
      AND p.sesunuse = nuProducto
      AND p.sesususc = NVL( nuContrato, p.sesususc)
      AND c.suscclie = NVL( nuCliente, c.suscclie);

   --TICKET 200-991 LJLB -- validar estructura de la cadena de item
   CURSOR cuValidaItem (sbCadena VARCHAR2)IS
   SELECT 'X'
   FROM DUAL
   WHERE regexp_LIKE(sbCadena ,'[0-9]*>[0-9.,]*>Y$');

  --TICKET 200-991 LJLB -- validar estructura de los datos adicionales
    CURSOR cuValidaDat(sbCadena VARCHAR2) IS
    SELECT  'X'
    FROM DUAL A
    WHERE regexp_LIKE(sbCadena ,'^=')
    union
    SELECT  'X'
    FROM DUAL A
    WHERE regexp_LIKE(sbCadena ,'=$')
    union
    SELECT 'X'
    FROM DUAL A
    WHERE regexp_LIKE(sbCadena ,'[=]');

    --TICKET 200-991 LJLB -- validar estructura del comentario de legalizacion
    CURSOR cuValidaComLeg(sbCadena VARCHAR2) IS
    SELECT  'X'
    FROM DUAL A
    WHERE regexp_LIKE(sbCadena ,'[0-9];.');

   sbDato VARCHAR2(1);
   TBSTRING   ut_string.TYTB_STRING;
   sbSeparador VARCHAR2(1) := ',';
   csbMetodo 			varchar2(100) := csbNOMPKG||'PROCVALIDATOVING'; 

 BEGIN

	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
   nuOk := 0;

   sbError := 'Linea: '||nulinea;
    --TICKET 200-991 LJLB -- validar si existe tipo de solicitud
   OPEN cuExisTiso;
   FETCH cuExisTiso INTO sbDato;
   IF cuExisTiso%NOTFOUND THEN
      sbError := ' Tipo de Solicitud ['||nuTiso||'] No Existe';
      nuOk  := -1;
   END IF;
   CLOSE cuExisTiso;

   --TICKET 200-991 LJLB -- validar si existe tipo de recepcion
   OPEN cuExisTire;
   FETCH cuExisTire INTO sbDato;
   IF cuExisTire%NOTFOUND THEN
      sbError := sbError||', Tipo de Recepcion ['||nuTire||'] No Existe';
      nuOk  := -1;
   END IF;
   CLOSE cuExisTire;

    --TICKET 200-991 LJLB -- validar si existe producto
   OPEN cuExiProd;
   FETCH cuExiProd INTO sbDato;
   IF cuExiProd%NOTFOUND THEN
      sbError := sbError||', Producto ['||nuProducto||'] No Existe';
      nuOk  := -1;
   END IF;
   CLOSE cuExiProd;

   --TICKET 200-991 LJLB -- validar si existe punto de atencion
   OPEN cuExisPuat;
   FETCH cuExisPuat INTO sbDato;
   IF cuExisPuat%NOTFOUND THEN
      sbError := sbError||', Punto de Atencion ['||nuPuntAte||'] No Existe, o no esta asociado a la persona['||nuPersona||']';
      nuOk  := -1;
   END IF;
   CLOSE cuExisPuat;
   --TICKET 200-991 LJLB -- se valida que el producto, contrato y cliente esten relacionados
   OPEN cuValProdCont;
   FETCH cuValProdCont INTO sbDato;
   IF cuValProdCont%NOTFOUND THEN
       sbError := sbError||', Producto ['||nuProducto||'] No esta asociado al contrato ['||nuContrato||'] o al cliente ['||nuCliente||']';
      nuOk  := -1;
   END IF;
   CLOSE cuValProdCont;

   IF nuContrato IS NOT NULL THEN
     --TICKET 200-991 LJLB -- validar si existe contarto
     OPEN cuExisCont;
     FETCH cuExisCont INTO sbDato;
     IF cuExisCont%NOTFOUND THEN
        sbError := sbError||', Contrato ['||nuContrato||'] No Existe';
        nuOk  := -1;
     END IF;
     CLOSE cuExisCont;
   END IF;

  IF nuCliente IS NOT NULL THEN
    --TICKET 200-991 LJLB -- validar si existe cliente
    OPEN cuExisClie;
    FETCH cuExisClie INTO sbDato;
    IF cuExisClie%NOTFOUND THEN
      sbError := sbError||', Cliente ['||nuCliente||'] No Existe';
      nuOk  := -1;
    END IF;
   CLOSE cuExisClie;
  END IF;

    IF nuDireccion IS NOT NULL THEN
     --TICKET 200-991 LJLB -- validar si existe direccion
     OPEN cuExisDire;
     FETCH cuExisDire INTO sbDato;
     IF cuExisDire%NOTFOUND THEN
        sbError := sbError||', Contrato ['||nuDireccion||'] No Existe';
        nuOk  := -1;
     END IF;
     CLOSE cuExisDire;
   END IF;

   --TICKET 200-991 LJLB -- validar si existe unidad operativa
   OPEN cuExisUnidad;
   FETCH cuExisUnidad INTO sbDato;
   IF cuExisUnidad%NOTFOUND THEN
      sbError := sbError||', Unidad Operativa ['||nuUnidad||'] No Existe';
      nuOk  := -1;
   END IF;
   CLOSE cuExisUnidad;

    --TICKET 200-991 LJLB -- validar si existe actividad
   OPEN cuExisActi;
   FETCH cuExisActi INTO sbDato;
   IF cuExisActi%NOTFOUND THEN
      sbError := sbError||', Actividad ['||nuActividad||'] No Existe';
      nuOk  := -1;
   END IF;
   CLOSE cuExisActi;

    --TICKET 200-991 LJLB -- validar si existe causal
   OPEN cuExisCausal;
   FETCH cuExisCausal INTO sbDato;
   IF cuExisCausal%NOTFOUND THEN
      sbError := sbError||', Causal ['||nuActividad||'] No Existe';
      nuOk  := -1;
   END IF;
   CLOSE cuExisCausal;

   OPEN cuPersona;
   FETCH cuPersona INTO sbDato;
   IF cuPersona%NOTFOUND THEN
      sbError := sbError||', persona ['||nuPersonaLeg||'] No Existe';
      nuOk  := -1;
   END IF;
   CLOSE cuPersona;

    --TICKET 200-991 LJLB --validacion de cadena de items
   IF sbItem IS NOT NULL THEN
      TBSTRING.DELETE;
       ut_string.EXTSTRING(sbItem, ';' , TBSTRING);
      FOR NUPOS IN TBSTRING.FIRST..TBSTRING.LAST LOOP

         OPEN cuValidaItem(TBSTRING(NUPOS));
         FETCH cuValidaItem INTO sbDato;
         IF cuValidaItem%NOTFOUND THEN
            sbError := sbError||', Cadena de Item Erronea['||TBSTRING(NUPOS)||']';
            nuOk  := -1;
            EXIT;
         END IF;
         CLOSE cuValidaItem;
      END LOOP;

   END IF;

  --TICKET 200-991 LJLB --validacion de cadena de datos adicionales
  IF sbDatAdi IS NOT NULL THEN
    TBSTRING.DELETE;
    ut_string.EXTSTRING(sbDatAdi, ';' , TBSTRING);
    FOR NUPOS IN TBSTRING.FIRST..TBSTRING.LAST LOOP

         OPEN cuValidaDat(TBSTRING(NUPOS));
         FETCH cuValidaDat INTO sbDato;
         IF cuValidaDat%NOTFOUND THEN
            sbError := sbError||', Cadena de Datos adicionales Erronea['||TBSTRING(NUPOS)||']';
            nuOk  := -1;
            EXIT;
         END IF;
         CLOSE cuValidaDat;
      END LOOP;

  END IF;

   --TICKET 200-991 LJLB --validacion de cadena de comentario de legalizacion
   IF sdComLeg IS NOT NULL THEN

     OPEN cuValidaComLeg(sdComLeg);
     FETCH cuValidaComLeg INTO sbDato;
     IF cuValidaComLeg%NOTFOUND THEN
            sbError := sbError||', Cadena de Comentario de Legalizacion Erronea['||sdComLeg||']';
            nuOk  := -1;
     END IF;
     CLOSE cuValidaComLeg;

   END IF;
    --TICKET 200-991 LJLB --se valida que la fecha no se mayor que la del sistema
   IF dtFecha > SYSDATE THEN
      sbError := sbError||', Fecha de Generacion es mayor a la del sistema ['||dtFecha||']';
      nuOk  := -1;
   END IF;

	pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR then
		ROLLBACK;
		pkg_error.getError(nuOk, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuOk, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		sbError := 'Error en PROCVALIDATOVING: '||sbError || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
		nuOk := -1;
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
 END PROCVALIDATOVING;

 PROCEDURE PROCVENING(sbCadena IN VARCHAR2,
                      nuLinea IN NUMBER,
                      nuCantReg IN NUMBER,
                      nuOk   OUT NUMBER,
                      sbError OUT VARCHAR2
                      ) IS
   /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : proceso que lee cadena de texto y procesa la venta de servicio de ingenieria

        Parametros Entrada
        sbCadena Cadena separado por coma.
        nuLinea  linea del archivo
        nucantreg   cantidad de registro del archivo

        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/


   TBSTRING   ut_string.TYTB_STRING;
   sbSeparador VARCHAR2(1) := ',';
   csbMetodo 			varchar2(100) := csbNOMPKG||'PROCVENING'; 

   nuTiso       LDC_DAVEINGTEMP.VETETISO%TYPE; --Ticket 200-991 LJLB-- tipo de solicitud
   nuTire       LDC_DAVEINGTEMP.VETETIRE%TYPE; --Ticket 200-991 LJLB-- tipo de recepcion
   nuProducto   LDC_DAVEINGTEMP.VETEPROD%TYPE; --Ticket 200-991 LJLB-- producto
   nuPuntAte    LDC_DAVEINGTEMP.VETEPATE%TYPE; --Ticket 200-991 LJLB-- punto de atencion
   nuContrato   LDC_DAVEINGTEMP.VETECONT%TYPE; --Ticket 200-991 LJLB-- contrato
   sbObse       LDC_DAVEINGTEMP.VETEOBSE%TYPE; --Ticket 200-991 LJLB-- observacion de la solicitud
   nuCliente    LDC_DAVEINGTEMP.VETECLIE%TYPE; --Ticket 200-991 LJLB-- cliente
   nuDireccion  LDC_DAVEINGTEMP.VETEIDDI%TYPE; --Ticket 200-991 LJLB-- direccion
   nuUnidad     LDC_DAVEINGTEMP.VETEUNID%TYPE; --Ticket 200-991 LJLB-- unidad operativa
   nuActividad  LDC_DAVEINGTEMP.VETEACTI%TYPE; --Ticket 200-991 LJLB-- actividad
   nuCausal     LDC_DAVEINGTEMP.VETECAUS%TYPE; --Ticket 200-991 LJLB-- causal de legalizacion
   sbItem       LDC_DAVEINGTEMP.VETEITEM%TYPE; --Ticket 200-991 LJLB-- items
   sbDatAdi     LDC_DAVEINGTEMP.VETEDAAD%TYPE; --Ticket 200-991 LJLB-- datos adicionales
   sdComLeg     LDC_DAVEINGTEMP.VETECOLE%TYPE; --Ticket 200-991 LJLB-- comentario de legalizacion
   dtfege       LDC_DAVEINGTEMP.VETEFEGE%TYPE; --Ticket 200-991 LJLB--fecha de generacion
   nuPersona    LDC_DAVEINGTEMP.VETEUSUA%TYPE; --Ticket 200-991 LJLB-- persona
   nuPersonaLeg    LDC_DAVEINGTEMP.VETEUSUA%TYPE; --Ticket 200-991 LJLB-- persona que legaliza


   --Ticket 200-991 LJLB-- Criterios de consulta de ordenes
    sbwherecons ge_boutilities.stystatement;
    sbwherecons2 ge_boutilities.stystatement;
   --Ticket 200-991 LJLB-- Consulta de ordenes
    sbconsulta  ge_boutilities.stystatement;
    sbconsulta2  ge_boutilities.stystatement;

    --Ticket 200-991 LJLB-- Tablas de la consulta
    sbfrom ge_boutilities.stystatement;

    --Ticket 200-991 LJLB-- Cursor referenciado con datos de la consulta
    rfresult constants_per.tyrefcursor;


   sbDato   VARCHAR2(1); --Ticket 200-991 LJLB-- se almacena dato
   nusession NUMBER := PKG_SESSION.FNUGETSESION;  --Ticket 200-991 LJLB-- se almacena la session conectada
   sbuser    VARCHAR2(4000) := USER; --Ticket 200-991 LJLB-- se almacena el usuario conectado

   nuOkProc NUMBER := 0;
   sbRowId   VARCHAR2(4000);
   
 BEGIN
 
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
 
     --TICKET 200-991 LJLB -- se setean variables
    nuTiso       :=  NULL;
    nuTire       :=  NULL;
    nuProducto   :=  NULL;
    nuPuntAte    :=  NULL;
    nuContrato   :=  NULL;
    sbObse       :=  NULL;
    nuCliente    :=  NULL;
    nuDireccion  :=  NULL;
    nuUnidad     :=  NULL;
    nuActividad  :=  NULL;
    nuCausal     :=  NULL;
    sbItem       :=  NULL;
    sbDatAdi     :=  NULL;
    sdComLeg     :=  NULL;
    nuPersonaLeg := NULL;

     DELETE FROM LDC_LOGPROC WHERE LOPRSESI = nusession AND   LOPRUSUA = sbuser AND 0 = (SELECT COUNT(*) FROM V$SESSION WHERE AUDSID = nusession);
     delete from LDC_DAVEINGTEMP;
     COMMIT;


    ut_string.EXTSTRING(sbCadena, sbSeparador , TBSTRING);  --TICKET 200-991 LJLB --se crera tabla pl con los datos correspondiente
     --TICKET 200-991 LJLB --se obtiene los datos de la tabla pl
    IF TBSTRING.COUNT = 15  THEN
       nuTiso       :=  100101 ;
       nuTire       :=  TBSTRING(1) ;
       nuProducto   :=  TBSTRING(2) ;
       nuPuntAte    :=  TBSTRING(3) ;
       nuContrato   :=  TBSTRING(4) ;
       sbObse       :=  TBSTRING(5) ;
       nuCliente    :=  TBSTRING(6) ;
       nuDireccion  :=  TBSTRING(7) ;
       nuUnidad     :=  TBSTRING(8) ;
       nuActividad  :=  TBSTRING(9);
       nuCausal     :=  TBSTRING(10);
       sbItem       :=  TBSTRING(11);
       sbDatAdi     :=  TBSTRING(12);
       sdComLeg     :=  TBSTRING(13);
       dtfege       :=  to_date(TBSTRING(14),'DD/MM/YYYY');
       nuPersonaLeg := TBSTRING(15);
       nuPersona    := PKG_BOPERSONAL.FNUGETPERSONAID;
   ELSE
     sbError := 'Cadena mal Formada debe ser separada por comas['||sbCadena||']';
     nuOk  := -1;
      proRegistraLog('PROCVENING',SYSDATE,nuProducto,sbError,nusession, sbuser  );
     RETURN;
   END IF;

   sbconsulta := 'SELECT ''X'' FROM LDC_DAVEINGTEMP';
   sbwherecons := ' WHERE VETETISO = '||nuTiso || ' ' || chr(10)
                     ||'AND VETETIRE = '||nuTire || ' ' || chr(10)
                     ||'AND VETEPROD = '||nuProducto || ' ' || chr(10)
                     ||'AND VETEFEGE = TO_DATE('''||dtfege || ''',''DD/MM/YYYY HH24:MI:SS'')' || chr(10)
                     ||'AND VETEPATE = '||nuPuntAte || ' ' || chr(10)
                     ||'AND VETEOBSE = '''||sbObse || ''' ' || chr(10)
                     ||'AND VETEUNID = '||nuUnidad || ' ' || chr(10)
                     ||'AND VETEACTI = '||nuActividad ;

   sbconsulta2 := 'SELECT ''X'' FROM LDC_DAVEING';
   sbwherecons2 := ' WHERE VEINTISO = '||nuTiso || ' ' || chr(10)
                     ||'AND VEINTIRE = '||nuTire || ' ' || chr(10)
                     ||'AND VEINPROD = '||nuProducto || ' ' || chr(10)
                     ||'AND VEINFEGE = TO_DATE('''||dtfege || ''',''DD/MM/YYYY HH24:MI:SS'')' || chr(10)
                     ||'AND VEINPATE = '||nuPuntAte || ' ' || chr(10)
                     ||'AND VEINOBSE = '''||sbObse || ''' ' || chr(10)
                     ||'AND VEINUNID = '||nuUnidad || ' ' || chr(10)
                     ||'AND VEINACTI = '||nuActividad ;

    IF nuContrato IS NOT NULL THEN
      sbwherecons := sbwherecons || ' AND VETECONT = '||nuContrato || ' ' || chr(10);
      sbwherecons2 := sbwherecons2 || ' AND VEINCONT = '||nuContrato || ' ' || chr(10);
    END IF;


    IF nuCliente IS NOT NULL THEN
      sbwherecons := sbwherecons || ' AND VETECLIE = '||nuCliente || ' ' || chr(10);
      sbwherecons2 := sbwherecons2 || ' AND VEINCLIE = '||nuCliente || ' ' || chr(10);
    END IF;

    IF nuDireccion IS NOT NULL THEN
      sbwherecons := sbwherecons || ' AND VETEIDDI = '||nuDireccion || ' ' || chr(10);
      sbwherecons2 := sbwherecons2 || ' AND VEINIDDI = '||nuDireccion || ' ' || chr(10);
    END IF;

    sbfrom := sbconsulta||' '||chr(10)|| sbwherecons||' UNION '||sbconsulta2||' '||chr(10)|| sbwherecons2;
    Open rfresult For sbfrom;

    LOOP
     FETCH rfresult INTO sbDato;
       EXIT WHEN rfresult%NOTFOUND;
    END LOOP;

    IF sbDato IS NOT  NULL THEN
      sbError :=sbError|| ' Registro de Producto, Codigo de la persona, Punto de atencion, Tipo de recepcion, Contrato, Observacion, Unidad Operativa, Cliente,
Direccion, Actividad. Ya existe en la base de datos por favor valide';
      nuOk  := -1;
      proRegistraLog('PROCVENING',SYSDATE,nuProducto,sbError,nusession, sbuser  );
      RETURN;
    END IF;

   PROCVALIDATOVING ( nuTiso, nuTire , nuProducto , nuPuntAte  , nuContrato , sbObse, nuCliente, nuDireccion, nuUnidad , nuActividad, nuCausal  , sbItem     , sbDatAdi
  , sdComLeg   , dtfege,nupersonaleg , nuLinea, nuOk , sbError );

  --TICKET 200-991 LJLB --validacion si no hubo error
  IF nuOk <> -1 THEN
        --TICKET 200-991 LJLB --se realiza registro en la tabla temporal
        INSERT INTO LDC_DAVEINGTEMP ( VETETISO,
                                      VETETIRE,
                                      VETEPROD,
                                      VETEPATE,
                                      VETECONT,
                                      VETEOBSE,
                                      VETECLIE,
                                      VETEIDDI,
                                      VETEUNID,
                                      VETEACTI,
                                      VETECAUS,
                                      VETEITEM,
                                      VETEDAAD,
                                      VETECOLE,
                                      VETEFEGE,
                                      VETEUSUA,
                                      VETEESTA,
                                      VETEINTE,
                                      VETEPERS
                                    )
            VALUES (
                    nuTiso,
                    nuTire ,
                    nuProducto ,
                    nuPuntAte ,
                    nuContrato,
                    sbObse  ,
                    nuCliente ,
                    nuDireccion,
                    nuUnidad  ,
                    nuActividad,
                    nuCausal   ,
                    sbItem     ,
                    sbDatAdi   ,
                    sdComLeg  ,
                    dtfege ,
                    nuPersona ,
                    'NO',
                    0,
                    nuPersonaLeg)  RETURNING  rowid INTO sbRowId;

          COMMIT;

      --TICKET 200-991 LJLB --se envia a procesar registro
      proGeneraSolicitudVSI(nuProducto, nuPersona, dtfege, nuLinea, sbRowId, nuOk, sbError );

    IF nuOk <> 0 THEN
      proRegistraLog('PROCVENING',SYSDATE,nuProducto,sbError,nusession, sbuser  );
      nuOkProc := nuOk;
    END IF;


  ELSE
   --TICKET 200-991 LJLB --se registra log de errores
    proRegistraLog('PROCVENING',SYSDATE,nuProducto,sbError,nusession, sbuser  );
    nuOkProc := -1;
  END IF;

  IF nuLinea = nuCantReg  THEN

    nuOk := nuOkProc;
    --TICKET 200-991 LJLB --se renvia correo electronico
    proEnviaCorreo(sbuser, nusession, nuOkProc, sbError);
    IF nuOk <> 0 THEN
      nuOk := -1;
    END IF;
  END IF;

  pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR then
		pkg_error.getError(nuOk, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		ROLLBACK;
		nuOk := -1;
    WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(nuOk, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		sbError := 'Error en PROCVENING: '||sbError || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
		proRegistraLog('PROCVENING',SYSDATE,nuProducto,sbError,nusession, sbuser  );
		nuOk := -1;
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
 END;

 PROCEDURE proGeneraSolicitudVSI ( nuProducto IN LDC_DAVEINGTEMP.VETEPROD%TYPE,
                                   nuPerson   IN LDC_DAVEINGTEMP.VETEUSUA%TYPE,
                                   dtFechaGene  IN DATE,
                                   nuLinea    IN NUMBER,
                                   sbRowId    IN VARCHAR2,
                                   nuOk       OUT NUMBER,
                                   sberror    OUT VARCHAR2) IS

   /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : proceso que genera las ventas de ingenieria

        Parametros Entrada
        nuProducto producto
        nuPerson   persona
        nuLinea    Linea a procesar

        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR        DESCRIPCION
        17/07/2023   jcatuchemvm  OSF-1258: Actualización llamados OS_LEGALIZEORDERS por API_LEGALIZEORDERS,
                                  OS_ASSIGN_ORDER por api_assign_order
        15/12/2018   HORBATH      200-2260 Se modifica para buscar la actividad no una sola vez sino N veces segun lo
                                  que este parametrizado en parametro LDCPARAMNOVECESBUSOA
								 
        15/12/2018   HORBATH      caso 374: Se modifica para eliminar la validación de la instancia.
   ***************************************************************************/

  sbDato varchar2(4000);
  nuOrder       or_order.order_id%TYPE; --Ticket 200-991 LJLB -- se almacena la orden generada
  nuSolicitud   mo_packages.package_id%TYPE; --Ticket 200-991 LJLB -- se almacena la solicitud
  nuMotivo      mo_motive.motive_id%TYPE; --Ticket 200-991 LJLB -- se almacena motivo  generado
  nuActivity    or_order_activity.order_activity_id%TYPE; --Ticket 200-991 LJLB -- se almacena id de la actividad generada

   --Ticket 200-991 LJLB -- se consultan datos por procesar
  CURSOR cuDatosventas IS
  SELECT  ROWID ID_T,
          VETETISO,
          VETETIRE,
          VETEPROD,
          VETEPATE,
          VETECONT,
          VETEOBSE,
          VETECLIE,
          VETEIDDI,
          VETEUNID,
          VETEACTI,
          VETECAUS,
          VETEITEM,
          VETEDAAD,
          VETECOLE,
          VETEFEGE,
          VETEUSUA,
          VETEPERS
  FROM LDC_DAVEINGTEMP
  WHERE NVL(VETEESTA,'NO') = 'NO'
      AND VETEINTE <= pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CANTINTRE')
      AND ROWID = sbRowId
      ;

  --Ticket 200-991 LJLB -- se valida la clasificacion de la causal
  CURSOR cuTipoCausal (nuCausal ge_causal.CAUSAL_ID%TYPE ) IS
  SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
  FROM ge_causal
  WHERE CAUSAL_ID = nuCausal;

  sbOrder VARCHAR2(1);
  nuClaseCausal NUMBER;

  nrows number; --Ticket 200-991 LJLB -- se almacena numero de filas
  inum number; --Ticket 200-991 LJLB -- se almacena cantidad de segundos



  un_coderror number; --Ticket 200-991 LJLB -- se almacena codigo de error
  un_msgerror varchar2(4000); --Ticket 200-991 LJLB -- se almacena mensaje de error

  nusession NUMBER := PKG_SESSION.FNUGETSESION;  --Ticket 200-991 LJLB-- se almacena la session conectada
  sbuser    VARCHAR2(4000) := USER; --Ticket 200-991 LJLB-- se almacena el usuario conectado
  blexiste  boolean;

  nuValorTiemMinu  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_TIEMCSVSI'); --TICKET 200-1440 LJLB -- se almacena valor del parametro de minutos para consultar solciitudes registradas
  nuValorTiemSegu  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_TIEMESSO'); --TICKET 200-1440 LJLB -- se almacena valor del parametro de segundo para esperar que se legalice solciitudes registradas
 numeroveces number; -- 200-2260 variable para indicar numero de veces a buscar la actividad
 SEGUNDOSAESPERAR NUMBER; -- 200-2260 variable para indicar numero de segundos a esperar
  veces number;
  swoa boolean;

  CURSOR cuConsuInstanciaSol IS
  SELECT i.instance_id
  FROM wf_instance i, wf_data_external e
  WHERE i.unit_id = 100903
  AND i.action_id = 100
  AND i.PLAN_ID = e.PLAN_ID
  AND e.PACKAGE_id=nuSolicitud;

  CURSOR cuConsuInstaOrden IS
  SELECT instance_id
  FROM or_order_activity
  WHERE order_id = nuOrder;
  
  CURSOR cuContador (inuActividad LDC_DAVEINGTEMP.VETEACTI%TYPE, inuProducto LDC_DAVEINGTEMP.VETEPROD%TYPE)IS
    select  count(*)
    from mo_data_for_order do, mo_motive mo, mo_packages so
    where do.motive_id = mo.motive_id
        and mo.package_id = so.package_id
        and so.motive_status_id = 13
        and do.item_id = inuActividad
        AND so.package_type_id = 100101
        and  mo.product_id = inuProducto
        and so.MESSAG_DELIVERY_DATE > SYSDATE - (nuValorTiemMinu/60)/24;--TICKET 200-1440 LJLB -- se obtiene valor del parametro LDC_TIEMCSVSI

	CURSOR cuActividad(inuorden OR_ORDER.ORDER_ID%TYPE) IS
	 SELECT o.order_activity_id
  	 FROM or_order_activity o, wf_instance w, or_order r
	 WHERE o.order_id = inuorden and
	 	   w.instance_id = o.instance_id and
		   w.status_id=4 and
		   r.order_id=o.order_id and
		   r.order_status_id=5;



  nuInstancia number;
  csbMetodo 			varchar2(100) := csbNOMPKG||'proGeneraSolicitudVSI'; 

 BEGIN
 
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);
	
    nuOk := 0;

 --Ticket 200-991 LJLB -- se recorren los registros a procesar
   FOR reg IN cuDatosventas LOOP
    -- BEGIN

      nrows := 0;
      inum := 0;

     --Ticket 200-991 LJLB -- se valida que no exista una solicitud registrada al mismo tiempo
	  IF cuContador%ISOPEN THEN
			CLOSE cuContador;
	  END IF;

	  OPEN cuContador(reg.VETEACTI,reg.VETEPROD);
	  FETCH cuContador into nrows;
	  CLOSE cuContador;
	  
     IF nrows > 0 THEN
        inum := 0;
        WHILE (nrows > 0 AND inum < nuValorTiemSegu)
        LOOP
           inum := inum + 1;
           dbms_lock.sleep(1);

		  IF cuContador%ISOPEN THEN
				CLOSE cuContador;
		  END IF;

		  OPEN cuContador(reg.VETEACTI,reg.VETEPROD);
		  FETCH cuContador into nrows;
		  CLOSE cuContador;

        END LOOP;
     END IF;


     IF nrows = 0 THEN

       nuOk := 0;
        nuSolicitud := null ;
        nuOrder := null;
        un_coderror := 0;
        nuMotivo := null;
        un_msgerror := null;
        --Ticket 200-991 LJLB -- se registra solicitud de venta de servicio de ingenieria
        ldci_pkosssolicitud.prosolicitudvsi( reg.VETECONT, reg.VETETIRE, reg.VETEPROD, reg.VETEUSUA, reg.VETEPATE,null, reg.VETEFEGE, reg.VETEOBSE, reg.VETECLIE,
reg.VETEIDDI, null, reg.VETEACTI, null, nuMotivo, nuSolicitud, nuOrder, un_coderror, un_msgerror );
        dbms_lock.sleep(3);
        --Ticket 200-991 LJLB -- si no hay error se procede asignar la orden
        IF un_coderror = 0 THEN

             INSERT INTO LDC_DAVEING
                                        ( VEINTISO,
                                          VEINTIRE,
                                          VEINPROD,
                                          VEINPATE,
                                          VEINCONT,
                                          VEINOBSE,
                                          VEINCLIE,
                                          VEINIDDI,
                                          VEINUNID,
                                          VEINACTI,
                                          VEINCAUS,
                                          VEINITEM,
                                          VEINDAAD,
                                          VEINCOLE,
                                          VEINUSUA,
                                          VEINORGE,
                                          VEINSOGE,
                                          VEINFEGE,
                                          VEINPERS
                                        )
                                        VALUES
                                        (
                                          REG.VETETISO,
                                          REG.VETETIRE,
                                          REG.VETEPROD,
                                          REG.VETEPATE,
                                          REG.VETECONT,
                                          REG.VETEOBSE,
                                          REG.VETECLIE,
                                          REG.VETEIDDI,
                                          REG.VETEUNID,
                                          REG.VETEACTI,
                                          REG.VETECAUS,
                                          REG.VETEITEM,
                                          REG.VETEDAAD,
                                          REG.VETECOLE,
                                          sbuser,
                                          nuorder,
                                          nuSolicitud,
                                          REG.VETEFEGE,
                                          REG.VETEPERS
                                        );

            DELETE FROM LDC_DAVEINGTEMP WHERE ROWID = REG.ID_T;
            COMMIT;
           un_coderror := null;
           un_msgerror := null;
           nuInstancia := NULL;

           --se consulta instancia de la solicitud
           OPEN cuConsuInstaOrden;
           FETCH cuConsuInstaOrden INTO nuInstancia;
           CLOSE cuConsuInstaOrden;

			
           --Ticket 200-991 LJLB -- se procede asignar la orden generada
           api_assign_order( nuOrder, REG.VETEUNID,  un_coderror, un_msgerror);

           IF un_coderror = 0 THEN
		          COMMIT;
               dbms_lock.sleep(1);
               un_coderror := null;
               un_msgerror := null;
              --Ticket 200-991 LJLB -- se consulta id de la actividad generada


              -- Tiquet 200-2260 se buscar valor de parametro de numero de veces
              numeroveces  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDCPARAMNOVECESBUSOA');

              -- Tiquet 200-2260 se buscar valor de parametro de segundos de espera en cada busqueda
              SEGUNDOSAESPERAR  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDCPARAMTIEMPO');

              swoa:=TRUE;
              veces := 0;
              while swoa loop
                    veces:=veces+1;
                    BEGIN

						IF cuActividad%ISOPEN THEN
							CLOSE cuActividad;
						END IF;

						OPEN cuActividad(nuOrder);
						FETCH cuActividad into nuActivity;
						IF cuActividad%NOTFOUND THEN
							CLOSE cuActividad;
							RAISE NO_DATA_FOUND;
						END IF;
						CLOSE cuActividad;

                        swoa := false;

                    EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              if veces <= numeroveces then
                                 dbms_lock.sleep(SEGUNDOSAESPERAR);
                              else
                                 swoa:=false;
                              end if;

                         WHEN OTHERS THEN
                              if veces <= numeroveces then
                                 dbms_lock.sleep(SEGUNDOSAESPERAR);
                              else
                                 swoa:=false;
                              end if;
                    end;
              end loop;

             IF nuActivity IS NULL THEN
                proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VETEPROD,'FLUJO: Linea: '||nuLinea||' '||-1||'-'||' Flujo de orden de trabajo ['||nuorder||'] no se encuentra en estado en esperando respuesta[4] ',nusession, sbuser  );
             ELSE
				  IF reg.VETECAUS IS NOT NULL THEN
                    OPEN cuTipoCausal(reg.VETECAUS);
                    FETCH cuTipoCausal INTO nuClaseCausal;
                    CLOSE cuTipoCausal;
                  END IF;
                  --Ticket 200-991 LJLB -- se procede a legalizar la orden de trabajo
                  api_legalizeorders( nuorder||'|'||reg.VETECAUS||'|'||reg.VETEPERS||'|'||REG.VETEDAAD||'|'||nuActivity||'>'||nuClaseCausal||';;;;|'||reg.VETEITEM||'||'||reg.VETECOLE, SYSDATE, SYSDATE, null, un_coderror, un_msgerror );
                  dbms_lock.sleep(2);
                  --Ticket 200-991 LJLB -- se valida que todo alla terminado bien
					 IF un_coderror = 0 THEN

						 COMMIT;
					 ELSE
						  --Ticket 200-991 LJLB -- se registran los log de errores
						  proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VETEPROD,'api_legalizeorders: Linea: '||nuLinea||' '||un_coderror||'-'||un_msgerror,nusession, sbuser  );
						  nuOk := un_coderror;
						  sberror := un_msgerror;
						  ROLLBACK;

				     END IF;
                  dbms_lock.sleep(2);
             END IF;
           ELSE
               --Ticket 200-991 LJLB -- se registran los log de errores
              proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VETEPROD,'api_assign_order: Linea: '||nuLinea||' '||un_coderror||'-'||un_msgerror,nusession, sbuser  );
              nuOk := un_coderror;
              sberror := un_msgerror;
               ROLLBACK;
               dbms_lock.sleep(2);

           END IF;
        ELSE           --Ticket 200-991 LJLB -- se registran los log de errores
           proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VETEPROD,'LDCI_PKOSSSOLICITUD.PROSOLICITUDVSI: Linea: '||nuLinea||' '||un_coderror||'-'||un_msgerror,nusession, sbuser  );

           nuOk := un_coderror;
           sberror := un_msgerror;
           ROLLBACK;
           dbms_lock.sleep(2);

         END IF;
      ELSE
       --Ticket 200-991 LJLB -- se registran los log de errores
        proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VETEPROD,'Linea: '||nuLinea||' '||'Producto tiene Venta Generada por favor revisar',nusession, sbuser  );
        nuOk := -1;
        sberror := 'Producto tiene Venta Generada por favor revisar';
      END IF;

    IF nuOk <> 0 THEN
       UPDATE LDC_DAVEINGTEMP SET VETEINTE = NVL(VETEINTE,0) + 1
      WHERE ROWID = REG.ID_T;
      commit;
      dbms_lock.sleep(2);
    END IF;
   END LOOP;
   
   pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR then
	
		pkg_error.getError(un_coderror, un_msgerror);
		pkg_traza.trace(csbMetodo||' '||un_msgerror);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		nuOk := -1;
		sbError := un_msgerror;
		proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,nuProducto,'Linea: '||nuLinea||' '||'Error no controlado '||sbError,nusession, sbuser  );
		ROLLBACK;
		dbms_lock.sleep(2);
    WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(un_coderror, un_msgerror);
		pkg_traza.trace(csbMetodo||' '||un_msgerror);
		ROLLBACK;
		un_msgerror := 'Error creando la solicitud, Linea: '||nuLinea||' '|| un_msgerror;
		nuOk := -1;
		sbError := un_msgerror;
		proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,nuProducto,'Linea: '||nuLinea||' '||'Error no controlado: '||sbError,nusession, sbuser  );
		ROLLBACK;
		dbms_lock.sleep(2);
 END proGeneraSolicitudVSI;

 PROCEDURE PROCVENTAING IS
  /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : proceso de vents de ingenia PB LDCREVEINVIS

        Parametros Entrada


        Valor de salida


        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        17/12/2018   horbath     Se modifica para manejar flag de procesar solicitudes
   ***************************************************************************/

    nuPerson         GE_PERSON.PERSON_ID%TYPE := PKG_BOPERSONAL.FNUGETPERSONAID;
    sbFechaIni       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; --Ticket 200-991 LJLB -- se almacena fecha inicial
    sbFechaFin       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; --Ticket 200-991 LJLB -- se almacena fecha final

    dtFechaIni       DATE; --Ticket 200-991 LJLB -- se almacena fecha inicial
    dtFechaFin       DATE;--Ticket 200-991 LJLB -- se almacena fecha final

    --Ticket 200-991 LJLB -- se consultan datos de venta
    CURSOR cuDatventas IS
    SELECT VETETISO,
            VETETIRE,
            VETEPROD,
            VETEPATE,
            VETECONT,
            VETEOBSE,
            VETECLIE,
            VETEIDDI,
            VETEUNID,
            VETEACTI,
            VETECAUS,
            VETEITEM,
            VETEDAAD,
            VETECOLE,
            VETEFEGE,
            VETEPERS,
            ROWID ID_T
    FROM LDC_DAVEINGTEMP
    WHERE NVL(VETEESTA,'NO') = 'NO'
      AND VETEUSUA = nuPerson
      AND VETEINTE <= pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CANTINTRE')
      AND VETEFEGE BETWEEN NVL( dtFechaIni, VETEFEGE ) AND NVL( dtFechaFin, VETEFEGE );


    CURSOR cuDatventasr IS
    SELECT VEINTISO,
            VEINTIRE,
            VEINPROD,
            VEINPATE,
            VEINCONT,
            VEINOBSE,
            VEINCLIE,
            VEINIDDI,
            VEINUNID,
            VEINACTI,
            VEINCAUS,
            VEINITEM,
            VEINDAAD,
            VEINCOLE,
            VEINFEGE,
            VEINPERS,
            LDC_DAVEING.ROWID ID_T
    FROM LDC_DAVEING,  OR_ORDER O, ge_person p,sa_user u
    WHERE VEINUSUA = u.mask
      AND  u.user_id = p.user_id
      AND  p.person_id = nuPerson
      AND VEINFEGE BETWEEN NVL( dtFechaIni, VEINFEGE ) AND NVL( dtFechaFin, VEinFEGE )
      and veINorge = o.order_id
	  and o.ORDER_STATUS_ID NOT IN (SELECT  EO.ORDER_STATUS_ID
									from OR_ORDER_STATUS EO
									where IS_FINAL_STATUS ='Y');

    nuOk NUMBER;
    sbError VARCHAR2(4000);
    nuOkProc NUMBER := 0;
    nuRegistro NUMBER := 0;

    nusession NUMBER := PKG_SESSION.FNUGETSESION;  --Ticket 200-991 LJLB-- se almacena la session conectada
    sbuser    VARCHAR2(4000) := USER; --Ticket 200-991 LJLB-- se almacena el usuario conectado
	
  	csbMetodo 			varchar2(100) := csbNOMPKG||'PROCVENTAING'; 

	
	
	
 BEGIN

	pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

     sbFechaIni  :=  GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER', 'CREATED_DATE'); --Ticket 200-991 LJLB -- accion a  ejecutar
     sbFechaFin  :=  GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER', 'EXECUTION_FINAL_DATE'); --Ticket 200-991 LJLB -- valor de multa
     sbflago     :=  GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('PLANSUSC', 'PLSUIMAV'); -- TICKET 2260 MANEJO FLAG REPROCESAR SOLICITUDES

     IF sbFechaIni IS NOT NULL THEN
       dtFechaIni := TO_DATE( TO_CHAR( TO_DATE( sbFechaIni,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');
     END IF;

     IF sbFechaFin IS NOT NULL THEN
       dtFechaFin := TO_DATE( TO_CHAR( TO_DATE( sbFechaFin,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');
     END IF;

   if nvl(sbflago,'N') IN ('n','N') then
      --Ticket 200-991 LJLB -- procesa datos guaradado enla tabla temporal
      FOR reg IN cuDatventas LOOP
          nuOk := 0;
          nuRegistro := nuRegistro + 1;
          PROCVALIDATOVING ( REG.VETETISO, REG.VETETIRE, REG.VETEPROD, REG.VETEPATE, REG.VETECONT, REG.VETEOBSE, REG.VETECLIE, REG.VETEIDDI, REG.VETEUNID,
                REG.VETEACTI, REG.VETECAUS, REG.VETEITEM, REG.VETEDAAD, REG.VETECOLE,  reg.vetefege,reg.vetepers,nuRegistro, nuOk , sbError );
          IF nuOk <> -1 THEN
            --TICKET 200-991 LJLB --se envia a procesar registro
            proGeneraSolicitudVSI(REG.VETEPROD, nuPerson, reg.vetefege,  nuRegistro, reg.ID_T, nuOk, sbError );
            IF nuOk <> 0 THEN
               ROLLBACK;
               --TICKET 200-991 LJLB --se registra log de errores
               proRegistraLog('PROCVENING1',SYSDATE,REG.VETEPROD,sbError,nusession, sbuser  );
            ELSE
               COMMIT;
            END IF;
          ELSE
            nuOkProc := -1;
            --TICKET 200-991 LJLB --se registra log de errores
            proRegistraLog('PROCVENING',SYSDATE,REG.VETEPROD,sbError,nusession, sbuser  );
            UPDATE LDC_DAVEINGTEMP SET VETEINTE = NVL(VETEINTE,0) + 1
                   WHERE ROWID = REG.ID_T;
            COMMIT;
          END IF;
      END LOOP;
   else
      --Ticket 200-2260 LJLB -- procesa datos guaradado enla tabla temporal
      FOR regr IN cuDatventasr LOOP
          nuOk := 0;
          nuRegistro := nuRegistro + 1;

          proprocesaSolicitudVSI (REGr.ID_T, REGr.VEinPROD,  nuRegistro, nuOk, sbError );
            IF nuOk <> 0 THEN
                proRegistraLog('PROCVENING1',SYSDATE,REGr.VEinPROD,sbError,nusession, sbuser  );
                ROLLBACK;
            ELSE
               COMMIT;
            END IF;
      END LOOP;
   end if;
   
   
   IF NVL(nuOkProc,0) <> 0 THEN
       --TICKET 200-991 LJLB --se renvia correo electronico
       proEnviaCorreo(sbuser, nusession, nuOk, sbError);
        nuOk := -1;
    END IF;
 

  pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 

 EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR then
		pkg_error.getError(nuOk, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		ROLLBACK;
		proRegistraLog('PROCVENING',SYSDATE,-1,sbError,nusession, sbuser  );
		nuOk := -1;
    WHEN OTHERS THEN
  		pkg_error.setError;
		pkg_error.getError(nuOk, sbError);
		pkg_traza.trace(csbMetodo||' '||sbError);
		ROLLBACK;
		sbError := 'Error en PROCVENTAING: ' || sbError || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
		proRegistraLog('PROCVENING',SYSDATE,-1,sbError,nusession, sbuser  );
		nuOk := -1;
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    RAISE Pkg_Error.CONTROLLED_ERROR ;
 END PROCVENTAING;
 
 
   FUNCTION fnuValidaEntrega RETURN NUMBER IS
  /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2017-04-01
        Ticket      : 200-991
        Descripcion : funcion que se encarga de validar si la entrega palica para la gasera

        Parametros Entrada


        Valor de salida


        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

    nuOk NUMBER;
	csbMetodo varchar2(100) := csbNOMPKG||'fnuValidaEntrega';

  BEGIN

	pkg_traza.trace(csbMetodo,  pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

	nuOk := 1;

	pkg_traza.trace(csbMetodo,  pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

     RETURN nuOk;

  END fnuValidaEntrega;

   PROCEDURE proprocesaSolicitudVSI ( sbRowId   IN VARCHAR2,
                                    nuProducto IN LDC_DAVEINGTEMP.VETEPROD%TYPE,
                                    nuLinea    IN NUMBER,
                                   nuOk       OUT NUMBER,
                                   sberror    OUT VARCHAR2) IS

   /**************************************************************************
        Autor       : Horbath
        Fecha       : 2018-12-17
        Ticket      : 200-2260
        Descripcion : proceso que genera las ventas de ingenieria (reprocesadas)

        Parametros Entrada
        nuProducto producto
        sbRowId   Identificador de la tabla
        nuLinea    Linea a procesar

        Valor de salida
        nuOk        0- Exito, -1 Error
        sbError     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR          DESCRIPCION
        17/07/2023   jcatuchemvm    OSF-1258: Actualización llamados OS_LEGALIZEORDERS por API_LEGALIZEORDERS,
                                    OS_ASSIGN_ORDER por api_assign_order
        18/12/2018   HORBATH        200-2260 Creacion procedimiento
   ***************************************************************************/

  sbDato varchar2(4000);
  nuOrder       or_order.order_id%TYPE; --Ticket 200-991 LJLB -- se almacena la orden generada
  nuSolicitud   mo_packages.package_id%TYPE; --Ticket 200-991 LJLB -- se almacena la solicitud
  nuMotivo      mo_motive.motive_id%TYPE; --Ticket 200-991 LJLB -- se almacena motivo  generado
  nuActivity    or_order_activity.order_activity_id%TYPE; --Ticket 200-991 LJLB -- se almacena id de la actividad generada
  csbMetodo		varchar2(100) := csbNOMPKG||'proprocesaSolicitudVSI';

   -- se consultan datos por procesar
  CURSOR cuDatosventas IS
  SELECT  ROWID ID_T,
          VEinTISO,
          VEinTIRE,
          VEinPROD,
          VEinPATE,
          VEinCONT,
          VEinOBSE,
          VEinCLIE,
          VEinIDDI,
          VEinUNID,
          VEinACTI,
          VEinCAUS,
          VEinITEM,
          VEinDAAD,
          VEinCOLE,
          VEinFEGE,
          VEinUSUA,
          VEinPERS, veinorge
  FROM LDC_DAVEING
  WHERE ROWID = sbRowId;

  CURSOR cuTipoCausal (nuCausal ge_causal.CAUSAL_ID%TYPE ) IS
  SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
  FROM ge_causal
  WHERE CAUSAL_ID = nuCausal;
  
  
  CURSOR cuActividad(inuorden OR_ORDER.ORDER_ID%TYPE) IS
	 SELECT o.order_activity_id
		FROM or_order_activity o, wf_instance w, or_order r
		WHERE o.order_id = inuorden and
			  w.instance_id = o.instance_id and
			  w.status_id=4 and
			  r.order_id=o.order_id and
			  r.order_status_id in (5,6,7);


  sbOrder VARCHAR2(1);
  nuClaseCausal NUMBER;

  nrows number; -- se almacena numero de filas
  inum number;  -- se almacena cantidad de segundos
  un_coderror number;         -- se almacena codigo de error
  un_msgerror varchar2(4000); -- se almacena mensaje de error
  nusession NUMBER := PKG_SESSION.FNUGETSESION; --  se almacena la session conectada
  sbuser    VARCHAR2(4000) := USER; --  se almacena el usuario conectado
  blexiste  boolean;

  nuValorTiemMinu  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_TIEMCSVSI'); -- se almacena valor del parametro de minutos para consultar solciitudes registradas
  nuValorTiemSegu  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_TIEMESSO');  -- se almacena valor del parametro de segundo para esperar que se legalice solciitudes registradas
 numeroveces number; -- 200-2260 variable para indicar numero de veces a buscar la actividad
 SEGUNDOSAESPERAR NUMBER; -- 200-2260 variable para indicar numero de segundos a esperar
  veces number;
  ost number;
  swoa boolean;
  blAsigno boolean;
 BEGIN
 
	pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

    nuOk := 0;

 -- se recorren los registros a procesar
   FOR reg IN cuDatosventas LOOP
    -- BEGIN

      nrows := 0;
      inum := 0;
      blAsigno := false;

     IF nrows = 0 THEN
        nuOk := 0;
        nuSolicitud := null ;
        nuOrder := null;
        un_coderror := 0;
        nuMotivo := null;
        un_msgerror := null;
        IF un_coderror = 0 THEN

           -- se procede a validar estado de la orden
		   
		   ost := PKG_BCORDENES.FNUOBTIENEESTADO(reg.veinorge);
		   
           if ost in (0,1,20,18,11) then
              un_coderror := null;
           un_msgerror := null;
              api_assign_order( reg.veinorge, REG.VEinUNID, un_coderror, un_msgerror);
              if un_coderror = 0 then
                  COMMIT;
                  blAsigno := true;
              end if;
           end if;
           IF (un_coderror = 0 and ost in (5,6,7)) or blAsigno THEN
              if ost=5 then
                 COMMIT;
              end if;
              dbms_lock.sleep(1);
              un_coderror := null;
              un_msgerror := null;
              -- se consulta id de la actividad generada

              -- Tiquete 200-2260 se buscar valor de parametro de numero de veces
              numeroveces  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDCPARAMNOVECESBUSOA');

              -- Tiquet 200-2260 se buscar valor de parametro de segundos de espera en cada busqueda
              SEGUNDOSAESPERAR  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDCPARAMTIEMPO');

              swoa:=TRUE;
              veces := 0;
              while swoa loop
                    veces:=veces+1;
                    BEGIN
					
						IF cuActividad%ISOPEN THEN
							CLOSE cuActividad;
						END IF;

						OPEN cuActividad(reg.veinorge);
						FETCH cuActividad into nuActivity;
						IF cuActividad%NOTFOUND THEN
							CLOSE cuActividad;
							RAISE NO_DATA_FOUND;
						END IF;
						CLOSE cuActividad;

                        swoa := false;
						
                    EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                              if veces <= numeroveces then
                                 dbms_lock.sleep(SEGUNDOSAESPERAR);
                              else
                                 swoa:=false;
                              end if;
					
                         WHEN OTHERS THEN
                              if veces <= numeroveces then
                                 dbms_lock.sleep(SEGUNDOSAESPERAR);
                              else
                                 swoa:=false;
                              end if;
                    end;
              end loop;


             IF reg.VEinCAUS IS NOT NULL THEN
                OPEN cuTipoCausal(reg.VEinCAUS);
                FETCH cuTipoCausal INTO nuClaseCausal;
                CLOSE cuTipoCausal;
              END IF;
              -- se procede a legalizar la orden de trabajo
              api_legalizeorders( reg.veinorge||'|'||reg.VEinCAUS||'|'||reg.VEinPERS||'|'||REG.VEinDAAD||'|'||nuActivity||'>'||nuClaseCausal||';;;;|'||reg.VEinITEM||'||'||reg.VEinCOLE, SYSDATE, SYSDATE, null, un_coderror, un_msgerror );
              dbms_lock.sleep(2);
              -- se valida que todo hubiese terminado bien
              IF un_coderror = 0 THEN
                 COMMIT;
              ELSE
                  --  se registran los log de errores
                  proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VEinPROD,'api_legalizeorders: Linea: '||nuLinea||' '||un_coderror||'-'||un_msgerror,nusession, sbuser  );
                  nuOk := un_coderror;
                  sberror := un_msgerror;
                  ROLLBACK;

              END IF;
              dbms_lock.sleep(2);
           ELSE
               --  se registran los log de errores
              proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VEinPROD,'api_assign_order: Linea: '||nuLinea||' '||un_coderror||'-'||un_msgerror,nusession, sbuser  );
              nuOk := un_coderror;
              sberror := un_msgerror;
               ROLLBACK;
               dbms_lock.sleep(2);

           END IF;
        ELSE           --  se registran los log de errores
           proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VEinPROD,'LDCI_PKOSSSOLICITUD.PROSOLICITUDVSI: Linea: '||nuLinea||' '||un_coderror||'-'||un_msgerror,nusession, sbuser  );

           nuOk := un_coderror;
           sberror := un_msgerror;
           ROLLBACK;
           dbms_lock.sleep(2);

         END IF;
      ELSE
       -- se registran los log de errores
        proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,REG.VEinPROD,'Linea: '||nuLinea||' '||'Producto tiene Venta Generada por favor revisar',nusession, sbuser  );
        nuOk := -1;
        sberror := 'Producto tiene Venta Generada por favor revisar';
      END IF;

   END LOOP;
   
   pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

 EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR then
	   Pkg_Error.getError(un_coderror, un_msgerror);
       pkg_traza.trace(csbMetodo||' '||un_msgerror);
       nuOk := -1;
       sbError := un_msgerror;
       proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,nuProducto,'Linea: '||nuLinea||' '||'Error no controlado '||sbError,nusession, sbuser  );
	   ROLLBACK;
	   pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       dbms_lock.sleep(2);
    WHEN OTHERS THEN
	   pkg_error.setError;
	   Pkg_Error.getError(un_coderror, un_msgerror);
       pkg_traza.trace(csbMetodo||' '||un_msgerror);
	   un_msgerror := 'Error creando la solicitud, Linea: '||nuLinea||' '|| un_msgerror;
	   nuOk := -1;
	   sbError := un_msgerror;
	   proRegistraLog('PROGENERASOLICITUDVSI',SYSDATE,nuProducto,'Linea: '||nuLinea||' '||'Error no controlado: '||sbError,nusession, sbuser  );
	   ROLLBACK;
	   pkg_traza.trace(CSBMETODO, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	   dbms_lock.sleep(2);
 END proprocesaSolicitudVSI ;

END LDC_GENERAVTINGVIS;
/

Prompt Otorgando permisos a ADM_PERSON.LDC_GENERAVTINGVIS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GENERAVTINGVIS', 'ADM_PERSON');
END;
/

