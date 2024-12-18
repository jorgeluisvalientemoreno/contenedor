BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_109 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_109',
		'CREATE OR REPLACE PACKAGE CONFEXME_109 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_109;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_109',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_109 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_109;'
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_109.cuFormat( 183 );
	fetch CONFEXME_109.cuFormat into nuFormatId;
	close CONFEXME_109.cuFormat;

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
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_109.cuFormat( 183 );
	fetch CONFEXME_109.cuFormat into nuFormatId;
	close CONFEXME_109.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_109.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = '1 - Pagare oficial GDC - EFG',
		       formtido = 77,
		       formiden = '<183>',
		       formtico = 80,
		       formdein = '<PAGARE>',
		       formdefi = '</PAGARE>'
		WHERE  formcodi = CONFEXME_109.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_109.rcED_Formato.formcodi := 183 ;

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
			CONFEXME_109.rcED_Formato.formcodi,
			'1 - Pagare oficial GDC - EFG',
			77,
			'<183>',
			80,
			'<PAGARE>',
			'</PAGARE>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_109.tbrcGE_Statement( '120198035' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [Extraccion de datos del encabezado del pagare para las personas juridicas de GDC]', 5 );
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
		CONFEXME_109.tbrcGE_Statement( '120198035' ).statement_id,
		47,
		'Extraccion de datos del encabezado del pagare para las personas juridicas de GDC',
		'SELECT /*index (a pk_pagare), index (c idx_cc_financing_request04), index(d pk_suscripc), index (e pk_ab_address) */
       (SELECT sistlogo FROM ldc_sistlogo WHERE ROWNUM=1) logo,a.pagacodi paga,b.sistnitc NIT,To_Char(a.pagafech,''fmmonth dd " de " yyyy'')  FECHA, c.subscription_id contrato,e.subscriber_name||'' ''||e.subs_last_name NOMBRE, f.address DIRE, e.IDENT_TYPE_ID tipo_id, e.IDENTIFICATION, user LOGIN_USUARIO
FROM   pagare a,sistema b, cc_financing_request c,suscripc d, ge_subscriber e,ab_address f
WHERE  a.pagacodi = to_number(obtenervalorinstancia(''PAGARE'',''PAGACODI''))
  AND  c.financing_id = a.pagacofi
  AND  d.susccodi = c.subscription_id
  AND  e.subscriber_id = d.suscclie
  AND  f.address_id = d.susciddi
