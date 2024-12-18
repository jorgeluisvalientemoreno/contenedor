column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuDiferidos IS
		SELECT 	*
		FROM 	open.diferido
		WHERE 	difecodi in (99422293,99414787,99413938,99460060,99523379,99390807,99388842,99616409,99407714,98989162,99147591,99294088)
		AND 	exists (select 'x' from open.suscripc where difesusc = susccodi and suscnupr = 0);
		
	TYPE tytbDiferidos IS TABLE OF cuDiferidos%ROWTYPE INDEX BY BINARY_INTEGER;
	tbDiferidos tytbDiferidos;
	
	nuErrorCode 	NUMBER;
    sbErrorMessage 	VARCHAR2(4000);
	nuIndex 		BINARY_INTEGER;
	
	nuPorcentaje 	NUMBER := 0;
	nuInteresPorc	NUMBER := 0;
	nuDifemeca		diferido.difemeca%TYPE;
	nuDifespre		diferido.difespre%TYPE;
	nuDifesape		diferido.difesape%TYPE;
	nuDifenucu		diferido.difenucu%TYPE;
	nuDifecupa		diferido.difecupa%TYPE;
	nuDifefagr		diferido.difefagr%TYPE;
	nuDifesusc		diferido.difesusc%TYPE;
	nuDifecodi		diferido.difecodi%TYPE;
	nuQuotaValue  	diferido.difevacu%TYPE;
	nuDifevatd 		diferido.difevatd%TYPE;
	nuDifenuse		diferido.difenuse%TYPE;
	nuDifeinte		diferido.difeinte%TYPE;
	nuDifevacu		diferido.difevacu%TYPE;
	nuNominalPerc 	NUMBER;
	nuRoundFactor 	NUMBER;
	inuIdCompany  	NUMBER := 99;
	
	nuReporte		NUMBER;
	nuConsecutivo	NUMBER := 1;
BEGIN
	
	OPEN cuDiferidos;
	FETCH cuDiferidos BULK COLLECT INTO tbDiferidos;
	CLOSE cuDiferidos;
	
	nuIndex := tbDiferidos.FIRST;
	
	nuReporte := SQ_REPORTES.NEXTVAL;
	
	INSERT INTO REPORTES(REPONUME, REPOAPLI, REPOFECH, REPOUSER, REPODESC) VALUES (nuReporte,'OSF-768',SYSDATE,'OPEN','Datafix DIFERIDOS OSF-768');
	
	LOOP
		EXIT WHEN nuIndex IS NULL;

		BEGIN
		
			nuDifemeca := tbDiferidos(nuIndex).difemeca;
			nuDifespre := tbDiferidos(nuIndex).difespre;
			nuDifesape := tbDiferidos(nuIndex).difesape;
			nuDifenucu := tbDiferidos(nuIndex).difenucu;
			nuDifecupa := tbDiferidos(nuIndex).difecupa;
			nuDifefagr := tbDiferidos(nuIndex).difefagr;
			nuDifesusc := tbDiferidos(nuIndex).difesusc;
			nuDifecodi := tbDiferidos(nuIndex).difecodi;
			nuDifevatd := tbDiferidos(nuIndex).difevatd;
			nuDifenuse := tbDiferidos(nuIndex).difenuse;
			nuDifeinte := tbDiferidos(nuIndex).difeinte;
			nuDifevacu := tbDiferidos(nuIndex).difevacu;
			
			--Calcula el interes nominal
			pkDeferredMgr.ValInterestSpread(nuDifemeca, -- Metodo de Calculo
												nuInteresPorc, -- Porcentaje de Interes (Efectivo Anual)
												nuDifespre, -- Spread
												nuNominalPerc -- Interes Nominal (Salida)
												);

			-- Obtiene el valor de la cuota
			pkDeferredMgr.CalculatePayment(nuDifevatd, -- Saldo a Diferir (difesape)
											   nuDifenucu, --(nuDifenucu - nuDifecupa), -- Numero de Cuotas  diferido
											   nuNominalPerc, -- Interes Nominal
											   nuDifemeca, -- Metodo de Calculo
											   nuDifefagr, --nuDifespre,              -- Spread
											   nuInteresPorc + nuDifespre, -- Interes Efectivo mas Spread
											   nuQuotaValue -- Valor de la Cuota (Salida)
											   );

			--  Obtiene el factor de redondeo para la suscripcion
			FA_BOPoliticaRedondeo.ObtFactorRedondeo(nuDifesusc, nuRoundFactor, inuIdCompany);

			--  Aplica politica de redondeo al valor de la cuota
			nuQuotaValue := round(nuQuotaValue, nuRoundFactor);

			--Actualizar el valor de las cuotas en el diferido y asigna porcentaje 0 al diferido
			UPDATE	diferido
			SET 	difeinte = nuPorcentaje, difevacu = nuQuotaValue
			WHERE 	difecodi = nuDifecodi;
			
			nuIndex := tbDiferidos.NEXT(nuIndex);
			
			INSERT INTO REPOINCO(REINREPO, REINCODI, REINLON1, REINLON2, REINLON3, REINLON4, REINDES3, REINDES4, REINVAL1, REINVAL2)
			VALUES (nuReporte, nuConsecutivo, nuDifecodi, nuDifesusc, nuDifenuse, nuDifecupa, nuDifeinte, nuPorcentaje, nuDifevacu, nuQuotaValue);
			
			nuConsecutivo := nuConsecutivo + 1;
			
			COMMIT;
			
		EXCEPTION
			WHEN OTHERS THEN
				Errors.setError;
				Errors.getError(nuErrorCode, sbErrorMessage);
				ROLLBACK;
				INSERT INTO REPOINCO(REINREPO, REINCODI, REINLON1, REINLON2, REINLON3, REINLON4, REINDES3, REINDES4, REINVAL1, REINVAL2, REINOBSE)
				VALUES (nuReporte, nuConsecutivo, nuDifecodi, nuDifesusc, nuDifenuse, nuDifecupa, nuDifeinte, nuPorcentaje, nuDifevacu, nuQuotaValue, SUBSTR(sbErrorMessage, 0, 2000));
				nuConsecutivo := nuConsecutivo + 1;
				COMMIT;
		END;
	END LOOP;

	COMMIT;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR  THEN
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    WHEN OTHERS THEN
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/