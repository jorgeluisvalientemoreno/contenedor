BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_12 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_12',
		'CREATE OR REPLACE PACKAGE CONFEXME_12 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_12;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_12',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_12 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_12;'
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_12.cuFormat( 52 );
	fetch CONFEXME_12.cuFormat into nuFormatId;
	close CONFEXME_12.cuFormat;

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
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_12.cuFormat( 52 );
	fetch CONFEXME_12.cuFormat into nuFormatId;
	close CONFEXME_12.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_12.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_CERTIFICADOPAZSALVO',
		       formtido = 131,
		       formiden = '<52>',
		       formtico = 581,
		       formdein = '<LDC_CERTIFICADOPAZSALVO>',
		       formdefi = '</LDC_CERTIFICADOPAZSALVO>'
		WHERE  formcodi = CONFEXME_12.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_12.rcED_Formato.formcodi := 52 ;

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
			CONFEXME_12.rcED_Formato.formcodi,
			'LDC_CERTIFICADOPAZSALVO',
			131,
			'<52>',
			581,
			'<LDC_CERTIFICADOPAZSALVO>',
			'</LDC_CERTIFICADOPAZSALVO>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_12.tbrcGE_Statement( '120079518' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC PAZ Y SALVO]', 5 );
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
		CONFEXME_12.tbrcGE_Statement( '120079518' ).statement_id,
		16,
		'LDC PAZ Y SALVO',
		'select
        pktblsistema.fsbgetcompanyname(99) NOMEMPRESA,
        decode(dapr_product.fnugetproduct_type_id(b.product_id),
              dald_parameter.fnuGetNumeric_Value(''COD_SERV_GAS'', null),
              '' que el servicio ubicado en la dirección '' ||
              nvl(c.address, 0) || '' del municipio '' ||
              nvl(dage_geogra_location.fsbgetdescription(c.geograp_location_id,null),
                  0) || '' con el contrato No.'' || s.susccodi ||
              '' a nombre de '' ||
              (select sc.subscriber_name || '' '' || sc.subs_last_name
                 from ge_subscriber sc
                where sc.subscriber_id = s.suscclie) ||
              '' se encuentra a PAZ Y SALVO con la empresa por todo '' ||
              ''concepto del servicio de GAS NATURAL. Así mismo se dio por terminado el contrato de prestación de servicio público domiciliario de gas natural.'',
              dald_parameter.fnuGetNumeric_Value(''COD_PRODUCT_TYPE_BRILLA'', null),
              '' que el servicio de BRILLA''||DECODE(LDC_FSBNUMFORMULARIO(ldc_crmpazysalvo.FnuProductId),NULL,'''','' correspondiente a la financiación no bancaria con numero de solicitud de crédito ''||LDC_FSBNUMFORMULARIO(ldc_crmpazysalvo.FnuProductId))||
              '', ''|| ''se encuentra a PAZ Y SALVO con la empresa por los conceptos asociados en la misma. '',
              dald_parameter.fnuGetNumeric_Value(''COD_SERV_GNCV'', null),
              '' que el servicio de financiacion del kit de gas natural vehicular correspondiente al vehiculo de placas No ''||''PLACA XXXXXX''||
              '', ''|| ''se encuentra a PAZ Y SALVO con la empresa por todo concepto. ''
              ) SERVICIOPUBLICO,
       pktblservicio.fsbGetDescription(dapr_product.fnugetproduct_type_id(b.product_id)) TIPOPRODUCTO,
       decode(dapr_product.fnugetproduct_type_id(b.product_id),dald_parameter.fnuGetNumeric_Value(''COD_SERV_GAS'', null),
              ''Así mismo se dio por terminado el contrato '' ||
              ''de prestación de servicio público domiciliario de gas natural.'',
              '''') TERMINACIONPROD,
       nvl(c.address, 0) Direccion,
       nvl(dage_geogra_location.fsbgetdescription(c.geograp_location_id,null),0) Municipio,
       s.susccodi Contrato,
       sc.subscriber_name || '' '' || sc.subs_last_name NombreCliente,
       (select sc.subscriber_name || '' '' || sc.subs_last_name
          from ge_subscriber sc
         where sc.subscriber_id = ldc_crmpazysalvo.FnuContactId) NombreContacto,
       DAGE_SUBSCRIBER.FSBGETIDENTIFICATION(ldc_crmpazysalvo.FnuContactId,
                                            null) ContactoId,
       ldc_crmpazysalvo.FnuDiaActual Dia,
       ldc_crmpazysalvo.FnuMesActual Mes,
       ldc_crmpazysalvo.FnuAnnoActual Anno,
       nvl(dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(c.geograp_location_id,null),null),0) Departamento,
       LDC_CRMPazySalvo.Fsbaddress MF
  from servsusc      sv,
       suscripc      s,
       ge_subscriber sc,
       pr_product    b,
       ab_address    c
 where sv.sesunuse = ldc_crmpazysalvo.FnuProductId
   and sv.sesususc = s.susccodi
   and s.suscclie = sc.subscriber_id
   and sc.subscriber_id = s.suscclie
   and sv.sesunuse = product_id
   AND b.address_id = c.address_id',
		'LDC_PAZYSALVO'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_12.tbrcGE_Statement( '120079518' ).statement_id,
		empty_clob(),
		empty_clob(),
		empty_clob()
	)
	RETURNING	wizard_columns, select_columns, list_values
	INTO		clWizardColumns, clSelectColumns, clListValues;

	dbms_lob.append( clSelectColumns, '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>NOMEMPRESA</Name>
    <Description>NOMEMPRESA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>SERVICIOPUBLICO</Name>
    <Description>SERVICIOPUBLICO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
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
    <Name>TERMINACIONPROD</Name>
    <Description>TERMINACIONPROD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>105</Length>
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
    <Name>NOMBRECLIENTE</Name>
    <Description>NOMBRECLIENTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>201</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRECONTACTO</Name>
    <Description>NOMBRECONTACTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>201</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONTACTOID</Name>
    <Description>CONTACTOID</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIA</Name>
    <Description>DIA</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MES</Name>
    <Description>MES</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ANNO</Name>
    <Description>ANNO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DEPARTAMENTO</Name>
    <Description>DEPARTAMENTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MF</Name>
    <Description>MF</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>' );

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_12.tbrcED_Franja( 2609 ).francodi := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Franja [PAZSALVO]', 5 );
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
		CONFEXME_12.tbrcED_Franja( 2609 ).francodi,
		'PAZSALVO',
		CONFEXME_12.tbrcED_Franja( 2609 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_12.tbrcED_FranForm( '2458' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_12.tbrcED_FranForm( '2458' ).frfoform := CONFEXME_12.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_12.tbrcED_Franja.exists( 2609 ) ) then
		CONFEXME_12.tbrcED_FranForm( '2458' ).frfofran := CONFEXME_12.tbrcED_Franja( 2609 ).francodi;
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
		CONFEXME_12.tbrcED_FranForm( '2458' ).frfocodi,
		CONFEXME_12.tbrcED_FranForm( '2458' ).frfoform,
		CONFEXME_12.tbrcED_FranForm( '2458' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_12.tbrcGE_Statement.exists( '120079518' ) ) then
		CONFEXME_12.tbrcED_FuenDato( '2559' ).fudasent := CONFEXME_12.tbrcGE_Statement( '120079518' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_PAZYSALVO]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi,
		'LDC_PAZYSALVO',
		NULL,
		CONFEXME_12.tbrcED_FuenDato( '2559' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20239' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20239' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOMEMPRESA]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20239' ).atfdcodi,
		'NOMEMPRESA',
		'NOMEMPRESA',
		1,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20239' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20240' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20240' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [SERVICIOPUBLICO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20240' ).atfdcodi,
		'SERVICIOPUBLICO',
		'SERVICIOPUBLICO',
		2,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20240' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20241' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20241' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
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
		CONFEXME_12.tbrcED_AtriFuda( '20241' ).atfdcodi,
		'TIPOPRODUCTO',
		'TIPOPRODUCTO',
		3,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20241' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20242' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20242' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [TERMINACIONPROD]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20242' ).atfdcodi,
		'TERMINACIONPROD',
		'TERMINACIONPROD',
		4,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20242' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20243' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20243' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
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
		CONFEXME_12.tbrcED_AtriFuda( '20243' ).atfdcodi,
		'DIRECCION',
		'DIRECCION',
		5,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20243' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20244' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20244' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
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
		CONFEXME_12.tbrcED_AtriFuda( '20244' ).atfdcodi,
		'MUNICIPIO',
		'MUNICIPIO',
		6,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20244' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20245' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20245' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
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
		CONFEXME_12.tbrcED_AtriFuda( '20245' ).atfdcodi,
		'CONTRATO',
		'CONTRATO',
		7,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20245' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20246' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20246' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOMBRECLIENTE]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20246' ).atfdcodi,
		'NOMBRECLIENTE',
		'NOMBRECLIENTE',
		8,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20246' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20247' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20247' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [NOMBRECONTACTO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20247' ).atfdcodi,
		'NOMBRECONTACTO',
		'NOMBRECONTACTO',
		9,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20247' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20248' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20248' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [CONTACTOID]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20248' ).atfdcodi,
		'CONTACTOID',
		'CONTACTOID',
		10,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20248' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20249' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20249' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
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
		CONFEXME_12.tbrcED_AtriFuda( '20249' ).atfdcodi,
		'DIA',
		'DIA',
		11,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20249' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20250' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20250' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
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
		CONFEXME_12.tbrcED_AtriFuda( '20250' ).atfdcodi,
		'MES',
		'MES',
		12,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20250' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20251' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20251' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [ANNO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20251' ).atfdcodi,
		'ANNO',
		'ANNO',
		13,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20251' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20252' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20252' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [DEPARTAMENTO]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20252' ).atfdcodi,
		'DEPARTAMENTO',
		'DEPARTAMENTO',
		14,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20252' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_12.tbrcED_AtriFuda( '20253' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_AtriFuda( '20253' ).atfdfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [MF]', 5 );
	INSERT INTO ED_AtriFuda
	(
		atfdcodi,
		atfdnote,
		atfddesc,
		atfdorde,
		atfdvisi,
		atfdfuda,
		atfdtida
	)
	VALUES
	(
		CONFEXME_12.tbrcED_AtriFuda( '20253' ).atfdcodi,
		'MF',
		'MF',
		15,
		'S',
		CONFEXME_12.tbrcED_AtriFuda( '20253' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_12.tbrcED_Bloque( 4118 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_12.tbrcED_FuenDato.exists( '2559' ) ) then
		CONFEXME_12.tbrcED_Bloque( 4118 ).bloqfuda := CONFEXME_12.tbrcED_FuenDato( '2559' ).fudacodi;
	end if;

	UT_Trace.Trace( 'Insertando Bloque [PAZSALVO_BLOQUEPAZSALVO]', 5 );
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
		CONFEXME_12.tbrcED_Bloque( 4118 ).bloqcodi,
		'PAZSALVO_BLOQUEPAZSALVO',
		CONFEXME_12.tbrcED_Bloque( 4118 ).bloqtibl,
		CONFEXME_12.tbrcED_Bloque( 4118 ).bloqfuda,
		'<PAZSALVO_BLOQUEPAZSALVO>',
		'</PAZSALVO_BLOQUEPAZSALVO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrfrfo := CONFEXME_12.tbrcED_FranForm( '2458' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_12.tbrcED_Bloque.exists( 4118 ) ) then
		CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrbloq := CONFEXME_12.tbrcED_Bloque( 4118 ).bloqcodi;
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
		CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi,
		CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrbloq,
		CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24376' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24376' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20239' ) ) then
		CONFEXME_12.tbrcED_Item( '24376' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20239' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOMEMPRESA]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24376' ).itemcodi,
		'NOMEMPRESA',
		CONFEXME_12.tbrcED_Item( '24376' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24376' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24376' ).itemgren,
		NULL,
		1,
		'<NOMEMPRESA>',
		'</NOMEMPRESA>',
		CONFEXME_12.tbrcED_Item( '24376' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24377' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24377' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20240' ) ) then
		CONFEXME_12.tbrcED_Item( '24377' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20240' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [SERVICIOPUBLICO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24377' ).itemcodi,
		'SERVICIOPUBLICO',
		CONFEXME_12.tbrcED_Item( '24377' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24377' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24377' ).itemgren,
		NULL,
		1,
		'<SERVICIOPUBLICO>',
		'</SERVICIOPUBLICO>',
		CONFEXME_12.tbrcED_Item( '24377' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24378' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24378' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20241' ) ) then
		CONFEXME_12.tbrcED_Item( '24378' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20241' ).atfdcodi;
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
		CONFEXME_12.tbrcED_Item( '24378' ).itemcodi,
		'TIPOPRODUCTO',
		CONFEXME_12.tbrcED_Item( '24378' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24378' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24378' ).itemgren,
		NULL,
		1,
		'<TIPOPRODUCTO>',
		'</TIPOPRODUCTO>',
		CONFEXME_12.tbrcED_Item( '24378' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24379' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24379' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20242' ) ) then
		CONFEXME_12.tbrcED_Item( '24379' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20242' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [TERMINACIONPROD]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24379' ).itemcodi,
		'TERMINACIONPROD',
		CONFEXME_12.tbrcED_Item( '24379' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24379' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24379' ).itemgren,
		NULL,
		1,
		'<TERMINACIONPROD>',
		'</TERMINACIONPROD>',
		CONFEXME_12.tbrcED_Item( '24379' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24380' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24380' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20243' ) ) then
		CONFEXME_12.tbrcED_Item( '24380' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20243' ).atfdcodi;
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
		CONFEXME_12.tbrcED_Item( '24380' ).itemcodi,
		'DIRECCION',
		CONFEXME_12.tbrcED_Item( '24380' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24380' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24380' ).itemgren,
		NULL,
		1,
		'<DIRECCION>',
		'</DIRECCION>',
		CONFEXME_12.tbrcED_Item( '24380' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24381' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24381' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20244' ) ) then
		CONFEXME_12.tbrcED_Item( '24381' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20244' ).atfdcodi;
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
		CONFEXME_12.tbrcED_Item( '24381' ).itemcodi,
		'MUNICIPIO',
		CONFEXME_12.tbrcED_Item( '24381' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24381' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24381' ).itemgren,
		NULL,
		1,
		'<MUNICIPIO>',
		'</MUNICIPIO>',
		CONFEXME_12.tbrcED_Item( '24381' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24382' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24382' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20245' ) ) then
		CONFEXME_12.tbrcED_Item( '24382' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20245' ).atfdcodi;
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
		CONFEXME_12.tbrcED_Item( '24382' ).itemcodi,
		'CONTRATO',
		CONFEXME_12.tbrcED_Item( '24382' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24382' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24382' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_12.tbrcED_Item( '24382' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24383' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24383' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20246' ) ) then
		CONFEXME_12.tbrcED_Item( '24383' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20246' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOMBRECLIENTE]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24383' ).itemcodi,
		'NOMBRECLIENTE',
		CONFEXME_12.tbrcED_Item( '24383' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24383' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24383' ).itemgren,
		NULL,
		1,
		'<NOMBRECLIENTE>',
		'</NOMBRECLIENTE>',
		CONFEXME_12.tbrcED_Item( '24383' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24384' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24384' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20247' ) ) then
		CONFEXME_12.tbrcED_Item( '24384' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20247' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [NOMBRECONTACTO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24384' ).itemcodi,
		'NOMBRECONTACTO',
		CONFEXME_12.tbrcED_Item( '24384' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24384' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24384' ).itemgren,
		NULL,
		1,
		'<NOMBRECONTACTO>',
		'</NOMBRECONTACTO>',
		CONFEXME_12.tbrcED_Item( '24384' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24385' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24385' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20248' ) ) then
		CONFEXME_12.tbrcED_Item( '24385' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20248' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [CONTACTOID]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24385' ).itemcodi,
		'CONTACTOID',
		CONFEXME_12.tbrcED_Item( '24385' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24385' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24385' ).itemgren,
		NULL,
		1,
		'<CONTACTOID>',
		'</CONTACTOID>',
		CONFEXME_12.tbrcED_Item( '24385' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24386' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24386' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20249' ) ) then
		CONFEXME_12.tbrcED_Item( '24386' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20249' ).atfdcodi;
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
		CONFEXME_12.tbrcED_Item( '24386' ).itemcodi,
		'DIA',
		CONFEXME_12.tbrcED_Item( '24386' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24386' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24386' ).itemgren,
		NULL,
		2,
		'<DIA>',
		'</DIA>',
		CONFEXME_12.tbrcED_Item( '24386' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24387' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24387' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20250' ) ) then
		CONFEXME_12.tbrcED_Item( '24387' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20250' ).atfdcodi;
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
		CONFEXME_12.tbrcED_Item( '24387' ).itemcodi,
		'MES',
		CONFEXME_12.tbrcED_Item( '24387' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24387' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24387' ).itemgren,
		NULL,
		2,
		'<MES>',
		'</MES>',
		CONFEXME_12.tbrcED_Item( '24387' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24388' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24388' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20251' ) ) then
		CONFEXME_12.tbrcED_Item( '24388' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20251' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [ANNO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24388' ).itemcodi,
		'ANNO',
		CONFEXME_12.tbrcED_Item( '24388' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24388' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24388' ).itemgren,
		NULL,
		2,
		'<ANNO>',
		'</ANNO>',
		CONFEXME_12.tbrcED_Item( '24388' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24389' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24389' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20252' ) ) then
		CONFEXME_12.tbrcED_Item( '24389' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20252' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [DEPARTAMENTO]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24389' ).itemcodi,
		'DEPARTAMENTO',
		CONFEXME_12.tbrcED_Item( '24389' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24389' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24389' ).itemgren,
		NULL,
		1,
		'<DEPARTAMENTO>',
		'</DEPARTAMENTO>',
		CONFEXME_12.tbrcED_Item( '24389' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_12.tbrcED_Item( '24390' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_12.tbrcED_Item( '24390' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_12.tbrcED_AtriFuda.exists( '20253' ) ) then
		CONFEXME_12.tbrcED_Item( '24390' ).itematfd := CONFEXME_12.tbrcED_AtriFuda( '20253' ).atfdcodi;
	end if;

	UT_Trace.Trace( 'Insertando Item [MF]', 5 );
	INSERT INTO ED_Item
	(
		itemcodi,
		itemdesc,
		itemceid,
		itemcons,
		itemobna,
		itemlong,
		itemalin,
		itematri,
		itemgren,
		itemmasc,
		itemtida,
		itemdein,
		itemdefi,
		itematfd
	)
	VALUES
	(
		CONFEXME_12.tbrcED_Item( '24390' ).itemcodi,
		'MF',
		CONFEXME_12.tbrcED_Item( '24390' ).itemceid,
		NULL,
		CONFEXME_12.tbrcED_Item( '24390' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_12.tbrcED_Item( '24390' ).itemgren,
		NULL,
		1,
		'<MF>',
		'</MF>',
		CONFEXME_12.tbrcED_Item( '24390' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24331' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24331' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24376' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24331' ).itblitem := CONFEXME_12.tbrcED_Item( '24376' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24331' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24331' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24331' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24332' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24332' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24377' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24332' ).itblitem := CONFEXME_12.tbrcED_Item( '24377' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24332' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24332' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24332' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24333' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24333' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24378' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24333' ).itblitem := CONFEXME_12.tbrcED_Item( '24378' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24333' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24333' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24333' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24334' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24334' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24379' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24334' ).itblitem := CONFEXME_12.tbrcED_Item( '24379' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24334' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24334' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24334' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24335' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24335' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24380' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24335' ).itblitem := CONFEXME_12.tbrcED_Item( '24380' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24335' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24335' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24335' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24336' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24336' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24381' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24336' ).itblitem := CONFEXME_12.tbrcED_Item( '24381' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24336' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24336' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24336' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24337' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24337' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24382' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24337' ).itblitem := CONFEXME_12.tbrcED_Item( '24382' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24337' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24337' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24337' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24338' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24338' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24383' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24338' ).itblitem := CONFEXME_12.tbrcED_Item( '24383' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24338' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24338' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24338' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24339' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24339' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24384' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24339' ).itblitem := CONFEXME_12.tbrcED_Item( '24384' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24339' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24339' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24339' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24340' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24340' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24385' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24340' ).itblitem := CONFEXME_12.tbrcED_Item( '24385' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24340' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24340' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24340' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24341' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24341' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24386' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24341' ).itblitem := CONFEXME_12.tbrcED_Item( '24386' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24341' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24341' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24341' ).itblblfr,
		11
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24342' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24342' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24387' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24342' ).itblitem := CONFEXME_12.tbrcED_Item( '24387' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24342' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24342' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24342' ).itblblfr,
		12
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24343' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24343' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24388' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24343' ).itblitem := CONFEXME_12.tbrcED_Item( '24388' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24343' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24343' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24343' ).itblblfr,
		13
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24344' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24344' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24389' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24344' ).itblitem := CONFEXME_12.tbrcED_Item( '24389' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24344' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24344' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24344' ).itblblfr,
		14
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_12.tbrcED_ItemBloq( '24345' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_12.tbrcED_ItemBloq( '24345' ).itblblfr := CONFEXME_12.tbrcED_BloqFran( '4282' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_12.tbrcED_Item.exists( '24390' ) ) then
		CONFEXME_12.tbrcED_ItemBloq( '24345' ).itblitem := CONFEXME_12.tbrcED_Item( '24390' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_12.tbrcED_ItemBloq( '24345' ).itblcodi,
		CONFEXME_12.tbrcED_ItemBloq( '24345' ).itblitem,
		CONFEXME_12.tbrcED_ItemBloq( '24345' ).itblblfr,
		15
	);

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
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
		8094, 
		hextoraw
		(
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E30626331623334312D343131352D343036372D383762322D3937353530333835336437623C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C52696768744D617267696E3E322E35636D3C2F52696768744D617267696E3E0D0A20203C4C6566744D617267696E3E322E35636D3C2F4C6566744D617267696E3E0D0A20203C426F74746F6D4D617267696E3E322E35636D3C2F426F74746F6D4D617267696E3E0D0A20203C72643A5265706F727449443E39643733656364632D613535632D343635352D613239392D6266393236363831666661633C2F72643A5265706F727449443E0D0A20203C5061676557696474683E3231636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D2250415A53414C564F5F424C4F51554550415A53414C564F223E0D0A2020202020203C4669656C64'
		||	'733E20202020202020200D0A09093C4669656C64204E616D653D224E4F4D454D5052455341223E0D0A202020202020202020203C446174614669656C643E4E4F4D454D50524553413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A09093C4669656C64204E616D653D22444952454343494F4E223E0D0A202020202020202020203C446174614669656C643E444952454343494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D554E49434950494F223E0D0A202020202020202020203C446174614669656C643E4D554E49434950494F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D425245434C49454E5445223E0D0A202020202020202020203C446174614669656C643E4E4F4D425245434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224E4F4D425245434F4E544143544F223E0D0A202020202020202020203C446174614669656C643E4E4F4D425245434F4E544143544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E544143544F4944223E0D0A202020202020202020203C446174614669656C643E434F4E544143544F49443C2F446174614669656C643E0D0A202020202020202020203C72643A'
		||	'547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444941223E0D0A202020202020202020203C446174614669656C643E4449413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D4553223E0D0A202020202020202020203C446174614669656C643E4D45533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22414E4E4F223E0D0A202020202020202020203C446174614669656C643E414E4E4F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22444550415254414D454E544F223E0D0A202020202020202020203C446174614669656C643E444550415254414D454E544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224D46223E0D0A202020202020202020203C446174614669656C643E4D463C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A09093C4669656C64204E616D653D225449504F50524F445543544F223E0D0A202020202020202020203C446174614669656C643E5449504F50524F445543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225445524D494E4143494F4E50524F44223E0D0A202020202020202020203C446174614669656C643E5445524D494E4143494F4E50524F443C2F446174614669656C643E0D0A2020202020202020'
		||	'20203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22534552564943494F5055424C49434F223E0D0A202020202020202020203C446174614669656C643E534552564943494F5055424C49434F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E50415A53414C564F3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E424C4F51554550415A53414C564F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E200D0A093C2F44617461536574733E090D0A20203C57696474683E3135636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E31636D3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78373C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31342E3235636D3C2F546F703E0D0A20202020202020203C57696474683E392E3235636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F'
		||	'6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22446570617274616D656E746F2022202B204669727374284669656C647321444550415254414D454E544F2E56616C7565293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78363C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31332E3235636D3C2F546F703E0D0A20202020202020203C57696474683E322E3533393638636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3633343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D224669726D613A223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78353C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E31312E3235636D3C2F546F703E0D0A20202020202020203C57696474683E33636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020'
		||	'203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3735636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22436F726469616C6D656E74652C223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78343C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E382E3735636D3C2F546F703E0D0A20202020202020203C57696474683E31342E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D225061726120636F6E7374616E636961207365206669726D6120656E2022202B204669727374284669656C6473214D462E56616C756529202B20222C20656C206469612022202B204669727374284669656C6473214449412E56616C756529202B20222064656C206D65732022202B204669727374284669656C6473214D45532E56616C756529202B20222064652022202B204669727374284669656C647321414E4E4F2E56616C756529202B20222E223C2F56616C75653E0D0A20202020'
		||	'20203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78333C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E36636D3C2F546F703E0D0A20202020202020203C57696474683E31342E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E32636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D22456C2070726573656E746520646F63756D656E746F20736520657870696465206120736F6C6963697475642064652022202B204669727374284669656C6473214E4F4D425245434F4E544143544F2E56616C756529202B202220717569656E207365206964656E74696669636120636F6E20656C20646F63756D656E746F206465206964656E7469666963616369C3B36E204E6F2E2022202B204669727374284669656C647321434F4E544143544F49442E56616C756529202B20222E223C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E322E35636D3C2F546F703E0D0A20202020202020203C57696474683E31342E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20'
		||	'2020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E33636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C6473214E4F4D454D50524553412E56616C7565292B22202063657274696669636122202B204669727374284669656C647321534552564943494F5055424C49434F2E56616C7565293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78313C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E302E3235636D3C2F546F703E0D0A20202020202020203C57696474683E31342E35636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E323270743C2F466F6E7453697A653E0D0A202020202020202020203C466F6E745765696768743E3730303C2F466F6E745765696768743E0D0A202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E3133343932636D3C2F4865696768743E0D0A20202020202020203C56616C75653E50415A20592053414C564F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E31352E35636D3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E'
		||	'65732D45533C2F4C616E67756167653E0D0A20203C546F704D617267696E3E322E35636D3C2F546F704D617267696E3E0D0A20203C506167654865696768743E32392E37636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_12.cuPlantilla( 18 );
	fetch CONFEXME_12.cuPlantilla into nuIdPlantill;
	close CONFEXME_12.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'LDC_CERTIFICADOPAZSALVO',
		       plannomb = 'LDC_CERTIFICADOPAZSALVO',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 18;
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
			18,
			blContent ,
			'LDC_CERTIFICADOPAZSALVO',
			'LDC_CERTIFICADOPAZSALVO',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_12.cuExtractAndMix( 12 );
	fetch CONFEXME_12.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_12.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_CERTIFICADOPAZSALVO',
		       coeminic = NULL,
		       coempada = '<52>',
		       coempadi = 'LDC_CERTIFICADOPAZSALVO',
		       coempame = NULL,
		       coemtido = 131,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 12;
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
			12,
			'LDC_CERTIFICADOPAZSALVO',
			NULL,
			'<52>',
			'LDC_CERTIFICADOPAZSALVO',
			NULL,
			131,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_12.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_12.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_12.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_12.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_12 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_12'
	);
--}
END;
/

