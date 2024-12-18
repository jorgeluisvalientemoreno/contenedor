CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGHISTCONTANULA 
BEFORE DELETE OR INSERT OR UPDATE ON LDC_CONTANVE 
REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW 
DECLARE
  sbExiste VARCHAR2(1);
  sbOperacion VARCHAR2(2);
  
  CURSOR cuValidaxisVent IS
  SELECT 'X'
  FROM LDC_SOLIANECO
  WHERE CONTRATO = :NEW.CONTANUL;
  
  CURSOR cuExisteContrPadr IS
  SELECT 'X'
  FROM SUSCRIPC
  WHERE susccodi = :NEW.CONTPADRE;
  
  CURSOR cuExisteContrato IS
  SELECT 'X'
  FROM SUSCRIPC
  WHERE susccodi = :NEW.CONTANUL;
BEGIN
  
  IF INSERTING THEN
     sbOperacion := 'I';     
  ELSIF UPDATING THEN
     sbOperacion := 'U';   
  ELSE
      sbOperacion := 'D'; 
  end if;
  
  IF sbOperacion <> 'I' THEN
     OPEN cuValidaxisVent;
     FETCH cuValidaxisVent INTO sbExiste;
     CLOSE cuValidaxisVent;
     
     IF sbExiste IS NOT NULL THEN
        ERRORS.SETERROR(2741, 'No se puede realizacion accion sobre el registro, porque tiene ventas asociadas');
        raise EX.CONTROLLED_ERROR;
     END IF;     
  END IF;
  
  IF sbOperacion <> 'D' THEN
    IF :NEW.CONTPADRE = :NEW.CONTANUL THEN
        ERRORS.SETERROR(2741, 'Los contratos no pueden ser iguales');
        raise EX.CONTROLLED_ERROR;
    ELSE
      OPEN cuExisteContrPadr;
      FETCH cuExisteContrPadr INTO sbExiste;
      IF cuExisteContrPadr%NOTFOUND THEN
         CLOSE cuExisteContrPadr;
         ERRORS.SETERROR(2741, 'Contrato padre ['||:NEW.CONTPADRE||'] no existe');
         raise EX.CONTROLLED_ERROR;
      END IF;
      CLOSE cuExisteContrPadr;
      
      OPEN cuExisteContrato;
      FETCH cuExisteContrato INTO sbExiste;
      IF cuExisteContrato%NOTFOUND THEN
         CLOSE cuExisteContrato;
         ERRORS.SETERROR(2741, 'Contrato anular ['||:NEW.CONTANUL||'] no existe');
         raise EX.CONTROLLED_ERROR;
      END IF;
      CLOSE cuExisteContrato;
	  
	  :NEW.FECHULMO := SYSDATE;
	  :NEW.USUARIO :=  user;
      :NEW.TERMINAL := userenv('TERMINAL');
      
      
    END IF;
  END IF;
  
  INSERT INTO LDC_CONTANVEHIST
  (
    CONTPADRE,
    CONTANUL,
    OPERACION,
    FECHREGI,
    USUARIO,
    TERMINAL
  )
  VALUES
  (
    NVL(:NEW.CONTPADRE, :OLD.CONTPADRE),
    NVL(:NEW.CONTANUL,:OLD.CONTANUL),
    sbOperacion,
    sysdate,
    user,
    userenv('TERMINAL')
  );
  
 EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       raise EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       errors.seterror;
       raise EX.CONTROLLED_ERROR;
END;
/