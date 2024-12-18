CREATE OR REPLACE PROCEDURE LDC_PBLDCRVP (inuProgramacion in ge_process_schedule.process_schedule_id%type) is

      /*******************************************************************************
     Metodo:       LDC_PBLDCRVP
     Descripcion:  Procedimiento se encarga de ejecutar toda la logica del PB LDC_PBLDCRVP

     Autor:        Olsoftware/Miguel Ballesteros
     Fecha:        25/01/2021


     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
     02/08/21     DANVAL                      CA799_1: Se Modifica la consulta de los Cupones y se aplica proceso de validacion de los caracteres
     23/04/24     jpinedc                     OSF-2580: * Se usa el paquete pkg_gestionArchivos
                                              en lugar de utl_file
                                              * Se usa pkg_Correo en lugar de ldc_sendemail
                                                
     
    *******************************************************************************/
    nuTipoFecha 			number;
	dtFechaIniSoli 			date;
	dtFechaFinSoli 			date;
	nuCategoria 			number;
    fiArchivo               pkg_gestionArchivos.styArchivo;
	nuHilos                 NUMBER := 1;
    nuLogProceso            ge_log_process.log_process_id%TYPE;
    sbParametros            ge_process_schedule.parameters_%TYPE;
    nuparano                perifact.pefaano%type;
    nuparmes                perifact.pefames%type;
    nutsess                 NUMBER;
    sbparuser               VARCHAR2(50);
	contador 				NUMBER := 100;
	sbDIRECTORY_ID  		ge_boInstanceControl.stysbValue;
    sbNomArch         		VARCHAR2(200) := 'Reporte_LDC_PBLDCRVP_'||SEQ_LDC_PBLDCRVP.NEXTVAL;
    sbNomHoja         		VARCHAR2(2000) := 'Reporte_LDCRPV';
	SBPATHFILE      		GE_DIRECTORY.PATH%TYPE;

	-- se crea variable tipo record
	TYPE rcCureporte IS RECORD
    (
		Tipo_Paquete					varchar2(2000),
		Mercado_Relevante				varchar2(2000),
		Departamento					varchar2(2000),
		Nombre_Departamento				varchar2(2000),
		Localidad						varchar2(2000),
		Nombre_Localidad				varchar2(2000),
		Direccion_Instalacion			varchar2(2000),
		Manzana							varchar2(2000),
		Ciclo							varchar2(2000),
		Tipo_Predio_1					varchar2(2000),
		Zona							varchar2(2000),
		Uso_servicio					varchar2(2000),
		Categoria						varchar2(2000),
		Nombre_Categoria				varchar2(2000),
		Subcategoria					varchar2(2000),
		Nombre_Subcategoria				varchar2(2000),
		Barrio							varchar2(2000),
		Nombre_Barrio					varchar2(2000),
		Numero_Solicitud				varchar2(2000),
		Tipo_solicitud					varchar2(2000),
		Numero_Interaccion				varchar2(2000),
		Tipo_Formulario					varchar2(2000),
		Nombre_Tipo_Formulario			varchar2(2000),
		Numero_Formulario_Venta			varchar2(2000),
		Contrato						varchar2(2000),
		Numero_producto					varchar2(2000),
		Tipo_producto					varchar2(2000),
		Estado_producto					varchar2(2000),
		Fecha_elaboracion_venta			date,
		Fecha_digitacion_Venta			date,
		Fecha_Atencion					date,
		Estado_Solicitud				varchar2(2000),
		Nombre_Digitador				varchar2(2000),
		Contratista						varchar2(2000),
		Nombre_Contratista				varchar2(2000),
		Punto_Atencion					varchar2(2000),
		Nombre_Punto_Atencion			varchar2(2000),
		Asesor_Venta					varchar2(2000),
		Nombre_Asesor_Venta				varchar2(2000),
		Unidad_Trabajo					varchar2(2000),
		Nombre_Unidad_Trabajo			varchar2(2000),
		Observacion_Venta				clob,
		Tipo_Identificacion				varchar2(2000),
		Identificacion_Cliente			varchar2(2000),
		Nombre_Cliente					varchar2(2000),
		Tipo_Cliente					varchar2(2000),
		Descripcion_Tipo_Cliente		varchar2(2000),
		Solicitud_Cotizacion			varchar2(2000),
		Cotizacion						varchar2(2000),
		Empresa_Cliente					varchar2(2000),
		Cargo_Cliente					varchar2(2000),
		Correo							varchar2(2000),
		Numero_Personas_a_Cargo			varchar2(2000),
		Energetico_Anterior				varchar2(2000),
		Tipo_Vivienda					varchar2(2000),
		Telefono_Contacto				varchar2(2000),
		Tipo_Instalacion				varchar2(2000),
		Plan_Comercial					varchar2(2000),
		Nombre_Plan_Comercial			varchar2(2000),
		Promociones						varchar2(2000),
		Plan_Financiacion				varchar2(2000),
		Nombre_Plan_Financiacion		varchar2(2000),
		Valor_de_la_Venta				varchar2(2000),
		CARGO_CONEXION					varchar2(2000), --- no aparece en el reporte original
		RED_INTERNA						varchar2(2000),
		IVA_RED_INTERNA					varchar2(2000),
		VALOR_REVISION_PREVIA			varchar2(2000),
		IVA_REVISION_PREVIA				varchar2(2000),
		Valor_Descuento					varchar2(2000),
		Valor_Cuota_Inicial				varchar2(2000),
		Numero_Cuotas					varchar2(2000),
		Valor_a_Financiar				varchar2(2000),
		Medio_de_Pago					varchar2(2000),
		Cuota_Ini_Recaudada_Vendedor	varchar2(2000),
		Predio_Anillado					varchar2(2000),
		address_id						varchar2(2000),   --- no aparece en el reporte original
		Fecha_Anillado					date,
		Multivivienda					varchar2(2000),
		Codigo_Predio					varchar2(2000),
		Porcentaje_Penetracion			varchar2(2000),
		Tecnico_Ventas					varchar2(2000),
		Unidad_Certificadora			varchar2(2000),
		Unidad_Instaladora				varchar2(2000),
		tipo_predio						varchar2(2000),
		predio_inde						varchar2(2000),
		contrato_inde					varchar2(2000),
		medidor_inde					varchar2(2000),
		estado_ley						varchar2(2000),
		construccion					varchar2(2000),
		ApliSubsidio					varchar2(2000),
		TotSubsidio						varchar2(2000),
		ValBrutoVent					varchar2(2000),
		ValFinalVent					varchar2(2000),
		Cupon							varchar2(2000),
		Valor_cupon						varchar2(2000),
		Pagado							varchar2(2000),
		Fecha_Pago						date
    );


    --Tipo de tablas pl
    TYPE tytbCureporte IS TABLE OF rcCureporte INDEX  BY pls_integer;

	-- variable del tipo de tabla pl
    tbReporte   tytbCureporte;


	cursor cuCursor (	nuCategoria	number, TipoFecha number, Fecha_Inicial	date,  Fecha_Final date	)is

        SELECT utl_raw.cast_to_varchar2(nlssort(package_type_id||' - '||Upper(daps_package_type.fsbGetdescription(package_type_id)), 'nls_sort=binary_ai')) Tipo_Paquete,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fnuMercaRelevanLo(ma.GEOGRAP_LOCATION_ID)||' - '||LDC_PK_REP_VEN.fsbNombMercaRelevanLo(ma.GEOGRAP_LOCATION_ID), 'nls_sort=binary_ai'))Mercado_Relevante,

				LDC_PK_REP_VEN.fnuDepartamento(ma.GEOGRAP_LOCATION_ID) Departamento,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbNomDepartamento(ma.GEOGRAP_LOCATION_ID), 'nls_sort=binary_ai'))Nombre_Departamento,

				ma.GEOGRAP_LOCATION_ID Localidad,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbNomLocalidad(ma.GEOGRAP_LOCATION_ID), 'nls_sort=binary_ai'))Nombre_Localidad ,

				utl_raw.cast_to_varchar2(nlssort((select mma.address from ab_address mma where mma.address_id = pp.address_id), 'nls_sort=binary_ai'))Direccion_Instalacion,

				LDC_PK_REP_VEN.fsbManzana(pp.address_id) Manzana,

				LDC_PK_REP_VEN.fnuCiclo(pp.address_id) Ciclo,

				utl_raw.cast_to_varchar2(nlssort( (
													SELECT  premty.description
													FROM    ab_premise_type premty, ab_premise prem
													WHERE   prem.premise_type_id = premty.premise_type_id
													AND     prem.premise_id = abad.estate_number
													), 'nls_sort=binary_ai')) Tipo_Predio_1,


				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbZona(ma.parser_address_id), 'nls_sort=binary_ai'))Zona,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbUsoServicio(m.package_id), 'nls_sort=binary_ai'))Uso_servicio,

				LDC_PK_REP_VEN.fnuCate(pp.product_id) Categoria,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbNombreCate(pp.product_id), 'nls_sort=binary_ai')) Nombre_Categoria,

				LDC_PK_REP_VEN.fnuSubCate(pp.product_id) Subcategoria,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbSubCate(pp.product_id), 'nls_sort=binary_ai')) Nombre_Subcategoria,

				LDC_PK_REP_VEN.fnuBarrio(pp.address_id) Barrio,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbBarrio(pp.address_id), 'nls_sort=binary_ai')) Nombre_Barrio,

				m.package_id Numero_Solicitud,

				utl_raw.cast_to_varchar2(nlssort(m.package_type_id||' - '||daps_package_type.fsbgetdescription(m.package_type_id), 'nls_sort=binary_ai')) Tipo_solicitud,

				m.cust_care_reques_num Numero_Interaccion,

				m.DOCUMENT_TYPE_ID Tipo_Formulario,

				utl_raw.cast_to_varchar2(nlssort((select TICODESC from TIPOCOMP where TICOCODI = m.DOCUMENT_TYPE_ID and rownum <2), 'nls_sort=binary_ai')) Nombre_Tipo_Formulario,

				m.document_key Numero_Formulario_Venta,

				pp.subscription_id Contrato,

				pp.product_id Numero_producto,

				utl_raw.cast_to_varchar2(nlssort(pp.product_type_id ||' - '||(select serv.servdesc
																				 from SERVICIO serv
																				 where serv.servcodi = pp.product_type_id), 'nls_sort=binary_ai')) Tipo_producto,

				pp.product_status_id ||' - '||(select utl_raw.cast_to_varchar2(nlssort( pps.description, 'nls_sort=binary_ai'))
											   from PS_PRODUCT_STATUS pps
											   where pps.product_status_id = pp.product_status_id) Estado_producto,

				REQUEST_DATE Fecha_elaboracion_venta,

				MESSAG_DELIVERY_DATE Fecha_digitacion_Venta,

				m.ATTENTION_DATE Fecha_Atencion,

				utl_raw.cast_to_varchar2(nlssort(m.MOTIVE_STATUS_ID||' - '||daps_motive_status.fsbgetdescription(m.MOTIVE_STATUS_ID), 'nls_sort=binary_ai')) Estado_Solicitud,

				utl_raw.cast_to_varchar2(nlssort(m.USER_ID, 'nls_sort=binary_ai')) Nombre_Digitador,

				LDC_PK_REP_VEN.fnuContratista(m.POS_OPER_UNIT_ID) Contratista,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbContratista(m.POS_OPER_UNIT_ID), 'nls_sort=binary_ai')) Nombre_Contratista,

				m.sale_channel_id Punto_Atencion,

				utl_raw.cast_to_varchar2(nlssort(dage_organizat_area.fsbGetname_(m.sale_channel_id), 'nls_sort=binary_ai')) Nombre_Punto_Atencion,

				m.PERSON_ID Asesor_Venta,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbAsesor(m.PERSON_ID), 'nls_sort=binary_ai')) Nombre_Asesor_Venta,

				m.POS_OPER_UNIT_ID Unidad_Trabajo,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbUnidaTrabajo(m.POS_OPER_UNIT_ID), 'nls_sort=binary_ai')) Nombre_Unidad_Trabajo,

				utl_raw.cast_to_varchar2(nlssort(m.comment_, 'nls_sort=binary_ai')) Observacion_Venta,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbTipoIdentCliente(g.IDENT_TYPE_ID), 'nls_sort=binary_ai')) Tipo_Identificacion,

				g.identification Identificacion_Cliente,

				utl_raw.cast_to_varchar2(nlssort(g.subscriber_name||' '||g.subs_last_name, 'nls_sort=binary_ai')) Nombre_Cliente,

				g.subscriber_type_id Tipo_Cliente,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbTipoCliente(g.subscriber_type_id), 'nls_sort=binary_ai')) Descripcion_Tipo_Cliente,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fnuSolicituCoti(m.package_id), 'nls_sort=binary_ai')) Solicitud_Cotizacion,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fnuCotizacion(m.package_id) , 'nls_sort=binary_ai')) Cotizacion,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbEmpreCliente(m.subscriber_id), 'nls_sort=binary_ai')) Empresa_Cliente,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbCargoCliente(m.subscriber_id), 'nls_sort=binary_ai')) Cargo_Cliente,

				utl_raw.cast_to_varchar2(nlssort(g.e_mail, 'nls_sort=binary_ai')) Correo,

				(SELECT person_quantity FROM ge_subs_housing_data
				 WHERE  subscriber_id = m.subscriber_id AND rownum <2) Numero_Personas_a_Cargo, -- ge_subs_housing_data

				utl_raw.cast_to_varchar2(nlssort((SELECT old_operator FROM  ge_subs_general_data WHERE subscriber_id = m.subscriber_id), 'nls_sort=binary_ai')) Energetico_Anterior,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbTipoVivien(m.subscriber_id), 'nls_sort=binary_ai')) Tipo_Vivienda,

				ldc_reportesconsulta.fsbGetPhones(m.subscriber_id) Telefono_Contacto,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbTipoInstal(m.package_id), 'nls_sort=binary_ai')) Tipo_Instalacion,

				mo.commercial_plan_id Plan_Comercial,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbPlanComercial(mo.commercial_plan_id), 'nls_sort=binary_ai')) Nombre_Plan_Comercial,

				utl_raw.cast_to_varchar2(nlssort(LDC_ReportesConsulta.fsbGetPromotions(mo.motive_id), 'nls_sort=binary_ai')) Promociones,

				LDC_PK_REP_VEN.fnuPlanFinan(m.package_id) Plan_Financiacion,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbPlanFinan(m.package_id), 'nls_sort=binary_ai')) Nombre_Plan_Financiacion,

				nvl((SELECT SUM(cargos.cargvalo)
						FROM cargos
						WHERE cargos.cargdoso = 'PP-'||m.package_id
						  AND cargos.cargsign = 'DB'
						  AND cargos.cargtipr = 'A'), 0) Valor_de_la_Venta,

				NVL((SELECT SUM(DECODE(cargsign,'DB',cargvalo,'CR',-cargvalo))
					  FROM cargos
					 WHERE cargos.cargdoso = 'PP-'||m.package_id
					   AND cargos.cargsign = 'DB'
					   AND cargos.cargconc IN (19)
					   AND cargtipr = 'A'
					), 0) CARGO_CONEXION,

				NVL((SELECT SUM(DECODE(cargsign,'DB',cargvalo,'CR',-cargvalo))
					  FROM cargos
					 WHERE cargos.cargdoso = 'PP-'||m.package_id
					   AND cargos.cargsign = 'DB'
					   AND cargos.cargconc IN (30, 289, 318, 613)
					   AND cargtipr = 'A'
					), 0) RED_INTERNA,

				NVL((SELECT SUM(DECODE(cargsign,'DB',cargvalo,'CR',-cargvalo))
					  FROM cargos
					 WHERE cargos.cargdoso = 'PP-'||m.package_id
					   AND cargos.cargsign = 'DB'
					   AND cargos.cargconc IN (287)
					   AND cargtipr = 'A'
					), 0) IVA_RED_INTERNA,

				NVL((SELECT SUM(DECODE(cargsign,'DB',cargvalo,'CR',-cargvalo))
					  FROM cargos
					 WHERE cargos.cargdoso = 'PP-'||m.package_id
					   AND cargos.cargsign = 'DB'
					   AND cargos.cargconc IN (674)
					   AND cargtipr = 'A'
					), 0) VALOR_REVISION_PREVIA,

				NVL((SELECT SUM(DECODE(cargsign,'DB',cargvalo,'CR',-cargvalo))
					  FROM cargos
					 WHERE cargos.cargdoso = 'PP-'||m.package_id
					   AND cargos.cargsign = 'DB'
					   AND cargos.cargconc IN (137)
					   AND cargtipr = 'A'
					), 0) IVA_REVISION_PREVIA,

				CASE
			   WHEN (m.package_type_id = 271) THEN
			   nvl((SELECT sum(cargos.cargvalo)
				   FROM  cargos
				   WHERE cargos.cargdoso = 'PP-'||m.package_id
				   AND cargos.CARGCONC = dald_parameter.fsbgetvalue_chain('CONCEPT_DCTO_VENTAS')
				   AND cargos.CARGSIGN = 'CR'), 0)
				END Valor_Descuento,

				LDC_PK_REP_VEN.fnuValorCuoInic(m.package_id) Valor_Cuota_Inicial,

				LDC_PK_REP_VEN.fnuNumeCuotas(m.package_id) Numero_Cuotas,

				nvl((select t.value_to_finance
				 from Cc_Sales_Financ_Cond t
				 where t.package_id = m.package_id),0) Valor_a_Financiar,

				utl_raw.cast_to_varchar2(nlssort(LDC_PK_REP_VEN.fsbMedPagCuotIni(m.package_id)||' - '||LDC_PK_REP_VEN.FsbMedioPago(m.package_id), 'nls_sort=binary_ai')) Medio_de_Pago,

				LDC_PK_REP_VEN.fsbCuoIniRecVende(m.package_id) Cuota_Ini_Recaudada_Vendedor,

				LDC_PK_REP_VEN.fsbPredioAnillado(pp.address_id) Predio_Anillado,

				pp.address_id,

				( select i.DATE_RING
						from ab_address a,AB_PREMISE ap,ab_info_premise i
						where a.estate_number = ap.premise_id
						and i.premise_id = ap.premise_id
						and a.address_id = pp.address_id and rownum < 2)  Fecha_Anillado,

				LDC_PK_REP_VEN.fnuGetMultiHousing(ma.parser_address_id) Multivivienda,

				abad.estate_number Codigo_Predio,

				(SELECT  info.porc_penetracion
				 FROM    ldc_info_predio info
				 WHERE   info.premise_id = abad.estate_number
				 AND     rownum < 2) Porcentaje_Penetracion,

				utl_raw.cast_to_varchar2(nlssort(LDC_PKGETDAADVENTA.fsbGetTecnicoVentas(m.package_id), 'nls_sort=binary_ai')) Tecnico_Ventas,

				utl_raw.cast_to_varchar2(nlssort(LDC_PKGETDAADVENTA.fsbGetUnidadCertificadora(m.package_id), 'nls_sort=binary_ai')) Unidad_Certificadora,

				utl_raw.cast_to_varchar2(nlssort(LDC_PKGETDAADVENTA.fsbGetUnidadInst(m.package_id), 'nls_sort=binary_ai')) Unidad_Instaladora,

				LDC_PKGETDAADVENTA.FsbGETTIPOPREDIO(m.package_id) tipo_predio,

				LDC_PKGETDAADVENTA.FSBGETPREDIOINDEP(m.package_id)  predio_inde,

				LDC_PKGETDAADVENTA.FNUGETCONTRATO(m.package_id) contrato_inde,

				LDC_PKGETDAADVENTA.FSBGETELEMMEDI(m.package_id)  medidor_inde,

				utl_raw.cast_to_varchar2(nlssort(LDC_PKGETDAADVENTA.FSBGETESTADOLEY(m.package_id), 'nls_sort=binary_ai')) estado_ley,

				LDC_PKGETDAADVENTA.FSBGETPREDIOCONTR(m.package_id) construccion,

				(select ls.APLICASUBSIDIO
				 from ldc_subsidios ls
				 where ls.package_id = m.package_id) ApliSubsidio,	-- CASO 198

				(select ls.TOTALSUBSIDIO
				 from ldc_subsidios ls
				 where ls.package_id = m.package_id) TotSubsidio,  	-- CASO 198

				 (select ls.VALBRUTOVENTA
				 from ldc_subsidios ls
				 where ls.package_id = m.package_id) ValBrutoVent,	-- CASO 198

				(select ls.VALFINALVENTA
				 from ldc_subsidios ls
				 where ls.package_id = m.package_id) ValFinalVent,	-- CASO 198
                (select cuponume from cupon c where  c.cuposusc = pp.subscription_id and c.cupodocu = mo.package_id and c.cupotipo = 'DE' and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cuposusc = pp.subscription_id and c1.cupodocu = mo.package_id and c1.cupotipo = 'DE') and rownum = 1) Cupon,
                (select cupovalo from cupon c where  c.cuposusc = pp.subscription_id and c.cupodocu = mo.package_id and c.cupotipo = 'DE' and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cuposusc = pp.subscription_id and c1.cupodocu = mo.package_id and c1.cupotipo = 'DE') and rownum = 1) Valor_cupon,
                (select cupoflpa from cupon c where  c.cuposusc = pp.subscription_id and c.cupodocu = mo.package_id and c.cupotipo = 'DE' and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cuposusc = pp.subscription_id and c1.cupodocu = mo.package_id and c1.cupotipo = 'DE') and rownum = 1) Pagado,
                (select pg.pagofegr from pagos pg where pg.pagocupo = (select cuponume from cupon c where  c.cuposusc = pp.subscription_id and c.cupodocu = mo.package_id and c.cupotipo = 'DE' and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cuposusc = pp.subscription_id and c1.cupodocu = mo.package_id and c1.cupotipo = 'DE') and rownum = 1)) Fecha_Pago
		FROM    mo_packages m
		inner join mo_address ma on (m.package_id=ma.package_id)
		inner join MO_MOTIVE mo on ( m.package_id=mo.package_id)
		inner join pr_product pp on (mo.product_id=pp.product_id)
		inner join ab_address abad on (ma.parser_address_id = abad.address_id)
		inner join GE_SUBSCRIBER g on (m.subscriber_id=g.subscriber_id)

		WHERE   mo.product_type_id in (7014, 3)
		AND     ','||dald_parameter.fsbgetvalue_chain('TIPOS_PACK_ESTADVETA')||',' LIKE '%,'||package_type_id||',%'
        AND     mo.category_id = Decode(nuCategoria,-1,mo.category_id,nuCategoria) --mo.category_id in (Categoria)
        AND     mo.category_id <> -1
        AND     DECODE(TipoFecha, 1, m.MESSAG_DELIVERY_DATE, 2, (select pg.pagofegr from pagos pg where pg.pagocupo = (select cuponume from cupon c where  c.cuposusc = pp.subscription_id and c.cupodocu = mo.package_id and c.cupotipo = 'DE' and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cuposusc = pp.subscription_id and c1.cupodocu = mo.package_id and c1.cupotipo = 'DE') and rownum = 1)), 3, m.MESSAG_DELIVERY_DATE) between Fecha_Inicial AND Fecha_Final + 1
		AND     DECODE(TipoFecha, 3, (select count(1) from cupon c where  c.cuposusc = pp.subscription_id and c.cupodocu = mo.package_id and c.cupotipo = 'DE' and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cuposusc = pp.subscription_id and c1.cupodocu = mo.package_id and c1.cupotipo = 'DE') and rownum = 1), 2, DECODE((select cupoflpa from cupon c where  c.cuposusc = pp.subscription_id and c.cupodocu = mo.package_id and c.cupotipo = 'DE' and c.cupofech = (select max(c1.cupofech) from cupon c1 where c1.cuposusc = pp.subscription_id and c1.cupodocu = mo.package_id and c1.cupotipo = 'DE') and rownum = 1), 'S', 2), 1) =  DECODE(TipoFecha, 2, 2, 3, 0, 1);

	cursor cuGetNameColumns is
		select   decode(rownum, 1     ,     'Tipo_Paquete     ',
								2     ,     'Mercado_Relevante      ',
								3     ,     'Departamento     ',
								4     ,     'Nombre_Departamento    ',
								5     ,     'Localidad  ',
								6     ,     'Nombre_Localidad ',
								7     ,     'Direccion_Instalacion  ',
								8     ,     'Manzana    ',
								9     ,     'Ciclo      ',
								10    ,     'Tipo_Predio      ',
								11    ,     'Zona ',
								12    ,     'Uso_servicio     ',
								13    ,     'Categoria  ',
								14    ,     'Nombre_Categoria ',
								15    ,     'Subcategoria     ',
								16    ,     'Nombre_Subcategoria    ',
								17    ,     'Barrio     ',
								18    ,     'Nombre_Barrio    ',
								19    ,     'Numero_Solicitud ',
								20    ,     'Tipo_solicitud   ',
								21    ,     'Numero_Interaccion     ',
								22    ,     'Tipo_Formulario  ',
								23    ,     'Nombre_Tipo_Formulario ',
								24    ,     'Numero_Formulario_Venta      ',
								25    ,     'Contrato   ',
								26    ,     'Numero_producto  ',
								27    ,     'Tipo_producto    ',
								28    ,     'Estado_producto  ',
								29    ,     'Fecha_elaboracion_venta      ',
								30    ,     'Fecha_digitacion_Venta ',
								31    ,     'Fecha_Atencion   ',
								32    ,     'Estado_Solicitud ',
								33    ,     'Nombre_Digitador ',
								34    ,     'Contratista      ',
								35    ,     'Nombre_Contratista     ',
								36    ,     'Punto_Atencion   ',
								37    ,     'Nombre_Punto_Atencion  ',
								38    ,     'Asesor_Venta     ',
								39    ,     'Nombre_Asesor_Venta    ',
								40    ,     'Unidad_Trabajo   ',
								41    ,     'Nombre_Unidad_Trabajo  ',
								42    ,     'Observacion_Venta      ',
								43    ,     'Tipo_Identificacion    ',
								44    ,     'Identificacion_Cliente ',
								45    ,     'Nombre_Cliente   ',
								46    ,     'Tipo_Cliente     ',
								47    ,     'Descripcion_Tipo_Cliente     ',
								48    ,     'Solicitud_Cotizacion   ',
								49    ,     'Cotizacion ',
								50    ,     'Empresa_Cliente  ',
								51    ,     'Cargo_Cliente    ',
								52    ,     'Correo     ',
								53    ,     'Numero_Personas_a_Cargo      ',
								54    ,     'Energetico_Anterior    ',
								55    ,     'Tipo_Vivienda    ',
								56    ,     'Telefono_Contacto      ',
								57    ,     'Tipo_Instalacion ',
								58    ,     'Plan_Comercial   ',
								59    ,     'Nombre_Plan_Comercial  ',
								60    ,     'Promociones      ',
								61    ,     'Plan_Financiacion      ',
								62    ,     'Nombre_Plan_Financiacion     ',
								63    ,     'Valor_de_la_Venta      ',
								64    ,     'Valor_Descuento   ',
								65    ,     'Valor_Cuota_Inicial      ',
								66    ,     'Numero_Cuotas  ',
								67    ,     'Valor_a_Financiar  ',
								68    ,     'Medio_de_Pago    ',
								69    ,     'Cuota_Ini_Recaudada_Vendedor  ',
								70    ,     'Predio_Anillado    ',
								71    ,     'Fecha_Anillado    ',
								72    ,     'Multivivienda      ',
								73    ,     'Codigo_Predio    ',
								74    ,     'Porcentaje_Penetracion ',
								75    ,     'Cargo_Por_Conexion  ',
								76    ,     'Red_Interna ',
								77    ,     'Iva_Red_Interna   ',
								78    ,     'Valor_Revision_Previa    ',
								79    ,     'Iva_Revision_Previa    ',
								80    ,     'Tecnico_Ventas ',
								81    ,     'Unidad_Certificadora   ',
								82    ,     'Unidad_Instaladora   ',
								83    ,     'tipo_predio     ',
								84    ,     'predio_independizacion      ',
								85    ,     'contrato_indedizacion      ',
								86    ,     'numero_medidor_indendizacion    ',
								87    ,     'estado_ley_1581     ',
								88    ,     'Predio_Construccion ',
								89    ,     'Aplica_Subsidio     ',
								90    ,     'Total_Subsidio     ',
								91    ,     'Valor_Bruto_Venta      ',
								92    ,     'Valor_Final_Venta     ',
								93    ,     'Cupon     ',
								94    ,     'Valor_cupon      ',
								95    ,     'Pagado      ',
								96    ,     'Fecha_Grabacion_Pago     ') as NameColumn
				 from dual
				 connect by level <= 96;

    sbRemitente      ld_parameter.value_chain%TYPE:= DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_SENDER');

    nuError     NUMBER;
    sbError     VARCHAR2(4000);
    
 BEGIN

	ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);

	SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER
      INTO nuparano,nuparmes,nutsess,sbparuser
	FROM dual;

    ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PBLDCRVP','En ejecucion..',nutsess,sbparuser);

	sbParametros 			:= dage_process_schedule.fsbgetparameters_(inuProgramacion);

	nuTipoFecha        		:= TO_NUMBER(TRIM(ut_string.getparametervalue(sbParametros,'SPONSOR_ID','|','=')));
	dtFechaIniSoli        	:= TO_DATE(ut_string.getparametervalue(sbParametros,'REQUEST_DATE','|','='));
	dtFechaFinSoli        	:= TO_DATE(ut_string.getparametervalue(sbParametros,'MESSAG_DELIVERY_DATE','|','='));
	nuCategoria 			:= TO_NUMBER(TRIM(ut_string.getparametervalue(sbParametros,'CATECODI','|','=')));
	sbDIRECTORY_ID 			:= ut_string.getparametervalue(sbParametros, 'DIRECTORY_ID', '|', '=');

	SBPATHFILE 				:= DAGE_DIRECTORY.FSBGETPATH( sbDIRECTORY_ID );


	IF ( cucursor%isopen ) THEN
        CLOSE cucursor;
    END IF;

	IF ( cuGetNameColumns%isopen ) THEN
        CLOSE cuGetNameColumns;
    END IF;

    -- se crea el encabezado del documento en excel
    fiArchivo := pkg_gestionArchivos.ftAbrirArchivo_SMF(SBPATHFILE,sbNomArch|| '.xls','w');

    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<?xml version="1.0"?>');
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Workbook xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">');

    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Styles>');
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Style ss:ID="OracleDate">');
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:NumberFormat ss:Format="dd/mm/yyyy\ hh:mm:ss"/>');
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Style>');
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Styles>');

    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Worksheet ss:Name="'||sbNomHoja||'">');
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Table>');

    -- Aqui se realiza el proceso de poner el nombre a las columnas del excel--
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Row>');
    FOR col in cuGetNameColumns
    LOOP
      pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
      pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'||col.NameColumn||'</ss:Data>');
      pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');
    END LOOP;
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Row>');


    --Abrimos el cursor  para obtener los datos e ingresarlos en la tabla PL
    OPEN cucursor (nuCategoria,	nuTipoFecha, dtFechaIniSoli, dtFechaFinSoli);
    LOOP
        FETCH cucursor BULK COLLECT INTO tbreporte LIMIT contador;

			FOR i IN 1..tbreporte.count LOOP

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Row>');

				-- se establece los valores que contendra cada celda de acuerdo a cada columna

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_Paquete, '<|>', '-' )  ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Mercado_Relevante, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Departamento, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Departamento, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Localidad, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Localidad, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Direccion_Instalacion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Manzana, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Ciclo, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_Predio_1, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Zona, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Uso_servicio, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Categoria, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Categoria, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Subcategoria, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Subcategoria, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Barrio, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Barrio, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Numero_Solicitud, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_solicitud, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Numero_Interaccion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_Formulario, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Tipo_Formulario, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Numero_Formulario_Venta, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Contrato, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Numero_producto, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_producto, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Estado_producto, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Fecha_elaboracion_venta, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Fecha_digitacion_Venta, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Fecha_Atencion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Estado_Solicitud, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Digitador, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Contratista, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Contratista, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Punto_Atencion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Punto_Atencion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Asesor_Venta, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Asesor_Venta, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Unidad_Trabajo, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Unidad_Trabajo, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Observacion_Venta, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_Identificacion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Identificacion_Cliente, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Cliente, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_Cliente, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Descripcion_Tipo_Cliente, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Solicitud_Cotizacion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Cotizacion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Empresa_Cliente, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Cargo_Cliente, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Correo, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Numero_Personas_a_Cargo, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Energetico_Anterior, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_Vivienda, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Telefono_Contacto, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tipo_Instalacion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Plan_Comercial, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Plan_Comercial, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Promociones, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Plan_Financiacion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Nombre_Plan_Financiacion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Valor_de_la_Venta, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Valor_Descuento, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Valor_Cuota_Inicial, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Numero_Cuotas, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Valor_a_Financiar, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Medio_de_Pago, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Cuota_Ini_Recaudada_Vendedor, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Predio_Anillado, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Fecha_Anillado, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Multivivienda, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Codigo_Predio, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Porcentaje_Penetracion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).CARGO_CONEXION, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).RED_INTERNA, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).IVA_RED_INTERNA, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).VALOR_REVISION_PREVIA, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).IVA_REVISION_PREVIA, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');


				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Tecnico_Ventas, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Unidad_Certificadora, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Unidad_Instaladora, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).tipo_predio, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).predio_inde, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).contrato_inde, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).medidor_inde, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).estado_ley, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).construccion, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).ApliSubsidio, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).TotSubsidio, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).ValBrutoVent, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).ValFinalVent, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Cupon, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Valor_cupon, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Pagado, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Cell>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'<ss:Data ss:Type="String">'|| regexp_replace( tbreporte(i).Fecha_Pago, '<|>', '-' ) ||'</ss:Data>');
				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Cell>');

				pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Row>');

			END LOOP;

    EXIT WHEN cucursor%NOTFOUND;
    END LOOP;
    CLOSE cucursor;

    -- se define el final de cada hoja de acuerdo a la sentencia --
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Table>');
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Worksheet>');

    -- se finaliza la hoja de excel --
    pkg_gestionArchivos.prcEscribirLinea_SMF(fiArchivo,'</ss:Workbook>');

    -- se cierra el archivo
    pkg_gestionArchivos.prcCerrarArchivo_SMF(fiArchivo);

    --- se llama al proceso que hace el envio por correo electronico del mensaje que el proceso ya termino


    DECLARE

      --- cursor que valida el correo de la persona que esta conectada al sistema
    cursor cuValEmail is
        select e_mail correo
            from   ge_person
            where  person_id = ge_bopersonal.fnuGetPersonId
            and    e_mail is not null;


        sbEmail			ge_person.e_mail%type;

    BEGIN

        if(cuValEmail%isopen)then
            close cuValEmail;
        end if;

        open cuValEmail;
        fetch cuValEmail into sbEmail;
            if(cuValEmail%FOUND)then
            
                pkg_Correo.prcEnviaCorreo
                (
                    isbRemitente        => sbRemitente,
                    isbDestinatarios    => sbEmail,
                    isbAsunto           => 'Proceso LDC_PBLDCRVP Termino de forma Correcta',
                    isbMensaje          => 'El proceso LDC_PBLDCRVP termino de forma correcta, validar el reporte generado en el servidor en la ruta: '||SBPATHFILE
                );
            
        else
                ldc_proactualizaestaprog(nutsess,'Error','LDC_PBLDCRVP','Termino con Error no se encontro correo de la persona conectada');
            end if;
        close cuValEmail;



    EXCEPTION
        when pkg_Error.CONTROLLED_ERROR then
            pkg_Error.getError( nuError, sbError );
            ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
            ldc_proactualizaestaprog(nutsess,sbError,'LDC_PBLDCRVP','Termino con error.');
            pkg_error.setErrorMessage( isbMsgErrr => sbError );

        when others then
            pkg_Error.setError;
            pkg_Error.getError( nuError, sbError );
            ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
            ldc_proactualizaestaprog(nutsess,sbError,'LDC_PBLDCRVP','Termino con error.');
            pkg_error.setErrorMessage( isbMsgErrr => sbError );
            
    END;



	ldc_proactualizaestaprog(nutsess,'Ok','LDC_PBLDCRVP','ok');

    ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');


EXCEPTION
    when pkg_Error.CONTROLLED_ERROR then
        pkg_Error.getError( nuError, sbError );
        ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
        ldc_proactualizaestaprog(nutsess,sbError,'LDC_PBLDCRVP','Termino con error.');
        pkg_error.setErrorMessage( isbMsgErrr => sbError );

    when others then
        pkg_Error.setError;
        pkg_Error.getError( nuError, sbError );
        ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
        ldc_proactualizaestaprog(nutsess,sbError,'LDC_PBLDCRVP','Termino con error.');
        pkg_error.setErrorMessage( isbMsgErrr => sbError );

END LDC_PBLDCRVP;
/
