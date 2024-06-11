/**********************************************************************
	Propiedad intelectual de OPEN International Systems
	Nombre
	Autor               DIEGO ARMANDO AREVALO GOMEZ

	Fecha               26-FEBRERO-2015

	Descripción        Realiza la notificación de WORFLOW con Fallo

***********************************************************************/

DECLARE
    nuError     NUMBER;
    sbError     VARCHAR2(2000);
    ionuComp   open.pr_component.component_id%type;
    ionuOrderActi open.or_order_activity.order_activity_id%type;

    CURSOR CUINSTANCIA IS
    SELECT A.* FROM OPEN.wf_instance A WHERE A.UNIT_TYPE_ID=162 AND A.STATUS_ID=4
    AND exists (select 1 FROM OPEN.wf_instance B WHERE B.UNIT_TYPE_ID=100243 AND B.STATUS_ID IN (4,6) AND A.PARENT_EXTERNAL_ID=B.PARENT_EXTERNAL_ID);

    TYPE TYTBINSTANCIA IS TABLE OF CUINSTANCIA%ROWTYPE;

    TBINSTANCIA TYTBINSTANCIA;
BEGIN
dbms_output.put_line('Inicio');

    IF CUINSTANCIA%ISOPEN THEN
        CLOSE CUINSTANCIA;
    END IF;

    OPEN CUINSTANCIA;
        FETCH CUINSTANCIA BULK COLLECT INTO TBINSTANCIA;
    CLOSE CUINSTANCIA;

    IF TBINSTANCIA.COUNT > 0 THEN
        FOR N IN TBINSTANCIA.FIRST..TBINSTANCIA.LAST LOOP
        
        WF_BOAnswer_Receptor.AnswerReceptor(TBINSTANCIA(N).INSTANCE_ID, 2); --Notifica Fallo la Instancia
        commit;

        UPDATE in_interface_history
        SET STATUS_ID=2,
        last_mess_code_error=NULL,
        last_mess_desc_error=NULL
        WHERE REQUEST_NUMBER_ORIGI=TBINSTANCIA(N).INSTANCE_ID;
        
        COMMIT;

        END LOOP;
    END IF;
   COMMIT;
 dbms_output.put_line('Fin');
 EXCEPTION
  when ex.CONTROLLED_ERROR  then
       Errors.getError(nuError, sbError);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuError);
       dbms_output.put_line('error osbErrorMess: '||sbError);

    when OTHERS then
         Errors.setError;
       Errors.getError(nuError, sbError);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuError);
        dbms_output.put_line('error osbErrorMess: '||sbError);
END;
/