CREATE OR REPLACE PROCEDURE      LDC_LLENACONTRIBUCIONCIERRE (nuano NUMBER,numes NUMBER,nuerror OUT NUMBER,sbmensa OUT VARCHAR2) IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-03-04
  Descripcion : Generamos informacion reporte contribucion a cierre

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
  23/03/2021   horbath CASO 648. Se modifica para llevar el reporte de subsidios y contribuciones
                       por departamento

***************************************************************************/
 TYPE t_bi_contribucion IS TABLE OF ldc_osf_contribucion%ROWTYPE INDEX BY BINARY_INTEGER;
 TYPE t_indice IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;

 TYPE array_contribucion IS RECORD(
                                  fact factura.factcodi%TYPE
                                 ,pefa perifact.pefacodi%TYPE
                                 ,cate cuencobr.cucocate%TYPE
                                 ,suca cuencobr.cucosuca%TYPE
                                 ,nuse cuencobr.cuconuse%TYPE
                                 ,cuco cuencobr.cucocodi%TYPE
                                 ,vlsc cargos.cargvalo%TYPE
                                 ,peco cargos.cargpeco%TYPE
                                 ,taco cargos.cargtaco%TYPE
                                 ,doso cargos.cargdoso%TYPE
                                 );
  TYPE t_array_contribucion IS TABLE OF array_contribucion;
  v_array_contribucion t_array_contribucion;
  table_bi_contribucion t_bi_contribucion;
  table_indice          t_indice;



   TYPE t_bi_contribucion_DEP IS TABLE OF ldc_osf_contribucion_DEP%ROWTYPE INDEX BY BINARY_INTEGER;
 TYPE t_indice_DEP IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;

 TYPE array_contribucion_DEP IS RECORD(
                                  fact factura.factcodi%TYPE
                                 ,pefa perifact.pefacodi%TYPE
                                 ,cate cuencobr.cucocate%TYPE
                                 ,suca cuencobr.cucosuca%TYPE
                                 ,nuse cuencobr.cuconuse%TYPE
                                 ,cuco cuencobr.cucocodi%TYPE
                                 ,vlsc cargos.cargvalo%TYPE
                                 ,peco cargos.cargpeco%TYPE
                                 ,taco cargos.cargtaco%TYPE
                                 ,doso cargos.cargdoso%TYPE
                                 );
  TYPE t_array_contribucion_DEP IS TABLE OF array_contribucion_DEP;
  v_array_contribucion_DEP t_array_contribucion_DEP;
  table_bi_contribucion_DEP t_bi_contribucion_DEP;
  table_indice_DEP          t_indice_DEP;

  nucodprogfgcc         ld_parameter.numeric_value%TYPE;
  nucodprogfgca         ld_parameter.numeric_value%TYPE;
  nucodprogmigr         ld_parameter.numeric_value%TYPE;
  nucontareg            NUMBER(15) DEFAULT 0;
  nucantiregcom         NUMBER(15) DEFAULT 0;
  nucantiregtot         NUMBER(15) DEFAULT 0;
  nucuentacob           cuencobr.cucocodi%TYPE;
  nufactura             factura.factcodi%TYPE;
  nuarserv              ldc_osf_contribucion.areasev%TYPE;
  sbindice              VARCHAR2(2000);
  sbindicedep              VARCHAR2(2000);
  nutaco                ta_vigetaco.vitctaco%TYPE;
  nucodtarev            ta_vigetaco.vitccons%TYPE;
  nuunliq               rangliqu.raliunli%TYPE;
  nuvalotarvar          rangliqu.ralivalo%TYPE;
  nuconsu$              rangliqu.ralivaul%TYPE DEFAULT 0;
  nucantusco            ldc_osf_contribucion.causmt3%TYPE DEFAULT 0;
  vporc                 ldc_osf_contribucion.porcont%TYPE;
  numerca               fa_mercrele.merecodi%TYPE;
  nuvalorcont           cargos.cargvalo%TYPE;
  nurefarrind           NUMBER(6);
  nurefarrindDEP        number(6);
  nucontaindice         NUMBER(6);
  nucontaindicedep         NUMBER(6);
  nuposicap             NUMBER(6);
  nuposicapdep             NUMBER(6);
  sw                    NUMBER(1) DEFAULT 0;
  nucusacargmasiv       ld_parameter.numeric_value%TYPE;
  sberrorprog           VARCHAR2(2000);
  sberrorpaso           VARCHAR2(2000);
  nulineaerror          NUMBER(3) DEFAULT 0;
  nuuserror             cuencobr.cuconuse%TYPE;
  nudepa                ge_geogra_location.geo_loca_father_id%TYPE;
  nuloca                ge_geogra_location.geograp_location_id%TYPE;
  swconsu               NUMBER(1) DEFAULT 0;
  dttcfein              DATE;
  dttcfefi              DATE;
  sbtipusu              ldc_osf_contribucion.tipousu%TYPE;
  vcargfunid            cargos.cargunid%TYPE;
  vcargfvalo            cargos.cargvalo%TYPE;
  nuconconsu            cargos.cargconc%TYPE;
  sbdoso                cargos.cargdoso%TYPE;
  dtfein                DATE;
  dtfefi                DATE;
  nupaano               NUMBER(4);
  nupames               NUMBER(2);
  sbobservacion         ldc_osf_contribucion.observacion%TYPE;
  nuperi                NUMBER(6);
  limit_in              NUMBER;
  sbbdoso               cargos.cargdoso%TYPE;
  nucate                cuencobr.cucocate%TYPE;
  nusuca                cuencobr.cucocate%TYPE;
  nupeco                cargos.cargpeco%TYPE;
  nupefa                cargos.cargpefa%TYPE;

