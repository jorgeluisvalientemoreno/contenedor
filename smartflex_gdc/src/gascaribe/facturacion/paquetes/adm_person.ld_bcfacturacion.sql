CREATE OR REPLACE PACKAGE adm_person.Ld_BcFacturacion is
  /**********************************************************************************
  Propiedad intelectual de Gases del Caribe E.S.P (c).

  Unidad         : Ld_BcFacturacion
  Descripcion    : Realizar logica para personalizaciones Factuarcion GDC

  Autor          : Samuel Alberto Pacheco
  Fecha          : 11/06/2015

  Historia de Modificaciones
  Fecha             Autor                 Modificacion
  =========       ====================   ===========================================
  21/06/2024          PAcosta            OSF-2847: Cambio de esquema ADM_PERSON 
  **********************************************************************************/

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada

  -----------------------
  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------
  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------
  Function frfLectura return pkConstante.tyRefCursor;
  Function frfconsumo return pkConstante.tyRefCursor;
  --REQ.218
  Function Aprfconsumo return pkConstante.tyRefCursor;
  Function Aprflectura return pkConstante.tyRefCursor;
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : updateconsumo
   Descripcion    : Proceso que cambia datos de conssesu.

   Autor          : Samuel Pacheco
   Fecha          : 17/06/2015

   Parametros          Descripcion
   ============        ===================
   InCOSSPECS  Identificador de periodo de consumo
   InuCOSSPEFA           identificador de periodo de facturacion
   InuCOSSCOCA         consumo a actualizar
   InuCOSSELME         Elemento de medicion
   OnuErrorCode        Codigo de error
   OsbErrorMessage     Mensaje de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   29/11/2019. Horbath (EHGv1). Caso 218. Control de auditoria. OK++
   10/12/2019. Horbath (EHGv2). Caso 218.
   19/12/2019. Horbath (EHGv3). Caso 218. Control parametrizado (Activo / Inactivo)
   07/02/2020. Horbath (ESHv4). Caso 218. adicion de  los campos d comentario de registro y aprobacion
  ******************************************************************/
  Procedure updateconsumo(InCOnSSesu      IN varchar2,
                          InuActReg       number,
                          InuTotalReg     number,
                          OnuErrorCode    out number,
                          OsbErrorMessage out varchar2);

  Procedure updateLectura(InLEEMCONS      lectelme.LEEMCONS%type,
                          InuActReg       number,
                          InuTotalReg     number,
                          OnuErrorCode    out number,
                          OsbErrorMessage out varchar2);

  --REQ.218
  Procedure Aprupdateconsumo(Inrowid         varchar2,--InAPR_ID        LDC_APRFMACO.APR_ID%type,
                             InuActReg       number,
                             InuTotalReg     number,
                             OnuErrorCode    out number,
                             OsbErrorMessage out varchar2);

  Procedure Aprupdatelectura(Inrowid         varchar2,--InLEEMCONS      lectelme.LEEMCONS%type,
                             InuActReg       number,
                             InuTotalReg     number,
                             OnuErrorCode    out number,
                             OsbErrorMessage out varchar2);
  --FIN REQ. 218

END Ld_BcFacturacion;
/
CREATE OR REPLACE PACKAGE BODY adm_person.Ld_BcFacturacion is

--REQ.218+(CA)++
  /********************************************************************************
      Propiedad intelectual de Gases del Caribe E.S.P (c).

  Unidad         : Ld_BcFacturacion
  Descripcion    : Realizar logica para personalizaciones Factuarcion GDC

  Autor          : gdc
  Fecha          : 11/06/2015
                   29/11/2019. Horbath (EHGv1). Caso 218. Control de auditoria. OK++
                   10/12/2019. Horbath (EHGv2). Caso 218.
                   19/12/2019. Horbath (EHGv3). Caso 218. Control parametrizado (Activo / Inactivo). OK++
				   07/02/2020. Horbath (ESHv4). Caso 218. adicion de  los campos d comentario de registro y aprobacion
     ********************************************************************************/
  Function frfLectura return pkConstante.tyRefCursor is

    rfcursor  pkConstante.tyRefCursor;
    nunuse_Id ge_boInstanceControl.stysbValue;
    nupefa    ge_boInstanceControl.stysbValue;
    --
    sbparuser varchar2(100);
    nusesion  number;
    nuexiste  number :=0;

    --Variable del parametro
    nuPAR_APRFMLE number;

  begin

    ut_trace.trace('Inicio Ld_BcFacturacion.frfconsumo', 10);

  --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;
  --

  --REQ.218. Se busca el usuario en la tabla LDC_USSFMLE
  Begin
    select count(1) into nuexiste
    from LDC_USSFMLE l
    where l.ussusuario = sbparuser
    and   l.ussestado = 'A';
   Exception
     When no_data_found then
       null;
  End;
  --

  --REQ.218(CA). Se obtiene el parametro de APROBACION FMLE PAR_AUDI_FMLE. (activo =1 / inactivo = 0)
  Begin
    select p.numeric_value into nuPAR_APRFMLE
    from ld_parameter p
    where p.parameter_id = 'PAR_APR_FMLE';
  Exception
    when no_data_found then
      nuPAR_APRFMLE := 0;
  End;
  --

  /*Si el parametro esta activo = 1 y si el usuario en la tabla LDC_USSFMLE no existe,
  genera una alerta en pantalla*/
  If ((nuPAR_APRFMLE = 1) and (nuexiste =0))then

    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                        'Usted no esta autorizado para usar esta funcionalidad');
    raise ex.CONTROLLED_ERROR;
    Open rfcursor For 'select * from dual';

  Else

    /*obtener los valores ingresados en la aplicacion PB FMACO Mantenimiento de Consumo*/
    nunuse_Id := ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                       'LEEMSESU');

    nupefa    := ge_boInstanceControl.fsbGetFieldValue('CONSSESU',
                                                       'COSSPEFA');

    if (nunuse_Id is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'El Codigo de servicio suscrito no debe ser nulo');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (nupefa is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'El Codigo del Periodo no debe ser nulo');
      raise ex.CONTROLLED_ERROR;
    end if;

    -- identifica lectura segun criterio dado
    OPEN rfcursor FOR

      select leemcons Id_Lect,--PK LECTELME --(rowid Id_registro,)
             leemelme Id_ElmMedicion,
             leempefa Periodo_Fact,
             leempecs Periodo_Cons,
             leemlean Lect_Ant,
             leemfela Fec_Lect_Ant,
             leemleto Lect_Tomada,
             leemfele Fec_Lect_Tomada,
             leemclec Causal_Lect,
             leemoble Obs_Lect
        from lectelme
       where leemsesu = nunuse_Id
         and leempefa = nupefa
         AND LEEMCLEC <> 'T';

    ut_trace.trace('Fin Ld_BcFacturacion.frfLectura', 10);

   End if;

    return rfcursor;

  exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end frfLectura;

