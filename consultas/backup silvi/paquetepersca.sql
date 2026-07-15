CREATE OR REPLACE PACKAGE      LDC_PKGENEORDEAUTORECO  IS
 FUNCTION fnugetValidaAuto (inuProducto IN servsusc.sesunuse%type) RETURN NUMBER;
 PROCEDURE progeneraPersca( isbProgram  in VARCHAR2,
                            inuProceso IN   NUMBER,
                            sbCICLO IN VARCHAR2,
                            sbDepartamento IN VARCHAR2,
                            sbLocalidad IN VARCHAR2,
                            inuHilo         IN   NUMBER,
                            inuTotalHilos   IN   NUMBER /*,
                            onuOk      OUT  NUMBER,
                            osbMensaje OUT  VARCHAR2*/);
   /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar persecuon

        Parametros Entrada
         inuProceso    codigo del proceso
         sbDepartamento   departamento
         sbLocalidad     localidad
        Valor de salida
        onuOk        0- Exito, -1 Error
        osbMensaje     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR                       DESCRIPCION
        21/08/2019  Mateo Velez / OLSOFTWARE     modificacion del cursor cuValidaOrde para la
                                                 mejora de tiempos de respuesta y validacion 
                                                 de actividades, porque anteriormente validaba
                                                 por tipos de trabajos.
        05/07/2020  OLsoftware.CA47              Se ajusta para serparar la lógica cuando se haga
                                                 llamado si es un proceso automatico o no.
                                                 Se crea «GeneraPerscaAuto» y «GeneraPerscaNoAuto»
        22/11/2020  OLsoftware.CA452             Se realiza validacion en el proceso GeneraPerscaAuto
                                                 para determinar si se genera la orden de persecucion
        
   ***************************************************************************/

    PROCEDURE VerificaFinProceso
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        inuCantHilos    IN   NUMBER,
        onuCantRegist   OUT  NUMBER,
        onuCantPerse    OUT  NUMBER
    );

  PROCEDURE PROGENEACTAUTORECO(inuConsecutivo IN  LDC_SUSP_AUTORECO.SARECODI%TYPE);
   /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar flujo de autoreconectado

        Parametros Entrada
         inuConsecutivo consecutivo de perseuacion
        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

   PROCEDURE LDC_PROGENTRAMVSI;
     /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar venta de servicio de ingenieria

        Parametros Entrada
        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA         AUTOR       			DESCRIPCION
		31/05/2019    Miguel Ballesteros    CA 200-2680 Se cambia la forma de como obtener el punto de atencion actual
                                            por medio de un procedimiento que retorna dicho valor y comentando el cursor
                                            que realizaba esta función.
   ***************************************************************************/
   PROCEDURE LDC_VALILECTAUTO;
     /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de validar lecturas

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
   PROCEDURE LDC_PROVALIESTAPRSU;
  /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de validar si un producto esta suspendido por RP

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

      PROCEDURE LDC_PROCREASOLIRECOSINCERT;
  /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar tramite de reinstalacion y reco rp

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

END LDC_PKGENEORDEAUTORECO;
/
CREATE OR REPLACE PACKAGE BODY      LDC_PKGENEORDEAUTORECO  IS

 FUNCTION fnuGetActividadgenerarAuto( inuProceso IN LDC_PROCESO.PROCESO_ID%TYPE ,
                                      inuActividad IN LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE,
                                      sbMarca  in number)  RETURN NUMBER IS

  --consulta Actividad a Generar
  CURSOR cuConsultaActividadGene IS
  SELECT PROXIMA_ACTIVITY_ID
  FROM LDC_ACTIVIDAD_GENERADA LAG
  WHERE LAG.PROCESO_ID = inuProceso
  AND LAG.ACTIVITY_ID_GENERADA = inuActividad
  AND INSTR(','||SUSPENSION_TYPE_ID||',',','||sbMarca||',') > 0 ;

   nuProxActivi  LDC_ACTIVIDAD_GENERADA.PROXIMA_ACTIVITY_ID%type;
 BEGIN

  OPEN cuConsultaActividadGene;
  FETCH cuConsultaActividadGene INTO nuProxActivi;
  CLOSE cuConsultaActividadGene;

  RETURN nuProxActivi;
 EXCEPTION
   WHEN OTHERS THEN
      RETURN -1;

 END ;

 FUNCTION fnugetValidaAuto (inuProducto IN servsusc.sesunuse%type) RETURN NUMBER IS

   ------------- MODIFICACION CASO 47 -------------------
   /*  --se consulta los titr a validar para la generacion de orden
   CURSOR cuTipoTrabVali IS
   SELECT ACTIVIDAD_VALIDAR
   FROM LDC_PROCESO
   WHERE PROCESO_ID = dald_parameter.fnuGetNumeric_Value('LDC_PROCAUTORECO',null);

   sbActividadValidar LDC_PROCESO.ACTIVIDAD_VALIDAR%TYPE;

   CURSOR cuValidaOrde IS
   SELECT 'X'
   FROM or_order o, or_order_activity oa
   WHERE o.order_id = oa.order_id
    AND oa.product_id = inuProducto
    AND o.task_type_id in (select to_number(column_value)
                            from table(open.ldc_boutilities.splitstrings(sbActividadValidar, ',')))
    AND o.order_status_id NOT IN (  SELECT ORDER_STATUS_ID
                                    FROM or_order_status
                                    WHERE is_final_status = 'Y');*/
