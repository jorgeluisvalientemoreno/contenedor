BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete FORMATO_142 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'FORMATO_142',
		'CREATE OR REPLACE PACKAGE FORMATO_142 IS ' || chr(10) || chr(10) ||
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

		'END FORMATO_142;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'FORMATO_142',
		'CREATE OR REPLACE PACKAGE BODY FORMATO_142 IS ' || chr(10) || chr(10) ||
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

		'END FORMATO_142;'
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open FORMATO_142.cuFormat( 142 );
	fetch FORMATO_142.cuFormat into nuFormatId;
	close FORMATO_142.cuFormat;

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
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open FORMATO_142.cuFormat( 142 );
	fetch FORMATO_142.cuFormat into nuFormatId;
	close FORMATO_142.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		FORMATO_142.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_NEGOCIACION_DEUDA',
		       formtido = 66,
		       formiden = '<142>',
		       formtico = 49,
		       formdein = '<LDC_NEGOCIACION_DEUDA>',
		       formdefi = '</LDC_NEGOCIACION_DEUDA>'
		WHERE  formcodi = FORMATO_142.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		FORMATO_142.rcED_Formato.formcodi := 142 ;

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
			FORMATO_142.rcED_Formato.formcodi,
			'LDC_NEGOCIACION_DEUDA',
			66,
			'<142>',
			49,
			'<LDC_NEGOCIACION_DEUDA>',
			'</LDC_NEGOCIACION_DEUDA>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	FORMATO_142.tbrcGE_Statement( '120096944' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC_NEGOCIACION_DEUDA]', 5 );
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
		FORMATO_142.tbrcGE_Statement( '120096944' ).statement_id,
		1,
		'LDC_NEGOCIACION_DEUDA',
		'SELECT (B.SUBSCRIBER_NAME||'' ''||B.SUBS_LAST_NAME||'' ''||
        B.SUBS_SECOND_LAST_NAME)                                        CLIENTE
        , B.IDENTIFICATION                                              IDENTIFICACION
        ,S.SUSCCODI                                                     CONTRATO
      ,(A.ADDRESS ||''  ''||
         (SELECT X.DESCRIPTION
            FROM GE_GEOGRA_LOCATION X
            WHERE X.GEOGRAP_LOCATION_ID = A.NEIGHBORTHOOD_ID))          DIRPROYECTO
      ,PA.PACKAGE_ID                                                    SOLICITUD
      ,CU.CUPOTIPO                                                      TIPOCUPON
      ,DECODE(CU.CUPONUME, NULL, ''NO SE HA GENERADO CUP¿N'', CU.CUPONUME)CUPON
      ,DECODE(CU.CUPOVALO, NULL, ''NO SE HA GENERADO CUP¿N'', ''$''||TO_CHAR(CU.CUPOVALO, ''FM999,999,999'')) VALOR
      ,''Pago Inmediato'' VALIDOHASTA
        ,''CUPON DE PAGO DE ''||
        UPPER(DAPS_PACKAGE_TYPE.FSBGETDESCRIPTION(
                DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(PA.PACKAGE_ID)))       TIPO_SOL
      ,''(415)''||DALD_PARAMETER.FSBGETVALUE_CHAIN(''COD_EAN_CODIGO_BARRAS'')        ||''(8020)''||LPAD(TO_CHAR(CUPONUME),10,''0'')
        ||''(3900)''||LPAD(TO_CHAR(CUPOVALO),10,''0'')
        ||''(96)''||TO_CHAR((SELECT CC_BOWAITFORPAYMENT.FDTCALCEXPIRATIONDATE(NEG.PACKAGE_ID) - 1 EXPIRATION_DATE FROM DUAL),''YYYYMMDD'') CODIGODEBARRAS
FROM GC_DEBT_NEGOTIATION NEG
     ,CUPON CU
     ,SUSCRIPC S, GE_SUBSCRIBER B
     ,AB_ADDRESS A, GE_GEOGRA_LOCATION G
     , MO_PACKAGES PA
