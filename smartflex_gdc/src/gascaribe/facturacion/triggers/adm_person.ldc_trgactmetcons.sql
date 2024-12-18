CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGACTMETCONS before update of sesucate, sesucicl ON servsusc
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
 WHEN ((NEW.SESUCATE <> OLD.SESUCATE OR NEW.SESUCICL <> OLD.SESUCICL) AND  OLD.SESUSERV = 7014)
DECLARE

  nuCate    LDC_COCMCPCC.COCPCATE%TYPE;
  nuCiclo   servsusc.SESUCICL%TYPE;
  nuMetodo  LDC_COCMCPCC.COCPMVCO%TYPE;

  sbCiclTele   VARCHAR2(1000) := DALD_PARAMETER.fsbGetValue_Chain('LDC_CICLTEME', NULL);
  nuClMedgen   NUMBER := DALD_PARAMETER.fnuGetNumeric_Value('LDC_COCLMEGE', NULL);
  nuClMedTele  NUMBER := DALD_PARAMETER.fnuGetNumeric_Value('LDC_COCLMETELE', NULL);
  sbdatos      VARCHAR2(1);
  sbdatoant     VARCHAR2(1);
  sbEleMedi    ELMESESU.EMSSELME%TYPE;

  CURSOR cuConfiCateCicl IS
  SELECT COCPMVCO
  FROM  LDC_COCMCPCC
  WHERE COCPCATE = nuCate AND
        nuCiclo IN ( SELECT DISTINCT TRIM(regexp_substr(COCPCICL,'[^,]+', 1, LEVEL)) AS ciclo
                     FROM   dual A
                     CONNECT BY regexp_substr(COCPCICL, '[^,]+', 1, LEVEL) IS NOT NULL) ;

  CURSOR cuConfiCambCicl IS
  SELECT 'x'
  FROM  dual
  WHERE  nuCiclo IN ( SELECT DISTINCT TRIM(regexp_substr(sbCiclTele,'[^,]+', 1, LEVEL)) AS ciclo
                     FROM   dual A
                     CONNECT BY regexp_substr(sbCiclTele, '[^,]+', 1, LEVEL) IS NOT NULL) ;

  CURSOR cuEleMedi IS
  SELECT EMSSELME
  FROM ELMESESU
  WHERE EMSSFERE > SYSDATE AND
    EMSSSESU = :NEW.SESUNUSE;

begin

 IF LDC_BOINSOLVENCYECON.gsbFlagValidate = 'N' THEN

 IF :NEW.SESUCATE <>  :OLD.SESUCATE OR :NEW.SESUCICL <> :OLD.SESUCICL THEN

   nuCate := :NEW.SESUCATE;
   nuCiclo := :NEW.SESUCICL;

   OPEN cuConfiCateCicl;
   FETCH cuConfiCateCicl INTO nuMetodo;
   CLOSE cuConfiCateCicl;

   IF nuMetodo IS NOT NULL THEN

     :NEW.SESUMECV := nuMetodo;

   END IF;

 END IF;

  IF :NEW.SESUCICL <>  :OLD.SESUCICL THEN
   nuCiclo := :OLD.SESUCICL;
   OPEN cuConfiCambCicl;
   FETCH cuConfiCambCicl INTO sbdatoant;
   CLOSE cuConfiCambCicl;

   nuCiclo := :NEW.SESUCICL;
   OPEN cuConfiCambCicl;
   FETCH cuConfiCambCicl INTO sbdatos;
   CLOSE cuConfiCambCicl;

   OPEN cuEleMedi;
   FETCH cuEleMedi INTO sbEleMedi;
   CLOSE cuEleMedi;

   IF sbdatoant IS NOT NULL AND sbdatos IS NULL THEN

      UPDATE ELEMMEDI SET ELMECLEM = nuClMedgen
      WHERE ELMEIDEM = sbEleMedi;
   END IF;

   IF sbdatoant IS  NULL AND sbdatos IS NOT NULL THEN
      UPDATE ELEMMEDI SET ELMECLEM = nuClMedTele
      WHERE ELMEIDEM = sbEleMedi;
    END IF;
  END IF;

  END IF;
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20000, 'Error no controlado en LDC_TRGACTMETCONS '||sqlerrm);
end;
/
