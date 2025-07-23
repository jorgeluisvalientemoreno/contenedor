column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuErrorCode			NUMBER;
	nuCanProdCobrSer	NUMBER := 0;
	nuProductoMotivo	NUMBER;
	nuTipoProducto		NUMBER := 3;
	nuPlanComercial		NUMBER := 4;
	nuDireccion			NUMBER;
	nuProductoCreado	NUMBER;
	nuComponente		NUMBER;
	sbMensajeError  	VARCHAR2(4000);
	rcDireccion			pkg_bcdirecciones.styDirecciones;
	
	CURSOR cuDatos 
	IS
		SELECT sesunuse,
			   sesususc,
			   sesucate,
			   sesusuca
		FROM servsusc 
		WHERE sesuserv = 7014 
		AND sesuplfa = 58
		AND sesususc NOT IN (48120690, 48000565, 48073850, 48139197, 48170789, 1179377, 1169833,
							 48049710, 1169112, 48215111, 48100987, 48044183, 48079644, 66917295,
							 1164611, 48011022, 1190765, 1169860, 66627523, 1187907, 1146982, 48121098,
							 48019141, 1173063);
						   
	CURSOR cuValProdCobroSer(inuContrato IN NUMBER)
	IS
		SELECT COUNT(*)
		FROM servsusc
		WHERE sesususc 	= inuContrato
		AND sesuserv 	= nuTipoProducto
		AND sesuesco 	= 1;
	
BEGIN

	dbms_output.put_line( 'Inicia OSF-4054' );
	
	nuProductoMotivo := pkg_bogestionestructura_prod.fnuObtieneMotivoporNombreTag('M_INSTALACION_DE_COBRO_DE_SERVICIOS_121');
	dbms_output.put_line('nuProductoMotivo: ' || nuProductoMotivo); 
	
	FOR reg IN cuDatos LOOP
	
		dbms_output.put_line('Validando si el contrato ' || reg.sesususc || ' tiene productos de tipo 3'); 
		
		IF (cuValProdCobroSer%ISOPEN) THEN
			CLOSE cuValProdCobroSer;
		END IF;
		
		OPEN cuValProdCobroSer(reg.sesususc);
		FETCH cuValProdCobroSer INTO nuCanProdCobrSer;
		CLOSE cuValProdCobroSer;
		
		dbms_output.put_line('El contrato ' || reg.sesususc || ' tiene ' || nuCanProdCobrSer || ' productos de tipo 3'); 
		
		-- Si el contrato no tiene productos tipo 3
		IF (nuCanProdCobrSer = 0) THEN
		
			dbms_output.put_line('Creando producto tipo 3, para el contrato ' || reg.sesususc); 
	
			-- Obtiene la dirección del producto
			nuDireccion := pkg_bcproducto.fnuIdDireccInstalacion(reg.sesunuse);
			dbms_output.put_line('nuDireccion: ' || nuDireccion); 
		
			-- Obtiene el record de la direccion 
			rcDireccion := pkg_bcdirecciones.frcgetrecord(nuDireccion);	
		
			pkg_bsgestion_producto.prcRegistraProductoyComponente
			(
				reg.sesususc,
				nuTipoProducto,
				nuPlanComercial,
				ldc_boConsGenerales.fdtGetSysDate,
				nuDireccion,
				reg.sesucate,
				reg.sesusuca,
				pkg_session.fnugetempresadeusuario,
				pkg_bopersonal.fnuGetPersonaId,
				pkg_bopersonal.fnuGetPuntoAtencionId(pkg_bopersonal.fnuGetPersonaId),
				nuProductoCreado,
				pkg_gestion_producto.CNUESTADO_ACTIVO_PRODUCTO,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				--Componente
				null,    			/* inuClassServiceId */
				NULL,               /* isbServiceNumber */
				NULL,               /* idtServiceDate */
				NULL,               /* idtMediationDate */
				NULL,               /* inuQuantity */
				NULL,               /* inuUnchargedTime */
				NULL,               /* isbDirectionality */
				NULL,               /* inuDistributAdminId */
				NULL,               /* inuMeter */
				NULL,               /* inuBuildingId */
				NULL,               /* inuAssignRouteId */
				NULL,               /* isbDistrictId */
				NULL,               /* isbincluded */
				rcDireccion.geograp_location_id,   /* inugeograp_location_id */
				rcDireccion.neighborthood_id,      /* inuneighborthood_id */
				rcDireccion.address,               /* isbaddress */
				NULL,               /* inuProductOrigin */
				NULL,               /* inuIncluded_Features_Id */
				NULL,               /* isbIsMain */
				nuComponente,        /* onuComponentId */
				FALSE,              /* iblRegAddress */
				FALSE,              /* iblElemmedi */
				FALSE,              /* iblSpecialPhone */
				NULL,               /* inuCompProdProvisionId */
				pkg_gestion_producto.CNUESTADO_ACTIVO_COMPONENTE,   /* inuComponentStatusId */
				FALSE,              /* iblValidate */
				nuProductoMotivo,   /*inuMotivoProducto*/
				nuErrorCode,
				sbMensajeError
			);
		
			dbms_output.put_line('nuProductoCreado: ' || nuProductoCreado || CHR(10) || 
								 'nuComponente: ' 	  || nuComponente 	  || CHR(10) || 
								 'nuErrorCode: ' 	  || nuErrorCode 	  || CHR(10) ||
								 'sbMensajeError: '   || sbMensajeError); 
	
			COMMIT;
			
		END IF;
	
	END LOOP;
	
	dbms_output.put_line( 'Fin OSF-4054' );
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/