--REQ.218+(CA)
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : frfconsumo
   Descripcion    : Consulta Consumo asociado al servicio suscrito


   Autor          : gdc
   Fecha          : 11/06/2015

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   29/11/2019. Horbath (EHGv1). Caso 218. Control de auditoria. OK++
   10/12/2019. Horbath (EHGv2). Caso 218.
   19/12/2019. Horbath (EHGv3). Caso 218. Control parametrzado. OK++
  ******************************************************************/
  Function frfconsumo return pkConstante.tyRefCursor is

    rfcursor   pkConstante.tyRefCursor;
    nunuse_Id  ge_boInstanceControl.stysbValue;
    nupefa     ge_boInstanceControl.stysbValue;
    nupeco     ge_boInstanceControl.stysbValue;
    nuCOSSCOCA ge_boInstanceControl.stysbValue;
    nuelemmed  ge_boInstanceControl.stysbValue;
    numetcalcu ge_boInstanceControl.stysbValue;

    --
    sbparuser varchar2(100);
    nusesion  number;
    nuexiste  number :=0;
    --Variable del parametro
    nuPAR_APRFMACO number;

  begin

  ut_trace.trace('Inicio Ld_BcFacturacion.frfconsumo', 10);

  --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;

  --Se busca el usuario en la tabla LDC_USSFMACO
  Begin
    select count(1) into nuexiste
    from LDC_USSFMACO l
    where l.ussusuario = sbparuser
    and   l.ussestado = 'A';
   Exception
     When no_data_found then
       null;
  End;
  --

   --Se valida el pamatro de APROBACION FMACO PAR_AUDI_FMACO. (activo =1 / inactivo = 0)
  Begin
    select p.numeric_value into nuPAR_APRFMACO
    from ld_parameter p
    where p.parameter_id = 'PAR_APR_FMACO';
  Exception
    when no_data_found then
      nuPAR_APRFMACO := 0;
  End;
  --

  /*Si el parametro esta activo = 1 y si el usuario en la tabla LDC_USSFMACO no existe,
  genera una alerta en pantalla*/
  If ((nuPAR_APRFMACO = 1) and (nuexiste =0))then

    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'Usted no esta autorizado para usar esta funcionalidad');
    raise ex.CONTROLLED_ERROR;
    Open rfcursor For 'select * from dual';

  Else

    /*obtener los valores ingresados en la aplicacion PB FMACO Mantenimiento de Consumo*/
    nunuse_Id := ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                       'LEEMSESU');

    nupefa := ge_boInstanceControl.fsbGetFieldValue('LECTELME', 'LEEMPEFA');

    nupeco := ge_boInstanceControl.fsbGetFieldValue('LECTELME', 'LEEMPECS');

    nuCOSSCOCA := ge_boInstanceControl.fsbGetFieldValue('HICOPRPM',
                                                        'HCPPCOPR');

    nuelemmed  := ge_boInstanceControl.fsbGetFieldValue('CONSSESU',
                                                        'COSSIDRE');
    numetcalcu := ge_boInstanceControl.fsbGetFieldValue('CONSSESU',
                                                        'COSSMECC');

    if (nunuse_Id is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'El Codigo de servicio suscrito no debe ser nulo');
      raise ex.CONTROLLED_ERROR;
    end if;
    if (nupefa is null) then
      nupefa := -1;
    end if;

    -- Validamos elemento de medicion y el metodo de calculo
     IF nuelemmed IS NULL THEN
      nuelemmed := -1;
     END IF;
     IF numetcalcu IS NULL THEN
      numetcalcu := -1;
     END IF;

      IF nuCOSSCOCA IS NULL THEN
      nuCOSSCOCA := -1;
     END IF;

    -- Valida si el estado es igual a 4-PAGADO

    OPEN rfcursor FOR
      SELECT rowid Id_registro,
             COSSELME Id_Elemento_Medicion,
             cossflli Liquidado,
             COSSMECC MtdoCalcCosum,
             cossfere Fecha_Consumo,
             COSSCOCA Consumo,
             COSSPEFA Periodo_Facturacion,
             cosspecs Periodo_Consumo,
             cossfufa Funcion_Calc_AVC,
             COSSTCON Codigo_tipo_consumo,
             COSSNVEC nro_veces_estimado_consumo,
             COSSDICO Dias_consumo,
             COSSFERE Fecha_consumo,
             COSSCAVC Califi_anali_variacion_consumo,
             COSSCONS Consecutivo,
             COSSFCCO factores_correcion_usados
        FROM CONSSESU
       where cosssesu = nunuse_Id
         and cosspefa = decode(nupefa, -1, cosspefa, nupefa)
         and cosscoca = decode(nuCOSSCOCA, -1,cosscoca ,nuCOSSCOCA)
         and cosspecs = nupeco
         and cosselme = decode(nuelemmed,-1,cosselme,nuelemmed)
         and cossmecc = decode(numetcalcu,-1,cossmecc,numetcalcu);

    ut_trace.trace('Fin Ld_BcFacturacion.frfconsumo', 10);


 End if;

    return rfcursor;

  exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end frfconsumo;


------------------------------------------


--REQ.218.
/*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Aprfconsumo
   Descripcion    : Consulta solicitudes de cambio de Consumo de la tabla LDC_APRFMACO,
                    asociadas al servicio suscrito o por rango de fechas


   Autor          : Horbath
   Fecha          : 27/12/2019

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/11/2019       Horbath(EHG)           Creacion
   07/02/2020. Horbath (ESHv4). Caso 218. adicion del campo comentario de registro
  ******************************************************************/
  Function Aprfconsumo return pkConstante.tyRefCursor is

  rfcursor   pkConstante.tyRefCursor;
  nunuse_Id  ge_boInstanceControl.stysbValue;
  nupefa     ge_boInstanceControl.stysbValue;
  nupeco     ge_boInstanceControl.stysbValue;
  nuCOSSCOCA ge_boInstanceControl.stysbValue;
  nuelemmed  ge_boInstanceControl.stysbValue;
  numetcalcu ge_boInstanceControl.stysbValue;
  --
  sbparuser varchar2(100);
  nusesion  number;
  nuexiste  number :=0;
  --
  sbsesu   LDC_APRFMACO2.APR_COSSESU%type;
  sbfecini date;
  sbfefin  date;
  --
  sbmensaje        VARCHAR2(2000);
  eerror           EXCEPTION;

  sbsqlmaestro   ge_boutilities.stystatement; -- se almacena la consulta

  sbsqlfiltro   ge_boutilities.stystatement; -- se almacena la filtro

  begin

  --Se busca la informaci?n del PB APRFMACO
  sbsesu   := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMACO2', 'APR_COSSESU');
  sbfecini := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMACO2', 'APRFECHA_SOL');-- FECHA INICIAL
  sbfefin  := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMACO2', 'APRFECREG');-- FECHA FINAL

   --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;

  --Se busca el usuario que aprueba en la tabla LDC_USAFMACO
  Begin
    select count(1) into nuexiste
    from LDC_USAFMACO l
    where l.usausuario = sbparuser
    and   l.usaestado = 'A';
   Exception
     When no_data_found then
       null;
  End;
  --

  If (nuexiste !=0) then

     if sbfecini is null and sbfefin is not null then
              sbmensaje := 'la fecha inicial esta vacia.';
              RAISE eerror;
     end if;

     if sbfecini is not null and sbfefin is null then
              sbmensaje := 'la fecha final esta vacia.';
              RAISE eerror;
     end if;

     if TO_DATE(sbfecini, 'DD/MM/YYYY HH24:MI:SS')   > TO_DATE (sbfefin, 'DD/MM/YYYY HH24:MI:SS')  then
              sbmensaje := 'la fecha inicial es mayor que la final.';
              RAISE eerror;
     end if;

   --Se cargan los registros de LDC_APRFMACO2 (opcion #1)
   sbsqlmaestro :='select
                  rowid           Id_registro,
                  apr_id          Consecutivo_APRFMACO,
                  apr_cossesu     Servicio_suscrito,
                  aprcosspecs     Cod_Periodo_Consumo_nuevo,
                  aprcosspecsant  Cod_Periodo_Consumo_Anterior,
                  aprcosspefa     Cod_Periodo_Fact_nuevo,
                  aprcosspefant   Cod_Periodo_Fact_Ant,
                  aprcosselme     Id_elemento_medicion_nuevo,
                  aprcosselmeant  Id_elemento_medicion_Ant,
                  aprcoca_new     Consumo_nuevo,
                  aprcoca_ant     Consumo_anterior,
                  aprestado       Estado,
                  apr_cossrowid   Rowid_consesu,
                  aprususolic     Usuario_solicita,
                  aprusuaprov     Usuario_aprueba,
                  aprfecha_sol    Fecha_solicitud,
                  aprfecha_apr    Fecha_aprobacion,
                  aprfecreg       Fecha_registro,
                  nusesion        Sesion,
                  APRCOMENT_reg   coemntario_registro
                  from LDC_APRFMACO2 ';

   if sbsesu = '-1' or sbsesu is null then
      sbsqlfiltro := ' WHERE APRESTADO = ''P''
      AND trunc(APRFECHA_SOL) BETWEEN
      trunc(TO_DATE('''||sbfecini||''', ''DD/MM/YYYY HH24:MI:SS'')) AND
      trunc(TO_DATE('''||sbfefin||''', ''DD/MM/YYYY HH24:MI:SS''))';
   else
      sbsqlfiltro := ' WHERE APRESTADO = ''P''
      AND trunc(APRFECHA_SOL) BETWEEN
      trunc(TO_DATE('''||sbfecini||''', ''DD/MM/YYYY HH24:MI:SS'')) AND
      trunc(TO_DATE('''||sbfefin ||''', ''DD/MM/YYYY HH24:MI:SS'')) AND
      APR_COSSESU = '||sbsesu;
   end if;

   Else

   Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'Usted no esta autorizado para usar esta funcionalidad');
   raise ex.CONTROLLED_ERROR;

 End if;

  if sbsqlmaestro is null then
    Open rfcursor For 'select * from dual';
  end if;

  Open rfcursor For sbsqlmaestro || sbsqlfiltro;

  return rfcursor;

  End Aprfconsumo;


