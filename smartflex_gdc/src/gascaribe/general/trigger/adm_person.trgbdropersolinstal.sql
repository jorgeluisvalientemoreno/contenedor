CREATE OR REPLACE TRIGGER ADM_PERSON.trgbdrOperSolInstal
BEFORE DELETE ON so_operative_solution
REFERENCING old AS old new AS new
FOR EACH ROW

/*
    Propiedad intelectual de OPEN International (c).

    Trigger     : trgbdrOperSolInstal
    Descripcion : Controla el borrado de las Soluciones Operativas registradas.
                  No es permitido eliminar registros de Soluciones Operativas.

    ---------------------------------------------------------------------------
    RESTRICCIÿN: Este código no debe usar ningún objeto del aplicativo de Open.
    ---------------------------------------------------------------------------

    Autor         Juan Carlos Castro Prado
    Fecha   	  27-Sep-2017

    Historia de Modificaciones
    Fecha   ID Entrega
    Descripcion

    27-Sep-2017 jcastroSAO414280
    Creación. Open Cali.
*/

BEGIN
--{
    -- Registra evento en el Log de Errores
    SO_BoErrors.RegisMessageError ('Borrando el registro de Solución Operativa. Id SO: ' ||
                                   :old.operative_solution_id, FALSE);

    -- Controla el borrado no permitido de registros
    raise_application_error (-20100, 'trgbdrOperSolInstal: No se permite eliminar registros de ' ||
                                     'Soluciones Operativas instaladas.');
--}
END trgbdrOperSolInstal;
/
