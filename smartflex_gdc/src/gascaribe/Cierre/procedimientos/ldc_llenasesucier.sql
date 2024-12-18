CREATE OR REPLACE PROCEDURE ldc_llenasesucier(
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-08-19
  Descripcion : Generamos información del producto a cierre nuevo esquema

  Parametros Entrada
    nuano A�o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
 ***************************************************************************/
                                              nupano  IN NUMBER,
                                              nupmes  IN NUMBER,
                                              sbmensa OUT VARCHAR2,
                                              error   OUT NUMBER
                                             ) IS
 TYPE array_cartcierre IS RECORD(
                                  nuse servsusc.sesunuse%TYPE
                                 ,tipr servsusc.sesuserv%TYPE
                                 ,cicl servsusc.sesucicl%TYPE
                                 ,cate servsusc.sesucate%TYPE
                                 ,suca servsusc.sesusuca%TYPE
                                 ,depa ge_geogra_location.geograp_location_id%TYPE
                                 ,loca ge_geogra_location.geograp_location_id%TYPE
                                 ,esco estacort.escocodi%TYPE
                                 ,cont servsusc.sesususc%TYPE
                                 ,dire ab_address.address_parsed%TYPE
                                 ,espo pr_product.product_status_id%TYPE
                                 ,esfi servsusc.sesuesfn%TYPE
                                 ,barr ab_address.neighborthood_id%TYPE
                                 ,clie ge_subscriber.subscriber_id%TYPE
                                 ,nomb ge_subscriber.subscriber_name%TYPE
                                 ,prap ge_subscriber.subs_last_name%TYPE
                                 ,seap ge_subscriber.subs_second_last_name%TYPE
                                 ,safa servsusc.sesusafa%TYPE
                                 ,sect ab_segments.operating_sector_id%TYPE
                                 ,pred ab_address.estate_number%TYPE
                                 ,iurb ab_address.is_urban%TYPE
                                 ,uasu pr_product.suspen_ord_act_id%TYPE
                                 );

TYPE t_array_cartcierre IS TABLE OF array_cartcierre;
v_array_cartcierre t_array_cartcierre;
 -- Cursor productos
 CURSOR cuservsusc IS
  SELECT l.sesunuse
       ,l.product_type_id
       ,l.sesucicl
       ,l.cate_prod
       ,l.sucacate_prod
       ,l.nuvdepa
       ,l.nuvloca
       ,l.estado_corte sesuesco
       ,l.contrato sesususc
       ,l.direccion
       ,l.estado_producto product_status_id
       ,l.estado_financiero sesuesfn
       ,l.barrio
       ,l.cliente suscclie
       ,l.subscriber_name
       ,l.subs_last_name
       ,l.subs_second_last_name
       ,l.sesusafa
       ,l.nuvsector
       ,l.predio
       ,l.is_urban
       ,l.ult_act_susp acsusp
   FROM open.ldc_view_cartcierre l;

 -- Cursor deuda corriente producto
 CURSOR cuiccartcoco(nucnuse ic_cartcoco.caccnuse%TYPE,dtcfech DATE) IS
  SELECT c.caccfeve fecha_vence
        ,c.cacccuco cta_cob
        ,ldc_edad_mes(TO_NUMBER(dtcfech-TRUNC(c.caccfeve))) edad_mora
        ,NVL(SUM(c.caccsape),0) saldo_cuenta
    FROM ic_cartcoco c
   WHERE c.caccnuse = nucnuse
     AND c.caccfege = dtcfech
     AND c.caccnaca = 'N'
GROUP BY c.caccfeve,c.cacccuco
ORDER BY c.caccfeve DESC;

-- Ultimo plan de financiacion del producto
CURSOR cuultref(nupprod NUMBER) IS
 SELECT
       DISTINCT d.difecofi codigo_financiacion
      ,TRUNC(d.difefein)   fecha_ingreso
      ,d.difepldi          plan_financiacion
  FROM open.diferido d
 WHERE difenuse = nupprod
   AND difeprog = 'GCNED'
 ORDER BY trunc(difefein) DESC;


