CREATE OR REPLACE Package adm_person.ldc_pkcc_scm Is
    /*****************************************************************
    Propiedad intelectual de GAS CARIBE (c).

    Unidad         : ldc_pkcc_scm
    Descripcion    : procesos para validar los datos que se insertaran en las tablas originales de OSF para ver los cambios reflejados en la forma CCGSCM
    Autor          : Ing. Oscar Ospino P. | Ludycom S.A
    Fecha          : 16-11-2016

    Historia de Modificaciones
    Fecha       Autor           Modificacion
    ==========  ===========     ====================
    02/07/2024  PAcosta         OSF-2889: Cambio de esquema ADM_PERSON 
    25-03-2022  cgonzalez       OSF-141 - Se crea el metodo ReemplazarCaracteres
    16-11-2016  OscarOspino     Creacion
    ******************************************************************/

	Function frfobtenerestructuratablas(onuerror Out Number,
																			osberror Out Varchar2)
		Return pkconstante.tyrefcursor;

	Procedure proinsdatosimportacion(sbplantilla      In Varchar2,
																	 sbrutaplantilla  In Varchar2,
																	 sbsegmentaciones In Varchar2,
																	 onuerror         Out Number,
																	 osberror         Out Varchar2);

	Function frfobtconsecutivos(onuerror Out Number,
															osberror Out Varchar2)
		Return pkconstante.tyrefcursor;

	Procedure prodatosvalidacion(orfestructuratablas Out pkconstante.tyrefcursor,
															 orfsegmentacion     Out pkconstante.tyrefcursor,
															 orfestadocivil      Out pkconstante.tyrefcursor,
															 orfgradoescolaridad Out pkconstante.tyrefcursor,
															 orfclasificacion    Out pkconstante.tyrefcursor,
															 orftipocliente      Out pkconstante.tyrefcursor,
															 orfnivelingresos    Out pkconstante.tyrefcursor,
															 orfplancomercial    Out pkconstante.tyrefcursor,
															 orfpromociones      Out pkconstante.tyrefcursor,
															 orfplanfinanciacion Out pkconstante.tyrefcursor,
															 orfestadocorte      Out pkconstante.tyrefcursor,
															 orfestadofinan      Out pkconstante.tyrefcursor,
															 onuerrorcode        Out Number,
															 osberrormessage     Out Varchar2);

	Procedure setcommercialsegment(iclcommercialsegment In Clob,
																 ocloutresults        Out Clob,
																 inuvalidate          In Number Default 0,
																 onuerrorcode         Out Number,
																 osberrormessage      Out Varchar2);

