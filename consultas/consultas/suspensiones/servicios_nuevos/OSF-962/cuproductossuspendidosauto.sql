/*cursor cuproductossuspendidosauto(nuCiclo          open.servsusc.sesucicl%type,
                                      NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE,
                                      ESTADOCORTE      VARCHAR2,
                                      ESTADOPRODCUTO   VARCHAR2,
                                      TIPOSSUSPENSION  VARCHAR2,
                                      inudepa  NUMBER,
                                      inuloca NUMBER,
                                      inuProductId IN   servsusc.sesunuse%type)
        IS
           */ SELECT *
            FROM (
                SELECT sesususc,
                   sesunuse,
                   sesuesco,
                   sesucicl,
                   suspen_ord_act_id,
                   open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(s.sesunuse) DEPA,
                   open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTLOCALITY(s.sesunuse ) LOCA,
                   inuHilo pershilo
                FROM open.servsusc              s,
                     open.pr_product            p,
                     open.pr_prod_suspension    ps,
                     open.ldc_proceso_actividad lpa
                WHERE s.sesuesco IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(estadocorte,
                                                                   '-1',
                                                                       to_char(s.sesuesco),
                                                                      estadocorte),
                                                                ',')))
                 AND p.product_status_id IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(estadoprodcuto,
                                                                       '-1',
                                                                       to_char(p.product_status_id),
                                                                       estadoprodcuto),
                                                                ',')))
                 AND ps.suspension_type_id IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(tipossuspension,
                                                                       '-1',
                                                                       to_char(ps.suspension_type_id),
                                                                       tipossuspension),
                                                                ',')))
                 AND s.sesucicl = decode(nuciclo, -1, s.sesucicl, nuciclo)
                 AND sesuserv = 51247582
                   and ps.ACTIVE ='Y'
                 AND p.product_id = s.sesunuse
                 AND p.product_id = ps.product_id
                 AND p.suspen_ord_act_id IS NOT NULL
                -- AND 0 = fnugetValidaAuto(s.sesunuse, 9)
                 AND 0 = (SELECT count(1)
                            FROM open.LDC_SUSP_AUTORECO, open.or_order
                           WHERE SARESESU = sesunuse
                             AND SAREORDE = order_id
                             AND order_status_id IN (0, 5, 6, 7))--200-2614
                 AND 0 = (SELECT count(1)
                            FROM open.LDC_SUSP_AUTORECO
                           WHERE SARESESU = s.sesunuse
                             AND SAREORDE IS NULL)
                 AND lpa.proceso_id = 9
                 AND lpa.activity_id =
                     OPEN.daor_order_activity.fnugetactivity_id(suspen_ord_act_id,
                                                                NULL)
                 AND NOT EXISTS(  SELECT 'X'
                                  FROM open.or_order_activity, open.or_order, open.ldc_actividad_generada
                                  WHERE or_order_activity.product_id = p.product_id
                                     AND or_order_activity.order_id = or_order.order_id
                                     AND order_status_id IN (0, 5, 6, 7) --200-2614
                                     AND or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                     AND ldc_actividad_generada.activity_id_generada = lpa.activity_id -- Inicia NC 3468.
                                    )
                --AND sesunuse > 0
                AND sesunuse = 51247582
             --   AND sesunuse = 162
                --AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos
        --INICIO CA 337
        AND LDC_PKGESTPREXCLURP.FUNVALEXCLURP(sesunuse) = 0
        --FIN CA 337
              ) WHERE DEPA = DECODE(inuDepa, -1, depa, inudepa)
                AND loca = DECODE(inuLoca, -1, loca, inuLoca);
/*9:28
Este es el inicial
9:29*/
/*CURSOR cuMaximaLectura(nuNuse           open.lectelme.leemsesu%type,
                               NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE)
        IS
            \*ajuste  # 1 seg?n necesidad del tiquete 3567 09/05/2014
          se suprimi la condici?n AND LEEMOBLE = 65 y se  cambia por
          open.ldc_boutilities.fsbbuscatoken(open.dald_parameter.fsbgetvalue_chain('TIPO_TRAB_REPESCA'),to_char(B.task_type_id),',') = 'S'
          se crea parametro TIPO_TRAB_REPESCA en LDPAR donde el funcional parametrizar? los Tipos de Trabajos para el proceso de repesca  *\
            SELECT leemfele, nvl(leemleto, 0), b.order_id, b.task_type_id
            FROM open.lectelme a
            inner join open.or_order_activity b
            on a.LEEMDOCU = b.ORDER_ACTIVITY_ID
            WHERE LEEMSESU = nuNuse
            AND LEEMCLEC = 'T'
            AND open.DAOR_ORDER.FNUGETTASK_TYPE_ID(open.DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(B.ORDER_ACTIVITY_ID,
                                                                                NULL),
                                             NULL) =
               (SELECT LPA.TASK_TYPE_ID
                  FROM open.LDC_PROCESO_ACTIVIDAD LPA
                 WHERE LPA.PROCESO_ID = NULDC_PROCESO_ID
                   AND LPA.ACTIVITY_ID = B.ACTIVITY_ID)
           ORDER BY leemfele desc;*/
