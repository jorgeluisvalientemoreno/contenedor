
CREATE OR REPLACE PACKAGE BODY MO_BCDATA_FOR_ORDER IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO191014';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FRFGETTASKTYPEDESC( INUMOTIVEID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      CRFTASKTYPE CONSTANTS.TYREFCURSOR;
    BEGIN
      OPEN CRFTASKTYPE FOR SELECT a.task_type_id || '-' || b.description task_type_id
            FROM mo_data_for_order a, or_task_type b
            WHERE a.motive_id = inuMotiveId
            AND a.task_type_id = b.task_type_id;
      RETURN CRFTASKTYPE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE GETITEMSBYPACKAGE( INUPACKAGEID IN MO_DATA_FOR_ORDER.PACKAGE_ID%TYPE, OTBDATAFORORDER OUT DAGE_ITEMS.TYTBITEMS_ID )
    IS
      CURSOR CUGETITEMSBYPACKAGE( INUPACKAGEID IN MO_DATA_FOR_ORDER.PACKAGE_ID%TYPE ) IS
SELECT item_id, quantity
            FROM mo_data_for_order
            WHERE mo_data_for_order.package_id = inuPackageId;
      NUQUANTITY MO_DATA_FOR_ORDER.QUANTITY%TYPE;
    BEGIN
      OTBDATAFORORDER.DELETE;
      FOR RGITEMS IN CUGETITEMSBYPACKAGE( INUPACKAGEID )
       LOOP
         NUQUANTITY := NVL( RGITEMS.QUANTITY, 1 );
         IF NUQUANTITY < 1 THEN
            NUQUANTITY := 1;
         END IF;
         FOR NUINDEX IN 1..NUQUANTITY
          LOOP
            OTBDATAFORORDER( NUINDEX ) := RGITEMS.ITEM_ID;
         END LOOP;
      END LOOP;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUGETITEMSBYPACKAGE%ISOPEN THEN
            CLOSE CUGETITEMSBYPACKAGE;
         END IF;
         RAISE;
      WHEN OTHERS THEN
         IF CUGETITEMSBYPACKAGE%ISOPEN THEN
            CLOSE CUGETITEMSBYPACKAGE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETITEMSBYPACKAGE;
   PROCEDURE GETITEMSBYMOTIVE( INUMOTIVEID IN MO_DATA_FOR_ORDER.MOTIVE_ID%TYPE, OTBDATAFORORDER OUT DAGE_ITEMS.TYTBITEMS_ID )
    IS
      CURSOR CUGETITEMSBYMOTIVE( INUMOTIVEID IN MO_DATA_FOR_ORDER.MOTIVE_ID%TYPE ) IS
SELECT item_id, quantity
            FROM mo_data_for_order
            WHERE mo_data_for_order.Motive_id = inuMotiveId;
      NUQUANTITY MO_DATA_FOR_ORDER.QUANTITY%TYPE;
    BEGIN
      OTBDATAFORORDER.DELETE;
      FOR RGITEMS IN CUGETITEMSBYMOTIVE( INUMOTIVEID )
       LOOP
         NUQUANTITY := NVL( RGITEMS.QUANTITY, 1 );
         IF NUQUANTITY < 1 THEN
            NUQUANTITY := 1;
         END IF;
         FOR NUINDEX IN 1..NUQUANTITY
          LOOP
            OTBDATAFORORDER( NUINDEX ) := RGITEMS.ITEM_ID;
         END LOOP;
      END LOOP;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUGETITEMSBYMOTIVE%ISOPEN THEN
            CLOSE CUGETITEMSBYMOTIVE;
         END IF;
         RAISE;
      WHEN OTHERS THEN
         IF CUGETITEMSBYMOTIVE%ISOPEN THEN
            CLOSE CUGETITEMSBYMOTIVE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETITEMSBYMOTIVE;
   PROCEDURE GETITEMSBYCOMPONENT( INUCOMPONENTID IN MO_DATA_FOR_ORDER.COMPONENT_ID%TYPE, OTBDATAFORORDER OUT DAGE_ITEMS.TYTBITEMS_ID )
    IS
      CURSOR CUGETITEMSBYCOMPONENT( INUCOMPONENTID IN MO_DATA_FOR_ORDER.COMPONENT_ID%TYPE ) IS
