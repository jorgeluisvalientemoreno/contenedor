WITH minCuCoRecl AS
            (
                SELECT ccm.cuconuse, MIN(cucocodi) cucocodi
                FROM cuencobr ccm
                WHERE (nvl( ccm.cucovare,0 ) + nvl(ccm.cucovrap,0)) > 0
                AND ccm.cucofeve < sysdate
                GROUP BY ccm.cuconuse
            ),
            minCuCoNoVenc AS
            (
                SELECT ccnv.cuconuse, MIN(cucocodi) cucocodi
                FROM cuencobr ccnv
                WHERE ccnv.cucofeve > sysdate
                GROUP BY ccnv.cuconuse
            )
            SELECT minCuCoRecl.cucocodi,
                    minCuCoNoVenc.cucocodi,
                    od.order_id
            FROM or_order             od,
                 gc_coll_mgmt_pro_det x,
                 pr_product           pr,
                 ldc_osf_sesucier     ci,
                 ((SELECT to_number(regexp_substr(:sbTt_Gc_Cartera,
                                    '[^,]+',
                                    1,
                                    LEVEL)) AS columna
                   FROM dual
                   CONNECT BY regexp_substr(:sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt,
                minCuCoRecl,
                minCuCoNoVenc
            WHERE od.task_type_id = tt.columna
             AND trunc(od.created_date) BETWEEN :dtcufein AND :dtcufefi
             AND od.order_id = x.order_id
             --AND od.ORDER_STATUS_ID = 5
             AND x.product_id = pr.product_id
             AND x.product_id  = :nuProducto
             AND od.operating_unit_id in
                 (select distinct unidad_operativa
                    from ldc_metas_cont_gestcobr r
                   where r.ano = :nuanoact
                     and r.mes = :numesact
                     and r.meta_usuarios > 0
                     and r.meta_deuda > 0
                     and r.tarifa_usuario is not null
                     and r.tarifa_cartera is not null)
             AND nuano = :nuanoact
             AND numes = :numesact
             AND ci.producto = x.product_id
             AND ci.edad > :nuEdadMora
             AND ci.area_servicio = ci.area_servicio
             AND (ci.estado_financiero <> 'C' OR (ci.estado_financiero = 'C' AND (SELECT SESUESFN FROM SERVSUSC WHERE SESUNUSE = x.product_id) <> 'C'))
             AND SUBSTR(TO_CHAR(od.order_id), LENGTH(TO_CHAR(od.order_id) - 1), 1) =
                 TO_CHAR(:INUHILO)
            AND minCuCoRecl.cuconuse = pr.product_id
            AND minCuCoNoVenc.cuconuse(+) = pr.product_id
            and NOT EXISTS
            (
                SELECT '1'
                FROM cuencobr cci
                WHERE cci.cuconuse = pr.product_id
                AND cci.cucocodi > minCuCoRecl.cucocodi
                AND cci.cucocodi < nvl(minCuCoNoVenc.cucocodi,9999999999999999)
                AND (cci.cucovato - nvl(cci.cucovaab,0) - nvl(cci.cucovare,0) - nvl(cci.cucovrap,0)) > 0
                AND (sysdate - cci.cucofeve ) > :nuEdadMora
            )
