declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

OPEN cuExiste('SA_BOSYSTEM.FNUGETUSERCOMPANYID'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','SA_BOSYSTEM.FNUGETUSERCOMPANYID','Retorna la empresa del usuario conectado','ADM_PERSON','PKG_SESSION.FNUGETEMPRESADEUSUARIO',NULL,''	); END IF;
commit;
  
end;
/