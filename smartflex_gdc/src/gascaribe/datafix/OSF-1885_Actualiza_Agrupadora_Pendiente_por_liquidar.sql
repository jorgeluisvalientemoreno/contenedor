column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    cursor cudatos is
    select b.* from or_order_items a, or_order b 
    where a.order_id = b.order_id
    and a.order_id in (303165656,
    303165658,
    303165659,
    303165660,
    303165661,
    303165662,
    303165663,
    303165664,
    303165665,
    303165666,
    303165667,
    303165668,
    303165669,
    303165670,
    303165671,
    303165672,
    303165673,
    303535535,
    303535538,
    303535533,
    303535534,
    303535536,
    303535537,
    303535539,
    303535540,
    303535541,
    304021843,
    304021844
    ) and a.legal_item_amount = 0 and a.value = 0
    and b.saved_data_values 		= 'ORDER_GROUPED';

	  
	    isbOrderComme   varchar2(4000):='Actualiza la orden a pendiente por liquidar OSF-1885';
      nuCommentType   number:=1277;
      nuErrorCode       number;
      sbErrorMesse      varchar2(4000);
begin
	for reg in cudatos loop
		begin
      
      update or_order
      set IS_PENDING_LIQ = 'Y'
      WHERE order_id = reg.order_id;
      
      OS_ADDORDERCOMMENT (reg.order_id, nuCommentType, isbOrderComme, nuErrorCode,sbErrorMesse);

      dbms_output.put_line('Actualiza la orden correctamente: '||reg.order_id);

		exception
		when others then 
			dbms_output.put_line('Error al actualizar orden: '||reg.order_id||' : '||sqlerrm);
			rollback;
		end;
	end loop;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/