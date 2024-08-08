        WITH BASE AS(
            SELECT GI_CONFIG.CONFIG_ID, GI_CONFIG.EXTERNAL_ROOT_ID
            FROM "OPEN".GI_CONFIG
            WHERE  GI_CONFIG.ENTITY_ROOT_ID = 2012
            AND    GI_CONFIG.CONFIG_TYPE_ID=4)
                
            SELECT FRAME_ID INTO parentFrame
                FROM "OPEN".GI_FRAME FR
                INNER JOIN "OPEN".GI_CONFIG_COMP CC ON CC.COMPOSITION_ID=FR.COMPOSITION_ID
                WHERE (CC.CONFIG_ID) IN (SELECT CONFIG_ID
                                                FROM BASE
                                                WHERE EXTERNAL_ROOT_ID = &tramite)
                    AND CONFIG_ID  NOT IN (SELECT CONFIG_ID
                                                FROM BASE
                                                WHERE  EXTERNAL_ROOT_ID = 587)
                    AND FR.ORDER_VIEW=1;