column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	sbCaso  VARCHAR2(20) := 'OSF-767';
    	
    PROCEDURE pRegistraPromocion
    IS              
    
        nuSolicitud         mo_packages.package_id%TYPE := 192369022;
        nuTipoPromocion     Mo_Mot_promotion.Mot_promotion_Id%TYPE := 387;
        
		CURSOR cuSolicitud
		IS
		SELECT mo.package_id, mo.motive_id, pk.request_date
		FROM mo_packages  pk,
            mo_motive   mo
        WHERE
            pk.package_id = nuSolicitud
        AND mo.package_id = pk.package_id
        AND NOT EXISTS
        (
            SELECT '1'
            FROM MO_MOT_PROMOTION pm
            WHERE pm.motive_id = mo.motive_id
            AND pm.promotion_id = nuTipoPromocion
        );
				
		rcMot_promotion  DAMO_MOT_PROMOTION.styMo_Mot_ProMotion;
		
    BEGIN
    
		FOR rgSol IN cuSolicitud LOOP
		
			BEGIN

				dbms_output.put_line( 'NO EXISTE PROMOCION TIPO [' || nuTipoPromocion  || ']Solicitud[' || nuSolicitud || ']'  ); 
			    
                rcMot_promotion.Mot_promotion_Id     := SEQ_MO_MOT_PROMOTIO_182911.NextVal;
                rcMot_promotion.Promotion_id         := nuTipoPromocion;
                rcMot_promotion.Motive_Id            := rgSol.Motive_Id;
                rcMot_promotion.Register_Date        := rgSol.Request_Date;
                rcMot_promotion.Active               := 'Y'; 
				
                DAMO_MOT_PROMOTION.insRecord ( rcMot_promotion );
			
				COMMIT;
				
				dbms_output.put_line( 'SE INSERTO PROMOCION [' || rcMot_promotion.Mot_promotion_Id  || ']Solicitud[' || nuSolicitud || ']'  ); 
				
				EXCEPTION 
					WHEN OTHERS THEN
                        dbms_output.put_line( 'ERROR INSERTANDO PROMOCION Solicitud[' || nuSolicitud || '][' || SQLERRM || ']'  ); 
						ROLLBACK;			
			END;
		
		END LOOP;		
        
    END pRegistraPromocion;
    
    PROCEDURE pActSolicPuntoAtencion
    IS              
    
        nuSolicitud         mo_packages.package_id%TYPE := 192369022;
        nuTipoPromocion     Mo_Mot_promotion.Mot_promotion_Id%TYPE := 387;
        
		CURSOR cuSolicitud
		IS
		SELECT pk.*, pk.ROWID RId
		FROM mo_packages  pk
        WHERE
        pk.package_id in
        (
            194216735,
            194218102,
            194220377,
            194221132,
            192320703,
            192123699
        );
				
		rcMot_promotion  DAMO_MOT_PROMOTION.styMo_Mot_ProMotion;
		
    BEGIN
    
		FOR rgSol IN cuSolicitud LOOP
		
			BEGIN

				dbms_output.put_line( 'ANTES - Solicitud[' || rgSol.Package_Id || ']Punto Atencion[' || rgSol.Sale_Channel_Id || ']'  ); 
			    
                UPDATE mo_packages
                SET Sale_Channel_Id = 4131
                WHERE ROWID = rgSol.RId;
			
				COMMIT;
				
				dbms_output.put_line( 'DESPUES - Solicitud[' || rgSol.Package_Id || ']Punto Atencion[' || '4131' || ']'  );
								
				EXCEPTION 
					WHEN OTHERS THEN
                        dbms_output.put_line( 'ERROR - Solicitud[' || rgSol.Package_Id || ']Punto Atencion[' || rgSol.Sale_Channel_Id || '][' || SQLERRM || ']'  );
						ROLLBACK;			
			END;
		
		END LOOP;		
        
    END pActSolicPuntoAtencion;   
     
begin
	pRegistraPromocion;
	
	pActSolicPuntoAtencion;
		
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/