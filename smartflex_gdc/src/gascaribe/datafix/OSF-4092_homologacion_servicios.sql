declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

OPEN cuExiste('OR_BOORDER.CLOSEORDERWITHPRODUCT'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
 insert into homologacion_servicios values(	'OPEN','OR_BOORDER.CLOSEORDERWITHPRODUCT','Crea una Orden y la actualiza a estado cerrada','ADM_PERSON','PKG_BOGESTION_ORDENES.PRCCREAORDENCERRADA','Crea una Orden y la actualiza a estado cerrada',''	); 
END IF;

delete homologacion_servicios where servicio_destino = 'PKG_BOGESTION_ORDENES.PRCPROCESARORDEN';

commit;  
end;
/