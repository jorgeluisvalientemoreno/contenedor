 /*CREATE OR REPLACE FUNCTION DiscountTimeOutServ
(
    INUCONSUMPTIONTYPE  IN  NUMBER,
    INUFOT              IN  NUMBER DEFAULT TA_BOUTILITARIO.CNUFOT1
)
RETURN NUMBER IS  */
--execute setsystemenviroment;
--set SERVEROUTPUT ON
alter session set current_schema="OPEN";
   declare
   
   INUCONSUMPTIONTYPE    NUMBER:=1;
    INUFOT               NUMBER :=6;--DEFAULT TA_BOUTILITARIO.CNUFOT1;
    SBERRMSG                    GE_ERROR_LOG.DESCRIPTION%TYPE;    
    NUCONSUMPTIONTYPE    NUMBER;   
    NUFOT               NUMBER;
    NUSUBSSERVICE        SERVSUSC.SESUNUSE%TYPE;
    NUSERVICE            SERVSUSC.SESUSERV%TYPE;
    NUCONCEPT            CONCEPTO.CONCCODI%TYPE;
    NUPERICOSEITERAID    PERICOSE.PECSCONS%TYPE;
    NUPERICOSEACTUALID   PERICOSE.PECSCONS%TYPE;
    DTINSTALLDATE        SERVSUSC.SESUFEIN%TYPE;
    NUCOMPONENT          PR_COMPONENT.COMPONENT_ID%TYPE;
    NUCHARGEVALUE        NUMBER;
    RCCOMPSESU           COMPSESU%ROWTYPE;
    CSBMETHODCALCULATION CONSTANT PARAMETR.PAMECODI%TYPE := 'BIL_MECC_FACTURADO';
  
  
  
  
  PROCEDURE GETTARIFF
    (
        INUSERVICIO     IN  NUMBER,
        INUCONCEPTO     IN  NUMBER,
        INUPRODUCTO     IN  NUMBER,
        IDTINITIAL      IN  DATE,
        IDTFINAL        IN  DATE,
        INUFOT          IN  NUMBER,
        ONUVALORTARIFA  OUT TA_VIGETACO.VITCVALO%TYPE
    )
    IS
        NUDUMMYCODTARIFA       TA_TARICONC.TACOCONS%TYPE;
        NUDUMMYCODVIGENCIA     TA_VIGETACO.VITCCONS%TYPE;
        NUDUMMYPORCTARIFA      TA_VIGETACO.VITCPORC%TYPE;

        
        DTSESUFEVI      SERVSUSC.SESUFEVI%TYPE;
    BEGIN
        PKERRORS.PUSH ('FA_BODiscountTimeOutServ.GetTarifa');
        
        
        DTSESUFEVI := PKTBLSERVSUSC.FDTGETSESUFEVI( INUPRODUCTO );

        
        TA_BOTARIFAS.LIQTARIFA
        (
            INUSERVICIO,
            INUCONCEPTO,
            INUPRODUCTO,
            NULL,
            IDTINITIAL,
            IDTFINAL,
            DTSESUFEVI,
            NULL,
            NULL,
            INUFOT,
            PKCONSTANTE.FALSO,
            NUDUMMYCODTARIFA,
            NUDUMMYCODVIGENCIA,
            ONUVALORTARIFA,
            NUDUMMYPORCTARIFA
        );

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETTARIFF;

  
   PROCEDURE CREATECHARGES
    (
        INUSERVICIO         IN  SERVSUSC.SESUSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  SERVSUSC.SESUNUSE%TYPE,
        INUCODINTER         IN  PR_TIMEOUT_COMPONENT.TIMEOUT_COMPONENT_ID%TYPE,
        IDTINITIAL          IN  PR_TIMEOUT_COMPONENT.INITIAL_DATE%TYPE,
        IDTFINAL            IN  PR_TIMEOUT_COMPONENT.FINAL_DATE%TYPE,
        INUCOMPTIME         IN  PR_TIMEOUT_COMPONENT.COMPENSATED_TIME%TYPE,
        INUPECSCICO         IN  PERICOSE.PECSCICO%TYPE,
        NUAVGCONSU          IN  NUMBER,
        INUFOT              IN  NUMBER,
        INUCONSUMPERIOD      IN  PERICOSE.PECSCONS%TYPE,
        INUCONSUMPTIONTYPE  IN  NUMBER
    )
    IS
        
        RFPERIODOS          PKCONSTANTE.TYREFCURSOR;

        
        NUPECSCONS          NUMBER := NULL;

        
        TYPE TYTBPERIODOS IS TABLE OF PERICOSE.PECSCONS%TYPE INDEX BY PLS_INTEGER;

        
        TBPERIODOS TYTBPERIODOS;
        
        NUIDX               NUMBER;

        
        RCPERICOSEINTE      PERICOSE%ROWTYPE;
        
        RCPERICOSEINTENULL  PERICOSE%ROWTYPE;

        
        NUDIAS              NUMBER;
        
        NUPORCE             NUMBER;

        
        NUTARIFA             TA_VIGETACO.VITCVALO%TYPE := 0;

        
        NUHORAS             NUMBER := 0;
        
        NUSUMAHORAS         NUMBER := 0;

        
        NUVALUEDOWNTIMEAUX   NUMBER := 0;
        
        NUVALUEDOWNTIME      NUMBER := 0;
        
        
        SBSUPPORTDOCUM       CARGOS.CARGDOSO%TYPE;
        valor number;
        fecha date;
    BEGIN
        PKERRORS.PUSH ('FA_BODiscountTimeOutServ.CreateCharges');

        PKBCPERICOSE.GETOVERLAPPINGPERIOD
        (
            INUPECSCICO, 
            NULL, 
            IDTINITIAL, 
            IDTFINAL,   
            RFPERIODOS 
        );

        dbms_output.put_line (
            'Fecha Inicial Interrupci�n    : '||
            TO_CHAR(IDTINITIAL,'DD/MM/YYYY HH:MI:SS AM')
        );
        dbms_output.put_line (
            'Fecha Final Interrupci�n      : '
            ||TO_CHAR(IDTFINAL,'DD/MM/YYYY HH:MI:SS AM')
        );
        dbms_output.put_line (
            'Tiempo Autorizado a Compensar : '|| INUCOMPTIME
        );
        dbms_output.put_line (
            'Horas Totales Interrupcion    : '||((IDTFINAL - IDTINITIAL)*24)
        );

        
        FETCH RFPERIODOS BULK COLLECT INTO TBPERIODOS;

        
        NUIDX := TBPERIODOS.FIRST;

        LOOP
            RCPERICOSEINTE := RCPERICOSEINTENULL;
            NUDIAS := 0;
            NUPECSCONS := 0;
            NUPORCE := 0;
            NUHORAS := 0;
            NUVALUEDOWNTIMEAUX := 0;
            NUVALUEDOWNTIME := 0;

            
            EXIT WHEN NUIDX IS NULL;

            
            NUPECSCONS := TBPERIODOS(NUIDX);

            
            RCPERICOSEINTE := PKTBLPERICOSE.FRCGETRECORD( NUPECSCONS );

            dbms_output.put_line (
                CHR(10)||
                'Periodo Procesado               : '||
                NUPECSCONS
            );
            dbms_output.put_line (
                'Fecha Inicial Periodo Procesado : '||
                TO_CHAR(RCPERICOSEINTE.PECSFECI,'DD/MM/YYYY HH:MI:SS AM')
            );
            dbms_output.put_line (
                'Fecha Final Periodo Procesado   : '
                ||TO_CHAR(RCPERICOSEINTE.PECSFECF,'DD/MM/YYYY HH:MI:SS AM')
            );

            
            
            
            
            
            
            IF( IDTINITIAL >= RCPERICOSEINTE.PECSFECI    AND
                IDTFINAL <= RCPERICOSEINTE.PECSFECF          ) THEN
                NUDIAS := IDTFINAL - IDTINITIAL;
            
            dbms_output.put_line ('NUDIAS1');
            dbms_output.put_line ('RCPERICOSEINTE.PECSFECI: '||RCPERICOSEINTE.PECSFECI);
            
            ELSIF( IDTINITIAL >= RCPERICOSEINTE.PECSFECI AND
                   IDTINITIAL < RCPERICOSEINTE.PECSFECF  AND
                   IDTFINAL > RCPERICOSEINTE.PECSFECF        ) THEN
                NUDIAS := RCPERICOSEINTE.PECSFECF - IDTINITIAL;
            dbms_output.put_line ('NUDIAS2');
            
            
            ELSIF( IDTINITIAL < RCPERICOSEINTE.PECSFECI  AND
                   IDTFINAL > RCPERICOSEINTE.PECSFECF       ) THEN
                NUDIAS := RCPERICOSEINTE.PECSFECF - RCPERICOSEINTE.PECSFECI;
            dbms_output.put_line ('NUDIAS3');
            
            
            ELSIF( IDTINITIAL < RCPERICOSEINTE.PECSFECI  AND
                   IDTFINAL <= RCPERICOSEINTE.PECSFECF   AND
                   IDTFINAL > RCPERICOSEINTE.PECSFECI       ) THEN
                NUDIAS := IDTFINAL - RCPERICOSEINTE.PECSFECI;
                dbms_output.put_line ('NUDIAS4');
            END IF;


            dbms_output.put_line (
                'Dias interrupci�n en el Periodo Procesado  : '||
                NUDIAS
            );
            
            dbms_output.put_line (
                'IDTFINAL  : '||
                IDTFINAL
            );
            
            dbms_output.put_line (
                'IDTINITIAL  : '||
                IDTINITIAL
            );

             dbms_output.put_line (
                'NUPORCE  : (100 * NUDIAS) ='||
                (100*NUDIAS)||'; NVL((IDTFINAL - IDTINITIAL), NUDIAS)='||NVL((IDTFINAL - IDTINITIAL), NUDIAS)
            );


          --  NUPORCE := (100 * NUDIAS) / NVL((IDTFINAL - IDTINITIAL), NUDIAS);

            
            IF( NUIDX = TBPERIODOS.LAST ) THEN

                
                NUHORAS := NVL( INUCOMPTIME, 0 ) - NUSUMAHORAS;

                
                NUSUMAHORAS := NUSUMAHORAS + NUHORAS;
            ELSE

                
                NUHORAS :=  ROUND(
                                (NVL( INUCOMPTIME, 0 ) / 100) * NUPORCE,
                                4
                            );

                
                NUSUMAHORAS := NUSUMAHORAS + NUHORAS;
            END IF;

            dbms_output.put_line (
                'Horas a Compensar para el Periodo : '||NUHORAS
            );
            
            
            GETTARIFF
            (
                INUSERVICIO,
                INUCONCEPTO,
                INUPRODUCTO,
                RCPERICOSEINTE.PECSFECI,
                RCPERICOSEINTE.PECSFECF,
                INUFOT,
                NUTARIFA
            );

            dbms_output.put_line (
                'Tarifa para el Periodo            : '||NUTARIFA
            );
            dbms_output.put_line (
                'Consumo para el Calculo           : '||NUAVGCONSU
            );

            
            
            
            
            
            NUVALUEDOWNTIMEAUX := (NUHORAS * NUTARIFA * NUAVGCONSU);
            
            NUVALUEDOWNTIME := NUVALUEDOWNTIMEAUX * -1;
            
            
            SBSUPPORTDOCUM := 'TFS-D-' || INUCODINTER;

            dbms_output.put_line (
                '<< Nuevo Cargo >>'
            );
            dbms_output.put_line (
                'Documento Soporte : '||SBSUPPORTDOCUM
            );
            dbms_output.put_line (
                'Unidades          : '||NUHORAS
            );
            dbms_output.put_line (
                'Valor Cargo       : '||NUVALUEDOWNTIME
            );
            begin
              select cargvalo, CARGFECR
                into valor, fecha
              from OPEN.cargos
              where cargnuse=INUPRODUCTO
                and cargconc=25
                and cargsign='CR';
                
                dbms_output.put_line('VALOR CARGO:'||valor);
                
                dbms_output.put_line('FECHA_CARGO:'||fecha);
            exception
                when others then
                  null;
            end;
            
            
            
         /*   PKBORATINGMEMORYMGR.ADDCHARGE
            (
                NUVALUEDOWNTIME,                      
                NUHORAS,                           
                SBSUPPORTDOCUM,                       
                PKBORATINGMEMORYMGR.CNUCONSEC_ON_NEW, 
                INUCONSUMPERIOD,                      
                INUCONSUMPTIONTYPE                    
            );*/

            
            NUIDX := TBPERIODOS.NEXT(NUIDX);

        END LOOP;

        dbms_output.put_line (
            CHR(10)||
            'Horas Compensadas Interrupcion : '||NUSUMAHORAS
        );

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END CREATECHARGES; 
    
     PROCEDURE GETTIMEAVERAGECONSUMPTION
    (
        INUPRODUCT              IN  SERVSUSC.SESUNUSE%TYPE,
        IDTINSTALLDATE          IN  SERVSUSC.SESUFEIN%TYPE,
        IDTINIINTERRUPCION      IN  PR_TIMEOUT_COMPONENT.INITIAL_DATE%TYPE,
        IDTFININTERRUPCION      IN  PR_TIMEOUT_COMPONENT.FINAL_DATE%TYPE,
        INUMETHODCALCULATION    IN  NUMBER,
        INUCONSUMPTIONTYPE      IN  NUMBER,
        ONUVALUE                OUT NUMBER
    )
    IS
        
        NUVALUE      NUMBER := 0;
        
        
        DTDATEINI    DATE;
        
        
        DTDATEFIN    DATE;
        
        
        CNUANIO      CONSTANT NUMBER := -12;
        
        
        DTONEYEARAGO DATE;
        
        
        NUNUMHOURS   NUMBER := 0;
        
        
        DTPECSFECI  PERICOSE.PECSFECI%TYPE;

        
        DTPECSFECF  PERICOSE.PECSFECF%TYPE;
    BEGIN
        PKERRORS.PUSH ('FA_BODiscountTimeOutServ.GetTimeAverageConsumption');

        
        ONUVALUE := 0;

        
        PKBCCONSUMPTIONPERIOD.GETPERIODPREVIOUS
        (
            INUPRODUCT,
            INUMETHODCALCULATION,
            INUCONSUMPTIONTYPE,
            IDTINIINTERRUPCION,
            DTPECSFECF
        );
        
        dbms_output.put_line('   Rango Final Fecha Final calculada: '||DTPECSFECF);
        
        
        DTDATEFIN := NVL(DTPECSFECF, IDTINIINTERRUPCION);
        
        
        DTONEYEARAGO := ADD_MONTHS( DTDATEFIN, CNUANIO );

        
        IF( IDTINSTALLDATE IS NOT NULL) THEN
        
            
            IF( IDTINSTALLDATE >= DTONEYEARAGO ) THEN

                dbms_output.put_line('Promedio desde Fecha Instalaci�n :'||IDTINSTALLDATE);

                
                DTDATEINI := IDTINSTALLDATE;

            
            ELSE
                dbms_output.put_line('Promedio desde A�o atras : '||DTONEYEARAGO);
                
                
                PKBCCONSUMPTIONPERIOD.GETPERIODBYPRODUCTANDDATE
                (
                    INUPRODUCT,
                    INUMETHODCALCULATION,
                    INUCONSUMPTIONTYPE,
                    DTONEYEARAGO,
                    DTDATEFIN,
                    DTPECSFECI
                );
                
                
                IF( DTPECSFECI >= DTONEYEARAGO) THEN
                
                    
                    DTDATEINI := DTONEYEARAGO;
                ELSE
                    
                    DTDATEINI := DTPECSFECI;
                END IF;

            END IF;
            
            dbms_output.put_line('Rango Ini 1: '||DTDATEINI);
            dbms_output.put_line('Rango Fin 2: '||DTDATEFIN);
            
            
            PKBCCONSUMPTIONPERIOD.GETTOTALCONSUMPTION
            (
                INUPRODUCT,
                INUMETHODCALCULATION,
                INUCONSUMPTIONTYPE,
                DTDATEINI,
                DTDATEFIN,
                NUVALUE
            );
        END IF;
        
        
        IF( NUVALUE > 0 ) THEN

            
            NUNUMHOURS := (DTDATEFIN - DTDATEINI) * 24;

            
            ONUVALUE := NUVALUE / NUNUMHOURS;
        END IF;
        
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETTIMEAVERAGECONSUMPTION;
    
    PROCEDURE GETDOWNTIMEOFSERVICE
    (
        INUCOMPONENT  IN  PR_TIMEOUT_COMPONENT.COMPONENT_ID%TYPE,
        IDTDATEINI    IN  PR_TIMEOUT_COMPONENT.AUTHORIZATION_DATE%TYPE,
        IDTDATEFIN    IN  PR_TIMEOUT_COMPONENT.AUTHORIZATION_DATE%TYPE,
        ORFDOWNTIME   OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        dbms_output.put_line ('FA_BODiscountTimeOutServ.GetDownTimeOfService');
        
        
        PR_BCTIMEOUTCOMPONENT.GETDOWNTIMEOFSERVICE
        (
            INUCOMPONENT,
            IDTDATEINI,
            IDTDATEFIN,
            ORFDOWNTIME
        );
        
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            IF ORFDOWNTIME%ISOPEN THEN
                CLOSE ORFDOWNTIME;
            END IF;
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF ORFDOWNTIME%ISOPEN THEN
                CLOSE ORFDOWNTIME;
            END IF;
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            IF ORFDOWNTIME%ISOPEN THEN
                CLOSE ORFDOWNTIME;
            END IF;
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETDOWNTIMEOFSERVICE;
    
    PROCEDURE GETVALUETODISCOUNTC
    (
        INUSERVICIO             IN  SERVSUSC.SESUSERV%TYPE,
        INUCONCEPTO             IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO             IN  SERVSUSC.SESUNUSE%TYPE,
        INUCOMPONENT            IN  PR_COMPONENT.COMPONENT_ID%TYPE,
        INUCONSUMPERIOD          IN  PERICOSE.PECSCONS%TYPE,
        IDTINSTALLDATE          IN  SERVSUSC.SESUFEIN%TYPE,
        INUCONSUMPTIONTYPE      IN  NUMBER,
        INUFOT                  IN  NUMBER,
        ONUVALOR                OUT NUMBER
    )
    IS
        
        RFDOWNTIME           PKCONSTANTE.TYREFCURSOR;
        
        RCDOWNTIME           PR_BCTIMEOUTCOMPONENT.RCDONWTIME;

        
        NUAVERAGECONSUMPTION NUMBER := 0;
        
        NUDONWTIME           NUMBER := 0;

        
        NUMETHODCALCULATION  NUMBER;

        
        RCPERICOSE           PERICOSE%ROWTYPE;

        

















        PROCEDURE INITIALIZE
        IS
        BEGIN
            dbms_output.put_line('FA_BODiscountTimeOutServ.GetValueToDiscount.Initialize');

            
            IF( PKTBLPERICOSE.FBLEXIST( INUCONSUMPERIOD ) ) THEN
                
                RCPERICOSE := PKTBLPERICOSE.FRCGETRECORD( INUCONSUMPERIOD );
            ELSE
                RETURN;
            END IF;
            
            
            ONUVALOR := 0;
            
            
            NUMETHODCALCULATION := PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE
                                   (
                                       CSBMETHODCALCULATION
                                   );
            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED THEN
              PKERRORS.POP;
              RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
              
              PKERRORS.POP;
              RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
              PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
              PKERRORS.POP;
              RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
        END INITIALIZE;
    BEGIN
        PKERRORS.PUSH ('FA_BODiscountTimeOutServ.GetValueToDiscount');

        
        INITIALIZE;
        
        IF( RCPERICOSE.PECSCONS IS NULL ) THEN
            RETURN;
        END IF;

        dbms_output.put_line( 'Servicio: '||INUSERVICIO );
        dbms_output.put_line ( 'Concepto: '||INUCONCEPTO );
        dbms_output.put_line ( 'Producto: '||INUPRODUCTO );
       dbms_output.put_line ( 'Componente: '||INUCOMPONENT );
        dbms_output.put_line ( 'Periodo de Consumo: '||INUCONSUMPERIOD );
        dbms_output.put_line ( 'Fecha Instalacion Prod.: '||IDTINSTALLDATE );
        dbms_output.put_line ( 'Tipo Consumo: '||INUCONSUMPTIONTYPE );
        dbms_output.put_line ( 'Metodo FOT: '||INUFOT );
        dbms_output.put_line ( 'Metodo de Calculo: '||NUMETHODCALCULATION );


            dbms_output.put_line ( 'RCPERICOSE.PECSFECI: '||RCPERICOSE.PECSFECI);
            dbms_output.put_line ( 'RCPERICOSE.PECSFECF: '||RCPERICOSE.PECSFECF);
        
        GETDOWNTIMEOFSERVICE
        (
            INUCOMPONENT,
            RCPERICOSE.PECSFECI,
            RCPERICOSE.PECSFECF,
            RFDOWNTIME
        );

        LOOP
            
            FETCH RFDOWNTIME INTO RCDOWNTIME;

            
            EXIT WHEN RFDOWNTIME%NOTFOUND;
            
            dbms_output.put_line(CHR(10)||'-- Codigo Interrup. : '||RCDOWNTIME.TIMEOUT_COMPONENT_ID);
            dbms_output.put_line('Fecha Ini Interrup. : '||RCDOWNTIME.INITIAL_DATE);
            dbms_output.put_line('Fecha Fin Interrup. : '||RCDOWNTIME.FINAL_DATE);
            dbms_output.put_line('Tiempo Compensar (Min). : '||RCDOWNTIME.COMPENSATED_TIME);

            



            
            
            GETTIMEAVERAGECONSUMPTION
            (
                INUPRODUCTO,
                IDTINSTALLDATE,
                RCDOWNTIME.INITIAL_DATE,
                RCDOWNTIME.FINAL_DATE,
                NUMETHODCALCULATION,
                INUCONSUMPTIONTYPE,
                NUAVERAGECONSUMPTION
            );

            dbms_output.put_line ( 'Consumo Promedio: '||NUAVERAGECONSUMPTION );
            
            
            NUDONWTIME := (NVL( RCDOWNTIME.COMPENSATED_TIME, 0 ) / 60);
            
            dbms_output.put_line ( 'NUDONWTIME: '||NUDONWTIME );
            
            CREATECHARGES
            (
                INUSERVICIO,
                INUCONCEPTO,
                INUPRODUCTO,
                RCDOWNTIME.TIMEOUT_COMPONENT_ID,
                RCDOWNTIME.INITIAL_DATE,
                RCDOWNTIME.FINAL_DATE,
                NUDONWTIME,
                RCPERICOSE.PECSCICO,
                NUAVERAGECONSUMPTION,
                INUFOT,
                INUCONSUMPERIOD,
                INUCONSUMPTIONTYPE
            );

        END LOOP;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETVALUETODISCOUNTC;
    
    

    PROCEDURE GETDATAPROCESS
    IS
    BEGIN
        PKERRORS.PUSH ('DiscountTimeOutServ.GetDataProcess');        
        NUCHARGEVALUE := 0;        
        NUCONSUMPTIONTYPE   := INUCONSUMPTIONTYPE;        
        NUFOT               := INUFOT;        

        
     /*   PKINSTANCEDATAMGR.GETCG_SUBSSERVICE( NUSUBSSERVICE );        
        PKINSTANCEDATAMGR.GETCG_SERVICE( NUSERVICE );
        PKINSTANCEDATAMGR.GETCG_CONCEPT( NUCONCEPT );
        PKINSTANCEDATAMGR.GETCG_CONSUMPERIOD( NUPERICOSEITERAID );
        PKINSTANCEDATAMGR.OBTPERACTUAL( NUPERICOSEACTUALID );
        PKINSTANCEDATAMGR.GETCG_INSTALLDATE(DTINSTALLDATE);*/
        
        NUSUBSSERVICE:=&producto; --1002887;
        NUSERVICE:=7014;
        NUCONCEPT:=25;
        NUPERICOSEITERAID:=&pericose;--91758;102449
        --NUPERICOSEACTUALID:=79307;
        DTINSTALLDATE:=pktblservsusc.fdtgetsesufein(NUSUBSSERVICE);
        
        RCCOMPSESU := PKBCCOMPSESU.FRCMAINCOMPBYPRODDATES
        (
            NUSUBSSERVICE,  
            sysdate,        
            sysdate        
        );
        
        NUCOMPONENT := RCCOMPSESU.CMSSIDCO;
        
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETDATAPROCESS;
    
    PROCEDURE GETVALUETODISCOUNT
    (
        INUSERVICE              IN  SERVSUSC.SESUSERV%TYPE,
        INUCONCEPT              IN  CONCEPTO.CONCCODI%TYPE,
        INUSUBSSERVICE          IN  SERVSUSC.SESUNUSE%TYPE,
        INUCOMPONENT            IN  PR_COMPONENT.COMPONENT_ID%TYPE,
        INUCONSUMPERIOD          IN  PERICOSE.PECSCONS%TYPE,
        IDTINSTALLDATE          IN  SERVSUSC.SESUFEIN%TYPE,
        INUCONSUMPTIONTYPE      IN  NUMBER,
        INUFOT                  IN  NUMBER,
        ONUVALUE                OUT NUMBER
    )
    IS
    BEGIN
        PKERRORS.PUSH ('DiscountTimeOutServ.GetValueToDiscount');
dbms_output.put_line('pase1');
        
        dbms_output.put_line('INUSERVICE: '||INUSERVICE);
            dbms_output.put_line('INUCONCEPT: '||INUCONCEPT);
            dbms_output.put_line('INUSUBSSERVICE: '||INUSUBSSERVICE);
            dbms_output.put_line('INUCOMPONENT: '||INUCOMPONENT);
            dbms_output.put_line('INUCONSUMPERIOD: '||INUCONSUMPERIOD);
            dbms_output.put_line('IDTINSTALLDATE: '||IDTINSTALLDATE);
            dbms_output.put_line('INUCONSUMPTIONTYPE: '||INUCONSUMPTIONTYPE);
            dbms_output.put_line('INUFOT: '||INUFOT);
            
            
        --FA_BODISCOUNTTIMEOUTSERV.
        GETVALUETODISCOUNTC
        (
            INUSERVICE,
            INUCONCEPT,
            INUSUBSSERVICE,
            INUCOMPONENT,
            INUCONSUMPERIOD,
            IDTINSTALLDATE,
            INUCONSUMPTIONTYPE,
            INUFOT,
            ONUVALUE
        );
dbms_output.put_line('pase2');
        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END GETVALUETODISCOUNT;

    
    
    

BEGIN
    PKERRORS.PUSH ('DiscountTimeOutServ');

    
    GETDATAPROCESS;

    
    GETVALUETODISCOUNT
    (
        NUSERVICE,
        NUCONCEPT,
        NUSUBSSERVICE,
        NUCOMPONENT,
        NUPERICOSEITERAID,
        DTINSTALLDATE,
        NUCONSUMPTIONTYPE,
        NUFOT,
        NUCHARGEVALUE
    );
    

    PKERRORS.POP;

    
  --  RETURN (NUCHARGEVALUE);

EXCEPTION
        WHEN LOGIN_DENIED THEN
          PKERRORS.POP;
          RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
          
          PKERRORS.POP;
          RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
          PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
          PKERRORS.POP;
          RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
END;
/
