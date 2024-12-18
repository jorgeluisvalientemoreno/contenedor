CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALIDACONTCONT
BEFORE INSERT OR UPDATE OF COD_CONTRATO ON LDC_CONFIGURACIONAIU
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
/**************************************************************************

      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 07-03-2018
      Ticket      : 200-1597
      Descripcion : TRIGGER que valida contrato relacioando al contratista


      Parametros Entrada

      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/
DECLARE
  --TICKET 200-1597 LJLB -- se consulta si el contrato pertenece al contratista
  CURSOR cuContContra IS
  SELECT 'X'
  FROM GE_CONTRATO
  WHERE id_contrato = :NEW.COD_CONTRATO
    AND id_contratista = :NEW.CONTRATISTA;

  sberror VARCHAR2(4000); --TICKET 200-1597 LJLB -- se almacena mensaje de error
  nuErrorCode NUMBER := 2; --TICKET 200-1597 LJLB -- se almacena codigo de error

  sbDato VARCHAR2(1); --TICKET 200-1597 LJLB -- se almacena dato del cursor

  erContratista EXCEPTION; --TICKET 200-1597 LJLB -- se alamcena excepcion si el contrato no esta relacioando al contratista
BEGIN
  --TICKET 200-1597 LJLB -- se valida contrato
  IF (:NEW.COD_CONTRATO <> :OLD.COD_CONTRATO OR :OLD.COD_CONTRATO is null) AND :NEW.CONTRATISTA IS NOT NULL THEN
      OPEN cuContContra;
      FETCH cuContContra INTO sbdato;
      IF cuContContra%NOTFOUND THEN
        sberror := 'Contrato ['||:new.COD_CONTRATO||'] no pertenece al contratista['||:new.CONTRATISTA||'], por favor valide';
        RAISE erContratista;
      END IF;
      CLOSE cuContContra;
  END IF;
EXCEPTION
  WHEN erContratista THEN
       Errors.SetError(nuErrorCode);
       Errors.SETMESSAGE(sberror);
       RAISE ex.CONTROLLED_ERROR;

   WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
        Errors.setError;
        sberror :='Error no controlado en LDC_TRGVALIDACONTCONT'|| sqlerrm;
        Errors.SETMESSAGE(sberror);
        RAISE EX.CONTROLLED_ERROR;

END LDC_TRGVALIDACONTCONT;
/
