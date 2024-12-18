BEGIN
    SetSystemEnviroment;
END;
/

BEGIN
    sa_boCreatePackages.CreatePackage('GOPC_PACKAGE',
                                      'CREATE OR REPLACE PACKAGE GOPC_PACKAGE' || chr(10) ||
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
  if not GOPC_PACKAGE.blProcessStatus then
    return;
  end if;
  nuExecutableId := null;
  BEGIN
    SELECT executable_id
    INTO nuExecutableId
    FROM sa_executable
    WHERE name = 'GOPC';
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
            GOPC_PACKAGE.tbOLD_GE_STATEMENT_Id(nuIndexStatement) := sbStatementId;
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
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;
    seqStatementId := GE_BOSEQUENCE.NEXTGE_STATEMENT;
    GOPC_PACKAGE.tbGE_STATEMENT_Id(120197929):= seqStatementId;

    sbStatement := 'select /*+ INDEX (LP PK_PROCESO) INDEX (CICLO UX_CICLO03)*/
DISTINCT LP.proceso_id CODIGO_PROCESO,
         lp.proceso_descripcion NOMBRE_PROCESO,
         LCC.CICLCODI Ciclo,
         CICLDESC Descripcion_Ciclo,
         LCC.PRODUCT_ID Producto,
         servsusc.SESUESCO CODIGO_ESTADO_CORTE,
         (SELECT ESTC.ESCODESC FROM ESTACORT ESTC WHERE ESTC.ESCOCODI = servsusc.SESUESCO) ESTADO_CORTE,
         SUBSCRIBER_NAME || '|| chr(39) ||' '|| chr(39) ||' || SUBS_LAST_NAME Nombre,
         OPEN.DALD_PARAMETER.fnuGetNumeric_Value('|| chr(39) ||'COD_ACT_SUSP_CM_PER_CART'|| chr(39) ||',
                                                 NULL) ACTIVIDAD_DESTINO,
         a.description DESCRIPCION_DESTINO,
(SELECT G.GEO_LOCA_FATHER_ID FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Cod_departamento,
         (SELECT G2.DESCRIPTION FROM GE_GEOGRA_LOCATION G, GE_GEOGRA_LOCATION G2 WHERE G2.GEOGRAP_LOCATION_ID = G.GEO_LOCA_FATHER_ID AND G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Departamento,
         open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID) Cod_localidad,
         (SELECT G.DESCRIPTION FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Localidad
  from LDC_CONSUMO_CERO LCC,
       ciclo,
       servsusc,
       suscripc,
       ge_subscriber,
       ldc_proceso      lp,
       ge_items         a,
       pr_product pr
 where CICLCICO = LCC.CICLCODI
   and SESUNUSE = LCC.PRODUCT_ID
   and SESUSUSC = SUSCCODI
   and SUBSCRIBER_ID = SUSCCLIE
   and pr.PRODUCT_ID = SESUNUSE
   and LCC.PRODUCT_ID is not null
   and 1 = (select count(1)
              from LDC_SUSP_PERSECUCION LSP
             where lcc.product_id = SUSP_PERSEC_PRODUCTO)
   and lp.proceso_id = lcc.proceso_id
   and a.items_id =
       OPEN.DALD_PARAMETER.fnuGetNumeric_Value('|| chr(39) ||'COD_ACT_SUSP_CM_PER_CART'|| chr(39) ||',
                                               NULL)';

    clColumns := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CODIGO_PROCESO</Name>
    <Description>CODIGO_PROCESO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE_PROCESO</Name>
    <Description>NOMBRE_PROCESO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CICLO</Name>
    <Description>CICLO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_CICLO</Name>
    <Description>DESCRIPCION_CICLO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>PRODUCTO</Name>
    <Description>PRODUCTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CODIGO_ESTADO_CORTE</Name>
    <Description>CODIGO_ESTADO_CORTE</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_CORTE</Name>
    <Description>ESTADO_CORTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE</Name>
    <Description>NOMBRE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ACTIVIDAD_DESTINO</Name>
    <Description>ACTIVIDAD_DESTINO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_DESTINO</Name>
    <Description>DESCRIPCION_DESTINO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_DEPARTAMENTO</Name>
    <Description>COD_DEPARTAMENTO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DEPARTAMENTO</Name>
    <Description>DEPARTAMENTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_LOCALIDAD</Name>
    <Description>COD_LOCALIDAD</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LOCALIDAD</Name>
    <Description>LOCALIDAD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>';

    ge_boFrameworkStatement.SaveStatement (GOPC_PACKAGE.tbGE_STATEMENT_Id(120197929),
                                           21,
                                           'LDC - CONSULTA CONSUMO CERO',
                                           'LDC - CONSULTA CONSUMO CERO',
                                           sbStatement,
                                           clWizard,
                                           clColumns,
                                           clListValues,
                                           false,
                                           nuStatementId);
EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;
    seqStatementId := GE_BOSEQUENCE.NEXTGE_STATEMENT;
    GOPC_PACKAGE.tbGE_STATEMENT_Id(120197930):= seqStatementId;

    sbStatement := 'select /*+ INDEX (LDC_SUSP_PERSECUCION IDX_LDC_SUSP_PERSECUCION01,IDX_LDC_SUSP_PERSECUCION02) INDEX (LP PK_PROCESO) INDEX (CICLO UX_CICLO03)*/
DISTINCT LP.proceso_id CODIGO_PROCESO,
         lp.proceso_descripcion NOMBRE_PROCESO,
         SUSP_PERSEC_CICLCODI Ciclo,
         CICLDESC Descripcion_Ciclo,
         SUSP_PERSEC_PRODUCTO Producto,
         servsusc.SESUESCO CODIGO_ESTADO_CORTE,
         (SELECT ESTC.ESCODESC FROM ESTACORT ESTC WHERE ESTC.ESCOCODI = servsusc.SESUESCO) ESTADO_CORTE,
         SUBSCRIBER_NAME || '|| chr(39) ||' '|| chr(39) ||' || SUBS_LAST_NAME Nombre,
         SUSP_PERSEC_SALPEND Saldo,
         gc_bodebtmanagement.fnugetexpirdebtbyprod(SUSP_PERSEC_PRODUCTO) CARTERA_VENCIDA,
         (select round(MONTHS_BETWEEN(TO_DATE(sysdate),
                                      max(pps.register_date)))
            from pr_prod_suspension pps
           where pps.product_id = SUSP_PERSEC_PRODUCTO) MESES_SUSPENCION,
         SUSP_PERSEC_CONSUMO Consumo,
         SUSP_PERSEC_ACT_ORIG Actividad_Origen,
         b.DESCRIPTION Descripcion_Origen,
         SUSP_PERSEC_ACTIVID Actividad_Destino,
         a.DESCRIPTION Descripcion_Destino,
         SUSP_PERSEC_PERVARI Numero_Periodos,
         SUSP_PERSEC_PERSEC Flag_Persecucion,
         ldc_Reportesconsulta.fsbEstadoFinancieroProducto(SUSP_PERSEC_PRODUCTO) Estado_Financiero,
         SUSP_PERSEC_FEJPROC Fecha_Proceso,
         SUSP_PERSEC_CODI CONSECUTIVO,
         (SELECT count(*)
            FROM cuencobr
           WHERE cucosacu > 0
             AND cuconuse = SUSP_PERSEC_PRODUCTO) CUENTAS_CON_SALDO,
         sesucate USO,
         (select c.catedesc from categori c where c.catecodi = sesucate) DESCRIPCION_USO,
         (SELECT max(leemleto)
            FROM pr_product, lectelme
           WHERE product_id = leemsesu
             AND leemdocu = suspen_ord_Act_id
             AND leemclec <> '|| chr(39) ||'F'|| chr(39) ||'
             AND product_id = SUSP_PERSEC_PRODUCTO) LECTURA_ULTIMA_SUSPENSION,
         (SELECT max(leemleto)
            FROM lectelme
           WHERE leemsesu = sesunuse
             AND leemclec = '|| chr(39) ||'F'|| chr(39) ||'
             and lectelme.leemfele in
                 (SELECT max(lectelme.leemfele)
                    FROM lectelme
                   WHERE leemsesu = sesunuse
                     AND leemclec = '|| chr(39) ||'F'|| chr(39) ||')) ULTIMA_LECTURA_FACTURACION,
         (SELECT G.GEO_LOCA_FATHER_ID FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Cod_departamento,
         (SELECT G2.DESCRIPTION FROM GE_GEOGRA_LOCATION G, GE_GEOGRA_LOCATION G2 WHERE G2.GEOGRAP_LOCATION_ID = G.GEO_LOCA_FATHER_ID AND G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Departamento,
         open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID) Cod_localidad,
         (SELECT G.DESCRIPTION FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Localidad
  from LDC_SUSP_PERSECUCION,
       ge_items              a,
       ge_items              b,
       ciclo,
       servsusc,
       suscripc,
       ge_subscriber,
       ldc_proceso           lp,
       ldc_proceso_actividad lpa,
       pr_product            pr
 where a.ITEMS_ID = SUSP_PERSEC_ACTIVID
   and b.ITEMS_ID = SUSP_PERSEC_ACT_ORIG
   and CICLCICO = SUSP_PERSEC_CICLCODI
   and SESUNUSE = SUSP_PERSEC_PRODUCTO
   and SESUSUSC = SUSCCODI
   and SUBSCRIBER_ID = SUSCCLIE
   and pr.PRODUCT_ID = SESUNUSE
   and SUSP_PERSEC_ORDER_ID is null
   and 0 = (select count(1)
              from ldc_consumo_cero lcc
             where lcc.proceso_id = lp.proceso_id
               and lcc.product_id = SUSP_PERSEC_PRODUCTO)
   and lp.proceso_id = lpa.proceso_id
   and (B.ITEMS_ID = lpa.activity_id OR A.ITEMS_ID = lpa.activity_id)';

    clColumns := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CODIGO_PROCESO</Name>
    <Description>CODIGO_PROCESO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE_PROCESO</Name>
    <Description>NOMBRE_PROCESO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CICLO</Name>
    <Description>CICLO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_CICLO</Name>
    <Description>DESCRIPCION_CICLO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>PRODUCTO</Name>
    <Description>PRODUCTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CODIGO_ESTADO_CORTE</Name>
    <Description>CODIGO_ESTADO_CORTE</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_CORTE</Name>
    <Description>ESTADO_CORTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>40</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE</Name>
    <Description>NOMBRE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>SALDO</Name>
    <Description>SALDO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CARTERA_VENCIDA</Name>
    <Description>CARTERA_VENCIDA</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MESES_SUSPENCION</Name>
    <Description>MESES_SUSPENCION</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONSUMO</Name>
    <Description>CONSUMO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>9</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ACTIVIDAD_ORIGEN</Name>
    <Description>ACTIVIDAD_ORIGEN</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_ORIGEN</Name>
    <Description>DESCRIPCION_ORIGEN</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ACTIVIDAD_DESTINO</Name>
    <Description>ACTIVIDAD_DESTINO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_DESTINO</Name>
    <Description>DESCRIPCION_DESTINO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NUMERO_PERIODOS</Name>
    <Description>NUMERO_PERIODOS</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FLAG_PERSECUCION</Name>
    <Description>FLAG_PERSECUCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_FINANCIERO</Name>
    <Description>ESTADO_FINANCIERO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_PROCESO</Name>
    <Description>FECHA_PROCESO</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONSECUTIVO</Name>
    <Description>CONSECUTIVO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CUENTAS_CON_SALDO</Name>
    <Description>CUENTAS_CON_SALDO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>USO</Name>
    <Description>USO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_USO</Name>
    <Description>DESCRIPCION_USO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_ULTIMA_SUSPENSION</Name>
    <Description>LECTURA_ULTIMA_SUSPENSION</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ULTIMA_LECTURA_FACTURACION</Name>
    <Description>ULTIMA_LECTURA_FACTURACION</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_DEPARTAMENTO</Name>
    <Description>COD_DEPARTAMENTO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DEPARTAMENTO</Name>
    <Description>DEPARTAMENTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_LOCALIDAD</Name>
    <Description>COD_LOCALIDAD</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>30</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LOCALIDAD</Name>
    <Description>LOCALIDAD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>';

    ge_boFrameworkStatement.SaveStatement (GOPC_PACKAGE.tbGE_STATEMENT_Id(120197930),
                                           21,
                                           'LDC - CONSULTA LDC_SUSP_PERSECUCION1',
                                           'LDC - CONSULTA LDC_SUSP_PERSECUCION1',
                                           sbStatement,
                                           clWizard,
                                           clColumns,
                                           clListValues,
                                           false,
                                           nuStatementId);
EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;
    seqStatementId := GE_BOSEQUENCE.NEXTGE_STATEMENT;
    GOPC_PACKAGE.tbGE_STATEMENT_Id(120197916):= seqStatementId;

    sbStatement := 'select codigo_proceso,
       nombre_proceso,
       ciclo,
       descripcion_ciclo,
       producto,
       codigo_estado_corte,
       estado_corte,
       nombre,
       contrato,
       estado_producto,
       cod_direccion,
       direccion,
       uso,
       descripcion_uso,
       cod_departamento,
       departamento,
       cod_localidad,
       localidad,
       estado_financiero,
       saldo,
       cartera_vencida,
       consumo,
       lectura_actual,
       lectura_anterior,
       lectura_suspension,
       fecha_suspension,
       tipo_trab_suspension,
       orden_suspension,
       meses_suspension,
       tipo_suspen_producto,
       marca_producto,
       multifamiliar,
       fecha_maximo_susp,
       actividad_origen,
       descripcion_origen,
       actividad_destino,
       descripcion_destino,
       numero_periodos,
       flag_persecucion,
       fecha_proceso,
       consecutivo,
       Cuentas_con_saldos,
       Defectos_no_reparables
  from vw_consulta_autoreconectados';

    clColumns := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CODIGO_PROCESO</Name>
    <Description>CODIGO_PROCESO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE_PROCESO</Name>
    <Description>NOMBRE_PROCESO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CICLO</Name>
    <Description>CICLO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_CICLO</Name>
    <Description>DESCRIPCION_CICLO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>PRODUCTO</Name>
    <Description>PRODUCTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CODIGO_ESTADO_CORTE</Name>
    <Description>CODIGO_ESTADO_CORTE</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_CORTE</Name>
    <Description>ESTADO_CORTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>40</Length>
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
    <Name>CONTRATO</Name>
    <Description>CONTRATO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_PRODUCTO</Name>
    <Description>ESTADO_PRODUCTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_DIRECCION</Name>
    <Description>COD_DIRECCION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIRECCION</Name>
    <Description>DIRECCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>USO</Name>
    <Description>USO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_USO</Name>
    <Description>DESCRIPCION_USO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_DEPARTAMENTO</Name>
    <Description>COD_DEPARTAMENTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>6</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DEPARTAMENTO</Name>
    <Description>DEPARTAMENTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_LOCALIDAD</Name>
    <Description>COD_LOCALIDAD</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>6</Length>
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
    <Name>ESTADO_FINANCIERO</Name>
    <Description>ESTADO_FINANCIERO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>SALDO</Name>
    <Description>SALDO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CARTERA_VENCIDA</Name>
    <Description>CARTERA_VENCIDA</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONSUMO</Name>
    <Description>CONSUMO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>9</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_ACTUAL</Name>
    <Description>LECTURA_ACTUAL</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_ANTERIOR</Name>
    <Description>LECTURA_ANTERIOR</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_SUSPENSION</Name>
    <Description>LECTURA_SUSPENSION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_SUSPENSION</Name>
    <Description>FECHA_SUSPENSION</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_TRAB_SUSPENSION</Name>
    <Description>TIPO_TRAB_SUSPENSION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ORDEN_SUSPENSION</Name>
    <Description>ORDEN_SUSPENSION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MESES_SUSPENSION</Name>
    <Description>MESES_SUSPENSION</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_SUSPEN_PRODUCTO</Name>
    <Description>TIPO_SUSPEN_PRODUCTO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MARCA_PRODUCTO</Name>
    <Description>MARCA_PRODUCTO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MULTIFAMILIAR</Name>
    <Description>MULTIFAMILIAR</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_MAXIMO_SUSP</Name>
    <Description>FECHA_MAXIMO_SUSP</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ACTIVIDAD_ORIGEN</Name>
    <Description>ACTIVIDAD_ORIGEN</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_ORIGEN</Name>
    <Description>DESCRIPCION_ORIGEN</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ACTIVIDAD_DESTINO</Name>
    <Description>ACTIVIDAD_DESTINO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_DESTINO</Name>
    <Description>DESCRIPCION_DESTINO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NUMERO_PERIODOS</Name>
    <Description>NUMERO_PERIODOS</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FLAG_PERSECUCION</Name>
    <Description>FLAG_PERSECUCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_PROCESO</Name>
    <Description>FECHA_PROCESO</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONSECUTIVO</Name>
    <Description>CONSECUTIVO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CUENTAS_CON_SALDOS</Name>
    <Description>CUENTAS_CON_SALDOS</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DEFECTOS_NO_REPARABLES</Name>
    <Description>DEFECTOS_NO_REPARABLES</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>1</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>';

    ge_boFrameworkStatement.SaveStatement (GOPC_PACKAGE.tbGE_STATEMENT_Id(120197916),
                                           21,
                                           'LDC_CONSULTA_AUTORECONECTADOS_RP_',
                                           'Reporte de Autoreconectado',
                                           sbStatement,
                                           clWizard,
                                           clColumns,
                                           clListValues,
                                           false,
                                           nuStatementId);
EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;
    seqStatementId := GE_BOSEQUENCE.NEXTGE_STATEMENT;
    GOPC_PACKAGE.tbGE_STATEMENT_Id(120197932):= seqStatementId;

    sbStatement := 'SELECT saresesu producto,
       SARECONT contrato,
       sarecicl ciclo,
       (SELECT subscriber_name || '|| chr(39) ||' '|| chr(39) ||' || subs_last_name FROM ge_subscriber WHERE subscriber_id = sareclie) nombre,
       SAREDEPA || '|| chr(39) ||'-'|| chr(39) ||'||dage_geogra_location.fsbGetDescription( SAREDEPA ) departamento,
       SARELOCA || '|| chr(39) ||'-'|| chr(39) ||'||dage_geogra_location.fsbGetDescription( SARELOCA ) Localidad,
       SAREDIRE ||'|| chr(39) ||'-'|| chr(39) ||'||daab_address.fsbgetaddress_parsed(SAREDIRE,null) direccion,
       SAREORSU orden_susp,
       SARELEAC lectura_actual,
       SARELEAN lectura_anterios,
       SARELESU lectura_susp,
       SAREMARC marca,
       sareorde orden_generada,
       or_order.task_type_id || '|| chr(39) ||'-'|| chr(39) ||' || daor_task_type.fsbGetDescription( or_order.task_type_id ) TipoTrabajo,
       or_order.created_date fecha_creacion,
      order_status_id estado,
      or_order.operating_unit_id unidad_operativa,
      or_order.assigned_date fecha_asignacion,
      or_order.legalization_date fecha_legalziacion,
      or_order.causal_id||'|| chr(39) ||'-'|| chr(39) ||'||dage_causal.fsbgetdescription( or_order.causal_id, null) causal
FROM ldc_susp_autoreco, or_order
WHERE sareorde IS NOT NULL
 and sareorde = order_id';

    clColumns := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>PRODUCTO</Name>
    <Description>PRODUCTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONTRATO</Name>
    <Description>CONTRATO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CICLO</Name>
    <Description>CICLO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
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
    <Name>DEPARTAMENTO</Name>
    <Description>DEPARTAMENTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LOCALIDAD</Name>
    <Description>LOCALIDAD</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIRECCION</Name>
    <Description>DIRECCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ORDEN_SUSP</Name>
    <Description>ORDEN_SUSP</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_ACTUAL</Name>
    <Description>LECTURA_ACTUAL</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_ANTERIOS</Name>
    <Description>LECTURA_ANTERIOS</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_SUSP</Name>
    <Description>LECTURA_SUSP</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MARCA</Name>
    <Description>MARCA</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ORDEN_GENERADA</Name>
    <Description>ORDEN_GENERADA</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPOTRABAJO</Name>
    <Description>TIPOTRABAJO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_CREACION</Name>
    <Description>FECHA_CREACION</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO</Name>
    <Description>ESTADO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>UNIDAD_OPERATIVA</Name>
    <Description>UNIDAD_OPERATIVA</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_ASIGNACION</Name>
    <Description>FECHA_ASIGNACION</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_LEGALZIACION</Name>
    <Description>FECHA_LEGALZIACION</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CAUSAL</Name>
    <Description>CAUSAL</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>';

    ge_boFrameworkStatement.SaveStatement (GOPC_PACKAGE.tbGE_STATEMENT_Id(120197932),
                                           21,
                                           'LDC_CONSULTA_ORDEAUTORECONECTADO2',
                                           'Reporte de Ordenes de Autoreconectado Generadas',
                                           sbStatement,
                                           clWizard,
                                           clColumns,
                                           clListValues,
                                           false,
                                           nuStatementId);
EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;
    seqStatementId := GE_BOSEQUENCE.NEXTGE_STATEMENT;
    GOPC_PACKAGE.tbGE_STATEMENT_Id(120197933):= seqStatementId;

    sbStatement := 'select codigo_proceso,
       nombre_proceso,
       ciclo,
       descripcion_ciclo,
       producto,
       codigo_estado_corte,
       estado_corte,
       nombre,
       contrato,
       estado_producto,
       cod_direccion,
       direccion,
       uso,
       descripcion_uso,
       cod_departamento,
       departamento,
       cod_localidad,
       localidad,
       estado_financiero,
       saldo,
       cartera_vencida,
       consumo,
       lectura_actual,
       lectura_anterior,
       lectura_suspension,
       fecha_suspension,
       tipo_trab_suspension,
       orden_suspension,
       meses_suspension,
       tipo_suspen_producto,
       marca_producto,
       multifamiliar,
       fecha_maximo_susp,
       actividad_origen,
       descripcion_origen,
       actividad_destino,
       descripcion_destino,
       numero_periodos,
       flag_persecucion,
       fecha_proceso,
       consecutivo
  from vw_consulta_autoreconectadossn';

    clColumns := '<?xml version="1.0" encoding="utf-16"?>
<ArrayOfBaseStatementColumn xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <BaseStatementColumn>
    <Name>CODIGO_PROCESO</Name>
    <Description>CODIGO_PROCESO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NOMBRE_PROCESO</Name>
    <Description>NOMBRE_PROCESO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CICLO</Name>
    <Description>CICLO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_CICLO</Name>
    <Description>DESCRIPCION_CICLO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>PRODUCTO</Name>
    <Description>PRODUCTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CODIGO_ESTADO_CORTE</Name>
    <Description>CODIGO_ESTADO_CORTE</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_CORTE</Name>
    <Description>ESTADO_CORTE</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>40</Length>
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
    <Name>CONTRATO</Name>
    <Description>CONTRATO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ESTADO_PRODUCTO</Name>
    <Description>ESTADO_PRODUCTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>4</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_DIRECCION</Name>
    <Description>COD_DIRECCION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DIRECCION</Name>
    <Description>DIRECCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>USO</Name>
    <Description>USO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_USO</Name>
    <Description>DESCRIPCION_USO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>30</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_DEPARTAMENTO</Name>
    <Description>COD_DEPARTAMENTO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>6</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DEPARTAMENTO</Name>
    <Description>DEPARTAMENTO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>COD_LOCALIDAD</Name>
    <Description>COD_LOCALIDAD</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>6</Length>
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
    <Name>ESTADO_FINANCIERO</Name>
    <Description>ESTADO_FINANCIERO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>4000</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>SALDO</Name>
    <Description>SALDO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CARTERA_VENCIDA</Name>
    <Description>CARTERA_VENCIDA</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONSUMO</Name>
    <Description>CONSUMO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>9</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_ACTUAL</Name>
    <Description>LECTURA_ACTUAL</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_ANTERIOR</Name>
    <Description>LECTURA_ANTERIOR</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>LECTURA_SUSPENSION</Name>
    <Description>LECTURA_SUSPENSION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_SUSPENSION</Name>
    <Description>FECHA_SUSPENSION</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_TRAB_SUSPENSION</Name>
    <Description>TIPO_TRAB_SUSPENSION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ORDEN_SUSPENSION</Name>
    <Description>ORDEN_SUSPENSION</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MESES_SUSPENSION</Name>
    <Description>MESES_SUSPENSION</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>TIPO_SUSPEN_PRODUCTO</Name>
    <Description>TIPO_SUSPEN_PRODUCTO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MARCA_PRODUCTO</Name>
    <Description>MARCA_PRODUCTO</Description>
    <DisplayType>1</DisplayType>
    <InternalType>1</InternalType>
    <Length>15</Length>
    <Scale>127</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>MULTIFAMILIAR</Name>
    <Description>MULTIFAMILIAR</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>10</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_MAXIMO_SUSP</Name>
    <Description>FECHA_MAXIMO_SUSP</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ACTIVIDAD_ORIGEN</Name>
    <Description>ACTIVIDAD_ORIGEN</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_ORIGEN</Name>
    <Description>DESCRIPCION_ORIGEN</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>ACTIVIDAD_DESTINO</Name>
    <Description>ACTIVIDAD_DESTINO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>DESCRIPCION_DESTINO</Name>
    <Description>DESCRIPCION_DESTINO</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>100</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>NUMERO_PERIODOS</Name>
    <Description>NUMERO_PERIODOS</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>3</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FLAG_PERSECUCION</Name>
    <Description>FLAG_PERSECUCION</Description>
    <DisplayType>2</DisplayType>
    <InternalType>2</InternalType>
    <Length>2</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>FECHA_PROCESO</Name>
    <Description>FECHA_PROCESO</Description>
    <DisplayType>4</DisplayType>
    <InternalType>4</InternalType>
    <Length>7</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
  <BaseStatementColumn>
    <Name>CONSECUTIVO</Name>
    <Description>CONSECUTIVO</Description>
    <DisplayType>0</DisplayType>
    <InternalType>0</InternalType>
    <Length>15</Length>
    <Scale>0</Scale>
  </BaseStatementColumn>
</ArrayOfBaseStatementColumn>';

    ge_boFrameworkStatement.SaveStatement (GOPC_PACKAGE.tbGE_STATEMENT_Id(120197933),
                                           21,
                                           'Reporte General Autoreconectados',
                                           'Reporte General Autoreconectados',
                                           sbStatement,
                                           clWizard,
                                           clColumns,
                                           clListValues,
                                           false,
                                           nuStatementId);
EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- SA_EXECUTABLE
 
    ge_boFrameworkReport.CheckReportExist ('GOPC');

    ge_boFrameworkReport.DeleteReportMenuOptions (ge_bocatalog.fnuGetIdSeqFromCatalog('GOPC','EXECUTABLE','sa_boexecutable.getNextId'));

    ge_boFrameworkReport.DeleteReportStatements (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'));

    ge_boFrameworkReport.SaveReport (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), 21, 'GOPC', 'Genera Ordenes de Persecucion de Cartera', false, nuExecutableId);

    GI_BOFrameWorkApplication.UpdatePathFileHelp (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), '');

    GI_BOFrameWorkApplication.UpdateDirectExecution (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), 'Y');

    -- =========================================================================
    -- SA_MENU_OPTION
 
    ge_boFrameworkMenuOption.SaveMenuOption (sa_bosequences.fnuNextSa_Menu_Option, 'GOPC', 'Genera Ordenes de Persecucion de Cartera', 9900, ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), nuMenuOptionId);

EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- GE_REPORT_STATEMENT
 
    clReport := '<?xml version="1.0" encoding="utf-16"?>
<BaseReportStatement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Name>LDC - CONSULTA CONSUMO CERO</Name>
  <Description>LDC - CONSULTA CONSUMO CERO</Description>
  <Module>[21] Facturación</Module>
  <ExecutableId xsi:type="xsd:string">'||ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE')||'</ExecutableId>
  <StatementId xsi:type="xsd:long">'||GOPC_PACKAGE.tbGE_STATEMENT_Id(120197929)||'</StatementId>
  <Statement>select /*+ INDEX (LP PK_PROCESO) INDEX (CICLO UX_CICLO03)*/
DISTINCT LP.proceso_id CODIGO_PROCESO,
         lp.proceso_descripcion NOMBRE_PROCESO,
         LCC.CICLCODI Ciclo,
         CICLDESC Descripcion_Ciclo,
         LCC.PRODUCT_ID Producto,
         servsusc.SESUESCO CODIGO_ESTADO_CORTE,
         (SELECT ESTC.ESCODESC FROM ESTACORT ESTC WHERE ESTC.ESCOCODI = servsusc.SESUESCO) ESTADO_CORTE,
         SUBSCRIBER_NAME || '|| chr(39) ||' '|| chr(39) ||' || SUBS_LAST_NAME Nombre,
         OPEN.DALD_PARAMETER.fnuGetNumeric_Value('|| chr(39) ||'COD_ACT_SUSP_CM_PER_CART'|| chr(39) ||',
                    ' ||
'                             NULL) ACTIVIDAD_DESTINO,
         a.description DESCRIPCION_DESTINO,
(SELECT G.GEO_LOCA_FATHER_ID FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Cod_departamento,
         (SELECT G2.DESCRIPTION FROM GE_GEOGRA_LOCATION G, GE_GEOGRA_LOCATION G2 WHERE G2.GEOGRAP_LOCATION_ID = G.GEO_LOCA_FATHER_ID AND G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Departamento,
         open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID) Cod_localidad,
         (SELECT G.DESCRIPTION FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Localidad
  from LDC_CONSUMO_CERO LCC,
       ciclo,
       servsusc,
       suscripc,
       ge_subscriber,
       ldc_proceso      lp,
       ge_items         a,
       pr_product pr
 where CICLCICO = LCC.CICLCODI
   and SESUNUSE = LCC.PRODUCT_ID
   and SESUSUSC = SUSCCOD' ||
'I
   and SUBSCRIBER_ID = SUSCCLIE
   and pr.PRODUCT_ID = SESUNUSE
   and LCC.PRODUCT_ID is not null
   and 1 = (select count(1)
              from LDC_SUSP_PERSECUCION LSP
             where lcc.product_id = SUSP_PERSEC_PRODUCTO)
   and lp.proceso_id = lcc.proceso_id
   and a.items_id =
       OPEN.DALD_PARAMETER.fnuGetNumeric_Value('|| chr(39) ||'COD_ACT_SUSP_CM_PER_CART'|| chr(39) ||',
                                               NULL)</Statement>
  <StatementColumns>
    <BaseStatementColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>' ||
'
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>' ||
'
    <BaseStatementColumn>
      <Name>ESTADO_CORTE</Name>
      <Description>ESTADO_CORTE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NOMBRE</Name>
      <Description>NOMBRE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ACTIVIDAD_DESTINO</Name>
      <Description>ACTIVIDAD_DESTINO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>DESCRIPCION_DESTINO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>' ||
'30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_LOCALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LOCALIDAD</Name>
      <Description>LOCALIDAD</Description>
      <DisplayType>2</DisplayType>' ||
'
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
  </StatementColumns>
  <ReportColumns>
    <BaseReportColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>
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
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>' ||
'String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>PRODUCTO</Name>
      <Description>' ||
'PRODUCTO</Description>
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
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_CORTE</Name>
      <Description>ESTADO_CORTE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
 ' ||
'     <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>NOMBRE</Name>
      <Description>NOMBRE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ACTIVIDAD_DESTINO</Name>
      <Description>ACTIVIDAD_DESTINO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>' ||
'
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>DESCRIPCION_DESTINO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>' ||
'String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
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
      <Name>COD_LOCALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LOCALIDAD</Name>
     ' ||
' <Description>LOCALIDAD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
  </ReportColumns>
  <MapSettingsId xsi:nil="true" />
</BaseReportStatement>';

    ge_boFrameworkReport.SaveReportStatement (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), GOPC_PACKAGE.tbGE_STATEMENT_Id(120197929), 'LDC - CONSULTA CONSUMO CERO', 'LDC - CONSULTA CONSUMO CERO', clReport);


EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- GE_REPORT_STATEMENT
 
    clReport := '<?xml version="1.0" encoding="utf-16"?>
<BaseReportStatement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Name>LDC - CONSULTA LDC_SUSP_PERSECUCION1</Name>
  <Description>LDC - CONSULTA LDC_SUSP_PERSECUCION1</Description>
  <Module>[21] Facturación</Module>
  <ExecutableId xsi:type="xsd:string">'||ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE')||'</ExecutableId>
  <StatementId xsi:type="xsd:long">'||GOPC_PACKAGE.tbGE_STATEMENT_Id(120197930)||'</StatementId>
  <Statement>select /*+ INDEX (LDC_SUSP_PERSECUCION IDX_LDC_SUSP_PERSECUCION01,IDX_LDC_SUSP_PERSECUCION02) INDEX (LP PK_PROCESO) INDEX (CICLO UX_CICLO03)*/
DISTINCT LP.proceso_id CODIGO_PROCESO,
         lp.proceso_descripcion NOMBRE_PROCESO,
         SUSP_PERSEC_CICLCODI Ciclo,
         CICLDESC Descripcion_Ciclo,
         SUSP_PERSEC_PRODUCTO Producto,
         servsusc.SESUESCO CODIGO_ESTADO_CORTE,
         (SELECT ESTC.ESCODESC FROM ESTACORT ESTC WHERE ESTC.ESCOCODI = servsusc.SESUESCO) ESTADO_CORTE,
         SUBSCRIBER_NAME || '|| chr(39) ||' '|| chr(39) ||' || SUBS_' ||
'LAST_NAME Nombre,
         SUSP_PERSEC_SALPEND Saldo,
         gc_bodebtmanagement.fnugetexpirdebtbyprod(SUSP_PERSEC_PRODUCTO) CARTERA_VENCIDA,
         (select round(MONTHS_BETWEEN(TO_DATE(sysdate),
                                      max(pps.register_date)))
            from pr_prod_suspension pps
           where pps.product_id = SUSP_PERSEC_PRODUCTO) MESES_SUSPENCION,
         SUSP_PERSEC_CONSUMO Consumo,
         SUSP_PERSEC_ACT_ORIG Actividad_Origen,
         b.DESCRIPTION Descripcion_Origen,
         SUSP_PERSEC_ACTIVID Actividad_Destino,
         a.DESCRIPTION Descripcion_Destino,
         SUSP_PERSEC_PERVARI Numero_Periodos,
         SUSP_PERSEC_PERSEC Flag_Persecucion,
         ldc_Reportesconsulta.fsbEstadoFinancieroProducto(SUSP_PERSEC_PRODUCTO) Estado_Financiero,
         SUSP_PERSEC_FEJPROC Fecha_Proceso,
         SUSP_PERSEC_CODI CONSECUTIVO,
         (SELECT count(*)
            FROM cuencobr
           WHERE cucosacu '||chr(38)||'gt; 0
             AND cuconuse = SUSP_PERSEC_PRO' ||
'DUCTO) CUENTAS_CON_SALDO,
         sesucate USO,
         (select c.catedesc from categori c where c.catecodi = sesucate) DESCRIPCION_USO,
         (SELECT max(leemleto)
            FROM pr_product, lectelme
           WHERE product_id = leemsesu
             AND leemdocu = suspen_ord_Act_id
             AND leemclec '||chr(38)||'lt;'||chr(38)||'gt; '|| chr(39) ||'F'|| chr(39) ||'
             AND product_id = SUSP_PERSEC_PRODUCTO) LECTURA_ULTIMA_SUSPENSION,
         (SELECT max(leemleto)
            FROM lectelme
           WHERE leemsesu = sesunuse
             AND leemclec = '|| chr(39) ||'F'|| chr(39) ||'
             and lectelme.leemfele in
                 (SELECT max(lectelme.leemfele)
                    FROM lectelme
                   WHERE leemsesu = sesunuse
                     AND leemclec = '|| chr(39) ||'F'|| chr(39) ||')) ULTIMA_LECTURA_FACTURACION,
         (SELECT G.GEO_LOCA_FATHER_ID FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Cod_departamento,
         (SELECT G2.DESCRIPTION FROM GE_GEOGRA_LOCATION ' ||
'G, GE_GEOGRA_LOCATION G2 WHERE G2.GEOGRAP_LOCATION_ID = G.GEO_LOCA_FATHER_ID AND G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Departamento,
         open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID) Cod_localidad,
         (SELECT G.DESCRIPTION FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Localidad
  from LDC_SUSP_PERSECUCION,
       ge_items              a,
       ge_items              b,
       ciclo,
       servsusc,
       suscripc,
       ge_subscriber,
       ldc_proceso           lp,
       ldc_proceso_actividad lpa,
       pr_product            pr
 where a.ITEMS_ID = SUSP_PERSEC_ACTIVID
   and b.ITEMS_ID = SUSP_PERSEC_ACT_ORIG
   and CICLCICO = SUSP_PERSEC_CICLCODI
   and SESUNUSE = SUSP_PERSEC_PRODUCTO
   and SESUSUSC = SUSCCODI
   and SUBSCRIBER_ID = SUSCCLIE
   and pr.PRODUCT_ID = SESUNUSE
   and SUSP_PERSEC_ORDER_ID is null
   and 0 = (select count(1)
     ' ||
'         from ldc_consumo_cero lcc
             where lcc.proceso_id = lp.proceso_id
               and lcc.product_id = SUSP_PERSEC_PRODUCTO)
   and lp.proceso_id = lpa.proceso_id
   and (B.ITEMS_ID = lpa.activity_id OR A.ITEMS_ID = lpa.activity_id)</Statement>
  <StatementColumns>
    <BaseStatementColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>' ||
'
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO_CORTE</Name>
      <Description>ESTADO_CORTE</Description>
      <DisplayType>2</DisplayType>
   ' ||
'   <InternalType>2</InternalType>
      <Length>40</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NOMBRE</Name>
      <Description>NOMBRE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>SALDO</Name>
      <Description>SALDO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CARTERA_VENCIDA</Name>
      <Description>CARTERA_VENCIDA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MESES_SUSPENCION</Name>
      <Description>MESES_SUSPENCION</Description>
      <DisplayType>' ||
'1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CONSUMO</Name>
      <Description>CONSUMO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>9</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ACTIVIDAD_ORIGEN</Name>
      <Description>ACTIVIDAD_ORIGEN</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_ORIGEN</Name>
      <Description>DESCRIPCION_ORIGEN</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ACTIVIDAD_DESTINO</Name>
  ' ||
'    <Description>ACTIVIDAD_DESTINO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>DESCRIPCION_DESTINO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NUMERO_PERIODOS</Name>
      <Description>NUMERO_PERIODOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FLAG_PERSECUCION</Name>
      <Description>FLAG_PERSECUCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>' ||
'
    <BaseStatementColumn>
      <Name>ESTADO_FINANCIERO</Name>
      <Description>ESTADO_FINANCIERO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECHA_PROCESO</Name>
      <Description>FECHA_PROCESO</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CONSECUTIVO</Name>
      <Description>CONSECUTIVO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CUENTAS_CON_SALDO</Name>
      <Description>CUENTAS_CON_SALDO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>' ||
'15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>USO</Name>
      <Description>USO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_USO</Name>
      <Description>DESCRIPCION_USO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_ULTIMA_SUSPENSION</Name>
      <Description>LECTURA_ULTIMA_SUSPENSION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ULTIMA_LECTURA_FACTURACION</Name>
      <Description>ULTIMA_LECTURA_FACTURACION</Description>
  ' ||
'    <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_LOCALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LOCALIDAD</Name>
' ||
'
      <Description>LOCALIDAD</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
  </StatementColumns>
  <ReportColumns>
    <BaseReportColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>
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
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
    ' ||
'  <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>' ||
'
    <BaseReportColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
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
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_CORTE</Name>
      <Description>ESTADO_CORTE</Description>' ||
'
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>40</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>NOMBRE</Name>
      <Description>NOMBRE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>SALDO</Name>
      <Description>DEUDA_CORRIENTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
   ' ||
'   <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CARTERA_VENCIDA</Name>
      <Description>CARTERA_VENCIDA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>MESES_SUSPENCION</Name>
      <Description>MESES_SUSPENCION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>' ||
'
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONSUMO</Name>
      <Description>DIFERENCIA_LECTURA</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>9</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ACTIVIDAD_ORIGEN</Name>
      <Description>ACTIVIDAD_ORIGEN</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>' ||
'
    <BaseReportColumn>
      <Name>DESCRIPCION_ORIGEN</Name>
      <Description>DESCRIPCION_ORIGEN</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ACTIVIDAD_DESTINO</Name>
      <Description>ACTIVIDAD_DESTINO</Description>
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
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>DESCRIPCI' ||
'ON_DESTINO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>NUMERO_PERIODOS</Name>
      <Description>NUMERO_PERIODOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FLAG_PERSECUCION</Name>
      <Description>FLAG_PERSECUCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
   ' ||
'   <Length>2</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_FINANCIERO</Name>
      <Description>ESTADO_FINANCIERO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FECHA_PROCESO</Name>
      <Description>FECHA_PROCESO</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>tru' ||
'e</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONSECUTIVO</Name>
      <Description>CONSECUTIVO</Description>
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
      <Name>CUENTAS_CON_SALDO</Name>
      <Description>CUENTAS_CON_SALDO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>St' ||
'ring</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>USO</Name>
      <Description>USO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DESCRIPCION_USO</Name>
      <Description>DESCRIPCION_USO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LECTURA_ULTIMA_SUSPENSION</Name>
      <Description>' ||
'LECTURA_ULTIMA_SUSPENSION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ULTIMA_LECTURA_FACTURACION</Name>
      <Description>ULTIMA_LECTURA_FACTURACION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>1</DisplayType>' ||
'
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_LOCALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>30</Scale>
      <Required>' ||
'false</Required>
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
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
  </ReportColumns>
  <MapSettingsId xsi:nil="true" />
</BaseReportStatement>';

    ge_boFrameworkReport.SaveReportStatement (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), GOPC_PACKAGE.tbGE_STATEMENT_Id(120197930), 'LDC - CONSULTA LDC_SUSP_PERSECUCION1', 'LDC - CONSULTA LDC_SUSP_PERSECUCION1', clReport);


EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/
DECLARE

clReportComplete clob := empty_clob ();

clReport1  clob := empty_clob ();
clReport2  clob := empty_clob ();

nuExecutableId number;
nuMenuOptionId number;

BEGIN
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- GE_REPORT_STATEMENT
 
    clReport1 := '<?xml version="1.0" encoding="utf-16"?>
<BaseReportStatement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Name>LDC_CONSULTA_AUTORECONECTADOS_RP_</Name>
  <Description>Reporte de Autoreconectado</Description>
  <Module>[21] Facturación</Module>
  <ExecutableId xsi:type="xsd:string">'||ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE')||'</ExecutableId>
  <StatementId xsi:type="xsd:long">'||GOPC_PACKAGE.tbGE_STATEMENT_Id(120197916)||'</StatementId>
  <Statement>select codigo_proceso,
       nombre_proceso,
       ciclo,
       descripcion_ciclo,
       producto,
       codigo_estado_corte,
       estado_corte,
       nombre,
       contrato,
       estado_producto,
       cod_direccion,
       direccion,
       uso,
       descripcion_uso,
       cod_departamento,
       departamento,
       cod_localidad,
       localidad,
       estado_financiero,
       saldo,
       cartera_vencida,
       consumo,
       lectura_actual,
       lectura_anterior,
       lectura_suspension,
       fecha_suspension,
' ||
'       tipo_trab_suspension,
       orden_suspension,
       meses_suspension,
       tipo_suspen_producto,
       marca_producto,
       multifamiliar,
       fecha_maximo_susp,
       actividad_origen,
       descripcion_origen,
       actividad_destino,
       descripcion_destino,
       numero_periodos,
       flag_persecucion,
       fecha_proceso,
       consecutivo,
       Cuentas_con_saldos,
       Defectos_no_reparables
  from vw_consulta_autoreconectados</Statement>
  <StatementColumns>
    <BaseStatementColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>' ||
'
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
    ' ||
'  <Length>3</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO_CORTE</Name>
      <Description>ESTADO_CORTE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>40</Length>
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
      <Name>CONTRATO</Name>
      <Description>CONTRATO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO_PRODUCTO</Name>
      <Description>ESTADO_PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>' ||
'0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_DIRECCION</Name>
      <Description>COD_DIRECCION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DIRECCION</Name>
      <Description>DIRECCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>USO</Name>
      <Description>USO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_USO</Name>
      <Description>DESCRIPCION_USO</Description>
      <DisplayType>2</DisplayType>' ||
'
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_LOCALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LOCALIDAD</Name>
      <Description>LOCALIDAD</Description>' ||
'
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO_FINANCIERO</Name>
      <Description>ESTADO_FINANCIERO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>SALDO</Name>
      <Description>SALDO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CARTERA_VENCIDA</Name>
      <Description>CARTERA_VENCIDA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CONSUM' ||
'O</Name>
      <Description>CONSUMO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>9</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_ACTUAL</Name>
      <Description>LECTURA_ACTUAL</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_ANTERIOR</Name>
      <Description>LECTURA_ANTERIOR</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_SUSPENSION</Name>
      <Description>LECTURA_SUSPENSION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>' ||
'
    <BaseStatementColumn>
      <Name>FECHA_SUSPENSION</Name>
      <Description>FECHA_SUSPENSION</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>TIPO_TRAB_SUSPENSION</Name>
      <Description>TIPO_TRAB_SUSPENSION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ORDEN_SUSPENSION</Name>
      <Description>ORDEN_SUSPENSION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MESES_SUSPENSION</Name>
      <Description>MESES_SUSPENSION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>' ||
'
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>TIPO_SUSPEN_PRODUCTO</Name>
      <Description>TIPO_SUSPEN_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MARCA_PRODUCTO</Name>
      <Description>MARCA_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MULTIFAMILIAR</Name>
      <Description>MULTIFAMILIAR</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>10</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECHA_MAXIMO_SUSP</Name>
      <Description>FECHA_MAXIMO_SUSP</Description>' ||
'
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ACTIVIDAD_ORIGEN</Name>
      <Description>ACTIVIDAD_ORIGEN</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_ORIGEN</Name>
      <Description>DESCRIPCION_ORIGEN</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ACTIVIDAD_DESTINO</Name>
      <Description>ACTIVIDAD_DESTINO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>' ||
'
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>DESCRIPCION_DESTINO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NUMERO_PERIODOS</Name>
      <Description>NUMERO_PERIODOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FLAG_PERSECUCION</Name>
      <Description>FLAG_PERSECUCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECHA_PROCESO</Name>
      <Description>FECHA_PROCESO</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>' ||
'0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CONSECUTIVO</Name>
      <Description>CONSECUTIVO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CUENTAS_CON_SALDOS</Name>
      <Description>CUENTAS_CON_SALDOS</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DEFECTOS_NO_REPARABLES</Name>
      <Description>DEFECTOS_NO_REPARABLES</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>1</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
  </StatementColumns>
  <ReportColumns>
    <BaseReportColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>' ||
'
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
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
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
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>' ||
'
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
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
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_CORTE</Name>
      <Description>ESTADO_CORTE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>40</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
' ||
'    <BaseReportColumn>
      <Name>NOMBRE</Name>
      <Description>NOMBRE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>201</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONTRATO</Name>
      <Description>CONTRATO</Description>
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
      <Name>ESTADO_PRODUCTO</Name>
      <Description>ESTADO_PRODUCTO</Description>
      <DisplayType>0</DisplayType>' ||
'
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_DIRECCION</Name>
      <Description>COD_DIRECCION</Description>
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
      <Name>DIRECCION</Name>
      <Description>DIRECCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
      <Required>fal' ||
'se</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>USO</Name>
      <Description>USO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DESCRIPCION_USO</Name>
      <Description>DESCRIPCION_USO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>' ||
'String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
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
      <Name>COD_LOC' ||
'ALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
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
      <Name>ESTADO_FINANCIERO</Name>
      <Description>ESTADO_FINANCIERO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>' ||
'2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>SALDO</Name>
      <Description>SALDO</Description>
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
      <Name>CARTERA_VENCIDA</Name>
      <Description>CARTERA_VENCIDA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>' ||
'true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONSUMO</Name>
      <Description>CONSUMO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>9</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LECTURA_ACTUAL</Name>
      <Description>LECTURA_ACTUAL</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>Stri' ||
'ng</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LECTURA_ANTERIOR</Name>
      <Description>LECTURA_ANTERIOR</Description>
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
      <Name>LECTURA_SUSPENSION</Name>
      <Description>LECTURA_SUSPENSION</Description>
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
      <Name>FECHA_SUSPENSI' ||
'ON</Name>
      <Description>FECHA_SUSPENSION</Description>
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
      <Name>TIPO_TRAB_SUSPENSION</Name>
      <Description>TIPO_TRAB_SUSPENSION</Description>
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
      <Name>ORDEN_SUSPENSION</Name>
      <Description>ORDEN_SUSPENSION</Description>
      <DisplayType>0</DisplayType>' ||
'
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
      <Name>MESES_SUSPENSION</Name>
      <Description>MESES_SUSPENSION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>TIPO_SUSPEN_PRODUCTO</Name>
      <Description>TIPO_SUSPEN_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>' ||
'
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>MARCA_PRODUCTO</Name>
      <Description>MARCA_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>MULTIFAMILIAR</Name>
      <Description>MULTIFAMILIAR</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>10</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>' ||
'
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FECHA_MAXIMO_SUSP</Name>
      <Description>FECHA_MAXIMO_SUSP</Description>
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
      <Name>ACTIVIDAD_ORIGEN</Name>
      <Description>ACTIVIDAD_ORIGEN</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>' ||
'
    <BaseReportColumn>
      <Name>DESCRIPCION_ORIGEN</Name>
      <Description>DESCRIPCION_ORIGEN</Description>
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
      <Name>ACTIVIDAD_DESTINO</Name>
      <Description>ACTIVIDAD_DESTINO</Description>
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
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>' ||
'DESCRIPCION_DESTINO</Description>
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
      <Name>NUMERO_PERIODOS</Name>
      <Description>NUMERO_PERIODOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FLAG_PERSECUCION</Name>
      <Description>FLAG_PERSECUCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>' ||
'';

    clReport2 := '
      <Length>2</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FECHA_PROCESO</Name>
      <Description>FECHA_PROCESO</Description>
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
      <Name>CONSECUTIVO</Name>
      <Description>CONSECUTIVO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>' ||
'
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CUENTAS_CON_SALDOS</Name>
      <Description>CUENTAS_CON_SALDOS</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DEFECTOS_NO_REPARABLES</Name>
      <Description>DEFECTOS_NO_REPARABLES</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>1</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>' ||
'String</DisplayControl>
    </BaseReportColumn>
  </ReportColumns>
  <MapSettingsId xsi:nil="true" />
</BaseReportStatement>';

    ge_boFrameworkReport.SaveReportStatement (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), GOPC_PACKAGE.tbGE_STATEMENT_Id(120197916), 'LDC_CONSULTA_AUTORECONECTADOS_RP_', 'Reporte de Autoreconectado', clReport1 || 
        clReport2
    );


EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
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
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- GE_REPORT_STATEMENT
 
    clReport := '<?xml version="1.0" encoding="utf-16"?>
<BaseReportStatement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Name>LDC_CONSULTA_ORDEAUTORECONECTADO2</Name>
  <Description>Reporte de Ordenes de Autoreconectado Generadas</Description>
  <Module>[21] Facturación</Module>
  <ExecutableId xsi:type="xsd:string">'||ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE')||'</ExecutableId>
  <StatementId xsi:type="xsd:long">'||GOPC_PACKAGE.tbGE_STATEMENT_Id(120197932)||'</StatementId>
  <Statement>SELECT saresesu producto,
       SARECONT contrato,
       sarecicl ciclo,
       (SELECT subscriber_name || '|| chr(39) ||' '|| chr(39) ||' || subs_last_name FROM ge_subscriber WHERE subscriber_id = sareclie) nombre,
       SAREDEPA || '|| chr(39) ||'-'|| chr(39) ||'||dage_geogra_location.fsbGetDescription( SAREDEPA ) departamento,
       SARELOCA || '|| chr(39) ||'-'|| chr(39) ||'||dage_geogra_location.fsbGetDescription( SARELOCA ) Localidad,
       SAREDIRE ||'|| chr(39) ||'-'|| chr(39) ||'||daab_address.fsbgetaddress_parsed(SAREDIRE,null) direccion,
       SAREORSU orden_susp,
       SARELEAC lectura_actual,
       SARELEAN lectu' ||
'ra_anterios,
       SARELESU lectura_susp,
       SAREMARC marca,
       sareorde orden_generada,
       or_order.task_type_id || '|| chr(39) ||'-'|| chr(39) ||' || daor_task_type.fsbGetDescription( or_order.task_type_id ) TipoTrabajo,
       or_order.created_date fecha_creacion,
      order_status_id estado,
      or_order.operating_unit_id unidad_operativa,
      or_order.assigned_date fecha_asignacion,
      or_order.legalization_date fecha_legalziacion,
      or_order.causal_id||'|| chr(39) ||'-'|| chr(39) ||'||dage_causal.fsbgetdescription( or_order.causal_id, null) causal
FROM ldc_susp_autoreco, or_order
WHERE sareorde IS NOT NULL
 and sareorde = order_id</Statement>
  <StatementColumns>
    <BaseStatementColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CONTRATO</Name>
      <Description>CONTRATO</Description>
' ||
'      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
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
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LOCALIDAD</Name>
      <Description>LOCALIDAD</Description>' ||
'
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DIRECCION</Name>
      <Description>DIRECCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ORDEN_SUSP</Name>
      <Description>ORDEN_SUSP</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_ACTUAL</Name>
      <Description>LECTURA_ACTUAL</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_ANTERIOS</Name>' ||
'
      <Description>LECTURA_ANTERIOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_SUSP</Name>
      <Description>LECTURA_SUSP</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MARCA</Name>
      <Description>MARCA</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ORDEN_GENERADA</Name>
      <Description>ORDEN_GENERADA</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>' ||
'
      <Name>TIPOTRABAJO</Name>
      <Description>TIPOTRABAJO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECHA_CREACION</Name>
      <Description>FECHA_CREACION</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO</Name>
      <Description>ESTADO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>UNIDAD_OPERATIVA</Name>
      <Description>UNIDAD_OPERATIVA</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>' ||
'
    <BaseStatementColumn>
      <Name>FECHA_ASIGNACION</Name>
      <Description>FECHA_ASIGNACION</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECHA_LEGALZIACION</Name>
      <Description>FECHA_LEGALZIACION</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CAUSAL</Name>
      <Description>CAUSAL</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
  </StatementColumns>
  <ReportColumns>
    <BaseReportColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>' ||
'
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONTRATO</Name>
      <Description>CONTRATO</Description>
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
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>' ||
'
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>NOMBRE</Name>
      <Description>NOMBRE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>201</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>' ||
'
    <BaseReportColumn>
      <Name>LOCALIDAD</Name>
      <Description>LOCALIDAD</Description>
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
      <Name>DIRECCION</Name>
      <Description>DIRECCION</Description>
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
      <Name>ORDEN_SUSP</Name>
      <Description>ORDEN_SUSP</Description>
      <DisplayType>' ||
'0</DisplayType>
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
      <Name>LECTURA_ACTUAL</Name>
      <Description>LECTURA_ACTUAL</Description>
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
      <Name>LECTURA_ANTERIOS</Name>
      <Description>LECTURA_ANTERIOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>' ||
'0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>LECTURA_SUSP</Name>
      <Description>LECTURA_SUSP</Description>
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
      <Name>MARCA</Name>
      <Description>MARCA</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
     ' ||
' <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ORDEN_GENERADA</Name>
      <Description>ORDEN_GENERADA</Description>
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
      <Name>TIPOTRABAJO</Name>
      <Description>TIPOTRABAJO</Description>
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
    <BaseReportColumn>' ||
'
      <Name>FECHA_CREACION</Name>
      <Description>FECHA_CREACION</Description>
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
      <Name>ESTADO</Name>
      <Description>ESTADO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>UNIDAD_OPERATIVA</Name>
      <Description>UNIDAD_OPERATIVA</Description>
      <DisplayType>0</DisplayType>' ||
'
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
      <Name>FECHA_ASIGNACION</Name>
      <Description>FECHA_ASIGNACION</Description>
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
      <Name>FECHA_LEGALZIACION</Name>
      <Description>FECHA_LEGALZIACION</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    ' ||
'  <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CAUSAL</Name>
      <Description>CAUSAL</Description>
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
  </ReportColumns>
  <MapSettingsId xsi:nil="true" />
</BaseReportStatement>';

    ge_boFrameworkReport.SaveReportStatement (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), GOPC_PACKAGE.tbGE_STATEMENT_Id(120197932), 'LDC_CONSULTA_ORDEAUTORECONECTADO2', 'Reporte de Ordenes de Autoreconectado Generadas', clReport);


EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/
DECLARE

clReportComplete clob := empty_clob ();

clReport1  clob := empty_clob ();
clReport2  clob := empty_clob ();

nuExecutableId number;
nuMenuOptionId number;

BEGIN
    if not GOPC_PACKAGE.blProcessStatus then
        return;
    end if;

    -- =========================================================================
    -- GE_REPORT_STATEMENT
 
    clReport1 := '<?xml version="1.0" encoding="utf-16"?>
<BaseReportStatement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Name>Reporte General Autoreconectados</Name>
  <Description>Reporte General Autoreconectados</Description>
  <Module>[21] Facturación</Module>
  <ExecutableId xsi:type="xsd:string">'||ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE')||'</ExecutableId>
  <StatementId xsi:type="xsd:long">'||GOPC_PACKAGE.tbGE_STATEMENT_Id(120197933)||'</StatementId>
  <Statement>select codigo_proceso,
       nombre_proceso,
       ciclo,
       descripcion_ciclo,
       producto,
       codigo_estado_corte,
       estado_corte,
       nombre,
       contrato,
       estado_producto,
       cod_direccion,
       direccion,
       uso,
       descripcion_uso,
       cod_departamento,
       departamento,
       cod_localidad,
       localidad,
       estado_financiero,
       saldo,
       cartera_vencida,
       consumo,
       lectura_actual,
       lectura_anterior,
       lectura_suspension,
       fecha_suspens' ||
