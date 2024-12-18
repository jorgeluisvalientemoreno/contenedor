CREATE OR REPLACE PACKAGE adm_person.ldc_pkgestionitems IS

	/*****************************************************************
    Unidad         : LDC_PKGESTIONITEMS
    Descripcion    : paquete que tiene la logica de la creacion de items y actividades
    Autor          : OLSOFTWARE
    Fecha          : 25/07/2020

    Historia de Modificaciones
    Fecha       Autor                       Modificación
    =========   =========                   ====================
    26/06/2024  Adrianavg                   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
    13-06-2024  jpinedc                     OSF-2604: * Se usa pkg_Correo
                                            * Se ajusta cadena en translate
                                            * LDC_CREATEITEM : Se quita translate
                                            * LDC_CREATEACTIVITY: Se quita translate 
    05-03-2024  ADRIANAVG                   OSF-2388: aplican pautas técnicas y se reemplazan servicios homólogos
                                            Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /*******************************************************************************
    Unidad     :   LDC_CREATEITEM
    Descripcion:   Procedimiento que se encarga de todo el proceso de creacion de los items
    *******************************************************************************/
    PROCEDURE LDC_CREATEITEM
    (
		nuCodExterno			IN  NUMBER,
		sbDescripcion			IN	VARCHAR2,
		nuClasificacion			IN	NUMBER,
		nuUnidMedida			IN	NUMBER,
		nuTipo					IN	NUMBER,
		nuConcepto				IN	NUMBER,
		nuConceptoDescuento		IN	NUMBER,
		sbRecuperable			IN	VARCHAR2,
		nuItemRecupe			IN	NUMBER,
		nuCostoUnitario			IN	NUMBER,
		nuGarantiaDias			IN	NUMBER,
		nuCategoria				IN	NUMBER,
		nuTipoElemento			IN	NUMBER,
		nuClaseElement			IN	NUMBER,
		nuAtributo				IN	NUMBER,
		sbTipoAprovisio			IN	VARCHAR2,
		sbCompartido			IN	VARCHAR2,
		sbPlataforma			IN	VARCHAR2,
		nuEstadoInicial			IN	NUMBER,
		UTLFileLogItem       	IN	pkg_gestionarchivos.styarchivo,
		nuLineCont				IN	NUMBER,
		nuCampAdiItemMater		IN	NUMBER
    );



	/*******************************************************************************
    Unidad     :   LDC_CREATXTLOG
    Descripcion:   Procedimiento que se encarga de crear el archivo plano con el
				   estado de los items procesados
    *******************************************************************************/
    FUNCTION LDC_CREATXTLOG
    (
        isbPathFile			IN  VARCHAR2,
		sbNombreArchivo		IN  VARCHAR2
    )
    RETURN pkg_gestionarchivos.styarchivo;


	/*******************************************************************************
    Unidad     :   LDC_LLENATXTLOG
    Descripcion:   Procedimiento que se encarga de llenar el archivo plano
    *******************************************************************************/
	PROCEDURE LDC_LLENATXTLOG
    (
        fiArchivo       IN	pkg_gestionarchivos.styarchivo,
		isbDato			IN  VARCHAR2
    );



	/**************************************************************
    Unidad      :  LDC_PRCINSERTITEMS
    Descripcion :  Procedimiento que se encarga de realizar el insert
				   en la tabla ge_items
    ***************************************************************/
	PROCEDURE LDC_PRCINSERTITEMS
    (

		INUITEMS_ID 					IN	GE_ITEMS.ITEMS_ID%TYPE,
		ISBDESCRIPTION					IN	GE_ITEMS.DESCRIPTION%TYPE,
		INUITEM_CLASSIF_ID				IN	GE_ITEMS.ITEM_CLASSIF_ID%TYPE,
		INUMEASURE_UNIT_ID				IN	GE_ITEMS.MEASURE_UNIT_ID%TYPE,
		INUTECH_CARD_ITEM_ID			IN	GE_ITEMS.TECH_CARD_ITEM_ID%TYPE,
		INUCONCEPT						IN	GE_ITEMS.CONCEPT%TYPE,
		INUOBJECT_ID					IN	GE_ITEMS.OBJECT_ID%TYPE,
		ISBUSE_							IN	GE_ITEMS.USE_%TYPE,
		INUELEMENT_TYPE_ID				IN	GE_ITEMS.ELEMENT_TYPE_ID%TYPE,
		INUELEMENT_CLASS_ID				IN	GE_ITEMS.ELEMENT_CLASS_ID%TYPE,
		ISBSTANDARD_TIME				IN	GE_ITEMS.STANDARD_TIME%TYPE,
		INUWARRANTY_DAYS				IN	GE_ITEMS.WARRANTY_DAYS%TYPE,
		INUDISCOUNT_CONCEPT				IN	GE_ITEMS.DISCOUNT_CONCEPT%TYPE,
		INUID_ITEMS_TIPO				IN	GE_ITEMS.ID_ITEMS_TIPO%TYPE,
		ISBOBSOLETO						IN	GE_ITEMS.OBSOLETO%TYPE,
		ISBPROVISIONING_TYPE			IN	GE_ITEMS.PROVISIONING_TYPE%TYPE,
		ISBPLATFORM						IN	GE_ITEMS.PLATFORM%TYPE,
		ISBRECOVERY						IN	GE_ITEMS.RECOVERY%TYPE,
		INURECOVERY_ITEM_ID				IN	GE_ITEMS.RECOVERY_ITEM_ID%TYPE,
		INUINIT_INV_STATUS_ID			IN	GE_ITEMS.INIT_INV_STATUS_ID%TYPE,
		ISBSHARED						IN	GE_ITEMS.SHARED%TYPE,
		ISBCODE							IN	GE_ITEMS.CODE%TYPE,
        UTLFileLogItem       	        IN	pkg_gestionarchivos.styarchivo,
        nuLineCont				        IN	NUMBER,
        nuError                         OUT NUMBER,
        sbMessage                       OUT VARCHAR2
    );



	/**************************************************************
    Unidad      :  LDC_PRCINSERTLISTACOSTO
    Descripcion :  Procedimiento que se encarga agregar la lista de costo
				   al item creado validando si el item es de material o no
				   porque de acuerdo a esto se obtendra la lista de costo
				   adecuada a relacionar al item
    ***************************************************************/
	PROCEDURE LDC_PRCINSERTLISTACOSTO
    (
		nuItemsId							IN   GE_UNIT_COST_ITE_LIS.ITEMS_ID%TYPE,
		nuCostoUnitario						IN   GE_UNIT_COST_ITE_LIS.PRICE%TYPE,
		nuClasificacion						IN	 GE_ITEMS.ITEM_CLASSIF_ID%TYPE
    );



	/**************************************************************
    Unidad      :  LDC_SENDFILEADJUNT
    Descripcion :  procedimiento que se encarga de buscar un archivo en el servidor y de enviarlo
                   como archivo adjunto por email
    ***************************************************************/
    PROCEDURE LDC_SENDFILEADJUNT
    (
		sbNombreArchivo       IN  	VARCHAR2,
		sbextsinpunto         IN  	VARCHAR2,
		sbEmail               IN  	VARCHAR2,
		sb_subject            IN  	VARCHAR2,
		sb_text_msg           IN  	VARCHAR2,
		nuDirectoryID         IN  	ge_directory.directory_id%type
    );



	/**************************************************************
    Unidad      :  LDC_CREATEACTIVITY
    Descripcion :  procedimiento que se encarga de crear las actividades
				   obteniendo los datos de un archivo plano
    ***************************************************************/
	PROCEDURE LDC_CREATEACTIVITY
	(
		nuObjeto				IN	NUMBER,
		sbDescripcion			IN  VARCHAR2,
		nuConcepto				IN	NUMBER,
		nuCostoUnitario			IN	NUMBER,
		sbUtilidad				IN	VARCHAR2,
		nuConceptoDescuento		IN	NUMBER,
		nuUnidMedida			IN	NUMBER,
		nuTimeExeMinuto			IN	NUMBER,
		nuActivtyCompens		IN	NUMBER,
		nuObjetoCompens			IN	NUMBER,
		nuCantLega				IN	NUMBER,
		nuGarantiaDias			IN	NUMBER,
		sbLegaMultiple			IN  VARCHAR2,
		sbObservNovedad			IN  VARCHAR2,
		sbItemNovedad			IN  VARCHAR2,
		nuSigno					IN	NUMBER,
		nuEstadoInicial			IN 	NUMBER,
		UTLFileLogItem       	IN	pkg_gestionarchivos.styarchivo,
		nuLineCont				IN	NUMBER
	);



	/**************************************************************
    Unidad      :  LDC_PRCINSERTACTIVIDAD
    Descripcion :  Procedimiento que se encarga de realizar el insert
				   en las tablas OR_ACTIVIDAD, GE_ITEMS_ATTRIBUTES y si
				   el item de novedad es igual a Y llenará la tabla
				   CT_ITEM_NOVELTY
    ***************************************************************/
	PROCEDURE LDC_PRCINSERTACTIVIDAD
    (

		NUID_ACTIVIDAD					IN   OR_ACTIVIDAD.ID_ACTIVIDAD%TYPE,
		NUACTIVID_COMPENSACION			IN   OR_ACTIVIDAD.ACTIVID_COMPENSACION%TYPE,
		NUOBJETO_COMPENSACION			IN   OR_ACTIVIDAD.OBJETO_COMPENSACION%TYPE,
		NUCANTIDAD_DEFECTO				IN   OR_ACTIVIDAD.CANTIDAD_DEFECTO%TYPE,
		SBLEGALIZA_MULTIPLE				IN   OR_ACTIVIDAD.LEGALIZA_MULTIPLE%TYPE,
		SBANULABLE						IN   OR_ACTIVIDAD.ANULABLE%TYPE,
		NUTIEMPO_VIDA					IN   OR_ACTIVIDAD.TIEMPO_VIDA%TYPE,
		SBPRIORIDAD_DESPACHO			IN   OR_ACTIVIDAD.PRIORIDAD_DESPACHO%TYPE,
		SBACTIVA						IN   OR_ACTIVIDAD.ACTIVA%TYPE,
		NUPRIORIDAD						IN   OR_ACTIVIDAD.PRIORIDAD%TYPE,
		SBITEMNOVEDAD					IN   VARCHAR2,
		NUSIGN							IN	 CT_ITEM_NOVELTY.LIQUIDATION_SIGN%TYPE,
		SBCOMMENT_						IN	 CT_ITEM_NOVELTY.COMMENT_%TYPE,
        UTLFileLogItem       	        IN	 pkg_gestionarchivos.styarchivo,
        nuLineCont				        IN	 NUMBER,
        nuError                         OUT  NUMBER,
        sbMessage                       OUT  VARCHAR2
    );


END LDC_PKGESTIONITEMS;
/

CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGESTIONITEMS IS
    /*****************************************************************
    Unidad         : LDC_PKGESTIONITEMS
    Descripcion    :
    Autor          : OLSOFTWARE
    Fecha          : 25/07/2020

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    08-03-2024  adrianavg                    OSF-2388: 
                                             Se declaran variables para la gestión de trazas
    ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
	PROCEDURE LDC_CREATEITEM   (nuCodExterno			IN  NUMBER,
								sbDescripcion			IN	VARCHAR2,
								nuClasificacion			IN	NUMBER,
								nuUnidMedida			IN	NUMBER,
								nuTipo					IN	NUMBER,
								nuConcepto				IN	NUMBER,
								nuConceptoDescuento		IN	NUMBER,
								sbRecuperable			IN	VARCHAR2,
								nuItemRecupe			IN	NUMBER,
								nuCostoUnitario			IN	NUMBER,
								nuGarantiaDias			IN	NUMBER,
								nuCategoria				IN	NUMBER,
								nuTipoElemento			IN	NUMBER,
								nuClaseElement			IN	NUMBER,
								nuAtributo				IN	NUMBER,
								sbTipoAprovisio			IN	VARCHAR2,
								sbCompartido			IN	VARCHAR2,
								sbPlataforma			IN	VARCHAR2,
								nuEstadoInicial			IN	NUMBER,
								UTLFileLogItem       	IN	pkg_gestionarchivos.styarchivo,
								nuLineCont				IN	NUMBER,
								nuCampAdiItemMater		IN	NUMBER) IS


	/*******************************************************************************
     método:       LDC_CREATEITEM
     Descripcion:  Procedimiento que se encarga de todo el proceso de creacion de los items
     Fecha:        25/07/2020

     Historia de Modificaciones
     FECHA        	AUTOR                       DESCRIPCION
	 25/07/2020		OLSOFTWARE					Creacion de procedimiento LDC_CREATEITEM
     08-03-2024     ADRIANAVG                   OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                                Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                                Se reemplaza ut_trace.trace por pkg_traza.trace
                                                Se ajusta cursor CUVALCONCEPTO para indicar parametro de entrada, dado que se usa para validar
                                                dos parametros de entrada pero en la lógica solo evalua el parametro nuConcepto
                                                Se reemplaza ex.controlled_error por pkg_error.controlled_error
                                                Se ajusta bloque de exception según pautas técnicas
     21-06-2024     jpinedc                     OSF-2604: Se quita translate                                                
    *******************************************************************************/
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			 CONSTANT VARCHAR2(100)      := csbNOMPKG||'ldc_createitem'; 

	nuValClasif				NUMBER;
	nuValUnitMed			NUMBER;
	nuValConcep				NUMBER;
	nuValConcepDiscount		NUMBER;
	nuValTypeElement		NUMBER;
	nuValClassElement		NUMBER;
	nuValAttributo			NUMBER;
	nuValItemRecup			NUMBER;
	nuValTipoAprov			NUMBER;
    nuValTipo   			NUMBER;
    nuValCategoria  		NUMBER;
    nuValDesc  				NUMBER;
    nuValItemMaterial  		NUMBER;
    nuError                 NUMBER;
    sbMessage               VARCHAR2(1000);
	sbMessageError			VARCHAR2(2000);

	blValidaError			BOOLEAN := TRUE;
	blValidaListCost		BOOLEAN := TRUE;
	secItemId				NUMBER := SEQ_GE_ITEMS_50000344.NEXTVAL; 

	CURSOR CUVALCLASSIF IS
		SELECT COUNT(1)
		FROM GE_ITEM_CLASSIF
		WHERE ITEM_CLASSIF_ID = NUCLASIFICACION;

	CURSOR CUVALUNITMEDIDA IS
		SELECT COUNT(1)
		FROM GE_MEASURE_UNIT
		WHERE MEASURE_UNIT_ID = NUUNIDMEDIDA;

	CURSOR CUVALCONCEPTO (P_CONCCODI CONCEPTO.CONCCODI%TYPE) IS
		SELECT COUNT(1)
		FROM CONCEPTO
		WHERE CONCCODI = P_CONCCODI;

	CURSOR CUVALTIPOELEMENTO IS
		SELECT COUNT(1)
		FROM IF_ELEMENT_TYPE
		WHERE ELEMENT_TYPE_ID = NUTIPOELEMENTO;

	CURSOR CUVALCLASSELEMENT IS
		SELECT COUNT(1)
		FROM IF_ELEMENT_CLASS
		WHERE CLASS_ID = NUCLASEELEMENT;

	CURSOR CUVALATRIBUTO IS
		SELECT COUNT(1)
		FROM GE_ATTRIBUTES
		WHERE ATTRIBUTE_TYPE_ID = 2
		AND   MODULE_ID = 4
		AND   ATTRIBUTE_CLASS_ID = 11
		AND   ATTRIBUTE_ID = NUATRIBUTO;

	CURSOR CUVALITEMRECUPE IS
		SELECT COUNT(1)
		FROM GE_ITEMS
		WHERE ITEM_CLASSIF_ID = 8
		AND MEASURE_UNIT_ID = 159
		AND ITEMS_ID = NUITEMRECUPE;

	CURSOR CUVALTIPO IS
		SELECT COUNT(1)
		FROM GE_ITEMS_TIPO
		WHERE ID_ITEMS_TIPO = NUTIPO;

	CURSOR CUVALTIPOAPROVIS IS
		SELECT COUNT(1)
		FROM(SELECT DECODE(ROWNUM, 1, 'N', 2, 'A', 3, 'M') AS CODIGO,
					DECODE(ROWNUM, 1, 'No aplica', 2, 'Automatico', 3, 'Manual') AS DESCRIPCION
			 FROM DUAL
			 CONNECT BY LEVEL <= 3)
		WHERE CODIGO = SBTIPOAPROVISIO;

	CURSOR CUVALCATEGORIA IS
		SELECT COUNT(1)
		FROM GE_ITEMS_GAMA
		WHERE ID_ITEMS_TIPO = NUTIPO
		AND   ID_ITEMS_GAMA = NUCATEGORIA;

	CURSOR CUVALITEMADICMATERIAL IS
		SELECT COUNT(1)
		FROM GE_ITEMS G
		WHERE G.ITEMS_ID = NUCAMPADIITEMMATER
		AND   G.ITEM_CLASSIF_ID IN(3,8,21);

	CURSOR CUVALDESCGEITEM IS
		SELECT SUM(VALUECONT) AS TOTAL FROM(
			SELECT COUNT(1) AS VALUECONT
			FROM GE_ITEMS G
			WHERE G.DESCRIPTION = SBDESCRIPCION
		);

	BEGIN

        pkg_traza.TRACE(csbmetodo, csbNivelTraza, csbinicio); 
        pkg_traza.TRACE(csbmetodo||' nuCodExterno: '||nuCodExterno||', sbDescripcion: ' ||sbDescripcion, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' nuClasificacion: '||nuClasificacion||', nuUnidMedida: ' ||nuUnidMedida, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' nuTipo: '||nuTipo||', nuConcepto: ' ||nuConcepto, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' nuConceptoDescuento: '||nuConceptoDescuento||', sbRecuperable: ' ||sbRecuperable, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' nuItemRecupe: '||nuItemRecupe||', nuCostoUnitario: ' ||nuCostoUnitario, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' nuGarantiaDias: '||nuGarantiaDias||', nuClaseElement: ' ||nuClaseElement, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' nuAtributo: '||nuAtributo||', sbTipoAprovisio: ' ||sbTipoAprovisio, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' sbCompartido: '||sbCompartido||', sbPlataforma: ' ||sbPlataforma, csbNivelTraza);
        pkg_traza.TRACE(csbmetodo||' nuEstadoInicial: '||nuEstadoInicial, csbNivelTraza);    
        pkg_traza.TRACE(csbmetodo||' nuLineCont: '||nuLineCont||', nuCampAdiItemMater: ' ||nuCampAdiItemMater, csbNivelTraza); 

		-- se valida que la clasificacion ingresada este dentro de la tabla de clasificacion --
		IF(cuvalclassif%isopen)THEN
			CLOSE cuvalclassif;
		END IF;

		OPEN cuvalclassif;
		FETCH cuvalclassif INTO nuvalclasif;
		CLOSE cuvalclassif;
        pkg_traza.TRACE(csbmetodo||' nuvalclasif: '||nuvalclasif, csbNivelTraza); 

		IF(nuvalclasif != 0)THEN
			-- se valida la unidad de medida --
			IF(cuvalunitmedida%isopen)THEN
				CLOSE cuvalunitmedida;
			END IF;
			OPEN cuvalunitmedida;
			FETCH cuvalunitmedida INTO nuvalunitmed;
			CLOSE cuvalunitmedida;
            pkg_traza.TRACE(csbmetodo||' nuvalunitmed: '||nuvalunitmed, csbNivelTraza); 

			IF(nuvalunitmed !=0) THEN

				-- si el concepto no es nulo se valida si existe--
				IF(nuconcepto IS NOT NULL)THEN                
					IF(cuvalconcepto%isopen)THEN
						CLOSE cuvalconcepto;
					END IF;

					OPEN cuvalconcepto(nuconcepto);
					FETCH cuvalconcepto INTO nuvalconcep;
					CLOSE cuvalconcepto;
                    pkg_traza.TRACE(csbmetodo||' nuvalconcep: '||nuvalconcep, csbNivelTraza); 

					IF(nuvalconcep = 0)THEN
						blvalidaerror := FALSE;
						sbmessageerror := 'El concepto del item ingresado no existe';
					END IF;
				END IF;

				-- si el concepto de descuento no es nulo se valida si existe--
				IF(nuconceptodescuento IS NOT NULL)THEN

					IF(cuvalconcepto%isopen)THEN
						CLOSE cuvalconcepto;
					END IF;

					OPEN cuvalconcepto(nuconceptodescuento);
					FETCH cuvalconcepto INTO nuvalconcepdiscount;
					CLOSE cuvalconcepto;
                    pkg_traza.TRACE(csbmetodo||' nuvalconcepdiscount: '||nuvalconcepdiscount, csbNivelTraza);

					IF(nuvalconcepdiscount = 0)THEN
						blvalidaerror := FALSE;
						sbmessageerror := sbmessageerror||', El concepto de descuento del item ingresado no existe';
					END IF;

				END IF; 

				IF(blvalidaerror)THEN

                    pkg_traza.TRACE(csbmetodo||' blvalidaerror is TRUE ', csbNivelTraza);

					-- se llama al cursor que valida si la descripcion con la que se quiere ingresar el item no exista en ge_items
					IF(cuvaldescgeitem%isopen)THEN
						CLOSE cuvaldescgeitem;
					END IF;

					OPEN cuvaldescgeitem;
					FETCH cuvaldescgeitem INTO nuvaldesc;
					CLOSE cuvaldescgeitem;
                    pkg_traza.TRACE(csbmetodo||' nuvaldesc: '||nuvaldesc, csbNivelTraza);

					-- si la descripcion no se encuentra en la tabla ge_items
					IF(nuvaldesc = 0)THEN 

						----------------------------------------------------------------------------------------
						--------------- CREACION DE ITEMS CLASIFICACION [1,3,23,50,51,52,903,904] --------------
						----------------------------------------------------------------------------------------

						-- de acuerdo a la clasificacion que se ingreso asi se validara cada uno de sus campos
						IF(nuclasificacion = 1  OR nuclasificacion = 3 OR nuclasificacion = 23 OR nuclasificacion = 50 OR
						   nuclasificacion = 51 OR nuclasificacion = 52 OR nuclasificacion = 903 OR nuclasificacion = 904)THEN
                            pkg_traza.TRACE(csbmetodo||'--------------- CREACION DE ITEMS CLASIFICACION [1,3,23,50,51,52,903,904] --------------', csbNivelTraza);

							IF(nuclasificacion = 51)THEN

								IF(nucampadiitemmater IS NOT NULL)THEN

									IF(cuvalitemadicmaterial%isopen)THEN
										CLOSE cuvalitemadicmaterial;
									END IF;

									OPEN cuvalitemadicmaterial;
									FETCH cuvalitemadicmaterial INTO nuvalitemmaterial;
									CLOSE cuvalitemadicmaterial;
                                    pkg_traza.TRACE(csbmetodo||' nuvalitemmaterial: '||nuvalitemmaterial, csbNivelTraza);

									IF(nuvalitemmaterial = 0)THEN
										blvalidaerror := FALSE;
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El item de material adicional para la clasificacion [51] no existe!!!');
									END IF;

								END IF;

							END IF;

							IF(blvalidaerror)THEN
                                pkg_traza.TRACE(csbmetodo||' blvalidaerror is TRUE ', csbNivelTraza);

								-- se llama al proceso que hace el registro del item
								ldc_prcinsertitems(	secitemid,
													sbdescripcion,
													nuclasificacion,
													nuunidmedida,
													NULL,
													nuconcepto,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													nuconceptodescuento,
													NULL,
													NULL,
													NULL,
													sbplataforma,
													NULL,
													NULL,
													nuestadoinicial,
													sbcompartido,
													nucodexterno,
													utlfilelogitem,
													nulinecont,
													nuerror,
													sbmessage
												);

								IF(nuerror = 0)THEN

									-- si el item se creo de forma correcta y el campo de item de material no es nulo
									IF(nucampadiitemmater IS NOT NULL)THEN

										-- se registrará¡ en la tabla LDC_HOMOITMAITAC una asociacion del campo nuCampAdiItemMater
										-- que seria el item de material y el item_id recien creado que se guardaria en esta tabla
										-- como item de actividad

										BEGIN

											INSERT INTO ldc_homoitmaitac( item_material, item_actividad)  VALUES ( nucampadiitemmater, secitemid);
                                            pkg_traza.TRACE(csbmetodo||' INSERT INTO ldc_homoitmaitac item_material: '||nucampadiitemmater, csbNivelTraza);

										EXCEPTION
											WHEN pkg_error.controlled_error THEN
												nuerror    := SQLCODE;
												sbmessage  := sqlerrm;
                                                pkg_traza.trace(csbMetodo ||' ERROR EN INSERT INTO ldc_homoitmaitac, sbmessage: ' || sbmessage, csbNivelTraza);
											WHEN OTHERS THEN
												nuerror    := SQLCODE;
												sbmessage  := sqlerrm;
                                                pkg_traza.trace(csbMetodo ||' ERROR EN INSERT INTO ldc_homoitmaitac, sbmessage: ' || sbmessage, csbNivelTraza);
										END;


										IF(nuerror = 0)THEN
											ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
											COMMIT;
										ELSE
											ROLLBACK;
											blvalidalistcost := FALSE;
											ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
										END IF;


									ELSE
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
										COMMIT;
									END IF;

								ELSE
									ROLLBACK;
									blvalidalistcost := FALSE;
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
								END IF;


								--- se llama al proceso que se encarga de crear la lista de costo para los items creados
								IF(blvalidalistcost)THEN
									ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
								END IF;


							END IF;

                            pkg_traza.TRACE(csbmetodo||'--------------- FIN CREACION DE ITEMS CLASIFICACION [1,3,23,50,51,52,903,904] --------------', csbNivelTraza);
                        END IF; 

                        ----------------------------------------------------------------------------------------
						----------------------- CREACION DE ITEMS CLASIFICACION [4,5] --------------------------
						----------------------------------------------------------------------------------------

						IF(nuclasificacion = 4 OR nuclasificacion = 5)THEN
                            pkg_traza.TRACE(csbmetodo||'----------------------- CREACION DE ITEMS CLASIFICACION [4,5] --------------------------', csbNivelTraza);
							-- se valida el tipo de elemento --
							IF(cuvaltipoelemento%isopen)THEN
								CLOSE cuvaltipoelemento;
							END IF;

							OPEN cuvaltipoelemento;
							FETCH cuvaltipoelemento INTO nuvaltypeelement;
							CLOSE cuvaltipoelemento;
                            pkg_traza.TRACE(csbmetodo||' nuvaltypeelement: '||nuvaltypeelement, csbNivelTraza);

							IF(nuvaltypeelement != 0)THEN

								-- se valida la clase de elemento --
								IF(nuclaseelement IS NOT NULL)THEN

									IF(cuvalclasselement%isopen)THEN
										CLOSE cuvalclasselement;
									END IF;

									OPEN cuvalclasselement;
									FETCH cuvalclasselement INTO nuvalclasselement;
									CLOSE cuvalclasselement;
                                    pkg_traza.TRACE(csbmetodo||' nuvalclasselement: '||nuvalclasselement, csbNivelTraza);

									IF(nuvalclasselement = 0)THEN
										blvalidaerror := FALSE;
										sbmessageerror := 'La clase de elemento del item ingresado no existe';
									END IF;

								END IF;

								-- se valida el atributo --
								IF(nuatributo IS NOT NULL)THEN

									IF(cuvalatributo%isopen)THEN
										CLOSE cuvalatributo;
									END IF;

									OPEN cuvalatributo;
									FETCH cuvalatributo INTO nuvalattributo;
									CLOSE cuvalatributo;
                                    pkg_traza.TRACE(csbmetodo||' nuvalattributo: '||nuvalattributo, csbNivelTraza);

									IF(nuvalattributo = 0)THEN
										blvalidaerror := FALSE;
										sbmessageerror := sbmessageerror||', El valor del atributo ingresado no existe';
									END IF;

								END IF;


								-- si no se presentó ningun error --

								IF(blvalidaerror)THEN

                                    pkg_traza.TRACE(csbmetodo||' blvalidaerror is TRUE ', csbNivelTraza);

                                    -- SE CREA EL ITEM - 
									ldc_prcinsertitems(	secitemid,
														sbdescripcion,
														nuclasificacion,
														nuunidmedida,
														NULL,
														nuconcepto,
														NULL,
														NULL,
														nutipoelemento,
														nuclaseelement,
														NULL,
														nugarantiadias,
														nuconceptodescuento,
														NULL,
														NULL,
														NULL,
														sbplataforma,
														NULL,
														NULL,
														nuestadoinicial,
														sbcompartido,
														nucodexterno,
														utlfilelogitem,
														nulinecont,
														nuerror,
														sbmessage
													);

									IF(nuerror = 0)THEN 
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
										COMMIT;
									ELSE
										ROLLBACK;
										blvalidalistcost := FALSE;
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
									END IF;


									--- se llama al proceso que se encarga de crear la lista de costo para los items creados
									IF(blvalidalistcost)THEN
										ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
									END IF;

								ELSE
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = '||sbmessageerror);
								END IF;

							ELSE
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El tipo de elemento del item ingresado no existe!!!');
							END IF;

                            pkg_traza.TRACE(csbmetodo||'----------------------- FIN CREACION DE ITEMS CLASIFICACION [4,5] --------------------------', csbNivelTraza);
                        END IF;


						----------------------------------------------------------------------------------------
						----------------------- CREACION DE ITEMS CLASIFICACION [7] ----------------------------
						----------------------------------------------------------------------------------------

						IF(nuclasificacion = 7)THEN

                            pkg_traza.TRACE(csbmetodo||'----------------------- CREACION DE ITEMS CLASIFICACION [7]  --------------------------', csbNivelTraza);

							ldc_prcinsertitems(	secitemid,
												sbdescripcion,
												nuclasificacion,
												nuunidmedida,
												NULL,
												nuconcepto,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												nuconceptodescuento,
												NULL,
												NULL,
												NULL,
												sbplataforma,
												NULL,
												NULL,
												nuestadoinicial,
												sbcompartido,
												nucodexterno,
												utlfilelogitem,
												nulinecont,
												nuerror,
												sbmessage
											);

							IF(nuerror = 0)THEN
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
								COMMIT;
							ELSE
								ROLLBACK;
								blvalidalistcost := FALSE;
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
							END IF;

							--- se llama al proceso que se encarga de crear la lista de costo para los items creados
							IF(blvalidalistcost)THEN
								ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
							END IF;

                            pkg_traza.TRACE(csbmetodo||'----------------------- FIN CREACION DE ITEMS CLASIFICACION [7]  --------------------------', csbNivelTraza);
                        END IF;

						----------------------------------------------------------------------------------------
						----------------------- CREACION DE ITEMS CLASIFICACION [8,9] --------------------------
						----------------------------------------------------------------------------------------

						IF(nuclasificacion = 8 OR nuclasificacion = 9)THEN

							pkg_traza.TRACE(csbmetodo||'----------------------- CREACION DE ITEMS CLASIFICACION [8,9]  --------------------------', csbNivelTraza);
                            IF(nuitemrecupe IS NOT NULL)THEN

								IF(sbrecuperable = 'Y')THEN

									-- se valida el item de recuperacion exista --
									IF(cuvalitemrecupe%isopen)THEN
										CLOSE cuvalitemrecupe;
									END IF;

									OPEN cuvalitemrecupe;
									FETCH cuvalitemrecupe INTO nuvalitemrecup;
									CLOSE cuvalitemrecupe;
                                    pkg_traza.TRACE(csbmetodo||' nuvalitemrecup: '||nuvalitemrecup, csbNivelTraza);

									IF(nuvalitemrecup = 0)THEN
										blvalidaerror := FALSE;
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El item de recuperacion ingresado no existe!!!');
									END IF;

								ELSE
									blvalidaerror := FALSE;
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El campo recuperable debe estar en Y para que enviar el item de recuperacion!!!');
								END IF;

							END IF;

							IF(blvalidaerror)THEN

								-- se llama al proceso que crea el item --
								ldc_prcinsertitems(	secitemid,
													sbdescripcion,
													nuclasificacion,
													nuunidmedida,
													NULL,
													nuconcepto,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													nuconceptodescuento,
													NULL,
													NULL,
													NULL,
													sbplataforma,
													sbrecuperable,
													nuitemrecupe,
													nuestadoinicial,
													sbcompartido,
													nucodexterno,
													utlfilelogitem,
													nulinecont,
													nuerror,
													sbmessage
												);


								IF(nuerror = 0)THEN
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
									COMMIT;
								ELSE
									ROLLBACK;
									blvalidalistcost := FALSE;
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
								END IF;

								--- se llama al proceso que se encarga de crear la lista de costo para los items creados
								IF(blvalidalistcost)THEN
									ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
								END IF;

							END IF;

                            pkg_traza.TRACE(csbmetodo||'----------------------- FIN CREACION DE ITEMS CLASIFICACION [8,9]  --------------------------', csbNivelTraza);
                        END IF;

						----------------------------------------------------------------------------------------
						----------------------- CREACION DE ITEMS CLASIFICACION [6,10,11] ----------------------
						----------------------------------------------------------------------------------------

						IF(nuclasificacion = 6 OR nuclasificacion = 10 OR nuclasificacion = 11)THEN
                            pkg_traza.TRACE(csbmetodo||'----------------------- CREACION DE ITEMS CLASIFICACION [6,10,11]  --------------------------', csbNivelTraza);

							-- se valida el tipo de elemento --
							IF(cuvaltipoelemento%isopen)THEN
								CLOSE cuvaltipoelemento;
							END IF;

							OPEN cuvaltipoelemento;
							FETCH cuvaltipoelemento INTO nuvaltypeelement;
							CLOSE cuvaltipoelemento;

							IF(nuvaltypeelement != 0)THEN

								-- se valida la clase de elemento --
								IF(nuclaseelement IS NOT NULL)THEN

									IF(cuvalclasselement%isopen)THEN
										CLOSE cuvalclasselement;
									END IF;

									OPEN cuvalclasselement;
									FETCH cuvalclasselement INTO nuvalclasselement;
									CLOSE cuvalclasselement;
                                     pkg_traza.TRACE(csbmetodo||' nuvalclasselement: ' ||nuvalclasselement, csbNivelTraza);

									IF(nuvalclasselement = 0)THEN
										blvalidaerror := FALSE;
										sbmessageerror := 'La clase de elemento del item ingresado no existe';
									END IF;

								END IF;

								-- se valida el atributo --
								IF(nuatributo IS NOT NULL)THEN

									IF(cuvalatributo%isopen)THEN
										CLOSE cuvalatributo;
									END IF;

									OPEN cuvalatributo;
									FETCH cuvalatributo INTO nuvalattributo;
									CLOSE cuvalatributo;
                                    pkg_traza.TRACE(csbmetodo||' nuvalattributo: ' ||nuvalattributo, csbNivelTraza);

									IF(nuvalattributo = 0)THEN
										blvalidaerror := FALSE;
										sbmessageerror := sbmessageerror||', El valor del atributo ingresado no existe';
									END IF;
								END IF;


								IF(blvalidaerror)THEN

									-- SE LLAMA AL PROCESO QUE CREARÁ EL ITEM --
									ldc_prcinsertitems(	secitemid,
														sbdescripcion,
														nuclasificacion,
														nuunidmedida,
														NULL,
														nuconcepto,
														NULL,
														NULL,
														nutipoelemento,
														nuclaseelement,
														NULL,
														nugarantiadias,
														nuconceptodescuento,
														NULL,
														NULL,
														NULL,
														sbplataforma,
														NULL,
														NULL,
														nuestadoinicial,
														sbcompartido,
														nucodexterno,
														utlfilelogitem,
														nulinecont,
														nuerror,
														sbmessage
													);

									IF(nuerror = 0)THEN 
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
										COMMIT;
									ELSE
										ROLLBACK;
										blvalidalistcost := FALSE;
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
									END IF;

									--- se llama al proceso que se encarga de crear la lista de costo para los items creados
									IF(blvalidalistcost)THEN
										ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
									END IF;

								ELSE
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = '||sbmessageerror);
								END IF;

							ELSE
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El tipo de elemento del item ingresado no existe!!!');
							END IF;

                            pkg_traza.TRACE(csbmetodo||'----------------------- FIN CREACION DE ITEMS CLASIFICACION [6,10,11]  --------------------------', csbNivelTraza);
                        END IF;

						----------------------------------------------------------------------------------------
						----------------------- CREACION DE ITEMS CLASIFICACION [13] ---------------------------
						----------------------------------------------------------------------------------------

						IF(nuclasificacion = 13)THEN
                            pkg_traza.TRACE(csbmetodo||'----------------------- CREACION DE ITEMS CLASIFICACION [13]  --------------------------', csbNivelTraza);
							IF(cuvaltipo%isopen)THEN
								CLOSE cuvaltipo;
							END IF;

							OPEN cuvaltipo;
							FETCH cuvaltipo INTO nuvaltipo;
							CLOSE cuvaltipo;

							IF(nuvaltipo != 0)THEN

								IF(cuvaltipoaprovis%isopen)THEN
									CLOSE cuvaltipoaprovis;
								END IF;

								OPEN cuvaltipoaprovis;
								FETCH cuvaltipoaprovis INTO nuvaltipoaprov;
								CLOSE cuvaltipoaprovis;
                                pkg_traza.TRACE(csbmetodo||' nuvaltipoaprov: ' ||nuvaltipoaprov, csbNivelTraza);

								IF(nuvaltipoaprov != 0)THEN

									ldc_prcinsertitems(	secitemid,
														sbdescripcion,
														nuclasificacion,
														nuunidmedida,
														NULL,
														nuconcepto,
														NULL,
														NULL,
														NULL,
														NULL,
														NULL,
														nugarantiadias,
														nuconceptodescuento,
														nutipo,
														NULL,
														sbtipoaprovisio,
														sbplataforma,
														NULL,
														NULL,
														nuestadoinicial,
														sbcompartido,
														nucodexterno,
														utlfilelogitem,
														nulinecont,
														nuerror,
														sbmessage
													);

									IF(nuerror = 0)THEN
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
										COMMIT;
									ELSE
										ROLLBACK;
										blvalidalistcost := FALSE;
										ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
									END IF;

									--- se llama al proceso que se encarga de crear la lista de costo para los items creados
									IF(blvalidalistcost)THEN
										ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
									END IF;

								ELSE
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El tipo de aprovisionamiento ingresado no existe!!!');
								END IF;

							ELSE
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El tipo de item ingresado no existe!!!');
							END IF;

                            pkg_traza.TRACE(csbmetodo||'----------------------- FIN CREACION DE ITEMS CLASIFICACION [13]  --------------------------', csbNivelTraza);
                        END IF;

						----------------------------------------------------------------------------------------
						----------------------- CREACION DE ITEMS CLASIFICACION [20] ---------------------------
						----------------------------------------------------------------------------------------

						IF(nuclasificacion = 20)THEN
                            pkg_traza.TRACE(csbmetodo||'----------------------- CREACION DE ITEMS CLASIFICACION [20] ---------------------------' ||nuvaltipoaprov, csbNivelTraza);
							ldc_prcinsertitems(	secitemid,
												sbdescripcion,
												nuclasificacion,
												nuunidmedida,
												NULL,
												nuconcepto,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												nuconceptodescuento,
												NULL,
												NULL,
												NULL,
												sbplataforma,
												NULL,
												NULL,
												nuestadoinicial,
												sbcompartido,
												nucodexterno,
												utlfilelogitem,
												nulinecont,
												nuerror,
												sbmessage
											);

							IF(nuerror = 0)THEN
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
								COMMIT;
							ELSE
								ROLLBACK;
								blvalidalistcost := FALSE;
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
							END IF;

							--- se llama al proceso que se encarga de crear la lista de costo para los items creados
							IF(blvalidalistcost)THEN
								ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
							END IF;

                            pkg_traza.TRACE(csbmetodo||'----------------------- FIN CREACION DE ITEMS CLASIFICACION [20] ---------------------------' ||nuvaltipoaprov, csbNivelTraza);
                        END IF;

						----------------------------------------------------------------------------------------
						----------------------- CREACION DE ITEMS CLASIFICACION [21] ---------------------------
						----------------------------------------------------------------------------------------

						IF(nuclasificacion = 21)THEN
                            pkg_traza.TRACE(csbmetodo||'----------------------- CREACION DE ITEMS CLASIFICACION [21] ---------------------------' ||nuvaltipoaprov, csbNivelTraza);

							-- se valida el tipo de item --
							IF(cuvaltipo%isopen)THEN
								CLOSE cuvaltipo;
							END IF;

							OPEN cuvaltipo;
							FETCH cuvaltipo INTO nuvaltipo;
							CLOSE cuvaltipo;
                            pkg_traza.TRACE(csbmetodo||' nuvaltipo: ' ||nuvaltipo, csbNivelTraza);

							IF(nuvaltipo != 0)THEN

								-- se valida el tipo de aprovisionamiento --
								IF(cuvaltipoaprovis%isopen)THEN
									CLOSE cuvaltipoaprovis;
								END IF;

								OPEN cuvaltipoaprovis;
								FETCH cuvaltipoaprovis INTO nuvaltipoaprov;
								CLOSE cuvaltipoaprovis;
                                pkg_traza.TRACE(csbmetodo||' nuvaltipoaprov: ' ||nuvaltipoaprov, csbNivelTraza);

								IF(nuvaltipoaprov != 0)THEN

									IF(nuitemrecupe IS NOT NULL)THEN

										IF(sbrecuperable = 'Y')THEN

											-- se valida el item de recuperacion exista --
											IF(cuvalitemrecupe%isopen)THEN
												CLOSE cuvalitemrecupe;
											END IF;

											OPEN cuvalitemrecupe;
											FETCH cuvalitemrecupe INTO nuvalitemrecup;
											CLOSE cuvalitemrecupe;
                                            pkg_traza.TRACE(csbmetodo||' nuvalitemrecup: ' ||nuvalitemrecup, csbNivelTraza);

											IF(nuvalitemrecup = 0)THEN
												blvalidaerror := FALSE;
												ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El item de recuperacion ingresado no existe!!!');
											END IF;

										ELSE
											blvalidaerror := FALSE;
											ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El campo recuperable debe estar en Y para que enviar el item de recuperacion!!!');
										END IF;

									END IF;


									-- se valida la categoria
									IF(nucategoria IS NOT NULL)THEN

										IF(cuvalcategoria%isopen)THEN
											CLOSE cuvalcategoria;
										END IF;

										OPEN cuvalcategoria;
										FETCH cuvalcategoria INTO nuvalcategoria;
										CLOSE cuvalcategoria;
                                        pkg_traza.TRACE(csbmetodo||' nuvalcategoria: ' ||nuvalcategoria, csbNivelTraza);

										IF(nuvalcategoria = 0)THEN
											blvalidaerror := FALSE;
											ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = La categoria ingresada no existe!!!');
										END IF;

									END IF;


									IF(blvalidaerror)THEN

										-- se llama al proceso que crea el item --
										ldc_prcinsertitems(	secitemid,
															sbdescripcion,
															nuclasificacion,
															nuunidmedida,
															NULL,
															nuconcepto,
															NULL,
															NULL,
															NULL,
															NULL,
															NULL,
															nugarantiadias,
															nuconceptodescuento,
															nutipo,
															NULL,
															sbtipoaprovisio,
															sbplataforma,
															sbrecuperable,
															nuitemrecupe,
															nuestadoinicial,
															sbcompartido,
															nucodexterno,
															utlfilelogitem,
															nulinecont,
															nuerror,
															sbmessage
														);

										IF(nuerror = 0)THEN

											IF(nucategoria IS NOT NULL)THEN

												BEGIN

													INSERT INTO ge_items_gama_item(items_id, id_items_gama_item, id_items_gama)
                                                           VALUES  ( secitemid, seq_ge_items_gama_item.NEXTVAL, nucategoria );
                                                    pkg_traza.TRACE(csbmetodo||' INSERT INTO GE_ITEMS_GAMA_ITEM, items_id: ' ||secitemid, csbNivelTraza);

												EXCEPTION
													WHEN pkg_error.controlled_error THEN
														nuerror    := SQLCODE;
														sbmessage  := sqlerrm;
                                                        pkg_traza.TRACE(csbmetodo||' sbmessage: ' ||sbmessage, csbNivelTraza);
													WHEN OTHERS THEN
														nuerror    := SQLCODE;
														sbmessage  := sqlerrm;
                                                        pkg_traza.TRACE(csbmetodo||' sbmessage: ' ||sbmessage, csbNivelTraza);
												END;

												IF(nuerror = 0)THEN
													ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
													COMMIT;
												ELSE
													ROLLBACK;
													blvalidalistcost := FALSE;
													ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
												END IF;

											ELSE
												ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo el item ['||secitemid||'] - ['||sbdescripcion||']');
												COMMIT;
											END IF;

										ELSE
											ROLLBACK;
											blvalidalistcost := FALSE;
											ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(nuerror)||' -- '|| sbmessage);
										END IF;

										--- se llama al proceso que se encarga de crear la lista de costo para los items creados
										IF(blvalidalistcost)THEN
											ldc_prcinsertlistacosto (secitemid,	nucostounitario, nuclasificacion);
										END IF;

									END IF;

								ELSE
									ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El tipo de aprovisionamiento ingresado no existe!!!');
								END IF;

							ELSE
								ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = El campo del tipo de item ingresado no existe!!!');
							END IF;

                            pkg_traza.TRACE(csbmetodo||'----------------------- FIN CREACION DE ITEMS CLASIFICACION [21] ---------------------------' ||nuvaltipoaprov, csbNivelTraza);
                        END IF;

					ELSE
						ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = No se puede crear el item porque la descripcion se encuentra registrada en la tabla GE_ITEMS!!!');
					END IF;

				ELSE
					ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = '||sbmessageerror);
				END IF; -- fin if(blValidaError)

			ELSE
				ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = La unidad de medida del item ingresado no existe!!!');
			END IF;

		ELSE
			ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = La clasificacion del item ingresado no existe!!!');
		END IF;


	pkg_traza.TRACE(csbmetodo, csbNivelTraza, pkg_traza.csbFIN); 

	EXCEPTION
		WHEN pkg_error.controlled_error THEN
            ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(SQLCODE)||' -- '|| sqlerrm);
            pkg_Error.getError(nuerror, sbmessage);
            pkg_traza.trace(csbMetodo ||' sbmessage: ' || sbmessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
		WHEN OTHERS THEN
			ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(SQLCODE)||' -- '|| sqlerrm);
            pkg_Error.setError;
            pkg_Error.getError(nuerror, sbmessage);
            pkg_traza.trace(csbMetodo ||' sbmessage: ' || sbmessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
	END LDC_CREATEITEM;

	/**************************************************************
    Unidad      :  LDC_CREATXTLOG
    Descripcion :  Procedimiento que se encarga de crear el archivo plano con el
				   estado de los items procesados

    Parametros  :  isbPathFile   --Ruta del archivo a crear

    Autor         : OLSOFTWARE SAS
    Fecha         : 26/07/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ==================== 
    08-03-2024     ADRIANAVG            OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                        Se declaran variables para la gestión de error
                                        Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                        Se reemplaza utl_file.fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                        Se ajusta bloque de exception según pautas técnica
    ***************************************************************/ 
    FUNCTION LDC_CREATXTLOG
    (
        isbPathFile			IN  VARCHAR2,
		sbNombreArchivo		IN  VARCHAR2
    )
    RETURN pkg_gestionarchivos.styarchivo
	IS    
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			 CONSTANT VARCHAR2(100)      := csbNOMPKG||'ldc_creatxtlog'; 
    --Se declaran variables para la gestión de error
    Onuerrorcode         NUMBER                      := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);

    fiArchivo          pkg_gestionarchivos.styarchivo;

    BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace(csbMetodo||' isbPathFile: '|| isbPathFile, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbNombreArchivo: '|| sbNombreArchivo, csbNivelTraza);

        -- se crea el archivo plano en el servidor --
        fiArchivo := pkg_gestionarchivos.ftabrirarchivo_smf(isbPathFile, sbNombreArchivo , 'W');

        pkg_traza.trace(csbMetodo||' fiArchivo ID: '|| fiArchivo.id, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' fiArchivo DATATYPE: '|| fiArchivo.datatype, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RETURN fiArchivo;

    EXCEPTION
        WHEN pkg_Error.controlled_error THEN
            pkg_error.geterror(onuerrorcode, osberrormessage);
            pkg_traza.TRACE(csbmetodo ||' osberrormessage: ' || osberrormessage, csbniveltraza);
            pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin_erc);
            RAISE pkg_error.controlled_error; 
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuerrorcode, osberrormessage);
            pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.controlled_error;
    END LDC_CREATXTLOG; 


	/**************************************************************
    Unidad      :  LDC_LLENATXTLOG
    Descripcion :  Procedimiento que se encarga de llenar el archivo plano creado

    Parametros  :  isbDato   --dato a llenar en el archivo plano

    Autor         : OLSOFTWARE SAS
    Fecha         : 26/07/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    08-03-2024     ADRIANAVG            OSF-2388: Se declara variable para el nombre del método en la gestión de trazas
                                        Se declaran variables para la gestión de error
                                        Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                        Se reemplaza utl_file.put_line por pkg_gestionarchivos.prcescribirlinea_smf
                                        Se declara variable vfiArchivo ya que el parámetro FIARCHIVO no puede ser usado para asignación de valor
                                        Se ajusta bloque de exception según pautas técnica    
    ***************************************************************/
    PROCEDURE LDC_LLENATXTLOG
    (
        fiArchivo       IN	pkg_gestionarchivos.styarchivo,
		isbDato			IN  VARCHAR2
    )
    IS
    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			 CONSTANT VARCHAR2(100)      := csbNOMPKG||'ldc_llenatxtlog'; 
    --Se declaran variables para la gestión de error
    Onuerrorcode         NUMBER                      := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    vfiArchivo           pkg_gestionarchivos.styarchivo; 
    BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace(csbMetodo||' fiArchivo id: '|| fiArchivo.id, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' fiArchivo datatype: '|| fiArchivo.datatype, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' isbDato: '|| isbDato, csbNivelTraza);

        -- se llena el archivo plano con datos --
        vfiArchivo:= fiArchivo;
		pkg_gestionarchivos.prcescribirlinea_smf(vfiArchivo, isbDato); 
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
            WHEN pkg_Error.CONTROLLED_ERROR THEN
                pkg_Error.getError(onuerrorcode, osberrormessage);
                pkg_traza.TRACE(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
                pkg_traza.TRACE(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(onuerrorcode, osberrormessage);
                pkg_traza.TRACE(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
                pkg_traza.TRACE(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                RAISE pkg_Error.Controlled_Error;  
    END LDC_LLENATXTLOG; 

	/**************************************************************
    Unidad      :  LDC_PRCINSERTITEMS
    Descripcion :  Procedimiento que se encarga de realizar el insert
				   en la tabla ge_items

    Autor         : OLSOFTWARE SAS
    Fecha         : 28/07/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    08-03-2024   ADRIANAVG              OSF-2388: Se declara variable para el nombre del método y nivel de traza en la gestión de trazas 
                                        Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                        Se reemplaza reinicio de variables de error por pkg_error.prInicializaError
                                        Se ajusta bloque de exception según pautas técnica
    ***************************************************************/
	PROCEDURE LDC_PRCINSERTITEMS
    (

		INUITEMS_ID 					IN	GE_ITEMS.ITEMS_ID%TYPE,
		ISBDESCRIPTION					IN	GE_ITEMS.DESCRIPTION%TYPE,
		INUITEM_CLASSIF_ID				IN	GE_ITEMS.ITEM_CLASSIF_ID%TYPE,
		INUMEASURE_UNIT_ID				IN	GE_ITEMS.MEASURE_UNIT_ID%TYPE,
		INUTECH_CARD_ITEM_ID			IN	GE_ITEMS.TECH_CARD_ITEM_ID%TYPE,
		INUCONCEPT						IN	GE_ITEMS.CONCEPT%TYPE,
		INUOBJECT_ID					IN	GE_ITEMS.OBJECT_ID%TYPE,
		ISBUSE_							IN	GE_ITEMS.USE_%TYPE,
		INUELEMENT_TYPE_ID				IN	GE_ITEMS.ELEMENT_TYPE_ID%TYPE,
		INUELEMENT_CLASS_ID				IN	GE_ITEMS.ELEMENT_CLASS_ID%TYPE,
		ISBSTANDARD_TIME				IN	GE_ITEMS.STANDARD_TIME%TYPE,
		INUWARRANTY_DAYS				IN	GE_ITEMS.WARRANTY_DAYS%TYPE,
		INUDISCOUNT_CONCEPT				IN	GE_ITEMS.DISCOUNT_CONCEPT%TYPE,
		INUID_ITEMS_TIPO				IN	GE_ITEMS.ID_ITEMS_TIPO%TYPE,
		ISBOBSOLETO						IN	GE_ITEMS.OBSOLETO%TYPE,
		ISBPROVISIONING_TYPE			IN	GE_ITEMS.PROVISIONING_TYPE%TYPE,
		ISBPLATFORM						IN	GE_ITEMS.PLATFORM%TYPE,
		ISBRECOVERY						IN	GE_ITEMS.RECOVERY%TYPE,
		INURECOVERY_ITEM_ID				IN	GE_ITEMS.RECOVERY_ITEM_ID%TYPE,
		INUINIT_INV_STATUS_ID			IN	GE_ITEMS.INIT_INV_STATUS_ID%TYPE,
		ISBSHARED						IN	GE_ITEMS.SHARED%TYPE,
		ISBCODE							IN	GE_ITEMS.CODE%TYPE,
        UTLFileLogItem       	        IN	pkg_gestionarchivos.styarchivo,
        nuLineCont				        IN	NUMBER,
        nuError                         OUT NUMBER,
        sbMessage                       OUT VARCHAR2
    )
    IS
        --Se declara variable para el nombre del método en la gestión de trazas
        csbMetodo  			    CONSTANT VARCHAR2(100)   := csbNOMPKG||'ldc_prcinsertitems';

		TiempoStandar  			NUMBER;
		DiasGarantia			NUMBER;
		nuUnidadMedida			NUMBER;
		isbCodeExterno			GE_ITEMS.CODE%TYPE;

    BEGIN

		pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_error.prInicializaError(nuError, sbMessage); 
        pkg_traza.trace(csbmetodo||' INUITEMS_ID: '|| inuitems_id||', ISBDESCRIPTION: '||isbdescription, csbniveltraza);
        pkg_traza.trace(csbmetodo||' INUITEM_CLASSIF_ID: '|| inuitem_classif_id||', INUMEASURE_UNIT_ID: '||inumeasure_unit_id, csbniveltraza);
        pkg_traza.trace(csbmetodo||' INUTECH_CARD_ITEM_ID: '|| inutech_card_item_id||', INUCONCEPT: '||inuconcept, csbniveltraza);
        pkg_traza.trace(csbmetodo||' INUOBJECT_ID: '|| inuobject_id||', ISBUSE_: '||isbuse_, csbniveltraza);
        pkg_traza.trace(csbmetodo||' INUELEMENT_TYPE_ID: '|| inuelement_type_id||', INUELEMENT_CLASS_ID: '||inuelement_class_id, csbniveltraza);
        pkg_traza.trace(csbmetodo||' ISBSTANDARD_TIME: '|| isbstandard_time||', INUWARRANTY_DAYS: '||inuwarranty_days, csbniveltraza);
        pkg_traza.trace(csbmetodo||' INUDISCOUNT_CONCEPT: '|| inudiscount_concept||', INUID_ITEMS_TIPO: '||inuid_items_tipo, csbniveltraza);
        pkg_traza.trace(csbmetodo||' ISBOBSOLETO: '|| isbobsoleto||', ISBPROVISIONING_TYPE: '||isbprovisioning_type, csbniveltraza);
        pkg_traza.trace(csbmetodo||' INURECOVERY_ITEM_ID: '|| inurecovery_item_id||', INUINIT_INV_STATUS_ID: '||inuinit_inv_status_id, csbniveltraza);
        pkg_traza.trace(csbmetodo||' ISBSHARED: '|| isbshared||', ISBCODE: '||isbcode, csbniveltraza);
        pkg_traza.trace(csbmetodo||', nuLineCont: '||nulinecont, csbniveltraza); 

        BEGIN

            IF(isbstandard_time IS NULL)THEN
				tiempostandar := 0;
			ELSE
				tiempostandar := isbstandard_time;
			END IF;
            pkg_traza.trace(csbMetodo||' tiempostandar: '|| tiempostandar, csbNivelTraza);

			IF(inuwarranty_days IS NULL)THEN
				diasgarantia  := 0;
			ELSE
				diasgarantia  := inuwarranty_days;
			END IF;
            pkg_traza.trace(csbMetodo||' diasgarantia: '|| diasgarantia, csbNivelTraza);

			-- se cambia el codigo externo ingresado en el txt por el codigo del item generado --
			isbCodeExterno := inuitems_id;

            INSERT INTO GE_ITEMS (  ITEMS_ID,
                                    DESCRIPTION,
                                    ITEM_CLASSIF_ID,
                                    MEASURE_UNIT_ID,
                                    TECH_CARD_ITEM_ID,
                                    CONCEPT,
                                    OBJECT_ID,
                                    USE_,
                                    ELEMENT_TYPE_ID,
                                    ELEMENT_CLASS_ID,
                                    STANDARD_TIME,
                                    WARRANTY_DAYS,
                                    DISCOUNT_CONCEPT,
                                    ID_ITEMS_TIPO,
                                    OBSOLETO,
                                    PROVISIONING_TYPE,
                                    PLATFORM,
                                    RECOVERY,
                                    RECOVERY_ITEM_ID,
                                    INIT_INV_STATUS_ID,
                                    SHARED,
                                    CODE 
                                 )
                          VALUES
                                 ( 
                                    INUITEMS_ID,
                                    ISBDESCRIPTION,
                                    INUITEM_CLASSIF_ID,
                                    INUMEASURE_UNIT_ID,
                                    INUTECH_CARD_ITEM_ID,
                                    INUCONCEPT,
                                    INUOBJECT_ID,
                                    ISBUSE_,
                                    INUELEMENT_TYPE_ID,
                                    INUELEMENT_CLASS_ID,
                                    TiempoStandar,
                                    DiasGarantia,
                                    INUDISCOUNT_CONCEPT,
                                    INUID_ITEMS_TIPO,
                                    ISBOBSOLETO,
                                    ISBPROVISIONING_TYPE,
                                    ISBPLATFORM,
                                    ISBRECOVERY,
                                    INURECOVERY_ITEM_ID,
                                    INUINIT_INV_STATUS_ID,
                                    ISBSHARED,
                                    isbCodeExterno 
                                 );
                pkg_traza.trace(csbMetodo||' INSERT INTO GE_ITEMS ITEMS_ID: '|| inuitems_id, csbNivelTraza);

        EXCEPTION
            WHEN pkg_error.controlled_error THEN
                nuerror    := SQLCODE;
                sbmessage  := sqlerrm;
                pkg_error.seterror; 
                pkg_traza.TRACE(csbmetodo ||' sbMessage: ' || sbmessage, csbNivelTraza); 
            WHEN OTHERS THEN
                nuerror    := SQLCODE;
                sbmessage  := sqlerrm;
                pkg_error.seterror; 
                pkg_traza.TRACE(csbmetodo ||' sbMessage: ' || sbmessage, csbNivelTraza);
        end;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

     EXCEPTION
        WHEN pkg_error.controlled_error THEN
            ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(SQLCODE)||' -- '|| sqlerrm);
            pkg_error.geterror(nuerror, sbmessage);
            pkg_traza.TRACE(csbmetodo ||' sbMessage: ' || sbmessage, csbNivelTraza);
            pkg_traza.TRACE(csbmetodo, csbNivelTraza, pkg_traza.csbfin_erc);
        WHEN OTHERS THEN
            ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(SQLCODE)||' -- '|| sqlerrm);
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sbmessage);
            pkg_traza.TRACE(csbmetodo ||' sbMessage: ' || sbmessage, csbNivelTraza);
            pkg_traza.TRACE(csbmetodo, csbNivelTraza, pkg_traza.csbfin_err);
    END LDC_PRCINSERTITEMS; 

	/**************************************************************
    Unidad      :  LDC_PRCINSERTLISTACOSTO
    Descripcion :  Procedimiento que se encarga agregar la lista de costo
				   al item creado validando si el item es de material o no
				   porque de acuerdo a esto se obtendra la lista de costo
				   adecuada a relacionar al item

    Autor         : OLSOFTWARE SAS
    Fecha         : 28/07/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    08-03-2024   ADRIANAVG              OSF-2388: Se declara variable para el nombre del método
                                        Se declaran variables para la gestión de error
                                        Se reemplaza reinicio de variables de error por pkg_error.prInicializaError
                                        Se reemplaza SELECT-INTO por cursor cuTerminal y cuUserId 
                                        Se ajusta bloque de exception según pautas técnica
    ***************************************************************/
	PROCEDURE LDC_PRCINSERTLISTACOSTO
    (
		nuItemsId							IN   GE_UNIT_COST_ITE_LIS.ITEMS_ID%TYPE,
		nuCostoUnitario						IN   GE_UNIT_COST_ITE_LIS.PRICE%TYPE,
		nuClasificacion						IN	 GE_ITEMS.ITEM_CLASSIF_ID%TYPE
    )
    IS
        --Se declara variable para el nombre del método en la gestión de trazas
        csbMetodo  			    CONSTANT VARCHAR2(100)   := csbNOMPKG||'ldc_prcinsertlistacosto'; 
        Onuerrorcode            NUMBER                   := pkg_error.CNUGENERIC_MESSAGE;
		Osberrormessage         VARCHAR2(2000);

		sbTerminal  			VARCHAR2(100);
		sbUserId				VARCHAR2(100);
		nuCostPrecio			NUMBER;
		nuValListCost			NUMBER;

		-- cursor que trae la lista de costo de items que sea de tipo material
        CURSOR cuGetListaCostMaterial is
        SELECT /*+ index_join(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST01 PK_GE_LIST_UNITARY_COST)*/
               GL.LIST_UNITARY_COST_ID ListaCosto
         FROM GE_LIST_UNITARY_COST GL
        WHERE GL.OPERATING_UNIT_ID IS NULL
          AND GL.CONTRACT_ID IS NULL
          AND GL.CONTRACTOR_ID IS NULL
          AND GL.GEOGRAP_LOCATION_ID IS NULL
          AND SYSDATE BETWEEN TRUNC(VALIDITY_START_DATE) AND TRUNC(VALIDITY_FINAL_DATE)
          AND GL.DESCRIPTION LIKE '%MATERIAL%';


        -- cursor que trae la lista de costo de items que sea de tipo material
        CURSOR cuGetListaCostNOMater is
        SELECT /*+ index_join(ge_list_unitary_cost IDX_GE_LIST_UNITARY_COST01 PK_GE_LIST_UNITARY_COST)*/
               GL.LIST_UNITARY_COST_ID ListaCosto
         FROM GE_LIST_UNITARY_COST GL
        WHERE GL.OPERATING_UNIT_ID IS NULL
          AND GL.CONTRACT_ID IS NULL
          AND GL.CONTRACTOR_ID IS NULL
          AND GL.GEOGRAP_LOCATION_ID IS NULL
          AND SYSDATE BETWEEN TRUNC(VALIDITY_START_DATE) AND TRUNC(VALIDITY_FINAL_DATE)
          AND GL.DESCRIPTION NOT LIKE '%MATERIAL%';

        CURSOR cuTerminal
        IS
		SELECT MACHINE
		  FROM V$SESSION H
		 WHERE H.AUDSID = USERENV('SESSIONID')
		   AND H.USERNAME = USER;        

        CURSOR cuUserId
        IS
		SELECT USER FROM dual;        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio); 
        pkg_error.prInicializaError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo||' nuItemsId: '|| nuItemsId||', nuCostoUnitario: '||nuCostoUnitario, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuClasificacion: '|| nuClasificacion, csbNivelTraza);

		OPEN cuTerminal;
        FETCH cuTerminal INTO sbTerminal;
        CLOSE cuTerminal;
        pkg_traza.trace(csbMetodo||' sbTerminal: '|| sbTerminal, csbNivelTraza);

        OPEN cuUserId;
        FETCH cuUserId INTO sbUserId;
        CLOSE cuUserId;
        pkg_traza.trace(csbMetodo||' sbUserId: '|| sbUserId, csbNivelTraza);

		IF(nucostounitario IS NULL)THEN
			nucostprecio := 0;
		ELSE
			nucostprecio := nucostounitario;
		END IF;

		-- se valida si el item es de material o no
		IF(NUCLASIFICACION = 3 OR NUCLASIFICACION = 8 OR NUCLASIFICACION = 21
		   OR NUCLASIFICACION = 2)THEN
            pkg_traza.trace(csbMetodo||' NUCLASIFICACION ES [3/8/21/2] ', csbNivelTraza);
			-- se llama al cursor que obtiene la lista de costos para item de material
			IF(CUGETLISTACOSTMATERIAL%ISOPEN)THEN
				CLOSE CUGETLISTACOSTMATERIAL;
			END IF;

			OPEN cuGetListaCostMaterial;
			LOOP
				FETCH cuGetListaCostMaterial INTO nuValListCost;
				EXIT WHEN cuGetListaCostMaterial%NOTFOUND;
					pkg_traza.trace(csbMetodo||' nuValListCost: '|| nuValListCost, csbNivelTraza);

					INSERT INTO GE_UNIT_COST_ITE_LIS (
															ITEMS_ID,
															LAST_UPDATE_DATE,
															LIST_UNITARY_COST_ID,
															PRICE,
															SALES_VALUE,
															TERMINAL,
															USER_ID
														 )
												  VALUES
														 (
															nuItemsId,
															SYSDATE,
															nuValListCost,
															nuCostPrecio,
															NULL,
															sbTerminal,
															sbUserId
														);
                    pkg_traza.trace(csbMetodo||' INSERT INTO GE_UNIT_COST_ITE_LIS: ITEMS_ID '|| nuItemsId, csbNivelTraza);
			END LOOP;
			CLOSE cuGetListaCostMaterial;

		ELSE
            pkg_traza.trace(csbMetodo||' NUCLASIFICACION ES !=[3/8/21/2] ', csbNivelTraza);
			-- se llama al cursor de items que NO son de material
			OPEN cuGetListaCostNOMater;
			LOOP
				FETCH cuGetListaCostNOMater INTO nuValListCost;
				EXIT WHEN cuGetListaCostNOMater%NOTFOUND;
					pkg_traza.trace(csbMetodo||' nuValListCost: '|| nuValListCost, csbNivelTraza);

					INSERT INTO GE_UNIT_COST_ITE_LIS (
															ITEMS_ID,
															LAST_UPDATE_DATE,
															LIST_UNITARY_COST_ID,
															PRICE,
															SALES_VALUE,
															TERMINAL,
															USER_ID
														 )
												  VALUES
														 (
															nuItemsId,
															SYSDATE,
															nuValListCost,
															nuCostPrecio,
															NULL,
															sbTerminal,
															sbUserId
														);
                    pkg_traza.trace(csbMetodo||' INSERT INTO GE_UNIT_COST_ITE_LIS: ITEMS_ID '|| nuItemsId, csbNivelTraza);
			END LOOP;
			CLOSE cuGetListaCostNOMater;

		END IF;

		COMMIT;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_Error.controlled_error THEN
			pkg_Error.getError(onuerrorcode, osberrormessage);
            pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.controlled_error;
		WHEN OTHERS THEN
			pkg_Error.setError;
            pkg_Error.getError(onuerrorcode, osberrormessage);
            pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.controlled_error;

    END LDC_PRCINSERTLISTACOSTO; 

	/**************************************************************
    Unidad      :  LDC_SENDFILEADJUNT
    Descripcion :  procedimiento que se encarga de buscar un archivo en el servidor y de enviarlo
                   como archivo adjunto por email

    Autor         : OLSOFTWARE SAS
    Fecha         : 29/07/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    13-06-2024  jpinedc                 OSF-2604: * Se usa pkg_Correo    
    08-03-2024   ADRIANAVG              OSF-2388: Se declara variable para el nombre del método
                                        Se declaran variables para la gestión de error
                                        Se reemplaza SELECT-INTO por cursor cuDirecAlias
                                        Se retira código comentariado
                                        Se retira esquema OPEN antepuesto a DALD_PARAMETER
                                        Se reemplaza ldc_boutilities.splitstrings por REGEXP_SUBSTR
                                        Se reemplaza ge_boerrors.seterrorcodeargument por pkg_erorr.seterrormessage, se retira
                                        el raise posterior al ge_boerrors, ya que el pkg_erorr.seterrormessage lo hace en su lógica interna 
                                        Se reemplaza dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
                                        Se ajusta bloque de exception según pautas técnica    
    ***************************************************************/
    PROCEDURE LDC_SENDFILEADJUNT
    (
		sbNombreArchivo       IN  VARCHAR2,
		sbextsinpunto         IN  VARCHAR2,
		sbEmail               IN  VARCHAR2,
		sb_subject            IN  VARCHAR2,
		sb_text_msg           IN  VARCHAR2,
		nuDirectoryID         IN  ge_directory.directory_id%type
    )
    IS
        --Se declara variable para el nombre del método en la gestión de trazas
        csbMetodo  			 CONSTANT VARCHAR2(100)   := csbNOMPKG||'ldc_sendfileadjunt'; 
        Onuerrorcode         NUMBER                   := pkg_error.cnugeneric_message;
		Osberrormessage      VARCHAR2(2000);

		blfile           BFILE;
		nuarchexiste     NUMBER; -- valida si creo algun archivo en el disco
		nutam_archivo    NUMBER; -- tamano del archivo a enviar
		adjunto          Blob;   -- file type del archivo final a enviar
		direcAlias       VARCHAR2(255);  -- se consulta directorio del archivo

		p_from          VARCHAR2(200)   :=  pkg_bcld_parameter.fsbobtienevalorcadena('LDC_SMTP_SENDER'); -- aqui dede ir el correo del remitente
		sbfromdisplay   VARCHAR2(4000)  := 'Open SmartFlex';

        CURSOR cuDirecAlias
        IS
        SELECT ALIAS INTO direcalias FROM ge_directory WHERE directory_id = nudirectoryid;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio); 
        pkg_error.prInicializaError(onuerrorcode, osberrormessage);        
        pkg_traza.trace(csbMetodo||' sbNombreArchivo: '|| sbNombreArchivo||', sbEmail: '||sbEmail, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sb_subject: '|| sb_subject||', sb_text_msg: '||sb_text_msg, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbextsinpunto: '|| sbextsinpunto||', nuDirectoryID: '||nuDirectoryID, csbNivelTraza);

        -- si el archivo es un txt
        OPEN cuDirecAlias;
        FETCH cuDirecAlias INTO direcAlias;
        CLOSE cuDirecAlias; 
        pkg_traza.trace(csbMetodo||' direcAlias: '|| direcAlias, csbNivelTraza);

        if(direcAlias is not null)then

            /* BLOQUE QUE SE ENCARGA DE BUSCAR EL ARCHIVO EN EL SERVIDOR*/
			blfile       := bfilename(direcAlias, sbNombreArchivo || '.' || sbextsinpunto); 
            nuarchexiste := dbms_lob.fileexists(blfile);  -- se valida si existe archivo
            pkg_traza.trace(csbMetodo||'se valida si existe archivo, nuarchexiste: '|| nuarchexiste, csbNivelTraza);

			dbms_lob.open(blfile, dbms_lob.file_readonly);
			nutam_archivo := dbms_lob.getlength(blfile);
            pkg_traza.trace(csbMetodo||' nutam_archivo: '|| nutam_archivo, csbNivelTraza);

			dbms_lob.createtemporary(adjunto, TRUE);
			dbms_lob.loadfromfile(adjunto, blfile, nutam_archivo);
			dbms_lob.close(blfile);
			----------------------------------------------------------

			-- si existe archivo se procede a enviar correo 
			IF (nutam_archivo >= 1) THEN

					IF(sbemail IS NOT NULL)THEN

						/* se crea un bloque anonimo para poder declarar un cursor dentro del begin del procedimiento para guardar los emails */
						DECLARE
						  CURSOR cuEmails IS 
                            SELECT (regexp_substr(SBEMAIL, '[^|]+',  1,  LEVEL)) AS column_value
                            FROM dual
                            CONNECT BY regexp_substr(SBEMAIL, '[^|]+' , 1, LEVEL) IS NOT NULL;

						BEGIN

							FOR sbCorreo IN cuEmails
							  LOOP
							  							    
							        pkg_Correo.prcEnviaCorreo
							        (
							            isbRemitente        => p_from,
							            isbDestinatarios    => sbCorreo.column_value,
							            isbAsunto           => sb_subject,
							            isbMensaje          => sb_text_msg,
							            isbArchivos         => direcAlias || '/'||sbNombreArchivo || '.' || sbextsinpunto,
							            isbDescRemitente    => sbfromdisplay
							        );							  

                                    pkg_traza.trace(csbMetodo||' sbCorreo: '|| sbCorreo.column_value, csbNivelTraza);
								 EXIT WHEN cuEmails%NOTFOUND;  ---si no encuentra mas valores dentro del cursor termina el ciclo.
							END LOOP;

							EXCEPTION
								WHEN pkg_error.controlled_error THEN
                                    pkg_Error.setError;
                                    pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
                                    RAISE pkg_error.controlled_error;
                                WHEN OTHERS THEN
                                    pkg_Error.setError;
                                    pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
                                    RAISE pkg_error.controlled_error;

						END;

						--Fin del bloque anidado 
					END IF; 

			ELSE
				pkg_traza.trace(csbMetodo ||' El archivo no existe en el servidor!!!', csbNivelTraza);
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                pkg_error.seterrormessage(-200, 'El archivo no existe en el servidor!!!');                
			END IF;

	    ELSE
			pkg_traza.trace(csbMetodo ||' El archivo no existe en el servidor!!!', csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            pkg_error.seterrormessage(-200, ' El alias del directorio : '||nuDirectoryID||' en la tabla GE_DIRECTORY no esta configurado !!!');

	    END IF;

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.controlled_error THEN
			 pkg_Error.getError(onuerrorcode, osberrormessage);
             pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
             RAISE pkg_error.controlled_error;
		WHEN OTHERS THEN
			 pkg_Error.setError;
             pkg_Error.getError(onuerrorcode, osberrormessage);
             pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
			 RAISE pkg_error.controlled_error;
    END LDC_SENDFILEADJUNT;


	/**************************************************************
    Unidad      :  LDC_CREATEACTIVITY
    Descripcion :  procedimiento que se encarga de crear las actividades
				   obteniendo los datos de un archivo plano

    Autor         : OLSOFTWARE SAS
    Fecha         : 29/07/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    08-03-2024   ADRIANAVG              OSF-2388: Se declara variable para el nombre del método    
                                        Se declaran variables para la gestión de error
                                        Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                        Se ajusta cursor CUVALCONCEPTO para indicar parametro de entrada, dado que se usa para validar
                                        dos parametros de entrada pero en la lógica solo evalua el parametro nuConcepto
                                        Se retira el código comentariado
                                        Se ajusta bloque de exception según pautas técnica
    21-06-2024   jpinedc                OSF-2604: Se quita translate                                       
    ***************************************************************/
	PROCEDURE LDC_CREATEACTIVITY
	(
			nuObjeto					IN	NUMBER,
			sbDescripcion				IN  VARCHAR2,
			nuConcepto					IN	NUMBER,
			nuCostoUnitario				IN	NUMBER,
			sbUtilidad					IN	VARCHAR2,
			nuConceptoDescuento			IN	NUMBER,
			nuUnidMedida				IN	NUMBER,
			nuTimeExeMinuto				IN	NUMBER,
			nuActivtyCompens			IN	NUMBER,
			nuObjetoCompens				IN	NUMBER,
			nuCantLega					IN	NUMBER,
			nuGarantiaDias				IN	NUMBER,
			sbLegaMultiple				IN  VARCHAR2,
			sbObservNovedad				IN  VARCHAR2,
			sbItemNovedad				IN  VARCHAR2,
			nuSigno						IN	NUMBER,
			nuEstadoInicial				IN 	NUMBER,
			UTLFileLogItem       		IN	pkg_gestionarchivos.styarchivo,
			nuLineCont					IN	NUMBER
	)IS

    --Se declara variable para el nombre del método en la gestión de trazas
    csbMetodo  			    CONSTANT VARCHAR2(100)   := csbNOMPKG||'ldc_createactivity'; 
    Onuerrorcode            NUMBER                   := pkg_error.cnugeneric_message;
    Osberrormessage         VARCHAR2(2000); 
	nuValUnitMed			NUMBER;
    nuValConcep				NUMBER;
    nuValConcepDiscount		NUMBER;
    nuValObjComp			NUMBER;
    nuValActiComp			NUMBER;
    nuValUtilidad			NUMBER;
    nuValObjeto				NUMBER;
    nuValDesc				NUMBER;
    nuValSigno				NUMBER;
    nuError                 NUMBER;
    nuUnidMediAux			NUMBER;
    sbMessage               VARCHAR2(1000);
    sbMessageError			VARCHAR2(2000);

    blValidaError			BOOLEAN := TRUE;
    blValidaListCost		BOOLEAN := TRUE;
    secItemId				NUMBER  := SEQ_GE_ITEMS_50000344.NEXTVAL; 

    CURSOR cuvalobjeto IS
    SELECT COUNT(1)
      FROM ge_object
     WHERE module_id = 4
       AND object_type_id = 10
       AND object_id = nuobjeto;

    CURSOR cuvalconcepto(p_conccodi concepto.conccodi%TYPE) IS
    SELECT COUNT(1)
      FROM concepto
     WHERE conccodi = nuconcepto;

    CURSOR cuvalutilidad IS
    SELECT COUNT(1)
      FROM ge_attr_allowed_values
     WHERE entity_attribute_id = 44563
       AND value_ = sbutilidad;

    CURSOR cuvalunitmedida IS
    SELECT COUNT(1)
      FROM ge_measure_unit
     WHERE measure_unit_id = nuunidmedida;

    CURSOR cuvalactivicompens IS
    SELECT COUNT(1)
      FROM ge_items
     WHERE item_classif_id = 2
       AND items_id = nuactivtycompens;

    CURSOR cuvalobjetocompens IS
    SELECT COUNT(1)
      FROM ge_object
     WHERE object_type_id = 18
       AND object_id = nuobjetocompens;

    CURSOR cuvaldescgeitem_actividad IS
    SELECT SUM(valuecont) AS total 
      FROM( 
            SELECT COUNT(1) AS valuecont
              FROM ge_items G
             WHERE G.DESCRIPTION = sbdescripcion
        );

    CURSOR cuvalsigno IS
    SELECT COUNT(1)
      FROM (
        SELECT 1 ID , 'Suma' DESCRIPTION FROM dual
        UNION
        SELECT -1 ID ,'Resta' DESCRIPTION FROM dual
        )
     WHERE ID = nusigno;

	BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio); 
        pkg_error.prInicializaError(onuerrorcode, osberrormessage);        
        pkg_traza.trace(csbMetodo||' nuObjeto: '|| nuObjeto||', sbDescripcion: '||sbDescripcion, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuConcepto: '|| nuConcepto||', nuCostoUnitario: '||nuCostoUnitario, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbUtilidad: '|| sbUtilidad||', nuConceptoDescuento: '||nuConceptoDescuento, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuUnidMedida: '|| nuUnidMedida||', nuTimeExeMinuto: '||nuTimeExeMinuto, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuActivtyCompens: '|| nuActivtyCompens||', nuObjetoCompens: '||nuObjetoCompens, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuCantLega: '|| nuCantLega||', nuGarantiaDias: '||nuGarantiaDias, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbLegaMultiple: '|| sbLegaMultiple||', sbObservNovedad: '||sbObservNovedad, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' sbItemNovedad: '|| sbItemNovedad||', nuSigno: '||nuSigno, csbNivelTraza);
        pkg_traza.trace(csbMetodo||' nuEstadoInicial: '|| nuEstadoInicial||', nuLineCont: '||nuLineCont, csbNivelTraza);

		-- Se valida el objeto
		IF(nuobjeto IS NOT NULL)THEN

			IF(cuvalobjeto%isopen)THEN
				CLOSE cuvalobjeto;
			END IF;

			OPEN cuvalobjeto;
			FETCH cuvalobjeto INTO nuvalobjeto;
			CLOSE cuvalobjeto;
            pkg_traza.trace(csbMetodo||' nuvalobjeto: '|| nuvalobjeto , csbNivelTraza);

			IF(nuvalobjeto = 0)THEN
				blvalidaerror := FALSE;
				sbmessageerror := 'El objeto de la actividad no existe';
			END IF;

		END IF;

		-- se valida el concepto
		IF(nuConcepto IS NOT NULL)THEN

			IF(cuValConcepto%isopen)THEN
				CLOSE cuValConcepto;
			END IF;

			OPEN cuValConcepto(nuConcepto);
			FETCH cuValConcepto INTO nuValConcep;
			CLOSE cuValConcepto;
            pkg_traza.trace(csbMetodo||' nuValConcep: '|| nuValConcep , csbNivelTraza);

			IF(nuValConcep = 0)THEN
				blValidaError := FALSE;
				sbMessageError := sbMessageError||', El concepto de la actividad no existe';
			END IF;
		END IF;

		-- si el concepto de descuento no es nulo se valida si existe--
		IF(nuconceptodescuento IS NOT NULL)THEN

			IF(cuvalconcepto%isopen)THEN
				CLOSE cuvalconcepto;
			END IF;

			OPEN cuvalconcepto(nuconceptodescuento);
			FETCH cuvalconcepto INTO nuvalconcepdiscount;
			CLOSE cuvalconcepto;
            pkg_traza.trace(csbMetodo||' nuvalconcepdiscount: '|| nuvalconcepdiscount , csbNivelTraza);

			IF(nuvalconcepdiscount = 0)THEN
				blvalidaerror := FALSE;
				sbmessageerror := sbmessageerror||', El concepto de descuento de la actividad no existe';
			END IF;

		END IF;

		-- si la utilidad no es nula se valida que exista
		IF(sbutilidad IS NOT NULL)THEN

			IF(cuvalutilidad%isopen)THEN
				CLOSE cuvalutilidad;
			END IF;

			OPEN cuvalutilidad;
			FETCH cuvalutilidad INTO nuvalutilidad;
			CLOSE cuvalutilidad;
            pkg_traza.trace(csbMetodo||' nuvalutilidad: '|| nuvalutilidad , csbNivelTraza);

			IF(nuvalutilidad = 0)THEN
				blvalidaerror := FALSE;
				sbmessageerror := sbmessageerror||', La utilidad de la actividad no existe';
			END IF;

		END IF;

		-- se valida la unidad de medida --
		IF(nuunidmedida IS NOT NULL)THEN

			IF(cuvalunitmedida%isopen)THEN
				CLOSE cuvalunitmedida;
			END IF;

			OPEN cuvalunitmedida;
			FETCH cuvalunitmedida INTO nuvalunitmed;
			CLOSE cuvalunitmedida;
            pkg_traza.trace(csbMetodo||' nuvalunitmed: '|| nuvalunitmed , csbNivelTraza);

			IF(nuvalunitmed = 0)THEN
				blvalidaerror := FALSE;
				sbmessageerror := sbmessageerror||', La Unidad de medida de la actividad no existe';
			ELSE
				nuunidmediaux := nuunidmedida;
			END IF;

		ELSE
			-- haciendo pruebas creando items de novedad se encontró que siempre se pone la unidad de
			-- medida en 5 por lo que si viene nulo esta campo se establece con este valor
			NUUNIDMEDIAUX := 5;
		END IF;

		-- se valida la actividad de compensacion --
		IF(nuactivtycompens IS NOT NULL)THEN

			IF(cuvalactivicompens%isopen)THEN
				CLOSE cuvalactivicompens;
			END IF;

			OPEN cuvalactivicompens;
			FETCH cuvalactivicompens INTO nuvalacticomp;
			CLOSE cuvalactivicompens;
            pkg_traza.trace(csbMetodo||' nuvalacticomp: '|| nuvalacticomp , csbNivelTraza);

			IF(nuvalacticomp = 0)THEN
				blvalidaerror := FALSE;
				sbmessageerror := sbmessageerror||', La Actividad de compensacion de la actividad no existe';
			END IF;

		END IF;

		-- se valida el objeto de compensacion de la actividad --
		IF(nuobjetocompens IS NOT NULL)THEN

			IF(cuvalobjetocompens%isopen)THEN
				CLOSE cuvalobjetocompens;
			END IF;

			OPEN cuvalobjetocompens;
			FETCH cuvalobjetocompens INTO nuvalobjcomp;
			CLOSE cuvalobjetocompens;
            pkg_traza.trace(csbMetodo||' nuvalobjcomp: '|| nuvalobjcomp , csbNivelTraza);

			IF(nuvalobjcomp =0)THEN
				blvalidaerror := FALSE;
				sbmessageerror := sbmessageerror||', El objeto de compensacion de la actividad no existe';
			END IF;

		END IF;

		-- se valida signo de la actividad de compensacion --
		IF(nusigno IS NOT NULL)THEN

			IF(cuvalsigno%isopen)THEN
				CLOSE cuvalsigno;
			END IF;

			OPEN cuvalsigno;
			FETCH cuvalsigno INTO nuvalsigno;
			CLOSE cuvalsigno;
            pkg_traza.trace(csbMetodo||' nuvalsigno: '|| nuvalsigno , csbNivelTraza);

			IF(nuvalsigno = 0)THEN
				blvalidaerror := FALSE;
				sbmessageerror := sbmessageerror||', El signo de la actividad no existe';
			END IF;

		END IF;


		-- si no existe ningun error en las validaciones de los campos se procede a crear la actividad
		IF(blvalidaerror)THEN

			-- se llama al cursor que valida si la descripcion con la que se quiere ingresar el item y la actividad no exista en ge_items
			IF(cuvaldescgeitem_actividad%isopen)THEN
				CLOSE cuvaldescgeitem_actividad;
			END IF;

			OPEN cuvaldescgeitem_actividad;
			FETCH cuvaldescgeitem_actividad INTO nuvaldesc;
			CLOSE cuvaldescgeitem_actividad;
            pkg_traza.trace(csbMetodo||' nuvaldesc: '|| nuvaldesc , csbNivelTraza);


			-- si la descripcion no se encuentra en la tabla ge_items
			IF(nuvaldesc = 0)THEN

				-- se llama el proceso que hace la insercion en la tabla GE_ITEMS
                pkg_traza.trace(csbMetodo||' -------------se llama el proceso que hace la insercion en la tabla GE_ITEMS -------------' , csbNivelTraza);
				ldc_prcinsertitems(	secitemid,
									sbdescripcion,
									2,
									nuunidmediaux,
									NULL,
									nuconcepto,
									nuobjeto,
									sbutilidad,
									NULL,
									NULL,
									nutimeexeminuto,
									nugarantiadias,
									nuconceptodescuento,
									NULL,
									NULL,
									'N',
									NULL,
									NULL,
									NULL,
									nuestadoinicial,
									NULL,
									NULL,
									utlfilelogitem,
									nulinecont,
									nuerror,
									sbmessage
								); 
                pkg_traza.trace(csbMetodo||' -------------termina el proceso que hace la insercion en la tabla GE_ITEMS -------------' , csbNivelTraza);
				IF(nuerror = 0)THEN

					-- se llama el proceso que hace la insercion en la tabla OR_ACTIVIDAD
					pkg_traza.trace(csbMetodo||' -------------se llama el proceso que hace la insercion en la tabla OR_ACTIVIDAD -------------' , csbNivelTraza);
                    ldc_prcinsertactividad	( secitemid,
											  nuactivtycompens,
											  nuobjetocompens,
                                              nucantlega,
                                              sblegamultiple,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              NULL,
                                              sbitemnovedad,
                                              nusigno,
                                              sbobservnovedad,
                                              utlfilelogitem,
                                              nulinecont,
                                              nuerror,
                                              sbmessage
											  );
                    pkg_traza.trace(csbMetodo||' -------------Termina proceso que hace la insercion en la tabla OR_ACTIVIDAD -------------' , csbNivelTraza);
					IF(nuerror = 0)THEN

						-- se llama al proceso del insert de la lista de costo para esa actividad --
						pkg_traza.trace(csbMetodo||' -------------se llama el proceso del insert de la lista de costo para esa actividad -------------' , csbNivelTraza);
                        ldc_prcinsertlistacosto (secitemid,	nucostounitario, 2);
                        pkg_traza.trace(csbMetodo||' -------------Termina proceso del insert de la lista de costo para esa actividad -------------' , csbNivelTraza);

						ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, 'Se creo la actividad ['||secitemid||'] - ['||sbdescripcion||']');
                        pkg_traza.trace(csbMetodo||' Se creo la actividad ['||secitemid||'] - ['||sbdescripcion||']' , csbNivelTraza);

						COMMIT;

					ELSE
						ROLLBACK;
						pkg_traza.trace(csbMetodo||' Error en ldc_prcinsertactividad: '||TO_CHAR(nuerror)||' -- '|| sbmessage , csbNivelTraza);
                        ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(nuerror)||' -- '|| sbmessage);                        
					END IF;

				ELSE
					ROLLBACK;
                    pkg_traza.trace(csbMetodo||' Error en ldc_prcinsertitems: '||TO_CHAR(nuerror)||' -- '|| sbmessage , csbNivelTraza);
					ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(nuerror)||' -- '|| sbmessage);                    
				END IF;

			ELSE
				ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = No se puede crear la actividad porque la descripcion se encuentra registrada en la tabla GE_ITEMS!!!');
                pkg_traza.trace(csbMetodo||' No se puede crear la actividad porque la descripcion se encuentra registrada en la tabla GE_ITEMS!!!', csbNivelTraza);
			END IF;

		ELSE
			ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = '||sbmessageerror);
            pkg_traza.trace(csbMetodo||' sbmessageerror: '||sbmessageerror, csbNivelTraza);            
		END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_Error.controlled_error THEN 
            pkg_Error.getError(onuerrorcode, osberrormessage);
            pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
            ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(SQLCODE)||' -- '|| sqlerrm);            
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
		WHEN OTHERS THEN

            pkg_Error.setError;
            pkg_Error.getError(onuerrorcode, osberrormessage);
            pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
            ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||TO_CHAR(SQLCODE)||' -- '|| sqlerrm);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
	END LDC_CREATEACTIVITY; 

	/**************************************************************
    Unidad      :  LDC_PRCINSERTACTIVIDAD
    Descripcion :  Procedimiento que se encarga de realizar el insert
				   en las tablas OR_ACTIVIDAD, GE_ITEMS_ATTRIBUTES y si
				   el item de novedad es igual a Y llenará¡ la tabla
				   CT_ITEM_NOVELTY

    Autor         : OLSOFTWARE SAS
    Fecha         : 28/07/2020

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    08-03-2024   ADRIANAVG              OSF-2388: Se declara variable para el nombre del método 
                                        Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                        Se reemplaza reinicio de variables de error por pkg_error.prInicializaError
                                        Se ajusta bloque de exception según pautas técnica
    ***************************************************************/
	PROCEDURE LDC_PRCINSERTACTIVIDAD
    (

		NUID_ACTIVIDAD					IN   OR_ACTIVIDAD.ID_ACTIVIDAD%TYPE,
		NUACTIVID_COMPENSACION			IN   OR_ACTIVIDAD.ACTIVID_COMPENSACION%TYPE,
		NUOBJETO_COMPENSACION			IN   OR_ACTIVIDAD.OBJETO_COMPENSACION%TYPE,
		NUCANTIDAD_DEFECTO				IN   OR_ACTIVIDAD.CANTIDAD_DEFECTO%TYPE,
		SBLEGALIZA_MULTIPLE				IN   OR_ACTIVIDAD.LEGALIZA_MULTIPLE%TYPE,
		SBANULABLE						IN   OR_ACTIVIDAD.ANULABLE%TYPE,
		NUTIEMPO_VIDA					IN   OR_ACTIVIDAD.TIEMPO_VIDA%TYPE,
		SBPRIORIDAD_DESPACHO			IN   OR_ACTIVIDAD.PRIORIDAD_DESPACHO%TYPE,
		SBACTIVA						IN   OR_ACTIVIDAD.ACTIVA%TYPE,
		NUPRIORIDAD						IN   OR_ACTIVIDAD.PRIORIDAD%TYPE,
		SBITEMNOVEDAD					IN   VARCHAR2,
		NUSIGN							IN	 CT_ITEM_NOVELTY.LIQUIDATION_SIGN%TYPE,
		SBCOMMENT_						IN	 CT_ITEM_NOVELTY.COMMENT_%TYPE,
        UTLFileLogItem       	        IN	 pkg_gestionarchivos.styarchivo,
        nuLineCont				        IN	 NUMBER,
        nuError                         OUT  NUMBER,
        sbMessage                       OUT  VARCHAR2
    )
    IS
        --Se declara variable para el nombre del método en la gestión de trazas
        csbMetodo  			 CONSTANT VARCHAR2(100)   := csbNOMPKG||'ldc_prcinsertactividad'; 

		sbLegaMulti  			VARCHAR2(1 BYTE);
		isbCodeExterno			GE_ITEMS.CODE%TYPE;

    BEGIN

		pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_error.prInicializaError(nuError, sbMessage); 
        pkg_traza.trace(csbMetodo ||' NUID_ACTIVIDAD: ' || NUID_ACTIVIDAD , csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' NUACTIVID_COMPENSACION: ' ||NUACTIVID_COMPENSACION, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' NUOBJETO_COMPENSACION: ' || NUOBJETO_COMPENSACION , csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' NUCANTIDAD_DEFECTO: ' ||NUCANTIDAD_DEFECTO, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' SBLEGALIZA_MULTIPLE: ' ||SBLEGALIZA_MULTIPLE, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' SBANULABLE: ' ||SBANULABLE, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' NUTIEMPO_VIDA: ' ||NUTIEMPO_VIDA, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' SBPRIORIDAD_DESPACHO: ' ||SBPRIORIDAD_DESPACHO, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' SBACTIVA: ' ||SBACTIVA, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' NUPRIORIDAD: ' ||NUPRIORIDAD, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' SBITEMNOVEDAD: ' ||SBITEMNOVEDAD, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' NUSIGN: ' ||NUSIGN, csbNivelTraza);        
        pkg_traza.trace(csbMetodo ||' SBCOMMENT_: ' ||SBCOMMENT_, csbNivelTraza);  
        pkg_traza.trace(csbMetodo ||' NULINECONT: ' ||nuLineCont, csbNivelTraza);    

        BEGIN

            IF(sblegaliza_multiple IS NULL)THEN
				sblegamulti := 'N';
			ELSE
				sblegamulti := sblegaliza_multiple;
			END IF;

            pkg_traza.trace(csbMetodo ||' sblegamulti: ' || sblegamulti, csbNivelTraza); 

            INSERT INTO or_actividad (
										id_actividad,
										activid_compensacion,
										objeto_compensacion,
										cantidad_defecto,
										legaliza_multiple,
										anulable,
										tiempo_vida,
										prioridad_despacho,
										activa,
										prioridad
									 )
							  VALUES
									 (
										nuid_actividad,
										nuactivid_compensacion,
										nuobjeto_compensacion,
										nucantidad_defecto,
										sblegamulti,
										sbanulable,
										nutiempo_vida,
										sbprioridad_despacho,
										sbactiva,
										nuprioridad
									 );

            pkg_traza.trace(csbMetodo ||' INSERT INTO OR_ACTIVIDAD, ID_ACTIVIDAD ' || nuid_actividad, csbNivelTraza);

        EXCEPTION
            WHEN pkg_Error.controlled_error THEN
                 nuerror    := SQLCODE;
                 sbmessage  := sqlerrm;
                 pkg_traza.trace(csbMetodo ||' Error WHEN pkg_Error.controlled_error INSERT INTO or_actividad sbmessage: ' || sbmessage, csbNivelTraza);
            WHEN OTHERS THEN
                 nuerror    := SQLCODE;
                 sbmessage  := sqlerrm;
                 pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS INSERT INTO or_actividad sbmessage: ' || sbmessage, csbNivelTraza);
        END; 

		IF(NUERROR = 0)THEN

			BEGIN

				INSERT INTO GE_ITEMS_ATTRIBUTES (
													ITEMS_ID,
													ATTRIBUTE_1_ID,
													INIT_EXPRESSION_1_ID,
													VALID_EXPRESSION_1_ID,
													STATEMENT_1_ID,
													COMPONENT_1_ID,
													ATTRIBUTE_2_ID,
													INIT_EXPRESSION_2_ID,
													VALID_EXPRESSION_2_ID,
													STATEMENT_2_ID,
													COMPONENT_2_ID,
													ATTRIBUTE_3_ID,
													INIT_EXPRESSION_3_ID,
													VALID_EXPRESSION_3_ID,
													STATEMENT_3_ID,
													COMPONENT_3_ID,
													ATTRIBUTE_4_ID,
													INIT_EXPRESSION_4_ID,
													VALID_EXPRESSION_4_ID,
													STATEMENT_4_ID,
													COMPONENT_4_ID,
													REQUIRED1,
													REQUIRED2,
													REQUIRED3,
													REQUIRED4
												)
										VALUES
												(
													NUID_ACTIVIDAD,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													NULL,
													'N',
													'N',
													'N',
													'N'
												);
                pkg_traza.trace(csbMetodo ||' INSERT INTO GE_ITEMS_ATTRIBUTES, ITEMS_ID ' || NUID_ACTIVIDAD, csbNivelTraza);

			EXCEPTION
				WHEN pkg_error.CONTROLLED_ERROR THEN
					 nuerror    := SQLCODE;
					 sbmessage  := SQLERRM;
                     pkg_traza.trace(csbMetodo ||' sbmessage: ' || sbmessage, csbNivelTraza);
				WHEN OTHERS THEN
					 nuerror    := SQLCODE;
					 sbmessage  := SQLERRM;
                     pkg_traza.trace(csbMetodo ||' sbmessage: ' || sbmessage, csbNivelTraza);
			END;

		END IF; 

		IF(nuError = 0)THEN

			-- se valida si el campo de item de novedad esta en Y
			IF(SBITEMNOVEDAD = 'Y')THEN

				BEGIN

					INSERT INTO CT_ITEM_NOVELTY  (
												ITEMS_ID,
												LIQUIDATION_SIGN,
												COMMENT_
											 )
									  VALUES
											 (
												NUID_ACTIVIDAD,
												NUSIGN,
												SBCOMMENT_
											 );

                    pkg_traza.trace(csbMetodo ||' INSERT INTO CT_ITEM_NOVELTY, ITEMS_ID ' || NUID_ACTIVIDAD, csbNivelTraza);
                EXCEPTION
					WHEN pkg_Error.CONTROLLED_ERROR THEN
						 nuError    := SQLCODE;
						 sbMessage  := SQLERRM;
                         pkg_traza.trace(csbMetodo ||' sbmessage: ' || sbmessage, csbNivelTraza);
					WHEN OTHERS THEN
						 nuError    := SQLCODE;
						 sbMessage  := SQLERRM;
                         pkg_traza.trace(csbMetodo ||' sbmessage: ' || sbmessage, csbNivelTraza);
				END;

			END IF;

		END IF; 

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

     EXCEPTION
        WHEN pkg_Error.controlled_error THEN             
             pkg_Error.getError(nuError, sbMessage);
             pkg_traza.trace(csbMetodo ||' sbMessage: ' || sbMessage||' - '||dbms_utility.format_error_backtrace, csbNivelTraza);
             ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(SQLCODE)||' -- '|| sqlerrm);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN             
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbMessage);
             pkg_traza.trace(csbMetodo ||' sbMessage: ' || sbMessage||' - '||dbms_utility.format_error_backtrace, csbNivelTraza);
             ldc_pkgestionitems.ldc_llenatxtlog(utlfilelogitem, nulinecont||' = Error: '||to_char(SQLCODE)||' -- '|| sqlerrm);
             pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);

    END LDC_PRCINSERTACTIVIDAD;



END LDC_PKGESTIONITEMS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGESTIONITEMS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGESTIONITEMS', 'ADM_PERSON'); 
END;
/
