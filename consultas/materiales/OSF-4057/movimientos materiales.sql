/*set serveroutput on*/
declare
 osbMesjErr varchar2(3000);
 ol_Payload CLOB;
 sesion number;
begin
  DBMS_OUTPUT.PUT_LINE('inicia el proceso pl_movimiento_material.sql');
  
  --"OPEN".LDCI_PKPEDIDOVENTAMATERIAL.PRONOTIFICASOLICITUDESERP;  -- Envia Solicitudes y Devoluciones de Pedidos de Venta de OSF a SAP
  "OPEN".LDCI_PKMOVIVENTMATE.proConfirmarSolicitud(-1);         -- Procesa Movimientos de Pedidos de Venta de SAP en OSF
  --lDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP;       -- Envia Solicitudes y Devoluciones de Reservas de OSF a SAP  
  /*SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  LDCI_PKMOVIMATERIAL.proConfirmarSolicitud(25717);         -- Procesa Movimiento de Reservas de SAP en OSF*/
  
  DBMS_OUTPUT.PUT_LINE('osbMesjErr: ' || osbMesjErr);     
  DBMS_OUTPUT.PUT_LINE('termina el proceso pl_movimiento_material.sql');  
  commit;
exception
   when others then
       DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
       DBMS_OUTPUT.PUT_LINE('Backtrace:' || DBMS_UTILITY.format_error_backtrace);
end;
/
/*[2:34:14 p. m.] Alex Lemos: estos son los 4
[2:34:27 p. m.] Alex Lemos: tanto los que envian
[2:34:32 p. m.] Alex Lemos: como los que procesan
[2:34:45 p. m.] Alex Lemos: pero tienen que ser con un usuario especial
[2:34:59 p. m.] Alex Lemos: aca yo lo hago con IntegraDesa
*/
