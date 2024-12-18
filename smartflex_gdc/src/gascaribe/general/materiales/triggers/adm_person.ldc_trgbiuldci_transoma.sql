CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBIULDCI_TRANSOMA
BEFORE INSERT OR UPDATE OR DELETE ON ldci_transoma
/*
    Propiedad intelectual de Gases de Occidente

    Trigger 	: ldc_trgbiuldci_transoma

    Descripcion	: Trigger verificar que los items que se hacen devolucion, son
                  del mismo tipo que se solicitaron
                  BEFORE INSERT OR UPDATE.

    Autor	   : Carlos Alberto Ramirez
    Fecha	   : 29/07/2014

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificacion

    25/09/2015 Mmejia Ara.8358 Se modifica el trigger para validar el motivo de venta
                               cuando tenga validacino de order debe pedir como campo
                               requerido el codigo de la orden. Este  valor de Y o N  se
                               configura desde LDCIMOTIPEDI.
    11/03/2015 carlosr.arqs
    Se quitan las validaciones de los campos(Codigo del contratista,Centro Logistico,
        Unidad Operativa,Documento Relacionado, Oficina de Venta) en la devolucion
    Los campos que se quitan se insertan desde la solicitud a devolver.

    12/12/2014 carlosr.arqs
    Se cambia para que valide solo si las modificaciones vienen desde las formas

    25/03/2020  dsaltarin     200-2321: Si el cambio aplica y se esta actualizando no se cambia el estado a 1

    29/07/2014  carlosr.arqs
    Creacion
*/
FOR EACH ROW
DECLARE
    PRAGMA Autonomous_transaction;
    ---------------
    -- Variables --
    ---------------
    sbErrMsg    ge_error_log.description%type;   -- ge_items_seriado   ldci_seriposi
    nuErrCode   number;

    CURSOR cuSerieItems
    IS
        SELECT  count(1)
        FROM    ldci_seriposi serie ,ldci_trsoitem item
        WHERE   serie.serisoma = :new.trsmcodi
        AND     serie.serisoma = item.tsitsoma
        AND     serie.seritsit = tsititem
        AND     exists
            (
            SELECT  1
            FROM    ge_items_seriado itser
            WHERE   itser.items_id = serie.seritsit
            AND     itser.serie = serie.serinume
            );

    CURSOR cuTotalItems
    IS
        SELECT  count(1)
        FROM    ldci_trsoitem item
        WHERE   item.tsitsoma = :new.trsmcodi;

    CURSOR cuGetItemClas
    IS
        SELECT  item_classif_id, trite.tsittrsm
        FROM    ge_items items, ldci_trsoitem trite
        WHERE   items.items_id = trite.tsititem
        AND     trite.tsitsoma = :new.trsmcodi
        AND     item_classif_id = 21;

    CURSOR cuGetDataFromReq
    IS
        SELECT  dema.trsmcodi
        FROM    ldci_intemmit sap, ldci_transoma dema
        WHERE   sap.mmitnupe like '%-'|| dema.trsmcodi
        AND     sap.mmitdsap = :new.trsmdsre
        AND     dema.trsmtipo = 1
        AND     rownum < 2;

    CURSOR cuGetRelatedDoc( nuRelatedDoc    in number)
    IS
        SELECT  trsmcont contrat, trsmprov Centro, trsmunop UniOp, trsmcodi docure,
                trsmofve oficina
        FROM    ldci_transoma dema
        WHERE   dema.trsmcodi = nuRelatedDoc
        AND     dema.trsmcodi <> :new.trsmcodi;

    nuCount         number;
    sbProgram       varchar2(100);
    nuClasif        number;
    nuPosic         number;
    nuTotalSerie    number;

    nuContratisa    number;
    nuCentro        number;
    nuUniOp         number;
    nuDocuRe        number;
    sbOficina       varchar(4);

    sbEntrega2321   varchar2(100) := 'OSS_CON_EEC_200_2321_GDC_10';
    sbAplica2321    varchar2(1):='N';