and b.sistcodi=99',
		'LDC_PAGAREPJGDC'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_109.tbrcGE_Statement( '120198035' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>LOGO</Name>
    <Description>LOGO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>PAGA</Name>
    <Description>PAGA</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NIT</Name>
    <Description>NIT</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA</Name>
    <Description>FECHA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>23</Length>
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
    <Name>NOMBRE</Name>
    <Description>NOMBRE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>201</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIRE</Name>
    <Description>DIRE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>200</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_ID</Name>
    <Description>TIPO_ID</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>IDENTIFICATION</Name>
    <Description>Identificación</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
    <Entity>GE_SUBSCRIBER</Entity>
    <Column>IDENTIFICATION</Column>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LOGIN_USUARIO</Name>
    <Description>LOGIN_USUARIO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_109.tbrcGE_Statement( '120198036' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDIPA_TOTPJGDC]', 5 );
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
		CONFEXME_109.tbrcGE_Statement( '120198036' ).statement_id,
		47,
		'LDIPA_TOTPJGDC',
		'SELECT To_Char(Sum(x.cuoini),''$999,999,999'') totini,
       To_Char(Sum(x.vrdife),''$999,999,999'') totdife,
       To_Char(Sum(x.cuoini),''$999,999,999'') totpag,
       (case when Sum(x.cuoini)>0 then LDC_IMPORTEENLETRAS(Sum(x.cuoini))||'' Pesos M/Cte'' else '''' end) letras,
       (case when x.codigofinanciacion>0 then ''Financiacion: '' || codigofinanciacion else '''' end) financiacion
FROM (SELECT /*index (c ix_diferido02),index (d ix_concserv02*/
             e.servcodi||'' - ''||e.servdesc tiprd,
             b.initial_payment cuoini,
             Sum(c.difevatd) vrdife,
             a.pagacofi codigofinanciacion
      FROM   pagare a
      JOIN   cc_financing_request b ON a.pagacofi = b.FINANCING_ID
      LEFT JOIN   diferido c ON b.financing_id = c.difecofi
      LEFT JOIN   servsusc d ON d.sesunuse = c.difenuse
      LEFT JOIN   servicio e ON e.servcodi = d.sesuserv
      WHERE  a.pagacodi = to_number(obtenervalorinstancia(''PAGARE'',''PAGACODI''))
      GROUP BY e.servcodi,e.servdesc,b.initial_payment,a.pagacofi) x group by  x.codigofinanciacion',
		'LDIPA_TOTPJGDC'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_109.tbrcGE_Statement( '120198036' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>TOTINI</Name>
    <Description>TOTINI</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TOTDIFE</Name>
    <Description>TOTDIFE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TOTPAG</Name>
    <Description>TOTPAG</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LETRAS</Name>
    <Description>LETRAS</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FINANCIACION</Name>
    <Description>FINANCIACION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_109.tbrcGE_Statement( '120198037' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDIPA_CARTAPJGDC]', 5 );
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
		CONFEXME_109.tbrcGE_Statement( '120198037' ).statement_id,
		47,
		'LDIPA_CARTAPJGDC',
		' SELECT To_Char(x.value_to_finance,''$999,999,999'') capital,
         To_Char((x.paganucu*x.valor_cuota)-x.value_to_finance,''$999,999,999'') intereses,
         x.paganucu numcuota,
                  To_Char(x.valor_cuota,''$999,999,999'') vrcuota,
                  CASE
                       WHEN x.codigo_3 IS NOT NULL THEN
                        ''(415)'' || x.codigo_1 || ''(8020)'' || x.codigo_2 || ''(3900)'' || x.codigo_3 ||
                        ''(96)'' || x.codigo_4
                       ELSE
                        NULL
                   END txtbarra,
    x.tipo_cupon,
    x.codigo_2 referencia,
    X.VALIDO_HASTA,
    X.TXT_MENSAJE
  FROM (
    SELECT  /*index (a pk_pagare), index (b ix_diferido02)*/
          dald_parameter.fsbGetValue_Chain(''COD_EAN_CODIGO_BARRAS'') codigo_1,
          To_char(d.cuponume) codigo_2,
          lpad(round(d.cupovalo), 10, ''0'') codigo_3,
          TO_CHAR((SELECT CC_BOWAITFORPAYMENT.FDTCALCEXPIRATIONDATE(n.package_id) - 1 EXPIRATION_DATE FROM DUAL),''YYYYMMDD'') codigo_4,
          b.quotas_number paganucu,b.quota_value valor_cuota,
          b.value_to_finance,
      d.cupotipo tipo_cupon,
      /*to_date(to_char(b.init_pay_expiration,''dd/mm/yyyy''))*/''INMEDIATO'' AS VALIDO_HASTA,
     dald_parameter.fsbGetValue_Chain(''PARAM_MENSAJE_NO_PAGO'',NULL) AS TXT_MENSAJE
    FROM pagare   a
    JOIN cc_financing_request b ON b.financing_id = a.pagacofi
    jOIN GC_DEBT_NEGOTIATION n ON n.package_id = b.package_id
    left JOIN cupon           d ON d.cuponume = n.coupon_id
    WHERE a.pagacodi =  to_number(obtenervalorinstancia(''PAGARE'',''PAGACODI''))
    UNION
                    SELECT NULL,
                           '' '',
                           NULL,
                           '' '',
                           NULL,
                           0,
                           0,
null,
null,
NULL

                    FROM   dual
  ) x
  WHERE ROWNUM=1',
		'LDIPA_CARTAPJGDC'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_109.tbrcGE_Statement( '120198037' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CAPITAL</Name>
    <Description>CAPITAL</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>INTERESES</Name>
    <Description>INTERESES</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NUMCUOTA</Name>
    <Description>NUMCUOTA</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>VRCUOTA</Name>
    <Description>VRCUOTA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TXTBARRA</Name>
    <Description>TXTBARRA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_CUPON</Name>
    <Description>TIPO_CUPON</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>REFERENCIA</Name>
    <Description>REFERENCIA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>40</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>VALIDO_HASTA</Name>
    <Description>VALIDO_HASTA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TXT_MENSAJE</Name>
    <Description>TXT_MENSAJE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_109.tbrcGE_Statement( '120198038' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDIPA_BARRA]', 5 );
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
		CONFEXME_109.tbrcGE_Statement( '120198038' ).statement_id,
		47,
		'LDIPA_BARRA',
		'SELECT CASE
          WHEN x.codigo_3 IS NOT NULL THEN
         ''(415)'' || x.codigo_1 || ''(8020)'' || x.codigo_2 || ''(3900)'' || x.codigo_3 ||''(96)'' || x.codigo_4
          ELSE
          NULL
      END barras,
      NULL image
  FROM (
    SELECT  /*index (a pk_pagare), index (b ix_diferido02)*/
          dald_parameter.fsbGetValue_Chain(''COD_EAN_CODIGO_BARRAS'') codigo_1,
          lpad(d.cuponume, 10, ''0'') codigo_2,
          lpad(round(d.cupovalo), 10, ''0'') codigo_3,
          TO_CHAR((SELECT CC_BOWAITFORPAYMENT.FDTCALCEXPIRATIONDATE(n.package_id) - 1 EXPIRATION_DATE FROM DUAL),''YYYYMMDD'') codigo_4,
          b.quotas_number paganucu,b.quota_value valor_cuota,
          b.value_to_finance
    FROM pagare   a
    JOIN cc_financing_request b ON b.financing_id = a.pagacofi
    jOIN GC_DEBT_NEGOTIATION n ON n.package_id = b.package_id
    left JOIN cupon           d ON d.cuponume = n.coupon_id
    WHERE a.pagacodi =  to_number(obtenervalorinstancia(''PAGARE'',''PAGACODI''))
    UNION
                    SELECT NULL,
                           '' '',
                           NULL,
                           '' '',
                           NULL,
                           0,
                           0

                    FROM   dual
  ) x
  WHERE ROWNUM=1
',
		'LDIPA_BARRA'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_109.tbrcGE_Statement( '120198038' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>BARRAS</Name>
    <Description>BARRAS</Description>
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
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_109.tbrcGE_Statement( '120198039' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDIPA_DETAPJGDC]', 5 );
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
		CONFEXME_109.tbrcGE_Statement( '120198039' ).statement_id,
		47,
		'LDIPA_DETAPJGDC',
		'SELECT ROWNUM item,x.*
FROM (SELECT /*index (c ix_diferido02),index (d ix_concserv02)*/
             e.servcodi||'' - ''||e.servdesc tiprd,
             To_Char(b.initial_payment,''$999,999,999'') cuoini,
             To_Char(Sum(c.difevatd),''$999,999,999'') vrdife
      FROM   pagare a
      JOIN   cc_financing_request b ON a.pagacofi = b.financing_id
      LEFT JOIN   diferido c ON b.financing_id = c.difecofi
      JOIN   MO_MOTIVE M ON M.PACKAGE_ID = b.PACKAGE_ID

     JOIN   servicio e ON e.servcodi = M.PRODUCT_TYPE_ID
      WHERE  a.pagacodi = to_number(obtenervalorinstancia(''PAGARE'',''PAGACODI''))
      GROUP BY e.servcodi,e.servdesc,b.initial_payment) x',
		'LDIPA_DETAPJGDC'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_109.tbrcGE_Statement( '120198039' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>ITEM</Name>
    <Description>ITEM</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPRD</Name>
    <Description>TIPRD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>73</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CUOINI</Name>
    <Description>CUOINI</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>VRDIFE</Name>
    <Description>VRDIFE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>13</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_109.tbrcGE_Statement( '120198040' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [DATOS DEL SOLICITANTE]', 5 );
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
		CONFEXME_109.tbrcGE_Statement( '120198040' ).statement_id,
		14,
		'DATOS DEL SOLICITANTE',
		'SELECT gs.IDENTIFICATION cedula, gs.SUBSCRIBER_NAME || '' '' || gs.SUBS_LAST_NAME nombre
FROM cc_financing_request cf, MO_PACKAGES mp, GE_SUBSCRIBER gs, pagare pg
where cf.PACKAGE_ID = mp.PACKAGE_ID and mp.CONTACT_ID = gs.SUBSCRIBER_ID
      AND pg.PAGACOFI = cf.FINANCING_ID and pg.pagacodi = to_number(obtenervalorinstancia(''PAGARE'',''PAGACODI''))',
		'SOLICITANTE'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_109.tbrcGE_Statement( '120198040' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CEDULA</Name>
    <Description>CEDULA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE</Name>
    <Description>NOMBRE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>201</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_109.tbrcED_Franja( 4878 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [Franja_pagare]', 5 );
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
		CONFEXME_109.tbrcED_Franja( 4878 ).francodi,
		'Franja_pagare',
		CONFEXME_109.tbrcED_Franja( 4878 ).frantifr,
		'<FR_ENCABEZADO>',
		'</FR_ENCABEZADO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_109.tbrcED_Franja( 4879 ).francodi := nuNextSeqValue;

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
		CONFEXME_109.tbrcED_Franja( 4879 ).francodi,
		'DETALLE',
		CONFEXME_109.tbrcED_Franja( 4879 ).frantifr,
		'<DETALLE>',
		'</DETALLE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_109.tbrcED_FranForm( '4727' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_109.tbrcED_FranForm( '4727' ).frfoform := CONFEXME_109.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_109.tbrcED_Franja.exists( 4878 ) ) then
		CONFEXME_109.tbrcED_FranForm( '4727' ).frfofran := CONFEXME_109.tbrcED_Franja( 4878 ).francodi;
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
		CONFEXME_109.tbrcED_FranForm( '4727' ).frfocodi,
		CONFEXME_109.tbrcED_FranForm( '4727' ).frfoform,
		CONFEXME_109.tbrcED_FranForm( '4727' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_109.tbrcED_FranForm( '4728' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_109.tbrcED_FranForm( '4728' ).frfoform := CONFEXME_109.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_109.tbrcED_Franja.exists( 4879 ) ) then
		CONFEXME_109.tbrcED_FranForm( '4728' ).frfofran := CONFEXME_109.tbrcED_Franja( 4879 ).francodi;
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
		CONFEXME_109.tbrcED_FranForm( '4728' ).frfocodi,
		CONFEXME_109.tbrcED_FranForm( '4728' ).frfoform,
		CONFEXME_109.tbrcED_FranForm( '4728' ).frfofran,
		2,
		'S'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_109.tbrcGE_Statement.exists( '120198035' ) ) then
		CONFEXME_109.tbrcED_FuenDato( '4037' ).fudasent := CONFEXME_109.tbrcGE_Statement( '120198035' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_PAGAREPJGDC]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi,
		'LDC_PAGAREPJGDC',
		NULL,
		CONFEXME_109.tbrcED_FuenDato( '4037' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_109.tbrcGE_Statement.exists( '120198036' ) ) then
		CONFEXME_109.tbrcED_FuenDato( '4038' ).fudasent := CONFEXME_109.tbrcGE_Statement( '120198036' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDIPA_TOTPJGDC]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi,
		'LDIPA_TOTPJGDC',
		NULL,
		CONFEXME_109.tbrcED_FuenDato( '4038' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_109.tbrcGE_Statement.exists( '120198037' ) ) then
		CONFEXME_109.tbrcED_FuenDato( '4039' ).fudasent := CONFEXME_109.tbrcGE_Statement( '120198037' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDIPA_CARTAPJGDC]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi,
		'LDIPA_CARTAPJGDC',
		NULL,
		CONFEXME_109.tbrcED_FuenDato( '4039' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_109.tbrcED_FuenDato( '4040' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_109.tbrcGE_Statement.exists( '120198038' ) ) then
		CONFEXME_109.tbrcED_FuenDato( '4040' ).fudasent := CONFEXME_109.tbrcGE_Statement( '120198038' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDIPA_BARRA]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_109.tbrcED_FuenDato( '4040' ).fudacodi,
		'LDIPA_BARRA',
		NULL,
		CONFEXME_109.tbrcED_FuenDato( '4040' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_109.tbrcED_FuenDato( '4041' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_109.tbrcGE_Statement.exists( '120198039' ) ) then
		CONFEXME_109.tbrcED_FuenDato( '4041' ).fudasent := CONFEXME_109.tbrcGE_Statement( '120198039' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDIPA_DETAPJGDC]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_109.tbrcED_FuenDato( '4041' ).fudacodi,
		'LDIPA_DETAPJGDC',
		NULL,
		CONFEXME_109.tbrcED_FuenDato( '4041' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_109.tbrcED_FuenDato( '4042' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_109.tbrcGE_Statement.exists( '120198040' ) ) then
		CONFEXME_109.tbrcED_FuenDato( '4042' ).fudasent := CONFEXME_109.tbrcGE_Statement( '120198040' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DATO_SOLICITANTE]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_109.tbrcED_FuenDato( '4042' ).fudacodi,
		'DATO_SOLICITANTE',
		NULL,
		CONFEXME_109.tbrcED_FuenDato( '4042' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31909' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4042' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31909' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4042' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CEDULA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31909' ).atfdcodi,
		'CEDULA',
		'CEDULA',
		1,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31909' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31910' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4042' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31910' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4042' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOMBRE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31910' ).atfdcodi,
		'NOMBRE',
		'NOMBRE',
		2,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31910' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31911' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4041' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31911' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4041' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ITEM]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31911' ).atfdcodi,
		'ITEM',
		'ITEM',
		1,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31911' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31912' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4041' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31912' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4041' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TIPRD]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31912' ).atfdcodi,
		'TIPRD',
		'TIPRD',
		2,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31912' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31913' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4041' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31913' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4041' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CUOINI]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31913' ).atfdcodi,
		'CUOINI',
		'CUOINI',
		3,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31913' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31914' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4041' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31914' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4041' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [VRDIFE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31914' ).atfdcodi,
		'VRDIFE',
		'VRDIFE',
		4,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31914' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31915' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4040' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31915' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4040' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [BARRAS]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31915' ).atfdcodi,
		'BARRAS',
		'BARRAS',
		1,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31915' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31916' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4040' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31916' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4040' ).fudacodi;
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
		CONFEXME_109.tbrcED_AtriFuda( '31916' ).atfdcodi,
		'IMAGE',
		'IMAGE',
		2,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31916' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31917' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31917' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CAPITAL]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31917' ).atfdcodi,
		'CAPITAL',
		'CAPITAL',
		1,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31917' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31918' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31918' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [INTERESES]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31918' ).atfdcodi,
		'INTERESES',
		'INTERESES',
		2,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31918' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31919' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31919' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NUMCUOTA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31919' ).atfdcodi,
		'NUMCUOTA',
		'NUMCUOTA',
		3,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31919' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31920' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31920' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [VRCUOTA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31920' ).atfdcodi,
		'VRCUOTA',
		'VRCUOTA',
		4,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31920' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31921' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31921' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TXTBARRA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31921' ).atfdcodi,
		'TXTBARRA',
		'TXTBARRA',
		5,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31921' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31922' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31922' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TIPO_CUPON]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31922' ).atfdcodi,
		'TIPO_CUPON',
		'TIPO_CUPON',
		6,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31922' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31923' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31923' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [REFERENCIA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31923' ).atfdcodi,
		'REFERENCIA',
		'REFERENCIA',
		7,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31923' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31924' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31924' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [VALIDO_HASTA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31924' ).atfdcodi,
		'VALIDO_HASTA',
		'VALIDO_HASTA',
		8,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31924' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31925' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31925' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TXT_MENSAJE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31925' ).atfdcodi,
		'TXT_MENSAJE',
		'TXT_MENSAJE',
		9,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31925' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31926' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4038' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31926' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TOTINI]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31926' ).atfdcodi,
		'TOTINI',
		'TOTINI',
		1,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31926' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31927' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4038' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31927' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TOTDIFE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31927' ).atfdcodi,
		'TOTDIFE',
		'TOTDIFE',
		2,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31927' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31928' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4038' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31928' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TOTPAG]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31928' ).atfdcodi,
		'TOTPAG',
		'TOTPAG',
		3,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31928' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31929' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4038' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31929' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LETRAS]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31929' ).atfdcodi,
		'LETRAS',
		'LETRAS',
		4,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31929' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31930' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4038' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31930' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FINANCIACION]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31930' ).atfdcodi,
		'FINANCIACION',
		'FINANCIACION',
		5,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31930' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31931' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31931' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LOGO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31931' ).atfdcodi,
		'LOGO',
		'LOGO',
		1,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31931' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31932' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31932' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [PAGA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31932' ).atfdcodi,
		'PAGA',
		'PAGA',
		2,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31932' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31933' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31933' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NIT]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31933' ).atfdcodi,
		'NIT',
		'NIT',
		3,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31933' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31934' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31934' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
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
		CONFEXME_109.tbrcED_AtriFuda( '31934' ).atfdcodi,
		'FECHA',
		'FECHA',
		4,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31934' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31935' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31935' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
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
		CONFEXME_109.tbrcED_AtriFuda( '31935' ).atfdcodi,
		'CONTRATO',
		'CONTRATO',
		5,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31935' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31936' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31936' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOMBRE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31936' ).atfdcodi,
		'NOMBRE',
		'NOMBRE',
		6,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31936' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31937' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31937' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DIRE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31937' ).atfdcodi,
		'DIRE',
		'DIRE',
		7,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31937' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31938' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31938' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TIPO_ID]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31938' ).atfdcodi,
		'TIPO_ID',
		'TIPO_ID',
		8,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31938' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31939' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31939' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Identificación]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31939' ).atfdcodi,
		'IDENTIFICATION',
		'Identificación',
		9,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31939' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_109.tbrcED_AtriFuda( '31940' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_AtriFuda( '31940' ).atfdfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LOGIN_USUARIO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_109.tbrcED_AtriFuda( '31940' ).atfdcodi,
		'LOGIN_USUARIO',
		'LOGIN_USUARIO',
		10,
		'S',
		CONFEXME_109.tbrcED_AtriFuda( '31940' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_109.tbrcED_Bloque( 6944 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4037' ) ) then
		CONFEXME_109.tbrcED_Bloque( 6944 ).bloqfuda := CONFEXME_109.tbrcED_FuenDato( '4037' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [ENCABEZADO]', 5 );
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
		CONFEXME_109.tbrcED_Bloque( 6944 ).bloqcodi,
		'ENCABEZADO',
		CONFEXME_109.tbrcED_Bloque( 6944 ).bloqtibl,
		CONFEXME_109.tbrcED_Bloque( 6944 ).bloqfuda,
		'<ENCABEZADO>',
		'</ENCABEZADO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_109.tbrcED_Bloque( 6945 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4038' ) ) then
		CONFEXME_109.tbrcED_Bloque( 6945 ).bloqfuda := CONFEXME_109.tbrcED_FuenDato( '4038' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [SUBTOTAL]', 5 );
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
		CONFEXME_109.tbrcED_Bloque( 6945 ).bloqcodi,
		'SUBTOTAL',
		CONFEXME_109.tbrcED_Bloque( 6945 ).bloqtibl,
		CONFEXME_109.tbrcED_Bloque( 6945 ).bloqfuda,
		'<SUBTOTAL>',
		'</SUBTOTAL>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_109.tbrcED_Bloque( 6946 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4039' ) ) then
		CONFEXME_109.tbrcED_Bloque( 6946 ).bloqfuda := CONFEXME_109.tbrcED_FuenDato( '4039' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [CARTA]', 5 );
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
		CONFEXME_109.tbrcED_Bloque( 6946 ).bloqcodi,
		'CARTA',
		CONFEXME_109.tbrcED_Bloque( 6946 ).bloqtibl,
		CONFEXME_109.tbrcED_Bloque( 6946 ).bloqfuda,
		'<CARTA>',
		'</CARTA>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_109.tbrcED_Bloque( 6947 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4040' ) ) then
		CONFEXME_109.tbrcED_Bloque( 6947 ).bloqfuda := CONFEXME_109.tbrcED_FuenDato( '4040' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [EXTRA_BARCODE_]', 5 );
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
		CONFEXME_109.tbrcED_Bloque( 6947 ).bloqcodi,
		'EXTRA_BARCODE_',
		CONFEXME_109.tbrcED_Bloque( 6947 ).bloqtibl,
		CONFEXME_109.tbrcED_Bloque( 6947 ).bloqfuda,
		'<EXTRA_BARCODE_>',
		'</EXTRA_BARCODE_>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_109.tbrcED_Bloque( 6948 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4041' ) ) then
		CONFEXME_109.tbrcED_Bloque( 6948 ).bloqfuda := CONFEXME_109.tbrcED_FuenDato( '4041' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [DETALLE]', 5 );
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
		CONFEXME_109.tbrcED_Bloque( 6948 ).bloqcodi,
		'DETALLE',
		CONFEXME_109.tbrcED_Bloque( 6948 ).bloqtibl,
		CONFEXME_109.tbrcED_Bloque( 6948 ).bloqfuda,
		'<DETALLE>',
		'</DETALLE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_109.tbrcED_Bloque( 6949 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_109.tbrcED_FuenDato.exists( '4042' ) ) then
		CONFEXME_109.tbrcED_Bloque( 6949 ).bloqfuda := CONFEXME_109.tbrcED_FuenDato( '4042' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [SOLICITANTE]', 5 );
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
		CONFEXME_109.tbrcED_Bloque( 6949 ).bloqcodi,
		'SOLICITANTE',
		CONFEXME_109.tbrcED_Bloque( 6949 ).bloqtibl,
		CONFEXME_109.tbrcED_Bloque( 6949 ).bloqfuda,
		'<SOLICITANTE>',
		'</SOLICITANTE>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrfrfo := CONFEXME_109.tbrcED_FranForm( '4727' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_109.tbrcED_Bloque.exists( 6944 ) ) then
		CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrbloq := CONFEXME_109.tbrcED_Bloque( 6944 ).bloqcodi;
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
		CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi,
		CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrbloq,
		CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrfrfo,
		1,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrfrfo := CONFEXME_109.tbrcED_FranForm( '4727' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_109.tbrcED_Bloque.exists( 6945 ) ) then
		CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrbloq := CONFEXME_109.tbrcED_Bloque( 6945 ).bloqcodi;
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
		CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrcodi,
		CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrbloq,
		CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrfrfo,
		3,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrfrfo := CONFEXME_109.tbrcED_FranForm( '4727' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_109.tbrcED_Bloque.exists( 6946 ) ) then
		CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrbloq := CONFEXME_109.tbrcED_Bloque( 6946 ).bloqcodi;
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
		CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi,
		CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrbloq,
		CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrfrfo,
		4,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrfrfo := CONFEXME_109.tbrcED_FranForm( '4727' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_109.tbrcED_Bloque.exists( 6947 ) ) then
		CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrbloq := CONFEXME_109.tbrcED_Bloque( 6947 ).bloqcodi;
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
		CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrcodi,
		CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrbloq,
		CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrfrfo,
		5,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrfrfo := CONFEXME_109.tbrcED_FranForm( '4728' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_109.tbrcED_Bloque.exists( 6948 ) ) then
		CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrbloq := CONFEXME_109.tbrcED_Bloque( 6948 ).bloqcodi;
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
		CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrcodi,
		CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrbloq,
		CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrfrfo,
		2,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrfrfo := CONFEXME_109.tbrcED_FranForm( '4728' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_109.tbrcED_Bloque.exists( 6949 ) ) then
		CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrbloq := CONFEXME_109.tbrcED_Bloque( 6949 ).bloqcodi;
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
		CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrcodi,
		CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrbloq,
		CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrfrfo,
		3,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37170' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37170' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31909' ) ) then
		CONFEXME_109.tbrcED_Item( '37170' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31909' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CEDULA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37170' ).itemcodi,
		'CEDULA',
		CONFEXME_109.tbrcED_Item( '37170' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37170' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37170' ).itemgren,
		NULL,
		1,
		'<CEDULA>',
		'</CEDULA>',
		CONFEXME_109.tbrcED_Item( '37170' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37171' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37171' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31910' ) ) then
		CONFEXME_109.tbrcED_Item( '37171' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31910' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOMBRE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37171' ).itemcodi,
		'NOMBRE',
		CONFEXME_109.tbrcED_Item( '37171' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37171' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37171' ).itemgren,
		NULL,
		1,
		'<NOMBRE_SOL>',
		'</NOMBRE_SOL>',
		CONFEXME_109.tbrcED_Item( '37171' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37172' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37172' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31911' ) ) then
		CONFEXME_109.tbrcED_Item( '37172' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31911' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ITEM]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37172' ).itemcodi,
		'ITEM',
		CONFEXME_109.tbrcED_Item( '37172' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37172' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37172' ).itemgren,
		NULL,
		2,
		'<ITEM>',
		'</ITEM>',
		CONFEXME_109.tbrcED_Item( '37172' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37173' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37173' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31912' ) ) then
		CONFEXME_109.tbrcED_Item( '37173' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31912' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TIPRD]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37173' ).itemcodi,
		'TIPRD',
		CONFEXME_109.tbrcED_Item( '37173' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37173' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37173' ).itemgren,
		NULL,
		1,
		'<TIPRD>',
		'</TIPRD>',
		CONFEXME_109.tbrcED_Item( '37173' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37174' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37174' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31913' ) ) then
		CONFEXME_109.tbrcED_Item( '37174' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31913' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CUOINI]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37174' ).itemcodi,
		'CUOINI',
		CONFEXME_109.tbrcED_Item( '37174' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37174' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37174' ).itemgren,
		NULL,
		1,
		'<CUOINI>',
		'</CUOINI>',
		CONFEXME_109.tbrcED_Item( '37174' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37175' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37175' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31914' ) ) then
		CONFEXME_109.tbrcED_Item( '37175' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31914' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [VRDIFE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37175' ).itemcodi,
		'VRDIFE',
		CONFEXME_109.tbrcED_Item( '37175' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37175' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37175' ).itemgren,
		NULL,
		1,
		'<VRDIFE>',
		'</VRDIFE>',
		CONFEXME_109.tbrcED_Item( '37175' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37176' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37176' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31915' ) ) then
		CONFEXME_109.tbrcED_Item( '37176' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31915' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [BARRAS]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37176' ).itemcodi,
		'BARRAS',
		CONFEXME_109.tbrcED_Item( '37176' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37176' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37176' ).itemgren,
		NULL,
		1,
		'<CODE>',
		'</CODE>',
		CONFEXME_109.tbrcED_Item( '37176' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37177' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37177' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31916' ) ) then
		CONFEXME_109.tbrcED_Item( '37177' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31916' ).atfdcodi;
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
		CONFEXME_109.tbrcED_Item( '37177' ).itemcodi,
		'IMAGE',
		CONFEXME_109.tbrcED_Item( '37177' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37177' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37177' ).itemgren,
		NULL,
		1,
		'<IMAGE>',
		'</IMAGE>',
		CONFEXME_109.tbrcED_Item( '37177' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37178' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37178' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31917' ) ) then
		CONFEXME_109.tbrcED_Item( '37178' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31917' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CAPITAL]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37178' ).itemcodi,
		'CAPITAL',
		CONFEXME_109.tbrcED_Item( '37178' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37178' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37178' ).itemgren,
		NULL,
		1,
		'<CAPITAL>',
		'</CAPITAL>',
		CONFEXME_109.tbrcED_Item( '37178' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37179' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37179' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31918' ) ) then
		CONFEXME_109.tbrcED_Item( '37179' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31918' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [INTERESES]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37179' ).itemcodi,
		'INTERESES',
		CONFEXME_109.tbrcED_Item( '37179' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37179' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37179' ).itemgren,
		NULL,
		1,
		'<INTERESES>',
		'</INTERESES>',
		CONFEXME_109.tbrcED_Item( '37179' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37180' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37180' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31919' ) ) then
		CONFEXME_109.tbrcED_Item( '37180' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31919' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NUMCUOTA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37180' ).itemcodi,
		'NUMCUOTA',
		CONFEXME_109.tbrcED_Item( '37180' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37180' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37180' ).itemgren,
		NULL,
		2,
		'<NUMCUOTA>',
		'</NUMCUOTA>',
		CONFEXME_109.tbrcED_Item( '37180' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37181' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37181' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31920' ) ) then
		CONFEXME_109.tbrcED_Item( '37181' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31920' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [VRCUOTA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37181' ).itemcodi,
		'VRCUOTA',
		CONFEXME_109.tbrcED_Item( '37181' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37181' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37181' ).itemgren,
		NULL,
		1,
		'<VRCUOTA>',
		'</VRCUOTA>',
		CONFEXME_109.tbrcED_Item( '37181' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37182' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37182' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31921' ) ) then
		CONFEXME_109.tbrcED_Item( '37182' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31921' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TXTBARRA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37182' ).itemcodi,
		'TXTBARRA',
		CONFEXME_109.tbrcED_Item( '37182' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37182' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37182' ).itemgren,
		NULL,
		1,
		'<TXTBARRA>',
		'</TXTBARRA>',
		CONFEXME_109.tbrcED_Item( '37182' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37183' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37183' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31922' ) ) then
		CONFEXME_109.tbrcED_Item( '37183' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31922' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TIPO_CUPON]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37183' ).itemcodi,
		'TIPO_CUPON',
		CONFEXME_109.tbrcED_Item( '37183' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37183' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37183' ).itemgren,
		NULL,
		1,
		'<TIPO_CUPON>',
		'</TIPO_CUPON>',
		CONFEXME_109.tbrcED_Item( '37183' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37184' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37184' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31923' ) ) then
		CONFEXME_109.tbrcED_Item( '37184' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31923' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [REFERENCIA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37184' ).itemcodi,
		'REFERENCIA',
		CONFEXME_109.tbrcED_Item( '37184' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37184' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37184' ).itemgren,
		NULL,
		1,
		'<REFERENCIA>',
		'</REFERENCIA>',
		CONFEXME_109.tbrcED_Item( '37184' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37185' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37185' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31924' ) ) then
		CONFEXME_109.tbrcED_Item( '37185' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31924' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [VALIDO_HASTA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37185' ).itemcodi,
		'VALIDO_HASTA',
		CONFEXME_109.tbrcED_Item( '37185' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37185' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37185' ).itemgren,
		NULL,
		1,
		'<VALIDO>',
		'</VALIDO>',
		CONFEXME_109.tbrcED_Item( '37185' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37186' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37186' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31925' ) ) then
		CONFEXME_109.tbrcED_Item( '37186' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31925' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TXT_MENSAJE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37186' ).itemcodi,
		'TXT_MENSAJE',
		CONFEXME_109.tbrcED_Item( '37186' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37186' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37186' ).itemgren,
		NULL,
		1,
		'<TXT_MENSAJE>',
		'</TXT_MENSAJE>',
		CONFEXME_109.tbrcED_Item( '37186' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37187' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37187' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31926' ) ) then
		CONFEXME_109.tbrcED_Item( '37187' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31926' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TOTINI]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37187' ).itemcodi,
		'TOTINI',
		CONFEXME_109.tbrcED_Item( '37187' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37187' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37187' ).itemgren,
		NULL,
		1,
		'<TOTINI>',
		'</TOTINI>',
		CONFEXME_109.tbrcED_Item( '37187' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37188' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37188' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31927' ) ) then
		CONFEXME_109.tbrcED_Item( '37188' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31927' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TOTDIFE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37188' ).itemcodi,
		'TOTDIFE',
		CONFEXME_109.tbrcED_Item( '37188' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37188' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37188' ).itemgren,
		NULL,
		1,
		'<TOTDIFE>',
		'</TOTDIFE>',
		CONFEXME_109.tbrcED_Item( '37188' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37189' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37189' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31928' ) ) then
		CONFEXME_109.tbrcED_Item( '37189' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31928' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TOTPAG]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37189' ).itemcodi,
		'TOTPAG',
		CONFEXME_109.tbrcED_Item( '37189' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37189' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37189' ).itemgren,
		NULL,
		1,
		'<TOTPAG>',
		'</TOTPAG>',
		CONFEXME_109.tbrcED_Item( '37189' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37190' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37190' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31929' ) ) then
		CONFEXME_109.tbrcED_Item( '37190' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31929' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [LETRAS]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37190' ).itemcodi,
		'LETRAS',
		CONFEXME_109.tbrcED_Item( '37190' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37190' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37190' ).itemgren,
		NULL,
		1,
		'<LETRAS>',
		'</LETRAS>',
		CONFEXME_109.tbrcED_Item( '37190' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37191' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37191' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31930' ) ) then
		CONFEXME_109.tbrcED_Item( '37191' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31930' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FINANCIACION]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37191' ).itemcodi,
		'FINANCIACION',
		CONFEXME_109.tbrcED_Item( '37191' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37191' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37191' ).itemgren,
		NULL,
		1,
		'<FINANCIACION>',
		'</FINANCIACION>',
		CONFEXME_109.tbrcED_Item( '37191' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37192' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37192' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31931' ) ) then
		CONFEXME_109.tbrcED_Item( '37192' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31931' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [LOGO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37192' ).itemcodi,
		'LOGO',
		CONFEXME_109.tbrcED_Item( '37192' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37192' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37192' ).itemgren,
		NULL,
		1,
		'<LOGO>',
		'</LOGO>',
		CONFEXME_109.tbrcED_Item( '37192' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37193' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37193' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31932' ) ) then
		CONFEXME_109.tbrcED_Item( '37193' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31932' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [PAGA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37193' ).itemcodi,
		'PAGA',
		CONFEXME_109.tbrcED_Item( '37193' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37193' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37193' ).itemgren,
		NULL,
		2,
		'<PAGA>',
		'</PAGA>',
		CONFEXME_109.tbrcED_Item( '37193' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37194' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37194' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31933' ) ) then
		CONFEXME_109.tbrcED_Item( '37194' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31933' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NIT]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37194' ).itemcodi,
		'NIT',
		CONFEXME_109.tbrcED_Item( '37194' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37194' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37194' ).itemgren,
		NULL,
		1,
		'<NIT>',
		'</NIT>',
		CONFEXME_109.tbrcED_Item( '37194' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37195' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37195' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31934' ) ) then
		CONFEXME_109.tbrcED_Item( '37195' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31934' ).atfdcodi;
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
		CONFEXME_109.tbrcED_Item( '37195' ).itemcodi,
		'FECHA',
		CONFEXME_109.tbrcED_Item( '37195' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37195' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37195' ).itemgren,
		NULL,
		1,
		'<FECHA>',
		'</FECHA>',
		CONFEXME_109.tbrcED_Item( '37195' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37196' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37196' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31935' ) ) then
		CONFEXME_109.tbrcED_Item( '37196' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31935' ).atfdcodi;
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
		CONFEXME_109.tbrcED_Item( '37196' ).itemcodi,
		'CONTRATO',
		CONFEXME_109.tbrcED_Item( '37196' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37196' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37196' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_109.tbrcED_Item( '37196' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37197' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37197' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31936' ) ) then
		CONFEXME_109.tbrcED_Item( '37197' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31936' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOMBRE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37197' ).itemcodi,
		'NOMBRE',
		CONFEXME_109.tbrcED_Item( '37197' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37197' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37197' ).itemgren,
		NULL,
		1,
		'<NOMBRE>',
		'</NOMBRE>',
		CONFEXME_109.tbrcED_Item( '37197' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37198' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37198' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31937' ) ) then
		CONFEXME_109.tbrcED_Item( '37198' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31937' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [DIRE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37198' ).itemcodi,
		'DIRE',
		CONFEXME_109.tbrcED_Item( '37198' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37198' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37198' ).itemgren,
		NULL,
		1,
		'<DIRE>',
		'</DIRE>',
		CONFEXME_109.tbrcED_Item( '37198' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37199' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37199' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31938' ) ) then
		CONFEXME_109.tbrcED_Item( '37199' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31938' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TIPO_ID]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37199' ).itemcodi,
		'TIPO_ID',
		CONFEXME_109.tbrcED_Item( '37199' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37199' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37199' ).itemgren,
		NULL,
		2,
		'<TIPO_ID>',
		'</TIPO_ID>',
		CONFEXME_109.tbrcED_Item( '37199' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37200' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37200' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31939' ) ) then
		CONFEXME_109.tbrcED_Item( '37200' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31939' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Identificación]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37200' ).itemcodi,
		'Identificación',
		CONFEXME_109.tbrcED_Item( '37200' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37200' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37200' ).itemgren,
		NULL,
		1,
		'<IDENTIFICATION>',
		'</IDENTIFICATION>',
		CONFEXME_109.tbrcED_Item( '37200' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_109.tbrcED_Item( '37201' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_109.tbrcED_Item( '37201' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_109.tbrcED_AtriFuda.exists( '31940' ) ) then
		CONFEXME_109.tbrcED_Item( '37201' ).itematfd := CONFEXME_109.tbrcED_AtriFuda( '31940' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [LOGIN_USUARIO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_109.tbrcED_Item( '37201' ).itemcodi,
		'LOGIN_USUARIO',
		CONFEXME_109.tbrcED_Item( '37201' ).itemceid,
		NULL,
		CONFEXME_109.tbrcED_Item( '37201' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_109.tbrcED_Item( '37201' ).itemgren,
		NULL,
		1,
		'<LOGIN_USUARIO>',
		'</LOGIN_USUARIO>',
		CONFEXME_109.tbrcED_Item( '37201' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37145' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37145' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37170' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37145' ).itblitem := CONFEXME_109.tbrcED_Item( '37170' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37145' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37145' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37145' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37146' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37146' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7113' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37171' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37146' ).itblitem := CONFEXME_109.tbrcED_Item( '37171' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37146' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37146' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37146' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37147' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37147' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37172' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37147' ).itblitem := CONFEXME_109.tbrcED_Item( '37172' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37147' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37147' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37147' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37148' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37148' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37173' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37148' ).itblitem := CONFEXME_109.tbrcED_Item( '37173' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37148' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37148' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37148' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37149' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37149' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37174' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37149' ).itblitem := CONFEXME_109.tbrcED_Item( '37174' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37149' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37149' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37149' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37150' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37150' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7112' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37175' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37150' ).itblitem := CONFEXME_109.tbrcED_Item( '37175' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37150' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37150' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37150' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37151' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37151' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37176' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37151' ).itblitem := CONFEXME_109.tbrcED_Item( '37176' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37151' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37151' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37151' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37152' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37152' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7111' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37177' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37152' ).itblitem := CONFEXME_109.tbrcED_Item( '37177' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37152' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37152' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37152' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37153' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37153' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37178' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37153' ).itblitem := CONFEXME_109.tbrcED_Item( '37178' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37153' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37153' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37153' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37154' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37154' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37179' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37154' ).itblitem := CONFEXME_109.tbrcED_Item( '37179' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37154' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37154' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37154' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37155' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37155' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37180' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37155' ).itblitem := CONFEXME_109.tbrcED_Item( '37180' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37155' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37155' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37155' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37156' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37156' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37181' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37156' ).itblitem := CONFEXME_109.tbrcED_Item( '37181' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37156' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37156' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37156' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37157' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37157' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37182' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37157' ).itblitem := CONFEXME_109.tbrcED_Item( '37182' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37157' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37157' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37157' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37158' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37158' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37183' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37158' ).itblitem := CONFEXME_109.tbrcED_Item( '37183' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37158' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37158' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37158' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37159' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37159' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37184' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37159' ).itblitem := CONFEXME_109.tbrcED_Item( '37184' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37159' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37159' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37159' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37160' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37160' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37185' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37160' ).itblitem := CONFEXME_109.tbrcED_Item( '37185' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37160' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37160' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37160' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37161' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37161' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7110' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37186' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37161' ).itblitem := CONFEXME_109.tbrcED_Item( '37186' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37161' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37161' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37161' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37162' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37162' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37187' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37162' ).itblitem := CONFEXME_109.tbrcED_Item( '37187' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37162' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37162' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37162' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37163' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37163' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37188' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37163' ).itblitem := CONFEXME_109.tbrcED_Item( '37188' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37163' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37163' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37163' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37164' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37164' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37189' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37164' ).itblitem := CONFEXME_109.tbrcED_Item( '37189' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37164' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37164' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37164' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37165' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37165' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37190' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37165' ).itblitem := CONFEXME_109.tbrcED_Item( '37190' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37165' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37165' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37165' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37166' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37166' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7109' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37191' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37166' ).itblitem := CONFEXME_109.tbrcED_Item( '37191' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37166' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37166' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37166' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37167' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37167' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37192' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37167' ).itblitem := CONFEXME_109.tbrcED_Item( '37192' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37167' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37167' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37167' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37168' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37168' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37193' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37168' ).itblitem := CONFEXME_109.tbrcED_Item( '37193' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37168' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37168' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37168' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37169' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37169' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37194' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37169' ).itblitem := CONFEXME_109.tbrcED_Item( '37194' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37169' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37169' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37169' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37170' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37170' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37195' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37170' ).itblitem := CONFEXME_109.tbrcED_Item( '37195' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37170' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37170' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37170' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37171' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37171' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37196' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37171' ).itblitem := CONFEXME_109.tbrcED_Item( '37196' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37171' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37171' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37171' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37172' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37172' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37197' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37172' ).itblitem := CONFEXME_109.tbrcED_Item( '37197' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37172' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37172' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37172' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37173' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37173' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37198' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37173' ).itblitem := CONFEXME_109.tbrcED_Item( '37198' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37173' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37173' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37173' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37174' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37174' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37199' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37174' ).itblitem := CONFEXME_109.tbrcED_Item( '37199' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37174' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37174' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37174' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37175' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37175' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37200' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37175' ).itblitem := CONFEXME_109.tbrcED_Item( '37200' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37175' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37175' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37175' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_109.tbrcED_ItemBloq( '37176' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_109.tbrcED_ItemBloq( '37176' ).itblblfr := CONFEXME_109.tbrcED_BloqFran( '7108' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_109.tbrcED_Item.exists( '37201' ) ) then
		CONFEXME_109.tbrcED_ItemBloq( '37176' ).itblitem := CONFEXME_109.tbrcED_Item( '37201' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_109.tbrcED_ItemBloq( '37176' ).itblcodi,
		CONFEXME_109.tbrcED_ItemBloq( '37176' ).itblitem,
		CONFEXME_109.tbrcED_ItemBloq( '37176' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
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
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E30306464353461392D353637642D346562622D396164382D6535363364336436363337363C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E673E4461746120536F757263653D736D6172747061733B5065727369737420536563757269747920496E666F3D547275653B557365722049443D656C69616E612E76697665726F733B50617373776F72643D6E6F6F6C7669646172323B556E69636F64653D547275653C2F436F6E6E656374537472696E673E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E66616C73653C2F72643A536E6170546F477269643E0D0A20203C72643A5265706F727449443E37393566373937652D653561622D343233332D626336352D6630326336383865356138323C2F72643A5265706F727449443E0D0A20203C456D626564646564496D616765733E0D0A202020203C456D626564646564496D616765204E616D653D22656669676173223E0D0A2020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D'
		||	'0A2020202020203C496D616765446174613E2F396A2F34414151536B5A4A5267414241514541534142494141442F327742444141454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151482F327742444151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151482F7767415243414273414E41444152454141684542417845422F385141486741424141494341674D424141414141414141414141414141674A42676342425149444367542F784141644151454141674D4141774541414141414141414141414141426763424251674442416B432F396F4144414D4241414951417841414141472F7741596669386E692F622B504B41414141414141414141414E62376253524E6E56655436712B33674141414141414141414147464C6E52504C2B4562485633733879645A34314776506B306E3849414141414141414141386677314249493538364858504576702F5834746C2B657658322F6562726A6C703246486D5141414141414141415952303572334E666E66664C56664E343058745451655466634538736F506C54337A5A4632722B66507941414F4D59355A4449414141414D49452F507956775A2B752F7A73393069334F776450724D4D392F513568773930584E3269756D4A64396B787A46506539474E4D7768413348483548484B58516A447666313334764E36396C4E50336B41414141425746786C364D66667174776C634452486247536570744B6E627434357853684A6C74483547397A575A66564F42615474534430686449386E32475656636D61617A62564C33727A76627A5158532B6D4A464762494B697561493839726E4D646474647978365478636D316637563063676B6E44357643717861777A7A576261584D4473526E4E53584E45427A2F764F6C4C4C71693670345969394D616D722B724F42624C2B542F4147335956394B345272322F34425131302F794276654C7A4B5A4666575A5762636C4558666332395655736446637737736A6B6D6C46437039586262644C584E63376453526D6D6342726D74326A706651437A634C324F716D72584E703247315263584F63314F38373137496A7371447A6172792B74576272512B764F74724D35533057636350644857632F566D426149736D453037332F414D3058746379396239623566572B662F716A6A76364D4F536530766E4F363234757A7A563753302B6B656736652B67655A'
		||	'354B5179774D383175776944507132732B700A652F592B5375465168736D702F70623435376E66724E664847487364543946655962484B343656723174616E392F31354959552F4A79365A5264412B4759486145633039763437564465584F3347637A467232796F307A47465739304A305A5548666E4F637A4B377379486C67317242537A616974746F62704F4A6B38726274764235393152755778366C6B4B6B5045356C5A7654563663357A71716F746858647A50705A65646D5233576C30526A6F506D6E637579646A745A696471526E332B7868677948474D63736778587461314F77697365725A46784B5A5774306630487778794765474F575751474B784C7A34425866755A7059506F3939756364767476457A6B414141414D596A374B496C6832773130735950507441536D4A6243314F333662325058303749492F4C71437A3841414141414141414D4E56627651396A34764A33337165353076732B7237767A2B2F444C32595A787264707A6E494141414141414141414141412F3851414C42414141674943416741444341454641414141414141414251594442414948414145494530415145525557467A41324E784955474341304E662F61414167424151414242514C2F41416A735179352B6F6257537170722B68574777646F656F33773566477A2B6C6D6D4E62636559464B38784C306E763636342B4D3861677235353579353856396F484C7972724F54487A76534F6832595154333034516D723341415871787A484C4C444A4D50346A694858665758586F337931314F776B716455746B73616E767331737775465632586769543353497A526C484A77325A6F4C77763636363535396464633856486865644D584465774A62494150454238624B447645544351496662634C48655A4F474753784D73676F46304F514830796C5273584A566B754C2F77427272764C4873526337494339756672745241644E444A2F625844796B4F443648464366682F5A4E557A3034783277316A516B785A6B6167536C526938524B626E504A766A5873655A3937414C59475478474B6D4F613775684A59724A4D6F50445572766947544B38793175704F5A622F735A7050357961714659336D4C3262584634334638563137375845374850466332352B757863354F73512B594E7463434C566834317376556F535A344C724A655349553338743351666E4E5057764E4A4153713232433634566B4D4A7735305162597277386A597A63517145707477755676722B744D64593564434E58704634313747364879376D6D7363664A34757350527938383964647151694C33527878357A5344366D4E436A747A396436757331366A2F3831712F436855575458303738744C6638704E2F4C64'
		||	'703073364C2F723759796E4B6E4F6C2B71550A6174754862306C485532706C357442506F736146634961534F7A71426677356E4B32437962494C787A3262414765555A31575778474865615576535473577A72766B4C7355654D4D614141796C6E342F424C72477066514A2F3539416E376D73746373616F465874487641302F66697A735556335237774D50624E317546643534504471772B6159696F56796278716934334C596A54657A735A7958682B623462726C70316C4F6976706674372B6D31396F71794D4A2B787358766A31472B4F7A366D574E67343578714937425A3265796D4D32497576496C6D7A6C4848684668396A646943794E397162585732375561466F636A45522B79524343793358794375652B7575673673566568527166644747436B3774737836734C45665866586654305A4B6A354C655A6D7374706C2B556F44546D526C5048765234706F507275645541577555784E4F68594D4C51733559747231433533535768412F75466446567833712F77442F7841424F45514143416745434241514242774D51426773414141414241674D45425245534141595449516355496A46424542556A4D6B4A5263544D32514167584D464A545657466964485742677053687364516B63704753744E4D5749445645566D57546C62505231662F6141416742417745425077482F414B695452794E4B694D47614278484B4239687A476B67552F77414F795257302F6A44394A35687A64666C37455863745A39533159695934396444504F33706868422B426B6B4B7272384271655043504E7A5A696C7A413175567072375A6A3577734F337474794543704771647441716D6C4B7178686949304349716F675166705069377A4F7555797365457153423665495A2F4D46484A53584974364A51772B7272545547454546696B6B6C6843564F356550437A6D464D4A7A477465773232706C31576B3748325366654456646A723258655447657A666C42395664782B51774F73496E6362566474736576752F7671772F6972392F785059664854394635727A73664C6D4376355274444C464673716F5470314C55333063432F5663364232445036573052574C656B45695352355A486C6C64704A4A475A354A485A6E64335936737A75784C4D7A456B6C6D4A4A50636E5867652F62332B4848672F7A68563571682B614D745954353778734D5A564353666E5773753464634D773274597242555737456A507157575830617977773530614C56302B7176563976627630394E5039302F6F754D714A5A677437394E5743787874324F317537612F3733543139765471506A727834335A5A7A6B36484C775967593558745730424252724D3443513636453674444372374F796B43772F75'
		||	'4748794459717357305A6D444945312B70750A5851752B6E6457414F7353396D31306C4F6968424C5375577364627258364D386C5735546D537857735173556B686C512B6C6C492F7056314F7153497A527572497A4B655575593035393551715A5A566A6A764C7568765149645669794659615449767579527A6F797A516F78334C484D674A49416339783250754F782F48394578686A72593572457843524B4A5A35586232574B4D45757A652F5A56526A3766446A4E35796650356A4A5A717836327964796133736B5561704535506C3464564A5A656842306F2F6F354276365337697936673871636D35506D32573738334C464844535248615733493677744A4957325675704645584D7242642F6F514459473379514578732B65355A7A584C5536775A616E4A427631364E6748713137473354643072413156325858317178456731425A6447425048366E624D53515A7250594E32486C3868516779454B6C6A36626443517853374639745A36746F47527663696E454F7741347931414547314544754865636475342F6450683766613048636572746F64654D6C6B616D4A7054354338356A71316C337A4F715049565855445859675A6A70723330423763667271386B6676724A2F594C332B58342F585635492F6657542B77587638414C3859486D7243637A65612B5A725457664A64447A47364365445A356A72644C5472527075336443543675753351612B3431356B3857735067376B74436C546C79396D764B59724A53646174614A304F6B694A4F5962426D6B6A505A67735854423950563342674D5034774C6C38684852586C3877645347354D5A546C424A7035536E50623268426A6C3364546F624E6436374E323752394E70782F6A516C362F547066394844463575314457366F7933553666576C574C66732B624533616274644E36362F655066396B385338694D4E34613569514D51317568466A34794E4F7A5A575249574834464A5A452F6834727754577034613164444C50596C6A6767695854644A4E4D346A6A52646442713773464770413150484B764C31666C6E43316358426F58516457334D502B38584A4176586D4F7666543072484839305349756E626A4A59326C6C71553144495634374E5764537278755062743264473934354539306B55686B50634563633563727A6370357158484D7A7A565A46387851734F75686D71757A42512B674364614A6C4D63327A5145674F4651534242344875796549574E436E51505479534D50765531484F682F704150346A676748554851673974434F326E33635749756A504C463845646750773137663363654948356E357A2B52742F694F4F574D4B4F597335527778736D6F4C72544C356752646670394F764C4D'
		||	'443075704676314D653354714C37363638660A72474C2F77434A322F38415A682F2B707853782B4F384A4B47536C755A6161394C6E45564B5A54484E414937475068744E477262624E72386F3977656F68516F51396D3738593030546B3652796D2F35754E754533656E727638414B395665734632614D506F3952365055507364394F4D412F68766D7072543454474A464E6A716B396D65614B704C556461386B4C315A514731426B4C7853754E6E66384162646D436E6A4750345253354C4877554B74337A7A337173644D6E3577482B6C39654D51626E6558516A71376478636C534E642B6F4A317A576578584C39587A655774783159695373616E31537A756F334D6B45532B755667766337516442373664745976476A6C6435565236655968526D5665733846566C51456B4D3869783233666176592F5272497831374C3234627859354D5669766E624C667868536E30503841745545663067456645446A4C3830596E423471746D4D684C4C4855746D46612B3246354A4865784131694A43714274684D614D5357495545616274534E5738617557775532342F4D4D4439636D4B6D70556476716A7A6A427A37366A5652714F7A4548586A432B4A334B6D616E6A71705A6D6F575A6E45635557526945416B5A746F56524D6A7931777A4F7752454D6F5A32374B44786576303862576C7558374D4E57724470314A706E574F4E647A425647356A395A6D4956563932596744697A347938717779744844426C6261417270504658686A69645439596F4A37455532356632736B4D65702B304233474338542B576337626A6F776D37547454794C46586975774B76585A76327277533249312B373652304A4A374435663151453751386B5961754F3657733754686B39782B51783936306848336753514474392F384130506739683076387976646B5147484431444F67303949737A486F562F774B70316E582B475035664748454A6535616A794B6A366644326C6B553764573874624B775745312B797059515373542B344166486A774670745A3539536364316F596A4957472B3736546F31464A3766427247673767616E346E62386D5230383550703847302F704141504869422B5A2B632F6B6266346A6A47545A474339424C696D737266557435633141357361736A4B776A43417364597977594166564A2B48487A76346C66756E4D762F6F58502B5878693846507A5679524E4C7A5732554E37477A35573158617758687344536F68514D4A6F324A694854556762514E646669653244705135444E346E487A3775686479644B704C734F6A394B657A48452B31766732316A6F644F4D5A7950687556594D7661786A577439724757594A52504B73693751686B556A304B5151563039'
		||	'394E474F6F31303435562F4F726C372B66630A5A2F78735048696E6D4A636E7A586272623961324C4355344642394F344B4873506F56476A47566968377344307777506651636D65465748755961746B3836624E697A6B496C6E6A72787950576A717776336A4461615379546B65707978564642434C4671706B666D50487759725035504831642F6C366C32574B4C714D476349722B6B4667463130486258545854333150666A4C387430755A2B5673465479463571464B72486A723169564F6B724D6B654E6548594A706A30712F71734B356C654F5A64454B645031683074342F77596F72305A6243544E3344505774354330345A42334F74646E433931374165686A36644471516374466A712B5374523469334C647879533630374D73545153764556566748526744766A4A4D5450735153464F6F73614B7751654A575379467644636C4C504937517A346E7A636839573261356F6B4C534F5353486B534C54516E566B36386831306D4F7649616367794A59546D73794C6561636556615A356B6F6976302B2F716849306C36686666312F547436585339572F6A48386863715763726A6337796E6C59646D50747854324B73646A7A734C6F726B4861322F7231334A5754547164534E324731524746312B587839724E59354977567056552B557A56575352744275534F664733594E6F62376D6C654C6437626971366A56653367616943767A4A4944394930324D52312B35455338597A2F41466D6B6B483958354D506C2F6E537A6E5968734B59764C4848523750637248547153534D2B7678387A4A4F6E596B61526A3234352F41504A764D4F763733756662587548516A2B2F54763850666A395474675872347A4F38777A4B523835324B2B4F70456A5453746A784C4A5A6B6A6276714A724E6859333976565358743664537A42564C45364B6F4C4D6675414866587365326E632F4854696151797979536E336B646D2F326E586A78412F4D2F4F66794E7638527834637A52562B63384C4C504C4844456B6C6E644C4B36787872725373714E7A75516F314A414770376B676366504F492F6658472F3236722F414D336A495861647645356A796C75745A36654E74395479383855327A66576E32622B6D7A626432787475756D3761326E73654F56507A7135652F6E7A4766386244786B762B7A722F77444972582F77507879722B64584C33382B347A2F6A6F655045536F31506E484E4B5177457468624D624D50727250476B6D346468716F63736D756E757047703031343551357A35666E35627835735A536E556E70556F6F726B45387978504359464B627472486355496A4C4B772B734154384F4F61626C652F7A4A6C376C535153313537387A78534455423033364268723844'
		||	'707144385233343854387A624D484C6D46530A5234365565446F577059316368624530734B42544B6F3033434A5547774E714157636744586A7736384F384A6E38534D7A6C5A5A724A61314C43744F43626F787872446F4E4A326A2B6D4D6A3768494172783759796839572F556336592F4834726D624B342F46674C527179787877714A6D6E32487938526D5179753773575763794B775A695559464470743043552B5673377933797A79396E703172334A6350426278387063515370752B6862793169525443306A4D6F3331323364514B684B485254786B50424C4A51713734374D5662653153566A73775054646A715054714A4C45594158556C326365333166563277575876594C4B314D68516B644A6F4A6B3349704957784557485672536A51376F356C477867564A485A6C306456492B544E344B506E446C44493443526C6A6B6D685A4B387A6173734E754569656E4B2F774446456F554E743150543345642B5043753359355A357179664C575A694E4B336543565A5970665473794E417974464871667243564A707843513232586447554C62303134384D72547A5A766E354A47372F4144307334585437556C6E4A72493334656D494166445474723850455557377547726376593165706C4F5A636858786C4F503749414A73575A70744E5374614747496D61516655334C3853416558634A553561776D4E77644C38686A717156772B30495A7046477330374B4364476E6B4C536B616E5464743137635A693641766C597A715737796B664252396A2B74376E2B4438666B3572786C6E4D6376355047302B6E356D33584D555856665A48754A48316E3062516666325034486A395A336D2F2F414D712F74722F35666A395A376E483738582F626E2F792F4849664A47623564782F4E4662496D6F5A6376557277314F6859615664386347526A62716B78707347363146706F473762767534776668567A566A73336963685038326D436C6B36567562703347615470515759355A4E696D4141747355375275477037616A69354730395331436D6D2B617650456D76596235496D566454384271652F4744384B756163666E4D546B5A2F6D336F55386E53747A434F347A53644B437A484C4A735577414D32785474476F31506255636339636A347A6D7436354632766A73326B5A574352676A4E6267423752537862306D6445636E5A4B6D2F70626D394436364350775579676B627A57626F563671686D656459705A43714C39767075594630433673643071414161466837385A4F4B6E466B3773474F6470714D56755747704D7A4352703449354448464F574349704D36714A644169676239753374787A667942507A5068734A4E556B53766C38646A71316378542B6D4B784830'
		||	'597430556A67457879777547324E6F564F720A4B333253754C384D7565306C6B676A6C474B676D4B72596C572B36527978677376654F75643075304F7843735071736676493476384167337A456C755263645053733142734555397178304A7054303036724E436B636F6A4856333746366A6B52376478336138637A2B472B627A474E3564577259704A6178474B6A6F5456354A4A464453695465306B633671796C4E704F674B4B64564863687A7350496E695630506D3371326D6F4852444238374E35506166536459544C744B6866663650344541486A6B7A776D6C78742B4C4A38777A56355871794C4C566F316D61524F744777614F616559694D61526B417243714F484A3962674C7466354D6463386E4E7133654B54307550752B357839355876322B494A2B4F6E4850666874694F656F6F7273566B34764F316B5879655A71703143776A3955556475494F686E695268364857534F7A423336556E75686F57755A6349693065637363797446746A69356878752B37693777476F366C727051724E6A5A64414E7873517058637475366B544870446C584674513538356C6B726B54307333526A793947654539614F78313759362F546B52646B6A5232486B334C457A37566B695A7679696A6A443876434849535A2F4A6247764C58656E6A6F795179596D693544326D44665638336B47534A726B67394B513136315A5470484C4A4C657A43494448564F392F59792F59542F562F626E2B37386543535353547153645354376B2F7350696A79686D2B5A4A63645A78455563777031724563735A6D574F56326B634F716F473055676761617379674539794233346C354938537034764C5456636C4C58374C30704D7241384F696E52543032754562514F3447335544324776626A6C447769747733612B52356B6575496137704D6D4D694A6D4D377141794C616B47324E5930663870454F714A6475782F5178312F595962553966386C497944346A33552F6970376633636650463739305838656D75762F7742663363476551796D6664746D594D444967434F5178557343796745676C564A314A31494776734F486C6C6B2B7649372F367A452F346E396C6F354F354A7A4E6B7362666E4E58704C313854524664656C65786769675237336D39574D6B306431706F3549463666526A364A5A4744712F484F764E452B45534B766A704B693356676B796C6B575A5930306F553559456176436A65715733666B6D574376474150517338686447574D5341673645647765345077492B42483438637A354B2F566D7774484776496C6A49334C48586143717432644B464F704A4A596C6A674D6B514F6C6D536C457A733231424E3342596F4F4C44354B44437A53564638396C59364450416B'
		||	'364A58387A6245525A466B546473695A33370A464E2B3154324C6535343562745358635A48616C757933704A5863536D616D74423639694A756A5A716D7370597865587352796F5564355A45494B4E4B3558647879376D73786C636F583073506957624C6C336D787A317138634D4E356F634E4A5375794242644E3271727A547244316844745573305964465036474F5738582F7078644C4D7235434F614365576539636D6C5343772F556C72315A4A5A6D616E585A2F554961706969553930556354637634697A35337A464B4B7732516853765A6B6E48566C61434F4A6F59346C6B6B3350476B6175355549526F386A796658646D4E664831716B307469465857536176547250724C4979644B694A6C7268593259786F7969655465364B476C3950554C6245307957446F3553617259736D346B394A5A307279303868646F5349746E6F6D6464314F654575736E516931446B6A30446978694B6C6733475A726B623378574537313739797534387076364A67614B5A445662365268493166704E4B4E6F6B4C6256417259624831445438764538586B6C7543454C4E4D464C5832523763303637397469784C496D38324A6738776553566C594757546446687145464B686A346F355936754D6175394F4F4F784F70513176795164316B44544B505A6B6D4C724A397348394D2F2F3851415552454141674942416751444177514C4377674C4141414141514944424155524567414745794548496A45554D6B454946534E524542636B4D304243556D46786B644D674E545A55596E52316770537A7442596C4D44524455364778474656575A484B426B355855342F442F3267414941514942415438422F634E464A4773547570565A6C4C786B2F6A4972744757483964475858343666684F4377382B647974584751646A596B306B6654586F7772357070694F3275795055366474546F506A78346E346D4C4632384574534D52556869765959462F6C5570336154636465376C6263544F78486D646D6675574F6E345234593876664E324C664C324530745A554C306779364E485151367074507641576E2B6D627341794A41644E427166455843506D4F58336C67586661786274646955647938495569796F4871666F394A4E41652F542B7651636138562B61385864356B746372304A42647634796E375A6D4868625748474352306A7131706E41594E6473737A4F4B77496147434B5357596F5768535838455A31556F705A565A7951674A414C6B4B7A6B4B4E653543717A61643946556E3048484C4747665035716C6A76534A354F705A63612B577445433835313158755547784F2F764D4E4E543234564552566A525652455656524541434B71674B7171423243714141414F7741304862'
		||	'6A2F4150446A3557562F6D487733787958650A5336456E7A586D356246624935324C75764B31682B6B49716B6353616C4779426B6C39697653394F4B71384A724B737468344858354C566C58743838704D356B74324938445A335348644A4973636D59466C6D646A7559744A5A674C4536376D494C48585458384538622F454337795A7A4E346650524C764853735838766B7165353478647153434C484C584C4168645458664A694D794352493532676D614E756C7466774C624735726C762F4C4C4853725A715A355931783832306F34707861764D7249774478794E594B70504733645772414875472B786C386D5950756175644A5439386B482B7A58386C5035546439782F464862336A716D54786D507A574F76596A4C55344D686A4D6C576C703371566C424A425A725472746B696B512F416A7572445230634C4A47797571734C474D66354F6E6A665069376B6C6D586C6D386D7974636B42445363753557594770626D415A593745324C73516447303636376A5673535277724A4949416B6B63694A4A4736795275697647364D48523063616F364D756F5A57476855715347476848344A342B57707337346F7A59756B7374697855723472445636793673587532414A6B6A68553644664D39324A664C366E5145366767636A59636368637359486C664775425877654C70343436626D696E6D7277716C6D7A74625136326248566D4A506D485539645272786D65664B324872782B30774D4C566A56592B677976743030337A394F54626F714567414D37456B6A333947416F35616E6C6C6161724F4A5731316C552B575643336657524433477631393150665136672F592B57377976466335583552357669552B3134584C57634C614B6F756A34374D774378433830683832326E6678346A67516558646C4A322B5048674634725451326176496E4D453461704D715163743348374E576E47372F4E637A39775962436C52534A32644761506F6653653078694C6A48592B316C626B46436B697957624446496B5A316A42594B57304C75516F3744346E31342B31707A642F4559503766542F626366613035752F694D483976702F74754D3579336C7558665A526C59456839733670673254777A377568302B7072306E62627031553031396465336F654F582F44484B5A6572486575573078646564424A585531327332586A59626B6B4D48557270476A4B564B37706435486D32616264637234562F4E6C4B53347564362F546B72526D4D347A6F2F3678616872416878666C397A7262744E76634C70714E64654C6E684B395370617466507953657931703748542B625758663059336B3262766254743342644E647261612B682B5038416F2F447A47507A72387162577843485445'
		||	'633135584A54497A6136783871475347704C0A7235644373394F704F46414A556A6143644E33456B695252764C4977574F4E476B646A364B6941737A483877414A34792B526B79743661334A7146596849552F33634345394E422B73733331737A483438566255394F654F7A576B614B574D3671796E395959656A4B66526C4F6F4937486A435A5A4D7852537941456C55394F78454471456D41424F3358767359454D6D76774F335669704A2B566D6974344938784668715579504C7A6F6679572B656169366A2B717A443942504555736B456B63304D6A7779784F6B7355735474484A48496A426B6B6A645347523059426C64534755674548586A6B374E6E6D506C62415A31314B795A5047564C4D77305561547445425032587971444D726B4165673048773435452F685A687635796637742B4D2F6C54684D5264796767466B30306A666F47547064546650484552314E6B6D3354716276636258545474783975462F774473386E2F756A663841774F4C4E792F346E33714B31636242546A77784C57773937716C36397957414F563351312B3859727435563774754863635878613969746A486950323332615956424A7445596E365A4547376435516F6251364E3565326837486A4F4A3467346D43443533795856723543334457534A724D5668576E57526245577168506F776B6B4B74714E50545430314847526938554936462B57355A6F47716C4F32396F4B31496E326459484E674B71786136394C646F4637363662652B6E47487775547A746E325847566D73534B4E306A6535464375756D2B61566A736A556E734E547133346F5066522F43626D465969365738564C49415430566D73686D2B70566553716B6570372B38797150796A727776686C7A5979672B7A56454A2F46653545474866547542722F414D794F4D5879316C63786B37574A70704331716C316A5A337A4B6B614C424F746152677A61622F414B56314143676B6736366161364C34535A3071532B51784B4E2B4B752B323270372B38337367432F4475752F7744514E4F4D7634643879596D46374267687651524B586B6B6F534E4B5555616B735958534B63716F47724D49794150556A696E537435477A485470515357624D7049534B4A53374851616B39765256414A596E5141616E585163562F436A6D4B574D504E59786C52694439444A504E4A49726161674D613965574C763231496B4A48726F66546A4D6548664D474871793358396A74316F497A4A504A556D596D4A42385448504842496672386974322B7A386B3276466B6647337841793531456C58465A2B7A427638414F332B634F59716B45675A7433763841546C37763574664D507874773531757458785967566A76757A644D2F57596B48'
		||	'556C3966724F78542F77434C37504A4677770A5A5236702B39335969702B4136734F7278742B633664525150675A44783873504B7830504232656D2B76557A664D654578384A2F6C5150506C6E422B72574C47762B725455656834384759356F7644546C555448557653615350385836475365566F782B6652542F352B76623048496E384C4D4E2F4F542F647678656A7054565A6F736974647154717658466F71494E6F634D4F71584955414F4530314938326E7839666D766B50384133484C662F72302F327647537A4D504C584E3855584C53343055386A426A4B316859416B304865302B386F595A4E6F6C3063676E556E303764752B5773795573586B376B4F337130386664737862764D76557231704A5939342B49334B4E5238652F666A4938355A586D535847566367745552775A477659546F52474E742B7654372B6474526F782B48714F4F597633677A76394435542F4141552F48683169343864797A556C434154354C64646E596A5269475A6B68556E386C59744350545179487472787A5A346B35536C6C374750773631346F4B4D68686B6E6C6957784A596C5833794E78325278493271726F75397470637633434C6772733252772B4D76574E6E587456495A70656D4E7162324770327153534272333031502F4C6A486377572B5865614D2F596F556C763237632B5170517776315756576649704E76365549366B33336A614930644353323764356470723376466934335753734946395653657452727074506F4E4A67726670334863505855656F78736C36576C576B7964654F72664D66335642444B4A59316C56694359334259465841567775704B62396D356975343868554B4E584B63344E4247697977355432564F79367731435A5A466A5161447078764A72324767626F6F50396D4F4F635735305531323559574A716F6962326F5269453344507639414A2F5745707432394C7A622B70314F327A69397A707A4A5678325277334D2B4C6B3333716B73466579596659355663715065554A304C43445664544873644E64575A396450732F4A6373706A50486A7851784D7A6B53584B764D4D4D412B39695671584E466566663053784F687269523049333756632B625239547A2B57366D4D585479684C5A422F6C4D61346239515666312F5979324B2B62612B456C4F37646B38594C3737757744506174526F716A36756846432F384158312F4E7879377238393433542B4D722B725274662B48362B506C75383278334D3979687958576C312B5A6156334E35534E574A427435646F4B2B505356646F5550577030624573656A4D646D52625854634F4B6C5778657456714E534A7037567978445671777270756D73574A46696869546351753653526C5264534271'
		||	'6535413435647738584C2B43772B4568304D0A654B78315369474734683267695248634679583064777A6748763339654F5250345759622B636E2B37666A6E654B57666C584D525152535453764244736A6952704A4730743179647149437830414A374430425077342B5A637A2F414E5535502B7757763258464F6C63703554466531314C4E587158367654396F676C6733374C4557375A3146586474334C753031303344583148484D5837775A332B6838702F67702B4B502B76552F3531582F76553435692F65444F2F77424435542F425438636B57567338713461514D757364586F4F46507576424936454875652B3156592F6D6258516567357235527A6B664D4638317364617451584C6373396165434A704563547476304A55614B79733231677847683950586A6C3272505377654A715755366339656C42484C47644355634C33553664745236485434386367347573746A6D504C464665354C6E4D685753517143304D4555376C6C6A4A393371752F3068476D3556525432484850585057577757542B6173624442447472785474626E6A367A794762556A6F71326B51535061564A4B7962704E3375376444797264755A48415975396B4354637451744C4B656B49643330386F6A59527146414452644D727455426C3059613636385357655A634E6E75596339686F445054544C54314C3065777A785073306D4874454562435655565838733637656D5762527835754B4869356A5A6D524C2B4C7455795341306C655A4C63592B7469706A676B39514E46565A443330314F6E664D5979706C7362626F585556345A5958387A41486F7942573663385A4F33624A43326A4B77302B4B6B3753773448324F626333613848664879687A7858686B6D6F3354426B6256614C624837586A376352782B5971512B5942706449336E51794645613173336E5A75417A396E486331637459766D5841326F386A6A4A596C76553755506D536568635650705067564B46453671736F654A6C64585657526742783469316B6978484A4D714451664E5073782F524857787278362F456B3957516E74395A4A3738592F4C59336C324C4A6330357162326644387559327A6B373867304C6C455862484441435172325A70474351526C687666747142717735343574794850664E75653575796743584D35666B7474437246307251364C4455714935565336564B73634E635346564D6E54336C5157504879646644696578652F77417538765832557167654C4178796A7A57626A6553584942534F304E5A4E305544362F5354534D79396F6458343559795662455A33485A433376396E72544635656D753939757868325855612F72342B326C797438446B4F332F41485166746550747038722F414A'
		||	'57522F736E2F414E76484F6E4E324A7A75510A35647330545A36654D73537957657444734F313536636736593374764F3242396654346658786C2F45726C713769737054684E377257386664725137367743395378576C695463656F6446334D4E546F644272363663567046687331355831325254785350703637556B566A6F5069644232347933695479316478655570776D393172655075316F7431554265705972537852377A31447458637731506651642B2F484A764E2B5235626A734130703868686D6B4454424E3669704F772B2B525462486951756F38305437524C744242556A635A50467646374E4B754B794D3968744248413777784B7A48734636694764753538766C68636E34446A4879577061564F5737477356796176444C616851454C444E4B6F643451437A6E364A6A302B37456E59547278797A7A7A587747587A554E74486E785751796471306B734F6A535635544E4A70497161365352797837643667376756566C3138774F513851655444456B7A6A35796C693161434930466552474F6A655637414377366B416267337270395846507857774D6C654A37306475437932347977775264654B503652756D717973305A6B505332626D32714E356261414E4F4F58764544443475396E506149626E732B547973742B437847694D566A64466A4353516C677762793636717A65396F514E504F4F632B5165734C774655577835785038314C3758714F2F61626F373978506365663137363863312B4A6B56326C4E6A7346464D67745274465976574149324554677138634549337344497049615632556F765A455974755837486A4234627234686376496C5172466E735130746E45537674437A3952414C474F6D6476636974394F497249434F6E5968686474592B6F726546486A647A6A3448354B35674D6C6A5A636E792B3170686C7556636C493957616E4F33616166477A50484B4B6338714D4A486A6147576E6341526D56642F573477486954346363387048593556356872567255363735655773354A4469387A55665253305543547A6D444971724D554270547A747175696956644A447A686E36503276634A64796C6D4848664D466C364753653749745A4B69525643596E6D4D724B49306B72777837532F767372716E64534F50475878686E352B65727964796E37614F575972715354724847347363305A6A65497162745855475A71564D6B7269716265655778504C626C693670717058384E506B3935504A54775A666E694A735A69303254525962585449586A715473753754397756396F425A535461666430325341676E697657677177513171304D64657642477355454553716B55555344616949692B5656566577412B483772542F6A7870396A77'
		||	'343570772B4268794E664A7A53514E616E720A795273496E655062476A71323872717939322F4A4F6F3139665469506D376B4B462F6149726D4E696D393771525936524A3954362B644B697471652B766E372F58787A52346E314A4B6C696A67466D6561644869664953446F72416A65526A58513675306A4C71466B505445657539647A416166754E4F4E5033484D3349334B6E4E3671764D4746715835556A614B4F30553656324B4E394E79785849536C68423237615365512B5A4E7265626A2F6F396547505633484635416F64666F546C722F5448594473776C4576596A5837346535373967414D66794679666A63614D52573566787A59344F6B7673317545584536386179496B34467272425A6773307939575059326B6A6A58516E6A4859444234676B34764434334873515158703071396552676535445352527137443878596A2F53334D66546A35636F58365543326A4952466B72706E6672306368314A58576D616F326F73556C5655614B593954717431644858615534354F35616A7A4C537A3334625431476C584731665A6F35474276326F356D53655630476B64576D6B66566E646A377A774A6F775A39704242494F6F4937666F2F583852707879336A3656704D76627943777642517152644A62467071634C584C4E694E4959354A3056794E595673754643376E5A414F7937694B36342B624D524A615073654D6B757173786764357842564D6F446D4F526C4C53425537712B33556A567476773435687170547954316F716B644B4F4E454D5168747464697351544471313753324830366E5767654E77366F696B486349313132385A2F45596A4759304A3944486C465446644E597236324C453073744D53355A626C4E642F7369314A326A6A674D6E52615463774379614D562F417A7A426B76754A5661764848516C696D6869687031596F6E6E686A36615432556A69566255775162544C59366A7350654A3134697A6D5567396A364675534261457A54316B68306A6A576153555453537369625664336456336277664B694950496F586965395A745178515446436B4D3171776D6B61493355757447302B3531554D344A695461724D566A373741753436342F4D58635A465A6772657A4E44626142353472564F72636A6436776C3644464C555571686F2B744C6F5142372F454756745678554372566B576B62426753656C566E543770326458724C4C457773447944594A7849454F70514C71646247597632766250614A466C3974617130786147497342534472576968626272586769523967676832524646514653493032795A61394E63753370586A6B7335464A6F37636B6B4D4C37316E2B2B46565A4373544838566F77724A32326B66686E2F2F4541464D51'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'41414943415149444251494744416B4844510A4141414145434177515242524941457945474643497851534E52454255794D3246784669517751454A44556D4A79675A4756427955304E5852326F6253314E6D4F443039546A3843425456484E3167704F556F7348523165482F3267414941514541426A38432F7743525048473673396152597031422B626B614B4F5A56623665584B6A59397A443735314858626548576E43655244753239357450344B31594E3132383255717062423272756242786A6A7461326F54382F55323751445662622B586831536F6B6357316359574E583036644931424F794E465441434C6E37346A374F553564326E646E6D63574E6A355366563546437A4668386B6D6A486D736E6D59354A4C597A343843474730346A6F363947756C7A7578776B646870413947566A35414366324F342B516E506B4D2F424A706B4235303165486E5847552B43746B6859346D4F43476D636B6E6C354778464C4D63375662373048587A38767039656E7636646671343150576A6732496F7554516A4F5061583748737133516873716A747A5A426A484C6A624F505068354A48615353526D65535352697A794F354C4F377365724F3745737A48715353543846585472635A6A31654E4F5438624E4A6D53335243675157565447354C7048676C6C5A69434553796D5873597236796A484D736955705154314A5647746952732B66797059382B386E7239363643596374336470376C69484F315A6F333231676D665138733251435151724D7246546A484769364C70302F4D6F307176786E5A326E356432367532424A567A306B70316C63594F475272637973506B2F414C7474637744356D4A67434A6A2B57345034706652636530627166414D53426C4F47553542486F662B50326A6F656E4665374C30676C445662754D6E596A73755877504D5275715334366E5A6E414A786B4D70444B774244413542423667676A6F5166512F656C68632B4770444242394149546D766A2F786576306A4238756A50616A334D53646B67384D714C2B4341777A354448513558364F4A2B3432592B355577727A6D3247693346733871714A6F743236535861784A4555595641637447536834537671564E71344978424975477253684F6D495A56384232394D72305A526A4B34497A784C48364D6F6366704C30503756503841365278466F6C39387850684E506D506E464A312B316E3936536669542B4134326451343263573959314F5234714E4A413969534F4B536431566E56415246454764764577386835646550357A752F756A556638415563667A6E642F64476F2F366A69383267575A724130343131746336705056326D304A6A4474353649587A3365544F334F4D44506E7850'
		||	'70576D61644E326775564A5868747574744B0A4E474B614E74727770613546795361534E677979624B334C56687445686263466930352B795864656244656C45796139336E486371466D3851597A6F31623559726376647A5044753362577867304B48324A5378642B75314B664E2B4F30666C39366E6A67356D7A34725866733337746D3564324D62686E503354585A57382B2B3259505438435875792B373051662F766E7846586851795454794A444647504E354A574349677A367378414846625459734631484E74536A3866616B787A70503742476E2B62524236635455623043574B3079375852782B7830506D6B692B614F7547552B52346C6F4D7A53313248507054734D47577335594C757834656247564D636D33414A472F616F634B422B6733415A53565A5347566C4F47556A7143434F6F4950554833385562702B5659725279503544326D4D53644230486A427750546A744C2F41454E50377844787057674E614E49616E4E4A44336F5139344D4F79744E506E6B6D5748666E6C62666E567875336463595038416C6A4C2B346B2F2B323431563732745739536D37544152366530576C636A6B334E4E72577A477368573162384D6A585538624B416E4C50523834476E2F4844532F466E664B35314A6F747A546D707A564E6E5A74385A6B6550634D6A78354F3464654C50324F36463365336F2B6D323773737770324B627254654A71566A446D5938356E69744F6D313978363579434F4E4A6730366A72517679366C70385641754E534369343971464B68646D73456265655939786649786E646B5A34372F7274364F6E437A4649553679574C4D674754485772706D535A674F726252745145467975527749354E4E375177516C674F3876576F73716A726C326A69314235746F36594349376E38675936736774366C49462F446A3079636F33307154744A48366878702F614C55704C4B304E5637734B496972504C504B39756F393646444776534D6D434E79786B594B7047334F534F46456569396F5A457A34334D656D6F63644D46454F6F486366504963785978356E50534B6B4C4E6E53626337694F474856346B72704937454245466D4B5765714864694656476D566D626F75654A395231533344537056786D57784F34524679634B507A6E59345645584C4D335144686F36744858745151466674694774566769595A38525662647943666F4D6C51304B626A675A584F525830794C3479303639636C57437244714656414A70587A745154564A37554B452F357830382F687450313972715535362B666965655472394F5231346135497559394B724764656E5476457035554836774F61342F512B474F2B4237625337495A546A72794C57324B64506F4735595A44'
		||	'2F31574F4D2B364E762F41472B44544E2F720A45374C2B675A584B2F774448753437532F774244542B3851385670394761326D7078753364476F6952725963787572636859673068597873344F3048773776546A2B5639747638417932702F37507859733974354E6366556444743637657050626157745A4F3354346A47736F7377373372376F675641436A356658726B614670316E64336655645930756A593248612F4A75586F4B387577396472624A47326E7267344F4478726D6F614F2B6F4E4E61305337546C4675777379636F727A387142456844626F68317A354539504C6A736E2F5758732F2F4149725534314B757A6B3164454930756D6D374B4C735648744F6F39476C7345682F50496A54726744696C72506152723039725659525A677177546D704653727354796337427A4A5A3545784B356468476D3452694C4B6C32317A5361686B4E58543952733159444D7765586C78746864374255444E6A31326A397648593670712B7150704F6E366253305456625669506B4B576A6A304E36786A4E69796552564832317A44504A484B42733237504675587538742B533234425635616C335662636D34656262713373382B34526A5A3659505563586F7444747A587449457837685A73777442504A585A51774530544253486A4A4D544E74546D624F5945514F46483847715735705872324F7A766635435332323171494665435361556B6E6E545251374D4D3257547655707A3763385846376474595738303669693068736A545256355933466D71654957656476336D667763766B386E7863336A52753033595058346A4670576F775772744557666A4B4634306679526934743070547462614A2B62484A6A43694C4262346451547A354F7232787578676B63326463342F4F384A382F64352B66486142382B4D7936617244383156756C50326C332F5A3848616D75757A5A6F577648534939766D79786166526D6B646A362F624D3169502F525948764F75352F3645783873395249684839754F76703538535448385951692F6F706E4A48317363663933694F474A533873727248476738326B63685558395A494846536B7655566138554F66796969414D3358387073742B766A744C2F51302F764550485A6D7A626E68713134726B356C6E7353704444474451747143387368564542596863735231494872782F6C4A6F483734302F3841326A6A74443857366C5131446B365071484F376A6372322B567A4B566E5A7A4F524A4A73333748326273627472592B53654F7966395A64412F7741567163616C2F77426E335037764A7832532F724C32662F78577078326E696457416C766D3347572F44697478527A42683048544C737654386B6A4A382B4E49533772576E3664'
		||	'623076546F4B64327262734A444C4731524F0A554852484961574F52497736736762497A6E714F4F30576F305A656454756170626E727A4146524A457A2B4677474162446559794230343745646E6C6C655054612F5A48524C386B4B7468624E7578556A565A4A674D627537787767516873684765527831626F646631797A617337727339564E4F7154437448434B32304E336D564E30375379376C6456526F4E6B4A552B4D79417272326B36514D61645174725872727A32734664746141796F5A6D5A325A6C6E4D717675596C484251343234485976736A326E747054314F587335543148535A7559745778467A5161784E4B334D6A56336C6434635355333338304A4754453245496C6B3066587450314D4B705A4962646554544A3238734948457479766E7A7937795172307A675A774E4F3162544A6E697331374D58524749466946704645315359444F2B43776D59354549506D47486A56535067754C354A666A53314763644E354731763253786E363835347336585A4969477178527872753644766455794E416E2B6B57615A554834544D7550545048384B5545725A5032517264483655393758493573443043386D41447235594148683437696E386F31577A465769583879503238377436374652414352354D36652F42534E664A526A3679423150362B506A75306E73596372524444357962796563666D52444B6F6677704353506D2B764773364E70334B373765727248427A6E35555734545276346E7732336F70394F506B61502B387638416363664E364E2B386639787832306F367174495436375368676F39337463354E36564E5568626D7479313559333234757658707539334768616A5A545375373664724F6C5872484C3144632F4970336F4C45757865534E7A38754E7471354754675A48467976486A6D543162454B5A4F42766B6864467966515A50586A5164527372705064744F316A5372316A6C366875666B55373046695859764A47357558473231636A4A774D6A696F793670553066744F73444C56615178736452716F666D5A36764E6A6E6B5346324F79314348614465796C4A464951667868722B69314B61626D6D74524C61734D6B613957635179705454354F5739705A695559385463616C4270633732644E7232374D4E4B7A4B515873316F5A476A69736B716B612F6243714A6868464144675934374B32644F6B6972646F4E4730485439506D7232695934626B4B56596377744C676D4378576E456E4C5A6C324D736B69536263527372566F6A385351542B477A592B4E6D68685A506B2B306A704F306C6A6F54686468365A392F4538576C7A6164636F4A734665315A7369704E4E374A4F617A566C5759516A6E6377496E4E6338734A7559746E'
		||	'6A7370334B78706E666444374F31744874300A5A705851504C464C4C4B307346725930624A3758627464492F6B5A79322F7748532F34774F6E74374D302F73676234754B6E4136317539636A5A6A7A396C3544793472613132746E7175614D715430394A714D5A3061784577654B65355A49524E6B4C71724A586A53515374677953494535622F414F5468623151744A564A3643546350615632506F73753153472F426B5253664475344B5343536E65724F5046686B6C6A644F6F33446F3351344B734347386D5276664853375359725755436F6D7072347174724765746A616F4E535879797A446B4F546E64456642783233734E4E454E46313352783269703339366D744B72366B6E65647334796A744463745471366F325148687970356B5A34453051646F495233545459414D76746B6362354169355050747545796F79646951782B616E684C5773713157714D4D74547973542F524C2F774178476655664F7435596A2B56776B55534C4848476F524551425656563642564136414166636445756146556874707039533544504731694F4B62664E4E444A4879306B774847497A31334442783966486337476C36355972644635552B72777931634C35657A6B31426B326A303848314469727176624271736457704B6C6950523458377A4A626B54447872636B58454D566458775A49564D7A546265552B784364333345642F707854734274575847325A52376C6C544567483062767048586A504A732F56337558482F7A2F41472B76484A69307970734A33486D51724D78623166644B4762636655676A504761744F74584A383268676A6A592F5779714366316E3772712B6B6170616B6F4A5851324E4430706163586474573063525178767159314137355A4C554E2B53564A36794745514A794D7879422B5A78587161525A302B4C556B676B31753933326146636150516D6753537258696C5947612F71636B334A71524943334C6874533551704875424279434D676A79493943507234374F36646F306C714B33712B6F324F385052303650564C55656D55614D30746D534B704A4A4772597379555561526D437870497836747442735355503479313248536E657233714B4F7233752B494330596D67526848437A793444524239716E77372F586947395071646A5535705A5A556E4E72546F744C735537646475373364506B70785A354C56626355794D6A7649366E4B6D5751414E77306D624D2B675353396F544F316A5344547031613962555458374F7470757076792F6A4A395172724E4C625748765351694E4D76446B422F76505648614F374E4E7245453957315973366E7146697848557379744E4C557054545748665436706C5975494B5A686A567362564742787166'
		||	'65744F6873767139654F72656C735A6E6D650A744458617444436B7370643455696A64396E4C4B2B306B6B6C4A4D6A6C754C467175736F6C733174507153373535704535476D4A4D6C5152784F356A69594C596B356A787172546545796C3969347057726F75706130354C6364537852314B2F7073385564376B643651533062466479733364594E774A2F46727871544F2B6F517961734B613235616D7033716B6F46446D643337744A424F6A55794F59776B6171596D6C474F5957326A476D3979727658476C4A66577171574C47307471686A61395061586D59755770336A4568733265624F4A486C6458426C6B3361567056654757436A6F30745762543459624E69506C76554A4D4964306B5670307954765359757375547A413333352F2F4541435551415145414167494242414943417741414141414141414552414345785152417751464668635947787753435230662F6141416742415141425079482F41417339636B2F424B6664754276667541515146727830552B3841685032656D684E4F416C36576B39796733526B634868794E6F765A6E644D566B75424B4268767254344F4D746F496643474951744C327155424175465155436764674B446F76413574453775786E444C4D61444268593331476F396341727756584549336A76386433475A6C615A7143526F6942526B726C65775A4A716D785667565A3757595A554E4D5A744E6E454531747443674457494E424F7742654553563677394770733575775879596352726B502B3849365242535A663439626A4B3136425670484232514E48796D41496778476D7661414A556F74514E302F77426A524F474C6853624E504C6B6B33534B71754B30795A766B44304B4B51725248533068634334326F6762344D6D3638764371423947764F6A72507369644D68666E687061462F77416557455445496B7444796C6F664A67777572736856424961674E7852696D5250374F73625350746C75624F70306D7364436B634F49327A6A35484E2F6833563950726B326342323435617878787771576F4E64394B44627043753079693667476A6133614857795959646B494A706963694C5332415947533566544B78364B686A4769536659763249593738706A6358674D415241496B4D4E6561303243687046496347654B7A625778354C4A4E79786956654351794372346E49595563776D51732B4C4A324861514E34714A4D716361745975686343444244684F335864796F4D6B34624867426F6E496177557975414B6D7871426E4E4C4D7169455647474170417A776175303761306C7A746E744672714A71364D4457743052637850634B49494E596554656D636E794769427644372F6D694372744D41734B57594B56346663'
		||	'6C375A684351316B417A4771774945416B530A78302B655431573771717132486B31752F6B414E7A614437756C2F622B7366484E6332464D49384D6D655A473048764562334B794C44587874436F6255504245727743494B666F644F3744772B4B7A4C554A355A434369726F325447727A69516B674B42425377347732465475666E7A5A30385954786D777067516E4B6B696D6A4359497A536E78634B6D634B73354F4F39624E4E545A4148575062646F734F6A77614A6F473753316F2F467A517544524D2B63512B564632573761466E654B33722F5A574F334365594870527439432B68585135323550694B4879416D484358686E3939756B4E655A64686A6D65456432525553634A554C694C5855594B5438454435507062332B486845507339413471622B6A5949474144786B3036437164666B3442514662546F4D35444F396C4F397A525A386735693175716371636D4F7152485A736C4C713256384B7865617266497444424A6D776547364F5352414F4C2F4F596E30656435634758615A6551624E6D5551624171787368696D67436149414C676347535A3030694E73554D336A3342666A46714B504534466A736D3177555930736D526B5949745A5252716667455A346D69466E54426944426E455343515573374D6B76467668745633734236436C675542386D654A706E456A55644F4C7A2B526A4C68646D365938745345464B6A7773464439376534517848634B4B697132316A6D6A66747A71345948324136414A4651356558656F645A707835724E354478386F43447742657761346734355A62337276795A6D5337567366474570693654755771772F325A2F696A43352B3151624B466F366D6A6555706950374E5846526863543137722B6767795A4F466B47773956666F7741724170447158536273356142676A676D4A4D726F646D4D4163717467366A654562585734584F2F4B614B6773336A665751796B6844433745657036443636555144526C72574657444B627A6943754C684D3363663562514B426546586C49616C4C784133784F42624542445842544F6E514943527744696E335373344A524175464C6774454E416633334C47596E6D367757366F557653634E597639463368746B496B4E796B755948416C70784567414145443061566E453744567776612B6D4E7355364D42386352366F624A684846614D2B63774161656B614B456D684E387466714164427467572F506E3847634A72744B2B567041637473705249684935635158676A71446F4244305576704E61343957674E53447550456A6B735432774D75384239646C494D696D4751464255476B43496D6B775439616A412B7A2B31676D59474A506337637151434E6265754A4B35524D72454C41'
		||	'6E5A42514347737234783753364E37486A460A4B414E6374517336367A4B474655504541585057656C72536963616778392B344C776B4A42492F5267584178514246366446416F3458516C3263714F686A4A65596967456A32317032767748336E2F2F61414177444151414341414D41414141514143414141414141414141414141465941414141414141414141415658594141414141414141414155733641414141414141414154696E6D41414853414141414156654945572F5663414141414148725A696F634F556652767562417134593442413670464B69484653647A34777A5339614C7562486E46484141325538384B58334339786D434134427679375641415A6D5941414141447A52374141414141414141414368393456414141414141414141414141412F2F7841416F455145424141494241774947417745424141414141414142455141684D5546683842425249454278675A48424D4C48786F64482F3267414941514D42415438512B426A4D5157747267545769464464666D4134424636454F6C4D644D76475158525A4F734576453268587A45586F6A496F5147574241504D727065776531434D7947466C444F2B2F6E48376664787642674351455253536A75494367766C55596F4C4A554B46594C327148337935636A31494155516B5145594A4E46307A6279394D736F53346B4451455563694E4A3376474D6E6C4D78457441544B7878684241415A706F63693644364649742B5630694A6751366D6C4A424453756145515A386856675256734F496D4649476C77497979636C4F376E646276445333527949504256796B484A47514B71517777507852454553434967596953695049684F732B486A4B623765322F77437635714F63614834697278796935706B763130734E62645A7459733162485846734F696C435973724248456D5443693451774762304A4E4D794666346E565132576C63386B7569394131554A526253723043642B3165306A61434841574D395277346C6A516652743272623669495A6D436138616C5456446172413758646A4A436B676D694843636B44702B614563546C506B442F4143614C666D71714669724556445557336C4F3377525A7752414B6876412B646D6F3759436B674D6C674544335065646B636C544E614C5951734635676C695A6D4C5858694946794F5A505366324874676F52464155744B47694946476A394942484E32307574624D56307137572B2F7054696151564F324241566F6A46414F59583968384F444C47374B4F63537768704B6F7272596E5832456A465166777332367873626C4A71444A4D564B684C794B5232447A5256646F68616C6D595857434A696754414747614C6F46324F41684169794349387732'
		||	'4D4B4D4548674F6D374A72427A4D776348540A313751496941476777454A564243694A62356F6177743444524773434F41522B30435668705944714367364E6742425135512B6C5A30704F6441424D48336E326D76447A376567565159496742413544634E45633941797363654A45494752495131686F4D57432B78684555737041574E61466841624747456A666F3457537730686152486D7965646E7162784C6D67746B71776361556F6D6B324C7935544263304D6D4579626B70585A394471726E4D6F74384165697273777A4A674C78496A785130576B517858567578504D5A344A656B6F5A69634665346738496C2B42476A4954674C6E6745646A76536D666161543253526C6342554256464D464F5A44644E4249334C416F3264625A48624F42464966494338514F6154752F432B536E53697043586A53507967414F425668795569686C51376B74575A4A684D727947736A515859486D752F316E6C3136434C4C4C4959425141526F31706D6C486D78483036624631303661776C4C434A59425143546F51436F685A6F4730326C696751726138516F436E5535433477616677414649784C64306F7153496B576749416736796A4E445A717747513051306651443070744F374C317942596B5246554847414D6D304F6B534479362F655856366E69754358656F5658575A57434F5653646452536F78787979634972435550736D634D4C786C4642704D4B2F4270726942387875696C6E314C4B326A5131675949596E2F7A4E694D447061724C456D43684867633448326F324C694E346A43763055416B6E47592B68307543727177437A2F77413837395836396651484D6967655943486347676842574956425036436165635A34546A69647344366F34676735756B546F4463464D4D6E6471725A594763614F62466E4D4D30624A57433530315A7648652B34517257314164676A517A433752447756704D594B686F4D5344333858796E6E6E425A6F4D417156324249516F617046684441626243776A4A453035513148534D5136476F777247544178546B424F676D684F614A6F6962512F354732695A59774F536861523371744C416E6873774B5038412F636734695567416A4854643637577A785845504D524E574F6B42614D55366A415647744E674E734373354574706A5962314F424B51672B44414C7963684B784545535174774142566E534F7956354C514570385A76792F6E396547564151416C4746534849615136516844666B5446457459726355495949423265664162476B35474875723558457773424131516D6B2F346950477455334B4D744C436F4F41362B393445413832344B6D655156445656717231586C3950313677397678722B756E626A316E6E6E5038'
		||	'4176753557357764494836535544434377300A6B4A4541464561577763554E576755344F4C54545366486C3839386E48626A2F6E2B665266664A35357A39376E6E6E6B79616E5437662B644F6E302B467458446169757858374E324E4E4E5A6F494C706D72613731527554514B4546757230434E695632414536554E4956614234795545426E554D6876767A3539763433392B666A6E375947536E555A526C62534245702F375669396C44796D636D434941674555525155514969636A635A663079736E2F7A414C574D6961345152544D73736A51576E38476C72724B6C7846454E646C65664949525879694B6B4F732F41396B556C4C4F5477362F3357376A3071367063687270696375576B78476B4F4646534C74305834315A42496F692F7879436B744242444A35436F61543531586432564A7243436E672F71496555444674626E562F7671326635336E352B612F2F78414170455145424141494341514D4441775542414141414141414245534578414546684546487763594768514C48524D4A4842346645672F396F41434145434151452F4550576D7238337977414E4962686168736F6D336F2F554D366D596547355163755936676B6543496355695252627063496E366771616E30635677426447664465754D38763754686F71414142524477634143474976564D456C546C63465A67734F69766364676D476C45535A58484A6E42434B6E387A4363767A35396638417636524B5931793577585343686C554F464771696368425641747167696430525768675365414141444B33616544487143675741796431337956487A43515376306A6E6A4B4A7851746C326556474167663566332F52756E6632337739477662687643675937484B35706254415763587038434A67796A394739583358587A726C4A70687548416D4B4F4A64445350416368502F414D343155556546446B546F6D47784758446A6D4B5569566C706A457672676F52462F38306C63486E483738706A4F32486C38667A726C4E584A31332F6266542F5464626D76332B6634356E4A787A5A56493153507A396C32757141526A4D494C5267423153644145564D4D6D794235472F3841706174774F326F524146416371582F697434476F364D4370444B69516F355A6246727A5479527654316A754A616E52737A324A7A4B554D5834683959674D4733314E65486B4D596D465A467149593268774134334E6A6F70516D745656787559436254636B57644D46597562417043647863487A675A50366A487837694A45387367444452557132456B467245466867586A39494352474541622B6F7532344747795170525577354257515235335865614C6F35364B694C6B496B4753436A3964556635584170584150'
		||	'49336F6F544165553046454A646453466F350A32483041412B47704E57465A494A5A514466534355786D67614B374942517359705A706F365967434B52684F50515373314E6D6851546E4356496B477845317368456F644441764C67514C6F676749704A524A77754C324C4365354A476345455230674B79326B4D4134776D514970753564676E2B57675144346B75436B674948534951474542597170434879746A2B5338464A31704F45544565534E4F676B47675263582B315968494351465644677036797831464D734654454C32504274313765667637506A2B63503866683450705A6C4561684263494D495266417941796957534C735671366E76686F38356643355472546A6A6B6E7638414F7850376B34766A446143453262496A55476D51766F5743673247515A464B734C504835382B593449444173685442617746564D57667067424D494F643157316D514D754236416B6D4F78554142556C6B6A675277434B4C686C47754C6E6F4A6845792B7A646F5451306C636D554968655A2F752F6966322B32755272554466444769546C67535659646B6762474B45624A42386B6B674A4C75794E6A4B5134494149775A64446B5847326B5137346F58314751625A6769696764493441544A695068664D58614F6342643945516B386B657853685A4D774771744A53455A5A683076444947506C5332454C63714A392F5875474A49506661672B37787A2B5077336956495753794B68686F6D4C6C4B56454E3268487645392F5A7730596E755778374C346549624A556D42715A77467A7562677732304E706B57514F306B316F6F4B38475348796F7A7A4D4F504A486A7544624C46677A596E2B5965564C7355427651766C4152776E6F41503477766F4A4371524551776B35542B4156475466467173337166764830525A4B5962796841464B43424F4751784A4854342F7753425949786C786D5130536C6368414A615045357A364753576D7055674B557063746C4454696C755049766967424E69435448314B4B6F46413638616C445946706F47387441383648476F596A454B525679792B63534C6843475758456D4E6B6573467451652F634B52713562472B6738612F64376B51725A7A5067514A313677456B465069413862517A6362392F4F4B5A37392B53426A58474442624652696C446B76474356543331344F515068686C3275734B5132354F344239672F553656764354422B6B785A63706D32367168494D315172797A3233754E7852644E4853343672776A322F522F762B633857426B496346455745794961364142366558447469306C674B475A784146476B5252494E734F2B646265584F4162427356415247654B31414F646C4F39575A796156486E44636771677330'
		||	'315A4A366A48614A747256694652514B534B0A4D4B5166676C576835346738695A5A4C5354494C544635617230724741674257774D71475767554D77747067306F5478746B736D47536845744135344C423463436535696956533546423779356F61793358763537792B446D4166624A31616E706E4A77356E4F6F4D623949533461366F4357712F6E59537478424B46484E336E746951555A5450714538634B322B48686A75685362786141446E66615463757839315A65465130447972364A5356504A762F5044482B2F5348327A68694E37316459334A69636A5032506B396D532F664D787267444867485751686B6B64626C4E454F4A764B57366E665A6A442F33645547707A563166776F5642416753434A756B6D6E64494C424C59614657756D505269666E424D4A795A79695872373473584D336E772B49666D37642F4E65324A726B4D654B4833396E5A396B3063536B616E7335786E3564344D386A48694E786351334C6B49753055396F416B784C2B5A62323648793566564C6831784B554C736B49584D6C584967445455414655436B7742594B4A3442557166527A696E776A6B705A4E782B4A53694B34515941414F5435382F5076332F546334786C6D66796663706A572B496B4F69554B412F7A676B38447A4C52415A437152737A6949425A774A4657496D51696F676C79586A5677546E764C312F41694846734A76734B4548777067594A50595A62617042574F555177573059424D32347535672F52796C6E31483665662B2F6E5373427837694F736F693456716D59413868376D53677A51466E516C50592B6F51346D44776477365A52794853594C7A61713766614A73477458565A412F454D35317952456F4152374F434570674167477933314975414A4E354B3242636447425658473833522B722F3851414B4241424151414341514D4342674D424151414141414141415245414954455151664252595342416359475277544378386148522F396F41434145424141452F455067422B7369657955746C43704148356C61534D62657851666C5958474163503959763051392F6D546D494D444457636C4D4F63793465794C4353696230727334322B766E4837665677664D562F6C556830384756614F4734304767496759714C676775775755464A577550733851786576486443782F33646941416F51764368506349764F506848653233794A7A5179692B556F727A524D704968436E3552565A5365674841387A3042675851644174554F642B4F446974454B696B3645524D3142784376664537495234514B637351537737386D46646F6F67776F3458615A61736B6B386B6369682B486A4B623976546639667A4D6B7462456B424A59696F416A4962546A74684B49'
		||	'56485A41525044637A617736506D624C45450A6A63537271396D6A306874584E383443575163794B6F52414A6636324779367056512F536E2B366665516E42685858566E48525370664C4937754274523567417365724C76304E46537A4758715543364369477162726E31696244686B3357446E4E57707350354677326B3071647451635164755659657A532F3354683376344B67696B7143554C55716832666D4A437649576B6936457A4E78624F7832725469472F426E46553043326B6F5248746F6671474F563842464F436562575164554359464B4230666757714A304C74617156656A3437557755394B5A6F6E7372544A667A6B6F546C74517A563143626C773430784156736D3938457158506A4D755752624B534E4A4C7542446E457A453173796B7438734A4D4B2B45486759637747644C684E6B566942427253454A6738346253643147324B345557676B494B6D6D4E466756786C4B73376B5173753337794F58614C384845704F44483846716E526946396B6651344A666F49745567426D4947346661613850507430533454466B414235494656566C4D4671616D64515A413730427459387A515973463944414E70384C726C4172384347493234532B43434B456756445269713832547A3265357645634B34714D43436B54634C59426865706E6961386B612F645964426D4C48547455554A6232543839466850454C6873576B68514247567837796C5333744F4742352F4E33534C7433743376653364784A76427757706D724A4A69556F3670762F4A6A6B326733722F77426564513641786B536D64437346563042694B6E514F654161312F714A45495A5342484C66684152522B76364E78494270554177752B2B67624163555635793757556E7561466B4B33662F774247554D3835457A7A5876395A35646449584841733372615352374146333132724C576F6345646C7354476E646257425344684257475943696B6A526459684851736333523642454B414546516230494F784D56676A694E355174634170513242546241596141564D49466975336F585A674D4147737953535A6154354851374853556659694A366A635542476942615A68776D572B4266656C68576C307764722B7370704335696A673354414378734B6A6E5A494B6F6C79693071774D4462385372694664734F6E493164324E59626948624956623961674931347A3949484157344C5344433233694D77456A69336C715431454367486971515771306F4643535877506E6E7633667233366264665962594F624A785272614D4A56424543513257344D777648484539735A4A662B436B6C596452347A4446527A697052756B73304477474344306F48594978757851364745455472567A4461536D'
		||	'6E546F7563576544555A70794242794765360A583353626D7276507159322B6C794C4458502F41427257516130714F58463133664E5A694379714656514E774475424152574E306A4F504B6174384D6D44784A3474656837774371424D4A594533574A49492B45456332384E374543354334546F7551464F6378416E424E772B6A4D73586937344D4949554E4A4D54733132714165417379524A5272326F506C4D326F576665484F72433367797856413853456F686345325265643135303436534134724D3335667A2B7644454F4330524F634E49616B796F7835494839576847445A4A7758554B687950754E65336C634F304672382B5077575473506254317A7A313977414C6E7273676A5261616A41424D5A4166434942316D4848674142302F585748702B4E66313239754F733838352F7742395844574E3461454C4A48554245774F51556D7236585A524B564144456474704F74693551426957504C3536354F50626A2F6E2B665266584A35357A39376E6E6E6B79616E6237662B647533302B466D5A693278524C5368724D4758464C556B4B4346455141436A676F516F734A5A6767417A72637947674F6E6C646C364142414141513337382B66622B4E2F666E34352B3252796A5635355A6969737947325039636D343772565A4A614D4F726B4E57434B4246457549797246423432304235527555775A2B49314336456D61314635557559753654696A764D59465736414B473456387039525461556A7A6E4D4A6977646A4B65495A676E7A303368797A6D683163396C3572685577574E47396A6A2F4A49417A336F74344D334F4D6D71427048757368474C734B48443452684C5741343741485A37763939327A2F5065666E35722F32513D3D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A202020203C456D626564646564496D616765204E616D653D22676463223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E6956424F5277304B47676F414141414E5355684555674141415477414141437A4341494141414362396A666F414141414358424957584D41414173544141414C457745416D707759414141414233524A5455554834515963447849566D6A61734251414141423170564668305132397462575675644141414141414151334A6C5958526C5A4342336158526F4945644A5456426B4C6D55484141416741456C4551565234327579395A354D6C325A456C646F3766472F4645766E7770536C65314B44526B41344F5A41555A7A78484C4E61454D617A5768472F67662B4F58376A63736E6C3275796F5851416A49415A'
		||	'693042714E377449713563756E49754A65502F775138624B7130514236506F7A31734C72437261334C4B69307231637354376E37382B48464B51683939395048386850552F676A37363645486252783939394B44746F34382B6574443230556350326A3736364B4D4862523939395047786950325034486B4B41636841426D4D4475704F756772584D546D743865464A6A746234344856375A47356477514141466335494349554A672F356A754D3230666E79356D4262624149784349776B43776B6A3163362F7433312F646E713258647543675A514168774158444A4A62424663683839615076343145424C69433136335343444B496672654A486576487632312F3938353242655A3141455341674153524A672F3750725164764876306C734D4574312B425541306534647258373477644633337A2B5931776F576A4A4167644F2F62517269726B66766F51647648707774614A79435A49434154456B4B4B78527350547637755A342F7672637A446342434C556B6943614B4367427043524A4B58514A3933505150524531504D5544694D6363436B34594554792F4E376A2B67653354743537636A6F4D49325833374A53436B57787A636F76774C75333250384D2B302F6278366661306F4E726556755A69466C59702F385037787A2B35642F5A6B586B656C71716E726C43555A7A77464B41576F35724435363050627871594D5741676B474D457531633162376633726A2F74755056386C445531574C64625675476B6B3852796970746848756364755878333338322F533047664341674A4B36646254387933654F337A78616E6459756843513757615A6C6E526B4D614863753234524C74483952587944336D626150542F7656636E61534364524E66762F782F432F65504867345839665A416272467730557A71374F5477506C496C732B43766F382B302F62784B5764617753444167594E46396450375A392F36326645795652534143417550353833784B69557051424245736B7532366C48625A396F2B2F6933433555493255506948572F4E7633356F740A6D7959746B7A73557A464E2B73456750356A367236444B416257664C5A38696F506E7251397646707631344331316C335A7456336273392B63762F4D55794A4C3067423336664569337A315A505A6B746856395346506567375548627836646648776551697A7239302F335A442B374F626832746B6355776F4157364F33537938767648793064485A394A54385349374A6B71393872674862522B66646F6730392B56382B522F6676482F37614A617A566A3530723030304B78797072763130566832657A46332B692F38573850346E32494F326A332F746C6A5844585A496A5A796933666168714B4574496746'
		||	'54665036762B386537714A37655878334F355136775A4B4E49373159552F6E46647650466B645631344A546C4A697269553554484A4A5570595342416D5375354C5143466E7744746C4B51493375505671385A306E71423730396150763457435A564F314156354A42336233484A485241387958392B74507A327A30397550366D58465547536A6577637441547A773058313030664C42374E366C535732487945374B4A4279534A4A4C755873496450795562305A457258517153776E496D362B6E677A4A363150616737654E6A723061556D554D42466B43544D3265677A4659347650446D4C42552F65377A34385875335A38764B5952594B732B6A5A5851364B634D69507A71716650547237385046735754575141363434794170794C7778454D686F5A6B692B45524A697063432B68416A4A584275514F6477454E7A4748657275514B4168334D505735373050627843376E5758556B69496150443145356E323757656E39786666502F3237494F445A524C6B4C6E6D4C626B676D4C774C4A6B4748484B2F2B76503573394F61306F675545794D7871426C456D36334F5842526D526F7379644A73515962416C587A654630664E30304E424D4546535545656544354236714D4862522B2F424C7174596C4865416F575168465869443236642F506A652F4C4369302B515A37694242673837333773786F3879702F2B344F7A44772B587979713132676F6A7247575259533264544A62745871346A6B794C6B587133726F39504657347631765A517249477957376A667135664D642F44353630506278464B75306146476B756E36534567795336334164662F447A772F636572334B784254504935566D434744706E47516D4F494E564E2B734739355538667A422F4E316F42496D47516751776B474D70494641494253647457414537464A3635503575772B502F32362B2B6B42716F414246795671486D7861307971484862512F61506E3442746F446F674C71304673684D5430646E36373934392F44397739577379746C64755135424962416A683479694E566D0A694A366E4B5546722F342B336C442B2B766C62506E4C4355684A37614F55656A344B5757533051724B31717644772B4D66336A763466356672527946774F4277434945574B42416C756D4B672B657444323858486B557042414D416745745737793361503158372F7A3550367371724F374D754847746D77576C45474A64427270546961596566334767385550376937756E6136547034346737755933446E6937453238676F4B6F3650447A3538635044767A2B5A2F5A51596C4D567543474D4A59434C3936514F466F76577737554862787A504256742F664A6B2B61474A774165624C3264353673767633656B'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'364E46757976725A6D78484E3271393353515173426A6F4E437245674854726150483932374D66334675737338764D4761473252335968457A49535145727A6B2F6C623977372F36744852743676716547767779724334515978636B686F676234525659677661766A722B7434352B792B662F522B454134456150674E4D634E4B4278652F65772B7537647330657A716B354F30537A433449304C6F46464B454D5541432B3651584552436B4B663348702F3868352F77793964337277557254634D67496745476D487346576C5566484A2B3963666678667A7735657A4F6C34384A32746B6376443470644F4B5832535344435356507258744F2F5348326D37654D58514B7357743537624D592F634636763831735035442B2F4E716952334151547043574B455251414742636F676545596E4F536269774F69485A2B7676667A6A37317273486A303658675349414756704C5A484A64505477342B6548397833397A65507154756A6B676B786B486737465A4B6346496F674469787669434C5837376C366B483759764D4F663269484E68624A5348527A55656C35506E787965724E653264765035795452684B6B424D3875426C6D5151444B5152696C6E6B44416A6778574647565A312B7643772B6B382F6676447577316D546B7552536B457A5A633134647A39393863506974423466665761385035423459516D434D6759536B4472534B456B4552526C6D766965724C3478634D7071336E4377555A36454C6A6B72456B4167523342424E4979526843634D2F435850614465366476503171634C724B55323338734F514F414241644968376B496749463042344F436D577035416F756C4437377A5158586A386D49364766335A7A58464459384F384F6A30342B2F6148522F2F355A5036322B7A796F7445594B775165447A433361774D786367494D474D776D4A4369424142337366316836304C78445031434B334D78776E417545515159466F74556F417845434A744A52317547692B392B487872634E466C6B4B494C752B3079552F4E4B5041734E655168774B0A57634D6832456C4A47723431583433767450726F7A3935656B7256795A56627536667A483730364D6C666E43376572504A4A4D426F736B305957547372564573556732424A583535505A2F6C784244396F5847384A41494E7173315131504B556B55435569305264336365544C2F3862327A68374F61674A45536637332F684378416A707A637A5544436F53706A384E3644303238586676504337702B2B656D7A2B6738656E2F2B3377394874565870454D4D6342797467423538455A61533033722B73686E43624B6E58335966505768664C4B594A614157463362454F754C733641554D4F4E4D456345433235'
		||	'507A6C622F744D486A7A38347957664A684A536274506C48767761316842464749466F476B547936694E4F562F656A57504F756642337A6A52766E396576623232687645725549716D31516871457A4F5A584A72306B6E79526454595749495558484C62474E65774232305032686578526962506C553964676D3366316871785153624A624E336B447738582F2F58646735504B6E5559593165695469454F6C42674549426F65424544323741685259443876355A5078477664326B734E64554264634A49376A634734613677456771616F56314E584F765366734961637765726A316F5839795375504D4E643038536A416261706B4C57706B4F565330654C2B6D64506C6A2B3650312F574A63673265333569474A4A454B5A695A3346734E42656A4437574C6E366D54372B7634646671484D44345437462F4675345375484A59504D71554350516C785873357A57684B6B7A5353625A7737554837597361556E6458466C544B792B784E45596542593849326471656236746639397648716A5565724F3263434B6C706B7532727A5366434A515A3651732B4A32534E3541744679364E526576627233326C5A335858746B2F586C2F3565545651614B62312B3174386B6D7930444474414E6D64306C6B5339506D36615A63647A74577437444544656641393956397544396B564D74774C53756E7130726F2B47672B337838484D78624C556B3075594B4E4276336E3934372B386D394F554942543151696B50386C7A4B31674667424C71315737386C4D576475506D3556632F4E376D34693750352F5572547A4D7533347238766C572F697233647766367A46556E734E4A433447314C702B6C50494D7947526F6A34753068306736766C72715A2F762F3574472F414A393275675663716866726579667A74382B575038743564663561744B5A4D6A664234716263654C6A3834574866467332664A46517038557158614876455235453143546F4D6839362B4F58766E633770574C773247684F6C586D56554A354647362B552F7850742B7A335A376F55744935737A0A43537151624E75486C58315955714C5A36644B7A2F7965394E4B4B50744F2B674455795576623166486E6E2B4F7A4E354A64324A3938636249543855674A5970666A4F516650656B2B724A7245594936437A56774667695656442B4E523839717A576A534253436647656E654F574C653164756A45717263784C6A654F6957574B395A666F446643666D6F394B4D7476316557702B513065566C6C567A705972683673317366626B7A3379664369384F654856393763396146383448676F4F4E5A3772565831777472784E71334E617974755457577A7A36714A71767658327733736E4B35724261555A61495646'
		||	'4E77303979516656596D4973706564622B6C6231585072667A796B746A43326672484C4B583770484D6868524E347A4266447237777950356B57683166612F363559454E615A5A6239644655395761314F7472635449496D533063377665566E66302F626C3851745948587457586676787172362F4F7274544C522B6C644C61784C2B5571346636382F7637747730656E432F6375716259695251716B41554A726C59687A396639353157716D676C6D527A59584C355575765471396533526F4F41345473636E64726E5641686F683767704D4C324162392B7A2F35736F52734E676C6748754477743176665056682B344E3575643977784163736C37372B516574433861594356427A6959766B6B35544F71726D392B617A39396256772B51566E48544F56766D39772B7164783266487937563770736D4A31713359414B4D5241684C59346A6B415164783447434E595A7043505233723574613258623435333973715533584E4270796D5A72515558515872777554744F39644A392B364D442B2B7243786F34364B734E7475623533756E797A626D593553324C727743684A386E2F5A6B64752B372B31422B396D4A426E42336E707A647175756C7363697337702F3933654F7A66317256523554542F50487038716676487930585267786957596243694167337747557239786F3043304F6949476E6D5A6B3550634B665447447A4E746E627370633966752F485335654734644C6D37537A417A7377435A77516B3659736241554D7653504537756C462B7664446D344F574747756E6B38573778354E50747039726E52794369346D526D6A752F5565555831502B316D6C6D397146486E36307053554968362B7167397973544D687154717233654C5958427675546E583268664453723372677A5731584948704664534649324577464845456759594952635363676B7A63795435453756577A7534636D4E382F5A573936653751516E4C50376934334D704355326C6F33516B4549684475787376483938427558382F7654394354716B4D70455774663348687A2B0A7858683449396F4F4C4A67356163393035702F63752F66525A3972504267385651446971756A6C5672754277615A574F6A2B5A7648707A38593150666D712F6D64343757377A772B717A77376D444F554D70524A6B52534B74724756434C537363684B636A41514A6A364735644858723273765443356447735144676B6B4E776E522B6E37586867676F514A4546567A6342512B663242664F654D4E6748415934506E30344F5137702F4E3331765678783041426F4A36786A4F716A7A375176525036317246586C42796D644B7133704468535277327231354D692F637A4B63334A372F795A76334237666E6978'
		||	'5179776F41656773667378655971687A4D413773694F474142525A6F705143586C522B4E374634755A726C79356532624B5131757531475141446A57693959747A6479514167494A73724D546867386B6262442B4F587037713930377766486346633871593565586A30567A46755878763865386864526A6774415757665333765166716171346C2B6A3142586B796F30766C3957446C4F625775687436674E644A6A7834642F5A65336A6F59666E6E362B597652456D524D755A75525344686C51474478333571706F3631584B4332555670653166476E3375697A75372B364D596D464F576F4D356E584B53315A685341424B4D796B45576A46434571452F586372687A5935362F7A327451657978754A4C41596E5A322B4D687465335239636E343838524A6356662B2F3331305A66486E3858496E75746D746179655A462B415475615163335167725A2B637666576775727365314E50395356454F445941614952486563634E732B325451424754536949414551744F6477625758706A64653252344F677952336B51454937627554624C6E666333457A49616346654F45704B6865714B32366468427648396C6F546D4346336F376975446B356D50336C792B6E64562F566865413452432F794C326F5033734E7241667179464A794A743676616A725756497453374B5635585568454D567049392B62586E7A743070652B636D566E663675494A7066454742476A477A4E79307A6133526B424F45466C71566F4F527274375965666E562F656C4F644F57556E4177786C4A42424A456B71352B5475495952576E4367774D55593155596B416B516D74624F39522F4D6F3651456178534A70484475667A442B342B2B723950546E395370314F516D363339507672792B4955706E314F617231595043526552495A6F694361614759576C6666704A7535474C3735577468454C6350482B61444A335A346D504B796753654644434D776C427461717A566B554F56453131346558337470617A497456367535504C59307237666E7551417A656965454A476C6B6B67670A5646455731506C415A70464C53344967334B3738307341646D6A644567754E654C78663162442F3866325044437A6A654B5970754950573537304837476F6D31417A776E626A32413270336C6448784331414763304767436861546963382B595A4C3259626241665A315A334A53467662595442706C6F2B725A6C6E584F612B556C5958325643314E37755541757863484E31375A32743250466E79314175487442592B4E386D6D7A626B38434A6B4649516752696448656149496B5A46705579796A6D764E483474387741324D342B537739323150443539597A52384B5954683375375849796639516E775032'
		||	'73395354647765545763376D67452B306745713135376D4B52314253776363413942637454505644444E647234747064737572504268507870653165794665654D6C50376A617A782B6E6F71476C4F6C353558384E78612F6350546146686376543639656D4E53444C784B6A6175775469776C645473496B4A774D4951534A4F627443416771366C5772714745475A5577775370614C42704D6B767066414F73637835683071424A43326C2B594F4462385043654F753646634E6778556566522F7131662B326A422B317A30394D437A366F734248425170646C382B546272496C7156754559754757512B544837353376694C4E62596C567378525A7A6C4A50746F646376746D733736574C7932617138664632556C594C72466132337956693444397138576C6C775A6E5371706A564E69796D6A49774F6B4E5751344D466B6B474E4941656C4B486F4A6961777A2F5879484A36716D4B4A685439387458526E35786D7534353663455473386C4C4C39484D44342B2F6C7A6A37386F332F665774776A537941746B4F756F435166627877342B6B32674872545050323750497973336556453152334C4251447064594D3459723358787A4B356B48306A494159626173384774694C415277746A4B53626B376A757639346D7A6C387858434D742F6333587635366E446E36766A684F73335771484B7549444247574B544D736D6753334747414B4C567A6F6D3742494974503559676D4639726167476532582F75554B6D6D74554E716C44475850315772394D4A32756E6F792F7939302F484139666B737443613952715858615641786B6F2B74652B422B337A42745A6E6D4F4F6E5930306935565754563637616D515642526F6C494663647A586D6F3064592B746E61496B654A4B7A795569736733466735585138744A3368497165717A712F4A2F7673626C313635734C55732F4B32443262335436734771656443554655736F78567A48344A6E427379474A6857535145376B4148622F366F4C764178456E4E37595268554770746A77567A756C544C76616C4F37680A2F38316143344F43697551435574413846566B413446776B58764F393465744D39706776306C76376831507176544C4F636D4D7A734D41705842764C5470736231532B3735354B524E6F6E6A4F79514C6F786559597A49687439356E566A766A384E76374D2F66583171563066757761356633706C4E2F6645362F33795A33357564336C347354334D396A4B4F4242784A654B4D6E4E4751545A4D794C456C6F484752335A794246765A33736F75314E7A6138694E6A45457955544934735A6458726F396B2F54596176444D5046765A33666170654F6A4B524267767074327836306E374649655A375348446B37'
		||	'4D67554351636E706937417A732B744A32344675614E7156327743517763334D4178794E4E45657A536E6C76554878704E48353962334B68744745677A41594433342B384E41785874737172772F54326D64356231453861316F4B35477A7A453449496A523876753456656B324B344272376939346D374E72516B65423567516E4A516C77436C51326230366D76317756467965546D34476A4E4375496F426942744264442B6D6A422B337A6C575A2F42586D716C4F63357A64734E57594242436B674A59636E6475563178444130726468767672513069545977714244545341716C7758592F463137636D727734484936713968566E51592F5268784D34775842794F4C34364C6E6450716E343558683158645A41395341535A6B703464665752687238332F57474B3034725468754652634541484E726A384B44594542594C4E382F694E2B37765064376B2F455851797A61792F576237377558362F53676653376A34794D51535772535763344C4579796739584179704A6F374B377577436A74795A545651436F535A695851426A534B4B5447547A466574724161395069392F63473031634445616A436137674445345176682B4C79545265485A535879766A3354343776774E61305662326D79614C6C554A69336A6F716243766D6A58376149784C69325357555430673175616E6431475252496D41774B7961757A3563397650666F7658336A70306A694F334A4F5A457956672F62546E55346A2B756669764446644237576D37702F657857756D77504B5646546774316A763171796459464C79313449584673544C524D4F675752546B713062504351485849664B622B2B732F33466E6646323651724A36584A4854705333565778496746694356794B2F7556332B44396632766E6C7061314B6B6A417747517748487237615661464F6C484567614E5A6749746A6D34325571714B4A6C6B6E6B48456C4A61484A7A3965724E35502B5A68307171434D2F5470426E326B2F53324232355A51584B533846423678314F785843476138756554466A5945796B7A0A456B7867773631586A494E6B655146306F566F5839755A764C6F314C4D78465A33637231727637506A493461384B4149664279615A50684F4A5A59354F72644A712B7A79666C4A32374474347177534267323268656A744F744647707746526348646A434B356D75623531736E68374E4C6F34696139427362323139367449754437365450753870562B35704359764731394A4C725633385A515954336C6A6963745359556F474559535952516B456A4B6A4E47395A62775839374E50377165484135687042617A624A6F516954435A7367613253333277434274652F57315566486E3179352F5A54495A514B75'
		||	'3669723975334E4F687A5A516467345174522B6B6B6D41335A756E4E39796852417961566158422B652F6E532B75726535344F6C535A6D385131576661357779644A42516B414535444B325073616B77706164316F6E656C43573050544556653858474D48436C536C6E4155614455467751414B305A73506F6C38624648312B374F426B5A714B6A49444138516B42316D416652574C424739456441455979684D5951702B72745476375731356174365A367868786A42522B4F6136364E314B53437464494B6D43746D466D74743673674D444D5559484932457062724A2B7436316830506761466A7050726F516673385262743337732B30646830784B312B6E5A755A353256317A52774F677758526C4678744F4349694F4E70736843326145714559705331654B2B4D584A364176545951784F304E4464424E49764B573639505A734A47574544616F2F36366D5338725049694C783474713447463047716B6151344954725366317A705669436859596841567645577479357A75464277454D346A32516C6664484B375744367271594669383141352B656F2F56766A782B446C484C62764838334A5766414F476535376B36556C6F4542696E546C334A6636396F79587367324E4D6A7070496D7157436E4C544C4B383843596B66476B772B74337472556C4951317067514141436A416845434F326C48544D4545746B434741705A7A476876554566713563486774336376764C347A4B664D73452B324350426D7A785779514E63376B4E4341474255504978695A6B443673794D2B53516959594E315A676F46454944425770734B484D2B5871782B4E70752F4B37566547564950326836307A3132426A4E5A3138614E4C384A4B6E744D343575626570454559546832744F61773164515A4A4930556B724F4967534D31784D4D563464464B394F5270636E572B496E4C37496141747658564E31326E676745545564386454723872597358417075314E306C413756454B4A47446D46735475456A306B63634F437462327355645932732B323762434A4C4F6157710A5361764E3849673943395744396E6B4572664278304C6F33615A46796C65554F527368676D614D46396D754E58635A75654F6F455461554A634753515A7038624432364F4233746C6243765954386A7A597273493849796E754D4E38584F6A6C726649622B7A7654776832354563794E636B4A454342374D795859305251464742625353597767774B41706F2B2B7A4E742B596461504F7962755A515072397930503853394B4239446B48622F666F2F665A764C363261656665334B49694F79795A4B3235727853612B497979744552744B51434F2F4B4B5A62417654456176444D704A653648724534747A6F65'
		||	'3259765A4D777461637A665769364F67692F756274316252784B51334947692F424D4F57486D7764543277784A466B5171516953354B4D4B6A59664C54323147583753624B516D377973366C4E3476566D31377A4E744439726E6A346A3643494D7155614B37312F6B6B652B56776C7873536751616A755631754F425A734D30476C3543346E6C575746686576442B506E64776634776D4D732B6157427A58702B32666257424269504D3361453867713648384C587039755868304D466368737A736E696B7A426F63637A6B4252684A76456A6E3179677561424778734D506732527A4C36753038793142723331782B674A354236307A326D462F4175526D337A71714E724E4F43493555474F303449574D6B675352416255333664785361373434446357584A36504C51787359354B316136524D2F64796646346C4D577A46714C637750485A6C2F646D7434636A6761474A564E7154773530416977344F69647A6F6E3273744B4F706A2F2B65384A6B48424E33724A732B7A36703433376B4837664F4A56364952427A2B5A455573684E4F68467130736B73354153724F46357954347A475443625143525070316D534A346F57792F4E724F654B6441567A332F43366167336C4A4862624956756B4B585551784F4337545868754F62772B4530637546564D674D44704778646270554C596C434B7167785A37544544675A732F7A726B326274785A5855337952665A61794C2B49366A3536304434487858484C762B495830535635375765753275416D6C37784273655A347A53305462584E43556D34415A6436346A347A586875484C3031455A3443594650744D6C2F2F6F7372326554486758414848534378445459395646785A52545839516F4D5A6B48753256776B52486348614B7743353459474D4D437753634D4342424F38465868426C4A7437646C2B3731357562656E33306F48337553754E6639686370707A535835315A363641774E427A564857534F54576B645674674E6467524B6F53774E3765526A336F305546794E436C746B397361556D316C2F480A6B6C484E7A49374F544F696C514634667835613342694C4A4D5A5350703569615A576C397A4D39535243364A7537775952376132447A556E3474764A756C783761374D7A6B6E7151733961447451667538636C456678374B6E7648545063444E416A4D6B4744515A433259495741475174494F696738664B6F7544457168765349304C35642F4A666371794E457541545039417A764A453641745165747A586347386361343343756A5A536A4A53466B324B58524871793267446C68754D693042333179672F345652466A636D725733756466575A7467667438346859593553735A5665664C5939547270586261'
		||	'5172463642773442304B774C6832797577596730686B745868344E4C67356954736B36555956453079664F6154635A3161454D4F535672752B78326355364A476B5A65476777756A376373775A4E435A4C737A464552612B31364E5955326B4E766B546E63686930386F4B505039557266697845334C304C333850327563317A5A355475454C65584B5A557A69746E456B5577754C7550473035544445354B42686E5A41446D4C5174694F2B63597758426B55466D49324F7471704B334D7246387A646838374B5541306C4958744C4C6B73696372446B4959675254725638556765314342734858536A393162496F41684F5A73316B757864495A6D6431735074545A4D4B2B6F51435A53516947477A41677771696144494D69444172556D6E426953597A4B5176597978422B317A334E72716F3069576C4D54636471346D7563724D636262676259477064746D3164556D32335548594C384E32455769324F51324C7A715A59542B6D6D445A6D3749624C513267353332624337774E574B505459325541595735435479536C454D4970314B4568317456533558344771412B5541726461744767494962785144416C4B454E63777744456B6C796144596D496E72692B464F4A6673766E587A665038754F4A64364D5078455A67324E3671444649555972733853776871653165523268304D687A47303966553538414261713072695274304D61303247485251596858503951327939467038316C4F6D2B4342434D444A4D694467495A6C4A6D4E475849684F44465155324A566F4F6F4F7A777355736D577831566451456D56452B36414A78694A5947634F416A4A413950526A66523539706E79666B696C3131334733376E453975572F613156556D5A6F3342456759434944584B68614C6F38476F396A30573769557642322B357A6E535452334F6B4A5259414A625835687A5A7874324D75577537657A734A4E67527678524C6872327932433473554C5579324A414E714D525961445855616146465A6946306D2F6271524D6A746C353541674F5967534C4F7969460A75784742465236684E744439726E75624D394C347A62735332784B566462756855556F6C7251646A6D786455587A4D7544795944414B6F61742F2F62776342732B664171334C544B64344943433259394A4F2F2B4362787759463079392B5958442B44614D4141434141535552425649797776544A75525175474A4A46754545426E47476F2B38704D4379347843735062664F38384C634A367644625431655169444D6B374D346F5A7137756D6F487254504932512F51683233674A5368704B7946556D736D493567553269546231726F53434130444C6856785A4E335741443769456D63626B2F465777745243'
		||	'5674626169617562744C5A324535733862632F654F32674C67514B32583970574E434E644A4B78564B527474724A4F526A7150577A6B49645730783164776B6B456E5441752B553852777A6A73747A685235614C65747A325065337A6C324B664857613247544C474D4C527A32716C374434467535326B554542544D786A464F4C5A5364686F4741473977463730356253643235364E6247574F6170557858435773734D6F79416E512B76495A7567594C6842414A686A4E7471494E6F775761752B5252697052465431762B5A4B685A524B34524F326C584F2B3370656E497A67397A5632555846474B66447766376D4B6457574666307656512F617A774B57593477544D443644624363796E784538436E4B674D49366A54597A46356D5237312F467565754B50566543746A5A4E566D53657246434C48685933694C395668614C4F4552444D4D774E4B7375777950364969414270684E384C44452F507854744958345267623162425A31674D4847772B4C696F4C7A5530385A3965667A38526B666550724E504B77686B4C4F49324C6262356A694B5269636155324A3131702B674F6D48455562475149374561384D703337396A394E307566634D4E7431507337576576764A3674354A64625A4F2F74477636426D3855544153526B526A4D496257345559784978444E53496462656C68673651776D7448743669527536754E3232706148392F6D686C4D52304E7267794C7931316E7A763433716766743877665A702B50535A78667053437644784377496E52476A49527472593233717A73794A377153424A565161444E37714A6479734F2B527558587661765466706C4D4D42717A50767A2B7076662F446B7651664878347371433343487178336761694D614675417764537576336862654A6B486D4E4F4E717245646A504462576A734C6B424E7A6B4A6E4F6A45787474565476614D62506859483838764C374A744E372F527657676652374C5944746E6647685069526E53596869324F616F744E55335A6C41774E6F545A6A696E49495568424332345A4B470A39742F77663338626748504D2B32475056346E506A697466334472384F375266463756546D677A344F6C575A6A64654775662F756253787150443273357574687A67613649544B6A71497A735768333278556F737158513341676A53595468594671574F38464754346D336E6F5471516675384D6C4562794852764957506343597741484151593045537344416D67773452756D616146373062374344765850583130424E72327569323744474452365036736575763236614E5A56535676685269623865797A746C56502B394A326874766C665942557765573248705361412B34496D78464F4F7A786D74797A'
		||	'63727379445A4B41566F38474E51584842454D38664466317651412F6135787A424D714967335949507970734678784A71692F4177304879733036416D6D7A56575A495953545545334D58744979736B67577045514862496968774C75624148746C6D696D624A3652434F4E4A3039772F71653766573536734C626B56457273546C52374D7766613559415959636E734F72305173733150656D4C6D625364742B63693239552F69613770526B417A49474943493755314A32354769706F42764E72416A463176626F643466463530523462675567336B75505034586F32654E504137786B4C496F746979574D6E6B55315163756F73384C5847524F54416A4930554E75706D75565769735275433733625A65564745766E307733597A3457565648353874313874715661586B37647A6E6C3675544344674A4962696B7768464670326E6F4A784E2F4F4D5A68494D6B6F514D714F576D6F3949534D41304B58734D6C6354773368372F4E7030636D557747424D4B6F584E5937513977395A6E324D2F4A444E6852464849573452537333444E4336774779636A397574747942763156475A616F4247316D377274574B4B7271726C7834584E7043454C733056315046766D4B7133727073372B6135524A7255346941556E4B73486133546B466A667A4A4E643063366F536747554749744A43454C4949794D5646514F4C6B6F7177755443394466476F2F30594377426B376B32506539422B706E37495A4645576B794C75687A41684D3245427A56416E55393050796F53316D2B5969736C5335716B795841472F587A3958615754794C316164337039466B484A2B746A303457614878644E5856793464786D416A69336575753634534378415A6277704E77754C336A51746A2F635437644766724C5A775857786F586D375A61537364716E574D306A53346D68342B64714633792B4B6E57364843516B776F443844333450322B61656C326F456D47574D594459764C67374276694A6C4455694F64584D6F666C446A4C706A71596D416D6C72486E566E44564B475A53450A334E3759432F7949422B4C356B465A43796A68654E4D654C5769457371377971633061334E74424A6A632B766C48517554785234517135386E6230684C4F4273716A74545051787156336462716C6C6D6B537967344849686B356E4D57586B34764C717A2F66703439426F78364F7969757676312B68653476506252672F62356942444359464473442B4C55774D594B4A34615958636933687A683270746F4B7459636C335A64314F7170796C54636577756533735A367469352B4A4F7574306C553558435345733672797376666D6F75754A5A47485771527364637673693555694469646E36306733736A4847'
		||	'66615A6B6D704A596F44464142447530316B6953474C6E497875376B362B5673513959394539465243687468726F6D616765744D393974414D564D786244636D63517831524F44453455574F37356E596B65474B76455568344E6C507571535539577A564B5547547262346E4F4231666E4135756B71582B4D3671394B737A6768685566753839717270674E634F6570386478585157636135315538397957476F63474B375550392F5476634B5746614F4D6D7A734635706C796732676D5771596C476B49593730792B7644743548544B6130566F2B724A424D3671632B5057672F4D3843564141364B2F654667776D4B5A7A4E324835746A696E58312F5A354B504C512B49594B4452476F5837712B616B3851524474332F5443617A6B37684A6152726D746B34586B766D7838315544796565327A64566F32325755746B36566E6E7836534D7A733835377861724764356D4378755933617A2B756474662B496831305A484A74324D5A744764376942684A6E64764571547833733658647165766A3463333547306A446B4474697445764B515036364548375845645A58697A4C5332594651614130686369546933727A6F6E2B7735664E4E7538704575372B7548315831576335746E776A67463372465A772B755A366B53616748516F76625A4B693272394B76423477367373683474386C6C6D67654F722F74596C66322B6F7333614E522B687346593252472B634E5543346A4A715042533566326633643736326177306362464268446331636C47657444326F4833757153687561434F694C50664C3871725A626D517742537251306B5739666358663350474848633172544D5A486466316776543670473444497255664642744F6465647654516A514C535A5A4177426431506C756E5A5A33614E59564F3074545278783071733353576347746853322B326466754766322B434F38456265445451524C6E63573272617A45687A51664B796942643374723930656539335275566C554C5232725259533351566D30767666714236306E36584F316F74695568540A58544B3946446F4C567375772B3363305039765847684F2B4B316C37425374424A616834763573654C525A7641577146523631357A6673757955794B335073646D43674542646371724F7464317A756650444E697A6E5761515A6648457777643157666C6931392B396C722B72754D6777793058705A6F775150627663625850454A4F64734E747265756E626C346C65337974654D6F2B774E694242434B376D4968566E49674B766E6F58725166675A794C554453414970684E4C687965667472685564586470707A5A486B7739547458386665583039765261304D5957464F546439622B34614B5A4E30324743'
		||	'444D6E554864482B4A413751776B784F344A62644A684C696B3153315454725841505A7151377A6C48666E74414479724F4744566236666C35667A7A312F31743665344B354D48675968356149716B6765374B41743074353241326D55356575726A37572F755433792F696A6C6C68466A6150685459646734686B364256525057672F4F37687475394C6859502F793775746C484D73736B55357A33783772374B722B2B61583844784D2F694D695249766D343176764C6648645A566433796749446D33464235632B354F416B77577043414836426C31386E564B6B48654D733467755737646D717A716F6457645A7235764831394E50722F76374A56614F3649544D4B51424F6B67776234535449596C4265324E2F35366F58646232344E763249636B4946384374714E646A4832346F70504A3372743861635972694A756A585A666A7366584D4A2B6C64416F304C4D5952747432735838626656746939712F465276726164562B352B5A786E2B3462432B65474D596A5A5158694334364C59766D4F64434E69425A45743641514857684D3431795839617041687569516F5557584D754179314D6A336D6E423373627079397436462B4C326833552F597A686C534947735763366D555274535948713159426B73684472624831792F762F644865397464743438506352772F61467949435A614573426C656E4F392B595630644E66575932614B77327830415934536A7862317970796E3963686573562F584754336A696466583461767A596458536F69585644625A384A70436462435A3244614C6A677034684F5755724F7130377753464369423375714736555A417A41385437713150562B74337635432F6379582B66475172594A754A7047444B567067486B6F534C56665A5578756C302F4A56584C762B767535505859396A7158385165744339594B794B4B525967376539752F5054743970313438434635576E4473313844425566556E7656537171584434752F75515565334D50643966316A34374F746730374F2B4F526864625A764E32713777515138450A4841337442326878455770576156716C6D6442494C65587050756A474E676C667A4F776F38573934625644312B3148303135456C716A4E7755694F356778434179417842706B4558616D6F396376372F7A5A785A302F4B7374645770436366557656672F5946436C45773433422F2F4C577A3452667138504F6D586C61465A314F465166414C6F633758384E6159422B2B676C50363749317739342B71374236643749563862384F584A71454849554541753462486C6B4B566843507644636E38555159472B7A4E56785775586730584B375457395A41424A3570766A7A34315536666574472B74625634643245'
		||	'6F6847794C3877484D456C534C6B496F4D706675546243746E65327676487A7066376C2B34582B304D43416F5A57634F4B50706862412F61467765304942677373426A7654623957722B342F50767A3751704D4575646E53676956464E426673795A665366356A6F37675038376D502B786F6E742F384D63504B6A2B33495A3767366130396E4A49384859766941716C5864696658727134433535517170706D746C71766379714447597775594A315A6E6E6D387655717A30372B664C502F6D636E346A6B35565A52715A794D486B596B68706F5654654E7352675072307933767644796C662F74777653334C5A514D464E727A4A5431636539432B554C48784B32516F4A747466724F714432657244764C3776574D6D5577424A757A4752314D623864745235684D624461777863667233652B65784B334933357A5231654848416672504E5A6F5267546A6C6633526A55766A4D4243585369746672334A756942673659746459415966312F4E62526831723837545439654275487458597967676861686A7754494572506A74466F6548562F35797558392F376B77765362772F4979444B42765A4D393962647944397356696F72796C686A4A516272303856623239764C313663684C796A4243796C577A636645304D6337337648773478482F502B41482F3666767247683265662B373838562B493339766A79324C626B4D736F6F496F4258702F486D6C584A725974574A2B514C4E696B7042325241426B316A4F6B783474377430392B49744A2F6263377542635A5A324A674E44504B35546D786F6C5449777544612F76547231792F2B3866564C2F334E4F6E75554544626C37366F6A6F5237453961462B6B38505969466B6B54682B57316135662B76476F657A5A59704E5364574259396A39397079616A67435930523130642B594E50663338644D502B4D33336C372F336C302B7550456A62663342423378694867636E6F686B543376534A396563662B364A587839782B67726D7A64704561315734535A79315A4E63335236362F54776234757A2F334E48700A775062795269416C586C424A56647550434777694476447764573953333934616538506437612F4B727246396F365876444E335A4838557277667469396254576E754E42784C64537476616D587A683075562F353065616E6679454E71736830596943467555793143565757336B3277474C49673548645031312B39625A6556627061375632394E67705842726F594A574551346F33647952392B34615633336E7176566A4E66613531796C676D5763333238654F664A386439564A2F2F74636E3172574A54677941456A775152333835686A4D52322B50423139615866797451753776376B392F767967324738'
		||	'336B377136486B39503976566462512F6146776D7A48676933344A3246444B4B56303073582F7254325646587A6C4E35612B6B70436164456F71594B5349525A4B4F336F38346347723865333330322F666E6E3339336558585469702B6157667239616D565930615777634C2B4E5037424634662F2B65714848783432703273736179526E797331712F666A6735472B50542F3753353239664675614947556C49786B4B57676F6F69584F4457394D7232373136592F76356B3737636D7857566A3631415658454172647437347155743964647944396F58696F51795375644E733430546A484E7675395A33664754412B34495871374D64316665427362374D62554E524F325967684F64627542362F36642F64783639422F64484C306A782F4F6278346676335A33352B61724F3850726F7A415A32422B3856503752563138376566504A777A71766251426F73586A2F7A754F2F50486E306636412B4D4D4F4355326430514A496E433346374F4C3632742F33352F6633586437646548356576684C4272397651516B4856756374616C32373666375548373471473275786F67696654577A6A51776A416458624F6533676F3247673368363975357966644130707A52725255794E484A6E676743684B315074344F506246726A39613548645375764B6F7556367672732B324C6C346537652B574F392F38334F4B3035727A7950483934374F387656393937655053747448346747316759707977686C4F566B4F4C6734476C776444562B616A462F6448723836486C34646C4263437436514E507648736E7A31536539432B7741587935762F644B52305151686E4461477430597A43596C68484438734C7837503335346F4F734D366D534E7A6D376E4F54415744726E51633257546B59347158526E305A544C74485736754A43484C3632336271793262337A7877705266326A3961376D37705A44332F32614C36774C5571527939483277474870527147305868306554703564576637693176446D38504274534C735151476B4A4D48375365787A38504358656C4F660A5479317979783444494A505143466C6547694A425165355658522B664C5438384F50326E6F396D507A6C592F71395A487442675141615863684B697331486A6A7A4B57466B7248776D47747A4456474D7976484F6A6433664B48642B5030352B34326F3571733865724E5078696B7650693256564264694672576B35654B6B6F646D49636854416943724B514968526F6666586267376150587735615141474332475A6168306745776451693275766B702B763630574A396437473863376138743634667275744856664E6B335277504E4943516B4A4A6C597978734E4F424F615264476732766A79625774795A'
		||	'576438705534664D55476C386F5130437854716D734A6C724C584A6F336A304F4B4F7351514457342F48397049506A4253594252477872346437305061784B59365641424A68632F71394E57647A41453939774F46674275572B727576547865725266485672556431654E2F65723569546D515541415053474A6B54614F2F78393762395A6A5758616469583172376233507557504D513436565763797172494646566C476B4B464B6B574249314E4E57553555613767595A68774541446676556638522F77732B45484E77534C6B69563153794A466B574B4C5A48476F65636973796A6B6A4D6A4C6D75504D5A396C35722B654863794B4C73626C554A614B70734950646A49694C6A336E5032326E734E332B435732746D5A667564437633657531396C6B365946794A52593254776B4345516450524D4A5170347947506D427A6A2B7048587448554F4F6C42695235446978384837655031364A3656434A427A76684658744C6B6A70674A794B68636356453156694277544538485547766B6C734247684D7242524143414A424441706B384154324946594954786E7045656F513354475A43455A46484D764D434E354A4D4C36694A32762B7367703644464F38584851506C372F344B5A56774967554D464D324D497842383338685970767266527549654A3438772B624E516C4F4C6F4142694D6A4D546D7274556B6D6B7A533255447359456259774A5452305A6741696D706D674C6B794273654B5A30325674567A49517A36304A575448392B302F7839666A3776482F3477484A4445676742675535427469716A55524249615277584161775068516A45324A6D6D436D526A5A434355626332504251302F5A74744E2B497542457852364D5734787231553461656567454A346638526B34314971703236315437755254322B61522B76782B76782B712B39486C63776A39666A39662F5039466A6E656F476E726D644739672F4134575A7A39666747525835716D3967452F5479764D724E544F57306F6A47466B2F412F7A734D66725931532B7030394C7264450A5874314D54454E41762F6F4364536777547163444E693946484C2B716A2F6F615A38656C5077777A556D49385969474543774D6752354E517873396B566377326252362B2F6361382B6C554E6E6E4E6F4F4E615367302F3977627274706A7A5170542F2F7358457564667546627A2B3333364A2F6C515439436B7069436D382F57714C6F334662364248766B36474B475A32426B633145363967542B356D3961613971575A6D6341694C4A714A6D736D3872576B475330303142684F6F777653304F4C506D4B31734561745055434863614B6F695977426F56774D657554502B45726151774D51416D5A70494D55'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'61456D54534364426B6A7A314A4E715645744156554772526C685642523956377869675A6B6E4E4C426C557A4553537A64392B4D6742576D305746416256424647595742574C4E5232724158486236397147475A42626E6639674D4B596D5A7A443950684557444342445261433862784B7878794654416F416142616650527A61442F5041576271596E4E4A6439466243343561776F7A4D59695A536D504D4B32594741637969575A57416C43534B706B2F327069557A4C3556784D484943356C4D78322F6C4141455977333579616A5273627A642B4F6E7436374271634944645448476D6332416B4742364D426F4F69616E38746150317A2B326C596962737A497A454D797A675547775A4968716E75656A334A51513244455A5347447A50704D5345632F4E61442F69574A6A37697A67434F5476746673474247495A4565564B496F4D5063304768686E73423069734A55674D6B636C4B5168346E7472314B69675269544F4D34784D515A51344E4177685A386F6143514135654737636334336E6B453479416F7A6E6A58516C4D584432533731764453546B61643664387737575A414A474A4F526778677079554464334C487A5532536543633270716D677A6566324A42657A726C68784B5A555A50644E4C6D4C715745756B494335625575547A4D772F662F50514351434A677563515667555455794F794454796D595036546C70495A6732446135462B4A6344534B573866463972434763307A57574C552F65335A68637948765A4F7955334B4F6E62422B6E464A463538426761624563433339366637592B71535A5753676B6944387775642F506E4E764A655442354578694A7173792B4755367A417667755A656E4B7A5330494B5532566B6B774F43493248536545383850457A496A416278686274644A6339754575626D744552486F6E2B47415A7841306A5774394D49505845676F7A546B444933464C75566E4B473262336A32594E684E5A697047526A4A456256613155766E326F735A75303875666653596E78376577446764495A792B64314A52734D0A46524D3138305149795369676A45594F7A6D3076577151577079475A776A4E6D5A79544D7877387A6B683437486B776364625A4F6F734F664E4E6E3046424658447A73507A2B74594D663344694B4C6843707039547A2F4E392F2B656F58387578636345366449794C416B55454E2F42467A47365A6B674A41446D634545584B722F776533396E39772B756E383071785535306D7133396379353565582B75536579344C677065636967444857505044626E486B4747786C4F7A455770747073686F664F69565154465A4D684F596F6A47775662506F714B6C374C57507A316E67616B4A6F495A3071652F312B44'
		||	'71662F367A376D70444A507344717276623057714279706D367353777570422F356D783339557A48544E37634F7672656A5A4D5044716F794F694C71424C66527A7A5A2B392F4C69656D44375249505751415948565961436D4A69622B35514E3545345063464A6C72677A6A576E634F70346644636C524A44542B4E4F713346514576744544447142697833334D573156722F54365753757732704B517154452B654F492F466A7073544E694D32624D6D6563454443713566567938746A56494C6F66426B79786B2F7664653474524545507635584A66773855442F5467334A4144676D636F54417448745376507467636D4E2F52675454744E77704B2B4A2F556179663765666D6D506C527361535957336F353557434E4162574B673449394D55485678576A424B784F5A69636A4A704E67644667394835556C306B3452435441794C586E4B486473366253393331646C6870356632577931674163366441725639327579384252645233646D662F3230385079736C42456F4935302F54383254376A33464E6E46674C626E5548382B64626F32734F5A5754414F4C632F72506430767A6C3942702F584A33554C2B463834654252514B6357794E48706847596864426F39727548785537782B4F64516656776B6E62486354684C733170716B6171756B796778425239796A335A772F647964363776466275764B52762B4C6C7862584F7679683863766A395446714C51555A4552734452716142694453566454307361764E6B546673796964595670386A71414B4F356D3043543048786B32504A70456B316B5171596546474F636C6E46634A6B657178466D6B716F365A57706A586373334A7A5170505A74525554555243594B6944454252454D4162417846506C765546392F32693650616932422B584F594859774C6F7149496D6B7445455576614F61514237665561362B30772F6E467A6C4D622F562B2F334F71323245484A456E37354547694741447175366C73486F324A574A47322B5375793333556B52525245635277765435415A467A4B444B6D674A33630A6B79717168544A766164504D4768504B3039724F4E704E37354A4D6F484761624C2F51477966564B3364473739336276376B373252724671595A6F72477157436F756C5A78427A4A63697934487A77544832535873743935656D4E733076396675373754505334737633595564744D4852714D4570746C5441484B7A6243746166617271616D54306D76744E4163705739505070394D573445636C683451357A5563464A67354D6A652B5759374C454C6E6A764D36616551775A6C4A59434A536345475A674F3038592B476D44552B4267344B46514F5363696C3838365238376437674A37655033396D6462552F'
		||	'31704B694C736D4252556A5742477277444D5447786336366430666E6C3770656558502F306D59767433446C4573684C6B67462F695555387733786A796D6C5A5656516E45324A5168467457537170715249766A637535794D504B73674D546E765131585864597761765073456739594141554F4A774D363551415154496C55583374755A665066396F2B2F644F4872765944597470556F573155536D704D6E42504A4E366C384269594C596B457355596C4554477065324E4A6D565A496A4935416A506F4D57547959787A2F4B6751464F3272476F455167714D765564395831515134733569514672356D44613844464467425557636C396A484A514C514667796741315A67436D70434758724A30634A57556B71574E4B617372634E43566767444552595936395A4D787A4D56566D6F715A7051564835714E51504873362B396572396E39375A763338384755534B4C676867556B50426347415038314672427766325A61327A574A764B765135447A67647461456A79793538536B73454A35636F684979334152683773774F77637332646C596F6D6345696B5A7430705749324C3253706B71515A564E38516B31616E3442584E4673464941734A7350424A4C3639646677663339723936585A356179446A365451614B357952597736647A43396B764E6A4F3271324D32597471724B74616256546273424174596D56574934417A596759705442344837636662533432544C53766D496D6F4D5659553231757653754E566D52726B68474C455261354D704E6567412F6B5559786E2F706D6E576E7152574247474179637762535A6E6845494B382B704379766A435049453042437A567747436C4D6A4434444950446644497A5A516262677A71462B39632F4B644E2B2B39397142344D4B6F6E4664554B4D6956434947356C7670506C75512B4F4F576C4C7A4B6F6B34797053593062696E574D5951386752636A7131462F736C64672F4D6D4F68734C332F3538734A5272594A4152716A35755450356862374C75536E58493274305A4B6F4A5A43524B4E5A704F0A367963493076616E7834345245786C67596D5448686236784D2F766A5633652F2F38486839735169676C637977444E3675567466624631596170316643477664724E2F4A4D2B394E74537A4B556D78336C7259473166686F4E6F4175392F4C634D376C6D56396E6A377648484339723545455242686D5932616D5A43446131484970544A5A32784D716F30346F6F4B616F523078356C69306A39685072716D575034542F6D486C5670776B536D5152675A69626E78456766655948594B52374C4444416C774D414E6C6347676F4D4E5A6576586534442B2B732F4F6439335A474B612F6877426C4D4F743474642F'
		||	'78364C39766F743961367256374C42795A524E307670704B6A327036456F79725950477776743446524A6A6468623973395154426E6769533476742F376246396147516D71657A5241376D34762B796B6F6E4F345546386877677057544B427165657A514875452B52574E44577442557341773878456B382F6532782F39786274482F386362783556664543716F6D74566867617865796533354E662F314639612F2B74544B732B7674705259334273514157314A3174446572622B375074726347313461543155572F34697450495646516F50553449442F57566A4A53632B536173527554455A4A48375245394A62614B594753314E334E707A4E496D5A41544844594C55414C4750336B356B4243456B674A5738415762525558525545537132364250617462576C6B3474364D7759546644504C4E33677A454976436B6C45673536516D52544A2F665776796E5465332F756139683466577451612F5255776D352F725A46793874763378312F63587A3751754C2B554C6245344D53526C463269335272456D2F63507A6F65706256754F304E683567775A2F2F49396777795579486D504B3276744A39664F4B7A666C59564D484D494F6756704F52442B797A5A41774F524D4C4F5A373664556B694A7A656954696C722F3451455041314569767A314B33332F2F2B472B764835594A6A494A563147556775394C6E33377979394D30584C317A5A79446358733457324377344D522B594D4D473947744F4779546E42586C764C5031637435774E6D466A427A7266446469446D7947696D6B644E53574C67694A5A70515277466C787564525A636C76733252344A5063496B7352306B5741494B4A6B634F637765614C61444F526D635A5547594F386F7A786A56656F45376D544D7050505249616978713275324D696C4B6143464A796970467171414B363446397139334B716531454B56427A64356D4A4B59675A526C4B44413467454B4A50546C4F71366E735A595570347A64316C624C70576833664C63597A567A383236726D52455A67557A5A544D69426D6C4B0A516A436B5278424149444353525759706C7A54456D5538756471375051795869524255674E707473704575647743364F33367741414941424A5245465578413473465245624F344E7A44567758436151674439496B56745263616C6D6D6D4A4C6C484E677A4F353835742B41546D7967676E676D4F4C5248557A4A66574D754B63553232354F59334D716B6255514E446E53716F305A2B30626D6C45674763534D724242736A665662372B37395A48733272467941436B784E6534462F39574C766D353839393674504C6C395961693931516964516345774D63686143612B642B716439365A69474C7462616337'
		||	'3761394E32635155494A35555352467056534A525A47597844513535754339397946333147494C5A4F5A6F44676C6A4B486B496B6B7045346D674B6238775571473352386277574F4A374A7242624151683457504449536C52546846523571484175304F786D78413469447330526167476F5159436B5A6A536B34583265754E73746D6B5973366C5446464D594B32413765447A774E3735376A426F6D67454234434D544578596E5947454C53416C525356554A6D2B784B6C4E56413932737834376272483032424657614D36367461577559476A47453746476461574343476C415A3374342B6566586538653339715A6C5271676A4F756442723652632F7466534E7A3537392B6E4F6233534245416F49537A32475070373368747564327A363331736E6B6E7A6B7949476E7731544776424E4F7134696B6654386D52636A347330715443757045675134697A33793577574F746C79507A76586B2F56657435577A75626B5969733070345671496A45733547645A37772F4B674C492F71656A4A46674F5742576D31757356764B2F5A6D4631684F723756344F3732677579675359555649374871623773334A6E556778475A566E52544A4A52576D4C7139685A582B7546736A38347339426479437134686F632F623667346F78635A5666545375747359306D4D584A724A79556457476837644550746842453276327A43396D5668624452613750445032796C4745794E6D45774E436F52546D4948565373655475446373646B62463852536A736B6F693752423875334E754956785A35504E4C624A51784F3043556E5445546A436D426E4D475A4563385279524244595851797148614831633549522B566B564D564B6B4A50727458796E6C532B3057302F30614C3348765A5A6A4A63384D4A444944584F4B6D423652475470696B6764696345674C6F464A4177372B426F6F774D33763039485662723273506A4A76614E374A3256557A737A45555476776B79765A4E313836382F7650627A793130664F7577647739476A5A5A634F67377A686D2B472B59564E520A4F5A52556B6A6B614B55775377657A655334744645565A31557359784A527A39544A664B2F54367564686F2B3032753335354B63755A66414F776855774B335234576430635446796E424F38384C4866724D6574624B2F616A574238666C2B3466786346784330766D31376D6650645675734E2F65475933565250616E364F46316558627134334433584479436E32687A63546156436241427A4346516D473531556434374C2F564678504B306E745756737932322F334D6D577571304C612F324E446E56646D69507A5151596F6A46514146714C446D65794E71723152504A68514C476554574E5A6D53336D2F'
		||	'3351377248582B78347863577164384A3763434E62447A6D6750494774444B2F615273374E314E67577375503374752B757A665175555376674C6A6C36664B532F6F746676666A727A32353241794365704F6D4D684272776841435168726E51454A3143316F31497A664E634851456D6B786E6447635A722B38566232386533396959505436716A516D6456716D4B73595A7137432B33576D56352B6353332F334D587738685833314C727673696471473047416D68796C7444394E31772B4C5632354D723230643368394D646B765A4731474C55353570467668734E797A6C34666B7A792F2F323179342F75394871657163774A69465945683058366457743066667648502F3834657A5753455946366C67364B72745A5775347558317270763369322B3939637A5A35623538574F7133305769453067426E62746F384C65667A683837656244487A3755613466785A4B6F576B31536C44394C4B6162486C6C6A72647A3131632B4A327279372F375443756638334C634B51596267474D516D51424A584F596B4259316B615643376E3930642F4F6A57795A76626B353178656A6964546D4C4D512F744D742F2F5A396662586E757A392F6D664F4B546F2B684D545232457959474B376A6A4D6955794A717871346D3657517062795636394D33336C357547724438636E78374E4254564D514956317138385A435A324E7438544F62693139355A76475A7A5778466C4D6A6F305754466B786C4A4E4754796B616E70584636445951346D664479753337697A647A43595648566C786B4A656A6461362F6774504C50797258332F79544F5962356173504A386A323453795A6B426A30434D34496F6F6E7772524E734855367550527866323533654F556C48342B6D347149746B74586D474C4F6130755A417639627250622F532B63484868563638756E653936463469687A754C42715072652B30642F2F4E362B49792F47765742584633486D3635655876482F3373507A576177392B644B2B2B647A6A69657661567035622F3356657674447A2F37363838334A7470580A594E566E635758506C5838336775624777757261696A4E5263754A616A4E7A6F4261355A566250726432526533646E38423975624E2F614832384E36734F5A395674686F2B334F3946746E5678652F38564C2B6C624E3270532B574C5A6A555A4D626B79486D79696F7A4573702F763653733378322F654F3770784D4A334D346A534A6D53347A7279363150375852662F486330724D583270383937793874556A41686778457273544E70304E722B777A34694D4B336B2F6E487878734E6966354A414243614E346A4A2F64726E39723135612F7378615A346D4E784A5459357144773567553069566E326F6362'
		||	'3158415742346669555A572B452B4D352B2B576476372F2F7439594E5238724F6971464E4B344B67516957706978672B4B2B6E446B62357A34317837364E376572333335363437656557642F7355794134674B5039374748397666663358726D35663239585270564D705334744A73754C537175436E4D746E4D2B38645A716E34394A6E64632F317A376278745A7070535A66364E336549767275332F354C3264375745386A70674B78596F73316734524F654B736D6F353139334230342F627537377877376D765072443637795170484A4C58592F534C38587A2B2F382F6366484832775830784D42724E55566B6271474549615A306D484A65384D596957793250572F3966524B446847516B417377516B4D6763515169654158585145356B51767644394366766248333335755461626E30796B794C574D5555794C617A656A354E5870754F3752346658546D5963327664487957655A526763696F78547247687A4965794D56715A5839336C5466336835392B3732747437654764776270574877716F6972554B4672636A7535674B6A66335A2B2F6365584474346370765033666D39352F66584F4F476645626D6B464B567A4D7A6C524472486A50396A4857343742644C524C4E48576F5037352F634E704957414363544A6E734B63326C6E377232624E727A6E4A715A48424F35654E4D6F4759756741686D6B446766427A495449526B656E42522F2B63614476377478736A32714A74474B5A44474B7071526D6F4B6A4567774B6A4B6F5752334E6B667633502F344B326468542F346C63756650744E64446D536D2B374E30383768342B2B475944576175453267387734386656744D373478392B7350664B6E6446413871497158537932526F7554326D5A312B746E32394353364641564A79616A626E3335785776714770746977474D7961477267774449767833397A61722B72347A74336A653466564C4D7055764A6D665475507564446F59465465503566622B2B4E627A53332F777774726E7A7A64757045594772314C3463484F2F2B4F3762442F2F440A6A654F7434396D6F7243644A5532316943725742326A6A4A37726836373848772F4166347974577A76333131387A6375646F6C6A41735263797743714366776F50516141635A4675486852625930775355794F6C5464774B37734A692F765572367865374C6C696930397177615852364D365A6D444B44344D4E576544393042596D68447A574E79753550302F75376B37613054796A6F74702B334D6456745A384F7A68553671487059786E61566F6E7257686E374363547459682B5A722F31334D7043356D653133522F4576336A373466632F324C75784D35684F59433558427278315769344C7A434A6D3161'
		||	'695152466A72576C57564548554B4A564A796232344E2F2F4C3630562B386533686E5A31596B646379396A433473396E4B586964537A736A3675346E345A6A306679674E4D4549624666612F764644746A696738487354392B666666767433626433706765466561655136496A624F58736D774566564B756F3470594E704F696E306C4133624650504E646F55534F5A68536F384D4749646F6279302F7654763769335A4D336436716A715A71616F53596738364858386A337669724A362F37413431704E2B4E70315746576E79426D6E4B5362486D394455596D7830583976725738442B387366326A442F613378326D63434D367674576B356334486444506E2B70426F55535650636E3161544B434C61592F3274703961577567474D425056514A686232704C56397044544336595570774B5379423650712B754730544342694D476C434B376A4C713932584C6978306B4278342F69697367536B333155376A65324C634B443454464F54494149797264484E2F2B766144346545736575383665566A4B586176726D53695A546D755A6C76566B4669584B73646A52304230554D63766244687466754E414C634A58794F4E7077566B464A6C576142632B652B652F33346346533964582B384D34704541705763755935694B536259714E626A5571524B4542567154614F6D4A4B7A4A344E79634636346756754C61624652585037693550796D7176654D696335314F4F3876677874456D303271714F6B3271316652674B45444D48562F6F74565A374966646B4D424F36635654387A516448662F726D3370733730316B736E6263736F383346627473374569324C2B724355335847314E346B37782F5730646952386F65764F726843485A6938786B496A55662F6757444B4D79336A7959445A4E5035496955564F424372355539735268653275793366545370795873474161774E45387455425149796B6A6E7379636842685A79416A43776E56575946472F4A614859463777626461744E6C76727931306C2F7664686262726356585578593244325163483958450A5271365249736E4E532F38514F653237363475564F783765505A764C447266476676487237316C4542633836707939444B664C66465A355A365861616755346E446D384E5143706262764E4850326B78426B51686A35622B2B2F76425058397539766C6372645A6C6C4B64656E462F794C5639615746724A5A586433644F6E353166376F376972505370686C2F373836786B48742B6465474C543843736650664238662F363356754851785243356A68475767682B765238326C6C744E795678456E49797259624B6C626D75686C54746D6167694A5462564A3169674B4E4339665163477345727132582F7A5A75'
		||	'30642F667A394F437241684942466243506C79762F57706A645A6D4C7A3863462B2F76543364474975554A703549355A6951563577546E7A4775446A494B44386533442B4E317265392F36325931786E6463753834365766667956733074504C7558645042745435386433442B3774543665466B4D743252765550336E39596A346566577571313870446C566D764B4851585079757A692F434C394B4E79576D634C49786B56384F4972334A304C477A47706D717261596834744C2B61576C334F6B45356F6E424D473277305742694D6C58416D4D6E50546561527A426A71414A69565174356A49656646746A2B3731446E667A3563376D5139754847333765504C67654C795871706E56596D355138334176306D7633313972302F475A334F5A447A336E7358324D53637764533071503133333934626C5479756E41386458302B494B573876724F526F6F786251517375666C4450546D677753326C6E7767513253694D30684F61526D31477A6B314443703959323778384668715A733966585A687464654F716A736E737A73376D4361667A4B417847643765476E6A52587A76622B39796C70617A767862534B3775382F4F50795431782F38364F34597966754D2B793039762B412B633346356F3974475367394F5A6D38386E4E796670444C52734B4C583770365132704E7232652B326C6C6358794247526B6349424E6F637873696D5246516D3755367672576C4F454A55764365572B78327A7254633836787A31744771673336526C454C465A4748465A567743764D5348597841446853306A676752336A756337307357324D6752734E4C3154367A6B6E3776512F654A7A4635396644553873684F56656E7565355978525674584D792B74366436727333543937634F755A554B647A394D662F6767623638552B5958772B357738743333626F784730364465664259704C65546C563539632B38627A467936746441504E764653613646725632782B4E2B7235363473794362336C314F7078563333372F364F3975542B344D6B70435231334E4C2B5A63764C660A78334C35353562743331576C7049642B743439593965762F2B6662673776374D63556E476839353244347262654F6E746F344D35796C3137596E75364F5930445958694D41322B3432725A33376A7163576E31305049576D61756A6A59723036336A6353734C7A323875654349674F4A6F4C4E54526B636159357334524D4F615744436233785950796A3277646C7970776E4D685656347461765831723833656457766E423565626D443053793965582F30662F3730377258444E4654506E45635655584B775241367162416E4B6F2B542B2B76556233372B2B5030546641674D3476394C35357164582F2B5854'
		||	'53356458517036355574706665714C2F563964322F76623637744855432F533430746350306739766E2F54612F73706D6E6A466253706F69564A6A4468306E54507761314A414A37706D6D56526F556B3855374E564A514D7A427539734E626D6A4A573442584A514A557667594930666E78487A764F46725941495A63534E346F6B6C38716C637966584A3935636D4E68533965576E687132533932386B376D41674557743062793033754462372B7A382F624264444B746F4D6C63652F736B33747964506A69634C4B355151484A4530544A564E72496B646A784E43703953366759387335342F7362547038726134374C6C6C33566A73376B396A7A7141594E5355477531537164424B382B6F79527749334B7055474E56547A677A65584F662B376979753838762F71565339787474777268375548396E58657A48393438764874554749786879667A4F4D503356577A73586C6C744C7665366F6B7466766C742B2F766E39392B3941546579664C432B316665624C2F377A3633394F5436326B49726A304C62452F32726433662B397632487232384E34554D4333526C4D2F2F3062397A2B313275726E6F644D6967413065616F397557674D51465A50614A455854357471456762755A572B30473551616A776D4C7A2F54637435667275354E587434574756424F5356324C524A6E554F6152676F63386F3175396A7458752B65585736304D424C7530326E7235756655587A72632F63334831516F3957636D356E47666C4151424A2F59636E31466E53692F474259446B356D30476C4B72634F70753759396547346C48396432377A68577941456942567859624F50545A2F752F643356317565324D4D374A4579756530505A6E6C486C5754646353496838663158372B786532752F4B4B49355575396D7A323332586E3536355574586C74666230714A55433162363261424B737770374A2F746A646159346E74617662682F664861335830512F4C6B4954556B706D795752664653786537762F6E732B684E396F70414472456B3031702B653555527570525663550A382B6641764F747556376D2B31334A6C49414867396D74772B6D445553564B6A62702F384C6979736643627A36352F342F6D56797975646B476B64646132544A5456352B2B6A74683256527756435A6D52465343453062714B6A544F77396E722B2B4D377837484B4A35496C6C703438557A2B683538392B2B4A36747452317A6A6C5433383234724363504279632F75516556574373666C75485676636D6E4C2F5175723262656D3545704646446C384445345A2F4D426B416571576D5A526A4A786858677737682B574F573268357831777265534B6553356945356E6646304752725A72433559757363774D47'
		||	'77396358575635343738384C4D4C713530726D36304E397249517559644F7A4B32734C6C4D2F565A67733732663353334C6C4F4268504B6C6C6431512F47466250725054596171674A484A7042744647566A42777572725A65504E2F35796C4D726C356443486E7969734E4B6D3879767467324B6F6F6B62656E444D6A30715371545A64567A6456774E566A6E6B6A6E5349456B75622F5A2B34366E56627A362F2F7453794F65656A3065566C36575A2B50497448347A53736C556956334B6A577478374F39696646786467616C766A42375A5072653857674D414952797A4F6237642B35757637564B367639546A7433586858725331724531655070374E62426343624F6B67794B2B71326436665748737963573237334D5052495338763841356D4B614A44565349584F4B766B6A75304773465957696A48394B6758526E54736E706E362B5250587475364E796F536E4C4F57515A5849794677634A6772646476755A3963375639536557657130735A7A4B35744A4A744C4B795A4C69396C466B675A44504C4A7945773859366D626662475858542B6F663354373547514D6C326F6D73706A643378734D5A3873436E36537447556B736B524C37505068574F3874377558557951636A68576779394441704C4C59655757544444795354653369392F654F506B7144514765314133717A39377476336C4A78625039526A454770307A4C4C62396C7A2B3165662B772B452F763730366E53634646744B3342384F5A4A74647A79726444783547757049636147504B52656A6F574F58387A5A356134686572506933456F66494661445159796F6F624131637166672B5234314D544E326675646B746A4D6F436947797141516D6132583479716557767662307967766E6538346F4575647354322F34566E6670316F6933682F76546F694948566757635A734535497356776C6E3579392B444F4949306A5130785A7A7662383538363176334A354B654E6F354A51344D4A3559436239797366662B33734B624F2B4D6F71736131754C6350782F634853335864377A70540A78385947694F446A5345624D4F78716B564B64556956434456565648554565706D33453763387975466D6E59747A5248446A61434A334D324C526B524F5872556B696177637873726E5A6358466E735732327A42675A73323962795A523473743939786D68327A7432396432647363576F376645416874576158386D77726D6867445579464D6E67464936492B6933366C637639662F32357A61382B76624765787A616267534D4856614C74555249316C356C6E5533557974546C7A6868532B4646656F55364A6D61744F34676A39375965464C5678592B65373746526D4C556776566166724858666E74722F4D'
		||	'3744387553775671654156534A62343351344C55646C504A7136562B3465505A776B6F52615A683639654F4E74372B564F724777734C6957414B5437726169693964364E383658503637473773374578636C56614C37553333333465797A5A3370504C4F666D353643542B636848795245706D33717432446C795441444D51784B704D6A4D7A515955424F4D634368565771783156384D456B374577424B61576845384D34387578535655426F665457466142524A6E5371706463453471304743656A5146533471696F685533566B62614364566D37544D6F4C6C704D6B72616F307253694B39514A66586D6A64486C5653524B4961745430595A583937363253685666334C7A32326363777374797051704D79476F67694A447A65374D5A6A382F484F306A4B376B3263577A646C553536666E50706D62574D36316B4B62584C4F4741717364486C7A7162585137783350707156345A55346B443435504E733873584F777A4B37456E63325157546B4C766A312F666E38336976336E787A4E4E6E2B316B7767714B42314A4343424F71626F34336E626650545A69755A4B716D534437772F6E4A314D45317A4F4A6772486C7270576666334A396A4F727A46615A4F696250786A6E73556766504C75443162746F5A7A4E685667436679524D524D5354456F356330486B354F706B7346376A53366333316936764C6D554D3453394754557449494E754C50592B6658374432774655795A447179613144657A42616E306271646F6735454C4F5A7770512B43717A66305041494271466F6B72546D56426B35597765466155574E4E6A4D6879317A4477575879436D4A4E444855754A324A54497257476C3951494169715943446E54616F594D766B6C4F42464243456B515253536B454D6B4937304F706976334E736B307242444C41514B72576167437A7A6E6E4D7449354F6F4D564A67753753596666584B346D382F7539594C634A777047554F4470536A4D6173774D4E6C4D78536377556D443242565255387131464559314A6C55695A316C47585A4D3039307A71380A7763365547525136596F396968634F56732F38723535512B47523249434B5654534A5071545376636E756E30693934364830796F535A2B523772613563336C683561713358664D474746634A494B3933382F474B2B306D33766A6C55354D7A5A792F4F372B2B50374A346863754D304D46444F6838354B4E4544484A6B4C553430483973716A444A48616C6257795A6B30544774534A55704B446F354437726F424C614A496A6B4D53305753736B5568594B4551586F6E6832486B774B596E494549714A43634F646B746A4F714469637972475253787A70464557567A4F654F7468365039385A674A6B7451556B'
		||	'726B435470584F3938493372713763476F334C475666697956785A7962576469616278317254382F4A6E4E467A59586E7A79547435695A504D7963434475616C58462F504B74544E476B6B7673745A74427448733166756A7A4D70786A777A4F472F6D6B41783261332B537A417348736B696D73616139516545764C4478397076505378633631497A65736F716D71364D33442B6939746546546F727A32352B4D4B5A33715856396E4937557A354E47703352584D72507948354236424A777A41444B56452F4B56455941546E56436C47584F4C6261364730756462703454444B514F4B735471434D4447596C6A724F6A4D787A5A716F345A67636330587573497233396F74706E59675349304C6130366E6332707439352B59524B546B30334663684834346D36594F39575453594F6D4B4372325A56504A6E566F306F333143475A6D5A4544702B61652B736544466B54455A434369344E6754537930684E77344D496B79547171696171575058714C45726E4946415971716D6C706959344F6255657030727842455477455135454157376F327072554F324E79326C5A544D6F3471625851514F7849306D773676586C513148576457784A4A36704A616774584F4E4B6D494352464D41366D79705A7A3038736261705A5865616A5A3350384663366F59624C4255635138756D5536627378557A4E694D43714B596B6B38535952624172487270766C6C2F7468745256676F666D305A43416C5433716D532B643731726169556D6445695869535A44444433696A74444D75694B6C79734D326830354331734855782F664F4F7735586B4D497943517359736932633248303167727135414B54466E30396748745455746941364C43672F4468794D634152326A3765534A4849472F7147564630556B6332705159517177705745486479392B524735387566577279776F7255357A33466E4D4E735A705A4F5A51514F784A7A434279515751557867524459763463427A76484D327550786838634654644838536A496B36724B464B726D6C6B574E45316A6656496E55320A394A4451546D5A47624152692B382F4E5453472F736E53484C76714278586B4A543268326B30693763483963307A647539532F4C577966336D3576646F4E4851396E426E4E3172654E706774536B545139455267562B644864774D704732315366474270655A7471784D774F32426A45704E6330797078456937457A4869713576354833356D5661354E7268324D783057426D4D626D33746D7237772F326268374E766E523535664E504C44322F32562F745553736A3531682F67545A75487A35664E5A7276395370714B5259565A4759616956317732554B6E3238347A35377A426C434C5063666B45574B2F6A'
		||	'2B32317642704D414E6F4B7843444D6E346E4755673146524A59435554456874393654363865336876576E4B6B6755496F44574D51326453784F326A5561587A6778326556476757307A5247674A4545786D44666A4F672B4474712B79657044634A6C6E4D70305062706B4D6268613169474B717A50514C4179536441325A566A52316754625A33366B62573142456F613932667858736E78665864796658647964336A32575179485A58314B47474772687143566C6B71746D63757154434A576D716D474D3655415A556F4B7362426B6D734557646C6F63374733334D36394B6369646F74775978446A4E7568766B4A6367704F586D4532345243456D74797349546D544B4F2B797A6462325549494D4538674A6F4F70475447776C4747745A5145704769757A4F56517173776F6E6B3351774B576F524D6E4F576B705370356A66756E38796D3031627745344D4267594141536E376E7144695A4A464F6C756643703751356E6737493241706D417942374E61525667552B3943336C37694D4651695A39546C6D4A536E4D5A3755556563515043697A5563354B357A72382B383873662F6E4B636C307A43544C455033707235382F65326E336C3172414B48566A46566756306B77597A7836594365584E6E2B75667648482F372B75374A2F734845386F7163516C53796B446C32716A526F57306A4B56516F786B59646A55782B6A6A7857676F52584F6266722F365574587A6E59662F506D37443336325037475353436A4773447630667A30382F504874306557336C2F37743531652B396E546E366D61376B2F5849554559334C6C6C4E5362305A6F7069702B2F474E77633976446C756B4D7864556E564D4A5049755752555053704A5735304462586A6C72756C48346363586B702F4D396675346A38414F2F613631737856684B59584E4A52566633647A666A5442354F6E507A6A3578745072662F6A733274584E6474376C53444C58644246543738324931456969684E426B716F4662456C673542596E525A556F5A2B3942714230664B53456F3074617A46450A6B7879465267485A766142584843697170365932436D7A38366F6371304972675463454A652F5A37672F7272596E7756706E4A7A476B30634D55642B436D6B736A684E5A6E424F3454586D6F4735536A6C72416562424367326C4865417071714C502F786372576D776F6F456D656F65347965442B71436D5447565242797466316A536F4E41556A546B714238436352534D79446A414C6947624E72465959464D6B5273544D6A493268364D437A2B354C334248373131662B74675642657056484C4A4A536278374C6B45693465306B6C695552454859577842536377694F516B33735654775158573561415A72'
		||	'674B3261766C534D316C35327145424B496D42435A42437A4B544A34356D716B49324A6A42426C4F5677465867714F7A4E4F616734706F374C2B35303879396C494F446C434D6A4A6C6475593657576931576A4F33524B494F4A564630674370566B616552536E4F6C643653426B782F45384B4D486F35397556775150346B6136466134524B644759456E457A7A2F4D6165716B2B716C49554169734852694B656A337738774B54646C6A32787A417565526B796D6D496B7A364D6B7362522F562B3650693345493743393752584D6D4C47523058736D435769616B5A7478613637537834553446465935447A7A6D664F45707363545055486479642F2F7672577A2B2B4E743463706169645231676E75584139584E726F586C2F4C56546D6746446C6E376734656A6E3934382F4F43676B7544566F43546B6E5A49706F6D6536764A7A39345763334C322B302F75624F385A75336877384F3633476C52537954747851524434622F2F6D63484E773757762F623075642B373275746E71684B6A4A4A6858566A4A31494A653365706E766572516F39525369517159454C2B79464145594C4C6C6C513152627A2B5662734F3358676A754D2F654737742F454C373532643750373139634F7445546D61694347522B4D724D624430666C724C7933502F3736382B752F6358583159702B5A4934484D4F5A766236566871616A63694E44592B6D736A4D6E4963796D54704E6E704E6A496E4C4F7147336B477548524A766E796D586C6E5641746E5275724D66445453524B616B694D6D5A65694D53546C704B7530577454414E4A6C6A4534687A6E54414361696A4F41495467697153706F4974744C795763675450424D375572626F5665512F53325839425A31486D6F755247306A366262652B32466C62576A71616C435346517977344F78684D746B2B4B76554C502B376C3770796F7861364F526E684349694D6A595145596542684E534A58492F764476393972583962372F33384E614A54716F6334706E54755956776361312F666E3178765A313357357A713138716D0A4141416741456C45515651376956583531782B4D626830576737495330366135705559417647736D762F47522F6E4D7A735A6C624266376E796E553758634176364D38536D666447755768497154497A622F436B6B434C543541304B4230664E315330475669494B6E6E31755A5A5753656841464D6B436A31797254696D414B3871514F4E617430632B754541417663675063566F6D59415A387A635A67637A4D31464C733779584C58617A5A4F54566765446F644F5444716B533630484A5062375133752B35346A4C46616263534D63575862772F5442776253623561736544447374314A694D4D6B72474A6D'
		||	'5143383834524F5458415A4B366F774E35426F736A396B2F715033396A2F2B77384F646763314B456557625378306E742F6F664F6C3836396D7A34634A69653758543672714D3236337676636350396759334436594A426A5A7A4E416463776B446F742B6E5A546D396A706257793248367133336C3365337A7A59485A726F4550524A4267553957766277344F5A4778537446726B76582B6F794E505047594B4E3549645A727556393959764871617561744D6E55325639736E5953384D6B48544A5663717132754A346162312F59544530674A466E4E2F4C31626E356C4B622B3035462F5A476C37664C2F65474E696F526B30786D36623370634739636A53514B39506566586C2F746166426B374F627441624C6F47704A3159786F67337051626E5570324C4759535936726D63472B7A374654623041677755724359516D70444143756772437961434262494733495947614A61424C6E7A692F37715276754A705A345058706E4E4F43516D4D6E4E6D524B7865474B615255306E456E7A2F6658576D484268664E4A6C43426652792B4763335644416D4C6E58422B755831787454637556474A42454C434D796E6833554C782F584735324F34315258344C4C35717239554468724E4A6442616F32757369573134374C2B776133426E37393763473372574E416E4472323276377A532B72574C2F52664F4C7A323576725457796E6F74396B35504A75563752376F7A4C496254524B446D736C493141724C674D383973497638553759766D79633831586B2F6A566B4147443367424E354B694D4B756B714F73714A575876366451307265464346636D4B4744304B495572774371654F6D5A437835647A34643575614F4B4B2B782B664F3961366537544946787477345453513154672B4F47584D2F5245466468466232334E6B656D657038634E6977664D784D457069574F75336E7A2B65586C317033446F766A556B45553243726A37526E39664874796472472F3241345A717A716E524777494270674A6E42685A696D524349495676594B574E6A4C776E6D31540A322F7437737231362F55366753453050453741735857762F4435382F386D786658484B5A4B6D566E754265717733714E32546D7252366F497A372F4A75724933454F516F52356C784B514B6354586E35363965564C792B2F766A4C3537342B4262312F4E724432636E3436686936706676484F7567654C423973762B2F66504F35334E4E53787A736E464E6E41784C545A6B662F784332762F2B73574E574539626F652F6D336330737A6D734538306E67324A6761655645484D5A69346C6C6D3931484E66364B393838636D5633337877384865336A7637797875676E4E7759574856476F4C5232553158666532'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'7A6F384F6A6E5857667A43706244574A3569787A4C576568437944454A795A52616B436B5363534D7A6848706B6E536144614C535A4B4A4D324D7A4955387742344546715A4955465657566332336C426D44766F776F52576C6E2B663766335A7332574A4D64356F4338526D586D32652B362B3164354C4E616F3339414B43414545513542674A6B6B597A635368524D704E4D54336F612F51762B687A4762667A426D4E494E6B41326D4767794748776E4141516D714336685A367265727172757261376C70334F6673356D526E7550672B5265653674526F4E6448476C6568736771732B363639357A4D6A4D79496350665033622F505A51306335785A4B634C6C764C7239366F666B76336C6A373731392F5668464B414656724267554B675651514569466A4232416B42564143457341306D4A455A714B6C4367536D616E6A632B58356A7849554D30512F544C546271366C4635665365346538474447426745776C4D42332B735650482F562B39564C4867786C4179633662692F3249434252376938776F4B444D42456B7746506A77592F65537A342F64322B715A4945704A454C69396B2F2B533174543938632B7636616A4D31564455304B4955546770544D704651703057654962496969696D694E7844655478424F47383764765A2F41437A6F5730493756645263732F2F3256316D466C5A4B7147784A30675946557778522B7470666A79646A6371796B336B5351544167416D4A6B4F35704E4473596A704C4B5674584B426D5267326D6A374A6B69547A5356554946777741335672622F625058742F373572313549665749534349485055666B62574242425A43496973416B5157356C594B5A6A457031377848694D35524344456C7366766647583933684232706750513071517768644D2B2F322F7668517664376E4C4C58657759677749364D3151444A454A454E69557545685A6D4D6F724E72446C49514A4D6B7A6662483974486A32635149424241685357433952582F775176666231356F4D4255694335474B42616D46306D74766A33437A4C4B4A0A3951454367444F675A41456B744955646B6A4F437742525A7937744E373867386232563636732F64584E2F5239392F50696468784E5642417054775A744837734F6A7966614376374B556B574D6F4149414D5954535A4851356D4A314E596272515657414851694D77596C535062437746614156555253526F55305A41497A42776973686D61504C5053616A6579477866582F334C6A3643653344323774395763466D43556C7076757A394165334439655731377564686A63464C434D644D4B74446B6B707149556E6157645A494845414F5A5642774534584845396B64797258437367614A6D53435342645953'
		||	'794438366E65344D7A4C4A6C737852566A4B7873704147394957595A58466A502B754F384841494A36327936323074334269686F4A415554457A706741765343566942346A6B7758674A796149584A695943566759535378565A63646150454C36796B69416C4958516F4178675731312B4E7650646E3536353241776357492B4355584A6650396F394D4D5039393563373778784B5674744F673643635634694174594F4E6F41445131414647497538647A67364773305930435574736E4A6A776239797366506447786375744A464143307743575749514249616C4876616E34356B414F6D59324D545168457754777A6E6C587739492F5A327A5039363162684675725659766E594D50714E6A4F7659424F524B5A695A7359695571444E4F643259796D42564C7A56515A49346B576D36486179564433687A41576A34494B6869424E4761316E7857616E737A764E434431514147616C6248396337702F4F42734E3866546D466D4B6B326E4374717A572F4B41454D6C707353416A427937686F5871573679717A35744F766E46743866564C5331734C445141565967444E5A394E62652B502F634850767232342F766E31536A416F777455723175446F2F4154733146454F72326134516A4643393438477350426A4D6771454347544B776136664A7861567376654D6A537A30616B4A55472B664659646E726C7754416F4F6B53486969724B48714E317A6D6459424E4C596A78614D544C735A503776572F4E61317854393863666D625639726B4244474153566C4B62784165396D66452F4F784B752B6D516D5942414A51796E2B7548652B4D4F394D614A48454B7772312B4D4E6F366B6942714263595A4B4C7159435A694F617A334E5459684B41776849553066576170385775586D6E2F34367670726C3176644668733545744B532B685039354768776B6F6443515530435775547A64305A6F565865615931787070517570417842415A2B67437547486764782F31392F73355966536C4541314C7862314A65656434756A384D67496C4243615A67574B495A4D0A6A4E33476E786A6F37485941435143614B6A426F33377877663730397546774768514E4B505A586768456747356B52674A567177774C7A6F474941524B414B6944466E43715A6633706F486465472F41686F734E3550584C33566533573675744249784E695779636A43653364775A6650396E6A393636652F4C674A4A3856494A484176424B4F71554E6B676E46525068354F4835324F48766247777A7845496C417A545232757476787A6136304652367947616F534B6F4F4E5A6548677965547771706B4C47695147614B716B344E44496A5245435376772F7A78656458637231484F53417A55314549534272'
		||	'7031476C61774B33393456357652674342724770323044417464666430756E73794C59304B704144456949734A7272523459394666574D78576D6D6E714545784D69314668487A304F372B34576F676152364B76756D744B59426B637977454A73554368714E4365313933367543523445414542544C6C2F6562482F3757726A3765504B586F3950535A56674B466D47692B4950334878794F526966363747396353532B3074656C6A503761485750414E61612B4161564244554A326E4E3544414A4A536879477361427862774F5758396B6B594664464E454D7243674567724E507A3255542F5A6E683731595865414E554257635133493644587259522F4A464936504D4552666B6E624133492B63415831317666627A52426A61316F414578594B4A6C66784A5337353966537A64544841554D6857685A444A5865756A66593642352F64627554345378786A676D524A52697247577159697375424A726B57733342786B516C705043745065734F56626A744C6C466941757979456D69633265575737383978477033747641455068306943554A556B7565534553553466696D4941636B4563456377706771417868617946646133754847726752532B6B4C38442B2B2F666A6C7463623131595A6E497A5656367566307A7348773574486B6146526943475A447768517445536E5130447461647534624736305057725233796F55316749756455666D334430352F2B4A482F7656637572486651673641573649694176626B386946486F352F7034624F744E584779346A49673078466F5141385551674D2B38784338456B632B5545375545704862696E3174762F2F614E7461507877636C6F584A42334F67436734784639372B33504A724F384E2B5533726D5772706B316E446B315253545871342B53416579657A672F3734345841796D6335693530416F5A3041774C6145496871676D6949716531474552536A73347A64393963504A3448484C777742533051416B45347446513155796C6B68657A434A5A564D2F336E6C7247645032442B5A2F3444425055470A7A6F7978424759415A674F5944753374753733584E685A65766253716F4144415A6E6D512F5346386574422F6444774542474A5551632B30326D34736470707233665361684F64583236666A3465505A7947537172764F33653248747A765331793057577559534A45626953314146565534417936436A58307A7738732B677A4D6A42416448592B35594D497358386F6474622B2B724D64746458787450657A3355452F6B46484759545A303775336466502F2F7676763257754F6C726661463554524C6F5A473179394B47307A416F37612F76484F32656A6869436D6743526B68504666445A647A657A716B6E'
		||	'657178717753796E4735682F4444542F6F4C71662F573556596E315544753852512B32702F2B4C32392F3974623977565359564D45526B6D4E696C77736F3368764F2F7532372B3466443057716E39637A71776F5757573269345A75725177755042374E626838433976393850556E43506C524D6748314A5A336E5951574D2F39484C3633393663336572524F3170426D4B3473375235416366506E62676E746C7550374F595847795661323374463334776F2F3555487033326268384F52374E7961794839783239736E3462776B7A736E662F374F335265336C792B755A4B766462487570756544494A50526E3462506838642F654854772B7A6C314A43674579357A72706171594C46444A5152383655475A47776E7551495A736F6876377261754C376558472F69775441334E455351556E2B324D2F78663339306A6B36382B76356F676E49376B7662336876336E337A7673505A6947584671475943675645536A564157576F497178332B33657362662F5078376F4F546644386E4D4E524139772F47332F75506E2F62483465584C617865585732734E793579556F65784E375751614870794F507A6B6337665479502F726173312B396B477836594652455153744A432B394E77483378536F304D674A5763447751305A6F6E356F59626E37393759486F356C6B706676484259717A526A32446F50397865332B4A7964323438356F6663477564724F564A696D57784B346F72442F566E544876506534464364313265716D624C44645363675654476168786B7376377536662F2F7433647231316475624B594E416E7A306E2B30502F6A427261502F2B6232446B306B4A5271414B456F69496E536676694D6741454A474A676970385555786275777047524667786151415249644835474E35694470655A6E484E6369755947614A51614E7A38366E6E372F67394E67366576504C572B325574487732656E344C7A37632F386E44596138777A4D637559565866644F3736617250527A4A68674C5A4866766246323244383548597A5570773774344C6A33772F630A6D615837383472584E357A63376C7861345136564A4741633479656C4250337936317A38645454764E394A2B2B735A30734A6D6A42735A43786D4E57317831436978655A424C3469726266763635617A2F3575576C644F2B2F37493532426955774261435453546B617A51616E6F302B4F5A3075644E43467270774D4E35535176423445666E7034656A517175774C536F547170464B4C6358473966585739734C79654F70464149454D4A754D33767230635A47486534634C4B783041675031526548742F2B73366E427764443865784C6B566F6A463033414650745465573933635076774B484870526E75776C'
		||	'767246746D383053414565393263502B7050506A67707A475670424774686A63794739754A7974744A4B6C70762F39567A59656A6D31533968384F436C4F5A356E726E61505476336A2F593342382B7338435857374461314E5051504D6E705A464963394565374A784D4766475772382F7576324E476F2F47427638754F483465357062376E6C752B316B61376C73736F484B754E43482F664C6A76556D7641454D77396B4461537558473174704B4D2F4749434D51616F3334446B4D6732696F434162725754334E6875763347703835382B50686D4B695A6D55326F5032573776546D52322B333575314B486B38444238646A4E352B314A394E4B5356477052497A7153796935555552516B6A59582B6A3437377834345654344A33663776566B5A7949384B2F4F424179766550506E6F637470646279366D6C48677578587136504A336259472B366454716346664F335A36584E72716255594E464C6F4D6A46706D426C396955354E564875794B4A53464341594A347355462F2B76504C5939467773336A54772F4C63533441596769486F3378554450624830453344656F5062435156555A42654354676F396E69576A30625354386373587375396379363473466A635061547778414A6D4B66586F382F644E33486E3136576C3561616A5964466157382F2B6A6F62783665666E593653356A55744241424D3352737945466A437A63674744395A3147572F6544787A512F7335507A6E6D564B4C326D4A45416956464352416D475356362B757A764D465738505A70754E724A543866712F2F3077657A2B7964615367717371705A367537535366766372612B73647A365464426E376E75595837782B76446D64772B6D437261564973487666782F2F326A3630616C635857317664354F75523555774C4D4C784F4F774D7972335469596F3874393461334E6A6337424A584B6D7441554331614253764D4D67426E79494A475746356364482F387873574F353061792B355037703450436A30574C55764A534876586B2F73534D50515A6F6B6A6D62716F614A5A610A70544A6E4F63494B59495271594D56696F73744E4C7257777476586C312B3532487661435371466F72527255636E4F366635322F66377978336E4A4F3950796F3948304B47696D2F6C4F5176756E51597A4E5541786D4171556F464E6766326D352F3270394F5143637530454B625849594632584153676769417036514A552F47514C7A626F6D637574357A5A614B79336679767A586E3176393744514D5A6A724C542F7242464747596C2B2F736E4E4A426679585274635161446762514751674F38396D736D4A726752724F78316D365571744E7063544C4D6A334A2F5043684D70386A516166665168417742'
		||	'6B73464D67716B6941616C7A36554A53507450464E362B75725853615349537172684B465536526751425154674A79326D462F5961762F576A6258446738456E6F374B66433552695458646E454861474A3238394F473237704465566F306D524A5870686F5948694476754661464E4D4153536F6A764E69466753516B4F453358727859417379472F6664503458526D73384B646C50513339796366486858747A475549374441516A42563645374A79716B453657584D306D55706F6762455A714247514A30724B66416238684E3934586B593834717567696F4149624255336B7A456F6B3778386363466E586B7A2F33436233546962544D6F695A6959364C4D4F6C4E764F59666D366842416236714E774930544E467379394A5334626D56317374623464625235505A73484B7755346632522F52383344323864466F764E6A4A6856594F2F6B61435A6874645675414A2B4D707232795645516A4C68576E68635A4F463669793046556C78666D78664D354A4E6A4E564652457A6E564D37784D386947704B7159564151564D6349784A6E6A7A535349554C386F66337A763550324433714A4C672B536E733146666C7178414247652B7A565A73646432626C31752F2B384A61743231456C6D5838796C62363352633368376D65446E63474F51594B457730336A384B64336B4572505730333032616171756F307A34666A796151514D5668744A3076747041687152754151494F43356D4A6141556F31746432704F383444656D4C71702F753672363973623752756639583730386437506469615067384F6B5454494148537434636B757A49674234597A4A4C77614E704B614A4B614B62456C43574D506B4F585846374C2F6F6666656648662F505848502F726B354E4F54307274456C6364352F7242583750596353476D6D6D55762F366138387639687974772F372F2F376467526F614A5948706F4A6965547365726C7255345166554B694A794A596939584449716D6C687452426D514776514C3835744C43743535642B70666675506A5356714F524D416D61380A62646658473076754B326C354D397548652B647A475A427749474A6E4D353057434252517978584D7A5056494136683461486261694578555568676A4D574230434953417853444D5467695167487071594B52517953433045336B7633743239593966766669725678593747537557684158365641414132476C4D534A61474769676C6745764C7A64393561587336532F2F74527A7366376652517053696E59465941376563704D78684170304666322F612F39734A576232782F3975376563497851656A45336F3341387930656C43484A77734E475333376D2B764E6C3639587366487637347A754739777A46'
		||	'6871676D4E52575A6A645A6F41464D6F42514C45674952526B4A6C314B5135744C42692F4F446164684E4A5A537654575751416F565552465656644D76494C4A67514455554557594359413167756271737958686A7662487836382B38766E58366F38394F666E7A76354E5A4F33396744456D684278517759314B56417A53524D545457676F6C4D546D785A6C6638774C4331642B2F39554F75665250692B4C7538537776475A414636625358392F717A4842457758637A38743634732F635A7A6D2B3838484C7A376F4A7A6B307877535652726E30702F6C70594B71717053686D426D6C55476E556D2B70384B453873576C45526B5341686A6A586934794B6971694A6D774B4677456849444C79454136487154662F2B467859764C433238394F76364C5733753955786736417259535547546342435746616534756237622B3063744C662F5471326B724C45596B436C4F41537732396361726239356C596E2F624F50657038656E66526E75584757693455386A4573466D4E5133544B555A4D4A4650576C6E6154496B5A784D43686F5272556C6859424749455941516B4A48434D4249714D7565583535697A734E2F2B7879637674672F4B6858486F3943627769395754344F5749494C67513063456A684B434A4D55516F74746F646C596166754C79396D4E6A66616C3555624459355073745531766232786657653638757A666536342B504A75565541704632584C4C59614730765A446657473739326654305964424D344F6C3373615649614A6154586C32444275375675362F652B756E46704177394878536A485351376A6F7077565252464B55764270316B7067326276566861586E4E37746676645439326F584F51674F5A444379677757714433726A513658702F656256393933433032353865546F76424A4D784B4553576946424653523632454F6D6C3371383350727252657662693431454264616E376E2B685A533269755361523779596A4B59686E467068624B4364307974784330332F47624858313575766E6C78385663754C533431484345670A4D4A4948704A6F376E4142416B62586D5A323079584F6D6D3333313574645878377A2F713778304E39346554635336695A4F53624B573630732B645830312B2F316E6C32632B582B30577A76654E6A735179486D53567575584730336E484F52657477686272525466396C5434703962613331794F44727046306654596A674C65576D6D446F77544A3430454D6E4A4C375779706E573131733163764C5857626D53454868476557334775625362666863742F415972536132664E72545A6336524B5959366C4346316B5175755A6767684E687A5341546D45596B416D6F6E4C76502F474D777572586665563766'
		||	'617476644865494838384B6E726A4970397859566953442B417A46514B5044496D6E68595175647450584C33576244622F5964722F3377754B53322F3770376D7A6E7444676435623263476367524E6C4B3376646A36796B6236787358576A5931324A30477665547678592B6F34434E6357726573436F4B464C317272744E793476546344482F70595537504A7971356B6C67736752473639494A674F7A6456765A3961336C7257597656797A526C324976724B5972545659694D72793435462F5A546A6548546442554F626D327376446D746155584E787058312F326C35657A75337552345850614C59674974784B524C754A4C7961726639327058754E36396D4E7A597958326D3278385145746A50336C59315735767A475976504F3439616A302F476A6755326D6556354B4C6C6F675A57695A77795442525A387374624E4C613633584C792B7374424B6E71716A41474168727A716F764F385267577572704A4E2F7254522B6454423664546836507930454F5530557856414D433949375A4A474E625347477A6E567863626C3163615735314777735A4A577749436D615434486437356366376F34384F6872766A3262416F454851356452653637656658327139665444757437485173642F6547377A30344F645A6B71754373754E4B797231396233313770446F49643955644867396E78704F7A6E3170755577306B2B4C556F697A4E4A304D63504E706C356457373636757243786B4C5663704F6E5875525964494172513062683865447139647A792B647A70355043704875515942516D62695A754B3654622F653571744C2F737069737257514E464B65435A354D5A4C6466486F324C77535166546164486F396E4A564D61435171376861446D6C4378332F7A457272387372436569645A795036755A494E417263527369676147474944325233627665487037722F6667614841364B334E42644E7A4E384E706938744A472B39554C69346C3339773548663333373864324A4436414A687736466C376158623278337269786E586974536155557142485A0A483561502B5A4F39342B50426B636A535263514746416F45316E485653616D662B517264786F647663584D77754C4B554E44324259474C7839652F2F572F756A52434B6175677A4A5A394F48716376624E3635767254642B672B43526A64334473422F39532B6469516977304C324F766E39342F474434386E752F33704D4E655A59476B6F5A676B454A764C73556F66724C586431705846396F3356746F3950797043454D70394E33446F6F37682B50646B3948524B41676C6D65506C706E74687658566A73336C354B576C3475376B336665642B37394F544D485864564D666236657A464E6665724C3130626C'
		||	'6E787A742F2F326E634F5245714352717450773675574E467939324C692F37784B714764674E41794574314E772F446E393861365069344D4A70686D676639326A7139666E6E783265306C427630506E35792B74394D666A71634B7A6C7979736444387873584F433873576742384D39494E48677764482F6350786243446B664C7241744E314A726D3873334E687562335330355651784A545731794242476B516E524649356D3872672F6533677975666C3431702F6B34326B354B6D54712F514A4B79316E576F41754E356C613374625861326C35727268416D6F414269446B7567703132305947596961686745536F453851756F78493278714B67414B6A6D50326A6843594B4B717A4F4B3732597A4E564B5A6D384765616C5455724A43594B4A71615A71546538547A2B7A556F3570614B4B306F61474A6349414242797444326C704B5A5943777846594D53494969564156535656496C514855704362615947596F4B416F6F4A7152444751704A69474252476C51694658794E5743676D716B676A41436459694A383454674344794251794F43574E635650555652446B714657476B5156346F7A645751705965714945646B524D6E305A75644B634B735141315144554F416A6B705A62425A68424B4E41547647564B476A4B6A684445487A6F68695043307061696952676F4E704D4B5858675345316A44355644644B4B676C7175576F64535A5941464F30436B676D42436F523067637051534D7945784D4E5A7370386E5157706945454E53434F48667665724E4D67523259477752676F6C6D4942795679312B426550556F4D424B6C4A514B4D5279305241557A4541464C48622F6D4345724F55586E43526F4F6D7734645777522F43674D566D2B575335364B6D3742797A456172336C4D626252696946706F586D775A4364534F6C4E4767376254573942673267527242534B3563367A6D585262507650494A476A423041646B5255537A674641474B484D464555454A694B4459596D6F34534E6D41796B4677733949737A4D41336E59497A6349346269510A4A42554369454A6E6C5A714149536F6246617770516D69584F78445257436F5973756C674551714B6942475A4F5A69576F70577561684A4A5A67496C706D5069316E624172654E317953494558355949356E414C504935326677564976574145776A35334B6B585A346E324A564D7A51514D684E4A357649425650566A73767172345955705646347469544558464342514D6A456941675A46494F504A65474A71426F53676F6B434553495A41694B4B6768637577706C7A6A394464414D34776F6946474958655964696B527943566B556A45483038784970364C674C3645506B4A5442455651424751774D5646'
		||	'48676D6D72524A716A742B786943484767514D6F6D474131566B4A67415350384D6D456D71345331616D5A6F56564F7975753363716D6F507144426E5169534E686B4543684F416F306E6F6A52476355564D45414B665969454A4A704C46534C4755654D737641316857315661304E314356384D346D707944545051754B6941484B6942436A73455241554B7745544538576D725267726E76334F59465447574155595A65624F36657441555142464267515170397241375642656C7653424B6968455A71456A6B6634744E52774178314B6835652B4D51316344557168496651674B55717639655441445A674949594D7A694D5652414B6D4169796F72474A68674347794B6D4267596C462B6C4372776B5641455742544179674470553642546343434D467438356F616D616D5A49454E386234627868435147745647466B4E6B4D5659384A49446B4C496358364371594B696F4B415A6C776C35435777574B656D644B494845576E2B4179766245742F5730536E62564D306444675050374C465973496F684135344C38696C374536764A7A424D4434657A4D30646248304643464F4F4E41594E4A4847425955575558746E5768456B4B4271536F57476C556745554D77357A705A456F48476443566A63366E36736968626D4956433176516566455436767948497A7632714B617762775A31755978554D57354832564D3438794C6A4C3559313749386A62614C416F72464776647154715055486F6F684D4B497A42424373557855535762374A6B79637A415973366B345149616A457479584E33434E414D32594151676173335548657851717A4D6E334E5831626C584D78566C5234786B61426262616245754E3677497272427956564142413444374D764859616F6C5761473074616C3839544753732B6C6B7261596F7A447632594F7A4D44514F616F556C52744F32694555424875613951414954414346554D6D52457846344F63414141376F5355524256444C44435076476159705959636C566833696347486A47335556516D617A6F54385672693970674A0A714B574F6D706C78466864553846695758386857686F676F57646D4D497130786C55484F6C626339415A67484D7A475253684E505543547A464E385A47686D426A5174796D6B7041667869456C4A795145696D544753477056682F556951616D7337537A46663277774442754F374A65786F7054324F5665734C5056327464666F57416E3375487075663563654D38533274475554413039424C44545554693675325241434949596741306749534D54554143424356797741364A4B6A4D2F4679754D4B554E6A514441513057434148417578716B6D6E5A456F776E7876345A4B6B41477249686834715A755672'
		||	'4D43416F675842483155757A365630414339616167616F4147444F4342714E346B77443246307074466B5378446A4A4D4C325A4156515145436741497741494D6849574552717977545442526939594D7A63504F5255465546574747376B53346C626F773137574D3037464C584246463045597869336959614C5456546B5249354D325242703178646769763370503466693530564162443855726E6E65536B7232466E793036712F434A48394534436A7832466E777652314635525A33543276574D38324249346C63715A73427152677A74434A633145736C794A70487245694359425850732F5358466E6F57425373426F70415472777A42464C446F6C436D6B6D67794B7A37647979656C4C4C62772B6B626153464943685641674F51516F4168354E484E47736D566E69584F307849526749734349514B6F4567436767554F65373379754E634774357664394A56623477535278736F32526E4F4870374F63736C2B5A5250544A674F5A74774C416A77554F4A2B487562722F6C776D5933323269304841495971414C4675685A38756B554C69465A56653864645436475753635235685A69464A3678733354734B74536F495675466354516B63613879694432754B566A5673455A41334267434B5632476F776D4C55796B58467553324E566435593151304445587336557A6D7037724761435A584F4155563738595246734A69594249724F59445868357064414D674E5171746D4C3637343073724F6964414D4C684142416C63547A4C37537A6C526D4D7063566777416252345459455253417A74736A2F344F5075546F69524B34635A785A517766744849464B753256716F7A714C34574F524F72704737502B62473174554E546D46504B494349796538624B42426B68687472306951516D786B6973686D424143683651335A794E3752667A306354545531554C627742567571494B6E7177456A45346F6E6B30624F6A504B4A6C48694167684154514769476C694D66474C64764563674E434D5641384236707A597A564F56597A324B786A4A666D546E72310A784167525946627452326167346E3068634F38342F4F426D3739624F635465687231395A6647617A4C63696D52735A4B57436938757A6635482F2F71306656562F4F3062793939384E6A46544249376244474F4E336F41613876354933726E662B3937503771347372567A66364D685773744A716F474E414473462B2B76484266376F336674417632356C647974593757656F38526771794F3465446633667A384E4D646D5A6C645738762B3055763677755A434E2F4565444B70492F4F6D466E68487272664B4A5A5074383370347630535938697753664A4633426338734261672B716A6A2F4A6175336B2B70'
		||	'794964554254793756565A4B39594D5841437A72572F61692B657A6E7462574F304E564A6E53714B4658587858505736313651466F46446C6758744E634234546E71304F6A56323978697835624B4A322F6C46306D3932336B74636F734257447756306E6B58414468695A4B3579392B7963437062464F507A734B6362344131414E30454C564C344A5277494E712B523272636450496B4153566445736B63546733504C5A355234444F392B6E61334E617965563947316D6A6E476E507256314637756842392F764F4F644E773935324F7059353835596C6564453757696651657265414B4D7A6D7745566A326F5A6F525674515455417A5777732F645A33517543475A6F416D434558496A756E6F7A2F37344B444A73724864586C744948626C4947416E73434746764F483137702F666A7530655457657656437830327263325149536A4743433943353869376F396C3765384D506476712F7662797933484A5A796B59552B2B494B70586365396A37616D77487A7978656157656F4E77534141347254452B3665542F2F4C6759444E644F52714832342B48642F6274346C4A7A776676596E364F414150793069785A727A37614F55334275654F73626E61746D317335546A554A555941665266454C5366504A68524A756F6B6857726E47574C377A56453370344B4C5146587A612B61636250474E2B6F56724759426953747738307A6A4462586D524979734731484F792B726B4B6365556F38336A564E417A6A4C663662525752315746613552585A7554415A48547A466D713269756E6F335135534B4A71304B4747735A59384149745562324961706D6D6B5647305A704B75553746677947344F4741535142536F2F59586F3156734E313156467A7342572F62615362474771504F486F684C44465670506F5A457539734278436C58502B3870337072492B6E596F364B7571393268685477357A6D556F79396C4676464350465047746D67445976704F366746483238474968473775375A782F79684C4A396570746676366573425942646F794941684251415A550A6B355031523736503775332F38787058662B73727174353562394568674A534B4153357A4937623354397834644C695135576C7346515A556479397A3067496E464A6E594D674876442F4746763173316176336D312B2F586E6C6C7A4B534B4136416442436B3838476557483561317664662F584E697777656F4151707A4456364265304D513238792F7464765848766E63486A3765486779674B4C51324634424947714D5A76776E662F496E5437466D315442416E413078344B664B7278573067475A6F586F584E4749426A74575A45306D706E42474E3443556F67614A486878537062584956587949614D68'
		||	'695A7149685A692B703441585051347A557255576C3074546B4F4C684356415968414D6C6563675734573652414D7A333245456F597A37496F4D525767776771654C5071645954415441616F7A454967386178524D6843494F71445769774969745250514A4848313852697749422F70372B6969494B675A71496767715952375159474A454F4D4A7043697077726D554A6C4339454969485A6E462F6E4D6942524C67414B794730622B496B31534A46463055777454613436796A46544B676F42546C77426955495459534B344A53426133464F4A4941325A414D534B4D51445667464546534944763664474C6C4573666949584D61585271426B776971736752415A6A4531596C61735866545A62694143684D4173416B527178656F3952734A564E6E526D6A557152546A6A474C427253416C544B306D526769737846484D4271516F4A71484D565671466B6C5243513151433242507A67656A5153373365784D423346357164544A6E4141706F68704E4A385A63336A322F7444562F626275596971777675776B716A37534D564D6C4C39554E6955724643466D37753964783730376F3270335578614361316B3243496A636B416567494B36673135354F43676161624C5777485A437747364B376D68592F756448672F2F7A7A756E7061646966327570692B3765757231316161626353526F4267427344344A556E467A3364415233536E776C44696A6C66446F455A5656414630746E6457753259566464626672644D77564A3354357337306D614E4453415245686D775249785143726642574F4D4F48712F75423641437A49576E314475644A7153706D4A74426F7666554D44713352717250514F48376534696A714435796E353635556C7145437043756434697278412F425555465331577945436F7A455A563130455A365465474575507170684143654C325567576F566B634931534F694F525146576A6E494E543546706D524346676945366C694651426B56516447716D366D776867714D6E343847712F525A56494B504E334432654A39717A6C51596E730A303944496F72744835325344682F4947426E7338586D6C34597154316E6C454F76767A7A76584B38382F346F55435650567345305648426B48694C686D766F6C6F7A5155586E43734351532F494134686B754C72582B795273586E452F6533786D3939636E6A764A69706751495749627939302F396766335134566E504A376A6A7344575538417A4D4F686D57554C4B3865475A7253724C4265626F4C30356E627A306B72577A5467314359716944496F5A6C6D3963374C79773063724676762F75386446517A45675532634A675767796E4A52714F685334747462352B756676385772766C455370326479616B'
		||	'703057507A2B504D64705944415979314D5A576A53664E436A447158426D646B57645532447A484E532B633870336C55724657625259786961593432416F6D68496B4253345948566E4463346C3162434F55586E334D5536383843784B68684342552F6E4866357A6B5779565361724D637278626D774E4E4D574C6973776D4C39616C72562F6C70553263527249726533336C5738506D756757616B4E53786D4269424D565074356B55635462423568734D3270664C586945346A66724A612B5171324A4445425231646C5647772B715662564E616B6131503270574C387736306B5A6A516F36706A476A7A434F464C7854426A6B46356849465A46425058556A6B724C674453507965755731726D734872674B5A7A34484A316773787172664E6458562F56454E534E4656503852356135314374513853474A6D6878755231704730414D7742464B6A6D6C4D41747154507A43356B4B6E305868344E486A2F776446765074504B477561643078422B655064345A3152776B765143373037675A474C547166566D4E7053514F6C70724D5A74556A702F35596137485578546B72322F35313761616C3566537A47522F4C416C4230306E6D386D37694E786163632F54575A38506A72326C766F704D5174727334474D396D65626E5A354A63754C6633476339305831684D796D65616C475872507358414837616E7A745067353347424F62566676796B2F79414F41636454372F37516F4F6D762F6F33506371383364656333792B6D7045516150364A7A3930533468647969737A50634C616B356D5954507A656B437561304A3463337A3158677A31477550486B432F4C6C6E3947577A475A346336424F49486949696B4A33374144396837732B4232352F374C30563338567A59535541593832466E6C7A38447536716549366933795850766C2B6276362F77376F7370372F764B42496E377847655A584F51746959413539787864553378764D765934767070696F4E7131712B5655766C35393456595250494978783236557A75454E4E4551417841304F692B3866356A0A2B364F76762F2B3066466F3873706D3974713178662F7273324977363239326B7565574F782F766A392B3831483374776D495A5A763152794567666E4A792B75327550686E7039712F30487279786E306C4E71435455445171466850427266327A6E352F6A416253416F76724678625372372F396F4E476F2F6E73616E716C62643937642F66746E644649345464665845596F2F757232384A4F54384B2B2F66616B335053456F7672725A2F4B4D333135355A624E342F4850785037337A323275574E317938735037505363453471536B6634727A6E77372F304A2F507565444C39676776353937674C2F333333'
		||	'792F374D446E2B61335477534D542F3049385174573142666152507A43536F696E75566638627A35426E7479336675366654334E6D2F415766783139553831452F475161674B6B597753426758472B377963764F6C7A655A7246357576624C58766E5953577435556D647A4C3831764E624E3961614E39617A73545248326C784B37634969636A38586445744E54786A4C53496B515046496E705A6375644965354774724759745A496D5268583234316D492B73326E506468596146313358773763323963586472716142374B4C58454F34634A53362B7658774B4E63586336364362517A586C76716474764E4C48584D6C6141513446505748762F792B4F58782F37386A467042486B4D7A6B644362376F2F4367467A6F705831684D317474756431426F3049617A566F71486562616177564A7142626D446F586E554270654430585155584C755A626E65397379495747684E594B665A6745486237525A3750566861623277752B342B797A7879464C6B6F564D506563663962676F62436D6C5A396362584536504A766D6F734F6458466F344C6D4A61616B58526253594B68507732336572626579746161764A444565435A6D43482B35614839352F494E64746D63686B596E45746842424E475967784277384B774945736343594F6C4A45452F516D49516268704B57686A786162325371614652556A4669415255796E514A3078414667513841534B715152696164366F70714939714C69434B6C6C4653417073596D5A574F48525A6B6D6D767145516D56304B414756583635614839352F414D3274656377774E675751794152726C4E465A4963495A71716D4C714A3869475345574561496E6B7742535146466B526A494B6745654977664959497151477959526F5166697168516355594449436C4B78344D43546B426B716D694F674F614F356F5A497047324B5539454545644F6649796E39352F504C3468336A6F655A5173686F74615A6172516F7278775662524E41424A7A4861686D484C45444E4851564855396443684954645256736A6B6759616161720A4D6A4B724D4470795A764E2F41684B434B68415959577A2F526D4A51415452674E496D464C67617873515942345038425738575543735343696D3041414141415355564F524B35435949493D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A202020203C456D626564646564496D616765204E616D653D226632223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E6956424F5277304B47676F414141414E535568455567414141556F41414141364341594141414457'
		||	'664242774141414141584E535230494172733463365141414141526E51553142414143786A777638595155414141414A6345685A6377414144734D41414137444163647671475141414170325355524256486865375A324C6B654D674449617672685355656C4A4E6D746C696376674245526942414745727958387A4E374F624253462B38476565797238582F6B45424B4141466F45425267582F51427770414153674142636F4B414A546F49564141436B4342696749414A626F49464941435541436752422B41416C4141436F77706742486C6D483749445157677741386F4146442B51434F6A696C4141436F77704146434F365966635541414B2F494143414B5735527635375057372F58762F2B53663766586F382F6378574151314467367851414B4D30314B554270726B6E67304D387241464361367749704B4F2B763536552B556E3834587770706E7663774F723648696A7866393333452F503573712B547A336C6E66763866727474726B52746D636A784E38756253395550674D4251444B47616F4F3262514679722F4850557A766E3363486F74766A6C6337322B54514C684479346C7038334350343962712F62736D6177514A546163372B6E344A524A75576847796D6E77556438586D6364527167423577584A4C706D34644A534A4C6F7749415A614E6738355062417558786761364D2B4E6148666B2B7A2F427765374B56654A5641366B505A5263674D75796273417657694B2B4A674835594176505230456F4F785237645138414F5770636B734B4D77784B4E7837306F304B2B4A6A544E56706431394C6A41774E4F4C674D462F3144336C7069505533616B4150395A4A34714F794C354957626B75543941654D4B4E766B55306F4E55436F4A715766474D436764564F3631626659306A516452365146336152344443374570474B75674C4E566A3042653966754174415A54366D725A6242436A624E5A75637779346F6E342F6A2B6D51717869484E3030487762393877796336485858337675393371686B78652B6C5A51387655593930572F637743552B7071325777516F327A57626E4D4D6D4B426359315A595144326B4F6135544848656C304932677449316C7A584152666250757A706574556E763572574B4D7331555071792B514F6B4A67484B4D2F564F31386151476D6846534966374945794872453958342F4D39447562686D3773754C3379393837305875466B4368773259544B674C446354735233424F633556724965614C396F644371445556725448486B445A6F397255504C5A417552344A696D344A376150432F587A6B4D674A6B307852480A676D34366E713562646B3639312B62493552583636477167363474712F77416F566558734E415A'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'5164676F334C357374554262726157376A492B50744A2F6859466A6D2B306F706437336D505873457951486D4A374B564378304570757963754F4E7773756D384F4F793136743363336A436A624E64505041564471617A706F635279556777346775796B4641456F4C7A5745446C4F735245677479575041426F4C5451436E5A382B484A516673697A7A344E7958516A6E72367374432F694859786F6476597475424277444A46544B3442622F577A2B6E6672666D6C5735414F44316C656747554864336F69374E63414D704C6E2F3143674A5674317936733257615071325744734E446A5A626D674B525762726C51576C4D7556736A747A5A396166615A4D392B49552B37492B4237473856656F327458675958434B48313834695354484346415A73725346336A754F41533979634E45734870416C422B4D665536716A5943797379524C494548567A3737355341737059734C43304E4A6249456B356F432F55625A794A534A73786561754677504B5053684134547862395A71596F4546433942686D2B463073677A746B33506F3539624D31722F6967732B2F736B684269414B576B362F784F6D684651306847594E4D697A6A57642F477A79534143767531396F734E7556464E6A684B4D724F72326654394C412F4B634B534344344C4151797839304D6D75614761737645323938343159416956336261333138336A577659662F326A2F30746B5A73626F33396D794E4B6153657351712B36764D464E31373468316D514E6C4E4C6E546669794E764C7362333069445636797A584C585577595A6C745376736A6F4E614643424863516C6D3056512F726B377654354741526579536D5645366231593178567931397469634D3247576973513677337A396C69756C2B5552705877715631383638646F6B6E6664415457375A673271626A356C7049745A6B39533151533141445A53312F2B766679564E504B732B39486C50475532633349566A4274645469774D6C6C626A5637554A457155587A4C63707545566D2F7A554F2F4F47457443626446762B4F312B3479384C4C314E76394433454D6B7846647269764D674E6F4D6D3633646D433557622B667A4A4E5031396C4B61633542624C744B3873706444425A5469355933516155492F796F5079354669545572485964445651536B6555486A436C4B6269645A332F316C675268795532726333736B385332782F4F444C42347557326C78384F553639447A635A38714D4932554D67374356684D79642B53337A5047715651682B30316D72786F44494353476648586169587249325651746F7A614E33385559303057376F320A2F362F3665336D38764E763977316E5A76612B7235763964414B62486A66617748585937443356'
		||	'3337374D64374C6E4677356D726657746F757679332B767136617649524C4E672B67704550763046512B644439706B36716A6F766262512F2B4855467A7847364263426D6C454C6B714E364850713641796245694653482B68746C3474427555395A6170474463725855574D647542715632724D6E61534E724E42576B6F54583979512F495647724B654D514A4B3462706B4749792F6C3979756650626A4E766442574F694A6B636F53554F6C345537535A4937644A51456B61684E346E4A584E374F6D526C5131374A576A2B6B6F6B4E6C4F7054326131784C4F65467A767A4869443664726E486D6359624E52677A69357052486C50684C707646387365356E716A69696E784A6F5576797863585878737A656A64643178576B6E65524556424B5337487A374A6343724B796E5A4E497670615050722F3937306C387053773662514D793579315135334D79523971585430746B42706539675061504A645245684D784D357971693352726D55782F6B36484775794E724C634B737845674A6438685162587763344135576D642B316A5178392F4D75564337337935614435526A78335038757062302F4630476752716770484573433275472B656C616D464E47414F754C65316D66786C4959523271556C674F716E66334C51566D74763430454E6B61554E725177346F554F4B4F5848633568714D394D5971556A5A70524E70356A5264626F6E6C696C695465356E3547326E4D744E76565266495647727730414756767439484D4231427171716C695377655538716C7633756B417574353574346F5746534F6E78356F733752376E6A7832566C674E6B456747554D70336D7067496F352B7262596430434B496B50566B45704F72725449583878793175583347486E394C5069636F44594E5942534C4E58456841446C52484837544E734370545477535576775773747061323057646D55544B7162665331376376613056457630646F47795361314A6967484B537350316D50784F552F665839724A7742674A31487074707243314332613661664136445531335451346A6D674C472B32764832516A6967484B2F307832594E75414F5848744A6D476F77436C686F71714E7334425A646E6C4431696A564E566362757A39676A6E72786852476C504C576D5A63536F4A796E6261646C4856434F48732F70336655654F3776704A614D6163454171704D6E657474414A755959525A5765332F764273414B573542745142355843314F733552797339753171347435734F6D3054727864366E702F6433336A5A6977413733556930366233653874472F7341355844502B6B6744414B0A57355A6A4D43796A336D487864556D5A4E4E35647069544D52442B4C314432556E592F31734134'
		||	'614C6C4E694C4E6737493935427133367A32764732487150553962755757415571375653536D7467504C3968557774477A72716F4B5268303967576F4865704E2F31576E326D6F4C524C637859386730794D39395159756E4B4F735A2B354D4156423243716561446142556C5650446D4231516874695944547538477148564968556C393654544E42364B4A622B3762765549347A707164494E67413642556C6250544745445A4B647938624A5A417563355A336452582F74584532694E4B7954337051356F51337A542F33537272433843485136742B4877397036654A6437316B39417143637057794C585943795261315430686F4435564A6E535969785852744E5545727553522F53634D476153647631686C7A62316966504F68626B4851596F54336E734B6F55416C425A61495A35723276737143414C4C326E716C4669676C3936537A61656A474467335246726754783477556831787265466E6F64696D41556C6650506D73415A5A397545334D5A4846464736325638664D72527335752B475061657444433047752B4857324E4D3179306C552B2F47355166647A6746513675725A5A773267374E4E745969374C6F4A785962616E70726B30597166464D757374476B70683644375361656C6141556C335355594D704B4F6B586A61552F39306366482F58796B76786E68315937753779737142685258744C586B6B4942536775745546796A42436A4E4E644770446747557038724E46415A51576D67462B41414657415541536775644136433030417277346263566F46384A765838644B787663754F48772F322B4C716C743767464A58543169444175304B414A54746D703263413641385758415542775767774F63704146422B5870764259796741425535573444382B4A34674B76723368674141414141424A52553545726B4A6767673D3D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A202020203C456D626564646564496D616765204E616D653D226631223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E6956424F5277304B47676F414141414E5355684555674141414C6F41414141384341594141414452353641304141414141584E535230494172733463365141414141526E51553142414143786A777638595155414141414A6345685A6377414144734D41414137444163647671475141414154775355524256486865375A33626C6134674449577479344B737832707335692F4745612F496F4A494C494C4A6E72664E775A696E677A6D634949546A4E6942386F55494543545158506945654541694E41427752'
		||	'564B414451717A417A48724A513048396A337A5A6A303454386138662B4230505872674241723532415370372F4936423334314346775961786135677A314E425A4D36445261786A376971593667463742432F4C7232776C7932786D594632594B2B376F43334D4F7648397567454856366E72596672364A55675035353042656F2F7A4D392F52366776393336376D49556F63756C78656151356176364F427A416F372F39785130623339435A4C424D7452702F44466765414A5A525A4D31596C6550564C6551423647446E465857554D797744643539464E3748766A4163755142714358595366794B5032673278363664544D7036324C4F2B33754154725A41346874716A644870487430595A6E7352546C454B504870695A6C6E6431516E3637726B356E766955523666482B69777A5262384A6F55743069644842477851413646477345465A6245314A2F673273324C575747417567792F58423349516F413945494D6857484B4641446F4D7631776479454B634546583279362B71426458323457724D2B74534348304A68386B456665693671644448567744454737765A7374375A767471345944554E30466D796665346D467568724E5A7678366B7165397754364A504A63713648534E6B43336D5457362F74763535454A64564E3036422F544A342F5A7A656249703637797164727335777559422B417A36556935364E67697476634E3258774F64742B4E7037336F2B677A373173526A3438716538756E5547364C2B2B33302F70754A365937787963664C474B4E352F4E3635775A4C62674D64665767456D6B4D6F484C51533678624A3450753861786535576B652B506D466F6258334F59382B51303672527651354852585131524952584C66497559384B2B683632624A337870314933647052347170744A746E79507669374F4E665335426A33636B596A7131724D566942464274384F57486657673666442B4C587A32364A79332B4175687933706D6B314F63355A464D7736502F6A382F586A6B496856676A4236445151514E2B2F6A324B4C626839495A526E6A5049446E2B4A483669475848364E367957616F45317655616F452B3176504D685A4648640A75754973465359484166537742743932565637515A656D38315A7372784F613032546330362B4C736F345236394730776C3535397A655A743655755741335535424F6A5233737A4E47374E6E4B565644483463715444556765307A6E685A587A42545471596E6D447A3836455755444F69784C4239326C4F6C67586F30554366567769433963742B65454A6A465272314B51574E72792F7A2B63577A393264306B68332F30737A34436F4441614F7A466E363950313750706A757339725733686D667652704F'
		||	'332F41443351566E6C6A644C3548503861744557616B506767536142777A352B337033325069676B635031322B2F4571417A52457436792F494E6D714F327966362F364F77725976523064727A7A364C65666E7241386E595A48542F6645394A3532734657794B316639597A464B74777A68446F33515261654B6B7A446F784A667165653237675150306147613939396A503363624F757368792F4E763435656D2F51366559425863412F5A6D345846636F3539487478776A5038543976486B6E6C675565584B6A6A666E3363784B6E73452F5A3152462F626E2B422B6779327959374F3653515439324D352B4270417361746E3534416C30657572685A462F7154684E79423043564570597A587241614B6B4A48514B4E6E6C664A37364C4B59766A783544626F4165513158644E6C555069783944302F486F3070314C3338366F726E784C61774139687172366255616F34583446364E35614633333541486F4D54574F3171517A464730426651702B596163584E4750446F7362434D314B34305646676E63757450746B675775714C555949525A366C70306742344A534452377130436B64516441442F72376B3953444134435A705542535431357436484C33765847417A674B58636850317542326C3766737035507731694F386476464254436730567263446E592F5369725950425578536F2B302B6B5535544374555572414E434C4E6838476E3169424A6E462F3641344B5A4645416F476552485A326D56674367703159632F575652414B426E6B523264706C59416F4B64574850316C555143675A3545646E615A57414B436E56687A395A56486744354165636855657A44314E4141414141456C46546B5375516D43433C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A20203C2F456D626564646564496D616765733E0D0A20203C5061676557696474683E3232636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D22454E434142455A41444F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224C4F474F223E0D0A202020202020202020203C446174614669656C643E4C4F474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2250414741223E0D0A202020202020202020203C446174614669656C643E504147413C2F446174614669656C643E0D0A202020202020202020203C7264'
		||	'3A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4954223E0D0A202020202020202020203C446174614669656C643E4E49543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224645434841223E0D0A202020202020202020203C446174614669656C643E46454348413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D425245223E0D0A202020202020202020203C446174614669656C643E4E4F4D4252453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244495245223E0D0A202020202020202020203C446174614669656C643E444952453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F5F4944223E0D0A202020202020202020203C446174614669656C643E5449504F5F49443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224944454E54494649434154494F4E223E0D0A202020202020202020203C446174614669656C643E4944454E54494649434154494F4E3C2F446174614669656C643E0D0A202020202020202020'
		||	'203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C4F47494E5F5553554152494F223E0D0A202020202020202020203C446174614669656C643E4C4F47494E5F5553554152494F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44617461536574313C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E454E434142455A41444F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22444554414C4C45223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224954454D223E0D0A202020202020202020203C446174614669656C643E4954454D3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449505244223E0D0A202020202020202020203C446174614669656C643E54495052443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2243554F494E49223E0D0A202020202020202020203C446174614669656C643E43554F494E493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E'
		||	'537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22565244494645223E0D0A202020202020202020203C446174614669656C643E5652444946453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44617461536574313C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E444554414C4C453C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22535542544F54414C223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22544F54494E49223E0D0A202020202020202020203C446174614669656C643E544F54494E493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22544F5444494645223E0D0A202020202020202020203C446174614669656C643E544F54444946453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22544F54504147223E0D0A202020202020202020203C446174614669656C643E544F545041473C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020'
		||	'203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C4554524153223E0D0A202020202020202020203C446174614669656C643E4C45545241533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246494E414E43494143494F4E223E0D0A202020202020202020203C446174614669656C643E46494E414E43494143494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44617461536574313C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E535542544F54414C3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D224341525441223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224341504954414C223E0D0A202020202020202020203C446174614669656C643E4341504954414C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22494E54455245534553223E0D0A202020202020202020203C446174614669656C643E494E544552455345533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020'
		||	'2020202020203C4669656C64204E616D653D224E554D43554F5441223E0D0A202020202020202020203C446174614669656C643E4E554D43554F54413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22565243554F5441223E0D0A202020202020202020203C446174614669656C643E565243554F54413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225458544241525241223E0D0A202020202020202020203C446174614669656C643E54585442415252413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F5F4355504F4E223E0D0A202020202020202020203C446174614669656C643E5449504F5F4355504F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225245464552454E434941223E0D0A202020202020202020203C446174614669656C643E5245464552454E4349413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C49444F223E0D0A202020202020202020203C446174614669656C643E56414C49444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225458545F4D454E53414A45223E0D0A202020202020202020203C446174614669656C643E5458545F4D454E53414A453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A54'
		||	'7970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44617461536574313C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E43415254413C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2245585452415F424152434F44455F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4445223E0D0A202020202020202020203C446174614669656C643E434F44453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22494D414745223E0D0A202020202020202020203C446174614669656C643E494D4147453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E427974655B5D3C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44617461536574313C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E'
		||	'45585452415F424152434F44455F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22534F4C49434954414E5445223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434544554C41223E0D0A202020202020202020203C446174614669656C643E434544554C413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D4252455F534F4C223E0D0A202020202020202020203C446174614669656C643E4E4F4D4252455F534F4C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E427974655B5D3C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E44617461536574313C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E534F4C49434954414E54453C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F6465202F3E0D0A20203C57696474683E32312E3735636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E31636D3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313835223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F783138353C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E37342E3431'
		||	'373939636D3C2F546F703E0D0A20202020202020203C57696474683E31362E3933313232636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3231363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3637333238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215458545F4D454E53414A452E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313834223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F783138343C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E36322E3631393035636D3C2F546F703E0D0A20202020202020203C57696474683E31362E3933313232636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3231353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3639373039636D3C2F4C6566743E0D0A2020'
		||	'2020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215458545F4D454E53414A452E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D6167653132223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C46616C73652C54727565293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E35352E3339313534636D3C2F546F703E0D0A20202020202020203C57696474683E322E3135303739636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E3231343C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6566696761733C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C496D616765204E616D653D22696D6167653131223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C46616C73652C54727565293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E36372E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3135303739636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A2020202020'
		||	'2020203C5A496E6465783E3231333C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6566696761733C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313831223E0D0A20202020202020203C546F703E35312E3338323238636D3C2F546F703E0D0A20202020202020203C57696474683E392E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3231323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22432E432E20222B4669727374284669656C647321434544554C412E56616C75652C2022534F4C49434954414E544522292B222044455F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313832223E0D0A20202020202020203C546F703E35302E3838323237636D3C2F546F703E0D0A20202020202020203C57696474683E392E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67'
		||	'546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3231313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D224E4F4D4252453A20222B4669727374284669656C6473214E4F4D4252455F534F4C2E56616C75652C2022534F4C49434954414E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313833223E0D0A20202020202020203C546F703E35302E3338323237636D3C2F546F703E0D0A20202020202020203C57696474683E392E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3231303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4649524D413A5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313331223E0D0A20202020202020203C546F703E34332E35636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456A656D706C6F2032202843C3A16C63756C6F206465206C612063756F7461206EC3BA6D65726F203220656E206164656C616E7465293A0A53652072657175696572652063616C63756C617220656C2076616C6F72206465206C612063756F7461206EC3BA6D65726F2032320A413232203D202432362E39333620282031202B20302C32252029203232202031203D2667743B20413232203D202432382E3039302C30302E0A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313332223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E34302E3339393436636D3C2F546F703E0D0A20202020202020203C57696474683E302E3039383434696E3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E4D61726F6F6E3C2F436F6C6F723E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4D61726F6F6E3C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3170743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C5061'
		||	'6464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3039383434696E3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F44452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313333223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E31352E3930373239696E3C2F546F703E0D0A20202020202020203C57696474683E302E3039383434696E3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4D61726F6F6E3C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3170743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3236313938696E3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3039383434696E3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F6E766572742E546F426173653634537472696E67284669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F2229293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E61'
		||	'6D653D22696D61676536223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E34322E35636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E3230363C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E66323C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C496D616765204E616D653D22696D61676537223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E3430636D3C2F546F703E0D0A20202020202020203C57696474683E322E3135303739636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E3230353C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E66313C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313334223E0D0A20202020202020203C546F703E3339636D3C2F546F703E0D0A20202020202020203C57696474683E332E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C546578744465636F726174696F6E3E556E6465726C696E653C2F546578744465636F726174696F6E3E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C65'
		||	'66743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3530323634636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321565243554F54412E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313335223E0D0A20202020202020203C546F703E3339636D3C2F546F703E0D0A20202020202020203C57696474683E302E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C546578744465636F726174696F6E3E556E6465726C696E653C2F546578744465636F726174696F6E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3530323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E554D43554F54412E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A'
		||	'2020202020203C54657874626F78204E616D653D2274657874626F78313336223E0D0A20202020202020203C546F703E33372E3735636D3C2F546F703E0D0A20202020202020203C57696474683E322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494E544552455345532E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313337223E0D0A20202020202020203C546F703E33372E3235636D3C2F546F703E0D0A20202020202020203C57696474683E322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230313C2F5A496E6465783E0D0A20'
		||	'202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E24303C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313338223E0D0A20202020202020203C546F703E33362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3230303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214341504954414C2E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313339223E0D0A20202020202020203C546F703E33312E3735636D3C2F546F703E0D0A20202020202020203C57696474683E31362E3734373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E6754'
		||	'6F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E32353533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214C45545241532E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313430223E0D0A20202020202020203C546F703E33312E3235636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E32363732636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F545041472E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313431223E0D0A20202020202020203C546F703E33302E3735636D3C2F546F703E0D0A20202020202020203C57696474683E342E31353038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453'
		||	'697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3735323634636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F54444946452E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313432223E0D0A20202020202020203C546F703E33302E3735636D3C2F546F703E0D0A20202020202020203C57696474683E342E31353038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3530323633636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F54'
		||	'494E492E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313433223E0D0A20202020202020203C546F703E34342E3536343831636D3C2F546F703E0D0A20202020202020203C57696474683E32302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E352E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456E206375616C7175696572206D6F6D656E746F2071756520656C20737573637269746F2064657365652063616E63656C6172206C6120746F74616C696461642064652073752064657564612C2065737465206465626572C3A120706167617220612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20746F646F73206C6F7320636F6E636570746F7320717565206C6520616465756465206861737461206C61206665636861206566656374697661206465207061676F2E0A4C61732063756F746173206D656E7375616C657320646566696E69746976617320696E636C756972C3A16E20656C2076616C6F72206465206C6F7320696E746572C3A97365732063616C63756C61646F7320736F62726520656C206361706974616C2C20636F6D70757461646F732061206C612074617361206DC3A178696D61206C6567616C20766967656E74652C20736F62726520656C20656E74656E6469646F2064652071756520656C2073697374656D61207061637461646F206465206772616469656E74652067656F6DC3A9747269636F2C2073756A657461732061206D6F64696669636163696F6E657320706F72206C6120766172'
		||	'69616369C3B36E20646520746173617320646520696E746572C3A9732061706C696361626C652E0A4C61206D6F726120656E20656C207061676F20646520646F732063756F74617320636F6E736563757469766173207065726D69746972C3A1206163656C6572617220656C20636F62726F206465206C61206F626C6967616369C3B36E2C2074656E69656E646F2061206C61206D69736D6120636F6D6F20646520706C617A6F2076656E6369646F206120706172746972206465206C6120666563686120656E206C61206375616C2047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E2C206465636964612070726F636564657220616C20636F62726F206465206C6120746F74616C696461642064656C2073616C646F20616465756461646F2E204C6F7320696E74657265736573206D6F7261746F72696F7320736520636F62726172C3A16E2061206C612074617361206DC3A178696D61206C6567616C2E0A456C20286C6F732920737573637269746F202873292C206F6272616E646F20656E20656C20636172C3A16374657220616E74657320696E64696361646F206175746F72697A6120286D6F7329206465206D616E6572612069727265766F6361626C6520612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E2C207061726120636F6E73756C7461722C20736F6C69636974617220792F6F207265706F727461722061206C61732063656E7472616C65732064652072696573676F2C20656C20636F6D706F7274616D69656E746F2072656C617469766F2061206D6920286E75657374726F29206372C3A96469746F2C206375616E7461732076656365732073652072657175696572612E204173C3AD206D69736D6F2C20656E206361736F2064652071756520656E20656C2066757475726F2047617365732064656C2043617269626520532E412E20452E532E502E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E206566656374756172656E20756E612076656E74612064652063617274657261206F2063657369C3B36E206465206C6173206F626C69676163696F6E65732061206D6920286E75657374726F2920636172676F2C206C6F732065666563746F73206465206C612070726573656E7465206175746F72697A616369C3B36E20736520657874656E646572'
		||	'C3A16E20616C207465726365726F20636573696F6E6172696F2C20656E206C6F73206D69736D6F732074C3A9726D696E6F73207920636F6E646963696F6E65732E0A4173C3AD206D69736D6F2C20656C20286C6F732920737573637269746F20287329206175746F72697A6120286D6F732920612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E2C2070617261206C61207265636F70696C616369C3B36E2C2075736F20792074726174616D69656E746F206465206C6F73206461746F7320706572736F6E616C657320636F6E74656E69646F7320656E206573746520666F726D756C6172696F2C20746F646F7320617175656C6C6F732072656C6163696F6E61646F7320636F6E20656C206372C3A96469746F207920617175656C6C6F7320717565207365206C6C65676172656E20612073756D696E697374726172206F207265636F70696C617220656E20656C2066757475726F2C2070617261206C61732066696E616C696461646573207920656E206C6F732074C3A9726D696E6F7320646573637269746F7320656E206C6120506F6CC3AD746963612064652074726174616D69656E746F20646973706F6E69626C6520656E206C612070C3A167696E61207777772E6761736361726962652E636F6D2C206C6173206375616C6573206465636C61726120286D6F7329206861626572206C65C3AD646F2E204173C3AD206D69736D6F2C20656C20286C6F732920737573637269746F20287329206175746F72697A6120286D6F732920706172612071756520736520656E76C3AD6520656C2074656CC3A9666F6E6F2C2063656C756C617220792F6F20636F7272656F20656C65637472C3B36E69636F20717565207469656E65207265676973747261646F2C206369746163696F6E65732C20617669736F732C2070726F6D6F63696F6E6573206F20696E7669746163696F6E657320636F6D65726369616C65732C20656E206375616C7175696572207469656D706F2E0A506F72206578707265736120696E73747275636369C3B36E206465206C61205375706572696E74656E64656E63696120646520496E64757374726961207920436F6D657263696F2C20736520696E666F726D612061206C6120706172746520646575646F72612071756520647572616E746520656C20706572C3AD6F646F2064652066696E616E616369616369C3B36E206C61207461736120646520696E746572C3A973206E6F20706F6472C3A120736572207375706572696F72206120312E3520766563657320656C20696E746572C3A9732062616E'
		||	'636172696F20636F727269656E74652071756520636572746966696361206C61205375706572696E74656E64656E6369612046696E616E636965726120646520436F6C6F6D6269612E0A4375616E646F20656C20696E746572C3A97320636F627261646F2073757065726520646963686F206CC3AD6D6974652C20656C206163726565646F7220706572646572C3A120746F646F73206C6F7320696E746572C3A97365732E20456E2074616C6573206361736F7320656C20636F6E73756D69646F7220706F6472C3A120736F6C696369746172206C6120696E6D656469617461206465766F6C756369C3B36E206465206C61732073756D61732071756520686179612063616E63656C61646F20706F7220636F6E636570746F206465206C6F73207265737065637469766F7320696E746572C3A97365732E0A53652072657075746172C3A16E2074616D6269C3A96E20636F6D6F20696E746572C3A9736573206C61732073756D61732071756520656C206163726565646F72207265636962612064656C20646575646F722073696E20636F6E7472617072657374616369C3B36E2064697374696E746120616C206372C3A96469746F206F746F726761646F2C2061756E206375616E646F206C6173206D69736D6173207365206A7573746966697175656E20706F7220636F6E636570746F20646520686F6E6F726172696F732C20636F6D6973696F6E65732075206F74726F732073656D656A616E7465732E2054616D6269C3A96E20736520696E636C756972C3A16E2064656E74726F206465206C6F7320696E746572C3A9736573206C61732073756D61732071756520656C20646575646F7220706167756520706F7220636F6E636570746F20646520736572766963696F732076696E63756C61646F7320646972656374616D656E746520636F6E20656C206372C3A96469746F2C2074616C657320636F6D6F20636F73746F732064652061646D696E69737472616369C3B36E2C206573747564696F2064656C206372C3A96469746F2C20706170656C6572C3AD612C2063756F746173206465206166696C69616369C3B36E2C206574632E2028617274C3AD63756C6F203638206465206C61204C65792034352064652031393930292E0A0A5061726120436F6E7374616E636961207365206669726D6120656E205F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F2C2061206C6F73205F5F5F5F5F5F5F5F2064C3AD61732064656C206D6573206465205F5F5F5F5F5F5F5F5F5F2064652032305F5F5F5F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313434223E0D0A202020'
		||	'20202020203C546F703E34302E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456E20646F6E64652041203D205072696D6572612063756F74612064656C207072C3A97374616D6F2C2050203D2053616C646F20612046696E616E636961722C206E203D20506572C3AD6F646F732C2069203D205461736120646520696E746572C3A973206DC3A178696D61206C6567616C20766967656E74652070617261206361646120706572C3AD6F646F20646520666163747572616369C3B36E2C2047203D20466163746F722064652063726563696D69656E746F206D656E7375616C206465206C612063756F74612C206573746520666163746F722065732064656C20302C32252E0A4C6120666F726D756C6120616E746572696F7220736572C3A120757361646120706172612063616C63756C617220736F6C616D656E7465206C61207072696D6572612063756F74612064656C206372C3A96469746F2C206C61732063756F746173207369677569656E7465732073652063616C63756C6172C3A16E20696E6372656D656E74C3A16E646F6C6520756E20666163746F722064652063726563696D69656E746F206D656E7375616C2064656C20302C32252E204120706172746972206465206C612063756F7461206E756D65726F20322C206C61732063756F74617320736572C3A16E2063616C63756C6164617320636F6E206C61207369677569656E74652066C3B3726D756C613A0A416E203D20413120282031202B204720294E202D20310A456A656D706C6F2031202843C3A16C63756C6F206465206C612063756F74'
		||	'61206EC3BA6D65726F2031293A205061726120756E6120646575646120726566696E616E636961646120706F722076616C6F722064652024312E3030302E3030302C3030202850292C206375796F207061676F206573207061637461646F206120373220286E292063756F746173206D656E7375616C65732C207061726120756E612074617361206DC3A178696D61206C6567616C2064656C20322C323825202869292C20656C2076616C6F72206465206C612063756F7461206EC3BA6D65726F203120736572C3AD61206465202432362E3933362E3030202841292E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313435223E0D0A20202020202020203C546F703E33392E35636D3C2F546F703E0D0A20202020202020203C57696474683E372E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E736567C3BA6E206C61207369677569656E74652066C3B3726D756C612C2061706C6963616461207061726120636164612076656E63696D69656E746F206D656E7375616C3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313436223E0D0A20202020202020203C546F703E3339636D3C2F546F703E0D0A20202020202020203C57696474683E31302E3135303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E327074'
		||	'3C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E362E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E63756F746173206D656E7375616C65732079207375636573697661732064657465726D696E616461732C206C61207072696D6572612063756F74612074656E6472C3A120756E2076616C6F72206170726F78696D61646F2064653C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313437223E0D0A20202020202020203C546F703E3339636D3C2F546F703E0D0A20202020202020203C57696474683E342E31353038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456C2076616C6F7220746F74616C2071756520736520726566696E616E6369612C20736572C3A12070616761646F20656E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22'
		||	'74657874626F78313438223E0D0A20202020202020203C546F703E33382E3235636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3139303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4465206163756572646F2061206C6F20636572746966696361646F20706F72206C61205375706572696E74656E64656E6369612046696E616E636965726120646520436F6C6F6D62696120656E2073752064697265636369C3B36E20656C65637472C3B36E696361207777772E737570657266696E616E63696572612E676F762E636F2C206C612074617361206DC3A178696D61206C6567616C20766967656E74652070617261206573746520706572C3AD6F646F20706F7220636F6E636570746F732064652066696E616E6369616369C3B36E205F5F5F5F5F5F5F5F20252079206C61207461736120646520696E74657265736573206D6F7261746F72696F73206DC3A178696D61206C6567616C20766967656E7465206573206465205F5F5F5F5F5F5F5F5F5F5F5F5F20252E204C612074617361206DC3A178696D61206C6567616C2064652066696E616E6369616369C3B36E207920646520696E746572C3A9736573206D6F7261746F72696F7320736520616A7573746172C3A120636164612076657A2071756520C3A973746173207365616E2061637475616C697A6164617320706F72206C61205375706572696E74656E64656E6369612046696E616E636965726120646520436F6C6F6D6269612E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313439223E0D0A2020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'3C546F703E33372E3735636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E506F7220496E74657265736573204361757361646F733C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313530223E0D0A20202020202020203C546F703E33372E3235636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E506F72204F74726F7320436F6E636570746F733C2F56616C75653E0D0A'
		||	'2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313531223E0D0A20202020202020203C546F703E33362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E312E3934303437636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E506F72204361706974616C3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313532223E0D0A20202020202020203C546F703E33352E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F48656967'
		||	'68743E0D0A20202020202020203C56616C75653E456C20737573637269746F20286129205F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F206964656E746966696361646F2028612920636F6D6F206170617265636520616C20706965206465206D69206669726D612C206F6272616E646F20656E206D692070726F70696F206E6F6D627265207920726570726573656E74616369C3B36E2C20636F6E20646F6D6963696C696F20656E206C6120636975646164206465205F5F5F5F5F5F5F5F2C206465636C61726F207175652061646575646F20656E206C612061637475616C6964616420612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F7320792F6F2050726F6D6967617320532E412E2C20452E532E502E2C20636F6E20646F6D6963696C696F207072696E636970616C20656E206C61206369756461642064652042617272616E7175696C6C612C20756E612073756D6120746F74616C20646520245F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313533223E0D0A20202020202020203C546F703E33352E3235636D3C2F546F703E0D0A20202020202020203C57696474683E382E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3830303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31322E3235323633636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E524546494E414E4349414349C3934E205041524120504552534F4E4153204E41545552414C45533C2F56616C75653E0D0A2020202020203C2F54657874626F'
		||	'783E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C5A496E6465783E3138343C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E444554414C4C453C2F446174615365744E616D653E0D0A20202020202020203C546F703E32392E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313534223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020'
		||	'20202020202020202020202020202020202020203C56616C75653E3D4669656C6473214954454D2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313535223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732154495052442E56616C75653C2F56616C75653E0D0A202020'
		||	'20202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313536223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732143554F494E492E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F727449'
		||	'74656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313537223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473215652444946452E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E35636D3C2F486569'
		||	'6768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313538223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020'
		||	'202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4954454D3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313539223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270'
		||	'743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5449504F2044452050524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313630223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566'
		||	'743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43554F544120494E494349414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313631223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020'
		||	'202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E444946455249444F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3932343934636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E372E3036383539636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E352E3131383634636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E352E3238383633636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020'
		||	'202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C4C696E65204E616D653D226C696E653131223E0D0A20202020202020203C546F703E33342E3735636D3C2F546F703E0D0A20202020202020203C57696474683E352E3930383733636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138333C2F5A496E6465783E0D0A20202020202020203C4C6566743E31322E3735323633636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C4C696E65204E616D653D226C696E653132223E0D0A20202020202020203C546F703E33342E3735636D3C2F546F703E0D0A20202020202020203C57696474683E362E3431313338636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138323C2F5A496E6465783E0D0A20202020202020203C4C6566743E322E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313632223E0D0A20202020202020203C546F703E33342E3735636D3C2F546F703E0D0A20202020202020203C57696474683E312E3930363039636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E'
		||	'3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3235323634636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E50524F43455341444F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313633223E0D0A20202020202020203C546F703E33342E3735636D3C2F546F703E0D0A20202020202020203C57696474683E322E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3138303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3530323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4649524D4120474553544F523C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6538223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E3137393C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313839223E0D0A2020202020202020202020203C546F703E312E3432333238636D3C2F546F703E0D0A2020202020202020202020203C57696474683E352E'
		||	'37383133636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E31322E3032313339636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214C4F47494E5F5553554152494F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E33322E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E322E35636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C4C696E65204E616D653D226C696E653133223E0D0A20202020202020203C546F703E33322E3235636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D'
		||	'0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3137383C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313634223E0D0A20202020202020203C546F703E33322E3235636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3137373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4F42534552564143494F4E45533A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313635223E0D0A20202020202020203C546F703E33312E3735636D3C2F546F703E0D0A20202020202020203C57696474683E332E3734373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'496E6465783E3137363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56414C4F5220454E204C45545241533A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6539223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E3137353C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313837223E0D0A2020202020202020202020203C546F703E302E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E31362E3734373335636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E322E3735636D3C2F4C6566743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732146494E414E43494143494F4E2E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E33312E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44'
		||	'656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313636223E0D0A20202020202020203C546F703E33312E3235636D3C2F546F703E0D0A20202020202020203C57696474683E332E3039373838636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3137343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E544F54414C20412050414741523C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C653130223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E3137333C2F5A496E6465783E0D0A20202020202020203C546F703E33312E3235636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313637'
		||	'223E0D0A20202020202020203C546F703E33302E3735636D3C2F546F703E0D0A20202020202020203C57696474683E312E3534373631636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3137323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3630353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E544F54414C45533C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C653131223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E3137313C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C4C696E65204E616D653D226C696E653134223E0D0A2020202020202020202020203C57696474683E30636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31352E3132393633636D3C2F4C6566743E0D0A202020202020202020203C2F4C696E653E0D0A202020202020202020203C4C696E65204E616D653D226C696E653135223E0D0A2020202020202020202020203C57696474683E30636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020'
		||	'202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C4C6566743E392E3938323534636D3C2F4C6566743E0D0A202020202020202020203C2F4C696E653E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E33302E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E302E3530323635636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313638223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E32362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E302E3039383434696E3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E4D61726F6F6E3C2F436F6C6F723E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4D61726F6F6E3C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3170743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3137303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E'
		||	'0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3039383434696E3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214C4F474F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676538223E0D0A20202020202020203C53697A696E673E46697450726F706F7274696F6E616C3C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C547275652C46616C7365293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E3237636D3C2F546F703E0D0A20202020202020203C57696474683E352E34303038636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E3136393C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F6E766572742E46726F6D426173653634537472696E67285265706F72744974656D73215458544C4F474F2E56616C7565293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313639223E0D0A20202020202020203C546F703E32392E3235636D3C2F546F703E0D0A20202020202020203C57696474683E362E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50'
		||	'616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31332E3530323633636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321444952452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313730223E0D0A20202020202020203C546F703E32392E3235636D3C2F546F703E0D0A20202020202020203C57696474683E372E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E322E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D4252452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313731223E0D0A20202020202020203C546F703E32382E3735636D3C2F546F703E0D0A20202020202020203C57696474683E362E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C65'
		||	'66743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31332E3530323633636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313732223E0D0A20202020202020203C546F703E32382E3735636D3C2F546F703E0D0A20202020202020203C57696474683E372E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E322E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C64732146454348412E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313733223E0D0A20202020202020203C546F703E32382E3235636D3C2F546F703E0D0A20202020202020203C57696474683E332E343030'
		||	'3739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E322E3334363537636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313734223E0D0A20202020202020203C546F703E32382E3235636D3C2F546F703E0D0A20202020202020203C57696474683E302E3835333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E312E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E49543A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D65'
		||	'3D2272656374616E676C653132223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E3136323C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C4C696E65204E616D653D226C696E653136223E0D0A2020202020202020202020203C57696474683E30636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31302E3735636D3C2F4C6566743E0D0A202020202020202020203C2F4C696E653E0D0A202020202020202020203C4C696E65204E616D653D226C696E653137223E0D0A2020202020202020202020203C546F703E302E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E32302E3235636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A2020202020202020202020203C4865696768743E30636D3C2F4865696768743E0D0A202020202020202020203C2F4C696E653E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313735223E0D0A2020202020202020202020203C546F703E302E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67'
		||	'546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E31302E3735636D3C2F4C6566743E0D0A2020202020202020202020203C56616C75653E44495245434349C3934E3A3C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313736223E0D0A2020202020202020202020203C546F703E302E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C56616C75653E4E4F4D4252453A3C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313737223E0D0A2020202020202020202020203C57696474683E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020'
		||	'3C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E31302E3735636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E535553435249504349C3934E3A3C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313738223E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E46454348413A3C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E32382E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C48'
		||	'65696768743E31636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313739223E0D0A20202020202020203C546F703E3238636D3C2F546F703E0D0A20202020202020203C57696474683E322E3536343831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3833383633636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321504147412E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313830223E0D0A20202020202020203C546F703E32372E3235636D3C2F546F703E0D0A20202020202020203C57696474683E332E3534373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3136303C2F5A496E64'
		||	'65783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3835353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E434F4D50524F42414E544520444520494E475245534F20412042414E434F204E6F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C4C696E65204E616D653D226C696E653130223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E35342E35636D3C2F546F703E0D0A20202020202020203C57696474683E31302E3839343138636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135393C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783832223E0D0A20202020202020203C546F703E37352E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E302E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E5265643C2F436F6C6F723E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020203C446972656374696F6E3E52544C3C2F446972656374696F6E3E0D0A202020202020202020203C57726974696E674D6F64653E74'
		||	'622D726C3C2F57726974696E674D6F64653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E32302E3036343831636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E434C49454E54453C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783833223E0D0A20202020202020203C546F703E37322E3335393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3239373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3637333238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4CC3AD6E65612047726174756974613A20303138303020393135203333343C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783834223E0D0A20202020202020203C546F703E37312E3630393738636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020'
		||	'202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3637333238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4641583A20333434313334383C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783835223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3637333238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E5042583A20333330363030303C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783836223E0D0A20202020202020203C546F703E37342E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F'
		||	'726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3037393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783837223E0D0A20202020202020203C546F703E37342E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'0A20202020202020203C56616C75653E546F74616C20456665637469766F3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783838223E0D0A20202020202020203C546F703E37332E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3037393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783839223E0D0A20202020202020203C546F703E37332E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E'
		||	'3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E546F74616C20436865717565733A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783930223E0D0A20202020202020203C546F703E37322E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3135303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3037393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783931223E0D0A20202020202020203C546F703E37322E3130393739636D3C2F546F70'
		||	'3E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783932223E0D0A20202020202020203C546F703E37322E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D'
		||	'3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783933223E0D0A20202020202020203C546F703E37322E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783934223E0D0A20202020202020203C546F703E37322E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E53'
		||	'6F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3732333535636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783935223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E4772'
		||	'6F773E0D0A20202020202020203C4C6566743E31392E3037393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783936223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783937223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765'
		||	'696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783938223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020'
		||	'202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783939223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3732333535636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313030223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E675269676874'
		||	'3E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3134303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3037393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313031223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313032223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C5769647468'
		||	'3E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313033223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67'
		||	'426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313034223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3732333535636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313035223E0D0A20202020202020203C546F703E36382E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F4465666175'
		||	'6C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3037393337636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56616C6F723C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313036223E0D0A20202020202020203C546F703E36382E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47'
		||	'726F773E0D0A20202020202020203C4C6566743E31372E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F6D6272652042616E636F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313037223E0D0A20202020202020203C546F703E36382E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436F642E2042616E636F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313038223E0D0A20202020202020203C546F703E36382E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870'
		||	'743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F2E204368657175653C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313039223E0D0A20202020202020203C546F703E36382E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3733383039636D3C2F4C6566743E0D0A20202020202020203C'
		||	'4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313130223E0D0A20202020202020203C546F703E37332E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E332E32333831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3133303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E35313139636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4D6964284669727374284669656C64732156414C49444F2E56616C75652C2022434152544122292C312C3130293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313131223E0D0A20202020202020203C546F703E37332E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020'
		||	'3C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E392E3238383336636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56616C69646F2068617374613A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313132223E0D0A20202020202020203C546F703E37332E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3839343138636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F545041472E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A20'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'20202020203C54657874626F78204E616D653D2274657874626F78313133223E0D0A20202020202020203C546F703E37332E3130393738636D3C2F546F703E0D0A20202020202020203C57696474683E312E3534333635636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56616C6F7220612070616761723A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313134223E0D0A20202020202020203C546F703E37322E3132343739636D3C2F546F703E0D0A20202020202020203C57696474683E332E32333831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F'
		||	'703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E35313139636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215245464552454E4349412E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313135223E0D0A20202020202020203C546F703E37322E3132343739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E392E3238383336636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F2E205265662E205061676F3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313136223E0D0A20202020202020203C546F703E37'
		||	'322E3132343739636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3839343138636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215449504F5F4355504F4E2E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313137223E0D0A20202020202020203C546F703E37322E3132343739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3534333635636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E'
		||	'0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E5469706F20646520437570C3B36E3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313138223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E332E32333831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E35313139636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321444952452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313139223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C'
		||	'5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E392E3238383336636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E44697220436C69656E74653A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313230223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3132303C2F5A49'
		||	'6E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3839343138636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313231223E0D0A20202020202020203C546F703E37302E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3534333635636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436F6E747261746F3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313232223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E332E32333831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C446566'
		||	'61756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E35313139636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214944454E54494649434154494F4E2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313233223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131373C2F5A496E6465783E0D0A20202020202020203C43'
		||	'616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E392E3238383336636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4964656E7469666963616369C3B36E3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313234223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3839343138636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D4252452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313235223E0D0A20202020202020203C546F703E36392E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E312E3534333635636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020'
		||	'3C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436C69656E74653A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313236223E0D0A20202020202020203C546F703E37302E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3637333238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E43617272657261203534204E6F2E2035392D3134343C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C653722'
		||	'3E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E3131333C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313237223E0D0A2020202020202020202020203C546F703E302E3735636D3C2F546F703E0D0A2020202020202020202020203C57696474683E31362E3735636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E313270743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E312E3030353239636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E4355504F4E204445205041474F20444520534F4C494349545544204445204E45474F4349414349C3934E2044452044455544413C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E36362E3630393738636D3C2F546F703E0D0A20202020202020203C57696474683E31372E3135303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E32636D'
		||	'3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C496D616765204E616D653D22696D61676534223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E37352E3334353234636D3C2F546F703E0D0A20202020202020203C57696474683E31302E3332313433636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E3131323C2F5A496E6465783E0D0A20202020202020203C4C6566743E362E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E33636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313238223E0D0A20202020202020203C546F703E37362E3539353234636D3C2F546F703E0D0A20202020202020203C57696474683E31322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3030323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C64732154585442415252412E56616C75652C2022434152544122293C2F56616C75'
		||	'653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313239223E0D0A20202020202020203C546F703E36382E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E31312E3339343138636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3131303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3030353239636D3C2F4865696768743E0D0A20202020202020203C56616C75653E5349205041474120434F4E20434845515545204553435249424120414C2052455350414C444F2044454C204D49534D4F205355204E4F4D4252452C20434F4449474F204445205245464552454E43494120592054454C45464F4E4F20444520434F4E544143544F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F78313330223E0D0A20202020202020203C546F703E36382E3835393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E74576569'
		||	'6768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3637333238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E47617365732064656C2043617269626520532E412E20452E532E502E203839302E3130312E3639312D323C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676535223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C547275652C46616C7365293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E36372E3130393739636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E3130383C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6764633C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783831223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7838313C2F72643A44656661756C744E616D653E0D0A2020'
		||	'2020202020203C546F703E36332E3339313533636D3C2F546F703E0D0A20202020202020203C57696474683E302E3835333138636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E5265643C2F436F6C6F723E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020203C446972656374696F6E3E52544C3C2F446972656374696F6E3E0D0A202020202020202020203C57726974696E674D6F64653E74622D726C3C2F57726974696E674D6F64653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E32302E3139373038636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E42414E434F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C4C696E65204E616D653D226C696E6539223E0D0A20202020202020203C546F703E36352E3938353435636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E4461736865643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020203C44656661756C743E3270743C2F44656661756C743E0D0A202020202020202020203C2F426F7264657257696474683E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130363C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E37333831636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A202020202020'
		||	'3C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783738223E0D0A20202020202020203C546F703E36302E3634313533636D3C2F546F703E0D0A20202020202020203C57696474683E322E3239373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3639373039636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4CC3AD6E65612047726174756974613A20303138303020393135203333343C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783737223E0D0A20202020202020203C546F703E35392E3839313533636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3639373039636D3C2F4C6566743E0D0A20202020202020203C4865'
		||	'696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4641583A20333434313334383C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783736223E0D0A20202020202020203C546F703E35392E3134313534636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3639373039636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E5042583A20333330363030303C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783739223E0D0A20202020202020203C546F703E36322E3431373939636D3C2F546F703E0D0A20202020202020203C57696474683E312E3532393039636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3134313534636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783830223E0D0A20202020202020203C546F703E36322E3431373939636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3830303236636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E546F74616C20456665637469766F3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783734223E0D0A20202020202020203C546F703E36312E343138636D3C2F546F703E0D0A20202020202020203C57696474683E312E3532393039636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A202020202020'
		||	'2020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E3130303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3134313534636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783735223E0D0A20202020202020203C546F703E36312E343138636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3830303236'
		||	'636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E546F74616C20436865717565733A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783639223E0D0A20202020202020203C546F703E36302E343138636D3C2F546F703E0D0A20202020202020203C57696474683E312E3532393039636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3134313534636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783730223E0D0A20202020202020203C546F703E36302E343138636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E7457'
		||	'65696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3830303236636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783731223E0D0A20202020202020203C546F703E36302E343138636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C5465'
		||	'7874626F78204E616D653D2274657874626F783732223E0D0A20202020202020203C546F703E36302E343138636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3334313238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783733223E0D0A20202020202020203C546F703E36302E3339313534636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C'
		||	'50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3732333535636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783634223E0D0A20202020202020203C546F703E35392E313638636D3C2F546F703E0D0A20202020202020203C57696474683E312E3532393039636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3134313534636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783635223E0D0A20202020202020203C546F703E35392E313638636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C65'
		||	'3E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3830303236636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783636223E0D0A20202020202020203C546F703E35392E313638636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A2020202020202020'
		||	'3C5A496E6465783E39313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783637223E0D0A20202020202020203C546F703E35392E313638636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E39303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3334313238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783638223E0D0A20202020202020203C546F703E35392E3134313534636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020'
		||	'2020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3732333535636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783539223E0D0A20202020202020203C546F703E35382E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3532393039636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3134313534636D3C2F4C6566743E0D0A20202020202020'
		||	'203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783630223E0D0A20202020202020203C546F703E35382E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3830303236636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783631223E0D0A20202020202020203C546F703E35382E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E327074'
		||	'3C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783632223E0D0A20202020202020203C546F703E35382E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3334313238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783633223E0D0A20202020202020'
		||	'203C546F703E35382E3134313533636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3732333535636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783538223E0D0A20202020202020203C546F703E35372E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3532393039636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20'
		||	'2020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3134313534636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56616C6F723C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783537223E0D0A20202020202020203C546F703E35372E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3830303236636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F6D6272652042616E636F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783536223E0D0A20202020202020203C546F703E35372E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3130333137636D3C2F57696474683E0D0A20202020202020203C5374796C65'
		||	'3E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E38313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3638323533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436F642E2042616E636F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783535223E0D0A20202020202020203C546F703E35372E3136373938636D3C2F546F703E0D0A20202020202020203C57696474683E312E3335333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F53'
		||	'74796C653E0D0A20202020202020203C5A496E6465783E38303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3334313238636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F2E204368657175653C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783534223E0D0A20202020202020203C546F703E35372E3134313533636D3C2F546F703E0D0A20202020202020203C57696474683E302E3630333137636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31342E3732333535636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783530223E0D0A20202020202020203C546F703E36312E3339313534636D3C2F546F703E0D0A20202020202020203C57696474683E322E39383831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C'
		||	'743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3733353435636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4D6964284669727374284669656C64732156414C49444F2E56616C75652C2022434152544122292C312C3130293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783531223E0D0A20202020202020203C546F703E36312E3339313534636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'20202020202020203C4C6566743E392E3438353434636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56616C69646F2068617374613A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783532223E0D0A20202020202020203C546F703E36312E3339313534636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3130353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F545041472E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783533223E0D0A20202020202020203C546F703E36312E3339313534636D3C2F546F703E0D0A20202020202020203C57696474683E312E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020'
		||	'20203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56616C6F7220612070616761723A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783436223E0D0A20202020202020203C546F703E36302E3430363533636D3C2F546F703E0D0A20202020202020203C57696474683E322E39383831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3733353435636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215245464552454E4349'
		||	'412E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783437223E0D0A20202020202020203C546F703E36302E3430363533636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E392E3438353434636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E6F2E205265662E205061676F3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783438223E0D0A20202020202020203C546F703E36302E3430363533636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E675269'
		||	'6768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3130353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473215449504F5F4355504F4E2E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783439223E0D0A20202020202020203C546F703E36302E3430363533636D3C2F546F703E0D0A20202020202020203C57696474683E312E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E393835636D3C2F4865696768743E0D0A20202020202020203C56616C75653E5469706F20646520437570C3B36E3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C'
		||	'54657874626F78204E616D653D2274657874626F783432223E0D0A20202020202020203C546F703E35392E3134313534636D3C2F546F703E0D0A20202020202020203C57696474683E322E39383831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E37303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3733353435636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321444952452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783433223E0D0A20202020202020203C546F703E35392E3134313534636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020'
		||	'202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E392E3438353434636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E44697220436C69656E74653A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783434223E0D0A20202020202020203C546F703E35392E3134313534636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3130353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783435223E0D0A20202020202020203C546F703E35392E3134313534636D3C2F546F703E0D0A20202020202020203C'
		||	'57696474683E312E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436F6E747261746F3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783431223E0D0A20202020202020203C546F703E35382E3134313533636D3C2F546F703E0D0A20202020202020203C57696474683E322E39383831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C65'
		||	'3E0D0A20202020202020203C5A496E6465783E36363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3733353435636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214944454E54494649434154494F4E2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783430223E0D0A20202020202020203C546F703E35382E3134313533636D3C2F546F703E0D0A20202020202020203C57696474683E322E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E392E3438353434636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4964656E7469666963616369C3B36E3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783339223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833393C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E35382E3134313533636D3C2F546F703E0D0A20202020202020203C576964'
		||	'74683E342E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3130353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D4252452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783338223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833383C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E35382E3134313533636D3C2F546F703E0D0A20202020202020203C57696474683E312E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E32'
		||	'70743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E436C69656E74653A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783337223E0D0A20202020202020203C546F703E35382E3339313533636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3639373039636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E43617272657261203534204E6F2E2035392D3134343C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6536223E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E36313C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F783334223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833343C2F72643A44656661756C744E616D65'
		||	'3E0D0A2020202020202020202020203C546F703E302E3735636D3C2F546F703E0D0A2020202020202020202020203C57696474683E31362E3735636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E313270743C2F466F6E7453697A653E0D0A20202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E312E3030353239636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E4355504F4E204445205041474F20444520534F4C494349545544204445204E45474F4349414349C3934E2044452044455544413C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E35342E3839313533636D3C2F546F703E0D0A20202020202020203C57696474683E31372E3135303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E32636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C4C696E65204E616D653D226C696E6538223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F56'
		||	'69736962696C6974793E0D0A20202020202020203C546F703E32362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E31322E3135303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E36303C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783237223E0D0A20202020202020203C546F703E31362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E35393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456A656D706C6F2032202843C3A16C63756C6F206465206C612063756F7461206EC3BA6D65726F203220656E206164656C616E7465293A0A53652072657175696572652063616C63756C617220656C2076616C6F72206465206C612063756F7461206EC3BA6D65726F2032320A413232203D202432362E39333620282031202B20302C32252029203232202031203D2667743B20413232203D202432382E3039302C30302E0A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61'
		||	'676533223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E36332E3632363939636D3C2F546F703E0D0A20202020202020203C57696474683E31302E3332313433636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E35383C2F5A496E6465783E0D0A20202020202020203C4C6566743E362E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E33636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D22434F4445223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E31332E3634393436636D3C2F546F703E0D0A20202020202020203C57696474683E302E3039383434696E3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E4D61726F6F6E3C2F436F6C6F723E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4D61726F6F6E3C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3170743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E35373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3039383434696E3C2F4865'
		||	'696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F44452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F445F424152524153223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E352E3337343438696E3C2F546F703E0D0A20202020202020203C57696474683E302E3039383434696E3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4D61726F6F6E3C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3170743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E35363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3236313938696E3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3039383434696E3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F6E766572742E546F426173653634537472696E67284669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F2229293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D6167654632223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E31352E3735636D3C2F546F703E0D0A20202020202020203C57696474683E342E34303038636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F75726365'
		||	'3E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E35353C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E66323C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C496D616765204E616D653D22696D6167654631223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E31332E3235636D3C2F546F703E0D0A20202020202020203C57696474683E322E3135303739636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E35343C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E66313C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D225458544241525241223E0D0A20202020202020203C72643A44656661756C744E616D653E54585442415252413C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E36342E3837363939636D3C2F546F703E0D0A20202020202020203C57696474683E31322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E35333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E4772'
		||	'6F773E0D0A20202020202020203C4C6566743E352E3030323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C64732154585442415252412E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22565243554F5441223E0D0A20202020202020203C72643A44656661756C744E616D653E565243554F54413C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31322E3235636D3C2F546F703E0D0A20202020202020203C57696474683E332E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C546578744465636F726174696F6E3E556E6465726C696E653C2F546578744465636F726174696F6E3E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E35323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3530323634636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321565243554F54412E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D224E554D43554F5441223E0D0A20202020202020203C72643A44656661756C744E616D653E4E554D43554F54413C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31322E3235636D3C2F546F703E0D0A20202020202020203C5769'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6474683E302E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C546578744465636F726174696F6E3E556E6465726C696E653C2F546578744465636F726174696F6E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E35313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E352E3530323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E554D43554F54412E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22494E54455245534553223E0D0A20202020202020203C72643A44656661756C744E616D653E494E544552455345533C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E3131636D3C2F546F703E0D0A20202020202020203C57696474683E322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A2020202020'
		||	'2020203C5A496E6465783E35303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494E544552455345532E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832353C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31302E35636D3C2F546F703E0D0A20202020202020203C57696474683E322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E24303C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D224341504954414C223E0D0A20202020202020203C72643A44656661756C744E616D653E4341504954414C3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E3130636D3C2F546F703E0D0A20202020202020203C57696474683E322E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020'
		||	'20202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214341504954414C2E56616C75652C2022434152544122293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D224C4554524153223E0D0A20202020202020203C72643A44656661756C744E616D653E4C45545241533C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E35636D3C2F546F703E0D0A20202020202020203C57696474683E31362E3734373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E32353533636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214C45545241532E56616C75652C2022535542544F54414C22293C2F56616C'
		||	'75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22544F54504147223E0D0A20202020202020203C72643A44656661756C744E616D653E544F545041473C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E342E35636D3C2F546F703E0D0A20202020202020203C57696474683E342E3438303135636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E32363732636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F545041472E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22544F5444494645223E0D0A20202020202020203C72643A44656661756C744E616D653E544F54444946453C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E342E31353038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E'
		||	'3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3735323634636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F54444946452E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22544F54494E49223E0D0A20202020202020203C72643A44656661756C744E616D653E544F54494E493C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E342E31353038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31312E3530323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321544F54494E492E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783333223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833333C2F72643A44656661756C74'
		||	'4E616D653E0D0A20202020202020203C546F703E32342E3730363335636D3C2F546F703E0D0A20202020202020203C57696474683E392E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22432E432E20222B4669727374284669656C647321434544554C412E56616C75652C2022534F4C49434954414E544522292B222044455F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783332223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32342E3230363335636D3C2F546F703E0D0A20202020202020203C57696474683E392E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34323C2F5A496E6465783E0D0A20202020202020203C43616E47'
		||	'726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D224E4F4D4252453A20222B4669727374284669656C6473214E4F4D4252455F534F4C2E56616C75652C2022534F4C49434954414E544522293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783331223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32332E3730363335636D3C2F546F703E0D0A20202020202020203C57696474683E392E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4649524D413A5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833303C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31372E3831343831636D3C2F546F703E0D0A20202020202020203C57696474683E32302E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E'
		||	'7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E34303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735636D3C2F4C6566743E0D0A20202020202020203C4865696768743E36636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456E206375616C7175696572206D6F6D656E746F2071756520656C20737573637269746F2064657365652063616E63656C6172206C6120746F74616C696461642064652073752064657564612C2065737465206465626572C3A120706167617220612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20746F646F73206C6F7320636F6E636570746F7320717565206C6520616465756465206861737461206C61206665636861206566656374697661206465207061676F2E0A4C61732063756F746173206D656E7375616C657320646566696E69746976617320696E636C756972C3A16E20656C2076616C6F72206465206C6F7320696E746572C3A97365732063616C63756C61646F7320736F62726520656C206361706974616C2C20636F6D70757461646F732061206C612074617361206DC3A178696D61206C6567616C20766967656E74652C20736F62726520656C20656E74656E6469646F2064652071756520656C2073697374656D61207061637461646F206465206772616469656E74652067656F6DC3A9747269636F2C2073756A657461732061206D6F64696669636163696F6E657320706F72206C612076617269616369C3B36E20646520746173617320646520696E746572C3A9732061706C696361626C652E0A4C61206D6F726120656E20656C207061676F20646520646F732063756F74617320636F6E736563757469766173207065726D69746972C3A1206163656C6572617220656C20636F62726F206465206C61206F626C6967616369C3B36E2C2074656E69656E646F2061206C61206D69736D6120636F6D6F20646520706C617A6F2076656E6369646F206120706172746972206465206C61206665636861'
		||	'20656E206C61206375616C2047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E2C206465636964612070726F636564657220616C20636F62726F206465206C6120746F74616C696461642064656C2073616C646F20616465756461646F2E204C6F7320696E74657265736573206D6F7261746F72696F7320736520636F62726172C3A16E2061206C612074617361206DC3A178696D61206C6567616C2E0A456C20286C6F732920737573637269746F202873292C206F6272616E646F20656E20656C20636172C3A16374657220616E74657320696E64696361646F206175746F72697A6120286D6F7329206465206D616E6572612069727265766F6361626C6520612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E2C207061726120636F6E73756C7461722C20736F6C69636974617220792F6F207265706F727461722061206C61732063656E7472616C65732064652072696573676F2C20656C20636F6D706F7274616D69656E746F2072656C617469766F2061206D6920286E75657374726F29206372C3A96469746F2C206375616E7461732076656365732073652072657175696572612E204173C3AD206D69736D6F2C20656E206361736F2064652071756520656E20656C2066757475726F2047617365732064656C2043617269626520532E412E20452E532E502E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E206566656374756172656E20756E612076656E74612064652063617274657261206F2063657369C3B36E206465206C6173206F626C69676163696F6E65732061206D6920286E75657374726F2920636172676F2C206C6F732065666563746F73206465206C612070726573656E7465206175746F72697A616369C3B36E20736520657874656E646572C3A16E20616C207465726365726F20636573696F6E6172696F2C20656E206C6F73206D69736D6F732074C3A9726D696E6F73207920636F6E646963696F6E65732E0A4173C3AD206D69736D6F2C20656C20286C6F732920737573637269746F20287329206175746F72697A6120286D6F732920612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F732C20792F6F2050726F6D6967617320532E412E20452E532E502E2C'
		||	'2070617261206C61207265636F70696C616369C3B36E2C2075736F20792074726174616D69656E746F206465206C6F73206461746F7320706572736F6E616C657320636F6E74656E69646F7320656E206573746520666F726D756C6172696F2C20746F646F7320617175656C6C6F732072656C6163696F6E61646F7320636F6E20656C206372C3A96469746F207920617175656C6C6F7320717565207365206C6C65676172656E20612073756D696E697374726172206F207265636F70696C617220656E20656C2066757475726F2C2070617261206C61732066696E616C696461646573207920656E206C6F732074C3A9726D696E6F7320646573637269746F7320656E206C6120506F6CC3AD746963612064652074726174616D69656E746F20646973706F6E69626C6520656E206C612070C3A167696E61207777772E6761736361726962652E636F6D2C206C6173206375616C6573206465636C61726120286D6F7329206861626572206C65C3AD646F2E204173C3AD206D69736D6F2C20656C20286C6F732920737573637269746F20287329206175746F72697A6120286D6F732920706172612071756520736520656E76C3AD6520656C2074656CC3A9666F6E6F2C2063656C756C617220792F6F20636F7272656F20656C65637472C3B36E69636F20717565207469656E65207265676973747261646F2C206369746163696F6E65732C20617669736F732C2070726F6D6F63696F6E6573206F20696E7669746163696F6E657320636F6D65726369616C65732C20656E206375616C7175696572207469656D706F2E0A506F72206578707265736120696E73747275636369C3B36E206465206C61205375706572696E74656E64656E63696120646520496E64757374726961207920436F6D657263696F2C20736520696E666F726D612061206C6120706172746520646575646F72612071756520647572616E746520656C20706572C3AD6F646F2064652066696E616E616369616369C3B36E206C61207461736120646520696E746572C3A973206E6F20706F6472C3A120736572207375706572696F72206120312E3520766563657320656C20696E746572C3A9732062616E636172696F20636F727269656E74652071756520636572746966696361206C61205375706572696E74656E64656E6369612046696E616E636965726120646520436F6C6F6D6269612E0A4375616E646F20656C20696E746572C3A97320636F627261646F2073757065726520646963686F206CC3AD6D6974652C20656C206163726565646F7220706572646572C3A120746F646F73206C6F7320696E746572C3A97365732E20456E2074616C6573206361736F7320656C20636F6E73756D69646F722070'
		||	'6F6472C3A120736F6C696369746172206C6120696E6D656469617461206465766F6C756369C3B36E206465206C61732073756D61732071756520686179612063616E63656C61646F20706F7220636F6E636570746F206465206C6F73207265737065637469766F7320696E746572C3A97365732E0A53652072657075746172C3A16E2074616D6269C3A96E20636F6D6F20696E746572C3A9736573206C61732073756D61732071756520656C206163726565646F72207265636962612064656C20646575646F722073696E20636F6E7472617072657374616369C3B36E2064697374696E746120616C206372C3A96469746F206F746F726761646F2C2061756E206375616E646F206C6173206D69736D6173207365206A7573746966697175656E20706F7220636F6E636570746F20646520686F6E6F726172696F732C20636F6D6973696F6E65732075206F74726F732073656D656A616E7465732E2054616D6269C3A96E20736520696E636C756972C3A16E2064656E74726F206465206C6F7320696E746572C3A9736573206C61732073756D61732071756520656C20646575646F7220706167756520706F7220636F6E636570746F20646520736572766963696F732076696E63756C61646F7320646972656374616D656E746520636F6E20656C206372C3A96469746F2C2074616C657320636F6D6F20636F73746F732064652061646D696E69737472616369C3B36E2C206573747564696F2064656C206372C3A96469746F2C20706170656C6572C3AD612C2063756F746173206465206166696C69616369C3B36E2C206574632E2028617274C3AD63756C6F203638206465206C61204C65792034352064652031393930292E0A0A5061726120436F6E7374616E636961207365206669726D6120656E205F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F2C2061206C6F73205F5F5F5F5F5F5F5F2064C3AD61732064656C206D6573206465205F5F5F5F5F5F5F5F5F5F2064652032305F5F5F5F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832393C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E3134636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C'
		||	'6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456E20646F6E64652041203D205072696D6572612063756F74612064656C207072C3A97374616D6F2C2050203D2053616C646F20612046696E616E636961722C206E203D20506572C3AD6F646F732C2069203D205461736120646520696E746572C3A973206DC3A178696D61206C6567616C20766967656E74652070617261206361646120706572C3AD6F646F20646520666163747572616369C3B36E2C2047203D20466163746F722064652063726563696D69656E746F206D656E7375616C206465206C612063756F74612C206573746520666163746F722065732064656C20302C32252E0A4C6120666F726D756C6120616E746572696F7220736572C3A120757361646120706172612063616C63756C617220736F6C616D656E7465206C61207072696D6572612063756F74612064656C206372C3A96469746F2C206C61732063756F746173207369677569656E7465732073652063616C63756C6172C3A16E20696E6372656D656E74C3A16E646F6C6520756E20666163746F722064652063726563696D69656E746F206D656E7375616C2064656C20302C32252E204120706172746972206465206C612063756F7461206E756D65726F20322C206C61732063756F74617320736572C3A16E2063616C63756C6164617320636F6E206C61207369677569656E74652066C3B3726D756C613A0A416E203D20413120282031202B204720294E202D20310A456A656D706C6F2031202843C3A16C63756C6F206465206C612063756F7461206EC3BA6D65726F2031293A205061726120756E6120646575646120726566696E616E636961646120706F722076616C6F722064652024312E3030302E3030302C3030202850292C206375796F207061676F206573207061637461646F206120373220286E292063756F746173206D656E7375616C65732C207061726120756E612074617361206DC3A178696D61206C6567616C'
		||	'2064656C20322C323825202869292C20656C2076616C6F72206465206C612063756F7461206EC3BA6D65726F203120736572C3AD61206465202432362E3933362E3030202841292E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783238223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832383C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31322E3735636D3C2F546F703E0D0A20202020202020203C57696474683E372E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E736567C3BA6E206C61207369677569656E74652066C3B3726D756C612C2061706C6963616461207061726120636164612076656E63696D69656E746F206D656E7375616C3A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832363C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31322E3235636D3C2F546F703E0D0A20202020202020203C57696474683E31302E3135303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C'
		||	'2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E362E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E63756F746173206D656E7375616C65732079207375636573697661732064657465726D696E616461732C206C61207072696D6572612063756F74612074656E6472C3A120756E2076616C6F72206170726F78696D61646F2064653C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783234223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832343C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31322E3235636D3C2F546F703E0D0A20202020202020203C57696474683E342E31353038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456C2076616C6F7220746F74616C2071756520736520726566696E616E6369612C20736572C3A12070616761646F20656E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F'
		||	'78204E616D653D2274657874626F783233223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832333C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31312E35636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4465206163756572646F2061206C6F20636572746966696361646F20706F72206C61205375706572696E74656E64656E6369612046696E616E636965726120646520436F6C6F6D62696120656E2073752064697265636369C3B36E20656C65637472C3B36E696361207777772E737570657266696E616E63696572612E676F762E636F2C206C612074617361206DC3A178696D61206C6567616C20766967656E74652070617261206573746520706572C3AD6F646F20706F7220636F6E636570746F732064652066696E616E6369616369C3B36E205F5F5F5F5F5F5F5F20252079206C61207461736120646520696E74657265736573206D6F7261746F72696F73206DC3A178696D61206C6567616C20766967656E7465206573206465205F5F5F5F5F5F5F5F5F5F5F5F5F20252E204C612074617361206DC3A178696D61206C6567616C2064652066696E616E6369616369C3B36E207920646520696E746572C3A9736573206D6F7261746F72696F7320736520616A7573746172C3A120636164612076657A2071756520C3A973746173207365616E2061637475616C697A6164617320706F72206C61205375706572696E74656E64656E6369612046696E616E636965726120646520436F6C6F6D6269612E3C2F56616C75653E0D0A20202020'
		||	'20203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E3131636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E506F7220496E74657265736573204361757361646F733C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31302E35636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E506F72204F74726F7320436F6E636570746F733C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7832303C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E3130636D3C2F546F703E0D0A20202020202020203C57696474683E312E3934303437636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E506F72204361706974616C3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831393C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E39636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E67526967'
		||	'68743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E456C20737573637269746F20286129205F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F206964656E746966696361646F2028612920636F6D6F206170617265636520616C20706965206465206D69206669726D612C206F6272616E646F20656E206D692070726F70696F206E6F6D627265207920726570726573656E74616369C3B36E2C20636F6E20646F6D6963696C696F20656E206C6120636975646164206465205F5F5F5F5F5F5F5F2C206465636C61726F207175652061646575646F20656E206C612061637475616C6964616420612047617365732064656C2043617269626520532E412E20456D707265736120646520536572766963696F732050C3BA626C69636F7320792F6F2050726F6D6967617320532E412E2C20452E532E502E2C20636F6E20646F6D6963696C696F207072696E636970616C20656E206C61206369756461642064652042617272616E7175696C6C612C20756E612073756D6120746F74616C20646520245F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783138223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831383C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E382E35636D3C2F546F703E0D0A20202020202020203C57696474683E382E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3830303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464'
		||	'696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31322E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E524546494E414E4349414349C3934E205041524120504552534F4E4153204E41545552414C45533C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C5461626C65204E616D653D22444554414C4C455F223E0D0A20202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E444554414C4C453C2F446174615365744E616D653E0D0A20202020202020203C546F703E33636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224445534352495043494F4E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4445534352495043494F4E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F56657274696361'
		||	'6C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214954454D2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22554E49444144223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E554E494441443C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E4C6566743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F56657274696361'
		||	'6C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732154495052442E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F52223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F523C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F56657274696361'
		||	'6C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732143554F494E492E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C65'
		||	'3C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473215652444946452E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A20202020202020202020202020202020202020202020'
		||	'3C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4954454D3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874'
		||	'626F7838223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5449504F2044452050524F445543544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D73'
		||	'3E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43554F544120494E494349414C3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C546162'
		||	'6C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E57686974653C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C4261636B67726F756E64436F6C6F723E426C61636B3C2F4261636B67726F756E64436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E444946455249444F3C2F56616C75653E0D0A202020202020202020202020202020'
		||	'20202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3932343934636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E372E3036383539636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E352E3131383634636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E352E3238383633636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C4C696E65204E616D653D226C696E6537223E0D0A20202020202020203C546F703E38636D3C2F546F703E0D0A20202020202020203C57696474683E352E3930383733636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A20202020202020203C4C6566743E31322E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A'
		||	'2020202020203C2F4C696E653E0D0A2020202020203C4C696E65204E616D653D226C696E6536223E0D0A20202020202020203C546F703E38636D3C2F546F703E0D0A20202020202020203C57696474683E362E3431313338636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A20202020202020203C4C6566743E322E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831353C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E38636D3C2F546F703E0D0A20202020202020203C57696474683E312E3930363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31352E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E50524F43455341444F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831343C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E38636D3C2F'
		||	'546F703E0D0A20202020202020203C57696474683E322E3234373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E342E3530323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4649524D4120474553544F523C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6535223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313838223E0D0A2020202020202020202020203C546F703E312E3436393538636D3C2F546F703E0D0A2020202020202020202020203C57696474683E352E37383133636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020'
		||	'203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E31322E3033393032636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C6473214C4F47494E5F5553554152494F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E36636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E322E3438363737636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C4C696E65204E616D653D226C696E6535223E0D0A20202020202020203C546F703E352E35636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831333C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E352E35636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A'
		||	'202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4F42534552564143494F4E45533A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3734373335636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E56414C4F5220454E204C45545241533A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6534223E0D0A20202020202020203C4C6566743E302E3735'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		15758, 
		hextoraw
		(
			'323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F78313836223E0D0A2020202020202020202020203C546F703E302E3437353039636D3C2F546F703E0D0A2020202020202020202020203C57696474683E31362E3734373335636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E322E3735636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E3D4669727374284669656C64732146494E414E43494143494F4E2E56616C75652C2022535542544F54414C22293C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E35636D3C2F546F703E0D0A20202020202020203C57696474683E32302E34303038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E302E3939313633636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831313C2F72643A44656661756C744E616D653E0D0A20'
		||	'202020202020203C546F703E342E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3039373838636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E544F54414C20412050414741523C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6533223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A20202020202020203C546F703E342E35636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783130223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7831303C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E312E3534373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453'
		||	'697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E382E3630353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E544F54414C45533C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6532223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C4C696E65204E616D653D226C696E6534223E0D0A2020202020202020202020203C57696474683E30636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31352E3132393633636D3C2F4C6566743E0D0A202020202020202020203C2F4C696E653E0D0A202020202020202020203C4C696E65204E616D653D226C696E6533223E0D0A2020202020202020202020203C57696474683E30636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C'
		||	'2F5374796C653E0D0A2020202020202020202020203C4C6566743E392E3938323534636D3C2F4C6566743E0D0A202020202020202020203C2F4C696E653E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E34636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E302E3530323635636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D225458544C4F474F223E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C57696474683E302E3039383434696E3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E4D61726F6F6E3C2F436F6C6F723E0D0A202020202020202020203C4261636B67726F756E64436F6C6F723E4D61726F6F6E3C2F4261636B67726F756E64436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3170743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3039383434696E3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214C4F474F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A202020202020'
		||	'3C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676531223E0D0A20202020202020203C53697A696E673E46697450726F706F7274696F6E616C3C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C547275652C46616C7365293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E302E3235636D3C2F546F703E0D0A20202020202020203C57696474683E352E34303038636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D436F6E766572742E46726F6D426173653634537472696E67285265706F72744974656D73215458544C4F474F2E56616C7565293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D22444952455F31223E0D0A20202020202020203C72643A44656661756C744E616D653E444952455F313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E35636D3C2F546F703E0D0A20202020202020203C57696474683E362E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A20202020202020203C43616E47726F'
		||	'773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31332E3530323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321444952452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D224E4F4D4252455F31223E0D0A20202020202020203C72643A44656661756C744E616D653E4E4F4D4252455F313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E35636D3C2F546F703E0D0A20202020202020203C57696474683E372E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E322E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D4252452E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F4E545241544F5F31223E0D0A20202020202020203C72643A44656661756C744E616D653E434F4E545241544F5F313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32636D3C2F546F703E0D0A20202020202020203C57696474683E362E3930303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C656674'
		||	'3E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31332E3530323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2246454348415F31223E0D0A20202020202020203C72643A44656661756C744E616D653E46454348415F313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32636D3C2F546F703E0D0A20202020202020203C57696474683E372E3635303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E322E3235323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C64732146454348412E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D224E49545F31223E0D0A20202020202020203C72643A4465'
		||	'6661756C744E616D653E4E49545F313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E312E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3430303739636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E322E3334363537636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E312E35636D3C2F546F703E0D0A20202020202020203C57696474683E302E3638323533636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C'
		||	'4C6566743E312E3137333239636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E4E49543A3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C52656374616E676C65204E616D653D2272656374616E676C6531223E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020203C5265706F72744974656D733E0D0A202020202020202020203C4C696E65204E616D653D226C696E6532223E0D0A2020202020202020202020203C57696474683E30636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E31302E3735636D3C2F4C6566743E0D0A202020202020202020203C2F4C696E653E0D0A202020202020202020203C4C696E65204E616D653D226C696E6531223E0D0A2020202020202020202020203C546F703E302E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E32302E3137303634636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C426F726465725374796C653E0D0A202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A2020202020202020202020203C4C6566743E302E3037393337636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E30636D3C2F4865696768743E0D0A202020202020202020203C2F4C696E653E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F78363C2F72643A44656661756C744E616D653E0D0A2020202020202020202020203C546F703E302E35636D3C2F546F703E0D'
		||	'0A2020202020202020202020203C57696474683E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E31302E3735636D3C2F4C6566743E0D0A2020202020202020202020203C56616C75653E44495245434349C3934E3A3C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F78353C2F72643A44656661756C744E616D653E0D0A2020202020202020202020203C546F703E302E35636D3C2F546F703E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C56616C75653E4E4F4D4252453A3C2F56616C75653E0D'
		||	'0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F78343C2F72643A44656661756C744E616D653E0D0A2020202020202020202020203C57696474683E32636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020202020202020203C2F5374796C653E0D0A2020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4C6566743E31302E3735636D3C2F4C6566743E0D0A2020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E535553435249504349C3934E3A3C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A202020202020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A2020202020202020202020203C72643A44656661756C744E616D653E74657874626F78333C2F72643A44656661756C744E616D653E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A2020202020202020202020203C5374796C653E0D0A20202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020'
		||	'20202020202020203C2F5374796C653E0D0A2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C56616C75653E46454348413A3C2F56616C75653E0D0A202020202020202020203C2F54657874626F783E0D0A20202020202020203C2F5265706F72744974656D733E0D0A20202020202020203C546F703E32636D3C2F546F703E0D0A20202020202020203C57696474683E32302E3430363038636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A2020202020203C2F52656374616E676C653E0D0A2020202020203C54657874626F78204E616D653D22504147415F31223E0D0A20202020202020203C72643A44656661756C744E616D653E504147415F313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E312E3235636D3C2F546F703E0D0A20202020202020203C57696474683E322E3536343831636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31372E3833383633636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321504147412E56616C75652C20'
		||	'22454E434142455A41444F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E302E35636D3C2F546F703E0D0A20202020202020203C57696474683E332E3534373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31362E3835353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E434F4D50524F42414E544520444520494E475245534F20412042414E434F204E6F2E3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783336223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833363C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E35372E3134313533636D3C2F546F703E0D0A20202020202020203C57696474683E31312E3339343138636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F5465'
		||	'7874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E332E3335353832636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3030353239636D3C2F4865696768743E0D0A20202020202020203C56616C75653E5349205041474120434F4E20434845515545204553435249424120414C2052455350414C444F2044454C204D49534D4F205355204E4F4D4252452C20434F4449474F204445205245464552454E43494120592054454C45464F4E4F20444520434F4E544143544F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F783335223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F7833353C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E35372E3134313533636D3C2F546F703E0D0A20202020202020203C57696474683E322E3739373632636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3639373039636D3C2F4C6566743E'
		||	'0D0A20202020202020203C4865696768743E31636D3C2F4865696768743E0D0A20202020202020203C56616C75653E47617365732064656C2043617269626520532E412E20452E532E502E203839302E3130312E3639312D323C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676532223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C547275652C46616C7365293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E35352E3339313534636D3C2F546F703E0D0A20202020202020203C57696474683E322E3430303739636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6764633C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C496D616765204E616D653D22696D61676539223E0D0A20202020202020203C53697A696E673E46697450726F706F7274696F6E616C3C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C46616C73652C54727565293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E302E3235636D3C2F546F703E0D0A20202020202020203C57696474683E352E34303038636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020'
		||	'202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6566696761733C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C496D616765204E616D653D22696D6167653130223E0D0A20202020202020203C53697A696E673E46697450726F706F7274696F6E616C3C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E49542E56616C75652C2022454E434142455A41444F2229204C696B6520222A3830303230323339352D332A222C46616C73652C54727565293C2F48696464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C546F703E3237636D3C2F546F703E0D0A20202020202020203C57696474683E352E34303038636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C4C6566743E302E3735323635636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6566696761733C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E38332E3832636D3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E65732D45533C2F4C616E67756167653E0D0A20203C506167654865696768743E32372E3934636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_109.cuPlantilla( 104 );
	fetch CONFEXME_109.cuPlantilla into nuIdPlantill;
	close CONFEXME_109.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = '1 - Pagare oficial GDC - EFG',
		       plannomb = 'PLANTILLA_63',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 104;
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
			104,
			blContent ,
			'1 - Pagare oficial GDC - EFG',
			'PLANTILLA_63',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_109.cuExtractAndMix( 109 );
	fetch CONFEXME_109.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_109.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = '1 - PAGARE OFICIAL GDC - EFG',
		       coeminic = NULL,
		       coempada = '<183>',
		       coempadi = 'PLANTILLA_63',
		       coempame = NULL,
		       coemtido = 77,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 109;
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
			109,
			'1 - PAGARE OFICIAL GDC - EFG',
			NULL,
			'<183>',
			'PLANTILLA_63',
			NULL,
			77,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_109.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_109.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_109.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_109.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_109 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_109'
	);
--}
END;
/

