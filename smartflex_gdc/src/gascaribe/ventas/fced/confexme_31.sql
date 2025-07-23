BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_31 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_31',
		'CREATE OR REPLACE PACKAGE CONFEXME_31 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_31;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_31',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_31 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_31;'
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_31.cuFormat( 62 );
	fetch CONFEXME_31.cuFormat into nuFormatId;
	close CONFEXME_31.cuFormat;

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
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_31.cuFormat( 62 );
	fetch CONFEXME_31.cuFormat into nuFormatId;
	close CONFEXME_31.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_31.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_VENTA_GAS_Y_SOL_INTERNA',
		       formtido = 66,
		       formiden = '<62>',
		       formtico = 49,
		       formdein = '<LDC_VENTA_GAS_Y_SOL_INTERNA>',
		       formdefi = '</LDC_VENTA_GAS_Y_SOL_INTERNA>'
		WHERE  formcodi = CONFEXME_31.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_31.rcED_Formato.formcodi := 62 ;

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
			CONFEXME_31.rcED_Formato.formcodi,
			'LDC_VENTA_GAS_Y_SOL_INTERNA',
			66,
			'<62>',
			49,
			'<LDC_VENTA_GAS_Y_SOL_INTERNA>',
			'</LDC_VENTA_GAS_Y_SOL_INTERNA>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue       number;

	-- CLOBS correspondientes a la definición de las columnas de la sentencia
	clWizardColumns      clob;
	clSelectColumns      clob;
	clListValues         clob;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_31.tbrcGE_Statement( '120096938' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC_VENTA_GAS_Y_SOL_INTERNA_BARCODE]', 5 );
	INSERT INTO GE_Statement
	(
		statement_id,
		module_id,
		description,
		statement,
		name
	)
	VALUES
	(
		CONFEXME_31.tbrcGE_Statement( '120096938' ).statement_id,
		14,
		'LDC_VENTA_GAS_Y_SOL_INTERNA_BARCODE',
		'select  ''415''||dald_parameter.fsbGetValue_Chain(''COD_EAN_CODIGO_BARRAS'')
        ||''8020''||LPAD(to_char(CUPONUME),10,''0'')||chr(200)
        ||''3900''||LPAD(to_char(CUPOVALO),10,''0'')||chr(200)
        ||''96''||to_char(CUPOFECH,''yyyymmdd'') CODE,
        NULL IMAGE
from cupon cu
where cu.cupodocu = to_number(obtenervalorinstancia(''FACTURA'',''FACTCODI''))
AND cu.cupotipo = ''AF''
AND rownum = 1',
		'LDC_VENTA_GAS_Y_SOL_INTERNA_BARCODE'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_31.tbrcGE_Statement( '120096938' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CODE</Name>
    <Description>CODE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>IMAGE</Name>
    <Description>IMAGE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue       number;

	-- CLOBS correspondientes a la definición de las columnas de la sentencia
	clWizardColumns      clob;
	clSelectColumns      clob;
	clListValues         clob;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_31.tbrcGE_Statement( '120096939' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC_VENTA_GAS_Y_SOL_INTERNA]', 5 );
	INSERT INTO GE_Statement
	(
		statement_id,
		module_id,
		description,
		statement,
		name
	)
	VALUES
	(
		CONFEXME_31.tbrcGE_Statement( '120096939' ).statement_id,
		66,
		'LDC_VENTA_GAS_Y_SOL_INTERNA',
		'select decode(subscriber_id, null, null,dage_subscriber.fsbgetsubscriber_name(subscriber_id))||'' ''||
       decode(subscriber_id, null, null,dage_subscriber.fsbgetsubs_last_name(subscriber_id))          CLIENTE ,
       decode(subscriber_id, null, null,dage_subscriber.fsbgetidentification(subscriber_id))          IDENTIFICACION,
       P.document_key                                                   PROYECTO,
       M.SUBSCRIPTION_ID                                                CONTRATO,
       LDC_BOUTILITIES.FSBGETVALORCAMPOTABLA(''MO_ADDRESS'',
            ''PACKAGE_ID'',
            ''ADDRESS'', P.package_id)                                    DIRPROYECTO,
       P.package_id                                                     SOLICITUD,
       C.cupotipo                                                       TIPOCUPON,
       decode(cuponume,null, ''No se ha generado Cupon_'', cuponume)       CUPON,
        ''$''||to_char(decode(cupovalo,null, ''No se ha generado Cup¿n'',
        cupovalo),''FM999,999,999'')                                      VALOR,
        to_char(P.expect_atten_date,''DD-MON-YYYY'')                     VALIDOHASTA ,
        ''CUPON DE PAGO DE ''||
        upper(daps_package_type.fsbgetdescription(
                damo_packages.fnugetpackage_type_id(P.package_id)))     TIPO_SOL
       ,''(415)''||dald_parameter.fsbGetValue_Chain(''COD_EAN_CODIGO_BARRAS'')
        ||''(8020)''||LPAD(to_char(CUPONUME),10,''0'')
        ||''(3900)''||LPAD(to_char(CUPOVALO),10,''0'')
        ||''(96)''||to_char(CUPOFECH,''yyyymmdd'') CODIGODEBARRAS
from open.mo_packages P, open.cupon C, mo_motive M
WHERE C.CUPODOCU = to_number(obtenervalorinstancia(''FACTURA'',''FACTCODI''))
AND C.cupotipo = ''AF''
AND P.PACKAGE_id = cc_bcCoupon.fnuGetPackageByCoupon(C.cuponume, C.cupodocu)
AND M.package_id = P.package_id
AND rownum = 1',
		'LDC_VENTA_GAS_Y_SOL_INTERNA'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_31.tbrcGE_Statement( '120096939' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CLIENTE</Name>
    <Description>CLIENTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>IDENTIFICACION</Name>
    <Description>IDENTIFICACION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>PROYECTO</Name>
    <Description>PROYECTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONTRATO</Name>
    <Description>CONTRATO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIRPROYECTO</Name>
    <Description>DIRPROYECTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>SOLICITUD</Name>
    <Description>SOLICITUD</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPOCUPON</Name>
    <Description>TIPOCUPON</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CUPON</Name>
    <Description>CUPON</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>40</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>VALOR</Name>
    <Description>VALOR</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>VALIDOHASTA</Name>
    <Description>VALIDOHASTA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>11</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_SOL</Name>
    <Description>TIPO_SOL</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CODIGODEBARRAS</Name>
    <Description>CODIGODEBARRAS</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_31.tbrcED_Franja( 2834 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [LDC_FRANJADEPOSITO]', 5 );
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
		CONFEXME_31.tbrcED_Franja( 2834 ).francodi,
		'LDC_FRANJADEPOSITO',
		CONFEXME_31.tbrcED_Franja( 2834 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_31.tbrcED_FranForm( '2683' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_31.tbrcED_FranForm( '2683' ).frfoform := CONFEXME_31.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_31.tbrcED_Franja.exists( 2834 ) ) then
		CONFEXME_31.tbrcED_FranForm( '2683' ).frfofran := CONFEXME_31.tbrcED_Franja( 2834 ).francodi;
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
		CONFEXME_31.tbrcED_FranForm( '2683' ).frfocodi,
		CONFEXME_31.tbrcED_FranForm( '2683' ).frfoform,
		CONFEXME_31.tbrcED_FranForm( '2683' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_31.tbrcED_FuenDato( '2656' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_31.tbrcGE_Statement.exists( '120096938' ) ) then
		CONFEXME_31.tbrcED_FuenDato( '2656' ).fudasent := CONFEXME_31.tbrcGE_Statement( '120096938' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_VENTA_GAS_Y_SOL_INTERNA_BARCODE]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_31.tbrcED_FuenDato( '2656' ).fudacodi,
		'LDC_VENTA_GAS_Y_SOL_INTERNA_BARCODE',
		NULL,
		CONFEXME_31.tbrcED_FuenDato( '2656' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_31.tbrcGE_Statement.exists( '120096939' ) ) then
		CONFEXME_31.tbrcED_FuenDato( '2657' ).fudasent := CONFEXME_31.tbrcGE_Statement( '120096939' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_VENTA_GAS_Y_SOL_INTERNA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi,
		'LDC_VENTA_GAS_Y_SOL_INTERNA',
		NULL,
		CONFEXME_31.tbrcED_FuenDato( '2657' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20829' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2656' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20829' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2656' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CODE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20829' ).atfdcodi,
		'CODE',
		'CODE',
		1,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20829' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20830' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2656' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20830' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2656' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [IMAGE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20830' ).atfdcodi,
		'IMAGE',
		'IMAGE',
		2,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20830' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20831' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20831' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CLIENTE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20831' ).atfdcodi,
		'CLIENTE',
		'CLIENTE',
		1,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20831' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20832' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20832' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [IDENTIFICACION]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20832' ).atfdcodi,
		'IDENTIFICACION',
		'IDENTIFICACION',
		2,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20832' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20833' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20833' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [PROYECTO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20833' ).atfdcodi,
		'PROYECTO',
		'PROYECTO',
		3,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20833' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20834' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20834' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
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
		CONFEXME_31.tbrcED_AtriFuda( '20834' ).atfdcodi,
		'CONTRATO',
		'CONTRATO',
		4,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20834' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20835' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20835' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DIRPROYECTO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20835' ).atfdcodi,
		'DIRPROYECTO',
		'DIRPROYECTO',
		5,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20835' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20836' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20836' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [SOLICITUD]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20836' ).atfdcodi,
		'SOLICITUD',
		'SOLICITUD',
		6,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20836' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20837' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20837' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TIPOCUPON]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20837' ).atfdcodi,
		'TIPOCUPON',
		'TIPOCUPON',
		7,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20837' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20838' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20838' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CUPON]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20838' ).atfdcodi,
		'CUPON',
		'CUPON',
		8,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20838' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20839' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20839' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [VALOR]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20839' ).atfdcodi,
		'VALOR',
		'VALOR',
		9,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20839' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20840' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20840' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [VALIDOHASTA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20840' ).atfdcodi,
		'VALIDOHASTA',
		'VALIDOHASTA',
		10,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20840' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20841' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20841' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TIPO_SOL]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20841' ).atfdcodi,
		'TIPO_SOL',
		'TIPO_SOL',
		11,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20841' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_31.tbrcED_AtriFuda( '20842' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_AtriFuda( '20842' ).atfdfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CODIGODEBARRAS]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_31.tbrcED_AtriFuda( '20842' ).atfdcodi,
		'CODIGODEBARRAS',
		'CODIGODEBARRAS',
		12,
		'S',
		CONFEXME_31.tbrcED_AtriFuda( '20842' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_31.tbrcED_Bloque( 4373 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2656' ) ) then
		CONFEXME_31.tbrcED_Bloque( 4373 ).bloqfuda := CONFEXME_31.tbrcED_FuenDato( '2656' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_EXTRA_BARCODE_]', 5 );
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
		CONFEXME_31.tbrcED_Bloque( 4373 ).bloqcodi,
		'LDC_EXTRA_BARCODE_',
		CONFEXME_31.tbrcED_Bloque( 4373 ).bloqtibl,
		CONFEXME_31.tbrcED_Bloque( 4373 ).bloqfuda,
		'<EXTRA_BARCODE_>',
		'</EXTRA_BARCODE_>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_31.tbrcED_Bloque( 4374 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_31.tbrcED_FuenDato.exists( '2657' ) ) then
		CONFEXME_31.tbrcED_Bloque( 4374 ).bloqfuda := CONFEXME_31.tbrcED_FuenDato( '2657' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [LDC_BLOQUEDEPOSITO]', 5 );
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
		CONFEXME_31.tbrcED_Bloque( 4374 ).bloqcodi,
		'LDC_BLOQUEDEPOSITO',
		CONFEXME_31.tbrcED_Bloque( 4374 ).bloqtibl,
		CONFEXME_31.tbrcED_Bloque( 4374 ).bloqfuda,
		'<LDC_FRANJADEPOSITO_LDC_BLOQUEDEPOSITO>',
		'</LDC_FRANJADEPOSITO_LDC_BLOQUEDEPOSITO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrfrfo := CONFEXME_31.tbrcED_FranForm( '2683' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_31.tbrcED_Bloque.exists( 4373 ) ) then
		CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrbloq := CONFEXME_31.tbrcED_Bloque( 4373 ).bloqcodi;
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
		CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrcodi,
		CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrbloq,
		CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrfrfo,
		1,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrfrfo := CONFEXME_31.tbrcED_FranForm( '2683' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_31.tbrcED_Bloque.exists( 4374 ) ) then
		CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrbloq := CONFEXME_31.tbrcED_Bloque( 4374 ).bloqcodi;
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
		CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi,
		CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrbloq,
		CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25045' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25045' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20829' ) ) then
		CONFEXME_31.tbrcED_Item( '25045' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20829' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CODE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25045' ).itemcodi,
		'CODE',
		CONFEXME_31.tbrcED_Item( '25045' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25045' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25045' ).itemgren,
		NULL,
		1,
		'<CODE>',
		'</CODE>',
		CONFEXME_31.tbrcED_Item( '25045' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25046' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25046' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20830' ) ) then
		CONFEXME_31.tbrcED_Item( '25046' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20830' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [IMAGE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25046' ).itemcodi,
		'IMAGE',
		CONFEXME_31.tbrcED_Item( '25046' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25046' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25046' ).itemgren,
		NULL,
		1,
		'<IMAGE>',
		'</IMAGE>',
		CONFEXME_31.tbrcED_Item( '25046' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25047' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25047' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20831' ) ) then
		CONFEXME_31.tbrcED_Item( '25047' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20831' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CLIENTE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25047' ).itemcodi,
		'CLIENTE',
		CONFEXME_31.tbrcED_Item( '25047' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25047' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25047' ).itemgren,
		NULL,
		1,
		'<CLIENTE>',
		'</CLIENTE>',
		CONFEXME_31.tbrcED_Item( '25047' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25048' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25048' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20832' ) ) then
		CONFEXME_31.tbrcED_Item( '25048' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20832' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [IDENTIFICACION]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25048' ).itemcodi,
		'IDENTIFICACION',
		CONFEXME_31.tbrcED_Item( '25048' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25048' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25048' ).itemgren,
		NULL,
		1,
		'<IDENTIFICACION>',
		'</IDENTIFICACION>',
		CONFEXME_31.tbrcED_Item( '25048' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25049' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25049' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20833' ) ) then
		CONFEXME_31.tbrcED_Item( '25049' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20833' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [PROYECTO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25049' ).itemcodi,
		'PROYECTO',
		CONFEXME_31.tbrcED_Item( '25049' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25049' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25049' ).itemgren,
		NULL,
		1,
		'<PROYECTO>',
		'</PROYECTO>',
		CONFEXME_31.tbrcED_Item( '25049' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25050' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25050' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20834' ) ) then
		CONFEXME_31.tbrcED_Item( '25050' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20834' ).atfdcodi;
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
		CONFEXME_31.tbrcED_Item( '25050' ).itemcodi,
		'CONTRATO',
		CONFEXME_31.tbrcED_Item( '25050' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25050' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25050' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_31.tbrcED_Item( '25050' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25051' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25051' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20835' ) ) then
		CONFEXME_31.tbrcED_Item( '25051' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20835' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [DIRPROYECTO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25051' ).itemcodi,
		'DIRPROYECTO',
		CONFEXME_31.tbrcED_Item( '25051' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25051' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25051' ).itemgren,
		NULL,
		1,
		'<DIRPROYECTO>',
		'</DIRPROYECTO>',
		CONFEXME_31.tbrcED_Item( '25051' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25052' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25052' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20836' ) ) then
		CONFEXME_31.tbrcED_Item( '25052' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20836' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [SOLICITUD]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25052' ).itemcodi,
		'SOLICITUD',
		CONFEXME_31.tbrcED_Item( '25052' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25052' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25052' ).itemgren,
		NULL,
		2,
		'<SOLICITUD>',
		'</SOLICITUD>',
		CONFEXME_31.tbrcED_Item( '25052' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25053' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25053' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20837' ) ) then
		CONFEXME_31.tbrcED_Item( '25053' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20837' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TIPOCUPON]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25053' ).itemcodi,
		'TIPOCUPON',
		CONFEXME_31.tbrcED_Item( '25053' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25053' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25053' ).itemgren,
		NULL,
		1,
		'<TIPOCUPON>',
		'</TIPOCUPON>',
		CONFEXME_31.tbrcED_Item( '25053' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25054' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25054' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20838' ) ) then
		CONFEXME_31.tbrcED_Item( '25054' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20838' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CUPON]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25054' ).itemcodi,
		'CUPON',
		CONFEXME_31.tbrcED_Item( '25054' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25054' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25054' ).itemgren,
		NULL,
		1,
		'<CUPON>',
		'</CUPON>',
		CONFEXME_31.tbrcED_Item( '25054' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25055' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25055' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20839' ) ) then
		CONFEXME_31.tbrcED_Item( '25055' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20839' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [VALOR]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25055' ).itemcodi,
		'VALOR',
		CONFEXME_31.tbrcED_Item( '25055' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25055' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25055' ).itemgren,
		NULL,
		1,
		'<VALOR>',
		'</VALOR>',
		CONFEXME_31.tbrcED_Item( '25055' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25056' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25056' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20840' ) ) then
		CONFEXME_31.tbrcED_Item( '25056' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20840' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [VALIDOHASTA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25056' ).itemcodi,
		'VALIDOHASTA',
		CONFEXME_31.tbrcED_Item( '25056' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25056' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25056' ).itemgren,
		NULL,
		1,
		'<VALIDOHASTA>',
		'</VALIDOHASTA>',
		CONFEXME_31.tbrcED_Item( '25056' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25057' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25057' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20841' ) ) then
		CONFEXME_31.tbrcED_Item( '25057' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20841' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TIPO_SOL]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25057' ).itemcodi,
		'TIPO_SOL',
		CONFEXME_31.tbrcED_Item( '25057' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25057' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25057' ).itemgren,
		NULL,
		1,
		'<TIPO_SOL>',
		'</TIPO_SOL>',
		CONFEXME_31.tbrcED_Item( '25057' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_31.tbrcED_Item( '25058' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_31.tbrcED_Item( '25058' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_31.tbrcED_AtriFuda.exists( '20842' ) ) then
		CONFEXME_31.tbrcED_Item( '25058' ).itematfd := CONFEXME_31.tbrcED_AtriFuda( '20842' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CODIGODEBARRAS]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_31.tbrcED_Item( '25058' ).itemcodi,
		'CODIGODEBARRAS',
		CONFEXME_31.tbrcED_Item( '25058' ).itemceid,
		NULL,
		CONFEXME_31.tbrcED_Item( '25058' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_31.tbrcED_Item( '25058' ).itemgren,
		NULL,
		1,
		'<CODIGODEBARRAS>',
		'</CODIGODEBARRAS>',
		CONFEXME_31.tbrcED_Item( '25058' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25000' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25000' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25045' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25000' ).itblitem := CONFEXME_31.tbrcED_Item( '25045' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25000' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25000' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25000' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25001' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25001' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4537' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25046' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25001' ).itblitem := CONFEXME_31.tbrcED_Item( '25046' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25001' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25001' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25001' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25002' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25002' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25047' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25002' ).itblitem := CONFEXME_31.tbrcED_Item( '25047' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25002' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25002' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25002' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25003' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25003' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25048' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25003' ).itblitem := CONFEXME_31.tbrcED_Item( '25048' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25003' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25003' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25003' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25004' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25004' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25049' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25004' ).itblitem := CONFEXME_31.tbrcED_Item( '25049' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25004' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25004' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25004' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25005' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25005' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25050' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25005' ).itblitem := CONFEXME_31.tbrcED_Item( '25050' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25005' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25005' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25005' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25006' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25006' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25051' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25006' ).itblitem := CONFEXME_31.tbrcED_Item( '25051' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25006' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25006' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25006' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25007' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25007' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25052' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25007' ).itblitem := CONFEXME_31.tbrcED_Item( '25052' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25007' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25007' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25007' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25008' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25008' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25053' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25008' ).itblitem := CONFEXME_31.tbrcED_Item( '25053' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25008' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25008' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25008' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25009' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25009' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25054' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25009' ).itblitem := CONFEXME_31.tbrcED_Item( '25054' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25009' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25009' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25009' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25010' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25010' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25055' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25010' ).itblitem := CONFEXME_31.tbrcED_Item( '25055' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25010' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25010' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25010' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25011' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25011' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25056' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25011' ).itblitem := CONFEXME_31.tbrcED_Item( '25056' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25011' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25011' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25011' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25012' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25012' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25057' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25012' ).itblitem := CONFEXME_31.tbrcED_Item( '25057' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25012' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25012' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25012' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_31.tbrcED_ItemBloq( '25013' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_31.tbrcED_ItemBloq( '25013' ).itblblfr := CONFEXME_31.tbrcED_BloqFran( '4538' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_31.tbrcED_Item.exists( '25058' ) ) then
		CONFEXME_31.tbrcED_ItemBloq( '25013' ).itblitem := CONFEXME_31.tbrcED_Item( '25058' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_31.tbrcED_ItemBloq( '25013' ).itblcodi,
		CONFEXME_31.tbrcED_ItemBloq( '25013' ).itblitem,
		CONFEXME_31.tbrcED_ItemBloq( '25013' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
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
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E64653135386330622D373562662D343566632D383235632D3534313763356464653562343C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C52696768744D617267696E3E302E32636D3C2F52696768744D617267696E3E0D0A20203C4C6566744D617267696E3E302E32636D3C2F4C6566744D617267696E3E0D0A20203C426F74746F6D4D617267696E3E302E32636D3C2F426F74746F6D4D617267696E3E0D0A20203C72643A5265706F727449443E61313338396464612D626332392D343533652D383064382D6538623530326535343435653C2F72643A5265706F727449443E0D0A20203C456D626564646564496D616765733E0D0A202020203C456D626564646564496D616765204E616D653D226C6F676F5F67646F5F736C6F67616E5F616C7461223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970'
		||	'653E0D0A2020202020203C496D616765446174613E6956424F5277304B47676F414141414E5355684555674141414D7341414142784341494141414430794D42334141414141584E535230494172733463365141414141526E51553142414143786A777638595155414141414A6345685A6377414144734D4141413744416364767147514141452B655355524256486865376233335878544C3169372B2F512F75443939663376752B39397954397437714E70457A4130504F4B4762466E434F495368424A676C6D5549456853524849596D426D476F4A687A776877775A79534879626E75553933444F4F494F5A352B7A392B667377325A39466B313364566656716C565072625771757166372F794F6A4E45712F4A593069624A522B577A496954506448596733443671456445394C2F414C502F465271316C756A41766631646569616A547138614B6F45706C72304F752B794F6F61342F4D6C50365979494D4446697743474D507679534B6A383962466A41716E565A443945435953714E6B45576243544348736464686C6477776C2F35475A3068385A595550494D504350456773594C534370707A6A544535324F614C553635536A43666F34702F57455239677359614A484B56454159574B7055345643747864626F5A456352396D4E4D6152526859434E516670694246726C43533232596A696A55464478714F457A455A4E534D41576444337059464673706A647A36582F34646C536E395968426B4A2B30597773584178347362414644423641752F34346C555863455A52684F424D72315672354550584D4E6C5A594B45386475647A58583959706A534B4D4F77623451567367594562646F646C426D45363875783562384652486E4147744346466F7A454635536A43667041702F5445525A6B6F34484159766C6733775968456D6B354961336F576C79364C5A4F4238704B6857375647474B4D4F5945796874466D4945706A53494D68306145796656457074564C57486A31396E58676C45496841317165504F7032634A675A45354D756B314D623174637670546E70656869626B51485A4B4D4B474D365652684F455143474D74466B5559646C527173556F4E444E45724E526F642F4748437473506A762F64627447696256456142704D53314F4B565644456359572F776F7767784D615252684F50794D4D48594849627857433941517155534638366450335861306E5731744F546377594631764C3145775A6D776F37796A43666F49706A53494D6830597653566B6937614F4A656A4C517238422F705979457A6F32774D5A3854364C66466E627669377430656A5970426D4146446F776A3743615930696A41636D694A4D6A63434C4A75754A45685A4E53346F4C477964'
		||	'503850666772416B4F694C577A57584373384B78650A533952716F7458416752726A4D415A6B6F7767627A70524745595A4449384C554B6A57466C3053733143464E533936386B484764356E71344C7664794466666B62724B78584C4235557859515268646339595478704B4D492B776D6D4E496F77484C49496F367857417974454D716A5677305170794C36644A57502F356A566A536F79486337695832785A6E682B58425165477658387030374D49727A54754B734A3967536E3955684C45672B41496C624A69766B53745564453156527936636665484757657A4E58652F747673585665584F416237774C5A355735786451362F6D574A4743375357414B494C51466252474E736F6847313244466C4E70464E5A79543554456278526778542B6B4D694441686764796B55304E6E416C6F535151577731656F6C454B59574647685354566176326370785863376C626E4A30695856775476663253374A77576D316E377277754C372B785753735830555236356D4A5944303865736F673171645032493338447448633877565642722B316E6B596661673163482F6F694C7045464D305538556245416B796B5843454D4B552F4D4D494D6E67344951333954664F677079375745786D43432B68762B675A7573625661346372647933524E64505A4A746E545946686D7A6C75432B79645A7079764C525A71794E30536F424C745551696F61746F65744B7649682F466D6A6366752B3964756961514B74377043514149564B6E56476E7142627167695A6F7430426D4773554A2F3352684A542B6D4D6A44467345584159584B5157384E446F6C6B71564B736D626444687537686462574B7A3038347A30396B317A646F2B30634E3079647673764C4A33724D754A4351615245794F6447674A4F5965705A7236527032655346546B39647675706A4C2B74715A5442564C4642364F7459682F313057685A3677563466596D77555273323076674C684B487436476B61472B6D4A5271716B7A3445316E726A6C35725855316E344A68785068353538434D2B624532656A6A462B66694575767147752F726D7A445A6650614239424A6379624B4B46716B524B39342B66466C3734757257354853762B3231435175416970547139584B4E524D524D49564D5A365A425A6B51776944414B4D4947326E4D49737A495133324D4465434343477A35796B52487A6D4A6E7A6A7058626C52513046346E7032676E353032424154747372614B6348524B6D54302F6A754B793374672B35634F554F4D494A4A7031676C31704342746A644E523671575A355334706857356434757641474561335143444B694B584B356E62414B6A4D434C4A526849316B5A6A7156335755376D486B6D527776576B58'
		||	'4D586E70745A546E6479576558734573357869664C0A3133655873484F664F5458527A54654A796B724231636F344D6E706F30626C4C517768557864352B2B55524C4538503258376C59644634526E6C51626B3878307A7935773742733571394E31795A54654C4D4956636F314C7168683734595A3379614B512F346E6B495734596A485956586279384A44382B595A44624C68627352427379467535586A477364315466486B37486531332B6E70767433644D39724F6162566E514354484D327969376478566D2F632B372B7838314837705150475350556535685930654A536564306F72746E6E2B6F302B67374D62566B45615A68467374554B6B414B6C6245675978474751794D4E43545A796D4E49664532476D666377594D415A655769323565624E337771515A726D3452514A4B6E54344B6E39335A622B3068337439327564716B2B3348526E7032675874374370632B496E4F537A796D705A6F3662622B37315A546475546D70466645377932646666783053487231704433482F31496B386E6E79707079514472686374555A43317A4A51442B5943384D475549414267787A496A414356543855594D55787268434E50704E486F394F765A7A436735316571564732344D3453617366704D2F6136346C4B536352696569396F34594B645163454A7A693452446F3662754F3778586A34375844325348427A6A505A3354504A7A3363643169586230334F66717374665A6350646C742F515333745A76336C79586B357152574A6D614A5668787538737353575766784A325A56637937667979546B76595A30364F69436855367030427273705945414C4350435073733234706A53794566594D4A42686E336B49724F4E742B785567514576453648636167576E4A3161766448703662584C6962485A32324F4470487533446A586477544B62736D65726E7564625A4E344C6A4765415A75732F4D4F48384E5A3544787236394B6B49386B6C3962757253772F57703259326273356F6D4A565237356F68734D6A6975516A506269586B42534566784C4A33444A4B49556A486B6C796B5A4554617951555A7068434E4D7131574468356B7851695271386F7A6674452B6865366F6E76537174444B6542734D54454D6B75725A66594F4561367532317A64674B633442303673457A665731524F685749797253777A736D5A4E33776B53336A655A4234664D534D314D62542B3172454F787672446A51574A41713270334B3335444B6E3535527A386B5775682B7457537A565853506B5A622B6B6A596E726466313945684F4551515A544D7A5A5351555A7068434E4D6F3145425954426A5836595066756F2F6B336C6B385A764F6B33715947575758584B562F3955626848376A4A31'
		||	'6E364E43777956643471373930356E627277394A390A71424738337869485A32436650316A2B56364A3431333247546874335632624F36324373484F45384C4568744C452B6D50624255557074646D3765556E372B5773794771626D69414B7A7932653150736B6A354446384A624F497278614C70535A65456A4B4D496D78454D417576723278593734505852616E35552F677443587279516B743663627267614C324E33514B752B325A33397752336A7852586A78534F5735496A4E3962524C63625A6651765849387A564D387943733848434F334A3652453543785A6C644A31733238516F6A42595852676D4F787461584A64636633384C4E5342556C70776857482B504D4B616B4F4C654D756C756B76776C547253425450476D464B4472686B5A52684532497669484933335363656E65766F7A6A6672734F4254313579314F5464695652726C6939316470754868444763593131356951347569513475535679504F49356E747463504B4D3866534D6E327936597A466B2B4B2F786759736E4A336330583468714545667A53794D614B7149614B6266573837614C4B76614A6A427752704232726A3071705746776F58702B623533583265437A4F6D4A653931314978704E426F4977424A325268453245686D41677933526B412B386C6E58354E5148376376327147376339656E33365375746C562F63515A39656C7A6937687A6935624F53364A7A74776B5A2F636B426D4778726C35624F647849422F634E553566484A7877705033447952454A39585552746258527A633254546963696D2B6D685256574A44385735522F7637366E4833566D516372456E4F714675535754366C7143482F544B644B5464337043462F64527655485A564A6852685031484D6B76594D65302F4A72356D504A524F72394C6F7847725364726A4D2F33694458396D4A52616C4846705457483979567557654D75624F7237796F48376E6F587A786750337952333332526E727A68377A7868377A7967486E366A78647375436C327950505678386F4547305131533175615A345931317456504F707A51307445554C684A6B455A66475753384D677559644665586C6C71646672656F6E6D56703563644C504A76755A704179454E43326D6D3850795147534738513246524F4E6D556B4D615752684C445053474C366A48324551553158553158306A714E61535A696E614E716666536A4E4B4C484A7262584F34516364716C325A55624E6A353948302B5A76697258775763344C434A7A73766377335937447372337378746A626E4842727667324739636C30384D584C497070796A74524573436E356659554A6438716A46614A4E78554C397773716F385543614A45764B33314E5848437167522B'
		||	'545649646279652F494B56696262596F4E497676650A62694B652F3547444347336162797670412F423071646E746651474B435456306674554D7231657A41673872446B6A67436D4E59495168394B47544F4B546F6D4A396E4D773949342B2F31335264704753575444764D6D48367231546131656571423256325A39325A3579515578577455646F704A5876696E454F4D3832343832304431707235724A6E734838465A47423958584C4E62564C39544A497A6C5663554A3668434578596A344D593243534645644F457055463131667431556F69425549347669434A454852666C466965734F4374447148394D724A31513354487A2F4F316B7066302F73476A4B52416D4162594D73674C304574484566596677542B414D4431524752464766786C45663350373473794E2B4B777979774B2B6254592F6548663534755453784832436B737A6D4D356D4E313365576E6B7A4935632F62754E74332F68612F4254486675797A34712F32384B57743370745931783557574A504F71553175616B2B72356D36704B6F2F6856385366716753306A4D79436A4F4573514668316F3370334B583343677A756C51725756757155746C31624A487477564550556A30674468395441696D4653426A6849576F37484D5777356F7A41706A5343456559567164416968354847734C2B786C5A4A48764361312B5757327830564F4F634B5A2B3672587056596C7052516D5A3959553564513262536E396B7A4F69527670764A6145374C4C7748546D4C7436524737696B76502F766B734F68555647376574754C6A6163314E7958786554465635764C4132686C384E5649474E43474E5945463966764975667372646D555561393235456D7037787935384D4641634B366C4C62377034692B6D35422B505A466F6949703571677A45686D4B6A435075394D33726F4278436D67383041776E425353323976493256416566566F35627938557164386E6B734F662F5A42596353752B6F50624730726942634B6F477548475978564A6C594C636B2B657A42536633487550566E72337A546B7A6E6761396B47763674316D79526147394E39626269597A426D757871455779714B5934574977486A524442754E5756783961557274377633384E5A6B4E33726D4E6467553878364D6C6669584661367372742F634E3343546B765A3530615145794C624E4152752B376A30683467536D4E594951687A4466455957796B542F7553394C54336E387775436A6E4F38793767655237697A64334C333753724D5350705A4F573245364A6F5555504B71644F7831627A64646257706C56565A56585550336E625257356853657675366835426E5972486F337031393152554A78555570745658622B627834515930'
		||	'525A4D415747355A74465A587462546963336843560A4A764A4C727A584C7137557571664D744C6C75596E372F383172333850766C6C50586D744A543171694D5549504F51766837566F4244436C455938774A557958577345674450474F2B75324C6A7A57486A67575638494F4F3141536D31537A635852635A56352B2B525653385563514C45776D324E546447567064474863765A57333738784D32626731724563615266546A716C536B414E4F4F765161792B39656E366B35635375367649397774716B75686F575A4561456257366F69785A56374738755043694B503141666B434777794B73314C2B49354631644D50316F53576C717A6F753164735A3438314A49504B71324D536F766F48384B4F497578337A384D51686B4D447772526176516F49777956454D796876652F4B32354E4378674C7853372B7A4B345053366C58736245684D61737A63316C6F5931316D3573466D30555675303479552F6D465230397858387637514F386D463935304F4B77333632516F555467374B6D345037653550763734305232315651425A6E4C41475A73774559565737524D6632386850534771666D747A67646262444D717A493755753556566A746E5434624C31516537744F536D6C727857304D4366455777555966384A44417959504C5A71514A684554774175656F5A354751586D6365397254327A4A4C5A397970436F6B767A62305548333437735964323570794978724C4E7A547877357345555932386849614B354A71433173356E4D7149577177416E6D6C314658365A50437856724E53675271666537507857304E43615646753053384F4A7171336164615937676C612B724C74357A34314A596458474B7348515050325666665568617657574F63507752767357786172656A6C623648537A31794B715938377972566B6D6361444143497169566154435648456662375A6E54393177696A502B6B78496B784A2F364D6E58396330682B6557422B64587A6369705735786548376D7263573973303547497873717752763747527348577072704E70626C566438353830505A4936652F6259463530656A587346363046495A4E557163446341595831454D32646A672F5A44667A59343063536552564A7346363838706A47757130744456483131636E43696C33383358767270783273747A3563503735414D4B6D5135335330326932763075317768632F4E35326B61386C696C363245525273336A4B4D4A2B332F787A43414E53364B73435948706556445373794B304B7971365A6459692F346F416F646D666A6757324E7837614971694E452F45695249453555473132633236627145424E356A364B546D6A3239686B45596F4162576148524B44544E7A67453245787A'
		||	'7A54396969787542432B4D713636596D747456664B0A5A357658565A58484E776D52683155372B337233314D7777494530346F784979796D6E753031763177706166773469594E65614451646C445A5543713739767046693059475578717043454D694545626A4D445964305A694F39477249772B4E3138773958423254557A6B3054724E737653746A5A6B4C36746F53537976695A534B4E777172492B767154783673615750714756454C6C58337351696A72464D5348667344495761396C4767565249384B4F6F6D322B4D4C70335455563864566C4D474F4A5463494E6C61574A4A2B71427342542B2F74333173314A46746C6B696972416A745934464E533748684235415746374E6243323570394332517A617467726C464F597177337A662F464D4C6F307A733042556E64557533316771707068336E2B422B744339776E44396A527354326E496968655678516A34572B7671452B7271642F4A71486B76367845536C596C342F495A50323038557175704B6D31477645524976596A6F4A4D7056654B4E55717858677572654B76392F5A374B7375335635547446676931564A58474E2F49524766724B774A6F57667572742B446F7577664F476B4937564F4254586359304B76334772762F5566394A4F534B5376384A596D7356674F386F776E377644486A52674F6B484555596663475653744B537A5633372B63476C67646D31414B6E2F424C7448476E5930376B7873504A3953586236766A782F4D61556D70454A65637649382B675669716E3446464B78483061465631525934416C30616F474B4D346F2B444446704E397251423266644A7244446655704657584A664E366D73714A644C55304A6F746F6B5955327949485758614D352B6B663068305551447768447331336E6D31666E747966662B4A4475707030386D71756E64627768726B486D454D6157526844414753537A545241504374466F57496742616538666779637A6A33746C31666E73466933614B4E75396F334A58636B4A4D677249797646535A564E2B327545743170373047414266517762777047527130616352664E5468454731716B48646651744F76513762596A47426F6B4F645A782B31726137716A4B7871694A4A574A736F7249766C567958565679554C396873526C6973304B366A6C46465237354E6534485255477078594750752B7342634930384D5936356E62343537614D4A4B5930596842476E646458434B4E4F6A62344C3034437744782F3747744B5075624D49537846464A7A656D4A6A556354524479674C446B4775472B716A7241705A752B73596C47387A5441683664553066666E4B3155346777495269736C70444D594157716C5453596B4771652B31796F4E315666486C78'
		||	'526E6E7A6B53556C5552586C2B305546752F6937390A78645033642F505364545A4A3554623562506438797264636D70646A6B6D6D70702B504F5468323070434F68534B666F6F77774E55673877686A53694D44596568767476745A654947414F5150436C456F3538314E5962443632397A646D464C6E6C69344A535263753343324B334E325448433874535470364B717858476C68614A486C3548674B3946526A314365566F7743674E794565524C31514D6F58366D6B6A3670715A497A686F5463374151306C736E5153536632446133466C783649724B6E61326E4932754C746C586C356C6546354D6D574A5175394D3273747A736B6D6E78594F506D7777434B625A35664438386B716E766D7837385367374A6B65737758554D5471582F4E307A4541597741564C595A386D494D4C564B70574952426876575069424B5038624E46516273467935504673596E4E7852734531516E4E5A364B7252556B3152772F392F6132677234777035382B59344D4359466D5931513441537345452F76517472346A364E637776784645656E56664B5655546553795174543173544B347542734A5357633747386B674F3165773756686D587946325477417A4B466A706D6979566D69373750714A2B594A48594377676F6F4658654B7A4B7531627075785268503048384E633244496E44454B5A5236392B7A434D757538393076574C5A546D4C436A6F5443575637564E63474972543743336F65612B3549324D506C727A417768544563526A4B42415247674977464D2F65374B516661384F736335436F7237572F534B6B7569363273334E37556B6C685865714175355644646D6B503865526B437630796841344F7738646B6973794D693136784B6E314C2B3267486C5655496A66646A4855595439427A4467774335574D56316C3643326B41424E717847484D637A7355595231693669557A613778533635627546696275626A6757553130527A577659576C4F6665616270505A48496D446368306E76524B4A4C786B677A434E50543552666F6C4E703147545238486F73577245665A704E486F67444E4E4C585A756B5A32397456547A692F66724746474870676471345137584C4D766E544D345465724A664D466B334B4556726D38626C7078643643553946537A52336D6351306C685263566A3556356844476C45594F776F626B6B6A696A43514161453052387149704642574C65304A6176454F3676614F355733654B3877635739445555785665557831593278315139366C633133305055315350537766504F426E68434552434E4E706443674B553075563857466F2B6D43586A7137336F35723365745642596533326D716F34486D39335131466133656273756E6C5A2F4F4244'
		||	'5172657365747573426A4D597346784172644931370A586A41786459307565346849623155624C596F53757A6553474A4B49774E685943434377525A324451686A6C36755933354452464C693354774F7143376B562F6F643576676434692F634A347663314647367271674443346E684E4256637577576B68624E636A31786349303441426F39354238633162742B6B626D746861474E6252783753704D3459357971797633566C58756133792B4E3647334C533674566E3861566C38377977684A30746B6E533279794B32337968553670356536355A6250667636427039512F6F77476663565251476970303544436C45594D7738426537526F547045557778434E4F5462706E2B2B6C466553473664667870766669702F61327044666C78562B626161786F53366C6F49726C3445774B564671596677417969474549534A6A456662673863755548587456536959566A4369664B52696E2B6E563654444B7A524C583742475862797250336977366D3835646B432F79792B57375A41716673657573636F58577530436C66344A6C64466C517543705070626D6E494F77615A513274346C497A536A78696D394D6442474B68585356714C366D59583849505465584D4F3844656E6972495371342F48317A556D386B2F6D583737555354505142516861776D65454961536E4347733565794D6F614C594B3368696875566F6A6C394B50617146736E4F705230335858484646466D72416F766D7A2F775961557A4C7135687755654F58784F6A734178523269624B33544946376A6C3177586C566377526E6B3469354358377167464448614D492B302F674952634A4E6E535949513772373866636B4E4133654E456C2F6D65566A537679616F4D7A71715A6E434E59664542314D35685875614469787456715963616F4643424E544734626F57302B394A654E344D5655553632534155577A3877536C5451676646436F564378587065756E4442754E4E757562705471387970507835666D4A4C5765444339496670515855697577435650344A7A4C6477546E4356794F3876324F3173374D4F4272614A623141534C74476A79414D5930434830686870516361326A42696D4E424A74324A63496F792B37317A466649714B484C3039636A6A3155366E7534646C713263486D61614763794C7A645A4A4E685777383834645249494779534973356A6F473966544E51364B4D446D3945553743492F61346530372F2B4C485838506F4A786A4A7147427A3271545376427A70792B486C3779704E53686647706463737A6172787A2B5535356451375A504C75385775656A41702F6371714430777043476337736C4768726A4B39564D4549627961646B67567651527870524746734A594D3059'
		||	'52686E2F41453055596A5A79593833426F65764C750A2F73766366666C752B594C414C4D4863745072596C4A723037594A4B54414454576B537669574B414B4E55414661356E454B616874357A6B64453166525259736A4C4F7839622F333843574B42324E435362664D68634479375666334D7176335A517554646C657633464D314C5A764842627A79617833796168304C654F34463151463535624F796A79312B31336D61507574504A484B466D416F4D2B64547775347838493541706A5269456F614F4859686F7750545167444963715145434C384233477037314C3270783678444F767A6975643535745776326B4862322B796F43532B726E4B50715070432B374D426F704A682B6F676F48746968582F6E54416D45774D6C30394A43676F334D4C43373979464F32774E4B725757755954574247393374765655576C6C4366745057585A557A3974643446776A6438336932522F684F785133652B64552B6D55562B786257725431314F5931346E31712F5279686C6755527036316636495A456F6A4132486F356148314D416F7645413478557A4E4D3168524147684247562B4F37316552325557316F546F336A2F6771484E4F47715866795537634B4337594C79784E716930757374672F514479796F4463445430755555315862556E4C31397050647A585774744F346648503471524B70355542597169476D58544336416E5056523473335A7A6273485A66746438686F5674686F31744F705530427A3747734164624C5079302F734F4873396A375A54586156565174774D714A696F7341674447554D6139484959456F6A426D486F4A2F4277684E475076634F4773552F6B554951682B6D6D376443384A4C6D787671566D61594E45655156797949437446564C4B744F766567714C6864313674697A4234744575436B746F782B3150765A4D3630626436326A30397A44655A55737768516161735067643346686C37536E57484434554F58476A4E713547554C506E41624F4561456A454A5A6236565259363174514F62576B647558393532574D415A4D596E695A6947434864304F666F527954494B493059684D4552676C6C43436C43426D614F456675776470674A3943675969364A4C393877355A615845545A332F6C2B4454687646333879495461417A756253754A71636E5A55355A7836634C4644334D6B69544B656736324A416D4A7A6F50337767337036626E5A7A6E7853646C494C70485353777A4F4353333231717A6A71666B3130576B6C67666B6E664449456C726B31396F563158454B4B6C304F46334D72477862666635346A31393569332F45457A38744B4463544452674A6D37466550544A6F7A59706A5350344B774836526831337A4E72504B4E504F'
		||	'7A737238736F6E3756683247646C51352F524F45790A74596437616859674B534B4D6E6C527279687041624E5333544D79727344776C6D37613164745A305874652F6B2F68544237683156757739577072572B76492F6930504E537156354A6635464C3356686650776B49694842776E4C4D756244736966785A6539496C39577175732B584C31337279315259317239356134464A376D7074644F79754D35564459484836763250316A6730586775536B4E75774E504B46472B525351505247414E47377A63782F2B6E3669454879595954455834745A4D6836796E514A526A4D796D674933582F4F744D795969777230762F696F5A732B31646B6D73736F714B6E3062414E4D4C2F76566D613355394A4374462F756D59694D64795076776F6176324F473968334548487A4A7170686566684B36636D5638334B4F6857625642544E75397A77764865775830653972494B35613453354A4D41514872466E346D53764A6376694D4638414B3569623478716976502F7962496B777271423257573574385035797177505634777450634370625A757735374A4B57483944616C6B6E4950554A65614D67483573644F7947537151306A496A6F306849542B664D69566A7539696D6755315466705A4E435966496A68725A3152776A3478434A62452F3930764A2F6A436E397777677A7476384874474361697932483756315766657A4F7279583072384953716654756C5273486A31544D79616E794F697A694842446137655737484779636337412B636B644A7974486D75736664413442446A345A38456B7646577632484C6E6C615A746E33457A784435386649354854526A476D6B656B44392B7354565177634B5A3665562B687874384D305863584C726259716150544B4C2F556F464B363839534F2B566E32566572412F2F434B2F4E49416C6B5543416B4D61726F4A39514C4D6857653162427079733879513538725258596A77746A356B436E435444502B69307A705A37336B543943774B316C6D3232396B466C7667595A663965786B4B66642F5A325644667369473932435774786A4C766A4550574B636464645535706A51743356323034554C6D33366D7A6A34342F3074536A517567704753307375582F6C6759546C312B6F794E6D46744B46455368563268497A3457376863667231366556424F62572B52317239737575633067744D303876637A6E4F5833722F7854454E75514E3436636C483569593341362F684D4949777248352B676B776C2F2B665974455951557469755958466D617232596977316B7A5035504D36566650644A6E3963557965326836396E66435547697658745032364E6D786374477974484B5844494639396B6D6E39424D7571534B2F644E47692F'
		||	'565562556F3545356C626C584C6C2F74317573706B0A73534F764B786E63786647446C68736D74373979424D474F443166754253587458717249715A68327543382F6A2B6D5A55652B3471634476503861382B7465396C526F3944664A2B5131724A654F507156443461576733393864456D45347949776E66677365686A4151456C4570554D55794B77424458776A324C7A4B6C6E30415961763146504377376D4332573366362B57434F574D4B386A374872786F6147386365504F516F2F64355336354C58344635366673353376747277374B34692F4E4B4675626569533870696E72365A7537636858395745337233536657396E6233323235705364657A397562736B6858376A77536E48764E4F4B2F593956423659577A326E367554476532384B7065536D6E6D4B72417A686D76767874434F6B4E4C326778387563754836624A72396B30327A2F4244413148474E68594F454D73746C696D7846377A727A436C66775268527153445758504B737645436C6B337A666B326D5A2F2F6444413279497573314F6E3350363038584769366C5A74637333566361734B2F4B6655386C4A34336E6E6965616D7375666D5645364D2F50342F494B4B794F5A7A6C5265766E2B306566422B62764F486879334E583731666B6C59647454772F4B71353566774A7466327269712B567253335A656C6E385258316553646C6936727769334346304E64714962356B54675568736F784257576C2B4B496A6363307733594A5A45566C6D382F777262457244546F455A596B58365172422F6B536E39494D4A4D32325A734D4E6F505A6E32325552656D56374A3576794B447543426A2B6238445A7459624E46494E7662394950334C6232647257574E57794B3756343775473657646C3166716B6C44686E6C6E4B4C3677487965333635737A2B5330755847374635323757587A755A74487272724E6E627554556E39743938326E426C59665A743138557675697337315865686D48543070387145596C636F3149706D4B565568756737364C36732F334D7634735458756D5835787A54387A3746704F634F59765743496673332B6F765376494D7A304D6D4E6545324C312B47744B2F47757857695872496E72446B345A61356D36546C723665702B4E7433376B726A374F456C7A66784C36376D6E566C554C4A705A63334C4A756461342B362B4F767570756B4A42574C576B62304E7A5630472F56764653534E696C39313978724C666D674A6231716F71534C73544352444C4E4533386943665559503746636D687853435642797A4B6A55797131756A686E394D79622B556B6466596736593872497068756635317076517A58704B7569544E794D4E396B5A4657675A6E612B4549682B55415739'
		||	'395450302B66702F4E384E2F6653446B4C584F58450A50733670743931734544394373446C4C57436B4A6E6630354947473343576B4459783968702F70795673393664497A622F733159616C614A36654636496D632B6348624549776F475A64596C5572327379426761452B7031557655326E3656706C656C36644D42376F787574546F466F313761386654626C37394F33364D45755559336F43637935716B684F627556796E71314F706C4D506B44667032774377612F373935396C536A2B424D4C42474A704F6F31444B3152713555536239734D48337352436154475A385259473769776B5838474A6B572B32396E614C436475557659786177476F516E303752484D38726F45316B69686539386A42724236645543535869785849575A2F6A2B42647A7A783477397A6E6F6530464B3155362B7649367651624D6C45446B437057472B526B63744545667234572B364F65396162324D41746D4F684142414E746977484B56516971466B4F46626B47314B795564582F4F6B5045516155615531725553356B464E504E545056524852514C554E4471786A6F7045542F314B56564D7949757A48576A57636F4454365743597A4B466E473247644F4D4E7668784A5A6757754476684E464D56726D554152585949515939394E647361763241556B4F2F624572626847767050396F4E68716159716770744E317945732B6965515441734538364231476F6C4378706D4F736B4343307978686271302B6B46594C345771523661414B55554A6E306D68554D6A6C637670774769576359746D30596D506950384B346E6D306D746F627357713136634C43666555774E307833594C525A626375616A76746A35705658384946503643595252676D48485745514151574845717078683479464F4762304135632F45466A4B737A4E38484D7739415532616555325673456E7763395864534A547767304561744561777A66467050743470324E4936524661314755334449736F62497845536C3145746C412F4137636D5758576765734147546F4C5679483872564D7036706847324246714B315339514256774E595132674137616A4367517A726652455349576F5930615869596C6849727556475A5944626C483257745669385753396D656B6B6B2F50397842717A4D51797352707055704433352F775431547851307A4A694443714349614E52544D304A416F534D434653794F6954426F614A74343765457A6173385444584B4F544979784B5357496D2F4C7662667A7741574F7A433057756237793079597A3077444B62626F71344852445449326E5368314D454A4D50685A65527359684567336E304543594B2B584149424247733950766C564979654D6168414968614C2F5166584A4A'
		||	'6149364F766E574B4A55532F4C686B38564D7671550A79314173532B787058502F504B5A4E75614D6B4D73322F6D56736D4A58454B37447832716B4F76704C415274554D715A547A2F3957763146365775456751336E30456A594B685A476443756E4E34465A4B646D6E52696B7A525146354B70796936675968696455464F30445A6B66717253507A724D42434155456E46764D6B63596D6C6F2B415634305369797575706B314F61444D5A465A5556475A642B363977566D4A716C6575485441466759455A624D6B56672F4176324B705571716147633946623971596B48416C62752F502B33656473564970416C6C554659384E595664416643594D4D666F415A756B61746976754A5A48426F64595042325241786B6E3775492F614B66347A31354E317263614F773963723531364B36316F3733524B38695638362F335261566C5A79517379736C743658354F6E32544D74534367696C395663492F795A534D43475052774572506E474F6270794F442F6472624E312F55387938657A6563663246753049796B506650786F41362F71374B33724C2F7037644143666C446F4C6F7A71516E6455466B7142543173482F456F3338786777786753306C666357635245566676646D6A49594F306933556B63744F7873582B66627A56706E62585A696F7358336A47394B74556137696F795237526461413577673054457A6D4473362F527163766967795079374258626A4E33333776326564614C684666782B4163784B6370626E5947534C69486855312B7762644B71546B2F52765A677A7674687A4E7244757774546B38744B5377516C42534A616970503372767A67766F4B7468636F4757746E75776E37587A5471703168507473666E546834583747415A6176373974484D6E3371736C68462F35594D4B3351654F2F395A30777876766776684C36546E38573638624132725345663549706652324830524F30585979547A6B67725737633678594F3777484A53674D556B5838764A506C5A6D337261576676625751642F38786437466157702B546A5847484D324555426E395A56414843456B6F6A653050716C79544B6C6732534742437869784D6333384A73783168796B4F6E6A415779416941465A78465A535A543035354E644B744B686F637767544576323754786E4D796B71774F4F676F2F5847573630394D6858795344576B6A2F34516E4859744F325A59654D4568646D6E3148547239414A3074616B6C65356D6E7A4D6376386E464D39485249454E5464594F5243774D2F57796F545439706A325654556348354A4E4876666B3544584E6D52453463352B6674746D6A694F49384A59376C4F396B486D6B31792B2B64766B3653487A43342B57475276446B4C4535686E'
		||	'6B727338572B4B644E3045324B556F43654A63546B0A547830357873562F2B352F2F7465554C3051696B6C70357666326C6B736D4F4B2F3263466D546D3632674C364B464E5A6B414E304F4132387377315348324C4C4D4A6870504752505A363746765644696C4959514254387763477A7639417A4A556365334732366C544E316D597A2F647732327876766372656372477277344A672F32584C463466506E726E4D6B7876713744426E2F446A7573554B42516F477741364547745148495336474A34455A4C4645717451716E57364F675568676D66366175356D4A686171644B69436731315663416B632F3267574945535A45704D35656A796B6C497477364659696B4F6F6A4C4A4568736B64335A45726365717A547274374F33416C657A41676F553832597764624759494C7569755871626F5A5445695A56522B32777A42574278576B5730585249316551666F6D6D6A2B704A5233616C7444685952317562686273347237743634366C43427745525859493153723157724553345275527152475936705170794B686A6668366252654B366B354E7833337762372B79525A6D53303930584158516A42787445367270375872614C73517131485A6F4F6F7A703138472B47336B63746261574335786456356C5A7A485431583732394F41566E747770667435547A435A5A54706F772B57527A433557576D6A715946376F6A6B7942696F6F584B4E66534F41535A674833732B514D4A42544343494449362B653643486C672F54326D6559432F634E644D7356716D4E4639577658374A6B334A33484E7174534C6C3971672B52504E62524F2B443747315773683158584B38754C6D336E78614D3646464C5853566432364E724C706A567174426C694D35366F456D46756C2B70775A53464271594459725A7231426F3975734D414A6F31576F614376574A50324437356E6642636C41384C557A42755246584C3656432F30556965344D6A566B6F375874496E76374D42644F56494233557447524F352F65306A5968464F746F4832782F7078485733646F61666143796F70466D5952704447664E794F45304A4652506C734B66364D5453497071652F586171414D564232396E786B2B70343569327359706D39396F78634469784B6C746F2F424A63336233594D7368734B6C4D675747463776663039637256314A51676855614773556152354E4D51523850374A644956587136427148533954435035364F6271534C5954377767384A4A712B365571725149617059436A455167516C72424E594456356F372F33646C65586C64646248794E454134733151434531582B684439477666414D55785A4B5A366F314E744459614856456B717179394E4E4A766D3652316C6272484142'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'4745514756564C474953707161674D466B4F6D52440A6B36724C437A57576C6E733272522F5030315A6265756E6E73743753633948664C324435306E6D302F7353453635644F47795A454342637453776736695343645451545941437845444844744A704C6E337A46426879646A4877416B4D444D69576443367559723966545241424569636B706B534759686961567049352F6D2B4F384D73417678744A6937704843526A7045595141513965745567307230462B6E73684D42516C653774682B666F48385930304536527975694C342B5679576A496438625162365855534D5476706735346B4D75556E527547555074737773465369675138653743657A3532775A4D7962516C62742B2F4954516C42304E6C383733305A3876594A69494D51476870614B66574C73716B32487970564F71565A3164505251694D494639744D647774727554644836694C786C48496D56444A61537275356675554A6E6F5A5A382B366A7261366130563942747A416633564E633443706D7865374C7835302F5071565264626A6C524B467A4C707863794D6A2B37544955552B646967474A505170615769544D6755557457476F5236337459355A3531505175455453674939313945745A6F76667567367570545942396D71716550374E6C356576783371774E3955787A7346312B2B2F7041426E30366D31774662794E636E49523239704B4F547A6A634E5378684D7579434D57455A71654C63734C426536754561616D532F2B776F62523937374B4D5836684F45676C6C5A48676F505732316E4E6458565A506E44413759754F5278772B31417A30456E67745A32456749314E5846664D38424A544441597564595544733634743362666F6F774C586E6653582B4D2F71476E72342B5A7869507751384D3775395741494667687038714256336E78756833703362305559583339686E46597837396A59375630317651392F2F3166766F6C4A78774376507559433969777973737058715A455648617670472B675653785251506931576935366C4F474578304E6C4233384D674871547649305675686171504D574266326A4371434455317863687A63482B316E56336F39476B4A584C634E51564E693774785459436F4C4A574A795378764D4D45594E74564C6F5350704646734D433073663237714A6A2F4E6959677A4E43776E79396C767435723567537547626C736F535537546C50486E66417467304D615076374E545358686D526E6C5565453777377958785067753272616C4C44774454733368696465766E49546C676C574865583339354B32783332376475543765693963757A70683775774E69786475507052522F756D6A75672F4B68366930565853626C5630527379313135707731'
		||	'6763484C7650336D4C31793065584E6B38753137620A624234476A3336465961396E316D74786A48744A7A44457271712B47683139644D614D6D4944674A644E6D4C556E5A6E516E415A57666573706F6334575333796435753062566262583153754646714D4E35385641716262346476506A6831527669306157454C466B5448524F34724B524A32647970595353517963727A6F75726E355567356E7134334E476F6F774A7030716C726B6E772F512B2F537338316D42744E5733613145674F5A396D3865556E33377973686C563544464641765167755A596445485941526A467458646F57757176355736703254466B7267677636587A353459745772427031727A49784A3348424932334942745972434B3337723559737A352B3762716B304E444931363831384F3546685531426751756E68537A43704C6168366371794658464C6C2B3561756E5448335964764D5049614735393950336175673230346C37506C35496D33485A3949536C4C6A374A6B37334431445A38786575545832344E6B7A6435554B426D6F7752314936357447636A6E5A747772623847564D6A672F306941727A445A6F5A45706166795037356A7675414A46534D5168307452736D753247424F5544416A54362B583033577451696F594565496662325379664D3276507439394E4C796D2F6F574A304D796A56446654525142356C64585851594B7466724A456F3146435058434F54612B687249614A6A742F2F6C7235594F4474504E7A554B734C65634742323532734A762F6C7A397A6257316D3274764E71716934414A6969613639636662467956647A33333373344F383337372F397964756575346A67742F702F2F74762B662F3250656650494B4177414B364954345938354F4338614F38585A796E47396E4F327663574A397859373174724B66372B3639382F6C776846704F65486A4934534F624F6A66543058506A394248634C4B31386E7A69787A53373976766E483638313873537371454B4565755A4B496643692F615947704459472F3653507932596E696F4D642F4D737A4262374F673065354B353239674A64677357786B5A7571764A7833326C7275634746732B72756777396942625570742B362F5752652B7A395A7037702F2F356D6C6D4F524F424336516139343262473266577A7553636D39646659566A432B2B526B587A5933572B33757474504A63624D42596451613064567A62466B4444336537596B5769672F30635638375369524F442B594B374D42356F43456F774447436168524A4570537349576C4A65664D724F637470662F38665A3750734169346D4239745A544A6E377650583753314D6D57737A3139566B64457076644C36592F7157752B306F7946576C744E'
		||	'38764E594B36683676584C375830697A59325747470A6C5958336D376553777A6C565A68622B5A6D597A7834385046496775796C576B71656D6C726456716A6B4F554779646D37656F63483638746B3865764776504E66444F7A454266753748486A504831396C325A6B5671447234584D7866744278786355745670597A767674376B49504E61682F3357476537634D7934783330376D2B7534737162384B6B535644444B332B576B7A304751774A5150435647724D6A4F68646974665074527A624E61374F6B6659323678306356392B2B54773079307938304B3532424D7763797449724F6E77796E426D575930704F64657A4C4D4C62783237536F57435A2B63502F75703961596B502F633841673675797A4972697A6D422F754776582B6C37756B6C457841454F5A793758645248536A2B52667242633872616D36763374585A585230327155726A31527730784B536E33635338612B444861355A32647A347176576D2B506C546B7078554E6E48384641444F305345554A68314466393763725336634252626D553378386C783949712B5456336D7073656E446B79496D4E456273616D362F5356367A535745334E33495A6A476B7A4E43446E56394D6A61596A454D6C61647259756963744B7873305933575630576C416A75487166593261774F38393341637469445376335837492B4431386F316B62646A752F2F745874322F47426B5A47463136395076442B4C536B76766246322B53374D72783174703652737A305077415039536B486654776E77393133576E74645747457732336878434730514C64304E73443050374C6C3749412F7A556537737674624F6334632B592F6569784765455458654F6D716B466F69566C492F726C455A6672494C6C564F456E664833584C6C706666724630322B66505A53335875756F4C4956424F6D68757464444261616D4E666569744F33327741713965363532634676683668356C4E6E4C3077644A6556785678587034577A5A30524D4456344F763579545732746C506333584A384C52636647707333656C43694C6774396C61725A3053734D66564B63725A6363335534486752762F666361666D6851343365507376514E526A32332F7A6437666274446D414C58465A323775392F63334F7758654C6E46624E2F312F6D585438694456704955327A5278374249767438302B6269766148765A5356383430575337486B4B614141526D394A48796E5769456C54665674484A73775834385579386C724669302B694D4542684133492B76706C694E325547526B5A3631644862593361763366333063536B725056683239614652543573657A346F6F354F73783230664655706D755678466E545347726C4A4F796B7175513177667A33'
		||	'41627977566E54332B51797768474D4962616A4F6D0A5255567679344F396B456E6F6C636B47723044564331492B663550362B472F3730333735754C75764F6E2B6E57716B68504A2F3257304F75585A4E614D4F454232777664544432553074583867336C36727067527664484B63743364664A6653495753314D416F727137715A4B675569494552464430446638776967414C2B6A4948684B325A712B503532627A6961756D42523234665573503534677A4147436438444A4D477464354B39633532736C683761584C37334671332F3471432B765A7A69374C56362F50665052455438655643733643434B72764F466A506745575A45726A717A71314F494F7A34735874416D4C5054646E4D7A654D6C62314E346245495939426D46616375644F4E77797A742B656141502F31496450436E72305952476444546C7A494D4B536C55322F366C6C695655694C52494B68392F306254396C416D517A79674A6E514C4154546B386855787068512B766C764754357957737175716F7876594A567A75796D6C54596C3263566A76614C562B38594D2B3153353234474833525030414F48654B50485276673478586C594C2F3038745558714B435739326A794244724D3443576E4245645656643462374B4E574530322B666663544F6D7471594D4C3473644F325268394264652F6645542F663163364F532B79736C346A7150736F517A4F464B47656C754A7876586C57433454687754754430755877754551653049586447416F5563696A416A726F612F7931684A6578563148797A434D593066627A544E6D7076514D55752B4353515973433641355A38366373643959326C6F4777414B37634F59374F49524D6D737939632B2B56556B326E496568553950454167793277474F5670534E735465584251754C7672576D754C6859657A54694636382F5A6134656537436C34766447374372527544674473752F7643654967776C664F715348432B704E3538383364647253364266444C717A7335334775646A425A547553713861506D2B4C4F5862466D395436594D6341554469736F634C326A3433796F474D424354364E534641576F73613872524C664A3548544A6A6B34584564712F484C5132432F4C3243494F35327244324F4249526C44782F3878346751396738503353336F323045484166585A65504669783952794C53517258594F53323374463658733571475A594851444A4F6E72494E4F4331766C374C35727776647678777050773273654F7470704E58755843536351452F45546A545652735142694B68684377536C7079393036667664316342415959473743372F54422B684C5233397A4D7249427135616B4169373459626832646E513176594E755369502F5A4531'
		||	'417545595737454E46436C4A6835656B65346534660A614F533161764F3469356330634873626466794846634159544E43456C342B6F52652F2F4739426956673342374F626877375A7071666437793135624B7A3539734136377136522F6132717A694F346643506139667451307568696E354168305A45424E4E625A39744E55774D546E6578586F422B462F45645746725063584663472B6B57396630302F4B4942704C2F414533706E4D74376464364F2B397A736474476630534158796C6D474A4C4475504D6B4246682F51703067355A634F6439706237347579486366624E697332536C744C776467773554364153424D725A486B354F5174585243786364332B30446B7037747877473574514F2F765A4C312F4C4D596D6A307A596C6566746565377A342F4D35645A54466263356374543534627573557659484641304D72673443316A78307A4E796A6F4231565255587261326E574A754565544B58516A446E704A536365316146316F6F6C744A434A4572397071686B52414D422F6C487562687375586577396E48326D71757175554E68575848773149754B517065574D6B476B525874374C75337449512B4E39473974703967367A5054785757466E4E54553675504865756E64376A416879684D68336948687066363351614A6377703353504E395664646E576242527A73344C447151326F54414348324D6F613668303143795930663174332B62352B2B39336335367A655048326E667669495064536A2F2F474375622B5A756938736F72373553577431615533547A5638764A6F626C4E493045702F6E336E4F546B46525732675048536D344E473763664666586541754C5A542B424D506A4861564F6A7A535A5044517861413454425A43477956394F6257506776365A65336F34396B6D6C356D6A4E41375752683154352F4B4C6C39366E35766273475A4E79727231322B654652732B5A7433334737423032646F746475437658683663444D6139664532666E785736757139446647384D4F6F314C3252386951415372495447394769317964596842376E54727A4248717571626C746262584132797469307153515066734C30586A55682F457A494B65546D2B536B2B6B6E6A317348432B667647506E744B4468775157566A4D744C656650326432596B5A365330583576534D465638724C573675716232794E50657A75446F537438655975662F4B674478436949396D4544416A54366E717053344748656B74737A5659452B653177643432436D2B2F736F31345356615039672B4C6537713442326945716B70393979385A796E62646E46434C6935755A6E5372684643596C4C7948483357505464474D2B7834377A4E7A494D3976526346546C6B6173535846'
		||	'307362583358326C6C655738343863766F526B49470A7975717A6B6473336A6475764D6634436637655069757833624F33724A635A5143682B79596F49423865352F6E3662376532572F503176666E2F39712F65454356502B312F2B794844664F4831666132733338667277333474623348375639413653792B734C556B4132416E62583176416E6A70336D34727A312B374F717A70796F6C2B353435426D46416C75467445547253306E6A44336A6F416B774F7532794965377735514F4B68513945672F7958523030585837396A49336C3068763933676E2B2F4237643555416D615039476976723559484257797A745A694F2B2F6E3569454F59756D4A644D474F7475612B553761627A5435456C4F613964736F37466A2F6C6B4C7938576558676C323971752F514A694A6C34535644516F4D63334E643775653746676A6A3156326967355036614E712F3842574479673573653854744B6A323972346D73434C63584C6F7A464C4F6562627A6A4F7A6A4E38664F65464C746779662B454F727364364F3466464473364C4E6B646C49773737384A465957314D7A59322B3759474E34426730356C465141694D41673749536456526A584B63484F657350704D382B675A3135744B777845594F416D613576703564574E6B4F46546C7759537948514432452B4D357A7461782F6C35376E433057332F76726A59694967646A6673614D4B4265587859364F4338654D38662F6D5777387A3838432F6657502F33332B6159474870506534375436744A5532356365613154302B484E4E70796C49595270427A435345524C4243432B657438664B596C6C51514B796C39627A636F384C4F4156685A744A35784F596A654E4554615334714F744A6C4E437650796A496632723932677763534F5057562F482B506D774A6B334F7A516D762F425532777346374C34596B2B314248646437466D5939446B354C736E4B614F6E7670784565694A4F3837744357565A32664E692B5A364C4F567746343264344F767573364369396778475545444949692F6656575957632B61474A68394D62306F2F314A5354667770354B327175377A74595656642F4B362B773455426D2B6363752B746744426B4366684143377131656C575671456D70764E486A636D4B4754717873724B382F317738585231454153354458485968645033724D79392F50775866764F6438384730576F78614A444F72396C4B5A57686362572B526B482B48684767764E74725A4B336D4B3832537A68754B79316331777766306E6977597A3677754D584D7A4F4547526D3168666D6949336D386772794B6E4A7953657545464950565930546B726D34584F6E4D336D466F736F77686A3777656757554446452B74674E323542'
		||	'716254585468624E6F307553676A4D77365A4F7A750A317943516C536752696B44566D4A5544573953417766634A3679392F2F3732627464553066372F5675336366787A51634D7A7459506E4459706C77766E77336A4A775776326241502F683049773168313479364646393459667041697A50415548793371554D5A4A652B73494E366674396A5A685A38342B42384A71363237623273377A3956332F662F36766257624F5561614C57565649326E753634754A727833363778744D6A6B637664387543526675506D7777374F6F5536753835323543394452655564623968346F503178516C312F45793867744C4379757A5473737A456A6C446244507564486842454A686C4978655571326C36384E306E44554B48343064472B54687363624662656D73655A746676714D336B53676A5A7577682F63786E50664D5050787A374C574B4F6146766231572F656B56666F43596335316E617A7A43796E48792B3949705952784A35794E59454A665036323379647773625072346B6C6D4D394D796851724545497866774C61376E334A5A35545763646664617A6E4762372B6F355236456A38636E5A4B4D66534F6E524B534178694B666F51424D4D664F7569505933734879614363664F71684A514265734B72596763564355467853334C7079785145507439586D5A6C4F387642624157444B444168716D344B49504F2B6A4A335673766E5232432F514D57323971485A4239755241666A334B652B646D62356E7178626D7A586D377776674A523373316C792F30536D544937695A372B752F30637032626B48526556594D7A4B4D70574F4657366677424151635A68475858455A526D5A6A4850325358437A6E346C6A66514E4350746974514975373869524A6D656E55452F335657357579337A39566A6566654953385543394B6C69713033663169705A5A5A56474575646E61654E58564B47467A717371584A314F2B6A6472683135754B5A63784E68774B436F754B536A4567563530695A3363312F4349477A32786F3270794974516D3045596B454F794D6B3836324778796330343051566772454F627648325A6C505858332F69773036474F48717174504C644F4A73623938785346482B36335756757539764C66417432526B69535A6242746B377A3534314C2F4A544E2B324666676C426A413739673948526745334842346F51674968356279686A69686761517069653376504346754D4D6B657A36734E304962757964356E3037316E767838753033726E644170345A6E67465855686C5755767672756D36577572704663742F44724E77647674505942342F3542595A5932633836652F775259514247305033536B757536614132654F752B6461324B5330544246534B45'
		||	'7245444436774133786F5358334438322F484248340A337A6F2F6A7472424F644F50717A66597834344B6E684D54434A50447148734D4230614B5964584D3275786946497A746A497A39304D5545796868377A664D6652493567507A6E4C6A4C6E5A7A6E333238524141567137557135706B6E4462734538505A6C7A384C516A6259324D3579634671315A6E5958774253564C71496B6D56322B3878477A4C336D707A6F47384B78326E746A56736659555857727439755A6856736254646E2F6362734B3966364B654B5A32517856426649775531636F44536735644B6A5A7A4877687879574B656B6C3274594A4F3249657675434C7943773837384C652F65453662466F505A6E356658757462576669537959536A4C454B6E743253444D556E44774A6C65586C58443943516D6C3149387938784A302B6556723362594F537A6D754B367A7435735847483048585058326D676775442F7A5859734D38496F7A392F7774516232484A7A6A7350383573793570777A43594D506D7537757438665A6548626F772F506D72667052506D5243786E4C6835724A38374E2B333738584F6D7A397747685A2B3538487943755866416C4E5857396A4F504656396F3779536F6B6661466E67786755676E59514C5651434B4D4E4A58306446734A4C34497953415748737A51724466556B3965664736623847694C656A76674F41494F50755A302B4B54346973623635362B666B7065504649387543574C434374783455545A4F36795A5A44626E2B7133654234396C6A707A35474538326467733352786265754B6C4352492F4F754E6B71445A6B5250585A386B4964584750685139716E7550704A327143366E6F4F486172552B776333426B7A3136514251763375584C584933726C65717938665738412B6C30666C6A4E70386E777A382F6B68302B4F7161683439655570362B6A484579634D6E386774583375376156394C5253376F48794B37396866584E4E3974655370342F31333338514634384A357333356273344C2B4F364973796139656A4A653668596F314D79713879476C314A4C422F5235325477454B38364F36376963714D496A7439732F555232392B79674E6E52387A65634C79715145484F5135624F4D367232525858573365664F6E476E327A724D633346626D3753393975456A61726F472B306C504F2B6E3853484B79716D70355A34453539453165336A6E45444336754D5A4D6E4C7A306875673931447948733831306A436A5164656678494768537763647A5945432F506A546257697833736C386475505A3654632B724368512B3357727562547A7735637654553573335A416E37623871555A5A704D57656E74474C6C7134372F35394A577142786D424677694E7948'
		||	'546D7241344F6A45636B7357376B586D766E3069580A433579356B344C48526A654E6F77684D477A32396D73636E574B777662556D55646F627733766C6F33315167776B4A38666C333431783378695239766F567664483036456E50397052635948664378446D3244764F506C3130456A4F413059684D50415753547A4B65454C74782B394E6956313239702F364C655A3638304478344F374E6C562B4F54684A327135554356467156496D37324F515A6252684F41655A6D4B69462F7061426B4C4D584869446F6D57772B4731706A566D39582B584933753967742B665A50626B452B47797A4D46675945786473344C454C382B2B5346716C39474971494F63647958326A73746E32532B594F62735052476279326650545A30776157485131506A467939496E6D79393263517337645068636E3568773342645A32633930395677614F48577A6C322B45746431797634433463654E442F2F723361556B706451504D4B2B3162372B6F4367684B634F427473485662614F36313263463478622B474F47584F327A567555364F693634502F2F4C2B755738383937784D544E5A34475A5459435A566543534A5473395064614654493178636C7279702F3978745443666B704E4C59797A716D2B442B364A4D7A7A466F4E6D71636C7A352B4951344C6A6253306972435A46596C6748426359454271317A644A6F3959554C497570586C626B347043466C73724F6666666668616F704A4246586C4631523765613734624F2F76506635354B6F33362F6D506C7A6434544F334F626A7674544B7A486675374130766E6B725239346379543575624C2F667953724730584831433948414959562F632B555A6E662F776B687A48742F4553574C6A6C6762626E4D6E62764A775861647463564B6A744D47462B6431746A614C7A4D336D6769654F6E79766B7636736F665148513231717464584F4E38505149583735387A3870564B64372B71344B43597A6D753466594F4B327A746C367A626B49554F652F2B4F5746754675726D736F584E4A4E7449337847455559656E70504275727053354F6D3742744F583066434B757562725779574F7A6C4875336E73335839756B4D4F396B7339584F4F432F58664F6D4C364E34374941375230334B53672B355769666A41344F364F3770472F48635264484F626B76476A4A383666744938463236457233397379497A7451564F33325473752F7674664843764C6D726F37366231497559497562476C30474E575550694D4D30786832743238415532574B5135694E4F3366375952586D7A4578326331706A4E6937456737504978583647785352664349484179393137796172317956647676575A686E724B37794D4E37685931394B454B6F502F335A'
		||	'783956746263704F337476335A5062635243664F4D0A6B7A45496D4E795946714470713332446C686959527334646F4B336C6533737965617A484A325872567964566C4A3243784D72474444594F656F54705352363637483569354A64334A5A507470674747346E724A356A35756E6E5058784F323439376A4C766A4B5A61753357646A35634C6A5478302F30346A694854707A676232633350534A696632356548586F58576D6257394E455557484161444E45766571445859516D36534E6A616F7A3575385250477A4A2F772F5651626D7842663338553362335139766B2F472F4732757239635763375067363766754B62546F486E686763766E4B7536546B796F434143487637686561547031744F446E47306D65356B4E335875724855786B587667493142585473374A3738644E646556756E44422B686B6B6378694B4D665871485070734133644B56517668394A616B58744957747A2F4A30582B746B76387A5262756E4538644D6D54777878635634435A7A64353476537A707A39696474386B65757642335144634F4471452F755576546936754D3559736933337851702B57325768684D64334D664D714B6C5474362B38697A703070506A325549442B7A745A6D304B3334666D44396B77576D6C6165716D4E3953775870355532566E4E615474324773363675766D706C4D636657616A46412B6679705075314134395341376559546C6E772F646F714E37517862752B6D7047525850333067514673506277594A6742334F51374C796D4B644D69485A7957637433587763694E2F583661453263356C377430787252567A352B32302F72514F676E39506A6F7A71696B5A4933306A555776475345595A326C556F53486558737533786834766E627A654B7A74594C543472715779356375505877346176655867586A6552686D4A7554763376566375584A667744397A376D7A7270335970326F6E73487A344D334C3739374E6D7A397034652B6B4365574B782B2F667254745774336D3573764E44536376337A35336F766E6E66513543385A426736463931497364624C753635506675765478373975624A6B35644F6E627279384F474C642B2B36364B4D6A544C32592F72312B382F48757663636E5431356F61626C3438654C4E7472593367344D41504A574A2B5355467977414A4744734D3454513658457A61486E65664F33767678496E4C3136382F364F7763524A6D4932642B396C54782B39504846692F622B41634D5461665435416D5979306445687658506E2B636D5456356F614C6C7738662B7665335461356A4335706F6B42304A38342B652F6F4A655A2B3274534E57687A59776F614A664766384D63667172556C59324B6A2F54514559682B6B7358373757'
		||	'6376465A586536716D70726D7838554A72363950320A646A463969674552486B722B4A4C74782F596C49644B366C35664B72562B314D7964434D394D6D5474302B6676752F714573746B7576352B786365502F51386576487A2B2F4833487033365A6C48335341615342736A35396B727834336E767A2B7174584C2F7348426D6845696D4A782B4F615639466C62723152436E314A2B39554A36702F566A7665444B36564F336272652B524E56677941593570564971625638766265796231344E76586B6B7558586A5355482F397A4B6C373538382B374F316837696E714D646E43574B4A786D494C65556A5655623051596A6E2B4B6F536C6B6B307270513844596C30716C7A4D38414B5545456945774647534C3631425255626B4C736A4E32556B45492F4C697158593475696A4E6D786732356739316E434958734E396C55713570366443614569464149524E426F56382F4F764C38542B6366354D6447493931425951396C6D70444D6466455751776E6F55656A504A416370786969364C767657615951646A6E65706B352F4265483043647A463438656F43306F475956676E796E794330496954673070696B3552305230796D6352594A6F7143426B7972594871473651746D55426E36585564755848754137554366367533724C6A61467A51524270474C366941334C536A6C7A30366C582B655A564A35765330543749376E7A364F494274623763634532554D70302F7450657849362B37434A4967532F564147517A2B444D44545A714B4D76395755674E4A6932594168505541473741344B755A54495A564D6271693155514F6B2B685548774E4F4A5344524B4E6D63526E4B4E42352B54546A315A53477356415A47595A423861435439414273465A676D696D74622B4E5545655578516136657547734152647365706932566A7673454E6341775177734268654E56495976654C73352B4848456E50787A374E4A3755516D70597452534F37706B75314D4F586A32394C5832442F3347613438647259794C33556E766567794A3174656A594B463239664C64785067395259565648393731737166714261656949354F714B3058595A395A684D4933496934726374694E6C4478416D486D5165545453686E3047597154716743347753647143775267557442364842544A737073556F78315473754D50594E4C734D2B694F314F6E474B484C464C59512F5979493948536D5551326F78472B4F45514A6243467343764445446C2B327A37426C5A663578706F54736B4A5A2B526D616F5A4F4E34414B4671566C52574270614D56654D5538724B4A754D41304861555A65396649624C334751315A55597A717242785434645930676E4158456D57494E365568414D34316C6F6B'
		||	'36322B5378656F513077396F664B68346A556741460A44734635683636506676656B32505033416D4B5644475566577234316B495955634A6E314F43764A4B38334B4B5759764644746A644F3950506E626B4F77385A6541437559646167414E69776850706B614D455A41735A6835544A53686E3048596A3358564D425559565777342F704A2B4C4A32577A696A55634D7751697671783630466661352B74326C5132734C486E666F78527279482F6C3454535744496366306D6F694B6C724F45477172394A704C52426A474C4F4A4C4C7A4162417244426B4C56503169464B54464B2B4D7A476F7342447058334274446C6F454D4F644851506E7A6C34396B4A71462F6534754D6561625A6157382F4C7A6A7356753376337A78415A4D5075597A4F7547487A78494E304C707153764B2B38724C62313173502B507270636976532B58746D4B35657352672B4A776345434A79365A4F6D62316C3839626272666552677643757533766F777A774D2F517A43594C465938384161426A42326D4E46446956574861613862775946306A44796A51385157784F494A684C50495973794648574D366D344C7879684B79734A65783137426E6634674D416B4E43434D794B7A63687053422F47724C5577566F63644647364548656F796E6D4A706D4441736D65352F5259614B3249344873396F626C6D6879475356554F6F79677732456159496E4E7858614861546C494D54304534784370485A2B595A374C3135503237446B4171646D736934485872357232757A73475535443246523875774651704F744431352B6554784B355853674569674B6D7A445A6942796F462F572F7248332B72586253447833396A494165756230786162474D3132642F6264624835575656694D64633473547A61647078692F7048343330545A6C744B567075314C7568444361674D657A395934544773305778586336713867654A397343516F746C63324C49704441305838756659514B69553662445068444A7038346147445876496E7670704D6D59456D646246394447466C784668587A5055794F5436556671797354696B53474A4C5A73633857376A52496E785A4634536A334E637275586633555855565879485876486E3938644C46613444556C637630683363442F644C6E7A393438652F727179654D584F4B51764247577938476F4539634A6D4150546A6836377231317131477469387167766E722B4C553354755033722F37394F3774703063506E2F5A30447A78352F507855797A6D61392F505835696A39517769447547795454424B48457936436D724144525A6A71432B6E73684D745552396A42495A76497068674A4B55436261516E59415137594B30304C2B5A4B6F564B595359682B4B4E'
		||	'68352B78634D4A78614969553576424A72493752730A4A5A4E6D5A69355747765A303939535A2F72596E4841736D6B36792B785A517961476A4D6F786C6D777142744B5A56783478433868444A5877464B554D36457245315A4D6547595467792B7236436F554F575659672F6F547A3935314D5373594C656A394D546F2F316A4C77437A6E33476C4E346755394234716D44367877384355586B433170474E2B696B7A706E37466844502F65614A68345038752F4E513272376D66356C394B7737442F4E767A3078794450776C7A534B734E2B49686C5833732F784C61566A326E2B58666D4559523968582F316A537375702F6C5830724473762B447A4762383162634D6A534C73532F3674615668315038752F6C495A6C2F2F637951364D492B354A2F6178705733632F794C36566832582B574D512F3437526A6C2F7A7A43526D6D5566684D615264676F2F5A5A4579503844566E596A4D39786A50753041414141415355564F524B35435949493D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A20203C2F456D626564646564496D616765733E0D0A20203C5061676557696474683E32312E3539636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D224C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434C49454E5445223E0D0A202020202020202020203C446174614669656C643E434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224944454E54494649434143494F4E223E0D0A202020202020202020203C446174614669656C643E4944454E54494649434143494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2250524F594543544F223E0D0A202020202020202020203C446174614669656C643E50524F594543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A202020'
		||	'20202020203C4669656C64204E616D653D22434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244495250524F594543544F223E0D0A202020202020202020203C446174614669656C643E44495250524F594543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22534F4C494349545544223E0D0A202020202020202020203C446174614669656C643E534F4C4943495455443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F4355504F4E223E0D0A202020202020202020203C446174614669656C643E5449504F4355504F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224355504F4E223E0D0A202020202020202020203C446174614669656C643E4355504F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F52223E0D0A202020202020202020203C446174614669656C643E56414C4F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C49444F4841535441223E0D0A202020202020202020203C446174614669656C643E56414C49444F48415354413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E61'
		||	'6D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F5F534F4C223E0D0A202020202020202020203C446174614669656C643E5449504F5F534F4C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4449474F4445424152524153223E0D0A202020202020202020203C446174614669656C643E434F4449474F44454241525241533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4652414E4A414445504F5349544F3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4C44435F424C4F5155454445504F5349544F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2245585452415F424152434F44455F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4445223E0D0A202020202020202020203C446174614669656C643E434F44453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22494D414745223E0D0A202020202020202020203C446174614669656C643E494D4147453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C'
		||	'2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4652414E4A414445504F5349544F3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E45585452415F424152434F44455F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F6465202F3E0D0A20203C57696474683E32302E35636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E31636D3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C5461626C65204E616D653D227461626C6532223E0D0A20202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E4C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F3C2F446174615365744E616D653E0D0A20202020202020203C546F703E382E3735636D3C2F546F703E0D0A20202020202020203C57696474683E31392E3231303633636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C496D616765204E616D653D22696D61676534223E0D0A'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'202020202020202020202020202020202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A202020202020202020202020202020202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A202020202020202020202020202020202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A202020202020202020202020202020202020202020203C5374796C65202F3E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E6C6F676F5F67646F5F736C6F67616E5F616C74613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F496D6167653E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E393C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C52696768743E57686974653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020'
		||	'202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F5F534F4C2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E312E3331373433636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F70'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F7274'
		||	'4974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F5465787441'
		||	'6C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020'
		||	'202020202020202020202020203C5A496E6465783E36323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783130223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A20202020202020202020'
		||	'2020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D'
		||	'0A202020202020202020202020202020202020202020203C5A496E6465783E35393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783331223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783338223E0D0A'
		||	'202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3231393537636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783339223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464'
		||	'696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E47617365732064656C2043617269626520532E412E20452E532E502E3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E343C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783430223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A65'
		||	'3E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C546578744465636F726174696F6E3E4F7665726C696E653C2F546578744465636F726174696F6E3E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5349205041474120434F4E20434845515545204553435249424120414C2052455350414C444F2044454C204D49534D4F205355204E4F4D4252452C20434F4449474F204445205245464552454E43494120592054454C45464F4E4F20444520434F4E544143544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783431223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C446566'
		||	'61756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783438223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020'
		||	'203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E204368657175653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783439223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020'
		||	'20202020202020202020202020202020202020203C5A496E6465783E35323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43C3B36469676F2042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783530223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F6D6272652042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020'
		||	'2020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783531223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F723C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3930313533636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020'
		||	'203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783534223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3839302E3130312E3639312D323C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783535223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436C69656E74653A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783536223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A20202020202020202020202020'
		||	'20202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434C49454E54452E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783537223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020'
		||	'20202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4964656E7469666963616369C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783538223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020'
		||	'20202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214944454E54494649434143494F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783539223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F'
		||	'74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783630223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A2020202020202020202020'
		||	'2020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783730223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C'
		||	'2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783733223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020'
		||	'202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783734223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20'
		||	'202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538303838636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783735223E0D'
		||	'0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43617272657261203534204E6F2E2035392D3134343C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783739223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F46'
		||	'6F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F6E747261746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783830223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E'
		||	'0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783934223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020202020'
		||	'20202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E466F726D2E2056656E74613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783737223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E367074'
		||	'3C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732150524F594543544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783831223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020'
		||	'3C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783838223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020'
		||	'2020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783839223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F7264'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'65725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783930223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020'
		||	'202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783938223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657243'
		||	'6F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783939223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374'
		||	'796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5042583A2033333036303030204641583A20333434313334383C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313030223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E675269676874'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4469722E20436C69656E74653A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313031223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020'
		||	'203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732144495250524F594543544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313032223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020'
		||	'2020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E20536F6C6963697475643A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313033223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E'
		||	'3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321534F4C4943495455442E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313034223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270'
		||	'743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313035223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020'
		||	'202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313036223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A20'
		||	'20202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313037223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020'
		||	'20203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313038223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020'
		||	'2020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313039223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F5061'
		||	'6464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4CC3AD6E65612047726174756974613A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313130223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E6742'
		||	'6F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5469706F20646520437570C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313131223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020'
		||	'20202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F4355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313132223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E3136'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'3C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E205265662E205061676F3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313133223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74'
		||	'746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313134223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A202020202020202020'
		||	'20202020202020202020203C54657874626F78204E616D653D2274657874626F78313135223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313136223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A2020202020'
		||	'20202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313137223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20436865717565733A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020'
		||	'2020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313138223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313139'
		||	'223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E30313830303020393135203333343C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313230223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453'
		||	'697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F7220612070616761723A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313231223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C'
		||	'743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F726D61743E3D466F726D61744E756D626572284669656C64732156414C4F522E56616C7565293C2F466F726D61743E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C4F522E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313232223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A65'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C69646F2068617374613A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313233223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A'
		||	'2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C49444F48415354412E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313234223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F'
		||	'5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313235223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313236223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020'
		||	'2020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313237223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C'
		||	'2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20456665637469766F3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313238223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020'
		||	'20202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373635636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3938303839636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3535636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3631393635636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3139333831636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E302E3633383736636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3335636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E36636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3237373532636D3C2F5769'
		||	'6474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E352E3234393938636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C496D616765204E616D653D22696D61676532223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E31342E35636D3C2F546F703E0D0A20202020202020203C57696474683E31302E34636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020203C4C6566743E352E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E32636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C496D616765204E616D653D22696D61676531223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E362E3235636D3C2F546F703E0D0A20202020202020203C57696474683E31302E34636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C4C6566743E352E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E32636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A20202020202020203C546F703E31302E3336373733636D3C2F546F703E0D0A20202020202020203C57696474683E302E35636D3C2F57696474683E0D0A'
		||	'20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E5265643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020203C57726974696E674D6F64653E74622D726C3C2F57726974696E674D6F64653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E332E3135383733636D3C2F4865696768743E0D0A20202020202020203C56616C75653E434C49454E54453C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32636D3C2F546F703E0D0A20202020202020203C57696474683E302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E5265643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020203C57726974696E674D6F64653E74622D726C3C2F57726974696E674D6F64653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'43616E47726F773E0D0A20202020202020203C4C6566743E31392E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E322E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E42414E434F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A20202020202020203C546F703E31352E39333635636D3C2F546F703E0D0A20202020202020203C57696474683E38636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E372E3238383335636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4449474F44454241525241532E56616C75652C20224C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F4449474F4445424152524153223E0D0A20202020202020203C72643A44656661756C744E616D653E434F4449474F44454241525241533C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E372E3536343832636D3C2F546F703E0D0A20202020202020203C57696474683E38636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E37636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3232333534636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4449474F44454241525241532E56616C75652C20224C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020'
		||	'203C4C696E65204E616D653D226C696E6531223E0D0A20202020202020203C546F703E382E35636D3C2F546F703E0D0A20202020202020203C57696474683E31392E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E4461736865643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C446174615365744E616D653E4C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F3C2F446174615365744E616D653E0D0A20202020202020203C546F703E302E35636D3C2F546F703E0D0A20202020202020203C57696474683E31392E3231303633636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C496D616765204E616D653D22696D61676533223E0D0A202020202020202020202020202020202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A202020202020202020202020202020202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A202020202020202020202020202020202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A202020202020202020202020202020202020202020203C5374796C65202F3E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36383C2F5A496E6465783E0D0A20202020202020202020202020202020'
		||	'2020202020203C56616C75653E6C6F676F5F67646F5F736C6F67616E5F616C74613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F496D6167653E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E393C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D225449504F5F534F4C223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E5449504F5F534F4C3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C52696768743E57686974653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020'
		||	'3C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F5F534F4C2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E312E3331373434636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783532223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020'
		||	'2020202020202020203C5A496E6465783E36363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783533223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020'
		||	'202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783631223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783632223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020'
		||	'202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783638223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E67526967'
		||	'68743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783639223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C'
		||	'56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783731223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783732223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837323C'
		||	'2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783738223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F70'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783931223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020'
		||	'202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3231393537636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783832223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E47617365732064656C2043617269626520532E412E20452E532E502E3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020'
		||	'2020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E343C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783932223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C546578744465636F726174696F6E3E4F7665726C696E653C2F546578744465636F726174696F6E3E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020'
		||	'202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5349205041474120434F4E20434845515545204553435249424120414C2052455350414C444F2044454C204D49534D4F205355204E4F4D4252452C20434F4449474F204445205245464552454E43494120592054454C45464F4E4F20444520434F4E544143544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783432223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67'
		||	'426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783332223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35333C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020'
		||	'3C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E204368657175653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43C3B36469676F2042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F6D6272652042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D73'
		||	'3E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F723C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3930313533636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A20202020'
		||	'20202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783833223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3839302E3130312E3639312D323C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783933223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839333C2F72643A44656661756C744E616D653E0D0A2020'
		||	'20202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436C69656E74653A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434C49454E5445223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434C49454E54453C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A202020202020202020'
		||	'20202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434C49454E54452E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783633223E0D0A202020202020202020202020202020202020202020203C'
		||	'72643A44656661756C744E616D653E74657874626F7836333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4964656E7469666963616369C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224944454E54494649434143494F4E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4944454E54494649434143494F4E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F'
		||	'72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214944454E54494649434143494F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D73'
		||	'3E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783433223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A2020202020'
		||	'20202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783333223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020202020202020202020'
		||	'20203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E'
		||	'6465783E34323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F'
		||	'74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783138223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020'
		||	'20202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538303838636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783834223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020'
		||	'202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43617272657261203534204E6F2E2035392D3134343C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783634223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020'
		||	'202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F6E747261746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434F4E545241544F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434F4E545241544F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E'
		||	'3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313330223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C65'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'3E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E466F726D2E2056656E74613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313239223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020'
		||	'2020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732150524F594543544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783434223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566'
		||	'743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783334223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020'
		||	'202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A202020202020202020202020202020'
		||	'2020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A202020202020202020202020202020202020202020'
		||	'20202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C5269'
		||	'6768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F'
		||	'78204E616D653D2274657874626F783835223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5042583A2033333036303030204641583A20333434313334383C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783935223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020'
		||	'2020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4469722E2056656E74613A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2244495250524F594543544F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E44495250524F594543544F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F5269'
		||	'6768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732144495250524F594543544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783635223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836353C2F72643A'
		||	'44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E20536F6C6963697475643A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22534F4C494349545544223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E534F4C4943495455443C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C65'
		||	'66743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321534F4C4943495455442E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7834'
		||	'35223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C'
		||	'6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783335223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A20'
		||	'20202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F'
		||	'773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783233223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'20203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783234223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F'
		||	'703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783836223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020'
		||	'2020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4CC3AD6E65612047726174756974613A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783936223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31'
		||	'383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5469706F20646520437570C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D225449504F4355504F4E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E5449504F4355504F4E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020202020202020'
		||	'20203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F4355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783636223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020'
		||	'20202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E205265662E205061676F3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224355504F4E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4355504F4E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E'
		||	'6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783436223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020'
		||	'2020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783336223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C65'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020'
		||	'20202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20436865717565733A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783237223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C'
		||	'2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783837223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020'
		||	'2020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E30313830303020393135203333343C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783937223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F7220612070616761723A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C'
		||	'2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F52223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F523C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F726D61743E3D466F726D61744E756D626572284669656C64732156414C4F522E56616C7565293C2F466F726D61743E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F'
		||	'74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C4F522E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783637223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A2020'
		||	'20202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C69646F2068617374613A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C49444F4841535441223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C49444F48415354413C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F'
		||	'703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C49444F48415354412E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783437223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		4393, 
		hextoraw
		(
			'202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783337223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783238223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D'
		||	'0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020'
		||	'2020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20456665637469766F3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A202020202020202020202020'
		||	'20202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3938303839636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3535636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3631393635636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3139333831636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E302E3633383736636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3335636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E36636D3C2F57696474'
		||	'683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3237373532636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E352E3234393938636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E31372E3235636D3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E65732D45533C2F4C616E67756167653E0D0A20203C546F704D617267696E3E302E32636D3C2F546F704D617267696E3E0D0A20203C506167654865696768743E32372E3934636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_31.cuPlantilla( 42 );
	fetch CONFEXME_31.cuPlantilla into nuIdPlantill;
	close CONFEXME_31.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'LDC_CUPON_VENTA_GAS_E_INTERNA',
		       plannomb = 'LDC_CUPON_VENTA_GAS_E_INTERNA',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 42;
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
			42,
			blContent ,
			'LDC_CUPON_VENTA_GAS_E_INTERNA',
			'LDC_CUPON_VENTA_GAS_E_INTERNA',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_31.cuExtractAndMix( 31 );
	fetch CONFEXME_31.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_31.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_CUPON_VENTA_GAS_E_INTERNA',
		       coeminic = NULL,
		       coempada = '<62>',
		       coempadi = 'LDC_CUPON_VENTA_GAS_E_INTERNA',
		       coempame = NULL,
		       coemtido = 66,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 31;
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
			31,
			'LDC_CUPON_VENTA_GAS_E_INTERNA',
			NULL,
			'<62>',
			'LDC_CUPON_VENTA_GAS_E_INTERNA',
			NULL,
			66,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_31.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_31.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_31.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_31.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_31 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_31'
	);
--}
END;
/