---------------------------------------------------------
--REQ.218.
/*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Aprfconsumo
   Descripcion    : Consulta solicitudes de cambio de Lecturas de la tabla LDC_APRFMLE,
                    asociadas al servicio suscrito o por rango de fechas


   Autor          : Horbath
   Fecha          : 27/12/2019

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/11/2019       Horbath(EHG)           Creacion
   07/02/2020. 		Horbath (ESHv4). Caso 218. adicion del campo comentario de registro
  ******************************************************************/
  Function Aprflectura return pkConstante.tyRefCursor is

  rfcursor  pkConstante.tyRefCursor;
  nunuse_Id ge_boInstanceControl.stysbValue;
  nupefa    ge_boInstanceControl.stysbValue;

  --
  sbparuser varchar2(100);
  nusesion  number;
  nuexiste  number :=0;
  --
  sbsesu   LDC_APRFMLE2.APRLEENSESU%type;
  sbfecini date;
  sbfefin  date;
  --
  sbmensaje        VARCHAR2(2000);
  eerror           EXCEPTION;

  sbsqlmaestro   ge_boutilities.stystatement; -- se almacena la consulta

  sbsqlfiltro   ge_boutilities.stystatement; -- se almacena la filtro

  begin

  --Se busca la informaci?n del PB APRFMLE
  sbsesu   := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMLE2', 'APRLEENSESU');
  sbfecini := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMLE2', 'APRFECHA_SOL');-- FECHA INICIAL
  sbfefin  := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMLE2', 'APRFECREG');-- FECHA FINAL

   --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;

  --Se busca el usuario que aprueba en la tabla LDC_USAFMLE
  Begin
    select count(1) into nuexiste
    from LDC_USAFMLE l
    where l.usausuario = sbparuser
    and   l.usaestado = 'A';
   Exception
     When no_data_found then
       null;
  End;
  --

  If (nuexiste !=0) then

   if sbfecini is null and sbfefin is not null then
            sbmensaje := 'la fecha inicial esta vacia.';
            RAISE eerror;
   end if;

   if sbfecini is not null and sbfefin is null then
            sbmensaje := 'la fecha final esta vacia.';
            RAISE eerror;
   end if;

   if TO_DATE(sbfecini, 'DD/MM/YYYY HH24:MI:SS')   > TO_DATE (sbfefin, 'DD/MM/YYYY HH24:MI:SS')  then
            sbmensaje := 'la fecha inicial es mayor que la final.';
            RAISE eerror;
   end if;

   --Opci?n #1
   --Se cargan los registros de LDC_APRFMLE2
   sbsqlmaestro :='select
                    rowid          Id_registro,
                    apr_id         Consecutivo_APRFMLE,
                    aprleensesu    Servicio_suscrito,
                    aprleemelme_ac Elemento_de_medicion_actual,
                    aprleemelme_an Elemento_de_medicion_anterior,
                    aprleempefa_ac Cod_Per_facturacion_actual,
                    aprleempefa_an Cod_per_facturacion_anterior,
                    aprleemlean_ac Lectura_anterior_actual,
                    aprleemlean_an Lectura_anterior_anterior,
                    aprleemfela_ac Fecha_lectura_anterior_actual,
                    aprleemfela_an Fecha_lect_anterior_anterior,
                    aprleemleto_ac Lectura_tomada_actual,
                    aprleemleto_an Lectura_tomada_anterior,
                    aprleemfele_ac Fecha_toma_lectura_actual,
                    aprleemfele_an Fecha_toma_lectura_anterior,
                    aprleempecs_ac Per_consumo_sector_actual,
                    aprleempecs_an Per_consumo_sector_anterior,
                    aprestado      Estado_registro,
                    aprfecha_sol   Fecha_solicitud,
                    aprfecha_apr   Fecha_Aprobacion,
                    aprfecreg      Fecha_registro,
                    aprfper_sol    Id_Persona_solicita,
                    aprfper_apr    Id_Persona_aprueba_rechaza,
                    aprfusu_sol    Usuario_solicita,
                    aprfusu_apr    Usuario_aprueba_rechaza,
                    aprfterm_sol   Terminal_solicita,
                    aprfterm_apr   Terminal_aprueba_rehaza,
                    aprip_sol      Direccion_ip_solicitante,
                    aprip_apr      Direccion_ip_aprobador,
                    aprhost_sol    Host_solicitante,
                    aprhost_apr    Host_aprobador,
                    nusesion_sol   Sesion_solicitante,
                    nusesion_apr   Sesion_aprobador,
                    APRCOMENT_REG  Comentario_registro
                    from LDC_APRFMlE2 ';

   if sbsesu = '-1' or sbsesu is null then
      sbsqlfiltro := ' WHERE APRESTADO = ''P''
      AND trunc(APRFECHA_SOL) BETWEEN
      trunc(TO_DATE('''||sbfecini||''', ''DD/MM/YYYY HH24:MI:SS'')) AND
      trunc(TO_DATE('''||sbfefin||''', ''DD/MM/YYYY HH24:MI:SS''))';
   else
      sbsqlfiltro := ' WHERE APRESTADO = ''P''
      AND trunc(APRFECHA_SOL) BETWEEN
      trunc(TO_DATE('''||sbfecini||''', ''DD/MM/YYYY HH24:MI:SS'')) AND
      trunc(TO_DATE('''||sbfefin ||''', ''DD/MM/YYYY HH24:MI:SS'')) AND
      APRLEENSESU = '||sbsesu;
   end if;

  Else

   Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'Usted no esta autorizado para usar esta funcionalidad');
   raise ex.CONTROLLED_ERROR;
   Open rfcursor For 'select * from dual';

 End if;

  if sbsqlmaestro is null then
    Open rfcursor For 'select * from dual';
  end if;

  Open rfcursor For sbsqlmaestro || sbsqlfiltro;

  return rfcursor;

  End Aprflectura;

