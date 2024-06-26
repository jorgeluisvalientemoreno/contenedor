PACKAGE TT_BSFault
IS
    







































































































    
    
    

    
    
    

    
    
    
    FUNCTION FSBVERSION
    RETURN VARCHAR2;
    
    PROCEDURE REGISTERFAULT
    (
        INUFAULTTYPEID   IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        INUELEMENTID     IN  TT_DAMAGE.ELEMENT_ID%TYPE,
        INUINITASSIGID   IN  IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID  IN  IF_ASSIGNABLE.ID%TYPE,
        IDTINITIALDATE   IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENDDATE IN  TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ISBCOMMENT       IN  MO_COMMENT.COMMENT_%TYPE,
        ONUFAULTID       OUT TT_DAMAGE.PACKAGE_ID%TYPE,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );
    
    PROCEDURE ATTENDFAULT
    (
        INUFAULTID        IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID    IN  TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        INUCLOSURECAUSEID IN  TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE,
        IDTINITIALDATE    IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTENDDATE        IN  TT_DAMAGE.END_DATE%TYPE,
        ISBAFFECTEDELEMS  IN  VARCHAR2,
        ONUERRORCODE      OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE   OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );

    PROCEDURE GETFAULT
    (
        INUFAULTID          IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OSBSTATUS           OUT VARCHAR2,
        OSBFAULTTYPE        OUT VARCHAR2,
        OSBCAUSAL           OUT VARCHAR2,
        ODTREGISTERDATE     OUT MO_PACKAGES.REQUEST_DATE%TYPE,
        ODTFIRSTINCABSORBED OUT TT_DAMAGE.DAMAGE_ABSOR_DATE%TYPE,
        ODTESTATTENDDATE    OUT TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ODTATTENTIONDATE    OUT MO_PACKAGES.ATTENTION_DATE%TYPE,
        ODTOUTAGEINIT       OUT TT_DAMAGE.INITIAL_DATE%TYPE,
        ODTOUTAGEEND        OUT TT_DAMAGE.END_DATE%TYPE,
        OSBELEMENTCODE      OUT IF_NODE.CODE%TYPE,
        OSBELEMENTTYPE      OUT VARCHAR2,
        OSBELEMENTCLASS     OUT VARCHAR2,
        OSBCOMPENSATE       OUT VARCHAR2,
        OSBATTRIBUTABLETO   OUT VARCHAR2,
        OSBCOMPSUSCEP       OUT TT_DAMAGE_TYPE.TIME_OUT%TYPE,
        ODTVERIFICATIONDATE OUT TT_DAMAGE.VERIFICATION_DATE%TYPE,
        OSBVERIFPERSON      OUT VARCHAR2,
        OSBGEOLOCATION      OUT VARCHAR2,
        OSBNEIGHBORHOOD     OUT VARCHAR2,
        OSBADDRESS          OUT VARCHAR2,
        ONUPRIORITY         OUT TT_DAMAGE.PRIORITY%TYPE,
        ORFORDERSASSOCIATED OUT CONSTANTS.TYREFCURSOR,
        ONUERRORCODE        OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );
    
    PROCEDURE UPDATEFAULT
    (
        INUFAULTID       IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID   IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        INUELEMENTID     IN  TT_DAMAGE.ELEMENT_ID%TYPE,
        INUINITASSIGID   IN  IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID  IN  IF_ASSIGNABLE.ID%TYPE,
        IDTINITIALDATE   IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENDDATE IN  TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    );

END TT_BSFAULT;


