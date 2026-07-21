DECLARE
  CURSOR c_ciclos IS
    SELECT DISTINCT ciclo
      FROM open.ciclo_facturacion
     where empresa IN ('GDCA', 'GDGU');

  v_ciclo    perifact.pefacicl%TYPE;
  v_pefacodi perifact.pefacodi%TYPE;

BEGIN
  FOR r IN c_ciclos LOOP
  
    v_ciclo := r.ciclo;
  
    BEGIN
      -- Buscar el periodo activo según la fecha actual
      SELECT pefacodi
        INTO v_pefacodi
        FROM open.perifact
       WHERE pefacicl = v_ciclo
         AND TRUNC(SYSDATE) BETWEEN TRUNC(pefafimo) AND TRUNC(pefaffmo)
         AND ROWNUM = 1;
    
    EXCEPTION
      WHEN OTHERS THEN
        v_pefacodi := NULL;
    END;
  
    IF v_pefacodi IS NOT NULL THEN
    
      BEGIN
      
        -- Primero, desactivar el periodo actual de ese ciclo
        UPDATE open.perifact
           SET pefaactu = 'N'
         WHERE pefacicl = v_ciclo
           AND pefaactu = 'S';
      
        -- Activar ese periodo
        UPDATE open.perifact
           SET pefaactu = 'S'
         WHERE pefacodi = v_pefacodi;
      
        DBMS_OUTPUT.PUT_LINE('Actualización completada para el ciclo ' ||
                             v_ciclo || '.');
      
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Error en ciclo ' || v_ciclo || ': ' ||
                               SQLERRM);
          ROLLBACK;
      END;
    
    ELSE
    
      DBMS_OUTPUT.PUT_LINE('No existe periodo facturacion para el ciclo ' ||
                           v_ciclo || ' activo.');
    
    END IF; --Fin IF v_pefacodi IS NOT NULL THEN
  
  END LOOP;

  --COMMIT;

  DBMS_OUTPUT.PUT_LINE('Actualización finalizada para todos los ciclos.');
END;
/
