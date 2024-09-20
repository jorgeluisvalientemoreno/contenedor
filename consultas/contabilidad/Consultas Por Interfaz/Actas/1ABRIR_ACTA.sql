DECLARE 

	CURSOR CUACTAS IS
	SELECT *
	FROM GE_ACTA
	WHERE ID_ACTA IN (45397 );

	cursor cuContratos(nuContrato number) is
  select *
	from ge_contrato
	where id_contrato=nuContrato;


	rwContrato cuContratos%rowtype;
	nuActualizaEstado	number:=0;
	nuActualizaValLiq	number:=0;
	nuActualizaAntAmo	number:=0;
	nuActualizaFonGara	number:=0;
	VALOR_ANTIPO_ACTA	NUMBER:=0;
	VALOR_FONDO		    NUMBER:=0;

	nuNuevoValorliquidado	NUMBER;
	nuNuevoValorAmortizado	NUMBER;
	nuNuevoFondoGaran	NUMBER;
	nuNuevoVAlorTotal	NUMBER;


BEGIN

  For reg in cuActas loop

	--IF REG.EXTERN_INVOICE_NUM IS NULL THEN

		update ge_acta
		   set estado = 'A',
			     fecha_cierre=null,
			     EXTERN_INVOICE_NUM=NULL,
			     EXTERN_PAY_DATE=NULL
		WHERE  id_acta=reg.id_acta;


		INSERT INTO CT_PROCESS_LOG(PROCESS_LOG_ID,LOG_DATE,CONTRACT_ID, PERIOD_ID,BREAK_DATE, ERROR_CODE,  ERROR_MESSAGE)
		  VALUES
			(SEQ_CT_PROCESS_LOG_109639.NEXTVAL,
			 SYSDATE,
			 REG.ID_CONTRATO,
			 NULL,
			 NULL,
			 2701,
			 'SE MODIFICA EL ACTA ' || REG.ID_ACTA ||
			 ' SEGUN CA 100-35106 PARA ABRIRLA. VALOR_TOTAL_ANT=' ||
			 REG.VALOR_TOTAL || ' VALOR LIQUIDADO_ANT: ' || REG.VALOR_LIQUIDADO||
			 'FECHA CIERRE ANT: '||REG.FECHA_CIERRE
			 );


		open cuContratos(reg.id_contrato);
		fetch cuContratos into rwContrato;
		close cuContratos;

		IF rwContrato.STATUS='CE' then
			nuActualizaEstado := 1;
		else
			nuActualizaEstado := 0;
		end if;

		IF rwContrato.VALOR_LIQUIDADO IS NOT NULL THEN
			nuActualizaValLiq:=1;
			nuNuevoValorliquidado:=rwContrato.VALOR_LIQUIDADO-NVL(REG.VALOR_LIQUIDADO,0);
		else
			nuActualizaValLiq:=0;
			nuNuevoValorliquidado:=null;
		END IF;


		IF rwContrato.anticipo_amortizado is not null then
			nuActualizaAntAmo:=1;
			BEGIN
				SELECT NVL(SUM(VALOR_TOTAL),0)
			    INTO VALOR_ANTIPO_ACTA
			    FROM OPEN.GE_DETALLE_ACTA
			   WHERE ID_ACTA=REG.ID_ACTA
					 AND ID_ITEMS=102006;

			EXCEPTION
				WHEN OTHERS THEN
					VALOR_ANTIPO_ACTA :=0;
			END;

			nuNuevoValorAmortizado:=rwContrato.anticipo_amortizado + VALOR_ANTIPO_ACTA;

		else
			nuActualizaAntAmo:=0;
			nuNuevoValorAmortizado:=null;
		end if;

		if rwContrato.acumul_fondo_garant is not null then
			nuActualizaFonGara:=1;
			BEGIN
				SELECT NVL(SUM(VALOR_TOTAL),0)
				  INTO VALOR_FONDO
				  FROM OPEN.GE_DETALLE_ACTA
				  WHERE ID_ACTA=REG.ID_ACTA
					AND ID_ITEMS=102007;
			EXCEPTION
				WHEN OTHERS THEN
					VALOR_FONDO :=0;
			END;


			nuNuevoFondoGaran:=rwContrato.ACUMUL_FONDO_GARANT+VALOR_FONDO;

		else

			nuActualizaFonGara:=0;
			nuNuevoFondoGaran:=null;
		end if;

		nuNuevoVAlorTotal:=rwContrato.VALOR_TOTAL_PAGADO-NVL(REG.VALOR_LIQUIDADO,REG.VALOR_TOTAL);

		UPDATE GE_CONTRATO
		   SET STATUS=DECODE(nuActualizaEstado,1,'AB',STATUS),
			     FECHA_CIERRE=DECODE(nuActualizaEstado,1,NULL,FECHA_CIERRE),
			     VALOR_LIQUIDADO=DECODE(nuActualizaValLiq,1,nuNuevoValorliquidado,VALOR_LIQUIDADO),
			     ANTICIPO_AMORTIZADO=DECODE(nuActualizaAntAmo,1,nuNuevoValorAmortizado,ANTICIPO_AMORTIZADO),
			     ACUMUL_FONDO_GARANT=DECODE(nuActualizaFonGara,1,nuNuevoFondoGaran,ACUMUL_FONDO_GARANT),
			     VALOR_TOTAL_PAGADO=nuNuevoVAlorTotal
		WHERE ID_CONTRATO=REG.ID_CONTRATO;


		INSERT INTO CT_PROCESS_LOG(PROCESS_LOG_ID,LOG_DATE,CONTRACT_ID, PERIOD_ID,BREAK_DATE, ERROR_CODE,  ERROR_MESSAGE)
		  VALUES
              (SEQ_CT_PROCESS_LOG_109639.NEXTVAL,
               SYSDATE,
               REG.ID_CONTRATO,
               NULL,
               NULL,
               2701,
               'SE MODIFICA EL ACTA ' || REG.ID_ACTA ||
               ' SEGUN CA 100-35106 PARA ABRIRLA. ESTADO_ANT_CONTRATO=' ||rwContrato.status||
               ' FECHA_CIERRE_ANT: ' || rwContrato.FECHA_CIERRE||
               ' VALOR_TOTAL_PAGADO ANT: '||rwContrato.VALOR_TOTAL_PAGADO||
               ' VALOR_LIQUIDADO ANT: '||rwContrato.VALOR_LIQUIDADO||
               ' ANTICIPO_AMORTIZADO ANT: '||rwContrato.ANTICIPO_AMORTIZADO||
               ' ACUMUL_FONDO_GARANT ANT: '||rwContrato.ACUMUL_FONDO_GARANT||
               DECODE(nuActualizaEstado,1,' ESTADO_NUE_CONTRATO= AB','')||
               DECODE(nuActualizaEstado,1,' FECHA_CIERRE_NUE= NULL','') ||
               ' VALOR_TOTAL_PAGADO NUE: '||nuNuevoVAlorTotal||
               DECODE(nuActualizaValLiq,1,' VALOR_LIQUIDADO NUE: '||nuNuevoValorliquidado,'')||
               DECODE(nuActualizaAntAmo,1,' ANTICIPO_AMORTIZADO NUE: '||nuNuevoValorAmortizado,'')||
               DECODE(nuActualizaFonGara,1,' ACUMUL_FONDO_GARANT NUE: '||nuNuevoFondoGaran)
               );


	--ELSE
	--END IF;

  end loop;

  --COMMIT;

END;







/   
