INSERT INTO GC_COLL_MGMT_PRO_DET (COLL_MGMT_PRO_DET_ID,
                               ORDER_ID,
                              EXEC_PROCESS_NAME,
                              COLL_MGMT_PROC_CR_ID,
                              IS_LEVEL_MAIN,
                              SUBSCRIBER_ID,
                              SUBSCRIPTION_ID,
                              PRODUCT_ID,
                              DEBT_AGE,
                              TOTAL_DEBT,
                              OUTSTANDING_DEBT,
                              OVERDUE_DEBT,
                              DEFERRED_DEBT,
                              PUNI_OVER_DEBT,
                              REFINANCI_TIMES,
                              FINANCING_PLAN_ID,
                              TOTAL_DEBT_CURRENT)
                        select seq_gc_coll_mgmt_pr_275315.nextval,
                              o.order_id,
                              'GCORECA',
                              47,
                              'N',
                              CLIENTE,
                              CONTRATO,
                              producto,
                              EDAD,
                              (DEUDA_CORRIENTE_NO_VENCIDA+DEUDA_CORRIENTE_VENCIDA+DEUDA_NO_CORRIENTE) TOTAL,
                              DEUDA_CORRIENTE_NO_VENCIDA,
                              DEUDA_CORRIENTE_VENCIDA,
                              DEUDA_NO_CORRIENTE,
                              nvl(VALOR_CASTIGADO,0) VALOR_CASTIGADO,
                              0,
                              NULL,
                              SESUSAPE
                        from or_order o, or_order_activity a, LDC_OSF_SESUCIER 
                        where o.order_id in (263377118,263377117,263377108,263377109,263377114,263377111,263377113,263377110)
                        and a.order_id = o.order_id
                        and a.product_id = producto
                        and nuano = 2022
                        and numes = 9