WHERE CU.CUPONUME = NEG.COUPON_ID
    AND NEG.PACKAGE_ID = PA.PACKAGE_ID
    AND S.SUSCCODI = CU.CUPOSUSC
    AND B.SUBSCRIBER_ID = S.SUSCCLIE
    AND A.ADDRESS_ID = S.SUSCIDDI
    AND G.GEOGRAP_LOCATION_ID = A.GEOGRAP_LOCATION_ID
    AND NEG.DEBT_NEGOTIATION_ID =  TO_NUMBER(OBTENERVALORINSTANCIA(''GC_DEBT_NEGOTIATION'',''DEBT_NEGOTIATION_ID''))
    AND CU.CUPOTIPO = ''NG''
    AND ROWNUM = 1',
		'LDC_NEGOCIACION_DEUDA'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		FORMATO_142.tbrcGE_Statement( '120096944' ).statement_id,
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
    <Length>302</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>IDENTIFICACION</Name>
    <Description>IDENTIFICACION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONTRATO</Name>
    <Description>CONTRATO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>8</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIRPROYECTO</Name>
    <Description>DIRPROYECTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>302</Length>
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
    <Length>23</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>VALIDOHASTA</Name>
    <Description>VALIDOHASTA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>15</Length>
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
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	FORMATO_142.tbrcGE_Statement( '120096945' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC_BARCODE_NEGOCIACION_DEUDA]', 5 );
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
		FORMATO_142.tbrcGE_Statement( '120096945' ).statement_id,
		1,
		'LDC_BARCODE_NEGOCIACION_DEUDA',
		'SELECT  ''415''||DALD_PARAMETER.FSBGETVALUE_CHAIN(''COD_EAN_CODIGO_BARRAS'')
        ||''8020''||LPAD(TO_CHAR(CUPONUME),10,''0'')||CHR(200)
        ||''3900''||LPAD(TO_CHAR(CUPOVALO),10,''0'')||CHR(200)
        ||''96''||TO_CHAR((SELECT CC_BOWAITFORPAYMENT.FDTCALCEXPIRATIONDATE(NEG.PACKAGE_ID) - 1 EXPIRATION_DATE FROM DUAL),''YYYYMMDD'') CODE,
        NULL IMAGE
