BEGIN
--{
	SetSystemEnviroment;
--}
END;
/

BEGIN
--{
	UT_Trace.Trace( '********************** Creando paquete CONFEXME_37 ***********************', 5 );
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_37',
		'CREATE OR REPLACE PACKAGE CONFEXME_37 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_37;'
	);
--}
END;
/

BEGIN
--{
	SA_BOCreatePackages.CreatePackage
	(
		'CONFEXME_37',
		'CREATE OR REPLACE PACKAGE BODY CONFEXME_37 IS ' || chr(10) || chr(10) ||
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

		'END CONFEXME_37;'
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_37.cuFormat( 182 );
	fetch CONFEXME_37.cuFormat into nuFormatId;
	close CONFEXME_37.cuFormat;

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
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del formato con el identificador especificado
	open CONFEXME_37.cuFormat( 182 );
	fetch CONFEXME_37.cuFormat into nuFormatId;
	close CONFEXME_37.cuFormat;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuFormatId is not NULL ) then
	--{
		-- Se establece el identificador para el formato
		CONFEXME_37.rcED_Formato.formcodi := nuFormatId;

		-- Se actualiza la información del formato
		UPDATE ED_Formato
		SET    formdesc = 'LDC_PAGO_PARCIAL',
		       formtido = 66,
		       formiden = '<182>',
		       formtico = 49,
		       formdein = '<LDC_PAGO_PARCIAL>',
		       formdefi = '</LDC_PAGO_PARCIAL>'
		WHERE  formcodi = CONFEXME_37.rcED_Formato.formcodi;
	--}
	else
	--{
		-- Se genera un identificador para el formato
		CONFEXME_37.rcED_Formato.formcodi := 182 ;

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
			CONFEXME_37.rcED_Formato.formcodi,
			'LDC_PAGO_PARCIAL',
			66,
			'<182>',
			49,
			'<LDC_PAGO_PARCIAL>',
			'</LDC_PAGO_PARCIAL>'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_37.tbrcGE_Statement( '120195246' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC_PAGO_PARCIAL]', 5 );
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
		CONFEXME_37.tbrcGE_Statement( '120195246' ).statement_id,
		1,
		'LDC_PAGO_PARCIAL',
		'SELECT (b.subscriber_name||'' ''||b.subs_last_name||'' ''||
        b.subs_second_last_name)                                                CLIENTE
        , b.identification                                                      IDENTIFICACION
        ,s.susccodi                                                             CONTRATO
      ,(a.address ||''  ''||
         (select x.description
            from ge_geogra_location x
            where x.geograp_location_id = a.neighborthood_id))                  DIRPROYECTO
      ,cu.cupotipo                                                              TIPOCUPON
      ,decode(cu.cuponume, null, ''No se ha generado Cup¿n'', cu.cuponume)        CUPON
      ,decode(fr.factvaap, null, ''No se ha generado Cup¿n'', ''$''||to_char(cu.cupovalo,''FM999,999,999,999''))   VALOR
      , case when (open.LDC_BOFORMATOFACTURA.fsbPagoInmediato(se.sesunuse)=1) then
                ''INMEDIATO''
            else to_char(pf.pefafepa,''DD-MON-YYYY'') end                           VALIDOHASTA
      ,''CUPON DE PAGO PARCIAL''            TIPO_SOL
      ,''(415)''||dald_parameter.fsbGetValue_Chain(''COD_EAN_CODIGO_BARRAS'')
        ||''(8020)''||LPAD(to_char(CUPONUME),10,''0'')
        ||''(3900)''||LPAD(to_char(CUPOVALO),10,''0'')
        ||''(96)''||to_char(pf.pefaffmo,''yyyymmdd'') CODIGODEBARRAS
from  suscripc s, servsusc se, ge_subscriber b
     ,ab_address a, ge_geogra_location g
     ,factura fr,cupon cu, perifact pf
where cu.cupodocu = fr.factcodi
    AND s.susccicl = pf.pefacicl
    AND pf.pefaactu = ''S''
    and a.geograp_location_id = g.geograp_location_id
    and s.SUSCIDDI = a.address_id
    and s.suscclie = b.subscriber_id
    and s.susccodi = cu.cuposusc
    AND se.sesususc = s.susccodi
    and cu.cuponume = to_number(obtenervalorinstancia(''CUPON'',''CUPONUME''))
    AND rownum = 1',
		'LDC_PAGO_PARCIAL'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_37.tbrcGE_Statement( '120195246' ).statement_id,
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
    <Length>11</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_SOL</Name>
    <Description>TIPO_SOL</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>15</Length>
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
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la sentencia
	nuNextSeqValue := GE_BOSequence.NextGe_Statement;
	CONFEXME_37.tbrcGE_Statement( '120195247' ).statement_id := nuNextSeqValue;

	UT_Trace.Trace( 'Insertando Sentencia [LDC_PAGO_PARCIAL_BARCODE]', 5 );
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
		CONFEXME_37.tbrcGE_Statement( '120195247' ).statement_id,
		1,
		'LDC_PAGO_PARCIAL_BARCODE',
		'select  ''415''||dald_parameter.fsbGetValue_Chain(''COD_EAN_CODIGO_BARRAS'')
        ||''8020''||LPAD(to_char(CUPONUME),10,''0'')||chr(200)
        ||''3900''||LPAD(to_char(CUPOVALO),10,''0'')||chr(200)
        ||''96''||to_char(pf.pefaffmo,''yyyymmdd'') CODE,
        NULL IMAGE
from suscripc s, cupon cu, perifact pf
WHERE cu.cuponume =  to_number(obtenervalorinstancia(''CUPON'',''CUPONUME''))
    AND s.susccicl = pf.pefacicl
    AND pf.pefaactu = ''S''
    and s.susccodi = cu.cuposusc
    AND rownum = 1',
		'LDC_PAGO_PARCIAL_BARCODE'
	);

	INSERT INTO GE_Statement_Columns VALUES
	(
		CONFEXME_37.tbrcGE_Statement( '120195247' ).statement_id,
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
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANJA;
	CONFEXME_37.tbrcED_Franja( 4678 ).francodi := nuNextSeqValue;

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
		CONFEXME_37.tbrcED_Franja( 4678 ).francodi,
		'LDC_FRANJADEPOSITO',
		CONFEXME_37.tbrcED_Franja( 4678 ).frantifr,
		NULL,
		NULL
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la franja-formato
	nuNextSeqValue := pkBOInsertMgr.NextED_FRANFORM;
	CONFEXME_37.tbrcED_FranForm( '4527' ).frfocodi := nuNextSeqValue;

	-- Se asigna el formato
	CONFEXME_37.tbrcED_FranForm( '4527' ).frfoform := CONFEXME_37.rcED_Formato.formcodi;

	-- Se asigna la franja
	if ( CONFEXME_37.tbrcED_Franja.exists( 4678 ) ) then
		CONFEXME_37.tbrcED_FranForm( '4527' ).frfofran := CONFEXME_37.tbrcED_Franja( 4678 ).francodi;
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
		CONFEXME_37.tbrcED_FranForm( '4527' ).frfocodi,
		CONFEXME_37.tbrcED_FranForm( '4527' ).frfoform,
		CONFEXME_37.tbrcED_FranForm( '4527' ).frfofran,
		0,
		'N'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_37.tbrcGE_Statement.exists( '120195246' ) ) then
		CONFEXME_37.tbrcED_FuenDato( '3713' ).fudasent := CONFEXME_37.tbrcGE_Statement( '120195246' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_PAGO_PARCIAL]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi,
		'LDC_PAGO_PARCIAL',
		NULL,
		CONFEXME_37.tbrcED_FuenDato( '3713' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para la fuente de datos
	nuNextSeqValue := pkBOInsertMgr.NextED_FUENDATO;
	CONFEXME_37.tbrcED_FuenDato( '3714' ).fudacodi := nuNextSeqValue;

	-- Se asigna la sentencia asociada a la fuente de datos
	if ( CONFEXME_37.tbrcGE_Statement.exists( '120195247' ) ) then
		CONFEXME_37.tbrcED_FuenDato( '3714' ).fudasent := CONFEXME_37.tbrcGE_Statement( '120195247' ).statement_id;
	end if;

	UT_Trace.Trace( 'Insertando Fuente de Datos [LDC_PAGO_PARCIAL_BARCODE]', 5 );
	INSERT INTO ED_FuenDato
	(
		fudacodi,
		fudadesc,
		fudaserv,
		fudasent
	)
	VALUES
	(
		CONFEXME_37.tbrcED_FuenDato( '3714' ).fudacodi,
		'LDC_PAGO_PARCIAL_BARCODE',
		NULL,
		CONFEXME_37.tbrcED_FuenDato( '3714' ).fudasent
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29843' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3714' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29843' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3714' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29843' ).atfdcodi,
		'CODE',
		'CODE',
		1,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29843' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29844' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3714' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29844' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3714' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29844' ).atfdcodi,
		'IMAGE',
		'IMAGE',
		2,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29844' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29845' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29845' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29845' ).atfdcodi,
		'CLIENTE',
		'CLIENTE',
		1,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29845' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29846' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29846' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29846' ).atfdcodi,
		'IDENTIFICACION',
		'IDENTIFICACION',
		2,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29846' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29847' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29847' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29847' ).atfdcodi,
		'CONTRATO',
		'CONTRATO',
		3,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29847' ).atfdfuda,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29848' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29848' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29848' ).atfdcodi,
		'DIRPROYECTO',
		'DIRPROYECTO',
		4,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29848' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29849' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29849' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29849' ).atfdcodi,
		'TIPOCUPON',
		'TIPOCUPON',
		5,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29849' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29850' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29850' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29850' ).atfdcodi,
		'CUPON',
		'CUPON',
		6,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29850' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29851' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29851' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29851' ).atfdcodi,
		'VALOR',
		'VALOR',
		7,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29851' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29852' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29852' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29852' ).atfdcodi,
		'VALIDOHASTA',
		'VALIDOHASTA',
		8,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29852' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29853' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29853' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29853' ).atfdcodi,
		'TIPO_SOL',
		'TIPO_SOL',
		9,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29853' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el atributo
	nuNextSeqValue := pkBOInsertMgr.NextED_ATRIFUDA;
	CONFEXME_37.tbrcED_AtriFuda( '29854' ).atfdcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_AtriFuda( '29854' ).atfdfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_AtriFuda( '29854' ).atfdcodi,
		'CODIGODEBARRAS',
		'CODIGODEBARRAS',
		10,
		'S',
		CONFEXME_37.tbrcED_AtriFuda( '29854' ).atfdfuda,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_37.tbrcED_Bloque( 6504 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3713' ) ) then
		CONFEXME_37.tbrcED_Bloque( 6504 ).bloqfuda := CONFEXME_37.tbrcED_FuenDato( '3713' ).fudacodi;
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
		CONFEXME_37.tbrcED_Bloque( 6504 ).bloqcodi,
		'LDC_BLOQUEDEPOSITO',
		CONFEXME_37.tbrcED_Bloque( 6504 ).bloqtibl,
		CONFEXME_37.tbrcED_Bloque( 6504 ).bloqfuda,
		'<LDC_FRANJADEPOSITO_LDC_BLOQUEDEPOSITO>',
		'</LDC_FRANJADEPOSITO_LDC_BLOQUEDEPOSITO>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQUE;
	CONFEXME_37.tbrcED_Bloque( 6505 ).bloqcodi := nuNextSeqValue;

	-- Se asigna la fuente de datos del bloque
	if ( CONFEXME_37.tbrcED_FuenDato.exists( '3714' ) ) then
		CONFEXME_37.tbrcED_Bloque( 6505 ).bloqfuda := CONFEXME_37.tbrcED_FuenDato( '3714' ).fudacodi;
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
		CONFEXME_37.tbrcED_Bloque( 6505 ).bloqcodi,
		'LDC_EXTRA_BARCODE_',
		CONFEXME_37.tbrcED_Bloque( 6505 ).bloqtibl,
		CONFEXME_37.tbrcED_Bloque( 6505 ).bloqfuda,
		'<EXTRA_BARCODE_>',
		'</EXTRA_BARCODE_>'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrfrfo := CONFEXME_37.tbrcED_FranForm( '4527' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_37.tbrcED_Bloque.exists( 6504 ) ) then
		CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrbloq := CONFEXME_37.tbrcED_Bloque( 6504 ).bloqcodi;
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
		CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi,
		CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrbloq,
		CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrfrfo,
		2,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el bloque-franja
	nuNextSeqValue := pkBOInsertMgr.NextED_BLOQFRAN;
	CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrcodi := nuNextSeqValue;

	-- Se asigna la franja-formato
	CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrfrfo := CONFEXME_37.tbrcED_FranForm( '4527' ).frfocodi;

	-- Se asigna el bloque
	if ( CONFEXME_37.tbrcED_Bloque.exists( 6505 ) ) then
		CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrbloq := CONFEXME_37.tbrcED_Bloque( 6505 ).bloqcodi;
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
		CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrcodi,
		CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrbloq,
		CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrfrfo,
		0,
		'S',
		'I'
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35101' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35101' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29843' ) ) then
		CONFEXME_37.tbrcED_Item( '35101' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29843' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35101' ).itemcodi,
		'CODE',
		CONFEXME_37.tbrcED_Item( '35101' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35101' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35101' ).itemgren,
		NULL,
		1,
		'<CODE>',
		'</CODE>',
		CONFEXME_37.tbrcED_Item( '35101' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35102' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35102' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29844' ) ) then
		CONFEXME_37.tbrcED_Item( '35102' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29844' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35102' ).itemcodi,
		'IMAGE',
		CONFEXME_37.tbrcED_Item( '35102' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35102' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35102' ).itemgren,
		NULL,
		1,
		'<IMAGE>',
		'</IMAGE>',
		CONFEXME_37.tbrcED_Item( '35102' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35103' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35103' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29845' ) ) then
		CONFEXME_37.tbrcED_Item( '35103' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29845' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35103' ).itemcodi,
		'CLIENTE',
		CONFEXME_37.tbrcED_Item( '35103' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35103' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35103' ).itemgren,
		NULL,
		1,
		'<CLIENTE>',
		'</CLIENTE>',
		CONFEXME_37.tbrcED_Item( '35103' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35104' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35104' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29846' ) ) then
		CONFEXME_37.tbrcED_Item( '35104' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29846' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35104' ).itemcodi,
		'IDENTIFICACION',
		CONFEXME_37.tbrcED_Item( '35104' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35104' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35104' ).itemgren,
		NULL,
		1,
		'<IDENTIFICACION>',
		'</IDENTIFICACION>',
		CONFEXME_37.tbrcED_Item( '35104' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35105' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35105' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29847' ) ) then
		CONFEXME_37.tbrcED_Item( '35105' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29847' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35105' ).itemcodi,
		'CONTRATO',
		CONFEXME_37.tbrcED_Item( '35105' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35105' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35105' ).itemgren,
		NULL,
		2,
		'<CONTRATO>',
		'</CONTRATO>',
		CONFEXME_37.tbrcED_Item( '35105' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35106' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35106' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29848' ) ) then
		CONFEXME_37.tbrcED_Item( '35106' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29848' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35106' ).itemcodi,
		'DIRPROYECTO',
		CONFEXME_37.tbrcED_Item( '35106' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35106' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35106' ).itemgren,
		NULL,
		1,
		'<DIRPROYECTO>',
		'</DIRPROYECTO>',
		CONFEXME_37.tbrcED_Item( '35106' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35107' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35107' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29849' ) ) then
		CONFEXME_37.tbrcED_Item( '35107' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29849' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35107' ).itemcodi,
		'TIPOCUPON',
		CONFEXME_37.tbrcED_Item( '35107' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35107' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35107' ).itemgren,
		NULL,
		1,
		'<TIPOCUPON>',
		'</TIPOCUPON>',
		CONFEXME_37.tbrcED_Item( '35107' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35108' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35108' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29850' ) ) then
		CONFEXME_37.tbrcED_Item( '35108' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29850' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35108' ).itemcodi,
		'CUPON',
		CONFEXME_37.tbrcED_Item( '35108' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35108' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35108' ).itemgren,
		NULL,
		1,
		'<CUPON>',
		'</CUPON>',
		CONFEXME_37.tbrcED_Item( '35108' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35109' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35109' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29851' ) ) then
		CONFEXME_37.tbrcED_Item( '35109' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29851' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35109' ).itemcodi,
		'VALOR',
		CONFEXME_37.tbrcED_Item( '35109' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35109' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35109' ).itemgren,
		NULL,
		1,
		'<VALOR>',
		'</VALOR>',
		CONFEXME_37.tbrcED_Item( '35109' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35110' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35110' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29852' ) ) then
		CONFEXME_37.tbrcED_Item( '35110' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29852' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35110' ).itemcodi,
		'VALIDOHASTA',
		CONFEXME_37.tbrcED_Item( '35110' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35110' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35110' ).itemgren,
		NULL,
		1,
		'<VALIDOHASTA>',
		'</VALIDOHASTA>',
		CONFEXME_37.tbrcED_Item( '35110' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35111' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35111' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29853' ) ) then
		CONFEXME_37.tbrcED_Item( '35111' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29853' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35111' ).itemcodi,
		'TIPO_SOL',
		CONFEXME_37.tbrcED_Item( '35111' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35111' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35111' ).itemgren,
		NULL,
		1,
		'<TIPO_SOL>',
		'</TIPO_SOL>',
		CONFEXME_37.tbrcED_Item( '35111' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEM;
	CONFEXME_37.tbrcED_Item( '35112' ).itemcodi := nuNextSeqValue;

	-- Se establece el nombre del objeto por defecto
	CONFEXME_37.tbrcED_Item( '35112' ).itemobna := NULL;

	-- Se asigna el grupo de entidad asociado al item
	if ( CONFEXME_37.tbrcED_AtriFuda.exists( '29854' ) ) then
		CONFEXME_37.tbrcED_Item( '35112' ).itematfd := CONFEXME_37.tbrcED_AtriFuda( '29854' ).atfdcodi;
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
		CONFEXME_37.tbrcED_Item( '35112' ).itemcodi,
		'CODIGODEBARRAS',
		CONFEXME_37.tbrcED_Item( '35112' ).itemceid,
		NULL,
		CONFEXME_37.tbrcED_Item( '35112' ).itemobna,
		0,
		NULL,
		NULL,
		CONFEXME_37.tbrcED_Item( '35112' ).itemgren,
		NULL,
		1,
		'<CODIGODEBARRAS>',
		'</CODIGODEBARRAS>',
		CONFEXME_37.tbrcED_Item( '35112' ).itematfd
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35076' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35076' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35101' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35076' ).itblitem := CONFEXME_37.tbrcED_Item( '35101' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35076' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35076' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35076' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35077' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35077' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6669' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35102' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35077' ).itblitem := CONFEXME_37.tbrcED_Item( '35102' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35077' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35077' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35077' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35078' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35078' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35103' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35078' ).itblitem := CONFEXME_37.tbrcED_Item( '35103' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35078' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35078' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35078' ).itblblfr,
		1
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35079' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35079' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35104' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35079' ).itblitem := CONFEXME_37.tbrcED_Item( '35104' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35079' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35079' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35079' ).itblblfr,
		2
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35080' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35080' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35105' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35080' ).itblitem := CONFEXME_37.tbrcED_Item( '35105' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35080' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35080' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35080' ).itblblfr,
		3
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35081' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35081' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35106' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35081' ).itblitem := CONFEXME_37.tbrcED_Item( '35106' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35081' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35081' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35081' ).itblblfr,
		4
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35082' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35082' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35107' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35082' ).itblitem := CONFEXME_37.tbrcED_Item( '35107' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35082' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35082' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35082' ).itblblfr,
		5
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35083' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35083' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35108' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35083' ).itblitem := CONFEXME_37.tbrcED_Item( '35108' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35083' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35083' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35083' ).itblblfr,
		6
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35084' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35084' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35109' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35084' ).itblitem := CONFEXME_37.tbrcED_Item( '35109' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35084' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35084' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35084' ).itblblfr,
		7
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35085' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35085' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35110' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35085' ).itblitem := CONFEXME_37.tbrcED_Item( '35110' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35085' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35085' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35085' ).itblblfr,
		8
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35086' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35086' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35111' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35086' ).itblitem := CONFEXME_37.tbrcED_Item( '35111' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35086' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35086' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35086' ).itblblfr,
		9
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

DECLARE

	-- Almacena el valor generado por una secuencia
	nuNextSeqValue      number;

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se genera un identificador para el item-bloque
	nuNextSeqValue := pkBOInsertMgr.NextED_ITEMBLOQ;
	CONFEXME_37.tbrcED_ItemBloq( '35087' ).itblcodi := nuNextSeqValue;

	-- Se asigna el bloque-franja
	CONFEXME_37.tbrcED_ItemBloq( '35087' ).itblblfr := CONFEXME_37.tbrcED_BloqFran( '6668' ).blfrcodi;

	-- Se asigna el item
	if ( CONFEXME_37.tbrcED_Item.exists( '35112' ) ) then
		CONFEXME_37.tbrcED_ItemBloq( '35087' ).itblitem := CONFEXME_37.tbrcED_Item( '35112' ).itemcodi;
	end if;

	INSERT INTO ED_ItemBloq
	(
		itblcodi,
		itblitem,
		itblblfr,
		itblorde
	)
	VALUES
	(
		CONFEXME_37.tbrcED_ItemBloq( '35087' ).itblcodi,
		CONFEXME_37.tbrcED_ItemBloq( '35087' ).itblitem,
		CONFEXME_37.tbrcED_ItemBloq( '35087' ).itblblfr,
		10
	);

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
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
			'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C5265706F727420786D6C6E733D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F73716C7365727665722F7265706F7274696E672F323030352F30312F7265706F7274646566696E6974696F6E2220786D6C6E733A72643D22687474703A2F2F736368656D61732E6D6963726F736F66742E636F6D2F53514C5365727665722F7265706F7274696E672F7265706F727464657369676E6572223E0D0A20203C44617461536F75726365733E0D0A202020203C44617461536F75726365204E616D653D2244756D6D7944617461536F75726365223E0D0A2020202020203C72643A44617461536F7572636549443E64653135386330622D373562662D343566632D383235632D3534313763356464653562343C2F72643A44617461536F7572636549443E0D0A2020202020203C436F6E6E656374696F6E50726F706572746965733E0D0A20202020202020203C4461746150726F76696465723E53514C3C2F4461746150726F76696465723E0D0A20202020202020203C436F6E6E656374537472696E67202F3E0D0A2020202020203C2F436F6E6E656374696F6E50726F706572746965733E0D0A202020203C2F44617461536F757263653E0D0A20203C2F44617461536F75726365733E0D0A20203C496E7465726163746976654865696768743E32392E37636D3C2F496E7465726163746976654865696768743E0D0A20203C72643A44726177477269643E747275653C2F72643A44726177477269643E0D0A20203C496E74657261637469766557696474683E3231636D3C2F496E74657261637469766557696474683E0D0A20203C72643A4772696453706163696E673E302E3235636D3C2F72643A4772696453706163696E673E0D0A20203C72643A536E6170546F477269643E747275653C2F72643A536E6170546F477269643E0D0A20203C52696768744D617267696E3E302E32636D3C2F52696768744D617267696E3E0D0A20203C4C6566744D617267696E3E302E32636D3C2F4C6566744D617267696E3E0D0A20203C426F74746F6D4D617267696E3E302E32636D3C2F426F74746F6D4D617267696E3E0D0A20203C72643A5265706F727449443E61313338396464612D626332392D343533652D383064382D6538623530326535343435653C2F72643A5265706F727449443E0D0A20203C456D626564646564496D616765733E0D0A202020203C456D626564646564496D616765204E616D653D226C6F676F5F67646F5F736C6F67616E5F616C7461223E0D0A2020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D455479'
		||	'70653E0D0A2020202020203C496D616765446174613E2F396A2F34414151536B5A4A5267414241514541594142674141442F34514267525868705A67414153556B7141416741414141434144454241674148414141414A67414141476D4842414142414141414C674141414141414141425161574E686332454141414D41414A414841415141414141774D6A497741714145414145414141444D41414141413641454141454141414351414141414141414141502F6241454D414367634843416347436767494341734B4367734F4742414F4451304F485255574552676A4879556B49683869495359724E79386D4B54517049534977515445304F54732B506A346C4C6B524A517A78494E7A302B4F2F2F6241454D424367734C4467304F484241514844736F496967374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F7A73374F2F2F4141424549414A41417A414D4249674143455145444551482F7841416641414142425145424151454241514141414141414141414141514944424155474277674A4367762F784143314541414341514D444167514442515545424141414158304241674D4142424546456945785151595455574548496E45554D6F47526F51676A5172484246564C523843517A596E4B4343516F574678675A4769556D4A7967704B6A51314E6A63344F547044524556475230684A536C4E5556565A5857466C615932526C5A6D646F6157707A6448563264336835656F4F456859614869496D4B6B704F556C5A61586D4A6D616F714F6B7061616E714B6D7173724F3074626133754C6D367773504578636248794D6E4B3074505531646258324E6E6134654C6A354F586D352B6A7036764879382F5431397666342B66722F7841416641514144415145424151454241514542414141414141414141514944424155474277674A4367762F78414331455141434151494542414D454277554542414142416E6341415149444551514649544547456B4652423246784579497967516755517047687363454A497A4E53384256696374454B46695130345358784678675A4769596E4B436B714E5459334F446B3651305246526B644953557054564656575631685A576D4E6B5A575A6E61476C7163335231646E64346558714367345346686F6549695971536B3553566C7065596D5A71696F36536C7071656F71617179733753317472653475627243773854467873664979637253303954563174665932647269342B546C3575666F36657279382F5431397666342B66722F3267414D41774541416845444551412F41505A4B4B4B4B414369696967416F6F6F6F'
		||	'414B4B4B4B414369696967416F6F6F6F414B4B4B4B410A4369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B4143697348565045304E6C346E3076516B494D31347861582F414745436E48346B6A394B3371707861536236695454436969697047464646464142525252514155555555414646464641425252525141555555554146464646414252525251415555555541464646464142566255622B4453394F754C2B3562624462786C32503037564C4C504843597737594D6A37462B762B52586D33786731347877573267777667796676376A4839306664483535503443744B4D5061543555524F584C4735353950346976626A78522F776B446E4E774C6754415A34414234583659347236463033554C6656644F6776375677304E77676454396533314853766D5776537642793678706567533273317730634E77323949434F5548666E746E307276783846476C7A785632756E6335614E546C65765539547437754B364D6E6B7476574E7470596443652B4B6D7242384A5371316A4C442F41424A4A6B6A32492F774472567656347548717572535533314F304B4B4B4B33414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F4135767862634D725773534D5151532B523250622B7465622B4B2F4475716174716B7571527A4C63764B42756A62355375426A41374563563376695A392B744B6E5A49312F7161683079794E2F6570442F41506D632B6772484C35536A587131764F3333484C5862625555634C345A3849334D456731485662523431552F75556465475039372F437576727654464759764B4B4B593859326B6359726C64613073574577654C506B796450396B2B6C656B36377153314D366C467856796A593337365A664C4F677972634F7639345632397663525855435477747552786B477650702B677265384A5854435361304A2B556A656F3944304E66504B74374847796F665A65766F32726E5453643449366569696976564E516F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B4B4B414369696967446A64652F354430762B367638414B746677784146745A5A79506D64396F2B672F2F4146316D2B4A346A46717953342B57574D632B34342F777256384D797131673857666D5279535059317A34527052715236387A2F4142324D4776337175613549474D6B44504139366F3633434A744A6D794F55473866685756346E31463750572F446B4162433346385133763868482F414C4E5778713867693071344A3770744834385631'
		||	'3872566E334E4A4E4E4E484454486B437462777047570A314E334852496A6E38534B78586263784E646C34633039724F7738325263537A2F41444548734F777235796D2F724F594F70485A50387445464F504C464931364B4B4B2B674C4369696967416F6F6F6F414B4B4B4B414369696967416F6F6F6F414B4B686D75375733594C506377784539413867582B64534A496B7142343356315051716369697744714B4B4B414369696967416F6F6F6F417A7462307A2B30724C616D424E4764795A372B6F726C624B2F754E4976506E5171792F4B364E786B5633645A657461686F6D6E72462F624D3176454A69566A4D772B38523248353179564D504E3150615558615858716E366B795365357A2F697034746168306E554C463930326E3330637278483732776B42754F2B4F44394B7565494E524E2F4B4C4379567051725A636F4D35507058515157466E626B4E446252496655494D314A4C4A46625179545346593434314C4F335141446B6D744B736131616B716261586F484C334F6630627732794F747A66714D6A6C597576346E2F43756B716E706D726166724E73626E5472754F3568446253385A34423950317135546F346147486A7952525155564162367A45766C473767456E39777944503556505731674369696967416F724D2F7743456B3054374E63584931533261473178357A724947456554675A78303571355A58317271567048643255367A7753444B534A30626E464E78613351726F6E6F6F6F7044436969696741726A766956346D757644756852705976356431654F59316B48564641795350666F5078727361347A346D2B473772583942696C73554D747A5A4F5845593675704743423739442B4662554F5832693574694B6C2B56324D2F54506839346474644969762F4142524E396F75726851306B747A636C46566D47646F4F526B2F57742F513762517644326B58376548572B33526F544D304545346C62646A6852365A7857425A654E2F43657461464459654B416B4D3841555332397A453243366A473459482B63317958687A5662335350432F694F393052634E396F6955534B75664C6A4A62356750792B6D61366E43704E506D62332B526C7A526A61332F424F35762F4865746154626939315077686357396B574161543751724D75656D514278566E5666694262573039685A36545953366E656168457330555373454156686B5A4A3738486A3272683963757447756642586E4A34693148564E556C52476C69653463704763677475546F414F6E50664658796E684338384F614C467175717470657177324B5044637837675175546A6B444235423936505977736D342F6E2F414D4F48504B396B7A7472627850504270463771506944535A644953'
		||	'30787730676B387A5039334866504834316A7638524C0A363373597457757644467A46704572414C632B6370594139474B6568726B7A652B4966466E67375672417532705136664B6B6B4E324979476E554535487563664E3631505A7A65463952384F51776170347A314F465245717A57556B6E436B667768647649424846436F52573636394C2F3139346337657A4F773158782F4442714E72706D6936664A7131356378435A5652776968534E773550747A57336F57706168715674492B6F36524A706B7362375247386766654D5A79434F31634871316834486A6773725674646D303355624F326A4D46333877636F5275584F42673848324E6258773238516174726C6C654A714C666159725A776B463573322B634F63353965675034316C4F6E465537785833332F3459714D6E7A57624E50785A3478742F444832614157736C3765335A784462786E42504F4D6B2F5534726750694A7256357153365442714F6B54365A6452796C396A754856314F426B4D506363697462346842744C386236447231776A4777695A566B634449516869542B687A2B465A66784D3852365A7273756C44544A786378775345764F716E5943324D4C6B3938444E6255494A4F445333767152556B326D6D7A754E5738596D3031684E44306E545A4E553145526835493063497351782F45782F7A794B71522B4C303172547462307137735A4E4F314B31744A544A62794D47794E703542485871507A726B3952746C3062346A58307572616E6661546133796C346232324F413263486154673863592F41567057566834626D7574563144546645563371326F4A7030786B615674774B6C64764A326A3271505A51555537644E39662B474B35704E6D6838482F2B52526D2F362B322F3942577133784A3176554A4E55302F7776706B3751506537544C49707753476261467A3663456D724877654950684762482F5032332F6F4B31562B4A576A333976712B6E2B4B745067616637467445794B4D6C6472626763656E4A426F5676724C7638413078612B79566A54672B464868654F3045553845383832506D6E615A67785071414F42576A71477261707045304F6C36503464754E525347425033356D574E414F674754315046553762347065464A724D5479337A57386D4D744138544667665467594E63314E346B2F7458786E64327575363764615070615268375249584D496C55344B6B734F6551632F7055714657546674467433755533424C335470744A3865726679616C5A336D6C79324F6F366641387A3237754348436A4A7766792F4F71756A2F4565585857746F3950385033557A764B4675575673706271546745746A6E6A6E466368704C326A654E74634E6E4C504C626E544A2F4B6B7548'
		||	'5A6E64664C487A5A626B673952375972717667356A2F0A684572676A4754654E6B2F38415772715571634975567533346B786E4A744B2F63774A622F5237337766347058533946476D744559784B776C4C2B622B384F447A3036483836752B476646326F615434497457745044747A65326C6D7266614C6E7A41696A35695474484A4F416554584F6153522F7769586A506B6666692F39474E585136423477306254666873326E586B2F6B33693238714C41796E4D75374F307232494F65767361316E4452713139562B5245587265397450314F706D2B49476A7865466F6465416B645A3238754F3341486D4754757634657456662B4538757450764C534C78426F45326C7758726259707A4D4A4144364D4230727A7158772F7163486750544E546147595152336A79757144356B52676F44342F344365666356304E31463450317543336A7650473270336D397835634572376D446E6A707434504E5A2B7870727A33376C63386D65725555324E504C6A564153646F4179657070316565644955555555415635394F7362703939785A57387A663370496C592F714B6B69746F49496A46444248484765714967412F49564A525475774B36616659784936523256756953666656596C4162363863306B6D6D32457171736C6A624F714443686F6C495565334657614B4C734C44596F6F34597848464773614C3056426744384B676254624235764F6578746D6C7A6E65596C4C666E69724E46463242586E734C4B35594E635763457848414D6B53746A3878553063615249493430564558674B6F77422B464F6F6F7577475378527A786D4F614E4A456271727143442B42714C2B7A3749524C44396A742F4C553556504B586144366759717852526467527A57384E78483563384D6371663358554D50794E4E68737253336A614F473168695268686C534D4B4439514B6D6F6F75774934594962644E6B454D6353357A7452516F7A2B4653555555674B6A61547072796559326E576A4F65647868556E3838564A4E59326C77554D3970424B553455764747322F54505370364B6432466949326C735A544B626549794D7530767347534F6D4D2B6C4C446277327962494959346C4A7A7452516F7A2B46535555585947564E62694C5530696A73554E6E4A47544F71514C686D7A3875654F652F4862725556686276637A797271576B777245726A37494768512B576D4F6E73654D2F6A57315256632B67724764484E6566326A654C4B6B6E325A647151714938672F4C6B74373835485773784C4F372B77327A57316844623337506D61647264426759626E676438446A727A6A3372704B4B464F33514C4349323546624247526E4247434B5769696F4746464646414252525251415555555541'
		||	'464646464142525252514155555555414646464641420A52525251415555555541464646464142525252514155555555414646464641482F396B3D3C2F496D616765446174613E0D0A202020203C2F456D626564646564496D6167653E0D0A20203C2F456D626564646564496D616765733E0D0A20203C5061676557696474683E32312E3539636D3C2F5061676557696474683E0D0A20203C44617461536574733E0D0A202020203C44617461536574204E616D653D224C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434C49454E5445223E0D0A202020202020202020203C446174614669656C643E434C49454E54453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224944454E54494649434143494F4E223E0D0A202020202020202020203C446174614669656C643E4944454E54494649434143494F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2250524F594543544F223E0D0A202020202020202020203C446174614669656C643E50524F594543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4E545241544F223E0D0A202020202020202020203C446174614669656C643E434F4E545241544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2244495250524F594543544F223E0D0A202020202020202020203C446174614669656C643E44495250524F594543544F3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64'
		||	'204E616D653D22534F4C494349545544223E0D0A202020202020202020203C446174614669656C643E534F4C4943495455443C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F4355504F4E223E0D0A202020202020202020203C446174614669656C643E5449504F4355504F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D224355504F4E223E0D0A202020202020202020203C446174614669656C643E4355504F4E3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C4F52223E0D0A202020202020202020203C446174614669656C643E56414C4F523C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D2256414C49444F4841535441223E0D0A202020202020202020203C446174614669656C643E56414C49444F48415354413C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D225449504F5F534F4C223E0D0A202020202020202020203C446174614669656C643E5449504F5F534F4C3C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22434F4449474F4445424152524153223E0D0A202020202020202020203C446174614669656C643E434F4449474F44454241525241533C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A'
		||	'20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4652414E4A414445504F5349544F3C2F72643A446174615365744E616D653E0D0A20202020202020203C72643A5461626C654E616D653E4C44435F424C4F5155454445504F5349544F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A202020203C44617461536574204E616D653D2245585452415F424152434F44455F223E0D0A2020202020203C4669656C64733E0D0A20202020202020203C4669656C64204E616D653D22434F4445223E0D0A202020202020202020203C446174614669656C643E434F44453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A20202020202020203C4669656C64204E616D653D22494D414745223E0D0A202020202020202020203C446174614669656C643E494D4147453C2F446174614669656C643E0D0A202020202020202020203C72643A547970654E616D653E53797374656D2E537472696E673C2F72643A547970654E616D653E0D0A20202020202020203C2F4669656C643E0D0A2020202020203C2F4669656C64733E0D0A2020202020203C51756572793E0D0A20202020202020203C44617461536F757263654E616D653E44756D6D7944617461536F757263653C2F44617461536F757263654E616D653E0D0A20202020202020203C436F6D6D616E6454657874202F3E0D0A20202020202020203C72643A55736547656E6572696344657369676E65723E747275653C2F72643A55736547656E6572696344657369676E65723E0D0A2020202020203C2F51756572793E0D0A2020202020203C72643A44617461536574496E666F3E0D0A20202020202020203C72643A446174615365744E616D653E4C44435F4652414E4A414445504F5349544F3C2F72643A446174615365744E616D653E0D'
		||	'0A20202020202020203C72643A5461626C654E616D653E45585452415F424152434F44455F3C2F72643A5461626C654E616D653E0D0A2020202020203C2F72643A44617461536574496E666F3E0D0A202020203C2F446174615365743E0D0A20203C2F44617461536574733E0D0A20203C436F6465202F3E0D0A20203C57696474683E32302E35636D3C2F57696474683E0D0A20203C426F64793E0D0A202020203C436F6C756D6E53706163696E673E31636D3C2F436F6C756D6E53706163696E673E0D0A202020203C5265706F72744974656D733E0D0A2020202020203C5461626C65204E616D653D227461626C6532223E0D0A20202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020202020203C446174615365744E616D653E4C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F3C2F446174615365744E616D653E0D0A20202020202020203C546F703E382E3735636D3C2F546F703E0D0A20202020202020203C57696474683E31392E3231303634636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C496D616765204E616D653D22696D61676534223E0D0A202020202020202020202020202020202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A202020202020202020202020202020202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A202020202020202020202020202020202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A202020202020202020202020202020202020202020203C5374796C65202F3E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E6C6F676F5F67646F5F736C6F67616E5F616C74613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F496D6167'
		||	'653E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E393C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7834223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C'
		||	'43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F5F534F4C2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E312E3331373433636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7835223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C654365'
		||	'6C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7836223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7837223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50'
		||	'616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7838223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36333C2F5A496E6465783E0D'
		||	'0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F7839223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D227465'
		||	'7874626F783130223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783131223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A20202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783132223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F'
		||	'78204E616D653D2274657874626F783331223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783338223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A'
		||	'202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3231393537636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783339223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A2020202020'
		||	'20202020202020202020202020202020203C56616C75653E47617365732064656C2043617269626520532E412E20452E532E502E0D0A3839302E3130312E3639312D323C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E343C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783430223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C546578744465636F726174696F6E3E4F7665726C696E653C2F546578744465636F726174696F6E3E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768'
		||	'743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5349205041474120434F4E20434845515545204553435249424120414C2052455350414C444F2044454C204D49534D4F205355204E4F4D4252452C20434F4449474F204445205245464552454E43494120592054454C45464F4E4F20444520434F4E544143544F0909090D0A0909090D0A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783431223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020'
		||	'20202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783438223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020202020'
		||	'2020202020202020203C56616C75653E4E6F2E204368657175653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783439223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43C3B36469676F2042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C'
		||	'5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783530223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F6D6272652042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783531223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C74'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F723C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3930313533636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783534223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E'
		||	'7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4CC3AD6E65617320646520456D657267656E6369613A0D0A3136340D0A3031383030303931353333343C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783535223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A20202020202020202020202020202020'
		||	'20202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436C69656E74653A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783536223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E'
		||	'674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434C49454E54452E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783537223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50'
		||	'616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4964656E7469666963616369C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783538223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020'
		||	'2020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214944454E54494649434143494F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783539223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020'
		||	'202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783630223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464'
		||	'696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783730223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C506164'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'64696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783733223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A20202020202020202020'
		||	'20202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783734223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572'
		||	'5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538303838636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783735223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020202020202020202020'
		||	'2020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4CC3AD6E656120646520536572766963696F20616C20436C69656E74653A0D0A363035333232373030303C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783739223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D'
		||	'3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F6E747261746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783830223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464'
		||	'696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313030223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33363C2F5A496E6465783E0D0A202020'
		||	'202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4469722E20436C69656E74653A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313031223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E'
		||	'67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732144495250524F594543544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783831223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67'
		||	'546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783838223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C5061646469'
		||	'6E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783839223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020202020'
		||	'2020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783930223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E675269'
		||	'6768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783938223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E675269'
		||	'6768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783939223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A20202020'
		||	'20202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E57686174734170703A0D0A2B353720363035333232373030303C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313130223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C'
		||	'2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5469706F20646520437570C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313131223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020'
		||	'203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F4355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313132223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E205265662E205061676F3A3C2F56616C75653E0D0A2020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313133223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A20202020202020202020202020202020202020'
		||	'2020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313034223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A2020202020202020202020'
		||	'20202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313035223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F'
		||	'5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313036223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A2020202020'
		||	'20202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313037223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F5061'
		||	'6464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313038223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C5061'
		||	'6464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313039223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A20202020202020202020202020202020'
		||	'2020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313230223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F7220612070616761723A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A2020202020'
		||	'20202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313231223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F726D61743E3D466F726D61744E756D626572284669656C64732156414C4F522E56616C7565293C2F466F726D61743E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A202020202020'
		||	'202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C4F522E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313232223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C69646F2068617374613A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A20202020202020'
		||	'2020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313233223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D46697273742846'
		||	'69656C64732156414C49444F48415354412E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313134223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313135223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752'
		||	'696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313136223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020'
		||	'2020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313137223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20436865717565733A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313138223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020'
		||	'202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313139223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E74'
		||	'53697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313033223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F783130333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A20202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313032223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F783130323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783737223E0D0A202020202020202020202020202020202020202020203C72643A4465666175'
		||	'6C744E616D653E74657874626F7837373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783736223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020'
		||	'203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313234223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313235223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020202020'
		||	'2020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313236223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020'
		||	'202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313237223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20456665637469766F3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F'
		||	'78204E616D653D2274657874626F78313238223E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E322E3938303839636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3535636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474'
		||	'683E332E3631393635636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3139333831636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E302E3633383736636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3335636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E36636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3237373533636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E352E3234393937636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A2020202020203C496D616765204E616D653D22696D61676532223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E31342E35636D3C2F546F703E0D0A20202020202020203C57696474683E31302E34636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A'
		||	'20202020202020203C4C6566743E352E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E32636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C496D616765204E616D653D22696D61676531223E0D0A20202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A20202020202020203C546F703E362E3235636D3C2F546F703E0D0A20202020202020203C57696474683E31302E34636D3C2F57696474683E0D0A20202020202020203C4D494D45547970653E696D6167652F706E673C2F4D494D45547970653E0D0A20202020202020203C536F757263653E44617461626173653C2F536F757263653E0D0A20202020202020203C5374796C65202F3E0D0A20202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A20202020202020203C4C6566743E352E35636D3C2F4C6566743E0D0A20202020202020203C4865696768743E312E32636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321494D4147452E56616C75652C202245585452415F424152434F44455F22293C2F56616C75653E0D0A2020202020203C2F496D6167653E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7833223E0D0A20202020202020203C546F703E31302E3336373733636D3C2F546F703E0D0A20202020202020203C57696474683E302E3639393734636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E5265643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020203C57726974696E674D6F64653E74622D726C3C2F57726974696E674D6F64653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E4772'
		||	'6F773E0D0A20202020202020203C4C6566743E31392E3535303236636D3C2F4C6566743E0D0A20202020202020203C4865696768743E332E3135383733636D3C2F4865696768743E0D0A20202020202020203C56616C75653E434C49454E54453C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7832223E0D0A20202020202020203C72643A44656661756C744E616D653E74657874626F78323C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E32636D3C2F546F703E0D0A20202020202020203C57696474683E302E3637333238636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C436F6C6F723E5265643C2F436F6C6F723E0D0A202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020203C57726974696E674D6F64653E74622D726C3C2F57726974696E674D6F64653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E31392E3537363732636D3C2F4C6566743E0D0A20202020202020203C4865696768743E322E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E42414E434F3C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D2274657874626F7831223E0D0A20202020202020203C546F703E31352E3735636D3C2F546F703E0D0A20202020202020203C57696474683E38636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E362E3735636D3C'
		||	'2F4C6566743E0D0A20202020202020203C4865696768743E302E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4449474F44454241525241532E56616C75652C20224C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C54657874626F78204E616D653D22434F4449474F4445424152524153223E0D0A20202020202020203C72643A44656661756C744E616D653E434F4449474F44454241525241533C2F72643A44656661756C744E616D653E0D0A20202020202020203C546F703E372E35636D3C2F546F703E0D0A20202020202020203C57696474683E38636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A20202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020203C4C6566743E37636D3C2F4C6566743E0D0A20202020202020203C4865696768743E302E3235636D3C2F4865696768743E0D0A20202020202020203C56616C75653E3D4669727374284669656C647321434F4449474F44454241525241532E56616C75652C20224C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F22293C2F56616C75653E0D0A2020202020203C2F54657874626F783E0D0A2020202020203C4C696E65204E616D653D226C696E6531223E0D0A20202020202020203C546F703E382E35636D3C2F546F703E0D0A20202020202020203C57696474683E31392E3735636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C426F726465725374796C653E0D0A2020202020202020202020203C44656661756C743E4461736865643C2F44656661756C743E0D0A202020202020202020203C2F426F726465725374796C653E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A20202020202020203C4865696768743E30636D3C2F4865696768743E0D0A2020202020203C2F4C696E653E0D0A2020202020203C5461626C65204E616D653D227461626C6531223E0D0A20202020202020203C446174615365744E616D653E4C44435F4652414E4A414445504F5349544F5F4C44435F424C4F5155454445504F5349544F3C2F446174615365744E'
		||	'616D653E0D0A20202020202020203C546F703E302E35636D3C2F546F703E0D0A20202020202020203C57696474683E31392E3232393734636D3C2F57696474683E0D0A20202020202020203C5374796C653E0D0A202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A20202020202020203C2F5374796C653E0D0A20202020202020203C4865616465723E0D0A202020202020202020203C5461626C65526F77733E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C496D616765204E616D653D22696D61676533223E0D0A202020202020202020202020202020202020202020203C53697A696E673E4669743C2F53697A696E673E0D0A202020202020202020202020202020202020202020203C4D494D45547970653E696D6167652F6A7065673C2F4D494D45547970653E0D0A202020202020202020202020202020202020202020203C536F757263653E456D6265646465643C2F536F757263653E0D0A202020202020202020202020202020202020202020203C5374796C65202F3E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C56616C75653E6C6F676F5F67646F5F736C6F67616E5F616C74613C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F496D6167653E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E393C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D225449504F5F534F4C223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E5449504F5F534F4C3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F7264'
		||	'6572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F5F534F4C2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E312E3331373433636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C'
		||	'65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783532223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783533223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7835333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E'
		||	'0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783631223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F506164'
		||	'64696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783632223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36333C2F5A496E6465783E0D0A2020202020202020'
		||	'20202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783638223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'2020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783639223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783731223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E'
		||	'674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E36303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783732223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35393C2F5A496E6465783E0D0A202020202020202020'
		||	'202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783738223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7837383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22'
		||	'74657874626F783931223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3870743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3231393537636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783832223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A202020202020'
		||	'2020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E47617365732064656C2043617269626520532E412E20452E532E502E0D0A3839302E3130312E3639312D323C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C436F6C5370616E3E343C2F436F6C5370616E3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783932223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E536F6C'
		||	'69643C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E536F6C69643C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E536F6C69643C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E536F6C69643C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C546578744465636F726174696F6E3E4F7665726C696E653C2F546578744465636F726174696F6E3E0D0A2020202020202020202020202020202020202020202020203C54657874416C69676E3E43656E7465723C2F54657874416C69676E3E0D0A2020202020202020202020202020202020202020202020203C566572746963616C416C69676E3E4D6964646C653C2F566572746963616C416C69676E3E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5349205041474120434F4E20434845515545204553435249424120414C2052455350414C444F2044454C204D49534D4F205355204E4F4D4252452C20434F4449474F204445205245464552454E43494120592054454C45464F4E4F20444520434F4E544143544F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A2020202020202020202020202020'
		||	'20203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783432223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783332223E0D'
		||	'0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833323C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E204368657175653C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783133223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A20202020202020202020202020202020202020'
		||	'20202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E43C3B36469676F2042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783134223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020'
		||	'202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F6D6272652042616E636F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783135223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020'
		||	'202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E35303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F723C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3930313533636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783833223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A20202020202020202020202020202020'
		||	'20202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4CC3AD6E65617320646520456D657267656E6369613A0D0A3136340D0A3031383030303931353333343C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783933223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F506164'
		||	'64696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436C69656E74653A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D22434C49454E5445223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434C49454E54453C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020'
		||	'202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434C49454E54452E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783633223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D'
		||	'0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4964656E7469666963616369C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224944454E54494649434143494F4E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4944454E54494649434143494F4E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C65'
		||	'3E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214944454E54494649434143494F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783433223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783333223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A202020'
		||	'20202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783136223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020'
		||	'202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783137223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831373C2F72643A44656661756C744E616D653E0D'
		||	'0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F7820'
		||	'4E616D653D2274657874626F783138223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E34303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020'
		||	'202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3538303838636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783834223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4CC3AD6E656120646520536572766963696F20616C20436C69656E74653A0D0A363035333232373030303C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A2020202020'
		||	'20202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783634223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E436F6E747261746F3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D'
		||	'653D22434F4E545241544F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E434F4E545241544F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C647321434F4E545241544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54'
		||	'657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783935223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4469722E20436C69656E74653A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A202020202020202020202020'
		||	'2020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2244495250524F594543544F223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E44495250524F594543544F3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669'
		||	'727374284669656C64732144495250524F594543544F2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783434223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A'
		||	'202020202020202020202020202020202020202020203C5A496E6465783E33343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783334223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020'
		||	'202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783139223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7831393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768'
		||	'743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783230223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020'
		||	'202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783231223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832313C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020'
		||	'202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E33303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783835223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		16000, 
		hextoraw
		(
			'6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E57686174734170703A0D0A2B353720363035333232373030303C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783936223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F'
		||	'50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E5469706F20646520437570C3B36E3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D225449504F4355504F4E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E5449504F4355504F4E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C4465'
		||	'6661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473215449504F4355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783636223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E'
		||	'3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E4E6F2E205265662E205061676F3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D224355504F4E223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E4355504F4E3C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020'
		||	'20202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C6473214355504F4E2E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783435223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C'
		||	'61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783335223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F72'
		||	'3E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783232223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832323C2F'
		||	'72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020'
		||	'202020202020203C54657874626F78204E616D653D2274657874626F783233223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832333C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F546162'
		||	'6C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783234223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E32303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A202020'
		||	'20202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783836223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020'
		||	'203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783937223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C6F7220612070616761723A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A20202020202020'
		||	'20202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C4F52223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C4F523C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C466F726D61743E3D466F726D61744E756D626572284669656C64732156414C4F522E56616C7565293C2F466F726D61743E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31373C2F5A496E6465783E0D0A20202020202020202020'
		||	'2020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C4F522E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783637223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E56616C69646F2068617374613A3C2F56616C75653E0D0A202020202020202020202020'
		||	'20202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2256414C49444F4841535441223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E56414C49444F48415354413C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F72646572436F6C6F723E0D0A20202020202020202020202020202020202020202020202020203C4C6566743E426C61636B3C2F4C6566743E0D0A20202020202020202020202020202020202020202020202020203C52696768743E426C61636B3C2F52696768743E0D0A20202020202020202020202020202020202020202020202020203C546F703E426C61636B3C2F546F703E0D0A20202020202020202020202020202020202020202020202020203C426F74746F6D3E426C61636B3C2F426F74746F6D3E0D0A2020202020202020202020202020202020202020202020203C2F426F72646572436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C65'
		||	'3E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E3D4669727374284669656C64732156414C49444F48415354412E56616C7565293C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783436223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F7274'
		)
	);

	dbms_lob.writeappend 
	(
		blContent , 
		11768, 
		hextoraw
		(
			'4974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783336223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783235223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E'
		||	'67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783236223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832363C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31313C2F'
		||	'5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20436865717565733A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783237223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E31303C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A2020202020202020'
		||	'20202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A2020202020202020202020203C5461626C65526F773E0D0A20202020202020202020202020203C5461626C6543656C6C733E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783837223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7838373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C436F6C6F723E477261793C2F436F6C6F723E0D0A2020202020202020202020202020202020202020202020203C466F6E745374796C653E4974616C69633C2F466F6E745374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3570743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E393C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C654365'
		||	'6C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313330223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F783133303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E383C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783635223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7836353C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F5061'
		||	'6464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E373C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F78313239223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F783132393C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E363C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A'
		||	'2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783934223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7839343C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E353C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783437223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7834373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F5061'
		||	'6464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E343C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783337223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833373C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E333C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A20202020202020202020'
		||	'2020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783238223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832383C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E323C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783239223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7832393C2F72643A44656661756C744E616D653E0D0A2020202020202020202020202020202020202020'
		||	'20203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C466F6E7453697A653E3670743C2F466F6E7453697A653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C5A496E6465783E313C2F5A496E6465783E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C75653E546F74616C20456665637469766F3A3C2F56616C75653E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A202020202020202020202020202020203C5461626C6543656C6C3E0D0A2020202020202020202020202020202020203C5265706F72744974656D733E0D0A20202020202020202020202020202020202020203C54657874626F78204E616D653D2274657874626F783330223E0D0A202020202020202020202020202020202020202020203C72643A44656661756C744E616D653E74657874626F7833303C2F72643A44656661756C744E616D653E0D0A202020202020202020202020202020202020202020203C5374796C653E0D0A2020202020202020202020202020202020202020202020203C426F726465725374796C653E0D0A20202020202020202020202020202020202020202020202020203C44656661756C743E536F6C69643C2F44656661756C743E0D0A2020202020202020202020'
		||	'202020202020202020202020203C2F426F726465725374796C653E0D0A2020202020202020202020202020202020202020202020203C50616464696E674C6566743E3270743C2F50616464696E674C6566743E0D0A2020202020202020202020202020202020202020202020203C50616464696E6752696768743E3270743C2F50616464696E6752696768743E0D0A2020202020202020202020202020202020202020202020203C50616464696E67546F703E3270743C2F50616464696E67546F703E0D0A2020202020202020202020202020202020202020202020203C50616464696E67426F74746F6D3E3270743C2F50616464696E67426F74746F6D3E0D0A202020202020202020202020202020202020202020203C2F5374796C653E0D0A202020202020202020202020202020202020202020203C43616E47726F773E747275653C2F43616E47726F773E0D0A202020202020202020202020202020202020202020203C56616C7565202F3E0D0A20202020202020202020202020202020202020203C2F54657874626F783E0D0A2020202020202020202020202020202020203C2F5265706F72744974656D733E0D0A202020202020202020202020202020203C2F5461626C6543656C6C3E0D0A20202020202020202020202020203C2F5461626C6543656C6C733E0D0A20202020202020202020202020203C4865696768743E302E3535373634636D3C2F4865696768743E0D0A2020202020202020202020203C2F5461626C65526F773E0D0A202020202020202020203C2F5461626C65526F77733E0D0A20202020202020203C2F4865616465723E0D0A20202020202020203C5461626C65436F6C756D6E733E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E33636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3535636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E332E3631393635636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A20202020'
		||	'20202020202020203C57696474683E332E3139333831636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E302E3633383736636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3335636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E35636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E36636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A202020202020202020203C5461626C65436F6C756D6E3E0D0A2020202020202020202020203C57696474683E312E3237373532636D3C2F57696474683E0D0A202020202020202020203C2F5461626C65436F6C756D6E3E0D0A20202020202020203C2F5461626C65436F6C756D6E733E0D0A20202020202020203C4865696768743E352E3234393937636D3C2F4865696768743E0D0A20202020202020203C4C6566743E302E3235636D3C2F4C6566743E0D0A2020202020203C2F5461626C653E0D0A202020203C2F5265706F72744974656D733E0D0A202020203C4865696768743E31372E3235636D3C2F4865696768743E0D0A20203C2F426F64793E0D0A20203C4C616E67756167653E65732D45533C2F4C616E67756167653E0D0A20203C546F704D617267696E3E302E32636D3C2F546F704D617267696E3E0D0A20203C506167654865696768743E32372E3934636D3C2F506167654865696768743E0D0A3C2F5265706F72743E'
		)
	);

	-- Se obtiene código de la plantilla con el identificador especificado
	open  CONFEXME_37.cuPlantilla( 101 );
	fetch CONFEXME_37.cuPlantilla into nuIdPlantill;
	close CONFEXME_37.cuPlantilla;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuIdPlantill is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_plantill  
		SET    plancont = blContent ,
		       plandesc = 'LDC_PLANTILLA_CUPON_PAGOS_2',
		       plannomb = 'LDC_PLANTILLA_CUPON_PAGOS_2',
		       planopen = 'N',
		       plansist = 99
		WHERE  plancodi = 101;
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
			101,
			blContent ,
			'LDC_PLANTILLA_CUPON_PAGOS_2',
			'LDC_PLANTILLA_CUPON_PAGOS_2',
			'N',
			99
		);
	--}
	end if;

		dbms_lob.freetemporary(blContent); 
EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
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
	if ( not CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	-- Se obtiene código del Extractor y mezcla con el identificador especificado
	open  CONFEXME_37.cuExtractAndMix( 37 );
	fetch CONFEXME_37.cuExtractAndMix into nuExtractAndMixId;
	close CONFEXME_37.cuExtractAndMix;

	-- Se verifica si existe un formato con el delimitador especificado, en cuyo caso se elimina
	if ( nuExtractAndMixId is not NULL ) then
	--{
		-- Se modifica el formato
		UPDATE ed_confexme  
		SET    coemdesc = 'LDC_PAGO_PARCIAL',
		       coeminic = NULL,
		       coempada = '<182>',
		       coempadi = 'LDC_PLANTILLA_CUPON_PAGOS_2',
		       coempame = NULL,
		       coemtido = 66,
		       coemvers = 0,
		       coemvige = 'S'
		WHERE  coemcodi = 37;
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
			37,
			'LDC_PAGO_PARCIAL',
			NULL,
			'<182>',
			'LDC_PLANTILLA_CUPON_PAGOS_2',
			NULL,
			66,
			0,
			'S'
		);
	--}
	end if;

EXCEPTION

	when OTHERS then
		CONFEXME_37.boProcessStatusOK := FALSE;
		ROLLBACK;
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( CONFEXME_37.boProcessStatusOK ) then
	--{
		-- No realiza nada
		return;
	--}
	end if;

	UT_Trace.Trace( '*********************** Borrando expresiones generadas *************************', 5 );
	CONFEXME_37.DeleteGeneratedExpressions;

EXCEPTION

	when OTHERS then
		UT_Trace.Trace( 'ERROR -> ' || sqlerrm, 5 );
		raise;
--}
END;
/

BEGIN
--{
	if ( not CONFEXME_37.boProcessStatusOK ) then
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
	UT_Trace.Trace( '********************** Borrando paquete CONFEXME_37 ***********************', 5 );
	SA_BOCreatePackages.DropPackage
	(
		'CONFEXME_37'
	);
--}
END;
/