create or replace Package ld_report_generation Is

  -- Author  : LUDYSANLEM
  -- Created : 05/01/2013 01:31:34 p.m.
  -- Purpose : Paquete que estipula el llamado de la generacion de informacion
  /**************************************************************************************************************
  Historia de Modificaciones

    Fecha           IDEntrega

    26-07-2018    HORBATH por mejora en rendimiento se modifica el procedimiento pbogenerateinfo para que cargue tablas temporales 200-1816

    18-12-2013      smunozSAO227685
    Eliminar de la tabla los registros adicionales a los que se solicitaron en la
    pantalla para generar la muestra. SAO227685
    Procedimiento modificado pbogenerateinforandom

    27-08-2013      smunozSAO213366
    Recuperacion de procesos.

    11-08-2013      smunozSAO213828
    Si indica claramente que central y sectores tienen pendiente aprobar su muestra.
    Procedimiento modificado: pboGenerateInfo

    08-08-2013      smunozSAO213862
    Se genera la muestra por sector y producto.
    Procedimientos modificados: pboGenerateInfoRandom, pboGenerateInfo

    01-07-2013      smunozSAO212742
    Se realizan las moficaciones inicializan las variables que permiten contar
    los identificadores de las tablas de errores y sample_detai.  Tambien se
    corrige la unidad de programa uqe calcula el numero de registros a procesar
    para las muestras.
    Procedimientos modificados: pbogenerateinforandom, f_registros_a_procesar.


    31-07-2013      smunozSAO212744
    Se realiza la modificacion para imprimir en estaprog el mensaje referente a
    que la muestra no esta probada para la central.
    Modificacion pbogenerateinfo.

    24-07-2013      smunozSAO215457
    Permitir registrar el avance del proceso
    Creacion f_registros_a_procesar.
    Modificacion pbogenerateinfo, pbogenerateinforandom

    22-07-2013      smunozSAO215459
    Permitir reanudar la ejecucion a partir del punto donde se
    produjo algun error en la ejecucion inmediatamente anterior.
    Modificacion pbogenerateinfo, pbogenerateinforandom


    Fecha           IDEntrega
    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.

  /**************************************************************************************************************/

  Type rgstr_typesector Is Record(
    tstypeid      ld_type_sector.type_id%Type,
    tsdescripcion ld_type_sector.description%Type,
    tsnivel       ld_type_sector.nivel%Type);

  Type rgstr_typefinancial Is Record(
    tfreporttypeid  ld_type_financial_repo.report_type_id%Type,
    tfreportdesc    ld_type_financial_repo.report_desc%Type,
    tfformatid      ld_type_financial_repo.format_id%Type,
    tfcreditb       ld_type_financial_repo.credit_bureau%Type,
    tftypeid        ld_type_financial_repo.sector_type%Type,
    tfproducttypeid ld_type_financial_repo.product_type_id%Type);
   procedure prollenatempo;
   procedure llena_ldc_cuotahistoricfgrcr;
  PROCEDURE LLENAR_LDC_datossesunusefgrcr(R NUMBER);

  /* para validar campos a programar, usado en el Mnemonic FGMAC*/
  Procedure programadofgmac;

  --Generacion de muestra aleatoria

  Procedure pbogenerateinforandom(nucredit_bureau_id  ld_credit_bureau.credit_bureau_id%Type,
                                  sbtype_sector       ld_type_sector.type_id%Type,
                                  sbsubscriber_number ld_selection_criteria.subscriber_number%Type,
                                  dtfechcierr         Date);

  /* para validar campos a programar, usado en el Mnemonic FGRCR*/
  Procedure programadofgrcr;

  --Generacion de muestra completa
  Procedure pbogenerateinfo(sbcredit_bureau_id   ld_credit_bureau.credit_bureau_id%Type,
                            sbtype_sector        ld_type_sector.type_id%Type,
                            dtfechcierr          Date);

  Function fsbversion Return Varchar2;


  Function f_registros_a_procesar(p_muestraoreporte Varchar2) Return Number;