'ion,
       tipo_trab_suspension,
       orden_suspension,
       meses_suspension,
       tipo_suspen_producto,
       marca_producto,
       multifamiliar,
       fecha_maximo_susp,
       actividad_origen,
       descripcion_origen,
       actividad_destino,
       descripcion_destino,
       numero_periodos,
       flag_persecucion,
       fecha_proceso,
       consecutivo
  from vw_consulta_autoreconectadossn</Statement>
  <StatementColumns>
    <BaseStatementColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>' ||
'
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>' ||
'
    <BaseStatementColumn>
      <Name>ESTADO_CORTE</Name>
      <Description>ESTADO_CORTE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>40</Length>
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
      <Name>CONTRATO</Name>
      <Description>CONTRATO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO_PRODUCTO</Name>
      <Description>ESTADO_PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
   ' ||
'   <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_DIRECCION</Name>
      <Description>COD_DIRECCION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DIRECCION</Name>
      <Description>DIRECCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>USO</Name>
      <Description>USO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_USO</Name>
      <Description>DESCRIPCION_USO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
     ' ||
' <Length>30</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>COD_LOCALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LOCALIDAD</Name>
      <Description>LOCALIDAD</Description>
      <DisplayType>2</DisplayType>
' ||
'      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ESTADO_FINANCIERO</Name>
      <Description>ESTADO_FINANCIERO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>SALDO</Name>
      <Description>SALDO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CARTERA_VENCIDA</Name>
      <Description>CARTERA_VENCIDA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>CONSUMO</Name>
      <Description>CONSUMO</Description>
