CREATE OR REPLACE package adm_person.ldc_pkggecoprfamas IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  18/06/2024    Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  14/08/2024    jpinedc     OSF-3126: Se modifican
                            * prGeneFinanCuentasEsp
                            * prFinaDeudpConti
  ***************************************************************************/
 -- variables globales
 nuNotasIng number := 0;
 nucommit number := 500;
 nusesion number;
 sbUser varchar2(8);
 dtFechProc date;
 sbTerminal varchar2(50) := pkGeneralServices.fsbGetTerminal;

 -- tabla de parametros
  TYPE rcParametros IS RECORD(
     flagditc  varchar2(1),
     flagdito  varchar2(1),
     nucucoex  number(3),
     nucucoge  number(3),
     plficoco  number(3),
     plficont  number(3),
     feincodi  varchar2(10),
     feincodo  varchar2(10));

  TYPE tbParametros IS TABLE OF rcParametros INDEX BY varchar2(4);
  tParametros tbParametros;
  sbIndPar varchar2(4);

 PROCEDURE prIniTabla;

 FUNCTION ValidaCategoria (inucate in servsusc.sesucate%type,
                          inusuca in servsusc.sesusuca%type) return number;

 FUNCTION LeeParametro (inucate in servsusc.sesucate%type,
                        inusuca in servsusc.sesusuca%type,
                        sbParam in varchar2) return varchar2;

 PROCEDURE LeeParametro ( inucate     in  servsusc.sesucate%type,
                          inusuca     in  servsusc.sesusuca%type,
                          sbFlagToCon OUT varchar2,
                          sbFlagFiCon OUT varchar2,
                           nuPlanFOtroC OUT number,
                          nuPlanFCons OUT number,
                          nuCuoCons   OUT varchar2,
                          nuCuoOtrco  OUT varchar2,
                          onuOk       OUT NUMBER,
                          OSBERROR    OUT VARCHAR2 );
 function fnuModDiasdeGracia (osbMsgError out varchar2) return number ;
 function ActualizaCupoBrilla (osbMsgError out varchar2) return number;
 PROCEDURE prGeneNotapppago;
 /**************************************************************************
  Proceso     : prGeneNotapppago
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-29-03
  Ticket      :
  Descripcion : genera nota de productos por pronto pago

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

 PROCEDURE  prFinaDeudpConti;
  /**************************************************************************
  Proceso     : prFinaDeudpConti
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-29-03
  Ticket      :
  Descripcion : genera financiacion de deuda dde usuario que no pudieron pagar

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

PROCEDURE prJobGestioConti;
  /**************************************************************************
  Proceso     : prJobGestioConti
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-29-03
  Ticket      :
  Descripcion : job que s encarga de generar los procesos de contigencia

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/

PROCEDURE prGeneFinanConc ( inuPeriodo  IN   NUMBER,
                               inumes      IN   NUMBER,
                             sbTipoConc  IN VARCHAR2,
                             idtFechaPago IN DATE,
                             onuerror    OUT  NUMBER,
                             osberror    OUT  VARCHAR2) ;
 /**************************************************************************
  Proceso     : prGeneFinanConc
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-31-03
  Ticket      : 374
  Descripcion : genera financiacion de conceptos

  Parametros Entrada
   inuPeriodo  numero de periodo
   sbTipoConc    tipo de concepto  C - CONSUMO, T - TODOS, O - OTROS
   idtFechaPago  Fecha de pago
  Parametros de salida
   onuerror     codigo de error
   osberror     mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/

function fdtFecPagoFacAliv  (inucicl in perifact.pefacicl%type,
                                       idtfefimo in perifact.pefafimo%type) return date;

PROCEDURE prInsertNota(inucuenta ldc_notas_masivas.cuenta%type,
                       inuproducto ldc_notas_masivas.producto%type,
                       inuconcepto ldc_notas_masivas.concepto%type,
                       inucausal ldc_notas_masivas.causal%type,
                       inuvalor ldc_notas_masivas.valor%type,
                       isbsigno ldc_notas_masivas.signo%type,
                       isbdiferir ldc_notas_masivas.diferir%type,
                       inuplanfina ldc_notas_masivas.planfina%type,
                       inucuotas ldc_notas_masivas.cuotas%type,
                       inucuensaldo ldc_notas_masivas.CTASCONSALDO%type,
                       isbobsnota ldc_notas_masivas.obsnota%type,
                       inusesion ldc_notas_masivas.sesion%type,
                       isbusuario ldc_notas_masivas.usuario%type,
                       idtfecha ldc_notas_masivas.fecha%type,
                       inufactura ldc_notas_masivas.FACTURA%TYPE,
					   isbconsusb  varchar2);

   PROCEDURE prGeneFinanCuentasEsp;

END ldc_pkggecoprfamas;
/

CREATE OR REPLACE package BODY adm_person.ldc_pkggecoprfamas IS

 vgCicloPrPago NUMBER :=0 ;
  nuPeriActua NUMBER;
  dtFechaIni DATE;
  dtFechaFin DATE;
  nuPeriCons  NUMBER;
  inucuenInt NUMBER := 0;
  sbFlagToCon  VARCHAR2(1)    ;--:= DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGDITC',NULL);-- se almacena flag que indica si se difiere todos los conceptos
  sbFlagFiCon  VARCHAR2(1)    ;--:= DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGDITO',NULL); --se almacena flag si se finnacia todo el consumo
  nuPlanFOtroC NUMBER         ;--:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PLFICONT', NULL);  --se almacena plan de financiacion
  nuPlanFCons  NUMBER         ;--:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PLFICOCO', NULL);  --se almacena plan de financiacion
  nuCuoCons    NUMBER         ;--:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUCUCOEX', NULL); --se almacena numero de cuotas para conceptos de consumo
  nuCuoOtrco   NUMBER         ;--:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUCUCOGE', NULL); --se almacena numero de cuotas para otros conceptos

  gnucate NUMBER := 0;
  gnusuca NUMBER := 0;


  PROCEDURE prIniTabla IS
  /**************************************************************************
    Proceso     : prIniTabla
    Autor       : F.Castro
    Fecha       : 2020-29-03
    Ticket      : 374
    Descripcion : proceso que guarda los parametros en tabla en memoria

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 cursor cuPar is
  select *
    from LDC_CONFIG_CONTINGENC;

 BEGIN
    tParametros.delete;
    for rg in cuPar loop
       sbIndPar := lpad(rg.cateproc,2,'0') || lpad(rg.estraproc,2,'0');
       if not tParametros.exists(sbIndPar) then
          tParametros(sbIndPar).flagditc := rg.flagditc;
          tParametros(sbIndPar).flagdito := rg.flagdito;
          tParametros(sbIndPar).nucucoex := rg.nucucoex;
          tParametros(sbIndPar).nucucoge := rg.nucucoge;
          tParametros(sbIndPar).plficoco := rg.plficoco;
          tParametros(sbIndPar).plficont := rg.plficont;
          tParametros(sbIndPar).feincodi := rg.feincodi; -- to_date(rg.feincodi,'dd/mm/yyyy');
          tParametros(sbIndPar).feincodo := rg.feincodo; -- to_date(rg.feincodo,'dd/mm/yyyy');
       end if;
    end loop;

   /*sbIndPar :=  tParametros.first;
    loop exit when (sbIndPar IS null);
      dbms_output.put_line(sbIndPar || ' - ' || tParametros(sbIndPar).flagdafa || ' - ' ||
                                                tParametros(sbIndPar).flagdptc || ' - ' ||
                                                tParametros(sbIndPar).nupevali || ' - ' ||
                                                tParametros(sbIndPar).prdesprpa || ' - ' ||
                                                tParametros(sbIndPar).flagditc || ' - ' ||
                                                tParametros(sbIndPar).flagdito || ' - ' ||
                                                tParametros(sbIndPar).flagdpct || ' - ' ||
                                                tParametros(sbIndPar).nucucoex || ' - ' ||
                                                tParametros(sbIndPar).nucucoge || ' - ' ||
                                                tParametros(sbIndPar).nuperefco || ' - ' ||
                                                tParametros(sbIndPar).plficoco || ' - ' ||
                                                tParametros(sbIndPar).plficont || ' - ' ||
                                                tParametros(sbIndPar).feincodi || ' - ' ||
                                                tParametros(sbIndPar).feincodo || ' - ' ||
                                                tParametros(sbIndPar).nucublcu);
       sbIndPar := tParametros.next(sbIndPar);
    end loop;
    tParametros.delete;*/
 EXCEPTION
   WHEN OTHERS THEN
      ERRORS.SETERROR;
 END prIniTabla;


 function ActualizaCupoBrilla (osbMsgError out varchar2) return number is

  PRAGMA AUTONOMOUS_TRANSACTION;
  /**************************************************************************
    Proceso     : prActualizaCupoBrilla
    Autor       : F.Castro
    Fecha       : 2020-29-03
    Ticket      : 374
    Descripcion : proceso que guarda los parametros en tabla en memoria

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 onuError          number := 0;
 nucausal          cc_Causal.Causal_Id%type;
 dtfecha           date;
 sbFila            varchar2(100);
 nuquota_block_id  LD_QUOTA_BLOCK.QUOTA_BLOCK_ID%type;
 nuact             NUMBER := 0;
 nuCausBloq        NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CABLCUCO', NULL);
 nuCuentasBloq     NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('NUCUBLCUCO', NULL);
 sbObserv          VARCHAR2(1000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('OBBQCUPOCONT',NULL);

 cursor cuContratos is
 /* select contrato, max(t.ctasconsaldo) nucusaldo
    from LDC_NOTAS_MASIVAS t
    where t.sesion = nusesion
    group by contrato*/
   select distinct contrato, fila, causal_id, register_date
  from (
    select t.contrato, b.rowid fila, b.causal_id, b.register_date
      from LDC_NOTAS_MASIVAS_log t
        left join LD_QUOTA_BLOCK b on b.subscription_id=contrato--inususc
             and b.block = 'Y'
      where t.sesion = nusesion
	    and menserror = 'Procesado'
        and ctasconsaldo >= nuCuentasBloq
      );

   TYPE  tblCupoBrilla IS TABLE OF  cuContratos%ROWTYPE;

   vtblCupoBrilla tblCupoBrilla;

  cursor cuCupoBrilla (inususc suscripc.susccodi%type) is
    select rowid fila, t.causal_id, t.register_date
  from LD_QUOTA_BLOCK t
 where t.subscription_id=inususc
   and t.block = 'Y';


 BEGIN
 /* UPDATE ldc_osf_estaproc l
       SET estado = 'Revisando bloqueos de Cupo Brilla'
     WHERE l.sesion = nusesion
       AND l.proceso = 'PRFINADEUDPCONTI';
     COMMIT;*/
    OPEN cuContratos;
    LOOP
      FETCH cuContratos BULK COLLECT INTO vtblCupoBrilla LIMIT 100;
        FOR reg IN 1..vtblCupoBrilla.COUNT LOOP
           IF NVL(vtblCupoBrilla(reg).causal_id, -1) = -1 THEN
              nuquota_block_id := SEQ_LD_QUOTA_BLOCK.NEXTVAL;
             insert into LD_QUOTA_BLOCK (quota_block_id, block, subscription_id, causal_id,
                                         register_date, observation, username, terminal)
                                 values (nuquota_block_id, 'Y', vtblCupoBrilla(rEg).contrato, nuCausBloq,
                                         sysdate, sbObserv, sbUser, sbTerminal);
           ELSE
            if vtblCupoBrilla(reg).causal_iD = nuCausBloq and trunc(vtblCupoBrilla(REG).register_date) != trunc(sysdate) then
               update LD_QUOTA_BLOCK
                  set register_date = sysdate
                where rowid = vtblCupoBrilla(REG).fila;
           end if;
           END IF;
        END LOOP;
        COMMIT;
     EXIT WHEN cuContratos%NOTFOUND;
    END LOOP;
    CLOSE cuContratos;
    COMMIT;
  /*  for rg in cuContratos loop
      -- if nvl(rg.nucusaldo,0) >= nuCuentasBloq then
         open cuCupoBrilla(rg.contrato);
         fetch cuCupoBrilla into sbFila, nucausal, dtfecha;
         if cuCupoBrilla%notfound then
           nucausal := -1;
         end if;
         close cuCupoBrilla;

         if nucausal = -1 then
           nuquota_block_id := SEQ_LD_QUOTA_BLOCK.NEXTVAL;
           insert into LD_QUOTA_BLOCK (quota_block_id, block, subscription_id, causal_id,
                                       register_date, observation, username, terminal)
                               values (nuquota_block_id, 'Y', rg.contrato, nuCausBloq,
                                       sysdate, sbObserv, sbUser, sbTerminal);
           nuact := nuact + 1;
         else
           if nucausal = nuCausBloq and trunc(dtfecha) != trunc(sysdate) then
             update LD_QUOTA_BLOCK
                set register_date = sysdate
              where rowid = sbFila;
               nuact := nuact + 1;
           end if;
         end if;

         if mod(nuact,1000) = 0 then
           commit;
         end if;
      -- end if;
    end loop;

    commit;-*/

    return onuError;

 EXCEPTION
   WHEN OTHERS THEN
    rollback;
    errors.seterror;
    errors.geterror(onuError,osbMsgError);
  --  osbMsgError := 'Error en ActualizaCupoBrilla: ' || sqlerrm;
    return -1;
 END ActualizaCupoBrilla;

  PROCEDURE LeeParametro ( inucate     in  servsusc.sesucate%type,
                          inusuca     in  servsusc.sesusuca%type,
                          sbFlagToCon OUT varchar2,
                          sbFlagFiCon OUT varchar2,
                          nuPlanFOtroC OUT number,
                          nuPlanFCons OUT number,
                          nuCuoCons   OUT varchar2,
                          nuCuoOtrco  OUT varchar2,
                          onuOk       OUT NUMBER,
                          OSBERROR    OUT VARCHAR2) is
    /**************************************************************************
    Proceso     : LeeParametro
    Autor       : F.Castro
    Fecha       : 2020-29-03
    Ticket      : 374
    Descripcion : proceso que busca el parametro solicitado

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
  BEGIN
     sbIndPar := lpad(inucate,2,'0') || lpad(inusuca,2,'0');
    onuOk := 0;
   if tParametros.exists(sbIndPar) then
      sbFlagToCon := tParametros(sbIndPar).FLAGDITC;
      sbFlagFiCon :=  tParametros(sbIndPar).FLAGDITO;
      nuCuoCons   :=  tParametros(sbIndPar).NUCUCOEX;
      nuCuoOtrco  :=  tParametros(sbIndPar).NUCUCOGE;
      nuPlanFCons :=  tParametros(sbIndPar).PLFICOCO;
      nuPlanFOtroC :=  tParametros(sbIndPar).PLFICONT;
    END IF;
  EXCEPTION
   WHEN OTHERS THEN
       ERRORS.SETERROR;
       ERRORS.GETERROR(onuOk,OSBERROR);
  END LeeParametro;

 FUNCTION LeeParametro (inucate in servsusc.sesucate%type,
                        inusuca in servsusc.sesusuca%type,
                        sbParam in varchar2) return varchar2 IS
  /**************************************************************************
    Proceso     : LeeParametro
    Autor       : F.Castro
    Fecha       : 2020-29-03
    Ticket      : 374
    Descripcion : proceso que busca el parametro solicitado

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 sbParametro varchar2(50);

 BEGIN
   sbIndPar := lpad(inucate,2,'0') || lpad(inusuca,2,'0');

   if tParametros.exists(sbIndPar) then
     if sbParam = 'FLAGDITC' then
        sbParametro := tParametros(sbIndPar).FLAGDITC;
     elsif sbParam = 'FLAGDITO' then
        sbParametro :=  tParametros(sbIndPar).FLAGDITO;
     elsif sbParam = 'NUCUCOEX' then
        sbParametro :=  tParametros(sbIndPar).NUCUCOEX;
     elsif sbParam = 'NUCUCOGE' then
        sbParametro :=  tParametros(sbIndPar).NUCUCOGE;
     elsif sbParam = 'PLFICOCO' then
        sbParametro :=  tParametros(sbIndPar).PLFICOCO;
     elsif sbParam = 'PLFICONT' then
        sbParametro :=  tParametros(sbIndPar).PLFICONT;
     elsif sbParam = 'FEINCODI' then
        sbParametro :=  tParametros(sbIndPar).FEINCODI;
     elsif sbParam = 'FEINCODO' then
        sbParametro :=  tParametros(sbIndPar).FEINCODO;
     else
        sbParametro := null;
     end if;
   else
     sbParametro := null;
   end if;

     return sbParametro;

 EXCEPTION
   WHEN OTHERS THEN
      return null;
 END LeeParametro;

 FUNCTION ValidaCategoria (inucate in servsusc.sesucate%type,
                          inusuca in servsusc.sesusuca%type) return number IS
  /**************************************************************************
    Proceso     : ValidaCategoria
    Autor       : F.Castro
    Fecha       : 2020-29-03
    Ticket      : 374
    Descripcion : proceso valida si la catgoria / subcategopria son validas para el proceso

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 sbParametro varchar2(50);

 BEGIN
   sbIndPar := lpad(inucate,2,'0') || lpad(inusuca,2,'0');
   if tParametros.exists(sbIndPar) then
      return 0;
   else
      return 1;
   end if;

 EXCEPTION
   WHEN OTHERS THEN
      return -1;
 END ValidaCategoria;
 PROCEDURE prInsertLog( inufactura  IN  NUMBER,
                        inuProducto IN  NUMBER,
                        isbProceso  IN  VARCHAR2,
                        isbError    IN  VARCHAR2) IS
  /**************************************************************************
    Proceso     : prInsertLog
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-29-03
    Ticket      : 374
    Descripcion : proceso que genera log

    Parametros Entrada
     inufactura    numero de factura
     inuProducto   numero de producto
     isbProceso    proceso
     isbError      error
    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN
   INSERT INTO LDC_LOGPROFACT
    (
      FACTURA,    PRODUCTO,    PROCESO,    FECHERRO,    MENSERRO
    )
    VALUES
    (      inufactura,      inuProducto,      isbProceso,     SYSDATE, isbError
    );
    COMMIT;
 EXCEPTION
   WHEN OTHERS THEN
      ERRORS.SETERROR;
 END prInsertLog;

 PROCEDURE prInsertNota(inucuenta ldc_notas_masivas.cuenta%type,
                       inuproducto ldc_notas_masivas.producto%type,
                       inuconcepto ldc_notas_masivas.concepto%type,
                       inucausal ldc_notas_masivas.causal%type,
                       inuvalor ldc_notas_masivas.valor%type,
                       isbsigno ldc_notas_masivas.signo%type,
                       isbdiferir ldc_notas_masivas.diferir%type,
                       inuplanfina ldc_notas_masivas.planfina%type,
                       inucuotas ldc_notas_masivas.cuotas%type,
                       inucuensaldo ldc_notas_masivas.CTASCONSALDO%type,
                       isbobsnota ldc_notas_masivas.obsnota%type,
                       inusesion ldc_notas_masivas.sesion%type,
                       isbusuario ldc_notas_masivas.usuario%type,
                       idtfecha ldc_notas_masivas.fecha%type,
                       inufactura ldc_notas_masivas.FACTURA%TYPE,
					   isbconsusb  varchar2) IS
  /**************************************************************************
    Proceso     : prInsertNota
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-29-03
    Ticket      : 374
    Descripcion : proceso que inserta notas a procesar

    Parametros Entrada

    Parametros de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
 nucontrato SERVSUSC.SESUSUSC%TYPE;

 BEGIN
   nuNotasIng := nuNotasIng + 1;

   select sesususc
     into nucontrato
     from servsusc
    where sesunuse=inuproducto;

   INSERT INTO ldc_notas_masivas
    (cuenta, contrato, producto, concepto, causal, valor, signo, diferir,
     planfina, cuotas, CTASCONSALDO, obsnota, sesion, usuario, fecha, FACTURA, conssubs  )

    VALUES
    (inucuenta, nucontrato, inuproducto, inuconcepto, inucausal, inuvalor, isbsigno, isbdiferir,
     inuplanfina, inucuotas, inucuensaldo, isbobsnota, inusesion, isbusuario, idtfecha, inufactura, isbconsusb);

    if mod(nuNotasIng,nucommit) = 0 then
      COMMIT;
    end if;
 EXCEPTION
   WHEN OTHERS THEN
      ERRORS.SETERROR;
 END prInsertNota;
 PROCEDURE prJobGestioConti IS
 /**************************************************************************
  Proceso     : prJobGestioConti
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-29-03
  Ticket      :
  Descripcion : job que s encarga de generar los procesos de contigencia

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
  nuparano   NUMBER;
  nuparmes   NUMBER;
  nutsess    NUMBER;
  sbparuser  VARCHAR2(4000);
  nuerror    NUMBER;
  osberror   VARCHAR2(4000);
  nuDias     NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUDICACO', NULL);-- se almacena el numero de dias a revisar
  sbCategoria  VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CATEPROC',NULL);
  nuconta   NUMBER := 0;
  nuperiante  NUMBER;
  sbFlagOtCoEjec  VARCHAR2(1) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGFEOC', NULL); --se almacena flag para ejecucion de otros
  sbEstrato    VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTRAPROC',NULL); --se almacena codigo de estratos
  nujob   NUMBER;
  sbWhat   VARCHAR2(4000);

  --se obtienen periodos a procesar dia antes de la fecha final
  CURSOR cuPeriodosFF IS
  SELECT pefafimo, pefaffmo, pefacicl, pefacodi
  FROM perifact
  WHERE ( trunc(pefaffmo) - TRUNC(SYSDATE) ) = nuDias;

    --se obtiene periodo anterior
  CURSOR cuperiodoant(inuciclo NUMBER, idtFeIniMov DATE) IS
  SELECT *
  FROM (SELECT --+ INDEX_DESC (PERIFACT IX_PEFA_CICL_FFMO)
          pefacodi
        FROM PERIFACT
        WHERE PEFAFFMO < idtFeIniMov
         AND PEFACICL = inuciclo
        ORDER BY PEFAFFMO desc)
   WHERE ROWNUM < 2;

  CURSOR cuFactura(nuPeriante NUMBER) IS
  SELECT /*+ index( cu IDXCUCO_RELA)
          index(f IX_FACTURA04) */
         cu.cucocodi
  FROM cuencobr cu, factura f, SERVSUSC S
  WHERE  f.factpefa =  nuPeriante
   AND f.factcodi = cu.cucofact
    AND f.factprog = 6
    AND s.sesunuse = cu.cuconuse
  AND ValidaCategoria(s.sesucate, s.sesusuca) = 0;
    /*AND s.sesucate IN ( SELECT to_number(regexp_substr(sbCategoria,'[^,]+', 1, LEVEL)) AS estacort
                        FROM dual
                        CONNECT BY regexp_substr(sbCategoria, '[^,]+', 1, LEVEL) IS NOT NULL
                        )
    AND s.sesusuca IN (  SELECT to_number(regexp_substr(sbEstrato,'[^,]+', 1, LEVEL)) AS ESTRATO
                        FROM dual
                        CONNECT BY regexp_substr(sbEstrato, '[^,]+', 1, LEVEL) IS NOT NULL
                         );*/

 BEGIN
    UT_TRACE.TRACE('[PRJOBGESTIOCONTI] INIICO ',10);
  IF fblaplicaentregaxcaso('0000379') THEN
     -- Obtenemos datos para realizar ejecucion
     SELECT  to_number(to_char(SYSDATE,'YYYY')),
                to_number(to_char(SYSDATE,'MM')),
                userenv('SESSIONID'),
                USER
     INTO nuparano,nuparmes,nutsess,sbparuser
     FROM dual;

      -- Start log program
     ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBGESTIOCONTI','En ejecucion',nutsess,sbparuser);
       -- Carga tabla de parametros en memoria
     prIniTabla;

     IF sbFlagOtCoEjec = 'S' THEN
        FOR reg IN cuPeriodosFF LOOP
          nuperiante := NULL;
          IF cuperiodoant%ISOPEN THEN
             CLOSE cuperiodoant;
          END IF;

          OPEN cuperiodoant(reg.pefacicl, reg.pefafimo);
          FETCH cuperiodoant INTO nuperiante;
          CLOSE cuperiodoant;
          nuconta := 0;
          --se actualizan cuentas
          FOR regC IN cuFactura(nuperiante) LOOP
             UPDATE cuencobr SET cucofeve = sysdate where cucocodi = regC.cucocodi;
             IF mod(nuconta,100) = 0 then
                COMMIT;
             END IF;
             nuconta := nuconta  + 1;
          END LOOP;
          COMMIT;

        END LOOP;
     END IF;
 tParametros.delete;

   ldc_pkggecoprfa.prGeneNotapppago;

   ldc_pkggecoprfa.prFinaDeudpConti;

     --se ejecuta proceso pronto pago
     /*sbWhat := ' DECLARE '||
                 chr(10) ||' nuOk NUMBER; '||
           chr(10) ||' sbErrorMessage VARCHAR2(4000); '||
           chr(10) || ' BEGIN ' ||
           chr(10) || '   SetSystemEnviroment; '||
           chr(10) || '   Errors.Initialize; '||
           chr(10) || '   ldc_pkggecoprfa.prGeneNotapppago; ' ||
           chr(10) || ' exception when others then  Errors.SetError; '||
           chr(10) || 'END;';

      dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
      commit;

      --se ejcuta proceso diferido
      sbWhat := ' DECLARE '||
                 chr(10) ||' nuOk NUMBER; '||
           chr(10) ||' sbErrorMessage VARCHAR2(4000); '||
           chr(10) || ' BEGIN ' ||
           chr(10) || '   SetSystemEnviroment; '||
           chr(10) || '   Errors.Initialize; '||
           chr(10) || '   ldc_pkggecoprfa.prFinaDeudpConti; ' ||
           chr(10) || ' exception when others then  Errors.SetError; '||
           chr(10) || 'END;';

      dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
      commit;*/

     ldc_proactualizaestaprog(nutsess,osberror,'PRJOBGESTIOCONTI','Ok.');
  END IF;
  UT_TRACE.TRACE('[PRJOBGESTIOCONTI] FIN ',10);
