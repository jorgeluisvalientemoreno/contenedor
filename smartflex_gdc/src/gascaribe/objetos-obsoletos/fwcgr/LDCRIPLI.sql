BEGIN
    SetSystemEnviroment;
END;
/

BEGIN
    sa_boCreatePackages.CreatePackage('LDCRIPLI_PACKAGE',
                                      'CREATE OR REPLACE PACKAGE LDCRIPLI_PACKAGE' || chr(10) ||
                                      'IS' || chr(10) ||
                                      '    blProcessStatus boolean := true;' || chr(10) ||
                                      '    type tyGE_STATEMENT_Id is table of GE_STATEMENT.STATEMENT_ID%type index by PLS_INTEGER;' || chr(10) ||
                                      '    tbGE_STATEMENT_Id tyGE_STATEMENT_Id;' || chr(10) ||
                                      '    tbOLD_GE_STATEMENT_Id tyGE_STATEMENT_Id;' || chr(10) ||
                                      '    type tyMAP_SETTINGS_Id is table of GE_MAP_PARAMETER.MAP_PARAMETER_ID%type index by PLS_INTEGER;' || chr(10) ||
                                      '    tbMAP_SETTINGS_Id tyMAP_SETTINGS_Id;' || chr(10) ||
                                      'END;');
END;
/

DECLARE
  nuErrorCode NUMBER;
  sbErrorMessage VARCHAR2(4000);
  clReportStatement     clob;
  xlReportStatement     xmltype;
  xlStatement xmltype;
  sbMapSettingsId varchar2(32);
  nuIndexStatement   number(2);
  nuExecutableId   number;
  nuReportStatement  ge_report_statement.statement_id%type;
  sbStatementId varchar2(100);
  CURSOR cuXMLStatement (nuExecutableId sa_executable.executable_id%type)
   IS
     SELECT report, statement_id
     FROM   ge_report_statement
     WHERE  executable_id = nuExecutableId;
BEGIN
  if not LDCRIPLI_PACKAGE.blProcessStatus then
    return;
  end if;
  nuExecutableId := null;
  BEGIN
    SELECT executable_id
    INTO nuExecutableId
    FROM sa_executable
    WHERE name = 'LDCRIPLI';
  EXCEPTION
    WHEN NO_DATA_FOUND then
    nuExecutableId := null;
  END;
  if ( nuExecutableId IS not null ) then
    open cuXMLStatement(nuExecutableId);
    loop
       FETCH cuXMLStatement INTO clReportStatement, nuReportStatement;
       Exit when cuXMLStatement%notfound;
       clReportStatement := replace (clReportStatement,'<Statement>','<Statement> <![CDATA[');
       clReportStatement := replace (clReportStatement,'</Statement>',']]></Statement>');
       xlReportStatement := xmltype(clReportStatement);
       nuIndexStatement := 1;
       if (xlReportStatement.extract('//StatementId') IS not null
          AND  xlReportStatement.existsnode('//StatementId') > 0 ) then
          xlStatement := xlReportStatement.extract('//StatementId');
          WHILE xlStatement.Existsnode('/StatementId[' || To_Char(nuIndexStatement) || ']') > 0
          LOOP
            sbStatementId:= xlStatement.extract('/StatementId[' || To_Char(nuIndexStatement) || ']/text()').getstringval();
            LDCRIPLI_PACKAGE.tbOLD_GE_STATEMENT_Id(nuIndexStatement) := sbStatementId;
            ut_trace.trace('Se adiciona para eliminar sentencia ['|| sbStatementId ||']', 1);
          nuIndexStatement := nuIndexStatement + 1;
          END loop;
       END if;
       IF( xlReportStatement.existsnode('//MapSettingsId') > 0
         AND xlReportStatement.extract('//MapSettingsId/text()') IS not null ) then
           sbMapSettingsId := xlReportStatement.extract('//MapSettingsId/text()').getstringval();
           DELETE FROM  ge_map_parameter WHERE  ge_map_parameter.map_parameter_id = sbMapSettingsId;
           ut_trace.trace('Se elimina mapsettings ['|| sbMapSettingsId ||']',1);
       END if;
    END loop;
  END if;
EXCEPTION
    WHEN others THEN
        LDCRIPLI_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/

DECLARE

sbStatement   varchar2(32767);
nuStatementId number;
seqStatementId number;

clWizard     clob := empty_clob ();
clColumns    clob := empty_clob ();
clListValues clob := empty_clob ();

