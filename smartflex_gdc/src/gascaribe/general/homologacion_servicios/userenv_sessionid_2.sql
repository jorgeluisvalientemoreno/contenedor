Prompt Borrando homologacion para USERENV_SESSIONID
BEGIN
    DELETE FROM homologacion_servicios
    where servicio_origen like 'USERENV(%SESSIONID%';
    COMMIT;
END;
/