-- Cursor facturas
 CURSOR cufacturas IS
  SELECT
         factcodi
        ,pefacodi
        ,cucocate
        ,cucosuca
        ,cuconuse
        ,cucocodi
        ,valorsc
        ,cargpeco
        ,cargtaco
        ,doso
    FROM open.ldc_vista_subsid_contrib;
   -- Cursor consumos
   CURSOR cu_rangliqu (nuse NUMBER,nupeco NUMBER,nucupefa NUMBER,nuconcepto NUMBER) IS
    SELECT r.raliidre,r.raliunli,r.ralivaul,r.ralivalo
      FROM open.rangliqu r
     WHERE r.ralisesu = nuse
       AND r.ralipeco = nupeco
       AND r.ralipefa = nucupefa
       AND r.raliconc = nuconcepto
     ORDER BY r.raliliir;

   -- Cursor cargo fijo
   CURSOR c_cargos1 (nuse number,ncuco number) is
    SELECT  /*+ RULE */ nvl(sum(decode(cargsign,'CR',-1*nvl(cargunid,0),'DB',nvl(cargunid,0))),0) unid
                       ,nvl(round(sum(decode(cargsign,'CR',-1*nvl(cargvalo,0),'DB',nvl(cargvalo,0))),2),0) valo
      FROM open.cargos
     WHERE cargnuse = nuse
       AND cargcuco = ncuco
       AND cargprog IN(nucodprogfgca,nucodprogfgcc,nucodprogmigr)
       AND cargconc = dald_parameter.fnuGetNumeric_Value('COD_CONCEPTO_CF')
       AND cargcaca = nucusacargmasiv;

   -- Cursor cargo consumos
  CURSOR c_cargos (nuse number,ncuco number,nupefa NUMBER,nupeco NUMBER) IS
   SELECT  /*+ RULE */
         nvl(sum(decode(cargsign,'CR',-1*nvl(cargunid,0),'DB',nvl(cargunid,0))),0) unid
        ,nvl(round(sum(decode(cargsign,'CR',-1*nvl(cargvalo,0),'DB',nvl(cargvalo,0))),2),0) valo
     FROM open.cargos
    WHERE cargnuse = nuse
      AND cargcuco = ncuco
      AND cargpefa = nupefa
      AND cargpeco = nupeco
      AND cargprog IN(nucodprogfgca,nucodprogfgcc,nucodprogmigr)
      AND cargconc = dald_parameter.fnuGetNumeric_Value('COD_CONCEPTO_CONSUMO')
      AND cargcaca <> dald_parameter.fnuGetNumeric_Value('CAUSAL_AJUSTE_CONSUMO')
      AND cargcaca = nucusacargmasiv
      AND substr(cargdoso,1,2) = 'CO';

 -- Cursor otros cargos contribucion no facturas
 CURSOR cuotroscargos IS
  SELECT *
    FROM ldc_view_otras_not_sub_con;

	 --INICIO CA 459
  nuConcContri  NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONCONTRTRAS', NULL); -- se almacena concepto de contribucion transitorio
  nuConceConTra NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONCTATT',  NULL); --se almacena concepto de consumo tarifa transitoria
  sbAplicaca459 VARCHAR2(1);
  --se consulta informacion de tarifa transitoria
  CURSOR cuGetConcepTran(nuse NUMBER,nfactura NUMBER,nupeco     NUMBER,nupefa NUMBER)
  IS
    SELECT    dptttatt valor
    FROM  OPEN.ldc_deprtatt
    WHERE  dpttfact   = nfactura
    AND DPTTSESU = nuse
    AND dpttperi = nupefa
    AND dpttpeco = nupeco
    AND dpttconc = nuConceConTra;

  CURSOR cuGetConsuTranTotal(nuse NUMBER,nfactura NUMBER,nupeco NUMBER,nupefa NUMBER, inuconcepto NUMBER)
  IS
    SELECT   NVL(SUM(DECODE(DPTTSIGN, 'CR', -NVL(dpttvano,0),NVL(dpttvano,0) )),0)
    FROM  OPEN.ldc_deprtatt
    WHERE   dpttfact           = nfactura
    AND DPTTSESU         = nuse
    AND dpttperi         = nupefa
    AND dpttpeco         = nupeco
    AND dpttconc         = inuconcepto;
  nuConsuTranTot NUMBER := 0;
  nuExisTT NUMBER := 0;
  nuvalotarvartt number := 0;
  nuContrITranTot number := 0;
  --FIN CA 459