BEGIN
    if not LDCRIPLI_PACKAGE.blProcessStatus then
        return;
    end if;
    seqStatementId := GE_BOSEQUENCE.NEXTGE_STATEMENT;
    LDCRIPLI_PACKAGE.tbGE_STATEMENT_Id(120032566):= seqStatementId;

    sbStatement := 'SELECT IP.IPLIMEDE ELEMEN_MED,
       IP.IPLIFECH FCHA_MSTRA,
       IP.IPLIHORA HORA_MSTRA,
       IP.IPLIDIRE DIR_MSTRA,
       IP.IPLIBARR BARR_MSTRA,
       IP.IPLIESTA ESTACION,
       IP.IPLILOCA LOCAL_MSTRA,
       IP.IPLICONCE CONCENTRACION,
       IP.IPLIPRES PRESION,
       IP.IPLITIOD TIPO_ODO,
       IP.IPLIMETO METODO,
       IP.IPLIREGU REGULADOR,
       IP.IPLILECT LECT_MSTRA,
       IP.ORDER_ID,
       PP.PRODUCT_ID COD_PRODUCT,
       PP.PRODUCT_STATUS_ID || '|| chr(39) ||'-'|| chr(39) ||' || PS.DESCRIPTION ESTADO_PROD,
       AB.ADDRESS_PARSED DIR_PROD,
       GL2.DESCRIPTION BARRIO,
       GL1.DESCRIPTION LOCALIDAD,
       TO_NUMBER(LEC.LEEMLETO) LECTURA,
       DACATEGORI.Fsbgetcatedesc(PP.CATEGORY_ID) CATEGORIA,
       IP.FLAG,
IP.UNIT_OPER,
trunc(IP.IPLIFECC) IPLIFECC
  FROM LDC_IPLI_IO IP
 INNER JOIN ELMESESU EM ON IP.IPLIMEDE = EM.EMSSCOEM
 INNER JOIN SERVSUSC SS ON EM.EMSSSESU = SS.SESUNUSE
 INNER JOIN SUSCRIPC SC ON SS.SESUSUSC = SC.SUSCCODI
 INNER JOIN PR_PRODUCT PP ON SC.SUSCCODI = PP.SUBSCRIPTION_ID
 INNER JOIN PS_PRODUCT_STATUS PS ON PP.PRODUCT_STATUS_ID = PS.PRODUCT_STATUS_ID
 INNER JOIN AB_ADDRESS AB ON PP.ADDRESS_ID = AB.ADDRESS_ID
 INNER JOIN GE_GEOGRA_LOCATION GL1 ON AB.GEOGRAP_LOCATION_ID = GL1.GEOGRAP_LOCATION_ID
 INNER JOIN GE_GEOGRA_LOCATION GL2 ON AB.NEIGHBORTHOOD_ID = GL2.GEOGRAP_LOCATION_ID
 INNER JOIN (SELECT LEEMELME, LEEMLETO
               FROM LECTELME A
              WHERE LEEMFELE = (SELECT MAX(LEEMFELE)
                                  FROM LECTELME B
                                 WHERE A.LEEMELME = B.LEEMELME)) LEC ON EM.EMSSELME = LEC.LEEMELME
 WHERE (TRUNC(SYSDATE) BETWEEN EMSSFEIN AND EMSSFERE)
   AND PP.PRODUCT_TYPE_ID = 7014';

    clColumns := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>ELEMEN_MED</Name>
    <Description>ELEMEN_MED</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>50</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FCHA_MSTRA</Name>
    <Description>FCHA_MSTRA</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>HORA_MSTRA</Name>
    <Description>HORA_MSTRA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIR_MSTRA</Name>
    <Description>DIR_MSTRA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>200</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>BARR_MSTRA</Name>
    <Description>BARR_MSTRA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTACION</Name>
    <Description>ESTACION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>50</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LOCAL_MSTRA</Name>
    <Description>LOCAL_MSTRA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>200</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONCENTRACION</Name>
    <Description>CONCENTRACION</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>4</Length>
    <Scale>2</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>PRESION</Name>
    <Description>PRESION</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>4</Length>
    <Scale>2</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_ODO</Name>
    <Description>TIPO_ODO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>METODO</Name>
    <Description>METODO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>REGULADOR</Name>
    <Description>REGULADOR</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>50</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECT_MSTRA</Name>
    <Description>LECT_MSTRA</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ORDER_ID</Name>
    <Description>Orden</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
    <Entity>LDC_IPLI_IO</Entity>
    <Column>ORDER_ID</Column>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_PRODUCT</Name>
    <Description>COD_PRODUCT</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_PROD</Name>
    <Description>ESTADO_PROD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>141</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIR_PROD</Name>
    <Description>DIR_PROD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>200</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>BARRIO</Name>
    <Description>BARRIO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LOCALIDAD</Name>
    <Description>LOCALIDAD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA</Name>
    <Description>LECTURA</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CATEGORIA</Name>
    <Description>CATEGORIA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FLAG</Name>
    <Description>Flag</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>1</Length>
    <Scale>0</Scale>
    <Entity>LDC_IPLI_IO</Entity>
    <Column>FLAG</Column>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>UNIT_OPER</Name>
    <Description>UNIDAD OPERATIVA</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>20</Length>
    <Scale>0</Scale>
    <Entity>LDC_IPLI_IO</Entity>
    <Column>UNIT_OPER</Column>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>IPLIFECC</Name>
    <Description>Fecha Creac. Reg.</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
    <Entity>LDC_IPLI_IO</Entity>
    <Column>IPLIFECC</Column>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>';

    ge_boFrameworkStatement.SaveStatement (LDCRIPLI_PACKAGE.tbGE_STATEMENT_Id(120032566),
                                           4,
                                           'Sentencia IPLI_IO',
                                           'Sentencia IPLI_IO',
                                           sbStatement,
                                           clWizard,
                                           clColumns,
                                           clListValues,
                                           false,
                                           nuStatementId);