exception
  WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror,osberror);
      ldc_proactualizaestaprog(nutsess,osberror,'PRJOBGESTIOCONTI','error');
    WHEN OTHERS THEN
       ERRORS.SETERROR;
       ERRORS.geterror(nuerror,osberror);
       ldc_proactualizaestaprog(nutsess,osberror,'PRJOBGESTIOCONTI','error');
 END prJobGestioConti;
 PROCEDURE prgeneraNotas( inuSusc     IN   NUMBER,
                          inuCuenta   IN    NUMBER,
                          idtfechaVen IN   DATE,
                          idtfechaVefi IN   DATE,
                          inuNuse     IN    NUMBER,
                          InuPeriActu IN   NUMBER,
                          inuFactura  IN   NUMBER,
                          inuciclo    IN   NUMBER,
                          inucupon    IN   NUMBER,
                          inucate     IN    NUMBER,
						  inuValor    IN    NUMBER,
						  inuValorDesc IN NUMBER,
						  inuConcepto IN NUMBER,
                          onuError    OUT  NUMBER,
                          osbError    OUT  VARCHAR2) IS
  /**************************************************************************
    Proceso     : prgeneraNotas
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-29-03
    Ticket      :
    Descripcion : genera nota de productos por pronto pago

    Parametros Entrada
     inuSusc       contrato
      inuCuenta    cuenta de cobro
      idtfechaVen  fecha de vencimiento
      inuNuse      numero de producto
      inuPeriAnte  periodo anterior
      InuPeriActu  periodo actual
      inuFactura   numero de factura
      inuciclo     ciclo
    inucupon     cupon
    inucate      CATEGORIA
    Parametros de salida
      onuError     numero de error
      osbError     mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
  dtFechPago   DATE;
  nuCupon      NUMBER;
  nuValorPago  NUMBER;
  nuvalornota  NUMBER;
  sbFlagDcot   VARCHAR2(1) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGDPCT',NULL); --se almacena flag si aplica descuento para todo el consumo
  rcCargo      cargos%rowtype ;
  nuPorcDesc   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PRDESPRPA', NULL);-- se almacena porcentaje de descuento
  sbFlagDpat   VARCHAR2(1) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGDPTC',NULL); --se almacena flga si aplica descuento para todo el pago
  sbConcExcl   VARCHAR2(400) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CONCNODE',NULL); --se almacena concepto de descuento
  sbConcEmpl   VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CONDEEMP',NULL);
  nuPrograma   number := dald_parameter.fnugetnumeric_value('LDC_PRGCPRPA',null);--se almacena programa que genera el cargo
  nuProgNota   number := dald_parameter.fnugetnumeric_value('LDC_PRGNPRPA',null);--se almacena programa que genera el cargo
  nuconcdesgas   NUMBER;

  inuCausal    NUMBER  :=  dald_parameter.fnugetnumeric_value('LDC_CACAPRPA',null);--se almacena cuasal  para generar cargos
  inuConsDocu  number; --se almacena codigo de la nota
  isbDocSop    VARCHAR2(100); -- se almacena documento de soporte
  rcCargoNull   cargos%rowtype;
  regNotas     NOTAS%ROWTYPE;
  nuError     NUMBER;
  sbError     VARCHAR2(4000);


  --se consulta si el pago fue antes de fecha de vencimiento
  CURSOR cugetPagos IS
  SELECT p.pagofepa, p.PAGOCUPO, p.PAGOVAPA
  FROM pagos p
  WHERE p.pagosusc = inuSusc
    AND p.pagocupo = inucupon
    and p.pagofepa <= idtfechaVen;

   CURSOR cugetProdgas IS
   SELECT sesunuse , cucocodi
   FROM servsusc, cuencobr
   WHERE sesususc = inuSusc
     AND sesuserv = 7014
     AND cuconuse = sesunuse
     AND cucofact = inuFactura;

   --se calcula valor de pago por consumo
   CURSOR cuValorNota IS
   SELECT SUM((nvl(RALIVAUL,0) - nvl(RALIVASU,0))) valcal, round( SUM( (nvl(RALIVAUL,0) - nvl(RALIVASU,0))  * (nuPorcDesc/100) ), 0) valor
    FROM RANGLIQU
    WHERE RALISESU = inuNuse
       AND RALIPEFA = InuPeriActu
       AND RALICONC = 31
       AND RALILIIR = 0
       AND RALILISR = 20
       and ralipeco = (SELECT MAX(re.ralipeco)
                            FROM rangliqu re
                            WHERE re.ralisesu = inuNuse
                             AND re.ralipefa = InuPeriActu
                             AND re.raliconc = 31);

   --valor nota tota consumo
   CURSOR cuValorNotaCon IS
   SELECT valor valcal , round(valor * (nuPorcDesc/100), 0) valor
   FROM ( SELECT NVL(SUM( NVL(RALIVAUL,0) - NVL(RALIVASU,0)),0) valor
          FROM RANGLIQU
          WHERE RALISESU = inuNuse
           AND RALIPEFA = InuPeriActu
           AND RALICONC = 31
           and ralipeco = (SELECT MAX(re.ralipeco)
                            FROM rangliqu re
                            WHERE re.ralisesu = inuNuse
                             AND re.ralipefa = InuPeriActu
                             AND re.raliconc = 31));


   --se obtiene periodo actual
   CURSOR cuGetPerioactual IS
   SELECT pefacodi, pefafimo, pefaffmo
   FROM perifact
   WHERE pefacicl = inuciclo
    AND pefaactu = 'S';

     --se obtiene periodo de consumo actual
    CURSOR cugetPeriCons(  dttfechIni  DATE,
                          dttfechFin  DATE
                          ) IS
    select pc.PECSCONS
    from  pericose pc
    where pc.pecsfecf between dttfechIni and dttfechFin
     and pc.pecscico = inuciclo;


   --saldo por concepto residenciales
  CURSOR cuSaldoConceR IS
  SELECT concepto,
		 SUM(VALOR) valcal,
		 ROUND(SUM(valor_DESC),0) valor_DESC,
		 producto,
		 cuenta
  FROM (
		  SELECT (select ticoconc from ldc_tiprodcondes where ticoserv = SESUSERV) concepto,
				CARGVALO VALOR,
				round(CARGVALO * (nuPorcDesc/100), 0) valor_DESC,
				CARGNUSE producto,
				CARGCUCO cuenta
		  FROM cargos, servsusc
		  WHERE cargcuco = inuCuenta
		   and cargnuse = inuNuse
		   and cargnuse = sesunuse
		   and cargcodo = inucupon
		   and cargsign = 'PA')
  GROUP BY concepto,producto, cuenta
  HAVING    SUM(valor_DESC) > 0;

  /*SELECT concepto,
        valor valcal,
        valor_DESC,
        producto,
        (SELECT MAX(cucocodi)
          FROM cuencobr c, factura f
          WHERE cuconuse = producto
            AND factpefa <= InuPeriActu
            AND f.factcodi = cucofact
            AND f.factprog = 6 ) cuenta
    FROM (
          SELECT (select ticoconc from ldc_tiprodcondes where ticoserv = rereserv) concepto, rerevalo valor, round(rerevalo * (nuPorcDesc/100), 0) valor_DESC,
          ( SELECT max(sesunuse)
           FROM servsusc
           WHERE sesususc = inuSusc
             AND sesuserv = rereserv
           AND EXISTS (SELECT 1 FROM OPEN.CARGOS WHERE CARGCODO = inucupon AND CARGNUSE = SESUNUSE AND CARGSIGN = 'PA' )
           ) producto
          FROM (
                SELECT  rereserv, sum(rerevalo) rerevalo
                FROM (
                    SELECT rerecupo,decode(rereconc, 196, 31,rereconc) rereconc,
                         rereserv , sum(rerevalo) rerevalo
                    FROM OPEN.resureca r
                     WHERE r.rerecupo = inucupon
                       AND trunc(rerefeve) >= trunc(idtfechaVefi)
                       AND rereconc not in ( SELECT to_number(regexp_substr(sbConcEmpl,'[^,]+', 1, LEVEL)) AS conc
                                            FROM dual
                                            CONNECT BY regexp_substr(sbConcEmpl, '[^,]+', 1, LEVEL) IS NOT NULL
                                            )
                    GROUP BY rerecupo,rereconc, rereserv
                    )
                GROUP BY  rereserv
                 having  sum(rerevalo) > 0 ) )
    WHERE valor_DESC > 0
     order by producto;*/

  /*SELECT *
  FROM (
      SELECT concepto,  valor valcal, round(valor * (nuPorcDesc/100), 0) valor_DESC
      FROM ( SELECT rereconc concepto,
               sum(rerevalo) valor
          FROM (
            SELECT factsusc, factcodi, factfege, rerecupo, rereconc, cucocodi, cucovato, cucosacu, rerevalo , rerefeve, sesunuse, sesuserv
            FROM (SELECT rerecupo,DECODE(rereconc, 196, 31,rereconc) rereconc,trunc(rerefeve) rerefeve, RERESERV, sum(rerevalo) rerevalo
                FROM OPEN.resureca r
                 WHERE r.rerecupo = inucupon
                GROUP BY rerecupo,rereconc, RERESERV, trunc(rerefeve)) r,  OPEN.cupon c, OPEN.servsusc s, OPEN.cuencobr cc, OPEN.factura f
            WHERE rerecupo = cuponume
             AND cuposusc = sesususc
             and RERESERV = sesuserv
             AND sesunuse = cuconuse
             AND cucofact = factcodi
             and sesunuse = inuNuse
             AND rerefeve = trunc(idtfechaVefi)
             AND (SELECT 'x' FROM OPEN.cargos WHERE cargcuco=cucocodi AND cargsign='PA' AND cargcodo=rerecupo) = 'x'
             )
            WHERE cucocodi = inuCuenta
          GROUP BY rereconc
          having  sum(rerevalo) > 0))
    where valor_DESC > 0*/


    --saldo por concepto no residenciales
  CURSOR cuSaldoConceNR IS
    SELECT concepto,
		 SUM(VALOR) valcal,
		 ROUND(SUM(valor_DESC),0) valor_DESC,
		 producto,
		 cuenta
  FROM (
		  SELECT (select ticoconc from ldc_tiprodcondes where ticoserv = SESUSERV) concepto,
				CARGVALO VALOR,
				round(CARGVALO * (nuPorcDesc/100), 0) valor_DESC,
				CARGNUSE producto,
				CARGCUCO cuenta
		  FROM cargos, servsusc
		  WHERE cargcuco = inuCuenta
		   and cargnuse = inuNuse
		   and cargnuse = sesunuse
		    and cargcodo = inucupon
		   and cargsign = 'PA')
  GROUP BY concepto,producto, cuenta
  HAVING    SUM(valor_DESC) > 0;

  /*SELECT concepto,
        valor valcal,
        valor_DESC,
        producto,
        (SELECT MAX(cucocodi)
          FROM cuencobr c, factura f
          WHERE cuconuse = producto
            AND factpefa <= InuPeriActu
            AND f.factcodi = cucofact
            AND f.factprog = 6 ) cuenta
    FROM (
          SELECT (select ticoconc from ldc_tiprodcondes where ticoserv = rereserv) concepto,
                  rerevalo valor,
                  round(rerevalo * (nuPorcDesc/100), 0) valor_DESC,
                  (SELECT MAX(sesunuse) FROM servsusc WHERE sesususc =inuSusc AND sesuserv = rereserv
                  AND EXISTS (SELECT 1 FROM OPEN.CARGOS WHERE CARGCODO = inucupon AND CARGNUSE = SESUNUSE AND CARGSIGN = 'PA' )
                    ) producto
          FROM (
                SELECT  rereserv, sum(rerevalo) rerevalo
                FROM (
                      SELECT rerecupo,decode(rereconc, 196, 31,rereconc) rereconc,
                              rereserv,
                             sum(rerevalo) rerevalo
                      FROM OPEN.resureca r
                      WHERE r.rerecupo = inucupon
                          AND trunc(rerefeve) >= trunc(idtfechaVefi)
                          AND r.rereconc not in ( SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                                    FROM dual
                                    CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL
                                    )
                          AND rereconc not in ( SELECT to_number(regexp_substr(sbConcEmpl,'[^,]+', 1, LEVEL)) AS conc
                                            FROM dual
                                            CONNECT BY regexp_substr(sbConcEmpl, '[^,]+', 1, LEVEL) IS NOT NULL
                                            )
                    GROUP BY rerecupo,rereconc, rereserv
                    )
                GROUP BY  rereserv
                 having  sum(rerevalo) > 0 )

    ) WHERE valor_DESC > 0
    order by producto;*/
    /*
  SELECT *
  FROM (
      SELECT concepto,  valor valcal, round(valor * (nuPorcDesc/100), 0) valor_DESC
      FROM ( SELECT rereconc concepto,
               sum(rerevalo) valor
          FROM (
            SELECT factsusc, factcodi, factfege, rerecupo, rereconc, cucocodi, cucovato, cucosacu, rerevalo , rerefeve, sesunuse, sesuserv
            FROM (SELECT rerecupo,DECODE(rereconc, 196, 31,rereconc) rereconc ,trunc(rerefeve) rerefeve, RERESERV, sum(rerevalo) rerevalo
                FROM OPEN.resureca r
                 WHERE r.rerecupo = inucupon
                GROUP BY rerecupo,rereconc, RERESERV, trunc(rerefeve)) r,  OPEN.cupon c, OPEN.servsusc s, OPEN.cuencobr cc, OPEN.factura f
            WHERE rerecupo = cuponume
             AND cuposusc = sesususc
             and RERESERV = sesuserv
             AND sesunuse = cuconuse
             AND cucofact = factcodi
             and sesunuse = inuNuse
             --AND rerefeve = trunc(cucofeve)
             AND (SELECT 'x' FROM OPEN.cargos WHERE cargcuco=cucocodi AND cargsign='PA' AND cargcodo=rerecupo) = 'x'
             )
            WHERE cucocodi = inuCuenta
                      AND rereconc not in ( SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                        FROM dual
                        CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL
                        )
          GROUP BY rereconc
          having  sum(rerevalo) > 0))
    where valor_DESC > 0;*/
    --concepto gas
    CURSOR cugetConceGas IS
     select ticoconc
     from ldc_tiprodcondes
     where ticoserv = 7014;

    PROCEDURE proGeneraNota( inuConc   IN NUMBER,
                             inuvalor  IN NUMBER,
                             inuvalCAL IN NUMBER,
                             inuprod   IN NUMBER,
                             inucuenta IN NUMBER,
                             onuerror  OUT  NUMBER,
                             osberror  OUT VARCHAR2) IS

    BEGIN
     onuerror := 0;
     IF inucuenInt <> inuCuenta THEN
        --si el valor de la nota es mayor a cero se crea
        PKBILLINGNOTEMGR.GETNEWNOTENUMBER(inuConsDocu);
        UT_TRACE.TRACE( 'CONSECUTIVO DE LA NOTA '||inuConsDocu||' CONTRATO '||inuSusc , 10 );
         regNotas.NOTANUME := inuConsDocu ;
        regNotas.NOTASUSC := inuSusc ;
        regNotas.NOTAFACT := -1 ;
        regNotas.NOTATINO := 'C' ;
        regNotas.NOTAFECO := SYSDATE ;
        regNotas.NOTAFECR := SYSDATE ;
        regNotas.NOTAPROG := nuProgNota ;
        regNotas.NOTAUSUA := 1 ;
        regNotas.NOTATERM := NVL(userenv('TERMINAL'),'DESCO');
        regNotas.NOTACONS := 71;
        regNotas.NOTANUFI := NULL;
        regNotas.NOTAPREF := NULL;
        regNotas.NOTACONF := NULL;
        regNotas.NOTAIDPR := NULL;
        regNotas.NOTACOAE := NULL;
        regNotas.NOTAFEEC := NULL;
        regNotas.NOTAOBSE := 'GENERACION DE NOTA POR PRONTO PAGO' ;
        regNotas.NOTADOCU := NULL ;
        regNotas.NOTADOSO := 'NC-' || inuConsDocu ;

        PKTBLNOTAS.INSRECORD(regNotas);
        inucuenInt := inuCuenta;
    END IF;
    UT_TRACE.TRACE( 'CREANDO CARGOS, CONTRATO '||inuSusc , 10 );

     rcCargo := rcCargoNull ;

    rcCargo.cargcuco := -1;
    rcCargo.cargnuse := inuprod ;
    rcCargo.cargpefa := nuPeriActua ;
    rcCargo.cargconc := inuConc ;
    rcCargo.cargcaca := inuCausal;
    rcCargo.cargsign := 'CR' ;
    rcCargo.cargvalo := inuvalor ;
    rcCargo.cargdoso := 'NC-'||inuConsDocu; -- isbDocumento ;  DEBE SER DF-NRODIFERIDO o ND-NRONOTA?
    rcCargo.cargtipr :=  pkBillConst.AUTOMATICO;
    rcCargo.cargfecr := SYSDATE ;
    rcCargo.cargcodo := inuConsDocu; --  DEBE SER  numero de la nota
    rcCargo.cargunid := 0 ;
    rcCargo.cargcoll := null ;
    rcCargo.cargpeco := nuPeriCons ;
    rcCargo.cargprog := nuPrograma; --
    rcCargo.cargusua := 1;

    -- Adiciona el Cargo
    pktblCargos.InsRecord (rcCargo);
    UT_TRACE.TRACE( 'TERMINO DE CREAR CARGO ', 10 );

    INSERT INTO LDC_PRCOPPPA
    (
      PCPPFACT,    PCPPCUCO,    PCPPPROD,    PCPPFEVE,    PCPPFEPA,    PCPPVAPA,    PCPPCUPO,    PCPPVALO,    PCPPNOTA,    PCPPFEGE, PCPPPEFA, PCPPCICL, PCPPCONC
    )
    VALUES
    (
      inuFactura, inucuenta, inuprod, idtfechaVen, dtFechPago, inuvalCAL, nuCupon,  inuvalor, inuConsDocu, SYSDATE, InuPeriActu,inuciclo,inuConc
    );
   exception
    WHEN EX.CONTROLLED_ERROR THEN
     ERRORS.geterror(onuError,osbError);

    WHEN OTHERS THEN
     ERRORS.SETERROR;
     ERRORS.geterror(onuError,osbError);

   END;
 BEGIN
    dtFechPago := null;
    nuCupon    := null;
    nuValorPago := null;
    nuvalornota := 0;
    onuError := 0;
    osbError := null;
	nuError := 0;
	sbError  := NULL;

    IF vgCicloPrPago <> inuciclo THEN
       -- DBMS_OUTPUT.PUT_LINE('INGRESO '||inuciclo);

        nuPeriActua := NULL;
        dtFechaIni := NULL;
        dtFechaFin := NULL;
        nuPeriCons := NULL;

        IF cuGetPerioactual%ISOPEN THEN
           CLOSE cuGetPerioactual;
        END IF;

        OPEN cuGetPerioactual;
        FETCH cuGetPerioactual INTO nuPeriActua, dtFechaIni, dtFechaFin;
        IF cuGetPerioactual%NOTFOUND THEN
          CLOSE cuGetPerioactual;
          onuError := -1;
          osbError := 'No se encontro periodo actual para el ciclo ['||inuciclo||']';
          RETURN;
        END IF;
        CLOSE cuGetPerioactual;
          IF cugetPeriCons%ISOPEN THEN
            CLOSE cugetPeriCons;
         END IF;


         OPEN cugetPeriCons(dtFechaIni, dtFechaFin);
         FETCH cugetPeriCons INTO nuPeriCons;
         IF cugetPeriCons%NOTFOUND THEN
            CLOSE cugetPeriCons;
          onuError := -1;
          osbError := 'No se encontro periodo de consumo vigente para el ciclo ['||inuciclo||'] fechas ['||dtFechaIni||' - '||dtFechaFin||']';
            RETURN;
         END IF;
         CLOSE cugetPeriCons;

         vgCicloPrPago := inuciclo;
    END IF;


   /*
    IF cugetPagos%ISOPEN THEN
       CLOSE cugetPagos;
    END IF;

   IF cugetProdgas%ISOPEN THEN
      CLOSE cugetProdgas;
   END IF;
  IF inuNuse IS NULL THEN
       OPEN cugetProdgas;
       FETCH cugetProdgas INTO inuNuse, inuCuenta;
       CLOSE cugetProdgas;
   END IF;*/

   --DBMS_OUTPUT.PUT_LINE('nuPeriActua '||nuPeriActua||' inuNuse '||inuNuse||' susc '||inuSusc);


    --se valida si hubo pagos dentro de los tiempos
   /* OPEN cugetPagos;
    FETCH cugetPagos INTO dtFechPago, nuCupon, nuValorPago;
    CLOSE cugetPagos;*/
