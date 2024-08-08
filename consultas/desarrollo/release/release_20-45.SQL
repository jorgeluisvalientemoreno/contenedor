

DECLARE
nuCodigoEntrega NUMBER; -- Código de la entrega
BEGIN
-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD20', sysdate, '473231', 'Se modifica la consulta para validar si el Contrato a facturar  tiene solicitudes recurrentes de constructoras para realizar aplicación de depósito.
Se entrega solución a la situación reportada para la funcionalidad Generación de Cuentas, según punto pendiente Sao 473231.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('MO_BCPackages'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD21', sysdate, '468850', 'Se modifica el paquete que contiene los servicios para el cálculo de consumo basado en Lecturas, para prevenir error por diferencia de lecturas de más de 999 días
Se entrega solución a la situación reportada para la funcionalidad Cálculo de consumo basado en Lecturas, según punto pendiente Sao 468850.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOEstimateServices'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOCalcConsumpServs'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD22', sysdate, '474297', 'Permite legalizar de forma tardía el cambio de medidor, posterior a su ejecución en terreno
Se entrega solución a la situación reportada para la funcionalidad Legalización tardía de Cambio de Medidor, según punto pendiente Sao 474297.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_BOItems'), 'PAQUETE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD23', sysdate, '472642', 'se modifica el evento del boton aceptar para que no se haga commit, ademas se modifica el registercallerdinamic para que este haga un rollback de los datos creados en en la base
Se entrega solución a la situación reportada para la funcionalidad OpenSystems.Claim.GUI, según punto pendiente Sao 472642.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Claim.GUI'), 'FORMA');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD24', sysdate, '464787', 'Se realiza correccion para que el reporte solo tenga en cuenta los movimientos de items que corresponden a transito. Esto se realiza por medio de la validacion de la causal de movimiento. 
Se entrega solución a la situación reportada para la funcionalidad Reporte de items en transito ORTRA, según punto pendiente Sao 464787.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ORTRA'), 'REPORTE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD25', sysdate, '469940', 'Al interior de la constructora se controla que el elemento de medición obtenido en la instancia no sea nulo, con ello se garantiza que no se registren consumos sin elemento de medición.
Se entrega solución a la situación reportada para la funcionalidad OBTECOPP - Obtener consumo promedio parametrizado, según punto pendiente Sao 469940.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOEstimateServices'), 'PAQUETE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD26', sysdate, '472531', 'Se estaba presentando inconsistencias en la negociación de deuda debido a que en la última entrega no se estabilizó correctamente el nombre de una variable.
Se modifica el objeto de negocio para tener el nombre correcto de la variable que estaba ocasionando la inconsistencia.
Se entrega solución a la situación reportada para la funcionalidad Negociación de Deuda - GCNED, según punto pendiente Sao 472531.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GC_BODebtNegotiation'), 'PAQUETE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD27', sysdate, '476344', 'Se implementa mejora de rendimiento en el proceso de agrupación de órdenes de trabajo, específicamente al obtener las órdenes particulares a un contratista, con algunos tipos de trabajos determinados. Esto generará optimización en tiempo de respuesta del proceso de agrupación y de Generación de Obligaciones a Contratistas.
Se entrega solución a la situación reportada para la funcionalidad Agrupación de órdenes de Trabajo por Tipo de Trabajo., según punto pendiente Sao 476344.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BCReads'), 'PAQUETE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD28', sysdate, '476359', 'Generación de Hecho económicos para el movimiento de aplicación de saldo a favor');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBOAccountingInterface'), 'PAQUETE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD29', sysdate, '482873-482775', 'Se entrega solución a la situación reportada para la funcionalidad Se modifica el servicio que trae las ordenes a nivel de unidades de trabajo en la forma CTCCO, para que al contrario de traer todas aquellas ordenes con estado diferente a Cerrado, ahora obtenga únicamente las ordenes cuyos estados sean Programada, Asignada, Ejecutando o Ejecutada., según punto pendiente Sao 482873.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('Ge_BofwCertifContratista'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BONovelty'), 'PAQUETE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD30', sysdate, '487756', 'Se modifica la sentencia de consulta de los consumos pendientes por facturar
Se entrega solución a la situación reportada para la funcionalidad Generación de Cargos, según punto pendiente Sao 487756.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBCConssesu'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIX_CONSSESU14'), 'INDEX');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD31', sysdate, '489084', 'En el proceso atención del cambio de ciclo, se agrega la evaluación del escenario en el cual el periodo de facturación actual del ciclo origen y del ciclo destino tienen el mismo año-mes y el proceso de cierre de ambos periodos es realizado de forma paralela, para que así se logre ejecutar el proceso.
Se entrega solución a la situación reportada para la funcionalidad Atención del cambio de ciclo en el cierre de periodo., según punto pendiente Sao 489084.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('MO_BOBillingDataChange'), 'PAQUETE');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD32', sysdate, '487756', 'Se modifica la sentencia de consulta de los diferidos con saldos pendientes para generar cuota mensual.
Se modifica consulta de valor cobrado en el cargo para el proceso de recuperación
Se entrega solución a la situación reportada para la funcionalidad Generación de Cargos, según punto pendiente Sao 487756.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBCCargos'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIX_DIFE_NUSE'), 'INDEX');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD33', sysdate, '490123', 'Se modifica el subproceso subproceso 6. Retiro de productos en estado "Retirado con financiación”, del proceso de Cierre de Periodo de Facturación FCPE, para que no genere inconsistencias en caso de que producto tenga saldo a favor
Se entrega solución a la situación reportada para la funcionalidad Cierre de Periodo de Facturación - FCPE, según punto pendiente Sao 490123.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkServNumberMgr'), 'PAQUETE');




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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD34', sysdate, '491133', 'Se crea un nuevo índice en el esquema de la base de datos para optimizar el tiempo de ejecución de una de las consultas de órdenes empleadas en la funcionalidad.
El nuevo índice busca por:
    Suscriptor
    Estado de la orden
    Tipo de trabajo
