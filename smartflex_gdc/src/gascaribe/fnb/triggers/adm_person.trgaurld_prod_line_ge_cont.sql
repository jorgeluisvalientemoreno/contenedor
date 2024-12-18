CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAURLD_PROD_LINE_GE_CONT
AFTER UPDATE ON LD_PROD_LINE_GE_CONT
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/*******************************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       : trgAurLD_PROD_LINE_GE_CONT

Descripcion   : Trigger que valida si ya hay Tipos de Pólizas asociadas a la Línea
                de Producto por Contratista para no permitir modificar datos.

Autor         : Juan Carlos Castro Prado
Fecha         : 21-Ago-2013

Historia de Modificaciones
Fecha        IDEntrega          Modificacion

21-Ago-2013  jcastroSAO214426   Creacion.
*******************************************************************************/

DECLARE
    cnuGeneric_Error  CONSTANT NUMBER := 2741; -- Error generico
    nuCantRegAsoc     NUMBER; -- Cantidad de Registros asociados

BEGIN
--{
    -- Obtiene la cantidad de Tipos de Pólizas asociados a la Línea por Contratista
    SELECT count(*)
    INTO   nuCantRegAsoc
    FROM   ld_policy_type
    WHERE  product_line_id = :old.product_line_id
    AND    contratista_id = :old.contratistas_id;

    -- Valida si hay registros asociados

    IF (nuCantRegAsoc > 0) THEN
    --{
        -- Valida que no se modifique la Línea de Producto

        IF (:old.PRODUCT_LINE_ID != :new.PRODUCT_LINE_ID) THEN
        --{
            Gi_BoErrors.SetErrorCodeArgument
            (
                cnuGeneric_Error,
                'La Línea de Producto no puede ser modificada porque ya hay Tipos de Pólizas asociadas.'
            );
            RAISE ex.controlled_error;
        --}
        END IF;

        -- Valida que no se modifique el Contratista

        IF (:old.CONTRATISTAS_ID < :new.CONTRATISTAS_ID) THEN
        --{
            Gi_BoErrors.SetErrorCodeArgument
            (
                cnuGeneric_Error,
                'El Contratista no puede ser modificado porque ya hay Tipos de Pólizas asociadas.'
            );
            RAISE ex.controlled_error;
        --}
        END IF;
    --}
    END IF;   -- Fin existen Tipos de Polizas asociadas

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
--}
END TRGAURLD_PROD_LINE_GE_CONT;
/
