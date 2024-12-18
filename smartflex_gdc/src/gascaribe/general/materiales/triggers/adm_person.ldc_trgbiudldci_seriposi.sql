CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBIUDLDCI_SERIPOSI
BEFORE INSERT OR UPDATE OR DELETE ON ldci_seriposi
/*
    Propiedad intelectual de Gases de Occidente

    Trigger 	: LDC_TRGBIUDldci_seriposi

    Descripcion	: Trigger verificar que los que los códigos de las series
                  pertenecan a los items seriados

    Autor	   : Carlos Alberto Ramírez
    Fecha	   : 12/12/2014

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificacion

    12/12/2014 carlosr.arqs
    Creacion
*/
FOR EACH ROW
DECLARE
    ---------------
    -- Variables --
    ---------------
    sbErrMsg    ge_error_log.description%type;   -- ge_items_seriado   ldci_seriposi
    nuErrCode   number;

    -- Obtiene el documento relacionado a una serie
    CURSOR cuGetRelatedDocument
    IS
        SELECT  devo.trsmacti, devo.trsmtipo
        FROM    LDCI_TRANSOMA DEVO
        WHERE   devo.trsmcodi = :new.serisoma;

    CURSOR cuGetRelatedDocDelete
    IS
        SELECT  devo.trsmacti, devo.trsmtipo
        FROM    LDCI_TRANSOMA DEVO
        WHERE   devo.trsmcodi = :old.serisoma;

    -- Obtiene los items asociados a la solicitud
    CURSOR cuGetItems
    IS
        SELECT  items_id
        FROM    ge_items_seriado
        WHERE   serie = :NEW.serinume;

    sbActi          varchar2(5);
    sbActiDel       varchar2(5);
    sbProgram       varchar2(100);
    nuTipo          number;
    nuTipoDel       number;
    nuItemId        number;

BEGIN
    pkErrors.PUSH('LDC_TRGBIUDldci_seriposi');

    -- Obtiene el programa
    sbProgram := ut_session.getmodule();

    open  cuGetRelatedDocument;
    fetch cuGetRelatedDocument INTO sbActi,nutipo;
    close cuGetRelatedDocument;

    open  cuGetRelatedDocDelete;
    fetch cuGetRelatedDocDelete INTO sbActiDel,nuTipoDel;
    close cuGetRelatedDocDelete;

    IF (upper(sbProgram) in ('LDCISOMA','LDCIDEMA')) THEN

        if((inserting OR updating) AND nutipo = 2) then

            -- Si está procesado genera error
            if(sbActi = 'S') then
                Errors.SetError
                (
                    2741,
                    'El registro ya fue procesado, no puede actualizar los datos'
                );
                raise ex.controlled_error;
            end if;

            open  cuGetItems;
            fetch cuGetItems INTO nuItemID;
            close cuGetItems;

            if(nvl(nuItemID,-9999999) <> :new.seritsit) then
                Errors.SetError
                (
                    2741,
                    'La serie no pertenece al item que intenta procesar'
                );
                raise ex.controlled_error;
            end if;
        end if;

        if(deleting AND sbActiDel = 'S' AND nutipoDel = 2)then
            Errors.SetError
                (
                    2741,
                    'El registro ya fue procesado, no puede Borrar los datos'
                );
            raise ex.controlled_error;
        end if;

    END if;
        pkErrors.Pop;


EXCEPTION
    when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;

    when OTHERS then
    	pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END LDC_TRGBIUDLDCI_SERIPOSI;
/
