BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_82 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_82',
		'CREATE OR REPLACE PACKAGE CONFEXME_82 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_82;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_82',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_82 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_82;'
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_82.cuFormat( 244 );
	fetch CONFEXME_82.cuFormat into nuFormatId;
	close CONFEXME_82.cuFormat;

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
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_82.cuFormat( 244 );
	fetch CONFEXME_82.cuFormat into nuFormatId;
	close CONFEXME_82.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_82.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_FACT_GASCARIBE_REG',
		       formtido = 66,
		       formiden = '<244>',
		       formtico = 49,
		       formdein = '<LDC_FACTURA>',
		       formdefi = '</LDC_FACTURA>'
		WHERE  formcodi = CONFEXME_82.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_82.rcED_Formato.formcodi := 244 ;

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
			CONFEXME_82.rcED_Formato.formcodi,
			'LDC_FACT_GASCARIBE_REG',
			66,
			'<244>',
			49,
			'<LDC_FACTURA>',
			'</LDC_FACTURA>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_82.tbrcED_Franja( 4718 ).francodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_Franja( 4718 ).francodi,
		'LDC_DATOS_GENERAL',
		CONFEXME_82.tbrcED_Franja( 4718 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_82.tbrcED_Franja( 4719 ).francodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_Franja( 4719 ).francodi,
		'LDC_DATOS_SERVICIO',
		CONFEXME_82.tbrcED_Franja( 4719 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_82.tbrcED_Franja( 4720 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_CARGOS_SPOOL]', 5 );
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
		CONFEXME_82.tbrcED_Franja( 4720 ).francodi,
		'LDC_CARGOS_SPOOL',
		CONFEXME_82.tbrcED_Franja( 4720 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_82.tbrcED_Franja( 4721 ).francodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_Franja( 4721 ).francodi,
		'LDC_RANGOS',
		CONFEXME_82.tbrcED_Franja( 4721 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_82.tbrcED_Franja( 4722 ).francodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_Franja( 4722 ).francodi,
		'LDC_REFERENCIALES',
		CONFEXME_82.tbrcED_Franja( 4722 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_82.tbrcED_Franja( 4723 ).francodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_Franja( 4723 ).francodi,
		'LDC_DATOS_MARCA',
		CONFEXME_82.tbrcED_Franja( 4723 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_82.tbrcED_Franja( 4724 ).francodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_Franja( 4724 ).francodi,
		'LDC_INFO_ADICIONAL',
		CONFEXME_82.tbrcED_Franja( 4724 ).frantifr,
		'<INFO_ADICIONALES>',
		'</INFO_ADICIONALES>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_82.tbrcED_FranForm( '4567' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_82.tbrcED_FranForm( '4567' ).frfoform := CONFEXME_82.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_82.tbrcED_Franja.exists( 4718 ) ) then
		CONFEXME_82.tbrcED_FranForm( '4567' ).frfofran := CONFEXME_82.tbrcED_Franja( 4718 ).francodi;
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
		CONFEXME_82.tbrcED_FranForm( '4567' ).frfocodi,
		CONFEXME_82.tbrcED_FranForm( '4567' ).frfoform,
		CONFEXME_82.tbrcED_FranForm( '4567' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_82.tbrcED_FranForm( '4568' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_82.tbrcED_FranForm( '4568' ).frfoform := CONFEXME_82.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_82.tbrcED_Franja.exists( 4719 ) ) then
		CONFEXME_82.tbrcED_FranForm( '4568' ).frfofran := CONFEXME_82.tbrcED_Franja( 4719 ).francodi;
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
		CONFEXME_82.tbrcED_FranForm( '4568' ).frfocodi,
		CONFEXME_82.tbrcED_FranForm( '4568' ).frfoform,
		CONFEXME_82.tbrcED_FranForm( '4568' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_82.tbrcED_FranForm( '4569' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_82.tbrcED_FranForm( '4569' ).frfoform := CONFEXME_82.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_82.tbrcED_Franja.exists( 4720 ) ) then
		CONFEXME_82.tbrcED_FranForm( '4569' ).frfofran := CONFEXME_82.tbrcED_Franja( 4720 ).francodi;
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
		CONFEXME_82.tbrcED_FranForm( '4569' ).frfocodi,
		CONFEXME_82.tbrcED_FranForm( '4569' ).frfoform,
		CONFEXME_82.tbrcED_FranForm( '4569' ).frfofran,
		3,
		'S'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_82.tbrcED_FranForm( '4570' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_82.tbrcED_FranForm( '4570' ).frfoform := CONFEXME_82.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_82.tbrcED_Franja.exists( 4721 ) ) then
		CONFEXME_82.tbrcED_FranForm( '4570' ).frfofran := CONFEXME_82.tbrcED_Franja( 4721 ).francodi;
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
		CONFEXME_82.tbrcED_FranForm( '4570' ).frfocodi,
		CONFEXME_82.tbrcED_FranForm( '4570' ).frfoform,
		CONFEXME_82.tbrcED_FranForm( '4570' ).frfofran,
		4,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_82.tbrcED_FranForm( '4571' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_82.tbrcED_FranForm( '4571' ).frfoform := CONFEXME_82.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_82.tbrcED_Franja.exists( 4722 ) ) then
		CONFEXME_82.tbrcED_FranForm( '4571' ).frfofran := CONFEXME_82.tbrcED_Franja( 4722 ).francodi;
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
		CONFEXME_82.tbrcED_FranForm( '4571' ).frfocodi,
		CONFEXME_82.tbrcED_FranForm( '4571' ).frfoform,
		CONFEXME_82.tbrcED_FranForm( '4571' ).frfofran,
		5,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_82.tbrcED_FranForm( '4572' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_82.tbrcED_FranForm( '4572' ).frfoform := CONFEXME_82.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_82.tbrcED_Franja.exists( 4723 ) ) then
		CONFEXME_82.tbrcED_FranForm( '4572' ).frfofran := CONFEXME_82.tbrcED_Franja( 4723 ).francodi;
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
		CONFEXME_82.tbrcED_FranForm( '4572' ).frfocodi,
		CONFEXME_82.tbrcED_FranForm( '4572' ).frfoform,
		CONFEXME_82.tbrcED_FranForm( '4572' ).frfofran,
		6,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_82.tbrcED_FranForm( '4573' ).frfoform := CONFEXME_82.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_82.tbrcED_Franja.exists( 4724 ) ) then
		CONFEXME_82.tbrcED_FranForm( '4573' ).frfofran := CONFEXME_82.tbrcED_Franja( 4724 ).francodi;
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
		CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi,
		CONFEXME_82.tbrcED_FranForm( '4573' ).frfoform,
		CONFEXME_82.tbrcED_FranForm( '4573' ).frfofran,
		7,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi,
		'LDC_DATOS_GENERALES',
		'LDC_DetalleFact_GasCaribe.RfDatosGenerales',
		CONFEXME_82.tbrcED_FuenDato( '3736' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3737' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3737' ).fudacodi,
		'LDC_DATOS_LECTURA',
		'ldc_detallefact_gascaribe.RfDatosLecturas',
		CONFEXME_82.tbrcED_FuenDato( '3737' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi,
		'LDC_DATOS_CONSUMO',
		'ldc_detallefact_gascaribe.RfDatosConsumoHist',
		CONFEXME_82.tbrcED_FuenDato( '3738' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3739' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3739' ).fudacodi,
		'LDC_DATOS_REVISION',
		'ldc_detallefact_gascaribe.RfDatosRevision',
		CONFEXME_82.tbrcED_FuenDato( '3739' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi,
		'LDC_CARGOS',
		'LDC_DetalleFact_GasCaribe.RfDatosConcEstadoCuenta',
		CONFEXME_82.tbrcED_FuenDato( '3740' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi,
		'LDC_RANGOS_CONSUMO',
		'LDC_DetalleFact_GasCaribe.RfRangosConsumo',
		CONFEXME_82.tbrcED_FuenDato( '3741' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3742' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3742' ).fudacodi,
		'LDC_COMPCOST',
		'LDC_DetalleFact_GasCaribe.rfGetValCostCompValid',
		CONFEXME_82.tbrcED_FuenDato( '3742' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi,
		'LDC_CUPON',
		'LDC_DetalleFact_GasCaribe.RfDatosCodBarras',
		CONFEXME_82.tbrcED_FuenDato( '3743' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3744' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [EXTRABARCODE]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_82.tbrcED_FuenDato( '3744' ).fudacodi,
		'EXTRABARCODE',
		'LDC_DetalleFact_GasCaribe.RfDatosBarCode',
		CONFEXME_82.tbrcED_FuenDato( '3744' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi,
		'LDC_TOTALES',
		'ldc_detallefact_gascaribe.RfConcepParcial',
		CONFEXME_82.tbrcED_FuenDato( '3745' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi,
		'ldc_rangos_2',
		'ldc_duplicado_meses_ant.prorangos2',
		CONFEXME_82.tbrcED_FuenDato( '3746' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3747' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3747' ).fudacodi,
		'ldc_detallefact_gascaribe.RfDatosConsumos',
		'ldc_detallefact_gascaribe.RfDatosConsumos',
		CONFEXME_82.tbrcED_FuenDato( '3747' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3748' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3748' ).fudacodi,
		'RfMarcaAguaDuplicado',
		'LDC_DETALLEFACT_GASCARIBE.RfMarcaAguaDuplicado',
		CONFEXME_82.tbrcED_FuenDato( '3748' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3749' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3749' ).fudacodi,
		'LDC_DATOS_ADICIONALES_DUPLICADO',
		'LDC_DETALLEFACT_GASCARIBE.RfDatosAdicionales',
		CONFEXME_82.tbrcED_FuenDato( '3749' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3750' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3750' ).fudacodi,
		'LDC_TASAS_CAMBIO',
		'LDC_DetalleFact_GasCaribe.rfGetValRates',
		CONFEXME_82.tbrcED_FuenDato( '3750' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3751' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3751' ).fudacodi,
		'LDC_DATOS_SPOOL',
		'ldc_detallefact_gascaribe.prodatosspool',
		CONFEXME_82.tbrcED_FuenDato( '3751' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3752' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3752' ).fudacodi,
		'LDC_PROTECCION_DATOS',
		'LDC_DETALLEFACT_GASCARIBE.RfProteccion_Datos',
		CONFEXME_82.tbrcED_FuenDato( '3752' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3753' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3753' ).fudacodi,
		'LDC_ACUMTATT',
		'ldc_detallefact_gascaribe.RfDatosCuenxCobrTt',
		CONFEXME_82.tbrcED_FuenDato( '3753' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3754' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3754' ).fudacodi,
		'LDC_FINAESPE',
		'LDC_DetalleFact_GasCaribe.RfDatosFinanEspecial',
		CONFEXME_82.tbrcED_FuenDato( '3754' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3755' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3755' ).fudacodi,
		'LDC_MEDIDOR_MAL_UBIC',
		'LDC_DetalleFact_GasCaribe.RfDatosMedMalubi',
		CONFEXME_82.tbrcED_FuenDato( '3755' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3756' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3756' ).fudacodi,
		'LDC_IMPRIME_FACTURA',
		'LDC_DetalleFact_GasCaribe.rfdatosimpresiondig',
		CONFEXME_82.tbrcED_FuenDato( '3756' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3757' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3757' ).fudacodi,
		'LDC_VALOR_FECH_ULTPAGO',
		'LDC_DetalleFact_GasCaribe.rfLastPayment',
		CONFEXME_82.tbrcED_FuenDato( '3757' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3758' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3758' ).fudacodi,
		'SALDO_ANTERIOR',
		'LDC_DetalleFact_GasCaribe.rfGetSaldoAnterior',
		CONFEXME_82.tbrcED_FuenDato( '3758' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi,
		'cargos_spool',
		'LDC_DetalleFact_GasCaribe.RfDatosConceptos',
		CONFEXME_82.tbrcED_FuenDato( '3897' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29916' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3737' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29916' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3737' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29916' ).atfdcodi,
		'NUM_MEDIDOR',
		'Num_Medidor',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29916' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29917' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3737' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29917' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3737' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29917' ).atfdcodi,
		'LECTURA_ANTERIOR',
		'Lectura_Anterior',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29917' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29918' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3737' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29918' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3737' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29918' ).atfdcodi,
		'LECTURA_ACTUAL',
		'Lectura_Actual',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29918' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29919' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3737' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29919' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3737' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29919' ).atfdcodi,
		'OBS_LECTURA',
		'Obs_Lectura',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29919' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29920' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3739' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29920' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3739' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29920' ).atfdcodi,
		'TIPO_NOTI',
		'Tipo_Noti',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29920' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29921' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3739' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29921' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3739' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29921' ).atfdcodi,
		'MENS_NOTI',
		'Mens_Noti',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29921' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29922' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3739' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29922' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3739' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29922' ).atfdcodi,
		'FECH_MAXIMA',
		'Fech_Maxima',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29922' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29923' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3739' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29923' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3739' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29923' ).atfdcodi,
		'FECH_SUSP',
		'Fech_Susp',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29923' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29924' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3741' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29924' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29924' ).atfdcodi,
		'LIM_INFERIOR',
		'Lim_Inferior',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29924' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29925' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3741' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29925' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29925' ).atfdcodi,
		'LIM_SUPERIOR',
		'Lim_Superior',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29925' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29926' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3741' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29926' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29926' ).atfdcodi,
		'VALOR_UNIDAD',
		'Valor_Unidad',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29926' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29927' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3741' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29927' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29927' ).atfdcodi,
		'CONSUMO',
		'Consumo',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29927' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29928' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3741' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29928' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29928' ).atfdcodi,
		'VAL_CONSUMO',
		'Val_Consumo',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29928' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29929' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3742' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29929' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3742' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29929' ).atfdcodi,
		'COMPCOST',
		'Compcost',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29929' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29930' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3744' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29930' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3744' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [C¿digo]', 5 );
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
		CONFEXME_82.tbrcED_AtriFuda( '29930' ).atfdcodi,
		'CODE',
		'C¿digo',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29930' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29931' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3744' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29931' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3744' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29931' ).atfdcodi,
		'IMAGE',
		'Image',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29931' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29932' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29932' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29932' ).atfdcodi,
		'LIM_INFERIOR1',
		'Lim_Inferior1',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29932' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29933' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29933' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29933' ).atfdcodi,
		'LIM_SUPERIOR1',
		'Lim_Superior1',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29933' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29934' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29934' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29934' ).atfdcodi,
		'VALOR_UNIDAD1',
		'Valor_Unidad1',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29934' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29935' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29935' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29935' ).atfdcodi,
		'CONSUMO1',
		'Consumo1',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29935' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29936' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29936' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29936' ).atfdcodi,
		'VAL_CONSUMO1',
		'Val_Consumo1',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29936' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29937' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29937' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29937' ).atfdcodi,
		'LIM_INFERIOR2',
		'Lim_Inferior2',
		6,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29937' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29938' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29938' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29938' ).atfdcodi,
		'LIM_SUPERIOR2',
		'Lim_Superior2',
		7,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29938' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29939' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29939' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29939' ).atfdcodi,
		'VALOR_UNIDAD2',
		'Valor_Unidad2',
		8,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29939' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29940' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29940' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29940' ).atfdcodi,
		'CONSUMO2',
		'Consumo2',
		9,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29940' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29941' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29941' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29941' ).atfdcodi,
		'VAL_CONSUMO2',
		'Val_Consumo2',
		10,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29941' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29942' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29942' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29942' ).atfdcodi,
		'LIM_INFERIOR3',
		'Lim_Inferior3',
		11,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29942' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29943' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29943' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29943' ).atfdcodi,
		'LIM_SUPERIOR3',
		'Lim_Superior3',
		12,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29943' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29944' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29944' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29944' ).atfdcodi,
		'VALOR_UNIDAD3',
		'Valor_Unidad3',
		13,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29944' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29945' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29945' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29945' ).atfdcodi,
		'CONSUMO3',
		'Consumo3',
		14,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29945' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29946' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29946' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29946' ).atfdcodi,
		'VAL_CONSUMO3',
		'Val_Consumo3',
		15,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29946' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29947' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29947' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29947' ).atfdcodi,
		'LIM_INFERIOR4',
		'Lim_Inferior4',
		16,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29947' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29948' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29948' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29948' ).atfdcodi,
		'LIM_SUPERIOR4',
		'Lim_Superior4',
		17,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29948' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29949' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29949' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29949' ).atfdcodi,
		'VALOR_UNIDAD4',
		'Valor_Unidad4',
		18,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29949' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29950' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29950' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29950' ).atfdcodi,
		'CONSUMO4',
		'Consumo4',
		19,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29950' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29951' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29951' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29951' ).atfdcodi,
		'VAL_CONSUMO4',
		'Val_Consumo4',
		20,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29951' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29952' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29952' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29952' ).atfdcodi,
		'LIM_INFERIOR5',
		'Lim_Inferior5',
		21,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29952' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29953' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29953' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29953' ).atfdcodi,
		'LIM_SUPERIOR5',
		'Lim_Superior5',
		22,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29953' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29954' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29954' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29954' ).atfdcodi,
		'VALOR_UNIDAD5',
		'Valor_Unidad5',
		23,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29954' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29955' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29955' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29955' ).atfdcodi,
		'CONSUMO5',
		'Consumo5',
		24,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29955' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29956' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29956' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29956' ).atfdcodi,
		'VAL_CONSUMO5',
		'Val_Consumo5',
		25,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29956' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29957' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29957' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29957' ).atfdcodi,
		'LIM_INFERIOR6',
		'Lim_Inferior6',
		26,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29957' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29958' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29958' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29958' ).atfdcodi,
		'LIM_SUPERIOR6',
		'Lim_Superior6',
		27,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29958' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29959' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29959' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29959' ).atfdcodi,
		'VALOR_UNIDAD6',
		'Valor_Unidad6',
		28,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29959' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29960' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29960' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29960' ).atfdcodi,
		'CONSUMO6',
		'Consumo6',
		29,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29960' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29961' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29961' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29961' ).atfdcodi,
		'VAL_CONSUMO6',
		'Val_Consumo6',
		30,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29961' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29962' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29962' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29962' ).atfdcodi,
		'LIM_INFERIOR7',
		'Lim_Inferior7',
		31,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29962' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29963' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29963' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29963' ).atfdcodi,
		'LIM_SUPERIOR7',
		'Lim_Superior7',
		32,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29963' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29964' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29964' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29964' ).atfdcodi,
		'VALOR_UNIDAD7',
		'Valor_Unidad7',
		33,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29964' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29965' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29965' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29965' ).atfdcodi,
		'CONSUMO',
		'Consumo',
		34,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29965' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29966' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29966' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29966' ).atfdcodi,
		'VAL_CONSUMO7',
		'Val_Consumo7',
		35,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29966' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29967' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3747' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29967' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3747' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29967' ).atfdcodi,
		'CONSUMO_MES',
		'Consumo_Mes',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29967' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29968' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3747' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29968' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3747' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29968' ).atfdcodi,
		'FECHA_CONS_MES',
		'Fecha_Cons_Mes',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29968' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29969' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3748' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29969' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3748' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29969' ).atfdcodi,
		'VISIBLE',
		'Visible',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29969' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29970' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3748' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29970' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3748' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29970' ).atfdcodi,
		'IMPRESO',
		'Impreso',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29970' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29971' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29971' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29971' ).atfdcodi,
		'ETIQUETA',
		'Etiqueta',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29971' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29972' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29972' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29972' ).atfdcodi,
		'DESC_CONCEP',
		'Desc_Concep',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29972' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29973' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29973' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29973' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29973' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29974' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29974' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29974' ).atfdcodi,
		'CAPITAL',
		'Capital',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29974' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29975' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29975' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29975' ).atfdcodi,
		'INTERES',
		'Interes',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29975' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29976' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29976' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29976' ).atfdcodi,
		'TOTAL',
		'Total',
		6,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29976' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29977' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29977' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29977' ).atfdcodi,
		'SALDO_DIF',
		'Saldo_Dif',
		7,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29977' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29978' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29978' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29978' ).atfdcodi,
		'CUOTAS',
		'Cuotas',
		8,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29978' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29979' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3749' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29979' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3749' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29979' ).atfdcodi,
		'DIRECCION_PRODUCTO',
		'Direccion_Producto',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29979' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29980' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3749' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29980' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3749' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29980' ).atfdcodi,
		'CAUSA_DESVIACION',
		'Causa_Desviacion',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29980' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29981' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3749' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29981' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3749' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29981' ).atfdcodi,
		'PAGARE_UNICO',
		'Pagare_Unico',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29981' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29982' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3749' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29982' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3749' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29982' ).atfdcodi,
		'CAMBIOUSO',
		'Cambiouso',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29982' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29983' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29983' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29983' ).atfdcodi,
		'CONS_CORREG',
		'Cons_Correg',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29983' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29984' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29984' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29984' ).atfdcodi,
		'FACTOR_CORRECCION',
		'Factor_Correccion',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29984' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29985' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29985' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29985' ).atfdcodi,
		'CONSUMO_MES_1',
		'Consumo_Mes_1',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29985' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29986' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29986' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29986' ).atfdcodi,
		'FECHA_CONS_MES_1',
		'Fecha_Cons_Mes_1',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29986' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29987' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29987' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29987' ).atfdcodi,
		'CONSUMO_MES_2',
		'Consumo_Mes_2',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29987' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29988' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29988' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29988' ).atfdcodi,
		'FECHA_CONS_MES_2',
		'Fecha_Cons_Mes_2',
		6,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29988' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29989' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29989' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29989' ).atfdcodi,
		'CONSUMO_MES_3',
		'Consumo_Mes_3',
		7,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29989' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29990' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29990' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29990' ).atfdcodi,
		'FECHA_CONS_MES_3',
		'Fecha_Cons_Mes_3',
		8,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29990' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29991' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29991' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29991' ).atfdcodi,
		'CONSUMO_MES_4',
		'Consumo_Mes_4',
		9,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29991' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29992' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29992' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29992' ).atfdcodi,
		'FECHA_CONS_MES_4',
		'Fecha_Cons_Mes_4',
		10,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29992' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29993' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29993' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29993' ).atfdcodi,
		'CONSUMO_MES_5',
		'Consumo_Mes_5',
		11,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29993' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29994' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29994' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29994' ).atfdcodi,
		'FECHA_CONS_MES_5',
		'Fecha_Cons_Mes_5',
		12,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29994' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29995' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29995' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29995' ).atfdcodi,
		'CONSUMO_MES_6',
		'Consumo_Mes_6',
		13,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29995' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29996' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29996' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29996' ).atfdcodi,
		'FECHA_CONS_MES_6',
		'Fecha_Cons_Mes_6',
		14,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29996' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29997' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29997' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29997' ).atfdcodi,
		'CONSUMO_PROMEDIO',
		'Consumo_Promedio',
		15,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29997' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29998' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29998' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29998' ).atfdcodi,
		'TEMPERATURA',
		'Temperatura',
		16,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29998' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '29999' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '29999' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '29999' ).atfdcodi,
		'PRESION',
		'Presion',
		17,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '29999' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30000' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30000' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30000' ).atfdcodi,
		'EQUIVAL_KWH',
		'Equival_Kwh',
		18,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30000' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30001' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30001' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30001' ).atfdcodi,
		'CALCULO_CONS',
		'Calculo_Cons',
		19,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30001' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30034' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3743' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30034' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30034' ).atfdcodi,
		'CODIGO_1',
		'Codigo_1',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30034' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30035' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3743' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30035' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30035' ).atfdcodi,
		'CODIGO_2',
		'Codigo_2',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30035' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30036' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3743' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30036' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30036' ).atfdcodi,
		'CODIGO_3',
		'Codigo_3',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30036' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30037' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3743' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30037' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30037' ).atfdcodi,
		'CODIGO_4',
		'Codigo_4',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30037' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30038' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3743' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30038' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30038' ).atfdcodi,
		'CODIGO_BARRAS',
		'Codigo_Barras',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30038' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30039' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3750' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30039' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3750' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30039' ).atfdcodi,
		'TASA_ULTIMA',
		'Tasa_Ultima',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30039' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30040' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3750' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30040' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3750' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30040' ).atfdcodi,
		'TASA_PROMEDIO',
		'Tasa_Promedio',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30040' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30041' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3751' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30041' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3751' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30041' ).atfdcodi,
		'CUADRILLA_REPARTO',
		'Cuadrilla_Reparto',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30041' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30042' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3751' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30042' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3751' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30042' ).atfdcodi,
		'OBSERV_NO_LECT_CONSEC',
		'Observ_No_Lect_Consec',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30042' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30043' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3752' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30043' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3752' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30043' ).atfdcodi,
		'VISIBLE',
		'Visible',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30043' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30044' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3752' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30044' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3752' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30044' ).atfdcodi,
		'IMPRESO',
		'Impreso',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30044' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30045' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3752' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30045' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3752' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30045' ).atfdcodi,
		'PROTECCION_ESTADO',
		'Proteccion_Estado',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30045' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30046' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3753' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30046' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3753' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30046' ).atfdcodi,
		'ACUMU',
		'Acumu',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30046' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30047' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3754' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30047' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3754' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30047' ).atfdcodi,
		'FINAESPE',
		'Finaespe',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30047' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30048' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3755' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30048' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3755' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30048' ).atfdcodi,
		'MED_MAL_UBICADO',
		'Med_Mal_Ubicado',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30048' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30049' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3756' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30049' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3756' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30049' ).atfdcodi,
		'IMPRIMEFACT',
		'Imprimefact',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30049' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30050' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3757' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30050' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3757' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30050' ).atfdcodi,
		'VALOR_ULT_PAGO',
		'Valor_Ult_Pago',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30050' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30051' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3757' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30051' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3757' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30051' ).atfdcodi,
		'FECHA_ULT_PAGO',
		'Fecha_Ult_Pago',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30051' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30052' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3758' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30052' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3758' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30052' ).atfdcodi,
		'SALDO_ANTE',
		'Saldo_Ante',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30052' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30849' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30849' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30849' ).atfdcodi,
		'ETIQUETA',
		'Etiqueta',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30849' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30850' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30850' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30850' ).atfdcodi,
		'CONCEPTO_ID',
		'Concepto_Id',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30850' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30851' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30851' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30851' ).atfdcodi,
		'DESC_CONCEP',
		'Desc_Concep',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30851' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30852' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30852' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30852' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30852' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30853' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30853' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30853' ).atfdcodi,
		'CAPITAL',
		'Capital',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30853' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30854' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30854' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30854' ).atfdcodi,
		'INTERES',
		'Interes',
		6,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30854' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30855' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30855' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30855' ).atfdcodi,
		'TOTAL',
		'Total',
		7,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30855' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30856' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30856' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30856' ).atfdcodi,
		'SALDO_DIF',
		'Saldo_Dif',
		8,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30856' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30857' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30857' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30857' ).atfdcodi,
		'UNIDAD_ITEMS',
		'Unidad_Items',
		9,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30857' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30858' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30858' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30858' ).atfdcodi,
		'CANTIDAD',
		'Cantidad',
		10,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30858' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30859' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30859' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30859' ).atfdcodi,
		'VALOR_UNITARIO',
		'Valor_Unitario',
		11,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30859' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30860' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30860' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30860' ).atfdcodi,
		'VALOR_IVA',
		'Valor_Iva',
		12,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30860' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30861' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30861' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30861' ).atfdcodi,
		'CUOTAS',
		'Cuotas',
		13,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30861' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30862' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3745' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30862' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30862' ).atfdcodi,
		'TOTAL',
		'Total',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30862' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30863' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3745' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30863' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30863' ).atfdcodi,
		'IVA',
		'Iva',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30863' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30864' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3745' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30864' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30864' ).atfdcodi,
		'SUBTOTAL',
		'Subtotal',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30864' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30865' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3745' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30865' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30865' ).atfdcodi,
		'CARGOSMES',
		'Cargosmes',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30865' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30866' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3745' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30866' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30866' ).atfdcodi,
		'CANTIDAD_CONC',
		'Cantidad_Conc',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30866' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30867' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30867' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30867' ).atfdcodi,
		'FACTURA',
		'Factura',
		1,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30867' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30868' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30868' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30868' ).atfdcodi,
		'FECH_FACT',
		'Fech_Fact',
		2,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30868' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30869' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30869' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30869' ).atfdcodi,
		'MES_FACT',
		'Mes_Fact',
		3,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30869' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30870' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30870' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30870' ).atfdcodi,
		'PERIODO_FACT',
		'Periodo_Fact',
		4,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30870' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30871' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30871' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30871' ).atfdcodi,
		'PAGO_HASTA',
		'Pago_Hasta',
		5,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30871' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30872' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30872' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30872' ).atfdcodi,
		'DIAS_CONSUMO',
		'Dias_Consumo',
		6,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30872' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30873' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30873' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30873' ).atfdcodi,
		'CONTRATO',
		'Contrato',
		7,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30873' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30874' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30874' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30874' ).atfdcodi,
		'CUPON',
		'Cupon',
		8,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30874' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30875' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30875' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30875' ).atfdcodi,
		'NOMBRE',
		'Nombre',
		9,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30875' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30876' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30876' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30876' ).atfdcodi,
		'DIRECCION_COBRO',
		'Direccion_Cobro',
		10,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30876' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30877' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30877' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30877' ).atfdcodi,
		'LOCALIDAD',
		'Localidad',
		11,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30877' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30878' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30878' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30878' ).atfdcodi,
		'CATEGORIA',
		'Categoria',
		12,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30878' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30879' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30879' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30879' ).atfdcodi,
		'ESTRATO',
		'Estrato',
		13,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30879' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30880' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30880' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30880' ).atfdcodi,
		'CICLO',
		'Ciclo',
		14,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30880' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30881' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30881' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30881' ).atfdcodi,
		'RUTA',
		'Ruta',
		15,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30881' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30882' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30882' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30882' ).atfdcodi,
		'MESES_DEUDA',
		'Meses_Deuda',
		16,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30882' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30883' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30883' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30883' ).atfdcodi,
		'NUM_CONTROL',
		'Num_Control',
		17,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30883' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30884' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30884' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30884' ).atfdcodi,
		'PERIODO_CONSUMO',
		'Periodo_Consumo',
		18,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30884' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30885' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30885' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30885' ).atfdcodi,
		'SALDO_FAVOR',
		'Saldo_Favor',
		19,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30885' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30886' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30886' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30886' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		20,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30886' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30887' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30887' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30887' ).atfdcodi,
		'FECHA_SUSPENSION',
		'Fecha_Suspension',
		21,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30887' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30888' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30888' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30888' ).atfdcodi,
		'VALOR_RECL',
		'Valor_Recl',
		22,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30888' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30889' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30889' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30889' ).atfdcodi,
		'TOTAL_FACTURA',
		'Total_Factura',
		23,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30889' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30890' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30890' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30890' ).atfdcodi,
		'PAGO_SIN_RECARGO',
		'Pago_Sin_Recargo',
		24,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30890' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30891' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30891' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30891' ).atfdcodi,
		'CONDICION_PAGO',
		'Condicion_Pago',
		25,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30891' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30892' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30892' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30892' ).atfdcodi,
		'IDENTIFICA',
		'Identifica',
		26,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30892' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_82.tbrcED_AtriFuda( '30893' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_AtriFuda( '30893' ).atfdfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_AtriFuda( '30893' ).atfdcodi,
		'SERVICIO',
		'Tipo de producto',
		27,
		'S',
		CONFEXME_82.tbrcED_AtriFuda( '30893' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6564 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3736' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6564 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3736' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6564 ).bloqcodi,
		'LDC_DATOS_CLIENTE',
		CONFEXME_82.tbrcED_Bloque( 6564 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6564 ).bloqfuda,
		'<LDC_DATOS_CLIENTE>',
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6565 ).bloqcodi := nuNextSeqValue;

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
		CONFEXME_82.tbrcED_Bloque( 6565 ).bloqcodi,
		'LDC_BRILLA',
		CONFEXME_82.tbrcED_Bloque( 6565 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6565 ).bloqfuda,
		NULL,
		'</LDC_DATOS_CLIENTE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6566 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3737' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6566 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3737' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6566 ).bloqcodi,
		'LDC_DATOS_LECTURA',
		CONFEXME_82.tbrcED_Bloque( 6566 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6566 ).bloqfuda,
		'<LDC_DATOS_LECTURA>',
		'</LDC_DATOS_LECTURA>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6567 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3738' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6567 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3738' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6567 ).bloqcodi,
		'LDC_DATOS_CONSUMO',
		CONFEXME_82.tbrcED_Bloque( 6567 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6567 ).bloqfuda,
		'<LDC_DATOS_CONSUMO>',
		'</LDC_DATOS_CONSUMO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6568 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3739' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6568 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3739' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6568 ).bloqcodi,
		'LDC_DATOS_REVISION',
		CONFEXME_82.tbrcED_Bloque( 6568 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6568 ).bloqfuda,
		'<LDC_DATOS_REVISION>',
		'</LDC_DATOS_REVISION>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6569 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3740' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6569 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3740' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6569 ).bloqcodi,
		'LDC_CARGOS',
		CONFEXME_82.tbrcED_Bloque( 6569 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6569 ).bloqfuda,
		'<LDC_CARGOS>',
		'</LDC_CARGOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6570 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3741' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6570 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3741' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6570 ).bloqcodi,
		'LDC_RANGOS',
		CONFEXME_82.tbrcED_Bloque( 6570 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6570 ).bloqfuda,
		'<LDC_RANGOS>',
		'</LDC_RANGOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6571 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3742' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6571 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3742' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6571 ).bloqcodi,
		'LDC_COMPCOST',
		CONFEXME_82.tbrcED_Bloque( 6571 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6571 ).bloqfuda,
		'<LDC_COMPCOST>',
		'</LDC_COMPCOST>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6572 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3743' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6572 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3743' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6572 ).bloqcodi,
		'LDC_CUPON',
		CONFEXME_82.tbrcED_Bloque( 6572 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6572 ).bloqfuda,
		'<LDC_CUPON>',
		'</LDC_CUPON>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6573 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3744' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6573 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3744' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6573 ).bloqcodi,
		'BARCODE',
		CONFEXME_82.tbrcED_Bloque( 6573 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6573 ).bloqfuda,
		'<EXTRA_BARCODE_>',
		'</EXTRA_BARCODE_>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6574 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3745' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6574 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3745' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6574 ).bloqcodi,
		'LDC_TOTALES',
		CONFEXME_82.tbrcED_Bloque( 6574 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6574 ).bloqfuda,
		'<LDC_TOTALES>',
		'</LDC_TOTALES>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6575 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3746' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6575 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3746' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6575 ).bloqcodi,
		'LDC_RANGOS_2',
		CONFEXME_82.tbrcED_Bloque( 6575 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6575 ).bloqfuda,
		'<LDC_RANGOS_2>',
		'</LDC_RANGOS_2>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6576 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3747' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6576 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3747' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6576 ).bloqcodi,
		'LDC_CONSUMOS_HIST',
		CONFEXME_82.tbrcED_Bloque( 6576 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6576 ).bloqfuda,
		'<LDC_CONSUMOS_HIST>',
		'</LDC_CONSUMOS_HIST>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6577 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3748' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6577 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3748' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6577 ).bloqcodi,
		'LDC_DATOS_MARCA',
		CONFEXME_82.tbrcED_Bloque( 6577 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6577 ).bloqfuda,
		'<LDC_DATOS_MARCA>',
		'</LDC_DATOS_MARCA>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6578 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3749' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6578 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3749' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6578 ).bloqcodi,
		'DATOS_ADICIONALES',
		CONFEXME_82.tbrcED_Bloque( 6578 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6578 ).bloqfuda,
		'<DATOS_ADICIONALES>',
		'</DATOS_ADICIONALES>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6579 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3750' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6579 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3750' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6579 ).bloqcodi,
		'LDC_TASAS_CAMBIO',
		CONFEXME_82.tbrcED_Bloque( 6579 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6579 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6580 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3751' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6580 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3751' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6580 ).bloqcodi,
		'LDC_DATOS_SPOOL',
		CONFEXME_82.tbrcED_Bloque( 6580 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6580 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6581 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3752' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6581 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3752' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6581 ).bloqcodi,
		'PROTECCION_DATOS',
		CONFEXME_82.tbrcED_Bloque( 6581 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6581 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6582 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3753' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6582 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3753' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6582 ).bloqcodi,
		'LDC_ACUMTATT',
		CONFEXME_82.tbrcED_Bloque( 6582 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6582 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6583 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3754' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6583 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3754' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6583 ).bloqcodi,
		'LDC_FINAESPE',
		CONFEXME_82.tbrcED_Bloque( 6583 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6583 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6584 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3755' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6584 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3755' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6584 ).bloqcodi,
		'LDC_MEDIDOR_MAL_UBIC',
		CONFEXME_82.tbrcED_Bloque( 6584 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6584 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6585 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3756' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6585 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3756' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6585 ).bloqcodi,
		'LDC_IMPRIME_FACTURA',
		CONFEXME_82.tbrcED_Bloque( 6585 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6585 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6586 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3757' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6586 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3757' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6586 ).bloqcodi,
		'LDC_VALOR_FECH_ULTPAGO',
		CONFEXME_82.tbrcED_Bloque( 6586 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6586 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6587 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3758' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6587 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3758' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6587 ).bloqcodi,
		'SALDO_ANTERIOR',
		CONFEXME_82.tbrcED_Bloque( 6587 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6587 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_82.tbrcED_Bloque( 6784 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_82.tbrcED_FuenDato.exists( '3897' ) ) then
		CONFEXME_82.tbrcED_Bloque( 6784 ).bloqfuda := CONFEXME_82.tbrcED_FuenDato( '3897' ).fudacodi;
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
		CONFEXME_82.tbrcED_Bloque( 6784 ).bloqcodi,
		'LDC_CARGOS_SPOOL',
		CONFEXME_82.tbrcED_Bloque( 6784 ).bloqtibl,
		CONFEXME_82.tbrcED_Bloque( 6784 ).bloqfuda,
		'<CARGOS_SPOOL>',
		'</CARGOS_SPOOL>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4567' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6564 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6564 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrfrfo,
		2,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6729' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6729' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4567' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6565 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6729' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6565 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6729' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6729' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6729' ).blfrfrfo,
		4,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4568' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6566 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6566 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrfrfo,
		1,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4568' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6567 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6567 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrfrfo,
		2,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4568' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6568 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6568 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrfrfo,
		3,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4569' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6569 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6569 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrfrfo,
		10,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4570' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6570 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6570 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrfrfo,
		0,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4571' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6571 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6571 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrfrfo,
		1,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4571' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6572 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6572 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrfrfo,
		2,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4571' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6573 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6573 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrfrfo,
		3,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4569' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6574 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6574 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrfrfo,
		0,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4570' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6575 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6575 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrfrfo,
		1,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4568' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6576 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6576 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4572' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6577 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6577 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4572' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6578 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6578 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrfrfo,
		1,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6579 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6579 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrfrfo,
		0,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6580 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6580 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrfrfo,
		1,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6581 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6581 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrfrfo,
		2,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6746' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6746' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6582 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6746' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6582 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6746' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6746' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6746' ).blfrfrfo,
		3,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6747' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6747' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6583 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6747' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6583 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6747' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6747' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6747' ).blfrfrfo,
		4,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6748' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6748' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6584 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6748' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6584 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6748' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6748' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6748' ).blfrfrfo,
		5,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6749' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6749' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6585 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6749' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6585 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6749' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6749' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6749' ).blfrfrfo,
		6,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6586 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6586 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrfrfo,
		7,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6751' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6751' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4573' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6587 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6751' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6587 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6751' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6751' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6751' ).blfrfrfo,
		8,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrfrfo := CONFEXME_82.tbrcED_FranForm( '4569' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_82.tbrcED_Bloque.exists( 6784 ) ) then
		CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrbloq := CONFEXME_82.tbrcED_Bloque( 6784 ).bloqcodi;
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
		CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi,
		CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrbloq,
		CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrfrfo,
		11,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
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

	open CONFEXME_82.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_82.cuGR_Config_Expression into rcExpression;
	close CONFEXME_82.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_82.tbrcGR_Config_Expression( '121403753' ) := CONFEXME_82.rcNullExpression;
	else
		CONFEXME_82.tbrcGR_Config_Expression( '121403753' ) := rcExpression;
		CONFEXME_82.ExecuteSQLSentence( CONFEXME_82.tbrcGR_Config_Expression( '121403753' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35221' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35221' ).itemobna := 'GCFIFA_CT49E121403753';

	-- Se asigna la expresión del item
	if ( CONFEXME_82.tbrcGR_Config_Expression.exists( '121403753' ) ) then
		CONFEXME_82.tbrcED_Item( '35221' ).itemobna := CONFEXME_82.tbrcGR_Config_Expression( '121403753' ).object_name;
		CONFEXME_82.tbrcED_Item( '35221' ).itemceid := CONFEXME_82.tbrcGR_Config_Expression( '121403753' ).config_expression_id;
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
		CONFEXME_82.tbrcED_Item( '35221' ).itemcodi,
		'CUPO_BRILLA',
		CONFEXME_82.tbrcED_Item( '35221' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35221' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35221' ).itemgren,
		NULL,
		NULL,
		'<CUPO_BRILLA>',
		'</CUPO_BRILLA>',
		CONFEXME_82.tbrcED_Item( '35221' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35222' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35222' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29916' ) ) then
		CONFEXME_82.tbrcED_Item( '35222' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29916' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35222' ).itemcodi,
		'Num_Medidor',
		CONFEXME_82.tbrcED_Item( '35222' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35222' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35222' ).itemgren,
		NULL,
		1,
		'<NUM_MEDIDOR>',
		'</NUM_MEDIDOR>',
		CONFEXME_82.tbrcED_Item( '35222' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35223' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35223' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29917' ) ) then
		CONFEXME_82.tbrcED_Item( '35223' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29917' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35223' ).itemcodi,
		'Lectura_Anterior',
		CONFEXME_82.tbrcED_Item( '35223' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35223' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35223' ).itemgren,
		NULL,
		1,
		'<LECTURA_ANTERIOR>',
		'</LECTURA_ANTERIOR>',
		CONFEXME_82.tbrcED_Item( '35223' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35224' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35224' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29918' ) ) then
		CONFEXME_82.tbrcED_Item( '35224' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29918' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35224' ).itemcodi,
		'Lectura_Actual',
		CONFEXME_82.tbrcED_Item( '35224' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35224' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35224' ).itemgren,
		NULL,
		1,
		'<LECTURA_ACTUAL>',
		'</LECTURA_ACTUAL>',
		CONFEXME_82.tbrcED_Item( '35224' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35225' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35225' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29919' ) ) then
		CONFEXME_82.tbrcED_Item( '35225' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29919' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35225' ).itemcodi,
		'Obs_Lectura',
		CONFEXME_82.tbrcED_Item( '35225' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35225' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35225' ).itemgren,
		NULL,
		1,
		'<OBS_LECTURA>',
		'</OBS_LECTURA>',
		CONFEXME_82.tbrcED_Item( '35225' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35226' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35226' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29920' ) ) then
		CONFEXME_82.tbrcED_Item( '35226' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29920' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35226' ).itemcodi,
		'Tipo_Noti',
		CONFEXME_82.tbrcED_Item( '35226' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35226' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35226' ).itemgren,
		NULL,
		2,
		'<TIPO_NOTI>',
		'</TIPO_NOTI>',
		CONFEXME_82.tbrcED_Item( '35226' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35227' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35227' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29921' ) ) then
		CONFEXME_82.tbrcED_Item( '35227' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29921' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35227' ).itemcodi,
		'Mens_Noti',
		CONFEXME_82.tbrcED_Item( '35227' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35227' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35227' ).itemgren,
		NULL,
		1,
		'<MENS_NOTI>',
		'</MENS_NOTI>',
		CONFEXME_82.tbrcED_Item( '35227' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35228' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35228' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29922' ) ) then
		CONFEXME_82.tbrcED_Item( '35228' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29922' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35228' ).itemcodi,
		'Fech_Maxima',
		CONFEXME_82.tbrcED_Item( '35228' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35228' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35228' ).itemgren,
		NULL,
		1,
		'<FECH_MAXIMA>',
		'</FECH_MAXIMA>',
		CONFEXME_82.tbrcED_Item( '35228' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35229' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35229' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29923' ) ) then
		CONFEXME_82.tbrcED_Item( '35229' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29923' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35229' ).itemcodi,
		'Fech_Susp',
		CONFEXME_82.tbrcED_Item( '35229' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35229' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35229' ).itemgren,
		NULL,
		1,
		'<FECH_SUSP>',
		'</FECH_SUSP>',
		CONFEXME_82.tbrcED_Item( '35229' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35230' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35230' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29924' ) ) then
		CONFEXME_82.tbrcED_Item( '35230' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29924' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35230' ).itemcodi,
		'Lim_Inferior',
		CONFEXME_82.tbrcED_Item( '35230' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35230' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35230' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR>',
		'</LIM_INFERIOR>',
		CONFEXME_82.tbrcED_Item( '35230' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35231' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35231' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29925' ) ) then
		CONFEXME_82.tbrcED_Item( '35231' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29925' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35231' ).itemcodi,
		'Lim_Superior',
		CONFEXME_82.tbrcED_Item( '35231' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35231' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35231' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR>',
		'</LIM_SUPERIOR>',
		CONFEXME_82.tbrcED_Item( '35231' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35232' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35232' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29926' ) ) then
		CONFEXME_82.tbrcED_Item( '35232' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29926' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35232' ).itemcodi,
		'Valor_Unidad',
		CONFEXME_82.tbrcED_Item( '35232' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35232' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35232' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD>',
		'</VALOR_UNIDAD>',
		CONFEXME_82.tbrcED_Item( '35232' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35233' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35233' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29927' ) ) then
		CONFEXME_82.tbrcED_Item( '35233' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29927' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35233' ).itemcodi,
		'Consumo',
		CONFEXME_82.tbrcED_Item( '35233' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35233' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35233' ).itemgren,
		NULL,
		1,
		'<CONSUMO>',
		'</CONSUMO>',
		CONFEXME_82.tbrcED_Item( '35233' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35234' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35234' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29928' ) ) then
		CONFEXME_82.tbrcED_Item( '35234' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29928' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35234' ).itemcodi,
		'Val_Consumo',
		CONFEXME_82.tbrcED_Item( '35234' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35234' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35234' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO>',
		'</VAL_CONSUMO>',
		CONFEXME_82.tbrcED_Item( '35234' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35235' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35235' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29929' ) ) then
		CONFEXME_82.tbrcED_Item( '35235' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29929' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35235' ).itemcodi,
		'Compcost',
		CONFEXME_82.tbrcED_Item( '35235' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35235' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35235' ).itemgren,
		NULL,
		1,
		'<COMPCOST>',
		'</COMPCOST>',
		CONFEXME_82.tbrcED_Item( '35235' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35236' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35236' ).itemobna := NULL;

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
		CONFEXME_82.tbrcED_Item( '35236' ).itemcodi,
		'ValoresRef',
		CONFEXME_82.tbrcED_Item( '35236' ).itemceid,
		'DES(h)=0 IPLI=100% IO=100% IRST=NO APLICA',
		CONFEXME_82.tbrcED_Item( '35236' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35236' ).itemgren,
		NULL,
		1,
		'<VALORESREF>',
		'</VALORESREF>',
		CONFEXME_82.tbrcED_Item( '35236' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35237' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35237' ).itemobna := NULL;

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
		CONFEXME_82.tbrcED_Item( '35237' ).itemcodi,
		'ValCalc',
		CONFEXME_82.tbrcED_Item( '35237' ).itemceid,
		'DES(h)=0 COMPENSACION($)=0',
		CONFEXME_82.tbrcED_Item( '35237' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35237' ).itemgren,
		NULL,
		1,
		'<VALCALC>',
		'</VALCALC>',
		CONFEXME_82.tbrcED_Item( '35237' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35238' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35238' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29930' ) ) then
		CONFEXME_82.tbrcED_Item( '35238' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29930' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [C¿digo]', 5 );
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
		CONFEXME_82.tbrcED_Item( '35238' ).itemcodi,
		'C¿digo',
		CONFEXME_82.tbrcED_Item( '35238' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35238' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35238' ).itemgren,
		NULL,
		1,
		'<CODE>',
		'</CODE>',
		CONFEXME_82.tbrcED_Item( '35238' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35239' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35239' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29931' ) ) then
		CONFEXME_82.tbrcED_Item( '35239' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29931' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35239' ).itemcodi,
		'Image',
		CONFEXME_82.tbrcED_Item( '35239' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35239' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35239' ).itemgren,
		NULL,
		1,
		'<IMAGE>',
		'</IMAGE>',
		CONFEXME_82.tbrcED_Item( '35239' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35240' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35240' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29932' ) ) then
		CONFEXME_82.tbrcED_Item( '35240' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29932' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35240' ).itemcodi,
		'Lim_Inferior1',
		CONFEXME_82.tbrcED_Item( '35240' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35240' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35240' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR1>',
		'</LIM_INFERIOR1>',
		CONFEXME_82.tbrcED_Item( '35240' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35241' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35241' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29933' ) ) then
		CONFEXME_82.tbrcED_Item( '35241' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29933' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35241' ).itemcodi,
		'Lim_Superior1',
		CONFEXME_82.tbrcED_Item( '35241' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35241' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35241' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR1>',
		'</LIM_SUPERIOR1>',
		CONFEXME_82.tbrcED_Item( '35241' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35242' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35242' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29934' ) ) then
		CONFEXME_82.tbrcED_Item( '35242' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29934' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35242' ).itemcodi,
		'Valor_Unidad1',
		CONFEXME_82.tbrcED_Item( '35242' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35242' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35242' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD1>',
		'</VALOR_UNIDAD1>',
		CONFEXME_82.tbrcED_Item( '35242' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35243' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35243' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29935' ) ) then
		CONFEXME_82.tbrcED_Item( '35243' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29935' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35243' ).itemcodi,
		'Consumo1',
		CONFEXME_82.tbrcED_Item( '35243' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35243' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35243' ).itemgren,
		NULL,
		1,
		'<CONSUMO1>',
		'</CONSUMO1>',
		CONFEXME_82.tbrcED_Item( '35243' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35244' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35244' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29936' ) ) then
		CONFEXME_82.tbrcED_Item( '35244' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29936' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35244' ).itemcodi,
		'Val_Consumo1',
		CONFEXME_82.tbrcED_Item( '35244' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35244' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35244' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO1>',
		'</VAL_CONSUMO1>',
		CONFEXME_82.tbrcED_Item( '35244' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35245' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35245' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29937' ) ) then
		CONFEXME_82.tbrcED_Item( '35245' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29937' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35245' ).itemcodi,
		'Lim_Inferior2',
		CONFEXME_82.tbrcED_Item( '35245' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35245' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35245' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR2>',
		'</LIM_INFERIOR2>',
		CONFEXME_82.tbrcED_Item( '35245' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35246' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35246' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29938' ) ) then
		CONFEXME_82.tbrcED_Item( '35246' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29938' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35246' ).itemcodi,
		'Lim_Superior2',
		CONFEXME_82.tbrcED_Item( '35246' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35246' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35246' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR2>',
		'</LIM_SUPERIOR2>',
		CONFEXME_82.tbrcED_Item( '35246' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35247' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35247' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29939' ) ) then
		CONFEXME_82.tbrcED_Item( '35247' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29939' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35247' ).itemcodi,
		'Valor_Unidad2',
		CONFEXME_82.tbrcED_Item( '35247' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35247' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35247' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD2>',
		'</VALOR_UNIDAD2>',
		CONFEXME_82.tbrcED_Item( '35247' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35248' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35248' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29940' ) ) then
		CONFEXME_82.tbrcED_Item( '35248' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29940' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35248' ).itemcodi,
		'Consumo2',
		CONFEXME_82.tbrcED_Item( '35248' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35248' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35248' ).itemgren,
		NULL,
		1,
		'<CONSUMO2>',
		'</CONSUMO2>',
		CONFEXME_82.tbrcED_Item( '35248' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35249' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35249' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29941' ) ) then
		CONFEXME_82.tbrcED_Item( '35249' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29941' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35249' ).itemcodi,
		'Val_Consumo2',
		CONFEXME_82.tbrcED_Item( '35249' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35249' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35249' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO2>',
		'</VAL_CONSUMO2>',
		CONFEXME_82.tbrcED_Item( '35249' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35250' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35250' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29942' ) ) then
		CONFEXME_82.tbrcED_Item( '35250' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29942' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35250' ).itemcodi,
		'Lim_Inferior3',
		CONFEXME_82.tbrcED_Item( '35250' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35250' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35250' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR3>',
		'</LIM_INFERIOR3>',
		CONFEXME_82.tbrcED_Item( '35250' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35251' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35251' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29943' ) ) then
		CONFEXME_82.tbrcED_Item( '35251' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29943' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35251' ).itemcodi,
		'Lim_Superior3',
		CONFEXME_82.tbrcED_Item( '35251' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35251' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35251' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR3>',
		'</LIM_SUPERIOR3>',
		CONFEXME_82.tbrcED_Item( '35251' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35252' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35252' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29944' ) ) then
		CONFEXME_82.tbrcED_Item( '35252' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29944' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35252' ).itemcodi,
		'Valor_Unidad3',
		CONFEXME_82.tbrcED_Item( '35252' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35252' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35252' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD3>',
		'</VALOR_UNIDAD3>',
		CONFEXME_82.tbrcED_Item( '35252' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35253' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35253' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29945' ) ) then
		CONFEXME_82.tbrcED_Item( '35253' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29945' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35253' ).itemcodi,
		'Consumo3',
		CONFEXME_82.tbrcED_Item( '35253' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35253' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35253' ).itemgren,
		NULL,
		1,
		'<CONSUMO3>',
		'</CONSUMO3>',
		CONFEXME_82.tbrcED_Item( '35253' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35254' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35254' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29946' ) ) then
		CONFEXME_82.tbrcED_Item( '35254' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29946' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35254' ).itemcodi,
		'Val_Consumo3',
		CONFEXME_82.tbrcED_Item( '35254' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35254' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35254' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO3>',
		'</VAL_CONSUMO3>',
		CONFEXME_82.tbrcED_Item( '35254' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35255' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35255' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29947' ) ) then
		CONFEXME_82.tbrcED_Item( '35255' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29947' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35255' ).itemcodi,
		'Lim_Inferior4',
		CONFEXME_82.tbrcED_Item( '35255' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35255' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35255' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR4>',
		'</LIM_INFERIOR4>',
		CONFEXME_82.tbrcED_Item( '35255' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35256' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35256' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29948' ) ) then
		CONFEXME_82.tbrcED_Item( '35256' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29948' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35256' ).itemcodi,
		'Lim_Superior4',
		CONFEXME_82.tbrcED_Item( '35256' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35256' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35256' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR4>',
		'</LIM_SUPERIOR4>',
		CONFEXME_82.tbrcED_Item( '35256' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35257' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35257' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29949' ) ) then
		CONFEXME_82.tbrcED_Item( '35257' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29949' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35257' ).itemcodi,
		'Valor_Unidad4',
		CONFEXME_82.tbrcED_Item( '35257' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35257' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35257' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD4>',
		'</VALOR_UNIDAD4>',
		CONFEXME_82.tbrcED_Item( '35257' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35258' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35258' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29950' ) ) then
		CONFEXME_82.tbrcED_Item( '35258' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29950' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35258' ).itemcodi,
		'Consumo4',
		CONFEXME_82.tbrcED_Item( '35258' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35258' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35258' ).itemgren,
		NULL,
		1,
		'<CONSUMO4>',
		'</CONSUMO4>',
		CONFEXME_82.tbrcED_Item( '35258' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35259' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35259' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29951' ) ) then
		CONFEXME_82.tbrcED_Item( '35259' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29951' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35259' ).itemcodi,
		'Val_Consumo4',
		CONFEXME_82.tbrcED_Item( '35259' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35259' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35259' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO4>',
		'</VAL_CONSUMO4>',
		CONFEXME_82.tbrcED_Item( '35259' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35260' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35260' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29952' ) ) then
		CONFEXME_82.tbrcED_Item( '35260' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29952' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35260' ).itemcodi,
		'Lim_Inferior5',
		CONFEXME_82.tbrcED_Item( '35260' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35260' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35260' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR5>',
		'</LIM_INFERIOR5>',
		CONFEXME_82.tbrcED_Item( '35260' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35261' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35261' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29953' ) ) then
		CONFEXME_82.tbrcED_Item( '35261' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29953' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35261' ).itemcodi,
		'Lim_Superior5',
		CONFEXME_82.tbrcED_Item( '35261' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35261' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35261' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR5>',
		'</LIM_SUPERIOR5>',
		CONFEXME_82.tbrcED_Item( '35261' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35262' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35262' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29954' ) ) then
		CONFEXME_82.tbrcED_Item( '35262' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29954' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35262' ).itemcodi,
		'Valor_Unidad5',
		CONFEXME_82.tbrcED_Item( '35262' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35262' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35262' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD5>',
		'</VALOR_UNIDAD5>',
		CONFEXME_82.tbrcED_Item( '35262' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35263' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35263' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29955' ) ) then
		CONFEXME_82.tbrcED_Item( '35263' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29955' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35263' ).itemcodi,
		'Consumo5',
		CONFEXME_82.tbrcED_Item( '35263' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35263' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35263' ).itemgren,
		NULL,
		1,
		'<CONSUMO5>',
		'</CONSUMO5>',
		CONFEXME_82.tbrcED_Item( '35263' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35264' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35264' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29956' ) ) then
		CONFEXME_82.tbrcED_Item( '35264' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29956' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35264' ).itemcodi,
		'Val_Consumo5',
		CONFEXME_82.tbrcED_Item( '35264' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35264' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35264' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO5>',
		'</VAL_CONSUMO5>',
		CONFEXME_82.tbrcED_Item( '35264' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35265' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35265' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29957' ) ) then
		CONFEXME_82.tbrcED_Item( '35265' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29957' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35265' ).itemcodi,
		'Lim_Inferior6',
		CONFEXME_82.tbrcED_Item( '35265' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35265' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35265' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR6>',
		'</LIM_INFERIOR6>',
		CONFEXME_82.tbrcED_Item( '35265' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35266' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35266' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29958' ) ) then
		CONFEXME_82.tbrcED_Item( '35266' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29958' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35266' ).itemcodi,
		'Lim_Superior6',
		CONFEXME_82.tbrcED_Item( '35266' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35266' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35266' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR6>',
		'</LIM_SUPERIOR6>',
		CONFEXME_82.tbrcED_Item( '35266' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35267' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35267' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29959' ) ) then
		CONFEXME_82.tbrcED_Item( '35267' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29959' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35267' ).itemcodi,
		'Valor_Unidad6',
		CONFEXME_82.tbrcED_Item( '35267' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35267' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35267' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD6>',
		'</VALOR_UNIDAD6>',
		CONFEXME_82.tbrcED_Item( '35267' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35268' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35268' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29960' ) ) then
		CONFEXME_82.tbrcED_Item( '35268' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29960' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35268' ).itemcodi,
		'Consumo6',
		CONFEXME_82.tbrcED_Item( '35268' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35268' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35268' ).itemgren,
		NULL,
		1,
		'<CONSUMO6>',
		'</CONSUMO6>',
		CONFEXME_82.tbrcED_Item( '35268' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35269' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35269' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29961' ) ) then
		CONFEXME_82.tbrcED_Item( '35269' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29961' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35269' ).itemcodi,
		'Val_Consumo6',
		CONFEXME_82.tbrcED_Item( '35269' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35269' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35269' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO6>',
		'</VAL_CONSUMO6>',
		CONFEXME_82.tbrcED_Item( '35269' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35270' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35270' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29962' ) ) then
		CONFEXME_82.tbrcED_Item( '35270' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29962' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35270' ).itemcodi,
		'Lim_Inferior7',
		CONFEXME_82.tbrcED_Item( '35270' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35270' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35270' ).itemgren,
		NULL,
		1,
		'<LIM_INFERIOR7>',
		'</LIM_INFERIOR7>',
		CONFEXME_82.tbrcED_Item( '35270' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35271' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35271' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29963' ) ) then
		CONFEXME_82.tbrcED_Item( '35271' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29963' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35271' ).itemcodi,
		'Lim_Superior7',
		CONFEXME_82.tbrcED_Item( '35271' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35271' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35271' ).itemgren,
		NULL,
		1,
		'<LIM_SUPERIOR7>',
		'</LIM_SUPERIOR7>',
		CONFEXME_82.tbrcED_Item( '35271' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35272' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35272' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29964' ) ) then
		CONFEXME_82.tbrcED_Item( '35272' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29964' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35272' ).itemcodi,
		'Valor_Unidad7',
		CONFEXME_82.tbrcED_Item( '35272' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35272' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35272' ).itemgren,
		NULL,
		1,
		'<VALOR_UNIDAD7>',
		'</VALOR_UNIDAD7>',
		CONFEXME_82.tbrcED_Item( '35272' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35273' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35273' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29965' ) ) then
		CONFEXME_82.tbrcED_Item( '35273' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29965' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35273' ).itemcodi,
		'Consumo',
		CONFEXME_82.tbrcED_Item( '35273' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35273' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35273' ).itemgren,
		NULL,
		1,
		'<CONSUMO>',
		'</CONSUMO>',
		CONFEXME_82.tbrcED_Item( '35273' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35274' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35274' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29966' ) ) then
		CONFEXME_82.tbrcED_Item( '35274' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29966' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35274' ).itemcodi,
		'Val_Consumo7',
		CONFEXME_82.tbrcED_Item( '35274' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35274' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35274' ).itemgren,
		NULL,
		1,
		'<VAL_CONSUMO7>',
		'</VAL_CONSUMO7>',
		CONFEXME_82.tbrcED_Item( '35274' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35275' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35275' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29967' ) ) then
		CONFEXME_82.tbrcED_Item( '35275' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29967' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35275' ).itemcodi,
		'Consumo_Mes',
		CONFEXME_82.tbrcED_Item( '35275' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35275' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35275' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES>',
		'</CONSUMO_MES>',
		CONFEXME_82.tbrcED_Item( '35275' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35276' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35276' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29968' ) ) then
		CONFEXME_82.tbrcED_Item( '35276' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29968' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35276' ).itemcodi,
		'Fecha_Cons_Mes',
		CONFEXME_82.tbrcED_Item( '35276' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35276' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35276' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES>',
		'</FECHA_CONS_MES>',
		CONFEXME_82.tbrcED_Item( '35276' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35277' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35277' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29969' ) ) then
		CONFEXME_82.tbrcED_Item( '35277' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29969' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35277' ).itemcodi,
		'Visible',
		CONFEXME_82.tbrcED_Item( '35277' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35277' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35277' ).itemgren,
		NULL,
		2,
		'<VISIBLE>',
		'</VISIBLE>',
		CONFEXME_82.tbrcED_Item( '35277' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35278' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35278' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29970' ) ) then
		CONFEXME_82.tbrcED_Item( '35278' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29970' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35278' ).itemcodi,
		'Impreso',
		CONFEXME_82.tbrcED_Item( '35278' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35278' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35278' ).itemgren,
		NULL,
		1,
		'<IMPRESO>',
		'</IMPRESO>',
		CONFEXME_82.tbrcED_Item( '35278' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35279' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35279' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29971' ) ) then
		CONFEXME_82.tbrcED_Item( '35279' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29971' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35279' ).itemcodi,
		'Etiqueta',
		CONFEXME_82.tbrcED_Item( '35279' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35279' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35279' ).itemgren,
		NULL,
		2,
		'<ETIQUETA>',
		'</ETIQUETA>',
		CONFEXME_82.tbrcED_Item( '35279' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35280' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35280' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29972' ) ) then
		CONFEXME_82.tbrcED_Item( '35280' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29972' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35280' ).itemcodi,
		'Desc_Concep',
		CONFEXME_82.tbrcED_Item( '35280' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35280' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35280' ).itemgren,
		NULL,
		1,
		'<DESC_CONCEP>',
		'</DESC_CONCEP>',
		CONFEXME_82.tbrcED_Item( '35280' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35281' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35281' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29973' ) ) then
		CONFEXME_82.tbrcED_Item( '35281' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29973' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35281' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_82.tbrcED_Item( '35281' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35281' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35281' ).itemgren,
		NULL,
		1,
		'<SALDO_ANT>',
		'</SALDO_ANT>',
		CONFEXME_82.tbrcED_Item( '35281' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35282' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35282' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29974' ) ) then
		CONFEXME_82.tbrcED_Item( '35282' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29974' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35282' ).itemcodi,
		'Capital',
		CONFEXME_82.tbrcED_Item( '35282' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35282' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35282' ).itemgren,
		NULL,
		1,
		'<CAPITAL>',
		'</CAPITAL>',
		CONFEXME_82.tbrcED_Item( '35282' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35283' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35283' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29975' ) ) then
		CONFEXME_82.tbrcED_Item( '35283' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29975' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35283' ).itemcodi,
		'Interes',
		CONFEXME_82.tbrcED_Item( '35283' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35283' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35283' ).itemgren,
		NULL,
		1,
		'<INTERES>',
		'</INTERES>',
		CONFEXME_82.tbrcED_Item( '35283' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35284' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35284' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29976' ) ) then
		CONFEXME_82.tbrcED_Item( '35284' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29976' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35284' ).itemcodi,
		'Total',
		CONFEXME_82.tbrcED_Item( '35284' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35284' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35284' ).itemgren,
		NULL,
		1,
		'<TOTAL>',
		'</TOTAL>',
		CONFEXME_82.tbrcED_Item( '35284' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35285' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35285' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29977' ) ) then
		CONFEXME_82.tbrcED_Item( '35285' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29977' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35285' ).itemcodi,
		'Saldo_Dif',
		CONFEXME_82.tbrcED_Item( '35285' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35285' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35285' ).itemgren,
		NULL,
		1,
		'<SALDO_DIF>',
		'</SALDO_DIF>',
		CONFEXME_82.tbrcED_Item( '35285' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35286' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35286' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29978' ) ) then
		CONFEXME_82.tbrcED_Item( '35286' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29978' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35286' ).itemcodi,
		'Cuotas',
		CONFEXME_82.tbrcED_Item( '35286' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35286' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35286' ).itemgren,
		NULL,
		2,
		'<CUOTAS>',
		'</CUOTAS>',
		CONFEXME_82.tbrcED_Item( '35286' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35287' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35287' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29979' ) ) then
		CONFEXME_82.tbrcED_Item( '35287' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29979' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35287' ).itemcodi,
		'Direccion_Producto',
		CONFEXME_82.tbrcED_Item( '35287' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35287' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35287' ).itemgren,
		NULL,
		1,
		'<DIRECCION_PRODUCTO>',
		'</DIRECCION_PRODUCTO>',
		CONFEXME_82.tbrcED_Item( '35287' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35288' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35288' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29980' ) ) then
		CONFEXME_82.tbrcED_Item( '35288' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29980' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35288' ).itemcodi,
		'Causa_Desviacion',
		CONFEXME_82.tbrcED_Item( '35288' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35288' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35288' ).itemgren,
		NULL,
		1,
		'<CAUSA_DESVIACION>',
		'</CAUSA_DESVIACION>',
		CONFEXME_82.tbrcED_Item( '35288' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35289' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35289' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29981' ) ) then
		CONFEXME_82.tbrcED_Item( '35289' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29981' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35289' ).itemcodi,
		'Pagare_Unico',
		CONFEXME_82.tbrcED_Item( '35289' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35289' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35289' ).itemgren,
		NULL,
		1,
		'<PAGARE_UNICO>',
		'</PAGARE_UNICO>',
		CONFEXME_82.tbrcED_Item( '35289' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35290' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35290' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29982' ) ) then
		CONFEXME_82.tbrcED_Item( '35290' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29982' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35290' ).itemcodi,
		'Cambiouso',
		CONFEXME_82.tbrcED_Item( '35290' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35290' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35290' ).itemgren,
		NULL,
		1,
		'<CAMBIOUSO>',
		'</CAMBIOUSO>',
		CONFEXME_82.tbrcED_Item( '35290' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35291' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35291' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29983' ) ) then
		CONFEXME_82.tbrcED_Item( '35291' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29983' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35291' ).itemcodi,
		'Cons_Correg',
		CONFEXME_82.tbrcED_Item( '35291' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35291' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35291' ).itemgren,
		NULL,
		1,
		'<CONS_CORREG>',
		'</CONS_CORREG>',
		CONFEXME_82.tbrcED_Item( '35291' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35292' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35292' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29984' ) ) then
		CONFEXME_82.tbrcED_Item( '35292' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29984' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35292' ).itemcodi,
		'Factor_Correccion',
		CONFEXME_82.tbrcED_Item( '35292' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35292' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35292' ).itemgren,
		NULL,
		1,
		'<FACTOR_CORRECCION>',
		'</FACTOR_CORRECCION>',
		CONFEXME_82.tbrcED_Item( '35292' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35293' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35293' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29985' ) ) then
		CONFEXME_82.tbrcED_Item( '35293' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29985' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35293' ).itemcodi,
		'Consumo_Mes_1',
		CONFEXME_82.tbrcED_Item( '35293' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35293' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35293' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_1>',
		'</CONSUMO_MES_1>',
		CONFEXME_82.tbrcED_Item( '35293' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35294' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35294' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29986' ) ) then
		CONFEXME_82.tbrcED_Item( '35294' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29986' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35294' ).itemcodi,
		'Fecha_Cons_Mes_1',
		CONFEXME_82.tbrcED_Item( '35294' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35294' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35294' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_1>',
		'</FECHA_CONS_MES_1>',
		CONFEXME_82.tbrcED_Item( '35294' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35295' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35295' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29987' ) ) then
		CONFEXME_82.tbrcED_Item( '35295' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29987' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35295' ).itemcodi,
		'Consumo_Mes_2',
		CONFEXME_82.tbrcED_Item( '35295' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35295' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35295' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_2>',
		'</CONSUMO_MES_2>',
		CONFEXME_82.tbrcED_Item( '35295' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35296' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35296' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29988' ) ) then
		CONFEXME_82.tbrcED_Item( '35296' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29988' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35296' ).itemcodi,
		'Fecha_Cons_Mes_2',
		CONFEXME_82.tbrcED_Item( '35296' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35296' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35296' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_2>',
		'</FECHA_CONS_MES_2>',
		CONFEXME_82.tbrcED_Item( '35296' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35297' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35297' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29989' ) ) then
		CONFEXME_82.tbrcED_Item( '35297' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29989' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35297' ).itemcodi,
		'Consumo_Mes_3',
		CONFEXME_82.tbrcED_Item( '35297' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35297' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35297' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_3>',
		'</CONSUMO_MES_3>',
		CONFEXME_82.tbrcED_Item( '35297' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35298' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35298' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29990' ) ) then
		CONFEXME_82.tbrcED_Item( '35298' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29990' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35298' ).itemcodi,
		'Fecha_Cons_Mes_3',
		CONFEXME_82.tbrcED_Item( '35298' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35298' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35298' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_3>',
		'</FECHA_CONS_MES_3>',
		CONFEXME_82.tbrcED_Item( '35298' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35299' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35299' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29991' ) ) then
		CONFEXME_82.tbrcED_Item( '35299' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29991' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35299' ).itemcodi,
		'Consumo_Mes_4',
		CONFEXME_82.tbrcED_Item( '35299' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35299' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35299' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_4>',
		'</CONSUMO_MES_4>',
		CONFEXME_82.tbrcED_Item( '35299' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35300' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35300' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29992' ) ) then
		CONFEXME_82.tbrcED_Item( '35300' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29992' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35300' ).itemcodi,
		'Fecha_Cons_Mes_4',
		CONFEXME_82.tbrcED_Item( '35300' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35300' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35300' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_4>',
		'</FECHA_CONS_MES_4>',
		CONFEXME_82.tbrcED_Item( '35300' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35301' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35301' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29993' ) ) then
		CONFEXME_82.tbrcED_Item( '35301' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29993' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35301' ).itemcodi,
		'Consumo_Mes_5',
		CONFEXME_82.tbrcED_Item( '35301' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35301' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35301' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_5>',
		'</CONSUMO_MES_5>',
		CONFEXME_82.tbrcED_Item( '35301' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35302' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35302' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29994' ) ) then
		CONFEXME_82.tbrcED_Item( '35302' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29994' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35302' ).itemcodi,
		'Fecha_Cons_Mes_5',
		CONFEXME_82.tbrcED_Item( '35302' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35302' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35302' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_5>',
		'</FECHA_CONS_MES_5>',
		CONFEXME_82.tbrcED_Item( '35302' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35303' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35303' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29995' ) ) then
		CONFEXME_82.tbrcED_Item( '35303' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29995' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35303' ).itemcodi,
		'Consumo_Mes_6',
		CONFEXME_82.tbrcED_Item( '35303' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35303' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35303' ).itemgren,
		NULL,
		1,
		'<CONSUMO_MES_6>',
		'</CONSUMO_MES_6>',
		CONFEXME_82.tbrcED_Item( '35303' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35304' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35304' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29996' ) ) then
		CONFEXME_82.tbrcED_Item( '35304' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29996' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35304' ).itemcodi,
		'Fecha_Cons_Mes_6',
		CONFEXME_82.tbrcED_Item( '35304' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35304' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35304' ).itemgren,
		NULL,
		1,
		'<FECHA_CONS_MES_6>',
		'</FECHA_CONS_MES_6>',
		CONFEXME_82.tbrcED_Item( '35304' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35305' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35305' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29997' ) ) then
		CONFEXME_82.tbrcED_Item( '35305' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29997' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35305' ).itemcodi,
		'Consumo_Promedio',
		CONFEXME_82.tbrcED_Item( '35305' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35305' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35305' ).itemgren,
		NULL,
		1,
		'<CONSUMO_PROMEDIO>',
		'</CONSUMO_PROMEDIO>',
		CONFEXME_82.tbrcED_Item( '35305' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35306' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35306' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29998' ) ) then
		CONFEXME_82.tbrcED_Item( '35306' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29998' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35306' ).itemcodi,
		'Temperatura',
		CONFEXME_82.tbrcED_Item( '35306' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35306' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35306' ).itemgren,
		NULL,
		1,
		'<TEMPERATURA>',
		'</TEMPERATURA>',
		CONFEXME_82.tbrcED_Item( '35306' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35307' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35307' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '29999' ) ) then
		CONFEXME_82.tbrcED_Item( '35307' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '29999' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35307' ).itemcodi,
		'Presion',
		CONFEXME_82.tbrcED_Item( '35307' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35307' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35307' ).itemgren,
		NULL,
		1,
		'<PRESION>',
		'</PRESION>',
		CONFEXME_82.tbrcED_Item( '35307' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35308' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35308' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30000' ) ) then
		CONFEXME_82.tbrcED_Item( '35308' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30000' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35308' ).itemcodi,
		'Equival_Kwh',
		CONFEXME_82.tbrcED_Item( '35308' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35308' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35308' ).itemgren,
		NULL,
		1,
		'<EQUIVAL_KWH>',
		'</EQUIVAL_KWH>',
		CONFEXME_82.tbrcED_Item( '35308' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35309' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35309' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30001' ) ) then
		CONFEXME_82.tbrcED_Item( '35309' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30001' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35309' ).itemcodi,
		'Calculo_Cons',
		CONFEXME_82.tbrcED_Item( '35309' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35309' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35309' ).itemgren,
		NULL,
		1,
		'<CALCCONS>',
		'</CALCCONS>',
		CONFEXME_82.tbrcED_Item( '35309' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35336' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35336' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30034' ) ) then
		CONFEXME_82.tbrcED_Item( '35336' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30034' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35336' ).itemcodi,
		'Codigo_1',
		CONFEXME_82.tbrcED_Item( '35336' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35336' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35336' ).itemgren,
		NULL,
		1,
		'<CODIGO_1>',
		'</CODIGO_1>',
		CONFEXME_82.tbrcED_Item( '35336' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35337' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35337' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30035' ) ) then
		CONFEXME_82.tbrcED_Item( '35337' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30035' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35337' ).itemcodi,
		'Codigo_2',
		CONFEXME_82.tbrcED_Item( '35337' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35337' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35337' ).itemgren,
		NULL,
		1,
		'<CODIGO_2>',
		'</CODIGO_2>',
		CONFEXME_82.tbrcED_Item( '35337' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35338' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35338' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30036' ) ) then
		CONFEXME_82.tbrcED_Item( '35338' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30036' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35338' ).itemcodi,
		'Codigo_3',
		CONFEXME_82.tbrcED_Item( '35338' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35338' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35338' ).itemgren,
		NULL,
		1,
		'<CODIGO_3>',
		'</CODIGO_3>',
		CONFEXME_82.tbrcED_Item( '35338' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35339' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35339' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30037' ) ) then
		CONFEXME_82.tbrcED_Item( '35339' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30037' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35339' ).itemcodi,
		'Codigo_4',
		CONFEXME_82.tbrcED_Item( '35339' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35339' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35339' ).itemgren,
		NULL,
		1,
		'<CODIGO_4>',
		'</CODIGO_4>',
		CONFEXME_82.tbrcED_Item( '35339' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35340' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35340' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30038' ) ) then
		CONFEXME_82.tbrcED_Item( '35340' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30038' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35340' ).itemcodi,
		'Codigo_Barras',
		CONFEXME_82.tbrcED_Item( '35340' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35340' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35340' ).itemgren,
		NULL,
		1,
		'<COD_BAR>',
		'</COD_BAR>',
		CONFEXME_82.tbrcED_Item( '35340' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35341' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35341' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30039' ) ) then
		CONFEXME_82.tbrcED_Item( '35341' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30039' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35341' ).itemcodi,
		'Tasa_Ultima',
		CONFEXME_82.tbrcED_Item( '35341' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35341' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35341' ).itemgren,
		NULL,
		1,
		'<TASA_ULTIMA>',
		'</TASA_ULTIMA>',
		CONFEXME_82.tbrcED_Item( '35341' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35342' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35342' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30040' ) ) then
		CONFEXME_82.tbrcED_Item( '35342' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30040' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35342' ).itemcodi,
		'Tasa_Promedio',
		CONFEXME_82.tbrcED_Item( '35342' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35342' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35342' ).itemgren,
		NULL,
		1,
		'<TASA_PROMEDIO>',
		'</TASA_PROMEDIO>',
		CONFEXME_82.tbrcED_Item( '35342' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35343' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35343' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30041' ) ) then
		CONFEXME_82.tbrcED_Item( '35343' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30041' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35343' ).itemcodi,
		'Cuadrilla_Reparto',
		CONFEXME_82.tbrcED_Item( '35343' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35343' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35343' ).itemgren,
		NULL,
		1,
		'<CUADRILLA_REPARTO>',
		'</CUADRILLA_REPARTO>',
		CONFEXME_82.tbrcED_Item( '35343' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35344' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35344' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30042' ) ) then
		CONFEXME_82.tbrcED_Item( '35344' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30042' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35344' ).itemcodi,
		'Observ_No_Lect_Consec',
		CONFEXME_82.tbrcED_Item( '35344' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35344' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35344' ).itemgren,
		NULL,
		1,
		'<OBSERV_NO_LECT_CONSEC>',
		'</OBSERV_NO_LECT_CONSEC>',
		CONFEXME_82.tbrcED_Item( '35344' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35345' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35345' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30043' ) ) then
		CONFEXME_82.tbrcED_Item( '35345' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30043' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35345' ).itemcodi,
		'Visible',
		CONFEXME_82.tbrcED_Item( '35345' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35345' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35345' ).itemgren,
		NULL,
		2,
		'<VISIBLE>',
		'</VISIBLE>',
		CONFEXME_82.tbrcED_Item( '35345' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35346' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35346' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30044' ) ) then
		CONFEXME_82.tbrcED_Item( '35346' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30044' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35346' ).itemcodi,
		'Impreso',
		CONFEXME_82.tbrcED_Item( '35346' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35346' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35346' ).itemgren,
		NULL,
		1,
		'<IMPRESO>',
		'</IMPRESO>',
		CONFEXME_82.tbrcED_Item( '35346' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35347' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35347' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30045' ) ) then
		CONFEXME_82.tbrcED_Item( '35347' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30045' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35347' ).itemcodi,
		'Proteccion_Estado',
		CONFEXME_82.tbrcED_Item( '35347' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35347' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35347' ).itemgren,
		NULL,
		1,
		'<PROTECCION_ESTADO>',
		'</PROTECCION_ESTADO>',
		CONFEXME_82.tbrcED_Item( '35347' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35348' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35348' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30046' ) ) then
		CONFEXME_82.tbrcED_Item( '35348' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30046' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35348' ).itemcodi,
		'Acumu',
		CONFEXME_82.tbrcED_Item( '35348' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35348' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35348' ).itemgren,
		NULL,
		1,
		'<ACUMU_TATT>',
		'</ACUMU_TATT>',
		CONFEXME_82.tbrcED_Item( '35348' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35349' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35349' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30047' ) ) then
		CONFEXME_82.tbrcED_Item( '35349' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30047' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35349' ).itemcodi,
		'Finaespe',
		CONFEXME_82.tbrcED_Item( '35349' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35349' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35349' ).itemgren,
		NULL,
		1,
		'<FINAESPE>',
		'</FINAESPE>',
		CONFEXME_82.tbrcED_Item( '35349' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35350' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35350' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30048' ) ) then
		CONFEXME_82.tbrcED_Item( '35350' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30048' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35350' ).itemcodi,
		'Med_Mal_Ubicado',
		CONFEXME_82.tbrcED_Item( '35350' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35350' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35350' ).itemgren,
		NULL,
		1,
		'<MED_MAL_UBICADO>',
		'</MED_MAL_UBICADO>',
		CONFEXME_82.tbrcED_Item( '35350' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35351' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35351' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30049' ) ) then
		CONFEXME_82.tbrcED_Item( '35351' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30049' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35351' ).itemcodi,
		'Imprimefact',
		CONFEXME_82.tbrcED_Item( '35351' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35351' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35351' ).itemgren,
		NULL,
		1,
		'<IMPRIMEFACT>',
		'</IMPRIMEFACT>',
		CONFEXME_82.tbrcED_Item( '35351' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35352' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35352' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30050' ) ) then
		CONFEXME_82.tbrcED_Item( '35352' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30050' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35352' ).itemcodi,
		'Valor_Ult_Pago',
		CONFEXME_82.tbrcED_Item( '35352' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35352' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35352' ).itemgren,
		NULL,
		1,
		'<VALOR_ULT_PAGO>',
		'</VALOR_ULT_PAGO>',
		CONFEXME_82.tbrcED_Item( '35352' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35353' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35353' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30051' ) ) then
		CONFEXME_82.tbrcED_Item( '35353' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30051' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35353' ).itemcodi,
		'Fecha_Ult_Pago',
		CONFEXME_82.tbrcED_Item( '35353' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35353' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35353' ).itemgren,
		NULL,
		1,
		'<FECHA_ULT_PAGO>',
		'</FECHA_ULT_PAGO>',
		CONFEXME_82.tbrcED_Item( '35353' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '35354' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '35354' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30052' ) ) then
		CONFEXME_82.tbrcED_Item( '35354' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30052' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '35354' ).itemcodi,
		'Saldo_Ante',
		CONFEXME_82.tbrcED_Item( '35354' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '35354' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '35354' ).itemgren,
		NULL,
		1,
		'<SALDO_ANTE>',
		'</SALDO_ANTE>',
		CONFEXME_82.tbrcED_Item( '35354' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36281' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36281' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30849' ) ) then
		CONFEXME_82.tbrcED_Item( '36281' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30849' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36281' ).itemcodi,
		'Etiqueta',
		CONFEXME_82.tbrcED_Item( '36281' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36281' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36281' ).itemgren,
		NULL,
		2,
		'<ETIQUETA>',
		'</ETIQUETA>',
		CONFEXME_82.tbrcED_Item( '36281' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36282' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36282' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30850' ) ) then
		CONFEXME_82.tbrcED_Item( '36282' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30850' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36282' ).itemcodi,
		'Concepto_Id',
		CONFEXME_82.tbrcED_Item( '36282' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36282' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36282' ).itemgren,
		NULL,
		1,
		'<CONCEPTO_ID>',
		'</CONCEPTO_ID>',
		CONFEXME_82.tbrcED_Item( '36282' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36283' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36283' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30851' ) ) then
		CONFEXME_82.tbrcED_Item( '36283' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30851' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36283' ).itemcodi,
		'Desc_Concep',
		CONFEXME_82.tbrcED_Item( '36283' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36283' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36283' ).itemgren,
		NULL,
		1,
		'<DESC_CONCEP>',
		'</DESC_CONCEP>',
		CONFEXME_82.tbrcED_Item( '36283' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36284' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36284' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30852' ) ) then
		CONFEXME_82.tbrcED_Item( '36284' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30852' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36284' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_82.tbrcED_Item( '36284' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36284' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36284' ).itemgren,
		NULL,
		1,
		'<SALDO_ANT>',
		'</SALDO_ANT>',
		CONFEXME_82.tbrcED_Item( '36284' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36285' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36285' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30853' ) ) then
		CONFEXME_82.tbrcED_Item( '36285' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30853' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36285' ).itemcodi,
		'Capital',
		CONFEXME_82.tbrcED_Item( '36285' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36285' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36285' ).itemgren,
		NULL,
		1,
		'<CAPITAL>',
		'</CAPITAL>',
		CONFEXME_82.tbrcED_Item( '36285' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36286' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36286' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30854' ) ) then
		CONFEXME_82.tbrcED_Item( '36286' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30854' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36286' ).itemcodi,
		'Interes',
		CONFEXME_82.tbrcED_Item( '36286' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36286' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36286' ).itemgren,
		NULL,
		1,
		'<INTERES>',
		'</INTERES>',
		CONFEXME_82.tbrcED_Item( '36286' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36287' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36287' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30855' ) ) then
		CONFEXME_82.tbrcED_Item( '36287' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30855' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36287' ).itemcodi,
		'Total',
		CONFEXME_82.tbrcED_Item( '36287' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36287' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36287' ).itemgren,
		NULL,
		1,
		'<TOTAL>',
		'</TOTAL>',
		CONFEXME_82.tbrcED_Item( '36287' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36288' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36288' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30856' ) ) then
		CONFEXME_82.tbrcED_Item( '36288' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30856' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36288' ).itemcodi,
		'Saldo_Dif',
		CONFEXME_82.tbrcED_Item( '36288' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36288' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36288' ).itemgren,
		NULL,
		1,
		'<SALDO_DIF>',
		'</SALDO_DIF>',
		CONFEXME_82.tbrcED_Item( '36288' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36289' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36289' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30857' ) ) then
		CONFEXME_82.tbrcED_Item( '36289' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30857' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36289' ).itemcodi,
		'Unidad_Items',
		CONFEXME_82.tbrcED_Item( '36289' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36289' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36289' ).itemgren,
		NULL,
		1,
		'<UNIDAD_ITEMS>',
		'</UNIDAD_ITEMS>',
		CONFEXME_82.tbrcED_Item( '36289' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36290' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36290' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30858' ) ) then
		CONFEXME_82.tbrcED_Item( '36290' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30858' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36290' ).itemcodi,
		'Cantidad',
		CONFEXME_82.tbrcED_Item( '36290' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36290' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36290' ).itemgren,
		NULL,
		1,
		'<CANTIDAD>',
		'</CANTIDAD>',
		CONFEXME_82.tbrcED_Item( '36290' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36291' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36291' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30859' ) ) then
		CONFEXME_82.tbrcED_Item( '36291' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30859' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36291' ).itemcodi,
		'Valor_Unitario',
		CONFEXME_82.tbrcED_Item( '36291' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36291' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36291' ).itemgren,
		NULL,
		1,
		'<VALOR_UNITARIO>',
		'</VALOR_UNITARIO>',
		CONFEXME_82.tbrcED_Item( '36291' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36292' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36292' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30860' ) ) then
		CONFEXME_82.tbrcED_Item( '36292' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30860' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36292' ).itemcodi,
		'Valor_Iva',
		CONFEXME_82.tbrcED_Item( '36292' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36292' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36292' ).itemgren,
		NULL,
		1,
		'<VALOR_IVA>',
		'</VALOR_IVA>',
		CONFEXME_82.tbrcED_Item( '36292' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36293' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36293' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30861' ) ) then
		CONFEXME_82.tbrcED_Item( '36293' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30861' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36293' ).itemcodi,
		'Cuotas',
		CONFEXME_82.tbrcED_Item( '36293' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36293' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36293' ).itemgren,
		NULL,
		1,
		'<CUOTAS>',
		'</CUOTAS>',
		CONFEXME_82.tbrcED_Item( '36293' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36295' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36295' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30862' ) ) then
		CONFEXME_82.tbrcED_Item( '36295' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30862' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36295' ).itemcodi,
		'Total',
		CONFEXME_82.tbrcED_Item( '36295' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36295' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36295' ).itemgren,
		NULL,
		1,
		'<TOTAL>',
		'</TOTAL>',
		CONFEXME_82.tbrcED_Item( '36295' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36296' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36296' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30863' ) ) then
		CONFEXME_82.tbrcED_Item( '36296' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30863' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36296' ).itemcodi,
		'Iva',
		CONFEXME_82.tbrcED_Item( '36296' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36296' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36296' ).itemgren,
		NULL,
		1,
		'<IVA>',
		'</IVA>',
		CONFEXME_82.tbrcED_Item( '36296' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36297' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36297' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30864' ) ) then
		CONFEXME_82.tbrcED_Item( '36297' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30864' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36297' ).itemcodi,
		'Subtotal',
		CONFEXME_82.tbrcED_Item( '36297' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36297' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36297' ).itemgren,
		NULL,
		1,
		'<SUBTOTAL>',
		'</SUBTOTAL>',
		CONFEXME_82.tbrcED_Item( '36297' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36298' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36298' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30865' ) ) then
		CONFEXME_82.tbrcED_Item( '36298' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30865' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36298' ).itemcodi,
		'Cargosmes',
		CONFEXME_82.tbrcED_Item( '36298' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36298' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36298' ).itemgren,
		NULL,
		1,
		'<CARGOSMES>',
		'</CARGOSMES>',
		CONFEXME_82.tbrcED_Item( '36298' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36299' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36299' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30866' ) ) then
		CONFEXME_82.tbrcED_Item( '36299' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30866' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36299' ).itemcodi,
		'Cantidad_Conc',
		CONFEXME_82.tbrcED_Item( '36299' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36299' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36299' ).itemgren,
		NULL,
		1,
		'<CANTIDAD_CONC>',
		'</CANTIDAD_CONC>',
		CONFEXME_82.tbrcED_Item( '36299' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36300' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36300' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30867' ) ) then
		CONFEXME_82.tbrcED_Item( '36300' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30867' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36300' ).itemcodi,
		'Factura',
		CONFEXME_82.tbrcED_Item( '36300' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36300' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36300' ).itemgren,
		NULL,
		1,
		'<FACTURA>',
		'</FACTURA>',
		CONFEXME_82.tbrcED_Item( '36300' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36301' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36301' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30868' ) ) then
		CONFEXME_82.tbrcED_Item( '36301' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30868' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36301' ).itemcodi,
		'Fech_Fact',
		CONFEXME_82.tbrcED_Item( '36301' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36301' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36301' ).itemgren,
		NULL,
		1,
		'<FECH_FACT>',
		'</FECH_FACT>',
		CONFEXME_82.tbrcED_Item( '36301' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36302' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36302' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30869' ) ) then
		CONFEXME_82.tbrcED_Item( '36302' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30869' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36302' ).itemcodi,
		'Mes_Fact',
		CONFEXME_82.tbrcED_Item( '36302' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36302' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36302' ).itemgren,
		NULL,
		1,
		'<MES_FACT>',
		'</MES_FACT>',
		CONFEXME_82.tbrcED_Item( '36302' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36303' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36303' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30870' ) ) then
		CONFEXME_82.tbrcED_Item( '36303' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30870' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36303' ).itemcodi,
		'Periodo_Fact',
		CONFEXME_82.tbrcED_Item( '36303' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36303' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36303' ).itemgren,
		NULL,
		1,
		'<PERIODO_FACT>',
		'</PERIODO_FACT>',
		CONFEXME_82.tbrcED_Item( '36303' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36304' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36304' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30871' ) ) then
		CONFEXME_82.tbrcED_Item( '36304' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30871' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36304' ).itemcodi,
		'Pago_Hasta',
		CONFEXME_82.tbrcED_Item( '36304' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36304' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36304' ).itemgren,
		NULL,
		1,
		'<PAGO_HASTA>',
		'</PAGO_HASTA>',
		CONFEXME_82.tbrcED_Item( '36304' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36305' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36305' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30872' ) ) then
		CONFEXME_82.tbrcED_Item( '36305' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30872' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36305' ).itemcodi,
		'Dias_Consumo',
		CONFEXME_82.tbrcED_Item( '36305' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36305' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36305' ).itemgren,
		NULL,
		1,
		'<DIAS_CONSUMO>',
		'</DIAS_CONSUMO>',
		CONFEXME_82.tbrcED_Item( '36305' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36306' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36306' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30873' ) ) then
		CONFEXME_82.tbrcED_Item( '36306' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30873' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36306' ).itemcodi,
		'Contrato',
		CONFEXME_82.tbrcED_Item( '36306' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36306' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36306' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_82.tbrcED_Item( '36306' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36307' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36307' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30874' ) ) then
		CONFEXME_82.tbrcED_Item( '36307' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30874' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36307' ).itemcodi,
		'Cupon',
		CONFEXME_82.tbrcED_Item( '36307' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36307' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36307' ).itemgren,
		NULL,
		1,
		'<CUPON>',
		'</CUPON>',
		CONFEXME_82.tbrcED_Item( '36307' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36308' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36308' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30875' ) ) then
		CONFEXME_82.tbrcED_Item( '36308' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30875' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36308' ).itemcodi,
		'Nombre',
		CONFEXME_82.tbrcED_Item( '36308' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36308' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36308' ).itemgren,
		NULL,
		1,
		'<NOMBRE>',
		'</NOMBRE>',
		CONFEXME_82.tbrcED_Item( '36308' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36309' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36309' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30876' ) ) then
		CONFEXME_82.tbrcED_Item( '36309' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30876' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36309' ).itemcodi,
		'Direccion_Cobro',
		CONFEXME_82.tbrcED_Item( '36309' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36309' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36309' ).itemgren,
		NULL,
		1,
		'<DIRECCION_COBRO>',
		'</DIRECCION_COBRO>',
		CONFEXME_82.tbrcED_Item( '36309' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36310' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36310' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30877' ) ) then
		CONFEXME_82.tbrcED_Item( '36310' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30877' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36310' ).itemcodi,
		'Localidad',
		CONFEXME_82.tbrcED_Item( '36310' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36310' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36310' ).itemgren,
		NULL,
		1,
		'<LOCALIDAD>',
		'</LOCALIDAD>',
		CONFEXME_82.tbrcED_Item( '36310' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36311' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36311' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30878' ) ) then
		CONFEXME_82.tbrcED_Item( '36311' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30878' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36311' ).itemcodi,
		'Categoria',
		CONFEXME_82.tbrcED_Item( '36311' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36311' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36311' ).itemgren,
		NULL,
		1,
		'<CATEGORIA>',
		'</CATEGORIA>',
		CONFEXME_82.tbrcED_Item( '36311' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36312' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36312' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30879' ) ) then
		CONFEXME_82.tbrcED_Item( '36312' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30879' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36312' ).itemcodi,
		'Estrato',
		CONFEXME_82.tbrcED_Item( '36312' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36312' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36312' ).itemgren,
		NULL,
		1,
		'<ESTRATO>',
		'</ESTRATO>',
		CONFEXME_82.tbrcED_Item( '36312' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36313' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36313' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30880' ) ) then
		CONFEXME_82.tbrcED_Item( '36313' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30880' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36313' ).itemcodi,
		'Ciclo',
		CONFEXME_82.tbrcED_Item( '36313' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36313' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36313' ).itemgren,
		NULL,
		1,
		'<CICLO>',
		'</CICLO>',
		CONFEXME_82.tbrcED_Item( '36313' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36314' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36314' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30881' ) ) then
		CONFEXME_82.tbrcED_Item( '36314' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30881' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36314' ).itemcodi,
		'Ruta',
		CONFEXME_82.tbrcED_Item( '36314' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36314' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36314' ).itemgren,
		NULL,
		1,
		'<RUTA>',
		'</RUTA>',
		CONFEXME_82.tbrcED_Item( '36314' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36315' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36315' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30882' ) ) then
		CONFEXME_82.tbrcED_Item( '36315' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30882' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36315' ).itemcodi,
		'Meses_Deuda',
		CONFEXME_82.tbrcED_Item( '36315' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36315' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36315' ).itemgren,
		NULL,
		2,
		'<MESES_DEUDA>',
		'</MESES_DEUDA>',
		CONFEXME_82.tbrcED_Item( '36315' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36316' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36316' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30883' ) ) then
		CONFEXME_82.tbrcED_Item( '36316' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30883' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36316' ).itemcodi,
		'Num_Control',
		CONFEXME_82.tbrcED_Item( '36316' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36316' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36316' ).itemgren,
		NULL,
		1,
		'<NUM_CONTROL>',
		'</NUM_CONTROL>',
		CONFEXME_82.tbrcED_Item( '36316' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36317' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36317' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30884' ) ) then
		CONFEXME_82.tbrcED_Item( '36317' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30884' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36317' ).itemcodi,
		'Periodo_Consumo',
		CONFEXME_82.tbrcED_Item( '36317' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36317' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36317' ).itemgren,
		NULL,
		1,
		'<PERIODO_CONSUMO>',
		'</PERIODO_CONSUMO>',
		CONFEXME_82.tbrcED_Item( '36317' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36318' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36318' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30885' ) ) then
		CONFEXME_82.tbrcED_Item( '36318' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30885' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36318' ).itemcodi,
		'Saldo_Favor',
		CONFEXME_82.tbrcED_Item( '36318' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36318' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36318' ).itemgren,
		NULL,
		2,
		'<SALDO_FAVOR>',
		'</SALDO_FAVOR>',
		CONFEXME_82.tbrcED_Item( '36318' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36319' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36319' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30886' ) ) then
		CONFEXME_82.tbrcED_Item( '36319' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30886' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36319' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_82.tbrcED_Item( '36319' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36319' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36319' ).itemgren,
		NULL,
		1,
		'<SALDO_ANT>',
		'</SALDO_ANT>',
		CONFEXME_82.tbrcED_Item( '36319' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36320' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36320' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30887' ) ) then
		CONFEXME_82.tbrcED_Item( '36320' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30887' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36320' ).itemcodi,
		'Fecha_Suspension',
		CONFEXME_82.tbrcED_Item( '36320' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36320' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36320' ).itemgren,
		NULL,
		1,
		'<FECHA_SUSPENSION>',
		'</FECHA_SUSPENSION>',
		CONFEXME_82.tbrcED_Item( '36320' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36321' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36321' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30888' ) ) then
		CONFEXME_82.tbrcED_Item( '36321' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30888' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36321' ).itemcodi,
		'Valor_Recl',
		CONFEXME_82.tbrcED_Item( '36321' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36321' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36321' ).itemgren,
		NULL,
		2,
		'<VALOR_RECL>',
		'</VALOR_RECL>',
		CONFEXME_82.tbrcED_Item( '36321' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36322' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36322' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30889' ) ) then
		CONFEXME_82.tbrcED_Item( '36322' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30889' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36322' ).itemcodi,
		'Total_Factura',
		CONFEXME_82.tbrcED_Item( '36322' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36322' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36322' ).itemgren,
		NULL,
		1,
		'<TOTAL_FACTURA>',
		'</TOTAL_FACTURA>',
		CONFEXME_82.tbrcED_Item( '36322' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36323' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36323' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30890' ) ) then
		CONFEXME_82.tbrcED_Item( '36323' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30890' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36323' ).itemcodi,
		'Pago_Sin_Recargo',
		CONFEXME_82.tbrcED_Item( '36323' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36323' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36323' ).itemgren,
		NULL,
		1,
		'<PAGO_SIN_RECARGO>',
		'</PAGO_SIN_RECARGO>',
		CONFEXME_82.tbrcED_Item( '36323' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36324' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36324' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30891' ) ) then
		CONFEXME_82.tbrcED_Item( '36324' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30891' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36324' ).itemcodi,
		'Condicion_Pago',
		CONFEXME_82.tbrcED_Item( '36324' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36324' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36324' ).itemgren,
		NULL,
		1,
		'<CONDICION_PAGO>',
		'</CONDICION_PAGO>',
		CONFEXME_82.tbrcED_Item( '36324' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36325' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36325' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30892' ) ) then
		CONFEXME_82.tbrcED_Item( '36325' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30892' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36325' ).itemcodi,
		'Identifica',
		CONFEXME_82.tbrcED_Item( '36325' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36325' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36325' ).itemgren,
		NULL,
		1,
		'<IDENTIFICA>',
		'</IDENTIFICA>',
		CONFEXME_82.tbrcED_Item( '36325' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_82.tbrcED_Item( '36326' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_82.tbrcED_Item( '36326' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_82.tbrcED_AtriFuda.exists( '30893' ) ) then
		CONFEXME_82.tbrcED_Item( '36326' ).itematfd := CONFEXME_82.tbrcED_AtriFuda( '30893' ).atfdcodi;
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
		CONFEXME_82.tbrcED_Item( '36326' ).itemcodi,
		'Tipo de producto',
		CONFEXME_82.tbrcED_Item( '36326' ).itemceid,
		NULL,
		CONFEXME_82.tbrcED_Item( '36326' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_82.tbrcED_Item( '36326' ).itemgren,
		NULL,
		1,
		'<SERVICIO>',
		'</SERVICIO>',
		CONFEXME_82.tbrcED_Item( '36326' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35196' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35196' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6729' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35221' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35196' ).itblitem := CONFEXME_82.tbrcED_Item( '35221' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35196' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35196' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35196' ).itblblfr,
		0
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35197' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35197' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35222' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35197' ).itblitem := CONFEXME_82.tbrcED_Item( '35222' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35197' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35197' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35197' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35198' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35198' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35223' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35198' ).itblitem := CONFEXME_82.tbrcED_Item( '35223' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35198' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35198' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35198' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35199' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35199' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35224' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35199' ).itblitem := CONFEXME_82.tbrcED_Item( '35224' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35199' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35199' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35199' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35200' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35200' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6730' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35225' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35200' ).itblitem := CONFEXME_82.tbrcED_Item( '35225' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35200' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35200' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35200' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35201' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35201' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35226' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35201' ).itblitem := CONFEXME_82.tbrcED_Item( '35226' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35201' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35201' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35201' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35202' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35202' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35227' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35202' ).itblitem := CONFEXME_82.tbrcED_Item( '35227' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35202' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35202' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35202' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35203' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35203' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35228' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35203' ).itblitem := CONFEXME_82.tbrcED_Item( '35228' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35203' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35203' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35203' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35204' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35204' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6732' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35229' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35204' ).itblitem := CONFEXME_82.tbrcED_Item( '35229' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35204' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35204' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35204' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35205' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35205' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35230' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35205' ).itblitem := CONFEXME_82.tbrcED_Item( '35230' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35205' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35205' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35205' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35206' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35206' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35231' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35206' ).itblitem := CONFEXME_82.tbrcED_Item( '35231' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35206' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35206' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35206' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35207' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35207' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35232' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35207' ).itblitem := CONFEXME_82.tbrcED_Item( '35232' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35207' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35207' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35207' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35208' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35208' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35233' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35208' ).itblitem := CONFEXME_82.tbrcED_Item( '35233' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35208' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35208' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35208' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35209' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35209' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6734' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35234' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35209' ).itblitem := CONFEXME_82.tbrcED_Item( '35234' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35209' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35209' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35209' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35210' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35210' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35235' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35210' ).itblitem := CONFEXME_82.tbrcED_Item( '35235' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35210' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35210' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35210' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35211' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35211' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35236' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35211' ).itblitem := CONFEXME_82.tbrcED_Item( '35236' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35211' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35211' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35211' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35212' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35212' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6735' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35237' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35212' ).itblitem := CONFEXME_82.tbrcED_Item( '35237' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35212' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35212' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35212' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35213' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35213' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35238' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35213' ).itblitem := CONFEXME_82.tbrcED_Item( '35238' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35213' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35213' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35213' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35214' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35214' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6737' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35239' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35214' ).itblitem := CONFEXME_82.tbrcED_Item( '35239' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35214' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35214' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35214' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35215' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35215' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35240' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35215' ).itblitem := CONFEXME_82.tbrcED_Item( '35240' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35215' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35215' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35215' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35216' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35216' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35241' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35216' ).itblitem := CONFEXME_82.tbrcED_Item( '35241' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35216' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35216' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35216' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35217' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35217' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35242' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35217' ).itblitem := CONFEXME_82.tbrcED_Item( '35242' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35217' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35217' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35217' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35218' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35218' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35243' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35218' ).itblitem := CONFEXME_82.tbrcED_Item( '35243' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35218' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35218' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35218' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35219' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35219' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35244' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35219' ).itblitem := CONFEXME_82.tbrcED_Item( '35244' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35219' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35219' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35219' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35220' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35220' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35245' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35220' ).itblitem := CONFEXME_82.tbrcED_Item( '35245' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35220' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35220' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35220' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35221' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35221' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35246' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35221' ).itblitem := CONFEXME_82.tbrcED_Item( '35246' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35221' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35221' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35221' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35222' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35222' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35247' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35222' ).itblitem := CONFEXME_82.tbrcED_Item( '35247' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35222' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35222' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35222' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35223' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35223' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35248' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35223' ).itblitem := CONFEXME_82.tbrcED_Item( '35248' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35223' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35223' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35223' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35224' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35224' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35249' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35224' ).itblitem := CONFEXME_82.tbrcED_Item( '35249' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35224' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35224' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35224' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35225' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35225' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35250' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35225' ).itblitem := CONFEXME_82.tbrcED_Item( '35250' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35225' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35225' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35225' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35226' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35226' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35251' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35226' ).itblitem := CONFEXME_82.tbrcED_Item( '35251' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35226' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35226' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35226' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35227' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35227' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35252' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35227' ).itblitem := CONFEXME_82.tbrcED_Item( '35252' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35227' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35227' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35227' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35228' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35228' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35253' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35228' ).itblitem := CONFEXME_82.tbrcED_Item( '35253' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35228' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35228' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35228' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35229' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35229' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35254' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35229' ).itblitem := CONFEXME_82.tbrcED_Item( '35254' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35229' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35229' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35229' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35230' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35230' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35255' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35230' ).itblitem := CONFEXME_82.tbrcED_Item( '35255' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35230' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35230' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35230' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35231' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35231' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35256' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35231' ).itblitem := CONFEXME_82.tbrcED_Item( '35256' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35231' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35231' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35231' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35232' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35232' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35257' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35232' ).itblitem := CONFEXME_82.tbrcED_Item( '35257' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35232' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35232' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35232' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35233' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35233' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35258' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35233' ).itblitem := CONFEXME_82.tbrcED_Item( '35258' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35233' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35233' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35233' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35234' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35234' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35259' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35234' ).itblitem := CONFEXME_82.tbrcED_Item( '35259' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35234' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35234' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35234' ).itblblfr,
		20
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35235' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35235' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35260' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35235' ).itblitem := CONFEXME_82.tbrcED_Item( '35260' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35235' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35235' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35235' ).itblblfr,
		21
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35236' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35236' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35261' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35236' ).itblitem := CONFEXME_82.tbrcED_Item( '35261' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35236' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35236' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35236' ).itblblfr,
		22
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35237' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35237' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35262' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35237' ).itblitem := CONFEXME_82.tbrcED_Item( '35262' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35237' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35237' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35237' ).itblblfr,
		23
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35238' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35238' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35263' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35238' ).itblitem := CONFEXME_82.tbrcED_Item( '35263' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35238' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35238' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35238' ).itblblfr,
		24
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35239' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35239' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35264' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35239' ).itblitem := CONFEXME_82.tbrcED_Item( '35264' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35239' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35239' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35239' ).itblblfr,
		25
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35240' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35240' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35265' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35240' ).itblitem := CONFEXME_82.tbrcED_Item( '35265' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35240' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35240' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35240' ).itblblfr,
		26
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35241' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35241' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35266' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35241' ).itblitem := CONFEXME_82.tbrcED_Item( '35266' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35241' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35241' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35241' ).itblblfr,
		27
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35242' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35242' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35267' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35242' ).itblitem := CONFEXME_82.tbrcED_Item( '35267' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35242' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35242' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35242' ).itblblfr,
		28
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35243' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35243' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35268' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35243' ).itblitem := CONFEXME_82.tbrcED_Item( '35268' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35243' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35243' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35243' ).itblblfr,
		29
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35244' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35244' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35269' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35244' ).itblitem := CONFEXME_82.tbrcED_Item( '35269' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35244' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35244' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35244' ).itblblfr,
		30
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35245' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35245' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35270' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35245' ).itblitem := CONFEXME_82.tbrcED_Item( '35270' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35245' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35245' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35245' ).itblblfr,
		31
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35246' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35246' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35271' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35246' ).itblitem := CONFEXME_82.tbrcED_Item( '35271' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35246' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35246' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35246' ).itblblfr,
		32
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35247' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35247' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35272' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35247' ).itblitem := CONFEXME_82.tbrcED_Item( '35272' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35247' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35247' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35247' ).itblblfr,
		33
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35248' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35248' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35273' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35248' ).itblitem := CONFEXME_82.tbrcED_Item( '35273' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35248' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35248' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35248' ).itblblfr,
		34
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35249' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35249' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6739' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35274' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35249' ).itblitem := CONFEXME_82.tbrcED_Item( '35274' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35249' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35249' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35249' ).itblblfr,
		35
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35250' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35250' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35275' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35250' ).itblitem := CONFEXME_82.tbrcED_Item( '35275' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35250' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35250' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35250' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35251' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35251' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6740' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35276' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35251' ).itblitem := CONFEXME_82.tbrcED_Item( '35276' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35251' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35251' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35251' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35252' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35252' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35277' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35252' ).itblitem := CONFEXME_82.tbrcED_Item( '35277' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35252' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35252' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35252' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35253' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35253' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6741' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35278' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35253' ).itblitem := CONFEXME_82.tbrcED_Item( '35278' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35253' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35253' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35253' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35254' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35254' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35279' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35254' ).itblitem := CONFEXME_82.tbrcED_Item( '35279' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35254' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35254' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35254' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35255' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35255' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35280' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35255' ).itblitem := CONFEXME_82.tbrcED_Item( '35280' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35255' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35255' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35255' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35256' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35256' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35281' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35256' ).itblitem := CONFEXME_82.tbrcED_Item( '35281' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35256' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35256' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35256' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35257' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35257' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35282' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35257' ).itblitem := CONFEXME_82.tbrcED_Item( '35282' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35257' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35257' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35257' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35258' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35258' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35283' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35258' ).itblitem := CONFEXME_82.tbrcED_Item( '35283' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35258' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35258' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35258' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35259' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35259' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35284' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35259' ).itblitem := CONFEXME_82.tbrcED_Item( '35284' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35259' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35259' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35259' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35260' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35260' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35285' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35260' ).itblitem := CONFEXME_82.tbrcED_Item( '35285' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35260' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35260' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35260' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35261' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35261' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6733' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35286' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35261' ).itblitem := CONFEXME_82.tbrcED_Item( '35286' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35261' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35261' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35261' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35262' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35262' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35287' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35262' ).itblitem := CONFEXME_82.tbrcED_Item( '35287' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35262' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35262' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35262' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35263' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35263' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35288' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35263' ).itblitem := CONFEXME_82.tbrcED_Item( '35288' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35263' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35263' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35263' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35264' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35264' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35289' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35264' ).itblitem := CONFEXME_82.tbrcED_Item( '35289' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35264' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35264' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35264' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35265' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35265' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6742' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35290' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35265' ).itblitem := CONFEXME_82.tbrcED_Item( '35290' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35265' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35265' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35265' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35266' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35266' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35291' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35266' ).itblitem := CONFEXME_82.tbrcED_Item( '35291' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35266' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35266' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35266' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35267' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35267' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35292' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35267' ).itblitem := CONFEXME_82.tbrcED_Item( '35292' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35267' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35267' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35267' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35268' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35268' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35293' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35268' ).itblitem := CONFEXME_82.tbrcED_Item( '35293' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35268' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35268' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35268' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35269' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35269' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35294' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35269' ).itblitem := CONFEXME_82.tbrcED_Item( '35294' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35269' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35269' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35269' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35270' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35270' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35295' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35270' ).itblitem := CONFEXME_82.tbrcED_Item( '35295' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35270' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35270' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35270' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35271' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35271' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35296' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35271' ).itblitem := CONFEXME_82.tbrcED_Item( '35296' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35271' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35271' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35271' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35272' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35272' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35297' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35272' ).itblitem := CONFEXME_82.tbrcED_Item( '35297' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35272' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35272' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35272' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35273' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35273' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35298' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35273' ).itblitem := CONFEXME_82.tbrcED_Item( '35298' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35273' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35273' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35273' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35274' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35274' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35299' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35274' ).itblitem := CONFEXME_82.tbrcED_Item( '35299' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35274' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35274' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35274' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35275' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35275' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35300' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35275' ).itblitem := CONFEXME_82.tbrcED_Item( '35300' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35275' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35275' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35275' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35276' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35276' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35301' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35276' ).itblitem := CONFEXME_82.tbrcED_Item( '35301' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35276' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35276' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35276' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35277' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35277' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35302' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35277' ).itblitem := CONFEXME_82.tbrcED_Item( '35302' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35277' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35277' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35277' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35278' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35278' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35303' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35278' ).itblitem := CONFEXME_82.tbrcED_Item( '35303' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35278' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35278' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35278' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35279' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35279' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35304' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35279' ).itblitem := CONFEXME_82.tbrcED_Item( '35304' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35279' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35279' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35279' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35280' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35280' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35305' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35280' ).itblitem := CONFEXME_82.tbrcED_Item( '35305' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35280' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35280' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35280' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35281' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35281' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35306' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35281' ).itblitem := CONFEXME_82.tbrcED_Item( '35306' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35281' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35281' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35281' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35282' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35282' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35307' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35282' ).itblitem := CONFEXME_82.tbrcED_Item( '35307' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35282' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35282' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35282' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35283' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35283' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35308' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35283' ).itblitem := CONFEXME_82.tbrcED_Item( '35308' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35283' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35283' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35283' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35284' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35284' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6731' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35309' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35284' ).itblitem := CONFEXME_82.tbrcED_Item( '35309' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35284' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35284' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35284' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35311' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35311' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35336' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35311' ).itblitem := CONFEXME_82.tbrcED_Item( '35336' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35311' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35311' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35311' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35312' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35312' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35337' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35312' ).itblitem := CONFEXME_82.tbrcED_Item( '35337' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35312' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35312' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35312' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35313' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35313' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35338' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35313' ).itblitem := CONFEXME_82.tbrcED_Item( '35338' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35313' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35313' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35313' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35314' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35314' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35339' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35314' ).itblitem := CONFEXME_82.tbrcED_Item( '35339' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35314' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35314' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35314' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35315' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35315' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6736' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35340' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35315' ).itblitem := CONFEXME_82.tbrcED_Item( '35340' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35315' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35315' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35315' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35316' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35316' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35341' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35316' ).itblitem := CONFEXME_82.tbrcED_Item( '35341' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35316' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35316' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35316' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35317' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35317' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6743' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35342' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35317' ).itblitem := CONFEXME_82.tbrcED_Item( '35342' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35317' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35317' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35317' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35318' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35318' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35343' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35318' ).itblitem := CONFEXME_82.tbrcED_Item( '35343' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35318' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35318' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35318' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35319' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35319' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6744' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35344' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35319' ).itblitem := CONFEXME_82.tbrcED_Item( '35344' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35319' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35319' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35319' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35320' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35320' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35345' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35320' ).itblitem := CONFEXME_82.tbrcED_Item( '35345' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35320' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35320' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35320' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35321' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35321' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35346' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35321' ).itblitem := CONFEXME_82.tbrcED_Item( '35346' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35321' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35321' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35321' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35322' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35322' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6745' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35347' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35322' ).itblitem := CONFEXME_82.tbrcED_Item( '35347' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35322' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35322' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35322' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35323' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35323' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6746' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35348' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35323' ).itblitem := CONFEXME_82.tbrcED_Item( '35348' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35323' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35323' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35323' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35324' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35324' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6747' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35349' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35324' ).itblitem := CONFEXME_82.tbrcED_Item( '35349' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35324' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35324' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35324' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35325' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35325' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6748' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35350' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35325' ).itblitem := CONFEXME_82.tbrcED_Item( '35350' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35325' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35325' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35325' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35326' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35326' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6749' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35351' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35326' ).itblitem := CONFEXME_82.tbrcED_Item( '35351' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35326' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35326' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35326' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35327' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35327' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35352' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35327' ).itblitem := CONFEXME_82.tbrcED_Item( '35352' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35327' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35327' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35327' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35328' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35328' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6750' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35353' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35328' ).itblitem := CONFEXME_82.tbrcED_Item( '35353' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35328' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35328' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35328' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '35329' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '35329' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6751' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '35354' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '35329' ).itblitem := CONFEXME_82.tbrcED_Item( '35354' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '35329' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '35329' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '35329' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36256' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36256' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36281' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36256' ).itblitem := CONFEXME_82.tbrcED_Item( '36281' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36256' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36256' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36256' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36257' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36257' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36282' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36257' ).itblitem := CONFEXME_82.tbrcED_Item( '36282' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36257' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36257' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36257' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36258' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36258' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36283' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36258' ).itblitem := CONFEXME_82.tbrcED_Item( '36283' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36258' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36258' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36258' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36259' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36259' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36284' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36259' ).itblitem := CONFEXME_82.tbrcED_Item( '36284' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36259' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36259' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36259' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36260' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36260' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36285' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36260' ).itblitem := CONFEXME_82.tbrcED_Item( '36285' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36260' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36260' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36260' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36261' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36261' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36286' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36261' ).itblitem := CONFEXME_82.tbrcED_Item( '36286' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36261' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36261' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36261' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36262' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36262' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36287' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36262' ).itblitem := CONFEXME_82.tbrcED_Item( '36287' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36262' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36262' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36262' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36263' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36263' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36288' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36263' ).itblitem := CONFEXME_82.tbrcED_Item( '36288' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36263' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36263' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36263' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36264' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36264' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36289' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36264' ).itblitem := CONFEXME_82.tbrcED_Item( '36289' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36264' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36264' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36264' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36265' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36265' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36290' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36265' ).itblitem := CONFEXME_82.tbrcED_Item( '36290' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36265' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36265' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36265' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36266' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36266' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36291' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36266' ).itblitem := CONFEXME_82.tbrcED_Item( '36291' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36266' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36266' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36266' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36267' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36267' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36292' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36267' ).itblitem := CONFEXME_82.tbrcED_Item( '36292' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36267' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36267' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36267' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36268' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36268' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6928' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36293' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36268' ).itblitem := CONFEXME_82.tbrcED_Item( '36293' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36268' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36268' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36268' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36270' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36270' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36295' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36270' ).itblitem := CONFEXME_82.tbrcED_Item( '36295' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36270' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36270' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36270' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36271' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36271' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36296' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36271' ).itblitem := CONFEXME_82.tbrcED_Item( '36296' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36271' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36271' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36271' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36272' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36272' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36297' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36272' ).itblitem := CONFEXME_82.tbrcED_Item( '36297' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36272' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36272' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36272' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36273' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36273' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36298' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36273' ).itblitem := CONFEXME_82.tbrcED_Item( '36298' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36273' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36273' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36273' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36274' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36274' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6738' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36299' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36274' ).itblitem := CONFEXME_82.tbrcED_Item( '36299' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36274' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36274' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36274' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36275' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36275' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36300' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36275' ).itblitem := CONFEXME_82.tbrcED_Item( '36300' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36275' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36275' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36275' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36276' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36276' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36301' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36276' ).itblitem := CONFEXME_82.tbrcED_Item( '36301' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36276' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36276' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36276' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36277' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36277' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36302' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36277' ).itblitem := CONFEXME_82.tbrcED_Item( '36302' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36277' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36277' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36277' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36278' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36278' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36303' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36278' ).itblitem := CONFEXME_82.tbrcED_Item( '36303' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36278' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36278' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36278' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36279' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36279' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36304' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36279' ).itblitem := CONFEXME_82.tbrcED_Item( '36304' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36279' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36279' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36279' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36280' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36280' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36305' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36280' ).itblitem := CONFEXME_82.tbrcED_Item( '36305' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36280' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36280' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36280' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36281' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36281' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36306' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36281' ).itblitem := CONFEXME_82.tbrcED_Item( '36306' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36281' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36281' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36281' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36282' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36282' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36307' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36282' ).itblitem := CONFEXME_82.tbrcED_Item( '36307' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36282' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36282' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36282' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36283' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36283' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36308' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36283' ).itblitem := CONFEXME_82.tbrcED_Item( '36308' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36283' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36283' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36283' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36284' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36284' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36309' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36284' ).itblitem := CONFEXME_82.tbrcED_Item( '36309' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36284' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36284' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36284' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36285' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36285' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36310' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36285' ).itblitem := CONFEXME_82.tbrcED_Item( '36310' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36285' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36285' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36285' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36286' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36286' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36311' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36286' ).itblitem := CONFEXME_82.tbrcED_Item( '36311' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36286' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36286' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36286' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36287' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36287' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36312' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36287' ).itblitem := CONFEXME_82.tbrcED_Item( '36312' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36287' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36287' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36287' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36288' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36288' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36313' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36288' ).itblitem := CONFEXME_82.tbrcED_Item( '36313' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36288' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36288' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36288' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36289' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36289' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36314' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36289' ).itblitem := CONFEXME_82.tbrcED_Item( '36314' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36289' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36289' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36289' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36290' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36290' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36315' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36290' ).itblitem := CONFEXME_82.tbrcED_Item( '36315' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36290' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36290' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36290' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36291' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36291' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36316' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36291' ).itblitem := CONFEXME_82.tbrcED_Item( '36316' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36291' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36291' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36291' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36292' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36292' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36317' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36292' ).itblitem := CONFEXME_82.tbrcED_Item( '36317' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36292' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36292' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36292' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36293' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36293' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36318' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36293' ).itblitem := CONFEXME_82.tbrcED_Item( '36318' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36293' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36293' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36293' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36294' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36294' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36319' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36294' ).itblitem := CONFEXME_82.tbrcED_Item( '36319' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36294' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36294' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36294' ).itblblfr,
		20
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36295' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36295' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36320' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36295' ).itblitem := CONFEXME_82.tbrcED_Item( '36320' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36295' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36295' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36295' ).itblblfr,
		21
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36296' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36296' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36321' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36296' ).itblitem := CONFEXME_82.tbrcED_Item( '36321' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36296' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36296' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36296' ).itblblfr,
		22
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36297' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36297' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36322' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36297' ).itblitem := CONFEXME_82.tbrcED_Item( '36322' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36297' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36297' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36297' ).itblblfr,
		23
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36298' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36298' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36323' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36298' ).itblitem := CONFEXME_82.tbrcED_Item( '36323' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36298' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36298' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36298' ).itblblfr,
		24
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36299' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36299' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36324' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36299' ).itblitem := CONFEXME_82.tbrcED_Item( '36324' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36299' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36299' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36299' ).itblblfr,
		25
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36300' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36300' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36325' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36300' ).itblitem := CONFEXME_82.tbrcED_Item( '36325' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36300' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36300' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36300' ).itblblfr,
		26
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_82.tbrcED_ItemBloq( '36301' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_82.tbrcED_ItemBloq( '36301' ).itblblfr := CONFEXME_82.tbrcED_BloqFran( '6728' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_82.tbrcED_Item.exists( '36326' ) ) then
		CONFEXME_82.tbrcED_ItemBloq( '36301' ).itblitem := CONFEXME_82.tbrcED_Item( '36326' ).itemcodi;
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
		CONFEXME_82.tbrcED_ItemBloq( '36301' ).itblcodi,
		CONFEXME_82.tbrcED_ItemBloq( '36301' ).itblitem,
		CONFEXME_82.tbrcED_ItemBloq( '36301' ).itblblfr,
		27
	);

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
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
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E62623266343131392D303866382D343937332D613839312D3135646237323363313166393C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E584D4C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C5265706F7274506172616D65746572733E0D0A202020203C5265706F7274506172616D65746572204E616D653D2250616765436F756E74223E0D0A2020202020203C44617461547970653E496E74656765723C2F44617461547970653E0D0A2020202020203C44656661756C7456616C75653E0D0A20202020202020203C56616C7565733E0D0A202020202020202020203C56616C75653E3D303C2F56616C75653E0D0A20202020202020203C2F56616C7565733E0D0A2020202020203C2F44656661756C7456616C75653E0D0A2020202020203C416C6C6F77426C616E6B3E747275653C2F416C6C6F77426C616E6B3E0D0A202020203C2F5265706F7274506172616D657465723E0D0A20203C2F5265706F7274506172616D65746572733E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E31636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F7264'
		||	'3A536E6170546F477269643E0D0A20203C52696768744D617267696E3E302E31636D3C2F52696768744D617267696E3E0D0A20203C4C6566744D617267696E3E302E31636D3C2F4C6566744D617267696E3E0D0A20203C72643A5265706F727449443E65633139656333322D616631642D343536642D613166622D3064643830663835396432663C2F72643A5265706F727449443E0D0A20203C5061676557696474683E3232636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D224C44435F4441544F535F434C49454E5445223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D2246414354555241223E0D0A202020202020202020203C446174614669656C643E464143545552413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543485F46414354223E0D0A202020202020202020203C446174614669656C643E464543485F464143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D45535F46414354223E0D0A202020202020202020203C446174614669656C643E4D45535F464143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22504552494F444F5F46414354223E0D0A202020202020202020203C446174614669656C643E504552494F444F5F464143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225041474F5F4841535441223E0D0A202020202020202020203C446174614669656C643E5041474F5F48415354413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A202020202020'
		||	'20203C4669656C64204E616D653D22444941535F434F4E53554D4F223E0D0A202020202020202020203C446174614669656C643E444941535F434F4E53554D4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224355504F4E223E0D0A202020202020202020203C446174614669656C643E4355504F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D425245223E0D0A202020202020202020203C446174614669656C643E4E4F4D4252453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444952454343494F4E5F434F42524F223E0D0A202020202020202020203C446174614669656C643E444952454343494F4E5F434F42524F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C4F43414C49444144223E0D0A202020202020202020203C446174614669656C643E4C4F43414C494441443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243415445474F524941223E0D0A202020202020202020203C446174614669656C643E43415445474F5249413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F'
		||	'72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224553545241544F223E0D0A202020202020202020203C446174614669656C643E4553545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224349434C4F223E0D0A202020202020202020203C446174614669656C643E4349434C4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2252555441223E0D0A202020202020202020203C446174614669656C643E525554413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D455345535F4445554441223E0D0A202020202020202020203C446174614669656C643E4D455345535F44455544413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E554D5F434F4E54524F4C223E0D0A202020202020202020203C446174614669656C643E4E554D5F434F4E54524F4C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22504552494F444F5F434F4E53554D4F223E0D0A202020202020202020203C446174614669656C643E504552494F444F5F434F4E53554D4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C444F5F4641564F52223E0D0A202020202020202020203C446174614669656C643E53414C444F5F4641564F523C2F446174614669656C643E0D0A'
		||	'202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F53555350454E53494F4E223E0D0A202020202020202020203C446174614669656C643E46454348415F53555350454E53494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525F5245434C223E0D0A202020202020202020203C446174614669656C643E56414C4F525F5245434C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22544F54414C5F46414354555241223E0D0A202020202020202020203C446174614669656C643E544F54414C5F464143545552413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225041474F5F53494E5F5245434152474F223E0D0A202020202020202020203C446174614669656C643E5041474F5F53494E5F5245434152474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224355504F5F4252494C4C41223E0D0A202020202020202020203C446174614669656C643E4355504F5F4252494C4C413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E7472'
		||	'75653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F434C49454E54453C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F4441544F535F4C454354555241223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224E554D5F4D454449444F52223E0D0A202020202020202020203C446174614669656C643E4E554D5F4D454449444F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C4543545552415F414E544552494F52223E0D0A202020202020202020203C446174614669656C643E4C4543545552415F414E544552494F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C4543545552415F41435455414C223E0D0A202020202020202020203C446174614669656C643E4C4543545552415F41435455414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224F42535F4C454354555241223E0D0A202020202020202020203C446174614669656C643E4F42535F4C4543545552413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E'
		||	'0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F4C4543545552413C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F4441544F535F434F4E53554D4F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4E535F434F52524547223E0D0A202020202020202020203C446174614669656C643E434F4E535F434F525245473C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464143544F525F434F5252454343494F4E223E0D0A202020202020202020203C446174614669656C643E464143544F525F434F5252454343494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F4D45535F31223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F4D45535F313C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F4D45535F32223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F4D45535F323C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F4D45535F33223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F4D45535F333C2F'
		||	'446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F4D45535F34223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F4D45535F343C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F4D45535F35223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F4D45535F353C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F4D45535F36223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F4D45535F363C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F434F4E535F4D45535F31223E0D0A202020202020202020203C446174614669656C643E46454348415F434F4E535F4D45535F313C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F434F4E535F4D45535F32223E0D0A202020202020202020203C446174614669656C643E46454348415F434F4E535F4D45535F323C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F434F4E535F4D45535F33223E0D0A202020202020202020203C446174614669656C643E46454348415F434F4E535F4D45535F333C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E53747269'
		||	'6E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F434F4E535F4D45535F34223E0D0A202020202020202020203C446174614669656C643E46454348415F434F4E535F4D45535F343C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F434F4E535F4D45535F35223E0D0A202020202020202020203C446174614669656C643E46454348415F434F4E535F4D45535F353C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F434F4E535F4D45535F36223E0D0A202020202020202020203C446174614669656C643E46454348415F434F4E535F4D45535F363C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F50524F4D4544494F223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F50524F4D4544494F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2254454D5045524154555241223E0D0A202020202020202020203C446174614669656C643E54454D50455241545552413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2250524553494F4E223E0D0A202020202020202020203C446174614669656C643E50524553494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D'
		||	'224551554956414C5F4B5748223E0D0A202020202020202020203C446174614669656C643E4551554956414C5F4B57483C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243414C43434F4E53223E0D0A202020202020202020203C446174614669656C643E43414C43434F4E533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F434F4E53554D4F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F434F4E53554D4F535F48495354223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F5F4D4553223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F5F4D45533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F434F4E535F4D4553223E0D0A202020202020202020203C446174614669656C643E46454348415F434F4E535F4D45533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20'
		||	'20202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E434F4E53554D4F535F484953543C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F434152474F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22444553435F434F4E434550223E0D0A202020202020202020203C446174614669656C643E444553435F434F4E4345503C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224554495155455441223E0D0A202020202020202020203C446174614669656C643E45544951554554413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C444F5F414E54223E0D0A202020202020202020203C446174614669656C643E53414C444F5F414E543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224341504954414C223E0D0A202020202020202020203C446174614669656C643E4341504954414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020'
		||	'203C4669656C64204E616D653D22494E5445524553223E0D0A202020202020202020203C446174614669656C643E494E54455245533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22544F54414C223E0D0A202020202020202020203C446174614669656C643E544F54414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C444F5F444946223E0D0A202020202020202020203C446174614669656C643E53414C444F5F4449463C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243554F544153223E0D0A202020202020202020203C446174614669656C643E43554F5441533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E434152474F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F52414E474F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224C494D5F494E464552494F52223E0D'
		||	'0A202020202020202020203C446174614669656C643E4C494D5F494E464552494F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C494D5F5355504552494F52223E0D0A202020202020202020203C446174614669656C643E4C494D5F5355504552494F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525F554E49444144223E0D0A202020202020202020203C446174614669656C643E56414C4F525F554E494441443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E53554D4F223E0D0A202020202020202020203C446174614669656C643E434F4E53554D4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C5F434F4E53554D4F223E0D0A202020202020202020203C446174614669656C643E56414C5F434F4E53554D4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C'
		||	'654E616D653E52414E474F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F434F4D50434F5354223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4D50434F5354223E0D0A202020202020202020203C446174614669656C643E434F4D50434F53543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F524553524546223E0D0A202020202020202020203C446174614669656C643E56414C4F5245535245463C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C43414C43223E0D0A202020202020202020203C446174614669656C643E56414C43414C433C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F434F4D50434F53543C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4C44435F434F4D50434F53543C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2245585452415F424152434F44455F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F'
		||	'4445223E0D0A202020202020202020203C446174614669656C643E434F44453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22494D414745223E0D0A202020202020202020203C446174614669656C643E494D4147453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E45585452415F424152434F44455F3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E424152434F44455F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F4355504F4E223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F445F424152223E0D0A202020202020202020203C446174614669656C643E434F445F4241523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A'
		||	'2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4355504F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4355504F4E3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F4441544F535F5245564953494F4E223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D225449504F5F4E4F5449223E0D0A202020202020202020203C446174614669656C643E5449504F5F4E4F54493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D454E535F4E4F5449223E0D0A202020202020202020203C446174614669656C643E4D454E535F4E4F54493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543485F4D4158494D41223E0D0A202020202020202020203C446174614669656C643E464543485F4D4158494D413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543485F53555350223E0D0A202020202020202020203C446174614669656C643E464543485F535553503C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F5175'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4441544F535F5245564953494F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F5245564953494F4E3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F4441544F535F4D41524341223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D2256495349424C45223E0D0A202020202020202020203C446174614669656C643E56495349424C453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22494D505245534F223E0D0A202020202020202020203C446174614669656C643E494D505245534F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4441544F535F4D415243413C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F4D415243413C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224441544F535F41444943494F4E414C4553223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22444952454343494F4E5F50524F445543544F223E0D0A202020202020202020'
		||	'203C446174614669656C643E444952454343494F4E5F50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243415553415F44455356494143494F4E223E0D0A202020202020202020203C446174614669656C643E43415553415F44455356494143494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225041474152455F554E49434F223E0D0A202020202020202020203C446174614669656C643E5041474152455F554E49434F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4441544F535F41444943494F4E414C45533C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F535F41444943494F4E414C45533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F64653E5368617265642068742041732053797374656D2E436F6C6C656374696F6E732E486173687461626C65203D204E65772053797374656D2E436F6C6C656374696F6E732E486173687461626C650D0A5075626C69632046756E6374696F6E20496E7374616E636961724974656D476C6F62616C28427956616C2067726F7570204173204F626A6563742C2042795265662067726F75704E616D6520417320537472696E672C20427952656620757365'
		||	'72494420417320537472696E672920417320537472696E670D0A2020202044696D206B657920417320537472696E67203D2067726F75704E616D652026616D703B207573657249440D0A202020204966204E6F742067726F7570204973204E6F7468696E67205468656E0D0A202020202020202044696D206720417320537472696E67203D2043547970652867726F75702C20537472696E67290D0A20202020202020204966204E6F74202868742E436F6E7461696E734B6579286B65792929205468656E0D0A20202020202020202020202068742E416464286B65792C2067290D0A2020202020202020456C73650D0A2020202020202020202020204966204E6F7420286874286B6579292E457175616C7328672929205468656E0D0A202020202020202020202020202020206874286B657929203D20670D0A202020202020202020202020456E642049660D0A2020202020202020456E642049660D0A20202020456E642049660D0A2020202052657475726E206874286B6579290D0A456E642046756E6374696F6E0D0A0D0A7075626C69632044696D20534E20617320496E7465676572203D20300D0A0D0A7075626C69632066756E6374696F6E2047657453686F704E756D626572286279726566204F6E6520617320737472696E672920617320737472696E670D0A2020206966204F6E65266C743B2667743B2222207468656E0D0A202020202020534E203D20534E202B20310D0A202020656E642069660D0A20202072657475726E20534E0D0A656E642066756E6374696F6E0D0A0D0A5075626C69632046756E6374696F6E2073616C746F732862797265662053616C746F20617320496E74656765722920417320537472696E670D0A202044696D20636164656E6120417320537472696E67203D2022220D0A202044696D206920417320496E74656765720D0A2020466F722069203D203120746F2053616C746F205374657020310D0A202020204966206920266C743B3D2039205468656E0D0A20202020202020636164656E61203D20636164656E612026616D703B202230222026616D703B20690D0A20202020456C73650D0A202020202020636164656E61203D20636164656E612026616D703B20690D0A202020456E642049660D0A20204E65787420690D0A202052657475726E20636164656E610D0A456E642046756E6374696F6E0D0A3C2F436F64653E0D0A20203C57696474683E32312E38636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020'
		||	'203C446174615365744E616D653E4C44435F434152474F533C2F446174615365744E616D653E0D0A20202020202020203C5461626C6547726F7570733E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65315F47726F757031223E0D0A20202020202020202020202020203C47726F757045787072657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D53797374656D2E4D6174682E4365696C696E672828526F774E756D626572284E6F7468696E6729292F3234293C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A20202020202020202020202020203C50616765427265616B4174456E643E747275653C2F50616765427265616B4174456E643E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A2020202020202020202020203C4865616465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783837223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838373C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020'
		||	'202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783639223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836393C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020'
		||	'2020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783736223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837363C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783737223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837373C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C'
		||	'6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783738223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837383C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020'
		||	'202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783739223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837393C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020'
		||	'2020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783830223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838303C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783831223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838313C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C'
		||	'6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783833223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838333C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E6754'
		||	'6F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D5265706F72746974656D732165746971756574616D61782E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E362E3935636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F4865616465723E0D0A2020202020202020202020203C466F6F7465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783839223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838393C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020'
		||	'20202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D436F64652E73616C746F73283735202D20284D617828496E74284669656C64732145544951554554412E56616C756529292D283234202A28496E74285265706F72746974656D732165746971756574616D61782E56616C756529202D2031292929293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2265746971756574616D6178223E0D0A20202020202020202020202020202020202020202020202020203C5669736962696C6974793E0D0A202020202020202020202020202020202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020202020202020202020202020202020202020203C2F5669736962696C6974793E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020'
		||	'2020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4365696C696E67284D617828496E74284669656C64732145544951554554412E56616C756529292F3234293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783730223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837303C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E426F74746F6D3C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D5265706F72746974656D732165746971756574616D'
		||	'61782E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783731223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837313C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E426F74746F6D3C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E'
		||	'0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783732223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837323C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783733223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837333C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E327074'
		||	'3C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783734223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837343C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C54'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'61626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783735223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837353C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783835223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838353C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020'
		||	'202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E3234313039636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F466F6F7465723E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A20202020202020203C2F5461626C6547726F7570733E0D0A20202020202020203C57696474683E32302E3535323931636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783838223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A202020202020202020202020202020'
		||	'2020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321444553435F434F4E4345502E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020'
		||	'2020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783334223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732153414C444F5F414E542E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783335223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A49'
		||	'6E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214341504954414C2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783336223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321494E54455245532E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783337223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F5465787441'
		||	'6C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321544F54414C2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783338223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732153414C444F5F4449462E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E'
		||	'0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783339223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732143554F5441532E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783834223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020'
		||	'202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3234313039636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783836223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020'
		||	'202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E373C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783430223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783832223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020'
		||	'202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E312E31636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A202020202020202020203C5265706561744F6E4E6577506167653E747275653C2F5265706561744F6E4E6577506167653E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E302E34636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E342E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3032363436636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57'
		||	'696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E31636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3032363435636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E36636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E382E3533323138636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3332636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783332223E0D0A20202020202020203C546F703E342E37636D3C2F546F703E0D0A20202020202020203C57696474683E302E3636636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E37636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3434393734636D3C2F486569'
		||	'6768743E0D0A20202020202020203C56616C75653E3D5265706F72744974656D7321434F4E53554D4F5F50524F4D4544494F452E56616C75653C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C5461626C65204E616D653D227461626C6532223E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E4C44435F52414E474F533C2F446174615365744E616D653E0D0A20202020202020203C546F703E36636D3C2F546F703E0D0A20202020202020203C57696474683E352E3632363436636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783634223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3370743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214C494D5F494E464552494F522E56616C75653C2F56616C75653E0D0A'
		||	'20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783635223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3370743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214C494D5F5355504552494F522E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783636223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020'
		||	'202020202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732156414C4F525F554E494441442E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783637223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F70'
		||	'3E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321434F4E53554D4F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783638223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732156414C5F434F4E53554D4F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F'
		||	'783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3233636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E302E36636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E302E36636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3332363436636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E34636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E37636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E302E3233636D3C2F4865696768743E0D0A20202020202020203C4C6566743E31352E34636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C4368617274204E616D653D22436F6E73756D6F73223E0D0A20202020202020203C4C6567656E643E0D0A202020202020202020203C5374796C653E0D0A2020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020203C2F426F726465725374796C653E0D0A2020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'20202020203C2F5374796C653E0D0A202020202020202020203C506F736974696F6E3E526967687443656E7465723C2F506F736974696F6E3E0D0A20202020202020203C2F4C6567656E643E0D0A20202020202020203C43617465676F7279417869733E0D0A202020202020202020203C417869733E0D0A2020202020202020202020203C5469746C653E0D0A20202020202020202020202020203C5374796C65202F3E0D0A2020202020202020202020203C2F5469746C653E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3330303C2F466F6E745765696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C4D616A6F72477269644C696E65733E0D0A20202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C2F4D616A6F72477269644C696E65733E0D0A2020202020202020202020203C4D696E6F72477269644C696E65733E0D0A20202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C2F4D696E6F72477269644C696E65733E0D0A2020202020202020202020203C4D696E3E303C2F4D696E3E0D0A2020202020202020202020203C56697369626C653E747275653C2F56697369626C653E0D0A202020202020202020203C2F417869733E0D0A20202020202020203C2F43617465676F7279417869733E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E4C44435F434F4E53554D4F535F484953543C2F446174615365744E616D653E0D0A20202020202020203C506C6F74417265613E0D0A202020202020202020203C5374796C653E0D0A2020202020202020202020203C4261636B67726F756E64436F6C6F'
		||	'723E57686974653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020203C4261636B67726F756E644772616469656E74456E64436F6C6F723E57686974653C2F4261636B67726F756E644772616469656E74456E64436F6C6F723E0D0A2020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020203C44656661756C743E4461726B477261793C2F44656661756C743E0D0A2020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C2F5374796C653E0D0A20202020202020203C2F506C6F74417265613E0D0A20202020202020203C54687265654450726F706572746965733E0D0A202020202020202020203C526F746174696F6E3E33303C2F526F746174696F6E3E0D0A202020202020202020203C496E636C696E6174696F6E3E33303C2F496E636C696E6174696F6E3E0D0A202020202020202020203C53686164696E673E53696D706C653C2F53686164696E673E0D0A202020202020202020203C57616C6C546869636B6E6573733E35303C2F57616C6C546869636B6E6573733E0D0A20202020202020203C2F54687265654450726F706572746965733E0D0A20202020202020203C506F696E7457696474683E303C2F506F696E7457696474683E0D0A20202020202020203C53657269657347726F7570696E67733E0D0A202020202020202020203C53657269657347726F7570696E673E0D0A2020202020202020202020203C5374617469635365726965733E0D0A20202020202020202020202020203C5374617469634D656D6265723E0D0A202020202020202020202020202020203C4C6162656C3E436F6E73756D6F733C2F4C6162656C3E0D0A20202020202020202020202020203C2F5374617469634D656D6265723E0D0A2020202020202020202020203C2F5374617469635365726965733E0D0A202020202020202020203C2F53657269657347726F7570696E673E0D0A20202020202020203C2F53657269657347726F7570696E67733E0D0A20202020202020203C546F703E332E36636D3C2F546F703E0D0A20202020202020203C537562747970653E506C61696E3C2F537562747970653E0D0A20202020202020203C56616C7565417869733E0D0A202020202020202020203C417869733E0D0A2020202020202020202020203C5469746C653E0D0A20202020202020202020202020203C5374796C6520'
		||	'2F3E0D0A2020202020202020202020203C2F5469746C653E0D0A2020202020202020202020203C5374796C65202F3E0D0A2020202020202020202020203C4D616A6F72477269644C696E65733E0D0A20202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C2F4D616A6F72477269644C696E65733E0D0A2020202020202020202020203C4D696E6F72477269644C696E65733E0D0A20202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C2F4D696E6F72477269644C696E65733E0D0A2020202020202020202020203C4D696E3E303C2F4D696E3E0D0A2020202020202020202020203C4D617267696E3E747275653C2F4D617267696E3E0D0A2020202020202020202020203C5363616C61723E747275653C2F5363616C61723E0D0A202020202020202020203C2F417869733E0D0A20202020202020203C2F56616C7565417869733E0D0A20202020202020203C547970653E436F6C756D6E3C2F547970653E0D0A20202020202020203C57696474683E342E3834636D3C2F57696474683E0D0A20202020202020203C43617465676F727947726F7570696E67733E0D0A202020202020202020203C43617465676F727947726F7570696E673E0D0A2020202020202020202020203C44796E616D696343617465676F726965733E0D0A20202020202020202020202020203C47726F7570696E67204E616D653D22466563686173223E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E733E0D0A2020202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C64732146454348415F434F4E535F4D45532E56616C75653C2F47726F757045787072657373696F6E3E0D0A202020202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A20202020202020202020202020203C2F47726F7570696E673E0D0A202020202020202020'
		||	'20202020203C4C6162656C202F3E0D0A2020202020202020202020203C2F44796E616D696343617465676F726965733E0D0A202020202020202020203C2F43617465676F727947726F7570696E673E0D0A20202020202020203C2F43617465676F727947726F7570696E67733E0D0A20202020202020203C50616C657474653E477261795363616C653C2F50616C657474653E0D0A20202020202020203C4368617274446174613E0D0A202020202020202020203C43686172745365726965733E0D0A2020202020202020202020203C44617461506F696E74733E0D0A20202020202020202020202020203C44617461506F696E743E0D0A202020202020202020202020202020203C4461746156616C7565733E0D0A2020202020202020202020202020202020203C4461746156616C75653E0D0A20202020202020202020202020202020202020203C56616C75653E3D43496E74284669656C647321434F4E53554D4F5F4D45532E56616C7565293C2F56616C75653E0D0A2020202020202020202020202020202020203C2F4461746156616C75653E0D0A202020202020202020202020202020203C2F4461746156616C7565733E0D0A202020202020202020202020202020203C446174614C6162656C3E0D0A2020202020202020202020202020202020203C5374796C653E0D0A20202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020202020202020203C56616C75653E3D43496E74284669656C647321434F4E53554D4F5F4D45532E56616C7565293C2F56616C75653E0D0A2020202020202020202020202020202020203C56697369626C653E747275653C2F56697369626C653E0D0A202020202020202020202020202020203C2F446174614C6162656C3E0D0A202020202020202020202020202020203C4D61726B65723E0D0A2020202020202020202020202020202020203C53697A653E3670743C2F53697A653E0D0A202020202020202020202020202020203C2F4D61726B65723E0D0A20202020202020202020202020203C2F44617461506F696E743E0D0A2020202020202020202020203C2F44617461506F696E74733E0D0A202020202020202020203C2F43686172745365726965733E0D0A20202020202020203C2F4368617274446174613E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E57686974653C2F44656661756C743E0D0A202020202020202020203C2F426F7264657243'
		||	'6F6C6F723E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5469746C653E0D0A202020202020202020203C5374796C65202F3E0D0A20202020202020203C2F5469746C653E0D0A20202020202020203C4865696768743E312E36636D3C2F4865696768743E0D0A20202020202020203C4C6566743E31362E34636D3C2F4C6566743E0D0A2020202020203C2F43686172743E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6531223E0D0A20202020202020203C526570656174576974683E7461626C65313C2F526570656174576974683E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783930223E0D0A2020202020202020202020203C546F703E31392E32636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E3432636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3134323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31382E33636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473215041474152455F554E49434F2E56616C75652C20224441544F535F41444943494F4E414C455322293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C496D616765204E616D653D22696D'
		||	'61676531223E0D0A2020202020202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A2020202020202020202020203C546F703E32342E37636D3C2F546F703E0D0A2020202020202020202020203C57696474683E392E31636D3C2F57696474683E0D0A2020202020202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A2020202020202020202020203C5374796C65202F3E0D0A2020202020202020202020203C5A496E6465783E3134313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31312E3738636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E312E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A202020202020202020203C2F496D6167653E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783530223E0D0A2020202020202020202020203C546F703E31372E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3134303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E392E3434636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732146454348415F53555350454E53494F4E452E56616C75653C2F56616C75653E0D0A20'
		||	'2020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783531223E0D0A2020202020202020202020203C546F703E31372E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E33636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31322E3334636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321544F54414C5F46414354555241452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783532223E0D0A2020202020202020202020203C546F703E3139636D3C2F546F703E0D0A2020202020202020202020203C57696474683E382E3134636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F'
		||	'74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E342E3734636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321434F4D50434F5354452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783533223E0D0A2020202020202020202020203C546F703E31382E3635636D3C2F546F703E0D0A2020202020202020202020203C57696474683E342E3632636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E372E3136636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3335636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732156414C43414C43452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783534223E0D0A2020202020202020202020203C546F703E31382E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E332E3532636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20'
		||	'202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E372E3234636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214551554956414C5F4B5748452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783535223E0D0A2020202020202020202020203C546F703E31372E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E362E3338636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E352E3634636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732153414C444F5F4641564F52452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F'
		||	'783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783536223E0D0A2020202020202020202020203C546F703E31372E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3838636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31342E3334636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214D455345535F4445554441452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783537223E0D0A2020202020202020202020203C546F703E31382E3135636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A202020202020202020202020'
		||	'3C5A496E6465783E3133333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31332E3534636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732156414C4F525F5245434C452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783538223E0D0A2020202020202020202020203C546F703E31382E3635636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E3432636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31332E31636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214355504F4E452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783539223E0D0A2020202020202020202020203C546F703E31382E37636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E3432636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020'
		||	'2020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31372E3834636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D2224202020222026616D703B205265706F72744974656D73214355504F5F4252494C4C41452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783630223E0D0A2020202020202020202020203C546F703E3139636D3C2F546F703E0D0A2020202020202020202020203C57696474683E332E3734636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3133303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D224E6F2E20434F4E54524F4C3A20222026616D703B205265706F72744974656D73214E554D5F434F4E54524F4C452E56616C75653C2F56616C7565'
		||	'3E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783631223E0D0A2020202020202020202020203C546F703E31382E3635636D3C2F546F703E0D0A2020202020202020202020203C57696474683E342E34636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E312E3834636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3335636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732156414C4F524553524546452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783632223E0D0A2020202020202020202020203C546F703E31362E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E332E3532636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F'
		||	'74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31302E3334636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73215041474F5F53494E5F5245434152474F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783633223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32342E38636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3134636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7446616D696C793E436F6465203132383C2F466F6E7446616D696C793E0D0A20202020202020202020202020203C466F6E7453697A653E333070743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E31636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E312E3134393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321434F4445452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874'
		||	'626F78204E616D653D22434F444545223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32322E38636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3334636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132363C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3333343932636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321434F44452E56616C75652C2022434F4445222C202245585452415F424152434F44455F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22494D505245534F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32332E3634393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E67'
		||	'4C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321494D505245534F2E56616C75652C2022494D505245534F222C20224C44435F4441544F535F4D4152434122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F445F42415245223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32302E3234393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3434636D3C2F4C65'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'66743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321434F445F4241522E56616C75652C2022434F445F424152222C20224C44435F4355504F4E22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D225255544145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E3234636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3238636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321525554412E56616C75652C202252555441222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783431223E0D0A2020202020202020202020203C546F703E32362E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E392E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E'
		||	'52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31312E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321494D505245534F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783432223E0D0A2020202020202020202020203C546F703E32362E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E392E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31312E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321434F445F424152452E56616C75653C2F56616C75653E0D0A20202020'
		||	'2020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783433223E0D0A2020202020202020202020203C546F703E32362E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E34636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3132303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E382E3934636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321544F54414C5F46414354555241452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783434223E0D0A2020202020202020202020203C546F703E32352E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E3634636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270'
		||	'743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E382E3734636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214355504F4E452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783435223E0D0A2020202020202020202020203C546F703E32362E38636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3838636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E352E3634636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3330393735636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214349434C4F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783436223E0D0A2020202020202020202020203C546F703E32362E38636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3838636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020'
		||	'2020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E322E3736636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3330393735636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214D455345535F4445554441452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783437223E0D0A2020202020202020202020203C546F703E32362E34636D3C2F546F703E0D0A2020202020202020202020203C57696474683E342E3138636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E312E3934636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732152555441452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783438223E0D0A2020202020202020202020203C546F703E32352E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E67'
		||	'4C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E332E3034636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214E554D5F434F4E54524F4C452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783439223E0D0A2020202020202020202020203C546F703E32352E3333636D3C2F546F703E0D0A2020202020202020202020203C57696474683E332E3734636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E342E33636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321434F4E545241544F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224355504F5F4252494C4C4145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020'
		||	'202020202020202020203C546F703E32302E3834393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214355504F5F4252494C4C412E56616C75652C20224355504F5F4252494C4C41222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2256414C4F525F5245434C45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32302E3634393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C50616464696E674C'
		||	'6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732156414C4F525F5245434C2E56616C75652C202256414C4F525F5245434C222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224D455345535F444555444145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32302E3534393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F486569'
		||	'6768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214D455345535F44455544412E56616C75652C20224D455345535F4445554441222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4D50434F535445223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32312E3134393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3131303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321434F4D50434F53542E56616C75652C20224355504F5F4252494C4C41222C20224C44435F434F4D50434F535422293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D225041474F5F53494E5F5245434152474F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A20202020202020'
		||	'20202020203C546F703E32302E3434393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73215041474F5F53494E5F5245434152474F2E56616C75652C20225041474F5F53494E5F5245434152474F222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2253414C444F5F4641564F5245223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32312E3334393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C5465'
		||	'7874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732153414C444F5F4641564F522E56616C75652C202253414C444F5F464143564F52222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224551554956414C5F4B574845223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32312E3034393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130373C2F5A496E6465783E0D0A20202020202020202020'
		||	'20203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214551554956414C5F4B57482E56616C75652C20224355504F5F4252494C4C41222C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2256414C43414C4345223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32302E3934393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732156414C43414C432E56616C75652C20224355504F5F4252494C4C41222C20224C44435F434F4D50434F535422293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2256414C4F52455352454645223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E74727565'
		||	'3C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32302E3734393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732156414C4F5245535245462E56616C75652C202256414C4F524553524546222C20224C44435F434F4D50434F535422293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224E554D5F434F4E54524F4C45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32312E3234393734636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E32'
		||	'70743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214E554D5F434F4E54524F4C2E56616C75652C20224E554D5F434F4E54524F4C222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224641435455524145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E302E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020'
		||	'203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321464143545552412E56616C75652C202246414354555241222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224D454E535F4E4F544945223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E37636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214D454E535F4E4F54492E56616C75652C20224D454E535F4E4F5449222C20224C44435F4441544F535F5245564953494F4E22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4E545241544F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E37636D3C2F546F703E0D0A20202020202020202020'
		||	'20203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321434F4E545241544F2E56616C75652C2022434F4E545241544F222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22464543485F4D4158494D4145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E38636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E3130303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321464543485F4D4158494D412E56616C75652C2022464543485F4D4158494D41222C20224C44435F4441544F535F5245564953494F4E22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2246454348415F53555350454E53494F4E45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73'
		||	'2146454348415F53555350454E53494F4E2E56616C75652C202246454348415F53555350454E53494F4E222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22544F54414C5F4641435455524145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E34636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321544F54414C5F464143545552412E56616C75652C2022544F54414C5F46414354555241222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22464543485F4641435445223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E'
		||	'3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321464543485F464143542E56616C75652C202246454348415F46414354222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224D45535F4641435445223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020'
		||	'2020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214D45535F464143542E56616C75652C20224D45535F46414354222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22504552494F444F5F4641435445223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E33636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E'
		||	'34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321504552494F444F5F464143542E56616C75652C2022504552494F444F5F46414354222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D225041474F5F484153544145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73215041474F5F48415354412E56616C75652C20225041474F5F4841535441222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22444941535F434F4E53554D4F45223E0D0A2020202020202020202020203C'
		||	'5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E33636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321444941535F434F4E53554D4F2E56616C75652C2022444941535F434F4E53554D4F222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4E535F434F5252454745223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E34636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D'
		||	'0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321434F4E535F434F525245472E56616C75652C2022434F4E535F434F52524547222C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224355504F4E45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C'
		||	'2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214355504F4E2E56616C75652C20224355504F4E222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224E4F4D42524545223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E39303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214E4F4D4252452E56616C75652C20224E4F4D425245222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22444952454343494F4E5F434F42524F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020'
		||	'203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E32636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321444952454343494F4E5F434F42524F2E56616C75652C2022444952454343494F4E5F434F42524F222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224C4F43414C4944414445223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E33636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020'
		||	'202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214C4F43414C494441442E56616C75652C20224C4F43414C49444144222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2243415445474F52494145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E33636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C546F67676C65496D6167653E0D0A20202020202020202020202020203C496E697469616C53746174653E747275653C2F496E697469616C53746174653E0D0A2020202020202020202020203C2F546F67676C65496D6167653E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374'
		||	'796C653E0D0A2020202020202020202020203C5A496E6465783E38373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732143415445474F5249412E56616C75652C202243415445474F524941222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224553545241544F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E34636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214553545241544F2E56616C75652C20224553545241544F222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C'
		||	'54657874626F78204E616D653D224349434C4F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214349434C4F2E56616C75652C20224349434C4F222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22504552494F444F5F434F4E53554D4F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C5465'
		||	'7874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321504552494F444F5F434F4E53554D4F2E56616C75652C2022504552494F444F5F434F4E53554D4F222C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224E554D5F4D454449444F5245223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020'
		||	'202020202020202020203C5A496E6465783E38333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214E554D5F4D454449444F522E56616C75652C20224E554D5F4D454449444F52222C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224C4543545552415F414E544552494F5245223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E32636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214C4543545552415F414E544552494F522E56616C75652C20224C4543545552415F414E544552494F52222C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224C4543545552415F41435455414C45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A202020202020202020202020'
		||	'20203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214C4543545552415F41435455414C2E56616C75652C20224C4543545552415F41435455414C222C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224F42535F4C45435455524145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E32636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67'
		||	'546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E38303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D73214F42535F4C4543545552412E56616C75652C20224F42535F4C454354555241222C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2254454D504552415455524145223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732154454D50455241545552412E56616C75652C202254454D5045524154555241222C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020202020203C54657874626F78204E616D653D2250524553494F4E45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E32636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732150524553494F4E2E56616C75652C202250524553494F4E222C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2243414C43434F4E5345223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E37636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020'
		||	'2020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732143414C43434F4E532E56616C75652C202243414C43434F4E53222C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4E53554D4F5F50524F4D4544494F45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E38636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321434F4E53554D4F5F50524F4D4544494F2E56616C75652C2022434F4E53'
		||	'554D4F5F50524F4D4544494F222C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22464143544F525F434F5252454343494F4E45223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D7321464143544F525F434F5252454343494F4E2E56616C75652C2022464143544F525F434F5252454343494F4E222C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A2020202020202020202020203C546F703E312E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020'
		||	'2020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31322E35636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321434F4E545241544F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A2020202020202020202020203C546F703E362E33636D3C2F546F703E0D0A2020202020202020202020203C57696474683E342E3834636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E352E31636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321464543485F4D4158494D41452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A2020202020202020202020203C546F703E362E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E342E3632636D3C2F57696474683E0D0A2020'
		||	'202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31302E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732146454348415F53555350454E53494F4E452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A2020202020202020202020203C546F703E352E3735636D3C2F546F703E0D0A2020202020202020202020203C57696474683E31332E36636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E312E35636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E'
		||	'3D5265706F72744974656D73214D454E535F4E4F5449452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A2020202020202020202020203C546F703E332E3435636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E37303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31332E31636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321544F54414C5F46414354555241452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783130223E0D0A2020202020202020202020203C546F703E312E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E34636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464'
		||	'696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31372E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732146414354555241452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A2020202020202020202020203C546F703E312E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31372E33636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321464543485F46414354452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A'
		||	'2020202020202020202020203C546F703E312E36636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3332636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31392E39636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214D45535F46414354452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A2020202020202020202020203C546F703E322E31636D3C2F546F703E0D0A2020202020202020202020203C57696474683E332E3038636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F7474'
		||	'6F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31372E36636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321504552494F444F5F46414354452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A2020202020202020202020203C546F703E322E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31392E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73215041474F5F4841535441452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A2020202020202020202020203C546F703E322E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3636636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C5465787441'
		||	'6C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31372E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321444941535F434F4E53554D4F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A2020202020202020202020203C546F703E342E3435636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31332E31636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321434F4E535F434F52524547452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A2020202020202020202020203C546F703E332E3437636D3C2F546F703E'
		||	'0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E382E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214355504F4E452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783138223E0D0A2020202020202020202020203C546F703E312E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E372E3936636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36313C2F5A496E6465783E0D0A2020202020202020202020203C4C65'
		||	'66743E362E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214E4F4D425245452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A2020202020202020202020203C546F703E32636D3C2F546F703E0D0A2020202020202020202020203C57696474683E372E39636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E36303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E362E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321444952454343494F4E5F434F42524F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A2020202020202020202020203C546F703E322E34636D3C2F546F703E0D0A2020202020202020202020203C57696474683E342E3434636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020'
		||	'202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E362E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214C4F43414C49444144452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A2020202020202020202020203C546F703E322E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E34636D3C2F57696474683E0D0A2020202020202020202020203C546F67676C65496D6167653E0D0A20202020202020202020202020203C496E697469616C53746174653E747275653C2F496E697469616C53746174653E0D0A2020202020202020202020203C2F546F67676C65496D6167653E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E362E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732143415445474F524941452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A2020202020202020202020203C546F703E322E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E'
		||	'0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31322E39636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214553545241544F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783233223E0D0A2020202020202020202020203C546F703E322E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31322E39636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214349434C4F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F5465787462'
		||	'6F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783234223E0D0A2020202020202020202020203C546F703E342E39636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E3432636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E322E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321504552494F444F5F434F4E53554D4F452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A2020202020202020202020203C546F703E342E34636D3C2F546F703E0D0A2020202020202020202020203C57696474683E322E3432636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E322E32636D'
		||	'3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3434393734636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214E554D5F4D454449444F52452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A2020202020202020202020203C546F703E342E3435636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E382E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214C4543545552415F414E544552494F52452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783237223E0D0A2020202020202020202020203C546F703E342E3435636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E352E38636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C7565'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'3E3D5265706F72744974656D73214C4543545552415F41435455414C452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783238223E0D0A2020202020202020202020203C546F703E352E3235636D3C2F546F703E0D0A2020202020202020202020203C57696474683E382E3538636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E342E32636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E34636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D73214F42535F4C454354555241452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A2020202020202020202020203C546F703E352E3035636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E35303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E392E36636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865'
		||	'696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732154454D5045524154555241452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A2020202020202020202020203C546F703E352E3035636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E362E37636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732150524553494F4E452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783331223E0D0A2020202020202020202020203C546F703E352E3035636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3938636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31332E31636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732143414C43434F4E53452E56616C75653C2F56616C75653E0D0A202020202020202020203C'
		||	'2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783333223E0D0A2020202020202020202020203C546F703E342E3435636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E3534636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31302E37636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E33636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D7321464143544F525F434F5252454343494F4E452E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F78353C2F72643A44656661756C744E616D653E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E302E3735636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3235636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34363C2F5A496E6465783E0D0A202020202020'
		||	'2020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E32302E34636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3235636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D5265706F72744974656D732174657874626F78342E56616C75653C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4445223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3937353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3835636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321434F44452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22494D505245534F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F56697369'
		||	'62696C6974793E0D0A2020202020202020202020203C546F703E332E3537353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3635636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D494946284669727374284669656C647321494D505245534F2E56616C75652C20224C44435F4441544F535F4D415243412229204973204E6F7468696E672C2022222C20494946285472696D284669727374284669656C647321494D505245534F2E56616C75652C20224C44435F4441544F535F4D41524341222929203D2022222C2022222C2022496D707265736F20706F723A2022202B204C43617365285472696D284669727374284669656C647321494D505245534F2E56616C75652C20224C44435F4441544F535F4D415243412229292929293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F445F424152223E0D0A2020202020202020202020203C546F703E332E3337353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E327074'
		||	'3C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3535636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321434F445F4241522E56616C75652C20224C44435F4355504F4E22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2252555441223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3837353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3637636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321525554412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C5465'
		||	'7874626F78204E616D653D22434F4D50434F5354223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3737353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4D50434F53542E56616C75652C20224C44435F434F4D50434F535422293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2256414C43414C43223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3632343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D'
		||	'0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E34303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3434393939636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C43414C432E56616C75652C20224C44435F434F4D50434F535422293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224551554956414C5F4B5748223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3232343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214551554956414C5F4B57482E56616C75652C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020'
		||	'202020203C54657874626F78204E616D653D2253414C444F5F4641564F52223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3532343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732153414C444F5F4641564F522E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224D455345535F4445554441223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3432343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A65'
		||	'3E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214D455345535F44455544412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2256414C4F525F5245434C223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3332343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E'
		||	'3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C4F525F5245434C2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224355504F5F4252494C4C41223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3732343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214355504F5F4252494C4C412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224E554D5F434F4E54524F4C223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C486964'
		||	'64656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3837353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214E554D5F434F4E54524F4C2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2256414C4F524553524546223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3332343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3470743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020'
		||	'20203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C4F5245535245462E56616C75652C20224C44435F434F4D50434F535422293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D225041474F5F53494E5F5245434152474F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3932343837636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3435636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E31636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473215041474F5F53494E5F5245434152474F2E56616C75652C20224C44435F4441544F535F434C49454E54'
		||	'4522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4E545241544F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3337353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22464543485F4D4158494D41223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3337353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D'
		||	'0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321464543485F4D4158494D412E56616C75652C20224C44435F4441544F535F5245564953494F4E22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2246454348415F53555350454E53494F4E223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3437353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32'
		||	'393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732146454348415F53555350454E53494F4E2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224D454E535F4E4F5449223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E342E3237353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214D454E535F4E4F54492E56616C75652C20224C44435F4441544F535F5245564953494F4E22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22544F54414C5F46414354555241223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A20202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'20202020202020203C546F703E332E3037353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321544F54414C5F464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2246414354555241223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3537353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566'
		||	'743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22464543485F46414354223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3137353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D'
		||	'0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321464543485F464143542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224D45535F46414354223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3237353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214D45535F464143542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22504552494F444F5F46414354223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3537353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E'
		||	'302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321504552494F444F5F464143542E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D225041474F5F4841535441223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E342E3137353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F'
		||	'703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473215041474F5F48415354412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22444941535F434F4E53554D4F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3837353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321444941535F434F4E53554D4F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020'
		||	'202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4E535F434F52524547223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3937353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4E535F434F525245472E56616C75652C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224355504F4E223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E342E3037353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50'
		||	'616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214355504F4E2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224E4F4D425245223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3637353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F48656967'
		||	'68743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D4252452E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22444952454343494F4E5F434F42524F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E332E3737353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32312E3035636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321444952454343494F4E5F434F42524F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224C4F43414C49444144223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3937353133636D3C2F546F703E0D0A20202020202020'
		||	'20202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214C4F43414C494441442E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2243415445474F524941223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3937353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C546F67676C65496D6167653E0D0A20202020202020202020202020203C496E697469616C53746174653E747275653C2F496E697469616C53746174653E0D0A2020202020202020202020203C2F546F67676C65496D6167653E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020'
		||	'202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732143415445474F5249412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224553545241544F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3037353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D46697273'
		||	'74284669656C6473214553545241544F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224349434C4F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3137353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214349434C4F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22504552494F444F5F434F4E53554D4F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3637353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374'
		||	'796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321504552494F444F5F434F4E53554D4F2E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224E554D5F4D454449444F52223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3737353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A'
		||	'2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214E554D5F4D454449444F522E56616C75652C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224C4543545552415F414E544552494F52223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E312E3837353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214C4543545552415F414E544552494F522E56616C75652C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224C4543545552415F41435455414C223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A202020'
		||	'2020202020202020203C546F703E322E3237353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214C4543545552415F41435455414C2E56616C75652C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224F42535F4C454354555241223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3637353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374'
		||	'796C653E0D0A2020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214F42535F4C4543545552412E56616C75652C20224C44435F4441544F535F4C45435455524122293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2254454D5045524154555241223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3737353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732154454D50455241545552412E56616C75652C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2250524553494F4E223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3837353133636D3C2F546F703E0D0A20202020'
		||	'20202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732150524553494F4E2E56616C75652C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2243414C43434F4E53223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3337353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		3892, 
		hextoraw
		(
			'732143414C43434F4E532E56616C75652C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22434F4E53554D4F5F50524F4D4544494F223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3437353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4E53554D4F5F50524F4D4544494F2E56616C75652C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D22464143544F525F434F5252454343494F4E223E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E322E3537353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E32636D3C2F57696474683E'
		||	'0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321464143544F525F434F5252454343494F4E2E56616C75652C20224C44435F4441544F535F434F4E53554D4F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F78343C2F72643A44656661756C744E616D653E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E302E3837353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3235636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C65'
		||	'66743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3235636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D436F64652E496E7374616E636961724974656D476C6F62616C285265706F72744974656D732174657874626F78312E56616C75652C202246414354555241222C20224C44435F4441544F535F434C49454E54455322293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A2020202020202020202020203C5669736962696C6974793E0D0A20202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A2020202020202020202020203C2F5669736962696C6974793E0D0A2020202020202020202020203C546F703E302E3632353133636D3C2F546F703E0D0A2020202020202020202020203C57696474683E302E3235636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E32302E3935636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E3235636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C647321464143545552412E56616C75652C20224C44435F4441544F535F434C49454E544522293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D224D4152434141475541223E0D0A2020202020202020202020203C546F703E31302E32636D3C2F546F703E0D0A2020202020202020202020203C5769'
		||	'6474683E31342E31636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C436F6C6F723E236664656565653C2F436F6C6F723E0D0A20202020202020202020202020203C466F6E7453697A653E353070743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E302E3934363832636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E322E32636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D494946284669727374284669656C64732156495349424C452E56616C75652C20224C44435F4441544F535F4D415243412229204973204E6F7468696E672C2022222C204949462843496E74284669727374284669656C64732156495349424C452E56616C75652C20224C44435F4441544F535F4D41524341222929203D20312C20224455504C494341444F222C20222229293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C57696474683E32312E37636D3C2F57696474683E0D0A2020202020203C2F52656374616E676C653E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E32372E33636D3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E65732D45533C2F4C616E67756167653E0D0A20203C506167654865696768743E32372E3934636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_82.cuPlantilla( 224 );
	fetch CONFEXME_82.cuPlantilla into nuIdPlantill;
	close CONFEXME_82.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'LDC_PLANTILLA_GASCARIB_REG',
		       plannomb = 'LDC_FACT_GASCARIBE_REG',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 224;
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
			224,
			blContent ,
			'LDC_PLANTILLA_GASCARIB_REG',
			'LDC_FACT_GASCARIBE_REG',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_82.cuExtractAndMix( 82 );
	fetch CONFEXME_82.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_82.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_FACT_GASCARIBE_REG',
		       coeminic = NULL,
		       coempada = '<244>',
		       coempadi = 'LDC_FACT_GASCARIBE_REG',
		       coempame = NULL,
		       coemtido = 66,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 82;
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
			82,
			'LDC_FACT_GASCARIBE_REG',
			NULL,
			'<244>',
			'LDC_FACT_GASCARIBE_REG',
			NULL,
			66,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_82.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_82.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_82.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_82.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_82 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_82'
	);
--}
END;
/
