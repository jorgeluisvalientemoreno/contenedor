create or replace PACKAGE LDC_PKGESTIONLEGORDCRI IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PKGESTIONLEGORDCRI
    Descripcion    : Paquete donde se implementa la lógica para Ots critica
    Autor          : Luis Javier Lopez Barrios / Horbath
    Fecha          : 24/08/2022

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha               Autor               Modificacion
    =========           =========           ====================
    23/04/2024          jpinedc             OSF-2580- PRNOTIFICA : Se cambia ldc_sendemail por
                                            pkg_Correo
    17/07/2023          jcatuchemvm         OSF-1258: Ajuste por encapsulamiento de
                                            procedimientos open
                                              [PRPROCORDEN]                                     
                                            Se actualizan llamados a métodos errors por los
                                            correspondientes en pkg_error
    24/08/2022          Luis Javier Lopez     Creación
  ******************************************************************/
  PROCEDURE PRNOTIFICA( isbasunto IN VARCHAR2,
                        isbMensaje IN VARCHAR2,
                        isbCorreo IN VARCHAR2,
                        onuError OUT NUMBER,
                        osbError  OUT VARCHAR2);
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRNOTIFICA
  Descripcion: Proceso que notifica por correo

  Autor    : Luis javier lopez barrios
  Fecha    : 24-08-2022

  Datos Entrada
   isbasunto    asunto del correo
   isbMensaje   cuerpo del correo
   isbCorreo    correo a enviar notificacion
  Salida:
   onuError    codigo de error
   osbError    mensaje de error
  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/

  PROCEDURE PRVALIDAPERI;
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRVALIDAPERI
  Descripcion: Proceso que valida si existe periodo de consumo

  Autor    : Luis javier lopez barrios
  Fecha    : 24-08-2022

  Datos Entrada

  Salida:

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/
  PROCEDURE PRPROCORDEN( inuciclo IN NUMBER,
                         inucausal IN NUMBER,
                         isobservacion IN VARCHAR2,
                         onuerror OUT NUMBER,
                         osberror OUT VARCHAR2);
    /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRNOTIFICA
  Descripcion: Proceso que notifica por correo

  Autor    : Luis javier lopez barrios
  Fecha    : 24-08-2022

  Datos Entrada
   inuciclo      ciclo de consumo
   inucausal        causal de legalizacion
   isobservacion    observacion de legalizacion
  Salida:
   onuError    codigo de error
   osbError    mensaje de error
  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/

  PROCEDURE PRJOBLEGORDECRIT;
 /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRJOBLEGORDECRIT
  Descripcion: Proceso que legaliza ordenes de criticas

  Autor    : Luis javier lopez barrios
  Fecha    : 26-09-2022

  Datos Entrada

  Salida:

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/
END ;
/

