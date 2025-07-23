column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso				VARCHAR2(30) := 'OSF-4088';
	rcContratosBloqueo	DALD_quota_block.styLD_quota_block;
	
	CURSOR cuContratos
	IS
		SELECT susccodi
		FROM suscripc  
		WHERE susccodi IN (6116911, 17125503, 6201297, 6115546, 48119985, 1107943, 66363214, 6103905, 6103905, 
                           2118921, 1124489, 6074919, 48002753, 17160073, 17127544, 6239352, 1132513, 17116900,
                           17161095, 6090381, 1113533, 2118763, 48252244, 1118034, 1113533, 48124649, 5161776,
                           6113818, 17136263, 17152143, 6216093, 17125328, 17169906, 6092918, 17106735, 2185272,
                           8085437, 1005406, 66665582, 66577589, 2180430, 6202948, 2156597, 6093400, 6118489, 
                           17161157, 66357834, 66853145, 48206668, 48059639, 48059639, 2159480, 48061026, 6206086,
                           48247279, 14207650, 66258272, 6222868, 66406180, 14218974, 14219733, 6239528, 6239528,
                           6217262, 66250131, 1104651, 17117790, 17220021, 2159515, 17144205, 6239799, 6239799,
                           6237440, 2159480, 2180520, 6235258, 17136385, 6234821, 48231224, 17142123, 66244324,
                           66260976, 66344483, 66869654, 48153586, 66283959, 14219134, 6087162, 2159480, 6237364,
                           66772175, 67143363, 48059639, 48059639, 66551016, 66708797, 17115550, 1070011, 1172439, 
                           17180981, 1502089, 2163284, 66247561, 17153469, 48031675, 6067218, 66269413, 66269413,
                           66269413, 1002259, 6234547, 66529899, 6207722, 6227065, 67116626, 67041301, 6110833,
                           66779505, 66269265, 66869654, 2172878, 6210838, 67010571, 17104892, 17114383, 66333377,
                           14220270, 6200560, 66278878, 6240324, 6233583, 48059639, 48059639, 14205470, 48083378,
                           5158219, 1074408, 66742835, 5158446, 48132923, 66597624, 66597634, 8092380, 6207722,
                           14216173, 67062743, 48120318, 66866931, 12000450, 6102177, 17197899, 2161221, 5156889,
                           48152141, 66498053, 66511870, 67214959, 6134979, 66652577,66644147, 2162842, 48008096,
                           17192116, 17192117, 6021813, 14224251, 17139776, 6222078, 6235544, 6044565, 6139129,
                           17109926, 17119734, 66935001, 1031175);

BEGIN

	dbms_output.put_line('Inicio Datafix OSF-4088');
	
	FOR rcContratos IN cuContratos LOOP
		
		dbms_output.put_line('Creando bloqueo del contrato: ' || rcContratos.susccodi);
			
		-- Llena el registro de los contratos
		rcContratosBloqueo.Quota_Block_Id 	:= SEQ_LD_QUOTA_BLOCK.NEXTVAL;
		rcContratosBloqueo.Block 			:= 'Y';
		rcContratosBloqueo.Subscription_Id 	:= rcContratos.susccodi;
		rcContratosBloqueo.Causal_Id 		:= 130;
		rcContratosBloqueo.Register_Date 	:= LDC_BOCONSGENERALES.FDTGETSYSDATE;
		rcContratosBloqueo.Observation 		:= 'Se bloquea cupo porque usuario no es asegurable porque ya utilizo la cobertura por presentar ITP';
		rcContratosBloqueo.Username			:= PKG_SESSION.GETUSER;
		rcContratosBloqueo.Terminal			:= PKG_SESSION.FSBGETTERMINAL;
		
		DALD_quota_block.insRecord(rcContratosBloqueo);
		
		COMMIT;		
		
	END LOOP;	
	
	dbms_output.put_line('FIN Datafix OSF-4088');
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/