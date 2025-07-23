column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	cursor cuOrdenesAnuladas
	IS
	SELECT oc.order_id, oc.initial_status_id, rownum Contador
	FROM or_order od,
		 or_order_stat_change oc
	WHERE od.order_id IN (284295959)
	AND od.order_status_id = 12
	AND oc.order_id = od.order_id
	AND oc.final_status_id = 12;
	
	PROCEDURE pDesAnulaOrden( inuOrden NUMBER, inuEstadoAnterior NUMBER )
	IS
  
        rcOrderComment  daor_order_comment.styor_order_comment;
        
        sbComment       or_order_comment.order_comment%TYPE := 'Se actualiza el estado de la orden al anterior - OSF-4065';
        nuCommTypeId    or_order_comment.comment_type_id%TYPE := 83;
        
        nuCausal        or_order.causal_id%type;
        nuCodError      number;
        sbMensError     varchar2(4000);
  
	BEGIN

        dbms_output.put_line( 'Inicia pDesAnulaOrden' );
        
       	nuCausal := NULL;
		
        IF inuEstadoAnterior IN ( 0, 5 ) THEN
        
            UPDATE or_order
            SET order_status_id = inuEstadoAnterior,
                causal_id 		= nuCausal
            WHERE order_id = inuOrden;
                        
            rcOrderComment.order_comment_id := or_bosequences.fnuNextOr_Order_Comment;
            rcOrderComment.order_comment    := sbComment;
            rcOrderComment.order_id         := inuOrden;
            rcOrderComment.comment_type_id  := nuCommTypeId;
            rcOrderComment.register_date    := ut_date.fdtSysdate;
            rcOrderComment.legalize_comment := GE_BOConstants.csbNO;
            rcOrderComment.person_id        := PKG_BOPERSONAL.FNUGETPERSONAID; 

            daor_order_comment.insRecord(rcOrderComment);
			
			-- haciendo un insert en la tabla de cambio de estado de la orden
			INSERT INTO OR_ORDER_STAT_CHANGE (ACTION_ID, CAUSAL_ID, COMMENT_TYPE_ID, EXECUTION_DATE, FINAL_OPER_UNIT_ID,
											  FINAL_STATUS_ID, INITIAL_OPER_UNIT_ID, INITIAL_STATUS_ID, ORDER_ID, ORDER_STAT_CHANGE_ID,
											  PROGRAMING_CLASS_ID, RANGE_DESCRIPTION, STAT_CHG_DATE, TERMINAL, USER_ID
											  )
			VALUES (102, null, nuCommTypeId, null, null, inuEstadoAnterior, null, 12, inuOrden, or_bosequences.fnuNextOr_Order_Stat_Change,
					null, null, sysdate, ut_session.getTERMINAL, ut_session.getUSER);
            
            IF inuEstadoAnterior IN ( 0, 5, 7 ) THEN
            
                UPDATE or_order_activity
                SET status 		= 'R',
					final_date  = null
                WHERE order_id = inuOrden;
            
            END IF;
            
            commit;
            
            dbms_output.put_line( 'OK pDesAnulaOrden|Orden|' || inuOrden || '|Ok' );
            
        ELSE
        
            dbms_output.put_line( 'NOK pDesAnulaOrden|Orden|' || inuOrden || '|No se procesa. Estado anterior '||inuEstadoAnterior );
                    
        END IF;
						 
        dbms_output.put_line( 'Termina pDesAnulaOrden' );
		
	exception
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(nuCodError, sbMensError);
			dbms_output.put_line( 'ERROR CONTR pDesAnulaOrden|Orden|' || inuOrden || '|' || sbMensError ); 
			rollback;           
		when others then
			dbms_output.put_line( 'ERROR NOCONTR pDesAnulaOrden|Orden|' || inuOrden || '|' || SQLERRM );
			rollback;	

	END pDesAnulaOrden;

BEGIN

	dbms_output.put_line( 'Inicia OSF-4065' );

	FOR reg IN cuOrdenesAnuladas LOOP

		pDesAnulaOrden( reg.order_id, reg.initial_status_id );
		
	END LOOP;
	
	COMMIT;
	dbms_output.put_line( 'Fin OSF-4065' );
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/