EXCEPTION
    WHEN others THEN
        LDCRIPLI_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/

DECLARE

clReportComplete clob := empty_clob ();

clReport clob := empty_clob ();

nuExecutableId number;
nuMenuOptionId number;

BEGIN
    if not LDCRIPLI_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- SA_EXECUTABLE
 
    ge_boFrameworkReport.CheckReportExist ('LDCRIPLI');

    ge_boFrameworkReport.DeleteReportMenuOptions (ge_bocatalog.fnuGetIdSeqFromCatalog('LDCRIPLI','EXECUTABLE','sa_boexecutable.getNextId'));

    ge_boFrameworkReport.DeleteReportStatements (ge_bocatalog.fnuGetIdFromCatalog('LDCRIPLI','EXECUTABLE'));

    ge_boFrameworkReport.SaveReport (ge_bocatalog.fnuGetIdFromCatalog('LDCRIPLI','EXECUTABLE'), 4, 'LDCRIPLI', 'Reporte Indice de Presión y/o Odorización', false, nuExecutableId);

    GI_BOFrameWorkApplication.UpdatePathFileHelp (ge_bocatalog.fnuGetIdFromCatalog('LDCRIPLI','EXECUTABLE'), '');

    GI_BOFrameWorkApplication.UpdateDirectExecution (ge_bocatalog.fnuGetIdFromCatalog('LDCRIPLI','EXECUTABLE'), 'Y');

EXCEPTION
    WHEN others THEN
        LDCRIPLI_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/
DECLARE

clReportComplete clob := empty_clob ();

clReport clob := empty_clob ();

nuExecutableId number;
nuMenuOptionId number;

BEGIN
    if not LDCRIPLI_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- GE_REPORT_STATEMENT
 
    clReport := '<?xml version="1.0" encoding="utf-16"?>
<BaseReportStatement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Name>Sentencia IPLI_IO</Name>
  <Description>Sentencia IPLI_IO</Description>
  <Module>[4] ¿rdenes</Module>
  <ExecutableId xsi:type="xsd:string">'||ge_bocatalog.fnuGetIdFromCatalog('LDCRIPLI','EXECUTABLE')||'</ExecutableId>
  <StatementId xsi:type="xsd:long">'||LDCRIPLI_PACKAGE.tbGE_STATEMENT_Id(120032566)||'</StatementId>
  <Statement>SELECT IP.IPLIMEDE ELEMEN_MED,
       IP.IPLIFECH FCHA_MSTRA,
       IP.IPLIHORA HORA_MSTRA,
       IP.IPLIDIRE DIR_MSTRA,
       IP.IPLIBARR BARR_MSTRA,
       IP.IPLIESTA ESTACION,
       IP.IPLILOCA LOCAL_MSTRA,
       IP.IPLICONCE CONCENTRACION,
       IP.IPLIPRES PRESION,
       IP.IPLITIOD TIPO_ODO,
       IP.IPLIMETO METODO,
       IP.IPLIREGU REGULADOR,
       IP.IPLILECT LECT_MSTRA,
       IP.ORDER_ID,
       PP.PRODUCT_ID COD_PRODUCT,
       PP.PRODUCT_STATUS_ID || '|| chr(39) ||'-'|| chr(39) ||' || PS.DESCRIPTION ESTADO_PROD,
       AB.ADDRESS_PARSED DIR_PROD,
       GL2.DESCRIPTION BARRIO,' ||