--DBMS_OUTPUT.PUT_LINE('nuCupon '||nuCupon||' sbFlagDpat '||sbFlagDpat||' sbFlagDcot '||sbFlagDcot||' inucate '||inucate);
    -- IF nuCupon IS NOT NULL THEN
      IF sbFlagDpat = 'N' THEN
          IF sbFlagDcot = 'N' THEN
              IF cuValorNota%ISOPEN THEN
                 CLOSE cuValorNota;
              END IF;
              --se captura valor nota
              OPEN cuValorNota;
              FETCH cuValorNota INTO nuValorPago, nuvalornota;
              CLOSE cuValorNota;
          ELSE
              --se consulta valor total consumo mes subsidios
              IF cuValorNotaCon%ISOPEN THEN
                 CLOSE cuValorNotaCon;
              END IF;

              OPEN cuValorNotaCon;
              FETCH cuValorNotaCon INTO nuValorPago, nuvalornota;
              CLOSE cuValorNotaCon;

          END IF;

        IF nuvalornota > 0 THEN

			IF cugetConceGas%ISOPEN THEN
			   CLOSE cugetConceGas;
			END IF;
			OPEN cugetConceGas;
			FETCH cugetConceGas INTO nuconcdesgas;
			CLOSE cugetConceGas;
			--Genera nota
			proGeneraNota(nuconcdesgas, nuvalornota, nuValorPago , inuNuse, inuCuenta, nuError,  sbError);
			 IF nuError <> 0 THEN
					prInsertLog( inuFactura,
								 inuNuse,
								 'PRGENENOTAPPPAGO',
								  31||' - '|| osberror);
					OnuError := nuError;
					OsbError := sbError;

				END IF;
		 END IF;
      ELSE
          --nuvalornota :=  ROUND( nuValorPago * (nuPorcDesc /100),0);
		  IF inucate = 1 THEN
			 --FOR regCon IN cuSaldoConceR LOOP
			  --DBMS_OUTPUT.PUT_LINE('concepto '||regCon.concepto);
			   --Genera nota
				proGeneraNota(inuConcepto, inuValorDesc, inuValor, inuNuse, inuCuenta, nuError,  sbError) ;
			   IF nuError <> 0 THEN
					prInsertLog( inuFactura,
								 inuNuse,
								 'PRGENENOTAPPPAGO',
								  inuConcepto||' - '|| osberror);
					OnuError := nuError;
					OsbError := sbError;

				END IF;
		   --END LOOP;
      ELSE
         --FOR regCon IN cuSaldoConceNR LOOP
         --Genera nota
            proGeneraNota(inuConcepto, inuValorDesc, inuValor, inuNuse, inuCuenta, nuError,  sbError) ;

            IF nuError <> 0 THEN
                prInsertLog( inuFactura,
                            inuNuse,
                             'PRGENENOTAPPPAGO',
                              inuConcepto||' - '|| osberror);
                OnuError := nuError;
                OsbError := sbError;

            END IF;
       --END LOOP;
      END IF;

      END IF;

