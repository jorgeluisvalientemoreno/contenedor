CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALPAGCUDE
BEFORE  INSERT ON PAGOS
FOR EACH ROW
 /**************************************************************************
  Proceso     : LDC_TRGVALPAGCUDE
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2020-05-26
  Ticket      : 415
  Descripcion : trigger para validar cupon de descuento

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  21/10/2024    jpinedc     OSF-3450: Se migra a ADM_PERSON
 ***************************************************************************/

    -- Se lanzara despues de cada fila actualizada
DECLARE
  --se valida que pago haya sido de descuento
  CURSOR cuPagodesc IS
  SELECT rowid ID_REG
  FROM LDC_PRODTATT
  WHERE PRTTCUDE = :NEW.pagocupo
    and PRTTGENO = 'N';

   --se valida que pago haya sido de descuento
  CURSOR cuPagoNormal IS
  SELECT rowid ID_REG
  FROM LDC_PRODTATT
  WHERE PRTTCUPR = :NEW.pagocupo
   and PRTTGENO = 'N';


  sbRowid  VARCHAR2(4000);

BEGIN
  IF FBLAPLICAENTREGAXCASO('0000415') THEN

    OPEN cuPagodesc;
    FETCH cuPagodesc INTO sbRowid;
    CLOSE cuPagodesc;

     IF sbRowid IS NOT NULL THEN
       UPDATE LDC_PRODTATT SET PRTTGENO = 'S' WHERE ROWID = sbRowid;
    else
       OPEN cuPagoNormal;
      FETCH cuPagoNormal INTO sbRowid;
      CLOSE cuPagoNormal;

     IF sbRowid IS NOT NULL THEN
         UPDATE LDC_PRODTATT SET PRTTGENO = 'T', PRTTERRO ='USUARIO PAGO CUPON NORMAL' WHERE ROWID = sbRowid;
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
