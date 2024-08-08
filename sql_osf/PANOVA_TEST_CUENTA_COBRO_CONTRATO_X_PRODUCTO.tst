PL/SQL Developer Test script 3.0
120
DECLARE
    -- Variable declarations
    l_INUPRODUCTID              NUMBER;
    l_IDTDATE                   DATE;
    l_ONUCURRENTACCOUNTTOTAL    NUMBER;
    l_ONUDEFERREDACCOUNTTOTAL   NUMBER;
    l_ONUCREDITBALANCE          NUMBER;
    l_ONUCLAIMVALUE             NUMBER;
    l_ONUDEFCLAIMVALUE          NUMBER;
    l_OTBBALANCEACCOUNTS        FA_BOACCOUNTSTATUSTODATE.TYTBBALANCEACCOUNTS;
    l_OTBDEFERREDBALANCE        FA_BOACCOUNTSTATUSTODATE.TYTBDEFERREDBALANCE;
    
    sbIndexAcc                  varchar2(20);
    sbIndexDif                  varchar2(20);
    
    cursor cuservicios(inuContrato number) is
    select a.* from open.servsusc a where a.sesususc = inuContrato; 
    
    rfcuservicios cuservicios%rowtype;
    
    nuCuentaCobro open.cuencobr.cucocodi%type;
    nuCuenCobrCantidadPreLEg number;
    nuCuenCobrCantidadPosLEg number;    
    nuContrato number;

    CURSOR cuLoadAccWithBalByProd(inuSusc NUMBER, InuServicio Number) IS
    --Cursor para establecer las cuentas de cobro que maneja el producto 
    --a fecha actual del sistema
    --CURSOR cuCargaCCConValorProd(inuSusc NUMBER, InuServicio Number) IS
        SELECT COUNT(cuco.cucocodi) ACCBAL
          FROM SERVSUSC SER
              ,CUENCOBR CUCO
         WHERE SER.SESUSUSC = inuSusc
           and ser.sesunuse = InuServicio
           AND CUCO.CUCONUSE = SER.SESUNUSE
           AND CUCO.CUCOFEVE < SYSDATE
           AND CUCO.CUCOSACU IS NOT NULL;
    
BEGIN

    /*ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);*/

    nuContrato := 269991;
    --l_IDTDATE := to_Date('27052023 000000','ddmmyyyy hh24miss');
    l_IDTDATE := to_date('25/05/2023','DD/MM/YYYY');
    for rfcuservicios in cuservicios(nuContrato) loop

      dbms_output.put_line('Producto: '|| rfcuservicios.sesunuse);

      -- Variable initializations
      l_INUPRODUCTID := rfcuservicios.sesunuse;

      -- Call
      FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE (
          INUPRODUCTID              => l_INUPRODUCTID,
          IDTDATE                   => l_IDTDATE,
          ONUCURRENTACCOUNTTOTAL    => l_ONUCURRENTACCOUNTTOTAL,
          ONUDEFERREDACCOUNTTOTAL   => l_ONUDEFERREDACCOUNTTOTAL,
          ONUCREDITBALANCE          => l_ONUCREDITBALANCE,
          ONUCLAIMVALUE             => l_ONUCLAIMVALUE,
          ONUDEFCLAIMVALUE          => l_ONUDEFCLAIMVALUE,
          OTBBALANCEACCOUNTS        => l_OTBBALANCEACCOUNTS,
          OTBDEFERREDBALANCE        => l_OTBDEFERREDBALANCE);

      --dbms_output.put_line('*****Cuentas de cobro: ' || l_OTBBALANCEACCOUNTS.count);
      sbIndexAcc := l_OTBBALANCEACCOUNTS.first;
      nuCuentaCobro := 0;
      nuCuenCobrCantidadPreLEg := 0;
      if sbIndexAcc is not null then
          --Identificar cuentas de cobro con saldo pendiente antes de la legalizacion
          dbms_output.put_line('*****Recorrido de cuenta de cobro con saldo antes de la legalizacion');
          loop            
            if nuCuentaCobro <> l_OTBBALANCEACCOUNTS(sbIndexAcc).cucocodi then
              --dbms_output.put_line('**********Recorrido: '||sbIndexAcc);
              dbms_output.put_line('**********Cuenta: '||l_OTBBALANCEACCOUNTS(sbIndexAcc).cucocodi);
              --dbms_output.put_line('**********Concepto: '||l_OTBBALANCEACCOUNTS(sbIndexAcc).conccodi);
              --dbms_output.put_line('**********Edad: '||l_OTBBALANCEACCOUNTS(sbIndexAcc).cucodive);
              --dbms_output.put_line('**********saldvalo: '||l_OTBBALANCEACCOUNTS(sbIndexAcc).saldvalo);
              nuCuentaCobro := l_OTBBALANCEACCOUNTS(sbIndexAcc).cucocodi;
              nuCuenCobrCantidadPreLEg := nuCuenCobrCantidadPreLEg + 1;
            end if;
              
            sbIndexAcc := l_OTBBALANCEACCOUNTS.next(sbIndexAcc);
            exit when sbIndexAcc is null;              
          end loop;
          dbms_output.put_line('***************Cuentas de cobros pedientes [' || nuCuenCobrCantidadPreLEg || ']');
          
          dbms_output.put_line('*****Recorrido de cuenta de cobro con saldo despues de la legalizacion');
          open cuLoadAccWithBalByProd(nuContrato,rfcuservicios.sesunuse);
          fetch cuLoadAccWithBalByProd into nuCuenCobrCantidadPosLEg;
          close cuLoadAccWithBalByProd;
          dbms_output.put_line('***************Cuentas de cobros pedientes poslegalizacion[' || nuCuenCobrCantidadPosLEg || ']');
      else
          dbms_output.put_line('Sin registros de cuentas');
      end if;

      /*
      dbms_output.put_line('');
      dbms_output.put_line('');      
      sbIndexDif := l_OTBDEFERREDBALANCE.first;
      dbms_output.put_line('*****Recorrido de direfridos con saldo');      
      if sbIndexDif is not null then
          loop
              dbms_output.put_line('**********Recorrido: '||sbIndexDif);
              dbms_output.put_line('**********Cuenta: '||l_OTBDEFERREDBALANCE(sbIndexDif).conccodi);
              dbms_output.put_line('**********saldvalo: '||l_OTBDEFERREDBALANCE(sbIndexDif).saldvalo);
              
              sbIndexDif := l_OTBDEFERREDBALANCE.next(sbIndexDif);
              exit when sbIndexDif is null;
          end loop;
      else
          dbms_output.put_line('Sin registros de Diferidos');
      end if;
      //*/

      dbms_output.put_line('-------------------------------------------------------');
   end loop;
END;
0
0
