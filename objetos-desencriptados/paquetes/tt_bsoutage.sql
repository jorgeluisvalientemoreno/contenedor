PACKAGE BODY TT_BSOutage
IS
    




















    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO206341';

    
    
    

    
    
    

    
    
    
    













    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    























    PROCEDURE REGISTEROUTAGE
    (
        INUFAULTTYPEID   IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        IDTOUTAGEINIT    IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        INUORDERID       IN  OR_ORDER.ORDER_ID%TYPE,
        INUTIME          IN  NUMBER,
        ISBCLASS         IN  TT_DAMAGE.CLASS%TYPE,
        ISBAFFECTEDPRODS IN  VARCHAR2,
        ISBCOMMENT       IN  MO_COMMENT.COMMENT_%TYPE,
        ONUFAULTID       OUT TT_DAMAGE.PACKAGE_ID%TYPE,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        TBAFFECTEDPRODS DAPR_PRODUCT.TYTBPRODUCT_ID; 
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);
        
        
        TT_BOOUTAGE.VALREGISTEROUTAGE(INUFAULTTYPEID,
                                      IDTOUTAGEINIT,
                                      INUORDERID,
                                      INUTIME,
                                      ISBCLASS);
        
        TT_BOOUTAGE.EXTPRODUCTS(ISBAFFECTEDPRODS,
                                FALSE,           
                                TRUE,            
                                TBAFFECTEDPRODS);
        
        TT_BOOUTAGE.REGISTEROUTAGE(INUFAULTTYPEID,
                                   IDTOUTAGEINIT,
                                   INUORDERID,
                                   INUTIME,
                                   ISBCLASS,
                                   ISBCOMMENT,
                                   ONUFAULTID);
                                   
        
        IF (TBAFFECTEDPRODS.COUNT > 0) THEN
            TT_BOOUTAGE.ADDPRODSTOOUTAGE(ONUFAULTID,
                                         TBAFFECTEDPRODS);
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END REGISTEROUTAGE;
    
    

















    PROCEDURE ADDPRODSTOOUTAGE
    (
        INUFAULTID       IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        ISBAFFECTEDPRODS IN  VARCHAR2,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        TBAFFECTEDPRODS DAPR_PRODUCT.TYTBPRODUCT_ID; 
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);

        
        TT_BOOUTAGE.VALPRODSOUTAGE(INUFAULTID,
                                   ISBAFFECTEDPRODS);
        
        TT_BOOUTAGE.EXTPRODUCTS(ISBAFFECTEDPRODS,
                                TRUE,            
                                TRUE,            
                                TBAFFECTEDPRODS);
        
        TT_BOOUTAGE.ADDPRODSTOOUTAGE(INUFAULTID,
                                     TBAFFECTEDPRODS);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END ADDPRODSTOOUTAGE;
    
    

















    PROCEDURE REMPRODSFROMOUTAGE
    (
        INUFAULTID       IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        ISBAFFECTEDPRODS IN  VARCHAR2,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        TBAFFECTEDPRODS DAPR_PRODUCT.TYTBPRODUCT_ID; 
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);

        
        TT_BOOUTAGE.VALPRODSOUTAGE(INUFAULTID,
                                   ISBAFFECTEDPRODS);
        
        TT_BOOUTAGE.EXTPRODUCTS(ISBAFFECTEDPRODS,
                                TRUE,            
                                FALSE,           
                                TBAFFECTEDPRODS);
        
        TT_BOOUTAGE.REMPRODSFROMOUTAGE(INUFAULTID,
                                       TBAFFECTEDPRODS);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END REMPRODSFROMOUTAGE;
    
    






















    PROCEDURE ATTENDOUTAGE
    (
        INUFAULTID        IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID    IN  TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        INUCLOSURECAUSEID IN  TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE,
        IDTOUTAGEINIT     IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTOUTAGEEND      IN  TT_DAMAGE.END_DATE%TYPE,
        ISBAFFECTEDPRODS  IN  VARCHAR2,
        ONUERRORCODE      OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE   OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        TBAFFECTEDPRODS DAPR_PRODUCT.TYTBPRODUCT_ID; 
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);

        
        TT_BOOUTAGE.VALATTENDOUTAGE(INUFAULTID,
                                    INUFAULTTYPEID,
                                    INUCLOSURECAUSEID,
                                    IDTOUTAGEINIT,
                                    IDTOUTAGEEND);
        
        TT_BOOUTAGE.EXTPRODUCTS(ISBAFFECTEDPRODS,
                                TRUE,            
                                FALSE,           
                                TBAFFECTEDPRODS);
        
        TT_BOOUTAGE.ATTENDOUTAGE(INUFAULTID,
                                 INUFAULTTYPEID,
                                 INUCLOSURECAUSEID,
                                 IDTOUTAGEINIT,
                                 IDTOUTAGEEND,
                                 TBAFFECTEDPRODS);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END ATTENDOUTAGE;
    
    




















    PROCEDURE UPDATEOUTAGE
    (
        INUFAULTID       IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID   IN  TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        IDTOUTAGEINIT    IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENDDATE IN  TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        INUADDRESSID     IN  AB_ADDRESS.ADDRESS_ID%TYPE,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);
                                        
        
        TT_BOOUTAGE.VALUPDATEOUTAGE(INUFAULTID,
                                    INUFAULTTYPEID,
                                    IDTOUTAGEINIT,
                                    INUADDRESSID);
        
        TT_BOFAULT.UPDATEFAULT(INUFAULTID,      
                               IDTOUTAGEINIT,   
                               IDTESTATTENDDATE,
                               INUFAULTTYPEID,  
                               NULL,            
                               NULL ,           
                               NULL);           
        
        TT_BOOUTAGE.UPDATEOUTAGEADDR(INUFAULTID,
                                     INUADDRESSID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END UPDATEOUTAGE;
    
END TT_BSOUTAGE;