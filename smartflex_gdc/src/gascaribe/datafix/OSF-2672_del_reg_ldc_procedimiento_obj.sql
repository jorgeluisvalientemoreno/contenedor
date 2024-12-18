SET SERVEROUTPUT ON;

DECLARE
    CURSOR cudelprocedimiento IS
    SELECT *
    FROM   ldc_procedimiento_obj
    WHERE  procedimiento IN (
                                'LDCPLUGINMARCREPAINTEGR'
                                ,'LDCPLUGINMARCCERTINTEGR'
                                ,'LDC_LEGALIZERECONEX'
                                ,'LDC_VALMEDI_ORDCARGOONEC'
                                ,'LDC_VALIDACANTCARACOBS'
                            )  ;

    sbproc VARCHAR2(200) := 'INICIO';
BEGIN
            
    FOR rc in cudelprocedimiento LOOP
    
        IF rc.procedimiento <> sbproc THEN            
            sbproc := rc.procedimiento;
            dbms_output.put_line('Eliminación registros proceso '||sbproc);
            dbms_output.put_line('TASK_TYPE_ID, CAUSAL_ID| PROCEDIMIENTO| DESCRIPCION| ORDEN_EJEC| ACTIVO|');
        END IF;
        
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
        AND    procedimiento = rc.procedimiento
        and    causal_id = rc.causal_id;
        
        IF rc.causal_id IS NULL THEN
            DELETE ldc_procedimiento_obj
            WHERE  task_type_id = rc.task_type_id
            AND    procedimiento = rc.procedimiento
            AND    causal_id IS NULL;
        END IF;

    END LOOP;   
  
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo eliminar registro en la tabla LDC_PROCEDIMIENTO_OBJ, ' || sqlerrm);
END;
/