' ||
'
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>9</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_ACTUAL</Name>
      <Description>LECTURA_ACTUAL</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_ANTERIOR</Name>
      <Description>LECTURA_ANTERIOR</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>LECTURA_SUSPENSION</Name>
      <Description>LECTURA_SUSPENSION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECH' ||
'A_SUSPENSION</Name>
      <Description>FECHA_SUSPENSION</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>TIPO_TRAB_SUSPENSION</Name>
      <Description>TIPO_TRAB_SUSPENSION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ORDEN_SUSPENSION</Name>
      <Description>ORDEN_SUSPENSION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MESES_SUSPENSION</Name>
      <Description>MESES_SUSPENSION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127' ||
'</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>TIPO_SUSPEN_PRODUCTO</Name>
      <Description>TIPO_SUSPEN_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MARCA_PRODUCTO</Name>
      <Description>MARCA_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>MULTIFAMILIAR</Name>
      <Description>MULTIFAMILIAR</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>10</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECHA_MAXIMO_SUSP</Name>
      <Description>FECHA_MAXIMO_SUSP</Description>
      <DisplayType>4</DisplayType>
   ' ||
'   <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ACTIVIDAD_ORIGEN</Name>
      <Description>ACTIVIDAD_ORIGEN</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_ORIGEN</Name>
      <Description>DESCRIPCION_ORIGEN</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>ACTIVIDAD_DESTINO</Name>
      <Description>ACTIVIDAD_DESTINO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>' ||
