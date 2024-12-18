CREATE OR REPLACE PACKAGE adm_person.ldc_pkgennotacomener
IS
    /*****************************************************************
    Unidad         : LDC_PKGENNOTACOMENER
    Descripcion    :
    Autor          : Miguel Angel Ballesteros Gomez
    Fecha          : 24/06/2020

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    26/06/2024  Adrianavg                   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
    ******************************************************************/
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
	-- tipo creado para la tabla pl de mercado relevante --
	TYPE rcMercado_relevante  IS record
    (
        nuCuentaCobro	  cuencobr.cucocodi%type,
		nuProducto		  cuencobr.cuconuse%type,
		nuFactura	      cuencobr.cucofact%type,
		nuCategoria		  cuencobr.cucocate%type,
		nusubcategoria    cuencobr.cucosuca%type,
		nuContrato	      factura.factsusc%type,
		nuPrioridad		  NUMBER,
		MERCADO			  NUMBER,
		ciclo         	  NUMBER,
		periodo_consumo   cargos.cargpeco%type
    );

    TYPE tytbMercado_relevante IS table of rcMercado_relevante index BY PLS_INTEGER;

    /*******************************************************************************
    Unidad     :   LDC_PRVALMERCRELEVCONTRATO
    Descripcion:   Procedimiento que realiza la consulta en la tabla LDC_CME_ORDENAMIENTO para obtener los
				   contratos ordenados por el campo prioridad validando el saldo del contrato
    *******************************************************************************/
    PROCEDURE LDC_PRVALMERCRELEVCONTRATO
    (
       inuPeriodo         IN   perifact.pefacodi%type
    );

	/*******************************************************************************
    Unidad     :   GETMERCADORELEVANTE
    Descripcion:   Obtiene tabla pl de toda la informacion del mercado relevante
    *******************************************************************************/
    PROCEDURE GETMERCADORELEVANTE
    (
       inuPeriodo		  		in   perifact.pefacodi%type,
	   otbMercado_Relevante     out  tytbMercado_relevante
    );
