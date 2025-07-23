DECLARE
    -- OSF-4204
BEGIN

    UPDATE ld_parameter
    SET value_chain = 'dsaltarin@gascaribe.com,projas@gascaribe.com'
    where parameter_id = 'NOTIFEMAILS';
    
    COMMIT;

    dbms_output.put_line('INFO[Ok actualizacion parametro NOTIFEMAILS]' );
            
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR[' || sqlerrm || ']' );
        ROLLBACK;
END;
/