----------------------METODOS DE PROCESAMIENTO
--REQ.218+(CA)
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : updateconsumo
   Descripcion    : Proceso que cambia datos del consumo.

   Autor          : gdc
   Fecha          : 10/06/2015

   Parametros          Descripcion
   ============        ===================
   InCOnSSesu          Identificador de medidor
   InuActReg           Registro actual
   InuTotalReg         Total de registros a procesar
   OnuErrorCode        Codigo de error
   OsbErrorMessage     Mensaje de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   10/06/2015       gdc                   Creacion
   29/11/2019. Horbath (EHGv1). Caso 218. Control de auditoria. OK++
   10/12/2019. Horbath (EHGv2). Caso 218.
   19/12/2019. Horbath (EHGv3). Caso 218. Control parametrzado. OK++
   07/02/2020. Horbath (ESHv4). Caso 218. adicion del campo comentario de registro
  ******************************************************************/
  Procedure updateconsumo(InCOnSSesu      varchar2,--ROWID
                          InuActReg       number,
                          InuTotalReg     number,
                          OnuErrorCode    out number,
                          OsbErrorMessage out varchar2) is

    /*Variables de instancia*/
    nunuse_Id   ge_boInstanceControl.stysbValue;
    nuCOSSPECS  ge_boInstanceControl.stysbValue;
    nuCOSSPEFA  ge_boInstanceControl.stysbValue;
    nupeco      ge_boInstanceControl.stysbValue;
    nuCOSSPEFA1 ge_boInstanceControl.stysbValue;
    nuCOSSCOCA1 ge_boInstanceControl.stysbValue;
    nuCOSSCOCA  ge_boInstanceControl.stysbValue;
    nuCOSSELME  ge_boInstanceControl.stysbValue;
    sbComentReg LDC_APRFMACO2.APRCOMENT_REG%type;

    nuCOSSPECS2 conssesu.COSSPECS%type;
    nuCOSSPEFA2 conssesu.COSSPEFA%type;
    nuCOSSCOCA2 conssesu.COSSCOCA%type;
    nuCOSSELME2 conssesu.COSSELME%type;

    vnuExpf   number;
    vnuExpc   number;
    VnuExLCPc number;

    --
    sbparuser varchar2(100);
    nusesion  number;
    nuexiste  number :=0;
    --Variable del parametro
    nuPAR_APRFMACO number;

  BEGIN

    ut_trace.trace('Inicio Ld_BcFacturacion.updateconsumo', 10);

  --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;
  --

  --Se obtiene el valor del parametro de APROBACION FMACO PAR_AUDI_FMACO. (activo =1 / inactivo = 0)
    Begin
      select p.numeric_value into nuPAR_APRFMACO
      from ld_parameter p
      where p.parameter_id = 'PAR_APR_FMACO';
    Exception
      when no_data_found then
        nuPAR_APRFMACO := 0;
    End;
  --


    nunuse_Id := ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                       'LEEMSESU');

    nuCOSSPEFA1 := ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                         'LEEMPEFA');

    nuCOSSCOCA1 :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('HICOPRPM',
                                                         'HCPPCOPR') /*)*/
      ;

    nuCOSSPECS :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('CONSSESU',
                                                        'COSSPECS') /*)*/
      ;

    nuCOSSPEFA :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('CONSSESU',
                                                        'COSSPEFA') /*)*/
      ;

    nuCOSSCOCA :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('CONSSESU',
                                                        'COSSCOCA') /*)*/
      ;

    nuCOSSELME :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('CONSSESU',
                                                        'COSSELME') /*)*/
      ;

    nupeco := ge_boInstanceControl.fsbGetFieldValue('LECTELME', 'LEEMPECS');

    sbComentReg := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMACO2','APRCOMENT_REG');

    if nuCOSSPEFA IS NOT NULL then
      --valida que el perido actualizada pertenezca al pruducto
      SELECT count(*)
        into vnuExpf
        FROM PERIFACT
       where pefacicl in (pktblservsusc.fnugetsesucicl(nunuse_Id))
         and pefacodi = nuCOSSPEFA;

      if vnuExpf = 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El Periodo de Factuacion no esta asociado al producto, Verifique.');
      end if;
    end if;

    -- si hay cambio de periodo consumo
    if nuCOSSPECS IS NOT NULL then
      --valida que el peridodo de consumo actualizado pertenezca al pruducto
      select count(*)
        into vnuExpc
        from pericose t
       where t.pecscico in (pktblservsusc.fnugetsesucicl(nunuse_Id))
         and t.pecscons = nuCOSSPECS;

      if vnuExpf = 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El Periodo de Consumo no esta asociado al producto, Verifique.');
      end if;
      --valida que el periodo de consumo actualizado tenga critica y lectura ademas que la fecha
      --final de periodo de consumo sea menos que el sysdate
      select COUNT(*)
        INTO VnuExLCPc
        from pericose t
       where t.pecscons = nuCOSSPECS
         and pecsproc = 'S'
         AND PECSFLAV = 'S'
         and pecsfecf < sysdate;

      if VnuExLCPc = 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El Periodo de Consumo no tiene Critica/Lectura o su fecha final es mayor o igual al dia de hoy, Verifique.');
      end if;
    end if;

    --Se obtiene el estado actual (antes de cambios) del registro procesado para los campos importantes
    Begin
      select COSSPECS,
             COSSPEFA,
             COSSCOCA,
             COSSELME
      into   nuCOSSPECS2,
             nuCOSSPEFA2,
             nuCOSSCOCA2,
             nuCOSSELME2
      from conssesu c
      where rowid = InCOnSSesu;
    Exception
      when others then
        null;
    End;

  --REQ.218(CA). Se valida si esta activo o inactivo, el parametro de aprobacion de cambios de consumo (PAR_AUDI_FMACO).
  If (nuPAR_APRFMACO = 1) then
   --REQ. 218. Se hace registra en la tabla de Aprobaciones de solicitudes FMACO (LDC_APRFMACO2).
   Begin
     insert into LDC_APRFMACO2
     (
      APR_ID        ,    --(Secuencia de la tabla)
      APR_COSSESU   ,    --(Codigo del servicio suscrito)
      APRCOSSPECS   ,    --(Codigo del periodo de consumo nuevo)
      APRCOSSPECSANT,    --(Codigo del periodo de consumo anterior)
      APRCOSSPEFA   ,    --(Codigo del periodo de facturacion nuevo)
      APRCOSSPEFANT ,    --(Codigo del periodo de facturacion anterior)
      APRCOSSELME   ,    --(ID del elemento de medicion nuevo)
      APRCOSSELMEANT,    --(ID del elemento de medicion anterior)
      APRCOCA_NEW   ,    --(Consumo nuevo)
      APRCOCA_ANT   ,    --(Consumo anterior)
      APRESTADO     ,    --(Estado(P/A/R)(Pendiente/Aprobado/Rechazado)
      APR_COSSROWID ,    --(ROWID del registro original de la tabla conssesu)
      APRUSUSOLIC   ,    --(Usuario que solicita)
      APRUSUAPROV   ,    --(Usuario que aprueba)
      APRFECHA_SOL  ,    --(Fecha de generacion de la sol. de cambio)
      APRFECHA_APR  ,    --(Fecha de aprobacion de la sol. de cambio)
      APRFECREG     ,    --Fecha de registro
      NUSESION,
      APRCOMENT_REG
     )
     values
     (
     SEQ_LDC_APRFMACO.NEXTVAL,
     nunuse_Id,--Sevicio suscrito (producto)
     nvl(nuCOSSPECS, nuCOSSPECS2),
     nuCOSSPECS2,--Codigo del periodo de consumo anterior
     nvl(nuCOSSPEFA, nuCOSSPEFA2),
     nuCOSSPEFA2,--Periodo de facturacion anterior
     nvl(nuCOSSELME, nuCOSSELME2),
     nuCOSSELME2,--Elemento de medicion anterior
     nvl(nuCOSSCOCA, nuCOSSCOCA2),
     nuCOSSCOCA2,---Consumo anterior
     'P',
     InCOnSSesu,--ROWID del registro original de la tabla conssesu
     sbparuser,--Usuario que solicita
     NULL,--Usuario que aprueba (todavia no se sabe)
     sysdate,--Fecha de solicitud de cambio de consumo
     NULL,--Fecha de aprobaci?n (todavia no se sabe)
     sysdate,--Fecha de registro
     nusesion,
     sbComentReg
     );

    Exception
       when others then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'Error al registrar Solicitud de aprobacion desde APRFMACO. - ' ||
                                             sqlerrm);
   End;

   Else --(nuPAR_APRFMACO = 0)

     --REQ.218.(CE). Se realiza el update directo.
     --Actualiza informacion de consumo
     update conssesu
     set COSSPECS = nvl(nuCOSSPECS, COSSPECS),
         COSSPEFA = nvl(nuCOSSPEFA, COSSPEFA),
         COSSCOCA = nvl(nuCOSSCOCA, COSSCOCA),
         COSSELME = nvl(nuCOSSELME, COSSELME)
     where rowid = InCOnSSesu;
     /*
     --nunuse_Id = cosssesu
     --and cosspefa = nuCOSSPEFA1
     --and cosscoca = nuCOSSCOCA1
     --AND cosselme = InCOnSSesu
     --AND COSSPECS = nupeco
    */
   End if;

    /*Hacer commit si todo OK*/
    commit;

    ut_trace.trace('Fin Ld_BcFacturacion.updateconsumo', 10);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END updateconsumo;



  ----------------------------

