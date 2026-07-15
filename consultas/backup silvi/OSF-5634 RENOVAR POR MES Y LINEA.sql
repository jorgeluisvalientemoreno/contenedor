SELECT /*+ index (p IDX_LD_POLICY_01)*/
                    COUNT(1)
            FROM    ld_policy p, contrato c
            WHERE   TO_NUMBER(SUBSTR(collective_number, 3, 4)) = inuMes
            AND     state_policy = 1
            AND     product_line_id = nvl(inuLineaProducto, product_line_id)
            AND     p.suscription_id = c.contrato
            AND     c.empresa = isbCodEmpresa
            AND NOT EXISTS (SELECT  /*+ use_nl(c s)
                                        index(c IDX_LD_SECURE_CANCELLA_02)
                                        index(s PK_MO_PACKAGES)
                                    */ 'x'
                            FROM    ld_secure_cancella c, mo_packages s
                            WHERE   p.policy_id = c.policy_id
                            AND     c.secure_cancella_id = s.package_id
                            AND     s.motive_status_id = 13);
