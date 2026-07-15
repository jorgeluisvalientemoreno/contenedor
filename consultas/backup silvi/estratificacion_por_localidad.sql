 SELECT a.modo
    FROM ldc_tipo_metod_estrat a,ldc_tipo_metod_estrat_loc b
   WHERE a.codigo    = b.codigo_metodologia
     AND b.localidad =9104
