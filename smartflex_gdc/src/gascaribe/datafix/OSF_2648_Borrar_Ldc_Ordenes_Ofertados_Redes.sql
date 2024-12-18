column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2648: Solicitamos eliminar el registro en la forma LDCDEORREOF, Orden Padre 321788707, ya
              que esta debe quedar registrada en el campo "Orden Hija", que se ingresó por error.

    Autor:    German Dario Guevara Alzate - GlobaMVM
    Fecha:    29/04/2024
*/
    -- Informacion general
    sbComment           CONSTANT VARCHAR2(200) := 'Se borra orden de la tabla LDC_ORDENES_OFERTADOS_REDES con el caso OSF-2648';
    nuCommentType       CONSTANT NUMBER        := 1277;
    nuOrden             CONSTANT NUMBER        := 321788707;

    rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
    nuPersonID          open.ge_person.person_id%type;
    sbErrorMessage      VARCHAR2(4000);
    nuEstado            NUMBER;
    exError             EXCEPTION;

BEGIN

    dbms_output.put_line('Inicia Proceso OSF_2648_Borrar_Ldc_Ordenes_Ofertados_Redes');
    dbms_output.put_line('---------------------------------------------------------------------------------');
    
    nuPersonID := ge_bopersonal.fnugetpersonid;

    -- Borra el registro
    nuEstado := null;
    DELETE ldc_ordenes_ofertados_redes
    WHERE orden_padre = nuOrden
    RETURNING orden_padre INTO nuEstado;

    IF (nuEstado is not null) THEN
        dbms_output.put_line('Orden '||nuEstado||' de LDC_ORDENES_OFERTADOS_REDES Borrada OK');

        -- Arma el registro con el comentario
        rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
        rcOR_ORDER_COMMENT.ORDER_COMMENT    := sbComment;
        rcOR_ORDER_COMMENT.ORDER_ID         := nuOrden;
        rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuCommentType;
        rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
        rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
        rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

        -- Inserta el registro en or_order_comment
        daor_order_comment.insrecord(rcOR_ORDER_COMMENT);        
        COMMIT;
    ELSE
        dbms_output.put_line('Error: Orden '||nuOrden||' No existe en LDC_ORDENES_OFERTADOS_REDES');    
    END IF;

    dbms_output.put_line('---------------------------------------------------------------------------------');
    dbms_output.put_line('Fin del Proceso');

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. '||SQLERRM );
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/