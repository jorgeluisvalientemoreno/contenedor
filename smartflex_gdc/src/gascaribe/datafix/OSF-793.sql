column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuCommentType   number;
  isbOrderComme   varchar2(4000);
  nuErrorCode     number;
  sbErrorMesse    varchar2(4000);

  -- Poblacion a la que aplica el Datafix
  CURSOR cuPoblacion IS
  SELECT  OA.*
  FROM    OPEN.OR_ORDER_ACTIVITY OA
  WHERE   OA.ORDER_ID IN (
                          --------------- CONTRATO: 67242547  ----------------
                          244955081	,--	PREDIO CUENTA CON ACOMETIDA 
                          245942713	,--	DOCUMENTACION NO CUMPLE
                          247005269	,--	IMPOSIBILIDAD DE EJECUCION
                          247496159	,--	IMPOSIBILIDAD DE EJECUCION
                          248022934	,--	IMPOSIBILIDAD DE EJECUCION
                          248477882	,--	IMPOSIBILIDAD DE EJECUCION
                          249229091	,--	IMPOSIBILIDAD DE EJECUCION
                          249544090	,--	IMPOSIBILIDAD DE EJECUCION
                          250015771	,--	IMPOSIBILIDAD DE EJECUCION
                          250543719	,--	IMPOSIBILIDAD DE EJECUCION
                          250847947	,--	IMPOSIBILIDAD DE EJECUCION
                          251476849	,--	IMPOSIBILIDAD DE EJECUCION
                          251585677	,--	IMPOSIBILIDAD DE EJECUCION
                          252170917	,--	IMPOSIBILIDAD DE EJECUCION
                          253318825	,--	IMPOSIBILIDAD DE EJECUCION
                          253710881	,--	IMPOSIBILIDAD DE EJECUCION
                          254132390	,--	IMPOSIBILIDAD DE EJECUCION
                          254709390	,--	IMPOSIBILIDAD DE EJECUCION
                          255102473	,--	IMPOSIBILIDAD DE EJECUCION
                          256250857	,--	IMPOSIBILIDAD DE EJECUCION
                          256973069	,--	IMPOSIBILIDAD DE EJECUCION
                          257324401	,--	IMPOSIBILIDAD DE EJECUCION
                          258036510	,--	IMPOSIBILIDAD DE EJECUCION
                          258916127	,--	IMPOSIBILIDAD DE EJECUCION
                          260283861	,--	IMPOSIBILIDAD DE EJECUCION
                          260941350	,--	IMPOSIBILIDAD DE EJECUCION
                          261531784	,--	IMPOSIBILIDAD DE EJECUCION
                          261946158	,--	DOCUMENTACION NO CUMPLE
                          263042058	,--	IMPOSIBILIDAD DE EJECUCION
                          263607714	,--	INSTALACION CERTIFICADA
                          --------------- CONTRATO: 67251617  ----------------
                          245469298	,--	PREDIO CUENTA CON ACOMETIDA 
                          246323603	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          247208348	,--	INSTALACION CERTIFICADA
                          --------------- CONTRATO: 67253018  ----------------
                          245691922	,--	INSTALACION CERTIFICADA
                          245774106	,--	REUBICAR ANILLO
                          247364451	,--	INSTALACION CERTIFICADA
                          253806372	,--	REUBICAR ANILLO
                          269987988	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67264979  ----------------
                          248474396	,--	INSTALACION CERTIFICADA
                          249294641	,--	IMPOSIBILIDAD DE EJECUCION
                          249694806	,--	DOCUMENTACION NO CUMPLE
                          250752306	,--	IMPOSIBILIDAD DE EJECUCION
                          251048160	,--	IMPOSIBILIDAD DE EJECUCION
                          251501966	,--	IMPOSIBILIDAD DE EJECUCION
                          252172849	,--	IMPOSIBILIDAD DE EJECUCION
                          252939624	,--	IMPOSIBILIDAD DE EJECUCION
                          253620544	,--	IMPOSIBILIDAD DE EJECUCION
                          254294621	,--	IMPOSIBILIDAD DE EJECUCION
                          254710477	,--	IMPOSIBILIDAD DE EJECUCION
                          255214131	,--	IMPOSIBILIDAD DE EJECUCION
                          255958208	,--	IMPOSIBILIDAD DE EJECUCION
                          256415977	,--	IMPOSIBILIDAD DE EJECUCION
                          256999568	,--	IMPOSIBILIDAD DE EJECUCION
                          257324477	,--	IMPOSIBILIDAD DE EJECUCION
                          257703051	,--	INSTALACION CERTIFICADA
                          --------------- CONTRATO: 67306221  ----------------
                          256408093	,--	INSTALACION CERTIFICADA
                          256702964	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67317189  ----------------
                          258552899	,--	PREDIO CUENTA CON ACOMETIDA 
                          258945961	,--	IMPOSIBILIDAD DE EJECUCION
                          259402829	,--	INSTALACION CERTIFICADA
                          --------------- CONTRATO: 67324764	
                          259745391	,--	INSTALACION CERTIFICADA
                          260806727	,--	REUBICAR ANILLO
                          265628831	,--	INSTALACION CERTIFICADA
                          267477078	,--	INSTALACION CERTIFICADA
                          --------------- CONTRATO: 67340607	
                          263780183	,--	PREDIO CUENTA CON ACOMETIDA 
                          265349620	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          266126149	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          267486639	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          268458586	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          269549087	,--	IMPOSIBILIDAD DE EJECUCION
                          270051788	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          --------------- CONTRATO: 67340794	
                          263790676	,--	PREDIO CUENTA CON ACOMETIDA 
                          265350009	,--	IMPOSIBILIDAD DE EJECUCION
                          265547960	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          266806301	,--	IMPOSIBILIDAD DE EJECUCION
                          267647929	,--	IMPOSIBILIDAD DE EJECUCION
                          268408424	,--	IMPOSIBILIDAD DE EJECUCION
                          268720737	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          269998808	,--	IMPOSIBILIDAD DE EJECUCION
                          270305527	,--	IMPOSIBILIDAD DE EJECUCION
                          --------------- CONTRATO: 67342325	
                          264080202	,--	INSTALACION CERTIFICADA
                          264218032	,--	REUBICAR ANILLO
                          264668861	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67342344	
                          264080303	,--	INSTALACION CERTIFICADA
                          265324921	,--	REUBICAR ANILLO
                          268020413	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67342510	
                          264082064	,--	PREDIO CUENTA CON ACOMETIDA 
                          265349623	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          266127146	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          267477447	,--	INSTALACION CERTIFICADA
                          269254705	,--	ÉXITO
                          --------------- CONTRATO: 67343009	
                          264204478	,--	INSTALACION CERTIFICADA
                          264217906	,--	REUBICAR ANILLO
                          265010206	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67346378	
                          265172422	,--	INSTALACION CERTIFICADA
                          266936135	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67346816	
                          269411090	,--	REUBICAR ANILLO
                          269411091	,--	INSTALACION CERTIFICADA
                          269793909	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67348390	
                          265528414	,--	INSTALACION CERTIFICADA
                          265917637	,--	IMPOSIBILIDAD DE EJECUCION
                          266161718	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          267491384	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          268511820	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          269788244	,--	INSTALACION INTERNA NUEVA CON DEFECTOS
                          --------------- CONTRATO: 67351805	
                          268065659	,--	PREDIO CUENTA CON ACOMETIDA 
                          269351006	,--	INSTALACION CERTIFICADA
                          --------------- CONTRATO: 67353981	
                          269409720	,--	INSTALACION CERTIFICADA
                          269409721	,--	INSTALACION CERTIFICADA
                          269918039	,--	IMPOSIBILIDAD DE EJECUCION
                          270232883	,--	INSTALACION CERTIFICADA
                          --------------- CONTRATO: 67358427	
                          267498601	,--	INSTALACION CERTIFICADA
                          268759917	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67358480	
                          270294953	,--	PREDIO CUENTA CON ACOMETIDA 
                          270294964	,--	INSTALACION CERTIFICADA
                          270396621	,--	IMPOSIBILIDAD DE EJECUCION
                          --------------- CONTRATO: 67358858	
                          267619495	,--	INSTALACION CERTIFICADA
                          269090046	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67358890	
                          267621430	,--	INSTALACION CERTIFICADA
                          268945163	,--	REUBICAR ANILLO
                          --------------- CONTRATO: 67360722	
                          270230609	,--	INSTALACION CERTIFICADA
                          270230618	 --	INSTALACION CERTIFICADA
  );

