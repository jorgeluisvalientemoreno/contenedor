
declare
  nuExiste  NUMBER;
  nuIdRegla NUMBER := 121405063;
begin 
    SELECT COUNT(1)
    INTO nuExiste
    FROM open.gr_config_expression c
    where c.config_expression_id = nuIdRegla;

    IF nuExiste > 0 THEN
        UPDATE GE_ACTION_MODULE 
           SET CONFIG_EXPRESSION_ID = nuIdRegla 
         WHERE ACTION_ID = 67; 
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Registro actualizado de forma correcta');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La regla no existe');
    END IF;

  commit;
end;
/