--REQ.218+(CA)
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : updateLectura
   Descripcion    : Proceso que cambia de datos de lectura

   Autor          : gdc
   Fecha          : 10/06/2014

   Parametros          Descripcion
   ============        ===================
   InLEEMCONS  Identificador de lectura
   InuActReg           Registro actual
   InuTotalReg         Total de registros a procesar
   OnuErrorCode        Codigo de error
   OsbErrorMessage     Mensaje de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   10/06/2015      gdc               Creacion
   29/11/2019.     Horbath (EHGv1). Caso 218. Control de auditoria. OK++
   10/12/2019.     Horbath (EHGv2). Caso 218.
   19/12/2019.     Horbath (EHGv3). Caso 218. Control parametrzado. OK++
   07/02/2020. 	   Horbath (ESHv4). Caso 218. adicion del campo comentario de registro
  ******************************************************************/
  Procedure updateLectura(InLEEMCONS      lectelme.LEEMCONS%type,--PK
                          InuActReg       number,
                          InuTotalReg     number,
                          OnuErrorCode    out number,
                          OsbErrorMessage out varchar2) is

    /*Variables de instancia*/
    nuLEEMPECS  ge_boInstanceControl.stysbValue;
    nuLEEMELME  ge_boInstanceControl.stysbValue;
    nuLEEMLEAN  ge_boInstanceControl.stysbValue;
    nuCOSSPEFA1 ge_boInstanceControl.stysbValue;
    dtLEEMFELA  date;
    nuLEEMLETO  ge_boInstanceControl.stysbValue;
    dtLEEMFELE  date;

    nuLEEMELME1 lectelme.LEEMELME%type;

    nuLEEMPEFA1 lectelme.LEEMPEFA%type;
    nuLEEMPECS1 lectelme.LEEMPECS%type;
    nuLEEMLEAN1 lectelme.LEEMLEAN%type;
    dtLEEMFELA1 lectelme.LEEMFELA%type;
    nuLEEMLETO1 lectelme.LEEMLETO%type;
    dtLEEMFELE1 lectelme.LEEMFELE%type;
    nunuse_Id   conssesu.cosssesu%type;
    NUleemclec  lectelme.leemclec%type;
    sbComentReg ldc_aprfmaco2.aprcoment_apr%type;--ge_boInstanceControl.stysbValue;--ldc_aprfmle2.aprcoment_apr%type;

    vnuExpf   number;
    vnuExpc   number;
    VnuExLCPc number;

    --
    sbparuser varchar2(100);
    nusesion  number;
    nuexiste  number :=0;
    --
    --Variable del parametro
    nuPAR_APRFMLE number;


  BEGIN

    ut_trace.trace('Inicio Ld_BcFacturacion.updateconsumo', 10);

  --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;
  --

  --Se obtiene el parametro de APROBACION FMLE PAR_AUDI_FMLE. (activo =1 / inactivo = 0)
  Begin
    select p.numeric_value into nuPAR_APRFMLE
    from ld_parameter p
    where p.parameter_id = 'PAR_APR_FMLE';
  Exception
    when no_data_found then
      nuPAR_APRFMLE := 0;
  End;
  --

    nuLEEMELME := ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                        'LEEMELME');

    nuCOSSPEFA1 := ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                         'LEEMPEFA');

    nuLEEMPECS :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                        'LEEMPECS') /*)*/
      ;

    nuLEEMLEAN :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                        'LEEMLEAN') /*)*/
      ;

    dtLEEMFELA := ut_convert.fnuChartoDate(ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                                                 'LEEMFELA'));

    nuLEEMLETO :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                        'LEEMLETO') /*)*/
      ;

    dtLEEMFELE := ut_convert.fnuChartoDate(ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                                                 'LEEMFELE'));

    nunuse_Id :=  /*ut_convert.fnuChartoNumber(*/
     ge_boInstanceControl.fsbGetFieldValue('LECTELME',
                                                       'LEEMSESU') /*)*/
      ;
   sbComentReg := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMLE2','APRCOMENT_REG');


    if nuCOSSPEFA1 IS NOT NULL then
      --valida que el perido actualizada pertenezca al pruducto
      SELECT count(*)
        into vnuExpf
        FROM PERIFACT
       where pefacicl in (pktblservsusc.fnugetsesucicl(nunuse_Id))
         and pefacodi = nuCOSSPEFA1;

      if vnuExpf = 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El Periodo de Factuacion no esta asociado al producto, Verifique.');
      end if;
    end if;

    if nuLEEMPECS is not null then
      --valida que el peridodo de consumo actualizado pertenezca al pruducto
      select count(*)
        into vnuExpc
        from pericose t
       where t.pecscico in (pktblservsusc.fnugetsesucicl(nunuse_Id))
         and t.pecscons = nuLEEMPECS;

      if vnuExpf = 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El Periodo de Consumo no esta asociado al producto, Verifique.');
      end if;
      --valida que el periodo de consumo actualizado tenga critica y lectura ademas que la fecha
      --final de periodo de consumo sea menos que el sysdate
      select COUNT(*)
        INTO VnuExLCPc
        from pericose t
       where t.pecscons = nuLEEMPECS
         and pecsproc = 'S'
         AND PECSFLAV = 'S'
         and pecsfecf < sysdate;

      if VnuExLCPc = 0 then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El Periodo de Consumo no tiene Critica/Lectura o su fecha final es mayor o igual al dia de hoy, Verifique.');
      end if;
    end if;

    --Se obtienen los valores actuales de la tabla LECTELME, antes del cambio
    BEGIN
      select LEEMELME,
             LEEMPEFA,
             LEEMPECS,
             LEEMLEAN,
             LEEMFELA,
             LEEMLETO,
             LEEMFELE,
             leemclec--CAUSAL
        into nuLEEMELME1,
             nuLEEMPEFA1,
             nuLEEMPECS1,
             nuLEEMLEAN1,
             dtLEEMFELA1,
             nuLEEMLETO1,
             dtLEEMFELE1,
             NUleemclec
        from lectelme--CAUSAL
       where inLEEMCONS = LEEMCONS;
    EXCEPTION
      WHEN OTHERS THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'Error al Consultar lectura. ' ||
                                         sqlerrm);
    END;

    -- si hay cambio de periodo consumo
    if dtleemfela IS NOT NULL then
      IF NUleemclec = 'F' THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'La fecha no se puede actualizar ya que esta asociada a Causal de Lectura F , Verifique.');
      END IF;

      if dtleemfela > SYSDATE then

        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'La fecha actualizada supera el dia actual, Verifique.');
      end if;
    END IF;

    --valida que la fecha actualizada no supera el dia actual
    IF dtleemfele IS NOT NULL THEN
      IF NUleemclec = 'F' THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'La fecha no se puede actualizar ya que esta asociada a Causal de Lectura F , Verifique.');
      END IF;
      if dtleemfele > SYSDATE then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'La fecha actualizada supera el dia actual, Verifique.');
      end if;
    END IF;

    --REQ.218(CA). Se valida si esta activo o inactivo, el parametro de aprobacion FMLE (PAR_AUDI_FMACO).
    If (nuPAR_APRFMLE = 1) then
      --REQ. 218. Se registra en la tabla de Aprobaciones de solicitudes FMLE (LDC_APRFMLE2).
      Begin
        insert into LDC_APRFMLE2 l(
                    apr_id         ,--Id de la Secuencia,
                    aprleensesu    ,--Numero de servicio suscrito,
                    aprleemelme_ac ,--Codigo del elemento de medicion actual,
                    aprleemelme_an ,--Codigo del elemento de medicion anterior,
                    aprleempefa_ac ,--Codigo del periodo de facturacion actual,
                    aprleempefa_an ,--Codigo del periodo de facturacion anterior,
                    aprleemlean_ac ,--Lectura anterior actual,
                    aprleemlean_an ,--Lectura anterior anterior,
                    aprleemfela_ac ,--Fecha lectura anterior actual,
                    aprleemfela_an ,--Lectura anterior anterior,
                    aprleemleto_ac ,--Lectura tomada actual,
                    aprleemleto_an ,--Lectura tomada anterior,
                    aprleemfele_ac ,--Fecha de toma de lectura actual,
                    aprleemfele_an ,--Fecha de toma de lectura anterior,
                    aprleempecs_ac ,--Periodo consumo por sector actual,
                    aprleempecs_an ,--Periodo consumo por sector anterior,
                    aprleemcons    ,--Consecutivo de LECTELME PK
                    aprestado      ,--Estado del registro,
                    aprfecha_sol   ,--Fecha de solicitud,
                    aprfecha_apr   ,--Fecha de Aprobaci?n,
                    aprfecreg      ,--Fecha de registro,
                    aprfper_sol    ,--Id Persona que solicita,
                    aprfper_apr    ,--Id Persona que aprueba o rechaza,
                    aprfusu_sol    ,--Usuario que solicita,
                    aprfusu_apr    ,--Usuario que aprueba o rechaza,
                    aprfterm_sol   ,--Terminal que solicita,
                    aprfterm_apr   ,--Terminal que aprueba,
                    aprip_sol      ,--Direccion ip solicitante,
                    aprip_apr      ,--Direccion ip aprobador,
                    aprhost_sol    ,--Host solicitante,
                    aprhost_apr    ,--Host aprobador,
                    nusesion_sol   ,--Sesion solicitante,
                    nusesion_apr   , --Sesion aprobador
                    APRCOMENT_REG
        )
        values(
           SEQ_LDC_APRFMLE.NEXTVAL,--Id de la Secuencia,
           nunuse_Id,--Numero de servicio suscrito,
           nvl(nuLEEMELME, nuleemelme1),--Codigo del elemento de medicion actual,
           nuleemelme1,--Codigo del elemento de medicion anterior,
           nvl(nuCOSSPEFA1, nuLEEMPEFA1),--Codigo del periodo de facturacion actual,
           nuLEEMPEFA1,--Codigo del periodo de facturacion anterior,
           nvl(nuLEEMLEAN, nuLEEMLEAN1),--Lectura anterior actual,
           nuLEEMLEAN1,--Lectura anterior anterior,
           nvl(dtLEEMFELA, dtLEEMFELA1), --Fecha lectura anterior actual,
           dtLEEMFELA1,--Fecha de toma de lectura anterior,
           nvl(nuLEEMLETO, nuLEEMLETO1),--Lectura tomada actual,
           nuLEEMLETO1,--Lectura tomada anterior,
           nvl(dtLEEMFELE, dtLEEMFELE1), --Fecha de toma de lectura actual,
           dtLEEMFELE1,--Fecha de toma de lectura anterior,
           nvl(nuLEEMPECS, nuLEEMPECS1),--Periodo consumo por sector actual,
           nuLEEMPECS1,--Periodo consumo por sector anterior,
           inLEEMCONS,--Consecutivo de LECTELME PK
           'P', --Estado por defecto = Pendiente
           sysdate,--Fecha Solicitud
           null,--Faecha de aprobaci?n (no aplica en este caso)
           sysdate,--Fecha de registro
           GE_BOPersonal.fnuGetPersonId,--Id Persona que solicita,
           NULL,--Id Persona que aprueba o rechaza,
           sbparuser,--Usuario solicitante (USER)
           null,--Usuario que aprueba (no aplica en este caso)
           userenv('TERMINAL'),--Terminal que solicita
           NULL,--Terminal que aprueba,
           sys_context('userenv', 'ip_address'),--Direccion ip solicitante,
           NULL,--Direccion ip aprobador,
           sys_context('userenv', 'host'),--Host solicitante,
           NULL,--Host aprobador
           nusesion,--Sesion solicitante,
           NULL,--Sesion aprobador
           sbComentReg

           );

      Exception
          when others then
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'Error al registrar Solicitud de aprobacion desde APRFMLE. - ' ||
                                             sqlerrm);
      End;

    Else--(nuPAR_APRFMLE = 0)
      --REQ. 218(CA). Se realiza el update e insert directo.
      --Actualiza informacion de lecturas
      update lectelme
         set LEEMELME = nvl(nuLEEMELME, LEEMELME),
             LEEMPEFA = nvl(nuCOSSPEFA1, LEEMPEFA),
             LEEMPECS = nvl(nuLEEMPECS, LEEMPECS),
             LEEMLEAN = nvl(nuLEEMLEAN, LEEMLEAN),
             LEEMFELA = nvl(dtLEEMFELA, LEEMFELA),
             LEEMLETO = nvl(nuLEEMLETO, LEEMLETO),
             LEEMFELE = nvl(dtLEEMFELE, LEEMFELE)
       where leemcons = InLEEMCONS
         and leemsesu = nunuse_Id;

      --registra auditoria de cambios de lectura
      BEGIN
        insert into aucalect
          (aulesesu,
           auleelme_ac,
           auleelme_an,
           aulepefa_ac,
           aulepefa_an,
           aulelean_ac,
           aulelean_an,
           aulefela_ac,
           aulefela_an,
           auleleto_ac,
           auleleto_an,
           aulefele_ac,
           aulefele_an,
           aulepecs_ac,
           aulepecs_an,
           aulefere,
           aulepers,
           auleusna,
           auleterm,
           aulediip,
           aulehost)
        values
          (nunuse_Id,
           nvl(nuLEEMELME, nuleemelme1),
           nuleemelme1,
           nvl(nuCOSSPEFA1, nuLEEMPEFA1),
           nuLEEMPEFA1,
           nvl(nuLEEMLEAN, nuLEEMLEAN1),
           nuLEEMLEAN1,
           nvl(dtLEEMFELA, dtLEEMFELA1), --
           dtLEEMFELA1,
           nvl(nuLEEMLETO, nuLEEMLETO1),
           nuLEEMLETO1,
           nvl(dtLEEMFELE, dtLEEMFELE1), --
           dtLEEMFELE1,
           nvl(nuLEEMPECS, nuLEEMPECS1),
           nuLEEMPECS1,
           SYSDATE,
           GE_BOPersonal.fnuGetPersonId,
           USER,
           userenv('TERMINAL'),
           sys_context('userenv', 'ip_address'),
           sys_context('userenv', 'host'));

      EXCEPTION
        WHEN OTHERS THEN
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'Error al registrar Auditoria desde FMLE. ' ||
                                           sqlerrm);
      END;
   End if;

    /*Hacer commit si todo OK*/
    commit;

    ut_trace.trace('Fin Ld_BcFacturacion.updateLectura', 10);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END updateLectura;


