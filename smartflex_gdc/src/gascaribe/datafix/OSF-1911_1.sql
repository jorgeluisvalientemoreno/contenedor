declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

OPEN cuExiste('UT_SESSION.GETTERMINAL'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','UT_SESSION.GETTERMINAL','Retorna el Id de la terminal del usuario','ADM_PERSON','PKG_SESSION.FSBGETTERMINAL',NULL,''	); END IF;
commit;
  
end;
/