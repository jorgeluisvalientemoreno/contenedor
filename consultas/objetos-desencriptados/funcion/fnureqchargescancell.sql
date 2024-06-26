CREATE OR REPLACE FUNCTION FNUREQCHARGESCANCELL( INUPACKAGE IN MO_PACKAGES.PACKAGE_ID%TYPE )
 RETURN NUMBER
 IS
   SBERRMSG GE_ERROR_LOG.DESCRIPTION%TYPE;
   NURESPONSE NUMBER;
 BEGIN
   PKERRORS.PUSH( 'fnuReqChargesCancell' );
   FA_BOREQCHARGESCANCELL.CHARGESCANCELLBYPACK( INUPACKAGE, NURESPONSE );
   PKERRORS.POP;
   RETURN NURESPONSE;
 EXCEPTION
   WHEN OTHERS THEN
      PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
      PKERRORS.POP;
      RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
END FNUREQCHARGESCANCELL;
/


