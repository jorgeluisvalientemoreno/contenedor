PL/SQL Developer Test script 3.0
107
-- Created on 25/05/2023 by JORGE VALIENTE 
declare

  -- Non-scalar parameters require additional processing 
  otbbalanceaccounts      fa_boaccountstatustodate.tytbbalanceaccounts;
  otbdeferredbalance      fa_boaccountstatustodate.tytbdeferredbalance;
  onucurrentaccounttotal  NUMBER;
  onudeferredaccounttotal NUMBER;
  onucreditbalance        NUMBER;
  onuclaimvalue           NUMBER;
  onudefclaimvalue        NUMBER;

  inuproductid NUMBER;
  idtdate      DATE := to_date('26/12/2022', 'DD/MM/YYYY'); --TRUNC(SYSDATE - 150);

  NUIDX2 NUMBER;

  INUSUSCCODI SUSCRIPC.SUSCCODI%TYPE := 440608;

  CURSOR CUCONSULTA IS
    select a.sesunuse from open.servsusc a where a.sesususc = INUSUSCCODI;

  rfCUCONSULTA CUCONSULTA%rowtype;
begin

  for rfCUCONSULTA in CUCONSULTA loop
    inuproductid := rfCUCONSULTA.Sesunuse;
    DBMS_OUTPUT.put_line('-----------------------------------------');
    DBMS_OUTPUT.put_line('Producto: ' || inuproductid);
    -- Call the procedure
    --/*
    fa_boaccountstatustodate.productbalanceaccountstodate(inuproductid            => inuproductid,
                                                          idtdate                 => idtdate,
                                                          onucurrentaccounttotal  => onucurrentaccounttotal,
                                                          onudeferredaccounttotal => onudeferredaccounttotal,
                                                          onucreditbalance        => onucreditbalance,
                                                          onuclaimvalue           => onuclaimvalue,
                                                          onudefclaimvalue        => onudefclaimvalue,
                                                          otbbalanceaccounts      => otbbalanceaccounts,
                                                          otbdeferredbalance      => otbdeferredbalance);
  
    DBMS_OUTPUT.put_line('onucurrentaccounttotal: ' ||
                         onucurrentaccounttotal);
    DBMS_OUTPUT.put_line('onudeferredaccounttotal: ' ||
                         onudeferredaccounttotal);
    DBMS_OUTPUT.put_line('onucreditbalance: ' || onucreditbalance);
    DBMS_OUTPUT.put_line('onuclaimvalue: ' || onuclaimvalue);
    DBMS_OUTPUT.put_line('onudefclaimvalue: ' || onudefclaimvalue);
  
    NUIDX2 := otbbalanceaccounts.FIRST;
  
    LOOP
      EXIT WHEN(NUIDX2 IS NULL);
      DBMS_OUTPUT.put_line('1');
      --DBMS_OUTPUT.put_line('-----------------------------------------DIFECONC: ' || otbdeferredbalance(NUIDX2).DIFECONC);    
      DBMS_OUTPUT.put_line('-----------------------------------------SALDVALO: ' || otbdeferredbalance(NUIDX2)
                           .SALDVALO);
      DBMS_OUTPUT.put_line('-----------------------------------------CONCCODI: ' || otbdeferredbalance(NUIDX2)
                           .CONCCODI);
      NUIDX2 := otbdeferredbalance.NEXT(NUIDX2);
    END LOOP;
    DBMS_OUTPUT.put_line('-----------------------------------------');
    --*/
  end loop;

  idtdate := trunc(sysdate); --TRUNC(SYSDATE - 150);
  for rfCUCONSULTA in CUCONSULTA loop
    inuproductid := rfCUCONSULTA.Sesunuse;
    DBMS_OUTPUT.put_line('-----------------------------------------');
    DBMS_OUTPUT.put_line('Producto: ' || inuproductid);
    -- Call the procedure
    --/*
    fa_boaccountstatustodate.productbalanceaccountstodate(inuproductid            => inuproductid,
                                                          idtdate                 => idtdate,
                                                          onucurrentaccounttotal  => onucurrentaccounttotal,
                                                          onudeferredaccounttotal => onudeferredaccounttotal,
                                                          onucreditbalance        => onucreditbalance,
                                                          onuclaimvalue           => onuclaimvalue,
                                                          onudefclaimvalue        => onudefclaimvalue,
                                                          otbbalanceaccounts      => otbbalanceaccounts,
                                                          otbdeferredbalance      => otbdeferredbalance);
  
    DBMS_OUTPUT.put_line('onucurrentaccounttotal: ' ||
                         onucurrentaccounttotal);
    DBMS_OUTPUT.put_line('onudeferredaccounttotal: ' ||
                         onudeferredaccounttotal);
    DBMS_OUTPUT.put_line('onucreditbalance: ' || onucreditbalance);
    DBMS_OUTPUT.put_line('onuclaimvalue: ' || onuclaimvalue);
    DBMS_OUTPUT.put_line('onudefclaimvalue: ' || onudefclaimvalue);
  
    NUIDX2 := otbbalanceaccounts.FIRST;
  
    LOOP
      EXIT WHEN(NUIDX2 IS NULL);
      DBMS_OUTPUT.put_line('1');
      --DBMS_OUTPUT.put_line('-----------------------------------------DIFECONC: ' || otbdeferredbalance(NUIDX2).DIFECONC);    
      DBMS_OUTPUT.put_line('-----------------------------------------SALDVALO: ' || otbdeferredbalance(NUIDX2)
                           .SALDVALO);
      DBMS_OUTPUT.put_line('-----------------------------------------CONCCODI: ' || otbdeferredbalance(NUIDX2)
                           .CONCCODI);
      NUIDX2 := otbdeferredbalance.NEXT(NUIDX2);
    END LOOP;
    DBMS_OUTPUT.put_line('-----------------------------------------');
    --*/
  end loop;

end;
0
0