PACKAGE BODY TT_BSFault
IS
    


























    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO207649';

    
    
    

    
    
    

    
    
    
    













    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    
























    PROCEDURE REGISTERFAULT
    (
        INUFAULTTYPEID   IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        INUELEMENTID     IN  TT_DAMAGE.ELEMENT_ID%TYPE,
        INUINITASSIGID   IN  IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID  IN  IF_ASSIGNABLE.ID%TYPE,
        IDTINITIALDATE   IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENDDATE IN  TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ISBCOMMENT       IN  MO_COMMENT.COMMENT_%TYPE,
        ONUFAULTID       OUT TT_DAMAGE.PACKAGE_ID%TYPE,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);
        
        TT_BOELEMENT.VALREGISTERFAULT(INUFAULTTYPEID,
                                      INUELEMENTID,
                                      INUINITASSIGID,
                                      INUFINALASSIGID,
                                      IDTINITIALDATE,
                                      IDTESTATTENDDATE);

        TT_BOFAULT.PROCESSREGISTERFAULT
        (
            INUFAULTTYPEID,
            INUELEMENTID,
            INUINITASSIGID,
            INUFINALASSIGID,
            IDTINITIALDATE,
            IDTESTATTENDDATE,
            ISBCOMMENT,
            TT_BCCONSTANTS.CSBCLASS_NOT_PROGRAM,
            ONUFAULTID
        );
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END REGISTERFAULT;
    
    
























    PROCEDURE ATTENDFAULT
    (
        INUFAULTID        IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID    IN  TT_DAMAGE.FINAL_DAMAGE_TYPE_ID%TYPE,
        INUCLOSURECAUSEID IN  TT_DAMAGE.DAMAGE_CAUSAL_ID%TYPE,
        IDTINITIALDATE    IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTENDDATE        IN  TT_DAMAGE.END_DATE%TYPE,
        ISBAFFECTEDELEMS  IN  VARCHAR2,
        ONUERRORCODE      OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE   OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        TBAFFECTEDELEMS TT_BOELEMENT.TYTBELEMENTS; 
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);

        
        TT_BOELEMENT.VALATTENDFAULT(INUFAULTID,
                                    INUFAULTTYPEID,
                                    INUCLOSURECAUSEID,
                                    IDTINITIALDATE,
                                    IDTENDDATE);
        
        TT_BOELEMENT.EXTELEMENTS(ISBAFFECTEDELEMS,
                                 TBAFFECTEDELEMS);
        
        TT_BOELEMENT.ATTENDFAULT(INUFAULTID,
                                 INUFAULTTYPEID,
                                 INUCLOSURECAUSEID,
                                 IDTINITIALDATE,
                                 IDTENDDATE,
                                 TBAFFECTEDELEMS);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END ATTENDFAULT;
    
    
















































    PROCEDURE GETFAULT
    (
        INUFAULTID          IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        OSBSTATUS           OUT VARCHAR2,
        OSBFAULTTYPE        OUT VARCHAR2,
        OSBCAUSAL           OUT VARCHAR2,
        ODTREGISTERDATE     OUT MO_PACKAGES.REQUEST_DATE%TYPE,
        ODTFIRSTINCABSORBED OUT TT_DAMAGE.DAMAGE_ABSOR_DATE%TYPE,
        ODTESTATTENDDATE    OUT TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ODTATTENTIONDATE    OUT MO_PACKAGES.ATTENTION_DATE%TYPE,
        ODTOUTAGEINIT       OUT TT_DAMAGE.INITIAL_DATE%TYPE,
        ODTOUTAGEEND        OUT TT_DAMAGE.END_DATE%TYPE,
        OSBELEMENTCODE      OUT IF_NODE.CODE%TYPE,
        OSBELEMENTTYPE      OUT VARCHAR2,
        OSBELEMENTCLASS     OUT VARCHAR2,
        OSBCOMPENSATE       OUT VARCHAR2,
        OSBATTRIBUTABLETO   OUT VARCHAR2,
        OSBCOMPSUSCEP       OUT TT_DAMAGE_TYPE.TIME_OUT%TYPE,
        ODTVERIFICATIONDATE OUT TT_DAMAGE.VERIFICATION_DATE%TYPE,
        OSBVERIFPERSON      OUT VARCHAR2,
        OSBGEOLOCATION      OUT VARCHAR2,
        OSBNEIGHBORHOOD     OUT VARCHAR2,
        OSBADDRESS          OUT VARCHAR2,
        ONUPRIORITY         OUT TT_DAMAGE.PRIORITY%TYPE,
        ORFORDERSASSOCIATED OUT CONSTANTS.TYREFCURSOR,
        ONUERRORCODE        OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);

        TT_BOFAULT.GETFAULT(INUFAULTID,
                            OSBSTATUS,
                            OSBFAULTTYPE,
                            OSBCAUSAL,
                            ODTREGISTERDATE,
                            ODTFIRSTINCABSORBED,
                            ODTESTATTENDDATE,
                            ODTATTENTIONDATE,
                            ODTOUTAGEINIT,
                            ODTOUTAGEEND,
                            OSBELEMENTCODE,
                            OSBELEMENTTYPE,
                            OSBELEMENTCLASS,
                            OSBCOMPENSATE,
                            OSBATTRIBUTABLETO,
                            OSBCOMPSUSCEP,
                            ODTVERIFICATIONDATE,
                            OSBVERIFPERSON,
                            OSBGEOLOCATION,
                            OSBNEIGHBORHOOD,
                            OSBADDRESS,
                            ONUPRIORITY,
                            ORFORDERSASSOCIATED);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END GETFAULT;
    
    























    PROCEDURE UPDATEFAULT
    (
        INUFAULTID       IN  TT_DAMAGE.PACKAGE_ID%TYPE,
        INUFAULTTYPEID   IN  TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE,
        INUELEMENTID     IN  TT_DAMAGE.ELEMENT_ID%TYPE,
        INUINITASSIGID   IN  IF_ASSIGNABLE.ID%TYPE,
        INUFINALASSIGID  IN  IF_ASSIGNABLE.ID%TYPE,
        IDTINITIALDATE   IN  TT_DAMAGE.INITIAL_DATE%TYPE,
        IDTESTATTENDDATE IN  TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE,
        ONUERRORCODE     OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE  OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE,
                                        OSBERRORMESSAGE);

        
        TT_BOELEMENT.VALUPDATEFAULT(INUFAULTID,
                                    INUFAULTTYPEID,
                                    IDTINITIALDATE,
                                    INUELEMENTID);

        
        TT_BOFAULT.UPDATEFAULT(INUFAULTID,
                               IDTINITIALDATE,
                               IDTESTATTENDDATE,
                               INUFAULTTYPEID,
                               INUELEMENTID,
                               INUINITASSIGID ,
                               INUFINALASSIGID);
                                    
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE,
                            OSBERRORMESSAGE);
    END UPDATEFAULT;
    
END TT_BSFAULT;