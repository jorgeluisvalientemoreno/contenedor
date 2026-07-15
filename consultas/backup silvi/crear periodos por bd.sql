DECLARE
    CURSOR c_ciclos IS
        SELECT DISTINCT ciclo
        FROM open.ciclo_facturacion
        WHERE empresa IN ('GDGU');

    v_ult_mes   NUMBER;
    v_ult_ano   NUMBER;

BEGIN
    FOR r IN c_ciclos LOOP

        -- Obtener el último periodo del ciclo
        SELECT MAX(pefames), MAX(pefaano)
        INTO v_ult_mes, v_ult_ano
        FROM open.perifact
        WHERE pefacicl = r.ciclo
          AND pefaano = 2026;

        
        IF v_ult_mes < 12 THEN

            INSERT INTO open.perifact
            SELECT  
                SQ_PERIFACT_PEFACODI.NEXTVAL,
                2026,
                v_ult_mes + 1,
                pefasaca,
                TRUNC(pefaffmo) + 1,
                pefaffmo + 29,
                pefaffmo + 30,
                pefaffmo + 31,
                pefaffmo + 31,
                pefaffmo + 30,
                pefaobse,
                pefacicl,
                'CICLO ' || r.ciclo || ' AÑO ' || v_ult_ano || ' MES ' || (v_ult_mes + 1),
                pefafcco,
                pefafgci,
                'N',
                pefafeem
            FROM open.perifact
            WHERE pefacicl = r.ciclo
              AND pefaano = v_ult_ano
              AND pefames = v_ult_mes;

        END IF;

    END LOOP;

    COMMIT;
END;
