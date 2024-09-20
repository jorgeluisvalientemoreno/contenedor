ALTER SESSION SET CURRENT_SCHEMA= "OPEN";
SELECT (SELECT geo.geo_loca_father_id FROM OPEN.ge_geogra_location geo WHERE geo.geograp_location_id =ldcii.geograp_location_id) depto,
       (SELECT geo.description FROM OPEN.ge_geogra_location geo WHERE geo.geograp_location_id = (SELECT geo.geo_loca_father_id FROM OPEN.ge_geogra_location geo WHERE geo.geograp_location_id =ldcii.geograp_location_id)) descdepto,
       ldcii.geograp_location_id codigo, 
       (SELECT geo.description FROM OPEN.ge_geogra_location geo WHERE geo.geograp_location_id =ldcii.geograp_location_id) localidad,
        ldcii.clas_contable clasificador, (SELECT icl.clcodesc FROM OPEN.ic_clascont icl WHERE icl.clcocodi = ldcii.clas_contable) desc_clas,
        ldcii.type_activity actividad,ldcii.items_id item, (SELECT description FROM OPEN.ge_items gi WHERE gi.items_id = ldcii.items_id) items,
        (SELECT descripcion||' ; '||porcentaje||' ; '||tipo_retencion FROM OPEN.ldc_tipo_actividad tc WHERE tc.tipo_actividad_id = ldcii.type_activity),
        (SELECT itemtire||' ; '||iteminre||' ; '||itemcate FROM OPEN.ldci_intemindica WHERE itemcodi = ldcii.items_id
        AND itemclco = ldcii.clas_contable) indicadores  
FROM OPEN.ldc_parametros_ica ldcii;



SELECT 
        ldcs.clas_contable, (SELECT icl.clcodesc FROM OPEN.ic_clascont icl WHERE icl.clcocodi = ldcs.clas_contable) desc_clas,
        ldcs.activity_id, ldcs.items_id item, (SELECT description FROM OPEN.ge_items gi WHERE gi.items_id = ldcs.items_id) items,
        ldcs.type_, (SELECT itemtire||' ; '||iteminre||' ; '||itemcate FROM OPEN.ldci_intemindica WHERE itemcodi = ldcs.items_id
        AND itemclco = ldcs.clas_contable) indicadores
FROM OPEN.ldc_construction_service ldcs;
