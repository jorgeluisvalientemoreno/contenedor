CREATE OR REPLACE TRIGGER ADM_PERSON.trgAftupdateservsusc
AFTER  UPDATE OF sesuesfn,sesuesco,sesucicl,sesucate,sesusuca ON servsusc
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
nuidregistro    ldc_usuarios_actualiza_cl.idregistro%TYPE;
BEGIN
    IF :new.sesuesfn <> :old.sesuesfn THEN
      nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
      INSERT INTO ldc_usuarios_actualiza_cl(producto,esfi,idregistro) VALUES(:new.sesunuse,'S',nuidregistro);
    END IF;
    IF :new.sesuesco <> :old.sesuesco THEN
        nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
        INSERT INTO ldc_usuarios_actualiza_cl(producto,esco,idregistro) VALUES(:new.sesunuse,'S',nuidregistro);
    END IF;
    IF :new.sesucicl <> :old.sesucicl THEN
      nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
        INSERT INTO ldc_usuarios_actualiza_cl(producto,cicl,idregistro) VALUES(:new.sesunuse,'S',nuidregistro);
    END IF;
    IF :new.sesucate||:new.sesusuca <> :old.sesucate||:old.sesusuca THEN
      nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
       INSERT INTO ldc_usuarios_actualiza_cl(producto,estr,Idregistro) VALUES(:new.sesunuse,'S',nuidregistro);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error(-20001,'Ha ocurrido un error - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/
