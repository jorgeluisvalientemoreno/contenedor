BEGIN
    --OSF-4555
    UPDATE master_personalizaciones
    SET COMENTARIO = 'BORRADO'
    WHERE NOMBRE = 'LDC_PAYMENTFORMATTICKET';
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('INFO[ OK LDC_PAYMENTFORMATTICKET MARCADO COMO BORRADO]' );
    
    INSERT INTO master_personalizaciones
    (
        esquema,
        nombre,
        tipo_objeto,
        comentario
    )
    values
    (
       'OPEN',
       'LDC_DATACREDITOMGR',
       'PAQUETE',
       'OPEN'
    );
    
    COMMIT;

    INSERT INTO master_personalizaciones
    (
        esquema,
        nombre,
        tipo_objeto,
        comentario
    )
    values
    (
       'OPEN',
       UPPER('LDC_BOmetrologia'),
       'PAQUETE',
       'OPEN'
    );
    
    COMMIT;
    
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR[' || SQLERRM || ']' );   
END;
/