'DESCRIPCION_DESTINO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>100</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>NUMERO_PERIODOS</Name>
      <Description>NUMERO_PERIODOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FLAG_PERSECUCION</Name>
      <Description>FLAG_PERSECUCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>
      <Name>FECHA_PROCESO</Name>
      <Description>FECHA_PROCESO</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
    <BaseStatementColumn>' ||
'
      <Name>CONSECUTIVO</Name>
      <Description>CONSECUTIVO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
    </BaseStatementColumn>
  </StatementColumns>
  <ReportColumns>
    <BaseReportColumn>
      <Name>CODIGO_PROCESO</Name>
      <Description>CODIGO_PROCESO</Description>
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
      <Name>NOMBRE_PROCESO</Name>
      <Description>NOMBRE_PROCESO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>4000</Length>
      <Scale>0</Scale>
      <Required>false</Required>' ||
'
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CICLO</Name>
      <Description>CICLO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DESCRIPCION_CICLO</Name>
      <Description>DESCRIPCION_CICLO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>' ||
'String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>PRODUCTO</Name>
      <Description>PRODUCTO</Description>
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
      <Name>CODIGO_ESTADO_CORTE</Name>
      <Description>CODIGO_ESTADO_CORTE</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_COR' ||
'TE</Name>
      <Description>ESTADO_CORTE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>40</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>NOMBRE</Name>
      <Description>NOMBRE</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>201</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONTRATO</Name>
      <Description>CONTRATO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
   ' ||
