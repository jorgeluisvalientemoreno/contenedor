CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBILDCI_TRSOITEM ------------ se debe cambiar el nombre porque ya es también al actualizar
BEFORE INSERT OR UPDATE OR DELETE ON ldci_trsoitem
/*
    Propiedad intelectual de Gases de Occidente

    Trigger     : ldc_trgbildci_trsoitem

    Descripcion : Trigger para calcular el valor de la devolución
                  BEFORE INSERT.

    Autor      : Carlos Alberto Ramírez
    Fecha      : 28/07/2014

    Historia de Modificaciones
    Fecha   ID Entrega
    Modificacion

    12/12/2014 carlosr.arqs
    Se cambia para que valide sólo si las modificaciones vienen desde las formas

    28/07/2014  carlosr.arqs
    Creacion
*/
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;---------------
    -- Variables --
    ---------------
    sbErrMsg    ge_error_log.description%type;
    --nuErrCode   number;

    CURSOR cuSolicitudMatAso
    IS
        SELECT  SOLI.TRSMVTOT, Itemsol.TSITCANT, DEVO.TRSMDORE
        FROM    LDCI_TRANSOMA DEVO, ldci_trsoitem itemSol, ldci_transoma SOLI
        WHERE   DEVO.TRSMCODI = :new.tsitsoma
        AND     SOLI.TRSMCODI = DEVO.TRSMDORE
        AND     ITEMSOL.TSITSOMA =  SOLI.TRSMCODI
        AND     itemsol.TSITITEM = :NEW.TSITITEM;

    CURSOR cuGetRelatedDocument
    IS
        SELECT  devo.trsmdore, devo.trsmdsre
        FROM    LDCI_TRANSOMA DEVO
        WHERE   devo.trsmcodi = :new.tsitsoma;

    CURSOR cuGetItemsQuant( nuDore number)
    IS
        SELECT COUNT(1) CANTIDAD FROM LDCI_TRSOITEM
        WHERE TSITSOMA = nuDore
        AND   TSITITEM = :NEW.TSITITEM;

    CURSOR cuGetProgram
    IS
        SELECT  trsmprog,trsmacti,trsmtipo
        FROM    ldci_transoma
        WHERE   trsmcodi = :old.tsitsoma;

    CURSOR cuGetProgram_inser
    IS
        SELECT  trsmprog,trsmacti,trsmtipo
        FROM    ldci_transoma
        WHERE   trsmcodi = :new.tsitsoma;

    nuValoSol   number;
    nuQuantity  number;
    nuIdDocuRe  number; -- documento SAP
    nuValoUni   number;
    --nuValoTot   number;
    NURELATEDDOCUMENT NUMBER;
    NUITEMRELATED     NUMBER;


    sbProgram   varchar2(100);
    sbState     varchar2(100);
    nuTipo      number;  -- 1 - Solicitud 2 - Devolución

    --sbProgram   varchar2(100);
BEGIN
    pkErrors.PUSH('ldc_trgbildci_trsoitem');

    if (inserting) then

        open  cuGetProgram_inser;
        fetch cuGetProgram_inser INTO sbProgram,sbState,nuTipo;
        close cuGetProgram_inser;
    else

        open  cuGetProgram;
        fetch cuGetProgram INTO sbProgram,sbState,nuTipo;
        close cuGetProgram;

    end if;
    -- Obtiene el programa
    sbProgram := ut_session.getmodule();

    --if((updating OR deleting) AND ((nvl(sbProgram,'sbProgram') <> 'WS_MOVIMIENTO_MATERIAL_T') AND sbState = 'S')) then
    if((updating OR deleting OR inserting) AND ((upper(sbProgram) in ('LDCISOMA','LDCIDEMA')) AND sbState = 'S')) then
        Errors.SetError
            (
                2741,
                'El registro ya fue procesado, no puede actualizar los datos'
            );
            raise ex.controlled_error;
    end if;

    if(updating OR inserting) then

        if (cuSolicitudMatAso%isopen) then
            close cuSolicitudMatAso;
        end if;

        open cuSolicitudMatAso;
        fetch cuSolicitudMatAso INTO nuValoSol,nuQuantity,nuIdDocuRe;
        close cuSolicitudMatAso;

        open  cuGetRelatedDocument;
        fetch cuGetRelatedDocument into nuRelatedDocument,nuIdDocuRe;
        close cuGetRelatedDocument;

        open  cuGetItemsQuant(nuRelatedDocument);
        fetch cuGetItemsQuant into nuItemRelated;
        close cuGetItemsQuant;

        if(nuTipo = 2 and nuItemRelated = 0) then --
            Errors.SetError
                (
                    2741,
                    'El item no está asociado al documento SAP relacionado: '||nuIdDocuRe
                );
                raise ex.controlled_error;
         end if;

        if(nuQuantity = 0 OR nuQuantity IS null) then
            :new.tsitcude := -1;
        else
            nuValoUni :=  nuValoSol/nuQuantity;
            :new.tsitcude := nuValoUni*:new.tsitcant;
        end if;

        if(nuQuantity < :new.tsitcant) then
            Errors.SetError
                (
                    2741,
                    'La cantidad a devolver debe ser menor o igual a la solicitada'
                );
                raise ex.controlled_error;
        end if;

        if(:new.tsititem IS null) then -- Item/Material
            Errors.SetError
                (
                    2741,
                    'El campo Material/Item no puede ser nulo'
                );
                raise ex.controlled_error;
        end if;

        if(:new.tsitmdma IS null AND nuTipo = 2) then -- Item/Material
            Errors.SetError
                (
                    2741,
                    'El campo Motivo de Devolución de Material no puede ser nulo'
                );
                raise ex.controlled_error;
        end if;

        if(:new.tsitcant IS null) then -- Cantidad Item
            Errors.SetError
                (
                    2741,
                    'El campo Cantidad Item no puede ser nulo'
                );
                raise ex.controlled_error;
        end if;

        if(:new.tsitcant < 1) then -- Cantidad Item
            Errors.SetError
                (
                    2741,
                    'El campo Cantidad Item no puede ser 0 o Negativo'
                );
                raise ex.controlled_error;
        end if;
    end if;
    --:new.tsittrsm := ge_bosequence.fnugetnextvalsequence('ldci_trsoitem','SEQ_LDCI_TRSOITEM');

    pkErrors.Pop;
EXCEPTION
    when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;

    when OTHERS then
        --pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);

END LDC_TRGBILDCI_TRSOITEM;
/
