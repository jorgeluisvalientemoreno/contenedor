CREATE OR REPLACE PROCEDURE LDC_LLENASUBSIDIOCIERRE(
    nuano NUMBER,
    numes NUMBER,
    nuerror OUT NUMBER,
    sbmensa OUT VARCHAR2)
IS
  /**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-03-04
  Descripcion : Generamos informaci��n reporte subsidio a cierre
  Parametros Entrada
  nuano A��o
  numes Mes
  Valor de salida
  sbmen  mensaje
  error  codigo del error
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR   DESCRIPCION
  27/07/2020   LJLB    CA 459 se adiciona logica para incluir tarifa
                       transitoria  RES 048
  23/03/2021   horbath CASO 648. Se modifica para llevar el reporte de subsidios y contribuciones
                       por departamento
  ***************************************************************************/
TYPE t_bi_subsidio
IS
  TABLE OF ldc_osf_subsidio%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE t_indice
IS
  TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
TYPE array_subsidio
IS
  RECORD
  (
    fact factura.factcodi%TYPE ,
    pefa perifact.pefacodi%TYPE ,
    cate cuencobr.cucocate%TYPE ,
    suca cuencobr.cucosuca%TYPE ,
    nuse cuencobr.cuconuse%TYPE ,
    cuco cuencobr.cucocodi%TYPE ,
    vlsc cargos.cargvalo%TYPE ,
    peco cargos.cargpeco%TYPE ,
    taco cargos.cargtaco%TYPE ,
    doso cargos.cargdoso%TYPE );
TYPE t_array_subsidio
IS
  TABLE OF array_subsidio;
  v_array_subsidio t_array_subsidio;
  table_bi_subsidio t_bi_subsidio;
  table_indice t_indice;


-- caso 648
  TYPE t_bi_subsidio_dep
IS
  TABLE OF ldc_osf_subsidio_dep%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE t_indice_dep
IS
  TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
TYPE array_subsidio_dep
IS
  RECORD
  (
    fact factura.factcodi%TYPE ,
    pefa perifact.pefacodi%TYPE ,
    cate cuencobr.cucocate%TYPE ,
    suca cuencobr.cucosuca%TYPE ,
    nuse cuencobr.cuconuse%TYPE ,
    cuco cuencobr.cucocodi%TYPE ,
    vlsc cargos.cargvalo%TYPE ,
    peco cargos.cargpeco%TYPE ,
    taco cargos.cargtaco%TYPE ,
    doso cargos.cargdoso%TYPE );
