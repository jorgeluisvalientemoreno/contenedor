BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_72 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_72',
		'CREATE OR REPLACE PACKAGE CONFEXME_72 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_72;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_72',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_72 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_72;'
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_72.cuFormat( 104 );
	fetch CONFEXME_72.cuFormat into nuFormatId;
	close CONFEXME_72.cuFormat;

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
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_72.cuFormat( 104 );
	fetch CONFEXME_72.cuFormat into nuFormatId;
	close CONFEXME_72.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_72.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_FAC_MASIVA_GASCARIBE_PLANO',
		       formtido = 66,
		       formiden = '<104>',
		       formtico = 49,
		       formdein = NULL,
		       formdefi = NULL
		WHERE  formcodi = CONFEXME_72.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_72.rcED_Formato.formcodi := 104 ;

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
			CONFEXME_72.rcED_Formato.formcodi,
			'LDC_FAC_MASIVA_GASCARIBE_PLANO',
			66,
			'<104>',
			49,
			NULL,
			NULL
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_72.tbrcED_Franja( 5178 ).francodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_Franja( 5178 ).francodi,
		'LDC_DATOS_GENERAL',
		CONFEXME_72.tbrcED_Franja( 5178 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_72.tbrcED_FranForm( '5047' ).frfoform := CONFEXME_72.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_72.tbrcED_Franja.exists( 5178 ) ) then
		CONFEXME_72.tbrcED_FranForm( '5047' ).frfofran := CONFEXME_72.tbrcED_Franja( 5178 ).francodi;
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
		CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi,
		CONFEXME_72.tbrcED_FranForm( '5047' ).frfoform,
		CONFEXME_72.tbrcED_FranForm( '5047' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi,
		'LDC_DATOS_GENERALES',
		'LDC_DetalleFact_GasCaribe.RfDatosGenerales',
		CONFEXME_72.tbrcED_FuenDato( '4253' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4254' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4254' ).fudacodi,
		'LDC_DATOS_LECTURA',
		'ldc_detallefact_gascaribe.RfDatosLecturas',
		CONFEXME_72.tbrcED_FuenDato( '4254' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi,
		'LDC_DATOS_CONSUMO',
		'ldc_detallefact_gascaribe.RfDatosConsumoHist',
		CONFEXME_72.tbrcED_FuenDato( '4255' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4256' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4256' ).fudacodi,
		'LDC_DATOS_REVISION',
		'ldc_detallefact_gascaribe.RfDatosRevision',
		CONFEXME_72.tbrcED_FuenDato( '4256' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi,
		'LDC_CARGOS',
		'LDC_DetalleFact_GasCaribe.RfDatosConceptos',
		CONFEXME_72.tbrcED_FuenDato( '4257' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi,
		'LDC_RANGOS_CONSUMO',
		'LDC_DetalleFact_GasCaribe.RfRangosConsumo',
		CONFEXME_72.tbrcED_FuenDato( '4258' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4259' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4259' ).fudacodi,
		'LDC_COMPCOST',
		'LDC_DetalleFact_GasCaribe.rfGetValCostCompValid',
		CONFEXME_72.tbrcED_FuenDato( '4259' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi,
		'LDC_CUPON',
		'LDC_DetalleFact_GasCaribe.RfDatosCodBarras',
		CONFEXME_72.tbrcED_FuenDato( '4260' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4261' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4261' ).fudacodi,
		'LDC_TASAS_CAMBIO',
		'LDC_DetalleFact_GasCaribe.rfGetValRates',
		CONFEXME_72.tbrcED_FuenDato( '4261' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi,
		'LDC_TOTALES',
		'ldc_detallefact_gascaribe.RfConcepParcial',
		CONFEXME_72.tbrcED_FuenDato( '4262' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4263' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ldc_datos_spool]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_72.tbrcED_FuenDato( '4263' ).fudacodi,
		'ldc_datos_spool',
		'ldc_detallefact_gascaribe.prodatosspool',
		CONFEXME_72.tbrcED_FuenDato( '4263' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4264' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4264' ).fudacodi,
		'LDC_PROTECCION_DATOS',
		'LDC_DETALLEFACT_GASCARIBE.RfProteccion_Datos',
		CONFEXME_72.tbrcED_FuenDato( '4264' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4265' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_DATOS_ADICIONALES]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_72.tbrcED_FuenDato( '4265' ).fudacodi,
		'LDC_DATOS_ADICIONALES',
		'LDC_DETALLEFACT_GASCARIBE.RfDatosAdicionales',
		CONFEXME_72.tbrcED_FuenDato( '4265' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4266' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4266' ).fudacodi,
		'LDC_ACUMTATT',
		'ldc_detallefact_gascaribe.RfDatosCuenxCobrTt',
		CONFEXME_72.tbrcED_FuenDato( '4266' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4267' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4267' ).fudacodi,
		'LDC_FINAESPE',
		'LDC_DetalleFact_GasCaribe.RfDatosFinanEspecial',
		CONFEXME_72.tbrcED_FuenDato( '4267' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4268' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4268' ).fudacodi,
		'LDC_MEDIDOR_MAL_UBIC',
		'LDC_DetalleFact_GasCaribe.RfDatosMedMalubi',
		CONFEXME_72.tbrcED_FuenDato( '4268' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4269' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '4269' ).fudacodi,
		'LDC_IMPRIME_FACTURA',
		'LDC_DetalleFact_GasCaribe.rfdatosimpresiondig',
		CONFEXME_72.tbrcED_FuenDato( '4269' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_72.tbrcED_FuenDato( '4270' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_VALORFECH_ULTIMO_PAGO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_72.tbrcED_FuenDato( '4270' ).fudacodi,
		'LDC_VALORFECH_ULTIMO_PAGO',
		'LDC_DetalleFact_GasCaribe.rfLastPayment',
		CONFEXME_72.tbrcED_FuenDato( '4270' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33614' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4254' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33614' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4254' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33614' ).atfdcodi,
		'NUM_MEDIDOR',
		'Num_Medidor',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33614' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33615' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4254' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33615' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4254' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33615' ).atfdcodi,
		'LECTURA_ANTERIOR',
		'Lectura_Anterior',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33615' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33616' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4254' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33616' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4254' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33616' ).atfdcodi,
		'LECTURA_ACTUAL',
		'Lectura_Actual',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33616' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33617' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4254' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33617' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4254' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33617' ).atfdcodi,
		'OBS_LECTURA',
		'Obs_Lectura',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33617' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33618' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4258' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33618' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33618' ).atfdcodi,
		'LIM_INFERIOR',
		'Lim_Inferior',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33618' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33619' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4258' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33619' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33619' ).atfdcodi,
		'LIM_SUPERIOR',
		'Lim_Superior',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33619' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33620' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4258' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33620' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33620' ).atfdcodi,
		'VALOR_UNIDAD',
		'Valor_Unidad',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33620' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33621' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4258' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33621' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33621' ).atfdcodi,
		'CONSUMO',
		'Consumo',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33621' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33622' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4258' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33622' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33622' ).atfdcodi,
		'VAL_CONSUMO',
		'Val_Consumo',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33622' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33623' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4259' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33623' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4259' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33623' ).atfdcodi,
		'COMPCOST',
		'Compcost',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33623' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33624' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4260' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33624' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33624' ).atfdcodi,
		'CODIGO_1',
		'Codigo_1',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33624' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33625' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4260' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33625' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33625' ).atfdcodi,
		'CODIGO_2',
		'Codigo_2',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33625' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33626' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4260' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33626' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33626' ).atfdcodi,
		'CODIGO_3',
		'Codigo_3',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33626' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33627' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4260' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33627' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33627' ).atfdcodi,
		'CODIGO_4',
		'Codigo_4',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33627' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33628' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4260' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33628' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33628' ).atfdcodi,
		'CODIGO_BARRAS',
		'Codigo_Barras',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33628' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33629' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4256' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33629' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4256' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33629' ).atfdcodi,
		'TIPO_NOTI',
		'Tipo_Noti',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33629' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33630' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4256' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33630' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4256' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33630' ).atfdcodi,
		'MENS_NOTI',
		'Mens_Noti',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33630' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33631' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4256' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33631' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4256' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33631' ).atfdcodi,
		'FECH_MAXIMA',
		'Fech_Maxima',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33631' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33632' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4256' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33632' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4256' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33632' ).atfdcodi,
		'FECH_SUSP',
		'Fech_Susp',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33632' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33633' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4261' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33633' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4261' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33633' ).atfdcodi,
		'TASA_ULTIMA',
		'Tasa_Ultima',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33633' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33634' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4261' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33634' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4261' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33634' ).atfdcodi,
		'TASA_PROMEDIO',
		'Tasa_Promedio',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33634' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33635' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33635' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33635' ).atfdcodi,
		'CONS_CORREG',
		'Cons_Correg',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33635' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33636' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33636' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33636' ).atfdcodi,
		'FACTOR_CORRECCION',
		'Factor_Correccion',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33636' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33637' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33637' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33637' ).atfdcodi,
		'CONSUMO_MES_1',
		'Consumo_Mes_1',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33637' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33638' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33638' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33638' ).atfdcodi,
		'FECHA_CONS_MES_1',
		'Fecha_Cons_Mes_1',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33638' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33639' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33639' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33639' ).atfdcodi,
		'CONSUMO_MES_2',
		'Consumo_Mes_2',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33639' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33640' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33640' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33640' ).atfdcodi,
		'FECHA_CONS_MES_2',
		'Fecha_Cons_Mes_2',
		6,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33640' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33641' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33641' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33641' ).atfdcodi,
		'CONSUMO_MES_3',
		'Consumo_Mes_3',
		7,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33641' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33642' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33642' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33642' ).atfdcodi,
		'FECHA_CONS_MES_3',
		'Fecha_Cons_Mes_3',
		8,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33642' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33643' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33643' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33643' ).atfdcodi,
		'CONSUMO_MES_4',
		'Consumo_Mes_4',
		9,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33643' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33644' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33644' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33644' ).atfdcodi,
		'FECHA_CONS_MES_4',
		'Fecha_Cons_Mes_4',
		10,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33644' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33645' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33645' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33645' ).atfdcodi,
		'CONSUMO_MES_5',
		'Consumo_Mes_5',
		11,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33645' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33646' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33646' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33646' ).atfdcodi,
		'FECHA_CONS_MES_5',
		'Fecha_Cons_Mes_5',
		12,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33646' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33647' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33647' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33647' ).atfdcodi,
		'CONSUMO_MES_6',
		'Consumo_Mes_6',
		13,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33647' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33648' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33648' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33648' ).atfdcodi,
		'FECHA_CONS_MES_6',
		'Fecha_Cons_Mes_6',
		14,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33648' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33649' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33649' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33649' ).atfdcodi,
		'CONSUMO_PROMEDIO',
		'Consumo_Promedio',
		15,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33649' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33650' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33650' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33650' ).atfdcodi,
		'TEMPERATURA',
		'Temperatura',
		16,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33650' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33651' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33651' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33651' ).atfdcodi,
		'PRESION',
		'Presion',
		17,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33651' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33652' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33652' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33652' ).atfdcodi,
		'EQUIVAL_KWH',
		'Equival_Kwh',
		18,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33652' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33653' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33653' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33653' ).atfdcodi,
		'CALCULO_CONS',
		'Calculo_Cons',
		19,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33653' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33654' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33654' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33654' ).atfdcodi,
		'ETIQUETA',
		'Etiqueta',
		1,
		'N',
		CONFEXME_72.tbrcED_AtriFuda( '33654' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33655' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33655' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33655' ).atfdcodi,
		'DESC_CONCEP',
		'Desc_Concep',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33655' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33656' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33656' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33656' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33656' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33657' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33657' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33657' ).atfdcodi,
		'CAPITAL',
		'Capital',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33657' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33658' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33658' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33658' ).atfdcodi,
		'INTERES',
		'Interes',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33658' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33659' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33659' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33659' ).atfdcodi,
		'TOTAL',
		'Total',
		6,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33659' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33660' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33660' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33660' ).atfdcodi,
		'SALDO_DIF',
		'Saldo_Dif',
		7,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33660' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33661' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33661' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33661' ).atfdcodi,
		'CUOTAS',
		'Cuotas',
		8,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33661' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33662' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4262' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33662' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33662' ).atfdcodi,
		'TOTAL',
		'Total',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33662' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33663' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4262' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33663' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33663' ).atfdcodi,
		'IVA',
		'Iva',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33663' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33664' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4262' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33664' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33664' ).atfdcodi,
		'SUBTOTAL',
		'Subtotal',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33664' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33665' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4262' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33665' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33665' ).atfdcodi,
		'CARGOSMES',
		'Cargosmes',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33665' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33666' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4262' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33666' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33666' ).atfdcodi,
		'CANTIDAD_CONC',
		'Cantidad_Conc',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33666' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33667' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4263' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33667' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4263' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33667' ).atfdcodi,
		'CUADRILLA_REPARTO',
		'Cuadrilla_Reparto',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33667' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33668' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4263' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33668' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4263' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33668' ).atfdcodi,
		'OBSERV_NO_LECT_CONSEC',
		'Observ_No_Lect_Consec',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33668' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33669' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33669' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33669' ).atfdcodi,
		'FACTURA',
		'Factura',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33669' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33670' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33670' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33670' ).atfdcodi,
		'FECH_FACT',
		'Fech_Fact',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33670' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33671' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33671' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33671' ).atfdcodi,
		'MES_FACT',
		'Mes_Fact',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33671' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33672' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33672' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33672' ).atfdcodi,
		'PERIODO_FACT',
		'Periodo_Fact',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33672' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33673' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33673' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33673' ).atfdcodi,
		'PAGO_HASTA',
		'Pago_Hasta',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33673' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33674' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33674' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33674' ).atfdcodi,
		'DIAS_CONSUMO',
		'Dias_Consumo',
		6,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33674' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33675' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33675' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33675' ).atfdcodi,
		'CONTRATO',
		'Contrato',
		7,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33675' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33676' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33676' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33676' ).atfdcodi,
		'CUPON',
		'Cupon',
		8,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33676' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33677' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33677' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33677' ).atfdcodi,
		'NOMBRE',
		'Nombre',
		9,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33677' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33678' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33678' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33678' ).atfdcodi,
		'DIRECCION_COBRO',
		'Direccion_Cobro',
		10,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33678' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33679' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33679' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33679' ).atfdcodi,
		'LOCALIDAD',
		'Localidad',
		11,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33679' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33680' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33680' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33680' ).atfdcodi,
		'CATEGORIA',
		'Categoria',
		12,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33680' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33681' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33681' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33681' ).atfdcodi,
		'ESTRATO',
		'Estrato',
		13,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33681' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33682' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33682' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33682' ).atfdcodi,
		'CICLO',
		'Ciclo',
		14,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33682' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33683' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33683' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33683' ).atfdcodi,
		'RUTA',
		'Ruta',
		15,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33683' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33684' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33684' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33684' ).atfdcodi,
		'MESES_DEUDA',
		'Meses_Deuda',
		16,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33684' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33685' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33685' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33685' ).atfdcodi,
		'NUM_CONTROL',
		'Num_Control',
		17,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33685' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33686' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33686' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33686' ).atfdcodi,
		'PERIODO_CONSUMO',
		'Periodo_Consumo',
		18,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33686' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33687' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33687' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33687' ).atfdcodi,
		'SALDO_FAVOR',
		'Saldo_Favor',
		19,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33687' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33688' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33688' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33688' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		20,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33688' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33689' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33689' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33689' ).atfdcodi,
		'FECHA_SUSPENSION',
		'Fecha_Suspension',
		21,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33689' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33690' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33690' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33690' ).atfdcodi,
		'VALOR_RECL',
		'Valor_Recl',
		22,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33690' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33691' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33691' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33691' ).atfdcodi,
		'TOTAL_FACTURA',
		'Total_Factura',
		23,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33691' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33692' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33692' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33692' ).atfdcodi,
		'PAGO_SIN_RECARGO',
		'Pago_Sin_Recargo',
		24,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33692' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33693' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33693' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33693' ).atfdcodi,
		'CONDICION_PAGO',
		'Condicion_Pago',
		25,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33693' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33694' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33694' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33694' ).atfdcodi,
		'IDENTIFICA',
		'Identifica',
		26,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33694' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33695' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33695' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33695' ).atfdcodi,
		'SERVICIO',
		'Tipo de producto',
		27,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33695' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33696' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4264' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33696' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4264' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33696' ).atfdcodi,
		'VISIBLE',
		'Visible',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33696' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33697' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4264' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33697' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4264' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33697' ).atfdcodi,
		'IMPRESO',
		'Impreso',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33697' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33698' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4264' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33698' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4264' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33698' ).atfdcodi,
		'PROTECCION_ESTADO',
		'Proteccion_Estado',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33698' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33699' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4266' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33699' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4266' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33699' ).atfdcodi,
		'ACUMU',
		'Acumu',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33699' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33700' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4265' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33700' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4265' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33700' ).atfdcodi,
		'DIRECCION_PRODUCTO',
		'Direccion_Producto',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33700' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33701' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4265' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33701' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4265' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33701' ).atfdcodi,
		'CAUSA_DESVIACION',
		'Causa_Desviacion',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33701' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33702' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4265' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33702' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4265' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33702' ).atfdcodi,
		'PAGARE_UNICO',
		'Pagare_Unico',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33702' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33703' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4265' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33703' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4265' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33703' ).atfdcodi,
		'CAMBIOUSO',
		'Cambiouso',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33703' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33704' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4267' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33704' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4267' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33704' ).atfdcodi,
		'FINAESPE',
		'Finaespe',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33704' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33705' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4268' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33705' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4268' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33705' ).atfdcodi,
		'MED_MAL_UBICADO',
		'Med_Mal_Ubicado',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33705' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33706' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4269' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33706' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4269' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33706' ).atfdcodi,
		'IMPRIMEFACT',
		'Imprimefact',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33706' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33707' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4270' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33707' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4270' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33707' ).atfdcodi,
		'VALOR_ULT_PAGO',
		'Valor_Ult_Pago',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33707' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_72.tbrcED_AtriFuda( '33708' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4270' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '33708' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '4270' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '33708' ).atfdcodi,
		'FECHA_ULT_PAGO',
		'Fecha_Ult_Pago',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '33708' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7364 ).bloqcodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DATOS]', 5 );
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
		CONFEXME_72.tbrcED_Bloque( 7364 ).bloqcodi,
		'LDC_DATOS',
		CONFEXME_72.tbrcED_Bloque( 7364 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7364 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7365 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4253' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7365 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4253' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7365 ).bloqcodi,
		'LDC_DATOS_CLIENTE',
		CONFEXME_72.tbrcED_Bloque( 7365 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7365 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7366 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4254' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7366 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4254' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7366 ).bloqcodi,
		'LDC_DATOS_LECTURA',
		CONFEXME_72.tbrcED_Bloque( 7366 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7366 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7367 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4255' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7367 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4255' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7367 ).bloqcodi,
		'LDC_DATOS_CONSUMO',
		CONFEXME_72.tbrcED_Bloque( 7367 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7367 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7368 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4256' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7368 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4256' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7368 ).bloqcodi,
		'LDC_DATOS_REVISION',
		CONFEXME_72.tbrcED_Bloque( 7368 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7368 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7369 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4257' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7369 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4257' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [CARGOS]', 5 );
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
		CONFEXME_72.tbrcED_Bloque( 7369 ).bloqcodi,
		'CARGOS',
		CONFEXME_72.tbrcED_Bloque( 7369 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7369 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7370 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4258' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7370 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4258' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7370 ).bloqcodi,
		'LDC_RANGOS',
		CONFEXME_72.tbrcED_Bloque( 7370 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7370 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7371 ).bloqcodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_Bloque( 7371 ).bloqcodi,
		'LDC_BRILLA',
		CONFEXME_72.tbrcED_Bloque( 7371 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7371 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7372 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4259' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7372 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4259' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7372 ).bloqcodi,
		'LDC_COMPCOST',
		CONFEXME_72.tbrcED_Bloque( 7372 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7372 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7373 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4260' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7373 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4260' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7373 ).bloqcodi,
		'LDC_CUPON',
		CONFEXME_72.tbrcED_Bloque( 7373 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7373 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7374 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4261' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7374 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4261' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7374 ).bloqcodi,
		'LDC_TASAS_CAMBIO',
		CONFEXME_72.tbrcED_Bloque( 7374 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7374 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7375 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4262' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7375 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4262' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [TOTALES]', 5 );
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
		CONFEXME_72.tbrcED_Bloque( 7375 ).bloqcodi,
		'TOTALES',
		CONFEXME_72.tbrcED_Bloque( 7375 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7375 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7376 ).bloqcodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Bloque [LDC_ENCABEZADO]', 5 );
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
		CONFEXME_72.tbrcED_Bloque( 7376 ).bloqcodi,
		'LDC_ENCABEZADO',
		CONFEXME_72.tbrcED_Bloque( 7376 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7376 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7377 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4263' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7377 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4263' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7377 ).bloqcodi,
		'LDC_DATOS_SPOOL',
		CONFEXME_72.tbrcED_Bloque( 7377 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7377 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7378 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4264' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7378 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4264' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7378 ).bloqcodi,
		'PROTECCION_DATOS',
		CONFEXME_72.tbrcED_Bloque( 7378 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7378 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7379 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4265' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7379 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4265' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7379 ).bloqcodi,
		'DATOS_ADICIONALES',
		CONFEXME_72.tbrcED_Bloque( 7379 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7379 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7380 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4266' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7380 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4266' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7380 ).bloqcodi,
		'LDC_ACUMTATT',
		CONFEXME_72.tbrcED_Bloque( 7380 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7380 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7381 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4267' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7381 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4267' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7381 ).bloqcodi,
		'LDC_FINAESPE',
		CONFEXME_72.tbrcED_Bloque( 7381 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7381 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7382 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4268' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7382 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4268' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7382 ).bloqcodi,
		'LDC_MEDIDOR_MAL_UBIC',
		CONFEXME_72.tbrcED_Bloque( 7382 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7382 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7383 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4269' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7383 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4269' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7383 ).bloqcodi,
		'LDC_IMPRIME_FACTURA',
		CONFEXME_72.tbrcED_Bloque( 7383 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7383 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_72.tbrcED_Bloque( 7384 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '4270' ) ) then
		CONFEXME_72.tbrcED_Bloque( 7384 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '4270' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 7384 ).bloqcodi,
		'LDC_VALOR_FECH_ULTPAGO',
		CONFEXME_72.tbrcED_Bloque( 7384 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 7384 ).bloqfuda,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7364 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7364 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrfrfo,
		1,
		'N',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7365 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7365 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrfrfo,
		2,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7366 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7366 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrfrfo,
		10,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7367 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7367 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrfrfo,
		11,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7368 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7368 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrfrfo,
		12,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7369 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7369 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrfrfo,
		41,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7370 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7370 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrfrfo,
		20,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7535' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7535' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7371 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7535' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7371 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7535' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7535' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7535' ).blfrfrfo,
		4,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7372 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7372 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrfrfo,
		30,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7373 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7373 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrfrfo,
		31,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7374 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7374 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrfrfo,
		32,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7375 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7375 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrfrfo,
		40,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7376 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7376 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrfrfo,
		0,
		'S',
		'R'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7377 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7377 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrfrfo,
		3,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7378 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7378 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrfrfo,
		33,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7379 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7379 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrfrfo,
		34,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7544' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7544' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7380 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7544' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7380 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7544' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7544' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7544' ).blfrfrfo,
		35,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7545' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7545' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7381 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7545' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7381 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7545' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7545' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7545' ).blfrfrfo,
		36,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7546' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7546' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7382 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7546' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7382 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7546' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7546' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7546' ).blfrfrfo,
		37,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7547' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7547' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7383 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7547' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7383 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7547' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7547' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7547' ).blfrfrfo,
		38,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '5047' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 7384 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 7384 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrfrfo,
		39,
		'S',
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - Genera ordenes de reparto]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'nuOrden = LDC_UTILIDADES_FACT.FSBGENDELIVERYORDER()',
		49,
		'LDC - Genera ordenes de reparto',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382928' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382928' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382928' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
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

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382929' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382929' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382929' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - CANTIDAD FACT]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'sbSessionId = LDC_BOBILLINGPROCESS.FSBGETSESSIONID();sbVariableFacturasBlancas = UT_STRING.FSBCONCAT("FacturasBlancas", sbSessionId, "");nuFacturasBlancas = LDC_BOBILLINGPROCESS.FNUGETVALUE(sbVariableFacturasBlancas) + 1;LDC_BOBILLINGPROCESS.VALUEACCUMULATION(sbVariableFacturasBlancas,1);nuFacturasBlancas = nuFacturasBlancas',
		49,
		'LDC - CANTIDAD FACT',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382930' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382930' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382930' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - Gascaribe Encabezado General]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'sbSessionId = LDC_BOBILLINGPROCESS.FSBGETSESSIONID();sbEncabezadoFlag = UT_STRING.FSBCONCAT("GASCAR", sbSessionId, "-");sbValor = LDC_BOBILLINGPROCESS.FNUGETVALUE(sbEncabezadoFlag);if (sbValor = 0,LDC_BOBILLINGPROCESS.VALUEACCUMULATION(sbEncabezadoFlag,1);sbEncabezado = LDC_DETALLEFACT_GASCARIBE.FSBGETENCABEZADO();,sbEncabezado = null;)',
		49,
		'LDC - Gascaribe Encabezado General',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382931' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382931' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382931' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - ENCABEZADO CONCEPTOS 1]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'sbSessionId = LDC_BOBILLINGPROCESS.FSBGETSESSIONID();sbEncabezadoFlag = UT_STRING.FSBCONCAT("GASCAR", sbSessionId, "-");sbValor = LDC_BOBILLINGPROCESS.FNUGETVALUE(sbEncabezadoFlag);if (sbValor = 1,LDC_BOBILLINGPROCESS.VALUEACCUMULATION(sbEncabezadoFlag,1);sbEncabezado = LDC_DETALLEFACT_GASCARIBE.FSBGETENCABCONC1();,sbEncabezado = null;)',
		49,
		'LDC - ENCABEZADO CONCEPTOS 1',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382932' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382932' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382932' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - ENCABEZADO CONCEPTO 2]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'sbSessionId = LDC_BOBILLINGPROCESS.FSBGETSESSIONID();sbEncabezadoFlag = UT_STRING.FSBCONCAT("GASCAR", sbSessionId, "-");sbValor = LDC_BOBILLINGPROCESS.FNUGETVALUE(sbEncabezadoFlag);if (sbValor = 2,LDC_BOBILLINGPROCESS.VALUEACCUMULATION(sbEncabezadoFlag,1);sbEncabezado = LDC_DETALLEFACT_GASCARIBE.FSBGETENCABCONC2();,sbEncabezado = null;)',
		49,
		'LDC - ENCABEZADO CONCEPTO 2',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382933' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382933' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382933' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - ENCABEZADO CONCEPTO 3]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'sbSessionId = LDC_BOBILLINGPROCESS.FSBGETSESSIONID();sbEncabezadoFlag = UT_STRING.FSBCONCAT("GASCAR", sbSessionId, "-");sbValor = LDC_BOBILLINGPROCESS.FNUGETVALUE(sbEncabezadoFlag);if (sbValor = 3,LDC_BOBILLINGPROCESS.VALUEACCUMULATION(sbEncabezadoFlag,1);sbEncabezado = LDC_DETALLEFACT_GASCARIBE.FSBGETENCABCONC3();,sbEncabezado = null;)',
		49,
		'LDC - ENCABEZADO CONCEPTO 3',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382934' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382934' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382934' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera una nueva expresión
	UT_Trace.Trace( 'Generando la expresión [LDC - ENCABEZADO CONCEPTOS 4]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'sbSessionId = LDC_BOBILLINGPROCESS.FSBGETSESSIONID();sbEncabezadoFlag = UT_STRING.FSBCONCAT("GASCAR", sbSessionId, "-");sbValor = LDC_BOBILLINGPROCESS.FNUGETVALUE(sbEncabezadoFlag);if (sbValor = 4,LDC_BOBILLINGPROCESS.VALUEACCUMULATION(sbEncabezadoFlag,1);sbEncabezado = LDC_DETALLEFACT_GASCARIBE.FSBGETENCABCONC4();,sbEncabezado = null;)',
		49,
		'LDC - ENCABEZADO CONCEPTOS 4',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121382935' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121382935' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121382935' ).code );
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39761' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39761' ).itemobna := 'GCFIFA_CT49E121382928';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382928' ) ) then
		CONFEXME_72.tbrcED_Item( '39761' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382928' ).object_name;
		CONFEXME_72.tbrcED_Item( '39761' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382928' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [Genera Ordenes]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '39761' ).itemcodi,
		'Genera Ordenes',
		CONFEXME_72.tbrcED_Item( '39761' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39761' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39761' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39761' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39762' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39762' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33614' ) ) then
		CONFEXME_72.tbrcED_Item( '39762' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33614' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39762' ).itemcodi,
		'Num_Medidor',
		CONFEXME_72.tbrcED_Item( '39762' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39762' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39762' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39762' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39763' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39763' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33615' ) ) then
		CONFEXME_72.tbrcED_Item( '39763' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33615' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39763' ).itemcodi,
		'Lectura_Anterior',
		CONFEXME_72.tbrcED_Item( '39763' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39763' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39763' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39763' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39764' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39764' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33616' ) ) then
		CONFEXME_72.tbrcED_Item( '39764' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33616' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39764' ).itemcodi,
		'Lectura_Actual',
		CONFEXME_72.tbrcED_Item( '39764' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39764' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39764' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39764' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39765' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39765' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33617' ) ) then
		CONFEXME_72.tbrcED_Item( '39765' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33617' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39765' ).itemcodi,
		'Obs_Lectura',
		CONFEXME_72.tbrcED_Item( '39765' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39765' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39765' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39765' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39766' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39766' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33618' ) ) then
		CONFEXME_72.tbrcED_Item( '39766' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33618' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39766' ).itemcodi,
		'Lim_Inferior',
		CONFEXME_72.tbrcED_Item( '39766' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39766' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39766' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39766' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39767' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39767' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33619' ) ) then
		CONFEXME_72.tbrcED_Item( '39767' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33619' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39767' ).itemcodi,
		'Lim_Superior',
		CONFEXME_72.tbrcED_Item( '39767' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39767' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39767' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39767' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39768' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39768' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33620' ) ) then
		CONFEXME_72.tbrcED_Item( '39768' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33620' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39768' ).itemcodi,
		'Valor_Unidad',
		CONFEXME_72.tbrcED_Item( '39768' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39768' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39768' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39768' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39769' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39769' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33621' ) ) then
		CONFEXME_72.tbrcED_Item( '39769' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33621' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39769' ).itemcodi,
		'Consumo',
		CONFEXME_72.tbrcED_Item( '39769' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39769' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39769' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39769' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39770' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39770' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33622' ) ) then
		CONFEXME_72.tbrcED_Item( '39770' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33622' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39770' ).itemcodi,
		'Val_Consumo',
		CONFEXME_72.tbrcED_Item( '39770' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39770' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39770' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39770' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39771' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39771' ).itemobna := 'GCFIFA_CT49E121382929';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382929' ) ) then
		CONFEXME_72.tbrcED_Item( '39771' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382929' ).object_name;
		CONFEXME_72.tbrcED_Item( '39771' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382929' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '39771' ).itemcodi,
		'CUPO_BRILLA',
		CONFEXME_72.tbrcED_Item( '39771' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39771' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39771' ).itemgren,
		NULL,
		NULL,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39771' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39772' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39772' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33623' ) ) then
		CONFEXME_72.tbrcED_Item( '39772' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33623' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39772' ).itemcodi,
		'Compcost',
		CONFEXME_72.tbrcED_Item( '39772' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39772' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39772' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39772' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39773' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39773' ).itemobna := NULL;

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
		CONFEXME_72.tbrcED_Item( '39773' ).itemcodi,
		'ValoresRef',
		CONFEXME_72.tbrcED_Item( '39773' ).itemceid,
		'DES(h)=0 IPLI=100% IO=100% IRST=NO APLICA',
		CONFEXME_72.tbrcED_Item( '39773' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39773' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39773' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39774' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39774' ).itemobna := NULL;

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
		CONFEXME_72.tbrcED_Item( '39774' ).itemcodi,
		'ValCalc',
		CONFEXME_72.tbrcED_Item( '39774' ).itemceid,
		'DES(h)=0 COMPENSACION($)=0',
		CONFEXME_72.tbrcED_Item( '39774' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39774' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39774' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39775' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39775' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33624' ) ) then
		CONFEXME_72.tbrcED_Item( '39775' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33624' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39775' ).itemcodi,
		'Codigo_1',
		CONFEXME_72.tbrcED_Item( '39775' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39775' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39775' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39775' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39776' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39776' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33625' ) ) then
		CONFEXME_72.tbrcED_Item( '39776' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33625' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39776' ).itemcodi,
		'Codigo_2',
		CONFEXME_72.tbrcED_Item( '39776' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39776' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39776' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39776' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39777' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39777' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33626' ) ) then
		CONFEXME_72.tbrcED_Item( '39777' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33626' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39777' ).itemcodi,
		'Codigo_3',
		CONFEXME_72.tbrcED_Item( '39777' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39777' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39777' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39777' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39778' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39778' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33627' ) ) then
		CONFEXME_72.tbrcED_Item( '39778' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33627' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39778' ).itemcodi,
		'Codigo_4',
		CONFEXME_72.tbrcED_Item( '39778' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39778' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39778' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39778' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39779' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39779' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33628' ) ) then
		CONFEXME_72.tbrcED_Item( '39779' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33628' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39779' ).itemcodi,
		'Codigo_Barras',
		CONFEXME_72.tbrcED_Item( '39779' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39779' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39779' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39779' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39780' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39780' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33629' ) ) then
		CONFEXME_72.tbrcED_Item( '39780' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33629' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39780' ).itemcodi,
		'Tipo_Noti',
		CONFEXME_72.tbrcED_Item( '39780' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39780' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39780' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39780' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39781' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39781' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33630' ) ) then
		CONFEXME_72.tbrcED_Item( '39781' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33630' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39781' ).itemcodi,
		'Mens_Noti',
		CONFEXME_72.tbrcED_Item( '39781' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39781' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39781' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39781' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39782' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39782' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33631' ) ) then
		CONFEXME_72.tbrcED_Item( '39782' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33631' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39782' ).itemcodi,
		'Fech_Maxima',
		CONFEXME_72.tbrcED_Item( '39782' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39782' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39782' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39782' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39783' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39783' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33632' ) ) then
		CONFEXME_72.tbrcED_Item( '39783' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33632' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39783' ).itemcodi,
		'Fech_Susp',
		CONFEXME_72.tbrcED_Item( '39783' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39783' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39783' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39783' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39784' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39784' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33633' ) ) then
		CONFEXME_72.tbrcED_Item( '39784' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33633' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39784' ).itemcodi,
		'Tasa_Ultima',
		CONFEXME_72.tbrcED_Item( '39784' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39784' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39784' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39784' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39785' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39785' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33634' ) ) then
		CONFEXME_72.tbrcED_Item( '39785' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33634' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39785' ).itemcodi,
		'Tasa_Promedio',
		CONFEXME_72.tbrcED_Item( '39785' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39785' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39785' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39785' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39786' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39786' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33635' ) ) then
		CONFEXME_72.tbrcED_Item( '39786' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33635' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39786' ).itemcodi,
		'Cons_Correg',
		CONFEXME_72.tbrcED_Item( '39786' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39786' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39786' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39786' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39787' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39787' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33636' ) ) then
		CONFEXME_72.tbrcED_Item( '39787' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33636' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39787' ).itemcodi,
		'Factor_Correccion',
		CONFEXME_72.tbrcED_Item( '39787' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39787' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39787' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39787' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39788' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39788' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33637' ) ) then
		CONFEXME_72.tbrcED_Item( '39788' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33637' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39788' ).itemcodi,
		'Consumo_Mes_1',
		CONFEXME_72.tbrcED_Item( '39788' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39788' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39788' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39788' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39789' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39789' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33638' ) ) then
		CONFEXME_72.tbrcED_Item( '39789' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33638' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39789' ).itemcodi,
		'Fecha_Cons_Mes_1',
		CONFEXME_72.tbrcED_Item( '39789' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39789' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39789' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39789' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39790' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39790' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33639' ) ) then
		CONFEXME_72.tbrcED_Item( '39790' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33639' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39790' ).itemcodi,
		'Consumo_Mes_2',
		CONFEXME_72.tbrcED_Item( '39790' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39790' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39790' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39790' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39791' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39791' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33640' ) ) then
		CONFEXME_72.tbrcED_Item( '39791' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33640' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39791' ).itemcodi,
		'Fecha_Cons_Mes_2',
		CONFEXME_72.tbrcED_Item( '39791' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39791' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39791' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39791' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39792' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39792' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33641' ) ) then
		CONFEXME_72.tbrcED_Item( '39792' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33641' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39792' ).itemcodi,
		'Consumo_Mes_3',
		CONFEXME_72.tbrcED_Item( '39792' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39792' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39792' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39792' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39793' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39793' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33642' ) ) then
		CONFEXME_72.tbrcED_Item( '39793' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33642' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39793' ).itemcodi,
		'Fecha_Cons_Mes_3',
		CONFEXME_72.tbrcED_Item( '39793' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39793' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39793' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39793' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39794' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39794' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33643' ) ) then
		CONFEXME_72.tbrcED_Item( '39794' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33643' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39794' ).itemcodi,
		'Consumo_Mes_4',
		CONFEXME_72.tbrcED_Item( '39794' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39794' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39794' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39794' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39795' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39795' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33644' ) ) then
		CONFEXME_72.tbrcED_Item( '39795' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33644' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39795' ).itemcodi,
		'Fecha_Cons_Mes_4',
		CONFEXME_72.tbrcED_Item( '39795' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39795' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39795' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39795' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39796' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39796' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33645' ) ) then
		CONFEXME_72.tbrcED_Item( '39796' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33645' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39796' ).itemcodi,
		'Consumo_Mes_5',
		CONFEXME_72.tbrcED_Item( '39796' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39796' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39796' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39796' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39797' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39797' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33646' ) ) then
		CONFEXME_72.tbrcED_Item( '39797' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33646' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39797' ).itemcodi,
		'Fecha_Cons_Mes_5',
		CONFEXME_72.tbrcED_Item( '39797' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39797' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39797' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39797' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39798' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39798' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33647' ) ) then
		CONFEXME_72.tbrcED_Item( '39798' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33647' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39798' ).itemcodi,
		'Consumo_Mes_6',
		CONFEXME_72.tbrcED_Item( '39798' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39798' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39798' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39798' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39799' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39799' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33648' ) ) then
		CONFEXME_72.tbrcED_Item( '39799' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33648' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39799' ).itemcodi,
		'Fecha_Cons_Mes_6',
		CONFEXME_72.tbrcED_Item( '39799' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39799' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39799' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39799' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39800' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39800' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33649' ) ) then
		CONFEXME_72.tbrcED_Item( '39800' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33649' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39800' ).itemcodi,
		'Consumo_Promedio',
		CONFEXME_72.tbrcED_Item( '39800' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39800' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39800' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39800' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39801' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39801' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33650' ) ) then
		CONFEXME_72.tbrcED_Item( '39801' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33650' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39801' ).itemcodi,
		'Temperatura',
		CONFEXME_72.tbrcED_Item( '39801' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39801' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39801' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39801' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39802' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39802' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33651' ) ) then
		CONFEXME_72.tbrcED_Item( '39802' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33651' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39802' ).itemcodi,
		'Presion',
		CONFEXME_72.tbrcED_Item( '39802' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39802' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39802' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39802' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39803' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39803' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33652' ) ) then
		CONFEXME_72.tbrcED_Item( '39803' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33652' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39803' ).itemcodi,
		'Equival_Kwh',
		CONFEXME_72.tbrcED_Item( '39803' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39803' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39803' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39803' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39804' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39804' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33653' ) ) then
		CONFEXME_72.tbrcED_Item( '39804' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33653' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39804' ).itemcodi,
		'Calculo_Cons',
		CONFEXME_72.tbrcED_Item( '39804' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39804' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39804' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39804' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39805' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39805' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33655' ) ) then
		CONFEXME_72.tbrcED_Item( '39805' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33655' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39805' ).itemcodi,
		'Desc_Concep',
		CONFEXME_72.tbrcED_Item( '39805' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39805' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39805' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39805' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39806' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39806' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33656' ) ) then
		CONFEXME_72.tbrcED_Item( '39806' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33656' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39806' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_72.tbrcED_Item( '39806' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39806' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39806' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39806' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39807' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39807' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33657' ) ) then
		CONFEXME_72.tbrcED_Item( '39807' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33657' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39807' ).itemcodi,
		'Capital',
		CONFEXME_72.tbrcED_Item( '39807' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39807' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39807' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39807' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39808' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39808' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33658' ) ) then
		CONFEXME_72.tbrcED_Item( '39808' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33658' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39808' ).itemcodi,
		'Interes',
		CONFEXME_72.tbrcED_Item( '39808' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39808' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39808' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39808' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39809' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39809' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33659' ) ) then
		CONFEXME_72.tbrcED_Item( '39809' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33659' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39809' ).itemcodi,
		'Total',
		CONFEXME_72.tbrcED_Item( '39809' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39809' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39809' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39809' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39810' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39810' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33660' ) ) then
		CONFEXME_72.tbrcED_Item( '39810' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33660' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39810' ).itemcodi,
		'Saldo_Dif',
		CONFEXME_72.tbrcED_Item( '39810' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39810' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39810' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39810' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39811' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39811' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33661' ) ) then
		CONFEXME_72.tbrcED_Item( '39811' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33661' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39811' ).itemcodi,
		'Cuotas',
		CONFEXME_72.tbrcED_Item( '39811' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39811' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39811' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39811' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39812' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39812' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33662' ) ) then
		CONFEXME_72.tbrcED_Item( '39812' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33662' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39812' ).itemcodi,
		'Total',
		CONFEXME_72.tbrcED_Item( '39812' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39812' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39812' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39812' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39813' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39813' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33663' ) ) then
		CONFEXME_72.tbrcED_Item( '39813' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33663' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39813' ).itemcodi,
		'Iva',
		CONFEXME_72.tbrcED_Item( '39813' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39813' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39813' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39813' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39814' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39814' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33664' ) ) then
		CONFEXME_72.tbrcED_Item( '39814' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33664' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39814' ).itemcodi,
		'Subtotal',
		CONFEXME_72.tbrcED_Item( '39814' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39814' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39814' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39814' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39815' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39815' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33665' ) ) then
		CONFEXME_72.tbrcED_Item( '39815' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33665' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39815' ).itemcodi,
		'Cargosmes',
		CONFEXME_72.tbrcED_Item( '39815' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39815' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39815' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39815' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39816' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39816' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33666' ) ) then
		CONFEXME_72.tbrcED_Item( '39816' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33666' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39816' ).itemcodi,
		'Cantidad_Conc',
		CONFEXME_72.tbrcED_Item( '39816' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39816' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39816' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39816' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39817' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39817' ).itemobna := 'GCFIFA_CT49E121382930';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382930' ) ) then
		CONFEXME_72.tbrcED_Item( '39817' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382930' ).object_name;
		CONFEXME_72.tbrcED_Item( '39817' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382930' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [NUMERO_FACT]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '39817' ).itemcodi,
		'NUMERO_FACT',
		CONFEXME_72.tbrcED_Item( '39817' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39817' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39817' ).itemgren,
		NULL,
		NULL,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39817' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39818' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39818' ).itemobna := 'GCFIFA_CT49E121382931';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382931' ) ) then
		CONFEXME_72.tbrcED_Item( '39818' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382931' ).object_name;
		CONFEXME_72.tbrcED_Item( '39818' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382931' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [ENCABEZADO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '39818' ).itemcodi,
		'ENCABEZADO',
		CONFEXME_72.tbrcED_Item( '39818' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39818' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39818' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39818' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39819' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39819' ).itemobna := 'GCFIFA_CT49E121382932';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382932' ) ) then
		CONFEXME_72.tbrcED_Item( '39819' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382932' ).object_name;
		CONFEXME_72.tbrcED_Item( '39819' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382932' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [ENCCONC1]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '39819' ).itemcodi,
		'ENCCONC1',
		CONFEXME_72.tbrcED_Item( '39819' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39819' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39819' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39819' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39820' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39820' ).itemobna := 'GCFIFA_CT49E121382933';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382933' ) ) then
		CONFEXME_72.tbrcED_Item( '39820' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382933' ).object_name;
		CONFEXME_72.tbrcED_Item( '39820' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382933' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [ENCCONC2]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '39820' ).itemcodi,
		'ENCCONC2',
		CONFEXME_72.tbrcED_Item( '39820' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39820' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39820' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39820' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39821' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39821' ).itemobna := 'GCFIFA_CT49E121382934';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382934' ) ) then
		CONFEXME_72.tbrcED_Item( '39821' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382934' ).object_name;
		CONFEXME_72.tbrcED_Item( '39821' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382934' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [ENCCONC3]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '39821' ).itemcodi,
		'ENCCONC3',
		CONFEXME_72.tbrcED_Item( '39821' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39821' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39821' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39821' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39822' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39822' ).itemobna := 'GCFIFA_CT49E121382935';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121382935' ) ) then
		CONFEXME_72.tbrcED_Item( '39822' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121382935' ).object_name;
		CONFEXME_72.tbrcED_Item( '39822' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121382935' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [ENCCONC4]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '39822' ).itemcodi,
		'ENCCONC4',
		CONFEXME_72.tbrcED_Item( '39822' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39822' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39822' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39822' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39823' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39823' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33667' ) ) then
		CONFEXME_72.tbrcED_Item( '39823' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33667' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39823' ).itemcodi,
		'Cuadrilla_Reparto',
		CONFEXME_72.tbrcED_Item( '39823' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39823' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39823' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39823' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39824' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39824' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33668' ) ) then
		CONFEXME_72.tbrcED_Item( '39824' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33668' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39824' ).itemcodi,
		'Observ_No_Lect_Consec',
		CONFEXME_72.tbrcED_Item( '39824' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39824' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39824' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39824' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39825' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39825' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33669' ) ) then
		CONFEXME_72.tbrcED_Item( '39825' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33669' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39825' ).itemcodi,
		'Factura',
		CONFEXME_72.tbrcED_Item( '39825' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39825' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39825' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39825' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39826' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39826' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33670' ) ) then
		CONFEXME_72.tbrcED_Item( '39826' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33670' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39826' ).itemcodi,
		'Fech_Fact',
		CONFEXME_72.tbrcED_Item( '39826' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39826' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39826' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39826' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39827' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39827' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33671' ) ) then
		CONFEXME_72.tbrcED_Item( '39827' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33671' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39827' ).itemcodi,
		'Mes_Fact',
		CONFEXME_72.tbrcED_Item( '39827' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39827' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39827' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39827' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39828' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39828' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33672' ) ) then
		CONFEXME_72.tbrcED_Item( '39828' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33672' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39828' ).itemcodi,
		'Periodo_Fact',
		CONFEXME_72.tbrcED_Item( '39828' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39828' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39828' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39828' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39829' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39829' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33673' ) ) then
		CONFEXME_72.tbrcED_Item( '39829' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33673' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39829' ).itemcodi,
		'Pago_Hasta',
		CONFEXME_72.tbrcED_Item( '39829' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39829' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39829' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39829' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39830' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39830' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33674' ) ) then
		CONFEXME_72.tbrcED_Item( '39830' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33674' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39830' ).itemcodi,
		'Dias_Consumo',
		CONFEXME_72.tbrcED_Item( '39830' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39830' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39830' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39830' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39831' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39831' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33675' ) ) then
		CONFEXME_72.tbrcED_Item( '39831' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33675' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39831' ).itemcodi,
		'Contrato',
		CONFEXME_72.tbrcED_Item( '39831' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39831' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39831' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39831' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39832' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39832' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33676' ) ) then
		CONFEXME_72.tbrcED_Item( '39832' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33676' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39832' ).itemcodi,
		'Cupon',
		CONFEXME_72.tbrcED_Item( '39832' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39832' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39832' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39832' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39833' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39833' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33677' ) ) then
		CONFEXME_72.tbrcED_Item( '39833' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33677' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39833' ).itemcodi,
		'Nombre',
		CONFEXME_72.tbrcED_Item( '39833' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39833' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39833' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39833' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39834' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39834' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33678' ) ) then
		CONFEXME_72.tbrcED_Item( '39834' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33678' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39834' ).itemcodi,
		'Direccion_Cobro',
		CONFEXME_72.tbrcED_Item( '39834' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39834' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39834' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39834' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39835' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39835' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33679' ) ) then
		CONFEXME_72.tbrcED_Item( '39835' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33679' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39835' ).itemcodi,
		'Localidad',
		CONFEXME_72.tbrcED_Item( '39835' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39835' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39835' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39835' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39836' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39836' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33680' ) ) then
		CONFEXME_72.tbrcED_Item( '39836' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33680' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39836' ).itemcodi,
		'Categoria',
		CONFEXME_72.tbrcED_Item( '39836' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39836' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39836' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39836' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39837' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39837' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33681' ) ) then
		CONFEXME_72.tbrcED_Item( '39837' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33681' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39837' ).itemcodi,
		'Estrato',
		CONFEXME_72.tbrcED_Item( '39837' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39837' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39837' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39837' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39838' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39838' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33682' ) ) then
		CONFEXME_72.tbrcED_Item( '39838' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33682' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39838' ).itemcodi,
		'Ciclo',
		CONFEXME_72.tbrcED_Item( '39838' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39838' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39838' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39838' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39839' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39839' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33683' ) ) then
		CONFEXME_72.tbrcED_Item( '39839' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33683' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39839' ).itemcodi,
		'Ruta',
		CONFEXME_72.tbrcED_Item( '39839' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39839' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39839' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39839' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39840' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39840' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33684' ) ) then
		CONFEXME_72.tbrcED_Item( '39840' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33684' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39840' ).itemcodi,
		'Meses_Deuda',
		CONFEXME_72.tbrcED_Item( '39840' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39840' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39840' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39840' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39841' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39841' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33685' ) ) then
		CONFEXME_72.tbrcED_Item( '39841' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33685' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39841' ).itemcodi,
		'Num_Control',
		CONFEXME_72.tbrcED_Item( '39841' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39841' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39841' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39841' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39842' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39842' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33686' ) ) then
		CONFEXME_72.tbrcED_Item( '39842' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33686' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39842' ).itemcodi,
		'Periodo_Consumo',
		CONFEXME_72.tbrcED_Item( '39842' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39842' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39842' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39842' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39843' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39843' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33687' ) ) then
		CONFEXME_72.tbrcED_Item( '39843' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33687' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39843' ).itemcodi,
		'Saldo_Favor',
		CONFEXME_72.tbrcED_Item( '39843' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39843' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39843' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39843' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39844' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39844' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33688' ) ) then
		CONFEXME_72.tbrcED_Item( '39844' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33688' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39844' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_72.tbrcED_Item( '39844' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39844' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39844' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39844' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39845' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39845' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33689' ) ) then
		CONFEXME_72.tbrcED_Item( '39845' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33689' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39845' ).itemcodi,
		'Fecha_Suspension',
		CONFEXME_72.tbrcED_Item( '39845' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39845' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39845' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39845' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39846' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39846' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33690' ) ) then
		CONFEXME_72.tbrcED_Item( '39846' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33690' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39846' ).itemcodi,
		'Valor_Recl',
		CONFEXME_72.tbrcED_Item( '39846' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39846' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39846' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39846' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39847' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39847' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33691' ) ) then
		CONFEXME_72.tbrcED_Item( '39847' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33691' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39847' ).itemcodi,
		'Total_Factura',
		CONFEXME_72.tbrcED_Item( '39847' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39847' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39847' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39847' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39848' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39848' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33692' ) ) then
		CONFEXME_72.tbrcED_Item( '39848' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33692' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39848' ).itemcodi,
		'Pago_Sin_Recargo',
		CONFEXME_72.tbrcED_Item( '39848' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39848' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39848' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39848' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39849' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39849' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33693' ) ) then
		CONFEXME_72.tbrcED_Item( '39849' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33693' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39849' ).itemcodi,
		'Condicion_Pago',
		CONFEXME_72.tbrcED_Item( '39849' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39849' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39849' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39849' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39850' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39850' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33694' ) ) then
		CONFEXME_72.tbrcED_Item( '39850' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33694' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39850' ).itemcodi,
		'Identifica',
		CONFEXME_72.tbrcED_Item( '39850' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39850' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39850' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39850' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39851' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39851' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33695' ) ) then
		CONFEXME_72.tbrcED_Item( '39851' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33695' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39851' ).itemcodi,
		'Tipo de producto',
		CONFEXME_72.tbrcED_Item( '39851' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39851' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39851' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39851' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39852' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39852' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33696' ) ) then
		CONFEXME_72.tbrcED_Item( '39852' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33696' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39852' ).itemcodi,
		'Visible',
		CONFEXME_72.tbrcED_Item( '39852' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39852' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39852' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39852' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39853' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39853' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33697' ) ) then
		CONFEXME_72.tbrcED_Item( '39853' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33697' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39853' ).itemcodi,
		'Impreso',
		CONFEXME_72.tbrcED_Item( '39853' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39853' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39853' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39853' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39854' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39854' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33698' ) ) then
		CONFEXME_72.tbrcED_Item( '39854' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33698' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39854' ).itemcodi,
		'Proteccion_Estado',
		CONFEXME_72.tbrcED_Item( '39854' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39854' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39854' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39854' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39855' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39855' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33699' ) ) then
		CONFEXME_72.tbrcED_Item( '39855' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33699' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39855' ).itemcodi,
		'Acumu',
		CONFEXME_72.tbrcED_Item( '39855' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39855' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39855' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39855' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39856' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39856' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33700' ) ) then
		CONFEXME_72.tbrcED_Item( '39856' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33700' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39856' ).itemcodi,
		'Direccion_Producto',
		CONFEXME_72.tbrcED_Item( '39856' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39856' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39856' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39856' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39857' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39857' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33701' ) ) then
		CONFEXME_72.tbrcED_Item( '39857' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33701' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39857' ).itemcodi,
		'Causa_Desviacion',
		CONFEXME_72.tbrcED_Item( '39857' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39857' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39857' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39857' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39858' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39858' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33702' ) ) then
		CONFEXME_72.tbrcED_Item( '39858' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33702' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39858' ).itemcodi,
		'Pagare_Unico',
		CONFEXME_72.tbrcED_Item( '39858' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39858' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39858' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39858' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39859' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39859' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33703' ) ) then
		CONFEXME_72.tbrcED_Item( '39859' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33703' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39859' ).itemcodi,
		'Cambiouso',
		CONFEXME_72.tbrcED_Item( '39859' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39859' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39859' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39859' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39860' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39860' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33704' ) ) then
		CONFEXME_72.tbrcED_Item( '39860' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33704' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39860' ).itemcodi,
		'Finaespe',
		CONFEXME_72.tbrcED_Item( '39860' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39860' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39860' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39860' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39861' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39861' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33705' ) ) then
		CONFEXME_72.tbrcED_Item( '39861' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33705' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39861' ).itemcodi,
		'Med_Mal_Ubicado',
		CONFEXME_72.tbrcED_Item( '39861' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39861' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39861' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39861' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39862' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39862' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33706' ) ) then
		CONFEXME_72.tbrcED_Item( '39862' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33706' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39862' ).itemcodi,
		'Imprimefact',
		CONFEXME_72.tbrcED_Item( '39862' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39862' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39862' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39862' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39863' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39863' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33707' ) ) then
		CONFEXME_72.tbrcED_Item( '39863' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33707' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39863' ).itemcodi,
		'Valor_Ult_Pago',
		CONFEXME_72.tbrcED_Item( '39863' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39863' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39863' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39863' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_72.tbrcED_Item( '39864' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '39864' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '33708' ) ) then
		CONFEXME_72.tbrcED_Item( '39864' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '33708' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '39864' ).itemcodi,
		'Fecha_Ult_Pago',
		CONFEXME_72.tbrcED_Item( '39864' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '39864' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '39864' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '39864' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39636' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39636' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39761' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39636' ).itblitem := CONFEXME_72.tbrcED_Item( '39761' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39636' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39636' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39636' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39637' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39637' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39762' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39637' ).itblitem := CONFEXME_72.tbrcED_Item( '39762' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39637' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39637' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39637' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39638' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39638' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39763' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39638' ).itblitem := CONFEXME_72.tbrcED_Item( '39763' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39638' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39638' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39638' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39639' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39639' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39764' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39639' ).itblitem := CONFEXME_72.tbrcED_Item( '39764' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39639' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39639' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39639' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39640' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39640' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7530' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39765' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39640' ).itblitem := CONFEXME_72.tbrcED_Item( '39765' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39640' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39640' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39640' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39641' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39641' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39766' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39641' ).itblitem := CONFEXME_72.tbrcED_Item( '39766' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39641' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39641' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39641' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39642' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39642' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39767' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39642' ).itblitem := CONFEXME_72.tbrcED_Item( '39767' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39642' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39642' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39642' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39643' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39643' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39768' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39643' ).itblitem := CONFEXME_72.tbrcED_Item( '39768' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39643' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39643' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39643' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39644' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39644' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39769' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39644' ).itblitem := CONFEXME_72.tbrcED_Item( '39769' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39644' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39644' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39644' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39645' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39645' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7534' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39770' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39645' ).itblitem := CONFEXME_72.tbrcED_Item( '39770' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39645' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39645' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39645' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39646' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39646' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7535' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39771' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39646' ).itblitem := CONFEXME_72.tbrcED_Item( '39771' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39646' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39646' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39646' ).itblblfr,
		0
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39647' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39647' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39772' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39647' ).itblitem := CONFEXME_72.tbrcED_Item( '39772' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39647' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39647' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39647' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39648' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39648' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39773' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39648' ).itblitem := CONFEXME_72.tbrcED_Item( '39773' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39648' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39648' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39648' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39649' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39649' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7536' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39774' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39649' ).itblitem := CONFEXME_72.tbrcED_Item( '39774' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39649' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39649' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39649' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39650' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39650' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39775' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39650' ).itblitem := CONFEXME_72.tbrcED_Item( '39775' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39650' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39650' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39650' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39651' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39651' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39776' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39651' ).itblitem := CONFEXME_72.tbrcED_Item( '39776' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39651' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39651' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39651' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39652' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39652' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39777' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39652' ).itblitem := CONFEXME_72.tbrcED_Item( '39777' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39652' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39652' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39652' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39653' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39653' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39778' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39653' ).itblitem := CONFEXME_72.tbrcED_Item( '39778' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39653' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39653' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39653' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39654' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39654' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7537' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39779' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39654' ).itblitem := CONFEXME_72.tbrcED_Item( '39779' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39654' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39654' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39654' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39655' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39655' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39780' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39655' ).itblitem := CONFEXME_72.tbrcED_Item( '39780' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39655' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39655' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39655' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39656' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39656' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39781' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39656' ).itblitem := CONFEXME_72.tbrcED_Item( '39781' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39656' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39656' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39656' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39657' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39657' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39782' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39657' ).itblitem := CONFEXME_72.tbrcED_Item( '39782' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39657' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39657' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39657' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39658' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39658' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7532' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39783' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39658' ).itblitem := CONFEXME_72.tbrcED_Item( '39783' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39658' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39658' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39658' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39659' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39659' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39784' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39659' ).itblitem := CONFEXME_72.tbrcED_Item( '39784' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39659' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39659' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39659' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39660' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39660' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39785' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39660' ).itblitem := CONFEXME_72.tbrcED_Item( '39785' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39660' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39660' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39660' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39661' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39661' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39786' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39661' ).itblitem := CONFEXME_72.tbrcED_Item( '39786' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39661' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39661' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39661' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39662' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39662' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39787' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39662' ).itblitem := CONFEXME_72.tbrcED_Item( '39787' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39662' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39662' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39662' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39663' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39663' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39788' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39663' ).itblitem := CONFEXME_72.tbrcED_Item( '39788' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39663' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39663' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39663' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39664' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39664' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39789' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39664' ).itblitem := CONFEXME_72.tbrcED_Item( '39789' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39664' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39664' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39664' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39665' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39665' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39790' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39665' ).itblitem := CONFEXME_72.tbrcED_Item( '39790' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39665' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39665' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39665' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39666' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39666' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39791' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39666' ).itblitem := CONFEXME_72.tbrcED_Item( '39791' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39666' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39666' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39666' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39667' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39667' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39792' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39667' ).itblitem := CONFEXME_72.tbrcED_Item( '39792' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39667' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39667' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39667' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39668' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39668' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39793' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39668' ).itblitem := CONFEXME_72.tbrcED_Item( '39793' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39668' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39668' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39668' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39669' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39669' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39794' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39669' ).itblitem := CONFEXME_72.tbrcED_Item( '39794' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39669' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39669' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39669' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39670' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39670' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39795' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39670' ).itblitem := CONFEXME_72.tbrcED_Item( '39795' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39670' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39670' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39670' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39671' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39671' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39796' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39671' ).itblitem := CONFEXME_72.tbrcED_Item( '39796' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39671' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39671' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39671' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39672' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39672' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39797' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39672' ).itblitem := CONFEXME_72.tbrcED_Item( '39797' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39672' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39672' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39672' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39673' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39673' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39798' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39673' ).itblitem := CONFEXME_72.tbrcED_Item( '39798' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39673' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39673' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39673' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39674' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39674' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39799' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39674' ).itblitem := CONFEXME_72.tbrcED_Item( '39799' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39674' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39674' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39674' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39675' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39675' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39800' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39675' ).itblitem := CONFEXME_72.tbrcED_Item( '39800' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39675' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39675' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39675' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39676' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39676' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39801' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39676' ).itblitem := CONFEXME_72.tbrcED_Item( '39801' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39676' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39676' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39676' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39677' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39677' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39802' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39677' ).itblitem := CONFEXME_72.tbrcED_Item( '39802' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39677' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39677' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39677' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39678' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39678' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39803' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39678' ).itblitem := CONFEXME_72.tbrcED_Item( '39803' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39678' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39678' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39678' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39679' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39679' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7531' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39804' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39679' ).itblitem := CONFEXME_72.tbrcED_Item( '39804' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39679' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39679' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39679' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39680' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39680' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39805' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39680' ).itblitem := CONFEXME_72.tbrcED_Item( '39805' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39680' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39680' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39680' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39681' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39681' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39806' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39681' ).itblitem := CONFEXME_72.tbrcED_Item( '39806' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39681' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39681' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39681' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39682' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39682' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39807' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39682' ).itblitem := CONFEXME_72.tbrcED_Item( '39807' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39682' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39682' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39682' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39683' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39683' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39808' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39683' ).itblitem := CONFEXME_72.tbrcED_Item( '39808' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39683' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39683' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39683' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39684' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39684' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39809' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39684' ).itblitem := CONFEXME_72.tbrcED_Item( '39809' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39684' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39684' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39684' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39685' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39685' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39810' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39685' ).itblitem := CONFEXME_72.tbrcED_Item( '39810' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39685' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39685' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39685' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39686' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39686' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7533' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39811' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39686' ).itblitem := CONFEXME_72.tbrcED_Item( '39811' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39686' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39686' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39686' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39687' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39687' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39812' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39687' ).itblitem := CONFEXME_72.tbrcED_Item( '39812' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39687' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39687' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39687' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39688' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39688' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39813' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39688' ).itblitem := CONFEXME_72.tbrcED_Item( '39813' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39688' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39688' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39688' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39689' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39689' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39814' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39689' ).itblitem := CONFEXME_72.tbrcED_Item( '39814' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39689' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39689' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39689' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39690' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39690' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39815' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39690' ).itblitem := CONFEXME_72.tbrcED_Item( '39815' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39690' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39690' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39690' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39691' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39691' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7539' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39816' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39691' ).itblitem := CONFEXME_72.tbrcED_Item( '39816' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39691' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39691' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39691' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39692' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39692' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7528' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39817' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39692' ).itblitem := CONFEXME_72.tbrcED_Item( '39817' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39692' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39692' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39692' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39693' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39693' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39818' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39693' ).itblitem := CONFEXME_72.tbrcED_Item( '39818' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39693' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39693' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39693' ).itblblfr,
		0
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39694' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39694' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39819' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39694' ).itblitem := CONFEXME_72.tbrcED_Item( '39819' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39694' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39694' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39694' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39695' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39695' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39820' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39695' ).itblitem := CONFEXME_72.tbrcED_Item( '39820' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39695' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39695' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39695' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39696' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39696' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39821' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39696' ).itblitem := CONFEXME_72.tbrcED_Item( '39821' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39696' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39696' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39696' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39697' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39697' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7540' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39822' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39697' ).itblitem := CONFEXME_72.tbrcED_Item( '39822' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39697' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39697' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39697' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39698' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39698' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39823' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39698' ).itblitem := CONFEXME_72.tbrcED_Item( '39823' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39698' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39698' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39698' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39699' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39699' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7541' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39824' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39699' ).itblitem := CONFEXME_72.tbrcED_Item( '39824' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39699' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39699' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39699' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39700' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39700' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39825' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39700' ).itblitem := CONFEXME_72.tbrcED_Item( '39825' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39700' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39700' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39700' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39701' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39701' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39826' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39701' ).itblitem := CONFEXME_72.tbrcED_Item( '39826' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39701' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39701' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39701' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39702' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39702' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39827' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39702' ).itblitem := CONFEXME_72.tbrcED_Item( '39827' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39702' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39702' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39702' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39703' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39703' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39828' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39703' ).itblitem := CONFEXME_72.tbrcED_Item( '39828' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39703' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39703' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39703' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39704' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39704' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39829' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39704' ).itblitem := CONFEXME_72.tbrcED_Item( '39829' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39704' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39704' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39704' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39705' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39705' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39830' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39705' ).itblitem := CONFEXME_72.tbrcED_Item( '39830' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39705' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39705' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39705' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39706' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39706' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39831' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39706' ).itblitem := CONFEXME_72.tbrcED_Item( '39831' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39706' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39706' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39706' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39707' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39707' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39832' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39707' ).itblitem := CONFEXME_72.tbrcED_Item( '39832' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39707' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39707' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39707' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39708' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39708' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39833' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39708' ).itblitem := CONFEXME_72.tbrcED_Item( '39833' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39708' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39708' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39708' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39709' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39709' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39834' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39709' ).itblitem := CONFEXME_72.tbrcED_Item( '39834' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39709' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39709' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39709' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39710' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39710' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39835' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39710' ).itblitem := CONFEXME_72.tbrcED_Item( '39835' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39710' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39710' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39710' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39711' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39711' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39836' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39711' ).itblitem := CONFEXME_72.tbrcED_Item( '39836' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39711' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39711' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39711' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39712' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39712' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39837' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39712' ).itblitem := CONFEXME_72.tbrcED_Item( '39837' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39712' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39712' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39712' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39713' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39713' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39838' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39713' ).itblitem := CONFEXME_72.tbrcED_Item( '39838' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39713' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39713' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39713' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39714' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39714' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39839' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39714' ).itblitem := CONFEXME_72.tbrcED_Item( '39839' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39714' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39714' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39714' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39715' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39715' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39840' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39715' ).itblitem := CONFEXME_72.tbrcED_Item( '39840' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39715' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39715' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39715' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39716' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39716' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39841' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39716' ).itblitem := CONFEXME_72.tbrcED_Item( '39841' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39716' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39716' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39716' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39717' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39717' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39842' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39717' ).itblitem := CONFEXME_72.tbrcED_Item( '39842' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39717' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39717' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39717' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39718' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39718' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39843' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39718' ).itblitem := CONFEXME_72.tbrcED_Item( '39843' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39718' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39718' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39718' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39719' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39719' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39844' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39719' ).itblitem := CONFEXME_72.tbrcED_Item( '39844' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39719' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39719' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39719' ).itblblfr,
		20
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39720' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39720' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39845' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39720' ).itblitem := CONFEXME_72.tbrcED_Item( '39845' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39720' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39720' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39720' ).itblblfr,
		21
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39721' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39721' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39846' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39721' ).itblitem := CONFEXME_72.tbrcED_Item( '39846' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39721' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39721' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39721' ).itblblfr,
		22
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39722' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39722' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39847' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39722' ).itblitem := CONFEXME_72.tbrcED_Item( '39847' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39722' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39722' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39722' ).itblblfr,
		23
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39723' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39723' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39848' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39723' ).itblitem := CONFEXME_72.tbrcED_Item( '39848' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39723' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39723' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39723' ).itblblfr,
		24
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39724' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39724' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39849' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39724' ).itblitem := CONFEXME_72.tbrcED_Item( '39849' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39724' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39724' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39724' ).itblblfr,
		25
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39725' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39725' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39850' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39725' ).itblitem := CONFEXME_72.tbrcED_Item( '39850' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39725' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39725' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39725' ).itblblfr,
		26
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39726' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39726' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7529' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39851' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39726' ).itblitem := CONFEXME_72.tbrcED_Item( '39851' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39726' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39726' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39726' ).itblblfr,
		27
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39727' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39727' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39852' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39727' ).itblitem := CONFEXME_72.tbrcED_Item( '39852' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39727' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39727' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39727' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39728' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39728' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39853' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39728' ).itblitem := CONFEXME_72.tbrcED_Item( '39853' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39728' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39728' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39728' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39729' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39729' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7542' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39854' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39729' ).itblitem := CONFEXME_72.tbrcED_Item( '39854' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39729' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39729' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39729' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39730' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39730' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7544' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39855' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39730' ).itblitem := CONFEXME_72.tbrcED_Item( '39855' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39730' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39730' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39730' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39731' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39731' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39856' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39731' ).itblitem := CONFEXME_72.tbrcED_Item( '39856' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39731' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39731' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39731' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39732' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39732' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39857' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39732' ).itblitem := CONFEXME_72.tbrcED_Item( '39857' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39732' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39732' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39732' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39733' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39733' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39858' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39733' ).itblitem := CONFEXME_72.tbrcED_Item( '39858' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39733' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39733' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39733' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39734' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39734' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7543' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39859' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39734' ).itblitem := CONFEXME_72.tbrcED_Item( '39859' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39734' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39734' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39734' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39735' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39735' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7545' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39860' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39735' ).itblitem := CONFEXME_72.tbrcED_Item( '39860' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39735' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39735' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39735' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39736' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39736' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7546' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39861' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39736' ).itblitem := CONFEXME_72.tbrcED_Item( '39861' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39736' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39736' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39736' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39737' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39737' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7547' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39862' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39737' ).itblitem := CONFEXME_72.tbrcED_Item( '39862' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39737' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39737' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39737' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39738' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39738' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39863' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39738' ).itblitem := CONFEXME_72.tbrcED_Item( '39863' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39738' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39738' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39738' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_72.tbrcED_ItemBloq( '39739' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '39739' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '7548' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '39864' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '39739' ).itblitem := CONFEXME_72.tbrcED_Item( '39864' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '39739' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '39739' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '39739' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_72.cuExtractAndMix( 72 );
	fetch CONFEXME_72.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_72.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_FACTURA_MASIVA_GASCAR',
		       coeminic = NULL,
		       coempada = '<104>',
		       coempadi = NULL,
		       coempame = NULL,
		       coemtido = 66,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 72;
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
			72,
			'LDC_FACTURA_MASIVA_GASCAR',
			NULL,
			'<104>',
			NULL,
			NULL,
			66,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_72.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_72.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_72.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_72 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_72'
	);
--}
END;
/

