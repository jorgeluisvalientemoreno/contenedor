CREATE OR REPLACE PROCEDURE ldc_llenasesucier_h11(
/**************************************************************************
  Fecha       : 2017-06-22
  Descripcion : Generamos informaci?n del producto a cierre nuevo esquema Hilo11

  Parametros Entrada
    nuano A?o
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
   SELECT
       s.sesunuse
      ,s.sesuserv product_type_id
      ,s.sesucicl
      ,s.sesucate cate_prod
      ,s.sesusuca sucacate_prod
      ,l.geo_loca_father_id nuvdepa
      ,l.geograp_location_id nuvloca
      ,s.sesuesco estado_corte
      ,s.sesususc contrato
      ,d.address_parsed direccion
      ,p.product_status_id estado_producto
      ,s.sesuesfn estado_financiero
      ,d.neighborthood_id barrio
      ,u.suscclie cliente
      ,cl.subscriber_name
      ,cl.subs_last_name
      ,cl.subs_second_last_name
      ,s.sesusafa
      ,se.operating_sector_id nuvsector
      ,d.estate_number predio
      ,d.is_urban
      ,p.suspen_ord_act_id ult_act_susp
  FROM
       open.servsusc      s
      ,open.suscripc      u
      ,open.ge_subscriber cl
      ,open.pr_product    p
      ,open.ab_address    d
      ,open.ab_segments   se
      ,ge_geogra_location l
WHERE s.sesususc              = u.susccodi
   AND s.sesunuse             = p.product_id
   AND u.susccodi             = p.subscription_id
   AND u.suscclie             = cl.subscriber_id
   AND p.address_id           = d.address_id
   AND d.segment_id           = se.segments_id
   AND d.geograp_location_id  = l.geograp_location_id
   AND mod(sesunuse,dald_parameter.fnuGetNumeric_Value('CIERRE_HILOS'))+1= 11;

 -- Cursor deuda corriente producto
 CURSOR cuiccartcoco(nucnuse ic_cartcoco.caccnuse%TYPE,dtcfech DATE) IS
  SELECT COUNT(DISTINCT c.cacccuco) ctaconsaldo
      ,MIN(c.caccfeve) fecha_vence
      ,MIN(c.cacccuco) cta_cob
      ,MAX(ldc_edad_mes(to_number(dtcfech-trunc(c.caccfeve)))) edad_mora
      ,SUM(decode(c.caccnaca,'N',c.caccsape,0)) saldo_cuenta
      ,SUM(decode(c.caccnaca,'F',c.caccsape,0)) saldo_cuenta_diferido
      ,SUM(decode(caccnaca,'N',decode(ldc_edad_mes(to_number(dtcfech-trunc(c.caccfeve))),0,c.caccsape,0),0)) novencida
      ,SUM(decode(c.caccnaca,'N',0,decode(caccplca,'C',c.caccsape,0))) diferida_corto
      ,SUM(decode(c.caccnaca,'N',0,decode(caccplca,'C',0,c.caccsape))) diferida_largo
  FROM ic_cartcoco c
 WHERE c.caccnuse = nucnuse
   AND c.caccfege = dtcfech;

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
nutotodifcorr        ic_cartcoco.caccsape%TYPE DEFAULT 0;
nutotodifnocorr      ic_cartcoco.caccsape%TYPE DEFAULT 0;
BEGIN
 nuerror := 0;
 sbmensa := NULL;
 error := 0;
 nucantiregcom := 0;
 nucantiregtot := 0;
 -- Borramos datos de la tabla sesucier para el a?o y mes a cerrar
 nuerror := -1;
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
      AND f.pefaactu = 'N'; --se cambia el = '-' por = 'N' para NO tomar los periodos de Facturaci?n Actual. el '-' indica periodo de fac cerrado
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
      nuerror := -5;
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
      nuerror := -6;
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
      nuerror := -7;
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
      nuerror := -8;
      FOR j IN cuiccartcoco(nunuse,dtfefifin) LOOP
        nuedadmor       := j.edad_mora;
        nuctacob        := j.cta_cob;
        nuctasconsaldo  := j.ctaConSaldo;
        nusaldtot       := nvl(j.saldo_cuenta,0);
        nutotdife       := j.saldo_cuenta_diferido; --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
        nutotodifcorr   := j.diferida_corto; --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
        nutotodifnocorr := j.diferida_largo; --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
        nusalnove       := j.novencida;
        IF NVL(nusaldtot,0) = 0 THEN
         nuedadmor := -1;
        END IF;
      END LOOP;
      -- Obtenemos la fecha de generacion de la ultima cuenta de cobro mas antigua con saldo
      nuerror := -9;
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
      nuerror := -10;
      IF dtfege IS NOT NULL THEN
       dtfege := trunc(dtfege);
       nuedaddeud := ldc_edad_mes(to_number(dtfefifin - dtfege));
      ELSE
       nuedaddeud := NULL;
      END IF;
      -- Calculamos deuda vencida
      nuerror := -11;
      nusalvenc  := nusaldtot - nusalnove;
      -- Obtenemos la deuda diferida o deuda no corriente
      nuerror    := -12;
      -- Obtenemos el centro de beneficio de la localidad y la categoria
      nuerror := -13;
      sbcebe := NULL;
      sbarserv := NULL;
      BEGIN
        SELECT cb.celocebe,ase.cebesegm INTO sbcebe,sbarserv
          FROM ldci_centbenelocal cb, ldci_centrobenef ase
         WHERE cb.celopais =cb.celopais
           AND cb.celodpto = v_array_cartcierre(i).depa
           AND cb.celoloca = v_array_cartcierre(i).loca
           AND cb.celocebe = ase.cebecodi;
      EXCEPTION
       WHEN OTHERS THEN
        sbcebe   := '-1';
        sbarserv := '-1';
      END;
       -- Consultamos valor en reclamo y pago no abonado del producto
       nuerror := -14;
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
  -- Registramos la informaci?n del producto a cierre
        nuerror := -15;
        INSERT INTO ldc_osf_sesucier_tmp11
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
          ,deuda_no_corriente --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
          ,deuda_diferida_corriente --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
          ,deuda_diferida_no_corriente --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
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
          ,ult_act_susp
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
          ,nvl(nutotdife,0) --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
          ,nvl(nutotodifcorr,0) --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
          ,nvl(nutotodifnocorr,0) --AZ Este campo es calculado con el cursor cuiccartcoco de acuerdo a sugerencia de Alex Beltran
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
          ,v_array_cartcierre(i).uasu
          );
         nuerror := -16;
         nucantiregcom := nucantiregcom + 1;
   END LOOP;
   COMMIT;
   EXIT WHEN cuservsusc%NOTFOUND;
  nuerror      := -17;
 END LOOP;
 COMMIT;
CLOSE cuservsusc;
   nuerror := -18;
   nucantiregtot := nucantiregcom;
   sbmensa := 'Proceso terminó Ok. Se procesaron '||to_char(nucantiregtot)||' registros.';
   error := 0;
   nuerror := -19;
EXCEPTION
WHEN err_fecha_per_conta THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenasesucier_h11 lineas error '||nuerror||' recuperando fecha periodo contable. '||sbmensa;
  error := -20;
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenasesucier_h11 lineas error '||nuerror||' producto '||nunuse||' '||sqlerrm;
  error := -21;
END;
/
