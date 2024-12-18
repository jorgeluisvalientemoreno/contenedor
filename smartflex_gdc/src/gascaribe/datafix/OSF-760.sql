column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	sbCaso  VARCHAR2(20) := 'OSF-760';

    CURSOR cuOrdenActa( inuOrden or_order.order_id%TYPE) IS
    select ID_ORDEN, id_acta
    from GE_detalle_acta
    WHERE ID_ORDEN = inuOrden;
    
    rcOrdenActa cuOrdenActa%ROWTYPE;
        	
	FUNCTION fblOrdenEnActa( inuOrden or_order.order_id%TYPE) RETURN BOOLEAN
	IS
	
        blOrdenEnActa   BOOLEAN := FALSE;        
        	
	BEGIN
	
        rcOrdenActa := NULL;
        
        OPEN cuOrdenActa(inuOrden);
        FETCH cuOrdenActa INTO rcOrdenActa;
        CLOSE cuOrdenActa;
        
        IF rcOrdenActa.ID_ORDEN IS NOT NULL THEN
            blOrdenEnActa := TRUE;
        END IF;
        
        RETURN blOrdenEnActa;
	
	END fblOrdenEnActa;
	
    PROCEDURE pAnulaOrden( inuOrden or_order.order_id%TYPE)
    IS
        sbOrderComme varchar2(4000) := 'Se cambia estado a anulado por caso ' || sbCaso;
        nuCommentType number := 1277;
    
        nuErrorCode     NUMBER;
        sbErrorMesse    VARCHAR2(4000);
              

    BEGIN
    
        IF NOT fblOrdenEnActa( inuOrden ) THEN
        
            or_boanullorder.anullorderwithoutval(inuOrden, SYSDATE);
            
            OS_AddOrderComment
            (   
                inuOrden,
                nuCommentType,
                sbOrderComme,
                nuErrorCode,
                sbErrorMesse
            );

            if nuErrorCode = 0 then
                commit;
               ut_trace.trace(isbmessage => '[Se anulo OK orden: ' || inuOrden, inuLevel => 2);
            else
                rollback;
                ut_trace.trace(isbmessage => '[Error anulando orden: ' || inuOrden || ' : ' || sbErrorMesse, inuLevel => 2);
            end IF;
        
        ELSE

            ut_trace.trace(isbmessage => '[Error anulando orden: ' || inuOrden || ' : ' || ' Se encuentra en el acta [' || rcOrdenActa.id_acta || ']', inuLevel => 2);
        
        END IF;
        
    END pAnulaOrden;
begin
	pAnulaOrden(259124342);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/