--REQ.218.
  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Aprupdateconsumo
   Descripcion    : Proceso que APRUEBA y CAMBIA /RECHAZA CAMBIO de los datos de lecturas,
                    de las solicitudes hechas desde FMACO.

   Autor          : gdc
   Fecha          : 26/11/2019

   Parametros          Descripcion
   ============        ===================
   InCOnSSesu          Identificador de medidor
   InuActReg           Registro actual
   InuTotalReg         Total de registros a procesar
   OnuErrorCode        Codigo de error
   OsbErrorMessage     Mensaje de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/11/2019       Horbath(EHG)           Creacion
   07/02/2020. 		Horbath (ESHv4). Caso 218. adicion del campo comentario de aprobacion
  ******************************************************************/--InCOnSSesu      IN varchar2,
  Procedure Aprupdateconsumo(Inrowid         varchar2,--ROWID (LDC_APRFMACO2) --InAPR_ID        LDC_APRFMACO2.APR_ID%type,)
                             InuActReg       number,
                             InuTotalReg     number,
                             OnuErrorCode    out number,
                             OsbErrorMessage out varchar2) is
  --
  sbparuser varchar2(100);
  nusesion  number;
  nuexiste  number :=0;
  sbAprestado LDC_APRFMACO2.APRESTADO%type;
  sbComentApr LDC_APRFMACO2.aprcoment_apr%type;
  --
  sbapr_cossrowid varchar2(100);
  nuCOSSPECS conssesu.COSSPECS%type;
  nuCOSSPEFA conssesu.COSSPEFA%type;
  nuCOSSCOCA conssesu.COSSCOCA%type;
  nuCOSSELME conssesu.COSSELME%type;
  --

  begin

   --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;


  --Se obtiene el valor del estado final de la solicitud de cambio de Consumo
  sbAprestado := ge_boInstanceControl.fsbGetFieldValue('LDC_APRFMACO2',
                                                         'APRESTADO');

  sbComentApr := ge_boInstanceControl.fsbGetFieldValue('LDC_APRFMACO2',
                                                         'APRCOMENT_APR');

  If sbAprestado is null then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'No ha seleccionado un estado valido para el proceso.');
    raise ex.CONTROLLED_ERROR;
  else
    if (sbAprestado) = 1 then
      sbAprestado := 'A';
    else
      sbAprestado := 'R';
    end if;
  end if;

    /*Se recupera la informacion de la tabla LDC_APRFMACO2, para procesarla y actualizar la tabla
      conssesu.*/
    begin
      select apr_cossrowid,
             aprcosspecs,
             aprcosspefa,
             aprcoca_new ,
             aprcosselme
      into   sbapr_cossrowid,
             nuCOSSPECS,
             nuCOSSPEFA,
             nuCOSSCOCA,
             nuCOSSELME
      from LDC_APRFMACO2 l
      where rowid = Inrowid;

    exception
      when others then
        null;
    end;

  IF (sbAprestado = 'A') Then
  /*Actualiza informacion de consumo en conssesu, haciendo uso finalmente de la funcionalidad
  original de FMACO. Adicionalmente como existe un trigger before insert or update para esta
  tabla, la auditoria se realiza desde el trigger insertando automaticamente en la tabla Aucamcons.*/
    --REQ.218
    begin
     update conssesu
     set COSSPECS = nvl(nuCOSSPECS, COSSPECS),
         COSSPEFA = nvl(nuCOSSPEFA, COSSPEFA),
         COSSCOCA = nvl(nuCOSSCOCA, COSSCOCA),
         COSSELME = nvl(nuCOSSELME, COSSELME)
     where rowid = sbapr_cossrowid;--InCOnSSesu
    exception
      when others then
        null;
    end;
     --
  END IF;

  --Actualiza el registro de solicitud LDC_APRFMACO2 a estado = (A/R)
    begin
      Update LDC_APRFMACO2 l
      set l.aprestado    = sbAprestado,
          l.aprusuaprov  = sbparuser,
          l.aprfecha_apr = sysdate,
          l.nusesion     = nusesion,
          l.APRCOMENT_APR = sbComentApr
       where rowid = Inrowid;
    exception
      when others then
        null;
    end;

  /*Hacer commit si todo OK*/
    commit;


    ut_trace.trace('Fin Ld_BcFacturacion.Aprupdateconsumo', 10);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  end Aprupdateconsumo;

