DECLARE
nuCodigoEntrega NUMBER; -- C�digo de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, 'OSS_JV_OSF-369_2', sysdate, 'OSF-369', 'VALIDAR CUENTAS DE COBROS CON SALDO');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','N');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDC_FNUCUENTASSALDOSPRODUCTO'), 'FUNCION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDC_PRCUENTASSALDOSCONTRATO'), 'PROCEDIMIENTO');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ldcvalproductparamarcado'), 'PROCEDIMIENTO');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ldcvalproducttramitereco'), 'PROCEDIMIENTO');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_OBJECT_121746'), 'FWCOB');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('PS_PACKAGE_TYPE_100306'), 'TRAMITE');

COMMIT;
DBMS_OUTPUT.PUT_LINE ('Entrega creada con �xito');

EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al aplicar la entrega ');

END;
/