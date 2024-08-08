DECLARE
nuCodigoEntrega NUMBER; -- Código de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD541', sysdate, '401496', 'Se estaba presentando inconsistencias al momento de registrar una negociación de deuda, ya que en el momento del registro de la negociación, cuando el método de pago es una financiación, se registraba una fecha de expiración del pago al momento del registro, pero al realizar el calculo desde el flujo (Actividad espera pago cuota inicial), que utiliza la misma función que el registro de la financiación, se calculaba otro valor.  Lo anterior debido a que en el flujo se estaba tomando un periodo de facturación diferente al actual.
Se modifica el objeto que calcula la fecha de expiración para no utilizar CACHE en el proceso.
Se entrega solución a la situación reportada para la funcionalidad Negociación de Deuda, según punto pendiente Sao 401496.');

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

DECLARE
nuCodigoEntrega NUMBER; -- Código de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD542', sysdate, '409831', 'Se modifican los procesos de reasignación y desasignación de órdenes desde  ORGOS, para que valide que el estado de la orden sea consistente y realice un bloqueo de la misma para que no sea tomada por otro proceso.
Se entrega solución a la situación reportada para la funcionalidad Gestión de órdenes de solicitudes [ORGOS], según punto pendiente Sao 409831.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOProcessOrder'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD543', sysdate, '411503', 'Se modifica servicio de validación de topes de contrato, para que en el proceso de legalización se verifique  sin tener en cuenta el valor asignado del contrato.
Se entrega solución a la situación reportada para la funcionalidad Topes de contrato, según punto pendiente Sao 411503.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOContract'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD544', sysdate, '411598', 'Se modifica el proceso de reversión de novedad para que si el contrato de la orden padre no esta cerrado lo copie a la orden de reversión. En caso contrario se le asociará un contrato abierto del contratista.
Se entrega solución a la situación reportada para la funcionalidad Reversión de novedad - CTRNL, según punto pendiente Sao 411598.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD545', sysdate, '409297', substr('Cuando se realiza un cambio de medidor el mismo día en que exista una lectura de facturación, se esta modificando la lectura de facturación al nuevo medidor, incluso si esta fue tomada primero y el cambio de medidor fue realizado horas despues.  Esto ocasiona que se presenten inconsistencias al momento de realizar el calculo de recuperacion de consumos por medio de la función RECUCOHA.
Se modifica el proceso de cambio de medidor para que valide la fecha con horas, minutos y segundos en que se realiza el cambio de medidor, para que modifique las lecturas de facturación posterior a la fecha fin de ejecución de trabajos.   
Se entrega solución a la situación reportada para la funcionalidad Cambio de Medidor, según punto pendiente Sao 409297.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOCalcConsumpServs'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkMeasurementReadingMgr'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBCPericose'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOLectelme'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD546', sysdate, '409418', substr('Al abrir dos solicitudes de traslado de diferido a corriente del contrato (FTDU) en sesiones diferentes, permitía la ejecución de ambas, y aunque solo dejaban cargos registrados de una solicitud, en el sistema quedaban los registros de dos solicitudes procesadas.
Se crea un nuevo objeto para permitir el bloqueo de la solicitud de "traslado de diferido a corriente del contrato - FTDU", para evitar que esta sea desplegada en dos sesiones diferentes. 
Se entrega solución a la situación reportada para la funcionalidad Traslado de Diferido a Corriente del Contrato - FTDU, según punto pendiente Sao 409418.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkFB_UIDefToCurTransfer'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD547', sysdate, '410371', 'Se corrigue inconveniente presentado al momento de consultar las órdenes para asignación.
Se entrega solución a la situación reportada para la funcionalidad Gestión de órdenes asociadas a solicitudes [ORGOS], según punto pendiente Sao 410371.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BCORDER'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD548', sysdate, '411730', 'Se corrige el error en el cálculo de liquidación del contrato al momento de generar un acta de liquidación del anticipo.
Adicionalmente se publica la forma Definir Contrato - CTDEC en el tab de novedades en CTCCO.
Se entrega solución a la situación reportada para la funcionalidad Valor liquidado del contrato, según punto pendiente Sao 411730.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CTCCO'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CTCCO_MENU_OPTIONS'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BoCertificate'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crTRGSA_EXECUTABLE01'), 'TRIGGER');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD549', sysdate, '411528', substr('Se estaban quedando productos con estado de "Número de Proceso" (SUSCNUPR) en 2 cuando estos no estan en proceso de facturación.
El inconveniente se presentaba por una validación, en la cual si el contrato en proceso tiene asociado una solucitud no recurrente de constructoras, se saltaba el proceso y no reestablecia el SUSCNUPR a 0.
Se modifica para que tenga en cuenta en esta validación, que se restablezca el estado del SUSCNUPR para dicho contrato cuando se salte el proceso de generación de cuentas.
Se entrega solución a la situación reportada para la funcionalidad Generación de Cuentas - FGCC, según punto pendiente Sao 411528.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkGenerateBill'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD550', sysdate, '408946', substr('El proceso de insolvencia económica estaba dejando en el producto origen, cargos de interés de diferido a causa del traslado de diferido a corriente para la cartera diferida del proceso de insolvencia.  Esto se debía a que la fecha con que se calculaba el interés era la fecha de ejecución de la solicitud y no la fecha de insolvencia económica.
Se modifica el proceso para que calcule el interés de financiación de un traslado de cartera diferida de insolvencia, de acuerdo a la fecha de inicio de insolvencia y no la fecha actual del sistema.  
Se entrega solución a la situación reportada para la funcionalidad Proceso de Insolvencia Económica, según punto pendiente Sao 408946.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BODefToCurTransfer'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkTransDefToCurrDebtMgr'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkFB_UIDefToCurTransfer'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GC_BOInsolvency'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD551', sysdate, '405446', 'Cambio de esquema para la secuencia de la tabla de contenedores GUI (SEQ_GI_FRAME).
Se entrega solución a la situación reportada para la funcionalidad Componentes GUI, según punto pendiente Sao 405446
Se entrega solución a la situación reportada para la funcionalidad Proceso de Insolvencia Económica, según punto pendiente Sao 408946.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crSEQ_GI_FRAME'), 'SECUENCIA');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD552', sysdate, '409654', substr('Se estaban generando inconsistencias al momento en que se asentaba una negociación de deuda y paralelamente se ejecutaba la generación de cargos "FGCA" para el ciclo del mismo contrato de la negocaición.  En este escenario se estaba duplicando el valor cobrado en los diferidos (uno por cuota normal de diferido, y otro por el valor trasladado a causa de la negociación).
Se modifica el proceso para determinar si al momento de asentar una negociación de deuda, está en ejecución el proceso FGCA, y de ser asi, generar excepción para volver a relanzar el flujo cuando el proceso FGCA haya finalizado. 
Se entrega solución a la situación reportada para la funcionalidad Negociación de deuda., según punto pendiente Sao 409654.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_MESSAGE_905316_20170405'), 'CONFIGURACION');
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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD553', sysdate, '413104', 'Se corrige el error presentado en el valor en reclamo cuando se consulta un producto que tiene varios reclamos abiertos y uno anulado.
Se entrega solución a la situación reportada para la funcionalidad Certificado de Estado de cuenta por fecha, según punto pendiente Sao 413104.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FA_BCAccountStatusToDate'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD554', sysdate, '415647', 'Se modifica la sentencia que trae las ordenes a asignar para mejorar rendimiento
Se entrega solución a la situación reportada para la funcionalidad ORGOS - Gestión de Órdenes Asociadas a Solicitudes, según punto pendiente Sao 415647.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BCORDER'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD555', sysdate, '414687', 'Se modifica la función PR_BCPromotion.fnuGetCurrentMonth encargada de obtener el mes actual de la promoción, para que devuelva 1 (primer mes) cuando la fecha incial de la promoción sea igual a la fecha final del periodo de consumo vigente. Se entrega solución a la situación reportada para la funcionalidad PR_BCPromotion.fnuGetCurrentMonth , según punto pendiente Sao 414687.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('PR_BCPromotion'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD556', sysdate, '414918', 'Se corrige el error que se presentaba al intentar procesar un ítem donde la unidad destino tuviera el valor máximo en los campos balance y balance ocasional.
Se entrega solución a la situación reportada para la funcionalidad Traslado de items ORPTM, según punto pendiente Sao 414918.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOFWItemsMove'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD557', sysdate, '413605', 'Se modifica el proceso de reconexión voluntaria para que en caso que la ultima orden asociada al motivo no este legalizada con clase de causal de éxito, no se reconecte.
Se entrega solución a la situación reportada para la funcionalidad Reconexión voluntaria, según punto pendiente Sao 413605.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('MO_BOSuspension'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD558', sysdate, '414520', 'Se modifica para que al realizar traslado de diferido a corriente a partir de la negociación, todos los cargos se generen en una nueva cuenta de cobro. 
Se entrega solución a la situación reportada para la funcionalidad Negociación de la Deuda GCNED , según punto pendiente Sao 414520.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkTransDefToCurrDebtMgr'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD559', sysdate, '415969', 'Se corrige el error que se estaba presentando al cerrar una orden con contrato definido y que no estaba disminuyendo el valor asignado del contrato. 
Se entrega solución a la situación reportada para la funcionalidad Legalición de órdenes de contratistas, según punto pendiente Sao 415969.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOContract'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD560', sysdate, '413844', 'Se agrega control para que la dirección asociada al cliente deba existir en la entidad de direcciones
Se entrega solución a la situación reportada para la funcionalidad CNCRM - Atención al Cliente, según punto pendiente Sao 413844.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crFK_GE_SUBSCRIB_AB_ADDRESS02'), 'CONSTRAINT');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD561', sysdate, '416368', substr('Al agregarse el control para evitar que en el instante en que se vaya a asentar una negociación, el proceso de generación de cargos FGCA estuviera en ejecución, este no estaba realizando la excepción esperada, ya que se estaba validando las sesiones activas mediante el campo PROCEJEC.PREJPRID, pero el proceso FGCA no deja registro de las sesiones activas en este campo, sino que las sesiónes activas quedan en los registros de ESPRSEPE.EPSPIDPR.
Se modifica el proceso para realizar las validaciones sobre las sesiones activas del proceso FGCA desde los registro de ESPRSEPE asociados. 
Se entrega solución a la situación reportada para la funcionalidad Negociación de Deuda - GCNED, según punto pendiente Sao 416368.',0,500));

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD562', sysdate, '416411', substr('Cuando se estaba realizando el analisis de consumos críticos, y se modificaba la lectura del periodo de consumo actual, el sistema estaba tratando de recuperar la lectura del siguiente periodo, pero en el siguiente periodo no existía lectura, y por lo tanto, el registro que obtenía era nulo y al procesar en esta condición, generaba una excepción no controlada.
Se modifica el proceso para evitar que cuando se vaya a modificar un periodo posterior, y en este no exista lectura, no realice modificación y continue con el proceso, para asi evitar la excepción no controlada.   
Se entrega solución a la situación reportada para la funcionalidad Análisis de Consumos Críticos - FOVC, según punto pendiente Sao 416411.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOConsCorrectEngine'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD563', sysdate, '4149263', substr('Se estaban presentando solicitudes de negociación de deuda, en las cuales los registros de la negociación estaban quedando inconsistente respecto a los datos de la financiación, cuando el método de pago es financiado.  Esto causaba que al ingresar el pago inicial de la negociación, no se asentara la financiación por las diferencias entre los datos.
La inconsistencia se presentaba porque se tenía configuradada una acción por evento al momento de seleccionar los productos de la negociación.  Cuando era del tipo de producto "BRILLA", se mostraba un mensaje de excepción indicando que el producto BRILLA no se puede negociar.  Pero despues de esto, el mensaje se seguía repitiendo para los demas tipos de productos, sin ser estos de BRILLA, y al continuar con la negociación, esta quedaba con datos inconsistentes.   
Se modifica el proceso de validación de productos seleccionados en la negociación, para establecer el código del producto en memoria al iniciar proceso, para que este sea visible en todo el proceso de validación.
Se entrega solución a la situación reportada para la funcionalidad Negociación de Deuda - GCNED, según punto pendiente Sao 414926.',0,500));

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD564', sysdate, '416076', 'Se corrige el problema de rendimiento que se presentaba al realizar el proceso de Generación de obligaciones a contratistas para un contrato con muchas ordenes legalizadas.
Se entrega solución a la situación reportada para la funcionalidad Generación de obligaciones a contratistas, según punto pendiente Sao 416076.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BCContract'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIDX_OR_ORDER21'), 'INDICE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIDX_OR_ORDER35'), 'INDICE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('drIDX_OR_ORDER23'), 'INDICE');
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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD565', sysdate, '418888', 'A pesar de que el parámetro CM_VARS_AVG_MAX_DAYS se encontraba en cero (0), el sistema estaba calculando promedio con el valor ingresado y con el valor vigente.
Se valida que no se calcule el valor promedio de la variable registrada por CMRVF, cuando el valor del parámetro CM_VARS_AVG_MAX_DAYS sea cero (0).
Se entrega solución a la situación reportada para la funcionalidad Generación y Crítica de Consumos, según punto pendiente Sao 418888.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOCorrectFactorsVars'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD566', sysdate, '417234', substr('El sistema en la generación de consumos de productos no leidos, no esta contemplando el escenario en donde para un mismo periodo de consumo, existan registros de consumos de dos elementos de medición a causa de una cambio en el medidor telemedido.  En este caso, el sistema solo está calculando el consumo del elemento de medición actual, dejando registros de consumo sin tener en cuenta para el calculo total del consumo en el periodo.  Cuando utilizan la función constructora en la actividad de cambio de medidor, el consumo que se genera está asociado específicamente a los días del periodo de consumo, por lo tanto, si el medidor es retirado y solo han pasado por ejemplo dos días del periodo de consumo, el consumo generado quedará con un total de días de consumo de 30.
Se modifica al función constructora para el calculo de consumos telemedidos, para que tenga en cuenta los registros de consumo de todos los medidores que puedan haber en un periodo de consumo a causa de cambios de elemento de medición. 
Se entrega solución a la situación reportada para la funcionalidad Generación y Análisis de Variación de Producción - CMGAP cmgapCCC, según punto pendiente Sao 417234.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOConsLogicService'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD567', sysdate, '416714',substr( 'Cuando se aplicaba un pago sobre un producto que no tenia deuda pendiente y el estado de corte del producto era no facturable, el sistema estaba registrando el pago pero no estaba generando los respectivos cargos asociados al pago (pago y saldo a favor).  Lo anterior se debía a que el sistema busca productos en estado facturable para agregarle el saldo a favor.
Se modifica la forma de agregar el saldo a favor proveniente del pago, para que se tenga en cuenta productos en estado no facturable.
Se entrega solución a la situación reportada para la funcionalidad Recaudos, según punto pendiente Sao 416714.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkCollectingMgr'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD568', sysdate, '414742', 'Se corrige el error que se presentaba en la forma de Registro de Reclamo por Cargos, cuando el valor del cargo era mayor a 999.999.999 no se mostraban los siguientes dígitos del inicio. 
Se entrega solución a la situación reportada para la funcionalidad Registro de Reclamo por Cargos, según punto pendiente Sao 414742.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Claim.GUI'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD569', sysdate, '415000', 'Se presenta error al momento de procesar un cambio de plan comercial para un producto cuyo contrato tiene diferentes tipos de producto.  La inconsistencia se debía a un mal manejo de variables en memoria en el proceso.  
Se modifica el proceso de cambio de plan para establecer correctamente en memoria la información de cada producto que se procesa.
Se entrega solución a la situación reportada para la funcionalidad Gestión de Productos, según punto pendiente Sao 415000.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkFgca'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FA_BOChangeBillPlan'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD570', sysdate, '417070', 'Se adiciona Validación donde si el número de hora es =0 no  realice la división por Cero y el porcentaje a compensar sea cero
Se entrega solución a la situación reportada para la funcionalidad FGCA - liquidación de compensaciones, según punto pendiente Sao 417070.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FA_BODiscountTimeOutServ'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD571', sysdate, '419135', substr('Se estaba presentando mensaje de error al momento de realizar la financiación de una venta.  La inconsistencia se debía a que la simulación del flujo de cuotas no era igual al numero de cuotas establecido en la financiación.  Esto se generaba porque se registró inicialmente la financiación a la tasa de usura, pero al asentar la financiación la tasa de usura cambió, siendo diferente la tasa en le calculo del flujo de cuotas en la simulación.  Esta diferencia hacía que el flujo de cuotas fuera diferente al establecido inicialmente.
Se modifica el proceso de simulación de cuotas del diferido para que solo para efectos de simulación, tome siempre la misma tasa con que se registró la financiación, con el objetivo de poder realizar el flujo de cuotas acorde con el número de cuotas pactado. 
Se entrega solución a la situación reportada para la funcionalidad Financiación de deuda, según punto pendiente Sao 419135.',0,500));

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD572', sysdate, '419157', substr('Se presentaba inconsistencia al momento del registro de una cotización.  Cuando se realizaba el registro y aprobación de la cotización y el flujo no se encontraba en la actividad "Proceso de Aprobación de Cotización".  Al aprobar una cotización en este escenario, el sistema no encontraba actividad de workflow a notificar, por lo tanto, no realizaba dicha notificación y cuando el flujo llegaba a la actividad "Proceso de Aprobación de Cotización" no avanzaba ya que espera la notificación del proceso.
Se modifica el proceso de registro de cotización para validar que el flujo se encuentre en la actividad adecuada para asegurar de esta forma que siempre encuentre la actividad que debe notificar para poder continuar con el proceso.   
Se entrega solución a la situación reportada para la funcionalidad Registro/Impresión de Cotización, según punto pendiente Sao 419157.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BOQuotationRegistry'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_MESSAGE_911102_20170710'), 'CONFIGURACION');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD573', sysdate, '419135', substr('Se presenta inconsistencia al momento de simular la financiación, ya que existen diferencia entre el porcentaje de interes registrado al momento del registro de la financiación, y el porcentaje utilizado al momento de la simulación del flujo de cuotas, haciendo que el numero de cuotas pactado en la financiación sea diferente al número de cuotas simulado.
Se modifica el proceso de simulación de la financiación para que no tenga en cuenta la validación sobre tasa de usura, ya que para efectos de simulación del flujo de cuotas, se debe procesar con el mismo porcentaje pactado al momento del registro de la financiación. 
Se entrega solución a la situación reportada para la funcionalidad Financiación de Deuda, según punto pendiente Sao 419135.',0,500));

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD574', sysdate, '416142', substr('Se corrige el error de rendimiento que se presentaba en el cálculo valor promedio por tipo de trabajo.
Se entrega solución a la situación reportada para la funcionalidad Cálculo valor promedio por tipo de trabajo, según punto pendiente Sao 416142.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('Ge_BCDetalleActa'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD575', sysdate, '419879', 'Se modifica el proceso de legalización de órdenes para que valide que la fecha de inicio de ejecucion no sea menor a la fecha actual menos los días configurados en el parámetro VALID_INIT_EXEC_DATE.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('Or_BOLegalizeActivities'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_MESSAGE_913132_20170728'), 'CONFIGURACION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_PARAMETER_VALID_INIT_EXEC_DATE_20170728'), 'CONFIGURACION');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD576', sysdate, '420340', 'Se modifica para que al cerrar la forma, ésta no quede bloqueada.
Se entrega la solución a la situación reportada para la funcionalidad Configuración y Gestión de Proyectos - PMCGP en el sao punto pendiente 420340.
Se entrega solución a la situación reportada para la funcionalidad configuración y gestión de proyectos - PMCGP, según punto pendiente Sao 420340.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('PM_BOProject'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD577', sysdate, '419909', substr('Se modifica el proceso de Generación Individual de Órdenes de Inspección - ORGII para que valide si el contrato asociado a la orden a inspeccionar está cerrado y el contratista de ese contrato no tienen ningún otro contrato en estado diferente a Cerrado o Anulado no permita registrar la inspección.
Se modifica el proceso de Anomalías y Descargos - ORCDA para que tome el contrato de la orden original. En caso que ese contrato este cerrado, se asociará a un contrato del mismo contratista en estado diferente a Cerrado o Anulado.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOGenOrdInspecc'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_MESSAGE_913139_20170808'), 'CONFIGURACION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOAdjustmentOrder'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD578', sysdate, '420926', substr('Según modificación realizada para poder utilizar la variable PRESION_ATMOSFERICA como una variable específica por producto (SAO 399726), allí no se tuvo en cuenta el registro del valor de la variable por producto, ya que las únicas variables que pueden ser registradas por producto son: PRESION_OPERACION y TEMPERATURA.
Se realiza modificación para permitir el registro de la variable PRESION_ATMOSFERICA por producto para que esta pueda ser cargada desde la funcionalidad FGIA y desde API.
Lo anterior para cumplir con resolución CREG 033 de 2015.
Se entrega solución a la situación reportada para la funcionalidad Registro de Variables para Factor de Corrección, según punto pendiente Sao 420926.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOCorrectFactorsVars'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD579', sysdate, '420066', 'Se corrige el problema de rendimiento que se presentaba al realizar el proceso de Generación de obligaciones a contratistas para un contrato con muchas ordenes legalizadas.
Se entrega solución a la situación reportada para la funcionalidad Generación de obligaciones a contratistas, según punto pendiente Sao 420066.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BCReads'), 'PAQUETE');
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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD580', sysdate, '419730', substr('Cuando se realizaba la agrupación de varios productos pertenecientes al mismo contrato, y uno de los productos tiene el mismo identificador del contrato, el sistema solo agrupaba el producto con el mismo identificador del contrato más no permitía la agrupación de los demás productos.
La inconsistencia se presentaba al validar si el producto en proceso ya se encontraba en una agrupación, porque en esta validación se estaba enviando el número del contrato y no el número del producto, lo anterior hacia que para varios productos con el mismo contrato validara el mismo valor.
Se modifica el proceso para enviar en la validación el número del producto en proceso y no el contrato. 
Se entrega solución a la situación reportada para la funcionalidad Agrupación Productos Otro Contrato - FASO, según punto pendiente Sao 419730.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkServSubscriberGrouping'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD581', sysdate, '422854', 'Se corrige el error que se presentaba al realizar un ajuste de ítems debido a que se estaba sobrescribiendo el estado de inventario del ítem con el estado anterior.
Se entrega solución a la situación reportada para la funcionalidad Ajuste de ítems -  ORAJI, según punto pendiente Sao 422854.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('or_boItemsMove'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD582', sysdate, '421040', substr('Se estaban asignando consumos estimados desde las reglas de analisis de variación de consumos, pero no se veía reflejado en los registros de consumos.  
La inconsistencia se presentaba porque al momento de obtener el historico de lecturas del producto, se estaba obteniendo un registro de lectura previa nulo, ocasionando esto que el consumo estimado fuera nulo y no se registrara en la entidad de consumos.
Se modifica el proceso para obtener de forma separada la lectura previa y la última lectura válida del producto, para que se garantice que se obtenga la lectura previa, ya que es con esta que se realizan los calculos del consumo. 
Se entrega solución a la situación reportada para la funcionalidad Analisis de Variación de Consumos, según punto pendiente Sao 421040.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOMeasConsumptions'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BCMeasConsumptions'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD583', sysdate, '419156', 'Se corrije el error reportado para que quede consistente la información del contrato y cliente, en la actividad de la orden de lectura. 
Se entrega solución a la situación reportada para la funcionalidad Generación de lecturas, Análisis masivo de consumos críticos y análisis de consumo crítico., según punto pendiente Sao 419156.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBOReadingGeneration'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD584', sysdate, '422310', substr('Se modifica por requerimiento de cliente, dado que no estaba permitido ejecutar la desinversión cuando el producto tenía cualquier trámite pendiente, incluyendo al trámite de venta a constructoras. Debido a que dicha venta puede tomar años y los producto que fueron instalados bajo esta modalidad operan normalmente mientrás el  trámite aún se encuentra abierto, se exluye la venta a constructoras de los impedimentos para ejecutar el proceso.   
Se entrega solución a la situación reportada para la funcionalidad Desinversión de Medidores, según punto pendiente Sao 422310.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BCChangeMeter'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD585', sysdate, '423526', substr('No se estaba generando notificación al momento acceder a una entidad desde el contexto de navegación (accediendo por la llave primaria del Tab), el incidente se presentaba porque la notificación solo se realizaba desde el contexto de búsqueda cuando se accedía a la entidad, pero una vez se ingresa a la información y se navegaba por los diferentes tabs, el sistema no generaba notificación.
Se modifica el proceso de notificación en el PI, para que al acceder a un registro desde su llave primaria en el contexto de navegación de la información, también se despliegue las notificaciones configuradas. 
Se entrega solución a la situación reportada para la funcionalidad Notificaciones, según punto pendiente Sao 423526.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Presentation.Executor'), 'FORMA');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD586', sysdate, '424759', 'Se modifica el proceso de cierre de actas para registrar un log que permita identificar el usuario que lo ejecuta.
Se entrega solución a la situación reportada para la funcionalidad Cierre de actas, según punto pendiente Sao 424759.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('Ge_BoCertifContratista'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD587', sysdate, '425048', substr('Al generar las cuentas para productos con solicitudes de venta a constructoras, estas presenta inconsistencia al momento de aplicar el depósito, ya que el valor amortizado no corresponde con lo que debería aplicarse.
La inconsistencia se presenta porque el calculo del valor a aplicar se está realizando con el saldo disponible del depósito, y no con el valor total inicial del depósito.  El saldo del depósito debe ser utilizado solo para validar el valor disponible y poder realizar el ajuste, pero el calculo del valor a amortizar se debe realizar con el valor inicial del depósito.   Se entrega solución a la situación reportada para la funcionalidad Generación de Cuentas FGCC, según punto pendiente Sao 425048.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBCSaldfavo'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkAccountMgr'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD588', sysdate, '422667', 'Se mejora la transaccionalidad del proceso que permite el acceso al sistema.
Se entrega solución a la situación reportada para la funcionalidad Herramientas del sistema - Seguridades., según punto pendiente Sao 422667.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('SA_BOSystem'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD589', sysdate, '419876', '419876  - Ref. Hallazgo34. Se modifica el proceso de cierre de contrato para que en caso de que el contrato tenga órdenes pendientes de liquidar no permita hacer el cierre y despliegue error.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOContract'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_MESSAGE_913178_20170824'), 'CONFIGURACION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOAdjustmentOrder'), 'PAQUETE');
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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD590', sysdate, '424491', 'Se restringe la actualización de promedios para que solo sea llevada a cabo después de ejecutar el proceso de cierre de crítica del periodo y antes de que se lleve a cabo el proceso de generación de lecturas del periodo siguiente.
Se entrega solución a la situación reportada para la funcionalidad Promedio de consumo, según punto pendiente Sao 424491.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOAvgConsServ'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BCAvgConsServ'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD591', sysdate, '421312', 'Se modifica el proceso de insolvencia para tener en cuenta los cargos de impuesto generados durante el proceso de traslado de diferido a corriente y asignarlos al contrato espejo.Se entrega solución a la situación reportada para la funcionalidad Insolvencia económica, según punto pendiente Sao 421312.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GC_BCInsolvency'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD592', sysdate, '425795-425814', substr('Se modifica el registro de recursos de reclamaciones para actualizar la cartera en reclamo antes de finalizar el proceso.
Se entrega solución a la situación reportada para la funcionalidad Reclamaciones, según punto pendiente Sao 425795.
Al registrar una solicitud de reclamo que es de atención inmediata, el sistema no aumenta cartera reclamada, pero al momento de anular una solicitud de este tipo, el sistema esta disminuyendo el valor reclamado, ocasionando esto que se genere un valor en reclamo negativo.  Se modifica el proceso de anulación para que identifique si la solicitud fue de atención inmediata, y de ser asi, no disminuya cartera. 
Se entrega solución a la situación reportada para la funcionalidad Anulación de Solicitudes de Reclamos, según punto pendiente Sao 425814.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BOClaimHandler'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD593', sysdate, '425523', substr('Cuando se ejecuta la solicitud de impresión de pagos parciales, el sistema al finalizar el proceso despliega un mensaje informando que el proceso se ejecutó con exito.  Si este mensaje no se cierra y se pierde la conexión, quedan información de asociación temporal que no se borra.  Estos datos que se quedan allí generan posteriormente inconvenientes en el proceso de impresión de factiras FIDF.
Se modifica el proceso para que primero elimine las asociaciones temporales y posterioremente genere la impresión de l cupon.
Se entrega solución a la situación reportada para la funcionalidad Impresión de Pagos Parciales, según punto pendiente Sao 425523.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Printing'), 'FORMA');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD594', sysdate, '424547', substr('Al ejecutar el proceso de traslado de diferidos entre servicios para un producto, en el momento en que simultaneamente se encuentra en ejecución el proceso de generación de cargos FGCA, se esta descontando tanto el valor del diferido por traslado, como la generación del cargo por cuota del diferido.
Se modifica el proceso de traslado de diferidos entre servicios - FTDS, para que valide si se encuentra en ejecución el FGCA, y de ser asi, no permita ejecutar el proceso hasta que éste finalice. 
Se entrega solución a la situación reportada para la funcionalidad Traslado de Diferidos entre Servicios - FTDS, según punto pendiente Sao 424547.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkDeferred'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('upd_GE_MESSAGE_904872_Sao426543'), 'CONFIGURACION');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD595', sysdate, '422990', substr('La busqueda de solicitudes por el CNCRM a traves del número de formulario esta demorando mucho en obtener resultados.  La inconsistencia se presenta debido a que cuando se consulta solo por este campo (DOCUMENT_KEY), no hay un indice que mejore el rendimiento de la busqueda.
Se modifica la consulta para adicionar un indice por el campo MO_PACKAGES.DOCUMENT_KEY, y de esta forma mejorar el rendimiento de la consulta cuando se busca por número de formulario.
Se entrega solución a la situación reportada para la funcionalidad Consulta solicitudes por CNCRM, según punto pendiente Sao 422990.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('cc_boOssPackage'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIDX_MO_PACKAGES11'), 'INDICE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD596', sysdate, '425153', substr('Se adiciona validación al método CM_BOESTIMATESERVICES.CalcPartialConsumption para que en caso de que los días de consumo sean mayores a 999, asigne dicho valor máximo a la variable días de consumo onuConsumptionDays. 
Se entrega solución a la situación reportada para la funcionalidad Registro de Lecturas, según punto pendiente Sao 425153.',0,500));

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD597', sysdate, '428188', substr('Se corrige el error que se presentaba al realizar un traslado de ítems donde el movimiento estaba quedando con valor cero aunque el ítem tenia valor en la unidad.
Se entrega solución a la situación reportada para la funcionalidad Traslado de ítems, según punto pendiente Sao 428188.
Con esta entrega se modifica la forma en que se actualizan los campos de balance y costo del ítem en la entidad de saldos por ítems de unidad. Anteriormente se hacía actualizando dos veces la entidad, primero el balance y luego el costo. Con esta modificación se hace todo en una transacción lo cual afecta el trigger TRG_AUROR_OPE_UNI_ITEM_BALA. Favor validar si existen personalizaciones en el trigger que se vean afectadas con esta modificación y realizar los cambios necesarios. ',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOOpeUniItemBala'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD598', sysdate, '431142', 'Se corrige el error que se presentaba al aceptar un ítem seriado que no era enviado o recibido por un centro de reparación o recibido por un laboratorio y que dejaba el ítem en un estado incorrecto. Se entrega solución a la situación reportada para la funcionalidad Aceptación de ítems en tránsito – ORPAM, según punto pendiente Sao 431142.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOFWItemsMove'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD599', sysdate, '428266', substr('Cuando se legalizaba una lectura de facturación que recuperaba consumos de periodos anteriores, se estaba modificando el consumo promedio del producto.  La situación se debía a una inconsistencia en el cursor que obtenía la información de los periodos para validar si debía o no actualizar consumos promedios.
Se modifica el cursor para obtener la información correcta de los periodos de consumo y validar de forma correcta si se debe actualizar los consumos promedios o no.
Se entrega solución a la situación reportada para la funcionalidad Consumos Medidos, según punto pendiente Sao 428266.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BCAvgConsServ'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD600', sysdate, '431196', substr('Cuando se recuperaban consumos por RECUCOHA a causa de un cambio de medidor tardío, y habían lecturas proyectadas entre el medidor anterior y el medidor nuevo, la lectura proyectada no correspondía a un dato coherente y por lo tanto la recuperación que hacia el sistema quedaba inconsistente.
Se modifica el proceso RECUCOHA para que cuando detecte una proyeccíon de lecturas en la recuperación no tome dicha proyección ya que no es correcta, sino que tome la lectura origial tomada.
se entrega solución a la situación reportada para la funcionalidad Recuperación de consumos hacia adelante - RECUCOHA, según punto pendiente Sao 431196.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOConsLogicService'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_PARAMETR_OBS_REVER_PROYEC_LECT_RECUCOHA_20171221'), 'CONFIGURACION');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD601', sysdate, '429442', 'Se arregla el error en el Estado de cuenta por fecha para que no tenga en cuenta las solicitudes en estado Anulado.
Se entrega solución a la situación reportada para la funcionalidad Estado de cuenta por fecha., según punto pendiente Sao 429442.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FA_BCAccountStatusToDate'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD602', sysdate, '433017', substr('El sistema no estaba realizando recuperación de consumos por la función de RECUCOHA, cuando los periodos no tenían un valor de lectura (Lectura con observación de no lectura).  Se modifica el proceso para que cuando en una recuperación por la función RECUCOHA, exista la posibilidad de recuperar consumos intermedios, lo realice teniendo en cuenta el número de periodos a recuperar. 
Se entrega solución a la situación reportada para la funcionalidad Recuperación de consumos hacia adelante - RECUCOHA, según punto pendiente Sao 433017.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CM_BOConsLogicService'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD603', sysdate, '433017', substr('Se modifica la aplicación de registro manual de novedades de liquidación de contratistas (CTNLC) para incluir un campo Contrato que permita al usuario seleccionar el contrato definido para liquidar la novedad que se genera.
Los contratos a desplegar deben cumplir con los siguientes requisitos:
Corresponder al contratista que se selecciona
Encontrarse abierto y vigente a la fecha
Ser válido para el tipo de trabajo asociado al ítem de novedad que se selecciona, ya sea por contrato o por tipo de contrato.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BONovelty'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOContractor'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper(' OpenSystems.Contractor.Certification'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crCT_tyobContracts'), 'OBJETO');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crCT_tytbContracts'), 'OBJETO');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD604', sysdate, '422742', 'Se modifica el proceso para no permitir procesar lecturas de trabajo por la funcionalidad FOVC, ya que estas lecturas estan generando inconsistencias en la corrección de lecturas por esta funcionalidad.
Se entrega solución a la situación reportada para la funcionalidad Análisis de consumos críticos - FOVC, según punto pendiente Sao 422742.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('cm_uiFOVC'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD605', sysdate, '424529', substr('Al momento de generar factura en flujo de workflow, se está estableciendo una fecha inicial y posteriormente ya finalizando el proceso, se aplica saldo a favor y este queda con la fecha inicial, pudiéndose haber liquidado cargos al momento de la generación de la cuenta, esto ocasiona que la aplicación del saldo a favor quede con una fecha menos a la de los cargos DB, siendo esto un inconveniente en la interfaz contable.
Se modifica el proceso para que se genere la aplicación del saldo a favor con la fecha actual de la creación del cargo AS.
Se entrega solución a la situación reportada para la funcionalidad Generación de Factura WorkFlow, según punto pendiente Sao 424529.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkGenerateInvoice'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD606', sysdate, '428347', substr('Se estaba generando un desbordamiento de variable al asentar financiaciones de venta de gas.  La situación se debía a que el documento soporte de la financiación lo estaba obteniendo de documento soporte del plan de financiación, pero las variables no concuerdan en tamaño, siendo la del plan de diferido más grande que la del DIFERIDO y del MOVIDIFE. Ya que este campo es informativo, se modifica el proceso para que se acote el tamaño de esta variable al momento de registrar los datos en el DIFERIDO, MOVIDIFE y CC_FINANCING_REQUEST. Se entrega solución a la situación reportada para la funcionalidad Financiación de Deuda, según punto pendiente Sao 428347.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BOFinancing'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BCWaitForPayment'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD607', sysdate, '432946', 'Se estaba presentando diferencia en el saldo reclamado en la solicitud de "Estado de Cuenta por Fecha".  La inconsistencia se debía a que el sistema no estaba teniendo en cuenta el signo del cargo en reclamo.  Se modifica el proceso para que tenga en cuenta el signo del valor en reclamo.  
Se entrega solución a la situación reportada para la funcionalidad Estado de Cuenta por Fecha , según punto pendiente Sao 432946.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FA_BOAccountStatusToDate'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD608', sysdate, '433718', 'Se corrige el error que se presentaba al calcular la fecha estimada de atención de una solicitud, cuando la solicitud se registra un día no hábil. 
Se entrega solución a la situación reportada para la funcionalidad Cálculo de fecha de atención de la solicitud, según punto pendiente Sao 433718.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('MO_BOUtilGenerateRequest'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD609', sysdate, '424438', 'Se modifica la funcionalidad para adicionar botón que permita recalcular los impuestos cuando se adicionan descuentos.
Se entrega solución a la situación reportada para la funcionalidad Negociación de Deuda, según punto pendiente Sao 424438.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GC_BODebtNegoCharges'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper(' OpenSystems.DebtNegotiation.DAL'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.DebtNegotiation.UI'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.DebtNegotiation.BL'), 'FORMA');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD610', sysdate, '424303', 'Se migra la descripción de todos los ítems existentes para que estén en mayúscula sostenida. Si existen varios ítems con la misma descripción, se adiciona consecutivo al final de la misma para eliminar la duplicidad.
Se crea índice de unicidad sobre el atributo Descripción del ítem.
Se modifican los procesos de registro de ítems, actividades y actividades administrativas para que no permitan almacenar un nuevo registro cuando existe otro ítem con la misma descripción.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_BOItemAdmin'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_BCItemAdmin'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ScriptMigracionSAO424303'), 'CONFIGURACION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_MESSAGE_913209_20170915'), 'CONFIGURACION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crUX_GE_ITEMS01'), 'INDICE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD611', sysdate, '420066',substr( 'Se realizan modificaciones de rendimiento sobre el proceso que no afectan el comportamiento de la opción.
Se entrega el JOB para ejecutar y programar desde el ejecutor de procesos (GEMPS) con el nombre: "Agrupación de órdenes de trabajo por tipo de trabajo." y con los parámetros: Tipo de Contrato y Contratista como opcionales, con el fin de limitar la agrupación de ordenes de trabajo diarias.
Se crea la forma CTAMC - Asignación Masiva de Contrato a Órdenes que permite definir un contrato a todas las órdenes ejecutadas por un contratista y que no tienen el contrato definido. La opción se encuentra en el pi de CTCCO a nivel del contrato. 
Se entrega solución a la situación reportada para la funcionalidad Generación de Obligaciones a Contratistas (CTGOC), según punto pendiente Sao 420066.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BCContract'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_UICTAMC'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BCReads'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOContract'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOLiquidationProcess'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOLiquidationSupport'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOReads'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crCT_tytbOrdersToLiq'), 'OBJETO');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crCT_tyobOrdersToLiq'), 'OBJETO');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CTAMC'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CTCCO'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_OBJECT_121281'), 'OBJETO');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD612', sysdate, '427773', 'Se modifica el proceso “Generación de Flujos de Instalación” del flujo de Venta a Constructoras para que sea una actividad de espera y que desde la acción a ejecutar se programe la ejecución de un JOB para la creación de los flujos independientemente del motor de WORKFLOW, con el objetivo de liberar esa carga de las colas y que estas no sean afectadas por la ejecución de este proceso. ');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CF_BOActions'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_OBJECT_121294'), 'OBJETO');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD613', sysdate, '432924', substr('Se modifica la forma CTCET – Costo Promedio por Tipo de Trabajo para adicionar el campo de Generación Automática el cual indica si el costo promedio del tipo de trabajo se calcula automáticamente en el proceso de Calcular Costo Estimado de Tipo de Trabajo o si se deja el valor registrado actualmente.
Se modifica el proceso CTCCE - Calcular Costo Estimado de Tipo de Trabajo para que no modifique los registros que no estén marcados como generación automática.
Se entrega solución a la situación reportada para la funcionalidad Calcular Costo Estimado de Tipo de Trabajo, según punto pendiente Sao 432924. Se debe tener en cuenta que el campo Generación Automática de la forma CTCET – Costo Promedio por Tipo de Trabajo quedará con valor Y para todos los registros que se encuentren de la entidad actualmente. Después de la aplicación del release se debe ingresar a la forma y cambiar los registros que no se deseen calcular automáticamente.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('Ge_BCDetalleActa'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('DAOR_TASKTYPE_AVG_COST'), 'OBJETO');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crCK_OR_TASKTYPE_AUTO_GENERATION'), 'CONSTRAINT');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('updGE_CATALOG_SAO433973'), 'ENTIDAD');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_ENTITY_ATTRIBUTES_357452_20180209'), 'ENTIDAD');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CTCET'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_TASKTYPE_AVG_COST'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GE_BOCertificate'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ctcce'), 'PRO C');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('al_20180209_OR_TASKTYPE_AVG_COST'), 'TABLA');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD614', sysdate, '428215', substr('se estaba presentando inconsistencia en el proceso de cambio de condiciones de financiación debido a que se generaba un valor adicional a cobrar por los diferidos, a causa de una ejecución concurrente con el proceso FGCA.
Se modifica el proceso de cambio de condiciones de facturación para que valide si se está ejecutando el proceso FGCA, de ser asi, se genera la excepción y queda para reenvío la actividad, el proceso podrá ser ejecutado una vez finalice la ejecución del FGCA.
Se entrega solución a la situación reportada para la funcionalidad Cambio de Condiciones de Financiación , según punto pendiente Sao 428215.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GC_BODebtNegotiation'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('upd_GE_MESSAGE_905316_Sao434011'), 'CONFIGURACION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FI_BOFinanDebtProcess'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD615', sysdate, '434542', 'Se corrige el error que se presentaba al actualizar los datos adicionales de una orden legalizada. 
Se entrega solución a la situación reportada para la funcionalidad ORADA - Actualización de Datos Adicionales, según punto pendiente Sao 434542.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOOrderAdditionalData'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD616', sysdate, '429692', substr('Se estaba presentando inconsistencias en la ejecución de los procesos "traslado de diferido a corriente del producto" y "traslado individual de saldo a favor", ya que los cargos estaban quedando con fechas que generaban diferencias en la interfaz contable.
Se adiciona validación para evitar que la ejecución de ambos procesos no se realice de forma concurrente, y asegurar que los cargos se asienten al finalizar cada ejecución antes de que el otro proceso se encuentre en ejecución.
Se entrega solución a la situación reportada para la funcionalidad Traslado Individual de Saldo a Favor - FTIS, según punto pendiente Sao 429692.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkFB_UIDefToCurrProdTransfer'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('ins_GE_MESSAGE_914288_20180131'), 'CONFIGURACION');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FA_UIProcesosFact'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpLD617', sysdate, '434934', 'Se presenta inconsistencia al momento del ordenamiento de los cargos de aplicación de saldo a favor por notas en la interfaz contable, en este caso, el ordenamiento se debe hacer primero por fecha, luego por cargcodo y finalmente por el peso del signo.
Se entrega solución a la situación reportada para la funcionalidad Interfaz Financiera, según punto pendiente Sao 434934.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkTransDefToCurrDebtMgr'), 'PAQUETE');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBOAccountingInterface'), 'PAQUETE');

COMMIT;
DBMS_OUTPUT.PUT_LINE ('Entrega creada con éxito');

EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al aplicar la entrega ');

END;
/
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE
nuCodigoEntrega NUMBER; -- Código de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD01', sysdate, '434934', 'Se corrige el error que se presentaba al validar si el contrato tiene ordenes pendientes de liquidar al momento de intentar cerrarlo. Se entrega solución a la situación reportada para la funcionalidad Cerrar Contrato, según punto pendiente Sao 436338.');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD02', sysdate, '463067', substr('El export enviado no contiene los registros correctos en la entidad GI_ATTRIB_DISP_DATA, por lo cuál al intentar abrir el Maestro Detalle de Certificación de Contratistas aparecía error.
Se envia correctamente el export con los registros adecuados en la entidad GI_ATTRIB_DISP_DATA.
Se entrega solución a la situación reportada para la funcionalidad CTCET - Certificación de Contratistas., según punto pendiente Sao 463067.
La negociación de deuda permite realizar el recalculo cuando se han modificado valores de descuento durante el registro del trámite. El inconveniente se presenta en la asignación de un valor en el indice de una tabla PL, donde se supera el valor del tipo binary_integer.
Se modifica para que no se presente error de desbordamiento para cuando se realice negociación de deuda para una cuenta de cobro con ID superiror a 2147483647.
Se entrega solución a la situación reportada para la funcionalidad Negociación de Deuda., según punto pendiente Sao 463768.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CTCET'), 'FWCMD');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('GC_BODebtNegoCharges'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD03', sysdate, '463541', substr('Se modifica el componente encargado de la ejecucción de ejecutables para registrar correctamente el conteo de ejecuciones y la ultima fecha de ejecucción.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Assembly'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Windows'), 'FORMA');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('SA_BOExeExecutable'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD04', sysdate, '440769', substr('Se impacta la lógica de creación de cargos de la cuota inicial asociada a los cambios de condiciones, para que poblé correctamente la población de la cartera diferida que se debe cancelar en DIFERIDO y MOVIDIFE, con respecto al cupón de cuota inicial que se procese.
Si el cargo a generar de un Cambio de Condiciones tiene documento soporte pkbillconst.csbTOKEN_DIFERIDO (DF-) se afecta la cartera diferida, de lo contrario se procesa como un cargo de interés o de impuesto sin afectar la cartera diferida origen.
Se modifica el proceso para que se asocie la cuenta de cobro en memoria por producto si la cuenta de cobro del diferido a insertar es -1.
Se entrega solución a la situación reportada para las funcionalidades de FCHCO-Cambio de Condiciones y Financiación de Deuda - Refinanciación, según estabilización de Puntos pendientes SAO438509 Y SAO439024.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('FI_BOFinanDebtProcess'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD05', sysdate, '464905', 'SSe realiza modificación al proceso de negociación de deuda por impacto en modificación del release 558.');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD06', sysdate, '441691', 'Se modifica el objeto que consulta si un cliente posee órdenes jurídicas en algún estado acitvo, ya que estaba generando demoras en la forma para los contratos de usuarios constructuros, que cuentan con gran volumen de órdenes. Se cambia la consulta para que obtenga la información de una sola entidad y resolviendo por el índice más selectivo.
Se entrega solución a la situación reportada para la funcionalidad CNCRM - Atención al cliente, según punto pendiente Sao 441691.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('gc_bcDebtManagement'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD07', sysdate, '442337', 'Se modifica la consulta para validar si el Contrato a facturar está asociado a un motivo de Constructoras, y este a su vez está asociado a una Solicitud con indicador de recurrencia en facturación.
Se entrega solución a la situación reportada para la funcionalidad Generación de Cuentas, según punto pendiente Sao 442337.');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD08', sysdate, '438773', 'Se modifica el servicio de consulta de Solicitudes de Reclamación mediante cuando se realiza la busqueda por el criterio de contrato, para mejorar el performance.
Se entrega solución a la situación reportada para la funcionalidad FAJU, según punto pendiente Sao 438773.
');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CC_BOSearchClaims'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD09', sysdate, '451646', substr('Se presenta mensaje de error al momento de ajustar un consumo mediante la funcionalidad FAJU, esto es debido a que el valor del ajuste es demasiado grande y desborda la capacidad de una variable interna del proceso.  Se aumenta la capacidad interna de la variable que genera la excepción, para que tenga la misma capacidad del campo donde se almacena dicha información en la base de datos.
Se entrega solución a la situación reportada para la funcionalidad Ajustes de Facturación - FAJU, según punto pendiente Sao 451646.',0,500));

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

DECLARE
nuCodigoEntrega NUMBER; -- Código de la entrega
BEGIN

-- Calcula consecutivo de entrega
nuCodigoEntrega := SEQ_LDC_VERSIONENTREGA.NEXTVAL;


-- VERSION ENTREGA
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD10', sysdate, '461144', 'Se presenta inconveniente de memoria JAVA en algunos casos al momento de registrar pagos.
Se optimiza la administración de memoria para manejo de archivos XML, en el proceso de resgistro de pagos individuales a traves del API OS_PAYMENTREGISTER.
Se entrega solución a la situación reportada para la funcionalidad API de Pagos OS_PAYMENTSREGISTER, según punto pendiente Sao 461144.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('RC_BOXMLEngine'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD11', sysdate, '436696', 'La función GetLastReadingDate estaba teniendo en cuenta las lecturas de tipo trabajo para generación de cargos, se modifica este objeto para que no tenga en cuenta las lecturas de tipo trabajo.
Se entrega solución a la situación reportada para la funcionalidad Generación de Cargos, según punto pendiente Sao 436696.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CI_BCLectelme'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD12', sysdate, '438259', 'Se corrige el error que se presentaba al realizar una modificación del anticipo del contrato teniendo registrado el ítem de anticipo como que no afecte en la liquidación, pero aun así estaba afectando el valor pagado del contrato. 
Se entrega solución a la situación reportada para la funcionalidad CTAMCN – Acta de Modificación del Contrato, según punto pendiente Sao 438259.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CT_BOContract'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD13', sysdate, '440791', 'Se actualiza el porcentaje de avance global del proceso FIDF, para que no lo muestre por hijos sino por padre.
Se entrega solución a la situación reportada para la funcionalidad Impresión de facturas (7.07.000), según punto pendiente Sao 440791.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('pkBOPrintMgr'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD14', sysdate, '451998', '451696. Se corrige metodo de asignacion que se usa en el desbloqueo de una orden para que no se consuma la capacidad horaria de la unidad. Esto teniendo en cuenta que ya fue consumido al momento de realizar la asignacion inicial. 
Se entrega solución a la situación reportada para la funcionalidad Bloqueo y desbloqueo de ordenes, según punto pendiente Sao 451696.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OR_BOProcessOrder'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD15', sysdate, '438843', '424459. Se entrega la forma CTAMC - Asignación Masiva de Contrato a Órdenes.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('CTCCO_MENU_OPTIONS'), 'FWCPI');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD16', sysdate, '444424', 'Se crea índice para consultas de cargos facturados en las reglas de facturación.
Se entrega solución a la situación reportada para la funcionalidad Generación de Cargos, según punto pendiente Sao 438794.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crIX_CARGOS09'), 'INDEX');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD17', sysdate, '444424', substr('En el proceso de negociación de deuda, justamente en el proceso de definir si se paga o se financia el saldo pendiente, al presionar el botón “Pagar” el sistema registra automáticamente la solicitud y sus motivos, sin embargo posterior a este proceso se despliega un mensaje informativo donde se presenta la solicitud creada. En caso de que en este mensaje ocurra una interrupción con la base de datos, se presenta inconsistencia pues existe persistencia entre la acción de presionar el botón “Pagar” y el despliegue del mensaje informativo. Una vez se afirma o se cierra este mensaje informativo, el sistema continua con la creación del flujo.
En caso de tener una interrupción entre el cliente y el servidor (bloqueo, red, inactividad de la cuenta, etc), el proceso no terminará correctamente.
Se cambia la posición de la persistencia de datos que se encuentra entre la acción de presionar el botón “Pagar” y el despliegue del mensaje, por hacer persistencia una vez se cierre el mensaje de aviso informativo, y el proceso termine correctamente.
Se entrega solución a la situación reportada para la funcionalidad Solicitud de Negociación de Deuda - , según punto pendiente Sao 444424.',0,500));

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.DebtNegotiation.UI'), 'ASSEMBLY');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD18', sysdate, '474092', 'Se entrega assemblies que realizan el conteo de los ejecutables del sistema.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Assembly'), 'ASSEMBLY');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.Windows'), 'ASSEMBLY');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('OpenSystems.DebtNegotiation.UI'), 'ASSEMBLY');
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('SA_BOExeExecutable'), 'PAQUETE');

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
insert into LDC_VERSIONENTREGA (CODIGO, NOMBRE_ENTREGA, FECHA, CODIGO_CASO, DESCRIPCION) values (nuCodigoEntrega, '7.07.046_rpGD19', sysdate, '468156', 'se modifica la definicion de variables del SQL crCT_tyobOrdersToLiq para que tenga los mismos valores que sus entidades origen
Se entrega solución a la situación reportada para la funcionalidad CTCCO, generacion de obligaciones, agrupacion de ordenes para la generacion de detalles de actas, según punto pendiente Sao 468156.');

--ENTREGA APLICA POR EMPRESA?
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'GDC','S');
insert into LDC_VERSIONAPLICA (CODIGO, CODIGO_ENTREGA, CODIGO_EMPRESA, APLICA) values (SEQ_LDC_VERSIONAPLICA.NEXTVAL, nuCodigoEntrega,  'EFG','S');

-- RELACION DE OBJETOS ENTREGADOS
insert into LDC_VERSIONOBJETOS (CODIGO, CODIGO_ENTREGA, OBJETO, TIPO) values (SEQ_LDC_VERSIONOBJETOS.NEXTVAL, nuCodigoEntrega, upper('crCT_tyobOrdersToLiq'), 'OBJ_BASE_DATOS');

COMMIT;
DBMS_OUTPUT.PUT_LINE ('Entrega creada con éxito');

EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE ('Ha ocurrido un error al aplicar la entrega ');

END;
/