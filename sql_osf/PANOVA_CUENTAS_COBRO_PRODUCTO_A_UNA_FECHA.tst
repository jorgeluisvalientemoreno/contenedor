PL/SQL Developer Test script 3.0
58
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
  idtdate      DATE := TRUNC(SYSDATE - 360);

  NUIDX2 NUMBER;

  INUSUSCCODI SUSCRIPC.SUSCCODI%TYPE := 32564;

  CURSOR CUCONSULTA IS
    select a.sesunuse from open.servsusc a where a.sesunuse = INUSUSCCODI;

  rfCUCONSULTA CUCONSULTA%rowtype;
begin

  for rfCUCONSULTA in CUCONSULTA loop
    inuproductid := rfCUCONSULTA.Sesunuse;
    DBMS_OUTPUT.put_line('Producto: ' || inuproductid);
    -- Call the procedure
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
  
    NUIDX2 := otbdeferredbalance.FIRST;
  
    LOOP
      EXIT WHEN(NUIDX2 IS NULL);
      DBMS_OUTPUT.put_line('1');
    
      NUIDX2 := otbbalanceaccounts.NEXT(NUIDX2);
    END LOOP;
  end loop;

end;
0
0
