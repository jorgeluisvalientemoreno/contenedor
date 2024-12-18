CREATE OR REPLACE procedure PROASIGNAORDENES is
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PROASIGNAORDENES
    Descripcion    : Realiza asignacion de ordenes masivas solo a la de inspeccion generadas 
	                 despues de la carga	                 

    Autor          : Jennifer Gutierrez Cundar/Olsoftware
    Fecha          : 30/10/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
	

  ******************************************************************/  
/*Realiza la ejecucion del API para la migracion de las solicitudes*/
	cursor cuLDC_MIG_SOLIVENT is
	 select * from LDC_MIG_SOLIVENT,LDC_MIG_ORDEPROC 
      Where MIVEDEPA = deparpere
		  and MIVELOCA = locapere
		  and MIVENUPE = atencion
		  and MIVEPROC = 'P';
	  
	cursor cuLDC_MIG_SOLIVENTASIG is
	 select * from LDC_MIG_SOLIVENT
	    Where not exists(select atencion from LDC_MIG_ORDEPROC
							where deparpere = MIVEDEPA
							  and locapere = MIVELOCA
							  and atencion = MIVENUPE)
               and MIVEPROC = 'P';	  
			
    regLDC_MIG_SOLIVENTASIG	  cuLDC_MIG_SOLIVENTASIG%rowtype;
		
     
    regLDC_MIG_SOLIVENT cuLDC_MIG_SOLIVENT%rowtype;
    
    

	cursor cuOR_ORDER_ACTIVITY(packageId in number) is
	 select a.order_id, a.task_type_id from OR_order a
		where exists (select 'x' from OR_ORDER_ACTIVITY b
						where a.order_id = b.order_id
						and   b.PACKAGE_ID = packageId)
						and   a.ORDER_status_id != 5
						and   a.task_type_id in (12162);
    
	
	cursor cuHOMOCUAD(nuCuad in number) is
	  select HOCUUNOP from LDC_MIG_HOMCUAD
	   where HOCUPROC = 'V'
		 and HOCUCUAD = nuCuad;
     
 cursor or_order_activity2(nuTrabajo in number,nusolicitud in number) is
	select order_id,operating_unit_id 
		from or_order_activity
		where package_id   =nusolicitud
		  and task_type_id = nuTrabajo;
			
    onuErrorCode    number;
    sbErrMens       varchar2(4000);
    onuPackageId    number;
    onuMotiveId     number;
    nuErrorCode     number;
    sbErrorMessage1 varchar2(4000);
    sberrormessage varchar2(4000);
    nuOperatingUnitId number;
    nuOrden_id   number;
    nuTipoTrab   number;
    sbsentencia  varchar2(100) :=  'Alter trigger LDC_TRGAU_ASIGAUTO DISABLE';
    sbsentencia1  varchar2(100):=  'Alter trigger LDC_TRBIGASIGAUTO DISABLE';
    sbsentencia2  varchar2(100):=  'Alter trigger LDC_TRGAUASIGAUTO DISABLE';
    nuordenInstalacion number;
    nuordenCargoConexion number;
    nuTrabajoConexion number:= 12150;
    nuTrabajoInstalacion number:= 12149; 	
    nuUnidadInstalacion  number:= 0;
    nuunidadCargo        number:= 0;   
    nupersonid2          number:= 0;
    nupersonid          number:= 0;
	nuCuadrillacompar number:= 0;
