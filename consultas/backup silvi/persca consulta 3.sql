SELECT *
            FROM (
                SELECT sesususc,
                   sesunuse,
                   sesuesco,
                   sesucicl,
                   suspen_ord_act_id,
                   PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(s.sesunuse) DEPA,
                   PKG_BCPRODUCTO.FNUOBTENERLOCALIDAD(s.sesunuse ) LOCA,
                   1 pershilo
                FROM servsusc              s,
                     pr_product            p,
                     pr_prod_suspension    ps,
                     ldc_proceso_actividad lpa
                WHERE s.sesuesco IN
                    (
                        1,3,6,5
                    )
                 AND p.product_status_id IN
                    (
                        2
                    )
                 AND ps.suspension_type_id IN
                    (
                       2,5
                    )
             --    AND s.sesucicl = decode(nuciclo, -1, s.sesucicl, nuciclo)
                 AND sesuserv = 7014--inuServ
                 and ps.ACTIVE ='Y'
                 AND p.product_id = s.sesunuse
                 AND p.product_id = ps.product_id
                 AND p.suspen_ord_act_id IS NOT NULL
                 AND 0 = (SELECT count(1)
                            FROM ldc_susp_persecucion, or_order
                           WHERE susp_persec_producto = sesunuse
                             AND susp_persec_order_id = order_id
                             AND order_status_id IN (0, 5, 7)) --200-2614
                 AND 0 = (SELECT count(1)
                            FROM ldc_susp_persecucion
                           WHERE susp_persec_producto = s.sesunuse
                             AND susp_persec_order_id IS NULL)
                 AND lpa.proceso_id = 3--nuldc_proceso_id
                 AND lpa.activity_id =
                     pkg_bcordenes.fnuObtieneItemActividad(suspen_ord_act_id)
                 AND NOT EXISTS(  SELECT 'X'
                                  FROM or_order_activity, or_order, ldc_actividad_generada
                                  WHERE or_order_activity.product_id = p.product_id
                                     AND or_order_activity.order_id = or_order.order_id
                                     AND order_status_id IN (0, 5, 7) --200-2614
                                     AND or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                       AND ldc_actividad_generada.activity_id_generada = lpa.activity_id -- Inicia NC 3468.
                                    )
               -- AND sesunuse = inuProductId

              ) WHERE DEPA = 8978--DECODE(inuDepa, -1, depa, inudepa)
                AND loca = 9265;--DECODE(inuLoca, -1, loca, inuLoca);
