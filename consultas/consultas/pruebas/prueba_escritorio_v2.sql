BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE CASOS_PRUEBA(CASO NUMBER)';
  FOR i IN 1..&num_condiciones LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE CASOS_PRUEBA ADD CONDICION_'||i||'  varchar2(1000)';
    END LOOP;
END;
/

DECLARE

    num_condiciones  NUMBER := &num_condiciones; -- Número de condiciones
    i NUMBER;
    j NUMBER;
    sbsql varchar2(4000);
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('Numero de condiciones: ' || num_condiciones);  -- Mostrar el número de condiciones

    -- Generar casos de prueba para todas las combinaciones posibles de condiciones
    DBMS_OUTPUT.PUT_LINE('Casos de Prueba:');
    FOR i IN 1..POWER(2, num_condiciones) LOOP
        INSERT INTO CASOS_PRUEBA(CASO) VALUES(I);
        FOR j IN 1..num_condiciones LOOP
            sbsql :=null;
            IF BITAND(i-1, POWER(2, j-1)) = 0 THEN
                sbsql:='UPDATE CASOS_PRUEBA SET CONDICION_'||J||'=''FALSO'' WHERE CASO='||i;
                EXECUTE IMMEDIATE sbsql;
            ELSE
                sbsql:='UPDATE CASOS_PRUEBA SET CONDICION_'||J||'=''VERDADERO'' WHERE CASO='||i;
                EXECUTE IMMEDIATE sbsql;
            END IF;
            
        END LOOP;
        commit;
    END LOOP;
END;
/
select *
from CASOS_PRUEBA;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE CASOS_PRUEBA';
END;
/
