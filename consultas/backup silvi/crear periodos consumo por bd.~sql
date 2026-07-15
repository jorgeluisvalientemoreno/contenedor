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
        SELECT MAX(EXTRACT(MONTH FROM pecsfecf)), MAX(EXTRACT(YEAR FROM pecsfecf))
        INTO v_ult_mes, v_ult_ano
        FROM open.pericose
        WHERE pecscico =r.ciclo
          AND  EXTRACT(YEAR FROM pecsfecf) = 2026;

        
        IF v_ult_mes < 12 THEN

           insert into open.pericose
            select  SQ_PERICOSE_PECSCONS.NEXTVAL as pecscons, 
            (TRUNC(pecsfecf) +1) as pecsfeci , 
            (pecsfecf +30 ) as pecsfecf, 
            'N'pecsproc, 
            pecsuser, 
            pecsterm, 
            pecsprog, 
            pecscico, 
            'N' pecsflav, 
            (TRUNC(pecsfecf) +1) AS  pecsfeai, 
            (pecsfecf +30 ) AS pecsfeaf
            from open.pericose c 
            where c.pecscico=r.ciclo
            and (EXTRACT(YEAR FROM pecsfecf)) =  v_ult_ano
             and (EXTRACT(MONTH FROM pecsfecf)) =  v_ult_mes;
           

        END IF;

    END LOOP;

    COMMIT;
END;
