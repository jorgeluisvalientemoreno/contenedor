declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

OPEN cuExiste('UT_SESSION.GETTERMINAL'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','UT_SESSION.GETTERMINAL','Retorna el Id de la terminal del usuario','ADM_PERSON','PKG_SESSION.FSBGETTERMINAL',NULL,''	); END IF;
OPEN cuExiste('OR_BOCONSTANTS.CNUSUCCESCAUSAL'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','OR_BOCONSTANTS.CNUSUCCESCAUSAL','Retorna tipo de causal Exito','PERSONALIZACIONES','PKG_GESTIONORDENES.CNUCAUSALEXITO',NULL,''	); END IF;
OPEN cuExiste('DAAB_ADDRESS.FNUGETESTATE_NUMBER'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','DAAB_ADDRESS.FNUGETESTATE_NUMBER','Retorna el ID de predio de una direccion','ADM_PERSON','PKG_BCDIRECCIONES.FNUGETPREDIO',NULL,''	); END IF;
OPEN cuExiste('OR_BOORDERACTIVITIES.CREATEACTIVITY'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','OR_BOORDERACTIVITIES.CREATEACTIVITY','Crear Órdenes de Trabajo','ADM_PERSON','API_CREATEORDER',NULL,''	); END IF;
OPEN cuExiste('PR_BOPRODUCT.GETCATSUBCATBYPROD'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','PR_BOPRODUCT.GETCATSUBCATBYPROD','obtiene categoria y subcategoria del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUCATEGORIA',NULL,''	); END IF;
OPEN cuExiste('PR_BOPRODUCT.GETCATSUBCATBYPROD'); FETCH cuExiste INTO nuConta; CLOSE cuExiste; IF nuConta = 0 THEN	insert into homologacion_servicios values(	'OPEN','PR_BOPRODUCT.GETCATSUBCATBYPROD','obtiene categoria y subcategoria del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUSUBCATEGORIA',NULL,''	); END IF;commit;
commit;  
end;
/

