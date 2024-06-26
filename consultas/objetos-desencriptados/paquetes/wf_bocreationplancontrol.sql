
CREATE OR REPLACE PACKAGE BODY WF_BOCREATIONPLANCONTROL IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO87246';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE BUILDEREXECUTORJ( ISBEXTERNALID IN VARCHAR2, INUENTITYID IN NUMBER, INUINTERFACEID IN NUMBER, ONUSTDTIME OUT NUMBER, ONUEXECMAXTIME OUT NUMBER, ONUPLANID OUT NUMBER, ONUUNITTYPEID OUT NUMBER, ONUERRORCODE OUT NUMBER, OSBERRORMSG OUT VARCHAR2 )
    IS
    LANGUAGE JAVA NAME 'os.wf.comm.CreatePlanStatic.create(java.lang.String, int, int, int[], int[], int[], int[], int[],java.lang.String[])';
   PROCEDURE BUILDEREXECUTOR( INUEXTERNALID IN WF_INSTANCE.EXTERNAL_ID%TYPE, INUENTITYID IN GE_ENTITY.ENTITY_ID%TYPE, INUINTERFACEID IN WF_INTERFACE_CONFIG.INTERFACE_CONFIG_ID%TYPE, ONUEXECMAXTIME OUT NUMBER, ONUSTDTIME OUT NUMBER, ONUERRORCODE OUT NUMBER, OSBERRORMESSAGE OUT VARCHAR2 )
    IS
      NUERRORCODEPROCESS NUMBER;
      SBERRORMESSAGEPROCESS VARCHAR2( 2000 );
      NUPLANID NUMBER;
      NUUNITTYPEID NUMBER;
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := NULL;
      BUILDEREXECUTORJ( INUEXTERNALID, INUENTITYID, INUINTERFACEID, ONUSTDTIME, ONUEXECMAXTIME, NUPLANID, NUUNITTYPEID, NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
      UT_JAVA.VALIDATEERROR( NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END BUILDEREXECUTOR;
   PROCEDURE BUILDEREXECUTOR( INUEXTERNALID IN WF_INSTANCE.EXTERNAL_ID%TYPE, INUENTITYID IN GE_ENTITY.ENTITY_ID%TYPE, INUINTERFACEID IN WF_INTERFACE_CONFIG.INTERFACE_CONFIG_ID%TYPE, ONUEXECMAXTIME OUT NUMBER, ONUSTDTIME OUT NUMBER, ONUPLANID OUT NUMBER, ONUERRORCODE OUT NUMBER, OSBERRORMESSAGE OUT VARCHAR2 )
    IS
      NUERRORCODEPROCESS NUMBER;
      SBERRORMESSAGEPROCESS VARCHAR2( 2000 );
      NUUNITTYPEID NUMBER;
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := NULL;
      BUILDEREXECUTORJ( INUEXTERNALID, INUENTITYID, INUINTERFACEID, ONUSTDTIME, ONUEXECMAXTIME, ONUPLANID, NUUNITTYPEID, NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
      UT_JAVA.VALIDATEERROR( NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END BUILDEREXECUTOR;
   PROCEDURE BUILDEREXECUTOR( INUEXTERNALID IN WF_INSTANCE.EXTERNAL_ID%TYPE, INUENTITYID IN GE_ENTITY.ENTITY_ID%TYPE, INUINTERFACEID IN WF_INTERFACE_CONFIG.INTERFACE_CONFIG_ID%TYPE, ONUEXECMAXTIME OUT NUMBER, ONUSTDTIME OUT NUMBER, ONUPLANID OUT NUMBER, ONUUNITTYPEID OUT NUMBER, ONUERRORCODE OUT NUMBER, OSBERRORMESSAGE OUT VARCHAR2 )
    IS
      NUERRORCODEPROCESS NUMBER;
      SBERRORMESSAGEPROCESS VARCHAR2( 2000 );
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := NULL;
      BUILDEREXECUTORJ( INUEXTERNALID, INUENTITYID, INUINTERFACEID, ONUSTDTIME, ONUEXECMAXTIME, ONUPLANID, ONUUNITTYPEID, NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
      UT_JAVA.VALIDATEERROR( NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END BUILDEREXECUTOR;
   PROCEDURE CREATESUBPLANJ( INUUNITTYPEID IN NUMBER, INUPLANID IN NUMBER, INUPARENTID IN NUMBER, ISBEXTERNALID IN VARCHAR2, INUENTITYID IN NUMBER, ONUERRORCODE OUT NOCOPY NUMBER, OSBERRORMESSAGE OUT NOCOPY VARCHAR2 )
    IS
    LANGUAGE JAVA NAME 'os.wf.comm.CreatePlanStatic.createSubPlan(int, int, int, java.lang.String, int, int[], java.lang.String[])';
   PROCEDURE CREATESUBPLANJESP( INUUNITTYPEID IN NUMBER, INUPLANID IN NUMBER, INUPARENTID IN NUMBER, ISBEXTERNALID IN VARCHAR2, INUENTITYID IN NUMBER, INUCONSEC IN NUMBER, INUMIDPOINTX IN NUMBER, INUSTARTINSTANCEID IN NUMBER, INUFINALINSTANCEID IN NUMBER, SBACTIVE IN VARCHAR2, INSTANCECREATEDID OUT NOCOPY NUMBER, ONUERRORCODE OUT NOCOPY NUMBER, OSBERRORMESSAGE OUT NOCOPY VARCHAR2 )
    IS
    LANGUAGE JAVA NAME 'os.wf.comm.CreatePlanStatic.createSubPlan(int,int, int, java.lang.String, int, int, int , int ,int ,  java.lang.String, int[], int[], java.lang.String[])';
   PROCEDURE CREATESUBPLANJSEQ( INUUNITTYPEID IN NUMBER, INUPLANID IN NUMBER, INUPARENTID IN NUMBER, ISBEXTERNALID IN VARCHAR2, INUENTITYID IN NUMBER, INUXPOSITION IN NUMBER, INUYPOSITION IN NUMBER, SBACTIVE IN VARCHAR2, ONUINSTANCECREATID OUT NOCOPY NUMBER, ONUERRORPROCESS OUT NOCOPY NUMBER, OSBERRORMESSPROCESS OUT NOCOPY VARCHAR2 )
    IS
    LANGUAGE JAVA NAME 'os.wf.comm.CreatePlanStatic.createSubPlanSeq(int,int, int, java.lang.String, int, int, int, java.lang.String, int[], int[], java.lang.String[])';
   PROCEDURE CREATESUBPLAN( INUUNITTYPEID IN WF_INSTANCE.UNIT_TYPE_ID%TYPE, INUPLANID IN WF_INSTANCE.PLAN_ID%TYPE, INUPARENTID IN WF_INSTANCE.PARENT_ID%TYPE, ISBEXTERNALID IN WF_INSTANCE.EXTERNAL_ID%TYPE, INUENTITYID IN WF_INSTANCE.ENTITY_ID%TYPE, ONUERRORCODE OUT NOCOPY NUMBER, OSBERRORMESSAGE OUT NOCOPY VARCHAR2 )
    IS
      NUPARENTID WF_INSTANCE.PARENT_ID%TYPE;
      NUERRORCODEPROCESS NUMBER;
      SBERRORMESSAGEPROCESS VARCHAR2( 2000 );
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := NULL;
      NUPARENTID := NVL( INUPARENTID, -1 );
      IF NUPARENTID = -1 THEN
         NUPARENTID := INUPLANID;
      END IF;
      CREATESUBPLANJ( INUUNITTYPEID, INUPLANID, NUPARENTID, ISBEXTERNALID, INUENTITYID, NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
      UT_JAVA.VALIDATEERROR( NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END CREATESUBPLAN;
   PROCEDURE CREATESUBPLANESP( INUUNITTYPEID IN WF_INSTANCE.UNIT_TYPE_ID%TYPE, INUPLANID IN WF_INSTANCE.PLAN_ID%TYPE, INUPARENTID IN WF_INSTANCE.PARENT_ID%TYPE, ISBEXTERNALID IN WF_INSTANCE.EXTERNAL_ID%TYPE, INUENTITYID IN WF_INSTANCE.ENTITY_ID%TYPE, INUCONSEC IN NUMBER, INUMIDPOINTX IN NUMBER, INUSTARTINSTANCEID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUFINALINSTANCEID IN WF_INSTANCE.INSTANCE_ID%TYPE, IBLACTIVE IN BOOLEAN, ONUINSTANCECREATID OUT NOCOPY NUMBER, ONUERRORCODE OUT NOCOPY NUMBER, OSBERRORMESSAGE OUT NOCOPY VARCHAR2 )
    IS
      SBACTIVE VARCHAR( 1 ) := GE_BOCONSTANTS.CSBNO;
      NUPARENTID WF_INSTANCE.PARENT_ID%TYPE;
      NUERRORCODEPROCESS NUMBER;
      SBERRORMESSAGEPROCESS VARCHAR2( 2000 );
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := NULL;
      NUPARENTID := NVL( INUPARENTID, -1 );
      IF NUPARENTID = -1 THEN
         NUPARENTID := INUPLANID;
      END IF;
      IF ( IBLACTIVE ) THEN
         SBACTIVE := GE_BOCONSTANTS.CSBYES;
      END IF;
      CREATESUBPLANJESP( INUUNITTYPEID, INUPLANID, NUPARENTID, ISBEXTERNALID, INUENTITYID, INUCONSEC, INUMIDPOINTX, INUSTARTINSTANCEID, INUFINALINSTANCEID, SBACTIVE, ONUINSTANCECREATID, NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
      UT_JAVA.VALIDATEERROR( NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END CREATESUBPLANESP;
   PROCEDURE CREATESUBPLANSEQ( INUUNITTYPEID IN WF_INSTANCE.UNIT_TYPE_ID%TYPE, INUPLANID IN WF_INSTANCE.PLAN_ID%TYPE, INUPARENTID IN WF_INSTANCE.PARENT_ID%TYPE, ISBEXTERNALID IN WF_INSTANCE.EXTERNAL_ID%TYPE, INUENTITYID IN WF_INSTANCE.ENTITY_ID%TYPE, INUXPOSITION IN NUMBER, INUYPOSITION IN NUMBER, IBLACTIVE IN BOOLEAN, ONUINSTANCECREATID OUT NOCOPY NUMBER, ONUERRORCODE OUT NOCOPY NUMBER, OSBERRORMESSAGE OUT NOCOPY VARCHAR2 )
    IS
      SBACTIVE VARCHAR( 1 ) := GE_BOCONSTANTS.CSBNO;
      NUPARENTID WF_INSTANCE.PARENT_ID%TYPE;
      NUERRORCODEPROCESS GE_MESSAGE.MESSAGE_ID%TYPE;
      SBERRORMESSAGEPROCESS GE_MESSAGE.DESCRIPTION%TYPE;
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := NULL;
      NUPARENTID := NVL( INUPARENTID, -1 );
      IF NUPARENTID = -1 THEN
         NUPARENTID := INUPLANID;
      END IF;
      IF ( IBLACTIVE ) THEN
         SBACTIVE := GE_BOCONSTANTS.CSBYES;
      END IF;
      CREATESUBPLANJSEQ( INUUNITTYPEID, INUPLANID, INUPARENTID, ISBEXTERNALID, INUENTITYID, INUXPOSITION, INUYPOSITION, SBACTIVE, ONUINSTANCECREATID, NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
      UT_JAVA.VALIDATEERROR( NUERRORCODEPROCESS, SBERRORMESSAGEPROCESS );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END CREATESUBPLANSEQ;
END WF_BOCREATIONPLANCONTROL;
/


