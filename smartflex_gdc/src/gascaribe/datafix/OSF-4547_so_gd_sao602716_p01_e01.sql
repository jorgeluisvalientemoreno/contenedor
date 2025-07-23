column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
     
    NUERRORCODE     NUMBER (18); 
    SBERRORMESSAGE  VARCHAR2(2000);  
    
    CNUANNUL_CAUSAL_TYPE    CONSTANT NUMBER         := 18; 
    
    RCORDERACTIVITY    DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY; 
    RCORDER            DAOR_ORDER.STYOR_ORDER; 
    RCCAUSAL           DAGE_CAUSAL.STYGE_CAUSAL; 
    
    BLFLAGRECONECT     BOOLEAN := TRUE; 
    DTINACTIVEDATE     PR_PROD_SUSPENSION.INACTIVE_DATE%TYPE; 
    
    CURSOR CUPRODSUSPEN 
    IS 
    SELECT 
        A.PRODUCT_ID, 
        A.PROD_SUSPENSION_ID, 
        A.REGISTER_DATE REGISTER_DATE_PR, 
        A.APLICATION_DATE APLICATION_DATE_PR, 
        A.INACTIVE_DATE INACTIVE_DATE_PR, 
        A.ACTIVE ACTIVE_PR, 
        C.PACKAGE_ID, 
        B.MOTIVE_ID MOTIVE_ID_M, 
        B.REGISTER_DATE REGISTER_DATE_M, 
        B.APLICATION_DATE APLICATION_DATE_M, 
        B.ENDING_DATE ENDING_DATE_M 
    FROM PR_PROD_SUSPENSION A, MO_SUSPENSION B, MO_MOTIVE C, MO_PACKAGES D 
    WHERE 1=1 
    
    AND   A.APLICATION_DATE IS NOT NULL 
    AND   A.ACTIVE = 'N' 
    AND   A.INACTIVE_DATE IS NULL 
    AND   A.SUSPENSION_TYPE_ID = 5 
    AND   A.REGISTER_DATE = B.REGISTER_DATE 
    AND   B.SUSPENSION_TYPE_ID = 5 
    AND   B.MOTIVE_ID = C.MOTIVE_ID 
    AND   A.PRODUCT_ID = C.PRODUCT_ID 
    AND   C.PACKAGE_ID = D.PACKAGE_ID 
    AND   D.PACKAGE_TYPE_ID = 100209 
    ORDER BY A.PRODUCT_ID, A.REGISTER_DATE;  
    
    CURSOR CUSOLISRECON 
    ( 
        INUPRODUCT      IN MO_MOTIVE.PRODUCT_ID%TYPE, 
        IDTAPLICATION   IN MO_SUSPENSION.APLICATION_DATE%TYPE 
    ) 
    IS 
    SELECT 
        C.MOTIVE_ID,     
        B.PACKAGE_ID 
    FROM MO_MOTIVE A, MO_PACKAGES B, MO_SUSPENSION C 
    WHERE 1=1 
    AND   A.PRODUCT_ID = INUPRODUCT 
    AND   A.PACKAGE_ID = B.PACKAGE_ID 
    AND   B.PACKAGE_TYPE_ID = 100210 
    AND   A.MOTIVE_ID = C.MOTIVE_ID 
    AND   C.REGISTER_DATE >= IDTAPLICATION 
    ORDER BY C.REGISTER_DATE;     
    
    CURSOR CUDATEATTENTIONINSTANCERECON 
    ( 
        INUPACKAGEID    IN MO_WF_PACK_INTERFAC.PACKAGE_ID%TYPE 
    ) 
    IS 
    SELECT 
        ATTENDANCE_DATE 
    FROM MO_WF_PACK_INTERFAC 
    WHERE PACKAGE_ID = INUPACKAGEID  
    AND   ACTION_ID = 8117; 
    
    CURSOR CUCOMPSUSPEN 
    ( 
        INUMOTIVEID         IN      MO_SUSPENSION.MOTIVE_ID%TYPE, 
        INUREGISTERDATE     IN      PR_PROD_SUSPENSION.REGISTER_DATE%TYPE 
    ) 
    IS 
    SELECT 
        B.COMP_SUSPENSION_ID, 
        B.COMPONENT_ID, 
        B.REGISTER_DATE REGISTER_DATE_C, 
        B.APLICATION_DATE APLICATION_DATE_C, 
        B.INACTIVE_DATE INACTIVE_DATE_C 
    FROM MO_COMPONENT A, PR_COMP_SUSPENSION B 
    WHERE 1=1 
    AND   A.MOTIVE_ID = INUMOTIVEID 
    AND   A.COMPONENT_ID_PROD = B.COMPONENT_ID 
    AND   B.REGISTER_DATE = INUREGISTERDATE 
    AND   B.SUSPENSION_TYPE_ID = 5; 
     
