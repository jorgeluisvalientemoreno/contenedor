   -- SC UNIFICADO
        select PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT,
               (SELECT lg.cuencosto from open.ldci_cugacoclasi lg
                 WHERE lg.cuenclasifi = CLASITT) CUENTA,
               (select cb.cuctdesc from open.ldci_cuentacontable cb
                 where cb.cuctcodi in (SELECT lg.cuencosto from open.ldci_cugacoclasi lg
                                        WHERE lg.cuenclasifi = CLASITT)
               ) nomcuenta,
               --cuenta,  nomcuenta,
               -- MIGRADOS
               SUM(ING_CXC_M) ING_CXC_M,
               SUM(ING_INT_M) ING_INT_M,
               SUM(ING_CER_M) ING_CER_M,
               -- CONSTRUCTORAS
               SUM(ING_CXC) ING_CXC,
               SUM(ING_INT) ING_INT,
               SUM(ING_CER) ING_CER,
               -- TOTAL INGRESO
               SUM(TOT_INGRE) TOT_INGRE
        from
        (
        -- Constructoras
        -- OSF-1402
        with base as
        (select /*+index(ca IX_CARG_NUSE_CUCO_CONC) */
                cargcuco, cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco, sum(cargvalo) cargvalo, sum(cargunid) cargunid
           from open.cargos ca, open.concepto o, open.servsusc
          where cargnuse =  sesunuse
            and cargcuco != -1
            and cargconc = conccodi
            and sesuserv =  6121
            and cargdoso like 'PP-%' -- || a.package_id
            and cargcaca in (53)
            and concclco in (4,19,400)
            and cargfecr <  '01-10-2023'
         group by cargcuco, cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco
         )
         ,cargo as (
         select cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco, sum(cargvalo) cargvalo, sum(cargunid) cargunid
          from base      
          inner join open.cuencobr c on c.cucocodi=base.cargcuco
          inner join open.factura f on f.factcodi=c.cucofact and f.factfege <  '01-10-2023'
          group by cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco
         )
        select 'CONSTRUCTORAS' TIPO, A.PRODUCT_ID, sesucate, cargconc, concclco clasificador, o2.order_id orden, o2.task_type_id TITR,
               (select tt.clctclco from open.ic_clascott tt where tt.clcttitr = o2.task_type_id) clasitt,
               CASE WHEN
                 concclco IN (4) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_CXC,
               CASE WHEN
                 concclco IN (19) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_INT,
               CASE WHEN
                 concclco IN (400) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_CER,
               0 ING_CXC_M,
               0 ING_INT_M,
               0 ING_CER_M,
               ((ca.cargvalo/ca.cargunid)) TOT_INGRE
          from open.or_order o2
         inner join open.ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
         inner join open.or_order_activity a ON a.order_id = o2.order_id
         inner join open.or_task_type tt ON tt.task_type_id = o2.task_type_id
         inner join open.mo_packages m ON m.package_id = a.package_id and m.package_type_id = 323
         inner join open.cargo ca ON cargdoso = 'PP-'||a.package_id and cargconc = tt.concept
         --inner join open.concepto ON conccodi = cargconc and concclco in (4,19,400)
         inner join open.servsusc sc ON sc.sesunuse = a.product_id
         inner join open.suscripc su ON su.susccodi = sc.sesususc
         inner join open.ab_address ab ON ab.address_id = su.susciddi
         where trunc(o2.legalization_date) >= &dtfefein --'01-03-2019'
           and trunc(o2.legalization_date) <= &dtfefefin --'01-04-2019'
           and o2.order_status_id = 8
        --   and trunc(o2.created_date ) <   &dtfefefin + 1
           and (
                (o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                 FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo FROM OPEN.LDCI_CARASEWE C
                                                                                 WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_INTERNA'),',') )) and
                 concclco in (19) and -- Interna
                 a.product_id not in (select act.product_id
                                        from open.or_order_activity act, open.or_order oo
                                       where act.product_id = a.product_id
                                         and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                   FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                                             FROM OPEN.LDCI_CARASEWE C
                                                                                                            WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_OT_APOYO'),',') ))
                                         and act.order_id = oo.order_id
                                         and oo.legalization_date < to_date((SELECT casevalo
                                                                               FROM OPEN.LDCI_CARASEWE C
                                                                              WHERE C.CASECODI = 'FECHA_FIN_ORDEN_DE_APOYO'))
                                     )
                )
              OR
                (
                  o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                        FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                FROM OPEN.LDCI_CARASEWE C
                                                                               WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_C_X_C'),',') )) and
                  concclCo = 4 -- cxc
                )
              OR
                (
                  o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                        FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                FROM OPEN.LDCI_CARASEWE C
                                                                               WHERE C.CASECODI = 'TIPO_DE_TRABAJO_CERTIF_PREVIA'),',')) ) and
                  concclco = 400 -- Cert Previa
                )
               )
           AND o2.order_id not in (select oo.related_order_id
                                     from open.OR_related_order oo
                                    where oo.related_order_id = o2.order_id
                                      and oo.rela_order_type_id in (13,14)
                                  )
           AND a.product_id NOT IN (SELECT hcecnuse
                                      FROM open.hicaesco h
                                     WHERE hcecfech < to_date((SELECT casevalo
                                                                 FROM OPEN.LDCI_CARASEWE C
                                                                WHERE C.CASECODI = 'FECHA_INICIO_INGRESO_X_ORDEN'))
                                       AND hcecnuse = a.product_id
                                       AND hcececan = 96
                                       AND hcececac = 1
                                       AND hcecserv = 7014)
        --
        UNION ALL
        --
        -- Consulta Servicio Cumplido Migrado
        select 'MIGRADOS' TIPO,  A.PRODUCT_ID, sesucate, conccodi, concclco clasificador, o2.order_id, o2.task_type_id TITR,
               (select tt.clctclco from open.ic_clascott tt where tt.clcttitr = o2.task_type_id) clasitt,
               0 ING_CXC,
               0 ING_INT,
               0 ING_CER,
               CASE WHEN
                 concclco IN (4) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_CXC_M,
               CASE WHEN
                 concclco IN (19) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_INT_M,
               CASE WHEN
                 concclco IN (400) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_CER_M,
               (mi.invmvain) TOT_INGRE
         from open.or_order o2
         inner join open.ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
         inner join open.or_order_activity a ON a.order_id = o2.order_id
         inner join open.mo_packages m on m.package_id = a.package_id and m.package_type_id = 100271 -- 323
         inner join open.Ldci_Ingrevemi mi ON mi.invmsesu = a.product_id
         inner join open.concepto o ON conccodi = mi.invmconc
         inner join open.servsusc sc ON sc.sesunuse = a.product_id
         inner join open.suscripc su ON su.susccodi = sc.sesususc
         inner join open.ab_address ab ON ab.address_id = su.susciddi
         where trunc(o2.legalization_date) >= &dtfefein -- '01-03-2019'
           and trunc(o2.legalization_date) < &dtfefefin --'01-04-2019'
           and o2.order_status_id = 8
        --   and trunc(o2.created_date ) <=  '01-03-2019' --&dtfefefin
           and (
                  (o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                         FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo FROM OPEN.LDCI_CARASEWE C
                                                                                         WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_INTERNA'),',') )) and
                   concclco in (19) and -- Interna
                   a.product_id not in (select act.product_id
                                           from open.or_order_activity act, open.or_order oo
                                          where act.product_id = a.product_id
                                            and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                     FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                                                     FROM OPEN.LDCI_CARASEWE C
                                                                                                                    WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_OT_APOYO'),',') ))
                                            and act.order_id = oo.order_id
                                            and oo.legalization_date < to_date((SELECT casevalo
                                                                                  FROM OPEN.LDCI_CARASEWE C
                                                                                 WHERE C.CASECODI = 'FECHA_FIN_ORDEN_DE_APOYO'))
                                        )
                  )

              OR
                (
                 o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM OPEN.LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_C_X_C'),',') )) and
                 concclCo = 4 -- cxc
                )
              OR
                (
                 o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM OPEN.LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPO_DE_TRABAJO_CERTIF_PREVIA'),',')) ) and
                 concclco = 400 -- Cert Previa
                )

              )
           AND o2.order_id not in (select oo.related_order_id
                                     from open.OR_related_order oo
                                    where oo.related_order_id = o2.order_id
                                      and oo.rela_order_type_id in (13,14)
                                  )
           AND a.product_id NOT IN (SELECT hcecnuse
                                      FROM open.hicaesco h
                                     WHERE hcecfech < to_date((SELECT casevalo
                                                                 FROM OPEN.LDCI_CARASEWE C
                                                                WHERE C.CASECODI = 'FECHA_INICIO_INGRESO_X_ORDEN'))
                                       AND hcecnuse = a.product_id
                                       AND hcececan = 96
                                       AND hcececac = 1
                                       AND hcecserv = 7014)
        ) GROUP BY PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT
