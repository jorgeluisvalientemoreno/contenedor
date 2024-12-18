CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGMARCAPERGECU
BEFORE INSERT OR UPDATE ON ESTAPROG FOR EACH ROW

 /**************************************************************************
  Proceso     : LDC_TRGMARCAPEPROC
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : trigger para marcar periodos que terminaron FIDF

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  21/10/2024    jpinedc     OSF-3450: Se migra a ADM_PERSON
 ***************************************************************************/

    -- Se lanzara despues de cada fila actualizada
DECLARE
  CURSOR cuExiste IS
  SELECT PEGPESTA
  FROM LDC_PEFAGEPTT
  WHERE PEGPPERI = :NEW.ESPRPEFA
    AND PEGPPROC = 'FIDF';

  CURSOR cugetCiclo IS
  SELECT pefacicl
  FROM perifact
  WHERE pefacodi = :NEW.ESPRPEFA;

  sbdatos VARCHAR2(1);
  nuCiclo NUMBER;
BEGIN
  IF FBLAPLICAENTREGAXCASO('0000415') THEN
    IF ( INSTR(:NEW.ESPRPROG,'FIDF') > 0 AND :NEW.ESPRPORC = 100 ) THEN
        OPEN cuExiste;
        FETCH cuExiste INTO sbdatos;
        CLOSE cuExiste;

        IF sbdatos IS NULL THEN
            OPEN cugetCiclo;
            FETCH cugetCiclo INTO nuCiclo;
            CLOSE cugetCiclo;

           INSERT INTO LDC_PEFAGEPTT
            (
              PEGPPERI, PEGPCICL, PEGPFERE, PEGPESTA, PEGPPROC
            )
            VALUES
            (
             :NEW.ESPRPEFA, nuCiclo, sysdate,'N', 'FIDF'
            );
		ELSE
		  IF sbdatos <> 'N' THEN
		     UPDATE LDC_PEFAGEPTT SET PEGPESTA = 'N' WHERE PEGPPERI = :NEW.ESPRPEFA AND PEGPPROC = 'FIDF'  ;
		  END IF;
        END IF;
    END IF;
  END IF;
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
      RAISE EX.CONTROLLED_ERROR;
 WHEN OTHERS THEN
   ERRORS.seterror;
   RAISE EX.CONTROLLED_ERROR;
END;
/
