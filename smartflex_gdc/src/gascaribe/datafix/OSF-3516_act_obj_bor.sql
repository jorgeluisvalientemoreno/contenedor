BEGIN

    -- OSF-3516
    UPDATE master_personalizaciones
    SET comentario = 'BORRADO'
    WHERE NOMBRE IN ( UPPER('susrp'), upper('trgsusrp') );

    COMMIT;
    
END;
/