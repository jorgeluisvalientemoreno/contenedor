CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_VALIDABODEGA
BEFORE UPDATE OR  INSERT ON GE_ITEMS_DOCUMENTO
  REFERENCING OLD AS OLD NEW AS NEW
  /*
    Propiedad intelectual de HORBATH TECHNOLOGIES

    Trigger   : TRG_VALIDABODEGA

    Descripcion : Trigger verificar si las bodegas o unidades operativas se encuentran en estado inhabilitado
                  y que pertenezcan a un tipo de documento Parametrizado
                  BEFORE INSERT OR UPDATE.

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
    nuErrorCode NUMBER := 2;

    CURSOR cuValidaEstado (nuUnidadOperativa GE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID%TYPE ) IS
    SELECT OPERATING_UNIT_ID||'-'||NAME
    FROM OR_OPERATING_UNIT
    WHERE OPER_UNIT_STATUS_ID =  DALD_PARAMETER.fnuGetNumeric_Value('LDC_STATUS_BODEGA')
      AND OPERATING_UNIT_ID = nuUnidadOperativa;


   erBodega EXCEPTION;

  BEGIN

    IF   instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TYPE_DOCSBODEGA'), to_char(:NEW.DOCUMENT_TYPE_ID) ) > 0  THEN
      --bodega origen
      OPEN cuValidaEstado(:NEW.OPERATING_UNIT_ID);
      FETCH cuValidaEstado INTO sbNombreUnidad;
      IF cuValidaEstado%FOUND THEN
         sberror := 'La bodega ['|| sbNombreUnidad||', se encuentra en  estado inhabilitado';
         RAISE erBodega;
      END IF;
      CLOSE cuValidaEstado;
      --bodega destino
      OPEN cuValidaEstado(:NEW.DESTINO_OPER_UNI_ID);
      FETCH cuValidaEstado INTO sbNombreUnidad;
      IF cuValidaEstado%FOUND THEN
         sberror := 'La bodega ['|| sbNombreUnidad||', se encuentra en  estado inhabilitado';
         RAISE erBodega;
      END IF;
      CLOSE cuValidaEstado;


    END IF;


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