BEGIN
 nuerror := 0;
 sbmensa := NULL;
 nucantiregcom := 0;
 nucantiregtot := 0;
 nucantusco := 0;
 nucontaindice := 0;
 nupaano := nuano;
 nupames := numes;
  -- Obtenemos fecha inicial y final del periodo contable
 ldc_cier_prorecupaperiodocont(nuano,numes,dtfein,dtfefi,sbmensa,nuerror);
  -- Codigo programa fgcc
 nucodprogfgcc := dald_parameter.fnuGetNumeric_Value('COD_FACTPROG');
  -- Codigo programa fgca
 nucodprogfgca := dald_parameter.fnuGetNumeric_Value('COD_PROG_FGCA');
  -- Codigo programa migracion
 nucodprogmigr := dald_parameter.fnuGetNumeric_Value('COD_PROG_MIGR');
  -- Obtenemos el concepto de consumo
 nuconconsu := dald_parameter.fnuGetNumeric_Value('COD_CONCEPTO_CONSUMO');
  -- Causa generacion cargos masivos
 nucusacargmasiv := dald_parameter.fnuGetNumeric_Value('CAUSA_CARGOS_MASIVOS');
  -- Borramos datos de la tabla para el a?o y mes
 DELETE ldc_osf_contribucion h WHERE h.anofact = nuano AND h.mesfact = numes;
 DELETE ldc_osf_contribucion_dep x WHERE x.anofact = nuano AND x.mesfact = numes;
 COMMIT;
  -- Borramos los datos de la tabla de errores para el a?o y mes
 DELETE ldc_osf_errproc y WHERE y.ano = nuano AND y.mes = numes AND trim(y.proceso) = 'LDC_LLENACONTRIBUCIONCIERRE';
 COMMIT;

 nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 limit_in := nucontareg;
  -- Recorremos las facturas
  nulineaerror := 0;
   -- Variables para la vista
 ldc_pk_parametros_vistas.dtfein      := dtfein;
 ldc_pk_parametros_vistas.dtfefi      := dtfefi;
 ldc_pk_parametros_vistas.sbprograma  := 'CONTRIBUCION';
 ldc_pk_parametros_vistas.nuclascont  := dald_parameter.fnuGetNumeric_Value('CLASIFICADOR_CONTRIBUCION');

 --INICIA CA 459
  IF FBLAPLICAENTREGAXCASO('0000459') THEN
    sbAplicaca459 := 'S';
  END IF;
 --FIN CA 459
 OPEN cufacturas;
 LOOP
     FETCH cufacturas BULK COLLECT INTO v_array_contribucion LIMIT limit_in;
     FOR f IN 1..v_array_contribucion.count LOOP
         --FOR f IN cufacturas(dtfein,dtfefi) LOOP
         nuerror     := 1;
         nufactura   := v_array_contribucion(f).fact;
         nucuentacob := v_array_contribucion(f).cuco;
         nuuserror   := v_array_contribucion(f).nuse;
         nuvalorcont := nvl(v_array_contribucion(f).vlsc,0);
         sbtipusu    := NULL;
         nutaco      := nvl(v_array_contribucion(f).taco,-1);
         sbbdoso     := v_array_contribucion(f).doso;
         sbdoso      := substr(sbbdoso,1,5);
         nucate      := v_array_contribucion(f).cate;
         nusuca      := v_array_contribucion(f).suca;
         nucantusco  := 1;
         nupeco      := v_array_contribucion(f).peco;
         nupefa      := v_array_contribucion(f).pefa;
         nuConsuTranTot := 0;
         nucodtarev  := 0;
         nuExisTT    := 0;
         nuvalotarvartt := 0;
         nuContrITranTot := 0;
         IF trim(sbdoso) = 'CN-PR' THEN
            nuperi := to_number(to_char(to_date('1/'||substr(sbbdoso,11)||'/'||substr(sbbdoso,7,4),'dd/mm/yyyy'),'YYYYMM'));
            sbobservacion := 'PROCESO DE RECUPERACION.';
         ELSIF trim(sbdoso) = 'CN-20' THEN
            sbobservacion := 'LIQUIDACION NORMAL.';
            nuperi := to_number(to_char(to_date('1/'||substr(sbbdoso,8)||'/'||substr(sbbdoso,4,4),'dd/mm/yyyy'),'YYYYMM'));
         ELSE
            nuperi := -1;
            sbobservacion := 'DESCUENTO CONTRIBUCION.';
         END IF;
         -- Verificamos el tipo de usuario
         IF nucate IN(1,2,3) THEN
            sbtipusu := 'R';
         ELSE
            sbtipusu := 'N';
         END IF;
         -- Obtenemos la localidad del producto al cierre
         sberrorprog := '00';
         sberrorpaso := NULL;
         BEGIN
              SELECT di.geograp_location_id
                     ,(SELECT de.geo_loca_father_id FROM ge_geogra_location de WHERE de.geograp_location_id = di.geograp_location_id) INTO nuloca,nudepa
                     FROM open.pr_product pr,ab_address di
                     WHERE pr.product_id = nuuserror
                           AND pr.address_id = di.address_id;
              EXCEPTION
                     WHEN OTHERS THEN
                          nudepa := -1;
                          nuloca := -1;
                          nulineaerror := 151;
                          sberrorprog := '-1'||'-'||SQLERRM;
              END;
              -- Retornamos area de servicio
              nuarserv := ldc_retornaareaservicio(nudepa,nuloca,nucate);
              nuerror := 2;
              IF substr(sberrorprog,1,2) = '-1' THEN
                 sberrorpaso := 'Linea error : '||nulineaerror||' PRODUCTO : '||nuuserror||' CTA : '||nucuentacob||' ERROR AL OBTENER LA LOCALIDAD DEL PRODUCTO '||sberrorprog;
                 ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
              ELSE
                 -- Facturacion por cargo de consumo y las unidades liquidadas
                 nuunliq := 0;
                 nuconsu$ := 0;
                 sberrorprog := '00';
                 sberrorpaso := NULL;
                 swconsu := 0;
                 IF nuvalorcont > 0 THEN
                    --INICIA CA 459
                    IF sbAplicaca459   = 'S' THEN
                       IF trim(sbdoso) != 'CN-PR' THEN
                          OPEN cuGetConsuTranTotal(nuuserror,nufactura, nupeco,nupefa, nuConceConTra);
                          FETCH cuGetConsuTranTotal INTO nuConsuTranTot;
                          CLOSE cuGetConsuTranTotal;
			              --se consulta valor contribucion
			              OPEN cuGetConsuTranTotal(nuuserror,nufactura, nupeco,nupefa, nuConcContri);
                          FETCH cuGetConsuTranTotal INTO nuContrITranTot;
                          CLOSE cuGetConsuTranTotal;
                	      OPEN cuGetConcepTran(nuuserror,nufactura, nupeco,nupefa);
			              FETCH cuGetConcepTran INTO nuvalotarvartt;
			              IF cuGetConcepTran%FOUND THEN
			                 nuExisTT := 1;
			              ELSE
			                 nuvalotarvartt :=0;
			                 nuExisTT := 0;
			              END IF;
			              CLOSE cuGetConcepTran;
                        END IF;
                    END IF;
                    --TERMINA CA 459
	                FOR liq IN cu_rangliqu(nuuserror,nupeco,nupefa,nuconconsu) LOOP
                        IF trim(sbdoso) = 'CN-PR' THEN
                           NULL;
                        ELSIF trim(sbdoso) = 'CN-20' THEN
                           nuunliq      := nuunliq + liq.raliunli;
                           nuconsu$     := nuconsu$ + liq.ralivaul;
                           nuvalotarvar := liq.ralivalo;
                           nucodtarev   := liq.raliidre;
                           swconsu      := 1;
                        END IF;
                    END LOOP;
                 END IF;
                 -- Validamos si se encontro liquidacion de consumo
                 IF swconsu = 0 THEN
                    -- Facturacion por cargo de consumo y las unidades liquidadas consumo promedio
                    IF nuvalorcont > 0 THEN
                       OPEN c_cargos(nuuserror,nucuentacob,nupefa,nupeco);
                       FETCH c_cargos INTO nuunliq,nuconsu$;
                       IF c_cargos%NOTFOUND THEN
                          nuunliq := 0;
                          nuconsu$ := 0;
                          sberrorprog := '-1'||'-'||SQLERRM;
                          nulineaerror := 205;
                       END IF;
                       CLOSE c_cargos;
                    END IF;
                    nucodtarev := -1;
                 END IF;
                 nuerror := 7;
                 sberrorprog := '00';
                 sberrorpaso := NULL;
                 nuerror := 8;
	             --INICIA CA 459
	             --se descuenta valor del consumo
                 IF nuExisTT = 1 THEN
		            nuconsu$    := nuconsu$ + nuConsuTranTot;
		            nuvalotarvar := nuvalotarvartt;
	             END IF;
	             --FIN CASO 459
                 -- Facturacion por cargo fijo
                 OPEN c_cargos1(nuuserror,nucuentacob);
                 FETCH c_cargos1 into vcargfunid,vcargfvalo;
                 IF c_cargos1%notfound then
                    vcargfunid:=0;
                    vcargfvalo:=0;
                    sberrorprog := '-1'||'-'||sberrorprog;
                    nulineaerror := 240;
                 END IF;
                 CLOSE c_cargos1;
                 nuerror := 9;
                 IF substr(sberrorprog,1,2) = '-1' THEN
                    sberrorpaso := 'Linea error : '||nulineaerror||' PRODUCTO : '||nuuserror||' CTA : '||nucuentacob||' ERROR AL OBTENER EL CARGO FIJO '||sberrorprog;
                    ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
                 ELSE
                    nuerror := 10;
                    -- Obtenemos fecha de la tarifa de consumo
                    sberrorprog := '00';
                    sberrorpaso := NULL;
                    IF nucodtarev = -1 OR  nucodtarev = 0 THEN
                       IF nuperi = -1 THEN
                          dttcfein := to_date('01/01/1900','dd/mm/yyyy');
                          dttcfefi := to_date('30/01/1900','dd/mm/yyyy');
                       ELSE
                          BEGIN
                               SELECT tc.vitcfein,tc.vitcfefi INTO dttcfein,dttcfefi
                                      FROM open.ta_vigetaco tc
                                      WHERE tc.vitctaco = nutaco
                                            AND to_number(to_char(tc.vitcfein,'YYYYMM')) = nuperi;
                          EXCEPTION
                               WHEN OTHERS THEN
                                    sberrorpaso := 'Periodo : '||to_char(nuperi)||' Factura : '||to_char(nufactura)||' nutaco '||to_char(nutaco)||' doso '||sbbdoso;
                                    ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
                                    dttcfein := to_date('01/01/1900','dd/mm/yyyy');
                                    dttcfefi := to_date('30/01/1900','dd/mm/yyyy');
                          END;
		                  IF nucodtarev = -1 THEN
			                 sbobservacion := 'PROCESO DE RECUPERACION.';
		                  END IF;
                       END IF;
                    ELSE
                       BEGIN
                            SELECT tc.vitcfein,tc.vitcfefi INTO dttcfein,dttcfefi
                                   FROM open.ta_vigetaco tc
                                   WHERE tc.vitccons = nucodtarev;
                       EXCEPTION
                            WHEN OTHERS THEN
                                 sberrorprog := '-1'||'-'||SQLERRM;
                                 nulineaerror := 259;
                       END;
                    END IF;
                    nuerror := 11;
                    IF substr(sberrorprog,1,2) = '-1' THEN
                       sberrorpaso := 'Linea error : '||TO_CHAR(nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '||TO_CHAR(nucuentacob)||' ERROR AL OBTENER LAS FECHAS DEL RANGO DE TARIFA '||sberrorprog;
                       ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
                    ELSE
                       sberrorprog := '00';
                       sberrorpaso := NULL;
                       IF nucodtarev = -1 THEN
                          nuvalotarvar := 0;
                          IF nucate = 1 THEN
                             vporc := 20;
                          ELSE
                             vporc := 8.9;
                          END IF;
                       ELSE
                          BEGIN
                               SELECT tc.vitcporc INTO vporc
                                      FROM open.ta_vigetaco tc
                                      WHERE tc.vitctaco  = nutaco
                                            AND trunc(vitcfein) = trunc(dttcfein)
                                            AND trunc(vitcfefi) = trunc(dttcfefi);
                          EXCEPTION
                               WHEN OTHERS THEN
                                    sberrorprog := '-1'||'-'||SQLERRM;
                                    nulineaerror := 259;
                          END;
                       END IF;
                       -- Tipo tarifa mercado
                       sberrorprog := '00';
                       sberrorpaso := NULL;
                       IF substr(sberrorprog,1,2) = '-1' THEN
                          sberrorpaso := 'Linea error : '||TO_CHAR(nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '||TO_CHAR(nucuentacob)||' ERROR AL OBTENER EL PORCENTAJE DE CONTRIBUCION '||sberrorprog;
                          ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
                       ELSE
                          IF nutaco = -1 THEN
                             numerca := -1;
                          ELSE
                             BEGIN
                                  SELECT jh.tacocr03 INTO numerca
                                         FROM open.ta_tariconc jh
                                         WHERE jh.tacocons = nutaco;
                             EXCEPTION
                                  WHEN no_data_found THEN
                                       numerca := -1;
                                  WHEN OTHERS THEN
                                       numerca := -1;
                                       sberrorprog := '-1'||'-'||SQLERRM;
                                       nulineaerror := 277;
                             END;
                          END IF;
                          nuerror := 12;
                          IF substr(sberrorprog,1,2) = '-1' THEN
                             sberrorpaso := 'Linea error : '||TO_CHAR(nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '||TO_CHAR(nucuentacob)||' ERROR AL OBTENER EL MERCADO RELEVANTE DE LA TARIFA '||sberrorprog;
                             ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
                          ELSE
                             nuerror := 13;
                             -- Construimos el indice de agrupacion
                             sberrorprog := '00';
                             sberrorpaso := NULL;
                             BEGIN
                                  sbindice := to_char(nuarserv)                  ||
                                              to_char(nuano)                     ||
                                              to_char(numes)                     ||
                                              to_char(trunc(dttcfein),'YYYYMMDD')||
                                              to_char(trunc(dttcfefi),'YYYYMMDD')||
                                              trim(sbtipusu)                     ||
                                              to_char(nucate)                ||
                                              to_char(nusuca)                ||
                                              to_char(nuvalotarvar)              ||
                                              to_char(vcargfvalo)                ||
                                              to_char(vporc)                     ||
                                              to_char(nuarserv)                  ||
                                              to_char(numerca)                   ||
                                              trim(sbobservacion);
                             EXCEPTION
                                  WHEN OTHERS THEN
                                       sberrorprog := '-1'||'-'||SQLERRM;
                                       nulineaerror := 303;
                             END;
                             nuerror := 14;
                             IF substr(sberrorprog,1,2) = '-1' THEN
                                sberrorpaso := 'Linea error : '||TO_CHAR(nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '||TO_CHAR(nucuentacob)||' ERROR AL CONSTRUIR EL INDICE '||sberrorprog;
                                ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
                             ELSE
                                nuerror := 15;
                                -- Llenamos el arreglo de indice con sus respectivas agrupaciones
                                nurefarrind := table_indice.count;
                                IF nurefarrind = 0 THEN
                                   nucontaindice := 1;
                                   table_indice(nucontaindice) := trim(sbindice);
                                   nuposicap := nucontaindice;
                                ELSE
                                   sw := 0;
                                   FOR indice IN 1..nurefarrind LOOP
                                       IF trim(table_indice(indice)) = trim(sbindice) THEN
                                          nuposicap := indice;
                                          sw := 1;
                                          exit;
                                       ELSE
                                          sw := 0;
                                       END IF;
                                   END LOOP;
                                   IF sw = 0 then
                                      nucontaindice := nurefarrind + 1;
                                      table_indice(nucontaindice) := trim(sbindice);
                                      nuposicap := nucontaindice;
                                   END IF;
                                END IF;
                                nuerror := 16;
                                -- Llenamos el arreglo de contribucion
                                IF table_bi_contribucion.exists(nuposicap) THEN
                                   table_bi_contribucion(nuposicap).areasev  := nuarserv;
                                   table_bi_contribucion(nuposicap).anofact  := nuano;
                                   table_bi_contribucion(nuposicap).mesfact  := numes;
                                   table_bi_contribucion(nuposicap).anotari  := to_number(to_char(trunc(dttcfein),'YYYY'));
                                   table_bi_contribucion(nuposicap).mestari  := to_number(to_char(trunc(dttcfein),'MM'));
                                   table_bi_contribucion(nuposicap).feintar  := trunc(dttcfein);
                                   table_bi_contribucion(nuposicap).fefintar := trunc(dttcfefi);
                                   table_bi_contribucion(nuposicap).tipousu  := trim(sbtipusu);
                                   table_bi_contribucion(nuposicap).categor  := nucate;
                                   table_bi_contribucion(nuposicap).subcate  := nusuca;
                                   table_bi_contribucion(nuposicap).consmt3  := table_bi_contribucion(nuposicap).consmt3 + nuunliq;
                                   table_bi_contribucion(nuposicap).causmt3  := table_bi_contribucion(nuposicap).causmt3 + nucantusco;
                                   table_bi_contribucion(nuposicap).tarfvar  := nuvalotarvar;
                                   table_bi_contribucion(nuposicap).condmt3  := table_bi_contribucion(nuposicap).condmt3 + round(nuconsu$,0);
                                   table_bi_contribucion(nuposicap).cargfij  := vcargfvalo;
                                   table_bi_contribucion(nuposicap).porcont  := vporc;
                                   table_bi_contribucion(nuposicap).contrdi  := table_bi_contribucion(nuposicap).contrdi + nuvalorcont;
                                   table_bi_contribucion(nuposicap).noajman  := 0;
                                   table_bi_contribucion(nuposicap).arease2  := nuarserv;
                                   table_bi_contribucion(nuposicap).tiptame  := numerca;
                                   table_bi_contribucion(nuposicap).observacion := trim(sbobservacion);
                                ELSE
                                   table_bi_contribucion(nuposicap).areasev := nuarserv;
                                   table_bi_contribucion(nuposicap).anofact := nuano;
                                   table_bi_contribucion(nuposicap).mesfact := numes;
                                   table_bi_contribucion(nuposicap).anotari := to_number(to_char(trunc(dttcfein),'YYYY'));
                                   table_bi_contribucion(nuposicap).mestari := to_number(to_char(trunc(dttcfein),'MM'));
                                   table_bi_contribucion(nuposicap).feintar := trunc(dttcfein);
                                   table_bi_contribucion(nuposicap).fefintar := trunc(dttcfefi);
                                   table_bi_contribucion(nuposicap).tipousu  := trim(sbtipusu);
                                   table_bi_contribucion(nuposicap).categor  := nucate;
                                   table_bi_contribucion(nuposicap).subcate := nusuca;
                                   table_bi_contribucion(nuposicap).consmt3 := nuunliq;
                                   table_bi_contribucion(nuposicap).causmt3 := nucantusco;
                                   table_bi_contribucion(nuposicap).tarfvar := nuvalotarvar;
                                   table_bi_contribucion(nuposicap).condmt3 := round(nuconsu$,0);
                                   table_bi_contribucion(nuposicap).cargfij := vcargfvalo;
                                   table_bi_contribucion(nuposicap).porcont := vporc;
                                   table_bi_contribucion(nuposicap).contrdi := nuvalorcont;
                                   table_bi_contribucion(nuposicap).noajman := 0;
                                   table_bi_contribucion(nuposicap).arease2 := nuarserv;
                                   table_bi_contribucion(nuposicap).tiptame := numerca;
                                   table_bi_contribucion(nuposicap).observacion := trim(sbobservacion);
                                END IF;
                                nuerror := 17;
		                        -- Construimos el indice de agrupacion por departamento caso 648
                                sberrorprog := '00';
                                sberrorpaso := NULL;
                                BEGIN
                                     sbindicedep := to_char(nuarserv)                  ||
                                     to_char(nuano)                     ||
                                     to_char(numes)                     ||
                                     to_char(trunc(dttcfein),'YYYYMMDD')||
                                     to_char(trunc(dttcfefi),'YYYYMMDD')||
                                     trim(sbtipusu)                     ||
                                     to_char(nucate)                ||
                                     to_char(nusuca)                ||
                                     to_char(nuvalotarvar)              ||
                                     to_char(vcargfvalo)                ||
                                     to_char(vporc)                     ||
                                     to_char(nuarserv)                  ||
                                     to_char(nudepa)                   ||
                                     trim(sbobservacion);
                                EXCEPTION
                                      WHEN OTHERS THEN
                                           sberrorprog := '-1'||'-'||SQLERRM;
                                           nulineaerror := 303;
                                END;
                                nuerror := 18;
                                IF substr(sberrorprog,1,2) = '-1' THEN
                                   sberrorpaso := 'Linea error : '||TO_CHAR(nulineaerror)||' PRODUCTO : '||TO_CHAR(nuuserror)||' CTA : '||TO_CHAR(nucuentacob)||' ERROR AL CONSTRUIR EL INDICE por  DEPARTAMENTO '||sberrorprog;
                                   ldc_procregerrorproc(nuano,numes,TRIM('LDC_LLENACONTRIBUCIONCIERRE'),nuuserror,sberrorpaso,nuvalorcont);
                                ELSE
                                   nuerror := 19;
                                   -- Llenamos el arreglo de indice con sus respectivas agrupaciones
                                   nurefarrindDEP := table_indice_DEP.count;
                                   IF nurefarrinddep = 0 THEN
                                      nucontaindicedep := 1;
                                      table_indice_dep(nucontaindicedep) := trim(sbindicedep);
                                      nuposicapdep := nucontaindicedep;
                                   ELSE
                                      sw := 0;
                                      FOR indicedep IN 1..nurefarrinddep LOOP
                                          IF trim(table_indice_dep(indicedep)) = trim(sbindicedep) THEN
                                             nuposicapdep := indicedep;
                                             sw := 1;
                                             exit;
                                          ELSE
                                             sw := 0;
                                          END IF;
                                     END LOOP;
                                     IF sw = 0 then
                                        nucontaindicedep := nurefarrinddep + 1;
                                        table_indice_DEP(nucontaindicedep) := trim(sbindicedep);
                                        nuposicapdep := nucontaindicedep;
                                     END IF;
                                END IF;
                                nuerror := 20;
                                -- Llenamos el arreglo de contribucion
                                IF table_bi_contribucion_dep.exists(nuposicapdep) THEN
                                   table_bi_contribucion_dep(nuposicapdep).areasev  := nuarserv;
                                   table_bi_contribucion_dep(nuposicapdep).anofact  := nuano;
                                   table_bi_contribucion_dep(nuposicapdep).mesfact  := numes;
                                   table_bi_contribucion_dep(nuposicapdep).anotari  := to_number(to_char(trunc(dttcfein),'YYYY'));
                                   table_bi_contribucion_dep(nuposicapdep).mestari  := to_number(to_char(trunc(dttcfein),'MM'));
                                   table_bi_contribucion_dep(nuposicapdep).feintar  := trunc(dttcfein);
                                   table_bi_contribucion_dep(nuposicapdep).fefintar := trunc(dttcfefi);
                                   table_bi_contribucion_dep(nuposicapdep).tipousu  := trim(sbtipusu);
                                   table_bi_contribucion_dep(nuposicapdep).categor  := nucate;
                                   table_bi_contribucion_dep(nuposicapdep).subcate  := nusuca;
                                   table_bi_contribucion_dep(nuposicapdep).consmt3  := table_bi_contribucion_dep(nuposicapdep).consmt3 + nuunliq;
                                   table_bi_contribucion_dep(nuposicapdep).causmt3  := table_bi_contribucion_dep(nuposicapdep).causmt3 + nucantusco;
                                   table_bi_contribucion_dep(nuposicapdep).tarfvar  := nuvalotarvar;
                                   table_bi_contribucion_dep(nuposicapdep).condmt3  := table_bi_contribucion_dep(nuposicapdep).condmt3 + round(nuconsu$,0);
                                   table_bi_contribucion_dep(nuposicapdep).cargfij  := vcargfvalo;
                                   table_bi_contribucion_dep(nuposicapdep).porcont  := vporc;
                                   table_bi_contribucion_dep(nuposicapdep).contrdi  := table_bi_contribucion_dep(nuposicapdep).contrdi + nuvalorcont;
                                   table_bi_contribucion_dep(nuposicapdep).noajman  := 0;
                                   table_bi_contribucion_dep(nuposicapdep).arease2  := nuarserv;
                                   table_bi_contribucion_dep(nuposicapdep).departamento  := nudepa;
                                   table_bi_contribucion_dep(nuposicapdep).observacion := trim(sbobservacion);
                                ELSE
                                   table_bi_contribucion_dep(nuposicapdep).areasev := nuarserv;
                                   table_bi_contribucion_dep(nuposicapdep).anofact := nuano;
                                   table_bi_contribucion_dep(nuposicapdep).mesfact := numes;
                                   table_bi_contribucion_dep(nuposicapdep).anotari := to_number(to_char(trunc(dttcfein),'YYYY'));
                                   table_bi_contribucion_dep(nuposicapdep).mestari := to_number(to_char(trunc(dttcfein),'MM'));
                                   table_bi_contribucion_dep(nuposicapdep).feintar := trunc(dttcfein);
                                   table_bi_contribucion_dep(nuposicapdep).fefintar := trunc(dttcfefi);
                                   table_bi_contribucion_dep(nuposicapdep).tipousu  := trim(sbtipusu);
                                   table_bi_contribucion_dep(nuposicapdep).categor  := nucate;
                                   table_bi_contribucion_dep(nuposicapdep).subcate := nusuca;
                                   table_bi_contribucion_dep(nuposicapdep).consmt3 := nuunliq;
                                   table_bi_contribucion_dep(nuposicapdep).causmt3 := nucantusco;
                                   table_bi_contribucion_dep(nuposicapdep).tarfvar := nuvalotarvar;
                                   table_bi_contribucion_dep(nuposicapdep).condmt3 := round(nuconsu$,0);
                                   table_bi_contribucion_dep(nuposicapdep).cargfij := vcargfvalo;
                                   table_bi_contribucion_dep(nuposicapdep).porcont := vporc;
                                   table_bi_contribucion_dep(nuposicapdep).contrdi := nuvalorcont;
                                   table_bi_contribucion_dep(nuposicapdep).noajman := 0;
                                   table_bi_contribucion_dep(nuposicapdep).arease2 := nuarserv;
                                   table_bi_contribucion_dep(nuposicapdep).departamento := nudepa;
                                   table_bi_contribucion_dep(nuposicapdep).observacion := trim(sbobservacion);
                                END IF;
                                nuerror := 21;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;
		end if;
    END IF;
 END LOOP;
 COMMIT;
  EXIT WHEN cufacturas%NOTFOUND;
  nuerror      := -22;
 END LOOP;
 COMMIT;
CLOSE cufacturas;
   nuerror := 23;
 -- Llenamos la tabla de Contribucion
 FOR i in 1..table_bi_contribucion.count LOOP
  INSERT INTO ldc_osf_contribucion
                                (
                                 areasev
                                ,anofact
                                ,mesfact
                                ,anotari
                                ,mestari
                                ,feintar
                                ,fefintar
                                ,tipousu
                                ,categor
                                ,subcate
                                ,consmt3
                                ,causmt3
                                ,tarfvar
                                ,condmt3
                                ,cargfij
                                ,porcont
                                ,contrdi
                                ,noajman
                                ,arease2
                                ,tiptame
                                ,observacion
                                )
                         VALUES
                               (
                                table_bi_contribucion(i).areasev
                               ,table_bi_contribucion(i).anofact
                               ,table_bi_contribucion(i).mesfact
                               ,table_bi_contribucion(i).anotari
                               ,table_bi_contribucion(i).mestari
                               ,table_bi_contribucion(i).feintar
                               ,table_bi_contribucion(i).fefintar
                               ,table_bi_contribucion(i).tipousu
                               ,table_bi_contribucion(i).categor
                               ,table_bi_contribucion(i).subcate
                               ,table_bi_contribucion(i).consmt3
                               ,table_bi_contribucion(i).causmt3
                               ,table_bi_contribucion(i).tarfvar
                               ,table_bi_contribucion(i).condmt3
                               ,table_bi_contribucion(i).cargfij
                               ,table_bi_contribucion(i).porcont
                               ,table_bi_contribucion(i).contrdi
                               ,table_bi_contribucion(i).noajman
                               ,table_bi_contribucion(i).arease2
                               ,table_bi_contribucion(i).tiptame
                               ,table_bi_contribucion(i).observacion
                               );
  nucantiregcom := nucantiregcom + 1;
  IF nucantiregcom >= nucontareg THEN
     COMMIT;
     nucantiregtot := nucantiregtot + nucantiregcom;
     nucantiregcom := 0;
  END IF;
   nuerror := 24;
 END LOOP;
 COMMIT;

  -- Llenamos la tabla de Contribucion caso 648
 FOR i in 1..table_bi_contribucion_dep.count LOOP
  INSERT INTO ldc_osf_contribucion_dep
                                (
                                 areasev
                                ,anofact
                                ,mesfact
                                ,anotari
                                ,mestari
                                ,feintar
                                ,fefintar
                                ,tipousu
                                ,categor
                                ,subcate
                                ,consmt3
                                ,causmt3
                                ,tarfvar
                                ,condmt3
                                ,cargfij
                                ,porcont
                                ,contrdi
                                ,noajman
                                ,arease2
                                ,departamento
                                ,observacion
                                )
                         VALUES
                               (
                                table_bi_contribucion_dep(i).areasev
                               ,table_bi_contribucion_dep(i).anofact
                               ,table_bi_contribucion_dep(i).mesfact
                               ,table_bi_contribucion_dep(i).anotari
                               ,table_bi_contribucion_dep(i).mestari
                               ,table_bi_contribucion_dep(i).feintar
                               ,table_bi_contribucion_dep(i).fefintar
                               ,table_bi_contribucion_dep(i).tipousu
                               ,table_bi_contribucion_dep(i).categor
                               ,table_bi_contribucion_dep(i).subcate
                               ,table_bi_contribucion_dep(i).consmt3
                               ,table_bi_contribucion_dep(i).causmt3
                               ,table_bi_contribucion_dep(i).tarfvar
                               ,table_bi_contribucion_dep(i).condmt3
                               ,table_bi_contribucion_dep(i).cargfij
                               ,table_bi_contribucion_dep(i).porcont
                               ,table_bi_contribucion_dep(i).contrdi
                               ,table_bi_contribucion_dep(i).noajman
                               ,table_bi_contribucion_dep(i).arease2
                               ,table_bi_contribucion_dep(i).departamento
                               ,table_bi_contribucion_dep(i).observacion
                               );
  nucantiregcom := nucantiregcom + 1;
  IF nucantiregcom >= nucontareg THEN
     COMMIT;
     nucantiregtot := nucantiregtot + nucantiregcom;
     nucantiregcom := 0;
  END IF;
   nuerror := 25;
 END LOOP;
 COMMIT;


 -- Otros cargos no factura
  FOR i IN cuotroscargos LOOP
   sbobservacion := 'OTRAS NOTAS DE FACTURACION CONTRIBUCION';
   IF i.cate IN(1,2,3) THEN
      sbtipusu := 'R';
   ELSE
      sbtipusu := 'N';
   END IF;
  -- Retornamos area de servicio
  nuarserv := ldc_retornaareaservicio(i.departamento,i.localidad,i.cate);
  -- Registramos otras notas de contribucion
  INSERT INTO ldc_osf_contribucion
                                (
                                 areasev
                                ,anofact
                                ,mesfact
                                ,feintar
                                ,fefintar
                                ,tipousu
                                ,categor
                                ,subcate
                                ,contrdi
                                ,noajman
                                ,arease2
                                ,tiptame
                                ,observacion
                                ,condmt3
                                ,consmt3
                                ,causmt3
                                )
                         VALUES
                               (
                                nuarserv
                               ,nupaano
                               ,nupames
                               ,trunc(dtfein)
                               ,trunc(dtfefi)
                               ,sbtipusu
                               ,i.cate
                               ,i.suca
                               ,nvl(i.valor,0)
                               ,0
                               ,nuarserv
                               ,i.mercado_relevante
                               ,sbobservacion
                               ,0
                               ,0
                               ,0
                               );


     INSERT INTO ldc_osf_contribucion_dep
                                (
                                 areasev
                                ,anofact
                                ,mesfact
                                ,feintar
                                ,fefintar
                                ,tipousu
                                ,categor
                                ,subcate
                                ,contrdi
                                ,noajman
                                ,arease2
                                ,departamento
                                ,observacion
                                ,condmt3
                                ,consmt3
                                ,causmt3
                                )
                         VALUES
                               (
                                nuarserv
                               ,nupaano
                               ,nupames
                               ,trunc(dtfein)
                               ,trunc(dtfefi)
                               ,sbtipusu
                               ,i.cate
                               ,i.suca
                               ,nvl(i.valor,0)
                               ,0
                               ,nuarserv
                               ,i.departamento
                               ,sbobservacion
                               ,0
                               ,0
                               ,0
                               );
 END LOOP;
 COMMIT;
 nuerror := 20;
 SELECT COUNT(1) INTO nucantiregtot
    FROM open.ldc_osf_contribucion s
   WHERE s.anofact = nuano
     AND s.mesfact = numes;
  nuerror := 0;
  sbmensa := 'Proceso termino Ok. Total contribucion en : '||to_char(nucantiregtot)||' registros.';
EXCEPTION
 WHEN OTHERS THEN
 -- nuerror := -1;
  sbmensa:= '-1'||' linea error : '||to_char(nuerror)||' Error en LDC_LLENACONTRIBUCIONCIERRE. Cuenta de cobro : '||to_char(nucuentacob)||' factura : '||to_char(nufactura)||' '||SQLERRM;
END;
/
