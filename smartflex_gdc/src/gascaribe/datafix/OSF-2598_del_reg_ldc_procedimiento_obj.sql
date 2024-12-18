SET SERVEROUTPUT ON;

DECLARE
    CURSOR cudelprocedimiento(inuprocedimiento in ldc_procedimiento_obj.procedimiento%type) IS
    SELECT *
    FROM   ldc_procedimiento_obj
    WHERE  procedimiento = inuprocedimiento ;

    --rc cudelprocedimiento%rowtype;
BEGIN
    dbms_output.put_line('Eliminación registros proceso '||'LDC_PROVALIQNOLEGAXORCAO');
    dbms_output.put_line('TASK_TYPE_ID, CAUSAL_ID| PROCEDIMIENTO| DESCRIPCION| ORDEN_EJEC| ACTIVO|');
        
    FOR rc in cudelprocedimiento('LDC_PROVALIQNOLEGAXORCAO') LOOP
        
        dbms_output.put_line(rc.task_type_id
                             || '|'
                             || rc.causal_id
                             || '|'
                             || rc.procedimiento
                             || '|'
                             || rc.descripcion
                             || '|'
                             || rc.orden_ejec
                             || '|'
                             || rc.activo);
    
        DELETE ldc_procedimiento_obj
        WHERE  task_type_id = rc.task_type_id
        AND    procedimiento = rc.procedimiento;

    END LOOP;
    
    dbms_output.put_line('Eliminación registros proceso '||'LDC_VAL_SUSP_DEFECT');
    dbms_output.put_line('TASK_TYPE_ID, CAUSAL_ID| PROCEDIMIENTO| DESCRIPCION| ORDEN_EJEC| ACTIVO|');
        
    FOR rc in cudelprocedimiento('LDC_VAL_SUSP_DEFECT') LOOP
        
        dbms_output.put_line(rc.task_type_id
                             || '|'
                             || rc.causal_id
                             || '|'
                             || rc.procedimiento
                             || '|'
                             || rc.descripcion
                             || '|'
                             || rc.orden_ejec
                             || '|'
                             || rc.activo);
    
        DELETE ldc_procedimiento_obj
        WHERE  task_type_id = rc.task_type_id
        AND    procedimiento = rc.procedimiento;

    END LOOP;
    
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo eliminar registro en la tabla LDC_PROCEDIMIENTO_OBJ, ' || sqlerrm);
END;
/