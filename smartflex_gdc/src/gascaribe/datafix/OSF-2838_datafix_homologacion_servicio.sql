declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

OPEN cuExiste('OR_BOCONSTANTS.CNUORDER_STAT_CLOSED'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
insert into homologacion_servicios values(	'OPEN','SA_BOUSER.FNUGETUSERID(USER_MASK)','Retorna id de usuario recibe mascara de usuario','ADM_PERSON','PKG_SESSION.FNUGETUSERIDBYMASK','Retorna id de usuario recibe mascara de usuario',''); 
END IF;

OPEN cuExiste('PKTBLSERVSUSC.FNUGETSERVICE'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FNUGETSERVICE','Retorna id del tipo de producto','ADM_PERSON','PKG_BCPRODUCTO.FNUTIPOPRODUCTO','Retorna id del tipo de producto',''); 
END IF;

OPEN cuExiste('PKTBLSUSCRIPC.FNUGETBILLINGCYCLE'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
insert into homologacion_servicios values(	'OPEN','PKTBLSUSCRIPC.FNUGETBILLINGCYCLE','Retorna id del ciclo','ADM_PERSON','PKG_BCCONTRATO.FNUCICLOFACTURACION','Retorna id del ciclo',''); 
END IF;


OPEN cuExiste('PR_BCPRODUCT.FNUGETADDRESSID'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
insert into homologacion_servicios values(	'OPEN','PR_BCPRODUCT.FNUGETADDRESSID','Retorna id de la direccion del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION','Retorna id de la direccion',''); 
END IF;


OPEN cuExiste('PKTBLSERVSUSC.FDTGETRETIREDATE'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
insert into homologacion_servicios values(	'OPEN','PKTBLSERVSUSC.FDTGETRETIREDATE','Retorna la fecha de retiro del producto','ADM_PERSON','PKG_BCPRODUCTO.FDTFECHARETIRO','Retorna la fecha de retiro del producto',''); 
END IF;

OPEN cuExiste('GW_BOERRORS.CHECKERROR'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta > 0 THEN	
delete homologacion_servicios where servicio_origen = 'GW_BOERRORS.CHECKERROR' and esquema_origen = 'OPEN';
END IF;

update homologacion_servicios set esquema_destino = 'ADM_PERSON' where servicio_destino = 'PKG_PRODUCTO.PRACTUALIZAESTADOPRODUCTO';


commit;  
end;
/