END LDC_PKGENNOTACOMENER;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGENNOTACOMENER
    IS
    /*****************************************************************
    Unidad         : LDC_PKGENNOTACOMENER
    Descripcion    :
    Autor          : Miguel Angel Ballesteros Gomez
    Fecha          : 24/06/2020

    Historia de Modificaciones
    Fecha       Autor                       Modificación
    =========   =========                   ====================
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************
    Unidad      :  PRINSERTCONTCOEN
    Descripcion :  Procedimiento Pragma que se encarga de realizar el insert en la tabla LDC_CONTCOEN

    Autor         : Miguel Ballesteros
    Fecha         : 25/06/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    ***************************************************************/
    PROCEDURE PRINSERTCONTCOEN
    (
       icuconuse		  		in   NUMBER,
       ifactsusc		  		in   NUMBER,
       inuPrioContrato		  	in   NUMBER,
       inuMercadoRelev		  	in   NUMBER,
       inuPeriodoFact		  	in   NUMBER,
       inuCicloFact		  		in   NUMBER,
       icucofact		  		in   NUMBER,
       inuCuentCobro   	 		in   NUMBER,
       inuValorNota		  		in   NUMBER,
       idtFechaRegistro	 		in   DATE,
       isbErrorGenerado	 		in   VARCHAR


    )
    IS
    PRAGMA AUTONOMOUS_TRANSACTION;
       CURSOR cugetExisteReg IS
	   SELECT 'X'
	   FROM LDC_CONTCOEN
	   WHERE COCEFACT = icucofact;

	   sbExiste VARCHAR2(4);
	BEGIN

	 OPEN cugetExisteReg;
	 FETCH cugetExisteReg INTO sbExiste;
	 IF cugetExisteReg%FOUND THEN
	    UPDATE LDC_CONTCOEN SET COCESESU = icuconuse,
							  COCECONT = ifactsusc,
							  COCEPRIO = inuPrioContrato,
							  COCEMECO = inuMercadoRelev,
							  COCEPERI = inuPeriodoFact,
							  COCECICL =inuCicloFact,
							  COCECUCO = inuCuentCobro,
							  COCEVALO = inuValorNota,
							  COCEFERE = idtFechaRegistro,
							  COCEERRO = isbErrorGenerado
	    WHERE COCEFACT = icucofact;
	 ELSE
	   INSERT INTO LDC_CONTCOEN (COCESESU,
							  COCECONT,
							  COCEPRIO,
							  COCEMECO,
							  COCEPERI,
							  COCECICL,
							  COCEFACT,
							  COCECUCO,
							  COCEVALO,
							  COCEFERE,
							  COCEERRO)
					  VALUES ( icuconuse,
							   ifactsusc,
							   inuPrioContrato,
							   inuMercadoRelev,
							   inuPeriodoFact,
							   inuCicloFact,
							   icucofact,
							   inuCuentCobro,
							   inuValorNota,
							   idtFechaRegistro,
							   isbErrorGenerado);
	 END IF;
	 CLOSE cugetExisteReg;


	COMMIT;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

	END PRINSERTCONTCOEN;

  /**************************************************************
    Unidad      :  GETMERCADORELEVANTE
    Descripcion :  Obtiene tabla pl de la informacion del mercado relevante de acuerdo al periodo de facturacion

    Parametros  :  inuPeriodo	    	  -- Numero del periodo de facturacion
                   otbMercado_Relevante   -- Tabla pl con informacion del mercado relevante

    Autor         : Miguel Ballesteros
    Fecha         : 25/06/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    ***************************************************************/
    PROCEDURE GETMERCADORELEVANTE
    (
       inuPeriodo		  		in   perifact.pefacodi%type,
	   otbMercado_Relevante     out  tytbMercado_relevante

    )
    IS
     CURSOR cuGetInfoMeRel IS
        select * from(
		SELECT
				 cu.cucocodi,
				 cu.cuconuse,
				 cu.cucofact,
				 cu.cucocate,
				 cu.cucosuca,
				 f.factsusc,
				 lc.prioridad,
				 ( select m.lomrmeco
				   from open.pr_product p, open.ab_address A, open.fa_locamere m
				   where p.product_id = cu.cuconuse
					 AND A.geograp_location_id = m.lomrloid
					 AND A.address_id = P.address_id ) MERCADO,
				 sr.sesucicl,
			    (select MAX(cargpeco) from open.cargos where cargcuco = cucocodi and cargprog = 5 and cargconc = 31) periodo_consumo
			FROM open.cuencobr cu,
				 open.factura f,
				 open.ldc_cme_ordenamiento lc,
				 open.servsusc sr
			WHERE  f.factpefa =  inuPeriodo
			  AND sr.sesunuse = cu.cuconuse
			  AND sr.sesuserv = 7014
			  AND f.factcodi = cu.cucofact
			  AND lc.id_contrato = f.factsusc
			  AND f.factprog = 6
			  AND NOT EXISTS (SELECT 1 FROM open.LDC_CONTCOEN WHERE COCEFACT = cu.cucofact ))
		    ORDER BY prioridad, mercado;

    BEGIN
        ut_trace.trace('Inicio Metodo LDC_PKGENNOTACOMENER.GETMERCADORELEVANTE',10);

		if(cuGetInfoMeRel%isopen)then
            close cuGetInfoMeRel;
        end if;

        open cuGetInfoMeRel;
        fetch cuGetInfoMeRel bulk collect into otbMercado_Relevante;
        close cuGetInfoMeRel;

        ut_trace.trace('Inicio Metodo LDC_PKGENNOTACOMENER.GETMERCADORELEVANTE',10);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GETMERCADORELEVANTE;

	  /**************************************************************
    Unidad      :  LDC_PRVALMERCRELEVCONTRATO
    Descripcion :  Procedimiento principal comparto mi energia

    Parametros  :  inuPeriodo	    	  -- Numero del periodo de facturacion

    Autor         : Miguel Ballesteros
    Fecha         : 25/06/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
	18/08/2020   LJLB                   CA 501 se adiciona nuevo concepto de subsidio adicional
    ***************************************************************/

    PROCEDURE LDC_PRVALMERCRELEVCONTRATO
    (
       inuPeriodo         IN   perifact.pefacodi%type
    )
    IS
		tbMerc_Relevante	   LDC_PKGENNOTACOMENER.tytbMercado_relevante; --Variable tipo tabla PL
		nuIndex                Pls_integer;--Index para recorrer la tabla
		nuValtotalAcum		   NUMBER;
		nuValorAplicado		   NUMBER;
		nuValNetoConsumo	   NUMBER;
		nuValorMercado		   NUMBER;
		nuVal				   NUMBER;
		nuCausalTarifa		   NUMBER := open.dald_parameter.fnugetnumeric_value('LDC_CAUSCARGTT', NULL);
		nuCodprograma		   NUMBER := open.dald_parameter.fnugetnumeric_value('LDC_PROGGECATT', NULL);
		nuConcepto			   NUMBER := open.dald_parameter.fnugetnumeric_value('LDC_CONCOMEN', NULL);
		nuCausalComer		   NUMBER := open.dald_parameter.fnugetnumeric_value('LDC_CUASCOMEN', NULL); --causal
		nuProgramaComer		   NUMBER := open.dald_parameter.fnugetnumeric_value('LDC_PROGGENCE', NULL); --programa
		sbObservacion		   VARCHAR2(100) := 'Nota generada por proceso comparto mi energia';
		isbSigno			   VARCHAR2(10)  := 'CR';
		NUMERCADORELEVANTEGL   NUMBER := 0;
		nuCiclo				   NUMBER;

		--INICIO CA 501
		 nuConcSubAdi   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONSUBADI', NULL);
		 nuConcSubAdiTT   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONSUBADITT', NULL);

		--FIN CA 501

		-- se obtiene el valor total acumulado por mercado relevante
		CURSOR cuGetTotalAcumulado(nuMercaProducto  fa_locamere.lomrmeco%type)is
			select nvl(sum(nvl(valor,0)),0)
			from LDC_CME_DONACIONES
			where ID_MERCADO = nuMercaProducto;

		-- se obtiene el valor aplicado por mercado relevante
		CURSOR cuGetValorAplicado(nuMercaProducto  fa_locamere.lomrmeco%type)is
			select NVL(sum(nvl(cocevalo, 0)),0)
			from ldc_contcoen
			where cocemeco = nuMercaProducto
			  and COCEERRO is null;

		-- se obtiene el valor neto del consumo del producto relacionado contrato seleccionado
		CURSOR cuGetValorNetConsuProd(cuconuse      pr_product.product_id%type,
									  nuCuentCobro	  cargos.cargcuco%type)is
			SELECT NVL(SUM(NVL(VALOR,0)),0)  VALOR, periodo
			   FROM (
			  SELECT  cargpeco periodo, sum(decode(cargsign,'CR', -cargvalo, cargvalo)) valor
			   FROM cargos
			   WHERE cargcuco = nuCuentCobro
				AND cargnuse = cuconuse
				AND cargconc in ( 31,196, nuConcSubAdi)
				AND cargcaca = 15
				AND cargprog = 5
				AND cargdoso NOT LIKE '%-PR%'
				group by cargpeco
			 UNION ALL
			SELECT  cargpeco, NVL(sum(decode(cargsign,'CR', -cargvalo, cargvalo)) ,0) valor
			   FROM cargos
			   WHERE cargcuco = nuCuentCobro
				AND cargnuse = cuconuse
				AND cargconc in ( 130,167, nuConcSubAdiTT)
				AND cargcaca = nuCausalTarifa
				AND cargprog = nuCodprograma
				group by cargpeco)
		    group by periodo;

     onuerror NUMBER;
		 osberror VARCHAR2(4000);
     sberrorMerca  VARCHAR2(4000);
	 sberroracum  VARCHAR2(4000);
     sbConfirma VARCHAR2(1) := 'S';

	  CURSOR cuGetInfoMeRel IS
        select * from(
		SELECT cu.cucocodi,
				 cu.cuconuse ,
				 cu.cucofact,
				 cu.cucocate,
				 cu.cucosuca,
				 f.factsusc,
				 lc.prioridad,
				 ( select m.lomrmeco
				   from open.pr_product p, open.ab_address A, open.fa_locamere m
				   where p.product_id = cu.cuconuse
					 AND A.geograp_location_id = m.lomrloid
					 AND A.address_id = P.address_id ) MERCADO,
				 sr.sesucicl	ciclo
			FROM open.cuencobr cu,
				 open.factura f,
				 open.ldc_cme_ordenamiento lc,
				 open.servsusc sr
			WHERE  f.factpefa =  inuPeriodo
			  AND sr.sesunuse = cu.cuconuse
			  AND sr.sesuserv = 7014
			  AND f.factcodi = cu.cucofact
			  AND lc.id_contrato = f.factsusc
			  AND f.factprog = 6
			  AND NOT EXISTS (SELECT 1 FROM open.LDC_CONTCOEN WHERE COCEFACT = cu.cucofact ))
		    ORDER BY prioridad, mercado;

		type tblContratos IS TABLE OF cuGetInfoMeRel%ROWTYPE;
		vtblContratos tblContratos;
		nuPerioConsu number;
		sbprograma    VARCHAR2(400)  := 'CUSTOMER';

    BEGIN

		ut_trace.trace('Inicio Metodo LDC_PKGENNOTACOMENER.LDC_PRVALMERCRELEVCONTRATO',10);

		--tbMerc_Relevante.delete;
		-- se obtiene la informacion del mercado relevante
		--LDC_PKGENNOTACOMENER.GETMERCADORELEVANTE(inuPeriodo, tbMerc_Relevante);
		--Se inicializa el index en la primera posicion de la tabla pl cargada con la informacion del mercado relevante
		--setear programa
        pkErrors.SetApplication(sbprograma);

		OPEN cuGetInfoMeRel;
		LOOP
		   FETCH cuGetInfoMeRel BULK COLLECT INTO  vtblContratos LIMIT 100;
		      FOR nuIndex IN 1..vtblContratos.COUNT LOOP
				   nuVal := 0;
				   onuerror := 0;
				   osberror := null;
				   nuValorMercado := 0;
				   sberroracum := null;
					   -- DBMS_OUTPUT.PUT_LINE('ahacer '||NUMERCADORELEVANTEGL);
				  -- se valida que el mercado relevante procesado sea diferente al que ya se proceso
				   if(NUMERCADORELEVANTEGL != vtblContratos(nuIndex).MERCADO)then
						sberrorMerca := NULL;
						nuValorAplicado := 0;
						nuValtotalAcum := 0;


						-- se asigna el valor del mercado a la variable global
						NUMERCADORELEVANTEGL := vtblContratos(nuIndex).MERCADO;
					 -- DBMS_OUTPUT.PUT_LINE('ingreso '||NUMERCADORELEVANTEGL);
						if(cuGetTotalAcumulado%isopen)then
						  close cuGetTotalAcumulado;
						end if;

						open cuGetTotalAcumulado(vtblContratos(nuIndex).MERCADO);
						fetch cuGetTotalAcumulado into nuValtotalAcum;
						close cuGetTotalAcumulado;


					  --   DBMS_OUTPUT.PUT_LINE('nuValtotalAcum '||nuValtotalAcum);
						IF nuValtotalAcum <= 0 THEN
      						sberrorMerca := 'El valor total acumulado del mercado ['||NUMERCADORELEVANTEGL||'] es menor o igual 0';
						END IF;
					 END IF;

					 if sberrorMerca is not null then
					    PRINSERTCONTCOEN(vtblContratos(nuIndex).cuconuse,
                              vtblContratos(nuIndex).factsusc,
                              vtblContratos(nuIndex).prioridad,
                            	 vtblContratos(nuIndex).MERCADO,
                               inuperiodo,
                               vtblContratos(nuIndex).CICLO,
                               vtblContratos(nuIndex).cucofact,
                               vtblContratos(nuIndex).cucocodi,
                               nuValNetoConsumo,
                               SYSDATE,
                               sberrorMerca);
					 ELSE
						 if(cuGetValorAplicado%isopen)then
						  close cuGetValorAplicado;
						end if;

						open cuGetValorAplicado(vtblContratos(nuIndex).MERCADO);
						fetch cuGetValorAplicado into nuValorAplicado;
						close cuGetValorAplicado;

						  -- se realiza el proceso para conocer el saldo del mercado
						nuValorMercado := nuValtotalAcum - nuValorAplicado;
					  --  DBMS_OUTPUT.PUT_LINE('nuValorMercado '||nuValorMercado||' nuValorAplicado'||nuValorAplicado);
						IF nuValorMercado <= 0 THEN
						   sberroracum := 'Mercado relevante ['||NUMERCADORELEVANTEGL||'] no tiene saldo para el proceso.';
						END IF;

					END IF;

					IF sberroracum IS NOT NULL THEN

						   ut_trace.trace('El valor total acumulado es menor a 0',10);
						   PRINSERTCONTCOEN(vtblContratos(nuIndex).cuconuse,
                              vtblContratos(nuIndex).factsusc,
                              vtblContratos(nuIndex).prioridad,
                            	 vtblContratos(nuIndex).MERCADO,
                               inuperiodo,
                               vtblContratos(nuIndex).CICLO,
                               vtblContratos(nuIndex).cucofact,
                               vtblContratos(nuIndex).cucocodi,
                               0,
                               SYSDATE,
                               sberroracum);
					  ELSE
						  if(cuGetValorNetConsuProd%isopen)then
							close cuGetValorNetConsuProd;
						  end if;

						  open cuGetValorNetConsuProd(vtblContratos(nuIndex).cuconuse, vtblContratos(nuIndex).cucocodi);
						  fetch cuGetValorNetConsuProd into nuValNetoConsumo, nuPerioConsu;
						  close cuGetValorNetConsuProd;

						 if (nuValNetoConsumo <= 0) then
							  PRINSERTCONTCOEN( vtblContratos(nuIndex).cuconuse,
                                  vtblContratos(nuIndex).factsusc,
                                  vtblContratos(nuIndex).prioridad,
                                  vtblContratos(nuIndex).MERCADO,
                                  inuperiodo,
                                  vtblContratos(nuIndex).CICLO,
                                  vtblContratos(nuIndex).cucofact,
                                  vtblContratos(nuIndex).cucocodi,
                                  nuValNetoConsumo,
                                  SYSDATE,
                                  'Contrato no tiene consumo para el periodo');
							sbConfirma := 'N';
						 ELSE
						   IF nuValorMercado > 0 THEN

							   nuVal := nuValorMercado - nuValNetoConsumo;
							  -- se valida si la resta es mayor a 0
							  IF nuVal < 0 THEN
                                 nuValNetoConsumo := nuValorMercado;
                              END IF;

							  -- si es mayor a 0 se creará la nota al contrato y un cargo llamando al paquete para la creacion de notas
							  LDC_PKGESTIONTARITRAN.proGeneraNotaUsuario(  vtblContratos(nuIndex).factsusc,
														   vtblContratos(nuIndex).cuconuse,
														   vtblContratos(nuIndex).cucocodi,
														   vtblContratos(nuIndex).cucofact,
														   null,   --inuUnidafact, ----------------------***********
														   inuperiodo,
														   nuPerioConsu, --vtblContratos(nuIndex).periodo_consumo,
														   null,   --nuTariconc,
														   nuConcepto,
														   isbSigno,
														   nuValNetoConsumo,  ---ValorNota
														   sbObservacion,
														   nuCausalComer,
														   nuProgramaComer,
														   1, 					--inufila
														   1, 					--inuFilaMax
														   onuerror,
														   osberror);

								if(onuerror != 0)then
									PRINSERTCONTCOEN( vtblContratos(nuIndex).cuconuse,
									  vtblContratos(nuIndex).factsusc,
									  vtblContratos(nuIndex).prioridad,
									  vtblContratos(nuIndex).MERCADO,
									  inuperiodo,
									  vtblContratos(nuIndex).CICLO,
									  vtblContratos(nuIndex).cucofact,
									  vtblContratos(nuIndex).cucocodi,
									  nuValNetoConsumo,
									  SYSDATE,
									  onuerror||' - '||osberror);
									sbConfirma := 'N';
						       else
									PRINSERTCONTCOEN(vtblContratos(nuIndex).cuconuse,
									 vtblContratos(nuIndex).factsusc,
									 vtblContratos(nuIndex).prioridad,
									 vtblContratos(nuIndex).MERCADO,
									 inuperiodo,
									 vtblContratos(nuIndex).CICLO,
									 vtblContratos(nuIndex).cucofact,
									 vtblContratos(nuIndex).cucocodi,
									 nuValNetoConsumo,
									 SYSDATE,
									 NULL);
									sbConfirma := 'S';
								END IF;

						else
							ut_trace.trace('El valor restante entre el saldo del mercado y el valor neto es menor a 0',10);
							PRINSERTCONTCOEN(vtblContratos(nuIndex).cuconuse,
                                vtblContratos(nuIndex).factsusc,
                                vtblContratos(nuIndex).prioridad,
                                vtblContratos(nuIndex).MERCADO,
                                inuperiodo,
                                vtblContratos(nuIndex).CICLO,
                                vtblContratos(nuIndex).cucofact,
                                vtblContratos(nuIndex).cucocodi,
                                nuValNetoConsumo,
                                SYSDATE,
									   'El valor restante entre el saldo['||nuValorMercado||'] del mercado relevante ['||vtblContratos(nuIndex).MERCADO||'] y el valor del consumo ['||nuValNetoConsumo||'] es menor a 0');
						  sbConfirma := 'N';
					   end if;  -- fin validacion nuVal > 0
					 end if;  -- fin validacion nuVal > 0
					end if;  -- fin validacion nuVal > 0

					IF  sbConfirma = 'S' THEN
					   COMMIT;
					ELSE
					  ROLLBACK;
					END IF;
			  END LOOP;


       exit when cuGetInfoMeRel%notfound;
	    END LOOP;
		CLOSE cuGetInfoMeRel;



      ut_trace.trace('Finaliza Metodo LDC_PKGENNOTACOMENER.LDC_PRVALMERCRELEVCONTRATO',10);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END LDC_PRVALMERCRELEVCONTRATO;

END LDC_PKGENNOTACOMENER;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGENNOTACOMENER
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGENNOTACOMENER', 'ADM_PERSON'); 
END;
/
