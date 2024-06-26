DECLARE
  task_type_id NUMBER;
  agente_id    NUMBER;
  initial_date DATE;
  final_date   DATE;
  EX_TECHNI_NOT_EXIST EXCEPTION;
  EX_ORDER_NOT_EXIST  EXCEPTION;
  EX_NULL_DATES       EXCEPTION;
  nuOrden         number := 59455453;
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(4000);
  accion          number;
BEGIN
  accion := 1;
  if accion = 1 then
    --Inserccion de datos
  
    BEGIN
      SELECT TASK_TYPE_ID
        INTO task_type_id
        FROM OPEN.OR_ORDER
       WHERE ORDER_ID = nuOrden;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE EX_ORDER_NOT_EXIST;
    END;
  
    initial_date := sysdate - 2;
    final_date   := sysdate - 1;
  
    INSERT INTO OPEN.LDC_OTLEGALIZAR
      (ORDER_ID,
       CAUSAL_ID,
       ORDER_COMMENT,
       EXEC_INITIAL_DATE,
       EXEC_FINAL_DATE,
       LEGALIZADO,
       FECHA_REGISTRO,
       TASK_TYPE_ID)
    VALUES
      (nuOrden,
       9595,
       'PRUEBA OSF-469',
       initial_date,
       final_date,
       'N',
       SYSDATE,
       task_type_id);
    BEGIN
    
      agente_id := 72;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE EX_TECHNI_NOT_EXIST;
    END;
    INSERT INTO OPEN.LDC_ANEXOLEGALIZA
      (ORDER_ID, AGENTE_ID, TECNICO_UNIDAD)
    VALUES
      (nuOrden, agente_id, 1);
    COMMIT;
  
  elsif accion = 3 then
    --Borrado 
    delete from OPEN.LDC_ANEXOLEGALIZA where ORDER_ID = nuOrden;
    delete from OPEN.LDC_OTLEGALIZAR where ORDER_ID = nuOrden;
    commit;
  
  end if;
EXCEPTION

  WHEN OTHERS THEN
    "OPEN".ERRORS.SETERROR;
    "OPEN".ERRORS.GETERROR(onuErrorCode, osbErrorMessage);
    ROLLBACK;
END;
