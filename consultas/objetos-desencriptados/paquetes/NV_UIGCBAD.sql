PACKAGE BODY NV_UIGCBAD IS 
   















    
    
    
    CSBVERSION                  CONSTANT UT_DATATYPES.STYSAOVERSION := 'SAO496172';
    GSBERRMSG                   GE_ERROR_LOG.DESCRIPTION%TYPE := NULL;


    
    
    


   




   FUNCTION FSBVERSION
   RETURN UT_DATATYPES.STYSAOVERSION IS
   BEGIN
       RETURN CSBVERSION;
   END FSBVERSION;

    















    PROCEDURE VALACTGESPATIALSERVER
    (
        ITYDATA IN DYNTYPE
    )IS
        TBKEYS      GE_BOLOGICALDELETED.TYTBKEYS;
        TBKEYSVAR   GE_BOLOGICALDELETED.TYTBKEYSVAR;
    BEGIN

        UT_TRACE.TRACE('BEGIN NV_UIGCBAD.ValActGeSpatialServer', 3);

        TBKEYS('SPATIAL_SERVER_ID'):= NULL;

        GE_BOLOGICALDELETED.VALIDATEACTIVEUNTIL(ITYDATA, TBKEYS, TBKEYSVAR);

        UT_TRACE.TRACE('END NV_UIGCBAD.ValActGeSpatialServer', 3);

    EXCEPTION
        WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            UT_TRACE.TRACE('ERROR NV_UIGCBAD.ValActGeSpatialServer', 3);
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GSBERRMSG );
            UT_TRACE.TRACE('ERROR NV_UIGCBAD.ValActGeSpatialServer', 3);
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GSBERRMSG);
    END VALACTGESPATIALSERVER;

END NV_UIGCBAD;