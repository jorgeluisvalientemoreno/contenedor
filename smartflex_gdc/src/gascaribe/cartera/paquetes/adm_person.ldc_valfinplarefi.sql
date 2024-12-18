CREATE OR REPLACE package ADM_PERSON.LDC_VALFINPLAREFI is

  function fsbValFechaFinRefiProd(inuProducto servsusc.sesunuse%type)
    return varchar2;

  function fsbValFechaFinRefiSusc(inuContrato servsusc.sesususc%type)
    return varchar2;

  function fsbRefinanciaM(inuOrder in NUMBER) RETURN VARCHAR2;

end LDC_VALFINPLAREFI;
/
CREATE OR REPLACE package body ADM_PERSON.LDC_VALFINPLAREFI is

  function fsbValFechaFinRefiProd(inuProducto servsusc.sesunuse%type)
    return varchar2

   is

    nuValido number;
    csbEntrega2001471 CONSTANT VARCHAR2(100) := 'BSS_CAR_STN_2001471_2';
  begin
    /*Jm || Ca 200-1471 || solo aplica para GDC*/
    IF open.fblAplicaEntrega(csbEntrega2001471) THEN
      SELECT /*+ index( diferido IX_DIFE_NUSE ) */

       count(1)
        into nuValido

        FROM DIFERIDO /*+ GC_BCCollMgmtProcess.fnuRefinanTimesByProd */

       WHERE DIFEPROG = 'GCNED'

         AND DIFENUSE = inuProducto
         and TRUNC(add_months(DIFEFEIN,
                              Dald_parameter.fnuGetNumeric_Value('CANT_MESE_REFI_PROD')),
                   'MM') = TRUNC(SYSDATE, 'MM'); --el tiempo de evaluacion lo determina parametro
      --and TRUNC(add_months(DIFEFEIN, 12), 'MM') = TRUNC(SYSDATE, 'MM');
    else
      SELECT /*+ index( diferido IX_DIFE_NUSE ) */

       count(1)
        into nuValido

        FROM DIFERIDO /*+ GC_BCCollMgmtProcess.fnuRefinanTimesByProd */

       WHERE DIFEPROG = 'GCNED'

         AND DIFENUSE = inuProducto
         and TRUNC(add_months(DIFEFEIN, 12), 'MM') = TRUNC(SYSDATE, 'MM');
    end if;
    if (nuValido > 0) then

      return 'S';

    else

      return 'N';

    end if;

  exception
    when others then

      return 'N';

  end fsbValFechaFinRefiProd;

  function fsbValFechaFinRefiSusc(inuContrato servsusc.sesususc%type)
    return varchar2

   is

    nuValido number;
    csbEntrega2001471 CONSTANT VARCHAR2(100) := 'BSS_CAR_STN_2001471_2';
  begin
    /*Jm || Ca 200-1471 || solo aplica para GDC*/
    IF open.fblAplicaEntrega(csbEntrega2001471) THEN
      SELECT /*+ index( diferido IX_DIFE_NUSE ) */

       count(1)
        into nuValido

        FROM DIFERIDO /*+ GC_BCCollMgmtProcess.fnuRefinanTimesByProd */

       WHERE DIFEPROG = 'GCNED'

         AND DIFESUSC = inuContrato
         and TRUNC(add_months(DIFEFEIN,
                              Dald_parameter.fnuGetNumeric_Value('CANT_MESE_REFI_PROD')),
                   'MM') = TRUNC(SYSDATE, 'MM'); --el tiempo de evaluacion lo determina parametro
      --  and TRUNC(add_months(DIFEFEIN, 12), 'MM') = TRUNC(SYSDATE, 'MM');
    else
      SELECT /*+ index( diferido IX_DIFE_NUSE ) */

       count(1)
        into nuValido

        FROM DIFERIDO /*+ GC_BCCollMgmtProcess.fnuRefinanTimesByProd */

       WHERE DIFEPROG = 'GCNED'

         AND DIFESUSC = inuContrato
         and TRUNC(add_months(DIFEFEIN, 12), 'MM') = TRUNC(SYSDATE, 'MM');
    end if;
    if (nuValido > 0) then

      return 'S';

    else

      return 'N';

    end if;

  exception
    when others then

      return 'N';

  end fsbValFechaFinRefiSusc;

  function fsbRefinanciaM(inuOrder in NUMBER) RETURN VARCHAR2

   is

    OSBERRORMESSAGE VARCHAR2(2000);

    nuCantRefi NUMBER;

    sbCantRefiParam VARCHAR2(200);

    CURSOR cuRefinancia IS

      SELECT REFINANCI_TIMES

        FROM OPEN.gc_coll_mgmt_pro_det

       WHERE ORDER_ID = inuOrder
         AND

             IS_LEVEL_MAIN = 'Y'
         AND

             ROWNUM <= 1;

    nuProducto servsusc.sesunuse%type;

    nuContrato suscripc.susccodi%type;

    nuFinaAnoP number;

    nuFinaAnoC number;

    csbEntrega200900 CONSTANT VARCHAR2(100) := 'BSS_CAR_NCZ_200900_2';

    sbValRefinan varchar2(1);

    /*Jm SEBTAP || Ca 200-1471 || solo aplica para GDC*/
    csbEntrega2001471 CONSTANT VARCHAR2(100) := 'BSS_CAR_STN_2001471_2';
    vbCount NUMBER := null;
    /*Fin 200-1471*/

  BEGIN

    OPEN cuRefinancia;

    FETCH cuRefinancia
      INTO nuCantRefi;

    CLOSE cuRefinancia;

    --Se obtiene el valor minimo de abono

    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR',
                                       'MAX_FINANCIA',
                                       sbCantRefiParam,
                                       osbErrorMessage);

    IF osbErrorMessage != '0' or sbCantRefiParam is null THEN

      sbCantRefiParam := '2';

    END IF;

    if (fblaplicaentrega(csbEntrega200900)) then

      begin

        select subscription_id, product_id

          into nuContrato, nuProducto

          from or_order_activity a

         where a.order_id = inuOrder;

        if (nuProducto is not null) then
          /*Jm SEBTAP || Ca 200-1471 || solo aplica para GDC*/
          --Si aplica para GDC, la variable nuFinaAnoP se obtiene con el SELECT.
          --De lo contrario se obtiene de la forma habitual.
          IF open.fblAplicaEntrega(csbEntrega2001471) THEN
            BEGIN
              SELECT COUNT(DISTINCT Trunc(Difefein))
                INTO vbCount
                FROM diferido
               WHERE difeprog = 'GCNED'
                 AND DIFENUSE = nuProducto
                 AND TRUNC(DIFEFEIN) >
                     TRUNC(ADD_MONTHS(sysdate,
                                      -Dald_parameter.fnuGetNumeric_Value('CANT_MESE_REFI_PROD')));
            EXCEPTION
              WHEN NO_DATA_FOUND then
                vbCount := null;
            END;
            nuFinaAnoP := vbCount;
          ELSE
            nuFinaAnoP := GC_BODEBTMANAGEMENT.fnuGetRefinanOfProduct(nuProducto);
          END IF;
          /*Fin 200-1471*/

          if (nuFinaAnoP = to_number(sbCantRefiParam)) then

            sbValRefinan := LDC_VALFINPLAREFI.fsbValFechaFinRefiProd(nuProducto);

          else

            IF nuFinaAnoP > to_number(sbCantRefiParam) THEN

              sbValRefinan := 'N';

            ELSE

              sbValRefinan := 'S';

            END IF;

          end if;

        else

          nuFinaAnoC := GC_BODEBTMANAGEMENT.fnuGetRefinanOfSusc(nuContrato);

          if (nuFinaAnoC = to_number(sbCantRefiParam)) then

            sbValRefinan := LDC_VALFINPLAREFI.fsbValFechaFinRefiSusc(nuContrato);

          else

            IF nuFinaAnoC > to_number(sbCantRefiParam) THEN

              sbValRefinan := 'N';

            ELSE

              sbValRefinan := 'S';

            END IF;

          end if;

        end if;

      exception
        when others then

          sbValRefinan := 'N';

      end;

      return sbValRefinan;

    else

      IF nuCantRefi > to_number(sbCantRefiParam) THEN

        RETURN 'N';

      ELSE

        RETURN 'S';

      END IF;

    end if;

  EXCEPTION

    WHEN OTHERS THEN

      LDCI_pkWebServUtils.Procrearerrorlogint('LDC_VALFINPLAREFI.fsbRefinanciaM',
                                              1,
                                              'Fallo definiendo flag refinanciar: ' ||
                                              DBMS_UTILITY.format_error_backtrace,
                                              null,
                                              null);

      RETURN 'N';

  END fsbRefinanciaM;

end LDC_VALFINPLAREFI;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALFINPLAREFI', 'ADM_PERSON');
END;
/
