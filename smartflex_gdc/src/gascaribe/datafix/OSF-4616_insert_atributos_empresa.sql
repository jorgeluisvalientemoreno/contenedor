declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(sbParametro VARCHAR2, sbEmpresa VARCHAR2) IS
  SELECT COUNT(1)
  FROM ATRIBUTOS_EMPRESA
  WHERE ATRIBUTO = sbParametro
  AND EMPRESA = sbEmpresa; 
  
BEGIN

OPEN cuExiste('LINEA_EMERGENCIAS','GDCA'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDCA','LINEA_EMERGENCIAS','164');
END IF;

----------------------------------------------------

OPEN cuExiste('LINEA_EMERGENCIAS','GDGU'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDGU','LINEA_EMERGENCIAS','164');
END IF;

----------------------------------------------------

OPEN cuExiste('LINEA_GRATUITA','GDCA'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDCA','LINEA_GRATUITA','018000915334');
END IF;

----------------------------------------------------

OPEN cuExiste('LINEA_GRATUITA','GDGU'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDGU','LINEA_GRATUITA','018000911300');
END IF;


----------------------------------------------------

OPEN cuExiste('WHATSAPP','GDCA'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDCA','WHATSAPP','+57 6053227000');
END IF;

----------------------------------------------------

OPEN cuExiste('WHATSAPP','GDGU'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDGU','WHATSAPP',' ');
END IF;


----------------------------------------------------

OPEN cuExiste('LINEA_SERVICIO_CLIENTE','GDCA'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDCA','LINEA_SERVICIO_CLIENTE','(605) 3227000');
END IF;

----------------------------------------------------

OPEN cuExiste('LINEA_SERVICIO_CLIENTE','GDGU'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
INSERT INTO ATRIBUTOS_EMPRESA VALUES ('GDGU','LINEA_SERVICIO_CLIENTE','(605) 7273464 ');
END IF;

COMMIT;

END;
/