--Cargos por servicio
select cc.cucofact FACTURA,
       (select p.proccons || ' - ' || p.procdesc
          from procesos p
         where p.proccons = f.factprog) Programa,
       cargcuco "Cuenta de cobro",
       sesususc "Contrato",
       sesuserv "Tipo de producto",
       cargnuse "Producto",
       sesuesco || ' - ' || initcap(escodesc) "Estado_corte",
       pr.product_status_id || ' - ' || initcap(ps.description) "Estado_producto",
       cargconc || '  -' || initcap(concdesc) as "Concepto", /*concclco || '  - ' || initcap(clcodesc ) "Clasificador contable" ,*/
       cargcaca "Causal",
       cargunid "unidades",
       cargsign "Signo",
       cargtipr "Tipo",
       cargpefa "Periodo fact",
       cargpeco "Periodo cons",
       cargvalo
       --decode (cargsign, 'CR', - cargvalo, 'DB', cargvalo, 'SA', cargvalo, 'AS', - cargvalo, cargvalo) "Valor",
       --decode (cargsign, 'CR', - cargunid, 'DB', cargunid, 'SA', cargunid, 'AS', - cargunid, cargunid) "Unidades"
       ,
       cargcodo    "Consecutivo",
       cargdoso    "Documento soporte",
       cargprog    "Programa cargos",
       cargfecr    "Fecha cargos",
       pc.pecsfeci
--cargos.*
  from open.cargos
  left join open.servsusc
    on cargnuse = sesunuse
  left join open.concepto
    on cargconc = conccodi
  left join open.ic_clascont
    on concclco = clcocodi
  left join open.estacort
    on escocodi = sesuesco
  left join open.pr_product pr
    on cargnuse = product_id
  left join open.ps_product_status ps
    on ps.product_status_id = pr.product_status_id
  left join open.pericose pc
    on cargpeco = pc.pecscons
  left join cuencobr cc
    on cc.cucocodi = cargos.cargcuco
  left join factura f
    on f.factcodi = cc.cucofact
 where
--cc.cucofact = 2024868429
 sesususc in (67504378)
 --and trunc(cargfecr) = '30/01/2024' --sysdate - 10
 ORDER BY cargfecr DESC;
--select * from sa_user a where a.user_id in (1, 5423)
--Cargos por solicitud
/*select ab.package_type_id Tipo, ab.package_id Solicitud, ab.subscription_id Contrato, ab.product_id Producto from 
(SELECT \*+  INDEX(PK_MO_PACKAGES a),
            INDEX(IDX_MO_PACKAGES_024 a),
            INDEX(IDX_MO_MOTIVE_02 b)
            *\
        a.package_type_id, a.package_id, b.subscription_id, b.product_id
        FROM open.mo_packages a, open.mo_motive b
        WHERE b.package_id = a.package_id
        AND a.package_type_id = 271
        AND a.motive_status_id = 14
        AND EXISTS (SELECT \*+ INDEX(IDX_MO_MOT_PROMOTION01 c)*\
                            1
                    FROM open.mo_mot_promotion c
                    WHERE c.motive_id = b.motive_id
                    AND c.promotion_id in (SELECT column_value
                                            from table(open.ldc_boutilities.splitstrings
                                            (&isbPromDctoVta,','))))
        AND EXISTS (SELECT \*+ INDEX(PK_CC_SALES_FINANC_COND e)*\
                            1
                    FROM cc_sales_financ_cond e
                    WHERE e.package_id = a.package_id
                    AND e.quotas_number = 1)
        AND NOT EXISTS (SELECT \*+  INDEX(IX_CARG_NUSE_CUCO_CONC a),
                                    INDEX(IX_CARGOS01 a),
                                    INDEX(IX_CARGOS010 a)*\
                                1
                        FROM cargos f
                        WHERE f.cargnuse = b.product_id
                        AND f.cargconc = &inuConcNotaDcto
                        AND f.cargsign = 'DB'
                        AND substr(f.cargdoso,1,3) = 'ND-')
        AND a.messag_delivery_date >= &idtInitDate
        --and rownum = 1
        UNION ALL
        SELECT \*+ INDEX(PK_MO_PACKAGES a),
            INDEX(IDX_MO_PACKAGES_024 a),
            INDEX(IDX_MO_MOTIVE_02 b)*\
        a.package_type_id, a.package_id, b.subscription_id, b.product_id
        FROM mo_packages a, mo_motive b
        WHERE b.package_id = a.package_id
        AND a.package_type_id = 100229
        AND a.motive_status_id = 14
        AND EXISTS (SELECT 1
                    FROM cc_quotation c, cc_quot_financ_cond d
                    WHERE d.quotation_id = c.quotation_id
                    AND c.package_id = a.package_id
                    AND c.status = 'C'
                    AND c.discount_percentage > 0
                    AND d.quotas_number = 1)
        AND EXISTS (SELECT 1
                    FROM cc_quotation c, cc_quotation_item d
                    WHERE d.quotation_id = c.quotation_id
                    AND c.package_id = a.package_id
                    AND d.unit_discount_value > 0
                    AND c.status = 'C'
                    AND c.discount_percentage > 0)
        AND EXISTS (SELECT 1
                    FROM cc_sales_financ_cond e
                    WHERE e.package_id = a.package_id
                    AND e.quotas_number = 1)
        AND NOT EXISTS (SELECT \*+  INDEX(IX_CARG_NUSE_CUCO_CONC a),
                                    INDEX(IX_CARGOS01 a),
                                    INDEX(IX_CARGOS010 a)*\
                                1
                        FROM cargos f
                        WHERE f.cargnuse = b.product_id
                        AND f.cargconc = &inuConcNotaDcto
                        AND f.cargsign = 'DB'
                        AND substr(f.cargdoso,1,3) = 'ND-')
        AND a.messag_delivery_date >= &idtInitDate
        --and rownum = 1
        ) AB;

*/
