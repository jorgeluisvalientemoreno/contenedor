CREATE OR REPLACE PACKAGE LDC_PKGENSOLAN
IS

    /*******************************************************************************
     Propiedad intelectual GASES DEL CARIBE

     Autor         :ESANTIAGO (horbath)
     Fecha         :17-02-2020
     DESCRIPCION   : Paquete utilizado para anular solicitudes de venta por archivo plano
     CASO          : 617

     FECHA        AUTOR       DESCRIPCION
	 19/10/2023	  JSOTO		  OSF-1706 Ajustes en todo el paquete para reemplazar algunos objetos de producto
							  por objetos personalizados para disminuir el impacto en la migracion a 8.0

	 20/03/2024	  JSOTO		  OSF-2387 Ajustes 
								se reemplaza uso de	utl_file.get_line	por	pkg_gestionarchivos.fsbobtenerlinea_ut
								se reemplaza uso de	utl_file.fclose	por	pkg_gestionarchivos.prccerrararchivo_ut
								se reemplaza uso de	utl_file.put_line	por	pkg_gestionarchivos.prcescribirlinea_ut
								se reemplaza uso de	utl_file.file_type	por	pkg_gestionarchivos.styarchivo
								se reemplaza uso de	utl_file.fopen	por	pkg_gestionarchivos.ftabrirarchivo_ut
								se reemplaza uso de	ge_directory.path	por	pkg_bcdirectorios.fsbgetruta
								Se ajusta el manejo de errores y trazas de acuerdo a las pautas tecnicas de desarrollo
	26/11/2024 		cgonzalez	Se ajusta servicio CARGARGRILLA para invocar a metodo de PKG_BCPERSONAL
     *******************************************************************************/


    FUNCTION CARGARGRILLA
        RETURN constants_per.tyrefcursor;

    /**************************************************************************
     Autor       : Ernesto Santiago / Horbath
     Fecha       : 24-12-2020
     Ticket      : 617
     Proceso     : CARGARGRILLA
     Descripcion : Funci??n para obtener el conjunto de registros apartir del archivo plano para la forma LDCGENSOLAN.

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PRPROCESAGRILLA (
        isbcodigo      IN     VARCHAR2,
        inucurrent     IN     NUMBER,
        inutotal       IN     NUMBER,
        onuerrorcode      OUT ge_error_log.message_id%TYPE,
        osberrormess      OUT ge_error_log.description%TYPE);

    /**************************************************************************
     Autor       : Ernesto Santiago / Horbath
     Fecha       : 24-12-2020
     Ticket      : 617
     Proceso     : PRPROCESAGRILLA
     Descripcion : procedimiento que se encarga de generar la solicitud de
             anulacion para los registros de la forma LDCGENSOLAN



     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE ACTIVACUPON (inuPackage_id IN mo_packages.package_id%TYPE);

    /**************************************************************************
     Autor       : Ernesto Santiago / Horbath
     Fecha       : 17-02-2020
     Ticket      : 617
     Proceso     : ACTIVACUPON
     Descripcion : procedimiento que se encarga de borrar el cupon de la tabla Cupon_Anulado_Ventas
       y registralo en la tabla Cupon



     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE ANULACUPON (inuPackage_id IN mo_packages.package_id%TYPE);

    /**************************************************************************
     Autor       : Ernesto Santiago / Horbath
     Fecha       : 17-02-2020
     Ticket      : 617
     Proceso     : ANULACUPON
     Descripcion : procedimiento que se encarga de borrar el cupon d el la tabla Cupon
       y registralo en la tabla Cupon_Anulado_Ventas



     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE CANCELANUL;

    /*******************************************************************************
     Propiedad intelectual de PROYECTO GASES DEL CARIBE

     Autor         :ESANTIAGO (horbath)
     Fecha         :17-02-2020
     DESCRIPCION   : procedimineto que utilizado por la forma LDCCANUL
     CASO          : 617

     Fecha                IDEntrega           Modificacion
     ============    ================    ============================================

     *******************************************************************************/

    PROCEDURE Aprubanul (isbcodigo      IN     VARCHAR2,
                         inucurrent     IN     NUMBER,
                         inutotal       IN     NUMBER,
                         onuerrorcode      OUT ge_error_log.message_id%TYPE,
                         osberrormess      OUT ge_error_log.description%TYPE);

    /*******************************************************************************
    Propiedad intelectual de PROYECTO GASES DEL CARIBE

    Autor         :ESANTIAGO (horbath)
    Fecha         :17-02-2020
    DESCRIPCION   : procedimineto que utilizado por la forma LDCACTANUL
    CASO          : 617

    Fecha                IDEntrega           Modificacion
    ============    ================    ============================================

    *******************************************************************************/
    FUNCTION CARGACTANUL
        RETURN constants_per.tyrefcursor;
/*******************************************************************************
Propiedad intelectual de PROYECTO GASES DEL CARIBE

Autor         :ESANTIAGO (horbath)
Fecha         :17-02-2020
DESCRIPCION   : Funcion utilizado para cargar la grilla de la forma LDCACTANUL
CASO          : 617

Fecha                IDEntrega           Modificacion
============    ================    ============================================

*******************************************************************************/

