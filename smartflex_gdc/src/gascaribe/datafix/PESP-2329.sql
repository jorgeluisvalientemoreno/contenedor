BEGIN
    UPDATE MASTER_PERSONALIZACIONES
       SET COMENTARIO = 'MIGRADO PERSONALIZACIONES'
     WHERE NOMBRE = UPPER('trgbidurAB_PREMISE')
        OR NOMBRE = UPPER('trgbidurAB_ADDRESS');
END;
/
PROMPT "Comentario en MASTER_PERSONALIZACIONES actualizado";