Se entrega solución a la situación reportada para la funcionalidad CNCRM, según punto pendiente Sao 491133.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('gc_bcDebtManagement'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIDX_OR_ORDER40'), 'INDEX');




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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD35', sysdate, '492019', 'Se realizan ajustes a sentencias de la generación de obligaciones para que resuelvan por un índice correcto
Se entrega solución a la situación reportada para la funcionalidad CTGOC -> Generación de Obligaciones a Contratistas, según punto pendiente Sao 492019.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BCContract'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD36', sysdate, '495419', 'No se valida la existencia de periodos de gracia al calcular los valores de Abono a capital e Intereses para realizar la simulación de las cuotas de las financiaciones para catalogar los saldos de los diferidos de corto o largo plazo


Se entrega solución a la situación reportada para la funcionalidad Generación de Información de Cartera por Comprobante y Concepto - ICBGIC, según punto pendiente Sao 495419.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkDeferredMgr'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BCGracePeriod'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD37', sysdate, '493917', 'No se valida la existencia de periodos de gracia al calcular los valores de Abono a capital e Intereses para realizar la simulación de las cuotas de las financiaciones para catalogar los saldos de los diferidos de corto o largo plazo
Se entrega solución a la situación reportada para la funcionalidad Generación de Información de Cartera por Comprobante y Concepto - ICBGIC, según punto pendiente Sao 493917.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GC_BODebtNegotiation'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_PARAMETER_NEGO_CONC_AJUSTE_20191126'), 'GE_PARAMETER');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_PARAMETER_NEGO_FLAG_AJUSTE_20191125'), 'GE_PARAMETER');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD38', sysdate, '510023', 'Se modifica el CURSOR cuFinishReve para que la fecha de registro del programa de reversión sea mayor a la fecha de generación.  Se eliminó criterio de selección ambiguo sobre coprprog. 
Se entrega solución a la situación reportada para la funcionalidad
 Función fblFinishedReverse que Verifica si el proceso de reversión para la fecha de movimiento esta finalizado. 