'   <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_PRODUCTO</Name>
      <Description>ESTADO_PRODUCTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>4</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_DIRECCION</Name>
      <Description>COD_DIRECCION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>' ||
'
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DIRECCION</Name>
      <Description>DIRECCION</Description>
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
      <Name>USO</Name>
      <Description>USO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>' ||
'
    <BaseReportColumn>
      <Name>DESCRIPCION_USO</Name>
      <Description>DESCRIPCION_USO</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>30</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>COD_DEPARTAMENTO</Name>
      <Description>COD_DEPARTAMENTO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>DEPARTAMENTO</Name>
      <Description>DEPARTAMENTO</Description>' ||
'
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
      <Name>COD_LOCALIDAD</Name>
      <Description>COD_LOCALIDAD</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>6</Length>
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
    ' ||
'  <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ESTADO_FINANCIERO</Name>
      <Description>ESTADO_FINANCIERO</Description>
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
      <Name>SALDO</Name>
      <Description>SALDO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>fals' ||
'e</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CARTERA_VENCIDA</Name>
      <Description>CARTERA_VENCIDA</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONSUMO</Name>
      <Description>CONSUMO</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>9</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    ' ||
'<BaseReportColumn>
      <Name>LECTURA_ACTUAL</Name>
      <Description>LECTURA_ACTUAL</Description>
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
      <Name>LECTURA_ANTERIOR</Name>
      <Description>LECTURA_ANTERIOR</Description>
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
      <Name>LECTURA_SUSPENSION</Name>
      <Description>LECTURA_SUSPENSION</Description>' ||
