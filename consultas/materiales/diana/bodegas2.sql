select * from open.ldc_act_ouib a where a.operating_unit_id= 3015 and a.items_id=10000278;
--select * from open.ldc_act_uibm a where a.operating_unit_id= 3015 and a.items_id=10000278;
select * from open.ldc_inv_ouib a where a.operating_unit_id= 3015 and a.items_id=10000278;
--select * from open.ldc_inv_uibm a where a.operating_unit_id= 3015 and a.items_id=10000278;
select * from OPEN.OR_OPE_UNI_ITEM_BALA a where a.operating_unit_id= 3015 and a.items_id=10000278;
select * from open.or_uni_item_bala_mov where operating_unit_id=3015 and items_id=10000278;
select * from OPEN.LDC_TT_TB where task_type_id=12335;
SELECT * FROM OPEN.LDC_OSF_LDCRBAI  WHERE COD_UNID_OPER=3225 AND COD_ITEM=10004070
select * from open.LDCI_CONTESSE 10010311
 --validar convertir serial a osf
--items requisiciones automaticas
select * from open.LDC_SALITEMSUNIDOP
SELECT sum(total_costs) FROM OPEN.ldc_osf_salbitemp where nuano=2019 and numes=8;
SELECT item, tipo, unidadOperativa, cupo, existencia, valor
FROM (
SELECT tipo, item, unidadOperativa, cupo, existencia, valor
FROM (
SELECT  '01 - GENERAL' tipo
        , items_id item
        , operating_unit_id unidadOperativa
        , quota * (-1) cupo
        , balance * (-1) existencia
        , total_costs * (-1) valor
FROM open.or_ope_uni_item_bala
WHERE  operating_unit_id IN (3315,3016)
        AND items_id IN (10000971)
UNION
SELECT  '02 - INVENTARIO' tipo
        , items_id item
        , operating_unit_id unidadOperativa
        , quota cupo
        , balance existencia
        , total_costs valor
FROM open.ldc_inv_ouib
WHERE  operating_unit_id IN (3315,3016)
        AND items_id IN (10000971)
UNION
SELECT  '03 - ACTIVO' tipo
        , items_id item
        , operating_unit_id unidadOperativa
        , quota cupo
        , balance existencia
        , total_costs valor
FROM open.ldc_act_ouib
WHERE  operating_unit_id IN (3316,3015)
        AND items_id IN (10000971)
--ORDER BY 3, 2
)
UNION ALL
SELECT tipo, item, unidadOperativa, 0 cupo, existencia, valor
FROM (
SELECT '04 - DIFERENCIA' tipo, item, unidadOperativa, SUM(existencia) existencia, SUM(valor) valor
FROM (
SELECT  'GENERAL' tipo
        , items_id item
        , operating_unit_id unidadOperativa
        , quota * (-1) cupo
        , balance * (-1) existencia
        , total_costs * (-1) valor
FROM open.or_ope_uni_item_bala
WHERE  operating_unit_id IN (3316,3015)
        AND items_id IN (10000971)
UNION
SELECT  'INVENTARIO' tipo
        , items_id item
        , operating_unit_id unidadOperativa
        , quota cupo
        , balance existencia
        , total_costs valor
FROM open.ldc_inv_ouib
WHERE  operating_unit_id IN (3316,3015)
        AND items_id IN (10000971)
UNION
SELECT  'ACTIVO' tipo
        , items_id item
        , operating_unit_id unidadOperativa
        , quota cupo
        , balance existencia
        , total_costs valor
FROM open.ldc_act_ouib
WHERE  operating_unit_id IN (3316,3015)
        AND items_id IN (10000971))
GROUP BY 'DIFERENCIA', item, unidadOperativa)
/*UNION
SELECT '05 - SERIALES' tipo, it.code item, gis.operating_unit_id unidadOperativa, 0 cupo, COUNT(*) existencia, MAX(gis.costo) valor
FROM  open.ge_items_seriado gis
      LEFT JOIN open.ge_items_estado_inv eis ON eis.id_items_estado_inv = gis.id_items_estado_inv
      LEFT JOIN open.ge_items it ON gis.items_id = it.items_id
      --LEFT JOIN open.ge_items_tipo_atr
WHERE it.item_classif_id IN (21)
      --AND gis.id_items_estado_inv = 1 -- Disponible
      -- AND it.id_items_tipo = 16 -- Sellos o 20 Medidores
      AND LENGTH(it.code) = 8 AND SUBSTR(it.code,1,4) = '1000'
      AND it.code IN ('10000013','10004081', '10004070', '10002011', '10000930')
      AND gis.operating_unit_id = 3316,799
GROUP BY '05 - SERIALES', it.code, gis.operating_unit_id, 0*/
)
ORDER BY item, tipo;




