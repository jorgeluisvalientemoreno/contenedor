column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2681');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    Nombre:      OSF-2681_Anula_Orden_Contratista_Viejo
    Descripcion: Se requiere anular las ordenes de novedad del archivo anexo ya que pertenecen a contratos que ya fueron cerrados 
                 y se están reflejando en la provisión y estan afectando el cierre de contratos. solo se requiere anular estas 
                 ordenes para que no sigan saliendo pendientes por liquidacion. esta misma actividad se solicito con otras ordenes 
                 de trabajo en el caso SOSF-1638: ANULACION DE ORDENES GENERADAS A CONTRATISTAS VIEJOS 07062023. 
                 en e cual dieron la siguiente solucion. Se realiza la creación de un datafix que se encargue de anular las ordenes, 
                 haciendo uso del servicio “or_boanullorder.anullorderwithoutval”. Se deja un comentario de trazabilidad 
                 en la entidad OR_ORDER_COMMENT.
    
                 - Script basado en el Datafix del caso OSF-2442
    Autor:       German Dario Guevara Alzate - GlobaMVM
    Fecha:       06/05/2024
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
    tbOrd tytbOrden := tytbOrden (192198174,192198175,192198176,192198177,192198178,192198179,192198180,192198181,192198182,
                                  192198183,192198184,192198185,318972340,318972341,318972343,318973837,318973844,318974997,
                                  318975049,318975050,318975051,318975053,318975054,318975055,318975056,318975057,318975058,
                                  318975059,318975060,318975061,318975062,318975063,318975064,318975065,318975066,318975067,
                                  320399615,320399618,320400201,322345582,322345583,322345584,322347965,322347975,322348674,
                                  322348675,322348676,322348681,322348682,322348683,322348684,323955511,323955512,323959220,
                                  323959221,323959223,323959229,323959230,323959231,323959232,323959234,323959235,323959236,
                                  323959237,323959239,323959240,323959241,323959242,323959243,323959244,323959246,323959248,
                                  323959249,323959251);

    sbOrderCommen       varchar2(4000) := 'Se cambia estado a anulado por caso OSF-2681';
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
                dbms_output.put_line('Error: No existe la Orden '|| tbOrd(i));
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