---DSALTARIN 558 20/10/2020         GLPI 558: Se arrega error de la consulta cuValidaOrde del cambio 47
 
 -- cursor que me permite consultar las actividades a validar para la generacion de orden
 CURSOR cuValidaOrde IS                                 
  SELECT 'X'
   FROM or_order o, or_order_activity oa
   WHERE o.order_id = oa.order_id
    AND oa.product_id = inuProducto
    AND oa.ACTIVITY_ID in ( select distinct
                             REGEXP_SUBSTR( A.ACTIVIDAD_VALIDAR, '[^,]+', 1, level )
                             from   LDC_PROCESO A
                             where A.PROCESO_ID = open.dald_parameter.fnugetnumeric_value('LDC_PROCAUTORECO',NULL)
                             --558
                             --connect by regexp_substr(SUSPENSION_TYPES, '[^,]+', 1, level) is not null)
                             connect by regexp_substr( A.ACTIVIDAD_VALIDAR, '[^,]+', 1, level) is not null)
                             --558
    AND o.order_status_id NOT IN (  SELECT ORDER_STATUS_ID
                                    FROM or_order_status
                                    WHERE is_final_status = 'Y');
                                    
    ------------------ FIN MODIFICACION CASO 47 -------------------
   sbDatos  VARCHAR2(1);

 BEGIN
  ------------- MODIFICACION CASO 47 -------------------
  /* OPEN  cuTipoTrabVali;
   FETCH cuTipoTrabVali INTO sbActividadValidar;
   IF cuTipoTrabVali%NOTFOUND THEN
      CLOSE cuTipoTrabVali;
      RETURN 0;
   END IF;
   CLOSE cuTipoTrabVali;*/
   

   --IF sbActividadValidar IS NOT NULL THEN 
   -- se recorre el cursor cuValidaOrde para validar que trae informacion, en tal caso 
   -- que no, se retorna 0 de la funcion
      OPEN cuValidaOrde;
      FETCH cuValidaOrde INTO sbdatos;
      IF cuValidaOrde%NOTFOUND THEN
         CLOSE cuValidaOrde;
         RETURN 0;
      END IF;
      CLOSE cuValidaOrde;

  -- ELSE
  --   return 0;  
  -- END IF;
  ------------ FIN MODIFICACION CASO 47 ---------------

   RETURN 1;
 EXCEPTION
   WHEN OTHERS THEN
     RETURN 0;
 END fnugetValidaAuto;

    /**************************************************************************
        Nombre      : fsbPermiteRegistroAutoRec
        Autor       : OLsoftware
        Fecha       : 10-11-2020
        Ticket      : CA452
        Descripcion : Servicio que permite validar si se realiza el registro
                      en LDC_SUSP_AUTORECO

        Parametros Entrada
         inuProducto         Codigo del producto

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        10/11/2020  OLsoftware   CA452. Creacion
    ***************************************************************************/

    FUNCTION fsbPermiteRegistroAutoRec
    (
        inuProducto         IN      pr_product.product_id%type
    )
    RETURN VARCHAR2
    IS
    
        csbComa             CONSTANT VARCHAR2(1) := ',';
        csbCaso452          CONSTANT VARCHAR2(20) := '0000452';
        cnuEdadSup          CONSTANT NUMBER := daLDC_PARAREPE.fnuGetPAREVANU('PERSEC_EDAD_SUP',NULL);
        cnuEdadInf          CONSTANT NUMBER := daLDC_PARAREPE.fnuGetPAREVANU('PERSEC_EDAD_INFER',NULL);
        csbTipoSusp         CONSTANT LDC_PARAREPE.paravast%TYPE := daLDC_PARAREPE.fsbGetPARAVAST('TIPOSUSP_GENERA_PERSEC_REPA',NULL);

        sbValida            VARCHAR2(1);
        nuEdadProducto      NUMBER;
        
        nuTipoSuspension    PR_PROD_SUSPENSION.suspension_type_id%type;
        nuCount             NUMBER;
        
        CURSOR cuTipoSuspension IS
            SELECT SUSPENSION_TYPE_ID
            FROM (
                SELECT *
                FROM PR_PROD_SUSPENSION
                WHERE PRODUCT_ID = inuProducto
                AND ACTIVE = 'Y'
                ORDER BY register_date desc
                )
            WHERE rownum = 1;

        CURSOR cuValidaExisteSusp IS
            SELECT count(1)
            FROM dual
            WHERE nuTipoSuspension IN (SELECT TO_NUMBER(COLUMN_VALUE)
                                       FROM TABLE (LDC_BOUTILITIES.splitStrings(csbTipoSusp,csbComa)));
    
    BEGIN
    
        ut_trace.trace('Inicio del servicio fsbPermiteRegistroAutoRec',10);
        
        IF NOT fblaplicaentregaxcaso(csbCaso452) THEN
        
            RETURN 'Y';
        
        END IF;
        
        IF fblaplicaentregaxcaso(csbCaso452) THEN

            nuEdadProducto := ldc_getedadrp(inuProducto);
            
            IF nuEdadProducto > cnuEdadSup THEN

                RETURN 'Y';
            
            END IF;
            
            IF nuEdadProducto >= cnuEdadInf AND nuEdadProducto <= cnuEdadSup THEN
            
                OPEN cuTipoSuspension;
                FETCH cuTipoSuspension INTO nuTipoSuspension;
                CLOSE cuTipoSuspension;
                
                OPEN cuValidaExisteSusp;
                FETCH cuValidaExisteSusp INTO nuCount;
                CLOSE cuValidaExisteSusp;
                
                IF nuCount > 0 THEN
                
                    RETURN 'Y';
                
                END IF;
            
            END IF;
            
            RETURN 'N';

        END IF;
        
        ut_trace.trace('Fin del servicio fsbPermiteRegistroAutoRec',10);
    
    
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            UT_Trace.Trace('CONTROLLED_ERROR LDC_PKGENEORDEAUTORECO.fsbPermiteRegistroAutoRec', 10);
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_Trace.Trace('OTHERS LDC_PKGENEORDEAUTORECO.fsbPermiteRegistroAutoRec', 10);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fsbPermiteRegistroAutoRec;

    /**************************************************************************
        Nombre      : GeneraPerscaAuto
        Autor       : OLsoftware
        Fecha       : 05-07-2020
        Ticket      : CA47
        Descripcion : Procesa los registros cuando es automatico

        Parametros Entrada
         inuProceso         Codigo del proceso
         inCiclo            Codigo del ciclo
         inDepartamento     Codigo dl departamento
         inLocalidad        Codigo de la localidad
         inuHilo            Hilo actual
         inuTotalHilos      Total hilos
         inuServ            Tipo de producto
         isbEstaCorte       Estados de corte
         isbProgram         Programa

        Valor de salida
         onuOk              0- Exito, -1 Error
         osbMensaje         Mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        05/07/2020  OLsoftware   CA47. Creacion
        22/11/2020  OLSoftware   CA452. Validacion de edad producto para creación de ordenes
                                 de persecución
								
	      09/12/2020          ljlb                CA 337 se coloca validacion de producto excluido		
        12/05/2021  OLSoftware    CA519: Se modificará los cursores cuConsuLectfact y cuLecturas 
                                  para que no validen que la observación de lectura sea nula o -1
    ***************************************************************************/
    PROCEDURE GeneraPerscaAuto
    (
        inuProceso      IN   NUMBER,
        inCiclo         IN   NUMBER,
        inDepartamento  IN   NUMBER,
        inLocalidad     IN   NUMBER,
        inuHilo         IN   NUMBER,
        inuTotalHilos   IN   NUMBER,
        inuServ         IN   NUMBER,
        isbProgram      IN   VARCHAR2,
        isbEstadoCorte  IN   VARCHAR2,
        isbEstadoProd   IN   VARCHAR2,
        isbTipoSuspen   IN   VARCHAR2,
        onuOk           OUT  NUMBER,
        osbMensaje      OUT  VARCHAR2
    )
    IS

        --200-2614
    	nuToleranciaDif	number:=NVL(DALD_PARAMETER.FNUGETNUMERIC_VALUE('TOLERANCIA_DIFE_AUTORECONE',3),0);
    	sbRegistra	    varchar2(1);
    	nuexiste number := 0;
    	--200-2614

        --Inicio CASO 200-216
        NUPCAR_TOPE_FACT_SUSP open.ld_parameter.numeric_value%type := open.dald_parameter.fnuGetNumeric_Value('PCAR_TOPE_FACT_SUSP',null);
        SBCOD_ACTI_SUSP_CART_PERSCA OPEN.LD_PARAMETER.VALUE_CHAIN%type := OPEN.DALD_PARAMETER.fsbGetValue_Chain('COD_ACTI_SUSP_CART_PERSCA',NULL);
        --sb200216 varchar2(4000);
        --Fin CASO 200-216
        nuDepaProd NUMBER;
        nuLocaProd NUMBER;

        nuTitrSusp NUMBER;
        nuOrdenSusp  NUMBER;
        nuLectSusp  NUMBER;

        --inuProceso               NUMBER;
        SBESTADOCORTE              VARCHAR2(4000);
        SBESTADOPRODUCTO           VARCHAR2(4000);
        SBTIPOSUSPENSION           VARCHAR2(4000);
        SBDESARROLLO               VARCHAR2(4000) := 'BSS_JLVM_RNP_1005';
        BLGDO                      BOOLEAN := open.LDC_CONFIGURACIONRQ.aplicaParaGDO(SBDESARROLLO);

        nuUltimaLectura number;
        CantiReg     number := 0;
        NUCantiReg     number := 0;

        nuConta      number := 0;
        sumaConsumo  number := 0;
        nuPromedio   number := 0;
        nuDeudaCorr  NUMBER(15, 2) := 0;
        nuDeudaDife  NUMBER(15, 2) := 0;
        nuSaldoTot   NUMBER(15, 2) := 0;
        Limite       number(9);
        sbmarca      varchar(1);
        --NUORDER_ID        or_order.order_id%type;
        NUACTIVITY     open.ge_items.items_id%type;
        NUACTIV_GENERA open.ge_items.items_id%type;
        DFFECHALEGA    date;

        nuTotal    NUMBER := 0;
       -- sbProgram  VARCHAR2(2000) := 'PERSCA';
        --parametros
        sbAplica2002611 varchar2(1):='N';

        nuNumPeriodo          number := open.Dald_parameter.fnuGetNumeric_Value('NUM_PERI_EVA_PERS',null);
        nuActivi_suspe_pers   open.ge_items.items_id%type := open.Dald_parameter.fnuGetNumeric_Value('ID_ITEM_SUSP_PERS',null);
        nuActivi_corte_pers   open.ge_items.items_id%type := open.Dald_parameter.fnuGetNumeric_Value('ID_ITEM_CORTE_PERS',null);
        nuSaldo_param         NUMBER(15, 2);
        add_cons_tope         number(9) := open.Dald_parameter.fnuGetNumeric_Value('PCAR_VALOR_ADIC_CONS_PROM',null);
        sw                    number;
        periodos_consecutivos VARCHAR2(1) := open.DALD_PARAMETER.fsbGetValue_Chain('FLAG_PERIODO_CONSE_PERS',null);
        ONUPREVPECSCONS       conssesu.cosspecs%type;
        -- contrato a procesar
        nuNumesusc open.servsusc.sesususc%type;
        -- Producto a procesar
        nuNumeServ open.servsusc.sesunuse%type;
        -- Estado de Corte del Producto
        nuServEsco open.servsusc.sesuesco%type;
        -- Ciclo del producto
        nuciclo open.servsusc.sesucicl%type;
        -- order_activity_id de la orden de suspension
        nuORD_ACT_ID open.pr_product.SUSPEN_ORD_ACT_ID%type;

        nuLEEMLETO open.lectelme.LEEMLETO%type;
        nuLEEMPEFA open.lectelme.LEEMPEFA%type;
        dfLEEMFELE open.lectelme.LEEMFELE%type;
        nuLEEMSESU open.lectelme.LEEMSESU%type;
        nuLEEMDOCU open.lectelme.LEEMDOCU%type;
        nuLEEMPECS open.lectelme.LEEMPECS%type;
        
        csbEntrega2002611 varchar2(4000):='200-2614';

        type styServsusc IS record(
            sesususc          open.servsusc.sesususc%type,
            sesunuse          open.servsusc.sesunuse%type,
            sesuesco          open.servsusc.sesuesco%type,
            sesucicl          open.servsusc.sesucicl%type,
            SUSPEN_ORD_ACT_ID open.pr_product.SUSPEN_ORD_ACT_ID%type,
            sesudepa          number(6),
            sesuloca          number(6),
            PERSHILO          open.LDC_PRODGENEPER.pershilo%TYPE
        );

        type tbtyServsuscTable IS table of styServsusc index BY binary_integer;

        tbServsusc tbtyServsuscTable;

        type stylectelme IS record(
            LEEMLETO open.lectelme.LEEMLETO%type,
            LEEMPEFA open.lectelme.LEEMPEFA%type,
            LEEMFELE open.lectelme.LEEMFELE%type,
            LEEMSESU open.lectelme.LEEMSESU%type,
            LEEMDOCU open.lectelme.LEEMDOCU%type,
            LEEMPECS open.lectelme.LEEMPECS%type
        );

        type tbtylectelmeTable IS table of stylectelme index BY binary_integer;

        tblectelme tbtylectelmeTable;

        cursor cuproductossuspendidosauto(nuCiclo          open.servsusc.sesucicl%type,
                                      NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE,
                                      ESTADOCORTE      VARCHAR2,
                                      ESTADOPRODCUTO   VARCHAR2,
                                      TIPOSSUSPENSION  VARCHAR2,
                                      inudepa  NUMBER,
                                      inuloca NUMBER,
                                      inuProductId IN   servsusc.sesunuse%type)
        IS
            SELECT *
            FROM (
                SELECT sesususc,
                   sesunuse,
                   sesuesco,
                   sesucicl,
                   suspen_ord_act_id,
                   open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(s.sesunuse) DEPA,
                   open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTLOCALITY(s.sesunuse ) LOCA,
                   inuHilo pershilo
                FROM open.servsusc              s,
                     open.pr_product            p,
                     open.pr_prod_suspension    ps,
                     open.ldc_proceso_actividad lpa
                WHERE s.sesuesco IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(estadocorte,
                                                                   '-1',
                                                                       to_char(s.sesuesco),
                                                                      estadocorte),
                                                                ',')))
                 AND p.product_status_id IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(estadoprodcuto,
                                                                       '-1',
                                                                       to_char(p.product_status_id),
                                                                       estadoprodcuto),
                                                                ',')))
                 AND ps.suspension_type_id IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(tipossuspension,
                                                                       '-1',
                                                                       to_char(ps.suspension_type_id),
                                                                       tipossuspension),
                                                                ',')))
                 AND s.sesucicl = decode(nuciclo, -1, s.sesucicl, nuciclo)
                 AND sesuserv = inuServ
                   and ps.ACTIVE ='Y'
                 AND p.product_id = s.sesunuse
                 AND p.product_id = ps.product_id
                 AND p.suspen_ord_act_id IS NOT NULL
                 AND fnugetValidaAuto(s.sesunuse) = 0
                 AND 0 = (SELECT count(1)
                            FROM open.LDC_SUSP_AUTORECO, open.or_order
                           WHERE SARESESU = sesunuse
                             AND SAREORDE = order_id
                             AND order_status_id IN (0, 5, 6, 7))--200-2614
                 AND 0 = (SELECT count(1)
                            FROM open.LDC_SUSP_AUTORECO
                           WHERE SARESESU = s.sesunuse
                             AND SAREORDE IS NULL)
                 AND lpa.proceso_id = nuldc_proceso_id
                 AND lpa.activity_id =
                     OPEN.daor_order_activity.fnugetactivity_id(suspen_ord_act_id,
                                                                NULL)
                 AND NOT EXISTS(  SELECT 'X'
                                  FROM open.or_order_activity, open.or_order, open.ldc_actividad_generada
                                  WHERE or_order_activity.product_id = p.product_id
                                     AND or_order_activity.order_id = or_order.order_id
                                     AND order_status_id IN (0, 5, 6, 7) --200-2614
                                     AND or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                     AND ldc_actividad_generada.activity_id_generada = lpa.activity_id -- Inicia NC 3468.
                                    )
                --AND sesunuse > 0
                AND sesunuse = inuProductId
             --   AND sesunuse = 162
                --AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos
				--INICIO CA 337
				AND LDC_PKGESTPREXCLURP.FUNVALEXCLURP(sesunuse) = 0
				--FIN CA 337
              ) WHERE DEPA = DECODE(inuDepa, -1, depa, inudepa)
                AND loca = DECODE(inuLoca, -1, loca, inuLoca)
                ;

        TYPE tbUsuarioAuto IS TABLE OF cuproductossuspendidosauto%ROWTYPE  ;
        v_tbUsuarioAuto tbUsuarioAuto;

        CURSOR cuConsUsuaProc
        IS
            SELECT *
            FROM open.LDC_PRODGENEPER
            WHERE pershilo = inuHilo;

        CURSOR cuMaximaLectura(nuNuse           open.lectelme.leemsesu%type,
                               NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE)
        IS
            /*ajuste  # 1 seg?n necesidad del tiquete 3567 09/05/2014
          se suprimi la condici?n AND LEEMOBLE = 65 y se  cambia por
          open.ldc_boutilities.fsbbuscatoken(open.dald_parameter.fsbgetvalue_chain('TIPO_TRAB_REPESCA'),to_char(B.task_type_id),',') = 'S'
          se crea parametro TIPO_TRAB_REPESCA en LDPAR donde el funcional parametrizar? los Tipos de Trabajos para el proceso de repesca  */
            SELECT leemfele, nvl(leemleto, 0), b.order_id, b.task_type_id
            FROM open.lectelme a
            inner join open.or_order_activity b
            on a.LEEMDOCU = b.ORDER_ACTIVITY_ID
            WHERE LEEMSESU = nuNuse
            AND LEEMCLEC = 'T'
            AND open.DAOR_ORDER.FNUGETTASK_TYPE_ID(open.DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(B.ORDER_ACTIVITY_ID,
                                                                                NULL),
                                             NULL) =
               (SELECT LPA.TASK_TYPE_ID
                  FROM open.LDC_PROCESO_ACTIVIDAD LPA
                 WHERE LPA.PROCESO_ID = NULDC_PROCESO_ID
                   AND LPA.ACTIVITY_ID = B.ACTIVITY_ID)
           ORDER BY leemfele desc;

        --se consulta informacion del producto
        CURSOR cuDatosProd
        IS
            SELECT open.daab_segments.fnugetoperating_sector_id(open.daab_address.fnugetsegment_id(address_id, NULL), NULL) seop,
               suscclie cliente,
               subscription_id contrato,
               product_status_id estado_prod,
               address_id direccion,
               category_id categoria,
               (SELECT multivivienda
               FROM open.ldc_info_predio
               WHERE premise_id =  daab_address.fnugetestate_number(address_id, NULL)
                 AND ROWNUM < 2) multfami,
              ( SELECT MAX(plazo_maximo)
                FROM open.ldc_plazos_cert
                WHERE id_producto = product_id) plazo_max
            FROM open.pr_product, open.suscripc
            WHERE subscription_id = susccodi
            AND product_id = nuNumeServ;
            
        rgDatosProd cuDatosProd%rowtype;

        -- se consulta lectura actual y lectura anterior de facturacion
        CURSOR cuConsuLectfact(dtFechaLect date)
        IS --200-2611
          SELECT leemleto lectactu, leemlean lectant, leemfele fecha
          FROM open.lectelme
          WHERE leemsesu = nuNumeServ
            AND leemtcon = 1
            AND leemclec = 'F'
        	and lectelme.leemfele>=dtFechaLect --200-2611
            AND lectelme.leemfele IN
               (SELECT MAX(lectelme.leemfele)
                  FROM open.lectelme
                 WHERE leemsesu = nuNumeServ
                   AND leemclec = 'F')
            --AND (lectelme.leemoble =-1 OR leemoble IS NULL)
            AND leemleto > 0;

        rgLecturaProd cuConsuLectfact%rowtype;

        --Se consulta marca de suspension
        CURSOR cuMarcaProd
        IS
            SELECT suspension_type_id
            FROM open.pr_prod_suspension
            WHERE active = 'Y'
              AND product_id = nuNumeServ;

        nuMarcaProd NUMBER;

        CURSOR cuLecturas(nuNuse open.lectelme.leemsesu%type,
                          dtfele open.lectelme.leemfele%type)
        IS
            SELECT LEEMLETO, LEEMPEFA, LEEMFELE, LEEMSESU, LEEMDOCU, LEEMPECS
            FROM open.lectelme
            WHERE LEEMSESU = nuNuse
            AND leemtcon = 1
            AND LEEMCLEC = 'F'
            AND leemfele > dtfele
            and lectelme.leemfele in
               (SELECT max(lectelme.leemfele)
                  FROM open.lectelme
                 WHERE leemsesu = nuNuse
                   AND leemclec = 'F')
            --Inicio CASO 200-216
            --and (lectelme.LEEMOBLE =-1 or LEEMOBLE IS NULL)
            and LEEMLETO > 0;
            --Fin CASO 200-216

        CURSOR CUEXISTE(NUDATO NUMBER, SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE)
        IS
            SELECT count(1) cantidad
            FROM DUAL
            WHERE NUDATO IN
               (select to_number(column_value)
                  from table(open.ldc_boutilities.splitstrings(SBPARAMETRO, ',')));

        nuCount NUMBER := 0;

        CURSOR cuObtieneProductosGas IS
            SELECT SESUNUSE
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        nuProductId     servsusc.sesunuse%type;
        
        CURSOR cuCantProdProcesar IS
            SELECT count(1)
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;
            
    BEGIN

        SBESTADOCORTE       := isbEstadoCorte;
        SBESTADOPRODUCTO    := isbEstadoProd;
        SBTIPOSUSPENSION    := isbTipoSuspen;
        
        If fblAplicaEntregaXCASO(csbEntrega2002611) Then
    		sbAplica2002611:='S';
    	Else
    		sbAplica2002611:='N';
    	end if;

        ut_trace.trace('Inicio LDC_PKGENEORDEAUTORECO.GeneraPerscaAuto',10);
        DELETE FROM open.LDC_SUSP_AUTORECO LSP
         WHERE LSP.SARECICL = DECODE(inCiclo, -1, LSP.SARECICL, inCiclo)
           AND LSP.SAREDEPA = DECODE(inDepartamento, -1, LSP.SAREDEPA, inDepartamento)
           AND LSP.SARELOCA = DECODE(inLocalidad, -1, LSP.SARELOCA, inLocalidad)
           AND LSP.SAREACOR IN ( SELECT LPA.ACTIVITY_ID
                     FROM open.LDC_PROCESO_ACTIVIDAD LPA
                     WHERE LPA.PROCESO_ID = inuProceso)
           AND LSP.SARESESU > 0
           AND MOD( LSP.SARESESU ,inuTotalHilos ) + inuHilo = inuTotalHilos;

         DELETE FROM open.LDC_SUSP_AUTORECO lsp
          WHERE lsp.SARECICL =  decode(inCiclo, -1, lsp.SARECICL, inCiclo)
            AND LSP.SAREDEPA = DECODE(inDepartamento, -1, LSP.SAREDEPA, inDepartamento)
            AND LSP.SARELOCA = DECODE(inLocalidad, -1, LSP.SARELOCA, inLocalidad)
            AND lsp.SAREACOR in
             (select lpa.activity_id
              from open.ldc_proceso_actividad lpa
               where lpa.proceso_id = inuProceso
               and lpa.activity_id = lsp.SAREACOR
               and lsp.saresesu in
                 (SELECT OOA.Product_Id
                  FROM OPEN.OR_ORDER_ACTIVITY OOA
                   WHERE OOA.ACTIVITY_ID = lsp.SAREACOR))
            AND LSP.SARESESU > 0
            AND MOD( LSP.SARESESU ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        COMMIT;

        /*Se obtiene la cantidad de registros a procesar*/
       /* OPEN cuCantProdProcesar;
        FETCH cuCantProdProcesar INTO nuTotal;
        CLOSE cuCantProdProcesar;*/

        OPEN cuObtieneProductosGas;
        LOOP
        FETCH cuObtieneProductosGas INTO nuProductId;
        EXIT WHEN cuObtieneProductosGas%NOTFOUND;

            OPEN cuproductossuspendidosauto( inCiclo,
                                         inuProceso,
                                         SBESTADOCORTE,
                                         SBESTADOPRODUCTO,
                                         SBTIPOSUSPENSION,
                                         inDepartamento,
                                         inLocalidad,
                                         nuProductId );
            LOOP
              FETCH cuproductossuspendidosauto BULK COLLECT INTO v_tbUsuarioAuto LIMIT 100;
               FORALL i IN 1..v_tbUsuarioAuto.COUNT
                 INSERT INTO LDC_PRODGENEPER  VALUES v_tbUsuarioAuto(i);
              EXIT WHEN cuproductossuspendidosauto%NOTFOUND;
            END LOOP;
            CLOSE cuproductossuspendidosauto;
            
        END LOOP;
        CLOSE cuObtieneProductosGas;

        -- Abre el CURSOR de productos y recupera los registros
        OPEN cuConsUsuaProc;
        LOOP
            FETCH cuConsUsuaProc BULK COLLECT INTO tbServsusc LIMIT 100;
            -- Obtiene el Total de registros a procesar
            nuTotal := nuTotal + tbServsusc.COUNT;
            FOR i IN 1..tbServsusc.COUNT LOOP

                nuCount := nuCount + 1;

                pkStatusExeProgramMgr.UpStatusExeProgramAT(isbProgram,
                                                             'Procesando productos...',
                                                             nuTotal,
                                                             nuCount);
            
                dfFechaLega := NULL;
                nuUltimaLectura := NULL;
                nuOrdenSusp := NULL;
                nuTitrSusp := NULL;
                nuLectSusp := null;
                numarcaprod:=null;--200-2614
            	rgLecturaProd:=null; --200-2611	 4

                -- Actualiza el estado del proceso en ESTAPROG

                -- Obtiene datos del producto a procesar
                nuNumesusc   := tbServsusc(i).sesususc;
                nuNumeServ   := tbServsusc(i).sesunuse;
                nuServEsco   := tbServsusc(i).sesuesco;
                nuciclo      := tbServsusc(i).sesucicl;
                nuORD_ACT_ID := tbServsusc(i).SUSPEN_ORD_ACT_ID;
                nuDepaProd   := tbServsusc(i).sesudepa;
                nuLocaProd   := tbServsusc(i).sesuloca;

                nuConta     := 0;
                sumaConsumo := 0;
                sw          := 0;

                IF cuMaximaLectura%ISOPEN THEN
                    CLOSE  cuMaximaLectura;
                END IF;

                -- busca la fecha de lectura
                open cuMaximaLectura(nuNumeServ, inuProceso);
                fetch cuMaximaLectura  into dfFechaLega, nuUltimaLectura,   nuOrdenSusp, nuTitrSusp ;
                if cuMaximaLectura%notfound then
                    dfFechaLega := null;
                end if;
                close cuMaximaLectura;

                --si es autoreconectado se realiza e cargue de los demas datos
                nuLectSusp := nuUltimaLectura;

                IF cuDatosProd%ISOPEN THEN
                  CLOSE  cuDatosProd;
                END IF;

                OPEN cuDatosProd;
                FETCH cuDatosProd INTO rgdatosProd;
                CLOSE cuDatosProd;

                IF cuConsuLectfact%ISOPEN THEN
                  CLOSE  cuConsuLectfact;
                END IF;

                OPEN cuConsuLectfact(dfFechaLega); --200-2611
                FETCH cuConsuLectfact INTO rgLecturaProd;
                CLOSE cuConsuLectfact;

                IF cuMarcaProd%ISOPEN THEN
                   CLOSE cuMarcaProd;
                END IF;

                OPEN cuMarcaProd;
                FETCH cuMarcaProd INTO numarcaprod;
                CLOSE cuMarcaProd;

              --PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA
              if dfFechaLega is not null AND SBESTADOCORTE <> '-1' then
                -- Abre el CURSOR de lecturas y recupera los registros
                open cuLecturas(nuNumeServ, dfFechaLega);
                fetch cuLecturas bulk collect INTO tblectelme;
                close cuLecturas;

                if tblectelme.first > 0 then

                  for k in tblectelme.first .. tblectelme.last loop
                    -- Obtiene datos de lecturas a procesar
                    nuLEEMLETO := tblectelme(k).LEEMLETO;
                    nuLEEMPEFA := tblectelme(k).LEEMPEFA;
                    dfLEEMFELE := tblectelme(k).LEEMFELE;
                    nuLEEMSESU := tblectelme(k).LEEMSESU;
                    nuLEEMDOCU := tblectelme(k).LEEMDOCU;
                    nuLEEMPECS := tblectelme(k).LEEMPECS;

                    if sw = 0 then
                      -- busca el periodo de consumo anterior al primer consumo despues de la suspension
                      GETPREVCONSPERIOD(nuLEEMPECS, ONUPREVPECSCONS);
                      -- busca el consumo promedio del periodo anterior al primer periodo de consumo despues de suspendido
                      nuPromedio := CM_BOHicoprpm.fnuGetLastConsbyProd(nuLEEMSESU,
                                                                       1,
                                                                       ONUPREVPECSCONS); -- promedio de consumo del producto del periodo anterior
                      Limite     := nuPromedio + add_cons_tope;
                      sw         := 1;
                    end if;

                    if ((nuLEEMLETO - nuUltimaLectura) > 0) then
                      nuConta         := nuConta + 1;
                      sumaConsumo     := sumaConsumo +
                                         (nuleemleto - nuUltimaLectura); --rcConsuLec.cosscoca;
                      nuUltimaLectura := nuleemleto;
                    else
                      --Inicio CASO 200-216
                      --Validacion de gasera
                      If fblAplicaEntrega('BSS_CART_JLV_200216_3') Then
                        if ((nuLEEMLETO - nuUltimaLectura) <> 0) then
                          nuConta         := nuConta + 1;
                          sumaConsumo     := sumaConsumo +
                                             (nuleemleto - nuUltimaLectura); --rcConsuLec.cosscoca;
                          nuUltimaLectura := nuleemleto;
                        else
                          nuConta     := 0;
                          sumaConsumo := 0;
                        end if;
                      else
                        if periodos_consecutivos = 'Y' then
                          nuConta     := 0;
                          sumaConsumo := 0;
                        end if;
                      end if;
                         --Fin CASO 200-216
                    end if;
                    EXIT WHEN(nuConta >= nuNumPeriodo);

                  end loop;

                  if (nuConta >= nuNumPeriodo) AND  SBESTADOCORTE IS NOT NULL then

                    --Inicio CASO 200-216
                    --Validacion de gasera
                    If fblAplicaEntrega('BSS_CART_JLV_200216_3') Then
                      --Topoe positivo
                      if (sumaConsumo > add_cons_tope) then
                        sbmarca := 'S';
                      else
                        --Tope Negativo
                        if (sumaConsumo < NUPCAR_TOPE_FACT_SUSP) then
                          sbmarca := 'S';
                        else
                          sbmarca := 'N';
                        end if;
                        --
                      end if;
                    else
                      --sb200216 := '1. FALSE';
                      --Validacion Original de EFIGAS
                      if (sumaConsumo > limite) then
                        sbmarca := 'S';
                      else
                        sbmarca := 'N';
                      end if;
                      --Validacion Original de EFIGAS
                    end if;
                    --Fin CASO 200-216

                    nuActivity  := daor_order_activity.Fnugetactivity_Id(nuORD_ACT_ID);
                    nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                    nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                    nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                    NUACTIV_GENERA := NULL;
                    NUACTIV_GENERA := fnuGetActividadgenerarAuto(inuProceso, nuActivity, numarcaprod);

                    --condicional para que ejecute cuando este ejecutando PERSCA en GDO
                    IF BLGDO = TRUE THEN
                      open cuexiste(nuActivity, SBCOD_ACTI_SUSP_CART_PERSCA);
                      fetch CUEXISTE
                        into nuexiste;
                      close CUEXISTE;

                      if nuexiste > 0 then
                        if (nuSaldoTot < nuSaldo_param) then
                          NUACTIV_GENERA := nuActivi_suspe_pers;
                        else
                          NUACTIV_GENERA := nuActivi_corte_pers;
                        end if;
                      end if;
                    end if;
                    --FIN condicional para que ejecute cuando este ejecutando PERSCA en GDO

                IF nvl(NUACTIV_GENERA,0) > 0 THEN

                    IF fsbPermiteRegistroAutoRec(nuNumeServ) = 'Y' THEN
                    
                        insert into LDC_SUSP_AUTORECO
                        (SARECODI,
                         SARESESU,
                          SARESAPE,
                          SARECONS,
                          SAREACTI,
                          SAREACOR,
                          SAREPEVA,
                          SAREAURE,
                          SAREFEGE,
                          SAREUSER,
                          SAREFEPR,
                          SAREORDE,
                          SARECICL,
                          SAREDEPA,
                          SARELOCA,
                          SARESECT,
                          SARECLIE,
                          SARECONT,
                          SAREESPR,
                          SAREDIRE,
                          SARECATE,
                          SAREMULT,
                          SAREPLMA,
                          SARELEAC,
                          SARELEAN,
                          SARELESU,
                          SAREFESU,
                          SARETTSU,
                          SAREORSU,
                          SAREMARC
                          )
                      values
                        (SEQ_LDC_SUSP_AUTORECO.nextval,
                         nuNumeServ,
                         nuSaldoTot,
                        nuLectSusp - nvl(rgLecturaProd.lectactu,0)  /*sumaConsumo*/,
                         NUACTIV_GENERA,
                         nuActivity,
                         nuConta,
                         sbmarca,
                         null,
                         null,
                         trunc(sysdate),
                         null,
                         nuciclo,
                         nuDepaProd,
                         nuLocaProd,
                         rgDatosProd.seop,
                         rgDatosProd.cliente,
                         rgDatosProd.contrato,
                         rgDatosProd.estado_prod,
                         rgDatosProd.direccion,
                         rgDatosProd.categoria,
                         rgDatosProd.multfami,
                         rgDatosProd.plazo_max,
                         rgLecturaProd.lectactu,
                         rgLecturaProd.lectant,
                         nuLectSusp,
                         dfFechaLega,
                         nuTitrSusp,
                         nuOrdenSusp,
                         numarcaprod
                          );

                        NUCantiReg := NUCantiReg + 1;
                    
                    END IF;

                    end if;

                    IF MOD(NUCantiReg, 1000) = 0 THEN
                       CantiReg := CantiReg + NUCantiReg  ;
                       NUCantiReg := 0;
                       commit;
                    END IF;

                  end if; -- (nuConta >= nuNumPeriodo)
                end if; --tblectelme.first > 0

              --PRESECUSION PARA LOS SERVICIOS CON EL ESTADO DEL PRODCUTO
              ELSif dfFechaLega is not null AND SBESTADOPRODUCTO <> '-1' then

                --Inicio CASO 200-216
                --Validacion de gasera
                If fblAplicaEntrega('BSS_CART_JLV_200216_3') Then
                  --sb200216 :=  '2. TRUE';
                  --if (sumaConsumo > limite) then
                  --Topoe positivo
                  if (nuUltimaLectura > add_cons_tope) then
                    sbmarca := 'S';
                  else
                    --Tope Negativo
                    if (nuUltimaLectura < NUPCAR_TOPE_FACT_SUSP) then
                      sbmarca := 'S';
                    else
                      sbmarca := 'N';
                    end if;
                    --
                  end if;
                else
                  --sb200216 :=  '2. FALSE';
                  --Validacion Original de EFIGAS
                  if (nuUltimaLectura > add_cons_tope) then
                    sbmarca := 'N';
                  else
                    sbmarca := 'S';
                  end if;
                  --Validacion Original de EFIGAS
                end if;
                --Fin CASO 200-216

                --200-2611--------------------
                IF sbAplica2002611 = 'S' then
                    if abs(nuLectSusp - rgLecturaProd.lectactu   )>=nuToleranciaDif AND rgLecturaProd.lectactu IS NOT NULL THEN
                      sbRegistra:='S';
                    else
                      sbRegistra:='N';
                    end if;
                else
                  sbRegistra :='S';
                end if;
                --200-2611--------------------

                nuActivity  := daor_order_activity.Fnugetactivity_Id(nuORD_ACT_ID);
                nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                NUACTIV_GENERA := NULL;
                NUACTIV_GENERA := fnuGetActividadgenerarAuto(inuProceso, nuActivity, numarcaprod);

                --nuNumeServ
                --nuSaldoTot
                ---rgLecturaProd.lectactu - nuLectSusp
                -- NUACTIV_GENERA
                -- nuActivity
                --nuConta
                -- sbmarca

                IF nvl(NUACTIV_GENERA,0) > 0 THEN

                  IF sbRegistra = 'S' THEN --200-2611
                  
                    IF fsbPermiteRegistroAutoRec(nuNumeServ) = 'Y' THEN
                    
                        insert into LDC_SUSP_AUTORECO
                        (SARECODI,
                         SARESESU,
                          SARESAPE,
                          SARECONS,
                          SAREACTI,
                          SAREACOR,
                          SAREPEVA,
                          SAREAURE,
                          SAREFEGE,
                          SAREUSER,
                          SAREFEPR,
                          SAREORDE,
                          SARECICL,
                          SAREDEPA,
                          SARELOCA,
                          SARESECT,
                          SARECLIE,
                          SARECONT,
                          SAREESPR,
                          SAREDIRE,
                          SARECATE,
                          SAREMULT,
                          SAREPLMA,
                          SARELEAC,
                          SARELEAN,
                          SARELESU,
                          SAREFESU,
                          SARETTSU,
                          SAREORSU,
                          SAREMARC
                          )
                      values
                        (SEQ_LDC_SUSP_AUTORECO.nextval,
                         nuNumeServ,
                         nuSaldoTot,
                         nvl(rgLecturaProd.lectactu,0) - nuLectSusp,--sumaConsumo,
                         NUACTIV_GENERA,
                         nuActivity,
                         nuConta,
                         sbmarca,
                         null,
                         null,
                         trunc(sysdate),
                         null,
                         nuciclo,
                         nuDepaProd,
                         nuLocaProd,
                         rgDatosProd.seop,
                         rgDatosProd.cliente,
                         rgDatosProd.contrato,
                         rgDatosProd.estado_prod,
                         rgDatosProd.direccion,
                         rgDatosProd.categoria,
                         rgDatosProd.multfami,
                         rgDatosProd.plazo_max,
                         rgLecturaProd.lectactu,
                         rgLecturaProd.lectant,
                         nuLectSusp,
                         dfFechaLega,
                         nuTitrSusp,
                         nuOrdenSusp,
                         numarcaprod
                          );
                    
                    END IF;
                    
                  END IF;--200-2611
                NUCantiReg := NUCantiReg + 1;
                end if; -- nvl(NUACTIV_GENERA,0) > 0

               IF MOD(NUCantiReg, 1000) = 0 THEN
                 CantiReg := CantiReg + NUCantiReg;
                 NUCantiReg := 0;
                 commit;
               END IF;
            END IF; -- FIN PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA

            END LOOP; -- fin for
        COMMIT;
        CantiReg := CantiReg + NUCantiReg;
        NUCantiReg := 0;

        EXIT WHEN cuConsUsuaProc%NOTFOUND;
        END LOOP;
        CLOSE cuConsUsuaProc;
        

        -- Actualiza el estaprog en el campo estasufa, para indicar la cantidad de usuarios a persecucion
        UPDATE estaprog SET esprsufa = CantiReg WHERE esprprog = isbProgram;
        commit;

        onuOk := 1;

        ut_trace.trace('Fin LDC_PKGENEORDEAUTORECO.GeneraPerscaAuto',10);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            UT_Trace.Trace('CONTROLLED_ERROR LDC_PKGENEORDEAUTORECO.GeneraPerscaAuto', 10);
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_Trace.Trace('OTHERS LDC_PKGENEORDEAUTORECO.GeneraPerscaAuto', 10);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END GeneraPerscaAuto;
 
 
    /**************************************************************************
        Nombre      : GeneraPerscaNoAuto
        Autor       : OLsoftware
        Fecha       : 05-07-2020
        Ticket      : CA47
        Descripcion : Procesa los registros cuando no es automatico

        Parametros Entrada
         inuProceso         Codigo del proceso
         inCiclo            Codigo del ciclo
         inDepartamento     Codigo dl departamento
         inLocalidad        Codigo de la localidad
         inuHilo            Hilo actual
         inuTotalHilos      Total hilos
         inuServ            Tipo de producto
         isbEstaCorte       Estados de corte
         isbProgram         Programa

        Valor de salida
         onuOk              0- Exito, -1 Error
         osbMensaje         Mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        05/07/2020  OLsoftware   CA47. Creacion
    ***************************************************************************/
    PROCEDURE GeneraPerscaNoAuto
    (
        inuProceso      IN   NUMBER,
        inCiclo         IN   NUMBER,
        inDepartamento  IN   NUMBER,
        inLocalidad     IN   NUMBER,
        inuHilo         IN   NUMBER,
        inuTotalHilos   IN   NUMBER,
        inuServ         IN   NUMBER,
        isbProgram      IN   VARCHAR2,
        isbEstadoCorte  IN   VARCHAR2,
        isbEstadoProd   IN   VARCHAR2,
        isbTipoSuspen   IN   VARCHAR2,
        onuOk           OUT  NUMBER,
        osbMensaje      OUT  VARCHAR2
    )
    IS

        --200-2614
    	nuToleranciaDif	number:=NVL(DALD_PARAMETER.FNUGETNUMERIC_VALUE('TOLERANCIA_DIFE_AUTORECONE',3),0);
    	sbRegistra	    varchar2(1);
    	nuexiste number := 0;
    	--200-2614

        --Inicio CASO 200-216
        NUPCAR_TOPE_FACT_SUSP open.ld_parameter.numeric_value%type := open.dald_parameter.fnuGetNumeric_Value('PCAR_TOPE_FACT_SUSP',null);
        SBCOD_ACTI_SUSP_CART_PERSCA OPEN.LD_PARAMETER.VALUE_CHAIN%type := OPEN.DALD_PARAMETER.fsbGetValue_Chain('COD_ACTI_SUSP_CART_PERSCA',NULL);
        --sb200216 varchar2(4000);
        --Fin CASO 200-216
        nuDepaProd NUMBER;
        nuLocaProd NUMBER;

        nuTitrSusp NUMBER;
        nuOrdenSusp  NUMBER;
        nuLectSusp  NUMBER;

        --inuProceso               NUMBER;
        SBESTADOCORTE              VARCHAR2(4000);
        SBESTADOPRODUCTO           VARCHAR2(4000);
        SBTIPOSUSPENSION           VARCHAR2(4000);
        SBDESARROLLO               VARCHAR2(4000) := 'BSS_JLVM_RNP_1005';
        BLGDO                      BOOLEAN := open.LDC_CONFIGURACIONRQ.aplicaParaGDO(SBDESARROLLO);

        nuUltimaLectura number;
        CantiReg     number := 0;
        NUCantiReg     number := 0;

        nuConta      number := 0;
        sumaConsumo  number := 0;
        nuPromedio   number := 0;
        nuDeudaCorr  NUMBER(15, 2) := 0;
        nuDeudaDife  NUMBER(15, 2) := 0;
        nuSaldoTot   NUMBER(15, 2) := 0;
        Limite       number(9);
        sbmarca      varchar(1);
        --NUORDER_ID        or_order.order_id%type;
        NUACTIVITY     open.ge_items.items_id%type;
        NUACTIV_GENERA open.ge_items.items_id%type;
        DFFECHALEGA    date;

        nuTotal    NUMBER := 0;
       -- sbProgram  VARCHAR2(2000) := 'PERSCA';
        --parametros

        nuNumPeriodo          number := open.Dald_parameter.fnuGetNumeric_Value('NUM_PERI_EVA_PERS',null);
        nuActivi_suspe_pers   open.ge_items.items_id%type := open.Dald_parameter.fnuGetNumeric_Value('ID_ITEM_SUSP_PERS',null);
        nuActivi_corte_pers   open.ge_items.items_id%type := open.Dald_parameter.fnuGetNumeric_Value('ID_ITEM_CORTE_PERS',null);
        nuSaldo_param         NUMBER(15, 2) := open.Dald_parameter.fnuGetNumeric_Value('SALDO_TOTAL_PERS',null);
        add_cons_tope         number(9) := open.Dald_parameter.fnuGetNumeric_Value('PCAR_VALOR_ADIC_CONS_PROM',null);
        sw                    number;
        periodos_consecutivos VARCHAR2(1) := open.DALD_PARAMETER.fsbGetValue_Chain('FLAG_PERIODO_CONSE_PERS',null);
        ONUPREVPECSCONS       conssesu.cosspecs%type;
        -- contrato a procesar
        nuNumesusc open.servsusc.sesususc%type;
        -- Producto a procesar
        nuNumeServ open.servsusc.sesunuse%type;
        -- Estado de Corte del Producto
        nuServEsco open.servsusc.sesuesco%type;
        -- Ciclo del producto
        nuciclo open.servsusc.sesucicl%type;
        -- order_activity_id de la orden de suspension
        nuORD_ACT_ID open.pr_product.SUSPEN_ORD_ACT_ID%type;

        nuLEEMLETO open.lectelme.LEEMLETO%type;
        nuLEEMPEFA open.lectelme.LEEMPEFA%type;
        dfLEEMFELE open.lectelme.LEEMFELE%type;
        nuLEEMSESU open.lectelme.LEEMSESU%type;
        nuLEEMDOCU open.lectelme.LEEMDOCU%type;
        nuLEEMPECS open.lectelme.LEEMPECS%type;

        type styServsusc IS record(
            sesususc          open.servsusc.sesususc%type,
            sesunuse          open.servsusc.sesunuse%type,
            sesuesco          open.servsusc.sesuesco%type,
            sesucicl          open.servsusc.sesucicl%type,
            SUSPEN_ORD_ACT_ID open.pr_product.SUSPEN_ORD_ACT_ID%type,
            sesudepa          number(6),
            sesuloca          number(6),
            PERSHILO          open.LDC_PRODGENEPER.pershilo%TYPE
        );

        type tbtyServsuscTable IS table of styServsusc index BY binary_integer;

        tbServsusc tbtyServsuscTable;

        type stylectelme IS record(
            LEEMLETO open.lectelme.LEEMLETO%type,
            LEEMPEFA open.lectelme.LEEMPEFA%type,
            LEEMFELE open.lectelme.LEEMFELE%type,
            LEEMSESU open.lectelme.LEEMSESU%type,
            LEEMDOCU open.lectelme.LEEMDOCU%type,
            LEEMPECS open.lectelme.LEEMPECS%type
        );

        type tbtylectelmeTable IS table of stylectelme index BY binary_integer;

        tblectelme tbtylectelmeTable;

        cursor cuproductossuspendidos(nuCiclo          open.servsusc.sesucicl%type,
                                      NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE,
                                      ESTADOCORTE      VARCHAR2,
                                      ESTADOPRODCUTO   VARCHAR2,
                                      TIPOSSUSPENSION  VARCHAR2,
                                      inudepa  NUMBER,
                                      inuloca NUMBER,
                                      inuProductId     IN servsusc.sesunuse%type)
        IS
            SELECT *
            FROM (
                SELECT sesususc,
                   sesunuse,
                   sesuesco,
                   sesucicl,
                   suspen_ord_act_id,
                   open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(s.sesunuse) DEPA,
                   open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTLOCALITY(s.sesunuse ) LOCA,
                   inuHilo pershilo
                FROM open.servsusc              s,
                     open.pr_product            p,
                     open.pr_prod_suspension    ps,
                     open.ldc_proceso_actividad lpa
                WHERE s.sesuesco IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(estadocorte,
                                                                   '-1',
                                                                       to_char(s.sesuesco),
                                                                      estadocorte),
                                                                ',')))
                 AND p.product_status_id IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(estadoprodcuto,
                                                                       '-1',
                                                                       to_char(p.product_status_id),
                                                                       estadoprodcuto),
                                                                ',')))
                 AND ps.suspension_type_id IN
                     (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(open.ldc_boutilities.splitstrings(decode(tipossuspension,
                                                                       '-1',
                                                                       to_char(ps.suspension_type_id),
                                                                       tipossuspension),
                                                                ',')))
                 AND s.sesucicl = decode(nuciclo, -1, s.sesucicl, nuciclo)
                 AND sesuserv = inuServ
                 and ps.ACTIVE ='Y'
                 AND p.product_id = s.sesunuse
                 AND p.product_id = ps.product_id
                 AND p.suspen_ord_act_id IS NOT NULL
                 AND 0 = (SELECT count(1)
                            FROM open.ldc_susp_persecucion, or_order
                           WHERE susp_persec_producto = sesunuse
                             AND susp_persec_order_id = order_id
                             AND order_status_id IN (0, 5, 7)) --200-2614
                 AND 0 = (SELECT count(1)
                            FROM open.ldc_susp_persecucion
                           WHERE susp_persec_producto = s.sesunuse
                             AND susp_persec_order_id IS NULL)
                 AND lpa.proceso_id = nuldc_proceso_id
                 AND lpa.activity_id =
                     OPEN.daor_order_activity.fnugetactivity_id(suspen_ord_act_id,
                                                                NULL)
                 AND NOT EXISTS(  SELECT 'X'
                                  FROM open.or_order_activity, open.or_order, open.ldc_actividad_generada
                                  WHERE or_order_activity.product_id = p.product_id
                                     AND or_order_activity.order_id = or_order.order_id
                                     AND order_status_id IN (0, 5, 7) --200-2614
                                     AND or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                       AND ldc_actividad_generada.activity_id_generada = lpa.activity_id -- Inicia NC 3468.
                                    )
                AND sesunuse = inuProductId

              ) WHERE DEPA = DECODE(inuDepa, -1, depa, inudepa)
                AND loca = DECODE(inuLoca, -1, loca, inuLoca);

        TYPE tbUsuarioPers IS TABLE OF cuproductossuspendidos%ROWTYPE  ;
        v_tbUsuarioPers tbUsuarioPers;

        CURSOR cuConsUsuaProc
        IS
            SELECT *
            FROM open.LDC_PRODGENEPER
            WHERE pershilo = inuHilo;

        CURSOR cuMaximaLectura(nuNuse           open.lectelme.leemsesu%type,
                               NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE)
        IS
            /*ajuste  # 1 seg?n necesidad del tiquete 3567 09/05/2014
          se suprimi la condici?n AND LEEMOBLE = 65 y se  cambia por
          open.ldc_boutilities.fsbbuscatoken(open.dald_parameter.fsbgetvalue_chain('TIPO_TRAB_REPESCA'),to_char(B.task_type_id),',') = 'S'
          se crea parametro TIPO_TRAB_REPESCA en LDPAR donde el funcional parametrizar? los Tipos de Trabajos para el proceso de repesca  */
            SELECT leemfele, nvl(leemleto, 0), b.order_id, b.task_type_id
            FROM open.lectelme a
            inner join open.or_order_activity b
            on a.LEEMDOCU = b.ORDER_ACTIVITY_ID
            WHERE LEEMSESU = nuNuse
            AND LEEMCLEC = 'T'
            AND open.DAOR_ORDER.FNUGETTASK_TYPE_ID(open.DAOR_ORDER_ACTIVITY.FNUGETORDER_ID(B.ORDER_ACTIVITY_ID,
                                                                                NULL),
                                             NULL) =
               (SELECT LPA.TASK_TYPE_ID
                  FROM open.LDC_PROCESO_ACTIVIDAD LPA
                 WHERE LPA.PROCESO_ID = NULDC_PROCESO_ID
                   AND LPA.ACTIVITY_ID = B.ACTIVITY_ID)
           ORDER BY leemfele desc;


        CURSOR cuLecturas(nuNuse open.lectelme.leemsesu%type,
                          dtfele open.lectelme.leemfele%type)
        IS
            SELECT LEEMLETO, LEEMPEFA, LEEMFELE, LEEMSESU, LEEMDOCU, LEEMPECS
            FROM open.lectelme
            WHERE LEEMSESU = nuNuse
            AND leemtcon = 1
            AND LEEMCLEC = 'F'
            AND leemfele > dtfele
            and lectelme.leemfele in
               (SELECT max(lectelme.leemfele)
                  FROM open.lectelme
                 WHERE leemsesu = nuNuse
                   AND leemclec = 'F')
            --Inicio CASO 200-216
            and (lectelme.LEEMOBLE =-1 or LEEMOBLE IS NULL)
            and LEEMLETO > 0;
            --Fin CASO 200-216

        --CURSOR PARA LA PROXIMA ACTIVIDAD A GENERAR
        CURSOR CULDC_ACTIVIDAD_GENERADA
        (
            NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE,
            NUACTIVITY_ID    open.LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE)
        IS
            SELECT LAG.*
            FROM open.LDC_ACTIVIDAD_GENERADA LAG
            WHERE LAG.PROCESO_ID = NULDC_PROCESO_ID
            AND LAG.ACTIVITY_ID_GENERADA = NUACTIVITY_ID;

        TEMPLDC_ACTIVIDAD_GENERADA CULDC_ACTIVIDAD_GENERADA%ROWTYPE;

        CURSOR CUEXISTE(NUDATO NUMBER, SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE)
        IS
            SELECT count(1) cantidad
            FROM DUAL
            WHERE NUDATO IN
               (select to_number(column_value)
                  from table(open.ldc_boutilities.splitstrings(SBPARAMETRO, ',')));

        ---curosr para determinar si el producto ya esta registrado
        cursor culdc_susp_persecucion
        (
            nususp_persec_producto open.ldc_susp_persecucion.susp_persec_producto %TYPE
        )
        is
            select count(1)
            from open.ldc_susp_persecucion lsp
            where lsp.susp_persec_producto = nususp_persec_producto;

        nuculdc_susp_persecucion number := 0;
        nuCount         number := 0;
        
        CURSOR cuObtieneProductosGas IS
            SELECT SESUNUSE
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        nuProductId     servsusc.sesunuse%type;
        
        CURSOR cuCantProdProcesar IS
            SELECT count(1)
            FROM SERVSUSC
            WHERE sesuserv = inuServ
            AND MOD( sesunuse ,inuTotalHilos ) + inuHilo = inuTotalHilos;

    BEGIN

        SBESTADOCORTE       := isbEstadoCorte;
        SBESTADOPRODUCTO    := isbEstadoProd;
        SBTIPOSUSPENSION    := isbTipoSuspen;

        ut_trace.trace('Inicio LDC_PKGENEORDEAUTORECO.GeneraPerscaNoAuto',10);
        --se eliminan registros
        DELETE FROM open.LDC_SUSP_PERSECUCION LSP
         WHERE LSP.SUSP_PERSEC_CICLCODI = DECODE(inCiclo, -1, LSP.SUSP_PERSEC_CICLCODI, inCiclo)
           AND LSP.SUSP_PERSEC_DEPA = DECODE(inDepartamento, -1, LSP.SUSP_PERSEC_DEPA, inDepartamento)
           AND LSP.SUSP_PERSEC_LOCA = DECODE(inLocalidad, -1, LSP.SUSP_PERSEC_LOCA, inLocalidad)
           AND LSP.SUSP_PERSEC_ACT_ORIG IN ( SELECT LPA.ACTIVITY_ID
                               FROM LDC_PROCESO_ACTIVIDAD LPA
                              WHERE LPA.PROCESO_ID = inuProceso)
           AND LSP.SUSP_PERSEC_PRODUCTO > 0
           AND MOD( LSP.SUSP_PERSEC_PRODUCTO ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        DELETE FROM open.LDC_SUSP_PERSECUCION lsp
         WHERE lsp.susp_persec_ciclcodi =  decode(inCiclo, -1, lsp.susp_persec_ciclcodi, inCiclo)
           AND LSP.SUSP_PERSEC_DEPA = DECODE(inDepartamento, -1, LSP.SUSP_PERSEC_DEPA, inDepartamento)
           AND LSP.SUSP_PERSEC_LOCA = DECODE(inLocalidad, -1, LSP.SUSP_PERSEC_LOCA, inLocalidad)
           and lsp.susp_persec_act_orig in
             (select lpa.activity_id
              from ldc_proceso_actividad lpa
               where lpa.proceso_id = inuProceso
               and lpa.activity_id = lsp.susp_persec_act_orig
               and lsp.susp_persec_producto in
                 (SELECT OOA.Product_Id
                  FROM OPEN.OR_ORDER_ACTIVITY OOA
                   WHERE OOA.ACTIVITY_ID = lsp.susp_persec_act_orig))
           AND LSP.SUSP_PERSEC_PRODUCTO > 0
           AND MOD( LSP.SUSP_PERSEC_PRODUCTO ,inuTotalHilos ) + inuHilo = inuTotalHilos;

        COMMIT;

        --se consultas datos para hacer persecucion y se llena tabla de sesion
        
       /* OPEN cuCantProdProcesar;
        FETCH cuCantProdProcesar INTO nuTotal;
        CLOSE cuCantProdProcesar; */
        
        OPEN cuObtieneProductosGas;
        LOOP
        FETCH cuObtieneProductosGas INTO nuProductId;
        EXIT WHEN cuObtieneProductosGas%NOTFOUND;
        
            OPEN cuproductossuspendidos( inCiclo,
                                     inuProceso,
                                     SBESTADOCORTE,
                                     SBESTADOPRODUCTO,
                                     SBTIPOSUSPENSION,
                                     inDepartamento,
                                     inLocalidad,
                                     nuProductId );
            LOOP
              FETCH cuproductossuspendidos BULK COLLECT INTO v_tbUsuarioPers LIMIT 100;
                FORALL i IN 1..v_tbUsuarioPers.COUNT
                    INSERT INTO open.LDC_PRODGENEPER  VALUES v_tbUsuarioPers(i);
              EXIT WHEN cuproductossuspendidos%NOTFOUND;
            END LOOP;
            CLOSE cuproductossuspendidos;
            

        END LOOP;
        CLOSE cuObtieneProductosGas;

        -- Abre el CURSOR de productos y recupera los registros
            OPEN cuConsUsuaProc;
            LOOP
            FETCH cuConsUsuaProc BULK COLLECT INTO tbServsusc LIMIT 100;
            -- Obtiene el Total de registros a procesar

            nuTotal := nuTotal + tbServsusc.COUNT;
            
            FOR i IN 1..tbServsusc.COUNT LOOP

                nuCount := nuCount + 1;

                -- Actualiza el estado del proceso en ESTAPROG
                pkStatusExeProgramMgr.UpStatusExeProgramAT(isbProgram,
                                                           'Procesando productos...',
                                                            nuTotal,
                                                            nuCount);
                dfFechaLega := NULL;
                nuUltimaLectura := NULL;
                nuOrdenSusp := NULL;
                nuTitrSusp := NULL;
                nuLectSusp := null;

                -- Obtiene datos del producto a procesar
                nuNumesusc   := tbServsusc(i).sesususc;
                nuNumeServ   := tbServsusc(i).sesunuse;
                nuServEsco   := tbServsusc(i).sesuesco;
                nuciclo      := tbServsusc(i).sesucicl;
                nuORD_ACT_ID := tbServsusc(i).SUSPEN_ORD_ACT_ID;
                nuDepaProd   := tbServsusc(i).sesudepa;
                nuLocaProd   := tbServsusc(i).sesuloca;

                nuConta     := 0;
                sumaConsumo := 0;
                sw          := 0;

                IF cuMaximaLectura%ISOPEN THEN
                    CLOSE  cuMaximaLectura;
                END IF;

                -- busca la fecha de lectura
                open cuMaximaLectura(nuNumeServ, inuProceso);
                fetch cuMaximaLectura  into dfFechaLega, nuUltimaLectura,   nuOrdenSusp, nuTitrSusp ;
                if cuMaximaLectura%notfound then
                    dfFechaLega := null;
                end if;
                close cuMaximaLectura;

              --PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA
              if dfFechaLega is not null AND SBESTADOCORTE <> '-1' then
                -- Abre el CURSOR de lecturas y recupera los registros
                open cuLecturas(nuNumeServ, dfFechaLega);
                fetch cuLecturas bulk collect INTO tblectelme;
                close cuLecturas;

                if tblectelme.first > 0 then
                  --for Consu in cuPerico(rg.sesunuse, dfFechaLega) loop
                  for k in tblectelme.first .. tblectelme.last loop
                    -- Obtiene datos de lecturas a procesar
                    nuLEEMLETO := tblectelme(k).LEEMLETO;
                    nuLEEMPEFA := tblectelme(k).LEEMPEFA;
                    dfLEEMFELE := tblectelme(k).LEEMFELE;
                    nuLEEMSESU := tblectelme(k).LEEMSESU;
                    nuLEEMDOCU := tblectelme(k).LEEMDOCU;
                    nuLEEMPECS := tblectelme(k).LEEMPECS;
                    --for Consu in cuLecturas(nuNumeServ, dfFechaLega) loop
                    if sw = 0 then
                      -- busca el periodo de consumo anterior al primer consumo despues de la suspension
                      GETPREVCONSPERIOD(nuLEEMPECS, ONUPREVPECSCONS);
                      -- busca el consumo promedio del periodo anterior al primer periodo de consumo despues de suspendido
                      nuPromedio := CM_BOHicoprpm.fnuGetLastConsbyProd(nuLEEMSESU,
                                                                       1,
                                                                       ONUPREVPECSCONS); -- promedio de consumo del producto del periodo anterior
                      Limite     := nuPromedio + add_cons_tope;
                      sw         := 1;
                    end if;

                    if ((nuLEEMLETO - nuUltimaLectura) > 0) then
                      nuConta         := nuConta + 1;
                      sumaConsumo     := sumaConsumo +
                                         (nuleemleto - nuUltimaLectura); --rcConsuLec.cosscoca;
                      nuUltimaLectura := nuleemleto;
                    else
                      --Inicio CASO 200-216
                      --Validacion de gasera
                      If fblAplicaEntrega('BSS_CART_JLV_200216_3') Then
                        if ((nuLEEMLETO - nuUltimaLectura) <> 0) then
                          nuConta         := nuConta + 1;
                          sumaConsumo     := sumaConsumo +
                                             (nuleemleto - nuUltimaLectura); --rcConsuLec.cosscoca;
                          nuUltimaLectura := nuleemleto;
                        else
                          nuConta     := 0;
                          sumaConsumo := 0;
                        end if;
                      else
                        if periodos_consecutivos = 'Y' then
                          nuConta     := 0;
                          sumaConsumo := 0;
                        end if;
                      end if;
                         --Fin CASO 200-216
                    end if; -- ((nuLEEMLETO - nuUltimaLectura) > 0)

                    EXIT WHEN(nuConta >= nuNumPeriodo);

                  end loop;
                  
                  if (nuConta >= nuNumPeriodo) AND  SBESTADOCORTE IS NOT NULL then
                   --  TEMPCULDC_PROCESO.ESTADOCORTE IS NOT NULL then
                    --Inicio CASO 200-216
                    --Validacion de gasera
                    If fblAplicaEntrega('BSS_CART_JLV_200216_3') Then
                      --Topoe positivo
                      if (sumaConsumo > add_cons_tope) then
                        sbmarca := 'S';
                      else
                        --Tope Negativo
                        if (sumaConsumo < NUPCAR_TOPE_FACT_SUSP) then
                          sbmarca := 'S';
                        else
                          sbmarca := 'N';
                        end if;
                        --
                      end if;
                    else
                      --sb200216 := '1. FALSE';
                      --Validacion Original de EFIGAS
                      if (sumaConsumo > limite) then
                        sbmarca := 'S';
                      else
                        sbmarca := 'N';
                      end if;
                      --Validacion Original de EFIGAS
                    end if;
                    --Fin CASO 200-216

                    nuActivity  := daor_order_activity.Fnugetactivity_Id(nuORD_ACT_ID);
                    nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                    nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                    nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                    NUACTIV_GENERA := NULL;


                    OPEN CULDC_ACTIVIDAD_GENERADA(inuProceso, nuActivity);
                    FETCH CULDC_ACTIVIDAD_GENERADA
                    INTO TEMPLDC_ACTIVIDAD_GENERADA;

                    IF CULDC_ACTIVIDAD_GENERADA%FOUND THEN
                        NUACTIV_GENERA := TEMPLDC_ACTIVIDAD_GENERADA.PROXIMA_ACTIVITY_ID;
                    END IF;
                    CLOSE CULDC_ACTIVIDAD_GENERADA;

                    --condicional para que ejecute cuando este ejecutando PERSCA en GDO
                    IF BLGDO = TRUE THEN
                      open cuexiste(nuActivity, SBCOD_ACTI_SUSP_CART_PERSCA);
                      fetch CUEXISTE
                        into nuexiste;
                      close CUEXISTE;

                      if nuexiste > 0 then
                        if (nuSaldoTot < nuSaldo_param) then
                          NUACTIV_GENERA := nuActivi_suspe_pers;
                        else
                          NUACTIV_GENERA := nuActivi_corte_pers;
                        end if;
                      end if;
                    end if;
                    --FIN condicional para que ejecute cuando este ejecutando PERSCA en GDO

                   IF nvl(NUACTIV_GENERA,0) > 0 THEN
                   --se valida si es autoreconectado
                    open culdc_susp_persecucion(nuNumeServ);
                    fetch culdc_susp_persecucion
                      into nuculdc_susp_persecucion;
                    close culdc_susp_persecucion;

                        if nuculdc_susp_persecucion = 0 then

                        insert into LDC_SUSP_PERSECUCION
                          (SUSP_PERSEC_CODI,
                           SUSP_PERSEC_PRODUCTO,
                           SUSP_PERSEC_SALPEND,
                           SUSP_PERSEC_CONSUMO,
                           SUSP_PERSEC_ACTIVID,
                           SUSP_PERSEC_ACT_ORIG,
                           SUSP_PERSEC_PERVARI,
                           SUSP_PERSEC_PERSEC,
                           SUSP_PERSEC_FEGEOT,
                           SUSP_PERSEC_USER_ID,
                           SUSP_PERSEC_FEJPROC,
                           SUSP_PERSEC_ORDER_ID,
                           SUSP_PERSEC_CICLCODI,
                           SUSP_PERSEC_DEPA,
                           SUSP_PERSEC_LOCA)
                        values
                          (SEQ_LDC_SUSP_PERSECUCION.nextval,
                           nuNumeServ,
                           nuSaldoTot,
                           sumaConsumo,
                           NUACTIV_GENERA,
                           nuActivity,
                           nuConta,
                           sbmarca,
                           null,
                           null,
                           trunc(sysdate),
                           null,
                           nuciclo,
                           nuDepaProd,
                           nuLocaProd);
                        END IF;

                        NUCantiReg := NUCantiReg + 1;

                   end if; -- nvl(NUACTIV_GENERA,0) > 0

                    IF MOD(NUCantiReg, 1000) = 0 THEN
                       CantiReg := CantiReg + NUCantiReg  ;
                       NUCantiReg := 0;
                       commit;
                    END IF;

                  end if; -- (nuConta >= nuNumPeriodo)
                end if; --tblectelme.first > 0

              --PRESECUSION PARA LOS SERVICIOS CON EL ESTADO DEL PRODCUTO
              ELSif dfFechaLega is not null AND SBESTADOPRODUCTO <> '-1' then


                --Inicio CASO 200-216
                --Validacion de gasera
                If fblAplicaEntrega('BSS_CART_JLV_200216_3') Then
                  --sb200216 :=  '2. TRUE';
                  --if (sumaConsumo > limite) then
                  --Topoe positivo
                  if (nuUltimaLectura > add_cons_tope) then
                    sbmarca := 'S';
                  else
                    --Tope Negativo
                    if (nuUltimaLectura < NUPCAR_TOPE_FACT_SUSP) then
                      sbmarca := 'S';
                    else
                      sbmarca := 'N';
                    end if;
                    --
                  end if;
                else
                  --sb200216 :=  '2. FALSE';
                  --Validacion Original de EFIGAS
                  if (nuUltimaLectura > add_cons_tope) then
                    sbmarca := 'N';
                  else
                    sbmarca := 'S';
                  end if;
                  --Validacion Original de EFIGAS
                end if;
                --Fin CASO 200-216

                --200-2611--------------------
                sbRegistra :='S';
                --200-2611--------------------

                nuActivity  := daor_order_activity.Fnugetactivity_Id(nuORD_ACT_ID);
                nuDeudaCorr := gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
                nuDeudaDife := gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
                nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));

                NUACTIV_GENERA := NULL;

                OPEN CULDC_ACTIVIDAD_GENERADA(inuProceso, nuActivity);
                FETCH CULDC_ACTIVIDAD_GENERADA
                INTO TEMPLDC_ACTIVIDAD_GENERADA;
                IF CULDC_ACTIVIDAD_GENERADA%FOUND THEN
                   NUACTIV_GENERA := TEMPLDC_ACTIVIDAD_GENERADA.PROXIMA_ACTIVITY_ID;
                END IF;
                CLOSE CULDC_ACTIVIDAD_GENERADA;

                IF nvl(NUACTIV_GENERA,0) > 0 THEN
                  open culdc_susp_persecucion(nuNumeServ);
                  fetch culdc_susp_persecucion
                    into nuculdc_susp_persecucion;
                  close culdc_susp_persecucion;

                  if nuculdc_susp_persecucion = 0 then
                   --se valida si es autoreconectado
                      insert into LDC_SUSP_PERSECUCION
                        (SUSP_PERSEC_CODI,
                         SUSP_PERSEC_PRODUCTO,
                         SUSP_PERSEC_SALPEND,
                         SUSP_PERSEC_CONSUMO,
                         SUSP_PERSEC_ACTIVID,
                         SUSP_PERSEC_ACT_ORIG,
                         SUSP_PERSEC_PERVARI,
                         SUSP_PERSEC_PERSEC,
                         SUSP_PERSEC_FEGEOT,
                         SUSP_PERSEC_USER_ID,
                         SUSP_PERSEC_FEJPROC,
                         SUSP_PERSEC_ORDER_ID,
                         SUSP_PERSEC_CICLCODI,
                         SUSP_PERSEC_DEPA,
                         SUSP_PERSEC_LOCA)
                      values
                        (SEQ_LDC_SUSP_PERSECUCION.nextval,
                         nuNumeServ,
                         nuSaldoTot,
                         sumaConsumo,
                         NUACTIV_GENERA,
                         nuActivity,
                         nuConta,
                         sbmarca,
                         null,
                         null,
                         trunc(sysdate),
                         null,
                         nuciclo,
                         nuDepaProd,
                         nulocaProd);
                    END IF;

                NUCantiReg := NUCantiReg + 1;
                end if;  -- nvl(NUACTIV_GENERA,0) > 0

                IF MOD(NUCantiReg, 1000) = 0 THEN
                 CantiReg := CantiReg + NUCantiReg;
                 NUCantiReg := 0;
                 commit;
                END IF;
              END IF; -- FIN PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA

            END LOOP; -- fin for
        COMMIT;
        CantiReg := CantiReg + NUCantiReg;
        NUCantiReg := 0;

        EXIT WHEN cuConsUsuaProc%NOTFOUND;
        END LOOP;
        CLOSE cuConsUsuaProc;
        


        -- Actualiza el estaprog en el campo estasufa, para indicar la cantidad de usuarios a persecucion
        UPDATE estaprog SET esprsufa = CantiReg WHERE esprprog = isbProgram;
        commit;

        onuOk := 1;
        ut_trace.trace('Inicio LDC_PKGENEORDEAUTORECO.GeneraPerscaNoAuto',10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            UT_Trace.Trace('CONTROLLED_ERROR LDC_PKGENEORDEAUTORECO.GeneraPerscaNoAuto', 10);
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_Trace.Trace('OTHERS LDC_PKGENEORDEAUTORECO.GeneraPerscaNoAuto', 10);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;

    END GeneraPerscaNoAuto;

 PROCEDURE progeneraPersca( isbProgram  in VARCHAR2,
                            inuProceso IN   NUMBER,
                            sbCICLO IN VARCHAR2,
                            sbDepartamento IN VARCHAR2,
                            sbLocalidad IN VARCHAR2,
                            inuHilo         IN   NUMBER,
                            inuTotalHilos   IN   NUMBER) IS
   /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar persecuon

        Parametros Entrada
         inuProceso    codigo del proceso
         sbCICLO     codigo del ciclo
         sbDepartamento   departamento
         sbLocalidad     localidad
        Valor de salida
        onuOk        0- Exito, -1 Error
        osbMensaje     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        02/05/2019   dsaltarin   caso 200-2614 Se realizan correcciones al proceso,
                                 para que solo registre los autoreconectados que
                                 tengan diferencia de lectura
        05/07/2020  OLsoftware   Se ajusta para serparar la lógica cuando se haga
                                 llamado si es un proceso automatico o no.
   ***************************************************************************/
    inCiclo             open.LDC_PROVCART.PROVANO%type;
    inDepartamento      NUMBER;
    inLocalidad         NUMBER;
    sbParametros open.GE_PROCESS_SCHEDULE.PARAMETERS_%type;
    onuOk   number;
    osbMensaje varchar2(2000);
    nuServ       open.LD_PARAMETER.numeric_value%TYPE;
    CantiReg     number := 0;
    NUCantiReg     number := 0;

    nuConta      number := 0;
    sumaConsumo  number := 0;
    nuPromedio   number := 0;
    nuDeudaCorr  NUMBER(15, 2) := 0;
    nuDeudaDife  NUMBER(15, 2) := 0;
    nuSaldoTot   NUMBER(15, 2) := 0;
    Limite       number(9);
    sbmarca      varchar(1);
    --NUORDER_ID        or_order.order_id%type;
    NUACTIVITY     open.ge_items.items_id%type;
    NUACTIV_GENERA open.ge_items.items_id%type;
    DFFECHALEGA    date;

    nuTotal    NUMBER := 0;
    sbProgram  VARCHAR2(2000); -- := 'PERSCA';
    Const_CERO NUMBER := 0;
    --parametros

    nuNumPeriodo          number;
    nuActivi_suspe_pers   open.ge_items.items_id%type;
    nuActivi_corte_pers   open.ge_items.items_id%type;
    nuSaldo_param         NUMBER(15, 2) := open.Dald_parameter.fnuGetNumeric_Value('SALDO_TOTAL_PERS',null);
    add_cons_tope         number(9);
    nuActivi_corte        open.ge_items.items_id%type;
    sw                    number;
    periodos_consecutivos VARCHAR2(1);
    ONUPREVPECSCONS       conssesu.cosspecs%type;
    -- contrato a procesar
    nuNumesusc open.servsusc.sesususc%type;
    -- Producto a procesar
    nuNumeServ open.servsusc.sesunuse%type;
    -- Estado de Corte del Producto
    nuServEsco open.servsusc.sesuesco%type;
    -- Ciclo del producto
    nuciclo open.servsusc.sesucicl%type;
    -- order_activity_id de la orden de suspension
    nuORD_ACT_ID open.pr_product.SUSPEN_ORD_ACT_ID%type;

    nuLEEMLETO open.lectelme.LEEMLETO%type;
    nuLEEMPEFA open.lectelme.LEEMPEFA%type;
    dfLEEMFELE open.lectelme.LEEMFELE%type;
    nuLEEMSESU open.lectelme.LEEMSESU%type;
    nuLEEMDOCU open.lectelme.LEEMDOCU%type;
    nuLEEMPECS open.lectelme.LEEMPECS%type;

    type styServsusc IS record(
    sesususc          open.servsusc.sesususc%type,
    sesunuse          open.servsusc.sesunuse%type,
    sesuesco          open.servsusc.sesuesco%type,
    sesucicl          open.servsusc.sesucicl%type,
    SUSPEN_ORD_ACT_ID open.pr_product.SUSPEN_ORD_ACT_ID%type,
    sesudepa          number(6),
    sesuloca          number(6)
    );

    type tbtyServsuscTable IS table of styServsusc index BY binary_integer;

    tbServsusc tbtyServsuscTable;

    type stylectelme IS record(
    LEEMLETO open.lectelme.LEEMLETO%type,
    LEEMPEFA open.lectelme.LEEMPEFA%type,
    LEEMFELE open.lectelme.LEEMFELE%type,
    LEEMSESU open.lectelme.LEEMSESU%type,
    LEEMDOCU open.lectelme.LEEMDOCU%type,
    LEEMPECS open.lectelme.LEEMPECS%type
    );

    type tbtylectelmeTable IS table of stylectelme index BY binary_integer;

    tblectelme tbtylectelmeTable;


    sender          VARCHAR2(2000);
    sbRecipients    VARCHAR2(2000);
    sbSubject       VARCHAR2(2000);
    sbMessage0      VARCHAR2(4000);
    nuUltimaLectura number;

    --RNP1005
    --VARIABLES Y CURSOR
    --INICIO CURSOR

    --CURSOR PARA OBTENER LOS DATOS PRO PROCESO DE PERSECUCION
    CURSOR CULDC_PROCESO(NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE) IS
    SELECT LP.* FROM open.LDC_PROCESO LP WHERE LP.PROCESO_ID = NULDC_PROCESO_ID;

    --CURSOR PARA LA PROXIMA ACTIVIDAD A GENERAR
    CURSOR CULDC_ACTIVIDAD_GENERADA(NULDC_PROCESO_ID open.LDC_PROCESO.PROCESO_ID%TYPE,
                                    NUACTIVITY_ID    open.LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE) IS
    SELECT LAG.*
    FROM open.LDC_ACTIVIDAD_GENERADA LAG
    WHERE LAG.PROCESO_ID = NULDC_PROCESO_ID
    AND LAG.ACTIVITY_ID_GENERADA = NUACTIVITY_ID;


    ---curosr para determinar si el producto ya esta registrado
    cursor culdc_susp_persecucion(nususp_persec_producto open.ldc_susp_persecucion.susp_persec_producto %TYPE) is
    select count(1)
    from open.ldc_susp_persecucion lsp
    where lsp.susp_persec_producto = nususp_persec_producto;

    nuculdc_susp_persecucion number := 0;

    --FIN CURSORES

    TEMPCULDC_PROCESO          CULDC_PROCESO%ROWTYPE;
    TEMPLDC_ACTIVIDAD_GENERADA CULDC_ACTIVIDAD_GENERADA%ROWTYPE;
    sbORDER_COMMENT            ge_boInstanceControl.stysbValue;
    --inuProceso               NUMBER;
    SBESTADOCORTE              VARCHAR2(4000);
    SBESTADOPRODUCTO           VARCHAR2(4000);
    SBTIPOSUSPENSION           VARCHAR2(4000);
    SBDESARROLLO               VARCHAR2(4000) := 'BSS_JLVM_RNP_1005';
    BLGDO                      BOOLEAN := open.LDC_CONFIGURACIONRQ.aplicaParaGDO(SBDESARROLLO);
    BLEFIGAS                   BOOLEAN := open.LDC_CONFIGURACIONRQ.aplicaParaEfigas(SBDESARROLLO);
    BLSURTIGAS                 BOOLEAN := open.LDC_CONFIGURACIONRQ.aplicaParaSurtigas(SBDESARROLLO);
    BLGDC                      BOOLEAN := open.LDC_CONFIGURACIONRQ.aplicaParaGDC(SBDESARROLLO);

    NUTIPO_TRAB_SUSP_CONS_CERO NUMBER := open.dald_parameter.fnuGetNumeric_Value('TIPO_TRAB_SUSP_CONS_CERO',
                                                                           null);
    nucantidad                 number := 0;

    nuError            NUMBER;
    sbError            VARCHAR2(2000);
    inuProductId       number;
    nuBillCycleId      open.ciclo.ciclcodi%type;
    nuCurrBillPeriodId open.perifact.pefacodi%type;
    nuPeriodoC         open.pericose.pecscons%type;
    rcPeriodoC         open.pericose%rowtype;
    --FIN VARIABLES RNP1005


    SBCOD_ACTI_SUSP_CART_PERSCA OPEN.LD_PARAMETER.VALUE_CHAIN%type := OPEN.DALD_PARAMETER.fsbGetValue_Chain('COD_ACTI_SUSP_CART_PERSCA',
                                                                                                      NULL);

    CantiRegCC number := 0;

    --Inicio cambio 3995
    --modificar la sentencia del cursor para buscar la ultima orden con tipo de trabajo
    --10122. el curosr solo obtendra la lista de suscriptores con estado 5 y
    --con mas de una cuenta con saldo pendiente. se suprimira las lecturas anterio y actual
    CURSOR CUCONSUMOCEROGDO(nuCiclo                     open.servsusc.sesucicl%type,
                      ESTADOCORTE                 VARCHAR2,
                      ESTADOPRODCUTO              VARCHAR2,
                      TIPOSSUSPENSION             VARCHAR2,
                      iNUTIPO_TRAB_SUSP_CONS_CERO NUMBER,
                      nuDepartamento              NUMBER,
                      nuLocalidad                 NUMBER) is            
             
    SELECT *
    FROM (
    select /*+ ALL_ROWS 
               use_nl(s p)              
               index (s PK_SERVSUSC)
               index (p PK_PR_PRODUCT)
               LEADING(p s)
               USE_MERGE(p s)  
           */
         S.SESUNUSE,
          open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(P.PRODUCT_ID ) depa,
          open.PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTLOCALITY(P.PRODUCT_ID ) loca,
         (SELECT max(ooa.hcecfech)
            FROM OPEN.hicaesco OOA
           WHERE OOA.HCECSERV = s.sesuserv
             and ooa.hcecnuse = s.sesunuse
             and ooa.hcececac IN
                 (select to_number(column_value)
                    from table(open.ldc_boutilities.splitstrings(DECODE(ESTADOCORTE,
                                                                        '-1',
                                                                        TO_CHAR(s.sesuesco),
                                                                        ESTADOCORTE),
                                                                 ',')))) fecha_ultima_suspencion_total
   from open.servsusc s, open.pr_product p
    where s.sesuesco IN
       (select to_number(column_value)
          from table(open.ldc_boutilities.splitstrings(DECODE(ESTADOCORTE,
                                                              '-1',
                                                              TO_CHAR(s.sesuesco),
                                                              ESTADOCORTE),
                                                       ',')))
    and p.PRODUCT_STATUS_ID IN
       (select to_number(column_value)
          from table(open.ldc_boutilities.splitstrings(DECODE(ESTADOPRODCUTO,
                                                              '-1',
                                                              TO_CHAR(p.PRODUCT_STATUS_ID),
                                                              ESTADOPRODCUTO),
                                                       ',')))
    and s.sesucicl = decode(nuCiclo, -1, s.sesucicl, nuCiclo)
    and sesuserv = nuSERV
    and 0 = (select /*+  
                         use_nl(lsp) 
                         index (lsp IDX_LDC_SUSP_PERSECUCION02)
                    */
                   count(1)
              from ldc_susp_persecucion lsp
             where lsp.susp_persec_producto = p.PRODUCT_ID));
   -- AND p.PRODUCT_ID > 0
   -- AND MOD ( p.PRODUCT_ID, inuHilo ) + 1 = inuTotalHilos);


    TYPE tbconsumocero IS TABLE OF CUCONSUMOCEROGDO%ROWTYPE index BY binary_integer;
    TEMPCUCONSUMOCEROGDO tbconsumocero;



    SBCOD_TIPO_SUSP_PROD_PERSCA open.ld_parameter.value_chain%type := nvl(open.dald_parameter.fsbGetValue_Chain('COD_TIPO_SUSP_PROD_PERSCA',
                                                                                                null),  0);



    cursor cuconsumoServicioGas(nuNuse open.lectelme.leemsesu%type,
                                dtfele open.lectelme.leemfele%type) is
    SELECT sum(leemlean) suma_lectura_anterior,
       sum(LEEMLETO) suma_lectura_actual,
       (sum(LEEMLETO) - sum(leemlean)) diferencia_total_consumo
    FROM open.lectelme
    WHERE LEEMSESU = nuNuse
    AND leemtcon = 1
    AND LEEMCLEC = 'F'
      --AND trunc(leemfele) >= trunc(add_months(dtfele, -13), 'MM') --trunc(dtfele)
    AND trunc(leemfele) >= trunc(dtfele, 'MM') --trunc(dtfele)
    and leemlean <> LEEMLETO;

    tempcuconsumoServicioGas cuconsumoServicioGas%rowtype;


    ---cursor basado en la sentecia del ing. Carlos Salcedo.
    --- sentencia que permite identificar la ultima orden de consumo cero 10122 de un
    --- susucriptor estado de corte 5. proveniente de un grupo de suscriptores
    --- generados de un cursor anterior
    cursor cuUltimaOrdenConsumoCero(nuNuse      open.lectelme.leemsesu%type,
                                    sbTT_PERSCA varchar2) is
    select a.TASK_TYPE_ID, b.PRODUCT_ID, a.ORDER_ID, a.execution_final_date
    from open.or_order a, open.or_order_activity b
    where a.ORDER_ID = b.ORDER_ID
    and a.TASK_TYPE_ID in
       (select to_number(column_value)
          from table(open.ldc_boutilities.splitstrings(sbTT_PERSCA, ','))) --(12526, 12528, 10169, 12521, 10122)
    and a.execution_final_date is not null
    and b.PRODUCT_ID = nuNuse
    group by a.TASK_TYPE_ID,
          b.PRODUCT_ID,
          a.ORDER_ID,
          a.execution_final_date
    order by a.execution_final_date desc;

    tempcuUltimaOrdenConsumoCero cuUltimaOrdenConsumoCero%rowtype;

    SBTIPO_TRAB_PERSCA_CONS_CERO open.ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('TIPO_TRAB_PERSCA_CONS_CERO',
                                                                                                       null);
    --fin cambio 3995

    --Inicio CASO 200-216
    NUPCAR_TOPE_FACT_SUSP open.ld_parameter.numeric_value%type := open.dald_parameter.fnuGetNumeric_Value('PCAR_TOPE_FACT_SUSP',null);
    --sb200216 varchar2(4000);
    --Fin CASO 200-216
   nuDepaProd NUMBER;
   nuLocaProd NUMBER;

   nuProcesoAuto NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_PROCAUTORECO',null);
   nuTitrSusp NUMBER;
   nuOrdenSusp  NUMBER;
   nuLectSusp  NUMBER;

	--200-2614
	csbEntrega2002611 varchar2(4000):='200-2614';
	sbAplica2002611 varchar2(1):='N';
	nuToleranciaDif	number:=NVL(DALD_PARAMETER.FNUGETNUMERIC_VALUE('TOLERANCIA_DIFE_AUTORECONE',3),0);
	sbRegistra	    varchar2(1);
	--200-2614

