create or replace PROCEDURE adm_person.ldc_prvaldatcargcontrato IS

      /*******************************************************************************
     Metodo:       LDC_PRVALDATCARGCONTRATO
     Descripcion:  Procedimiento usado como regla de validacion para verificar que los campos
				   estan llenos en el PB y se encarga de ejecutar toda la logica del PB LDC_PBREGCONT

     Autor:        Olsoftware/Miguel Ballesteros
     Fecha:        11/01/2021


     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
     19/03/2023  Adrianavg           OSF-2389: Se aplican pautas técnicas y se reemplazan servicios homólogos
                                     Se declaran variables para la gestión de trazas
                                     Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                     Se retira esquema OPEN antepuesto a ge_person
                                     Se reemplaza ldc_boutilities por REGEXP_SUBSTR
                                     Se declaran variables para la gestión de trazas del metodo interno
                                     Se reemplaza ex.controlled_error por Pkg_Error.controlled_error
                                     Se reemplaza ge_boerrors.seterrorcodeargument por Pkg_Error.Seterrormessage y se retira el raise por que este ya se hace
                                     en la lógica interna del Pkg_Error.Seterrormessage
                                     Se reemplaza ERRORS.seterror por Pkg_Error.seterror
                                     Se reemplaza ge_bofilemanager.fileopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                     Se reemplaza ge_bofilemanager.csbread_open_file por pkg_gestionarchivos.csbmodo_lectura
                                     Se reemplaza ge_bofilemanager.fileread por pkg_gestionarchivos.fsbobtenerlinea_smf
                                     Se reemplaza utl_file.fgetattr por pkg_gestionarchivos.prcatributosarchivo_smf
                                     Se reemplaza dage_directory.fsbgetpath por pkg_bcdirectorios.fsbgetruta
                                     Se reemplaza ldc_sendemail por pkg_correo.prcenviacorreo
                                     Se declaran variables sbCuerpoCorreo, sbSender, sbAsunto, nuCodigo, cnuEND_OF_FILE
                                     Se añade BEGIN-END para al llamado de pkg_gestionarchivos.fsbobtenerlinea_smf() para manejar
                                     la exception de fin de archivo y asignar valor a nuCodigo
                                     Se ajusta bloque de excepciones según pautas técnicas
                                     Añado asignación de valor a la variable Onuerrorcode previo a invocar el Pkg_Error.Seterrormessage
	19-04-2024		 Adrianavg		 OSF-2389: Se migra del esquema OPEN al esquema ADM_PERSON                                     
	29-05-2024		 Adrianavg		 OSF-2389: Se retira declaración y uso de la variable sbSender como parametro en el pkg_correo.prcenviacorreo ( remitente del correo)    
                                     Se ajusta invocación del pkg_correo.prcenviacorreo retirando parámetros con valor por defecto
    *******************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo               CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza           CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	        CONSTANT VARCHAR2(35) 	    := pkg_traza.csbInicio;
    Onuerrorcode            NUMBER                      := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage         VARCHAR2(2000);

	sbDIRECTORY_ID 			ge_boInstanceControl.stysbValue;
	sbFILE_NAME 			ge_boInstanceControl.stysbValue;
	SBRuta		      		GE_DIRECTORY.PATH%TYPE;
	nuLengthBytes   		NUMBER;
    nuBlocks        		NUMBER;
	boExistsFile    		BOOLEAN;
	FPSUSCRIPCDATA          pkg_gestionarchivos.styarchivo;
	CNUMAXLENGTHTOASSIG   	CONSTANT  NUMBER:=32000;
	NURECORD              	NUMBER;
	SUBTYPE STYSIZELINE     IS VARCHAR2(32000);
	SBLINE                  STYSIZELINE;
	SBContrato_id           VARCHAR2(2000);
	nuContrato_id			suscripc.susccodi%type;
	sbSeparador 			VARCHAR2(1) := ';';
	TBSTRING    			ut_string.TYTB_STRING;
	sbmensa         		VARCHAR2(10000);

    -- cursor para obtener los correos --
    CURSOR cugetemails IS
    SELECT G.e_mail correo
      FROM ge_person G
      WHERE G.person_id IN (--USUARIOS PERMITIDOS PARA APROBAR Y RECHAZAR TERMINACIONES DE CONTRATOS A USUARIOS CON DEUDA CASO 560
                            SELECT TO_NUMBER(Regexp_Substr(pkg_bcld_parameter.fsbobtienevalorcadena('LDC_PARUSERPERMI'),  '[^,]+',  1, LEVEL)) AS columna
                              FROM dual
                           CONNECT BY REGEXP_SUBSTR(pkg_bcld_parameter.fsbobtienevalorcadena('LDC_PARUSERPERMI'), '[^,]+', 1, LEVEL) IS NOT NULL);

    sbCuerpoCorreo         VARCHAR2(2000)   := 'Se han enviado contratos para su aprobación de Terminación de Contrato y que deben ingresar a la nueva forma LDC_APUSSOTECO para proceder a aprobar o rechazar el listado. ';
    sbAsunto               VARCHAR2(2000)   := 'Códigos de Contratos para Terminación';
    nuCodigo               NUMBER;
    cnuEND_OF_FILE         CONSTANT NUMBER := 1;


	PROCEDURE prollenatabla (nuContrato  suscripc.susccodi%type)
    IS
	  PRAGMA AUTONOMOUS_TRANSACTION;
      --Se declaran variables para la gestión de trazas del metodo interno
        csbMetodoInt               CONSTANT VARCHAR2(40)       := $$PLSQL_UNIT||'.'||'prollenatabla';
    BEGIN

        pkg_traza.trace(csbMetodoInt, csbNivelTraza, csbInicio);
        pkg_error.prInicializaError(Onuerrorcode, Osberrormessage);

        INSERT INTO ldc_contratpendtermi ( contrato_id, estado, observacion, ident_user, fecha_ejecucion )
                                   VALUES( nucontrato ,  'P'  ,  NULL      ,  NULL     , NULL) ;
        pkg_traza.trace(csbMetodoInt||' INSERT INTO LDC_CONTRATPENDTERMI, CONTRATO_ID= '||nucontrato||', Estado: Pendiente', csbNivelTraza);
        COMMIT;

        pkg_traza.trace(csbMetodoInt, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN Pkg_Error.controlled_error THEN
			ROLLBACK;
            Onuerrorcode:= pkg_error.CNUGENERIC_MESSAGE;
            Osberrormessage:= sqlerrm;
            pkg_traza.trace(csbMetodoInt||' WHEN Pkg_Error.controlled_error '||Osberrormessage, csbNivelTraza);
			pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            Pkg_Error.Seterrormessage(Onuerrorcode,  Osberrormessage);
        WHEN OTHERS THEN
            ROLLBACK;
            Onuerrorcode:= pkg_error.CNUGENERIC_MESSAGE;
            Osberrormessage:= sqlerrm;
            pkg_traza.trace(csbMetodoInt||' WHEN OTHERS '||Osberrormessage, csbNivelTraza);
			pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            Pkg_Error.Seterrormessage(Onuerrorcode,  Osberrormessage);
    END;

	----------------------------------------------------------

 BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, Osberrormessage);

	sbDIRECTORY_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DIRECTORY_ID');
	pkg_traza.trace(csbMetodo||' Directorio: '||sbDIRECTORY_ID, csbNivelTraza);

    sbFILE_NAME    := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_COMMENT', 'ORDER_COMMENT');
    pkg_traza.trace(csbMetodo||' Nombre Archivo: '||sbFILE_NAME, csbNivelTraza);

	-- se obtiene la ruta
	SBRuta := pkg_bcdirectorios.fsbgetruta( sbDIRECTORY_ID );
    pkg_traza.trace(csbMetodo||' Ruta: '||SBRuta, csbNivelTraza);

	-- valida que exista el archivo en el directorio
	pkg_gestionarchivos.prcatributosarchivo_smf( SBRuta, sbFILE_NAME, boExistsFile, nuLengthBytes, nuBlocks);

    IF boExistsFile THEN

		-- se abre el archivo
		fpsuscripcdata:= pkg_gestionarchivos.ftabrirarchivo_smf (SBRuta, sbFILE_NAME, pkg_gestionarchivos.csbmodo_lectura);

		-- se recorre el archivo
		WHILE TRUE LOOP

            --nuCodigo: esta variable es igual a 1 cuando ya no hay registros para procesar
            BEGIN
              SBLINE:= pkg_gestionarchivos.fsbobtenerlinea_smf(fpsuscripcdata);
              pkg_traza.trace(csbMetodo ||' Se obtiene linea: ' || SBLINE, csbNivelTraza);
              nucodigo:=0;
            EXCEPTION WHEN NO_DATA_FOUND THEN
              nucodigo:=1;
            END;
            pkg_traza.trace(csbMetodo ||' nucodigo: ' ||nucodigo, csbNivelTraza);
            EXIT WHEN(nuCodigo = cnuend_of_file);

			pkg_traza.trace(csbMetodo||' Línea: '||SBLINE, csbNivelTraza);

			SBLINE := replace(replace(TRIM(SBLINE),chr(10), ''), chr(13),'');

			pkg_traza.trace(csbMetodo||' Línea sin saltos: '||SBLINE, csbNivelTraza);

			DECLARE

				CURSOR cusplitsbline IS
					SELECT TO_NUMBER(Regexp_Substr(sbline,  '[^,]+',  1, LEVEL)) AS contrato
                      FROM dual
                   CONNECT BY REGEXP_SUBSTR(sbline, '[^,]+', 1, LEVEL) IS NOT NULL;

			BEGIN
                pkg_traza.trace(csbMetodo||' Inicia llenado de tabla ldc_contratpendtermi', csbNivelTraza);
				FOR J IN cusplitsbline
					LOOP
						pkg_traza.trace(csbMetodo||' Contrato: '||J.contrato, csbNivelTraza);
                        prollenatabla(J.contrato);
					END LOOP;
                pkg_traza.trace(csbMetodo||' Fin llenado de tabla ldc_contratpendtermi', csbNivelTraza);
			END;
		 END LOOP;

		 -- se envia un correo indicando que hay contratos guardados
        pkg_traza.trace(csbMetodo||' Se envia un correo indicando que hay contratos guardados ', csbNivelTraza);
	    FOR i IN cuGetEmails
			LOOP
                pkg_traza.trace(csbMetodo||' Destinatarios '||i.correo, csbNivelTraza);
				pkg_correo.prcenviacorreo( i.correo,       --isbDestinatarios
                                           sbAsunto,       --isbAsunto
                                           sbCuerpoCorreo); --isbMensaje
		 END LOOP;

	ELSE
		sbmensa := 'El archivo no existe en la base de datos o no esta en esa ruta';
        pkg_traza.trace(csbMetodo||' sbmensa: '||sbmensa, csbNivelTraza);
		Onuerrorcode:= pkg_error.CNUGENERIC_MESSAGE;
        Pkg_Error.Seterrormessage(onuerrorcode, sbmensa);
	END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage||', Backtrace '||DBMS_UTILITY.format_error_backtrace, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;
END LDC_PRVALDATCARGCONTRATO;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_PRVALDATCARGCONTRATO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRVALDATCARGCONTRATO', 'ADM_PERSON'); 
END;
/