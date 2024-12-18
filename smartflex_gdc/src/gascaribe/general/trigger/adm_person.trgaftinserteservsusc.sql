CREATE OR REPLACE TRIGGER ADM_PERSON.trgAftinserteservsusc
AFTER  INSERT ON servsusc
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/*
    Propiedad intelectual de PETI

    Trigger     : trgauAllocateQuoteEsFn
    Descripcion : Trigger que permite marcar el contrato para actualiza cupo
    Autor       : llozada
    Fecha       : 12-05-2015

    Historia de Modificaciones
    Fecha
    12-05-2015  Creacion
*/
DECLARE
BEGIN
  UPDATE ldc_usuarios_actualiza_cl un
     SET un.esfi = 'S'
   WHERE un.producto = :new.sesunuse;
      IF SQL%NOTFOUND THEN
        INSERT INTO ldc_usuarios_actualiza_cl(producto) VALUES(:new.sesunuse);
      END IF;
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001,'Ha ocurrido un error - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/