, según punto pendiente Sao 510023.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBCConcproc'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD39', sysdate, '512497', 'Se modifican los mensajes de advertencia para establecer si el cruce de fechas se está dando sobre períodos de consumo o períodos de facturación en la creación de los mismos. Se modifica el método además el método ValCruceFechIndividualAbono para que use un código de mensaje específico en el cruce de las fechas de inicio de cargo básico.
Se entrega solución a la situación reportada para la funcionalidad Consola de Facturación - FACOF., según punto pendiente Sao 512497.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBOConsumptPeriod'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_MENSAJE_900062_OPF_BIL_20200707'), 'MENSAJE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('upd_MENSAJE_10194_OPF_BIL_Sao513288'), 'MENSAJE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('upd_MENSAJE_18533_OPF_BIL_Sao513288'), 'MENSAJE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD40', sysdate, '515433', 'Se crearon cuatro índices que permitan mejorar la selectividad de la consulta, teniendo como base el índice IX_IC_MOVIMIEN02.
Se entrega solución a la situación reportada para la funcionalidad Generación de Registros Contables - ICGIC., según punto pendiente Sao 515433.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBOAccountingRecord'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIX_IC_MOVIMIEN14'), 'INDEX');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIX_IC_MOVIMIEN13'), 'INDEX');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIX_IC_MOVIMIEN12'), 'INDEX');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIX_IC_MOVIMIEN11'), 'INDEX');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD41', sysdate, '514387', 'Se modifica ordenamiento de cursor Cunotas en objeto PKBOACCOUNTINGINTERFACE para optimizar procesamiento de cargos para generación de hechos económicos. 
Se entrega solución a la situación reportada para la funcionalidad Generación de hechos económicos., según punto pendiente Sao 514387.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBOAccountingInterface'), 'PAQUETE');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD42', sysdate, '517315', 'Se modifica Secuencia SEQ_OR_ORDER_ACTIVITY para que esta sea cíclica y su tope máximo no supere el valor de los 2.100.000 para evitar error de desbordamiento numérico por procesos de creación de actividades de órdenes que usan tablas PL con declaración de variables de índice Binary_Integer.
Se entrega solución a la situación reportada para la funcionalidad Creación de Actividades de Órdenes, según punto pendiente Sao 517315.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crSEQ_OR_ORDER_ACTIVITY'), 'SECUENCIA');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD43', sysdate, '518019', 'Se modifica Secuencia SEQ_OR_ORDER_ACTIVITY para que esta sea cíclica y su tope máximo no supere el valor de los 2.100.000 para evitar error de desbordamiento numérico por procesos de creación de actividades de órdenes que usan tablas PL con declaración de variables de índice Binary_Integer.
Se entrega solución a la situación reportada para la funcionalidad Creación de Actividades de Órdenes, según punto pendiente Sao 517315.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crSEQ_OR_ORDER_ACTIVITY'), 'SECUENCIA');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD44', sysdate, '516950', 'Se realizan modificaciones  para agregar traza al proceso y así identificar los consumos que serán liquidados.
Se modifica para agregarla validación pkBCConssesu.fblValidateConsProd al proceso y así identificar que el CARGCODO procesado pertenezca al producto en gestion .
Se entrega solución a la situación reportada para la funcionalidad Se realizan modificaciones en el proceso de liquidación de consumos en el proceso masivo e individual. , según punto pendiente Sao 516950.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBORatingMemoryMgr'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBCConssesu'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('LiqChargesConsByRanks'), 'FUNCION');


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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD45', sysdate, '521868', 'Se impacta la liquidación de contratistas de manera que primero se liquide la orden y posterior a esto se genere la novedades por condiciones de novedad. Con esto se pretende evitar problemas en las instancias que son utilizadas en las reglas de condiciones simples y formuladas.
Se entrega solución a la situación reportada para la funcionalidad Generación de obligaciones, según punto pendiente Sao 521868.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOLiquidationProcess'), 'PAQUETE');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD46', sysdate, '522540', 'En el marco del calculo de intereses de financiación que se realiza para  los métodos con tasa variable, se modifica para controlar que la porcentaje de interés a aplicar no sea mayor a la tasa de usura vigente para la fecha.Se entrega solución a la situación reportada para la funcionalidad Cálculo de interés de financiación, según punto pendiente Sao 522540.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkEffectiveInterestRateMgr'), 'PAQUETE');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD47', sysdate, '526119', 'Se modifica la secuencia seqWF_INSTANCE_ATTRIB disminuyendo su límite máximo por debajo del entero máximo representable en 32 bits y se hace ciclica de modo que se previenen futuros desbordamientos.Se entrega solución a la situación reportada para la funcionalidad FLUJOS DE NEGOCIO, según punto pendiente Sao 526119.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crSEQ_WF_INSTANCE_ATTRIB'), 'SECUENCIA');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD48', sysdate, '527178', 'Se modifica el proceso de legalización de órdenes para que, al buscar el valor del ítem en la lista de costos el sistema lo haga con la fecha fin de ejecución de la orden y no con el SYSDATESe entrega solución a la situación reportada para la funcionalidad GEMPL - Listas de Costos, ORCAO - Gestión de Órdenes., según punto pendiente Sao 527178.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOItemValue'), 'PAQUETE');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD49', sysdate, '527509', 'Se modifica la DLL (OpenSystems.General) - GEMPL para que al setear la fecha inicial de vigencia de una nueva lista de costos se realice con formato corto (DD/MM/YYYY). Se entrega solución a la situación reportada para la funcionalidad GEMPL - Listas de Costos, según punto pendiente Sao 527509.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.General'), 'DLL');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD50', sysdate, '527178', 'Se modifica el proceso de legalización de órdenes para que, al buscar el valor del ítem en la lista de costos el sistema lo haga con la fecha fin de ejecución de la orden y no con el SYSDATESe entrega solución a la situación reportada para la funcionalidad GEMPL - Listas de Costos, ORCAO - Gestión de Órdenes., según punto pendiente Sao 527178.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOItemValue'), 'PAQUETE');



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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD51', sysdate, '527153', 'Se modifica la funcionalidad para que periódicamente refresque las tarifas en la memoria.Se entrega solución a la situación reportada para la funcionalidad Liquidación de Tarifas, según punto pendiente Sao 527153.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('TA_BOTarifas'), 'PAQUETE');



COMMIT;
DBMS_OUTPUT.PUT_LINE ('Entrega creada con éxito');

EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al aplicar la entrega ');

END;
/