CREATE OR REPLACE PACKAGE adm_person.LDC_Pk_ORCUO IS
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_Pk_ORCUO
    Descripcion    : Servicios para gestionar el saldo de las unidades de trabajo
    Autor          : Eduardo Cerón
    Fecha          : 17-04-2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    02/07/2024        PAcosta           OSF-2889: Cambio de esquema ADM_PERSON 
  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetUnitOperByPerson
    Descripcion    : Obtiene las unidades de trabajo según la persona conectada.
  ******************************************************************/
    PROCEDURE GetUnitOperByPerson
    (
        orfUnidades  out  nocopy pkconstante.tyRefCursor
    );

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetBalanceByOper
    Descripcion    : Obtiene los saldos de los ítmes dada la unidad de trabajo
  ******************************************************************/
    PROCEDURE GetBalanceByOper
    (
        inuOperUnit IN  or_operating_unit.operating_unit_id%TYPE,
        orfSaldos  out  nocopy pkconstante.tyRefCursor
    );

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetItemsLOV
    Descripcion    : Obtiene los items para lista de valores.
   ******************************************************************/
    PROCEDURE GetItemsLOV
    (
        inuOperUnit     in   or_operating_unit.operating_unit_id%TYPE,
        isbLoadAll      IN   varchar2,
        orfItems  out  nocopy pkconstante.tyRefCursor
    );

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : CreOrUpdBalance
    Descripcion    : Crea o actualiza el registro del balance por unidad de trabajo.
  ******************************************************************/
    PROCEDURE CreOrUpdBalance
    (
        inuOperUnit IN  or_operating_unit.operating_unit_id%TYPE,
        inuItemsId  IN  ge_items.items_id%TYPE,
        inuQuota    IN  or_ope_uni_item_bala.quota%TYPE,
        inuBalance  IN  or_ope_uni_item_bala.balance%TYPE
    );


