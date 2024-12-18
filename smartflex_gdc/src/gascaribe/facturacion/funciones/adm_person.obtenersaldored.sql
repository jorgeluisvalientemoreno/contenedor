CREATE OR REPLACE FUNCTION adm_person.obtenersaldored ( 
    inuproductid IN NUMBER
) RETURN NUMBER IS
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GASES DEL CARIBE E.S.P.

  UNIDAD         : obtenersaldored
  DESCRIPCION    : 
  AUTOR          : 
  CASO           : 
  FECHA          : 

  FECHA             AUTOR                   MODIFICACION
  ==========        =========               ====================
  07/03/2024        Paola Acosta            OSF-2104: Se retiran las referencias .open 
  28/02/2024        Paola Acosta            OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  ******************************************************************/

    currentcursor      fa_boaccountstatustodate.tytbbalanceaccounts;
    deferredcursor     fa_boaccountstatustodate.tytbdeferredbalance;
    actualrow          VARCHAR2(2000);
    saldored           NUMERIC(15);
    currentvalue       NUMBER;
    deferredvalue      NUMBER;
    positivebalance    NUMBER;
    claimvalue         NUMBER;
    deferredclaimvalue NUMBER;
BEGIN
    fa_boaccountstatustodate.productbalanceaccountstodate(inuproductid, sysdate, currentvalue, deferredvalue, positivebalance,
                                                                claimvalue, deferredclaimvalue, currentcursor, deferredcursor);

    saldored := 0;

    -- cartera corriente
    actualrow := currentcursor.first;
    WHILE actualrow IS NOT NULL LOOP
        IF currentcursor(actualrow).conccodi = 19 OR currentcursor(actualrow).conccodi = 30 OR currentcursor(actualrow).conccodi = 758
        THEN
            saldored := saldored + currentcursor(actualrow).saldvalo;
        END IF;

        actualrow := currentcursor.next(actualrow);
    END LOOP;

    -- cartera diferida
    actualrow := deferredcursor.first;
    WHILE actualrow IS NOT NULL LOOP
        IF deferredcursor(actualrow).conccodi = 19 OR deferredcursor(actualrow).conccodi = 30 OR deferredcursor(actualrow).conccodi =
        758 THEN
            saldored := saldored + deferredcursor(actualrow).saldvalo;
        END IF;

        actualrow := deferredcursor.next(actualrow);
    END LOOP;

    RETURN saldored;
END obtenersaldored;
/

BEGIN
    pkg_utilidades.praplicarpermisos('OBTENERSALDORED', 'ADM_PERSON');
END;
/