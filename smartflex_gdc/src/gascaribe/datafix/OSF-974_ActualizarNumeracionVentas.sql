BEGIN
	DECLARE
		nuErrorCode      NUMBER;
		sbErrorMessage   VARCHAR2(4000);
		nuEjecucionFlujo NUMBER := 0;
	BEGIN
		-- Empujar Flujo solicitud de devolución 115481591
		BEGIN
			errors.Initialize;
			ut_trace.Init;
			ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
			ut_trace.SetLevel(0);
			ut_trace.Trace('INICIO');
			
			dbms_output.put_line('APLICANDO DATAFIX');
			  
			dbms_output.put_line('Procesar Solicitud 174288710');

			WF_BOAnswer_Receptor.AnswerReceptor(2084734794, -- Código de la instancia del flujo
												MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
      
			COMMIT;
	  
			dbms_output.put_line('Procesar Solicitud 178280560');
	  
			WF_BOAnswer_Receptor.AnswerReceptor(56450551, -- Código de la instancia del flujo
												MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
      
			COMMIT;
	  
			dbms_output.put_line('Procesar Solicitud 196630925');

			UPDATE 	mo_packages
			SET		document_key = '701779'
			WHERE	package_id = 196630925;
	  
			COMMIT;
	  
			dbms_output.put_line('Procesar Solicitud 197245083');
	  
			UPDATE 	mo_packages
			SET		document_key = '701813'
			WHERE	package_id = 197245083;
	  
			COMMIT;
			
			dbms_output.put_line('Procesar Solicitud 177550510');
	  
			UPDATE 	fa_histcodi
			SET		hicdesta = 'P'
			WHERE	hicdcons = 167974706;
	  
			COMMIT;
			
			dbms_output.put_line('FIN APLICANDO DATAFIX');
	  
		EXCEPTION
			when ex.CONTROLLED_ERROR then
				nuEjecucionFlujo := 1;
				Errors.getError(nuErrorCode, sbErrorMessage);
				dbms_output.put_line('ERROR CONTROLLED ');
				dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
				dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
			when OTHERS then
				nuEjecucionFlujo := 1;
				Errors.setError;
				Errors.getError(nuErrorCode, sbErrorMessage);
				dbms_output.put_line('ERROR OTHERS ');
				dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
				dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
		END;
	END;
END;
/