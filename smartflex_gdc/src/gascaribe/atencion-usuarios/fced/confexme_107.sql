BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_107 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_107',
		'CREATE OR REPLACE PACKAGE CONFEXME_107 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_107;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_107',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_107 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_107;'
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_107.cuFormat( 125 );
	fetch CONFEXME_107.cuFormat into nuFormatId;
	close CONFEXME_107.cuFormat;

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
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_107.cuFormat( 125 );
	fetch CONFEXME_107.cuFormat into nuFormatId;
	close CONFEXME_107.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_107.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_CERT_ESTADO_DEUDA_PRODUCTO_A_FECHA',
		       formtido = 122,
		       formiden = '<125>',
		       formtico = 466,
		       formdein = '<LDC_CERT_ESTADO_DEUDA_PRODUCTO_A_FECHA>',
		       formdefi = '</LDC_CERT_ESTADO_DEUDA_PRODUCTO_A_FECHA>'
		WHERE  formcodi = CONFEXME_107.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_107.rcED_Formato.formcodi := 125 ;

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
			CONFEXME_107.rcED_Formato.formcodi,
			'LDC_CERT_ESTADO_DEUDA_PRODUCTO_A_FECHA',
			122,
			'<125>',
			466,
			'<LDC_CERT_ESTADO_DEUDA_PRODUCTO_A_FECHA>',
			'</LDC_CERT_ESTADO_DEUDA_PRODUCTO_A_FECHA>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_107.tbrcED_Franja( 4844 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [ENCABEZADO Y PIE]', 5 );
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
		CONFEXME_107.tbrcED_Franja( 4844 ).francodi,
		'ENCABEZADO Y PIE',
		CONFEXME_107.tbrcED_Franja( 4844 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_107.tbrcED_Franja( 4845 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [DETALLE DEUDA]', 5 );
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
		CONFEXME_107.tbrcED_Franja( 4845 ).francodi,
		'DETALLE DEUDA',
		CONFEXME_107.tbrcED_Franja( 4845 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_107.tbrcED_FranForm( '4687' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_107.tbrcED_FranForm( '4687' ).frfoform := CONFEXME_107.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_107.tbrcED_Franja.exists( 4844 ) ) then
		CONFEXME_107.tbrcED_FranForm( '4687' ).frfofran := CONFEXME_107.tbrcED_Franja( 4844 ).francodi;
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
		CONFEXME_107.tbrcED_FranForm( '4687' ).frfocodi,
		CONFEXME_107.tbrcED_FranForm( '4687' ).frfoform,
		CONFEXME_107.tbrcED_FranForm( '4687' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_107.tbrcED_FranForm( '4688' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_107.tbrcED_FranForm( '4688' ).frfoform := CONFEXME_107.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_107.tbrcED_Franja.exists( 4845 ) ) then
		CONFEXME_107.tbrcED_FranForm( '4688' ).frfofran := CONFEXME_107.tbrcED_Franja( 4845 ).francodi;
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
		CONFEXME_107.tbrcED_FranForm( '4688' ).frfocodi,
		CONFEXME_107.tbrcED_FranForm( '4688' ).frfoform,
		CONFEXME_107.tbrcED_FranForm( '4688' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - FUENTE DATOS - INFORMACION CERTIFICADO ESTADO DEUDA A FECHA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi,
		'LDC - FUENTE DATOS - INFORMACION CERTIFICADO ESTADO DEUDA A FECHA',
		'PKG_BOINFODATOSFORMATOS.prcDatosFormEstDeudaporProd',
		CONFEXME_107.tbrcED_FuenDato( '4007' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - FUEN - DEUDA DIFERIDA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi,
		'LDC - FUEN - DEUDA DIFERIDA',
		'ldc_bocertificado_estdeuda.proObtieneDeudaDiferida',
		CONFEXME_107.tbrcED_FuenDato( '4008' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - FUENDAT - DEUDA CORRIENTE A LA FECHA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi,
		'LDC - FUENDAT - DEUDA CORRIENTE A LA FECHA',
		' ldc_bocertificado_estdeuda.proObtieneDeudaCorriente',
		CONFEXME_107.tbrcED_FuenDato( '4009' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31694' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31694' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Diferido]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31694' ).atfdcodi,
		'DIFERIDO',
		'Diferido',
		1,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31694' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31695' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31695' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
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
		CONFEXME_107.tbrcED_AtriFuda( '31695' ).atfdcodi,
		'PRODUCTO',
		'Producto',
		2,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31695' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31696' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31696' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tipo_Producto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31696' ).atfdcodi,
		'TIPO_PRODUCTO',
		'Tipo_Producto',
		3,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31696' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31697' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31697' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
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
		CONFEXME_107.tbrcED_AtriFuda( '31697' ).atfdcodi,
		'CONCEPTO',
		'Concepto',
		4,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31697' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31698' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31698' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Desc_Concepto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31698' ).atfdcodi,
		'DESC_CONCEPTO',
		'Desc_Concepto',
		5,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31698' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31699' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31699' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Num_Finan]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31699' ).atfdcodi,
		'NUM_FINAN',
		'Num_Finan',
		6,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31699' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31700' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31700' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Fecha_Ing]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31700' ).atfdcodi,
		'FECHA_ING',
		'Fecha_Ing',
		7,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31700' ).atfdfuda,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31701' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31701' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cuot_Pact]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31701' ).atfdcodi,
		'CUOT_PACT',
		'Cuot_Pact',
		8,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31701' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31702' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31702' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cuot_Canc]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31702' ).atfdcodi,
		'CUOT_CANC',
		'Cuot_Canc',
		9,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31702' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31703' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31703' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Cuot_Pend]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31703' ).atfdcodi,
		'CUOT_PEND',
		'Cuot_Pend',
		10,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31703' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31704' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31704' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Valor_Ini]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31704' ).atfdcodi,
		'VALOR_INI',
		'Valor_Ini',
		11,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31704' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31705' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31705' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Sald_Pend]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31705' ).atfdcodi,
		'SALD_PEND',
		'Sald_Pend',
		12,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31705' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31706' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31706' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
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
		CONFEXME_107.tbrcED_AtriFuda( '31706' ).atfdcodi,
		'PRODUCTO',
		'Producto',
		1,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31706' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31707' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31707' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tipo_Producto]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31707' ).atfdcodi,
		'TIPO_PRODUCTO',
		'Tipo_Producto',
		2,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31707' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31708' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31708' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Tipo_Prod_Desc]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31708' ).atfdcodi,
		'TIPO_PROD_DESC',
		'Tipo_Prod_Desc',
		3,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31708' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31709' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31709' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
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
		CONFEXME_107.tbrcED_AtriFuda( '31709' ).atfdcodi,
		'CONCCODI',
		'Concepto',
		4,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31709' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31710' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31710' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
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
		CONFEXME_107.tbrcED_AtriFuda( '31710' ).atfdcodi,
		'CONCDESC',
		'Concepto',
		5,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31710' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31711' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31711' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Deuda_Fecha]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31711' ).atfdcodi,
		'DEUDA_FECHA',
		'Deuda_Fecha',
		6,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31711' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31712' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31712' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Deuda_30]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31712' ).atfdcodi,
		'DEUDA_30',
		'Deuda_30',
		7,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31712' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31713' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31713' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Deuda_60]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31713' ).atfdcodi,
		'DEUDA_60',
		'Deuda_60',
		8,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31713' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31714' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31714' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Deuda_90]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31714' ).atfdcodi,
		'DEUDA_90',
		'Deuda_90',
		9,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31714' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31715' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31715' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Deuda_Mas90]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31715' ).atfdcodi,
		'DEUDA_MAS90',
		'Deuda_Mas90',
		10,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31715' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31716' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31716' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Sald_Deud_Corr]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31716' ).atfdcodi,
		'SALD_DEUD_CORR',
		'Sald_Deud_Corr',
		11,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31716' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31717' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31717' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Sald_Deud_Dif]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31717' ).atfdcodi,
		'SALD_DEUD_DIF',
		'Sald_Deud_Dif',
		12,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31717' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31718' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31718' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Sald_Deud_Tot]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31718' ).atfdcodi,
		'SALD_DEUD_TOT',
		'Sald_Deud_Tot',
		13,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31718' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31719' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31719' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CONTRATO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31719' ).atfdcodi,
		'CONTRATO',
		'CONTRATO',
		1,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31719' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31720' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31720' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DIRECCION]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31720' ).atfdcodi,
		'DIRECCION',
		'DIRECCION',
		2,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31720' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31721' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31721' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MUNICIPIO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31721' ).atfdcodi,
		'MUNICIPIO',
		'MUNICIPIO',
		3,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31721' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31722' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31722' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOMBRE_CLIENTE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31722' ).atfdcodi,
		'NOMBRE_CLIENTE',
		'NOMBRE_CLIENTE',
		4,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31722' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31723' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31723' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [APELLIDO_CLIENTE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31723' ).atfdcodi,
		'APELLIDO_CLIENTE',
		'APELLIDO_CLIENTE',
		5,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31723' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31724' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31724' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOM_SOLICITANTE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31724' ).atfdcodi,
		'NOM_SOLICITANTE',
		'NOM_SOLICITANTE',
		6,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31724' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31725' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31725' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DOC_SOLICITANTE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31725' ).atfdcodi,
		'DOC_SOLICITANTE',
		'DOC_SOLICITANTE',
		7,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31725' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31726' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31726' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MUNICIPIO_FIRMA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31726' ).atfdcodi,
		'MUNICIPIO_FIRMA',
		'MUNICIPIO_FIRMA',
		8,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31726' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31727' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31727' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FECHA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31727' ).atfdcodi,
		'FECHA',
		'FECHA',
		9,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31727' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31728' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31728' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DIA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31728' ).atfdcodi,
		'DIA',
		'DIA',
		10,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31728' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31729' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31729' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MES]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31729' ).atfdcodi,
		'MES',
		'MES',
		11,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31729' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31730' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31730' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ANO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31730' ).atfdcodi,
		'ANO',
		'ANO',
		12,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31730' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31731' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31731' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOM_EMPRESA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31731' ).atfdcodi,
		'NOM_EMPRESA',
		'NOM_EMPRESA',
		13,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31731' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31732' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31732' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FECHA_DEUDA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31732' ).atfdcodi,
		'FECHA_DEUDA',
		'FECHA_DEUDA',
		14,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31732' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31733' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31733' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DDEUDA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31733' ).atfdcodi,
		'DDEUDA',
		'DDEUDA',
		15,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31733' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31734' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31734' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MDEUDA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31734' ).atfdcodi,
		'MDEUDA',
		'MDEUDA',
		16,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31734' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31735' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31735' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ADEUDA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31735' ).atfdcodi,
		'ADEUDA',
		'ADEUDA',
		17,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31735' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31736' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31736' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ESCASTIGADA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31736' ).atfdcodi,
		'ESCASTIGADA',
		'ESCASTIGADA',
		18,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31736' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_107.tbrcED_AtriFuda( '31737' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_AtriFuda( '31737' ).atfdfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [VALORCASTIGADA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_107.tbrcED_AtriFuda( '31737' ).atfdcodi,
		'VALORCASTIGADA',
		'VALORCASTIGADA',
		19,
		'S',
		CONFEXME_107.tbrcED_AtriFuda( '31737' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_107.tbrcED_Bloque( 6895 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4007' ) ) then
		CONFEXME_107.tbrcED_Bloque( 6895 ).bloqfuda := CONFEXME_107.tbrcED_FuenDato( '4007' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_INFORMACION_CERT]', 5 );
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
		CONFEXME_107.tbrcED_Bloque( 6895 ).bloqcodi,
		'LDC_INFORMACION_CERT',
		CONFEXME_107.tbrcED_Bloque( 6895 ).bloqtibl,
		CONFEXME_107.tbrcED_Bloque( 6895 ).bloqfuda,
		'<LDC_INFORMACION_CERT>',
		'</LDC_INFORMACION_CERT>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_107.tbrcED_Bloque( 6896 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4008' ) ) then
		CONFEXME_107.tbrcED_Bloque( 6896 ).bloqfuda := CONFEXME_107.tbrcED_FuenDato( '4008' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DEUDA_DIFERIDA]', 5 );
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
		CONFEXME_107.tbrcED_Bloque( 6896 ).bloqcodi,
		'LDC_DEUDA_DIFERIDA',
		CONFEXME_107.tbrcED_Bloque( 6896 ).bloqtibl,
		CONFEXME_107.tbrcED_Bloque( 6896 ).bloqfuda,
		'<LDC_DEUDA_DIFERIDA>',
		'</LDC_DEUDA_DIFERIDA>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_107.tbrcED_Bloque( 6897 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_107.tbrcED_FuenDato.exists( '4009' ) ) then
		CONFEXME_107.tbrcED_Bloque( 6897 ).bloqfuda := CONFEXME_107.tbrcED_FuenDato( '4009' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_DEUDA_CORRIENTE]', 5 );
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
		CONFEXME_107.tbrcED_Bloque( 6897 ).bloqcodi,
		'LDC_DEUDA_CORRIENTE',
		CONFEXME_107.tbrcED_Bloque( 6897 ).bloqtibl,
		CONFEXME_107.tbrcED_Bloque( 6897 ).bloqfuda,
		'<LDC_DEUDA_CORRIENTE>',
		'</LDC_DEUDA_CORRIENTE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrfrfo := CONFEXME_107.tbrcED_FranForm( '4687' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_107.tbrcED_Bloque.exists( 6895 ) ) then
		CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrbloq := CONFEXME_107.tbrcED_Bloque( 6895 ).bloqcodi;
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
		CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi,
		CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrbloq,
		CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrfrfo := CONFEXME_107.tbrcED_FranForm( '4688' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_107.tbrcED_Bloque.exists( 6896 ) ) then
		CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrbloq := CONFEXME_107.tbrcED_Bloque( 6896 ).bloqcodi;
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
		CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi,
		CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrbloq,
		CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrfrfo := CONFEXME_107.tbrcED_FranForm( '4688' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_107.tbrcED_Bloque.exists( 6897 ) ) then
		CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrbloq := CONFEXME_107.tbrcED_Bloque( 6897 ).bloqcodi;
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
		CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi,
		CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrbloq,
		CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrfrfo,
		1,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36932' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36932' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31694' ) ) then
		CONFEXME_107.tbrcED_Item( '36932' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31694' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Diferido]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36932' ).itemcodi,
		'Diferido',
		CONFEXME_107.tbrcED_Item( '36932' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36932' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36932' ).itemgren,
		NULL,
		1,
		'<DIFERIDO>',
		'</DIFERIDO>',
		CONFEXME_107.tbrcED_Item( '36932' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36933' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36933' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31695' ) ) then
		CONFEXME_107.tbrcED_Item( '36933' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31695' ).atfdcodi;
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
		CONFEXME_107.tbrcED_Item( '36933' ).itemcodi,
		'Producto',
		CONFEXME_107.tbrcED_Item( '36933' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36933' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36933' ).itemgren,
		NULL,
		1,
		'<PRODUCTO>',
		'</PRODUCTO>',
		CONFEXME_107.tbrcED_Item( '36933' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36934' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36934' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31696' ) ) then
		CONFEXME_107.tbrcED_Item( '36934' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31696' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tipo_Producto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36934' ).itemcodi,
		'Tipo_Producto',
		CONFEXME_107.tbrcED_Item( '36934' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36934' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36934' ).itemgren,
		NULL,
		1,
		'<TIPO_PRODUCTO>',
		'</TIPO_PRODUCTO>',
		CONFEXME_107.tbrcED_Item( '36934' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36935' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36935' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31697' ) ) then
		CONFEXME_107.tbrcED_Item( '36935' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31697' ).atfdcodi;
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
		CONFEXME_107.tbrcED_Item( '36935' ).itemcodi,
		'Concepto',
		CONFEXME_107.tbrcED_Item( '36935' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36935' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36935' ).itemgren,
		NULL,
		1,
		'<CONCEPTO>',
		'</CONCEPTO>',
		CONFEXME_107.tbrcED_Item( '36935' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36936' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36936' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31698' ) ) then
		CONFEXME_107.tbrcED_Item( '36936' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31698' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Desc_Concepto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36936' ).itemcodi,
		'Desc_Concepto',
		CONFEXME_107.tbrcED_Item( '36936' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36936' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36936' ).itemgren,
		NULL,
		1,
		'<DESC_CONCEPTO>',
		'</DESC_CONCEPTO>',
		CONFEXME_107.tbrcED_Item( '36936' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36937' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36937' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31699' ) ) then
		CONFEXME_107.tbrcED_Item( '36937' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31699' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Num_Finan]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36937' ).itemcodi,
		'Num_Finan',
		CONFEXME_107.tbrcED_Item( '36937' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36937' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36937' ).itemgren,
		NULL,
		1,
		'<NUM_FINAN>',
		'</NUM_FINAN>',
		CONFEXME_107.tbrcED_Item( '36937' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36938' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36938' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31700' ) ) then
		CONFEXME_107.tbrcED_Item( '36938' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31700' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Fecha_Ing]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36938' ).itemcodi,
		'Fecha_Ing',
		CONFEXME_107.tbrcED_Item( '36938' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36938' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36938' ).itemgren,
		NULL,
		12,
		'<FECHA_ING>',
		'</FECHA_ING>',
		CONFEXME_107.tbrcED_Item( '36938' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36939' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36939' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31701' ) ) then
		CONFEXME_107.tbrcED_Item( '36939' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31701' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cuot_Pact]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36939' ).itemcodi,
		'Cuot_Pact',
		CONFEXME_107.tbrcED_Item( '36939' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36939' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36939' ).itemgren,
		NULL,
		1,
		'<CUOT_PACT>',
		'</CUOT_PACT>',
		CONFEXME_107.tbrcED_Item( '36939' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36940' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36940' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31702' ) ) then
		CONFEXME_107.tbrcED_Item( '36940' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31702' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cuot_Canc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36940' ).itemcodi,
		'Cuot_Canc',
		CONFEXME_107.tbrcED_Item( '36940' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36940' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36940' ).itemgren,
		NULL,
		2,
		'<CUOT_CANC>',
		'</CUOT_CANC>',
		CONFEXME_107.tbrcED_Item( '36940' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36941' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36941' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31703' ) ) then
		CONFEXME_107.tbrcED_Item( '36941' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31703' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Cuot_Pend]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36941' ).itemcodi,
		'Cuot_Pend',
		CONFEXME_107.tbrcED_Item( '36941' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36941' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36941' ).itemgren,
		NULL,
		2,
		'<CUOT_PEND>',
		'</CUOT_PEND>',
		CONFEXME_107.tbrcED_Item( '36941' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36942' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36942' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31704' ) ) then
		CONFEXME_107.tbrcED_Item( '36942' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31704' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Valor_Ini]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36942' ).itemcodi,
		'Valor_Ini',
		CONFEXME_107.tbrcED_Item( '36942' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36942' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36942' ).itemgren,
		NULL,
		2,
		'<VALOR_INI>',
		'</VALOR_INI>',
		CONFEXME_107.tbrcED_Item( '36942' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36943' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36943' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31705' ) ) then
		CONFEXME_107.tbrcED_Item( '36943' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31705' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Sald_Pend]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36943' ).itemcodi,
		'Sald_Pend',
		CONFEXME_107.tbrcED_Item( '36943' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36943' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36943' ).itemgren,
		NULL,
		2,
		'<SALD_PEND>',
		'</SALD_PEND>',
		CONFEXME_107.tbrcED_Item( '36943' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36944' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36944' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31706' ) ) then
		CONFEXME_107.tbrcED_Item( '36944' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31706' ).atfdcodi;
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
		CONFEXME_107.tbrcED_Item( '36944' ).itemcodi,
		'Producto',
		CONFEXME_107.tbrcED_Item( '36944' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36944' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36944' ).itemgren,
		NULL,
		1,
		'<PRODUCTO>',
		'</PRODUCTO>',
		CONFEXME_107.tbrcED_Item( '36944' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36945' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36945' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31707' ) ) then
		CONFEXME_107.tbrcED_Item( '36945' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31707' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tipo_Producto]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36945' ).itemcodi,
		'Tipo_Producto',
		CONFEXME_107.tbrcED_Item( '36945' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36945' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36945' ).itemgren,
		NULL,
		2,
		'<TIPO_PRODUCTO>',
		'</TIPO_PRODUCTO>',
		CONFEXME_107.tbrcED_Item( '36945' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36946' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36946' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31708' ) ) then
		CONFEXME_107.tbrcED_Item( '36946' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31708' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Tipo_Prod_Desc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36946' ).itemcodi,
		'Tipo_Prod_Desc',
		CONFEXME_107.tbrcED_Item( '36946' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36946' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36946' ).itemgren,
		NULL,
		1,
		'<TIPO_PROD_DESC>',
		'</TIPO_PROD_DESC>',
		CONFEXME_107.tbrcED_Item( '36946' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36947' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36947' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31709' ) ) then
		CONFEXME_107.tbrcED_Item( '36947' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31709' ).atfdcodi;
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
		CONFEXME_107.tbrcED_Item( '36947' ).itemcodi,
		'Concepto',
		CONFEXME_107.tbrcED_Item( '36947' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36947' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36947' ).itemgren,
		NULL,
		2,
		'<CONCEPTO>',
		'</CONCEPTO>',
		CONFEXME_107.tbrcED_Item( '36947' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36948' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36948' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31710' ) ) then
		CONFEXME_107.tbrcED_Item( '36948' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31710' ).atfdcodi;
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
		CONFEXME_107.tbrcED_Item( '36948' ).itemcodi,
		'Concepto',
		CONFEXME_107.tbrcED_Item( '36948' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36948' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36948' ).itemgren,
		NULL,
		1,
		'<CONCDESC>',
		'</CONCDESC>',
		CONFEXME_107.tbrcED_Item( '36948' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36949' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36949' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31711' ) ) then
		CONFEXME_107.tbrcED_Item( '36949' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31711' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Deuda_Fecha]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36949' ).itemcodi,
		'Deuda_Fecha',
		CONFEXME_107.tbrcED_Item( '36949' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36949' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36949' ).itemgren,
		NULL,
		2,
		'<DEUDA_FECHA>',
		'</DEUDA_FECHA>',
		CONFEXME_107.tbrcED_Item( '36949' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36950' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36950' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31712' ) ) then
		CONFEXME_107.tbrcED_Item( '36950' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31712' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Deuda_30]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36950' ).itemcodi,
		'Deuda_30',
		CONFEXME_107.tbrcED_Item( '36950' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36950' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36950' ).itemgren,
		NULL,
		2,
		'<DEUDA_30>',
		'</DEUDA_30>',
		CONFEXME_107.tbrcED_Item( '36950' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36951' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36951' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31713' ) ) then
		CONFEXME_107.tbrcED_Item( '36951' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31713' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Deuda_60]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36951' ).itemcodi,
		'Deuda_60',
		CONFEXME_107.tbrcED_Item( '36951' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36951' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36951' ).itemgren,
		NULL,
		2,
		'<DEUDA_60>',
		'</DEUDA_60>',
		CONFEXME_107.tbrcED_Item( '36951' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36952' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36952' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31714' ) ) then
		CONFEXME_107.tbrcED_Item( '36952' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31714' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Deuda_90]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36952' ).itemcodi,
		'Deuda_90',
		CONFEXME_107.tbrcED_Item( '36952' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36952' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36952' ).itemgren,
		NULL,
		2,
		'<DEUDA_90>',
		'</DEUDA_90>',
		CONFEXME_107.tbrcED_Item( '36952' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36953' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36953' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31715' ) ) then
		CONFEXME_107.tbrcED_Item( '36953' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31715' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Deuda_Mas90]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36953' ).itemcodi,
		'Deuda_Mas90',
		CONFEXME_107.tbrcED_Item( '36953' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36953' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36953' ).itemgren,
		NULL,
		2,
		'<DEUDA_MAS90>',
		'</DEUDA_MAS90>',
		CONFEXME_107.tbrcED_Item( '36953' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36954' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36954' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31716' ) ) then
		CONFEXME_107.tbrcED_Item( '36954' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31716' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Sald_Deud_Corr]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36954' ).itemcodi,
		'Sald_Deud_Corr',
		CONFEXME_107.tbrcED_Item( '36954' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36954' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36954' ).itemgren,
		NULL,
		2,
		'<SALD_DEUD_CORR>',
		'</SALD_DEUD_CORR>',
		CONFEXME_107.tbrcED_Item( '36954' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36955' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36955' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31717' ) ) then
		CONFEXME_107.tbrcED_Item( '36955' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31717' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Sald_Deud_Dif]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36955' ).itemcodi,
		'Sald_Deud_Dif',
		CONFEXME_107.tbrcED_Item( '36955' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36955' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36955' ).itemgren,
		NULL,
		2,
		'<SALD_DEUD_DIF>',
		'</SALD_DEUD_DIF>',
		CONFEXME_107.tbrcED_Item( '36955' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36956' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36956' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31718' ) ) then
		CONFEXME_107.tbrcED_Item( '36956' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31718' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Sald_Deud_Tot]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36956' ).itemcodi,
		'Sald_Deud_Tot',
		CONFEXME_107.tbrcED_Item( '36956' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36956' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36956' ).itemgren,
		NULL,
		2,
		'<SALD_DEUD_TOT>',
		'</SALD_DEUD_TOT>',
		CONFEXME_107.tbrcED_Item( '36956' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36957' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36957' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31719' ) ) then
		CONFEXME_107.tbrcED_Item( '36957' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31719' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CONTRATO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36957' ).itemcodi,
		'CONTRATO',
		CONFEXME_107.tbrcED_Item( '36957' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36957' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36957' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_107.tbrcED_Item( '36957' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36958' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36958' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31720' ) ) then
		CONFEXME_107.tbrcED_Item( '36958' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31720' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [DIRECCION]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36958' ).itemcodi,
		'DIRECCION',
		CONFEXME_107.tbrcED_Item( '36958' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36958' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36958' ).itemgren,
		NULL,
		1,
		'<DIRECCION>',
		'</DIRECCION>',
		CONFEXME_107.tbrcED_Item( '36958' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36959' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36959' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31721' ) ) then
		CONFEXME_107.tbrcED_Item( '36959' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31721' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MUNICIPIO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36959' ).itemcodi,
		'MUNICIPIO',
		CONFEXME_107.tbrcED_Item( '36959' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36959' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36959' ).itemgren,
		NULL,
		1,
		'<MUNICIPIO>',
		'</MUNICIPIO>',
		CONFEXME_107.tbrcED_Item( '36959' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36960' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36960' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31722' ) ) then
		CONFEXME_107.tbrcED_Item( '36960' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31722' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOMBRE_CLIENTE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36960' ).itemcodi,
		'NOMBRE_CLIENTE',
		CONFEXME_107.tbrcED_Item( '36960' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36960' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36960' ).itemgren,
		NULL,
		1,
		'<NOMBRE_CLIENTE>',
		'</NOMBRE_CLIENTE>',
		CONFEXME_107.tbrcED_Item( '36960' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36961' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36961' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31723' ) ) then
		CONFEXME_107.tbrcED_Item( '36961' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31723' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [APELLIDO_CLIENTE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36961' ).itemcodi,
		'APELLIDO_CLIENTE',
		CONFEXME_107.tbrcED_Item( '36961' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36961' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36961' ).itemgren,
		NULL,
		1,
		'<APELLIDO_CLIENTE>',
		'</APELLIDO_CLIENTE>',
		CONFEXME_107.tbrcED_Item( '36961' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36962' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36962' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31724' ) ) then
		CONFEXME_107.tbrcED_Item( '36962' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31724' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOM_SOLICITANTE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36962' ).itemcodi,
		'NOM_SOLICITANTE',
		CONFEXME_107.tbrcED_Item( '36962' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36962' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36962' ).itemgren,
		NULL,
		1,
		'<NOM_SOLICITANTE>',
		'</NOM_SOLICITANTE>',
		CONFEXME_107.tbrcED_Item( '36962' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36963' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36963' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31725' ) ) then
		CONFEXME_107.tbrcED_Item( '36963' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31725' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [DOC_SOLICITANTE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36963' ).itemcodi,
		'DOC_SOLICITANTE',
		CONFEXME_107.tbrcED_Item( '36963' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36963' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36963' ).itemgren,
		NULL,
		1,
		'<DOC_SOLICITANTE>',
		'</DOC_SOLICITANTE>',
		CONFEXME_107.tbrcED_Item( '36963' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36964' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36964' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31726' ) ) then
		CONFEXME_107.tbrcED_Item( '36964' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31726' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MUNICIPIO_FIRMA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36964' ).itemcodi,
		'MUNICIPIO_FIRMA',
		CONFEXME_107.tbrcED_Item( '36964' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36964' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36964' ).itemgren,
		NULL,
		1,
		'<MUNICIPIO_FIRMA>',
		'</MUNICIPIO_FIRMA>',
		CONFEXME_107.tbrcED_Item( '36964' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36965' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36965' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31727' ) ) then
		CONFEXME_107.tbrcED_Item( '36965' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31727' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FECHA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36965' ).itemcodi,
		'FECHA',
		CONFEXME_107.tbrcED_Item( '36965' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36965' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36965' ).itemgren,
		NULL,
		1,
		'<FECHA>',
		'</FECHA>',
		CONFEXME_107.tbrcED_Item( '36965' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36966' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36966' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31728' ) ) then
		CONFEXME_107.tbrcED_Item( '36966' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31728' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [DIA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36966' ).itemcodi,
		'DIA',
		CONFEXME_107.tbrcED_Item( '36966' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36966' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36966' ).itemgren,
		NULL,
		1,
		'<DIA>',
		'</DIA>',
		CONFEXME_107.tbrcED_Item( '36966' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36967' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36967' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31729' ) ) then
		CONFEXME_107.tbrcED_Item( '36967' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31729' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MES]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36967' ).itemcodi,
		'MES',
		CONFEXME_107.tbrcED_Item( '36967' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36967' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36967' ).itemgren,
		NULL,
		1,
		'<MES>',
		'</MES>',
		CONFEXME_107.tbrcED_Item( '36967' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36968' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36968' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31730' ) ) then
		CONFEXME_107.tbrcED_Item( '36968' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31730' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ANO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36968' ).itemcodi,
		'ANO',
		CONFEXME_107.tbrcED_Item( '36968' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36968' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36968' ).itemgren,
		NULL,
		1,
		'<ANO>',
		'</ANO>',
		CONFEXME_107.tbrcED_Item( '36968' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36969' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36969' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31731' ) ) then
		CONFEXME_107.tbrcED_Item( '36969' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31731' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOM_EMPRESA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36969' ).itemcodi,
		'NOM_EMPRESA',
		CONFEXME_107.tbrcED_Item( '36969' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36969' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36969' ).itemgren,
		NULL,
		1,
		'<NOM_EMPRESA>',
		'</NOM_EMPRESA>',
		CONFEXME_107.tbrcED_Item( '36969' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36970' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36970' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31732' ) ) then
		CONFEXME_107.tbrcED_Item( '36970' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31732' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FECHA_DEUDA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36970' ).itemcodi,
		'FECHA_DEUDA',
		CONFEXME_107.tbrcED_Item( '36970' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36970' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36970' ).itemgren,
		NULL,
		1,
		'<FECHA_DEUDA>',
		'</FECHA_DEUDA>',
		CONFEXME_107.tbrcED_Item( '36970' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36971' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36971' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31733' ) ) then
		CONFEXME_107.tbrcED_Item( '36971' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31733' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [DDEUDA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36971' ).itemcodi,
		'DDEUDA',
		CONFEXME_107.tbrcED_Item( '36971' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36971' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36971' ).itemgren,
		NULL,
		1,
		'<DDEUDA>',
		'</DDEUDA>',
		CONFEXME_107.tbrcED_Item( '36971' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36972' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36972' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31734' ) ) then
		CONFEXME_107.tbrcED_Item( '36972' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31734' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MDEUDA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36972' ).itemcodi,
		'MDEUDA',
		CONFEXME_107.tbrcED_Item( '36972' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36972' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36972' ).itemgren,
		NULL,
		1,
		'<MDEUDA>',
		'</MDEUDA>',
		CONFEXME_107.tbrcED_Item( '36972' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36973' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36973' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31735' ) ) then
		CONFEXME_107.tbrcED_Item( '36973' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31735' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ADEUDA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36973' ).itemcodi,
		'ADEUDA',
		CONFEXME_107.tbrcED_Item( '36973' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36973' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36973' ).itemgren,
		NULL,
		1,
		'<ADEUDA>',
		'</ADEUDA>',
		CONFEXME_107.tbrcED_Item( '36973' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36974' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36974' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31736' ) ) then
		CONFEXME_107.tbrcED_Item( '36974' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31736' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ESCASTIGADA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36974' ).itemcodi,
		'ESCASTIGADA',
		CONFEXME_107.tbrcED_Item( '36974' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36974' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36974' ).itemgren,
		NULL,
		2,
		'<ESCASTIGADA>',
		'</ESCASTIGADA>',
		CONFEXME_107.tbrcED_Item( '36974' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_107.tbrcED_Item( '36975' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_107.tbrcED_Item( '36975' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_107.tbrcED_AtriFuda.exists( '31737' ) ) then
		CONFEXME_107.tbrcED_Item( '36975' ).itematfd := CONFEXME_107.tbrcED_AtriFuda( '31737' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [VALORCASTIGADA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_107.tbrcED_Item( '36975' ).itemcodi,
		'VALORCASTIGADA',
		CONFEXME_107.tbrcED_Item( '36975' ).itemceid,
		NULL,
		CONFEXME_107.tbrcED_Item( '36975' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_107.tbrcED_Item( '36975' ).itemgren,
		NULL,
		1,
		'<VALORCASTIGADA>',
		'</VALORCASTIGADA>',
		CONFEXME_107.tbrcED_Item( '36975' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36907' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36907' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36932' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36907' ).itblitem := CONFEXME_107.tbrcED_Item( '36932' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36907' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36907' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36907' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36908' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36908' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36933' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36908' ).itblitem := CONFEXME_107.tbrcED_Item( '36933' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36908' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36908' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36908' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36909' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36909' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36934' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36909' ).itblitem := CONFEXME_107.tbrcED_Item( '36934' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36909' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36909' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36909' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36910' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36910' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36935' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36910' ).itblitem := CONFEXME_107.tbrcED_Item( '36935' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36910' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36910' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36910' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36911' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36911' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36936' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36911' ).itblitem := CONFEXME_107.tbrcED_Item( '36936' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36911' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36911' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36911' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36912' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36912' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36937' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36912' ).itblitem := CONFEXME_107.tbrcED_Item( '36937' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36912' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36912' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36912' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36913' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36913' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36938' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36913' ).itblitem := CONFEXME_107.tbrcED_Item( '36938' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36913' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36913' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36913' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36914' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36914' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36939' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36914' ).itblitem := CONFEXME_107.tbrcED_Item( '36939' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36914' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36914' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36914' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36915' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36915' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36940' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36915' ).itblitem := CONFEXME_107.tbrcED_Item( '36940' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36915' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36915' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36915' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36916' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36916' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36941' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36916' ).itblitem := CONFEXME_107.tbrcED_Item( '36941' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36916' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36916' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36916' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36917' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36917' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36942' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36917' ).itblitem := CONFEXME_107.tbrcED_Item( '36942' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36917' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36917' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36917' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36918' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36918' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7060' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36943' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36918' ).itblitem := CONFEXME_107.tbrcED_Item( '36943' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36918' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36918' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36918' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36919' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36919' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36944' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36919' ).itblitem := CONFEXME_107.tbrcED_Item( '36944' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36919' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36919' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36919' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36920' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36920' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36945' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36920' ).itblitem := CONFEXME_107.tbrcED_Item( '36945' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36920' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36920' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36920' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36921' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36921' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36946' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36921' ).itblitem := CONFEXME_107.tbrcED_Item( '36946' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36921' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36921' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36921' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36922' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36922' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36947' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36922' ).itblitem := CONFEXME_107.tbrcED_Item( '36947' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36922' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36922' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36922' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36923' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36923' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36948' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36923' ).itblitem := CONFEXME_107.tbrcED_Item( '36948' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36923' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36923' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36923' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36924' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36924' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36949' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36924' ).itblitem := CONFEXME_107.tbrcED_Item( '36949' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36924' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36924' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36924' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36925' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36925' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36950' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36925' ).itblitem := CONFEXME_107.tbrcED_Item( '36950' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36925' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36925' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36925' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36926' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36926' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36951' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36926' ).itblitem := CONFEXME_107.tbrcED_Item( '36951' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36926' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36926' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36926' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36927' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36927' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36952' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36927' ).itblitem := CONFEXME_107.tbrcED_Item( '36952' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36927' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36927' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36927' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36928' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36928' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36953' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36928' ).itblitem := CONFEXME_107.tbrcED_Item( '36953' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36928' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36928' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36928' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36929' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36929' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36954' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36929' ).itblitem := CONFEXME_107.tbrcED_Item( '36954' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36929' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36929' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36929' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36930' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36930' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36955' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36930' ).itblitem := CONFEXME_107.tbrcED_Item( '36955' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36930' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36930' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36930' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36931' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36931' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7061' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36956' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36931' ).itblitem := CONFEXME_107.tbrcED_Item( '36956' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36931' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36931' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36931' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36932' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36932' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36957' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36932' ).itblitem := CONFEXME_107.tbrcED_Item( '36957' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36932' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36932' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36932' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36933' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36933' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36958' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36933' ).itblitem := CONFEXME_107.tbrcED_Item( '36958' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36933' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36933' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36933' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36934' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36934' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36959' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36934' ).itblitem := CONFEXME_107.tbrcED_Item( '36959' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36934' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36934' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36934' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36935' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36935' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36960' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36935' ).itblitem := CONFEXME_107.tbrcED_Item( '36960' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36935' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36935' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36935' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36936' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36936' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36961' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36936' ).itblitem := CONFEXME_107.tbrcED_Item( '36961' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36936' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36936' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36936' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36937' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36937' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36962' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36937' ).itblitem := CONFEXME_107.tbrcED_Item( '36962' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36937' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36937' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36937' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36938' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36938' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36963' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36938' ).itblitem := CONFEXME_107.tbrcED_Item( '36963' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36938' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36938' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36938' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36939' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36939' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36964' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36939' ).itblitem := CONFEXME_107.tbrcED_Item( '36964' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36939' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36939' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36939' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36940' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36940' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36965' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36940' ).itblitem := CONFEXME_107.tbrcED_Item( '36965' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36940' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36940' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36940' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36941' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36941' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36966' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36941' ).itblitem := CONFEXME_107.tbrcED_Item( '36966' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36941' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36941' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36941' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36942' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36942' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36967' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36942' ).itblitem := CONFEXME_107.tbrcED_Item( '36967' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36942' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36942' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36942' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36943' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36943' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36968' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36943' ).itblitem := CONFEXME_107.tbrcED_Item( '36968' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36943' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36943' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36943' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36944' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36944' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36969' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36944' ).itblitem := CONFEXME_107.tbrcED_Item( '36969' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36944' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36944' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36944' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36945' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36945' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36970' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36945' ).itblitem := CONFEXME_107.tbrcED_Item( '36970' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36945' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36945' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36945' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36946' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36946' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36971' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36946' ).itblitem := CONFEXME_107.tbrcED_Item( '36971' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36946' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36946' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36946' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36947' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36947' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36972' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36947' ).itblitem := CONFEXME_107.tbrcED_Item( '36972' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36947' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36947' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36947' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36948' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36948' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36973' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36948' ).itblitem := CONFEXME_107.tbrcED_Item( '36973' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36948' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36948' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36948' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36949' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36949' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36974' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36949' ).itblitem := CONFEXME_107.tbrcED_Item( '36974' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36949' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36949' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36949' ).itblblfr,
		18
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_107.tbrcED_ItemBloq( '36950' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_107.tbrcED_ItemBloq( '36950' ).itblblfr := CONFEXME_107.tbrcED_BloqFran( '7059' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_107.tbrcED_Item.exists( '36975' ) ) then
		CONFEXME_107.tbrcED_ItemBloq( '36950' ).itblitem := CONFEXME_107.tbrcED_Item( '36975' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_107.tbrcED_ItemBloq( '36950' ).itblcodi,
		CONFEXME_107.tbrcED_ItemBloq( '36950' ).itblitem,
		CONFEXME_107.tbrcED_ItemBloq( '36950' ).itblblfr,
		19
	);

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
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
			'EFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E30613336383633312D366364302D343937342D386137332D3335663366653036623332373C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C52696768744D617267696E3E31636D3C2F52696768744D617267696E3E0D0A20203C4C6566744D617267696E3E31636D3C2F4C6566744D617267696E3E0D0A20203C506167654865616465723E0D0A202020203C5072696E744F6E4669727374506167653E747275653C2F5072696E744F6E4669727374506167653E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C496D616765204E616D653D22696D61676531223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C57696474683E352E3735636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D4554797065'
		||	'3E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C4C6566743E302E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6764635F3C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E322E35636D3C2F4865696768743E0D0A202020203C5072696E744F6E4C617374506167653E747275653C2F5072696E744F6E4C617374506167653E0D0A20203C2F506167654865616465723E0D0A20203C426F74746F6D4D617267696E3E302E33636D3C2F426F74746F6D4D617267696E3E0D0A20203C72643A5265706F727449443E66376237353039342D643930392D343634372D623166622D6436396438376631373930383C2F72643A5265706F727449443E0D0A20203C456D626564646564496D616765733E0D0A202020203C456D626564646564496D616765204E616D653D226764635F223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E6956424F5277304B47676F414141414E5355684555674141415355414141425143415941414142662F324F78414141414358424957584D41414137454141414F784147564B773462414141414233524A545555483451455444685152494942703677414141416430525668305158563061473979414B6D757A4567414141414D644556596445526C63324E79615842306157397541424D4A49534D414141414B6445565964454E7663486C796157646F644143734438773641414141446E524657485244636D566864476C76626942306157316C4144583344776B414141414A6445565964464E765A6E523359584A6C414631772F7A6F414141414C644556596445527063324E7359576C745A584941743843306A774141414168305256683056324679626D6C755A774441472B6148414141414233524657485254623356795932554139662B443677414141416830525668305132397462575675644144327A4A612F41414141426E524657485255615852735A51436F3774496E4141416741456C45515652346E4F32646435776B645A6E2F333158567558756D4A3865647A546B76752B534D784A3849696751565042564F455539505251384470334A6E4F45343855546B44364345694B6B6C68455A416F63516B4C797936625A33646E646D5A6E4A303933542B6451346676376F365A3770716437347535794C4666763132'
		||	'7465722B6C4B33323958563333712B54376635336C4B456B49494C4377734C4E346C794F3955517930444356375A4833716E6D724F777344684B6555644553544D4566393854594443707652504E57566859484D573849364C30797634512F2F4630797A76526C4957467856484F4552636C49654457353972594830685334624566366559734C43794F636F36344B443364504D4444573376784F5255694B5776345A6D46684D543548564A535371733758316A63502F572F5145306B66796559734C437A65417878525562706A517764624F694D41364961674E5A41346B73315A57466938427A68696F72512F6B4F5437542B553774397343795350566E4957467858754549795A4B50336971686635594A6D2F5A6A703459486148556B57725377734C69506341524561586E3977613539363275677556624F365073376F3064695359744C437A65497878325564494E776665653345637372526573792B67474C3764615564305746685A6A6339684636592B62756E69746258444D39552F744872426D345377734C4D626B734970534E4B33786F32663345383855576B6C5A586D73623549304434576D3349595178375830744C437A652F5278575562727468585A3239457A734D2F7264786B3530592B724643654C4A44734B78586450706D6F57460A7856484359524F6C51467A6C6E6A65364A69553244322F7435645678686E6A46474978735A38652B5735426C7833533761474668635252773245547035792B3173377476636A4E727569483434544F746B7A35324F4C61625454752F6A71596E4B5055756D4734584C5377736A67494F69796931444354347A617364544B566333462B33392F48497472344A742B7350766361623237394B50486D416870727A447147584668595752774F48525A522B2B397242615156466676586833517A454D324F7537772B2B777561644E784A50486B43526E666A637377366C6D785957466B63426879784B7533706A2F4F484E776B444A79624333503834332F37716E364C714F6E76567332766B3155706C2B4143544A687366564D4F312B576C68594842306373696A6475366D62747544306339702B2F30596E76336D31593851535155764837396A612F443079366F6A5141556C436C70335437366946686356527753474A30713765474C2F6232486C4948556970427439345A4138763778314536436E32745032436E5332336F68756A416979465144657376446B4C692F63363078596C496544784866323048344B566C475567704848646654743476666C483948543842376F42494F5733683034713358764962566C59574C79376D62596F4852784D3861734E4277367464516E49364E6963457537355A6179507A694B696C'
		||	'2B456C674D687459434B4549476D4A6B6F58466535347852556E5649716861644D77646E326B6559462F2F495252746B3443306A733275634F77704E53786456735A5736554D386266384F61616B4544774545456C6C68456B496C45697675464C657773486A764D49596F436272366E6D4967744C486F326B5247352B637648594B564A414E7041316D525758644B505973576C5A464A4A48455A416662595073447A6A6D2B693438516C496B50435A4F61386857504E30322F5477734C69714B436F4B476C366775372B5A78694D62692B363032747467327A716D475A537251786B444E414D567031517936496C5A6152534F706F414F326B38596F4164746B74357A663435464E4C59535A4B316C6D4C7856704B7037756D316132466863565251564A54536D53436879445A43346130596F32624264454E77787973647858616247416C546B444B4370636658736D783542577047787A424D65306767597965426D304865736E2B535862614C73596B6B456D62566756536D6A36372B70366258746F5746785646425556464B7066745274536A42794E763042562F4A5739666346353955656B67424571414A534F737357566646326E5856474C7041302F4A7A5577517954684542496647362F546F43796F496861306B676845465833314F463451490A57466862764759714B556A532B44774444794C42372F38394A7049596A74682F61326B74534862746530706A6F4174494738315A57735870644E5549494E4B313462535144475463425174496333725A6469593444425850627765674F446E512F4E5058324C5377736A676F4B524D6B7756434C7876626E506B64676564726263697161624D3348337654554E6E343442704853614670647833496B31794C4A454F6A4E7873545950412B78547A715A544F52594A46544164337531644431712B4A51754C397967466F7154704D574B4A2F586E4C4F7675656F722F33567A793275594F573769524D70543662414E496174584E4B4F4F486B4F6D78324254566A6A41714E4C49614551675956467A75554436454C42394B517452534A37574650322B315746556F4C692F636742614B555553504534766D694A4954457676302F35636E393934484441326E644849354E70437743534F755531336B343862514733473646644A4558436F7939753453444246334B616E715531586B7A635230396A316A444F41754C397941466F6852507475637938374F624F4B515567366B535844506D634E785A3956544E38494A75514649624671646941705857635A58594F65365565736F726E4B5353552F56465353696F5A4351767262625445554B434957764A45427137393938325A6979566859584630636B6F55524946517A6542'
		||	'774362694247304C615464574D3650527A6C6E6E4E6248793246704B2F453749364242544954564363435441454D68326D62556E3174485535434D6556616656515947455179546F5646595456367052794A42567748516D794E764E2F355A7A7A46745957427A3935496D53626D53497867764C3143706F4846424F514A566370424971546F664D4D636457632B614673316835556832315453585958546149612B5A66516F4F34797079564653786156455938707070564B5364324A42564651534E4F486230737830596D7A3655565433627731733576576F357643347633434C6152483351395254693661395147475A4A5347643379476951424D676170464D697951586D5A6B347031315353576C52506F543948586E534161797444646C3643387A4D47534652573052314934444368314B43436D356950505975715A524A65796C6B5847347A415561706B6C484E764E786D3166354D545676385A6839302B6A4251734C6933634C65614A6B47476D53365A37635A7A4F51635A434479676B4D79724E7973312B535A4A597553535130464558435956646F6D4F476A7164464C494B35796D69547A2B666C31364537593042766C3758434367346B4D48707543543547486A6A3031444352437969795357686D4B794742675A3751776264337A50640A59752F55386B365969386A647A437775496449452B556B716E75764D6F4145675979426E33534D6C4B534B51596A6B5351774445453670534E4C6F4171425A4A4F34626B6B3978355A3641566854346957513058673945474E3956346A4F5A41612F5863456D53564D534A676D4442445745705361716A575A536B7231674E4E6A56397953562F6A584D6D6647784B5A30454377754C647739354A6B55386452416854496531514D49753469516F70394F3242674D5A4761336F5153544A74466B47565A304C716B745A352F506B316A6C6C695161586E5138316C76504446553163326C69424B69437069796D356D475230456C49466357727A51674E47303978324F3946347978534F62474668385735696843694A556335694352735A6F6E494451586B65706C3154504668526C6D42513156685336754C446A5A5859354F4B4355654F793834397A712F6D58525857554F3253695936535A4645656753553469636830436962487372497761596B2F6237557A50653256685966472F54553655684444792F456B5342684947412F4A693076695255536C6D6E55684158444F7779784B666D46564E74644E57734D314946456E696C4D6F537672576B6B51556C54754B6150696E354D455649454A64713053526E726E4A414D6670447278494D767A324A6F317059574C7A6279496D5349545353715A476970434F51364A63'
		||	'586B5A61384B4B4A346E4A454F444B6F47463953567336624D5533536259737A7A7562686855514F7A505534532B6D5453547379707534525568593539544A45454D7971396F2B65525366664677734C6933554E4F6C445174536C6F4E446E3253734A456D4B5655536C4F6343636D376D6266544F4556566E76732F4A5A54504B73556C5443305271634E6E35776F49367975774B43563066743244345550314A557667787349303566474E6F75344851526E5439304639715947466838633653307746566935484F6D4B496B414C7449454A4562474A526E6F525278634574413268426F68754144395758554F4F335436734369456865666E463174486B754D372F79575275577A6A43644C365579413375444C302B7154685958462F78346A4C4B555936637741594E37324D675952366B684B6C5A674F377448463243437136537A7A757A6D6E3974414346732B754B6557736D6A494361583243595A776F364D64596148716377556A78637234575278644346502F2F63422F664F4249485077724A6E6F622F72644F5238306F6E5570305968706C58707042426B31774D796E505268514E626B536E346A43467779544C6E31667278325134395750474B706E493268654A454E5A305375347878474536496C587079394C4E2B57792B2F664E6C38530A595745684D4D6D63664E4669316853367A7373782F2F656B793238334270456C695230513743307A73644E46797A413778352F77755A6F4A616E71504E4D63494A7A5573436B533862544F76436F50703830765235596B6676425543792B324249666D7477567A4B6A333834724A6C544E457A63306A6B7A6E78614451476D4853494C4452304849586B6D756D54444B664B48622B62723267527A6655374F71696B394C42325A3758487967586F2F2F374E2F594279526B2F4A65757A51527958517675703545556479487059395A2B71495A746E5247614231496B464231676E45565130435A323462486F564262346D52706E59396C3959666E78766D2F7A4D366547452F75477368623975557A3572436B397641632F2F6D39415A3764453868395068424B3876567A35754C6E30455270383845493237756A6842496177555347704770513662486A63397159562B56685471576268545865512B332B6C426C4D616E7A68775A333052545049456D5230672F4F57564C4E7570682B66552B474666554765326A3138766876394C6E357979524B63683848776D43776A4C4B58686B726379476D6D706C4A6A5567454247516B4F4D63454F72686B43574A63366F38654E57446C396E54367375345A6D2B4D503170446239644B576F74796568445475364A68556E5434366836374C4349556B59332B4F4F6233547977755A'
		||	'766D766A6944535A5634526B6333424B7075646C53524A577979684E4D6D34336662714331783876504C6C6E48634C43736662377134375572655A343944776159637673643271537466665077752B35447663756F4545797033622B7A6B2F7333647441655452464961475532514D562F356E4C732B664534467238504738625039334833564B6C7A32642B364746384B306C6B61577445356B687638764758552B6E44615A726E43614F5A57483938452B48726B65714F6F674D4277506C4A544B53456D6C794F694D4667425643427063646B3671504C784B332B5278636D79466A3739304250485A6C4C785778564450504153515564457054444D5A6A61366E554C556F4C6B6631496658723065313966502B7046725A3252664E2B77494C3244494675434E4B615153536C3052464B4555704D7232534C68636D52486A5563726D484A453776362B63596A65396A5647794D39526C4477794F736A454666784F47546B6430476170694B62517A556F504E2B3645474E2B6E7950466D445A71557170416C547844385544445A46334E71387338314C756D4E2B4D32466A4B7774737A4C6B7A3168557271425235487A334E6F53417165496F41674E58584A4F65447844614F683661747239305133427A632B303874306E396858384D453662544B50660A786278714434312B4A346F733052314F4530796F74415754424F4D714C72754D322F4575754F714F596F3630722F56516E626D47454E79786F594E762F48555067386E386538566C6C796C3332356C5A3773364A54796968306A6D594A714871314A553663527A476B635A6B38446B56726A746C4A674D7846627369455531727247337934374B5A46756D3777645766453656344D75744D4E4732536846524247682B7955504D36616769425235453570767A496A49646E6535334D386A72594730336847664744435353454A4F4D7A656C42495931444B524B6451676B4F714750434C6C773977302B4E373055614E493163326C50445A55325A7979617061616B734B7854487242396E564736504B363568322B78627666763630715A742F57622B62324B67797A38664E386E507479544D355A5734356336733879424C496B6B522F4C4D4F57677847653278743852353348575570644E6D3636594D4537332F41554742362B616247682F387762554D57444C6A6D515266374A466B43563038617173694D6A537255754F77743962707244615178476D704E6D4C703650507378366D4D55444F6B636979303773797653637A5A735052766A6D5835734C424F6E63785658632F6647565263556F7939493648307672786D39584E7753427545704331596D6C4E53497044622F4C546F6C4C6F64526C6F3877397352586147'
		||	'30305454656D354A3353357835377A5A35574D6B2B3454546D71456B697144535A5755616C447074565069744646584F7248314755716F68464D616F59534B71677638626873756D347A587155786267494D4A6C5642434A54426B58565A363754543658594135744A674B2F62454D30625447514D77386C74396C6F39526C6F39787A654B3136674C333963623731324A34435162726D78426E38374D4E4C38546955676E32716651374F57567A464F5975726968347A6F7875454569704A315851424A4655647638754F31364651346C4B4B5868635A33647857434E4E6F634E726B3348614745427763544E4554796442593571536831475836756F6238584A6F684B48486138446B4C2B356F6C362F4F4B7044543659786C43435256466C716A3032716E794F6F702B7A394845306A716868456F776F5A4C53644D7264646B70634E75704B6E4158696E4C74794A576E45675356514A512B366347496A786B6870304956676F632B4661346F587932535267566C754235496B45474A347A432B5138656B396C427064714C676D64537846646D4B7A54552B5576763334336F4B4C375A696D55753636616E78426D6F6A2B5749625832775A355A6B2B41725A315265694A70416F6B4D7362534F7A326E4F334D3272386E446873686F75576C464474612F0A77526E2B374D3872396D37765A30427169505A676B4F4F5333717649364B5066596D562F743459756E7A2B62454F5756352B3656556730653239334C76706D3532393862706A71524A617761314A513661796C32634D7265436A3679745A32564453554762335A45306639375377314F3742396A62483663336D6B4562457155797435304776354D72317A5677356271475351744A4A4B56787A787464504C616A6A393239636670696156773268646D5662733563554D47587A3578446D647547545A594B4867366A6151306B754F2B7462703570446E41676C4B51336B7346706B366B7063544333797350355336713434706A36773271352F7537315476594838724D4754706864786D382B756D4A4B7878454339673345326467653575585745447537592F544630677A457A4275343147576A32756467646F57484D786455634E6D616568723877396667692F744333507263666A4B3667616F4C6C7458372B506C6C797A67346D4F4A4866392F50332F634561423149634E474B476E35352B584B2B394A6564644952535342496B56594D5072717A6C7132664E4B646F336C3033476F63693832424C6B746866616561736A516C38736A5632526153707A736171786C47744F6E4D48703879754B37702F52445A37634E6343664E6E57787179644F7832435374475A5137724854564F626D78446C6C6647686C4C536650'
		||	'4C632F744D2F77347A513275425169426967394E6375455367336D4E614159734B4A6D634B4579584F7263446E31314246514C6E6B436F5A794C6759704D546F515A50634531704A414535484A585A6234513032456475376F377A656C762B39505136466235347A6A2F704A5742506A6363386258567A2F304B36693678495A6E62356F686D31645552376532737435573672347865584C6D4673356E464E34312B75643350686F4D3133687772634552314961424742545235676C7462343855517245566237773441372B744B6B77647173746D4B51746D4F536C6C684433764E6E4A4C526376356F706A366E5072743364482B647A394F3369704A565377627A537463584177786662754B476E4E344B4E7247356A3475576C615235392F6F4C412F7362544F51447A446D776643764E34575A6D365647363954495A7773586A59485443667A317839703575334F614E377961426F4734686C32397352346448736644322F7435633650726153702F4E4376332F35596871656242777157662B4F6365564D2B6C6945455033703250336538306C4630665379743078564F38335A6E6C505862656E6C675377393358626D532B64586D64644557545044347A75475866585248307678745A7A38335039334B6979334233504C3941564D5148742F5A54310A393075445A6131696F74526B6F7A754F585A566D3766304448714A62536D35624F314B387044573376343738755738596E6A477650324453633176766249626D376655506939596D6D646A6C434B562F61482B4E584C422F6A752B78667935544E6E41794E455365514E30795241483772786830765047676A63696B536A2B3942757A496D6F734376346251723961525758724F544B3466704548323443784B6D614950664E784F4E71794C63414A386C4C4C53487A42682F426B6C6F66373139574D2B566A6A53593077686B3675384C4E6F6C6F764E54346E417348577A69686275345A767243643344664450442B356B2F6166586F7367536A327A72347A5033627375464949447070316861353876466E4F7A756A51506B335868707A65435466396A4B6F3975485837632B70394C4E32597571634E746C4E72614865573149684474434B61372B347A6161796C32634E4B65636C6F45456C2F786D4D33763734336E665931365642362F442F47303651696B476B796F314A5137736B3579752F3846544C555546387351355A6453574F486C685835415857344B38324D4B347A75446E3967623479463162386B5472665173726D56666C495A625265587848663235342B30787A6743767633734C3654363839354F48633975346F3237706965637561796C3135542F79704D504A365731726E593161466D396F53423447'
		||	'34797261754B47334259597473513275494C7A79346B33732F7552712F327879654F6D3079616331416B6D417771664B5A6537647A6344422F6B6B63496B47566F4B6E506E69644A34676149646F52512F6562344E6748557A2F54535675576A7569374F7A5A2F6937783949362F33542F44686258656A6C2B6C766B673141334256782F657A5739654852616B52722B4C38355A5534624C4C764E305A5A554F722B5A434C5A335375663267586A57564F4C6C39545079784B546D6331354E364D612F7073784B6861324C6F4231553462565A4D595178344B6C5534624A58615A726C533262516B4A6E57706A4E38596B525561573766693863366656666E73775754446274726A57577A53654A4A52513651796E69735A5536596241353153595865484A3361794C613777634E3876505638366177354A61487A504B584A5335375167456263456B64327A6F34436650742B586166337033674F6632426A6C3755535733766469574A306A7A717A336364756C53356C64356B57565164634742594A4964506247386D2B4F575A2F666E43644970633876353552584C57463576577047643452542F6450394F48746E65613559357A756A632B4F67656E76764338547936765339506B4F794B78453875576372703879747935364D2F5A6C6F3263796F6E560A795669553065592F336E31594E34796C31336D6C6F735838364656745A533737577A726A764B566833617A6F54575538332B4D706A6561356E50333738675470472B66503538766E44364C4B7138443352413876724F667A3936335057645A767451533472363375766E734B544D6E31646578434D6256677466584C367372476463334D786153424C576C54733559554D47587A356A44346C6F767453564F2F4734627362524F7930434347783974357245647739625145377636656231396B484D585678584D494934556E424E6D6C33483837444A553357425A58516C32575559666462474F334839304C545244434C774F68653964754A424C5674565337585051455572782F6164617548746A5A3236376545626E6C6D6633382B44566177433465324E6E6E6941644E3876503752395A7A7570474D3969364F354C6D612B75622B663062773866347A754E374F5856657862416F755A315A4B3041437958517179304C4C4F5A516C54482B537A3635515A702F616964634D775A362B4F4B5575477A504B4A6A61647654595A6C367777347635444A6B4F647668554E35365269567879324D73704C563032706E316C4757306D794A49335A377A397436756257352F656A365957715A41695957653769727174574D712F4B764748667636794730786455464A6A4D45684A7A4B7A33387877635773614531784D74445435'
		||	'474D6276424D3877426E4C36724D2B5936794E5070646E4C386B50775A72555930337A346E61486B7A797136453044544364345638376532354F6B4C4C4875666D6952627A63476951514E397434757A504B3975346F396C4657696F54454231665735766B30356C56354F474632767639715044613044685A4D6E332F32354A6C382F72525A75632F487A79726A563163734B32716C5A652B6239647636637059686D42662B3957664F7954333546566E694138747232484A774A74392B665068563950652B3163336C7839525463516A57556B2B30635068633733636954324E4B545A596B626E6A66584779795245314A76732F4C3531525931566A434C5239637A4F61446B62786865334E666E484D58562B553569724D436F3867534E3534376A3274506E6B6C3971524E444343544A3943754B6355595A78654C77726A696D6E692B644D5476336557474E6C353966746F77334434547A4C4B5A745856483659786E63646F566676356F2F5A4C76706767553551514B6F4C3358793166664E34666C3941547043706B5733757A664F7731743768384F304A576D45435366414B614C59704251474E724C576B6741636B6F526A696846663862544F58613933356F317678794E726E325850745936644D714F64457271472B6A4D784C6C63745A53564C0A703954504C4B4F6471744C516447347849696D4E6666324A6E46396D354E2B42554A4B4467366D3852452B2F3231596753456E56394B4D45346D727571546D537A7244356F3631717A452F7065654E416D4D2F6476345065496A64496C6B6433394E455847313766564F626977755746773944467464366363494C7044336974625A41314D2F4C6256413244532B3938693166334434342B784B545A317058762B31466B695774504C7252636C746558634E4B635172477A4B7A4C52744D62445733767A6C6C2B306F72626F554F547352666B7A58567336492B4F6573386D51556775744E386368524A6F332B4A3046677054496D4E6446504B506A735373464438626F304D4F7A574154362B785A573871337A353950674E32653346466D61554442315139415479543876465234376C362B704C396A5735315434344D7261504D7371474666706A71545A3352764C382B2F4E722F6277766B575642636459325642536B4D50342B4D372B3454766336353478394A2B5A5732596A695349796946467579386E6E36512F544630767A64504D414D796270594277644D4B6C4B4C68714D4C62694E45426E4A4F3245505A4D6C476263577030343552476D324347304951546857507A433733324B6B74635A4C536443516B307071525A395A376E5572426246517372664E303877445037516C77494A53694B3577695076534555'
		||	'6D534A396D442B6A4535474D372F763957664F5A6D5037494475367A61645449714E7A2B34594F6E747362344A6F546D376A6D68426B4676704A392F596B386B5232495A376A6C3266316D644C45596A754A565A436C7647475149776537654F4A38366667622F6346776A76332B6A4532484F676644712F6B45757650314E726A696D6E6E383664525A4C363379546A726C4A715162397366775855445356756649737235466B6A35335664516C7A43446D593041724537646E6D514F3732464C6C745A5862313576742B776B6D4E7A73453053326F6E332B2F5246417566434D54564953746B65676364544B6F3876714F666C3174446441796D36496D6B535752305A456C434D347963525A466C65477171384834346557353530624C55343163684933644E5A436C3132635A4D4D566C6558344979596D593070656B6348457A524F3954764C4E47557A722F396252382B353344716D45325755485652634B31766141324E464B575A7559344A77434D4763496F5963616C717146442F4D464D39355164434B626273445A425A327A444650553072795355694E4F68766A5768396646477932307570717A357A796D316C7166475A5A6E6A577768474367704F5835564D6E4E504B7864656154524E55464E7A2F64776933504472396C4F48736A5A39660A663830596E503379324E5538735A456E43625A65524A516D62496858344B72497372792F6867617658384B552F372B4B6C6C68424A56632B4A783966574E2F4F7A4639713438647A35584856734139346876393941504A506E4D2B674B70376C682F65354A6E5963396658455557654B4F6A79796E3347506E743638647A41317467776D565837353867442B38326355314A3837676E302B667A65794B796556486A52614345706474544848774F4A5263786E7032583773736B39474E6E4A426E65573576674F6632426F6F64706F44734F5A616D7155716C4C6C76654E514C6D4C475A4745307A56355A72574450373778585A756672715655464C4E2B587979655A53794A43484C6A4F6C624B3462724D4358516570334B6D4C4F567453574F764165754D65535044493979662F5247302F7A6771636D397A434F55554566366C4F70515A43653659543746536F77755849534A5349324D664C327467616D6D4532656544624F6E4C77373943594C78795A6E4D77335541424A726B6F6C726653625778453156794D786B37726278304E583766346B6E33627A54725A767278753231356557764E6658454F4471594B544769484975646D6877776843684A494A576E344A767A656B2F763439796547587A4675567952574E355A79346649616A703370782B6330665736666632424833685476534A62552B6E6A73732B7534'
		||	'65324D6E50336D2B6A583339695A7734645952536650612B3766783165792B2F76487735546557756E4A57567857315857466A6A7752434639594D6B704A7856596769526D334A32326D522B63736B534C6C35527738315074374B78505A7A7A435556534772632B31386244573376357A556458634E6243516A4E394E4D56534F385A4C6768334C427A4C615956746259673642684D6A664A2F75395275365474536A464E504E4D4674643657566A6A79664E706265324D737163767A6A464E6B362B636B64594D726E396F4637393461646A76353759724844664C7A2F7558316243697755653578343568775055503763724E6B6F35456B615143555A386F726D75794749625A783948584E5A67694F664C306A66554C7575304B73797063324256357A4773756978416A51674B636A6B6F3837686C4534713059325041537843384F304D74794442516B42445A4A49714C716846534E656D56795157675A3354444E624E30674F4D70734834756B4C736759426A4943417A757A39526477696569514B4932504C447559502F4D546B32706E4C453662583837384B67397648416A6E6C6E574555767A687A53362B647662594D3371474B4C78524A4352634E6F57392F58462B2F4E79774265573079587A706A4E6E63664E476967754E4D564D76484A6B0A74636663494D5072613267643974374F54756A5A3238736E38346875697848663138354B34742F50304C787A46376C4F6D39714D624C35712B64504F3778782B4C4D425A576375614353396474362B5A3958442F4A303830444F7437492F6B4F53794F7A667A304B65503462523578515070674B494A715032787A4A674631674A78746144496D325949624C4B457836486B545570382F72525A2F4F7435553473546D6D377532344A714C36664E7138675470597875634E6672427A6D6D61664B2B7A47656141775743644E4D4638376C683148553265704A6A4A49316C4C70516A6C4C4F53554D305971574B52354B304479627A72585A456C2F4334626F56476D596C4F35697A662F35655363395434527555764536616A453635364642476953433775493036692F6855494B4859645A6A564B4355466F6A6D426B376B4730307353476D573067414142484E53555242564C524F573338634A496C41556973597378596A6D4E4749615270433975476C6A7A6E3653776A4A786D51476A6C586C78314868587A50702F6858446F636863507972434E61305A2F4F7946746C78735254455553634978796D79574A50413646423762305A38585A7243307A6C64556B49414333384659754F77793135376378474F66586373587A3569645A30712F736A2F4553793068566A65573573583539456254624F2B4F466A7663704C6C'
		||	'3452533250664759742F2F58424A586B523538474579713965506A44754D4D4F687941564332524E4A353833696A47547A77556A655A344635383164364851564F306A634F544E2F3550683275504C616849457A6B6A6C63366547427A7A78683746444A3675486E7354442F2F4E4749574D6B7330705A6B6A6A694C346E4D6F5279364D4C7844507347754F33656574674F4D38694D7930694E77757176586E58596B636F4E576266693545332B2B627A7A415145426A59454D4550624F425242375549675543534A6D4B367A507A62356D59753471744D5A5449496B4D524254435930546D5A736C6B4E4749614161615573596337546C4B525166474A4F4B454A556C6D34617A50544C7076342F4752592B713536746838483168584F4D305676393343377A5A32466A68727A66614C50336C6C32527A6D6A4C785844534879596F36792F4831506747326A52434E625036677A6E43726162706E627A673875584D686F762B624F6E686A6E4C366D69306A76386C4F754F70506C4F6B53546A6B535179656937774C7072576141306B696D373375564E6E736D4A55536B702F4C464F516E6A4F61596D6B737437335958724473373373436552596744486B55786644737A306A2B75723276495035704E507344795847746A716C773272774B506E644B760A6F436B4E594E2F2F4E4D32626E6C326630454B796B693264555635596C632F5865484342314378414E5448647653503257395646306573644730737258506E6177634C4C4E6D75634A6F6E6467376B4C612F324F5A6852356D4C316A424A576A4167355361703630527A426B5769474761656E47324A6B3770744D57636C793833384D30704B66537247587563594C624A617678454242527363687932774A4A376D7759584B5271326E4E5943436867554F6D5A2B696D71706F67507151336C615A5038314A75433742596652525A61476A5378444E3354585558552B466650616C2B545962624C6C314B4F4B6E783178474268353368464A2B385A79756E7A43336E6A415556314A653671436C7830446D596F697553357645642B62346749637A5A7331574E4A656254624F6733624F364C632F3144752F6A5765664E7A5538462F32396E50567837615454697035516D63652B68702F4F392F3238654F6E68686E4C61786B667057482B6455654849704D577A444A2B6D323942534A58376A455455623934786D792B2F6B687A62766C663375376C386A733363386D714F74624D4B4B5865377951517A3941356D475A4C5A34532F3765786E52554D4A502F72675968376433732F4E543764773672774B6C74623557464C6E78652B7945306C70764E342B574441444E71504D4E5734794D4D423553367159552B6E4F7532'
		||	'6E76663675626D655575726C7258694E397434376D394162373752457452455535703573583944386331384F74584F6E4B576E78447770622F735A452B2F4762387A75384B4E3136485146553754486B71796F5458454D3830442F5054445338664D315A6F712F33726550466F4469627A776845684B34346231752F6E446D3532736D2B6C6E34516A4C495A485232647566344E573245437362536A6831586B56655A50756D6A6A412F656E592F6E7A316C4A6855654F394730786F4F62652F6A323433734F53332B6E772B4D372B2F6E55483762786D5A4F61574654725A5874586A483937596D38755643584C7166504B38546755504368382B637A5A664F4B6572626C316A2B336F353749374E2F505274665735617936534D6C4F5557766F542F506E74486D615575666A4A4A55767A6733374B537065684B4335305054746B4D31696D506B534C66425978755271586943424C67755A6F6B725A4568746D656966314B686742744B4C3439464D38554243614F526865436C6C694774504377564875594B72466E534A444774303839726759577A7235327776354D68544B336E62757557736B506E6D7268762F362B50322F6479794D434844304F5A637A6962306E567A4F492F6433455678383379352B4A3755716F35342F4C4B2F6842314A5534530A7173346237574869475A307172345042704771654E38777056544354546A653068746A51476B4B524A65704B6E4E675573787A47365061583166747938546E586E7A6D483572343476333174324970346147737666393365782B784B4E3256754F3747305269696835654A33737366623057326D766D54545832704B48486A73436B6E564B496A316364706B5072613259634A556B30612F69362B664D3439723778312B73594E6D4347352B75705548742F54677353767337496D6847594B365569654A6A4A3637626E51683642344B4943787A32336E776D6A56636475666D6E446A47306A6F2F664B6156333735326B437176413564644A70525147596750573341444934524F486D56656A7079596D417A6C486A752F2F756879477630756676355376725833646D6530494239764A44552B4A356575727550587233546B68712F786A4D363348392F4C773174374B665059696161306E484F37306D765042626643384D4F7157482F48696B6E4B686E2F6B4C5A4F4731343263634C4172456D56754F2F327844486476374F535A356748715331336D74502B6F33333542745A6362522F6A7A726C7A58514D7441496D396935346C642F547A64504D447343764F6153366F367759524B627A534E45475A73465A442F716A5748765A784B2F39716844676F53556955317867355761333941426778734B42494D5A6E536536'
		||	'77737A47624B2B4B47534A51454B64554A543630786B3278567855696A6157717738684352324469534E766C3837374D68375831454D4F4A714C43592B632F4C3172456B3538376C6F7457464D3939473638615A6158586A6C3252634E735637723571465263737A592F416671736A77754D372B336C2B62784244774F382F766F72725470325A4E3777364545725348556E6A6451772F5133524430426C4F3052354D4672522F7974787937766D4856626E6B596273696364756C53376E316B69563546513430513743765038476242384C73376F336E58576A5A414537334B4F646B587A5244577A425A6346484F4C48647A39386458466732534B3862564A387A6778783961556D425637657450734C5572696D59494C6C3164782B382F76696F764A69696C476E6C527A5974717644783637566F2B66564A54586C784F66797A44727434596D7739476141736D3834594F76684674446F7979784F495A66557054373242575A2F6A784A59745A2F2B6D312F4C2B6C6B3639793268644C4D36504D7852382B735970566A63504448643051764845677A4E4F3742336974625A4146315637752F3951617A686B56424C716A4F3461716D323641314B6930714743692B4B5353495367496B4D79475668694376486738565264382F4E6847487268364453560A4F473133684E4A73367767572F2F54464E70647A37796456355163474B4C5047763538336E7A6F2B7459454831634A6B6A335243304443545931474647672F644530726B5251626E486A697950716A7870557A7A4D714C7551767541477A456C5647306E4A7A314C315166726B706579316E594E44364569537A6B73445563367138544E726B745953456D6A70776869473065794B7759474578686E476656534C5A744C53784B5648356A5639676F61616379666362726F6F7373533569367334666C595A3761456B72375347654F74674A4A636A6C3032456443686D54456C7469594E5A4657364F6E3133473862504B714230616E7332763976444854367A69326559416A2B33737032306F61377661352B435565655663744C794768545665586D736270434F55524E584E2B73377A716A79346244492F7533514A483131625433636B7A6348426C446C6B444B65784B5249315067654E5A53374F5756544632706D6C42535536764136464C3530786D34745831504C437669437674772F5346553452546D716F75714463593562485746546A5939314D662B346D756561454761795A555570484B4556484B456C6E4F4D58427752515A5456446874564E5836755455756556465532664777795A4C6650474D575A7939714A4948742F53777654744B627A5344585A4679695A73584C612F46375A433562485564652F726A'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'75664D37747972665554367A334D3150503779457A357A55784C4E3741757A7169644564535A4E556452525A6F7372726F4D726E594D324D556B36655535345875583752697070636D45644B4D3168573538506E6D467A5777456763697378464B326F3462583435652F6F53504E4D38774C5975387A746C64494F4D5A75433079536979524C6E487A747A4B34536A6E3159326C50484864736678745A7A392F33787667514E4163467458376E5A773874357A4C56746452562B724534314449364F623066456F7A57466A6A52544D4D366B716366504C34526C4B716753464D2F394A4A63347137562B794B784A5872476A67346D454B574A4F495A6E544D58564F522B6B387658314E4D366B4543574A65797978506C4C7A4E705053327039504C79746C39666142676B6C5642794B5449506679656E7A4B376834525731424E48713272552B644D49507A6C31616235587161412F5245302F514E575562656F56493954575575547078547A746F6D63314A4745714D434E524B704C6C376438706C634A557142684A4D594353703477666C4E3270575473426B786B72724F7562562B2F6E6C423762674471395A676B7666642B6970742B304C6774664F727139647737556C4E5262644E3651626633366578742F4E687270532F6931306B794F426A764E0A696B4762582F6A35574C766F314E6D66777277773848616331414D30526554457732356B495A436F4973466C46626248395A4D6D66537369613349555175766B67676B4355703732305332576C786665686C6F4E6B3246566D61644A5A2B526A6651644A474C734A57485568487379746A70434350624641495532647A6E55457536366F5970767270423772754D6E4E557931346E6330474B386335733964376F59727365562F5737462B716E71496A65744C52434835667355363464754347545A76455955475779795850533353716C477A6B70575A48445A686D66576A4B463632646C67306D78666853694D476249723070683172544B366754466B57416B45646B584F6E632B52363059664A317466334244466636654A554857425A686935435A2F734D55623374654352344845314D4C502B672B78712F5A6D35493449305074774D636C726D683778677634454F32386E596A426A503959565A5575726D334E7178673858634E706B616A344D3253594168787033753370575561516E7534697A78573978476949525579586943564674354773766D332F434F43784B592F704E444B654179337636794A4F47796A7930756B6D52654C4A4D566F474B59515A3954323865576656764C744673746A694A4C754F57784F2B4E515A435A5670496D4A7A39316F447655384871352B5A426E764A6A636A2F777450684351'
		||	'78705663676A58632B7831756E444D57475452667A58452B3866394676306C683751533774424962797A2F44694551464F7A397A4D504F31704A4D564C54486A345856732F3238504670347A42444D6566562B383148316536494A6257696B35664A6F466E756F49736976324D42644C624A4B5878733837727173356B7A5A4C76346E51636E6C6B554334762F6977776D56523764337363722B304D4667623967706C644E4A6D354F4D7753624F734938307879675A5342664431526438484A72694364323952656B555056473036776647685A6D5A342B4C69704C48316369694F64654E4B70426D6B4D474E6877426E5A7636645937586655476C4C30353778382B4E394556726A78574D79764136466B2B5A5667435344627441396D434B70465471474E34554D67703233635A7A3047416D704C4B38365154345373786F2B7A4C726C2F3458445072324357685957466D5A69386733726D376E3276753038767A645945464C5345306C7A3071327663754F6A4534636A504C5637674D7676334D49446D37734C676E4E2F2F6C4937582F7A7A54753765324A6B58613655626768736633634F2F50727158712B352B6D306433394A6E756A4C4561616177356E356E31483878624A694849344558473449544D66334E652B67614F7362334737726A45440A62733033687773486C523577757879764255756947654978444D6B52383055644B6D7771655858724D3363676179556F4F497357753557555677736D66734656693336447249306457656B685958464D4163485539792F755A74766E444F50623534377232446F654E39625A7679554C73535953654A672B7270653242656B707354427637392F5163454D38352B33394C4369766F512F66694A2F687134396C47545467516A3366576F317178704C324877774D6C52656367776B5357484A3343395357625975667A6D434442365355686D7A394A653549505556727042754A685062776F323745397A6244596C52427337534F682F6E7236694653495A6B5569637A5170457A7743737466365938384A2F34375135532B495A65674A6C5071573868613566657A494A5A2F7A6A6D79624777734A673843327538664F584D4F667A3068545A65324A64663636777A6E4F4B32463976357A456B7A3659326B693961457A3549634B6B6554794F6A6339315A504C6F3473793366667635444E427950633958706E33764A73654D6B3166397947455043787451316D525954784F7532776C33484D30762B67736D7874336E494A675947446D4653504A46525771766477746651566A6B766577702F33767344336D324E7369417750766A78326D592B663241526C54726F47346E6D71753676316474534F6231426C68345255686A'
		||	'524B6B47545A7762796D6A3350733868395456335857654E3231734C4359416E5A46346C766E7A3065524A4C373335443553366E41747342382B30306F696F374F374E3862473975485970474B704975476B7872372B4F463836597A62586E4469443268496E736253656935383759304546483135647837636633344E75434B4A704D79786F62332B63436F2B64302B5A5838494D504C474A2B7459654D62714463644E4E4E4E343362635A75506D6F71545361613669535A6138395A4A51365646564D6D4E327767795239724F545030564974477462417547325A4E7949477856314C6867575932584C594E4F586A385935747254466C446C56646D2B377862327466344D74327767354249594D57537A32337A4D724C755970664F755A31624470546A732F6D6D666641734C69304965334E4C446C62393747383051664F2F436854793273342F31572F756F4B33567936334E74335065703163797639724B394F3872616D5834653264624862312F76354F4B564E586C31714C6F6961583736664474624F714F55754777634F38765064554F313039304F6D6576753338487A65344E636663494D7172774F50762F4154693564553864663375374235375478793875585565567A63506C76743567684C71506A6C4D5A4331574B30647A33497667502F0A5130596448633174766C744552734E42476F524752486378494455696E504F704B466E4B797672464449516B376E7A647865644F4B63477233384775397239686B353349736773514F4F782B536E324C714B393648315556782B4E317A5543577254664D576C6763435A723734727A574E736A534F682F487A76537A6F7A7447576A4F6F397A735A6947567979645A372B754A55654F306348457752542B73466232784A5A4854654F6869684B357869587057487455312B586D7362704C375569633970343958394965794B7A426B4C4B6B6970426D393352546831626B58754453335A7970597637417379733977396556457945635354485852307236633338424C68574C454B6875616252785130684E425268594671324367705763433875744F7071627759753732576547496E6D70354530794C6F526871337134465333774A73696E64613732717A734C4234627A4246555449525169656A68676B4D766B6C66384756436B573345452B3059596D514B695954583355536C667A553146536453556259576837305357533657787A623975735957466862764C66342F6E4E574C3055316F466C5941414141415355564F524B35435949493D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A20203C2F456D626564646564496D616765733E0D0A20203C506167655769647468'
		||	'3E32332E3235636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D224C44435F494E464F524D4143494F4E5F43455254223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444952454343494F4E223E0D0A202020202020202020203C446174614669656C643E444952454343494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D554E49434950494F223E0D0A202020202020202020203C446174614669656C643E4D554E49434950494F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D4252455F434C49454E5445223E0D0A202020202020202020203C446174614669656C643E4E4F4D4252455F434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224150454C4C49444F5F434C49454E5445223E0D0A202020202020202020203C446174614669656C643E4150454C4C49444F5F434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D5F534F4C49434954414E5445223E0D0A202020202020202020203C446174614669656C643E4E4F4D5F534F4C49434954414E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20'
		||	'202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444F435F534F4C49434954414E5445223E0D0A202020202020202020203C446174614669656C643E444F435F534F4C49434954414E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D554E49434950494F5F4649524D41223E0D0A202020202020202020203C446174614669656C643E4D554E49434950494F5F4649524D413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224645434841223E0D0A202020202020202020203C446174614669656C643E46454348413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444941223E0D0A202020202020202020203C446174614669656C643E4449413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D4553223E0D0A202020202020202020203C446174614669656C643E4D45533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22414E4F223E0D0A202020202020202020203C446174614669656C643E414E4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D5F454D5052455341223E0D0A202020202020202020203C446174614669656C643E4E4F4D5F454D50524553413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472'
		||	'696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444445554441223E0D0A202020202020202020203C446174614669656C643E4444455544413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D4445554441223E0D0A202020202020202020203C446174614669656C643E4D44455544413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22414445554441223E0D0A202020202020202020203C446174614669656C643E4144455544413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224553434153544947414441223E0D0A202020202020202020203C446174614669656C643E45534341535449474144413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F52434153544947414441223E0D0A202020202020202020203C446174614669656C643E56414C4F524341535449474144413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C7264'
		||	'3A446174615365744E616D653E4C44435F434552545F45535441444F5F44455544415F50524F445543544F5F415F46454348413C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4C44435F494E464F524D4143494F4E5F434552543C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F44455544415F4449464552494441223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22444946455249444F223E0D0A202020202020202020203C446174614669656C643E444946455249444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2250524F445543544F223E0D0A202020202020202020203C446174614669656C643E50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F5F50524F445543544F223E0D0A202020202020202020203C446174614669656C643E5449504F5F50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E434550544F223E0D0A202020202020202020203C446174614669656C643E434F4E434550544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444553435F434F4E434550544F223E0D0A202020202020202020203C446174614669656C643E444553435F434F4E434550544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E55'
		||	'4D5F46494E414E223E0D0A202020202020202020203C446174614669656C643E4E554D5F46494E414E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415F494E47223E0D0A202020202020202020203C446174614669656C643E46454348415F494E473C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243554F545F50414354223E0D0A202020202020202020203C446174614669656C643E43554F545F504143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243554F545F43414E43223E0D0A202020202020202020203C446174614669656C643E43554F545F43414E433C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243554F545F50454E44223E0D0A202020202020202020203C446174614669656C643E43554F545F50454E443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525F494E49223E0D0A202020202020202020203C446174614669656C643E56414C4F525F494E493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C445F50454E44223E0D0A202020202020202020203C446174614669656C643E53414C445F50454E443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A2020202020'
		||	'2020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F434552545F45535441444F5F44455544415F50524F445543544F5F415F46454348413C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4C44435F44455544415F44494645524944413C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224C44435F44455544415F434F525249454E5445223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D2250524F445543544F223E0D0A202020202020202020203C446174614669656C643E50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F5F50524F445543544F223E0D0A202020202020202020203C446174614669656C643E5449504F5F50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F5F50524F445F44455343223E0D0A202020202020202020203C446174614669656C643E5449504F5F50524F445F444553433C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E434550544F223E0D0A202020202020202020203C446174614669656C643E434F4E434550544F3C2F446174614669656C643E'
		||	'0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E4344455343223E0D0A202020202020202020203C446174614669656C643E434F4E43444553433C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244455544415F4645434841223E0D0A202020202020202020203C446174614669656C643E44455544415F46454348413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244455544415F3330223E0D0A202020202020202020203C446174614669656C643E44455544415F33303C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244455544415F3630223E0D0A202020202020202020203C446174614669656C643E44455544415F36303C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244455544415F3930223E0D0A202020202020202020203C446174614669656C643E44455544415F39303C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244455544415F4D41533930223E0D0A202020202020202020203C446174614669656C643E44455544415F4D415339303C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C445F444555445F434F5252223E0D0A20'
		||	'2020202020202020203C446174614669656C643E53414C445F444555445F434F52523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C445F444555445F444946223E0D0A202020202020202020203C446174614669656C643E53414C445F444555445F4449463C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C445F444555445F544F54223E0D0A202020202020202020203C446174614669656C643E53414C445F444555445F544F543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F434552545F45535441444F5F44455544415F50524F445543544F5F415F46454348413C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4C44435F44455544415F434F525249454E54453C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F6465202F3E0D0A20203C57696474683E32312E3235636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E31636D3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C5461626C65204E616D653D227461626C6533223E0D0A20202020202020203C5A496E6465783E373C2F5A496E64'
		||	'65783E0D0A20202020202020203C446174615365744E616D653E4C44435F44455544415F434F525249454E54453C2F446174615365744E616D653E0D0A20202020202020203C546F703E342E3735636D3C2F546F703E0D0A20202020202020203C5461626C6547726F7570733E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65335F47726F757031223E0D0A20202020202020202020202020203C4C6162656C3E3D4669656C64732150524F445543544F2E56616C75653C2F4C6162656C3E0D0A20202020202020202020202020203C47726F757045787072657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C64732150524F445543544F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A20202020202020203C2F5461626C6547726F7570733E0D0A20202020202020203C57696474683E32302E3234393939636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783633223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50'
		||	'616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473215449504F5F50524F445F444553432E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783634223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67526967'
		||	'68743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732150524F445543544F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67'
		||	'546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C7565292929204F722053756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783339223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E67'
		||	'4C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F4449462E56616C75652929294F722053756D2843646563284669656C64732153414C445F444555445F4449462E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F4449462E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783531223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C44617461456C656D656E744E616D653E544F54414C44455544413C2F44617461456C656D656E744E616D653E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F544F542E56616C75652929294F722053756D2843646563284669656C64732153414C445F444555445F544F542E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F544F542E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E363235636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A202020202020202020203C47726F7570696E67204E616D653D227461626C65335F44657461696C735F47726F7570223E0D0A2020202020202020202020203C47726F757045787072657373696F6E733E0D0A20202020202020202020202020203C47726F757045787072'
		||	'657373696F6E3E3D4669656C64732150524F445543544F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A2020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A202020202020202020203C2F47726F7570696E673E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E353C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313033223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F783130333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020'
		||	'203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E526573756D656E2045737461646F20646520446575646120506F722050726F647563746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783833223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E675269'
		||	'6768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E50524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783834223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752'
		||	'696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E49442050524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783931223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020'
		||	'20202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E53414C444F20434F525249454E54453C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783932223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020'
		||	'202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E53414C444F20444946455249444F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783933223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C506164'
		||	'64696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E544F54414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E363235636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3839393132636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3334323039636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E342E3333363236636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E342E3333363236636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E342E3333363236636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E322E353139'
		||	'3834636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783934223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E57686974653C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C52696768743E3170743C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464'
		||	'696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313036223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F783130363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A'
		||	'2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E544F54414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313030223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C'
		||	'69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C7565292929204F722053756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874'
		||	'626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313031223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F4449462E56616C75652929294F72205375'
		||	'6D2843646563284669656C64732153414C445F444555445F4449462E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F4449462E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313032223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020'
		||	'20202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C44617461456C656D656E744E616D653E544F54414C44455544413C2F44617461456C656D656E744E616D653E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F544F542E56616C75652929294F722053756D2843646563284669656C64732153414C445F444555445F544F542E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F544F542E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C5461626C65204E616D653D227461626C6532223E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E4C44435F44455544415F44494645524944413C2F446174615365744E616D653E0D0A20202020202020203C546F703E3131636D3C2F546F703E0D0A20202020202020203C5461626C6547726F7570733E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65325F47726F757031223E0D0A20202020202020202020202020203C4C6162656C3E3D4669656C64732150524F445543544F2E56616C75653C2F4C6162656C3E0D0A20202020202020202020202020203C47726F757045787072657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E'
		||	'3E3D4669656C64732150524F445543544F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A2020202020202020202020203C466F6F7465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C436F6C5370616E3E383C2F436F6C5370616E3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783832223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838323C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D22537562746F74616C2022202B204669656C6473215449504F5F50524F445543544F2E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783536223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020202020202020202020202020202020'
		||	'3C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E67284669656C64732156414C4F525F494E492E56616C7565292C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732156414C4F525F494E492E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020'
		||	'202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E67284669656C64732153414C445F50454E442E56616C7565292C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F50454E442E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F466F6F7465723E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A20202020202020203C2F5461626C6547726F7570733E0D0A20202020202020203C57696474683E32302E3535363731636D3C2F57696474683E'
		||	'0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783336223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732150524F445543544F2E56616C75653C2F56616C75653E0D0A2020202020'
		||	'2020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473215449504F5F50524F445543544F2E56616C75653C2F56616C75653E0D0A2020202020'
		||	'2020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321434F4E434550544F2E56616C7565202B222D222B4669656C647321444553435F434F4E434550544F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F5465'
		||	'7874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214E554D5F46494E414E2E56616C75653C2F56616C75653E0D0A2020202020202020202020'
		||	'2020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783233223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4D6964284669656C64732146454348415F494E472E56616C75652C312C31'
		||	'30293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783238223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321'
		||	'43554F545F504143542E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783332223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56'
		||	'616C75653E3D4669656C64732143554F545F43414E432E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783335223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020'
		||	'20202020202020202020203C56616C75653E3D4669656C64732143554F545F50454E442E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783338223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D'
		||	'0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E6379284669656C64732156414C4F525F494E492E56616C75652C302C46414C53452C46414C53452C54525545293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783431223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F53'
		||	'74796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E6379284669656C64732153414C445F50454E442E56616C75652C302C46414C53452C46414C53452C54525545293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E31303C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E57686974653C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E4E6F6E653C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F'
		||	'6D3E4E6F6E653C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E446574616C6C652064652053616C646F7320646966657269646F733C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783333223E0D0A20202020202020202020202020202020'
		||	'2020202020203C72643A44656661756C744E616D653E74657874626F7833333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E49442050524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F7274497465'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783130223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32343C2F5A496E646578'
		||	'3E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E50524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020'
		||	'202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E434F4E434550544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020'
		||	'202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4EC39A4D45524F2044452046494E414E4349414349C3934E3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020'
		||	'202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E464543484120444520494E475245534F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C'
		||	'653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43554F5441532050414354414441533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783331223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020'
		||	'202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43554F54415320464143545552414441533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783334223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A'
		||	'2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43554F5441532050454E4449454E5445533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C546578'
		||	'74626F78204E616D653D2274657874626F783337223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56414C4F5220494E494349414C2044454C20444946455249444F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F'
		||	'5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783430223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E646578'
		||	'3E31363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E53414C444F2050454E4449454E54452044454C20444946455249444F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3733363331636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3733363331636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3235636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3137383631636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3435323431636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3733363331636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E'
		||	'3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3735636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E32333234636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3938343336636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E332E31373436636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E383C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783434223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C656674'
		||	'3E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E544F54414C2044452053414C444F5320444946455249444F533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783538223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C'
		||	'6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E67284669656C64732156414C4F525F494E492E56616C7565292C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732156414C4F525F494E492E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783432223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768'
		||	'743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E67284669656C64732153414C445F50454E442E56616C7565292C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F50454E442E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C446174'
		||	'615365744E616D653E4C44435F44455544415F434F525249454E54453C2F446174615365744E616D653E0D0A20202020202020203C546F703E372E3735636D3C2F546F703E0D0A20202020202020203C5461626C6547726F7570733E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65315F47726F757031223E0D0A20202020202020202020202020203C4C6162656C3E3D4669656C64732150524F445543544F2E56616C75653C2F4C6162656C3E0D0A20202020202020202020202020203C47726F757045787072657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C64732150524F445543544F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A2020202020202020202020203C466F6F7465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C436F6C5370616E3E333C2F436F6C5370616E3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783635223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'20202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E3170743C2F52696768743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D22537562746F74616C2022202B204669656C6473215449504F5F50524F445F444553432E56616C75653C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020'
		||	'20202020202020203C54657874626F78204E616D653D2274657874626F783436223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834363C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E'
		||	'67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F46454348412E56616C7565292929204F722053756D2843646563284669656C64732144455544415F46454348412E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F46454348412E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783735223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A202020'
		||	'202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F33302E56616C7565292929204F722053756D2843646563284669656C64732144455544415F33302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F33302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56'
		||	'616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783736223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E3170743C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E7457656967'
		||	'68743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F36302E56616C7565292929204F722053756D2843646563284669656C64732144455544415F36302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F36302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783737223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020'
		||	'20202020202020202020202020202020203C426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E3170743C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020'
		||	'20202020203C5A496E6465783E31353C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F39302E56616C7565292929204F722053756D2843646563284669656C64732144455544415F39302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F39302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783738223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020'
		||	'20202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F4D415339302E56616C7565292929204F722053756D2843646563284669656C64732144455544415F4D415339302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F4D415339302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783739223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A65'
		||	'3E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C7565292929204F722053756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A202020202020202020202020202020202020202020202020'
		||	'3C54657874626F78204E616D653D2274657874626F783830223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F4449462E56616C75652929294F722053756D2843646563284669656C64732153414C445F444555445F4449462E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153'
		||	'414C445F444555445F4449462E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783831223E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020202020'
		||	'20203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C44617461456C656D656E744E616D653E544F54414C44455544413C2F44617461456C656D656E744E616D653E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F544F542E56616C75652929294F722053756D2843646563284669656C64732153414C445F444555445F544F542E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F544F542E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F466F6F7465723E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A20202020202020203C2F5461626C6547726F7570733E0D0A20202020202020203C57696474683E32302E3439323338636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783435223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834353C2F72643A44656661756C744E616D653E0D0A2020'
		||	'20202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732150524F445543544F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2250524F445543544F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E50524F445543544F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020'
		||	'203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473215449504F5F50524F445F444553432E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434F4E434550544F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434F4E434550544F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661'
		||	'756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321434F4E434550544F2E56616C75652B222D222B4669656C647321434F4E43444553432E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224645434841223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E46454348413C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D494966284669656C64732144455544415F46454348412E56616C75653D302C22222C20466F726D617443757272656E6379284669656C64732144455544415F46454348412E56616C75652C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F525F544F54414C223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F525F544F54414C3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020'
		||	'202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D494966284669656C64732144455544415F33302E56616C75653D302C22222C20466F726D617443757272656E6379284669656C64732144455544415F33302E56616C75652C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2251554F544153223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E61'
		||	'6D653E51554F5441533C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D494966284669656C64732144455544415F36302E56616C75653D302C22222C20466F726D617443757272656E6379284669656C64732144455544415F36302E56616C75652C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020'
		||	'202020202020202020202020203C54657874626F78204E616D653D2251554F5441535F50454449454E544553223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E51554F5441535F50454449454E5445533C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D494966284669656C64732144455544415F39302E56616C75653D302C22222C20466F726D617443757272656E6379284669656C64732144455544415F39302E56616C75652C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020'
		||	'202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F525F51554F5441223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F525F51554F54413C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D494966284669656C64732144455544415F4D415339302E56616C75653D302C22222C20466F726D617443757272656E6379284669656C64732144455544415F4D415339302E56616C75652C302C46414C53452C46414C5345'
		||	'2C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2253414C444F5F444946455249444F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E53414C444F5F444946455249444F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C'
		||	'56616C75653E3D494966284669656C64732153414C445F444555445F434F52522E56616C75653D302C22222C20466F726D617443757272656E6379284669656C64732153414C445F444555445F434F52522E56616C75652C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2253414C444F5F434F525249454E54455F31223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E53414C444F5F434F525249454E54455F313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020202020'
		||	'20202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D494966284669656C64732153414C445F444555445F4449462E56616C75653D302C22222C20466F726D617443757272656E6379284669656C64732153414C445F444555445F4449462E56616C75652C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020'
		||	'202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D466F726D617443757272656E6379284669656C64732153414C445F444555445F544F542E56616C75652C302C46414C53452C46414C53452C54525545293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E363235636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783433223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F7264'
		||	'65725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E49442050524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020202020'
		||	'20203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E50524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C4465'
		||	'6661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E434F4E434550544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020202020202020202020202020'
		||	'2020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E41204C412046454348413C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F'
		||	'723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E333020444941533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783138223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831383C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020'
		||	'3C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E363020444941533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E7465'
		||	'7874626F7832313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E393020444941533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D227465787462'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6F783234223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E2B20393020444941533C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F'
		||	'72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783237223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E53414C444F20444555444120434F525249454E54453C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461'
		||	'626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E53414C444F2044455544412044494645524944413C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F546578'
		||	'74626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E4461726B477261793C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C'
		||	'56616C75653E53414C444F20444555444120544F54414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E363235636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3735393834636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3530383433636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3735393834636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3935373134636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3935373134636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3935373134636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3030383933636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E37313235636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D'
		||	'0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3935373134636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3935373134636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3935373134636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E322E3531393834636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E333C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783530223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F'
		||	'7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C52696768743E3170743C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E544F54414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783537223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D'
		||	'0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E3170743C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020'
		||	'20202020202020202020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F46454348412E56616C7565292929204F722053756D2843646563284669656C64732144455544415F46454348412E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F46454348412E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783533223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E'
		||	'0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C546F703E3170743C2F546F703E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F33302E56616C7565292929204F722053756D2843646563284669656C64732144455544415F33302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F33302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020'
		||	'3C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783534223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E3170743C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020'
		||	'202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F36302E56616C7565292929204F722053756D2843646563284669656C64732144455544415F36302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F36302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783535223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A202020'
		||	'2020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E3170743C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F39302E56616C7565292929204F722053756D28436465'
		||	'63284669656C64732144455544415F39302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F39302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783532223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F'
		||	'74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732144455544415F4D415339302E56616C7565292929204F722053756D2843646563284669656C64732144455544415F4D415339302E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732144455544415F4D415339302E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783437223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69'
		||	'676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C7565292929204F722053756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F434F52522E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783438223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		9332, 
		hextoraw
		(
			'2020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F4449462E56616C75652929294F722053756D2843646563284669656C64732153414C445F444555445F4449462E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F4449462E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C5465787462'
		||	'6F78204E616D653D2274657874626F783439223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C44617461456C656D656E744E616D653E544F54414C44455544413C2F44617461456C656D656E744E616D653E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4949662849734E6F7468696E672853756D2843646563284669656C64732153414C445F444555445F544F542E56616C75652929294F722053756D2843646563284669656C64732153414C445F44455544'
		||	'5F544F542E56616C756529293D302C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D2843646563284669656C64732153414C445F444555445F544F542E56616C756529292C302C46414C53452C46414C53452C5452554529293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78353C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31392E3735636D3C2F546F703E0D0A20202020202020203C57696474683E362E3530373934636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436F726469616C6D656E74652C0D0A0D0A446570617274616D656E746F206465204174656E6369C3B36E2061205573756172696F733C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A2020'
		||	'2020202020203C72643A44656661756C744E616D653E74657874626F78343C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E3135636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020203C4C616E67756167653E65733C2F4C616E67756167653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D224573746520636F6E747261746F20636F6E20636F72746520616C2022202B204669727374284669656C6473214444455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B20222064652022202B200D0A537769746368284669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223031222C22456E65726F222C200D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223032222C224665627265726F222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223033222C224D61727A6F222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223034222C22416272696C222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223035222C224D61796F222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223036222C224A756E696F222C0D0A4669727374284669656C647321'
		||	'4D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223037222C224A756C696F222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223038222C2241676F73746F222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223039222C225365707469656D627265222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223130222C224F637475627265222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223131222C224E6F7669656D627265222C0D0A4669727374284669656C6473214D44455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223132222C2244696369656D62726522290D0A2B20222064652022202B204669727374284669656C6473214144455544412E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B2022207469656E6520756E612064657564612022202B20494966284669727374284669656C64732145534341535449474144412E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229266C743B2667743B2230222C22636173746967616461222C22746F74616C2229202B202220706F7220756E2076616C6F7220646520222B494966284669727374284669656C64732145534341535449474144412E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229266C743B2667743B2230222C4669727374284669656C64732156414C4F524341535449474144412E56616C75652C224C44435F494E464F524D4143494F4E5F4345525422292C4949662849734E6F7468696E672853756D284344626C284669656C64732153414C445F444555445F544F542E56616C7565292C20224C44435F44455544415F434F525249454E54452229292C466F726D617443757272656E63792830292C466F726D617443757272656E63792853756D284344626C284669656C64732153414C445F444555445F544F542E56616C7565292C20224C44435F44455544415F434F525249454E544522292C302C46414C53452C46414C53452C545255452929292B222E223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A20202020202020203C72643A44656661'
		||	'756C744E616D653E74657874626F78333C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31362E35636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E322E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22456C2070726573656E746520646F63756D656E746F2073652065787069646520656E206C612063697564616420646520222B204669727374284669656C6473214D554E49434950494F5F4649524D412E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B20202220656C2064C3AD612022202B204669727374284669656C6473214449412E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B20222064652022202B200D0A537769746368284669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223031222C22456E65726F222C200D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223032222C224665627265726F222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223033222C224D61727A6F222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223034222C22416272696C222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223035222C224D61796F222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229'
		||	'3D223036222C224A756E696F222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223037222C224A756C696F222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223038222C2241676F73746F222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223039222C225365707469656D627265222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223130222C224F637475627265222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223131222C224E6F7669656D627265222C0D0A4669727374284669656C6473214D45532E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422293D223132222C2244696369656D62726522290D0A202B20222064652022202B204669727374284669656C647321414E4F2E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B2022206120736F6C6963697475642064652022202B204669727374284669656C6473214E4F4D5F534F4C49434954414E54452E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B202220717569656E207365206964656E74696669636120636F6E20656C206EC3BA6D65726F20646520646F63756D656E746F204E6F2E2022202B4669727374284669656C647321444F435F534F4C49434954414E54452E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B20222E223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020'
		||	'203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D5F454D50524553412E56616C75652C20224C44435F494E464F524D4143494F4E5F4345525422292B2220686163652020636F6E7374617220207175652020736567C3BA6E2020696E666F726D6163696F6E202064656C202073697374656D6120636F6D65726369616C2C2020656C2020636F6E747261746F2022202B204669727374284669656C647321434F4E545241544F2E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B202220636F72726573706F6E6469656E74652020616C2020736572766963696F20207562696361646F2020656E2020656C206D756E69636970696F2064652022202B204669727374284669656C6473214D554E49434950494F2E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B20222C2061206E6F6D6272652064652022202B204669727374284669656C6473214E4F4D4252455F434C49454E54452E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B20222022202B204669727374284669656C6473214150454C4C49444F5F434C49454E54452E56616C75652C20224C44435F494E464F524D4143494F4E5F434552542229202B20222C2070726573656E7461206C6F73207369677569656E7465732070726F647563746F7320636F6E206C617320636F6E646963696F6E65732066696E616E63696572617320717565206120636F6E74696E756163696F6E20736520646574616C6C616E3A223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874'
		||	'416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E434F4E5354414E4349412045535441444F20444520444555444120504F522050524F445543544F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E3232636D3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E656E2D55533C2F4C616E67756167653E0D0A20203C50616765466F6F7465723E0D0A202020203C5072696E744F6E4669727374506167653E747275653C2F5072696E744F6E4669727374506167653E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78393C2F72643A44656661756C744E616D653E0D0A20202020202020203C57696474683E352E3238393638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E35636D3C2F4C6566743E0D0A20202020202020203C4865'
		||	'696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2022506167696E612022202B20476C6F62616C7321506167654E756D6265722E546F537472696E672829202B20222064652022202B20476C6F62616C7321546F74616C50616765732E546F537472696E6728293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E31636D3C2F4865696768743E0D0A202020203C5072696E744F6E4C617374506167653E747275653C2F5072696E744F6E4C617374506167653E0D0A20203C2F50616765466F6F7465723E0D0A20203C546F704D617267696E3E302E35636D3C2F546F704D617267696E3E0D0A20203C506167654865696768743E32392E37636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_107.cuPlantilla( 94 );
	fetch CONFEXME_107.cuPlantilla into nuIdPlantill;
	close CONFEXME_107.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'PLANTILLA DE CERTIFICADO DE ESTADO DE DEUDA PARA GDC',
		       plannomb = 'LDC_PLAN_DEU_PROD_GDC',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 94;
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
			94,
			blContent ,
			'PLANTILLA DE CERTIFICADO DE ESTADO DE DEUDA PARA GDC',
			'LDC_PLAN_DEU_PROD_GDC',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_107.cuExtractAndMix( 107 );
	fetch CONFEXME_107.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_107.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_CONFEXME_ESTAD_DEUDA_GDC',
		       coeminic = NULL,
		       coempada = '<125>',
		       coempadi = 'LDC_PLAN_DEU_PROD_GDC',
		       coempame = NULL,
		       coemtido = 122,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 107;
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
			107,
			'LDC_CONFEXME_ESTAD_DEUDA_GDC',
			NULL,
			'<125>',
			'LDC_PLAN_DEU_PROD_GDC',
			NULL,
			122,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_107.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_107.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_107.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_107.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_107 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_107'
	);
--}
END;
/

