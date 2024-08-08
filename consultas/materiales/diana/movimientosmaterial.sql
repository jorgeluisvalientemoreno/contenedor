/*set serveroutput on*/
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');
  
  --"OPEN".LDCI_PKPEDIDOVENTAMATERIAL.PRONOTIFICASOLICITUDESERP;  -- Envia Solicitudes y Devoluciones de Pedidos de Venta de OSF a SAP
  --"OPEN".LDCI_PKMOVIVENTMATE.proConfirmarSolicitud(-1);         -- Procesa Movimientos de Pedidos de Venta de SAP en OSF
  ---lDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP;       -- Envia Solicitudes y Devoluciones de Reservas de OSF a SAP  
  LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(-1);         -- Procesa Movimiento de Reservas de SAP en OSF
  
  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;
/


