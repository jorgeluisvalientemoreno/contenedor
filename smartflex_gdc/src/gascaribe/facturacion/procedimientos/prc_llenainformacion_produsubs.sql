create or replace procedure prc_llenainformacion_produsubs IS
   csbMetodo       VARCHAR2(2000) := 'PRC_LLENAINFORMACION_PRODUSUBS';
   csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
   nuError         NUMBER;
   sbError         VARCHAR2(2000);   
   sbProceso  VARCHAR2(100) := csbMetodo||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
   
   CURSOR cuObtInfoSubsNormal IS
  --subsidio normal
    WITH periodo AS (
      SELECT  *
      FROM open.perifact F
      INNER JOIN open.pericose C ON C.pecsfecf BETWEEN F.pefafimo AND F.pefaffmo
                            AND C.pecscico = F.pefacicl
          WHERE (pefaano*100)+pefames BETWEEN 202207 AND 202412-->= 202207
    ),
    rangos_liquidados AS (
        SELECT cargsign signo, pecsfecf fecha_consumo ,cargpeco, R.raliidre vigencia_taco,  R.ralisesu, R.ralipeco, pecscons, pefacodi, pefaano, pefames, pefacicl,
             ( SELECT max(csu.cargunid)
              FROM OPEN.cargos csu 
              WHERE csu.cargcuco = C.cargcuco
                AND  C.cargpefa =  csu.cargpefa
                AND  C.cargpeco =  csu.cargpeco                
                AND csu.cargconc =  196
                )
            unidades, 
            raliunli,
        ralivaul, ralivasu, raliporc, ralivalo, (ralivaul-ralivasu)/raliunli, 'SIN TT', c.cargcodo, C.cargcuco
        FROM open.rangliqu R
             INNER JOIN periodo ON pefacodi = ralipefa
             JOIN open.cargos  c ON c.cargnuse = ralisesu and ralicodo = cargcodo and cargconc = 31
        WHERE raliconc = 31
        AND   R.raliliir = 0
        AND   R.ralilisr = 20)        
    SELECT  tacocr03 mercado, 
            ( SELECT ab_address.geograp_location_id 
              FROM open.ab_address 
              WHERE ab_address.address_id = pr_product.address_id ) localidad,
            sesucate categoria_actual,
            sesusuca subcategoria_actual,
            pr_product.product_status_id  estado_producto,
            sesuesco estado_corte,    
            ralisesu producto, 
            sesususc contrato,
            pefacodi periodo_facturacion,         
            decode(signo, 'DB', 1, -1) * round(  unidades * tmp_tarifas_subs_actualizadas.diferencia  ,0) valor_ajuste,
            tmp_tarifas_subs_actualizadas.concepto concepto,
            ralipeco periodo_consumo,
            fecha_consumo,
            pefaano anio, 
            pefames mes,       
            pefacicl ciclo,        
            unidades unidades_liquidada,           
            ralivasu valor_subsidio,
           decode(unidades, 0, 0, (ralivasu/unidades)) tarifa_subs,
           tacocr02 categoria_tarifa, 
           tacocr01 subcategoria_tarifa, 
           tmp_tarifas_subs_actualizadas.tarifafacturada,
           tmp_tarifas_subs_actualizadas.tarifaactualizada,
           tmp_tarifas_subs_actualizadas.diferencia  diferencia,
           decode(signo, 'DB', 'CR', 'DB') signo,
           tmp_tarifas_subs_actualizadas.anoperiodo anio_tarifa,
           tmp_tarifas_subs_actualizadas.mesperiodo mes_tarifa,
            CASE WHEN NVL(unidades,0) = 0 THEN 'N' ELSE 'S' END marca_subsidio,
          decode(signo, 'DB', 1, -1) * round(  raliunli * tmp_tarifas_subs_actualizadas.diferencia  ,0) valor_ajuste_unrang ,
          raliunli
    FROM ta_vigetaco, ta_tariconc, tmp_tarifas_subs_actualizadas, rangos_liquidados, servsusc, pr_product
    WHERE ta_vigetaco.vitccons = rangos_liquidados.vigencia_taco
     AND ta_vigetaco.vitctaco = ta_tariconc.tacocons
     AND tmp_tarifas_subs_actualizadas.idmercadorelevante = ta_tariconc.tacocr03
     AND tmp_tarifas_subs_actualizadas.categoria = ta_tariconc.tacocr02
     AND tmp_tarifas_subs_actualizadas.subcategoria = ta_tariconc.tacocr01
     AND tmp_tarifas_subs_actualizadas.concepto = 196
     AND tmp_tarifas_subs_actualizadas.anoperiodo = to_char(ta_vigetaco.vitcfefi,'yyyy')  
     AND tmp_tarifas_subs_actualizadas.mesperiodo = to_char(ta_vigetaco.vitcfefi,'mm')
     AND servsusc.sesunuse = rangos_liquidados.ralisesu
     AND pr_product.product_id = servsusc.sesunuse
     AND tmp_tarifas_subs_actualizadas.diferencia > 0;
     
    TYPE tblSubsidio  IS TABLE OF cuObtInfoSubsNormal%ROWTYPE;
    v_tblSubsidio   tblSubsidio;
    
    --subsidio transitoria
   CURSOR cuObtInfoSubsOTT IS
   WITH periodo AS (
      SELECT  *
      FROM perifact F
      INNER JOIN pericose C ON C.pecsfecf BETWEEN F.pefafimo AND F.pefaffmo
                            AND C.pecscico = F.pefacicl
      WHERE (pefaano*100)+pefames BETWEEN 202207 AND 202412-->= 202207
    ),
    rangos_liquidados AS (
        SELECT pecsfecf fecha_consumo , R.raliidre vigencia_taco,  R.ralisesu, R.ralipeco, pecscons, pefacodi, pefaano, pefames, pefacicl, raliunli, ralivaul, ralivasu, raliporc, ralivalo, (ralivaul-ralivasu)/raliunli, 'SIN TT'
        FROM rangliqu R
             INNER JOIN periodo ON pefacodi = ralipefa --AND pecscons = ralipeco
             JOIN cargos ON cargos.cargnuse = ralisesu and ralicodo = cargcodo and cargconc = 31
        WHERE raliconc = 31
        AND   R.raliliir = 0
        AND   R.ralilisr = 20),
    Productos_liquidados as (
    SELECT   tacocr03 mercado, 
            ( SELECT ab_address.geograp_location_id 
              FROM ab_address 
              WHERE ab_address.address_id = pr_product.address_id ) localidad,
            sesucate categoria_actual,
            sesusuca subcatgeoria_actual,
            pr_product.product_status_id  estado_producto,
            sesuesco estado_corte,    
            ralisesu producto, 
            sesususc contrato,
            pefacodi periodo_facturacion, 
            round(raliunli * diferencia,0) valor_ajuste,
            tmp_tarifas_subs_actualizadas.concepto concepto,
            ralipeco periodo_consumo,
            fecha_consumo,
            pefaano anio, 
            pefames mes, 
            pefacicl ciclo,        
            raliunli unidades_liquidada,
            ralivasu valor_subsidio,
           (ralivasu/raliunli) tarifa_subs,
           tacocr02 categoria_tarifa, 
           tacocr01 subcategoria_tarifa, 
           tmp_tarifas_subs_actualizadas.tarifafacturada,
           tmp_tarifas_subs_actualizadas.tarifaactualizada,
           tmp_tarifas_subs_actualizadas.diferencia,
           tmp_tarifas_subs_actualizadas.anoperiodo,
           tmp_tarifas_subs_actualizadas.mesperiodo           
    FROM ta_vigetaco, ta_tariconc, tmp_tarifas_subs_actualizadas, rangos_liquidados, servsusc, pr_product
    WHERE ta_vigetaco.vitccons = rangos_liquidados.vigencia_taco
     AND ta_vigetaco.vitctaco = ta_tariconc.tacocons
     AND tmp_tarifas_subs_actualizadas.idmercadorelevante = ta_tariconc.tacocr03
     AND tmp_tarifas_subs_actualizadas.categoria = ta_tariconc.tacocr02
     AND tmp_tarifas_subs_actualizadas.subcategoria = ta_tariconc.tacocr01
     AND tmp_tarifas_subs_actualizadas.concepto = 167
     AND tmp_tarifas_subs_actualizadas.anoperiodo = to_char(ta_vigetaco.vitcfefi,'yyyy')  
     AND tmp_tarifas_subs_actualizadas.mesperiodo = to_char(ta_vigetaco.vitcfefi,'mm')
     AND servsusc.sesunuse = rangos_liquidados.ralisesu
     AND pr_product.product_id = servsusc.sesunuse
     AND tmp_tarifas_subs_actualizadas.diferencia > 0)
     SELECT mercado, 
           localidad, categoria_actual, subcatgeoria_actual, 
           estado_producto, estado_corte, producto, contrato,
           periodo_facturacion,         
           decode(DPTTSIGN, 'CR', -1, 1) * round(dpttunid * diferencia,0) valor_ajuste, 
           concepto, periodo_consumo, fecha_consumo, anio, mes, ciclo,
           dpttunid unidades_liquidada, ldc_deprtatt.dpttvano valor_subsidio, ldc_deprtatt.DPTTTATT tarifa_subs,
           categoria_tarifa, subcategoria_tarifa, 
           tarifafacturada,
           tarifaactualizada, 
           diferencia ,
           DPTTSIGN signo,
           anoperiodo,
           mesperiodo,
           'S' marca,
            decode(DPTTSIGN, 'CR', -1, 1) * round(unidades_liquidada * diferencia,0) valor_ajuste_rang,
            unidades_liquidada unidad_rango
     FROM Productos_liquidados
      JOIN ldc_deprtatt ON ldc_deprtatt.dpttsesu = Productos_liquidados.producto 
                            AND ldc_deprtatt.dpttperi =Productos_liquidados.periodo_facturacion
                            AND ldc_deprtatt.dpttpeco = Productos_liquidados.periodo_consumo
                            AND ldc_deprtatt.dpttconc = 167;
    
   
   TYPE tblSubsidioOTT  IS TABLE OF cuObtInfoSubsOTT%ROWTYPE;
   v_tblSubsidioOTT   tblSubsidioOTT;
    
   errors NUMBER;
   dml_errors EXCEPTION;
   PRAGMA EXCEPTION_INIT(dml_errors, -24381);
   nuIdReporte  number;
   nuConsecutivo NUMBER := 0;
   