END LDC_Pk_ORCUO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_Pk_ORCUO IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_Pk_ORCUO
    Descripcion    : Servicios para gestionar el saldo de las unidades de trabajo
    Autor          : Eduardo Cerón
    Fecha          : 17-04-2019

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    02/07/2024        PAcosta           OSF-2889: Cambio de esquema ADM_PERSON 
  ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetUnitOperByPerson
    Descripcion    : Obtiene las unidades de trabajo según la persona conectada.
    Autor          : Eduardo Cerón
    Fecha          : 17/04/2019

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    orfUnidades   Cursor con las unidades de trabajo

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/
    PROCEDURE GetUnitOperByPerson
    (
        orfUnidades  out  nocopy pkconstante.tyRefCursor
    )
    IS
    BEGIN

        ut_trace.Trace('INICIO: LDC_Pk_ORCUO.GetUnitOperByPerson', 8);

        open orfUnidades for
            select  or_operating_unit.operating_unit_id,
                    or_operating_unit.name,
                    or_operating_unit.person_in_charge||' - '|| dage_person.fsbgetname_(or_operating_unit.person_in_charge, 0) "Persona"
            from    or_operating_unit, or_oper_unit_persons
            where   or_operating_unit.operating_unit_id = or_oper_unit_persons.operating_unit_id
            and     or_oper_unit_persons.person_id = ge_bopersonal.fnugetpersonid
            ORDER BY or_operating_unit.operating_unit_id;

        ut_trace.Trace('FIN: LDC_Pk_ORCUO.GetUnitOperByPerson', 8);
    --}
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END GetUnitOperByPerson;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetBalanceByOper
    Descripcion    : Obtiene los saldos de los ítmes dada la unidad de trabajo
    Autor          : Eduardo Cerón
    Fecha          : 17/04/2019

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuOperUnit   Identificador de la unidad de trabajo
    orfSaldos     Cursor con los saldos de la unidad de trabajo

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/
    PROCEDURE GetBalanceByOper
    (
        inuOperUnit IN  or_operating_unit.operating_unit_id%TYPE,
        orfSaldos  out  nocopy pkconstante.tyRefCursor
    )
    IS
    BEGIN

        ut_trace.Trace('INICIO: LDC_Pk_ORCUO.GetBalanceByOper - inuOperUnit: '||inuOperUnit, 8);

        open orfSaldos for
            select  or_ope_uni_item_bala.items_id ID,
                    dage_items.fsbgetdescription(or_ope_uni_item_bala.items_id,0) "Item",
                    or_ope_uni_item_bala.balance,
                    or_ope_uni_item_bala.quota
            from    or_ope_uni_item_bala
            where   or_ope_uni_item_bala.operating_unit_id = inuOperUnit
            order by or_ope_uni_item_bala.items_id;

        ut_trace.Trace('FIN: LDC_Pk_ORCUO.GetBalanceByOper', 8);
    --}
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END GetBalanceByOper;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : GetItemsLOV
    Descripcion    : Obtiene los items para lista de valores.
    Autor          : Eduardo Cerón
    Fecha          : 17/04/2019

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuOperUnit   Identificador de la unidad de trabajo
    isbLoadAll    Indica si se deben cargar todos los items
    orfUnidades   Cursor con las unidades de trabajo

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/
    PROCEDURE GetItemsLOV
    (
        inuOperUnit     in   or_operating_unit.operating_unit_id%TYPE,
        isbLoadAll      IN   varchar2,
        orfItems  out  nocopy pkconstante.tyRefCursor
    )
    IS
    BEGIN

        ut_trace.Trace('INICIO: LDC_Pk_ORCUO.GetItemsLOV', 8);

        IF isbLoadAll = 'N' THEN
            open orfItems for
                select ID,
                       DESCRIPTION
                FROM(
                    select -1 ID,
                           '------------------------------' DESCRIPTION
                    FROM DUAL
                    UNION ALL
                    select  ge_items.items_id ID,
                            ge_items.description
                    from    ge_items
                    where   ge_items.item_classif_id IN (3,8,13,21)
                    and     not exists (select 1
                                        from or_ope_uni_item_bala
                                        where or_ope_uni_item_bala.operating_unit_id = inuOperUnit
                                        and or_ope_uni_item_bala.items_id = ge_items.items_id
                                         )
                    )
                 order by  ID;

        ELSE
            open orfItems for
                select  ge_items.items_id ID,
                        ge_items.description
                from    ge_items
                where   ge_items.item_classif_id IN (3,8,13,21);
        END IF;



        ut_trace.Trace('FIN: LDC_Pk_ORCUO.GetItemsLOV', 8);
    --}
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END GetItemsLOV;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : CreOrUpdBalance
    Descripcion    : Crea o actualiza el registro del balance por unidad de trabajo.
    Autor          : Eduardo Cerón
    Fecha          : 17/04/2019

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    inuOperUnit   Identificador de la unidad de trabajo
    inuItemsId    Identificador del item
    inuQuota      Cupo
    inuBalance    Saldo

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/
    PROCEDURE CreOrUpdBalance
    (
        inuOperUnit IN  or_operating_unit.operating_unit_id%TYPE,
        inuItemsId  IN  ge_items.items_id%TYPE,
        inuQuota    IN  or_ope_uni_item_bala.quota%TYPE,
        inuBalance  IN  or_ope_uni_item_bala.balance%TYPE
    )
    IS
    BEGIN

        ut_trace.Trace('INICIO: LDC_Pk_ORCUO.CreOrUpdBalance - inuOperUnit: '||inuOperUnit||
                       ' inuItemsId: '||inuItemsId||' inuQuota: '||inuQuota||' inuBalance: '||inuBalance, 8);

        -- Se valida que no sea el item dummi
        IF inuItemsId = -1 THEN
            ge_boerrors.seterrorcodeargument
            (
                ld_boconstans.cnugeneric_error,
                'El Ítem -1 no es un valor válido. Favor ajustar.'
            );
            raise ex.CONTROLLED_ERROR;

        END IF;

        IF inuQuota >= 0 AND inuBalance >= 0 THEN

            -- Si existe se actualiza
            IF  daor_ope_uni_item_bala.fblexist(inuItemsId, inuOperUnit) THEN

                UPDATE or_ope_uni_item_bala
                    set  or_ope_uni_item_bala.quota = inuQuota
                where or_ope_uni_item_bala.items_id = inuItemsId
                and   or_ope_uni_item_bala.operating_unit_id = inuOperUnit;

            ELSE
                -- Si no existe se crea el nuevo registro
                INSERT INTO OR_OPE_UNI_ITEM_BALA
                            (
                                ITEMS_ID,
                                OPERATING_UNIT_ID,
                                QUOTA,
                                BALANCE,
                                TOTAL_COSTS,
                                OCCACIONAL_QUOTA,
                                TRANSIT_IN,
                                TRANSIT_OUT
                            )
                VALUES (inuItemsId,inuOperUnit,inuQuota,0,0,0,Null,Null);

            END IF;

            COMMIT;

        END IF;


        ut_trace.Trace('FIN: LDC_Pk_ORCUO.CreOrUpdBalance', 8);
    --}
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;

    END CreOrUpdBalance;




END LDC_Pk_ORCUO;
/
PROMPT Otorgando permisos de ejecucion a LDC_PK_ORCUO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PK_ORCUO', 'ADM_PERSON');
END;
/