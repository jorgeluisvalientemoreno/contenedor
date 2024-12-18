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
	WHERE od.order_id IN
	(
		340645758,
		341219087,
		341219240,
		341219377,
		341219811,
		341220132,
		341221123,
		341234364,
		341234365,
		341234367,
		341234368,
		341234369,
		341234371,
		341234372,
		341234373,
		341234376,
		341234377,
		341234379,
		341234381,
		341234382,
		341234383,
		341234386,
		341234387,
		341234389,
		341234390,
		341234391,
		341234392,
		341234393,
		341234394,
		341234395,
		341234396,
		341234397,
		341234398,
		341234399,
		341234400,
		341234401,
		341234402,
		341234403,
		341234404,
		341234405,
		341234406,
		341234407,
		341234408,
		341234409,
		341234410,
		341234411,
		341234412,
		341234413,
		341234414,
		341234415,
		341234417,
		341234418,
		341234419,
		341234420,
		341234421,
		341234422,
		341234423,
		341234424,
		341234425,
		341234426,
		341234427,
		341234428,
		341234430,
		341234432,
		341234433,
		341234434,
		341234437,
		341234438,
		341234439,
		341234440,
		341234441,
		341234442,
		341234443,
		341234444,
		341234445,
		341234446,
		341234447,
		341234448,
		341234449,
		341234450,
		341234451,
		341234452,
		341234455,
		341234456,
		341234457,
		341234458,
		341234459,
		341234460,
		341234461,
		341234463,
		341234464,
		341234468,
		341234469,
		341234471,
		341234473,
		341234474,
		341234475,
		341234476,
		341234477,
		341234479,
		341234481,
		341234482,
		341234484,
		341234485,
		341234486,
		341234487,
		341234490,
		341234491,
		341234494,
		341234495,
		341234496,
		341234497,
		341234499,
		341234500,
		341234501,
		341234502,
		341234503,
		341234504,
		341234505,
		341234506,
		341234507,
		341234508,
		341234509,
		341234510,
		341234511,
		341234512,
		341234514,
		341234515,
		341234516,
		341234517,
		341234518,
		341234519,
		341234520,
		341234525,
		341234526,
		341234527,
		341234531,
		341234532,
		341234533,
		341234534,
		341234535,
		341234536,
		341234537,
		341234538,
		341234539,
		341234541,
		341234542,
		341234546,
		341234547,
		341234548,
		341234549,
		341234550,
		341234552,
		341234553,
		341234554,
		341234557,
		341234558,
		341234559,
		341234560,
		341234561,
		341234562,
		341234563,
		341234564,
		341234565,
		341234567,
		341234588,
		341234609,
		341234626,
		341234643,
		341234649,
		341234657,
		341235348,
		341235354,
		341235429,
		341235448,
		341235499,
		341235515,
		341235554,
		341235577,
		341235590,
		341235597,
		341235713,
		341236460,
		341236542,
		341236562,
		341236627,
		341236640,
		341236670,
		341236685,
		341236693,
		341236698,
		341236726,
		341236749,
		341236794,
		341236801,
		341236803,
		341236804,
		341236805,
		341236825,
		341236870,
		341236885,
		341236952,
		341236984,
		341237007,
		341237028,
		341237051,
		341237101,
		341237120,
		341237170,
		341237182,
		341237189,
		341237222,
		341237451,
		341238889,
		341238967,
		341239292,
		341240960,
		341241901,
		341241917,
		341245337,
		341260238,
		341260240,
		341260241,
		341260242,
		341260250,
		341260251,
		341260254,
		341260257,
		341260259,
		341260264,
		341260267,
		341260269,
		341260270,
		341260283,
		341260289,
		341260295,
		341260299,
		341260302,
		341260303,
		341260305,
		341260311,
		341260318,
		341260319,
		341260326,
		341260330,
		341260334,
		341260338,
		341260339,
		341260340,
		341260348
	)
	AND od.order_status_id = 12
	AND oc.order_id = od.order_id
	AND oc.final_status_id = 12
	AND TRUNC( oc.stat_chg_date ) = TO_DATE( '10/10/2024', 'dd/mm/yyyy' );
	
	PROCEDURE pDesAnulaOrden( inuOrden NUMBER, inuEstadoAnterior NUMBER )
	IS
  
        rcOrderComment  daor_order_comment.styor_order_comment;
        
        sbComment       or_order_comment.order_comment%TYPE := 'Se actualiza el estado de la orden al anterior - OSF-3467';
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
                causal_id = nuCausal
            WHERE order_id = inuOrden;
                        
            rcOrderComment.order_comment_id := or_bosequences.fnuNextOr_Order_Comment;
            rcOrderComment.order_comment    := sbComment;
            rcOrderComment.order_id         := inuOrden;
            rcOrderComment.comment_type_id  := nuCommTypeId;
            rcOrderComment.register_date    := ut_date.fdtSysdate;
            rcOrderComment.legalize_comment := GE_BOConstants.csbNO;
            rcOrderComment.person_id        := ge_boPersonal.fnuGetPersonId;

            daor_order_comment.insRecord(rcOrderComment);
            
            IF inuEstadoAnterior IN ( 0, 5, 7 ) THEN
            
                UPDATE or_order_activity
                SET status = 'R',
                final_date = null
                WHERE order_id = inuOrden
                and trunc(final_date) = TO_DATE( '10/10/2024', 'dd/mm/yyyy' );
            
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

	dbms_output.put_line( 'Inicia OSF-3467' );

	FOR reg IN cuOrdenesAnuladas LOOP

		pDesAnulaOrden( reg.order_id, reg.initial_status_id );
		
	END LOOP;
	
	COMMIT;
	dbms_output.put_line( 'Fin OSF-3467' );
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/