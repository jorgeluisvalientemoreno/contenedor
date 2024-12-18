CREATE OR REPLACE TRIGGER ADM_PERSON.trgbdrOperSolExecut
BEFORE DELETE ON so_execution_status
REFERENCING old AS old new AS new
FOR EACH ROW

/*
    Propiedad intelectual de OPEN International (c).

    Trigger     : trgbdrOperSolExecut
    Descripcion : Controla el borrado del Log de las Soluciones Operativas ejecutadas.
                  No es permitido eliminar registros de Log de Soluciones Operativas ejecutadas.

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
    SO_BoErrors.RegisMessageError ('Borrando registro del Log del Estado de Ejecución. Id SO: ' ||
                                   :old.operative_solution_id || '. Id Log: ' || :old.execution_status_id, FALSE);

    -- Controla el borrado no permitido de registros
    raise_application_error (-20100, 'trgbdrOperSolExecut: No se permite eliminar registros de ' ||
                                     ' Log del Estado de Ejecución de las Soluciones Operativas.');
--}
END trgbdrOperSolExecut;
/
