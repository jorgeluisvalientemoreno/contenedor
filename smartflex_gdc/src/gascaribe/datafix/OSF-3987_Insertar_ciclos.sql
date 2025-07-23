DECLARE

    nuConta NUMBER;

    CURSOR cuDatosGdCa
    IS
	SELECT ciclcodi CICLO, 'GDCA' EMPRESA
	FROM CICLO;
    
	CURSOR cuExiste (inuCiclo IN NUMBER) 
	IS
	SELECT COUNT(*)
	FROM CICLO_FACTURACION
	WHERE CICLO = inuCiclo;
    
    rcDatosGdCa cuDatosGdCa%ROWTYPE;
    
BEGIN


    FOR rcDatosGdCa IN cuDatosGdCa LOOP
	
		OPEN cuExiste(rcDatosGdCa.ciclo);
		FETCH cuExiste INTO nuConta;
		CLOSE cuExiste;
	
		IF nuConta = 0 THEN	

			BEGIN
			
				INSERT INTO MULTIEMPRESA.CICLO_FACTURACION VALUES rcDatosGdCa;
				
				COMMIT;

				DBMS_OUTPUT.PUT_LINE('INFO:INSERCION EN CICLO_FACTURACION CICLO[' || rcDatosGdCa.CICLO || '][OK]' ); 
				
			EXCEPTION
				WHEN OTHERS THEN
					DBMS_OUTPUT.PUT_LINE('ERROR:INSERCION EN CICLO_FACTURACION CICLO[' || rcDatosGdCa.CICLO || '][' || SQLERRM || ']' ); 
					ROLLBACK;
			END;

		END IF;
        
    END LOOP;

END;
/