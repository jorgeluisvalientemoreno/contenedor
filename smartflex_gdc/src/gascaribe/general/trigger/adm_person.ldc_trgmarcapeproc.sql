CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGMARCAPEPROC
BEFORE INSERT OR UPDATE ON PROCEJEC FOR EACH ROW

 /**************************************************************************
  Proceso     : LDC_TRGMARCAPEPROC
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : trigger para marcar periodos que terminaron FGCC

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR        DESCRIPCION
  26/08/2020   OLSOFTWARE   CA 502 se coloca proceso para insert en la tabla
                            LDC_PERIPRPL
  21/10/2024   jpinedc      OSF-3450: Se migra a ADM_PERSON
 ***************************************************************************/

    -- Se lanzara despues de cada fila actualizada
DECLARE
  CURSOR cuExiste IS
  SELECT 'X'
  FROM LDC_PEFAGEPTT
  WHERE PEGPPERI = :NEW.PREJCOPE
    AND PEGPPROC = :NEW.PREJPROG;

  CURSOR cugetCiclo IS
  SELECT pefacicl
  FROM perifact
  WHERE pefacodi = :NEW.PREJCOPE;

  sbdatos VARCHAR2(1);
  nuCiclo NUMBER;
  --INICIA CA 312
  CURSOR cuExistePePl IS
  SELECT 'X'
  FROM LDC_PERIPRPL
  WHERE PEPPPERI = :NEW.PREJCOPE
    AND PEPPPROC = :NEW.PREJPROG;


  --FIN CA 312
BEGIN
  IF FBLAPLICAENTREGAXCASO('0000415') THEN
    IF (:NEW.PREJESPR = 'T' AND :NEW.PREJPROG IN ('FGCC')) THEN
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
             :NEW.PREJCOPE, nuCiclo, sysdate,'N', :NEW.PREJPROG
            );
        END IF;
    END IF;
  END IF;
  --inicia ca 512
  IF FBLAPLICAENTREGAXCASO('0000312') THEN
     OPEN cuExistePePl;
     FETCH cuExistePePl INTO sbdatos;
     CLOSE cuExistePePl;

      IF sbdatos IS NULL THEN
          OPEN cugetCiclo;
          FETCH cugetCiclo INTO nuCiclo;
          CLOSE cugetCiclo;

         INSERT INTO LDC_PERIPRPL
          (
            PEPPPERI, PEPPCICL, PEPPFERE, PEPPFLAG, PEPPPROC
          )
          VALUES
          (
           :NEW.PREJCOPE, nuCiclo, sysdate,'N', :NEW.PREJPROG
          );
      END IF;
  END IF;
  --fin ca 512
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
      RAISE EX.CONTROLLED_ERROR;
 WHEN OTHERS THEN
   ERRORS.seterror;
   RAISE EX.CONTROLLED_ERROR;
END;
/
