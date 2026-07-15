DECLARE
    CURSOR c_ciclos IS
        SELECT DISTINCT ciclo
        FROM open.ciclo_facturacion
        where empresa IN ('GDCA', 'GDGU');
    
    v_ciclo     perifact.pefacicl%TYPE;
    v_pefacodi  perifact.pefacodi%TYPE;

BEGIN
    FOR r IN c_ciclos LOOP
        v_ciclo := r.ciclo;
        
        -- Primero, desactivar el periodo actual de ese ciclo
        UPDATE open.perifact
        SET pefaactu = 'N'
        WHERE pefacicl = v_ciclo
        AND pefaactu = 'S';
        
        BEGIN
            -- Buscar el periodo activo según la fecha actual
            SELECT pefacodi
            INTO v_pefacodi
            FROM open.perifact
            WHERE pefacicl = v_ciclo
            AND TRUNC(SYSDATE) BETWEEN TRUNC(pefafimo) AND TRUNC(pefaffmo)
            AND ROWNUM = 1;
            
            -- Activar ese periodo
            UPDATE open.perifact
            SET pefaactu = 'S'
            WHERE pefacodi = v_pefacodi;
            
            DBMS_OUTPUT.PUT_LINE('Actualización completada para el ciclo ' || v_ciclo || '.');
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No se encontró un periodo válido para el ciclo ' || v_ciclo || '.');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error en ciclo ' || v_ciclo || ': ' || SQLERRM);
        END;
        
    END LOOP;
    
    COMMIT;  
    
    DBMS_OUTPUT.PUT_LINE('Actualización finalizada para todos los ciclos.');
END;
/
