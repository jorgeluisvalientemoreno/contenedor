CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_DELETECONFTAIN
AFTER delete ON  CONFTAIN
 FOR EACH ROW
DECLARE

    nuTasaValida    conftain.cotitain%TYPE;
    
    CURSOR cuTasasPBRCD(inuTasa IN conftain.cotitain%TYPE) IS
        SELECT	column_value
        FROM 	TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('LDC_TASAS_PBRCD',null),','))
        WHERE   column_value = inuTasa;
        
BEGIN
	ut_trace.trace('Inicio ldc_trg_deleteCONFTAIN', 10);
    
    OPEN cuTasasPBRCD(:OLD.cotitain);
    FETCH cuTasasPBRCD INTO nuTasaValida;
    CLOSE cuTasasPBRCD;
    
	IF (:OLD.cotitain = pktblparametr.fnugetvaluenumber('BIL_TASA_USURA') 
		OR nuTasaValida IS NOT NULL) THEN
		
        delete from ldc_conftain
		where ldc_conftain.cotitain = :OLD.cotitain
		and ldc_conftain.cotifein = :OLD.cotifein;
           
	END IF;
	
	ut_trace.trace('Fin ldc_trg_deleteCONFTAIN', 10);
END LDC_TRG_DELETECONFTAIN;
/