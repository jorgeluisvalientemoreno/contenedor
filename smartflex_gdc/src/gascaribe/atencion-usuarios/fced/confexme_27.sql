BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_27 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_27',
		'CREATE OR REPLACE PACKAGE CONFEXME_27 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_27;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_27',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_27 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_27;'
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_27.cuFormat( 23 );
	fetch CONFEXME_27.cuFormat into nuFormatId;
	close CONFEXME_27.cuFormat;

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
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_27.cuFormat( 23 );
	fetch CONFEXME_27.cuFormat into nuFormatId;
	close CONFEXME_27.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_27.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_CERTIFICADO_CONSTANCIA_PAGOS',
		       formtido = 134,
		       formiden = '<23>',
		       formtico = 466,
		       formdein = '<LDC_CERTIFICADO_CONSTANCIA_PAGOS>',
		       formdefi = '</LDC_CERTIFICADO_CONSTANCIA_PAGOS>'
		WHERE  formcodi = CONFEXME_27.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_27.rcED_Formato.formcodi := 23 ;

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
			CONFEXME_27.rcED_Formato.formcodi,
			'LDC_CERTIFICADO_CONSTANCIA_PAGOS',
			134,
			'<23>',
			466,
			'<LDC_CERTIFICADO_CONSTANCIA_PAGOS>',
			'</LDC_CERTIFICADO_CONSTANCIA_PAGOS>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_27.tbrcGE_Statement( '120127680' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC - Datos del cliente]', 5 );
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
		CONFEXME_27.tbrcGE_Statement( '120127680' ).statement_id,
		16,
		'LDC - Datos del cliente',
		'SELECT  open.pktblsistema.fsbgetcompanyname(99) NOM_EMPRESA,
        suscripc.susccodi               CONTRATO,
        add_susc.address_parsed         DIRECCION,
        geo_susc.description            MUNICIPIO,
        client.subscriber_name          NOMBRE_CLIENTE,
        client.subs_last_name           APELLIDO_CLIENTE,
        (select contact.subscriber_name||'' ''||contact.subs_last_name
        from ge_subscriber contact where mo_packages.contact_id= contact.subscriber_id) NOM_SOLICITANTE,
        (select contact.identification
        from ge_subscriber contact where mo_packages.contact_id= contact.subscriber_id)DOC_SOLICITANTE,
        (select GE.description from or_operating_unit OP, ab_address DIR, ge_geogra_location GE
        where OP.operating_unit_id=mo_packages.pos_oper_unit_id
        and OP.starting_address=DIR.address_id
        and DIR.geograp_location_id = GE.geograp_location_id) MUN_SOLICITANTE,
        to_char(mo_packages.request_date,''dd/mm/yyyy'') FECHA,
        to_char(mo_packages.request_date,''DD'') DIA,
        to_char(mo_packages.request_date,''MM'') MES,
        to_char(mo_packages.request_date,''YYYY'') ANO,
		LDC_CRMPazySalvo.Fsbaddress MUNICIPIO_ATENCION