BEGIN 

	dbms_output.put_line('Inicia SO_GD_SAO602716_P01_E01 OSF-4547');
   
    ROLLBACK; 
 
    FOR X IN CUPRODSUSPEN LOOP 
 
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------------'); 
        DBMS_OUTPUT.PUT_LINE('se obtuvo el producto: '||X.PRODUCT_ID); 
        DBMS_OUTPUT.PUT_LINE('se debe actualizar la fecha de inactivaci�n para la solicitud de suspensi�n: '||X.PACKAGE_ID); 
        DBMS_OUTPUT.PUT_LINE('datos obtenidos: '); 
        DBMS_OUTPUT.PUT_LINE('id registro pr_prod_suspension: '||X.PROD_SUSPENSION_ID); 
        DBMS_OUTPUT.PUT_LINE('fecha registro pr_prod_suspension: '||X.REGISTER_DATE_PR); 
        DBMS_OUTPUT.PUT_LINE('fecha aplicacion pr_prod_suspension: '||X.APLICATION_DATE_PR); 
        DBMS_OUTPUT.PUT_LINE('fecha inactivaci�n pr_prod_suspension: '||X.INACTIVE_DATE_PR); 
        DBMS_OUTPUT.PUT_LINE('activa en pr_prod_suspension: '||X.ACTIVE_PR); 
        DBMS_OUTPUT.PUT_LINE('motivo mo_suspension: '||X.MOTIVE_ID_M); 
        DBMS_OUTPUT.PUT_LINE('fecha registro mo_suspension: '||X.REGISTER_DATE_M); 
        DBMS_OUTPUT.PUT_LINE('fecha aplicacion mo_suspension: '||X.APLICATION_DATE_M); 
        DBMS_OUTPUT.PUT_LINE('fecha inactivaci�n mo_suspension: '||X.ENDING_DATE_M);  
 
        FOR Y IN CUSOLISRECON(X.PRODUCT_ID, X.APLICATION_DATE_PR) LOOP  
 
            BLFLAGRECONECT := TRUE; 
 
            DBMS_OUTPUT.PUT_LINE(''); 
            DBMS_OUTPUT.PUT_LINE('buscando actividad de reconexi�n...'); 
 
            IF CUDATEATTENTIONINSTANCERECON%ISOPEN THEN 
                CLOSE CUDATEATTENTIONINSTANCERECON; 
            END IF; 
 
            OPEN CUDATEATTENTIONINSTANCERECON(Y.PACKAGE_ID); 
            FETCH CUDATEATTENTIONINSTANCERECON INTO DTINACTIVEDATE; 
            CLOSE CUDATEATTENTIONINSTANCERECON; 
            
            RCORDERACTIVITY  := OR_BCACTIVITIESBYTASKTYPE.FRCGETRECBYMOTANDPRO(Y.MOTIVE_ID, X.PRODUCT_ID); 
            
            IF  (RCORDERACTIVITY.ORDER_ACTIVITY_ID IS NOT NULL) THEN 
                
                RCORDER := DAOR_ORDER.FRCGETRECORD(RCORDERACTIVITY.ORDER_ID); 
                DTINACTIVEDATE := RCORDER.EXECUTION_FINAL_DATE; 
 
                IF (RCORDER.CAUSAL_ID IS NOT NULL) THEN 
                    
                    RCCAUSAL := DAGE_CAUSAL.FRCGETRECORD(RCORDER.CAUSAL_ID); 
 
                    IF (RCCAUSAL.CLASS_CAUSAL_ID <> MO_BOCAUSAL.FNUGETSUCCESS) THEN 
                        
                        BLFLAGRECONECT := FALSE;                  
                    
                    ELSIF ((RCCAUSAL.CLASS_CAUSAL_ID = MO_BOCAUSAL.FNUGETSUCCESS) AND 
                           (RCCAUSAL.CAUSAL_TYPE_ID <> CNUANNUL_CAUSAL_TYPE)) THEN 
                        
                        BLFLAGRECONECT := TRUE;                         
                   
                    ELSIF (RCCAUSAL.CAUSAL_TYPE_ID = CNUANNUL_CAUSAL_TYPE) THEN 
                        
                        BLFLAGRECONECT := FALSE; 
                        
                    END IF; 
                
                ELSE 
                    
                    BLFLAGRECONECT := TRUE; 
                    
                END IF; 
            
            ELSE 
                
                BLFLAGRECONECT := TRUE;            
 
            END IF; 
 
            IF BLFLAGRECONECT THEN 
 
                DBMS_OUTPUT.PUT_LINE('Actividad de reconexi�n encontrada ['||RCORDERACTIVITY.ORDER_ACTIVITY_ID||']'); 
                DBMS_OUTPUT.PUT_LINE('Causal ['||RCCAUSAL.CAUSAL_ID||']'); 
                DBMS_OUTPUT.PUT_LINE('Clase de causal ['||RCCAUSAL.CLASS_CAUSAL_ID||']'); 
                DBMS_OUTPUT.PUT_LINE('Tipo de causal ['||RCCAUSAL.CAUSAL_TYPE_ID||']'); 
 
                DBMS_OUTPUT.PUT_LINE('motivo de reconexi�n obtenido: '||Y.MOTIVE_ID); 
                DBMS_OUTPUT.PUT_LINE('se actualiza la fecha de inactivaci�n de la suspensi�n con la fecha de reconexi�n: '||DTINACTIVEDATE||' de la solicitud: '||Y.PACKAGE_ID); 
                DAPR_PROD_SUSPENSION.UPDINACTIVE_DATE(X.PROD_SUSPENSION_ID, DTINACTIVEDATE); 
 
                IF X.ENDING_DATE_M IS NULL THEN 
                    DBMS_OUTPUT.PUT_LINE('se actualiza la fecha de inactivaci�n de la suspensi�n del motivo: '||X.MOTIVE_ID_M); 
                    DAMO_SUSPENSION.UPDENDING_DATE(X.MOTIVE_ID_M, DTINACTIVEDATE); 
                END IF; 
 
                FOR Z IN CUCOMPSUSPEN(X.MOTIVE_ID_M, X.REGISTER_DATE_PR) LOOP 
                    IF Z.INACTIVE_DATE_C IS NULL THEN 
                        DBMS_OUTPUT.PUT_LINE('se actualiza la fecha de inactivaci�n de la suspensi�n del componente: '||Z.COMPONENT_ID); 
                        DAPR_COMP_SUSPENSION.UPDINACTIVE_DATE(Z.COMP_SUSPENSION_ID, DTINACTIVEDATE); 
                    END IF; 
                END LOOP; 
 
                
                EXIT; 
 
            END IF; 
 
        END LOOP; 
 
    END LOOP;  
 
    COMMIT; 
	
	dbms_output.put_line('Finaliza SO_GD_SAO602716_P01_E01 OSF-4547');
 
EXCEPTION 
    WHEN OTHERS THEN 
        ERRORS.SETERROR; 
        ERRORS.GETERROR (NUERRORCODE, SBERRORMESSAGE);  
		dbms_output.put_line('NUERRORCODE: ' || NUERRORCODE || ' SBERRORMESSAGE: ' || SBERRORMESSAGE); 		
        ROLLBACK; 

END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/