--    END IF;

 exception
  WHEN EX.CONTROLLED_ERROR THEN
   ERRORS.geterror(onuError,osbError);
  -- DBMS_OUTPUT.PUT_LINE('NO CONTROLADO '||osbError);
  WHEN OTHERS THEN
     ERRORS.SETERROR;
     ERRORS.geterror(onuError,osbError);
    -- DBMS_OUTPUT.PUT_LINE('NO CONTROLADO '||osbError);

 END prgeneraNotas;
 PROCEDURE prGeneNotapppago IS
 /**************************************************************************
  Proceso     : prGeneNotapppago
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-29-03
  Ticket      :
  Descripcion : genera nota de productos por pronto pago

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
  nuparano   NUMBER;
  nuparmes   NUMBER;
  nutsess    NUMBER;
  sbparuser  VARCHAR2(4000);
  nuerror    NUMBER;
  osberror   VARCHAR2(4000);
  nuPeriante   NUMBER;

  nuDias       NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUDICACO', NULL);-- se almacena el numero de dias a revisar
  sbFlagDpat   VARCHAR2(1) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGDPTC',NULL); --se almacena flga si aplica descuento para todo el pago
  sbEstrato    VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTRAPROC',NULL); --se almacena codigo de estratos
  sbCategoria  VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CATEPROC',NULL);
  sbFlagDefac  VARCHAR2(1) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGDAFA',NULL); --indica si el descuento es factura actua o todas
  sbFlagOtCoEjec  VARCHAR2(1) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGFEOC', NULL); --se almacena flag para ejecucion de otros
  nuPeriodoDe  NUMBER :=  DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUPEREFCO', NULL);-- numero de periodos a refinanciar
  dtFechaven  date;
  NUCAUSCAR    NUMBER := dald_parameter.fnugetnumeric_value('LDC_CACARECU',null);
  nuPeriCons   NUMBER;
  nuFactura    number;
  dtFechaIni   DATE;
  dtFechapago   DATE;
  nuPorcDesc   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PRDESPRPA', NULL);-- se almacena porcentaje de descuento


  TYPE typRefCursor IS REF CURSOR;
  VcuFacturaSinSaldo typRefCursor;



  --se obtienen periodos a procesar
  CURSOR cuPeriodos IS
  SELECT pefafimo, pefaffmo, pefacicl, pefacodi, pefafepa
  FROM perifact
  WHERE ( trunc(pefafepa) + nuDias ) = TRUNC(SYSDATE);


   --se obtienen periodos a procesar dia antes de la fecha final
  CURSOR cuPeriodosFF IS
  SELECT pefafimo, pefaffmo, pefacicl, pefacodi, pefafepa
  FROM perifact
  WHERE ( trunc(pefaffmo) - TRUNC(SYSDATE) ) = nuDias;

  --se obtiene periodo anterior
  CURSOR cuperiodoant(inuciclo NUMBER, idtFeIniMov DATE) IS
  SELECT *
  FROM (SELECT --+ INDEX_DESC (PERIFACT IX_PEFA_CICL_FFMO)
          pefacodi, pefafimo, pefafepa
        FROM PERIFACT
        WHERE PEFAFFMO < idtFeIniMov
         AND PEFACICL = inuciclo
        ORDER BY PEFAFFMO desc)
   WHERE ROWNUM < 2;

  --se consultas todas las cuentas sin sado del periodo anterior
  CURSOR cuFacturaSinSaldo( nuPeriodo NUMBER) IS
  SELECT *
  FROM (
        SELECT /*+ index(f IX_FACTURA04) */
              f.factsusc,
              f.factcodi,
              s.sesucate,
            s.sesucicl,
            (select cucofeve from cuencobr c where c.cucofact = factcodi and rownum < 2) fecha_venc
        FROM factura f, suscripc co, servsusc s
        WHERE  f.factpefa =  nuPeriodo
          AND f.factprog = 6
          AND f.factsusc = co.susccodi
          AND s.sesususc = co.susccodi
          AND s.sesuserv = 7014
          --and f.factcodi in ( 2052319154)
          AND s.sesucate IN ( SELECT to_number(regexp_substr(sbCategoria,'[^,]+', 1, LEVEL)) AS estacort
                      FROM dual
                    CONNECT BY regexp_substr(sbCategoria, '[^,]+', 1, LEVEL) IS NOT NULL
                    )
          AND s.sesusuca IN ( SELECT to_number(regexp_substr(sbEstrato,'[^,]+', 1, LEVEL)) AS estacort
                      FROM dual
                    CONNECT BY regexp_substr(sbEstrato, '[^,]+', 1, LEVEL) IS NOT NULL
                    )
            AND NOT EXISTS (SELECT 1 FROM LDC_PRCOPPPA pf WHERE pf.PCPPFACT = f.factcodi)
            AND ( 0 = ( SELECT count(1)
                       FROM cuencobr cu
                       WHERE ( nvl(cu.cucosacu,0) > 0
                              OR ( nvl(cu.cucosacu,0) = 0
                                AND  EXISTS ( SELECT 1
											  FROM CARGOS CA
											  WHERE CA.CARGCUCO = CU.CUCOCODI
  											    AND CA.CARGCACA = NUCAUSCAR
												AND CA.CARGCONC NOT IN (select ticoconc
																		from OPEN.ldc_tiprodcondes )
														)))
                        AND f.factcodi = cu.cucofact)
            or 0 = ( SELECT count(1)
                      FROM cuencobr cu
                      WHERE ( nvl(cu.cucosacu,0) > 0
                              OR ( nvl(cu.cucosacu,0) = 0
                                AND  EXISTS ( SELECT 1
											  FROM CARGOS CA
											  WHERE CA.CARGCUCO = CU.CUCOCODI
											   AND CA.CARGCACA = NUCAUSCAR
											   AND CA.CARGCONC NOT IN ( select ticoconc
																		from OPEN.ldc_tiprodcondes ) ))
											  )
                         AND f.factcodi = cu.cucofact
                         AND cu.cuconuse = s.sesunuse)  )

     )
   ;-- WHERE CUPON IS NOT NULL;

	type tblfacturaSinSaldo IS TABLE OF cuFacturaSinSaldo%ROWTYPE;
	vtblfacturaSinSaldo tblfacturaSinSaldo;

  --se consulta cupon de pago
  CURSOR cugetCuponPago(inuFactura NUMBER) IS
  SELECT cargcodo
  FROM cargos, cuencobr
  WHERE cargcuco = cucocodi
   AND cucofact = inuFactura
   AND cargsign = 'PA'
  ORDER BY cargfecr desc;

  nuCuponPago NUMBER;

  --se obtiene cuentas afectadas
  CURSOR cuGetCuentAfect( inufactura NUMBER, idtFeIniMov DATE, inuciclo NUMBER, nucupon number) IS
  SELECT CARGCUCO,
		 CARGNUSE,
		 CUCOFEVE,
		 cupon,
		 concepto,
		 SUM(valor) valor,
		 SUM(valor_DESC) valor_DESC
  FROM (
	  SELECT CARGCUCO,
			CARGNUSE,
			CUCOFEVE,
			cargcodo cupon,
			cargvalo valor,
			round(CARGVALO * (nuPorcDesc/100), 0) valor_DESC,
		   (select ticoconc from ldc_tiprodcondes where ticoserv = SESUSERV) concepto
	  FROM CARGOS, cuencobr, factura f, perifact, SERVSUSC
	  WHERE CARGSIGN ='PA'
	   and cargcodo = nucupon
	   and cargcuco = cucocodi
	   and cucofact = f.factcodi
	   and pefacodi = factpefa
	   and sesunuse = cargnuse
	   and f.factcodi = decode(inufactura, -1, factcodi, inufactura)
	   and f.factpefa in (  SELECT pefacodi
						  FROM ( SELECT --+ INDEX_DESC (PERIFACT IX_PEFA_CICL_FFMO)
								  pefacodi
								FROM PERIFACT
								WHERE PEFAFFMO < idtFeIniMov
								 AND PEFACICL = inuciclo
								ORDER BY PEFAFFMO desc)
						   WHERE ROWNUM <=  nuPeriodoDe))

  group by CARGCUCO,
		 CARGNUSE,
		 CUCOFEVE,
		 cupon,
		 concepto
   HAVING  SUM(valor_DESC) > 0;

  --se consulta facturas de gas sin sado del periodo anterior
  CURSOR cuFacturaGassinsaldo( nuPeriodo NUMBER) IS
  SELECT *
  FROM (
        SELECT /*+ index( cu IDXCUCO_RELA)
                index(f IX_FACTURA04) */
             f.factsusc,
             f.factcodi,
             cu.cucocodi,
             cu.cucofeve,
             cu.cuconuse,
             cu.cucovaab,
           S.SESUCATE/*,
           ( SELECT CUPONUME
              FROM CUPON
            WHERE CUPODoCU = TO_CHAR(F.FACTCODI)
              AND CUPOSUSC = F.FACTSUSC
            AND CUPOFLPA = 'S'
            AND ROWNUM < 2 ) CUPON*/
        FROM cuencobr cu, factura f, SERVSUSC S
        WHERE  f.factpefa =  nuPeriodo
         AND f.factcodi = cu.cucofact
          AND nvl(cucosacu,0)  =0
          AND f.factprog = 6
          AND s.sesunuse = cu.cuconuse
          AND s.sesuserv = 7014
          AND s.sesucate IN ( SELECT to_number(regexp_substr(sbCategoria,'[^,]+', 1, LEVEL)) AS estacort
                    FROM dual
                  CONNECT BY regexp_substr(sbCategoria, '[^,]+', 1, LEVEL) IS NOT NULL
                  )
          AND s.sesusuca IN (  SELECT to_number(regexp_substr(sbEstrato,'[^,]+', 1, LEVEL)) AS estacort
                              FROM dual
                              CONNECT BY regexp_substr(sbEstrato, '[^,]+', 1, LEVEL) IS NOT NULL
                               )
           AND NOT EXISTS (SELECT 1 FROM LDC_PRCOPPPA pf WHERE pf.PCPPFACT = f.factcodi))
     ;--WHERE CUPON is not null;


   nuproducto number;
   nucuenta   number;
  limit_in number := 100;

  BEGIN
  UT_TRACE.TRACE('[PRGENENOTAPPPAGO] INIICO ',10);
  IF fblaplicaentregaxcaso('0000379') THEN
      -- Obtenemos datos para realizar ejecucion
      SELECT  to_number(to_char(SYSDATE,'YYYY')),
                to_number(to_char(SYSDATE,'MM')),
                userenv('SESSIONID'),
                USER
      INTO nuparano,nuparmes,nutsess,sbparuser
      FROM dual;

      -- Start log program
      ldc_proinsertaestaprog(nuparano,nuparmes,'PRGENENOTAPPPAGO','En ejecucion',nutsess,sbparuser);
    --dbms_output.put_line('inicio sbFlagOtCoEjec '||sbFlagOtCoEjec);
    IF sbFlagOtCoEjec = 'N' THEN
      FOR reg IN cuPeriodos LOOP
         IF sbFlagDpat = 'S' THEN
           --open cuFacturaSinSaldo(REG.PEFACODI);
           open VcuFacturaSinSaldo FOR  ' SELECT *
										  FROM (
												SELECT
													  f.factsusc,
													  f.factcodi,
													  s.sesucate,
													s.sesucicl,
													(select cucofeve from cuencobr c where c.cucofact = factcodi and rownum < 2) fecha_venc
												FROM factura f, suscripc co, servsusc s
												WHERE  f.factpefa =  '||REG.PEFACODI||'
												  AND f.factprog = 6
												  AND f.factsusc = co.susccodi
												  AND s.sesususc = co.susccodi
												  AND s.sesuserv = 7014
												  AND s.sesucate IN ( '||sbCategoria||'	)
												  AND s.sesusuca IN ( '||sbEstrato||' )
													AND NOT EXISTS (SELECT 1 FROM LDC_PRCOPPPA pf WHERE pf.PCPPFACT = f.factcodi)
													AND ( 0 = ( SELECT count(1)
															   FROM cuencobr cu
															   WHERE ( nvl(cu.cucosacu,0) > 0
																	  OR ( nvl(cu.cucosacu,0) = 0
																		AND  EXISTS ( SELECT 1
																					  FROM CARGOS CA
																					  WHERE CA.CARGCUCO = CU.CUCOCODI
																						AND CA.CARGCACA = '||NUCAUSCAR||'
																						AND CA.CARGCONC NOT IN (select ticoconc
																												from OPEN.ldc_tiprodcondes )
																								)))
																AND f.factcodi = cu.cucofact)
													or 0 = ( SELECT count(1)
															  FROM cuencobr cu
															  WHERE ( nvl(cu.cucosacu,0) > 0
																	  OR ( nvl(cu.cucosacu,0) = 0
																		AND  EXISTS ( SELECT 1
																					  FROM CARGOS CA
																					  WHERE CA.CARGCUCO = CU.CUCOCODI
																					   AND CA.CARGCACA = '||NUCAUSCAR||'
																					   AND CA.CARGCONC NOT IN ( select ticoconc
																												from OPEN.ldc_tiprodcondes ) ))
																					  )
																 AND f.factcodi = cu.cucofact
																 AND cu.cuconuse = s.sesunuse)  )

											 )
											';

		   loop
		      FETCH VcuFacturaSinSaldo BULK COLLECT INTO vtblfacturaSinSaldo LIMIT limit_in;
                 FOR idx IN 1..vtblfacturaSinSaldo.COUNT LOOP
		   --FOR regf IN cuFacturaSinSaldo(REG.PEFACODI) LOOP
                prInsertLog( vtblfacturaSinSaldo(idx).factcodi,
							  vtblfacturaSinSaldo(idx).factsusc,
							  'PRGENENOTAPPPAGO',
							  'PROCESANDO USUARIO');

				       nuerror := NULL;
                osberror := NULL;
                nuFactura := null;
                nuCuponPago := NULL;

                IF cugetCuponPago%ISOPEN THEN
                  CLOSE cugetCuponPago;
                END IF;

                OPEN cugetCuponPago(vtblfacturaSinSaldo(idx).factcodi);
                FETCH cugetCuponPago INTO nuCuponPago;
                CLOSE cugetCuponPago;
                --se valida si descuento aplica a factura actual
                IF sbFlagDefac = 'S' THEN
                   nuFactura := vtblfacturaSinSaldo(idx).factcodi;
                ELSE
                   nuFactura := -1;
                END IF;

			  	   FOR regCuen IN cuGetCuentAfect( nuFactura, reg.pefafimo, REG.PEFACICL,  nuCuponPago) LOOP

                    prgeneraNotas( vtblfacturaSinSaldo(idx).factsusc,
                                   regCuen.CARGCUCO,--regCuen.cargcuco,
                                   vtblfacturaSinSaldo(idx).fecha_venc,
                                   regCuen.CUCOFEVE,
                                   regCuen.CARGNUSE,--regCuen.cargnuse,
                                   reg.pefacodi,
                                   vtblfacturaSinSaldo(idx).factcodi,
                                   vtblfacturaSinSaldo(idx).sesucicl,
                                   regCuen.CUPON,
                                   vtblfacturaSinSaldo(idx).SESUCATE,
                                   regCuen.valor,
                                   regCuen.valor_DESC,
                                   regCuen.concepto,
                                   nuerror,
                                   osberror) ;
                   IF nuerror = 0 THEN
                       COMMIT;
                   ELSE
                     ROLLBACK;
                     prInsertLog( vtblfacturaSinSaldo(idx).factcodi,
                          vtblfacturaSinSaldo(idx).factsusc,
                          'PRGENENOTAPPPAGO',
                          osberror);
                   END IF;
               END LOOP;
                END LOOP;
			   EXIT WHEN VcuFacturaSinSaldo%NOTFOUND;
			 END LOOP;
			 CLOSE VcuFacturaSinSaldo;
           ELSE
              FOR regfi IN cuFacturaGassinsaldo(REG.PEFACODI) LOOP
                 nuerror := NULL;
                osberror := NULL;
                 prInsertLog( regfi.factcodi,
							  regfi.factsusc,
							  'PRGENENOTAPPPAGO',
							  'PROCESANDO USUARIO');
							   nuerror := NULL;
                osberror := NULL;
                nuFactura := null;

                nuCuponPago := NULL;

                IF cugetCuponPago%ISOPEN THEN
                  CLOSE cugetCuponPago;
                END IF;

                OPEN cugetCuponPago(regfi.factcodi);
                FETCH cugetCuponPago INTO nuCuponPago;
                CLOSE cugetCuponPago;

                --se valida si descuento aplica a factura actual
                IF sbFlagDefac = 'S' THEN
                   nuFactura := regfi.factcodi;
                ELSE
                   nuFactura := -1;
                END IF;

			  	      FOR regCuen IN cuGetCuentAfect( nuFactura, reg.pefafimo, REG.PEFACICL, nuCuponPago) LOOP

                    prgeneraNotas( regfi.factsusc,
                                     regfi.cucocodi,
                                     regfi.cucofeve,
                                     regfi.cucofeve,
                                     regfi.cuconuse,
                                     reg.pefacodi,
                                     regfi.factcodi,
                                     REG.PEFACICL,
                                     regCuen.CUPON,
                                     REGFI.SESUCATE,
                                     regCuen.valor,
                                     regCuen.valor_DESC,
                                     regCuen.concepto,
                                     nuerror,
                                     osberror) ;
                    IF nuerror = 0 THEN
                       COMMIT;
                    ELSE
                      ROLLBACK;
                      prInsertLog( regfi.factcodi,
                                    regfi.cuconuse,
                                    'PRGENENOTAPPPAGO',
                                    osberror);
                     END IF;
                 END LOOP;
              END LOOP;
           END IF;
        END LOOP;
   ELSE
      FOR reg IN cuPeriodosff LOOP
        nuperiante := NULL;
        dtFechapago := NULL;
        dtFechaIni := NULL;
       IF cuperiodoant%ISOPEN THEN
           CLOSE cuperiodoant;
       END IF;
       --
       OPEN cuperiodoant(reg.pefacicl, reg.pefafimo);
       FETCH cuperiodoant INTO nuperiante, dtFechaIni, dtFechapago;
       CLOSE cuperiodoant;

         IF sbFlagDpat = 'S' THEN
           --open cuFacturaSinSaldo(nuperiante);
		   open VcuFacturaSinSaldo FOR  ' SELECT *
										  FROM (
												SELECT
													  f.factsusc,
													  f.factcodi,
													  s.sesucate,
													s.sesucicl,
													(select cucofeve from cuencobr c where c.cucofact = factcodi and rownum < 2) fecha_venc
												FROM factura f, suscripc co, servsusc s
												WHERE  f.factpefa =  '||nuperiante||'
												  AND f.factprog = 6
												  AND f.factsusc = co.susccodi
												  AND s.sesususc = co.susccodi
												  AND s.sesuserv = 7014
												  AND s.sesucate IN ( '||sbCategoria||'	)
												  AND s.sesusuca IN ( '||sbEstrato||' )
													AND NOT EXISTS (SELECT 1 FROM LDC_PRCOPPPA pf WHERE pf.PCPPFACT = f.factcodi)
													AND ( 0 = ( SELECT count(1)
															   FROM cuencobr cu
															   WHERE ( nvl(cu.cucosacu,0) > 0
																	  OR ( nvl(cu.cucosacu,0) = 0
																		AND  EXISTS ( SELECT 1
																					  FROM CARGOS CA
																					  WHERE CA.CARGCUCO = CU.CUCOCODI
																						AND CA.CARGCACA = '||NUCAUSCAR||'
																						AND CA.CARGCONC NOT IN (select ticoconc
																												from OPEN.ldc_tiprodcondes )
																								)))
																AND f.factcodi = cu.cucofact)
													or 0 = ( SELECT count(1)
															  FROM cuencobr cu
															  WHERE ( nvl(cu.cucosacu,0) > 0
																	  OR ( nvl(cu.cucosacu,0) = 0
																		AND  EXISTS ( SELECT 1
																					  FROM CARGOS CA
																					  WHERE CA.CARGCUCO = CU.CUCOCODI
																					   AND CA.CARGCACA = '||NUCAUSCAR||'
																					   AND CA.CARGCONC NOT IN ( select ticoconc
																												from OPEN.ldc_tiprodcondes ) ))
																					  )
																 AND f.factcodi = cu.cucofact
																 AND cu.cuconuse = s.sesunuse)  )

											 )';


		    loop
		      FETCH VcuFacturaSinSaldo BULK COLLECT INTO vtblfacturaSinSaldo LIMIT limit_in;
                 FOR idx IN 1..vtblfacturaSinSaldo.COUNT LOOP
		   --FOR regf IN cuFacturaSinSaldo(nuperiante) LOOP
					nuerror := NULL;
					osberror := NULL;
					nuFactura := null;

					 prInsertLog( vtblfacturaSinSaldo(idx).factcodi,
							  vtblfacturaSinSaldo(idx).factsusc,
							  'PRGENENOTAPPPAGO',
							  'PROCESANDO USUARIO');

             nuCuponPago := NULL;

              IF cugetCuponPago%ISOPEN THEN
                CLOSE cugetCuponPago;
              END IF;

              OPEN cugetCuponPago( vtblfacturaSinSaldo(idx).factcodi);
              FETCH cugetCuponPago INTO nuCuponPago;
              CLOSE cugetCuponPago;

            --se valida si descuento aplica a factura actual
            IF sbFlagDefac = 'S' THEN
               nuFactura := vtblfacturaSinSaldo(idx).factcodi;
            ELSE
               nuFactura := -1;
            END IF;
        	FOR regCuen IN cuGetCuentAfect( nuFactura, reg.pefafimo, reg.pefacicl,nuCuponPago ) LOOP

						prgeneraNotas( vtblfacturaSinSaldo(idx).factsusc,
								 regCuen.CARGCUCO,--regCuen.cargcuco,
							   vtblfacturaSinSaldo(idx).fecha_venc,
							   regCuen.CUCOFEVE,
								regCuen.CARGNUSE,--regCuen.cargcuco,
							   nuperiante,
							   vtblfacturaSinSaldo(idx).factcodi,
							   vtblfacturaSinSaldo(idx).sesucicl,
							   regCuen.CUPON,
							   vtblfacturaSinSaldo(idx).SESUCATE,
                 regCuen.valor,
                 regCuen.valor_DESC,
                 regCuen.concepto,
							   nuerror,
							   osberror) ;
					   IF nuerror = 0 THEN
						   COMMIT;
					   ELSE
						 ROLLBACK;
						 prInsertLog( vtblfacturaSinSaldo(idx).factcodi,
							  vtblfacturaSinSaldo(idx).factsusc,
							  'PRGENENOTAPPPAGO',
							  osberror);
					   END IF;
				    END LOOP;
				END LOOP;
			   EXIT WHEN VcuFacturaSinSaldo%NOTFOUND;
			 END LOOP;
			 CLOSE VcuFacturaSinSaldo;
           ELSE
              FOR regfi IN cuFacturaGassinsaldo(nuperiante) LOOP
                 nuerror := NULL;
                osberror := NULL;
                nuFactura := NULL;
                 prInsertLog( regfi.factcodi,
                              regfi.factsusc,
                              'PRGENENOTAPPPAGO',
                              'PROCESANDO USUARIO');

                 IF sbFlagDefac = 'S' THEN
                   nuFactura := regfi.factcodi;
                ELSE
                   nuFactura := -1;
                END IF;
                 nuCuponPago := NULL;

                IF cugetCuponPago%ISOPEN THEN
                  CLOSE cugetCuponPago;
                END IF;

                OPEN cugetCuponPago(regfi.factcodi);
                FETCH cugetCuponPago INTO nuCuponPago;
                CLOSE cugetCuponPago;

			  	      FOR regCuen IN cuGetCuentAfect( nuFactura, reg.pefafimo, REG.PEFACICL, nuCuponPago) LOOP

                    prgeneraNotas( regfi.factsusc,
                                     regfi.cucocodi,
                                     regfi.cucofeve,
                                     regfi.cucofeve,
                                     regfi.cuconuse,
                                     reg.pefacodi,
                                     regfi.factcodi,
                                     REG.PEFACICL,
                                     regCuen.CUPON,
                                     REGFI.SESUCATE,
                                     regCuen.valor,
                                     regCuen.valor_DESC,
                                     regCuen.concepto,
                                     nuerror,
                                     osberror) ;
                    IF nuerror = 0 THEN
                       COMMIT;
                    ELSE
                      ROLLBACK;
                      prInsertLog( regfi.factcodi,
                                    regfi.cuconuse,
                                    'PRGENENOTAPPPAGO',
                                    osberror);
                     END IF;
                 END LOOP;
              END LOOP;
           END IF;
        END LOOP;
   END IF;
      ldc_proactualizaestaprog(nutsess,osberror,'PRGENENOTAPPPAGO','Ok.');
  END IF;
  UT_TRACE.TRACE('[PRGENENOTAPPPAGO] FIN ',10);
 exception
  WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror,osberror);
      ldc_proactualizaestaprog(nutsess,osberror,'PRGENENOTAPPPAGO','error');
    WHEN OTHERS THEN
       ERRORS.SETERROR;
       ERRORS.geterror(nuerror,osberror);
       ldc_proactualizaestaprog(nutsess,osberror,'PRGENENOTAPPPAGO','error');
 END prGeneNotapppago;

 PROCEDURE prFinanConcCuen( inuCuenta   IN NUMBER,
                            inufactura IN NUMBER,
                            inucate     in cuencobr.cucocate%type,
                            inusuca     in cuencobr.cucosuca%type,
                            idtFechVec  IN DATE,
                            inuCupon    IN NUMBER,
                            inucuensaldo in number,
                            sbConcepto  IN VARCHAR2,
                            inuValorAbo IN NUMBER,
                            nuValorRecl IN NUMBER,
                            inuProducto IN NUMBER,
                            inuPeriodo  IN NUMBER,
                            isbTotConc  IN OUT VARCHAR2,
                            inusaldo    IN NUMBER) IS
  /**************************************************************************
    Proceso     : prFinanConcCuen
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-29-03
    Ticket      :
    Descripcion : genera financiacion de cuenta

    Parametros Entrada
      inuCuenta   numero de de cuenta
      inuCupon    numero de cuponume
      sbConceptos  concepto a liquidar
      isbTotConc  total concepto
      idtFechVec   fecha de vencimiento
      inucate     categoria
      inusuca     subcategoria
      inuValorAbo valor abono
      nuValorRecl  valor reclamo
      inuProducto  producto
      inuPeriodo  perioddo
    inusaldo   saldo de la cuenta
    Parametros de salida


    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  nuPlanFin    NUMBER;
   sbConcExcl   VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CONADIF36',NULL); --se almacena conceptos a diferir a 36
  nuCupon      NUMBER;
  nuExiste     NUMBER;
  nuCuotas     NUMBER;
  inuCausal    NUMBER  :=  dald_parameter.fnugetnumeric_value('LDC_CACARECU',null);--se almacena cuasal  para generar cargos

     --se consultan conceptos abonados y reclamos
    CURSOR cuGetConceRecAbo IS
    WITH valor_db AS
  ( SELECT sum(valor) valor
    FROM (
       SELECT sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
           )

       GROUP BY concepto
     HAVING sum(valor) > 0) ) ,
  valor_cr AS
  ( SELECT sum(valor)*-1 valor
    FROM (
      SELECT  sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
          )

       GROUP BY concepto
       HAVING sum(valor) < 0 ))
    SELECT   concepto,
           round(valor - (valor*(SELECT nvl(valor,0) FROM valor_cr)*100/(SELECT nvl(valor,0) FROM valor_db)/100),0) valor,
            ROWNUM fila,
            MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
    FROM (
    SELECT concepto, valor
    FROM (
        SELECT concepto, sum(valor) valor
        FROM (
            SELECT  concepto, sum(valor) valor
            FROM (
              SELECT decode(cr.catrconc,196,31,cr.catrconc) concepto, decode(catrsign, 'DB',-cr.catrvare,cr.catrvare)  valor
              FROM OPEN.cargtram cr, OPEN.mo_motive m, OPEN.mo_packages s
              WHERE cr.catrcuco = inucuenta
               AND cr.catrmoti = m.motive_id
               AND m.package_id  = s.package_id
               AND s.motive_status_id = 13
              UNION ALL
              SELECT decode(c.cargconc, 196, 31, c.cargconc), decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
              FROM OPEN.cargos c
              WHERE cargcuco = inucuenta
               and cargsign IN ('DB', 'CR'))
            GROUP BY concepto
            HAVING sum(valor) > 0
            UNION ALL
            SELECT rereconc,
               (sum(rerevalo) * -1) valor
            FROM (
            SELECT factsusc, factcodi, factfege, rerecupo, rereconc, cucocodi, cucovato, cucosacu, rerevalo , rerefeve, sesunuse, sesuserv
            FROM (SELECT rerecupo,DECODE(rereconc, 196, 31,rereconc) rereconc,RERESERV,trunc(rerefeve) rerefeve, sum(rerevalo) rerevalo
                FROM OPEN.resureca r
                 WHERE r.rerecupo = inucupon
                GROUP BY rerecupo,RERESERV,rereconc,trunc(rerefeve)) r,  OPEN.cupon c, OPEN.servsusc s, OPEN.cuencobr cc, OPEN.factura f
             WHERE rerecupo = cuponume
             AND cuposusc = sesususc
             AND sesunuse = cuconuse
             AND cucofact = factcodi
             and sesuserv = RERESERV
			  and rereconc not in (select ticoconc
									from open.ldc_tiprodcondes
									where ticoserv = sesuserv)
             and sesunuse = inuProducto
             AND rerefeve = trunc(idtFechVec)
             AND (SELECT 'x' FROM OPEN.cargos WHERE cargcuco=cucocodi AND cargsign='PA' AND cargcodo=rerecupo) = 'x'
             )
            WHERE cucocodi = inucuenta
            GROUP BY rereconc
            HAVING sum(rerevalo) > 0
            )
        WHERE DECODE(sbConcepto, '-1', concepto, '1', concepto, INSTR(','||sbConcepto||',',','||concepto||',' ) ) > 0
            AND concepto <> (CASE WHEN sbConcepto = '1' THEN 31 ELSE 0 END)
        GROUP BY concepto
          HAVING sum(valor) > 0)
    ORDER BY VALOR);

   --se consultan conceptos  reclamos
    CURSOR cuGetConceReclamo IS
    WITH valor_db AS
  ( SELECT sum(valor) valor
    FROM (
       SELECT sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
           )

       GROUP BY concepto
     HAVING sum(valor) > 0) ) ,
  valor_cr AS
  ( SELECT sum(valor)*-1 valor
    FROM (
      SELECT  sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
          )

       GROUP BY concepto
       HAVING sum(valor) < 0 ))
    SELECT   causal,
            concepto,
            round(valor - (valor*(SELECT nvl(valor,0) FROM valor_cr)*100/(SELECT nvl(valor,0) FROM valor_db)/100),0) valor,
            ROWNUM fila,
            MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
    FROM (
      SELECT causal, concepto,  valor
      FROM(
        SELECT causal, concepto, sum(valor) valor
        FROM (
            SELECT  causal, concepto, sum(valor) valor
            FROM (
              SELECT  (CASE WHEN catrconc in (31,17, 196) and cr.CATRCACA in (15,62) /*and isbTotConc = 'N'*/ then 1 else 0 end)  causal, decode(cr.catrconc,196,31,cr.catrconc) concepto, decode(catrsign, 'DB',-cr.catrvare,cr.catrvare)  valor
              FROM OPEN.cargtram cr, OPEN.mo_motive m, OPEN.mo_packages s
              WHERE cr.catrcuco = inucuenta
               AND cr.catrmoti = m.motive_id
               AND m.package_id  = s.package_id
               AND s.motive_status_id = 13
             -- and CATRCACA = DECODE(isbTotConc, 'N', 15, CATRCACA)
              UNION ALL
              SELECT  (CASE WHEN cargconc in (31,17, 196) and cargcaca in (15,62)/*and isbTotConc = 'N'*/ then 1 else 0 end)  causal, decode(c.cargconc, 196, 31, c.cargconc), decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
              FROM OPEN.cargos c
              WHERE cargcuco = inucuenta
              and cargsign IN ('DB', 'CR')
            --   and cargcaca = DECODE(isbTotConc, 'N', 15, cargcaca)
            )
           WHERE DECODE(sbConcepto, '-1', concepto, '1', concepto, INSTR(','||sbConcepto||',',','||concepto||',' ) ) > 0
          AND concepto <> (CASE WHEN sbConcepto = '1' THEN 31 ELSE 0 END)
          GROUP BY concepto, causal
            HAVING sum(valor) > 0)
        GROUP BY concepto, causal
           HAVING sum(valor) > 0)
    ORDER BY VALOR);


     --se consultan conceptos abonados
        --se consultan conceptos abonados
    CURSOR cuGetConceAbono IS
    WITH valor_db AS
  ( SELECT sum(valor) valor
    FROM (
       SELECT sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
           )

       GROUP BY concepto
     HAVING sum(valor) > 0) ) ,
  valor_cr AS
  ( SELECT sum(valor)*-1 valor
    FROM (
      SELECT  sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
          )

       GROUP BY concepto
       HAVING sum(valor) < 0 ))
    SELECT   concepto,
            round(valor - (valor*(SELECT nvl(valor,0) FROM valor_cr)*100/(SELECT nvl(valor,0) FROM valor_db)/100),0) valor,
            ROWNUM fila,
            MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
    FROM (
         SELECT   concepto, valor
         FROM (
        SELECT concepto, sum(valor) valor
        FROM (
            SELECT  concepto, sum(valor) valor
            FROM (

              SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
              FROM OPEN.cargos c
              WHERE cargcuco = inucuenta
              and cargsign IN ('DB', 'CR'))
            GROUP BY concepto
            HAVING sum(valor) > 0
            UNION ALL
            SELECT rereconc,
               (sum(rerevalo) * -1) valor
            FROM (
            SELECT factsusc, factcodi, factfege, rerecupo, rereconc, cucocodi, cucovato, cucosacu, rerevalo , rerefeve, sesunuse, sesuserv
            FROM (SELECT rerecupo,DECODE(rereconc, 196, 31,rereconc) rereconc,RERESERV, trunc(rerefeve) rerefeve, sum(rerevalo) rerevalo
                FROM OPEN.resureca r
                 WHERE r.rerecupo = inucupon
                GROUP BY rerecupo,rereconc,RERESERV, trunc(rerefeve)) r,  OPEN.cupon c, OPEN.servsusc s, OPEN.cuencobr cc, OPEN.factura f
             WHERE rerecupo = cuponume
             AND cuposusc = sesususc
             AND sesunuse = cuconuse
             AND cucofact = factcodi
             and sesuserv = RERESERV
             and sesunuse = inuProducto
			 and rereconc not in (select ticoconc
									from open.ldc_tiprodcondes
									where ticoserv = sesuserv)

             AND rerefeve = trunc(idtFechVec)
             AND (SELECT 'x' FROM OPEN.cargos WHERE cargcuco=cucocodi AND cargsign='PA' AND cargcodo=rerecupo) = 'x'
             )
            WHERE cucocodi = inucuenta
            GROUP BY rereconc
            HAVING sum(rerevalo) > 0
            )
          WHERE DECODE(sbConcepto, '-1', concepto, '1', concepto, INSTR(','||sbConcepto||',',','||concepto||',' ) ) > 0
          AND concepto <> (CASE WHEN sbConcepto = '1' THEN 31 ELSE 0 END)
          GROUP BY concepto
          HAVING sum(valor) > 0)
          order by valor);

   --se consultan conceptos abonados
   CURSOR cuGetConceptos IS
   WITH valor_db AS
  ( SELECT sum(valor) valor
    FROM (
       SELECT sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
           )

       GROUP BY concepto
     HAVING sum(valor) > 0) ) ,
   valor_cr AS
  ( SELECT sum(valor)*-1 valor
    FROM (
      SELECT  sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
          )

       GROUP BY concepto
       HAVING sum(valor) < 0 ))
    SELECT   causal,
            concepto,
            round(valor - (valor*(SELECT nvl(valor,0) FROM valor_cr)*100/(SELECT nvl(valor,0) FROM valor_db)/100),0) valor,
            ROWNUM fila,
            MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
   FROM (
       SELECT  causal,concepto, valor
       FROM (
         SELECT causal, concepto, sum(valor) valor
         FROM ( SELECT  CASE WHEN cargconc in (31,17, 196) and cargcaca in (15,62) /*and isbTotConc = 'N'*/ then 1 else 0 end  causal, decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
                 FROM OPEN.cargos c
                WHERE cargcuco = inucuenta
                 and cargsign IN ('DB', 'CR')
               --  and cargcaca = DECODE(isbTotConc, 'N', 15, cargcaca)
               )
         WHERE DECODE(sbConcepto, '-1', concepto, '1', concepto, INSTR(','||sbConcepto||',',','||concepto||',' ) ) > 0
           AND concepto <> (CASE WHEN sbConcepto = '1' THEN 31 ELSE 0 END)
         GROUP BY concepto, causal
         HAVING sum(valor) > 0)
        order by valor);

   --se consulta consumo de subsistencia
   CURSOR cuValorConsumo(inuNuse NUMBER) IS
    --SELECT ROUND(SUM((nvl(RALIVAUL,0) - nvl(RALIVASU,0))),0) vaLOR
     WITH valor_db AS
  ( SELECT sum(valor) valor
    FROM (
       SELECT sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
           )

       GROUP BY concepto
     HAVING sum(valor) > 0) ) ,
  valor_cr AS
  ( SELECT sum(valor)*-1 valor
    FROM (
      SELECT  sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
          )

       GROUP BY concepto
       HAVING sum(valor) < 0 ))
	 select round(valor - (valor*(SELECT nvl(valor,0) FROM valor_cr)*100/(SELECT nvl(valor,0) FROM valor_db)/100),0) valor
	 from (
	SELECT SUM(nvl(ROUND(RALIVAUL,0),0) - nvl(ROUND(RALIVASU,0),0)) vaLOR
    FROM RANGLIQU
    WHERE RALISESU = inuNuse
       AND RALIPEFA = inuPeriodo
       AND RALICONC = 31
       AND (( RALILIIR = 0 AND RALILISR = 20 AND inusuca IN (1,2) )
          OR inusuca > 2)
     AND ralipeco =  ( SELECT MAX(re.ralipeco)
                         FROM rangliqu re
                         WHERE re.ralisesu = inuNuse
                           AND re.ralipefa = inuPeriodo
                           AND re.raliconc = 31));

    CURSOR cuAbonoConsu IS
	SELECT (sum(rerevalo) * -1) valor
	FROM (
	SELECT factsusc, factcodi, factfege, rerecupo, rereconc, cucocodi, cucovato, cucosacu, rerevalo , rerefeve, sesunuse, sesuserv
	FROM (SELECT rerecupo,DECODE(rereconc, 196, 31,rereconc) rereconc,RERESERV, trunc(rerefeve) rerefeve, sum(rerevalo) rerevalo
		FROM OPEN.resureca r
		 WHERE r.rerecupo = inucupon
		GROUP BY rerecupo,rereconc,RERESERV, trunc(rerefeve)) r,  OPEN.cupon c, OPEN.servsusc s, OPEN.cuencobr cc, OPEN.factura f
	 WHERE rerecupo = cuponume
	 AND cuposusc = sesususc
	 AND sesunuse = cuconuse
	 AND cucofact = factcodi
	 and sesuserv = RERESERV
	 and rereconc = 31
	 and sesunuse = inuProducto
	 AND rerefeve = trunc(idtFechVec)
	 AND (SELECT 'x' FROM OPEN.cargos WHERE cargcuco=cucocodi AND cargsign='PA' AND cargcodo=rerecupo) = 'x'
	 )
	WHERE cucocodi = inucuenta
	GROUP BY rereconc;

	nuabono NUMBER;

       --se consultan conceptos a procesar
    CURSOR cuGetConceEspec IS
    WITH valor_db AS
  ( SELECT sum(valor) valor
    FROM (
       SELECT sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
           )

       GROUP BY concepto
     HAVING sum(valor) > 0) ) ,
  valor_cr AS
  ( SELECT sum(valor)*-1 valor
    FROM (
      SELECT  sum(valor) valor
       FROM ( SELECT decode(c.cargconc, 196, 31, c.cargconc) concepto, decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
           FROM OPEN.cargos c
          WHERE cargcuco = inucuenta
           AND cargsign IN ('DB', 'CR', 'AS')
          )

       GROUP BY concepto
       HAVING sum(valor) < 0 ))
   SELECT concepto,
          round(valor - (valor*(SELECT nvl(valor,0) FROM valor_cr)*100/(SELECT nvl(valor,0) FROM valor_db)/100),0) valor,
          ROWNUM fila,
          MAX(ROWNUM) OVER (PARTITION BY '1') maxrownum
    FROM(
     SELECT concepto, VALOR
     FROM (
      SELECT concepto,  sum(valor) valor
      FROM (
            SELECT  concepto, sum(valor) valor
            FROM (
                SELECT  decode(cr.catrconc,196,31,cr.catrconc) concepto, decode(catrsign, 'DB',-cr.catrvare,cr.catrvare)  valor
                FROM OPEN.cargtram cr, OPEN.mo_motive m, OPEN.mo_packages s
                WHERE cr.catrcuco = inucuenta
                 AND cr.catrmoti = m.motive_id
                 AND m.package_id  = s.package_id
                 AND s.motive_status_id = 13
                UNION ALL
                SELECT  decode(c.cargconc, 196, 31, c.cargconc), decode(c.cargsign, 'DB', c.cargvalo, - c.cargvalo) valor
                FROM OPEN.cargos c
                WHERE cargcuco = inucuenta
                 and cargsign IN ('DB', 'CR')
                 )
            GROUP BY concepto
            HAVING sum(valor) > 0
            UNION ALL
            SELECT
                   rereconc,
                   (sum(rerevalo) * -1) valor
            FROM (
              SELECT factsusc, factcodi, factfege, rerecupo, rereconc, cucocodi, cucovato, cucosacu, rerevalo , rerefeve, sesunuse, sesuserv
              FROM (SELECT rerecupo,DECODE(rereconc, 196, 31,rereconc) rereconc,trunc(rerefeve) rerefeve, RERESERV, sum(rerevalo) rerevalo
                      FROM OPEN.resureca r
                     WHERE r.rerecupo = inucupon
                    GROUP BY rerecupo,rereconc, RERESERV, trunc(rerefeve)) r,  OPEN.cupon c, OPEN.servsusc s, OPEN.cuencobr cc, OPEN.factura f
             WHERE rerecupo = cuponume
               AND cuposusc = sesususc
               AND sesunuse = cuconuse
               and sesuserv = RERESERV
               AND cucofact = factcodi
               and sesunuse = inuProducto
			   and rereconc not in (select ticoconc
									from open.ldc_tiprodcondes
									where ticoserv = sesuserv)
               AND rerefeve = trunc(idtFechVec)
               AND (SELECT 'x' FROM OPEN.cargos WHERE cargcuco=cucocodi AND cargsign='PA' AND cargcodo=rerecupo) = 'x'
               )
            WHERE cucocodi = inucuenta
            GROUP BY rereconc
            HAVING sum(rerevalo) > 0
            ) det, LDC_CONCDIFE
        WHERE det.concepto = CODICODI
         AND CODIFLAG = 'S'
         AND DECODE(sbConcepto, '-1', concepto, '1', concepto, INSTR(','||sbConcepto||',',','||concepto||',' ) ) > 0
       AND concepto <> (CASE WHEN sbConcepto = '1' THEN 31 ELSE 0 END)
      GROUP BY concepto
        HAVING sum(valor) > 0)
      ORDER BY VALOR);


  nuValor  number;
  onuError   number;
  osberror   varchar2(4000);
  nuSaldoCuen NUMBER := inusaldo;
  nuValiSalCu NUMBER := 0;


 BEGIN

  IF gnucate <> inucate OR gnusuca <> inusuca THEN
    -- Halla valores de parametro
    LeeParametro(inucate,inusuca, sbFlagToCon, sbFlagFiCon, nuPlanFOtroC, nuPlanFCons, nuCuoCons, nuCuoOtrco, onuError,  osberror);
  -- dbms_output.put_line(' ingreso '|| sbFlagToCon||' - '|| sbFlagFiCon||' - '|| nuPlanFOtroC||' - '|| nuPlanFCons||' - '|| nuCuoCons||' - '|| nuCuoOtrco||' - '||osberror);
    IF onuError <> 0 THEN
      RETURN;
    END IF;
    gnucate := inucate;
    gnusuca := inusuca;
  END IF;

 IF sbFlagToCon = 'S' THEN
     IF NVL(nuValorRecl,0) > 0 AND NVL(inuValorAbo,0) > 0 THEN
         -- dbms_output.put_line('valor reclamo abono');
            --se consultan conceptos con abono y con reclamos
            FOR regcon IN cuGetConceRecAbo LOOP
              nuCuotas := NULL;
              nuPlanFin := null;

              nuabono := 0;
        --se valida si existe concepto en exclusion
              SELECT  COUNT(1) INTO nuExiste
              FROM (SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                    FROM dual
                    CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL)
              WHERE conc = regcon.concepto;

              IF nuExiste > 0 THEN
                 nuCuotas :=  nuCuoCons;
                nuPlanFin := nuPlanFCons;
              ELSE
                nuCuotas :=  nuCuoOtrco;
                nuPlanFin := nuPlanFOtroC;
              END IF;
              nuValor := 0;
              nuValiSalCu := 1;
              --se valida si el consumo es de subsistencia
              IF regcon.concepto = 31 AND  (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN

				  IF NVL(inuValorAbo,0) > 0 THEN
				    OPEN cuAbonoConsu;
					FETCH cuAbonoConsu INTO nuabono;
					CLOSE cuAbonoConsu;
				  END IF;
				  IF cuValorConsumo%ISOPEN THEN
                    CLOSE cuValorConsumo;
                  END IF;
                  OPEN cuValorConsumo(inuProducto);
                  FETCH cuValorConsumo INTO nuValor;
                  CLOSE cuValorConsumo;

				  IF (nuabono + nuValor) > 0 THEN
				      nuValor := nuValor + nuabono;
				  END IF;

              ELSE
                nuValor := regcon.VALOR;
              END IF;
			IF (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN

			  nuValiSalCu := 0;
			  if isbTotConc = 'S' THEN
			     isbTotConc := sbFlagFiCon;
			  END IF;
			END IF;
			IF nuValiSalCu = 1 THEN
				nuSaldoCuen := nuSaldoCuen  - nuValor;
				IF nuSaldoCuen <> 0 AND regcon.fila = regcon.maxrownum THEN
				   nuValor := nuValor  + nuSaldoCuen;
				END IF;
			 END IF;
           --   dbms_output.put_line('generar nota '||inucuenta||' - '||regcon.concepto);
              IF NVL(nuValor,0) > 0  THEN

                 --se financia
                  prInsertNota (inucuenta,
                               inuProducto,
                               regcon.concepto,
                               inuCausal,
                               nuValor,
                               'CR', -- DB  CR
                               'S', -- S N
                               nuPlanFin,
                               nuCuotas,
                               inucuensaldo,
                               'GENERACION DE NOTA POR CONTIGENCIA',
                               nusesion,
                               sbUser,
                               dtFechProc,
                               inufactura,
							   isbTotConc);
           END IF;
          END LOOP;
        ELSIF  NVL(nuValorRecl,0) > 0 THEN
            --se consultan conceptos con reclamos
            FOR regrecl IN cuGetConceReclamo LOOP
              nuCuotas := NULL;
             nuPlanFin := null;

              --se valida si existe concepto en exclusion
              SELECT  COUNT(1) INTO nuExiste
              FROM (SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                    FROM dual
                    CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL)
              WHERE conc = regrecl.concepto
                and regrecl.causal = 1;

              IF nuExiste > 0 THEN
                  nuCuotas :=  nuCuoCons;
                  nuPlanFin := nuPlanFCons;
              ELSE
                nuCuotas :=  nuCuoOtrco;
                nuPlanFin := nuPlanFOtroC;
              END IF;
              nuValor := NULL;
              nuValiSalCu := 1;
        --se valida si el consumo es de subsistencia
             IF regrecl.concepto = 31 AND  (sbFlagFiCon = 'N' OR isbTotConc = 'N')   THEN
                IF cuValorConsumo%ISOPEN THEN
                  CLOSE cuValorConsumo;
                END IF;
                OPEN cuValorConsumo(inuproducto);
                FETCH cuValorConsumo INTO nuValor;
                CLOSE cuValorConsumo;

              ELSE
                nuValor := regrecl.VALOR;
              END IF;
        IF (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN
          nuValiSalCu := 0;

			   if isbTotConc = 'S' THEN
			     isbTotConc := sbFlagFiCon;
			  END IF;
        END IF;
			IF nuValiSalCu = 1 THEN
				nuSaldoCuen := nuSaldoCuen  - nuValor;
				IF nuSaldoCuen <> 0 AND regrecl.fila = regrecl.maxrownum THEN
				   nuValor := nuValor  + nuSaldoCuen;
				END IF;
			 END IF;
         --   dbms_output.put_line('generar nota reclamo'||inucuenta||' - '||regrecl.concepto);
               IF NVL(nuValor,0) > 0  THEN

                  --se financia
                  prInsertNota ( inucuenta,
                                 inuProducto,
                                 regrecl.concepto,
                                 inuCausal,
                                 nuValor,
                                 'CR', -- DB  CR
                                 'S', -- S N
                                 nuPlanFin,
                                 nuCuotas,
                                  inucuensaldo,
                                 'GENERACION DE NOTA POR CONTIGENCIA',
                                 nusesion,
                                 sbUser,
                                 dtFechProc,
                                 inufactura,
							   isbTotConc);
                END IF;
            END LOOP;
        ELSIF NVL(inuValorAbo,0) > 0 THEN
             --conceptos con abonos
             FOR regabo IN cuGetConceAbono LOOP
                nuCuotas := NULL;
                nuPlanFin := null;
				nuabono := 0;

                --se valida si existe concepto en exclusion
                SELECT  COUNT(1) INTO nuExiste
                FROM (SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                      FROM dual
                      CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL)
                WHERE conc = regabo.concepto;

                IF nuExiste > 0 THEN
                           nuCuotas :=  nuCuoCons;
                   nuPlanFin := nuPlanFCons;
                  ELSE
                    nuCuotas :=  nuCuoOtrco;
                    nuPlanFin := nuPlanFOtroC;
                  END IF;
                  nuValor := NULL;
                  nuValiSalCu := 1;
                  --se valida si el consumo es de subsistencia
                  IF regabo.concepto = 31 AND  (sbFlagFiCon = 'N' OR isbTotConc = 'N')  THEN
                    IF cuAbonoConsu%ISOPEN THEN
					  CLOSE cuAbonoConsu;
					 END IF;

				    OPEN cuAbonoConsu;
					FETCH cuAbonoConsu INTO nuabono;
					CLOSE cuAbonoConsu;

					 IF cuValorConsumo%ISOPEN THEN
					  CLOSE cuValorConsumo;
					 END IF;

					 OPEN cuValorConsumo(inuProducto);
					 FETCH cuValorConsumo INTO nuValor;
					 CLOSE cuValorConsumo;

					  IF (nuabono + nuValor) > 0 THEN
						  nuValor := nuValor + nuabono;
					  END IF;

                  ELSE
                    nuValor := regabo.VALOR;
                  END IF;

          IF (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN
            nuValiSalCu := 0;

			   if isbTotConc = 'S' THEN
			     isbTotConc := sbFlagFiCon;
			  END IF;
           END IF;
			IF nuValiSalCu = 1 THEN
				nuSaldoCuen := nuSaldoCuen  - nuValor;
				IF nuSaldoCuen <> 0 AND regabo.fila = regabo.maxrownum THEN
				   nuValor := nuValor  + nuSaldoCuen;
				END IF;
			  END IF;
                --   dbms_output.put_line('generar nota abono '||inucuenta||' - '||regabo.concepto);
                IF NVL(nuValor,0) > 0 THEN


                       prInsertNota ( inucuenta,
                                             inuProducto,
                                             regabo.concepto,
                                             inuCausal,
                                             nuValor,
                                             'CR', -- DB  CR
                                             'S', -- S N
                                             nuPlanFin,
                                             nuCuotas,
                                              inucuensaldo,
                                             'GENERACION DE NOTA POR CONTIGENCIA',
                                             nusesion,
                                             sbUser,
                                             dtFechProc,
                                             inufactura,
											 isbTotConc);

        END IF;
            END LOOP;
        ELSE
           --conceptos sin abonos y sin reclamos
           FOR regcosa IN cuGetConceptos LOOP
              nuCuotas := NULL;
              nuPlanFin := null;

              --se valida si existe concepto en exclusion
              SELECT  COUNT(1) INTO nuExiste
              FROM (SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                    FROM dual
                    CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL)
              WHERE conc = regcosa.concepto
                and regcosa.causal = 1;

              IF nuExiste > 0 THEN
                 nuCuotas :=  nuCuoCons;
                 nuPlanFin := nuPlanFCons;
              ELSE
                nuCuotas :=  nuCuoOtrco;
                nuPlanFin := nuPlanFOtroC;
              END IF;

              nuValor := NULL;
              nuValiSalCu := 1;
              --se valida si el consumo es de subsistencia
              IF regcosa.concepto = 31 AND  (sbFlagFiCon = 'N' OR isbTotConc = 'N')    THEN
               IF cuValorConsumo%ISOPEN THEN
                CLOSE cuValorConsumo;
               END IF;
               OPEN cuValorConsumo(inuproducto);
               FETCH cuValorConsumo INTO nuValor;
              CLOSE cuValorConsumo;

             ELSE
              nuValor := regcosa.VALOR;
             END IF;

        IF (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN
          nuValiSalCu := 0;

		   if isbTotConc = 'S' THEN
			     isbTotConc := sbFlagFiCon;
			  END IF;
        END IF;
			IF nuValiSalCu = 1 THEN
				nuSaldoCuen := nuSaldoCuen  - nuValor;
				IF nuSaldoCuen <> 0 AND regcosa.fila = regcosa.maxrownum THEN
				   nuValor := nuValor  + nuSaldoCuen;
				END IF;
			 END IF;
               --   dbms_output.put_line('generar nota concepto '||inucuenta||' - '||regcosa.concepto);
            IF NVL(nuValor,0) > 0  THEN

                --se financia

                prInsertNota ( inucuenta,
                         inuproducto,
                         regcosa.concepto,
                         inuCausal,
                         nuValor,
                         'CR', -- DB  CR
                         'S', -- S N
                         nuPlanFin,
                         nuCuotas,
                          inucuensaldo,
                         'GENERACION DE NOTA POR CONTIGENCIA',
                         nusesion,
                         sbUser,
                         dtFechProc,
                         inufactura,
						 isbTotConc);


       end if;
            END LOOP;
        END IF;
     ELSE
        IF sbFlagFiCon = 'S' THEN

           --se consulta conceptos especificos
           FOR regcoesp IN cuGetConceEspec LOOP
              nuCuotas := NULL;
              nuPlanFin := null;

              --se valida si existe concepto en exclusion
              SELECT  COUNT(1) INTO nuExiste
              FROM (SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                    FROM dual
                    CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL)
              WHERE conc = regcoesp.concepto;

              IF nuExiste > 0 THEN
                 nuCuotas :=  nuCuoCons;
                 nuPlanFin := nuPlanFCons;
              ELSE
                nuCuotas :=  nuCuoOtrco;
                nuPlanFin := nuPlanFOtroC;
              END IF;
              nuValiSalCu := 1;
              IF regcoesp.concepto = 31 AND (sbFlagFiCon = 'N' OR isbTotConc = 'N')   THEN
                      IF cuValorConsumo%ISOPEN THEN
                        CLOSE cuValorConsumo;
                      END IF;
                      OPEN cuValorConsumo(inuproducto);
                      FETCH cuValorConsumo INTO nuValor;
                      CLOSE cuValorConsumo;

        ELSE
          nuValor := regcoesp.VALOR;
        END IF;

        IF (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN
            nuValiSalCu := 0;

			 if isbTotConc = 'S' THEN
			     isbTotConc := sbFlagFiCon;
			  END IF;
        END IF;
		--se financia
                 IF nuValiSalCu = 1 THEN
                    nuSaldoCuen := nuSaldoCuen  - nuValor;
                    IF nuSaldoCuen <> 0 AND regcoesp.fila = regcoesp.maxrownum THEN
                       nuValor := nuValor  + nuSaldoCuen;
                    END IF;
                 END IF;
            IF NVL(nuValor,0) > 0 THEN

                 prInsertNota ( inucuenta,
                               inuproducto,
                               regcoesp.concepto,
                               inuCausal,
                               regcoesp.valor,
                               'CR', -- DB  CR
                               'S', -- S N
                               nuPlanFin,
                               nuCuotas,
                                inucuensaldo,
                               'GENERACION DE NOTA POR CONTIGENCIA',
                              nusesion,
                              sbUser,
                              dtFechProc,
                              inufactura,
							   isbTotConc);

         end if;
           END LOOP;
        ELSE
           --se consulta conceptos especificos
           FOR regcoesp IN cuGetConceEspec LOOP
              nuCuotas := NULL;
              nuValor  := NULL;
        nuPlanFin := null;
              nuValiSalCu := 1;

              --se valida si existe concepto en exclusion
              SELECT  COUNT(1) INTO nuExiste
              FROM (SELECT to_number(regexp_substr(sbConcExcl,'[^,]+', 1, LEVEL)) AS conc
                    FROM dual
                    CONNECT BY regexp_substr(sbConcExcl, '[^,]+', 1, LEVEL) IS NOT NULL)
              WHERE conc = regcoesp.concepto;

              IF regcoesp.concepto = 31 AND (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN
                IF cuValorConsumo%ISOPEN THEN
                  CLOSE cuValorConsumo;
                END IF;
                OPEN cuValorConsumo(inuproducto);
                FETCH cuValorConsumo INTO nuValor;
                CLOSE cuValorConsumo;

              ELSE
                nuValor := regcoesp.VALOR;
              END IF;
                IF (sbFlagFiCon = 'N' OR isbTotConc = 'N') THEN
					nuValiSalCu := 0;

					   if isbTotConc = 'S' THEN
						 isbTotConc := sbFlagFiCon;
					  END IF;
				END IF;
              IF nuExiste > 0 THEN
                 nuCuotas :=  nuCuoCons;
                 nuPlanFin := nuPlanFCons;
              ELSE
                nuCuotas :=  nuCuoOtrco;
                nuPlanFin := nuPlanFOtroC;
              END IF;
			   IF nuValiSalCu = 1 THEN
                    nuSaldoCuen := nuSaldoCuen  - nuValor;
                    IF nuSaldoCuen <> 0 AND regcoesp.fila = regcoesp.maxrownum THEN
                       nuValor := nuValor  + nuSaldoCuen;
                    END IF;
                 END IF;

              IF NVL(nuValor,0) > 0  THEN

               prInsertNota ( inucuenta,
                              inuproducto,
                             regcoesp.concepto,
                             inuCausal,
                             nuValor,
                             'CR', -- DB  CR
                             'S', -- S N
                             nuPlanFin,
                             nuCuotas,
                              inucuensaldo,
                             'GENERACION DE NOTA POR CONTIGENCIA',
                             nusesion,
                             sbUser,
                             dtFechProc,
                             inufactura,
							   isbTotConc);


        end if;
           END LOOP;

        END IF;
     END IF;
 EXCEPTION
   WHEN OTHERS THEN
      errors.seterror;
      errors.geterror(Onuerror, Osberror);
      prInsertLog( inucuenta,
                    inuproducto,
                    'PRFINADEUDPCONTI',
                    osberror);
 END prFinanConcCuen;

 PROCEDURE prGeneFinanConc ( inuPeriodo  IN   NUMBER,
                             inumes      IN   NUMBER,
                             sbTipoConc  IN   VARCHAR2,
                             idtFechaPago IN   DATE,
                             onuerror    OUT  NUMBER,
                             osberror    OUT  VARCHAR2) IS
 /**************************************************************************
  Proceso     : prGeneFinanConc
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-31-03
  Ticket      : 374
  Descripcion : genera financiacion de conceptos

  Parametros Entrada
   inuPeriodo  numero de periodo
   sbTipoConc    tipo de concepto  C - CONSUMO, T - TODOS, O - OTROS
   idtFechaPago  Fecha de pago
  Parametros de salida
   onuerror     codigo de error
   osberror     mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/

  sbEstrato    VARCHAR2(100)  := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTRAPROC',NULL); --se almacena codigo de estratos

  sbConcExcl   VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CONADIF36',NULL); --se almacena conceptos a diferir a 36
  nuCupon      NUMBER;
  nuExiste     NUMBER;
  nuPeriConsaldo  NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUPEVALI', NULL); --se almacena numero de cuentas a validar
  nuPeriodo       NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUPEREFCO', NULL);-- numero de periodos a refinanciar

  sbLiqSuboTF   VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_LIQSUBOTOFA',NULL); -- S liquida solo subsistencia T todda la factura cuando el nr cuentas con saldo mayor a parametro

  sbValiPerAnt  VARCHAR2(1);
  sbLiqTodFact  VARCHAR2(1);
  sbLiqPerAnt   VARCHAR2(1);

  --se consulta facturas de gas sin sado del periodo anterior
  CURSOR cuFacturaconsaldo IS
  SELECT /*+ index( cu IDXCUCO_RELA)
          index(f IX_FACTURA04) */
       f.factsusc,
       f.factcodi,
       cu.cucocodi,
       decode(f.factpefa,inuPeriodo, idtFechaPago, cu.cucofeve) cucofeve,
    CU.CUCOCATE,
       CU.CUCOSUCA,
     cu.cuconuse,
       nvl(cucovare,0) cucovare,
      nvl(cu.cucovaab,0) cucovaab,
    (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) saldo
  FROM cuencobr cu, factura f, SERVSUSC S
  WHERE  f.factpefa =  inuPeriodo
   AND f.factcodi = cu.cucofact
   -- and not exists (select 'x' from open.cargos where cargcuco=cucocodi and cargcaca=62)
	AND F.factsusc in ( SELECT CONTRATO
						  FROM open.LDC_DIFEAPROC_PLANALIV c
						  WHERE NROPROCESO = 121)
   AND f.factprog = 6
    AND s.sesunuse = cu.cuconuse
    --AND s.sesucate = 1
   --and f.factcodi in ( 2052057398,  2052063351)
   AND ValidaCategoria(s.sesucate, s.sesusuca) = 0
   /* AND s.sesusuca IN (  SELECT to_number(regexp_substr(sbEstrato,'[^,]+', 1, LEVEL)) AS ESTRATO
                        FROM dual
                        CONNECT BY regexp_substr(sbEstrato, '[^,]+', 1, LEVEL) IS NOT NULL
                         )
    AND NOT EXISTS ( SELECT 1
                     FROM cargos ca
                     WHERE ca.cargcuco = cu.cucocodi
                      AND  ((ca.cargcaca = 51 AND ca.cargconc in( 31,17) and cu.cucovaab > 0)
                        or ca.cargsign = 'AS'))*/
    ;

  TYPE tblFacturas IS TABLE OF cuFacturaconsaldo%ROWTYPE;
   VtblFacturas tblFacturas;
  CURSOR cuFacturaconsaldoant(nuPeriante NUMBER, inunuse  IN NUMBER) IS
  SELECT /*+ index( cu IDXCUCO_RELA)
          index(f IX_FACTURA04) */
       f.factsusc,
       f.factcodi,
       cu.cucocodi,
       cu.cucofeve,
       cu.cuconuse,
    CU.CUCOCATE,
       CU.CUCOSUCA,
     nvl(cucovare,0) cucovare,
      nvl(cu.cucovaab,0) cucovaab,
    (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) saldo
  FROM cuencobr cu, factura f, SERVSUSC S
  WHERE  f.factpefa =  nuPeriante
   AND f.factcodi = cu.cucofact
   AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0
  --  and not exists (select 'x' from open.cargos where cargcuco=cucocodi and cargcaca=62)

    AND f.factprog = 6
    AND s.sesunuse = cu.cuconuse
    AND s.sesunuse = inunuse
  AND ValidaCategoria(s.sesucate, s.sesusuca) = 0

    --AND s.sesucate = 1
    /*AND s.sesusuca IN (  SELECT to_number(regexp_substr(sbEstrato,'[^,]+', 1, LEVEL)) AS ESTRATO
                        FROM dual
                        CONNECT BY regexp_substr(sbEstrato, '[^,]+', 1, LEVEL) IS NOT NULL
                         )
     AND NOT EXISTS ( SELECT 1
                     FROM cargos ca
                     WHERE ca.cargcuco = cu.cucocodi
                      AND  ((ca.cargcaca = 51 AND ca.cargconc in( 31,17) and cu.cucovaab > 0)
                        or ca.cargsign = 'AS'))*/;

     TYPE tblFacturasAnt IS TABLE OF cuFacturaconsaldoant%ROWTYPE;
   VtblFacturasAnt tblFacturasAnt;
  --numero de cuenta con saldo
  CURSOR cuCuenCons(inuNuse NUMBER) IS
  /*SELECT COUNT(*)
  FROM cuencobr
  WHERE cuconuse = inuNuse
   AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0;*/
  SELECT COUNT(*)
  FROM cuencobr, factura
  WHERE cuconuse = inuNuse
   and cucofact=factcodi
   and factprog=6
   AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0
   and cucofeve < to_date('01/06/2020');

  nuCuenSaldos number;

  --numero de periodo con  saldo
  CURSOR cuCuenConsPer(inuNuse NUMBER) IS
  SELECT f.factpefa
  FROM cuencobr, factura f
  WHERE cucofact = factcodi
   AND cuconuse = inuNuse
   and factprog = 6
   AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0
    and cucofeve < to_date('01/06/2020');

  nuSumaPer  NUMBER := 0;
  nuExisPer  NUMBER := 0;

  --se obtiene periodo anterior
  CURSOR cuperiodoval(inuperi NUMBER) IS
  SELECT count(1)
  FROM (
      SELECT periodo
      FROM ( SELECT pa.pefacodi periodo
           FROM PERIFACT pa, perifact p
           WHERE  pa.PEFACICL = p.pefacicl
             AND p.pefacodi = inuPeriodo
              and pa.pefacodi <= p.pefacodi
           ORDER BY  pa.pefaffmo desc)
      WHERE  ROWNUM <= (nuPeriConsaldo))
  WHERE inuperi = periodo;

  --se obtiene periodo anterior
  CURSOR cuperiodoanterior IS
  SELECT periodo, fecha_pago
  FROM ( SELECT pa.pefacodi periodo, pa.pefafepa fecha_pago
     FROM PERIFACT pa, perifact p
     WHERE pa.PEFAFFMO < p.pefafimo
       AND pa.PEFACICL = p.pefacicl
       AND p.pefacodi = inuPeriodo
     ORDER BY  pa.pefaffmo desc)
  WHERE  ROWNUM <= (nuPeriConsaldo - 1);

    --se obtiene periodo anterior desde marzo
  CURSOR cuperiodoanteriorMar IS
  SELECT periodo, fecha_pago
  FROM ( SELECT pa.pefacodi periodo, pa.pefafepa fecha_pago
     FROM PERIFACT pa, perifact p
     WHERE pa.PEFAFFMO < p.pefafimo
       AND pa.PEFACICL = p.pefacicl
       AND p.pefacodi = inuPeriodo
	   AND pa.pefaano = 2020
       AND pa.pefames >= 3
     ORDER BY  pa.pefaffmo desc)
  ;--WHERE  ROWNUM <= (nuPeriConsaldo - 1);

   --se obtiene cupon de pago
  CURSOR cuGetCupon(nucuenta NUMBER) IS
  SELECT cargcodo
  FROM cargos
  WHERE cargcuco = nucuenta
    AND cargsign = 'PA';

    sbConc  VARCHAR2(4000);

 BEGIN
   onuerror := 0;
 --DBMS_OUTPUT.PUT_LINE('inuPeriodo '||inuPeriodo);
  /*OPEN cuFacturaconsaldo;
  LOOP
    FETCH cuFacturaconsaldo BULK COLLECT INTO VtblFacturas LIMIT 100;*/

   FOR regi IN cuFacturaconsaldo LOOP
          sbLiqTodFact := NULL;
          sbValiPerAnt := NULL;
          sbLiqPerAnt := NULL;
          sbConc      := NULL;
          IF cuGetCupon%ISOPEN THEN
               CLOSE cuGetCupon;
            END IF;

          IF cuCuenCons%ISOPEN THEN
            CLOSE cuCuenCons;
          END IF;

          --se valida periodos con saldo
          OPEN cuCuenCons(regi.cuconuse);
          FETCH cuCuenCons INTO nuCuenSaldos;
          CLOSE cuCuenCons;
        -- DBMS_OUTPUT.PUT_LINE('cuenta con saldo '||nuCuenSaldos||' nuse '||regi.cuconuse);
          --se valida la cantidad de cuentas con saldo
          IF nuCuenSaldos = 1 THEN
             sbValiPerAnt := 'N';
             sbLiqTodFact := 'S';
             sbLiqPerAnt  := 'N';
          ELSE
            IF nuCuenSaldos <= nuPeriConsaldo THEN
               sbValiPerAnt := 'S';
               sbLiqTodFact := 'N';
               sbLiqPerAnt  := 'N';
            ELSE
               sbValiPerAnt := 'N';
               if sbLiqSuboTF = 'S' then -- S solo Subsistencia
                  sbLiqTodFact := 'N';
                  sbLiqPerAnt  := 'N';
               else -- T Toda la factura
                 sbLiqTodFact := 'S'; -- para que liquide todos los conceptos y no solo el de susbsist segun reunion 19Jun2020
                 sbLiqPerAnt  := 'N';
               end if;
            END IF;
          END IF;
        --si se requiere validar periodos
        IF sbValiPerAnt = 'S' THEN
           nuSumaPer := 0;
           nuExisPer := 0;
           FOR regPer IN cuCuenConsPer(regi.cuconuse) LOOP
           if cuperiodoval%isopen then
            close cuperiodoval;
           end if;

           open cuperiodoval(regper.factpefa);
           fetch cuperiodoval into nuExisPer;
           close cuperiodoval;

           nuSumaPer := nuSumaPer + nuExisPer;

           END LOOP;
           --
           IF nuSumaPer = nuCuenSaldos THEN
             sbLiqTodFact := 'S';
             sbLiqPerAnt  := 'S';
           ELSE
             if sbLiqSuboTF = 'S' then -- S solo Subsistencia
               sbLiqTodFact := 'N';
               sbLiqPerAnt  := 'N';
             else -- T Toda la factura
               sbLiqTodFact := 'S';
               sbLiqPerAnt  := 'N';
             end if;
           END IF;

         END IF;


        --DBMS_OUTPUT.PUT_LINE('sbLiqTodFact '||sbLiqTodFact||' nuSumaPer '||nuSumaPer);
         --se valida si se difiere toda la factura o solo el consumo
         IF sbLiqTodFact = 'S' and sbTipoConc = 'T' THEN
           sbConc := '-1';
         ELSIF sbLiqTodFact = 'S' and sbTipoConc = 'C' THEN
           sbConc := sbConcExcl;
         ELSIF sbLiqTodFact = 'S' and sbTipoConc = 'O' THEN
           sbConc := '1';
         ELSIF sbLiqTodFact = 'N' THEN
           sbConc := sbConcExcl;
         END IF;

         -- DBMS_OUTPUT.PUT_LINE('sbConc '||sbConc);
        nuCupon:= NULL;
        --se obtiene cupon
        OPEN cuGetCupon(regi.cucocodi);
        FETCH cuGetCupon INTO nuCupon;
        CLOSE cuGetCupon;
        --DBMS_OUTPUT.PUT_LINE('nuCupon '||nuCupon||' sbConc '||sbConc||' sbLiqTodFact '||sbLiqTodFact);

        IF regi.saldo > 0 THEN
          --se financia cuenta
          prFinanConcCuen( regi.cucocodi,
               regi.factcodi,
               regi.cucocate,
               regi.cucosuca,
               regi.cucofeve,
               nuCupon,
               nuCuenSaldos,
               sbConc,
               regi.cucovaab,
               regi.cucovare,
               regi.cuconuse,
               inuPeriodo,
               sbLiqTodFact,
               regi.saldo);
         END IF;

         IF nuPeriodo > 1 AND sbLiqTodFact = 'S' AND sbLiqPerAnt = 'S' THEN
           FOR regPant IN cuperiodoanterior LOOP
              /* OPEN cuFacturaconsaldoant(regPant.periodo, VtblFacturas(regi).cuconuse );
               LOOP
                FETCH cuFacturaconsaldoant BULK COLLECT INTO VtblFacturasAnt LIMIT 100;
                 FOR regCuen IN 1..VtblFacturasAnt.COUNT LOOP*/
              FOR regCuen IN cuFacturaconsaldoant(regPant.periodo, regi.cuconuse  ) LOOP
                      nuCupon:= NULL;
                      IF cuGetCupon%ISOPEN THEN
                         CLOSE cuGetCupon;
                      END IF;
                      --se obtiene cupon
                      OPEN cuGetCupon(regCuen.cucocodi);
                      FETCH cuGetCupon INTO nuCupon;
                      CLOSE cuGetCupon;
                      --se financia cuenta
                      prFinanConcCuen( regCuen.cucocodi,
                          regCuen.factcodi,
                          regCuen.Cucocate,
                          regCuen.Cucosuca,
                          regPant.fecha_pago /*regCuen.cucofeve*/,
                          nuCupon,
                          nuCuenSaldos,
                          sbConc,
                          regCuen.cucovaab,
                          regCuen.cucovare,
                          regCuen.cuconuse,
                          regPant.periodo,
                          sbLiqTodFact,
                          regCuen.saldo);
                   END LOOP;
            END LOOP;
          END IF;
          --se liquidan hasta marzo
          IF nuPeriodo > 1 AND sbLiqTodFact = 'S' AND sbLiqPerAnt = 'N' THEN
           FOR regPant IN cuperiodoanteriorMar LOOP
                  /*OPEN cuFacturaconsaldoant(regPant.periodo, VtblFacturas(regi).cuconuse );
               LOOP
                FETCH cuFacturaconsaldoant BULK COLLECT INTO VtblFacturasAnt LIMIT 100;
                 FOR regCuen IN 1..VtblFacturasAnt.COUNT LOOP*/
                FOR regCuen IN cuFacturaconsaldoant(regPant.periodo, regi.cuconuse  ) LOOP
                       nuCupon:= NULL;
                      IF cuGetCupon%ISOPEN THEN
                         CLOSE cuGetCupon;
                      END IF;
                      --se obtiene cupon
                      OPEN cuGetCupon(regCuen.cucocodi);
                      FETCH cuGetCupon INTO nuCupon;
                      CLOSE cuGetCupon;
                      --se financia cuenta
                      prFinanConcCuen( regCuen.cucocodi,
                          regCuen.factcodi,
                          regCuen.Cucocate,
                          regCuen.Cucosuca,
                          regPant.fecha_pago /*regCuen.cucofeve*/,
                          nuCupon,
                          nuCuenSaldos,
                          sbConc,
                          regCuen.cucovaab,
                          regCuen.cucovare,
                          regCuen.cuconuse,
                          regPant.periodo,
                          sbLiqTodFact,
                          regCuen.saldo);
                   END LOOP;
            END LOOP;
          END IF;
      END LOOP;

 exception
  WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(Onuerror,osberror);
    --  DBMS_OUTPUT.PUT_LINE('osberror  '||osberror);
       prInsertLog( inuPeriodo,
                    inuPeriodo,
                    'PRFINADEUDPCONTI',
                    osberror);
  WHEN OTHERS THEN
       ERRORS.SETERROR;
       ERRORS.geterror(Onuerror,osberror);
      -- DBMS_OUTPUT.PUT_LINE('error no controlado  '||osberror);
        prInsertLog( inuPeriodo,
                    inuPeriodo,
                    'PRFINADEUDPCONTI',
                    osberror);
 END prGeneFinanConc;

 PROCEDURE prGeneFinanCuentasEsp  IS
 /**************************************************************************
  Proceso     : prGeneFinanConc
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-31-03
  Ticket      : 374
  Descripcion : genera financiacion de conceptos

  Parametros Entrada
   inuPeriodo  numero de periodo
   sbTipoConc    tipo de concepto  C - CONSUMO, T - TODOS, O - OTROS
   idtFechaPago  Fecha de pago
  Parametros de salida
   onuerror     codigo de error
   osberror     mensaje de error

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  14/08/2024    jpinedc     OSF-3126: Se cambia truncate por 
                            pkg_truncate_tablas_open.prcLdc_Notas_Masivas
 ***************************************************************************/

  inuPeriodo  NUMBER;
  inumes      NUMBER;
  sbTipoConc  VARCHAR2(1) := 'T';
  onuerror    NUMBER;
  osberror    VARCHAR2(4000);

  idtFechaPago  DATE;

  sbEstrato    VARCHAR2(100)  := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTRAPROC',NULL); --se almacena codigo de estratos

  sbConcExcl   VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CONADIF36',NULL); --se almacena conceptos a diferir a 36
  nuCupon      NUMBER;
  nuExiste     NUMBER;
  nuPeriConsaldo  NUMBER := inumes;--DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUPEVALI', NULL); --se almacena numero de cuentas a validar
  nuPeriodo       NUMBER := inumes;--DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUPEREFCO', NULL);-- numero de periodos a refinanciar

  sbLiqSuboTF   VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_LIQSUBOTOFA',NULL); -- S liquida solo subsistencia T todda la factura cuando el nr cuentas con saldo mayor a parametro

  sbValiPerAnt  VARCHAR2(1);
  sbLiqTodFact  VARCHAR2(1);
  sbLiqPerAnt   VARCHAR2(1);

  --se consulta facturas de gas sin sado del periodo anterior
  CURSOR cuFacturaconsaldo IS
    with contratos as
	( select CONTRATO, sesunuse, c.CUENTA, pefacodi, sesucate, sesusuca,pefafepa
	  from open.LDC_DIFEAPROC_PLANALIV c,
		   open.perifact p,
		   open.SERVSUSC S
	  where nroproceso=121
		and pefaano = 2020
		and pefames = c.CUENTA - 1
		and sesususc = CONTRATO
		and sesucicl = pefacicl
	)
 SELECT
        f.factsusc,
        f.factcodi,
        cu.cucocodi,
        pefafepa cucofeve,
        pefacodi,
        CU.CUCOCATE,
        CU.CUCOSUCA,
        cu.cuconuse,
        nvl(cucovare,0) cucovare,
        nvl(cu.cucovaab,0) cucovaab,
        (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) saldo,
        c.CUENTA nuperiodo
 FROM open.cuencobr cu, open.factura f, contratos c
WHERE  f.factpefa =  pefacodi
  AND f.factcodi = cu.cucofact
  AND c.CONTRATO = f.factsusc
	AND f.factprog = 6
	AND ((nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0
        or exists ( SELECT 1
                    FROM open.cuencobr c, open.factura fa
                    WHERE c.cuconuse = cu.cuconuse
                     and c.cucofact=fa.factcodi
                     and fa.factprog=6
                     AND (nvl(c.cucosacu,0) - nvl(c.cucovare,0) - nvl(c.CUCOVRAP, 0)) > 0
                     and c.cucofeve < sysdate))
	AND ValidaCategoria(c.sesucate, c.sesusuca) = 0;


  TYPE tblFacturas IS TABLE OF cuFacturaconsaldo%ROWTYPE;
   VtblFacturas tblFacturas;
  CURSOR cuFacturaconsaldoant(nuPeriante NUMBER, inunuse  IN NUMBER) IS
  SELECT /*+ index( cu IDXCUCO_RELA)
          index(f IX_FACTURA04) */
       f.factsusc,
       f.factcodi,
       cu.cucocodi,
       cu.cucofeve,
       cu.cuconuse,
    CU.CUCOCATE,
       CU.CUCOSUCA,
     nvl(cucovare,0) cucovare,
      nvl(cu.cucovaab,0) cucovaab,
    (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) saldo
  FROM cuencobr cu, factura f, SERVSUSC S
  WHERE  f.factpefa =  nuPeriante
   AND f.factcodi = cu.cucofact
    AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0
  --  and not exists (select 'x' from open.cargos where cargcuco=cucocodi and cargcaca=62)
    AND f.factprog = 6
    AND s.sesunuse = cu.cuconuse
    AND s.sesunuse = inunuse
  AND ValidaCategoria(s.sesucate, s.sesusuca) = 0

    --AND s.sesucate = 1
    /*AND s.sesusuca IN (  SELECT to_number(regexp_substr(sbEstrato,'[^,]+', 1, LEVEL)) AS ESTRATO
                        FROM dual
                        CONNECT BY regexp_substr(sbEstrato, '[^,]+', 1, LEVEL) IS NOT NULL
                         )
     AND NOT EXISTS ( SELECT 1
                     FROM cargos ca
                     WHERE ca.cargcuco = cu.cucocodi
                      AND  ((ca.cargcaca = 51 AND ca.cargconc in( 31,17) and cu.cucovaab > 0)
                        or ca.cargsign = 'AS'))*/;

     TYPE tblFacturasAnt IS TABLE OF cuFacturaconsaldoant%ROWTYPE;
   VtblFacturasAnt tblFacturasAnt;
  --numero de cuenta con saldo
  CURSOR cuCuenCons(inuNuse NUMBER) IS
  /*SELECT COUNT(*)
  FROM cuencobr
  WHERE cuconuse = inuNuse
   AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0;*/
  SELECT COUNT(*)
  FROM cuencobr, factura
  WHERE cuconuse = inuNuse
   and cucofact=factcodi
   and factprog=6
   AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0
   and cucofeve < sysdate;

  nuCuenSaldos number;

  --numero de periodo con  saldo
  CURSOR cuCuenConsPer(inuNuse NUMBER) IS
  SELECT f.factpefa
  FROM cuencobr, factura f
  WHERE cucofact = factcodi
   AND cuconuse = inuNuse
   and factprog = 6
   AND (nvl(cucosacu,0) - nvl(cucovare,0) - nvl(CUCOVRAP, 0)) > 0
    and cucofeve < sysdate;

  nuSumaPer  NUMBER := 0;
  nuExisPer  NUMBER := 0;

  --se obtiene periodo anterior
  CURSOR cuperiodoval(inuperi NUMBER) IS
  SELECT count(1)
  FROM (
      SELECT periodo
      FROM ( SELECT pa.pefacodi periodo
           FROM PERIFACT pa, perifact p
           WHERE  pa.PEFACICL = p.pefacicl
             AND p.pefacodi = inuPeriodo
              and pa.pefacodi <= p.pefacodi
           ORDER BY  pa.pefaffmo desc)
      WHERE  ROWNUM <= (nuPeriConsaldo))
  WHERE inuperi = periodo;

  --se obtiene periodo anterior
  CURSOR cuperiodoanterior IS
  SELECT periodo, fecha_pago
  FROM ( SELECT pa.pefacodi periodo, pa.pefafepa fecha_pago
     FROM PERIFACT pa, perifact p
     WHERE pa.PEFAFFMO < p.pefafimo
       AND pa.PEFACICL = p.pefacicl
       AND p.pefacodi = inuPeriodo
     ORDER BY  pa.pefaffmo desc)
  WHERE  ROWNUM <= (nuPeriConsaldo - 1);

    --se obtiene periodo anterior desde marzo
  CURSOR cuperiodoanteriorMar IS
  SELECT periodo, fecha_pago
  FROM ( SELECT pa.pefacodi periodo, pa.pefafepa fecha_pago
     FROM PERIFACT pa, perifact p
     WHERE pa.PEFAFFMO < p.pefafimo
       AND pa.PEFACICL = p.pefacicl
       AND p.pefacodi = inuPeriodo
	   AND pa.pefaano = 2020
       AND pa.pefames >= 3
     ORDER BY  pa.pefaffmo desc)
  ;--WHERE  ROWNUM <= (nuPeriConsaldo - 1);

   --se obtiene cupon de pago
  CURSOR cuGetCupon(nucuenta NUMBER) IS
  SELECT cargcodo
  FROM cargos
  WHERE cargcuco = nucuenta
    AND cargsign = 'PA';

    sbConc  VARCHAR2(4000);
   nuparano   NUMBER;
  nuparmes   NUMBER;
  nutsess    NUMBER;
  sbparuser  VARCHAR2(4000);

 BEGIN
   onuerror := 0;
 --DBMS_OUTPUT.PUT_LINE('inuPeriodo '||inuPeriodo);

   -- Obtenemos datos para realizar ejecucion
     SELECT  to_number(to_char(SYSDATE,'YYYY')),
                to_number(to_char(SYSDATE,'MM')),
                userenv('SESSIONID'),
                USER
     INTO nuparano,nuparmes,nutsess,sbparuser
     FROM dual;

     -- asigna variables globales
     nusesion := nutsess;
     sbUser := sbparuser;
     dtFechProc := sysdate;

      -- Start log program
     ldc_proinsertaestaprog(nuparano,nuparmes,'PRFINADEUDPCONTI','En ejecucion',nutsess,sbparuser);
      -- Carga tabla de parametros en memoria
     prIniTabla;
	 pkg_truncate_tablas_open.prcLdc_Notas_Masivas;
    commit;

	 ldc_proinsertaestaprog(nuparano,nuparmes,'LLENARNOTATEMP','En ejecucion',nutsess,sbparuser);
  OPEN cuFacturaconsaldo;
  LOOP
    FETCH cuFacturaconsaldo BULK COLLECT INTO VtblFacturas LIMIT 100;
      FOR regi IN 1..VtblFacturas.COUNT LOOP
          sbLiqTodFact := NULL;
          sbValiPerAnt := NULL;
          sbLiqPerAnt := NULL;
          sbConc      := NULL;
		  nuPeriConsaldo := null;
		  nuPeriodo := null;
		  inuPeriodo := null;


		  nuPeriConsaldo := VtblFacturas(regi).nuperiodo;
		  nuPeriodo := VtblFacturas(regi).nuperiodo;
		  inuPeriodo := VtblFacturas(regi).pefacodi;

          IF cuGetCupon%ISOPEN THEN
               CLOSE cuGetCupon;
            END IF;

          IF cuCuenCons%ISOPEN THEN
            CLOSE cuCuenCons;
          END IF;

          --se valida periodos con saldo
          OPEN cuCuenCons(VtblFacturas(regi).cuconuse);
          FETCH cuCuenCons INTO nuCuenSaldos;
          CLOSE cuCuenCons;
        -- DBMS_OUTPUT.PUT_LINE('cuenta con saldo '||nuCuenSaldos||' nuse '||regi.cuconuse);
          --se valida la cantidad de cuentas con saldo
          IF nuCuenSaldos = 1 THEN
             sbValiPerAnt := 'N';
             sbLiqTodFact := 'S';
             sbLiqPerAnt  := 'N';
          ELSE
            IF nuCuenSaldos <= nuPeriConsaldo THEN
               sbValiPerAnt := 'S';
               sbLiqTodFact := 'N';
               sbLiqPerAnt  := 'N';
            ELSE
               sbValiPerAnt := 'N';
               if sbLiqSuboTF = 'S' then -- S solo Subsistencia
                  sbLiqTodFact := 'N';
                  sbLiqPerAnt  := 'N';
               else -- T Toda la factura
                 sbLiqTodFact := 'S'; -- para que liquide todos los conceptos y no solo el de susbsist segun reunion 19Jun2020
                 sbLiqPerAnt  := 'N';
               end if;
            END IF;
          END IF;
        --si se requiere validar periodos
        IF sbValiPerAnt = 'S' THEN
           nuSumaPer := 0;
           nuExisPer := 0;
           FOR regPer IN cuCuenConsPer(VtblFacturas(regi).cuconuse) LOOP
           if cuperiodoval%isopen then
            close cuperiodoval;
           end if;

           open cuperiodoval(regper.factpefa);
           fetch cuperiodoval into nuExisPer;
           close cuperiodoval;

           nuSumaPer := nuSumaPer + nuExisPer;

           END LOOP;
           --
           IF nuSumaPer = nuCuenSaldos THEN
             sbLiqTodFact := 'S';
             sbLiqPerAnt  := 'S';
           ELSE
             if sbLiqSuboTF = 'S' then -- S solo Subsistencia
               sbLiqTodFact := 'N';
               sbLiqPerAnt  := 'N';
             else -- T Toda la factura
               sbLiqTodFact := 'S';
               sbLiqPerAnt  := 'N';
             end if;
           END IF;

         END IF;


        --DBMS_OUTPUT.PUT_LINE('sbLiqTodFact '||sbLiqTodFact||' nuSumaPer '||nuSumaPer);
         --se valida si se difiere toda la factura o solo el consumo
         IF sbLiqTodFact = 'S' and sbTipoConc = 'T' THEN
           sbConc := '-1';
         ELSIF sbLiqTodFact = 'S' and sbTipoConc = 'C' THEN
           sbConc := sbConcExcl;
         ELSIF sbLiqTodFact = 'S' and sbTipoConc = 'O' THEN
           sbConc := '1';
         ELSIF sbLiqTodFact = 'N' THEN
           sbConc := sbConcExcl;
         END IF;

         -- DBMS_OUTPUT.PUT_LINE('sbConc '||sbConc);
        nuCupon:= NULL;
        --se obtiene cupon
        OPEN cuGetCupon(VtblFacturas(regi).cucocodi);
        FETCH cuGetCupon INTO nuCupon;
        CLOSE cuGetCupon;
        --DBMS_OUTPUT.PUT_LINE('nuCupon '||nuCupon||' sbConc '||sbConc||' sbLiqTodFact '||sbLiqTodFact);

        IF VtblFacturas(regi).saldo > 0 THEN
          --se financia cuenta
          prFinanConcCuen( VtblFacturas(regi).cucocodi,
               VtblFacturas(regi).factcodi,
               VtblFacturas(regi).cucocate,
               VtblFacturas(regi).cucosuca,
               VtblFacturas(regi).cucofeve,
               nuCupon,
               nuCuenSaldos,
               sbConc,
               VtblFacturas(regi).cucovaab,
               VtblFacturas(regi).cucovare,
               VtblFacturas(regi).cuconuse,
               inuPeriodo,
               sbLiqTodFact,
               VtblFacturas(regi).saldo);
         END IF;

         IF nuPeriodo > 1 AND sbLiqTodFact = 'S' AND sbLiqPerAnt = 'S' THEN
           FOR regPant IN cuperiodoanterior LOOP
           --    OPEN cuFacturaconsaldoant(regPant.periodo, VtblFacturas(regi).cuconuse );
              -- LOOP
              ---  FETCH cuFacturaconsaldoant BULK COLLECT INTO VtblFacturasAnt LIMIT 100;
            --     FOR regCuen IN 1..VtblFacturasAnt.COUNT LOOP
					FOR regCuen IN cuFacturaconsaldoant(regPant.periodo, VtblFacturas(regi).cuconuse  ) LOOP
						nuCupon:= NULL;
						IF cuGetCupon%ISOPEN THEN
						CLOSE cuGetCupon;
						END IF;
						--se obtiene cupon
						OPEN cuGetCupon(regCuen.cucocodi);
						FETCH cuGetCupon INTO nuCupon;
						CLOSE cuGetCupon;
						--se financia cuenta
						prFinanConcCuen( regCuen.cucocodi,
						regCuen.factcodi,
						regCuen.Cucocate,
						regCuen.Cucosuca,
						regPant.fecha_pago /*regCuen.cucofeve*/,
						nuCupon,
						nuCuenSaldos,
						sbConc,
						regCuen.cucovaab,
						regCuen.cucovare,
						regCuen.cuconuse,
						regPant.periodo,
						sbLiqTodFact,
						regCuen.saldo);
					END LOOP;
                 /* EXIT WHEN cuFacturaconsaldoant%NOTFOUND;
                 END LOOP;
                 CLOSE cuFacturaconsaldoant;*/
            END LOOP;
          END IF;
          --se liquidan hasta marzo
          IF nuPeriodo > 1 AND sbLiqTodFact = 'S' AND sbLiqPerAnt = 'N' THEN
           FOR regPant IN cuperiodoanteriorMar LOOP
               /*   OPEN cuFacturaconsaldoant(regPant.periodo, VtblFacturas(regi).cuconuse );
               LOOP
                FETCH cuFacturaconsaldoant BULK COLLECT INTO VtblFacturasAnt LIMIT 100;
                 FOR regCuen IN 1..VtblFacturasAnt.COUNT LOOP*/
                  FOR regCuen IN cuFacturaconsaldoant(regPant.periodo, VtblFacturas(regi).cuconuse  ) LOOP
                      	nuCupon:= NULL;
						IF cuGetCupon%ISOPEN THEN
						CLOSE cuGetCupon;
						END IF;
						--se obtiene cupon
						OPEN cuGetCupon(regCuen.cucocodi);
						FETCH cuGetCupon INTO nuCupon;
						CLOSE cuGetCupon;
						--se financia cuenta
						prFinanConcCuen( regCuen.cucocodi,
						regCuen.factcodi,
						regCuen.Cucocate,
						regCuen.Cucosuca,
						regPant.fecha_pago /*regCuen.cucofeve*/,
						nuCupon,
						nuCuenSaldos,
						sbConc,
						regCuen.cucovaab,
						regCuen.cucovare,
						regCuen.cuconuse,
						regPant.periodo,
						sbLiqTodFact,
						regCuen.saldo);

                 END LOOP;

            END LOOP;
          END IF;
      END LOOP;
       EXIT WHEN cuFacturaconsaldo%NOTFOUND;
   END LOOP;
   CLOSE cuFacturaconsaldo;

   ldc_proactualizaestaprog(nutsess,osberror,'LLENARNOTATEMP','ok');

   ldc_proinsertaestaprog(nuparano,nuparmes,'PROCESANOTAS','En ejecucion',nutsess,sbparuser);
   ldc_pkgenotadife.fnuPrincipal(nutsess,onuerror,osberror);
   ldc_proactualizaestaprog(nutsess,osberror,'PROCESANOTAS','ok');

   tParametros.delete;
    ldc_proactualizaestaprog(nutsess,osberror,'PRFINADEUDPCONTI','ok');

 exception
  WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(Onuerror,osberror);
    --  DBMS_OUTPUT.PUT_LINE('osberror  '||osberror);
       prInsertLog( inuPeriodo,
                    inuPeriodo,
                    'PRFINADEUDPCONTI',
                    osberror);
  WHEN OTHERS THEN
       ERRORS.SETERROR;
       ERRORS.geterror(Onuerror,osberror);
      -- DBMS_OUTPUT.PUT_LINE('error no controlado  '||osberror);
        prInsertLog( inuPeriodo,
                    inuPeriodo,
                    'PRFINADEUDPCONTI',
                    osberror);
 END prGeneFinanCuentasEsp;

 function fnuModDiasdeGracia (osbMsgError out varchar2) return number is

  PRAGMA AUTONOMOUS_TRANSACTION;

  sbFechIni  ld_parameter.value_chain%type   := dald_parameter.fsbgetvalue_chain('LDC_FEINCODI',NULL);
  nuPlanFina ld_parameter.numeric_value%TYPE := dald_parameter.fnugetnumeric_value('LDC_PLFICONT', null);
  nuDias     number;
  nucodpergracia cc_grace_period.grace_period_id%type;
  onuError  number;
  cursor cuPlanesParam is
   select distinct plficoco plan, feincodi fecha
     from LDC_CONFIG_CONTINGENC t
    where plficoco is not null and feincodi is not null
  union
   select distinct plficont plan , feincodo fecha
     from LDC_CONFIG_CONTINGENC t
    where plficont is not null and feincodo is not null ;
  cursor cuPlanDife (nuplan plandife.pldicodi%type) is
   select pldipegr
     from plandife
    where pldicodi = nuplan;

  cursor cuPeriGracia (nucopegr cc_grace_period.grace_period_id%type) is
   select *
     from cc_grace_period g
   where g.grace_period_id = nucopegr;

begin
  onuError := 0;

   for rg in cuPlanesParam loop
  nuDias := to_Date(rg.fecha,'dd/mm/yyyy') - trunc(sysdate);
    if nuDias > 0 then
       open cuPlanDife(rg.plan);
       fetch cuPlanDife into nucodpergracia;
       if cuPlanDife%notfound or nucodpergracia is null then
         onuError := -1;
         osbMsgError := 'No existe periodo de gracia asociado al Plan ' || nuPlanFina;
       end if;
       close cuPlanDife;

       if onuError = 0 then
          update cc_grace_period t
             set t.min_grace_days = nuDias,
                 t.max_grace_days = nuDias
           where t.grace_period_id = nucodpergracia;
           commit;
           osbMsgError := 'Periodo de Gracia Actualizado a ' || nuDias || ' dias';
       end if;
    else
      osbMsgError := 'Nro Dias que faltan para el parametro es menor o igual a 1 ... Periodo de Gracia No se actualizo';
    end if;
  end loop;

  return onuError;

exception when others then
  rollback;
  onuError := -1;
  osbMsgError := 'Error en fnuModDiasdeGracia: ' || sqlerrm;
  return -1;
 end;

 ----------------------------------------------------
 function fdtFecPagoFacAliv  (inucicl in perifact.pefacicl%type,
                                       idtfefimo in perifact.pefafimo%type) return date is

dtfechapago date;

cursor cuFechaPago is
select pefafepa
  from (select p.pefafepa
          from perifact p
         where p.pefacicl=inucicl
           and p.pefaffmo < idtfefimo
           and p.pefaano=2020
         order by p.pefafimo desc)
where rownum = 1;

BEGIN
 open cuFechaPago;
 fetch cuFechaPago into dtfechapago;
 if cuFechaPago%notfound then
    dtfechapago := null;
 end if;
 close cuFechaPago;

 return dtfechapago;

exception when others then
  return null;
end fdtFecPagoFacAliv;

 -------------------------------------

 PROCEDURE prFinaDeudpConti IS
 /**************************************************************************
  Proceso     : prFinaDeudpConti
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-29-03
  Ticket      :
  Descripcion : genera financiacion de deuda dde usuario que no pudieron pagar

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  14/08/2024    jpinedc     OSF-3126: Se cambia truncate por 
                            pkg_truncate_tablas_open.prcLdc_Notas_Masiva  
***************************************************************************/
  nuparano   NUMBER;
  nuparmes   NUMBER;
  nutsess    NUMBER;
  sbparuser  VARCHAR2(4000);
  nuerror    NUMBER;
  osberror   VARCHAR2(4000);
  nuDias     NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUDICACO', NULL);-- se almacena el numero de dias a revisar
  nuPeriodo  NUMBER :=  DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUPEREFCO', NULL);-- numero de periodos a refinanciar
  nuperiante  NUMBER;

  nuerrorBloqCupo NUMBER;
  osberrorBloqCupo VARCHAR2(4000);


  sbFlagConsEjec  VARCHAR2(1) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGFECO', NULL); --se almacena flag para ejecucion de consumo
  sbFlagOtCoEjec  VARCHAR2(1) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGFEOC', NULL); --se almacena flag para ejecucion de otros


  --se obtienen periodos a procesar
  CURSOR cuPeriodos IS
  SELECT pefafimo, pefaffmo, pefacicl, pefacodi, pefafepa
  FROM perifact
  WHERE ( trunc(pefafepa) + nuDias ) = TRUNC(SYSDATE)
  ;

   --se obtienen periodos a procesar dia antes de la fecha final
  CURSOR cuPeriodosFF IS
  select distinct pe.pefafimo, pe.pefaffmo, pe.pefacicl, pe.pefacodi,pe.PEFAFEPA, C.CUENTA  pefames
  from open.LDC_DIFEAPROC_PLANALIV c,
       open.perifact pe
where nroproceso= 121
  and pefaano = 2020
  and (pefames ) = c.PERIODO
  and DIFERIDO = pefacicl;
  /*
   SELECT  pe.pefafimo, pe.pefaffmo, pe.pefacicl, pe.pefacodi,pe.PEFAFEPA, pe.pefames
   FROM (
			SELECT P.PEFACICL, MAX(pefacodi) periodomax
			FROM open.perifact P
			WHERE (P.PEFAFfmo < SYSDATE or (( trunc(PEFAFfmo) + nuDias ) = TRUNC(SYSDATE)) )
			  and P.pefaano > 2019
			group by P.PEFACICL) p, open.perifact PE
	WHERE p.periodomax = PE.pefacodi
	order by pefacicl ;*/



  --se obtiene periodo anterior
  CURSOR cuperiodoant(inuciclo NUMBER, idtFeIniMov DATE) IS
  SELECT *
  FROM (SELECT --+ INDEX_DESC (PERIFACT IX_PEFA_CICL_FFMO)
          pefacodi, PEFAFEPA, PEFAMES
        FROM PERIFACT
        WHERE PEFAFFMO < idtFeIniMov
         AND PEFACICL = inuciclo
        ORDER BY PEFAFFMO desc)
   WHERE ROWNUM < 2;

   dtFechaPago DATE;
   NUMES  NUMBER;
 BEGIN
  UT_TRACE.TRACE('[PRFINADEUDPCONTI] INIICO ',10);

  IF fblaplicaentregaxcaso('0000379') THEN
     -- Obtenemos datos para realizar ejecucion
     SELECT  to_number(to_char(SYSDATE,'YYYY')),
                to_number(to_char(SYSDATE,'MM')),
                userenv('SESSIONID'),
                USER
     INTO nuparano,nuparmes,nutsess,sbparuser
     FROM dual;

     -- asigna variables globales
     nusesion := nutsess;
     sbUser := sbparuser;
     dtFechProc := sysdate;

      -- Start log program
     ldc_proinsertaestaprog(nuparano,nuparmes,'PRFINADEUDPCONTI','En ejecucion',nutsess,sbparuser);
      -- Carga tabla de parametros en memoria
     prIniTabla;

    -- borra registros si ya existen para la sesion
   -- delete from ldc_notas_masivas t where t.sesion = nusesion;
    pkg_truncate_tablas_open.prcLdc_Notas_Masivas;    
    commit;
    ldc_proinsertaestaprog(nuparano,nuparmes,'LLENARNOTATEMP','En ejecucion',nutsess,sbparuser);
   /* nuerror := fnuModDiasdeGracia(osberror);

    IF nuerror = -1 THEN
       errors.seterror(2741, osberror);
       RAISE  EX.CONTROLLED_ERROR;
    END IF;*/
     -- todos por fecha de vencimientos

   --todos por fecha de final de movimientos
  -- IF sbFlagConsEjec = 'S' AND sbFlagOtCoEjec = 'S' THEN
    --- dbms_output.put_line('ingreso aqui');
     FOR reg IN cuPeriodosFF LOOP
   --  dbms_output.put_line('ingreso aqui'||reg.pefacodi);
		nuerror := null;
		osberror := null;
		dtFechaPago := NULL;
		/*NUMES := NULL;
		open cuperiodoant(reg.pefacicl, reg.pefafimo);
		fetch cuperiodoant into nuperiante, dtFechaPago ,NUMES;
		close cuperiodoant;
		if nuperiante is not null then*/

          prGeneFinanConc ( reg.pefacodi,
                            reg.pefames,
                            'T',
                            reg.PEFAFEPA,
                              nuerror,
                              osberror);
          IF nuerror = 0 THEN
            COMMIT;
          ELSE
            ROLLBACK;
          END IF;
   -- end if;
   END LOOP;
   --END IF;
     ldc_proactualizaestaprog(nutsess,osberror,'LLENARNOTATEMP','ok');

     ldc_proinsertaestaprog(nuparano,nuparmes,'PROCESANOTAS','En ejecucion',nutsess,sbparuser);
     ldc_pkgenotadife.fnuPrincipal(nusesion,nuerror,osberror);
     ldc_proactualizaestaprog(nutsess,osberror,'PROCESANOTAS','ok');

	 /*ldc_proinsertaestaprog(nuparano,nuparmes,'ACTUALIZACUPOBRILLA','En ejecucion',nutsess,sbparuser);
     nuerrorBloqCupo := ActualizaCupoBrilla(osberrorBloqCupo);
     IF nuerrorBloqCupo = -1 and nuerror = -1 then
       osberror := osberror || ' - ' || osberrorBloqCupo;
     ELSIF  nuerrorBloqCupo = -1 and nuerror = 0 then
       osberror := osberrorBloqCupo;
     END IF;
     ldc_proactualizaestaprog(nutsess,osberror,'ACTUALIZACUPOBRILLA','ok');*/


     tParametros.delete;
     ldc_proactualizaestaprog(nutsess,osberror,'PRFINADEUDPCONTI','ok');
  END IF;
  UT_TRACE.TRACE('[PRFINADEUDPCONTI] FIN ',10);
exception
  WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror,osberror);
      ldc_proactualizaestaprog(nutsess,osberror,'PRFINADEUDPCONTI','error');
    WHEN OTHERS THEN
       ERRORS.SETERROR;
       ERRORS.geterror(nuerror,osberror);
       ldc_proactualizaestaprog(nutsess,osberror,'PRFINADEUDPCONTI','error');
 END prFinaDeudpConti;
END ldc_pkggecoprfamas;
/

PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGGECOPRFAMAS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGGECOPRFAMAS', 'ADM_PERSON'); 
END;
/

