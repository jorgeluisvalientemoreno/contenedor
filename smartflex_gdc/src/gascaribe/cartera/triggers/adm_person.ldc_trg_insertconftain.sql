CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_INSERTCONFTAIN
AFTER insert ON  CONFTAIN
 FOR EACH ROW
DECLARE

	nuTasaValida    conftain.cotitain%TYPE;
    
    CURSOR cuTasasPBRCD(inuTasa IN conftain.cotitain%TYPE) IS
        SELECT	column_value
        FROM 	TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('LDC_TASAS_PBRCD',null),','))
        WHERE   column_value = inuTasa;
BEGIN
	ut_trace.trace('Inicio ldc_trg_insertCONFTAIN', 10);
	
	OPEN cuTasasPBRCD(:NEW.cotitain);
    FETCH cuTasasPBRCD INTO nuTasaValida;
    CLOSE cuTasasPBRCD;
	
	IF (:NEW.cotitain = pktblparametr.fnugetvaluenumber('BIL_TASA_USURA') 
		OR nuTasaValida IS NOT NULL) THEN
		
		insert into ldc_conftain (cotitain,cotifein,cotifefi,cotiporc,flag,FECHA_PROCESAMIENTO)
		values (:NEW.cotitain,:NEW.cotifein,:NEW.cotifefi,:NEW.cotiporc,'N',null);
			  
	END IF;
	
	ut_trace.trace('Fin ldc_trg_insertCONFTAIN', 10);
END LDC_TRG_INSERTCONFTAIN;
/