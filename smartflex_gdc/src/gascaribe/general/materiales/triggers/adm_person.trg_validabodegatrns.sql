CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_VALIDABODEGATRNS
AFTER UPDATE OR  INSERT ON ldci_transoma
 REFERENCING OLD AS OLD NEW AS NEW
 /*
    Propiedad intelectual de HORBATH TECHNOLOGIES

    Trigger   : TRG_VALIDABODEGATRNS

    Descripcion : Trigger verificar si las bodegas o unidades operativas se encuentran en estado inhabilitado
                  AFTER INSERT OR UPDATE.

    Autor    : Josh Brito
    Fecha    : 15/05/2017

    Historia de Modificaciones
    Fecha ID Entrega : OSS_CONST_JGBA_2001068_1
    Modificacion


    Creacion
*/
  FOR EACH ROW
  DECLARE
    sbNombreUnidad OR_OPERATING_UNIT.NAME%type;
    sberror VARCHAR2(4000);
    nuErrorCode NUMBER := 2;  --Ticket 200-1090  JGBA -- Se almacena codigo de error

    CURSOR cuValidaEstado (nuUnidadOperativa ldci_transoma.TRSMUNOP%TYPE ) IS
    SELECT OPERATING_UNIT_ID||'-'||NAME
    FROM OR_OPERATING_UNIT
    WHERE OPER_UNIT_STATUS_ID =  DALD_PARAMETER.fnuGetNumeric_Value('LDC_STATUS_BODEGA')
      AND OPERATING_UNIT_ID = nuUnidadOperativa;

       CURSOR cuGetRelatedDoc( nuRelatedDoc    in number)
    IS
        SELECT  trsmcont contrat, trsmprov Centro, trsmunop UniOp, trsmcodi docure,
                trsmofve oficina
        FROM    ldci_transoma dema
        WHERE   dema.trsmcodi = nuRelatedDoc
        AND     dema.trsmcodi <> :new.trsmcodi;


   erBodega EXCEPTION;

  BEGIN
 --bodega origen
      OPEN cuValidaEstado(:NEW.TRSMPROV);
      FETCH cuValidaEstado INTO sbNombreUnidad;
      IF cuValidaEstado%FOUND THEN
         sberror := 'La bodega origen ['|| sbNombreUnidad||', se encuentra en  estado inhabilitado';
         RAISE erBodega;
      END IF;
      CLOSE cuValidaEstado;
      --bodega destino
      OPEN cuValidaEstado(:NEW.TRSMUNOP);
      FETCH cuValidaEstado INTO sbNombreUnidad;
      IF cuValidaEstado%FOUND THEN
         sberror := 'La bodega destino ['|| sbNombreUnidad||', se encuentra en  estado inhabilitado';
         RAISE erBodega;
      END IF;
      CLOSE cuValidaEstado;



  EXCEPTION
    WHEN erBodega THEN
       Errors.SetError(nuErrorCode);
       Errors.SETMESSAGE(sberror);
       RAISE ex.CONTROLLED_ERROR;

   WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
        Errors.setError;
    sberror := sqlerrm;
        Errors.SETMESSAGE(sberror);
        RAISE EX.CONTROLLED_ERROR;
  END;
/
