select * from open.ldci_infgestotmov
where operacion like 'VENTA_SERVICIOS'
  AND XML_SOLICITUD LIKE '%<idProducto>1114547%'
