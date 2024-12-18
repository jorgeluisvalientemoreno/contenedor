BEGIN
    
    -- OSF-2875
    UPDATE homologacion_servicios
    SET esquema_destino = 'ADM_PERSON'
    where servicio_destino like '%PKG_CORREO%'
    AND esquema_destino = 'PERSONALIZACIONES';
    
    COMMIT;

END;
/