End ld_report_generation;
/
create or replace Package Body ld_report_generation Is

  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  csbversion Constant Varchar2(250) := 267685;

  g_table_name_error    ld_trace_gen_report.table_name%Type;
  g_operation_error     ld_trace_gen_report.operation%Type;
  g_table_name_trace    ld_trace_gen_report.table_name%Type;
  g_operation_trace     ld_trace_gen_report.operation%Type;
  g_credit_bureau_id    ld_sector_product.credit_bureau_id%Type;
  g_type_sector         ld_sector_product.sector_id%Type;
  g_type_product_id     ld_sector_product.product_id%Type;
  g_rec_procesados      Number := 0;
  g_rec_a_procesar      Number := 0;
  g_ultimopasoejecutado Number;
  -- Se crea la variable global g_subscriber_number. smunozSAO213366
  g_subscriber_number ld_selection_criteria.subscriber_number%Type;
  g_fechareporte      Date;
  p_nuano             Number;
  p_numes             Number;

  -- Cursores

  Cursor cusecprod_recup(p_nro_rep Number) Is
  -- Permite obtener los tipos de sector y opcionalmente recuperar informacion de cierto
  -- registro en adelante.
  -- Se obtienen los registros sin consultar por producto, solo por sector. smunozSAO213862
    Select nro_rep,
           code,
           sector_id,
           product_id,
           credit_bureau_id,
           repor_code_bureau,
           nivel,
           description_sector
      From (Select rownum nro_rep,
                   code,
                   sector_id,
                   product_id,
                   credit_bureau_id,
                   repor_code_bureau,
                   nivel,
                   description_sector
              From (Select ld_sector_product.*,
                           ld_type_sector.nivel,
                           ld_type_sector.description description_sector
                      From ld_sector_product, ld_type_sector -- Tabla sin indice porque es muy peque?a
                     Where sector_id = decode(g_type_sector,
                                              -1,
                                              sector_id,
                                              g_type_sector)
                       And credit_bureau_id =
                           decode(g_credit_bureau_id,
                                  -1,
                                  credit_bureau_id,
                                  g_credit_bureau_id)
                       And sector_id = type_id
                     Order By code))
     Where nro_rep >= nvl(p_nro_rep, 1)
     Order By sector_id;

  Cursor cuselcrit(inutypesector     ld_selection_criteria.sector_id%Type,
                   inucreditbereauid ld_selection_criteria.credit_bureau%Type) Is
    Select minimum_amount, subscriber_number, overdue_bills, category
      From ld_selection_criteria
     Where sector_id = inutypesector
       And credit_bureau = inucreditbereauid;

   PROCEDURE LLENAR_LDC_DATOSESU IS
   cursor curserv is select sesunuse from servsusc order by sesunuse ASC;
   n number:=0;
   ri number:=1;
   rf number;
   sr number :=1;
   v number;
   X NUMBER;
   SW BOOLEAN;
   dtFecha DATE;
   cursor r is select * from ldc_rangogenintF;
   BEGIN
     delete from ldc_rangogenintf;
     commit;
     execute immediate 'truncate table LDC_datossesunusefgrcr drop storage';
     for u in curserv loop
         n:=n+1;
         v:=u.sesunuse;
         if n=100000 then
            n:=0;
            rf:=u.sesunuse;
            insert into ldc_rangogenintf (codrango , rangoini , rangofin ,ejecutado ,inicia ,finaliza ,observacion )
                                 values (sr,ri,rf,1,null,null,'EMPEZO');
            ri:=rf+1;
            sr:=sr+1;
         end if;
     end loop;
     if n>0 then
        insert into  ldc_rangogenintf (codrango , rangoini , rangofin ,ejecutado ,inicia ,finaliza ,observacion )
                                 values (sr,ri,v,1,null,null,'EMPEZO');
     end if;
     commit;
     for a in r loop
         dtFecha := (sysdate);
         DBMS_JOB.SUBMIT ( x, 'LD_REPORT_GENERATION.LLENAR_LDC_datossesunusefgrcr('||to_char(a.codrango)||');',dtfecha);
         commit;
     end loop;
     sw:=TRUE;
     while sw loop
           select count(1) into n from ldc_rangogenint where ejecutado=1;
           if n=0 then
              sw:=FALSE;
           end if;
     end loop;   

     update ldcpasosfgrcr  set nullenaservsusc =1;
     COMMIT;
   END;



   PROCEDURE LLENAR_LDC_datossesunusefgrcr(R NUMBER) IS
   INI NUMBER;
   FIN NUMBER;
   FNUPACKAGE_ID number(15);
   FIDENT_TYPE_ID NUMBER(4);
   FIDENTIFICATION VARCHAR2(20);
   FDEBTORNAME VARCHAR2(100);
   FLAST_NAME VARCHAR2(100);
   FCITY_DESC VARCHAR2(100);
   FCITY NUMBER(6);
   FDEPARTMENT_DESC VARCHAR2(100);
   FADDRESS_ID varchar2(200);
   FPROPERTYPHONE_ID NUMBER(15);
   FCITY_COMPANY_DESC varchar2(100);
   FCITY_COMPANY_ID number(6);
   FDEPARTMENTCOMPANY_DESC varchar2(100);
   FCOMPANYADDRESS_ID  VARCHAR2(100);
   FPHONE1_ID NUMBER(15);
   FEMAIL VARCHAR2(100);
   CURSOR CURSERVSUSC IS SELECT SESUNUSE FROM SERVSUSC WHERE SESUNUSE>=INI AND SESUNUSE<=FIN;
   NUFEULPA NUMBER;
   NUFELIPA NUMBER;
   FECIER   date;
   ffff number;
   BEGIN
     SELECT RANGOINI, RANGOFIN INTO INI, FIN FROM LDC_RANGOGENINTF WHERE CODRANGO=R;
     UPDATE LDC_RANGOGENINTF SET INICIA=SYSDATE,OBSERVACION='EN PROCESO' WHERE CODRANGO=R;
     SELECT FECHAC INTO FECIER FROM ldcpasosfgrcr WHERE ROWNUM=1;
     FOR S IN CURSERVSUSC LOOP
         BEGIN
              SELECT nvl(to_number(to_char(MAX(cucofepa), 'yyyymmdd')), 0) fepa
                     INTO nufeulpa
                     FROM cuencobr, factura
                     WHERE cuconuse = S.sesunuse
                           AND cucofact = factcodi
                           AND factfege <= fecier
                           AND cucofepa <= fecier;
         EXCEPTION
              WHEN OTHERS THEN
                   NUFEULPA:=0;
         END;
         BEGIN
              SELECT nvl(to_number(to_char(MAX(cucofeve), 'yyyymmdd')), 0)
                     INTO nufelipa
                     FROM cuencobr, factura
                     WHERE cuconuse = S.sesunuse
                           AND cucofact = factcodi
                           AND factfege <= fecier;
         EXCEPTION
              WHEN OTHERS THEN
                   NUFELIPA:=0;
         END;

         BEGIN
            SELECT p.package_id,
                p.ident_type_id,
                identification,
                debtorname NOMBRE,
                last_name last_name,
                (SELECT ge_geogra_location.description
                        FROM ab_address, ge_geogra_location
                        WHERE ab_address.address_id = p.address_id
                              AND ab_address.geograp_location_id =
                              ge_geogra_location.geograp_location_id) city_desc,
                (SELECT ge_geogra_location.geograp_location_id
                        FROM ab_address, ge_geogra_location
                        WHERE ab_address.address_id = p.address_id
                              AND ab_address.geograp_location_id =
                              ge_geogra_location.geograp_location_id) city,
                (SELECT ge_geogra_location.description
                        FROM ge_geogra_location
                        WHERE geograp_location_id IN
                              (SELECT ge_geogra_location.geo_loca_father_id
                                      FROM ab_address, ge_geogra_location
                                      WHERE ab_address.address_id = p.address_id
                                            AND ab_address.geograp_location_id =
                                            ge_geogra_location.geograp_location_id)) department_desc,
                daab_address.fsbgetaddress(p.address_id, 0) address_id,
                propertyphone_id,
                (SELECT ge_geogra_location.description
                        FROM ab_address, ge_geogra_location
                        WHERE ab_address.address_id = p.companyaddress_id
                              AND ab_address.geograp_location_id =
                              ge_geogra_location.geograp_location_id) city_company_desc,
                (SELECT ge_geogra_location.geograp_location_id
                        FROM ab_address, ge_geogra_location
                        WHERE ab_address.address_id = p.companyaddress_id
                              AND ab_address.geograp_location_id =
                              ge_geogra_location.geograp_location_id) city_company_id,
                (SELECT ge_geogra_location.description
                        FROM ge_geogra_location
                        WHERE geograp_location_id IN
                              (SELECT ge_geogra_location.geo_loca_father_id
                                      FROM ab_address, ge_geogra_location
                     WHERE ab_address.address_id = p.companyaddress_id
                       AND ab_address.geograp_location_id =
                           ge_geogra_location.geograp_location_id)) departmentCOMPANY_desc,
                (SELECT address
                        FROM ab_address
                        WHERE ab_address.address_id = p.companyaddress_id) companyaddress_id,
                phone1_id,
                p.email
                INTO Fnupackage_id,
                     Fident_type_id,
                     Fidentification,
                     FDEBTORNAME,
                     Flast_name,
                     FCITY_DESC,
                     FCITY,
                     FDEPARTMENT_DESC,
                     FADDRESS_ID,
                     FPROPERTYPHONE_ID ,
                     FCITY_COMPANY_DESC ,
                     FCITY_COMPANY_ID ,
                     FDEPARTMENTCOMPANY_DESC ,
                     FCOMPANYADDRESS_ID  ,
                     FPHONE1_ID ,
                     FEMAIL
                FROM ld_promissory p
                WHERE p.package_id =
                      (SELECT MAX(pk.package_id)
                              FROM mo_motive mo, mo_packages pk
                              WHERE mo.package_id = pk.package_id
                                    AND mo.product_id = S.sesunuse
                                    AND pk.package_type_id =
                                        (SELECT numeric_value
                                                FROM ld_parameter
                                                WHERE parameter_id = 'TIPO_SOL_VENTA_FNB'))
                      AND promissory_type = 'D'
                      and rownum=1;
           EXCEPTION
                WHEN OTHERS THEN
                     Fnupackage_id   := NULL;
                     Fident_type_id  := NULL;
                     Fidentification := NULL;
                     FDEBTORNAME     := null;
                     Flast_name      := null;
                     FCITY_DESC      := null;
                     FCITY           := null;
                     FDEPARTMENT_DESC :=null;
                     FADDRESS_ID      := null;
                     FPROPERTYPHONE_ID :=null;
                     FCITY_COMPANY_DESC := null;
                     FCITY_COMPANY_ID := null;
                     FDEPARTMENTCOMPANY_DESC := null;
                     FCOMPANYADDRESS_ID  := null;
                     FPHONE1_ID         := null;
                     FEMAIL           :=null;
           END;
           select count(1) into ffff from LDC_datossesunusefgrcr where nuse=S.sesunuse;
           if ffff=0 then
              INSERT INTO LDC_datossesunusefgrcr(NUSE,vPACKAGE_ID ,
                     vIDENT_TYPE_ID ,
                     vIDENTIFICATION ,
                     vDEBTORNAME ,
                     vLAST_NAME ,
                     vCITY_DESC ,
                     vCITY ,
                     vDEPARTMENT_DESC ,
                     vADDRESS_ID ,
                     vPROPERTYPHONE_ID ,
                     vCITY_COMPANY_DESC ,
                     vCITY_COMPANY_ID ,
                     vDEPARTMENTCOMPANY_DESC ,
                     vCOMPANYADDRESS_ID  ,
                     vPHONE1_ID ,
                     vEMAIL,feulpa,felipa )
             VALUES (S.sesunuse, Fnupackage_id,
                     Fident_type_id,
                     Fidentification,
                     FDEBTORNAME,
                     Flast_name,
                     FCITY_DESC,
                     FCITY,
                     FDEPARTMENT_DESC,
                     FADDRESS_ID,
                     FPROPERTYPHONE_ID ,
                     FCITY_COMPANY_DESC ,
                     FCITY_COMPANY_ID ,
                     FDEPARTMENTCOMPANY_DESC ,
                     FCOMPANYADDRESS_ID  ,
                     FPHONE1_ID ,
                     FEMAIL,nufeulpa,nufelipa      );
               COMMIT;
            end if;
     END LOOP;
     UPDATE LDC_RANGOGENINTF SET FINALIZA=SYSDATE,EJECUTADO=0,OBSERVACION='TERMINO CON EXITO' WHERE CODRANGO=R;
     commit;
   END;


   procedure llena_ldc_cuotahistoricfgrcr is
   fecier date;
   cursor s is select susccodi from suscripc;
   nuavaliblequote number;
   begin
     SELECT FECHAC INTO FECIER FROM ldcpasosfgrcr WHERE ROWNUM=1;
     execute immediate 'truncate table ldc_cuotahistoricfgrcr drop storage';
     for x in s loop
         BEGIN
             SELECT assigned_quote
                    INTO nuavaliblequote
                    FROM (SELECT register_date, assigned_quote
                                 FROM ld_quota_historic
                                 WHERE subscription_id = x.susccodi
                                       AND register_date <= fecier
                                 ORDER BY register_date DESC)
                    WHERE rownum = 1;
         EXCEPTION
             WHEN OTHERS THEN
                  nuavaliblequote := 0;
         END;
         insert into ldc_cuotahistoricfgrcr(susccodi ,asigned_cuote) values(x.susccodi,nuavaliblequote);
         commit;
     end loop;
     update ldcpasosfgrcr set nullenacuota=1;
     commit;
  exception
     when others then
          null;
      --    xinsertfgrcr('me parti llenando llenarldccuotahistoric');
  end;
  procedure prollenatempo is
  FECIER  DATE;
  NANO    NUMBER;
  NMES    NUMBER;
  begin
       SELECT FECHAC,TO_NUMBER(TO_CHAR(FECHAC,'YYYY')),TO_NUMBER(TO_CHAR(FECHAC,'MM')) INTO FECIER,NANO,NMES FROM ldcpasosfgrcr WHERE ROWNUM=1;
       xinsertfgrcr('VOY 0.005 ENTRE A PROCEDIMIENTO DE LLENAR TEMPORALES, VOY A BORRAR TEMPORALES');
       execute immediate ('truncate table ldc_osf_sesucier_t drop storage');
       execute immediate ('truncate table ldc_osf_diferido_t drop storage');
       execute immediate ('truncate table ic_cartcoco_t drop storage');

       xinsertfgrcr('VOY 0.006 BORRE TEMPORALES');
       xinsertfgrcr('VOY 0.006 voy a llenar temporal ic_cartcoco_t');
       insert into ic_cartcoco_t (CACCCONS,CACCNACA,CACCTICL,CACCIDCL,CACCCLIE,CACCSUSC,CACCSERV,CACCNUSE,CACCESCO,CACCUBG1,
                                  CACCUBG2,CACCUBG3,CACCUBG4,CACCUBG5,CACCCATE,CACCSUCA,CACCTICO,CACCPREF,CACCNUFI,CACCCOMP,
                                  CACCCUCO,CACCCONC,CACCSAPE,CACCFEVE,CACCFEGE,CACCVABL,CACCCICL,CACCPLCA)
                       select /*+ index(ic_cartcoco IX_IC_CARTCOCO03) */ CACCCONS,CACCNACA,CACCTICL,CACCIDCL,CACCCLIE,CACCSUSC,CACCSERV,CACCNUSE,CACCESCO,CACCUBG1,
                                  CACCUBG2,CACCUBG3,CACCUBG4,CACCUBG5,CACCCATE,CACCSUCA,CACCTICO,CACCPREF,CACCNUFI,CACCCOMP,
                                  CACCCUCO,CACCCONC,CACCSAPE,CACCFEVE,CACCFEGE,CACCVABL,CACCCICL,CACCPLCA from ic_cartcoco
                                  where caccfege=fecier and caccnuse=caccnuse;
       commit;
       xinsertfgrcr('VOY 0.006 llene temporal ic_cartcoco_t');
       xinsertfgrcr('VOY 0.006 voy a llenar temporal ldc_osf_sesucier_t');
       insert into ldc_osf_sesucier_t (TIPO_PRODUCTO,NUANO,NUMES,CLIENTE,CONTRATO,PRODUCTO,CICLO,SESUSAPE,SALDO_FAVOR,DEPARTAMENTO,
                                     LOCALIDAD,SECTOR,ESTADO_TECNICO,ESTADO_FINANCIERO,ESTADO_CORTE,CATEGORIA,SUBCATEGORIA,NOMBRES,
                                     APELLIDO,SEGUNDO_APELLIDO,EDAD,DEUDA_CORRIENTE_NO_VENCIDA,DEUDA_CORRIENTE_VENCIDA,DEUDA_NO_CORRIENTE,
                                     DEUDA_DIFERIDA_CORRIENTE,DEUDA_DIFERIDA_NO_CORRIENTE,BARRIO,CONSUMO,CODIGO_PREDIO,MANZANA,LADO_MANZANA,
                                     NUMERO_PREDIO,NUMERO_MEJORA,SECUENCIA_TIPO_PREDIO,SEGMENTO_PREDIO,CONSECUTIVO_ZONA_POSTAL,TIPO_CONSUMO,
                                     FLAG_VALOR_RECLAMO,VALOR_RECLAMO,FLAG_PAGO_NO_ABO,VALOR_PAGO_NO_ABONADO,FLAG_EDAD_0_MES,NRO_CTAS_CON_SALDO,
                                     VALOR_CASTIGADO,SECTOR_CATASTRAL,ZONA_CATASTRAL,UBICACION,DIRECCION_PRODUCTO,EDAD_DEUDA,AREA_SERVICIO,
                                     CENTRO_BENEF,CONSUMOS_CERO,ULT_ACT_SUSP,ULTIMO_PLAN_FINA)                           
                              select TIPO_PRODUCTO,NUANO,NUMES,CLIENTE,CONTRATO,PRODUCTO,CICLO,SESUSAPE,SALDO_FAVOR,DEPARTAMENTO,
                                     LOCALIDAD,SECTOR,ESTADO_TECNICO,ESTADO_FINANCIERO,ESTADO_CORTE,CATEGORIA,SUBCATEGORIA,NOMBRES,
                                     APELLIDO,SEGUNDO_APELLIDO,EDAD,DEUDA_CORRIENTE_NO_VENCIDA,DEUDA_CORRIENTE_VENCIDA,DEUDA_NO_CORRIENTE,
                                     DEUDA_DIFERIDA_CORRIENTE,DEUDA_DIFERIDA_NO_CORRIENTE,BARRIO,CONSUMO,CODIGO_PREDIO,MANZANA,LADO_MANZANA,
                                     NUMERO_PREDIO,NUMERO_MEJORA,SECUENCIA_TIPO_PREDIO,SEGMENTO_PREDIO,CONSECUTIVO_ZONA_POSTAL,TIPO_CONSUMO,
                                     FLAG_VALOR_RECLAMO,VALOR_RECLAMO,FLAG_PAGO_NO_ABO,VALOR_PAGO_NO_ABONADO,FLAG_EDAD_0_MES,NRO_CTAS_CON_SALDO,
                                     VALOR_CASTIGADO,SECTOR_CATASTRAL,ZONA_CATASTRAL,UBICACION,DIRECCION_PRODUCTO,EDAD_DEUDA,AREA_SERVICIO,
                                     CENTRO_BENEF,CONSUMOS_CERO,ULT_ACT_SUSP,ULTIMO_PLAN_FINA from ldc_osf_sesucier where nuano=nano and numes=nmes ;
       commit;
       xinsertfgrcr('VOY 0.006 llene temporal ldc_osf_sesucier_t');
       xinsertfgrcr('VOY 0.006 voy a llenar temporal ldc_osf_diferido_t');                                   
       insert into ldc_osf_diferido_t (DIFEANO,DIFEMES,DIFECODI,DIFESUSC,DIFECONC,DIFEVATD,DIFEVACU,DIFECUPA,DIFENUCU,DIFESAPE,DIFENUDO,DIFEINTE,
                                       DIFEINAC,DIFEUSUA,DIFETERM,DIFESIGN,DIFENUSE,DIFEMECA,DIFECOIN,DIFEPROG,DIFEPLDI,DIFEFEIN,DIFEFUMO,DIFESPRE,
                                       DIFETAIN,DIFEFAGR,DIFECOFI,DIFETIRE,DIFEFUNC,DIFELURE,DIFEENRE,DIFECORR,DIFENCORR)                                          
                               select DIFEANO,DIFEMES,DIFECODI,DIFESUSC,DIFECONC,DIFEVATD,DIFEVACU,DIFECUPA,DIFENUCU,DIFESAPE,DIFENUDO,DIFEINTE,
                                       DIFEINAC,DIFEUSUA,DIFETERM,DIFESIGN,DIFENUSE,DIFEMECA,DIFECOIN,DIFEPROG,DIFEPLDI,DIFEFEIN,DIFEFUMO,DIFESPRE,
                                       DIFETAIN,DIFEFAGR,DIFECOFI,DIFETIRE,DIFEFUNC,DIFELURE,DIFEENRE,DIFECORR,DIFENCORR
                                       from ldc_osf_diferido where difeano=nano and difemes=nmes;
       xinsertfgrcr('VOY 0.006 llene temporal ldc_osf_diferido_t');                                       
       xinsertfgrcr('VOY 0.006 LLENE TEMPORALES');
       update ldcpasosfgrcr set nupasotemporales=1;
       commit;
  end;


  Procedure programadofgmac Is

    cnunull_attribute Constant Number := 2126;
    gsberrmsg ge_error_log.description%Type;

    sbcredit_bureau_id  ge_boinstancecontrol.stysbvalue;
    sbtype_sector       ge_boinstancecontrol.stysbvalue;
    sbsubscriber_number ge_boinstancecontrol.stysbvalue;



  Begin

    pkerrors.push('ld_report_generation.programadofgmac');

    sbcredit_bureau_id := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE',
                                                                'CREDIT_BUREAU_ID');

    sbtype_sector      := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE',
                                                                'TYPE_SECTOR');

    sbsubscriber_number := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE',
                                                                 'SUBSCRIBER_NUMBER');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    If (sbcredit_bureau_id Is Null) Then
      errors.seterror(cnunull_attribute, 'Cod. Central de Riesgo');
      Raise ex.controlled_error;
    End If;

    If (sbtype_sector Is Null) Then
      errors.seterror(cnunull_attribute, 'Tipo de Sector');
      Raise ex.controlled_error;
    End If;

    If (sbsubscriber_number Is Null) Then
      errors.seterror(cnunull_attribute, 'Num. Suscriptores');
      Raise ex.controlled_error;
    End If;

    ------------------------------------------------
    -- User code
    ------------------------------------------------
    pkerrors.pop;
  Exception
    When ex.controlled_error Then
      pkerrors.pop;
      Raise;

    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  End;

  Function f_registros_a_procesar(p_muestraoreporte Varchar2) Return Number Is
    /****************************************************************************

     Proposito:  Calcula el numero de registros a procesar

     Historia de Modificaciones

     Fecha           IDEntrega
     24-09-2013      slemusSAO217833
     Se crea cursor para tener en cuenta los criterios por categoria

     01-08-2013      smunozSAO212742
     Se corrige la funcion para que solo se ejecute los cursores diferidos_not_exists
     y servicios_not_exists para reportes.

     24-07-2013      smunozSAO215457
     Creacion.

     DD-MM-2013      usuarioSAO######
     Descripcion breve, precisa y clara de la modificacion realizada.

    ****************************************************************************/

    -- Proposito:
    v_reg_a_procesar            Number;
    v_exists                    Boolean;
    v_amount                    ld_selection_criteria.minimum_amount%Type;
    v_subsnumber                ld_selection_criteria.subscriber_number%Type;
    v_overduebills              ld_selection_criteria.overdue_bills%Type;
    v_category                  ld_selection_criteria.category%Type;
    v_registros_a_procesar      Number := 0;
    v_reportar_codeudor_central ld_general_parameters.text_value%Type;
    v_respuesta                 Number(8);
    nuanogen                    Number;
    numesgen                    Number;
  Begin

    nuanogen         := to_number(to_char(g_fechareporte, 'yyyy'));
    numesgen         := to_number(to_char(g_fechareporte, 'mm'));

    For r_secprod_recup In cusecprod_recup(1) Loop
      -- Se debe obtener la informacion por sector. smunozSAO213862

      provapatapa('REPORTAR_CODEUDOR_CENTRAL',
                  'S',
                  v_respuesta,
                  v_reportar_codeudor_central);

      /* v_exists := ld_bcselectioncriteria.fbogetselectioncriteriaid(r_secprod_recup.sector_id,
      r_secprod_recup.credit_bureau_id,
      v_amount,
      v_subsnumber,
      v_overduebills,
      v_category);*/
      For regselcrit In cuselcrit(r_secprod_recup.sector_id,
                                  r_secprod_recup.credit_bureau_id) Loop

        v_amount       := regselcrit.minimum_amount;
        v_subsnumber   := regselcrit.subscriber_number;
        v_overduebills := regselcrit.overdue_bills;
        v_category     := regselcrit.category;

        If (upper(r_secprod_recup.nivel) = 'P') Then

          For r_servicios In ld_bcgenerationrandomsample.cu_servicios(p_credit_bureau_id  => r_secprod_recup.credit_bureau_id,
                                                                      p_typesector        => r_secprod_recup.sector_id,
                                                                      p_typeproductid     => r_secprod_recup.product_id,
                                                                      p_category          => v_category,
                                                                      p_overduebills      => v_overduebills,
                                                                      p_repomuestra       => p_muestraoreporte,
                                                                      p_subscriber_number => g_subscriber_number,
                                                                      p_nuano             => nuanogen,
                                                                      p_numes             => numesgen) Loop

            v_registros_a_procesar := v_registros_a_procesar +
                                      r_servicios.total;
            Exit;
            /*If v_reportar_codeudor_central = 'S' Then

              For r_codeudores_ser In ld_bcgenerationrandomsample.cu_codeudor_ser(p_cunuserv => r_servicios.sesunuse) Loop
                v_registros_a_procesar := v_registros_a_procesar + 1;
              End Loop; -- For r_cu_codeudores_ser In ld_bcgenerationrandomsample.cu_codeudor_ser Loop

            End If; -- If g_reportar_codeudor_central = 'S' Then*/

          End Loop; -- For r_cu_servicios In ld_bcgenerationrandomsample.cu_servicios(p_credit_bureau_id  => g_credit_bureau_id,

          -- Solo se calcula para reportes. smunozSAO212742
/*          If p_muestraoreporte = 'R' Then
            For r_servicios_not_exists In ld_bcgenerationrandomsample.cu_servicios_not_exists(p_credit_bureau_id => r_secprod_recup.credit_bureau_id,
                                                                                              p_typeproductid    => r_secprod_recup.product_id,
                                                                                              p_category         => v_category,
                                                                                              p_overduebills     => v_overduebills) Loop
              v_registros_a_procesar := v_registros_a_procesar +
                                        r_servicios_not_exists.total;
             Exit;

            If v_reportar_codeudor_central = 'S' Then

              For r_codeudores_ser In ld_bcgenerationrandomsample.cu_codeudor_ser(p_cunuserv => r_servicios_not_exists.sesunuse) Loop
                v_registros_a_procesar := v_registros_a_procesar + 1;
              End Loop; -- For r_cu_codeudores_ser In ld_bcgenerationrandomsample.cu_codeudor_ser Loop

            End If; -- If g_reportar_codeudor_central = 'S' Then*\

            End Loop;
          End If; -- If p_muestraoreporte = 'R' Then
*/
        Elsif (upper(r_secprod_recup.nivel) = 'D') Then

          For r_diferido In ld_bcgenerationrandomsample.cu_diferido(p_amount            => v_amount,
                                                                    p_subscriber_number => g_subscriber_number,
                                                                    p_duebil            => v_overduebills,
                                                                    p_category          => v_category,
                                                                    p_typeproductid     => r_secprod_recup.product_id,
                                                                    p_repomuestra       => p_muestraoreporte,
                                                                    p_credit_bureau_id  => r_secprod_recup.credit_bureau_id) Loop

            v_registros_a_procesar := v_registros_a_procesar +
                                      r_diferido.total;
            Exit;

          /*If v_reportar_codeudor_central = 'S' Then

                                                                                                                                                For r_codeudores_dif In ld_bcgenerationrandomsample.cu_codeudor_dif(p_cudifcodi => r_diferido.sesunuse) Loop
                                                                                                                                                  v_registros_a_procesar := v_registros_a_procesar + 1;
                                                                                                                                                End Loop; -- For r_cu_codeudores_ser In ld_bcgenerationrandomsample.cu_codeudor_ser Loop

                                                                                                                                              End If; -- If g_reportar_codeudor_central = 'S' Then*/

          End Loop; -- For r_cu_servicios In ld_bcgenerationrandomsample.cu_servicios(p_credit_bureau_id  => g_credit_bureau_id,

          -- Solo se calcula para reportes. smunozSAO212742
          If p_muestraoreporte = 'R' Then
            For r_diferidos_not_exists In ld_bcgenerationrandomsample.cu_diferido_not_exists(p_amount           => v_amount,
                                                                                             p_duebil           => v_overduebills,
                                                                                             p_category         => v_category,
                                                                                             p_typeproductid    => r_secprod_recup.product_id,
                                                                                             p_credit_bureau_id => r_secprod_recup.credit_bureau_id) Loop

              v_registros_a_procesar := v_registros_a_procesar +
                                        r_diferidos_not_exists.total;
              Exit;

            /*If v_reportar_codeudor_central = 'S' Then

                                                                                                                                                                            For r_cu_codeudores_dif In ld_bcgenerationrandomsample.cu_codeudor_dif(p_cudifcodi => r_diferidos_not_exists.sesunuse) Loop
                                                                                                                                                                              v_registros_a_procesar := v_registros_a_procesar + 1;
                                                                                                                                                                            End Loop; -- For r_cu_codeudores_ser In ld_bcgenerationrandomsample.cu_codeudor_ser Loop

                                                                                                                                                                          End If; -- If g_reportar_codeudor_central = 'S' Then*/

            End Loop;
          End If; -- If p_muestraoreporte = 'R' Then
        End If; -- If (upper(rgstrsector.nivel) = 'P') Then
      End Loop;
    End Loop; -- For r_cusecprod_recup In cusecprod_recup Loop

    Return v_registros_a_procesar;
  Exception
    When Others Then
      Return - 1;
  End;

  --Generacion de muestra aleatoria
  Procedure pbogenerateinforandom(nucredit_bureau_id  ld_credit_bureau.credit_bureau_id%Type,
                                  sbtype_sector       ld_type_sector.type_id%Type,
                                  sbsubscriber_number ld_selection_criteria.subscriber_number%Type,
                                  dtfechcierr         Date) Is

    /**************************************************************************************************************
    Proposito: Generacion de la muestra
    Historia de Modificaciones

      Fecha           IDEntrega


      18-12-2013      smunozSAO227685
      Eliminar de la tabla los registros adicionales a los que se solicitaron en la
      pantalla para generar la muestra. SAO227685


      16-08-2013      kcienfuegosSAO214729
      Se registra en ge_error_log

      08-08-2013      smunozSAO213862
      Se genera la muestra por sector, por tanto no se requiere el parametro producto.

      24-07-2013      smunozSAO212742
      Permitir registrar el avance del proceso


      22-07-2013      smunozSAO215459
      Permitir reanudar la ejecucion a partir del punto donde se
      produjo algun error en la ejecucion inmediatamente anterior.


      Fecha           IDEntrega
      DD-MM-2013      usuarioSAO######
      Descripcion breve, precisa y clara de la modificacion realizada.

    /**************************************************************************************************************/

    cnunull_attribute Constant Number := 2126;
    gsberrmsg ge_error_log.description%Type;

    -- Se inicializan las variables. smunozSAO212742. 01-08-2013
    ionutotalrec Number := 0;
    ionutotalerr Number := 0;
    ionutotalnov Number := 0;

    /* Cursor para listar los tipos de sector */
    -- Ya no se consulta por producto ya que se va a generar muestra por sector. smunozSAO213862
    Cursor cusecprod Is
      Select ld_sector_product.*, ld_type_sector.nivel

        From ld_sector_product, ld_type_sector

       Where sector_id =
             decode(sbtype_sector, -1, sector_id, sbtype_sector)
         And credit_bureau_id =
             decode(nucredit_bureau_id,
                    -1,
                    credit_bureau_id,
                    nucredit_bureau_id)
         And sector_id = type_id
       Order By code;

    /* Variable global cursor CuSector */
    rgstrsector            cusecprod%Rowtype;
    nuerror                Number;
    sberrormessage         Varchar2(2000);
    seq_estaprog           Number;
    sbprograma             estaprog.esprprog%Type := 'FGMAC';
    nucode                 ld_sector_product.code%Type := 0;
    sbtipogen              Varchar2(1);
    nusecuencia            Number;
    nutotalrec             ld_sample_fin.number_of_record%Type;
    nutotalerr             Number;
    nutotalnov             ld_sample_fin.sum_of_new%Type;
    sbult_sector_proc      ld_sector_product.sector_id%Type; -- Ultimo sector procesado
    sbult_product_proc     ld_sector_product.product_id%Type; -- Ultimo producto procesado
    nulastcredit_bureau_id ld_sector_product.credit_bureau_id%Type; -- Ultima central procesada
    nulastsector_id        ld_sector_product.sector_id%Type; -- Ultimo sector procesado
    nulastproduct_id       ld_sector_product.product_id%Type; -- Ultimo producto procesado
    sbcambiosector         Varchar2(1); -- Indica si el sector cambio
    sbcambioproducto       Varchar2(1); -- Indica si el producto cambio
    sbnomlog               Varchar2(200);
    sbnomcent              Varchar2(200);
    isruta                 Varchar2(60);
    vnulogarc              utl_file.file_type;
  Begin

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    pkerrors.push('ld_report_generation.pbogenerateinforandom');

    seq_estaprog := sqesprprog.nextval;

    -- Calcula el numero de registros a procesar y se usa para insertar
    -- el registro en estaprog. smunozSAO213266
    pkstatusexeprogrammgr.addrecord(sbprograma || seq_estaprog,
                                    'Calculando Registros a Procesar ...',
                                    0);

    pkgeneralservices.committransaction;

    g_credit_bureau_id  := nucredit_bureau_id;
    g_type_sector       := sbtype_sector;
    g_subscriber_number := sbsubscriber_number;
    g_fechareporte      := dtfechcierr;

    g_rec_a_procesar    := f_registros_a_procesar(p_muestraoreporte => 'M');

    -- Inserta el registro de seguimiento del proceso en ESTAPROG
    pkstatusexeprogrammgr.updateestaprogat(sbprograma || seq_estaprog,
                                           'Proceso en Ejecuccion..',
                                           g_rec_a_procesar,
                                           Null);

    -- Aisenta en la base de datos el registro de seguimiento de la ejecucion del Proceso
    pkgeneralservices.committransaction;
    If (nucredit_bureau_id Is Null) Then
      errors.seterror(cnunull_attribute, 'Cod. Central de Riesgo');
      Raise ex.controlled_error;
    End If;

    If (sbtype_sector Is Null) Then
      errors.seterror(cnunull_attribute, 'Tipo de Sector');
      Raise ex.controlled_error;
    End If;

    If (sbsubscriber_number Is Null) Then
      errors.seterror(cnunull_attribute, 'Num. Suscriptores');
      Raise ex.controlled_error;
    End If;

    If g_credit_bureau_id = 1 Then
      sbnomcent := 'DATACREDITO_' || to_char(Sysdate, 'ddmmyyyy');

    Else
      sbnomcent := 'CIFIN_' || to_char(Sysdate, 'ddmmyyyy');

    End If;

    /* Validacion sector Comercial */
    Open cusecprod;
    Loop
      Fetch cusecprod
        Into rgstrsector;
      Exit When cusecprod%Notfound;

      -- Se genera la muestra por sector y producto. smunozSAO213862
      If nucode = rgstrsector.code Then
        nucode    := rgstrsector.code;
        sbtipogen := 'C';

        -- Identificar si se esta procesando otro sector. smunozSAO213862
        If nulastsector_id = rgstrsector.sector_id Then
          sbcambiosector := 'N';
          -- Identificar si se esta procesando otro producto. smunozSAO213862
          If nulastproduct_id = rgstrsector.product_id Then
            sbcambioproducto := 'N';
          Else
            sbcambioproducto := 'S';
          End If; -- If nuUltProductId = rgstrsector.product_id Then
        Else
          sbcambiosector   := 'S';
          sbcambioproducto := 'S';
        End If; -- If nuUltSectorId = rgstrsector.sector_id Then

      Else
        nucode       := rgstrsector.code;
        nusecuencia  := seq_ld_random_sample.nextval;
        sbtipogen    := 'N';
        ionutotalerr := 0;
        ionutotalrec := 0;
        ionutotalnov := 0;

        -- Reiniciar los valores que identifican si se esta procesando otra central,
        -- otro sector o producto. smunozSAO213862
        nulastcredit_bureau_id := rgstrsector.credit_bureau_id;
        nulastsector_id        := rgstrsector.sector_id;
        nulastproduct_id       := rgstrsector.product_id;
        sbcambiosector         := 'N';
        sbcambioproducto       := 'N';
      End If;

      If (upper(rgstrsector.nivel) = 'P') Then
        ionutotalrec          := 0;
        g_ultimopasoejecutado := 0;

        ld_bcgenerationrandomsample.pbogenerationser(p_inucreditbereauid    => rgstrsector.credit_bureau_id,
                                                     p_inutypesector        => rgstrsector.sector_id,
                                                     p_inutypeproductid     => rgstrsector.product_id,
                                                     p_isbsubscriber_number => sbsubscriber_number,
                                                     p_innusampleid         => nusecuencia,
                                                     p_insbtypegen          => sbtipogen,
                                                     p_ionutotalrec         => ionutotalrec,
                                                     p_ionutotalerr         => ionutotalerr,
                                                     p_ionutotalnov         => ionutotalnov,
                                                     p_idtfechgen           => dtfechcierr,
                                                     p_isbrepomuestra       => 'M',
                                                     p_onuerrorcode         => nuerror,
                                                     p_osberrormessage      => sberrormessage,
                                                     p_table_name_trace     => g_table_name_trace,
                                                     p_operation_trace      => g_operation_trace,
                                                     p_table_name_error     => g_table_name_trace,
                                                     p_operation_error      => g_operation_trace,
                                                     p_rec_procesados       => g_rec_procesados,
                                                     p_rec_a_procesar       => g_rec_a_procesar,
                                                     p_program_id           => sbprograma ||
                                                                               seq_estaprog,
                                                     p_nucambiosector       => sbcambiosector,
                                                     p_nucambioproducto     => sbcambioproducto);

        /* Confirmar registro */
        If (nuerror = 0) Then
          Commit;
        Else
          errors.seterror(nuerror, sberrormessage);
          Raise ex.controlled_error;
        End If;
      End If;

      If (upper(rgstrsector.nivel) = 'D') Then

        g_ultimopasoejecutado := 0;
        ld_bcgenerationrandomsample.pbogenerationdif(p_nucreditbereauid    => rgstrsector.credit_bureau_id,
                                                     p_inutypesector       => rgstrsector.sector_id,
                                                     p_inutypeproductid    => rgstrsector.product_id,
                                                     p_innusampleid        => nusecuencia,
                                                     p_sbsubscriber_number => sbsubscriber_number,
                                                     p_insbtypegen         => sbtipogen,
                                                     p_ionutotalrec        => ionutotalrec,
                                                     p_ionutotalerr        => ionutotalerr,
                                                     p_ionutotalnov        => ionutotalnov,
                                                     p_idtfechgen          => dtfechcierr,
                                                     p_onuerrorcode        => nuerror,
                                                     p_osberrormessage     => sberrormessage,
                                                     p_isbrepomuestra      => 'M',
                                                     p_table_name_trace    => g_table_name_trace,
                                                     p_operation_trace     => g_operation_trace,
                                                     p_table_name_error    => g_table_name_trace,
                                                     p_operation_error     => g_operation_trace,
                                                     p_rec_procesados      => g_rec_procesados,
                                                     p_rec_a_procesar      => g_rec_a_procesar,
                                                     p_program_id          => sbprograma ||
                                                                              seq_estaprog,
                                                     p_nucambiosector      => sbcambiosector,
                                                     p_nucambioproducto    => sbcambioproducto);

        /* Confirmar registro */
        If (nuerror = 0) Then
          Commit;
        Else
          errors.seterror(nuerror, sberrormessage);
          Raise ex.controlled_error;
        End If;
      End If;

    End Loop;

    -- Eliminar de la tabla los registros adicionales a los que se solicitaron en la
    -- pantalla para generar la muestra. SAO227685
    ld_bcgenerationrandomsample.proelimregistrosadicmuestra(inurandom_sample_id => nusecuencia,
                                                            nutotalreg          => sbsubscriber_number);

    pkstatusexeprogrammgr.upstatusexeprogramat(isbprog       => sbprograma ||
                                                                seq_estaprog,
                                               isbmens       => Null,
                                               inutotalreg   => g_rec_a_procesar,
                                               inucurrentreg => g_rec_procesados);

    pkstatusexeprogrammgr.processfinishok(sbprograma || seq_estaprog);
    Commit;
    --pkgeneralservices.committransaction;
    pkerrors.pop;
  Exception
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           nuerror,
                           sberrormessage);
      -- Se graba el resultado del proceso  indicando el error. smunozSAO212742.
      pkstatusexeprogrammgr.upstatusexeprogramat(isbprog       => sbprograma ||
                                                                  seq_estaprog,
                                                 isbmens       => 'Proceso terminado con error. ' ||
                                                                  sberrormessage,
                                                 inutotalreg   => g_rec_a_procesar,
                                                 inucurrentreg => g_rec_procesados);
      pkstatusexeprogrammgr.processfinishnok(sbprograma || seq_estaprog,
                                             'Proceso terminado con error. ' ||
                                             sberrormessage);
      pkgeneralservices.committransaction;
      dbms_application_info.set_module(module_name => 'FGMAC',
                                       action_name => Null);
      errors.seterror;
      ge_boerrors.seterrorcodeargument(2741, sberrormessage);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, sberrormessage);
  End;

  Procedure programadofgrcr Is

    cnunull_attribute Constant Number := 2126;
    gsberrmsg ge_error_log.description%Type;

    sbcredit_bureau_id ge_boinstancecontrol.stysbvalue;
    sbtype_sector      ge_boinstancecontrol.stysbvalue;

  Begin
    pkerrors.push('ld_report_generation.programadofgrcr');
    sbcredit_bureau_id := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE',
                                                                'CREDIT_BUREAU_ID');
    sbtype_sector      := ge_boinstancecontrol.fsbgetfieldvalue('LD_SAMPLE',
                                                                'TYPE_SECTOR');

    If (sbcredit_bureau_id Is Null) Then
      errors.seterror(cnunull_attribute, 'Cod. Central de Riesgo');
      Raise ex.controlled_error;
    End If;

    If (sbtype_sector Is Null) Then
      errors.seterror(cnunull_attribute, 'Tipo de Sector');
      Raise ex.controlled_error;
    End If;

    pkerrors.pop;
  Exception
    When ex.controlled_error Then
      pkerrors.pop;
      Raise;

    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  End;

  --Generacion de muestra completa
  Procedure pbogenerateinfo(sbcredit_bureau_id ld_credit_bureau.credit_bureau_id%Type,
                            sbtype_sector      ld_type_sector.type_id%Type,
                            dtfechcierr        Date) Is

    /**************************************************************************************************************
    Proposito: Generacion de reportes
    Historia de Modificaciones

      Fecha           IDEntrega

      11-08-2013      smunozSAO213828
      Si indica claramente que central y sectores tienen pendiente aprobar su muestra.

      08-08-2103      smunozSAO213862
      Ya no se solicita por parametro el producto ya que se va a generar reporte por sector

      31-07-2013      smunozSAO212744
      Se realiza la modificacion para imprimir en estaprog el mensaje referente a
      que la muestra no esta probada para la central

      24-07-2013      smunozSAO215457
      Permitir registrar el avance del proceso


      22-07-2013      smunozSAO215459
      Permitir reanudar la ejecucion a partir del punto donde se
      produjo algun error en la ejecucion inmediatamente anterior.


      Fecha           IDEntrega
      DD-MM-2013      usuarioSAO######
      Descripcion breve, precisa y clara de la modificacion realizada.

    /**************************************************************************************************************/

    cnunull_attribute Constant Number := 2126;
    gsberrmsg ge_error_log.description%Type;

    rgstrsector cusecprod_recup%Rowtype;

    nuerror Number;
    nucode  ld_sector_product.code%Type := 0;
    -- Se cambia el tipo de dato de la variable Sberrormessage que almacena el error para que pueda
    -- mostrar mas informacion, estaba como Varchar2(1000). smunozSAO213828
    sberrormessage         estaprog.esprmesg%Type;
    nusecuencia            Number;
    sbtipogen              Varchar2(1);
    nutotalrec             ld_sample_fin.number_of_record%Type;
    nutotalerr             Number;
    nutotalnov             ld_sample_fin.sum_of_new%Type;
    dtfechgen              Date;
    boexists               Boolean;
    bosample               Boolean;
    nuamount               ld_selection_criteria.minimum_amount%Type;
    nusubsnumber           ld_selection_criteria.subscriber_number%Type;
    nuoverduebills         ld_selection_criteria.overdue_bills%Type;
    nucategory             ld_selection_criteria.category%Type;
    seq_estaprog           Number;
    sbprograma             estaprog.esprprog%Type := 'FGRCR';
    numreg                 Number;
    nutotal                Number := 0;
    v_table_name           user_tables.table_name%Type;
    v_nro_rep              ld_trace_gen_report.nro_rep%Type := 1;
    r_ld_trace             ld_trace_gen_report%Rowtype;
    v_ultimo_rep_con_error Varchar2(1);
    sbult_sector_proc      ld_sector_product.sector_id%Type; -- Ultimo sector procesado
    sbult_product_proc     ld_sector_product.product_id%Type; -- Ultimo producto procesado
    nulastsector_id        ld_sector_product.sector_id%Type; -- Ultimo sector procesado
    nulastproduct_id       ld_sector_product.product_id%Type; -- Ultimo producto procesado
    sbcambiosector         Varchar2(1); -- Indica si el sector cambio
    sbcambioproducto       Varchar2(1); -- Indica si el producto cambio
    DTFECHAJ DATE;
    XJ NUMBER;
    swj boolean;
    vnupasotemporales ldcpasosfgrcr.nupasotemporales%type;
    vnullenaservsusc  ldcpasosfgrcr.nullenaservsusc%type;
    vnullenacuota     ldcpasosfgrcr.nullenacuota%type;
    -- Se crean variables para permitir identificar que centrales y sectores
    -- no tienen muestra aprobada. smunozSAO213828
    nulastcreditbureauapr ld_sector_product.credit_bureau_id%Type; -- Codigo de la ulitma central que se estaba verificando si tiene todas sus muestras aprobadas
    nulastsectorapr       ld_sector_product.sector_id%Type; -- Codigo del ultimo sector al que se le ha verificado si tiene muestra aprobada
    sbfaltaaprobacion     Varchar2(1) := 'N'; -- Indica si por lo menos algun sector de los procesados no tiene muestra aprobada
    CORREO              VARCHAR2(2000);
    sbsubject           Varchar2(255) := '';
  Begin
    delete from xtracefgrcr;
    commit;
    xinsertfgrcr('VOY 0.00');
    pkerrors.push('ld_report_generation.Pbogenerateinfo');

    BEGIN
        SELECT VALUE_CHAIN INTO CORREO
        FROM LD_PARAMETER
        WHERE PARAMETER_ID = 'MAILFGRCR';
    EXCEPTION
      WHEN no_data_found THEN
        CORREO := '';
    END;

    IF CORREO is not null THEN
        sbsubject := 'Notificacion: Procesos FGRCR ';
                LDC_ENVIAMAIL('<'||CORREO||'>',
                              sbsubject,
                              'Inicia La ejecucion del Proceso: FGRCR'
                              );
    END IF;
    /*Se inicializa el atributo donde se almacenara el id de la secuencia de la entidad estaprog*/
    seq_estaprog := sqesprprog.nextval;

    pkstatusexeprogrammgr.addrecord(sbprograma || seq_estaprog,
                                    'Calculando Registros a Procesar ...',
                                    0);
    pkgeneralservices.committransaction;
    -- LLENA TEMPORALES SOBRE LA CUAL SE HARAN LOS QUERYS QUE TIENEN MAYOR COMPLEJIDAD
    xinsertfgrcr('VOY 0.10 VOY A LLENAR TEMPORALES X MEDIO DE LOS JOB');

    EXECUTE IMMEDIATE 'TRUNCATE TABLE ldcpasosfgrcr DROP STORAGE';

    INSERT INTO ldcpasosfgrcr (FECHAC ,nupasotemporales ,nullenaservsusc , nullenacuota ) VALUES(dtfechcierr, 0,0,0);
    COMMIT;

    dtFechaJ := (sysdate);
    DBMS_JOB.SUBMIT ( xJ, 'LD_REPORT_GENERATION.PROLLENATEMPO;',dtfechaJ);
    commit;

    dtFechaJ := (sysdate);
    DBMS_JOB.SUBMIT ( xJ, 'LD_REPORT_GENERATION.llena_ldc_cuotahistoricfgrcr;',dtfechaJ);
    commit;

    LLENAR_LDC_DATOSESU;    
   -- dtFechaJ := (sysdate);
   -- DBMS_JOB.SUBMIT ( xJ, 'LD_REPORT_GENERATION.LLENAR_LDC_datossesunusefgrcr;',dtfechaJ);
   -- commit;

 --   xinsertfgrcr('VOY 0.21 VINE DE PROGRAMAR TEMPORALES por medio del job');
    -- TERMINA DE LLENAR TEMPORALES SOBRE LA CUAL SE HARAN LOS QUERYS QUE TIENEN MAYOR COMPLEJIDAD


    swj:=true;
    while swj loop
          select nupasotemporales ,nullenaservsusc , nullenacuota into vnupasotemporales ,vnullenaservsusc , vnullenacuota from ldcpasosfgrcr;
          if vnupasotemporales=1 and vnullenaservsusc =1  and vnullenacuota=1 then
             swj:=false;
          end if;
    end loop;
   xinsertfgrcr('VOY 0.21 VINE DE LLENAR TEMPORALES por medio de los jobs');
   -- pkstatusexeprogrammgr.addrecord(sbprograma || seq_estaprog,'Calculando Registros a Procesar ...',0);
   -- pkgeneralservices.committransaction;
    g_fechareporte := dtfechcierr;

    g_credit_bureau_id := sbcredit_bureau_id;
    g_type_sector      := sbtype_sector;
    g_rec_a_procesar   := f_registros_a_procesar(p_muestraoreporte => 'R');
    xinsertfgrcr('VOY 0.211 VINE DE CALCULAR REGISTROS A PROCESAR='||TO_CHAR(g_rec_a_procesar));
    -- Inserta el registro de seguimiento del proceso en ESTAPROG
    pkstatusexeprogrammgr.updateestaprogat(sbprograma || seq_estaprog,
                                           'Proceso en Ejecuccion',
                                           g_rec_a_procesar,
                                           Null);

    -- Aisenta en la base de datos el registro de seguimiento de la ejecucion del Proceso
    pkgeneralservices.committransaction;
    dtfechgen := trunc(Sysdate);
    ut_trace.trace('Antes de Valdaciones', 1);

    -- Identifica a partir de que dato debe procesarse la informacion
    Begin
      Select * Into r_ld_trace From ld_trace_gen_report;

      if r_ld_trace.sector is null then
      v_ultimo_rep_con_error := 'S';
      else 
         v_ultimo_rep_con_error := 'N';
      end if;
    Exception
      When Others Then
        v_ultimo_rep_con_error := 'N';
    End;
    ut_trace.trace('Antes de Realiza Valdaciones de Producto por Sector',
                   2);
    Open cusecprod_recup(1);

    xinsertfgrcr('VA A REALIZAR VALIDACIONES');

    Loop
      xinsertfgrcr('VA A REALIZAR VALIDACIONES 1111');
      Fetch cusecprod_recup
        Into rgstrsector;
      ut_trace.trace('Valida Sector: ' || rgstrsector.sector_id, 3);

      numreg := cusecprod_recup%Rowcount;
      Exit When cusecprod_recup%Notfound;
      -- Se debe obtener la informacion por sector. smunozSAO213862
      boexists := ld_bcselectioncriteria.fbogetselectioncriteriaid(rgstrsector.sector_id,
                                                                   rgstrsector.credit_bureau_id,
                                                                   nuamount,
                                                                   nusubsnumber,
                                                                   nuoverduebills,
                                                                   nucategory);

      If pkld_general_rules.frequiresaproval(rgstrsector.credit_bureau_id) Then

        -- Se debe obtener la informacion por sector. smunozSAO213862
        bosample := pkld_general_rules.fboprevalidatesampleaproval(rgstrsector.sector_id,
                                                                   rgstrsector.credit_bureau_id,
                                                                   g_fechareporte);

        If Not bosample Then
          -- Construir el mensaje de error. smunozSAO213828
          sbfaltaaprobacion := 'S';
          If nulastcreditbureauapr Is Null Or
             nulastcreditbureauapr <> rgstrsector.credit_bureau_id Then

            ut_trace.trace('Valida aprobacion, para central: ' ||
                           rgstrsector.credit_bureau_id,
                           4);

            If nulastcreditbureauapr Is Null Then

              sberrormessage := sberrormessage ||
                                ld_bcequivalreport.fnugetcreditbureaudesc(rgstrsector.credit_bureau_id) ||
                                ', sector(es): ';
            Else
              sberrormessage := sberrormessage || '. ' ||
                                ld_bcequivalreport.fnugetcreditbureaudesc(rgstrsector.credit_bureau_id) ||
                                ', sector(es): ';
            End If;
            nulastcreditbureauapr := rgstrsector.credit_bureau_id;
            nulastsectorapr       := Null;

          End If; --  If Not Nulastcreditbureauapr = Rgstrsector.Credit_Bureau_Id Then

          If nulastsectorapr Is Null Or
             nulastsectorapr <> rgstrsector.sector_id Then
            ut_trace.trace('Concatena Sector: ' ||
                           rgstrsector.description_sector,
                           3);
            If nulastsectorapr Is Null Then
              sberrormessage := sberrormessage ||
                                rgstrsector.description_sector;
            Else
              sberrormessage := sberrormessage || ', ' ||
                                rgstrsector.description_sector;
            End If;
            ut_trace.trace('Ultimo Sector: ' || rgstrsector.sector_id, 3);
            nulastsectorapr := rgstrsector.sector_id;

          End If; -- If Nulastsectorapr Is Null Or Nulastsectorapr <> Rgstrsector.Sector_Id Then
        End If; -- If Not Bosample Then

      End If;

      If Not boexists Then
        nutotal := nutotal + 1;
      End If;

    End Loop;
    xinsertfgrcr('termino de validar');
    -- En el error se indica que centrles y sectores no tienen muestra aprobada. smunozSAO213828
    If sbfaltaaprobacion = 'S' Then
      sberrormessage := 'No se encontro muestra aprobada para: ' ||
                        sberrormessage;
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           sberrormessage,
                           gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    End If; -- If sbFaltaAprobacion ='S' Then
    Close cusecprod_recup;
    If nutotal = numreg Then
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           'No se Encontraron Criterios para la Generacion' ||
                           ld_bcequivalreport.fnugetcreditbureaudesc(rgstrsector.credit_bureau_id),
                           gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
    End If;
    xinsertfgrcr('VA A abrir loop grande');
    Open cusecprod_recup(1);

    v_nro_rep := nvl(r_ld_trace.nro_rep, 1);
    xinsertfgrcr('VA A recorrer loop grande');
    Loop

      Fetch cusecprod_recup
        Into rgstrsector;
      Exit When cusecprod_recup%Notfound;

      -- Si el ultimo reporte se ejecuto sin problemas, se ejecuta el reporte desde decro
      If v_ultimo_rep_con_error = 'N' Then

        If nucode = rgstrsector.code Then
          nucode    := rgstrsector.code;
          sbtipogen := 'C';

          -- Identificar si se esta procesando otro sector. smunozSAO213862
          If nulastsector_id = rgstrsector.sector_id Then
            sbcambiosector := 'N';
            -- Identificar si se esta procesando otro producto. smunozSAO213862
            If nulastproduct_id = rgstrsector.product_id Then
              sbcambioproducto := 'N';
            Else
              sbcambioproducto := 'S';
            End If; -- If nuUltProductId = rgstrsector.product_id Then

          Else
            sbcambiosector   := 'S';
            sbcambioproducto := 'S';
          End If; -- If nuUltSectorId = rgstrsector.sector_id Then

        Else
          nucode      := rgstrsector.code;
          nusecuencia := seq_ld_generatesample.nextval;
          sbtipogen   := 'N';
          nutotalerr  := 0;
          nutotalrec  := 0;
          nutotalnov  := 0;

          -- Reiniciar los valores que identifican si se esta procesando otra central,
          -- otro sector o producto. smunozSAO213862
          nulastsector_id  := rgstrsector.sector_id;
          nulastproduct_id := rgstrsector.product_id;
          sbcambiosector   := 'N';
          sbcambioproducto := 'N';
        End If;
        -- Si el ultimo error se produjo al insertar en ld_sample
      Else
        nucode           := rgstrsector.code;
        nusecuencia      := r_ld_trace.secuen;
        sbtipogen        := r_ld_trace.gen_type;
        nutotalrec       := nvl(r_ld_trace.nutotalreg, 0);
        nutotalerr       := nvl(r_ld_trace.nutotalerr, 0);
        nutotalnov       := nvl(r_ld_trace.nutotalnov, 0);
        g_rec_procesados := nvl(r_ld_trace.rec_procesados, 0);
      End If; -- If v_ultimo_rep_con_error = 'N' Then
      xinsertfgrcr('va a validar nivel');
      If (upper(rgstrsector.nivel) = 'P') Then
        g_ultimopasoejecutado := 0;
        xinsertfgrcr('VOY 0.211A VA LLAMAR A ld_bcgenerationrandomsample.pbogenerationser CON TYPEPRODUCT='||TO_CHAR(rgstrsector.product_id));
        xinsertfgrcr('VOY 0.211A VA LLAMAR A ld_bcgenerationrandomsample.pbogenerationser CON g_rec_procesados='||TO_CHAR(g_rec_procesados));
        xinsertfgrcr('VOY 0.211A VA LLAMAR A ld_bcgenerationrandomsample.pbogenerationser CON p_program_id='||sbprograma || seq_estaprog);
        ld_bcgenerationrandomsample.pbogenerationser(p_inucreditbereauid    => rgstrsector.credit_bureau_id,
                                                     p_inutypesector        => rgstrsector.sector_id,
                                                     p_inutypeproductid     => rgstrsector.product_id,
                                                     p_isbsubscriber_number => Null,
                                                     p_innusampleid         => nusecuencia,
                                                     p_insbtypegen          => sbtipogen,
                                                     p_ionutotalrec         => nutotalrec,
                                                     p_ionutotalerr         => nutotalerr,
                                                     p_ionutotalnov         => nutotalnov,
                                                     p_idtfechgen           => dtfechcierr,
                                                     p_isbrepomuestra       => 'R',
                                                     p_onuerrorcode         => nuerror,
                                                     p_osberrormessage      => sberrormessage,
                                                     p_table_name_trace     => g_table_name_trace,
                                                     p_operation_trace      => g_operation_trace,
                                                     p_table_name_error     => r_ld_trace.table_name,
                                                     p_operation_error      => r_ld_trace.operation,
                                                     p_rec_procesados       => g_rec_procesados,
                                                     p_rec_a_procesar       => g_rec_a_procesar,
                                                     p_program_id           => sbprograma ||
                                                                               seq_estaprog,
                                                     p_nucambiosector       => sbcambiosector,
                                                     p_nucambioproducto     => sbcambioproducto);
        /* Confirmar registro */
        If (nuerror = 0) Then
          Commit;
        Else
          /*          Delete ld_trace_gen_report;
          Insert Into ld_trace_gen_report ltgr
            (table_name,
             sector,
             product,
             credit_bureau,
             code,
             nivel,
             secuen,
             gen_type,
             nutotalreg,
             nutotalerr,
             nutotalnov,
             nufechagen,
             operation,
             error,
             nro_rep,
             rec_procesados)
          Values
            (g_table_name_trace,
             rgstrsector.sector_id,
             rgstrsector.product_id,
             rgstrsector.credit_bureau_id,
             rgstrsector.code,
             upper(rgstrsector.nivel),
             nusecuencia,
             sbtipogen,
             nutotalrec,
             nutotalerr,
             nutotalnov,
             Sysdate,
             g_operation_trace,
             sberrormessage,
             v_nro_rep,
             g_rec_procesados);

          Commit;*/

          errors.seterror(cnunull_attribute, sberrormessage);
          Raise ex.controlled_error;
        End If;

      Elsif (upper(rgstrsector.nivel) = 'D') Then
        g_ultimopasoejecutado := 0;
        ld_bcgenerationrandomsample.pbogenerationdif(p_nucreditbereauid    => rgstrsector.credit_bureau_id,
                                                     p_inutypesector       => rgstrsector.sector_id,
                                                     p_inutypeproductid    => rgstrsector.product_id,
                                                     p_innusampleid        => nusecuencia,
                                                     p_sbsubscriber_number => Null,
                                                     p_insbtypegen         => sbtipogen,
                                                     p_ionutotalrec        => nutotalrec,
                                                     p_ionutotalerr        => nutotalerr,
                                                     p_ionutotalnov        => nutotalnov,
                                                     p_idtfechgen          => dtfechcierr,
                                                     p_onuerrorcode        => nuerror,
                                                     p_osberrormessage     => sberrormessage,
                                                     p_isbrepomuestra      => 'R',
                                                     p_table_name_trace    => g_table_name_trace,
                                                     p_operation_trace     => g_operation_trace,
                                                     p_table_name_error    => r_ld_trace.table_name,
                                                     p_operation_error     => r_ld_trace.operation,
                                                     p_rec_procesados      => g_rec_procesados,
                                                     p_rec_a_procesar      => g_rec_a_procesar,
                                                     p_program_id          => sbprograma ||
                                                                              seq_estaprog,
                                                     p_nucambiosector      => sbcambiosector,
                                                     p_nucambioproducto    => sbcambioproducto);
        /* Confirmar registro */
        If (nuerror = 0) Then
          Commit;
        Else
          /*  Delete ld_trace_gen_report;
          Insert Into ld_trace_gen_report ltgr
            (table_name,
             sector,
             product,
             credit_bureau,
             code,
             nivel,
             secuen,
             gen_type,
             nutotalreg,
             nutotalerr,
             nutotalnov,
             nufechagen,
             operation,
             error,
             nro_rep,
             rec_procesados)
          Values
            (g_table_name_trace,
             rgstrsector.sector_id,
             rgstrsector.product_id,
             rgstrsector.credit_bureau_id,
             rgstrsector.code,
             upper(rgstrsector.nivel),
             nusecuencia,
             sbtipogen,
             nutotalrec,
             nutotalerr,
             nutotalnov,
             Sysdate,
             g_operation_trace,
             sberrormessage,
             v_nro_rep,
             g_rec_procesados);

          Commit;*/
          errors.seterror(cnunull_attribute, sberrormessage);
          Raise ex.controlled_error;
        End If;
      End If;

      v_ultimo_rep_con_error := 'N';
      v_nro_rep              := v_nro_rep + 1;
      r_ld_trace.table_name  := Null;
      r_ld_trace.operation   := Null;

    End Loop;

    -- Eliminar la informacion trace de la ejecucion anterior
    Delete ld_trace_gen_report;
    Commit;

    Close cusecprod_recup;

    -- Actualiza el registro de seguimiento del proceso en ESTAPROG a Terminado OK
    pkstatusexeprogrammgr.upstatusexeprogramat(isbprog       => sbprograma ||
                                                                seq_estaprog,
                                               isbmens       => Null,
                                               inutotalreg   => g_rec_a_procesar,
                                               inucurrentreg => g_rec_procesados);
    pkstatusexeprogrammgr.processfinishok(sbprograma || seq_estaprog);
    -- Finaliza la transaccion del proceso
    pkgeneralservices.committransaction;

    pkerrors.pop;

    xinsertfgrcr('VA A mandar correo diciendo que termino');

    IF CORREO is not null THEN
        sbsubject := 'Notificacion: Procesos FGRCR ';
                LDC_ENVIAMAIL('<'||CORREO||'>',
                              sbsubject,
                              'Termina La ejecucion del Proceso: FGRCR'
                              );
    END IF;
    xinsertfgrcr('termino proceso');
  Exception
    When Others Then
      xinsertfgrcr('se partio el programa');
      IF CORREO is not null THEN
        sbsubject := 'Notificacion: Procesos FGRCR';
                LDC_ENVIAMAIL('<'||CORREO||'>',
                              sbsubject,
                              'Ejecucion del proceso termino con errores: FGRCR'
                              );
      END IF;
      -- Finaliza la transaccion del proceso
      --pkerrors.notifyerror(pkerrors.fsblastobject, nuerror, sberrormessage);
      pkerrors.notifyerror(pkerrors.fsblastobject,
                           nuerror,
                           sberrormessage);
      pkstatusexeprogrammgr.upstatusexeprogramat(isbprog       => sbprograma ||
                                                                  seq_estaprog,
                                                 isbmens       => 'Proceso terminado con error. ' ||
                                                                  sberrormessage,
                                                 inutotalreg   => g_rec_a_procesar,
                                                 inucurrentreg => g_rec_procesados);
      pkstatusexeprogrammgr.processfinishnok(sbprograma || seq_estaprog,
                                             sberrormessage);
      pkgeneralservices.committransaction;
      dbms_application_info.set_module(module_name => 'FGRCR',
                                       action_name => Null);
      errors.seterror;
      ge_boerrors.seterrorcodeargument(2741, sberrormessage);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, sberrormessage);
  End;

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizo la ultima entrega del paquete
    Return(csbversion);
    --}
  End fsbversion;
End ld_report_generation;
/