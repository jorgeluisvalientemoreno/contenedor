declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

OPEN cuExiste('OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER','Obtiene actividades por orden','ADM_PERSON','PKG_BCGESTION_ORDENES,PRCOBTACTIVPORORDEN','Obtiene actividades por orden',NULL); END IF;	
OPEN cuExiste('OR_BORELATEDORDER.RELATEORDERS'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','OR_BORELATEDORDER.RELATEORDERS','Relaciona ordenes','ADM_PERSON','API_RELATED_ORDER','Relaciona ordenes',NULL); END IF;	
OPEN cuExiste('OR_BOPROCESSORDER.PROCESSORDER'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','OR_BOPROCESSORDER.PROCESSORDER','Procesa Orden','ADM_PERSON','PKG_BOGESTION_ORDENES.PRCPROCESARORDEN','Procesa Orden',NULL); END IF;	
OPEN cuExiste('OR_BOPROCESSORDER.FBLISORDERALTERABLEBYRELATED'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','OR_BOPROCESSORDER.FBLISORDERALTERABLEBYRELATED','Valida si la orden es apta para relacionar','ADM_PERSON','PKG_BOGESTION_ORDENES.FBLVALGENERARORDENADICIONAL','Valida si la orden es apta para relacionar',NULL); END IF;	
OPEN cuExiste('DAOR_ORDER_ACTIVITY.FNUGETPROCESS_ID'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','DAOR_ORDER_ACTIVITY.FNUGETPROCESS_ID','Obtiene valor de la columna con el ID','ADM_PERSON','PKG_OR_ORDER_ACTIVITY.FNUOBTPROCESS_ID','Obtiene valor de la columna con el ID',NULL); END IF;	
OPEN cuExiste('DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_ID'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','DAOR_ORDER_ACTIVITY.FNUGETACTIVITY_ID','Obtiene valor de la columna con el ID','ADM_PERSON','PKG_OR_ORDER_ACTIVITY.FNUOBTACTIVITY_ID','Obtiene valor de la columna con el ID',NULL); END IF;	
OPEN cuExiste('DAOR_ORDER_ACTIVITY.FNUGETSERIAL_ITEMS_ID'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','DAOR_ORDER_ACTIVITY.FNUGETSERIAL_ITEMS_ID','Obtiene valor de la columna con el ID','ADM_PERSON','PKG_OR_ORDER_ACTIVITY.FNUOBTSERIAL_ITEMS_ID','Obtiene valor de la columna con el ID',NULL); END IF;	
OPEN cuExiste('DAOR_ORDER_ACTIVITY.FRCGETRECORD'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','DAOR_ORDER_ACTIVITY.FRCGETRECORD','Obtine el registro','ADM_PERSON','PKG_OR_ORDER_ACTIVITY.FRCOBTREGISTRORID','Obtine el registro',NULL); END IF;	
OPEN cuExiste('DAOR_ORDER_ACTIVITY.FRCUPDRECORD'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values('OPEN','DAOR_ORDER_ACTIVITY.FRCUPDRECORD','Actualiza el registro','ADM_PERSON','PKG_OR_ORDER_ACTIVITY.PRACTREGISTRO','Actualiza el registro',NULL); END IF;	

commit;  
end;
/
