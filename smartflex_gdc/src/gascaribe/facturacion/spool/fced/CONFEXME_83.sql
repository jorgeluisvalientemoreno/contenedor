BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_83 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_83',
		'CREATE OR REPLACE PACKAGE CONFEXME_83 IS ' || chr(10) || chr(10) ||
		chr(9) || '-- Estado de procesamiento' || chr(10) ||
		chr(9) || 'boProcessStatusOK   boolean := TRUE;' || chr(10) || chr(10) ||

		chr(9) || '-- Indice para recorrer las colecciones' || chr(10) ||
		chr(9) || 'nuIndex             binary_integer;' || chr(10) || chr(10) ||

		chr(9) || '-- Registro para almacenar la información de un formato' || chr(10) ||
		chr(9) || 'rcED_Formato        DAED_Formato.styED_Formato;' || chr(10) || chr(10) ||

		chr(9) || '-- Registro para almacenar la información de una expresión' || chr(10) ||
		chr(9) || 'rcNullExpression    DAGR_Config_Expression.styGR_Config_Expression;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de sentencias' || chr(10) ||
		chr(9) || 'tbrcGE_Statement    ID_BCExportaFormato.tytbGE_Statement;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de tipos de franja' || chr(10) ||
		chr(9) || 'tbrcED_TipoFran     DAED_TipoFran.tytbED_TipoFran;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de tipos de bloque' || chr(10) ||
		chr(9) || 'tbrcED_TipoBloq     DAED_TipoBloq.tytbED_TipoBloq;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de entidades por formato' || chr(10) ||
		chr(9) || 'tbrcED_EntiForm     ID_BCExportaFormato.tytbED_EntiForm;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de franjas por formato' || chr(10) ||
		chr(9) || 'tbrcED_FranForm     ID_BCExportaFormato.tytbED_FranForm;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de servicios por franjas por formato' || chr(10) ||
		chr(9) || 'tbrcED_ServFran     DAED_ServFran.tytbED_ServFran;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de fuentes de datos' || chr(10) ||
		chr(9) || 'tbrcED_FuenDato     ID_BCExportaFormato.tytbED_FuenDato;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de atributos por fuentes de datos' || chr(10) ||
		chr(9) || 'tbrcED_AtriFuda     ID_BCExportaFormato.tytbED_AtriFuda;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de franjas' || chr(10) ||
		chr(9) || 'tbrcED_Franja       DAED_Franja.tytbED_Franja;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de bloques por franja' || chr(10) ||
		chr(9) || 'tbrcED_BloqFran     ID_BCExportaFormato.tytbED_BloqFran;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de bloques' || chr(10) ||
		chr(9) || 'tbrcED_Bloque       DAED_Bloque.tytbED_Bloque;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de ítems por bloque' || chr(10) ||
		chr(9) || 'tbrcED_ItemBloq     ID_BCExportaFormato.tytbED_ItemBloq;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de ítems' || chr(10) ||
		chr(9) || 'tbrcED_Item         ID_BCExportaFormato.tytbED_Item;' || chr(10) || chr(10) ||

		chr(9) || '-- Colección de expresiones' || chr(10) ||
		chr(9) || 'tbrcGR_Config_Expression    ID_BCExportaFormato.tytbGR_Config_Expression;' || chr(10) || chr(10) ||

		chr(9) || '-- extractor y Mezcla con identificador ' || chr(10) ||
		chr(9) || 'CURSOR cuExtractAndMix' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'inuIdExtAndMix   ed_confexme.coemcodi%type' || chr(10) ||
		chr(9) || ')' || chr(10) ||
		chr(9) || 'IS' || chr(10) ||
		chr(9) || chr(9) || 'SELECT   coemcodi' || chr(10) ||
		chr(9) || chr(9) || 'FROM     ed_confexme' || chr(10) ||
		chr(9) || chr(9) || 'WHERE    coemcodi = inuIdExtAndMix;' || chr(10) || chr(10) ||

		chr(9) || '-- plantilla con nombre identificador ' || chr(10) ||
		chr(9) || 'CURSOR cuPlantilla' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'isbPlantillId   ed_plantill.plancodi%type' || chr(10) ||
		chr(9) || ')' || chr(10) ||
		chr(9) || 'IS' || chr(10) ||
		chr(9) || chr(9) || 'SELECT   plancodi' || chr(10) ||
		chr(9) || chr(9) || 'FROM     ed_plantill' || chr(10) ||
		chr(9) || chr(9) || 'WHERE    plancodi = isbPlantillId;' || chr(10) || chr(10) ||

		chr(9) || '-- Formato con identificador de formato' || chr(10) ||
		chr(9) || 'CURSOR cuFormat' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'isbFormatId     ed_formato.formcodi%type' || chr(10) ||
		chr(9) || ')' || chr(10) ||
		chr(9) || 'IS' || chr(10) ||
		chr(9) || chr(9) || 'SELECT   formcodi' || chr(10) ||
		chr(9) || chr(9) || 'FROM     ed_formato' || chr(10) ||
		chr(9) || chr(9) || 'WHERE    formcodi = isbFormatId;' || chr(10) || chr(10) ||

		chr(9) || '-- Reglas asociadas a Items' || chr(10) ||
		chr(9) || 'CURSOR cuGR_Config_Expression' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'inuExpression    gr_config_expression.config_expression_id%type' || chr(10) ||
		chr(9) || ')' || chr(10) ||
		chr(9) || 'IS' || chr(10) ||
		chr(9) || chr(9) || 'SELECT   gr_config_expression.*, gr_config_expression.rowid' || chr(10) ||
		chr(9) || chr(9) || 'FROM     gr_config_expression' || chr(10) ||
		chr(9) || chr(9) || 'WHERE    config_expression_id = inuExpression;' || chr(10) || chr(10) ||

		chr(9) || '-- Tipos de Franja asociadas a una regla' || chr(10) ||
		chr(9) || 'CURSOR cuStripTypes' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'isbStripTypeRule    ed_tipofran.tifrobna%type' || chr(10) ||
		chr(9) || ')' || chr(10) ||
		chr(9) || 'IS' || chr(10) ||
		chr(9) || chr(9) || 'SELECT   tifrcodi' || chr(10) ||
		chr(9) || chr(9) || 'FROM     ed_tipofran' || chr(10) ||
		chr(9) || chr(9) || 'WHERE    upper(tifrobna) = upper(isbStripTypeRule);' || chr(10) || chr(10) ||

		chr(9) || '-- Tipos de Bloque asociados a una regla' || chr(10) ||
		chr(9) || 'CURSOR cuBlockTypes' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'isbBlockTypeRule    ed_tipobloq.tiblobna%type' || chr(10) ||
		chr(9) || ')' || chr(10) ||
		chr(9) || 'IS' || chr(10) ||
		chr(9) || chr(9) || 'SELECT   tiblcodi' || chr(10) ||
		chr(9) || chr(9) || 'FROM     ed_tipobloq' || chr(10) ||
		chr(9) || chr(9) || 'WHERE    upper(tiblobna) = upper(isbBlockTypeRule);' || chr(10) || chr(10) ||

		chr(9) || '-- Procedimiento para ejecutar una sentencia en una transacción autónoma' || chr(10) ||
		chr(9) || 'PROCEDURE ExecuteSQLSentence' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'isbSQLSentence    in   varchar2' || chr(10) ||
		chr(9) || ');' || chr(10) || chr(10) ||

		chr(9) || '-- Procedimiento para eliminar en una transacción autónoma las expresiones generadas' || chr(10) ||
		chr(9) || 'PROCEDURE DeleteGeneratedExpressions;' || chr(10) || chr(10) ||

		'END CONFEXME_83;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_83',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_83 IS ' || chr(10) || chr(10) ||
		chr(9) || '-- Procedimiento para ejecutar una sentencia en una transacción autónoma' || chr(10) ||
		chr(9) || 'PROCEDURE ExecuteSQLSentence' || chr(10) ||
		chr(9) || '(' || chr(10) ||
		chr(9) || chr(9) || 'isbSQLSentence    in   varchar2' || chr(10) ||
		chr(9) || ')' || chr(10) ||
		chr(9) || 'IS' || chr(10) || chr(10) ||

		chr(9) || chr(9) || '-- Se define el procedimiento como una transacción autónoma' || chr(10) ||
		chr(9) || chr(9) || 'PRAGMA AUTONOMOUS_TRANSACTION;' || chr(10) || chr(10) ||

		chr(9) || 'BEGIN' || chr(10) ||
		chr(9) || '--{' || chr(10) ||
		chr(9) || chr(9) || 'EXECUTE IMMEDIATE isbSQLSentence;' || chr(10) || chr(10) ||

		chr(9) || 'EXCEPTION' || chr(10) || chr(10) ||

		chr(9) || chr(9) || 'when OTHERS then' || chr(10) ||
		chr(9) || chr(9) || chr(9) || 'raise;' || chr(10) ||
		chr(9) || '--}' || chr(10) ||
		chr(9) || 'END;' || chr(10) || chr(10) ||

		chr(9) || '-- Procedimiento para eliminar en una transacción autónoma las expresiones generadas' || chr(10) ||
		chr(9) || 'PROCEDURE DeleteGeneratedExpressions' || chr(10) ||
		chr(9) || 'IS' || chr(10) || chr(10) ||

		chr(9) || chr(9) || '-- Se define el procedimiento como una transacción autónoma' || chr(10) ||
		chr(9) || chr(9) || 'PRAGMA AUTONOMOUS_TRANSACTION;' || chr(10) || chr(10) ||

		chr(9) || chr(9) || '-- Indice para recorrer la colección de expresiones generadas' || chr(10) ||
		chr(9) || chr(9) || 'sbExprIdx            ID_BCExportaFormato.styStrIdx;' || chr(10) || chr(10) ||

		chr(9) || chr(9) || '-- Flag que indica si un objeto stand-alone fue eliminado' || chr(10) ||
		chr(9) || chr(9) || 'boObjectDeleted      boolean;' || chr(10) || chr(10) ||

		chr(9) || 'BEGIN' || chr(10) ||
		chr(9) || '--{' || chr(10) ||
		chr(9) || chr(9) || '-- Se elimina cada una de las expresiones generadas' || chr(10) ||
		chr(9) || chr(9) || 'sbExprIdx := tbrcGR_Config_Expression.first;' || chr(10) || chr(10) ||

		chr(9) || chr(9) || 'while ( sbExprIdx is not NULL ) loop' || chr(10) ||
		chr(9) || chr(9) || '--{' || chr(10) ||
		chr(9) || chr(9) || chr(9) || '-- Se verifica que el objeto exista' || chr(10) ||
		chr(9) || chr(9) || chr(9) || 'if ( tbrcGR_Config_Expression( sbExprIdx ).object_name is not NULL and' || chr(10) ||
		chr(9) || chr(9) || chr(9) || '     UT_Object.fboExistObject( tbrcGR_Config_Expression( sbExprIdx ).object_name )' || chr(10) ||
		chr(9) || chr(9) || chr(9) || ') then' || chr(10) ||
		chr(9) || chr(9) || chr(9) || '--{' || chr(10) ||
		chr(9) || chr(9) || chr(9) || chr(9) || '-- Se elimina el objeto stand-alone' || chr(10) ||
		chr(9) || chr(9) || chr(9) || chr(9) || 'UT_Trace.Trace( ''Eliminando el objeto ['' || tbrcGR_Config_Expression( sbExprIdx ).object_name || '']'', 6 );' || chr(10) ||
		chr(9) || chr(9) || chr(9) || chr(9) || 'boObjectDeleted := UT_Object.fboDeleteObject( tbrcGR_Config_Expression( sbExprIdx ).object_name );' || chr(10) ||
		chr(9) || chr(9) || chr(9) || '--}' || chr(10) ||
		chr(9) || chr(9) || chr(9) || 'end if;' || chr(10) || chr(10) ||

		chr(9) || chr(9) || chr(9) || '-- Se obtiene el índice de la siguiente expresión' || chr(10) ||
		chr(9) || chr(9) || chr(9) || 'sbExprIdx := tbrcGR_Config_Expression.next( sbExprIdx );' || chr(10) ||
		chr(9) || chr(9) || '--}' || chr(10) ||
		chr(9) || chr(9) || 'end loop;' || chr(10) || chr(10) || 

		chr(9) || 'EXCEPTION' || chr(10) || chr(10) ||

		chr(9) || chr(9) || 'when OTHERS then' || chr(10) ||
		chr(9) || chr(9) || chr(9) || 'raise;' || chr(10) ||
		chr(9) || '--}' || chr(10) ||
		chr(9) || 'END;' || chr(10) || chr(10) ||

		'END CONFEXME_83;'
	);
--}
END;
/

DECLARE

	-- Identificador de un formato
	nuFormatId          ed_formato.formcodi%type;

	-- Código de error
	nuErrorCode         ge_error_log.message_id%type;

	-- Mensaje de Error
	sbErrorMessage      ge_error_log.description%type;

BEGIN
--{
	UT_Trace.Trace( '***************************** Eliminando formato *******************************', 5 );
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_83.cuFormat( 264 );
	fetch CONFEXME_83.cuFormat into nuFormatId;
	close CONFEXME_83.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		pkBSDataExtractor.DeleteFormat
		(
			nuFormatId,
			FALSE,
			nuErrorCode,
			sbErrorMessage
		);

		if ( nuErrorCode <> pkConstante.EXITO ) then
		--{
			-- Se eleva una excepción controlada
			raise LOGIN_DENIED;
		--}
		end if;
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '****************************** Generando formato *******************************', 5 );
--}
END;
/