nuedadmor            NUMBER(5);
nuedaddeud           NUMBER(5);
nuctasconsaldo       NUMBER(5);
nusaldtot            ic_cartcoco.caccsape%TYPE;
nusalnove            ic_cartcoco.caccsape%TYPE;
nusalvenc            ic_cartcoco.caccsape%TYPE;
nutotdife            ic_cartcoco.caccsape%TYPE;
nunuse               servsusc.sesunuse%TYPE;
rg_ab_premise        ab_premise%ROWTYPE;
rg_ab_block          ab_block%ROWTYPE;
nupefa               perifact.pefacodi%TYPE;
TYPE tbperifact IS TABLE OF perifact%ROWTYPE INDEX BY BINARY_INTEGER;
tab_perifact         tbperifact;
v_consumo            conssesu.cosscoca%TYPE;
dtfege               factura.factfege%TYPE;
sbcebe               ldci_centrobenef.cebecodi%TYPE;
sbarserv             ldci_centrobenef.cebesegm%TYPE;
v_vare               cuencobr.cucovare%TYPE;
v_panoab             cuencobr.cucovrap%TYPE;
dtfefiini            DATE;
dtfefifin            DATE;
err_fecha_per_conta  EXCEPTION;
nuerror              NUMBER(3):= 0;
nucontareg           NUMBER(15) DEFAULT 0;
nucantiregcom        NUMBER(15) DEFAULT 0;
nucantiregtot        NUMBER(15) DEFAULT 0;
nuctacob             cuencobr.cucocodi%TYPE;
limit_in             INTEGER := 100;
nuconccero           NUMBER(6);
nuultre              plandife.pldicodi%TYPE;
nucontaref           NUMBER(3);
nutotodifcorr        ic_cartcoco.caccsape%TYPE DEFAULT 0;
nutotodifnocorr      ic_cartcoco.caccsape%TYPE DEFAULT 0;
BEGIN
 nuerror := 0;
 sbmensa := NULL;
 error := 0;
 nucantiregcom := 0;
 nucantiregtot := 0;
 -- Borramos datos de la tabla sesucier para el año y mes a cerrar
 nuerror := -1;
 DELETE ldc_osf_sesucier n WHERE n.nuano = nupano AND numes = nupmes AND n.area_servicio = n.area_servicio;
 COMMIT;
 nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 limit_in   := nucontareg;
 -- Recuperamos fecha inicial y final del periodo contable
 nuerror := -2;
 ldc_cier_prorecupaperiodocont(nupano,nupmes,dtfefiini,dtfefifin,sbmensa,error);
 IF error <> 0 THEN
  RAISE err_fecha_per_conta;
 END IF;
 dtfefifin := trunc(dtfefifin);
 -- Guardamos ciclos de productos en arreglo
 nuerror := -3;
 FOR h IN (SELECT DISTINCT(sesucicl) pciclo FROM servsusc) LOOP
  BEGIN
   SELECT MAX(f.pefacodi) INTO nupefa
     FROM perifact f
    WHERE f.pefacicl = h.pciclo
      AND f.pefaactu = '-';
  EXCEPTION
   WHEN no_data_found THEN
    nupefa := NULL;
    tab_perifact(h.pciclo).pefacodi := nupefa;
  END;
   tab_perifact(h.pciclo).pefacodi := nupefa;
 END LOOP;
 -- Recorremos los productos
 nuerror := -4;
 OPEN cuservsusc;
 LOOP
  FETCH cuservsusc BULK COLLECT INTO v_array_cartcierre LIMIT limit_in;
   FOR i IN 1..v_array_cartcierre.count LOOP
       nuerror        := -5;
       nunuse         := v_array_cartcierre(i).nuse;
       nusaldtot      := 0;
       nusalnove      := 0;
       nuedadmor      := NULL;
       nuedaddeud     := NULL;
       nuctacob       := NULL;
       nuctasconsaldo := 0;
      -- Consultamos los datos del predio
      nuerror := -6;
      BEGIN
       SELECT pd.premise_id
             ,pd.block_id
             ,pd.block_side
             ,pd.premise
             ,pd.number_division
             ,pd.premise_type_id
             ,pd.segments_id
             ,pd.zip_code_id
         INTO rg_ab_premise.premise_id
             ,rg_ab_premise.block_id
             ,rg_ab_premise.block_side
             ,rg_ab_premise.premise
             ,rg_ab_premise.number_division
             ,rg_ab_premise.premise_type_id
             ,rg_ab_premise.segments_id
             ,rg_ab_premise.zip_code_id
         FROM ab_premise pd
        WHERE pd.premise_id = v_array_cartcierre(i).pred;
      EXCEPTION
       WHEN no_data_found THEN
        rg_ab_premise.premise_id := -1;
        rg_ab_premise.block_id := -1;
        rg_ab_premise.block_side := '-1';
        rg_ab_premise.premise := -1;
        rg_ab_premise.number_division := -1;
        rg_ab_premise.premise_type_id := -1;
        rg_ab_premise.segments_id := -1;
        rg_ab_premise.zip_code_id := -1;
      END;
      -- Consultamos el sector catastral y la manzana
      nuerror := -7;
      BEGIN
       SELECT sector,zone INTO rg_ab_block.sector,rg_ab_block.zone
         FROM ab_block bl
        WHERE bl.block_id = rg_ab_premise.block_id;
      EXCEPTION
       WHEN no_data_found THEN
        rg_ab_block.sector := -1;
        rg_ab_block.zone := -1;
      END;
      -- Obtenemos el consumo facturado
      nuerror := -8;
      BEGIN
       SELECT NVL(SUM(cl.cosscoca),0) INTO v_consumo
         FROM conssesu cl
        WHERE cl.cosspefa = tab_perifact(v_array_cartcierre(i).cicl).pefacodi
          AND cl.cossmecc = 4
          AND cl.cosssesu = nunuse;
      EXCEPTION
       WHEN OTHERS THEN
        v_consumo := NULL;
      END;
      -- Obtenemos saldo corriente, edad deuda y edad mora
      nuerror := -9;
      FOR j IN cuiccartcoco(nunuse,dtfefifin) LOOP
       IF NVL(j.saldo_cuenta,0) > 0 THEN
        nuedadmor      := j.edad_mora;
        nuctacob       := j.cta_cob;
        nuctasconsaldo := nuctasconsaldo + 1;
       END IF;
       nusaldtot       := nusaldtot + NVL(j.saldo_cuenta,0);
       IF nuedadmor <= 0 THEN
        nusalnove      := nusalnove + NVL(j.saldo_cuenta,0);
       END IF;
      END LOOP;
      -- Obtenemos la fecha de generacion de la ultima cuenta de cobro mas antigua con saldo
      nuerror := -10;
      BEGIN
       SELECT f.factfege INTO dtfege
         FROM cuencobr,factura f
        WHERE cucocodi = nuctacob
          AND cucofact = f.factcodi;
      EXCEPTION
       WHEN OTHERS THEN
        dtfege := NULL;
      END;
      -- Calculamos la edad de deuda
      nuerror := -11;
      IF dtfege IS NOT NULL THEN
       dtfege := trunc(dtfege);
       nuedaddeud := ldc_edad_mes(to_number(dtfefifin - dtfege));
      ELSE
       nuedaddeud := NULL;
      END IF;
      -- Calculamos deuda vencida
      nuerror := -12;
      nusalvenc  := nusaldtot - nusalnove;
      -- Obtenemos la deuda diferida o deuda no corriente
      nuerror         := -13;
      nutotdife       := 0;
      nutotodifcorr   := 0;
      nutotodifnocorr := 0;
      SELECT nvl(SUM(cartera_diferida_corto),0),nvl(SUM(cartera_diferida_largo),0) INTO nutotodifcorr,nutotodifnocorr
        FROM(
             SELECT nvl(SUM(d.caccsape),0) cartera_diferida_corto,0 AS cartera_diferida_largo
               FROM open.ic_cartcoco d
              WHERE d.caccnuse = nunuse
                AND d.caccfege = dtfefifin
                AND d.caccnaca = 'F'
                AND d.caccplca = 'C'
              UNION ALL
             SELECT 0 AS cartera_diferida_corto,nvl(SUM(d.caccsape),0) cartera_diferida_largo
               FROM open.ic_cartcoco d
              WHERE d.caccnuse = nunuse
                AND d.caccfege = dtfefifin
                AND d.caccnaca = 'F'
                AND d.caccplca = 'L');
       nutotdife := nvl(nutotodifcorr,0)+nvl(nutotodifnocorr,0);
      /*SELECT NVL(SUM(d.caccsape),0) INTO nutotdife
        FROM ic_cartcoco d
       WHERE d.caccnuse = nunuse
         AND d.caccfege = dtfefifin
         AND d.caccnaca = 'F';*/
      -- Obtenemos el centro de beneficio de la localidad y la categoria
      nuerror := -14;
      sbcebe := NULL;
      BEGIN
       sbcebe := open.ldci_pkinterfazsap.fvaGetCebeNew(v_array_cartcierre(i).loca,v_array_cartcierre(i).cate);
      EXCEPTION
       WHEN OTHERS THEN
        sbcebe := '-1';
      END;
      -- Obtenemos el area de servicio
      nuerror := -15;
      sbarserv := NULL;
      BEGIN
       SELECT cb.cebesegm INTO sbarserv
         FROM ldci_centrobenef cb
        WHERE cb.cebecodi = sbcebe;
      EXCEPTION
       WHEN OTHERS THEN
        sbarserv := '-1';
      END;
       -- Consultamos valor en reclamo y pago no abonado del producto
       nuerror := -16;
       v_vare := 0;
       v_panoab := 0;
      BEGIN
       SELECT NVL(SUM(ct.cucovare),0),NVL(SUM(ct.cucovrap),0) INTO v_vare,v_panoab
         FROM cuencobr ct
        WHERE ct.cuconuse = nunuse;
      EXCEPTION
       WHEN no_data_found THEN
        v_vare := 0;
        v_panoab := 0;
      END;
      -- Obtenemos cantidad de consumos 0 consecutivos
      nuerror := -17;
      nuconccero := 0;
      BEGIN
       nuconccero := open.ldc_fnuGetZeroConsPer(nunuse,nupano,nupmes);
      EXCEPTION
       WHEN OTHERS THEN
        nuconccero := 0;
      END;
      -- Recuperamos la ultima financiaci�n
       nuerror      := -18;
       nuultre      := 0;
       nucontaref   := 0;
      FOR k IN cuultref(nunuse) LOOP
       nucontaref := nucontaref + 1;
       IF nucontaref = 1 THEN
        nuultre       := k.plan_financiacion;
        EXIT;
       END IF;
      END LOOP;
      -- Registramos la informaci�n del producto a cierre
        nuerror := -19;
        INSERT INTO ldc_osf_sesucier
         (
           tipo_producto
          ,nuano
          ,numes
          ,cliente
          ,contrato
          ,producto
          ,ciclo
          ,sesusape
          ,saldo_favor
          ,departamento
          ,localidad
          ,sector
          ,estado_tecnico
          ,estado_financiero
          ,estado_corte
          ,categoria
          ,subcategoria
          ,nombres
          ,apellido
          ,segundo_apellido
          ,edad
          ,deuda_corriente_no_vencida
          ,deuda_corriente_vencida
          ,deuda_no_corriente
          ,deuda_diferida_corriente
          ,deuda_diferida_no_corriente
          ,barrio
          ,consumo
          ,codigo_predio
          ,manzana
          ,lado_manzana
          ,numero_predio
          ,numero_mejora
          ,secuencia_tipo_predio
          ,segmento_predio
          ,consecutivo_zona_postal
          ,flag_valor_reclamo
          ,valor_reclamo
          ,flag_pago_no_abo
          ,valor_pago_no_abonado
          ,nro_ctas_con_saldo
          ,sector_catastral
          ,zona_catastral
          ,ubicacion
          ,direccion_producto
          ,edad_deuda
          ,centro_benef
          ,area_servicio
          ,consumos_cero
          ,ult_act_susp
          ,ultimo_plan_fina
          )
        VALUES
         (
           v_array_cartcierre(i).tipr
          ,nupano
          ,nupmes
          ,v_array_cartcierre(i).clie
          ,v_array_cartcierre(i).cont
          ,nunuse
          ,v_array_cartcierre(i).cicl
          ,nusaldtot
          ,v_array_cartcierre(i).safa
          ,v_array_cartcierre(i).depa
          ,v_array_cartcierre(i).loca
          ,nvl(v_array_cartcierre(i).sect,-1)
          ,v_array_cartcierre(i).espo
          ,v_array_cartcierre(i).esfi
          ,v_array_cartcierre(i).esco
          ,v_array_cartcierre(i).cate
          ,v_array_cartcierre(i).suca
          ,v_array_cartcierre(i).nomb
          ,v_array_cartcierre(i).prap
          ,v_array_cartcierre(i).seap
          ,nvl(nuedadmor,-1)
          ,nvl(nusalnove,0)
          ,nvl(nusalvenc,0)
          ,nvl(nutotdife,0)
          ,nvl(nutotodifcorr,0)
          ,nvl(nutotodifnocorr,0)
          ,v_array_cartcierre(i).barr
          ,v_consumo
          ,rg_ab_premise.premise_id
          ,rg_ab_premise.block_id
          ,rg_ab_premise.block_side
          ,rg_ab_premise.premise
          ,rg_ab_premise.number_division
          ,rg_ab_premise.premise_type_id
          ,rg_ab_premise.segments_id
          ,rg_ab_premise.zip_code_id
          ,decode(v_vare,0,'N','S')
          ,v_vare
          ,decode(v_panoab,0,'N','S')
          ,v_panoab
          ,nuctasconsaldo
          ,rg_ab_block.sector
          ,rg_ab_block.zone
          ,v_array_cartcierre(i).iurb
          ,v_array_cartcierre(i).dire
          ,nvl(nuedaddeud,-1)
          ,nvl(sbcebe,'-1')
          ,nvl(sbarserv,'-1')
          ,nvl(nuconccero,0)
          ,v_array_cartcierre(i).uasu
          ,nuultre
          );
         nuerror := -20;
         nucantiregcom := nucantiregcom + 1;
   END LOOP;
   COMMIT;
  EXIT WHEN cuservsusc%NOTFOUND;
  nuerror      := -21;
 END LOOP;
 COMMIT;
CLOSE cuservsusc;
   nuerror := -22;
   nucantiregtot := nucantiregcom;
   sbmensa := 'Proceso terminó Ok. Se procesarón '||to_char(nucantiregtot)||' registros.';
   error := 0;
   nuerror := -23;
EXCEPTION
WHEN err_fecha_per_conta THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenasesucier lineas error '||nuerror||' recuperando fecha periodo contable. '||sbmensa;
  error := -1;
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenasesucier lineas error '||nuerror||' producto '||nunuse||' '||sqlerrm;
  error := -1;
END;
/