'
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
      <Name>FECHA_SUSPENSION</Name>
      <Description>FECHA_SUSPENSION</Description>
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
      <Name>TIPO_TRAB_SUSPENSION</Name>
      <Description>TIPO_TRAB_SUSPENSION</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>' ||
'15</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>ORDEN_SUSPENSION</Name>
      <Description>ORDEN_SUSPENSION</Description>
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
      <Name>MESES_SUSPENSION</Name>
      <Description>MESES_SUSPENSION</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>tru' ||
'e</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>TIPO_SUSPEN_PRODUCTO</Name>
      <Description>TIPO_SUSPEN_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>MARCA_PRODUCTO</Name>
      <Description>MARCA_PRODUCTO</Description>
      <DisplayType>1</DisplayType>
      <InternalType>1</InternalType>
      <Length>15</Length>
      <Scale>127</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>' ||
'String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>MULTIFAMILIAR</Name>
      <Description>MULTIFAMILIAR</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>10</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FECHA_MAXIMO_SUSP</Name>
      <Description>FECHA_MAXIMO_SUSP</Description>
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
      <Name>ACTIVI' ||
'DAD_ORIGEN</Name>
      <Description>ACTIVIDAD_ORIGEN</Description>
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
      <Name>DESCRIPCION_ORIGEN</Name>
      <Description>DESCRIPCION_ORIGEN</Description>
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
      <Name>ACTIVIDAD_DESTINO</Name>
      <Description>ACTIVIDAD_DESTINO</Description>
      <DisplayType>0</DisplayType>' ||