SELECT item_id, quantity
            FROM   mo_data_for_order
            WHERE  mo_data_for_order.component_id = inuComponentId;
      NUQUANTITY MO_DATA_FOR_ORDER.QUANTITY%TYPE;
    BEGIN
      OTBDATAFORORDER.DELETE;
      FOR RGITEMS IN CUGETITEMSBYCOMPONENT( INUCOMPONENTID )
       LOOP
         NUQUANTITY := NVL( RGITEMS.QUANTITY, 1 );
         IF NUQUANTITY < 1 THEN
            NUQUANTITY := 1;
         END IF;
         FOR NUINDEX IN 1..NUQUANTITY
          LOOP
            OTBDATAFORORDER( NUINDEX ) := RGITEMS.ITEM_ID;
         END LOOP;
      END LOOP;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUGETITEMSBYCOMPONENT%ISOPEN THEN
            CLOSE CUGETITEMSBYCOMPONENT;
         END IF;
         RAISE;
      WHEN OTHERS THEN
         IF CUGETITEMSBYCOMPONENT%ISOPEN THEN
            CLOSE CUGETITEMSBYCOMPONENT;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETITEMSBYCOMPONENT;
   PROCEDURE GETDATAFORORDERBYPACKAGE( INUPACKAGEID IN MO_DATA_FOR_ORDER.PACKAGE_ID%TYPE, RFRESULT OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO MO_BCData_For_Order.GetDataForOrderByPackage ', 15 );
      OPEN RFRESULT FOR SELECT MO_data_for_order.*,MO_data_for_order.rowid
            FROM mo_data_for_order
            WHERE package_id = inuPackageId;
      UT_TRACE.TRACE( 'FIN MO_BCData_For_Order.GetDataForOrderByPackage ', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETDATAFORORDERBYPACKAGE;
   FUNCTION FTBGETDATABYPACK( INUPACKAGEID IN MO_DATA_FOR_ORDER.PACKAGE_ID%TYPE )
    RETURN DAMO_DATA_FOR_ORDER.TYTBMO_DATA_FOR_ORDER
    IS
      TBMO_DATA_FOR_ORDER DAMO_DATA_FOR_ORDER.TYTBMO_DATA_FOR_ORDER;
    BEGIN
      UT_TRACE.TRACE( 'INICIO MO_BCData_For_Order.ftbGetDataByPack ', 15 );
      OPEN CUDATAFORORDERBYPACKID( INUPACKAGEID );
      FETCH CUDATAFORORDERBYPACKID
         BULK COLLECT INTO TBMO_DATA_FOR_ORDER;
      CLOSE CUDATAFORORDERBYPACKID;
      UT_TRACE.TRACE( 'FIN MO_BCData_For_Order.ftbGetDataByPack ' || TBMO_DATA_FOR_ORDER.COUNT, 15 );
      RETURN TBMO_DATA_FOR_ORDER;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETDATABYPACK;
   FUNCTION FTBGETDATAONLYMOT( INUMOTIVEID IN MO_DATA_FOR_ORDER.MOTIVE_ID%TYPE )
    RETURN DAMO_DATA_FOR_ORDER.TYTBMO_DATA_FOR_ORDER
    IS
      TBMO_DATA_FOR_ORDER DAMO_DATA_FOR_ORDER.TYTBMO_DATA_FOR_ORDER;
    BEGIN
      UT_TRACE.TRACE( 'INICIO MO_BCData_For_Order.ftbGetDataOnlyMot ', 15 );
      OPEN CUDATAFORORDERONLYMOT( INUMOTIVEID );
      FETCH CUDATAFORORDERONLYMOT
         BULK COLLECT INTO TBMO_DATA_FOR_ORDER;
      CLOSE CUDATAFORORDERONLYMOT;
      UT_TRACE.TRACE( 'FIN MO_BCData_For_Order.ftbGetDataOnlyMot ' || TBMO_DATA_FOR_ORDER.COUNT, 15 );
      RETURN TBMO_DATA_FOR_ORDER;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETDATAONLYMOT;
   FUNCTION FTBGETDATAONLYCOMP( INUCOMPONENTID IN MO_DATA_FOR_ORDER.COMPONENT_ID%TYPE )
    RETURN DAMO_DATA_FOR_ORDER.TYTBMO_DATA_FOR_ORDER
    IS
      TBMO_DATA_FOR_ORDER DAMO_DATA_FOR_ORDER.TYTBMO_DATA_FOR_ORDER;
    BEGIN
      UT_TRACE.TRACE( 'INICIO MO_BCData_For_Order.ftbGetDataOnlyComp ', 15 );
      OPEN CUDATAFORORDERONLYCOMP( INUCOMPONENTID );
      FETCH CUDATAFORORDERONLYCOMP
         BULK COLLECT INTO TBMO_DATA_FOR_ORDER;
      CLOSE CUDATAFORORDERONLYCOMP;
      UT_TRACE.TRACE( 'FIN MO_BCData_For_Order.ftbGetDataOnlyComp ' || TBMO_DATA_FOR_ORDER.COUNT, 15 );
      RETURN TBMO_DATA_FOR_ORDER;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETDATAONLYCOMP;
END MO_BCDATA_FOR_ORDER;
/

