DECLARE
 onuError  NUMBER;
 osbError  VARCHAR2(1000);
 
BEGIN 
  LDC_PKGESTIONABONDECONS.nuIdReporte :=  LDC_PKGESTIONABONDECONS.fnuCrReportHeader;
  onuError := 0;
  
  LDC_PKGESTIONABONDECONS.prGeneraAbonDiferido (48258605,
                                                 onuError,
                                                 osbError);

  IF onuError <> 0 THEN
    LDC_PKGESTIONABONDECONS.nuConsecutivo := LDC_PKGESTIONABONDECONS.nuConsecutivo  + 1;
    LDC_PKGESTIONABONDECONS.crReportDetail(LDC_PKGESTIONABONDECONS.nuIdReporte,
                   48258605,
                   osbError,
                   'S');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(onuError, osbError);
    LDC_PKGESTIONABONDECONS.nuConsecutivo := LDC_PKGESTIONABONDECONS.nuConsecutivo  + 1;
    LDC_PKGESTIONABONDECONS.crReportDetail(LDC_PKGESTIONABONDECONS.nuIdReporte,
                                          48258605 ,
                                           osbError,
                                           'S');
END;
