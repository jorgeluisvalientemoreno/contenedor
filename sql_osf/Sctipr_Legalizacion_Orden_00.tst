PL/SQL Developer Test script 3.0
24
-- Created on 12/10/2022 by JORGE VALIENTE 
declare
  -- Local variables here
  i integer;

  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(4000);

begin
  -- Test statements here

  os_legalizeorders('246628469|3379|15902||238522491>0;;;;|||1277;Prueba suspension por seguridad CM',
                    sysdate,
                    sysdate,
                    sysdate,
                    onuErrorCode,
                    osbErrorMessage);

  dbms_output.put_line('Codigo error: ' || onuErrorCode);
  dbms_output.put_line('Mensaje error: ' || osbErrorMessage);

  Rollback;

end;
0
8
nuOrderId
nucausal
sbcausalesPerm
nuProducto
nuCliente
nuPersona
nuUnidadOpera
nuLectura