BEGIN

  inCiclo := to_number(nvl(sbCICLO,'-1'));
  inDepartamento := to_number(nvl(sbDepartamento,'-1')); --< CASO 200-1940
  inLocalidad := to_number(nvl(sbLocalidad,'-1')); --< CASO 200-1940

	If fblAplicaEntregaXCASO(csbEntrega2002611) Then
		sbAplica2002611:='S';
	Else
		sbAplica2002611:='N';
	end if;


  OPEN CULDC_PROCESO(inuProceso);
  FETCH CULDC_PROCESO INTO TEMPCULDC_PROCESO;
  CLOSE CULDC_PROCESO;

  -- Inicializa contador de productos procesados
  CantiReg := 0;
  nuTotal  := 0;
  
  sbProgram := isbProgram;

  -- Establece Ejecutable
  pkerrors.setapplication('PERSCA');

  -- Obtiene consecutivo de proceso para Estaprog  ESTAPROG.ESPRPROG%TYPE

  sbProgram := sbProgram || '-' ||inuHilo;

  --sbProgram := pkStatusExeProgramMgr.fsbGetProgramID(sbProgram);

  -- Inicializa registro en Estaprog
  -- Valida que exista un registro con el correspondiente key,
  -- si no existe lo crea en la tabla ESTAPROG
  pkStatusExeProgramMgr.ValidateRecordAT(sbProgram);

  -- Inicializa el estado del proceso en ESTAPROG
  pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                             'Inicio proceso Persecucion de suspendidos - PERSCA',
                                             nuTotal,
                                             Const_CERO);

  nuSERV := open.Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV', null);

  if nuSERV is null then
    sbMessage0 := 'No existe datos para el parametro "COD_TIPO_SERV", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

  nuNumPeriodo := open.Dald_parameter.fnuGetNumeric_Value('NUM_PERI_EVA_PERS',
                                                     null);

  if nuNumPeriodo is null then
    sbMessage0 := 'No existe datos para el parametro "NUM_PERI_EVA_PERS", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

   nuActivi_suspe_pers := open.Dald_parameter.fnuGetNumeric_Value('ID_ITEM_SUSP_PERS',
                                                            null);

  if nuActivi_suspe_pers is null then
    sbMessage0 := 'No existe datos para el parametro "ID_ITEM_SUSP_PERS", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

  nuActivi_corte_pers := open.Dald_parameter.fnuGetNumeric_Value('ID_ITEM_CORTE_PERS',
                                                            null);

  if nuActivi_corte_pers is null then
    sbMessage0 := 'No existe datos para el parametro "ID_ITEM_CORTE_PERS", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

  nuSaldo_param := open.Dald_parameter.fnuGetNumeric_Value('SALDO_TOTAL_PERS',
                                                      null);

  if nuSaldo_param is null then
    sbMessage0 := 'No existe datos para el parametro "SALDO_TOTAL_PERS", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

  add_cons_tope := open.Dald_parameter.fnuGetNumeric_Value('PCAR_VALOR_ADIC_CONS_PROM',
                                                      null);

  if add_cons_tope is null then
    sbMessage0 := 'No existe datos para el parametro "PCAR_VALOR_ADIC_CONS_PROM", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

  --Inicio CASO 200-216
  if NUPCAR_TOPE_FACT_SUSP is null then
    sbMessage0 := 'No existe datos para el parametro "NUPCAR_TOPE_FACT_SUSP", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;
  --Fin CASO 200-216

  nuActivi_corte := open.Dald_parameter.fnuGetNumeric_Value('ID_ITEM_CORTE_MORA',
                                                       null);

  if nuActivi_corte is null then
    sbMessage0 := 'No existe datos para el parametro "ID_ITEM_CORTE_MORA", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

  periodos_consecutivos := open.DALD_PARAMETER.fsbGetValue_Chain('FLAG_PERIODO_CONSE_PERS',
                                                            null);

  if periodos_consecutivos is null then
    sbMessage0 := 'No existe datos para el parametro "FLAG_PERIODO_CONSE_PERS", Favor crearlo por el comando LDPAR' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10) || ' ' ||
                  chr(10);
    raise ex.CONTROLLED_ERROR;
  end if;

  IF TEMPCULDC_PROCESO.ESTADOCORTE IS NOT NULL THEN
    SBESTADOCORTE := TEMPCULDC_PROCESO.ESTADOCORTE;
  ELSE
    SBESTADOCORTE := '-1';
  END IF;

  IF TEMPCULDC_PROCESO.ESTADOPRODUCTO IS NOT NULL THEN
    SBESTADOPRODUCTO := TEMPCULDC_PROCESO.ESTADOPRODUCTO;
  ELSE
    SBESTADOPRODUCTO := '-1';
  END IF;

  IF (TEMPCULDC_PROCESO.SUSPENSION_TYPES IS NOT NULL) THEN
    SBTIPOSUSPENSION := TEMPCULDC_PROCESO.SUSPENSION_TYPES;
  ELSE
    SBTIPOSUSPENSION := '-1';
  END IF;


  -- Se hace el llamado a los servicio nuevos
  --se valida si el proceso es autoreconetado
  IF nuProcesoAuto <> inuProceso THEN
  
    GeneraPerscaNoAuto
    (
        inuProceso,
        inCiclo,
        inDepartamento,
        inLocalidad,
        inuHilo,
        inuTotalHilos,
        nuSERV,
        sbProgram,
        SBESTADOCORTE,
        SBESTADOPRODUCTO,
        SBTIPOSUSPENSION,
        onuOk,
        osbMensaje
    );
  ELSE
    GeneraPerscaAuto
    (
        inuProceso,
        inCiclo,
        inDepartamento,
        inLocalidad,
        inuHilo,
        inuTotalHilos,
        nuSERV,
        sbProgram,
        SBESTADOCORTE,
        SBESTADOPRODUCTO,
        SBTIPOSUSPENSION,
        onuOk,
        osbMensaje
    );
  
  END IF;


  --RNP10005 ANALISIS DE CONSUMO CERO

  IF BLGDC = TRUE OR BLSURTIGAS = TRUE OR BLEFIGAS = TRUE OR BLGDO = TRUE THEN

    OPEN  CUCONSUMOCEROGDO(inCiclo,
                           TEMPCULDC_PROCESO.ESTADOCORTECC,
                           '-1',
                           '-1',---SBCOD_TIPO_SUSP_PROD_PERSCA,
                           NUTIPO_TRAB_SUSP_CONS_CERO,
                           inDepartamento,
                            inLocalidad);
    LOOP
      FETCH CUCONSUMOCEROGDO BULK COLLECT INTO TEMPCUCONSUMOCEROGDO LIMIT 100;

        FOR i in 1..TEMPCUCONSUMOCEROGDO.COUNT loop
          open culdc_susp_persecucion(TEMPCUCONSUMOCEROGDO(I).SESUNUSE);
          fetch culdc_susp_persecucion
            into nuculdc_susp_persecucion;
          close culdc_susp_persecucion;

          if nuculdc_susp_persecucion = 0 then
            ---codido nuevo para establecer suscriprotes con ultima lectura de cosumo cero
            open cuUltimaOrdenConsumoCero(TEMPCUCONSUMOCEROGDO(I).sesunuse,
                                          SBTIPO_TRAB_PERSCA_CONS_CERO); --'12526, 12528, 10169, 12521, 10122');
            fetch cuUltimaOrdenConsumoCero
              into tempcuUltimaOrdenConsumoCero;
            if cuUltimaOrdenConsumoCero%found then
              if tempcuUltimaOrdenConsumoCero.Task_Type_Id =
                 NUTIPO_TRAB_SUSP_CONS_CERO then
                --10122 then
                open cuconsumoServicioGas(TEMPCUCONSUMOCEROGDO(I).sesunuse,
                                          TEMPCUCONSUMOCEROGDO(I).FECHA_ULTIMA_SUSPENCION_TOTAL);

                fetch cuconsumoServicioGas
                  into tempcuconsumoServicioGas;
                close cuconsumoServicioGas;

                if tempcuconsumoServicioGas.diferencia_total_consumo >
                   add_cons_tope then
                  dbms_output.put_line('*************************************');
                  dbms_output.put_line('Servicio Suscrito[' ||
                                       TEMPCUCONSUMOCEROGDO(I).sesunuse ||
                                       '] - Fecha Estado de corte 5 [' ||
                                       TEMPCUCONSUMOCEROGDO(I).FECHA_ULTIMA_SUSPENCION_TOTAL ||
                                       '] - Consumo Suscriptor[' ||
                                       tempcuconsumoServicioGas.diferencia_total_consumo ||
                                       ' - Cosunmo Tope [' || add_cons_tope || ']');
                  dbms_output.put_line('*************************************');
                  NUACTIV_GENERA := dald_parameter.fnuGetNumeric_Value('COD_ACTI_SUSP_CENT_MEDI_MORA',
                                                                       null);

                  insert into LDC_SUSP_PERSECUCION
                    (SUSP_PERSEC_CODI,
                     SUSP_PERSEC_PRODUCTO,
                     SUSP_PERSEC_SALPEND,
                     SUSP_PERSEC_CONSUMO,
                     SUSP_PERSEC_ACTIVID,
                     SUSP_PERSEC_ACT_ORIG,
                     SUSP_PERSEC_PERVARI,
                     SUSP_PERSEC_PERSEC,
                     SUSP_PERSEC_FEGEOT,
                     SUSP_PERSEC_USER_ID,
                     SUSP_PERSEC_FEJPROC,
                     SUSP_PERSEC_ORDER_ID,
                     SUSP_PERSEC_CICLCODI,
                     SUSP_PERSEC_DEPA,
                     SUSP_PERSEC_LOCA)
                  values
                    (SEQ_LDC_SUSP_PERSECUCION.nextval,
                     TEMPCUCONSUMOCEROGDO(I).sesunuse,
                     0,
                     0,
                     NUACTIV_GENERA,
                     --TEMPcuordenSUSPCONSCERO.Actividad,
                     NUACTIV_GENERA,
                     0,
                     'S',
                     null,
                     null,
                     trunc(sysdate),
                     null,
                     nuCiclo,
                     TEMPCUCONSUMOCEROGDO(I).DEPA,
                     TEMPCUCONSUMOCEROGDO(I).LOCA
                     );
                  --CantiReg := CantiReg + 1;

                  ---REGISTRAR LOS PRODUCTOS DEL PROCESO CON CONSUMO CERO
                  INSERT INTO LDC_CONSUMO_CERO
                    (PROCESO_ID, PRODUCT_ID, CICLCODI)
                  VALUES
                    (inuProceso, TEMPCUCONSUMOCEROGDO(I).sesunuse, nuCiclo);
                  ---FIN REGISTRAR PRODCUTO

                  CantiRegCC := CantiRegCC + 1;
                  IF MOD(CantiRegCC, 1000) = 0 THEN
                    commit;
                  END IF;
                end if;
              end if;
            end if;
            close cuUltimaOrdenConsumoCero;
          END IF; --FIN DE VALIDACION SI EXISTE EN LA NORMAL DE PERSCA
        END LOOP;
        ---Fin Cambio 3995
        EXIT WHEN CUCONSUMOCEROGDO%NOTFOUND;
    END LOOP;
    CLOSE CUCONSUMOCEROGDO;
    COMMIT;
   END IF;

  ---FIN RNP10005 ANALISIS DE CONSUMO CERO

  -- Actualiza el estado del proceso en ESTAPROG
  /*pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                             'Proceso Termin? Exitosamente',
                                             100,
                                             100);*/
                                             
    pkStatusExeProgramMgr.ProcessFinishOK(sbProgram);