TYPE t_array_subsidio_dep
IS
  TABLE OF array_subsidio_dep;
  v_array_subsidio_dep t_array_subsidio_dep;
  table_bi_subsidio_dep t_bi_subsidio_dep;
  table_indice_dep t_indice_dep;

  nucodprogfgcc ld_parameter.numeric_value%TYPE;
  nucodprogfgca ld_parameter.numeric_value%TYPE;
  nucodprogmigr ld_parameter.numeric_value%TYPE;
  nucontareg    NUMBER(15) DEFAULT 0;
  limit_in      NUMBER(15) DEFAULT 0;
  nucantiregcom NUMBER(15) DEFAULT 0;
  nucantiregtot NUMBER(15) DEFAULT 0;
  nucuentacob cuencobr.cucocodi%TYPE;
  nufactura factura.factcodi%TYPE;
  nuarserv ldc_osf_subsidio.areasev%TYPE;
  sbindice VARCHAR2(2000);
  sbindiceDEP VARCHAR2(2000);
  nutaco ta_vigetaco.vitctaco%TYPE;
  nucodtarev ta_vigetaco.vitccons%TYPE;
  nurango    NUMBER(2);
  nudiasfact NUMBER(2) DEFAULT 30;
  nuunliq rangliqu.raliunli%TYPE;
  nuvalotarvar rangliqu.ralivalo%TYPE;
  nuconsu$ rangliqu.ralivaul%TYPE DEFAULT 0;
  nucantusco ldc_osf_subsidio.causmt3%TYPE DEFAULT 0;
  nutarsub ta_rangvitc.ravtvalo%TYPE;
  vporc ldc_osf_subsidio.porsubs%TYPE;
  numerca fa_mercrele.merecodi%TYPE;
  nuvalorsub cargos.cargvalo%TYPE;
  nurefarrind   NUMBER(6);
  nucontaindice NUMBER(6);
  nuposicap     NUMBER(6);

  nurefarrindDEP   NUMBER(6);
  nucontaindiceDEP NUMBER(6);
  nuposicapDEP     NUMBER(6);


  sw            NUMBER(1) DEFAULT 0;
  nucusacargmasiv ld_parameter.numeric_value%TYPE;
  sberrorprog  VARCHAR2(2000);
  sberrorpaso  VARCHAR2(2000);
  nulineaerror NUMBER(3) DEFAULT 0;
  nuuserror cuencobr.cuconuse%TYPE;
  nudepa ge_geogra_location.geo_loca_father_id%TYPE;
  nuloca ge_geogra_location.geograp_location_id%TYPE;
  nutarcosu ta_rangvitc.ravtvalo%TYPE;
  swconsu  NUMBER(1) DEFAULT 0;
  dttcfein DATE;
  dttcfefi DATE;
  nuconsec NUMBER;
  nuconcconsu cargos.cargconc%TYPE;
  sbdoso cargos.cargdoso%TYPE;
  dtfein  DATE;
  dtfefi  DATE;
  nupaano NUMBER(4);
  nupames NUMBER(2);
  nuperi  NUMBER(6);
  sbobservacion ldc_osf_subsidio.observacion%TYPE;
  nucate cuencobr.cucocate%TYPE;
  nusuca cuencobr.cucosuca%TYPE;
  nupeco cargos.cargpeco%TYPE;
  nupefa perifact.pefacodi%TYPE;
  sbbdoso cargos.cargdoso%TYPE;
  -- Cursor facturas
  CURSOR cufacturas
  IS
    SELECT
      factcodi ,
      pefacodi ,
      cucocate ,
      cucosuca ,
      cuconuse ,
      cucocodi ,
      valorsc ,
      cargpeco ,
      cargtaco ,
      doso
    FROM
      open.ldc_vista_subsid_contrib;
  -- Cursor consumos por rango liquidado
  CURSOR cu_rangliqu (nuse NUMBER,nupeco NUMBER,nupefa NUMBER,nuconcepto NUMBER
    )
  IS
    SELECT
      r.raliidre,
      r.raliunli,
      r.ralivaul
    FROM
      open.rangliqu r
    WHERE
      r.ralisesu   = nuse
    AND r.ralipeco = nupeco
    AND r.ralipefa = nupefa
    AND r.raliconc = nuconcepto
	and raliunli > 0;
  -- Cursor tarifas
  CURSOR cu_tarifas(nuconsetar NUMBER)
  IS
    SELECT
      tv.ravtliin ini,
      tv.ravtvalo valor
    FROM
      open.ta_rangvitc tv
    WHERE
      tv.ravtvitc = nuconsetar
    ORDER BY
      tv.ravtliin;
  -- Cursor cargo consumos
  CURSOR c_cargos (nuse NUMBER,ncuco NUMBER,nupefa NUMBER,nupeco NUMBER)
  IS
    SELECT
      /*+ RULE */
      NVL(SUM(DECODE(cargsign,'CR',-1*NVL(cargunid,0),'DB',NVL(cargunid,0))),0)
      unid ,
      NVL(ROUND(SUM(DECODE(cargsign,'CR',-1*NVL(cargvalo,0),'DB',NVL(cargvalo,0
      ))),2),0) valo
    FROM
      open.cargos
    WHERE
      cargnuse               = nuse
    AND cargcuco             = ncuco
    AND cargpefa             = nupefa
    AND cargpeco             = nupeco
    AND cargprog            IN(nucodprogfgca,nucodprogfgcc,nucodprogmigr)
    AND cargconc             = dald_parameter.fnuGetNumeric_Value('COD_CONCEPTO_CONSUMO')
    AND cargcaca            <> dald_parameter.fnuGetNumeric_Value('CAUSAL_AJUSTE_CONSUMO')
    AND cargcaca             = nucusacargmasiv
    AND SUBSTR(cargdoso,1,2) = 'CO';
  -- Cursor otros cargos subsidio no facturas
  CURSOR cuotroscargos
  IS
    SELECT
      *
    FROM
      ldc_view_otras_not_sub_con;
  --INICIO CA 459
  nuConcSub NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONSUBTRAS', NULL
  ); -- se almacena concepto de subsisdio transitorio
  nuConceConTra NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONCTATT',
  NULL); --se almacena concepto de consumo tarifa transitoria
  sbAplicaca459 VARCHAR2(1);
  --se consulta informacion de tarifa transitoria
  CURSOR cuGetConcepTran(nuse NUMBER,nfactura NUMBER,nupeco  NUMBER,nupefa NUMBER, inuconcepto NUMBER)
  IS
    SELECT
      dptttatt valor,
      to_number(SUBSTR(dpttrang, 1,2)) ini
    FROM
      OPEN.ldc_deprtatt
    WHERE
      dpttfact   = nfactura
    AND DPTTSESU = nuse
    AND dpttperi = nupefa
    AND dpttpeco = nupeco
    AND dpttconc = inuconcepto;
  CURSOR cuGetConsuTranTotal(nuse NUMBER,nfactura NUMBER,nupeco  NUMBER,nupefa NUMBER, inuconcepto NUMBER)
  IS
    SELECT
      NVL(SUM(DECODE(DPTTSIGN, 'CR', -NVL(dpttvano,0),NVL(dpttvano,0) )),0)
    FROM
      OPEN.ldc_deprtatt
    WHERE
      dpttfact           = nfactura
    AND DPTTSESU         = nuse
    AND dpttperi         = nupefa
    AND dpttpeco         = nupeco
    AND dpttconc         = inuconcepto;
  nuConsuTranTot NUMBER := 0;
  nuSubTranTot number := 0;

  --FIN CA 459