--REQ.218.
   /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : Aprupdateconsumo
   Descripcion    : Proceso que APRUEBA y CAMBIA /RECHAZA CAMBIO de los datos de lecturas,
                    de las solicitudes hechas desde FMLE.

   Autor          : gdc
   Fecha          : 26/11/2019

   Parametros          Descripcion
   ============        ===================
   InLEEMCONS          Identificador de lectura
   InuActReg           Registro actual
   InuTotalReg         Total de registros a procesar
   OnuErrorCode        Codigo de error
   OsbErrorMessage     Mensaje de error

   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
   26/11/2019       Horbath(EHG)           Creacion
   07/02/2020. 		Horbath (ESHv4). Caso 218. adicion del campo comentario de aprobacion
   ******************************************************************/

  Procedure Aprupdatelectura(Inrowid         varchar2,--ROWID (LDC_APRFMLE)
                             InuActReg       number,
                             InuTotalReg     number,
                             OnuErrorCode    out number,
                             OsbErrorMessage out varchar2) is

  --
  sbparuser varchar2(100);
  nusesion  number;
  nuexiste  number :=0;
  sbAPRESTADO LDC_APRFMLE2.APRESTADO%type; --ge_boInstanceControl.stysbValue;
  --Variables para el update a lectelme
  nuLEEMELME lectelme.leemelme%type;
  nuLEEMPEFA lectelme.leempefa%type;
  nuLEEMPECS lectelme.leempecs%type;
  nuLEEMLEAN lectelme.leemlean%type;
  dtLEEMFELA lectelme.leemfela%type;
  nuLEEMLETO lectelme.leemleto%type;
  dtLEEMFELE lectelme.leemfele%type;
  ----
  --Variables para el insert en aucalect y update a lectelme
  nuapr_id      ldc_aprfmle2.apr_id%type;
  nuleensesu    ldc_aprfmle2.aprleensesu%type;
  nuleemelme_ac ldc_aprfmle2.aprleemelme_ac%type;
  nuleemelme_an ldc_aprfmle2.aprleemelme_an%type;
  nuleempefa_ac ldc_aprfmle2.aprleempefa_ac%type;
  nuleempefa_an ldc_aprfmle2.aprleempefa_an%type;
  nuleemlean_ac ldc_aprfmle2.aprleemlean_ac%type;
  nuleemlean_an ldc_aprfmle2.aprleemlean_an%type;
  dtleemfela_ac ldc_aprfmle2.aprleemfela_ac%type;
  dtleemfela_an ldc_aprfmle2.aprleemfela_an%type;
  nuleemleto_ac ldc_aprfmle2.aprleemleto_ac%type;
  nuleemleto_an ldc_aprfmle2.aprleemleto_an%type;
  dtleemfele_ac ldc_aprfmle2.aprleemfele_ac%type;
  dtleemfele_an ldc_aprfmle2.aprleemfele_an%type;
  nuleempecs_ac ldc_aprfmle2.aprleempecs_ac%type;
  nuleempecs_an ldc_aprfmle2.aprleempecs_an%type;
  nuLEEMCONS    ldc_aprfmle2.aprleemcons%type;
  sbestado      ldc_aprfmle2.aprestado%type;
  dtfecha_sol   ldc_aprfmle2.aprfecha_sol%type;
  dtfecha_apr   ldc_aprfmle2.aprfecha_apr%type;
  dtfecreg      ldc_aprfmle2.aprfecreg%type;
  sbper_sol     ldc_aprfmle2.aprfper_sol%type;
  sbper_apr     ldc_aprfmle2.aprfper_apr%type;
  apusu_sol     ldc_aprfmle2.aprfusu_sol%type;
  apusu_apr     ldc_aprfmle2.aprfusu_apr%type;
  apterm_sol    ldc_aprfmle2.aprfterm_sol%type;
  apterm_apr    ldc_aprfmle2.aprfterm_apr%type;
  apip_sol      ldc_aprfmle2.aprip_sol%type;
  apip_apr      ldc_aprfmle2.aprip_apr%type;
  aphost_sol    ldc_aprfmle2.aprhost_sol%type;
  aphost_apr    ldc_aprfmle2.aprhost_apr%type;
  nusesion_sol  ldc_aprfmle2.nusesion_sol%type;
  nusesion_apr  ldc_aprfmle2.nusesion_apr%type;
  sbComentApr ldc_aprfmle2.aprcoment_apr%type;

  --Variables de filtro en las sentencias (update e insert)
  --nuLEEMCONS lectelme.leemcons%type;
  nunuse_Id  lectelme.leemsesu%type;

  --Variables para controlar la auditoria en aucalect
  nuLEEMELMEa lectelme.leemelme%type;
  nuLEEMTCONa lectelme.leemtcon%type;
  nuLEEMPEFAa lectelme.leempefa%type;
  nuLEEMOBLEa lectelme.leemoble%type;
  nuLEEMLEANa lectelme.leemlean%type;
  dtLEEMFELAa lectelme.leemfela%type;
  nuLEEMLETOa lectelme.leemleto%type;
  dtLEEMFELEa lectelme.leemfele%type;
  nuLEEMFAMEa lectelme.leemfame%type;
  nuLEEMDOCUa lectelme.leemdocu%type;
  nuLEEMSESUa lectelme.leemsesu%type;
  nuLEEMCMSSa lectelme.leemcmss%type;
  nuLEEMFLCOa lectelme.leemflco%type;
  nuLEEMPECSa lectelme.leempecs%type;
  nuLEEMPETLa lectelme.leempetl%type;
  nuLEEMCLECa lectelme.leemclec%type;
  sbLEEMOBSBa lectelme.leemobsb%type;
  sbLEEMOBSCa lectelme.leemobsc%type;

  begin

   --Validaci?n del usuario conectado
  SELECT userenv('SESSIONID'), USER INTO nusesion, sbparuser
  FROM dual;

  --Se obtiene el valor del estado final de la solicitud de cambio de Consumo
  sbAprestado := ge_boInstanceControl.fsbGetFieldValue('LDC_APRFMLE2',
                                                         'APRESTADO');
  sbComentApr := ge_boinstancecontrol.fsbgetfieldvalue('LDC_APRFMLE2','APRCOMENT_APR');

  If sbAprestado is null then
    Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                    'No ha seleccionado un estado valido para el proceso.');
    raise ex.CONTROLLED_ERROR;
  else
    if (sbAprestado) = 1 then
      sbAprestado := 'A';
    else
      sbAprestado := 'R';
    end if;
  end if;

  --Recupera la informaci?n del cambio a procesar de la tabla LDC_APRFMLE2
 begin
   select apr_id         ,--Id_Reg,
          aprleensesu    ,--Servicio_suscrito,
          aprleemelme_ac ,--Elemento_de_medicion_actual,
          aprleemelme_an ,--Elemento_de_medicion_anterior,
          aprleempefa_ac ,--Cod_Per_facturacion_actual,
          aprleempefa_an ,--Cod_per_facturacion_anterior,
          aprleemlean_ac ,--Lectura_anterior_actual,
          aprleemlean_an ,--Lectura_anterior_anterior,
          aprleemfela_ac ,--Fecha_lectura_anterior_actual,
          aprleemfela_an ,--Lectura_anterior_anterior,
          aprleemleto_ac ,--Lectura_tomada_actual,
          aprleemleto_an ,--Lectura_tomada_anterior,
          aprleemfele_ac ,--Fecha_toma_lectura_actual,
          aprleemfele_an ,--Fecha_toma_lectura_anterior,
          aprleempecs_ac ,--Per_consumo_sector_actual,
          aprleempecs_an,-- Per_consumo_sector_anterior,
          aprleemcons,--     PK_registro_lectelme,--NEW
          aprestado,--      Estado_registro,
          aprfecha_sol,--   Fecha_solicitud,
          aprfecha_apr,-- Fecha Aprobacion_rechazo
          aprfecreg,--      Fecha_registro,
          aprfper_sol,--    Id_Persona_solicita,
          aprfper_apr,--    Id_Persona_aprueba_rechaza,
          aprfusu_sol,--    Usuario_solicita,
          aprfusu_apr,--    Usuario_aprueba_rechaza,
          aprfterm_sol,--   Terminal_solicita,
          aprfterm_apr,--   Terminal_aprueba_rehaza,
          aprip_sol,--      Direccion_ip_solicitante,
          aprip_apr,--      Direccion_ip_aprobador,
          aprhost_sol,--    Host_solicitante,
          aprhost_apr,
          nusesion_sol,
          nusesion_apr

     into
          nuapr_id,
          nunuse_Id,
          nuleemelme_ac ,
          nuleemelme_an ,
          nuleempefa_ac ,
          nuleempefa_an ,
          nuleemlean_ac ,
          nuleemlean_an ,
          dtleemfela_ac ,
          dtleemfela_an ,
          nuleemleto_ac ,
          nuleemleto_an ,
          dtleemfele_ac ,
          dtleemfele_an ,
          nuleempecs_ac ,
          nuleempecs_an ,
          nuLEEMCONS    ,
          sbestado      ,
          dtfecha_sol   ,
          dtfecha_apr   ,
          dtfecreg      ,
          sbper_sol    ,
          sbper_apr    ,
          apusu_sol    ,
          apusu_apr    ,
          apterm_sol   ,
          apterm_apr   ,
          apip_sol      ,
          apip_apr      ,
          aphost_sol    ,
          aphost_apr    ,
          nusesion_sol   ,
          nusesion_apr

    from LDC_APRFMLE2 l
    where rowid = Inrowid;

  exception
    WHEN OTHERS THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'Error al Consultar solicitudes FMLE (LDC_APRFMLE2). ' ||
                                         sqlerrm);
  end;

  --Se actualiza el estado del registro en la tabla LDC_APRFMLE2 al estado indicado por
    --el usuario Aprobador desde el PB APRFMLE Y los campos del aprobador
      update LDC_APRFMLE2 l
      set l.aprestado    = sbAPRESTADO,
          l.aprfecha_apr = sysdate,
          l.aprfper_apr  = GE_BOPersonal.fnuGetPersonId,
          l.aprfusu_apr  = USER,
          l.aprfterm_apr = userenv('TERMINAL'),
          l.aprip_apr    = sys_context('userenv', 'ip_address'),
          l.aprhost_apr  = sys_context('userenv', 'host'),
          l.nusesion_apr = nusesion,
          l.aprcoment_apr = sbComentApr
      where rowid     = Inrowid;
    --

  IF (sbAprestado = 'A') THEN
     --Se actualiza la informaci?n del cambio de lectura en la tabla lectelme (update original)
       update lectelme
         set LEEMELME = nvl(nuLEEMELME_ac, LEEMELME),
             LEEMPEFA = nvl(nuLEEMPEFA_ac, LEEMPEFA),
             LEEMPECS = nvl(nuLEEMPECS_ac, LEEMPECS),
             LEEMLEAN = nvl(nuLEEMLEAN_ac, LEEMLEAN),
             LEEMFELA = nvl(dtLEEMFELA_ac, LEEMFELA),
             LEEMLETO = nvl(nuLEEMLETO_ac, LEEMLETO),
             LEEMFELE = nvl(dtLEEMFELE_ac, LEEMFELE)
       where leemcons = nuLEEMCONS
         and leemsesu = nunuse_Id;
    --

    --Se registra la auditoria de cambios de lectura en la tabla aucalect
    BEGIN
      insert into aucalect
        (aulesesu,   --1 Numero de servicio suscrito
         auleelme_ac,--2 Codigo del elemento de medicion actual
         auleelme_an,--3 Codigo del elemento de medicion anterior
         aulepefa_ac,--4 Codigo del periodo de facturacion actual
         aulepefa_an,--5 Codigo del periodo de facturacion anterior
         aulelean_ac,--6 Lectura nueva
         aulelean_an,--7 Lectura anterior
         aulefela_ac,--8 Fecha lectura nueva
         aulefela_an,--9 Fecha lectura anterior
         auleleto_ac,--10 Lectura tomada nueva
         auleleto_an,--11 Lectura tomada anterior
         aulefele_ac,--12 Fecha de toma de lectura nueva
         aulefele_an,--13 Fecha de toma de lectura anterior
         aulepecs_ac,--14 Periodo de consumo de lectura por sector actual
         aulepecs_an,--15 Periodo de consumo de lectura por sector anterior
         aulefere,--16 Fecha de registro
         aulepers,--17 Id Persona que realiza operacion
         auleusna,--18 Usuario
         auleterm,--19 Terminal
         aulediip,--20 Direccion ip
         aulehost)--21 Host
      values
        (nunuse_Id,--1
         nvl(nuLEEMELME_ac, nuLEEMELME_an),--2
         nuLEEMELME_an,--3
         nvl(nuLEEMPEFA_ac, nuLEEMPEFA_an),--4
         nuLEEMPEFA_an,--5
         nvl(nuLEEMLEAN_ac, nuLEEMLEAN_an),--6--
         nuLEEMLEAN_an,--7--
         nvl(dtLEEMFELA_ac, dtLEEMFELA_an),--8--
         dtLEEMFELA_an,--9--
         nvl(nuLEEMLETO_ac, nuLEEMLETO_an),--10--
         nuLEEMLETO_an,--11--
         nvl(dtLEEMFELE_ac, dtLEEMFELE_an),--12--
         dtLEEMFELE_an,--13--
         nvl(nuLEEMPECS_ac, nuLEEMPECS_an),--14--
         nuLEEMPECS_an,--15--
         SYSDATE,--16--
         sbper_sol,--GE_BOPersonal.fnuGetPersonId,--17--
         apusu_sol,--USER,--18--
         apterm_sol,--userenv('TERMINAL'),--19--
         apip_sol,--sys_context('userenv', 'ip_address'),--20--
         aphost_sol--sys_context('userenv', 'host')--21--
         );
      EXCEPTION
       when others then
         ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'Error al Registrar la auditoria FMLE (Aucalect). ' ||
                                         sqlerrm);
      END;
  END IF;

 /*Hacer commit si todo OK*/
    commit;

    ut_trace.trace('Fin Ld_BcFacturacion.Aprupdatelectura', 10);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

 end Aprupdatelectura;

END Ld_BcFacturacion;
/
PROMPT Otorgando permisos de ejecucion a LD_BCFACTURACION
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCFACTURACION', 'ADM_PERSON');
END;
/