begin
  dbms_output.put_line('---- Inicio OSF-793 ----');

  FOR reg in cuPoblacion
  LOOP
    UPDATE  OPEN.OR_ORDER_ACTIVITY
    SET     OR_ORDER_ACTIVITY.PACKAGE_ID = NULL,
            OR_ORDER_ACTIVITY.MOTIVE_ID = NULL
    WHERE   ORDER_ID = reg.ORDER_ID;
    dbms_output.put_line('Se actualiza la orden ['||reg.ORDER_ID||'] PACKAGE_ID actual ['||reg.PACKAGE_ID||'] - MOTIVE_ID Actual [' ||reg.MOTIVE_ID||']');

    If (reg.ORDER_ID in (245774106, 253806372, 264217906, 264218032, 268020413, 269411090)) THEN
      nuCommentType := 3;
    else
      nuCommentType := 1277;
    end if;

    isbOrderComme  := 'La orden ['||reg.ORDER_ID||'] pertenecia a la solicitud ['||reg.PACKAGE_ID||'] y al motivo [' ||reg.MOTIVE_ID||'] - Se desvinculan por el Caso OSF-793';

    -- Adiciona comentario en la orden
    OS_ADDORDERCOMMENT( inuOrderId       => reg.ORDER_ID,
                        inuCommentTypeId => nuCommentType,
                        isbComment       => isbOrderComme,
                        onuErrorCode     => nuErrorCode,
                        osbErrorMessage  => sbErrorMesse);
    IF (nuErrorCode <> 0) THEN
      dbms_output.put_line('No se logro crear el comentario de La orden ['||reg.ORDER_ID||']');
    END IF;
    dbms_output.put_line('[OR_ORDER_COMMENT] - ['||isbOrderComme||']');

  END LOOP;

  COMMIT;

  dbms_output.put_line('---- Fin OSF-793 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-793 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/