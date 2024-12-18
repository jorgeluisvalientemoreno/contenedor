CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIRLD_POLICY_TYPE
BEFORE INSERT OR UPDATE ON ld_policy_type
FOR EACH ROW
DECLARE
    sbExeLines ld_parameter.value_chain%type;
BEGIN

    sbExeLines := DALD_PARAMETER.fsbGetValue_Chain('PROD_LINE_EXE');
    if ((:new.is_exq = 'S') AND :new.ammount_cedula > 1) then
        ge_boerrors.seterrorcodeargument
        (
            ld_boconstans.cnuGeneric_Error,
            'La línea de producto seleccionada para el producto es Exequial,
            no se debe permitir la venta de más de una (1) póliza por cédula'
        );
        raise ex.CONTROLLED_ERROR;
    END if;

END;

/
