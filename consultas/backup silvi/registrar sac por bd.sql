declare 
onusolicitud  mo_packages.package_id%type;
onucodigoerror ge_error_log.error_log_id%type;
osbmensajeerror ge_error_log.description%type;
begin
  -- Call the procedure
  ldci_pkservicioschatbot.prcregistrasolicitudsacrp(48030497,--- contrato
                                                    10, --medio de recepcion 
                                                    'prueba', --comentario
                                                    4294820, --actividad a generar
                                                    320493433 , --orden de rp del producto
                                                    onusolicitud,
                                                    onucodigoerror ,
                                                    osbmensajeerror );
                                                    
dbms_output.put_line ('solicitud creada:' ||onusolicitud); 
dbms_output.put_line ('Codigo error:'|| onucodigoerror); 
dbms_output.put_line ('Mensaje error' || osbmensajeerror); 
 
end;