DECLARE

	-- Identificador de un formato
	nuFormatId          ed_formato.formcodi%type;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_83.cuFormat( 264 );
	fetch CONFEXME_83.cuFormat into nuFormatId;
	close CONFEXME_83.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_83.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_FACT_GASCARIBE_NOREG',
		       formtido = 66,
		       formiden = '<264>',
		       formtico = 49,
		       formdein = '<LDC_FACTURA>',
		       formdefi = '</LDC_FACTURA>'
		WHERE  formcodi = CONFEXME_83.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_83.rcED_Formato.formcodi := 264 ;

		-- Se inserta el formato
		INSERT INTO ED_Formato
		(
			formcodi,
			formdesc,
			formtido,
			formiden,
			formtico,
			formdein,
			formdefi
		)
		VALUES
		(
			CONFEXME_83.rcED_Formato.formcodi,
			'LDC_FACT_GASCARIBE_NOREG',
			66,
			'<264>',
			49,
			'<LDC_FACTURA>',
			'</LDC_FACTURA>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '**************************** Generando sentencias ******************************', 5 );
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '*********************** Generando entidades por formato ************************', 5 );
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '************************** Generando tipos de franja ***************************', 5 );
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '************************** Generando tipos de bloque ***************************', 5 );
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '****************************** Generando franjas *******************************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_83.tbrcED_Franja( 4807 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_DATOS_GENERAL]', 5 );
	INSERT INTO ED_Franja
	(
		francodi,
		frandesc,
		frantifr,
		frandein,
		frandefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Franja( 4807 ).francodi,
		'LDC_DATOS_GENERAL',
		CONFEXME_83.tbrcED_Franja( 4807 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_83.tbrcED_Franja( 4808 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_DATOS_SERVICIO]', 5 );
	INSERT INTO ED_Franja
	(
		francodi,
		frandesc,
		frantifr,
		frandein,
		frandefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Franja( 4808 ).francodi,
		'LDC_DATOS_SERVICIO',
		CONFEXME_83.tbrcED_Franja( 4808 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_83.tbrcED_Franja( 4809 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_CARGOS]', 5 );
	INSERT INTO ED_Franja
	(
		francodi,
		frandesc,
		frantifr,
		frandein,
		frandefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Franja( 4809 ).francodi,
		'LDC_CARGOS',
		CONFEXME_83.tbrcED_Franja( 4809 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_83.tbrcED_Franja( 4810 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_REFERENCIALES]', 5 );
	INSERT INTO ED_Franja
	(
		francodi,
		frandesc,
		frantifr,
		frandein,
		frandefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Franja( 4810 ).francodi,
		'LDC_REFERENCIALES',
		CONFEXME_83.tbrcED_Franja( 4810 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_83.tbrcED_Franja( 4811 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_RANGOS]', 5 );
	INSERT INTO ED_Franja
	(
		francodi,
		frandesc,
		frantifr,
		frandein,
		frandefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Franja( 4811 ).francodi,
		'LDC_RANGOS',
		CONFEXME_83.tbrcED_Franja( 4811 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_83.tbrcED_Franja( 4812 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_DATOS_MARCA]', 5 );
	INSERT INTO ED_Franja
	(
		francodi,
		frandesc,
		frantifr,
		frandein,
		frandefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Franja( 4812 ).francodi,
		'LDC_DATOS_MARCA',
		CONFEXME_83.tbrcED_Franja( 4812 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_83.tbrcED_Franja( 4813 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_INFO_ADICIONAL]', 5 );
	INSERT INTO ED_Franja
	(
		francodi,
		frandesc,
		frantifr,
		frandein,
		frandefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Franja( 4813 ).francodi,
		'LDC_INFO_ADICIONAL',
		CONFEXME_83.tbrcED_Franja( 4813 ).frantifr,
		'<INFO_ADICIONALES>',
		'</INFO_ADICIONALES>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '************************ Generando franjas por formato *************************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_83.tbrcED_FranForm( '4656' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_83.tbrcED_FranForm( '4656' ).frfoform := CONFEXME_83.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_83.tbrcED_Franja.exists( 4807 ) ) then
		CONFEXME_83.tbrcED_FranForm( '4656' ).frfofran := CONFEXME_83.tbrcED_Franja( 4807 ).francodi;
	end if;

	INSERT INTO ED_FranForm
	(
		frfocodi,
		frfoform,
		frfofran,
		frfoorde,
		frfomult
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FranForm( '4656' ).frfocodi,
		CONFEXME_83.tbrcED_FranForm( '4656' ).frfoform,
		CONFEXME_83.tbrcED_FranForm( '4656' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_83.tbrcED_FranForm( '4657' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_83.tbrcED_FranForm( '4657' ).frfoform := CONFEXME_83.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_83.tbrcED_Franja.exists( 4808 ) ) then
		CONFEXME_83.tbrcED_FranForm( '4657' ).frfofran := CONFEXME_83.tbrcED_Franja( 4808 ).francodi;
	end if;

	INSERT INTO ED_FranForm
	(
		frfocodi,
		frfoform,
		frfofran,
		frfoorde,
		frfomult
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FranForm( '4657' ).frfocodi,
		CONFEXME_83.tbrcED_FranForm( '4657' ).frfoform,
		CONFEXME_83.tbrcED_FranForm( '4657' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_83.tbrcED_FranForm( '4658' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_83.tbrcED_FranForm( '4658' ).frfoform := CONFEXME_83.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_83.tbrcED_Franja.exists( 4809 ) ) then
		CONFEXME_83.tbrcED_FranForm( '4658' ).frfofran := CONFEXME_83.tbrcED_Franja( 4809 ).francodi;
	end if;

	INSERT INTO ED_FranForm
	(
		frfocodi,
		frfoform,
		frfofran,
		frfoorde,
		frfomult
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FranForm( '4658' ).frfocodi,
		CONFEXME_83.tbrcED_FranForm( '4658' ).frfoform,
		CONFEXME_83.tbrcED_FranForm( '4658' ).frfofran,
		3,
		'S'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_83.tbrcED_FranForm( '4659' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_83.tbrcED_FranForm( '4659' ).frfoform := CONFEXME_83.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_83.tbrcED_Franja.exists( 4810 ) ) then
		CONFEXME_83.tbrcED_FranForm( '4659' ).frfofran := CONFEXME_83.tbrcED_Franja( 4810 ).francodi;
	end if;

	INSERT INTO ED_FranForm
	(
		frfocodi,
		frfoform,
		frfofran,
		frfoorde,
		frfomult
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FranForm( '4659' ).frfocodi,
		CONFEXME_83.tbrcED_FranForm( '4659' ).frfoform,
		CONFEXME_83.tbrcED_FranForm( '4659' ).frfofran,
		5,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_83.tbrcED_FranForm( '4660' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_83.tbrcED_FranForm( '4660' ).frfoform := CONFEXME_83.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_83.tbrcED_Franja.exists( 4811 ) ) then
		CONFEXME_83.tbrcED_FranForm( '4660' ).frfofran := CONFEXME_83.tbrcED_Franja( 4811 ).francodi;
	end if;

	INSERT INTO ED_FranForm
	(
		frfocodi,
		frfoform,
		frfofran,
		frfoorde,
		frfomult
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FranForm( '4660' ).frfocodi,
		CONFEXME_83.tbrcED_FranForm( '4660' ).frfoform,
		CONFEXME_83.tbrcED_FranForm( '4660' ).frfofran,
		4,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_83.tbrcED_FranForm( '4661' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_83.tbrcED_FranForm( '4661' ).frfoform := CONFEXME_83.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_83.tbrcED_Franja.exists( 4812 ) ) then
		CONFEXME_83.tbrcED_FranForm( '4661' ).frfofran := CONFEXME_83.tbrcED_Franja( 4812 ).francodi;
	end if;

	INSERT INTO ED_FranForm
	(
		frfocodi,
		frfoform,
		frfofran,
		frfoorde,
		frfomult
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FranForm( '4661' ).frfocodi,
		CONFEXME_83.tbrcED_FranForm( '4661' ).frfoform,
		CONFEXME_83.tbrcED_FranForm( '4661' ).frfofran,
		6,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_83.tbrcED_FranForm( '4662' ).frfoform := CONFEXME_83.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_83.tbrcED_Franja.exists( 4813 ) ) then
		CONFEXME_83.tbrcED_FranForm( '4662' ).frfofran := CONFEXME_83.tbrcED_Franja( 4813 ).francodi;
	end if;

	INSERT INTO ED_FranForm
	(
		frfocodi,
		frfoform,
		frfofran,
		frfoorde,
		frfomult
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi,
		CONFEXME_83.tbrcED_FranForm( '4662' ).frfoform,
		CONFEXME_83.tbrcED_FranForm( '4662' ).frfofran,
		7,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '******************* Generando servicios por franja-formato *********************', 5 );
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '************************* Generando fuentes de datos ***************************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_DATOS_GENERALES]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi,
		'LDC_DATOS_GENERALES',
		'LDC_DetalleFact_GasCaribe.RfDatosGenerales',
		CONFEXME_83.tbrcED_FuenDato( '3945' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3946' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_DATOS_REVISION]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3946' ).fudacodi,
		'LDC_DATOS_REVISION',
		'ldc_detallefact_gascaribe.RfDatosRevision',
		CONFEXME_83.tbrcED_FuenDato( '3946' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_CARGOS]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi,
		'LDC_CARGOS',
		'LDC_DetalleFact_GasCaribe.RfDatosConcEstadoCuenta',
		CONFEXME_83.tbrcED_FuenDato( '3947' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3948' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_CUPON]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3948' ).fudacodi,
		'LDC_CUPON',
		'LDC_DetalleFact_GasCaribe.RfDatosBarCode',
		CONFEXME_83.tbrcED_FuenDato( '3948' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3949' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_TASAS_CAMBIO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3949' ).fudacodi,
		'LDC_TASAS_CAMBIO',
		'LDC_DetalleFact_GasCaribe.rfGetValRates',
		CONFEXME_83.tbrcED_FuenDato( '3949' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_SUBTOTALES]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi,
		'LDC_SUBTOTALES',
		'LDC_DetalleFact_GasCaribe.RfConcepParcial',
		CONFEXME_83.tbrcED_FuenDato( '3950' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_CODBARRAS]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi,
		'LDC_CODBARRAS',
		'LDC_DetalleFact_GasCaribe.RfDatosCodBarras',
		CONFEXME_83.tbrcED_FuenDato( '3951' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3952' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ldc_detallefact_gascaribe.RfDatosConsumos]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3952' ).fudacodi,
		'ldc_detallefact_gascaribe.RfDatosConsumos',
		'ldc_detallefact_gascaribe.RfDatosConsumos',
		CONFEXME_83.tbrcED_FuenDato( '3952' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3953' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_DATOS_LECTURA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3953' ).fudacodi,
		'LDC_DATOS_LECTURA',
		'ldc_detallefact_gascaribe.RfDatosLecturas',
		CONFEXME_83.tbrcED_FuenDato( '3953' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_DATOS_CONSUMO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi,
		'LDC_DATOS_CONSUMO',
		'ldc_detallefact_gascaribe.RfDatosConsumoHist',
		CONFEXME_83.tbrcED_FuenDato( '3954' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [cargos_spool]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi,
		'cargos_spool',
		'LDC_DetalleFact_GasCaribe.RfDatosConceptos',
		CONFEXME_83.tbrcED_FuenDato( '3955' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_RANGOS_CONSUMO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi,
		'LDC_RANGOS_CONSUMO',
		'LDC_DetalleFact_GasCaribe.RfRangosConsumo',
		CONFEXME_83.tbrcED_FuenDato( '3956' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ldc_rangos_2]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi,
		'ldc_rangos_2',
		'ldc_duplicado_meses_ant.prorangos2',
		CONFEXME_83.tbrcED_FuenDato( '3957' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3958' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_COMPCOST]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3958' ).fudacodi,
		'LDC_COMPCOST',
		'LDC_DetalleFact_GasCaribe.rfGetValCostCompValid',
		CONFEXME_83.tbrcED_FuenDato( '3958' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3959' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [RfMarcaAguaDuplicado]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3959' ).fudacodi,
		'RfMarcaAguaDuplicado',
		'LDC_DETALLEFACT_GASCARIBE.RfMarcaAguaDuplicado',
		CONFEXME_83.tbrcED_FuenDato( '3959' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3960' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_DATOS_ADICIONALES_DUPLICADO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3960' ).fudacodi,
		'LDC_DATOS_ADICIONALES_DUPLICADO',
		'LDC_DETALLEFACT_GASCARIBE.RfDatosAdicionales',
		CONFEXME_83.tbrcED_FuenDato( '3960' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3961' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_TASAS_CAMBIO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3961' ).fudacodi,
		'LDC_TASAS_CAMBIO',
		'LDC_DetalleFact_GasCaribe.rfGetValRates',
		CONFEXME_83.tbrcED_FuenDato( '3961' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3962' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_DATOS_SPOOL]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3962' ).fudacodi,
		'LDC_DATOS_SPOOL',
		'ldc_detallefact_gascaribe.prodatosspool',
		CONFEXME_83.tbrcED_FuenDato( '3962' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3963' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_PROTECCION_DATOS]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3963' ).fudacodi,
		'LDC_PROTECCION_DATOS',
		'LDC_DETALLEFACT_GASCARIBE.RfProteccion_Datos',
		CONFEXME_83.tbrcED_FuenDato( '3963' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3964' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_ACUMTATT]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3964' ).fudacodi,
		'LDC_ACUMTATT',
		'ldc_detallefact_gascaribe.RfDatosCuenxCobrTt',
		CONFEXME_83.tbrcED_FuenDato( '3964' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3965' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_FINAESPE]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3965' ).fudacodi,
		'LDC_FINAESPE',
		'LDC_DetalleFact_GasCaribe.RfDatosFinanEspecial',
		CONFEXME_83.tbrcED_FuenDato( '3965' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3966' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_MEDIDOR_MAL_UBIC]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3966' ).fudacodi,
		'LDC_MEDIDOR_MAL_UBIC',
		'LDC_DetalleFact_GasCaribe.RfDatosMedMalubi',
		CONFEXME_83.tbrcED_FuenDato( '3966' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3967' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_IMPRIME_FACTURA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3967' ).fudacodi,
		'LDC_IMPRIME_FACTURA',
		'LDC_DetalleFact_GasCaribe.rfdatosimpresiondig',
		CONFEXME_83.tbrcED_FuenDato( '3967' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3968' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_VALOR_FECH_ULTPAGO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3968' ).fudacodi,
		'LDC_VALOR_FECH_ULTPAGO',
		'LDC_DetalleFact_GasCaribe.rfLastPayment',
		CONFEXME_83.tbrcED_FuenDato( '3968' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '3969' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [SALDO_ANTERIOR]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '3969' ).fudacodi,
		'SALDO_ANTERIOR',
		'LDC_DetalleFact_GasCaribe.rfGetSaldoAnterior',
		CONFEXME_83.tbrcED_FuenDato( '3969' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_TOTALES]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi,
		'LDC_TOTALES',
		'LDC_DetalleFact_GasCaribe.RfConcepParcial',
		CONFEXME_83.tbrcED_FuenDato( '4010' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '******************** Generando atributos por fuente de datos *******************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31055' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3946' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31055' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3946' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tipo_Noti]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31055' ).atfdcodi,
		'TIPO_NOTI',
		'Tipo_Noti',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31055' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31056' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3946' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31056' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3946' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Mens_Noti]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31056' ).atfdcodi,
		'MENS_NOTI',
		'Mens_Noti',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31056' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31057' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3946' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31057' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3946' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fech_Maxima]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31057' ).atfdcodi,
		'FECH_MAXIMA',
		'Fech_Maxima',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31057' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31058' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3946' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31058' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3946' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fech_Susp]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31058' ).atfdcodi,
		'FECH_SUSP',
		'Fech_Susp',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31058' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31059' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3949' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31059' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3949' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tasa_Ultima]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31059' ).atfdcodi,
		'TASA_ULTIMA',
		'Tasa_Ultima',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31059' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31060' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3949' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31060' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3949' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tasa_Promedio]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31060' ).atfdcodi,
		'TASA_PROMEDIO',
		'Tasa_Promedio',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31060' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31061' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31061' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Etiqueta]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31061' ).atfdcodi,
		'ETIQUETA',
		'Etiqueta',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31061' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31062' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31062' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Desc_Concep]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31062' ).atfdcodi,
		'DESC_CONCEP',
		'Desc_Concep',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31062' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31063' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31063' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Saldo_Ant]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31063' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31063' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31064' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31064' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Capital]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31064' ).atfdcodi,
		'CAPITAL',
		'Capital',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31064' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31065' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31065' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Interes]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31065' ).atfdcodi,
		'INTERES',
		'Interes',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31065' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31066' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31066' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Total]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31066' ).atfdcodi,
		'TOTAL',
		'Total',
		6,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31066' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31067' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31067' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Saldo_Dif]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31067' ).atfdcodi,
		'SALDO_DIF',
		'Saldo_Dif',
		7,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31067' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31068' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31068' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cuotas]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31068' ).atfdcodi,
		'CUOTAS',
		'Cuotas',
		8,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31068' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31069' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31069' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Factura]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31069' ).atfdcodi,
		'FACTURA',
		'Factura',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31069' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31070' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31070' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fech_Fact]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31070' ).atfdcodi,
		'FECH_FACT',
		'Fech_Fact',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31070' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31071' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31071' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Mes_Fact]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31071' ).atfdcodi,
		'MES_FACT',
		'Mes_Fact',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31071' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31072' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31072' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Periodo_Fact]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31072' ).atfdcodi,
		'PERIODO_FACT',
		'Periodo_Fact',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31072' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31073' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31073' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Pago_Hasta]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31073' ).atfdcodi,
		'PAGO_HASTA',
		'Pago_Hasta',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31073' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31074' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31074' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Dias_Consumo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31074' ).atfdcodi,
		'DIAS_CONSUMO',
		'Dias_Consumo',
		6,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31074' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31075' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31075' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Contrato]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31075' ).atfdcodi,
		'CONTRATO',
		'Contrato',
		7,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31075' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31076' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31076' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cupon]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31076' ).atfdcodi,
		'CUPON',
		'Cupon',
		8,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31076' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31077' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31077' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nombre]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31077' ).atfdcodi,
		'NOMBRE',
		'Nombre',
		9,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31077' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31078' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31078' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Direccion_Cobro]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31078' ).atfdcodi,
		'DIRECCION_COBRO',
		'Direccion_Cobro',
		10,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31078' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31079' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31079' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Localidad]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31079' ).atfdcodi,
		'LOCALIDAD',
		'Localidad',
		11,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31079' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31080' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31080' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Categoria]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31080' ).atfdcodi,
		'CATEGORIA',
		'Categoria',
		12,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31080' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31081' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31081' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Estrato]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31081' ).atfdcodi,
		'ESTRATO',
		'Estrato',
		13,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31081' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31082' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31082' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Ciclo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31082' ).atfdcodi,
		'CICLO',
		'Ciclo',
		14,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31082' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31083' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31083' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Ruta]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31083' ).atfdcodi,
		'RUTA',
		'Ruta',
		15,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31083' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31084' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31084' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Meses_Deuda]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31084' ).atfdcodi,
		'MESES_DEUDA',
		'Meses_Deuda',
		16,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31084' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31085' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31085' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Num_Control]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31085' ).atfdcodi,
		'NUM_CONTROL',
		'Num_Control',
		17,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31085' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31086' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31086' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Periodo_Consumo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31086' ).atfdcodi,
		'PERIODO_CONSUMO',
		'Periodo_Consumo',
		18,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31086' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31087' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31087' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Saldo_Favor]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31087' ).atfdcodi,
		'SALDO_FAVOR',
		'Saldo_Favor',
		19,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31087' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31088' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31088' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Saldo_Ant]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31088' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		20,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31088' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31089' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31089' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Suspension]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31089' ).atfdcodi,
		'FECHA_SUSPENSION',
		'Fecha_Suspension',
		21,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31089' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31090' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31090' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Recl]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31090' ).atfdcodi,
		'VALOR_RECL',
		'Valor_Recl',
		22,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31090' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31091' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31091' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Total_Factura]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31091' ).atfdcodi,
		'TOTAL_FACTURA',
		'Total_Factura',
		23,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31091' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31092' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31092' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Pago_Sin_Recargo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31092' ).atfdcodi,
		'PAGO_SIN_RECARGO',
		'Pago_Sin_Recargo',
		24,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31092' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31093' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31093' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Condicion_Pago]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31093' ).atfdcodi,
		'CONDICION_PAGO',
		'Condicion_Pago',
		25,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31093' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31094' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31094' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Identifica]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31094' ).atfdcodi,
		'IDENTIFICA',
		'Identifica',
		26,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31094' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31095' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31095' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tipo de producto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31095' ).atfdcodi,
		'SERVICIO',
		'Tipo de producto',
		27,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31095' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31096' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3948' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31096' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3948' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Código]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31096' ).atfdcodi,
		'CODE',
		'Código',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31096' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31097' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3948' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31097' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3948' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Image]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31097' ).atfdcodi,
		'IMAGE',
		'Image',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31097' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31098' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3951' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31098' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo_1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31098' ).atfdcodi,
		'CODIGO_1',
		'Codigo_1',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31098' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31099' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3951' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31099' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo_2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31099' ).atfdcodi,
		'CODIGO_2',
		'Codigo_2',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31099' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31100' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3951' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31100' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo_3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31100' ).atfdcodi,
		'CODIGO_3',
		'Codigo_3',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31100' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31101' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3951' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31101' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo_4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31101' ).atfdcodi,
		'CODIGO_4',
		'Codigo_4',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31101' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31102' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3951' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31102' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo_Barras]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31102' ).atfdcodi,
		'CODIGO_BARRAS',
		'Codigo_Barras',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31102' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31103' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3950' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31103' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Total]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31103' ).atfdcodi,
		'TOTAL',
		'Total',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31103' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31104' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3950' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31104' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Iva]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31104' ).atfdcodi,
		'IVA',
		'Iva',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31104' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31105' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3950' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31105' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Subtotal]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31105' ).atfdcodi,
		'SUBTOTAL',
		'Subtotal',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31105' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31106' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3950' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31106' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cargosmes]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31106' ).atfdcodi,
		'CARGOSMES',
		'Cargosmes',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31106' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31107' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3950' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31107' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cantidad_Conc]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31107' ).atfdcodi,
		'CANTIDAD_CONC',
		'Cantidad_Conc',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31107' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31108' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3952' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31108' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3952' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Mes]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31108' ).atfdcodi,
		'CONSUMO_MES',
		'Consumo_Mes',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31108' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31109' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3952' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31109' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3952' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Cons_Mes]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31109' ).atfdcodi,
		'FECHA_CONS_MES',
		'Fecha_Cons_Mes',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31109' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31110' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3953' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31110' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3953' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Num_Medidor]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31110' ).atfdcodi,
		'NUM_MEDIDOR',
		'Num_Medidor',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31110' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31111' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3953' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31111' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3953' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lectura_Anterior]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31111' ).atfdcodi,
		'LECTURA_ANTERIOR',
		'Lectura_Anterior',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31111' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31112' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3953' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31112' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3953' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lectura_Actual]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31112' ).atfdcodi,
		'LECTURA_ACTUAL',
		'Lectura_Actual',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31112' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31113' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3953' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31113' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3953' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Obs_Lectura]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31113' ).atfdcodi,
		'OBS_LECTURA',
		'Obs_Lectura',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31113' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31114' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31114' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cons_Correg]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31114' ).atfdcodi,
		'CONS_CORREG',
		'Cons_Correg',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31114' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31115' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31115' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Factor_Correccion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31115' ).atfdcodi,
		'FACTOR_CORRECCION',
		'Factor_Correccion',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31115' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31116' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31116' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Mes_1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31116' ).atfdcodi,
		'CONSUMO_MES_1',
		'Consumo_Mes_1',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31116' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31117' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31117' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Cons_Mes_1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31117' ).atfdcodi,
		'FECHA_CONS_MES_1',
		'Fecha_Cons_Mes_1',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31117' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31118' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31118' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Mes_2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31118' ).atfdcodi,
		'CONSUMO_MES_2',
		'Consumo_Mes_2',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31118' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31119' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31119' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Cons_Mes_2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31119' ).atfdcodi,
		'FECHA_CONS_MES_2',
		'Fecha_Cons_Mes_2',
		6,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31119' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31120' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31120' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Mes_3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31120' ).atfdcodi,
		'CONSUMO_MES_3',
		'Consumo_Mes_3',
		7,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31120' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31121' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31121' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Cons_Mes_3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31121' ).atfdcodi,
		'FECHA_CONS_MES_3',
		'Fecha_Cons_Mes_3',
		8,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31121' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31122' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31122' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Mes_4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31122' ).atfdcodi,
		'CONSUMO_MES_4',
		'Consumo_Mes_4',
		9,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31122' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31123' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31123' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Cons_Mes_4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31123' ).atfdcodi,
		'FECHA_CONS_MES_4',
		'Fecha_Cons_Mes_4',
		10,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31123' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31124' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31124' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Mes_5]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31124' ).atfdcodi,
		'CONSUMO_MES_5',
		'Consumo_Mes_5',
		11,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31124' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31125' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31125' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Cons_Mes_5]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31125' ).atfdcodi,
		'FECHA_CONS_MES_5',
		'Fecha_Cons_Mes_5',
		12,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31125' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31126' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31126' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Mes_6]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31126' ).atfdcodi,
		'CONSUMO_MES_6',
		'Consumo_Mes_6',
		13,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31126' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31127' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31127' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Cons_Mes_6]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31127' ).atfdcodi,
		'FECHA_CONS_MES_6',
		'Fecha_Cons_Mes_6',
		14,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31127' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31128' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31128' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo_Promedio]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31128' ).atfdcodi,
		'CONSUMO_PROMEDIO',
		'Consumo_Promedio',
		15,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31128' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31129' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31129' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Temperatura]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31129' ).atfdcodi,
		'TEMPERATURA',
		'Temperatura',
		16,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31129' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31130' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31130' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Presion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31130' ).atfdcodi,
		'PRESION',
		'Presion',
		17,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31130' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31131' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31131' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Equival_Kwh]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31131' ).atfdcodi,
		'EQUIVAL_KWH',
		'Equival_Kwh',
		18,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31131' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31132' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31132' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Calculo_Cons]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31132' ).atfdcodi,
		'CALCULO_CONS',
		'Calculo_Cons',
		19,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31132' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31133' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31133' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Etiqueta]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31133' ).atfdcodi,
		'ETIQUETA',
		'Etiqueta',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31133' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31134' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31134' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Concepto_Id]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31134' ).atfdcodi,
		'CONCEPTO_ID',
		'Concepto_Id',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31134' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31135' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31135' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Desc_Concep]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31135' ).atfdcodi,
		'DESC_CONCEP',
		'Desc_Concep',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31135' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31136' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31136' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Saldo_Ant]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31136' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31136' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31137' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31137' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Capital]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31137' ).atfdcodi,
		'CAPITAL',
		'Capital',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31137' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31138' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31138' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Interes]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31138' ).atfdcodi,
		'INTERES',
		'Interes',
		6,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31138' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31139' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31139' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Total]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31139' ).atfdcodi,
		'TOTAL',
		'Total',
		7,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31139' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31140' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31140' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Saldo_Dif]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31140' ).atfdcodi,
		'SALDO_DIF',
		'Saldo_Dif',
		8,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31140' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31141' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31141' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Unidad_Items]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31141' ).atfdcodi,
		'UNIDAD_ITEMS',
		'Unidad_Items',
		9,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31141' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31142' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31142' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cantidad]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31142' ).atfdcodi,
		'CANTIDAD',
		'Cantidad',
		10,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31142' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31143' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31143' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unitario]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31143' ).atfdcodi,
		'VALOR_UNITARIO',
		'Valor_Unitario',
		11,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31143' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31144' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31144' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Iva]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31144' ).atfdcodi,
		'VALOR_IVA',
		'Valor_Iva',
		12,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31144' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31145' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31145' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cuotas]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31145' ).atfdcodi,
		'CUOTAS',
		'Cuotas',
		13,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31145' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31146' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3956' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31146' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31146' ).atfdcodi,
		'LIM_INFERIOR',
		'Lim_Inferior',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31146' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31147' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3956' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31147' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31147' ).atfdcodi,
		'LIM_SUPERIOR',
		'Lim_Superior',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31147' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31148' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3956' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31148' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31148' ).atfdcodi,
		'VALOR_UNIDAD',
		'Valor_Unidad',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31148' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31149' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3956' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31149' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31149' ).atfdcodi,
		'CONSUMO',
		'Consumo',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31149' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31150' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3956' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31150' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31150' ).atfdcodi,
		'VAL_CONSUMO',
		'Val_Consumo',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31150' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31151' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31151' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31151' ).atfdcodi,
		'LIM_INFERIOR1',
		'Lim_Inferior1',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31151' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31152' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31152' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31152' ).atfdcodi,
		'LIM_SUPERIOR1',
		'Lim_Superior1',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31152' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31153' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31153' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31153' ).atfdcodi,
		'VALOR_UNIDAD1',
		'Valor_Unidad1',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31153' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31154' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31154' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31154' ).atfdcodi,
		'CONSUMO1',
		'Consumo1',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31154' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31155' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31155' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo1]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31155' ).atfdcodi,
		'VAL_CONSUMO1',
		'Val_Consumo1',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31155' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31156' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31156' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31156' ).atfdcodi,
		'LIM_INFERIOR2',
		'Lim_Inferior2',
		6,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31156' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31157' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31157' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31157' ).atfdcodi,
		'LIM_SUPERIOR2',
		'Lim_Superior2',
		7,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31157' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31158' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31158' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31158' ).atfdcodi,
		'VALOR_UNIDAD2',
		'Valor_Unidad2',
		8,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31158' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31159' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31159' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31159' ).atfdcodi,
		'CONSUMO2',
		'Consumo2',
		9,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31159' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31160' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31160' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo2]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31160' ).atfdcodi,
		'VAL_CONSUMO2',
		'Val_Consumo2',
		10,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31160' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31161' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31161' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31161' ).atfdcodi,
		'LIM_INFERIOR3',
		'Lim_Inferior3',
		11,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31161' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31162' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31162' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31162' ).atfdcodi,
		'LIM_SUPERIOR3',
		'Lim_Superior3',
		12,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31162' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31163' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31163' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31163' ).atfdcodi,
		'VALOR_UNIDAD3',
		'Valor_Unidad3',
		13,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31163' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31164' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31164' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31164' ).atfdcodi,
		'CONSUMO3',
		'Consumo3',
		14,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31164' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31165' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31165' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo3]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31165' ).atfdcodi,
		'VAL_CONSUMO3',
		'Val_Consumo3',
		15,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31165' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31166' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31166' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31166' ).atfdcodi,
		'LIM_INFERIOR4',
		'Lim_Inferior4',
		16,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31166' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31167' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31167' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31167' ).atfdcodi,
		'LIM_SUPERIOR4',
		'Lim_Superior4',
		17,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31167' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31168' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31168' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31168' ).atfdcodi,
		'VALOR_UNIDAD4',
		'Valor_Unidad4',
		18,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31168' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31169' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31169' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31169' ).atfdcodi,
		'CONSUMO4',
		'Consumo4',
		19,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31169' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31170' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31170' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo4]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31170' ).atfdcodi,
		'VAL_CONSUMO4',
		'Val_Consumo4',
		20,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31170' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31171' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31171' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior5]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31171' ).atfdcodi,
		'LIM_INFERIOR5',
		'Lim_Inferior5',
		21,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31171' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31172' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31172' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior5]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31172' ).atfdcodi,
		'LIM_SUPERIOR5',
		'Lim_Superior5',
		22,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31172' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31173' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31173' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad5]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31173' ).atfdcodi,
		'VALOR_UNIDAD5',
		'Valor_Unidad5',
		23,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31173' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31174' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31174' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo5]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31174' ).atfdcodi,
		'CONSUMO5',
		'Consumo5',
		24,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31174' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31175' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31175' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo5]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31175' ).atfdcodi,
		'VAL_CONSUMO5',
		'Val_Consumo5',
		25,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31175' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31176' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31176' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior6]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31176' ).atfdcodi,
		'LIM_INFERIOR6',
		'Lim_Inferior6',
		26,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31176' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31177' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31177' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior6]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31177' ).atfdcodi,
		'LIM_SUPERIOR6',
		'Lim_Superior6',
		27,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31177' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31178' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31178' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad6]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31178' ).atfdcodi,
		'VALOR_UNIDAD6',
		'Valor_Unidad6',
		28,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31178' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31179' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31179' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo6]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31179' ).atfdcodi,
		'CONSUMO6',
		'Consumo6',
		29,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31179' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31180' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31180' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo6]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31180' ).atfdcodi,
		'VAL_CONSUMO6',
		'Val_Consumo6',
		30,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31180' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31181' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31181' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Inferior7]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31181' ).atfdcodi,
		'LIM_INFERIOR7',
		'Lim_Inferior7',
		31,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31181' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31182' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31182' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Lim_Superior7]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31182' ).atfdcodi,
		'LIM_SUPERIOR7',
		'Lim_Superior7',
		32,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31182' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31183' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31183' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Unidad7]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31183' ).atfdcodi,
		'VALOR_UNIDAD7',
		'Valor_Unidad7',
		33,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31183' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31184' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31184' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consumo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31184' ).atfdcodi,
		'CONSUMO',
		'Consumo',
		34,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31184' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31185' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31185' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Val_Consumo7]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31185' ).atfdcodi,
		'VAL_CONSUMO7',
		'Val_Consumo7',
		35,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31185' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31186' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3958' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31186' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3958' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Compcost]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31186' ).atfdcodi,
		'COMPCOST',
		'Compcost',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31186' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31187' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3959' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31187' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3959' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Visible]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31187' ).atfdcodi,
		'VISIBLE',
		'Visible',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31187' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31188' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3959' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31188' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3959' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Impreso]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31188' ).atfdcodi,
		'IMPRESO',
		'Impreso',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31188' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31189' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3960' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31189' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3960' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Direccion_Producto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31189' ).atfdcodi,
		'DIRECCION_PRODUCTO',
		'Direccion_Producto',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31189' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31190' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3960' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31190' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3960' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Causa_Desviacion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31190' ).atfdcodi,
		'CAUSA_DESVIACION',
		'Causa_Desviacion',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31190' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31191' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3960' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31191' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3960' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Pagare_Unico]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31191' ).atfdcodi,
		'PAGARE_UNICO',
		'Pagare_Unico',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31191' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31192' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3960' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31192' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3960' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cambiouso]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31192' ).atfdcodi,
		'CAMBIOUSO',
		'Cambiouso',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31192' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31193' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3961' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31193' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3961' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tasa_Ultima]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31193' ).atfdcodi,
		'TASA_ULTIMA',
		'Tasa_Ultima',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31193' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31194' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3961' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31194' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3961' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tasa_Promedio]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31194' ).atfdcodi,
		'TASA_PROMEDIO',
		'Tasa_Promedio',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31194' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31195' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3962' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31195' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3962' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cuadrilla_Reparto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31195' ).atfdcodi,
		'CUADRILLA_REPARTO',
		'Cuadrilla_Reparto',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31195' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31196' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3962' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31196' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3962' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Observ_No_Lect_Consec]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31196' ).atfdcodi,
		'OBSERV_NO_LECT_CONSEC',
		'Observ_No_Lect_Consec',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31196' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31197' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3963' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31197' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3963' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Visible]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31197' ).atfdcodi,
		'VISIBLE',
		'Visible',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31197' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31198' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3963' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31198' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3963' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Impreso]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31198' ).atfdcodi,
		'IMPRESO',
		'Impreso',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31198' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31199' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3963' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31199' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3963' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Proteccion_Estado]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31199' ).atfdcodi,
		'PROTECCION_ESTADO',
		'Proteccion_Estado',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31199' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31200' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3964' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31200' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3964' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Acumu]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31200' ).atfdcodi,
		'ACUMU',
		'Acumu',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31200' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31201' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3965' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31201' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3965' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Finaespe]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31201' ).atfdcodi,
		'FINAESPE',
		'Finaespe',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31201' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31202' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3966' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31202' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3966' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Med_Mal_Ubicado]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31202' ).atfdcodi,
		'MED_MAL_UBICADO',
		'Med_Mal_Ubicado',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31202' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31203' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3967' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31203' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3967' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Imprimefact]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31203' ).atfdcodi,
		'IMPRIMEFACT',
		'Imprimefact',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31203' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31204' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3968' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31204' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3968' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Ult_Pago]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31204' ).atfdcodi,
		'VALOR_ULT_PAGO',
		'Valor_Ult_Pago',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31204' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31205' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3968' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31205' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3968' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Ult_Pago]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31205' ).atfdcodi,
		'FECHA_ULT_PAGO',
		'Fecha_Ult_Pago',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31205' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31206' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3969' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31206' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '3969' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Saldo_Ante]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31206' ).atfdcodi,
		'SALDO_ANTE',
		'Saldo_Ante',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31206' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31738' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '4010' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31738' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Total]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31738' ).atfdcodi,
		'TOTAL',
		'Total',
		1,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31738' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31739' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '4010' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31739' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Iva]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31739' ).atfdcodi,
		'IVA',
		'Iva',
		2,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31739' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31740' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '4010' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31740' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Subtotal]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31740' ).atfdcodi,
		'SUBTOTAL',
		'Subtotal',
		3,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31740' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31741' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '4010' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31741' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cargosmes]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31741' ).atfdcodi,
		'CARGOSMES',
		'Cargosmes',
		4,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31741' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_83.tbrcED_AtriFuda( '31742' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '4010' ) ) then
		CONFEXME_83.tbrcED_AtriFuda( '31742' ).atfdfuda := CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cantidad_Conc]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_83.tbrcED_AtriFuda( '31742' ).atfdcodi,
		'CANTIDAD_CONC',
		'Cantidad_Conc',
		5,
		'S',
		CONFEXME_83.tbrcED_AtriFuda( '31742' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '****************************** Generando bloques *******************************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6812 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3945' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6812 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3945' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DATOS_CLIENTE]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6812 ).bloqcodi,
		'LDC_DATOS_CLIENTE',
		CONFEXME_83.tbrcED_Bloque( 6812 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6812 ).bloqfuda,
		'<LDC_DATOS_CLIENTE>',
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6813 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3946' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6813 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3946' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DATOS_REVISION]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6813 ).bloqcodi,
		'LDC_DATOS_REVISION',
		CONFEXME_83.tbrcED_Bloque( 6813 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6813 ).bloqfuda,
		'<LDC_DATOS_REVISION>',
		'</LDC_DATOS_REVISION>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6814 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3947' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6814 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3947' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_CARGOS]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6814 ).bloqcodi,
		'LDC_CARGOS',
		CONFEXME_83.tbrcED_Bloque( 6814 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6814 ).bloqfuda,
		'<LDC_CARGOS>',
		'</LDC_CARGOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6815 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3948' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6815 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3948' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [BARCODE]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6815 ).bloqcodi,
		'BARCODE',
		CONFEXME_83.tbrcED_Bloque( 6815 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6815 ).bloqfuda,
		'<EXTRA_BARCODE_>',
		'</EXTRA_BARCODE_>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6816 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3949' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6816 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3949' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_TASAS_CAMBIO]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6816 ).bloqcodi,
		'LDC_TASAS_CAMBIO',
		CONFEXME_83.tbrcED_Bloque( 6816 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6816 ).bloqfuda,
		'<LDC_TASAS_CAMBIO>',
		'</LDC_TASAS_CAMBIO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6817 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3950' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6817 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3950' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_SUBTOTALES]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6817 ).bloqcodi,
		'LDC_SUBTOTALES',
		CONFEXME_83.tbrcED_Bloque( 6817 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6817 ).bloqfuda,
		'<LDC_SUBTOTALES>',
		'</LDC_SUBTOTALES>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6818 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3951' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6818 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3951' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_CUPON]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6818 ).bloqcodi,
		'LDC_CUPON',
		CONFEXME_83.tbrcED_Bloque( 6818 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6818 ).bloqfuda,
		'<LDC_CUPON>',
		'</LDC_CUPON>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6819 ).bloqcodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Bloque [LDC_BRILLA]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6819 ).bloqcodi,
		'LDC_BRILLA',
		CONFEXME_83.tbrcED_Bloque( 6819 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6819 ).bloqfuda,
		NULL,
		'</LDC_DATOS_CLIENTE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6820 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3952' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6820 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3952' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_CONSUMOS_HIST]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6820 ).bloqcodi,
		'LDC_CONSUMOS_HIST',
		CONFEXME_83.tbrcED_Bloque( 6820 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6820 ).bloqfuda,
		'<LDC_CONSUMOS_HIST>',
		'</LDC_CONSUMOS_HIST>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6821 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3953' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6821 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3953' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DATOS_LECTURA]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6821 ).bloqcodi,
		'LDC_DATOS_LECTURA',
		CONFEXME_83.tbrcED_Bloque( 6821 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6821 ).bloqfuda,
		'<LDC_DATOS_LECTURA>',
		'</LDC_DATOS_LECTURA>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6822 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3954' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6822 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3954' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DATOS_CONSUMO]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6822 ).bloqcodi,
		'LDC_DATOS_CONSUMO',
		CONFEXME_83.tbrcED_Bloque( 6822 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6822 ).bloqfuda,
		'<LDC_DATOS_CONSUMO>',
		'</LDC_DATOS_CONSUMO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6823 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3955' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6823 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3955' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_CARGOS_SPOOL]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6823 ).bloqcodi,
		'LDC_CARGOS_SPOOL',
		CONFEXME_83.tbrcED_Bloque( 6823 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6823 ).bloqfuda,
		'<CARGOS_SPOOL>',
		'</CARGOS_SPOOL>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6824 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3956' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6824 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3956' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_RANGOS]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6824 ).bloqcodi,
		'LDC_RANGOS',
		CONFEXME_83.tbrcED_Bloque( 6824 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6824 ).bloqfuda,
		'<LDC_RANGOS>',
		'</LDC_RANGOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6825 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3957' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6825 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3957' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_RANGOS_2]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6825 ).bloqcodi,
		'LDC_RANGOS_2',
		CONFEXME_83.tbrcED_Bloque( 6825 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6825 ).bloqfuda,
		'<LDC_RANGOS_2>',
		'</LDC_RANGOS_2>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6826 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3958' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6826 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3958' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_COMPCOST]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6826 ).bloqcodi,
		'LDC_COMPCOST',
		CONFEXME_83.tbrcED_Bloque( 6826 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6826 ).bloqfuda,
		'<LDC_COMPCOST>',
		'</LDC_COMPCOST>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6827 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3959' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6827 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3959' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DATOS_MARCA]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6827 ).bloqcodi,
		'LDC_DATOS_MARCA',
		CONFEXME_83.tbrcED_Bloque( 6827 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6827 ).bloqfuda,
		'<LDC_DATOS_MARCA>',
		'</LDC_DATOS_MARCA>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6828 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3960' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6828 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3960' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [DATOS_ADICIONALES]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6828 ).bloqcodi,
		'DATOS_ADICIONALES',
		CONFEXME_83.tbrcED_Bloque( 6828 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6828 ).bloqfuda,
		'<DATOS_ADICIONALES>',
		'</DATOS_ADICIONALES>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6829 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3961' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6829 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3961' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_TASAS_CAMBIO]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6829 ).bloqcodi,
		'LDC_TASAS_CAMBIO',
		CONFEXME_83.tbrcED_Bloque( 6829 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6829 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6830 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3962' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6830 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3962' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DATOS_SPOOL]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6830 ).bloqcodi,
		'LDC_DATOS_SPOOL',
		CONFEXME_83.tbrcED_Bloque( 6830 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6830 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6831 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3963' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6831 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3963' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [PROTECCION_DATOS]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6831 ).bloqcodi,
		'PROTECCION_DATOS',
		CONFEXME_83.tbrcED_Bloque( 6831 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6831 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6832 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3964' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6832 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3964' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_ACUMTATT]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6832 ).bloqcodi,
		'LDC_ACUMTATT',
		CONFEXME_83.tbrcED_Bloque( 6832 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6832 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6833 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3965' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6833 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3965' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_FINAESPE]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6833 ).bloqcodi,
		'LDC_FINAESPE',
		CONFEXME_83.tbrcED_Bloque( 6833 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6833 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6834 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3966' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6834 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3966' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_MEDIDOR_MAL_UBIC]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6834 ).bloqcodi,
		'LDC_MEDIDOR_MAL_UBIC',
		CONFEXME_83.tbrcED_Bloque( 6834 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6834 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6835 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3967' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6835 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3967' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_IMPRIME_FACTURA]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6835 ).bloqcodi,
		'LDC_IMPRIME_FACTURA',
		CONFEXME_83.tbrcED_Bloque( 6835 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6835 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6836 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3968' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6836 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3968' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_VALOR_FECH_ULTPAGO]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6836 ).bloqcodi,
		'LDC_VALOR_FECH_ULTPAGO',
		CONFEXME_83.tbrcED_Bloque( 6836 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6836 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6837 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '3969' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6837 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '3969' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [SALDO_ANTERIOR]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6837 ).bloqcodi,
		'SALDO_ANTERIOR',
		CONFEXME_83.tbrcED_Bloque( 6837 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6837 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_83.tbrcED_Bloque( 6904 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_83.tbrcED_FuenDato.exists( '4010' ) ) then
		CONFEXME_83.tbrcED_Bloque( 6904 ).bloqfuda := CONFEXME_83.tbrcED_FuenDato( '4010' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_TOTALES]', 5 );
	INSERT INTO ED_Bloque
	(
		bloqcodi,
		bloqdesc,
		bloqtibl,
		bloqfuda,
		bloqdein,
		bloqdefi
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Bloque( 6904 ).bloqcodi,
		'LDC_TOTALES',
		CONFEXME_83.tbrcED_Bloque( 6904 ).bloqtibl,
		CONFEXME_83.tbrcED_Bloque( 6904 ).bloqfuda,
		'<LDC_TOTALES>',
		'</LDC_TOTALES>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************* Generando bloques por franja-formato *********************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4656' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6812 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6812 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrfrfo,
		2,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4657' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6813 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6813 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrfrfo,
		3,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4658' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6814 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6814 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrfrfo,
		10,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4659' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6815 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6815 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrfrfo,
		3,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4659' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6816 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6816 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrfrfo,
		4,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4658' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6817 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6817 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrfrfo,
		0,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4659' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6818 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6818 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrfrfo,
		2,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6983' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6983' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4656' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6819 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6983' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6819 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6983' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6983' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6983' ).blfrfrfo,
		4,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4657' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6820 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6820 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4657' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6821 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6821 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrfrfo,
		1,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4657' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6822 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6822 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrfrfo,
		2,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4658' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6823 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6823 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrfrfo,
		11,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4660' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6824 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6824 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrfrfo,
		0,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4660' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6825 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6825 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrfrfo,
		1,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4659' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6826 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6826 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrfrfo,
		1,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4661' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6827 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6827 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4661' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6828 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6828 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrfrfo,
		1,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6829 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6829 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrfrfo,
		0,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6830 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6830 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrfrfo,
		1,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6831 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6831 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrfrfo,
		2,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6996' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6996' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6832 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6996' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6832 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6996' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6996' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6996' ).blfrfrfo,
		3,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6997' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6997' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6833 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6997' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6833 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6997' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6997' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6997' ).blfrfrfo,
		4,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6998' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6998' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6834 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6998' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6834 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6998' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6998' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6998' ).blfrfrfo,
		5,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '6999' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '6999' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6835 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '6999' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6835 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '6999' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '6999' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '6999' ).blfrfrfo,
		6,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6836 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6836 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrfrfo,
		7,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '7001' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '7001' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4662' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6837 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '7001' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6837 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '7001' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '7001' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '7001' ).blfrfrfo,
		8,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrfrfo := CONFEXME_83.tbrcED_FranForm( '4658' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_83.tbrcED_Bloque.exists( 6904 ) ) then
		CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrbloq := CONFEXME_83.tbrcED_Bloque( 6904 ).bloqcodi;
	end if;

	INSERT INTO ED_BloqFran
	(
		blfrcodi,
		blfrbloq,
		blfrfrfo,
		blfrorde,
		blfrmult,
		blfrsait
	)
	VALUES
	(
		CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrcodi,
		CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrbloq,
		CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrfrfo,
		1,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '**************************** Generando expresiones *****************************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

	-- Registro para almacenar los datos de un expresión
	rcExpression        DAGR_Config_Expression.styGR_Config_Expression;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - Obtiene el cupo disponible de Brilla]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'nuContrato = OBTENERVALORINSTANCIA("FACTURA", "FACTSUSC");nuCupo = LDC_DETALLEFACT_GASCARIBE.FSBFORMATOCUPOBRILLA(LD_BONONBANKFINANCING.FNUGETAVALIBLEQUOTE(nuContrato))',
		49,
		'LDC - Obtiene el cupo disponible de Brilla',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_83.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_83.cuGR_Config_Expression into rcExpression;
	close CONFEXME_83.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_83.tbrcGR_Config_Expression( '121406088' ) := CONFEXME_83.rcNullExpression;
	else
		CONFEXME_83.tbrcGR_Config_Expression( '121406088' ) := rcExpression;
		CONFEXME_83.ExecuteSQLSentence( CONFEXME_83.tbrcGR_Config_Expression( '121406088' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '******************************* Generando ítems ********************************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36346' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36346' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31055' ) ) then
		CONFEXME_83.tbrcED_Item( '36346' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31055' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tipo_Noti]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36346' ).itemcodi,
		'Tipo_Noti',
		CONFEXME_83.tbrcED_Item( '36346' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36346' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36346' ).itemgren,
		NULL,
		2,
		'<TIPO_NOTI>',
		'</TIPO_NOTI>',
		CONFEXME_83.tbrcED_Item( '36346' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36347' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36347' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31056' ) ) then
		CONFEXME_83.tbrcED_Item( '36347' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31056' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Mens_Noti]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36347' ).itemcodi,
		'Mens_Noti',
		CONFEXME_83.tbrcED_Item( '36347' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36347' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36347' ).itemgren,
		NULL,
		1,
		'<MENS_NOTI>',
		'</MENS_NOTI>',
		CONFEXME_83.tbrcED_Item( '36347' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36348' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36348' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31057' ) ) then
		CONFEXME_83.tbrcED_Item( '36348' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31057' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fech_Maxima]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36348' ).itemcodi,
		'Fech_Maxima',
		CONFEXME_83.tbrcED_Item( '36348' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36348' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36348' ).itemgren,
		NULL,
		1,
		'<FECH_MAXIMA>',
		'</FECH_MAXIMA>',
		CONFEXME_83.tbrcED_Item( '36348' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36349' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36349' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31058' ) ) then
		CONFEXME_83.tbrcED_Item( '36349' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31058' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fech_Susp]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36349' ).itemcodi,
		'Fech_Susp',
		CONFEXME_83.tbrcED_Item( '36349' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36349' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36349' ).itemgren,
		NULL,
		1,
		'<FECH_SUSP>',
		'</FECH_SUSP>',
		CONFEXME_83.tbrcED_Item( '36349' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36350' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36350' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31059' ) ) then
		CONFEXME_83.tbrcED_Item( '36350' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31059' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tasa_Ultima]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36350' ).itemcodi,
		'Tasa_Ultima',
		CONFEXME_83.tbrcED_Item( '36350' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36350' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36350' ).itemgren,
		NULL,
		1,
		'<TASA_ULTIMA>',
		'</TASA_ULTIMA>',
		CONFEXME_83.tbrcED_Item( '36350' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36351' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36351' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31060' ) ) then
		CONFEXME_83.tbrcED_Item( '36351' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31060' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tasa_Promedio]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36351' ).itemcodi,
		'Tasa_Promedio',
		CONFEXME_83.tbrcED_Item( '36351' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36351' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36351' ).itemgren,
		NULL,
		1,
		'<TASA_PROMEDIO>',
		'</TASA_PROMEDIO>',
		CONFEXME_83.tbrcED_Item( '36351' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36352' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36352' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31061' ) ) then
		CONFEXME_83.tbrcED_Item( '36352' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31061' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Etiqueta]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36352' ).itemcodi,
		'Etiqueta',
		CONFEXME_83.tbrcED_Item( '36352' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36352' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36352' ).itemgren,
		NULL,
		2,
		'<ETIQUETA>',
		'</ETIQUETA>',
		CONFEXME_83.tbrcED_Item( '36352' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36353' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36353' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31062' ) ) then
		CONFEXME_83.tbrcED_Item( '36353' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31062' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Desc_Concep]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36353' ).itemcodi,
		'Desc_Concep',
		CONFEXME_83.tbrcED_Item( '36353' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36353' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36353' ).itemgren,
		NULL,
		1,
		'<DESC_CONCEP>',
		'</DESC_CONCEP>',
		CONFEXME_83.tbrcED_Item( '36353' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36354' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36354' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31063' ) ) then
		CONFEXME_83.tbrcED_Item( '36354' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31063' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Saldo_Ant]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36354' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_83.tbrcED_Item( '36354' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36354' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36354' ).itemgren,
		NULL,
		1,
		'<SALDO_ANT>',
		'</SALDO_ANT>',
		CONFEXME_83.tbrcED_Item( '36354' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36355' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36355' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31064' ) ) then
		CONFEXME_83.tbrcED_Item( '36355' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31064' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Capital]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36355' ).itemcodi,
		'Capital',
		CONFEXME_83.tbrcED_Item( '36355' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36355' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36355' ).itemgren,
		NULL,
		1,
		'<CAPITAL>',
		'</CAPITAL>',
		CONFEXME_83.tbrcED_Item( '36355' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36356' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36356' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31065' ) ) then
		CONFEXME_83.tbrcED_Item( '36356' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31065' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Interes]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36356' ).itemcodi,
		'Interes',
		CONFEXME_83.tbrcED_Item( '36356' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36356' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36356' ).itemgren,
		NULL,
		1,
		'<INTERES>',
		'</INTERES>',
		CONFEXME_83.tbrcED_Item( '36356' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36357' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36357' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31066' ) ) then
		CONFEXME_83.tbrcED_Item( '36357' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31066' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Total]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36357' ).itemcodi,
		'Total',
		CONFEXME_83.tbrcED_Item( '36357' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36357' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36357' ).itemgren,
		NULL,
		1,
		'<TOTAL>',
		'</TOTAL>',
		CONFEXME_83.tbrcED_Item( '36357' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36358' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36358' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31067' ) ) then
		CONFEXME_83.tbrcED_Item( '36358' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31067' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Saldo_Dif]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36358' ).itemcodi,
		'Saldo_Dif',
		CONFEXME_83.tbrcED_Item( '36358' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36358' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36358' ).itemgren,
		NULL,
		1,
		'<SALDO_DIF>',
		'</SALDO_DIF>',
		CONFEXME_83.tbrcED_Item( '36358' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36359' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36359' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31068' ) ) then
		CONFEXME_83.tbrcED_Item( '36359' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31068' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cuotas]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36359' ).itemcodi,
		'Cuotas',
		CONFEXME_83.tbrcED_Item( '36359' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36359' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36359' ).itemgren,
		NULL,
		2,
		'<CUOTAS>',
		'</CUOTAS>',
		CONFEXME_83.tbrcED_Item( '36359' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36360' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36360' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31069' ) ) then
		CONFEXME_83.tbrcED_Item( '36360' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31069' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Factura]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36360' ).itemcodi,
		'Factura',
		CONFEXME_83.tbrcED_Item( '36360' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36360' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36360' ).itemgren,
		NULL,
		1,
		'<FACTURA>',
		'</FACTURA>',
		CONFEXME_83.tbrcED_Item( '36360' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36361' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36361' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31070' ) ) then
		CONFEXME_83.tbrcED_Item( '36361' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31070' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fech_Fact]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36361' ).itemcodi,
		'Fech_Fact',
		CONFEXME_83.tbrcED_Item( '36361' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36361' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36361' ).itemgren,
		NULL,
		1,
		'<FECH_FACT>',
		'</FECH_FACT>',
		CONFEXME_83.tbrcED_Item( '36361' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36362' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36362' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31071' ) ) then
		CONFEXME_83.tbrcED_Item( '36362' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31071' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Mes_Fact]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36362' ).itemcodi,
		'Mes_Fact',
		CONFEXME_83.tbrcED_Item( '36362' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36362' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36362' ).itemgren,
		NULL,
		1,
		'<MES_FACT>',
		'</MES_FACT>',
		CONFEXME_83.tbrcED_Item( '36362' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36363' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36363' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31072' ) ) then
		CONFEXME_83.tbrcED_Item( '36363' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31072' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Periodo_Fact]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36363' ).itemcodi,
		'Periodo_Fact',
		CONFEXME_83.tbrcED_Item( '36363' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36363' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36363' ).itemgren,
		NULL,
		1,
		'<PERIODO_FACT>',
		'</PERIODO_FACT>',
		CONFEXME_83.tbrcED_Item( '36363' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36364' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36364' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31073' ) ) then
		CONFEXME_83.tbrcED_Item( '36364' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31073' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Pago_Hasta]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36364' ).itemcodi,
		'Pago_Hasta',
		CONFEXME_83.tbrcED_Item( '36364' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36364' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36364' ).itemgren,
		NULL,
		1,
		'<PAGO_HASTA>',
		'</PAGO_HASTA>',
		CONFEXME_83.tbrcED_Item( '36364' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36365' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36365' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31075' ) ) then
		CONFEXME_83.tbrcED_Item( '36365' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31075' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Contrato]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36365' ).itemcodi,
		'Contrato',
		CONFEXME_83.tbrcED_Item( '36365' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36365' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36365' ).itemgren,
		NULL,
		1,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_83.tbrcED_Item( '36365' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36366' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36366' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31076' ) ) then
		CONFEXME_83.tbrcED_Item( '36366' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31076' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cupon]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36366' ).itemcodi,
		'Cupon',
		CONFEXME_83.tbrcED_Item( '36366' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36366' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36366' ).itemgren,
		NULL,
		1,
		'<CUPON>',
		'</CUPON>',
		CONFEXME_83.tbrcED_Item( '36366' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36367' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36367' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31077' ) ) then
		CONFEXME_83.tbrcED_Item( '36367' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31077' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nombre]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36367' ).itemcodi,
		'Nombre',
		CONFEXME_83.tbrcED_Item( '36367' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36367' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36367' ).itemgren,
		NULL,
		1,
		'<NOMBRE>',
		'</NOMBRE>',
		CONFEXME_83.tbrcED_Item( '36367' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36368' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36368' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31078' ) ) then
		CONFEXME_83.tbrcED_Item( '36368' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31078' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Direccion_Cobro]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36368' ).itemcodi,
		'Direccion_Cobro',
		CONFEXME_83.tbrcED_Item( '36368' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36368' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36368' ).itemgren,
		NULL,
		1,
		'<DIRECCION_COBRO>',
		'</DIRECCION_COBRO>',
		CONFEXME_83.tbrcED_Item( '36368' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36369' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36369' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31079' ) ) then
		CONFEXME_83.tbrcED_Item( '36369' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31079' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Localidad]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36369' ).itemcodi,
		'Localidad',
		CONFEXME_83.tbrcED_Item( '36369' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36369' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36369' ).itemgren,
		NULL,
		1,
		'<LOCALIDAD>',
		'</LOCALIDAD>',
		CONFEXME_83.tbrcED_Item( '36369' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36370' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36370' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31087' ) ) then
		CONFEXME_83.tbrcED_Item( '36370' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31087' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Saldo_Favor]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36370' ).itemcodi,
		'Saldo_Favor',
		CONFEXME_83.tbrcED_Item( '36370' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36370' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36370' ).itemgren,
		NULL,
		1,
		'<SALDO_FAVOR>',
		'</SALDO_FAVOR>',
		CONFEXME_83.tbrcED_Item( '36370' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36371' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36371' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31088' ) ) then
		CONFEXME_83.tbrcED_Item( '36371' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31088' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Saldo_Ant]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36371' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_83.tbrcED_Item( '36371' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36371' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36371' ).itemgren,
		NULL,
		1,
		'<SALDO_ANT>',
		'</SALDO_ANT>',
		CONFEXME_83.tbrcED_Item( '36371' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36372' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36372' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31091' ) ) then
		CONFEXME_83.tbrcED_Item( '36372' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31091' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Total_Factura]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36372' ).itemcodi,
		'Total_Factura',
		CONFEXME_83.tbrcED_Item( '36372' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36372' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36372' ).itemgren,
		NULL,
		1,
		'<TOTAL_FACTURA>',
		'</TOTAL_FACTURA>',
		CONFEXME_83.tbrcED_Item( '36372' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36373' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36373' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31092' ) ) then
		CONFEXME_83.tbrcED_Item( '36373' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31092' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Pago_Sin_Recargo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36373' ).itemcodi,
		'Pago_Sin_Recargo',
		CONFEXME_83.tbrcED_Item( '36373' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36373' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36373' ).itemgren,
		NULL,
		1,
		'<PAGO_SIN_RECARGO>',
		'</PAGO_SIN_RECARGO>',
		CONFEXME_83.tbrcED_Item( '36373' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36374' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36374' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31093' ) ) then
		CONFEXME_83.tbrcED_Item( '36374' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31093' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Condicion_Pago]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36374' ).itemcodi,
		'Condicion_Pago',
		CONFEXME_83.tbrcED_Item( '36374' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36374' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36374' ).itemgren,
		NULL,
		1,
		'<CONDICION_PAGO>',
		'</CONDICION_PAGO>',
		CONFEXME_83.tbrcED_Item( '36374' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36375' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36375' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31094' ) ) then
		CONFEXME_83.tbrcED_Item( '36375' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31094' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Identifica]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36375' ).itemcodi,
		'Identifica',
		CONFEXME_83.tbrcED_Item( '36375' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36375' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36375' ).itemgren,
		NULL,
		1,
		'<IDENTIFICA>',
		'</IDENTIFICA>',
		CONFEXME_83.tbrcED_Item( '36375' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36376' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36376' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31095' ) ) then
		CONFEXME_83.tbrcED_Item( '36376' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31095' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tipo de producto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36376' ).itemcodi,
		'Tipo de producto',
		CONFEXME_83.tbrcED_Item( '36376' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36376' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36376' ).itemgren,
		NULL,
		1,
		'<TIPOPRODUCTO>',
		'</TIPOPRODUCTO>',
		CONFEXME_83.tbrcED_Item( '36376' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36377' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36377' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31096' ) ) then
		CONFEXME_83.tbrcED_Item( '36377' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31096' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Codigo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36377' ).itemcodi,
		'Codigo',
		CONFEXME_83.tbrcED_Item( '36377' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36377' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36377' ).itemgren,
		NULL,
		1,
		'<CODE>',
		'</CODE>',
		CONFEXME_83.tbrcED_Item( '36377' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36378' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36378' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31097' ) ) then
		CONFEXME_83.tbrcED_Item( '36378' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31097' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Image]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36378' ).itemcodi,
		'Image',
		CONFEXME_83.tbrcED_Item( '36378' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36378' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36378' ).itemgren,
		NULL,
		1,
		'<IMAGE>',
		'</IMAGE>',
		CONFEXME_83.tbrcED_Item( '36378' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36379' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36379' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31102' ) ) then
		CONFEXME_83.tbrcED_Item( '36379' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31102' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Codigo_Barras]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36379' ).itemcodi,
		'Codigo_Barras',
		CONFEXME_83.tbrcED_Item( '36379' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36379' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36379' ).itemgren,
		NULL,
		1,
		'<COD_BAR>',
		'</COD_BAR>',
		CONFEXME_83.tbrcED_Item( '36379' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36380' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36380' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31104' ) ) then
		CONFEXME_83.tbrcED_Item( '36380' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31104' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Iva]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36380' ).itemcodi,
		'Iva',
		CONFEXME_83.tbrcED_Item( '36380' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36380' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36380' ).itemgren,
		NULL,
		1,
		'<IVA>',
		'</IVA>',
		CONFEXME_83.tbrcED_Item( '36380' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36381' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36381' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31105' ) ) then
		CONFEXME_83.tbrcED_Item( '36381' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31105' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Subtotal]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36381' ).itemcodi,
		'Subtotal',
		CONFEXME_83.tbrcED_Item( '36381' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36381' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36381' ).itemgren,
		NULL,
		1,
		'<SUBTOTAL>',
		'</SUBTOTAL>',
		CONFEXME_83.tbrcED_Item( '36381' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36382' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36382' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31106' ) ) then
		CONFEXME_83.tbrcED_Item( '36382' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31106' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cargosmes]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36382' ).itemcodi,
		'Cargosmes',
		CONFEXME_83.tbrcED_Item( '36382' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36382' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36382' ).itemgren,
		NULL,
		1,
		'<CARGOSMES>',
		'</CARGOSMES>',
		CONFEXME_83.tbrcED_Item( '36382' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36383' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36383' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31074' ) ) then
		CONFEXME_83.tbrcED_Item( '36383' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31074' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Dias_Consumo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36383' ).itemcodi,
		'Dias_Consumo',
		CONFEXME_83.tbrcED_Item( '36383' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36383' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36383' ).itemgren,
		NULL,
		1,
		'<DIAS_CONSUMO>',
		'</DIAS_CONSUMO>',
		CONFEXME_83.tbrcED_Item( '36383' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36384' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36384' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31080' ) ) then
		CONFEXME_83.tbrcED_Item( '36384' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31080' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Categoria]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36384' ).itemcodi,
		'Categoria',
		CONFEXME_83.tbrcED_Item( '36384' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36384' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36384' ).itemgren,
		NULL,
		1,
		'<CATEGORIA>',
		'</CATEGORIA>',
		CONFEXME_83.tbrcED_Item( '36384' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36385' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36385' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31081' ) ) then
		CONFEXME_83.tbrcED_Item( '36385' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31081' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Estrato]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36385' ).itemcodi,
		'Estrato',
		CONFEXME_83.tbrcED_Item( '36385' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36385' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36385' ).itemgren,
		NULL,
		1,
		'<ESTRATO>',
		'</ESTRATO>',
		CONFEXME_83.tbrcED_Item( '36385' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36386' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36386' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31082' ) ) then
		CONFEXME_83.tbrcED_Item( '36386' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31082' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Ciclo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36386' ).itemcodi,
		'Ciclo',
		CONFEXME_83.tbrcED_Item( '36386' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36386' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36386' ).itemgren,
		NULL,
		1,
		'<CICLO>',
		'</CICLO>',
		CONFEXME_83.tbrcED_Item( '36386' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36387' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36387' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31083' ) ) then
		CONFEXME_83.tbrcED_Item( '36387' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31083' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Ruta]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36387' ).itemcodi,
		'Ruta',
		CONFEXME_83.tbrcED_Item( '36387' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36387' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36387' ).itemgren,
		NULL,
		1,
		'<RUTA>',
		'</RUTA>',
		CONFEXME_83.tbrcED_Item( '36387' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36388' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36388' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31084' ) ) then
		CONFEXME_83.tbrcED_Item( '36388' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31084' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Meses_Deuda]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36388' ).itemcodi,
		'Meses_Deuda',
		CONFEXME_83.tbrcED_Item( '36388' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36388' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36388' ).itemgren,
		NULL,
		2,
		'<MESES_DEUDA>',
		'</MESES_DEUDA>',
		CONFEXME_83.tbrcED_Item( '36388' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36389' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36389' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31085' ) ) then
		CONFEXME_83.tbrcED_Item( '36389' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31085' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Num_Control]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36389' ).itemcodi,
		'Num_Control',
		CONFEXME_83.tbrcED_Item( '36389' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36389' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36389' ).itemgren,
		NULL,
		1,
		'<NUM_CONTROL>',
		'</NUM_CONTROL>',
		CONFEXME_83.tbrcED_Item( '36389' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36390' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36390' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31086' ) ) then
		CONFEXME_83.tbrcED_Item( '36390' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31086' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Periodo_Consumo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36390' ).itemcodi,
		'Periodo_Consumo',
		CONFEXME_83.tbrcED_Item( '36390' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36390' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36390' ).itemgren,
		NULL,
		1,
		'<PERIODO_CONSUMO>',
		'</PERIODO_CONSUMO>',
		CONFEXME_83.tbrcED_Item( '36390' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36391' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36391' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31089' ) ) then
		CONFEXME_83.tbrcED_Item( '36391' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31089' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Suspension]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36391' ).itemcodi,
		'Fecha_Suspension',
		CONFEXME_83.tbrcED_Item( '36391' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36391' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36391' ).itemgren,
		NULL,
		1,
		'<FECHA_SUSPENSION>',
		'</FECHA_SUSPENSION>',
		CONFEXME_83.tbrcED_Item( '36391' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36392' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36392' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31090' ) ) then
		CONFEXME_83.tbrcED_Item( '36392' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31090' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Recl]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36392' ).itemcodi,
		'Valor_Recl',
		CONFEXME_83.tbrcED_Item( '36392' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36392' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36392' ).itemgren,
		NULL,
		2,
		'<VALOR_RECL>',
		'</VALOR_RECL>',
		CONFEXME_83.tbrcED_Item( '36392' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36393' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36393' ).itemobna := 'GCFIFA_CT49E121406088';

	-- Se asigna la expresión del item
	if ( CONFEXME_83.tbrcGR_Config_Expression.exists( '121406088' ) ) then
		CONFEXME_83.tbrcED_Item( '36393' ).itemobna := CONFEXME_83.tbrcGR_Config_Expression( '121406088' ).object_name;
		CONFEXME_83.tbrcED_Item( '36393' ).itemceid := CONFEXME_83.tbrcGR_Config_Expression( '121406088' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [CUPO_BRILLA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36393' ).itemcodi,
		'CUPO_BRILLA',
		CONFEXME_83.tbrcED_Item( '36393' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36393' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36393' ).itemgren,
		NULL,
		NULL,
		'<CUPO_BRILLA>',
		'</CUPO_BRILLA>',
		CONFEXME_83.tbrcED_Item( '36393' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36394' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36394' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31108' ) ) then
		CONFEXME_83.tbrcED_Item( '36394' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31108' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Mes]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36394' ).itemcodi,
		'Consumo_Mes',
		CONFEXME_83.tbrcED_Item( '36394' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36394' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36394' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES>',
		'</CONSUMO_MES>',
		CONFEXME_83.tbrcED_Item( '36394' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36395' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36395' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31109' ) ) then
		CONFEXME_83.tbrcED_Item( '36395' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31109' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Cons_Mes]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36395' ).itemcodi,
		'Fecha_Cons_Mes',
		CONFEXME_83.tbrcED_Item( '36395' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36395' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36395' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES>',
		'</FECHA_CONS_MES>',
		CONFEXME_83.tbrcED_Item( '36395' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36396' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36396' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31110' ) ) then
		CONFEXME_83.tbrcED_Item( '36396' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31110' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Num_Medidor]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36396' ).itemcodi,
		'Num_Medidor',
		CONFEXME_83.tbrcED_Item( '36396' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36396' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36396' ).itemgren,
		NULL,
		1,
		'<NUM_MEDIDOR>',
		'</NUM_MEDIDOR>',
		CONFEXME_83.tbrcED_Item( '36396' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36397' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36397' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31111' ) ) then
		CONFEXME_83.tbrcED_Item( '36397' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31111' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lectura_Anterior]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36397' ).itemcodi,
		'Lectura_Anterior',
		CONFEXME_83.tbrcED_Item( '36397' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36397' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36397' ).itemgren,
		NULL,
		1,
		'<LECTURA_ANTERIOR>',
		'</LECTURA_ANTERIOR>',
		CONFEXME_83.tbrcED_Item( '36397' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36398' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36398' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31112' ) ) then
		CONFEXME_83.tbrcED_Item( '36398' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31112' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lectura_Actual]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36398' ).itemcodi,
		'Lectura_Actual',
		CONFEXME_83.tbrcED_Item( '36398' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36398' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36398' ).itemgren,
		NULL,
		1,
		'<LECTURA_ACTUAL>',
		'</LECTURA_ACTUAL>',
		CONFEXME_83.tbrcED_Item( '36398' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36399' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36399' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31113' ) ) then
		CONFEXME_83.tbrcED_Item( '36399' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31113' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Obs_Lectura]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36399' ).itemcodi,
		'Obs_Lectura',
		CONFEXME_83.tbrcED_Item( '36399' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36399' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36399' ).itemgren,
		NULL,
		1,
		'<OBS_LECTURA>',
		'</OBS_LECTURA>',
		CONFEXME_83.tbrcED_Item( '36399' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36400' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36400' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31114' ) ) then
		CONFEXME_83.tbrcED_Item( '36400' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31114' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cons_Correg]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36400' ).itemcodi,
		'Cons_Correg',
		CONFEXME_83.tbrcED_Item( '36400' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36400' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36400' ).itemgren,
		NULL,
		1,
		'<CONS_CORREG>',
		'</CONS_CORREG>',
		CONFEXME_83.tbrcED_Item( '36400' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36401' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36401' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31115' ) ) then
		CONFEXME_83.tbrcED_Item( '36401' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31115' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Factor_Correccion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36401' ).itemcodi,
		'Factor_Correccion',
		CONFEXME_83.tbrcED_Item( '36401' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36401' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36401' ).itemgren,
		NULL,
		1,
		'<FACTOR_CORRECCION>',
		'</FACTOR_CORRECCION>',
		CONFEXME_83.tbrcED_Item( '36401' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36402' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36402' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31116' ) ) then
		CONFEXME_83.tbrcED_Item( '36402' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31116' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Mes_1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36402' ).itemcodi,
		'Consumo_Mes_1',
		CONFEXME_83.tbrcED_Item( '36402' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36402' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36402' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_1>',
		'</CONSUMO_MES_1>',
		CONFEXME_83.tbrcED_Item( '36402' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36403' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36403' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31117' ) ) then
		CONFEXME_83.tbrcED_Item( '36403' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31117' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Cons_Mes_1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36403' ).itemcodi,
		'Fecha_Cons_Mes_1',
		CONFEXME_83.tbrcED_Item( '36403' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36403' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36403' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_1>',
		'</FECHA_CONS_MES_1>',
		CONFEXME_83.tbrcED_Item( '36403' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36404' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36404' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31118' ) ) then
		CONFEXME_83.tbrcED_Item( '36404' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31118' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Mes_2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36404' ).itemcodi,
		'Consumo_Mes_2',
		CONFEXME_83.tbrcED_Item( '36404' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36404' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36404' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_2>',
		'</CONSUMO_MES_2>',
		CONFEXME_83.tbrcED_Item( '36404' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36405' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36405' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31119' ) ) then
		CONFEXME_83.tbrcED_Item( '36405' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31119' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Cons_Mes_2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36405' ).itemcodi,
		'Fecha_Cons_Mes_2',
		CONFEXME_83.tbrcED_Item( '36405' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36405' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36405' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_2>',
		'</FECHA_CONS_MES_2>',
		CONFEXME_83.tbrcED_Item( '36405' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36406' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36406' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31120' ) ) then
		CONFEXME_83.tbrcED_Item( '36406' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31120' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Mes_3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36406' ).itemcodi,
		'Consumo_Mes_3',
		CONFEXME_83.tbrcED_Item( '36406' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36406' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36406' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_3>',
		'</CONSUMO_MES_3>',
		CONFEXME_83.tbrcED_Item( '36406' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36407' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36407' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31121' ) ) then
		CONFEXME_83.tbrcED_Item( '36407' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31121' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Cons_Mes_3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36407' ).itemcodi,
		'Fecha_Cons_Mes_3',
		CONFEXME_83.tbrcED_Item( '36407' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36407' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36407' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_3>',
		'</FECHA_CONS_MES_3>',
		CONFEXME_83.tbrcED_Item( '36407' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36408' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36408' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31122' ) ) then
		CONFEXME_83.tbrcED_Item( '36408' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31122' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Mes_4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36408' ).itemcodi,
		'Consumo_Mes_4',
		CONFEXME_83.tbrcED_Item( '36408' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36408' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36408' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_4>',
		'</CONSUMO_MES_4>',
		CONFEXME_83.tbrcED_Item( '36408' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36409' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36409' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31123' ) ) then
		CONFEXME_83.tbrcED_Item( '36409' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31123' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Cons_Mes_4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36409' ).itemcodi,
		'Fecha_Cons_Mes_4',
		CONFEXME_83.tbrcED_Item( '36409' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36409' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36409' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_4>',
		'</FECHA_CONS_MES_4>',
		CONFEXME_83.tbrcED_Item( '36409' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36410' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36410' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31124' ) ) then
		CONFEXME_83.tbrcED_Item( '36410' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31124' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Mes_5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36410' ).itemcodi,
		'Consumo_Mes_5',
		CONFEXME_83.tbrcED_Item( '36410' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36410' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36410' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_5>',
		'</CONSUMO_MES_5>',
		CONFEXME_83.tbrcED_Item( '36410' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36411' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36411' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31125' ) ) then
		CONFEXME_83.tbrcED_Item( '36411' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31125' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Cons_Mes_5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36411' ).itemcodi,
		'Fecha_Cons_Mes_5',
		CONFEXME_83.tbrcED_Item( '36411' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36411' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36411' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_5>',
		'</FECHA_CONS_MES_5>',
		CONFEXME_83.tbrcED_Item( '36411' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36412' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36412' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31126' ) ) then
		CONFEXME_83.tbrcED_Item( '36412' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31126' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Mes_6]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36412' ).itemcodi,
		'Consumo_Mes_6',
		CONFEXME_83.tbrcED_Item( '36412' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36412' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36412' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_6>',
		'</CONSUMO_MES_6>',
		CONFEXME_83.tbrcED_Item( '36412' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36413' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36413' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31127' ) ) then
		CONFEXME_83.tbrcED_Item( '36413' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31127' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Cons_Mes_6]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36413' ).itemcodi,
		'Fecha_Cons_Mes_6',
		CONFEXME_83.tbrcED_Item( '36413' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36413' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36413' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_6>',
		'</FECHA_CONS_MES_6>',
		CONFEXME_83.tbrcED_Item( '36413' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36414' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36414' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31128' ) ) then
		CONFEXME_83.tbrcED_Item( '36414' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31128' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo_Promedio]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36414' ).itemcodi,
		'Consumo_Promedio',
		CONFEXME_83.tbrcED_Item( '36414' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36414' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36414' ).itemgren,
		NULL,
		1,
		'<CONSUMO_PROMEDIO>',
		'</CONSUMO_PROMEDIO>',
		CONFEXME_83.tbrcED_Item( '36414' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36415' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36415' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31129' ) ) then
		CONFEXME_83.tbrcED_Item( '36415' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31129' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Temperatura]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36415' ).itemcodi,
		'Temperatura',
		CONFEXME_83.tbrcED_Item( '36415' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36415' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36415' ).itemgren,
		NULL,
		1,
		'<TEMPERATURA>',
		'</TEMPERATURA>',
		CONFEXME_83.tbrcED_Item( '36415' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36416' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36416' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31130' ) ) then
		CONFEXME_83.tbrcED_Item( '36416' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31130' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Presion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36416' ).itemcodi,
		'Presion',
		CONFEXME_83.tbrcED_Item( '36416' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36416' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36416' ).itemgren,
		NULL,
		1,
		'<PRESION>',
		'</PRESION>',
		CONFEXME_83.tbrcED_Item( '36416' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36417' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36417' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31131' ) ) then
		CONFEXME_83.tbrcED_Item( '36417' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31131' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Equival_Kwh]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36417' ).itemcodi,
		'Equival_Kwh',
		CONFEXME_83.tbrcED_Item( '36417' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36417' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36417' ).itemgren,
		NULL,
		1,
		'<EQUIVAL_KWH>',
		'</EQUIVAL_KWH>',
		CONFEXME_83.tbrcED_Item( '36417' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36418' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36418' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31132' ) ) then
		CONFEXME_83.tbrcED_Item( '36418' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31132' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Calculo_Cons]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36418' ).itemcodi,
		'Calculo_Cons',
		CONFEXME_83.tbrcED_Item( '36418' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36418' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36418' ).itemgren,
		NULL,
		1,
		'<CALCULO_CONS>',
		'</CALCULO_CONS>',
		CONFEXME_83.tbrcED_Item( '36418' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36419' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36419' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31103' ) ) then
		CONFEXME_83.tbrcED_Item( '36419' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31103' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Total]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36419' ).itemcodi,
		'Total',
		CONFEXME_83.tbrcED_Item( '36419' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36419' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36419' ).itemgren,
		NULL,
		1,
		'<TOTAL>',
		'</TOTAL>',
		CONFEXME_83.tbrcED_Item( '36419' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36420' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36420' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31107' ) ) then
		CONFEXME_83.tbrcED_Item( '36420' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31107' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cantidad_Conc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36420' ).itemcodi,
		'Cantidad_Conc',
		CONFEXME_83.tbrcED_Item( '36420' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36420' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36420' ).itemgren,
		NULL,
		2,
		'<CANTIDAD_CONC>',
		'</CANTIDAD_CONC>',
		CONFEXME_83.tbrcED_Item( '36420' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36421' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36421' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31133' ) ) then
		CONFEXME_83.tbrcED_Item( '36421' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31133' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Etiqueta]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36421' ).itemcodi,
		'Etiqueta',
		CONFEXME_83.tbrcED_Item( '36421' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36421' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36421' ).itemgren,
		NULL,
		2,
		'<ETIQUETA>',
		'</ETIQUETA>',
		CONFEXME_83.tbrcED_Item( '36421' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36422' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36422' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31134' ) ) then
		CONFEXME_83.tbrcED_Item( '36422' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31134' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Concepto_Id]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36422' ).itemcodi,
		'Concepto_Id',
		CONFEXME_83.tbrcED_Item( '36422' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36422' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36422' ).itemgren,
		NULL,
		1,
		'<CONCEPTO_ID>',
		'</CONCEPTO_ID>',
		CONFEXME_83.tbrcED_Item( '36422' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36423' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36423' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31135' ) ) then
		CONFEXME_83.tbrcED_Item( '36423' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31135' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Desc_Concep]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36423' ).itemcodi,
		'Desc_Concep',
		CONFEXME_83.tbrcED_Item( '36423' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36423' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36423' ).itemgren,
		NULL,
		1,
		'<DESC_CONCEP>',
		'</DESC_CONCEP>',
		CONFEXME_83.tbrcED_Item( '36423' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36424' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36424' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31136' ) ) then
		CONFEXME_83.tbrcED_Item( '36424' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31136' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Saldo_Ant]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36424' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_83.tbrcED_Item( '36424' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36424' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36424' ).itemgren,
		NULL,
		1,
		'<SALDO_ANT>',
		'</SALDO_ANT>',
		CONFEXME_83.tbrcED_Item( '36424' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36425' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36425' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31137' ) ) then
		CONFEXME_83.tbrcED_Item( '36425' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31137' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Capital]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36425' ).itemcodi,
		'Capital',
		CONFEXME_83.tbrcED_Item( '36425' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36425' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36425' ).itemgren,
		NULL,
		1,
		'<CAPITAL>',
		'</CAPITAL>',
		CONFEXME_83.tbrcED_Item( '36425' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36426' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36426' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31138' ) ) then
		CONFEXME_83.tbrcED_Item( '36426' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31138' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Interes]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36426' ).itemcodi,
		'Interes',
		CONFEXME_83.tbrcED_Item( '36426' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36426' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36426' ).itemgren,
		NULL,
		1,
		'<INTERES>',
		'</INTERES>',
		CONFEXME_83.tbrcED_Item( '36426' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36427' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36427' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31139' ) ) then
		CONFEXME_83.tbrcED_Item( '36427' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31139' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Total]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36427' ).itemcodi,
		'Total',
		CONFEXME_83.tbrcED_Item( '36427' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36427' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36427' ).itemgren,
		NULL,
		1,
		'<TOTAL>',
		'</TOTAL>',
		CONFEXME_83.tbrcED_Item( '36427' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36428' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36428' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31140' ) ) then
		CONFEXME_83.tbrcED_Item( '36428' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31140' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Saldo_Dif]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36428' ).itemcodi,
		'Saldo_Dif',
		CONFEXME_83.tbrcED_Item( '36428' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36428' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36428' ).itemgren,
		NULL,
		1,
		'<SALDO_DIF>',
		'</SALDO_DIF>',
		CONFEXME_83.tbrcED_Item( '36428' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36429' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36429' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31141' ) ) then
		CONFEXME_83.tbrcED_Item( '36429' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31141' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Unidad_Items]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36429' ).itemcodi,
		'Unidad_Items',
		CONFEXME_83.tbrcED_Item( '36429' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36429' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36429' ).itemgren,
		NULL,
		1,
		'<UNIDAD_ITEMS>',
		'</UNIDAD_ITEMS>',
		CONFEXME_83.tbrcED_Item( '36429' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36430' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36430' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31142' ) ) then
		CONFEXME_83.tbrcED_Item( '36430' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31142' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cantidad]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36430' ).itemcodi,
		'Cantidad',
		CONFEXME_83.tbrcED_Item( '36430' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36430' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36430' ).itemgren,
		NULL,
		1,
		'<CANTIDAD>',
		'</CANTIDAD>',
		CONFEXME_83.tbrcED_Item( '36430' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36431' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36431' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31143' ) ) then
		CONFEXME_83.tbrcED_Item( '36431' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31143' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unitario]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36431' ).itemcodi,
		'Valor_Unitario',
		CONFEXME_83.tbrcED_Item( '36431' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36431' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36431' ).itemgren,
		NULL,
		1,
		'<VALOR_UNITARIO>',
		'</VALOR_UNITARIO>',
		CONFEXME_83.tbrcED_Item( '36431' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36432' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36432' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31144' ) ) then
		CONFEXME_83.tbrcED_Item( '36432' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31144' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Iva]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36432' ).itemcodi,
		'Valor_Iva',
		CONFEXME_83.tbrcED_Item( '36432' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36432' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36432' ).itemgren,
		NULL,
		1,
		'<VALOR_IVA>',
		'</VALOR_IVA>',
		CONFEXME_83.tbrcED_Item( '36432' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36433' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36433' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31145' ) ) then
		CONFEXME_83.tbrcED_Item( '36433' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31145' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cuotas]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36433' ).itemcodi,
		'Cuotas',
		CONFEXME_83.tbrcED_Item( '36433' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36433' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36433' ).itemgren,
		NULL,
		1,
		'<CUOTAS>',
		'</CUOTAS>',
		CONFEXME_83.tbrcED_Item( '36433' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36434' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36434' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31146' ) ) then
		CONFEXME_83.tbrcED_Item( '36434' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31146' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36434' ).itemcodi,
		'Lim_Inferior',
		CONFEXME_83.tbrcED_Item( '36434' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36434' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36434' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR>',
		'</LIM_INFERIOR>',
		CONFEXME_83.tbrcED_Item( '36434' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36435' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36435' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31147' ) ) then
		CONFEXME_83.tbrcED_Item( '36435' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31147' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36435' ).itemcodi,
		'Lim_Superior',
		CONFEXME_83.tbrcED_Item( '36435' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36435' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36435' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR>',
		'</LIM_SUPERIOR>',
		CONFEXME_83.tbrcED_Item( '36435' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36436' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36436' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31148' ) ) then
		CONFEXME_83.tbrcED_Item( '36436' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31148' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36436' ).itemcodi,
		'Valor_Unidad',
		CONFEXME_83.tbrcED_Item( '36436' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36436' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36436' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD>',
		'</VALOR_UNIDAD>',
		CONFEXME_83.tbrcED_Item( '36436' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36437' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36437' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31149' ) ) then
		CONFEXME_83.tbrcED_Item( '36437' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31149' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36437' ).itemcodi,
		'Consumo',
		CONFEXME_83.tbrcED_Item( '36437' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36437' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36437' ).itemgren,
		NULL,
		1,
		'<CONSUMO>',
		'</CONSUMO>',
		CONFEXME_83.tbrcED_Item( '36437' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36438' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36438' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31150' ) ) then
		CONFEXME_83.tbrcED_Item( '36438' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31150' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36438' ).itemcodi,
		'Val_Consumo',
		CONFEXME_83.tbrcED_Item( '36438' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36438' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36438' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO>',
		'</VAL_CONSUMO>',
		CONFEXME_83.tbrcED_Item( '36438' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36439' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36439' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31151' ) ) then
		CONFEXME_83.tbrcED_Item( '36439' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31151' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36439' ).itemcodi,
		'Lim_Inferior1',
		CONFEXME_83.tbrcED_Item( '36439' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36439' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36439' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR1>',
		'</LIM_INFERIOR1>',
		CONFEXME_83.tbrcED_Item( '36439' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36440' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36440' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31152' ) ) then
		CONFEXME_83.tbrcED_Item( '36440' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31152' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36440' ).itemcodi,
		'Lim_Superior1',
		CONFEXME_83.tbrcED_Item( '36440' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36440' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36440' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR1>',
		'</LIM_SUPERIOR1>',
		CONFEXME_83.tbrcED_Item( '36440' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36441' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36441' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31153' ) ) then
		CONFEXME_83.tbrcED_Item( '36441' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31153' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36441' ).itemcodi,
		'Valor_Unidad1',
		CONFEXME_83.tbrcED_Item( '36441' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36441' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36441' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD1>',
		'</VALOR_UNIDAD1>',
		CONFEXME_83.tbrcED_Item( '36441' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36442' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36442' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31154' ) ) then
		CONFEXME_83.tbrcED_Item( '36442' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31154' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36442' ).itemcodi,
		'Consumo1',
		CONFEXME_83.tbrcED_Item( '36442' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36442' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36442' ).itemgren,
		NULL,
		1,
		'<CONSUMO1>',
		'</CONSUMO1>',
		CONFEXME_83.tbrcED_Item( '36442' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36443' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36443' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31155' ) ) then
		CONFEXME_83.tbrcED_Item( '36443' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31155' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36443' ).itemcodi,
		'Val_Consumo1',
		CONFEXME_83.tbrcED_Item( '36443' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36443' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36443' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO1>',
		'</VAL_CONSUMO1>',
		CONFEXME_83.tbrcED_Item( '36443' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36444' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36444' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31156' ) ) then
		CONFEXME_83.tbrcED_Item( '36444' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31156' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36444' ).itemcodi,
		'Lim_Inferior2',
		CONFEXME_83.tbrcED_Item( '36444' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36444' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36444' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR2>',
		'</LIM_INFERIOR2>',
		CONFEXME_83.tbrcED_Item( '36444' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36445' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36445' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31157' ) ) then
		CONFEXME_83.tbrcED_Item( '36445' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31157' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36445' ).itemcodi,
		'Lim_Superior2',
		CONFEXME_83.tbrcED_Item( '36445' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36445' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36445' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR2>',
		'</LIM_SUPERIOR2>',
		CONFEXME_83.tbrcED_Item( '36445' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36446' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36446' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31158' ) ) then
		CONFEXME_83.tbrcED_Item( '36446' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31158' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36446' ).itemcodi,
		'Valor_Unidad2',
		CONFEXME_83.tbrcED_Item( '36446' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36446' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36446' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD2>',
		'</VALOR_UNIDAD2>',
		CONFEXME_83.tbrcED_Item( '36446' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36447' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36447' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31159' ) ) then
		CONFEXME_83.tbrcED_Item( '36447' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31159' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36447' ).itemcodi,
		'Consumo2',
		CONFEXME_83.tbrcED_Item( '36447' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36447' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36447' ).itemgren,
		NULL,
		1,
		'<CONSUMO2>',
		'</CONSUMO2>',
		CONFEXME_83.tbrcED_Item( '36447' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36448' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36448' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31160' ) ) then
		CONFEXME_83.tbrcED_Item( '36448' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31160' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36448' ).itemcodi,
		'Val_Consumo2',
		CONFEXME_83.tbrcED_Item( '36448' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36448' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36448' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO2>',
		'</VAL_CONSUMO2>',
		CONFEXME_83.tbrcED_Item( '36448' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36449' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36449' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31161' ) ) then
		CONFEXME_83.tbrcED_Item( '36449' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31161' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36449' ).itemcodi,
		'Lim_Inferior3',
		CONFEXME_83.tbrcED_Item( '36449' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36449' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36449' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR3>',
		'</LIM_INFERIOR3>',
		CONFEXME_83.tbrcED_Item( '36449' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36450' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36450' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31162' ) ) then
		CONFEXME_83.tbrcED_Item( '36450' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31162' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36450' ).itemcodi,
		'Lim_Superior3',
		CONFEXME_83.tbrcED_Item( '36450' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36450' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36450' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR3>',
		'</LIM_SUPERIOR3>',
		CONFEXME_83.tbrcED_Item( '36450' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36451' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36451' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31163' ) ) then
		CONFEXME_83.tbrcED_Item( '36451' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31163' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36451' ).itemcodi,
		'Valor_Unidad3',
		CONFEXME_83.tbrcED_Item( '36451' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36451' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36451' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD3>',
		'</VALOR_UNIDAD3>',
		CONFEXME_83.tbrcED_Item( '36451' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36452' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36452' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31164' ) ) then
		CONFEXME_83.tbrcED_Item( '36452' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31164' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36452' ).itemcodi,
		'Consumo3',
		CONFEXME_83.tbrcED_Item( '36452' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36452' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36452' ).itemgren,
		NULL,
		1,
		'<CONSUMO3>',
		'</CONSUMO3>',
		CONFEXME_83.tbrcED_Item( '36452' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36453' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36453' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31165' ) ) then
		CONFEXME_83.tbrcED_Item( '36453' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31165' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36453' ).itemcodi,
		'Val_Consumo3',
		CONFEXME_83.tbrcED_Item( '36453' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36453' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36453' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO3>',
		'</VAL_CONSUMO3>',
		CONFEXME_83.tbrcED_Item( '36453' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36454' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36454' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31166' ) ) then
		CONFEXME_83.tbrcED_Item( '36454' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31166' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36454' ).itemcodi,
		'Lim_Inferior4',
		CONFEXME_83.tbrcED_Item( '36454' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36454' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36454' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR4>',
		'</LIM_INFERIOR4>',
		CONFEXME_83.tbrcED_Item( '36454' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36455' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36455' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31167' ) ) then
		CONFEXME_83.tbrcED_Item( '36455' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31167' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36455' ).itemcodi,
		'Lim_Superior4',
		CONFEXME_83.tbrcED_Item( '36455' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36455' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36455' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR4>',
		'</LIM_SUPERIOR4>',
		CONFEXME_83.tbrcED_Item( '36455' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36456' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36456' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31168' ) ) then
		CONFEXME_83.tbrcED_Item( '36456' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31168' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36456' ).itemcodi,
		'Valor_Unidad4',
		CONFEXME_83.tbrcED_Item( '36456' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36456' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36456' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD4>',
		'</VALOR_UNIDAD4>',
		CONFEXME_83.tbrcED_Item( '36456' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36457' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36457' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31169' ) ) then
		CONFEXME_83.tbrcED_Item( '36457' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31169' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36457' ).itemcodi,
		'Consumo4',
		CONFEXME_83.tbrcED_Item( '36457' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36457' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36457' ).itemgren,
		NULL,
		1,
		'<CONSUMO4>',
		'</CONSUMO4>',
		CONFEXME_83.tbrcED_Item( '36457' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36458' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36458' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31170' ) ) then
		CONFEXME_83.tbrcED_Item( '36458' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31170' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36458' ).itemcodi,
		'Val_Consumo4',
		CONFEXME_83.tbrcED_Item( '36458' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36458' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36458' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO4>',
		'</VAL_CONSUMO4>',
		CONFEXME_83.tbrcED_Item( '36458' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36459' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36459' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31171' ) ) then
		CONFEXME_83.tbrcED_Item( '36459' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31171' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36459' ).itemcodi,
		'Lim_Inferior5',
		CONFEXME_83.tbrcED_Item( '36459' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36459' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36459' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR5>',
		'</LIM_INFERIOR5>',
		CONFEXME_83.tbrcED_Item( '36459' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36460' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36460' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31172' ) ) then
		CONFEXME_83.tbrcED_Item( '36460' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31172' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36460' ).itemcodi,
		'Lim_Superior5',
		CONFEXME_83.tbrcED_Item( '36460' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36460' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36460' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR5>',
		'</LIM_SUPERIOR5>',
		CONFEXME_83.tbrcED_Item( '36460' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36461' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36461' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31173' ) ) then
		CONFEXME_83.tbrcED_Item( '36461' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31173' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36461' ).itemcodi,
		'Valor_Unidad5',
		CONFEXME_83.tbrcED_Item( '36461' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36461' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36461' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD5>',
		'</VALOR_UNIDAD5>',
		CONFEXME_83.tbrcED_Item( '36461' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36462' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36462' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31174' ) ) then
		CONFEXME_83.tbrcED_Item( '36462' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31174' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36462' ).itemcodi,
		'Consumo5',
		CONFEXME_83.tbrcED_Item( '36462' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36462' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36462' ).itemgren,
		NULL,
		1,
		'<CONSUMO5>',
		'</CONSUMO5>',
		CONFEXME_83.tbrcED_Item( '36462' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36463' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36463' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31175' ) ) then
		CONFEXME_83.tbrcED_Item( '36463' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31175' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36463' ).itemcodi,
		'Val_Consumo5',
		CONFEXME_83.tbrcED_Item( '36463' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36463' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36463' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO5>',
		'</VAL_CONSUMO5>',
		CONFEXME_83.tbrcED_Item( '36463' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36464' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36464' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31176' ) ) then
		CONFEXME_83.tbrcED_Item( '36464' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31176' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior6]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36464' ).itemcodi,
		'Lim_Inferior6',
		CONFEXME_83.tbrcED_Item( '36464' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36464' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36464' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR6>',
		'</LIM_INFERIOR6>',
		CONFEXME_83.tbrcED_Item( '36464' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36465' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36465' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31177' ) ) then
		CONFEXME_83.tbrcED_Item( '36465' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31177' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior6]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36465' ).itemcodi,
		'Lim_Superior6',
		CONFEXME_83.tbrcED_Item( '36465' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36465' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36465' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR6>',
		'</LIM_SUPERIOR6>',
		CONFEXME_83.tbrcED_Item( '36465' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36466' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36466' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31178' ) ) then
		CONFEXME_83.tbrcED_Item( '36466' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31178' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad6]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36466' ).itemcodi,
		'Valor_Unidad6',
		CONFEXME_83.tbrcED_Item( '36466' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36466' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36466' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD6>',
		'</VALOR_UNIDAD6>',
		CONFEXME_83.tbrcED_Item( '36466' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36467' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36467' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31179' ) ) then
		CONFEXME_83.tbrcED_Item( '36467' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31179' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo6]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36467' ).itemcodi,
		'Consumo6',
		CONFEXME_83.tbrcED_Item( '36467' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36467' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36467' ).itemgren,
		NULL,
		1,
		'<CONSUMO6>',
		'</CONSUMO6>',
		CONFEXME_83.tbrcED_Item( '36467' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36468' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36468' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31180' ) ) then
		CONFEXME_83.tbrcED_Item( '36468' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31180' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo6]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36468' ).itemcodi,
		'Val_Consumo6',
		CONFEXME_83.tbrcED_Item( '36468' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36468' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36468' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO6>',
		'</VAL_CONSUMO6>',
		CONFEXME_83.tbrcED_Item( '36468' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36469' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36469' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31181' ) ) then
		CONFEXME_83.tbrcED_Item( '36469' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31181' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Inferior7]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36469' ).itemcodi,
		'Lim_Inferior7',
		CONFEXME_83.tbrcED_Item( '36469' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36469' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36469' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR7>',
		'</LIM_INFERIOR7>',
		CONFEXME_83.tbrcED_Item( '36469' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36470' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36470' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31182' ) ) then
		CONFEXME_83.tbrcED_Item( '36470' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31182' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Lim_Superior7]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36470' ).itemcodi,
		'Lim_Superior7',
		CONFEXME_83.tbrcED_Item( '36470' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36470' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36470' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR7>',
		'</LIM_SUPERIOR7>',
		CONFEXME_83.tbrcED_Item( '36470' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36471' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36471' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31183' ) ) then
		CONFEXME_83.tbrcED_Item( '36471' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31183' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Unidad7]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36471' ).itemcodi,
		'Valor_Unidad7',
		CONFEXME_83.tbrcED_Item( '36471' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36471' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36471' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD7>',
		'</VALOR_UNIDAD7>',
		CONFEXME_83.tbrcED_Item( '36471' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36472' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36472' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31184' ) ) then
		CONFEXME_83.tbrcED_Item( '36472' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31184' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consumo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36472' ).itemcodi,
		'Consumo',
		CONFEXME_83.tbrcED_Item( '36472' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36472' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36472' ).itemgren,
		NULL,
		1,
		'<CONSUMO>',
		'</CONSUMO>',
		CONFEXME_83.tbrcED_Item( '36472' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36473' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36473' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31185' ) ) then
		CONFEXME_83.tbrcED_Item( '36473' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31185' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Val_Consumo7]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36473' ).itemcodi,
		'Val_Consumo7',
		CONFEXME_83.tbrcED_Item( '36473' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36473' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36473' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO7>',
		'</VAL_CONSUMO7>',
		CONFEXME_83.tbrcED_Item( '36473' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36474' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36474' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31186' ) ) then
		CONFEXME_83.tbrcED_Item( '36474' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31186' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Compcost]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36474' ).itemcodi,
		'Compcost',
		CONFEXME_83.tbrcED_Item( '36474' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36474' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36474' ).itemgren,
		NULL,
		1,
		'<COMPCOST>',
		'</COMPCOST>',
		CONFEXME_83.tbrcED_Item( '36474' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36475' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36475' ).itemobna := NULL;

	UT_Trace.Trace( 'Insertando Item [ValoresRef]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36475' ).itemcodi,
		'ValoresRef',
		CONFEXME_83.tbrcED_Item( '36475' ).itemceid,
		'DES(h)=0 IPLI=100% IO=100% IRST=NO APLICA',
		CONFEXME_83.tbrcED_Item( '36475' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36475' ).itemgren,
		NULL,
		1,
		'<VALORESREF>',
		'</VALORESREF>',
		CONFEXME_83.tbrcED_Item( '36475' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36476' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36476' ).itemobna := NULL;

	UT_Trace.Trace( 'Insertando Item [ValCalc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36476' ).itemcodi,
		'ValCalc',
		CONFEXME_83.tbrcED_Item( '36476' ).itemceid,
		'DES(h)=0 COMPENSACION($)=0',
		CONFEXME_83.tbrcED_Item( '36476' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36476' ).itemgren,
		NULL,
		1,
		'<VALCALC>',
		'</VALCALC>',
		CONFEXME_83.tbrcED_Item( '36476' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36477' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36477' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31098' ) ) then
		CONFEXME_83.tbrcED_Item( '36477' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31098' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Codigo_1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36477' ).itemcodi,
		'Codigo_1',
		CONFEXME_83.tbrcED_Item( '36477' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36477' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36477' ).itemgren,
		NULL,
		1,
		'<CODIGO_1>',
		'</CODIGO_1>',
		CONFEXME_83.tbrcED_Item( '36477' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36478' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36478' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31099' ) ) then
		CONFEXME_83.tbrcED_Item( '36478' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31099' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Codigo_2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36478' ).itemcodi,
		'Codigo_2',
		CONFEXME_83.tbrcED_Item( '36478' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36478' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36478' ).itemgren,
		NULL,
		1,
		'<CODIGO_2>',
		'</CODIGO_2>',
		CONFEXME_83.tbrcED_Item( '36478' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36479' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36479' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31100' ) ) then
		CONFEXME_83.tbrcED_Item( '36479' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31100' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Codigo_3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36479' ).itemcodi,
		'Codigo_3',
		CONFEXME_83.tbrcED_Item( '36479' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36479' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36479' ).itemgren,
		NULL,
		1,
		'<CODIGO_3>',
		'</CODIGO_3>',
		CONFEXME_83.tbrcED_Item( '36479' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36480' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36480' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31101' ) ) then
		CONFEXME_83.tbrcED_Item( '36480' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31101' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Codigo_4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36480' ).itemcodi,
		'Codigo_4',
		CONFEXME_83.tbrcED_Item( '36480' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36480' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36480' ).itemgren,
		NULL,
		1,
		'<CODIGO_4>',
		'</CODIGO_4>',
		CONFEXME_83.tbrcED_Item( '36480' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36481' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36481' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31187' ) ) then
		CONFEXME_83.tbrcED_Item( '36481' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31187' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Visible]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36481' ).itemcodi,
		'Visible',
		CONFEXME_83.tbrcED_Item( '36481' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36481' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36481' ).itemgren,
		NULL,
		2,
		'<VISIBLE>',
		'</VISIBLE>',
		CONFEXME_83.tbrcED_Item( '36481' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36482' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36482' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31188' ) ) then
		CONFEXME_83.tbrcED_Item( '36482' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31188' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Impreso]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36482' ).itemcodi,
		'Impreso',
		CONFEXME_83.tbrcED_Item( '36482' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36482' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36482' ).itemgren,
		NULL,
		1,
		'<IMPRESO>',
		'</IMPRESO>',
		CONFEXME_83.tbrcED_Item( '36482' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36483' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36483' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31189' ) ) then
		CONFEXME_83.tbrcED_Item( '36483' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31189' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Direccion_Producto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36483' ).itemcodi,
		'Direccion_Producto',
		CONFEXME_83.tbrcED_Item( '36483' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36483' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36483' ).itemgren,
		NULL,
		1,
		'<DIRECCION_PRODUCTO>',
		'</DIRECCION_PRODUCTO>',
		CONFEXME_83.tbrcED_Item( '36483' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36484' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36484' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31190' ) ) then
		CONFEXME_83.tbrcED_Item( '36484' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31190' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Causa_Desviacion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36484' ).itemcodi,
		'Causa_Desviacion',
		CONFEXME_83.tbrcED_Item( '36484' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36484' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36484' ).itemgren,
		NULL,
		1,
		'<CAUSA_DESVIACION>',
		'</CAUSA_DESVIACION>',
		CONFEXME_83.tbrcED_Item( '36484' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36485' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36485' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31191' ) ) then
		CONFEXME_83.tbrcED_Item( '36485' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31191' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Pagare_Unico]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36485' ).itemcodi,
		'Pagare_Unico',
		CONFEXME_83.tbrcED_Item( '36485' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36485' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36485' ).itemgren,
		NULL,
		1,
		'<PAGARE_UNICO>',
		'</PAGARE_UNICO>',
		CONFEXME_83.tbrcED_Item( '36485' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36486' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36486' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31192' ) ) then
		CONFEXME_83.tbrcED_Item( '36486' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31192' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cambiouso]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36486' ).itemcodi,
		'Cambiouso',
		CONFEXME_83.tbrcED_Item( '36486' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36486' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36486' ).itemgren,
		NULL,
		1,
		'<CAMBIOUSO>',
		'</CAMBIOUSO>',
		CONFEXME_83.tbrcED_Item( '36486' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36487' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36487' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31193' ) ) then
		CONFEXME_83.tbrcED_Item( '36487' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31193' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tasa_Ultima]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36487' ).itemcodi,
		'Tasa_Ultima',
		CONFEXME_83.tbrcED_Item( '36487' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36487' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36487' ).itemgren,
		NULL,
		1,
		'<TASA_ULTIMA>',
		'</TASA_ULTIMA>',
		CONFEXME_83.tbrcED_Item( '36487' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36488' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36488' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31194' ) ) then
		CONFEXME_83.tbrcED_Item( '36488' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31194' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tasa_Promedio]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36488' ).itemcodi,
		'Tasa_Promedio',
		CONFEXME_83.tbrcED_Item( '36488' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36488' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36488' ).itemgren,
		NULL,
		1,
		'<TASA_PROMEDIO>',
		'</TASA_PROMEDIO>',
		CONFEXME_83.tbrcED_Item( '36488' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36489' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36489' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31195' ) ) then
		CONFEXME_83.tbrcED_Item( '36489' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31195' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cuadrilla_Reparto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36489' ).itemcodi,
		'Cuadrilla_Reparto',
		CONFEXME_83.tbrcED_Item( '36489' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36489' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36489' ).itemgren,
		NULL,
		1,
		'<CUADRILLA_REPARTO>',
		'</CUADRILLA_REPARTO>',
		CONFEXME_83.tbrcED_Item( '36489' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36490' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36490' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31196' ) ) then
		CONFEXME_83.tbrcED_Item( '36490' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31196' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Observ_No_Lect_Consec]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36490' ).itemcodi,
		'Observ_No_Lect_Consec',
		CONFEXME_83.tbrcED_Item( '36490' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36490' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36490' ).itemgren,
		NULL,
		1,
		'<OBSERV_NO_LECT_CONSEC>',
		'</OBSERV_NO_LECT_CONSEC>',
		CONFEXME_83.tbrcED_Item( '36490' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36491' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36491' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31197' ) ) then
		CONFEXME_83.tbrcED_Item( '36491' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31197' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Visible]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36491' ).itemcodi,
		'Visible',
		CONFEXME_83.tbrcED_Item( '36491' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36491' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36491' ).itemgren,
		NULL,
		2,
		'<VISIBLE>',
		'</VISIBLE>',
		CONFEXME_83.tbrcED_Item( '36491' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36492' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36492' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31198' ) ) then
		CONFEXME_83.tbrcED_Item( '36492' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31198' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Impreso]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36492' ).itemcodi,
		'Impreso',
		CONFEXME_83.tbrcED_Item( '36492' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36492' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36492' ).itemgren,
		NULL,
		1,
		'<IMPRESO>',
		'</IMPRESO>',
		CONFEXME_83.tbrcED_Item( '36492' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36493' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36493' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31199' ) ) then
		CONFEXME_83.tbrcED_Item( '36493' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31199' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Proteccion_Estado]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36493' ).itemcodi,
		'Proteccion_Estado',
		CONFEXME_83.tbrcED_Item( '36493' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36493' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36493' ).itemgren,
		NULL,
		1,
		'<PROTECCION_ESTADO>',
		'</PROTECCION_ESTADO>',
		CONFEXME_83.tbrcED_Item( '36493' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36494' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36494' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31200' ) ) then
		CONFEXME_83.tbrcED_Item( '36494' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31200' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Acumu]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36494' ).itemcodi,
		'Acumu',
		CONFEXME_83.tbrcED_Item( '36494' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36494' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36494' ).itemgren,
		NULL,
		1,
		'<ACUMU>',
		'</ACUMU>',
		CONFEXME_83.tbrcED_Item( '36494' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36495' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36495' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31201' ) ) then
		CONFEXME_83.tbrcED_Item( '36495' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31201' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Finaespe]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36495' ).itemcodi,
		'Finaespe',
		CONFEXME_83.tbrcED_Item( '36495' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36495' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36495' ).itemgren,
		NULL,
		1,
		'<FINAESPE>',
		'</FINAESPE>',
		CONFEXME_83.tbrcED_Item( '36495' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36496' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36496' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31202' ) ) then
		CONFEXME_83.tbrcED_Item( '36496' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31202' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Med_Mal_Ubicado]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36496' ).itemcodi,
		'Med_Mal_Ubicado',
		CONFEXME_83.tbrcED_Item( '36496' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36496' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36496' ).itemgren,
		NULL,
		1,
		'<MED_MAL_UBICADO>',
		'</MED_MAL_UBICADO>',
		CONFEXME_83.tbrcED_Item( '36496' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36497' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36497' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31203' ) ) then
		CONFEXME_83.tbrcED_Item( '36497' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31203' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Imprimefact]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36497' ).itemcodi,
		'Imprimefact',
		CONFEXME_83.tbrcED_Item( '36497' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36497' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36497' ).itemgren,
		NULL,
		1,
		'<IMPRIMEFACT>',
		'</IMPRIMEFACT>',
		CONFEXME_83.tbrcED_Item( '36497' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36498' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36498' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31204' ) ) then
		CONFEXME_83.tbrcED_Item( '36498' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31204' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Ult_Pago]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36498' ).itemcodi,
		'Valor_Ult_Pago',
		CONFEXME_83.tbrcED_Item( '36498' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36498' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36498' ).itemgren,
		NULL,
		1,
		'<VALOR_ULT_PAGO>',
		'</VALOR_ULT_PAGO>',
		CONFEXME_83.tbrcED_Item( '36498' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36499' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36499' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31205' ) ) then
		CONFEXME_83.tbrcED_Item( '36499' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31205' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Ult_Pago]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36499' ).itemcodi,
		'Fecha_Ult_Pago',
		CONFEXME_83.tbrcED_Item( '36499' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36499' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36499' ).itemgren,
		NULL,
		1,
		'<FECHA_ULT_PAGO>',
		'</FECHA_ULT_PAGO>',
		CONFEXME_83.tbrcED_Item( '36499' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36500' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36500' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31206' ) ) then
		CONFEXME_83.tbrcED_Item( '36500' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31206' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Saldo_Ante]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36500' ).itemcodi,
		'Saldo_Ante',
		CONFEXME_83.tbrcED_Item( '36500' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36500' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36500' ).itemgren,
		NULL,
		1,
		'<SALDO_ANTE>',
		'</SALDO_ANTE>',
		CONFEXME_83.tbrcED_Item( '36500' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36981' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36981' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31738' ) ) then
		CONFEXME_83.tbrcED_Item( '36981' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31738' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Total]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36981' ).itemcodi,
		'Total',
		CONFEXME_83.tbrcED_Item( '36981' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36981' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36981' ).itemgren,
		NULL,
		1,
		'<TOTAL>',
		'</TOTAL>',
		CONFEXME_83.tbrcED_Item( '36981' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36982' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36982' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31739' ) ) then
		CONFEXME_83.tbrcED_Item( '36982' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31739' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Iva]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36982' ).itemcodi,
		'Iva',
		CONFEXME_83.tbrcED_Item( '36982' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36982' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36982' ).itemgren,
		NULL,
		1,
		'<IVA>',
		'</IVA>',
		CONFEXME_83.tbrcED_Item( '36982' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36983' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36983' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31740' ) ) then
		CONFEXME_83.tbrcED_Item( '36983' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31740' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Subtotal]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36983' ).itemcodi,
		'Subtotal',
		CONFEXME_83.tbrcED_Item( '36983' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36983' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36983' ).itemgren,
		NULL,
		1,
		'<SUBTOTAL>',
		'</SUBTOTAL>',
		CONFEXME_83.tbrcED_Item( '36983' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36984' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36984' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31741' ) ) then
		CONFEXME_83.tbrcED_Item( '36984' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31741' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cargosmes]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36984' ).itemcodi,
		'Cargosmes',
		CONFEXME_83.tbrcED_Item( '36984' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36984' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36984' ).itemgren,
		NULL,
		1,
		'<CARGOSMES>',
		'</CARGOSMES>',
		CONFEXME_83.tbrcED_Item( '36984' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_83.tbrcED_Item( '36985' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_83.tbrcED_Item( '36985' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_83.tbrcED_AtriFuda.exists( '31742' ) ) then
		CONFEXME_83.tbrcED_Item( '36985' ).itematfd := CONFEXME_83.tbrcED_AtriFuda( '31742' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cantidad_Conc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_83.tbrcED_Item( '36985' ).itemcodi,
		'Cantidad_Conc',
		CONFEXME_83.tbrcED_Item( '36985' ).itemceid,
		NULL,
		CONFEXME_83.tbrcED_Item( '36985' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_83.tbrcED_Item( '36985' ).itemgren,
		NULL,
		2,
		'<CANTIDAD_CONC>',
		'</CANTIDAD_CONC>',
		CONFEXME_83.tbrcED_Item( '36985' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Generando ítems por bloque-franja ***********************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36321' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36321' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36346' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36321' ).itblitem := CONFEXME_83.tbrcED_Item( '36346' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36321' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36321' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36321' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36322' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36322' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36347' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36322' ).itblitem := CONFEXME_83.tbrcED_Item( '36347' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36322' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36322' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36322' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36323' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36323' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36348' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36323' ).itblitem := CONFEXME_83.tbrcED_Item( '36348' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36323' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36323' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36323' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36324' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36324' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6977' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36349' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36324' ).itblitem := CONFEXME_83.tbrcED_Item( '36349' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36324' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36324' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36324' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36325' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36325' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36350' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36325' ).itblitem := CONFEXME_83.tbrcED_Item( '36350' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36325' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36325' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36325' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36326' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36326' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6980' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36351' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36326' ).itblitem := CONFEXME_83.tbrcED_Item( '36351' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36326' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36326' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36326' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36327' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36327' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36352' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36327' ).itblitem := CONFEXME_83.tbrcED_Item( '36352' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36327' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36327' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36327' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36328' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36328' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36353' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36328' ).itblitem := CONFEXME_83.tbrcED_Item( '36353' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36328' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36328' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36328' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36329' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36329' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36354' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36329' ).itblitem := CONFEXME_83.tbrcED_Item( '36354' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36329' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36329' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36329' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36330' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36330' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36355' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36330' ).itblitem := CONFEXME_83.tbrcED_Item( '36355' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36330' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36330' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36330' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36331' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36331' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36356' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36331' ).itblitem := CONFEXME_83.tbrcED_Item( '36356' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36331' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36331' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36331' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36332' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36332' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36357' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36332' ).itblitem := CONFEXME_83.tbrcED_Item( '36357' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36332' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36332' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36332' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36333' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36333' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36358' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36333' ).itblitem := CONFEXME_83.tbrcED_Item( '36358' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36333' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36333' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36333' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36334' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36334' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6978' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36359' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36334' ).itblitem := CONFEXME_83.tbrcED_Item( '36359' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36334' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36334' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36334' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36335' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36335' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36360' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36335' ).itblitem := CONFEXME_83.tbrcED_Item( '36360' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36335' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36335' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36335' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36336' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36336' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36361' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36336' ).itblitem := CONFEXME_83.tbrcED_Item( '36361' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36336' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36336' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36336' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36337' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36337' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36362' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36337' ).itblitem := CONFEXME_83.tbrcED_Item( '36362' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36337' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36337' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36337' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36338' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36338' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36363' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36338' ).itblitem := CONFEXME_83.tbrcED_Item( '36363' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36338' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36338' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36338' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36339' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36339' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36364' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36339' ).itblitem := CONFEXME_83.tbrcED_Item( '36364' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36339' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36339' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36339' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36340' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36340' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36365' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36340' ).itblitem := CONFEXME_83.tbrcED_Item( '36365' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36340' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36340' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36340' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36341' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36341' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36366' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36341' ).itblitem := CONFEXME_83.tbrcED_Item( '36366' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36341' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36341' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36341' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36342' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36342' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36367' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36342' ).itblitem := CONFEXME_83.tbrcED_Item( '36367' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36342' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36342' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36342' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36343' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36343' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36368' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36343' ).itblitem := CONFEXME_83.tbrcED_Item( '36368' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36343' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36343' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36343' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36344' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36344' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36369' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36344' ).itblitem := CONFEXME_83.tbrcED_Item( '36369' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36344' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36344' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36344' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36345' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36345' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36370' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36345' ).itblitem := CONFEXME_83.tbrcED_Item( '36370' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36345' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36345' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36345' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36346' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36346' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36371' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36346' ).itblitem := CONFEXME_83.tbrcED_Item( '36371' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36346' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36346' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36346' ).itblblfr,
		20
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36347' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36347' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36372' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36347' ).itblitem := CONFEXME_83.tbrcED_Item( '36372' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36347' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36347' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36347' ).itblblfr,
		23
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36348' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36348' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36373' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36348' ).itblitem := CONFEXME_83.tbrcED_Item( '36373' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36348' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36348' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36348' ).itblblfr,
		24
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36349' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36349' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36374' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36349' ).itblitem := CONFEXME_83.tbrcED_Item( '36374' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36349' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36349' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36349' ).itblblfr,
		25
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36350' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36350' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36375' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36350' ).itblitem := CONFEXME_83.tbrcED_Item( '36375' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36350' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36350' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36350' ).itblblfr,
		26
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36351' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36351' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36376' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36351' ).itblitem := CONFEXME_83.tbrcED_Item( '36376' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36351' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36351' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36351' ).itblblfr,
		27
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36352' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36352' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36377' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36352' ).itblitem := CONFEXME_83.tbrcED_Item( '36377' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36352' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36352' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36352' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36353' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36353' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6979' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36378' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36353' ).itblitem := CONFEXME_83.tbrcED_Item( '36378' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36353' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36353' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36353' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36354' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36354' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36379' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36354' ).itblitem := CONFEXME_83.tbrcED_Item( '36379' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36354' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36354' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36354' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36355' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36355' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36380' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36355' ).itblitem := CONFEXME_83.tbrcED_Item( '36380' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36355' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36355' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36355' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36356' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36356' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36381' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36356' ).itblitem := CONFEXME_83.tbrcED_Item( '36381' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36356' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36356' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36356' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36357' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36357' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36382' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36357' ).itblitem := CONFEXME_83.tbrcED_Item( '36382' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36357' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36357' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36357' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36358' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36358' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36383' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36358' ).itblitem := CONFEXME_83.tbrcED_Item( '36383' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36358' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36358' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36358' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36359' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36359' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36384' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36359' ).itblitem := CONFEXME_83.tbrcED_Item( '36384' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36359' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36359' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36359' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36360' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36360' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36385' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36360' ).itblitem := CONFEXME_83.tbrcED_Item( '36385' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36360' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36360' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36360' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36361' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36361' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36386' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36361' ).itblitem := CONFEXME_83.tbrcED_Item( '36386' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36361' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36361' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36361' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36362' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36362' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36387' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36362' ).itblitem := CONFEXME_83.tbrcED_Item( '36387' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36362' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36362' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36362' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36363' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36363' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36388' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36363' ).itblitem := CONFEXME_83.tbrcED_Item( '36388' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36363' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36363' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36363' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36364' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36364' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36389' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36364' ).itblitem := CONFEXME_83.tbrcED_Item( '36389' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36364' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36364' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36364' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36365' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36365' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36390' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36365' ).itblitem := CONFEXME_83.tbrcED_Item( '36390' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36365' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36365' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36365' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36366' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36366' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36391' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36366' ).itblitem := CONFEXME_83.tbrcED_Item( '36391' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36366' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36366' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36366' ).itblblfr,
		21
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36367' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36367' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6976' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36392' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36367' ).itblitem := CONFEXME_83.tbrcED_Item( '36392' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36367' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36367' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36367' ).itblblfr,
		22
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36368' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36368' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6983' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36393' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36368' ).itblitem := CONFEXME_83.tbrcED_Item( '36393' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36368' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36368' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36368' ).itblblfr,
		0
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36369' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36369' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36394' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36369' ).itblitem := CONFEXME_83.tbrcED_Item( '36394' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36369' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36369' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36369' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36370' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36370' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6984' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36395' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36370' ).itblitem := CONFEXME_83.tbrcED_Item( '36395' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36370' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36370' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36370' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36371' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36371' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36396' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36371' ).itblitem := CONFEXME_83.tbrcED_Item( '36396' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36371' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36371' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36371' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36372' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36372' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36397' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36372' ).itblitem := CONFEXME_83.tbrcED_Item( '36397' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36372' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36372' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36372' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36373' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36373' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36398' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36373' ).itblitem := CONFEXME_83.tbrcED_Item( '36398' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36373' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36373' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36373' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36374' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36374' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6985' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36399' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36374' ).itblitem := CONFEXME_83.tbrcED_Item( '36399' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36374' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36374' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36374' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36375' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36375' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36400' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36375' ).itblitem := CONFEXME_83.tbrcED_Item( '36400' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36375' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36375' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36375' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36376' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36376' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36401' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36376' ).itblitem := CONFEXME_83.tbrcED_Item( '36401' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36376' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36376' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36376' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36377' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36377' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36402' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36377' ).itblitem := CONFEXME_83.tbrcED_Item( '36402' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36377' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36377' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36377' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36378' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36378' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36403' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36378' ).itblitem := CONFEXME_83.tbrcED_Item( '36403' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36378' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36378' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36378' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36379' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36379' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36404' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36379' ).itblitem := CONFEXME_83.tbrcED_Item( '36404' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36379' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36379' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36379' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36380' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36380' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36405' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36380' ).itblitem := CONFEXME_83.tbrcED_Item( '36405' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36380' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36380' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36380' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36381' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36381' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36406' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36381' ).itblitem := CONFEXME_83.tbrcED_Item( '36406' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36381' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36381' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36381' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36382' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36382' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36407' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36382' ).itblitem := CONFEXME_83.tbrcED_Item( '36407' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36382' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36382' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36382' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36383' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36383' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36408' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36383' ).itblitem := CONFEXME_83.tbrcED_Item( '36408' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36383' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36383' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36383' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36384' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36384' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36409' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36384' ).itblitem := CONFEXME_83.tbrcED_Item( '36409' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36384' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36384' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36384' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36385' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36385' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36410' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36385' ).itblitem := CONFEXME_83.tbrcED_Item( '36410' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36385' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36385' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36385' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36386' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36386' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36411' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36386' ).itblitem := CONFEXME_83.tbrcED_Item( '36411' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36386' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36386' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36386' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36387' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36387' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36412' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36387' ).itblitem := CONFEXME_83.tbrcED_Item( '36412' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36387' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36387' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36387' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36388' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36388' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36413' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36388' ).itblitem := CONFEXME_83.tbrcED_Item( '36413' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36388' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36388' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36388' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36389' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36389' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36414' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36389' ).itblitem := CONFEXME_83.tbrcED_Item( '36414' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36389' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36389' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36389' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36390' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36390' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36415' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36390' ).itblitem := CONFEXME_83.tbrcED_Item( '36415' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36390' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36390' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36390' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36391' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36391' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36416' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36391' ).itblitem := CONFEXME_83.tbrcED_Item( '36416' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36391' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36391' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36391' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36392' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36392' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36417' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36392' ).itblitem := CONFEXME_83.tbrcED_Item( '36417' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36392' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36392' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36392' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36393' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36393' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6986' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36418' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36393' ).itblitem := CONFEXME_83.tbrcED_Item( '36418' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36393' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36393' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36393' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36394' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36394' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36419' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36394' ).itblitem := CONFEXME_83.tbrcED_Item( '36419' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36394' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36394' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36394' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36395' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36395' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6981' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36420' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36395' ).itblitem := CONFEXME_83.tbrcED_Item( '36420' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36395' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36395' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36395' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36396' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36396' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36421' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36396' ).itblitem := CONFEXME_83.tbrcED_Item( '36421' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36396' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36396' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36396' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36397' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36397' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36422' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36397' ).itblitem := CONFEXME_83.tbrcED_Item( '36422' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36397' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36397' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36397' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36398' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36398' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36423' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36398' ).itblitem := CONFEXME_83.tbrcED_Item( '36423' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36398' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36398' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36398' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36399' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36399' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36424' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36399' ).itblitem := CONFEXME_83.tbrcED_Item( '36424' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36399' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36399' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36399' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36400' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36400' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36425' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36400' ).itblitem := CONFEXME_83.tbrcED_Item( '36425' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36400' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36400' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36400' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36401' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36401' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36426' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36401' ).itblitem := CONFEXME_83.tbrcED_Item( '36426' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36401' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36401' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36401' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36402' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36402' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36427' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36402' ).itblitem := CONFEXME_83.tbrcED_Item( '36427' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36402' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36402' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36402' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36403' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36403' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36428' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36403' ).itblitem := CONFEXME_83.tbrcED_Item( '36428' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36403' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36403' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36403' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36404' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36404' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36429' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36404' ).itblitem := CONFEXME_83.tbrcED_Item( '36429' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36404' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36404' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36404' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36405' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36405' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36430' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36405' ).itblitem := CONFEXME_83.tbrcED_Item( '36430' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36405' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36405' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36405' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36406' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36406' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36431' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36406' ).itblitem := CONFEXME_83.tbrcED_Item( '36431' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36406' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36406' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36406' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36407' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36407' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36432' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36407' ).itblitem := CONFEXME_83.tbrcED_Item( '36432' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36407' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36407' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36407' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36408' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36408' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6987' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36433' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36408' ).itblitem := CONFEXME_83.tbrcED_Item( '36433' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36408' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36408' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36408' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36409' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36409' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36434' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36409' ).itblitem := CONFEXME_83.tbrcED_Item( '36434' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36409' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36409' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36409' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36410' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36410' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36435' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36410' ).itblitem := CONFEXME_83.tbrcED_Item( '36435' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36410' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36410' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36410' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36411' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36411' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36436' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36411' ).itblitem := CONFEXME_83.tbrcED_Item( '36436' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36411' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36411' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36411' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36412' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36412' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36437' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36412' ).itblitem := CONFEXME_83.tbrcED_Item( '36437' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36412' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36412' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36412' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36413' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36413' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6988' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36438' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36413' ).itblitem := CONFEXME_83.tbrcED_Item( '36438' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36413' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36413' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36413' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36414' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36414' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36439' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36414' ).itblitem := CONFEXME_83.tbrcED_Item( '36439' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36414' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36414' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36414' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36415' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36415' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36440' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36415' ).itblitem := CONFEXME_83.tbrcED_Item( '36440' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36415' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36415' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36415' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36416' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36416' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36441' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36416' ).itblitem := CONFEXME_83.tbrcED_Item( '36441' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36416' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36416' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36416' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36417' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36417' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36442' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36417' ).itblitem := CONFEXME_83.tbrcED_Item( '36442' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36417' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36417' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36417' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36418' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36418' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36443' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36418' ).itblitem := CONFEXME_83.tbrcED_Item( '36443' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36418' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36418' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36418' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36419' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36419' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36444' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36419' ).itblitem := CONFEXME_83.tbrcED_Item( '36444' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36419' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36419' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36419' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36420' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36420' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36445' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36420' ).itblitem := CONFEXME_83.tbrcED_Item( '36445' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36420' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36420' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36420' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36421' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36421' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36446' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36421' ).itblitem := CONFEXME_83.tbrcED_Item( '36446' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36421' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36421' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36421' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36422' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36422' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36447' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36422' ).itblitem := CONFEXME_83.tbrcED_Item( '36447' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36422' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36422' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36422' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36423' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36423' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36448' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36423' ).itblitem := CONFEXME_83.tbrcED_Item( '36448' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36423' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36423' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36423' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36424' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36424' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36449' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36424' ).itblitem := CONFEXME_83.tbrcED_Item( '36449' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36424' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36424' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36424' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36425' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36425' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36450' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36425' ).itblitem := CONFEXME_83.tbrcED_Item( '36450' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36425' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36425' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36425' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36426' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36426' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36451' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36426' ).itblitem := CONFEXME_83.tbrcED_Item( '36451' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36426' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36426' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36426' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36427' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36427' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36452' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36427' ).itblitem := CONFEXME_83.tbrcED_Item( '36452' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36427' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36427' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36427' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36428' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36428' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36453' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36428' ).itblitem := CONFEXME_83.tbrcED_Item( '36453' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36428' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36428' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36428' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36429' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36429' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36454' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36429' ).itblitem := CONFEXME_83.tbrcED_Item( '36454' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36429' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36429' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36429' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36430' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36430' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36455' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36430' ).itblitem := CONFEXME_83.tbrcED_Item( '36455' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36430' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36430' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36430' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36431' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36431' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36456' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36431' ).itblitem := CONFEXME_83.tbrcED_Item( '36456' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36431' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36431' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36431' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36432' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36432' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36457' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36432' ).itblitem := CONFEXME_83.tbrcED_Item( '36457' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36432' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36432' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36432' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36433' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36433' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36458' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36433' ).itblitem := CONFEXME_83.tbrcED_Item( '36458' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36433' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36433' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36433' ).itblblfr,
		20
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36434' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36434' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36459' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36434' ).itblitem := CONFEXME_83.tbrcED_Item( '36459' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36434' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36434' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36434' ).itblblfr,
		21
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36435' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36435' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36460' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36435' ).itblitem := CONFEXME_83.tbrcED_Item( '36460' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36435' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36435' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36435' ).itblblfr,
		22
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36436' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36436' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36461' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36436' ).itblitem := CONFEXME_83.tbrcED_Item( '36461' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36436' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36436' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36436' ).itblblfr,
		23
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36437' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36437' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36462' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36437' ).itblitem := CONFEXME_83.tbrcED_Item( '36462' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36437' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36437' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36437' ).itblblfr,
		24
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36438' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36438' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36463' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36438' ).itblitem := CONFEXME_83.tbrcED_Item( '36463' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36438' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36438' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36438' ).itblblfr,
		25
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36439' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36439' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36464' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36439' ).itblitem := CONFEXME_83.tbrcED_Item( '36464' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36439' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36439' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36439' ).itblblfr,
		26
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36440' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36440' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36465' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36440' ).itblitem := CONFEXME_83.tbrcED_Item( '36465' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36440' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36440' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36440' ).itblblfr,
		27
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36441' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36441' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36466' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36441' ).itblitem := CONFEXME_83.tbrcED_Item( '36466' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36441' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36441' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36441' ).itblblfr,
		28
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36442' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36442' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36467' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36442' ).itblitem := CONFEXME_83.tbrcED_Item( '36467' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36442' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36442' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36442' ).itblblfr,
		29
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36443' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36443' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36468' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36443' ).itblitem := CONFEXME_83.tbrcED_Item( '36468' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36443' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36443' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36443' ).itblblfr,
		30
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36444' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36444' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36469' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36444' ).itblitem := CONFEXME_83.tbrcED_Item( '36469' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36444' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36444' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36444' ).itblblfr,
		31
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36445' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36445' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36470' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36445' ).itblitem := CONFEXME_83.tbrcED_Item( '36470' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36445' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36445' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36445' ).itblblfr,
		32
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36446' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36446' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36471' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36446' ).itblitem := CONFEXME_83.tbrcED_Item( '36471' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36446' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36446' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36446' ).itblblfr,
		33
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36447' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36447' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36472' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36447' ).itblitem := CONFEXME_83.tbrcED_Item( '36472' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36447' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36447' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36447' ).itblblfr,
		34
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36448' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36448' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6989' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36473' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36448' ).itblitem := CONFEXME_83.tbrcED_Item( '36473' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36448' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36448' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36448' ).itblblfr,
		35
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36449' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36449' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36474' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36449' ).itblitem := CONFEXME_83.tbrcED_Item( '36474' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36449' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36449' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36449' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36450' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36450' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36475' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36450' ).itblitem := CONFEXME_83.tbrcED_Item( '36475' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36450' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36450' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36450' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36451' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36451' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6990' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36476' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36451' ).itblitem := CONFEXME_83.tbrcED_Item( '36476' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36451' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36451' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36451' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36452' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36452' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36477' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36452' ).itblitem := CONFEXME_83.tbrcED_Item( '36477' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36452' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36452' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36452' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36453' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36453' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36478' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36453' ).itblitem := CONFEXME_83.tbrcED_Item( '36478' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36453' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36453' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36453' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36454' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36454' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36479' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36454' ).itblitem := CONFEXME_83.tbrcED_Item( '36479' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36454' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36454' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36454' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36455' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36455' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6982' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36480' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36455' ).itblitem := CONFEXME_83.tbrcED_Item( '36480' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36455' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36455' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36455' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36456' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36456' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36481' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36456' ).itblitem := CONFEXME_83.tbrcED_Item( '36481' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36456' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36456' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36456' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36457' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36457' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6991' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36482' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36457' ).itblitem := CONFEXME_83.tbrcED_Item( '36482' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36457' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36457' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36457' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36458' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36458' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36483' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36458' ).itblitem := CONFEXME_83.tbrcED_Item( '36483' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36458' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36458' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36458' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36459' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36459' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36484' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36459' ).itblitem := CONFEXME_83.tbrcED_Item( '36484' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36459' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36459' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36459' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36460' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36460' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36485' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36460' ).itblitem := CONFEXME_83.tbrcED_Item( '36485' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36460' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36460' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36460' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36461' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36461' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6992' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36486' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36461' ).itblitem := CONFEXME_83.tbrcED_Item( '36486' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36461' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36461' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36461' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36462' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36462' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36487' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36462' ).itblitem := CONFEXME_83.tbrcED_Item( '36487' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36462' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36462' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36462' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36463' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36463' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6993' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36488' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36463' ).itblitem := CONFEXME_83.tbrcED_Item( '36488' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36463' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36463' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36463' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36464' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36464' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36489' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36464' ).itblitem := CONFEXME_83.tbrcED_Item( '36489' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36464' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36464' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36464' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36465' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36465' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6994' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36490' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36465' ).itblitem := CONFEXME_83.tbrcED_Item( '36490' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36465' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36465' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36465' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36466' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36466' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36491' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36466' ).itblitem := CONFEXME_83.tbrcED_Item( '36491' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36466' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36466' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36466' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36467' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36467' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36492' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36467' ).itblitem := CONFEXME_83.tbrcED_Item( '36492' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36467' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36467' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36467' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36468' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36468' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6995' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36493' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36468' ).itblitem := CONFEXME_83.tbrcED_Item( '36493' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36468' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36468' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36468' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36469' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36469' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6996' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36494' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36469' ).itblitem := CONFEXME_83.tbrcED_Item( '36494' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36469' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36469' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36469' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36470' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36470' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6997' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36495' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36470' ).itblitem := CONFEXME_83.tbrcED_Item( '36495' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36470' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36470' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36470' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36471' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36471' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6998' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36496' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36471' ).itblitem := CONFEXME_83.tbrcED_Item( '36496' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36471' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36471' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36471' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36472' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36472' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '6999' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36497' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36472' ).itblitem := CONFEXME_83.tbrcED_Item( '36497' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36472' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36472' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36472' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36473' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36473' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36498' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36473' ).itblitem := CONFEXME_83.tbrcED_Item( '36498' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36473' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36473' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36473' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36474' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36474' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7000' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36499' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36474' ).itblitem := CONFEXME_83.tbrcED_Item( '36499' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36474' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36474' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36474' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36475' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36475' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7001' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36500' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36475' ).itblitem := CONFEXME_83.tbrcED_Item( '36500' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36475' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36475' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36475' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36956' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36956' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36981' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36956' ).itblitem := CONFEXME_83.tbrcED_Item( '36981' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36956' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36956' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36956' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36957' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36957' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36982' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36957' ).itblitem := CONFEXME_83.tbrcED_Item( '36982' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36957' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36957' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36957' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36958' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36958' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36983' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36958' ).itblitem := CONFEXME_83.tbrcED_Item( '36983' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36958' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36958' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36958' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36959' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36959' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36984' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36959' ).itblitem := CONFEXME_83.tbrcED_Item( '36984' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36959' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36959' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36959' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_83.tbrcED_ItemBloq( '36960' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_83.tbrcED_ItemBloq( '36960' ).itblblfr := CONFEXME_83.tbrcED_BloqFran( '7068' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_83.tbrcED_Item.exists( '36985' ) ) then
		CONFEXME_83.tbrcED_ItemBloq( '36960' ).itblitem := CONFEXME_83.tbrcED_Item( '36985' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_83.tbrcED_ItemBloq( '36960' ).itblcodi,
		CONFEXME_83.tbrcED_ItemBloq( '36960' ).itblitem,
		CONFEXME_83.tbrcED_ItemBloq( '36960' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '****************************** Generando plantilla *******************************', 5 );
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	blContent           blob;

	-- Identificador plantilla
	nuIdPlantill        ed_plantill.plancodi%type;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se escribe el CLOB
	dbms_lob.createtemporary(blContent , true); 

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E38313336303835362D393166332D343635382D626366652D3766323466643034633038313C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32372E39636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E31636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C72643A5265706F727449443E30333738316163372D306335382D343462642D383864382D3435623233656333613835313C2F72643A5265706F727449443E0D0A20203C5061676557696474683E32312E3539636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D224C44435F4441544F535F434C49454E5445223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D2246414354555241223E0D0A202020202020202020203C446174614669656C643E464143545552413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E53747269'
		||	'6E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543485F46414354223E0D0A202020202020202020203C446174614669656C643E464543485F464143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D45535F46414354223E0D0A202020202020202020203C446174614669656C643E4D45535F464143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22504552494F444F5F46414354223E0D0A202020202020202020203C446174614669656C643E504552494F444F5F464143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225041474F5F4841535441223E0D0A202020202020202020203C446174614669656C643E5041474F5F48415354413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224355504F4E223E0D0A202020202020202020203C446174614669656C643E4355504F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D425245223E0D0A202020202020202020203C446174614669656C643E4E4F4D4252453C2F446174614669656C643E0D0A2020202020202020'
		||	'20203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444952454343494F4E5F434F42524F223E0D0A202020202020202020203C446174614669656C643E444952454343494F4E5F434F42524F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C4F43414C49444144223E0D0A202020202020202020203C446174614669656C643E4C4F43414C494441443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C444F5F4641564F52223E0D0A202020202020202020203C446174614669656C643E53414C444F5F4641564F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C444F5F414E54223E0D0A202020202020202020203C446174614669656C643E53414C444F5F414E543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22544F54414C5F46414354555241223E0D0A202020202020202020203C446174614669656C643E544F54414C5F464143545552413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225041474F5F53494E5F5245434152474F223E0D0A202020202020202020203C446174614669656C643E5041474F5F53494E5F5245434152474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C466965'
		||	'6C64204E616D653D22434F4E444943494F4E5F5041474F223E0D0A202020202020202020203C446174614669656C643E434F4E444943494F4E5F5041474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224944454E544946494341223E0D0A202020202020202020203C446174614669656C643E4944454E5449464943413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F50524F445543544F223E0D0A202020202020202020203C446174614669656C643E5449504F50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F434C49454E54453C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F434152474F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22444553435F434F4E434550223E0D0A202020202020202020203C446174614669656C643E444553435F434F4E4345503C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669'
		||	'656C643E0D0A20202020202020203C4669656C64204E616D653D224554495155455441223E0D0A202020202020202020203C446174614669656C643E45544951554554413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224341504954414C223E0D0A202020202020202020203C446174614669656C643E4341504954414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243554F544153223E0D0A202020202020202020203C446174614669656C643E43554F5441533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E434152474F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F535542544F54414C4553223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22495641223E0D0A202020202020202020203C446174614669656C643E4956413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253554254'
		||	'4F54414C223E0D0A202020202020202020203C446174614669656C643E535542544F54414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434152474F534D4553223E0D0A202020202020202020203C446174614669656C643E434152474F534D45533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F535542544F54414C45533C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E535542544F54414C45533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F54415341535F43414D42494F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22544153415F554C54494D41223E0D0A202020202020202020203C446174614669656C643E544153415F554C54494D413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22544153415F50524F4D4544494F223E0D0A202020202020202020203C446174614669656C643E544153415F50524F4D4544494F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020'
		||	'203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F54415341535F43414D42494F3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E54415341535F43414D42494F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2245585452415F424152434F44455F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4445223E0D0A202020202020202020203C446174614669656C643E434F44453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22494D414745223E0D0A202020202020202020203C446174614669656C643E494D4147453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E45585452415F424152434F44455F3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E424152434F44455F3C2F7264'
		||	'3A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F4355504F4E223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F445F424152223E0D0A202020202020202020203C446174614669656C643E434F445F4241523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4355504F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4355504F4E3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F4441544F535F5245564953494F4E223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D225449504F5F4E4F5449223E0D0A202020202020202020203C446174614669656C643E5449504F5F4E4F54493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D454E535F4E4F5449223E0D0A202020202020202020203C446174614669656C643E4D454E535F4E4F54493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543485F4D4158494D41223E0D0A202020202020202020203C44'
		||	'6174614669656C643E464543485F4D4158494D413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543485F53555350223E0D0A202020202020202020203C446174614669656C643E464543485F535553503C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4441544F535F5245564953494F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F5245564953494F4E3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F64653E5368617265642068742041732053797374656D2E436F6C6C656374696F6E732E486173687461626C65203D204E65772053797374656D2E436F6C6C656374696F6E732E486173687461626C650D0A5075626C69632046756E6374696F6E20496E7374616E636961724974656D476C6F62616C28427956616C2067726F7570204173204F626A6563742C2042795265662067726F75704E616D6520417320537472696E672C2042795265662075736572494420417320537472696E672920417320537472696E670D0A2020202044696D206B657920417320537472696E67203D2067726F75704E616D652026616D703B207573657249440D0A202020204966204E6F742067726F7570204973204E6F7468696E67205468656E0D0A202020202020202044696D206720417320537472696E67203D2043547970652867726F75702C20537472696E67290D0A20202020202020204966204E6F74202868742E436F6E7461'
		||	'696E734B6579286B65792929205468656E0D0A20202020202020202020202027206D75737420626520746865206669727374207061737320736F20736574207468652063757272656E742067726F757020746F2067726F75700D0A20202020202020202020202068742E416464286B65792C2067290D0A2020202020202020456C73650D0A2020202020202020202020204966204E6F7420286874286B6579292E457175616C7328672929205468656E0D0A202020202020202020202020202020206874286B657929203D20670D0A202020202020202020202020456E642049660D0A2020202020202020456E642049660D0A20202020456E642049660D0A2020202052657475726E206874286B6579290D0A456E642046756E6374696F6E3C2F436F64653E0D0A20203C57696474683E32312E3539636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783331223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E302E39636D3C2F546F703E0D0A20202020202020203C57696474683E302E3837333032636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A20202020202020203C4C6566743E31382E34636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2231223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833303C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E35636D3C2F546F703E0D0A20202020202020203C57696474683E31372E3034636D3C2F57696474683E0D0A20202020202020203C5374796C'
		||	'653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A20202020202020203C4C6566743E322E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214D454E535F4E4F54492E56616C75652C20224C44435F4441544F535F5245564953494F4E22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F4449474F5F424152524153223E0D0A20202020202020203C72643A44656661756C744E616D653E434F4449474F5F4241525241533C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32342E37636D3C2F546F703E0D0A20202020202020203C57696474683E382E37636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A20202020202020203C4C6566743E31312E39636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F445F4241522E56616C75652C20224C44435F4355504F4E2229'
		||	'3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676532223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E32332E37636D3C2F546F703E0D0A20202020202020203C57696474683E392E3730303031636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A202020202020202020203C2F426F7264657257696474683E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A20202020202020203C4C6566743E31312E34636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832393C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32302E39636D3C2F546F703E0D0A20202020202020203C57696474683E362E35383733636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A20202020202020203C4C6566743E322E37636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3636313338636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544153415F'
		||	'554C54494D412E56616C75652C20224C44435F54415341535F43414D42494F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783238223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832383C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32302E32636D3C2F546F703E0D0A20202020202020203C57696474683E362E3338636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A20202020202020203C4C6566743E322E37636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3636313338636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544153415F50524F4D4544494F2E56616C75652C20224C44435F54415341535F43414D42494F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783237223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832373C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E352E37636D3C2F546F703E0D0A20202020202020203C57696474683E342E3339313533636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C'
		||	'5A496E6465783E32373C2F5A496E6465783E0D0A20202020202020203C4C6566743E31342E39636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321464543485F535553502E56616C75652C20224C44435F4441544F535F5245564953494F4E22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832363C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E342E31636D3C2F546F703E0D0A20202020202020203C57696474683E342E3137393839636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E3232636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321464543485F4D4158494D412E56616C75652C20224C44435F4441544F535F5245564953494F4E22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A20202020202020203C546F703E32302E38636D3C2F546F703E0D0A20202020202020203C57696474683E332E3734636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50'
		||	'616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E33636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C6473214956412E56616C75652C20224C44435F535542544F54414C455322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783234223E0D0A20202020202020203C546F703E3230636D3C2F546F703E0D0A20202020202020203C57696474683E332E3734636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E33636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C647321535542544F54414C2E56616C75652C20224C44435F535542544F54414C455322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A20202020202020203C546F703E31372E37636D3C2F546F703E0D0A20202020202020203C57696474683E332E3734636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D'
		||	'0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E33636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C647321434152474F534D45532E56616C75652C20224C44435F535542544F54414C455322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6531223E0D0A20202020202020203C4C6566743E322E34636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C5461626C65204E616D653D227461626C6531223E0D0A2020202020202020202020203C446174615365744E616D653E4C44435F434152474F533C2F446174615365744E616D653E0D0A2020202020202020202020203C46696C746572733E0D0A20202020202020202020202020203C46696C7465723E0D0A202020202020202020202020202020203C46696C74657245787072657373696F6E3E3D4669656C64732145544951554554412E56616C75653C2F46696C74657245787072657373696F6E3E0D0A202020202020202020202020202020203C4F70657261746F723E457175616C3C2F4F70657261746F723E0D0A202020202020202020202020202020203C46696C74657256616C7565733E0D0A2020202020202020202020202020202020203C46696C74657256616C75653E33353C2F46696C74657256616C75653E0D0A202020202020202020202020202020203C2F46696C74657256616C7565733E0D0A20202020202020202020202020203C2F46696C7465723E0D0A2020202020202020202020203C2F46696C746572733E0D0A202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		14790, 
		hextoraw
		(
			'2020202020203C546F703E302E3232636D3C2F546F703E0D0A2020202020202020202020203C57696474683E31362E3537636D3C2F57696474683E0D0A2020202020202020202020203C44657461696C733E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D22444553435F434F4E434550223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3770743C2F50616464696E674C6566743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321444553435F434F4E4345502E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2243554F544153223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874'
		||	'416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3370743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732143554F5441532E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D224341504954414C223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3370743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214341504954414C2E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E3335636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461'
		||	'626C65526F77733E0D0A2020202020202020202020203C2F44657461696C733E0D0A2020202020202020202020203C5461626C65436F6C756D6E733E0D0A20202020202020202020202020203C5461626C65436F6C756D6E3E0D0A202020202020202020202020202020203C57696474683E382E36636D3C2F57696474683E0D0A20202020202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020202020202020203C5461626C65436F6C756D6E3E0D0A202020202020202020202020202020203C57696474683E342E31636D3C2F57696474683E0D0A20202020202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020202020202020203C5461626C65436F6C756D6E3E0D0A202020202020202020202020202020203C57696474683E332E3837636D3C2F57696474683E0D0A20202020202020202020202020203C2F5461626C65436F6C756D6E3E0D0A2020202020202020202020203C2F5461626C65436F6C756D6E733E0D0A2020202020202020202020203C4865696768743E302E3335636D3C2F4865696768743E0D0A202020202020202020203C2F5461626C653E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E382E37636D3C2F546F703E0D0A20202020202020203C57696474683E31362E39636D3C2F57696474683E0D0A20202020202020203C4865696768743E382E38636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783233223E0D0A20202020202020203C546F703E32312E36636D3C2F546F703E0D0A20202020202020203C57696474683E342E3138636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A20202020202020203C4C6566743E31342E3835636D3C2F'
		||	'4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C647321544F54414C5F464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A20202020202020203C546F703E31392E32636D3C2F546F703E0D0A20202020202020203C57696474683E332E3734636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E33636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C64732153414C444F5F4641564F522E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A20202020202020203C546F703E31382E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3734636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020'
		||	'202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E33636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C64732153414C444F5F414E542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A20202020202020203C546F703E32362E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3532636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A20202020202020203C4C6566743E332E34636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C64732153414C444F5F414E542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783138223E0D0A20202020202020203C546F703E3236636D3C2F546F703E0D0A20202020202020203C57696474683E332E3532636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E'
		||	'0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A20202020202020203C4C6566743E332E34636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214D45535F464143542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A20202020202020203C546F703E32352E36636D3C2F546F703E0D0A20202020202020203C57696474683E332E3532636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A20202020202020203C4C6566743E332E34636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321464543485F464143542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A20202020202020203C546F703E3235636D3C2F546F703E0D0A20202020202020203C57696474683E332E3338636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69'
		||	'676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A20202020202020203C4C6566743E332E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A20202020202020203C546F703E32362E35636D3C2F546F703E0D0A20202020202020203C57696474683E322E32636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A20202020202020203C4C6566743E392E36636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C647321544F54414C5F464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78'
		||	'3134223E0D0A20202020202020203C546F703E32352E38636D3C2F546F703E0D0A20202020202020203C57696474683E322E32636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A20202020202020203C4C6566743E392E36636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2224222026616D703B204669727374284669656C647321544F54414C5F464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A20202020202020203C546F703E3235636D3C2F546F703E0D0A20202020202020203C57696474683E32636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020203C4C6566743E392E'
		||	'36636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A20202020202020203C546F703E372E34636D3C2F546F703E0D0A20202020202020203C57696474683E372E37636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020203C4C6566743E332E39636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E39636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321444952454343494F4E5F434F42524F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A20202020202020203C546F703E372E34636D3C2F546F703E0D0A20202020202020203C57696474683E362E3338636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020'
		||	'202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020203C4C6566743E31332E32636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215449504F50524F445543544F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783130223E0D0A20202020202020203C546F703E362E39636D3C2F546F703E0D0A20202020202020203C57696474683E372E3234383638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020203C4C6566743E31332E32636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214944454E5449464943412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A20202020202020203C546F703E362E39636D3C2F546F703E0D0A20202020202020203C57696474683E372E3234383638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F7474'
		||	'6F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020203C4C6566743E332E39636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D4252452E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A20202020202020203C546F703E332E3438636D3C2F546F703E0D0A20202020202020203C57696474683E372E3234383638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020203C4C6566743E31322E3732636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E444943494F4E5F5041474F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A20202020202020203C546F703E362E33636D3C2F546F703E0D0A20202020202020203C57696474683E332E33636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E32'
		||	'70743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C4C6566743E31362E37636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214355504F4E2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A20202020202020203C546F703E362E33636D3C2F546F703E0D0A20202020202020203C57696474683E322E3634636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C4C6566743E392E37636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A20202020202020203C546F703E322E3739636D3C2F546F703E0D0A20202020202020203C57696474683E362E39636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464'
		||	'696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C4C6566743E31322E3732636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215041474F5F48415354412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78343C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E3138636D3C2F546F703E0D0A20202020202020203C57696474683E372E3234383638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C4C6566743E31322E3332636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321504552494F444F5F464143542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A20202020202020203C546F703E312E3536636D3C2F546F703E0D0A20202020202020203C57696474683E322E35636D3C2F5769'
		||	'6474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C4C6566743E31362E36636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214D45535F464143542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A20202020202020203C546F703E312E3536636D3C2F546F703E0D0A20202020202020203C57696474683E322E38636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C4C6566743E31322E32636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321464543485F464143542E56616C75652C20224C44435F4441544F535F'
		||	'434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E302E3838636D3C2F546F703E0D0A20202020202020203C57696474683E33636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4C6566743E31322E32636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E32372E39636D3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E656E2D55533C2F4C616E67756167653E0D0A20203C506167654865696768743E32372E39636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_83.cuPlantilla( 244 );
	fetch CONFEXME_83.cuPlantilla into nuIdPlantill;
	close CONFEXME_83.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'LDC_PLANTILLA_GASCARIB_NR',
		       plannomb = 'FACTURAGCNR',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 244;
	--}
	else
	--{
		-- Se inserta el formato
		INSERT INTO ed_plantill  
		(
			plancodi,
			plancont,
			plandesc,
			plannomb,
			planopen,
			plansist
		)
		VALUES
		(
			244,
			blContent ,
			'LDC_PLANTILLA_GASCARIB_NR',
			'FACTURAGCNR',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '****************************** Generando Configuración de Extracción y mezcla *******************************', 5 );
--}
END;
/

DECLARE

	-- Identificador del extractor y mezcla
	nuExtractAndMixId    ed_confexme.coemcodi%type;

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_83.cuExtractAndMix( 83 );
	fetch CONFEXME_83.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_83.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_FACT_GASCARIBE_NOREG',
		       coeminic = NULL,
		       coempada = '<264>',
		       coempadi = 'FACTURAGCNR',
		       coempame = NULL,
		       coemtido = 66,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 83;
	--}
	else
	--{
		-- Se inserta configuración de extracción y mezcla
		INSERT INTO ed_confexme 
		(
			coemcodi,
			coemdesc,
			coeminic,
			coempada,
			coempadi,
			coempame,
			coemtido,
			coemvers,
			coemvige
		)
			VALUES
		(
			83,
			'LDC_FACT_GASCARIBE_NOREG',
			NULL,
			'<264>',
			'FACTURAGCNR',
			NULL,
			66,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_83.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_83.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_83.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '***************** Realizando persistencia en la base de datos ******************', 5 );
	COMMIT;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_83 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_83'
	);
--}
END;
/

