DECLARE
    nuCodigoEntrega NUMBER;
BEGIN
    nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;

    insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, 'OSS_JJJM_OSF-352_1', sysdate, 'OSF-352', 'Actualizacion causal tramite de impresion pago parcial.');

    	--ENTREGA APLICA POR EMPRESA?
	insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','N');
	insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');
	
	dbms_output.put_line('Entrega por empresa Ok!'); 

	-- RELACION DE OBJETOS ENTREGADOS
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDC_TIPCAUS_IMPAPAR'),   'TABLA');
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDC_TIPCAU_CAUS_IMPPAR'),'TABLA');
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('SEQ_LDC_TIPCAU_CAUS_IMPPAR'), 'SECUENCIA');
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDC_TIPCAU_CAUS_IMPPAR'), 'FWCEA');
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDC_TIPCAU_CAUS_IMPPAR'), 'FWCEA');
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDCCOTICACAUS'), 'FWCMD');
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('PS_PACKAGE_TYPE_100039'), 'PSCRE');
	insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('DATOS'), 'DATAFIX');
	
		
	dbms_output.put_line('Relaci�n de objetos entregados ok!'); 
	
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE ('Registro de objetos exitoso');
EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al registrar los objetos de la entrega');
END;
/


