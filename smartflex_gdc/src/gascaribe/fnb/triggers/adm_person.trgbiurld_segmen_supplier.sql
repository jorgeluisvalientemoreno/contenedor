CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_SEGMEN_SUPPLIER
BEFORE INSERT OR UPDATE OF LINE_EQUIVALENCE
ON Ld_Segmen_Supplier
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/*******************************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  trgBiurLd_Segmen_Supplier

Descripcion   : Trigger que valida que el valor de la Equivalencia no quede vacia,
                ya que se controla que el valor de la Equivalencia sea única por
                Proveedor.

Autor         : Juan Carlos Castro Prado
Fecha         : 09-Sep-2013

Historia de Modificaciones
Fecha        IDEntrega          Modificacion

09-Sep-2013  jcastroSAO213549   Creacion.
*******************************************************************************/

BEGIN
--{
    -- Valida que la Equivalencia no quede vacía

    IF (:new.LINE_EQUIVALENCE IS NULL) THEN
    --{
        :new.LINE_EQUIVALENCE := :new.SEGMEN_SUPPLIER_ID;
    --}
    END IF;
--}
END TRGBIURLD_SEGMEN_SUPPLIER;
/
