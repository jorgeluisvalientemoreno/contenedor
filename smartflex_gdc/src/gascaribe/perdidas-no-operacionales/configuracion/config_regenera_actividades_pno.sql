column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuActividades
    IS
    SELECT it.*, it.ROWID Rid
    FROM ge_items it
    WHERE items_id in
    ( 
        4000949, -- VISITA VERIFICACION ANOMALIA
        4295152, -- CIERRE DE PNO
        4294367, -- REVISION INICIO ACTUACION ADMINISTRATIVA
        4000948  -- INFORMANTE
    );
    
    CURSOR cuReglasActi ( inuActividad NUMBER )
    IS
    SELECT CASE inuActividad 
            WHEN 4000949 THEN 56324   -- GAS - Registra los complementos de lectura para la presion y temperatura en legalizacion
            WHEN 4295152 THEN 53280  -- FM_BO_NTL_PROCESS.OBJUPDATENTLNOTFOUND
            WHEN 4294367 THEN 53279  -- FM_BO_NTL_PROCESS.OBJUPDATENTLFOUND
            WHEN 4000948 THEN 56324   -- GAS - Registra los complementos de lectura para la presion y temperatura en legalizacion
            END IdReglaActi
    FROM DUAL;
    
    rcReglasActi  cuReglasActi%ROWTYPE; 
    
    PROCEDURE pDelConfigLdItemObj( inuActividad NUMBER )
    IS
        CURSOR culdc_Item_Obj( inuActi NUMBER )
        IS
        SELECT ld.*, ld.rowid rid
        FROM ldc_Item_Obj ld
        WHERE item_id = inuActi;    
    BEGIN
    
        dbms_output.put_line('Inicia pDelConfigLdItemObj');
            
        FOR rg IN culdc_Item_Obj( inuActividad ) LOOP
            delete from ldc_Item_Obj where rowid = rg.rid;
            dbms_output.put_line( rg.item_obj_id || '|' || rg.item_id || '|' || rg.object_id || '|' || rg.is_active || '|' || rg.ord_execut || '|BORRADO' );
        END LOOP;
        
        dbms_output.put_line('Termina pDelConfigLdItemObj');
                
    END pDelConfigLdItemObj; 

	PROCEDURE pDelConfigOrRegeneraActivida
	IS
	
		CURSOR cuOR_Regenera_Activida IS
		select 	a.ID_REGENERA_ACTIVIDA || '|' ||
				ACTIVIDAD ||'|' ||
				ID_CAUSAL  ||'|' ||
				CUMPLIDA ||'|' ||
				ACTIVIDAD_REGENERAR  ||'|' ||
				ACTIVIDAD_WF  ||'|' ||
				ESTADO_FINAL  ||'|' ||
				TIEMPO_ESPERA  ||'|' ||
				ACTION  ||'|' ||
				TRY_LEGALIZE datos,
				a.ROWID RId
		  from open.or_regenera_activida a,
			   open.or_task_Types_items  ti,
			   open.ge_causal            c,
			   open.or_task_Types_items  ti2
		 where a.actividad = ti.items_id
		   and a.id_causal = c.causal_id
		   and ti2.items_id = a.actividad_regenerar
		   and a.actividad_regenerar in (4000949, 4000948);
	
	BEGIN
	
		dbms_output.put_line('Inicia pDelConfigOrRegeneraActivida');

		dbms_output.put_line( 'ID_REGENERA_ACTIVIDA|ACTIVIDAD|ID_CAUSAL|CUMPLIDA|ACTIVIDAD_REGENERAR|ACTIVIDAD_WF|ESTADO_FINAL|TIEMPO_ESPERA|ACTION|TRY_LEGALIZE');
		
		FOR rgConf IN cuOR_Regenera_Activida LOOP
		
			delete from OR_Regenera_Activida WHERE ROWID = rgConf.RId;

			dbms_output.put_line( rgConf.Datos || '|' || 'Borrado' );		
		
		END LOOP;
	
		dbms_output.put_line('Termina pDelConfigOrRegeneraActivida');
	
	END pDelConfigOrRegeneraActivida;
	
	PROCEDURE pInsConfigLdcProcedimientoObj 
	IS
	
        sbProcedimiento ldc_procedimiento_obj.procedimiento%TYPE    := 'LDC_BOREGISTROPNO.PREGENERAORDENPNO';
            
        sbDescripcion   ldc_procedimiento_obj.descripcion%TYPE      := 'REGENEACION ACTIVIDADES PNO';

        CURSOR cuOR_TASK_TYPE
        IS
        SELECT *
        FROM or_task_type tt
        WHERE tt.task_type_id in
        (
            12486,
            12684,
            12688,
            12689,
            12690,
            12631,
            12844,
            12844,
            12844,
            12620,
            10944
        );
        
        CURSOR cuLDC_PROCEDIMIENTO_OBJ ( inuTask_Type_Id ldc_procedimiento_obj.task_type_id%TYPE)
        IS
        SELECT *
        FROM LDC_PROCEDIMIENTO_OBJ
        WHERE task_type_id = inuTask_Type_Id
        AND procedimiento = sbProcedimiento;

        rcLDC_PROCEDIMIENTO_OBJ cuLDC_PROCEDIMIENTO_OBJ%ROWTYPE;

	BEGIN

		dbms_output.put_line('Inicia pInsConfigLdcProcedimientoObj');

		

		FOR rgTT IN cuOR_TASK_TYPE LOOP
		
            rcLDC_PROCEDIMIENTO_OBJ := NULL;
            
            OPEN cuLDC_PROCEDIMIENTO_OBJ( rgTT.task_type_id );
            FETCH cuLDC_PROCEDIMIENTO_OBJ INTO rcLDC_PROCEDIMIENTO_OBJ;
            CLOSE cuLDC_PROCEDIMIENTO_OBJ;
            
            IF rcLDC_PROCEDIMIENTO_OBJ.task_type_id IS NULL THEN
            
                INSERT INTO ldc_procedimiento_obj
                (
                    task_type_id    ,
                    causal_id       ,
                    procedimiento   ,
                    descripcion     ,
                    orden_ejec      ,
                    activo      
                )                
                VALUES
                (
                    rgTT.task_type_id   ,   
                    NULL                ,
                    sbProcedimiento     ,
                    sbDescripcion       ,
                    99                  ,
                    'S'     
                );
                
                dbms_output.put_line('Se inserto en ldc_procedimiento_obj :tipo de trabajo|' ||  rgTT.task_type_id || '|Procedimiento|' ||sbProcedimiento );
                
            END IF;
		
		END LOOP;
			
		dbms_output.put_line('Termina pInsConfigLdcProcedimientoObj');	
	
	END pInsConfigLdcProcedimientoObj;
    
BEGIN
        
    --
    FOR rgActividad IN cuActividades LOOP
    
        rcReglasActi := NULL;
    
        OPEN cuReglasActi( rgActividad.Items_Id) ;
        FETCH cuReglasActi INTO rcReglasActi;
        CLOSE cuReglasActi;
        
        dbms_output.put_line( 'Actividad|' || rgActividad.Items_Id || '|ReglaActual|' ||rgActividad.object_id || '|ReglaNueva|' ||rcReglasActi.IdReglaActi  );
        
        IF rgActividad.object_id <> rcReglasActi.IdReglaActi THEN
        
            update ge_items set object_id = rcReglasActi.IdReglaActi
            WHERE ROWID = rgActividad.Rid;
            
            IF rgActividad.object_id = 120140 THEN
            
                pDelConfigLdItemObj( rgActividad.Items_Id );
                
            END IF;
            
        END IF;
    
    END LOOP;
    
    pDelConfigOrRegeneraActivida;
    
    pInsConfigLdcProcedimientoObj;
    
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('ERROR|'|| sqlerrm);
            ROLLBACK; 
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/