End ldc_pkcc_scm;
/
CREATE OR REPLACE Package Body adm_person.ldc_pkcc_scm Is
	------------------------------------------------------------------------------------------------
	-- Datos de paquete
	------------------------------------------------------------------------------------------------
	gsbpaquete Varchar2(30) := 'LDC_PKCC_SCM';
	gnusesion  Number := userenv('sessionid');
	sbentrega  Varchar2(100) := 'CRM_GDC_0000956_1';

	Function frfobtenerestructuratablas(onuerror Out Number,
																			osberror Out Varchar2)
		Return pkconstante.tyrefcursor Is
		/*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: FrfObtenerEstructuraTablas
    Descripcion:        Obtiene la estructura de las tablas que intervienen en la Segmentacion
                        Comercial y las devuelve en un cursor referenciado de una sola fila.

    Autor    : Oscar Ospino P.
    Fecha    : 16-11-2016  CA 200-513

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    16-11-2016   Oscar Ospino P.        Creacion
    ******************************************************************/

		sbproceso Varchar2(4000) := gsbpaquete || '.' ||
																'FRFOBTENERESTRUCTURATABLAS';

		cudatos pkconstante.tyrefcursor;

	Begin

		ut_trace.trace('INICIO ' || sbentrega || ' | ' || sbproceso);

		--Se abre el cursor con la consulta sobre all_tab_columns col y all_col_comments
		Open cudatos For
			Select col.owner,
						 col.table_name,
						 col.column_id,
						 col.column_name,
						 col.data_type,
						 nvl(col.data_precision, col.data_length) data_precision,
						 col.nullable,
						 upper(com.comments) coldescription
				From all_tab_columns col, all_col_comments com
			 Where col.table_name = com.table_name And
						 col.column_name = com.column_name And
						 col.owner = com.owner And
						 col.owner = 'OPEN' And
						 col.table_name In
						 ('CC_COMMERCIAL_SEGM', 'CC_COM_SEG_FEA_VAL', 'CC_COM_SEG_PROM', 'CC_COM_SEG_PLAN', 'CC_COM_SEG_FINAN')
			 Order By col.table_name, col.column_id;

		ut_trace.trace('FIN ' || sbentrega || ' | ' || sbproceso);

		Return cudatos;

	Exception

		When Others Then
			onuerror := Sqlcode;
			osberror := 'TERMINO CON ERROR NO CONTROLADO | ' || sbentrega ||
									' | ' || sbproceso || ' | Sesion: ' || gnusesion ||
									chr(10) || Sqlerrm;
			ut_trace.trace(osberror);

	End frfobtenerestructuratablas;

	/* Procedure proinssegcom Is

  Begin
  End;*/

	Procedure proinsdatosimportacion(sbplantilla      In Varchar2,
																	 sbrutaplantilla  In Varchar2,
																	 sbsegmentaciones In Varchar2,
																	 onuerror         Out Number,
																	 osberror         Out Varchar2) Is

		/*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: ProInsDatosImportacion
    Descripcion:        Inserta el registro de las operaciones realizadas en la forma .NET CCSCM
                        en la tabla Master de Segmentacion Masiva

    Autor    : Oscar Ospino P.
    Fecha    : 16-11-2016  CA 200-513

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    16-11-2016   Oscar Ospino P.        Creacion
    ******************************************************************/

		dtfecha   Date := Sysdate;
		sbmaquina Varchar2(100) := sys_context('USERENV', 'HOST');
		nusesion  Number(15) := userenv('sessionid');
		sbusuario Varchar2(100) := open.cc_bopetitionmgr.fsbgetpersonname(); --open.sa_bouser.fnugetuserid;

		nuid ldc_cc_scma.id%Type;

	Begin

		Select Max(id) Into nuid From open.ldc_cc_scma;
		/*id             NUMBER not null,
    fecha          DATE not null,
    plantilla      VARCHAR2(50) not null,
    rutaplantilla  VARCHAR2(50) not null,
    segmentaciones NUMBER(15) not null,
    usuario        VARCHAR2(50) not null,
    maquina */

		--Actualizo el consecutivo a insertar
		If nuid Is Null Then
			nuid := 1;
		Else
			nuid := nuid + 1;
		End If;
		Insert Into open.ldc_cc_scma
			(id,
			 fecha,
			 plantilla,
			 rutaplantilla,
			 segmentaciones,
			 usuario,
			 sesion,
			 maquina)
		Values
			(nuid,
			 dtfecha,
			 sbplantilla,
			 sbrutaplantilla,
			 sbsegmentaciones,
			 sbusuario,
			 nusesion,
			 sbmaquina);

	Exception
		When Others Then
			onuerror := Sqlcode;
			osberror := Sqlerrm;

	End proinsdatosimportacion;

	Function frfobtconsecutivos(onuerror Out Number,
															osberror Out Varchar2)
		Return pkconstante.tyrefcursor Is
		/*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: FrfObtConsecutivos
    Descripcion:        Obtiene la estructura de las tablas que intervienen en la Segmentacion
                        Comercial y las devuelve en un cursor referenciado de una sola fila.

    Autor    : Oscar Ospino P.
    Fecha    : 16-11-2016  CA 200-513

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    16-11-2016   Oscar Ospino P.        Creacion
    ******************************************************************/

		sbproceso Varchar2(4000) := gsbpaquete || '.' || 'FRFOBTCONSECUTIVOS';

		cudatos pkconstante.tyrefcursor;

	Begin

		ut_trace.trace('INICIO ' || sbentrega || ' | ' || sbproceso);

		--Se abre el cursor con la consulta
		Open cudatos For
			Select ( --segmentacion comercial
							Select Max(commercial_segm_id) From open.cc_commercial_segm) commercial_segm_id,
						 ( --caracteristicas
							Select Max(com_seg_fea_val_id) From open.cc_com_seg_fea_val) com_seg_fea_val_id,
						 ( --oferta comercial por promocion
							Select Max(com_seg_prom_id) From open.cc_com_seg_prom) com_seg_prom_id,
						 ( --oferta comercial por plan
							Select Max(com_seg_plan_id) From open.cc_com_seg_plan) com_seg_plan_id,
						 ( --oferta comercial por plan de financiacion
							Select Max(com_seg_finan_id) From open.cc_com_seg_finan) com_seg_finan_id
				From dual;

		ut_trace.trace('FIN ' || sbentrega || ' | ' || sbproceso);

		Return cudatos;

	Exception
		When Others Then
			onuerror := Sqlcode;
			osberror := 'TERMINO CON ERROR NO CONTROLADO | ' || sbentrega ||
									' | ' || sbproceso || ' | Sesion: ' || gnusesion ||
									chr(10) || Sqlerrm;
			ut_trace.trace(osberror);

	End frfobtconsecutivos;

	Procedure prodatosvalidacion(orfestructuratablas Out pkconstante.tyrefcursor,
															 orfsegmentacion     Out pkconstante.tyrefcursor,
															 orfestadocivil      Out pkconstante.tyrefcursor,
															 orfgradoescolaridad Out pkconstante.tyrefcursor,
															 orfclasificacion    Out pkconstante.tyrefcursor,
															 orftipocliente      Out pkconstante.tyrefcursor,
															 orfnivelingresos    Out pkconstante.tyrefcursor,
															 orfplancomercial    Out pkconstante.tyrefcursor,
															 orfpromociones      Out pkconstante.tyrefcursor,
															 orfplanfinanciacion Out pkconstante.tyrefcursor,
															 orfestadocorte      Out pkconstante.tyrefcursor,
															 orfestadofinan      Out pkconstante.tyrefcursor,
															 onuerrorcode        Out Number,
															 osberrormessage     Out Varchar2) Is

		/*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: prodatosvalidacion
    Descripcion:        Obtiene los datos de las tablas asociadas a la Segmentacion COmercial.
                        Devuelve cursores referenciados de las tablas Padre (FK).

    Autor    : Oscar Ospino P.
    Fecha    : 16-11-2016  CA 200-513

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    16-11-2016   Oscar Ospino P.        Creacion
    ******************************************************************/

		sbproceso Varchar2(4000) := gsbpaquete || '.' || 'PRODATOSVALIDACION';

	Begin
		ut_trace.trace('INICIO ' || sbentrega || ' | ' || sbproceso);

		--Se abre el cursor con la consulta sobre all_tab_columns col y all_col_comments
		Open orfestructuratablas For
			Select col.owner,
						 col.table_name,
						 col.column_id,
						 col.column_name,
						 col.data_type,
						 nvl(col.data_precision, col.data_length) data_precision,
						 col.nullable,
						 upper(com.comments) coldescription
				From all_tab_columns col, all_col_comments com
			 Where col.table_name = com.table_name And
						 col.column_name = com.column_name And
						 col.owner = com.owner And
						 col.owner = 'OPEN' And
						 col.table_name In
						 ('CC_COMMERCIAL_SEGM', 'CC_COM_SEG_FEA_VAL', 'CC_COM_SEG_PROM', 'CC_COM_SEG_PLAN', 'CC_COM_SEG_FINAN')
			 Order By col.table_name, col.column_id;

		Open orfsegmentacion For
			Select commercial_segm_id id
				From cc_commercial_segm
			 Where commercial_segm_id > 0;

		Open orfestadocivil For
			Select Distinct civil_state_id id
				From ge_civil_state
			 Where civil_state_id > 0;

		Open orfgradoescolaridad For
			Select Distinct school_degree_id id
				From ge_school_degree
			 Where school_degree_id > 0;

		Open orfclasificacion For
			Select Distinct clasificacion_id id
				From cc_tipo_scoring
			 Where clasificacion_id > 0;

		Open orftipocliente For
			Select Distinct subscriber_type_id id
				From ge_subscriber_type
			 Where subscriber_type_id > 0;

		Open orfnivelingresos For
			Select Distinct wage_scale_id id
				From ge_wage_scale
			 Where wage_scale_id > 0;

		Open orfplancomercial For
			Select Distinct commercial_plan_id id, initial_date, final_date
				From cc_commercial_plan
			 Where commercial_plan_id > 0;

		Open orfpromociones For
			Select Distinct promotion_id id
				From cc_promotion
			 Where promotion_id > 0;

		Open orfplanfinanciacion For
			Select Distinct pldicodi id From plandife Where pldicodi > 0;

		Open orfestadocorte For
			Select escocodi id From estacort t Where escocodi > 0;

		Open orfestadofinan For
			Select esficodi id From estafina Where esficodi > 0;

		ut_trace.trace('FIN ' || sbentrega || ' | ' || sbproceso);

	Exception
		When Others Then
			onuerrorcode    := Sqlcode;
			osberrormessage := Sqlerrm;
			Raise;

	End;

    /*****************************************************************
    Propiedad intelectual de GAS CARIBE (c).

    Unidad         : ReemplazarCaracteres
    Descripcion    : Reemplaza caracteres del XML que se arma en la funcionalidad CCGSCM
    Autor          : Horbath
    Fecha          : 31-03-2022

    Historia de Modificaciones
    Fecha       Autor       Modificacion
    ==========  =========   ====================
    31-03-2022  cgonzalez   OSF-128 Creacion
    ******************************************************************/
    PROCEDURE ReemplazarCaracteres
    (
        iclXML IN   CLOB,
        oclXML OUT  CLOB
    )
    IS

    BEGIN
        UT_TRACE.TRACE('INICIO LDC_PKCC_SCM.ReemplazarCaracteres', 5);

        --Completar tag XML del campo LAST_FINAN_PLAN
        oclXML  := replace(iclXML,'<LastFinanPlan>','<LastFinanPlan><Key>');
        oclXML  := replace(oclXML,'</LastFinanPlan>','</Key></LastFinanPlan>');

		--Mapeo Campo FINAN_FINAN_STATE
		oclXML  := replace(oclXML,'<FinanState>1','<FinanState>A');
		oclXML  := replace(oclXML,'<FinanState>2','<FinanState>D');
		oclXML  := replace(oclXML,'<FinanState>5','<FinanState>C');
		oclXML  := replace(oclXML,'<FinanState>6','<FinanState>M');
        oclXML  := replace(oclXML,'<FinanState>7','<FinanState>');

        UT_TRACE.TRACE('FIN LDC_PKCC_SCM.ReemplazarCaracteres', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('EX.CONTROLLED_ERROR LDC_PKCC_SCM.ReemplazarCaracteres', 5);
        WHEN OTHERS THEN
            UT_TRACE.TRACE('OTHERS LDC_PKCC_SCM.ReemplazarCaracteres', 5);
    END ReemplazarCaracteres;

	Procedure setcommercialsegment(iclcommercialsegment In Clob,
																 ocloutresults        Out Clob,
																 inuvalidate          In Number Default 0,
																 onuerrorcode         Out Number,
																 osberrormessage      Out Varchar2) Is
		/*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: SetCommercialSegment
    Descripcion:        Invoca al proceso OSF que gestiona las segmentaciones comerciales por XML.

    Parametros:
        iclcommercialsegment       XML con la segmentaciones a insertar/modificar/eliminar
        ocloutresults              XML con los resultados del proceso.
        inuvalidate

    Autor    : Oscar Ospino P.
    Fecha    : 28-12-2016  CA 200-513

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              	Modificacion
    -----------  -------------------------  -------------------------------------
    31-03-2022   cgonzalez                  OSF-128 Se adiciona llamado al metodo ReemplazarCaracteres
    31-03-2022	 cgonzalez	                GLPI 955 Se reemplaza el tag <LastFinanPlan> por <LastFinanPlan><Key>.
	27-01-2022	 cgonzalez	                GLPI 955 Se reemplaza el tag <LastFinanPlan> por <LastFinanPlan><Key>.
											Se reemplaza el tag </LastFinanPlan> por </Key></LastFinanPlan>.
    28-12-2016   Oscar Ospino P.        	Creacion
    ******************************************************************/

		sbproceso Varchar2(4000) := gsbpaquete || '.' ||'SETCOMMERCIALSEGMENT';

		clin  Clob;
		clout Clob;
	Begin
		ut_trace.trace('Inicia ' || sbproceso, 10);

        ReemplazarCaracteres(iclcommercialsegment, clin);

		clout := ocloutresults;

		If inuvalidate = 0 Then
			ut_trace.trace('Llamando cc_bouicommercialsegm.setcommercialsegment - Sin Flag de validacion', 10);
			cc_bouicommercialsegm.setcommercialsegment(clin, clout, False);
		Else
			ut_trace.trace('Llamando cc_bouicommercialsegm.setcommercialsegment - Con Flag de validacion', 10);
			cc_bouicommercialsegm.setcommercialsegment(clin, clout, True);
		End If;

		ocloutresults := clout;
		onuerrorcode  := 0;
		ut_trace.trace('Fin ' || sbproceso, 10);

	Exception
		When Others Then
			onuerrorcode    := Sqlcode;
			osberrormessage := Sqlerrm;

	End;

End ldc_pkcc_scm;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKCC_SCM
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKCC_SCM', 'ADM_PERSON');
END;
/