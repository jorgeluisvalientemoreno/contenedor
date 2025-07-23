BEGIN
    -- OSF-4493
    EXECUTE IMMEDIATE 'ALTER TRIGGER multiempresa.trg_val_emp_func_contr DISABLE';
    DBMS_OUTPUT.PUT_LINE('INFO:[TRIGGER multiempresa.trg_val_emp_func_contr DESHABILITADO' );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR:[DESHABILITANDO TRIGGER multiempresa.trg_val_emp_func_contr[' || SQLERRM || ']' );          
END;
/