END LDC_PKGENSOLAN;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKGENSOLAN
IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'LDC_PKGENSOLAN.';
    cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;



    FUNCTION CARGARGRILLA
        RETURN constants_per.tyrefcursor
    IS
        sbmensaje                VARCHAR2 (2000);
        eerror                   EXCEPTION;
        erextarc                 EXCEPTION;
        rfresult                 constants_per.tyrefcursor;

        usercon                  NUMBER;
        us                       NUMBER;
        SBDIRECTORY_ID           ge_boInstanceControl.stysbValue;
        SBFILENAME               ge_boInstanceControl.stysbValue;
        SBPATHFILE               GE_DIRECTORY.PATH%TYPE;
        NUCODIGOERROOR           NUMBER;
        SBMENSAJEERROR           VARCHAR2 (4000);
        --archivo
        SBARCHIVOORIGEN          PKG_GESTIONARCHIVOS.STYARCHIVO;
        SBLINEARORIGEN           VARCHAR2 (4000) := NULL;
        NUREGISTRO               NUMBER := 1;
        NUPROC                   NUMBER := 0;
        NUCANTIDADPALABRAS       NUMBER;
        SBARRAYVARCHAR           VARCHAR2 (4000);
        NUCONTADOR               NUMBER;
        ----------DESTINO
        SBARCHIVODESTINO         PKG_GESTIONARCHIVOS.STYARCHIVO;
        SBNOMBREARCHIVODESTINO   VARCHAR2 (4000);

        SBTERMINAL               VARCHAR2 (100);
        archivo_error            NUMBER (1);
        NUVALLINEA               NUMBER;
        NUVALEXTARC              NUMBER;

        NUPACKAGE_ID             NUMBER (15);
        SBPACKAGE_ID             NUMBER (15);
        nuValSol                 NUMBER;
        nupakcancel              NUMBER
            := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO ('COD_CANCEL_PACKAGE'); -- codigo del estado anulado de la solicitud : 32
        nuCodVg                  NUMBER
            := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO ('COD_VENTA_GAS_FORM'); -- codigo del ramite de venta de gas: 271

        sbsqlmaestro             ge_boutilities.stystatement; -- se almacena la consulta
		
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.CARGARGRILLA';
		nuErrorCode number;
		sbErrorMessage varchar2(4000);


        CURSOR cuDatos (solicitud NUMBER)
        IS
            SELECT mp.PACKAGE_ID,
                   mp.package_type_id,
                   gs.SUBSCRIBER_NAME || ' ' || gs.SUBS_LAST_NAME
                       solicitante,
                   IDENTIFICATION,
                   mm.SUBSCRIPTION_ID,
                   mm.PRODUCT_ID,
                   TOTAL_VALUE
                       val_venta,
                   INITIAL_PAYMENT
                       cuota_ini,
                   cu.CUPONUME
                       cupon,
                   cu.CUPOFLPA
                       cupon_pagado
              FROM mo_packages       mp,
                   GE_SUBSCRIBER     gs,
                   mo_motive         mm,
                   cupon             cu,
                   MO_GAS_SALE_DATA  vn
             WHERE     mp.pACKAGE_ID = solicitud
                   AND gs.SUBSCRIBER_ID = mp.SUBSCRIBER_ID
                   AND mp.pACKAGE_ID = mm.pACKAGE_ID
                   AND cu.CUPOSUSC = mm.SUBSCRIPTION_ID
                   AND mp.pACKAGE_ID = vn.pACKAGE_ID;

        CURSOR cuValSol (solicitud NUMBER)
        IS
            SELECT 1
              FROM mo_packages mp, mo_motive mm, cupon cu
             WHERE     mp.pACKAGE_ID = mm.pACKAGE_ID
                   AND cu.CUPOSUSC = mm.SUBSCRIPTION_ID
                   AND mp.PACKAGE_TYPE_ID = nuCodVg
                   AND mp.pACKAGE_ID = solicitud
                   AND cu.CUPOFLPA = 'N'
                   AND mp.MOTIVE_STATUS_ID <> nupakcancel
                   AND mp.pACKAGE_ID NOT IN
                           (SELECT oa.pACKAGE_ID
                              FROM or_order_activity oa
                             WHERE     oa.pACKAGE_ID = mp.pACKAGE_ID
                                   AND Task_Type_Id NOT IN
												   (SELECT regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('TASK_TYPE_NO_PERM'), '[^,]+', 1, LEVEL)AS tipotrab
													FROM dual
													CONNECT BY regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('TASK_TYPE_NO_PERM'), '[^,]+', 1, LEVEL) IS NOT NULL)
                                   AND ROWNUM = 1);

        datos_sol                cuDatos%ROWTYPE;

        PROCEDURE PR_WRTERROR (mensaje   VARCHAR2,
                               NOMARCH   VARCHAR2,
                               DIRARCH   VARCHAR2)
        IS
            SBARCHIVOERR   PKG_GESTIONARCHIVOS.STYARCHIVO;
        BEGIN
            SBARCHIVOERR := PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_UT (DIRARCH, NOMARCH, 'A');
            PKG_GESTIONARCHIVOS.PRCESCRIBIRLINEA_UT (SBARCHIVOERR, mensaje);
            PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_UT (SBARCHIVOERR);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_traza.TRACE (
                    'ERROR AL ACCEDER AL ARCHIVO DE ERRORES' || SYSDATE,
                    cnuNVLTRC);
        END;
	
    BEGIN
	    
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	    
        usercon :=
            pkg_bcpersonal.fnuObtieneUsuario(pkg_bopersonal.fnuGetPersonaId());
        SBDIRECTORY_ID :=
            GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_DIRECTORY',
                                                   'DIRECTORY_ID'); 
        SBFILENAME :=
            GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_COMMENT',
                                                   'ORDER_COMMENT'); 
        SBPATHFILE := pkg_bcdirectorios.fsbGetRuta(SBDIRECTORY_ID);

		NUVALEXTARC := REGEXP_COUNT (UPPER (SBFILENAME), '\.TXT$');

        DELETE FROM LDC_GENSOLANUL_TEMP
              WHERE USER_ID = usercon OR USER_ID IS NULL;

        pkg_traza.TRACE ('CARGARGRILLA  NUVALEXTARC: ' || NUVALEXTARC, cnuNVLTRC);



        IF NUVALEXTARC = 0
        THEN
            pkg_traza.TRACE (
                   'CARGARGRILLA Error en el la extecion de archivo SBMENSAJEERROR: '
                || SBMENSAJEERROR,
                cnuNVLTRC);
            RAISE erextarc;
        END IF;

        LDC_BOARCHIVO.PRVALIDAEXISTENCIAABRIR (SBPATHFILE,
                                               SBFILENAME,
                                               NUCODIGOERROOR,
                                               SBMENSAJEERROR);

        IF NUCODIGOERROOR <> 0
        THEN
            pkg_traza.TRACE (
                'CARGARGRILLA aqui 3.1 SBMENSAJEERROR: ' || SBMENSAJEERROR,
                cnuNVLTRC);
            RAISE eerror;
        END IF;

        --INICIO ABRIR ARCHIVO DE ITEMS SERIADOS
        SBARCHIVOORIGEN := PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_UT (SBPATHFILE, SBFILENAME, 'R');
        ---INICIO ARCHIVO DE ERRORES
        SBNOMBREARCHIVODESTINO := SBFILENAME;
        SBNOMBREARCHIVODESTINO :=
               REPLACE (UPPER (SBNOMBREARCHIVODESTINO), '.TXT')
            || '_'
            || REPLACE (
                   REPLACE (
                       REPLACE (TO_CHAR (SYSDATE, 'DD/MM/YYYY HH:MI:SS'),
                                '/',
                                '_'),
                       ':',
                       '_'),
                   ' ',
                   '_')
            || '.ERR';

        LOOP
            BEGIN
                pkg_traza.TRACE (
                    'CARGARGRILLA aqui 5 NUREGISTRO:' || NUREGISTRO,
                    cnuNVLTRC);

                SBLINEARORIGEN:= PKG_GESTIONARCHIVOS.fsbObtenerLinea_Ut (SBARCHIVOORIGEN);
                SBLINEARORIGEN :=
                    REPLACE (REPLACE (SBLINEARORIGEN, CHR (10), ''),
                             CHR (13),
                             '');
                pkg_traza.TRACE ('LINEA --> ' || SBLINEARORIGEN, cnuNVLTRC);
                pkg_traza.TRACE ('LINEA --> ' || SBLINEARORIGEN, cnuNVLTRC);
                NUVALLINEA := REGEXP_COUNT (SBLINEARORIGEN, '^[0-9]*;$');

                pkg_traza.TRACE (
                       'CARGARGRILLA  LINEA --> '
                    || SBLINEARORIGEN
                    || ' NUVALLINEA:'
                    || NUVALLINEA,
                    cnuNVLTRC);
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    EXIT;
            END;

            IF NUVALLINEA >= 1
            THEN
                --CANTIDAD DE PALABRAS EN EL REGISTRO DEL ARCHIVO
                NUCANTIDADPALABRAS :=
                    LDC_BOARCHIVO.FNUCOUNTCHARACTER (SBLINEARORIGEN, ';');

                --INICIALIZA EL VECTOR Y VARIABLE
                SBARRAYVARCHAR := NULL;
                NUPACKAGE_ID := NULL;
                SBPACKAGE_ID := NULL;
                nuValSol := NULL;
                datos_sol := NULL;

                pkg_traza.TRACE (
                    'CARGARGRILLA  NUPACKAGE_ID: ' || NUPACKAGE_ID,
                    cnuNVLTRC);
                --COLOCA CADA PALABRA EN UN POSICION DEL VECTOR
                SBARRAYVARCHAR :=
                    SUBSTR (SBLINEARORIGEN,
                            1,
                              LENGTH (REGEXP_SUBSTR (SBLINEARORIGEN,
                                                     '.*?\;',
                                                     1,
                                                     1))
                            - 1);

                --RECORRE EL VECTOR PARA OBTENER EL VALOR DE CADA POSCION Y SER UTILIZADOS EN EL XML DE OPEN

                IF NUPACKAGE_ID IS NULL
                THEN
                    SBPACKAGE_ID := SBARRAYVARCHAR;
                    NUPACKAGE_ID :=
                        TO_NUMBER (
                            REPLACE (REPLACE (SBPACKAGE_ID, CHR (10), ''),
                                     CHR (13),
                                     ''));
                END IF;

                OPEN cuValSol (NUPACKAGE_ID);

                FETCH cuValSol INTO nuValSol;

                CLOSE cuValSol;

                -- SE VALIDA QUE LA SOLICITUD CUMPLA CO LOS REQUISITOS
                IF nuValSol = 1
                THEN
                    OPEN cuDatos (NUPACKAGE_ID);

                    FETCH cuDatos INTO datos_sol;

                    CLOSE cuDatos;

                    -- SE REGISTRA EN LA TABLA LDC_GENSOLANUL_TEMP
                    IF datos_sol.PACKAGE_ID IS NOT NULL
                    THEN
                        BEGIN
                            INSERT INTO LDC_GENSOLANUL_TEMP (PACKAGE_ID,
                                                             PACKAGE_TYPE_ID,
                                                             SOLICITANTE,
                                                             CEDULA,
                                                             CONTRATO,
                                                             PRODUCTO,
                                                             VALOR_VENTA,
                                                             CUOTA_INICIAL,
                                                             CUPON,
                                                             CUPON_PAGADO,
                                                             USER_ID)
                                 VALUES (datos_sol.PACKAGE_ID,
                                         datos_sol.package_type_id,
                                         datos_sol.solicitante,
                                         datos_sol.IDENTIFICATION,
                                         datos_sol.SUBSCRIPTION_ID,
                                         datos_sol.PRODUCT_ID,
                                         datos_sol.val_venta,
                                         datos_sol.cuota_ini,
                                         datos_sol.cupon,
                                         datos_sol.cupon_pagado,
                                         usercon);
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                pkg_traza.TRACE (
                                    'ERROR AL INSERTAR LDC_GENSOLANUL_TEMP',
                                    cnuNVLTRC);
                                PR_WRTERROR (
                                       'Error l??A-nea '
                                    || NUREGISTRO
                                    || ': ERROR AL INSERTAR LA SOLICITUD: '
                                    || datos_sol.PACKAGE_ID
                                    || ' LDC_GENSOLANUL_TEMP',
                                    SBNOMBREARCHIVODESTINO,
                                    SBPATHFILE);
                        END;

                        NUPROC := NUPROC + 1;
                    END IF;
                ELSE
                    PR_WRTERROR (
                           'Error linea '
                        || NUREGISTRO
                        || ': La solicitud  '
                        || NUPACKAGE_ID
                        || ', no cumple con los requisitos',
                        SBNOMBREARCHIVODESTINO,
                        SBPATHFILE);
                END IF;
            ELSE
                PR_WRTERROR (
                       'Error l??A-nea '
                    || NUREGISTRO
                    || ': LINEA NO TIENE LE FORMATO CORRECTO',
                    SBNOMBREARCHIVODESTINO,
                    SBPATHFILE);
            END IF;

            NUREGISTRO := NUREGISTRO + 1;
        END LOOP;

        COMMIT;
        PR_WRTERROR (
               'Se cargaron  '
            || NUPROC
            || ' de '
            || NUREGISTRO
            || ' solicitudes',
            SBNOMBREARCHIVODESTINO,
            SBPATHFILE);
        PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_UT (SBARCHIVOORIGEN);

        sbsqlmaestro := ' SELECT PACKAGE_ID,SOLICITANTE,CEDULA,CONTRATO,
						PRODUCTO,VALOR_VENTA,CUOTA_INICIAL,CUPON,CUPON_PAGADO
						FROM LDC_GENSOLANUL_TEMP ';

        OPEN rfresult FOR sbsqlmaestro;

		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
        RETURN rfresult;

    EXCEPTION
        WHEN eerror
        THEN
		    sbmensaje:= 'NO se encontro el archivo '||SBFILENAME|| ' en el directorio especificado';
			pkg_traza.trace('CARGARGRILLA ' || sbmensaje || ' ' || SQLERRM, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
		    pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,sbmensaje);

        WHEN erextarc
        THEN
		    sbmensaje:= 'El tipo de archivo inv??A!lido. Debe ser .txt';
            pkg_traza.trace ('CARGARGRILLA ' || sbmensaje || ' ' || SQLERRM,cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
			pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
        WHEN OTHERS
        THEN
		    pkg_error.setError;
			pkg_error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace ('CARGARGRILLA ' || ' ' || sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
			pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,sbErrorMessage);
    END CARGARGRILLA;

    -----------------------------------------------------------------------------------------------
    PROCEDURE PRPROCESAGRILLA (
        isbcodigo      IN     VARCHAR2,
        inucurrent     IN     NUMBER,
        inutotal       IN     NUMBER,
        onuerrorcode      OUT ge_error_log.message_id%TYPE,
        osberrormess      OUT ge_error_log.description%TYPE)
    IS
        sbFlag            VARCHAR2 (2);
        codigo            NUMBER;

        orden             LDC_CAMFEC.ORDER_ID%TYPE := 0;
        a_ejec            or_order.EXEC_INITIAL_DATE%TYPE;
        pkg               or_order_activity.PACKAGE_ID%TYPE;
        per_c             GE_PERSON.USER_ID%TYPE;
        sbRequestXML1     constants_per.tipo_xml_sol%TYPE;
        nuAddres          NUMBER;
        SBCOMMENT         ge_boInstanceControl.stysbValue;
        nuRecepType       NUMBER
            := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO ('RECEPTYPEANUL');
        nuCauAnul         NUMBER
            := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO ('CAUSALANUL');
        nuErrorCode       NUMBER;
        sbErrorMessage    VARCHAR2 (4000);
        nuPackageId       mo_packages.package_id%TYPE;
        nuMotiveId        mo_motive.motive_id%TYPE;
        osbErrorMessage   VARCHAR2 (4000);
        onuErrorCod       NUMBER;

        q_ejec            VARCHAR (200) := 'select EXEC_INITIAL_DATE
                        from  or_order
						where ORDER_ID=';

        sbProceso          VARCHAR2(70):= 'LDC_PKGENSOLAN.PRPROCESAGRILLA'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        CURSOR cu_reg (cod NUMBER)
        IS
            SELECT *
              FROM LDC_GENSOLANUL_TEMP
             WHERE PACKAGE_ID = cod;

        CURSOR cu_datos (cod NUMBER)
        IS
            SELECT mp.ADDRESS_ID, mp.SUBSCRIBER_ID
              FROM mo_packages mp
             WHERE mp.pACKAGE_ID = cod;

        datos_sol         cu_reg%ROWTYPE;
        datos             cu_datos%ROWTYPE;
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.PRPROCESAGRILLA';
		
    BEGIN
	
	    pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
		pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);
		
        per_c := pkg_bopersonal.fnuGetPersonaId();
        SBCOMMENT :=
            GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('MO_PACKAGES', 'COMMENT_');

        codigo := TO_NUMBER (isbcodigo);

        OPEN cu_reg (codigo);

        LOOP
            FETCH cu_reg INTO datos_sol;

            EXIT WHEN cu_reg%NOTFOUND;
        END LOOP;

        CLOSE cu_reg;

        IF datos_sol.PACKAGE_ID IS NOT NULL
        THEN
            OPEN cu_datos (datos_sol.PACKAGE_ID);

            FETCH cu_datos INTO datos;

            CLOSE cu_datos;

            sbRequestXML1 :=
			pkg_xml_soli_venta.getSolicitudAnulacionVenta(per_c,
														  nuRecepType,
														  datos.ADDRESS_ID,
														  datos.SUBSCRIBER_ID,
														  NULL,
														  SBCOMMENT,
														  datos_sol.PACKAGE_ID,
														  datos_sol.CONTRATO,
														  nuCauAnul
														  );

              api_registerRequestByXml(sbRequestXML1,
                                       nuPackageId,
                                       nuMotiveId,
                                       onuErrorCod,
                                       osbErrorMessage);

            IF onuErrorCod <> 0
            THEN
                nuErrorCode := onuErrorCod;
                sbErrorMessage := osbErrorMessage;
                pkg_traza.trace (
                    ' ERROR AL GENERAR EL TRAMITE -->' || sbErrorMessage,
                    cnuNVLTRC);

				  
		  	    
				
				pkg_estaproc.prActualizaEstaproc(sbProceso, ' con error',
												'ERROR  AL GENERAR EL TRAMITE DE ANULACION PARA LA SOLICITUD: '
												|| datos_sol.PACKAGE_ID|| ' LDC_GENSOLANUL_TEMP'
											    );

            ELSE
                DELETE FROM LDC_GENSOLANUL_TEMP
                      WHERE PACKAGE_ID = datos_sol.PACKAGE_ID;

                COMMIT;

		  	    pkg_estaproc.prActualizaEstaproc(sbProceso, ' Ok.',
												'SE GENERO EL TRAMITE ' || nuPackageId
												|| '  PARA LA SOLICITUD: '|| datos_sol.PACKAGE_ID
											   );

            END IF;
        END IF;
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
			ROLLBACK;
			RAISE;
        WHEN OTHERS THEN
            ROLLBACK;
            pkg_error.seterror;
			pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END PRPROCESAGRILLA;
	
    PROCEDURE ACTIVACUPON (inuPackage_id IN mo_packages.package_id%TYPE)
    IS
        nuCupon       NUMBER;
        nuError       NUMBER;
        sbmensa       VARCHAR2 (4000);
        coderror      NUMBER;
        nuSolicitud   mo_packages.package_id%TYPE;
        nuErrorCode   NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuObtienecupon (solicitud NUMBER)
        IS
            SELECT cu.CUPONUME     cupon
              FROM mo_packages mp, mo_motive mm, Cupon_Anulado_Ventas cu
             WHERE     mp.pACKAGE_ID = solicitud
                   AND mp.pACKAGE_ID = mm.pACKAGE_ID
                   AND cu.CUPOSUSC = mm.SUBSCRIPTION_ID;


        CURSOR cuCuponActivar (cupon NUMBER)
        IS
            SELECT *
              FROM Cupon_Anulado_Ventas
             WHERE Cuponume = cupon;

        rgCupo        cuCuponActivar%ROWTYPE;
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.ACTIVACUPON';
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        nuError := 0;

        pkg_traza.trace ('Solicitud: ' || INUPACKAGE_ID,cnuNVLTRC);
        nuSolicitud :=
			pkg_bcsolicitudes.fnuGetSolicitudAnulacion(INUPACKAGE_ID);

        OPEN cuObtienecupon (nuSolicitud);

        FETCH cuObtienecupon INTO nuCupon;

        CLOSE cuObtienecupon;

        pkg_traza.trace (
            'Solicitud: ' || nuSolicitud || ' cupon: ' || nuCupon,cnuNVLTRC);

        IF nuCupon IS NOT NULL
        THEN

            OPEN cuCuponActivar (nuCupon);

            FETCH cuCuponActivar INTO rgCupo;

            CLOSE cuCuponActivar;

            -- Se borra el cupon de la tabla cupon
            BEGIN
                DELETE FROM Cupon_Anulado_Ventas
                      WHERE Cuponume = rgCupo.Cuponume;

            EXCEPTION
                WHEN OTHERS
                THEN
                    nuError := 1;
            END;

            -- guarda los datos del cupon en la tabla Cupon_Anulado_Ventas
            IF nuError = 0
            THEN
                BEGIN
                    INSERT INTO Cupon
                         VALUES (rgCupo.Cuponume,
                                 rgCupo.cupotipo,
                                 rgCupo.cupodocu,
                                 rgCupo.cupovalo,
                                 rgCupo.cupofech,
                                 rgCupo.cupoprog,
                                 rgCupo.cupocupa,
                                 rgCupo.cuposusc,
                                 rgCupo.cupoflpa);
                EXCEPTION
                    WHEN OTHERS
                    THEN
                        pkg_traza.trace (SQLERRM,cnuNVLTRC);
                        nuError := 1;
                END;
            END IF;
        ELSE
            sbmensa :=
                'No se encontro cupon para la solicitud: ' || nuSolicitud;
            pkg_error.setErrorMessage (ld_boconstans.cnuGeneric_Error, sbmensa);
        END IF;


        IF nuError = 1
        THEN
            sbmensa :=
                   'No se pudo activar el cupon ['
                || rgCupo.Cuponume
                || '] asociado la solicitud: '
                || INUPACKAGE_ID;
            pkg_error.setErrorMessage (ld_boconstans.cnuGeneric_Error,sbmensa);
        END IF;
		
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
		    pkg_error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace (sbmensa,cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage,cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
			RAISE;
        WHEN OTHERS THEN
			pkg_error.setError;
		    pkg_error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace (sbmensa,cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage,cnuNVLTRC);
            RAISE pkg_error.CONTROLLED_ERROR;
    END ACTIVACUPON;

    PROCEDURE ANULACUPON (inuPackage_id IN mo_packages.package_id%TYPE)
    IS
        nuCupon       NUMBER;
        nuError       NUMBER;
        sbmensa       VARCHAR2 (4000);
        coderror      NUMBER;
        nuSolicitud   mo_packages.package_id%TYPE;

        CURSOR cuObtienecupon (solicitud NUMBER)
        IS
            SELECT cu.CUPONUME     cupon
              FROM mo_packages mp, mo_motive mm, cupon cu
             WHERE     mp.pACKAGE_ID = solicitud
                   AND mp.pACKAGE_ID = mm.pACKAGE_ID
                   AND cu.CUPOSUSC = mm.SUBSCRIPTION_ID;


        CURSOR cuCuponesAnular (cupon NUMBER)
        IS
            SELECT *
              FROM Cupon
             WHERE Cuponume = cupon;

        rgCupo        cuCuponesAnular%ROWTYPE;
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.ANULACUPON';
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        nuError := 0;
        pkg_traza.trace ('Solicitud: ' || INUPACKAGE_ID,cnuNVLTRC);
        nuSolicitud :=
            pkg_bcsolicitudes.fnuGetSolicitudAnulacion(INUPACKAGE_ID);

        OPEN cuObtienecupon (nuSolicitud);

        FETCH cuObtienecupon INTO nuCupon;

        CLOSE cuObtienecupon;

        IF nuCupon IS NOT NULL
        THEN

            OPEN cuCuponesAnular (nuCupon);

            FETCH cuCuponesAnular INTO rgCupo;

            CLOSE cuCuponesAnular;

            -- Se borra el cupon de la tabla cupon
            BEGIN
                DELETE FROM Cupon
                      WHERE Cuponume = rgCupo.Cuponume;

            EXCEPTION
                WHEN OTHERS
                THEN
                    nuError := 1;
            END;

            -- guarda los datos del cupon en la tabla Cupon_Anulado_Ventas
            IF nuError = 0
            THEN
                BEGIN
                    INSERT INTO Cupon_Anulado_Ventas
                         VALUES (rgCupo.Cuponume,
                                 rgCupo.cupotipo,
                                 rgCupo.cupodocu,
                                 rgCupo.cupovalo,
                                 rgCupo.cupofech,
                                 rgCupo.cupoprog,
                                 rgCupo.cupocupa,
                                 rgCupo.cuposusc,
                                 rgCupo.cupoflpa);

                EXCEPTION
                    WHEN OTHERS
                    THEN
                        nuError := 1;
                END;
            END IF;
        ELSE
            sbmensa :=
                'No se encontro cupon para la solicitud: ' || nuSolicitud;
            pkg_error.setErrorMessage (ld_boconstans.cnuGeneric_Error,
                                              sbmensa);
        END IF;


        IF nuError = 1
        THEN
            sbmensa :=
                   'No se pudo anular el cupon ['
                || rgCupo.Cuponume
                || '] asociado la solicitud: '
                || INUPACKAGE_ID;
            pkg_error.setErrorMessage (ld_boconstans.cnuGeneric_Error,
                                              sbmensa);
        END IF;

	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.getError (coderror, sbmensa);
			pkg_traza.trace(csbMT_NAME||' '||sbmensa,cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            RAISE;
        WHEN OTHERS THEN
		    pkg_error.setError;
            pkg_error.getError (coderror, sbmensa);
			pkg_traza.trace(csbMT_NAME||' '||sbmensa,cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END ANULACUPON;

    PROCEDURE CANCELANUL
    IS
        sbmensaje     VARCHAR2 (2000);
        eerror        EXCEPTION;

        nuInstancia   wf_instance.instance_id%TYPE;
        nuSolicitud   mo_packages.package_id%TYPE;
        nuError       NUMBER := 0;
        nuValsol      NUMBER;

        --se obtiene instancia de espera
        CURSOR cuGetInstancia IS
            SELECT i.instance_id
              FROM wf_data_external w, wf_instance i
             WHERE     w.package_id = nuSolicitud
                   AND w.plan_id = i.plan_id
                   AND i.unit_id = 103132;

        CURSOR cuValSol IS
            SELECT 1
              FROM MO_PACKAGES
             WHERE     PACKAGE_type_id = 100327
                   AND MOTIVE_STATUS_ID = 13
                   AND PACKAGE_ID = nuSolicitud;
				   
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.CANCELANUL';
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        nuSolicitud :=
            ge_boinstancecontrol.fsbgetfieldvalue ('MO_PACKAGES',
                                                   'PACKAGE_ID');


        pkg_traza.TRACE (
            'Inicio CANCELANUL, Id Paquete [' || nuSolicitud || ']',
            cnuNVLTRC);

        --obtiene instancia actual
        OPEN cuGetInstancia;

        FETCH cuGetInstancia INTO nuInstancia;

        CLOSE cuGetInstancia;

        OPEN cuValSol;

        FETCH cuValSol INTO NuValSol;

        CLOSE cuValSol;

        IF     nuInstancia IS NOT NULL
           AND NuValSol IS NOT NULL
           AND WF_BOINSTANCE.FNUGETSTATUS (nuInstancia) <> 6
        THEN
            -- se acancela la anulacion
            BEGIN
                UPDATE MO_PACKAGES
                   SET NUMBER_OF_PROD = 0
                 WHERE PACKAGE_ID = nuSolicitud;

                COMMIT;
            EXCEPTION
                WHEN OTHERS
                THEN
                    nuError := 1;
            END;

            pkg_traza.TRACE ('nuError : [' || nuError || ']', cnuNVLTRC);


            IF nuError = 0
            THEN
                WF_BOANSWER_RECEPTOR.ANSWERRECEPTOR (
                    nuInstancia,
                    pkg_gestionordenes.cnuCausalExito);
                COMMIT;
            ELSE
                MO_BOACTIONUTIL.SETEXECACTIONINSTANDBY (TRUE);
                sbmensaje :=
                       'No se pudo cancelar la anulacion de la solicitud: '
                    || nuSolicitud;
                RAISE eerror;
            END IF;
        ELSE         -- Si no existe la instancia, se deja en pespera le flujo
            sbmensaje :=
                   'La solicitud: '
                || nuSolicitud
                || ' no es apta para la cancelacion de anulacion.';
            RAISE eerror;
        END IF;

        pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN eerror THEN
            ROLLBACK;
            pkg_traza.trace (csbMT_NAME||' CANCELANUL ' || sbmensaje || ' ' || SQLERRM, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
			pkg_error.setErrorMessage(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
        WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuError, sbmensaje);
            pkg_traza.trace (csbMT_NAME||' CANCELANUL ' || sbmensaje || ' ' || SQLERRM, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);    
			RAISE pkg_error.controlled_error;
		END CANCELANUL;

    FUNCTION CARGACTANUL
        RETURN constants_per.tyrefcursor
    IS
        NUPACKAGE_ID   mo_packages.package_id%TYPE;
        sbsqlmaestro   ge_boutilities.stystatement; -- se almacena la consulta
        rfresult       constants_per.tyrefcursor;
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.CARGACTANUL';
		nuErrorCode number;
		sbErrorMessage varchar2(4000);
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

        NUPACKAGE_ID :=
            GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('MO_PACKAGES',
                                                   'PACKAGE_ID'); 

        IF NUPACKAGE_ID IS NULL
        THEN
            sbsqlmaestro :=
                   ' select 
					sc.PACKAGE_ID solicitud_de_anulacion,
					mp.PACKAGE_ID,
					 mp.package_type_id,
					 gs.SUBSCRIBER_NAME '
                || '||'' ''||'
                || ' gs.SUBS_LAST_NAME solicitante,
					 IDENTIFICATION,
					 mm.SUBSCRIPTION_ID,
					 mm.PRODUCT_ID,
					 TOTAL_VALUE val_venta,
					 INITIAL_PAYMENT cuota_ini,
					 cu.CUPONUME cupon,
					 cu.CUPOFLPA cupon_pagado
				from mo_packages      mp,
					 GE_SUBSCRIBER    gs,
					 mo_motive        mm,
					 Cupon_Anulado_Ventas            cu,
					 MO_GAS_SALE_DATA vn,
					 (select sa.PACKAGE_ID 
                    from mo_packages sa
                    where sa.package_type_id=100327 
                    and sa.NUMBER_OF_PROD is null  
                    AND sa.MOTIVE_STATUS_ID=13) sc
			   where mp.pACKAGE_ID = pkg_bcsolicitudes.fnuGetSolicitudAnulacion(sc.PACKAGE_ID)
				 and gs.SUBSCRIBER_ID = mp.SUBSCRIBER_ID
				 and mp.pACKAGE_ID = mm.pACKAGE_ID
				 and cu.CUPOSUSC = mm.SUBSCRIPTION_ID
				 and mp.pACKAGE_ID = vn.pACKAGE_ID 
				 AND (SELECT 1 FROM or_order_activity OA WHERE OA.PACKAGE_ID =sc.PACKAGE_ID) IS NULL';
        ELSE
            sbsqlmaestro :=
                   ' select 
					'
                || NUPACKAGE_ID
                || 'solicitud_de_anulacion,
					mp.PACKAGE_ID,
					 mp.package_type_id,
					 gs.SUBSCRIBER_NAME '
                || '||'' ''||'
                || ' gs.SUBS_LAST_NAME solicitante,
					 IDENTIFICATION,
					 mm.SUBSCRIPTION_ID,
					 mm.PRODUCT_ID,
					 TOTAL_VALUE val_venta,
					 INITIAL_PAYMENT cuota_ini,
					 cu.CUPONUME cupon,
					 cu.CUPOFLPA cupon_pagado
				from mo_packages      mp,
					 GE_SUBSCRIBER    gs,
					 mo_motive        mm,
					 Cupon_Anulado_Ventas            cu,
					 MO_GAS_SALE_DATA vn
			   where  gs.SUBSCRIBER_ID = mp.SUBSCRIBER_ID
				 and mp.pACKAGE_ID = mm.pACKAGE_ID
				 and cu.CUPOSUSC = mm.SUBSCRIPTION_ID
				 and mp.pACKAGE_ID = vn.pACKAGE_ID
				 AND (SELECT 1 FROM or_order_activity OA WHERE OA.PACKAGE_ID ='
                || NUPACKAGE_ID
                || ') IS NULL				 
				 AND mp.pACKAGE_ID='
                || pkg_bcsolicitudes.fnuGetSolicitudAnulacion (NUPACKAGE_ID);
        END IF;


        OPEN rfresult FOR sbsqlmaestro;

        pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
		RETURN rfresult;
        
		
    EXCEPTION
        WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.getError(nuErrorCode, sbErrorMessage);
            pkg_traza.trace (csbMT_NAME||' CARGACTANUL ' || ' ' || sbErrorMessage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
			RAISE pkg_error.controlled_error;
    END CARGACTANUL;

    PROCEDURE Aprubanul (isbcodigo      IN     VARCHAR2,
                         inucurrent     IN     NUMBER,
                         inutotal       IN     NUMBER,
                         onuerrorcode      OUT ge_error_log.message_id%TYPE,
                         osberrormess      OUT ge_error_log.description%TYPE)
    IS
        nuSolicitud   mo_packages.package_id%TYPE;
        nuInstancia   wf_instance.instance_id%TYPE;
        nuValsol      NUMBER;
        nuError       NUMBER := 0;
		nuErrorCode	  NUMBER;
		sbErrorMessage varchar2(4000);

        CURSOR cuGetInstancia IS
            SELECT i.instance_id
              FROM wf_data_external w, wf_instance i
             WHERE     w.package_id = nuSolicitud
                   AND w.plan_id = i.plan_id
                   AND i.unit_id = 103132;

        CURSOR cuValSol IS
            SELECT 1
              FROM MO_PACKAGES
             WHERE     PACKAGE_type_id = 100327
                   AND MOTIVE_STATUS_ID = 13
                   AND PACKAGE_ID = nuSolicitud;
				   
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.Aprubanul';
        sbProceso   VARCHAR2(70) := 'LDC_PKGENSOLAN.Aprubanul'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    BEGIN
	
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
        
		nuSolicitud := TO_NUMBER (isbcodigo);

        pkg_traza.TRACE ('Id Paquete [' || nuSolicitud || ']',cnuNVLTRC);
		
		pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

        --obtiene instancia actual
        OPEN cuGetInstancia;

        FETCH cuGetInstancia INTO nuInstancia;

        CLOSE cuGetInstancia;

        OPEN cuValSol;

        FETCH cuValSol INTO NuValSol;

        CLOSE cuValSol;

        IF     nuInstancia IS NOT NULL
           AND NuValSol IS NOT NULL
           AND WF_BOINSTANCE.FNUGETSTATUS (nuInstancia) <> 6
        THEN
            -- se acancela la anulacion
            BEGIN
                UPDATE MO_PACKAGES
                   SET NUMBER_OF_PROD = 1
                 WHERE PACKAGE_ID = nuSolicitud;

                COMMIT;
            EXCEPTION
                WHEN OTHERS
                THEN
                    nuError := 1;
            END;

            pkg_traza.TRACE ('nuError : [' || nuError || ']', cnuNVLTRC);


            IF nuError = 0
            THEN
                WF_BOANSWER_RECEPTOR.ANSWERRECEPTOR (
                    nuInstancia,
                    pkg_gestionordenes.cnuCausalExito);
                COMMIT;

				pkg_estaproc.prActualizaEstaproc(
								sbProceso, ' ok',
								'Fizalizado'
								);

            ELSE
                MO_BOACTIONUTIL.SETEXECACTIONINSTANDBY (TRUE);
                COMMIT;

				pkg_estaproc.prActualizaEstaproc(
												sbProceso, ' con error',
												'No se pudo cancelar la anulacion de la solicitud: ' || nuSolicitud
											    );
        END IF;
        ELSE         -- Si no existe la instancia, se deja en pespera le flujo
            MO_BOACTIONUTIL.SETEXECACTIONINSTANDBY (TRUE);
            COMMIT;

				pkg_estaproc.prActualizaEstaproc(
												sbProceso, ' ok',
												'La solicitud: '|| nuSolicitud || ' no es apta para la aprobacion de anulacion.'
											    );
        END IF;

        pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
		
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ROLLBACK;
		    pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
            RAISE;
        WHEN OTHERS THEN
            ROLLBACK;
            pkg_error.seterror;
		    pkg_error.getError(nuErrorCode, sbErrorMessage);
			pkg_traza.trace(csbMT_NAME||' '||sbErrorMessage);
			pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            RAISE pkg_error.controlled_error;
    END Aprubanul;
END LDC_PKGENSOLAN;
/

GRANT EXECUTE ON LDC_PKGENSOLAN TO SYSTEM_OBJ_PRIVS_ROLE;
/