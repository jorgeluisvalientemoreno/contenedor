CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBITASADIFERIDO
BEFORE INSERT ON diferido
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW 
DECLARE

	CURSOR cuTasasPBRCD(inuTasa IN conftain.cotitain%TYPE)
	IS
		SELECT	column_value
        FROM 	TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('LDC_TASAS_PBRCD', NULL),','))
        WHERE   column_value = inuTasa;
		
	CURSOR cuPorcentajeVig(inuTasa IN conftain.cotitain%TYPE)
	IS
		SELECT 	cotiporc
		FROM  	ldc_conftain
		WHERE 	cotitain = inuTasa
		AND 	SYSDATE BETWEEN TO_DATE(cotifein, ut_date.fsbDATE_FORMAT) AND TO_DATE(cotifefi, ut_date.fsbDATE_FORMAT);
		
	CURSOR cuPlanDife(inuPldicodi IN plandife.pldicodi%TYPE, inupldimccd IN plandife.pldimccd%TYPE) IS
		SELECT 	*
		FROM 	plandife pd
		WHERE 	pd.pldicodi = inuPldicodi
		AND 	pd.pldimccd = inuPldimccd;

	rcPlanDife 		cuPlanDife%ROWTYPE;
	nuTasaValida    conftain.cotitain%TYPE;
	nuPorcentaje	ldc_conftain.cotiporc%TYPE;
	nuQuotaValue  	diferido.difevacu%TYPE;
	nuInteresPorc 	conftain.cotiporc%type;
	nuDifetain  	diferido.difetain%TYPE;
	nuDifeinte  	diferido.difeinte%TYPE;
	nuDifemeca		diferido.difemeca%TYPE;
	nuDifespre		diferido.difespre%TYPE;
	nuDifesape		diferido.difesape%TYPE;
	nuDifenucu		diferido.difenucu%TYPE;
	nuDifecupa		diferido.difecupa%TYPE;
	nuDifefagr		diferido.difefagr%TYPE;
	nuDifesusc		diferido.difesusc%TYPE;
	nuDifecodi		diferido.difecodi%TYPE;
	nuNominalPerc 	NUMBER;
	nuRoundFactor 	NUMBER;
	inuIdCompany  	NUMBER := 99;
	sbProcesar   	VARCHAR2(1) := 'S';
	
	nuFactorGradiante NUMBER;
	nuCuotaCalculada  NUMBER;
	nuNuevoQuotaValue NUMBER;
BEGIN
	
	nuDifetain := :NEW.difetain;
	nuDifeinte := :NEW.difeinte;
	nuDifemeca := :NEW.difemeca;
	nuDifespre := :NEW.difespre;
	nuDifesape := :NEW.difesape;
	nuDifenucu := :NEW.difenucu;
	nuDifecupa := :NEW.difecupa;
	nuDifefagr := :NEW.difefagr;
	nuDifesusc := :NEW.difesusc;
	nuDifecodi := :NEW.difecodi;
	
	--Obtener tasa vigente para la fecha actual
	OPEN cuPorcentajeVig(nuDifetain);
	FETCH cuPorcentajeVig INTO nuPorcentaje;
	CLOSE cuPorcentajeVig;
	
	IF (nuPorcentaje IS NOT NULL AND nuPorcentaje <> nuDifeinte AND nuDifeinte <> 0) THEN

		nuInteresPorc := nuDifeinte;

		--OSF 345 - Logica para procesar tasas del parametro LDC_TASAS_PBRCD
		IF (nuDifetain = pktblparametr.fnugetvaluenumber('BIL_TASA_USURA')) THEN
			--Validar el metodo antes de obtener el % interes
			IF (INSTR(DALD_PARAMETER.fsbGetValue_Chain('ID_MECADIFE'), TO_CHAR(nuDifemeca)) > 0) THEN
				--Validar si el % de interes pactado sobrepasa el % de usura
				IF (nuInteresPorc > nuPorcentaje) THEN
					nuInteresPorc := nuPorcentaje;
					sbProcesar    := 'S';
				ELSE
					sbProcesar := 'N';
				END IF;
			ELSE
				nuInteresPorc := nuPorcentaje;
				sbProcesar    := 'S';
			END IF;
		ELSE
			OPEN cuTasasPBRCD(nuDifetain);
			FETCH cuTasasPBRCD INTO nuTasaValida;
			CLOSE cuTasasPBRCD;

			IF (nuTasaValida IS NOT NULL) THEN
				nuInteresPorc := nuPorcentaje;
				sbProcesar    := 'S';
			END IF;
		END IF;

        IF (sbProcesar = 'S') THEN
            --Calcula el interes nominal
            pkDeferredMgr.ValInterestSpread(nuDifemeca, -- Metodo de Calculo
                                            nuInteresPorc, -- Porcentaje de Interes (Efectivo Anual)
                                            nuDifespre, -- Spread
                                            nuNominalPerc -- Interes Nominal (Salida)
                                            );

            -- Obtiene el valor de la cuota
            pkDeferredMgr.CalculatePayment(nuDifesape, -- Saldo a Diferir (difesape)
                                           (nuDifenucu - nuDifecupa), -- Numero de Cuotas  diferido
                                           nuNominalPerc, -- Interes Nominal
                                           nuDifemeca, -- Metodo de Calculo
                                           nuDifefagr, --nuDifespre,              -- Spread
                                           nuInteresPorc + nuDifespre, -- Interes Efectivo mas Spread
                                           nuQuotaValue -- Valor de la Cuota (Salida)
                                           );

            --  Obtiene el factor de redondeo para la suscripcion
            FA_BOPoliticaRedondeo.ObtFactorRedondeo(nuDifesusc,
                                                    nuRoundFactor,
                                                    inuIdCompany);

            IF (OPEN.LDC_CONFIGURACIONRQ.APLICAPARAGDC('CRM_JLVM_NC_3698') = TRUE) THEN
              
				OPEN cuPlanDife(:NEW.difepldi, nuDifemeca);
				FETCH cuPlanDife INTO rcPlanDife;
				
				IF (cuPlanDife%FOUND) THEN
				
					nuFactorGradiante := rcPlanDife.PLDIFAGR;
					
					nuCuotaCalculada := power((1 + (nuFactorGradiante/100)), nuDifecupa);

					nuNuevoQuotaValue := nuQuotaValue / nuCuotaCalculada;

					nuQuotaValue := nuNuevoQuotaValue;

				END IF;
                
				CLOSE cuPlanDife;
                
            END IF;
            
			--  Aplica politica de redondeo al valor de la cuota
            nuQuotaValue := round(nuQuotaValue, nuRoundFactor);

            --Actualizar el valor de la cuota en el diferido
            :NEW.difevacu := nuQuotaValue;

            --Actualizar porcentaje del diferido
            :NEW.difeinte := nuPorcentaje;
            
        END IF;
	END IF;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
		RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
		errors.seterror;
		RAISE EX.CONTROLLED_ERROR;
END;
/