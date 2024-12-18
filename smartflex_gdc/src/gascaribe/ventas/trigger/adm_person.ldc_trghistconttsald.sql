CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGHISTCONTTSALD 
BEFORE DELETE OR INSERT OR UPDATE ON LDC_CONTTSFA 
REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW 
DECLARE
  sbExiste VARCHAR2(1);
  sbOperacion VARCHAR2(2);
  
  CURSOR cuValidaxisVent IS
  SELECT 'X'
  FROM mo_packages
  WHERE address_id = :NEW.DIREPRHI;
  
  CURSOR cuExisteContrPadr IS
  SELECT 'X'
  FROM SUSCRIPC
  WHERE susccodi = :NEW.CONTPADRE;
  
  CURSOR cuExisteDireccion IS
  SELECT 'X'
  FROM ab_address
  WHERE address_id = :NEW.DIREPRHI;
BEGIN
  
  IF INSERTING THEN
     sbOperacion := 'I';     
  ELSIF UPDATING THEN
     sbOperacion := 'U';   
  ELSE
      sbOperacion := 'D'; 
  end if;
  
  IF sbOperacion <> 'I' AND NVL(:NEW.ESTADO,'N') = NVL(:OLD.ESTADO,'N') THEN
     OPEN cuValidaxisVent;
     FETCH cuValidaxisVent INTO sbExiste;
     CLOSE cuValidaxisVent;
     
     IF sbExiste IS NOT NULL THEN
        ERRORS.SETERROR(2741, 'No se puede realizacion accion sobre el registro, porque tiene ventas asociadas');
        raise EX.CONTROLLED_ERROR;
     END IF;     
  END IF;
  
  IF sbOperacion <> 'D' THEN
    OPEN cuExisteContrPadr;
    FETCH cuExisteContrPadr INTO sbExiste;
    IF cuExisteContrPadr%NOTFOUND THEN
       CLOSE cuExisteContrPadr;
       ERRORS.SETERROR(2741, 'Contrato padre ['||:NEW.CONTPADRE||'] no existe');
       raise EX.CONTROLLED_ERROR;
    END IF;
    CLOSE cuExisteContrPadr;
      
    OPEN cuExisteDireccion;
    FETCH cuExisteDireccion INTO sbExiste;
    IF cuExisteDireccion%NOTFOUND THEN
       CLOSE cuExisteDireccion;
       ERRORS.SETERROR(2741, 'Direccion a trasladar saldo ['||:NEW.DIREPRHI||'] no existe');
       raise EX.CONTROLLED_ERROR;
    END IF;
    CLOSE cuExisteDireccion;
	  
	:NEW.FECHULMO := SYSDATE;
    :NEW.USUARIO :=  user;
    :NEW.TERMINAL := userenv('TERMINAL');
  END IF;
  
  INSERT INTO LDC_CONTTSFAHIST
  (
    CONTPADRE,
    DIREPRHI,
    OPERACION,
    FECHREGI,
    USUARIO,
    TERMINAL
  )
  VALUES
  (
    NVL(:NEW.CONTPADRE, :OLD.CONTPADRE),
    NVL(:NEW.DIREPRHI,:OLD.DIREPRHI),
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