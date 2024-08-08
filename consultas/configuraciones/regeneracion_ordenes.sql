 --consulta cuando el campo legalize_try_times esta nulo
  SELECT  A.ACTIVIDAD_REGENERAR,
                    A.ACTIVIDAD_WF,
                    A.TIEMPO_ESPERA,
                    NULL TIEMPO_VIDA,
                    NULL PRIORIDAD_DESPACHO,
                    A.ACTION,
                    A.TRY_LEGALIZE
              FROM  (SELECT/*+ INDEX(OR_regenera_activida IDX_OR_REGENERA_ACTIVIDA_02)
                      INDEX(actRegenerar PK_GE_ITEMS) */
                OR_REGENERA_ACTIVIDA.ID_REGENERA_ACTIVIDA,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD,
                OR_REGENERA_ACTIVIDA.ID_CAUSAL,
                OR_REGENERA_ACTIVIDA.CUMPLIDA,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD_WF,
                OR_REGENERA_ACTIVIDA.ESTADO_FINAL,
                OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA,
                OR_REGENERA_ACTIVIDA.ACTION,
            OR_REGENERA_ACTIVIDA.TRY_LEGALIZE
            FROM OR_REGENERA_ACTIVIDA, GE_ITEMS ACTREGENERAR
            /*+ Or_bcRegeneraActivid.CargaTablaRegAct SAO182466 */
            WHERE OR_REGENERA_ACTIVIDA.ACTIVIDAD = 4295245
                AND ACTREGENERAR.ITEMS_ID(+) = OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR
                AND ACTREGENERAR.ITEM_CLASSIF_ID(+) = 2) A
              /*+ Or_bcRegeneraActivid.ActividadesARegenera SAO193408 */
             WHERE  A.ACTIVIDAD   = 4295245
               AND  NVL(A.ID_CAUSAL, 9423) = 9423
               --AND  A.TRY_LEGALIZE IS NULL
               AND  ( (&cumplida = 0) AND (&cumplida = A.CUMPLIDA)
                OR    (&cumplida != 0) AND (A.CUMPLIDA > 0) );


--cuando no esta nulo                
SELECT  A.ACTIVIDAD_REGENERAR,
                    A.ACTIVIDAD_WF,
                    A.TIEMPO_ESPERA,
                    NULL TIEMPO_VIDA,
                    NULL PRIORIDAD_DESPACHO,
                    A.ACTION,
                    A.TRY_LEGALIZE
              FROM  (SELECT/*+ INDEX(OR_regenera_activida IDX_OR_REGENERA_ACTIVIDA_02)
                      INDEX(actRegenerar PK_GE_ITEMS) */
                OR_REGENERA_ACTIVIDA.ID_REGENERA_ACTIVIDA,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD,
                OR_REGENERA_ACTIVIDA.ID_CAUSAL,
                OR_REGENERA_ACTIVIDA.CUMPLIDA,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD_WF,
                OR_REGENERA_ACTIVIDA.ESTADO_FINAL,
                OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA,
                OR_REGENERA_ACTIVIDA.ACTION,
            OR_REGENERA_ACTIVIDA.TRY_LEGALIZE
            FROM OR_REGENERA_ACTIVIDA, GE_ITEMS ACTREGENERAR
            /*+ Or_bcRegeneraActivid.CargaTablaRegAct SAO182466 */
            WHERE OR_REGENERA_ACTIVIDA.ACTIVIDAD = 4295245
                AND ACTREGENERAR.ITEMS_ID(+) = OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR
                AND ACTREGENERAR.ITEM_CLASSIF_ID(+) = 2) A
              /*+ Or_bcRegeneraActivid.ActividadesARegenera SAO182466 */
             WHERE  A.ACTIVIDAD   = NUIDACTIVIDAD
               AND  NVL(A.ID_CAUSAL, NUIDCAUSAL) = NUIDCAUSAL
               AND  (   A.TRY_LEGALIZE IS NULL OR
                        A.TRY_LEGALIZE = NVL(NUINTENTOS, 0)
                    )
               AND  ( (NUCUMPLIDA = 0) AND (NUCUMPLIDA = A.CUMPLIDA)
                OR    (NUCUMPLIDA != 0) AND (A.CUMPLIDA > 0) );
                
