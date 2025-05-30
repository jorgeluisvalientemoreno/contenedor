DECLARE
nuCodigoEntrega NUMBER; -- Codigo de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, 'CRM_JV_OSF-445_1', sysdate, 'OSF-445', 'Actualizacion 100225 Cambio de Uso del Servicio');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','N');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('COD_SOL_EST_REGISTRADA_100225'), 'PARAMETRO');

insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('PS_PACKAGE_TYPE_100225'), 'TRAMITE');

insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LDC_VAL_SOL_EST_REG_100225'), 'FUNCION');

insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_OBJECT_121657'), 'FWCOB');

COMMIT;
DBMS_OUTPUT.PUT_LINE ('Entrega creada con exito');

EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al aplicar la entrega ');

END;
/