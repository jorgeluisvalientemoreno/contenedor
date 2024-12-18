column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    Nombre:      OSF-2442_Anula_Orden_Contratista_Viejo
    Descripcion: Se requiere anular las ordenes de novedad del archivo anexo ya que pertenecen a contratos que ya fueron 
                 cerrados y se están reflejando en la provisión y estan afectando el cierre de contratos. 
                 solo se requiere anular estas ordenes para que no sigan saliendo pendientes por liquidacion.
                 - Script basado en el Datafix del caso OSF-1199
    Autor:       German Dario Guevara Alzate - GlobaMVM
    Fecha:       05/03/2024
*/
    -- Cursor para consulta la orden
    CURSOR cuDatos (inuOrden NUMBER) IS
        SELECT o.order_id
        FROM open.or_order_activity a, 
             open.or_order o
        WHERE a.order_id = inuOrden
          AND a.order_id = o.order_id;
    
    TYPE tytbOrden IS TABLE OF NUMBER;
    -- Lista de ordenes a anular
    tbOrd tytbOrden := tytbOrden (315544283, 315544344, 315544357, 315544300, 315544314, 315544299, 315544346, 315544305, 315544318, 315542714, 315544327, 315544333, 
                                  315544358, 315544293, 315544322, 315544315, 315544320, 315544325, 315544353, 315544324, 315544294, 315544334, 315544323, 315544285, 
                                  315544340, 315544350, 315544304, 315544355, 315544343, 315544308, 315544349, 315544345, 315544331, 315542706, 315544291, 315544352, 
                                  315544319, 315544336, 315544359, 315544281, 315544330, 315544297, 315544284, 315544312, 315544295, 315544339, 315544342, 315544296, 
                                  317128618, 192198184, 317130519, 315544290, 315544301, 315544335, 192198176, 315542708, 315544321, 315544338, 315542702, 315544288, 
                                  315544298, 315544328, 317130520, 315544286, 315544287, 192198177, 192198179, 315544311, 315544316, 315544326, 315544337, 315544302, 
                                  315544329, 315544341, 315544354, 315544360, 315544289, 315544280, 315544332, 315544309, 315544310, 315544313, 315544361, 315544279, 
                                  315544307, 315544278, 315544351, 315544356, 315542703, 315544292, 315544306, 192198174, 317130516, 315544303, 315544347, 315544348, 
                                  317130515, 192198180, 317130517, 192198175, 192198181, 192198178, 192198183, 317128619, 192198185, 192198182);

    sbOrderCommen       varchar2(4000) := 'Se cambia estado a anulado por caso OSF-2442';
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
    
    -- Recorriendo y mostrando los elementos de la tabla anidada
    i := tbOrd.FIRST;
    LOOP
        EXIT WHEN i IS NULL; -- Salir del bucle cuando no haya más elementos   
        
        BEGIN        
            nuOrden := null;        
            OPEN cudatos (tbOrd(i));
            FETCH cuDatos INTO nuOrden;
            CLOSE cuDatos;
            
            IF (nvl(nuOrden,0) = 0) THEN
                dbms_output.put_line('Error NO existe en la BD la Orden: '|| tbOrd(i));
                RAISE exError;
            END IF;
            
            nuSelec := nuSelec + 1;

            -- Se reemplaza or_boanullorder.anullorderwithoutval por el nuevo API para anular ordenes
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
            OS_ADDORDERCOMMENT
            (
                nuOrden, 
                nuCommentType, 
                sbOrderCommen, 
                nuErrorCode, 
                sbErrorMessage
            );

            IF (nuErrorCode = 0) THEN
                commit;
                dbms_output.put_line('Se anulo OK orden: ' || nuOrden);
                nuCont := nuCont + 1;
            ELSE
                rollback;
                dbms_output.put_line('Error anulando orden: ' || nuOrden || ' : ' || sbErrorMessage);
            END IF;

            i := tbOrd.NEXT(i); -- Avanzar al siguiente índice
        EXCEPTION
            WHEN exError THEN
                rollback;
                i := tbOrd.NEXT(i);      
            WHEN OTHERS THEN
                dbms_output.put_line('Error OTHERS anulando orden: ' || tbOrd(i) || ' : ' || sqlerrm);
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