'
       GL1.DESCRIPTION LOCALIDAD,
       TO_NUMBER(LEC.LEEMLETO) LECTURA,
       DACATEGORI.Fsbgetcatedesc(PP.CATEGORY_ID) CATEGORIA,
       IP.FLAG,
IP.UNIT_OPER,
trunc(IP.IPLIFECC) IPLIFECC
  FROM LDC_IPLI_IO IP
 INNER JOIN ELMESESU EM ON IP.IPLIMEDE = EM.EMSSCOEM
 INNER JOIN SERVSUSC SS ON EM.EMSSSESU = SS.SESUNUSE
 INNER JOIN SUSCRIPC SC ON SS.SESUSUSC = SC.SUSCCODI
 INNER JOIN PR_PRODUCT PP ON SC.SUSCCODI = PP.SUBSCRIPTION_ID
 INNER JOIN PS_PRODUCT_STATUS PS ON PP.PRODUCT_STATUS_ID = PS.PRODUCT_STATUS_ID
 INNER JOIN AB_ADDRESS AB ON PP.ADDRESS_ID = AB.ADDRESS_ID
 INNER JOIN GE_GEOGRA_LOCATION GL1 ON AB.GEOGRAP_LOCATION_ID = GL1.GEOGRAP_LOCATION_ID
 INNER JOIN GE_GEOGRA_LOCATION GL2 ON AB.NEIGHBORTHOOD_ID = GL2.GEOGRAP_LOCATION_ID
 INNER JOIN (SELECT LEEMELME, LEEMLETO
               FROM LECTELME A
              WHERE LEEMFELE = (SELECT MAX(LEEMFELE)
                                  FROM LECTELME B
                                 WHERE A.LEEMELME = B.LEEMELME)) LEC ON EM.EMSSEL' ||
'ME = LEC.LEEMELME
 WHERE (TRUNC(SYSDATE) BETWEEN EMSSFEIN AND EMSSFERE)
   AND PP.PRODUCT_TYPE_ID = 7014</Statement>
  <StatementColumns>
    <BaseStatementColumn>
      <Name>ELEMEN_MED</Name>
      <Description>ELEMEN_MED</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>50</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FCHA_MSTRA</Name>
      <Description>FCHA_MSTRA</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>HORA_MSTRA</Name>
      <Description>HORA_MSTRA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>10</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DIR_MSTRA</Name>
      <Description>DIR_MSTRA</Description>' ||
'
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>200</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>BARR_MSTRA</Name>
      <Description>BARR_MSTRA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTACION</Name>
      <Description>ESTACION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>50</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LOCAL_MSTRA</Name>
      <Description>LOCAL_MSTRA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>200</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CONCENTRACION</Name>
      <Description>' ||
'CONCENTRACION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>4</Length>
      <Scale>2</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>PRESION</Name>
      <Description>PRESION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>4</Length>
      <Scale>2</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>TIPO_ODO</Name>
      <Description>TIPO_ODO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>20</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>METODO</Name>
      <Description>METODO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>20</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>REGULADOR</Name>
   ' ||
'   <Description>REGULADOR</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>50</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECT_MSTRA</Name>
      <Description>LECT_MSTRA</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ORDER_ID</Name>
      <Description>Orden</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Entity>LDC_IPLI_IO</Entity>
      <Column>ORDER_ID</Column>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_PRODUCT</Name>
      <Description>COD_PRODUCT</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
  ' ||
'  </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO_PROD</Name>
      <Description>ESTADO_PROD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>141</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DIR_PROD</Name>
      <Description>DIR_PROD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>200</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>BARRIO</Name>
      <Description>BARRIO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LOCALIDAD</Name>
      <Description>LOCALIDAD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>' ||
'0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA</Name>
      <Description>LECTURA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CATEGORIA</Name>
      <Description>CATEGORIA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FLAG</Name>
      <Description>Flag</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>1</Length>
      <Scale>0</Scale>
      <Entity>LDC_IPLI_IO</Entity>
      <Column>FLAG</Column>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>UNIT_OPER</Name>
      <Description>UNIDAD OPERATIVA</Description>
      <DisplayType>2</DisplayType>' ||
