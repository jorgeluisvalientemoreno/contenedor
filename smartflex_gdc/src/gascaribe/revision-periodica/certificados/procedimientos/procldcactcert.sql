CREATE OR REPLACE PROCEDURE PROCLDCACTCERT 
(
	isbPathFile 	IN VARCHAR2,
	isbFileName     IN VARCHAR2
) 
IS
	/*****************************************************************
    Autor       : Carlos Gonzalez / Horbath
    Fecha       : 17/08/2022
    Ticket      : OSF-505
    Descripcion : Procedimiento del Proceso Batch LDCACTCERT para actualizacion de certificados OIA por archivo plano
    
	Parametros  :
	isbPathFile : Ruta del archivo
    isbFileName : Nombre del archivo a procesar

	Historia de Modificaciones
	Fecha       Ticket		Autor           Modificacion
	==========	=========	=============	====================
	17/08/2022	OSF-505	  	cgonzalez	    Creacion
	05/04/2024	OSF-2378	jpinedc	        Se cambia utl_file por pkg_gestionArchivos
                                            y se implementan ultimos estandares de
                                            programación
	******************************************************************/

	SUBTYPE STYSIZELINE IS VARCHAR2(32000);
	blDataArchivo       pkg_gestionArchivos.styArchivo;
	sbLine              STYSIZELINE;
	nuErrorCode         NUMBER;
	sbErrorMessage      VARCHAR2(2000);
	sbCertificadoOIA    VARCHAR2(2000);
	sbContrato      	VARCHAR2(2000);
	sbCertificadoNuevo 	VARCHAR2(2000);
	sbObservacion		VARCHAR2(2000);
    sbComentario		VARCHAR2(2000);
	tbDataLinea    		ut_string.TYTB_STRING;
	sbSeparador 		VARCHAR2(1) := '|';
	nuAno  		  		NUMBER;
    nuMes  		  		NUMBER;
    nuSesion       		NUMBER;
    sbUsuario       	VARCHAR2(100);
	sbTerminal       	VARCHAR2(100);

	CURSOR cuObtenerCertificado
	(
		inuCertificado 	IN 	ldc_certificados_oia.certificados_oia_id%TYPE,
		inuContrato		IN 	ldc_certificados_oia.id_contrato%TYPE
	) 
	IS
    SELECT 	*
    FROM 	ldc_certificados_oia
    WHERE	certificados_oia_id = inuCertificado
    AND 	id_contrato = inuContrato;

	rcCertificado ldc_certificados_oia%ROWTYPE;

    sbproceso  VARCHAR2(100)  := 'LDCACTCERT'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
  	
BEGIN

	pkg_Traza.Trace('INICIO PROCLDCACTCERT', 5);
	pkg_Traza.Trace('isbPathFile: '||isbPathFile, 5);
	pkg_Traza.Trace('isbFileName: '||isbFileName, 5);
			
	nuAno       := to_number(to_char(SYSDATE,'YYYY'));
	nuMes       := to_number(to_char(SYSDATE,'MM'));
	nuSesion    := USERENV('SESSIONID');
	sbTerminal  := USERENV('TERMINAL');
	sbUsuario   := USER;
	
	blDataArchivo := pkg_gestionArchivos.ftAbrirArchivo_SMF( isbPathFile, isbFileName, 'r' );
	
    pkg_estaproc.prinsertaestaproc( sbproceso , 1);
	
	--Ciclo para recorrer el archivo plano y almacenar en la tabla temporal de ordenes
	LOOP
    
        BEGIN
            sbLine := pkg_gestionArchivos.fsbObtenerLinea_SMF(blDataArchivo);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
        END;

		sbLine := replace(replace(TRIM(sbLine),chr(10), ''), chr(13),'');

		UT_STRING.EXTSTRING(sbLine, sbSeparador, tbDataLinea);

		sbCertificadoOIA    := tbDataLinea(1);
		sbContrato 			:= tbDataLinea(2);
		sbCertificadoNuevo 	:= tbDataLinea(3);
		sbObservacion 		:= tbDataLinea(4);

		IF (cuObtenerCertificado%isopen) THEN
			CLOSE cuObtenerCertificado;
		END IF;

		OPEN cuObtenerCertificado(sbCertificadoOIA, sbContrato);
		FETCH cuObtenerCertificado INTO rcCertificado;
		CLOSE cuObtenerCertificado;

		sbComentario := 'ERROR - No Existe el Certificado OIA';
		
		IF (rcCertificado.certificados_oia_id IS NOT NULL) THEN
			
			UPDATE 	ldc_certificados_oia
			SET 	certificado = sbCertificadoNuevo
			WHERE 	certificados_oia_id = sbCertificadoOIA
			AND 	id_contrato = sbContrato;
			
			sbComentario := 'OK - Certificado OIA actualizado con exito';
		END IF;
		
		INSERT INTO LDC_LOGACTCERT(LOGACTCERT_ID, NOMBRE_ARCHIVO, LINEA, CERTIFICADOS_OIA_ID, ID_CONTRATO, CERTIFICADO_ACTUAL, CERTIFICADO_NUEVO, OBSERVACION, FECHA, ESTADO, USUARIO, TERMINAL)
		VALUES (LDC_SEQLOGACTCERT.NEXTVAL, isbFileName, sbLine, sbCertificadoOIA, sbContrato, rcCertificado.certificado, sbCertificadoNuevo, sbObservacion, SYSDATE, sbComentario, sbUsuario, sbTerminal);
		
		rcCertificado := NULL;

	END LOOP;

    --Valido y cierro el archivo plano de registros cargado.
    IF (pkg_gestionArchivos.fblArchivoAbierto_SMF(blDataArchivo)) THEN
		pkg_gestionArchivos.prcCerrarArchivo_SMF (blDataArchivo);
    END IF;

    pkg_estaproc.practualizaestaproc(isbproceso => sbproceso);

	COMMIT;

    pkg_Traza.Trace('FIN PROCLDCACTCERT', 5);

EXCEPTION
	WHEN pkg_Error.CONTROLLED_ERROR THEN
		pkg_Error.getError(nuErrorCode, sbErrorMessage);
        pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sbErrorMessage  );		
		ROLLBACK;
		RAISE pkg_Error.CONTROLLED_ERROR;
	WHEN OTHERS THEN
		pkg_Error.setError;
		pkg_Error.getError(nuErrorCode, sbErrorMessage);
        pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sbErrorMessage  );		
		ROLLBACK;
		RAISE pkg_Error.CONTROLLED_ERROR;
END PROCLDCACTCERT;
/