BEGIN
/*
 * Se omite todo, solo si la accion llega desde un job
 */
    /*open  cuGetProgram;
    fetch cuGetProgram INTO sbProgram;
    close cuGetProgram;     */

    -- Obtiene el programa
    sbProgram := ut_session.getmodule();
    IF fblaplicaentrega(sbEntrega2321) then
      sbAplica2321:='S';
    else
      sbAplica2321:='N';
    end if;

    IF (upper(sbProgram) in ('LDCISOMA','LDCIDEMA')) THEN

        pkErrors.PUSH('ldc_trgbiuldci_transoma');

        if((inserting OR updating) AND :new.trsmtipo = 1) then
            IF sbAplica2321='S' and updating  THEN
              null;

            else
               :new.trsmesta := 1;

            end if;
            if(:new.trsmcont IS null) then -- contratista
                Errors.SetError
                    (
                        2741,
                        'El campo Contratista no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;
            if(:new.trsmprov IS null) then -- Centro a Solicitar
                Errors.SetError
                    (
                        2741,
                        'El campo Centro a Solicitar no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;
            if(:new.trsmfecr IS null) then -- Fecha
                Errors.SetError
                    (
                        2741,
                        'El campo Fecha no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;
            if(:new.trsmunop IS null) then -- Unidad Operativa
                Errors.SetError
                    (
                        2741,
                        'El campo Unidad Operativa no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;
            if(:new.trsmofve IS null) then -- Oficina de Venta
                Errors.SetError
                    (
                        2741,
                        'El campo Oficina de Venta no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;
            if(:new.trsmmpdi IS null) then -- Motivo Venta
                Errors.SetError
                    (
                        2741,
                        'El campo Motivo no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;

        end if;

        if((inserting OR updating) AND :new.trsmtipo = 1) then
            -- guarda el codigo del ldci_transoma como descripcion
            :new.trsmsol := :new.trsmcodi;
        end if;

        if((inserting OR updating) AND :new.trsmtipo = 2) then

            if(:new.trsmmdpe IS null) then -- Motivo Devolucion
                Errors.SetError
                    (
                        2741,
                        'El campo Motivo Devolucion Pedido no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;
            if(:new.trsmdsre IS null) then -- Documento Sap
                Errors.SetError
                    (
                        2741,
                        'El campo Documento SAP no puede ser nulo'
                    );
                    raise ex.controlled_error ;
            end if;

            open  cuGetDataFromReq;
            fetch cuGetDataFromReq INTO nuDocuRe;
            close cuGetDataFromReq;

            if(nuDocuRe IS null) then
                Errors.SetError
                    (
                        2741,
                        'El documento SAP ingresado no corresponde a ningun pedido'
                    );
                    raise ex.controlled_error;
            end if;

            open  cuGetRelatedDoc(nuDocuRe);
            fetch cuGetRelatedDoc INTO nuContratisa,nuCentro,nuUniOp,nuDocuRe,sbOficina;
            close cuGetRelatedDoc;

            :new.trsmcont := nuContratisa;
            :new.trsmprov := nuCentro;
            :new.trsmunop := nuUniOp;
            :new.trsmofve := sbOficina;
            :new.trsmdore := nuDocuRe;

        end if;

        if(:new.trsmtipo = 2) then

            if(:new.trsmacti = 'S') then

                if (cuSerieItems%isopen) then
                    close cuSerieItems;
                end if;

                open cuSerieItems;
                fetch cuSerieItems INTO nuCount;
                close cuSerieItems;

                if(nuCount = 0 ) then
                    open  cuGetItemClas;
                    fetch cuGetItemClas into nuClasif,nuPosic;
                    close cuGetItemClas;

                    if(nuClasif = 21) then

                        Errors.SetError
                        (
                            2741,
                            'La serie que intenta Devolver no es del mismo Item, o no ha ingresado ninguna serie. Posicion ['||nuPosic||']'
                        );
                        raise ex.controlled_error ;
                    end if;

                end if;
            end if;
        end if;

        --if((updating OR deleting) AND :old.trsmacti = 'S') then
        if((updating OR deleting) ) then
          if ((upper(sbProgram) in ('LDCISOMA','LDCIDEMA')) and :old.trsmacti = 'S') THEN
            Errors.SetError
            (
              2741,
              'Este registro ya fue procesado, no se puede modificar'
            );
            raise ex.controlled_error ;
          end if;
        end if;



        --- Esto se hace para evitar que cuando acaba de insertar el registro y no se ha actualizado la pantalla
        --- no deje el estado en nulo
        if(updating AND :new.trsmtipo = 1 AND :new.trsmesta IS null) then
            :new.trsmesta := 1;
        end if;


        if((inserting OR updating) AND :new.trsmacti = 'S') then
            open  cuTotalItems;
            fetch cuTotalItems INTO nuTotalSerie;
            close cuTotalItems;

            if(nuTotalSerie = 0) then
                Errors.SetError
                (
                    2741,
                    'El registro ['||:new.trsmcodi||'] que intenta procesar no tiene items'
                );
                raise ex.controlled_error ;

            end if;

        end if;

        --ARA:8358
        --Mmejia
        --Validacion motivo de venta
        IF((INSERTING OR UPDATING))THEN
            --Se hace el llamado a la funcion que valida si el motivo de venta
            --requiere codigod e orden asociado a la unidad operativa
            IF(NOT fsFuncionValLDCISOMA(:new.TRSMMPDI,:new.ORDER_ID,:new.TRSMUNOP))THEN
               Errors.SetError
                (
                    2741,
                    'El motivo de venta  ['||:new.TRSMMPDI||'] requiere en el campo  CODIGO ORDEN una orden asociada a la unidad operativa ['||:new.TRSMUNOP||']'
                );
                RAISE ex.controlled_error ;
            END IF;
        END IF;

        pkErrors.Pop;
    ELSE
      if((updating OR deleting) ) then
          ut_trace.Trace('sbAplica2321 '||sbAplica2321, 10);
          ut_trace.Trace(':OLD.TRSMESTA '||:OLD.TRSMESTA, 10);
          ut_trace.Trace(':NEW.TRSMESTA '||:NEW.TRSMESTA, 10);
          ut_trace.Trace('sbProgram '||sbProgram, 10);
          if (sbAplica2321 = 'S' AND :OLD.TRSMESTA in (6,7,8) AND :NEW.TRSMESTA!=:OLD.TRSMESTA AND (upper(sbProgram) in ('LDCAPSOMA'))) THEN
            Errors.SetError
            (
              2741,
              'Este registro ya fue procesado, no se puede modificar'
            );
            raise ex.controlled_error ;
        end if;
      END IF;
    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;

    when OTHERS then
    	pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);

END LDC_TRGBIULDCI_TRANSOMA;
/