'
      <InternalType>2</InternalType>
      <Length>20</Length>
      <Scale>0</Scale>
      <Entity>LDC_IPLI_IO</Entity>
      <Column>UNIT_OPER</Column>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>IPLIFECC</Name>
      <Description>Fecha Creac. Reg.</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
      <Entity>LDC_IPLI_IO</Entity>
      <Column>IPLIFECC</Column>
    </BaseStatementColumn>
  </StatementColumns>
  <ReportColumns>
    <BaseReportColumn>
      <Name>ELEMEN_MED</Name>
      <Description>ELEMEN_MED</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>50</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
  ' ||
'  <BaseReportColumn>
      <Name>FCHA_MSTRA</Name>
      <Description>FCHA_MSTRA</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>HORA_MSTRA</Name>
      <Description>HORA_MSTRA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>10</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DIR_MSTRA</Name>
      <Description>DIR_MSTRA</Description>
      <DisplayType>2</DisplayType>' ||
'
      <InternalType>2</InternalType>
      <Length>200</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>BARR_MSTRA</Name>
      <Description>BARR_MSTRA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTACION</Name>
      <Description>ESTACION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>50</Length>
      <Scale>0</Scale>
      <Required>false</Required>' ||
'
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LOCAL_MSTRA</Name>
      <Description>LOCAL_MSTRA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>200</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONCENTRACION</Name>
      <Description>CONCENTRACION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>4</Length>
      <Scale>2</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
     ' ||
' <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>PRESION</Name>
      <Description>PRESION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>4</Length>
      <Scale>2</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>TIPO_ODO</Name>
      <Description>TIPO_ODO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>20</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>METODO</Name>
      <Description>' ||
'METODO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>20</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>REGULADOR</Name>
      <Description>REGULADOR</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>50</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LECT_MSTRA</Name>
      <Description>LECT_MSTRA</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
 ' ||
'     <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ORDER_ID</Name>
      <Description>Orden</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_PRODUCT</Name>
      <Description>COD_PRODUCT</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>' ||
'
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_PROD</Name>
      <Description>ESTADO_PROD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>141</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DIR_PROD</Name>
      <Description>DIR_PROD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>200</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>' ||
'
      <Name>BARRIO</Name>
      <Description>BARRIO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LOCALIDAD</Name>
      <Description>LOCALIDAD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LECTURA</Name>
      <Description>LECTURA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>' ||
'1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CATEGORIA</Name>
      <Description>CATEGORIA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FLAG</Name>
      <Description>Flag</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>1</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>' ||
'
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>UNIT_OPER</Name>
      <Description>UNIDAD OPERATIVA</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>20</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>IPLIFECC</Name>
      <Description>Fecha Creac. Reg.</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>' ||
'
    </BaseReportColumn>
  </ReportColumns>
  <MapSettingsId xsi:nil="true" />
</BaseReportStatement>';

    ge_boFrameworkReport.SaveReportStatement (ge_bocatalog.fnuGetIdFromCatalog('LDCRIPLI','EXECUTABLE'), LDCRIPLI_PACKAGE.tbGE_STATEMENT_Id(120032566), 'Sentencia IPLI_IO', 'Sentencia IPLI_IO', clReport);


EXCEPTION
    WHEN others THEN
        LDCRIPLI_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/
declare
  nuIndexStatement PLS_INTEGER;
BEGIN
    if not LDCRIPLI_PACKAGE.blProcessStatus then
      return;
    END if;
    nuIndexStatement := LDCRIPLI_PACKAGE.tbOLD_GE_STATEMENT_Id.first;
    while (nuIndexStatement IS not null)
    loop
       DELETE FROM ge_statement_columns WHERE statement_id = LDCRIPLI_PACKAGE.tbOLD_GE_STATEMENT_Id(nuIndexStatement);
       DELETE FROM ge_statement WHERE statement_id = LDCRIPLI_PACKAGE.tbOLD_GE_STATEMENT_Id(nuIndexStatement);
       nuIndexStatement := LDCRIPLI_PACKAGE.tbOLD_GE_STATEMENT_Id.next(nuIndexStatement);
    END loop;
END;
/
BEGIN
  if not LDCRIPLI_PACKAGE.blProcessStatus then
    return;
  end if;
    commit;

EXCEPTION
    WHEN others THEN
        LDCRIPLI_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/

BEGIN
    sa_boCreatePackages.DropPackage ('LDCRIPLI_PACKAGE');
END;
/

