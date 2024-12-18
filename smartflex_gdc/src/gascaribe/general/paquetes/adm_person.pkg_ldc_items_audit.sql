CREATE OR REPLACE PACKAGE adm_person.PKG_LDC_ITEMS_AUDIT
IS

	PROCEDURE PRINSERTAR (  nuLIST_UNITARY_COST_ID    LDC_ITEMS_AUDIT.LIST_UNITARY_COST_ID%type,
                          nuITEM                    LDC_ITEMS_AUDIT.ITEM%type,
                          nuPREV_PRICE              LDC_ITEMS_AUDIT.PREV_PRICE%type,
                          nuCURR_PRICE              LDC_ITEMS_AUDIT.CURR_PRICE%type,
                          nuPREV_SALVALUE           LDC_ITEMS_AUDIT.PREV_SALVALUE%type,
                          nuCURR_SALVALUE           LDC_ITEMS_AUDIT.CURR_SALVALUE%type,
                          sbCOMMENT                 LDC_ITEMS_AUDIT.COMMENTS%type,
                          sbOPERATION               LDC_ITEMS_AUDIT.OPERATION%type
                       );

END PKG_LDC_ITEMS_AUDIT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_ITEMS_AUDIT
IS

  PROCEDURE PRINSERTAR (  nuLIST_UNITARY_COST_ID    LDC_ITEMS_AUDIT.LIST_UNITARY_COST_ID%type,
                          nuITEM                    LDC_ITEMS_AUDIT.ITEM%type,
                          nuPREV_PRICE              LDC_ITEMS_AUDIT.PREV_PRICE%type,
                          nuCURR_PRICE              LDC_ITEMS_AUDIT.CURR_PRICE%type,
                          nuPREV_SALVALUE           LDC_ITEMS_AUDIT.PREV_SALVALUE%type,
                          nuCURR_SALVALUE           LDC_ITEMS_AUDIT.CURR_SALVALUE%type,
                          sbCOMMENT                 LDC_ITEMS_AUDIT.COMMENTS%type,
                          sbOPERATION               LDC_ITEMS_AUDIT.OPERATION%type
                       )
  IS
     nuConsecutivo  LDC_ITEMS_AUDIT.CONSECUTIVE%type;
  BEGIN

    ut_trace.trace('INICIO PKG_LDC_ITEMS_AUDIT.PRINSERTAR', 5);

    SELECT SEQ_LDC_ITEMS_AUDIT.NEXTVAL INTO nuConsecutivo FROM DUAL;

    INSERT INTO LDC_ITEMS_AUDIT(  CONSECUTIVE          ,
                                  LIST_UNITARY_COST_ID ,
                                  ITEM                 ,
                                  PREV_PRICE           ,
                                  CURR_PRICE           ,
                                  PREV_SALVALUE        ,
                                  CURR_SALVALUE        ,
                                  COMMENTS             ,
                                  OPERATION            ,
                                  USER_ID              ,
                                  MODIF_DATE
                               )
    VALUES(nuConsecutivo          ,
           nuLIST_UNITARY_COST_ID ,
           nuITEM                 ,
           nuPREV_PRICE           ,
           nuCURR_PRICE           ,
           nuPREV_SALVALUE        ,
           nuCURR_SALVALUE        ,
           sbCOMMENT              ,
           sbOPERATION            ,
           USER                   ,
           SYSDATE
          );

    ut_trace.trace('FIN PKG_LDC_ITEMS_AUDIT.PRINSERTAR', 5);

  EXCEPTION when others then
     RAISE_APPLICATION_ERROR(-20996, sqlerrm);
     raise ex.CONTROLLED_ERROR;

  END PRINSERTAR;


END PKG_LDC_ITEMS_AUDIT;
/
Prompt Otorgando permisos sobre ADM_PERSON.PKG_LDC_ITEMS_AUDIT
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('PKG_LDC_ITEMS_AUDIT'), 'ADM_PERSON');
END;
/