FROM    mo_motive, mo_packages, suscripc, ab_address add_susc, ge_geogra_location  geo_susc,ge_subscriber client
WHERE   mo_motive.motive_id         = cc_bocertificate.fnuMotiveId
AND     mo_motive.package_id        = mo_packages.package_id
AND     mo_motive.subscription_id   = suscripc.susccodi
AND     suscripc.susciddi           = add_susc.address_id
AND     add_susc.geograp_location_id= geo_susc.geograp_location_id
AND     suscripc.suscclie           = client.subscriber_id',
		'LDC - Datos del cliente'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_27.tbrcGE_Statement( '120127680' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>NOM_EMPRESA</Name>
    <Description>NOM_EMPRESA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
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
    <Name>DIRECCION</Name>
    <Description>DIRECCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>200</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MUNICIPIO</Name>
    <Description>MUNICIPIO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE_CLIENTE</Name>
    <Description>NOMBRE_CLIENTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>APELLIDO_CLIENTE</Name>
    <Description>APELLIDO_CLIENTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOM_SOLICITANTE</Name>
    <Description>NOM_SOLICITANTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>201</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DOC_SOLICITANTE</Name>
    <Description>DOC_SOLICITANTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MUN_SOLICITANTE</Name>
    <Description>MUN_SOLICITANTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA</Name>
    <Description>FECHA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIA</Name>
    <Description>DIA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MES</Name>
    <Description>MES</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ANO</Name>
    <Description>ANO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MUNICIPIO_ATENCION</Name>
    <Description>MUNICIPIO_ATENCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_27.tbrcGE_Statement( '120127681' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC - Datos Generales de Constancia Pagos]', 5 );
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
		CONFEXME_27.tbrcGE_Statement( '120127681' ).statement_id,
		16,
		'LDC - Datos Generales de Constancia Pagos',
		'select to_char(mo_motive.prov_initial_date,''DD/MM/YYYY'') FECHAINI,
       to_char(mo_motive.prov_final_date, ''DD/MM/YYYY'') FECHAFIN,
       to_char(prov_initial_date,''MON'') MESINI,
       to_char(prov_initial_date,''YYYY'') ANOINI,
       to_char(prov_final_date,''MON'') MESFIN,
       to_char(prov_final_date,''YYYY'') ANOFIN
from mo_motive
where   mo_motive.motive_id = cc_bocertificate.fnumotiveid',
		'LDC - Datos Generales de Constancia Pagos'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_27.tbrcGE_Statement( '120127681' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>FECHAINI</Name>
    <Description>FECHAINI</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHAFIN</Name>
    <Description>FECHAFIN</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MESINI</Name>
    <Description>MESINI</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ANOINI</Name>
    <Description>ANOINI</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MESFIN</Name>
    <Description>MESFIN</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ANOFIN</Name>
    <Description>ANOFIN</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_27.tbrcGE_Statement( '120127682' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC - Detalle de Pagos]', 5 );
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
		CONFEXME_27.tbrcGE_Statement( '120127682' ).statement_id,
		16,
		'LDC - Detalle de Pagos',
		'SELECT open.DAPR_PRODUCT.FNUGETPRODUCT_TYPE_ID(CARGNUSE,NULL) tip_prod,open.PKTBLSERVICIO.FSBGETDESCRIPTION(open.DAPR_PRODUCT.FNUGETPRODUCT_TYPE_ID(CARGNUSE,NULL),NULL) TIPOPRODUCTO,
       to_char(open.PKTBLFACTURA.FDTGETFACTFEGE(CUCOFACT,NULL),''DD/MM/YYYY'')FECHAGENFAC,
CASE WHEN cargcuco = (SELECT MAX(cargcuco) FROM open.cargos t WHERE t.cargsign = ''PA'' and t.cargcodo = PAGOCUPO) THEN
            (select sum(cargvalo) from open.CARGOS t where t.cargsign = ''PA'' and t.cargcodo = PAGOCUPO)
           ELSE
            0
      END TOTALFACT,
             to_char(pagos.PAGOFEPA, ''DD/MM/YYYY'') FECHARECAUDO,
       cargcuco CUENTACOBROPAGO,
       cargvalo VALORRECAUDO,
       to_char(pagos.pagofegr, ''DD/MM/YYYY'') FECHAAPLICACIONRECAUDO,
       (select subanomb
          from open.sucubanc
         where sucubanc.subabanc = pagos.pagobanc
           and sucubanc.subacodi = pagos.pagosuba) ENTIDADRECAUDADORA
  from open.pagos, open.mo_motive, open.CARGOS,open.CUENCOBR
 where mo_motive.motive_id = cc_bocertificate.fnuMotiveId
   and mo_motive.subscription_id = pagos.pagosusc
   AND cargcodo = pagocupo
   and trunc(pagos.pagofepa) >= mo_motive.prov_initial_date
   and trunc(pagos.pagofepa) <= mo_motive.prov_final_date
   and CARGOS.cargsign =''PA''
   AND CARGOS.CARGCUCO = CUENCOBR.CUCOCODI
ORDER BY pagos.PAGOFEPA, tip_prod asc',
		'LDC - Detalle de Pagos'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_27.tbrcGE_Statement( '120127682' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>TIP_PROD</Name>
    <Description>TIP_PROD</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPOPRODUCTO</Name>
    <Description>TIPOPRODUCTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHAGENFAC</Name>
    <Description>FECHAGENFAC</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TOTALFACT</Name>
    <Description>TOTALFACT</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHARECAUDO</Name>
    <Description>FECHARECAUDO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CUENTACOBROPAGO</Name>
    <Description>CUENTACOBROPAGO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>VALORRECAUDO</Name>
    <Description>VALORRECAUDO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>13</Length>
    <Scale>2</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHAAPLICACIONRECAUDO</Name>
    <Description>FECHAAPLICACIONRECAUDO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ENTIDADRECAUDADORA</Name>
    <Description>ENTIDADRECAUDADORA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>40</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_27.tbrcED_Franja( 5405 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [DATOS DE PAGOS]', 5 );
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
		CONFEXME_27.tbrcED_Franja( 5405 ).francodi,
		'DATOS DE PAGOS',
		CONFEXME_27.tbrcED_Franja( 5405 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_27.tbrcED_Franja( 5406 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [DATOS GENERALES]', 5 );
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
		CONFEXME_27.tbrcED_Franja( 5406 ).francodi,
		'DATOS GENERALES',
		CONFEXME_27.tbrcED_Franja( 5406 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_27.tbrcED_FranForm( '5334' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_27.tbrcED_FranForm( '5334' ).frfoform := CONFEXME_27.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_27.tbrcED_Franja.exists( 5405 ) ) then
		CONFEXME_27.tbrcED_FranForm( '5334' ).frfofran := CONFEXME_27.tbrcED_Franja( 5405 ).francodi;
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
		CONFEXME_27.tbrcED_FranForm( '5334' ).frfocodi,
		CONFEXME_27.tbrcED_FranForm( '5334' ).frfoform,
		CONFEXME_27.tbrcED_FranForm( '5334' ).frfofran,
		2,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_27.tbrcED_FranForm( '5335' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_27.tbrcED_FranForm( '5335' ).frfoform := CONFEXME_27.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_27.tbrcED_Franja.exists( 5406 ) ) then
		CONFEXME_27.tbrcED_FranForm( '5335' ).frfofran := CONFEXME_27.tbrcED_Franja( 5406 ).francodi;
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
		CONFEXME_27.tbrcED_FranForm( '5335' ).frfocodi,
		CONFEXME_27.tbrcED_FranForm( '5335' ).frfoform,
		CONFEXME_27.tbrcED_FranForm( '5335' ).frfofran,
		1,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - Aplicacion de Pagos]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi,
		'LDC - Aplicacion de Pagos',
		'CC_BOCertificate.GetPaysDetail',
		CONFEXME_27.tbrcED_FuenDato( '4134' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_27.tbrcGE_Statement.exists( '120127682' ) ) then
		CONFEXME_27.tbrcED_FuenDato( '4135' ).fudasent := CONFEXME_27.tbrcGE_Statement( '120127682' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - Detalle de Pagos]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi,
		'LDC - Detalle de Pagos',
		NULL,
		CONFEXME_27.tbrcED_FuenDato( '4135' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_27.tbrcGE_Statement.exists( '120127680' ) ) then
		CONFEXME_27.tbrcED_FuenDato( '4136' ).fudasent := CONFEXME_27.tbrcGE_Statement( '120127680' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - Datos del cliente]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi,
		'LDC - Datos del cliente',
		NULL,
		CONFEXME_27.tbrcED_FuenDato( '4136' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_27.tbrcGE_Statement.exists( '120127681' ) ) then
		CONFEXME_27.tbrcED_FuenDato( '4137' ).fudasent := CONFEXME_27.tbrcGE_Statement( '120127681' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC - Datos Generales de Constancia Pagos]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi,
		'LDC - Datos Generales de Constancia Pagos',
		NULL,
		CONFEXME_27.tbrcED_FuenDato( '4137' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40142' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4137' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40142' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FECHAINI]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40142' ).atfdcodi,
		'FECHAINI',
		'FECHAINI',
		1,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40142' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40143' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4137' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40143' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FECHAFIN]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40143' ).atfdcodi,
		'FECHAFIN',
		'FECHAFIN',
		2,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40143' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40144' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4137' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40144' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MESINI]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40144' ).atfdcodi,
		'MESINI',
		'MESINI',
		3,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40144' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40145' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4137' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40145' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ANOINI]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40145' ).atfdcodi,
		'ANOINI',
		'ANOINI',
		4,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40145' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40146' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4137' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40146' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MESFIN]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40146' ).atfdcodi,
		'MESFIN',
		'MESFIN',
		5,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40146' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40147' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4137' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40147' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ANOFIN]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40147' ).atfdcodi,
		'ANOFIN',
		'ANOFIN',
		6,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40147' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40161' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40161' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nuyear]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40161' ).atfdcodi,
		'NUYEAR',
		'Nuyear',
		1,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40161' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40162' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40162' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Numonth]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40162' ).atfdcodi,
		'NUMONTH',
		'Numonth',
		2,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40162' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40163' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40163' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nupaymentid]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40163' ).atfdcodi,
		'NUPAYMENTID',
		'Nupaymentid',
		3,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40163' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40164' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40164' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Dtcollectdate]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40164' ).atfdcodi,
		'DTCOLLECTDATE',
		'Dtcollectdate',
		4,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40164' ).atfdfuda,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40165' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40165' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nucollectrecord]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40165' ).atfdcodi,
		'NUCOLLECTRECORD',
		'Nucollectrecord',
		5,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40165' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40166' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40166' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Dtcollectappli]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40166' ).atfdcodi,
		'DTCOLLECTAPPLI',
		'Dtcollectappli',
		6,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40166' ).atfdfuda,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40167' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40167' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nucollectentity]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40167' ).atfdcodi,
		'NUCOLLECTENTITY',
		'Nucollectentity',
		7,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40167' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40168' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40168' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Sbbankname]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40168' ).atfdcodi,
		'SBBANKNAME',
		'Sbbankname',
		8,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40168' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40169' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40169' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nuproduct]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40169' ).atfdcodi,
		'NUPRODUCT',
		'Nuproduct',
		9,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40169' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40170' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40170' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Sbproddesc]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40170' ).atfdcodi,
		'SBPRODDESC',
		'Sbproddesc',
		10,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40170' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40171' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40171' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nuconcept]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40171' ).atfdcodi,
		'NUCONCEPT',
		'Nuconcept',
		11,
		'N',
		CONFEXME_27.tbrcED_AtriFuda( '40171' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40172' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40172' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Sbconcdesc]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40172' ).atfdcodi,
		'SBCONCDESC',
		'Sbconcdesc',
		12,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40172' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40173' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40173' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nuaccount]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40173' ).atfdcodi,
		'NUACCOUNT',
		'Nuaccount',
		13,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40173' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40174' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40174' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nuprevbalance]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40174' ).atfdcodi,
		'NUPREVBALANCE',
		'Nuprevbalance',
		14,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40174' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40175' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40175' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nupayappli]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40175' ).atfdcodi,
		'NUPAYAPPLI',
		'Nupayappli',
		15,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40175' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40176' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40176' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Nuapplibalance]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40176' ).atfdcodi,
		'NUAPPLIBALANCE',
		'Nuapplibalance',
		16,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40176' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '40177' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '40177' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [Billliquidation]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '40177' ).atfdcodi,
		'BILLLIQUIDATION',
		'Billliquidation',
		17,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '40177' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41251' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41251' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41251' ).atfdcodi,
		'NOM_EMPRESA',
		'NOM_EMPRESA',
		1,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41251' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41252' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41252' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41252' ).atfdcodi,
		'CONTRATO',
		'CONTRATO',
		2,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41252' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41253' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41253' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41253' ).atfdcodi,
		'DIRECCION',
		'DIRECCION',
		3,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41253' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41254' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41254' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41254' ).atfdcodi,
		'MUNICIPIO',
		'MUNICIPIO',
		4,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41254' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41255' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41255' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41255' ).atfdcodi,
		'NOMBRE_CLIENTE',
		'NOMBRE_CLIENTE',
		5,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41255' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41256' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41256' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41256' ).atfdcodi,
		'APELLIDO_CLIENTE',
		'APELLIDO_CLIENTE',
		6,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41256' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41257' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41257' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41257' ).atfdcodi,
		'NOM_SOLICITANTE',
		'NOM_SOLICITANTE',
		7,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41257' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41258' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41258' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41258' ).atfdcodi,
		'DOC_SOLICITANTE',
		'DOC_SOLICITANTE',
		8,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41258' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41259' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41259' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MUN_SOLICITANTE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41259' ).atfdcodi,
		'MUN_SOLICITANTE',
		'MUN_SOLICITANTE',
		9,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41259' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41260' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41260' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41260' ).atfdcodi,
		'FECHA',
		'FECHA',
		10,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41260' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41261' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41261' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41261' ).atfdcodi,
		'DIA',
		'DIA',
		11,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41261' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41262' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41262' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41262' ).atfdcodi,
		'MES',
		'MES',
		12,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41262' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41263' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41263' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
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
		CONFEXME_27.tbrcED_AtriFuda( '41263' ).atfdcodi,
		'ANO',
		'ANO',
		13,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41263' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41264' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41264' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MUNICIPIO_ATENCION]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41264' ).atfdcodi,
		'MUNICIPIO_ATENCION',
		'MUNICIPIO_ATENCION',
		14,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41264' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41282' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41282' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TIP_PROD]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41282' ).atfdcodi,
		'TIP_PROD',
		'TIP_PROD',
		1,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41282' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41283' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41283' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TIPOPRODUCTO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41283' ).atfdcodi,
		'TIPOPRODUCTO',
		'TIPOPRODUCTO',
		2,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41283' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41284' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41284' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FECHAGENFAC]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41284' ).atfdcodi,
		'FECHAGENFAC',
		'FECHAGENFAC',
		3,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41284' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41285' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41285' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TOTALFACT]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41285' ).atfdcodi,
		'TOTALFACT',
		'TOTALFACT',
		4,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41285' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41286' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41286' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FECHARECAUDO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41286' ).atfdcodi,
		'FECHARECAUDO',
		'FECHARECAUDO',
		5,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41286' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41287' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41287' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CUENTACOBROPAGO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41287' ).atfdcodi,
		'CUENTACOBROPAGO',
		'CUENTACOBROPAGO',
		6,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41287' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41288' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41288' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [VALORRECAUDO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41288' ).atfdcodi,
		'VALORRECAUDO',
		'VALORRECAUDO',
		7,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41288' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41289' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41289' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [FECHAAPLICACIONRECAUDO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41289' ).atfdcodi,
		'FECHAAPLICACIONRECAUDO',
		'FECHAAPLICACIONRECAUDO',
		8,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41289' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_27.tbrcED_AtriFuda( '41290' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_AtriFuda( '41290' ).atfdfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ENTIDADRECAUDADORA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_27.tbrcED_AtriFuda( '41290' ).atfdcodi,
		'ENTIDADRECAUDADORA',
		'ENTIDADRECAUDADORA',
		9,
		'S',
		CONFEXME_27.tbrcED_AtriFuda( '41290' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_27.tbrcED_Bloque( 8321 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4134' ) ) then
		CONFEXME_27.tbrcED_Bloque( 8321 ).bloqfuda := CONFEXME_27.tbrcED_FuenDato( '4134' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [APLICACION_PAGOS]', 5 );
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
		CONFEXME_27.tbrcED_Bloque( 8321 ).bloqcodi,
		'APLICACION_PAGOS',
		CONFEXME_27.tbrcED_Bloque( 8321 ).bloqtibl,
		CONFEXME_27.tbrcED_Bloque( 8321 ).bloqfuda,
		'<APLICACION_PAGOS>',
		'</APLICACION_PAGOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_27.tbrcED_Bloque( 8322 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4135' ) ) then
		CONFEXME_27.tbrcED_Bloque( 8322 ).bloqfuda := CONFEXME_27.tbrcED_FuenDato( '4135' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [DETALLE_PAGOS]', 5 );
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
		CONFEXME_27.tbrcED_Bloque( 8322 ).bloqcodi,
		'DETALLE_PAGOS',
		CONFEXME_27.tbrcED_Bloque( 8322 ).bloqtibl,
		CONFEXME_27.tbrcED_Bloque( 8322 ).bloqfuda,
		'<DETALLE_PAGOS>',
		'</DETALLE_PAGOS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_27.tbrcED_Bloque( 8323 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4136' ) ) then
		CONFEXME_27.tbrcED_Bloque( 8323 ).bloqfuda := CONFEXME_27.tbrcED_FuenDato( '4136' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [DATA_INFORMACION]', 5 );
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
		CONFEXME_27.tbrcED_Bloque( 8323 ).bloqcodi,
		'DATA_INFORMACION',
		CONFEXME_27.tbrcED_Bloque( 8323 ).bloqtibl,
		CONFEXME_27.tbrcED_Bloque( 8323 ).bloqfuda,
		'<DATA_INFORMACION>',
		'</DATA_INFORMACION>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_27.tbrcED_Bloque( 8324 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_27.tbrcED_FuenDato.exists( '4137' ) ) then
		CONFEXME_27.tbrcED_Bloque( 8324 ).bloqfuda := CONFEXME_27.tbrcED_FuenDato( '4137' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [DATA_FECHAS]', 5 );
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
		CONFEXME_27.tbrcED_Bloque( 8324 ).bloqcodi,
		'DATA_FECHAS',
		CONFEXME_27.tbrcED_Bloque( 8324 ).bloqtibl,
		CONFEXME_27.tbrcED_Bloque( 8324 ).bloqfuda,
		'<DATA_FECHAS>',
		'</DATA_FECHAS>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrfrfo := CONFEXME_27.tbrcED_FranForm( '5334' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_27.tbrcED_Bloque.exists( 8321 ) ) then
		CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrbloq := CONFEXME_27.tbrcED_Bloque( 8321 ).bloqcodi;
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
		CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi,
		CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrbloq,
		CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrfrfo,
		4,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrfrfo := CONFEXME_27.tbrcED_FranForm( '5334' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_27.tbrcED_Bloque.exists( 8322 ) ) then
		CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrbloq := CONFEXME_27.tbrcED_Bloque( 8322 ).bloqcodi;
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
		CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi,
		CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrbloq,
		CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrfrfo,
		3,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrfrfo := CONFEXME_27.tbrcED_FranForm( '5335' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_27.tbrcED_Bloque.exists( 8323 ) ) then
		CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrbloq := CONFEXME_27.tbrcED_Bloque( 8323 ).bloqcodi;
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
		CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi,
		CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrbloq,
		CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrfrfo := CONFEXME_27.tbrcED_FranForm( '5335' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_27.tbrcED_Bloque.exists( 8324 ) ) then
		CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrbloq := CONFEXME_27.tbrcED_Bloque( 8324 ).bloqcodi;
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
		CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi,
		CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrbloq,
		CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56462' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56462' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40142' ) ) then
		CONFEXME_27.tbrcED_Item( '56462' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40142' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FECHAINI]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56462' ).itemcodi,
		'FECHAINI',
		CONFEXME_27.tbrcED_Item( '56462' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56462' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56462' ).itemgren,
		NULL,
		1,
		'<FECHAINI>',
		'</FECHAINI>',
		CONFEXME_27.tbrcED_Item( '56462' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56463' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56463' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40143' ) ) then
		CONFEXME_27.tbrcED_Item( '56463' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40143' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FECHAFIN]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56463' ).itemcodi,
		'FECHAFIN',
		CONFEXME_27.tbrcED_Item( '56463' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56463' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56463' ).itemgren,
		NULL,
		1,
		'<FECHAFIN>',
		'</FECHAFIN>',
		CONFEXME_27.tbrcED_Item( '56463' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56464' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56464' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40144' ) ) then
		CONFEXME_27.tbrcED_Item( '56464' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40144' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MESINI]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56464' ).itemcodi,
		'MESINI',
		CONFEXME_27.tbrcED_Item( '56464' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56464' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56464' ).itemgren,
		NULL,
		1,
		'<MESINI>',
		'</MESINI>',
		CONFEXME_27.tbrcED_Item( '56464' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56465' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56465' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40145' ) ) then
		CONFEXME_27.tbrcED_Item( '56465' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40145' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ANOINI]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56465' ).itemcodi,
		'ANOINI',
		CONFEXME_27.tbrcED_Item( '56465' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56465' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56465' ).itemgren,
		NULL,
		1,
		'<ANOINI>',
		'</ANOINI>',
		CONFEXME_27.tbrcED_Item( '56465' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56466' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56466' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40146' ) ) then
		CONFEXME_27.tbrcED_Item( '56466' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40146' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MESFIN]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56466' ).itemcodi,
		'MESFIN',
		CONFEXME_27.tbrcED_Item( '56466' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56466' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56466' ).itemgren,
		NULL,
		1,
		'<MESFIN>',
		'</MESFIN>',
		CONFEXME_27.tbrcED_Item( '56466' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56467' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56467' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40147' ) ) then
		CONFEXME_27.tbrcED_Item( '56467' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40147' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ANOFIN]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56467' ).itemcodi,
		'ANOFIN',
		CONFEXME_27.tbrcED_Item( '56467' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56467' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56467' ).itemgren,
		NULL,
		1,
		'<ANOFIN>',
		'</ANOFIN>',
		CONFEXME_27.tbrcED_Item( '56467' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56481' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56481' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40161' ) ) then
		CONFEXME_27.tbrcED_Item( '56481' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40161' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nuyear]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56481' ).itemcodi,
		'Nuyear',
		CONFEXME_27.tbrcED_Item( '56481' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56481' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56481' ).itemgren,
		NULL,
		1,
		'<NUYEAR>',
		'</NUYEAR>',
		CONFEXME_27.tbrcED_Item( '56481' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56482' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56482' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40162' ) ) then
		CONFEXME_27.tbrcED_Item( '56482' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40162' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Numonth]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56482' ).itemcodi,
		'Numonth',
		CONFEXME_27.tbrcED_Item( '56482' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56482' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56482' ).itemgren,
		NULL,
		1,
		'<NUMONTH>',
		'</NUMONTH>',
		CONFEXME_27.tbrcED_Item( '56482' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56483' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56483' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40170' ) ) then
		CONFEXME_27.tbrcED_Item( '56483' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40170' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Sbproddesc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56483' ).itemcodi,
		'Sbproddesc',
		CONFEXME_27.tbrcED_Item( '56483' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56483' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56483' ).itemgren,
		NULL,
		1,
		'<SBPRODDESC>',
		'</SBPRODDESC>',
		CONFEXME_27.tbrcED_Item( '56483' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56484' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56484' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40172' ) ) then
		CONFEXME_27.tbrcED_Item( '56484' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40172' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Sbconcdesc]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56484' ).itemcodi,
		'Sbconcdesc',
		CONFEXME_27.tbrcED_Item( '56484' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56484' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56484' ).itemgren,
		NULL,
		1,
		'<SBCONCDESC>',
		'</SBCONCDESC>',
		CONFEXME_27.tbrcED_Item( '56484' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56485' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56485' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40173' ) ) then
		CONFEXME_27.tbrcED_Item( '56485' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40173' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nuaccount]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56485' ).itemcodi,
		'Nuaccount',
		CONFEXME_27.tbrcED_Item( '56485' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56485' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56485' ).itemgren,
		NULL,
		1,
		'<NUACCOUNT>',
		'</NUACCOUNT>',
		CONFEXME_27.tbrcED_Item( '56485' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56486' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56486' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40174' ) ) then
		CONFEXME_27.tbrcED_Item( '56486' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40174' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nuprevbalance]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56486' ).itemcodi,
		'Nuprevbalance',
		CONFEXME_27.tbrcED_Item( '56486' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56486' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56486' ).itemgren,
		NULL,
		2,
		'<NUPREVBALANCE>',
		'</NUPREVBALANCE>',
		CONFEXME_27.tbrcED_Item( '56486' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56487' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56487' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40175' ) ) then
		CONFEXME_27.tbrcED_Item( '56487' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40175' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nupayappli]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56487' ).itemcodi,
		'Nupayappli',
		CONFEXME_27.tbrcED_Item( '56487' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56487' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56487' ).itemgren,
		NULL,
		2,
		'<NUPAYAPPLI>',
		'</NUPAYAPPLI>',
		CONFEXME_27.tbrcED_Item( '56487' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56488' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56488' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40176' ) ) then
		CONFEXME_27.tbrcED_Item( '56488' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40176' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Nuapplibalance]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56488' ).itemcodi,
		'Nuapplibalance',
		CONFEXME_27.tbrcED_Item( '56488' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56488' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56488' ).itemgren,
		NULL,
		2,
		'<NUAPPLIBALANCE>',
		'</NUAPPLIBALANCE>',
		CONFEXME_27.tbrcED_Item( '56488' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '56489' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '56489' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '40177' ) ) then
		CONFEXME_27.tbrcED_Item( '56489' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '40177' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [Billliquidation]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '56489' ).itemcodi,
		'Billliquidation',
		CONFEXME_27.tbrcED_Item( '56489' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '56489' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '56489' ).itemgren,
		NULL,
		2,
		'<BILLLIQUIDATION>',
		'</BILLLIQUIDATION>',
		CONFEXME_27.tbrcED_Item( '56489' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57611' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57611' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41251' ) ) then
		CONFEXME_27.tbrcED_Item( '57611' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41251' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57611' ).itemcodi,
		'NOM_EMPRESA',
		CONFEXME_27.tbrcED_Item( '57611' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57611' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57611' ).itemgren,
		NULL,
		1,
		'<NOM_EMPRESA>',
		'</NOM_EMPRESA>',
		CONFEXME_27.tbrcED_Item( '57611' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57612' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57612' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41252' ) ) then
		CONFEXME_27.tbrcED_Item( '57612' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41252' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57612' ).itemcodi,
		'CONTRATO',
		CONFEXME_27.tbrcED_Item( '57612' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57612' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57612' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_27.tbrcED_Item( '57612' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57613' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57613' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41253' ) ) then
		CONFEXME_27.tbrcED_Item( '57613' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41253' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57613' ).itemcodi,
		'DIRECCION',
		CONFEXME_27.tbrcED_Item( '57613' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57613' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57613' ).itemgren,
		NULL,
		1,
		'<DIRECCION>',
		'</DIRECCION>',
		CONFEXME_27.tbrcED_Item( '57613' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57614' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57614' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41254' ) ) then
		CONFEXME_27.tbrcED_Item( '57614' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41254' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57614' ).itemcodi,
		'MUNICIPIO',
		CONFEXME_27.tbrcED_Item( '57614' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57614' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57614' ).itemgren,
		NULL,
		1,
		'<MUNICIPIO>',
		'</MUNICIPIO>',
		CONFEXME_27.tbrcED_Item( '57614' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57615' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57615' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41255' ) ) then
		CONFEXME_27.tbrcED_Item( '57615' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41255' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57615' ).itemcodi,
		'NOMBRE_CLIENTE',
		CONFEXME_27.tbrcED_Item( '57615' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57615' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57615' ).itemgren,
		NULL,
		1,
		'<NOMBRE_CLIENTE>',
		'</NOMBRE_CLIENTE>',
		CONFEXME_27.tbrcED_Item( '57615' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57616' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57616' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41256' ) ) then
		CONFEXME_27.tbrcED_Item( '57616' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41256' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57616' ).itemcodi,
		'APELLIDO_CLIENTE',
		CONFEXME_27.tbrcED_Item( '57616' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57616' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57616' ).itemgren,
		NULL,
		1,
		'<APELLIDO_CLIENTE>',
		'</APELLIDO_CLIENTE>',
		CONFEXME_27.tbrcED_Item( '57616' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57617' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57617' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41257' ) ) then
		CONFEXME_27.tbrcED_Item( '57617' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41257' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57617' ).itemcodi,
		'NOM_SOLICITANTE',
		CONFEXME_27.tbrcED_Item( '57617' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57617' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57617' ).itemgren,
		NULL,
		1,
		'<NOM_SOLICITANTE>',
		'</NOM_SOLICITANTE>',
		CONFEXME_27.tbrcED_Item( '57617' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57618' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57618' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41258' ) ) then
		CONFEXME_27.tbrcED_Item( '57618' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41258' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57618' ).itemcodi,
		'DOC_SOLICITANTE',
		CONFEXME_27.tbrcED_Item( '57618' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57618' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57618' ).itemgren,
		NULL,
		1,
		'<DOC_SOLICITANTE>',
		'</DOC_SOLICITANTE>',
		CONFEXME_27.tbrcED_Item( '57618' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57619' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57619' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41259' ) ) then
		CONFEXME_27.tbrcED_Item( '57619' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41259' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MUN_SOLICITANTE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57619' ).itemcodi,
		'MUN_SOLICITANTE',
		CONFEXME_27.tbrcED_Item( '57619' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57619' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57619' ).itemgren,
		NULL,
		1,
		'<MUN_SOLICITANTE>',
		'</MUN_SOLICITANTE>',
		CONFEXME_27.tbrcED_Item( '57619' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57620' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57620' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41260' ) ) then
		CONFEXME_27.tbrcED_Item( '57620' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41260' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57620' ).itemcodi,
		'FECHA',
		CONFEXME_27.tbrcED_Item( '57620' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57620' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57620' ).itemgren,
		NULL,
		1,
		'<FECHA>',
		'</FECHA>',
		CONFEXME_27.tbrcED_Item( '57620' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57621' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57621' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41261' ) ) then
		CONFEXME_27.tbrcED_Item( '57621' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41261' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57621' ).itemcodi,
		'DIA',
		CONFEXME_27.tbrcED_Item( '57621' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57621' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57621' ).itemgren,
		NULL,
		1,
		'<DIA>',
		'</DIA>',
		CONFEXME_27.tbrcED_Item( '57621' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57622' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57622' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41262' ) ) then
		CONFEXME_27.tbrcED_Item( '57622' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41262' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57622' ).itemcodi,
		'MES',
		CONFEXME_27.tbrcED_Item( '57622' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57622' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57622' ).itemgren,
		NULL,
		1,
		'<MES>',
		'</MES>',
		CONFEXME_27.tbrcED_Item( '57622' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57623' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57623' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41263' ) ) then
		CONFEXME_27.tbrcED_Item( '57623' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41263' ).atfdcodi;
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
		CONFEXME_27.tbrcED_Item( '57623' ).itemcodi,
		'ANO',
		CONFEXME_27.tbrcED_Item( '57623' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57623' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57623' ).itemgren,
		NULL,
		1,
		'<ANO>',
		'</ANO>',
		CONFEXME_27.tbrcED_Item( '57623' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57624' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57624' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41264' ) ) then
		CONFEXME_27.tbrcED_Item( '57624' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41264' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MUNICIPIO_ATENCION]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57624' ).itemcodi,
		'MUNICIPIO_ATENCION',
		CONFEXME_27.tbrcED_Item( '57624' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57624' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57624' ).itemgren,
		NULL,
		1,
		'<MUNICIPIO_ATENCION>',
		'</MUNICIPIO_ATENCION>',
		CONFEXME_27.tbrcED_Item( '57624' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57675' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57675' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41282' ) ) then
		CONFEXME_27.tbrcED_Item( '57675' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41282' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TIP_PROD]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57675' ).itemcodi,
		'TIP_PROD',
		CONFEXME_27.tbrcED_Item( '57675' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57675' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57675' ).itemgren,
		NULL,
		2,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57675' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57676' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57676' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41283' ) ) then
		CONFEXME_27.tbrcED_Item( '57676' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41283' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TIPOPRODUCTO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57676' ).itemcodi,
		'TIPOPRODUCTO',
		CONFEXME_27.tbrcED_Item( '57676' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57676' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57676' ).itemgren,
		NULL,
		1,
		'<TIPOPRODUCTO>',
		'</TIPOPRODUCTO>',
		CONFEXME_27.tbrcED_Item( '57676' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57677' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57677' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41284' ) ) then
		CONFEXME_27.tbrcED_Item( '57677' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41284' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FECHAGENFAC]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57677' ).itemcodi,
		'FECHAGENFAC',
		CONFEXME_27.tbrcED_Item( '57677' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57677' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57677' ).itemgren,
		NULL,
		1,
		'<FECHAGENFAC>',
		'</FECHAGENFAC>',
		CONFEXME_27.tbrcED_Item( '57677' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57678' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57678' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41285' ) ) then
		CONFEXME_27.tbrcED_Item( '57678' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41285' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TOTALFACT]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57678' ).itemcodi,
		'TOTALFACT',
		CONFEXME_27.tbrcED_Item( '57678' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57678' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57678' ).itemgren,
		NULL,
		2,
		'<TOTALFACT>',
		'</TOTALFACT>',
		CONFEXME_27.tbrcED_Item( '57678' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57679' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57679' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41286' ) ) then
		CONFEXME_27.tbrcED_Item( '57679' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41286' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FECHARECAUDO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57679' ).itemcodi,
		'FECHARECAUDO',
		CONFEXME_27.tbrcED_Item( '57679' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57679' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57679' ).itemgren,
		NULL,
		1,
		'<FECHARECAUDO>',
		'</FECHARECAUDO>',
		CONFEXME_27.tbrcED_Item( '57679' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57680' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57680' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41287' ) ) then
		CONFEXME_27.tbrcED_Item( '57680' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41287' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CUENTACOBROPAGO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57680' ).itemcodi,
		'CUENTACOBROPAGO',
		CONFEXME_27.tbrcED_Item( '57680' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57680' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57680' ).itemgren,
		NULL,
		2,
		'<CUENTACOBROPAGO>',
		'</CUENTACOBROPAGO>',
		CONFEXME_27.tbrcED_Item( '57680' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57681' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57681' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41288' ) ) then
		CONFEXME_27.tbrcED_Item( '57681' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41288' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [VALORRECAUDO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57681' ).itemcodi,
		'VALORRECAUDO',
		CONFEXME_27.tbrcED_Item( '57681' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57681' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57681' ).itemgren,
		NULL,
		2,
		'<VALORRECAUDO>',
		'</VALORRECAUDO>',
		CONFEXME_27.tbrcED_Item( '57681' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57682' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57682' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41289' ) ) then
		CONFEXME_27.tbrcED_Item( '57682' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41289' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [FECHAAPLICACIONRECAUDO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57682' ).itemcodi,
		'FECHAAPLICACIONRECAUDO',
		CONFEXME_27.tbrcED_Item( '57682' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57682' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57682' ).itemgren,
		NULL,
		1,
		'<FECHAAPLICACIONRECAUDO>',
		'</FECHAAPLICACIONRECAUDO>',
		CONFEXME_27.tbrcED_Item( '57682' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_27.tbrcED_Item( '57683' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_27.tbrcED_Item( '57683' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_27.tbrcED_AtriFuda.exists( '41290' ) ) then
		CONFEXME_27.tbrcED_Item( '57683' ).itematfd := CONFEXME_27.tbrcED_AtriFuda( '41290' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ENTIDADRECAUDADORA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_27.tbrcED_Item( '57683' ).itemcodi,
		'ENTIDADRECAUDADORA',
		CONFEXME_27.tbrcED_Item( '57683' ).itemceid,
		NULL,
		CONFEXME_27.tbrcED_Item( '57683' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_27.tbrcED_Item( '57683' ).itemgren,
		NULL,
		1,
		'<ENTIDADRECAUDADORA>',
		'</ENTIDADRECAUDADORA>',
		CONFEXME_27.tbrcED_Item( '57683' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55951' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55951' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56462' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55951' ).itblitem := CONFEXME_27.tbrcED_Item( '56462' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55951' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55951' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55951' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55952' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55952' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56463' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55952' ).itblitem := CONFEXME_27.tbrcED_Item( '56463' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55952' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55952' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55952' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55953' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55953' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56464' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55953' ).itblitem := CONFEXME_27.tbrcED_Item( '56464' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55953' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55953' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55953' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55954' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55954' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56465' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55954' ).itblitem := CONFEXME_27.tbrcED_Item( '56465' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55954' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55954' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55954' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55955' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55955' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56466' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55955' ).itblitem := CONFEXME_27.tbrcED_Item( '56466' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55955' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55955' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55955' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55956' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55956' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8363' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56467' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55956' ).itblitem := CONFEXME_27.tbrcED_Item( '56467' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55956' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55956' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55956' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55970' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55970' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56481' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55970' ).itblitem := CONFEXME_27.tbrcED_Item( '56481' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55970' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55970' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55970' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55971' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55971' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56482' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55971' ).itblitem := CONFEXME_27.tbrcED_Item( '56482' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55971' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55971' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55971' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55972' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55972' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56483' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55972' ).itblitem := CONFEXME_27.tbrcED_Item( '56483' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55972' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55972' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55972' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55973' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55973' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56484' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55973' ).itblitem := CONFEXME_27.tbrcED_Item( '56484' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55973' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55973' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55973' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55974' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55974' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56485' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55974' ).itblitem := CONFEXME_27.tbrcED_Item( '56485' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55974' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55974' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55974' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55975' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55975' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56486' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55975' ).itblitem := CONFEXME_27.tbrcED_Item( '56486' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55975' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55975' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55975' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55976' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55976' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56487' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55976' ).itblitem := CONFEXME_27.tbrcED_Item( '56487' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55976' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55976' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55976' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55977' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55977' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56488' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55977' ).itblitem := CONFEXME_27.tbrcED_Item( '56488' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55977' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55977' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55977' ).itblblfr,
		16
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '55978' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '55978' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8360' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '56489' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '55978' ).itblitem := CONFEXME_27.tbrcED_Item( '56489' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '55978' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '55978' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '55978' ).itblblfr,
		17
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57060' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57060' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57611' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57060' ).itblitem := CONFEXME_27.tbrcED_Item( '57611' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57060' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57060' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57060' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57061' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57061' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57612' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57061' ).itblitem := CONFEXME_27.tbrcED_Item( '57612' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57061' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57061' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57061' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57062' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57062' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57613' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57062' ).itblitem := CONFEXME_27.tbrcED_Item( '57613' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57062' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57062' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57062' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57063' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57063' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57614' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57063' ).itblitem := CONFEXME_27.tbrcED_Item( '57614' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57063' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57063' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57063' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57064' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57064' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57615' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57064' ).itblitem := CONFEXME_27.tbrcED_Item( '57615' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57064' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57064' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57064' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57065' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57065' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57616' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57065' ).itblitem := CONFEXME_27.tbrcED_Item( '57616' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57065' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57065' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57065' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57066' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57066' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57617' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57066' ).itblitem := CONFEXME_27.tbrcED_Item( '57617' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57066' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57066' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57066' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57067' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57067' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57618' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57067' ).itblitem := CONFEXME_27.tbrcED_Item( '57618' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57067' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57067' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57067' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57068' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57068' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57619' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57068' ).itblitem := CONFEXME_27.tbrcED_Item( '57619' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57068' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57068' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57068' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57069' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57069' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57620' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57069' ).itblitem := CONFEXME_27.tbrcED_Item( '57620' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57069' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57069' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57069' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57070' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57070' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57621' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57070' ).itblitem := CONFEXME_27.tbrcED_Item( '57621' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57070' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57070' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57070' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57071' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57071' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57622' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57071' ).itblitem := CONFEXME_27.tbrcED_Item( '57622' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57071' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57071' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57071' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57072' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57072' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57623' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57072' ).itblitem := CONFEXME_27.tbrcED_Item( '57623' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57072' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57072' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57072' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57073' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57073' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8362' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57624' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57073' ).itblitem := CONFEXME_27.tbrcED_Item( '57624' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57073' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57073' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57073' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57124' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57124' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57675' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57124' ).itblitem := CONFEXME_27.tbrcED_Item( '57675' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57124' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57124' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57124' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57125' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57125' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57676' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57125' ).itblitem := CONFEXME_27.tbrcED_Item( '57676' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57125' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57125' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57125' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57126' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57126' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57677' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57126' ).itblitem := CONFEXME_27.tbrcED_Item( '57677' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57126' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57126' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57126' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57127' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57127' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57678' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57127' ).itblitem := CONFEXME_27.tbrcED_Item( '57678' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57127' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57127' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57127' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57128' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57128' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57679' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57128' ).itblitem := CONFEXME_27.tbrcED_Item( '57679' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57128' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57128' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57128' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57129' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57129' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57680' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57129' ).itblitem := CONFEXME_27.tbrcED_Item( '57680' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57129' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57129' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57129' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57130' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57130' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57681' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57130' ).itblitem := CONFEXME_27.tbrcED_Item( '57681' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57130' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57130' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57130' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57131' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57131' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57682' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57131' ).itblitem := CONFEXME_27.tbrcED_Item( '57682' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57131' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57131' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57131' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_27.tbrcED_ItemBloq( '57132' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_27.tbrcED_ItemBloq( '57132' ).itblblfr := CONFEXME_27.tbrcED_BloqFran( '8361' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_27.tbrcED_Item.exists( '57683' ) ) then
		CONFEXME_27.tbrcED_ItemBloq( '57132' ).itblitem := CONFEXME_27.tbrcED_Item( '57683' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_27.tbrcED_ItemBloq( '57132' ).itblcodi,
		CONFEXME_27.tbrcED_ItemBloq( '57132' ).itblitem,
		CONFEXME_27.tbrcED_ItemBloq( '57132' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
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
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E61386239626335642D306666642D346330622D386230372D3132646564396163346561383C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C52696768744D617267696E3E322E35636D3C2F52696768744D617267696E3E0D0A20203C4C6566744D617267696E3E322E35636D3C2F4C6566744D617267696E3E0D0A20203C426F74746F6D4D617267696E3E322E35636D3C2F426F74746F6D4D617267696E3E0D0A20203C72643A5265706F727449443E66333532653062622D353464622D346361332D613661382D3539343837333039323038313C2F72643A5265706F727449443E0D0A20203C456D626564646564496D616765733E0D0A202020203C456D626564646564496D616765204E616D653D226C6F676F5F656669676173223E0D0A2020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A20202020'
		||	'20203C496D616765446174613E2F396A2F34414151536B5A4A5267414241514541534142494141442F327742444141454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151482F327742444151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151454241514542415145424151482F7767415243414273414E41444152454141684542417845422F385141486741424141494341674D424141414141414141414141414141674A42676342425149444367542F784141644151454141674D4141774541414141414141414141414141426763424251674442416B432F396F4144414D4241414951417841414141472F7741596669386E692F622B504B41414141414141414141414E62376253524E6E56655436712B33674141414141414141414147464C6E52504C2B4562485633733879645A34314776506B306E3849414141414141414141386677314249493538364858504576702F5834746C2B657658322F6562726A6C703246486D5141414141414141415952303572334E666E66664C56664E343058745451655466634538736F506C54337A5A4632722B66507941414F4D59355A4449414141414D49452F507956775A2B752F7A73393069334F776450724D4D392F513568773930584E3269756D4A64396B787A46506539474E4D7768413348483548484B58516A447666313334764E36396C4E50336B41414141425746786C364D66667174776C634452486247536570744B6E627434357853684A6C74483547397A575A66564F42615474534430686449386E32475656636D61617A62564C33727A76627A5158532B6D4A464762494B697561493839726E4D646474647978365478636D316637563063676B6E44357643717861777A7A576261584D4473526E4E53584E45427A2F764F6C4C4C71693670345969394D616D722B724F42624C2B542F4147335956394B345272322F34425131302F794276654C7A4B5A4666575A5762636C4558666332395655736446637737736A6B6D6C46437039586262644C584E63376453526D6D6342726D74326A706651437A634C324F716D72584E703247315263584F63314F38373137496A7371447A6172792B74576272512B764F74724D35533057636350644857632F566D426149736D453037332F414D3058746379396239623566572B662F716A6A76364D4F536530766E4F363234757A7A563753302B6B656736652B67655A354B517977'
		||	'4D383175776944507132732B700A652F592B5375465168736D702F70623435376E66724E664847487364543946655962484B343656723174616E392F31354959552F4A79365A5264412B4759486145633039763437564465584F3347637A467232796F307A47465739304A305A5548666E4F637A4B377379486C67317242537A616974746F62704F4A6B38726274764235393152755778366C6B4B6B5045356C5A7654563663357A71716F746858647A50705A65646D5233576C30526A6F506D6E637579646A745A696471526E332B7868677948474D63736778587461314F77697365725A46784B5A5774306630487778794765474F575751474B784C7A34425866755A7059506F3939756364767476457A6B414141414D596A374B496C6832773130735950507441536D4A6243314F333662325058303749492F4C71437A3841414141414141414D4E56627651396A34764A33337165353076732B7237767A2B2F444C32595A787264707A6E494141414141414141414141412F3851414C42414141674943416741444341454641414141414141414251594442414948414145494530415145525557467A41324E784955474341304E662F61414167424151414242514C2F41416A735179352B6F6257537170722B68574777646F656F33773566477A2B6C6D6D4E62636559464B38784C306E763636342B4D3861677235353579353856396F484C7972724F54487A76534F6832595154333034516D723341415871787A484C4C444A4D50346A694858665758586F337931314F776B716455746B73616E767331737775465632586769543353497A526C484A77325A6F4C77763636363535396464633856486865644D584465774A62494150454238624B447645544351496662634C48655A4F474753784D73676F46304F514830796C5273584A566B754C2F77427272764C4873526337494339756672745241644E444A2F625844796B4F443648464366682F5A4E557A3034783277316A516B785A6B6167536C526938524B626E504A766A5873655A3937414C59475478474B6D4F613775684A59724A4D6F50445572766947544B38793175704F5A622F735A7050357961714659336D4C3262584634334638563137375845374850466332352B757863354F73512B594E7463434C566834317376556F535A344C724A655349553338743351666E4E5057764E4A4153713232433634566B4D4A7735305162597277386A597A63517145707477755676722B744D64593564434E58704634313747364879376D6D7363664A34757350527938383964647151694C33527878357A5344366D4E436A747A396436757331366A2F3831712F436855575458303738744C6638704E2F4C64703073364C'
		||	'2F723759796E4B6E4F6C2B71550A6174754862306C485532706C357442506F736146634961534F7A71426677356E4B32437962494C787A3262414765555A31575778474865615576535473577A72766B4C7355654D4D614141796C6E342F424C72477066514A2F3539416E376D73746373616F465874487641302F66697A735556335237774D50624E317546643534504471772B6159696F56796278716934334C596A54657A735A7958682B623462726C70316C4F6976706674372B6D31396F71794D4A2B787358766A31472B4F7A366D574E67343578714937425A3265796D4D32497576496C6D7A6C4848684668396A646943794E397162585732375561466F636A45522B79524343793358794375652B7575673673566568527166644747436B3774737836734C45665866586654305A4B6A354C655A6D7374706C2B556F44546D526C5048765234706F507275645541577555784E4F68594D4C51733559747231433533535768412F75466446567833712F77442F7841424F45514143416745434241514242774D51426773414141414241674D45425245534141595449516355496A46424542556A4D6B4A5263544D32514167584D464A545657466964485742677053687364516B63704753744E4D5749445645566D57546C62505231662F6141416742417745425077482F414B695452794E4B694D47614278484B4239687A476B67552F77414F795257302F6A44394A35687A64666C37455863745A39533159695934396444504F33706868422B426B6B4B7272384271655043504E7A5A696C7A413175567072375A6A3577734F337474794543704771647441716D6C4B7178686949304349716F675166705069377A4F7555797365457153423665495A2F4D46484A53584974364A51772B7272545547454546696B6B6C6843564F356550437A6D464D4A7A477465773232706C31576B3748325366654456646A723258655447657A666C42395664782B51774F73496E6362566474736576752F7671772F6972392F785059664854394635727A73664C6D4376355274444C464673716F5470314C55333063432F5663364232445036573052574C656B45695352355A486C6C64704A4A475A354A485A6E64335936737A75784C4D7A456B6C6D4A4A50636E5867652F62332B4848672F7A68563571682B614D745954353778734D5A564353666E5773753464634D773274597242555737456A507157575830617977773530614C56302B7176563976627630394E5039302F6F754D714A5A677437394E5743787874324F317537612F3733543139765471506A727834335A5A7A6B36484C775967593558745730424252724D3443513636453674444372374F796B43772F754748794459'
		||	'717357305A6D444945312B70750A5851752B6E6457414F7353396D31306C4F6968424C5375577364627258364D386C5735546D537857735173556B686C512B6C6C492F7056314F7153497A527572497A4B655575593035393551715A5A566A6A764C7568765149645669794659615449767579527A6F797A516F78334C484D674A49416339783250754F782F48394578686A72593572457843524B4A5A35586232574B4D45757A652F5A56526A3766446A4E35796650356A4A5A717836327964796133736B5561704535506C3464564A5A656842306F2F6F354276365337697936673871636D35506D32573738334C464844535248615733493677744A4957325675704645584D7242642F6F514459473379514578732B65355A7A584C5536775A616E4A427631364E6748713137473354643072413156325858317178456731425A6447425048366E624D53515A7250594E32486C3868516779454B6C6A36626443517853374639745A36746F47527663696E454F7741347931414547314544754865636475342F6450683766613048636572746F64654D6C6B616D4A7054354338356A71316C337A4F715049565855445859675A6A70723330423763667271386B6676724A2F594C332B58342F585635492F6657542B77587638414C3859486D7243637A65612B5A725457664A64447A47364365445A356A72644C5472527075336443543675753351612B3431356B3857735067376B74436C546C79396D764B59724A53646174614A304F6B694A4F5962426D6B6A505A67735854423950563342674D5034774C6C38684852586C3877645347354D5A546C424A7035536E50623268426A6C3364546F624E6436374E323752394E70782F6A516C362F547066394844463575314457366F7933553666576C574C66732B624533616274644E36362F655066396B385338694D4E34613569514D51317568466A34794E4F7A5A575249574834464A5A452F6834727754577034613164444C50596C6A6767695854644A4E4D346A6A52646442713773464770413150484B764C31666C6E43316358426F58516457334D502B38584A4176586D4F7666543072484839305349756E626A4A59326C6C71553144495634374E5764537278755062743264473934354539306B55686B50634563633563727A6370357158484D7A7A565A46387851734F75686D71757A42512B674364614A6C4D63327A5145674F4651534242344875796549574E436E51505479534D50765531484F682F704150346A676748554851673974434F326E33635749756A504C463845646750773137663363654948356E357A2B52742F694F4F574D4B4F597335527778736D6F4C72544C356752646670394F764C4D4430757046'
		||	'76314D653354714C37363638660A72474C2F77434A322F38415A682F2B707853782B4F384A4B47536C755A6161394C6E45564B5A54484E414937475068744E477262624E72386F3977656F68516F51396D3738593030546B3652796D2F35754E754533656E727638414B395665734632614D506F3952365055507364394F4D412F68766D7072543454474A464E6A716B396D65614B704C556461386B4C315A514731426B4C7853754E6E66384162646D436E6A4750345253354C4877554B74337A7A337173644D6E3577482B6C39654D51626E6558516A71376478636C534E642B6F4A317A576578584C39587A655774783159695373616E31537A756F334D6B45532B755667766337516442373664745976476A6C6435565236655968526D5665733846566C51456B4D3869783233666176592F5272497831374C3234627859354D5669766E624C667868536E30503841745545663067456645446A4C3830596E423471746D4D684C4C4855746D46612B3246354A4865784131694A43714274684D614D5357495545616274534E5738617557775532342F4D4D4439636D4B6D70556476716A7A6A427A37366A5652714F7A4548586A432B4A334B6D616E6A71705A6D6F575A6E45635557526945416B5A746F56524D6A7931777A4F7752454D6F5A32374B44786576303862576C7558374D4E57724470314A706E574F4E647A425647356A395A6D4956563932596744697A347938717779744844426C6261417270504658686A69645439596F4A37455532356632736B4D65702B304233474338542B576337626A6F776D37547454794C46586975774B76585A76327277533249312B373652304A4A374435663151453751386B5961754F3657733754686B39782B51783936306848336753514474392F384130506739683076387976646B5147484431444F67303949737A486F562F774B70316E582B475035664748454A6535616A794B6A366644326C6B553764573874624B775745312B797059515373542B344166486A774670745A3539536364316F596A4957472B3736546F31464A3766427247673767616E346E62386D5230383550703847302F704141504869422B5A2B632F6B6266346A6A47545A474339424C696D737266557435633141357361736A4B776A43417364597977594166564A2B48487A76346C66756E4D762F6F58502B5878693846507A5679524E4C7A5732554E37477A35573158617758687344536F68514D4A6F324A694854556762514E646669653244705135444E346E487A3775686479644B704C734F6A394B657A48452B31766732316A6F644F4D5A7950687556594D7661786A577439724757594A52504B73693751686B556A304B5151563039394E474F6F'
		||	'31303435562F4F726C372B66630A5A2F78735048696E6D4A636E7A586272623961324C4355344642394F344B4873506F56476A47566968377344307777506651636D65465748755961746B3836624E697A6B496C6E6A72787950576A717776336A4461615379546B65707978564642434C4671706B666D50487759725035504831642F6C366C32574B4C714D476349722B6B4667463130486258545854333150666A4C387430755A2B5673465479463571464B72486A723169564F6B724D6B654E6548594A706A30712F71734B356C654F5A64454B645031683074342F77596F72305A6243544E3344505774354330345A42334F74646E433931374165686A36644471516374466A712B5374523469334C647879533630374D73545153764556566748526744766A4A4D5450735153464F6F73614B7751654A575379467644636C4C504937517A346E7A636839573261356F6B4C534F5353486B534C54516E566B36386831306D4F7649616367794A59546D73794C6561636556615A356B6F6976302B2F716849306C36686666312F547436585339572F6A48386863715763726A6337796E6C59646D50747854324B73646A7A734C6F726B4861322F7231334A5754547164534E324731524746312B587839724E59354977567056552B557A56575352744275534F664733594E6F62376D6C654C6437626971366A56653367616943767A4A4944394930324D52312B35455338597A2F41466D6B6B483958354D506C2F6E537A6E5968734B59764C4848523750637248547153534D2B7678387A4A4F6E596B61526A3234352F41504A764D4F763733756662587548516A2B2F54763850666A395474675872347A4F38777A4B523835324B2B4F70456A5453746A784C4A5A6B6A6276714A724E6859333976565358743664537A42564C45364B6F4C4D6675414866587365326E632F4854696151797979536E336B646D2F326E586A78412F4D2F4F66794E7638527834637A52562B63384C4C504C4844456B6C6E644C4B36787872725373714E7A75516F314A414770376B676366504F492F6658472F3236722F414D336A495861647645356A796C75745A36654E74395479383855327A66576E32622B6D7A626432787475756D3761326E73654F56507A7135652F6E7A4766386244786B762B7A722F77444972582F77507879722B64584C33382B347A2F6A6F655045536F31506E484E4B5177457468624D624D50727250476B6D346468716F63736D756E757047703031343551357A35666E35627835735A536E556E70556F6F726B45387978504359464B627472486355496A4C4B772B734154384F4F61626C652F7A4A6C376C535153313537387A785344554230333642687238447071443852'
		||	'33343854387A624D484C6D46530A5234365565446F577059316368624530734B42544B6F3033434A5547774E714157636744586A7736384F384A6E38534D7A6C5A5A724A61314C43744F43626F787872446F4E4A326A2B6D4D6A3768494172783759796839572F556336592F4834726D624B342F46674C527179787877714A6D6E32487938526D5179753773575763794B775A695559464470743043552B5673377933797A79396E703172334A6350426278387063515370752B6862793169525443306A4D6F3331323364514B684B485254786B50424C4A51713734374D5662653153566A73775054646A715054714A4C45594158556C326365333166563277575876594C4B314D68516B644A6F4A6B3349704957784557485672536A51376F356C477867564A485A6C306456492B544E344B506E446C44493443526C6A6B6D685A4B387A6173734E754569656E4B2F774446456F554E743150543345642B5043753359355A357179664C575A694E4B336543565A5970665473794E417974464871667243564A707843513232586447554C62303134384D72547A5A766E354A47372F4144307334585437556C6E4A72493334656D494166445474723850455557377547726376593165706C4F5A636858786C4F503749414A73575A70744E5374614747496D61516655334C3853416558634A553561776D4E77644C38686A717156772B30495A7046477330374B4364476E6B4C536B616E5464743137635A693641766C597A715737796B664252396A2B74376E2B4438666B3572786C6E4D6376355047302B6E356D33584D555856665A48754A48316E3062516666325034486A395A336D2F2F414D712F74722F35666A395A376E483738582F626E2F792F4849664A47623564782F4E4662496D6F5A6376557277314F6859615664386347526A62716B78707347363146706F473762767534776668567A566A73336963685038326D436C6B36567562703347615470515759355A4E696D4141747355375275477037616A69354730395331436D6D2B617650456D76596235496D566454384271652F4744384B756163666E4D546B5A2F6D336F55386E53747A434F347A53644B437A484C4A735577414D32785474476F31506255636339636A347A6D7436354632766A73326B5A574352676A4E6267423752537862306D6445636E5A4B6D2F70626D394436364350775579676B627A57626F563671686D656459705A43714C39767075594630433673643071414161466837385A4F4B6E466B3773474F6470714D56755747704D7A4352703449354448464F574349704D36714A644169676239753374787A667942507A5068734A4E556B53766C38646A71316378542B6D4B784830597430556A'
		||	'67457879777547324E6F564F720A4B333253754C384D7565306C6B676A6C474B676D4B72596C572B36527978677376654F75643075304F7843735071736676493476384167337A456C755263645053733142734555397178304A7054303036724E436B636F6A4856333746366A6B52376478336138637A2B472B627A474E3564577259704A6178474B6A6F5456354A4A464453695465306B633671796C4E704F674B4B64564863687A7350496E695630506D3371326D6F4852444238374E35506166536459544C744B6866663650344541486A6B7A776D6C78742B4C4A38777A56355871794C4C566F316D61524F744777614F616559694D61526B417243714F484A3962674C7466354D6463386E4E7133654B54307550752B357839355876322B494A2B4F6E4850666874694F656F6F7273566B34764F316B5879655A71703143776A3955556475494F686E695268364857534F7A423336556E75686F57755A6349693065637363797446746A69356878752B37693777476F366C727051724E6A5A64414E7873517058637475366B544870446C584674513538356C6B726B54307333526A793947654539614F78313759362F546B52646B6A5232486B334C457A37566B695A7679696A6A443876434849535A2F4A6247764C58656E6A6F795179596D693544326D44665638336B47534A726B67394B513136315A5470484C4A4C657A43494448564F392F59792F59542F562F626E2B37386543535353547153645354376B2F7350696A79686D2B5A4A63645A78455563777031724563735A6D574F56326B634F716F473055676761617379674539794233346C354938537034764C5456636C4C58374C30704D7241384F696E52543032754562514F3447335544324776626A6C447769747733612B52356B6575496137704D6D4D694A6D4D377141794C616B47324E5930663870454F714A6475782F5178312F595962553966386C497944346A33552F6970376633636650463739305838656D75762F7742663363476551796D6664746D594D444967434F5178557343796745676C564A314A31494776734F486C6C6B2B7649372F367A452F346E396C6F354F354A7A4E6B7362666E4E58704C313854524664656C65786769675237336D39574D6B306431706F3549463666526A364A5A4744712F484F764E452B45534B766A704B693356676B796C6B575A5930306F553559456176436A65715733666B6D574376474150517338686447574D5341673645647765345077492B42483438637A354B2F566D7774484776496C6A49334C48586143717432644B464F704A4A596C6A674D6B514F6C6D536C457A733231424E3342596F4F4C44354B44437A53564638396C59364450416B364A58387A'
		||	'6245525A466B546473695A33370A464E2B3154324C6535343562745358635A48616C757933704A5863536D616D74423639694A756A5A716D7370597865587352796F5564355A45494B4E4B3558647879376D73786C636F583073506957624C6C336D787A317138634D4E356F634E4A5375794242644E3271727A547244316844745573305964465036474F5738582F7078644C4D7235434F614365576539636D6C5343772F556C72315A4A5A6D616E585A2F554961706969553930556354637634697A35337A464B4B7732516853765A6B6E48566C61434F4A6F59346C6B6B3350476B6175355549526F386A796658646D4E664831716B307469465857536176547250724C4979644B694A6C7268593259786F7969655465364B476C3950554C6245307957446F3553617259736D346B394A5A307279303868646F5349746E6F6D6464314F654575736E516931446B6A30446978694B6C6733475A726B623378574537313739797534387076364A67614B5A445662365268493166704E4B4E6F6B4C6256417259624831445438764538586B6C7543454C4E4D464C5832523763303637397469784C496D38324A6738776553566C594757546446687145464B686A346F355936754D6175394F4F4F784F70513176795164316B44544B505A6B6D4C724A397348394D2F2F3851415552454141674942416751444177514C4377674C4141414141514944424155524567414745794548496A45554D6B454946534E524542636B4D304243556D46786B644D674E545A55596E52316770537A7442596C4D44524455364778474656575A484B426B355855342F442F3267414941514942415438422F634E464A4773547570565A6C4C786B2F6A4972744757483964475858343666684F4377382B647974584751646A596B306B6654586F7772357070694F3275795055366474546F506A78346E346D4C4632384574534D52556869765959462F6C5570336154636465376C6263544F78486D646D6675574F6E345234593876664E324C664C324530745A554C306779364E485151367074507641576E2B6D627341794A41644E427166455843506D4F58336C67586661786274646955647938495569796F4871666F394A4E41652F542B7651636138562B61385864356B746372304A42647634796E375A6D4868625748474352306A7131706E41594E6473737A4F4B77496147434B5357596F5768535838455A31556F705A565A7951674A414C6B4B7A6B4B4E653543717A61643946556E3048484C4747665035716C6A76534A354F705A63612B577445433835313158755547784F2F764D4E4E543234564552566A525652455656524541434B71674B7171423243714141414F77413048626A2F415044'
		||	'6A3557562F6D487733787958650A5336456E7A586D356246624935324C75764B31682B6B49716B6353616C4779426B6C39697653394F4B71384A724B737468344858354C566C58743838704D356B74324938445A335348644A4973636D59466C6D646A7559744A5A674C4536376D494C48585458384538622F454337795A7A4E346650524C764853735838766B7165353478647153434C484C584C4168645458664A694D794352493532676D614E756C7466774C624735726C762F4C4C4853725A715A355931783832306F34707861764D7249774478794E594B70504733645772414875472B786C386D5950756175644A5439386B482B7A58386C5035546439782F464862336A716D54786D507A574F76596A4C55344D686A4D6C576C703371566C424A425A725472746B696B512F416A7572445230634C4A47797571734C474D66354F6E6A665069376B6C6D586C6D386D7974636B42445363753557594770626D415A593745324C73516447303636376A5673535277724A4949416B6B63694A4A4736795275697647364D48523063616F364D756F5A57476855715347476848344A342B57707337346F7A59756B7374697855723472445636793673587532414A6B6A68553644664D39324A664C366E5145366767636A59636368637359486C664775425877654C70343436626D696E6D7277716C6D7A74625136326248566D4A506D485539645272786D65664B324872782B30774D4C566A56592B677976743030337A394F54626F714567414D37456B6A333947416F35616E6C6C6161724F4A5731316C552B575643336657524433477631393150665136672F592B57377976466335583552357669552B3134584C57634C614B6F756A34374D774378433830683832326E6678346A67516558646C4A322B5048674634725451326176496E4D453461704D715163743348374E576E47372F4E637A39775962436C52534A32644761506F6653653078694C6A48592B316C626B46436B697957624446496B5A316A42594B57304C75516F3744346E31342B31707A642F4559503766542F626366613035752F694D483976702F74754D3579336C7558665A526C59456839733670673254777A377568302B7072306E62627031553031396465336F654F582F44484B5A6572486575573078646564424A585531327332586A59626B6B4D48557270476A4B564B37706435486D32616264637234562F4E6C4B53347564362F546B72526D4D347A6F2F3678616872416878666C397A7262744E76634C70714E64654C6E684B395370617466507953657931703748542B625758663059336B3262766254743342644E647261612B682B5038416F2F447A47507A72387162577843485445633135584A'
		||	'54497A6136783871475347704C0A7235644373394F704F46414A556A6143644E33456B695252764C4977574F4E476B646A364B6941737A483877414A34792B526B79743661334A7146596849552F33634345394E422B73733331737A483438566255394F654F7A576B614B574D3671796E395959656A4B66526C4F6F4937486A435A5A4D7852537941456C55394F78454471456D41424F3358767359454D6D76774F335669704A2B566D6974344938784668715579504C7A6F6679572B656169366A2B717A443942504555736B456B63304D6A7779784F6B7355735474484A48496A426B6B6A645347523059426C64534755674548586A6B374E6E6D506C62415A31314B795A5047564C4D77305561547445425032587971444D726B4165673048773435452F685A687635796637742B4D2F6C54684D5264796767466B30306A666F47547064546650484552314E6B6D3354716276636258545474783975462F774473386E2F756A663841774F4C4E792F346E33714B31636242546A77784C57773937716C36397957414F563351312B3859727435563774754863635878613969746A486950323332615956424A7445596E365A4547376435516F6251364E3565326837486A4F4A3467346D43443533795856723543334457534A724D5668576E57526245577168506F776B6B4B74714E50545430314847526938554936462B57355A6F47716C4F32396F4B31496E326459484E674B71786136394C646F4637363662652B6E47487775547A746E325847566D73534B4E306A6535464375756D2B61566A736A556E734E547133346F5066522F43626D465969365738564C49415430566D73686D2B70566553716B6570372B38797150796A727776686C7A5979672B7A56454A2F46653545474866547542722F414D794F4D5879316C63786B37574A70704331716C316A5A337A4B6B614C424F746152677A61622F414B56314143676B6736366161364C34535A3071532B51784B4E2B4B752B323270372B38337367432F4475752F7744514E4F4D7634643879596D46374267687651524B586B6B6F534E4B5555616B735958534B63716F47724D49794150556A696E537435477A485470515357624D7049534B4A53374851616B39765256414A596E5141616E585163562F436A6D4B574D504E59786C52694439444A504E4A49726161674D613965574C763231496B4A48726F66546A4D6548664D474871793358396A74316F497A4A504A556D596D4A42385448504842496672386974322B7A386B3276466B6647337841793531456C58465A2B7A427638414F332B634F59716B45675A7433763841546C37763574664D507874773531757458785967566A76757A644D2F57596B48556C396672'
		||	'4F78542F77434C37504A4677770A5A5236702B39335969702B4136734F7278742B633664525150675A44783873504B7830504232656D2B76557A664D654578384A2F6C5150506C6E422B72574C47762B725455656834384759356F7644546C555448557653615350385836475365566F782B6652542F352B76623048496E384C4D4E2F4F542F647678656A7054565A6F736974647154717658466F71494E6F634D4F71584955414F4530314938326E7839666D766B50384133484C662F72302F327647537A4D504C584E3855584C53343055386A426A4B316859416B304865302B386F595A4E6F6C3063676E556E303764752B5773795573586B376B4F337130386664737862764D76557231704A5939342B49334B4E5238652F666A4938355A586D535847566367745552775A477659546F52474E742B7654372B6474526F782B48714F4F597633677A76394435542F4141552F48683169343864797A556C434154354C64646E596A5269475A6B68556E386C59744350545179487472787A5A346B35536C6C374750773631346F4B4D68686B6E6C6957784A596C5833794E78325278493271726F75397470637633434C6772733252772B4D76574E6E587456495A70656D4E7162324770327153534272333031502F4C6A486377572B5865614D2F596F556C763237632B5170517776315756576649704E76365549366B33336A614930644353323764356470723376466934335753734946395653657452727074506F4E4A67726670334863505855656F78736C36576C576B7964654F72664D66335642444B4A59316C56694359334259465841567775704B62396D356975343868554B4E584B63344E4247697977355432564F79367731435A5A466A5161447078764A72324767626F6F50396D4F4F635735305531323559574A716F6962326F5269453344507639414A2F5745707432394C7A622B70314F327A69397A707A4A5678325277334D2B4C6B3333716B73466579596659355663715065554A304C43445664544873644E64575A396450732F4A6373706A50486A7851784D7A6B53584B764D4D4D412B39695671584E466566663053784F687269523049333756632B625239547A2B57366D4D585479684C5A422F6C4D61346239515666312F5979324B2B62612B456C4F37646B38594C3737757744506174526F716A36756846432F384158312F4E7879377238393433542B4D722B725274662B48362B506C75383278334D3979687958576C312B5A6156334E35534E574A427435646F4B2B505356646F5550577030624573656A4D646D52625854634F4B6C5778657456714E534A7037567978445671777270756D73574A46696869546351753653526C52645342716535413435'
		||	'647738584C2B43772B4568304D0A654B78315369474734683267695248634679583064777A6748763339654F5250345759622B636E2B37666A6E654B57666C584D525152535453764244736A6952704A4730743179647149437830414A374430425077342B5A637A2F414E5535502B7757763258464F6C63703554466531314C4E587158367654396F676C6733374C4557375A3146586474334C753031303344583148484D5837775A332B6838702F67702B4B502B76552F3531582F76553435692F65444F2F77424435542F425438636B57567338713461514D757364586F4F46507576424936454875652B3156592F6D6258516567357235527A6B664D4638317364617451584C6373396165434A704563547476304A55614B79733231677847683950586A6C3272505377654A715755366339656C42484C47644355634C33553664745236485434386367347573746A6D504C464665354C6E4D685753517143304D4555376C6C6A4A393371752F3068476D3556525432484850585057577757542B6173624442447472785474626E6A367A794762556A6F71326B51535061564A4B7962704E3375376444797264755A48415975396B4354637451744C4B656B49643330386F6A59527146414452644D727455426C3059613636385357655A634E6E75596339686F445054544C54314C3065777A785073306D4874454562435655565838733637656D5762527835754B4869356A5A6D524C2B4C7455795341306C655A4C63592B7469706A676B39514E46565A443330314F6E664D5979706C7362626F585556345A5958387A41486F7942573663385A4F33624A43326A4B77302B4B6B3753773448324F626333613848664879687A7858686B6D6F3354426B6256614C624837586A376352782B5971512B5942706449336E51794645613173336E5A75417A396E486331637459766D5841326F386A6A4A596C76553755506D536568635650705067564B46453671736F654A6C64585657526742783469316B6978484A4D714451664E5073782F524857787278362F456B3957516E74395A4A3738592F4C59336C324C4A6330357162326644387559327A6B373867304C6C455862484441435172325A70474351526C687666747142717735343574794850664E75653575796743584D35666B7474437246307251364C4455714935565336564B73634E635346564D6E54336C5157504879646644696578652F77417538765832557167654C4178796A7A57626A6553584942534F304E5A4E305544362F5354534D79396F6458343559795662455A33485A433376396E72544635656D753939757868325855612F72342B326C797438446B4F332F41485166746550747038722F414A57522F736E'
		||	'2F414E76484F6E4E324A7A75510A35647330545A36654D73537957657444734F313536636736593374764F3242396654346658786C2F45726C713769737054684E377257386664725137367743395378576C695463656F6446334D4E546F644272363663567046687331355831325254785350703637556B566A6F5069644232347933695479316478655570776D393172655075316F7431554265705972537852377A31447458637731506651642B2F484A764E2B5235626A734130703868686D6B4454424E3669704F772B2B525462486951756F38305437524C744242556A635A50467646374E4B754B794D3968744248413777784B7A48734636694764753538766C68636E34446A4879577061564F5737477356796176444C616851454C444E4B6F643451437A6E364A6A302B37456E59547278797A7A7A587747587A554E74486E785751796471306B734F6A535635544E4A70497161365352797837643667376756566C3138774F513851655444456B7A6A35796C693161434930466552474F6A655637414377366B416267337270395846507857774D6C654A37306475437932347977775264654B503652756D717973305A6B505332626D32714E356261414E4F4F58764544443475396E506149626E732B547973742B437847694D566A64466A4353516C677762793636717A65396F514E504F4F632B5165734C774655577835785038314C3758714F2F61626F373978506365663137363863312B4A6B56326C4E6A7346464D67745274465976574149324554677138634549337344497049615632556F765A455974755837486A4234627234686376496C5172466E735130746E45537674437A3952414C474F6D6476636974394F497249434F6E5968686474592B6F726546486A647A6A3448354B35674D6C6A5A636E792B3170686C7556636C493957616E4F33616166477A50484B4B6338714D4A486A6147576E6341526D56642F573477486954346363387048593556356872567255363735655773354A4469387A55665253305543547A6D444971724D554270547A747175696956644A447A686E36503276634A64796C6D4848664D466C364753653749745A4B69525643596E6D4D724B49306B72777837532F767372716E64534F50475878686E352B65727964796E37614F575972715354724847347363305A6A65497162745855475A71564D6B7269716265655778504C626C693670717058384E506B3935504A54775A666E694A735A69303254525962585449586A715473753754397756396F425A535461666430325341676E697657677177513171304D64657642477355454553716B55555344616949692B5656566577412B483772542F6A7870396A77343570772B'
		||	'4268794E664A7A53514E616E720A795273496E655062476A71323872717939322F4A4F6F3139665469506D376B4B462F6149726D4E696D393771525936524A3954362B644B697471652B766E372F58787A52346E314A4B6C696A67466D6561644869664953446F72416A65526A58513675306A4C71466B505445657539647A416166754E4F4E5033484D3349334B6E4E3671764D4746715835556A614B4F30553656324B4E394E79785849536C68423237615365512B5A4E7265626A2F6F396547505633484635416F64666F546C722F5448594473776C4576596A5837346535373967414D66794679666A63614D52573566787A59344F6B7673317545584536386179496B34467272425A6773307939575059326B6A6A58516E6A4859444234676B34764434334873515158703071396552676535445352527137443878596A2F53334D66546A35636F58365543326A4952466B72706E6672306368314A58576D616F326F73556C5655614B593954717431644858615534354F35616A7A4C537A3334625431476C584731665A6F35474276326F356D53655630476B64576D6B66566E646A377A774A6F775A39704242494F6F4937666F2F583852707879336A3656704D76627943777642517152644A62467071634C584C4E694E4959354A3056794E595673754643376E5A414F7937694B36342B624D524A615073654D6B757173786764357842564D6F446D4F526C4C53425537712B33556A567476773435687170547954316F716B644B4F4E454D5168747464697351544471313753324830366E5767654E77366F696B486349313132385A2F45596A4759304A3944486C465446644E597236324C453073744D53355A626C4E642F7369314A326A6A674D6E52615463774379614D562F417A7A426B76754A5661764848516C696D6869687031596F6E6E686A36615432556A69566255775162544C59366A7350654A3134697A6D5567396A364675534261457A54316B68306A6A576153555453537369625664336456336277664B694950496F586965395A745178515446436B4D3171776D6B61493355757447302B3531554D344A695461724D566A373741753436342F4D58635A465A6772657A4E44626142353472564F72636A6436776C3644464C555571686F2B744C6F5142372F454756745678554372566B576B62426753656C566E543770326458724C4C457773447944594A7849454F70514C71646247597632766250614A466C3974617130786147497342534472576968626272586769523967676832524646514653493032795A61394E63753370586A6B7335464A6F37636B6B4D4C37316E2B2B46565A4373544838566F77724A32326B66686E2F2F4541464D514141494341'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'5149444251494744416B4844510A4141414145434177515242524941457945474643497851534E52454255794D3246784669517751454A44556D4A79675A4756427955304E5852326F6253314E6D4F443039546A3843425456484E3167704F556F7348523165482F3267414941514541426A38432F7743525048473673396152597031422B626B614B4F5A56623665584B6A59397A443735314858626548576E43655244753239357450344B31594E3132383255717062423272756242786A6A7461326F54382F55323751445662622B586831536F6B6357316359574E583036644931424F794E465441434C6E37346A374F553564326E646E6D63574E6A355366563546437A4668386B6D6A486D736E6D59354A4C597A343843474730346A6F363947756C7A7578776B646870413947566A35414366324F342B516E506B4D2F424A706B4235303165486E5847552B43746B6859346D4F43476D636B6E6C354778464C4D63375662373048587A38767039656E7636646671343150576A6732496F7554516A4F5061583748737133516873716A747A5A426A484C6A624F505068354A48615353526D65535352697A794F354C4F377365724F3745737A48715353543846585472635A6A31654E4F5438624E4A6D53335243675157565447354C7048676C6C5A69434553796D5873597236796A484D736955705154314A5647746952732B66797059382B386E7239363643596374336470376C69484F315A6F333231676D665138733251435151724D7246546A484769364C70302F4D6F307176786E5A326E356432367532424A567A306B70316C63594F475272637973506B2F414C7474637744356D4A67434A6A2B57345034706652636530627166414D53426C4F47553542486F662B50326A6F656E4665374C30676C445662754D6E596A73755877504D5275715334366E5A6E414A786B4D70444B774244413542423667676A6F5166512F656C68632B4770444242394149546D766A2F786576306A4238756A50616A334D53646B67384D714C2B4341777A354448513558364F4A2B3432592B355577727A6D3247693346733871714A6F743236535861784A4555595641637447536834537671564E71344978424975477253684F6D495A56384232394D72305A526A4B34497A784C48364D6F6366704C30503756503841365278466F6C39387850684E506D506E464A312B316E3936536669542B4134326451343263573959314F5234714E4A413969534F4B536431566E56415246454764764577386835646550357A752F756A556638415563667A6E642F64476F2F366A69383267575A724130343131746336705056326D304A6A4474353649587A3365544F334F4D44506E785070576D6164'
		||	'4E326775564A5868747574744B0A4E474B614E74727770613546795361534E677979624B334C56687445686263466930352B795864656244656C45796139336E486371466D3851597A6F31623559726376647A5044753362577867304B48324A5378642B75314B664E2B4F30666C39366E6A67356D7A34725866733337746D3564324D62686E503354585A57382B2B3259505438435875792B373051662F766E7846586851795454794A444647504E354A574349677A367378414846625459734631484E74536A3866616B787A70503742476E2B62524236635455623043574B3079375852782B7830506D6B692B614F7547552B52346C6F4D7A53313248507054734D47577335594C757834656247564D636D33414A472F616F634B422B6733415A53565A5347566C4F47556A7143434F6F4950554833385562702B5659725279503544326D4D53644230486A427750546A744C2F41454E50377844787057674E614E49616E4E4A44336F5139344D4F79744E506E6B6D5748666E6C62666E567875336463595038416C6A4C2B346B2F2B323431563732745739536D37544152366530576C636A6B334E4E72577A477368573162384D6A585538624B416E4C50523834476E2F4844532F466E664B35314A6F747A546D707A564E6E5A74385A6B6550634D6A78354F3464654C50324F36463365336F2B6D323773737770324B627254654A71566A446D5938356E69744F6D313978363579434F4E4A6730366A72517679366C70385641754E534369343971464B68646D73456265655939786649786E646B5A34372F7274364F6E437A4649553679574C4D674754485772706D535A674F726252745145467975527749354E4E375177516C674F3876576F73716A726C326A69314235746F36594349376E38675936736774366C49462F446A3079636F33307154744A48366878702F614C55704C4B304E5637734B496972504C504B39756F393646444776534D6D434E79786B594B7047334F534F46456569396F5A457A34334D656D6F63644D46454F6F486366504963785978356E50534B6B4C4E6E53626337694F474856346B72704937454245466D4B5765714864694656476D566D626F75654A395231533344537056786D57784F34524679634B507A6E59345645584C4D335144686F36744858745151466674694774566769595A38525662647943666F4D6C51304B626A675A584F525830794C3479303639636C57437244714656414A70587A745154564A37554B452F357830382F687450313972715535362B666965655472394F5231346135497559394B724764656E5476457035554836774F61342F512B474F2B4237625337495A546A72794C57324B64506F4735595A442F31574F4D'
		||	'2B364E762F41472B44544E2F720A45374C2B675A584B2F774448753437532F774244542B3851385670394761326D7078753364476F6952725963787572636859673068597873344F3048773776546A2B5639747638417932702F37507859733974354E6366556444743637657050626157745A4F3354346A47736F7377373372376F675641436A356658726B614670316E64336655645930756A593248612F4A75586F4B387577396472624A47326E7267344F4478726D6F614F2B6F4E4E61305337546C4675777379636F727A387142456844626F68317A354539504C6A736E2F5758732F2F4149725534314B757A6B3164454930756D6D374B4C735648744F6F39476C7345682F50496A54726744696C72506152723039725659525A677177546D704653727354796337427A4A5A3545784B356468476D3452694C4B6C32317A5361686B4E58543952733159444D7765586C78746864374255444E6A31326A397648593670712B7150704F6E366253305456625669506B4B576A6A304E36786A4E69796552564832317A44504A484B42733237504675587538742B533234425635616C335662636D34656262713373382B34526A5A3659505563586F7444747A587449457837685A73777442504A585A51774530544253486A4A4D544E74546D624F5945514F46483847715735705872324F7A766635435332323171494665435361556B6E6E545251374D4D3257547655707A3763385846376474595738303669693068736A545256355933466D71654957656476336D667763766B386E7863336A52753033595058346A4670576F775772744557666A4B4634306679526934743070547462614A2B62484A6A43694C4262346451547A354F7232787578676B63326463342F4F384A382F64352B66486142382B4D7936617244383156756C50326C332F5A3848616D75757A5A6F577648534939766D79786166526D6B646A362F624D3169502F525948764F75352F3645783873395249684839754F76703538535448385951692F6F706E4A48317363663933694F474A533873727248476738326B63685558395A494846536B7655566138554F66796969414D3358387073742B766A744C2F51302F764550485A6D7A626E68713134726B356C6E7353704444474451747143387368564542596863735231494872782F6C4A6F483734302F3841326A6A74443857366C5131446B365071484F376A6372322B567A4B566E5A7A4F524A4A73333748326273627472592B53654F7966395A64412F7741567163616C2F77426E335037764A7832532F724C32662F78577078326E696457416C766D3347572F44697478527A42683048544C737654386B6A4A382B4E49533772576E3664623076546F'
		||	'4B64327262734A444C4731524F0A554852484961574F52497736736762497A6E714F4F30576F305A656454756170626E727A4146524A457A2B4677474162446559794230343745646E6C6C655054612F5A48524C386B4B7468624E7578556A565A4A674D627537787767516873684765527831626F646631797A617337727339564E4F7154437448434B32304E336D564E30375379376C6456526F4E6B4A552B4D79417272326B36514D61645174725872727A32734664746141796F5A6D5A325A6C6E4D717675596C484251343234485976736A326E747054314F587335543148535A7559745778467A5161784E4B334D6A56336C6434635355333338304A4754453245496C6B3066587450314D4B705A4962646554544A3238734948457479766E7A7937795172307A675A774E4F3162544A6E697331374D58524749466946704645315359444F2B43776D59354549506D47486A56535067754C354A666A53314763644E354731763253786E363835347336585A4969477178527872753644766455794E416E2B6B57615A554834544D7550545048384B5545725A5032517264483655393758493573443043386D41447235594148683437696E386F31577A465769583879503238377436374652414352354D36652F42534E664A526A3679423150362B506A75306E73596372524444357962796563666D52444B6F6677704353506D2B764773364E70334B373765727248427A6E35555734545276346E7732336F70394F506B61502B387638416363664E364E2B386639787832306F367174495436375368676F39337463354E36564E5568626D7479313559333234757658707539334768616A5A545375373664724F6C5872484C3144632F4970336F4C45757865534E7A38754E7471354754675A48467976486A6D543162454B5A4F42766B6864467966515A50586A5164527372705064744F316A5372316A6C366875666B55373046695859764A47357558473231636A4A774D6A696F793670553066744F73444C56615178736452716F666D5A36764E6A6E6B5346324F79314348614465796C4A464951667868722B69314B61626D6D74524C61734D6B613957635179705454354F5739705A695559385463616C4270633732644E7232374D4E4B7A4B515873316F5A476A69736B716B612F6243714A6868464144675934374B32644F6B6972646F4E4730485439506D7232695934626B4B56596377744C676D4378576E456E4C5A6C324D736B69536263527372566F6A385351542B477A592B4E6D68685A506B2B306A704F306C6A6F54686468365A392F4538576C7A6164636F4A734665315A7369704E4E374A4F617A566C5759516A6E6377496E4E6338734A7559746E6A7370334B'
		||	'78706E666444374F31744874300A5A705851504C464C4C4B307346725930624A3758627464492F6B5A79322F7748532F34774F6E74374D302F73676234754B6E4136317539636A5A6A7A396C3544793472613132746E7175614D715430394A714D5A3061784577654B65355A49524E6B4C71724A586A53515374677953494535622F414F5468623151744A564A3643546350615632506F73753153472F426B5253664475344B5343536E65724F5046686B6C6A644F6F33446F3351344B734347386D5276664853375359725755436F6D7072347174724765746A616F4E535879797A446B4F546E64456642783233734E4E454E46313352783269703339366D744B72366B6E65647334796A744463745471366F325148687970356B5A34453051646F495233545459414D76746B6362354169355050747545796F79646951782B616E684C5773713157714D4D74547973542F524C2F774178476655664F7435596A2B56776B55534C4848476F524551425656563642564136414166636445756146556874707039533544504731694F4B62664E4E444A4879306B774847497A31334442783966486337476C36355972644635552B72777931634C35657A6B31426B326A303848314469727176624271736457704B6C6950523458377A4A626B54447872636B58454D566458775A49564D7A546265552B784364333345642F707854734274575847325A52376C6C544567483062767048586A504A732F56337558482F7A2F41472B76484A69307970734A33486D51724D78623166644B4762636655676A504761744F74584A383268676A6A592F5779714366316E3772712B6B6170616B6F4A5851324E4430706163586474573063525178767159314137355A4C554E2B53564A36794745514A794D7879422B5A78587161525A302B4C556B676B31753933326146636150516D6753537258696C5947612F71636B334A71524943334C6874533551704875424279434D676A79493943507234374F36646F306C714B33712B6F324F385052303650564C55656D55614D30746D534B704A4A4772597379555561526D437870497836747442735355503479313248536E657233714B4F7233752B494330596D67526848437A793444524239716E77372F586947395071646A5535705A5A556E4E72546F744C735537646475373364506B70785A354C56626355794D6A7649366E4B6D5751414E77306D624D2B675353396F544F316A5344547031613962555458374F7470757076792F6A4A395172724E4C625748765351694E4D76446B422F76505648614F374E4E7245453957315973366E7146697848557379744E4C557054545748665436706C5975494B5A686A56736256474278716665744F6873'
		||	'767139654F72656C735A6E6D650A744458617444436B7370643455696A64396E4C4B2B306B6B6C4A4D6A6C754C467175736F6C733174507153373535704535476D4A4D6C5152784F356A69594C596B356A787172546545796C3969347057726F75706130354C6364537852314B2F7073385564376B643651533062466479733364594E774A2F46727871544F2B6F517961734B613235616D7033716B6F46446D643337744A424F6A55794F59776B6171596D6C474F5957326A476D3979727658476C4A66577171574C47307471686A61395061586D59755770336A4568733265624F4A486C6458426C6B3361567056654757436A6F30745762543459624E69506C76554A4D4964306B5670307954765359757375547A413333352F2F4541435551415145414167494242414943417741414141414141414552414345785152417751464668635947787753435230662F6141416742415141425079482F41417339636B2F424B6664754276667541515146727830552B3841685032656D684E4F416C36576B39796733526B634868794E6F765A6E644D566B75424B4268767254344F4D746F496643474951744C327155424175465155436764674B446F76413574453775786E444C4D61444268593331476F396341727756584549336A76386433475A6C615A7143526F6942526B726C65775A4A716D785667565A3757595A554E4D5A744E6E454531747443674457494E424F7742654553563677394770733575775879596352726B502B3849365242535A663439626A4B3136425670484232514E48796D41496778476D7661414A556F74514E302F77426A524F474C6853624E504C6B6B33534B71754B30795A766B44304B4B51725248533068634334326F6762344D6D3638764371423947764F6A72507369644D68666E687061462F77416557455445496B7444796C6F664A67777572736856424961674E7852696D5250374F73625350746C75624F70306D7364436B634F49327A6A35484E2F6833563950726B326342323435617878787771576F4E64394B44627043753079693667476A6133614857795959646B494A706963694C5332415947533566544B78364B686A4769536659763249593738706A6358674D415241496B4D4E6561303243687046496347654B7A625778354C4A4E79786956654351794372346E49595563776D51732B4C4A324861514E34714A4D716361745975686343444244684F335864796F4D6B34624867426F6E496177557975414B6D7871426E4E4C4D7169455647474170417A776175303761306C7A746E744672714A71364D4457743052637850634B49494E596554656D636E794769427644372F6D694372744D41734B57594B563466636C375A6843'
		||	'51316B417A4771774945416B530A78302B655431573771717132486B31752F6B414E7A614437756C2F622B7366484E6332464D49384D6D655A473048764562334B794C44587874436F6255504245727743494B666F644F3744772B4B7A4C554A355A434369726F325447727A69516B674B42425377347732465475666E7A5A30385954786D777067516E4B6B696D6A4359497A536E78634B6D634B73354F4F39624E4E545A4148575062646F734F6A77614A6F473753316F2F467A517544524D2B63512B564632573761466E654B33722F5A574F334365594870527439432B68585135323550694B4879416D484358686E3939756B4E655A64686A6D65456432525553634A554C694C5855594B5438454435507062332B486845507339413471622B6A5949474144786B3036437164666B3442514662546F4D35444F396C4F397A525A386735693175716371636D4F7152485A736C4C713256384B7865617266497444424A6D776547364F5352414F4C2F4F596E30656435634758615A6551624E6D5551624171787368696D67436149414C676347535A3030694E73554D336A3342666A46714B504534466A736D3177555930736D526B5949745A5252716667455A346D69466E54426944426E455343515573374D6B76467668745633734236436C675542386D654A706E456A55644F4C7A2B526A4C68646D365938745345464B6A7773464439376534517848634B4B697132316A6D6A66747A71345948324136414A4651356558656F645A707835724E354478386F43447742657761346734355A62337276795A6D5337567366474570693654755771772F325A2F696A43352B3151624B466F366D6A6555706950374E5846526863543137722B6767795A4F466B47773956666F7741724170447158536273356142676A676D4A4D726F646D4D4163717467366A654562585734584F2F4B614B6773336A665751796B6844433745657036443636555144526C72574657444B627A6943754C684D3363663562514B426546586C49616C4C784133784F42624542445842544F6E514943527744696E335373344A524175464C6774454E416633334C47596E6D367757366F557653634E597639463368746B496B4E796B755948416C70784567414145443061566E453744567776612B6D4E7355364D42386352366F624A684846614D2B63774161656B614B456D684E387466714164427467572F506E3847634A72744B2B567041637473705249684935635158676A71446F4244305576704E61343957674E53447550456A6B735432774D75384239646C494D696D4751464255476B43496D6B775439616A412B7A2B31676D59474A506337637151434E6265754A4B35524D72454C416E5A425143'
		||	'47737234783753364E37486A460A4B414E6374517336367A4B474655504541585057656C72536963616778392B344C776B4A42492F5267584178514246366446416F3458516C3263714F686A4A65596967456A32317032767748336E2F2F61414177444151414341414D41414141514143414141414141414141414141465941414141414141414141415658594141414141414141414155733641414141414141414154696E6D41414853414141414156654945572F5663414141414148725A696F634F556652767562417134593442413670464B69484653647A34777A5339614C7562486E46484141325538384B58334339786D434134427679375641415A6D5941414141447A52374141414141414141414368393456414141414141414141414141412F2F7841416F455145424141494241774947417745424141414141414142455141684D5546683842425249454278675A48424D4C48786F64482F3267414941514D42415438512B426A4D5157747267545769464464666D4134424636454F6C4D644D76475158525A4F734576453268587A45586F6A496F5147574241504D727065776531434D7947466C444F2B2F6E48376664787642674351455253536A75494367766C55596F4C4A554B46594C327148337935636A31494155516B5145594A4E46307A6279394D736F53346B4451455563694E4A3376474D6E6C4D78457441544B7878684241415A706F63693644364649742B5630694A6751366D6C4A424453756145515A386856675256734F496D4649476C77497979636C4F376E646276445333527949504256796B484A47514B71517777507852454553434967596953695049684F732B486A4B623765322F77437635714F63614834697278796935706B763130734E62645A7459733162485846734F696C435973724248456D5443693451774762304A4E4D794666346E565132576C63386B7569394131554A526253723043642B3165306A61434841574D395277346C6A516652743272623669495A6D436138616C5456446172413758646A4A436B676D694843636B44702B614563546C506B442F4143614C666D71714669724556445557336C4F3377525A7752414B6876412B646D6F3759436B674D6C674544335065646B636C544E614C5951734635676C695A6D4C5858694946794F5A505366324874676F52464155744B47694946476A394942484E32307574624D56307137572B2F7054696151564F324241566F6A46414F59583968384F444C47374B4F63537768704B6F7272596E5832456A465166777332367873626C4A71444A4D564B684C794B5232447A5256646F68616C6D595857434A696754414747614C6F46324F416841697943493877324D4B4D4548'
		||	'674F6D374A72427A4D776348540A313751496941476777454A564243694A62356F6177743444524773434F41522B30435668705944714367364E6742425135512B6C5A30704F6441424D48336E326D76447A376567565159496742413544634E45633941797363654A45494752495131686F4D57432B78684555737041574E61466841624747456A666F3457537730686152486D7965646E7162784C6D67746B71776361556F6D6B324C7935544263304D6D4579626B70585A394471726E4D6F74384165697273777A4A674C78496A785130576B517858567578504D5A344A656B6F5A69634665346738496C2B42476A4954674C6E6745646A76536D666161543253526C6342554256464D464F5A44644E4249334C416F3264625A48624F42464966494338514F6154752F432B536E53697043586A53507967414F425668795569686C51376B74575A4A684D727947736A515859486D752F316E6C3136434C4C4C4959425141526F31706D6C486D78483036624631303661776C4C434A59425143546F51436F685A6F4730326C696751726138516F436E5535433477616677414649784C64306F7153496B576749416736796A4E445A717747513051306651443070744F374C317942596B5246554847414D6D304F6B534479362F655856366E69754358656F5658575A57434F5653646452536F78787979634972435550736D634D4C786C4642704D4B2F4270726942387875696C6E314C4B326A5131675949596E2F7A4E694D447061724C456D43684867633448326F324C694E346A43763055416B6E47592B68307543727177437A2F77413837395836396651484D6967655943486347676842574956425036436165635A34546A69647344366F34676735756B546F4463464D4D6E6471725A594763614F62466E4D4D30624A57433530315A7648652B34517257314164676A517A433752447756704D594B686F4D5344333858796E6E6E425A6F4D417156324249516F617046684441626243776A4A453035513148534D5136476F777247544178546B424F676D684F614A6F6962512F354732695A59774F536861523371744C416E6873774B5038412F636734695567416A4854643637577A785845504D524E574F6B42614D55366A415647744E674E734373354574706A5962314F424B51672B44414C7963684B784545535174774142566E534F7956354C514570385A76792F6E396547564151416C4746534849615136516844666B5446457459726355495949423265664162476B35474875723558457773424131516D6B2F346950477455334B4D744C436F4F41362B393445413832344B6D655156445656717231586C3950313677397678722B756E626A316E6E6E50384176753557'
		||	'357764494836535544434377300A6B4A4541464561577763554E576755344F4C54545366486C3839386E48626A2F6E2B665266664A35357A39376E6E6E6B79616E5437662B644F6E302B467458446169757858374E324E4E4E5A6F494C706D72613731527554514B4546757230434E695632414536554E4956614234795545426E554D6876767A3539763433392B666A6E375947536E555A526C62534245702F375669396C44796D636D434941674555525155514969636A635A663079736E2F7A414C574D6961345152544D73736A51576E38476C72724B6C7846454E646C65664949525879694B6B4F732F41396B556C4C4F5477362F3357376A3071367063687270696375576B78476B4F4646534C74305834315A42496F692F7879436B744242444A35436F61543531586432564A7243436E672F71496555444674626E562F7671326635336E352B612F2F78414170455145424141494341514D4441775542414141414141414245534578414546684546487763594768514C48524D4A4842346645672F396F41434145434151452F4550576D7238337977414E4962686168736F6D336F2F554D366D596547355163755936676B6543496355695252627063496E366771616E30635677426447664465754D38763754686F71414142524477634143474976564D456C546C63465A67734F69766364676D476C45535A58484A6E42434B6E387A4363767A35396638417636524B5931793577585343686C554F464771696368425641747167696430525768675365414141444B33616544487143675741796431337956487A43515376306A6E6A4B4A7851746C326556474167663566332F52756E6632337739477662687643675937484B35706254415763587038434A67796A394739583358587A726C4A70687548416D4B4F4A64445350416368502F414D343155556546446B546F6D47784758446A6D4B5569566C706A457672676F52462F38306C63486E483738706A4F32486C38667A726C4E584A31332F6266542F5464626D76332B6634356E4A787A5A56493153507A396C32757141526A4D494C5267423153644145564D4D6D794235472F3841706174774F326F524146416371582F697434476F364D4370444B69516F355A6246727A5479527654316A754A616E52737A324A7A4B554D5834683959674D4733314E65486B4D596D465A467149593268774134334E6A6F70516D745656787559436254636B57644D46597562417043647863487A675A50366A487837694A45387367444452557132456B467245466867586A39494352474541622B6F7532344747795170525577354257515235335865614C6F35364B694C6B496B4753436A396455663558417058415049336F6F54'
		||	'4165553046454A646453466F350A32483041412B47704E57465A494A5A514466534355786D67614B374942517359705A706F365967434B52684F50515373314E6D6851546E4356496B477845317368456F644441764C67514C6F676749704A524A77754C324C4365354A476345455230674B79326B4D4134776D514970753564676E2B57675144346B75436B674948534951474542597170434879746A2B5338464A31704F45544565534E4F676B47675263582B315968494351465644677036797831464D734654454C32504274313765667637506A2B63503866683450705A6C4561684263494D495266417941796957534C735671366E76686F38356643355472546A6A6B6E7638414F7850376B34766A446143453262496A55476D51766F5743673247515A464B734C504835382B593449444173685442617746564D57667067424D494F643157316D514D754236416B6D4F78554142556C6B6A675277434B4C686C47754C6E6F4A6845792B7A646F5451306C636D554968655A2F752F6966322B32755272554466444769546C67535659646B6762474B45624A42386B6B674A4C75794E6A4B5134494149775A64446B5847326B5137346F58314751625A6769696764493441544A695068664D58614F6342643945516B386B657853685A4D774771744A53455A5A683076444947506C5332454C63714A392F5875474A49506661672B37787A2B5077336956495753794B68686F6D4C6C4B56454E3268487645392F5A7730596E755778374C346549624A556D42715A77467A7562677732304E706B57514F306B316F6F4B38475348796F7A7A4D4F504A486A7544624C46677A596E2B5965564C7355427651766C4152776E6F41503477766F4A4371524551776B35542B4156475466467173337166764830525A4B5962796841464B43424F4751784A4854342F7753425949786C786D5130536C6368414A615045357A364753576D7055674B557063746C4454696C755049766967424E69435448314B4B6F46413638616C445946706F47387441383648476F596A454B525679792B63534C6843475758456D4E6B6573467451652F634B52713562472B6738612F64376B51725A7A5067514A313677456B465069413862517A6362392F4F4B5A37392B53426A58474442624652696C446B76474356543331344F515068686C3275734B5132354F344239672F553656764354422B6B785A63706D32367168494D315172797A3233754E7852644E4853343672776A322F522F762B633857426B496346455745794961364142366558447469306C674B475A784146476B5252494E734F2B646265584F4162427356415247654B31414F646C4F39575A796156486E44636771677330315A4A366A'
		||	'48614A747256694652514B534B0A4D4B5166676C576835346738695A5A4C5354494C544635617230724741674257774D71475767554D77747067306F5478746B736D47536845744135344C423463436535696956533546423779356F61793358763537792B446D4166624A31616E706E4A77356E4F6F4D623949533461366F4357712F6E59537478424B46484E336E746951555A5450714538634B322B48686A75685362786141446E66615463757839315A65465130447972364A5356504A762F5044482B2F5348327A68694E37316459334A69636A5032506B396D532F664D787267444867485751686B6B64626C4E454F4A764B57366E665A6A442F33645547707A563166776F5642416753434A756B6D6E64494C424C59614657756D505269666E424D4A795A79695872373473584D336E772B49666D37642F4E65324A726B4D654B4833396E5A396B3063536B616E7335786E3564344D386A48694E786351334C6B49753055396F416B784C2B5A62323648793566564C6831784B554C736B49584D6C584967445455414655436B7742594B4A3442557166527A696E776A6B705A4E782B4A53694B34515941414F5435382F5076332F546334786C6D66796663706A572B496B4F69554B412F7A676B38447A4C52415A437152737A6949425A774A4657496D51696F676C79586A5677546E764C312F41694846734A76734B4548777067594A50595A62617042574F555177573059424D32347535672F52796C6E31483665662B2F6E5373427837694F736F693456716D59413868376D53677A51466E516C50592B6F51346D44776477365A52794853594C7A61713766614A73477458565A412F454D35317952456F4152374F434570674167477933314975414A4E354B3242636447425658473833522B722F3851414B4241424151414341514D4342674D424151414141414141415245414954455151664252595342416359475277544378386148522F396F41434145424141452F455067422B7369657955746C43704148356C61534D62657851666C5958474163503959763051392F6D546D494D444457636C4D4F63793465794C4353696230727334322B766E4837665677664D562F6C556830384756614F4734304767496759714C676775775755464A577550733851786576486443782F33646941416F51764368506349764F506848653233794A7A5179692B556F727A524D704968436E3552565A5365674841387A3042675851644174554F642B4F446974454B696B3645524D3142784376664537495234514B637351537737386D46646F6F67776F3458615A61736B6B386B6369682B486A4B623976546639667A4D6B7462456B424A59696F416A4962546A74684B4956485A4152'
		||	'5044637A617736506D624C45450A6A63537271396D6A306874584E383443575163794B6F52414A6636324779367056512F536E2B366665516E42685858566E48525370664C4937754274523567417365724C76304E46537A4758715543364369477162726E31696244686B3357446E4E57707350354677326B3071647451635164755659657A532F3354683376344B67696B7143554C55716832666D4A437649576B6936457A4E78624F7832725469472F426E46553043326B6F5248746F6671474F563842464F436562575164554359464B4230666757714A304C74617156656A3437557755394B5A6F6E7372544A667A6B6F546C74517A563143626C773430784156736D3938457158506A4D755752624B534E4A4C7542446E457A453173796B7438734A4D4B2B45486759637747644C684E6B566942427253454A6738346253643147324B345557676B494B6D6D4E466756786C4B73376B5173753337794F58614C384845704F44483846716E526946396B6651344A666F49745567426D4947346661613850507430533454466B414235494656566C4D4671616D64515A413730427459387A515973463944414E70384C726C4172384347493234532B43434B456756445269713832547A3265357645634B34714D43436B54634C59426865706E6961386B612F645964426D4C48547455554A6232543839466850454C6873576B68514247567837796C5333744F4742352F4E33534C7433743376653364784A76427757706D724A4A69556F3670762F4A6A6B326733722F77426564513641786B536D64437346563042694B6E514F654161312F714A45495A5342484C66684152522B76364E78494270554177752B2B67624163555635793757556E7561466B4B33662F774247554D3835457A7A5876395A35646449584841733372615352374146333132724C576F6345646C7354476E646257425344684257475943696B6A526459684851736333523642454B414546516230494F784D56676A694E355174634170513242546241596141564D49466975336F585A674D4147737953535A6154354851374853556659694A366A635542476942615A68776D572B4266656C68576C307764722B7370704335696A673354414378734B6A6E5A494B6F6C79693071774D4462385372694664734F6E493164324E59626948624956623961674931347A3949484157344C5344433233694D77456A69336C715431454367486971515771306F4643535877506E6E7633667233366264665962594F624A785272614D4A56424543513257344D777648484539735A4A662B436B6C596452347A4446527A697052756B73304477474344306F48594978757851364745455472567A4461536D6E546F7563'
		||	'576544555A70794242794765360A583353626D7276507159322B6C794C4458502F41427257516130714F58463133664E5A694379714656514E774475424152574E306A4F504B6174384D6D44784A3474656837774371424D4A594533574A49492B45456332384E374543354334546F7551464F6378416E424E772B6A4D73586937344D4949554E4A4D54733132714165417379524A5272326F506C4D326F576665484F72433367797856413853456F686345325265643135303436534134724D3335667A2B7644454F4330524F634E49616B796F7835494839576847445A4A7758554B687950754E65336C634F304672382B5077575473506254317A7A313977414C6E7273676A5261616A41424D5A4166434942316D4848674142302F585748702B4E66313239754F733838352F7742395844574E3461454C4A48554245774F51556D7236585A524B564144456474704F74693551426957504C3536354F50626A2F6E2B665266584A35357A39376E6E6E6B79616E6237662B647533302B466D5A693278524C5368724D4758464C556B4B4346455141436A676F516F734A5A6767417A72637947674F6E6C646C364142414141513337382B66622B4E2F666E34352B3252796A5635355A6969737947325039636D343772565A4A614D4F726B4E57434B4246457549797246423432304235527555775A2B49314336456D61314635557559753654696A764D59465736414B473456387039525461556A7A6E4D4A6977646A4B65495A676E7A303368797A6D683163396C3572685577574E47396A6A2F4A49417A336F74344D334F4D6D71427048757368474C734B48443452684C5741343741485A37763939327A2F5065666E35722F32513D3D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A202020203C456D626564646564496D616765204E616D653D226C6F676F223E0D0A2020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A2020202020203C496D616765446174613E6956424F5277304B47676F414141414E5355684555674141416177414141434A43415941414142773367796441414141426D4A4C523051412F77442F41502B6776616554414141414358424957584D41414173544141414C457745416D707759414141414233524A5455554834515552467855774F59792B5141414141423170564668305132397462575675644141414141414151334A6C5958526C5A4342336158526F4945644A5456426B4C6D55484141416741456C455156523432757939325A4D73325848652B584D2F45626E5664766531567A52414C4E77706B53614E4F4E704D6F35475A48755A35337563666D3664'
		||	'3547706D4E53634D5A493852464A45675249426F67774F3547373432377237566C3552595235376A50777A6D5A56643341454831704466524649373632757266725A6C566B5A4F614A2B493637662F3635754C767A4F63493941594B4934675969414136536342524838754F4159446A6753506C766652434174506C5A354D786A50587230364E486A43344871387A34424634564D4D30686D4874773966796C5934564D524966685A496E49517764307A59596B67556769725234386550587038346143664F3247744363594E73454A45344369436F4644694C4E2F515769613138724D342F6F6E48385036443764476A5234382B77767135734A61444759674449556464557468553173516B4F4748445257614A6455446C4A514C626B4A58374F7266596F306550486A313677766F4D513778316443564B4573464B724F52756943636377784536453153554B6F437149757659366D4F70514D2F48632B314A71306550486A322B514E446E356B786B4855574246633742452B424546343461353244574D472B36446147642B655753484E783832364E486A78343965734C3637486C4B4A4376376B434B37635044435769624B4C437133706F6D485277744F5669334A54314F41346F4B3462444B424470746A39656A526F3065506E72412B4D36786C367078524377614257724F597658486C34637235377430563936644C466D324875654375624170596C6D4D7263382B71776B336471306550486A31363949543157524757354B394D586F617575362F63774A7A44656553747579663836642F6634656D734A53483535305857345251695169396F3739476A52342B65734836756B4932775055736F5A434E687A7A31613977365766502B6A4137377A77564E6D72524D306F4C4A4F2F78574B6B7449794C446C563644313139656A526F306450574A383959566C52424772522F4B56435859465931627A353449692F667638783935614B68524844716D6267454C3030485975446434436A70586E5950665478566F3865505870387766433579396F4E0A4A51765A4466654141536F514C664865343562586278337833704E6A526D474D4A384F53496534456C614B726B4A4A454C4934595A2F377330614E486A7835396850575A34557743454848465845674F79356A346D77384F2B6547394535374D576971504E46314C477850756A73705A57704B4E3530557674756A526F3065506E72422B546F5231616D5962454A493772516E543176696A4E2B2F7A39754D6C30514A64307A42664E617936446E66506256736276684C6335574E48374E476A523438655879783837696C42775A4145574941414133467548537A34722B3863387462426B755057636A334C6C614E465A4E'
		||	'456D4A47694F7034704B6B4A49615A47325575375957374E476A5234386566595431325A32416259787448576937784165505A2F7A78573039354F4676527075787259567178502B2B5974676B5459574F5557326A7645797A596F306550486A3336434F757A6A7241637450542F416B2F6E44572F63502B4576337A396B455A75532B7174414134396E4859664C53505269672B766755695A6A7265646F39597A566F306550486E324539584F424F656151696B4C396232374E2B4E61744B597575497934695A754242735A68344D4938386D426E5452724469644C47755A516B6C46656839426174486A78343965734C364F5A3243493679536332666138466533702F7A772F676B5749794944524251777A4A3348383854646F795650706F7566494B577A4D56565057443136394F6A5245395A6E44776B677772794E664F2F2B6C4E667654726C3173494C6B534267694768417A444F646F6164772F5850446F344B536F4175566A6843566C6D4750764A4E696A5234386550574639356E415231497A46624D462F6675732B74772B6D704F51736259525A69377167576D4E45327459346E6A6273483830777435392B5048497472456550486A3136394954317332454A7A4842336A455443795A4F74484C774654376844424E786237703830665076756B682F65586E4134383179336B68594A676F75737A6468784D52374F47743538737553774D526F48453048636B6453573531506338334F374A39786A726D743548676870486E45366E44775963734E77486F47573078396530313871782B72447468343965765434346847572B36596E79737538594E763875325869494C757A527A632B50466A7772512B507550326B5A64486B575659694861356E4355744145672F6E445738385776426732724A4D6E703362336346544563684C646E70334C3853563845794E5A3977776A464E5A6643476E4E626D527A70792F6E2F35637A3167396576546F3851556B4C4B317756584C4C727849513141314A43526951744D597761757334695458765035370A7A672F64754D313030474971474774554B53355A54662B4C5A6239434E67354F4739782B64384F504855785A4E563059544731344E53523577737A4A4C4B364B69694153697A58456967714A65597A5941723845564B314F4E7A63444D6751375538686432536E4A693541376E6E725236394F6A5234347444574A784A76376C6B65316F7830474A4234577963325839346638353362302F35364F6B694F3742626A7344516B49633675714E753145455143535355773658783339366638755334516478424175364B7171414378495349594A344A4C2B67596B56416B47575545696251674851493033574E573753466431'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'774B687849534F653841746C4E456C50564831364E476A78786553734462455262466663737565667851316E384D7943712F664F754948393262734E344B4A3471582B6C5964624B586975556557424959714B4D6D7353332F726F68422F764C3167306365504F70414B36476556594A68496A69417A577A347152454D6D577532594E712F6141342F6D506D4B2F7545564D4468444E544A633934464A36644E4E6D6A5234386550623459684A576A474B5853436866424E7A55687754313358726B352B36754B317A2F633537334853314B3942617135786D565A6C4F45534E68455A376D415133476D37794F763346727A78594D616A36517077524544645551514A41354341534956495863354B63452B59743441685648527878644873585234652F6A577A35556534642B4142764D4939323238497034546C4B66536B31614E486A78356672416872492B764C6B6F564E6442495153596846446B35572F5047372B337977763254614A4A495A6E6C704363454B51553547444369354B6C787758493772544A5043343474753346337A2F2F6770504355745A4E4F456B6F724252466D3430475A3754684A5857694375723554373768392F6E3374502F68385871455345496F39456F2F3435342B537142486D7A5369543136394F6A5234777446574A78474A57587750524C4B33383671533977395750476E377A7A682F72536854595A35517241793538704C564A5A415043734652524578544953496F746279356F4D3572392B64632B39345262523471762F62534E4B7452464F5A757252515439507373332F30417837752F33654F706D386744426E553577686855674C42694968396E4944464565307071306550486A322B5549516C61305061645A516B696B7641736E71426F3558787A704D6C333372764351667A39587772517A576E4438304C7A5256356569354A56515178524155504659484972594D7332486A39337078567371784D6C436F2F70575443636C495266575461696E484730657848334E762F457834646649756D4F5752722B420A4B6A2B6962434F442B33643041365936525249693731336C6533523438655054346E2F467A633271333871574A5567456B6549714A415A3871372B773366755876436F326C444777317851625543426575796C46785553744F7635467157687478513749594C52414A756B666365482F462F2F564434366F317A58412F4B514A3152634952592B46677861304355706E334B34636D62334833386E7A6B366559735944366C316A35337869777A726332435A4D4C3145596F49686F7269735937516550587230365047466972424F7666774D746253527362735A383258695277396E66502F656C435A363658334B78534B4C'
		||	'34464B425675586B6E43434F34746B39592B4D664B46414E5554483254315A38393864542F764C64707A773658684445793651527A562F6C324B766D49552B5076732F3978332F472F7645506162756E694552556865467767756F6743304A45454771674F6A5046754E5467724B6573486A31363950676C4A4B797A54684366494377764C626453767646636B34715765487930354B31374A377A3963496149496B585A34413657444A65416138695A514247434343714F70355156454A7162676257755559566C472F6E7866734D662F654142377A366330735659484335796235596E4936556C68374F33654C442F6C7A7A592F79745771366534475545434951685646524142647A386C4C432B454A5A36725836363932555750486A31366649373431436C4258342B6646382B526978684F68376D6A4D6B4149344C6D464B716758456C496B4249495A7957486D797576336A6E6E37305A7A6A656349396C643673624B4D6B4153426D44685442554B78454F5249454D6376696A61436F743768466B4A714644666D726A78707558706D7A757A336D583734796F524E464F6945746A336C363869312B6650442F636A523747374D5A7751646F35336749324842496B69314568366871466D785962674654396579513461454564766E352B2B52676A783439656A7A486843566C6F712B37623152335169695753546B5379646B3332546970753452735443744B544D372B764F4E7666337A4972663035795A30514B737974324137364A36594767332B43474377454D4D64544A496E6C544A306E5341324879384466667643457178506A78643258754C72646B4C72374845332F6A6B64502F706A6A2B567330365969676771496B4556534532724C336F4B2B56674B554C57636F30794C4D445445536B4A36736550587230654E344A36366451474242795A4656454375742F466E6663705967564842646C336E626365544C6A422F644F65446874697A4E4664704C347442314F72694637423661496D65596D595179384954486B76516648664B7332580A726C346A762F78355550555875667838562B77662F79334E476D5A553478564145326B63717867486536726F677A4D6B6545704A646C50656330396576546F30654D354A367A317A56734C507858624938444D3845326A62534B49346D6757583467537A58687973754237487A336D6F36504553565363534F70694F63796E4A414B583472386B5149576D62484A725656594F48692B5676377331492F6E664D35513375546E344C753330625662575162564637633667697A5145664241785752424E3665495230655A55506B466C554E4B5532644E5169353155667130395966586F306150484C306D457455364C6E5470'
		||	'5A624B49716B5533616B4C5868725475757971704C2F48682F7A6E393739796C486A65556D59425478446E38473359664844674951464B7A344272706B7355594144304937476A44626E76426D75304D58412B6537686C7057524D5A676A6C6D48684A61614D653431725164577A52537A4E6B765950366B4D6C4A366F6576546F30654F586A4C444F316D38637331686B344A6F5643707530344A724D736D4F4675584D7762336E2F79594B2F757A396A3051344B4365677A3034435333642F644136714B6D3047536A51686B74464F7A643232626E52735875434E665A704165344E7A6E4575395332784A4469517175686E6841724D4B7057445654556C7768364E727938417735392B6A526F306550587972436374634E6253464F54417553646454566943435433426273656552392F706C79737A666A397547534E7838747558506951494E6F68617964304A2B4245367267574953556E476F6E454B3044467A514E4D4F32346447324C4C3331746A792B39644948443156552B62495A34364E68745032424C6E6842317A434C7341516B316F544A68494E437544756D3678616E6D4937763349684B41644F5A4E6F43396A39656A526F38667A48324774417930484971766D45617632674E467768386E6F5661717756573771756A46594E7863364D3936346438495037383067314741523859674136566C566477367149636461793257655978796351613363664F554B4C372B367A61567A63444B37542B4F374A4C6E43726572664D5044454B2F77706539786E346E4D576670344F7832584F554A78562B346959706B444B63374E6B5053315A4E71724230366E4432712B61486A31363950676338497833332B4C503579337A3154324F5A6D397A736E69666C4A59664F3653582F7A71487877766E5277385866505230645A6F36744A536265305039365155585542534632545844756767704D68774A4636364E65656E56633179394E474A554F3231735547754944446749722F424F2F522B3470582F41314338546645556C586536784571656A0A593955396F6D6E336958482B45394C366A373946666464776A78343965767953524669356B54625A69746E69446F636E627848744D756532663439686B59546E30565552454A7059386337546A7665654E44795A7468444378765543514B6F4278436137736E384B4A463950445936495133426A62362F6D70612B63352B724E4D514E745364475261734C496C4367744B786E7745662B456B41345932414662646F2F42344269525861494E614A4C6838536D4C35514F5771304E3274733976706776374A2B703239445774486A31363950676C494377424D50414F5379334C39696B6E6939754974715334774330685965'
		||	'33646C2F2B654E78312F2B665A4437683074455655775156555172584F30314857356A2B705477716F614E556469784A4A7A34657035586E70316A3564656D4B44686846554B4A4274675669475355434B564F704D77597A48384D6F2F3044396C7444726E652F5432316449676F6A53724A6A6C6B32543167756A396A5A695A6D597654683136426D586A37576B76306550486A31362F4D4C7862436C424238784933744C6149637632507375544F7A534C523852346B6D744B447069776A48422F31764C64322F73384F70356A646870462B56714635336B796361345052545943683431783766704A38366D71313068794B756D346547584143792F766375336146714E52746F564B3570675A53697175363437514D75534968683265796D3979542F386C6337394A5238436C4A574334526561722B35777350384B734B383462624D346E6578506D32566F396576546F30654D354A367A73397764755170666D5244386D78674F613254316D302F64594E512B4A316F414A59734A306D586876762B4764787963634C6C61594A5551644538724D7164794270614C6B52474945575A4E6141414975624F7068546B4354454E79596A4A3058763754466936394D3244732F49436244556F32596F42355258655847587745524939674D4D7A6A32463769762F35796E2B67336D4F73466F715479424B597656505934586239463255314C796F6D424D724F326F4D6D4831377263396576546F3855735159585741595359636E6479696252656F3143527075482F79317A772B2B52374C3967427851395234664C7A676A51384F574D7756595567314742427152616A41464442636C3569314949714745554B4E694B4271714270694563777945556E4134705374506557463136357A383455726A4359447A4330376254696F616C59527570496E63416C4752574B49307549616D56586233426E384A6F3166495A686932514365746E764D6450345742394D335344624C52436F566A75586A536F575A6E6A5A4C392B6A526F3065505879672B76666C746B58630A6278724A3553757157714550796A71506D5065546B5047463467653239437A6744486B30623372777A5A646C4173677153345554634536705A7A6D43454968335067785A7A6F33484D55344A46736E74367A484F3078467532397544717A516B33586A725037726B5247694A6D4B524F573562456A556B6156354852654252377759744A72416B756463442F38426C6653422B7A474A31532B6A336843694B7A61657A7A592F324D6D6F357455756763614D6E474B6E6E306A6576546F306150483878786843614551566B506248654F70416376707657553835474432466B2B50766B3358336D4B326E48486E594D55376A'
		||	'30396F4C4745494B594848424A377975486B526E4C6F6F433073544D57735659635178524B7253435756556F6550797453327576376A4C7863746A71706F6370586D756D396D6D3848526D79434E724230444E7954787857686C794546376A7158364E45376C4A6556456F594F6D597030642F78664873485662745953472B7466325549394C5873487230364E486A75592B77634358356B73616545754D78486C6435506855316C59786F6C6B3834734C2F69614C544E37646B66387462394962646E63324A494549614942594A564A4B765A7A4352657A38417967325251426341525639517238414734556466472B55733172337A704D70657562714568736C717455433263572B70675570534D5A6C5A634B69435155484F69424178514E7A726634574831565862394E6E766442315147515450356464305244772F2B684B72613466727733344162356F706769455A673049645A50587230365045384535626A6D4363365737426F4868446A4C4366785248454C59433352482F486F344A7638364744456A3439666F35454B69354B392B7A426345715142626B554557437459455459494A61724B6B6E6933476B394F505641755842377A366C66324F4864685442574546464D57674254486543387A74395A54672F505A4B75494A534C676F346B36466C2F526679307976386C526634345A635A316366343962684C6B6739354F6A6B5463616A472B794D62374139655256686748694F4176745772423439657654346650424D73765A6B69625A62736D69656B47774F596E6D6353457055427351565430352B7849506D4C717468792B3646626572424B442B4A64376E6846364F7754624635797632346F6B363252744B63666F7A5A5048643362386A31463361352B64494F6F3148413354487A456B486C575678536A477258616A355A792B59704272796942497A614970556E616D39705A49756A634A4E442F524A6445424B4F6D534975724A716E4845312F794A506A76365A70482B505735716A4B513739696576546F30654E354A797752634F0A746F56335061646B7230724C707A58614A7052653067314278336A70336635644B584C764E725837764B336F5574366B707879314C78716F4B714D6C5153704735547A314968707767525349353353345A6A3539724E505635382B514B376578586D6952687A7571384B67394B764A575730695A4E53784D7749495777736C687768536B586C485658784D42515367725055387A797176735971674B766755684E395269556A5A724F507550766F763342302F45506165467763357466444B6E7630364E476A787938617A32444E354D513459376C38574E4A376B4842456E556F454A4E4A4A594B466635556D3853617033'
		||	'6550463659466A74735038773866534A737238665359734F4C4F49686C55474D49397755504F73466E515469444C61643679394F75503743467475374135624C47573756527247587065785A424B45716D39367550425A4545636D6A53504136702F504569784E697069767853505168422F494B6A56316D7141395137664B344641657A6C766E38507263652F742B67497937752F533531765A4E6C2B54317039656A526F38647A5446676553584647327A354661497568525A56763849445430636D496D627A4369567769365A4364344F6931506262487A745A4F594C6A6473586A63304331613270525965734B545A39454644704A6E58413247634F37536B4A737662584875516F554759376B6B43782F4B334B31544A3474314B362B582B56563570705554635371676F7249384E4E4B4C35564A437154795347444354713352326E5352505161656F565A6B497A54426663486A384A755052433451773476793533365353375836675934386550586F387A34546C716358696A4267507742646B6F36496869474C6559684A704A544431473754314C736D557445774D4A39744D726A6A6E4C6C5A63664D453475747378665277354F4F6A6F6A686459576D623364736B4344697779487456637537484C745A766231454F6A6952336D4E627078773869754778755457733970776842434A71526B654968416A5A677938493632716B41634E63456C464B2F416D6F3574757651434D6279447343436C5063516A51584B6B46754F4D42302B2F42527159624E314136784642363538535A665844736E7230364E486A637947736A6547726C4F46574D71534A5532614C7435473270744B474B4374494179513461694F695865486535437530374F41754E4A4B6F2F49515548626378353062437A697364712B754A792F4F4F613463314A30654278514B574B325732544E51424C6C797275667A436B424F50654674526557424C57385156704D496B6B4C78444644546B515976655A5A6B38346E6A6C694131796D6C46616B6C6A52647A6749564E376D4E0A43474B69584E2F38424A6A753852757649654A594D47496B6C4133426A61416273622B346438535A637058622F357662413276493149443631705A417835786D35775A76757A46424C68486A7834396576784349367A6B6953374E61626F443344793350346B683569434A78495356582B4A4572354A736944756B4145714C4A5156543667703044474769444C59486E4A7455724337556E43794E32524C434976484B75664F38654733453372554A44316552365171616C4768776B496F4B70524A484E637656765751554655716479724F66346359384E2B486948347439314330334B3565764537314161377549447844'
		||	'4E787A417833484F6A7336574735656F6838586A4A6B386C336B48502F6A4D6E6F42647763445A5946684B366E555A596232576C6A304B2B77486A313639506835453561636254675369476C4A6C35596C2F5A63794D586A75627849696A5579597957553633385773797035376D71586D5743796D7552436C4A616777314147376B7847364E324B65496B32622B4A49722F2F726D5A563636754D57694E6E3730644D7139343459487934344833594247427543524B725655775567534D686C47523272506F6B4554534457496257547A2F784379696E4362566E61496A41676573307A654B524659486C6A705A6E544E456665662F676E442B684C442B697234414E4545424D7A72374954686F596853724A6A36396D6E43486A313639506946526C68744F71474E55314C71534A49777370704F5049456B4672724C6F62354561786451472B436155324B57457151382F4E4255694A624168497145696A47316C6B364E4337754266334A686C362F764B7466476867586C7870553970727647343158697730586976656B78742B634C6A6C504C71426F7A74494149574F31454E395345344F44364351736C6C315079386B38536C724C5538797A314971317373575548714151637A5247624F6B624350654874696F5070393967657663516F584F4C38336D386A6D6C4F6D4B6C4A6D5A2B566A396A7A566F306550486A39487776705933656F5469476C476A444E494353506C57565A413849694A4D513937545055473058634959696864475A2B566376655342457756745141476E54737A4F705978635835593832766A4356382F763833466754494B32554A394F445175564D4C6C55654471316F42726F386A624A3835373835596E6E64413671426D4B456171414F52694A53684E6D34522B4D717A5A395767364E374C435563375379785461504353684F774552776A55437567596B6E7A426F4F7074396E58463968642F7356416D4E596D2B34693263304445412F39684F4965505872302B4D56485745354D4D314B636F57356C5372415133416C450A496F47466E474F6D567A46474B4D745348614C34304F626D586E576838686F6E453961635347334F6A61726D4E37653265586B305A43794F46662F32576F79714D6B5956374930436C3059544C6B3171396F3462766E65345A4C3970365A4952334B6B5249676B54492F7A4D564B43662B56746F47624F555852715A624A714B4D39556F706F4A344754614A45416A4D46782F777450706272707A2F6662596E587946554E53356E3532566C65583250486A3136395069464556627835584F6E6979656B4E4563644E4F514D5733424469625379783149767367783775446E4A4F2F42494470515546384579533146526B77'
		||	'5353476B747075523767363773317633562B7A4C5935456852525152334D417959426B39794464614771326436747544596363486C5138642B66484849485A53584B736C3068366D696C7046436A567579664E693946667572726334456F465376647074467452484C457067356D676F6B51504B636531525538454B33685A504568747835396B792B2F634A6C4A4E635973356C456B444B4334772F66785659386550587038646C42332F34664A69757A50462B4F63464F656C5754646249516D4F41584F357A467775456D5743536B51305A5157686B386C4B736E47734A67554C4A414D33592B794A722B2F74384A5739435475443344746C5972675A704968344A6F3567516F695A6441594956797668393359472F4C7672352F6D39793174733135464541676B6F645A6C6B2F326D697250786C515051784864745A614F467366416E7A33344B37347135594171456978675837527A3967767679416D41374C363630527A3336456654617752343865505836684556612B735A736E59706F5430364C63337256454A336C302F596C6359794758386D526669556870304258504354624438394237467A714236455A4E35474B6C2F5072654E6939766A6169314B4F7438545353327A695A6D7A30415457736E5050414A6548436A626F776E56414F6170346430757355714B6D7A7A44334B705373384F4A444F6E5977616D77745850386D655A6B504E4F7A6D534968594E3678574E336961503432342F456C747173766756645A50536C6E5A335031364E476A52342F504A4D4C362B4C6679695A7673615A5452705157644C637633736947734B42584863704D46563343765559396F69634A7749586D654143786B363842576A553561746F4C784F2B4D4A3335674D75564946516854557178793571554D6C454D724E5839626672786B73792F4632724F4858787A582F2F766F56767261397A52426E32545A556E303752766E6E4636676C6A5347514C5934434A67435355684C6F58696275544A436636386E765134724A692F2F674E5A73743752634F0A78667239536B625433364E476A523439665349546C6138382B64364B76364878464569765465374D307761685979685661396E49506B6A6434536A6953665161446C336D4E4F584A61535964557875564A7A622B34666F6E74735949346C56644941677335376B6B47716748454E6F322F6C57586C5952635543545871675632455677664F37352F66776D4C484F7A506E6B496F4A6B6641506B736270592B4B4F65343335475063364E3056542B716A5738376E494464495361704349535963374C465A50574C5854584C4F53504E32596A51436A5234386550587038786F53316E7168344E7056317171527A577847374B'
		||	'5A59575A61533934335141644F7979314574307370312F532F4C496573644A4A4278464A6274516442354A376C79744B3736795065624C75794F7159475749766637454D332B5358484A447270525A4A347167444D55354C383433746963736D7351387A586D30614268714B4D4E41536A38594A6333482B76777945516C73624A716942467963594C6D507973547938456E4C3655456A523134495344485A626274396C7173484E4D31545276554C47336C374B61523961746736766A307A4A777958736A4534472F663652734E596150526A5A72792B44707658715658787A61444C3955546D395667572F796E7864592F6E41576576777A4F754C4A376C50434A6E503633546E3131504C344473516C4D6153764A4B583663356E754654646E4974562B56307A6130747877512F74522F7A564A5A7249452B576B3439667955566861334A6D70667136362B4F30567337366D697A7A387462582B756C7A73546D32623634584E6F2B64586355756E336766666131616C75666B4537597A3136316A364F6231654E35466231366C46794F447A65384B5A43636463724846664B50472F714A726B7A572F4B536C503763585031482F5753384F774E434D31423369634579546B6C4A637463444E5766703146645A476B49375259476F6E6B70747447476A7735716F3572596D346449634B764463663830353074746B4E6B4A4571516B4E4E394961634E6730416F6255795A79724A4B4C326B414364537556436E586C3179635370775868304E2B35397846767236337A53424E535A4B6A774A7846724568616B5252634F3077694A6770554241386F67615243467849576C6779534546496743585453496436684C6A68314A6D6F50694539514271523079487A355074505A75376D3565433359344E4E4857563657587836526B73433750504453452B5A4F576A39654C757859766B38344363504B737956796A336132546252384846726359726254637364704943553872546356304D65447A787466475867716E324E75576F384F6E5945567537417A6A4C0A4A52773770467A44724D4939445159445346644C44306364587370316954356B3430787A3369474D6E7A7A446E66724E4E597A7248467653506E587471794B6833334C6D396131362B687244587A4D2B735579354D56764B5034352B547A6A486C7A6D7A626E5836364A4C4B2B694B38664A486E436E7065636450434541414341415355524256497631596A62503134666C74762F796D44386E367A7A72416E7A3932586B6975624D574E727552337A4D53377062666737522B6E5A5433704D4F39495149784A72706B78462B396C4F4250376A3679516E425668694F43656437787143694A45537432615832456B616342'
		||	'752B615A566F4A5355325569544A426369465867576C337A387661594B3974625A55663236586338536A683759766E354A457654436337755748683564385276583772493279634E717752435146756A476D536E445678526B7A4B4C7139536A316C47495A396263484E4F317150374B316B66494E33354F68534534784E6A5178575532314E69386A352F2B64596B37565770777258454A70424A7653756C666B3830523836616957753834792F6473584F767A54616145674C6E356D627045556A6B65302F4A5937715872434F526F4B31747039524F566E3476626D65686D6B7A4C772F4D6C565776773738554A65547156356657415149395161554D6D70363430524E4F544952746652796A4E77356A6F71393379644276644E756C73494A6271434B454F6951556F775556335041416576455051304F6968386F704A587069517067314F72596B626A6D79784B436C574F4A743141684B68313263435764687272537351556F4E4B733543566E445462646B4B585772724C65694275534848547775555A616A70436B3272777653536F435875347A65614F644A49413761766B6C5770444E3369545831552B6E7459646775446B574861727156346D7766704B30334977757A6F6D704952585432436F6E2B6B67795A753458614832436F656836683451685649675063472F4249496B677172773647664C4B5A4D6A35516257575A6A7A446A66336A7153382F6D3142546D4E544B69317344667666434876645844396C505475654273656B5A495551673248707846396D2B7248305241367A394139664E7631357458744D365A62464A31586768724C536737575A353579746851362F507449544C59646374414F362B756162794D4F5A4D5446727165657664325361746B764D496D30544D4A6D32597244544F35574D617563394E31696D53766D50734F55525779326F78556C34504C5930432B394F4F4F77644C3768363345444A4269547671384C587275317A644854495A614734464F66767050724E774E5A30536771385438684252506E7938340A50473059645A456F7558305978307164696444766E463179505A517143674731464C53342B364555686C6D6B3572582F43556C33576B4A4E4A2B7871524B384B2B7335354B794E62584B41703234383473566470697131395A49704B6A64314F58503175676A727565476665326F4C41597563744D6139425653324B6D2B54456F463645446733444677595A6F485A72594D46393434626A685A5755734E35424E4A6F315041374E3862734466526E314F792F5949516C5079306F63444133326D3547736C564F5234685165554A63695777786B367530766F3268424C63692F2F5938757435443256586C485067674B462F'
		||	'6548765053634D423271633038792B337972423267726264625A544B58433478457544594D2F4E61354C6235334644687049374554676C596B6178484E704B4F6D7549426857456B72697133505633474A325575513966667044455765696A4338354A4737744B42706A3846614350555A613674502B6370454946536C726C6236334E5937714858314C6C6D2B6D454F4F686B71704D4565756C6C68624E7271476B694C4D4E765A3161704577674242795937554B51515656434769704C656976525037376C775869527642493849703164644D51477544397079762B2F4564502B49763339756C434E6C79754A4C4A644B662F72502F38312F756C777749303645437A6B6D5736516E562F4D382F72356C4A4746536B37334A516B6C556E4D5379736F712F754C4478337A37773331753779396F44595A454C6D364E2B4F714E38357A667563464C67357167367853306C41714E4563704E5276773051304335562B534D53616B6E46394E734C3147486C4170504635336F586C4A3957717A6B4450654F494F75616C7A4E5170334C625A436A4D45306B485A6544733662627A632F74383139765A6D4868343150446E647A716B50634B5334785A4944686433682F7A6D39533075587076676E766A426E58332B374C3144336E3353734F71794664796B446C7A5A4758446C663371467663733136723879685057544E3969634973756A364E7430524C494777364334577742306A4A6E704654715A344A374830712B506B33504B686F7154584B6D44636E565538647135495264474154552F54546E494D337A53624F714C4A5A3749635A325A6F514A6A6C427368384F75374F7879746C747A744941304379524B59456152434A64426C756B4B4346447131456D726E434D744B764B4B6D4A55317836724E34746C67716F69526230635970356975436A42477038476371626B73706E75594C4731476B4F49524175632B454D31746C4D5579567875476B4E65342F6E665030654D5730536252557A44746A3375626939376C78546332557252724F547749760A586871784D356B774751516D6172674A53544A7044587575654535536771474D7A6C485743626231756A3971456838654C506E656E534E6947494A444A596E645163572F2F78306C466B4E6F744E70455A6B567A3834785A734F7A4E4754332F76346F5142476F5648683475656650656A5063654C374C2B79534C6E4A7973615566376E3557577537777A786F4B69657562354C62547A6656414F6D396361545769775273487A4F4B766B3637547138726F6F316D704E53346E4332354F48786B6766544659646459425A686D5A7A6B7346636C68674847512B5871755330756A3273756A4962736A4149445453564F6539'
		||	'5A6B2F6338724A51675257486247477738582F4F2F6665634A71396F5359636C6E434C664B4E367A736F4E2F6A79745631716454343636766A756E536B2F65724441766361315A6C51706C37654E78387562764D614530612F416A764E544A4477545854724F356474312F746F6A695971574D584F3553474B5143635254756630576C5A33474C426C4832513031583930656332576B444C574D6A424A3770694748766C454C6E6E4753634D6E484B456F6D525A696F384932745865364E344D6C387955496953463677624E7733387434315A476C6A3263584630755A3831736C4A2F2F3954706F55357A5671364E434E356D792B38662F544F4B30654C474B5351375A33554862454F305543484D473264322F744C37682B6363502B6F346345733876436B343367525762534A4E6957617469556D5131536F7135706842654D3673444D4D334E674A3747324E654F334B446E2F77386836584A6B715135794E4E30754E3041324E6B686167573961363455597367466C6D314C63664C467139794B6931676545785932364378797762546542596C725A302F355651562B326D545671645A5245453849573555434633584D5639316E4B7769515177545A64414A546473784D4B666531466A57535766467145716172716765525568436A72794B766342612F5A736A5047567579714F6A6C747637632B34654E647739576E482F614D47546B79584C4470625261464E7567646D756A55474159523034747A336D77726A6D357436454C312F5A345839345A635457534850647A434E492F626E546C68613530306E54387347544B6376466B6D6A5A43596A5573544D4F484334376B6B45646C4D3572356A4677744F7759594A67617356596D513567314461755547466256467A3635582F45505654496B4379693665495454626771585766457A6F4A454A437A6D505331555758535947385A4A796B793750716E4C68346D4441722B394E324B747A3064586343574C50744F637857537358355578655873684369644F426A414834306D6A434B364F5764366F0A56393678687145724930696679504D6B69324C42386A4F435279687555564E4B456D54746B737730386B343963533232466B6E4C6F6944596E575673454A382B65496A684E6A32517853536F546B735554574D63384F6F2B58786E754844582F7A305A5333626A336D2F59637A376B7737356C625475574C6D65467A693359704B51565270456777474E614771715654596B6354324B504176766E4B46362B643232426C57374B6A30733775654C386261534A757A654D42526477597131446B5A6C7639644E336C377A493251566C5457456D77496B6A4D475671705270324B625A31695852624772354367495479574E58'
		||	'4E4A7451524750614B6970716F71424374734242755252503552366154356A7A6555707338314A70434C696B434C43774C49794D707179537372376879752B642B75496233393477427350463979644734664C6C75567169616263627549705A7A75725150596746535745774867673344792F7854393739544B2F6675314678734E416F454E38566449566E3938574C51756E4C462B6A626A524E51354D6775654B6D6B4A7A4F6E47694775534D476454576B436B50456855714E5245516C55465531546476536468315756312F346A5766313855443170367345577A7642764D337071704C713636526D4A524E57736F57366248594D49506C4E4C314C327A707A7449467766426236364F325951576B776346546E74483369475548716A7A6A73542B55693565677633454944646F4E775931317764563378774E4755344875562B734768594B5031634C706762714B445345475347306D466B3851577964715A6630346E6D75705766766C3975696B6E436249565A573370686E75336D6E3258743258354B794264634C514B6550526B74314C783166386166764C50506E3732337A317450467378586953626D685A3353484C48634B463270594655676F6951485653656D524A647945542B6D784D6E4B65545364735671746F464F6B6A484E42717034736E674F6F6C59684451396B5979546F486A6F5542566D316859536666654458684952487243687545776A42794B7636784D6966754759733357526F504B6F4F3853645753586A5442366946704D43594779564642544C52644A4A706A71755835533548564E6464305A643066714A76556F46684F6259746B516855564F6C503256386137447862387039647638353250486E5037594D5A524A3353684C684C7674756973416D67465874465A53796A667231706A306257344A57354E464E4A4E6173765841707436394F64617063514A4A426C69576A4D5159346E69556D57426C436F684B46726C615247614F6A5247784154584553764E39792F5643704D425A6A6D4E717635734761746655730A49717855315A4630492F7667317A5438513477793174786D795942446F5A30737159354F4F382B4D524B54727045544F7530674469586838714C6F346F4C6C614B2B4A6F4E4E49656F5A50756273543168795A5A766B6D31685233624132726333583761565278597462513862486A6959703768744F556B5074544C546B69744A5379527968785A6E674A55306F5264437861595955326642526A71375730766949575377394A2F374D736C6B445A483244417351376F734F5457636666337A6E676A3337346B4F2F635866484255654A6B50733852465147586747724E5A4643784F314432786750476F77477146636D4D'
		||	'726D316F7A5A6D327A7645795963754F78703257476E53416148486D384E515431764F437462754B364561776C4F4D567936306C355446534B75304941317947755539514E502F6575733933336236686E3277342F6C6E5256546A64546133543775514A3436476F32333254676169777169594F686A5375644169566B4A31686B4A4A654C35766473735A45696C532F754D4D346562376452306374723339307944642F634976763356747962396F7961345457636A51694172556F6F3048465A44426B574E554556614B4E534F34304D5848536449676E3668436F7130416F5973516B415747346A6A632F3336537635303337396530682F2B715658665A624931486E39374E56766E3574794173376761477536337764616C6C63596C597957636D514E6B2B5255416D2F456F62623163392B613432594670676C4D45564A754652454864497878426C73434B746349616446597374682B7056787A6331787A5567736A7777706C34334C4D3872614B57526868717554696F61376B6B786B656668766357425832427457334A774D4F442B6F61474C7032672B4361794B6B334239696D6C647A6F435777514F6B343359716D5455324C4D3931514830766D7557796976725851784A394A6372474F457233497A636E4E6F7549634C49322F75372F672F337A3949582F2B376C50757A70794F6D736F797256554B32385041356230524C35776263584F3335744C57674A334A6B454656356362753559705663683475496E654F476B3732467878686E4E38654D717755436575626D2F63717765654773504B3663743859684F582B4B6E4C447270515744556B646D434C56414855746A69786C756E6352684D756161395979386B2B394D4D4F6D64725A4F765763786E314F5A45537843366C424A674B4B61546147546C30336365692F715A787735696A4C517969576A736C594D5A684A2B756F6938667575495033726A50743938367A37544F4B516C354C34705430797177506C4A7865587441566432526C7A61477245397171685653425A59784D6A68730A7548787647613558444775617137736A716D443556595655536F66504265706279666674313435502B4A2F2B59314C48436642764D71696C4737433162324B3179354D4746436B2B7075576C6D494D76706C6B555A55674944787A6D3941586B374463694B6E465536354643594A7268636B516B79464F79454D64693451564C38324D4C69586647726779486E4A70574A46694A4768647246343837784B663455302B4E5A6A4E73753130656D316E636C7848696A6964774B67534C672B48584A6C7363652B677933577A6F52525865434734347170496C4F786D77516F686C6C326A62506F3554757457612F66324D3632'
		||	'38766E344E767048692F6D4D53424C56483171612B6E6F785944586A72385A542F3875592B2F386666486442557579525A4973324374743546764F584330506E477059702F2B7875582B634D76582B42726C38656347326D52382B5A494E7164416855654C6C7663664C3768373534676648632B34754664786F57716F70435A4B6A5A466438487338447A55735238797A7130785A2B506C6D46616C6F7165696F4A4B4C656C44586155726B5434676D6178755168504346764A4E6370382B544654507254746C7034475761613136564A365850796A694164515271454276574F4B734B3464635A70776A415A6C65632B5461457167695A797537754461486242694337554567697052517969563778395A385933663343482F2F725741353736566E62544B42476E654F4C477A6F412F65506B382F2B72584C7650624E3865387344646B6431786C7A565745615A6434754978384D4F7434372F592B42395049706130784135613468374B356C732B647278776853714371344C564C5931363964444E766E4F314D4836567136645679576E476B71744671514851467252464A614B675956474E6972496B784E30392F30614F734B746479516E46747358587A657435766C31704E536B744D596D5A364639514D6B776C6474557573416C557177773152524471677969377442486172784D3152344F7177526B4F57554765483948776C727033486775556B64313669695544657557557878616E486D417459554A4A4245454D6C6C626C62756D6B6D7930564E5A5249534677664779344F6178794779534A43536F6A3741705552364B6149365935524F474B556C346748526945696435614D53534A4B56577057336F44586D4B616447434A697679673169684D67456B5644555765753579632B7771793731696967566436655250332F6E674439392B796D72434D6F537459534641596A7A326F37797231383778332F38375264343763715171337344647365424F755463766E692B32586D562B314F75684147544F7644617553472F3235356E574D50310A3355474F734537766B326473376F336B5274735A4D547064676D56306D6C4A4D483953426F62634D36734267574448574C73384A4978444647624A43764B6978504F476C6E796572386975576E624E49695956317843625831366F674441654B6D5443706C636C4155536D574F334936416344527A593158444659597978524A71346259435532787139704771555A6A526B4E684842496D396161315774784A4A6565764F4A4C795A34734943566A46674D56493237624D7534365644426D71737158474B455257395A6852705779723452354F5777364B4231354F6A326668512B356C57746474637039526C4D77686461'
		||	'6E74784A5259784935567133526474744961686B4137714A6B4D6C44314E5143775364534559524231436B467A3253453175727457414577692B6C734C4873707572514979596E47577272477A464B6E6245364179315269764E4E384151324B31696D57414171644A43666B564236785572482B4769444458532B6841505271645A39434F793972383864626E635A50394C55334259622F7853466A3474453977354D6637546D342F3439743046783032674C705A4B35735A3272667A2B6939763878392B3677652B2F657034587A6F30354E366D5A314549644E424E57634F6F364D4235576E4E735A38645864415631726A454C46317269693870433375424C424B354A424E47684D614A4C5470555158453236526F457064565652567A544149493356716354784953594E6D3178475443684A455333524574484F4D4B6D2B4361324873586134646C6E547177534B7861484D4E72523757374659776B49536C534A646C4747434F646B7359547868493976595272516B65455675437443553946596B756E45684E71466F476F635639774B4A546C6D316B315557366C44576934316F5A3178584457716C43626C48496175517572336B454679643551693148616B6D646D747759336952684653753861316A4668686259476D796A51526D7273614D4F6456614C5A743751456D45627761326B7234745A656E434374325644485A34353271314F497758374B657863786F68347A4D327A6B6876353142337A41556B6D4A41326F70567754516E4A7A376A7261457558634543344D416A76355472714A683039485271306242396E30454A354A6E702B6D524E5A3356466D664C327470424F764A7761656939317A54716B5859726F537264633277576A457A497862567A5670456A6A6D68576A466B787443584F49464E6463774470726C65494A534C754B5155386C6B6F454574454D304A316B6E65562F34696B677866316C514F4E77392F6650655431577764382B48696558533969677841496F575A375A507A426C383778483337724F762F323631660A5A71684E5354486C4E394E546136597A3259317770342B33417065304236705A54752B3635423275746666457345353533786B6E547354396663586A5363724B4D7A426F3461524C4C43456D557762446976455A324A77504F37777934735A3234764C3346614B6955666E464F4F39797951646F794A5535576963506A6C6B66484B353673567579334C624D3531446A445768694E6C5A45477A6730727275324F654F6E696D4F306856474874656243326F524B694F5166486B64754C4666646E5334366D4B31614E734567526C386735466261323937697755334E395737693275385075554B6A44786D7468732B344373'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'45724F53644F7966394A7735305134576E544D4669746D7135616C31347772324B6D6433547152786A746333783377326D374E6C653178636258796E307A386C41733279376B4E714D3830764471744351657A6A6B6648532B35506C787A4D5962707169436B78726D757138595162757A577637536B337A796B75677A7A466749527079446448484A55496B736E4B58596F6F33566B4856307358446F386148683433334A38613039574D616450782F3548326E6B31325A64655A3572504E4D64656B52326243466C414F5A55675757535246493471696645744E6A61546F3770694F6D596D5969493659722F4E4835672F4D4435677648597152475A6D517842596C696932535256752B67436F414252524D656E6639505765624E522F32755463544A56496932425742694D7049494F2F4E63382F5A65362B3133766435717743464D6E524C5337737357477956504E56567248633133644B676F384C71356A3576504652654A3632696C70674F64446F64524557594879544F796F375557585655544B31374E6266644B2F715635386232684F392F644D684878314E63314F5169424B4E6F5A5A716E56334F2B2F706E7A2F4E374C477A793330573375685561304E5873464A575147466B79797A64684F646A7072613778634C6E6A364954435A426B37476A734E78344767713943764875484A4D6E536545694E574B646D3770746B7357696F794E6C6D477A59316C5A7A696C304976334D474B7A445365526862384B392F68446A556731737247617872666A55656B355A57507031354E48526C506350484165444B51545070584D6458726E596F64535232377339427448676F6B58466948556A5674615775624C5334654A4342736F51342B79414A6330734D6157796F7A565A707068366F5839636366646F796C352F7774476F5A6C676E452F564B79374C537A6C6E756C46772B74384247573945782F7051354F6D3830536C4B446F676C4B6354414F375059726476754F2F6148435463634D335A5261684F5669675659725937317475644B324C430A347046746F5A7255796A6D384C693149676B7A554754426F662B684966356A3763456C546F564566794C56766F4D6C43797A473347324F52684562437231565A676A5557626373566C3762726B6F4B653370515043556F4A35754E4B314F5732366E4979494E5A4D3035502B334D566B3458424B585355466339627067364C524D6165724E43595A57686D316B4B6F3142474343716B7672756B574D6D6F6F4242487A6F534D4B676B5A476A7179456767365651637A4D596B3035754A5A663134706731595A5275644A647170736F3478366B67396B526E687645707A727748666665386939335A4D476943754E4B454A54'
		||	'577357313563692F2B3655722F504B4C6D335179494E694559464B4330686B314B5434734131544D6D492F2B31426E2B71536855464F776330703965597A6857334F30356275784E654F766845586432683277665678784F4975504B557A6C486A52414C772B565779666C75775A567A4261396579666A617334626E3169306462564771686168554D64664B6F4C786E622B5335655444687456736A626A77343450374A6B4A3170594C65764B4C576E79434E3570726E51795667754D6C342B76384A2F2F7549315874776F36646845384E41717A5739386941776D6E68382F36504F74753066386148764D6E58366750344861545446715369663372485257754C7136774B63766450696672756538744B355A616874716D354D706A5453454547316148453645393764372F4F54324E742F5A6A74773463427950497549386F5A70697330425A4B4A5A4B77334B377736745846766D74367976383967736C785A79696273367747745058757645786753655948424D385758516F385A7A5568682F654F2B473764343535382B47517259466E657A52693642784631754A385A344658316C763836744E646675395446346D3073566D473179366878554B714D457937735862455A673671303461565A6A735A44377A773437736A5872743977492B33427877666A546D7046534D5543732F566C6D5A6A736333477553552B74626E4556313559346F584E6E4E57515A4F66717242546370766C6163414A3565444B6C372B786530776E644B55467A4E4B6835342B34752B7964447172704352424F554A597269584D66792B6163572B614E666670727A75535768457873432F566C672F5A6D31532B47626133343643305170686B467A3578676548417935735433677873364975386565773847497761526D346F56614C4A72415571485958437859376E5A346561504C35363873386B76586C376E55735A684D4A662B594F50623746662F342F69462F38743465526C6D43614C715A6348304A7A762F474E5A6174356432444B582F366B30643839364F616A0A7737363648724D5635356234622F3879724F555676502F764C624E376A68533136426A2B726D6665576243373378796B3433464E614C415641784F437053716B515A7A56537244696F355958624C544E37793764634A66333372496E623042443035714473624351706B3233504D4C4A5266576C766A647A78523835594C7737454A41386B556B31493041784B434D52556D56676E636C353065376B64647544336A7A6F304E75375938596A68306A6E3443384B31717A74747A696D593046506E31786D52637674336A6C6B7558716B694B543036355856426F6A596335345448744478692F4B4737466E6638792F364642'
		||	'784A6B427872704B62415763316B537956774E544D6541316E4E375A4D437875744E6D32627A534E4856485069466E576D4946514E72337A576A32774776496C676672704463775A5864457136614E68374D77724747585347456B577544437435786B4B6D32584E434C5A465375365A74702F484B3070554A706654495A455251575649544E696359722B4B384A5A6B416D7A3574536D68693879426F6E5A505A446A5A724A644C69452F615335304973594651463768394E65474E3777743751703139554B36494C6D4E7879596158464833316D68552B6461374F734252556B6C654A7A574F6A73415A363167764C487663354B546C752B526A657A78316C6E3366484F3370532F65487550663769355439396278704D4A746664344E433543434B34685457736554576F4F2B705A62783561666246766566466A786D383976384F7376724C4F356F4D69617A316737345966624E662F342F6936763364376A6F3531417677714D517331554846344B4A6C576B6D69694D4B5269504C64624132452F3478506B644C6935637046573030757A5365797178764C457A346139753750483939375A3432484D634F52674668617355346D6F4D4467707734347252494C4A7A304F6657687A76383169637638717376725048695A6C4A5A4B68576F6733422F6B76482F2F6567752F2F7A4249522F735452684B344754736D56614369675A4E51455848324564365538335769614D4B6761574F356465665836556745456A51306D786556365A453776523057534B6147696955516F4A69722B663573336365384D3362513237733142795041784E5834377844535751694E5874757947756A4166634F4437687850455A6E4C65373350546250696135685243715071314E4C55316D4C714567494E564662646B655274782F322B635A3744336A3751592B374A35366A595045544E34645A4F334538644962395565443233706833376A376978765971762F6E53655837763555334F4E576F2B5153456D775A363943474B4B704136574A77413936394F375456434D0A76654C4253633250376838776D6F524745712F7859684345357A61572B6655584C33444F4349564B6353616E534C666D494263464D646E70435475345535754731696956694232506A6966387A5275502B4B6462787A7A73567779644D5047436334486F66514A484B3064556D704D4A3943745031672F63335276777A763139337470613550632F653431506E4F2B776B715775314E3759632F746F7774766241784B4E7974444F46494D7866472B37596E52337748632B324F57317533314F5173476B6D6D4C63684166394A5961314D4B3439503377343474675A7641766730337939737A446943364D70746C6B317465'
		||	'68477053337A476468456F44635A3850643339716871787A76336A766A6F6F474C7341714E674562474D526F3664305969542F6F5462523445503977626365586D5A332F2F6B4F5435335356424E686134456241784D624D627476516E66664875627637353178494F6A4D6631707A644248664E31556556453469634C414233594746653839366E4870412F6A4B395176383576564E766E716C67394975705571496F52524131553379686A324E554F484A476354325A314D784936635931625039786E6E7832484444477778524934745854644E4745636D4E59714D6F61426C7A3269365A4D532F504E7644554B6631637A5A743870396A4B314972517078746E77776B37652B4D2F376E773662555A594E43753570574D31526B4D566B364A527A394B786C4B474D51317278684977786F566C7556494E65697A503937707768474D2F6B314B5233625578426272746F62586D73372F6D45586979417763527A65332F436777454D76573449414F6D30556D614779307346762F48734F6C6336686B7738383945645A2B5A33496D67316B7848487831356B6C6D30553161797047656566744661476E61486E2F5A3068627A38345275567453684E7035595A4F6D5A4E5A6A635869665531764768694D50615061457976463173417948456245775549752F50704C71797A6D6C6E4574334439782F4E586232337A7267313175625A3077476F4B59677167424B37524C51353570644169495650516E41612F675845656F71696D4569496D4A48786D56346330485066376D3569462F396534426437664754487A456145303356317865366C4B596E42427178744F616F3871784E33556339514F5074476449687465576379334C556875304F4236646A506E7A39386438342B3064337434617354385272496B5148455A70576F584761675659584978554C6A4C776E7632523533677930377A4770746C78707339496573384749537046494A4549676C4C734467492F7544666B723934393573327469734E52496D344C4E517249625561337448537459544B0A7465503967776C45385A6945664D616F71565052596156682F4B4653512B596C575345626A6F346E772B6F4D65662F334751373737775234504235364254397A4B63793346643039486F6741414941424A52454655536D37497447464D77643677346D5469696436784E366F59756B41496B61364F2F50707A35316A7570474254543078627239494562564778666A4A39365A6D714B414444536E6A55723768354D474C7147794B48566B51505A576134747462684D3563586D3042576658714E355577796E4B4C7850365A326756616E6B346149536978465946423562752B4E655074526A344F7877317044753868594C'
		||	'67786C78364B56776B76436D6F326D4E634F7849376A415552414F6534623969534D76576867322B507A6C4C686D474B6D6F475475694E4B34694B4742586A54464D59777A6476486E485172336A722F6F4374766B74742B78676F744B5A324166454F6A39437649306654514B6738684568514A534D58385436676F30387A796359467170713561315361576F522B586648743233734D4A78573752784E793036626479736B78444A77774846574D596D546B493745617364394C3453794630567A756C7178314D7772627346474434746268684C2F2F344A412F66334F584E3764476A4E305559345538563277756457685A677771523661546D594A6F32724E3268592B756F5A6C5162564E426337686775724370304E6E73655A714F542B4667532B792B434B6A6A647347593936464D35336E7737304F534A5869477A655A484D76794E696D68626837422F724E4139444B49316950624F3064484E425A6E444C73374D7130576B5861374250756F6B4A6D436E7964494E7A61615253387A413331666A395A5461452F78666C596571445A57685763303348616E546A6D306F3766517141314572546C684E61636F79564B553658446577327452526B6470486E67584A68506E2B594B585774615A506E5330313434396D745444335A63797A516E7A707537342F70655974584A6E33494D59444A364A59355479316C66475A7A675A5A31715A7933746E47564E425666544E63726869544B4678564F74334E5247434A426D655A375174467743644D57586C424867304C547A53786C71646863614846757363504B516F66466C7147724B79623168467637597A3759727A6D614F436F66775165326A6D752B4C7764307A596850583276547469304F7834487650426A775A7A2F2B6B447548457843444D52475451356C624F71586D2F484B586A6C5A6B63555277505737334D715942566C71616A5957636C6C5A6B4D64484B4231487A647A65332B664F663748427A74796171446C6F486C6F764938347557547A39376A7558466E48466463652F4245540A2F65473748546434796E77696A582F4F506449344979764C79327942656541704570377A343634762F2B3568304F656A414A436A45613578534C6D57563949574E6A70577751586F614A672B4E425263384C7935325378624C41364851766E566F635A6C30494E536549783862566C346C514263574E76516C2F386534682F337A664D5A796B7731474752326B6879777057466B716532536A5A3742596344436138767A64697178384930324F306E364B31493165425368647074696D57324D43715A39446D447738633337797879352F2B38426144757141324F64596F56717A6A73786557655871356F46506B44465362'
		||	'3739336235364F3945614E4A514A6D637258374E74392F66706837306547613553316C6B3549565152303968464A6E5669616A755471756D6E2F746F4A6F6B7749306F5954427A626663663959514A71613532657252694670534C6A796E4C423165554345346370726B516E614653632B5430626D6F62455A76335161517A51614472774967332B4B66556A703046684C5377576D71575735634A796D30734C42537674484A756C52663768305A424852774E3266635659616F4959546D704E62396568666E4B666379334679357570796A4C575971306830304A6F7173496F6B556C742B656262752F536E6D6B466C73466B6257773952576C4730466C6B746F45564E514C4659576F366E597954573658316E4C664C4D6B6D6D426B4F344A6B2B524D63792B61714D5236484E61524E2B34646B526C5937755138663247527457344C46794E627832507562734849573379544B655946336E3577676732524C31376F387572565A6649465335424935517A2F2F4D4542662F62364937353762774465596E504E51686D3574476A34314A55564E6A6F74384A35487832506532423579662B695A656B577655767A6B336A4571436B2B66792F6E74636F5731525A55417A4B4B6154794374353669507032303873656A69707947535A46366A57464F69745A6E374A3037503839496759446A4679545474514B4D316257745A31495A3848675751586B73546D3466727450556F73784E4563374F426F4B4E763970356D515A3742594A553056566254456A6B72797069762F736D3061485861724571724D617242463856554C697652324F6A707848314B36574E4A384E683564546B443373356E65427174552B534B4E4831616C4D586152637069645A35646455726A2B506D7755306B316D575946457738374936477561364A334B535450423354525A616C54637235724D455A6A69784A70494C3030687449364B435A4F3036735530305359777759336432675946466D736357513455747674306B49677A33535454516172486374547177577658753777680A5A657538504A61786C4F4C57664A74465156477736537132447275383439334B3735352B35673348787968665A722F3352396F7676306F387257744B6357566A4A33656B472B2B6434742B663051574C574A7A6E504973466C4E2B35656C7A2F4F374C6C376D36326946545932796F694635786F2B7179312B2B7A594375654F722B494C5333525248726A696D2B386638672F66546A6B376F6B6E4B45485A794D586C676939665865512F66766F384C363062756D566B456A6F384F46726A6A312B2F7A332B2F336550756E734E6E68684272377537332B4E4F33446E6C75347A79397365636E4434667339423265466D4A'
		||	'5337704B574D562B396670367650726645382B735A57563469597169644D4A35363768774E4B504F4D6C7A635873556F42475561647075444F416771314F71567A4B346C6F37396B664B7435344E4F4337482B347A39546E474B705245516F776F58664C4C56356634375A64572B667931465662613042393733727A66352F2F39775431754848683630614A316759754245464D46353155445478595055645033687239372F52626675726C486A77556B53346536533674747676364A4E663739383874635738306F63734D3074506A5355777638375930742F75486D446F636A5379427956455665332F643835384E6A7569334C7335734675646149543555594D614231396E67562F32397556374D52524B706152355650465857776D436849544767307447616A6D33477570636C317569343076364D5344376F785355756A584E617A2F432F64434A67617356526A576F342B5948334E61683535656E3256707A63572B634C56525A3562735379314339713549564F414F423730417A2F3436495276764C5046322F736A68714D4B6F6B644D693466486A7473374978346444466C615657524E7A4965546E426854634B30507774456F31614C65657A6F5A764C4265384E54794A715A6F45557A4F537975526A61554F65794F587A4D484F456231506362562B53677874504A5A6F387751623135494F426731355838654142617759436D4E3539636F71762F5879476C2B3571756D3053695A42382F436B35722B396D2F4F64327766634F357A4D313167766C71326535322F6632754C7953736C7974304F2F4372782B6238713362753578382B4542566D6D734361777374766A73307776386C316558655872394849746C6751754B683850493337363778542B3876383372443370674D7A794B7579636A2F75736239336C6D4C516C573275554D554A34556B496767546371382B735532724C4D7444505654466C4F4C7464307A4641513162786D714762547973544B7630554A7052647471756A724E4D6B344C2B466B5437366652367A372B56576F520A566B46784D7645596D2B544F4C6675762F624C4332553159617968513546706A3574744A497946464B4F6A545A5965633457507659535A534F4C3277487A3854704A3976644A73794F306552722F385047524A6E70624B4C4D4B7946344632696938776E544A704F626C6A725A436D495571636249636A706F6A6961426D377544506E78777834486C53656773464531794A6230336A492F77716B4D6E52567364484A2B363371485379736C5A5A3765773957316B712B39744D346E4C375834314A55314C6E63567134576D6C65636F6D364541487979586C7733647863677761683731707077636A79474F384C376B5947'
		||	'5334386643456C31594C42725877305A476A6F6B674C5651524D786C494C506E466867642B3576735A4B7979413652346C4852633346324749344C724255387A61456337423956504E33622B78775A322F43784355577054566A587472733872586E562F6E537379757374774B6C38745142566864795469725075494C64347A3047305341526A6B593150333534784C332B4F72577A394B595A506969692B4A517749454B48435A2B3530754858586C7A6E71515746796F703061504B4236476F2B4D533551797242615A724F7A597A704D79616E5868724E4542556C6D547755384F686C7A353244456F3335466943704A76465567732F447378694B2F39754936762F76794B7464573232523573686163612B66344B49533344336C376538716B41714671516B7A425A316B5469434E4D6173383732324E653378707737386A68676B57707748494A6E7A356638416576584F4454367A6E4C48594D78426F6D575471365A316B4F32543437352F6B635167364F4F6D6F4E70786F393368337A6963706472617A6E57536C4D784A71356F31426C506C6D7078366D4730514655487869344A6D345454655A67784B5631677362515972616D6A777170472F5368684C736F43525A426B6F6C637A7A5A55366B3173334E38554C3630736C58336E70504A38634331645732317A66614C4852676A7A4C73555A6A6C4B416C59334E467356436D754937644839356A4F7656346B706871574164322B6A575065685576724862525569632B4B515A6D6E6A565256463551427136736C587A3655707576504C664B7465574D49724E346C624861556C78616262452F36524644496F43495351705046543078786A6E524A4572434774534E7669357031734C6349337074733874586E31766A36792B763839794B59497A4669654C615371435457775A6A782B48413036746A5172307051372B4F764C55395A6D383434596F72365533683278386563334E3377736D6B69546A5367526332572F7A573958562B35646B3146746F74436D4F4A4564615849784F337874460A6F7A4A333948754E67454238346D645338745458693576615970355A6164484D7A46396739666D5435785A7143647561395565726A6D316154616155736D5631416158733664524B4655674746532F344D6D57314171595557426252577449796D705A73386E67596F4B336F656A636770645538393969764D4345677170744B2F50785675376B395962686E4F4C32515533593942486D56475444724E72424C5336556F4474736D414D69714A4B55517341594F6870695748644753486A4446526D545333616B51666E6A4F4B51445644574F6D6D4A5A6F79503470736B566178535A6C744E484570703633526E2F2F444F'
		||	'454D426B496750766A464E796978536C42685366454B337A424B3874326D78787559306154534D7068587650446A6D7A33377967492F36457A77474932554B436C657042576863443638794F7130574C3679337562372B464D76646B72784935737972717A6B62692B6551754D4A794C6D517152584F694C46345549674772552F7668433932636D2F7331332F33776D4F4D4247462B6A6C554A637A7633644533726A465149574831724558424863464C784832344C4D6C725479676D346874504D415751476D52424F3568694A624C6A47557951736E63447830664C6733355475336A6A6D63796D783853796576656556436979382F74635446726B373966576377416B7374793565663265542B7759542F2F76344F6F35456E6F706B343463464A6A3976484653756C70637A615747577051773068685345576D61646277474C62736C526F544747612B796468765336754C7151445555794C5270435A7631446D4D38665A6870574571364568725669326A7364736E557959684752596A343078754D7A684B38387338367650722F4C4A5331324D4B4A7A534646703466734E536470613530396338374F30786D6C514A4A52676A59496835686A4870514E41626537352F62352B374A353642537A445671414D5875705A584C3762347972566C6375315357306C704D67315072575A38396B71583933635865584E72674175524B4A6F36474E342B4748442F5A4A6D365871426A684767306F704E514B76436B3662326E73315956466258335643476B5757774569536E6D305368504A396530636F5057686A71452B5A68675072325757637132616C42717337584A6E446B6F704D394447385047617075764C5337524655644C532B4E5A6242534C6335464D556F472B744E6C4779546D2B63574F4C6E5948676E4557384A6944304B732F654F424230675442704D48524A364A517776696D76617146556650626141762F683155312B35666B4E316F7630756F4C47365977594665706848783869596E4C4561695247544267316D594C533045347330320A4359524E506B41445936417031474B6939655875524C7A793779797155534C596F6769684B685731715775693365666A44676E653070787763313061525674777142427750507757684B662B6F3448426C65753366493974415456496B53433762696B786536664F325A4E545957462F464A506F42566B625853385A6E4C43397735574F4766627532774E545334344B6C435A473855655864377A43766E757A793155694257654C7A33704D394D4935384D313275566B69626439716533734A5453354B614C316F30445A765A6745744371546E386B7A69736D61585A776A534A487944587A7758376935656D3541312F72'
		||	'4D333673356D64484E6176433071395642385657762B4B66372B377A776B70426F5A64593656684D6A4931694B4A303454716B7A367378464F647565533631494C656B765236584A6D4E4357586472736F56564E6C4B7A786C6953616534716F3171664B78316E38676154726F70576D4C465A706C786650564669524D784674502F6444484A74356C5A61496A5258616D4554444268436265746B786F6E584B47534B47394172476F455061774B6F594F616F636A346165725746544266746565742F5749465A6A66466F677036493548494845696B77466A4354366451644E6F534B42534361324D59536E764377586F51374E513655695A535A30644B536A46564576496F55692B45685665556156776757686D326D754C5A5A38324B3849453464534E6454436F33374F503977355A7247732B506576626E44524C464B716E4B67567561544B50614A77477149496438646A666E54515A342B6371613652594E44535962587465586C7A6D52664F356568366A4D39614B474D516E54364A3159356D63376C6B6361484C30586A454E466969316E6756654852307A4F62355261347361485255614B75534F5651796A724D75662F4C3648754F78347A39392B6A7A50583167677A3571776A686D56514D553030347832666E41346C517A70755674414B53453241336D6261665A3659343548486B7A52474853544D62636A46622F7864497358316A52614B6951617445716651594677745130764C734C7248632F57795268744B7343696C453041576133774555366D6754636644546B657861542B7368466E4D6935744C484E7463356C435139424A7A61726A6156396B59366E4C4A7935745947572F61623242723466634F5241653964635A4F55576E7264413653336C746B6F513936676D6D456648306141744234535467593433325661717974476D77673955735A41576C494D2F4E334475706C5532396C2B6A54664D6F5554534A78736D6F6F66646F5A5561714A66315251614D5661446A6B707944454E446C496E78516477495243384A387653670A6257564B646157466D676643634F712B647A52424A584557375543386878724E555763347251695245486A7962527764536E6E56353564346A6466504563334136507A4250346D6B6F6E484259324F6774594E4C4477474A486930566D5261593155366B45513034786F6D4C6F6D706F6C62706A31486B6563344C54375735744B7252756B716A466F726B5756534F74737034397349437A313561345950654955454368416B786549624F636C7846396F6152683865426A3435366A437148306A6E4B64696B3767577362717A7833726A752F566B6F786A324A61375252635769705937625459475553697A6C4E42596A54'
		||	'763767323466377A45353639704E44484276596D4A79692F6D5977762F6B375145355766703157532B59566C544A76564F517874494A386D41466B39435854597143745655574D3141797769594A674A427A76714459394D5731476435752B704D592B7A556D7A5431697531657A59382F4F71516A6931773731794B71547549514E6944617562666A54493131746F45585265593872686E4A554A5367315A51794846484943556F436B617A4A37456C35576149554A7571477A78625444432F4F4B7134304653714C52664A3843614E626A2F76596E7144616E53556F3630625256476F2F66367A54303676496A534B4B4D4B303952734C633536566952436C505641614D4A69734D6E53796C4C7A746C30466B7951337252524B645151524E55686A4D5A4C6C693073556D5668557065444E4A316E515334657A786D713139784D417A30717343776474546545554A4553774A7A767258645A323877514373495069497842575A4F4D4D536F754E544E2B4E337271397A704435694F4E5657774B44464D7138434E72534852443367776D764B3538357438636E4F4A703838586C46716A6C553278366947676A5749386465774E787454654961465A7950535573524E75485935353766364150457759364447435361676950494A775A322B4946307651475571535A4E7A56697432544366627949732B66622F4F5A4B323175484270366C554E694A49624937594F617635456568355049463539653470506E753178646137485353687672764C566C6D67354651336959693451616737734354454D376E2F71613464517A64636D6A46654D5170584A79593167714F327773742B6B557858772B6E4551796D6D6A537A6253786C48477559314C46467650354E714264496A5255796E42514F5437616D7A43715055716C5A355451596A514B334E6B643839397548364B61325663794E4165557A546763656A375948654F6B71585330416C737872687A483435702B46646D49426E787A7944576776637A4454582B2B445374744972713558696F7A614B76510A6F535A6B42614B7A5A75736634574F6136346C457A4F7A416E4F717652706B63306A7735436C346E512F49735A566B525434584A7170456C4B555542754141372F596F484A78573767796D6A365954683144477349354F594A516831384978484932377654366A726D6B49384958696938596C6B4C7A5647596B72376C7441455757627055436D65516B5775625A7A6A366D71587466784D46366E78734D7A4D354B686D6B597A545274554C555675437041676D31577861336765434431674A4F445153775768444A792B3474704378566D596732667A33544D42636856575238783346706137516B676C5654483439727A'
		||	'5244487A675A77323766733957624D716B6D47466554453346475953586A77663649373930366F4C536151624D695A557251786846437A7533744561364F4B5745674A6E2B7244704550397857376F326B6A79484670424E4E30764C536F35686B52477366396B383677314D2B594136574632646F6C5444504469673372324F4377544A723059554E73646C4446624B426D356C6C534D2F48555754475269506F707236726D366F335A587830355961746663654E2B6A78655743796F666D77336A544D43632B6D6B7A4F486D3843644730334E51384F566A49474C4D67322B517954503334526A353675766E4A584D55345630484F5046624B6F465247713768456B61326873593249354263374F63776C386970524B6453386D3647776B724A7A5849674D613963494E4A6F484F456251716470734634616E4E3970382B5A6B6C4C713947616A465937646736476250563978795042574B47307262354644584B4E453536456C616E4E33467344787833443866636648544342346356393038636878504871484C4A33784D466B5A7773656B617535726A3253636A696B393042725A4E5042396A6F5A6E7A747557586532447347482F6A6F634D716767754139657A3150662B7A34384B546D396E6E686F36754F4C303458754C62535971325430625A674A4A6E52367A6F7947486B494E537171786B32666A4D4C6676586643385444516B70706A535A4F6358434B6C54504841687965422F6A5469352F363467484F4B6E5746416C4F62365A7345666647714E634750496A66304267386B456E476367686E6432612B366637484C37634D7958727133797561655765586C7A676257756F737756787569556E335A4736536D506661684E696B477A534663754D6732436178412F306F527A5A695A6E73643268566551596B39773355626B6D6F56666D6E59647532374C51536C772B43566B617869506F454E42613435566D34414C372F516D56542B77714A514556685A336A69753939324F4F6A6B53663351745A45417455494F6D737A6E4467654876610A7034686B6A763158456F4267377A38673159476766306E4F6837627837387154332B71774E6D6D5747334F72544255796C6F617867474C7649784B564E536575507134486A715A4172786C535A4E66354F645961787748796D42644D36736A6432664851383465624F6B4A7337512B34646A526B4F522F536E4E583050597A704567537857354837437737484278775162694F4C6E4B6C776A7A596F5848434547524765494E3432434F53334B6D307464566C6F46566D4C7A6A4D3142675132753662514E536250596F7778526D626C6F5A795961495868304579486B4733573051624667436A624C6E4D55735379724B4F'
		||	'5977684E735154574D3768584A6C5153303653756C4D4D5644457772754234364E6B66546C4C625651516A48682B6D2B46727A7876316A78714D525A57595A4E75387053786F6A6C4C647348553434486E6F6B786961374C35474F646E706A54715A316779674C7A57457543656473664E78372B7351715161317330785A55632F6C7A7171737274496B552B54557931555945616D32787756436F4957337059635152644559553351696A58544C546969564567356541317759644E566E446477303677565A74544B6D3473317770727A5647584D4A6352517457636549635779635657342F476E467A582B4B68546F696B6D3064705678456A6A51576C616435715A536A42396C57504A517870364F36334A6F73627179494B63634D472F5478616E714559574B7A7135795133754E4D7778706D476C31594B575757354E68724564466C7166703879655469656A4544456D786555527A524F315A324F6A464C516D6F3267746F374E65387643496F714D64506D70477A6E46634A324E6A4F686B6E3272796F4168305646397561333374686853382F75304A6461315341484D6366763758465837793177327433656C525A47365243533056474278387A52424C414F424234633276455837357A78446475376E4338743839514369706C69415269794D6C79677A61527145356F535961506D73706E4F4B2B7744516A5A4F6F64314652444A796F794C6D35622F343076506371487A694C39383978452F334273695534554B43756379646E7157762B7364384C30502B31783765356E2F2F4C6C56667658354E7463335737547A4C6B70673667794471535A4B524D5730594C7367534452383739594A503772646F31535273636D4930574269494E4E6A6E4F51344152383973524A4D316B4A4D4378656E62453074417766586C6A502B7A312B394173552B764375382F734468716B436D46635A482B6C5846503931322F4F44526B4F632F4F4F5A336E312F6E44313438782F584E466B564834315343444A6D59354948524E7562786D496A714963766D62620A644D6C34524D4537556E4377356E63714C4B3054616A6247574A6A346B6E4B735649636B6F6479435251784C524A5A46716A6259597947535A45596B79783874704574446259474E477559684972416859684979714C31634C39587332445955412F6D4A4B484D5359364245326C32324248454372456A5A494532706A6B754849467141342B616C7963674C48706742517A4A4C594A65705467744C504D726E397A6142344A704E6C63546B31585139646D524A4F515656704E5555726A5A49474471654A6B4576464F304E6F526462714F526C7979444F674D524D687753617768306A5366556E64424B5931704F695A45'
		||	'7A365065684439373734512F6675732B442F6237314250504E43714D4E33697443465A6A395252307742496F66554263774B73737456437A745045624D6F7A4B714A58474E6D6F395A776F6B706E766559366D307873594B6F394A383668547530384147464B6D4669436245314648513269455343513262565466576E5267446D613749744350714A4D3467426F78577445325230686B4B6A61694139675A463472354772544669614F635A5A566B794E73756F4544464D55637068674267566C644F4D6E47497168716B31714A6968766558455A587A33555A3866504B79535245596C61354D3077696D6C464E46486E45392B30475370734D5373693638507162784C716449787A556D39306B6B376F446E6C732F3569736E615A4E395055782B497A6C4C4A6B5751647438395136436F49536835457856675A6B6355716769785A4A77466F70307142514B614C5753567A6552482B6B6570445466436C3168762F303247765338506B553436726D6544426D4F713659564234663431774B722F364E30573573576F596D4369494E6C554E466C42624B654549333774446D4D4C5552356A54716B4D36637A616B676D59485478696753694B4B4A3472436D7A554C37475261376D7852464F305779475A6D334D7455543558796C556C6572534B63556E6C72524C46704658796659356A676B426458783250507773476176502B486959764A7147445854587770615139746B354A6B67655568475646327932456C2F5632494163656D415A797A473568684A6A4D54395565546239346238356573502B4E46484178373250433632385370426379393234646D4E446C6557433962614757576D7966495748327A332B634874417A37597277685A347756534157554E55516B526839574B61797335662F444B4A7463325376372B3768467666746A6A3055484E6F49704D3342527642652F4137666634727A2F633539622B4F722F362F45562B353371586854775367384F464243364E4F68302B444170546C48527A5338644371547A64434347475270466E430A64716D67343247456F4F586A42676A70645A634B68304C4A6D4C517449336D3931383678365846466A2B36304F5548482B357A357A6877504A3631696933447358427275383930504F576A7651472F386649365837322B6C6D5A6732715532726B6B746C316B476C5A3872694A72326F534C5A4E55515159314F4C57564A63683955656F354E6F77496969315A79697A795A715235736A316943714A7567636151357331676B714E6A3664434D346E395A386F526443654F413230536B575A527A495679484D4E756B6A673635676C6A36504B472F4E444F677A47474E5050524667744C586C57344C457031566646524771'
		||	'5067614456762B32496E7A56735A754B4952686D3530444B734C37553574377A4D3458434B43684D4D6A6F6E4F3254385A387642347775346B63736D714F5A5970786B62476A6943693857544E657045454D306F533777384A54637663384A31374937357859343976764C664E6E65504973436F67574C543258467A4D75484A756755767253367933436A716C706A41425630333575772F3633446D5963444B7443424C6E496F2F5A3464696178706763334750726D44535167644E5564506C58634655792F334E4B367A6E316C49713169436F494D635037704179316B73515068416C3559794B504E41476554545558424852554B4A5668746157514B5A58335241744B5A5931327732466A525236724F52624271706730695448514B5952326C74714E576A6677684167687068314435787174453074546D71514A38574F4B627335534A38654C7773616B4645777154492F79446D4E49345A7638516933426E7962625474574A4A694F7A4C597A746F48514F59646F49474B5A6B39476D48597971393167424559304F2B6941516C4F4D424A3435566F3941723844503758783658744B6F6D62364938716A76746A5175575A316F343678444D33675070583068476154624F3549514B36695149527841687474382B696630684C5468714463504D393671626F6A6F4274464849366C646942787167735A4B624C3275496E616264577351313653716E5179484B66584E36756D797075735451387639466973324D34477341674372556B656636674568373250422F736A2B6A6B42577332715A79537A4468784B784B4F796A643559554A41734D616747714D68456B3454616258464548416863502B34356B2F65324F4F665039686E3536514756554365733748593575574E4E6C2B3656504C6968597A4C53793357326955646B364E624A662F346E75625237676D3339306634707538725268486B6C506150676F5757347356326C3433566B74576C4673387474486E33345944622B3250756E455236496549446E45787166764B77782F3759634449700A4B5A58687931633761434B35546570416151534D6B4D45344141416741456C455156524353695641367938397463543174527A624342566D687938526C5459734461684152795579516471774846665846376938314C41576C6548466A594C315473477A797756586C7932765065687863322F4B626B2F6F543848357748447365572F555933645130512B4F514F54336E6C396E7252764A72454A303868476D41355067544F72357A365547457243534A427052616441474851514A44746373526B6C564B4F514E686B666D62665530376734534964514957617032694F696F4363336D6B696D4C55445441555563554238'
		||	'707761636C796661504655387464624A62454A794B617A4F754537444C4A374B786A756D59534864716E6975647A6C7A7173747249354731464C614E705954357A386469704A557244557A72693030754C4B577066424A424C6342455541486568504866644F4A72782F4E47577A303859324C536D50495A386C437969616D5A59305072675A48434164684830556A7159313337357A776C2B2B75382B4E42306345466C41366F397579584673742B654B5642543535615A6D6E31356335562B5A30533430316B6550686C50634F493175394362325262366738716371494D52325938387953573432575150676653444B65666537714D63516338313552716B56737168396A453045705168556D31485746397846743752797A6C4F366274465A4E764442786159515456414C3052677A52614C53435841754656673334514967534D457178594F485669313275582B6967566462774731504645594A76346D4A556D732B7157514A376748704356756138644B476249415A7A65306354773952736A447A786467583258376476615A544B794C4D756D5633466D4337526A314B4D4F343553546C69554C66727964447146417148704B415952717068632F62455A4C73355455495635304E786A6D3953634535692B72674D63443659636E597A41526161566F32376D4A45726B7A48346E6A38555A7A456A72677541514B69492B375462704647474568577148566638524C5857436B7A597A5861326F47554B6B6B534F484A6A4A42464447434D536C6874565675634748744332545A30696E5648673855637744716B7842424A586A516975563269356376465678624C726C374D4F466F6D6A78556D525971305477634B333730634D69467051575757686D356A6B5354354B35614945746C5967706F455956343177542B715762777155347A785553775368685777767537592F37323962744D6D6A61744A6842452B507A6C6B762F74632B66355435382B6832464556446B694254616B727564365639457146464563556B2F5175635555485677747147410A774B734D68474F5078514C75643862586E312F6A6131525865332B727A7A5676372F4F6E4E67687662593434486A68694561466534657851356D547A69346645652F39665858364B7769755732545331583139675774474B7A48666A6650332B4F2F2F4470445677396F73775730756C4E52564A44644E5A7546617750594454536B466343476B4E492F32394B52477157753462504C367A79686164582B6256482B2F7A546E55502B356C6166373938365156796157396269325A39572F4C6633486E4277654D7A4639684B667635707862694664577830614730527A614D674A43566B6D676773566D5571656F74433033'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6C526A5A656950787A676638424977496B3030695A3046716F4E6B684D6F544A685771716A436D6C584B556C454B55786355302F432F7A416C7532554B4D4B3851357352645A65355A564C626637587A36377A5236382B5331536B61784F46746F2B6750563548676F49384A44596C434472554B554178654A4355647142546D5A484D3671704937656D5056516E2F576A7442792B7A357A5668746136367446467866792F6C773139436670696B4E79754D77334F6E562F4F446843562B38736B4457504F584F324B526756623778676D72386A4A45704768395432306C706D41523464336649642B34653874616A486849564F6E6A795050445559736C2F2F4D7736662F69354331772F313659516C5459694152634D75595A4370384E45444136566C576C3272465179655375686C5765303835784D717A53336C592B355663374F306D634C6C70787533624E4F30754D6470744D2F496F4A7A456130456B326E495453502F5631524B4F496B5668354D70512B655364797730336B3264446B504B434166544D62756A49556F374F6D57484B71526B417456716B2B556C6556365335524655686B6946623441493631334C2F2F7A71426636584C31366979504B6B5946524A375046784D376750495948416457706B6A6B6E6A6E567763516556703832776F5279617A544A742F322F6E466A4D5071394B5130557A764A615576516D685A6C746B466856676B634A70322B3872546B685056776C7A333943694F3967696A64304C5442423246594F515A4F38426D55536F67717A495545357247793931534F50682B614A746F5078795048386168476A47466342535A314F736E6F78767331627A57632B66395A736167625039574A556B7A696C4242545A704E68774B4938594646324D455263343147616258796D6B66784B54444D5472554C6178465167434C52624631686165496C3236786B5542524C507441492F5271502F65624F776C4C594E35316252795252666533474465774E344E4F6C445442676D695844634D2F7A565735354C5330757364690A79584678726C6F3072764F5571794469696C306D4459314F516D5949784764493757696968566B736C4C4943394B646B6243652F745478704943795A4B4D474459366D712B2F734D52586E32356A7143486B4B473254656B5A486174456356384A2B4A55685A6F71737832676477486D575444466B48536153436D456743566A6C5167574174567A6261664C31316B52657672764F74477A74382B2F313966764A675449774B744763534644634F4C4F38656A4C6D346D484631705552624133574441464D7748452F5A363038356D734271717A73547A69624D6A79527A735A6D5637427155314A79367251743862467257'
		||	'6D6B512F5561715A6577536557657651625A573864486D44763938383444736637484A7A7538653042704563707770327067562F38384565363673624C43323079435343636B30556A385A4569394A4E516A41616B2B643079354A57626F454B584349696A4350736A774E6267384454745643324E4B474A663948694D5531323063506A43592F36677053726942536F474241747546614256786D694647554A6C7A5A4B65714D4B4E774164444845365965756B34464666455654616949784F73766D30756D63456C6154616D56487A4537417971635776544E34634142573170466D453069624E74474C39622F75455A3750614D305A654A4E45424C79775976767273416A2B347330742F62416D536B6673615A77776648517A35683365332B647A4741702B39556E4B756254452B704E666D56427779627A5532306D6656694546474966445733704344345253447775596474446732467A4D2B64586D4233336E704570653669616C5A7178797668567A53326A4E776B623365684E4530674C4C4A5A4233537661456C72584F5A745754576E49467579383934784E572F714B67344D2F70515A77526E4836664D6C566B454752504370446C73476B49494F42575A6D6F4A483030422F577250534C6F68474E646935356A364F77744567736A4F41556368515154556B32454137444E6B6F613834764C4C41314B644571412B33542F464B58374977634F3864542B6F4F4B6A645569436332594A5754454D3536364D78737343692B7A37356A3062307A6154394B414B4B4363707A533261516B2B576379492F6C6D556964502F444D5955464E6B716856314D413032644552575539466B4C39796B354A6970507262506B68534364514D61313536674B564C4D6851764F42364A2F57446677704C3138486F54667839436270496F3771774C694F75506A5467533866623533506B73474845686D465143554768575568374C4C4549316F63702B476634677750555A726341334D4B334655657445655A674368467433574E3565346E794F784B2B70426E5A0A75636D5958555768766C456A5A497A344E4B3244587A703657566576624C4368635657436C5055426F685530776B337430643838385932332F70676E772B4F616F5A317367726F475A4E78666B4C5459464A4D513569335055394E413170464D6D766F547832372F536D2B61546D4A536774527438693576464B79735A41314D6D48645149465433586F34436A77366365774F504645316671436F6B76676B55366D744734527171716839436D5A55416E6842533253704E4479373375597254792F7A68792B76387557725862514E4B4F56424173344654767165423730703268696558657653746B6D5A6834595950494E'
		||	'4A354E3374456539756A314A666E74416F7A76515A76466A4456315170654B4B4B4D4B35434D394D54516F68553077714A677047414A716D62466F75435A315A612F504B564E6E2F3479676166656172445573636732714B444A6A704E627879356464446E71504C5545614945764A49304E304E685261506B4E466E624773566170324378734531436755575578574D5A654D4F6244337673394370304932525154584B33693472747365504F3459536467516556497A67614B42394F4361495375574B685A586870733856794B7831656F455555654E69726557646E776764374179592B7A72507461457A716D69614675326D647579674D616B586C4936484A58694C4770714C547079664C5879435A6F4F6E6C6F515257327A6D76586C6E676C597474316A703559764A466A525A48667A546C78714D2B662F37475131373738496A37527858546D69596756733154312F545A595A6D47556533594830783465447A6B77636D495165585473786B534B4C6577696E4F646A4F66574F7978616A596C70636463714B5A314855382B446F7A48377735704A304D6E595332495736686977446564557032544B7563547246364C632F4C544E374C483564687172784A43416D6D6B75705969696D6452776332664139736B30495761317A46506F694A364A69327764543967366D7542455579754E52324F55596A6C587248554D6D38735A6C355A4C31746F46685730435632504B30337076332F506D566B324944536C66365162346F4761766B6E54686A53653244676E6D712B4C736F48696D7A596C717769505647632F694C3152687A586236667A6B745653724E7363703869634B3255524C774B6C554447574E5734674F367373326832715257432B534E42445445774D52353969654F38594A6C56617635513645656F2B7A4B6D643732342F456B4C67714479744F76772F2F503370733257584B646433362F732B52793939713333724132324141496769424655534A4653684D534A646D6538636A5776484345587A6E43455A35766F572F67463437510A4E356749325A774A53334C496D704556456F63636A536871434245456958317039466264316258637172746D356C6E3834707A4D6536734253476849464B6D59546B59486D6C3156742B374E355A7A6E2B542F2F4A5735596A6E48704B43706F70517548434C47305953313736675974676D64656C5A785A7864546E4B4F48594C74396A3164386D6B564D4B6F534E54736436734A4B37655944314936524179644664685474646D304832476C653631734943664D2F354D634736523476557759717759734149344D6C58782F45365858337263384E37394B583836507148534F614B79694E49776459492F66765547422B'
		||	'4D78782B354A766E596C34304C58305536432B53632B6965344C594D67596C6A417A556550686C6D6E575164357154595570693657305849556C6F5A41357035566B584D4967452B477A656F4F7A6874495676484E67656676756E494E684C584B4E77526F4F74425A49375A675A783847705143596C725478364F70615352467455347646536F784738734E58687A6530754B492F7A426D634577676853563345364E57524A77744F624754755A594777457067775753534D6E2B6537314D375948523378757230637535715261422F4B43736869766770374647575A575579435A466F3579627269346F7042434D706C584841394872412B36354B6C444B677471674C495334517053502B577A657A3265327534787548344749347571504A694B536C6F4B57314261693346682B6D6D31696B34636B6B53495142534A6F6E71465962656673646C4E304D4A68564376714571456B34547476336566357A525A584E316F6B79694F64787A6E4A615346352B64364931772B6E484934726844463450304B4B444F47444F373377775A52325457752B764E33685278334A2F6F6D69394331514A626648465839393434512F657933684E7A353767613265494D456958496E51456F6B69385A7243574C77306E42614F2B785050566C757730744A42482B644D6E5141534A68484767446F50592F3174506E486E67487458675A42303034536E747272383672564E446966334F4235504B475743646D6541354767732B656233333263364C786A4F464338396E725068485730644947306E484E4B35614D59744B42447348382B35647A7268356D6A4B64445A766A48424E4E51634A7377704B45777754764255494A30696B5134735355336E756E52533863754F592B784E4451514A4B596C775A457371785953345A4E5749327A73703848484F4935567A4A6A7A6B54797843713937574568695748697A6F48547752474A6872764661494B746C576F4947755A6A547A6666322F4969397439587269303059674D6C506355786E4A33424F2F634F2B58573053670A366667535A5171496B473930574B3730326D344F4D78363368365930754A354D52392B646A764A336864492B2F336A6473766A766A7863736C6561354A6C555246765A763359586275585068765A527A6A776E4653474A35595363686C54426758756B6D4F39304947526D6730374641504853386950715A335037666243374A6B6A547A7249704970786E56524C6B646A36496962724C6B334F624A584B503047496A706565534770764F4C4F72474A595A6579515244734F47596171506C676265656361456242735176414345385534463755596F536F616C34367A755746615766714A616753432F6B48356C66655253'
		||	'536177316A4B627A446D7A4F55594B317630686A78577630705033636370534568356157516459656F55316B524176515571506463467553736B327179745857656C666F353166694D576C61444C447646734B5265626879426443674B36395A6949752B74556E657A692F77575132354164337A6A67314569397A6C4A6B7A3070727633796D342B782F66342F75624C5A376237584A684C5350506F4A56337153725061475934717A7A2F366431443770794D555269637479426C4543633651544766735A4637486C744E304D37686C517152335A4F4B6651462F397659702F537A684B35633739444B486B5A72374D336A74376F7A2F2B2F7676383930507A70685A46537943744552496A5A494B585668776775756A4F662F756C6273636A4D5A7339446F387364486E516B665462326E616D555A34772F327A4F5738636A506A54743034784D342F5745716453724577777774464A4E4C31557370496E2F4E5A7A6D2F7A65363050654F48623474493070533934396E504C4850373650527650455870636E566C497564696F32753437544D7546734C6A6D645757366444486E72594D5234587248627A2F67665874726A78426A2B3474316A2F73504C372F487333686F5831334D32426A6C377132333657754B74345852756548393078462B2F643862396F774A6453527747636F33755A577A6B6A7234303544693031486758625A7A4541715A324D514A446D594C484E6C70633357717A31526263477856523141363263767A67396F6A2F35355639704C643837756B4E5567456E5938735039306638323166653564556263307868365569423951347244554A494D6D6367477168753942532F666E57627633727A446A654F432B3457595644756A4F534465784F2B2B5A2F6634585269655037794A6866584F6D7932504C6D32564B5A694F504D637A777733546961386654446D39724467743737344A4A2B376B4C4B5467497251755041563070556B69512B784B654C7659676E364A6E6A5141555A346C4C494E4A6236564B4C357862592F5278440A49744B6C342B4B484732485278446847426B50482F7931696C76483375757654746D712B3935624A437A33705A42723659305A656B356E546C755478543739346359617868304D79344E55745A6147564B584B466C685A49766A77764C716E52502B384A55376650477864613673704C536C6F4B67535872743778682B2F6363692F2B6545396A7164567148356431454A4A6964494A4D7446494B534E334C4241506A48506E4954332F45646850584A2B6B6C4169332B4A71554D7271482B413972316A7834705A42616F3157466455586F63475347563231654F3572782B7A38367766694D7A7A2B31786B346E777A7244'
		||	'2B7963542F755448642F6D4C6D794F47705563554533537163433668725456584E397130326A6C4B776D5A712B6656726D787963486E4E794E73596C475670343768304E2B624D6654736D4B493535396649656E643370633669743673734A627738544163534735635770345A2F2B556B2F474D586A766A5837323052376F532F454731736B697634735A756B544668517678394F71792F36306A5444644A304D3969794F41476B595A4174686D7A34317A687854314F7775304132492F78795A313579727969355943554470525A4E7830634962422B30773758655533676F49397473556A724F5A6F5A70596143742F7736442B6941456E6C6E5076596C6C5A41554A4A2B793431396C3062354F4C45615A6D594D573467394231614B4A58523251696535795843467130736A303231373549722F4D59537262772F747A7A69484D65486E5A2B3164795746634B7261503255594956676F2B763530755763307939635A6A586235322F756A4C6C39566F567144386E78744749386E6E4E324D7562746F7A6D72765978556572725A47633645324F387A6F37683563734C68754551317A4B4861496352526D6F71396C525A58747A7273395650757A79796C445944616644726D752B2F637079774D31772F3672506643753730374E6E7A2F376F795833376E48765A456C55516D567456484248396C774E67794754326557483934353436324451314B6473643039597A4E4C574F6B6D74466F425872682F4F756647365A5433443075387A68472B44434C4A524E44755A31786379316E76704B79324533377A733976636E48696D31536B337A3071387338774B78377548592F376731587673334233785246397875514D626263654A61584E635349366E4A66644F783977356E714951664861337832392B316E4D3472766A522F70547633445338647A4A6B725A4D77364B6273726C57306C51646E6D5A534F6D366356622B3550475A5952506C61426F64664A4C4E64324E316C76707951694142334B425A736B3051535469696A55446F53646A56374B740A6230754C313371385A6476486A4F79507379724B7365514C742B394D325075443368314F4B636A552B3650444B2F644336624738356B6B6B7772684A4A5849492B55676B43434B7373515951366F534C765153767637734255367334692F654F325534727A41795956774B666E545055723136794776334458747248645979543559454F4764594F4F3550505166444566736E4D32596C6650484A475539745A76684F634573486756514B7153544F7A504653666D49443342706443564539716A59424A525743692F3245727A3631787352617A4F744876484E514D536B735950454344735946342F4B4D75784D595A4961'
		||	'746C714B62536F7877434B5578786A45744855667A6C5046345269395850483868352B75503531785A4B586E3951444B5A686D7379733535336A6D623833737533654F656B34744A716D37594F4F565776336A726B723236653850374A6E4653464F585A7049326C4C4B3778514743656139416942627A4B33506737612B37736F375975554A2F4652464F4941773072774D6A416F777A78616B677244744B68343563364977676E654F70757A30387170624D454877314F2B6432504F4238654F796D6167484D35357373527A6154336A47352F5A5A4B75586F4B526A30424A382F616B2B487878744D5A706233726F3377776E507A4A58634742623876362F4E654F3345387468476C37314279694152415A497644556354772B327A697632544B6335616E74727163485A746835324252496C4646714C455235473962654B64507357473552746D6976644C63307978734651535170436D61365470446C4B75684D473556776976454D717734642F677A44334E6D4363346B567568717041433477583379704C392B5A7868715269304E4E696C386441537A545749427338446536474E6C30484C516768574738304E30394A4549396F465761537865424B4C48432F6A50534D444830776B55316651387A6534345036614C6A64527A6D4F4552696F54444846646D48456F48664259495478434267615A64786C70757347676435577431532F5153726569595844774471732F68334D657157793836523547457566416C33696668354778554745774C696F75726D682B2B36574C39424A464B37334458337877776C6D5A4D4C474F737249556C65585730504C424E4B537543674E743664462B686E4F4771633978626F61534871315368416932503949484D6E446C6F4E2F4A754C726235777550726648797A5347485934747A486C4F4F656550574D6264504372372F77536C725059323242616654696A6648304A4D6C677A79686C3072756E706777652F444250587475677A4D487065423035414D31654459464E3055625362387230626D676C4A37520A31474273634F43576152746D6C6F53436C5A626B696373646E747275734E354A364F514A58337071672F64504447647A783777343574514539756D6F71486A3539676E7933696E7271574D7A396251306E4E486A7A417047785A78354F634E62775861377857624D444A724E536F3548425964467774465A6958637A68494A6564786948363645344F3574626A486552697537514F714F66566A777845487A6873553357652B3141646E454F375774476C454E4945334746714B6C524752326C6547613379363963322B546733686C766A79744F43777556786263313735345A626F2B4F2B65364E45376F365A54697A4845'
		||	'354C387452786F643943574D334261596C313755427878324B6359314B557A4533735768523837646D4C564D4238644D71724A3341793938784C7A58456C2B61735070767A34734B5362613349425367754D68496D443456546971786E4F574870356D2F4630686A5764774C7A31344C77456D53426C536C584D51583059336E7141733975734D62694645343458756B6B53567A69557444782F73552B534A316A762B41392B7976586A4B62504B594B50475A31496170734D70695374343031756344314271347769427749734D3454323750714E79384E5236682B643344573863546E6C7250734834436D735664386565662F2F36415738636C4B7930633652534F4176377834664D7257476A30365746346E673859316856775542614B696F6E6D4A554F57367442473733615168333634506B5148344E654F6565774E73544F4C794D7A39632B4764636A686650434A744D4B686C514370794C56694A7A56594B7A6B744B37357A2F5A68583777315A30526E4746707A4D78357A615658775A45713939306B58356B743242356775584F2F7A364D35734D7568347050586D752B4F7875786A6565335746554F453547747A6B7242455961707337772B714868336545394F746B4A33585A474F3874777A6A4572436B61544B644D79454E493275696D7233545377756230454C554A34597A32356B674A44524E552B6C567437794F52634C506F42715875774B53564A7569544A4C74492F6752625838584961684C53757A77723772496B666330396335566A73344B4C337363457A4E4255486B7A456E6262695574314375726C427238735679514D6B69726A304D64714F54677771754561554A4C4D4779744E68477978487A5668356F624A53587A4C3167364254766C796D464F326248766357752F523565543743326937514A715841496F62472B43764D644753696B586753504E5773745572626F6458625A336E695754766F4555725377726B4B70464B565569414C774870306F454358343450556C506E454245555363726F344C635237746973440A3655704A4235766A3146376259322B3579376630683333357A6E782F636E6E4C666145546152646F7A63424D6343564B764D69384E454837572B777753675866424139444A734A424B4A636C54466169364F7558795A73372F396D7650386D2F2F303574382B2B316A336A6D755348534B6334704A5558427A57484A6E714D45474E5836754D2F37567A7A334E536B667A31734570662F6A4B5758444E6C696C47536536564D30356D457A5A383047774A6C345468724D7178546A4173484D49454162417650464C6D516350466B4A4B456E64552B58336C796C662F357978643562726356584C7574774876464C7A323751'
		||	'6265763256314E2B614D336A74672F6E6F6546576F4F336C704F355931514B70477868665247384A48334D52424C51536D44513653436B516B7044796752523373504B6C63672B4B7A6D62674A614239596F644273635A71654E4D317A42494C662F737951312B2B34574C2F50795646587135437443554B42464A4675655243753171545643464677346A4D7952776161334E727A3233783279653865396575383172743463495A796D72774151726B6477744D6D70516F74655366484576345265663257553438667A524B2F754D4A674B71424F733163326B346D73656B594B4577477259376C6C2B3775735A4F3577572B2B654D4476765075416463504A6B695234564C4A7846726D453464324B5644696C416E7A31314A697063414B685A4B4F31637A515652574B424B73316F356C68504C46554C734733567347574F477644482B6569343448384F41355864414378574B575167484947664948544F57306C754C625659767572542F443533524F2B2F66347833376C2B7A42753354304E584B795334456C6E4F5159485447636732715A6E686E5176646C6E5A3436356D56466163545262392F686439386F596655476239586C7278334E4B656F416F504E43736E4A734742344F71635167546D366B69643835636F7158337471683564766E76484B6A5970704D614D675A46354E43737670764B427959536273624955703533695A4E65746F634B6877595531786B5A58367747466457462B4D445836667A726C4673523750706255656A384B55476D745350416E57684F753031566238356A4D7258467A7238393162522F7A4A472F734D5432436B4A616A41364C5232517075514D4441724E4A64334F76794C35316635725263325765396F704C52682F6F516D3959497658327254545862593757583830577444336A6B38356E52653446564F5954326D4D457771423079585071756B38734554555359706E54796A6E556D55436B3248466A37436E394636533268713375796E3047484A63334F55387A4F7452597671686153566262505665340A35377837655952774E57523070693576546C54586234532B5A6D69784F35683545356D6177343835716263386631536355542F59702B4D50414A566B69796A5035587457366D547163555741664B5362514C43376A336D73703469717069626B7641426F647A46316A57587671467330564D7A6874566776325A34593664736D586634347037677A3633384A464A67774E746337775367584A504657593871424447356B47714674335752545A57507364613930736B656F41512B6B4D736E7756705254396B33454A39726B505372784A45485A52476961437855634B786D6969653331583057676C507271573864572F43'
		||	'7257484630646777484D4677586A41786767714E4D517050534766564D6B574B6C41784452336E36375262723359534C617A6E5874727463576D76525367527436586C784A38472F744D65567452367637452F59503531774F4B325957594F556A70354F57576C31324F766E584E747138597458747A416542696B636E71777764436D56443446375631634A6962324444722F78755730756251734F7869586A516A4174416F747258706155706B4936534C4B63546770726957616A763872544F774D2B64326E4146792F30364C63454B68492B6849654E6C75536C437A304753634C6C6A53377648597935637A726A59465A794E6A584D4B787673626D5157584C7131704A4E4B65746D41336137697966554F4C3178635962556C634B7474766E35314679457A686D584B72444155355A537A6D5746536555716E6343526F4A656D6B6D725657776B347634664A616D793963584F486E4C713277327449786B3077685A46685546306C594D733677564B534B653454337442566347575238342F6B4E4F72324556322B64736E38343475356F7971514937392F4C6848596D324F376D504C325238645848657A793573383448683350326A30613054774F544E70474F6A713759364C6251576A6543544330453239324D35484B4354414D6A377532444D63656E4A59657A6B7448635546516830425376534C576C6C5549754E6176646E4E56757A7534673534564C71777A616559444342447978716E6C784A3258513068524A4331474F3263673954322B32305A6B4F65687766495836354942514539454D323867326F593930434442364B4157696E6D6A784A2B504954665459476D732F7364586C6A66387A2B5763483963636C77556C4C4D466155506A475644517534736B6753684945306B2F565279635A44782B557344327132456C61376D4E35355A5956587638623037633236666C4A794D43346146517355777956616D32567670384A6E746A4A63756472693233596754483338414143414153555242564B575843684A58304530544A724B48780A764434696D65675455425A644D726D6F4D744C6C31655A786F77753452775A6E73747248647035696F30536B3856594F3871666C57665179626D3675385A7565306A68424A5649714B7A6E6D59324D3962624353596E30676F7572435A2F647939675A7463466C4F4A58792B4871664C7A792B797250624C523762537269306C7650652F70536A5363567057544B6C6778417041796C597A7851626779347658686E7743342F6C584E764F5354524C42733242384E624E4E5A2F5A37704472684F32564E752F65373344725A4D4B744D383930566C42556C7349365369484A68536658676A51567243517071393263533573'
		||	'64506E2B357A336F6E5254754845773655774D69777469737655433634774E5433773665775A6C726173443647612B36425046746A612B55614A32666659575A4F5935636A6361354832342F59386139693744595658324D7364787659374B423076447531584A3057504E6C537445544E464B77695068684E63723159784E456A6B44353467616E6F667530736C4D59784E3048453246527845525A306B5A6B586F2B41344C4430337079587A366F4372356B66737558644A6D5647536856387048544C61486F6E6F767235737179524551706175737A5A346C7657566C2B6A6B6E30454B2B614575396A7A75725039326C634466306D584A633664394B664D7236682F5757347156764D50563952596E6A786673443266634F7035793679546E2F7154697249435A437852324633566F6956596F62386D5670352F42546A666C346C7148692B7474646763742B726B6B5659476775706C3676767255426B397344506A6333544776335274785A7A4A6E564A59494847755A35734B6779394F625854352F4D61505879546D5A5746712B522B35334F4849704D7766616C317A7065433673744E6C6262664F4E586F75584C6D63636E7330356D6C616346703768744749304C5A69564656494B3869786A4A5266737442325062613778324561663758354F522F766F624C456731365243734E764E324F71326548713779383254476465504A6C772F6D584A2F58444575676D754746416F6C466531554D32676E624855566A36306D58466C4A3265326E74444A426E7254352B74574D703766584F5A79556E45304C78724D5A682B4D35787A504C784161336A4A615772475753433732454A395937584637767339564C3665666967665A426E64654C4E46705246614842614B506C6F5A634958727A51596D65513834554C6664376148334C6A38497954655556684255497242726E67385A5755353761377648426868545452444C5467374B6B564870386D474279704D76536B34646E64415375744E4D5A5868496332565A4B746E75615832796C58743772630A4F703279667A54693576475577366C6C556B4C70776E796870543239544E4C4E4579344D576C7759744E6C5A79626D776D74464B6F73754C67426376644D6B56334272445450635174734E4B596E68734C616662316B685A6D784E484D704A665771666A7645457375787849436151733277676F41587572476576396C476376724C442F524D454868784E75486B3235637A706A56446A6D566C4435494D424F795646536B69684E706756624863316A36793275626E646F7034704F496E68687238336A7137746376566679377347454F38646A447363474B314E79725668726135375A366E42747038336C315A5257456D'
		||	'433558446F756278706D656B446D4A75786C6335355930795169624B37503750543537312F59592B77434E566B36683361474679344F574F396D6F617677626D485A4A4749416F395273723354345A38397334796161306B766D496868386633464C636D6B6C6A31437134376B4C475A592B6F306D306D4E4D70322F30327A312F7338637961352B6E7446702F5A586546487438363463586A4B7757544F6D5A586F4A4B4F764A4875396C4B76626661377464646E754F546F3670453949467777484671344E6B705632797566796C4176724C65366639726835504F58312B334E4F7077575457635734744D7953684C3677644854514446356F74646B64644E6A64364C433332575A566969624F79534F614D467756395A477575536B65737254332F704F4E5379766E6366614D2B66784E6676542B37334930667050536E4B4B394A3750424B5749754A474F36764B502F4A6266556C7A6C6D4632316E534F48597A444E65574F6E7A3331336F7335344B684C636B79754E7467684D797A4779634452356C516D4B383473357078662F2B5A2B2F77622F3769666537766A35483567482F2B3069372F36396375384B76582B6767644E4334615353574A777A7948466C42672B592B48696D2F64486E4A7739397338712F38764C736B3336564B472B415366494952427144486570336A58517667386D46416D553451304B4E326C313336577833622B4A7A5A57766B537142332B66554F462F6D4D4E37764C55423077356A44347161566C7476337434466A52454F74477151396142536C79524B6B576946566F744B312F73416253695A42477077355A6C576C6B4B43386345784F3350425679784E46456F374568476A485370505755716D586F574D49456B496D30783864416F516A662B6139634668775668505A514B6B49714D6274394D436D30713653744953676C534173413472484435514E7065694D5950343054704A36614277496150494F4B4B62664E775963476768534857434643475A4E704542706768693466447757426347307459706A4A4F0A55316C503547444C71695937357763496D303048486F72524571453959496671463156776A65524452774E67726A495769636C54474D3864514359386749564868584F5A5330744B6873436A4B6B736D6B524B6164384F7A6777546E616D5354546F4B58444F39634573417168735136634C334375776C526873532F52324A677468512F5054694967315A4A4D42757179556A4A45424457626A5749324E38794D776267594478466C49596E3339466F534C634D6D5A627743475757734871534E2B2F6B6E6A6431784A69353245754E434E316C59687A47526A75747331417735704177364E436331546D67534353307461'
		||	'4F73512F304A4D367930394F4F755A4635616973446A765546716A564E516C4A704B732F7377434B69755A6C53346D434775737255693870615546335861434E77356A48615878564459772F5277776E3173476E595138455368704564376752594952775A56476549385255426D6F43676657596F58464341464F304647536C6F5A4D655A41565A30597A727A7A657A4346706F7833425431417257716B4C4A766F7872323561564A51784C31414B6A334B6556456D794E455672455641635166443571347572324F77344778336B565741735775656F724B4D71444A565557424E30693157656B46587A3045776B435332646B676F5A355351423671757A3458783064516B30397569305538664C504F774D36354E2B6F78496571564B536249662B34504F4D69324F71636F5355475A55736B5134794479324F4D654C5063643551324B39517144304B3454696F4444382B5065504A76756135666F764E524164633037736731684D687438597367536D5A395051535154665233426370336C664D53734F34384A483034614E514E6D6241784B77714C797833446479656E7A4B627638565439692F5931752F526B6A4F67687A43527753553956695A4970324B4835664369774470447176763032352F683874612F5A4B5637446130362F437763776155364D4D3530764448534A58735067554D32416359534B394E7A384C6C59317478353331686B42624E696A525468686D366E6E6B7A374749515974463353676B4968704D5247386169516E6A543170496D6735596A43343843535137726F7965685249685157506B7A58617643376353674954766B434B795536436C71464439644931752B767A6B75726C6651695A445A6C517041713645544B73426378574C434F6B71464F6C70586E2B4B676D796969456745534733326552574339704C636B6969645A574163344B34546F32526E35386367772B766E757879487A7A496A6863537A794A444B484C704D484A4F736A356647516268743972343838726E644476694C4178784B424C68496F667A780A48734E6E586A766942454944514A475A6839576B506D6F79366D796143546A5264314C54477054313574332B6D6A3244644C46576B716D67304471574E47616A4469785331654F2F674F456C504A48512B547843316970497243783142446147754A5439556976395A4836616F493931343464774774304D4B68512F52443347386C695A42494A6367796A302F693535613150564C59634F70723549464D5170724C4D4966794A69615A717969556A6134775770416C68484245455759366E5579675648426171624F356171346F3057704C566F62554330536542625449422F65574B484B4C61316E344A65314530564C68'
		||	'6D68695A6F42306F483879737256434E56566B75424A6B4D7A76636877744246364655302B594F31637456356778557845735746714A3251737963615A6F4F536B6B534B6150396D455659476C3564556B746A677075476B776B754A74693747545247546B70654C7A4E72774F4D795448316232383941626C7651434C784B55487244616535477A307A63704A2F736F6C314B494D5535344D71664966636D6D663576434A785132355344354B7165734D6E614B572F4F534878795036456B59444E7130704D494C32396769315770704879766A544D46714C6C6E4A673432483978557A553342576D756A324868636C495275585A6F2B6B384936624538667835445A35385464636B542B674C34616F3648556F76454A677736794D724B4665656C4547337A34316F4E2B36787462676132774D666F453044634E343739326E3147662F773239614E5A652B686C624567304375723632693541507A336B58457546397976412F50535A3177484A7768644F335046683869675969436F68422F454549756658776667647172765775534F71304C6D357150304C42666F7266574571587A624741666730475841752B5742616E654E7947694C47554C3144347179357448343730626D61536975625045412F53657859506A3631777245566955737462787833764D4E363953703734397A424853695831746F4D726939657853422B796A4B464E3773525352457A6F574778635449524E6B496B4F6967492F417541797A4965667268565174584743386A626C306357455438567A3542565456444C43623841534A6631424D466430576C4A616F6546323963777552724741706548535277427853673131776A4F4668484C6F66764E494C4B795A594F463045794E7A58435738734931774C766E323852794F6457436B526643586A5055573038784C5256554A452F5A5045685956656873354D714C436F4278616F587A6A7A6932422B586538304F6E6164745256647A63437166515A6B70506A5842694B2B6F6673484A2F537A75635536482B617665656A6F6B0A543575424C34786F5332746F346F6D74496C5363584F58352B2F3332723671646F2F3343754D396B394A51655564435942596E7372347938624D686D5A5556733870695346684A445A6B4D67612F534F35514D353647796E744E7053656F4D6265334A386D53424938543532474B4E387565732B4D525061734D6962675A53354B79316E324F555030577033714D717078534A7730705051595A7936366A5373737672744D556862354C692F5339797A41346A4D654E37683665734B7374754A726A5562564846616C566853534F63467936304A31654B7454786C726156723277716D747544457A4C444B6F57576F664C30'
		||	'506E6E554152676847587650657951787A2B6A6F587A48665979573968534B673857446442756978652F41424A4B7056677852546E4B7054734D4F6839686B75622F3579393956394871697A2B446F7354466B584354784D58464E366A6E4832514962506F49327272464D48354F6345435A2F6E776844497565706C594342754A4259714E6454464349465830434B376848554630667734335879714474524857674845686D6B587061412F6B50754A2B696C494B72324A6C61724552426C4A317464643478626D34695A7744334439436F4271634F7278516D4272704549734E4C5877614734493659376966693342524B45646338414E30726C3769674353734B6D4C78572F58444B7532694A73744871365736512F524334554C6A676F6C6E53554759706B6F525749665262696F5661586966516D43466A736B496E4E75306D31545835744936724C656834313336506848444A594D745537336A784F776646353169367654656B454D5273356F71684D716A39454C6A314F4939714C67676E2F753772776C564A6E6773506B5250756D776C686A382F4B2F5A4C6D454C5943467963666456642B4C4C6468466879792F66522F46677565527579674D7839494533675937636F486668676E32556A6F555836554E414937784253525667574571632B4E503576776D5746713176716D46367073596E47693041714532574A55354A4B5371627A6B6E6632433661565A61556A754C71643055717A5545435A4D676177516D6B4568314F4E6C4850617553665665716D446A30556A4B6F5A6C7575446C4A7978594B41764233574846555746704A516C377659794E784B50697075734249314E756A2B6263504A6C54324A79663278466B625158536B2F6753534A68594F4A67613372747A536B6362646759353236314F574D64397A4A6631506A7A696F72364F616F6B5A2F685062734F4C5154437045306D61312F787A6C374134485233394A347273686B454E4B706C49686A55645473533776633958384156312F6933322B794946346E7146633437746A0A454963463335413571316C46476B744C345655454F474B636653705A582B757A75624543596F6A77675356344E70737A74345A55685A437A514A6D635930584B79476C757A41786E7033394A642F726E624E6B66593457676B424B4C5258694C6B68366E636F54775A483547575656496B64444F742B6C336E754C53396D2B78336E385271644A6733456A6F4173565066594156462B54472B4C4D754468655876344859366B4C556D334F6278486D686E566973395846787155325036397979476C4969516A6F695071696F327278556B76696161424466687770506638502B39434A572B63756445343175785466506C30'
		||	'53714A43346C5974482F2B5355646A31676142766E6142314A387944556B7345564468527463544A5A314273767651635255337A41675869777769774133663837584E45424459663258443270412F70622B61744864315036414E614E5631715048324D424B487A73424B5549415936796F7052423436324C32576E43366B4B4A2B72626949317151474C35663054776D2B36575A6A4349614932396F444A7453693774796A625974594B675345554B684552646949786B76504C48557A31707177526B52724D78657671794D6B572B7661515057543961544E6F6959465333664C456B323656766A344B6E34576466343539614C5A795A742B4C525A626453486A597471787145327770572B4B4B556B53593376436A4C32474675746979767467306152715379596676547A7279493161683156666C2F68637A4A744E506343364E6B6B6F4C56772F4D767A783630506575483345494A563836636F4B542B7830412B7A6E504E49726E425355446C375A6E2F4A2F664F7357567A6345763370746A5639344D6F306F5549793438543457666A576D345042436358647365666D4449642F38775875737236357A646275483355315A3737534361625651474F5035337076332B4D767245323663566E527A7A365638693136656F5A4F7756677676656666676A4439342F594233626C766D337650345A73362F654D37787A453666515A6F452B462B354A764669596233334B5A4A70486D7244716B4E2B59717836742F633052586E4932657736646E34487836774A724575704863344C4E75776261442B6E7859524D6C6A6A314E41667A41643862616E6F6158686834646E4A4257386C6F5A534B69367A736F4B646865613346687334334B50474C714D545048664761786C5143746D696F514B5369416F334C4D42386658385A4E7630546576304F4F4930673943545331417942424662654D696C44714C6F3055723332467438426D3256722F4B6576386C386E51726C714A75715A373736634F427A5972736C376F687A6D644E4C362B76443570795372480A556E586A78496574676A33687754562B435A614B6A7651416E665451764663315577734E697472567363726E596B52597647742B332B4241753442736366626C51726D6476766A473144646C66396376473966396337795566674A647130383746787230594443382B3539497252426A554C3364773964784E50437967496339586C4A45354A7571464D69367538734675455256315A43483873595A667A77667A784E635362676B6B5858775753585478393659523139614D73415854646947346233617079417230305157554B5078383442614A4D4A732F4A30395A3748514C36424D6848776F47716B4E377849636454'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6C6E456C6B5A4E307A6E5234324C4C456D4A355A59776C6B6C692B797636425677306462484E504E534761766F4857367A6C666B2F385554512F634F61682B6B6635417641714C582B4B626D4238526A596539554A54576376746B7A422F39364235745A646E6536374C5A7A39425342774778454B434368474A2F4E4F5037743464383537314470764D4F4C317A6F6F6278622F45595243307A424F57746749785233786E4E2B75442F69523764502B645731646459366D6A774C633669675078575554764C797A534776376339424B5A362F304362506B6E672F47424343575358343447544B33397934783036327A754845384E623945652F653956786362644E506B736151323958536E58724E2B5A53312F796666734A52727348734C704A314C3948314A6233714432663068797036466932516C71616877306A45586B4E75534E5865646E4446746359654D582B4A6438336D756A78376E4435326C38494C5072776F757453556437304B374C734F446F684473394457506261643075704A694B484554714759436278546579686A56362F45695A57773839796133755858344A33544C627A48674E6C706F7A727841696544394A534B447A6F67433454324A6C3668736C37582B5A396E622B4170376D2F384E316A6973647847445830416D336F74506F624836536343434339697577663657566847785A426C6C6C6A566A59676D5161546F7133385368654C6E6B65533338306E693844736F4C6B474D45694549454F59734276525579526C2F4768397776775764436E6F4D67367A2B69366270694265684E454F2F5764444B78624E776C4772697A30666E4552645575562B4F524669336A78753667575953635037384A3174386E344E784376627A6D43733953317858736C5234576742642B4B57433737686145625459514554645334614B396C56784170733453444877584D2B77495670345079617833753056367547365737674468326B68536B67304E784E55366E4E68424E373647714161536933794B3042484B4265784868445A564A440A3473384561374A4A50523149455866496F7458764A67696D2F346C2F70655863776931596332752B615057397A6E77546E697647436E4C754A6344526A377053496F586D6356626473657444685976726857504241786447374F4B68627A59656652537354726238496C63524A72436B3748513137373441362F2F6449566675557A47337A6C715255534963465834587A7146473074622B3266384D4E62422F545441754737776244624F5A525769794931704834476C35446F6C4734513749384B6267376E4450494F762F7A59674338397459724F564E426B75796E674B46334B2B32634670533934635866412F2F494C'
		||	'462B4D34704172686F627246734A546348686D4730776E2F2B71584865666C6778467448493437506F437744367A5A5571785A586B2B53577665772B686635482F6337762F4D3776664C4A7674664742467A474554534A46527170586D5664334D5A79427235426C306B52615941574F4E6B36306B4D4C51346F42562F79344476343855493236626E494E4B632B6F3057734E47477454524D727061432B64524747617A4F5466766E334634783646317770554C4C6237367A417174504C433250594B5A716268332B6A3737683939696450784E3176304A4C644843697747566447686167543058633747386B71533652792B397774623256396A622F42565742353948365177685A54536A444173633954683365644839715230685A4A4A36385A47424975706C374878454341303049767837346B49596F4B715A6E7246576C704570574C75326933704F524D53366652307A76776878614C716D5767416F516F586F764D5636307768435A56796D3673462B4A567A63573565304F66453931774D786A346C75356B7572636C30722B34554C79324A667467697170704A55684371336E7639492F474C46695475466A4F64416954417A5657454C6A6F68524A4459415676686D5A75706A46706F584E7241653433753345574D5434704D7933714A704C43374D51374659345A743334464578766B46452B446C654A782B2B716F564453644F77514F4F714852327741334D3058446D4651595855335A716B456664614A79564F3647413648542F39676D386846713478534577557A6973526B73515664625A59574E5A6C513061704230454248765778617775466757326958615233437A4C4E4A7A786E6F5874784335697976672B396A786F66693349573555786774784A6D714D7135706843526E4C2F5077796979784873545A347175715A2B697A6A6C6344652F514D55394E43723955304868774275464E3038454571596B506B4B6D584B42386951476F53535031382B546854394A455A4C59574D74316B4A4B6B4871424F4D6C5A34586C672B4555690A32427674554D76313746494445587A64467279703638663863622B6942663332685457737448585846687630553269645259434753754C6F48397953462F69484C782B5A386A4C4E345A636E306936375A524F4B6C6E50425233707739785A4A6F44454F4D32395963584257556B7253396C73436270706943796143633368714F4B2F3344726A2F337633684A4D547739325A5A324F6C79363963336554536570644F5A484D6137304E334A56516F4469524C39376A38435856594D534E483170456554704C4B446F5075553278756652313337446B622F6841687A796A7841525969515567647335704B556D5A3037426B'
		||	'5A45334A7853457665345854364C44663846627A5A6F566A645962656C324D3438477A6F73494A6E5358466A703875576E4C764C6D363239542B6F727833444D33466873665747744C54695A7663762F6B50314D4D763831572B5146356B6F4A6F42534B7445494768354679492F39594A2F6677532F645A565672725073623779417233326B32544A57754E4F6637355345783844582F31552B71767A654633447468464C7335354943312B71486A39794B4C6C6334486761614D702F564756596477444C675A6C4C5855646A5A686B48506A494F366D746D6C49536C6275724466496D366E2F4E4C5653704C6C656F432B6C7173647A5A43646D4C7076664967674C5245625263667572496646736D4C706D4878693838707A74384A66766D63504D51516548476C496933425236686F36627949706A305744555265512F47315154504C6A4C6B6C4E70696F48332B2F6641627247636F69773067306A4D776C7548734A4B7659314F3635686376706C476544534A683166542F676C67453030505A3538674A7279365772715266667A3447323775416558723539596776476245752B4264484B35364A444534703456597247354C35696A532F65737234737432644444362B745856784643754B5631596E464F6E5775477158474F46595845516D466B67734B534B4D58463151372F343073582B4E332F6449745862342B354D726A50336F75625A476B617645754E34667533542F6E52335445484538666565737164795954396B575579423939526A584F665169376759792F77586A4B76504D50435934586B433373356C395A7A42726B69387A596B4E517546464A434C69706375397268394E4F463748357A772B363863386551675A36326442686369615469626C59786D4663494C4A6C62797A4771487A312F753866526D6C3034537A53446976533662597438314C4D785067315A393467334C7578414D494A566271436E52794C545035766F765554704455597778356E576D626F62336B456F6466506C384551625661424A764750674475754B510A4B2F6F4E336A557663755073733777316659356849626736364843744C306E62416931536C4653733954552F2F33544F76392B357A76576A69744D3554457377546D42737857782B774F48775735774D2F785133666F4D7444324D30466F5048684A776D6156412B4956487269453666376434585765392F69653771352B676D5730685230316C56364B704568412F45456B33632F7977676775654E645A7347596D6C39466E495A48354E4C333774454B6D42427052586E7175766150584A7042755358494B326C7239654C7034787535457537586569615246686D306F5939746143712B32563063476B4E647376766457'
		||	'6E655543394D49685955515A65566E4B7650506D53594C647943536E3975455A474E5053744C47354F494C4C4846577265593370324443442B56466F4747354343624753496673626E3679457156775130674C6E4C65417A5A6F72635453434C4B65676451686B51444B4C345930506D5950794E6F5761526D7938693653424878444D434553326254777A55595558416C6B382F646C747866766C7A715070566D6338416F705649535346346134556A7A452B5975515A4131442B36573974655A534E4F65694870314A6361344B3835346C694C512B4A3372424C68546E30505477765575667A79315430474D683445586F564A75764E5459655558636F6D6C6350586241503530333447746D5144616A6F684B525347644C4D4D63366A704F4B5A6E543639566F75626832653865754F5158333669513937794A46726A6A4F4850336A76693972684570536C446F37677A68654F705A7A627A444F65656B54566B57724C5A43533433337363356F6B38594659366A5766434A2F4E4A75776F7537625336765A755465636E6469535357307453585842594D30596275763056727933666448484833524D5A7736707361774E7843635465624D6934716474754B355336743837616B427A32796C53472B5A465258654335496B3341634C4772384E3978437949652F385244617349446F4C71624579506874427869466F79785832426C38674535703973553478656F57795041785738714B2B72416D6C45336A5A516969445934357A6831787833324F4E447A6879503242342F466463487A2F4779636B5433426F38787056427A6C354C3063306B503338783552656566594C68612F65355731726D4D674D386B386D3733447A34553462332F6B386F443545534A714C6633464465653579524B4E306A622B2B79326E75537462567272485375305534766F39514B557037503835464E746F673852352F364752686666576A42464F4A44552B72467349514832584D50394267666753504C422B676C487858744A5A7146527A7A413456312B44334B702B767A0A774B69556534493938464C486B5844663277473468502F7A625032496C6C4975787650696F632F45525079543455447A4D5237372B513974467967656F65412B2B78744C4A453357582F4D443371672B522B683567506E375558325544615A326649386B6F2F46496665682F7948504F6A726E6E697A38727A51612B695A6B737533543850336939534C476769443350616C6865306A33726463382B7350432F765744416B363376466E373872784D663032512F634A30305A304777306933767677314F7A6A346A4D454855684A4D2B505A46314947554149636A7843536A34344B766A3265324E2B2F3956446A735A5450'
		||	'727554382B4C6A4B2F7A352B79566E38314E3265696C5072665634382B36454C317761384F4B4646536F7A35335273794B586A7876454A72397A7833426F35727535322B57382F75305A75687A6A5A77636F32526B4470444A5078684F75336A2F6E395563365A7A65435A6452356654666E3937392B673157727A354562476C61376E6D362F6334667533783477642F504B7A6177684B76765857694C655044662F366C7934786E42306A4B666E63547076662B73496D543679302B6544676A4E39392B583165764C7A4E35792B7338635236433630444E4F77514D5970474C766C4C2F7352596772566C666C32707577612F566B4C527A72615267382B685A4973383035794F336D49365036537154734E4D4B4C4A314B752B69656A64446B4A425373735A64326D374369727648784C364A4D647663712F596F5A33756364546259617132786B6735343666454A7036566758446A732B43346E376C326D73372F6D377646334D504E39764D7951716F324A44736470326958504E6D686C4F37547969335462562B69317239444F64386A53645A546F78446A776A33766766305A3271452B376D33334B62785A2F3331386A506E34422F665276576679442F647A50396F58355737773978616437335938484D502B32646B64384C4548313033784B38593935577A39597148337376333236562F6F3054343534734467524B6A4A6449354C674956556832666E795770766E64747138654C484E5A3365375844383264424C50656C7652797756666558715861357474726D336C544779627357757A6D6E6B7572416A55615945566D745632457275356D4441674942475358695A3537734B415552486D736473724F61314D495A56676F39756933636F5A7444524A59756A334F317A314364316338394A6A712B7A3248495770324C55614C6544434E72307251414141434B684A52454655616F63765051364A734479326C6A4E496F5A73724E6C6348444C7074386B796A6C4669554337454A6B47496835482F6F4B2F744A7651544268346746482F4A54684C0A4352315157434E46624B4663614E4F42722B46343648502B626B374633476B2F6578666F5433525979344D486758547151554B564B4D5562344B4F3743485169676D496D55714F6A6935546A652F7946726E41707539433569797A7A754861787850562F6A6C693572552F78576A346D574F5A6D2B6A625947544178413571613851716B57377455572F6534564237326B362B57506B3253364A57715657735155664F52634946754B66344F6230364868305044722B615236315432564E497647576B376E6C3774687759326A6F5A596F4C4B796C625863326473784A6E484333743657534367794A6E493466567A464E4B'
		||	'7A6232524A78474F6C716F3447383859473032336E624533534E432B444C6C6A30586935737034625A345937707956464D576439706331655036476E50652F664E2B5270536A39334A4B7267746147694C4432726D65544A725261716D6E45344C5269586E7166582B7879564D4B73637562514D4F696D704D4A7A4F4447384D505675646E4D32326F702B474F4A6E417567777A367472384B58547844786377386841626C6F3044325A705A5A50425551565472556D536B304959636D494B795047453076633768366373636E2F32413065776469766C786946416E30454F4E72564461593732686368564F57464B705349556D6352706253707A5049576D527467646357486D656450416C64506435647449573557696675546C684A7159344F3246614643676B3635302B615861524A426D676451756C576F454149684B384431454B745A376B30543731364868305044702B4B6E76574F62546159323174776D79446355493070793549554334454956707655434A447938445374434C42322B4470456F77354B7278496D67354F4B52394678426163785573562F444B7478396B536B615252716D43774A4A46564764494D527A35424F30654749304545426A49574A7A7935544B6C51654F7552336C4E706852596C306A734B6C354549455A6D5159564E61486732725A6A2F684A37316845626F54547850355544735A694A704D624D4F38776273533430365A6C2F65597A4738786D64356B4E4C334E764C7A4C764C78485564316E587032512B51773847417847577154514A4C4A464A67616B63703157746B75377530756E7538306776597A4F4C794F7A54564B6C6F4A706954456E70505569446453585365396F36522B6F42557154525A797A536538575330616677306473743646582B53634A2F6A3435487836506A6E32364C31667874535A7A75677A69684A7238344A78424B52353178434D66556A7168564452464D516C534E526B3347354E69514B526A7331494B4E6C413132597A4C49476F4A636F4D434C744E46724964584358314B49450A475476792B44775954516B456973444C3046344859675448727A7A57435877497367586C413873534265643268463677654673474C68787050535432724343626946735450694666453755796A796951362B6C63543450576947506333504B3870544A3742376A3251644D6968764D717A7355315242744D315349496356673845496A5A427574566D696C4F2F5461462B6C31392B6932743547324379494C336C33536F34554243395971304547494A33456F4637513876684646637136624376393377656F5234716672442F6A6F654851384F7635724F797A6E70514231782B576A4E554F49342F45754F503473574A6E'
		||	'424973724A494F4C5846727861376C62454F656D346A50724B6D6848715A62497747426356777357435069613865312B4C544753306C6171436374306D6B43696363466A684555366A6859736153516E5359534F444B6E4757454C4162425074437149595A4B317A6B596F7061492F5A77544D46507647465A577846636A6E586A36743945354567584C30424E536B35777A7366574E6E4C775264694A6E51756444544A73646F5550624B6745676D6C715A4A55354B6242524A6138515341643269614655345642554B43385250734634496E305845694743304C4F684C4A38333758474F633871646E785848705566486F2B50523856394A64315562476B62724B754C71576639705669767645635A532B304437364E396F4937745747302B6C6452526D4F35784B5168774D775A564545544C6E6645334A693061394E5863375249494155675A5764794F4E414A7A42786F3152555650374179516F585949515266524B546C452B6B443141783852335278312B492B75564E6E69364E5535476E3262702F655478496C4C46446142614576744569714A6255745648362F31416A3632646B674E30474B786C367367776A2F4D5671556871662F306F4E6F3747743347544373344349574B3556714837614779714974776E3843675A54566B525157666835626B62704D3757435A687862664B7A4847502B714D4E36644477364868332F534675576A2B49525159546E58435079397A4869524D5A5154612F307775704A426835423035637045784C445250784A4830723532746B46373742524F36594643462F463055684956773857594946454A357876596D6D38743947645254524A41744B4A4A6A4B6D336E2B575A58677975734334706559672F4D3875446578383835716635766A6B4F6977685978646C6F7A684F4E2B3363636B7865694933776A64713831693473363835464C5952734173326971334E4D474B76312B434936485474637641412B6D69654B45414F416970436B6A79614C74557A55496A357945317079453269694C5234524C7834640A6A343548787A2F327362772B31556249496867594E4B7456574175646A4A45763954707058614F48713933485049766D51417135684379357870637A304F6474517A5033586B5A50786A714A496236584B446866307458486950755947535A386A4D525243346D6B5747514D4F2F47676C4B4B4A724635494E6A2B6437636E447859744148584958585343616949596C794D3052766463574E71696834306E774E7351394233573451704575425039654E4934437A5764526F5774534E66346F513171515143396C4A55586968334F4E736A35347869666E62346A6D3741544A587A31626449346D4D767252386568346444'
		||	'773666764B4869466C6F4247544A4332702F425148526C5A386F76576B435652727A5A6D63716C4E596F485A6F455A36492F587A5433566F324A63796A3031584C4434476F4C715541334E30316B6A317379306D36366C502B2F76547661625269456F54423844466E662F33453370594664324941544B564B315365334E2F3131506264634C58414D356C7070666C4F677A697A704371453036744B6C304C794A2B4E7261324E47765038566C3174574836583846362F5A62676D4C7330346D35366B626F762F46596953626758395661397345535936457058574E456D467248396B53327A76707A346D78587A4572644B5A6F704F544D7371556D336636765A514D2F384D57787662666D4F79617A79596C3759437879544E38637A566643764F73414338645539774265336E534B36384B4457546A70694E5A7462386D4B4D5864663349346D6A462B7536587A6D652B5A696F5759794C3043435275665352397866767432765749734C664451342B6A616E364E434C53786574705435664275715A637144316E79564B43746D565262704E564C52632B346E47647A424A4450525A7433744E2F515963315872376C5431506E57776A556F394E7A686D4E6B356F505132444F475367544E723368704774747263484152362B5377337235352F51414441423575744649676F585266586B7262563575772F713335645042346E71724D625334484170335850356A7935464934717161355A64584875645A344A6C775A366A6B626A4F6E45744A5747744F5852334D57476E662B3576583966727A3245424150413562495942414368594141425173414141464377414143685941414251734141414643774141436859414142517341414146437741414E376A4636624C6E53384E2F736F4E4141414141456C46546B5375516D43433C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A20203C2F456D626564646564496D616765733E0D0A20203C5061676557696474683E3231636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D22444154415F494E464F524D4143494F4E223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224E4F4D5F454D5052455341223E0D0A202020202020202020203C446174614669656C643E4E4F4D5F454D50524553413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22'
		||	'434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444952454343494F4E223E0D0A202020202020202020203C446174614669656C643E444952454343494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D554E49434950494F223E0D0A202020202020202020203C446174614669656C643E4D554E49434950494F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D4252455F434C49454E5445223E0D0A202020202020202020203C446174614669656C643E4E4F4D4252455F434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224150454C4C49444F5F434C49454E5445223E0D0A202020202020202020203C446174614669656C643E4150454C4C49444F5F434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D5F534F4C49434954414E5445223E0D0A202020202020202020203C446174614669656C643E4E4F4D5F534F4C49434954414E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444F435F534F4C49434954414E5445223E0D0A202020202020202020203C446174614669656C643E444F435F534F4C49434954414E54453C2F446174614669656C643E0D0A202020202020202020'
		||	'203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D554E49434950494F5F4649524D41223E0D0A202020202020202020203C446174614669656C643E4D554E49434950494F5F4649524D413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224645434841223E0D0A202020202020202020203C446174614669656C643E46454348413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444941223E0D0A202020202020202020203C446174614669656C643E4449413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D4553223E0D0A202020202020202020203C446174614669656C643E4D45533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22414E4F223E0D0A202020202020202020203C446174614669656C643E414E4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D554E49434950494F5F4154454E43494F4E223E0D0A202020202020202020203C446174614669656C643E4D554E49434950494F5F4154454E43494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461'
		||	'536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E444154415F494E464F524D4143494F4E3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22444154415F5041474F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D2246454348415245434155444F223E0D0A202020202020202020203C446174614669656C643E46454348415245434155444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525245434155444F223E0D0A202020202020202020203C446174614669656C643E56414C4F525245434155444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543484141504C49434143494F4E5245434155444F223E0D0A202020202020202020203C446174614669656C643E464543484141504C49434143494F4E5245434155444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22454E544944414452454341554441444F5241223E0D0A202020202020202020203C446174614669656C643E454E544944414452454341554441444F52413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C46'
		||	'69656C64204E616D653D224944434F4E434550544F223E0D0A202020202020202020203C446174614669656C643E4944434F4E434550544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C444F414E544552494F52223E0D0A202020202020202020203C446174614669656C643E53414C444F414E544552494F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225041474F41504C494341444F223E0D0A202020202020202020203C446174614669656C643E5041474F41504C494341444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224355454E5441434F42524F223E0D0A202020202020202020203C446174614669656C643E4355454E5441434F42524F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2253414C444F223E0D0A202020202020202020203C446174614669656C643E53414C444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224C49515549444143494F4E223E0D0A202020202020202020203C446174614669656C643E4C49515549444143494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E64'
		||	'54657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E444154415F5041474F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22444154415F464543484153223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224645434841494E49223E0D0A202020202020202020203C446174614669656C643E4645434841494E493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543484146494E223E0D0A202020202020202020203C446174614669656C643E464543484146494E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D4553494E49223E0D0A202020202020202020203C446174614669656C643E4D4553494E493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22414E4F494E49223E0D0A202020202020202020203C446174614669656C643E414E4F494E493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D455346494E223E0D0A202020202020202020203C446174614669656C643E4D455346494E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020'
		||	'202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22414E4F46494E223E0D0A202020202020202020203C446174614669656C643E414E4F46494E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E444154415F4645434841533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D22444554414C4C455F5041474F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D225449504F50524F445543544F223E0D0A202020202020202020203C446174614669656C643E5449504F50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543484147454E464143223E0D0A202020202020202020203C446174614669656C643E464543484147454E4641433C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22544F54414C46414354223E0D0A202020202020202020203C446174614669656C643E544F54414C464143543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A202020'
		||	'20202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2246454348415245434155444F223E0D0A202020202020202020203C446174614669656C643E46454348415245434155444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224355454E5441434F42524F5041474F223E0D0A202020202020202020203C446174614669656C643E4355454E5441434F42524F5041474F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F525245434155444F223E0D0A202020202020202020203C446174614669656C643E56414C4F525245434155444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22464543484141504C49434143494F4E5245434155444F223E0D0A202020202020202020203C446174614669656C643E464543484141504C49434143494F4E5245434155444F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22454E544944414452454341554441444F5241223E0D0A202020202020202020203C446174614669656C643E454E544944414452454341554441444F52413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A20'
		||	'20202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E444554414C4C455F5041474F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2241504C49434143494F4E5F5041474F53223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D224E554D4F4E5448223E0D0A202020202020202020203C446174614669656C643E4E554D4F4E54483C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225342434F4E4344455343223E0D0A202020202020202020203C446174614669656C643E5342434F4E43444553433C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E555052455642414C414E4345223E0D0A202020202020202020203C446174614669656C643E4E555052455642414C414E43453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E555041594150504C49223E0D0A202020202020202020203C446174614669656C643E4E555041594150504C493C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E554143434F554E54223E0D0A202020202020202020203C446174614669656C643E4E554143434F554E543C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D65'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'3D224E554150504C4942414C414E4345223E0D0A202020202020202020203C446174614669656C643E4E554150504C4942414C414E43453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2242494C4C4C49515549444154494F4E223E0D0A202020202020202020203C446174614669656C643E42494C4C4C49515549444154494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22534250524F4444455343223E0D0A202020202020202020203C446174614669656C643E534250524F44444553433C2F446174614669656C643E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44433C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E41504C49434143494F4E5F5041474F533C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F6465202F3E0D0A20203C57696474683E3136636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E30636D3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C496D616765204E616D653D22696D61676532223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E4F4D5F454D50524553412E56616C75652C2022444154415F494E464F524D4143494F4E2229204C696B6520222A4546494741532A222C46616C73652C54727565293C2F4869'
		||	'6464656E3E0D0A20202020202020203C2F5669736962696C6974793E0D0A20202020202020203C57696474683E352E3235636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020203C4865696768743E312E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6C6F676F5F6566696761733C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78333C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E312E35636D3C2F546F703E0D0A20202020202020203C57696474683E31352E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C7565202F3E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E444554414C4C455F5041474F533C2F446174615365744E616D653E0D0A20202020202020203C546F703E372E35636D3C2F546F703E0D0A20202020202020203C5461626C6547726F7570733E0D0A202020202020202020203C5461626C6547726F75703E0D0A2020202020202020202020203C47726F7570696E67204E616D653D227461626C65315F47726F757031223E0D0A20202020202020202020202020203C47726F757045787072'
		||	'657373696F6E733E0D0A202020202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C64732146454348415245434155444F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A2020202020202020202020203C2F47726F7570696E673E0D0A2020202020202020202020203C4865616465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78353C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20'
		||	'202020202020202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78363C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020'
		||	'20202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78373C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32'
		||	'343C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78383C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A2020202020'
		||	'2020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783130223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831303C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A2020202020202020202020202020202020202020'
		||	'2020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831313C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E'
		||	'747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831323C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E'
		||	'0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E3235636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F4865616465723E0D0A2020202020202020202020203C466F6F7465723E0D0A20202020202020202020202020203C5461626C65526F77733E0D0A202020202020202020202020202020203C5461626C65526F773E0D0A2020202020202020202020202020202020203C5461626C6543656C6C733E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831333C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E675269676874'
		||	'3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831343C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020'
		||	'202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831363C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020'
		||	'202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831373C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020'
		||	'202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C7565202F3E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C436F6C5370616E3E323C2F436F6C5370616E3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783138223E0D0A20202020202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831383C2F72643A44656661756C744E616D653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A2020202020202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A'
		||	'202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D22546F74616C2050616761646F223C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020202020202020202020203C5265706F72744974656D733E0D0A2020202020202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A20202020202020202020202020202020202020202020202020203C546F67676C65496D6167653E0D0A202020202020202020202020202020202020202020202020202020203C496E697469616C53746174653E747275653C2F496E697469616C53746174653E0D0A20202020202020202020202020202020202020202020202020203C2F546F67676C65496D6167653E0D0A20202020202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020'
		||	'20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A202020202020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020202020202020203C4C6566743E302E3570743C2F4C6566743E0D0A202020202020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A202020202020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A20202020202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020202020202020202020202020203C56616C75653E3D222420222B466F726D61744E756D6265722853756D2843646563284669656C64732156414C4F525245434155444F2E56616C756529292C32293C2F56616C75653E0D0A2020202020202020202020202020202020202020202020203C2F54657874626F783E0D0A202020202020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C2F5461626C6543656C6C733E0D0A2020202020202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A202020202020202020202020202020203C2F5461626C65526F773E0D0A20202020202020202020202020203C2F5461626C65526F77733E0D0A2020202020202020202020203C2F466F6F7465723E0D0A202020202020202020203C2F5461626C6547726F75703E0D0A20202020202020203C2F5461626C6547726F7570733E0D'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'0A20202020202020203C57696474683E31352E34353337636D3C2F57696474683E0D0A20202020202020203C44657461696C733E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2246454348415245434155444F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E46454348415245434155444F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C486964654475706C6963617465733E444554414C4C455F5041474F533C2F486964654475706C6963617465733E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E3170743C2F4C6566743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020203C2F5374796C'
		||	'653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C55736572536F72743E0D0A2020202020202020202020202020202020202020202020203C536F727445787072657373696F6E3E3D4669656C64732146454348415245434155444F2E56616C75653C2F536F727445787072657373696F6E3E0D0A202020202020202020202020202020202020202020203C2F55736572536F72743E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C64732146454348415245434155444F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22464543484141504C49434143494F4E5245434155444F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E464543484141504C49434143494F4E5245434155444F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020'
		||	'202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321464543484141504C49434143494F4E5245434155444F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22454E544944414452454341554441444F5241223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E454E544944414452454341554441444F52413C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A20202020202020202020202020'
		||	'20202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321454E544944414452454341554441444F52412E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020202020202020202020'
		||	'2020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473214355454E5441434F42524F5041474F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D225449504F50524F445543544F223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C'
		||	'54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C6473215449504F50524F445543544F2E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22464543484147454E464143223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E4E6F6E653C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C5061646469'
		||	'6E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669656C647321464543484147454E4641432E56616C75653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22544F54414C46414354223E0D0A202020202020202020202020202020202020202020203C546F67676C65496D6167653E0D0A2020202020202020202020202020202020202020202020203C496E697469616C53746174653E747275653C2F496E697469616C53746174653E0D0A202020202020202020202020202020202020202020203C2F546F67676C65496D6167653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E4E6F6E653C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E3170743C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020'
		||	'202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D222420222B466F726D61744E756D62657228494966284C656E284669656C64732156414C4F525245434155444F2E56616C7565292667743B302C204669656C64732156414C4F525245434155444F2E56616C75652C2030292C32293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A202020202020202020203C47726F7570696E67204E616D653D227461626C65315F44657461696C735F47726F7570223E0D0A2020202020202020202020203C47726F757045787072657373696F6E733E0D0A20202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C64732146454348415245434155444F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C64732156414C4F525245434155444F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C647321464543484141504C49434143494F4E5245434155444F2E56616C75653C2F47726F757045787072657373696F6E3E0D0A20202020202020202020202020203C47726F757045787072657373696F6E3E3D4669656C647321464543484147454E4641432E56616C75653C2F47726F757045787072657373696F6E3E0D0A2020202020202020202020203C2F47726F757045787072657373696F6E733E0D0A202020'
		||	'202020202020203C2F47726F7570696E673E0D0A20202020202020203C2F44657461696C733E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A202020202020202020203C426F7264657257696474683E0D0A2020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A202020202020202020203C2F426F7264657257696474683E0D0A202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2263656C6C466563726567223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C'
		||	'5A496E6465783E33333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D2246656368612064656C207061676F223C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2263656C6C46656361706C223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D2246656368612064652061706C6963616369C3B36E2064656C207061676F223C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F546578'
		||	'74626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2263656C6C456E7469646164223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D22456E74696461642052656361756461646F7261223C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C546578'
		||	'74626F78204E616D653D2263656C6C4375656E636F6272223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D224375656E746120646520436F62726F2061206C61207175652041706C6963C3B320656C205061676F223C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2263656C6C546970726F223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C'
		||	'2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D225469706F2064652050726F647563746F223C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2263656C6C46616366656765223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A202020202020202020202020202020202020'
		||	'2020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D2246656368612064652047656E6572616369C3B36E206465206C612046616374757261223C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2263656C6C546F74616C223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3770743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020202020202020202020'
		||	'2020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D2256616C6F722050616761646F223C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3930343736636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E33636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3735636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3739383934636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C'
		||	'65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E33636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E322E3034393832636D3C2F4865696768743E0D0A20202020202020203C466F6F7465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5669736962696C6974793E0D0A202020202020202020202020202020203C48696464656E3E747275653C2F48696464656E3E0D0A20202020202020202020202020203C2F5669736962696C6974793E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783234223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		9263, 
		hextoraw
		(
			'726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A20202020202020'
		||	'2020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F5061646469'
		||	'6E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783332223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E64'
		||	'65783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264657257696474683E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F7264657257696474683E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F546162'
		||	'6C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3239393832636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F466F6F7465723E0D0A2020202020203C2F5461626C653E0D0A2020202020203C54657874626F78204E616D653D224D554E49434950494F5F4649524D41223E0D0A20202020202020203C72643A44656661756C744E616D653E4D554E49434950494F5F4649524D413C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31332E35636D3C2F546F703E0D0A20202020202020203C57696474683E31302E3937333534636D'
		||	'3C2F57696474683E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22446570617274616D656E746F206465204174656E6369C3B36E2061205573756172696F73223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22747874436F726469616C223E0D0A20202020202020203C546F703E31322E3735636D3C2F546F703E0D0A20202020202020203C57696474683E332E35636D3C2F57696474683E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22436F726469616C6D656E74652C223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22747874496E666F536F6C69636974616E7465223E0D0A20202020202020203C546F703E392E3735636D3C2F546F703E0D0A20202020202020203C57696474683E31352E3735636D3C2F57696474683E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4865696768743E322E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22456C2070726573656E746520646F63756D656E746F2073652065787069646520656E206C612063697564616420646520222B4669727374284669656C6473214D554E49434950494F5F4154454E43494F4E2E56616C75652C2022444154415F494E464F524D4143494F4E22292B2220656C2064C3AD6120222B4669727374284669656C6473214449412E56616C75652C2022444154415F494E464F524D4143494F4E22292B222064656C206D657320222B4669727374284669656C6473214D45532E56616C75652C2022444154415F494E464F524D4143494F4E22292B222064656C20222B4669727374284669656C647321414E4F2E56616C75652C2022444154415F494E464F524D4143494F4E22292B22206120736F6C69636974756420646520222B4669727374284669656C6473214E4F4D5F534F4C49434954414E54452E56616C75652C2022444154415F494E464F524D4143494F4E22292B222C20717569656E20'
		||	'7365206964656E74696669636120636F6E20656C20646F63756D656E746F204E6F2E222B4669727374284669656C647321444F435F534F4C49434954414E54452E56616C75652C2022444154415F494E464F524D4143494F4E22292B222E223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22747874446574706167223E0D0A20202020202020203C546F703E362E3735636D3C2F546F703E0D0A20202020202020203C57696474683E372E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22446574616C6C65206465205061676F73223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22747874546974756C6F223E0D0A20202020202020203C546F703E322E3235636D3C2F546F703E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E313470743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3032363436636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3734303734636D3C2F4865696768743E0D0A20202020202020203C56616C75653E434F4E5354414E434941204445205041474F533C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22444952454343494F4E223E0D0A20202020202020203C72643A44656661756C744E616D653E444952454343494F4E3C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E39322E383570743C2F546F703E0D0A20202020202020203C57696474683E3434352E3033323570743C2F57696474683E0D0A20'
		||	'202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E312E343870743C2F4C6566743E0D0A20202020202020203C4865696768743E39312E34323570743C2F4865696768743E0D0A20202020202020203C56616C75653E3D204669727374284669656C6473214E4F4D5F454D50524553412E56616C75652C2022444154415F494E464F524D4143494F4E22292B22206861636520636F6E737461722071756520656C20736572766963696F207562696361646F20656E206C612064697265636369C3B36E2022202B4669727374284669656C647321444952454343494F4E2E56616C75652C2022444154415F494E464F524D4143494F4E22292B2022206465206C61206C6F63616C6964616420222B204669727374284669656C6473214D554E49434950494F2E56616C75652C2022444154415F494E464F524D4143494F4E22292B2220636F6E20656C20636F6E747261746F204E6F2E20222B4669727374284669656C647321434F4E545241544F2E56616C75652C2022444154415F494E464F524D4143494F4E22292B222061206E6F6D62726520646520222B4669727374284669656C6473214E4F4D4252455F434C49454E54452E56616C75652C2022444154415F494E464F524D4143494F4E22292B2220222B4669727374284669656C6473214150454C4C49444F5F434C49454E54452E56616C75652C2022444154415F494E464F524D4143494F4E22292B222070726573656E746120656C207369677569656E74652068697374C3B37269636F206465207061676F7320656E20656C20706572C3AD6F646F20636F6D7072656E6469646F20656E747265206C61732066656368617320222B4669727374284669656C6473214645434841494E492E56616C75652C2022444154415F46454348415322292B22206120222B4669727374284669656C647321464543484146494E2E56616C75652C2022444154415F46454348415322292B222E223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C496D616765204E616D653D22696D61676531223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C5669736962696C6974793E0D0A202020202020202020203C48696464656E3E3D494946284669727374284669656C6473214E4F4D5F454D50524553412E56616C75652C2022444154415F494E464F524D4143494F4E2229204C696B6520222A4546494741532A222C547275652C46616C7365293C2F48696464656E3E0D0A20202020202020203C2F5669'
		||	'736962696C6974793E0D0A20202020202020203C57696474683E352E3235636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E6C6F676F3C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E31342E3235636D3C2F4865696768743E0D0A202020203C5374796C653E0D0A2020202020203C426F7264657257696474683E0D0A20202020202020203C44656661756C743E302E3570743C2F44656661756C743E0D0A2020202020203C2F426F7264657257696474683E0D0A202020203C2F5374796C653E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E656E2D55533C2F4C616E67756167653E0D0A20203C50616765466F6F7465723E0D0A202020203C5072696E744F6E4669727374506167653E747275653C2F5072696E744F6E4669727374506167653E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78393C2F72643A44656661756C744E616D653E0D0A20202020202020203C57696474683E352E3238393638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C54657874416C69676E3E52696768743C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E35636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D2022506167696E612022202B20476C6F62616C7321506167654E756D6265722E54'
		||	'6F537472696E672829202B20222064652022202B20476C6F62616C7321546F74616C50616765732E546F537472696E6728293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A202020203C5072696E744F6E4C617374506167653E747275653C2F5072696E744F6E4C617374506167653E0D0A20203C2F50616765466F6F7465723E0D0A20203C546F704D617267696E3E322E35636D3C2F546F704D617267696E3E0D0A20203C506167654865696768743E3237636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_27.cuPlantilla( 2 );
	fetch CONFEXME_27.cuPlantilla into nuIdPlantill;
	close CONFEXME_27.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'PLANTILLA CONSTANCIA PAGOS',
		       plannomb = 'LDC_CONSTANCIA_PAGOS',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 2;
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
			2,
			blContent ,
			'PLANTILLA CONSTANCIA PAGOS',
			'LDC_CONSTANCIA_PAGOS',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_27.cuExtractAndMix( 27 );
	fetch CONFEXME_27.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_27.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_CONSTANCIA_PAGOS',
		       coeminic = NULL,
		       coempada = '<23>',
		       coempadi = 'LDC_CONSTANCIA_PAGOS',
		       coempame = NULL,
		       coemtido = 134,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 27;
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
			27,
			'LDC_CONSTANCIA_PAGOS',
			NULL,
			'<23>',
			'LDC_CONSTANCIA_PAGOS',
			NULL,
			134,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_27.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_27.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_27.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_27.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_27 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_27'
	);
--}
END;
/

