CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_ASSIGN_ORDER(INUORDERID         IN OR_ORDER.ORDER_ID%TYPE,
                                                       INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
                                                       IDTARRANGEDHOUR    IN OR_ORDER.ARRANGED_HOUR%TYPE,
                                                       IDTCHANGEDATE      IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE,
                                                       IDTASSIGORD        IN OR_ORDER.ASSIGNED_DATE%TYPE,
                                                       ONUERRORCODE       OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                                       OSBERRORMESSAGE    OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
  SBCUPDATEIDTCHANGEDATE VARCHAR2(1) := DALD_PARAMETER.fsbGetValue_Chain('LDCUPDATEIDTCHANGEDATE');
  SBSI                   VARCHAR2(1) := 'S';
  dtnwchdte                date;
BEGIN
  If IDTCHANGEDATE > sysdate and nvl(SBCUPDATEIDTCHANGEDATE, SBSI) = SBSI then
   dtnwchdte:=sysdate;
  else
    dtnwchdte:=IDTCHANGEDATE;
  end if;

  OS_ASSIGN_ORDER(INUORDERID,
                  INUOPERATINGUNITID,
                  IDTARRANGEDHOUR,
                  nvl(dtnwchdte,IDTCHANGEDATE),
                  ONUERRORCODE,
                  OSBERRORMESSAGE);
  --se compara la fecha idtchangedate con el sysdate

    Update open.or_order o
       set o.ASSIGNED_DATE =IDTASSIGORD
     where o.order_id = INUORDERID
       and o.operating_unit_id = INUOPERATINGUNITID;


EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ASSIGN_ORDER', 'ADM_PERSON');
END;
/
