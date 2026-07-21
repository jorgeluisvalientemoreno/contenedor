DECLARE
  inuorderid         NUMBER := 435182538;
  inuoperatingunitid NUMBER := 120;
  idtarrangedhour    NUMBER := SYSDATE;
  idtchangedate      NUMBER := SYSDATE;
  onuerrorcode       NUMBER;
  osberrormessage    VARCHAR2(4000);
BEGIN

  os_assign_order(inuorderid,
                  inuoperatingunitid,
                  idtarrangedhour,
                  idtchangedate,
                  onuerrorcode,
                  osberrormessage);
  dbms_output.put_line('Codigo Error: ' || onuerrorcode);
  dbms_output.put_line('Mensaje Error: ' || osberrormessage);

END;
