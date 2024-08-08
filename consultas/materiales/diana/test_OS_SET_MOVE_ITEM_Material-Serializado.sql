/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : pl_movimiento_material.sql
 * Tiquete : Templates
 * Autor   : OLSoftware / Carlos Virgen
 * Fecha   : 16-03-2011
 * Descripcion : Realiza la eliminación de la configuración de una opción en GASPLUS
 *
 * Historia de Modificaciones
 * Autor          Fecha  Descripcion
**/
set serveroutput on
declare
  ISBSERIE VARCHAR2(50);
  INUTARGETOPEUNI NUMBER;
  ISBDOCREFERENCE VARCHAR2(30);
  ONUTIPOITEMID NUMBER;
  ONUITEMSGAMAID NUMBER;
  ONUERRORCODE NUMBER;
  OSBERRORMESSAGE VARCHAR2(2000);
begin
  DBMS_OUTPUT.PUT_LINE('OS_SET_MOVE_ITEM : ');
  /*Lo mueve de la unidad operativa 990 a la 979*/
  ISBSERIE := '2300008';
  INUTARGETOPEUNI := 1273;   
  ISBDOCREFERENCE := '000-2300007'; 
  OS_SET_MOVE_ITEM (isbSerie, inuTargetOpeUni, isbDocReference, onuTipoItemId, onuItemsGamaId, onuErrorCode, osbErrorMessage);
 
 
 --select * from GE_ITEMS_SERIADO where SERIE = '1212121';


  DBMS_OUTPUT.PUT_LINE('onuTipoItemId : ' || onuTipoItemId);   
  DBMS_OUTPUT.PUT_LINE('onuItemsGamaId : ' || onuItemsGamaId);   
  DBMS_OUTPUT.PUT_LINE('onuItemsGamaId : ' || onuItemsGamaId);     
  DBMS_OUTPUT.PUT_LINE('onuErrorCode : ' || onuErrorCode);     
  DBMS_OUTPUT.PUT_LINE('osbErrorMessage : ' || osbErrorMessage);    
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);                  
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;