-- Normalito 
DECLARE
 RESPUESTA   VARCHAR2(2000);
  TOTAL       NUMBER ;
  SBRESPUESTA VARCHAR2(2000) ; 
BEGIN
  dbms_output.put_line('OPERACION ARITMETICA');
   SELECT LDC_QA_FNUCALCULADORA(10,20,'S') INTO RESPUESTA  FROM DUAL;
  dbms_output.put_line('TOTAL OBTENIDO: '||RESPUESTA);
   IF RESPUESTA = '15' THEN
   dbms_output.put_line('PRUEBA EXITOSA');
  ELSE
   dbms_output.put_line('PRUEBA FAIL' );
  END IF;
END;

--Variables 
DECLARE
 RESPUESTA   VARCHAR2(2000);
  N1 NUMBER;
  N2 NUMBER;
  OP VARCHAR2(2000);
  ESPERADO VARCHAR2(2000);
BEGIN
  N1 := 20 ;
  N2 := 10 ;
  OP := 'r' ;
  ESPERADO := 10 ;
  dbms_output.put_line('OPERACION ARITMETICA REALIZADA: '|| OP);
  dbms_output.put_line('NUMERO 1: '|| N1);
  dbms_output.put_line('NUMERO 2: '|| N2);
  
  SELECT LDC_QA_FNUCALCULADORA(N1,N2,OP) INTO RESPUESTA  FROM DUAL;
  dbms_output.put_line('TOTAL CALCULADO: '||RESPUESTA);
  dbms_output.put_line('VALOR ESPERADO: '||ESPERADO);
  
WHILE i < 4 then    
    IF OP = 'S' AND RESPUESTA = ESPERADO THEN
   dbms_output.put_line('PRUEBA EXITOSA');
   i : = i +1 ;
   ELSE IF OP = 'R' AND RESPUESTA = ESPERADO  THEN 
      dbms_output.put_line('PRUEBA EXITOSA');
      ELSE IF OP = 'M' AND RESPUESTA = ESPERADO  THEN 
      dbms_output.put_line('PRUEBA EXITOSA');
         ELSE IF OP = 'D' AND RESPUESTA = ESPERADO  THEN 
         dbms_output.put_line('PRUEBA EXITOSA');
           ELSE
           dbms_output.put_line('PRUEBA FALLIDA' );
           END IF ;
         END IF;
      END IF;
   END IF;
END;


--Variables 
DECLARE
 RESPUESTA   VARCHAR2(2000);
  N1 NUMBER;
  N2 NUMBER;
  TYPE OPARRAY IS VARRAY(4) OF VARCHAR2(10); 
  OP OPARRAY;
  LONGITUD INTEGER;
  TYPE OPESPERADO IS VARRAY(4) OF VARCHAR2(2000); 
  ESPERADO OPESPERADO;
 
BEGIN
  N1 := 20;
  N2 := 20;
  OP := OPARRAY('s','r','m','d');
  LONGITUD := OP.COUNT;  
  ESPERADO := OPESPERADO(40,0,200,1);
    
  FOR i in 1 .. LONGITUD LOOP 
  dbms_output.put_line('OPERACION ARITMETICA REALIZADA: '|| OP(i));
  dbms_output.put_line('NUMERO 1: '|| N1);
  dbms_output.put_line('NUMERO 2: '|| N2);
      
  SELECT LDC_QA_FNUCALCULADORA(N1,N2,OP(i)) INTO RESPUESTA  FROM DUAL;
  dbms_output.put_line('TOTAL CALCULADO: '||RESPUESTA);  
  dbms_output.put_line('VALOR ESPERADO: '||ESPERADO(i));
  
       
   IF OP(i) = 'S' OR OP(i) = 's' AND RESPUESTA = ESPERADO(i) THEN
   dbms_output.put_line('PRUEBA EXITOSA');
   CONTINUE;
   ELSE IF OP(i) = 'R' OR OP(i) = 'r' AND RESPUESTA = ESPERADO(i)  THEN 
      dbms_output.put_line('PRUEBA EXITOSA');
      CONTINUE;
      ELSE IF OP(i) = 'M' OR OP(i) = 'm' AND RESPUESTA = ESPERADO(i) THEN 
      dbms_output.put_line('PRUEBA EXITOSA');
      CONTINUE;
         ELSE IF OP(i) = 'D' OR OP(i) = 'd' AND RESPUESTA = ESPERADO(i)  THEN 
         dbms_output.put_line('PRUEBA EXITOSA');
         CONTINUE;
           ELSE
           dbms_output.put_line('PRUEBA FALLIDA' );
           CONTINUE;
           END IF ;
         END IF;
      END IF;
   END IF;
   END LOOP; 
END;
