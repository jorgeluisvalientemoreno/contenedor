
  CREATE OR REPLACE PROCEDURE "OPEN"."ACTUALIZARCARTERAPORCONCEPTO" ( INUPRODUCTID IN number )
IS
  currentValue number;
  deferredValue number;
  positiveBalance number;
  actualRow varchar2(2000);

  currentCursor "OPEN".LDCBI_ESTADOCUENTA.tytbBalanceAccounts;
  deferredCursor "OPEN".LDCBI_ESTADOCUENTA.tytbDeferredBalance;

  flag varchar2(1);
BEGIN
  "OPEN".LDCBI_ESTADOCUENTA.PRODUCTOAFECHA(
    INUPRODUCTID,
    SYSDATE,
    currentValue,
    deferredValue,
    positiveBalance,
    currentCursor,
    deferredCursor
  );

  delete from LDCBI_CARTERAPORCONCEPTO where PRODUCT_ID = INUPRODUCTID ;

  -- cartera corriente
  actualRow := currentCursor.first;
  while actualRow is not null loop
    flag := 'N';
    if substr(actualRow,1,2) = 'R-' then
      flag := 'S';
    end if;
    insert into LDCBI_CARTERAPORCONCEPTO (PRODUCT_ID, CONCEPT_ID, TIPO, VALOR, REFINANCIADA)
    values ( INUPRODUCTID, currentCursor(actualRow).CONCCODI, 'C', currentCursor(actualRow).SALDVALO, flag );
    actualRow := currentCursor.next(actualRow);
  end loop;

  -- cartera diferida
  actualRow := deferredCursor.first;
  while actualRow is not null loop
    flag := 'N';
    if substr(actualRow,1,2) = 'R-' then
      flag := 'S';
    end if;
    insert into LDCBI_CARTERAPORCONCEPTO (PRODUCT_ID, CONCEPT_ID, TIPO, VALOR, REFINANCIADA)
    values ( INUPRODUCTID, deferredCursor(actualRow).CONCCODI, 'D', deferredCursor(actualRow).SALDVALO, flag );
    actualRow := deferredCursor.next(actualRow);
  end loop;

  MERGE INTO LDCBI_PRODUCTO_CARTERA dest
  USING ( SELECT INUPRODUCTID AS PRODUCT_ID FROM DUAL ) src
  ON ( dest.PRODUCT_ID = src.PRODUCT_ID )
  WHEN MATCHED THEN UPDATE SET UPDATED_DATE = SYSDATE, STATUS_ID = -1
  WHEN NOT MATCHED THEN INSERT ( PRODUCT_ID, STATUS_ID ) VALUES ( INUPRODUCTID, -1 );
end;

/