BEGIN
 
          
  For regLDC_MIG_SOLIVENT in cuLDC_MIG_SOLIVENT Loop    
 
        --Asignacion de las ordenes no asignadas por el proceso				
		open  cuHOMOCUAD(regLDC_MIG_SOLIVENT.cuadrilla);
		fetch cuHOMOCUAD into nuOperatingUnitId;
		close cuHOMOCUAD;
		nuOrden_id  := 0;
	    nuTipoTrab  := 0;
		--Ontiene si existen las ordenses de cargo por conexion e interna
		nuTrabajoConexion := 12150;
		nuTrabajoInstalacion := 12149; 
		nuordenCargoConexion := 0;
		nuordenInstalacion   := 0;
		nuUnidadInstalacion  := 0;
		nuunidadCargo        := 0;
     
       open or_order_activity2(nuTrabajoConexion,regLDC_MIG_SOLIVENT.MIVESOLI);
       fetch or_order_activity2 into nuordenCargoConexion,nuunidadCargo;
       close or_order_activity2;
	
       open or_order_activity2(nuTrabajoInstalacion,regLDC_MIG_SOLIVENT.MIVESOLI);
       fetch or_order_activity2 into nuordenInstalacion,nuUnidadInstalacion;
       close or_order_activity2;

		  
		  
        If (nvl(nuordenCargoConexion,0) = 0) or (nvl(nuordenInstalacion,0) = 0 or nvl(nuUnidadInstalacion,0)= 0) Then
                  update LDC_MIG_SOLIVENT
					 set MIVEERCA = 'No se puede realizar asignacion de la certificacion por que no existe la orden cargo de conexion o instalacion interna',
						 MIVEPROC = 'R'						 
				   where MIVEDEPA = regLDC_MIG_SOLIVENT.MIVEDEPA
					 and MIVELOCA = regLDC_MIG_SOLIVENT.MIVELOCA
					 and MIVENUPE = regLDC_MIG_SOLIVENT.MIVENUPE;
				  commit;		    
        Else		
			open  cuOR_ORDER_ACTIVITY(regLDC_MIG_SOLIVENT.MIVESOLI);
			fetch cuOR_ORDER_ACTIVITY into nuOrden_id,nuTipoTrab;
			close cuOR_ORDER_ACTIVITY;

			If nvl(nuOrden_id,0) > 0 Then
				os_assign_order(nuOrden_id,nuOperatingUnitId,sysdate,sysdate,nuerrorcode,sberrormessage);	
				commit;
				If sberrormessage is not null Then
				  update LDC_MIG_SOLIVENT
					 set MIVEERCA = sberrormessage,
						 MIVEPROC = 'R',
						 MIVEOTAC = nuOrden_id
				   where MIVEDEPA = regLDC_MIG_SOLIVENT.MIVEDEPA
					 and MIVELOCA = regLDC_MIG_SOLIVENT.MIVELOCA
					 and MIVENUPE = regLDC_MIG_SOLIVENT.MIVENUPE;
				  commit;

				Else
				  update LDC_MIG_SOLIVENT
					 set MIVEERCA = sberrormessage,
						 MIVEPROC = 'A',
						 MIVEOTAC = nuOrden_id
				  where  MIVEDEPA = regLDC_MIG_SOLIVENT.MIVEDEPA
					 and MIVELOCA = regLDC_MIG_SOLIVENT.MIVELOCA
					 and MIVENUPE = regLDC_MIG_SOLIVENT.MIVENUPE;
				   commit;
				   
				  --Realiza Ejecucion de la orden de cargo por conexion y de interna	
  
					SELECT person_id into nupersonid
					FROM OR_OPER_UNIT_PERSONS
					WHERE operating_unit_id = nuunidadCargo
					AND ROWNUM = 1;		

					SELECT person_id into nupersonid2
					FROM OR_OPER_UNIT_PERSONS
					WHERE operating_unit_id = nuUnidadInstalacion
					AND ROWNUM = 1;							
					
                    INSERT INTO LDC_ASIG_OT_TECN(unidad_operativa,tecnico_unidad,orden) VALUES(nuunidadCargo,nupersonid,nuordenCargoConexion);	
                    commit;					
				    Or_BoEjecutarOrden.ExecOrderWithCausal(nuordenCargoConexion,1,null,null,sysdate);
					commit;
				    INSERT INTO LDC_ASIG_OT_TECN(unidad_operativa,tecnico_unidad,orden) VALUES(nuUnidadInstalacion,nupersonid2,nuordenInstalacion);	
					commit;
					Or_BoEjecutarOrden.ExecOrderWithCausal(nuordenInstalacion,1,null,null,sysdate);
				    commit;
				End If;					   
			Else
				  update LDC_MIG_SOLIVENT
					 set MIVEERCA = 'Error la Orden de trabajo de certificacion No existe',
						 MIVEPROC = 'R'
				   where MIVEDEPA = regLDC_MIG_SOLIVENT.MIVEDEPA
					 and MIVELOCA = regLDC_MIG_SOLIVENT.MIVELOCA
					 and MIVENUPE = regLDC_MIG_SOLIVENT.MIVENUPE;
				  commit;	   
			End If;	
		End If;
 End Loop;  

 For regLDC_MIG_SOLIVENTASIG in cuLDC_MIG_SOLIVENTASIG loop
    If (regLDC_MIG_SOLIVENTASIG.mivedepa = 76 and regLDC_MIG_SOLIVENTASIG.miveloca = 1) Then
	  
			nuOrden_id :=0;
			nuTipoTrab :=0;	
			open  cuOR_ORDER_ACTIVITY(regLDC_MIG_SOLIVENTASIG.MIVESOLI);
			fetch cuOR_ORDER_ACTIVITY into nuOrden_id,nuTipoTrab;
			close cuOR_ORDER_ACTIVITY;
            nuOperatingUnitId := 390;		
 		
			If nvl(nuOrden_id,0) > 0 Then
				os_assign_order(nuOrden_id,nuOperatingUnitId,sysdate,sysdate,nuerrorcode,sberrormessage);	
				commit;
				If sberrormessage is not null Then
				  update LDC_MIG_SOLIVENT
					 set MIVEERCA = sberrormessage,
						 MIVEPROC = 'R',
						 MIVEOTAC = nuOrden_id
				   where MIVEDEPA = regLDC_MIG_SOLIVENTASIG.MIVEDEPA
					 and MIVELOCA = regLDC_MIG_SOLIVENTASIG.MIVELOCA
					 and MIVENUPE = regLDC_MIG_SOLIVENTASIG.MIVENUPE;
				  commit;

				Else
				  update LDC_MIG_SOLIVENT
					 set MIVEERCA = sberrormessage,
						 MIVEPROC = 'A',
						 MIVEOTAC = nuOrden_id
				  where  MIVEDEPA = regLDC_MIG_SOLIVENTASIG.MIVEDEPA
					 and MIVELOCA = regLDC_MIG_SOLIVENTASIG.MIVELOCA
					 and MIVENUPE = regLDC_MIG_SOLIVENTASIG.MIVENUPE;
				   commit;
				End If;
			Else
				  update LDC_MIG_SOLIVENT
					 set MIVEERCA = 'Error la Orden de trabajo No existe',
						 MIVEPROC = 'R'
				   where MIVEDEPA = regLDC_MIG_SOLIVENTASIG.MIVEDEPA
					 and MIVELOCA = regLDC_MIG_SOLIVENTASIG.MIVELOCA
					 and MIVENUPE = regLDC_MIG_SOLIVENTASIG.MIVENUPE;
				  commit;	  				
			 End If;
    Else
	    nuOrden_id :=0;
		nuTipoTrab :=0;
		open  cuOR_ORDER_ACTIVITY(regLDC_MIG_SOLIVENTASIG.MIVESOLI);
		fetch cuOR_ORDER_ACTIVITY into nuOrden_id,nuTipoTrab;
		close cuOR_ORDER_ACTIVITY;
		nuOperatingUnitId := 782;			
		If nvl(nuOrden_id,0) > 0 Then
			os_assign_order(nuOrden_id,nuOperatingUnitId,sysdate,sysdate,nuerrorcode,sberrormessage);	
			commit;
			If sberrormessage is not null Then
			  update LDC_MIG_SOLIVENT
				 set MIVEERCA = sberrormessage,
					 MIVEPROC = 'R',
					 MIVEOTAC = nuOrden_id
			   where MIVEDEPA = regLDC_MIG_SOLIVENTASIG.MIVEDEPA
				 and MIVELOCA = regLDC_MIG_SOLIVENTASIG.MIVELOCA
				 and MIVENUPE = regLDC_MIG_SOLIVENTASIG.MIVENUPE;
			  commit;

			Else
			  update LDC_MIG_SOLIVENT
				 set MIVEERCA = sberrormessage,
					 MIVEPROC = 'A',
					 MIVEOTAC = nuOrden_id
			  where  MIVEDEPA = regLDC_MIG_SOLIVENTASIG.MIVEDEPA
				 and MIVELOCA = regLDC_MIG_SOLIVENTASIG.MIVELOCA
				 and MIVENUPE = regLDC_MIG_SOLIVENTASIG.MIVENUPE;
			   commit;
			End If;
		Else
			  update LDC_MIG_SOLIVENT
				 set MIVEERCA = 'Error la Orden de trabajo de certificacion No existe',
					 MIVEPROC = 'R'
			   where MIVEDEPA = regLDC_MIG_SOLIVENTASIG.MIVEDEPA
				 and MIVELOCA = regLDC_MIG_SOLIVENTASIG.MIVELOCA
				 and MIVENUPE = regLDC_MIG_SOLIVENTASIG.MIVENUPE;
			  commit;	  				
		 End If;    	
	End If;
 End Loop;
exception
 when others then
    dbms_output.put_line('error'||DBMS_UTILITY.format_error_backtrace||' Codigo Error'||SQLCODE);
    sbErrMens := 'ERROR: <PROASIGNAORDENES>:' || DBMS_UTILITY.format_error_backtrace||' Codigo Error'||SQLCODE;  
end PROASIGNAORDENES;
/