FROM GC_DEBT_NEGOTIATION NEG, CUPON CU
WHERE NEG.DEBT_NEGOTIATION_ID = TO_NUMBER(OBTENERVALORINSTANCIA(''GC_DEBT_NEGOTIATION'',''DEBT_NEGOTIATION_ID''))
AND CU.CUPONUME = NEG.COUPON_ID
AND CU.CUPOTIPO = ''NG''
AND ROWNUM = 1',
		'LDC_BARCODE_NEGOCIACION_DEUDA'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		FORMATO_142.tbrcGE_Statement( '120096945' ).statement_id,
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
    <Length>56</Length>
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
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	FORMATO_142.tbrcED_Franja( 2837 ).francodi := nuNextSeqValue;

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
		FORMATO_142.tbrcED_Franja( 2837 ).francodi,
		'LDC_FRANJADEPOSITO',
		FORMATO_142.tbrcED_Franja( 2837 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	FORMATO_142.tbrcED_FranForm( '2686' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	FORMATO_142.tbrcED_FranForm( '2686' ).frfoform := FORMATO_142.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( FORMATO_142.tbrcED_Franja.exists( 2837 ) ) then
		FORMATO_142.tbrcED_FranForm( '2686' ).frfofran := FORMATO_142.tbrcED_Franja( 2837 ).francodi;
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
		FORMATO_142.tbrcED_FranForm( '2686' ).frfocodi,
		FORMATO_142.tbrcED_FranForm( '2686' ).frfoform,
		FORMATO_142.tbrcED_FranForm( '2686' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	FORMATO_142.tbrcED_FuenDato( '2662' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( FORMATO_142.tbrcGE_Statement.exists( '120096945' ) ) then
		FORMATO_142.tbrcED_FuenDato( '2662' ).fudasent := FORMATO_142.tbrcGE_Statement( '120096945' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_BARCODE_NEGOCIACION_DEUDA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		FORMATO_142.tbrcED_FuenDato( '2662' ).fudacodi,
		'LDC_BARCODE_NEGOCIACION_DEUDA',
		NULL,
		FORMATO_142.tbrcED_FuenDato( '2662' ).fudasent
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( FORMATO_142.tbrcGE_Statement.exists( '120096944' ) ) then
		FORMATO_142.tbrcED_FuenDato( '2663' ).fudasent := FORMATO_142.tbrcGE_Statement( '120096944' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_NEGOCIACION_DEUDA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi,
		'LDC_NEGOCIACION_DEUDA',
		NULL,
		FORMATO_142.tbrcED_FuenDato( '2663' ).fudasent
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '20882' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2662' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '20882' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2662' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '20882' ).atfdcodi,
		'CODE',
		'CODE',
		1,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '20882' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '20883' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2662' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '20883' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2662' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '20883' ).atfdcodi,
		'IMAGE',
		'IMAGE',
		2,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '20883' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29795' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29795' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29795' ).atfdcodi,
		'CLIENTE',
		'CLIENTE',
		1,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29795' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29796' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29796' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29796' ).atfdcodi,
		'IDENTIFICACION',
		'IDENTIFICACION',
		2,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29796' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29797' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29797' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29797' ).atfdcodi,
		'CONTRATO',
		'CONTRATO',
		3,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29797' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29798' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29798' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29798' ).atfdcodi,
		'DIRPROYECTO',
		'DIRPROYECTO',
		4,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29798' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29799' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29799' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29799' ).atfdcodi,
		'SOLICITUD',
		'SOLICITUD',
		5,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29799' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29800' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29800' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29800' ).atfdcodi,
		'TIPOCUPON',
		'TIPOCUPON',
		6,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29800' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29801' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29801' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29801' ).atfdcodi,
		'CUPON',
		'CUPON',
		7,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29801' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29802' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29802' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29802' ).atfdcodi,
		'VALOR',
		'VALOR',
		8,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29802' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29803' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29803' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29803' ).atfdcodi,
		'VALIDOHASTA',
		'VALIDOHASTA',
		9,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29803' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29804' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29804' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29804' ).atfdcodi,
		'TIPO_SOL',
		'TIPO_SOL',
		10,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29804' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	FORMATO_142.tbrcED_AtriFuda( '29805' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_AtriFuda( '29805' ).atfdfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_AtriFuda( '29805' ).atfdcodi,
		'CODIGODEBARRAS',
		'CODIGODEBARRAS',
		11,
		'S',
		FORMATO_142.tbrcED_AtriFuda( '29805' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	FORMATO_142.tbrcED_Bloque( 4379 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2662' ) ) then
		FORMATO_142.tbrcED_Bloque( 4379 ).bloqfuda := FORMATO_142.tbrcED_FuenDato( '2662' ).fudacodi;
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
		FORMATO_142.tbrcED_Bloque( 4379 ).bloqcodi,
		'LDC_EXTRA_BARCODE_',
		FORMATO_142.tbrcED_Bloque( 4379 ).bloqtibl,
		FORMATO_142.tbrcED_Bloque( 4379 ).bloqfuda,
		'<EXTRA_BARCODE_>',
		'</EXTRA_BARCODE_>'
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	FORMATO_142.tbrcED_Bloque( 4380 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( FORMATO_142.tbrcED_FuenDato.exists( '2663' ) ) then
		FORMATO_142.tbrcED_Bloque( 4380 ).bloqfuda := FORMATO_142.tbrcED_FuenDato( '2663' ).fudacodi;
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
		FORMATO_142.tbrcED_Bloque( 4380 ).bloqcodi,
		'LDC_BLOQUEDEPOSITO',
		FORMATO_142.tbrcED_Bloque( 4380 ).bloqtibl,
		FORMATO_142.tbrcED_Bloque( 4380 ).bloqfuda,
		'<LDC_FRANJADEPOSITO_LDC_BLOQUEDEPOSITO>',
		'</LDC_FRANJADEPOSITO_LDC_BLOQUEDEPOSITO>'
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	FORMATO_142.tbrcED_BloqFran( '4543' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	FORMATO_142.tbrcED_BloqFran( '4543' ).blfrfrfo := FORMATO_142.tbrcED_FranForm( '2686' ).frfocodi;

	-- Se asigna el bloque
	if ( FORMATO_142.tbrcED_Bloque.exists( 4379 ) ) then
		FORMATO_142.tbrcED_BloqFran( '4543' ).blfrbloq := FORMATO_142.tbrcED_Bloque( 4379 ).bloqcodi;
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
		FORMATO_142.tbrcED_BloqFran( '4543' ).blfrcodi,
		FORMATO_142.tbrcED_BloqFran( '4543' ).blfrbloq,
		FORMATO_142.tbrcED_BloqFran( '4543' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	FORMATO_142.tbrcED_BloqFran( '4544' ).blfrfrfo := FORMATO_142.tbrcED_FranForm( '2686' ).frfocodi;

	-- Se asigna el bloque
	if ( FORMATO_142.tbrcED_Bloque.exists( 4380 ) ) then
		FORMATO_142.tbrcED_BloqFran( '4544' ).blfrbloq := FORMATO_142.tbrcED_Bloque( 4380 ).bloqcodi;
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
		FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi,
		FORMATO_142.tbrcED_BloqFran( '4544' ).blfrbloq,
		FORMATO_142.tbrcED_BloqFran( '4544' ).blfrfrfo,
		2,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '25098' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '25098' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '20882' ) ) then
		FORMATO_142.tbrcED_Item( '25098' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '20882' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '25098' ).itemcodi,
		'CODE',
		FORMATO_142.tbrcED_Item( '25098' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '25098' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '25098' ).itemgren,
		NULL,
		1,
		'<CODE>',
		'</CODE>',
		FORMATO_142.tbrcED_Item( '25098' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '25099' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '25099' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '20883' ) ) then
		FORMATO_142.tbrcED_Item( '25099' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '20883' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '25099' ).itemcodi,
		'IMAGE',
		FORMATO_142.tbrcED_Item( '25099' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '25099' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '25099' ).itemgren,
		NULL,
		1,
		'<IMAGE>',
		'</IMAGE>',
		FORMATO_142.tbrcED_Item( '25099' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35041' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35041' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29795' ) ) then
		FORMATO_142.tbrcED_Item( '35041' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29795' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35041' ).itemcodi,
		'CLIENTE',
		FORMATO_142.tbrcED_Item( '35041' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35041' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35041' ).itemgren,
		NULL,
		1,
		'<CLIENTE>',
		'</CLIENTE>',
		FORMATO_142.tbrcED_Item( '35041' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35042' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35042' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29796' ) ) then
		FORMATO_142.tbrcED_Item( '35042' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29796' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35042' ).itemcodi,
		'IDENTIFICACION',
		FORMATO_142.tbrcED_Item( '35042' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35042' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35042' ).itemgren,
		NULL,
		1,
		'<IDENTIFICACION>',
		'</IDENTIFICACION>',
		FORMATO_142.tbrcED_Item( '35042' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35043' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35043' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29797' ) ) then
		FORMATO_142.tbrcED_Item( '35043' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29797' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35043' ).itemcodi,
		'CONTRATO',
		FORMATO_142.tbrcED_Item( '35043' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35043' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35043' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		FORMATO_142.tbrcED_Item( '35043' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35044' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35044' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29798' ) ) then
		FORMATO_142.tbrcED_Item( '35044' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29798' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35044' ).itemcodi,
		'DIRPROYECTO',
		FORMATO_142.tbrcED_Item( '35044' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35044' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35044' ).itemgren,
		NULL,
		1,
		'<DIRPROYECTO>',
		'</DIRPROYECTO>',
		FORMATO_142.tbrcED_Item( '35044' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35045' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35045' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29799' ) ) then
		FORMATO_142.tbrcED_Item( '35045' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29799' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35045' ).itemcodi,
		'SOLICITUD',
		FORMATO_142.tbrcED_Item( '35045' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35045' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35045' ).itemgren,
		NULL,
		2,
		'<SOLICITUD>',
		'</SOLICITUD>',
		FORMATO_142.tbrcED_Item( '35045' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35046' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35046' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29800' ) ) then
		FORMATO_142.tbrcED_Item( '35046' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29800' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35046' ).itemcodi,
		'TIPOCUPON',
		FORMATO_142.tbrcED_Item( '35046' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35046' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35046' ).itemgren,
		NULL,
		1,
		'<TIPOCUPON>',
		'</TIPOCUPON>',
		FORMATO_142.tbrcED_Item( '35046' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35047' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35047' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29801' ) ) then
		FORMATO_142.tbrcED_Item( '35047' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29801' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35047' ).itemcodi,
		'CUPON',
		FORMATO_142.tbrcED_Item( '35047' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35047' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35047' ).itemgren,
		NULL,
		1,
		'<CUPON>',
		'</CUPON>',
		FORMATO_142.tbrcED_Item( '35047' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35048' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35048' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29802' ) ) then
		FORMATO_142.tbrcED_Item( '35048' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29802' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35048' ).itemcodi,
		'VALOR',
		FORMATO_142.tbrcED_Item( '35048' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35048' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35048' ).itemgren,
		NULL,
		1,
		'<VALOR>',
		'</VALOR>',
		FORMATO_142.tbrcED_Item( '35048' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35049' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35049' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29803' ) ) then
		FORMATO_142.tbrcED_Item( '35049' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29803' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35049' ).itemcodi,
		'VALIDOHASTA',
		FORMATO_142.tbrcED_Item( '35049' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35049' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35049' ).itemgren,
		NULL,
		1,
		'<VALIDOHASTA>',
		'</VALIDOHASTA>',
		FORMATO_142.tbrcED_Item( '35049' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35050' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35050' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29804' ) ) then
		FORMATO_142.tbrcED_Item( '35050' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29804' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35050' ).itemcodi,
		'TIPO_SOL',
		FORMATO_142.tbrcED_Item( '35050' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35050' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35050' ).itemgren,
		NULL,
		1,
		'<TIPO_SOL>',
		'</TIPO_SOL>',
		FORMATO_142.tbrcED_Item( '35050' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	FORMATO_142.tbrcED_Item( '35051' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	FORMATO_142.tbrcED_Item( '35051' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( FORMATO_142.tbrcED_AtriFuda.exists( '29805' ) ) then
		FORMATO_142.tbrcED_Item( '35051' ).itematfd := FORMATO_142.tbrcED_AtriFuda( '29805' ).atfdcodi;
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
		FORMATO_142.tbrcED_Item( '35051' ).itemcodi,
		'CODIGODEBARRAS',
		FORMATO_142.tbrcED_Item( '35051' ).itemceid,
		NULL,
		FORMATO_142.tbrcED_Item( '35051' ).itemobna,
		0,
		NULL,
		NULL,
		FORMATO_142.tbrcED_Item( '35051' ).itemgren,
		NULL,
		1,
		'<CODIGODEBARRAS>',
		'</CODIGODEBARRAS>',
		FORMATO_142.tbrcED_Item( '35051' ).itematfd
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
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
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '25053' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '25053' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4543' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '25098' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '25053' ).itblitem := FORMATO_142.tbrcED_Item( '25098' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '25053' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '25053' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '25053' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '25054' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '25054' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4543' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '25099' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '25054' ).itblitem := FORMATO_142.tbrcED_Item( '25099' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '25054' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '25054' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '25054' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35016' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35016' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35041' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35016' ).itblitem := FORMATO_142.tbrcED_Item( '35041' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35016' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35016' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35016' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35017' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35017' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35042' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35017' ).itblitem := FORMATO_142.tbrcED_Item( '35042' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35017' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35017' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35017' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35018' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35018' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35043' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35018' ).itblitem := FORMATO_142.tbrcED_Item( '35043' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35018' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35018' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35018' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35019' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35019' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35044' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35019' ).itblitem := FORMATO_142.tbrcED_Item( '35044' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35019' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35019' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35019' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35020' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35020' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35045' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35020' ).itblitem := FORMATO_142.tbrcED_Item( '35045' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35020' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35020' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35020' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35021' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35021' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35046' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35021' ).itblitem := FORMATO_142.tbrcED_Item( '35046' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35021' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35021' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35021' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35022' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35022' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35047' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35022' ).itblitem := FORMATO_142.tbrcED_Item( '35047' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35022' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35022' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35022' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35023' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35023' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35048' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35023' ).itblitem := FORMATO_142.tbrcED_Item( '35048' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35023' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35023' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35023' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35024' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35024' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35049' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35024' ).itblitem := FORMATO_142.tbrcED_Item( '35049' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35024' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35024' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35024' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35025' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35025' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35050' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35025' ).itblitem := FORMATO_142.tbrcED_Item( '35050' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35025' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35025' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35025' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	FORMATO_142.tbrcED_ItemBloq( '35026' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	FORMATO_142.tbrcED_ItemBloq( '35026' ).itblblfr := FORMATO_142.tbrcED_BloqFran( '4544' ).blfrcodi;

	-- Se asigna el item
	if ( FORMATO_142.tbrcED_Item.exists( '35051' ) ) then
		FORMATO_142.tbrcED_ItemBloq( '35026' ).itblitem := FORMATO_142.tbrcED_Item( '35051' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		FORMATO_142.tbrcED_ItemBloq( '35026' ).itblcodi,
		FORMATO_142.tbrcED_ItemBloq( '35026' ).itblitem,
		FORMATO_142.tbrcED_ItemBloq( '35026' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		FORMATO_142.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( FORMATO_142.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	FORMATO_142.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not FORMATO_142.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete FORMATO_142 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'FORMATO_142'
	);
--}
END;
/

