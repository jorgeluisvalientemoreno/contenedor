column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    nuError    NUMBER;
    sbError    VARCHAR2(4000);
    nuEstadoInventario  ge_items_seriado.id_items_estado_inv%TYPE := 17;


    CURSOR cuItemsSeriado
    IS
    SELECT  *
    FROM    ge_items_seriado
    WHERE   serie = 'S-327831-19';

BEGIN

    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Inicia Baja de item');

    
    FOR rcItems IN cuItemsSeriado LOOP 

        dbms_output.put_line('Inicia cambio de estado Items seriado ['||rcItems.id_items_seriado||']');
		
        UPDATE  ge_items_seriado
        SET     id_items_estado_inv = nuEstadoInventario,
				numero_servicio		= NULL,
				propiedad			= 'E'
        WHERE  id_items_seriado = rcItems.id_items_seriado;
		
		
        dbms_output.put_line('Fin cambio de estado Items seriado ['||rcItems.id_items_seriado||']');
		
		dbms_output.put_line('Inicia inserción del log de movimientos del item seriado ['||rcItems.id_items_seriado||']');
		
        INSERT INTO OR_UNI_ITEM_BALA_MOV (UNI_ITEM_BALA_MOV_ID, 
										 ITEMS_ID, 
										 OPERATING_UNIT_ID, 
										 ITEM_MOVEME_CAUS_ID, 
										 MOVEMENT_TYPE, 
										 AMOUNT, 
										 COMMENTS, 
										 MOVE_DATE, 
										 TERMINAL, 
										 USER_ID, 
										 SUPPORT_DOCUMENT,
										 TARGET_OPER_UNIT_ID,
										 TOTAL_VALUE, 
										 ID_ITEMS_DOCUMENTO, 
										 ID_ITEMS_SERIADO,
										 ID_ITEMS_ESTADO_INV,
										 VALOR_VENTA,
										 INIT_INV_STAT_ITEMS
										 )
		VALUES (or_bosequences.fnunextor_uni_item_bala_mov, 
				rcItems.items_id, 
				799, 
				-1,
				'N', 
				1, 
				'Creado por caso OSF-4036', 
				SYSDATE, 
				pkg_session.fsbgetTerminal, 
				pkg_session.getUser, 
				' ', 
				799,
				0, 
				NULL,
				rcItems.id_items_seriado,
				17,
				0,
				rcItems.id_items_estado_inv
				);		
		
        dbms_output.put_line('Finaliza inserción del log de movimientos del item seriado ['||rcItems.id_items_seriado||']');
		
    END LOOP;

    COMMIT;
	
	dbms_output.put_line('Finaliza Baja de item');
	
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Baja de item '||nuerror||'-'||sberror||']');

        rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/