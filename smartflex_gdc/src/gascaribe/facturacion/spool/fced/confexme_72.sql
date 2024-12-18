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
	CONFEXME_72.tbrcED_Franja( 4758 ).francodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_Franja( 4758 ).francodi,
		'LDC_DATOS_GENERAL',
		CONFEXME_72.tbrcED_Franja( 4758 ).frantifr,
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
	CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_72.tbrcED_FranForm( '4594' ).frfoform := CONFEXME_72.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_72.tbrcED_Franja.exists( 4758 ) ) then
		CONFEXME_72.tbrcED_FranForm( '4594' ).frfofran := CONFEXME_72.tbrcED_Franja( 4758 ).francodi;
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
		CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi,
		CONFEXME_72.tbrcED_FranForm( '4594' ).frfoform,
		CONFEXME_72.tbrcED_FranForm( '4594' ).frfofran,
		0,
		'S'
	);

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
	CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi,
		'LDC_DATOS_GENERALES',
		'LDC_DetalleFact_GasCaribe.RfDatosGenerales',
		CONFEXME_72.tbrcED_FuenDato( '3898' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3899' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3899' ).fudacodi,
		'LDC_DATOS_LECTURA',
		'ldc_detallefact_gascaribe.RfDatosLecturas',
		CONFEXME_72.tbrcED_FuenDato( '3899' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi,
		'LDC_DATOS_CONSUMO',
		'ldc_detallefact_gascaribe.RfDatosConsumoHist',
		CONFEXME_72.tbrcED_FuenDato( '3900' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3901' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3901' ).fudacodi,
		'LDC_DATOS_REVISION',
		'ldc_detallefact_gascaribe.RfDatosRevision',
		CONFEXME_72.tbrcED_FuenDato( '3901' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi,
		'LDC_CARGOS',
		'LDC_DetalleFact_GasCaribe.RfDatosConceptos',
		CONFEXME_72.tbrcED_FuenDato( '3902' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi,
		'LDC_RANGOS_CONSUMO',
		'LDC_DetalleFact_GasCaribe.RfRangosConsumo',
		CONFEXME_72.tbrcED_FuenDato( '3903' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3904' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3904' ).fudacodi,
		'LDC_COMPCOST',
		'LDC_DetalleFact_GasCaribe.rfGetValCostCompValid',
		CONFEXME_72.tbrcED_FuenDato( '3904' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi,
		'LDC_CUPON',
		'LDC_DetalleFact_GasCaribe.RfDatosCodBarras',
		CONFEXME_72.tbrcED_FuenDato( '3905' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3906' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3906' ).fudacodi,
		'LDC_TASAS_CAMBIO',
		'LDC_DetalleFact_GasCaribe.rfGetValRates',
		CONFEXME_72.tbrcED_FuenDato( '3906' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi,
		'LDC_TOTALES',
		'ldc_detallefact_gascaribe.RfConcepParcial',
		CONFEXME_72.tbrcED_FuenDato( '3907' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3908' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3908' ).fudacodi,
		'ldc_datos_spool',
		'ldc_detallefact_gascaribe.prodatosspool',
		CONFEXME_72.tbrcED_FuenDato( '3908' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3909' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3909' ).fudacodi,
		'LDC_PROTECCION_DATOS',
		'LDC_DETALLEFACT_GASCARIBE.RfProteccion_Datos',
		CONFEXME_72.tbrcED_FuenDato( '3909' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3910' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3910' ).fudacodi,
		'LDC_DATOS_ADICIONALES',
		'LDC_DETALLEFACT_GASCARIBE.RfDatosAdicionales',
		CONFEXME_72.tbrcED_FuenDato( '3910' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3911' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3911' ).fudacodi,
		'LDC_ACUMTATT',
		'ldc_detallefact_gascaribe.RfDatosCuenxCobrTt',
		CONFEXME_72.tbrcED_FuenDato( '3911' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3912' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3912' ).fudacodi,
		'LDC_FINAESPE',
		'LDC_DetalleFact_GasCaribe.RfDatosFinanEspecial',
		CONFEXME_72.tbrcED_FuenDato( '3912' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3913' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3913' ).fudacodi,
		'LDC_MEDIDOR_MAL_UBIC',
		'LDC_DetalleFact_GasCaribe.RfDatosMedMalubi',
		CONFEXME_72.tbrcED_FuenDato( '3913' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3914' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3914' ).fudacodi,
		'LDC_IMPRIME_FACTURA',
		'LDC_DetalleFact_GasCaribe.rfdatosimpresiondig',
		CONFEXME_72.tbrcED_FuenDato( '3914' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3915' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3915' ).fudacodi,
		'LDC_VALORFECH_ULTIMO_PAGO',
		'LDC_DetalleFact_GasCaribe.rfLastPayment',
		CONFEXME_72.tbrcED_FuenDato( '3915' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3916' ).fudacodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_FuenDato( '3916' ).fudacodi,
		'SALDO_ANTERIOR',
		'LDC_DetalleFact_GasCaribe.rfGetSaldoAnterior',
		CONFEXME_72.tbrcED_FuenDato( '3916' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_FuenDato( '3917' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [INFO_ADICIONAL]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_72.tbrcED_FuenDato( '3917' ).fudacodi,
		'INFO_ADICIONAL',
		'LDC_DetalleFact_GasCaribe.prcGetInfoAdicional',
		CONFEXME_72.tbrcED_FuenDato( '3917' ).fudasent
	);

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
	CONFEXME_72.tbrcED_AtriFuda( '30739' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3899' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30739' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3899' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30739' ).atfdcodi,
		'NUM_MEDIDOR',
		'Num_Medidor',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30739' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30740' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3899' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30740' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3899' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30740' ).atfdcodi,
		'LECTURA_ANTERIOR',
		'Lectura_Anterior',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30740' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30741' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3899' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30741' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3899' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30741' ).atfdcodi,
		'LECTURA_ACTUAL',
		'Lectura_Actual',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30741' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30742' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3899' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30742' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3899' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30742' ).atfdcodi,
		'OBS_LECTURA',
		'Obs_Lectura',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30742' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30743' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3903' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30743' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30743' ).atfdcodi,
		'LIM_INFERIOR',
		'Lim_Inferior',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30743' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30744' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3903' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30744' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30744' ).atfdcodi,
		'LIM_SUPERIOR',
		'Lim_Superior',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30744' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30745' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3903' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30745' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30745' ).atfdcodi,
		'VALOR_UNIDAD',
		'Valor_Unidad',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30745' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30746' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3903' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30746' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30746' ).atfdcodi,
		'CONSUMO',
		'Consumo',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30746' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30747' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3903' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30747' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30747' ).atfdcodi,
		'VAL_CONSUMO',
		'Val_Consumo',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30747' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30748' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3904' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30748' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3904' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30748' ).atfdcodi,
		'COMPCOST',
		'Compcost',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30748' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30749' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3905' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30749' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30749' ).atfdcodi,
		'CODIGO_1',
		'Codigo_1',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30749' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30750' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3905' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30750' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30750' ).atfdcodi,
		'CODIGO_2',
		'Codigo_2',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30750' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30751' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3905' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30751' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30751' ).atfdcodi,
		'CODIGO_3',
		'Codigo_3',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30751' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30752' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3905' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30752' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30752' ).atfdcodi,
		'CODIGO_4',
		'Codigo_4',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30752' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30753' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3905' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30753' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30753' ).atfdcodi,
		'CODIGO_BARRAS',
		'Codigo_Barras',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30753' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30754' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3901' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30754' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3901' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30754' ).atfdcodi,
		'TIPO_NOTI',
		'Tipo_Noti',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30754' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30755' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3901' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30755' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3901' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30755' ).atfdcodi,
		'MENS_NOTI',
		'Mens_Noti',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30755' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30756' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3901' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30756' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3901' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30756' ).atfdcodi,
		'FECH_MAXIMA',
		'Fech_Maxima',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30756' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30757' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3901' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30757' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3901' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30757' ).atfdcodi,
		'FECH_SUSP',
		'Fech_Susp',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30757' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30758' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3906' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30758' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3906' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30758' ).atfdcodi,
		'TASA_ULTIMA',
		'Tasa_Ultima',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30758' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30759' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3906' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30759' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3906' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30759' ).atfdcodi,
		'TASA_PROMEDIO',
		'Tasa_Promedio',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30759' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30760' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30760' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30760' ).atfdcodi,
		'CONS_CORREG',
		'Cons_Correg',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30760' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30761' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30761' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30761' ).atfdcodi,
		'FACTOR_CORRECCION',
		'Factor_Correccion',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30761' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30762' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30762' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30762' ).atfdcodi,
		'CONSUMO_MES_1',
		'Consumo_Mes_1',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30762' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30763' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30763' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30763' ).atfdcodi,
		'FECHA_CONS_MES_1',
		'Fecha_Cons_Mes_1',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30763' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30764' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30764' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30764' ).atfdcodi,
		'CONSUMO_MES_2',
		'Consumo_Mes_2',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30764' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30765' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30765' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30765' ).atfdcodi,
		'FECHA_CONS_MES_2',
		'Fecha_Cons_Mes_2',
		6,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30765' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30766' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30766' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30766' ).atfdcodi,
		'CONSUMO_MES_3',
		'Consumo_Mes_3',
		7,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30766' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30767' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30767' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30767' ).atfdcodi,
		'FECHA_CONS_MES_3',
		'Fecha_Cons_Mes_3',
		8,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30767' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30768' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30768' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30768' ).atfdcodi,
		'CONSUMO_MES_4',
		'Consumo_Mes_4',
		9,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30768' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30769' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30769' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30769' ).atfdcodi,
		'FECHA_CONS_MES_4',
		'Fecha_Cons_Mes_4',
		10,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30769' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30770' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30770' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30770' ).atfdcodi,
		'CONSUMO_MES_5',
		'Consumo_Mes_5',
		11,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30770' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30771' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30771' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30771' ).atfdcodi,
		'FECHA_CONS_MES_5',
		'Fecha_Cons_Mes_5',
		12,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30771' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30772' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30772' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30772' ).atfdcodi,
		'CONSUMO_MES_6',
		'Consumo_Mes_6',
		13,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30772' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30773' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30773' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30773' ).atfdcodi,
		'FECHA_CONS_MES_6',
		'Fecha_Cons_Mes_6',
		14,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30773' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30774' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30774' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30774' ).atfdcodi,
		'CONSUMO_PROMEDIO',
		'Consumo_Promedio',
		15,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30774' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30775' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30775' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30775' ).atfdcodi,
		'TEMPERATURA',
		'Temperatura',
		16,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30775' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30776' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30776' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30776' ).atfdcodi,
		'PRESION',
		'Presion',
		17,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30776' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30777' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30777' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30777' ).atfdcodi,
		'EQUIVAL_KWH',
		'Equival_Kwh',
		18,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30777' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30778' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30778' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30778' ).atfdcodi,
		'CALCULO_CONS',
		'Calculo_Cons',
		19,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30778' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30787' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3907' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30787' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30787' ).atfdcodi,
		'TOTAL',
		'Total',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30787' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30788' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3907' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30788' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30788' ).atfdcodi,
		'IVA',
		'Iva',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30788' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30789' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3907' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30789' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30789' ).atfdcodi,
		'SUBTOTAL',
		'Subtotal',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30789' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30790' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3907' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30790' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30790' ).atfdcodi,
		'CARGOSMES',
		'Cargosmes',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30790' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30791' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3907' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30791' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30791' ).atfdcodi,
		'CANTIDAD_CONC',
		'Cantidad_Conc',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30791' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30792' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3908' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30792' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3908' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30792' ).atfdcodi,
		'CUADRILLA_REPARTO',
		'Cuadrilla_Reparto',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30792' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30793' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3908' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30793' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3908' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30793' ).atfdcodi,
		'OBSERV_NO_LECT_CONSEC',
		'Observ_No_Lect_Consec',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30793' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30794' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30794' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30794' ).atfdcodi,
		'FACTURA',
		'Factura',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30794' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30795' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30795' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30795' ).atfdcodi,
		'FECH_FACT',
		'Fech_Fact',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30795' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30796' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30796' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30796' ).atfdcodi,
		'MES_FACT',
		'Mes_Fact',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30796' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30797' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30797' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30797' ).atfdcodi,
		'PERIODO_FACT',
		'Periodo_Fact',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30797' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30798' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30798' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30798' ).atfdcodi,
		'PAGO_HASTA',
		'Pago_Hasta',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30798' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30799' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30799' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30799' ).atfdcodi,
		'DIAS_CONSUMO',
		'Dias_Consumo',
		6,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30799' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30800' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30800' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30800' ).atfdcodi,
		'CONTRATO',
		'Contrato',
		7,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30800' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30801' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30801' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30801' ).atfdcodi,
		'CUPON',
		'Cupon',
		8,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30801' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30802' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30802' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30802' ).atfdcodi,
		'NOMBRE',
		'Nombre',
		9,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30802' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30803' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30803' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30803' ).atfdcodi,
		'DIRECCION_COBRO',
		'Direccion_Cobro',
		10,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30803' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30804' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30804' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30804' ).atfdcodi,
		'LOCALIDAD',
		'Localidad',
		11,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30804' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30805' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30805' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30805' ).atfdcodi,
		'CATEGORIA',
		'Categoria',
		12,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30805' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30806' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30806' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30806' ).atfdcodi,
		'ESTRATO',
		'Estrato',
		13,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30806' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30807' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30807' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30807' ).atfdcodi,
		'CICLO',
		'Ciclo',
		14,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30807' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30808' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30808' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30808' ).atfdcodi,
		'RUTA',
		'Ruta',
		15,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30808' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30809' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30809' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30809' ).atfdcodi,
		'MESES_DEUDA',
		'Meses_Deuda',
		16,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30809' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30810' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30810' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30810' ).atfdcodi,
		'NUM_CONTROL',
		'Num_Control',
		17,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30810' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30811' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30811' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30811' ).atfdcodi,
		'PERIODO_CONSUMO',
		'Periodo_Consumo',
		18,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30811' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30812' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30812' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30812' ).atfdcodi,
		'SALDO_FAVOR',
		'Saldo_Favor',
		19,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30812' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30813' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30813' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30813' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		20,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30813' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30814' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30814' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30814' ).atfdcodi,
		'FECHA_SUSPENSION',
		'Fecha_Suspension',
		21,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30814' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30815' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30815' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30815' ).atfdcodi,
		'VALOR_RECL',
		'Valor_Recl',
		22,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30815' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30816' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30816' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30816' ).atfdcodi,
		'TOTAL_FACTURA',
		'Total_Factura',
		23,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30816' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30817' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30817' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30817' ).atfdcodi,
		'PAGO_SIN_RECARGO',
		'Pago_Sin_Recargo',
		24,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30817' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30818' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30818' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30818' ).atfdcodi,
		'CONDICION_PAGO',
		'Condicion_Pago',
		25,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30818' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30819' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30819' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30819' ).atfdcodi,
		'IDENTIFICA',
		'Identifica',
		26,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30819' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30820' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30820' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30820' ).atfdcodi,
		'SERVICIO',
		'Tipo de producto',
		27,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30820' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30821' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3909' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30821' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3909' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30821' ).atfdcodi,
		'VISIBLE',
		'Visible',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30821' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30822' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3909' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30822' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3909' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30822' ).atfdcodi,
		'IMPRESO',
		'Impreso',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30822' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30823' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3909' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30823' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3909' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30823' ).atfdcodi,
		'PROTECCION_ESTADO',
		'Proteccion_Estado',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30823' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30824' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3911' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30824' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3911' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30824' ).atfdcodi,
		'ACUMU',
		'Acumu',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30824' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30825' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3910' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30825' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3910' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30825' ).atfdcodi,
		'DIRECCION_PRODUCTO',
		'Direccion_Producto',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30825' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30826' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3910' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30826' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3910' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30826' ).atfdcodi,
		'CAUSA_DESVIACION',
		'Causa_Desviacion',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30826' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30827' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3910' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30827' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3910' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30827' ).atfdcodi,
		'PAGARE_UNICO',
		'Pagare_Unico',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30827' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30828' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3910' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30828' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3910' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30828' ).atfdcodi,
		'CAMBIOUSO',
		'Cambiouso',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30828' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30829' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3912' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30829' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3912' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30829' ).atfdcodi,
		'FINAESPE',
		'Finaespe',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30829' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30830' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3913' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30830' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3913' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30830' ).atfdcodi,
		'MED_MAL_UBICADO',
		'Med_Mal_Ubicado',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30830' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30831' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3914' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30831' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3914' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30831' ).atfdcodi,
		'IMPRIMEFACT',
		'Imprimefact',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30831' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30832' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3915' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30832' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3915' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30832' ).atfdcodi,
		'VALOR_ULT_PAGO',
		'Valor_Ult_Pago',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30832' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30833' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3915' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30833' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3915' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30833' ).atfdcodi,
		'FECHA_ULT_PAGO',
		'Fecha_Ult_Pago',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30833' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30834' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3916' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30834' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3916' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30834' ).atfdcodi,
		'SALDO_ANTE',
		'Saldo_Ante',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30834' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30835' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3917' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30835' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3917' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Calificacion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_72.tbrcED_AtriFuda( '30835' ).atfdcodi,
		'CALIFICACION',
		'Calificacion',
		1,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30835' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30836' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30836' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30836' ).atfdcodi,
		'ETIQUETA',
		'Etiqueta',
		1,
		'N',
		CONFEXME_72.tbrcED_AtriFuda( '30836' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30837' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30837' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30837' ).atfdcodi,
		'CONCEPTO_ID',
		'Concepto_Id',
		2,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30837' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30838' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30838' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30838' ).atfdcodi,
		'DESC_CONCEP',
		'Desc_Concep',
		3,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30838' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30839' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30839' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30839' ).atfdcodi,
		'SALDO_ANT',
		'Saldo_Ant',
		4,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30839' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30840' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30840' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30840' ).atfdcodi,
		'CAPITAL',
		'Capital',
		5,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30840' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30841' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30841' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30841' ).atfdcodi,
		'INTERES',
		'Interes',
		6,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30841' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30842' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30842' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30842' ).atfdcodi,
		'TOTAL',
		'Total',
		7,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30842' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30843' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30843' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30843' ).atfdcodi,
		'SALDO_DIF',
		'Saldo_Dif',
		8,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30843' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30844' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30844' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30844' ).atfdcodi,
		'UNIDAD_ITEMS',
		'Unidad_Items',
		9,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30844' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30845' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30845' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30845' ).atfdcodi,
		'CANTIDAD',
		'Cantidad',
		10,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30845' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30846' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30846' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30846' ).atfdcodi,
		'VALOR_UNITARIO',
		'Valor_Unitario',
		11,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30846' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30847' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30847' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30847' ).atfdcodi,
		'VALOR_IVA',
		'Valor_Iva',
		12,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30847' ).atfdfuda,
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
	CONFEXME_72.tbrcED_AtriFuda( '30848' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_AtriFuda( '30848' ).atfdfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_AtriFuda( '30848' ).atfdcodi,
		'CUOTAS',
		'Cuotas',
		13,
		'S',
		CONFEXME_72.tbrcED_AtriFuda( '30848' ).atfdfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6785 ).bloqcodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_Bloque( 6785 ).bloqcodi,
		'LDC_DATOS',
		CONFEXME_72.tbrcED_Bloque( 6785 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6785 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6786 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3898' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6786 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3898' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6786 ).bloqcodi,
		'LDC_DATOS_CLIENTE',
		CONFEXME_72.tbrcED_Bloque( 6786 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6786 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6787 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3899' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6787 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3899' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6787 ).bloqcodi,
		'LDC_DATOS_LECTURA',
		CONFEXME_72.tbrcED_Bloque( 6787 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6787 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6788 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3900' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6788 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3900' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6788 ).bloqcodi,
		'LDC_DATOS_CONSUMO',
		CONFEXME_72.tbrcED_Bloque( 6788 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6788 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6789 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3901' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6789 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3901' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6789 ).bloqcodi,
		'LDC_DATOS_REVISION',
		CONFEXME_72.tbrcED_Bloque( 6789 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6789 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6790 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3902' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6790 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3902' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6790 ).bloqcodi,
		'CARGOS',
		CONFEXME_72.tbrcED_Bloque( 6790 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6790 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6791 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3903' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6791 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3903' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6791 ).bloqcodi,
		'LDC_RANGOS',
		CONFEXME_72.tbrcED_Bloque( 6791 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6791 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6792 ).bloqcodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_Bloque( 6792 ).bloqcodi,
		'LDC_BRILLA',
		CONFEXME_72.tbrcED_Bloque( 6792 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6792 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6793 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3904' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6793 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3904' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6793 ).bloqcodi,
		'LDC_COMPCOST',
		CONFEXME_72.tbrcED_Bloque( 6793 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6793 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6794 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3905' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6794 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3905' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6794 ).bloqcodi,
		'LDC_CUPON',
		CONFEXME_72.tbrcED_Bloque( 6794 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6794 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6795 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3906' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6795 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3906' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6795 ).bloqcodi,
		'LDC_TASAS_CAMBIO',
		CONFEXME_72.tbrcED_Bloque( 6795 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6795 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6796 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3907' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6796 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3907' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6796 ).bloqcodi,
		'TOTALES',
		CONFEXME_72.tbrcED_Bloque( 6796 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6796 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6797 ).bloqcodi := nuNextSeqValue;

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
		CONFEXME_72.tbrcED_Bloque( 6797 ).bloqcodi,
		'LDC_ENCABEZADO',
		CONFEXME_72.tbrcED_Bloque( 6797 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6797 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6798 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3908' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6798 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3908' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6798 ).bloqcodi,
		'LDC_DATOS_SPOOL',
		CONFEXME_72.tbrcED_Bloque( 6798 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6798 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6799 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3909' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6799 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3909' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6799 ).bloqcodi,
		'PROTECCION_DATOS',
		CONFEXME_72.tbrcED_Bloque( 6799 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6799 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6800 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3910' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6800 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3910' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6800 ).bloqcodi,
		'DATOS_ADICIONALES',
		CONFEXME_72.tbrcED_Bloque( 6800 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6800 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6801 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3911' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6801 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3911' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6801 ).bloqcodi,
		'LDC_ACUMTATT',
		CONFEXME_72.tbrcED_Bloque( 6801 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6801 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6802 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3912' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6802 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3912' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6802 ).bloqcodi,
		'LDC_FINAESPE',
		CONFEXME_72.tbrcED_Bloque( 6802 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6802 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6803 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3913' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6803 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3913' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6803 ).bloqcodi,
		'LDC_MEDIDOR_MAL_UBIC',
		CONFEXME_72.tbrcED_Bloque( 6803 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6803 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6804 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3914' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6804 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3914' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6804 ).bloqcodi,
		'LDC_IMPRIME_FACTURA',
		CONFEXME_72.tbrcED_Bloque( 6804 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6804 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6805 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3915' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6805 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3915' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6805 ).bloqcodi,
		'LDC_VALOR_FECH_ULTPAGO',
		CONFEXME_72.tbrcED_Bloque( 6805 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6805 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6806 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3916' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6806 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3916' ).fudacodi;
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
		CONFEXME_72.tbrcED_Bloque( 6806 ).bloqcodi,
		'SALDO_ANTERIOR',
		CONFEXME_72.tbrcED_Bloque( 6806 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6806 ).bloqfuda,
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
	CONFEXME_72.tbrcED_Bloque( 6807 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_72.tbrcED_FuenDato.exists( '3917' ) ) then
		CONFEXME_72.tbrcED_Bloque( 6807 ).bloqfuda := CONFEXME_72.tbrcED_FuenDato( '3917' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [INFO_ADICIONAL]', 5 );
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
		CONFEXME_72.tbrcED_Bloque( 6807 ).bloqcodi,
		'INFO_ADICIONAL',
		CONFEXME_72.tbrcED_Bloque( 6807 ).bloqtibl,
		CONFEXME_72.tbrcED_Bloque( 6807 ).bloqfuda,
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
	CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6785 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6785 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6786 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6786 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6787 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6787 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6788 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6788 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6789 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6789 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6790 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6790 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrfrfo,
		43,
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
	CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6791 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6791 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6936' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6936' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6792 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6936' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6792 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6936' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6936' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6936' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6793 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6793 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6794 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6794 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6795 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6795 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6796 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6796 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6797 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6797 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6798 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6798 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6799 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6799 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6800 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6800 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6945' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6945' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6801 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6945' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6801 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6945' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6945' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6945' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6946' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6946' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6802 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6946' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6802 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6946' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6946' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6946' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6947' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6947' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6803 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6947' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6803 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6947' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6947' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6947' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6948' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6948' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6804 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6948' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6804 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6948' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6948' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6948' ).blfrfrfo,
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
	CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6805 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6805 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrfrfo,
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

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_BloqFran( '6950' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6950' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6806 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6950' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6806 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6950' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6950' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6950' ).blfrfrfo,
		42,
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
	CONFEXME_72.tbrcED_BloqFran( '6951' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_72.tbrcED_BloqFran( '6951' ).blfrfrfo := CONFEXME_72.tbrcED_FranForm( '4594' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_72.tbrcED_Bloque.exists( 6807 ) ) then
		CONFEXME_72.tbrcED_BloqFran( '6951' ).blfrbloq := CONFEXME_72.tbrcED_Bloque( 6807 ).bloqcodi;
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
		CONFEXME_72.tbrcED_BloqFran( '6951' ).blfrcodi,
		CONFEXME_72.tbrcED_BloqFran( '6951' ).blfrbloq,
		CONFEXME_72.tbrcED_BloqFran( '6951' ).blfrfrfo,
		44,
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403919' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403919' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403919' ).code );
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403920' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403920' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403920' ).code );
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403921' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403921' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403921' ).code );
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403922' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403922' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403922' ).code );
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403923' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403923' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403923' ).code );
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403924' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403924' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403924' ).code );
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403925' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403925' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403925' ).code );
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
		CONFEXME_72.tbrcGR_Config_Expression( '121403926' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403926' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403926' ).code );
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
	UT_Trace.Trace( 'Generando la expresión [LDC - ENCABEZADO CONCEPTO 5]', 6 );
	GR_BOInterface_Body.GenerateRule
	(
		'sbSessionId = LDC_BOBILLINGPROCESS.FSBGETSESSIONID();sbEncabezadoFlag = UT_STRING.FSBCONCAT("GASCAR", sbSessionId, "-");sbValor = LDC_BOBILLINGPROCESS.FNUGETVALUE(sbEncabezadoFlag);if (sbValor = 5,LDC_BOBILLINGPROCESS.VALUEACCUMULATION(sbEncabezadoFlag,1);sbEncabezado = LDC_DETALLEFACT_GASCARIBE.FSBGETENCABCONC5();,sbEncabezado = null;)',
		49,
		'LDC - ENCABEZADO CONCEPTO 5',
		NULL,
		nuNextSeqValue,
		'PF'
	);

	open CONFEXME_72.cuGR_Config_Expression( nuNextSeqValue );
	fetch CONFEXME_72.cuGR_Config_Expression into rcExpression;
	close CONFEXME_72.cuGR_Config_Expression;

	if ( rcExpression.config_expression_id is NULL ) then
		CONFEXME_72.tbrcGR_Config_Expression( '121403927' ) := CONFEXME_72.rcNullExpression;
	else
		CONFEXME_72.tbrcGR_Config_Expression( '121403927' ) := rcExpression;
		CONFEXME_72.ExecuteSQLSentence( CONFEXME_72.tbrcGR_Config_Expression( '121403927' ).code );
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
	CONFEXME_72.tbrcED_Item( '36149' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36149' ).itemobna := 'GCFIFA_CT49E121403919';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403919' ) ) then
		CONFEXME_72.tbrcED_Item( '36149' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403919' ).object_name;
		CONFEXME_72.tbrcED_Item( '36149' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403919' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36149' ).itemcodi,
		'Genera Ordenes',
		CONFEXME_72.tbrcED_Item( '36149' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36149' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36149' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36149' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36150' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36150' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30739' ) ) then
		CONFEXME_72.tbrcED_Item( '36150' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30739' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36150' ).itemcodi,
		'Num_Medidor',
		CONFEXME_72.tbrcED_Item( '36150' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36150' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36150' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36150' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36151' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36151' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30740' ) ) then
		CONFEXME_72.tbrcED_Item( '36151' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30740' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36151' ).itemcodi,
		'Lectura_Anterior',
		CONFEXME_72.tbrcED_Item( '36151' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36151' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36151' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36151' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36152' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36152' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30741' ) ) then
		CONFEXME_72.tbrcED_Item( '36152' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30741' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36152' ).itemcodi,
		'Lectura_Actual',
		CONFEXME_72.tbrcED_Item( '36152' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36152' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36152' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36152' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36153' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36153' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30742' ) ) then
		CONFEXME_72.tbrcED_Item( '36153' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30742' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36153' ).itemcodi,
		'Obs_Lectura',
		CONFEXME_72.tbrcED_Item( '36153' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36153' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36153' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36153' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36154' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36154' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30743' ) ) then
		CONFEXME_72.tbrcED_Item( '36154' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30743' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36154' ).itemcodi,
		'Lim_Inferior',
		CONFEXME_72.tbrcED_Item( '36154' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36154' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36154' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36154' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36155' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36155' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30744' ) ) then
		CONFEXME_72.tbrcED_Item( '36155' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30744' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36155' ).itemcodi,
		'Lim_Superior',
		CONFEXME_72.tbrcED_Item( '36155' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36155' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36155' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36155' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36156' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36156' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30745' ) ) then
		CONFEXME_72.tbrcED_Item( '36156' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30745' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36156' ).itemcodi,
		'Valor_Unidad',
		CONFEXME_72.tbrcED_Item( '36156' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36156' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36156' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36156' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36157' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36157' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30746' ) ) then
		CONFEXME_72.tbrcED_Item( '36157' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30746' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36157' ).itemcodi,
		'Consumo',
		CONFEXME_72.tbrcED_Item( '36157' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36157' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36157' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36157' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36158' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36158' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30747' ) ) then
		CONFEXME_72.tbrcED_Item( '36158' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30747' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36158' ).itemcodi,
		'Val_Consumo',
		CONFEXME_72.tbrcED_Item( '36158' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36158' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36158' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36158' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36159' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36159' ).itemobna := 'GCFIFA_CT49E121403920';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403920' ) ) then
		CONFEXME_72.tbrcED_Item( '36159' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403920' ).object_name;
		CONFEXME_72.tbrcED_Item( '36159' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403920' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36159' ).itemcodi,
		'CUPO_BRILLA',
		CONFEXME_72.tbrcED_Item( '36159' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36159' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36159' ).itemgren,
		NULL,
		NULL,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36159' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36160' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36160' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30748' ) ) then
		CONFEXME_72.tbrcED_Item( '36160' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30748' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36160' ).itemcodi,
		'Compcost',
		CONFEXME_72.tbrcED_Item( '36160' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36160' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36160' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36160' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36161' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36161' ).itemobna := NULL;

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
		CONFEXME_72.tbrcED_Item( '36161' ).itemcodi,
		'ValoresRef',
		CONFEXME_72.tbrcED_Item( '36161' ).itemceid,
		'DES(h)=0 IPLI=100% IO=100% IRST=NO APLICA',
		CONFEXME_72.tbrcED_Item( '36161' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36161' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36161' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36162' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36162' ).itemobna := NULL;

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
		CONFEXME_72.tbrcED_Item( '36162' ).itemcodi,
		'ValCalc',
		CONFEXME_72.tbrcED_Item( '36162' ).itemceid,
		'DES(h)=0 COMPENSACION($)=0',
		CONFEXME_72.tbrcED_Item( '36162' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36162' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36162' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36163' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36163' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30749' ) ) then
		CONFEXME_72.tbrcED_Item( '36163' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30749' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36163' ).itemcodi,
		'Codigo_1',
		CONFEXME_72.tbrcED_Item( '36163' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36163' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36163' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36163' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36164' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36164' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30750' ) ) then
		CONFEXME_72.tbrcED_Item( '36164' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30750' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36164' ).itemcodi,
		'Codigo_2',
		CONFEXME_72.tbrcED_Item( '36164' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36164' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36164' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36164' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36165' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36165' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30751' ) ) then
		CONFEXME_72.tbrcED_Item( '36165' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30751' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36165' ).itemcodi,
		'Codigo_3',
		CONFEXME_72.tbrcED_Item( '36165' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36165' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36165' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36165' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36166' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36166' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30752' ) ) then
		CONFEXME_72.tbrcED_Item( '36166' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30752' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36166' ).itemcodi,
		'Codigo_4',
		CONFEXME_72.tbrcED_Item( '36166' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36166' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36166' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36166' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36167' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36167' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30753' ) ) then
		CONFEXME_72.tbrcED_Item( '36167' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30753' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36167' ).itemcodi,
		'Codigo_Barras',
		CONFEXME_72.tbrcED_Item( '36167' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36167' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36167' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36167' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36168' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36168' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30754' ) ) then
		CONFEXME_72.tbrcED_Item( '36168' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30754' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36168' ).itemcodi,
		'Tipo_Noti',
		CONFEXME_72.tbrcED_Item( '36168' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36168' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36168' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36168' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36169' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36169' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30755' ) ) then
		CONFEXME_72.tbrcED_Item( '36169' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30755' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36169' ).itemcodi,
		'Mens_Noti',
		CONFEXME_72.tbrcED_Item( '36169' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36169' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36169' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36169' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36170' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36170' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30756' ) ) then
		CONFEXME_72.tbrcED_Item( '36170' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30756' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36170' ).itemcodi,
		'Fech_Maxima',
		CONFEXME_72.tbrcED_Item( '36170' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36170' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36170' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36170' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36171' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36171' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30757' ) ) then
		CONFEXME_72.tbrcED_Item( '36171' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30757' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36171' ).itemcodi,
		'Fech_Susp',
		CONFEXME_72.tbrcED_Item( '36171' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36171' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36171' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36171' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36172' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36172' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30758' ) ) then
		CONFEXME_72.tbrcED_Item( '36172' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30758' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36172' ).itemcodi,
		'Tasa_Ultima',
		CONFEXME_72.tbrcED_Item( '36172' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36172' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36172' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36172' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36173' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36173' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30759' ) ) then
		CONFEXME_72.tbrcED_Item( '36173' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30759' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36173' ).itemcodi,
		'Tasa_Promedio',
		CONFEXME_72.tbrcED_Item( '36173' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36173' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36173' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36173' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36174' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36174' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30760' ) ) then
		CONFEXME_72.tbrcED_Item( '36174' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30760' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36174' ).itemcodi,
		'Cons_Correg',
		CONFEXME_72.tbrcED_Item( '36174' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36174' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36174' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36174' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36175' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36175' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30761' ) ) then
		CONFEXME_72.tbrcED_Item( '36175' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30761' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36175' ).itemcodi,
		'Factor_Correccion',
		CONFEXME_72.tbrcED_Item( '36175' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36175' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36175' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36175' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36176' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36176' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30762' ) ) then
		CONFEXME_72.tbrcED_Item( '36176' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30762' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36176' ).itemcodi,
		'Consumo_Mes_1',
		CONFEXME_72.tbrcED_Item( '36176' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36176' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36176' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36176' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36177' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36177' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30763' ) ) then
		CONFEXME_72.tbrcED_Item( '36177' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30763' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36177' ).itemcodi,
		'Fecha_Cons_Mes_1',
		CONFEXME_72.tbrcED_Item( '36177' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36177' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36177' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36177' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36178' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36178' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30764' ) ) then
		CONFEXME_72.tbrcED_Item( '36178' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30764' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36178' ).itemcodi,
		'Consumo_Mes_2',
		CONFEXME_72.tbrcED_Item( '36178' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36178' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36178' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36178' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36179' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36179' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30765' ) ) then
		CONFEXME_72.tbrcED_Item( '36179' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30765' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36179' ).itemcodi,
		'Fecha_Cons_Mes_2',
		CONFEXME_72.tbrcED_Item( '36179' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36179' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36179' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36179' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36180' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36180' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30766' ) ) then
		CONFEXME_72.tbrcED_Item( '36180' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30766' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36180' ).itemcodi,
		'Consumo_Mes_3',
		CONFEXME_72.tbrcED_Item( '36180' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36180' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36180' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36180' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36181' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36181' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30767' ) ) then
		CONFEXME_72.tbrcED_Item( '36181' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30767' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36181' ).itemcodi,
		'Fecha_Cons_Mes_3',
		CONFEXME_72.tbrcED_Item( '36181' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36181' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36181' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36181' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36182' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36182' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30768' ) ) then
		CONFEXME_72.tbrcED_Item( '36182' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30768' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36182' ).itemcodi,
		'Consumo_Mes_4',
		CONFEXME_72.tbrcED_Item( '36182' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36182' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36182' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36182' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36183' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36183' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30769' ) ) then
		CONFEXME_72.tbrcED_Item( '36183' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30769' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36183' ).itemcodi,
		'Fecha_Cons_Mes_4',
		CONFEXME_72.tbrcED_Item( '36183' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36183' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36183' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36183' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36184' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36184' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30770' ) ) then
		CONFEXME_72.tbrcED_Item( '36184' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30770' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36184' ).itemcodi,
		'Consumo_Mes_5',
		CONFEXME_72.tbrcED_Item( '36184' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36184' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36184' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36184' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36185' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36185' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30771' ) ) then
		CONFEXME_72.tbrcED_Item( '36185' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30771' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36185' ).itemcodi,
		'Fecha_Cons_Mes_5',
		CONFEXME_72.tbrcED_Item( '36185' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36185' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36185' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36185' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36186' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36186' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30772' ) ) then
		CONFEXME_72.tbrcED_Item( '36186' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30772' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36186' ).itemcodi,
		'Consumo_Mes_6',
		CONFEXME_72.tbrcED_Item( '36186' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36186' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36186' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36186' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36187' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36187' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30773' ) ) then
		CONFEXME_72.tbrcED_Item( '36187' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30773' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36187' ).itemcodi,
		'Fecha_Cons_Mes_6',
		CONFEXME_72.tbrcED_Item( '36187' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36187' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36187' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36187' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36188' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36188' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30774' ) ) then
		CONFEXME_72.tbrcED_Item( '36188' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30774' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36188' ).itemcodi,
		'Consumo_Promedio',
		CONFEXME_72.tbrcED_Item( '36188' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36188' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36188' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36188' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36189' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36189' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30775' ) ) then
		CONFEXME_72.tbrcED_Item( '36189' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30775' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36189' ).itemcodi,
		'Temperatura',
		CONFEXME_72.tbrcED_Item( '36189' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36189' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36189' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36189' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36190' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36190' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30776' ) ) then
		CONFEXME_72.tbrcED_Item( '36190' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30776' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36190' ).itemcodi,
		'Presion',
		CONFEXME_72.tbrcED_Item( '36190' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36190' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36190' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36190' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36191' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36191' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30777' ) ) then
		CONFEXME_72.tbrcED_Item( '36191' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30777' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36191' ).itemcodi,
		'Equival_Kwh',
		CONFEXME_72.tbrcED_Item( '36191' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36191' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36191' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36191' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36192' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36192' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30778' ) ) then
		CONFEXME_72.tbrcED_Item( '36192' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30778' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36192' ).itemcodi,
		'Calculo_Cons',
		CONFEXME_72.tbrcED_Item( '36192' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36192' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36192' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36192' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36200' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36200' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30787' ) ) then
		CONFEXME_72.tbrcED_Item( '36200' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30787' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36200' ).itemcodi,
		'Total',
		CONFEXME_72.tbrcED_Item( '36200' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36200' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36200' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36200' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36201' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36201' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30788' ) ) then
		CONFEXME_72.tbrcED_Item( '36201' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30788' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36201' ).itemcodi,
		'Iva',
		CONFEXME_72.tbrcED_Item( '36201' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36201' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36201' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36201' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36202' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36202' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30789' ) ) then
		CONFEXME_72.tbrcED_Item( '36202' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30789' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36202' ).itemcodi,
		'Subtotal',
		CONFEXME_72.tbrcED_Item( '36202' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36202' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36202' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36202' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36203' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36203' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30790' ) ) then
		CONFEXME_72.tbrcED_Item( '36203' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30790' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36203' ).itemcodi,
		'Cargosmes',
		CONFEXME_72.tbrcED_Item( '36203' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36203' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36203' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36203' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36204' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36204' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30791' ) ) then
		CONFEXME_72.tbrcED_Item( '36204' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30791' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36204' ).itemcodi,
		'Cantidad_Conc',
		CONFEXME_72.tbrcED_Item( '36204' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36204' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36204' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36204' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36205' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36205' ).itemobna := 'GCFIFA_CT49E121403921';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403921' ) ) then
		CONFEXME_72.tbrcED_Item( '36205' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403921' ).object_name;
		CONFEXME_72.tbrcED_Item( '36205' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403921' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36205' ).itemcodi,
		'NUMERO_FACT',
		CONFEXME_72.tbrcED_Item( '36205' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36205' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36205' ).itemgren,
		NULL,
		NULL,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36205' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36206' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36206' ).itemobna := 'GCFIFA_CT49E121403922';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403922' ) ) then
		CONFEXME_72.tbrcED_Item( '36206' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403922' ).object_name;
		CONFEXME_72.tbrcED_Item( '36206' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403922' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36206' ).itemcodi,
		'ENCABEZADO',
		CONFEXME_72.tbrcED_Item( '36206' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36206' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36206' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36206' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36207' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36207' ).itemobna := 'GCFIFA_CT49E121403923';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403923' ) ) then
		CONFEXME_72.tbrcED_Item( '36207' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403923' ).object_name;
		CONFEXME_72.tbrcED_Item( '36207' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403923' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36207' ).itemcodi,
		'ENCCONC1',
		CONFEXME_72.tbrcED_Item( '36207' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36207' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36207' ).itemgren,
		NULL,
		1,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36207' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36208' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36208' ).itemobna := 'GCFIFA_CT49E121403924';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403924' ) ) then
		CONFEXME_72.tbrcED_Item( '36208' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403924' ).object_name;
		CONFEXME_72.tbrcED_Item( '36208' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403924' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36208' ).itemcodi,
		'ENCCONC2',
		CONFEXME_72.tbrcED_Item( '36208' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36208' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36208' ).itemgren,
		NULL,
		1,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36208' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36209' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36209' ).itemobna := 'GCFIFA_CT49E121403925';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403925' ) ) then
		CONFEXME_72.tbrcED_Item( '36209' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403925' ).object_name;
		CONFEXME_72.tbrcED_Item( '36209' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403925' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36209' ).itemcodi,
		'ENCCONC3',
		CONFEXME_72.tbrcED_Item( '36209' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36209' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36209' ).itemgren,
		NULL,
		1,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36209' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36210' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36210' ).itemobna := 'GCFIFA_CT49E121403926';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403926' ) ) then
		CONFEXME_72.tbrcED_Item( '36210' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403926' ).object_name;
		CONFEXME_72.tbrcED_Item( '36210' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403926' ).config_expression_id;
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
		CONFEXME_72.tbrcED_Item( '36210' ).itemcodi,
		'ENCCONC4',
		CONFEXME_72.tbrcED_Item( '36210' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36210' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36210' ).itemgren,
		NULL,
		1,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36210' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36211' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36211' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30792' ) ) then
		CONFEXME_72.tbrcED_Item( '36211' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30792' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36211' ).itemcodi,
		'Cuadrilla_Reparto',
		CONFEXME_72.tbrcED_Item( '36211' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36211' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36211' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36211' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36212' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36212' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30793' ) ) then
		CONFEXME_72.tbrcED_Item( '36212' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30793' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36212' ).itemcodi,
		'Observ_No_Lect_Consec',
		CONFEXME_72.tbrcED_Item( '36212' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36212' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36212' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36212' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36213' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36213' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30794' ) ) then
		CONFEXME_72.tbrcED_Item( '36213' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30794' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36213' ).itemcodi,
		'Factura',
		CONFEXME_72.tbrcED_Item( '36213' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36213' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36213' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36213' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36214' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36214' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30795' ) ) then
		CONFEXME_72.tbrcED_Item( '36214' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30795' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36214' ).itemcodi,
		'Fech_Fact',
		CONFEXME_72.tbrcED_Item( '36214' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36214' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36214' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36214' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36215' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36215' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30796' ) ) then
		CONFEXME_72.tbrcED_Item( '36215' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30796' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36215' ).itemcodi,
		'Mes_Fact',
		CONFEXME_72.tbrcED_Item( '36215' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36215' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36215' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36215' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36216' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36216' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30797' ) ) then
		CONFEXME_72.tbrcED_Item( '36216' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30797' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36216' ).itemcodi,
		'Periodo_Fact',
		CONFEXME_72.tbrcED_Item( '36216' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36216' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36216' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36216' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36217' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36217' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30798' ) ) then
		CONFEXME_72.tbrcED_Item( '36217' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30798' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36217' ).itemcodi,
		'Pago_Hasta',
		CONFEXME_72.tbrcED_Item( '36217' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36217' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36217' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36217' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36218' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36218' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30799' ) ) then
		CONFEXME_72.tbrcED_Item( '36218' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30799' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36218' ).itemcodi,
		'Dias_Consumo',
		CONFEXME_72.tbrcED_Item( '36218' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36218' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36218' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36218' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36219' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36219' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30800' ) ) then
		CONFEXME_72.tbrcED_Item( '36219' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30800' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36219' ).itemcodi,
		'Contrato',
		CONFEXME_72.tbrcED_Item( '36219' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36219' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36219' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36219' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36220' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36220' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30801' ) ) then
		CONFEXME_72.tbrcED_Item( '36220' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30801' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36220' ).itemcodi,
		'Cupon',
		CONFEXME_72.tbrcED_Item( '36220' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36220' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36220' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36220' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36221' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36221' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30802' ) ) then
		CONFEXME_72.tbrcED_Item( '36221' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30802' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36221' ).itemcodi,
		'Nombre',
		CONFEXME_72.tbrcED_Item( '36221' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36221' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36221' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36221' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36222' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36222' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30803' ) ) then
		CONFEXME_72.tbrcED_Item( '36222' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30803' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36222' ).itemcodi,
		'Direccion_Cobro',
		CONFEXME_72.tbrcED_Item( '36222' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36222' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36222' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36222' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36223' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36223' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30804' ) ) then
		CONFEXME_72.tbrcED_Item( '36223' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30804' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36223' ).itemcodi,
		'Localidad',
		CONFEXME_72.tbrcED_Item( '36223' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36223' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36223' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36223' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36224' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36224' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30805' ) ) then
		CONFEXME_72.tbrcED_Item( '36224' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30805' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36224' ).itemcodi,
		'Categoria',
		CONFEXME_72.tbrcED_Item( '36224' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36224' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36224' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36224' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36225' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36225' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30806' ) ) then
		CONFEXME_72.tbrcED_Item( '36225' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30806' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36225' ).itemcodi,
		'Estrato',
		CONFEXME_72.tbrcED_Item( '36225' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36225' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36225' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36225' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36226' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36226' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30807' ) ) then
		CONFEXME_72.tbrcED_Item( '36226' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30807' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36226' ).itemcodi,
		'Ciclo',
		CONFEXME_72.tbrcED_Item( '36226' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36226' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36226' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36226' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36227' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36227' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30808' ) ) then
		CONFEXME_72.tbrcED_Item( '36227' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30808' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36227' ).itemcodi,
		'Ruta',
		CONFEXME_72.tbrcED_Item( '36227' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36227' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36227' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36227' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36228' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36228' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30809' ) ) then
		CONFEXME_72.tbrcED_Item( '36228' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30809' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36228' ).itemcodi,
		'Meses_Deuda',
		CONFEXME_72.tbrcED_Item( '36228' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36228' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36228' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36228' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36229' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36229' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30810' ) ) then
		CONFEXME_72.tbrcED_Item( '36229' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30810' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36229' ).itemcodi,
		'Num_Control',
		CONFEXME_72.tbrcED_Item( '36229' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36229' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36229' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36229' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36230' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36230' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30811' ) ) then
		CONFEXME_72.tbrcED_Item( '36230' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30811' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36230' ).itemcodi,
		'Periodo_Consumo',
		CONFEXME_72.tbrcED_Item( '36230' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36230' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36230' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36230' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36231' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36231' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30812' ) ) then
		CONFEXME_72.tbrcED_Item( '36231' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30812' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36231' ).itemcodi,
		'Saldo_Favor',
		CONFEXME_72.tbrcED_Item( '36231' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36231' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36231' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36231' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36232' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36232' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30813' ) ) then
		CONFEXME_72.tbrcED_Item( '36232' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30813' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36232' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_72.tbrcED_Item( '36232' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36232' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36232' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36232' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36233' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36233' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30814' ) ) then
		CONFEXME_72.tbrcED_Item( '36233' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30814' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36233' ).itemcodi,
		'Fecha_Suspension',
		CONFEXME_72.tbrcED_Item( '36233' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36233' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36233' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36233' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36234' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36234' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30815' ) ) then
		CONFEXME_72.tbrcED_Item( '36234' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30815' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36234' ).itemcodi,
		'Valor_Recl',
		CONFEXME_72.tbrcED_Item( '36234' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36234' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36234' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36234' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36235' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36235' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30816' ) ) then
		CONFEXME_72.tbrcED_Item( '36235' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30816' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36235' ).itemcodi,
		'Total_Factura',
		CONFEXME_72.tbrcED_Item( '36235' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36235' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36235' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36235' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36236' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36236' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30817' ) ) then
		CONFEXME_72.tbrcED_Item( '36236' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30817' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36236' ).itemcodi,
		'Pago_Sin_Recargo',
		CONFEXME_72.tbrcED_Item( '36236' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36236' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36236' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36236' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36237' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36237' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30818' ) ) then
		CONFEXME_72.tbrcED_Item( '36237' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30818' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36237' ).itemcodi,
		'Condicion_Pago',
		CONFEXME_72.tbrcED_Item( '36237' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36237' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36237' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36237' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36238' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36238' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30819' ) ) then
		CONFEXME_72.tbrcED_Item( '36238' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30819' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36238' ).itemcodi,
		'Identifica',
		CONFEXME_72.tbrcED_Item( '36238' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36238' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36238' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36238' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36239' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36239' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30820' ) ) then
		CONFEXME_72.tbrcED_Item( '36239' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30820' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36239' ).itemcodi,
		'Tipo de producto',
		CONFEXME_72.tbrcED_Item( '36239' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36239' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36239' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36239' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36240' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36240' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30821' ) ) then
		CONFEXME_72.tbrcED_Item( '36240' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30821' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36240' ).itemcodi,
		'Visible',
		CONFEXME_72.tbrcED_Item( '36240' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36240' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36240' ).itemgren,
		NULL,
		2,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36240' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36241' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36241' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30822' ) ) then
		CONFEXME_72.tbrcED_Item( '36241' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30822' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36241' ).itemcodi,
		'Impreso',
		CONFEXME_72.tbrcED_Item( '36241' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36241' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36241' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36241' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36242' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36242' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30823' ) ) then
		CONFEXME_72.tbrcED_Item( '36242' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30823' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36242' ).itemcodi,
		'Proteccion_Estado',
		CONFEXME_72.tbrcED_Item( '36242' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36242' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36242' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36242' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36243' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36243' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30824' ) ) then
		CONFEXME_72.tbrcED_Item( '36243' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30824' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36243' ).itemcodi,
		'Acumu',
		CONFEXME_72.tbrcED_Item( '36243' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36243' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36243' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36243' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36244' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36244' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30825' ) ) then
		CONFEXME_72.tbrcED_Item( '36244' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30825' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36244' ).itemcodi,
		'Direccion_Producto',
		CONFEXME_72.tbrcED_Item( '36244' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36244' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36244' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36244' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36245' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36245' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30826' ) ) then
		CONFEXME_72.tbrcED_Item( '36245' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30826' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36245' ).itemcodi,
		'Causa_Desviacion',
		CONFEXME_72.tbrcED_Item( '36245' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36245' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36245' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36245' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36246' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36246' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30827' ) ) then
		CONFEXME_72.tbrcED_Item( '36246' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30827' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36246' ).itemcodi,
		'Pagare_Unico',
		CONFEXME_72.tbrcED_Item( '36246' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36246' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36246' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36246' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36247' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36247' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30828' ) ) then
		CONFEXME_72.tbrcED_Item( '36247' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30828' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36247' ).itemcodi,
		'Cambiouso',
		CONFEXME_72.tbrcED_Item( '36247' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36247' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36247' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36247' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36248' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36248' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30829' ) ) then
		CONFEXME_72.tbrcED_Item( '36248' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30829' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36248' ).itemcodi,
		'Finaespe',
		CONFEXME_72.tbrcED_Item( '36248' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36248' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36248' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36248' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36249' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36249' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30830' ) ) then
		CONFEXME_72.tbrcED_Item( '36249' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30830' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36249' ).itemcodi,
		'Med_Mal_Ubicado',
		CONFEXME_72.tbrcED_Item( '36249' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36249' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36249' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36249' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36250' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36250' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30831' ) ) then
		CONFEXME_72.tbrcED_Item( '36250' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30831' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36250' ).itemcodi,
		'Imprimefact',
		CONFEXME_72.tbrcED_Item( '36250' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36250' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36250' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36250' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36251' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36251' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30832' ) ) then
		CONFEXME_72.tbrcED_Item( '36251' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30832' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36251' ).itemcodi,
		'Valor_Ult_Pago',
		CONFEXME_72.tbrcED_Item( '36251' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36251' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36251' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36251' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36252' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36252' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30833' ) ) then
		CONFEXME_72.tbrcED_Item( '36252' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30833' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36252' ).itemcodi,
		'Fecha_Ult_Pago',
		CONFEXME_72.tbrcED_Item( '36252' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36252' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36252' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36252' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36253' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36253' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30834' ) ) then
		CONFEXME_72.tbrcED_Item( '36253' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30834' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36253' ).itemcodi,
		'Saldo_Ante',
		CONFEXME_72.tbrcED_Item( '36253' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36253' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36253' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36253' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36254' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36254' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30835' ) ) then
		CONFEXME_72.tbrcED_Item( '36254' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30835' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Calificacion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '36254' ).itemcodi,
		'Calificacion',
		CONFEXME_72.tbrcED_Item( '36254' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36254' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36254' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36254' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36261' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36261' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30837' ) ) then
		CONFEXME_72.tbrcED_Item( '36261' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30837' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36261' ).itemcodi,
		'Concepto_Id',
		CONFEXME_72.tbrcED_Item( '36261' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36261' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36261' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36261' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36262' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36262' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30838' ) ) then
		CONFEXME_72.tbrcED_Item( '36262' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30838' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36262' ).itemcodi,
		'Desc_Concep',
		CONFEXME_72.tbrcED_Item( '36262' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36262' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36262' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36262' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36263' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36263' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30839' ) ) then
		CONFEXME_72.tbrcED_Item( '36263' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30839' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36263' ).itemcodi,
		'Saldo_Ant',
		CONFEXME_72.tbrcED_Item( '36263' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36263' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36263' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36263' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36264' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36264' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30840' ) ) then
		CONFEXME_72.tbrcED_Item( '36264' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30840' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36264' ).itemcodi,
		'Capital',
		CONFEXME_72.tbrcED_Item( '36264' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36264' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36264' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36264' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36265' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36265' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30841' ) ) then
		CONFEXME_72.tbrcED_Item( '36265' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30841' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36265' ).itemcodi,
		'Interes',
		CONFEXME_72.tbrcED_Item( '36265' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36265' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36265' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36265' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36266' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36266' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30842' ) ) then
		CONFEXME_72.tbrcED_Item( '36266' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30842' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36266' ).itemcodi,
		'Total',
		CONFEXME_72.tbrcED_Item( '36266' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36266' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36266' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36266' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36267' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36267' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30843' ) ) then
		CONFEXME_72.tbrcED_Item( '36267' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30843' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36267' ).itemcodi,
		'Saldo_Dif',
		CONFEXME_72.tbrcED_Item( '36267' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36267' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36267' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36267' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36268' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36268' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30844' ) ) then
		CONFEXME_72.tbrcED_Item( '36268' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30844' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36268' ).itemcodi,
		'Unidad_Items',
		CONFEXME_72.tbrcED_Item( '36268' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36268' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36268' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36268' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36269' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36269' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30845' ) ) then
		CONFEXME_72.tbrcED_Item( '36269' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30845' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36269' ).itemcodi,
		'Cantidad',
		CONFEXME_72.tbrcED_Item( '36269' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36269' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36269' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36269' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36270' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36270' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30846' ) ) then
		CONFEXME_72.tbrcED_Item( '36270' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30846' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36270' ).itemcodi,
		'Valor_Unitario',
		CONFEXME_72.tbrcED_Item( '36270' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36270' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36270' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36270' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36271' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36271' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30847' ) ) then
		CONFEXME_72.tbrcED_Item( '36271' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30847' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36271' ).itemcodi,
		'Valor_Iva',
		CONFEXME_72.tbrcED_Item( '36271' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36271' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36271' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36271' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36272' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36272' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_72.tbrcED_AtriFuda.exists( '30848' ) ) then
		CONFEXME_72.tbrcED_Item( '36272' ).itematfd := CONFEXME_72.tbrcED_AtriFuda( '30848' ).atfdcodi;
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
		CONFEXME_72.tbrcED_Item( '36272' ).itemcodi,
		'Cuotas',
		CONFEXME_72.tbrcED_Item( '36272' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36272' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36272' ).itemgren,
		NULL,
		1,
		NULL,
		'|',
		CONFEXME_72.tbrcED_Item( '36272' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_72.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
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
	CONFEXME_72.tbrcED_Item( '36294' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_72.tbrcED_Item( '36294' ).itemobna := 'GCFIFA_CT49E121403927';

	-- Se asigna la expresión del item
	if ( CONFEXME_72.tbrcGR_Config_Expression.exists( '121403927' ) ) then
		CONFEXME_72.tbrcED_Item( '36294' ).itemobna := CONFEXME_72.tbrcGR_Config_Expression( '121403927' ).object_name;
		CONFEXME_72.tbrcED_Item( '36294' ).itemceid := CONFEXME_72.tbrcGR_Config_Expression( '121403927' ).config_expression_id;
	end if;

	UT_Trace.Trace( 'Insertando Item [ENCCONC5]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_72.tbrcED_Item( '36294' ).itemcodi,
		'ENCCONC5',
		CONFEXME_72.tbrcED_Item( '36294' ).itemceid,
		NULL,
		CONFEXME_72.tbrcED_Item( '36294' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36294' ).itemgren,
		NULL,
		NULL,
		NULL,
		NULL,
		CONFEXME_72.tbrcED_Item( '36294' ).itematfd
	);

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
	CONFEXME_72.tbrcED_ItemBloq( '36124' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36124' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36149' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36124' ).itblitem := CONFEXME_72.tbrcED_Item( '36149' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36124' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36124' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36124' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36125' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36125' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36150' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36125' ).itblitem := CONFEXME_72.tbrcED_Item( '36150' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36125' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36125' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36125' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36126' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36126' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36151' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36126' ).itblitem := CONFEXME_72.tbrcED_Item( '36151' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36126' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36126' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36126' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36127' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36127' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36152' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36127' ).itblitem := CONFEXME_72.tbrcED_Item( '36152' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36127' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36127' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36127' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36128' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36128' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6931' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36153' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36128' ).itblitem := CONFEXME_72.tbrcED_Item( '36153' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36128' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36128' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36128' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36129' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36129' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36154' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36129' ).itblitem := CONFEXME_72.tbrcED_Item( '36154' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36129' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36129' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36129' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36130' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36130' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36155' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36130' ).itblitem := CONFEXME_72.tbrcED_Item( '36155' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36130' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36130' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36130' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36131' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36131' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36156' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36131' ).itblitem := CONFEXME_72.tbrcED_Item( '36156' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36131' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36131' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36131' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36132' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36132' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36157' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36132' ).itblitem := CONFEXME_72.tbrcED_Item( '36157' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36132' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36132' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36132' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36133' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36133' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6935' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36158' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36133' ).itblitem := CONFEXME_72.tbrcED_Item( '36158' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36133' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36133' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36133' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36134' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36134' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6936' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36159' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36134' ).itblitem := CONFEXME_72.tbrcED_Item( '36159' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36134' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36134' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36134' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36135' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36135' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36160' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36135' ).itblitem := CONFEXME_72.tbrcED_Item( '36160' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36135' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36135' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36135' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36136' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36136' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36161' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36136' ).itblitem := CONFEXME_72.tbrcED_Item( '36161' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36136' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36136' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36136' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36137' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36137' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6937' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36162' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36137' ).itblitem := CONFEXME_72.tbrcED_Item( '36162' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36137' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36137' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36137' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36138' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36138' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36163' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36138' ).itblitem := CONFEXME_72.tbrcED_Item( '36163' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36138' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36138' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36138' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36139' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36139' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36164' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36139' ).itblitem := CONFEXME_72.tbrcED_Item( '36164' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36139' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36139' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36139' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36140' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36140' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36165' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36140' ).itblitem := CONFEXME_72.tbrcED_Item( '36165' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36140' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36140' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36140' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36141' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36141' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36166' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36141' ).itblitem := CONFEXME_72.tbrcED_Item( '36166' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36141' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36141' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36141' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36142' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36142' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6938' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36167' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36142' ).itblitem := CONFEXME_72.tbrcED_Item( '36167' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36142' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36142' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36142' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36143' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36143' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36168' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36143' ).itblitem := CONFEXME_72.tbrcED_Item( '36168' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36143' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36143' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36143' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36144' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36144' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36169' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36144' ).itblitem := CONFEXME_72.tbrcED_Item( '36169' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36144' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36144' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36144' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36145' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36145' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36170' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36145' ).itblitem := CONFEXME_72.tbrcED_Item( '36170' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36145' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36145' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36145' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36146' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36146' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6933' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36171' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36146' ).itblitem := CONFEXME_72.tbrcED_Item( '36171' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36146' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36146' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36146' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36147' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36147' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36172' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36147' ).itblitem := CONFEXME_72.tbrcED_Item( '36172' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36147' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36147' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36147' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36148' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36148' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6939' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36173' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36148' ).itblitem := CONFEXME_72.tbrcED_Item( '36173' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36148' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36148' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36148' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36149' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36149' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36174' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36149' ).itblitem := CONFEXME_72.tbrcED_Item( '36174' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36149' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36149' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36149' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36150' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36150' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36175' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36150' ).itblitem := CONFEXME_72.tbrcED_Item( '36175' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36150' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36150' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36150' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36151' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36151' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36176' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36151' ).itblitem := CONFEXME_72.tbrcED_Item( '36176' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36151' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36151' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36151' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36152' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36152' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36177' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36152' ).itblitem := CONFEXME_72.tbrcED_Item( '36177' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36152' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36152' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36152' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36153' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36153' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36178' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36153' ).itblitem := CONFEXME_72.tbrcED_Item( '36178' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36153' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36153' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36153' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36154' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36154' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36179' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36154' ).itblitem := CONFEXME_72.tbrcED_Item( '36179' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36154' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36154' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36154' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36155' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36155' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36180' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36155' ).itblitem := CONFEXME_72.tbrcED_Item( '36180' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36155' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36155' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36155' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36156' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36156' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36181' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36156' ).itblitem := CONFEXME_72.tbrcED_Item( '36181' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36156' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36156' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36156' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36157' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36157' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36182' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36157' ).itblitem := CONFEXME_72.tbrcED_Item( '36182' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36157' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36157' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36157' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36158' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36158' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36183' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36158' ).itblitem := CONFEXME_72.tbrcED_Item( '36183' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36158' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36158' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36158' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36159' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36159' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36184' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36159' ).itblitem := CONFEXME_72.tbrcED_Item( '36184' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36159' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36159' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36159' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36160' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36160' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36185' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36160' ).itblitem := CONFEXME_72.tbrcED_Item( '36185' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36160' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36160' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36160' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36161' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36161' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36186' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36161' ).itblitem := CONFEXME_72.tbrcED_Item( '36186' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36161' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36161' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36161' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36162' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36162' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36187' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36162' ).itblitem := CONFEXME_72.tbrcED_Item( '36187' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36162' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36162' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36162' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36163' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36163' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36188' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36163' ).itblitem := CONFEXME_72.tbrcED_Item( '36188' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36163' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36163' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36163' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36164' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36164' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36189' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36164' ).itblitem := CONFEXME_72.tbrcED_Item( '36189' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36164' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36164' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36164' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36165' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36165' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36190' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36165' ).itblitem := CONFEXME_72.tbrcED_Item( '36190' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36165' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36165' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36165' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36166' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36166' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36191' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36166' ).itblitem := CONFEXME_72.tbrcED_Item( '36191' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36166' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36166' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36166' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36167' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36167' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6932' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36192' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36167' ).itblitem := CONFEXME_72.tbrcED_Item( '36192' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36167' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36167' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36167' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36175' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36175' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36200' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36175' ).itblitem := CONFEXME_72.tbrcED_Item( '36200' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36175' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36175' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36175' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36176' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36176' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36201' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36176' ).itblitem := CONFEXME_72.tbrcED_Item( '36201' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36176' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36176' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36176' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36177' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36177' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36202' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36177' ).itblitem := CONFEXME_72.tbrcED_Item( '36202' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36177' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36177' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36177' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36178' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36178' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36203' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36178' ).itblitem := CONFEXME_72.tbrcED_Item( '36203' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36178' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36178' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36178' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36179' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36179' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6940' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36204' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36179' ).itblitem := CONFEXME_72.tbrcED_Item( '36204' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36179' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36179' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36179' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36180' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36180' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6929' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36205' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36180' ).itblitem := CONFEXME_72.tbrcED_Item( '36205' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36180' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36180' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36180' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36181' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36181' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36206' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36181' ).itblitem := CONFEXME_72.tbrcED_Item( '36206' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36181' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36181' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36181' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36182' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36182' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36207' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36182' ).itblitem := CONFEXME_72.tbrcED_Item( '36207' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36182' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36182' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36182' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36183' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36183' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36208' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36183' ).itblitem := CONFEXME_72.tbrcED_Item( '36208' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36183' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36183' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36183' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36184' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36184' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36209' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36184' ).itblitem := CONFEXME_72.tbrcED_Item( '36209' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36184' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36184' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36184' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36185' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36185' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36210' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36185' ).itblitem := CONFEXME_72.tbrcED_Item( '36210' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36185' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36185' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36185' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36186' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36186' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36211' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36186' ).itblitem := CONFEXME_72.tbrcED_Item( '36211' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36186' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36186' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36186' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36187' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36187' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6942' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36212' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36187' ).itblitem := CONFEXME_72.tbrcED_Item( '36212' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36187' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36187' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36187' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36188' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36188' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36213' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36188' ).itblitem := CONFEXME_72.tbrcED_Item( '36213' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36188' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36188' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36188' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36189' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36189' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36214' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36189' ).itblitem := CONFEXME_72.tbrcED_Item( '36214' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36189' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36189' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36189' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36190' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36190' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36215' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36190' ).itblitem := CONFEXME_72.tbrcED_Item( '36215' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36190' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36190' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36190' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36191' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36191' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36216' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36191' ).itblitem := CONFEXME_72.tbrcED_Item( '36216' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36191' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36191' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36191' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36192' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36192' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36217' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36192' ).itblitem := CONFEXME_72.tbrcED_Item( '36217' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36192' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36192' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36192' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36193' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36193' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36218' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36193' ).itblitem := CONFEXME_72.tbrcED_Item( '36218' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36193' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36193' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36193' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36194' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36194' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36219' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36194' ).itblitem := CONFEXME_72.tbrcED_Item( '36219' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36194' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36194' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36194' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36195' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36195' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36220' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36195' ).itblitem := CONFEXME_72.tbrcED_Item( '36220' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36195' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36195' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36195' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36196' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36196' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36221' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36196' ).itblitem := CONFEXME_72.tbrcED_Item( '36221' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36196' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36196' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36196' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36197' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36197' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36222' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36197' ).itblitem := CONFEXME_72.tbrcED_Item( '36222' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36197' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36197' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36197' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36198' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36198' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36223' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36198' ).itblitem := CONFEXME_72.tbrcED_Item( '36223' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36198' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36198' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36198' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36199' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36199' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36224' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36199' ).itblitem := CONFEXME_72.tbrcED_Item( '36224' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36199' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36199' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36199' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36200' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36200' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36225' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36200' ).itblitem := CONFEXME_72.tbrcED_Item( '36225' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36200' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36200' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36200' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36201' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36201' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36226' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36201' ).itblitem := CONFEXME_72.tbrcED_Item( '36226' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36201' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36201' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36201' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36202' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36202' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36227' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36202' ).itblitem := CONFEXME_72.tbrcED_Item( '36227' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36202' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36202' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36202' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36203' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36203' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36228' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36203' ).itblitem := CONFEXME_72.tbrcED_Item( '36228' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36203' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36203' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36203' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36204' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36204' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36229' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36204' ).itblitem := CONFEXME_72.tbrcED_Item( '36229' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36204' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36204' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36204' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36205' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36205' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36230' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36205' ).itblitem := CONFEXME_72.tbrcED_Item( '36230' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36205' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36205' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36205' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36206' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36206' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36231' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36206' ).itblitem := CONFEXME_72.tbrcED_Item( '36231' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36206' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36206' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36206' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36207' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36207' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36232' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36207' ).itblitem := CONFEXME_72.tbrcED_Item( '36232' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36207' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36207' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36207' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36208' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36208' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36233' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36208' ).itblitem := CONFEXME_72.tbrcED_Item( '36233' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36208' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36208' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36208' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36209' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36209' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36234' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36209' ).itblitem := CONFEXME_72.tbrcED_Item( '36234' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36209' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36209' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36209' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36210' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36210' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36235' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36210' ).itblitem := CONFEXME_72.tbrcED_Item( '36235' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36210' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36210' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36210' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36211' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36211' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36236' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36211' ).itblitem := CONFEXME_72.tbrcED_Item( '36236' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36211' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36211' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36211' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36212' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36212' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36237' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36212' ).itblitem := CONFEXME_72.tbrcED_Item( '36237' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36212' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36212' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36212' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36213' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36213' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36238' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36213' ).itblitem := CONFEXME_72.tbrcED_Item( '36238' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36213' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36213' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36213' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36214' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36214' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6930' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36239' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36214' ).itblitem := CONFEXME_72.tbrcED_Item( '36239' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36214' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36214' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36214' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36215' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36215' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36240' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36215' ).itblitem := CONFEXME_72.tbrcED_Item( '36240' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36215' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36215' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36215' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36216' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36216' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36241' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36216' ).itblitem := CONFEXME_72.tbrcED_Item( '36241' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36216' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36216' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36216' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36217' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36217' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6943' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36242' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36217' ).itblitem := CONFEXME_72.tbrcED_Item( '36242' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36217' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36217' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36217' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36218' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36218' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6945' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36243' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36218' ).itblitem := CONFEXME_72.tbrcED_Item( '36243' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36218' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36218' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36218' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36219' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36219' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36244' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36219' ).itblitem := CONFEXME_72.tbrcED_Item( '36244' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36219' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36219' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36219' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36220' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36220' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36245' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36220' ).itblitem := CONFEXME_72.tbrcED_Item( '36245' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36220' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36220' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36220' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36221' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36221' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36246' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36221' ).itblitem := CONFEXME_72.tbrcED_Item( '36246' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36221' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36221' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36221' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36222' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36222' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6944' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36247' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36222' ).itblitem := CONFEXME_72.tbrcED_Item( '36247' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36222' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36222' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36222' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36223' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36223' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6946' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36248' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36223' ).itblitem := CONFEXME_72.tbrcED_Item( '36248' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36223' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36223' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36223' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36224' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36224' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6947' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36249' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36224' ).itblitem := CONFEXME_72.tbrcED_Item( '36249' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36224' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36224' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36224' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36225' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36225' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6948' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36250' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36225' ).itblitem := CONFEXME_72.tbrcED_Item( '36250' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36225' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36225' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36225' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36226' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36226' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36251' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36226' ).itblitem := CONFEXME_72.tbrcED_Item( '36251' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36226' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36226' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36226' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36227' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36227' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6949' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36252' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36227' ).itblitem := CONFEXME_72.tbrcED_Item( '36252' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36227' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36227' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36227' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36228' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36228' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6950' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36253' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36228' ).itblitem := CONFEXME_72.tbrcED_Item( '36253' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36228' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36228' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36228' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36229' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36229' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6951' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36254' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36229' ).itblitem := CONFEXME_72.tbrcED_Item( '36254' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36229' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36229' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36229' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36236' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36236' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36261' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36236' ).itblitem := CONFEXME_72.tbrcED_Item( '36261' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36236' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36236' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36236' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36237' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36237' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36262' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36237' ).itblitem := CONFEXME_72.tbrcED_Item( '36262' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36237' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36237' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36237' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36238' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36238' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36263' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36238' ).itblitem := CONFEXME_72.tbrcED_Item( '36263' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36238' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36238' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36238' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36239' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36239' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36264' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36239' ).itblitem := CONFEXME_72.tbrcED_Item( '36264' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36239' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36239' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36239' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36240' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36240' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36265' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36240' ).itblitem := CONFEXME_72.tbrcED_Item( '36265' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36240' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36240' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36240' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36241' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36241' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36266' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36241' ).itblitem := CONFEXME_72.tbrcED_Item( '36266' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36241' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36241' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36241' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36242' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36242' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36267' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36242' ).itblitem := CONFEXME_72.tbrcED_Item( '36267' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36242' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36242' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36242' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36243' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36243' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36268' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36243' ).itblitem := CONFEXME_72.tbrcED_Item( '36268' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36243' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36243' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36243' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36244' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36244' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36269' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36244' ).itblitem := CONFEXME_72.tbrcED_Item( '36269' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36244' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36244' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36244' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36245' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36245' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36270' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36245' ).itblitem := CONFEXME_72.tbrcED_Item( '36270' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36245' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36245' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36245' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36246' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36246' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36271' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36246' ).itblitem := CONFEXME_72.tbrcED_Item( '36271' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36246' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36246' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36246' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36247' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36247' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6934' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36272' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36247' ).itblitem := CONFEXME_72.tbrcED_Item( '36272' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36247' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36247' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36247' ).itblblfr,
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
	CONFEXME_72.tbrcED_ItemBloq( '36269' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_72.tbrcED_ItemBloq( '36269' ).itblblfr := CONFEXME_72.tbrcED_BloqFran( '6941' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_72.tbrcED_Item.exists( '36294' ) ) then
		CONFEXME_72.tbrcED_ItemBloq( '36269' ).itblitem := CONFEXME_72.tbrcED_Item( '36294' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_72.tbrcED_ItemBloq( '36269' ).itblcodi,
		CONFEXME_72.tbrcED_ItemBloq( '36269' ).itblitem,
		CONFEXME_72.tbrcED_ItemBloq( '36269' ).itblblfr,
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