'
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
      <Name>DESCRIPCION_DESTINO</Name>
      <Description>DESCRIPCION_DESTINO</Description>
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
      <Name>NUMERO_PERIODOS</Name>
      <Description>NUMERO_PERIODOS</Description>
      <DisplayType>0</DisplayType>
      <InternalType>0</InternalType>
      <Length>3</Length>
      <Scale>0</Scale>' ||
'
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FLAG_PERSECUCION</Name>
      <Description>FLAG_PERSECUCION</Description>
      <DisplayType>2</DisplayType>
      <InternalType>2</InternalType>
      <Length>2</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>FECHA_PROCESO</Name>
      <Description>FECHA_PROCESO</Description>
      <DisplayType>4</DisplayType>
      <InternalType>4</InternalType>
      <Length>7</Length>
      <Scale>0</Scale>
      <Required>false</Required>
      <UpdateAllowed>true</UpdateAllowed>
      <Multiline>false</Multiline>' ||
'';

    clReport2 := '
      <Group>false</Group>
      <DisplayControl>String</DisplayControl>
    </BaseReportColumn>
    <BaseReportColumn>
      <Name>CONSECUTIVO</Name>
      <Description>CONSECUTIVO</Description>
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
  </ReportColumns>
  <MapSettingsId xsi:nil="true" />
</BaseReportStatement>';

    ge_boFrameworkReport.SaveReportStatement (ge_bocatalog.fnuGetIdFromCatalog('GOPC','EXECUTABLE'), GOPC_PACKAGE.tbGE_STATEMENT_Id(120197933), 'Reporte General Autoreconectados', 'Reporte General Autoreconectados', clReport1 || 
        clReport2
    );


EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/
declare
  nuIndexStatement PLS_INTEGER;
BEGIN
    if not GOPC_PACKAGE.blProcessStatus then
      return;
    END if;
    nuIndexStatement := GOPC_PACKAGE.tbOLD_GE_STATEMENT_Id.first;
    while (nuIndexStatement IS not null)
    loop
       DELETE FROM ge_statement_columns WHERE statement_id = GOPC_PACKAGE.tbOLD_GE_STATEMENT_Id(nuIndexStatement);
       DELETE FROM ge_statement WHERE statement_id = GOPC_PACKAGE.tbOLD_GE_STATEMENT_Id(nuIndexStatement);
       nuIndexStatement := GOPC_PACKAGE.tbOLD_GE_STATEMENT_Id.next(nuIndexStatement);
    END loop;
END;
/
BEGIN
  if not GOPC_PACKAGE.blProcessStatus then
    return;
  end if;
    commit;

EXCEPTION
    WHEN others THEN
        GOPC_PACKAGE.blProcessStatus := false;
        rollback;
        ut_trace.trace('**ERROR:'||sqlerrm);
        raise;
END;
/

BEGIN
    sa_boCreatePackages.DropPackage ('GOPC_PACKAGE');
END;
/