BEGIN
   pkg_estaproc.prinsertaestaproc( sbProceso , 0);
   nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'LLENAPRSU',
                                                        'Job que llena informacion de subsidio');
   pkg_traza.trace(' nuIdReporte => ' || nuIdReporte, pkg_traza.cnuNivelTrzDef);
   execute immediate 'truncate table tmp_producto_procsub';
   OPEN cuObtInfoSubsNormal;
   LOOP
 	FETCH cuObtInfoSubsNormal BULK COLLECT INTO v_tblSubsidio LIMIT 100;
      BEGIN
          FORALL i IN v_tblSubsidio.FIRST..v_tblSubsidio.LAST SAVE EXCEPTIONS
              INSERT INTO tmp_producto_procsub values v_tblSubsidio(i); 
      EXCEPTION
        WHEN dml_errors THEN
          errors := SQL%BULK_EXCEPTIONS.COUNT;
          FOR i IN 1..errors LOOP
             nuConsecutivo := nuConsecutivo + 1;
             pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                   SQL%BULK_EXCEPTIONS(i).ERROR_INDEX,
                                                   'Error #' || i || ' occurred during '||SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE),
                                                   'S',
                                                   nuConsecutivo );
 
          END LOOP;
       END;
       COMMIT;
    EXIT   WHEN cuObtInfoSubsNormal%NOTFOUND;
   END LOOP;
  CLOSE cuObtInfoSubsNormal;
  COMMIT;
  --subsidio transitorio
   OPEN cuObtInfoSubsOTT;
   LOOP
 	FETCH cuObtInfoSubsOTT BULK COLLECT INTO v_tblSubsidioOTT LIMIT 100;
      BEGIN
          FORALL i IN v_tblSubsidioOTT.FIRST..v_tblSubsidioOTT.LAST SAVE EXCEPTIONS
              INSERT INTO tmp_producto_procsub values v_tblSubsidioOTT(i); 
      EXCEPTION
        WHEN dml_errors THEN
          errors := SQL%BULK_EXCEPTIONS.COUNT;
          FOR i IN 1..errors LOOP
             nuConsecutivo := nuConsecutivo + 1;
             pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                   SQL%BULK_EXCEPTIONS(i).ERROR_INDEX,
                                                   'Error #' || i || ' occurred during '||SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE),
                                                   'S',
                                                   nuConsecutivo );
 
          END LOOP;
       END;
       COMMIT;
    EXIT   WHEN cuObtInfoSubsOTT%NOTFOUND;
   END LOOP;
  CLOSE cuObtInfoSubsOTT;
  COMMIT;
  pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION    
  WHEN pkg_Error.Controlled_Error  THEN
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_error.getError(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        pkg_EstaProc.prActualizaEstaproc ( sbProceso, 'Error ', sbError );
        RAISE pkg_Error.Controlled_Error;
END prc_llenainformacion_produsubs;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PRC_LLENAINFORMACION_PRODUSUBS', 'OPEN');
END;
/
