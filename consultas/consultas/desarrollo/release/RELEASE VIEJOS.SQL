DECLARE
nuCodigoEntrega NUMBER; -- Código de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, 'Installer_7.07.046_rpLD450', sysdate, '376777', 'Se realiza ajuste sobre la funcionalidad de Financiación de deuda, para tener en cuenta que durante la adición de cargos, al operar internamente, el proceso no debe ingresar valores negativos para un cargo. Se ajusta para que en caso de cambio de signo en la memoria de proceso para un cargo tome el valor absoluto de la diferenciadurante la actualización  del cargo correspondiente.
Se entrega solución a la situación reportada para la funcionalidad Financiación de Deuda, según punto pendiente Sao 376777.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BOFinancing'), 'PAQUETE');

COMMIT;
DBMS_OUTPUT.PUT_LINE ('Entrega creada con éxito');

EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al aplicar la entrega ');

END;

/

DECLARE
nuCodigoEntrega NUMBER; -- Código de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD451', sysdate, '376874  - Ref. CA 300-258', 'Se modifica el proceso que calcula la fecha de expiración de la solicitud para que retorne siempre la fecha con horas, minutos y segundos hasta el final del día, de este modo la solicitud no se anulará inmediatamente.
Se entrega solución a la situación reportada para la funcionalidad Registro de Solicitud de Financiación de Deuda, según punto pendiente Sao 376868.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BOWaitForPayment'), 'PAQUETE');

COMMIT;
DBMS_OUTPUT.PUT_LINE ('Entrega creada con éxito');

EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al aplicar la entrega ');

END;
/

