
declare
 nuConta  NUMBER;
 
 CURSOR cuExiste IS
  SELECT COUNT(1)
  FROM SA_TAB
  WHERE APLICA_EXECUTABLE = 'FCFA' AND PROCESS_NAME = 'PBCIEM'; 
  
BEGIN

OPEN cuExiste; 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
  INSERT INTO SA_TAB VALUES(SEQ_SA_TAB.NEXTVAL,'FCFA_CICLO','PBCIEM','FCFA',NULL,NULL,0,NULL,NULL); 
END IF;

COMMIT;

END;
/