EXCEPTION
  when ex.CONTROLLED_ERROR then

    -- Actualiza el estado del proceso en ESTAPROG
    pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                               'Proceso Finalizado con Errores: ' ||
                                               sbMessage0,
                                               nuTotal,
                                               nuTotal);

    sbSubject := 'ERROR PERSCA - PROCESO DE PERSECUCION DE USUARIOS SUSPENDIDOS QUE TIENEN VARIACION DE LECTURA   ' ||
                 SYSDATE;
    ldc_email.mail(sender, sbRecipients, sbSubject, sbMessage0);

    rollback;
    RAISE EX.CONTROLLED_ERROR;
  when OTHERS then
    -- Actualiza el estado del proceso en ESTAPROG
    pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                               'Proceso Finalizado con Errores: ' ||
                                               sbMessage0,
                                               nuTotal,
                                               nuTotal);
    sbSubject  := 'ERROR PERSCA - PROCESO DE PERSECUCION DE USUARIOS SUSPENDIDOS QUE TIENEN VARIACION DE LECTURA   ' ||
                  SYSDATE;
    sbMessage0 := 'Durante la ejecucion del proceso se presento un error no controlado ' ||
                  chr(10) || '[' || SQLCODE || ' - ' || SQLERRM || chr(10) ||
                  ']. Por favor contacte al Administrador.' || chr(10) || ' ' ||
                  chr(10) || ' ' || chr(10) || ' ' || chr(10);

    --ldc_seguimiento_codigo_bz(sbMessage0);

    --Enviar correo
    ldc_email.mail(sender, sbRecipients, sbSubject, sbMessage0);

    rollback;
    RAISE EX.CONTROLLED_ERROR;
 END progeneraPersca;
 
    /**************************************************************************
        Autor       : Olsoftware
        Fecha       : 12-07-2020
        Ticket      : CA47
        Descripcion : Valida si el proceso ya terminó

        Parametros Entrada
         isbIdPrograma          Identificador del programa
         inuCantHilos           Cantidad de hilos

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR                       DESCRIPCION
        05/07/2020  OLsoftware.CA47              Creacion
   ***************************************************************************/
    PROCEDURE VerificaFinProceso
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        inuCantHilos    IN   NUMBER,
        onuCantRegist   OUT  NUMBER,
        onuCantPerse    OUT  NUMBER
    )
    IS
        CURSOR cuTotales
        IS
            SELECT  SUM(esprsupr) cantRegist,
                    SUM(esprsufa) cantPers
            FROM  estaprog
            WHERE esprprog LIKE isbIdPrograma || '-%'
              AND esprporc >= 100;

        --  Variable para almacenar indicador de finalizaci¿n de proceso
        blProcesoTermino      BOOLEAN;
        
        FUNCTION fblProcesoTermino
        (
            isbIdPrograma   IN   estaprog.esprprog%TYPE,
            inuCantHilos    IN   NUMBER
        )
        RETURN BOOLEAN
        IS
            --  Variable que almacena el numero de procesos pendientes de procesar
            nuProcesosTerm NUMBER;
        BEGIN
            UT_Trace.Trace('Begin LDC_PKGENEORDEAUTORECO.VerificaFinProceso.fblProcesoTermino',10);

            SELECT COUNT(1)
              INTO nuProcesosTerm
              FROM estaprog
             WHERE esprprog LIKE isbIdPrograma || '-%'
               AND esprporc >= 100;

            UT_Trace.Trace('End LDC_PKGENEORDEAUTORECO.VerificaFinProceso.fblProcesoTermino',10);
            IF(nuProcesosTerm < inuCantHilos)THEN
              RETURN(FALSE);
            END IF;
            RETURN(TRUE);

        EXCEPTION
        WHEN ex.Controlled_Error THEN
          UT_Trace.Trace('ex.Controlled_Error LDC_PKGENEORDEAUTORECO.VerificaFinProceso.fblProcesoTermino',10);
          RAISE ex.Controlled_Error;
        WHEN OTHERS THEN
          Errors.SetError;
          UT_Trace.Trace('OTHERS LDC_PKGENEORDEAUTORECO.VerificaFinProceso.fblProcesoTermino',10);
          RAISE ex.Controlled_Error;
        END fblProcesoTermino;
        
        
    BEGIN
        UT_Trace.Trace('Begin LDC_PKGENEORDEAUTORECO.VerificaFinProceso',10);
        --  Define que el proceso no termin¿
        blProcesoTermino      := FALSE;
        LOOP

          --  Verifica en la tabla ESTAPROG si el proceso ya termino
          blProcesoTermino   := fblProcesoTermino(isbIdPrograma,inuCantHilos);

          EXIT WHEN blProcesoTermino;

          --  Define un tiempo de espera de 60 segundos para volver a validar
          DBMS_LOCK.SLEEP(60);
        END LOOP;
        
        -- Se calculan los totales procesados
        OPEN cuTotales;
        FETCH cuTotales INTO onuCantRegist, onuCantPerse;
        CLOSE cuTotales;

        UT_Trace.Trace('End LDC_PKGENEORDEAUTORECO.VerificaFinProceso',10);
    EXCEPTION
        WHEN ex.Controlled_Error THEN
          UT_Trace.Trace('ex.Controlled_Error LDC_PKGENEORDEAUTORECO.VerificaFinProceso',10);
          RAISE ex.Controlled_Error;
        WHEN OTHERS THEN
          Errors.SetError;
          UT_Trace.Trace('OTHERS LDC_PKGENEORDEAUTORECO.VerificaFinProceso',10);
          RAISE ex.Controlled_Error;
    END VerificaFinProceso;

 PROCEDURE PROGENEACTAUTORECO (inuConsecutivo IN  LDC_SUSP_AUTORECO.SARECODI%TYPE) IS

  /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar orden de autoreconectado

        Parametros Entrada
         inuProceso    codigo del proceso
         sbCICLO     codigo del ciclo
         sbDepartamento   departamento
         sbLocalidad     localidad
        Valor de salida
        onuOk        0- Exito, -1 Error
        osbMensaje     mensaje de error

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
    sbParametros            GE_PROCESS_SCHEDULE.PARAMETERS_%type;
    sbCICLO                 ge_boInstanceControl.stysbValue;
    NUORDER_ID              or_order.order_id%type;
    NUACTIVITY              ge_items.items_id%type;
    NUACTIV_GENERA          ge_items.items_id%type;

    onuerrorcode               NUMBER;
    osberrormessage            VARCHAR2 (2000);
    --parametros

   ionuorderid              OR_ORDER.ORDER_ID%TYPE;
   nuProduct_id             LDC_SUSP_PERSECUCION.SUSP_PERSEC_PRODUCTO%type;
   nuaddressid              pr_product.address_id%type;
   nuSUSPEN_ORD_ACT_ID      pr_product.SUSPEN_ORD_ACT_ID%type;

   nuSUBSCRIBER_ID          OR_ORDER_ACTIVITY.SUBSCRIBER_ID%type;
   nuSUBSCRIPTION_ID        OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%type;
   nuOrdenGen               number := 0;
   nuOrdenesAct             number := 0;
   nuProEjecucion           number := 0;
   sbSQL                    varchar2(2000);
   sbSQLAct                 varchar2(2000);
   sbSQLEje                 varchar2(2000);
   --se consultan datos del producto
   CURSOR cuGeneraOrden IS
   SELECT SAREACTI, SARESESU, SAREORSU, SAREDIRE, SARECLIE, SARECONT, SAREMARC, SAREACOR
   FROM LDC_SUSP_AUTORECO
   WHERE inuConsecutivo = SARECODI ;

   nuMarcaReport NUMBER;
   nuActividad  NUMBER;

   --Se consulta marca de suspension
  CURSOR cuMarcaProd IS
  SELECT suspension_type_id
  FROM pr_prod_suspension
  WHERE active = 'Y'
    AND product_id = nuProduct_id;

  nuMarcaProd NUMBER;



