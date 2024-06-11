/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : pl_movimiento_material.sql
 * Tiquete : Templates
 * Autor   : OLSoftware / Carlos Virgen
 * Fecha   : 16-03-2011
 * Descripcion : Realiza la eliminaci�n de la configuraci�n de una opci�n en GASPLUS
 *
 * Historia de Modificaciones
 * Autor          Fecha  Descripcion
**/

set serveroutput on
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');
  -- ejecuci�n en desarrollo
  --LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(-1);
  
  -- ejecuci�n en calidad
  --"OPEN".LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(-1);  
--  "OPEN".LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(1);  
  "OPEN".LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(-1);    


  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);                  
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;
/