declare

  TYPE TYDIFECODI IS TABLE OF open.DIFERIDO.DIFECODI%TYPE INDEX BY BINARY_INTEGER;

  TYPE TYCATRCONS IS TABLE OF open.CARGTRAM.CATRCONS%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRCUCO IS TABLE OF open.CARGTRAM.CATRCUCO%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRNUSE IS TABLE OF open.CARGTRAM.CATRNUSE%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRCONC IS TABLE OF open.CARGTRAM.CATRCONC%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRCACA IS TABLE OF open.CARGTRAM.CATRCACA%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRSIGN IS TABLE OF open.CARGTRAM.CATRSIGN%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRPEFA IS TABLE OF open.CARGTRAM.CATRPEFA%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRCARE IS TABLE OF open.CARGTRAM.CATRCARE%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRVALO IS TABLE OF open.CARGTRAM.CATRVALO%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRDOSO IS TABLE OF open.CARGTRAM.CATRDOSO%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRCODO IS TABLE OF open.CARGTRAM.CATRCODO%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRUSUA IS TABLE OF open.CARGTRAM.CATRUSUA%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRTIPR IS TABLE OF open.CARGTRAM.CATRTIPR%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRUNID IS TABLE OF open.CARGTRAM.CATRUNID%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRFECR IS TABLE OF open.CARGTRAM.CATRFECR%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRPROG IS TABLE OF open.CARGTRAM.CATRPROG%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRVARE IS TABLE OF open.CARGTRAM.CATRVARE%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRVAAC IS TABLE OF open.CARGTRAM.CATRVAAC%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRFLCH IS TABLE OF open.CARGTRAM.CATRFLCH%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRCOLL IS TABLE OF open.CARGTRAM.CATRCOLL%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRUNRE IS TABLE OF open.CARGTRAM.CATRUNRE%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRUNAC IS TABLE OF open.CARGTRAM.CATRUNAC%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRMOTI IS TABLE OF open.CARGTRAM.CATRMOTI%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRVABL IS TABLE OF open.CARGTRAM.CATRVABL%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRVBLR IS TABLE OF open.CARGTRAM.CATRVBLR%TYPE INDEX BY BINARY_INTEGER;
  TYPE TYCATRVBLA IS TABLE OF open.CARGTRAM.CATRVBLA%TYPE INDEX BY BINARY_INTEGER;

  TYPE TYTBCARGTRAM IS RECORD(
    CATRCONS TYCATRCONS,
    CATRCUCO TYCATRCUCO,
    CATRNUSE TYCATRNUSE,
    CATRCONC TYCATRCONC,
    CATRCACA TYCATRCACA,
    CATRSIGN TYCATRSIGN,
    CATRPEFA TYCATRPEFA,
    CATRCARE TYCATRCARE,
    CATRVALO TYCATRVALO,
    CATRDOSO TYCATRDOSO,
    CATRCODO TYCATRCODO,
    CATRUSUA TYCATRUSUA,
    CATRTIPR TYCATRTIPR,
    CATRUNID TYCATRUNID,
    CATRFECR TYCATRFECR,
    CATRPROG TYCATRPROG,
    CATRVARE TYCATRVARE,
    CATRVAAC TYCATRVAAC,
    CATRFLCH TYCATRFLCH,
    CATRCOLL TYCATRCOLL,
    CATRUNRE TYCATRUNRE,
    CATRUNAC TYCATRUNAC,
    CATRMOTI TYCATRMOTI,
    CATRVABL TYCATRVABL,
    CATRVBLR TYCATRVBLR,
    CATRVBLA TYCATRVBLA);

  TYPE TYRCDEFERREDVALUES IS RECORD(
    DIFECODI open.DIFERIDO.DIFECODI%TYPE,
    DIFECONC open.DIFERIDO.DIFECONC%TYPE,
    DIFEVATD open.DIFERIDO.DIFEVATD%TYPE,
    DIFEVAMO NUMBER);

  TYPE TYTBDEFERREDVALUES IS TABLE OF TYRCDEFERREDVALUES;

  TYPE TYRCCUCOCHARGE IS RECORD(
    CARGCONC open.CARGOS.CARGCONC%TYPE,
    CARGSIGN open.CARGOS.CARGSIGN%TYPE,
    CARGVALO open.CARGOS.CARGVALO%TYPE,
    CARGFECR open.CARGOS.CARGFECR%TYPE,
    CARGUNID open.CARGOS.CARGUNID%TYPE,
    CARGDOSO open.CARGOS.CARGDOSO%TYPE,
    CARGCODO open.CARGOS.CARGCODO%TYPE);
  TYPE TYTBCUCOCHARGES IS TABLE OF TYRCCUCOCHARGE INDEX BY VARCHAR2(30);

  TYPE TYRCACCOUNT IS RECORD(
    CUCOSACU          open.CUENCOBR.CUCOSACU%TYPE,
    CUCOFEVE          open.CUENCOBR.CUCOFEVE%TYPE,
    NUACCOUNTAGE      NUMBER,
    NUACCOUNTAGERANGE NUMBER,
    TBCHARGES         TYTBCUCOCHARGES);
  TYPE TYTBACCOUNTS IS TABLE OF TYRCACCOUNT INDEX BY VARCHAR2(10);

  GTBACCOUNTS TYTBACCOUNTS;

  TYPE TYRCBALANCEACCOUNT IS RECORD(
    CUCOCODI open.CUENCOBR.CUCOCODI%TYPE,
    CONCCODI open.CONCEPTO.CONCCODI%TYPE,
    CUCODIVE NUMBER(10),
    SALDVALO NUMBER(16, 3));

  TYPE TYTBBALANCEACCOUNTS IS TABLE OF TYRCBALANCEACCOUNT INDEX BY VARCHAR2(20);

  TYPE TYRCDEFERREDBALANCE IS RECORD(
    CONCCODI open.CONCEPTO.CONCCODI%TYPE,
    SALDVALO NUMBER(16, 3));

  TYPE TYTBDEFERREDBALANCE IS TABLE OF TYRCDEFERREDBALANCE INDEX BY VARCHAR2(20);

  TYPE fa_tyobChargesByDate IS RECORD(
    cargrowid varchar2(30),
    cargcuco  number(10),
    cargconc  number(4),
    cargsign  varchar2(2),
    cargvalo  number(13, 2),
    cargfecr  date,
    cargunid  number(15, 4),
    cargdoso  varchar2(30),
    cargcodo  number(10, 0));
  TYPE fa_tytbChargesByDate IS TABLE OF fa_tyobChargesByDate;

  GTBCHARGESBYDATE FA_TYTBCHARGESBYDATE;

  blKeepProcess BOOLEAN;
  cursor cuOrdenes is
    select ooa.subscription_id contrato,
           trunc(oo.legalization_date) fechalegalizacion
      from open.or_order oo,
           open.or_order_activity ooa,
           ((SELECT trim(regexp_substr( --'149799183,149907394,150000152,150109550,150109701,150198040,150433609',
                                       '149799183,149907394,150000152,150109550,150109701,150198040,150433609,150433626,150433664,150433788,150433895,150479811,150479839,150479880,150480046,150480353,150480377,150480400,150480401,150480415,150480428,150480471,150480522,150480543,150480616,150480665,150480724,150480726,150481140,150613838,150614204,150614275,150614305,150614621,150614623,150614693,150614848',
                                       '[^,]+',
                                       1,
                                       LEVEL)) AS orden
               FROM dual
             CONNECT BY regexp_substr( --'149799183,149907394,150000152,150109550,150109701,150198040,150433609',
                                      '149799183,149907394,150000152,150109550,150109701,150198040,150433609,150433626,150433664,150433788,150433895,150479811,150479839,150479880,150480046,150480353,150480377,150480400,150480401,150480415,150480428,150480471,150480522,150480543,150480616,150480665,150480724,150480726,150481140,150613838,150614204,150614275,150614305,150614621,150614623,150614693,150614848',
                                      '[^,]+',
                                      1,
                                      LEVEL) IS NOT NULL) B)
     where oo.order_id = ooa.order_id
       and b.orden = ooa.order_id;
  rfcuOrdenes cuOrdenes%rowtype;

  cursor cuContratos is
    SELECT trim(regexp_substr('23998,45206,58251,65103,70245,70974,92022,214533,285330,370495,428706,431756,435155,440110,454509,454666,461126,462504,468326,480786,483120,500204,502157,507685,510973,541932,559755,592265,603711,604431,614333,614351,711524,903193,916484,1104055,1174535',
                              '[^,]+',
                              1,
                              LEVEL)) contrato
      FROM dual
    CONNECT BY regexp_substr('23998,45206,58251,65103,70245,70974,92022,214533,285330,370495,428706,431756,435155,440110,454509,454666,461126,462504,468326,480786,483120,500204,502157,507685,510973,541932,559755,592265,603711,604431,614333,614351,711524,903193,916484,1104055,1174535',
                             '[^,]+',
                             1,
                             LEVEL) IS NOT NULL;
  rfcuContratos cuContratos%rowtype;

  FUNCTION GetAccWithBalByProd(inuContraro          IN open.servsusc.sesususc%TYPE,
                               idtFechaLegalizacion date) return boolean is
  
    -- Variable declarations
    l_INUPRODUCTID            NUMBER;
    l_IDTDATE                 DATE;
    l_ONUCURRENTACCOUNTTOTAL  NUMBER;
    l_ONUDEFERREDACCOUNTTOTAL NUMBER;
    l_ONUCREDITBALANCE        NUMBER;
    l_ONUCLAIMVALUE           NUMBER;
    l_ONUDEFCLAIMVALUE        NUMBER;
    l_OTBBALANCEACCOUNTS      TYTBBALANCEACCOUNTS;
    l_OTBDEFERREDBALANCE      TYTBDEFERREDBALANCE;
  
    sbIndexAcc varchar2(20);
    sbIndexDif varchar2(20);
  
    cursor cuservicios(inuContrato number) is
      select a.* from open.servsusc a where a.sesususc = inuContrato;
  
    rfcuservicios cuservicios%rowtype;
  
    nuCuentaCobro            open.cuencobr.cucocodi%type;
    nuCuenCobrCantidadPreLEg number;
    nuCuenCobrCantidadPosLEg number;
  
    oblKeepProcess boolean;
  
    --Cursor para establecer las cuentas de cobro con saldo pendiente que maneja
    --el producto en el momento del pago
    CURSOR cuGetAccWithBalByProd(inuSusc NUMBER, InuServicio Number) IS
      SELECT COUNT(cuco.cucocodi) ACCBAL
        FROM open.SERVSUSC SER, open.CUENCOBR CUCO
       WHERE SER.SESUSUSC = inuSusc
         and ser.sesunuse = InuServicio
         AND CUCO.CUCONUSE = SER.SESUNUSE
         AND CUCO.CUCOFEVE < trunc(idtFechaLegalizacion) --SYSDATE
         AND CUCO.CUCOSACU IS NOT NULL;
  
    PROCEDURE PRODUCTBALANCEACCOUNTSTODATE(INUPRODUCTID            IN open.SERVSUSC.SESUNUSE%TYPE,
                                           IDTDATE                 IN DATE,
                                           ONUCURRENTACCOUNTTOTAL  OUT NUMBER,
                                           ONUDEFERREDACCOUNTTOTAL OUT NUMBER,
                                           ONUCREDITBALANCE        OUT NUMBER,
                                           ONUCLAIMVALUE           OUT NUMBER,
                                           ONUDEFCLAIMVALUE        OUT NUMBER,
                                           OTBBALANCEACCOUNTS      OUT NOCOPY TYTBBALANCEACCOUNTS,
                                           OTBDEFERREDBALANCE      OUT NOCOPY TYTBDEFERREDBALANCE) IS
      RCPRODUCTO       open.SERVSUSC%ROWTYPE;
      RCCONTRATO       open.SUSCRIPC%ROWTYPE;
      TBACCOUNTS       TYTBACCOUNTS;
      TBDEFERREDVALUES TYTBDEFERREDVALUES;
      NUDIFERENCIA     NUMBER;
      NUIDX            NUMBER;
      TBCLAIMSVALUES   TYTBCARGTRAM;
      SBSUPDOCUMENT    open.CARGTRAM.CATRDOSO%TYPE;
      NUINDEX          BINARY_INTEGER;
      SBDEFERREDID     VARCHAR2(15);
      TBCLAIMDEF       TYDIFECODI;
    
      PROCEDURE GETCHARGES(INUSUSCCODI  IN open.SUSCRIPC.SUSCCODI%TYPE,
                           INUPRODUCTID IN open.SERVSUSC.SESUNUSE%TYPE,
                           IDTDATE      IN DATE) IS
      
        TYPE TYRCACCOUNTBYDATE IS RECORD(
          CUCOCODI open.CUENCOBR.CUCOCODI%TYPE,
          CUCOSACU open.CUENCOBR.CUCOSACU%TYPE,
          CUCOFEVE open.CUENCOBR.CUCOFEVE%TYPE);
      
        TYPE TYTBACCOUNTBYDATE IS TABLE OF TYRCACCOUNTBYDATE;
      
        TYPE TYRCCHARGES IS RECORD(
          CARGROWID VARCHAR2(30),
          CARGCONC  open.CARGOS.CARGCONC%TYPE,
          CARGSIGN  open.CARGOS.CARGSIGN%TYPE,
          CARGVALO  open.CARGOS.CARGVALO%TYPE,
          CARGFECR  open.CARGOS.CARGFECR%TYPE,
          CARGUNID  open.CARGOS.CARGUNID%TYPE,
          CARGDOSO  open.CARGOS.CARGDOSO%TYPE,
          CARGCODO  open.CARGOS.CARGCODO%TYPE);
      
        TYPE TYTBCHARGES IS TABLE OF TYRCCHARGES;
      
        DTFECHACONSULTA DATE;
        TBACCOUNTBYDATE TYTBACCOUNTBYDATE;
        NUIDX           NUMBER;
        NUIDX2          NUMBER;
        TBCHARGES       TYTBCHARGES;
        TBCUCOCHARGES   TYTBCUCOCHARGES;
        RCCUCOCHARGE    TYRCCUCOCHARGE;
        RCACCOUNT       TYRCACCOUNT;
        OBCHARGESBYDATE FA_TYOBCHARGESBYDATE;
      
        PROCEDURE GETACCOUNTSBYDATE(INUSUSCCODI     IN open.SUSCRIPC.SUSCCODI%TYPE,
                                    INUPRODUCTID    IN open.SERVSUSC.SESUNUSE%TYPE,
                                    IDTDATE         IN DATE,
                                    TBACCOUNTBYDATE OUT TYTBACCOUNTBYDATE) IS
        
          CURSOR CUCONSULTA IS
            SELECT /*+ leading(factura)
                                                                                index(factura IX_FACTURA06)
                                                                                use_nl(factura cuencobr)
                                                                                index(cuencobr IDXCUCO_RELA)
                                                                            */
             CUCOCODI, CUCOSACU, CUCOFEVE
              FROM /*+ pkBCCuencobr.GetAccountsByDate */ open.FACTURA,
                   open.CUENCOBR
             WHERE CUCOFACT = FACTCODI
               AND FACTSUSC = INUSUSCCODI
               AND FACTFEGE >= IDTDATE
               AND CUCONUSE = INUPRODUCTID;
          EXERROR_LEVEL2 EXCEPTION;
        BEGIN
        
          --PKERRORS.PUSH('pkBCCuencobr.GetAccountsByDate');
          DBMS_OUTPUT.put_line('Inicio [pkBCCuencobr.GetAccountsByDate]');
        
          IF (CUCONSULTA%ISOPEN) THEN
          
            CLOSE CUCONSULTA;
          
          END IF;
        
          OPEN CUCONSULTA;
          FETCH CUCONSULTA BULK COLLECT
            INTO TBACCOUNTBYDATE;
          CLOSE CUCONSULTA;
        
          --PKERRORS.POP;
          DBMS_OUTPUT.put_line('Fin [pkBCCuencobr.GetAccountsByDate]');
        
        EXCEPTION
        
          WHEN LOGIN_DENIED OR EXERROR_LEVEL2
          --OR EX.CONTROLLED_ERROR 
           THEN
          
            IF (CUCONSULTA%ISOPEN) THEN
            
              CLOSE CUCONSULTA;
            
            END IF;
            DBMS_OUTPUT.put_line('LOGIN_DENIED [pkBCCuencobr.GetAccountsByDate]');
            --PKERRORS.POP;
            RAISE;
          
          WHEN OTHERS THEN
          
            IF (CUCONSULTA%ISOPEN) THEN
            
              CLOSE CUCONSULTA;
            
            END IF;
            --PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            --PKERRORS.POP;
            DBMS_OUTPUT.put_line('OTHERS [pkBCCuencobr.GetAccountsByDate]');
            --RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
            raise;
          
        END GETACCOUNTSBYDATE;
      
        PROCEDURE GETACCOUNTCHARGES(INUPRODUCTID IN open.SERVSUSC.SESUNUSE%TYPE,
                                    INUCUCOCODI  IN open.CUENCOBR.CUCOCODI%TYPE,
                                    OTBCHARGES   OUT TYTBCHARGES) IS
          CURSOR CUCONSULTA IS
            SELECT
            /*+ index(cargos IX_CARG_NUSE_CUCO_CONC) */
             ROWIDTOCHAR(ROWID),
             CARGCONC,
             CARGSIGN,
             CARGVALO,
             CARGFECR,
             CARGUNID,
             CARGDOSO,
             CARGCODO
              FROM open.CARGOS
             WHERE CARGNUSE = INUPRODUCTID
               AND CARGCUCO = INUCUCOCODI;
        BEGIN
          --PKERRORS.PUSH('FA_BCAccountStatusToDate.GetAccountCharges');
        
          IF (CUCONSULTA%ISOPEN) THEN
            CLOSE CUCONSULTA;
          END IF;
        
          OPEN CUCONSULTA;
          FETCH CUCONSULTA BULK COLLECT
            INTO OTBCHARGES;
          CLOSE CUCONSULTA;
        
          --PKERRORS.POP;
        EXCEPTION
          WHEN LOGIN_DENIED THEN
            --PKERRORS.POP;
            IF (CUCONSULTA%ISOPEN) THEN
              CLOSE CUCONSULTA;
            END IF;
            RAISE;
          WHEN OTHERS THEN
            --PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            --PKERRORS.POP;
            IF (CUCONSULTA%ISOPEN) THEN
              CLOSE CUCONSULTA;
            END IF;
            --RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
            RAISE;
        END GETACCOUNTCHARGES;
      
      BEGIN
        --PKERRORS.PUSH('FA_BOAccountStatusToDate.GetCharges');
      
        DTFECHACONSULTA := IDTDATE - 2190;
        DBMS_OUTPUT.put_line('Fecha de consulta para cargos (1 a�o atras): ' ||
                             DTFECHACONSULTA);
      
        GETACCOUNTSBYDATE(INUSUSCCODI,
                          INUPRODUCTID,
                          DTFECHACONSULTA,
                          TBACCOUNTBYDATE);
      
        DBMS_OUTPUT.put_line('Cantidad de cuentas de cobro: ' ||
                             TBACCOUNTBYDATE.COUNT);
      
        NUIDX := TBACCOUNTBYDATE.FIRST;
      
        LOOP
          EXIT WHEN(NUIDX IS NULL);
        
          DBMS_OUTPUT.put_line('Obteniendo cargos de la cuenta de cobro: ' || TBACCOUNTBYDATE(NUIDX)
                               .CUCOCODI);
        
          GETACCOUNTCHARGES(INUPRODUCTID,
                            TBACCOUNTBYDATE(NUIDX).CUCOCODI,
                            TBCHARGES);
        
          DBMS_OUTPUT.put_line('Cantidad de cargos: ' || TBCHARGES.COUNT);
        
          NUIDX2 := TBCHARGES.FIRST;
          TBCUCOCHARGES.DELETE;
        
          LOOP
            EXIT WHEN(NUIDX2 IS NULL);
          
            IF TBCHARGES(NUIDX2).CARGFECR > IDTDATE THEN
              /*OBCHARGESBYDATE := FA_TYOBCHARGESBYDATE(NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL,
              NULL);*/
            
              OBCHARGESBYDATE.CARGROWID := null;
              OBCHARGESBYDATE.CARGCONC  := null;
              OBCHARGESBYDATE.CARGSIGN  := null;
              OBCHARGESBYDATE.CARGVALO  := null;
              OBCHARGESBYDATE.CARGFECR  := null;
              OBCHARGESBYDATE.CARGUNID  := null;
              OBCHARGESBYDATE.CARGDOSO  := null;
              OBCHARGESBYDATE.CARGCODO  := null;
              OBCHARGESBYDATE.CARGCUCO  := null;
            
              OBCHARGESBYDATE.CARGROWID := TBCHARGES(NUIDX2).CARGROWID;
              OBCHARGESBYDATE.CARGCONC  := TBCHARGES(NUIDX2).CARGCONC;
              OBCHARGESBYDATE.CARGSIGN  := TBCHARGES(NUIDX2).CARGSIGN;
              OBCHARGESBYDATE.CARGVALO  := TBCHARGES(NUIDX2).CARGVALO;
              OBCHARGESBYDATE.CARGFECR  := TBCHARGES(NUIDX2).CARGFECR;
              OBCHARGESBYDATE.CARGUNID  := TBCHARGES(NUIDX2).CARGUNID;
              OBCHARGESBYDATE.CARGDOSO  := TBCHARGES(NUIDX2).CARGDOSO;
              OBCHARGESBYDATE.CARGCODO  := TBCHARGES(NUIDX2).CARGCODO;
              OBCHARGESBYDATE.CARGCUCO  := TBACCOUNTBYDATE(NUIDX).CUCOCODI;
            
              GTBCHARGESBYDATE.EXTEND;
              GTBCHARGESBYDATE(GTBCHARGESBYDATE.LAST) := OBCHARGESBYDATE;
            END IF;
          
            RCCUCOCHARGE.CARGCONC := TBCHARGES(NUIDX2).CARGCONC;
            RCCUCOCHARGE.CARGSIGN := TBCHARGES(NUIDX2).CARGSIGN;
            RCCUCOCHARGE.CARGVALO := TBCHARGES(NUIDX2).CARGVALO;
            RCCUCOCHARGE.CARGFECR := TBCHARGES(NUIDX2).CARGFECR;
            RCCUCOCHARGE.CARGUNID := TBCHARGES(NUIDX2).CARGUNID;
            RCCUCOCHARGE.CARGDOSO := TBCHARGES(NUIDX2).CARGDOSO;
            RCCUCOCHARGE.CARGCODO := TBCHARGES(NUIDX2).CARGCODO;
          
            TBCUCOCHARGES(TBCHARGES(NUIDX2).CARGROWID) := RCCUCOCHARGE;
          
            NUIDX2 := TBCHARGES.NEXT(NUIDX2);
          END LOOP;
        
          RCACCOUNT.CUCOSACU  := NVL(TBACCOUNTBYDATE(NUIDX).CUCOSACU, 0);
          RCACCOUNT.CUCOFEVE  := TBACCOUNTBYDATE(NUIDX).CUCOFEVE;
          RCACCOUNT.TBCHARGES := TBCUCOCHARGES;
        
          GTBACCOUNTS(TBACCOUNTBYDATE(NUIDX).CUCOCODI) := RCACCOUNT;
        
          NUIDX := TBACCOUNTBYDATE.NEXT(NUIDX);
        END LOOP;
      
        DBMS_OUTPUT.put_line('Cantidad de cargos a procesar: ' ||
                             GTBCHARGESBYDATE.COUNT);
      
        --PKERRORS.POP;
      EXCEPTION
        WHEN LOGIN_DENIED --OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR 
         THEN
          --PKERRORS.POP;
          RAISE;
        WHEN OTHERS THEN
          --PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          --PKERRORS.POP;
          --RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
          RAISE;
      END GETCHARGES;
    
      PROCEDURE PROCESSCHARGES(ONUCREDITBALANCE IN OUT NUMBER) IS
        NUIDX     NUMBER;
        RCACCOUNT TYRCACCOUNT;
      BEGIN
        --PKERRORS.PUSH('FA_BOAccountStatusToDate.ProcessCharges');
      
        SELECT CAST(MULTISET (SELECT FA_TYOBCHARGESBYDATE(CARGROWID,
                                                 CARGCUCO,
                                                 CARGCONC,
                                                 CARGSIGN,
                                                 CARGVALO,
                                                 CARGFECR,
                                                 CARGUNID,
                                                 CARGDOSO,
                                                 CARGCODO)
                       FROM TABLE(GTBCHARGESBYDATE)
                      ORDER BY CARGFECR DESC) AS FA_TYTBCHARGESBYDATE)
          INTO GTBCHARGESBYDATE
          FROM DUAL;
      
        NUIDX := GTBCHARGESBYDATE.FIRST;
        LOOP
          EXIT WHEN(NUIDX IS NULL);
        
          UT_TRACE.TRACE('Procesando cargo.: ' || GTBCHARGESBYDATE(NUIDX)
                         .CARGVALO,
                         5);
        
          RCACCOUNT := GTBACCOUNTS(GTBCHARGESBYDATE(NUIDX).CARGCUCO);
        
          IF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.DEBITO THEN
            RCACCOUNT.CUCOSACU := RCACCOUNT.CUCOSACU - GTBCHARGESBYDATE(NUIDX)
                                 .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.CREDITO THEN
            RCACCOUNT.CUCOSACU := RCACCOUNT.CUCOSACU + GTBCHARGESBYDATE(NUIDX)
                                 .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.DEVOLUCION THEN
            ONUCREDITBALANCE := ONUCREDITBALANCE + GTBCHARGESBYDATE(NUIDX)
                               .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.ANULA_DEV THEN
            ONUCREDITBALANCE := ONUCREDITBALANCE - GTBCHARGESBYDATE(NUIDX)
                               .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.SALDOFAVOR THEN
            RCACCOUNT.CUCOSACU := RCACCOUNT.CUCOSACU - GTBCHARGESBYDATE(NUIDX)
                                 .CARGVALO;
          
            ONUCREDITBALANCE := ONUCREDITBALANCE - GTBCHARGESBYDATE(NUIDX)
                               .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.ANULASALDO THEN
            RCACCOUNT.CUCOSACU := RCACCOUNT.CUCOSACU + GTBCHARGESBYDATE(NUIDX)
                                 .CARGVALO;
          
            ONUCREDITBALANCE := ONUCREDITBALANCE + GTBCHARGESBYDATE(NUIDX)
                               .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.APLSALDFAV THEN
            RCACCOUNT.CUCOSACU := RCACCOUNT.CUCOSACU + GTBCHARGESBYDATE(NUIDX)
                                 .CARGVALO;
          
            ONUCREDITBALANCE := ONUCREDITBALANCE + GTBCHARGESBYDATE(NUIDX)
                               .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.PAGO THEN
            RCACCOUNT.CUCOSACU := RCACCOUNT.CUCOSACU + GTBCHARGESBYDATE(NUIDX)
                                 .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX).CARGSIGN = PKBILLCONST.ANULAPAGO THEN
            RCACCOUNT.CUCOSACU := RCACCOUNT.CUCOSACU - GTBCHARGESBYDATE(NUIDX)
                                 .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX)
           .CARGSIGN = PKBILLCONST.TRAS_SALDO_FAVOR THEN
            ONUCREDITBALANCE := ONUCREDITBALANCE + GTBCHARGESBYDATE(NUIDX)
                               .CARGVALO;
          
          ELSIF GTBCHARGESBYDATE(NUIDX)
           .CARGSIGN = PKBILLCONST.SALDO_FAVOR_TRAS THEN
            ONUCREDITBALANCE := ONUCREDITBALANCE - GTBCHARGESBYDATE(NUIDX)
                               .CARGVALO;
          END IF;
        
          RCACCOUNT.TBCHARGES.DELETE(GTBCHARGESBYDATE(NUIDX).CARGROWID);
        
          UT_TRACE.TRACE('Saldo de la cuenta: ' || RCACCOUNT.CUCOSACU, 5);
        
          GTBACCOUNTS(GTBCHARGESBYDATE(NUIDX).CARGCUCO) := RCACCOUNT;
        
          NUIDX := GTBCHARGESBYDATE.NEXT(NUIDX);
        END LOOP;
      
        PKERRORS.POP;
      EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR
             EX.CONTROLLED_ERROR THEN
          PKERRORS.POP;
          RAISE;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
      END PROCESSCHARGES;
    
    BEGIN
      --PKERRORS.PUSH('FA_BOAccountStatusToDate.ProductBalanceAccountsToDate');
      dbms_output.put_line('FA_BOAccountStatusToDate.ProductBalanceAccountsToDate');
    
      GTBACCOUNTS.DELETE;
      GTBCHARGESBYDATE := FA_TYTBCHARGESBYDATE();
    
      ONUCURRENTACCOUNTTOTAL  := 0;
      ONUDEFERREDACCOUNTTOTAL := 0;
      ONUCLAIMVALUE           := 0;
      ONUDEFCLAIMVALUE        := 0;
    
      --RCPRODUCTO := "OPEN".PKTBLSERVSUSC.FRCGETRECORD(INUPRODUCTID, 0);
    
      select *
        into RCPRODUCTO
        from open.servsusc a
       where a.sesunuse = INUPRODUCTID;
    
      --RCCONTRATO := PKTBLSUSCRIPC.FRCGETRECORD(RCPRODUCTO.SESUSUSC);
    
      select *
        into RCCONTRATO
        from open.suscripc a
       where a.susccodi = RCPRODUCTO.SESUSUSC;
    
      ONUCREDITBALANCE := NVL(RCPRODUCTO.SESUSAFA, 0);
    
      GETCHARGES(RCCONTRATO.SUSCCODI, INUPRODUCTID, IDTDATE);
    
      PROCESSCHARGES(ONUCREDITBALANCE);
    
      PROCESSACCOUNTS(INUPRODUCTID,
                      IDTDATE,
                      ONUCURRENTACCOUNTTOTAL,
                      OTBBALANCEACCOUNTS);
    
      UT_TRACE.TRACE('Cartera corriente: ' || ONUCURRENTACCOUNTTOTAL, 6);
    
      FA_BCACCOUNTSTATUSTODATE.GETCLAIMVALUES(INUPRODUCTID,
                                              IDTDATE,
                                              TBCLAIMSVALUES);
    
      UT_TRACE.TRACE('Registros de CARGTRAM: ' ||
                     TBCLAIMSVALUES.CATRCONS.COUNT,
                     6);
    
      NUINDEX := TBCLAIMSVALUES.CATRCONS.FIRST;
    
      LOOP
        EXIT WHEN NUINDEX IS NULL;
      
        IF TBCLAIMSVALUES.CATRSIGN(NUINDEX) = CC_BOCONSTANTS.CSBCR THEN
        
          ONUCLAIMVALUE := ONUCLAIMVALUE - TBCLAIMSVALUES.CATRVARE(NUINDEX);
        ELSE
          ONUCLAIMVALUE := ONUCLAIMVALUE + TBCLAIMSVALUES.CATRVARE(NUINDEX);
        
        END IF;
        UT_TRACE.TRACE('Valor en reclamo: ' || ONUCLAIMVALUE, 7);
      
        SBSUPDOCUMENT := TBCLAIMSVALUES.CATRDOSO(NUINDEX);
        UT_TRACE.TRACE('Documento de soporte: ' || SBSUPDOCUMENT, 7);
      
        IF (CC_BOGRACE_PERI_DEFE.FBOISDEFERRED(SBSUPDOCUMENT)) THEN
        
          SBDEFERREDID := SUBSTR(SBSUPDOCUMENT, 4);
        
          PKTBLDIFERIDO.ACCKEY(SBDEFERREDID);
        
          TBCLAIMDEF(SBDEFERREDID) := SBDEFERREDID;
        
        END IF;
      
        NUINDEX := TBCLAIMSVALUES.CATRCONS.NEXT(NUINDEX);
      
      END LOOP;
    
      UT_TRACE.TRACE('Valor en reclamo final: ' || ONUCLAIMVALUE, 6);
      UT_TRACE.TRACE('Numero de diferidos con reclamos: ' ||
                     TBCLAIMDEF.COUNT,
                     6);
    
      FA_BCACCOUNTSTATUSTODATE.GETDEFERREDVALUES(INUPRODUCTID,
                                                 IDTDATE,
                                                 TBDEFERREDVALUES);
    
      UT_TRACE.TRACE('Diferidos a la fecha: ' || TBDEFERREDVALUES.COUNT, 6);
    
      NUIDX := TBDEFERREDVALUES.FIRST;
    
      LOOP
        EXIT WHEN(NUIDX IS NULL);
      
        NUDIFERENCIA := TBDEFERREDVALUES(NUIDX)
                        .DIFEVATD - NVL(TBDEFERREDVALUES(NUIDX).DIFEVAMO, 0);
      
        UT_TRACE.TRACE('Cod. Diferido          : ' || TBDEFERREDVALUES(NUIDX)
                       .DIFECODI,
                       6);
        UT_TRACE.TRACE('Valor total diferido   : ' || TBDEFERREDVALUES(NUIDX)
                       .DIFEVATD,
                       6);
        UT_TRACE.TRACE('Valor total movimientos: ' ||
                       NVL(TBDEFERREDVALUES(NUIDX).DIFEVAMO, 0),
                       6);
        UT_TRACE.TRACE('Diferencia: ' || NUDIFERENCIA, 6);
      
        IF NUDIFERENCIA > 0 THEN
        
          ONUDEFERREDACCOUNTTOTAL := ONUDEFERREDACCOUNTTOTAL + NUDIFERENCIA;
          UT_TRACE.TRACE('Cartera diferida: ' || ONUDEFERREDACCOUNTTOTAL,
                         6);
        
          IF (TBCLAIMDEF.EXISTS(TBDEFERREDVALUES(NUIDX).DIFECODI)) THEN
          
            ONUDEFCLAIMVALUE := ONUDEFCLAIMVALUE + NUDIFERENCIA;
          END IF;
        
          UT_TRACE.TRACE('Saldo diferido en reclamo: ' || ONUDEFCLAIMVALUE,
                         6);
        
          IF OTBDEFERREDBALANCE.EXISTS(TBDEFERREDVALUES(NUIDX).DIFECONC) THEN
            OTBDEFERREDBALANCE(TBDEFERREDVALUES(NUIDX).DIFECONC).SALDVALO := OTBDEFERREDBALANCE(TBDEFERREDVALUES(NUIDX).DIFECONC)
                                                                             .SALDVALO +
                                                                              NUDIFERENCIA;
          ELSE
            OTBDEFERREDBALANCE(TBDEFERREDVALUES(NUIDX).DIFECONC).CONCCODI := TBDEFERREDVALUES(NUIDX)
                                                                             .DIFECONC;
            OTBDEFERREDBALANCE(TBDEFERREDVALUES(NUIDX).DIFECONC).SALDVALO := NUDIFERENCIA;
          END IF;
        END IF;
      
        NUIDX := TBDEFERREDVALUES.NEXT(NUIDX);
      END LOOP;
    
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR
           EX.CONTROLLED_ERROR THEN
        PKERRORS.POP;
        RAISE;
      WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG);
    END PRODUCTBALANCEACCOUNTSTODATE;
  
  BEGIN
  
    /*ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);*/
  
    oblKeepProcess := FALSE;
    l_IDTDATE      := trunc(idtFechaLegalizacion); --trunc(sysdate); --to_date('25/05/2023','DD/MM/YYYY');
    for rfcuservicios in cuservicios(inuContraro) loop
    
      -- Variable initializations
      l_INUPRODUCTID := rfcuservicios.sesunuse;
    
      -- Call
      FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE(INUPRODUCTID            => l_INUPRODUCTID,
                                                            IDTDATE                 => l_IDTDATE,
                                                            ONUCURRENTACCOUNTTOTAL  => l_ONUCURRENTACCOUNTTOTAL,
                                                            ONUDEFERREDACCOUNTTOTAL => l_ONUDEFERREDACCOUNTTOTAL,
                                                            ONUCREDITBALANCE        => l_ONUCREDITBALANCE,
                                                            ONUCLAIMVALUE           => l_ONUCLAIMVALUE,
                                                            ONUDEFCLAIMVALUE        => l_ONUDEFCLAIMVALUE,
                                                            OTBBALANCEACCOUNTS      => l_OTBBALANCEACCOUNTS,
                                                            OTBDEFERREDBALANCE      => l_OTBDEFERREDBALANCE);
    
      sbIndexAcc               := l_OTBBALANCEACCOUNTS.first;
      nuCuentaCobro            := 0;
      nuCuenCobrCantidadPreLEg := 0;
      if sbIndexAcc is not null then
        --Identificar cuentas de cobro con saldo pendiente antes de la legalizacion
        dbms_output.put_line('Producto: ' || rfcuservicios.sesunuse || ' ');
        dbms_output.put_line('*****Recorrido de cuenta de cobro con saldo antes de la legalizacion');
        loop
          if nuCuentaCobro <> l_OTBBALANCEACCOUNTS(sbIndexAcc).cucocodi then
            dbms_output.put_line('**********Cuenta: ' || l_OTBBALANCEACCOUNTS(sbIndexAcc)
                                 .cucocodi || ' ');
            nuCuentaCobro            := l_OTBBALANCEACCOUNTS(sbIndexAcc)
                                        .cucocodi;
            nuCuenCobrCantidadPreLEg := nuCuenCobrCantidadPreLEg + 1;
          end if;
        
          sbIndexAcc := l_OTBBALANCEACCOUNTS.next(sbIndexAcc);
          exit when sbIndexAcc is null;
        end loop;
        dbms_output.put_line('***************Cuentas de cobros pedientes prelegalizacion[' ||
                             nuCuenCobrCantidadPreLEg || ']');
      
        if cuGetAccWithBalByProd%ISOPEN then
          close cuGetAccWithBalByProd;
        end if;
        open cuGetAccWithBalByProd(inuContraro, rfcuservicios.sesunuse);
        fetch cuGetAccWithBalByProd
          into nuCuenCobrCantidadPosLEg;
        close cuGetAccWithBalByProd;
        dbms_output.put_line('***************Cuentas de cobros pedientes poslegalizacion[' ||
                             nuCuenCobrCantidadPosLEg || ']');
      
        if nuCuenCobrCantidadPreLEg <= 1 or nuCuenCobrCantidadPosLEg <> 1 then
          return(TRUE);
        end if;
      
      else
        dbms_output.put_line('***************Sin registros de cuentas');
      end if;
      dbms_output.put_line('-----------------------------------------------------');
    end loop;
    return(FALSE);
  end GetAccWithBalByProd;
begin
  --/*
  for rfcuOrdenes in cuOrdenes loop
  
    dbms_output.put_line('Contrato[' || rfcuOrdenes.contrato ||
                         '] - Fecha Legalizacion[' ||
                         rfcuOrdenes.fechalegalizacion || ']');
  
    blKeepProcess := GetAccWithBalByProd(rfcuOrdenes.contrato,
                                         rfcuOrdenes.fechalegalizacion);
  
    if blKeepProcess then
      dbms_output.put_line('TRUE');
    else
      dbms_output.put_line('FALSE');
    end if;
    dbms_output.put_line('**************************************************');
  
  end loop;
  --*/

  /*for rfcuContratos in cuContratos loop
  
    dbms_output.put_line('Contrato[' || rfcuContratos.contrato || ']');
  
    blKeepProcess := GetAccWithBalByProd(rfcuContratos.contrato, sysdate);
  
    if blKeepProcess then
      dbms_output.put_line('TRUE');
    else
      dbms_output.put_line('FALSE');
    end if;
    dbms_output.put_line('**************************************************');
  
  end loop;*/

end;
