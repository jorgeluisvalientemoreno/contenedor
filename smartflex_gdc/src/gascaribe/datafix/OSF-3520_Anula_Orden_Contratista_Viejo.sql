column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2681');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    -- Cursor para consulta la orden
    CURSOR cuDatos (inuOrden NUMBER) IS
        SELECT o.order_id
        FROM open.or_order_activity a, 
             open.or_order o
        WHERE a.order_id = inuOrden
          AND a.order_id = o.order_id;
    
    TYPE tytbOrden IS TABLE OF NUMBER;
    -- Lista de ordenes a anular
    tbOrd tytbOrden := tytbOrden (309161788);

    sbOrderCommen       varchar2(4000) := 'Se cambia estado a anulado por caso OSF-3520';
    nuCommentType       number         := 1277;
    i                   number;
    nuErrorCode         number;
    nuCont              number;
    nuTotal             number; 
    nuSelec             number; 
    nuOrden             number;    
    sbErrorMessage      varchar2(4000);
    exError             EXCEPTION;
BEGIN

    nuCont  := 0;
    nuSelec := 0;
    nuTotal := tbOrd.COUNT;
    
    i := tbOrd.FIRST;
    LOOP
        EXIT WHEN i IS NULL; 
        
        BEGIN        
            nuOrden := null;        
            OPEN cudatos (tbOrd(i));
            FETCH cuDatos INTO nuOrden;
            CLOSE cuDatos;
            
            IF (nvl(nuOrden,0) = 0) THEN
                dbms_output.put_line('Error: No existe la Orden '|| tbOrd(i));
                RAISE exError;
            END IF;
            
            nuSelec := nuSelec + 1;

            api_anullorder
            (
                nuOrden,
                null,
                null,
                nuErrorCode,
                sbErrorMessage
            );
            IF (nuErrorCode <> 0) THEN
                dbms_output.put_line('Error en api_anullorder, Orden: '|| nuOrden ||', '|| sbErrorMessage);
                RAISE exError;
            END IF;
            -- Adiciona el comentario
            api_addordercomment
            (
                nuOrden, 
                nuCommentType, 
                sbOrderCommen, 
                nuErrorCode, 
                sbErrorMessage
            );

            IF (nuErrorCode = 0) THEN
                commit;
                dbms_output.put_line('Se anulo OK la orden: ' || nuOrden);
                nuCont := nuCont + 1;
            ELSE
                rollback;
                dbms_output.put_line('Error anulando la orden: ' || nuOrden || ' : ' || sbErrorMessage);
            END IF;

            i := tbOrd.NEXT(i); -- Avanzar al siguiente índice
        EXCEPTION
            WHEN exError THEN
                rollback;
                i := tbOrd.NEXT(i);      
            WHEN OTHERS THEN
                dbms_output.put_line('Error OTHERS anulando la orden: ' || tbOrd(i) || ' : ' || sqlerrm);
                rollback;
                i := tbOrd.NEXT(i);   
        END;
    END LOOP;
    dbms_output.put_line('---------------------------------------------------------------------------------');
    dbms_output.put_line('Fin del Proceso. Ordenes Enviadas: '||nuTotal||', Ordenes Seleccionadas: '||nuSelec||', Ordenes Anuladas: '||nuCont);    
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

