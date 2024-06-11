DECLARE
    nuErrorCode         NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    -- Inicializa contador de productos procesados
    nuTotal             NUMBER  := 0;

    type tyrcRegister IS record
    (
        interface_history_id         in_interface_history.interface_history_id%type
    );

    type tytbInHistory IS table of tyrcRegister index BY binary_integer;

    rcRegister          tyrcRegister;
    tbInHistory         tytbInHistory;

    -- CURSOR para actividades detenidas
    CURSOR cuInHistory
    IS
              SELECT in_interface_history.interface_history_id
              FROM in_interface_history
              WHERE in_interface_history.status_id = 9
              AND in_interface_history.request_number_origi IS not null
              AND trunc(in_interface_history.inserting_date) >= trunc(to_date('07/09/2015','DD/MM/YYYY'));

BEGIN
    nuErrorCode := 0;

    open  cuInHistory;
    fetch cuInHistory bulk collect INTO tbinHistory;
    close cuInHistory;
    
    nuTotal := NVL(tbinHistory.last,0);
    dbms_output.put_line('Total de Registros a procesar: '||nuTotal);

    for pos in tbinHistory.first..tbinHistory.last loop
    
       IN_BSMessageReProcess.MessageReProcess(tbinHistory(pos).interface_history_id, nuErrorCode, sbErrorMessage);
       
       if (nuErrorCode>0)
       then
          dbms_output.put_line('Error en registro: '||tbinHistory(pos).interface_history_id||'Error: '||nuErrorCode||' '||sbErrorMessage);
       END if;

    END loop;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END;