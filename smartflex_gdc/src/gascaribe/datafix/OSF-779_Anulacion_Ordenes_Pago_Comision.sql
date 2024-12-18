column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	sbCaso  VARCHAR2(20) := 'OSF-779';
	
	CURSOR cuActiRepeXdirec IS
	SELECT activity_id, address_id, count(1) Cantidad
    FROM or_order_activity oa
    WHERE activity_id in
    (
		SELECT NUMERIC_VALUE
        FROM LD_PARAMETER
        WHERE PARAMETER_ID LIKE 'ACT_COMISION%VENTA_Z%'
    )
	AND oa.register_date > '30/12/2022'   
    group by activity_id, address_id
    having count(1) > 1;
	
	TYPE tytbActiRepeXdirec IS TABLE  OF cuActiRepeXdirec%ROWTYPE INDEX BY BINARY_INTEGER;
	
	tbActiRepeXdirec tytbActiRepeXdirec;
	
	CURSOR cuOrdenesRepetidas( inuActividad number, inuIdDireccion number ) IS
    SELECT oa.order_id
    FROM or_order_activity oa
    WHERE activity_id in
    (
		SELECT NUMERIC_VALUE
		FROM LD_PARAMETER
        WHERE PARAMETER_ID LIKE 'ACT_COMISION%VENTA_Z%'
    ) 
	AND oa.register_date > '30/12/2022'
    AND oa.activity_id = inuActividad
	AND oa.address_id = inuIdDireccion
	ORDER BY oa.order_id DESC;
	
	TYPE tytbOrdenesRepetidas IS TABLE OF cuOrdenesRepetidas%ROWTYPE INDEX BY BINARY_INTEGER;
	
	tbOrdenesRepetidas tytbOrdenesRepetidas;

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
               dbms_output.put_line(  'Se anulo OK orden: ' || inuOrden);
            else
                rollback;
                dbms_output.put_line(  'Error anulando orden: ' || inuOrden || ' : ' || sbErrorMesse);
            end IF;
        
        ELSE

            dbms_output.put_line(  'Error anulando orden: ' || inuOrden || ' : ' || ' Se encuentra en el acta [' || rcOrdenActa.id_acta || ']');
        
        END IF;
        
    END pAnulaOrden;
	
	PROCEDURE pAnulaOrdenesRepe IS
	BEGIN

		OPEN cuActiRepeXdirec;
		FETCH cuActiRepeXdirec BULK COLLECT INTO tbActiRepeXdirec;
		CLOSE cuActiRepeXdirec;

		FOR indTb1 IN 1..tbActiRepeXdirec.COUNT LOOP

			dbms_output.put_line(  'Actividad[' || tbActiRepeXdirec(indTb1).activity_id || ']IdDireccion[' || tbActiRepeXdirec(indTb1).address_id || ']Cantidad[' || tbActiRepeXdirec(indTb1).Cantidad || ']');

			tbOrdenesRepetidas.DELETE;
		
			OPEN cuOrdenesRepetidas ( tbActiRepeXdirec(indTb1).activity_id, tbActiRepeXdirec(indTb1).address_id );
			FETCH cuOrdenesRepetidas BULK COLLECT INTO tbOrdenesRepetidas LIMIT tbActiRepeXdirec(indTb1).Cantidad -1;
			CLOSE cuOrdenesRepetidas;
						
			FOR indTb2 IN 1..tbOrdenesRepetidas.COUNT LOOP
				pAnulaOrden(tbOrdenesRepetidas(indTb2).Order_Id);
			END LOOP;
			
		END LOOP;
		
	END pAnulaOrdenesRepe;
	
begin
	
	pAnulaOrdenesRepe;
	
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/