create or replace PACKAGE BODY LDC_PKGESTIONLEGORDCRI IS
  PROCEDURE PRNOTIFICA( isbasunto IN VARCHAR2,
                        isbMensaje IN VARCHAR2,
                        isbCorreo IN VARCHAR2,
                        onuError OUT NUMBER,
                        osbError  OUT VARCHAR2) IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRNOTIFICA
  Descripcion: Proceso que notifica por correo

  Autor    : Luis javier lopez barrios
  Fecha    : 24-08-2022

  Datos Entrada
   isbasunto    asunto del correo
   isbMensaje   cuerpo del correo
   isbCorreo    correo a enviar notificacion
  Salida:
   onuError    codigo de error
   osbError    mensaje de error
  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/
    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
  BEGIN
  
    pkg_Correo.prcEnviaCorreo
    (
        isbRemitente        => sbRemitente,
        isbDestinatarios    => isbCorreo,
        isbAsunto           => isbasunto,
        isbMensaje          => isbMensaje
    );
                                    
  exception
     when others then
       Pkg_Error.setError;
       pkg_Error.getError(onuError, osbError);
  END PRNOTIFICA;
  PROCEDURE PRPROCORDEN( inuciclo IN NUMBER,
                         inucausal IN NUMBER,
                         isobservacion IN VARCHAR2,
                         onuerror OUT NUMBER,
                         osberror OUT VARCHAR2) IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRNOTIFICA
  Descripcion: Proceso que notifica por correo

  Autor    : Luis javier lopez barrios
  Fecha    : 24-08-2022

  Datos Entrada
   inuciclo      ciclo de consumo
   inucausal        causal de legalizacion
   isobservacion    observacion de legalizacion
  Salida:
   onuError    codigo de error
   osbError    mensaje de error
  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  17/07/2023   jcatuchemvm            OSF-1258: Actualización llamados OS_LEGALIZEORDERS por API_LEGALIZEORDERS,
                                      OS_ASSIGN_ORDER por api_assign_order
  ******************************************************************/
    nuPersonaLega        ge_person.person_id%TYPE := ge_bopersonal.fnugetpersonid;
    sbIdCriticas       VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_IDREGLAEXCL',NULL);
    sbNotifica   VARCHAR2(4000) :='<table border=0>';
    nuperiodoactu  number;


    CURSOR cuGetordenesLega IS
    SELECT O.ORDER_ID, OA.ORDER_ACTIVITY_ID actividad, C.IDORDEN ID_REG, IDPERIODOCONSUMO periodo, PECSCICO ciclo
    FROM or_order o, LDC_BI_PROC_CRITICA_CONSUMO C, OR_ORDER_ACTIVITY OA, pericose p
    WHERE IDPERIODOCONSUMO = p.PECSCONS
     AND p.PECSCICO = decode(inuciclo,-1,PECSCICO, inuciclo)
     AND o.order_id = IDORDEN
     AND NVL(FLAGPROCESADO,'N') = 'N'
     AND o.order_status_id = 0
     AND O.TASK_TYPE_ID = 12619
     AND IDREGLACRITICA NOT IN (select TO_NUMBER(trim(regexp_substr(sbIdCriticas,'[^,]+',1,level))) IDREGLA
                                from dual
                                connect by regexp_substr(sbIdCriticas, '[^,]+', 1, level) is not null)
     AND OA.ORDER_ID = O.ORDER_ID
    order by IDPERIODOCONSUMO;

    TYPE tblOrdenes IS TABLE OF cuGetordenesLega%ROWTYPE;
    v_tblOrdenes tblOrdenes;

    CURSOR cuTipoCausal  IS
    SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
    FROM ge_causal
    WHERE CAUSAL_ID = inucausal;

    nuclaseCausal NUMBER;
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);
    nuCantOrdLega NUMBER := 0;
    nuCantOrdFall NUMBER := 0;
    nuUnidadAsig  NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_UNIOPEFOVC', NULL);
    sbEmail      VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_EMAILNOLE');
    NUORDEN NUMBER;
    nucicloact number;

    PROCEDURE prActulizalog(isBprocesado IN VARCHAR2,
                            isbmensaje  IN VARCHAR2,
                            INUORDEN    in number) IS
     PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        UPDATE LDC_BI_PROC_CRITICA_CONSUMO SET FLAGPROCESADO = isBprocesado , MSGERROR = isbmensaje
        WHERE IDORDEN = INUORDEN;
       COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
         Pkg_Error.setError;
    END;

  BEGIN
     -- Consultamos datos para inicializar el proceso
     SELECT to_number(to_char(SYSDATE,'YYYY'))
             ,to_number(to_char(SYSDATE,'MM'))
             ,userenv('SESSIONID')
             ,USER INTO nuparano,nuparmes,nutsess,sbparuser
     FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'PRPROCORDEN','En ejecucion',nutsess,sbparuser);

    OPEN cuTipoCausal;
    FETCH cuTipoCausal INTO nuclaseCausal;
    CLOSE cuTipoCausal;
    BEGIN

        FOR reg IN cuGetordenesLega LOOP
            onuerror := 0;
            osberror := null;
            NUORDEN :=  reg.ORDER_ID;
            IF nuperiodoactu <> REG.periodo and nuperiodoactu is not null then
              sbNotifica := substr(sbNotifica ||'<tr>Periodo['||nuperiodoactu||'-'||nucicloact||'] exitosas ['||nuCantOrdLega||'] fallidas['||nuCantOrdFall||']'||'</tr></br>',1,3999);
              nuCantOrdLega := 0;
              nuCantOrdFall := 0;
            END IF;
            BEGIN
              SAVEPOINT actualizaorden;
            api_assign_order(  reg.ORDER_ID,
                                nuUnidadAsig,
                                onuError,
                                osberror);

            IF onuerror = 0 THEN
                api_legalizeOrders( reg.ORDER_ID||'|'||inucausal||'|'||nuPersonaLega||'||'||reg.actividad||'>'||nuClaseCausal||';;;;|||1277;'||isobservacion, SYSDATE, SYSDATE, null, onuerror, osberror );
                IF onuerror = 0 THEN
                    COMMIT;
                    prActulizalog('S', null, reg.ID_REG);
                    nuCantOrdLega := nuCantOrdLega +1;
                END IF;
            END IF;
            IF onuerror <> 0 THEN
                ROLLBACK TO SAVEPOINT actualizaorden;
                prActulizalog('N', osberror, reg.ID_REG);
                nuCantOrdFall := nuCantOrdFall + 1;
            END IF;
          EXCEPTION
            WHEN OTHERS THEN
               Pkg_Error.setError;
               pkg_Error.getError(onuerror, osberror);
               osberror := 'Orden '||reg.ORDER_ID||osberror;
               prActulizalog('N', osberror, reg.ID_REG);
          END;

           nuperiodoactu := reg.periodo;
           nucicloact := reg.ciclo;
      END LOOP;

       IF nuperiodoactu is not null then
        sbNotifica := substr(sbNotifica ||' <tr>Periodo['||nuperiodoactu||'-'||nucicloact||'] exitosas ['||nuCantOrdLega||'] fallidas['||nuCantOrdFall||']</tr></table>',1,3999);

      END IF;
    EXCEPTION
        WHEN OTHERS THEN
           Pkg_Error.setError;
           pkg_Error.getError(onuerror, osberror);
           osberror := 'Error fuera del bucle '||NUORDEN||' '||osberror;
           LDC_proactualizaestaprog(nutsess,osberror,'PRPROCORDEN','Ok');
           RETURN;
    END;

    IF sbemail IS NOT NULL and (nuCantOrdFall + nuCantOrdLega) > 0 THEN
       PRNOTIFICA('Legalizacion ordenes de critica','<h4>Ordenes de periodo de consumo</h4><br> '||sbNotifica, sbemail, onuerror, osberror);
    END IF;

    LDC_proactualizaestaprog(nutsess,osberror,'PRPROCORDEN','Ok');
  EXCEPTION
    WHEN OTHERS THEN
        Pkg_Error.setError;
        pkg_Error.getError(onuerror, osberror);
        LDC_proactualizaestaprog(nutsess,osberror,'PRPROCORDEN','ERROR');
  END PRPROCORDEN;

  PROCEDURE PRVALIDAPERI IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRVALIDAPERI
  Descripcion: Proceso que valida si existe periodo de consumo

  Autor    : Luis javier lopez barrios
  Fecha    : 24-08-2022

  Datos Entrada

  Salida:

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/
    sbPECSCONS ge_boInstanceControl.stysbValue;


    CURSOR cuGetValidaOrdenPend IS
    SELECT 'X'
    FROM LDC_BI_PROC_CRITICA_CONSUMO C, PERICOSE P
    WHERE IDPERIODOCONSUMO = P.PECSCONS
     and P.PECSCICO = to_number(sbPECSCONS)
     AND NVL(FLAGPROCESADO,'N') = 'N';

    sbExiste VARCHAR2(1);


  BEGIN
     sbPECSCONS := ge_boInstanceControl.fsbGetFieldValue ('PERICOSE', 'PECSCONS');

     OPEN cuGetValidaOrdenPend;
     FETCH cuGetValidaOrdenPend INTO sbExiste;
     CLOSE cuGetValidaOrdenPend;

     IF sbExiste IS NULL THEN
         Pkg_Error.setErrorMessage (isbMsgErrr => 'Periodo de Consumo no ordenes pendiente por legalizar');
         raise Pkg_Error.CONTROLLED_ERROR;
     END IF;

  EXCEPTION
    when Pkg_Error.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Pkg_Error.setError;
        raise Pkg_Error.CONTROLLED_ERROR;
   END;
 PROCEDURE PRJOBLEGORDECRIT IS
 /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: PRJOBLEGORDECRIT
  Descripcion: Proceso que legaliza ordenes de criticas

  Autor    : Luis javier lopez barrios
  Fecha    : 26-09-2022

  Datos Entrada

  Salida:

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------

  ******************************************************************/
      --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);

    nuerror NUMBER;
    SBERROR VARCHAR2(4000);
    nucausal  NUMBER := Dald_parameter.fnugetnumeric_value('LDC_CAUSLEGCRIT',null);
    sbobservacion VARCHAR2(4000) := 'Se legaliza por JOB PRJOBLEGORDECRIT';

    CURSOR cuGetordenesLega IS
    SELECT DISTINCT P.PECSCICO
    FROM  LDC_BI_PROC_CRITICA_CONSUMO C, PERICOSE P
    WHERE NVL(FLAGPROCESADO,'N') = 'N'
     AND P.PECSCONS = IDPERIODOCONSUMO;

  BEGIN
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;

    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'PRJOBLEGORDECRIT',
                           'En ejecucion',
                           nutsess,
                           sbparuser);

       nuerror:= 0;
       PRPROCORDEN(-1,
                   nucausal,
                   sbobservacion,
                   nuerror,
                   SBERROR);
        IF nuerror <> 0 THEN
           ROLLBACK;
        ELSE
          COMMIT;
        END IF;
    ldc_proactualizaestaprog(nutsess, SBERROR, 'PRJOBLEGORDECRIT', 'Ok');

  EXCEPTION
    WHEN Pkg_Error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuerror, SBERROR);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBLEGORDECRIT',
                               'error');

    WHEN OTHERS THEN
      Pkg_Error.setError;
      pkg_Error.getError(nuerror, SBERROR);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBLEGORDECRIT',
                               'error');
  END PRJOBLEGORDECRIT;
END ;
/

