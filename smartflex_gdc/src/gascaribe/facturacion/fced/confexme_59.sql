BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_59 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_59',
		'CREATE OR REPLACE PACKAGE CONFEXME_59 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_59;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_59',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_59 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_59;'
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_59.cuFormat( 66 );
	fetch CONFEXME_59.cuFormat into nuFormatId;
	close CONFEXME_59.cuFormat;

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
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_59.cuFormat( 66 );
	fetch CONFEXME_59.cuFormat into nuFormatId;
	close CONFEXME_59.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_59.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'IMPRESION_FACTURA_SERVICIOS',
		       formtido = 66,
		       formiden = '<66>',
		       formtico = 49,
		       formdein = '<IMPRESION_FACTURA_SERVICIOS>',
		       formdefi = '</IMPRESION_FACTURA_SERVICIOS>'
		WHERE  formcodi = CONFEXME_59.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_59.rcED_Formato.formcodi := 66 ;

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
			CONFEXME_59.rcED_Formato.formcodi,
			'IMPRESION_FACTURA_SERVICIOS',
			66,
			'<66>',
			49,
			'<IMPRESION_FACTURA_SERVICIOS>',
			'</IMPRESION_FACTURA_SERVICIOS>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_59.tbrcED_Franja( 4844 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_GENERAL]', 5 );
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
		CONFEXME_59.tbrcED_Franja( 4844 ).francodi,
		'LDC_GENERAL',
		CONFEXME_59.tbrcED_Franja( 4844 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_59.tbrcED_Franja( 4845 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_DETALLE]', 5 );
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
		CONFEXME_59.tbrcED_Franja( 4845 ).francodi,
		'LDC_DETALLE',
		CONFEXME_59.tbrcED_Franja( 4845 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_59.tbrcED_FranForm( '4693' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_59.tbrcED_FranForm( '4693' ).frfoform := CONFEXME_59.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_59.tbrcED_Franja.exists( 4844 ) ) then
		CONFEXME_59.tbrcED_FranForm( '4693' ).frfofran := CONFEXME_59.tbrcED_Franja( 4844 ).francodi;
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
		CONFEXME_59.tbrcED_FranForm( '4693' ).frfocodi,
		CONFEXME_59.tbrcED_FranForm( '4693' ).frfoform,
		CONFEXME_59.tbrcED_FranForm( '4693' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_59.tbrcED_FranForm( '4694' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_59.tbrcED_FranForm( '4694' ).frfoform := CONFEXME_59.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_59.tbrcED_Franja.exists( 4845 ) ) then
		CONFEXME_59.tbrcED_FranForm( '4694' ).frfofran := CONFEXME_59.tbrcED_Franja( 4845 ).francodi;
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
		CONFEXME_59.tbrcED_FranForm( '4694' ).frfocodi,
		CONFEXME_59.tbrcED_FranForm( '4694' ).frfoform,
		CONFEXME_59.tbrcED_FranForm( '4694' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DatosFactura]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi,
		'DatosFactura',
		'PKG_UIIMPRE_FACT_SERVI.prcDatosFactura',
		CONFEXME_59.tbrcED_FuenDato( '3817' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ConceptosFactura]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi,
		'ConceptosFactura',
		'PKG_UIIMPRE_FACT_SERVI.prcDetalleFactura',
		CONFEXME_59.tbrcED_FuenDato( '3818' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_59.tbrcED_FuenDato( '3819' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TotalFactura]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_59.tbrcED_FuenDato( '3819' ).fudacodi,
		'TotalFactura',
		'PKG_UIIMPRE_FACT_SERVI.prcTotalFactura',
		CONFEXME_59.tbrcED_FuenDato( '3819' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ConceptosIva]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi,
		'ConceptosIva',
		'PKG_UIIMPRE_FACT_SERVI.prcDetalleIva',
		CONFEXME_59.tbrcED_FuenDato( '3820' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30510' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3818' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30510' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30510' ).atfdcodi,
		'CODIGO',
		'Codigo',
		1,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30510' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30511' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3818' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30511' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Concepto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30511' ).atfdcodi,
		'CONCEPTO',
		'Concepto',
		2,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30511' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30512' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3818' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30512' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi;
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
		CONFEXME_59.tbrcED_AtriFuda( '30512' ).atfdcodi,
		'CANTIDAD',
		'Cantidad',
		3,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30512' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30513' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3818' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30513' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30513' ).atfdcodi,
		'VALOR',
		'Valor',
		4,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30513' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30514' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3818' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30514' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi;
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
		CONFEXME_59.tbrcED_AtriFuda( '30514' ).atfdcodi,
		'VALOR_TOTAL',
		'Valor_Total',
		5,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30514' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30515' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30515' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo_Factura]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30515' ).atfdcodi,
		'CODIGO_FACTURA',
		'Codigo_Factura',
		1,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30515' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30516' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30516' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Expedicion]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30516' ).atfdcodi,
		'FECHA_EXPEDICION',
		'Fecha_Expedicion',
		2,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30516' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30517' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30517' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Vencimiento]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30517' ).atfdcodi,
		'FECHA_VENCIMIENTO',
		'Fecha_Vencimiento',
		3,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30517' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30518' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30518' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cliente]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30518' ).atfdcodi,
		'CLIENTE',
		'Cliente',
		4,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30518' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30519' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30519' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nit_Cliente]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30519' ).atfdcodi,
		'NIT_CLIENTE',
		'Nit_Cliente',
		5,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30519' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30520' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30520' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Contacto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30520' ).atfdcodi,
		'CONTACTO',
		'Contacto',
		6,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30520' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30521' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30521' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
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
		CONFEXME_59.tbrcED_AtriFuda( '30521' ).atfdcodi,
		'DIRECCION',
		'Direccion',
		7,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30521' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30522' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30522' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
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
		CONFEXME_59.tbrcED_AtriFuda( '30522' ).atfdcodi,
		'CIUDAD',
		'Ciudad',
		8,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30522' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30523' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30523' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Correo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30523' ).atfdcodi,
		'CORREO',
		'Correo',
		9,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30523' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30524' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30524' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Telefono]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30524' ).atfdcodi,
		'TELEFONO',
		'Telefono',
		10,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30524' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30525' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3819' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30525' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3819' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Total_Pagar]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30525' ).atfdcodi,
		'VALOR_TOTAL_PAGAR',
		'Valor_Total_Pagar',
		1,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30525' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30526' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3819' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30526' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3819' ).fudacodi;
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
		CONFEXME_59.tbrcED_AtriFuda( '30526' ).atfdcodi,
		'VALOR_IVA',
		'Valor_Iva',
		2,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30526' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30527' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3820' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30527' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Codigo]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30527' ).atfdcodi,
		'CODIGO',
		'Codigo',
		1,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30527' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30528' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3820' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30528' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Concepto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30528' ).atfdcodi,
		'CONCEPTO',
		'Concepto',
		2,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30528' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30529' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3820' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30529' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi;
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
		CONFEXME_59.tbrcED_AtriFuda( '30529' ).atfdcodi,
		'CANTIDAD',
		'Cantidad',
		3,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30529' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30530' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3820' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30530' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_59.tbrcED_AtriFuda( '30530' ).atfdcodi,
		'VALOR',
		'Valor',
		4,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30530' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_59.tbrcED_AtriFuda( '30531' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3820' ) ) then
		CONFEXME_59.tbrcED_AtriFuda( '30531' ).atfdfuda := CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi;
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
		CONFEXME_59.tbrcED_AtriFuda( '30531' ).atfdcodi,
		'VALOR_TOTAL',
		'Valor_Total',
		5,
		'S',
		CONFEXME_59.tbrcED_AtriFuda( '30531' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_59.tbrcED_Bloque( 6736 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3817' ) ) then
		CONFEXME_59.tbrcED_Bloque( 6736 ).bloqfuda := CONFEXME_59.tbrcED_FuenDato( '3817' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [GENERAL_DATOS]', 5 );
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
		CONFEXME_59.tbrcED_Bloque( 6736 ).bloqcodi,
		'GENERAL_DATOS',
		CONFEXME_59.tbrcED_Bloque( 6736 ).bloqtibl,
		CONFEXME_59.tbrcED_Bloque( 6736 ).bloqfuda,
		'<GENERAL_DATOS>',
		'</GENERAL_DATOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_59.tbrcED_Bloque( 6737 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3818' ) ) then
		CONFEXME_59.tbrcED_Bloque( 6737 ).bloqfuda := CONFEXME_59.tbrcED_FuenDato( '3818' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [DETALLE_DATOS]', 5 );
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
		CONFEXME_59.tbrcED_Bloque( 6737 ).bloqcodi,
		'DETALLE_DATOS',
		CONFEXME_59.tbrcED_Bloque( 6737 ).bloqtibl,
		CONFEXME_59.tbrcED_Bloque( 6737 ).bloqfuda,
		'<DETALLE_DATOS>',
		'</DETALLE_DATOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_59.tbrcED_Bloque( 6738 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3819' ) ) then
		CONFEXME_59.tbrcED_Bloque( 6738 ).bloqfuda := CONFEXME_59.tbrcED_FuenDato( '3819' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [GENERAL_TOTAL]', 5 );
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
		CONFEXME_59.tbrcED_Bloque( 6738 ).bloqcodi,
		'GENERAL_TOTAL',
		CONFEXME_59.tbrcED_Bloque( 6738 ).bloqtibl,
		CONFEXME_59.tbrcED_Bloque( 6738 ).bloqfuda,
		'<GENERAL_TOTAL>',
		'</GENERAL_TOTAL>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_59.tbrcED_Bloque( 6739 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_59.tbrcED_FuenDato.exists( '3820' ) ) then
		CONFEXME_59.tbrcED_Bloque( 6739 ).bloqfuda := CONFEXME_59.tbrcED_FuenDato( '3820' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [DETALLE_IVA]', 5 );
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
		CONFEXME_59.tbrcED_Bloque( 6739 ).bloqcodi,
		'DETALLE_IVA',
		CONFEXME_59.tbrcED_Bloque( 6739 ).bloqtibl,
		CONFEXME_59.tbrcED_Bloque( 6739 ).bloqfuda,
		'<DETALLE_IVA>',
		'</DETALLE_IVA>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrfrfo := CONFEXME_59.tbrcED_FranForm( '4693' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_59.tbrcED_Bloque.exists( 6736 ) ) then
		CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrbloq := CONFEXME_59.tbrcED_Bloque( 6736 ).bloqcodi;
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
		CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi,
		CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrbloq,
		CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrfrfo := CONFEXME_59.tbrcED_FranForm( '4694' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_59.tbrcED_Bloque.exists( 6737 ) ) then
		CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrbloq := CONFEXME_59.tbrcED_Bloque( 6737 ).bloqcodi;
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
		CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrcodi,
		CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrbloq,
		CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrfrfo := CONFEXME_59.tbrcED_FranForm( '4693' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_59.tbrcED_Bloque.exists( 6738 ) ) then
		CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrbloq := CONFEXME_59.tbrcED_Bloque( 6738 ).bloqcodi;
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
		CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrcodi,
		CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrbloq,
		CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrfrfo := CONFEXME_59.tbrcED_FranForm( '4694' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_59.tbrcED_Bloque.exists( 6739 ) ) then
		CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrbloq := CONFEXME_59.tbrcED_Bloque( 6739 ).bloqcodi;
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
		CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrcodi,
		CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrbloq,
		CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35854' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35854' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30510' ) ) then
		CONFEXME_59.tbrcED_Item( '35854' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30510' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35854' ).itemcodi,
		'Codigo',
		CONFEXME_59.tbrcED_Item( '35854' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35854' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35854' ).itemgren,
		NULL,
		1,
		'<Codigo>',
		'</Codigo>',
		CONFEXME_59.tbrcED_Item( '35854' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35855' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35855' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30511' ) ) then
		CONFEXME_59.tbrcED_Item( '35855' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30511' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Concepto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35855' ).itemcodi,
		'Concepto',
		CONFEXME_59.tbrcED_Item( '35855' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35855' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35855' ).itemgren,
		NULL,
		1,
		'<Concepto>',
		'</Concepto>',
		CONFEXME_59.tbrcED_Item( '35855' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35856' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35856' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30512' ) ) then
		CONFEXME_59.tbrcED_Item( '35856' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30512' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35856' ).itemcodi,
		'Cantidad',
		CONFEXME_59.tbrcED_Item( '35856' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35856' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35856' ).itemgren,
		NULL,
		2,
		'<Cantidad>',
		'</Cantidad>',
		CONFEXME_59.tbrcED_Item( '35856' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35857' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35857' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30513' ) ) then
		CONFEXME_59.tbrcED_Item( '35857' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30513' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35857' ).itemcodi,
		'Valor',
		CONFEXME_59.tbrcED_Item( '35857' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35857' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35857' ).itemgren,
		NULL,
		2,
		'<Valor>',
		'</Valor>',
		CONFEXME_59.tbrcED_Item( '35857' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35858' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35858' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30514' ) ) then
		CONFEXME_59.tbrcED_Item( '35858' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30514' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35858' ).itemcodi,
		'Valor_Total',
		CONFEXME_59.tbrcED_Item( '35858' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35858' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35858' ).itemgren,
		NULL,
		2,
		'<Valor_Total>',
		'</Valor_Total>',
		CONFEXME_59.tbrcED_Item( '35858' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35859' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35859' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30515' ) ) then
		CONFEXME_59.tbrcED_Item( '35859' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30515' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Codigo_Factura]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35859' ).itemcodi,
		'Codigo_Factura',
		CONFEXME_59.tbrcED_Item( '35859' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35859' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35859' ).itemgren,
		NULL,
		2,
		'<Codigo_Factura>',
		'</Codigo_Factura>',
		CONFEXME_59.tbrcED_Item( '35859' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35860' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35860' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30516' ) ) then
		CONFEXME_59.tbrcED_Item( '35860' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30516' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Expedicion]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35860' ).itemcodi,
		'Fecha_Expedicion',
		CONFEXME_59.tbrcED_Item( '35860' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35860' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35860' ).itemgren,
		NULL,
		1,
		'<Fecha_Expedicion>',
		'</Fecha_Expedicion>',
		CONFEXME_59.tbrcED_Item( '35860' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35861' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35861' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30517' ) ) then
		CONFEXME_59.tbrcED_Item( '35861' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30517' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Vencimiento]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35861' ).itemcodi,
		'Fecha_Vencimiento',
		CONFEXME_59.tbrcED_Item( '35861' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35861' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35861' ).itemgren,
		NULL,
		1,
		'<Fecha_Vencimiento>',
		'</Fecha_Vencimiento>',
		CONFEXME_59.tbrcED_Item( '35861' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35862' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35862' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30518' ) ) then
		CONFEXME_59.tbrcED_Item( '35862' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30518' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cliente]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35862' ).itemcodi,
		'Cliente',
		CONFEXME_59.tbrcED_Item( '35862' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35862' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35862' ).itemgren,
		NULL,
		1,
		'<Cliente>',
		'</Cliente>',
		CONFEXME_59.tbrcED_Item( '35862' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35863' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35863' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30519' ) ) then
		CONFEXME_59.tbrcED_Item( '35863' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30519' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nit_Cliente]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35863' ).itemcodi,
		'Nit_Cliente',
		CONFEXME_59.tbrcED_Item( '35863' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35863' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35863' ).itemgren,
		NULL,
		1,
		'<Nit_Cliente>',
		'</Nit_Cliente>',
		CONFEXME_59.tbrcED_Item( '35863' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35864' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35864' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30520' ) ) then
		CONFEXME_59.tbrcED_Item( '35864' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30520' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Contacto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35864' ).itemcodi,
		'Contacto',
		CONFEXME_59.tbrcED_Item( '35864' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35864' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35864' ).itemgren,
		NULL,
		1,
		'<Contacto>',
		'</Contacto>',
		CONFEXME_59.tbrcED_Item( '35864' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35865' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35865' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30521' ) ) then
		CONFEXME_59.tbrcED_Item( '35865' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30521' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35865' ).itemcodi,
		'Direccion',
		CONFEXME_59.tbrcED_Item( '35865' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35865' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35865' ).itemgren,
		NULL,
		1,
		'<Direccion>',
		'</Direccion>',
		CONFEXME_59.tbrcED_Item( '35865' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35866' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35866' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30522' ) ) then
		CONFEXME_59.tbrcED_Item( '35866' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30522' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35866' ).itemcodi,
		'Ciudad',
		CONFEXME_59.tbrcED_Item( '35866' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35866' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35866' ).itemgren,
		NULL,
		1,
		'<Ciudad>',
		'</Ciudad>',
		CONFEXME_59.tbrcED_Item( '35866' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35867' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35867' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30523' ) ) then
		CONFEXME_59.tbrcED_Item( '35867' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30523' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Correo]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35867' ).itemcodi,
		'Correo',
		CONFEXME_59.tbrcED_Item( '35867' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35867' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35867' ).itemgren,
		NULL,
		1,
		'<Correo>',
		'</Correo>',
		CONFEXME_59.tbrcED_Item( '35867' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35868' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35868' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30524' ) ) then
		CONFEXME_59.tbrcED_Item( '35868' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30524' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Telefono]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35868' ).itemcodi,
		'Telefono',
		CONFEXME_59.tbrcED_Item( '35868' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35868' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35868' ).itemgren,
		NULL,
		1,
		'<Telefono>',
		'</Telefono>',
		CONFEXME_59.tbrcED_Item( '35868' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35869' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35869' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30525' ) ) then
		CONFEXME_59.tbrcED_Item( '35869' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30525' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Total_Pagar]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35869' ).itemcodi,
		'Valor_Total_Pagar',
		CONFEXME_59.tbrcED_Item( '35869' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35869' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35869' ).itemgren,
		NULL,
		2,
		'<VALOR_TOTAL_PAGAR>',
		'</VALOR_TOTAL_PAGAR>',
		CONFEXME_59.tbrcED_Item( '35869' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35870' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35870' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30526' ) ) then
		CONFEXME_59.tbrcED_Item( '35870' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30526' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35870' ).itemcodi,
		'Valor_Iva',
		CONFEXME_59.tbrcED_Item( '35870' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35870' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35870' ).itemgren,
		NULL,
		2,
		'<VALOR_IVA>',
		'</VALOR_IVA>',
		CONFEXME_59.tbrcED_Item( '35870' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35871' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35871' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30527' ) ) then
		CONFEXME_59.tbrcED_Item( '35871' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30527' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35871' ).itemcodi,
		'Codigo',
		CONFEXME_59.tbrcED_Item( '35871' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35871' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35871' ).itemgren,
		NULL,
		1,
		'<Codigo>',
		'</Codigo>',
		CONFEXME_59.tbrcED_Item( '35871' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35872' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35872' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30528' ) ) then
		CONFEXME_59.tbrcED_Item( '35872' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30528' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Concepto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35872' ).itemcodi,
		'Concepto',
		CONFEXME_59.tbrcED_Item( '35872' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35872' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35872' ).itemgren,
		NULL,
		1,
		'<Concepto>',
		'</Concepto>',
		CONFEXME_59.tbrcED_Item( '35872' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35873' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35873' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30529' ) ) then
		CONFEXME_59.tbrcED_Item( '35873' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30529' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35873' ).itemcodi,
		'Cantidad',
		CONFEXME_59.tbrcED_Item( '35873' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35873' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35873' ).itemgren,
		NULL,
		2,
		'<Cantidad>',
		'</Cantidad>',
		CONFEXME_59.tbrcED_Item( '35873' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35874' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35874' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30530' ) ) then
		CONFEXME_59.tbrcED_Item( '35874' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30530' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_59.tbrcED_Item( '35874' ).itemcodi,
		'Valor',
		CONFEXME_59.tbrcED_Item( '35874' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35874' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35874' ).itemgren,
		NULL,
		2,
		'<Valor>',
		'</Valor>',
		CONFEXME_59.tbrcED_Item( '35874' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_59.tbrcED_Item( '35875' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_59.tbrcED_Item( '35875' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_59.tbrcED_AtriFuda.exists( '30531' ) ) then
		CONFEXME_59.tbrcED_Item( '35875' ).itematfd := CONFEXME_59.tbrcED_AtriFuda( '30531' ).atfdcodi;
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
		CONFEXME_59.tbrcED_Item( '35875' ).itemcodi,
		'Valor_Total',
		CONFEXME_59.tbrcED_Item( '35875' ).itemceid,
		NULL,
		CONFEXME_59.tbrcED_Item( '35875' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_59.tbrcED_Item( '35875' ).itemgren,
		NULL,
		2,
		'<Valor_Total>',
		'</Valor_Total>',
		CONFEXME_59.tbrcED_Item( '35875' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35829' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35829' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35854' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35829' ).itblitem := CONFEXME_59.tbrcED_Item( '35854' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35829' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35829' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35829' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35830' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35830' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35855' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35830' ).itblitem := CONFEXME_59.tbrcED_Item( '35855' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35830' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35830' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35830' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35831' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35831' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35856' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35831' ).itblitem := CONFEXME_59.tbrcED_Item( '35856' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35831' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35831' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35831' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35832' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35832' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35857' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35832' ).itblitem := CONFEXME_59.tbrcED_Item( '35857' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35832' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35832' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35832' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35833' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35833' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6901' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35858' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35833' ).itblitem := CONFEXME_59.tbrcED_Item( '35858' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35833' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35833' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35833' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35834' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35834' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35859' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35834' ).itblitem := CONFEXME_59.tbrcED_Item( '35859' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35834' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35834' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35834' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35835' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35835' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35860' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35835' ).itblitem := CONFEXME_59.tbrcED_Item( '35860' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35835' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35835' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35835' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35836' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35836' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35861' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35836' ).itblitem := CONFEXME_59.tbrcED_Item( '35861' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35836' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35836' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35836' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35837' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35837' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35862' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35837' ).itblitem := CONFEXME_59.tbrcED_Item( '35862' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35837' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35837' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35837' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35838' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35838' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35863' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35838' ).itblitem := CONFEXME_59.tbrcED_Item( '35863' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35838' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35838' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35838' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35839' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35839' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35864' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35839' ).itblitem := CONFEXME_59.tbrcED_Item( '35864' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35839' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35839' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35839' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35840' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35840' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35865' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35840' ).itblitem := CONFEXME_59.tbrcED_Item( '35865' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35840' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35840' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35840' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35841' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35841' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35866' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35841' ).itblitem := CONFEXME_59.tbrcED_Item( '35866' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35841' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35841' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35841' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35842' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35842' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35867' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35842' ).itblitem := CONFEXME_59.tbrcED_Item( '35867' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35842' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35842' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35842' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35843' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35843' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6900' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35868' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35843' ).itblitem := CONFEXME_59.tbrcED_Item( '35868' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35843' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35843' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35843' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35844' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35844' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35869' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35844' ).itblitem := CONFEXME_59.tbrcED_Item( '35869' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35844' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35844' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35844' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35845' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35845' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6902' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35870' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35845' ).itblitem := CONFEXME_59.tbrcED_Item( '35870' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35845' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35845' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35845' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35846' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35846' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35871' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35846' ).itblitem := CONFEXME_59.tbrcED_Item( '35871' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35846' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35846' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35846' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35847' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35847' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35872' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35847' ).itblitem := CONFEXME_59.tbrcED_Item( '35872' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35847' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35847' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35847' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35848' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35848' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35873' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35848' ).itblitem := CONFEXME_59.tbrcED_Item( '35873' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35848' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35848' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35848' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35849' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35849' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35874' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35849' ).itblitem := CONFEXME_59.tbrcED_Item( '35874' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35849' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35849' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35849' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_59.tbrcED_ItemBloq( '35850' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_59.tbrcED_ItemBloq( '35850' ).itblblfr := CONFEXME_59.tbrcED_BloqFran( '6903' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_59.tbrcED_Item.exists( '35875' ) ) then
		CONFEXME_59.tbrcED_ItemBloq( '35850' ).itblitem := CONFEXME_59.tbrcED_Item( '35875' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_59.tbrcED_ItemBloq( '35850' ).itblcodi,
		CONFEXME_59.tbrcED_ItemBloq( '35850' ).itblitem,
		CONFEXME_59.tbrcED_ItemBloq( '35850' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
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
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E37643230303465372D663139332D343232642D393761382D3532313335306565393432613C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C52696768744D617267696E3E32636D3C2F52696768744D617267696E3E0D0A20203C4C6566744D617267696E3E32636D3C2F4C6566744D617267696E3E0D0A20203C426F74746F6D4D617267696E3E322E35636D3C2F426F74746F6D4D617267696E3E0D0A20203C72643A5265706F727449443E35636432343963612D356635372D343632392D386430312D3561653835356330653565363C2F72643A5265706F727449443E0D0A20203C456D626564646564496D616765733E0D0A202020203C456D626564646564496D616765204E616D653D22696D6167656E6C61746572616C223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020203C'
		||	'496D616765446174613E6956424F5277304B47676F414141414E5355684555674141414263414141452F4341494141414169774D38594141414141584E535230494172733463365141414141526E51553142414143786A777638595155414141414A6345685A6377414144734D41414137444163647671475141414342735355524256486865375A7748564254582B2F66764C6C5636373731336B5771766741335567474276574E4859513951596A624847726D6A736F675A72314669525746434B43414C534248627073505379734378736753337A6E3932393641437A412F782B2F2F4F6539377A6E2F5A79634F50632B6A392B642B39772B63306353676944677634594D2F2F7A762B5038712B456856595148514473416736772B2F706C7341324830684E65644C74613233772F495A4C6E356D384D665941484142304A496B734B41712F546C38395A325868745647423856704669626D6E71757570745A4B38754D53692F6446765A64635938457655565857303357372F6150794D6C3638503337456F2F5459676730336335725266455A744669336E767351484337364B70677950702B734C3546786B4C65637675504C67366C62355530742B6646724B6C35456E6B7741664F6D484156396D36304C4F6C724954577A42476E39435A732B757558414E4C427350557847553379636A4C697A4E37416B76576A345046425A6D30525449696F7537647448674161477A5A7567426B59704B72305238697076623168784F334461324561773642556A723875693665306F4265437A68702B6336456B45347655566F65463875687351303469656B46574E706252635A526B59686D554368423041694861334B51794B425566617A554C5855575977414F2F42306979534F4C2F6932415741486C746F476A415145416E414362664452443865376E3275736A2F574E7076622B6C764761414D674334315A3151437A55394A7972385539554C69673055572F746D62397353483855654F79747535704B7550714E4F7A55584179747A4B336E6A50545062306B6D2F553141594167364E65446C4E47372B564E7730454C622B614662527869316C5A536D5A4F666D66577071524478656C39637358755A322F7477463650594E6358336A6B484E76653969596748596D523551514E416D354B556A647778755273384A584461585643666E644C516C2F434C684D6D425A7A2F3836644E6548684D494642366E785577675055447342754236724B594951754D4254584379333751324E70746E666F4E72484C642F42567374764168736872334F53486C7649496C61784764764562452B692F49746A615636454C72544541314B4266442F6771572F6564366B712B73434E6971724B465A66'
		||	'724432497676616271360A757157434B542B652B54584D6352683077694971566A2F57726C3058485830564A6844752B7455526A323663546A7935664D6273694649327A4D5743332B70634445677676744B2F6343574E574B4656304D56584D686D2F37666F30702B3744522B364958587142722F4C6A706E4362764D6372413759754F70757834464A42586C4B6870516F6158724B32793252512B783436595A44534737573866722F30362F35526552702F727762582F503959614F417A5952513034514A4C316875682B44394553456361456F57304F49517647714A5143684C75787035644B626E47676C394865782F6C754A6C707A76557852363962424343787156734A4145383965543168422B427A774441396964733338457655394F357152774861363041394234542F2F6A6A53642F37326F4657686D324C75555158394A56436B78415549414243696632516E6636626669557738706876376B39797330735058316B516B3158524C504C4467713477324A622F34556F6D4F6B615475527374526F307A6E58376163663333373631664245386D336A765872304E4A556C6D37636F506B6C656648787042796D624863336D51367A4C5456645A774C5756356A4349676C7966316F4C376831644F3371732B3077564D3765354F3138635430462B2F70666C4D485037385132726F5163477158306142576B72716331366D503736656671372B6E4B4F4B6C66496D753176764F7A58593749476F364648443051715058514B655652424C52554979584B574577484A43475A6A4749774B684D55445363334157517559395A3955524D5561484E573042685862755A466E48384930426D6E744251646444664B447554587A4459746847734D51536F54657433686C6830342B436A436A422F78374B577A6A666177586C484E454B30304D704B384E4D73386F36496A5A462F78373262487639724759784647657A69376537756F325272616D4274596D61694D4E774F4E374C7850667056362F66676A363959412F4E34593630522B33584275764E45596E4E6546726E47775353644464715758724D7A326E504433416A4147644D45694C5339655A6A663470704C457870355970746C6533356D5757354F6256306B6733583330786D6A4C6C3070392F5171397669436F4B44313531366F32312F717832426B776A6641526833666E72534867347A69676C74615A4A4A72372B423638316B315661455341654339436C705A4B686B7157544D7334614537394561483375756C7434392F356244586D326A6247397470325A723565467636754F76624243794B715830523963507A72304D4F5068345256724C48686D6C6F616C785531357A6153763366706B63372B4E6539597439'
		||	'73545A426B695A31645A0A7469443646726D746230536B4E516371523967524777752B33776B654F6D627A38545355616F4C376778305557384C4D56504E4756764C695A57674B3143656F54396936392F6D4C42474F542B7564505143514F2B7974376C6F30736650746B5955313747463033755065686F4F6753414E67704D595A44616A777275377A703039456D7177512B6D4938614D38686D757143624C365A5A396565466B6D42316A33346C4C304B6B4871536F6F6E4F4B376151387666666E536C46436B3049706F6769356D694364702B396B7A77484163394F694253415843727742314761436A41386A4A41755068514E6B64356D50415630473351476A412B73657356516959434C446F312B37776F33766C5266365966516B2F763268343051514B78493151516B7043377556546A32454341333666377637384A4F33515152313731774B6C3454527447786B484D77747A717A6D4276706C464F6279694A4142436F46385055754C43794A673363373570614F67766F387A6153346F2F66636E4F54616D7634376D394B716C64754D4C6A2F4C6C42392B6D43523773586A5A3763336935653779494D525041466F622F34613366496B4E653739556C6E2B4E774F6D42627A344D366464586A723353484D4A43693165596D357A364A6741734D67326773474250424A6F6B584A344F5941584F72623249456E763937504876522B47686435646D765832516D567A772F414E4161704A617271416B6E6C484147505A476D6B614B494A7A475341484D49467443644178675359444B3466556470422B4E362F43682F657464435855564977355A6861573477634E33656135324A6E4F656A52473379567263662F616F7A39666666436B5372365A6A566C4A5A586C4C616D552B6F773636306B2F482F686A4254703639514E5636593934483341474A70417542476C416D6C4D4B376D36634E744876654877317A4D61414831306A645A6D6E78544B314D43555067443751476532304947724A346A4755753864674E675A386C62336246356A6D50467936377561564C50616E5A71515A6741363069774A515362596A4962315841474B6B31684833362F337A2B772F634C744D5536486E7132497845314E5134724F37326A7A63507248414B2F664549644F7142734F33794B4B79304239544D334B5455616A704C675378676A35746B36372F394A4A4131685134395346564A61774F5A31594173433752557579667131426A49636F454D435A443163523975346174386F49457447772B6F35543630555A484E59696D3332632F7744707135504E513553412F765152414B71744B663964742F33663244457A667A4F4B2F68596661467859736D32472B6237546C2B314F707A'
		||	'696658516F7A663464530A546F624C594F2B6B6E423879645A2F626E754554474B74744E484C397834626250366D794E623078765250743058664A574A6473502B5469783955536436786F6653496D514B4543586265636544782B706450747033536B504256356D2F59664E6B317673392F724F6E62586F325A73652F745067304A78315244354B3339415874575249664C506771514D4569386C4C557263306167545837786D577675506A4C424A634A4536454A46786966667144625A6A61366565797551526A35694B42546B6C6E2B2B66476E6D31736B31316A77565671366B635848336F39596675666F57394554544261437044554B503959694C414550456149726D7237677132792B3947614B702F745A5034767858674758302B714F767372586E6244655A4E4C614854475A304B4D33306B61473964485866304F5139757A4C50336F37425151467A5972375A57547173646C7A78766C467636324554686A776F30734741686F4A335161726D633037674F6A78526A6C71544475554F6A4C79616568636E342F337A30456E445067716D326662707437384E2B774D5A666D6C44466C61657165796134566B354E6478526E647734717465344B7659543938654F567442383977557030667259364E336B6C6C466B596475785448416F7A794742753736414A594D687934424F3148412B59786564656263572B4D2F31735278316C77767539716B6378497A46674B5658676771343870764C324A2B75515854765345637051614E6C42347752496167496851767A584447685347704E4C5230546F7038465A33554D38466747494B4B456F39682B544B4D6D34797A676965716F795A6D562F544847706751305955773369434D484A6A434946576C444545534369716D42765A36346B366C4932397775704830766471526E64474C4E6C2F4B72387A5A2F61723153674849453639353035506533492F717534464677562F766F75796678506270544431642B4A563159734C466175327A6A704F56584E334B6B6D4E58756544384D4836725133637A36425466566C6E342F73792B755876586362366D30537171386F76794F417A32394657377444336E513739765341725768367476693450505A4E523063456F52526A504D512B4568534275383741312B6956532B2F7330383845654C542B4C5A69386C3138706F716A6E625744685A6A505056744454544D4146434758742B52306F38365367543136514C6455546E336A315555646D53576C2B613164436F4A6E61766C486565746D526D357A41653639594376306F674145676C6F694B4B4457686D676F344A585539685955317A317055724C32643878614448303677466635557A4D2B314F78475A367562706147746E61'
		||	'756574373261736171510A4A30456873486E6548335869506771394A7A6E4261395030536F364B76494668664C755255616D2B687061316759754A41664C576434472F755971304F38627149703047496777463248457471627375584D386449716E4E7A70703774783042426F7853496C75442B564345456668705755334B57652B555256476D7A4C7267356275735A7938444A7037774664704169432B436A794E79793939396E78597A597678486C71426F7A316376657856336359434F6253752B7A5666385233315A662B4A4E78717159344E39484739746E315752634A545079684D334F616E673930627A6A6F2F7169702B6F35673576564D4F7530674A50354269387177626C62494175575847657145707464657969316F7A3770666B353559564E5A56535133327059624B716A5932536C4C47752B494D5172644A4931644F7468674F694B6C737443477142584E71522F4B4D6D6A3548327573357535336E2F31616D6A73595541564C4B686E765469306F6E644A5749616B49685770593932514750686555444F36306D51696F4A6B4A79707537445A515248384F2B753039386C53592B4B475741306A70754D613270766F6B4F364D774765677537736241774F794E793662536674713248666A3367712F787839384D76352F2F78554B415A64644A3068467232357070334D354A334C6E6233744E5979474456507A586B4F3950734771744B666D443252614F6566753270685157454D307634426E56656D7A3569636C59557A45306E416A2B37384C53737962345A624D57755837554F69696E32457749714D6F4C45517653484142367268774F4E577633327966754B4D3458347A4479525A652F6C6E35756443537A2B4978786555646D355A394D556C76733671736A4F3278547972364D4C746C414F71694F4656314D5A74322B316E5A6551636475345646575A69474A794B684B37734434654359692B6567456B4D513142703451675066616A4F4B734F75496942443641473870746F72637963397550734170724641745835516D6E6E4D4C74454C72652F776D4D7A346E57325A643245534137354B66456E6237494E334B2B71614A4D6C43756D4458693472544B59324E6B6E512F384658575268794E336F2F75673053626D50786D6E7633384D2B3447336835756F384D4F34377959514D475043306C59336D58694A6E6C79464858726D57502B2B637A594A58484878736D392B6533634935786E71766A336B6E683167312F776972304A794D5A376459353644736B336670586B33376C384A4478386F2B5161432F36396A463931624C4635783463566C6B39587557344A734279372F43644A506B63466E5978776E6C5A49627939646C52315A5565304A6534'
		||	'526446456B476734764D0A57626E72384D344953524B4C644A562B4D427171306B3647494132704D49316871484D4175764C415758373948356B44627065326A747966394A37616A6C344C456343564E6B364A793456505656336E534F2F776C57366163396165714F516772557A57376E397971396939753455596F6E7468743965713656526579303355614871552B757156707171435A7671356779662F6757594D5243724B5A4B46536C32776A6346585563525A7947514449474C704F456C5338676D594D5243716D4E7361686B7978433139354970416D613547546F414C777145386A324F796F6941705A4D43707736796F33496361504E6C4D3063772B7743546F2B326455693975772F614D417969706E6C306573474C38732F4A776A6175715A654C3065516641566B566D6E6F59514B574549376A2F68636C735A3172704357613747687370397032684A524370744855685333364F615831365456576431386E534548724D584C6F314C4749307A7274796F72685169737343526A6F6742526351327550757A4B6962693778484F2F7264543856355449616A55742B4E704863686E6569675830585A737A59676D77587A3059336B3962324C7731667568436B4D4F44564E6A66386337724E39334D72626135363356576E36723170334E4C6C64736F335735546C4D6C7855746876754345786432665748656E634F4668566D6C54544A4E35544A70565A514F7A2F6E654D31646F6142696E507A31396370576C6630676B644F30424E3771495548512B6955666D55414737444E426F75636E764D6E4F724B764A5A4B58545A6B4831525079344F67493766454A65724C39666979304C505A39643038457246622B6A454D42456B43366D366A644353595159472F4232665573363931674E2F4E48736B6E4C3259314B436F713472752B4277747833693432356D4E4D454774304F733755746F4C673970562B346C6B4F4448332F7647697234797379764B767257786C3446716E36424332617670505339417454692B49576C3172463068735A5039677867543071733461536D4E744B5332375373393171764F73766A732B6F6C5A5852436B4F6D6A36763936445567596861556C2B495267593956586B72486552325952336D7A516936312B752F4553596358785230444C706B39434A6E724A35332F764F664761795054464344316A3830396F496F4C7430647A506A6A42797572506E2B754B69396B5765717075444530374F63746D625178324156363945436B49715A54644E4B30767042526E466C56566C6D55315767366573366F6863756873516369465861584D4A6247307A4A57734A4D4878724B53776F756D4641445578662F2F4471464B473350567842337636'
		||	'54793971625A4F746A360A3277783274724E5739644256634E6674476B7969366E517279794468774D616A697352396C53753632754F5654316736666C526E37484A71786F5063694451714647684177466C303469314F4E4653392F57547042392B3337562B4A6B4C346A7552556B4761614572786C5A4B7A70377057637A386665717958666669306572754335474B6D5A5678354854644C53474C51382F6C33715477586A4A6B6E39546F797A576D51544D5765452F39614F30536E5742414F69732B5273336137474D6535444462336935346859394E5266783569514D57664A57304F6C62453966633154654C6E52774965767A323950666453593977767A506F58596E7466384655694E70772F735737653978464B54414F646665314E3266657848414E2B5849543872316F2B5538566E434C366A3273334D76587A78366A2B44666A654235766176435355442F5A4842426E6D78563241614137374B786B4472784274763768517959666F3768726939476C2F464D54417933494E334F48445A796E73566278723464563267475145353765425363704F42327142506934697066337473355A366F39487256796470653439526B31596F7230326249786C323764517359545941755052434F444567334E2B744B66757262307277574A70316A34367A6C47377863326233666F4475493855554347694132414472536E70344F556D55416346514B5733676632336A7568734E73683547555A5552502B484358636C68775646342B66787578386F534B6F34504E75444657707659477470716D706C7244395A514E4E456A6F53677A3359444A656956716F72616E587979714C4B3476724B366A43724871396645525731334F45735A3662724C484237436D3250376A315855345278775864437457444E6B70723667637170617979734455396E2B7735662F6D53725375672F52756F4367474A445278304C5A514C6A324F32496431664544623257447545534B5742336A3170316835664536504675782B675930524C422B2F737037596839476B4A6263303042646148744B5444764C797A3731392F306C6270706A2F353563445646476A47514B5169692F42495A4356677555784E7A35464C72304A37746232375231506154576A47514B5269593672705A36657936475261615964636C2F6A426345473745686E33575134736D52546F52576B2F68586B626D526A592B573864762B31664F34647844382F67764C584571656C5763626378465A38634539475757765479646C4943686455684F32713867652B4B6655445A536D4C35426F374B383769385453666A44456536754E725A2B6B2B7774444B5873774D385659514F534F69695678753339654B6F7343747945363573'
		||	'797152554E315371356E0A634E4C796272476B36773039617A6333427838764E536439516B3236764C51396476694972564636486F5A6175677372586C626669715261666D657564646E333879794847346A70616833734A62443939424C777845306156514B6750385A694A496954685656525437792F6F492F36784D6E505575555530726B6A6E4E48627945656874787973787578763478343338342F777A6E50436152696F576C34592F6A5646634872316B57586678336C5443654B2F4F79516C323244716674447442652B417A713679502B613064594F4E6D48474473746D7539705434303743573059694563474D514A4F642B766E3572545850415A4430333230757576436279337047344E514751524563526B38413669303841464638736B4F495551713758787737477053786632373650586668594C41432F6B50386E42664B6844574561573459764B556155686E535159446366454C44584651433571782F45574A414A6F78454E334C4D49524C3476452B4170763947302F344E4363395372362F594C4C4D6B354E395033644149564978743944624E4E4E777737783144555858742F345A4258536D4E78704F4958563351444D5765452F533444527945332F6C5A4B4974725A504F354F2F667443556C3569673059526841355730445A2F6B2F62566E6935356E637475616170447339692B6865454B6E557458534E6E2F727A52484F394254746930426D706C6456314E71502B32306C634C49513133554A544571522B534C384143693938654A576B7153526B2F4C332F774A2B69452F393949464B52522F677979444368586F69716E6C4D336F7859644B6D7A63666471795971415A4135474B6C626E324E46654E30494D6643686D79485045676D555758782F384C73475253594A522B326250593239785978327238657039312F7A6A5A2B543737637A7530595268456E3237504B5834646B35476333383253395268724F6E7A42626A4273304B65754A4A5233434F71597946686A64443773424477656B4E504644514A5258427259794F3644663548666F424F7A2F494858585659624577342B7263542F54584735384248763163596A534E632F75517748652B2B6A552F555754673234454638427A526949376B563747456C4E4B50777443546D7765383853542B546E66372F4F576A77363877374F323338694656317A383730523077754F547873742F3372567232665254522B565A36762B4836775A4548344855765563615535434C357362474A63327261704F5262745358346A71694D555650437674314C5A5374795144517755776A4E2F5A7A5368543068304F7A526949564E674D35736F4A6B516D4E6E66705437577A4D505378484F467662616676'
		||	'6F4B486E6F39333158540A6851587070776347452B4B58746A36504B686D5675572B6A2B756E622F594B7A482F376E2B7A4B305A71574C4376704E572F32682F735A7873582F4B303732677568656C475751316D613566306F6B54374F306A50313354316D38382B47624D6E477946305171706A616D75344B4E647336644F2B7459327155633974384E354C394C6452546F5836415A4337776E616243714D36364737527872456577593647516274476130625533535A576A43674639483641627A53373351555A4F6B72696A65315342555550325A5831354A7476416B5777534B58586F6A456576446E63514B39305862793674454A32614B57766778686279555471516151626F6C356E3767787958353734744C314C49747A555337387264765075795946785131642F324B344B6764317A4E78703168384659546672756D4E376A4A467A307736367770433746744F723164646266513664636571637A47445033654965656371773266724F55383344446F616476372B366C316A43684F7651774D47664A56522B6B7150507A5858697A387769506A425A38743879656357716F71475977434338306B72767371795052484774544637723852576F323350626F714B777A524A666E366A55486C49627858715070774F73725964742B543830655332707A546B63535779497671727663754D776F64445044564F54343236662F58616B79776C46736343415878355474624774643668753348656651347742344475717062304A773230456A4A5A527466535674637A424D6A2B6439396C45534331706C48516A557A3734483643534B576D7557506658353967676841694659526553377639657A314D4555476B6F6D396D614466653562634C4C2F4F2F6658346842634C526D396E35793679495A326D6667482B776D632F4D7962346A48427855504931494E724A396635744952636A6E306775664939583558395066706551304E744D304D756E6D737A597533785535433372304D48424E6F393153664D5374515961547A38374E4A616B3644334F474865496241366A6B64416A4F504D67764B617279384853654D386C36696A374D37774F52536B756E594D476D593972554F3361614B6F563056726E514F327A50377031426651384669554256704545704B764D62365972516E694838516E37707734536A495250484255566E34687978493537564B503442415441686F6A766D394E6277694630776859476F765A69714B70677775647476467A534C6A2B4D41494D665538774A646A574A6A4C7761494C6933722B6F7256463975477237567A632B454332594C4866323662706847782B777730397A426754664D59325664656E372B635343557A4F634C416958727A3930'
		||	'63424653646F374745410A465854654B45666243343970497968574268796761416D414362526849464A425A38676A7A78747548622F557A57765864664F64484478313154524E42326A73425A464B6158586A76446D7A5438375131546255793837502B756346753350382B6B75334E3976304838425246576B5555796768734B5A35694C4364562F58584E6A2F586943323378546D39494B707045774D4E33796D4F66325A5773494573494B6E4A6D693378584C477A697A6E3462376E4649416F36705A6E44396B316646766837334F56732F764E4745467442392F626F2B356B38436C4663756C6B64615A65503131566E706C487A476F52326A45624E724E4A5368364151312B4277583165544D46756732504F38596344326767357A4C4B536C676C47525132386F375768675A3261563535515738546D32667A792B6F366D764C584561554B5550584E424E357A5758646E5A55716C6D48794D6A4267356C44566347484B4C6F53574142557774346F6C514875355731543139477A37326C557172336E694F4441556376634648422F6C6B696C767055627376536E43534465786451307136497170634A38334538486A712F326857597371496F304B4E546967504665534765753643756D316F79696831746E544A7A7978357371614D5A41464263794975417261724755335552664D576C363263303974576A70684F49487836455A4135474B6859364B47794A632B6366375841366769774E6344717A4A434D35454F55423057366A5074717A646B7A3173716F36644630736F772F703038394371346348722B323736426D3476724B726E4B64656A73677159764737422B4D6E32457A5964427A4C47304E6244414372315846444C415636614C494130417145517942674F2B63317953786659632B494A383345302B6A662F54446363385876442B555463463876454E553070435A67794764316676616E674F33694D325470534C5754716E4A68304F6A526A494C6F584E586D426E46427776556A72514F53655762724E70314A5451304F73506C7A61436330596946534D4C4978334C6661367658574F4C754E52784A487A414469564B3373703448377A414F394A47743174677679722F504A48364E4462307349367458466459527A4F4C6D73416C627556375250504669575669383550636A7661616E50663457365369465371366C696A664663766339554B6A6A684E347942746E657A3972366E564F4A3866455561583356366A716C56364D2B2B646176324454362F694E4A546C464E2B6650486A794354526A49464A52496775486365566177496868757334436268734173735A7545336C6C4C36455A4135474B6D6256523243547A6B50562F4A56554C6D75584972'
		||	'554C6B33334B68334A420A324E684C59745A544C32385A366D366D59757379336E3346326C4B3154797033666F413044555439715A676C666C664B584F546252767A796A706E7A6964676874523775592B5730454D76306D4E6F6B594C6B5555366B7A2F494434384C734957483654426562694C5168515866665668746961714E334972785A553744414771694A513445716E49612B6C7A2B5271375A36344F4F5A463034694D6A6E69366F46496F4F656B497A42714B34644864304A4A3435556C507A4F6132734F4C2F64524576527455584E667436794B5676432B6E3561546A784B6F535A3055754F4131684A32325A6561386C4A715270325254364258324F432B4D7668474178393558736C7262534F50744A555A715535534A48574B50313358674F596569465359664754316F64663530656356465A6C734C5776446B624D6931766E5074564D6844576C46526930756E2B68753266562B4C354A37716554576B67506A7258303935736452682F6A4575727149736D354F514C31512F4B2F626943672B74796C7778636F444D495742714B62314C457A4D4138622F65754646506B73695A4B7671753443455645417A42716E66483648774F4F5436753754346A4F683363596D543534547236356E45782B59736D326247515242464E4B4B59384242464639337864564B664352736F32522F665A464D5A46515649646F4F6733535A41652B77594C31655033384A73565256685551616F61595A514E4B75687636773272455756584B685957314F546C50512B4D626D70526D6C4E644B7961486E7A645461544334416857483436742B664C5255466462576339657763374B3273457332463344586856744E62576966304E43394D575543434B566B6F7271685834547A7138657A696554714958644B563962696E69644B3762735842552B6C484E6B4E41726C78366E2B3642416E70673570654E3257634B516C442B63494450465978333539382F79434462465A6E554A306C42462B627A683949536F52477746726F7034392B3357646A7365635559464C6E52304D4E6378554A70716F4F3273503769736D4361555631665038664534747475414B5A4B67354863554E68696C4D6C615752383765746E6773397669472B49337971714A5131675650467033723443464B4A4D442F7776707A68554F5045786C3451335573336C336E3678746C6170564762353032785642413356524C2B615130694652615473794E6F32394F30654D565A693278397030333264624F33563344584A5A6E3147787277565151492B7073494548446263782B7A716E492B66337966567368736239444A5956722F734748527275307A6F4638502B4370785751334A395377335733304859325654'
		||	'4A5A4957695539434E770A4E4D436A636E54366A6D7075512B75482F7437642F4C4E34377675395267704D2F56744C417A48324868363235676257786E716D316E4A4F4F6F444A543678555A4B584953312F4F4B3468734963576B6C316156456E705559397137324A4A6C5254494E6C7469567979504C54765032684146463078714C555A38476F356C4D7A4734674A71566F6D6552356A483343484F416631416C2B2F6F756D364935356F48436447344F336A2B643152676966374C6376322F4635662F653151412B422F79584831766B694E6A6F7741414141424A52553545726B4A6767673D3D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A202020203C456D626564646564496D616765204E616D653D226C6F676F676463223E0D0A2020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E2F396A2F34414151536B5A4A5267414241514541594142674141442F3277424441414942415149424151494341674943416749434177554441774D444177594542414D464277594842776347427763494351734A4341674B434163484367304B4367734D4441774D42776B4F4477304D4467734D44417A2F327742444151494341674D44417759444177594D434163494441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D44417A2F774141524341425A415249444153494141684542417845422F38514148774141415155424151454241514541414141414141414141414543417751464267634943516F4C2F3851417452414141674544417749454177554642415141414146394151494441415152425249684D5545474531466842794A7846444B426B61454949304B78775256533066416B4D324A7967676B4B4668635947526F6C4A69636F4B536F304E5459334F446B3651305246526B644953557054564656575631685A576D4E6B5A575A6E61476C7163335231646E643465587144684957476834694A69704B546C4A57576C35695A6D714B6A704B576D7036697071724B7A744C57327437693575734C44784D584778386A4A79744C54314E585731396A5A32754869342B546C3575666F3665727838765030396662332B506E362F38514148774541417745424151454241514542415141414141414141414543417751464267634943516F4C2F385141745245414167454342415144424163464241514141514A3341414543417845454253457842684A425551646863524D694D6F454946454B526F62484243534D7A557641'
		||	'56596E4C524368596B4E4F456C3852635947526F6D4A7967704B6A55324E7A67354F6B4E4552555A4853456C4B55315256566C64595756706A5A47566D5A326870616E4E3064585A3365486C36676F4F456859614869496D4B6B704F556C5A61586D4A6D616F714F6B7061616E714B6D7173724F3074626133754C6D367773504578636248794D6E4B3074505531646258324E6E613475506B3565626E364F6E7138765030396662332B506E362F396F4144414D424141495241784541507744392F4B4B4B4B4145626F434F314E49427A6E474B58766E4A774B2B61644D2F6273303778582F7741464A472B432B6D79787662364C34647562752B6D5677664F31447A4948574166396334504D4A3933493432313034544256712F4D3655627143636E354A645468787559554D4E794B744B7A6E4A52586D33736A36594848487052526E76326F726D4F344B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F0A6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B676A76495A627157425A466161454B7A6F447967624F4D2F58422F4B70636B74775045762B43682F77433164442B78312B797A346938584A4A442F414730592F73576A517934496D764A51524838763851586C795052445834556673722F7454367038437632772F44767853314F357574517537665632764E596C79476D76497079793358586773795353456535466654332F414158362F616E66347266744C32667738734A77326A66442B484D2B317369572B6D554D2B6638416354596E7143587234454F65756335722B6B4F414F4636564C4A3553784566657272582F41417457532B35332B666B667A483468385656612B644A5965566F346432582B4A4F37663371337950366C2F445069477A38576548724C5664507549727577314B336A757265654D3553614A31444977506F5151667871746F666A58542F456575616C59576334754A74495A49376C6B494B52794D43664C7A2F654147534F3252583557663845332F7742736A346C2B43663251705042392F45497450696C4B61427163306A2F624C6131624A654E564978734466367473384269414D425350747A2F676E487243586E67627848624E49587534395245386859355A67385941592B75536A562F4B2F464F597A796E69716E7732347438796B2B64374E4A4E704C752B2F62592F662B474D2B772B6234434F4D6F765861556571665650394F353949305555563752376F55555555414646464641425252525141555555554146464646414252525251415555555541464646464142525252514155555555414646464641425252525141'
		||	'5555555541464646464144654D447258794234312F617A765068482B30723432756C676C314C54486A2B79665A555942764E676A7768584A41487A376763396D507058313164547261326B73726E43784B575030417A5835652B4D39656B3853654A4E533147596B7A616A6453334C2F56334C4839545877584646544656383579724C4D484A715653727A4F3338735637312F4B7A5A3557665A6C484C387372347958325975337139462B4A2B5958786231485874632B4A7576366C346D6A756F746631532F6D76622F414F304B566B61615679376B353953785070587050374966374E702B4C75756E574E5868622F6848644E6B775659594639494F664C482B794F43782F447678393365422F32574E4F2F61753861577668362B30717876456B557954334D3847357253496665594D4D4D4F6F4177526B6B563955612F7744384576764350683377645A616234466C6B384F70703859524C65566D6E686C48636B6E357778504A0A4F546B39712F73664D7550734C68714D4D48626B6C6270716F72394C2B6D682F4B325663485A726D3943706A7350446D53665632636E7537583374313152386951517061784A4847717878787146525647465541634144734B39622F5A492B4E71664272346D7854336A46644A314E426158702F35356A4F566B2F344366304A727A3778313447315434622B4B4C76523958746E747232306261366E6B4D4F7A4B65366B6367316D57707978474F746667486A66676C5049566E7546743762437956534D75385730704C306164326A366677777A4374674D39574271335371586A4A50704A4B36757536617366716E61586B6439624A5044496B73557168306443475677526B45456451525534474F33417235582F414742666A7A63586B7A2B434E546B6B6D4563625461624B7A5A4B4B764C512B754D5A59656D43505376716B4849794B2B503455346A6F5A336C304D64523076704A64704C646671764B782F5455344F4C73776F6F6F7A583070415555555A6F414B4B4D305541464647614B4143696A4E47614143696969674C6852525251415555555A6F414B4B4B4B4143696A4E47614143696A4E46414252526D6A503655414646464641425252525142682F4569354E68385064646D422B6147776E63666847787238774C6F2F4F4236562B6E6E784F747A652F446A586F563561585472685239544577723877376E2F4146674865764279796C47664847416C50374E4F71313632536634483539346F546B73676E47505755552F532F77446E592B31762B4366587775547776384C7066454D796733766943516C4352796B4B45716F2F4674782F45656C665157635A3436567A7677683053507733384C7441734974757930302B434D456438'
		||	'52727A2B5058386174616A3431734E4E386261586F4D306D4E52316132754C7533542B386B445243512F675A6B2F4F76726366576E6963565571505737622B532F7953506F2B4863445477475755634F744C52562F4E766637327A77582F676F6A384A34745A3844326E6979326758375A70457177334C714D466F484F426E313275526A2F654E66484E723938312B6A76375474676D7066414C7858464941555854705A4F665656334439514B2F4F533148425072587A6669526E63635077466A49565871326F5238377461664A58666F6643593749312F72726871394657556F755576564A712F774139506D64392B7A50716B326B66487277704E43784474667878484864584F78682B5447763061422B514870785877462B7862345262785A2B30486F7A4D70614453773937496577324B51763841342B56723739786E497963562B546542744370484B4B31535877796D37664A4B372F543548374469583779504776323076320A322F4233374476777858784434736D6E6E6E76484D4F6E615A61375464616A49426B684153414655594C4F6546794F7049422B542F426E2F425254397248396F765352346A2B472F774230614C77726444665A793674654D4A4C6C4F7A4B377977427766565578373134312F77576F6554346A66384142542F345465454E616431384F5332756C7762474F49796C7A714D695476384155717171663977562B675037595837526E696A396B6234656548702F4176776E316E346B43346D4E6D39686F2F6D522F3262436B575663694F4754433842514D41653966315A547937445950425956716A477257727076333231474B57795771562B3762386A38737235706963646A6355705635556147486158754A4F556D39323947374A37575775355A2F59652B4E2F774153766A6434413165342B4B50772F6234666549644931453253323464326A76592F4C522F4F54646E3563735679475948616565316532435A6334334C6B65347234352F596F2F7743436A636E2F4141555A2B48587853734A64476234585365484E50574274552F745958445772584563362B666B78786557596A4875795431376A4666496E37526E677234452B41764248694B2B3048397144346B2B492F69646F396E4A63326C7A623672635831766458534B53735A65474D71675A68747A3575467A6B6E6731784C6875646648564D505769364D6B3137735975615630745730335A61333365353379347170346641553852516B7130576E3730704B44646D39456D7458386C7366734877464A3641392B314A4849736A59444B63652B612F484878332B3239386466695A2F775358385061337057726132382B6D2B49376A5250456575324734587A577363535043306B69664D'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'696B7962586B474353695A507A485030622F77544A2B42767778312F5539422B495867443435664548784C633654464A4E712F6837564E59425233654234324678613444414B37373162356C4A51594A36314F4D34526E684D504F76694B6E77796C464B4D584C575064723462394C6C59486A57474D784D4B4748704F306F786B334A706150657966785736325A2B674A64554A79526B657078536C67526E67672F6C58343665442F77427062776E2F414D4643506A39342F7742612B4D337870313334632B43644A754567384C614459616D624154526C70414A446857444D716F70596B456C70656F4141716638415A582F62502B4A4867507868386250684E384F664631393855625379305338762F412B70586B7A586C7972516C442B364C66665977504977546F5A596C41487A45486F716344596D4D5A52633754696F75536161696C4B3230336F327233667A3373633950784177387071587337776B354B4C54546B33472B0A3846716B3757522B77586D716367736F783739616363384841774B2F48542F41494A3566443377682B31366B332F435966482F414F4B6E686E347A2F6135466E734A4E61617A4D6F442F4949664D356C4F507649474441352B554442503743574E754C4C543459764D655951527170647A6C6E774D5A507561385450736C575856765963376C4A5876377253395533756E3061506634657A31356E5265493546434F6C766554666D6D6C7331325A4D58433953416665767A392F624D2F62662B4A66776E2F344B6F66444C346261423468537938472B496A706E322B784E6A627947667A726D534F543934794631797167634D4D5934727862776E4834732F344B766638464B2F694234613172787A346F384C2B412F416B6C30747459614E657441664C676E467447464833524A49325A47637154314134786A682F6A6E38484E612B41582F42596234522B474E56385661313477744C472F3064744A7674576C4574386C6F317978454D6A6A373553547A41475038414474394B2B7779626872443462455470346D635A315059796D344F4E3147367574586F32767736487847666356346E453465465443303551702B326A4654556C6432646E644B7A535A2B3065344B6F4A4B6774575A3479314B58537643477158567334576533744A5A59327744745A554A42776663562B532F696A39714C517632345032315048326C2F466A34756176384E50686E344F6C6C734E4630375464536178462F4A484D5968497A6257444D51724F78494F4E79675941725A2F59522F616A765068392B327234332B4447692F455055666954384D4E583071376B30472B76626F33625176485A2F6142736B5049415553527342685379676743764D2F774253635254'
		||	'6735796C37304971636F38727479364E705332636B6E64723131505758486C43704E516A44335A5363464C6D562B62564A754F365461305A37742F7752452F624D2B4933375950686A346858587842313564646E304B367334724E685A5157336B72496B706359695263354B44726E7058324C38592F693934652B4176773131667862346F7634744E305052494463584D7A386E48514B6F3673374568516F354A4946666E542F776254382B437669774D342F30335476384130585058582F384142786E3470314C537632575043476D577A535236667133694A6674685849442B58424B306148324C48646A3151656C625A746B7448456355764C36615549536C465753736B75564E325731392F6D5A5A506E746644634A724D616A633578556E64747474387A53752B79302B526E614E2F77414663506A742B314E726C37503843666761757265484C4755772F77426F61744B7838346A6E42595046456A59494F774F354765764E0A66545037422F37513378622B4E73666969782B4C66773248772F3154773839734C65534E334D477069555337696D3473506B3874636C58623734366439582F676D7234513076775A2B776A384B7262536F3430677550446C7065796C5034353534784E4D7839535A486175722F61733043303855664158784670313934346E2B4846726452786958784444647261796165676C526D4B794D79685379715579542F48333656356561597642547254774F477736676C4C6C557665636C5A3275396462727062305055796E43592B46434759346E45756263655A783931526431644A616157303176305052764D5134415A536672536C676F42794436562B4B7637577476384866672F384F62377846384950326A50695A726E7844306934695A51326F58647862332B5A4657544536524C4770414A664A636737636335465876322B763276504833696234462F73712B4F72485874557364653158544C7561385733756E686876376D33754C564138716F5147444D704A42342B636976526F6343564B37704F6C55616A4E7550765263576D6F75577A6571615736504E722B494E4F67717171306B3551555A65374E5354546B6F3770614E4E37575031482F624A766669645A664158564A50672F427039333437576144374848646D495247507A563833506D6B4A2F7139335531384F663846455032332F32682F32522F77426D2F774343302B7036785A6547766942346A62565234696A74374F7A756F5A54444C463541584B756934696B552F496553787A794B716674672F736A2B4F76325366324A666952385264652B4C6E697A78503430385551615A46656B5450424459534E66774F34675A587946484B4441554665774846664D76376433695455'
		||	'5046662F424F6A396C4F38315338764E54763775487845306C7A6379744E4C4B526477714E7A4D53536359485059563766444F5134615536446268567075704B4C62693774716E4A3275393470374B323675654478567844696C43757254705646536A4A4A54566B6E5553765A4C5354573776733748376D65467453625650446D6E584D7A7130303974484935365A4C4943542B5A7252376339442B46666C722B325A2B7756347A2B466637483076786D6D2B4C667841757669526F566C61616A664975706D4C543474375271384E7569594D6178372F6C7763454A303534347634332F3841425654783134702F59512B44656A5733695639413855654F3572697838516549305978543239766133437765614758376A4F47444F793450794E6A47612B666F38477A78696A56774656546935754C306135576C7A4E2B617473394C396A364F72787848424F564C4D4B4C684A51556F36703879625353386E64363636647A3966524D0A474F464B7354364870546778596A73445834712F744F2B4F66427637484F6C654666473377452F61473854654C7646734F7078783678703933724A765972794D7875356C614C61716D506567566C62642F725279434D312B776677592B49432F466A3451654676464349496B3852365461366B454852504F695754622B47374665526E4F51547746476E694F5A796A4E744B3858467072756E3065365A3757526353527A4374557737687979676B335A71536165316D757136726F6454525252587A3539515672753053387335594847556D516F3375434D562B59337846384833586758786C71656B58614D6C7870747938445A474E7744634D50596A424239434B2F55444A347A6A4272357A2F62512F5A66757669475638542B4872667A7457676A4564356171506E75304852313958556359376A486359507866464C783242723462503874687A31634D3233482B61456C615330363232504C7A724A365761594770674B72747A4C667331716E3935364A2B79743852495069503845744475456E5357367372644C4F3654634338636B6168547548597341472B6A56345438646669686536462F7756342B446568504A496D6E3366686E55555564465A35764E5A683963327358365635503844666A5A7258374F2F6A4B573467696B6B745A5349372F41452B624B6561416663664B3638344F505931364C38614E5A3054396F663841614A2B42337846384D544136703450316C344E58735A68356431445A547068704D6448574E676337536343516E6F446A362F67376A6A497331727A713071716A7A77714C6B6C704B4D6E4632545433313054562B68382F56686A6F594B6E68713857716C4F554C7458616C465356326E357256706E7638412B'
		||	'324A347668384A66732F36385A5A5653625559785A514B5467794E4951434236345863666F4458352F77524D64714B475A6D4F41414D6B6E307236452F615A3854654A2F7742707234675136563463304C57626E5274475972446D32614E5A70447730724534436A417775346A6A6E6A4A4665692F737A2F7354772B41627933313378535962335634735357396F6E7A51326A646D592F7875507942396544583468787656782F46324A7035486C6B57734E546B3554714E4E526374744831555674626476736654346241526A6A5A5A68562B4C6C5559727372336239572F7752712F7351664171342B4758676962574E56746D67316E58434738755253736C744150757151655157507A4566377565525875334248714B6267706A4234464F427A36312B745A426B74444B6344547747482B474374667133316239576438354F54757A34712F344B34663845344E592F62453066516647486761356974766946344F5572625179530A434A4E5267336951494A44776B69506C6B4A344F3567635A4248442B46762B436E66783638456543446F486A62396D44346A3631346E302B455773742F70466A63505A33726864706B796B45696A505537485A636E6A41347239432B656D51442B644E4B422B774A487258336D483468746859595446306F3159776263627553636236744A7861756E325A386E697547723471654D776461564B56524A53736B314B32696254547331354834742F737666734D664772785038417354664833545966422F69587731712F6971343071357362445562647247665634344A35704A34465758613333575538674269414F3572312F7743447678423864322F2F414154323150344E65467632612F482F41496638597A2B487271773148557233526D302F54626A4D544C4C64656249424A4E63534C6E6245716B6C32414232697631484334414741445342514F53415065765478664731624579637131474C764E5453764A4A4E4A4A587339566F747A79634C774652773056476A576B6D6F7544646B32314A747531316F3774366F2F4C372F676E7634352B4A2F374476374555466C6566416E783734746C31587854664C71576C7270303046376257787437665A4B4958694A6B527A7558706737547A584366444C3443654E2F6A4E2F7755673849654E66686A384566476E774D384D5745304D6D754E71646E4E70747663526279626A434F717069534D2B5835555949505567636B66723651754F414D5567494249436A49724E635954565374586A52697031564A5364355739372B37666C64756C306150676945716448447A7279634B545453744650547A74645836366E354B66442F38415A6B3855663845302F77426F6A786A5A367A384137723434'
		||	'2F4466785063435853723754394754563732775247636F4E766C755562624A746457436869696B4E787A39452F427A3438582F396D654D2F46766733396B625676423135345830354A644C573930534C53745331755635565753336A56596736674957596C64774F336E30503343414D484942393656514153414D4375624863545378623970694B536C4E704A75386C7A5774756B375861566E5A48566775456F3450334D4E5763594A74706373573166733272364E335078312F62326738546674325857697634562F5A542B4A586776346B7958386258586947343075613169644170477835664C534E2F6D4B6B537946536F5467344A7239572F6752346531337772384566434F6C654B6234366E346C302F527257323157364C626A63335377717372353735634D63392B74646674415051412F536C78304F4D34726B7A58506E693850537773616168476D3231724A76587065546274706F6C6F646D54384F4C4134697269700A56484F56524A50524A6164624A4A5866566E35556150384E2F696C2F7741457950384167704E3432385A3654384D50462F784938422B50487570424A3465302B57376C6969754A31754150336173456B696B477A443751793549505048502F4142523846664762396F2F2F41494B662F437A346F3678384A664750687677355066366131764531684E634E70646E44636B627278305462444954766B4B4E6771724C6E315036374541344241346F5656474146414E6572446A4B6F70653264474C714F484935586C6478746139723276747259386D707750546C4832437279564A5435314779736E6539723276627975666C467250374B506937396762397458786C346F7566676E50384148483461654F626957347430734E4A54553772546A4A4B5A7549696A6C4851737963674B36344F344867665250374D2F6A36302B4C2F6A7A573474492F5A61315434563256686F64334A44723272654859744C765A4C6C6C4561775249496C59373064386C575054474F612B3157554E676E474237556251704A41417A3759726B786E46453856465372553035714B6A7A4A795637624E71396D3765577031595068476E685A74554B6A5547322B56714C7466644A7458537674726F666E522F77623866413778703846664350784E6938592B452F456E685758554C797865325856744F6D736D7541736377596F4A46586341534D34365A466656482F425144396A327A2F62642F5A76315477584E644A5961694A5676394B753351737472647837746859446E617973794E6A6E446B395258747967453867556F354875613473646E2B4978475A6632704833616C3031625A4E4A4A622B68364F413464772B4879762B79704E79685A70333062556D323976'
		||	'552F4C6E396D443970503970542F676E6A3449672B4748697A3443654C50694670576773363658714768785433496A685A6977547A59597055644153536F4F316744676A6759785032384E5A2B50582F425337396E65366E74766776347738465766676A563462722B78727947646233575935495A6C61574F4F534F4D796D456852745253663378497A322F574861447951434437556D464241774D31366B654B345278537830634C42566233636C7A5762367531374B2B76336E6A79345071537772774573584E30725755576F3353364B39727532682B586637532F784238662F74462F38452F4C7A3462664433396E44782F344B743950744C4936764871476947785862464C45336C574D49486D334C74496F596B49434556696554586A6E37542F374C48784E38532F73662F73726164702F77383862586D7065484C625634745674496445756E6E30316D7659436E6E49453352376C425A6477475143526B562B302B3045660A64474B43426A424149726643636131634D6F786F306F70526C4B653762626C46786432322B6A2F4247474C344570596C796C57725362635977325353555A4B53736B6C3152387466384667766837722F414D542F4150676E313472305477336F757165494E59755A74504D566A7039704A64584D675737685A6973614173634B435467634145312B6666375633374A2F785138582F73476673756548394D2B486E6A4F38316A51344E6654564C574C52626C35394D615739674D586E6F454C526231444D4E774751704936562B303735564734794150544A7278727739346D38633248776A316D4B505364613150785064586B38656E33467771774B38547A424575437234454952474C2B5565766C6E483368555A44784A694D48537030365559766B6E7A726D64727555584858705A493134683456772B4E725471565A5358505455585A4A32555A4B576E6D326A34702F62472F614C2B4F33784D2F5A4E6E2B42397A38427669444C347975343758537456313678734A6272523770496E516D6143614E437045757853647841514D3254786975622B4F502F4249583467614C2B78463849626E514E4E73745A38662F44743769393166524379534C6472635469344D615A2B53526F79717155364F433243634148394B2F675266363764664337513762785462586B6669537A302B4350555A4A3058453834557137426C2B566953705934342B596574636C3457315478626366434C784A4A7145766944542F45657248554A624F5837413977644B47386942566A78686971794A674C6B4E356248504272717733464F4A773171654568436D6F7A356E5A74715461616537656C72376261484C694F4563506972316362556C4E79687978625354696B'
		||	'3031736B6D37323333506A7A532F326C62585550444E7261786673472B4A4434716B5659325366775A4642706F6C36467650613379457A7A796F2B7665763056384D61624470486833543757327359644D677437614F4F4F306852556A74564367434E5658674B6F3441484178586B6E6A71792B49586A6A774E344F302F772F4C715868585555557A367A647A6B54764269794F49775370383469655A446A41446D426C4A417A5873316C4F62757A686C4B53526D5246626249753131794D3449374831466650357869595659776349714F72756C4B556E765A58356D30764B33512B69795042546F536B70796374465A754D59394C75316B6D2F4F2F55736A6F4D644B4B4B4B384D2B6A436A415055413055556D674D58572F68376F5869615553366A6F756C58386F365063576B6372666D774A71665176422B6C654749796D6D366259616572645262573678412F38416649466154394B452B364B356F344844786E37574D467A0A64374B2F336A625942514F514144394B576969756C52533251676F6F6F7067464646464142525252514155555555414646464641425252525141555555554146464646414252525251415555555541464646464142523759346F6F6F4150776F774F6D42696969674C4252525251415555555541662F396B3D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A202020203C456D626564646564496D616765204E616D653D226C6F676F656669676173223E0D0A2020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E2F396A2F34525578525868705A674141545530414B674141414167414277455341414D41414141424141454141414561414155414141414241414141596745624141554141414142414141416167456F41414D41414141424141494141414578414149414141416341414141636745794141494141414155414141416A6F647041415141414141424141414170414141414E41414C6362414141416E45414174787341414143635151575276596D5567554768766447397A6147397749454E544E5342586157356B6233647A414449774D5449364D5441364D4449674D4467364D6A45364D6A5941414141414136414241414D414141414241414541414B41434141514141414142414141465236414441415141414141424141414332774141414141414141414741514D4141774141414145414267414141526F414251414141414541414145654152734142514141414145414141456D415367414177414141414541416741414167454142414141414145414141457541674941424141414141'
		||	'4541414250374141414141414141414567414141414241414141534141414141482F32502F74414178425A4739695A563944545141422F2B3441446B466B62324A6C414753414141414141662F62414951414441674943416B4944416B4A4442454C436773524651384D4441385647424D5446524D544742454D4441774D444177524441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441454E4377734E44673051446734514641344F446851554467344F446851524441774D444177524551774D4441774D4442454D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D2F3841414551674156774367417745694141495241514D5241662F644141514143762F4541543841414145464151454241514542414141414141414141414D41415149454251594843416B4B43774541415155424151454241514541414141414141414141514143417751464267634943516F4C454141424241454441675143425163474341554444444D424141495241775168456A45465156466845794A7867544947464A47687355496A4A4256537757497A4E484B4330554D484A5A4A54384F487859334D3146714B7967795A456B31526B52634B6A64445958306C58695A664B7A684D50546465507A52696555704957306C6354553550536C74635856356656575A6E61476C7161327874626D396A6448563264336835656E74386658352F6352414149434151494542414D4542515948427759464E5145414168454449544553424546525958456945775579675A45556F624643493846533066417A4A474C68636F4B530A51314D5659334D303853554746714B796777636D4E634C53524A4E556F78646B525655326447586938724F4577394E31342F4E476C4B5346744A5845314F54307062584631655831566D5A326870616D747362573576596E4E3064585A3365486C366533782F2F61414177444151414345514D524144384139565353535355706334667243322F363455394A70644E464E647262434F485A47305762645038417550557978763841787237503945722F414E5A4F726A6F2F536263735236377630654F3039375866512F37623931722F414F5257764C4D504E767738326E4F724A666454594C5A6364586D5A73443366384E3732762F72713579764C653547636A324D5966332B375335766D76616E6A674F346C502B342B7A704B766835754E6D5964656251384F6F745948746449304866662B36356E306250334532486D3135677366547255783278722F414E3467427A6E4166756535555A536A47596849314F563148394C302F4D3352714C476F37746C4A4A4A4F55704A4A4A4A536B6B6B'
		||	'6B6C4B5353535355704A4A4A4A536B6B6B6B6C4B53535353552F2F3050565549354659795734785036527A445942354168762F41483546584D64627A4831645664637737585972576870487739535037587162484B747A664D4842474245544D7A79517869492B6158482B366B41616B6D67415A452B547A7631383672397336754D4F737A52674462707762587736302F3247374B762B33567A5770304770504143765A65426C4F7473764476584E6A6E57506353412F633437336C302F796972474630363747325835645436724C424E4462476C76742F7742493364394A7A6C306B4F44486A6A454548684666336938336D79484C6B6C6B50552F59503057373069374B77734E324862616673397A2F5566534F47482F582B645A3942646C395772576E4875702F4F592F663841325841522F774251754D5770306A5074785874755A376A583748744F6D35683132726E2F414976696A687A592F694F7568396E6D423039764A36595A596A3948676E383337377066432B5A6C4B2B586B62303473582B4438304875456B4C47796173716874394A6C6A2F76423774642F4B616971534D684943555459497345646E52556B68666173622F544D2F774134663370666173622F41457A50383466337031487369783343564A4474794B4B4B5466645979716C6F6C31723342725144334C3365315A315831702B723131374D65724F72646259344D59305471357832746131323362376E49694570416B524A726567677A6A4567475146375758565357626A2F41466A36486B35444D616A4E7173757364745A5730366B69645038416F7253516C4755666D42486D4B5447555A617849506B620A556B6B6B676C53535353536C4A4A4A4A4B662F2F52395658446461744C736A495037397A68386D6E2F414D78617535586E2F5579546351663337442F306C586E415435336B594862334A3566384C426A6C6C682F7A6D486D3547504B35694F7352442F77795874792F3653626F48544231485041734534394557584473663946562F626350662F7762463275526A555A564C716369747474542B577545685A6E3156786D30394A5A62487679584F7463664B646C662F67624772595637506B4D73686F2F4A6F474C6B634559594259733552785376744C35592F77434B38463172704C756C355972424C3865304631447A7A412B6E572F38416C316F4F4564624235412F6975732B74574F32376F396C6B653748633231702B4232502F4150416E76584B595130736435676678566634746C4576684F6379333945664F587659324444673972346A6A45666C496C4D6631596D4539486F5071336B755A6B57597850737462766150355459422F7A6D6639517567732F6D3366412F6B584C394261'
		||	'58645472492F4E6139782B4562663841767936697A2B626438442B525A2F77576370636F424C3943636F782F752F4E2F33547135642F6F2B4E394636582B314D3748774B334E7166654851397A5A41327364623945522B34756C502B4C504D49492B3255616A2F52752F38414A4C6D756B555A2B546D5555644F63356D593848306E4D65613343474F632B4C51573750306258726F6A3044362F38412F63692F2F77426A48663841705264586E6E4D5348446D686A302B5764582F6563486C34774D535A595A35547848315132386B663179366A512B6A41365052643668366344586C7444584E623674626136716A37783776384E74326F333159366639567369334161374B7564316A6532373032687A5742395836783657745870624774712F77424A2B6B556638594854734C447A7365374772394F7A4D39577A49647563647A67616F6444334F617A3654766F4C642B714851656B74366467645746455A33706C33726233387544366E666F392F706651642B346F4A5A497835574A426D4F4B3672682B6338587A2F314765474F6375636B4349533442486669394D42772F4A2F58637A6F324639546D6462787A6864517972633174727A585539734D4C774C4E375848374C582F4C2F414D49756D3676395A4F6B39486332764D7450724F47357446594C33782B383572666F4E2F77434D584166566E2F785734332F6869372F716230444271663841574C367873626B504C546E58506661344753474E4472665459585439476D723061763345736E4C786C6B7563354745496355722B62394C2F414C3157506D6A4847426A684554795A4443494879366350712F357A33565831362B0A7262367655646B50714D77613331763366474B32763971764D2B735852374F6D576456626566735654746A375378346832357463656E7339583662322F6D4C6B767274304470485373484774774D6630624833656D35323937706273652F2F4350662B6331482B727A4F6C32665571356E56725454684F79536248416B4537583132735933614850384165356E2B442F534B475744436363636B4F4F705445613034712F53345765504D5A786C6C696E775847426C78432B472B6E453654763859503166446F48727548377772302F77436B3572762B6974667066572B6C395759353242654C545848714D494C58746E393675774E662F622B6775477975722F55555647696A704E7275514C435257372B733278317237763841505658366B32574D2B737549316A6F39527472482B626654665A74642F7742637272656E79355342787A6B497A786D41347658772B716D4F504F544757454A53686B457A772F712B4C30766439552B7458524F6C326D6A49764C38687346314E545339776E392F'
		||	'62374B2F36746A3044412B7576516332396D4F3279796D3631775A5732327477334F6364724737323732653533377A6C357A695756343355772F71324F374B394F783332764865347463352F75336C37767A6E2B722B6B39333836757377482F556A716D66696E457266307A4F7175727370615236626243787773394B47757478766674322F6D582F414F6A536E796D4F4564524F576C2B354775482F414256592B63795A4A36484844316350747A766A492F76502F394C3156634A31756B3135566F694E6C7A78386E6E6578643275652B736D42372F745962757173415A663545614D65663633305656357163734D73504E434A6C39326E785469506D396E4A45347376442F57345A4C63754C337355385631786A512F31342B75482F4F64443676324E73364C6946763574595966697A3947372F704E514F6F5A7A36767248306E436134686C374D6C316A65784C574D4E582F414B4E5754304C71523656592B6A4A4A6467326E634C514A394E2F6631415038472F38414F2F6C717831373266574836763953714966532B312B4F62476B4673334E2F5251346636543949722B47654C4E49354D63686B787A6A4D776C483937676C365A66757A6A2B354A72696368696A47514D4D6D4D343435496E656F796A36682B394358377A712F574A345A30544C4A373137666D34686A662B71584A304D394F70725479666337346C626E316C7A4732755A67744D7472634C4C2F43522F4D31662B6A62502B7466767174307A704E3261345757417378706B764F68662F4A722F41505369772F6975655766322B517765755848377561766C69666B78776C4C2B72367035502B70746E466A48760A537A7930715074512B336A6E4C2F75472F38415676454C6133356A682F4F657976384171672B393339702F2F6E74624E6E3832373448386954477459304D594131725141316F34414841546B546F65466F38727938655877777844586847702F656C2B6B56306A78456C38633646314D644B36686A6451324337304137394875327A765936723663503841394A2B367572502B4D3241542B7A52702F7741502F77436F46316E3745364D502B30474E2F774273312F38416B4576324A30622F414C6759332F624C502F494C5479637A677948696E694A4E5638316166527A38584B387869426A444B49784A347134622F4E3476362F3549795739497959326576512B7A624D787639422B336470753558552F564458367464506A2F41455838584C51753664302B384D6266693032696F6261772B747267306165316D35767362375557716D71697474564C47315673454E597742725150354C572B3151354D305A59593467434F456B332F41497A506A77536A6E6E6C4D67654F496A396A356439'
		||	'5753502B64324C71503652642F314E36486D305A7631593639366A4737445261352B4B3934396C6C526B6264333533364B7A3072747630463664583076706C566F7671784B4B376D6B75466A613242774A2B6B34506133642B6375542B735831703670307A7247546832346C57546741734E51757263415A7259352B79332B62662B6C4C2F7A466178387763755569454C426877796849317855662F5132706B35614F4C45444F5A424754696A4F49766834762F5258472B7358316E797576596C58366D4D664670743174446A59446274642B6A39585A5657333947584F395036614464546B4F2B702B4C63774534394F6263626F34426341796D782F386E366465372F68564C7148564F722F5761796A46783854394853663057506A4E4F304633743332324F69746E395A3370563172762B6739486230336F7458547277323178613435476B746336776C31724964394F7633656C2F5554386D534F444841634969524C69397348693950384165575973557559795A4478475554446839776A67395868463544367366576A7058534F6E2F5A6A68575764516539305071613178754C6A2B685A764C7655622F414B4C5A73575A3954334676316B7843434E774678386466527558704F4C3062704F486236324C6830555736785979747258436564726D6A32716450532B6D555774756F77364B72577A74735A5778726849327532756133643945714138336A2F57384D4A586C47704A36367467636E6B764478546A5745324149384F6E7065484831722B7258567157763637307A646C6251485855414759483574752B7249722F3476332F3841474C4471786D645136343348364C585A0A58585A61303437586E632B706F4C5A7574633364745A5337394A394C2F77414558714752304C6F755538325A4744525A59347935357262754A2F6C506A633548784D4843776D6C6D486A313437586653465447736D5033746747354B504E34344138455A416B664C4B58466A6A39465335504A6B6B50636E4567472B4B4D65484A4C2F43662F2F543956544F61317A533177426152424231424254704A4B6375373676594C336271792B6E2B53776A62397A7735506A64417773665464593975345038415463364762326B574D744664595933314750627539526161466B354E4F4C53623779577361514E4158456C784662474D59774F653937337561786A474B4448796543452B50486A455A6E397A302F38414E6971557248713141376F4B2B6B644E726636676F446E544D764C6E366E3837394B353675494E65585337482B30506D6D7354753959477369447439337162564E3974565A61327837574F734F3167635143342F75746E36536C6869686A73516749576465475044722F677134'
		||	'7231746D6B6D4A445153544147704A55426B3437713357747459616D45683777346251573650334F2B6A3755366C57456953452F4B786D5755315074614C4D6966526154712F614E37746E373374524135704D41676E58384F55714B4C433653476369687264377247426F49615846776A6365472F317456455A56527933596D767174724670303032754C6D443366316D493065797248644D6B6F7673727262757363474E3858454166696B3679746A6D7465344E633877774567456E6D472F7649556D326C316A4E7677735A6C3157316A445947333376616247307349642B6E6654572B70396A5056394F7032327A3946367632682F364B6C3644395965732F736E42395373316E4B733343686C7274725473613636317A39513761327174333066384E364E582B465633497873484A74714F5179753279676D796F50676C704733394931702F643969616E47774844316161366E4E654C414874414949746436755237762B477439397637366B69596A684A695452312F726474574F516B65494167574E442B373330543176625A5732786D7258674F616649367250717A38713772562B477742754C6A4E6148754E543346316A6D2B713572636B5062545436624C63663947367578373066455A30326D2B374878425779367474667256316741686F6236655076412F7743435A74722F414A436237443071343335586F30764F5378316552614144765A4870324D73662B6333394873642F555148434C734855656E54756B385234614930507131333455597A736B3962646750446171505239576D5775633636447475645863487472702B7A506656767066572B782F71656F684E360A6C6E5764626668565642324C533456334F32506B54563970396237542F41456236646D4E52396C2F70483654312F7743617255325539467932355759366D6F693075707962724767626857665463317A3366344839477256744F417752613274677575592F33514E397A53313154763564333647765A2F786164635270776D2B486832326C2B38744845646549567863572B386630597638412F395431564A664B7153536E36715648713141756F7269786C56746431646C487147477573593763796C332F414233383337666F667A6E70324C356A53546F5878437437577A72685046745439483259576258694E6266625543374B4E6E7033584F654257574F62396E707A4D71717933314E2F36622B5A2B68366C4666702F7A71453343653276704C614C38635830555573646436676348314E6452366E70593736725058717563797630726D57593974646E706670463836704B62395A2F56335038697766712F77437473507A3650314231536F58644D79366E505A57327969787073734D4D'
		||	'61484D633366596639473338395A70786F6F795859642B4C737379736434624C6467446138577355377474724B62726654592B68337057667A6C50702F6D57562F4F4B535A6A3436307172362F774343795A4F43396275756E2B452F527546694E7071364D33317361783141653173506E65317A66357A45647463367A5A37505A2F34496959474B2B767162582B706A75726163335A73734A736362723662725A71326257665A5874394337394A5A372F7744522F774132766D354A4F507561335836582F64332F414F7046736662394E582B6A2B5750682F7744556239433234564A2B722B486A596D526843686C543637624E7A5257392F6F325632323158745A5A39463371573337665473745A763333562F705055314D5848637A714C62445A57373954727263774F6C3874633469774E6A335576334F2F53667946387A4A495339796A64667058333339536F2B337844687639477532337066704436776D73573442736251396F73746C7555344D715036433664377979332F414D392F51514D7A4174464F4251334B7833313030304E443758426A336D75334764367A4837626E324D79505472725A583674663661786E39492F522B6E38374A4977343668773139653979525067764A785839503365474C39493359395871395A4E562B4B334D7671477239726A577756437476327472702F51626D7566372F7742456A39456F6452546B626E31764E6D51393546542F414641306B4D3356766674722F536268377659766D644A4E504877473672302B66797834563065446A4658667138766D6C7850306E66694D74794F724D46394E66326E486178396A584431616A73665876750A72397636505937315750395656575964646E5463367A31734F717532326D783156566D3746614B57343776527573323137575A6464625758666F66365062582B6A742F77414A38374A4A30666372537630662B3534662F55614A653165742F702F393378662B7048364C474B5734444C445A694F4E65645A663652732F56334F652B3167785858625035327179373150356A2B6C302F7A615959446D3466544B364D696A375256573730736A314274394A7871633975506A7672755A6C347266304C472B2B697A2B59395049703952664F715350367A772B592F39312F7A666E572F712F3633796A2F75662B64386E2F714E2F396E2F37527A69554768766447397A6147397749444D754D414134516B6C4E42415141414141414142386341566F414178736C527877434141414379426B6341675541433278765A3238675A575A705A32467A41446843535530454A51414141414141454D462F632F496173542B7A78506D304C30767376384934516B6C4E42446F4141414141414F7341414141'
		||	'514141414141514141414141414333427961573530543356306348563041414141426741414141424462484A545A573531625141414141424462484A544141414141464A48516B4D4141414141546D3067494652465746514141414152414545415A414276414749415A5141674146494152774243414341414B41417841446B414F51413441436B41414141414141424A626E526C5A573531625141414141424A626E526C4141414141454E73636D3041414141415458424362474A766232774241414141443342796157353055326C346447566C626B4A7064474A76623277414141414143334279615735305A584A4F5957316C56455659564141414142514153774235414738415977426C41484941595141674145594155774174414449414D4141774144414152414167414573415741414141446843535530454F77414141414142736741414142414141414142414141414141415363484A70626E52506458527764585250634852706232357A41414141456741414141424463485275596D3976624141414141414151327869636D4A76623277414141414141464A6E63303169623239734141414141414244636D3544596D397662414141414141415132353051324A7662327741414141414145786962484E6962323973414141414141424F5A335232596D397662414141414141415257317352474A76623277414141414141456C7564484A696232397341414141414142435932746E54324A715977414141414541414141414141425352304A444141414141774141414142535A4341675A473931596B4276344141414141414141414141414564796269426B62335669510A472F67414141414141414141414141516D77674947527664574A41622B4141414141414141414141414243636D52555657353052694E536248514141414141414141414141414141414243624751675657353052694E536248514141414141414141414141414141414253633278305657353052694E5165477841637341414141414141414141414170325A574E3062334A4559585268596D39766241454141414141554764516332567564573041414141415547645163774141414142515A314244414141414145786C5A6E5256626E524749314A73644141414141414141414141414141414146527663434256626E524749314A736441414141414141414141414141414141464E6A62434256626E5247493142795930425A41414141414141414F454A4A5451507441414141414141514153774141414142414149424C41414141414541416A6843535530454A674141414141414467414141414141414141414141412F674141414F454A4A5451514E4141414141414145414141416544'
		||	'68435355304547514141414141414241414141423434516B6C4E412F4D414141414141416B414141414141414141414145414F454A4A54536351414141414141414B414145414141414141414141416A6843535530443951414141414141534141765A6D5941415142735A6D59414267414141414141415141765A6D5941415143686D5A6F41426741414141414141514179414141414151426141414141426741414141414141514131414141414151417441414141426741414141414141546843535530442B41414141414141634141412F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F77506F4141414141502F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F3844364141414141442F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F412B6741414141412F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F2F77506F41414134516B6C4E42414141414141414141494141446843535530454167414141414141416741414F454A4A54515177414141414141414241514134516B6C4E4243304141414141414159414151414141414934516B6C4E424167414141414141424141414141424141414351414141416B4141414141414F454A4A545151654141414141414145414141414144684353553045476741414141414453774141414159414141414141414141414141414174734141415648414141414377424D414738415A774276414341415251426D41476B415A77426841484D41414141424141414141414141414141414141414141414141414141414141454141414141414141410A414141414255634141414C624141414141414141414141414141414141414141414145414141414141414141414141414141414141414141414141414541414141414541414141414141427564577873414141414167414141415A69623356755A484E50596D706A41414141415141414141414141464A6A64444541414141454141414141465276634342736232356E41414141414141414141424D5A575A30624739755A7741414141414141414141516E527662577876626D634141414C624141414141464A6E614852736232356E414141465277414141415A7A62476C6A5A584E576245787A4141414141553969616D4D414141414241414141414141466332787059325541414141534141414142334E7361574E6C535552736232356E41414141414141414141646E636D393163456C45624739755A774141414141414141414762334A705A326C755A57353162514141414178465532787059325650636D6C6E615734414141414E595856306230646C626D56795958526C5A41414141'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'4142556558426C5A573531625141414141704655327870593256556558426C4141414141456C745A79414141414147596D3931626D527A54324A71597741414141454141414141414142535933517841414141424141414141425562334167624739755A77414141414141414141415447566D64477876626D6341414141414141414141454A30623231736232356E4141414332774141414142535A326830624739755A774141425563414141414464584A73564556595641414141414541414141414141427564577873564556595641414141414541414141414141424E6332646C5645565956414141414145414141414141415A68624852555957645552566855414141414151414141414141446D4E6C624778555A58683053584E495645314D596D39766241454141414149593256736246526C654852555256685541414141415141414141414143576876636E704262476C6E626D5675645730414141415052564E7361574E6C53473979656B467361576475414141414232526C5A6D4631624851414141414A646D567964454673615764755A573531625141414141394655327870593256575A584A30515778705A323441414141485A47566D5958567364414141414174695A304E766247397956486C775A575675645730414141415252564E7361574E6C516B644462327876636C52356347554141414141546D39755A51414141416C30623342506458527A5A5852736232356E4141414141414141414170735A575A305433563063325630624739755A774141414141414141414D596D3930644739745433563063325630624739755A774141414141414141414C636D6C0A6E614852506458527A5A5852736232356E4141414141414134516B6C4E42436741414141414141774141414143502F41414141414141414134516B6C4E424251414141414141415141414141434F454A4A5451514D41414141414251584141414141514141414B41414141425841414142344141416F794141414250374142674141662F592F2B30414445466B62324A6C58304E4E4141482F3767414F51575276596D55415A494141414141422F3973416841414D434167494351674D43516B4D4551734B437845564477774D4478555945784D5645784D594551774D4441774D4442454D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4151304C4377304F4452414F446841554467344F4642514F4467344F4642454D4441774D444245524441774D4441774D4551774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D44417A2F7741415243414258414B41444153494141684542417845422F3930414241414B'
		||	'2F38514250774141415155424151454241514541414141414141414141774142416751464267634943516F4C41514142425145424151454241514141414141414141414241414944424155474277674A436773514141454541514D43424149464277594942514D4D4D77454141684544424345534D51564255574554496E47424D6759556B61477851694D6B46564C42596A4D30636F4C525177636C6B6C50773466466A637A55576F724B444A6B53545647524677714E304E68665356654A6C38724F4577394E31342F4E474A35536B68625356784E546B394B57317864586C39565A6D646F615770726247317562324E3064585A3365486C3665337839666E3978454141674942416751454177514642676348426755314151414345514D684D524945515646686353495442544B426B5253687355496A77564C5238444D6B5975467967704A445578566A637A54784A5159576F724B444279593177744A456B31536A4632524656545A305A654C79733454443033586A38306155704957306C6354553550536C74635856356656575A6E61476C7161327874626D396963335231646E64346558703766482F396F4144414D42414149524178454150774431564A4A4A4A536C7A682B734C622F726854306D6C303055313274734934646B62525A74302F77433439544C472F77444776732F3053763841316B36754F6A394A7479784872752F5234375433746439442F7476335776384135466138737738322F447A616336736C39314E67746C7831655A6D7750642F773376612F2B75726E4B3874376B5A79505978682F6637744C6D2B613971654F413769552F376A374F6B712B486D340A325A683135744477366931676531306A5164392F37726D6652732F6354596562586D4378394F7454486247763841336941484F63422B35376C526C4B4D5A69456A5535585566307654387A64476F73616A7532556B6B6B35536B6B6B6B6C4B5353535355704A4A4A4A536B6B6B6B6C4B5353535355704A4A4A4A542F2F513956516A6B566A4A626A452F70484D4E67486B43472F3841666B56637831764D66563156317A447464697461476B664431492F746570736371334E387763455945524D7A504A4447496A357063663771514271536141426B5435504F2F587A7176327A713477367A4E47414E756E4274664472542F596273712F3764584E616E51616B38414B396C344755363279384F3963324F645939784944397A6A766558542F4B4B735958547273625A666C315071737345304E7361572B332F41456A6433306E4F585351344D654F4D51516545562F654C7A6562496375535751395439672F526276534C7372437733596474702B7A335039523949345966396635316E304632'
		||	'58316174616365366E38356A392F77445A6342482F4146433478616E534D2B33466532356E754E6673653036626D48586175663841692B4B4F484E6A2B49363648326559485432386E70686C6950306543667A6676756C384C356D5572356552765469786634507A516534535173624A7179714733306D57502B38487531333870714B70497945674A524E6769775232644653534639717876394D7A2F4144682F656C397178763841544D2F7A682F656E5565794C48634A556B4F33496F6F704E39316A4B715769585776634774415063766437566E5666576E3676585873783673367431746A67786A524F726E486131725862647675636949536B4352456D743643444F4D53415A4158745A64564A5A7550384157506F65546B4D78714D327179367832316C625471534A302F774369744A43555A522B59456559704D5A526C7245672B52745353535343564A4A4A4A4B556B6B6B6B702F2F39483156634E31713075794D672F76334F4879616638417A4671376C656639544A4E78422F6673502F5356656342506E6552676476636E6C2F7773474F5757482F4F5965626B5938726D49367845502F444A65334C2F704A7567644D485563384377546A30525A634F782F305658397477392F2F4273586135474E526C557570794B3232315035613453466D665658476254306C6C73652F4A63363178387032562F2B427361746858732B517979476A386D675975527752686746697A6C48464B2B30766C6A2F414972775857756B7536586C69734576783751585550504D443664622F774358576734523173486B442B4B367A3631593762756A3257523773647A62576E3448592F3841380A436539637068445378336D422F46562F693255532B45357A4C663052383565396A594D4F443276694F4D522B556955782F566959543065672B726553356D525A6A452B793175396F2F6C4E67482F4F5A2F314336437A2B626438442B52637630467064314F736A38317233483452742F77432F4C714C50357433775035466E2F425A796C79674576304A796A482B3738332F644F726C332B6A34333058706637557A7366417263327039346444334E6B4461783176305248376936552F34733877676A375A5271503947372F77416B75613652526E354F5A525230357A6D5A6A77665363783572634959357A34744262732F5274657569505150722F774439794C2F2F41474D642F77436C46316565637849634F61475054355A316639357765586A41784A6C686E6C50456656446279522F584C714E44364D446F394633714870774E6557304E633176713174727171507648752F773233616A66566A702F3157794C63427273713533574E3762765461484E594831667248706131656C736132'
		||	'722F41456E3652522F7867644F7773504F783773617630374D7A31624D68323578334F427168305063357250704F2B677433366F6442365333703242315955526E656D586574766679345071642B6A332B6C3942333769676C6B6A486C596B47593472717548357A7866502F555A3459357935795149684C6745642B4C30774844386E39647A4F6A5958314F5A3176484F4631444B747A5732764E6454327777764173337463667374663876384177693662712F316B365430647A613879302B7334626D305667766648377A6D742B67332F41497863423957662F46626A662B474C762B7076514D47702F77425976724778755138744F6463393972675A4959304F74394E6864503061617652712F6353796376475753357A6B5951687853763576307638417656592B614D6359474F4552504A6B4D4967664C70772B722F6E50645666587236747671395232512B6F7A427266572F64385972612F3271387A3678644873365A5A315674352B78564F3250744C486948626D317836657A31667076622B5975532B7533514F6B644B7763613341782F5273666436626E6233756C7578372F3849392F357A556636764D36585A3953726D6457744E4F45374A4A736343515474665861786A646F632F7742376D66345039496F5A594D4A7878795134366C4D5272546972394C685A3438786E4757574B664263594758454C3462366354704F2F78672F56384F6765753466764376542F414B546D752F364B312B6C39623658315A6A6E594634744E63656F77677465326633713741312F3976364334624B367639525255614B4F6B32753541734A466276367A62485776752F774139566671540A5A597A3679346A574F6A31473273663574394E396D31332F414679757436664C6C4948484F516A50475944693966443671593438354D5A59516C4B47515450442B723476533933315436316445365861614D6938767947775855314E4C33436633397673722F713250514D44363639427A62325937624C4B627258426C62626133446335783273627662765A376E66764F586E4F4A5A586A6454442B7259377372303748666138643769317A6E2B376558752F4F663676365433667A71367A416639534F715A2B4B6353742F544D36713675796C70487074734C48437A306F61363347392B33622B5A663841364E4B664B5934523145356158376B613466384146566A357A4A6B6E6F63635056772B334F2B4D6A2B382F2F30765656776E573654586C5769493258504879656437463361353736795948762B316875367177426C2F6B526F78352F72665256586D70797779773830496D58336166464F492B6232636B54697938503962686B74793476657854785858474E442F586A3634663835'
		||	'3050712F59327A6F7549572F6D3168682B4C503062762B6B314136686E50712B736653634A72694758737958574E3745745977316638416F315A505175704870566A364D6B6C324461647774416E3033392F55412F77622F7741372B57724858765A395966712F314B6F68394C37583435736151577A6333394644682F7050306976345A3473306A6B78794754484F4D7A43556633754358706C2B374F50376B6D754A79474B4D5A417779597A6A6A6B6964366A4B50714837304A66764F7239596E686E524D736E7658742B6269474E2F3670636E517A30366D74504A397A766956756657584D6261356D4330793274777376384A48387A562F364E732F36312B2B7133544F6B335A72685A59437A476D533836462F386D763841394B4C442B4B35355A2F62354442363563667535712B574A2B54484355763676716E6B2F366D3263574D65394C504C536F2B314437654F63762B34622F77425738517472666D4F483835374B2F77437144373366326E2F2B65317332667A62766766794A4D61316A5178674457744144576A674163424F524F6834576A79764C7835664444454E6545616E3936583652585350455358787A6F585578307271474E3144594C76514476306537624F396A717670772F7744306E377136732F347A594250374E476E2F41412F2F414B6758576673546F772F375159332F41477A582F774351532F596E5276384175426A663973732F386774504A7A4F4449654B65496B31587A56703948507863727A4749474D4D6F6A456E697268763833692F722F6B6A4A62306A4A6A5A363944374E737A472F30483764326D376C645439554E667131302B5038415266780A63744337703354377778742B4C54614B687472443632754452703757626D2B78767452617161714B323155736256577751316A414774412F6B74623756446B7A526C686A6941493453546638416A4D2B50424B4F65655579423434695032506C33315A492F353359756F2F7046332F55336F6562526D2F566A7233714D62734E46726E3472336A32575647527433666E666F72505375322F5158703166532B6D5657692B72456F7275615334574E725948416E3654673972643335793550367866576E716E544F735A4F486269565A4F4143773143367477426D746A6E374C6635742F3655762F4D5672487A427935534951734748444B456A5846522F3944616D546C6F3473514D356B455A4F4B4D34692B48692F3946636236786657664B363969566671597838576D3357304F4E674E753133365031646C566266305A6337302F706F4E314F5137366E34747A41546A30357478756A674677444B62482F7966703137762B4655756F64553676395A724B4D5848785030644A2F52592B4D3037'
		||	'51586533666259364B3266316E656C5857752F364430647654656931644F7644625846726A6B6153317A7243585773683330362F643658395250795A49344D634277694A45754C3277654C302F7742355A697853356A4A6B50455A524D4F4833434F44316545586B50717839614F6C64493666396D4F465A5A31423733512B7072584734755036466D387539527638416F746D785A6E315063572F5754454949334158487831394735656B347652756B3464767259754852526272466A4B3274634A3532756150617030394C365A526132366A446F7174624F32786C624775456A6137613572643330536F447A6550396277776C6555616B6E727132427965533850464F4E595459416A7736656C34636657763674645770612F7276544E32567441646451415A67666D3237367369762F692F662F774159734F72475A3144726A63666F74646C64646C72546A7465647A366D67746D36317A6432316C4C76306E30762F414152656F5A4851756935547A5A6B594E466C6A6A4C6E6D7475346E2B552B4E7A6B664577634C436157596550586A74643949564D6179592F653241626B6F38336A674477526B435238737063574F5030564C6B386D5351397963534162346F7834636B76384A2F2F395031564D3572584E4C584146704545485545464F6B6B70793776713967766475724C3666354C434E763350446B2B4E30444378394E316A3237672F77424E7A6F5A7661525979305631686A6655593975373146706F57546B3034744A76764A61787041304263535845567359786A4135373376653572474D596F4D664A3449543438654D526D663350542F7741324B7053736572554475670A7236523032742F7143674F644D7938756671667A7630726E7134673135644C736637512B6161784F3731676179494F333365707455333231566C7262487459367737574278414C6A2B363266704B57474B474F784341685A313459384F762B4372697657326153596B4E424A4D41616B6C5147546A75726461323168715953487644687442626F2F633736507454715659534A49543872475A5A54552B316F73794A3946704F72396F3375326676653145446D6B77434364667735536F6F734C70495A794B477433757359476768706358434E7834622F573155526C56484C6469612B713273576E54546134755950642F57596A52374B7364307953692B797574753678775933786351422B4B54724B324F61313767317A7A44415341536559622B386853626158574D322F43786D585662574D4E6762666539707362537768333664394E62366E324D395830366E6262503058712F61482F6F71586F503168367A2B796348314B7A5763717A634B47577532744F787272725850314474726171'
		||	'3366522F77336F3166345658636A4777636D326F35444B37624B43624B672B43576B6266306A576E3933324A71636241635056707271633134734165304167693133713548752F34613333322F7671534A694F456D4A4E48582B743231593543523467434259305037766652505739746C626247617465413570386A71732B725079727574583462414734754D316F653431506358574F6236726D74795139744E50707374782F3062713748765238526E5461623773664546624C7132312B745857414347687670342B38442F41494A6D327638416B4A76735053726A666C656A5338354C485635466F414F396B656E5979782F357A663065783339524163497577645236644F36547848686F6A512B72586668526A4F795431743241384E716F394831615A61357A726F4F32353164776532756E374D3939572B6C396237482B70366945337157645A31742B4656554859744C68586337592B524E58326E3176745038415276703259314832582B6B667050582F414A7174545A5430584C626C5A6A7161694C53366E4A7573614275465A394E7A5850642F67663061745730344442467261324336356A2F644133334E4C58564F2F6C33666F61396E2F46703178476E436234654862615837793063523134685846786237782F52692F77442F315056556C3871704A4B66717055657255433669754C4756573133563255656F596136786A747A4B5866384148667A66742B682F4F656E59766D4E4A4F6866454B3374624F75453857315030665A685A74654931743974514C736F32656E64633534465A59357632656E4D7971724C6655332F7076356E36487155562B6E2F4F6F54634A370A612B6B746F76787866525253783133714277665531314871656C6A767173396571357A4B2F53755A5A6A323132656C2B6B587A716B7076316E3958632F794C422B722F414B32772F506F2F5548564B6864307A4C7163396C62624B4C476D797777786F63787A6439682F3062667A316D6E47696A4A6468333475797A4B783368737432414E727861785475323273707574394E6A3648656C5A2F4F552B6E2B5A5A583834704A6D506A72537176722F41494C4A6B344C317536366634543947345749326D726F7A665778724855423757772B6437584E2F6E4D5232317A724E6E73396E2F67694A675972362B707466366D4F3674707A646D79776D787875767075746D725A745A396C6533304C76306C6E762F414E482F4144612B626B6B342B3572646670663933663841366B57783976303166365035592B482F414E5276304C6268556E367634654E695A47454B475650727473334E4662332B6A5A5862625665316C6E30586570626674394F79316D2F6664582B6B3954557863647A4F6F74'
		||	'734E6C6276314F75747A41365879317A694C41325064532F6337394A2F49587A4D6B684C334B4E312B6C666666314B6A3766454F472F30613762656C2B6B50724361786267477874443269793257355467796F2F6F4C7033764C4C6638417A333942417A4D4330553446446372486658545451305074634750656137635A33724D66747566597A49394F75746C6671312F70724766306A394836667A736B6A446A714844583137334A452B43386E4666302F64345976306A646A316572316B3158347263792B6F617632754E6242554B322F6132756E39427561352F762F4145535030536831464F5275665738325A44336B56503841554453517A6457392B3276394A75487539692B5A306B3038664162717654352F4C48685852344F4D56642B72792B6158452F53642B497933493673775830312F6163647248324E635056714F7839652B3676322F6F396A7656592F3156565A683132644E7A72505777367137626162485656576273566F70626A753947367A6258745A6C3131745A642B682F6F397466364F332F41416E7A736B6E523979744B2F522F376E682F39526F6C375636332B6E2F3366462F366B666F73597062674D734E6D49343135316C2F70477A3958633537375744466464732F6E61724C76552F6D503658542F4E7068674F6268394D726F794B507446566276537950554733306E47707A32342B4F2B75356D5869742F51736237364C50356A3038696E3146383670492F725044356A2F33582F4E2B64622B722F72664B502B352F353379662B6F332F32514134516B6C4E4243454141414141414655414141414241514141414138415151426B414738415967426C0A414341415541426F414738416441427641484D41614142764148414141414154414545415A414276414749415A5141674146414161414276414851416277427A414767416277427741434141517742544144554141414142414468435355304542674141414141414277414541414141415145412F2B4554686D6830644841364C793975637935685A4739695A53356A62323076654746774C7A45754D433841504439346347466A6132563049474A6C5A326C7550534C767537386949476C6B50534A584E553077545842445A576870534870795A564E36546C526A656D746A4F575169507A34675048673665473177625756305953423462577875637A703450534A685A4739695A547075637A70745A5852684C7949676544703462584230617A306951575276596D55675745315149454E76636D55674E5334774C574D774E6A41674E6A45754D544D304E7A63334C4341794D4445774C7A41794C7A45794C5445334F6A4D794F6A417749434167494341674943416950694138636D526D4F'
		||	'6C4A455269423462577875637A70795A475939496D6830644841364C79393364336375647A4D7562334A6E4C7A45354F546B764D4449764D6A4974636D526D4C584E35626E52686543317563794D6950694138636D526D4F6B526C63324E79615842306157397549484A6B5A6A7068596D3931644430694969423462577875637A703462584139496D6830644841364C793975637935685A4739695A53356A62323076654746774C7A45754D433869494868746247357A4F6E6874634652515A7A30696148523063446F764C32357A4C6D466B62324A6C4C6D4E7662533934595841764D5334774C335176634763764969423462577875637A707A64455270625430696148523063446F764C32357A4C6D466B62324A6C4C6D4E7662533934595841764D5334774C334E556558426C4C3052706257567563326C76626E4D6A4969423462577875637A70346258424850534A6F644852774F693876626E4D7559575276596D5575593239744C336868634338784C6A41765A793869494868746247357A4F6D526A50534A6F644852774F6938766348567962433576636D63765A474D765A57786C6257567564484D764D5334784C79496765473173626E4D366547317754553039496D6830644841364C793975637935685A4739695A53356A62323076654746774C7A45754D43397462533869494868746247357A4F6E4E3052585A3050534A6F644852774F693876626E4D7559575276596D5575593239744C336868634338784C6A41766331523563475576556D567A6233567959325646646D567564434D69494868746247357A4F6E4E30556D566D50534A6F644852774F693876626E4D0A7559575276596D5575593239744C336868634338784C6A41766331523563475576556D567A62335679593256535A57596A4969423462577875637A70775A475939496D6830644841364C793975637935685A4739695A53356A623230766347526D4C7A45754D793869494868746247357A4F6E426F6233527663326876634430696148523063446F764C32357A4C6D466B62324A6C4C6D4E76625339776147393062334E6F623341764D5334774C794967654731774F6B4E795A57463062334A556232397350534A425A4739695A53424A62477831633352795958527663694244557A51694948687463447044636D5668644756455958526C505349794D4441354C5445784C544179564445354F6A55314F6A41334C5441314F6A417749694234625841365457396B61575A35524746305A5430694D6A41784D6930784D4330774D6C51774F446F794D546F794E6930774E546F774D434967654731774F6B316C6447466B59585268524746305A5430694D6A41784D6930784D4330774D6C5177'
		||	'4F446F794D546F794E6930774E546F774D434967654731775646426E4F6B35515957646C637A30694D534967654731775646426E4F6B686863315A7063326C6962475655636D467563334268636D567559336B39496B5A6862484E6C4969423462584255554763365347467A566D6C7A61574A735A5539325A584A77636D6C7564443069526D4673633255694947526A4F6D5A76636D316864443069615731685A325576616E426C5A7949676547317754553036556D56755A476C30615739755132786863334D39496E42796232396D4F6E426B5A69496765473177545530365247396A6457316C626E524A52443069654731774C6D52705A4470454D7A6C454E7A49784D546B304D454E464D6A45784F555531513049334E6A413352555244524464475169496765473177545530365357357A644746755932564A52443069654731774C6D6C705A4470454E446C454E7A49784D546B304D454E464D6A45784F555531513049334E6A4133525552445244644751694967654731775455303654334A705A326C755957784562324E316257567564456C4550534A3164576C6B4F6A6B794F575179596D55774C54637A4D4745744E474977595331695A544D334C544E6A4D6D4D77595463344E6D526C597949676347526D4F6C4279623252315932567950534A425A4739695A5342515245596762476C69636D4679655341354C6A4177496942776147393062334E6F623341365132397362334A4E6232526C5053497A496942776147393062334E6F6233413653554E4455484A765A6D6C735A54306963314A485169424A52554D324D546B324E6930794C6A4569506941386547317756460A426E4F6B3168654642685A3256546158706C49484E3052476C744F6E6339496A49334C6A6B304D4441774D4349676333524561573036614430694D6A45754E546B774D4441774969427A6445527062547031626D6C3050534A445A5735306157316C644756796379497650694138654731775646426E4F6C42735958526C546D46745A584D2B494478795A4759365532567850694138636D526D4F6D7870506B4E35595734384C334A6B5A6A70736154346750484A6B5A6A70736154354E5957646C626E5268504339795A47593662476B2B494478795A47593662476B2B5757567362473933504339795A47593662476B2B494478795A47593662476B2B516D7868593273384C334A6B5A6A707361543467504339795A47593655325678506941384C336874634652515A7A7051624746305A5535686257567A50694138654731775646426E4F6C4E335958526A6145647962335677637A346750484A6B5A6A70545A58452B494478795A47593662476B6765473177527A706E636D3931634535'
		||	'6862575539496B6479645842764947526C494731315A584E30636D467A494842766369426B5A575A6C5933527649694234625842484F6D64796233567756486C775A5430694D434976506941384C334A6B5A6A70545A58452B49447776654731775646426E4F6C4E335958526A6145647962335677637A34675047526A4F6E52706447786C50694138636D526D4F6B46736444346750484A6B5A6A70736153423462577736624746755A7A30696543316B5A575A6864577830496A3573623264764947566D61576468637A7776636D526D4F6D7870506941384C334A6B5A6A70426248512B494477765A474D3664476C306247552B494478346258424E5454704961584E3062334A3550694138636D526D4F6C4E6C6354346750484A6B5A6A70736153427A64455632644470685933527062323439496D4E76626E5A6C636E526C5A43496763335246646E5136634746795957316C64475679637A30695A6E4A76625342686348427361574E6864476C76626939775A475967644738675958427762476C6A5958527062323476646D356B4C6D466B62324A6C4C6E426F62335276633268766343497650694138636D526D4F6D787049484E3052585A304F6D466A64476C76626A3069633246325A57516949484E3052585A304F6D6C7563335268626D4E6C53555139496E6874634335706157513652444D35524463794D5445354E444244525449784D546C464E554E434E7A59774E30564551305133526B496949484E3052585A304F6E646F5A573439496A49774D5449744D5441744D444A554D4467364D6A45364D6A59744D4455364D44416949484E3052585A304F6E4E765A6E5233590A584A6C5157646C626E5139496B466B62324A6C4946426F623352766332687663434244557A556756326C755A4739336379496763335246646E513659326868626D646C5A4430694C79497650694138636D526D4F6D787049484E3052585A304F6D466A64476C76626A306959323975646D56796447566B4969427A644556326444707759584A68625756305A584A7A50534A6D636D3974494746776347787059324630615739754C33426B5A694230627942706257466E5A5339716347566E4969382B494478795A47593662476B6763335246646E513659574E306157397550534A6B5A584A70646D566B4969427A644556326444707759584A68625756305A584A7A50534A6A623235325A584A305A5751675A6E4A76625342686348427361574E6864476C7662693932626D517559575276596D5575634768766447397A614739774948527649476C745957646C4C3270775A5763694C7A346750484A6B5A6A70736153427A64455632644470685933527062323439496E4E68646D566B4969'
		||	'427A6445563264447070626E4E305957356A5A556C4550534A346258417561576C6B4F6B51304F5551334D6A45784F545177513055794D54453552545644516A63324D44644652454E454E305A434969427A644556326444703361475675505349794D4445794C5445774C544179564441344F6A49784F6A49324C5441314F6A41774969427A644556326444707A62325A30643246795A55466E5A57353050534A425A4739695A5342516147393062334E6F6233416751314D3149466470626D527664334D6949484E3052585A304F6D4E6F5957356E5A575139496938694C7A3467504339795A47593655325678506941384C3368746345314E4F6B687063335276636E6B2B494478346258424E545470455A584A70646D566B526E4A766253427A64464A6C5A6A7070626E4E305957356A5A556C4550534A346258417561576C6B4F6B517A4F5551334D6A45784F545177513055794D54453552545644516A63324D44644652454E454E305A434969427A64464A6C5A6A706B62324E316257567564456C4550534A34625841755A476C6B4F6B517A4F5551334D6A45784F545177513055794D54453552545644516A63324D44644652454E454E305A434969427A64464A6C5A6A7076636D6C6E6157356862455276593356745A57353053555139496E5631615751364F5449355A444A695A5441744E7A4D7759533030596A42684C574A6C4D7A63744D324D79597A42684E7A67325A47566A4969427A64464A6C5A6A70795A57356B61585270623235446247467A637A306963484A76623259366347526D4969382B49447776636D526D4F6B526C63324E796158423061573975506941380A4C334A6B5A6A70535245592B4944777665447034625842745A585268506941674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749'
		||	'43416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943410A67494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167'
		||	'49434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749430A41674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341'
		||	'67494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674943416749434167494341674944772F654842685932746C6443426C626D5139496E6369507A372F3467785953554E445831425354305A4A54455541415145414141784954476C756277495141414274626E5279556B64434946685A576941487A67414341416B41426741784141426859334E7754564E47564141414141424A52554D6763314A4851674141414141414141414141414141415141413974594141514141414144544C556851494341414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414142466A63484A3041414142550A41414141444E6B5A584E6A414141426841414141477833644842304141414238414141414252696133423041414143424141414142527957466C6141414143474141414142526E57466C61414141434C4141414142526957466C6141414143514141414142526B6257356B41414143564141414148426B6257526B4141414378414141414968326457566B414141445441414141495A326157563341414144314141414143527364573170414141442B414141414252745A57467A4141414544414141414352305A574E6F414141454D4141414141787956464A4441414145504141414341786E56464A4441414145504141414341786956464A444141414550414141434178305A5868304141414141454E7663486C796157646F6443416F59796B674D546B354F4342495A5864735A5852304C56426859327468636D51675132397463474675655141415A47567A59774141414141414141415363314A485169424A52554D324D546B324E6930794C6A45414141414141414141414141414142'
		||	'4A7A556B644349456C46517A59784F5459324C5449754D5141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414157466C61494141414141414141504E5241414541414141424673785957566F6741414141414141414141414141414141414141414146685A5769414141414141414142766F6741414F50554141414F5157466C61494141414141414141474B5A4141433368514141474E705957566F6741414141414141414A4B414141412B45414143327A32526C63324D414141414141414141466B6C465179426F644852774F693876643364334C6D6C6C5979356A61414141414141414141414141414141466B6C465179426F644852774F693876643364334C6D6C6C5979356A6141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141426B5A584E6A41414141414141414143354A52554D674E6A45354E6A59744D6934784945526C5A6D463162485167556B644349474E76624739316369427A6347466A5A53417449484E53523049414141414141414141414141414143354A52554D674E6A45354E6A59744D6934784945526C5A6D463162485167556B644349474E76624739316369427A6347466A5A53417449484E5352304941414141414141414141414141414141414141414141414141414141415A47567A597741414141414141414173556D566D5A584A6C626D4E6C49465A705A586470626D6367513239755A476C306157397549476C7549456C460A517A59784F5459324C5449754D5141414141414141414141414141414C464A6C5A6D56795A57356A5A534257615756336157356E49454E76626D527064476C76626942706269424A52554D324D546B324E6930794C6A4541414141414141414141414141414141414141414141414141414141414141414141485A705A5863414141414141424F6B2F67415558793441454D3855414150747A4141454577734141317965414141414156685A57694141414141414145774A566742514141414156782F6E62575668637741414141414141414142414141414141414141414141414141414141414141414141416F38414141414363326C6E4941414141414244556C516759335679646741414141414141415141414141414251414B414138414641415A414234414977416F414330414D674133414473415141424641456F415477425541466B415867426A414767416251427941486341664143424149594169774351414A55416D674366414B514171514375414C494174774338414D454178'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'67444C414E414131514462414F4141355144724150414139674437415145424277454E41524D4247514566415355424B7745794154674250674646415577425567465A415741425A7746754158554266414744415973426B674761416145427151477841626B427751484A416445423251486841656B423867483641674D4344414955416830434A674976416A674351514A4C416C514358514A6E416E454365674B45416F34436D414B694171774374674C424173734331514C674175734339514D414177734446674D68417930444F414E444130384457674E6D4133494466674F4B413559446F674F7541376F4478775054412B4144374150354241594545775167424330454F7752494246554559775278424834456A415361424B674574675445424E4D45345154774250344644515563425373464F67564A425667465A775633425959466C67576D42625546785158564265554639675947426859474A775933426B674757515A71426E73476A416164427138477741625242754D473951634842786B484B7763394230384859516430423459486D516573423738483067666C422F67494377676643444949526768614347344967676957434B6F4976676A53434F63492B776B514353554A4F676C504357514A65516D504361514A75676E504365554A2B776F524369634B50517055436D6F4B675171594371344B7851726343764D4C43777369437A6B4C555174704334414C6D4175774338674C345176354442494D4B6778444446774D6451794F444B634D77417A5A44504D4E4451306D4455414E576731304459344E715133444464344E2B4134544469344F5351356B446E380A4F6D7736324474494F3767384A447955505151396544336F506C672B7A443838503742414A4543595151784268454834516D784335454E6351395245544554455254784674455977527168484A456567534278496D456B55535A424B4545714D5377784C6A45774D5449784E4445324D5467784F6B45385554355251474643635553525271464973557252544F4650415645685530465659566542576246623056344259444669595753525A73466F38577368625746766F584852644246325558695265754639495839786762474541595A52694B474B385931526A364753415A52526C72475A455A74786E64476751614B687052476E63616E687246477577624642733747324D626968757947396F6341687771484649636578796A484D776339523065485563646342325A48634D6437423457486B4165616836554872346536523854487A346661522B5548373866366941564945456762434359494D5167384345634955676864534768496334682B79496E496C556967694B764974306A'
		||	'43694D344932596A6C435043492F416B4879524E4A48776B717954614A516B6C4F43566F4A5A636C787958334A69636D567961484A72636D364363594A306B6E656965724A39776F4453672F4B48456F6F696A554B5159704F436C724B5A307030436F434B6A5571614371624B733872416973324B326B726E5376524C4155734F5378754C4B49733179304D4C554574646932724C6545754669354D4C6F4975747937754C79517657692B524C3863762F6A41314D477777704444624D524978536A47434D626F78386A49714D6D4D796D7A4C554D77307A526A4E2F4D37677A385451724E4755306E6A54594E524D31545457484E6349312F5459334E6E4932726A62704E795133594465634E396334464468514F49773479446B464F554935667A6D384F666B364E6A70304F724936377A73744F327337716A766F504363385A54796B504F4D39496A31685061453934443467506D412B6F4437675079452F59542B69502B4A414930426B514B5A41353045705157704272454875516A4243636B4B31517664444F6B4E395138424541305248524970457A6B5553525656466D6B586552694A475A306172527642484E556437523842494255684C534A464931306B6453574E4A71556E77536A644B665572455377784C55307561532B4A4D4B6B7879544C704E416B314B545A4E4E3345346C546D354F7430384154306C506B302F64554364516356433755515A525546476255655A534D564A385573645445314E6655367054396C5243564939553231556F56585656776C5950566C785771566233563052586B6C66675743395966566A4C5752705A61566D3457676461566C716D57760A566252567556572B56634E567947584E5A644A31313458636C65476C3573587231664431396858374E6742574258594B70672F47465059614A6839574A4A5970786938474E445935646A363252415A4A526B365755395A5A4A6C353259395A704A6D364763395A354E6E3657672F614A5A6F37476C44615A7070385770496170397139327450613664722F327858624B39744347316762626C75456D357262735276486D3934623946774B334347634F42784F6E47566366427953334B6D6377467A58584F34644252306348544D6453683168585868646A35326D33623464315A3373336752654735347A486B7165596C3535337047657156374248746A65384A3849587942664F4639515832686667462B596E374366794E2F68482F6C674565417149454B675775427A59497767704B4339494E586737714548595341684F4F465234577268673647636F6258687A75486E34674569476D497A6F6B7A695A6D4A2F6F706B6973714C4D497557692F794D59347A4B6A54474E6D49332F6A6D61'
		||	'4F7A6F38326A353651427042756B4E61525035476F6B68475365704C6A6B303254747051676C497155394A56666C636D574E4A61666C777158645A66676D457959754A6B6B6D5A435A2F4A706F6D745762517075766E427963695A7A336E575364307035416E713666485A2B4C6E2F7167616144596F5565687471496D6F70616A42714E326F2B616B567154487054696C71615961706F756D2F616475702B436F55716A457154657071616F63716F2B7241717431712B6D73584B7A5172555374754B34747271477646712B4C73414377646244717357437831724A4C73734B7A4F4C4F75744357306E4C55547459713241625A3574764333614C666775466D3430626C4B75634B364F3771317579363770377768764A7539466232507667712B684C372F7633712F39634277774F7A425A38486A776C2F4332384E59773954455563544F78557646794D5A47787350485163652F79443349764D6B3679626E4B4F4D7133797A624C747377317A4C584E4E6332317A6A624F747338337A376A514F64433630547A527674492F30734854524E504731456E557939564F316448575664625931317A58344E686B324F6A5A624E6E78326E62612B3975413341586369743051335A6265484E366933796E66722B4132344C3368524F484D346C5069322B4E6A342B766B632B54383559546D4465615735782F6E71656779364C7A7052756E51366C767135657477362F767368753052375A7A754B4F3630373044767A504259384F58786376482F386F7A7A47664F6E39445430777656513964373262666237393472344766696F2B546A35782F70582B756637642F77482F4A6A394B6632362F0A6B762B335039742F2F2F2F3767414F51575276596D55415A414141414141422F39734168414147424151484251634C4267594C44676F49436734524467344F4468455745784D5445784D574551774D4441774D4442454D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4151634A43524D4D45794954457949554467344F4642514F4467344F4642454D4441774D444245524441774D4441774D4551774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D4441774D44417A2F7741415243414C62425563444152454141684542417845422F393041424143702F3851426F674141414163424151454241514141414141414141414142415544416759424141634943516F4C4151414341674D424151454241514141414141414141414241414944424155474277674A436773514141494241774D434241494742774D4541675943637745434178454541415568456A46425551595459534A78675251796B614548466246434938'
		||	'46533065457A466D4C774A484B43385356444E464F536F724A6A63384931524365546F374D324631526B644D50533467676D67776B4B47426D456C455647704C52573031556F47764C6A383854553550526C6459575670625846316558315A6E61476C7161327874626D396A6448563264336835656E74386658352F63345346686F65496959714C6A49324F6A344B546C4A57576C35695A6D7075636E5A36666B714F6B7061616E714B6D717136797472712B6845414167494241674D46425151464267514941774E744151414345514D45495249785151565245324569426E47426B544B68736641557764486849304956556D4A7938544D6B4E454F4346704A544A614A6A7373494863394931346B53444631535443416B4B47426B6D4E6B55614A325230565466796F3750444B436E54342F4F456C4B5330784E546B39475631685A576C7463585635665647566D5A326870616D7473625735765A48563264336835656E74386658352F63345346686F65496959714C6A49324F6A344F556C5A61586D4A6D616D3579646E702B536F36536C7071656F71617172724B327572362F396F4144414D4241414952417845415077443154697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735659352B59586D4136466F74786478476B374C3655502F47522F67542F6761382F396A6D56706358695441366678663159754871387668597952395830782F72535A44444573534C4776325641412B517A474A7479774B32585945757856324B757856324B750A7856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7638412F39443154697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273'
		||	'566469727356646972735664697273566469727356646972735665432F6E4A35795857645974764C3971774D46724D76714D4E36796B384B663841504657342F7743757A35305768776345444D2F78442F592F38656557375231506954474D66544358712F722F41504858765763363953374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F2F52395534713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597177373830764F362B564E4B6157496A363750574F4165422F616C2F774257496638414438462F617A4F30656E3861572F30782B70312B75315867517366584C36502B4B2F7A587939597A4F62754F556B6C0A2F5556716E6331725775645A49625045785071423833326C6E43766F7A735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356662F3076564F4B757856324B7578'
		||	'56324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578565A504D6B4562545373466A51466D5939414275536349463742424E43792B542F774178764F636E6D7A565A4C797046736E3775425432514837565035705074742F7750374F646A7063486777722B4C2B4A345457616B3535332F442F422F565976307A4C634A397232733475496B6D48523144626534726E426B55616652346D786170675A4F7856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B762F302F564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856342F2B66760A6E6A36706272356474472F657A67504F5232543969502F6E6F6669622F492F77434D6D627673335432654D2F772F53382F32727175456547503476722F71764138364A355A324B76734C79546566584E45734C697453397446583538564466384E6E45366950444F512F704639413030754C48452F30592F636E57554F5337465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859'
		||	'7137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712F77442F3150564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7058356F3877776558644F6D314F362B784374517461466D4F794976384172746C3248456373684564576A506D474B4A6B663458794A724F72543676655336686474796D6E5975782B665966354B2F5A582F414363374F45424143492F686542795A446B6B5A486E4A425A593175785639522F6B70662F572F4C4671436174435A497A394473792F3841434D75636C7234384F552B6232335A732B4C4350364E782B316E4F6139326273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469720A73566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F41502F563955347137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712B64667A3138372F706655426F31713162577A4A3530364E4C30622F6B5550672F3176557A70757A74507752346A39552F38416350493971616E784A63412B6D482B372F77434F764C6332377048597137465876582F4F4F477163374F3930346E2B376C5755442F584842762B54517A6E6531496269582B622B50394D3952324E4F34796A3538582B6D2F365265785A70486F585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137'
		||	'46585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F2F573955347137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465749666D6A3530486C5853486D6A492B7554316A67482B555238556E79695834763962677637575A756A77654E4F7634592F55362F58616E77495750726C3659666A2B692B55325975537A47704F354A7A7233686D734B757856324B76522F7741686459466A35684673782B47376965503235443936762F4A746C2F32576176744748466A762B59662B4F7533374B79634F5776353434663841665070584F5765796469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356640A69727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356662F2F5839553471374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971307A425157593041334A4F4B766C5838302F4F5A383036753830544532634659344232346A37556E2F505676692F314F432F7335312B6A776544437634706655384E727454343837483052394D50782F5359646D633639324B757856324B6F2F51645666534C2B333143503756764B6B6C4233346D70582F4147512B484B386B4F4F4A6A2F'
		||	'4F44626979654849532F6D6D333256424F6B38617A526E6B6A674D70385152555A77354662506F594E697776774A64697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F2F5139553471374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971387A2F50507A722B68744D2F525673314C7139425530367246306B622F6E702F64722F732F7743584E723266702B4F58456670682F756E546471616E773463412B724A2F75487A666E555048757856324B757856324B7578563952666B7635672F532F6C3246484E5A62516D42766B7639312F79535A462F324F636C723858426B50384153395432765A7558784D512F6F656A2F41496E2F41474C4F733137744859710A37465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712F2F3066564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856'
		||	'324B757856324B757856324B757856527662794B79676B757268676B4D536C33593941716A6B787955596D526F4D5A5345525A354238692B64504E45766D62564A74546C714663306A552F736F4E6F302B3737582B5879624F7A77595269694968344855357A6D6D5A48385253504D68786E59713746585971374658597139532F774363662F4D6E36503164394C6C4E49723150682F34794A566C2F344A5055482F415A714F3073584644692F6D66376C33665A4F62676E776E2F4B6637714C364B7A6D58726E597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712F77442F3076564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B75785634372F7A6B42357A2B72570A366558725A76336B314A4A36486F67503775502F6E6F337866367166356562767333425A347A302B6C3537746255305044483857382F367277584F69655864697273566469727356646972735652476E3338756E334D5635626E6A4C43367568393150495A435552495565724B457A41676A2B463969655874616831797767314B332F753530443038442B306E7A5275534E6E465A635A78794D542F432B6859636F795245682F456D47564E727356646972735664697273566469727356646972735664697273566458465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859'
		||	'713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F302F564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B6F4C5774586730657A6D314337504747424337483564682F6C4D6668584C4D63444D69492F6961386D5159346D5235526649506D48584A396476357453756A2B396E5973523241364B672F79555834567A744D574D593469492F686650383255355A47522F6953374C5770324B757856324B757856324B757856324B7662762B6365764E33393735647547385A6F4B2F386C6F2F2B5A692F38394D30486165446C4D66315A6637313654736A5563385A2F72512F337A32374E43394B37465859713746585971374658597137465859713746585971782F7A5235726A306C54444652377068734F792F7743552F77447A546D67375537566A705277783957592F772F7A5036552F2B4A6259592B4A4D3946745A4C653151546B744F773579453953782B312F774144396E2F5935737446696C6A786A6A395753587279532F3279582F452F522F5669776B624B4E7A4E59757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578560A324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F39543154697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972772F2F6E49547A6A566F2F4C6C733277704C635538663930782F387A572F35355A762B7A4D482B55503957503841766E6D7531395279786A2B74502F65782F7742392F7058696562353574324B757856324B757856324B757856324B75785648614872452B6A58734F6F3270704C4134'
		||	'6365394F716E2F4A59664332563549436354452F784E6D4C4963636849667776722F41454457344E63735964537444574B644177385166326B622F4B527667624F4B79597A6A6B596E2B463941785A526C694A442B4A48355732757856324B757856324B757856324B757856324B735538312B6331736556705A454E6364476271452F712B6374327232794D4634385871792F774155763463582F482F3979337778337557482B5737567454314F4A5A5358712F4E796436302B4D387639624F52374E7848553669496C367656346B2F38414D39662B7963695A6F50573839586342324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F563955347137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746557538786135446F576E7A366E632F3363434671654A2F590A5165377678584C63574D354A43492F6961633255596F6D522F6866482B726170507174334C6633626370706E4C7366632F7741422B7A6E6177674941416448674D6B7A4F526B65636B4A6B3274324B757856324B757856324B757856324B757856324B765876794438386655726C764C393233376D34504B416B2F5A6B2F616A2F7743656F2F354B4C2F785A6D6C3753302F454F4D66772F562F56642F77426C61726850686E6C4C365036332F486E763263343955374658597137465859713746585971374657442B62504F314F566E707A657A796A2F694D6638417A582F774F6354327432317A7834542F414638762B39782F38582F70584A78347570594B54586335784C6B73792F4C573135547A334A2F59554B50396B612F38615A312F7331697563702F7A5969482B6E2F365163664D647165675A337269757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B'
		||	'757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B762F2F5739553471374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465868582F41446B4A35763841566C69387657376644485357656E3878483771502F59722B382F32615A30485A6D4368786E2B7246356A74665557526A483961662B39654D5A76586E5859713746585971374658597137465859713746585971374656384D7A77757373524B7568444B5273515275434D42467042726350717A38732F4F3665624E4C57345967586B4E456E55667A646E482B544C39722F676B2F5A7A6B4E58702F426C58384A2B6C376E52616E7834582F4848362F782F535A626D45353773566469727356646972544D45425A6A5144636B344351425A563537357338364737355764675349656A4F4E69337350386A2F69582B726E41647264736E4C6550462F642F7741552F774456502B4F6637722B7135655048573559686E4A4E377356656A2F6C7A427773486B505635443977432F38335A364A374F0A5936776D583836662B356A482F414938346D593773727A715768324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F312F564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578'
		||	'56324B706435693179485174506E314F352F7534454C5538542B776739336669755734735A795345522F453035736F78524D6A2F4141766A2F5664546D3153376C76726F387070334C7366636E39583875647243416741422F432B66354A6D5A4D6A7A6B684D6D77646972735664697273566469727356646972735664697273566469724A5049586E4B66796E716158305657685077544A2F4D68362F77437A5837536635582B546D4C7163417A52722F53755A704E5363452B496376347636723677303755594E537434377930635351537147526833427A6A70524D5452365064516D4A6A69484B5349794C4E324B7578565A4E4D6B43475755685555564A50514449546D4944696B65474D56417435743572383376715A4E7462457261672F49762F414B332B542F6B2F38466E6E5861766135314A3449656E442F77424E66363339482B6A2F414B5A7A4D655068334C47633570756469727356657165526F2B476B776E2B5975663841686D47656F646878725452382B50384133636E437938302B7A6574547356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273560A64697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F2F51395534713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971384D2F77436368764E764F5348792F6274736C4A7036654A2F755550795839352F736F383644737A44735A6E2B72482F66504D39723669794D592F72542F414E3638577A65764F4F7856324B757856324B757856324B757856324B757856324B757856324B757856366E2B5333356B2F6F5334476A6169394C47647633624D646F3350366F3550327635582B502B664E5272394C346734342F58482F5A4F37374E3176686E676C39457639684C2F41496C3945357A4C317A7356557271366A7459326E6E594A476771536371793559346F6D556A7778696B43336D506D6A7A584C71376D4B4B7157716E5A65376635542F38303535'
		||	'72327032724C566E686A3663492F682F6E2F77424B662F45755A44487770426D68625859713746585971395A386E663841484B742F39552F385362505665782F385768376A2F75704F446B35707A6D34613359713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F2F3066564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B75785642613371384F6A3255326F334A704641686476656E374939322B79755759344763684566784E6558494D6354492F77766A335774576D3165396D3143354E5A5A335A3239716E37492F79562B797564726A6749415248384C35396B79484A497950384145677373613359713746585971374658597137465859713746585971374658597137465859713746587666354C666D674C3145387636732F2B6B494F4E7649782B326F36517366392B0A4C2F75762B6466387637664F362F536350726A792F692F3470366E7333586358377566316677532F7742363962764C32477969616534594A4776556E4F657A5A6F34596D637A7778693943426279337A4C356E6D316D5367716C75702B46502B4E6D2F79763841694F655A647064707931637635754B5030512F33302F36582B356332454F464A63307259374658597137465859713958386C507A306D412B415966637A5A366E324C4B394E442F4F2F7742334A77636E314A336D366133597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658'
		||	'59713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F394C315469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356654D663835442B612F5469683876774E764A5361616E386F5037704438332B50384132435A76657A4D4E6B7A5039574C7A76612B65674D592F72532F337277724F6765596469727356646972735664697273566469727356646972735664697273566469727356646971765A527A53544B4C616F6C424255716145456674562F5A342B4F526B5142756B476E736965614C335749496F64516C395357465144515544482F66682F774176504666617A5335595A42502F414A432F355038413275663832663841532F6D532F6D2B6C377A7372576A4E48685038416578352F30342F7A762B4B617A6758664F7856324B757856324B75785636622B587333716162782F6B6B5A663150384138625A365437507A347450583879636F2F77432F2F77423834655562736C7A70476C324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578560A324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F3950315469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469716C655863566E444A637A7478696955757A487346484A6A6B6F784D6A5159796B49697A306648336D725835664D477033477154645A334A41505A52384D616637464F4B35327548474D6352456677766E2B664B63737A492F784A546C7A513746585971374658597137465859713746585971374658597137465859713746585971725774724A6379434B49565935456D7479724D744D30794F776A347275352B30336A2F41475A67546E784B6A6B636F51'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'796D6847596D6642485045776D4F4F452F71693259386B7363684B4A345A52547179766863436832636473385A376237446C6F4A63556658703566545038416D6637586B2F34722B4E372F414C503752477046483035522F442F4F2F7051525763753768324B757856324B7578566E66355A334E56754C633969726A366171332F47756478374E5A4E70772F717A2F414E374C2F65754E6D444E383756786E59713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F2F5539553471374658597137465859713746585971374658597137465859713746556E3831366E2B6A72515441305071786A376D35742F77414B6D616A7458552F6C38516C2F746D502F41485869532F324D477A4847796E437347465275446D32427472646856324B757856324B757856355A2B66336D6E394861576D6B5174536139507865306162742F7741472F466639586E6D0A33374E77385575492F776637703066613266676877446E6B2F334435327A706E6B6E59713746585971374658597137465859713746585971374658597137465859713746565733743375484555517178794A4E626C575A6156706957456645627566744E342F77426D59453538525647355772735658493551686C4E434D7179346F35596D457878776E395557634A6D42346F2B6D5555367372775843304F7A6A714D3856376337476C6F4A32505670352F774233502B622F414C58502B6C2F75342F357A3644326432674E54476A2F65782B71502B2F696973356C3237735664697273565A4635447650712B7071684E466C566B502F456C2F46633648734C4E34656F412F77425542682F76342F376C7179697739517A3078776E5971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859'
		||	'7137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F395831546972735664697273566469727356646972735664697273566469727356594E2B5A64332F63576F2F7741707A2F7846662B4E38346E326C7A6652443335503937482F667554684856503841796671503137546F6D4A713859394E766D76542F4149546A6D39374931486A59496E2B4B483775582B5A2F787A686173676F70316D3561335971374658597137706972354D2F4D7A7A522F6954584C6938513167512B6C443463453244442F6A49334B542F5A35324F6B772B4641447239556E6739626E386249542F41412F54482B7178624D78776E5971374658597137465859713746585971374658597137465859713746585971715151504F346A6A465750515A456D6C5A6C70576C4A5952304738682B30333842375A67546E784B6A737256324B757856324B723435476A594F75784759327030304E5241343867346F5462635757574B516C486155553974626C62684F513639786E686661765A6B39426C344A62782B7248502F56496638562F5066534E467134366D484550712F6A6A2F4E6B725A70334F64697273565662533561326D53640A5074527347487A42726C754C4963636849633445532F30716B5739707470317549316D6A4E556451772B52337A3254486B4753496B50706D4F4C2F544F754970557978447356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356662F2F573955347137465859713746'
		||	'5859713746585971374658597137465859713746586C666E65382B733670494161724741672B6766462F77414F577A792F74764E346D6F6C2F5172482F414B583676396E784F64694642472F6C377133316136617A632F424F4E76384157482F4E532F384147755A76732F712F447948476670792F542F7779502F46522F774236777978735739487A304E78485971374658597177723833764E48364130475A6F7A533475663345644F6F354434322F324D66502F414766484D2F513466457944756A366E57396F5A2F43786D76716E3649766C6A4F7565496469727356646972735664697273566469727356646972735664697273566469712B4B4A7057456143724D6141594361566D4F6B615374676C54764B33326A2F414D616A4D444A5069564D4D7156324B757856324B757856324B713172636D33666B4F6E635A714F31657A59362F45636376722B7246502F4146504A2F7741542F5063375261733661664550702F6A6A2F4F6A2B507054354844714758634850434D2B4757475A684D634D3448686C46394A7835426B694A52336A4A646C44593746585971394B2F4C2F552F724E6B625A6A386342702F735475762F41427375656A2B7A2B7138544677483673503841754A66542F766F75486C6A52746C47644D30757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856320A4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F583955347137465859713746585971374658597137465859713746585971746B6B45616C3232565153666B4D6A4B51694C5052586964314F62695635322B314978592F4D6D75654D35636879534D6A2F4849792F307A73674B57777974433679786D6A71515166416A49776D59455348315239537659644331564E557445756C366B555965444437517A3176513673616E474A6A2F41442F364D2F3476782F4E6343556545306A387A3244735664697235752F506E7A4E2B6C4E61476E7847734E69764435794E527066752B43502F594E6E55646E59754348462F'
		||	'502F414E79386632726E34386E434F57502F41485838547A544E71365A324B757856324B757856324B757856324B757856324B757856324B757856636946794655565937414441724C39463063575363354E356D472F742F6B6A4D484A6B346C54504B56646972735664697273566469727356646971596158643847394A76736E703838344C3270374A3857483569412F65597637332B6E692F6E6638414A4C2F706E2F55656C37473176424C77706654503650364D2F77446A2F7744756B327A7964375A324B7578564F664B5772666F322F52324E4970506766354839722F59746D34374A316635624D43666F6E364A2F353338582B613135493248724F657175433746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F3944315469727356646972735664697273566469727356646972735664697155656262763672706B373932586750396C3850360A733150613262777450492F7A6F38482F41437339445A6A466C354A6E6C446E4F78566B506B7A7A422B69376E30706A53336D6F472F77416B2F73762F414D315A30485933614835624A77792F75736E3166304A66777A2F34722F6A72566B687842366A317A3031776E59716C6E6D6258493943303234314F58374D455A5944785052452F326238567933466A3853516950346D6E4E6C474B426B66345878336433556C334D397A4D6555737246324A376C6A79592F666E62524643672B66536B5A477A3155736B78646972735664697273566469727356646972735664697273566469725946646867566C6568614C395648727A44393665672F6C482F4E575965584A6577564F4D78316469727356646972735664697273566469727356623659434C324B67306E6C6A632B7648552F6147787A777A74337333386A6E494839316B39654C2B722F4144502B536638417565463948374E3166356E485A2B7550706E2F78582B6369633535326A7356646972314C79567266365273784849617A51'
		||	'3056766366734E6E70335975742F4D597150393569394D76367638456E4379526F73677A6674547356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F3948315469727356646972735664697273566469727356646972735664697244767A4B752B467444626A71376C766F556638414E2B636837535A617878682F506C786636542F704E794D493365665A774C6C4F7856324B76515049336D63544B4E4E756D2F654B4B527365344837487A58396E4F39374437543478344D7A366F2F335576353066356E2B622F442F5263584C4471475A5A32446A76477638416E49727A4A365676623648453378536E3170522F6B72384D512F325438322F353535764F7938566B7A5038415669383732786D6F4341362B71582B3965455A304C7A447356646972735664697273566469727356646972735664697273566469724A504C2B6A636158553433366F44322F77410A722F6D6E4D544C6B364257515A69713746585971374658597137465859713746585971374658597169624334394351452F5A4F787A6E6533757A767A7541676633755038416559763633387A2F414A4B522F77426C774F31374E316635664943666F6E365A2F774446663571653534612B6A4F774B3746557938766179326B3361334171552B7934385650582F414A717A5A646E36773658494A2F772F544F503836483439544363654950586F5A6B6D525A597A79526743434F344F6573516D4A675347385A4F41757961757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578'
		||	'56324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F394C31546972735664697273566469727356646972735664697273566469727A5838784C76316451454936524942394A2B4C395848504F6661484C785A75482F5534442F545339662F45755A68477A4638356875646972735662527968444B6145476F4979514A42734B394B387065626C314A5261335243334B6A59394134486638413176356C7A3062736E7459616B6548502B2B2F36612F3841482F3530584479592B4863506D3338772F4D662B4974627562395457497677692F7742525067542F41495037662B73326573616246345542482F5466316E7A76563576467947582B6C2F7173637A4B6352324B757856324B757856324B757856324B757856324B757856324B70356F476A657552637A44393250736A785038417A546D4E6C795673465A526D477273566469727356646972735664697273566469727356646972735664697164366463657246512F61585935346E3753646E2F414A585545782F75382F37794839622F41436B50394E3676367334766F585A4F71386246522B7648364A6637784635797A75585971374657626551664D58412F6F79344F7833694A38653666542B7A6E616467396F312B346E2F79532F774371662F4575506C68315A356E63754B374658597137465859713746585971374658597137465859713746585971374658597137465859710A3746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F3950315469727356646972735664697273566469727356646972735664697278337A4664665774516E6C3667794544354434562F415A354632686C3858504F58394D2F374830526468415545767A58736E5971374658597168373663777846676145374436633648734453666D6456456677342F774239502B72692F7743'
		||	'50384558576470352F42776B2F7853394566382F2F4149363833316A514774717A57395769376A75762F4E7566514F504C6578664E306C7A4956324B757856324B757856324B757856324B757856324B7578564D7446306B33306E4A396F6C366E782F796370795434565A697168414655554132417A41567646585971374658597137465859713746585971374658597137465859713746555870732F705367486F3232637237533648387A706A496658672F65782F712F35582F5965722F4D6431325271664379674836636E6F2F346A2F5A6637704F383855665158597137465731597151796D68473449776731754665706555664D6731614430355453356A4878442B59667A6A2F6A62505475794F3068716F564C2B2B68395839502F62502B4B634C4A4468542F4E38314F7856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B762F395431546972735664697273566469720A735664697273566469727356554C36342B7257386B352F33576A4E3977726C47664A34634A532F6D526C4C2F536849466C346F54586339633861646937417273566469727356536E56357175497832335030353674374836506778797A482F4143737543483954482F78552F7744706D385832376E34706A47503450564C2B7450384134372F756B767A76336D456D315479374863566B74364A4A34646A2F414D30356B5179317A566A4E7A6179577A656E4D705676664D735342354B705A4A5859713746585971374658597137465859716974507348765A52456E547154344449546C7769315A74625779573059696A4646584E63546536716D425859713746585971374658597137465859713746585971374658597137465859713244544152657855476D515730767178712F694E2F6E6E7A39326C7050797565574C2B5A4C302F774443356572482F73483144535A2F4778786E2F4F482B792F692F3253726D736374324B7578565873623657786D573567504752445566302B5758344D'
		||	'38734D684F47306F6F49765A36786F4775786178626961505A7873363977662B6166356339553047756A713463512B722B4F483879582F452F7A58426E48684B5A35736D4473566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356662F3958315469727356646972735664697273566469727356646972735653507A74632B687063744451765242394A332F414F46355A704F327376427035663071682F7070663854784E754D57586C4F6557756137465859713746576961626E4A52695A47687A4B4361466C6A30387671757A6E75632B686444706870734D63512F77416E45522F7A7634356635302F552B57366E4E34307A4D2F78482F7046547A4F6364324B71647862523343384A6C444C373451534F537042666556694B746174556679742F4273796F357539556A6E74704C64754D716C5437356B4167386C55736B72735664697273566469712B4746706E456359717A4767470A416D6C5A7270656E4A59784242753533592B4A7A587A6E7846555A6C61757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578564E4E486C71476A5062635A35663759365370517A442B4C3931502F4E3955503841662F36523748734850596C6A503850726A2F766B797A7A703670324B757856324B6F7A5364576D307564626D41376A714F7A442B56737A4E4A71356161596E442F704F50383254475565495539583058576F4E576745384233364D703671664135366E6F7462445651346F2F353066346F53634B55654648356E4D485971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859'
		||	'7137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F2F3176564F4B757856324B757856324B757856324B757856324B7578566876356C5850473367742F35334C6638434B663862357948744C6C714559667A7047582B6B482F5678794D4933656635774C6C4F7856324B75785643366A4C36634A3857327A70765A7A53666D4E56472F70772F767066356E3066394C4F42314861326677734A37352F752F394E39582B77346B6A7A32393837646972735664697273565779784A4B764751426C5059697545476C53713638735730753856597A37626A376A6C306378484E557075504C4E31467648535165786F667879385A6756533661306C672F76555A666D4D7445676553714F5356324B7373387636543957543135522B395962447748396377637337324370786C43757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B6F6E543550546D58774F3333357A6E74467076483073782F466A2F414830662B53663166394B2B4E32765A57627738306636666F2F302F2F4875465063384E66526E59713746585971374655666F6D737A6154634334684E52305A657A44777A503057736C705A386366382B5038415069786C486944316E544E5368314742626D334E5562377765366E33476571616255783145424F4830792F32503946775A52725A465A6C0A4D58597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746564F61346A67484B566C52664669415078776745386B45676330444A356D30754D3858764C6454344756422F78746C67785350535879616A6E674F7366394D46762B4B39492F356262622F6B636E2F4E5748775A393076394B556550442B64482F5452565538776164494F535855444B65346B552F7744473252384B58644C354D686D696573666D696F72754755306A64574A3332494F514D5347596B44795663444A324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B75785632'
		||	'4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B762F3966315469727356646972735664697273566469727356646972735665632F6D50633837324F456449347839354A2F68787A7A7A326A79635755522F6D512F335A2F36526376434E6D4A3579726537465859713746557031655772694D64685837383957396A394C7734705A542F6C5A634566366D502F41492F4C2F59504639765A754B59682F4D48462F6E542F482B79532F4F2F6559646972735664697273566469727356646972694B3471685A744C745A7674787238774B48384D6D4A6B4B796A794A2B54397472664B2F6E4C785736476B64434479622F5A4437436638532F31577A463147754D50534F62743944326634344D70656D483850395A6B4770666C4466513161796C536365446641332F477966384144356A523173547A464E32587365592B6B69662B77596871656733326C6E6A65777646327152384A2B546A3444392B5A6B4D6B5A3869366E4C676E692B6F474B4179786F6469727356646972735664697273566469727356646972735664697273566469727356646972594E445564526B4A774577596E6C4C30706A49784E686B636238314444754B353836366A43634D3551502B546C4B482B6B50432B7259702B4A455348385145763841544C73783278324B757856324B7578564F2F4B336D4A744875506A716265545A782F787550646333585A66614A306B392F7743366E2F65522F77422F2F6D7463346351657178794C496F644347566855456443446E714D5A4351736369344B374A4B3746585971374658597137460A58597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597178377A563539306A79756C64526D416C49717353664649332B772F5A2F77425A2B436635575A4F485454792F535038414F2F686354507134596671502B622F45386A38772F77444F524E394F786A3061335343507338767876382B493478702F79567A63347579346A367A78663158515A75324A483642772F77426231532F482B6D5948716E35692B594E554A2B745830784236716A63462F77434169344C6D78687063634F514471386D73797A35796C2F75663979782B575635574C794D575939535455356B675534704E724D4B48597137465859716D467235673147304E6261366E695038416B534D762F4557796F346F793567664A746A6D6C486B5A44347656767951383661787175734E593339314A50414948626A496557344B55504A766A2F414776357331486147434549584563'
		||	'4A346E65396D616D6335384D695A523465724A662B63674E52756244537261537A6C6B686333464359324B6B6A672B31567A45374E694A534E692F53356E61307A47416F38507136653534542F41497231662F6C74756638416B632F2F4144566E512B4444756A2F7051387834382F353076394E4A332B4B39582F3562626E2F6B632F38417A566A344D4F36502B6C432B505038416E532F30306E66347231662F414A62626E2F6B632F77447A566A344D4F36502B6C432B50502B644C2F5453642F6976562F77446C7475662B527A2F3831592B4444756A2F414B554C34382F35307638415453642F6976562F2B5732352F7743527A2F38414E57506777376F2F36554C34382F353076394E4A332B4B39582F3562626E2F6B632F38417A566A344D4F36502B6C432B505038416E532F30306E31462B5774784A636558624761646D6B6B6149466D596B6B6D70367363354C56674449514F39376252456E46456E755A4C6D4B356A735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356662F3050564F4B757856324B757856324B757856324B757856324B757856354C35767550583153647577594C2F77494335355632766B3439524D2B66442F414B5163446E59785153664E4F324F7856324B7577717836356C3957526E38546E30483262706679324347502B0A5A416358396636736E2B7A346E792F5635764779536E2F4144706637482B482F59715762467848597137465859713746585971374658597137465534387265585A646576567459396F7838556A6679714F762B79503256796E4E6C474D5735656C30357A7A34522F6E66315876566E5A7857634B57304368596F774655447747632F4B526B624C336349434145527969725A466D314A4773696C48415A5473516477636270424638324A36332B57656C366A5634462B71796E7648396E36592F732F3842777A4D7836715565667164566E374D78354F5837755839482F69586E586D4438763841557447426C4B2B7441503841646B6539422F6C723970662B492F3557624C4871597A38693839714F7A386D4866366F2F7A6F735A7A4B646137465859713746585971374658597137465859713746585971374658597137465859716E6D6D767A685832327A7848326C776546713566375A773550395048316637506966524F794D6E486748394734666A2F4E525763773764324B757856324B75'
		||	'7856324B733338676559714839475842324F38525034782F38414E4F64723242326A583769662F4A4C2F414B702F385334325748566E656477347A73566469727356646972735664697273566469727356646972735664697278503834767A4631337939724B32576C33506F77474248342B6E473378457655316B52322F5A7A666148537779517551733858664A35767448575A4D575468696547504433522F5577622F6C64586D7A2F414A62762B534D502F564C4D2F7744495975372F414755762B4B645A2F4B57622B642F735966384145752F35585635732F774357372F6B6A442F3153782F495975372F5A532F34706635537A667A76396A442F69586638414B36764E6E2F4C642F77416B59663841716C6A2B517864332B796C2F78532F796C6D2F6E663747482F45752F35585635732F3562762B534D502F564C48386869377638415A532F34706635537A667A76396A442F41496C332F4B36764E6E2F4C642F7952682F3670592F6B4D58642F7370663841464C2F4B57622B642F7359663853372F414A585635732F35627638416B6A442F414E55736679474C752F3255762B4B582B55733338372F59772F346C332F4B36764E6E2F41433366386B59662B7157503544463366374B582F464C2F41436C6D2F6E663747482F45752F35585635732F3562762B534D502F414653782F495975372F5A532F77434B582B55733338372F41474D502B4A642F7975727A5A2F793366386B59662B7157503544463366374B582F464C2F4B57622B642F735966384145752F35585635732F774357372F6B6A442F3153782F495975372F5A532F34706635537A667A76396A442F69586638410A4B36764E6E2F4C642F77416B59663841716C6A2B517864332B796C2F78532F796C6D2F6E663747482F45752F35585635732F3562762B534D502F564C48386869377638415A532F34706635537A667A76396A442F41496C332F4B36764E6E2F4C642F7952682F3670592F6B4D58642F7370663841464C2F4B57622B642F7359663853372F414A585635732F35627638416B6A442F414E55736679474C752F3255762B4B582B55733338372F59772F346C332F4B36764E6E2F41433366386B59662B7157503544463366374B582F464C2F41436C6D2F6E663747482F45752F35585635732F3562762B534D502F414653782F495975372F5A532F77434B582B55733338372F41474D502B4A642F7975727A5A2F793366386B59662B7157503544463366374B582F464C2F4B57622B642F73596638414576665079773171373176793961366871442B7263792B707961675776475352462B4641712F5A5666326335335634786A79474D6670322F334C314F6879797959684B57386A662B364C4B6378'
		||	'484F646972735664697279443830667A70476E4D2B6B364177613546566C6E3668442F4143522F73744A2F4D2F32552F774262374736306567347656503666345976503637744C67394750367634702F7741332B71384875626D57366B61653464704A584E575A69535354335A6A6E516741436738764B526B624B6C6B6B4F7856324B757856324B757856324B757856365A2F7A6A372F414D7045332F4D4E4A2F784B504E56326E2F642F3577647A32542F652F77436166304D332F7743636A6638416A6B57762F4D542F414D61506D423258395A2F712F70646C327839412F72663731382B5A306A796A73566469727356646972735666576635572F38414B4E61662F774159522B73357875732F764A65393776512F33556636724B6378484F646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F2F3066564F4B757856324B757856324B757856324B757856324B753659713854765A2F7245386B3338377333336D75654D5A386E69544D76353870532F3078646942536A6C4B58597137465643396C394F466D37306F50707A643969616238787159522F6834754F583958462B382F32584477757637517A6546686C4C79346639503655677A3370383064697273566469727356646972735664697273565878524E4B367878677337454141645354300A47416D6B6757614433627958355954514C49524E5133456C476C62332F414A522F6B702F7A646D677A356645506C2F43397A6F744B4D454B2F6A6C3966342F6F702F6D4F35377356646972735664697245764D333563574F72316D74774C65354F2F4A52384C482F4C542F6A5A662B477A4D786171554E6A366F757031585A734D753439452F7744592F77436446354E726E6C3638305362304C3143746673734E31622F56622F4E73322B504B4A697738706E3038384A71512F77434A53334C58486469727356646972735664697273566469727356646972735664697273565458523371724C34477633353562375A5961795179667A3453782F38414B7558462F774250587375774D6C786C482B6249532F302F2F53435935353439533746585971374658597137465630636A524D4A454A566C49494937455A4B4D6A45324F595636373563316C64577446754F6B672B4678344D50362F617A316E73375744565968502B4C36636E3966386570774A7834536D65624A673746585971374658'
		||	'59713746585971374658597137465859713746587A66384138354266387045762F4D4E482F7741536B7A714F7A5037762F4F4C782F613339372F6D6A394C7A504E71365A324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B75785639532F6B722F7969646A2F7A322F35505335794F762F76542F6D2F376D4C322F5A76384163782F7A7639334A6D2B5944736E59713746586D5035312F6D4732675767307177626A6658536B73774F386366546B50387554374B66374E7674636332326730766948696C394566396C4A3076615773384B50424836352F37474C3579363530377944574B757856324B757856324B757856324B757856324B7654502B6366662B5569622F6D476B2F77434A52357175302F37762F4F447565796637332F4E503647622F41504F52762F4849746638416D4A2F3430664D447376367A2F562F53374C746A36422F572F7742362B664D36523552324B757856324B757856324B76725038414B332F6C4774502F414F4D492F576334335766336B766539336F663771503841565A546D49357A735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356662F3076564F4B757856324B757856324B757856324B757856324B6F5456352F71396E504E33534E79506D426D4A71386E683470532F6D770A6C2F755755525A654D5A34363742324B757856324B706472456C465750784E633946396A644E633535542F4445596F2F352F726E2F75492F365A3558742F4E555977372F582F414B582F414B5353725055486A6E5971374658597137465859713746585971374658705035566556656266706D35585A53566842376E3971542F592F5A582F5A5A724E5A6D2F68482B6339483256704C2F65532F7A503841696E702B6170365A324B757856324B757856324B75785644616A703176714D4C573132676B696271442B7365422F79736C4752696244586B78787944686B4F4B4C79487A6C2B58732B693175725373316E314A2F61542F582F77416E2F4C2F344C4E7A6731496E736671655231765A78772B715071782F376A2B742F785444737A58554F7856324B757856324B757856324B757856324B757856324B75785648364F314A4758784763483759347277526C2F4D79385038417034532F346836587347645A44482B64442F63792F7743504A766E6B7A327A735664697273566469727356'
		||	'64697249664A4F74666F363945546D6B4D394662325037445A30485975742F4C3565452F33655830532F726677532F48383571795273505563394E634A324B757856324B757856324B757856324B757856324B757856324B766D2F38413579432F35534A662B5961502F69556D6452325A2F642F3578655037572F766638306670655A357458544F7856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B767158386C662B555473662B65332F4A36584F52312F39366638332F63786533374E2F75592F35332B376B7A664D423254735655376D356A74596E754A6A786A6A557378505941636D4F45437A5159796B4969792B50764E666D43587A44716478716B31617A4F536F50374B6A3459302F324B63526E6134635178784552306650382B59355A6D522F69536A4C3268324B757856324B757856324B757856324B757856324B76545038416E48332F414A534A762B5961542F695565617274502B372F414D344F35374A2F766638414E503647622F38414F52762F4142794C582F6D4A2F77434E487A41374C2B732F316630757937592B6766317639362B664D36523552324B757856324B757856324B7672503872662B5561302F2F6A4350316E4F4E316E39354C33766436482B366A2F565A546D49357A73566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356640A69727356646972735664697273566469727356662F2F543955347137465859713746585971374658597137465859716B6E6E576630744B6D3857347150705966777A5339745434644E4C2B6C77782F3251624D593365555A3559357A73566469727356535455354F6378485A64733973396D644E344F6B69663473706C6C2F3373503968434C353732786C38544F663646512F482B63684D366C307A73566469727356646972735664697273565466797435666B31322B537A536F5437556A6679715074482F6A566638414B796E4E6B384F4E755870644F633878456635333956373762573064724573454B6859304156514F77476338545A7376655269496968794370675A4F7856324B757856324B757856324B757856706C4441717771447351635665562B666679372B71427453307466335057534966732F356166354838792F7366366E32647470395466706C38336C74663264776576483950384146442B622F562F6F76504D32547A3773566469727356646972735664697273566469'
		||	'7273566469714C307871546A33722B724F5639714963576A6B66356B6F532F77426E47482B2F647A32504B73342F7063582B35346B377A78523943646972735664697273566469727356646856363535583162394A324B544D61794C38442F774373502B6176745A36763258712F7A4F455350316A30542F72782F77434B2B70775A7834536D3262567264697273566469727356646972735664697273566469727356664E2F2F4F51582F4B524C2F77417730663841784B544F6F374D2F752F38414F4C782F613339372F6D6A394C7A504E71365A324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B75785639532F6B722F77416F6E592F38397638416B394C6E49362F2B395038416D2F376D4C322F5A76397A482F4F2F33636D6235674F7964697242667A71316B365A35616E43476A334A574166374C347050766953544E686F4D66486B483948314F733753796347492F302F522B5038313875353172784C7356646972735664697273565A7235502F4B5857764D385975595557433062704C4B5341772F34725556642F6E396A2F414373774D2B7468693250716C2F4E69374854396E354D7773656D503836543057772F357876736C412B753330736A642F545255482F442B726D736C32716567447434646A522F696B6638414E2F456B772F36463130442F41482F65663848482F77425563722F6C544A33512F77426C2F774155336679506A37352F4F50384178434676502B6363644C634836706554786E747A43503841385257484A7837556C314566782F706D755859304F686C396B76384169574A617A2F7A6A3172566F4331684C0A4664714F31665462376E2F642F77444A584D7A48326E412F566350396B344754736A4A4836534A2F37483866365A4E667958386B367A6F6D754E63366C617951512B6736636D7053704B62624832796E583669475346525046366D2F7333545A4D6553354468394A54372F6E49694635644A74524770592F576577722B772B592F5A5A715A2F712F70637274675841663176305041507146782F76742F774467546E52385165563454334F2B6F58482B2B332F34453438515868506337366863663737662F67546A78426545397A767146782F76742F384167546A78426545397A767146782F76742F774467546A78426545397A767146782F76742F2B424F5045463454335071333873454B6557374257424245497144387A6E4836762B386C37337574442F64522F71736F7A456331324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B75785632'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B762F395431546972735664697273566469727356646972735664697246507A486E345743526A71386F2B3442762B62633562326A6E5745442B646B2F334D5A4E2B4562764F4D38376374324B757856706946465430475468417A496950716B65482F544D5A5345525A364D63647937466A314A726E305867784444434D427978786A442F534468664B736B7A4F526B6634695A66365A626C3757374658597137465859713746585971374658742F774358766C6A394332496B6D464C6D346F7A2B49483745662B782F612F79733057707938637476706939723264706642685A2B756631663853796E4D52326A7356646972735664697273566469727356646972735664697279663878664976314574716D6E722F414B4F545752422B77542B32762B51662B452F316673376654616A69394D75627976614F673450336B50702F696A2F4E2F77434F765038414E693642324B757856324B757856324B757856324B757856324B71396961544A383830666273654C535A422F513476394A366E59396D797250482B736E2B654450705473566469727356646972735664697273565A622B585770656A64505A7366686D576F2F316C2F77436265576458374F366E67794847655755656E2B76442F6A6E45305A6F375739467A304A7848597137465859713746585971374658597137465859713746587A662F414D354266387045762F4D4E482F784B544F6F374D2F752F3834764839726633762B615030764D383272700A6E59713746585971374658597137465859713746585971374658597137465859713746585971374658314C2B53762F4B4A325038417A322F35505335794F76384137302F35762B3569397632622F63782F7A76384164795A766D41374A324B7647502B636B7234726232466D44733779534566366F56462F354F4E6D38374B6A76492B353533746D5730523735666A2F5450437336463568324B757856324B7578566C333557655531387A363346617A69747445444E4D5046567038482B7A646B542F567A43316D62776F456A36767069352B68302F6A5A4144394939556E3161694B696845414367554147774147636539794254654B585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971'
		||	'374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F3166564F4B757856324B757856324B757856324B757856324B73472F4D32622F41486D69482B57782F774346417A696661616630522F72792F774279354F487177624F49636C324B7578564433386E43466A34696E3335304859474478745841667A5A654A2F797139663841757546316E6165587738456A336A672F302F7053485064587A64324B757856324B757856324B757856324B73772F4C5879312B6C622F367A4D746265326F7872304C66734A2F7873332F4E3259657179384561484F54742B7A644E34732B492F526A2F3358384C326A4E47396B374658597137465859713746585971374658597137465859713746576E525A464B4F4156595549505167346F49765A346C3539386E6E51626E315941545A7A4538442F41436E76476638416A542F4A2F7742584E3770382F694466366738587239483445724839334C3666365038415259726D573674324B757856324B757856324B757856324B757856567454535650395966727A57647169394E6B2F34546C2F365A79637A52477330502B47512F335449632B66583039324B757856324B757856324B757856324B712B6E336A575678486370316A594E3933624D6A54356A686D4A6A2B43516B67697854326D4F525A46446F6171774242396A6E73635A4351736458584C736B7273566469727356646972735664697273566469727356664E2F2F41446B462F774170457638417A44522F38536B7A714F7A50377638417A69386632742F652F7743615030764D383272706E5971374658597137465657316A0A4573715274305A6744394A794A4E424D525A66526E2F41454C3735642F6D756638416B59762F4146547A6D663554796630666B39662F414354692F706650396A762B6866664C7638317A2F77416A462F3670342F796E6B2F6F2F4A66354A786630766E2B78332F5176766C332B61352F35474C2F3154782F6C504A2F522B532F7954692F706650396A762B6866664C7638414E632F386A462F3670342F796E6B2F6F2F4A66354A786630766E2B78332F5176766C332B61352F35474C2F3154782F6C504A2F522B532F7954692F706650384159372F6F583379372F4E632F386A462F3670342F796E6B2F6F2F4A66354A786630766E2B78332F5176766C332B61352F35474C2F414E5538663554796630666B76386B347636587A2F59372F414B463938752F7A58503841794D582F414B70342F7741703550365079582B536358394C352F73642F7742432B2B586635726E2F414A474C2F77425538663554796630666B7638414A4F4C2B6C382F324F2F36463938752F7A58502F41434D582F716E'
		||	'6A2F4B65542B6A386C2F6B6E462F532B6637486639432B2B586635726E2F6B59762F5650482B55386E3948354C2F4A4F4C2B6C382F324D3438742B5837627939595261585A466A42447934387A552F457A5347706F7637543572387555354A6352356C326548434D55524750307854504B6D35324B76412F2B636B4A7136685A52562B7A437A552B62552F34307A6F7579783653664E3562746B2B71492F6F76483833627A377356646972735664697233442F6E47327748472F7654314A696A482F44752F2F476D6144745758306A337653396A512B715839574C327A4E4339493746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F3176564F4B757856324B757856324B757856324B757856324B764F767A496C355830636638735150337333394D3839396F35336C69503575502F64536B3565486B784C4F5562335971374655763168364971654A72393265672B78754469797A79667A4943482F4B32582F5670356A742F4A5549782F6E53347638415366384153615535366F38573746585971374658597137465859717669696156316A6A425A32494141376B394D424E4A4173304876336C545156304F776A737854314B6370434F376E37582F414453762B0A546E505A736E6953743733536166774943502B6D2F724A766C4C6C757856324B757856324B757856324B757856324B757856324B757856324B6F4C576449683165316B73726B56535164653450374C4C37726B34544D4459616332455A596D4D75727748574E4A6D306D366B73726755654D307232492F5A59657A444F69684D544668344C4E694F4B5269663455466B326C324B757856324B757856324B757856324B716B48393476384172443965594F762F414C69662F43736E2B346B35476D2F76492F31342F7743365A466E7A772B70757856324B757856324B757856324B757856324B76562F4A6C3739613079496B31614F735A2F77426A396E2F684F4F6570396A5A7646303866364837762F5366542F734F467763676F70336D366133597137465859713746585971374658597137465859712B622F2B6367762B5569582F414A686F2F774469556D6452325A2F642F774363586A2B317637332F4144522B6C356E6D31644D374658597137465859717232482B3945662B757636386A'
		||	'4C6B796A7A4437567A68483064324B757856324B757856324B757856324B757856324B7578565475626D4F316965346D50474F4E537A487741484A6A68417330474D7043497373542F35573735582F7743573950384167582F356F7A4D2F4A5A663576334F442F4B47482B642F756E6638414B33664B2F77447933702F774C2F38414E4750354C4C2F4E2B35663551772F7A763930385A2F4F377A4E702F6D4455726534307559547870427859674555504A6D703859584E353266696C6A695249635071656437547A78797A4269654C30764F63326A714859713746585971374658733335492B6474473876366463513670634C424C4A5079414B73535634715032466276797A52396F61656553514D5278656C364C737A55343855534A4868395430622F6C62766C662F6C76542F67582F414F614D3166354C4C2F4E2B35322F386F596635332B36642F7741726438722F41504C656E2F41762F774130592F6B73763833376C2F6C44442F4F2F3354762B56752B562F77446C76542F67582F356F782F4A5A663576334C2F4B47482B642F756E6638726438722F77444C656E2F41762F7A526A2B53792F774133376C2F6C44442F4F2F7742307944512F4D466A7273483176544A524E43474B3867434E783148784266484D664A696C6A4E53464F56697A527969346E6943595A5533496255745374394E7433764C78784842454F5473616D672B6A4A77675A47687A59546D4944695030686A482F4B33664B2F2F414333702F7741432F77447A526D562B53792F7A6675634C2B554D5038372F644F2F35573735582F414F5739502B42662F6D6A48386C6C2F6D2F6376386F596635332B360A642F79743379762F414D74366638432F2F4E4750354C4C2F41446675582B554D5038372F414854762B56752B562F38416C76542F4149462F2B614D667957582B6239792F7968682F6E663770332F4B33664B2F2F414333702F7741432F77447A526A2B53792F7A6675582B554D5038414F2F3354762B56752B562F2B5739502B42663841356F782F4A5A663576334C2F414368682F6E6637706C734D79546F73735A716A674D443467376A4D4D69746E504276634C38435859713746585971374656737371516F5A4A57436F6F71574A6F41506334514C5154573565662B59667A78387636535448627531374B4F30492B482F6B613346502B5266715A7363585A2B5366503066316E565A75314D554F58377A2B722F7854414E562F35794D3153616F302B3168675539334C534E2F7A4B582F684D32554F79346A36695A66374631575474695A2B6B526A2F414C4C2F41496C6A747A2B64666D6D636D6C324931505A496F782B4A526D2F34624D6B6144454F6E32796353586157593966384159'
		||	'7855462F4F447A53704246383233696B5A2F3430795835484633663770682F4B47622B642F7566314A685A2F6E74356E7479444A4E4650542B654A52582F6B5636575679374F784870772F46756A32706D484D69582B622F77415477736F306A2F6E4A4355454C716C6B705875304445552F35357963712F774449334D53665A512F68502B6D633348327966346F2F365438663735364A35642F4E62792F727045647663694B5A7639317A66413379484C3932332B776473316D5852354D664D663656322B48583473764930663573765379374D4A7A306931377A7A6F336C2B5A6262564C6C594A58586D4649596B725572792B42573771325A4750547A7943346A6963584C717365493149384B576638726438722F3874366638432F38417A526C76354C4C2F4144667561663551772F7A763930372F414A573735582F3562302F34462F38416D6A48386C6C2F6D2F6376386F596635332B36642F7741726438722F41504C656E2F41762F774130592F6B73763833376C2F6C44442F4F2F3354762B56752B562F77446C76542F67582F356F782F4A5A663576334C2F4B47482B642F756E6638726438722F77444C656E2F41762F7A526A2B53792F774133376C2F6C44442F4F2F7742306E486C377A6670666D4C315030564F732F6F3865644177707935636674717658673255356345735831446874794D4F6F686C766750467770786C446B4F7856324B725A4A466955764951716A636B6D674745433045307833552F7A493875366255584E2F445564516A656F522F73596655624D6D476C79533552502B352F33546954316D4B484F556639312F75574A366C2F7A6B4A6F56767461780A7A33446549554B76337533502F414A4A356D51374D6D65664446774A397234787945704D61766638416E4A4B34626130734554336B6B4C666771782F38537A4B6A32554F737673634F58624A36522B314A62722F6E49507A444C2F64706252442F41435932502F4533664C78325A6A48383578706472355479345238503270644E2B642F6D7154374E307166367355662F4142736A5A614F7A38586439736D6B3970356A312F77426A48395346663834504E4C486B6235716E77534D6671544A2F6B6358642F756D48386F357635332B352F55742F355739356F2F3562332F3446502B614D6679574C2B6239362F77416F5A7635332B355659767A6D38315269677669523778524839636541364445656E32792F576B64705A682F462F73592F38536D46762B66586D574C376277792F3630592F356C384D72505A324D392F7A626832726C4838302F424F37482F6E4A4455452F3373736F5A502B4D624E482F785031387835646C7836452F37722F69584A6A327A496656474A2F712B6E2F6932'
		||	'5536562F7A6B4E6F7479517437464E6245393642314830703866384179547A456E325A4D63694A4F626A3758786E36684B482B795A336F666E48534E64482B343236696D6272784455663841354674786B2F34584E666B7754782F55434861597452444C394A4576782F4E546A4B4849646972735664697273566469727356646972735664697145315056375453346A63583879515244397152676F2F484A77675A6D6F6A69613535497746795043774857507A383876324E55746656753348386938562F7743436C34482F414946477A5977374E7953353142316554745846486C632F782F53596671502F41446B686575543951736F6F78324D72732F3841784430637A6F396C52366B2F3576346B363666624D7634596A2F4F39582F45704264666E78356D6D2F7535496F7638415569422F354F65706D514F7A7359377A3858466C32726C5055522F7A55756B2F4F507A564A7531383233684847503841694D655744513468302B325836326F396F356A2F4142665A482F6956762F4B33764E482F414333502F7741416E2F4E4748386C692F6D2F656A2B554D3338372F41484B4B682F4F377A5647617464712F733055662F47694C6B443266693776746B7A486165596466396A4839536257662F4F513276513754785730773731526C502F4376782F34584B70646D597A7934673378375879446D49792F48765A4670762F4F534D4C55476F574C4C34744649472F345231542F6B356D4C50736F2F776E2F544F5A44746B6678522F30705A706F7635782B5739554955585031647A2B7A4F4F482F442F33582F4A544D484A6F636B4F6E462F56646A6A375278543638503966302F770A444857597758456477676C685A5A4932364D7042422B5247594A42477864694344754654416C324B762F312F564F4B757856324B757856324B757856324B757856324B764C76507376505648582B52554834637638416A62504D75337058714350357359782F3250462F766E4E78636D505A7A376137465859716B2B727657554C34445058765A48447761637A2F414E5679482F53777150384175754E345874334A785A52482B5A482F4148583469676337643535324B757856324B757856324B7578566E50355665582F72743664526C46597262375075353666384150692F34444D44575A4F4563492F6964333256702B4F66476670782F37762F6A72312F4E4D3963374658597137465859713746585971374658597137465859713746585971374658597177663830504C4836517450306A4150333973506970315A5032762B5266322F2B447A50306D5868504366346E5364716158784938592B71482B342F343638667A637649757856324B757856324B757856324B75785655672F7646'
		||	'2F31682B764D48582F414E78502F6857542F6353636A5466336B663638663930794C506E68395464697273566469727356646972735664697273565A372B576C31574F653250374C4B342B6B63572F3469756431374E5A626A4F486E47662B6D39502B38693432596457613532626A4F7856324B757856324B757856324B757856324B75785638332F41504F51582F4B524C2F7A44522F384145704D366A737A2B372F7A69386632742F652F356F2F53387A7A61756D646972735664697273565637442F656950384131312F586B5A636D55655966617563492B6A757856324B757856324B757856324B757856324B757856324B705835722F414F4F52652F38414D4E4E2F78427375772F575036306676614D2F30532F71792F7742792B4E38376438396469727356646972735664697273566469727356646972735664697273566653502F4F50762F4B4F742F7741784D6E2F455938356674503841765038414E4432485A503841646635782F51394C7A564F3559742B61582F4B4E61682F78685036786D586F2F37795076634858663355763672354D7A736E68485971374658597137465859712B7A39432F7742344C622F6A44482F78455A773254366A37792B6959767048395549334B3231324B757856324B734F382B2F6D6670336C46444849665876694B724170332F7742615676384164612F384D33374B356E616253537A6630592F7A6E583672585277626656502B5A2F7858383138382B622F7A4331627A56495466796B515671734B62526A2F592F74742F6C5079624F6C77616147486B4E2F3533385479576F316338353952395038332B466A575A5468757856324B75780A56324B757856324B737A386E666D7672506C6B72476B6E316D30485747556B67442F6974767452665238482B526D446E30634D7639475838364C73645072386D4862366F2F7A5A666A306F483877764E34383261712B7049686A6A4B496949787156436A34685566385763386E707348677734577256366A783538587559316D5734627356646972735664697232372F6E476E2F705A2F39472F2F4144507A5164712F772F35332B39656B37462F692F77417A2F66766273304C30727356516D727974445A5479526D6A7245354248596854544A7746794876613868714A506B2B4F395431752B31562F557637695734627257527931506C794F32647444484748306752665070355A542B6F6D58395A425A5931757856324B757856324B757856324B757856324B757856324B74717851686C4E434E775267566E6E6C5438353963304972484E4A39647468743663784A59442F496D2B327638417375612F3547612F4E6F495A4F586F6C2F522F346C326D44744C4A69352F76492F77424C2F69'
		||	'6E756E6B723879744B383270787448394F36417130456D7A44784B6470452F77417066396D71357A2B6F306B7350503666357A302B6D31734D2F4C3676356A4B3877334F6469727356646972735664697143316E573750526264727A555A5668685839706A315038716A717A66354B355A6A786D5A71497471795A593478636A7768346E35782F77436367726D344C572F6C3550526A366574494158502B704875696637506E2F734D3332447377446566712F6F764E366A74596E62483666366376716554366C717433716B70754C365A3535542B314978592F384E327A6351674943674F463055386B706D354869516D54594F7856324B757856324B757856324B757856324B706A6F2F6D48554E476631644F754A4947366E677841502B737632572F3257565478526E3951346D33486D6C6A33695446365A355A2F357947763755724672634B334D6665534F69534433342F33542F77444A4C4E566C374D69643448682F334C75734861386F375448482F536A365A663841452F376C3731395A58306658333438655876536E4C4F6472656E714C32742F2F3050564F4B757856324B757856324B757856324B757856324B764A504E736E716170634E2F6C552B344263386F37576C7861695A2F7066376B634C6E342B53555A715762735664697151587238356E50765437747339363745772B46706363663648482F414D72663376384176337A5474484A783570482B6C772F365430663731517A64757664697273566469727356646971364F4E70474349435759674144755469646B675873483044355730526446302B4B7A4832774B7566467A39762F414A702F316335334E6B34350A5739377063486777456638415466316B31796C793359713746585971374658597137465859713746585971374658597137465859713746576D554D4372436F4F78427856344E35303041364A71556C756F70432F78782F3670376637412F426E51594D6E484733684E62702F42794566772F56482B716B4F5A4467757856324B757856324B757856324B7174734B79702F724439656133744D317073682F326E4C2F307A6B35656A46355966384D682F756D5135382B50714473566469727356646972735664697273566469724B6679366E395055476A3753526B665343477A702F5A334A773579503538442B6954546D477A306E50526E446469727356646972735664697273566469727356646972357638412B6367762B5569582F6D476A2F77434A535A31485A6E39332F6E46342F74622B392F7A522B6C356E6D31644D374658597137465859717232482B3945662B757636386A4C6B796A7A4437567A68483064324B757856324B757856324B757856324B757856324B7578564B2F4E66'
		||	'2F4849766638416D476D2F346732585966724839615033744766364A66315A66376C386235323735363746585971374658597137465859713746585971374658597137465859712B6B662B6366662B5564622F414A695A502B497835792F616639352F6D683744736E2B362F7741342F6F656C35716E6373572F4E4C2F6C4774512F34776E39597A4C306639354833754472763771583956386D5A3254776A735664697273566469727356665A2B6866377757332F4747502F69497A68736E3148336C394578665350366F527556747273566469727A583832507A5754793068307A545347314A7875656F69422F6162786B50374366374E2F32566661364C522B4C367066522F753354612F582B4436592F336E2B342F34382B637271366C7570576E75484D6B726B737A4D616B6B3979633659414155486B4A534D6A5A55736B68324B757856324B757856324B757856324B757856324B757856324B757856324B75785637642F774134302F3841537A2F364E2F38416D666D6737562F682F7741372F65765364692F7866356E2B2F65335A6F58705859716774642F3367756638416A444A2F7845355A6A2B6F65384E575836542F564C34777A75587A74324B757856324B757856324B757856324B757856324B757856324B757856324B713170647A576371334673375279786E6B72716145456477526B5A524568525A526B596D772B6B76796F2F4E46504E555031472B6F6D70524C5539684B6F2F3359672F6E2F77422B4A2F736C2B4837484C367A522B4362483066376C3744516137787877792F76422F73336F6D61783237735664697273565972352B2F4D4B79386E323371542F0A764C715148306F5164322F796D2F6B6A2F414D722F4149484D7A54616157593766542F464A77645871343663622F562F4446387A6561664E326F655A376F33657053637A2B77673252422F4C476E622F695466745A3157484248454B69385A6E3145737875522F34366B3258754F3746585971374658597137465859713746585971374658597137465859712B7A2F38416A772F35342F38414775634E2F46385830542B482F4E662F3066564F4B757856324B757856324B757856324B757856324B764739656B39532F7547385A582F346B6338673130754C4E4D2F375A50384133547349386B446D4379646972524E4255354B4D5449304F7143614673625A75524A5066506F2F4641593469492F67416A2F705879656375496B2F7A6D737359757856324B757856324B7578566D50355836462B6B4E532B7379437356714F6674795039332F7A582F734D7774586B3459312F4F647632586738544A7848366366712F7A7634662B4B657A357048736E59713746585971374658597137465859'
		||	'71374658597137465859713746585971374658597137465748666D686F5836513030336359724E612F483830503934502B4E2F396A6D62704D6E444B76357A702B314D4869592B4966566A39582B622F414266385538597A6476484F7856324B757856324B757856324B71396B4B7A4A38383076626375485335442F414C5766396C365859646E433830503679663534492B6C757856324B757856324B757856324B757856324B7033354C6C3950565944324A596665725A75757870634F706A2F6E522F32456D764A79657235366D344C73566469727356646972735664697273566469727356664E2F38417A6B462F796B532F387730662F45704D366A737A2B372F7A69386632742F652F356F2F53387A7A61756D6469727356646972735656374861346A2F31312F586B5A636D556559665A2F774265742F384166696638454D3462684C364C784476643965742F392B4A2F775178345376454F39333136332F33346E2F424448684B38513733665872662F4148346E2F424448684B3851373366587266384133346E2F41415178345376454F39333136332F33346E2F424448684B38513733665872662F66696638454D654572784476643965742F384166696638454D654572784476643965742F77446669663841424448684B38513733665872662F66696638454D654572784476564935556C484B4E677736564272674970494E706235722F343546372F7A4454663851624C6350316A2B744837326E503841524C2B724C2F63766A664F33665058597137465859713746585971374658597137465859713746585971374658306A2F414D342B2F77444B4F742F7A45796638526A0A7A6C2B302F377A2F4E4432485A5039312F6E48394430764E55376C693335706638414B4E61682F774159542B735A6C36502B386A373342313339314C2B712B544D374A3452324B757856324B757856324B76732F517639344C622F6A44482F77415247634E6B2B6F2B38766F6D4C36522F56434E79747464697246667A483837522B55744C61373261366B2B43424433596A37522F79492F744E2F7741422B336D5A7064503430712F682F69634857616B5949582F462F412B553779386D765A6E75626C7A4A4E49785A3262636B6E71546E587869496967384E4B526B62504E52795446324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B76627638416E476E2F414B57662F52762F414D7A3830486176385038416E663731365473582B4C2F4D2F77422B39757A5176537578564261372F7642632F77444747542F694A797A4839513934617376306E2B715878686E63766E6273566469727356646972735664697273566469727356646972735664'
		||	'697273566469714C3072564C6A5372714B2B73334B547773475668346A2F6A55394758397063684F416D4B50497338637A4169512B714C3635386F2B5A59664D6D6D51367042734A562B4A663558473069663746762B462B4C4F4D7A346A696B596C37375435686D674A44716E47554F513746556F38312B5A62667933703075703358325978384B3932592F596A582F57502F412F61793744694F57516948487A356868695A46386D6559764D46333567765A4E52763235537948364648374B49503255584F797859686A6A776834544E6D6C6C6C785353334C576C324B757856324B757856324B757856324B757856324B757856324B757856324B76732F38413438502B6550384178726E446678664639452F682F7741312F394C31546972735664697273566469727356646972735664697278532B666E63535031713748377A6E6A4F63385535482B6C4C3733596A6B6F5A516C324B71563033474A7A37484E7032586938545559342F3762442F64657077396250677853503841516C397A48732B67587A42324B757856324B757856324B757856376A2B5857692F6F7653597934704C50384176572B6E37412F34446A2F7732614855354F4F583958307662646E595043786A2B6450312F7744452F7743785A506D4B374E324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856624A4773696C4846565945454875446842704246374638396559644A6253622B617962704778433137716669512F38446E523435386351587A2F4146474C77706D503833385253374C4848646972735664697273566469714B3031617A7237562F566E0A4D2B30732B48527A2F706345663841705A46322F5A45627A782F7A76397A4A504D385166524859713746585971374658597137465859713746557A38737356314B32492F77422B4B50767A5A646D47733850363857452B526576353632344473566469727356646972735664697273566469727356664E2F77447A6B462F796B532F387730662F41424B544F6F374D2F752F3834764839726633762B615030764D383272706E597137465859713746585971374658597137465859713746585971374658597137465859712B69762B6364662B4F42502F414D786A2F77444A75484F5A37552F76422F552F33306E7275782F37732F317A2F75594D2B38312F386369392F77435961622F69445A727350316A2B74483733615A2F6F6C2F566C2F755878766E62766E7273566469727356646972735664697273566469727356646972735664697236522F3578392F355231762B596D542F41496A486E4C39702F7742352F6D683744736E2B362F7A6A2B6836586D71647978623830762B55613144'
		||	'2F6A4366316A4D76522F336B6665344F752F7570663158795A6E5A50434F7856324B757856324B757856396E36462F764262663859592F774469497A68736E3148336C394578665350366F52755674726961626E70697235552F4E507A6D664E47735354524D545A77566A67486269507453663839572B4C2F5534667935312B6A776546437634706655384E727454343837483052394D50782F5359646D633639324B757856324B757856324B757856324B6F754C534C7955636F344A57486945592F77414D675A6764517A474F523541714D39724C626E6A4D6A49664267522B7643434479596D4A484E5379534859713746585971374658597137465874332F4F4E50384130732F2B6A663841356E356F4F3166346638372F414872306E597638582B5A2F7633743261463656324B6F4C586638416543352F3477796638524F57592F71487644566C2B6B2F31532B4D4D376C38376469727356524E6A70743171442B6C5A777954796679787157503841774B56794570694F3550437A6A417A32694F4C2B71796E542F77416F504D393951705A4E47703779737166384B37422F2B467A456C7273556576796332485A2B615838502B6D394B64516638342B2B59704B636D746F362F7A534E742F774142472B554874504750353379636B646B35542F4E2B663747332F774363652F4D4B6D6765324938524933385938483870342F77436C2B506976386B5A6636487A2F414F4F6F4F342F49727A50454B7044484966425A562F34334B5A594F306352362F59316E73764D4F672F307A476459386C617A6F344C33396E4E45673675564A582F6B59764A502B477A4B686E685036534844790A61624A6A2B6F5343535A6B4F4D374658597137465859713746585971396E2F35783038784D6B397A6F6B682B423139654D65444C524A422F736C4B663869383058616D4C59542F7A586F7578383235682F6E786536357A3730377356665048352F656244714770706F304C66754C4D5663646A4B772F356C7830582F4147556D644C3262683459385A357A2F414E79386C3274714F4F66415070682F75336C57626830627356646972735664697273565A4C35642F4C6E58664D41456C68617559542F757836496C5046576B34382F2B65664C4D584C716F592F714C6D5964486B7937784733383736597331737638416E48505670414464585676465873764A79503841685938774A647151484953646C4873655A356D4952332F51746C782F3163452F3546482F414B715A582F4B6F2F6D2F613266794D6635332B782F616C39332F7A6A707245597262334E764A374D58552F3851664C49397151366954564C73655935475032735831663870664D756C67744C5A7649672F6168496B2F3457'
		||	'506B2F2F43356D5131754F66582F54656C77736E5A2B57484F502B6C39544570596E6859787971566454516769684239786D5944626745567A5759554F7856324B76732F774434385038416E6A2F78726E446678664639452F682F7A582F2F302F564F4B757856324B757856324B757856324B757856324B76446E59735378366B317A78516D7A62736D73697273565175704E53427665672F484F6E396D73664872496630654F582F5375582B2B645232764C687753382B456637494A486E747A353237465859713746585971374655303873615364573147437A70565859462F3841564878502F77414C6C57576642456C79644C68385849492F6A682F696651697146464273426E4F506F4473566469727356646972735664697273566469727356646972735664697273566469727356646972735664697279373834644A345377616B673263474A2F6D5069543731356638426D323055396A46356A746A4652452F77444D502B3965635A736E6E585971374658597137465859716A744957737050677563563758354F485441667A387366397A4F5430505955627A452F774132422B2B4B635A342B393037465859713746585971374658597137465859716A2F41432F583949323348723679663853475A2F5A2F392F43763955682F756D4D2B5265783536383639324B757856324B757856324B757856324B757856324B766D2F77443579432F35534A662B5961502F41496C4A6E55646D6633662B63586A2B317637332F4E4836586D656256307A735664697273566469727356646972735664697273566469727356646972735664697273566652582F41446A722F7741634366380A41356A482F414F54634F637A32702F65442B702F76705058646A2F335A2F726E2F41484D4871457353544930557168306346575668554548717244777A556730376F6939696B332B4274412F3674746E2F414E4938662F4E47582F6D4D6E3836662B6D6B342F774356782F7A596636534C76384461422F3162625038413652342F2B614D667A47542B6450384130306C2F4B342F3573503841535265472F6E3370466C706571573056684246626F3176794B784971416E6D2F78454946337A66396D7A4D346E694A6C3676346E6D65316363595441694248302F7741507036764D4D327A7058597137465859713746587050354461565A366E7263304E2F424863526931646773714B344239534563754C6868796F787A56396F7A4D494178504436763466644A33485A574F4D386845674A656A2B4C31667852653866344730442F713232662F5350482F7A526E50666D4D6E3836662B6D6B39522B56782F7A596636534C76384461422F3162625038413652342F2B614D667A47542B64503841'
		||	'30306C2F4B342F35735038415352642F676251502B72625A2F77445350482F7A526A2B5979667A702F77436D6B763558482F4E682F7049752F77414461422F316262502F414B52342F77446D6A4838786B2F6E542F77424E4A667975502B62442F5352544C54394C744E4E6A394378686A743471387545534246716632754B41437556536D5A4779654C3374304952674B6942482B716963677A59742B61582F41436A576F66384147452F72475A656A2F76492B397764642F64532F71766B7A4F796545646972735664697273566469723750304C2F6543322F3477782F384145526E445A507150764C364A692B6B6631516A63726257442F6E48356F4F6736444C36527063585239434F6E5563682B38622F59783876396C787A59614844346D5158796A366E57646F352F43786D76716E364879336E577645757856324B757856324B7578565773374F61396D5332746B6153615168565652556B6E73426B5A5345525A5A52695A47687A65332B532F77446E4836464657363878755863372F56347A52523753536A346D2F77436566482F58624E446E3753504C482F706E70644E32534F65542F53522F3470367070486C6E544E48554C7039724642547569414D66395A2F74742F736D7A547A79796E39524D6E655938454D6630675254504B6D35624C456B716C4A46444B656F49714D494E4949766D7872562F774173764C757167693473596C592F74524430322F344B4C68582F4147575A554E586B68794A2F7A765534655452597038346A2F4E39482B35664E763568655859504C6D75584F6C326A4D304D4A546958494A6F794A4C76546A30353531476D796E4C4153505839620A783272776A446B4D42796A2F785045787A4D7078485971374658597137465874332F41446A542F77424C502F6F332F77435A2B614474582B482F4144763936394A324C2F462F6D66373937646D68656C6469714331332F6543352F77434D4D6E2F45546C6D5036683777315A6670503955766A61307335727956594C614E705A5732565542596E354B7564764B51694C4C3537474A6B614737306279332B516D74616E786C31417059776E73337853552F3478727350396E496A66354F617A4C326C4350302B762F63753377396C5A4A37792F642F37722F53765439412F493779397064486E6A61386C4865592F44582F6A456E464B66362F715A71636E614753664C306631586459757938554F66722F726638537A7530736F4C4B4D5132736152526A6F714B46412F324B375A7235534D747937534D5245554E6C6249736E597137465859713772697243664E2F77435565692B59305A78454C57375053574941622F3841466B592B43542F69662B586D666731733858394B50383254726452'
		||	'32666A7A644F435838364C3576383065574C7A7931665070312B744A46334444374C4B667375682F6C502F4E756452687A444C48696938666E77537779345A4A546C7A5137465859713746585971797A387139534F6E2B5A624755476765555248333951656A2F78766D48724963574F58753476394C366E4F304D2B444C452B66442F702F532B734D343537745375376C4C574637695530534E533748324135484445576159796C7769792B4D645476354E527570623266655364326B62357365527A7559523451415034587A75637A4D6D522F6933513254594F7856324B757856324B76625079532F4C4B3076625965594E566A45334A6949493246566F7034744B362F742F4856555676682B486C2F4C7830506147724D547752322F6E5053646D614B4D68346B2F562F4D6A2F766E7541464E68307A515053757856324B757856324B705472336C5053396654303954746F35747142694B4D5039575261534C2F73577937486D6C6A2B6B30342B585477792F554F4A354435742F3578356C694458486C2B6231414E2F516D4944664A4A646B502B7A56502B4D6D627244326D44744D6635305851616A73676A6647622F6F532F77434B6551616A70747A70733757743747304D79476A49346F526D366A4D53466A6430453447427151345368736D77665A2F2F414234663838662B4E6334622B4C34766F6E38502B612F2F3150564F4B757856324B757856324B757856324B7578565A4D61497848576879452B5239795138517A7856324C7356646971423164715241654C444F32396B496357704A2F6D347066377145586E75335A5668412F6E54482B356B6B2B65767643757856320A4B757856324B75785636522B54326B38704A395359624B42456E7A5078762F414D616638466D7331732B55663835364C736646755A2F356E2F4666373136686D71656E6469727356646972735664697273566469727356646972735664697273566469727356646972735664697273565939352F77424D2F53476A7A6F4256347836712F4E5069502F43637379644E50686D4858396F59764578482B6A362F394B38497A6676444F7856324B757856324B7578564D394758376266495A3574375A356473635036382F384163786A2F414C3536333266683955763673663841644A6E6E6D62317A73566469727356646972735664697273566469715A6557564C616C6241663738583965624C7377586E682F5869776E794C324450573341646972735664697273566469727356646972735664697235762F774363677638416C496C2F35686F2F2B4A535A31485A6E39332F6E46342F74622B392F7A522B6C356E6D31644D37465859713746585971374658597137465859713746585971374658'
		||	'5971374658597137465830562F7A6A722F78774A2F2B59782F2B54634F637A32702F65442B702F76705058646A2F414E326636352F334D48715761683362735664697235392F35794E2F343639722F774177332F473735306E5A6630482B742B683554746A36782F562F337A79584E793646324B757856324B757856366E2F774134362F384148666E2F414F594E2F77446B35446D6F37552F75782F582F414E374A3366592F39346636682F33554830546E4D76584F7856324B757856324B7578566933357066386F3171482F47452F72475A656A2F414C795076634858663355763672354D7A736E68485971374658597137465859712B7A39432F3367747638416A44482F414D5247634E6B2B6F2B38766F6D4C36522F56434E7974746650582F41446B50725A757458683031543846724679492F79355069502F4A4E59383658737A4855444C2B63663979386E32766C347069503877663772385265555A7548524F7856324B757856324B75785639492F6B7A2B5855656857533674657058554C6C6551714E34305032554838727550377A2F6B582F4E7935665836727844776A36492F374B5432485A756A474B50484C2B386C2F7349765338315475585971374658597137465879312B64582F4B5758332F50482F6B7A466E5736442B36482B642F7570504564706633307638332F41484557455A734857757856324B757856324B76627638416E476E2F414B57662F52762F414D7A3830486176385038416E663731365473582B4C2F4D2F77422B39757A517653757856706C44417177714473516356554C62547261314A613369534D6E596C4641722F7741446B6A496E6D5745590A435049496A49733359713746585971374658597137465859713746586C6638417A6B48356653373065505656583939615341467638682F67492F3547656E542F41475838326266737A4C552B482B642F756F756A37587863554F5072412F37475435337A706E6B6E59713746585971374655666F4D336F616862545670776D6A61767959484B3867754A486B573345616B442F5344374E7A686E3052495050387A512B583952646576315755666570584D6E5443386B6636776358566D735576366B7675664957646F38413746585971374658597137465831442B5365707858766C6D326A6A50783235654E78586F65544F502B435231624F53313844484966365432765A6B784C4541503462697A764E653752324B757856324B757856324B7578564A664E486B3354504D30506F616E434849464663624F76384171536466396A396A2B5A6376773535596A635334326654517A4370442F696E68586D543868746273726F707043433874547572383052682F6B794C497966462F6C4A38502B'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'72396E4F6878646F776B5056364A6646356A4E32566B69665236342F774362482F64506F5830482B71656A54342F543430392B4E4D35713937657472303135502F2F56395534713746585971374658597137465859713746564739597042497736684750345A546D4E514A2F6F792B3549654A3534773746324B7578564C745950777150633536463747522F65545039434D66394E4C2F4149363876322B6654456630696C57657076474F7856324B757856324B75785637763542307A39483650416846486B5831572B622F45502B4534726D67314D2B4B5A653537507865486948394C312F365A6B4F597A734859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465770455752536A6971734B4565787843434C32664F4F70575A7362715731627245374A2F774A343530305A635142664F38734F43526A2F4E504368736B31757856324B757856324B7078704B556972346E50482F61374E78366B522F315048482F414530754B663841784C336659634F4844663841506D662B4A52326355394137465859713746585971374658597137465859716E586B794C314E566748675750334B787A63396A52347454442F4F6C2F70595361386E4A36786E716A67757856324B757856324B757856324B757856324B75785638332F38354266387045762F414444522F774445704D366A737A2B372F774134764839726633762B615030764D383272706E597137465859713746585971374658597137465859713746585971374658597137465859712B697638416E48582F414934452F77447A47503841386D3463356E74542B38480A39542F6653657537482F757A2F41467A2F414C6D44314C4E513774324B757856382B2F38414F52762F41423137582F6D472F77434E337A704F792F6F5039623944796E6248316A2B722F766E6B75626C304C7356646972735664697231502F6E48582F6A767A2F38414D472F2F414363687A5564716633592F722F373254752B782F7743385039512F377144364A7A6D58726E59713746585971374658597178623830762B556131442F6A4366316A4D76522F336B6665344F752F7570663158795A6E5A50434F7856324B757856324B757856396E36462F764262663859592F2B496A4F4779665566655830544639492F716847355732766B54387774532F53586D432F756131426E645650697148306B2F774345526337545451346363522F52654231632B504C492F77424C2F632B6C6A325A4C694F7856324B757856324B73752F4B767979766D48587265326D586C4248576155654B702B79665A333449332B746D46724D76683479527A2B6D4C6E364844347551412F5439557638313958'
		||	'5A78373354735664697273566469727356664C5835316638705A66663838662B544D5764626F50376F6635332B366B3852326C2F66532F7A663978466847624231727356646972735664697232372F6E476E2F705A2F384152763841387A383048617638502B642F7658704F78663476387A2F66766273304C3072735664697273566469727356646972735664697132535659313553454B6F376B304745433045306C563135783057302F336F76725A4434475A41663841676556637547435A3543582B6C614A616A48486E4B50384170676C64782B61336C6D33727A76346A542B586B332F4A7457793061504B66345330485834682F45457275507A7A38727866596E6B6C2F31596E2F356D4B6D576A732F4B656E32744A3755776A72662B6157482F414A672F6E506F7576364E633656615258426C6E56654C4F6968515136763841462B383566732F795A6E61625154787A456A7737666A756466712B30736558475941533958362F367A784C4E383832374658597137465859717232482B3945662B757636386A4C6B796A7A4437567A68483064492F506475626A516451694855327331506D45596A4D6A546D736B6636305846315176484966304A66632B503837563442324B757856324B757856324B7368386D65654E513870584A756242675565676B69626448412F6D2F79682B7936356A5A3950484D4B6B35656D3155734275502B64482B6339783875666E7A6F6570425531446C597A48593878795376744B672F346D695A7A2B5873366366703962307548745848503676335A2F32502B6D6567616471317071556671324D3063386638306242682F77414C6D756C4178320A493458617779526D4C69524C2B71697367324F7856324B757856324B757856324B7578562F2F3176564F4B757856324B757856324B757856324B75785651762F38416565582F4146472F566C4766364A66315A66376C493576464D385A646937465859716C6D736E37412B6638414450532F597550393666384168582F5431354C32675030442B76384137784C4D394B65526469727356646972735652576D5752767271473158724C497166384142476D526E4C68424C5A696878794566357834583061694C476F52525256464150595A7A4C364942577A654B58597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597138512F4D71792B7136334D52396D554C49507046472F3464577A653657567744785061634F484B6636565359746D573678324B757856324B75785650374A4F454B443272392B2B654364745A764731575358394D772F355666757639342B6D646E342F447778483948692F302F722F3379766D6C633932'
		||	'4B757856324B757856324B757856324B7578566B2F3565516570714A662B534E6A3939462F34327A70765A3648466E762B5A435836492F3735707A485A36586E6F3768757856324B757856324B757856324B757856324B75785638332F41504F51582F4B524C2F7A44522F384145704D366A737A2B372F7A69386632742F652F356F2F53387A7A61756D6469727356646972735664697273566469727356646972735664697273566469727356646972364B2F3578312F3434452F38417A47502F414D6D3463356E74542B384839542F6653657537482F757A2F58502B356739537A554F3764697273566650762F4F52762F485874662B59622F6A64383654737636442F572F513870327839592F712F3735354C6D3564433746585971374658597139542F414F6364662B4F2F502F7A42762F7963687A5564716633592F722F373254752B782F37772F7742512F774336672B6963356C3635324B757856324B757856324B73572F4E4C2F6C4774512F34776E39597A4C306639354833754472763771583956386D5A3254776A735664697273566469727356665A2B6866377757332F4747502F69497A68736E3148336C394578665350366F524E784D4949326C62374B4B57507941726B414C4E4E684E433378564E4B307A744B35717A456B6E334F6432425435775465367A4368324B757856324B757856376A2F7A6A6470594358326F734E795568552F4B736B6E363438304861732B5566383536587361483153393058746561463652324B757856324B757856324B766C723836762B5573767638416E6A2F795A697A7264422F64442F4F2F33556E694F30763736582B622F754973490A7A594F746469727356646972735665336638414F4E502F4145732F2B6A662F414A6E356F4F3166346638414F2F3372306E597638582B5A2F7633743261463656324B757856324B7578564B6465383236566F433839547559344E7168536173522F6B78725752763969755859384D736E30693348793669474C3669492F6A2B61383531762F6E49725472636C4E4C74704C672F7A5345527239483934352F34464D326D507375522B6F38502B7964526C3759695070426C2F735745366E2B66336D4736714C623062566533424F522B2B59794C2F77414A6D64447333474F64792F48394631732B31737375584444346638557871392F4D727A4865313958554A774431434E772F354E634D796F365448486C474C6879317557584F55763841632F376C494C6D386E756D3533456A534E347578592F3841445A6B6949484A785A534D75616A6B6D4C73566469727356646972735664697273566469717659663730522F36362F72794D75544B504D5074584F456652316C78417338625179626F36'
		||	'6C5438694B4843445736434C46506A44564E506654727561796C2B3342493062664E54787A75595334674350346E7A724A44676B596E2B45384B46796242324B757856324B757856324B7578565574376D57336353514F30626A6F796B672F654D6951447A53435275475561582B61766D5854514668767048556470615366386E51375A697A30654F584D663658302F376C7A59612F4C446C492F774364362F3841644D7230372F6E4972574961433874344A774F36386B592F547964662B457A446C325841386A4B4C6E7737596D4F596A4C2F597376306A2F414A7949306935495855494A72566A33464A4648307277662F6B6E6D46507379592B6B69582B78632F483276412F554A512F3258342F3072506444383561507275326D3363557A486667476F2F7744794B666A4A2F77414C6D7579594A342F71424474635770686C2B6B69582B362F3071633551354473566469727356662F58395534713746585971374658597137465859713746564B37586E43366E757048345A566C4678492F6F6C49654A5A34753746324B7578564B395A3670394F656E2B786E3035503632502F6676482B30484F482B642F7655747A305A3552324B757856324B7578566C66355A57583172576F6D4971734B7449666F4846662B476463784E564B6F4F30374D68785A522F52755432334E453971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597138722F4F533134334E74632F7A78736E2F416E6C2F7A4D7A6261453745504C64737839555A6558442F70662B6B6E6E65624A3539324B757856324B726F30357346480A63307A48314759596363706E2F4A786C502F534469624D5550456B496A2B4B516A2F706D5267553247664F6B7047527376717746624276497064697273566469727356646972735664697273565A7A2B5764742F765263482F4A5166697A66386135323373316A2B7566384156683938706637317873785A7A6E62754D37465859713746585971374658597137465859713746587A66384138354266387045762F4D4E482F7741536B7A714F7A5037762F4F4C782F613339372F6D6A394C7A504E71365A324B757856324B7578565873643769502F58583965526C795A523568396E2F556266384133326E2F4141497A687549766F76434F35333147332F33326E2F416A48694B3849376E665562662F4148326E2F416A48694B3849376E66556266384133326E2F41414978346976434F35333147332F33326E2F416A48694B3849376E665562662F66616638434D654972776A75643952742F384166616638434D654972776A75643952742F77446661663841416A48694B3849376E66556266'
		||	'2F66616638434D654972776A75643952742F3939702F774978346976434F35556A695349635931436A7251436D416D30675575774A646972735666507638417A6B622F414D6465312F3568762B4E337A704F792F6F5039623944796E6248316A2B722F414C35354C6D3564433746585971374658597139542F3578312F3437382F38417A42762F414D6E49633148616E393250362F3841765A4F3737482F76442F55502B36672B6963356C3635324B757856324B757856324B73572F4E4C2F414A5272555038416A4366316A4D76522F7742354833754472763771583956386D5A3254776A735664697273566469727356665A2B6866377757332F4142686A2F7743496A4F4779665566655830544639492F716853387A7559394B7648587174764B5239434E6877377A483959497A6D6F532F71792B353861353344353437465859713746585971374658306C2F7A6A3962694C793658485753346B592F5145542F6A544F5837534E355038305059646B6973582B635870576170334C735664697273566469727356664C5835316638705A66663838662B544D5764626F50376F6635332B366B3852326C2F66532F7A663841635259526D7764613746585971374658597139752F77436361663841705A2F39472F38417A507A5164712F772F7743642F7658704F78663476387A2F41483732374E43394B37465859716C586D547A52702F6C79324E3571636F69546F6F3673782F6C6A5471782F7A624C735747575531454E47625048434C6B6165452B63667A343150564330476A6A366C6248626B4E3553503966374D662F505034763841697A4F6777646E5268764C31792F32447A476F0A37566E5061483775502B7A655A5433456C77356C6D5A6E6B59315A6D4A4A4A39324F625943746736556B6E63716546447356646972735664697273566469727356646972735664697273566469717659663730522F36362F72794D75544B504D5074584F4566523359712B632F7A3738717470757244566F6C2F7742487652566A3245696A69342F326138582F414F447A702B7A6333464468504F482B35655137567763452B4D66546B2F3362792F4E733656324B757856324B757856324B757856324B757856324B757856636A6C4347556B4D44554564516343732B38702F6E567265686C59726C2F72747350324A6A3851482B524E39762F672F55582F4A7A585A7442444A7939457636502F457531302F615754467366336B6636582F465064504A6E356A615635736A2F414E4366686367566542396E48792F33346E2B556E2B7934357A2B66537977382F702F6E5054366257517A6A302F562F4D2F695A526D4935727356662F3944315469727356646972735664697273566469727356'
		||	'57794C7A557234676A497946696C654835346F374A324B7578564B395A3670394F656E2B786E3035503632502F6676482B30484F482B642F7655747A305A3552324B757856324B757856364E2B546470796E75726B6A374B4967502B7353782F354E6A4E62726A73413944324E44655576644838663656366C6D70656F646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735659422B6355484B78743576355A5376384177536B2F38615A736445665552354F67375A6A3641663658365038416A7279624E7538713746585971374655587073664F59654337357933744E715042306B6831796D4F4C2F546571582B77684A3350592B4C6A7A6A2B68632F782F6E4A336E69623645374658597137465859713746585971374658597137465871486B4B303944544663395A575A2F38416A516638517A307A734846776163482F41465355702F377A2F654F486C4E6C6B57644330757856324B757856324B757856324B757856324B75785638332F38414F51582F41436B532F77444D4E482F784B544F6F374D2F752F77444F4C782F613339372F414A6F2F53387A7A61756D646972735664697273565637442F6569502F58583965526C795A523568397135776A364F3746585971374658597137465859713746585971374658597137465859713746587A372F7A6B622F783137582F414A68762B4E337A704F792F6F503841572F513870327839592F712F3735354C6D3564433746585971374658597139542F774363646638416A767A2F41504D472F77447963687A5564716633592F722F414F396B377673662B380A5039512F377144364A7A6D58726E59713746585971374658597178623830762B556131442F6A4366316A4D76522F336B6665344F752F7570663158795A6E5A50434F7856324B757856324B757856396E36462F764262663859592F774469497A68736E3148336C394578665350366F55504E662F4849766638416D476D2F34673253772F57503630667659352F6F6C2F566C2F755878766E62766E7273566469727356646972735666544835432F386F306E2F47615439656372326A2F656641505A646C6633582B63586F6D61783237735664697273566469727356664C5835316638705A66663838662B544D5764626F50376F6635332B366B3852326C2F66532F7A663841635259526D7764613746585971374658597139752F77436361663841705A2F39472F38417A507A5164712F772F7743642F7658704F78663476387A2F41483732374E43394B3746574E2B665050467035527354643348787A50565959676433622F6A56462F62662F41493234356C6162546E4E4B682F6E53635056'
		||	'61714F6E6A5A352F77782F6E506C7A7A4C356D76764D6432312F714D68655275672F5A55646B6A58396C522F31313857646269785278436F76453573387330754B53565A63304F7856324B757856324B757856324B757856324B757856324B757856324B757856324B7139682F7652482F414B362F72794D75544B504D5074584F4566523359716B336D37797662655A394F6C307936325678565748564848324A4238762B47586B7558344D7878533467342B6F77444E45784C355038782B5872767939657961646672786C6A505873772F5A64442B306A66352F466E5934736F7952346F76435A734D7355754753575A6130757856324B757856324B757856324B757856324B757856324B75785657744C75617A6C5734746E614F614D3156314A4242385177794D6F69516F736F794D545966525035542F414A7372356B413076564345314642384C62415367646144744C2F4D692F36792F774171387A7264463458716A39482B346574304776384147394D76377A2F642F7744486E7075617033542F41502F5239553471374658597137465859713746585971374658597138516E543035475470784A4833485046736B654752486D37494C4D7256324B705A72492B77666E2F41417A307A324C6C2F656A2F4149562F30396552396F4239422F722F414F38537A5053586B6E5971374658597137465872663550572F4854353575377A63662B4256662B6138302B74507141386E712B78342B676E2B6C2B686E756139337A7356646972735664697273566469727356646972735664697158617A7263576C2F56784C3971356E5342422F6C4E2F5256624C63654D7A757634593854540A6B796946582F48495154484B6D35324B757856324B757856324B757856324B75785668333572526339474C6679536F6631722F414D625A6D364D2B76344F6E3757463476383450474D3362787A7356646972735654545234396D6B386473387739737454636F59682F43446C6C2F6E2B69482B356E2F706E7365774D4E43552F77444D2F7742394C2F65706C6E6E4C31547356646972735664697273566469727356646972614B58495652556B30417951466D6772326E543751576C7648626A2F64614B7633445059395069384B4559667A49694C7269624B497A495137465859713746585971374658597137465859713746587A662F414D354266387045762F4D4E482F784B544F6F374D2F752F3834764839726633762B615030764D383272706E5971374658597137465665772F774236492F384158583965526C795A523568397135776A364F3746585971374658597137465859713746585971374658597137465859713746587A372F7A6B622F783137582F6D472F3433664F6B374C2B'
		||	'672F317630504B647366575036762B2B655335755851757856324B757856324B76552F77446E48582F6A767A2F3877622F386E49633148616E393250362F2B396B377673662B3850384155503841756F506F6E4F5A65756469727356646972735664697246767A532F35527255502B4D4A2F574D7939482F655239376736372B366C2F56664A6D646B38493746585971374658597137465832666F582B3846742F78686A2F34694D34624A3952393566524D58306A2B71466E6D4B4C31744E756F76356F4A563239316244694E534839594C6D4677492F6F6E376E786E6E63506E6273566469727356646972735666536E354179682F4C595566735479412F774443742F78746E4C64704439352F6D683748736B33692F77413476534D316275485971374658597137465859712B57767A712F7743557376762B65503841795A697A7264422F64442F4F2F7742314A346A744C2B2B6C2F6D2F37694C434D324472585971374658597137465874332F4F4E502F537A2F414F6A662F6D666D6737562F682F7A763936394A324C2F462F6D66373937646D68656C5572753669733458755A324352524B585A6A304155636D4F536A45794E426A4B51694C5052386C6566504F4D2F6D7655354C2B576F694877776F6632554832522F724E39702F77444B7A73644E67474750435038414F654431576F4F6566456638332B7178334D707848597137465859713746585971715177535475496F564C7532775652556E35415943613570414A32444B4E4E2F4B727A4C714E444659794B703779306A2F354F6C446D4A50575934387A2F7066562F75584E686F4D732B55542F6E656A2F644D6774662B0A6366664D55782F654E6278442F4B6B4A2F77435461506D4D653073592F6E4F5848736E4B65664350696E56702F77413432334C66373158386166366B5A622F69545235524C745564492F61354D65786A316C396E2F534B4738372F6B6E5A2B576445754E5657366C6D6D68394F674B71716E6C496B5A7239707673762F4E6B7450727A6C6D4931562F7159617273794F48475A325A474E6637726865525A756E514F7856324B757856324B7139682F7652482F72722B764979354D6F38772B316334523948646972735659313534386857486D2B323943384843644166536D556645682F3432512F744A2F784676697A4B302B706C684E6A2F4F69346571306B64514B50502B47583831383265636649477165564A7546394857416D69544A756A66542B79332B512F774157645467314D6377322F77424B3864714E4A50416656792F6E667773627A4B634E324B757856324B757856324B757856324B757856324B757856324B7174706453326B715846757853574E6779734F6F493342475249'
		||	'4246466C47526962443667304C7A38327365564A39656834693774726555794C32457361462B6E386A2F432F774471746E4A354E4E775A52412F544B512F306B6939726931666959546B4831786A4C2F5477442F394C315469727356646972735664697273566469727356646972786A56342F54764A302F6C6C636663787A7833567834637378335A4A2F3770324D6553457A455337465575316766437039383943396A4A316B6E48766847582B6C6C2F78393566742B506F696636522F482B7853725055336A48597137465859713746587450355652384E465676357048502F47762F47756154574831765A646C4373582B63575835684F3364697273566469727356646972735664697273566469727356654B2F6E4C356F39487A4870566D682B477A6B6A75482F316D64654E663956492F77446B706D39304F4738636A2F50755032504F646F353679776A2F4144434A2F77437965315A6F6E6F3359713746585971374658597137465859713746574C2F6D596E4C51707A2F4B597A2F77414F6F7A4C30763168316661592F636E2F4E2F77423048682B62313470324B757856324B702F5A52656E4571393656503035344C323171767A4F706E4D66547863456636754C39332F7375486966532B7A3850685959783875492F774366366C664E493742324B757856324B757856324B757856324B7578564F764A31683963314B494556574D2B6F332B7836663850787A63396A3450477A78376F66764A66356E2F482B467279476739597A31527758597137465859713746585971374658597137465859713746587A66384138354266387045762F4D4E482F7741536B7A714F7A50370A762F4F4C782F613339372F6D6A394C7A504E71365A324B757856324B7578565873503936492F774458583965526C795A523568397135776A364F3746585971374658597137465859713746585971374658597137465859713746587A372F774135472F3841485874662B59622F414933664F6B374C2B672F317630504B647366575036762B2B655335755851757856324B757856324B76552F2B6364662B4F2F502F774177622F38414A79484E5232702F646A2B762F765A4F3737482F414C772F31442F756F506F6E4F5A65756469727356646972735664697246767A532F35527255502B4D4A2F574D7939482F655239376736372B366C2F56664A6D646B38493746585971374658597137465832666F582B3846742F78686A2F34694D34624A3952393566524D58306A2B7145584A474A464B4E3059454836636744545952623470754947676B61462F744978552F4D476D6432446537357752527054776F64697273566469727356652B66383434616748734C32787276484D737450396465'
		||	'482F4D6E4F6437556A3667664C682F30762F5354315059302F544B50394C692F30332F534C32444E4939413746585971374658597137465879312B64582F4B5758332F50482F6B7A466E5736442B36482B642F7570504564706633307638332F41484557455A734857757856324B757856324B76627638416E476E2F414B57662F52762F414D7A3830486176385038416E663731365473582B4C2F4D2F77422B39757A517653764D767A2B38776E5474455777694E4A4C325469663952506A6B2F774347394E6639567332765A754C696E78667A503930365874624E77592B456635542F41484D66784638345A3144794473566469727356646972735665752F6C7638416B67327251707165756C6F72642F696A68585A33485A33622F64614E2B797632322F794D3075713751344477772B722B63372F52396D65494F4C4A74482B613973305479787075687036656D5738634170516C562B492F367A2F62662F5A4E6D68795A705A50715045394A69775178625241696D65564E7A735664697243507A712F35524F2B2F35342F38414A364C4D2F5166336F2F7A76397A4A31766158397A4C2F4E2F7742334638745A317A7844735664697273566469717659663730522F7743757636386A4C6B796A7A4437567A68483064324B757856324B71647A61785855625158434C4A45346F7973415152344D7077676B4777786C45534646356635702F49445339514A6D306952724B5537385074786E2F41474A504E5038415974782F794D323248744B55647065762F644F6C7A396B776E764439332F736F764C74662F4A7A7A486F39572B722F5759682B33626E6E2F414D6B2F37332F6B6E6D0A33783637485072772F312F7741634C704D765A32584830342F366E712F34387779614353427A484B705278315668516A36446D6344664A317842477855384B48597137465859713746585971374658597137465859717A3338737465613274645930707A2B3775745075485566356363626E385932662F6763313272783259792F6D35492F374B54744E466C34524F48382F48503841303059762F3950315469727356646972735664697273566469727356646972794C7A564636657033432B4C6B2F663841466E6B2F61736548555448394B2F38415465707A34636B717A564D33597167745757734E66416A4F30396B636E44716950352B4B55667468502F65756737636A65472F3573782F766F704E6E734C77627356646972735664697232373873502B4F48442F414B306E2F456A6D693166316C375473762B35482B642F756D565A694F316469727356646972735664697273566469727356646972735666496E6E37577A724776586C2B707172544549522F4B6E37754D2F3841414975'
		||	'6470707366426A45664A34485635664579536C2F532F77427A394C367A302B3646336252584936536F722F384142446C6E4779464568377545754941393649794C4E324B757856324B757856324B757856324B735A2F4D6E2F4149344E7A2F7A7A2F774354695A6C61583678386639793633744C2B356C2F6D2F77433769384E7A6650454F7856324B7174724636736970346E66355A712B314E562B563038386E574D66522F77414D6E364D662B7A6B356D6A772B4E6C6A447650712F712F564A6B4F6650373665374172735664697273566469727356646972735664697230443874394F394F43533959627948677679587239376638527A76665A7A54384D4A5A542F4836492F315966384148763841634F4C6D50526D57646734377356646972735664697273566469727356646972735664697235762F414F6367762B5569582F6D476A2F346C4A6E55646D6633662B63586A2B317637332F4E4836586D656256307A735664697273566469717659663730522F7743757636386A4C6B796A7A4437567A68483064324B757856324B757856324B757856324B757856324B757856324B757856324B766E332F6E49332F6A7232762F4D4E2F774162766E53646C2F5166363336486C4F3250724839582F66504A63334C6F585971374658597137465871662F4F4F762F48666E2F3567332F354F5135714F3150377366312F39374A3366592F384165482B6F663931423945357A4C317A73566469727356646972735659742B61582F4B4E61682F78685036786D586F2F37795076634858663355763672354D7A736E68485971374658597137465859712B7A39432F336774762B4D4D662F0A45526E445A507150764C364A692B6B6631516A63726258794A2B594F6E666F2F58372B3270514334646750386C7A366966384143766E61616158466A6966364C774F7268775A4A442B6B57505A6B7549374658597137465859717A76386D764E4B36447273596E4E4C6537486F4F543042596A30332F354766442F414B724E6D7631324878496263342B7032665A326677736D2F77424D2F522F784C36687A6B6E746E5971374658597137465859712B57767A712F3553792B2F35342F38414A6D4C4F74304839305038414F2F33556E694F30763736582B622F754973497A594F74646972735664697273566533663834302F394C502F414B4E2F2B5A2B614474582B482F4F2F3372306E59763841462F6D66373937646D68656C6650502F41446B54714A6D316D3374416172426267303847646D3566384B6B65644C3258476F452F7A70504A6473547649422F4E6A2F756E6C4F62683062735664697273566469724D50796E3874522B594E6667743578796769724E49443049546F702F7957'
		||	'6B344B332B546D44724D76683479527A2B6C324767776A4C6B4150306A31532F7A58315A307A6B4875585971374658597137465745666E562F796964392F7A782F3550525A6E36442B39482B642F755A4F7437532F755A6635762B37692B577336353468324B757856324B7578565873503936492F396466313547584A6C486D4832726E43506F37735664697273566469727356646971453144534C50556C3458304555362B45694B772F7743484279635A6D50496D4C58504847663141532F724D57314C386E664C4639556D7A4554654D544D6E2F4141716E302F3841684D793461374C48722F706E436E3264686C30722B717848566638416E4843796B71644E764A596A32457168782F7753656C2F78746D624474535838512F3076346B362F4A324E452F54496A2B7436762B4A5956712F3545655937477067534F365164346E414E50395758302F77446865575A384F3063637566702F724F7479646C5A5938716E2F4146662B504D46314C53627A5335505176345A494A50355A464B6E2F4149624E6843596D4C42346E5754787967616B44482B73684D6D77646972735664697273566469714D3071394E6E4B306F4E4B7854522F386A4933682F77434E38726E486948786A2F735A63545A6A6C776D2F4B582B7969597638412F3954315469727356646972735664697273566469727356646972792F77412F512B6E716A742F4F714E2B48442F6A58504D2B336F634F6F4A2F6E786A4C374F442F654F62694F7A4863353574646971483142655544443666757A6F665A2F4C346572786E2B6449772F3557526C423166616B4F5042496635332B6B50456B4F6536506E447356640A69727356646972327A38726E44614A45422B7937672F384142567A5236763633744F797A2B3548766C39374C4D773361757856324B757856324B757856324B757856324B7578564A764F6572666F6A5272792F426F30554C6C542F6C4563592F2B484B35666768787A41383348314F5477385A6C335266486D64732B6650727A3876627636333566302B55376E367447702B61727750384178484F4C314D61795348394976666153584669696636495A426D4D3562735664697273566469727356646972735659742B5A726C64446E48387A526A2F68314F5A656B2B734F72375450376B2F7743622F756E694762313470324B7578564D7448683361552F495A3578375936756844414F763736663841754D662F4145382F3072316E594F446557512F384C6A2F75706637314E4D3878657664697273566469727356646972735664697273565851784E4D36786F4B73784141397A6B34524D79496A6E4C3071396D3075785777746F37564F6B6167664D2F744836577A3248533442677869412F'
		||	'67482F41456C2F736E58794E6D30566D537864697273566469727356646972735664697273566469727356664E2F2F41446B462F774170457638417A44522F38536B7A714F7A50377638417A69386632742F652F7743615030764D383272706E5971374658597137465665772F336F6A2F31312F586B5A636D55655966617563492B6A757856324B757856324B757856324B757856324B757856324B757856324B757856382B2F3835472F386465312F774359622F6A64383654737636442F41467630504B647366575036762B2B655335755851757856324B757856324B76552F38416E48582F414937382F77447A42763841386E49633148616E393250362F7744765A4F3737482F76442F55502B36672B6963356C3635324B757856324B757856324B73572F4E4C2F6C4774512F34776E39597A4C306639354833754472763771583956386D5A3254776A735664697273566469727356665A2B6866377757332F474750384134694D34624A3952393566524D58306A2B7145626C62612B636638416E494853446161387436423846334372452F355366756D2F34525973366673326434362F6D6C354474624877354F4C2B66482F632B6E2F69586D4F625A307273566469727356646972735666526E35522F6D7246726345656B616F345455597746526D5039384230332F33392F4F76376632312F61343878726447635A346F2F522F75502B4F7658646E36385A4277532F765039332F783536686D70643237465859713746556A383065644E4C3873512B74715577527156574D62794E2F7152396638415A66592F6D624D6A44676C6C4E52482F41424C6A5A395444434C6B6638332B0A4A387565642F4D67387936766361737366704C4D566F684E53417172454B6E333463733633543476436749397A7847717A654E4D7A3563582F4145696B575A446A4F7856324B757856324B7662762B6361662B6C6E2F7742472F77447A507A5164712F772F35332B39656B37462F692F7A50392B39757A517653766D4838385A76553830334B317277534A666C3843762F414D625A316E5A347245506A39377858615A764D6638332F41484C4163324C71335971374658597137465872482F4F4F5958394D335250327671787038756364633033616E30442B742B67753937482F414C772F31503841664239435A7A62316A7356646972735664697243507A712F35524F2B2F774365502F4A364C4D2F5166336F2F7A76384163796462326C2F63792F7A6639334638745A317A7844735664697273566469717659663730522F36362F72794D75544B504D5074584F456652306B3836362B2F6C37534C6A56496B456A774B4346593042717970322F317376302B4C784A694A2F69636255356643'
		||	'675A6A2B46672F6B623839625457702F7165726F746C4B782F6476792F646E2F4143575A763774762B452F3166327468714F7A6A415848312F774336645A706531493544777A394838332B61395436357148654F7856324B757856324B757856324B7578564236746F316E713842746451685365467571754B2F535035572F796C2B4C4A77794742754A3457764A6A6A6B46534845487A482B616E6B4D65554E5345567553316E634B58694A3669686F386248397268342F79737564586F39543430625031522B70347658615838764F68394576702F346C68655A37726E5971374658597137465859712F2F3166564F4B757856324B757856324B757856324B757856324B76502F414D79344F4E78424E2F4D68582F6754582F6A664F4339706364546A4C2B6445782F306B762B726A6C59547377334F506368324B725A45357156506355792F543554696E47592F79636F7A2F414E4A4C696138734F4F4A69663467592F77436D59345251304F66526B5A4351736458796B696A52617953485971374658597139682F4B4F666E704C7033535A68394256477A5336306572345058396B5376475233542F557A664D4633547356646972735664697273566469727356646972735665612F6E2F7166315879384C594865366D524350386C617A482F686F307A61396D77764A663830663864644E3274506878562F506B503841696E7A626E55504876714C386B7276367835577456505749796F662B445A682F77725A79586141724B6668397A32335A6B72776A79347639307A724E65374E324B757856324B757856324B757856324B734D2F4E6D58686F34582B655A462F426D2F34317A4F0A3059396677644E327361786635772F5338617A645048757856324B73677449665269564F2F6635353444327672507A656F6C6B2F68347548482F414D4C6836596638552B6D3648542B42694565763858396558314B3261687A6E5971374658597137465859713746585971374657552F6C2F70503171384E32342F6477436F2F316A396E3776745A3148732F705045792B496670772F394E4A66542F78582B6C61637371465053633946634E324B757856324B757856324B757856324B757856324B757856324B766D2F2F6E494C2F6C496C2F77435961503841346C4A6E55646D66336638416E46342F74622B392F7741306670655A357458544F7856324B757856324B7174724949356B6475697343666F4F524F345445305830312F79764C79762F774174442F384149702F2B616335582B54387664396F657A2F6C5444332F374754762B563565562F77446C6F6638413546502F414D30342F77416E35653737517638414B6D48762F77426A4A332F4B38764B2F2F4C512F2F49702F2B6163'
		||	'663550793933326866355577392F7744735A4F2F35586C35582F774357682F38416B552F2F4144546A2F4A2B58752B304C2F4B6D48762F324D6E6638414B38764B2F7744793050384138696E2F414F6163663550793933326866355577392F3841735A4F2F35586C35582F3561482F3546502F7A546A2F4A2B58752B304C2F4B6D48763841396A4A332F4B38764B2F38417930502F414D696E2F77436163663550793933326866355577392F2B786B372F414A586C35582F3561482F35465038413830342F79666C377674432F797068372F77445979642F79764C79762F774174442F384149702F2B6163663550793933326866355577392F2B786B372F6C65586C6638413561482F414F52542F77444E4F5038414A2B58752B304C2F41437068372F38415979642F79764C79762F7930502F794B662F6D6E482B54387664396F582B564D506638413747544C744231793131327A6A314B775976627938754C454556347359322B46742F744B3259575447635A345A63335959736F7978346F2F5355666C62613746587A372F414D35472F7744485874662B59622F6A64383654737636442F572F513870327839592F712F77432B655335755851757856324B757856324B76552F2B6364662B4F2F502F414D77622F77444A79484E5232702F646A2B762F414C3254752B782F37772F31442F756F506F6E4F5A65756469727356646972735664697246767A532F7743556131442F4149776E39597A4C30663841655239376736372B366C2F56664A6D646B38493746585971374658597137465832666F582B3846742F774159592F384169497A68736E3148336C394578665350366F5275560A74727A54382F504C78314C517866526973746B2F503841324466424A2B5070762F734D32765A7558686E58383930336175486A7838512F7966384175587A646E555048757856324B757856324B75785673476D343634465A2F355A2F4F3358744656594A5857386758744E5573422F6B796A342F7744672B6561374C6F4D655463656A2B71375842326E6B783748316A2B6C2F78544E62582F6E4A4B416A2F41456D7764572F794A51772F345A457A42505A5236532B783255653252316A2F414C4A71362F35795367412F30625433592F35636F582F694B50694F796A316C39694A64736A70482F5A4D52313338392F4D4770417832786A73347A742B3657726638414979546E2F77414A777A4D78396E5934382F582F41466E41793971355A3871682F5665665856334E64794E50637530737247724F354C4D543773322B6249524146423155704752733771575359757856324B757856324B75785637642F774134302F3841537A2F364E2F38416D666D6737562F682F7741372F6576536469'
		||	'2F7866356E2B2F65335A6F5870587A422B654D48702B61626C76392B4A45332F4A4E452F34307A724F7A7A654966482F64504664706973782F7A663979774C4E693674324B757856324B7578566E66354C61374870486D4F48316A786A755661416B39693147543735455263312B767838654D312F44366E5A396D35526A79692F3476522B5038353951357954327A7356646972735664697279333839664F46686261544C6F49666E653348706E67752F4256645A65556E38764C68384B2F612F612B7A6D33374F77534D78502B474C6F2B314E5245514F502B4F566635752F452B6463365A354A324B757856324B7578565873503936492F396466313547584A6C486D4832726E43506F37442F414D33662B5558762F774455582F69615A6D364C2B396A2B4F6A722B3050376D58342F69664B656467384D39423869666E4A71586C6F4C6158566275784777526A3861442F697154772F79472B482B58686D743147686A6C33486F6D375853396F7A77374831772F48307665664B766E2F53504D364136664F444C53706966345A422F734439722F41466B354A2F6C5A7A756254547866555038372B46366E4271345A76705038416D2F784D697A476374324B757856324B757856324B75785634642F7A6B6C6651744A5957596F5A6B4573683851726346582F677A47332F415A76384173714A3952397A7A50624D68635231395478544E383834374658597137465859716D47683665622B6434674B68494A35542F7A7A696B6D2F343079724A4C68482B6445663661516932346F6352722B6A4B582B6B675A502F3176564F4B757856324B757856324B757856324B757856324B73532F0A4D6932353263557736704A543647482F4144617563703752343778526C2F4D6E2F75782F783176776E6435316E6E726C757856324B70466678656E4D7737486637383930396E3954342B6C6766347359384B582F41435339502B3434487A6A745444345761512F6E65763841302F38417835445A304C713359713746585971394E2F4A7136327537592F35446A2F686C622F6A584E587268794C307659302F716A2F566B394C7A5676534F7856324B757856324B757856324B757856324B75785634562F7A6B6A71484B3473624548374353536B66367856462F354E766E51646C52326B666446356A746D6538592B2B54786A4E3638362B696638416E4861373954513534436434726C76755A492F2B4E7557637A32704770672F305872657835586A493770666F4431504E513778324B757856324B757856324B757856324B7650507A6B754F4E726251667A794D332F41696E2F4D7A4E6C6F527553382F327A4C3078486E2F75662B6B6E6C57625A355A324B6F72543450566C466569376E4F'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'61396F74642B563078722B387A66755966352F31792F306E462F6E634C742B79744E34325558394F5031792F7742372F736B387A7739394564697273566469727356646972735664697273566341574E4275546841745872336C72534270566B6B422F764438542F7743736576384177503263395A374E306E35584549667866566B2F72792F346E3658416E4C694B615A733244735664697273566469727356646972735664697273566469727356664E2F2F41446B462F774170457638417A44522F38536B7A714F7A50377638417A69386632742F652F7743615030764D383272706E59713746585971374658597137465859713746585971374658597137465859713746585971374658314C2B537638417969646A2F774139762B543075636A722F774339502B622F414C6D4C322F5A76397A482F41447639334A6D2B5944736E59712B66662B636A662B4F76612F38414D4E2F78752B644A325839422F72666F655537592B736631663938386C7A6375686469727356646972735665702F38414F4F762F414233352F77446D44663841354F5135714F3150377366312F77446579643332502F65482B6F663931423945357A4C317A73566469727356646972735659742B61582F4B4E61682F78685036786D586F2F7743386A373342313339314C2B712B544D374A3452324B757856324B757856324B76732F517639344C622F414977782F774445526E445A507150764C364A692B6B6631516A63726256473973347232435331754635785371794F703771773473507579555A474A734D5A5245685236766B447A5835646D3875366C50706C7839714A714B3338796E654E2F396B750A647068796A4C45534856382F7A3454696D596E2B464B4D7661485971374658597137465859713746585971374658597137465859713746585971374658597137465874332F41446A542F77424C502F6F332F77435A2B614474582B482F4144763936394A324C2F462F6D66373937646D68656C6650762F4F52656C6D485662572F412B476541702F736F32332F414F466C544F6B374C6E63535035702F3354796E62454B6D4A667A6F2F7743352F77436B6E6B75626C304C73566469727356646972594A42714E694D437662504976352B7046456C6C356A566979696775454653522F78636E3275582B576E32763550327330576F374E73336A2F306E2F45765361587461687735503950384138553951302F7A396F4F6F4B4774722B334E657A5342572F344354692F77447775616D576D795235786B37754772787A35536A3830792F5474682F7930772F386A462F726C586879376A386D3378593938666D6B6574666D6635643068535A37324A32483745523952766C534C6C782F3266484C'
		||	'38656B795435442F4145337063624A727357506E49663576722F334C79727A662F7741354133643672573267786D326A4F337253554D6C50386864306A2F354B663550484E7867374E4564352B722B6A2F433650556472536C746A48422F532F6965537A7A79547530737A4635484A4C4D78715354314C4D6575626B43746736456B6E6371654644735664697273566469717659663730522F7743757636386A4C6B796A7A4437567A68483064682F35752F38414B4C332F4150714C2F774154544D3352663373667830646632682F63792F48385435547A7348686E5971756A6B614E67364571796D6F494E434467497451615A2F7743572F77413739663063434B647865776A616B32375539706838662F497A314D313258732F48506C365036763841784C74635061655448736633672F70663855394930542F6E4954527273426452696C7448376D6E714A2F77536676502B535761764A325A4D665352502F5975347864723435665544442F5A522F482B617A545466502B67366C54367266514D5430557546622F674A4F4C2F384C6D4450545A4938784A32554E586A6E796C483570354450484D764F4A67362B4B6D6F2F444D63696E4A4242354C7961626E7067536C477065623949307746727938676970324D6938766F53764D2F646C304D453538684A783536694550716C4566463539356E2F414F6367744E7446614C525932753575676467556A4876385837312F3958696E2B766D7977396D536C3966702F7742303672503274434F30505766394C482F696E684F743631643633647958392B356B6E6C4E53542B437150325658396C633648486A474D634D6554792B584B630A6B754B58314641355931757856324B757856324B765450797538754639483176584A42384357567842483773597938702F324B38502B447A56617A4C3634512F70786C2F736E63364844364A7A502B707968482F532B702F2F583955347137465859713746585971374658597137465859716C486D36302B73365A4F673671764D663745382F345A716531735869616551376F38662F41437239625A6A4E46354A6E6C446E4F7856324B706472454E56575164746A6E6F6E7364724F476373422F6A2F65772F7251394D2F77445452346639493874323967754979442B4830532F3376342F704A566E714C7872735664697273565A682B566C2F3957316859696143644754366637776638517A44316362682F56647632566B346374667A77592F37372F6576614D3062325473566469727356646972735664697273566469727356664E4835395876316A7A4B3856663769474B50377836332F41444E7A71757A6F316A2F72452F3841457647397179764C583832492F77434B2F77423838367A'
		||	'5A756F65342F77444F4E6C31566451746A324D4C6A3666555676314C6D67375648306E2B742B68365873615831442B722F414C3537586D68656B6469727356646972735664697273566469727962383462766E6651572F384176754974394C482F414A737A623649656B6E7A655537596E637750357366384164663841534C414D324C6F5859716E576D51656E48795056742F6F375A34313755612F3878714F416652702F522F79552F7741722F7741522F6D5066646A6162777358456671792B722F4D2F672F34722F4F526D63653731324B757856324B757856324B757856324B7578566C486B50525072743139626B46596F44555637742B7A2F775032762B427A702B776446343254784A6652682F366166772F77436C2B7638413072546C6C517036566E6F7A68757856324B757856324B757856324B757856324B757856324B757856324B766D2F38413579432F35534A662B5961502F69556D6452325A2F642F3578655037572F766638306670655A357458544F7856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B767158386C662B555473662B65332F4A36584F52312F39366638332F63786533374E2F75592F35332B376B7A664D42325473566650762F4F52762F485874662B59622F6A64383654737636442F572F513870327839592F712F3735354C6D3564433746585971374658597139542F414F6364662B4F2F502F7A42762F7963687A5564716633592F722F373254752B782F37772F7742512F774336672B6963356C3635324B757856324B757856324B73572F4E4C2F6C4774512F34776E39597A4C306639354833750A4472763771583956386D5A3254776A735664697273566469727356665A2B6866377757332F4747502F69497A68736E3148336C394578665350366F5275567472735665612F6E562B587A6559624D616E5972797672525438493679523957542F5854376166374E66326C7A613644552B4765452F524C2F41474D6E5464706154785938556672682F736F766D37706E555048745971374658597137465859713746585971374658597137465859713746585971374658597137465874332F4F4E50384130732F2B6A663841356E356F4F3166346638372F414872306E597638582B5A2F7633743261463656352F38416E66356262574E41656546617A575465734B6465494847596638422B382F35353573757A3876426B6F2F782B6E2F695855397034664578324F6550316638552B593836743478324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578565873503936492F774458583965526C795A523568397135776A364F772F38336638416C46'
		||	'372F415031462F77434A706D626F7637325034364F7637512F755A666A2B4A3870353244777A73566469727356646972735662566970444B614562676A41712B57346B6C70366A4D314F6C5354694253535356504368324B757856324B757856324B75785646365670632B713355566A614C7A6E6D59496F397A2F7741616A396F354363784157656A5048417A49694F636E3164592B544962487938336C79334956587433685A3664576B55724A4C394C4E797A6A355A7A4C4A34682F6E63582B6C65366A7068484634592F6D6D502B6D2F69662F51395534713746585971374658597137465859713746585971746C6A5756476A66645742422B52794D6F69514950385376464C713361326D65422F745273565030476D654D35635A78794D542F4141534D66394B374947314C4B6C646971796149536F5550635A6D364C564853355935592F7743546C78663858482F4F6A36576A5559526D6759482B4D4D656453684B6E714E732B673857555A59696366706E45546A2F566B2B585467594578503152394B334C574473566469714B30752B6177756F72744F7354712F77413647744D684F5045434733466B384F516C2F4E4E766F7947565A6B575244565741495069446E4E6B552B6867324C4337416C324B757856324B757856324B757856324B757856386E666D72646657664D312B3533704C772F34414C482F414D615A324F6A4659342B3534545879764C4C332F77433559706D59344C316A2F6E48533634617A6332352F335A6246767056302F77436138302F6167394150394A33765938717945663066306839435A7A54316A735664697273566469727356646972735665460A666D446666573961755748325559526A2F596A69332F443873332B6D6A5541384E3268506A79793876542F70574F5A6B7576567253443170416E6271666C6D6F3757317730574357542B4C3663663841773266306638582F41465975646F644E2B59794350546E502B702B50536E34464E686E675A4A4A73767067466242764970646972735664697273566469727356646971706257306C7A4B734551354F354141397A6C754C47636B68474F3870656B4B5454324852744C545337564C5750666950695069782B303265743650536A5459784166772F562F536E2F41425364664B58456252755A7246324B757856324B757856324B757856324B757856324B757856324B75785638332F38354266387045762F414444522F774445704D366A737A2B372F774134764839726633762B615030764D383272706E59713746585971374658597137465859713746585971374658597137465859713746585971374658314C2B53762F414369646A2F7A322F7743543075636A722F37302F7743622F'
		||	'75597662396D2F334D6638372F64795A766D41374A324B766E332F414A794E2F77434F76612F3877332F473735306E5A6630482B742B683554746A36782F562F774238386C7A6375686469727356646972735665702F3834362F38642B662F414A67332F7743546B4F616A74542B374839662F4148736E64396A2F414E346636682F33554830546E4D76584F7856324B757856324B757856693335706638414B4E61682F774159542B735A6C36502B386A373342313339314C2B712B544D374A3452324B757856324B757856324B76732F517639344C622F6A44482F77415247634E6B2B6F2B38766F6D4C36522F56434E7974746469727356654A2F6D352B543779764A726D6778386933785457366A65766553465231722B33482F736B2F6C7A66614C5856364A2F3573762B4B65623751374F7631342F77444F682F766F76454F6D6239357072465859713746585971374658597137465859716D4F672B583733587270624854596D6C6D62734F6748387A74396C462F7741707371795A59347863746D3346696C6C5044456352562F4E336C755479337155756B7A4F4A4A495248795A5251565A456C4E503841563538636A67792B4C48694858396250555954686D59482B4776384163385354356534377356646972735664697232372F6E476E2F705A2F39472F2F4144507A5164712F772F35332B39656B37462F692F77417A2F66766273304C3072546F484256674370464344304978563872666D68354666796E71625278672F5570367641336750326F6966356F762B4963472F617A72394A7150476A2F536A395477327530766754322B6958306638542F6D734E7A4F646537460A5859713746585971374658597137465859713746556261364E64335672506677786B323173464D736E374B386D574E46722F4D7A50396E4B7A6B4149422B71584A736A6A6C494751487068395343797872646972735664697273565637442F6569502F58583965526C795A523568397135776A364F772F38414E332F6C46372F2F4146462F346D6D5A75692F76592F6A6F362F74442B356C2B50346E796E6E5950444F7856324B757856324B757856324B757856324B757856324B757856324B75785655676765643168685576493543717169704A505141594361334B514C324436512F4B503872783559692F534F6F6748557056705471496C5037432F7744466A663773622F594C2B317A3566573676785477782B6766374E3744732F512B434F4B5839354C2F5950534D316275482F3066564F4B757856324B757856324B757856324B757856324B7578563562353673667175704F3448777A414F502B49742F77414D75655939753450447A6B394D6C5A5039374C2F5A5263334562444838'
		||	'30446137465859716C5772573346684B7651374835353670374A647063634470354831592F58692F34582F48482F4D6C2F735A6630486A4F334E4A7779385563702B6D663966384134386C326567764C757856324B757856375A2B57657366704453556859316B746A365A2B582B362F2B462B482F595A6F395644686C6638414F6530374D7A654A6A72726A39503841784C4C4D773361757856324B757856324B757856324B757856324B766A337A744E36327536684A755131314F5258773574544F313034714566367366756650745362795350394F582B3653584D6878336F48354633586F2B6149492F392F527970397947542F6D586D74375146346A355537587375565A682F5334767566546D636F396F374658597137465859713746585971705856796C724339784A736B616C6A38674F5277675761597A6B49676B2F77414C3578757268726D5635332B314978592F4D6D75644D42517038366C4C694A4A36715746696E4F6C322F70707A50326D2F566E6A337454326A2B597A6546482B37302F384173733338662B6B2B6A2F547664396A6154777366476671792F774454502B482F4145333166365647357862304473566469727356646972735664697273566469725076792F77444C2F704A2B6B70783854696B59505964332F77426C322F796639624F38374137503452343076716C2F64663166352F38416E66376E2B7334755766526D6D646934377356646972735664697273566469727356646972735664697273566469727356664E2F2F4F51582F4B524C2F77417730663841784B544F6F374D2F752F38414F4C782F613339372F6D6A394C7A504E71365A324B750A7856324B757856324B757856324B757856324B757856324B757856324B757856324B75785639532F6B722F77416F6E592F38397638416B394C6E49362F2B395038416D2F376D4C322F5A76397A482F4F2F33636D6235674F7964697235392F7743636A6638416A7232762F4D4E2F78752B644A325839422F72666F655537592B73663166384166504A63334C6F585971374658597137465871662F4F4F762F48666E2F7743594E2F38416B35446D6F37552F75782F582F7742374A3366592F774465482B6F663931423945357A4C317A73566469727356646972735659742B61582F41436A576F66384147452F72475A656A2F76492B397764642F64532F71766B7A4F796545646972735664697273566469723750304C2F6543322F3477782F384145526E445A507150764C364A692B6B6631516A63726258597137465859713839382B2F6B3370336D5574655770467066747558556641352F34746A2F414A762B4C462B4C2B626E6D793032756C6932507267366E56646E527A626A30542F33'
		||	'58395A3454356F2F4C7A57764C5445333975336F6A704D6E78526E2F5A6A37502F414430344E6E51346456444C394A2F7A66346E6D4D2B6A79596671473338372B466A655A5468757856324B757856324B7174766253334D67686752704A474E4171676B6B2B79726B53514E796B524A4E42365A35502F49625539554B7A3677667156743134374756682F71665A6A2F353666462F78586D717A396F7868744831792F324475745032564F65382F774233482F5A7664664C666C5854764C64763955307949524A2B3033566D5038306A2F41476D2F7A34357A2B584E4C4B626B5870384F434F455645552B61667A636D39587A5266745774485666384167555266345A31576946596F2F6A7138623267627A532F48384C44387A5858757856324B757856324B76642F2B636259794C572F6B3747534D6663482F774361733537745537782B4C302F5977326C3777396C7A5276524F78564A764E766C5330383057443664656A5A743063645562396D52666C2F773332637677356A696C7842783952676A6D6A77792F3652664C486D377966666556727732576F4A53745447342B79362F7A4966384169532F61584F75775A34356863586839527035594A634D762B6B6B6A7A49635A324B757856324B757856324B757856324B732F2F4143342F4B613838314F743364637266545164354350696B2F77416D4776384179632B77762B58396E4E627174614D4F7739552F397A2F5764726F39424C507566546A2F414E312F552F3470367A2B614F6A576D6A6553727178734978464247495146482F47614C346A2F4D782F61624E506F38686E6D426C7A39582B356B373358593434394F59780A326A3666393346387A3531547872735664697273566469717659663730522F36362F72794D75544B504D5074584F456652324E666D5270567A71336C2B3873724A50556E6B516356424172526C62397232584D72537A454D674A354F48724D5A79596A475031506B2B3873703747567265366A614B5A44526B634657487A567337474D68495748684A524D545232554D6B7864697273566469727356646972735664697273566469727356646971656556764A6D702B5A3576513079457541614E49646B582F586B2F34312B332F4B75592B625048454C6B663841696E4A7761616559314566482B463945666C392B564668355455584430754E5149336C59624C3472437637502B743974762B467A6D7454724A5A747670682F4E2F77434B6574306D676A67332B716638372F6957635A72335A7578562F394C315469727356646972735664697273566469727356646972735659682B592B6E2B72617833616A654A7148354E2F7741336366384167733550326A302F466A475166354F584366'
		||	'366D542F6A33442F706E49776E656E6E6D65664F553746585971736C6A45716C4736484D7253366D576D79444A4436385A34762B4F2F353330744F62434D7354435830795343654577755562714D39393057736871385179772B6D663841734A6678516C2F56664D7452676C676D59532F682F77426C2F5355387A6E4864697273565A5A2B573276666F765531696B4E49626D6B6265415038417574762B432B482F414765596D7178386366367274657A632F685A4B50303550542F784C327A4E45396F37465859713746585971374658597137465859712B4F504E662F41423137332F6D4A6D2F346D326476682B676631592F632B65352F726C2F576C2F756B7179356F5A522B574E313957387961664A30724F716638482B372F34337A45315976484C2B713575696C57575039622F645072544F4E653864697273566469727356646972735659702B5A6D71665564486B5254523767694966492F452F774477696C6379394C44696E2F566456326E6C344D5248382F305045733372786149737266313541763749334F614C747674456148415A442B386E364D5839662B642F6D6655374C732F53666D4D676A2F424831542F712F7744486B39365A34515465356653514B62774B3746585971374658597137465859713746553838702B586D31653571342F30654F68632B50676E2B797A64396C646E6E56354E2F37714839352F78482B642F7557764A50684431565643414B6F6F4273414D3952416F554842627771374658597137465859713746585971374658597137465859713746585971374658682F357A655174613137573175394D74576D6845434A79444B4E77587150690A5A66484E2F6F645444484370477655387A326C704D6D584A635278446859482F414D71683830663873442F38456E2F4E6562443837692F6E6665367A2B54383338332F63752F355644356F2F3559482F414F43542F6D76483837692F6E666576386E3576357638417558663871683830663873442F7744424A2F7A586A2B6478667A7676582B54383338332F41484C762B56512B615038416C67662F41494A502B6138667A754C2B6439362F79666D2F6D2F376C332F4B6F664E482F414377502F7741456E2F4E65503533462F4F2B396635507A667A663979372F6C55506D6A2F6C67662F676B2F3572782F4F3476353333722F4143666D2F6D2F376C332F4B6F664E482F4C412F2F424A2F7A586A2B6478667A7676582B54383338332F63752F774356512B61502B57422F2B43542F414A72782F4F3476353333722F4A2B622B622F75586638414B6F664E482F4C412F774477536638414E65503533462F4F2B396635507A667A663979372F6C55506D6A2F6C67663841344A502B6138667A75'
		||	'4C2B6439362F79666D2F6D2F774335642F7971487A522F7977502F414D456E2F4E65503533462F4F2B396635507A667A66384163752F355644356F2F774357422F3841676B2F3572782F4F3476353333722F4A2B622B622F75586638716838306638414C412F2F414153663831342F6E6358383737312F6B2F4E2F4E2F334C762B56512B61502B57422F2B43542F6D76483837692F6E66657638414A2B622B622F7558663871683830663873442F38456E2F4E65503533462F4F2B396635507A667A663979372F414A5644356F2F3559482F344A5038416D76483837692F6E666576386E357635762B35642F774171683830663873442F4150424A2F774131342F6E6358383737312F6B2F4E2F4E2F334C36422F4B7A534C72522F4C74705933385A6975492F563549534453736B6A72396D6F2B7979357A6D736D4A3543593874763979487139446A4F50454979326C367639314A6C6559626E4F7856347A2B64336B6657504D4770573978706473303861516357494B6968354D31506A5A63336E5A2B6F686A695249385071656437543073387377596A69394C7A6E2F6C55506D6A2F6C67662F676B2F35727A5A2F6E635838373733556679666D2F6D2F376C332F414371487A522F797750384138456E2F4144586A2B6478667A7676582B54383338332F63752F355644356F2F3559482F414F43542F6D76483837692F6E666576386E3576357638417558663871683830663873442F7744424A2F7A586A2B6478667A7676582B54383338332F41484C762B56512B615038416C67662F41494A502B6138667A754C2B6439362F79666D2F6D2F376C36442B53666B5457644131696136310A5332614346725A6B44466C4E574C784E782B426D2F5A527331327631454D6B41496E693958364A4F31374D307554464D6D513452776637364C32764E43394937465859713746585971374657502F6D42707478716568586C6E5A6F5A4A355969714B4B43707150484D6E5454455A676E6B346D72675A343552483145506E503841355644356F2F3559482F344A502B613836623837692F6E6665386A2F4143666D2F6D2F376C332F4B6F664E482F4C412F2F424A2F7A586A2B6478667A7676582B54383338332F63752F774356512B61502B57422F2B43542F414A72782F4F3476353333722F4A2B622B622F75586638414B6F664E482F4C412F774477536638414E65503533462F4F2B396635507A667A663979372F6C55506D6A2F6C67663841344A502B6138667A754C2B6439362F79666D2F6D2F774335642F7971487A522F7977502F414D456E2F4E65503533462F4F2B396635507A667A6638416376714C535958677334497042523069525350416851446E4A7A4E6B6E7A653178696F67'
		||	'4875525751624859713746585971374658455632505446574C61312B562F6C3357435875624F4E5A442B3346574D3138663358486C2F732B575A6550563549636A2F766E42793648466B35782F77424C3666384163735276762B636464486C4A4E7263334552505A69726766384B6A66384E6D624874535935694A634358593844794D6F70584A2F7A6A55705077616B51506543762F4D35637548617639482F4147582F4142316F505976394C2F592F386562682F7743636134776633756F73792B437742542B4D723444327233522F32582F48556A7359645A6637482F6A796636582B51486C2B304961354D31306534642B4B2F644545622F6838783539705A4479714C6C51374A78523538552F782F525A336F2F6C375439475430744F743434463648676F42502B7333326D2F3257612B6557552F715045375048686A6A326942464D4D71626E59712B4F764E757044553958764C3144564A703547582F41465378346638414335322B47484241447569487A3355543435796C2F4F6B556F79356F646972735664697273566652662F4F504E6E365767797A6E724C637352386C56462F346C7A7A6D4F3035584D442B693964325247735A50664C395431484E533774324B7578564C664D486C797838775772574F705243574937697656542F4F6A6455624C635757574D3346707A5959355277794676422F4F503544616E706A4E506F782B753233586A734A56482B72396D542F5966462F78586E51344F30597A326E364A663746356655646C546876443935482F4147662F414235356E645763316E4959626D4E6F70563671366C53506D7262357452495333447070524D545232550A636B7864697273566469724B2F4C6E3558363972354457317330634A2F33624E384366503476696638413535712B596558563438664D2F774362467A734F68795A6551322F6E53394C324879662B512B6D615379334F7174396575427546497045442F716637742F3266772F38414665615450326A4B6530665150396B3942702B796F5939352F764A6637442F6A7A303945564643494146416F414E67414D314C75674B59722B61656B585773655862757873497A4C6353656C78514543744A493362375642396C577A4D3063784449444C6C763841376B754672735A79596A474F3876542F414C714C352B2F355644356F2F774357422F3841676B2F35727A6F2F7A754C2B643937796E386E357635762B35642F7971487A522F774173442F3841424A2F7A586A2B6478667A7676582B54383338332F63752F355644356F2F3559482F344A502B6138667A754C2B6439362F77416E357635762B35642F7971487A522F7977502F7753663831342F6E6358383737312F6B2F4E2F4E2F334C7638'
		||	'416C55506D6A2F6C67662F676B2F77436138667A754C2B6439362F79666D2F6D2F376C577450796B387A704E4737574C67426C4A2B4A50482F41463845746269726E39374B505A2B5948366639792B707335463764324B705A726E6C6E5464646A394C5537654F64657859626A2F556366476E2B78624C6365575750654A34576E4C68686C46534845383031372F6E4857776E724A704679397533386B67357239446641362F77444A544E726A37556B507148462F735853356578346E3644772F317655382B316A386B664D6D6E564B5172644950326F58422F774345663035502B457A5A5137517879363850395A315754737A4C4470782F315747366870463570722B6E66515351503453495650384177777A4F6A4D53354869646450484B483141782F7249544A7348597137465859713746585971713231724C644F497264476B63394655456E376C794A49484E49695A62426D4F68666B35356A31616A66566A62526E397563384B6638382F37332F6B6E6D466B31324F4858692F712F6A68646A69374F79354F6E442F41462F542F774165656F6557502B6366644D73537332727974655344666750676A2B6D6E37782F2B43582F557A553575303553326A365039303772423254434F387A782F37474C31437A736F4C474A6265316A574B4642525551425648795663314D7047527375376A455246445A57794C4A324B7578562F2F3950315469727356646972735664697273566469727356646972735651327057533331744A6176306B556A354873666F4F59327077444E6A6C412F787834575554527434784E45304C7447346F796B676A334765505469594578504F507064670A747943757856324B6F54554C543131354C3974656E76375A316E733932782B537963452F7744463876312F3758502F4146582F4149762B6A2F56644C32706F507A45654B50384165772B6E2B6E2F512F77434A5358706E74414E3768382B49707243727356624270754D5665362B52504D67317A54316551317549714A4C34312F5A662F5A6A2F4149626C6D6731474C7735655433476731506A77332B7550706E2F78582B63794C4D5A324C73566469727356646972735664697273566648586D2B4D78367A66493356627159483648624F32774734442B7248376E7A335543736B7636387639306C47587443592B584C723670716470636450536E69662F4149466C624B736F754A48394574754758444D48756C48373332586E44766F6A735664697273566469727356646972794C383239582B733336574B4834626461742F725038582F454F47626E5277714E2F774135354C74664E785445522F422F75704D467A4F4A7030664E504C473239434F682B30647A6E68766233616635374E59'
		||	'2F7563666F786637374A2F77416C50397A77506F335A756A2F4C59365039355031542F77434A2F77413145357A727458597137465859713746585971374658597169744D303258557031746F42566D3739674F37484D72533661576F6D49512B71582B782F70496B614676584E4A30754C5337646257486F7655397965374850574E4A70593661416848702F7370667A6E416C4C694E6F7A4D746937465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746574B666D64356F5879376F64786368754D38716D4B45642B62696E49663841474E65556E2B787A4D306D48785A676450716B344F757A2B446A4A2F6950706A2F57664A326469384937465859713746585971374658316A2B56576C6E54664C566A43327A504836702F3536457A663852664F4F316B2B4C49542F6D2F77436C394C3357676877596F6A7934763950366D563568756537465859713746585971684E52306579314E5054766F493530384A454466385347546A4D77354868613534347A326B424C2B737865382F4A337976644573316B714D65364F362F774443712F442F4149584D754F75796A72397A6853374F77792F682F774230686638416C52766C662F6C6E662F6B612F77447A566B2F355179392F3242722F414A4C770A39332B796B7177666B72355669332B70387A2F6C537948384F6648496E583554312B794C49646D3452302F32557631703970586B6E52644A595357566C4246494F6A684157482B7A61722F384E6D505055546E7A4A63724870736350706A454A316C446B757856324B757856324B757856324B757856324B757856324B757856324B757856324B725A596B6C5570496F5A543142465163494E49497449723779426F463853626977747978366B5268542F7741456E46737949366E4A486C4B587A6361576B787935786A386B6C75507955387254476F7443682F795A5A422B484F6D586A583552312B794C6A48733343656E2B796C2B74424E2B516E6C7068514C4D443469542B6F796638414B5754792B54582F414356692F70664E62462B51506C744B38684F2F7A6B2F357056634A3753796630666B67646B347636587A52554835476556347674323779663630722F7744476A4A6B4432686C505837417A485A6545645038415A535461792F4B2F79315A2F33576E776E2F6A49444A2F7964'
		||	'4C35544C56354A6678482F4148502B3563694F68785235526A2F75763930794730734C657A583037574A496B3845554B5075584D61556A4C6D356359435049557235466B374658597137465859713746582F2F3150564F4B757856324B757856324B757856324B757856324B757856324B764E5050384170583157392B736F50336334722F736839722F6D72504F4F33394C3457586A483035762B6D6B66722F77434B637A464B7854474D356C75646972735664697157366C5931724E474E2B342F6A6E6F2F733132377731703878395038416B4D6B762B6D4D762B6E662B6B2F6D764B6472396D332B39786A2F686B663841662F38414666365A4B38394F65506469727356547A7966356B66514C35626A637774384D716A7570372F36796661584B4D2B4C78493035756A314A7754763841682F6A2F414B72336D43644A34316D69495A48415A534F684236484F664972597664526B4A437776774D6E59713746585971374658597137465879522B5A56723957387836676C4B567548662F677A366E2F472B646C7044654F503956344C5778724C4C2B742F756D4E5A6C754732445463646343767457797550724D45632F2B2F4556767646633457516F302B6A784E674657794C4A324B757856324B75785644366866523246764A6454476B63536C6A3947536A48694E4272795445496D522F68664F2B6F58306C2F63535863333235574C4836546E53526A7769672B665A4A6D636A492F78496A5337586D33717430587038383454327037573847483565422F655A6637332B68692F6D2F38414A542F6366316E6F65787446346B76466C394D506F2F70542F77434F6637704E73386E0A65326469727356646972735664697273566469712B3374354C695259596C4C4F786F414F35797A486A4F51694D5278536C79556D6E71766C6679346D6A5155616A58442F62622F6A5266386B5A3668325A32634E4A4466664C4C2B386C2F76492F30663841644F444F66456E57626C72646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469716E6353656C473067334B7154397777675755453048684D662F41446B6A6568675873596976634232422B2B6A6638527A6F54325648764C7934375A6C2F4E487A5A7235652F5058514E557048644D396C4B65306F71746661564F512F3547656E6D426C374F79513565762B71374C4432706A6E7A2F41486639622F696D'
		||	'663264374265786965316B53614939475267796E2F5A4C746D756C4578324F7A7459794568595045725A466B3746585971374658597137465574312F7A48593642624738314B56596F78307231592F796F76326E622F56793348696C6B4E5246744F584E48454C6B65463878666D50352F6E3834582F7245474F7A697173455A37413958662F69795439722F414944396E4F7230756D47474E667866785046367A566E555376384167483052596C6D613444735664697273566469715A2B5774466657395374394E6A72576552554A4859562B4E7639676E4A737179355044695A667A5737446A385359695034692B78346F6C695259347878525141414F7748544F494A74394341725A64675337465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712F77442F3166564F4B757856324B757856324B757856324B757856324B757856324B7054356E3066394B325477715033692F456E2B734F332B792B7A6D7137543066356E45596A36783638663965502F41425830746B4A634A65526B55325058504B484F646756324B757856324B70586636665373735132376A5055505A2F32694571775A7A367670785A66353339444A2F532F6D7A2F692F6939583163663270325656354D664C2B4F482B2B676C756569764B4F7856324B76512F7979383569315961526574534A7A2B36592F73736639312F36722F732F7743562F725A727456677631442F4F6567374D3176442B376C395038482F4576560A633144314C735664697273566469727356646972356B2F5053772B712B5A70704B5546784848495038416766532F346C466E56396E53764550364E76463971513463785038414F416C2F76663841657650733254716E59712B775049747A395A3048543565357459612F4D4971742B4F635671425753512F705366514E4C4B3863542F516A3979655A6A75533746585971374658597138382F4E76582F526754536F6A3855767879552F6C4832462F77426B2F7741582B777A5A6150485A346E6E7531395251474D6678657158395635686257356E63494F6E632B3248745074474F6878484A4C6E394F4F482B715A5035762F46663058536150536E557A45422F6E532F6D7854364E42476F5664674D38487A35355A356E4A4D3855356E696B2B6C597359787845592F5446646D4F324F7856324B757856324B757856324B726F6F6D6C595278677337476741366B354F4D5449304E35465870766C4C7971756B70363977413130342F3445667972372F7A4E6E70505A505A51306F3435373570'
		||	'66394B2F364D663841665363504A6B346D5235304C533746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859716F33332B38386E2B6F3336736C486D786C794C34707A75337A68324B6F7A546458764E4C6B3961786D6B676B2F6D6A5971662B467945344365784845325179536762695448334D3330723839664D6C6A5154535233536A744C474B2F38464636546638466D766E32646A6C793950395632575074544C486D52502B73502B4A34575661662F414D354A4D41426657414A3774484C542F6848542F6D5A6D4A4C7372756C396A6E51375A2F6E522F30705469482F6E497A525350333174644B6638414A434E2B75524D6F505A632B686A3976366E4948624750714A2F37482F696C386E2F4F52656867664262335A507573592F77435A725942325850766A2F73762B4A5365324D6664502F592F38556C39332F7741354932712F377932456A2F363867542F694B79356248736F395A66593079375A48534A2B662F5354474E582F3579443179374253796A68745650526743376A2F5A5366752F2B53575A634F7A49446E636E44796472354A665477772F3258342F30727A7656645A764E586D4E7A71457A7A796E3970324A70374C2F4B50386C6332554D59674B694F463147544A4C49626B654A425A5931757856324B757856324B75785637500A2F7A6A7835554D6B38336D436466676A4268687233592F33726A2F4146552B442F5A766D6937547A5542416631705052646B594C4A79482B72482F41487A33584F66656E64697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F41502F5739553471374658597137465859713746585971374658597137465859713746586D6E6E76512F714E3139616948376D63312B546674442F5A66612F344C504F4F336444344F5478492F7742336C2F324F542B4C2F414533312F77436D637A464B7854474D356C756469727356646972735653363930336E57534C7233486A6E6F505966744B6356597451654C482F426D2F69782F30636E383648394C366F2F31667035667448736A6A39654C367634736638372B722F5353736767304F787A314B4D6849575056475856343067673057736B68324B76'
		||	'576679373839692B56644D314276394958614E7A2B32503557502B2F502B4A2F3633327452716450772B71504A367673375838666F6E39663841444C2B662F7741652F7742307A2F4E633735324B757856324B757856324B7644662B636B4E4B704C59366B6F2B30727773666B66556A2F346E4A6E51646C54324D6638414F655A375A7837786C2F6D76466333727A6A735666566635503350316A79745976344B3666384337702F78726E496134566C5034365063396E797644483866784D787A426467374658597137465550714639465957386C3363486A4845705A6A38736C474A6B6144586B7944484579504B4C352B316A5535745A765A4C75586435573248675032562F774269756232556F6165484649384D4D5934705365456E4B576F79587A6C4D375252396E616933536E3752366E50454F324F314A612F4C78637355505469682F4E6A2F41447636382F3476394C2F432B67614452445451722B4F5831792F48384D55526D6964693746585971374658597137465859717668686564784645437A7361414471546B34514D79497848464B5376532F4B666C4E644B58367863414E644D506D454838712F3558387A5A3652325632534E4B4F4F66717A482F70582F526A2F414576353076784C44795A4F4C6B79544F696158597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658590A713746585971374658597137465859716F33332B38386E2B6F3336736C486D786C794C34707A75337A68324B757856324B757856324B757856324B757856324B757856324B757856324B7578564D664C2B68584F753330576D326138705A6D6F5041443970322F795558346D79724C6B474F4A6B656A626878484C49526A2F452B75764C75685161445951365A616A3931416F5776636E71376E2F4B647669624F4D7935446B6B5A482B4A37374469474B49695034557879707564697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F396631546972735664697273566469727356646972735664697273566469727356516572615A4871647339724C305962487750374C5A6961765452314F4D3435667866374758384D6D555A5562655158396A4C597A506254696A6F61482B763035354C6E'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'7753777A4D4A6656467A776233554D7830757856324B757856324B6F573773557542586F2F6A2F41467A7065794F3363756750442F65595039532F6D2F38414376356E2B356C2F736E55363773324770332B6A4A2F502F414F4C5369653365413858465066746E722B68375278613250466950462F4F6A2F6C4966313466695038313458553657656E4E5448782F686C2F565573324C694E717855686C4E434E775269723166794C2B5971336758543956594C5030535539482F7958384A50387239762F572B31714E52707548315265713048615048364D6E3166777A2F6E663176365430444E633739324B757856324B757856672F357A364564573875584251566B74694C686639682F656638414A4A704D32476779634751663076542B503835316E61574C784D522F6F65763866357235627A7258695859712B6C2F79467550563874496E2B2B3570462F45502F7741623579766149724A3841396C32556278663578656935724862757856324B75785635582B616E6D6E367A4B4E48746D72484761796B64322F5A542F5966746635662B706D32306D4C68484766784635667454566352384B5054362F363338333866784D55302B79394563332B3266777A792F77426F6533507A6B7643786E2F423466394C702F7741372B70482B442F542F414D336833665A665A3367446A6E2F65792F3656782F34722B636A633478333773566469727356646972735664697149734E506D76355242624B58647677397A34444D6A427035353563454278535154584E36643561387177364F6E4E71506373506966772F7955397638416957656C646D396C523067732B764E2F465038413373500A78366E446E5069547A4E32314F7856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B714E392F76504A2F714E2B724A5235735A63692B4B6337743834646972735664697273566469727356646972735664697273566469727356646971745A326331374D6C7462495A4A70434656564653536577794D70434973736F784D6A513576707238712F793154796A624765366F2B70546A39347733434C313946442F414D54623974763956633558576176786A512B695034346E7339426F7641466E2B386C2F7366364C504D317A744859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859'
		||	'7137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746582F2F3050564F4B757856324B757856324B757856324B757856324B757856324B757856324B73623835655776307044395967482B6B786A622F4B48386E7A2F6C7A6E6532657A667A4D654F483939442F705A442B5A2F7844646A6E77764D5343706F64694D383149707A4859466469727356646972735657795272494F4C696F7A49302B6F6E703563654D6E484D6678526173754B4F55634D687852537935306F7238554F34384F2B656D646C2B316B636E6F3148377566384171736637755839655038482B342F715049367A735355665669396366356E38662B622F4F2F48314A6551564E447363373645784D63555478526C2F464836586D5A524D545232617962466E2F414A4D2F4D7837486A5A3673544A4230575871792F7743742F4F6E2F41412F2B746D757A365869336A7A64396F75307A4430354E342F7A2F414F4B502F4650566261356A7559316D675950473471724B61676A4E5351527358715979456859334370675A4F7856324B724A34556E6A614755636B6346574237673745595161335152596F766A7A7A586F4D6D67617063615A4A58397A4951705064543855622F414F7954693264746879654A45532F6E506E32664563557A452F7770546C7A512B68502B6363726A6C6F3931422F4C636C763841676B6A482F4D764F6137554872422F6F2F7065733748506F492F702F373050574D3037765859713746574C2B66504E713644612B6E4361336B77496A48386F3779483566732F35582B797A4B302B486A4E6E365975730A312B7238434E442B386E39503841785479617873694436383153353333392B352F797334623268376638653847452F757638706B2F31582B68442F61762B6D6E395436337376737A772F3375542B382F686A2F4D2F70532F702F376E2B736A3834463656324B757856324B757856324B7578564F4E413873584F735056427768422B4B513950396A2F4D32626651646D5A4E576476546A2F69796638542F4144704D4A7A455870656A364A6261544636567375352B30782B30782F77416F3536526F39466A30736547412F72532F6A6D34557047584E48356E4D58597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859716F33332B38386E2B6F'
		||	'3336736C486D786C794C34707A75337A68324B757856324B757856324B757856324B757856324B757856324B7578566B486C50794C716E6D6D5830394F694A6A426F38726252722F72502F7871764A387873326F6A694871502B622F4535576E3073383571492F7A763458305A35422F4C4C542F4B45664F4D6574664D4B504F77332F3159312F33576E2F444E2B303263787164584C4D6536483831362F53614B4F6E483836663841502F346C6D47595473485971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712F77442F3066564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856686E6E4C7967626A6C66324B2F764F726F50327638414C582F4B2F6D2F6D2F7742623758483973396B654A65584550582F6C4D663841502F70782F702F7A763533396236736A486B725973417A67334B646756324B757856324B757856324B714D3972484F506A472F6A337A62614474584E6F6A654F58702F314F587178532F7A66393948686B3457703057505544316A2F414476343074754E4B6B54655034682B4F656B396E2B3165484E3663762B443550394E682F77424E2F422F6E2F77436E655331585975544876443937482F705A2F7741652F7741332F536F4967716148593532634A6959346F6E696966346F2F53364355544530646B35387565626237514A4B327A636F6966696A6264542F7A53332B55755635634D636E4E79744E71350A34443666702F6D2F77414C313379313535734E6441534E7653754F38546E662F594839762F69582B546D6E793665575033643731756D31304D2B77394D2F356B7678366D51356A4F776469727356654D6638414F516E6C4431596F764D4E7576785230696E702F4B542B366B2F324C66752F396D6D627A737A505234442F57693837327670374179442B72502F657643733646356837702F7741343254386F6452682F6C6146762B4345672F77434E4D352F74556278503962394430335978326B5036762B2B65305A6F6E6F3359716C586D547A48426F5673626962346E62614E42315A764435667A4E6B345276636E686A483670532B6D4D584731476359526631535030512F696E4A342F63537A366A637671462B6555376D744F796A73712F3675634E3231322F34773844542B6E422F486B2F697A2F774456762F642F3166537730585A353476467A65724B66706A2F44692F34392F75562B63513735324B757856324B757856324B72344C655334635251715864756755564F5759386373'
		||	'6834596A696C2F4E69704E4D3438762F6C2B467050716535366949482F6962663841477135326E5A2F732F58717A2F77444B722F71704C2F65782F77424D34303876637A574F4E596C4352674B7169674146414D374F4D5245554E673479374A4B37465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971736D6A3956476A4F77594566666842704246764264562F3578793147496B36646478544C34534B305A2F7743463956662B493530554F31496E3667522F7376384169586C736E593868394A45763633702F3470695770666C44356D734B6C374A7046486549713966396968352F384C6D5A445734706466384154656C774A396E35592F772F3658314D5A767449766450504738676C6750536B694D762F41424D444D754D784C6B524A77355935512B6F4750395A42354E7264697273566469727356646972735652566A7064337144656E5A7779547634526F57503349446B4A5445655A34576359536E39494D7636724E4E452F4A487A487164476B6857316A5037557A55502F497465636E2F414153726D446B375178773638583956324F4C737A4C506D4F442B75394E3873666B44704F6E4554616F3758736F2F5A2B78482F414D417678742F736E342F354761724E326C4F573066522F756E64594F795951336E2B380A2F77426A46365A61326B4E7045734673697852494B4B6941425150386C567A556D526B624C755978455251325663444A324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F53395534713746585971374658597137465859713746585971374658597137465859713746585971772F7741312B5368646C727977464A6A7579646D393138482F414F4A5A79506176597669336B7866336E3865502F5650367639502F4148546B59386C624635394A473062464842566761454859673577556F6D4A6F38334B61794B757856324B757856324B757856324B71637476484D4B4F4163324F6B37517A615133696C4B4839482B442F4F684C304F4C6E3075504F4B6D424C2F64663662366B424E6F2F654A766F4F64316F766248706E6A2F7955772F3841564F662F4142662B59'
		||	'3833714F7765754D2F3575542F692F2B4F6F4B53336C674E5742464F342F726E626154745442712F7743376E47522F6D66546B2F774356632F55382F6D30655842395554482B6C2F442F706D582B58667A5176744F704466663654414E716B2F4750396E2B332F414C502F4149504C73756B6A4C63656C7A4E4E32705048744C3935482F5A7653744338333664725941745A514A442F75742F68662F676632763968797A575A4D4D6F6333704D4773783576704F2F38414E6C395363355135694831485434645274354C4F365550444D705231506345554F536A49784E6A6F776E415442423553664A586E66796A63655664536B30366570516646452F38414F682B792F774478712F38416C3532576E7A444E4869482B63384871644F63457A452F3576394B4C306638413578746C706336684833614F49302B52662F6D724E5A32714E6F2F4633485978336B50367233624F65656E5372582F4D64766F30584F583470574877526737742F774130722F6C356A366A55773038654C496543502B796C2F5268482B4B58346B774A504944696C2F4E2F34722B62463556716D6F7A3670636D38757A796B4F79676446483869442F506C6E6E6E6166624D395836492F7539503841366E2F502F7035663533395836492F374A767761555150484C3135663533384D50364F503863556B506E4F756337465859713746585971756A6A61526769417378364143704F536A45794E446371796E5276792F7572716B6C3666516A384F726E36503266396C2F774F64506F2B774D6D58664A2B366A2F41446638702F787A2F4F2F3072544C4B42795A7A70576957756C70777455436B39574F374835740A6E6236585259394D4B674B2F706678792F7A6E466C4979356F374D316937465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746576D554D4372436F4F784278564C4C76797070463558367A5A57386850646F6B4A2F4663756A6D6E486B5A664E6F6C67684C6E47502B6C4355584835566557626A3764684550384156354C2F414D6D32584C68724D6F2F694C516442695038414345766B2F4A44797135717471792B776C6B2F343264737348614758762B794C53657A4D50642F737066725137666B4E355A4A4A45636F48674A546B2F774355636E6C386D48386C5976502F4145792B483869764C455A71'
		||	'30456B6E2B744B332F4768544165306370362F5979485A654564442F414B596F3648386E664B304A71746970372F464A49332F453547797336374B65762B35624232646848385032792F576D746E354530477A6F594C4332556A6F544570502F41415441746C4D74526B6C7A6C4C357438644C6A6A796A482F53703346456B5368493143714F67416F426C424E7553425337416C324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B762F2F543955347137465859713746585971374658597137465859713746585971374658597137465859713746556B387765564C6257427A50377563445A77502B4A6A39724E4C326832566A315976364D763841716E2F462F77413573686B4D586E4F7361426436532F47355434543063627166702F726E6E7573304754536D706A62704F50305363794D784C6B6C3261356B37465859713746585971374658597137465859565138746A444A3155412B49327A656158747A566162614D35536A2F4D796676592F3750366638336864646D374E77356563522F576836503841636F5639496F6555546B45644B2F317A71744E375A486C6C686638415378482F414B647A34763841706F36584C32414F634A6636662F696F2F774445702F70506E54584E4B6F6859584D512F5A6B332B3539704D3357507433525A2B5A4F4758394F4A6A2F754F50482F736D754F485634503841626F2B2F692F346E497A4454507A0A54735A714C66787957722B4A425A662B435563763841684D7A346347582B366E6A7A66314A78347676636D4F76722B386A50442F57696546336E66797670766E2F546A48617A52746452566147525742346E2B53546A385870762B312F77575A6D6E7A53303874783666346B366A46445678394A6A7844365A4D442F497253376A513957314B32314A44424A424567666C734238577835665A347431567632737A65314D30546A457248422F4F64623256696C444A4B4A4871415A39723335677878417736614F62395055492B456636712F7466384145663841577A7A66572B30454D66707866764A2F7A2F38414A2F3841482F3841632F306E7134346965657A424C6D356B755A444E4F7865527572486335772B6F314D3838754B5A3435666A366635726B786749386C504D5A6D37465859713746557973504C6C2F66304D454C46542B305278482F4141545A7373485A326250394D5A6631706569482B6D6B774D774754365A2B573352372B582F59522F77444E626638414E4F644C70765A'
		||	'76726C6C2F6D592F2B4C6C2F78482B6330797A647A4C4E4F3061303035654E724771654A366B2F4E6A385764567039486A3034724845522F33662B6E2B706F4D6965614E7A4D59757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7638412F395431546972735664697273566469727356646972735664697273566469727356646972735664697273566469713257464A6C4D6371686B505545564279453443597151346F2F306C596C7248356477546B795744656933387262722F7A55762F445A797573396E6F543378487735667A4A6572482F78555038415A4F52484E584E687570655862375453667245524344396F62722F77512F34327A6B4E5432646D302F77426354772F7A342B71482B6D63694D7755757A584D6E597137465859713746585971374658597137465859717232656E3346363343326A61512F350A4972392B5A4748547A7A476F43552F366F5153427A5A4E70583563334D6A435737595155336F75372F655068582F6773363352396A616A2B4F6373456635734A486A2F414E6965442F644F4A4D774F394358775A59664B566A4A48366334655537565A33597361644E36397135305A374D7879687754343873522F716D536376562F70754668783062435858483563324437785049682B59492F45562F34624E586B396E634D76704D34664B583650393832444D55424A2B57512F3358632F51552F35757A436C374D39302F7744596638665A654E354B662F4B7335612F37304C542F4146442F414D315A582F6F616C2F50482B6C2F34386E786C5748387368316C75612B79702F486C6C73505A6E2B64502F414573502B5049386279544B322F4C33546F743550556C2F316D6F502B453435734D587339676A7A34386E3961582F45634C4135696E466E6F646C5A6232384B4B523370552F3841424834733347485134735030526A483465722F546655316D524B4F7A4E59757856324B757856'
		||	'324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F5639553471374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971377269715533336C58547232706C68554D66326B2B452F384C312F32576172503256677A665645582F4F682B372F33502B2B62426B495347372F4C5346743761646C396E41623856345A6F38767331452F524B55663634342F3841633844594D33656C56782B58576F522F3362527944324A422F7743474761724A374F356F386A4366782F346F4E677A42417965537457542F41485258354D702F34327A446C324C71592F772F374B482F4142544C78416F2F345631502F6C6E663773702F6B7255667A4A4A38514F2F777271662F41437A766A2F4A576F2F6D5358784172782B53645766384133525165374B502B4E73756A324C715A0A66772F374B482F4649385149324438757451662B38614E42376B6B2F384B755A6B505A33504C6D59512B4A2F3373574A7A424D37583874497851334D3550694555442F686D356638527A5A34765A715038637A2F414A6B65482F5A53347638416373446D376B37732F4A6D6D57744349765559643544792F345837482F433575635059326E78667738663841777A312F374836503969314849536E4D6353524C776A415652304146426D346A45524644307461374A4B3746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658'
		||	'5971374658597137465859713746585971374658597137465859716C486D487A6470586C31412B715843513146517033592F367361386E622F67637678594A5A50704675506D31454D583148685954636638414F51766C364A754B5233556F2F6D574E616638414A5352472F7743467A4F485A6D512F7A66783848576E7466455035352B482F486B566F503534364C725635467031764663724C4F345265614A53703865457235444A32664F414D69592B6E38647A5A69375478354A4349452F5637762B4B6568357258624F7856324B757856324B7578564C504D666D4F7A387657626168714C3849554947777153536142565875637478596A6B504446707A5A6F346F38557554446C2F506E793053427A6D4666474D356E6679646B38766D36372B566358394C3550524D316A74335971374658597137465859713746585971374658597137465570387A2B614C4C793161665839524A57486B452B45564E543032793744684F55384D576A506E6A686A7853354D522F774356396557763535762B525A7A4E2F6B374A35664E312F77444B754C2B6C386E663872363874667A7A6638697A6A2F4A3254792B612F7972692F70664A75503839764C6B6A42456159737841413949376B344432646B486438306A745445663533796568357258624F7856324B757856324B6F4C567461737448684E31714D7951524439707A537038462F6D622F4143567979474F557A5552784E65544C48474C6B6546676C392B662F414A63746E347866574C67667A527867442F6B73385466686D776A32626B50383250782F346E6964584C7462454F58464C2B71502B4B34554F6E2F4F52486C396D414D0A4E326F50636F6C50776D4F532F6B7A4A33782B332F41496C674F313858645035522F77434B656E525036696877434F51426F65752F6A6D714F7A756762585945757856324B7578566A486D333878744A38717978322B7073346B6C55736F526557775048664D7644705A356863584331477368674E53367363622F6E49487936435142634833394D663831356C6679626B2F6F2F4E772F3557786630766C2B315774507A35387454747764356F52347647616638414A4D795A47585A325164782B4C4B506175492F7A6F2F426E4F6C3676616174414C71776C536546756A49616A35657A66354F612B6344413149634C733865534F5158453851526551624859712F77442F3176564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B75785632'
		||	'4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B73552F4D767A71504B576C4E6552674E63794830345650546B52586D332B544776786638436E37575A6D6B302F6A54722B482B4A774E627166416866384146394D587A505A32657165623954394E4F64316658427157592F657A4E2B7769442F676673726E56536C4844482B62434C7873597A3145362B75636E71656E2F41504F4E7A7447477672384C4B65717878386750396D3770792F3442633145753164396F2F61377548593233716C2F70516D2F6B37386A70504C6D7451616F31306C7842427950456F556170566B58626C4976776C75583273707A396F444C417872684D6E49302F5A687735424B2B4B4D664C68657335706E664F7856324B757856324B75785638362F6E78357A2F53756F6A52375A7132316B666A703061552F612F35464439332F7265706E54646E594F43504566716E2F75486B65316454787A3442394F502F4148662F41423135646D3364492B78664B576F667048534C4F3772557932386248356C52792F34624F497A52345A6B6630692B6861656648434A3734684E737062335971374658597137465859713746585971374658597138642F357951314C685A325667440A2F6553764B522F714C77482F4A374E3332564463792F7A66782F70586E75325A2B6D4D6650692F77424C2F77424A504D5049663564336E6E4E70317335493468626843786B722B3379343034687635477A62616E564442562F784F6C30756A6C714C346148442F4F5A662F7742433561762F414D7456742F772F2F4E4759583871513770665937442B5235393866396B6D506C3338674E51734E527472793775494868686C53526C586C556854793437714F75565A65306F796951424C634E7548736D555A416B78714A34757233484E41394D37465859713746557538786135446F576E7A366E632F3363434669504539455165377678544C63574D354A43492F6961633255596F6D522F68664B486D487A4871586D2F5550724630576C6D6B626A46477453467166686969542F414435667466466E59597355634D61487865467A5A703669566E636E36592F37324C3058512F38416E48533875496C6C31533757326369706A52505549396D666B69387639586E2F414B32617A4A326F416169'
		||	'4F4C2F59753378646A794975523466365031492F2F414B467A61337549705962315A596C6B51756A786C54784248506979744A567550326668584B2F35557345456661322F79505242457233376E746D61463652324B757856324B7578563830666E7A715831767A4938494E5262525278666550572F77435A75645632644373642F7741346B2F37332F65764739717A347374667A51492F37372F664B766B48386C35504E656E445647757862497A73717236584D6E6A747972366B666649366E582B444C6872692B503745365473303534385638502B62786670576564507953314C7935617671454D7133647448764A785571366A2B66683866772F7A556634663958446737516A6C50435277535271657A4A34527841386355682F4C727A6E50355731534B3452794C57526C53644B2F43554A6F57702F4E483974472F34315A73794E566747574E66786677754C6F3953634577663466342F3672367A7A6A6E764859712F2F58395534713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658590A7137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971384F2F3579546B66314E4F54663036544832722B367A66396C667866357636586D65325476482F41447639366C502F41446A7A663274767245384535437A7A77385969653944796442377350692F3247586470784A67434F515071614F794A6754495031536A365830506E4E5057757856324B757856324B757856324B73592F4D667A65766C6252356231535072442F7534416537734E6A386B2F76472F316379394C673861594838503858395677745A715041675A66786654442B732B612F4A506C75587A58724D4E6753534A47357A50334344347057722F4D3332562F79327A7164526C474742502B6C654F3032453538676A2F7076367638534D2F4E66545530337A4A6557304B684977554B676441475247322B2F4B3948506978676E3862746D7668775A53423566376C37722B53656F6658504C4673704E57684D6B522B6869792F384936'
		||	'357A2B766A77355435303950325A5069776A2B6A6357645A72335A757856324B757856324B757856324B757856324B75785638352F383543616A395931364F3148326265425166395A6930682F3458686E54396D5272486638414F6B386832764F386C667A5973332F3578323037304E476E7644316E6E49482B716972542F686D664D447453567A412F6D78646E325043735A5038414F6C2F755871756164336A7356646972735664697273566563666E36377235624953764670347733792B492F38533435744F7A66377A2F4E4C702B316A2B362F7A6738562F4B792F7462447A4A5A58463651495135465430444D724A47782B556A4C2F784C4E3772496D574D67504F6147596A6C695A636E316A6E485064757856324B757856324B757856324B766A2F414D38366A2B6B746376727174566565546966386B48696E2F434B7564727034384D4150364C352F7170386553522F7046394F666C76706E364E387532467352512B69726B65426B2F664E2F77306D6370717038575352382F7744632B6C37545277344D55522F522F774231366B623577756F625852373261347036533238745165395649342F374C374F5177416D59412F6E42733145684848496E2B6158782F61327A33557157385171386A42564875547847646F545174382F694F49304832736F6F414F7450484F456653473856662F2F513955347137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658590A713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971777A38316649783832365836567651586C75544A445875616648465874366E2F453154396E4D3752366A775A622F544C366E58612F532B504368396364342F38532B594A59627253376B70494867756F473647717372443856595A3167496D5035305A50464547422F6D796939702F4C6E3839424D5530337A495172476970633941662B4D342F5A2F3479723850382F483765614C56646E563673662B6B2F346C36505239715836636E2F4143732F347638413470375343'
		||	'434B6A63484E453947374658597137465859713746587A482B63336E503841784471375738445673374F7361554F7A4E2F7532542F677667582F49544F7230474477345766716D3858326C7166466E512B6948702F347154302F38692F4A6E3648307A394B33433075723441696F3357496633592F353666336E2F41434C2F414A633150614F666A6C776A365966377033585A656D384F484766717966376A38657067582F4F51326E2B68726B563042384D39757466395A575A542F77414A3665624873795677492F6D79645832764373675038364C4B2F77446E484455505530363873712F3355797966386A46342F77444D6E4D5074534E534238763841632F384153546E646A54754D6F3930754C2F546639497658383072304473566469727356646972735664697273566469727356664A48356C616C2B6B664D562F63413148724D675074482B3558384938374C53773463635235663772315042613266486C6B6636582B35394B5A2B57767A67316A79375978365A597242364D58496775684C486B7863386A7A582B624B737568686C6C7848696273506145384D654750445154542F414B47433878667932332F497476384171706C58386D592F36587A622F77435673763841522B583758736E35596559372F774178364D7570366B45456B6B6A6865433048465477376C763231664E4871385563552B474C304F687A537A592B4B544C4D7733506469727356646971552B612F4C73506D4C544A394C6E4E466D5767622B56683855622F77437863444C734F5534704351364E4766434D3044452F78506B377A4A356176664C6C343968714B464A463648396C6832654E76326B0A622F727234733748466C6A6C48464634544E686C686C77795A2F77446C312B64747A6F77545439613558466B4B4B736E57534D66387A59312F344E66326632557A586172733854395550544C2F41474D6E613650744D342F545031512F6E6678522F77434B66514E6866776168416C33614F4A594A514752314E51516335755554453058716F5445785933425638697A646972735664697143317A5542707468635878365152504A2F774B6C73737878347041667A6931355A3845544C2B61444A3862573643655A556B62694859426D506170335935323532443534425A3366564D33356D2B574E4F67482B6E516C455769724753356F42734F4D59624F51476B7979504976634857345944366F2F357671654D2F6D6A2B626A2B61562F52756E7130576E6867574C66616B492B7A79412B79693956542F5A4E2F4B753830656938483153336E2F75586E64643268342F706A3663662B37523335472F6C2F4C714E366D763369466253324E59712F37736B4851722F6B5266613566373834722F'
		||	'41443544744455694D654166564C3676364D662B504E765A656B4D356549666F683950394B582F4858304C6E4E50574F78562F2F3066564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856696E6E6E3874394E3833516E3677767058616969546F50694867722F77432F492F38414A622F594D6D5A6D6E3155734A322B6E2B61344F7130634D3433326C2F50664C2F6D4451726A51623662544C77556D67626961644350744B792F354C72526C7A724D57515A4969512F69654A7A596A696B596E6E4639442F414A462B594A7457304152584A4C50615347454D65705369756E2F41382B482B7171357A58614F4D51795750342F55396232586C4F5448522F67504339457A574F33646972735664697243507A6438352F774347744863514E78764C717355564F6F722F41486B762F504E662B536A4A6D666F7348697A332B6D50716B360A7A7444552B44446236352B6D502F4142543579386F32746863366E416D7279694779567555724775366A66307877444E2B382B786E54357A495250434C6C2F43386A7034784D78786E68682F452B6B302F4E767971674372665268514B4142486F422F7741426E4C2F6B737664397A3250386F596635332B362F5538762F4144793830364E3569697335644B75566E6C686152574144413857436D7678717664502B477A62646E345A3469524956644F6B37557A34387769594869346257663834366168365772334E6F545154572F49664E47582F6A575238653149334148756B6A73656454492F6E522F7742792B684D35743678324B757856324B757856324B757856324B757856513143385779747062702F73776F7A6E354B4F57536A4869494865776E4C684250383138592F764C32662B61575A2F765A6A2F584F35326950632B643779503841576655635035502B574552556179526D41414C466E33506A39764F534F7579392F77427A3277374F776A2B482F644C762B565265562F38'
		||	'416C67542F41494A2F2B61384835334C2F41447675542F4A2B482B622F414C706B756B3654613654624A59324D59697434363855466143703548722F6C4E6D4C4F5A6D62504E7A4D654D597877783269693867324F7856324B757856324B7054356B38726166356B746A5A366E454A452F5A50526C503830623956622F4144624C735761574933466F7A5949356855672B5A507A4638685465547238577A4E3674744B43304D6C4B56412B306A66356166746637467632754F64587064534D38622F692F69654C316D6B4F6E6C584F4A2B6D5430502F6E485058356E4E316F30684C51716F6E6A722B7961384A422F73716F332F42667A5A724F314D59326E2F6D75323748796E65482B6539757A517653757856324B75785668583579616A39523873585A426F306F574966374A6C4466386B2B655A2B686A785A522F706E57396F7A34634A382F532B61764C336C2B3738775869616470366835334445416B41664343352B492F4C4F707935526A48464C6B3864687779797934592F557A47322F49667A4E4B3456346F6F682F4D3071302F354A38322F34584D45396F3468332F4A3241374B796E6F422F6E4D3938712F77444F506C6C5A4F7478726333317068512B6B674B78312F77417076747966386B38313262744F55746F44682F7066784F3077646B526A764D386639482B46367A42424862787244436F534E414656564641414F67417A546B337558664141436776774A6469722F394C31546972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469720A7356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273565779797045706B6B594B6969704A4E41414F354F45433045317A664B50356F2B596F504D477633463761486C622F41416F6A667A424146352F374A713866386E4F773065493438594235764336374D4D7551794830766150794530615377387638413169594547376C615651663551466A582F6775444E2F71356F753070695753682F434F46365073724759347250385A347639'
		||	'3639497A5675345938667A433041585831443639423639654E4F5731663566552F752B582B54797A4A2F4B354B34714E4F4A2B627833773855654A6B4F597A6C744D7755466D4E414E7954697235532F4E447A69664E4F735358455A7261772F756F50395548376638417A3062342F77445634722B7A6E5961544234554B2F6950716B384C72745234387952394D6654443866306B36306E38686465314B306976566B746F6C6D554F456B5A7777423663777354676638466C452B3063635352367476642F78546B342B79736B3469587048462F4F34762B4A52662F5175757638412B2F37502F6735502B714F512F6C544833542F32502F464D2F774352386E664435792F34684B664E50354D36763561302B545662755733654749714745624F572B4A68475074784976326D2F6D79374472345A5A63493476732F57305A2B7A5A3459385A4D614838322F384169554E2B54756F6655764D396D784E466B4C524833357179722F772F484A61365046694C44733666446D6A2F414B5639555A794C33436C64336B4E6C453178644F73554B43724F35415544335A736C474A6B6144475568455764676C4F6965643947317955322B6E5863633079373841614567643156755049663675585A4E5050474C6B4B614D577078354455534A4A336D4F354C735664697273566469727356596A2B625770666F2F797A6653566F306B59694876366845522F34566D7A4E30554F4C4950384154663656312B766E7759706636582F54656C3838666C6E7076365238783245464B67544C49666C482B2B502F4143627A70645850687879506C2F757653386E6F6F636557492F70582F7066552B7463340A313778324B757856324B73656C2F4D4C5149726F32456C39434A7761454674676635544A2F643876386E6C6D534E4C6B4934714E4F4964586A4234654B50457948726D4D3562735664697273566650332F4F51666D653131473874744D7457456A57676379737443417A3852366466356B3950342F7744572F6D7A704F7A4D4A6944492F78386E6C4F3138346E49524838463853596638414F4F476A79657065617177496A34724170385354366A2F384253502F4149504B75314A37435038416E4E7659324D334B662B5939787A5150544A4672486E6E524E476D467271463346464D61664154556976546D46356350396E6D526A303835693467754C6B31575047616B51436E4E7463785855617A774F736B54674D724B5151516536734D6F49494E46795979456859564D43586B582F4F52326F2B6E70746E59672F7742394D306E305272782F356E5A7575793433496E75482B362F3652644232784F6F43503836562F77436C2F77436B6D4D663834363662363272334E3652555151635237'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'4D37436E2F4378766D5632704F6F41667A7066376C77757834584D792F6D782F7742302B684D35743678324B754A4146547342697248375438776442753772366A426651764F547843687469663556663744742F71746D544C545A4969794454695231654F5234524B504579444D5A79332F2F302F564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7578566A763569366F644C38763331304478595173716E775A2F335366384144506D567059636551447A63505754344D556A2F414566393136587A4C59656639657345394B327635315164464C6C675039555079342F526E565330324F57356A46347947727952324570664E5331547A6672577467573937647A7A71646847574E43662B4D612F43782F324F47474347506341525250555A4D6D306A4B544E50792B2F4A532F3169564C7A576B6131735151654462535366354954375561667A4F2F0A2B772F6D5842314F766A41564431542F324D5859365473325751335030512F32556E305642416C7647734D4B684930415656477741416F716A355A7A4A4E376C363443685153667A76426454364A657861665836793044684176326961665A582F41436D483263763035416D4F4C36654A7839554363636848367545766B4152737A656D4153354E4B55337234557A744C66503666596E6C4B47356730697A6976712F57557434784A587279436A6B472F79763573346E4D515A6B6A366549766F576E424549695831634974686635342B632F304C7058364E7432706458774B37486459782F654E2F732F37736637502B584D37732F42346B75492F54442F644F7437553150687734523957542F63666A30764976796C386D2F77434A395A525A6C725A32314A5A713943416667692F35364E2F776E504E3172632F6851322B7158706936445161627870372F414552395576384169583150307A6B5875485971786E387A4C4C3635356231434B6C61514D2F3841794C2F652F7744476D5A656B'
		||	'6C7735492F7742622F64656C777462486978534839482F632B70387361427148364F3147327661303943614F542F6757445A3175535046456A2B63433852696E775345763573684A396D357737364938742F35794674377558525958747778743435775A67765955496A5A76386A6C2F7733444E763259514A6D2B64656C306E61346B63597236654C315047667935747275343877574B32495071724F6A456A736F4E5A53332B5236664C6C6D38315241786D2F35727A756A69546C6A772F7A682F783539635A786A337273566469727356646972735665542F38414F525770656A704E745A41304D382F492B366F702F77434E70457A63646C77755A5038414E6A2F756E5264735471416A2F4F6C2F755867646A71467A70386F754C4F56344A6C71413862465746646A385355624F696C4553464831504B786D5947346E685039464E503863362F774439584B382F36534A502B6138712F4C342F357350394C46762F414457542B64502F4145386B33386E2B5A39653150574C4F7962556273704C504772417A79456365513537632F774353755535384F4F4543654748306E2B474C6B6166506B6E4F4D654B6538682F464A3955357944334358655A49376954544C744C4B76316C6F4A524654727A4B4E36645038415A35626949456866303851346D6E4D435948682B72686C772F7742616E78735932567654494963476C4B6231384B5A3239766E6C5072767942625864746F4E6C44714149755568554D47366766734B332B55716356624F4D314A427945782B6D3376744A47556363524C367546505A70566852705A44524542596E774136356A675735524E62766B5A66503274510A5845747861586B38516C6B655171726E6A566A79507766592F34584F7A2F414330434143496C344C38336B424A457052767A6276667A44387758735A686E763579683249446C612F50687872676A7063636478474B79316D57516F796B6D586B72387139573830534B2F707462325A4E576E6B4241702F7741564B6435572F7742583450356E79765561794749667A70667A573754614765592F7A59667A356637332B632B6D504C2B673275673255576D324B385959685156366B2F744F332B557833624F567935446B6C7846374C4469474B496A486B45777970756648486D754736683157376A76362F57524D2F506C314A4A72792B546661582F4A7A74384A42674F48366166506334496D654C367549766F4C38687261376738754436324743504D377768763841665A436450386C705055622F4149624F623752494F5462753958395A367673714D6869332F6E656E2B722B4F4A364C6D7364752B656638416E496E556657316D337378396D4341452F774373374E582F414956557A7065'
		||	'793431416E2B644A354C7469643541503573663841644D742F357830303330644A75623069686E6E34672B4B78714B66384E492B5966616B376D422F4E6A2F756E5037486855444C2B644C2F632F77445354316E4E4D3735324B73592F4D3643366E387558306468557A6D4C6F76557256665655552F6D6935356C3651675A4278642F38413069345774424F4B516A7A722F704C2F41474C354F7434704A70466A6742615669416F55564A4A2B794670337A73536135764341456D672B77767139372B6876513566366639563438712F3774345535637638416A4A6E4533486A762B44692F324E766F4E53384F76342B442F5A384C2F3954315469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356616441344B7341564F784278564B4A764A756954747A6C302B31646A3361434D6E385679385A356A6C4B582B6D4C6A6E54597A7A6A442F41457355560A702B676164707035574E72444166474B4E552F3467426B4A5A4A53356B792B4C4F474B4D507045592F31516A737262585971374655765879377071335031356257415856612B71496C353138665534383874385756566375482B626256344D4C34716A78667A7148456D47564E716E4A6278536D73694B78397744684249515143334642484658303143313630464D53625541426667533746584541696833427856522B6F322F2B2B302F34455A4C694C48684863725A466B746C6953565448496F5A474643434B676739694D494E4949766D67394F304C54394D4C4E5957304E75582B30596F3153762B747743317963736B702F55544C2B735775474B4D507045592F774255634B4F797474646972735664697273566469717957434F576E714B477030714163494E49494257665562662F4148326E2F416A44784648434F35333147332F33326E2F416A48694B3849376D30733455504A59314248634B4D654972776856794C4A324B7065664C756D74632F586A617747367258316653586E'
		||	'587839546A7A7933785A565679346635747458677776697150462F4F6F6353595A55327578564B37767972704634334F367372615675745868526A2F77793564484E4F5049792F77424D57695743457563596E2F4E447254797070466D337157746C625250347043696E37315847576163755A6C2F706973634549386F78482B62464E4D706233597137465576762F4C326D366A494A723231676E6B586F306B617552386D645363736A6C6C485947556669315477776D626B49792F724248716F55425646414E67426C62613369716E4A617853486B364B7838534163494A4445784258527872474F4B414B5041436D4A4E70417064675337465859716C397635643032326E4E354261775233427154497353687A587238617279337930355A4555544C683937554D4D496D774938583836676D47564E722F2F3166564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B0A757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7638412F39623154697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972'
		||	'73566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F41502F58395534713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712F77442F3050564F4B757856324B750A7856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B7050712F6E4C523948597066336B4D4C6A3967754F582F41434C48782F384143356644424F6630676C78386D70686A2B6F78696C555835732B574A57344C6678676E784441666579675A6364466C48384C514E66685038515A4A702B7032756F782B765A54527A782F7A5273474833726D4C4B426A735277755A43596D4C69654C2B716963677A6469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697244507A492F4D622F4141584842496259335031677341656641417278'
		||	'2B31384C2F61355A6E6158532B4F547677384C72745A72507934473346784C66797638417A416B3835323178505045734C77794251716B6E34537456725839726C7A773676546541514276614E44717A7141535277384A5A726D41374A324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856683335706564626E79687030576F576B615373397773544C4A576E4570492B334572385659317A4F30656E4761526966357646397A72396471547034695133395844396B6B4E2B562F77435A542B645675524C6269336131394F70562B51626E7A374656346366532F6D624A6176532B425648693472596148572F6D6273635042582B79762F6957645A72335A757856324B757856324B757856324B757856324B757856324B757856324B7578562F2F3066564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B744D7751466D4E414E79546972352B2F4D333836626A554A583033514A44445A72384C544C7338683738473670462F77372F36767735306D6B3041694F4B653876357638313554573970475A34636670682F4F2F6E66384148556F38722F6B6E726D767869376E34326B4C37677A563573442B30497838582F497A686C32625877780A3744312F31584877646D5A4D6F732B67663076715A484E2F7A6A6264424B7733386250546F305255562F3167372F41504563786832714F7366746377396A48704C2F41474C43395638712B5A66792B7542656648434161436546716F66386C6A372F414D6B7966462F4C6D64444E6A3149726E2F526C3958342F71757479594D756C50463950394F48302F6A2B732B6A2F4A6C357156377056766336306978336B69386D5664746A3967737637447376326B2F5A2F34584F587A786A475A4550706577303070796744503630377968795859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374657442F6D682B5A4465536F72637851436557354C30354D5643384F465473726376377A2B5A637A394A7066484A33346546316D75316E355943687863642F77437858666C54357A76664E31685071462B6B61634A7A45697867675543'
		||	'6F2B2F4A6E332F6559367A424844495248383230364455797A784D70563958443657625A674F796469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972796A2F6E4979477569323076387430462B394A442F414D615A754F797A36795036503651364C74676675776636662B396B6C6638417A6A584C564E536A37417748372F572F35707933745566542F6E6637316F374650316635762B2B6531356F6E70485971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597138532F35583366366A71634F6E61666178524A4C4F6B584A79306A454D77537138505346662B447A66667962474D544B5250303858383135762B565A546D4978414679346635332F45766263304C306A735664697273566469727356646972735664697273566469727356646972735665572F38414F52582F41427749502B5978502B546332626673762B385039542F6652644A32782F646A2B7550397A4E492F2B6361662B6C6E2F414E472F2F4D2F4C2B3166346638372F4148726939692F7866356E2B2F65335A6F58705859713746585971374658597137465859713746585971374658597137465859712F77442F3076564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B764D767A350A383176704F6B707074757857612B4A56694F6F6A582B392F77434435496E2B707A7A61396E59654F66456634503841644F6C37567A2B48446848504A2F7550346E6E6E35462B546F39623152372B37586C623249566744304D6850377576694534732F2B74777A5A396F357A6A6A776A6E502F41484C716579394F4D6B2B492F546A2F414E322B6B4D35643742324B74504773696C58415A54314233474E306769323855757856324B7578564939623838364C6F684B36686552524F4F716375546A2F414A35783870502B467A49783665655436515846793672486A2B6F67666A2B61782F384135586A3557725436793150483070502B614D79663550793933327863582B5538506638413747544A39423831615A356751796158634A4F4636685452682F725274786466396B75596D54444C48395134584E785A345A64346E6954584B5739324B757856537572714B30696165346459346B46575A7941415038706A68414A4E426A4B51694C4C4164552F506679335975556A65573549377770'
		||	'742F77557252567A5A51374F7953376F2F316E567A375578523558503841716A2F69754662702F774366666C7536594C4B30317658764C48742F7952615847585A75516430766A2F785843694861754B5850696A2F57482F4538544F4E4A31757931654C3678703830633866696A41302F317635542F414B32594538636F47704468646E6A79787943346E69527556746A7356646972735664697273566469727356594E722F414F622B6B614C7136614E4F5332394A70564934784D6673713338332F466E2B2B2F38414B2B4C6A734D65686E4F4847503832503835316D587443474F664166383658387A386678667A57536559504E4F6E65583766363571557978526E3750637366434E462B4A2F774459356934734D73687149637A4E6E6A6946794E504E37372F6E49375459334B326C6E4E4B6F37757970583642366D6253505A636A7A4964504C7469413543522F32502F464A7235652F506A5139556C467664435379646A514E4A51702F794D5837502B7A56562F79737079396E54674C487262385061754F5A6F2B6A2B74394C306745455647344F617433447356646972735659357250356A65583948597833743745726A71716B75772F316B694473762B797A4B7836584A506B442F414C6E2F41485468354E5A69782F56496637722F41484B544C2B65506C596B41334C44334D556E2F4144526C2F77444A2B58752B324C6A2F414D7034652F3841324D6D57364E723968725550316A545A306E6A36456F61305067772B30702F317377736D4F574D3149634C6E3438736367754A346B666C62613746555071476F322B6D774E6433736977774A546B376D6969703469702F310A6A6B6F784D6A51334C436378415849384D58675035392B5A4C4457626979476E5470634A456B6E49787347414C4666442F557A6F2B7A63556F41385134655479766175614F517834547856624A2F7955383136527047672B6866336B4D4D7A544F2F4233436B41385647782F3163784E66686E504A59424F7A6D396D3534593864536C474A3469394A30727A5A704F72796D33302B3668754A517059724734593047334C62743857617565476342636759753578366947513145786B6D325574377356536E58504E756C614651616E6378774D77354257507845667A4242386450396A6C325044504A3949346E48793669474C3669496F6A524E62744E627445314454333953326C3563576F525869786A6234584374397057794F5447635A345A66557A785A593549385566704B4F797474514F72613959614F676B31473469743161764831474331703134312B312F736373686A6C503652784E57544C484876496950395A5A6F586D4B77313646726E544A6850456A6D4E6D5545446B417245'
		||	'66454258345858446B7853786D70446852697A527969346E692F6854484B6D35324B6F485674637364486A45326F7A783236486F5A4743312F31612F612F324F575178796E74456354566B7978786935455239364538742B62394D38794356394B6D45797773466338575768497150746854782F7741724A356345735831437259596452444E6641654C68532F7A482B5A75672B583544426533494D343678786775772F77426268736E2B7A5A63737861544A6B3341326163327478346A556A3676357366556D766C767A4A616559374E645273437867596C5157557161716148726C5758456352345A63322F446D6A6D6A78522B6C4E4D70623359716C4F7465624E4B305166376B72714B412F79737735665247506A502F4135646A777A796653444A6F7961694750366949735A663838504B7973514C6C6D703345556C5078544D762B543876643973584350616548762F414E6A4A6B486C377A786F336D496C644C756B6C634370546458702F786A6B43762F7775593258547A786655484B773672486C2B6B326E6D59376C4F7856324B764C662B6369762B4F42422F7A474A2F79626D7A62396C2F33682F716637364C704F325037736631782F755A70482F7A6A542F30732F38416F332F356E356632722F442F414A332B39635873582B4C2F414450392B39757A517653757856324B757856324B757856324B757856494E65382F614A6F456867314B36534B55414570526D61683666444772746D546A30303867754963544C713865493149306D4F6C61356161705A4A71647139625752537764766832426F61387673394D716E6A4D4A634A2B70757835597A6A784436575058760A35752B56374F517853337946682F497275502B446952302F34624D6D4F6979793372376F754A4C74444445305A663771582B35546251504F576B6559502B4F5A64527A4D42557144523665507050786B2F34584B636D4365503668546B597454444C394A4576782F4E546E4B4849646972735664697144315457624C536F2F5776353434492F47526774666C7936354F474F55396F6A6961353549774679496A37324A3350353165566F4834665779354855704849522F7758436E335A6D6A515A54302B304F424C744C434F7632535232682F6D6A35653171555739706472367A476753514D684A384639514B72482F5679764A6F386B425A482B2B62635775785A44514F2F77447057565A687563374658597168372F557262546F6A63587371515244597649775566384532536A41794E4163544363784158493850395A4B6443383961507231314A5A615A634365614A6562425177464B3866685A674662666A396E2B624C736D6E6E6A4679484330597456444B65474A346947764D6E6E33'
		||	'52764C5A34616E6372484B5255526972502F7743636D582F41466D2B48446930303876306847625634385031482F4E2F696238706564645038315253543659585A496D43747A5572755258366347625479776D704A302B706A6E4678364A396D4F35547356514772362F702B6A7036756F334564757036656F7742502B7150744E2F736373686A6C503652784E57544C48487649694C464A2F774137664B3054635264462F6459704B663841454D7A4232666C50543759754365303849362F3747536136422B5A4767363949494C433752706A7349334252696638414A57514C7A2F32484C4B636D6C79593979473746724D65553145372F414F6C5A4C6D4B35727356646972735664697273566469727356535057664F6D6B36557A323931647778584B4C586737674863636C2B48337A4978344A7A33414A6934325455776873544553664C586B696543333179786E756D45634D647845374D786F4146594E794A7A726451435945442B6158694E4D514D6B5365584548302F384138724638752F3841567874762B526935796635584A2F4E6C386E74667A6D4C2B64483570376158635635456C7862734A49704147566C4E5151656A444D6555544530584A6A4953466856774D6E5971746B6B574E53376B4B7169704A4E4142684174424E4D51314438332F4C4669786A6B76566468326A566E482F4278717966384E6D624851355A6448416E3268686A2F462F70626B7236522B61586C7A56584556746578695274677367614D313850336F51482F593547656A7951356A2F6666376C6C6A31324B65776C2F7076542F414C706C58584D4E7A6E597137465859713746556E312F7A68700A506C3841367063787745696F556D7245654B7870796B502F4135666A77547966534F4A7838756F68692B6F384B5432663576655637755152523336426A2F41447136442F67355552502B4779365769796A66682B36546A78375177794E43582B366A2F756D4E6638354379704E35657470496D444931334751774E515236633351356C646D4373682F712F77432B69346661357645435035342F334D6B6D2F77436361663841705A2F39472F38417A50792F74582B482F4F2F33726A64692F7741582B5A2F7633743261463656324B7578565475626D4B326A616164316A6951565A6D49414138575A746868414A3243444952466C6839392B63666C657A637874654232482B2B3064782F7741477138502B477A4E6A6F6373756E334F766C326A686A2F462F7062522B692F6D54356631715151325635473072624248716A452B43724B4535482F5679764A70636B4E795039392F75573346726357513147512F33502B365A4C6D4B356A73566469727356514F73363959364A41627255706B67'
		||	'6947315850552B43723970322F7956797A486A6C6B4E524845315A4D736359755234574258662F4F51506C3242754D61334D772F6D534D4166386C586A622F6863324D657A63682F6D6A3475726C327469484C696C38503841696A464836582B64336C712F5949303757374870367945442F6731356F763841736D7975665A2B535054692F7174734F3038557576442F575A716D6F577A776658456C5132345576366759634F49334C382F73386638724D44684E31587164694A676937395038414F662F54395534713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712B622F38416E494855446365594674362F446277497450646930682F42317A714F7A59316A762B644A342F74616435612F6D7844306238674E4F5732387666575032726964334A396C7045422F776A5A712B3070586B722B614862396B777246663836522F346C36566D726479374658597137465859713746586B6E3536616A356973316754544A475454353652743649496B4D684F794D362F4878646673634F504C3431666C384F626E73364F4F56385831782F6E665477756837556E6C6A58442F647932395031636244764C583542367871696966556E57786A62656A446E4A394D594B71762B796B3566354F5A3258744B454E6F2B762F63757577396C546E764C39332F73704D6F6E2F414F636272517845513330676C37466B42582F675156622F4149624D5164716D3977357837476A57306A386E6B3772716E6B5857536F6230723230636271617177507866370A4B4F56502B467A63656E55512F6F7964436550545A4F366350782F705A50724852395354564C4B432F69325334695351447744414E544F4F6E44676B592F7A587538632B4F496B503468784976494E6A7356664E6E35326564353959315754536F6E4973724E754845485A70427449372F36726675312F316638414B7A71644270784348462F46502F6376486470366B354A6D412B69482B365A54354D2F4943316D7449377658704A50576C5550364D5A436841642B4D6A454D7A502F4E783463663872375759656674496731442F41457A6E6162736B474E35436250384144464D4E592F35783130795A43644E755A6F4A4F776B704976366F332F774347624B34647153483141532F324C626B37486766704D6F2F374A4D2F796B2F4C47667969317A6336677950637945526F554A49394D664658634C2F6550322F347279725736735A714566702F337A6432666F6A6773792B723666383136506D7264773746585971374658597137465859713746587A462B646E6C714851396559326F34'
		||	'773355596E436A6F7245737367482B79546E2F73383676515A546B78372F414D5070654C3754776A466B32355439616835573873367A2B5931306B6373702B72576B6152475639316A525278534E462F616B616E2F477A746B733257476D484C31543958442F41446D4744426B315A6F6E3077484478667A59765737663867664C736348705365764A49522F65475368722F414A4B714F482F43746D6D506157516D396E666A736E454252347636317649667A503841793562795A6452694B517A576C77474D624D4B4D43744F5350543466326C2B4C39722B584E31704E563434377052656631326A2F4143354665714D767065792F6B5A726B757165586C6A6E626B39704930414A3638514665502F67566B394E6639544E48326A6A454D6D333858716569374C796D654B6A2F4141486765685A7258624F785634662B647431356D625559394D746D63366664436B4D6341494C6B443935484C782B4E322F61342F774233772F5A2B316D2F3750475068346A39636671346E6D7530355A654C68483933503665442B4C2B736C766C372F414A7835314B38555336744F6C6F44767755656F2F774473714659312F774344664C63766163592F534F502F41474C546837496E4C655A3450396C4A4F74522F3578776739416D7776583963445953714F4A50683848784A2F7741506C45653144653432386E496E324D4B394D76562F5365592B56396676764A4774427A79526F5A505375492B7A4B44786B512F3841476A667A66466D317A59343534652F654470634757576D79663154777A6A2F756E31717242674755314233427A6A587657385653547A7235612F784E704D2B6B657236480A7238506A3438716358575837484A4B31346366745A6B61664C3455784C36754678745468386142686644786672346E7A642B5A48356666344C75494C663678395A39644339665434556F654E507479567A70394C716648424E634E5048367A53666C79426648786558436E2F414A472F4A542F464F6C7836723965394431433434656A7A707859703976315538503563783952722F426C7731786635332F48584B30765A6E6A77452B4C682F7A6638416A7A3162387476797769386C476554312F7255302F45637654346356577677303579666162722F71726D6E3157724F657475486864356F74434E4E5A766A34764C685A766D41374E324B766E332F6E49332F6A72327638417A44663862766E53646C2F5166363336486C4F3250724839582F6650532F79562F7743555473662B65332F4A36584E56722F37302F7743622F75597535374E2F75592F35332B376B7A664D423254786A2F6E4A502F6566542F7744586C2F56486D38374B35792B447A7662504B5038416E666F54582F6E4858'
		||	'2F6A67542F38414D592F2F41436268797274542B384839542F6653622B782F37732F317A2F755950557331447533597138312F5037543075504C3331676A3437655A474238413159322F346E6D30374E6C5753763577644E32744338562F7A5A4234583562383336686F4D4E7A62615978535338434958583751414A2F752F38747558486C2B7A2B7A38583265677934493543444C2B42356E44714A596752482B4E6B6D6C666B62356B314B4836793652322F496367737A6B4F663969697963542F786B345A6A54375178784E66562F56637A4832586C6D4C326A2F586652486C725249394430323330794B6E47434D4B534F352F62662F5A7679664F5A793550456B5A482B4A36334469474B41695034516D57564E7A7A7638414F76557464303353317564466B394F3342343344495033674232526C6639684F587773562B503748785A73394243457056506E2F4141667A58556470547951686350702F6A2F6E504C664C58354B36373568706558782B7152536645586D715A47722B31365832762B526A523574737576686A3248722F712F5336544432626B793779394839623676394C2F414D557A516638414F4E316C36644466532B722F4144656D76482F674B312F34664D482B56543342325038414930612B6F2F4A3554356E3874366835473155573776786D6A704C444E476156577677794C2F4C7576466C7A635963736452432F684B4C6F382B47576D6E5858366F796654586B547A45664D57693275707654314A556F395035314A6A6B2F346465576370714D5868544D5873394C6D3858474A6436665A6A75553746586C762F4F52582F4841672F774359785038416B334E0A6D33374C2F414C772F315038416652644A32782F646A2B7550397A4E492F77446E476E2F705A2F384152763841387A387637562F682F7741372F65754C324C2F462F6D66373937646D68656C64697273566469727356646972735664697235342F35794B743154573765556458746C723944795A30765A5A394248394C394165533759483777482B682B6D54474E4D76504D486D793174764C476E686E7437634834453258646D66314C682F732F447A3472792B482B583438793578783453636B75637678365843684C4A6E4178522B6D50362F343261576E2F4F4E393838584B35766F6F3561665A56475966384754482F7741517A426C327247396758597837476C573868386D432B612F4A6D72655237794D3342346B6E6C44504554516B667974384C4B362F7935734D4F65476F47332B644754724D2B6D6E7070622F3573347665507969382F74357230396F37736A362F613057516A626D443969576E2B5654692F2B562F725A7A327430336779322B695431485A2B7238654F2F774263'
		||	'50712F34706E6D6135326A735653507A744A7173576B7A796144782B764B745642586B534239726750732B70782B7879356636755A476E45544D636630754E71544D5150682F572B643942386865592F506370763543786A5937334677786F663954375476542F4958682B7A384F644C6B314F505469763968423548467063757150462F7335732F732F38416E4736324366365866534E4A2F774156786851502B434C35727064716E6F48617837474857583250502F7A492F4B2B35386D736B776B2B7357557834724A546951314F58707574572F5A2B793337582B546D79307572476662365A42315773304A302B2F31516C2F4539652F49337A645072756B7661336A4635374A676E4D376B6F777248795064687864503956567A53396F59426A6E593554642F325871446C68522B72482F756634586F2B617433447356596E2B6131676C373561766B6B4832497655487355496B482F4142484D7A5279346367392F2B366344587734735576647866365638306556664E5631355A756D7672476E724E4538594A36446C2B31782F61342F73387668355A315762434D6F6F7647344D35776E696A7A72685A4A6F6E3554655A504E536E556E416A5762342F567558494C313335304379532F462F4D792F462B7A6D4C6B3175504436653770427A4D576779352F562F4F2F6979667866373537782B58486C4D2B56744769302B58695A36744A4B56364632502F477163452F324F6339717333697A4D756E384C31476A302F675978452F562F462F575A506D49357246767A4C756459744E466D754E4149467848385466447962302F3932656C32395266746636764C6A3866484D765343420A6D425036663938344F746C4F4F4D6E4839582B392F6F7643504C6E35592B59664F6A667047596C495A5455334677784A62335166464A4A2F7266592F793836484C71386544306A2F5351655977364C4C71505565522F6A6D7A32322F3578757331536C78665373394F71497169767959762F414D537A584874553941375350593065736A386E6D763568666C3764655372714E486B4530453154464B6F346D7130354B792F7375764A66327332756D31497A6A75492B714C7074587044706A2F4F6A4C365A506466796438317A65597444535337626E6332376D4632505675494449352F7975444C792F6D5A655763397273497854322B6D5871656E374F7A6E4E6A332B7150705A786D41374E324B757856324B757856324B75785635622B5948354D66346B314362576672766F386B58393336504C37433866742B716E327550386D626654612F776F6946582F414A332F414231306D72374E3861526E7863506C772F7A663835345635573050394F366E623658366E7066574834632B504B6E'
		||	'767871764C2F677336444E6B384F4A6C2F4E6559775976466D4938754A36326E2F41446A55415279314D6C61376757394454352B7363303338712F3066396C2F7831333338692F307639682F783537526257386474456B4549437878714655446F414278555A6F69624E6C364F4941464255774A616477674C4D51464171536567474B766D583879667A4576504F4E2B645073432F31414F45696957745A477278456A6A396F7566377450325039626C6E563658536A4448696C39663855763572786574316B74524C686A3948384D6635374A664C2F77447A6A7050504373327358586F534D4B2B6C456F596A2F576B4A3438763956572F31387863766167427149347636546D5965787952637A772F3059705435322F497539304B33652F303658363562786A6B3638654D6967645734315A5A4658397237502B726C326E37526A6B50444963422F324C5271657935596878525048482F5A4972386D2F774130703743356A304C56484C32637843524F78336A592F5A546C2F76702F732F384146663841713873687274474A446A6A39512B722B6B32646E6134784978792B6958302F30502B4F766F4C4F626572646972735659482B62503569663453736C69744B48554C6D6F6A7276775566616C5A662B5466387A66366A5A7364467066474E6E36492F6A68645872395A3445614839354C36663650394A34683553386B6176352F7535626753664347724E63536B6E633976356E662F4143662B49357673326F687078582B6C6846357254365765716B542F414B61636E6F45762F4F4E69635033656F6E314B64346469662B526D32613464712F3066396C2B78327037472F706637480A2F6A7A41664F336C3758664B64737569616933716165386F6D695A53536E4A5179664279336A626A4A3863662F585762485435595A6A78782B757547547139546879594277532F7537346F2F7741333865706E662F4F4E502F537A2F77436A662F6D666D7537562F682F7A763936375073582B4C2F4D2F333732374E43394B3746564F36755937574A376964676B55616C33593941716A6B7A4835444341536144475568455758793935323837616C3539314A625731446D334C384C6533587676384143376A7649332F4A502F676D7A724E50703436654E6E367634357646616E557A31553648302F77515A6E6F762F4F4F4C76454A4E567650546C492B784576494C38354850786638414166374C4D484A32707636522F706E59347578374872502B6C593535372F4A572F77444C55446168617943377445336368654C6F50356D537256542F41436C622F59356C61665878796E68506F6B346571374E6C6848454478782F3254492F79572F4E4364703038763674495A456B327435474E5347'
		||	'2F33797A6431622F64662B56384838764847312B6B46636366382F774434707A4F7A646362384F6638416D532F3372334C4F66656D6469716E6333435730547A796E6A4847705A6A3441446B3245437A51597950434C4C3551317A577452382F36327656704A3542484248583455556E3456397166616B663841316E7A7363654F4F6E682F562B7034584C6B6C71736E396230776A2F414466782F453965306E2F6E486E523459514E516D6D6E6E492B4A6C495251663868614D332F424E6D6C6E326E4D6E3067524430475073694148714D70532F3071576559502B6363345755766F74307976326A754143442F414D39597776482F414A46766C754C74512F786A2F5374476273636677482F542F7744464D72387565514A644638705847694A51333131424E7A3332395352436972792F6C5434452F7743477A4479366B5479696638455A522F307353352B48534848684D503435786C2F703578662F3150564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B766C33383747592B6137774E304168703876536A2F77434E733633516633512F7A7638416446346E74503841766A2F6D2F7743356939722F4143562F35524F782F774365332F4A36584E44722F774339502B622F414C6D4C306E5A76397A482F41447639334A6D2B5944736E7A6E712F353165614E4E764A374752347555456A786E3930503253567A70346144464941372B727A65517964705A6F534D66543654772F53685038416C66586D582B65482F6B554D6E2F4A320A507A2B62442B5663763948355054507959382B366E35732B752F70526B62367636504467764837667138712F3869317A56612F54527731772F774158462F765863396D367565666934763465482F665053383154755859713056446452587669726E6B574E53376B4B6F334A4F77474E57676D6B706D3835614A413343572F7455627761654D4838577938594A6E6C47582B6C4C5164546A484F5550394E463837666E5671467071486D463769786C6A6E69614B4D63346D444B5342543753564663365851524D63644830376E6D386C326C4F4D387478496C735070652F666C312F796A756E66387730662F4142484F63315839354C2B73587174482F64522F71686B57597A6C7578563868656664506C734E6576344A68526863534D4B39315A76555276396B6A4B326470707043574F4A48383050416175426A6B6B442F4F4C36553870666D5070486D4B326A6C6A754934376C674F634C734664572F6141566A3861312B797935793262537A78486C3666357A324F6E316B4D6F4273635838'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'316C4F596A6E4F7856324B757856324B757856324B757856324B757856382B2F77444F52763841783137582F6D472F3433664F6B374C2B672F317630504B647366575036763841766E6F2F3549323863586C5731654E5172534E4B7A6B667445534F6E4A7638415949712F37484E58326762796E3466376C322F5A6741776A2F4F2F33525A336D76646F38592F3579542F336E302F3841313566315235764F79756376673837327A796A2F414A333645642F7A6A6C2F78794C722F414A69662B4E457948616E316A2B722B6C7337482B672F31763936395A7A544F2B646972525545676B626A7069713261654F42544A4B775242314C47672B3834514C35494A413570544A3531304F4A754D6D6F5769734F786E6A422F346C6C7730387A2F4141792F30736D67366E4750346F6636614C35672F4D613668752F4D463950624F736B4C796B7136454D70464275724C384A7A724E4B434D5942376E69745A49537979493733316C592F377A782F36692F717A6A70633375343867725A466B374658676E2F4F53482B39396C2F774159582F346C6E52646C665366653874327A39556636725076794E2F355265332F313566384169625A7275305037302F44376E61646C2F7742795038372F4148545063317A745859713746587A372F774135472F3841485874662B59622F414933664F6B374C2B672F317630504B647366575036762B2B656C2F6B722F7969646A2F414D39762B5430756172582F414E366638332F6378647A32622F63782F7741372F64795A766D41374A34782F7A6B6E2F414C7A36662F72792F716A7A65646C633566423533746E6C482F4F2F516D762F41446A722F77410A6343663841356A482F414F54634F5664716633672F71663736546632502F646E2B75663841637765705A7148647578566758353566386F7663663638582F45317A59396E2F414E36506A397A71753150376B2F35762B3665582F77444F502B6977582B74535856776F663672467A53765A795171762F7356353574753073686A43682F455853396B34684C49536634422F736E30626E4D5058757856324B744D6F59555956427856736D6D353659716C567A35743065316268635831744733673879412F384D325844444D38684C2F536C6F6C7149523579682F706F7644507A3931657831532B744A64506E687541734C4B7A524F72302B4C5A574B467336447332456F5250454448662B4A356E74624A476367596D4D76542F44366E706635472F77444B4C322F2B764C2F784E733158614839366668397A754F792F376B6635332B365A376D7564713746586C7638417A6B562F787749502B5978502B546332626673762B385039542F6652644A32782F646A2B75503841637A53502F6E476E'
		||	'2F705A2F39472F2F414450792F74582B482F4F2F33726939692F7866356E2B2F65335A6F58705859713746585971374658597137465859712B66662B636A662B4F76612F3877332F4142752B644A325839422F72666F655537592B7366316639387A3738694C4F474879334850476757536153517577473763574B4C795038416B726D7537526B546B727570326E5A55514D515038346C364A6D7364757776383474485455764C563179465867416D512B42512F462F795435726D666F5A384F5166307653363374484878346A2F5239662B6C654E666B54716A57586D574B437445756F35496A346244316C2F774347697A64396F773473642F7A612F77434A6565374C6E7735515035344D6639392F7658307A6E4B765A757856324B744B6F555555554178564158336D485462416C62793667684936695352562F346B32575278536C79456A384771576145655A6A482B73586D5035352B59394B3150516B6873727533754A567545626A484B6A7342786B4262696A4D66327332335A2B4B634A32524B5070376E5364715A6F54783145786C3668394D684C76532F77443578702F365766384130622F387A387337562F682F7A763841657458597638582B5A2F7633743261463656324B73642F4D582F6C4864522F356870502B49356B36582B386A2F574469617A2B366C2F564C35302F4B62526F4E5838783274746471486842615171647733425764516638414A356865576450726368686A4A44794767786A4A6C41504C2F69583162307A6A33756E59713746586463566341414B44594446557476504D326C324A343364356277734F7A796F702F774347624C593470533543522B0A44544C5043504D786A2F414A776552666E3935673037564C4B7A5454377143345A4A574C434B52584948487133426D7A64646D3470516B6549474F333851644232746D6A4F49345447572F774443654A4D662B63634333364F764161386658576E68586A762F4141797274543668376D377362365A66316E7232615633377356646972735664697273566469716A6666377A7966366A667179556562475849766C4C3872762B556C302F2F6A4D5031484F76316E39334C33504461482B396A2F5766576563633932374658597177373833645962532F4C56334A45615353714956502F475168482F354A38387A7446446A79442F54663656312F6147546778456A723666384154504776794730684C2F7A454A70425557735479697638414E56596C2F7743546E4C2F5935752B305A384F4F76357834586E65797366466C732F7744692F337236577A6C6E736E455632505446587944353530686446317938736F5278534B5A6967485A543863592F7742696A4C6E61616566484145397A774771'
		||	'782B486B6C45644A5071627962713761786F396E667561764E4368662F414671556B2F34666C6E4A5A3463457A48754C322B6D79654A41532F6E52546A4B484964697235562F4E7A575731587A4A64735456494739425234435034472F354B656F332B797A7239466A344D592F7065722F41457A77336147546A796E2B6A3650394B2B68767935304750524E42744C574D414D30617953487864787A6635302B782F717175633171736E695A435872644869475047423563557636306D535A69755938742F35794B2F343445482F4D596E2F4A75624E7632582F65482B702F766F756B37592F75782F58482B356D6B662F41446A542F77424C502F6F332F77435A2B5839712F7741502B642F76584637462F692F7A50392B39757A51765375785635372B65757274702F6C78346B4E4775704568323630336B6637316A342F374C4E6C3264446979582F4E39547165314D6E4269722B6565482F665050502B6364394A53353165652B63564E744452665A7044783566384173692F374C4E6E326E4F6F41667A6A2F755855396B59376D5A667A492F37703943357A5431697961464A30614B55426B63465742364548596734516133515265786648657357736D6736745062777356657A754756473731527667622F4149586C6E6251506951425038636639302B665A496E464D676677532F7742795831356F2B6F4455624B432B585954784A4950396D6F662B4F63584F5044496A2B61587673632B4F496C2F4F416B693867324A62356D73704C2F5337797A682F764A7265574E666D794D713562696C777942505351616338544B42412F696A4966592B55664A65754C3565316D32314B640A5379515366476F3630494B50542F4B56577A734D2B50784947492F6965463032587773676B6634532B724E4738303658725342394F75597075517278566879482B7448397466396B7563686B77796839514965357835345A5070496B6D6D5574377356662F2F56395534713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859712B62507A2B7357742F4D5A6D49326E676A63483556692F356C3531505A737278312F4E6B586A75316F316C762B644566385339502F4143477678632B576F345164376557534D2F5366572F356D3571653059316B762B63422F784C757579703369722B61535039392F766E6F6D6178323658542B57394D7548615761306765526A566D614A435366456B726C6F797947774D766D306E4441376B522F306F65622F414A376148595757674C4C6157304D4D6E31684279534E564E4B507456526D30374F79536C6B6F6B6E30'
		||	'3937702B314D55593437416A483144703730712F3578702F3657662F52762F77417A387437562F682F7A7639363064692F7866356E2B2F65335A6F5870585971382B2F4E5438306B387052697A73774A4E526C586B413332593136656F2F69782F59542F5A4E2F6C374C52365078747A39482B36645472746434417150393466384159764A644638742B5A2F7A4C6C61356E6E5A7264576F5A5A6D496A422F6C696A5861762B54476E482B626A6D35795A63576C4641622F7A592F55364846687A617732543666353076702F7A5759572F2F41446A596E48392F714A3566354D4F3334795A68487458756A2F7376324F77485933664C2F592F386565582B66664B792B5674566B30704A544D49315138797647764A512F77426D72654F6262545A76466878636E5336724234457A432B4A394F666C2F4836666C37546C4F2F77446F734A2B3946624F55314A764A4C2B744A37545343735566366B6675542F4D5A796E59717750387976797174764E34463143347439516A5869484971726A736B6F2B31742B79362F5A2F7741724E6A704E59634F78395548563633514455626A307A2F4831504664572F4A767A4C7070502B696D64422B31437763482F41474839372F79547A657731324F5858682F72504F5A4F7A73734F6E462F5639582F486B6E744E63313779764B493470626D7A6B582F6462636C482B79696B2B452F374A4D756C6A783552796A503841483835783435636D4530444B486C2F7831375A2B564835764E356B6C2F524F71685676754A4D63693743536D37446A2B7A4A782B4C34666862347673356F745A6F764348464836503979394A6F4F305047504250362F38410A647655733144753359713746585971374658597137465859712B66662B636A662B4F76612F77444D4E2F78752B644A325839422F72666F655537592B736631663938394C2F4A582F414A524F782F353766386E70633157762F76542F414A762B3569376E73332B356A2F6E663775544E3877485A5047502B636B2F393539502F414E6558395565627A73726E4C34504F3973386F2F7743642B68486638343566386369362F7743596E2F6A524D68327039592F712F70624F782F6F5039622F65765763307A766E597138712F4E6A38336D38767948534E486F62366E377951696F6A714B7171722B314C543476692B46503872396E62364C52654A367066542F414C7030657637513849384550722F696C2F4D2F343838393876666C39356A2F4144412F334A3373354675784E4A72686D504C7366526A2F414A562F3535782F7935733875707836623067622F774132502B2B645468306D5856657152395038366638417657585266383432524266336D6F7357396F51422F77416E446D456531'
		||	'542F4E2F77426C2B787A78324D4F7376396A2F414D6565502B5A6449476A616C6336617247515738725268694B56346D6C615A7538552B4F496C2F4F447A2B624834637A482B6165463968325149676A4232495266315A784D75623644486B725A466B374658676E2F4F53482B39396C2F7868662F695764463256394A39377933625031522F71732B2F49332F6C46376638413135662B4A746D7537512F7654385075647032582F636A2F41447639307A334E633756324B757856382B2F3835472F386465312F3568762B4E337A704F792F6F5039623944796E6248316A2B722F766E7066354B2F77444B4A32502F4144322F355053357174662F4148702F7A6638416378647A32622F63782F7A7639334A6D2B5944736E6A482F41446B6E2F7650702F774472792F716A7A65646C633566423533746E6C482F4F2F516D762F4F4F762F48416E2F774359782F38416B33446C58616E393450366E2B2B6B33396A2F335A2F726E2F637765705A7148647578566758353566386F7663663638582F45317A59396E2F774236506A397A71753150376B2F35762B3659442F7A6A662F7666652F38414746502B4A5A736531667048766458324E395576367233764F646570646972735659682B592F3568322F6B367A4568416C764A71694750736164586B2F77434B302F3462375038416C4C6D3658536E4F6636492B70312B7331673038652B637670693851736B3831666D64644D6E717338536E3479784B5178313666417531663969386D622B5868615563762B4C6B38314878746165662B3978785A6861663834326644573631436A2B435262442F5A4E4A762F414D446D444C7458756A390A727349396A643876396A2B316750356C2B5130386D336B566E484F626753786570794B38616645793036742F4C6D79306D6F386345317737757231756C2F4C794176697363543348386B592B486C5730622B5A70542F77416C48582F6A584F6637515037302F442F637653396D4439795038372F64466E656139326A735665572F38354666386343442F6D4D542F6B334E6D33374C2F76442F414650393946306E624839325036342F334D306A2F77436361663841705A2F39472F38417A50792F74582B482F4F2F33726939692F7741582B5A2F7633743261463656324B757856324B757856324B757856324B766E332F414A794E2F77434F76612F3877332F473735306E5A6630482B742B683554746A36782F562F77423839462F49332F6C46376638413135662B4A746D7337512F7654385075647432582F636A2F41447639307A334E6337564A5050582F4142774E532F3567376A2F6B322B5A476E2F76492F774265502B3663625666336376366B7639792B612F796F352F346E73505436'
		||	'2B7166753474792F34584F6F316E39314A34375166333066652B723834393770324B7058356E387957766C79776B314B2B4E4934787342315A6A396C452F796D2F774362767335646878484C4C6844526E7A444445796B2B654E5438382B5A767A41766870396758524A43654D454C6356432B4D306E77382F77444B615434503556584F6C687038656D6A78532F3030763936386C50565A64564C686A2F70492F77432B5A4C706E2F4F4E397A496F66556235493350565934792F2F41413774482F78444D5766616F4830687A59646A452F564C2F536A69534C387966796A69386E6166487145643030356B6D574C69554330717276797279622F6665583658576E504C68726832346E4631765A343038654B2B4C3163504C3373702F77436361347152366A4A334C514437684C2F7A566D4A327166702F7A763841657564324D4E706635763841766E7457614A364E324B73642F4D582F414A5233556638416D476B2F346A6D54706637795039594F4A7250377158395576412F794E2F355369332F314A66384169445A3066614839306668393779765A6639385038372F637670374F5465316469727356534C7A70357674664B6D6E76714E3338522B7A4847445175352B79672F77434A4D33374B356B594D427A53345134757031417752346A2F6D2F77424A382F7A2B5A764E48356B583331433264754456506F786E6845692F7A536E396F442B61546C2F4B6E387564474D574C5378732F36622B4A3555353832736C776A2F5378394D5038414F5A56702F77447A6A624B796872362F56483772464757482F427530662F4A764D5358616F36522B317A6F646A482B4B582B6C44462F0A7A4E2F4B2B48795842627978334C5844547379304B6361425144583754667A5A6C3654566E4F534B3465467764626F527077446646786554304C2F6E484C2F6A6B58582F4D542F7741614A6D7437552B7366316630753237482B672F31763936395A7A544F2B6469727356646972735664697273565562372F6565542F55623957536A7A597935463870666C642F796B756E2F7744475966714F6466725037755875654730503937482B732B733834353774324B75785635702F7A6B462F796A712F38784D662F455A4D32765A6E39352F6D6C3033613339312F6E44394C422F38416E48492F376C376F642F71332F47365A6E39716651503633364857646A2F57663676384176672B673835743678324B766C723836762B5573767638416E6A2F795A697A7264422F64442F4F2F33556E694F30763736582B622F7549766366795A646E3871574A6272535566514A5A414D304F762F414C302F442F6368365873302F75592F35332B376B7A544D42325473566648486D763841343639372F7741'
		||	'784D332F45327A74385030442B7248376E7A335039637636307639302B774C446133692F31462F566E465335766F454F515638697965572F38354666386343442F414A6A452F774354633262667376384176442F552F77423946306E624839325036342F334D306A2F414F6361662B6C6E2F7742472F77447A50792F74582B482F41447639363476597638582B5A2F7633743261463656324B7649762B636A792F364D737750736575612F50696550384178746D36374C2B6F2F7742563048625030442B742B684C502B63613355507153483752454248794872562F586C766176385038416E66373170374650316635762B2B65345A6F48705859712B532F7A51554C356C314141552F66452F666E5A61542B376A376E6739642F65792F7250704C38756A58793770316638416C6D6A2F414F496A4F57315839354C2B73587364482F64522F71686B57597A6C757856354A2B5976354844576268395430523068754A44796B69665A47623970305A5165444E2B304F50466D2F6C7A63365874446748445063667A6E51367A737A78447851394D76346F2F77764B64542F4B377A4A706C576C735A57432F7452556B487A2F63383833454E5A6A6E79492F774137302F3770305539446C687A696638333166376C5430623877504D486C32586842637971454E44464B53792F36706A6B2B7A2F73654C59636D6D78355275422F57696A487138754937452F315A5064664B2F7743617161396F4E37716363617066324544795352456B7153714D364D7637587076772F77425A662B425A75667A61507738676A2F424D2F55394E67312F693435532F6A78784A3466672F2F39623154697273560A64697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972796A2F6E494C7975392F70305772774C56374D6B5355362B6D3950692F324468662B44624E78325A6D345A474A2F6A2F33546F753173484645544838482B356B78443867764E38656C36684A70463033474B3970365A5051537230582F6E7176772F36796F755A766157446A6A78442B442F41484C722B797451495334442F4839503966384134382B687335703631324B764E5038416E494C2F414A5231662B596D502F694D6D6258737A2B382F7A53366274622B362F774134667059352F774134302F3841537A2F364E2F38416D666D5432722F442F6E663731772B78663476387A2F66766273304C30727356664A50356C33386C39356A31435355314B7A7647506C476653582F68557A73744A48687878722B622F7576553846725A6D575752503837682F77424C3658307A35457349724851724743'
		||	'415551573862664D736F6B6476396B374D326372715A475579542F4F4C32656C6749343467667A516E7559376C506C7A383635784C3570757774434545533142384930722B5077353175674659683866384164504539704738782F7741332F6368394665535634614670796767307449425564442B37544F5A314831792F72532F335431756D2F75342F31492F376C4F636F636C324B757856324B704835303875576576365A506133714B51455A6B636A6447412B4752472F5A706D5267796E4849454F4C71634D6373434A663949766D4438765A5A492F4D4F6E4E46396F33555150794C42582F34546C6E57616B586A6C663830764636516B5A59312F50692B753834743735324B757856324B757856324B757856324B766E332F6E49332F6A72327638417A44663862766E53646C2F5166363336486C4F3250724839582F6650532F79562F7743555473662B65332F4A36584E56722F37302F7743622F75597535374E2F75592F35332B376B7A664D423254786A2F6E4A502F6566542F7744586C2F56486D38374B35792B447A7662504B5038416E666F52332F4F4F582F4849757638416D4A2F343054496471665750367636577A736636442F572F3372316E4E4D3735324B766A4C5572743956314357356E4A4433457A4D7850626B33384D376945654349412F684435334F5848496B2F78536659396C5A7857554564724176474B4A51696764676F34726E45796B5A47792B6852694969683056736979664966356779724C3567314234794755334D74434F6E326A6E616159566A6A2F56447747724E355A66317050727A4F4C652F646972735665436638354966373332582F47460A2F7744695764463256394A39377933625031522F71732B2F49332F6C4637662F414635662B4A746D7537512F7654385075647032582F636A2F4F2F33545063317A745859713746587A372F7A6B622F783137582F414A68762B4E337A704F792F6F503841572F513870327839592F712F373536582B537072355573766231762B5430756172582F33702F7A66397A4633505A76397A482F4F2F7742334A6D2B5944736E69502F4F534E2F433331437A56675A313952325875465042564A2F31754C6638414135762B796F6E314833504E64737A4870485864505038416E48582F414934452F77447A47503841386D3463782B3150377766315039394A7965782F37732F312F7744657865705A7148654F78566758353566386F7663663638582F41424E6332505A2F3936506A397A71753150376B2F7743622F756D412F77444F4E2F38417666652F3859552F346C6D7837562B6B65393166593331532F717665383531366C324B7578563879666E726676632B5A356F58507732386355612F496F'
		||	'4A762B4A53746E56396E527245442F4144722F414F4A654C37556E65596A2B62776A374F4C2F6650597679567349725879786176454B4E4D586B632B4C633254384552562F324F615458794A796E796568374E67493452583856792B316E4F6139326235342F35794B6E443635627843683457716B2F4D764A73666F7A7065797836442F572F51486B7532442B38412F6F663736543150386D553465564C45416737536E62336C6B50345A7164662F4148702B482B3544752B7A66376D502B642F75704D307A41646B3746586C762F41446B562F77416343442F6D4D542F6B334E6D33374C2F76442F552F3330585364736633592F726A2F637A53502F6E476E2F705A2F774452762F7A50792F74582B482F4F2F7742363476597638582B5A2F7633743261463656324B757856324B757856324B757856324B766E332F6E49332F6A72327638417A44663862766E53646C2F5166363336486C4F3250724839582F66505250794D594879766267486F386F502F4141625A724F305037302F44376E62646C2F33492F7741373732665A726E6173522F4E6A5630307A79336575786F30305A6755654A6B2F642F7744454F626637484D3352513438673876562F705841312B546778532F70656A2F5476452F794B307072337A4A464F42564C564A4A475062646653582F68704D3376614D2B4847522F4F6562374C78385755482B5A637639362B6D733556374E324B76465038416E4A4B2F6B4357466B44534E6A4C497738534F434A2F77504E2F3841677333335A55667150756562375A6D6654482B744A6638413834335745586F3331365257626B6B595067744335412F316D2B312F7172670A37566B624154324E41564B587569396F7A525052764A2F38416E4932634C6F397244555661354455372F436B672F77434E3833485A59395A503948394C6F75324436415036662B394B442F3578756A7061583731367952696E79446638315A5A327164342F4672374748706C3777396B7A5276517578566A7635692F386F3771502F4D4E4A2F7741527A4A30763935482B734845316E39314C2B7158676635472F387052622F7743704C2F784273365074442B3650772B39355873762B2B482B642F755830396E4A7661757856324B7642502B636A373252722B79744366335351744942377333452F68486E52646C78394A506D3874327A493855522F525A4A2F7A6A72703855656A3346346F426D6C75436A48767852554B4C2F7955647638415A5A693971534A6D422F52637A736541454365706C2F7558712B6164337278622F6E4A4F52665230394B6A6C796C4E4F394B523576657968764C2F4E2F5338353279646F2F7743642B684E662B63644541304B34667562747839306350396370'
		||	'37552B7366315039394A7637484837732F7742662F657865715A7148654F7856324B757856324B757856324B714E392F76504A2F714E2B724A5235735A63692B557679752F7743556C302F2F41497A4439527A72395A2F6479397A7732682F76592F316E316E6E485064757856324B734C2F4F4C5357314C79316472474B7643466D487951386E2F414F5366504D37517A346367382F53363774484878346A2F414566562F7058692F77435275724C702F6D534A484E467559336872376D6B692F77444250457135766530496357502B72366E6E4F79386E426C48394D6350342F77424B2B6E4D35523752324B766B76387A74555456504D643964524771657277423866544377312F77435365646C704963474D44792F33587165443132546A797949372F7744632B6C394A666C33706A365A356673625755556459565A676578663841654666396A7A7A6C3956506A79452B62324F6A6877596F672F7741316B5759726C757856386D2F6D6A704C615A356A766F57464138706C5877704A2B39322F34506A6E59364F66486A423875482F537643613748775A5A447A34763950366E3076354A3165505639467337324D3875634B42765A6C48435266396A4972444F5731454F435A486D396C707367795934794838314F3878334A6556663835467A494E45746F69773952727457433979466A6C44482F4147504E662B437A63646C6A316B2F3066393946306662422F646766302F3841657953622F6E476E2F705A2F39472F2F414450793774582B482F4F2F33726A64692F7866356E2B2F65335A6F587058597138362F506A5347762F4C7254494B746179704B66486A7645332F4A7A6C0A2F736332665A302B484A583834634C714F3163664669762B59654C2F652F373535312F7741343936717472726B746D356F4C6D456866646B49662F6948715A732B303458432F3570645232526B34636848382B503841755830566E4D76584F4A7075656D4B766A7A7A667151316257627939692B4A4A70334B553772792F642F384143386337624244676741656B587A3755543854495A442B4B526657506C6E546A706D6C326C69776F3045456362664E5643742F773263646D6C78794A2F6E534C336543484241522F6D78435A5A55334F7856324B757856356E2B66486C797A7574446B31566B566275325A4F4C67414D775A6C694D62483970666A352F7743787A61396E5A534A3850384D6E53397134597978386638554B2F77434A65532F6C6A4C497636585250734E704E3179487943304F626E566A36662B477764466F6966582F776D622F2F312F564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B'
		||	'757856324B757856324B757856324B757856324B757856324B724A3445754932686D555047344B73703342424647552F50434457345152596F766D373879767969752F4C737233326D4B302B6D6B6C716A646F76386D542F4948374D762F422F3558556154576A4B4B6C365A2F3770342F57396E79776E696A3673662B342F4838357679742B657573364E477474654B74394375774D68496B41385057484C6C2F7A3052322F774172484E326443653439482B352F3071344F314D6D4D564C39345036583166365A6C342F357952744F46545953632F443142542F6775502F47755958386C482B64396A7350355A6A2F4E507A59482B5948357433766D2B4557545170623269754834676C6D4A46514F5568342F7A66736F75624454614B4F453366464A31657237516C7142773177785A392F7A6A70704E33615158313163525048445036507073776F47342B727A3456366763312B4C4E6432704D4567412F5478663731326E592B4F5552496B62533465482F5A505973306A304C7356664E6635332B554A394A3169545530516D7A76547A446A6F48702B386A622F4143696633692F35502B7132645432666E4534635038555039793864326E707A6A7963583847542F41485366666C352B655674704F6E783658724D556A66563134527978674E565239684852696E32462B486B75592B7137504D3563555034756A6B365074515934694D776654394D6F6F337A542F7741354451744330486C2B422F57635545737741433137704770666D3338764C6A3858374C355868374D4E334D2F357357335032754B72474E2F353076384169586C486D58793571756C6947393168485637344E0A4B433965524E6669395376535439766966353833474C4C4764695038487064466D777A6855702F355431506F44386C764E7936356F79575A526C6D734653466952384C41436B58427648677678722F414D315A7A6D767765484F2F352F716572374E314869343636342F542F77415339417A577531575845766F78744C784C38564A34714B6B3048325648383245433045304C664F6C702B642F6D445364516E4E38676B69615269626555465448552F7742326A553570782B7A386650384131633661585A2B4F6352582B6E6A2F45386A4874504C6A6B654C762B6958384C4E37482F414A794C3065525239627472694A7A313438485566374C6C47332F435A6753374C6D4F5269374B506245447A456838704D623839666E79757132636D6E614C444A4373796C486C6C6F47436E37536F6946774F58382F504D7254396E634234706D362F686934657137563434384D4277385838556C7635462F6C2F63584634766D473951706251672B6879464F626B6365612F3856786A39722B66375032'
		||	'5777396F366B4163412B6F2F562F5252325870435A654A4C36592F522F53652B357A6A315473566469727356646972735664697273566650762F41446B622F77416465312F35687638416A64383654737636442F572F513870327839592F712F373536582B53762F4B4A325038417A322F35505335717466384133702F7A66397A4633505A76397A482F41447639334A6D2B5944736E6A482F4F536638417650702F2B764C2B71504E3532567A6C38486E6532655566383739434F2F3578792F343546312F7A452F384147695A44745436782F562F5332646A2F4145482B742F7658724F615A337A7356664B50356E2B554A764C657354526C434C575A326B67616D78566A7934562F6D697277622F677632733744535A786C675035772B703458586163345A6E2B624C31512F483946365235532F3579437334374E4C6658497066724D616866556941595054626B775A6C5A582F6D2B30762B72396E4E586D374D4A4E774934663654754E5032744552715950462F4F6A2F4567664F50353879367047644F3874517978764E384871742F656237635959342B644762396C2B584C2B564F6557594F7A6841385751387634663466383571314861706D4F48474436763476347638313562356A3873332F6C3664626256497A484C4969794145313262332F6D422B467638724E76697978794334756B7A594A596A5576367A36672F4C7A7A65766D6E536F37344936534C534F546B4E69366763796A667471633550565950426E5432756A31486A774576394E2F575A4E6D4935727356654A6638414F53476C536E366A714B715445764F4A7A32424E486A2F344C39352F774F6237737159330A6A2F6E504E3973347A365A652B4B562F6C5038416D37592B573741365671715363466376484A4741774162375375745166746646384F58617A52537979346F74476737516A686A77547638416F7656664A76356C61623574754A7262546C6B426756574A6B414849456C6668415A6A3850772F612F6D7A5435394A4C43415A66784F38303274686E4A4562395065797A4D4E7A33597138592F77436369664C55303864747255436C6B6842696C70767842504B4E2F7744563563315A7639544E3732586C417542362B714C7A766247456B43592F68394D763936773738742F7A656E3870516E5437694836785A466977414E48516E375848396C6C2F7950384168737A64566F686D504544777964646F2B30446748435278512F32544D64612F35794E742F524B3654614F5A794E6D6E4943716648684757352F3841424A6D466A374C4E2B6F2F3656324F58746756364276384130336C3270615272577432632F6D792B4453516D525661567632755656716736656C47334750346668586B714C'
		||	'6D32684F474D6A47506B365365504A6B69637375562F562B5034586F6E2F4F4F766D4E5970626E51335671792F763059436F4255634A41352F5A3234636558772F732F615A63316E616D4B774A2F357274757838314577372F5739307A6E3370335971774C3838762B55587550384158692F346D756248732F38417652386675645632702F636E2F4E2F335441662B63622F393737332F414977702F7741537A5939712F535065367673623670663158766563363953374658597138472F357943386F547064703567675574627949736378472F466C2B4647622F4143585869763841724C2F6C726E51396D5A7858416566384C792F61326E496C34672B6E6C4A41666C622B6355586C6D302F52577152764A617178614E3436466B35664579464734386C35664639722F41494C4C645A6F546C504648366D6E51396F6A4448676B50542F4477737031372F6E4971776A684B36526279537A6B6247594255552B34566D642F3958345039664D50483258496E3148622B69353258746949486F424D76365830764A664D656B613363514C356D3164484B587368416439695453716E6A2B7A47792F7742312F6B703850773863334F4B634166446A2F4136484E6A7945654C502F4143682F482F485872332F4F502F6D3162757762514852765574655569754256536A4E79347333374C2B6F376636792F36725A706530734E53342F357A30485A4F6F346F2B482F4D2F77427939627A544F2B6469727A502F414A79447335626A79386B6B53315747356A642F5A654D6B646638416735457A61396D534179652B50366E546472784A7862667779482B2B655A2F6B392B59567235536E7549720A324E6D6A765053484E616643564C4372637166425358663841316332757530787A41562F426270657A74574D42496C2F48772F6A2F41475436597A6C58733359713746585971374658597137465859712B666638416E49332F41493639722F7A44663862766E53646C2F5166363336486C4F3250724839582F41487A45764B586D7A572F4A596A314331552F55726B6E3458424D556E45384736665A6C576E3750782F37444D7A4E68686E394A2B71502B6D6934476E314754542B6F6652503841306B762B50505459762B636B4C49773870624755542F7971366C662B442B46762B5365616F396C53766D48636A746D4E62784E764E764F6E6E3356505064314841553478427151323864572B493756502B2F4A50326138663956562B4C4E70673030644F4C2F30303354366E567A3152412F3073492F6A366E756635542B5144355330386D366F622B356F30744E2B494832496766386A39722F4C622B586A6D673175703861573330522B6C36625161547749372F584C36762B4A5A786D7664'
		||	'6D3746586D3335352B554A396430714F3773314D6C785A4D7A634275536A4165727848646C34492F2B71725A744F7A383478796F38702F3770302F616D6E4F5746782B72482F7566346E6B5035592F6D4D2F6B79366B61534D7A576C77414A45553059466673794A58626B4F5466442B312F4E6D3631656C386364306F7650364C57666C7A76366F792B70366E652F383545614A48455774594C69575873724255482B79666D39503969725A7149396D544A334D5865533758786762435265586559626A582F507133486D4761492F55374E64677451694C55636B692F6E6366336B7A66792F61342F75307A6234686A3039514831542F482F534C704D787961713868486F682F706638332F41487964666B4C357558536453665370555A3176796755714B3858586C396F66794657626D333748486C396E6C6D50326A67343438512F67636E73725563452B412F35542F64506F764F5A657564697248667A462F7743556431482F414A6870502B49356B36582B386A2F574469617A2B366C2F564C7750386A662B556F742F3953582F41496732644832682F6448346665387232582F66442F4F2F334C36657A6B33745859713746586B6E352F38416B2B66557257485762525337326F5A5A56417166544F34662F6E6D3332763841583566733575657A63346954412F7866542F5764443274707A4D43592F672B722B7138392F4B7A383044354F655332756F326D735A694749536E4A5747334E4F5646626B76326C717632562B4C2B625A617A536550754E7068314F683133356577665643543062552F77446E496E52346F696243436561627348436F762B79626B3766636D6179485A630A79647A454F336E327841443069556A2F70586C506D4E646638414E6B4D336D792B6A4A7459797163674B4B6F4A6F71784C2F41434933326D2F6E623476697A63597644776B597839546F7333695A77637376702F4830737A2F35783938334C61547936424B6A4E395962315932555641594C5354315035564B716E785A673970344C4847503466533748736E55634A4F4D2F7865714C33724F6465706469727356646972735664697273565754522B716A526E594D43507677673067693379427031316365564E5A5361525033396A503841456832715550784C2F73763573375751476146644A78665034534F444A5A2B72484A37702F774244422B582F4145665634584871663737344C57762B747A345A7A2F38414A6D532F3458702F355878566671656B5756326C354248637862704B697576795963686D726C48684E4F346A4C694149367132525A4C5A49316B556F34444B77494950516734516151526235622F4D50794C656553745345397679466F7A3837655966736B486B73624E2B'
		||	'7A4C482F772F7742764F7430756F47654E48367634347645367A537930303748306677532F4838544F2F4C6E2F41446B584573496A3179326379714B47534469655875596E4D66442F41474C357238765A5A7630482F544F7A77397343716D503836482F456F587A6A2F774135424738746E744E42686B686151554D3070415A516639396F6863637638766E385038755377646D634A755A762B6A4668714F317549566A48442F536B787238702F774174702F4D31346C2F646F52706B4C636D5A76393245663771542B62662B38622B582F4B7A4C3175714749555072502B786350516149357063522F75342F375038416F2F384146507072706E4B505A757856324B764D767A6F2F4C69587A48416D703661764B2B7431346C42316B6A3638522F6C786E346B2F6D354E2F6B3574644271686950444C364A6637475470653074476377346F2F58482F5A5265536552767A4C31507955373279703674737A5665435371305962456F663931762F4E38502B787A63366A53527A372F78667A6E513658577A3032334F503879544E37762F414A79546B614F6C727036724952316559734166395659303566384142726D42487372766C2F73663275796C327961326A2F73762B4F764F664D4E3972666D6C4A504D4F6F386E74343245664F6C455574396D4B49663841457638416B7038545A744D5559597652486E2F736E555A705A4D39354A6654395039482B7246364A2F77413432584B724E714E7566744F734C44354B5A46502F4143637A5764716A614A2F72666F6474324E4C65512F712F3735376E6E5076547578565276624F4B2B676B74626851384D716C4855393159635747536A0A49784E686A4B496B4B505638736562664B6D7065514E5757534E6D436F2F4F3275414E6D414F31663265612F774337492F38416A52733637446D6A71496637754C772B6F775430733976387962306A517638416E4932314D4958576257515441627462385756766668493066442F67337A56354F797A6670503841706E6359753242587242762B682F78354A7650663538747131712B6E364C433845636F4B764C49527A346E37536F69636C546C2F507A622F414750327376302F5A3341654B5A3476364C6A36727458784277774844663841464C366B4A2B544835617A617464783633666F56735947447868682F6575443850482F6974472B4A6D2F612B782F506B3966716841634566726C2F735776733352484A4C6A6C394566702F707966524F6379396337465567382B61766461546F317A64366647387479456F675253784250772B705166737866622F324F5A4F6D674A7A416C394C6936724963654D6D497558342F334C7858797638416E3971756D71494E566A4637474E75525043'
		||	'51664E6743722F774379546C2F6C357663335A735A627839482B35656277647254687450384165663747624E6F502B636964435A4B797758534F4230436F522F7357395566384E787A41505A632B2B50322F71646B4F324D6655542F32502F46504F767A4B2F4E6D627A676936666152474379566733456D72753337504C6A734648386E7866462B316D7A306D69474831453855763979366A573638366A3067634D50396C4A6D586B5038757272522F4C4F70336C334577763736306D534F4B6E78717642754363667465704B2F37482B702B316D447164554A3549676652436366563858593658526E48696B5350586B684C302F35762B2B662F394431546972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697246395A2F4C4879377244475736736F2F5550566F36786B6E785070464F582B797A4C7836764A446B6639383457545134736D356A2F414B58302F7743355352667948387367314D637048675A54544D6A2B55636E6C386E472F6B724633482F544A396F2F3562655874495953576C6C454858634D344D6A412B49615575562F324F593039566B6E7A4A2F77427A2F75584B78364C466A3552482B362F33544A6378584D6469727356554C3278677634577472754E5A59584647527743443877636C4752696244475552495564777769372F41434F387358446D525948697232535271666378624D2B50614755646673645A4C737643656C66464E504C33355961426F4567754C4F31557A72306B6B4A6467664665660A776F6639525679724C71386D54596E5A7677364848694E6765722B6C366B3238782B5772487A46616D78314B4D53524531485971522B306A4464572F7A2B7A6C4F4C4C4C456269333573456377345A42336C6E79315A2B57374A4E4E303953496B716174757A452F616432327178787935546C6C78535842686A686A777854544B5739324B705A72586C6E544E62586871567446505459463142596636722F62582F59746C75504E4C48394A34576E4A67686B2B6F435445702F794B38735374795747534D6679724B31502B48356E4D30646F3552312B783135374C776E6F66394D6A64492F4A2F7931706269574F314573696D6F4D7A462F774468472F642F384A6C6339646B6E74663841705733483264696876562F3176557A4A5643674B6F6F4273414D77585974347137465859713746585971374658597137465573316279787065734D736D6F32734E7736436761524178412F6C3548656D57777A5368394A4D576E4A67686B2B6F526B6939503036333032426253796A5747424B3855'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'51555556504930482B7363684B526B624F355A776749436F6A6869694D697A515770614A59366F4658554C65473543564B69574E58705872783568715A5A444A4B48306B782F71746338555A2F5549792F72446958616270466C7061474B776769743059386973534B674A2F6D49514C76676E4D7A2B6F6D58395A59593477326942482B723655586B4778324B6F50567447733958674E7271454B54776E666934714B2B492F6C622F4B584A77794742754A3457764A6A6A6B465348454746542F6B5635596C626B734D6B5938466C616E2F44386A6D654F30636F362F593630396C345430502B6D5A4235632F4C3752504C6A657070747371532F3738596C332B68354F52582F414748484D624C715A3566714C6C34644A6A773778482B637638322B53644E3831774333314B4D6B70557049706F36563638472F3431626B762B5467776169574533464F6F30304D3471587A2F695450534E4B74394A745972437A586842436F56522F6E2B3033326D7971637A4D3852356C757834786A6949782B6D4B4C7944593746555071476E572B6F775061586B61797753436A497771446B6F794D54595954674A696A754741335035422B57356E4C6F73385150374B5362442F6B5972742F7732624564705A422F4E2B547135646C596A2F4F48785A4C35573867365035584C507063504356787861526D4C4D523134315937442F414663786332706E6C2B6F755A67306B4D5030686B4F597A6C757856624E436B794E464B6F644742444B7771434431424277673179515265785946716635472B577236517972464A626B376B525052662B42666D462F324F62474861475349712B4C2B733675660A5A654B527575482B7176306E386B664C576E7943557774634D4E774A6E35442F67463449332B7A5673452B304D6B74723466367163665A6D4B4275754C2B737A5366547265653361796C6A56725A6C34474F6734386155343866444D4153494E2F784F784D4152776B656E755366796835463033796E484A48707145475A697A4F357178466667546C2F4A482B7A2F7733785A666E3145733331644848302B6C6867423466346D515A6A4F573746554A71756B577572323757642F4773304445456F3351304E526B34544D4463646931354D59794370446969673945386F36566F62744A706C736B4479436A464F344754795A355A507150453134745044467645634B6235533544735664697132574A4A6B4D6371686B59454D72436F495055455951615152657859527150354B655762317A4C39574D4C48632B6B374B503841674B6C462F774269755A3864666C6A31762B733632665A7547573963503955712B692F6C443562306D515478576F6C6C5531426D5976542F41474466752F3841'
		||	'684D6A6B31755359712F3841537373665A2B4C476241762B74366D543672704672713173396A66526957336B4647552F352F43522B79792F5A7A45684D774E6A6D357554474D67345A433470623552386C36643555676532303157416B63757A4F6173663556356266436E37482F4E584C4C632B6F6C6D4E79616450706F344255657165356A75553746566B397648635274444D6F654E775179734B676739694468427263494942464668622F6B7435576162316A6155337278456B67582F676566384177755A33352F4C5658396764622F4A75473772375A4D316A6A574E5169436971414150595A676B323749436C32424C73566469727356646972735664697235392F7743636A6638416A7232762F4D4E2F78752B644A325839422F72666F655537592B736631663841664D382F4A3354726255664B4D467465784A4E437A7931523144412F47335A733132756B5935535274792B35326E5A304250414249635139582B365246332B52336C693463794C4138566579534E542F414959746B59396F5A52312B786C4C737643656C6646502F41433535443062793465656D5779527945554D68717A2F386A4A437A44354C6D506C314D3876314679384F6C78346670482F464A2F6D4D355473566469727356596C727635552B5864616B4D397A61684A6D4E5338524B456E785A552B426A2F414A544C6D626A316D544873442F706E41793644466B4E6B622F306653674C48386B504C46724A366874326C493643535269502B425572792F77426C6C6B75304D703631384771505A6D474A75754C2B7357625157554676434C57474E55675563516971416F48387648374E4D7744496B320A585A4349416F636D5065587679333062792F6679366E70385253615563614531564154567653422B787A2F612B4C2F4A5469755A4F5856547952455A483866306E4577365048696B5A524850384132503841565A506D49357273565562327968766F5874626C524A444B70563150516739526B6F794D54595979694A436A79536A5376496D696152634C6557467048444F6F49447144555646446C3039524F597152734F506A30755047626942475365356A755537465859713772697244645A2F4B44793371736A5479326F696C6263744578542F684650702F384A6D646A31325347312F365A313254732F464D32525839583071476D2F6B72355A735A424E39574D7A4131416C646D582F6750734E2F7331624A54312B575731312F565977374E78524E317866316D5A79574D456B4274486A5532374C774D644278343034384F50546A544D4553494E3958596D4949722B4649504B763565615435586E6E75644E6A4B765051486B655846522F7575507571567A497A6171655541532F6863'
		||	'58426F34595354482B4A6B7559726D4F7856324B757856324B757856324B7578566A486D6E38747445387A5036312F422F70464B65724753722F774379342F432F2B7A567379384F716E69326964763572685A39466A7A627948712F6E4A465A2F6B4E3561743335756B307748374D6B68702F7954455A7A496C326A6B506350673473657973512F6E532B4C304331746F37574A4C6542516B55616845556441716A69716A35444E615353624C745978455251564D444A324B714E355A515873545739314773734C696A4934444B52377132536A49784E686A4B496B4B4F345948662F6B543561753544496B6373466632593544542F6B70366D624350614F51643076673675665A654B523547503955716D6D666B643561735A424B304C33424271424B35492F34464F43742F73755743666147535858682F717068325A69696272692F72466E634D4563434C46436F534E5252565555414867414D31354E376C3267414777583445757856324B7578564A4E63386B364E727035366C61525453644F5A46482F35474A78662F4149624D6A48714A342F704A446A5A644E6A792F55424A4B6258386F504B3173346B6A73564A483837794F502B426B6431793436374B65762B356149396E34593738502B366C2B6C6B56356F4668655766364E6E676A617A32487063514632504A614B76536A5A697879536965494831667A6E4C6C696A4B50435236503571453058795A7047695447353032315343566C4B466B725571534478362B4B35504A6E6E6B465350453134394E444762694F464F736F636C324B75785644616A706C7271634C577439456B304C645563416A38636E435A6762477A0A4363424D56496351594A65666B4E35617548356F6B304950374B53476E2F4A5153484E68487448494F342F423163757973522F6E522B4B4B306A386C504C656D79436230477548553148724D57482F4141413478742F7331624954312B535731385039566E6A374E78514E3178663132636F696F6F5241416F4641427341426D76646D4254654B58597137465567317A79466F65754D5831437A696B6B5056774F4C6E35795238482F34624D6E48715A342F704C6935644A6A792F5541787476794738736B6B694F55447745707A4B2F6C484A35664A7776354B7865663841706B2B3876666C786F506C39784E5957716959644A484A64683771306862682F734F4F593258565A4D6D30693565485234385738527638417A76715A4C6D4B356A2F2F5239553471374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971'
		||	'37465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746585971374658597137465859713746587A372F7A6B622F783137582F6D472F3433664F6B374C2B672F317630504B647366575036762B2B65692F6B622F414D6F76622F3638762F45327A57646F6633702B48334F32374C2F75522F6E6637706E75613532727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469722F2F3076564F4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856320A4B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856324B757856344E2B6676702F7079303962302B4831622F6476506A39742F77446648377A4F69374E2B67312F4F36563366306E6C2B316138515858302F78635838372B67394B2F4B66306638414438483162306654724A5430505634666161762B3966372F414A667A637638415966426D71316C2B4962762F414475482F70333658636143764346635058364F4C68352F375A36325835684F77646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356646972735664697273566469727356662F396B3D3C2F496D616765446174613E0D0A202020'
		||	'203C2F456D626564646564496D6167653E0D0A20203C2F456D626564646564496D616765733E0D0A20203C5061676557696474683E3231636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D2247454E4552414C5F4441544F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4449474F5F46414354555241223E0D0A202020202020202020203C446174614669656C643E434F4449474F5F464143545552413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F45585045444943494F4E223E0D0A202020202020202020203C446174614669656C643E46454348415F45585045444943494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434C49454E5445223E0D0A202020202020202020203C446174614669656C643E434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E49545F434C49454E5445223E0D0A202020202020202020203C446174614669656C643E4E49545F434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E544143544F223E0D0A202020202020202020203C446174614669656C643E434F4E544143544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444952454343494F4E223E0D0A202020202020202020203C446174614669656C643E444952454343494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E'
		||	'53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434955444144223E0D0A202020202020202020203C446174614669656C643E4349554441443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F5252454F223E0D0A202020202020202020203C446174614669656C643E434F5252454F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2254454C45464F4E4F223E0D0A202020202020202020203C446174614669656C643E54454C45464F4E4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F56454E43494D49454E544F223E0D0A202020202020202020203C446174614669656C643E46454348415F56454E43494D49454E544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E47454E4552414C3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C446174'
		||	'61536574204E616D653D22444554414C4C455F4441544F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4449474F223E0D0A202020202020202020203C446174614669656C643E434F4449474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E434550544F223E0D0A202020202020202020203C446174614669656C643E434F4E434550544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243414E5449444144223E0D0A202020202020202020203C446174614669656C643E43414E54494441443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F52223E0D0A202020202020202020203C446174614669656C643E56414C4F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525F544F54414C223E0D0A202020202020202020203C446174614669656C643E56414C4F525F544F54414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A4461'
		||	'74615365744E616D653E444554414C4C453C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4441544F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2247454E4552414C5F434F54495A4143494F4E223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22464F524D415F5041474F223E0D0A202020202020202020203C446174614669656C643E464F524D415F5041474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D4F5449564F5F56454E5441223E0D0A202020202020202020203C446174614669656C643E4D4F5449564F5F56454E54413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E47454E4552414C3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E434F54495A4143494F4E3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2247454E4552414C5F544F54414C223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525F495641223E0D0A202020202020202020203C446174614669656C643E56414C4F525F4956413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E5374'
		||	'72696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525F544F54414C5F5041474152223E0D0A202020202020202020203C446174614669656C643E56414C4F525F544F54414C5F50414741523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E47454E4552414C3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E544F54414C3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22444554414C4C455F495641223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4449474F223E0D0A202020202020202020203C446174614669656C643E434F4449474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E434550544F223E0D0A202020202020202020203C446174614669656C643E434F4E434550544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243414E5449444144223E0D0A202020202020202020203C446174614669656C643E43414E54494441443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472'
		||	'696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F52223E0D0A202020202020202020203C446174614669656C643E56414C4F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525F544F54414C223E0D0A202020202020202020203C446174614669656C643E56414C4F525F544F54414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E444554414C4C453C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4956413C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F6465202F3E0D0A20203C57696474683E362E3539353331696E3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E302E31696E3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A20202020202020203C546F703E3138636D3C2F546F703E0D0A20202020202020203C57696474683E342E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54'
		||	'657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56414C4C454455504152202D20434F4C4F4D4249410D0A43414C4C452031362041204EC2B0202034202D2039320D0A54454C454641583A2035383433343334202D203538353037353120353834383135340D0A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A20202020202020203C546F703E3138636D3C2F546F703E0D0A20202020202020203C57696474683E342E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3735636D3C2F48'
		||	'65696768743E0D0A20202020202020203C56616C75653E53414E5441204D41525441202D20434F4C4F4D4249410D0A41562E20454C204C494245525441444F5220204EC2B0203135202D2032390D0A5042582034323136383439202D2034323136313138202D20343231363234390D0A46415820343231353335360D0A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A20202020202020203C546F703E3138636D3C2F546F703E0D0A20202020202020203C57696474683E342E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E42415252414E5155494C4C41202D20434F4C4F4D4249410D0A43415252455241203534204EC2B020203539202D203134340D0A5042582033333036303030202D20333631323439390D0A46415820333434313334380D0A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676532223E0D0A20202020202020203C53697A696E673E4175746F53697A653C2F53697A696E673E0D0A20202020202020203C546F703E342E3235636D3C2F546F703E0D0A20202020202020203C57696474683E302E3438363737636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263'
		||	'653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A20202020202020203C4C6566743E31352E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E362E3735313332636D3C2F4865696768743E0D0A20202020202020203C56616C75653E696D6167656E6C61746572616C3C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C5461626C65204E616D653D227461626C6532223E0D0A20202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E444554414C4C455F4956413C2F446174615365744E616D653E0D0A20202020202020203C546F703E31302E3437333534636D3C2F546F703E0D0A20202020202020203C57696474683E3135636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434F4449474F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434F4449474F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C'
		||	'2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321434F4449474F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434F4E434550544F5F31223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434F4E434550544F5F313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E'
		||	'0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321434F4E434550544F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2243414E54494441445F31223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E43414E54494441445F313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020'
		||	'2020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732143414E54494441442E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F525F31223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F525F313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D61744E756D6265722843646563284669656C64732156414C4F522E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A202020202020202020202020202020'
		||	'20202020203C54657874626F78204E616D653D2256414C4F525F544F54414C5F31223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F525F544F54414C5F313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D61744E756D6265722843646563284669656C64732156414C4F525F544F54414C2E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F52'
		||	'65706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538323031636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A202020202020202020203C536F7274696E673E0D0A2020202020202020202020203C536F727442793E0D0A20202020202020202020202020203C536F727445787072657373696F6E3E3D4669656C647321434F4449474F2E56616C75653C2F536F727445787072657373696F6E3E0D0A20202020202020202020202020203C446972656374696F6E3E417363656E64696E673C2F446972656374696F6E3E0D0A2020202020202020202020203C2F536F727442793E0D0A202020202020202020203C2F536F7274696E673E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020'
		||	'202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F642E3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761'
		||	'696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F6E636570746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D73'
		||	'3E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783331223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E552E4D2E3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020'
		||	'202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783333223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020'
		||	'202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E424153453C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783334223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020202020'
		||	'20202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E562E20546F74616C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538323031636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E352E3235636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E312E3136343032636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3235303031636D3C2F4C6566743E0D0A2020202020203C2F54'
		||	'61626C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E332E3330323931636D3C2F546F703E0D0A20202020202020203C57696474683E37636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3237363436636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E52C38947494D454E20434F4DC39A4E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E3631373732636D3C2F546F703E0D0A20202020202020203C57696474683E362E3734363033636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020'
		||	'2020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3934373039636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3530323635636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E49543A203839303130313639312D323C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2256414C4F525F544F54414C5F5041474152223E0D0A20202020202020203C72643A44656661756C744E616D653E56414C4F525F544F54414C5F50414741523C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31332E3735636D3C2F546F703E0D0A20202020202020203C57696474683E33636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C'
		||	'4C6566743E31322E3332393336636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D466F726D61744E756D62657228436465632843496E74284669727374284669656C64732156414C4F525F544F54414C5F50414741522E56616C75652C202247454E4552414C5F544F54414C222929202B2043496E74284669727374284669656C64732156414C4F525F4956412E56616C75652C202247454E4552414C5F544F54414C222929292C32293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2256414C4F525F495641223E0D0A20202020202020203C72643A44656661756C744E616D653E56414C4F525F4956413C2F72643A44656661756C744E616D653E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E31332E3132303336636D3C2F546F703E0D0A20202020202020203C57696474683E33636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566'
		||	'743E31322E3332393336636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D466F726D61744E756D6265722843646563284669727374284669656C64732156414C4F525F4956412E56616C75652C202247454E4552414C5F544F54414C2229292C32293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E444554414C4C455F4441544F533C2F446174615365744E616D653E0D0A20202020202020203C546F703E382E3539333931636D3C2F546F703E0D0A20202020202020203C57696474683E3135636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434F4449474F5F31223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434F4449474F5F313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020'
		||	'2020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321434F4449474F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434F4E434550544F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434F4E434550544F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020'
		||	'2020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321434F4E434550544F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2243414E5449444144223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E43414E54494441443C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C'
		||	'653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732143414E54494441442E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F52223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F523C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'20202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D61744E756D6265722843646563284669656C64732156414C4F522E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F525F54'
		||	'4F54414C223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F525F544F54414C3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D61744E756D6265722843646563284669656C64732156414C4F525F544F54414C2E56616C7565292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F'
		||	'5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538323031636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A202020202020202020203C536F7274696E673E0D0A2020202020202020202020203C536F727442793E0D0A20202020202020202020202020203C536F727445787072657373696F6E3E3D4669656C647321434F4449474F2E56616C75653C2F536F727445787072657373696F6E3E0D0A20202020202020202020202020203C446972656374696F6E3E417363656E64696E673C2F446972656374696F6E3E0D0A2020202020202020202020203C2F536F727442793E0D0A202020202020202020203C2F536F7274696E673E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020'
		||	'202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F642E3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E746578'
		||	'74626F78343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F6E636570746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F'
		||	'72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020'
		||	'202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E552E4D2E3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020'
		||	'2020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E562E20556E69746172696F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F'
		||	'6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E562E20546F74616C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538323031636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E352E3235636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F5769647468'
		||	'3E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E312E3739383934636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E323C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4761696E73626F726F3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020'
		||	'2020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E535542544F54414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783233223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020202020'
		||	'20202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783234223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F52'
		||	'5F544F54414C5F50414741525F31223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F525F544F54414C5F50414741525F313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D61744E756D6265722843646563284669727374284669656C64732156414C4F525F544F54414C5F50414741522E56616C75652C202247454E4552414C5F544F54414C2229292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E32'
		||	'34393939636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C496D616765204E616D653D22696D61676531223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E302E3137303633636D3C2F546F703E0D0A20202020202020203C57696474683E372E35636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E322E3332393337636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6C6F676F6764633C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832303C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E372E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E38636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4649524D'
		||	'4120592053454C4C4F2044454C20434C49454E54453C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783138223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831383C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E372E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4649524D4120592053454C4C4F2044454C20454D49534F523C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831363C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31332E3736343535636D3C2F546F703E0D0A20202020202020203C57696474683E332E3238393638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E67'
		||	'52696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E39636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E544F54414C20412050414741523C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831313C2F72643A44656661756C744E616D653E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E31332E3133343931636D3C2F546F703E0D0A20202020202020203C57696474683E332E3238393638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E39636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4956413C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D227465787462'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		14858, 
		hextoraw
		(
			'6F783130223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831303C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31322E3633343932636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E322E3836353038636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4C61207265736F6C756369C3B36E206465204772616E20436F6E747269627579656E7465203031323232302064656C2032362064652064696369656D62726520646520323032322E0D0A0D0A4573746120466163747572612070726573746172C3A1206DC3A97269746F20656A6563757469766F206465206163756572646F2061206C6173206E6F726D61732064656C206465726563686F20636976696C207920636F6D65726369616C20284C6579203134322F3934204172742E20313330293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22464F524D415F5041474F223E0D0A20202020202020203C72643A44656661756C744E616D653E464F524D415F5041474F3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E36636D3C2F546F703E0D0A20202020202020203C57696474683E37636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C'
		||	'2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D224D6F7469766F3A2022202B4669727374284669656C6473214D4F5449564F5F56454E54412E56616C75652C202247454E4552414C5F434F54495A4143494F4E22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A20202020202020203C546F703E352E3232333535636D3C2F546F703E0D0A20202020202020203C57696474683E332E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270'
		||	'743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3737363435636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E43656E74726F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A20202020202020203C546F703E352E3232333535636D3C2F546F703E0D0A20202020202020203C57696474683E332E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3237363436636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C7565'
		||	'3E52656D6973696F6E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A20202020202020203C546F703E332E3934373039636D3C2F546F703E0D0A20202020202020203C57696474683E37636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3237363435636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22466F726D61206465205061676F2022202B204669727374284669656C647321464F524D415F5041474F2E56616C75652C202247454E4552414C5F434F54495A4143494F4E22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78363C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E342E3537393337636D3C2F546F703E0D0A20202020202020203C57696474683E37636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020'
		||	'202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3237363435636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E756D65726F20646520416374613C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2254454C45464F4E4F223E0D0A20202020202020203C72643A44656661756C744E616D653E54454C45464F4E4F3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E372E3130353832636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020'
		||	'202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C64732154454C45464F4E4F2E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F5252454F223E0D0A20202020202020203C72643A44656661756C744E616D653E434F5252454F3C2F72643A44656661756C744E616D653E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E372E3735636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F5252454F2E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434955444144223E0D0A20202020202020203C72643A44656661756C744E616D653E4349554441443C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F'
		||	'703E362E34383831636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214349554441442E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22444952454343494F4E223E0D0A20202020202020203C72643A44656661756C744E616D653E444952454343494F4E3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E352E3835353832636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020'
		||	'203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321444952454343494F4E2E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F4E544143544F223E0D0A20202020202020203C72643A44656661756C744E616D653E434F4E544143544F3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E352E3232333535636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E544143544F2E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D224E49545F434C49454E5445223E0D0A20202020202020203C72643A44656661756C744E616D653E4E49545F434C49454E54453C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E342E3537393337636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F'
		||	'50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E49545F434C49454E54452E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434C49454E5445223E0D0A20202020202020203C72643A44656661756C744E616D653E434C49454E54453C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E332E3936313634636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434C49454E54452E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F4449474F5F46414354555241223E0D0A20202020202020203C72643A44656661756C'
		||	'744E616D653E434F4449474F5F464143545552413C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E302E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3637303634636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3635383733636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4449474F5F464143545552412E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2246454348415F45585045444943494F4E223E0D0A20202020202020203C72643A44656661756C744E616D653E46454348415F45585045444943494F4E3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31636D3C2F546F703E0D0A20202020202020203C57696474683E332E3637303634636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F7264657243'
		||	'6F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3635383733636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C64732146454348415F45585045444943494F4E2E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2246454348415F56454E43494D49454E544F223E0D0A20202020202020203C72643A44656661756C744E616D653E46454348415F56454E43494D49454E544F3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E312E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3637303634636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752'
		||	'696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3635383733636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C64732146454348415F56454E43494D49454E544F2E56616C75652C202247454E4552414C5F4441544F5322293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831373C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31636D3C2F546F703E0D0A20202020202020203C57696474683E332E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4C69676874477265793C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50'
		||	'616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3135383733636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4665636861206465204578706564696369C3B36E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831343C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E302E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4C69676874477265793C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E'
		||	'0D0A20202020202020203C4C6566743E382E3135383733636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E46616374757261204E6F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831333C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E312E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4C69676874477265793C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020203C44656661756C743E53696C7665723C2F44656661756C743E0D0A202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3135383733636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E46656368612056656E63696D69656E746F3C2F56616C75653E0D0A2020202020203C2F54657874'
		||	'626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E332E3331373436636D3C2F546F703E0D0A20202020202020203C57696474683E372E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4C69676874477265793C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3332393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436C69656E74652C204E69742C20436F6E746163746F2C2044697265636369C3B36E2C204369756461642C2054656C65666F6E6F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E372E3739353833696E3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E65732D45533C2F4C616E67756167653E0D0A20203C546F704D617267696E3E322E35636D3C2F546F704D617267696E3E0D0A20203C506167654865696768743E32392E37636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_59.cuPlantilla( 46 );
	fetch CONFEXME_59.cuPlantilla into nuIdPlantill;
	close CONFEXME_59.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'IMPRESION_FACTURA_SERVICIOS',
		       plannomb = 'IMPRESION_FACTURA_SERVICIOS',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 46;
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
			46,
			blContent ,
			'IMPRESION_FACTURA_SERVICIOS',
			'IMPRESION_FACTURA_SERVICIOS',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_59.cuExtractAndMix( 59 );
	fetch CONFEXME_59.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_59.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'IMPRESION_FACTURA_SERVICIOS',
		       coeminic = NULL,
		       coempada = '<66>',
		       coempadi = 'IMPRESION_FACTURA_SERVICIOS',
		       coempame = NULL,
		       coemtido = 66,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 59;
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
			59,
			'IMPRESION_FACTURA_SERVICIOS',
			NULL,
			'<66>',
			'IMPRESION_FACTURA_SERVICIOS',
			NULL,
			66,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_59.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_59.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_59.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_59.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_59 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_59'
	);
--}
END;
/