BEGIN
  nuerror       := 0;
  sbmensa       := NULL;
  nucantiregcom := 0;
  nucantiregtot := 0;
  nucantusco    := 0;
  nucontaindice := 0;
  nupaano       := nuano;
  nupames       := numes;
  -- Obtenemos fecha inicial y final del periodo contable
  ldc_cier_prorecupaperiodocont(nuano,numes,dtfein,dtfefi,sbmensa,nuerror);
  -- Codigo programa fgcc
  nucodprogfgcc := dald_parameter.fnuGetNumeric_Value('COD_FACTPROG');
  -- Codigo programa fgca
  nucodprogfgca := dald_parameter.fnuGetNumeric_Value('COD_PROG_FGCA');
  -- Codigo programa migraci��n
  nucodprogmigr := dald_parameter.fnuGetNumeric_Value('COD_PROG_MIGR');
  -- Causa generacion cargos masivos
  nucusacargmasiv := dald_parameter.fnuGetNumeric_Value('CAUSA_CARGOS_MASIVOS')
  ;
  -- Obtenemos el concepto de consumo
  nuconcconsu := dald_parameter.fnuGetNumeric_Value('COD_CONCEPTO_CONSUMO');
  -- Borramos datos de la tabla para el a��o y mes
  DELETE
    ldc_osf_subsidio h
  WHERE
    h.anofact   = nuano
  AND h.mesfact = numes;

  -- caso 648
  DELETE
    ldc_osf_subsidio_dep x
  WHERE
    x.anofact   = nuano
  AND x.mesfact = numes;

  COMMIT;
  -- Borramos los datos de la tabla de errores para el a��o y mes
  DELETE
    ldc_osf_errproc y
  WHERE
    y.ano             = nuano
  AND y.mes           = numes
  AND trim(y.proceso) = 'LDC_LLENASUBSIDIOCIERRE';
  COMMIT;
  nucontareg   := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
  limit_in     := nucontareg;
  nulineaerror := 0;
  -- Variables para la vista
  ldc_pk_parametros_vistas.dtfein     := dtfein;
  ldc_pk_parametros_vistas.dtfefi     := dtfefi;
  ldc_pk_parametros_vistas.sbprograma := 'SUBSIDIO';
  ldc_pk_parametros_vistas.nuclascont := dald_parameter.fnuGetNumeric_Value(
  'CLASIFICADOR_SUBSIDIO');
  IF FBLAPLICAENTREGAXCASO('0000459') THEN
    sbAplicaca459 := 'S';
  END IF;
  -- Recorremos las facturas
  OPEN cufacturas;
  LOOP
      FETCH
      cufacturas BULK COLLECT
      INTO
      v_array_subsidio LIMIT limit_in;
      FOR f IN 1..v_array_subsidio.count
          LOOP
              nuerror        := 1;
              nufactura      := v_array_subsidio(f).fact;
              nucuentacob    := v_array_subsidio(f).cuco;
              nuuserror      := v_array_subsidio(f).nuse;
              nuvalorsub     := NVL(v_array_subsidio(f).vlsc,0);
              sbbdoso        := v_array_subsidio(f).doso;
              sbdoso         := SUBSTR(sbbdoso,1,5);
              nucantusco     := 1;
              nutaco         := v_array_subsidio(f).taco;
              nucate         := v_array_subsidio(f).cate;
              nusuca         := v_array_subsidio(f).suca;
              nupeco         := v_array_subsidio(f).peco;
              nupefa         := v_array_subsidio(f).pefa;
              nuConsuTranTot := 0;
	          nuSubTranTot    := 0;
              IF trim(sbdoso) = 'SU-PR' THEN
                 nuperi       := to_number(TO_CHAR(to_date('1/'||SUBSTR(sbbdoso,11)||'/'
                 ||SUBSTR(sbbdoso,7,4),'dd/mm/yyyy'),'YYYYMM'));
                 sbobservacion   := 'PROCESO DE RECUPERACION.';
              ELSIF trim(sbdoso) = 'SU-20' THEN
                 sbobservacion   := 'LIQUIDACION NORMAL.';
                 nuperi          := to_number(TO_CHAR(to_date('1/'||SUBSTR(sbbdoso,8)||
                 '/'||SUBSTR(sbbdoso,4,4),'dd/mm/yyyy'),'YYYYMM'));
              ELSE
                 nuperi        := -1;
                 sbobservacion := 'DESCUENTOS SUBSIDIO.';
              END IF;
              -- Obtenemos la localidad del producto al cierre
              sberrorprog := '00';
              sberrorpaso := NULL;
              BEGIN
                   SELECT di.geograp_location_id ,
                          (
                           SELECT de.geo_loca_father_id
                                 FROM ge_geogra_location de
                                 WHERE de.geograp_location_id = di.geograp_location_id
                           )
                           INTO nuloca, nudepa
                           FROM open.pr_product pr, ab_address di
                           WHERE pr.product_id   = nuuserror
                                 AND pr.address_id = di.address_id;
              EXCEPTION
                       WHEN OTHERS THEN
                            nudepa       := -1;
                            nuloca       := -1;
                            nulineaerror := 151;
                            sberrorprog  := '-1'||'-'||SQLERRM;
              END;
              -- Retornamos area de servicio
              nuarserv                  := ldc_retornaareaservicio(nudepa,nuloca,nucate);
              nuerror                   := 2;
              IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                 sberrorpaso             := 'Linea error : '||nulineaerror||
                 ' PRODUCTO : '||nuuserror||' CTA : '||nucuentacob||
                 ' ERROR AL OBTENER LA LOCALIDAD DEL PRODUCTO '||sberrorprog;
                 ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENASUBSIDIOCIERRE'),
                 nuuserror,sberrorpaso,nuvalorsub);
              ELSE
                 -- Facturacion por cargo de consumo y las unidades liquidadas
                 nuunliq         := 0;
                 nuconsu$        := 0;
                 sberrorprog     := '00';
                 sberrorpaso     := NULL;
                 swconsu         := 0;
                 IF nuvalorsub*-1 > 0 THEN
                    --INICIA CA 459
                    IF sbAplicaca459   = 'S' THEN
                       IF trim(sbdoso) != 'SU-PR' THEN
					      IF cuGetConsuTranTotal%ISOPEN THEN
			                 CLOSE cuGetConsuTranTotal;
			              END IF;
                          OPEN cuGetConsuTranTotal(nuuserror,nufactura, nupeco,nupefa, nuConceConTra);
                          FETCH cuGetConsuTranTotal  INTO  nuConsuTranTot;
                          CLOSE cuGetConsuTranTotal;
         			      --se obtiene valor del subsidio
			              OPEN cuGetConsuTranTotal(nuuserror,nufactura, nupeco,nupefa, nuConcSub);
			              FETCH cuGetConsuTranTotal INTO  nuSubTranTot;
			              CLOSE cuGetConsuTranTotal;
                       END IF;
                    END IF;
                    --TERMINA CA 459
                    FOR liq IN cu_rangliqu(nuuserror,nupeco,nupefa,nuconcconsu) LOOP
                        IF trim(sbdoso) = 'SU-PR' THEN
                           NULL;
                        ELSIF trim(sbdoso) = 'SU-20' THEN
                           nuunliq         := nuunliq  + liq.raliunli;
                           nuconsu$        := nuconsu$ + liq.ralivaul;
                           nucodtarev      := liq.raliidre;
                           swconsu         := 1;
                        END IF;
                    END LOOP;
		            --CA 459 se toma valor de cargos y unidades
		            IF trim(sbdoso) = 'SU-20' THEN
				       OPEN c_cargos(nuuserror,nucuentacob,nupefa,nupeco);
				       FETCH c_cargos INTO nuunliq,nuconsu$;
				       IF c_cargos%NOTFOUND THEN
				          nuunliq      := 0;
				          nuconsu$     := 0;
				          sberrorprog  := '-1'||'-'||SQLERRM;
				          nulineaerror := 205;
				       END IF;
				       CLOSE c_cargos;
		            END IF;
                 END IF;
                 nuerror   := 7;
                 nuconsec  := nucodtarev;
                 IF swconsu = 0 THEN
                    -- Facturacion por cargo de consumo y las unidades liquidadas consumo
                    -- promedio
                    IF nuvalorsub*-1 > 0 THEN
                       OPEN c_cargos(nuuserror,nucuentacob,nupefa,nupeco);
                       FETCH c_cargos INTO nuunliq, nuconsu$;
                       IF c_cargos%NOTFOUND THEN
                          nuunliq      := 0;
                          nuconsu$     := 0;
                          sberrorprog  := '-1'||'-'||SQLERRM;
                          nulineaerror := 205;
                       END IF;
                       CLOSE c_cargos;
                    END IF;
                    nucodtarev := -1;
                 END IF;
                 nuerror := 8;
                 -- Obtenemos la tarifa de consumo subsidiada y plena
                 sberrorprog := '00';
                 sberrorpaso := NULL;
                 swconsu     := 0;
                 --se descuenta valor del consumo
                 nuconsu$       := nuconsu$ + nuConsuTranTot;
		         nuvalorsub      :=  nuvalorsub + nuSubTranTot;
                 IF nucodtarev   =          -1 THEN
                    nutarcosu    := 0;
                    nuvalotarvar := 0;
                    swconsu      := 1;
                 ELSE
                    --INICIA CA 459
                    IF sbAplicaca459 = 'S' THEN
                       FOR regTAR IN cuGetConcepTran(nuuserror,nufactura, nupeco,nupefa, nuConceConTra) LOOP
                           IF regTAR.ini = 0 THEN
                              nutarcosu  := regTAR.valor;
                           ELSE
                              nuvalotarvar := regTAR.valor;
                           END IF;
                           swconsu := 1;
                       END LOOP;
                    END IF;
                    --TERNMINA CA 459
                    IF swconsu = 0 THEN
                       FOR tar IN cu_tarifas(nucodtarev) LOOP
                           IF tar.ini   = 0 THEN
                              nutarcosu := tar.valor;
                           ELSE
                              nuvalotarvar := tar.valor;
                           END IF;
                           swconsu := 1;
                       END LOOP;
                    END IF;
                 END IF;
                IF swconsu      = 0 THEN
                   sberrorprog  := '-1'||'-'||sberrorprog;
                   nulineaerror := 244;
                END IF;
                nuerror                   := 9;
                IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                   sberrorpaso             := 'Linea error : '||nulineaerror||
                   ' PRODUCTO : '||nuuserror||' CTA : '||nucuentacob||
                   ' ERROR AL OBTENER LA TARIFA DE CONSUMO SUBSIDIADA Y PLENA'||
                   sberrorprog;
                   ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENASUBSIDIOCIERRE'),
                                        nuuserror,sberrorpaso,nuvalorsub);
                ELSE
                   nuerror := 10;
                   -- Validamos si se pertenece a rango 1 o 2
                   IF NVL(nuunliq,0) < 21 THEN
                      nurango        := 1;
                   ELSE
                      nurango := 2;
                   END IF;
                   nuerror := 11;
                   -- Obtenemos fecha de la tarifa de consumo
                   sberrorprog  := '00';
                   sberrorpaso  := NULL;
                   IF nucodtarev = -1 THEN
                      IF nuperi   = -1 THEN
                         dttcfein := to_date('01/01/1900','dd/mm/yyyy');
                         dttcfefi := to_date('30/01/1900','dd/mm/yyyy');
                      ELSE
                         BEGIN
                             SELECT
                                   tc.vitcfein,tc.vitcfefi
                                   INTO dttcfein,dttcfefi
                                   FROM open.ta_vigetaco tc
                                   WHERE tc.vitctaco                                = nutaco
                                         AND to_number(TO_CHAR(tc.vitcfein,'YYYYMM')) = nuperi;
                         EXCEPTION
                             WHEN OTHERS THEN
                                  sberrorpaso := 'Periodo : '||TO_CHAR(nuperi)||' Factura : '||
                                  TO_CHAR(nufactura)||' nutaco '||TO_CHAR(nutaco)||' doso '||
                                  sbbdoso;
                                  ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENASUBSIDIOCIERRE'),nuuserror,sberrorpaso,nuvalorsub);
                                  dttcfein := to_date('01/01/1900','dd/mm/yyyy');
                                  dttcfefi := to_date('30/01/1900','dd/mm/yyyy');
                         END;
                         sbobservacion := 'PROCESO DE RECUPERACION.';
                      END IF;
                   ELSE
                      BEGIN
                           SELECT tc.vitcfein, tc.vitcfefi INTO dttcfein, dttcfefi
                                  FROM open.ta_vigetaco tc
                                  WHERE  tc.vitccons = nucodtarev;
                      EXCEPTION
                           WHEN OTHERS THEN
                                sberrorprog  := '-1'||'-'||SQLERRM;
                                nulineaerror := 289;
                      END;
                   END IF;
                   nuerror                   := 12;
                   IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                      sberrorpaso             := 'Linea error : '||TO_CHAR(nulineaerror)
                      ||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '||TO_CHAR(
                      nucuentacob)||
                      ' ERROR AL OBTENER AL OBTENER EL CONSECUTIVO DE TARIFA DE CONSUMO '
                      ||sberrorprog;
                      ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENASUBSIDIOCIERRE'),
                           nuuserror,sberrorpaso,nuvalorsub);
                   ELSE
                      nuerror := 13;
                      -- Obtenemos consecutivo para la tarifa de subsidio
                      sberrorprog  := '00';
                      sberrorpaso  := NULL;
                      IF nucodtarev = -1 THEN
                         nucodtarev := -1;
                      ELSE
                         BEGIN
                              SELECT vitccons INTO nucodtarev  FROM open.ta_vigetaco tc  WHERE tc.vitctaco  = nutaco AND TRUNC(tc.vitcfein) = TRUNC(dttcfein)
                                   AND TRUNC(tc.vitcfefi) = TRUNC(dttcfefi);
                         EXCEPTION
                            WHEN OTHERS THEN
                                 sberrorprog  := '-1'||'-'||SQLERRM;
                                 nulineaerror := 309;
                         END;
                      END IF;
                      nuerror                   := 14;
                      IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                         sberrorpaso             := 'Linea error : '||TO_CHAR(nulineaerror
                         )||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '||TO_CHAR(
                         nucuentacob)||
                         ' ERROR AL OBTENER EL CONSECUTIVO DE LA TARIFA DE SUBSIDIO'||
                         sberrorprog;
                         ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENASUBSIDIOCIERRE'),
                          nuuserror,sberrorpaso,nuvalorsub);
                      ELSE
                         nuerror      := 15;
                         swconsu      := 0;
                         IF nucodtarev = -1 THEN
                            nutarsub   := 0;
                            swconsu    := 1;
                         ELSE
                            --INICIA CA 459
                            IF sbAplicaca459 = 'S' THEN
                               FOR tar IN cuGetConcepTran(nuuserror,nufactura, nupeco,nupefa, nuConcSub) LOOP
                                   IF tar.ini  = 0 THEN
                                      nutarsub := tar.valor;
                                   END IF;
                                   swconsu := 1;
                               END LOOP;
                            END IF;
                            --FIN CA 459
                            IF swconsu = 0 THEN
                               FOR tar IN cu_tarifas(nucodtarev)  LOOP
                                   IF tar.ini  = 0 THEN
                                      nutarsub := tar.valor;
                                   END IF;
                                   swconsu := 1;
                               END LOOP;
                            END IF;
                         END IF;
                         IF swconsu      = 0 THEN
                sberrorprog  := '-1'||'-'||sberrorprog;
                nulineaerror := 244;
              END IF;
                            nuerror                   := 16;
                            IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                               sberrorpaso             := 'Linea error : '||nulineaerror||
                               ' PRODUCTO : '||nuuserror||' CTA : '||nucuentacob||
                               ' ERROR AL OBTENER LA TARIFA DE SUBSIDIO '||sberrorprog;
                               ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENASUBSIDIOCIERRE'
                                    ),nuuserror,sberrorpaso,nuvalorsub);
                            ELSE
                               -- Tipo tarifa mercado
                               sberrorprog := '00';
                               sberrorpaso := NULL;
                               IF nutaco    = -1 THEN
                                  numerca   := -1;
                               ELSE
                                  BEGIN
                                       SELECT jh.tacocr03 INTO numerca  FROM open.ta_tariconc jh WHERE jh.tacocons = nutaco;
                                  EXCEPTION
                                       WHEN OTHERS THEN
                                            numerca      := -1;
                                            sberrorprog  := '-1'||'-'||SQLERRM;
                                            nulineaerror := 328;
                                  END;
                               END IF;
                               nuerror                   := 17;
                               IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                                  sberrorpaso             := 'Linea error : '||TO_CHAR(nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '
                                                             ||TO_CHAR(nucuentacob)|| ' ERROR AL OBTENER EL MERCADO RELEVANTE DE LA TARIFA '||
                                                             sberrorprog;
                                  ldc_procregerrorproc(nuano,numes,TRIM( 'LDC_LLENASUBSIDIOCIERRE'),nuuserror,sberrorpaso,nuvalorsub);
                               ELSE
                                  nuerror := 18;
                                  -- Obtenemos el porcentaje de subsidio/contribuci��n
                                  IF NVL(nutarcosu,0) <> 0 THEN
                                     vporc             := ROUND((NVL(nutarsub,0)/NVL(nutarcosu,0 )) *100,2);
                                  ELSE
                                     vporc := 0;
                                  END IF;
                                  nuerror := 19;
                                  -- Construimos el indice de agrupaci��n
                                  sberrorprog := '00';
                                  sberrorpaso := NULL;
                                  BEGIN
                                       sbindice := TO_CHAR(nuarserv) || TO_CHAR(nuano) || TO_CHAR(numes) || TO_CHAR(TRUNC(dttcfein),'YYYYMMDD')|| TO_CHAR(
                                                   TRUNC(dttcfefi),'YYYYMMDD')|| TO_CHAR(nucate) || TO_CHAR(nusuca) || TO_CHAR(nudiasfact) || TO_CHAR(NVL(nurango,0))
                                                   || TO_CHAR(nuvalotarvar) || TO_CHAR(nutarcosu) || TO_CHAR(nutarsub) || TO_CHAR(vporc) || TO_CHAR(nuarserv) || TO_CHAR
                                                   (numerca) || trim(sbobservacion);
                                  EXCEPTION
                                       WHEN OTHERS THEN
                                            sberrorprog  := '-1'||'-'||SQLERRM;
                                            nulineaerror := 364;
                                  END;
                                  nuerror                   := 20;
                                  IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                                     sberrorpaso             := 'Linea error : '||TO_CHAR(
                                     nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)||
                                     ' CTA : '||TO_CHAR(nucuentacob)||
                                     ' ERROR AL CONSTRUIR EL INDICE '||sberrorprog;
                                     ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENASUBSIDIOCIERRE'),nuuserror,sberrorpaso,nuvalorsub);
                                  ELSE
                                     nuerror := 21;
                                     -- Llenamos el arreglo de indice con sus respectivas agrupaciones
                                     nurefarrind                   := table_indice.count;
                                     IF nurefarrind                 = 0 THEN
                                        nucontaindice               := 1;
                                        table_indice(nucontaindice) := trim(sbindice);
                                        nuposicap                   := nucontaindice;
                                     ELSE
                                        sw := 0;
                                        FOR indice IN 1..nurefarrind LOOP
                                            IF trim(table_indice(indice)) = trim(sbindice) THEN
                                               nuposicap                  := indice;
                                               sw                         := 1;
                                               EXIT;
                                            ELSE
                                               sw := 0;
                                            END IF;
                                        END LOOP;
                                        IF sw                          = 0 THEN
                                           nucontaindice               := nurefarrind + 1;
                                           table_indice(nucontaindice) := trim(sbindice);
                                           nuposicap                   := nucontaindice;
                                        END IF;
                                     END IF;
                                     nuerror := 22;
                                     -- Llenamos el arreglo del subsidio
                                     IF table_bi_subsidio.exists(nuposicap) THEN
                                        table_bi_subsidio(nuposicap).areasev := nuarserv;
                                        table_bi_subsidio(nuposicap).anofact := nuano;
                                        table_bi_subsidio(nuposicap).mesfact := numes;
                                        table_bi_subsidio(nuposicap).anotari := to_number(TO_CHAR(TRUNC(dttcfein),'YYYY'));
                                        table_bi_subsidio(nuposicap).mestari := to_number(TO_CHAR(TRUNC(dttcfein),'MM'));
                                        table_bi_subsidio(nuposicap).feintar  := TRUNC(dttcfein);
                                        table_bi_subsidio(nuposicap).fefintar := TRUNC(dttcfefi);
                                        table_bi_subsidio(nuposicap).categor  := nucate;
                                        table_bi_subsidio(nuposicap).subcate  := nusuca;
                                        table_bi_subsidio(nuposicap).diasfac  := nudiasfact;
                                        table_bi_subsidio(nuposicap).rangcon  := nurango;
                                        table_bi_subsidio(nuposicap).consmt3  :=
                                        table_bi_subsidio(nuposicap).consmt3 + nuunliq;
                                        table_bi_subsidio(nuposicap).causmt3 := table_bi_subsidio (nuposicap).causmt3 + nucantusco;
                                        table_bi_subsidio(nuposicap).tarfvar := nuvalotarvar;
                                        table_bi_subsidio(nuposicap).condmt3 := table_bi_subsidio (nuposicap).condmt3 + ROUND(nuconsu$,0);
                                        table_bi_subsidio(nuposicap).caussub := nutarcosu;
                                        table_bi_subsidio(nuposicap).tarfsub := nutarsub;
                                        table_bi_subsidio(nuposicap).porsubs := vporc;
                                        table_bi_subsidio(nuposicap).subsidi := table_bi_subsidio(nuposicap).subsidi + nuvalorsub;
                                        table_bi_subsidio(nuposicap).noajman     := 0;
                                        table_bi_subsidio(nuposicap).arease2     := nuarserv;
                                        table_bi_subsidio(nuposicap).tiptame     := numerca;
                                        table_bi_subsidio(nuposicap).observacion := trim(sbobservacion);
                                     ELSE
                                        table_bi_subsidio(nuposicap).areasev := nuarserv;
                                        table_bi_subsidio(nuposicap).anofact := nuano;
                                        table_bi_subsidio(nuposicap).mesfact := numes;
                                        table_bi_subsidio(nuposicap).anotari := to_number(TO_CHAR(TRUNC(dttcfein),'YYYY'));
                                        table_bi_subsidio(nuposicap).mestari := to_number(TO_CHAR(TRUNC(dttcfein),'MM'));
                                        table_bi_subsidio(nuposicap).feintar  := TRUNC(dttcfein);
                                        table_bi_subsidio(nuposicap).fefintar := TRUNC(dttcfefi);
                                        table_bi_subsidio(nuposicap).categor  := nucate;
                                        table_bi_subsidio(nuposicap).subcate  := nusuca;
                                        table_bi_subsidio(nuposicap).diasfac  := nudiasfact;
                                        table_bi_subsidio(nuposicap).rangcon  := nurango;
                                        table_bi_subsidio(nuposicap).consmt3  := nuunliq;
                                        table_bi_subsidio(nuposicap).causmt3  := nucantusco;
                                        table_bi_subsidio(nuposicap).tarfvar  := nuvalotarvar;
                                        table_bi_subsidio(nuposicap).condmt3  := ROUND(nuconsu$,0);
                                        table_bi_subsidio(nuposicap).caussub     := nutarcosu;
                                        table_bi_subsidio(nuposicap).tarfsub     := nutarsub;
                                        table_bi_subsidio(nuposicap).porsubs     := vporc;
                                        table_bi_subsidio(nuposicap).subsidi     := nuvalorsub;
                                        table_bi_subsidio(nuposicap).noajman     := 0;
                                        table_bi_subsidio(nuposicap).arease2     := nuarserv;
                                        table_bi_subsidio(nuposicap).tiptame     := numerca;
                                        table_bi_subsidio(nuposicap).observacion := trim(sbobservacion);
                                     END IF;
                                     nuerror := 23;
					                 -- Construimos el indice de agrupaci��n por departamento CASO 648
                                     sberrorprog := '00';
                                     sberrorpaso := NULL;
                                     BEGIN
                                          sbindiceDEP := TO_CHAR(nuarserv) || TO_CHAR(nuano) || TO_CHAR(numes) || TO_CHAR(TRUNC(dttcfein),'YYYYMMDD')|| TO_CHAR(
                                                         TRUNC(dttcfefi),'YYYYMMDD')|| TO_CHAR(nucate) || TO_CHAR(nusuca) || TO_CHAR(nudiasfact) || TO_CHAR(NVL(nurango,0))
                                                         || TO_CHAR(nuvalotarvar) || TO_CHAR(nutarcosu) || TO_CHAR(nutarsub) || TO_CHAR(vporc) || TO_CHAR(nuarserv) || TO_CHAR
                                                         (nuDEPA) || trim(sbobservacion);
                                     EXCEPTION
                                          WHEN OTHERS THEN
                                               sberrorprog  := '-1'||'-'||SQLERRM;
                                               nulineaerror := 364;
                                     END;
                                     nuerror                   := 24;
                                     IF SUBSTR(sberrorprog,1,2) = '-1' THEN
                                        sberrorpaso             := 'Linea error : '||TO_CHAR( nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)|| ' CTA : '||TO_CHAR(nucuentacob)||
                                                                   ' ERROR AL CONSTRUIR EL INDICE DEP'||sberrorprog;
                                        ldc_procregerrorproc(nuano,numes,TRIM( 'LDC_LLENASUBSIDIOCIERRE'),nuuserror,sberrorpaso,nuvalorsub);
                                     ELSE
                                        nuerror := 25;
                                        -- Llenamos el arreglo de indice con sus respectivas agrupaciones
                                        nurefarrindDEP                   := table_indice_DEP.count;
                                        IF nurefarrindDEP                 = 0 THEN
                                           nucontaindiceDEP               := 1;
                                           table_indice_DEP(nucontaindice) := trim(sbindiceDEP);
                                           nuposicapDEP                   := nucontaindiceDEP;
                                        ELSE
                                           sw := 0;
                                           FOR indiceDEP IN 1..nurefarrindDEP LOOP
                                               IF trim(table_indice_DEP(indiceDEP)) = trim(sbindiceDEP) THEN
                                                  nuposicapDEP                  := indiceDEP;
                                                  sw                         := 1;
                                                  EXIT;
                                               ELSE
                                                  sw := 0;
                                               END IF;
                                           END LOOP;
                                           IF sw = 0 THEN
                                              nucontaindiceDEP               := nurefarrindDEP + 1;
                                              table_indice_DEP(nucontaindiceDEP) := trim(sbindiceDEP);
                                              nuposicapDEP                   := nucontaindiceDEP;
                                           END IF;
                                        END IF;
                                        nuerror := 26;
                                        -- Llenamos el arreglo del subsidio
                                        IF table_bi_subsidio_DEP.exists(nuposicapDEP) THEN
                                           table_bi_subsidio_DEP(nuposicapDEP).areasev := nuarserv;
                                           table_bi_subsidio_DEP(nuposicapDEP).anofact := nuano;
                                           table_bi_subsidio_DEP(nuposicapDEP).mesfact := numes;
                                           table_bi_subsidio_DEP(nuposicapDEP).anotari := to_number(TO_CHAR(TRUNC(dttcfein),'YYYY'));
                                           table_bi_subsidio_DEP(nuposicapDEP).mestari := to_number(TO_CHAR(TRUNC(dttcfein),'MM'));
                                           table_bi_subsidio_DEP(nuposicapDEP).feintar  := TRUNC(dttcfein);
                                           table_bi_subsidio_DEP(nuposicapDEP).fefintar := TRUNC(dttcfefi);
                                           table_bi_subsidio_DEP(nuposicapDEP).categor  := nucate;
                                           table_bi_subsidio_DEP(nuposicapDEP).subcate  := nusuca;
                                           table_bi_subsidio_DEP(nuposicapDEP).diasfac  := nudiasfact;
                                           table_bi_subsidio_DEP(nuposicapDEP).rangcon  := nurango;
                                           table_bi_subsidio_DEP(nuposicapDEP).consmt3  :=table_bi_subsidio_DEP(nuposicapDEP).consmt3 + nuunliq;
                                           table_bi_subsidio_DEP(nuposicapDEP).causmt3 := table_bi_subsidio_DEP(nuposicapDEP).causmt3 + nucantusco;
                                           table_bi_subsidio_DEP(nuposicapDEP).tarfvar := nuvalotarvar;
                                           table_bi_subsidio_DEP(nuposicapDEP).condmt3 := table_bi_subsidio_DEP(nuposicapDEP).condmt3 + ROUND(nuconsu$,0);
                                           table_bi_subsidio_DEP(nuposicapDEP).caussub := nutarcosu;
                                           table_bi_subsidio_DEP(nuposicapDEP).tarfsub := nutarsub;
                                           table_bi_subsidio_DEP(nuposicapDEP).porsubs := vporc;
                                           table_bi_subsidio_DEP(nuposicapDEP).subsidi := table_bi_subsidio_DEP(nuposicapDEP).subsidi + nuvalorsub;
                                           table_bi_subsidio_DEP(nuposicapDEP).noajman     := 0;
                                           table_bi_subsidio_DEP(nuposicapDEP).arease2     := nuarserv;
                                           table_bi_subsidio_DEP(nuposicapDEP).DEPARTAMENTO     := nuDEPA;
                                           table_bi_subsidio_DEP(nuposicapDEP).observacion := trim(sbobservacion);
                                        ELSE
                                           table_bi_subsidio_DEP(nuposicapDEP).areasev := nuarserv;
                                           table_bi_subsidio_DEP(nuposicapDEP).anofact := nuano;
                                           table_bi_subsidio_DEP(nuposicapDEP).mesfact := numes;
                                           table_bi_subsidio_DEP(nuposicapDEP).anotari := to_number(TO_CHAR(TRUNC(dttcfein),'YYYY'));
                                           table_bi_subsidio_DEP(nuposicapDEP).mestari := to_number(TO_CHAR(TRUNC(dttcfein),'MM'));
                                           table_bi_subsidio_DEP(nuposicapDEP).feintar  := TRUNC(dttcfein);
                                           table_bi_subsidio_DEP(nuposicapDEP).fefintar := TRUNC(dttcfefi);
                                           table_bi_subsidio_DEP(nuposicapDEP).categor  := nucate;
                                           table_bi_subsidio_DEP(nuposicapDEP).subcate  := nusuca;
                                           table_bi_subsidio_DEP(nuposicapDEP).diasfac  := nudiasfact;
                                           table_bi_subsidio_DEP(nuposicapDEP).rangcon  := nurango;
                                           table_bi_subsidio_DEP(nuposicapDEP).consmt3  := nuunliq;
                                           table_bi_subsidio_DEP(nuposicapDEP).causmt3  := nucantusco;
                                           table_bi_subsidio_DEP(nuposicapDEP).tarfvar  := nuvalotarvar;
                                           table_bi_subsidio_DEP(nuposicapDEP).condmt3  := ROUND(nuconsu$,0);
                                           table_bi_subsidio_DEP(nuposicapDEP).caussub     := nutarcosu;
                                           table_bi_subsidio_DEP(nuposicapDEP).tarfsub     := nutarsub;
                                           table_bi_subsidio_DEP(nuposicapDEP).porsubs     := vporc;
                                           table_bi_subsidio_DEP(nuposicapDEP).subsidi     := nuvalorsub;
                                           table_bi_subsidio_DEP(nuposicapDEP).noajman     := 0;
                                           table_bi_subsidio_DEP(nuposicapDEP).arease2     := nuarserv;
                                           table_bi_subsidio_DEP(nuposicapDEP).DEPARTAMENTO := nuDEPA;
                                           table_bi_subsidio_DEP(nuposicapDEP).observacion := trim(sbobservacion);
                                        END IF;
                                        nuerror := 27;
                                    END IF;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
		end if;
    END LOOP;
    COMMIT;
    EXIT
  WHEN cufacturas%NOTFOUND;
    nuerror := -28;
  END LOOP;
  COMMIT;
  CLOSE cufacturas;
  nuerror := 29;


  -- Llenamos la tabla de subsidio
  FOR i IN 1..table_bi_subsidio.count LOOP
    INSERT
    INTO
      ldc_osf_subsidio
      (
        areasev ,
        anofact ,
        mesfact ,
        anotari ,
        mestari ,
        feintar ,
        fefintar ,
        categor ,
        subcate ,
        diasfac ,
        rangcon ,
        consmt3 ,
        causmt3 ,
        tarfvar ,
        condmt3 ,
        caussub ,
        tarfsub ,
        porsubs ,
        subsidi ,
        noajman ,
        arease2 ,
        tiptame ,
        observacion
      )
      VALUES
      (
        table_bi_subsidio(i).areasev ,
        table_bi_subsidio(i).anofact ,
        table_bi_subsidio(i).mesfact ,
        table_bi_subsidio(i).anotari ,
        table_bi_subsidio(i).mestari ,
        table_bi_subsidio(i).feintar ,
        table_bi_subsidio(i).fefintar ,
        table_bi_subsidio(i).categor ,
        table_bi_subsidio(i).subcate ,
        table_bi_subsidio(i).diasfac ,
        table_bi_subsidio(i).rangcon ,
        table_bi_subsidio(i).consmt3 ,
        table_bi_subsidio(i).causmt3 ,
        table_bi_subsidio(i).tarfvar ,
        table_bi_subsidio(i).condmt3 ,
        table_bi_subsidio(i).caussub ,
        table_bi_subsidio(i).tarfsub ,
        table_bi_subsidio(i).porsubs ,
        table_bi_subsidio(i).subsidi ,
        table_bi_subsidio(i).noajman ,
        table_bi_subsidio(i).arease2 ,
        table_bi_subsidio(i).tiptame ,
        table_bi_subsidio(i).observacion
      );
    nucantiregcom    := nucantiregcom + 1;
    IF nucantiregcom >= nucontareg THEN
      COMMIT;
      nucantiregtot := nucantiregtot + nucantiregcom;
      nucantiregcom := 0;
    END IF;
    nuerror := 30;
  END LOOP;
  COMMIT;

   -- Llenamos la tabla de subsidio DEP CASO 648
  FOR i IN 1..table_bi_subsidio_DEP.count
  LOOP
    INSERT
    INTO
      ldc_osf_subsidio_dep
      (
        areasev ,
        anofact ,
        mesfact ,
        anotari ,
        mestari ,
        feintar ,
        fefintar ,
        categor ,
        subcate ,
        diasfac ,
        rangcon ,
        consmt3 ,
        causmt3 ,
        tarfvar ,
        condmt3 ,
        caussub ,
        tarfsub ,
        porsubs ,
        subsidi ,
        noajman ,
        arease2 ,
        DEPARTAMENTO ,
        observacion
      )
      VALUES
      (
        table_bi_subsidio_DEP(i).areasev ,
        table_bi_subsidio_DEP(i).anofact ,
        table_bi_subsidio_DEP(i).mesfact ,
        table_bi_subsidio_DEP(i).anotari ,
        table_bi_subsidio_DEP(i).mestari ,
        table_bi_subsidio_DEP(i).feintar ,
        table_bi_subsidio_DEP(i).fefintar ,
        table_bi_subsidio_DEP(i).categor ,
        table_bi_subsidio_DEP(i).subcate ,
        table_bi_subsidio_DEP(i).diasfac ,
        table_bi_subsidio_DEP(i).rangcon ,
        table_bi_subsidio_DEP(i).consmt3 ,
        table_bi_subsidio_DEP(i).causmt3 ,
        table_bi_subsidio_DEP(i).tarfvar ,
        table_bi_subsidio_DEP(i).condmt3 ,
        table_bi_subsidio_DEP(i).caussub ,
        table_bi_subsidio_DEP(i).tarfsub ,
        table_bi_subsidio_DEP(i).porsubs ,
        table_bi_subsidio_DEP(i).subsidi ,
        table_bi_subsidio_DEP(i).noajman ,
        table_bi_subsidio_DEP(i).arease2 ,
        table_bi_subsidio_DEP(i).DEPARTAMENTO ,
        table_bi_subsidio_DEP(i).observacion
      );
    nucantiregcom    := nucantiregcom + 1;
    IF nucantiregcom >= nucontareg THEN
      COMMIT;
      nucantiregtot := nucantiregtot + nucantiregcom;
      nucantiregcom := 0;
    END IF;
    nuerror := 31;
  END LOOP;
  COMMIT;

  -- Otros cargos no factura
  FOR i IN cuotroscargos
  LOOP
    sbobservacion := 'OTRAS NOTAS DE FACTURACION SUBSIDIO';
    -- Retornamos area de servicio
    nuarserv := ldc_retornaareaservicio(i.departamento,i.localidad,i.cate);
    -- Insertamos registro
    INSERT
    INTO
      ldc_osf_subsidio
      (
        areasev ,
        anofact ,
        mesfact ,
        feintar ,
        fefintar ,
        categor ,
        subcate ,
        subsidi ,
        noajman ,
        arease2 ,
        tiptame ,
        observacion ,
        condmt3 ,
        consmt3 ,
        causmt3
      )
      VALUES
      (
        nuarserv ,
        nupaano ,
        nupames ,
        TRUNC(dtfein) ,
        TRUNC(dtfefi) ,
        i.cate ,
        i.suca ,
        NVL(i.valor,0) ,
        0 ,
        nuarserv ,
        i.mercado_relevante ,
        sbobservacion ,
        0 ,
        0 ,
        0
      );

	  -- CASO 648 INSERTAMOS EN LDC_OSF_SUBSIDIO_DEP
	  INSERT
    INTO
      ldc_osf_subsidio_DEP
      (
        areasev ,
        anofact ,
        mesfact ,
        feintar ,
        fefintar ,
        categor ,
        subcate ,
        subsidi ,
        noajman ,
        arease2 ,
        DEPARTAMENTO ,
        observacion ,
        condmt3 ,
        consmt3 ,
        causmt3
      )
      VALUES
      (
        nuarserv ,
        nupaano ,
        nupames ,
        TRUNC(dtfein) ,
        TRUNC(dtfefi) ,
        i.cate ,
        i.suca ,
        NVL(i.valor,0) ,
        0 ,
        nuarserv ,
        i.DEPARTAMENTO ,
        sbobservacion ,
        0 ,
        0 ,
        0
      );


  END LOOP;
  COMMIT;
  SELECT
    COUNT(1)
  INTO
    nucantiregtot
  FROM
    open.ldc_osf_subsidio s
  WHERE
    s.anofact   = nuano
  AND s.mesfact = numes;
  nuerror      := 0;
  sbmensa      := 'Proceso terminó Ok. Total subsidio en : '||TO_CHAR(
  nucantiregtot)||' registros.';
EXCEPTION
WHEN OTHERS THEN
 -- nuerror := -1;
  sbmensa := '-1'||' linea error : '||nuerror||
  ' Error en ldc_llenasubsidiocierre. Cuenta de cobro : '||nucuentacob||
  ' factura : '||nufactura||' '||SQLERRM;
END;
/
