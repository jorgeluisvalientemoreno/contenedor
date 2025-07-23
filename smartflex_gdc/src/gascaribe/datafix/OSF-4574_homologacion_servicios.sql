declare
 nuConta  NUMBER;
 
 CURSOR cuExiste(fsbObjeto VARCHAR2) IS
  SELECT COUNT(1)
  FROM HOMOLOGACION_SERVICIOS
  WHERE SERVICIO_ORIGEN = fsbObjeto; 
  
BEGIN

OPEN cuExiste('CC_BOWAITFORPAYMENT.FDTCALCEXPIRATIONDATE'); 
FETCH cuExiste INTO nuConta; 
CLOSE cuExiste; 

IF nuConta = 0 THEN	
 insert into homologacion_servicios values('OPEN','CC_BOWAITFORPAYMENT.FDTCALCEXPIRATIONDATE','Calcula fecha de Espera Pago','ADM_PERSON','PKG_BOGESTION_PAGOS.FDTFECHAVENCIMIENTOESPERAPAGO','Calcula fecha de Espera Pago',''	); 
END IF;

commit;  
end;
/