BEGIN

   --se carga informacion base
   OPEN cuGeneraOrden;
   FETCH cuGeneraOrden INTO NUACTIV_GENERA, nuProduct_id, nuOrder_id, nuaddressid, nuSUBSCRIBER_ID,  nuSUBSCRIPTION_ID, nuMarcaReport, nuActividad;
   CLOSE cuGeneraOrden;

  --se consulta marca actual del producto
  OPEN cuMarcaProd;
  FETCH cuMarcaProd INTO nuMarcaProd;
  CLOSE cuMarcaProd;

  --se valida si el producto cambio la marca
  IF nuMarcaProd IS NOT NULL AND nuMarcaProd <> nuMarcaReport THEN
    NUACTIV_GENERA :=  fnuGetActividadgenerarAuto( dald_parameter.fnuGetNumeric_Value('LDC_PROCAUTORECO',null),
                                  nuActividad,
                                  nuMarcaProd);
  END IF;

  ionuorderid := NULL;

    BEGIN

    nuProEjecucion := 0;
    sbSQLEje := 'select count(1) from GE_CONTROL_PROCESS PRO, ge_record_process RC
                where PRO.object_id=121471
                and PRO.record_initial_date > to_date(trunc(sysdate), ''DD/MM/YYYY hh24:mi:ss'')
                and PRO.advance < 100
                and PRO.control_process_id = RC.control_process_id
                and RC.arguments like ''CONSECUTIVO=>'||to_char(inuConsecutivo)||'''';

    EXECUTE IMMEDIATE sbSQLEje INTO nuProEjecucion;

    EXCEPTION
        when no_data_found then
            nuProEjecucion := 0;
    END;

    -- Si no existe el mismo registro procesandose anteriormente
    IF (nuProEjecucion < 2) THEN
        ------------------------------------------------------------------------
        -- Se consulta si el registro que se esta procesando ya contienen una orden generada
        BEGIN

        nuOrdenGen := 0;
        sbSQL:=     'select SAREORDE
                        from LDC_SUSP_AUTORECO
                        where SARECODI= '||inuConsecutivo||
                        ' and SAREORDE is not null and rownum=1';

            EXECUTE IMMEDIATE sbSQL INTO nuOrdenGen;


            EXCEPTION
                when no_data_found then
                    nuOrdenGen := 0;
            END;

            ------------------------------------------------------------------------
            -- Se consulta si existen otras ordenes en estado Asignada o Registrada
            BEGIN

                nuOrdenesAct := 0;

                sbSQLAct := 'select count(1)
                            from LDC_SUSP_AUTORECO
                            where SARECODI ='|| inuConsecutivo||
                            ' and SAREORDE is null
                            and exists   (select ''X''
                                          from or_order_activity, or_order , LDC_ACTIVIDAD_GENERADA
                                          where or_order_activity.product_id = SARESESU
                                            and or_order_activity.order_id = or_order.order_id
                                            and order_status_id in (0,5)
                                            and or_order_activity.activity_id = ldc_actividad_generada.proxima_activity_id
                                            and LDC_ACTIVIDAD_GENERADA.activity_id_generada = SAREACOR)';

               EXECUTE IMMEDIATE sbSQLAct INTO nuOrdenesAct;

            EXCEPTION
                when no_data_found then
                    nuOrdenesAct := 0;
            END;

            ------------------------------------------------------------------------

            -- Si no se ha generado una orden previamente en la tabla LDC_SUSP_PERSECUCION
            -- y si no existe una orden de persecucion en estado registrada o asignada
            IF (nuOrdenGen = 0 ) and (nuOrdenesAct=0) and  fnugetValidaAuto(nuProduct_id) = 0 THEN

              os_createorderactivities (NUACTIV_GENERA, nuaddressid, sysdate+1, null,0, ionuorderid,onuerrorcode, osberrormessage);
                IF (onuerrorcode <> 0) THEN
                    gw_boerrors.checkerror (onuerrorcode, osberrormessage);
                    raise ex.CONTROLLED_ERROR;
                END IF;


                update or_order_activity
                set PRODUCT_ID       = nuPRODUCT_ID,
                  SUBSCRIBER_ID    = nuSUBSCRIBER_ID,
                    SUBSCRIPTION_ID  = nuSUBSCRIPTION_ID
                where ORDER_ID=ionuorderid;

                UPDATE LDC_SUSP_AUTORECO set SAREFEGE = sysdate,
                                             SAREUSER = sa_bouser.fnuGetUserId(ut_session.getUSER),
                                             SAREORDE = ionuorderid
                WHERE sarecodi = inuConsecutivo;
                commit;

            -- Inicia NC 3468
            -- Si ya existe una orden en la tabla LDC_SUSP_PERSECUCION
            ELSIF (nuOrdenGen>0) THEN

                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'Error generando Orden al consecutivo ['||inuConsecutivo|| ']'||
                                   ' dado que ya tiene la orden ['||nuOrdenGen||'] generada ';
                ge_boerrors.SetErrorCodeArgument(onuErrorCode,osbErrorMessage);
                raise ex.CONTROLLED_ERROR;

            -- Si ya existe una orden registrada o asignada previamente
            ELSIF (nuOrdenesAct>0) THEN

                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'Error generando Orden al consecutivo ['||inuConsecutivo|| ']'||
                                   ' dado que el producto ya tiene una orden en estado asignada o registrada';
               -- osbErrorMessage := sbSQLEje;
                ge_boerrors.SetErrorCodeArgument(onuErrorCode,osbErrorMessage);
                raise ex.CONTROLLED_ERROR;

            END IF;

        ELSE
            onuErrorCode    := ld_boconstans.cnuGeneric_Error;
            osbErrorMessage := 'Error generando Orden al consecutivo ['||inuConsecutivo|| ']'||
                                   ' por que existe '||nuProEjecucion||' registro en ejecucion ';
            ge_boerrors.SetErrorCodeArgument(onuErrorCode,osbErrorMessage);
            raise ex.CONTROLLED_ERROR;
        END IF;

        -- Fin NC 3468


EXCEPTION
    when ex.CONTROLLED_ERROR then
        ge_boerrors.SetErrorCodeArgument(onuErrorCode,osbErrorMessage);
    rollback;
        raise ex.CONTROLLED_ERROR;
    when OTHERS then
    gw_boerrors.checkerror(SQLCODE,SQLERRM);
        rollback;
    raise ex.CONTROLLED_ERROR;
END;

  PROCEDURE LDC_PROGENTRAMVSI IS
     /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar venta de servicio de ingenieria

        Parametros Entrada
         inuConsecutivo consecutivo de perseuacion
        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA         AUTOR                 DESCRIPCION
        31/05/2019    Miguel Ballesteros    CA 200-2680 Se cambia la forma de como obtener el punto de atencion actual
                                            por medio de un procedimiento que retorna dicho valor y comentando el cursor
                                            que realizaba esta función.
   ***************************************************************************/
    onuErrorCode          NUMBER;
    nuorden             number := null;

    sbRequestXML VARCHAR2(4000);
    nuPackageId  NUMBER;
    nuMotiveId   NUMBER;

    nuparano     NUMBER(4);
    nuparmes     NUMBER(2);
    nutsess      NUMBER;
    sbparuser    VARCHAR2(30);
    sbmensa      VARCHAR2(10000);
    sbTitrSuspCm   VARCHAR2(4000) :=dald_parameter.fsbgetvalue_chain('LDC_TITRSUSPCMRP', NULL);
    sbTitrSuspAcom   VARCHAR2(4000) :=dald_parameter.fsbgetvalue_chain('LDC_TITRSUSPACORP', NULL);

    nuActiSuspCm   NUMBER := dald_parameter.fnugetnumeric_value('LDC_ACTISUSCMRP', NULL);
    nuActiSuspAco  NUMBER := dald_parameter.fnugetnumeric_value('LDC_ACTISUSACONCERT', NULL);

    nuCausSuspCm  NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSLEGASUCMRP', NULL);
    nuCausSuspAco  NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSLEGASUACORP', NULL);

    sbItemSuspCm   VARCHAR2(4000) :=dald_parameter.fsbgetvalue_chain('LDC_ITEMADICISUCMRP', NULL);
    sbItemSuspAcom   VARCHAR2(4000) :=dald_parameter.fsbgetvalue_chain('LDC_ITEMADICISUACORP', NULL);

    nuMedioRecepcion  NUMBER := dald_parameter.fnugetnumeric_value('LDC_MEDIORECEPVSI', NULL);
    nuPersonIdsol NUMBER := ge_bopersonal.fnugetpersonid;

    inuContactIdsol  NUMBER;
    inuIdAddress   NUMBER;
    sbObserva      VARCHAR2(4000);
    nuProductId   NUMBER;
    nuPtoAtncndsol number;

    nuActividad  number;
    nupakageid  NUMBER;
    
    --//---------------- CA 200-2680 ---------------------//-- 
    /* se agrega variable que se encarga de guarda el valor que devuelve 
    el procedimiento para obtener el punto de atencion actual del usuario*/
    ONUCHANNEL   CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE; 

  /*  --se consultan datos del punto de atencion
   CURSOR cuPuntoAtencion IS
   SELECT a.ORGANIZAT_AREA_ID
   FROM CC_ORGA_AREA_SELLER s, GE_ORGANIZAT_AREA a
   WHERE s.organizat_area_id=a.organizat_area_id
      AND s.PERSON_ID = nuPersonIdsol ;*/
  --//---------------- CA 200-2680 ---------------------//-- 
  
  --se consulta datos del producto
  CURSOR cuDatosProdu IS
  SELECT oa.product_id, OA.ADDRESS_ID,OA.SUBSCRIBER_ID, PACKAGE_ID
  FROM or_order_activity oa
  WHERE oa.order_id=nuorden;

  --se valida ultima actividad de suspension
  CURSOR cuUltiActSusp IS
  SELECT o.task_type_id
  from PR_PRODUCT pr, or_order_activity oa, or_order o
  where pr.product_id = nuProductId
     and o.order_id = oa.order_id
     and oa.ORDER_ACTIVITY_ID = pr.suspen_ord_act_id;

    nuTitrSusp number;

  -- Actividad a generar
   CURSOR cuActividadGene IS
   SELECT nuActiSuspCm, nuCausSuspCm, sbItemSuspCm
   FROM dual
   where nuTitrSusp in (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(ldc_boutilities.splitstrings(sbTitrSuspCm,',')))
   UNION ALL
   SELECT nuActiSuspAco, nuCausSuspAco, sbItemSuspAcom
   FROM dual
   where nuTitrSusp in (SELECT to_number(COLUMN_VALUE)
                        FROM TABLE(ldc_boutilities.splitstrings(sbTitrSuspAcom,',')))
   ;
    nuCausalLeg  NUMBER;
    sbItemAdic VARCHAR2(4000);

    nuUnidad NUMBER;

 BEGIN
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
    FROM dual;

    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PROGENTRAMVSI','En ejecucion',nutsess,sbparuser);
    --Obtener el identificador de la orden  que se encuentra en la instancia   
    nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;
    --se cargan datos de la orden
    OPEN cuDatosProdu;
    FETCH cuDatosProdu INTO nuProductId, inuIdAddress, inuContactIdsol, nupakageid;
    CLOSE cuDatosProdu;
    
    --//---------------- CA 200-2680 ---------------------//-- 
    --se consulta punto de atencion
   /* OPEN cuPuntoAtencion;
    FETCH cuPuntoAtencion INTO nuPtoAtncndsol;
    CLOSE cuPuntoAtencion;*/
    
     --se consulta punto de atencion con el nuevo procedimiento
    GE_BOPERSONAL.GETCURRENTCHANNEL(nuPersonIdsol,ONUCHANNEL);   
    nuPtoAtncndsol := ONUCHANNEL;   
    --//---------------- CA 200-2680 ---------------------//-- 
 
    --se consulta ultima actividad de suspension
    OPEN cuUltiActSusp;
    FETCH cuUltiActSusp INTO nuTitrSusp;
    CLOSE cuUltiActSusp;
    

    
    --se consuta actividad a generar
    OPEN cuActividadGene;
    FETCH cuActividadGene INTO nuActividad, nuCausalLeg, sbItemAdic;
    CLOSE cuActividadGene;
    


    IF nuActividad IS NOT NULL THEN
    sbObserva := 'Solicitud Generada por proceso de autoreconectado, orden #'||nuorden;

    sbRequestXML := '<P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 ID_TIPOPAQUETE="100101">
                      <CUSTOMER/>
                      <CONTRACT/>
                <PRODUCT>' || nuProductId ||
                    '</PRODUCT>
                <FECHA_DE_SOLICITUD>' || SYSDATE ||
                    '</FECHA_DE_SOLICITUD>
                <ID>' || nuPersonIdsol ||
                    '</ID>
                <POS_OPER_UNIT_ID>' || nuPtoAtncndsol ||
                    '</POS_OPER_UNIT_ID>
                <RECEPTION_TYPE_ID>' || nuMedioRecepcion ||
                    '</RECEPTION_TYPE_ID>
                <CONTACT_ID>' || inuContactIdsol ||
                    '</CONTACT_ID>
                <ADDRESS_ID>' || inuIdAddress ||
                    '</ADDRESS_ID>
                <COMMENT_>' ||  sbObserva||'</COMMENT_>
                <CONTRATO></CONTRATO>
              <M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                <ITEM_ID>'|| nuActividad ||'</ITEM_ID>
                <DIRECCION_DE_EJECUCION_DE_TRABAJOS>' ||
                    inuIdAddress ||
                    '</DIRECCION_DE_EJECUCION_DE_TRABAJOS>
                <C_GENERICO_22>
                <C_GENERICO_10319/>
                </C_GENERICO_22>
                </M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                </P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101>';

  /*Ejecuta el XML creado*/
    OS_RegisterRequestWithXML(sbRequestXML,
                              nuPackageId,
                              nuMotiveId,
                              onuErrorCode,
                              sbmensa);
    

    
    IF nupackageid IS NULL THEN
        RAISE  ex.controlled_error;
    ELSE
      insert into LDC_BLOQ_LEGA_SOLICITUD(PACKAGE_ID_ORIG, PACKAGE_ID_GENE) values(nupakageid,  nuPackageId);

      nuUnidad := daor_order.fnugetoperating_unit_id(nuorden,NULL);

      INSERT INTO LDC_ORDEASIGPROC
            (
              ORAPORPA, ORAPSOGE,ORAOPELE,ORAOUNID,ORAOCALE,  ORAOITEM, ORAOPROC
            )
            VALUES
            ( nuorden, nuPackageId, DAOR_ORDER_PERSON.FNUGETPERSON_ID(nuUnidad,nuorden),daor_order.fnugetoperating_unit_id(nuorden,NULL),  nuCausalLeg, sbItemAdic, 'AUTORECO');

   END IF;

  ELSE
   errors.SETERROR(2741, 'No existe actividad configurada para el tipo de trabajo '||nuTitrSusp||' valiadar parametros LDC_TITRSUSPACORP y LDC_TITRSUSPACORP');
   RAISE  ex.controlled_error;
  END IF;


    ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROGENTRAMVSI','Ok');
 EXCEPTION
   WHEN ex.controlled_error THEN
      errors.GETERROR( onuErrorCode,sbmensa);
     
       ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROGENTRAMVSI','Error');
      RAISE;
   WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. '||SQLERRM;

      ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLISUSPADMI','Error');
      errors.seterror;
      RAISE ex.controlled_error;
 END LDC_PROGENTRAMVSI;

 PROCEDURE LDC_VALILECTAUTO IS
     /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de validar lecturas

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
    nuOrden   number;
    sbNombreAtrib VARCHAR2(100)  := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_NOMBPARLECT',NULL);

    sbLecturas VARCHAR2(4000);

    CURSOR cuDatosLect IS
    SELECT value1||'>'|| nvl(value2,'')||'>'||nvl(value3,'')||'>'||nvl(value4,'')
    FROM or_order_activity
    WHERE order_id =nuOrden;

     CURSOR cudatosvalid IS
    SELECT COLUMN_VALUE valor, ROWNUM numero
    FROM TABLE(ldc_boutilities.splitstrings(sbLecturas,'>'))
    WHERE COLUMN_VALUE IS NOT NULL;

    nuparano     NUMBER(4);
    nuparmes     NUMBER(2);
    nutsess      NUMBER;
    sbparuser    VARCHAR2(30);
    sbmensa      VARCHAR2(10000);
    nuClasiCausal NUMBER;
    onuErrorCode  number;
    nuLinea    number:= 0;
   BEGIN
      -- Consultamos datos para inicializar el proceso
      SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
      FROM dual;
      -- Inicializamos el proceso
      ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_VALILECTAUTO','En ejecucion',nutsess,sbparuser);
      --Obtener el identificador de la orden  que se encuentra en la instancia
      nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;

      nuClasiCausal := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(DAOR_ORDER.FNUGETCAUSAL_ID(nuorden,NULL),NULL);

      IF nuClasiCausal = 1 THEN
        OPEN cuDatosLect;
        FETCH cuDatosLect INTO sbLecturas;
        CLOSE cuDatosLect;

        IF sbLecturas IS NOT NULL THEN
          FOR reg IN  cudatosvalid LOOP
              IF reg.valor = sbNombreAtrib THEN
                  nuLinea := reg.numero +1;
              END IF;

              IF nuLinea = reg.numero  THEN
                 IF TO_NUMBER(reg.valor) <= 0 THEN
                    errors.SETERROR(2741, 'Error en proceso LDC_PKGENEORDEAUTORECO.LDC_VALILECTAUTO La lectura legalizada no puede ser menor o igual a 0');
                    RAISE  ex.controlled_error;
                 ELSE
                   EXIT;
                 END IF;
              END IF;
          END LOOP;
        END IF;
      END IF;
     ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_VALILECTAUTO','Ok');
 EXCEPTION
   WHEN ex.controlled_error THEN
      errors.GETERROR( onuErrorCode,sbmensa);
       ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_VALILECTAUTO','Error');
      RAISE;
   WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. '||SQLERRM;
      ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_VALILECTAUTO','Error');
      errors.seterror;
      RAISE ex.controlled_error;

   END LDC_VALILECTAUTO;
 PROCEDURE LDC_PROVALIESTAPRSU IS
  /**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de validar si un producto esta suspendido por RP

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/


    nuparano     NUMBER(4);
    nuparmes     NUMBER(2);
    nutsess      NUMBER;
    sbparuser    VARCHAR2(30);
    sbmensa      VARCHAR2(10000);
    nuClasiCausal NUMBER;
    nuorden NUMBER;
    onuErrorCode  NUMBER;

    sbTipoSuspRp VARCHAR2(200) := dald_parameter.fsbgetvalue_chain('LDC_TIPOSUSPRP',NULL);

     --se consulta datos del producto
    CURSOR cuDatosProdu IS
    SELECT  oa.product_id
    FROM or_order_activity oa, pr_product p
    WHERE oa.order_id=nuorden
      and p.product_id = oa.product_id
      and p.product_status_id = 2;


    nuProduct_id NUMBER;

    --se consulta marca del producto
    CURSOR cuMarcaProd IS
    SELECT 'X'
    FROM pr_prod_suspension
    WHERE active = 'Y'
      AND product_id = nuProduct_id
      AND suspension_type_id IN (select to_number(column_value)
                                   from table(open.ldc_boutilities.splitstrings(sbTipoSuspRp, ',')));

    sbdatos VARCHAR2(1);

 BEGIN
   -- Consultamos datos para inicializar el proceso
      SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
      FROM dual;
      -- Inicializamos el proceso
      ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PROVALIESTAPRSU','En ejecucion',nutsess,sbparuser);
      --Obtener el identificador de la orden  que se encuentra en la instancia
      nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;

     nuClasiCausal := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(DAOR_ORDER.FNUGETCAUSAL_ID(nuorden,NULL),NULL);

     IF nuClasiCausal = 1 THEN
       OPEN cuDatosProdu;
       FETCH cuDatosProdu INTO nuProduct_id ;
       IF cuDatosProdu%NOTFOUND THEN
           CLOSE cuDatosProdu;
           errors.SETERROR(2741, 'Error en proceso LDC_PKGENEORDEAUTORECO.LDC_PROVALIESTAPRSU, producto no se encuentra suspendido');
           RAISE  ex.controlled_error;
       END IF;
       CLOSE cuDatosProdu;

       OPEN cuMarcaProd;
       FETCH cuMarcaProd INTO sbdatos;
       IF cuMarcaProd%NOTFOUND THEN
          CLOSE cuMarcaProd;
           errors.SETERROR(2741, 'Error en proceso LDC_PKGENEORDEAUTORECO.LDC_PROVALIESTAPRSU, producto no se encuentra suspendido por RP( Parametro LDC_TIPOSUSPRP )');
           RAISE  ex.controlled_error;
       END IF;
       CLOSE cuMarcaProd;

     END IF;
     ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROVALIESTAPRSU','Ok');

 EXCEPTION
   WHEN ex.controlled_error THEN
      errors.GETERROR( onuErrorCode,sbmensa);
       ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROVALIESTAPRSU','Error');
      RAISE;
   WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. '||SQLERRM;
      ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROVALIESTAPRSU','Error');
      errors.seterror;
      RAISE ex.controlled_error;

 END LDC_PROVALIESTAPRSU;

 PROCEDURE LDC_PROCREASOLIRECOSINCERT IS
/**************************************************************************
        Autor       : Elkin Alvarez / Horbath
        Fecha       : 2019-24-01
        Ticket      : 200-2231
        Descripcion : proceso que se encarga de generar tramite de reinstalacion y reco rp

        Parametros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
   sbrequestxml1       VARCHAR2(32767);
    nupackageid         mo_packages.package_id%TYPE;
    numotiveid          mo_motive.motive_id%TYPE;
    nuerrorcode         NUMBER;
    sberrormessage      VARCHAR2(10000);
    nucont              NUMBER(4);
    rcComponent         damo_component.stymo_component;
    rcmo_comp_link      damo_comp_link.stymo_comp_link;
    nunumber            NUMBER(4) DEFAULT 0;
    nuprodmotive        mo_component.prod_motive_comp_id%TYPE;
    sbtagname           mo_component.tag_name%TYPE;
    nuclasserv          mo_component.class_service_id%TYPE;
    nucomppadre         mo_component.component_id%TYPE;
    nuparano            NUMBER(4);
    nuparmes            NUMBER(2);
    nutsess             NUMBER;
    sbparuser           VARCHAR2(30);
    sbmensa             VARCHAR2(10000);
    nupakageid          mo_packages.package_id%TYPE;
    nucliente           ge_subscriber.subscriber_id%TYPE;
    numediorecepcion    mo_packages.reception_type_id%TYPE;
    sbdireccionparseada ab_address.address_parsed%TYPE;
    nudireccion         ab_address.address_id%TYPE;
    nulocalidad         ab_address.geograp_location_id%TYPE;
    nucategoria         mo_motive.category_id%TYPE;
    nusubcategori       mo_motive.subcategory_id%TYPE;
    sbComment           VARCHAR2(2000);
    nuProductId         NUMBER;
    nuContratoId        NUMBER;
    nuTaskTypeId        NUMBER;
    sw                  NUMBER(2) DEFAULT 0;
    sbflag              VARCHAR2(1);
    nuunidadoperativa   or_order.operating_unit_id%TYPE;
    nuestadosolicitud   mo_packages.motive_status_id%TYPE;
    sbsolicitudes       VARCHAR2(1000);
    nuorden   number;
    nuOrdenGene        or_order.order_id%TYPE;
    nuActividad        OR_ORDER_ACTIVITY.order_activity_id%TYPE;

    dtFechaAsig         or_order.ASSIGNED_DATE%TYPE;
    dtFechaEjecIni      or_order.EXEC_INITIAL_DATE%TYPE;
    dtFechaEjecFin      or_order.EXECUTION_FINAL_DATE%TYPE;
    dtFechaLega         or_order.LEGALIZATION_DATE%TYPE;

     nuCausalLega   ge_causal.causal_id%type := Dald_parameter.fnuGetNumeric_Value('LDC_CAUSLEGRECSCERT',NULL);
    nuClaseCausal        NUMBER;
    nuPersonaLega        ge_person.person_id%TYPE := ge_bopersonal.fnugetpersonid;
    nuEstado             pr_product.PRODUCT_STATUS_ID%TYPE;
    nuItemLega           ge_items.items_id%TYPE := Dald_parameter.fnuGetNumeric_Value('LDC_CODITEMRECOSCERT',NULL);
    nuCodigoAtrib        NUMBER := Dald_parameter.fnuGetNumeric_Value('LDC_CODIATRLECTRECOSCERT',NULL);
    sbNombreoAtrib       VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_NOMBATRLECTRECOSCERT',NULL);
    sbTipoSuspe          VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPOSUSP_RECO',NULL);
    nuLectura            NUMBER;
    sbTipoSuspeTra          VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('ID_RP_SUSPENSION_TYPE',NULL);
    sbdato               VARCHAR(1);
    nuTipoSuspLega       NUMBER;

    CURSOR cusolicitudesabiertas(nucuproducto pr_product.product_id%TYPE) IS
    SELECT pv.package_id colsolicitud
    FROM mo_packages pv,mo_motive mv
    WHERE pv.package_type_id     IN (SELECT to_number(column_value)
                                       FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('VAL_TRAMITES_NUEVOS_FLUJOS',NULL),',')))
      AND pv.motive_status_id = dald_parameter.fnuGetNumeric_Value('ESTADO_SOL_REGISTRADA')
      AND mv.product_id       = nucuproducto
      AND pv.package_id       = mv.package_id;

   --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
   CURSOR cuProducto(nucuorden NUMBER) IS
   SELECT product_id, subscription_id, oa.task_type_id,oa.package_id,oa.subscriber_id,ot.operating_unit_id, 13 estado_sol, ot.ASSIGNED_DATE,
            ot.EXEC_INITIAL_DATE,
            ot.EXECUTION_FINAL_DATE,
            ot.LEGALIZATION_DATE
   FROM or_order_activity oa,or_order ot--,open.mo_packages m
   WHERE oa.order_id = nucuorden
    --  AND oa.package_id IS NOT NULL
      AND oa.order_id = ot.order_id
     -- AND oa.package_id = m.package_id
      AND rownum   = 1;

    -- Cursor para obtener los componentes asociados a un motivo
    CURSOR cuComponente(nucumotivos mo_motive.motive_id%TYPE) IS
    SELECT COUNT(1)
    FROM mo_component C
    WHERE c.package_id = nucumotivos;


    -- Se consulta si el producto esta suspendido
    CURSOR cuEstadoProducto(nuProducto pr_product.product_id%type) IS
    SELECT 'X'
    FROM PR_PRODUCT P, pr_prod_suspension PS
    WHERE P.PRODUCT_ID = PS.PRODUCT_ID AND
        P.PRODUCT_ID = nuProducto AND
        P.PRODUCT_STATUS_ID = 2 AND
        PS.ACTIVE = 'Y' AND
        PS.SUSPENSION_TYPE_ID IN ( SELECT to_number(column_value)
                                    FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoSuspeTra,',') ));


  numarca number;
BEGIN
-- Consultamos datos para inicializar el proceso
 SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
   FROM dual;

  nuorden       := or_bolegalizeorder.fnuGetCurrentOrder;

    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PROCREASOLIRECOSINCERT','En ejecucion',nutsess,sbparuser);
    ut_trace.trace('Numero de la Orden:'||nuorden, 10);
    -- obtenemos el producto y el paquete
   OPEN cuproducto(nuorden);
   FETCH cuProducto INTO nuproductid, nucontratoid, nutasktypeid,nupakageid,nucliente,nuunidadoperativa,nuestadosolicitud, dtFechaAsig, dtFechaEjecIni, dtFechaEjecFin, dtFechaLega;
      IF cuProducto%NOTFOUND THEN
         sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
         ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLIRECOSINCERT','Ok');
         ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
         RAISE ex.controlled_error;
     END IF;
   CLOSE cuproducto;
   ut_trace.trace('Salio cursor cuProducto, nuProductId: '||nuProductId||'nuContratoId:'||'nuTaskTypeId:'||nuTaskTypeId, 10);

  OPEN  cuEstadoProducto(nuproductid);
  FETCH cuEstadoProducto INTO sbdato;
  IF cuEstadoProducto%NOTFOUND THEN
    sbmensa := 'Proceso termino con errores : '||'El producto: '||to_char(nuproductid)||' no se encuentra suspendido o esta suspendido con un tipo diferente a['||sbTipoSuspe||']';
    ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLIRECOSINCERT','Ok');
    RETURN;
  END IF;
  CLOSE cuEstadoProducto;
   -- Buscamos solicitudes de revisi?n periodica generadas
  sbsolicitudes := NULL;
  FOR i IN cusolicitudesabiertas(nuproductid) LOOP
   IF sbsolicitudes IS NULL THEN
    sbsolicitudes := i.colsolicitud;
   ELSE
    sbsolicitudes := sbsolicitudes||','||to_char(i.colsolicitud);
   END IF;
  END LOOP;

  IF TRIM(sbsolicitudes) IS NULL THEN
       -- Obtenemos los datos de la solicitud de visita de verificacion para generar el tramite de defecto critico
       sbdireccionparseada := NULL;
       nudireccion         := NULL;
       nulocalidad         := NULL;
       nucategoria         := NULL;
       nusubcategori       := NULL;
       sw                  := 1;
       BEGIN
        SELECT di.address_parsed
              ,di.address_id
              ,di.geograp_location_id
              ,pr.category_id
              ,pr.subcategory_id
          INTO sbdireccionparseada
               ,nudireccion
               ,nulocalidad
               ,nucategoria
               ,nusubcategori
          FROM pr_product pr,ab_address di
         WHERE pr.product_id = nuproductid
           AND pr.address_id = di.address_id;
       EXCEPTION
        WHEN no_data_found THEN
             sw := 0;
       END;
       IF sw = 1 THEN
            numarca := ldc_fncretornamarcaprod(nuproductid);
        -- Construimos el XML para generar la ord?n de reconexi?n sin certificaci?n
        sbcomment        := substr(ldc_retornacomentotlega(nuorden),1,2000)||' orden legalizada : '||to_char(nuorden)||' REGENERACION ';
        numediorecepcion := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_RECO_SIN_CERT');
        sbrequestxml1 := '<?xml version="1.0" encoding="ISO-8859-1"?>
                          <P_SOLICITUD_DE_RECONEXION_SIN_CERTIFICACION_100321 ID_TIPOPAQUETE="100321">
                          <RECEPTION_TYPE_ID>'||numediorecepcion||'</RECEPTION_TYPE_ID>
                          <CONTACT_ID>'||nucliente||'</CONTACT_ID>
                          <COMMENT_>'||sbcomment||'</COMMENT_>
                          <TIPO_DE_SUSPENSION>'||numarca||'</TIPO_DE_SUSPENSION>
                           <M_MOTIVO_DE_RECONEXION_SIN_CERTIFICACION_100304>
                            <CONTRATO>'||nucontratoid||'</CONTRATO>
                            <PRODUCTO>'||nuproductid||'</PRODUCTO>
                            <ADDRESS>'||sbdireccionparseada||'</ADDRESS>
                            <PARSER_ADDRESS_ID>'||nudireccion||'</PARSER_ADDRESS_ID>
                            <GEOGRAP_LOCATION_ID>'||nulocalidad||'</GEOGRAP_LOCATION_ID>
                            <CATEGORY_ID>'||nucategoria||'</CATEGORY_ID>
                            <SUBCATEGORY_ID>'||nusubcategori||'</SUBCATEGORY_ID>
                             <C_GAS_10346>
                              <C_MEDICION_10348/>
                             </C_GAS_10346>
                           </M_MOTIVO_DE_RECONEXION_SIN_CERTIFICACION_100304>
                          </P_SOLICITUD_DE_RECONEXION_SIN_CERTIFICACION_100321>';
        -- Procesamos el XML y generamos la solicitud
        os_registerrequestwithxml(
                                  sbrequestxml1,
                                  nupackageid,
                                  numotiveid,
                                  nuerrorcode,
                                  sberrormessage
                                 );
       IF nupackageid IS NULL THEN
          sbmensa := 'Proceso termino con errores : '||'Error al generar la solicitud. Codigo error : '||to_char(nuerrorcode)||' Mensaje de error : '||sberrormessage;
          ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLIRECOSINCERT','Ok');
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
          RAISE ex.controlled_error;
       ELSE

        sbmensa := 'Proceso termino Ok. Se genero la solicitud Nro : '||to_char(nupackageid);
        ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLIRECOSINCERT','Ok');
       END IF;
      -- Consultamos si el motivo generado tiene asociado los componentes
      OPEN cuComponente(numotiveid);
      FETCH cuComponente INTO nucont;
      CLOSE cuComponente;
       -- Si el motivo no tine los componentes asociados, se procede a registrarlos
      IF (nucont=0)THEN
        FOR i IN (
                  SELECT kl.*,mk.package_id solicitud,mk.subcategory_id subcategoria
                    FROM mo_motive mk,pr_component kl
                   WHERE mk.motive_id = numotiveid
                     AND kl.component_status_id <> 9
                     AND mk.product_id = kl.product_id
                   ORDER BY kl.component_type_id
                  ) LOOP
         IF i.component_type_id = 7038 THEN
            nunumber     := 1;
            nuprodmotive := 10346;
            sbtagname    := 'C_GAS_10346';
            nuclasserv   := NULL;
         ELSIF i.component_type_id = 7039 THEN
            nunumber     := 2;
            nuprodmotive := 10348;
            sbtagname    := 'C_MEDICION_10348';
            nuclasserv   := 3102;
         END IF;
         rcComponent.component_id         := mo_bosequences.fnugetcomponentid();
         rcComponent.component_number     := nunumber;
         rcComponent.obligatory_flag      := 'N';
         rcComponent.obligatory_change    := 'N';
         rcComponent.notify_assign_flag   := 'N';
         rcComponent.authoriz_letter_flag := 'N';
         rcComponent.status_change_date   := SYSDATE;
         rcComponent.recording_date       := SYSDATE;
         rcComponent.directionality_id    := 'BI';
         rcComponent.custom_decision_flag := 'N';
         rcComponent.keep_number_flag     := 'N';
         rcComponent.motive_id            := numotiveid;
         rcComponent.prod_motive_comp_id  := nuprodmotive;
         rcComponent.component_type_id    := i.component_type_id;
         rcComponent.motive_type_id       := 75;
         rcComponent.motive_status_id     := 15;
         rcComponent.product_motive_id    := 100304;
         rcComponent.class_service_id     := nuclasserv;
         rcComponent.package_id           := nupackageid;
         rcComponent.product_id           := i.product_id;
         rcComponent.service_number       := i.product_id;
         rcComponent.component_id_prod    := i.component_id;
         rcComponent.uncharged_time       := 0;
         rcComponent.product_origin_id    := i.product_id;
         rcComponent.quantity             := 1;
         rcComponent.tag_name             := sbtagname;
         rcComponent.is_included          := 'N';
         rcComponent.category_id          := i.category_id;
         rcComponent.subcategory_id       := i.subcategoria;
         damo_component.Insrecord(rcComponent);
         IF i.component_type_id = 7038 THEN
          nucomppadre :=  rcComponent.component_id;
         END IF;
         IF(nuMotiveId IS NOT NULL)THEN
           rcmo_comp_link.child_component_id  := rcComponent.component_id;
           IF i.component_type_id = 7039 THEN
              rcmo_comp_link.father_component_id := nucomppadre;
           ELSE
              rcmo_comp_link.father_component_id := NULL;
           END IF;
           rcmo_comp_link.motive_id           := nuMotiveId;
           damo_comp_link.insrecord(rcmo_comp_link);
         END IF;
        END LOOP;
       END IF;
     ELSE
      sbmensa := 'Proceso termino con errores : '||'No se encontraron datos de la solicitud asociada a la orden # '||to_char(nuorden);
      ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLIRECOSINCERT','Ok');
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
      RAISE ex.controlled_error;
     END IF;
    ELSE
     sbmensa := 'Proceso termino. : El producto : '||to_char(nuproductid)||' ya tiene una solicitud de reconexi?n sin certificaci?n en estado registrada.';
     ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLIRECOSINCERT','Ok');
     ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
      RAISE ex.controlled_error;
    END IF;

	
EXCEPTION
 WHEN ex.controlled_error THEN
  RAISE;
 WHEN OTHERS THEN
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDC_PROCREASOLIRECOSINCERT','Ok');
  errors.seterror;
  RAISE ex.controlled_error;
END;
END LDC_PKGENEORDEAUTORECO;
/
