CREATE OR REPLACE TRIGGER trg_pruebas_gdgu_direccion
BEFORE UPDATE OF geograp_location_id ON ab_address

FOR EACH ROW
BEGIN
  IF :OLD.address_id in (514268, 427873) THEN
    LDC_SENDEMAIL('sjurado@findingtc.com' , 'Estan actualizando la direccion' , 'terminal que esta haciendo el cambio : '||' '|| pkg_session.fsbgetterminal); 
    pkg_error.setErrorMessage(-20001, 'No debe modificarse este address_id. Prueba Silvana GDGU.');
    
  END IF;
END;


