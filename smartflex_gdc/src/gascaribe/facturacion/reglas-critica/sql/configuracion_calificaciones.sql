declare
  nuseq number;
  nuConta NUMBER;
  sbProceso  VARCHAR2(1);
  nuContador NUMBER := 34;
  nuUltValor   NUMBER;
  
  CURSOR cuGetValorSeq IS
  SELECT LAST_NUMBER
  FROM DBA_SEQUENCES
  WHERE sequence_name ='SEQ_LDC_CALIFICACION_CONS';

begin
  
  OPEN cuGetValorSeq;
  FETCH cuGetValorSeq INTO nuUltValor;
  CLOSE cuGetValorSeq;
  
  IF nuUltValor < 34 THEN
     EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_LDC_CALIFICACION_CONS NOCACHE';
     FOR REG in 1..13 LOOP
        nuseq := SEQ_LDC_CALIFICACION_CONS.NEXTVAL;
     END LOOP;
  END IF;
  
  SELECT COUNT(1) INTO nuConta
  FROM ldc_calificacion_cons
  WHERE codigo_calificacion = 3001;
  
  IF nuConta = 0 THEN   
         
   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3001, 'REGLA DE LECTURA 3001', 'L','Y', 35, 'Y');

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3002, 'REGLA DE LECTURA 3002', 'L','Y', 36, 'Y');

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3003, 'REGLA DE LECTURA 3003', 'L','Y', 37, 'Y');
   
   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3005, 'REGLA DE LECTURA 3005', 'L','Y', 38, 'Y');

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3004, 'REGLA DE LECTURA 3004', 'L','Y', 39, 'Y');        
 
   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3015, 'REGLA DE LECTURA 3015', 'L','Y', 40, 'Y'); 

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3006, 'REGLA DE LECTURA 3006', 'L','Y', 41, 'Y');      
   
   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3007, 'REGLA DE LECTURA 3007', 'L','Y', 42, 'Y');   

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3008, 'REGLA DE LECTURA 3008', 'R','Y', 43, 'Y');

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3009, 'REGLA DE LECTURA 3009', 'R','Y', 44, 'Y');

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3010, 'REGLA DE LECTURA 3010', 'R','Y', 45, 'Y');

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3012, 'REGLA DE LECTURA 3012', 'R','Y', 46, 'Y');

      insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3011, 'REGLA DE LECTURA 3011', 'R','Y', 47, 'Y');      
   
   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3016, 'REGLA DE LECTURA 3016', 'R','Y', 48, 'Y');

   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3013, 'REGLA DE LECTURA 3013', 'R','Y', 49, 'Y');      
   
   insert into ldc_calificacion_cons (CONSECUTIVO, CODIGO_CALIFICACION, DESCRIPCION, PROCESO, ACTIVO, PRIORIDAD, TIENE_LECTURA)
         values (SEQ_LDC_CALIFICACION_CONS.nextval, 3014, 'REGLA DE LECTURA 3014', 'R','Y', 50, 'Y');  
   
   
   
   COMMIT;
   
  END IF;
  
end;
/