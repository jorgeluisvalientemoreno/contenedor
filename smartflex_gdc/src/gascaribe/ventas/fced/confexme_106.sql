BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_106 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_106',
		'CREATE OR REPLACE PACKAGE CONFEXME_106 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_106;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_106',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_106 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_106;'
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_106.cuFormat( 584 );
	fetch CONFEXME_106.cuFormat into nuFormatId;
	close CONFEXME_106.cuFormat;

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
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_106.cuFormat( 584 );
	fetch CONFEXME_106.cuFormat into nuFormatId;
	close CONFEXME_106.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_106.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_COTIZACION_COMERCIAL',
		       formtido = 128,
		       formiden = '<584>',
		       formtico = 576,
		       formdein = '<DS_COTIZACION>',
		       formdefi = '</DS_COTIZACION>'
		WHERE  formcodi = CONFEXME_106.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_106.rcED_Formato.formcodi := 584 ;

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
			CONFEXME_106.rcED_Formato.formcodi,
			'LDC_COTIZACION_COMERCIAL',
			128,
			'<584>',
			576,
			'<DS_COTIZACION>',
			'</DS_COTIZACION>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_106.tbrcED_Franja( 3490 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [ENCABEZADO]', 5 );
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
		CONFEXME_106.tbrcED_Franja( 3490 ).francodi,
		'ENCABEZADO',
		CONFEXME_106.tbrcED_Franja( 3490 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_106.tbrcED_Franja( 3491 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [DATOS_CLIENTE]', 5 );
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
		CONFEXME_106.tbrcED_Franja( 3491 ).francodi,
		'DATOS_CLIENTE',
		CONFEXME_106.tbrcED_Franja( 3491 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_106.tbrcED_Franja( 3492 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [DETALLE]', 5 );
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
		CONFEXME_106.tbrcED_Franja( 3492 ).francodi,
		'DETALLE',
		CONFEXME_106.tbrcED_Franja( 3492 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_106.tbrcED_Franja( 3493 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [FORMA_PAGO]', 5 );
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
		CONFEXME_106.tbrcED_Franja( 3493 ).francodi,
		'FORMA_PAGO',
		CONFEXME_106.tbrcED_Franja( 3493 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_106.tbrcED_FranForm( '3359' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_106.tbrcED_FranForm( '3359' ).frfoform := CONFEXME_106.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_106.tbrcED_Franja.exists( 3490 ) ) then
		CONFEXME_106.tbrcED_FranForm( '3359' ).frfofran := CONFEXME_106.tbrcED_Franja( 3490 ).francodi;
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
		CONFEXME_106.tbrcED_FranForm( '3359' ).frfocodi,
		CONFEXME_106.tbrcED_FranForm( '3359' ).frfoform,
		CONFEXME_106.tbrcED_FranForm( '3359' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_106.tbrcED_FranForm( '3360' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_106.tbrcED_FranForm( '3360' ).frfoform := CONFEXME_106.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_106.tbrcED_Franja.exists( 3491 ) ) then
		CONFEXME_106.tbrcED_FranForm( '3360' ).frfofran := CONFEXME_106.tbrcED_Franja( 3491 ).francodi;
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
		CONFEXME_106.tbrcED_FranForm( '3360' ).frfocodi,
		CONFEXME_106.tbrcED_FranForm( '3360' ).frfoform,
		CONFEXME_106.tbrcED_FranForm( '3360' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_106.tbrcED_FranForm( '3361' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_106.tbrcED_FranForm( '3361' ).frfoform := CONFEXME_106.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_106.tbrcED_Franja.exists( 3492 ) ) then
		CONFEXME_106.tbrcED_FranForm( '3361' ).frfofran := CONFEXME_106.tbrcED_Franja( 3492 ).francodi;
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
		CONFEXME_106.tbrcED_FranForm( '3361' ).frfocodi,
		CONFEXME_106.tbrcED_FranForm( '3361' ).frfoform,
		CONFEXME_106.tbrcED_FranForm( '3361' ).frfofran,
		2,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_106.tbrcED_FranForm( '3362' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_106.tbrcED_FranForm( '3362' ).frfoform := CONFEXME_106.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_106.tbrcED_Franja.exists( 3493 ) ) then
		CONFEXME_106.tbrcED_FranForm( '3362' ).frfofran := CONFEXME_106.tbrcED_Franja( 3493 ).francodi;
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
		CONFEXME_106.tbrcED_FranForm( '3362' ).frfocodi,
		CONFEXME_106.tbrcED_FranForm( '3362' ).frfoform,
		CONFEXME_106.tbrcED_FranForm( '3362' ).frfofran,
		3,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - ENCABEZADO_COTIZACION_COM]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi,
		'LDC - ENCABEZADO_COTIZACION_COM',
		'ldc_bcformato_coti_com.proObtieneEncabezado',
		CONFEXME_106.tbrcED_FuenDato( '3341' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - DATOS_CLIENTE_COM]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi,
		'LDC - DATOS_CLIENTE_COM',
		'ldc_bcformato_coti_com.proObtieneDatosCliente',
		CONFEXME_106.tbrcED_FuenDato( '3342' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - DETALLE_COTI_COM]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi,
		'LDC - DETALLE_COTI_COM',
		'ldc_bcformato_coti_com.proObtieneDetalleItems',
		CONFEXME_106.tbrcED_FuenDato( '3343' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - FORMA_PAGO_COM]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi,
		'LDC - FORMA_PAGO_COM',
		'ldc_bcformato_coti_com.proObtieneFormaPago',
		CONFEXME_106.tbrcED_FuenDato( '3344' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27365' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27365' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Consecutivo_Cotizacion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27365' ).atfdcodi,
		'CONSECUTIVO_COTIZACION',
		'Consecutivo_Cotizacion',
		1,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27365' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27366' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27366' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Registro]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27366' ).atfdcodi,
		'FECHA_REGISTRO',
		'Fecha_Registro',
		2,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27366' ).atfdfuda,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27367' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27367' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Vigencia]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27367' ).atfdcodi,
		'FECHA_VIGENCIA',
		'Fecha_Vigencia',
		3,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27367' ).atfdfuda,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27368' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27368' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Solicitud]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27368' ).atfdcodi,
		'SOLICITUD',
		'Solicitud',
		4,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27368' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27369' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27369' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nit Cliente ]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27369' ).atfdcodi,
		'NIT',
		'Nit Cliente ',
		5,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27369' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27370' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27370' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Direccion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27370' ).atfdcodi,
		'DIRECCION',
		'Direccion',
		6,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27370' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27371' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27371' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Ciudad]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27371' ).atfdcodi,
		'CIUDAD',
		'Ciudad',
		7,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27371' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27372' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27372' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tipo_Trabajo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27372' ).atfdcodi,
		'TIPO_TRABAJO',
		'Tipo_Trabajo',
		1,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27372' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27373' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27373' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Id_Item]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27373' ).atfdcodi,
		'ID_ITEM',
		'Id_Item',
		2,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27373' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27374' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27374' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Item_Desc]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27374' ).atfdcodi,
		'ITEM_DESC',
		'Item_Desc',
		3,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27374' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27375' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27375' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Costo_Venta]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27375' ).atfdcodi,
		'COSTO_VENTA',
		'Costo_Venta',
		4,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27375' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27376' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27376' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Aiu]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27376' ).atfdcodi,
		'AIU',
		'Aiu',
		5,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27376' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27377' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27377' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
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
		CONFEXME_106.tbrcED_AtriFuda( '27377' ).atfdcodi,
		'CANTIDAD',
		'Cantidad',
		6,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27377' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27378' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27378' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Precio_Total]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27378' ).atfdcodi,
		'PRECIO_TOTAL',
		'Precio_Total',
		7,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27378' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27379' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27379' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
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
		CONFEXME_106.tbrcED_AtriFuda( '27379' ).atfdcodi,
		'VALOR_IVA',
		'Valor_Iva',
		8,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27379' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27380' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27380' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Total]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27380' ).atfdcodi,
		'VALOR_TOTAL',
		'Valor_Total',
		9,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27380' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27381' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3344' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27381' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Modalidad_Pago]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27381' ).atfdcodi,
		'MODALIDAD_PAGO',
		'Modalidad_Pago',
		1,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27381' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27382' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3344' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27382' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Numero_Cuotas]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27382' ).atfdcodi,
		'NUMERO_CUOTAS',
		'Numero_Cuotas',
		2,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27382' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27383' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3344' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27383' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Descuento]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27383' ).atfdcodi,
		'DESCUENTO',
		'Descuento',
		3,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27383' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27384' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3344' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27384' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cuota_Inicial]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27384' ).atfdcodi,
		'CUOTA_INICIAL',
		'Cuota_Inicial',
		4,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27384' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27385' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3344' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27385' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Financiar]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27385' ).atfdcodi,
		'VALOR_FINANCIAR',
		'Valor_Financiar',
		5,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27385' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27386' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27386' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
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
		CONFEXME_106.tbrcED_AtriFuda( '27386' ).atfdcodi,
		'CONTRATO',
		'Contrato',
		1,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27386' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27387' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27387' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Producto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27387' ).atfdcodi,
		'PRODUCTO',
		'Producto',
		2,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27387' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27388' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27388' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Direccion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27388' ).atfdcodi,
		'DIRECCION',
		'Direccion',
		3,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27388' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27389' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27389' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nombre_Cliente]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27389' ).atfdcodi,
		'NOMBRE_CLIENTE',
		'Nombre_Cliente',
		4,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27389' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27390' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27390' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Telefono_Cliente]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27390' ).atfdcodi,
		'TELEFONO_CLIENTE',
		'Telefono_Cliente',
		5,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27390' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27391' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27391' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Identificacion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27391' ).atfdcodi,
		'IDENTIFICACION',
		'Identificacion',
		6,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27391' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27392' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27392' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
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
		CONFEXME_106.tbrcED_AtriFuda( '27392' ).atfdcodi,
		'CATEGORIA',
		'Categoria',
		7,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27392' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27393' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27393' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Subcategoria]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27393' ).atfdcodi,
		'SUBCATEGORIA',
		'Subcategoria',
		8,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27393' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27394' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27394' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Departamento]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27394' ).atfdcodi,
		'DEPARTAMENTO',
		'Departamento',
		9,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27394' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27395' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27395' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
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
		CONFEXME_106.tbrcED_AtriFuda( '27395' ).atfdcodi,
		'LOCALIDAD',
		'Localidad',
		10,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27395' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27396' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27396' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Contratista]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27396' ).atfdcodi,
		'CONTRATISTA',
		'Contratista',
		11,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27396' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27397' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27397' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Formulario]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27397' ).atfdcodi,
		'FORMULARIO',
		'Formulario',
		12,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27397' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_106.tbrcED_AtriFuda( '27398' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_AtriFuda( '27398' ).atfdfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Observacion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_106.tbrcED_AtriFuda( '27398' ).atfdcodi,
		'OBSERVACION',
		'Observacion',
		13,
		'S',
		CONFEXME_106.tbrcED_AtriFuda( '27398' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_106.tbrcED_Bloque( 5382 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3341' ) ) then
		CONFEXME_106.tbrcED_Bloque( 5382 ).bloqfuda := CONFEXME_106.tbrcED_FuenDato( '3341' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [BLOQUE_ENCABEZADO]', 5 );
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
		CONFEXME_106.tbrcED_Bloque( 5382 ).bloqcodi,
		'BLOQUE_ENCABEZADO',
		CONFEXME_106.tbrcED_Bloque( 5382 ).bloqtibl,
		CONFEXME_106.tbrcED_Bloque( 5382 ).bloqfuda,
		'<BLOQUE_ENCABEZADO>',
		'</BLOQUE_ENCABEZADO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_106.tbrcED_Bloque( 5383 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3342' ) ) then
		CONFEXME_106.tbrcED_Bloque( 5383 ).bloqfuda := CONFEXME_106.tbrcED_FuenDato( '3342' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [BLOQUE_CLIENTE]', 5 );
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
		CONFEXME_106.tbrcED_Bloque( 5383 ).bloqcodi,
		'BLOQUE_CLIENTE',
		CONFEXME_106.tbrcED_Bloque( 5383 ).bloqtibl,
		CONFEXME_106.tbrcED_Bloque( 5383 ).bloqfuda,
		'<BLOQUE_CLIENTE>',
		'</BLOQUE_CLIENTE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_106.tbrcED_Bloque( 5384 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3343' ) ) then
		CONFEXME_106.tbrcED_Bloque( 5384 ).bloqfuda := CONFEXME_106.tbrcED_FuenDato( '3343' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [BLOQUE_DETALLE]', 5 );
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
		CONFEXME_106.tbrcED_Bloque( 5384 ).bloqcodi,
		'BLOQUE_DETALLE',
		CONFEXME_106.tbrcED_Bloque( 5384 ).bloqtibl,
		CONFEXME_106.tbrcED_Bloque( 5384 ).bloqfuda,
		'<BLOQUE_DETALLE>',
		'</BLOQUE_DETALLE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_106.tbrcED_Bloque( 5385 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_106.tbrcED_FuenDato.exists( '3344' ) ) then
		CONFEXME_106.tbrcED_Bloque( 5385 ).bloqfuda := CONFEXME_106.tbrcED_FuenDato( '3344' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [BLOQUE_FORMA_PAGO]', 5 );
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
		CONFEXME_106.tbrcED_Bloque( 5385 ).bloqcodi,
		'BLOQUE_FORMA_PAGO',
		CONFEXME_106.tbrcED_Bloque( 5385 ).bloqtibl,
		CONFEXME_106.tbrcED_Bloque( 5385 ).bloqfuda,
		'<BLOQUE_FORMA_PAGO>',
		'</BLOQUE_FORMA_PAGO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrfrfo := CONFEXME_106.tbrcED_FranForm( '3359' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_106.tbrcED_Bloque.exists( 5382 ) ) then
		CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrbloq := CONFEXME_106.tbrcED_Bloque( 5382 ).bloqcodi;
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
		CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi,
		CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrbloq,
		CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrfrfo := CONFEXME_106.tbrcED_FranForm( '3360' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_106.tbrcED_Bloque.exists( 5383 ) ) then
		CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrbloq := CONFEXME_106.tbrcED_Bloque( 5383 ).bloqcodi;
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
		CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi,
		CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrbloq,
		CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrfrfo := CONFEXME_106.tbrcED_FranForm( '3361' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_106.tbrcED_Bloque.exists( 5384 ) ) then
		CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrbloq := CONFEXME_106.tbrcED_Bloque( 5384 ).bloqcodi;
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
		CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi,
		CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrbloq,
		CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrfrfo := CONFEXME_106.tbrcED_FranForm( '3362' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_106.tbrcED_Bloque.exists( 5385 ) ) then
		CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrbloq := CONFEXME_106.tbrcED_Bloque( 5385 ).bloqcodi;
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
		CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrcodi,
		CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrbloq,
		CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33239' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33239' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27365' ) ) then
		CONFEXME_106.tbrcED_Item( '33239' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27365' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Consecutivo_Cotizacion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33239' ).itemcodi,
		'Consecutivo_Cotizacion',
		CONFEXME_106.tbrcED_Item( '33239' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33239' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33239' ).itemgren,
		NULL,
		1,
		'<Consecutivo_Cotizacion>',
		'</Consecutivo_Cotizacion>',
		CONFEXME_106.tbrcED_Item( '33239' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33240' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33240' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27366' ) ) then
		CONFEXME_106.tbrcED_Item( '33240' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27366' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Registro]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33240' ).itemcodi,
		'Fecha_Registro',
		CONFEXME_106.tbrcED_Item( '33240' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33240' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33240' ).itemgren,
		NULL,
		12,
		'<Fecha_Registro>',
		'</Fecha_Registro>',
		CONFEXME_106.tbrcED_Item( '33240' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33241' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33241' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27367' ) ) then
		CONFEXME_106.tbrcED_Item( '33241' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27367' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Vigencia]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33241' ).itemcodi,
		'Fecha_Vigencia',
		CONFEXME_106.tbrcED_Item( '33241' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33241' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33241' ).itemgren,
		NULL,
		12,
		'<Fecha_Vigencia>',
		'</Fecha_Vigencia>',
		CONFEXME_106.tbrcED_Item( '33241' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33242' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33242' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27368' ) ) then
		CONFEXME_106.tbrcED_Item( '33242' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27368' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Solicitud]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33242' ).itemcodi,
		'Solicitud',
		CONFEXME_106.tbrcED_Item( '33242' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33242' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33242' ).itemgren,
		NULL,
		1,
		'<Solicitud>',
		'</Solicitud>',
		CONFEXME_106.tbrcED_Item( '33242' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33243' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33243' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27369' ) ) then
		CONFEXME_106.tbrcED_Item( '33243' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27369' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nit]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33243' ).itemcodi,
		'Nit',
		CONFEXME_106.tbrcED_Item( '33243' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33243' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33243' ).itemgren,
		NULL,
		1,
		'<Nit>',
		'</Nit>',
		CONFEXME_106.tbrcED_Item( '33243' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33244' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33244' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27370' ) ) then
		CONFEXME_106.tbrcED_Item( '33244' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27370' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Direccion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33244' ).itemcodi,
		'Direccion',
		CONFEXME_106.tbrcED_Item( '33244' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33244' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33244' ).itemgren,
		NULL,
		1,
		'<Direccion>',
		'</Direccion>',
		CONFEXME_106.tbrcED_Item( '33244' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33245' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33245' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27371' ) ) then
		CONFEXME_106.tbrcED_Item( '33245' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27371' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Ciudad]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33245' ).itemcodi,
		'Ciudad',
		CONFEXME_106.tbrcED_Item( '33245' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33245' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33245' ).itemgren,
		NULL,
		1,
		'<Ciudad>',
		'</Ciudad>',
		CONFEXME_106.tbrcED_Item( '33245' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33246' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33246' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27372' ) ) then
		CONFEXME_106.tbrcED_Item( '33246' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27372' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tipo_Trabajo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33246' ).itemcodi,
		'Tipo_Trabajo',
		CONFEXME_106.tbrcED_Item( '33246' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33246' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33246' ).itemgren,
		NULL,
		1,
		'<Tipo_Trabajo>',
		'</Tipo_Trabajo>',
		CONFEXME_106.tbrcED_Item( '33246' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33247' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33247' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27373' ) ) then
		CONFEXME_106.tbrcED_Item( '33247' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27373' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Id_Item]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33247' ).itemcodi,
		'Id_Item',
		CONFEXME_106.tbrcED_Item( '33247' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33247' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33247' ).itemgren,
		NULL,
		1,
		'<Id_Item>',
		'</Id_Item>',
		CONFEXME_106.tbrcED_Item( '33247' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33248' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33248' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27374' ) ) then
		CONFEXME_106.tbrcED_Item( '33248' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27374' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Item_Desc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33248' ).itemcodi,
		'Item_Desc',
		CONFEXME_106.tbrcED_Item( '33248' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33248' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33248' ).itemgren,
		NULL,
		1,
		'<Item_Desc>',
		'</Item_Desc>',
		CONFEXME_106.tbrcED_Item( '33248' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33249' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33249' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27375' ) ) then
		CONFEXME_106.tbrcED_Item( '33249' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27375' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Costo_Venta]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33249' ).itemcodi,
		'Costo_Venta',
		CONFEXME_106.tbrcED_Item( '33249' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33249' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33249' ).itemgren,
		NULL,
		2,
		'<Costo_Venta>',
		'</Costo_Venta>',
		CONFEXME_106.tbrcED_Item( '33249' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33250' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33250' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27376' ) ) then
		CONFEXME_106.tbrcED_Item( '33250' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27376' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Aiu]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33250' ).itemcodi,
		'Aiu',
		CONFEXME_106.tbrcED_Item( '33250' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33250' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33250' ).itemgren,
		NULL,
		2,
		'<Aiu>',
		'</Aiu>',
		CONFEXME_106.tbrcED_Item( '33250' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33251' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33251' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27377' ) ) then
		CONFEXME_106.tbrcED_Item( '33251' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27377' ).atfdcodi;
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
		CONFEXME_106.tbrcED_Item( '33251' ).itemcodi,
		'Cantidad',
		CONFEXME_106.tbrcED_Item( '33251' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33251' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33251' ).itemgren,
		NULL,
		2,
		'<Cantidad>',
		'</Cantidad>',
		CONFEXME_106.tbrcED_Item( '33251' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33252' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33252' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27378' ) ) then
		CONFEXME_106.tbrcED_Item( '33252' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27378' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Precio_Total]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33252' ).itemcodi,
		'Precio_Total',
		CONFEXME_106.tbrcED_Item( '33252' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33252' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33252' ).itemgren,
		NULL,
		2,
		'<Precio_Total>',
		'</Precio_Total>',
		CONFEXME_106.tbrcED_Item( '33252' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33253' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33253' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27379' ) ) then
		CONFEXME_106.tbrcED_Item( '33253' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27379' ).atfdcodi;
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
		CONFEXME_106.tbrcED_Item( '33253' ).itemcodi,
		'Valor_Iva',
		CONFEXME_106.tbrcED_Item( '33253' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33253' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33253' ).itemgren,
		NULL,
		2,
		'<Valor_Iva>',
		'</Valor_Iva>',
		CONFEXME_106.tbrcED_Item( '33253' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33254' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33254' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27380' ) ) then
		CONFEXME_106.tbrcED_Item( '33254' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27380' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Total]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33254' ).itemcodi,
		'Valor_Total',
		CONFEXME_106.tbrcED_Item( '33254' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33254' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33254' ).itemgren,
		NULL,
		2,
		'<Valor_Total>',
		'</Valor_Total>',
		CONFEXME_106.tbrcED_Item( '33254' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33255' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33255' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27381' ) ) then
		CONFEXME_106.tbrcED_Item( '33255' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27381' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Modalidad_Pago]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33255' ).itemcodi,
		'Modalidad_Pago',
		CONFEXME_106.tbrcED_Item( '33255' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33255' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33255' ).itemgren,
		NULL,
		1,
		'<Modalidad_Pago>',
		'</Modalidad_Pago>',
		CONFEXME_106.tbrcED_Item( '33255' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33256' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33256' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27382' ) ) then
		CONFEXME_106.tbrcED_Item( '33256' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27382' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Numero_Cuotas]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33256' ).itemcodi,
		'Numero_Cuotas',
		CONFEXME_106.tbrcED_Item( '33256' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33256' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33256' ).itemgren,
		NULL,
		1,
		'<Numero_Cuotas>',
		'</Numero_Cuotas>',
		CONFEXME_106.tbrcED_Item( '33256' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33257' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33257' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27383' ) ) then
		CONFEXME_106.tbrcED_Item( '33257' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27383' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Descuento]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33257' ).itemcodi,
		'Descuento',
		CONFEXME_106.tbrcED_Item( '33257' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33257' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33257' ).itemgren,
		NULL,
		2,
		'<Descuento>',
		'</Descuento>',
		CONFEXME_106.tbrcED_Item( '33257' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33258' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33258' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27384' ) ) then
		CONFEXME_106.tbrcED_Item( '33258' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27384' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cuota_Inicial]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33258' ).itemcodi,
		'Cuota_Inicial',
		CONFEXME_106.tbrcED_Item( '33258' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33258' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33258' ).itemgren,
		NULL,
		2,
		'<Cuota_Inicial>',
		'</Cuota_Inicial>',
		CONFEXME_106.tbrcED_Item( '33258' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33259' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33259' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27385' ) ) then
		CONFEXME_106.tbrcED_Item( '33259' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27385' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Financiar]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33259' ).itemcodi,
		'Valor_Financiar',
		CONFEXME_106.tbrcED_Item( '33259' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33259' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33259' ).itemgren,
		NULL,
		2,
		'<Valor_Financiar>',
		'</Valor_Financiar>',
		CONFEXME_106.tbrcED_Item( '33259' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33260' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33260' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27386' ) ) then
		CONFEXME_106.tbrcED_Item( '33260' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27386' ).atfdcodi;
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
		CONFEXME_106.tbrcED_Item( '33260' ).itemcodi,
		'Contrato',
		CONFEXME_106.tbrcED_Item( '33260' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33260' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33260' ).itemgren,
		NULL,
		1,
		'<Contrato>',
		'</Contrato>',
		CONFEXME_106.tbrcED_Item( '33260' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33261' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33261' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27387' ) ) then
		CONFEXME_106.tbrcED_Item( '33261' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27387' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Producto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33261' ).itemcodi,
		'Producto',
		CONFEXME_106.tbrcED_Item( '33261' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33261' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33261' ).itemgren,
		NULL,
		1,
		'<Producto>',
		'</Producto>',
		CONFEXME_106.tbrcED_Item( '33261' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33262' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33262' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27388' ) ) then
		CONFEXME_106.tbrcED_Item( '33262' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27388' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Direccion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33262' ).itemcodi,
		'Direccion',
		CONFEXME_106.tbrcED_Item( '33262' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33262' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33262' ).itemgren,
		NULL,
		1,
		'<Direccion>',
		'</Direccion>',
		CONFEXME_106.tbrcED_Item( '33262' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33263' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33263' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27389' ) ) then
		CONFEXME_106.tbrcED_Item( '33263' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27389' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nombre_Cliente]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33263' ).itemcodi,
		'Nombre_Cliente',
		CONFEXME_106.tbrcED_Item( '33263' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33263' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33263' ).itemgren,
		NULL,
		1,
		'<Nombre_Cliente>',
		'</Nombre_Cliente>',
		CONFEXME_106.tbrcED_Item( '33263' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33264' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33264' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27390' ) ) then
		CONFEXME_106.tbrcED_Item( '33264' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27390' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Telefono_Cliente]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33264' ).itemcodi,
		'Telefono_Cliente',
		CONFEXME_106.tbrcED_Item( '33264' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33264' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33264' ).itemgren,
		NULL,
		1,
		'<Telefono_Cliente>',
		'</Telefono_Cliente>',
		CONFEXME_106.tbrcED_Item( '33264' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33265' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33265' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27391' ) ) then
		CONFEXME_106.tbrcED_Item( '33265' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27391' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Identificacion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33265' ).itemcodi,
		'Identificacion',
		CONFEXME_106.tbrcED_Item( '33265' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33265' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33265' ).itemgren,
		NULL,
		1,
		'<Identificacion>',
		'</Identificacion>',
		CONFEXME_106.tbrcED_Item( '33265' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33266' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33266' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27392' ) ) then
		CONFEXME_106.tbrcED_Item( '33266' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27392' ).atfdcodi;
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
		CONFEXME_106.tbrcED_Item( '33266' ).itemcodi,
		'Categoria',
		CONFEXME_106.tbrcED_Item( '33266' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33266' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33266' ).itemgren,
		NULL,
		1,
		'<Categoria>',
		'</Categoria>',
		CONFEXME_106.tbrcED_Item( '33266' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33267' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33267' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27393' ) ) then
		CONFEXME_106.tbrcED_Item( '33267' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27393' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Subcategoria]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33267' ).itemcodi,
		'Subcategoria',
		CONFEXME_106.tbrcED_Item( '33267' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33267' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33267' ).itemgren,
		NULL,
		1,
		'<Subcategoria>',
		'</Subcategoria>',
		CONFEXME_106.tbrcED_Item( '33267' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33268' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33268' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27394' ) ) then
		CONFEXME_106.tbrcED_Item( '33268' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27394' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Departamento]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33268' ).itemcodi,
		'Departamento',
		CONFEXME_106.tbrcED_Item( '33268' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33268' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33268' ).itemgren,
		NULL,
		1,
		'<Departamento>',
		'</Departamento>',
		CONFEXME_106.tbrcED_Item( '33268' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33269' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33269' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27395' ) ) then
		CONFEXME_106.tbrcED_Item( '33269' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27395' ).atfdcodi;
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
		CONFEXME_106.tbrcED_Item( '33269' ).itemcodi,
		'Localidad',
		CONFEXME_106.tbrcED_Item( '33269' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33269' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33269' ).itemgren,
		NULL,
		1,
		'<Localidad>',
		'</Localidad>',
		CONFEXME_106.tbrcED_Item( '33269' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33270' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33270' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27396' ) ) then
		CONFEXME_106.tbrcED_Item( '33270' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27396' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Contratista]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33270' ).itemcodi,
		'Contratista',
		CONFEXME_106.tbrcED_Item( '33270' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33270' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33270' ).itemgren,
		NULL,
		1,
		'<Contratista>',
		'</Contratista>',
		CONFEXME_106.tbrcED_Item( '33270' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33271' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33271' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27397' ) ) then
		CONFEXME_106.tbrcED_Item( '33271' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27397' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Formulario]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33271' ).itemcodi,
		'Formulario',
		CONFEXME_106.tbrcED_Item( '33271' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33271' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33271' ).itemgren,
		NULL,
		1,
		'<Formulario>',
		'</Formulario>',
		CONFEXME_106.tbrcED_Item( '33271' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_106.tbrcED_Item( '33272' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_106.tbrcED_Item( '33272' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_106.tbrcED_AtriFuda.exists( '27398' ) ) then
		CONFEXME_106.tbrcED_Item( '33272' ).itematfd := CONFEXME_106.tbrcED_AtriFuda( '27398' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Observacion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_106.tbrcED_Item( '33272' ).itemcodi,
		'Observacion',
		CONFEXME_106.tbrcED_Item( '33272' ).itemceid,
		NULL,
		CONFEXME_106.tbrcED_Item( '33272' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_106.tbrcED_Item( '33272' ).itemgren,
		NULL,
		1,
		'<Observacion>',
		'</Observacion>',
		CONFEXME_106.tbrcED_Item( '33272' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33185' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33185' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33239' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33185' ).itblitem := CONFEXME_106.tbrcED_Item( '33239' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33185' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33185' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33185' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33186' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33186' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33240' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33186' ).itblitem := CONFEXME_106.tbrcED_Item( '33240' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33186' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33186' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33186' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33187' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33187' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33241' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33187' ).itblitem := CONFEXME_106.tbrcED_Item( '33241' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33187' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33187' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33187' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33188' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33188' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33242' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33188' ).itblitem := CONFEXME_106.tbrcED_Item( '33242' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33188' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33188' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33188' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33189' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33189' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33243' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33189' ).itblitem := CONFEXME_106.tbrcED_Item( '33243' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33189' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33189' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33189' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33190' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33190' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33244' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33190' ).itblitem := CONFEXME_106.tbrcED_Item( '33244' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33190' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33190' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33190' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33191' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33191' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5553' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33245' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33191' ).itblitem := CONFEXME_106.tbrcED_Item( '33245' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33191' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33191' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33191' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33192' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33192' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33246' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33192' ).itblitem := CONFEXME_106.tbrcED_Item( '33246' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33192' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33192' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33192' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33193' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33193' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33247' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33193' ).itblitem := CONFEXME_106.tbrcED_Item( '33247' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33193' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33193' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33193' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33194' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33194' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33248' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33194' ).itblitem := CONFEXME_106.tbrcED_Item( '33248' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33194' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33194' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33194' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33195' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33195' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33249' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33195' ).itblitem := CONFEXME_106.tbrcED_Item( '33249' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33195' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33195' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33195' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33196' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33196' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33250' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33196' ).itblitem := CONFEXME_106.tbrcED_Item( '33250' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33196' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33196' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33196' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33197' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33197' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33251' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33197' ).itblitem := CONFEXME_106.tbrcED_Item( '33251' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33197' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33197' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33197' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33198' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33198' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33252' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33198' ).itblitem := CONFEXME_106.tbrcED_Item( '33252' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33198' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33198' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33198' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33199' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33199' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33253' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33199' ).itblitem := CONFEXME_106.tbrcED_Item( '33253' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33199' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33199' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33199' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33200' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33200' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5555' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33254' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33200' ).itblitem := CONFEXME_106.tbrcED_Item( '33254' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33200' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33200' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33200' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33201' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33201' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33255' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33201' ).itblitem := CONFEXME_106.tbrcED_Item( '33255' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33201' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33201' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33201' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33202' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33202' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33256' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33202' ).itblitem := CONFEXME_106.tbrcED_Item( '33256' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33202' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33202' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33202' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33203' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33203' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33257' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33203' ).itblitem := CONFEXME_106.tbrcED_Item( '33257' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33203' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33203' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33203' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33204' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33204' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33258' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33204' ).itblitem := CONFEXME_106.tbrcED_Item( '33258' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33204' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33204' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33204' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33205' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33205' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5556' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33259' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33205' ).itblitem := CONFEXME_106.tbrcED_Item( '33259' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33205' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33205' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33205' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33206' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33206' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33260' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33206' ).itblitem := CONFEXME_106.tbrcED_Item( '33260' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33206' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33206' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33206' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33207' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33207' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33261' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33207' ).itblitem := CONFEXME_106.tbrcED_Item( '33261' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33207' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33207' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33207' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33208' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33208' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33262' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33208' ).itblitem := CONFEXME_106.tbrcED_Item( '33262' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33208' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33208' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33208' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33209' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33209' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33263' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33209' ).itblitem := CONFEXME_106.tbrcED_Item( '33263' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33209' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33209' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33209' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33210' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33210' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33264' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33210' ).itblitem := CONFEXME_106.tbrcED_Item( '33264' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33210' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33210' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33210' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33211' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33211' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33265' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33211' ).itblitem := CONFEXME_106.tbrcED_Item( '33265' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33211' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33211' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33211' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33212' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33212' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33266' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33212' ).itblitem := CONFEXME_106.tbrcED_Item( '33266' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33212' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33212' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33212' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33213' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33213' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33267' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33213' ).itblitem := CONFEXME_106.tbrcED_Item( '33267' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33213' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33213' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33213' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33214' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33214' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33268' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33214' ).itblitem := CONFEXME_106.tbrcED_Item( '33268' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33214' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33214' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33214' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33215' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33215' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33269' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33215' ).itblitem := CONFEXME_106.tbrcED_Item( '33269' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33215' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33215' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33215' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33216' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33216' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33270' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33216' ).itblitem := CONFEXME_106.tbrcED_Item( '33270' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33216' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33216' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33216' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33217' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33217' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33271' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33217' ).itblitem := CONFEXME_106.tbrcED_Item( '33271' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33217' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33217' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33217' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_106.tbrcED_ItemBloq( '33218' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_106.tbrcED_ItemBloq( '33218' ).itblblfr := CONFEXME_106.tbrcED_BloqFran( '5554' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_106.tbrcED_Item.exists( '33272' ) ) then
		CONFEXME_106.tbrcED_ItemBloq( '33218' ).itblitem := CONFEXME_106.tbrcED_Item( '33272' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_106.tbrcED_ItemBloq( '33218' ).itblcodi,
		CONFEXME_106.tbrcED_ItemBloq( '33218' ).itblitem,
		CONFEXME_106.tbrcED_ItemBloq( '33218' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
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
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E63663833333861342D656138322D343463362D613262662D6133343735613039623234643C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C506167654865616465723E0D0A202020203C5072696E744F6E4669727374506167653E747275653C2F5072696E744F6E4669727374506167653E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783637223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E33636D3C2F546F703E0D0A20202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C42'
		||	'6F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E53657444617461285265706F72744974656D732174657874626F7833352E56616C75652C31293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783636223E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020'
		||	'20202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E4765744461746128342C31293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783635223E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E466563686120646520566967656E6369613C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783634223E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A'
		||	'202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E4765744461746128332C31293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783633223E0D0A20202020202020203C546F703E332E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E4765744461746128322C31293C2F56616C75653E0D0A20'
		||	'20202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783632223E0D0A20202020202020203C546F703E33636D3C2F546F703E0D0A20202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E4765744461746128312C31293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783537223E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E342E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E32'
		||	'70743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E466563686120646520456C61626F72616369C3B36E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783532223E0D0A20202020202020203C546F703E332E35636D3C2F546F703E0D0A20202020202020203C57696474683E342E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E536F6C696369747564204EC2B03C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874'
		||	'626F78204E616D653D2274657874626F783531223E0D0A20202020202020203C546F703E33636D3C2F546F703E0D0A20202020202020203C57696474683E342E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436F74697A616369C3B36E206465205365766963696F73204E6F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676531223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C57696474683E362E35636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4744433C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020'
		||	'202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A20202020202020203C546F703E302E3735636D3C2F546F703E0D0A20202020202020203C57696474683E392E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E233339373361643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C4C6566743E31312E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E4765744461746128362C31293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22446972656363696F6E223E0D0A20202020202020203C72643A44656661756C744E616D653E446972656363696F6E3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E312E3235636D3C2F546F703E0D0A20202020202020203C57696474683E392E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E233339373361643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A'
		||	'20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C4C6566743E31312E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E4765744461746128352C31293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C4C696E65204E616D653D226C696E6531223E0D0A20202020202020203C546F703E32636D3C2F546F703E0D0A20202020202020203C57696474683E32302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E233339373361643C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D226E6974223E0D0A20202020202020203C72643A44656661756C744E616D653E6E69743C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E3035323931636D3C2F546F703E0D0A20202020202020203C57696474683E342E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E233339373361643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E313C2F5A49'
		||	'6E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E322E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F64652E4765744461746128372C31293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E3035323931636D3C2F546F703E0D0A20202020202020203C57696474683E302E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E233339373361643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E32636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E69742E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E35636D3C2F4865696768743E0D0A202020203C5072696E744F6E4C617374506167653E747275653C2F5072696E744F6E4C617374506167653E0D0A20203C2F506167654865616465723E0D0A20203C426F74746F6D4D617267696E3E302E35636D3C2F426F74746F6D4D617267696E3E0D0A20203C72643A5265706F727449443E65623133306536642D613632622D343335392D393734642D3434363864663165646436663C2F72643A5265706F727449443E0D0A20203C456D626564646564496D616765733E0D0A202020203C456D626564646564496D616765204E616D653D226C6F676F5F656669676173223E0D0A2020202020'
		||	'203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E2F396A2F34414151536B5A4A5267414241514541594142674141442F3277424441414942415149424151494341674943416749434177554441774D444177594542414D464277594842776347427763494351734A4341674B434163484367304B4367734D4441774D42776B4F4477304D4467734D44417A2F327742444151494341674D44417759444177594D434163494441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D44417A2F7741415243414268414B73444153494141684542417845422F38514148774141415155424151454241514541414141414141414141414543417751464267634943516F4C2F3851417452414141674544417749454177554642415141414146394151494441415152425249684D5545474531466842794A7846444B426B61454949304B78775256533066416B4D324A7967676B4B4668635947526F6C4A69636F4B536F304E5459334F446B3651305246526B644953557054564656575631685A576D4E6B5A575A6E61476C7163335231646E643465587144684957476834694A69704B546C4A57576C35695A6D714B6A704B576D7036697071724B7A744C57327437693575734C44784D584778386A4A79744C54314E585731396A5A32754869342B546C3575666F3665727838765030396662332B506E362F38514148774541417745424151454241514542415141414141414141414543417751464267634943516F4C2F385141745245414167454342415144424163464241514141514A3341414543417845454253457842684A425551646863524D694D6F454946454B526F62484243534D7A55764156596E4C524368596B4E4F456C3852635947526F6D4A7967704B6A55324E7A67354F6B4E4552555A4853456C4B55315256566C64595756706A5A47566D5A326870616E4E3064585A3365486C36676F4F456859614869496D4B6B704F556C5A61586D4A6D616F714F6B7061616E714B6D7173724F3074626133754C6D367773504578636248794D6E4B3074505531646258324E6E613475506B3565626E364F6E7138765030396662332B506E362F396F4144414D424141495241784541507744392F4B4B4B382F38413270506A377076374D50774438532B4E39554B6D4C51375270495953324464547438735551393263715059456E745774436855725659306153764B545353377437474F4A78465044305A56367A74474B6262374A61732B46662B437A2F77447755455477503856664350777A30'
		||	'57353352614C716C6C7276695578484A6378794A4C44616E386849773954483647763066304C57626678486F6C6E71467049730A747266774A6351794B6368306451796B48334246667A4B664537346A617038577669467248696257626C377656646275354C79356D593875377357503048504137562B78582F42456A397565772B4E507744692B48327558305550696A774C626249424D2B30336D6E723978775431386F59527652646839612F584F4E65446C674D6B6F5477367637472F4F2B2F4E613876524E57386C62736669484150486E396F3851596D474B646C5874374E5070795874483161642F4E70397A37736F72796A77582B3050463857506A593268364649683062536F4A5A626D34786B33626A6146432B6941746E50553437447236765834466B504557417A6D6A50455A64506E70786D34637932626A612F4B2B7175375832646E613673332B3956614D3662355A364D4B4B4B4B3977794369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967446A66692F38414679312B457936484A646C566831505546745A58596636754D67376D2F4137612F4E622F41494F4676327076375531377731384B744C756431765A527272577265573379764A49434945505934546332502B6D716D7671622F67704A346F49317A772F70676C4B70623237335569672F336D3450346555667A723877666A7A384B59666A6A34737539656C76376D3231613549426C636D574F5246415641564A794D4B46484859446975627752346A725A6C782F6D32457845623462424B6E797937564A78315458566645373948487A302F4C2F4142707A4E594C49614F46707530385133663841775273332B4C69764E4E6E792B41575941416B6B344141354A72364C2F5A752B476435384B62694C78444C4E4E6136374968454B49325073694D4D4548315A6753434F774F4B39432F5A2B2F344A532F457154774E483852526F634F766159537A61644262536636533667342B30655377425964646F4754786E485369654A3765346B696C53534B614A796B6B63696C586A59645177504949394458395535746D324578394F706771546A556730347A576A5454306357757A576A543332327566792F56776D4E774C7031366B4A5537326C43566E472F564F4C2F4736507266396744343132756C6646537875627478416C2F7573626F46734C453739472B68495836445070583648312B4C2F774149745A6654504671784B3230585346666F792F4D702F6E2B646670482B786C2B30372F7773335331384F36772F2F4535736F763345705038417839496F36482F614148346748304F66344277734D763441343078484133775962457456384C665A6530306C'
		||	'53623870776B6F5833576A664D31662B7A2B4275494B334557515538797261316162644F7035754E6D70664F4C54666E6532680A3737525258694878782F774343692F77652F5A772B49452F6866786C3474476B61356252527A535735302B356D327136376C4F354932586B4548723372396E776D4378474B6E37504455334F57396F707432394565746A6377777544702B317864534E4F4E37586B306C6674646E743946664D502F41412B502F5A302F364B43762F677076662F6A4E65702F732F774437583377382F6167304C56395338452B495939577364425A5676356E7435625A626663724D43664E56654D4B78794F42697576455A4A6D4F48707572586F546A466458475358337448466865496372784E5255634E696163355070476357394E586F6D656C3056384F2F46662F41494C346642373466654C626E53744B73664576696C62535178506557554D63647449516345786C32444D50666141653252566E784A2F7758532B475068627744346238515850683378676262784D6C77304561525146342F4A6B387467325A414F765446656B754463376359792B7253393762376D3974396B7A79587835772B70546A39616A37752B3757365736566E71307444375A6F72697632642F6A6C706E3753587762305478726F39766557756D36374530734D563046457142585A4475326B6A71703647753172353674526E527153705656615557303132613350714D50694B64656C4776526434795361666450564D4B4B4B4B794E676F6F6F6F414B4B4B4B4143696969674434442F344B6165495754346B367438782F774247736F725A505973716E2F326331383866736F2F416554396F3334353650345A2B64644F4C4737314F526638416C6E6178344C6A5059746B49506476617661662B436E4264506962712B6634706F50793874635636482F775277384178512B476647586968307A63584E3346706B542F335934303878682B4C4F763556343367653167736B7A334E6F2F774157726A3638622B554F534D6675753276552F477645444C2F375A3430774756316634634B555A4E655635796C2F34465A5250732F53744C74394430793373724F474F32744C534A5959596F317773534B4D4B6F486F41425879522F7755362F5A4373764676676D372B497567576977612F6F79655A717151726A2B30625966656367645A49787A6E756F49505156396458742F447074713031784C4842436D4E7A794D46555A4F42796663696F395A306D4458744875724735515357313743384571486F364D7056682B524E665535626D465842346D4F4A67396E723572716A394934687948445A746C383876724A5761302F7576374C586133355857782B4B7667562F2B4B7730306A2F6E'
		||	'735036313737384A2F467333676234696156716C752F6C79576C77736D6659484A4239694D672B784E654E654666437A614A380A574C76546A794E4675376D456E2F414B354F79442B517231587768704C6137346E73724E415761356C455941484A4A3448366D7635462B6D626D6C2B4E38766867332B397055494F3633556E5671536A38396D765648672F52397764536E6B4F496C56576B71306C3930494A2F6A70386A39513761345737743435562B37496F64666F526D7677352F344C7271482F774343684772673944707467442F3334537633433032312B773666424431386D4E557A3634474B2F44332F41494C734A356E2F4141554831686637326D32412F77444943562F656E684C7A504E337A622B7A663578506E2F476E2F414A454D502B7673662F535A6E3064384A763841676C482B7A4A34752B4658686E5664552B49787474543150536257377534662B456973553871615346486464705849777849776552697076326D54384F663841676C312B7837346D30443462585770654B34506A44466461596453693161476150544A6F6F517534474E4D45346E35475165427A58416644542F673332316E346966446A772F34676A2B4A6C68624A72756D32326F4C43326C794D59684E45736758506D633433592F43766F6A784E2B7739462B787A2F7753663841696C3455316139307A78566557746E714F7132313862414962597951524A386D38735662393339344564523656372B4B7A5042764530366338664C4570314970306D6E4662364F2F3932566E6272592B62775755593559537255703562444353564B54565A53556E747175572F7742754E31667065352B5A6E374333782F384168352B7A39342B315857506942384F4950695174786243477874626952504A745A43344C534D6A6F7973634441794F4D6D767562397137396F62396E6E34562F43373456367472507741736455735047656A53617870396C62337632564E4C575351463438494E704A5935344146655766384739336844536647487832386377367470656E617046486F617569586C716B366F66506A47514742776133763841673476303633306A782F3841432B3174494962573267306936534B4746416952714A6B77416F34412B6C652F6D645444597669656E6C306C4E53746479565353545849326B6B6D72573772665875664E5A52537865433450715A7043554846744B4D5853684A702B30536263704A383131736E7470625A48326C34452F624D2B47503750482F4250377776385254704465442F435633624561586F56764A396F6E6152704A4D51786B3433456C57596B344147536359723568306A2F41494F4F724B3438583762723459335361435A4E766D51617148756B542B'
		||	'39744D59516E2F5A795072337235632F6230385633782F59302F5A6E30547A5A46303150446C35652B5744386A79746473684A0A48714167782F7648317239482F3841676B582B7A48344A384C2F734F654539552F734452395131547854424A65366A65584E70484E4C4F544B36694D6C67666C56564132394D676E7154587A474F79584A7372774538787A436C4B744B70566E464C6D61736C4B53577656326A6474336262395436374C75494D2B7A6A4D6165565A5A586A516A536F776C4A386B58647545472F64745A4B38724A4B7953586F6A6C50325A762B433433683739706E342F3841682F774A5965417458303254784264746252586B2B6F78754951465A677A494539463642752F5531532F62442F7743433339762B7A5238634E65384236623850727257745130433446764E647A6169495970474B4B2F796F736248487A447152394B2B43662B43636B4B5166384654504343526F73614A3468754171714D4252736D344172362B2F61552F344B342B4176673138667464306E345566437A522F462F692B3876327439523175574542722B35474979735952544C4B4D7274487A4B446A6745484A363866776C674B4762526F595842757246306C4C6C3533464A75545635536230305733587363655738625A6C69636C6C6963626A31526D717A6A7A657A556D347143664C474357727537333664795034632F774442786A70643134676874764633773575394E735A48437958576E36674A6E684763452B57364C75782F766976737A34306674362F446634482F414C50476D2F457A5574594E31346531324A4A4E495731546463616D7A727543526F635949414F3764674C673577654B2F48722F41494B57664648346F66476135384E61393853506856706677386B6B57614F7A754C665370624B652F583543566B4D6A466D325A474D6A6A65665776525069662B7A6A34302B4F2F2F42492F344C2B497644646C66363542345075645A6A76374F3255797978785358726C5A67673549587979446A6F434F32534C782F4265547A574578445873564F664C4A4B664E48615453556E3162696C3839726F79797A6A2F506162787546556E694A55366650427970386B7669676D334257646B704F577662657A505A39552F344F4D4A726E55355A4E4A2B464C79365643334C7A3673664E322B70327862562F58366D7673623967543976505350323966683971757336626F576F2B48353945756B744C7532755A566C58657937675563594A48423671707238722F324D663841677264346A2F597A2B476358676D3838412B473966304F336D6B64764E694E70647476624C42354147562B707875516E47426E414666705A2F7741457A666A2F41504354396F72776E346D3851'
		||	'6644627737463451316138756F705045576A716F5479357472434F565658354E6A414E686C4335494F5144586C635A634F34620A413453704B6C6758424A726C714B6F354A71362B4B4C6434335872725A5850613443347178655934326C47746D4B714F53626C536C5455476E5A2F424A4B30725066566158646A36656F6F6F72386C5032302B45762B436F66674B616278724A636F6D663753733435346A6A377A782F4B562B754548356975692F3449352B4F4C61372B4858697A7734585558746A715333346A50336D696C6A56632F67305A48346976655032736667613378712B486D327A554856394D4A6D74656D5A4163626B7A37344248756F486576676A776864654A50325A2F6A4E46346F30434C374E716C6F7A51332B6D334759346451694A472B4D2F7742306E41497A3059412B31666C4753635A3458672F4F737734627A2B5873634A6A366E316A44316E384561736C46564B6333396C4E785454326A6538724B5631387678466B47496E6D5746346B792B4471536F78644F7242664536627661555631636274754F386C6F74565A2F56582F4258763472584877692F59326E763761526F6E757645576A327A4F707752483975696C6638414E596950787236584F7151783654397464776B416838396E59384B754E784A2F4376696E397633786E6F3337662F384177543438596156345561565047476C51786131486F4E794E6C39356C73346B654E552F35615A515342536D5165507058626674416674472B562B7966345A3054545A5A663764385A6548624E376C6B42333246724C626F5A4762306467536F42395365316672326535356C4757634E3038317831654D4B554A7A3570585454546A4278356250337232664B6C666D6577734A697131584E4B2F774258584F7055366649753754714A70396D6D317A5874793331506A58777350375A3133582F454A475037643147347549662B75545375775034352F53767076396733344C532B4C7648792B493771492F32646F7242304A4845733338412F413462384236317A6E77422F59343133346E584E73383973326A36444674426D6B54475548384B442B49342F44314E66636E6762775270337736384D57756B615641494C4F3158436A7535377378376B39362F6B4C686268724E4F502B4E4B76486D64306E5377764F70553479336B6F57564B4B37786846526370625361307665567673637077464849736F705A54516C7A53697665666554643576357962737569394458723855662B433350773138522B4A2F322B4E5975394C304C56372B33476E57494574765A795349534945376745662F414B712F613669763761345734696C6B754D654C6A446E764678746532375437507366463859384C527A2F41'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'72425371657A744A5376612B7961746136376E34786543762B437350375433674C776270476832506843792B78614C5A5132460A76356E687563763563534B69354F376B34555A7236462B473337556678532F62452F7743436476375144655039465731315054744A4E74703046727063747330776B696B4C664B784A593556656E5438612F5269697658786E4632427170536F3443464F616C47584D6E72704A502B587261337A5045774842475A555734346A4D7031494F4D6F3872576E76526356397037587576512F4A762F67337638413635344F2B50586A655456644831545459356443436F397A61764572487A342B41574147663844576C2F77634E2B424E62385A66457A3464485364493150556C68307536456A577471386F516D5663416C516348697631536F6F664738336E717A76324F747263764E2F64356437665059492B486B4677342B48766275334E666E356637334E746635626E355A2F474C2F676E74346C2F616E2F414F4358507761314C773370386B6E6A4C77527031774470736F3871613874355A6D4C496F62487A676F7241487143324F534166496632522F69662B324C38496644582F4141717A775234613852573972357A72417570614667615358624C6C5A706B4378726B6C6A764F4153534D45312B6C582F42536E532F696A7166374E6A483451507136654D4C58564C6534542B7A5A31696D6142512B38664D5147584A584B3835394458774634722B4E6637652F6A54777050345A75504433692B495863527435726D333850787754794952672F76566A4158492F69556A3631396A6B4761563878774D31572B727967366B704B4E5757734C766D766133764C336E625A3771396A345069624A384E6C655930355550724D6169705169353059365473755731372B363752562F69577A74666677662F41494A67573936502B436D48675A6231767446366D737A2F414769524475445035553235736A6A47656330793738472B502F3841676D682B334E4272656F654635645675764465707933466D62694A76733271777348525A456B4150336C624949795650555A42466662332F414153482F77434355666966396E6E34696E346D6645694F4378316D47336B68306E53566C575757427042746565566C796F4F77737171435438784A77514258364A336D6E572B6F68526351517A68446C524967626166624E5069446A374459624E4A30364556587053707145724F7962764A364E5830744A702F6739413459384E635869386E70314D524E3465744771366B4C71375361677459747257384531663572552F46442F67704C38645069392B334E345338452B4964542B46642F3458384D777463707053785253334531363538767A4A4353716E5A'
		||	'776F487941646346734848706677382F61422B4E50374748374576774E317277563464315739306D464E6169385136666336580A4A4A62466A714C4E455A634150477854635659455A47656F34723961787852587930754F734F384E537758314B507371636D2B586D625454556C62564E33393639373771396C302B78683463346D4F4C725A6839666E376170464C6E35556D6D6E423330615676637479322B463262665838557632742F774467704C4C2B32663841444336384C6A3444364861654A645164502B4A744847317A6532374277543557496C664C59493559395477612B732F2B4347503745666937396D7A7758346D3857654D724B3430573938577042425A365A4F7532654B434D75786C6B587170597541464F4341704A484972377674644373724B354D304E6E6178544872496B5371782F45444E5736357330347A703163746C6C6541772F7371636E64336B35766F374B2B7930523135507746556F3572484F637A785874367346614E6F5267746D7275323773332F414D454B4B4B4B2B455030634B35587833384650432F784B6B387A574E4874626D66475050414D637550646C77542B4F61367169754C4D4D74776D506F764459366C47704237786C465358334E4E46526E4B4C7646325A35786F48374A6E674C77376652334D5768704E4E43322B4E70356E665966595A7858567766444C773562616A39736A3044526B75762B6577736F772F35347A576E7247725732676154645831354B74766157554C7A7A797439324B4E41575A6A3741416D75502B466E786E66346B36464A72452B67332B67364A4A614A71466E643330384F626D3363466C646F31597445646D477734484444766B446C793768484B734A6833444259536E436D6D6E614D49706333523274712F7741544F726A76337168556B2B5A727A32586673765537685632726744414841413755746366612F48377764652B444C7278424672396B326B3256774C5361623573704D32304C4873787633747658616F47573344476369756D30585762627844704E766657636E6E577433474A596E326C64796E6B484241492F4556376336465343764F4C58546272324D366549705648616E4A50532B6A36642F5174555679576B2F4862776A726E78426D384B326D753263327677504C45396D7537637278414E496D63626436717759726E4F446E474F61715876375233673231384B654A745A6A3171433774504346733933716774315A35495931566A6B4C6A4C4137474149794356497A7761302B715637323548303650726F767636476631374457763753505871756D722B3562396A754B4B35694834792B475A4E43744E5266574C53327462335448316D4D7A743554665A45436C3569447946'
		||	'58657553656D525538337855384F322F6A535077362B7357513179577A2F414C515779332F7666732F5037306A736E796E6B380A5A46543958712F7976723037622F635839616F2F77413636645631322B2F6F644252586E6E694439706677315A2F4450577645326B5855666943333047574B473667746E3253497A75696A49594448446867656A446F54586F4D737177784D374861716773785059436C556F564B61764F4E7462664E572F7741304F6E6961565232707954305430374F36332B542B3464545A4A56686A5A33594B716A4C4D5467416570726C50425078343848664566537451767444385236587164707063596D7535594A73724447564C427A2F73454B32474842326E6E6731452F77433042344B2F34562F632B4A355045576D522B48376163576C78655376736A696C4C4B6F6A594D4151784C7141704754755848555666315775706372673733533265373258712B684831334475504F716B6257627664624C642B69366E6D2F7743797838654A4E666938594E34763856576C376636667263396F7478464E422F59306B535274634A39686B514175713235557968797A4936506E465958374C2F37594E3938542F6933347A50694F3566522F446C7A59326D7265487266554C42724132746F39784C624B533867486D6D59694351455A413835564849723255655066424F6C612F705868763754704672665838666D57466959524748456973324647304B475A5135323845674E7765616E2B4D487843384F2F427A7746642B4A504561716D6C32486C5253757474357A44664B6949416F47534E374B666247653165764B76536E4F6346683365725A5238746673726C36327470357137757A77345965745470776D385375576A7A4F572B756E326E7A665A76665879646B306A6D2F327966696A714877662F5A793851367A6F3931425A367A694379302B655A305249703769654F46484C5366494E766D627374386F3235504172497676694671506837396D6255467366474F6A447876426F6E396F77336576616C614D6B426D5A68424A4C4A454244735A675552774E684948586D753538572F46587764706D6F61586F2B746174704D632B767172576472646B66365147495643564977417A454B4E324D7363446E6975662B4B58786B38476542504665696546626D32307A55745731362B73394C4F6E496B5A61434B566D387433556A4778537049553838456763566A68622B7A68533969322B626D7662644B326D7132566E6670646D2B4D743757705739756B7556517466615475373650346E6457363252774F752F744A5461662B78424E7276682F5664557666474D326A5730316E447161514856566D765A2F4A74326B69554C487A4953454F416A424163'
		||	'343572304C396D545576457265433776542F474F7152582F69477776485A6F4A4A494776724F306B4F36325736386E45666E460A4D6B6C426A424858424E62397038522F422B702F454F34384E51366C6F38766953434D47577A42557A414A686776546B6F4744626335554D44675A717834462B4966687A346758576F7961446532742B39724B496271614244745A6757555966414467465747564A414B6B5A34705969736E526C4255655737357232315364724B396C377539752B6E5965466F4E5969465356666D74486B3555394731653774642B39746674723330364B696969764850644369696967436A346C385032336933773566365665715873395474704C53645163466F35464B73416533424E654F2B412F3254745A384A332B7033456E6939557647384C48777270326F574F6E2F414765376A6A47504B75706A764B79547868564149436A676E6A4F423768525856517874616A46777076522B5366356E48694D4251727A6A557172574F3272583566306A777A77372B794A633652384D50464F69336C2F6F577258506962554C66556A3971735A6A6232386B554D4D5751664F3833666D454F4A41345A575048537655766854344D752F6835384F744930532B316939312B37303233454D756F585A7A4E636B5A35596B6B3864426B6B34417953656136476971784750723134387452335637374C653176794977755734664479553655624F31743374652F352F774441504D74492F5A78545376694E622B49427138724E62362F66363649667334414A75725262627938352F6732377334357A6A46637A34432F5A43314C773770506A61445666465A316136385936414E426C765774472B3063666163584D6A4E493236527674424A556256425159414272334F6974466D6D4A5363656273746C3064313037366D627966434F536C79374E76643779584B2B765A5750467669312B7A4C7233784F3054536B6A3853366670756F4A3464752F4457707A6632615A3435344C6B526235496C4D674B4F4443754E785959592B6772723476677A4A4234303137584964586C74627657394174744552345951487332684D354536456B354F5A736748676242317A58645556447A4375344B6E665258364C71373975364C6A6C65486A5564564A33647572364A7064657A5A344634592F597A314453766872343030613938547858562F347653784C58677333506C53577171504D66664B7A5347516F476235686773324F31653661704139316F39784742756B6B685A5141635A4A5569724E4654694D625772793571727672665A646B756E6B6B586863766F5961504C5256744C627439572B766E4A2F6566503377562F5A613854364E384C7A2F626669502B782F464E78344F74'
		||	'764331704C706C73735A30614F4D4F77596B4F776C6C456B682B5A5346776E474D6B31732B445032543574423842336D6B586D0A7332306B6C393470732F46444E62326A434F4E6F4774574D49456B6A737762374D506E5A732F4F665376614B4B364B6D623471636E4B36563366524C70742F582F4141546C705A486849526A477A646B31713331333637762B746B65502B4F76325A745338622F48725450467376695A6D303753722B30314332303661336154374B595935493369694F384B7179655A765A696862636F357878586266477A3464532F466A3459366E6F4D46364E4F754C7A796E68754769387859354935556C586375526B466B415049344A7271714B35336A717A6C546B33384672614C5333352F4D366F3564516A4770464C5370666D316574394831302B57783435385950325872333473654A70727336374259326D76574668702B7651437A3878355573376C726D4E725A7933377069377570794734494935576E654B2F77426C3638317A34774E34677466454D6472705635726D6E2B4962327865774573306C785A784346455358654E736249464A42556B4654672F4D6139686F72574F61596D4B55597930537473764C79386C723549786E6B2B456E4A796C485674506437712F6E2F41487061624F37504950442F414F792F506F66786C6A313436346B6D68326D7433766953317366736D4C6C6232377432676C567074334D4956335A5632673559416B68526E552B426677477566672F346B3852586E3970322F77445A2B734F725161525951795157466F776552336D574E35483253536277474362552B5148626B6D7653364B6D706D4F497152634A5052704C5A624A33583439647971575659616E4E564952315462336537566E38724C62594B4B4B4B345430516F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B41502F5A3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A202020203C456D626564646564496D616765204E616D653D22474443223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E6956424F5277304B47676F414141414E535568455567414141596B4141414277434149414141426B565275504141414141584E535230494172733463365141414141526E51553142414143786A777638595155414141414A6345685A6377414144734D414141374441636476714751414144496853555242564868653758304864427648756658764773654F45796632732F33732B446E4E6558486569797A33'
		||	'48696457584F53344A533653374669793543593339643537373533716B6C576F4C7045534F394649414F79396F5A42674A774743424373366F502B5375317275446A70494B614C6533484D50443767374F7A75374D33506E2B3662742F377449515546426366574261684D464263585669482B504E72565A37426137692F3248676F4B437767502F486D32536170714E4854623248776F4B43676F502F4275307964426847337573734C6E4C7A763550515546423459457272553175393855464D65706E3169716F4E6C465155506A426C64616D677272325838345650624969565539394F676F4B43742B346F74726B634C704848737937626C7A4D5134736B5653316D39696746425157464236366F4E695755476E34794A65482F6652397A7A367A6B3073594F3969674642515746423636634E6C6B64727566574B53424D3447325434314F307A65774A43676F4B436739634F5733616E6C4A31342F685952707575487866375130596465344B43676F4C43413164496D2F54743174387345445043784842576C496F3952304642516547424B36464E4C7666462B54487136336E43424C367A4B38766D6F4650444B53676F764F4E4B614A4F327165757547596C3859514C2F64376D737363334B687143676F4B415134724A726B3850702F7535344553464D344D2B6E4A7970314A6A59514251554668524358585A7579713174766D78785043424E3433626A595456496447346943676F4A43694D757254534B3138565A767773547777586B696C623654445570425155484277325855706B3662383932643259516538586E6A2B4E6864696D6F324E415546425155506C3147624573754D7430794D492F5349344774624D32774F4E33734242515546785356634C6D337173447266324A464A4B4A456E373569576D467265776C34544970784F432F754C676F4C696D73506C3071616F77735966542F4C5A303854787575396A506A74633441376463716F334A4C5A3361746C2F4B43676F726A6C63466D3171737A6A2B76694F4C6B43466676476457556B46644F33746C454843375864554E3578573558396F6449567846515545787348425A744F6C434562766651444338626C7A4D56354746727542734A37666257644D5148534E37766B433948434C46487157670A6F4C6A6D30502F61314756337672636E687841672F37786A656D4A47566542356D4736336F37726833415870302B644566367070504D386570614367754262522F397155554E623030366E42476B30632F37346A302B37305A7765353345356433596C6F79524D514A72437467793456707143346C744850326D52784F4E38503057686965504F45754C334B476A595744376863646D3331415536597A6B75'
		||	'66746C674E37446B4B436F70724566327354564A743835307A6B676A64435A4B2F576943756250617955612F545A564658376A6F7666596F524A6A417539613832657974376D6F4B43346C704566327154772B556166626A674F672F52435A346A3975656162553432756834346E46316C7568313859514954464B2F5A4858524C5877714B61786E39715532354E5733337A41725461474A34342F6A5948616C56546863375A7564306D6B764C74334375484E556D436F722F4F2B673362594B6354447856516D684E47507A5A7441526D70726A54615333537249305350305949453567676635564F62714B67754C62526239716B4D35722F6333597949545468386146466B7149366656375A6F696A7859454B56474D616D7647437A3055386855464263792B673362566F5772373168484B6B793466476D535845666E346B394B6E6D4E6B43534F55654A4875797A3055776755464E63792B6B65625769324F6835664B43496B4A6A7A644F6A487673594F5948637457556C50334852433853717353787554574876546346426357316947433179653057444A38524F4A4A56642F4F45414E7568424D50727838634F32705078766C7A396F56497A54466B324D3258376364467A68436F78314E5765594F394E515546784C53496F62584B3672455A544E76755042397A7569332F626B6B366F54486A38593051614930774D4955397A5A52744F6978346E68416E4D4C5A3376587934704B4367474E494C537072594F6462466D6E612B3174656D56706D4332512F4850363862462F5063323551654B586D46694F46785A756C6932364B7A6F45554B62524F6E2F6F454E31464254584D494C537070724743354B4D44793032492F752F45474D6A432F737933784B454D503132592B7037716151774D6678596B6264524F70625170696A78344A6132416A59464642515531787943307159433959706F79524D4E54574C326678364D6E62592B546832414D5031797465786461526B685358782B4C706363464C394F79464F7831716370523046424D644152574A7663463133537A4F485167737A434B55346E75643774514870746E34796D635446334C78472F6C56784369424842595572316C4A543970305743655A6A4A61653959625531734F69676F4B4B3474424E590A6D733655684E7156374C502B4337466C447334493932674F62302F564B33337242373569584E4453686D464169727879684C4E34672F596176546564456A3154566E325754516B46426357306873445931476D5852456E616B4C44566E744D336575776C635558313777432B702B4F46744D784B486E43386B4E4D675050354E4C6A346B465577716B6D534F73396A412F6855424251584531493741326C65'
		||	'6B697A6F6B474D566F514A5235635572375235586267754D7439636434464E53453377664E48552B4A664F4A6C487149392F446C4F714673735763384C556B353548796D754F39437A6D6F364367754B5951574A765338722F6A7930474D374C6E71686E5075693236543254356F655171684F454879786F6D786A783349394A7778454A436A46476E455A50486B744863367569725A74464A5155467772434B424E54706331516634715877764165506E66476F3070596E58546A654E6A4364454A6874654E692F33395673552F55304957706836716C30746E38784D544A5271555837625936614C6671714F67754B5951514A76614F37584D74774D49787374662F2F7034394856684C65363964356E304862472F4751502B2B555771364A546F535835694C6B69667257324D705A34644263573168414461564B7550383770527954487838352B496B68356347374A5039354F5A69612F48427A557735357671625A4A52524871533074366B6E394B6B6F4C69574545436269725872755935775071454F30496A3355745744393258634E436E596F626F624A3861396443626651327443357054557657644570474B6D354979322B706935546B46424D654151514A75556565526945664373364A465A4B56735A6D6668416F52345358586A764D736E31516651392F576C334F6E387062396A38524A455636624639437579376E4A4A5A446D63586D33514B436F714244482F61354849354568526B527A67594B66377A3533494A58797A2B49565539637A546E726B576947796636564B6A37566B6A2F49565078722B6F4C4E30732F4A314946526F73664B3961736337717337414E515546414D57506A544A724F6C6E766A41436350746B7048446C46343673392B566C6A312F505065424E624A62707966634D454567556A2B656E6A43307239314D41734A773839796341497957504B36753345323354364767474F6A777030314E4C526C5259724C2B6E78554E6D7075796756414B676D386D6C5434546D6633627A664937356958664E436B4F3774375452334B494D48336B6C2F4C454579497641346A6742656C546466703439686B6F4B4367474A7678705530584E55632B4F38474F694636454C68464C343467634B3954766930716D793876303677375438366F0A2F537445534173446C6357667144324F6547346A45704C375A31714E6E486F4B4367474944776F303375664E56536F7336447579544450314955455572686835507A7170707444706662336556306C625662396C515976736E5244664D49466759335372346D30735A6E61765A6F75374F546652514B436F714242702F613548613746486C664552556558437862516D69454834374B4B4D3973466E7A6B30'
		||	'754632313568746836754D59374E31524F42514F54396C465A45325075474E61716F50304132654B4367474B4878716B38746C53314B38515654346B36496E78365765496A544346324563376172514F393165706D766A6F4C7244736B6256384846362B463765704E52447849354F424F506C517A713671746862556C425144436A34314B6257396A4B69716F4D624A64384D55775331334F5266366472557073443765554F34436C75377667334C68686F707A7A7771666F6C49496348596C42633671547852554178412B4E536D4F6B4D6955632F506951624E6B573069424D49584E366F62624B36672F436D59565A576431736E355655514D41546C635765616E4F35786A53666B6D39305871325646514444443430696133706D6F6655636C506970372B5268354E4349525866704F6A712B674D59574D41794A4F75307A497872354B494A78425675795166456F6E3070496875335574424D514468585A7663626C6542616A6C5279512B493378696C53506351434A4C44307A5448613477756239314D666F4451716E627A6C316B565247782B716434692B5978497043656A784950726D3054736253676F4B41594976477554792B31494C35684156504974307339474B414E38644143636B6C396C734E725A69454B45324E44326353687A6F4E5A4C76796353365A563539454F62464251444464363179656D797972492B4A6D70344D4C4D486871647034787462325668434236796E4C6472473447632F725A4A4F49784C706C654C30392B6757425251554177766574636E7561453955434C715A7A34674754306739536B69444A2B6355316251372B6D53686D4F794F38626E42646A79746C4D37674A3949587A30756662476E4C5A32394151554578454F42646D79785751347A736558373150693536396E4F356D4A4147677350544E48444B32436A36414A452B574D3875534730436458556E324E677042694336624D36574C6A7566566E752F6A623261375A6378386747484E6F75442F79704D654475753050714F2B77766574616E545842556C334C7874762F69745478525A684451516E464651335772766832346469394D3172366947694E77726739656D664E585348706552596B426957594A3230504955506F396B3172486E2B6F78744B565645350A44396B3946766B5679484B6D37724F356A6565345646527758354944547230337534632F71743463623153322F54765766766C585A744D625556453364346947544E43475743546B77734E707636712F51706A78372B436D444B2B566A7152534B63767075562F657A6E3264584B37325661336F6332714E6E535736566D57473773613236303433745071554533734B37343755637A66636766634A4F6D33'
		||	'6A2B764D6A79452F5A625A65724750503951486461306874546D4F6E72645A6B55563071474270444A346F4B436F626C33326561625A4656336A49703771594A73527A66334A48466E4C4935585839614A74686F2B78665445347361416B2B6976687A77726B324E52686C527431664B5A684B3651504472624A335232763364756E364232656D434655626377704D6279532F392B71513063376A4E33672F2B4A6765627735576D4D7932493066786A562F596A4B314C756E7056302B3554346E317A695436636D3344636E2B64475671662F636E54336E7645716B4E763462792B49316749476C5457694F4642576D65526655622B37492F4D4D534B616F33567A62773439375A79592B74545031776238364B5243324351513759793634554E6B6C314E776833715232364C5A4D3535616C4E53484E65625839576E4F4468585A747147714B49756A306E4A63434D38414F5654663172494D513374673550492B3869704A65504776686963747262467175656A627076304C6662566965565037784547737732784178524650616E316244585534534F67614A4E4D4A53513058434672683858564E6D346158787351643256746B7043307159665434724C71626D61744B6D693567692F59703856445A715147756B68446233384F45316230646E50486C4F4478665A746A76393164716F396B6E2F79302B6D48695972587538783956516572773355677666612F463074442F5444667A524E69542B5932734C465168493672583576514C6D6458743736794A66336D4353463868662F577958455678697539772F324131696133756E497676324B664551332B557037674951323958464263612B317630395470646D2F534E424133346E4F45737553512B42562B4F76327737397255616E614D4F316C382B3551456673357852496D4536583766484E483963305477357641624C6A33332F54356B63454970585463545071357962594C48454664692B5031694B5245507835736D784B493864484E6948463858666A34393064426859324F35556A6956312F445854576B76625642796E4861326A446D46317663334338526338734372533576634639316C4656763446667545364A6E524367556844587847312F64624C7A67663071613245623764756C474B39456A780A6E2F6E70394D4D2B61684E7339652B4F4636474538624D4E684F6E2B77447A52703466794432665670656C4D734D2F422F4C7032706335304F72397855617A6D3161305A2F7A6B372B59357069576D564A6A5975697442784E577354536E353670656B505337774930302B6E4A6A797A566A4835544D6E65744A717A42593152685871556971327979732B4F46507A764D686E6175562F4F46585861727653'
		||	'4B425A76443157357838496E697A5A79434E7633585042482F4556446D4D3676436E30336446336A5870744C795466794B665667385A4B5169673541476A682B6C6165764D6C3058376138793273646B2B563968394A59382F4C6E71476E30342F374E596D5379306262346941756234717152782B47542F50514451705977376E6C7A5A322B4A6E2F67584A51574E2B2B54715372616A477A6879684378395773545856746C6863334B496B5972683858382B773652585352486A57664453644553356339706C692F4F45357A356676432F6342546D304130744F7A704B347567744B6C6E637050506A78484D4C4B693242376364537169774F46304C664539306D70423631502F65636E776D7037316A7352725965454D4554423430674553473354346C666F7573306E343146617872474665744E714864676B4E306E5566503930663763397438714E4C566A4B74656D39797549733171667358654A666E7759345850372F4565726D713666424E3444756961694E74786E4A75796E7039492F35526D6657515061773642772B6C2B625773476B5673335459696266304674642F624463305064797653644D635747694E5371785848614254467163466D43396D423672614B697054335174417959624C6A38524737443671527958416A37376D68326E565454724E5A332B6D7178475344706461325736454C39656C454663394D566965575257665635745732773964684150674158514B457A7755395A4571645A474B754752703872614D796F4D6C57624C47474C645832623958795248714B416C43794D55572B53364A4A55786F354C6A782B384E75474656426A4E5A2F49623179537A7A37557171514C7670376968772B48447675324C4E7546317757636E4C6E3968765A4A4C65616877756433564C655A6B6C58462F65753379424C59386742764575745035445156313756357A783942686979397434696857477A7574724A7657616E626743504D325475633151457A3137626245737437415950366C7355492F326F5358563937556454796E416555455553475064737572356555743569436D572B4F6D46635975654C573854436B2F6C6C4F50782F47564B5942336253725772754E5837416A4A7878387043676C70344A6A5463686B48476D53477475450A6564325334526A714A6E306A2F444876755A58716C79624F62616369576A4B612B6457476943454A36356C355177664B2F62336279625A506A6278675865393234474934336A6F2F392B6654457753745456696458314C643653626E54355A5A716A422F737A626C7654764B504A73624269574175684F3935783754753256572F587952464A55463559692B34424C666258644C594D65356B386138586947'
		||	'2B64484D396432484E74334E307A6B3137656E48347974344872672B44445A4C6276566C512F7655622B692B6D4A5343467A46574B416533766E6A455155367A38756C5831336F69676B5030586659563059712F6E3959696C65417063592F4943742B7451612B616D38427351576A4459784932566A44686367475567502F376E77667536646E54783065325A73695148566A373367457671695462505071363454586E764C7844684941337336464B434E675143684955543638657A633632574978376C6C5574773973354A65327068324B4C4F576148686969773233542B3264587663664D354D674E3268573456512B73315A782B355145356D3238465A4746596F4D47435A6E464251592F506379754E76577154536E6C4C62556D7936545470512F4D4665464E636B6D366F6165496F6F79684A664238717779514B626B31625A2B786D534C495830534678786D794F5233703856706767764C70746B70472B356F552F6B6D36316E51354F2F4E55375A5A52476558455458756F33694D4F646749426D462B327550764A516751555A4E4C7045694B72554A3950357A5779496349464D7550526C594C42576C3945475831355531706572574157444272506A524C6458544D53696341456F6171365A6B452F46327739364D37445332516F48305267506C4665767A74655A4F77553643394D6D772F33356751634933397457305A41793474445659735A466362506E417A5555746851583059574573634A62634C37334B4F6F2F7456384D614555424B48616338366A54416B7164746A6131474631446C365A536C794C7869613842576866527862367A78534F554E34766A6853306D6E7433496B4C31356C2B4C6D702B696259374D7272393756684A334548787A5237633251557167432F7A6A772F666E4D76463431615A396154567637636A304D3250725A314D545669526F4C52364C2F42314F4632543077666B692F356D43776A6274624B6D6E43397858625A7155587856575267514C76635875645A62545345566D7050684666694C3973377A364542746A4B4943392B76677173764139766B7175622B2F725A4334594C37412B6D416952633669636146575952677A615230772F41662B3851566C6A5972635368574C756B6C6354785176455651793559760A54544B516C386655456A426D473661325A7665555742787533756D706D496C766257536648384D6E546A684E68766A68655A4C30316E68786B4645534571442F376C627371642B7668416E6839446E512F5542415247526549695A496A59384851515165625548564D5442713067645A797654626A62546E6E563756506975624E344133695465436738476D6F796478794558626B67527350337838505770'
		||	'7579614E714A3551494C68694C476E513853557336566350486744734A4B593867427A30744E796833554749347437426B4B625144684E6E6E4D6177744F6D4A31624A6D524B465573726B43334576384C597038556379362F69356A743948737571516543344D496B4577354568507067674B473579476D56466C6850486C525A73517255713367312B782F576A546576586C6E564949663954723470587655382B63456A334254365166526B73654D7A51723242684451554F626C562F6947583456576468334F555945335658392B786734583538637A49755156346E5578717A71566C4369615636527150334E516F454A67454B504B6752467737586C78693634564E777045446E392F70366356596E6C4779575647795356634A4651353245632F584B75794D354C613146397832393573316451314562737A303352747453306D4346387953726A4B3176532B63336A725A506A554C7877495736375656624A4857654951677A48454E55594E3858664B57644B345454644F7A734A6C6962556B376D6A6636435351426E3563614C5150377845696E714655796479366965664B666D46443975517230314B6E656B2F5A76514B4C73546F71364F464F496948676C3047662B66707457777A7742447466474A5A3733537A734C58706545343959664568492B4A4B7768787977564D6A42715474377A7579316F6F713448356D566E575842325746436372372F486F6C50327441764B6A475332306B386F3751697763384A41594D543574413342712B4955783158487373707837354474456B776778616E6C4C6632727354643046642B353238544947596A6F307356465A30467A5A6B43743753587A616C635764423546704D73594666627278726B365A715037397562354F4D484B48302F72334D794F724C7532656231656C61576C4A4C334252636B4C4C79724D633368333078586A366B79317A4E7868674B737174622B612B50346659553778397551554652365474395557336F4A4761794C49375672424E56364E74746E6A555A2F3163597A63514D335438756C5345777A6D3455362F6A48775A34527739355938414E7877756A54474870586B4D5072655739334E6E634A784735735A424852646433535A583978765741342F4B6B31636C684D384E4765570A7963346A714B6656397647547A682B6F39776A686A715468587765623044673137655267777776625579723556324F4F4A57366C67666D65716B746E445A5A48433755572B34344C4934464D5772697557446E2F726651694868375A786258695275324E6B464E43455834326253454D6E3259712F616A43686F6E6E437052473772775A6A786649507A51346674792B6264445A5934715A50735755737062'
		||	'5047305A4547335971455035634D71674265634B47754E4B6D3943386861704E69486E4D6F514B543263476C43676D4575454E472B63456730377556624331445558396C53322F6D6F724174697455516E6A377179784E43702B533162526B64504D2F4F717A5A64314E5564353966746E64336638693067314145637074516B6872584C70614864376768756B41747659595061792B7A773446665367664B634D5936777676474C484F572F4F78424648316E4C6E6859434251744F68432F43506B6F73452B68346878582B754C2B584142486B4E38736F436A437063414773582B34675178786E722F454E32456433544F7531516536646C567A614B5069734B594E446D5858386D56793354306D51714A7368543739664A4B6A626A36314B37654E6F5147577A47612B46482B66507079636D71636A5A3836696D7341634A3877546B74436D3653482F7A784E367A6631676951387A4D4B5437574A6C6367373768676438394B7972323068445673625A70326C7379494F32636B4D75314847494449456B344E415669436648735A5A6A586E50337256706C3876454B4D41653862705835767546585A526766414E74515A795241555663394B5A45754B6D372B2F4A5A6F723068574C395462782B5354514D745479546967484337564A55633248413236636D77427067542F7653706C7039444C3975373557382B7939464871454F344967306258707A7948556571642B76614F71772B73734750694C4B396352395031466B523470433647777131713776655255684130304E2F39324238507868624C4F6E68666A73534145526D453963654B45344E47732F7462774675635846634F4F343242387975716550376B69743467347952497361634F6E4435444F3933526E676E7A6371766336424B4B3576763563334B4D3555414E6863667856613450444664736D727651367642496D6F51763250684E3371335550764E693944377A4135506366704F573336364541752F2F694865334F384B6A3738493337484538527572354A644A7843324E6B303852593654514A737533786F554E41612F5779686F49623435587353633874516D504F416D7163364C41655A586D7978324632454E67642B644B50626168754B563872755477502F704E7532744B4257662F7044500A502F374A775479765255577437795336307262786E424C763271513370764C7239672F69563063714D676D42414B464E426130685479426F614C562F64714443304F476C4648724650703242754F2B45314D6A546F6B66354B6654444B50476A686D596C47316549514A764D6633476748346E70697A616846594962306D487433676F4B7551747A7437374E476C326F4A2B5A384D6856535A2B7769786C39'
		||	'75474266377A73347347414B2B706C7735584F374868434E4B6E78374B523848314A4372415134736B2F4A447637386C42704242456F7238445A73374357445753697176434150785A4A4A7366346669544A6577354961413154363457644269427A4B7577324A3245787A637A5373562F484937317264593770676C653576636E69356E347739616D7957653861464E6A754859544830677773677A6D6171765A67527A425332356F74785933745039326F5342725074716678345433314361345A716A357A466B436F577154723258714B4B362F4569362B51367457564E2F5231476B6A7575486E5856436A68504F7A673247723259355378412F3578644643726D6E78726B327437615838366E3163394F786F685A495143424461564E5157736A614A7974722B764B716B30686A73554A656E4E7132555475636E7A7A2B543039344F2B304D47734B4C354C77354543574336687A3078376D51785447364F5035346B61464B3861684D794159565072477065477138646554415074736E676C616D2F57796A357A514C4A412F4E456949516F63457858462F4A7571394464593469534D537461565874704F4938504849525479512F382F4872465A716E4F6B36755379753852436839454454464142595A7354696653632F32346D4D64587977396E3167597A41593841596363685A72547A37446B506F504C7741344F4D4E7457594C45535333746965515477525131682F5243502F646B51574B677769435675626B47764533564778772B3576596744504C722B756657744B3564686A685739737A34516F7779464365666A56665048644D35503462696E6F523574776F636E7376666B50535A74756E68435835574D3948563765733273562F4D433354346D586156754B477A71496E764B33496A4B4A374743344A726D63474774366656734753686F547633647436724C55525574365238466770486A6468774461564269364E71324F622F6A4476494C43756D44586C7848614E454A5266466738684574625142616F56726A6459626F655653316D7A3256304B78504C32644E437746667674446F347A6A3276346C2F6C7155306C4452336A54785866507966413741382B492B527358794D7131525A5A7065644B4768414B745342475853643037334E71326E370A4F3632774B69622B637933376472376E542F7637756245394E6844333131477235735A7A36344B6331415639464676456A516133623533754C71322B5043774B446A44624A4B3171493438487A705931707A41794A734C56706631724E44554A4675485653764567565A6B4E6F374C5274454F7365575A464B434A41662B74476D35395970596463775A776D457045316F49497671666534775259786D6F44'
		||	'314F4C477353715A734A457A74345072644F67646161696479374E746E7370726A556C376E716656593061464C71496235414D4951327054563736552F31412F676348305A6F666A307A54366F4F6467584A546D462F302F65707038344B397A4C3377326A785938327437487350412B305778304F4C42565930434F665A61343847676356784776355666473343356273563162434D69437938665572437730746C734A372B75547637677A30355137646E45684D644F57304345496C4962555267784D77504130492B486C3469505A706478376C3461547154703630654A4E46634D35454162525948664445303430524E41464575345663574272315432686448424E4D702F57755472336E6853536F6A63547834776E4A6B526B37443169615A74706C6F487043685733786266333651566D6D4344554A6B4A525145722F71464463713364326168504D43354A6A4B52307961594E6B534F504C4E573457744258386A6135487450586B4B6262706B5946316469694374703468384D69552B746B62643073584E4B76577554303257525A41672B3537314974707776454179484B545768666F327575645078314C4C692B36666C6E73706874302F334437527247336D374F413154717464494A2F4D5435702B704F6150746A76427462506A38493457396575436735536B4E62594564556A2F61424B2B51373262446276726449676C71694B4C43424F634C52516F75456B714A56454D57666234324D576A71734B4831666D4B56334E4F632B656E552B4A6C524B735344594A6C56725552767939327A6B6C4238672B485162526E4D76526841453073614F3661644C5955395256683833512B7955424A66596D42384A66385966314C51575150336345657139386B5A4143466B494B4E4E556D307A6352797049744C76693138654C57426330624331716248645267786667752F75796D5A5042343353786B34554B76374C76484E36347068444262456C6867706A462B6F71557837715736305043572F4861564E425866746C30696155775077366E32624553384952456E6A4E457255787363784946417730772F77333734646A4475647A732F6139613550623763676F4648776D594C506B43363866395431634664715761546C566E58446F377075617531305331410A36354E70643757576B6464377565456271582B416E7A79304656395766444736486A6343717667636A3148302B4B4332595453312F615A444C622F32655A6A482F71385657704F5457746E76575A474B63445062574A4152527457594957416B653441376A70306E677446466254524861662F2B74415870664E47517939396955687A76524B4530784931434A2B7443445551616B4C764A2F587641737134'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'73557569644F77357A7A77566B51575079544961424E714E58463836746C534976322B694872494A444A7362554B4F6A5435454E6C316F4139543645446F36454D6E5878346F677A56774D64383549504A785A362B6B67477A767356313662726838664338655A4F557641356E524255766D425957526C564C584369494D427854382B4B30725661535866763164796D514A343179613873574C74426E34392F304838326968354771635248466557686661316E4C4E354C663831505266614E503963554C7370745475634D336E7A7771656C3775476E796A2B5430393632326675364C526163646D4C6148766A793576546D726744444D6236304358397635755563536F6D767A76586F51763074777655577672514A514935577470692F5056354D4649766265766169682F4E436A4C344E325A774F665745764468654951614A70666D3664676D676E2F37596C506542436646684A684A4B4F504E6739644F674A7138503176384A707143436A5461682B50785061677838647941764761754D6A62473043346B734E654D5038612F4571506A325548347A587A38445961587477766D436F6366546841712B58567A53623735386A43486B4674416E636E2B363971686F36625044332B53466848326B4D6E5A34444C324D4F46345378515955766262705932796959346E53362B37752B5872594D2F7A706278313856455241626B686F68544F445951377067386B3976375631504E304A5A4843455A77552B566631625552444B4C50506F4935413152692B42415454395835722F72313563324557506E643831497976577835796C4D49614A44796F38324D58413458624F6942583377344A4A3444643443345A7A2B352B786B474650735A583144593575566D4B43416F71384B4E46776C56687635453435414E4D4C477A743731717879797139746753764244676F773249583966325A724F502F374870544B764935562B30426474516D562B6233634F63546E796431744B5A5A41536D562F587A766663595541786A2B614A684C4B6D32345262516C385A62594B4A3766565A346B6F4D52447950723078744E64764E335573764D2F6E487553554E4963476E4E6E5630566B614A42584F49316B676E446C655763717245634A68535539555677734C5869636571470A47333649454C545A5173737057587435704758396948344E7658736D61436E4E596E532F6D6C33424E73763678396F74392F666E6533703259302F5765786E3061387662554C4A3479734F585052346231754A77394C786E4E544461424D3033552B3554796874756B6D6F704850507178442B664A47657633674E61666A75524C482F3167773334674C3443596E4950786632427948796B6F59416779524E'
		||	'48545A34662F79726B4C7A4937487232394355676372786E767376446B4B76414234517442356F4E76486C6638377759774E7A6A323478393053594130766E67664D45304878444659315A55575832723155383634424E4255304243447161644C57564438494430666E3238694369456C304F625042664B77516A695439646D674C4C78345635795973635852777159357A3259587376504D7678656D566765734C415268727850625849364C596D4B6F667A61666C673835484F3568464D6C6A744631516656714D2F686F6C356252706C66576C37563065682F6A35454F6B62345038345337446C53587270642F78302B4F4855654C424E593058656879642F6F477532667A73576757522F5A4162794D6457575756686658744C6C783053687263506E376D2B7A5A7066322F375A59594764776D6C54564B47653739504242526762575969726D4273785146536F5950786744426C746B6D6D62596661667957736F4E335A42776A695A77672B30546C38654A62754E6479753672304C493134536A4B7044466D56466C4E53594C595633696E336172493675716466713555715A6E44514B78494561394B46596A3037593074466E35685178464B71656D3757486862746E2F4D544F707569574138594A37666E49776A334147423639497761766A5567504C3948426D3353383875725241547074614C593548685659627771394930434B646849446A5837547153703370752B4E462F4332572B71684E654150373032714A4F59516756504A5079314D57784767537935706752654B464D4651624F6C4F304C5842703334724951766D70616A595430306468684249374F4F50396E38317668496E4E44776232757A615A37553469486842354E4852626873625178623150535039655A5130786777394E79376B43646A6C5863366674616548554A37776679424F716871637230323578704665316A6A745A544454535072584A6664476456535359346E6857394D684332597068536A56666D4D443552625842753356444E3555783276544D38754C713567426D48694C645663464F4950684B486E3869364E334246626C664F6C333976485141687343517A656D4563776569434B4C39663236643474316457652F7679526D364C524F2B4354776D49767335625770730A74784B7A6164465366584F73434E572B724F665472784A4E3878644843794163734436497172745A326C306844325455346A6461356F6357535637666C6F464D585269726758424D4F6C3379776E6F6C63562F3443365758544A6955386D61696855666948316D5267686832796173505A6453422B44483958426B637066746D4A794D427A4751754E476876624D3945715557316633524679676437637942'
		||	'7175434D4561387A68676F635753596C3076726B6A6B3142627230685747596B716A5673387645514758555A4B555070482F5A4450424D4444456E5747372F68634B4E4C664E564D517A7930543435356149353938706853524D4D38566B567146392F4F5854576C337A307936666E7A732F7654652B5170393143594162516D30786C4D37514351625766447242574938463850664C4244664D5332524B556A337A456F7964646C48374D2F6A5078307935645774475645462B744C47447053487A4B7257426248712B2B6149594830514C3448544A756764595671477255333834794243496A337755676576544555782B79476A446B4C382B5A45435967515A2F4D7647744F5A4C772F2B6F75564A4E4D39476F494B716E5673755243377355624748624B612B476B666A79357653375A7958683062594C4232703961684E51575866716E4843742F3048783632506B4B5A77714D66776F5461734C2B754E304C3638745A6254705477734B692B7344544C2F73644C686D46335A33684D4F5858434D4C397650694D536E506D397259645562396939705743334C46302B674E68707732416175544B6F6A4341614C36776259486D6335736C4E3133646D5954412F2B6F526267634373552F36496649623967496E4B6D4D3576643058734D44336A6242384D5770506634464443576F486E484B463338794A534849443134685966417250655765494637493138634B6964664F31795938467A5449717A5434496C39392B71354E674D5070507046542F397546596B492B2F42505A5864647167536C48644236444B44436F2F7769415667725344384A792F383043775944475033657A387857715465624C7045316F6A312F626D6848776F6536616B5268377158677A67486C30504B664230357A3077795878677132762F476C546C36582B677651705963306674467736653568537864636D634A2F4F774E7569777838346258706F647235634736412F534E74682B53797A75374E7072447A32684F6870595571384539366353686642586E385A41414D2B707469414A694A676A534A343034547537576D595347784F462B774F596B434E547753475032586F734B473935522F2F356E67523376495359552B574C384C712B584276447248484935436D4D7A322F58686C0A6B46667230555064757262414C426930587A487677785A394D6A742B5856684E6B5951424D5A6A73384F7A387645343032724C503053684F786159486E466D35776E574144387350343461776F396F7473514C396F45774F647351732B745766443434732F6D686A4C444271677A534236332F69454D4C32794A623238716573667533703375514668426A494E7A2B58544A746A4646636175763234534444'
		||	'675168426C344D4C3357712B386B307A512F73694931794D49323858514A366864377058397441705435337843562F345434476338427538387A4B2F51574C794D736E754330365948706564483541623766634B36755A526A734D6D586846736B5852444A384D533376573164592B344B484249684C5771567079706C534F41356F3349694643787852584F43452F33477037463848383144344C4A66326B415451314365564E614646347073444B494C3439383249544F516F6B306E763773714775637352566876633964547946747A367654303554363657337A4F7232336E6B7531536F3533664E54486F72496774334A446F584F6344684F7046622F38374F4C4D534A7973396443794B716D796645336A386E476337704F6C464664632B59462B796D694E5471735A46467232334C784F4F674D656433743364664D6A48756434736B38457A686867537453797773647564755A66555471314B4A436E507A684C686E31737250354458434A454579486C325A796E385643324F37545567433756594844436A347558664F594A306D6A6B6A6B6A7962455054685039485A45467677762F694447717152796673776748705939467A7151737A716A47653750732B735565464845656D614F654F32343066743763706A565258686E6B41446F47727738767371676C5870735A53703848334F506A377773587374504A393450737A41466B64777A752F63344F485237707138505961434E684137794133385657636963516C37776A344E7A7A6E65766E555954736A52652B37754667676C305542783462576A2F636D7261664253306271437749564E6532356142774A365A676C78475974364B794E77697253536D4E4166514A7075394C564570364245487A346F47625A5A2B2F6939464C6C2B6576736973434F617A34352F734B576530435677565277374B3846485362683664576636705168486B7675447871533833476D58737852515546414D634162514A4B4B335947695636684243434D364C4271365654594E487735576D747172374C377A41684D5031554E61644E553035552B314A62784C4B33776A4263576270554E762B737839303947534E3772724C75524E687265696B6F4B4B3432424E596D733755424A676D6842574350504530647275686479440A49695452506259494A4E793137704454746C687673766164506F2F52572B64722B452F2F4E31746D35633676486A6F6D654A2B336F7957764B45756E4B50322B3364677157676F426949434B784E674B70796435545979394A2F4F48656270462F796E54743459566B742F69594569387661666A73726E39476D643761712B5630776642796F4E4978527950654C2F303763305A506E4A553971712F613771'
		||	'444252554953465471757A714D3563326D433239573449336F7332733750575A412B6D443747787A6137525738436146687352334F6C7934336842725A6E5955677242616B30326E4B6F3057766D3934417943306961627255576136583278434F52706C2B54446E74326432486C50332B64576C7262356E42785133327037664845526F30312F58594F41586D624236447174597A4F4B4E306E4842767861415679356970716A4C6C645133664155464251457441627265397331344A6744465331645A414D50765A68796F7672393752707554795666514D6A522B387266324B6843344A5778676E356B6D784F52564C323557665668684561684661775767476D43342B3974562F397458656D455931566D34554B526F4C514A6147675378365338514567447838506949544E5349726A7570306C35566357745A71395336335264484C57766774476D5A31635531356E49475A49326C3374645766555332614B41752B374779312B703038645469346D43496D7A73536A46387345505430476F33646E6F5A314D335164517A647148706C58576C466F4631716D7A6F6362323952533154742B6E5A376D305667634A5131574A3566575A4A5833576E736346694670706D683366377733494A796731577537586879615646746930414E6774556D53454378646B4F302B44464349446965466A322B587672396C2F4C4559636F79794E4F34334D7130356736484E317677554A72787632626B515A73655856796F616853736245446F704D615765616E62546F6D654A4F49586370413434344F6D6C677A612B553142305265674D6B4955557454746E6A5856345853506A367A634B545041744D6D71444C427975376A4F2F4F71474D6B56355233577A6C5667445839466B7853334F354C5A346469356E566E592B736151494E70644D302F37587461584E6E51493749316874416D78325533724265474B6D4F4D476A34722F4D6C363336524A4544462B2F546A504A54746330576A354737716D62723038754C6F55312F6E462B514C587A6D696B374C6B7653444A2F327554596B534438346F6E4E786C3854662F67494B4349686A417A506C6B542F6C6631705155656579526E5637524156395033325966467145396D7864677A577879616475664668624361787437530A4563345135436564596B4E5479307250704864544A686D68394F4E304B6256386656444E3561745479536E3434576754594446716C666B427067476556593036494434373930756E714A67654A7032515846745754753563484652644F333955334E2F4E7A7466707536644774356B74572F4A3275502F61373378715339583170326D48557755465032462B6C62374F3176565530384B7070743239782F74'
		||	'722F6834742F59485A6450664E366E574A675459544847375644394E47414D66715049525576327236387667784C4748756739656E4865756475546538723270426868636E6C5A56614E6F4564466E716C486C662B37656577444F69522F644A33706D56736E5755496D4E5552766E4F436E3131562B392B455671444653376F677A50795967765A765264614C423348637466414D5354693452676A6579362F6248476E7561624838364F676F4F6772374536337163765A307558342F6D6A6C334850646930344B61727667677545556A4962584E705274534772594A6D3463746266386D385064717865684C484A747539664642754D6A7137614A39635A4F523374505A314F587A53565274544F62494F45576E56596E424167616877414E72585A34694E412B69393039616C2F3571657A757A38454372575A6E717061396845484932675359725930354A584F694A54353168434D55367144343957577965642F4B7A332B585762533758413862436C34656450534173756D684F666E6E386C7263626E644C6879592B65377950765A6B47786375483448624E72586D752F74356167494C692F7A4C556A65623364326A6754373237565A31543357567A754F43527255326F522F326363714C71614C725269637270766E69687744546D51495856376F724B4E3732387472524632437345514B314737797366756C47463244596D64572B5455744A6768684E5858472B476A6E313370504B4E5461712F7253754643655A79585479536276776751674D4A4130667330685A6638695756355231774C5457384475687774416C774F44764C71772F487931384A614541785043462B6572666B766558534F584F55787A59564B63563135646F57772B777A366E4D357571713630306E4B4E34587844496F5750786158386C4A4B396B6831355A3632446855646A4B4F6736486430576C30355656325A757334366B783347433252496137444178594F676C4275737A4165796741367271394A6F6857435A7A45345956703654713346455A3753574E566A4178725A75723833713649375A367569574E696855656B5748576D39684443356A68364F306F56757A5944724252754E324155526945446C2F4943394D6265714247366F42697762656C756569466A38384958726D0A6B4F544E4D786E6A56625769756D5A315A6430706C57356E6B575A4E54736E6339507A76302F4B2F4C5641767232343431397065366E5147324A2B4D676F4C69576B566674496B42464570546F74306F536E2F587A7777446A684179526436587574726A5A6B766754355651554644386E30586674596D42477A5A4F573465367176344D4C4B43736F716B7766785235587A484537397A532B65724B335933'
		||	'4746497656304C50776A54514C4B53676F4B506A6F4C32337168647674644C6C736B437148733473686672766363476970486C46515541534C2F74636D43676F4B6972364461684D4642635856683473582F7A3874756335427767356C656741414141424A52553545726B4A6767673D3D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A20203C2F456D626564646564496D616765733E0D0A20203C5061676557696474683E32312E3539636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D22424C4F5155455F454E434142455A41444F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224E6F6D6272655F456D7072657361223E0D0A202020202020202020203C446174614669656C643E4E6F6D6272655F456D70726573613C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D226E6974223E0D0A202020202020202020203C446174614669656C643E6E69743C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22436975646164223E0D0A202020202020202020203C446174614669656C643E4369756461643C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246656368615F53697374656D61223E0D0A202020202020202020203C446174614669656C643E46656368615F53697374656D613C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22436F6E736563757469766F5F436F74697A6163696F6E223E0D0A202020202020202020203C446174614669656C643E436F6E736563757469766F5F436F74697A6163696F6E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E'
		||	'537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22646972656363696F6E223E0D0A202020202020202020203C446174614669656C643E646972656363696F6E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246656368615F526567697374726F223E0D0A202020202020202020203C446174614669656C643E46656368615F526567697374726F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246656368615F566967656E636961223E0D0A202020202020202020203C446174614669656C643E46656368615F566967656E6369613C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22536F6C696369747564223E0D0A202020202020202020203C446174614669656C643E536F6C6963697475643C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44535F434F54495A4143494F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E454E434142455A41444F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A2020'
		||	'20203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22424C4F5155455F434C49454E5445223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22436F6E747261746F223E0D0A202020202020202020203C446174614669656C643E436F6E747261746F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2250726F647563746F223E0D0A202020202020202020203C446174614669656C643E50726F647563746F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22446972656363696F6E223E0D0A202020202020202020203C446174614669656C643E446972656363696F6E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E6F6D6272655F436C69656E7465223E0D0A202020202020202020203C446174614669656C643E4E6F6D6272655F436C69656E74653C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2254656C65666F6E6F5F436C69656E7465223E0D0A202020202020202020203C446174614669656C643E54656C65666F6E6F5F436C69656E74653C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224964656E74696669636163696F6E223E0D0A202020202020202020203C446174614669656C643E4964656E74696669636163696F6E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C6420'
		||	'4E616D653D2243617465676F726961223E0D0A202020202020202020203C446174614669656C643E43617465676F7269613C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253756263617465676F726961223E0D0A202020202020202020203C446174614669656C643E53756263617465676F7269613C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22446570617274616D656E746F223E0D0A202020202020202020203C446174614669656C643E446570617274616D656E746F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C6F63616C69646164223E0D0A202020202020202020203C446174614669656C643E4C6F63616C696461643C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22436F6E7472617469737461223E0D0A202020202020202020203C446174614669656C643E436F6E74726174697374613C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22466F726D756C6172696F223E0D0A202020202020202020203C446174614669656C643E466F726D756C6172696F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224F62736572766163696F6E223E0D0A202020202020202020203C446174614669656C643E4F62736572766163696F6E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374'
		||	'656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44535F434F54495A4143494F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E434C49454E54453C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22424C4F5155455F444554414C4C45223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D225469706F5F54726162616A6F223E0D0A202020202020202020203C446174614669656C643E5469706F5F54726162616A6F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2249645F4974656D223E0D0A202020202020202020203C446174614669656C643E49645F4974656D3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224974656D5F44657363223E0D0A202020202020202020203C446174614669656C643E4974656D5F446573633C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22436F73746F5F56656E7461223E0D0A202020202020202020203C446174614669656C643E436F73746F5F56656E74613C2F446174614669656C643E0D0A202020202020202020203C72643A547970'
		||	'654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22616975223E0D0A202020202020202020203C446174614669656C643E6169753C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243616E7469646164223E0D0A202020202020202020203C446174614669656C643E43616E74696461643C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2250726563696F5F546F74616C223E0D0A202020202020202020203C446174614669656C643E50726563696F5F546F74616C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256616C6F725F697661223E0D0A202020202020202020203C446174614669656C643E56616C6F725F6976613C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256616C6F725F746F74616C223E0D0A202020202020202020203C446174614669656C643E56616C6F725F746F74616C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E'
		||	'666F3E0D0A20202020202020203C72643A446174615365744E616D653E44535F434F54495A4143494F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4954454D3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22424C4F5155455F464F524D415F5041474F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224D6F64616C696461645F5061676F223E0D0A202020202020202020203C446174614669656C643E4D6F64616C696461645F5061676F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E756D65726F5F43756F746173223E0D0A202020202020202020203C446174614669656C643E4E756D65726F5F43756F7461733C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224465736375656E746F223E0D0A202020202020202020203C446174614669656C643E4465736375656E746F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243756F74615F496E696369616C223E0D0A202020202020202020203C446174614669656C643E43756F74615F496E696369616C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256616C6F725F46696E616E63696172223E0D0A202020202020202020203C446174614669656C643E56616C6F725F46696E616E636961723C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A20202020'
		||	'20203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44535F434F54495A4143494F4E3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E464F524D415041474F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F64653E202020536861726564204461746131204173204F626A6563740D0A0D0A202020205075626C69632046756E6374696F6E204765744461746128427956616C204E756D20417320496E74656765722C20427956616C2047726F757020417320496E746567657229206173204F626A6563740D0A202020202020202049662047726F7570203D2031205468656E0D0A20202020202020202020202052657475726E20437374722843686F6F7365284E756D2C2053706C69742843737472284461746131292C43687228313737292929290D0A2020202020202020456E642049660D0A20202020456E642046756E6374696F6E0D0A0D0A202020205075626C69632046756E6374696F6E205365744461746128427956616C204E657744617461204173204F626A6563742C20427956616C2047726F757020417320496E7465676572290D0A202020202020202049662047726F7570203D203120616E64204E657744617461202667743B202222205468656E0D0A2020202020202020202020204461746131203D204E6577446174610D0A2020202020202020456E642049660D0A20202020456E642046756E6374696F6E3C2F436F64653E0D0A20203C57696474683E32312E35636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E31636D3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C5461626C65204E616D653D227461626C6537223E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E424C4F5155455F454E434142455A41444F3C2F44617461536574'
		||	'4E616D653E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E31302E35636D3C2F546F703E0D0A20202020202020203C57696474683E31302E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C5461626C65204E616D653D227461626C6538223E0D0A202020202020202020202020202020202020202020203C446174615365744E616D653E424C4F5155455F454E434142455A41444F3C2F446174615365744E616D653E0D0A202020202020202020202020202020202020202020203C5669736962696C6974793E0D0A2020202020202020202020202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A202020202020202020202020202020202020202020203C2F5669736962696C6974793E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C4865616465723E0D0A2020202020202020202020202020202020202020202020203C5461626C65526F7773'
		||	'3E0D0A20202020202020202020202020202020202020202020202020203C5461626C65526F773E0D0A202020202020202020202020202020202020202020202020202020203C5461626C6543656C6C733E0D0A2020202020202020202020202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A20202020202020202020202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A202020202020202020202020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783335223E0D0A2020202020202020202020202020202020202020202020202020202020202020202020203C5374796C653E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020202020202020203C56616C75653E3D4669656C647321436F6E736563757469766F5F436F74697A6163696F6E2E56616C7565202B204368722831373729202B4669656C647321536F6C6963697475642E56616C75652B2043687228313737292B4669656C64732146656368615F526567697374726F2E56616C7565202B2043687228313737292B4669656C64732146656368615F566967656E6369612E56616C75652B43687228313737292B4669656C647321646972656363696F6E2E56616C75652B43687228313737292B4669656C6473214369756461642E56616C75652B43687228313737292B4669656C6473216E69742E56616C75653C2F56616C75653E0D0A202020202020202020202020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A20202020202020202020202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A202020202020202020202020202020202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020202020202020202020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020202020202020202020202020203C2F5461626C65526F77733E0D0A202020202020202020202020202020202020202020203C2F4865616465723E0D0A202020202020202020202020202020202020202020203C5461626C65436F6C756D6E733E0D0A2020202020202020202020202020202020202020202020203C5461626C65436F6C756D6E3E0D0A20202020202020202020202020202020202020202020202020203C57696474683E31302E3735636D3C2F57696474683E0D0A2020202020202020202020202020202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020202020202020202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020202020202020202020202020203C2F5461626C653E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A20'
		||	'2020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E31302E3735636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C4C6566743E39636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C5461626C65204E616D653D227461626C6536223E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E424C4F5155455F434C49454E54453C2F446174615365744E616D653E0D0A20202020202020203C546F703E3131636D3C2F546F703E0D0A20202020202020203C57696474683E32302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E333C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020'
		||	'202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4F62736572766163696F6E65733C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E'
		||	'362E3833333331636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E362E38303933636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E362E3835373339636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E312E3236393834636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E333C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783530223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020202020202020202020'
		||	'20203C56616C75653E3D4669656C6473214F62736572766163696F6E2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C5461626C65204E616D653D227461626C6535223E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E424C4F5155455F464F524D415F5041474F3C2F446174615365744E616D653E0D0A20202020202020203C546F703E38636D3C2F546F703E0D0A20202020202020203C57696474683E32302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A20202020202020202020202020202020'
		||	'20202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E466F726D61206465205061676F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783536223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835363C2F72643A44656661756C744E616D653E'
		||	'0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E416E74696369706F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D73'
		||	'3E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4465736375656E746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A20202020202020'
		||	'20202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783438223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020'
		||	'202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F7220612046696E616E636961723C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783533223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C506164'
		||	'64696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4EC3BA6D65726F2064652043756F7461733C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E362E3130313139636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3137323632636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3431363637636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3930343736636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3930343736636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E312E3236393834636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A2020202020202020'
		||	'20203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783534223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214D6F64616C696461645F5061676F2E56616C75652C2022424C4F5155455F464F524D415F5041474F22293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020'
		||	'3C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783538223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843646563284669727374284669656C64732143756F74615F496E696369616C2E56616C75652C2022424C4F5155455F464F524D415F5041474F2229292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A202020202020202020202020202020'
		||	'20202020203C54657874626F78204E616D653D2274657874626F783539223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843646563284669727374284669656C6473214465736375656E746F2E56616C75652C2022424C4F5155455F464F524D415F5041474F2229292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783630223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A20'
		||	'20202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843446563284669727374284669656C64732156616C6F725F46696E616E636961722E56616C75652C2022424C4F5155455F464F524D415F5041474F2229292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783631223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020202020202020'
		||	'20202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D61744E756D626572284344626C284669727374284669656C6473214E756D65726F5F43756F7461732E56616C75652C2022424C4F5155455F464F524D415F5041474F2229292C30293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783535223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7835353C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E392E3735636D3C2F546F703E0D0A20202020202020203C'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'57696474683E32302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E2A456C2076616C6F722064652049564120657320C3BA6E6963616D656E74652063616C63756C61646F20706172612074726162616A6F732079206D6174657269616C65732072656C6163696F6E61646F7320636F6E206C6120696E7465726E613C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E424C4F5155455F444554414C4C453C2F446174615365744E616D653E0D0A20202020202020203C546F703E352E35636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3439393939636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D225469706F5F54726162616A6F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E5469706F5F54726162616A6F3C2F7264'
		||	'3A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473215469706F5F54726162616A6F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2249645F4974656D223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E49645F4974656D3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A20202020202020'
		||	'20202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732149645F4974656D2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224974656D5F44657363223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4974656D5F446573633C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020'
		||	'2020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214974656D5F446573632E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22436F73746F5F56656E7461223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E436F73746F5F56656E74613C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020'
		||	'20202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843646563284669656C647321436F73746F5F56656E74612E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22616975223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E6169753C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020202020'
		||	'20202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4344626C284669656C64732143616E74696461642E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2243616E7469646164223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E43616E74696461643C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020202020'
		||	'20202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843646563284669656C6473216169752E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2250726563696F5F546F74616C223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E50726563696F5F546F74616C3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E5269'
		||	'6768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843646563284669656C64732150726563696F5F546F74616C2E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256616C6F725F497661223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56616C6F725F4976613C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A20202020202020'
		||	'20202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843646563284669656C64732156616C6F725F6976612E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256616C6F725F546F74616C223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56616C6F725F546F74616C3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C5061646469'
		||	'6E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792843646563284669656C64732156616C6F725F746F74616C2E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3636363637636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D'
		||	'653E74657874626F7831333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5469706F2054726162616A6F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C'
		||	'3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43C3B36469676F204974656D3C2F56616C75653E0D0A2020'
		||	'2020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783333223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C'
		||	'5A496E6465783E32323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E446573637269706369C3B36E204974656D3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783434223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F506164'
		||	'64696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F73746F2056656E74613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783237223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270'
		||	'743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43616E74696461643C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E74576569'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4149553C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783339223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C46'
		||	'6F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E50726563696F20546F74616C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783432223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E'
		||	'0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4956413C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783238223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C65'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F7220546F74616C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3636363637636D3C2F4865696768743E0D0A2020202020202020202020203C2F'
		||	'5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3238313535636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3031393431636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3737363639636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3237313834636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3736363939636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3034363133636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3034363133636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3031393431636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3237313834636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E312E3936383236636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C6552'
		||	'6F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E333C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E544F54414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F'
		||	'783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783430223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792853756D2843646563284669656C647321436F73746F5F56656E74612E56616C756529292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020'
		||	'2020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783431223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D61744E756D6265722853756D284344626C284669656C64732143616E74696461642E56616C756529292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020'
		||	'2020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783433223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792853756D2843646563284669656C6473216169752E56616C756529292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20'
		||	'2020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783435223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792853756D2843646563284669656C64732150726563696F5F546F74616C2E56616C756529292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461'
		||	'626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783436223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792853756D2843646563284669656C64732156616C6F725F6976612E56616C756529292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020'
		||	'202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783437223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E63792853756D2843646563284669656C64732156616C6F725F746F74616C2E56616C756529292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D'
		||	'3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C5461626C65204E616D653D227461626C6532223E0D0A20202020202020203C446174615365744E616D653E424C4F5155455F434C49454E54453C2F446174615365744E616D653E0D0A20202020202020203C546F703E302E3235636D3C2F546F703E0D0A20202020202020203C5461626C6547726F7570733E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65325F47726F757031223E0D0A20202020202020202020202020203C47726F757045787072657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C647321436F6E747261746F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C64732150726F647563746F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A2020202020202020202020203C466F6F7465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831323C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020'
		||	'202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020'
		||	'20202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E446570617274616D656E746F3C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D22446570617274616D656E746F223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E446570617274616D656E746F3C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020'
		||	'202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321446570617274616D656E746F2E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783130223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831303C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E6754'
		||	'6F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E4C6F63616C696461643C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D224C6F63616C696461645F31223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4C6F63616C696461645F313C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020'
		||	'202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214C6F63616C696461642E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E36323738636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A'
		||	'20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F466F6F7465723E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65325F47726F757032223E0D0A20202020202020202020202020203C47726F757045787072657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C647321446972656363696F6E2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A2020202020202020202020203C4865616465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831313C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020'
		||	'2020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E44697265636369C3B36E3C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20'
		||	'202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C436F6C5370616E3E333C2F436F6C5370616E3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D22446972656363696F6E5F31223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E446972656363696F6E5F313C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C5465787441'
		||	'6C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321446972656363696F6E2E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E36323738636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F4865616465723E0D0A2020202020202020202020203C466F6F7465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C'
		||	'744E616D653E74657874626F7832363C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A'
		||	'202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E43617465676F72C3AD613C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2243617465676F726961223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E43617465676F7269613C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020'
		||	'202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732143617465676F7269612E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C52'
		||	'65706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832393C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020'
		||	'202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E5375622D63617465676F72C3AD613C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2253756263617465676F726961223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E53756263617465676F7269613C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D'
		||	'0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732153756263617465676F7269612E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020'
		||	'202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E36323738636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F466F6F7465723E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65325F47726F757033223E0D0A20202020202020202020202020203C47726F757045787072657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C6473214E6F6D6272655F436C69656E74652E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A2020202020202020202020203C4865616465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783233223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832333C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E'
		||	'426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E'
		||	'47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E4E6F6D6272652064656C20436C69656E74653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C436F6C5370616E3E333C2F436F6C5370616E3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D224E6F6D6272655F436C69656E7465223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4E6F6D6272655F436C69656E74653C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214E6F6D6272655F436C69656E74652E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E36323738636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F4865616465723E0D0A2020202020202020202020203C466F6F7465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020'
		||	'202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783336223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833363C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E'
		||	'7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E54656CC3A9666F6E6F3C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2254656C65666F6E6F5F436C69656E7465223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E54656C65666F6E6F5F436C69656E74653C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020'
		||	'202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C'
		||	'75653E3D4669656C64732154656C65666F6E6F5F436C69656E74652E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783338223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833383C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020202020'
		||	'3C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E4E69742E2F20436564756C613C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D224964656E74696669636163696F6E223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4964656E74696669636163696F6E3C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F7264657243'
		||	'6F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020'
		||	'202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214964656E74696669636163696F6E2E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E36323738636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F466F6F7465723E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A20202020202020203C2F5461626C6547726F7570733E0D0A20202020202020203C57696474683E32302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E343C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E'
		||	'5768697465536D6F6B653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020'
		||	'202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E496E666F726D616369C3B36E2064656C20536F6C69636974616E74653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3734313539636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E342E30353636636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E382E3039393136636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E34363734636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E352E3837363834636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E342E3632323138636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020'
		||	'3C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C656674'
		||	'3E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F6E74726174697374613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224F62736572766163696F6E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4F62736572766163696F6E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020'
		||	'2020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321436F6E74726174697374612E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A2020202020202020202020202020202020202020'
		||	'20203C72643A44656661756C744E616D653E74657874626F7832313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3970743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020'
		||	'202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E466F726D756C6172696F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783332223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020'
		||	'202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321466F726D756C6172696F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3734313539636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E31362E35636D3C2F4865'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		849, 
		hextoraw
		(
			'696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E656E2D55533C2F4C616E67756167653E0D0A20203C50616765466F6F7465723E0D0A202020203C5072696E744F6E4669727374506167653E747275653C2F5072696E744F6E4669727374506167653E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831373C2F72643A44656661756C744E616D653E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D202250C3A167696E612022202B20476C6F62616C7321506167654E756D6265722E546F537472696E672829202B20222064652022202B20476C6F62616C7321546F74616C50616765732E546F537472696E6728293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E312E3133343932636D3C2F4865696768743E0D0A202020203C5072696E744F6E4C617374506167653E747275653C2F5072696E744F6E4C617374506167653E0D0A20203C2F50616765466F6F7465723E0D0A20203C546F704D617267696E3E302E35636D3C2F546F704D617267696E3E0D0A20203C506167654865696768743E32372E3934636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_106.cuPlantilla( 504 );
	fetch CONFEXME_106.cuPlantilla into nuIdPlantill;
	close CONFEXME_106.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'PLANTILLA DE COTIZACION COMERCIAL PARA GDC',
		       plannomb = 'LDC_COTIZACION_COM_GDC',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 504;
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
			504,
			blContent ,
			'PLANTILLA DE COTIZACION COMERCIAL PARA GDC',
			'LDC_COTIZACION_COM_GDC',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_106.cuExtractAndMix( 106 );
	fetch CONFEXME_106.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_106.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_CONFEXME_COTI_COM_GDC',
		       coeminic = NULL,
		       coempada = '<584>',
		       coempadi = 'LDC_COTIZACION_COM_GDC',
		       coempame = NULL,
		       coemtido = 128,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 106;
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
			106,
			'LDC_CONFEXME_COTI_COM_GDC',
			NULL,
			'<584>',
			'LDC_COTIZACION_COM_GDC',
			NULL,
			128,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_106.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_106.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_106.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_106.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_106 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_106'
	);
--}
END;
/

