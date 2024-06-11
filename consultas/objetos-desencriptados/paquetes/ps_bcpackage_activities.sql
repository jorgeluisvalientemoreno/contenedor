PACKAGE BODY PS_BCPackage_Activities
IS

































    
    
    
    
    
    
    
    
    

    
    
    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO201614';
    
    
    CNUTRACELEVEL       CONSTANT    NUMBER  := 7;

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    
























    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
    
        UT_TRACE.TRACE('Inicio: PS_BCPackage_Activities.fsbVersion', CNUTRACELEVEL);
        
        UT_TRACE.TRACE('Fin: PS_BCPackage_Activities.fsbVersion', CNUTRACELEVEL);
        RETURN CSBVERSION;
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: PS_BCPackage_Activities.fsbVersion', CNUTRACELEVEL);
        	RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: PS_BCPackage_Activities.fsbVersion', CNUTRACELEVEL);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FSBVERSION;
    
    












































    FUNCTION FRFINFOBYOTHERSUBJECT
    (
        INUPACKAGETYPE  IN    PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE,
        INUCAUSALTYPE   IN    CC_CAUSAL_TYPE.CAUSAL_TYPE_ID%TYPE,
        INUCAUSAL       IN    CC_CAUSAL.CAUSAL_ID%TYPE,
        INUSERVICE      IN    SERVICIO.SERVCODI%TYPE,
        INUITEMID       IN    GE_ITEMS.ITEMS_ID%TYPE
    )
    RETURN PKCONSTANTE.TYREFCURSOR
    IS
        
        RFCURSOR        PKCONSTANTE.TYREFCURSOR;
        
        
        SBSQL           VARCHAR2(20000);
    BEGIN
    
        UT_TRACE.TRACE('Inicio: PS_BCPackage_Activities.frfInfoByOtherSubject', CNUTRACELEVEL);
        
        UT_TRACE.TRACE ( 'inuPackageType = '|| INUPACKAGETYPE, CNUTRACELEVEL );
        UT_TRACE.TRACE ( 'inuCausalType = '|| INUCAUSALTYPE, CNUTRACELEVEL );
        UT_TRACE.TRACE ( 'inuCausal = '|| INUCAUSAL, CNUTRACELEVEL );
        UT_TRACE.TRACE ( 'inuService = '|| INUSERVICE, CNUTRACELEVEL );
        UT_TRACE.TRACE ( 'inuItemId = '|| INUITEMID, CNUTRACELEVEL );
        
        SBSQL := 'SELECT  /*+ index (a UX_PS_PACKAGE_ACTIVITIES02) */ '||CHR(10)||
                 'a.*, a.rowid '||CHR(10)||
                 'FROM    ps_package_activities a --+ PS_BCPackage_Activities.frfInfoByOtherSubject '||CHR(10)||
                 'WHERE   a.package_type_id = nvl ( :inuPackageType, a.package_type_id ) '||CHR(10)||
                 'AND     a.causal_type_id  = nvl ( :inuCausalType, a.causal_type_id ) '||CHR(10)||
                 'AND     a.items_id        = nvl ( :inuItemId, a.items_id ) '||CHR(10);

        IF ( INUCAUSAL IS NULL ) THEN
        
            SBSQL := SBSQL || 'AND     a.causal_id IS null' || CHR(10);
        
        ELSE
        
            SBSQL := SBSQL || 'AND     a.causal_id = ' || INUCAUSAL || CHR(10);
        
        END IF;

        IF ( INUSERVICE IS NOT NULL ) THEN
        
            SBSQL := SBSQL || 'AND     a.servcodi = ' || INUSERVICE;
        
        END IF;

        
        OPEN RFCURSOR FOR SBSQL USING INUPACKAGETYPE, INUCAUSALTYPE, INUITEMID;
        
        UT_TRACE.TRACE('sbSql '||SBSQL, CNUTRACELEVEL);
        
        UT_TRACE.TRACE('Fin: PS_BCPackage_Activities.frfInfoByOtherSubject', CNUTRACELEVEL);
        RETURN RFCURSOR;
    
    EXCEPTION
    
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: PS_BCPackage_Activities.frfInfoByOtherSubject', CNUTRACELEVEL);
            UT_TRACE.TRACE(SBSQL, CNUTRACELEVEL);
        	RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: PS_BCPackage_Activities.frfInfoByOtherSubject', CNUTRACELEVEL);
            UT_TRACE.TRACE(SBSQL, CNUTRACELEVEL);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FRFINFOBYOTHERSUBJECT;

END PS_BCPACKAGE_ACTIVITIES;