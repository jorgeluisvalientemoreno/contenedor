column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    
    nuTotal             NUMBER;
    nuOK                NUMBER;
    nuErr               NUMBER;
    nuNotExist          NUMBER;
    
    onuErrorCode        NUMBER; 
    osbErrorMessage     VARCHAR2(2000);    
   
    nucomment_type_id   or_order_comment.comment_type_id%type := 1277;
    sborder_comment     or_order_comment.order_comment%type;
    
    rcOr_order          or_order%rowtype;
    
    TYPE rcOrdenFecha IS RECORD(
        order_id              or_order.order_id%type,
        execution_final_date  or_order.execution_final_date%type,
        exec_estimate_date    or_order.exec_estimate_date%type
    );  
    
    TYPE tyOrdenFecha IS TABLE OF rcOrdenFecha INDEX BY BINARY_INTEGER ;
    tbOrdenFecha tyOrdenFecha;
    
          
    
BEGIN
    tbOrdenFecha(1).order_id := 350309532; 
    tbOrdenFecha(1).execution_final_date := '29/01/2025 15:54:07';
    tbOrdenFecha(1).exec_estimate_date := '29/01/2025 15:54:18';
      
    nuTotal := 0;
    nuOK    := 0;
    nuErr   := 0;
    nuNotExist := 0;
    
    FOR i IN tbOrdenFecha.FIRST..tbOrdenFecha.LAST LOOP
        
        nuTotal := nuTotal + 1;
    
        IF DAOR_order.fblexist(tbOrdenFecha(i).order_id) THEN
        
            SELECT *
            INTO rcOr_order
            FROM or_order
            WHERE order_id = tbOrdenFecha(i).order_id;
            
             --Actualiza fecha fin de ejecución de la orden
             UPDATE or_order
             SET    execution_final_date = tbOrdenFecha(i).execution_final_date,
                    exec_estimate_date = tbOrdenFecha(i).exec_estimate_date
             WHERE  order_id = tbOrdenFecha(i).order_id;  

             UPDATE or_order_activity
             SET    exec_estimate_date = tbOrdenFecha(i).exec_estimate_date
             WHERE  order_id = tbOrdenFecha(i).order_id;  
            
            sborder_comment := 'OSF-4056: Se realiza cambio de fecha de '|| nvl(TO_CHAR(rcOr_order.execution_final_date), 'NULO') ||' a '|| tbOrdenFecha(i).execution_final_date;
            
            --Inserta comentario
            OS_ADDORDERCOMMENT(tbOrdenFecha(i).order_id, nucomment_type_id,sborder_comment, onuErrorCode, osbErrorMessage); 
                      
            IF onuErrorCode <> 0 THEN
                nuErr := nuErr + 1;
                
                ROLLBACK;
                dbms_output.put_line('Error insertando comentario orden: ' || tbOrdenFecha(i).order_id ||', '|| osbErrorMessage);                
            ELSE
                nuOK := nuOK + 1;
                
                COMMIT;
            END IF;                        
        
        ELSE
            nuNotExist := nuNotExist + 1;            
        END IF;
    
    END LOOP;
    
    dbms_output.put_line('-----------------------------------------');
    dbms_output.put_line('Total Ordenes Seleccionadas: '||nuTotal);
    dbms_output.put_line('Total Ordenes Actualizadas: '||nuOK);
    dbms_output.put_line('Total Ordenes NO Existentes en la BD: '||nuNotExist);
    dbms_output.put_line('Total Ordenes con Error: '||nuErr);
    dbms_output.put_line('-----------------------------------------');
	dbms_output.put_line('Finaliza datafix OSF-4056');
    
EXCEPTION
    when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        pkerrors.geterrorvar(onuErrorCode, osbErrorMessage);
        dbms_output.put_line('onuErrorCode: '||onuErrorCode|| '|' || osbErrorMessage);        
        ROLLBACK;
    when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
        pkerrors.geterrorvar(onuErrorCode, osbErrorMessage);
        dbms_output.put_line('onuErrorCode: '||onuErrorCode|| '|' || osbErrorMessage);          
        ROLLBACK;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/