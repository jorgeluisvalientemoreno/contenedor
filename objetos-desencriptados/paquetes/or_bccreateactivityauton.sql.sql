CREATE OR REPLACE PACKAGE BODY OR_BCCREATEACTIVITYAUTON IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO81339';
   CNUADMINTASKTYPES CONSTANT NUMBER := 0;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FRFGETACTIVITIESLOV( ISBCONCATSYMBOL IN VARCHAR2 := NULL )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      RFRESULT CONSTANTS.TYREFCURSOR;
    BEGIN
      IF ( ISBCONCATSYMBOL ) IS NULL THEN
         OPEN RFRESULT FOR SELECT ge_items.items_id id,
                       ge_items.description
                FROM ge_items,
                     or_task_types_items,
                     or_task_type
                WHERE ge_items.item_classif_id = or_boorderactivities.fnuActivityType()
                  AND ge_items.items_id = or_task_types_items.items_id
                  AND or_task_type.task_type_id= or_task_types_items.task_type_id
                  AND or_task_type.task_type_classif = cnuAdminTaskTypes;
       ELSE
         OPEN RFRESULT FOR SELECT ge_items.items_id id,
                       ge_items.items_id || isbConcatSymbol ||
                       ge_items.description description
                FROM ge_items,
                     or_task_types_items,
                     or_task_type
                WHERE ge_items.item_classif_id = or_boorderactivities.fnuActivityType()
                  AND ge_items.items_id = or_task_types_items.items_id
                  AND or_task_type.task_type_id= or_task_types_items.task_type_id
                  AND or_task_type.task_type_classif = cnuAdminTaskTypes;
      END IF;
      RETURN RFRESULT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETACTIVITIESLOV;
   FUNCTION FRFGETCREATEDORDERS( INUACTIVITYGROUPID IN OR_ORDER_ACTIVITY.ACTIVITY_GROUP_ID%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      RFRESULT CONSTANTS.TYREFCURSOR;
    BEGIN
      OPEN RFRESULT FOR SELECT or_order_activity.order_id
                FROM or_order_activity
                WHERE or_order_activity.order_id IS not null
                  AND or_order_activity.activity_group_id = inuActivityGroupId;
      RETURN RFRESULT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETCREATEDORDERS;
END OR_BCCREATEACTIVITYAUTON;
/


