CREATE OR REPLACE TRIGGER ADM_PERSON.trgbdrLDC_TASKTYPE_CONTYPE
BEFORE DELETE ON CT_TASKTYPE_CONTYPE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
/*****************************************************************
Propiedad intelectual de redi gascaribe.

Unidad         : trgbdrLDC_TASKTYPE_CONTYPE
Descripcion    : No se permitiran eliminar  Tipos de Trabajo que pertenezcan
                 a tipos de contrato que ya esten siendo utilizados en alguna
                 acta abierta.

Autor          : Viviana Barrag?n G?mez.
Fecha          : 19-04-2016

Historia de Modificaciones
Fecha        Autor                   Modificacion
=========    ======================  ====================

******************************************************************/
DECLARE
    sbErrMsg                    ge_error_log.description%type;
    nuErrCode                    NUMBER;
    sbResult                    varchar2(1);

    nuERROR_EXISTS_CERT          number := 901161;

    --
    CURSOR cuExistTasktype
    (
        inuTaskTypeId       in CT_TASKTYPE_CONTYPE.task_type_id%type,
        inuContractTypeId   in CT_TASKTYPE_CONTYPE.contract_type_id%type
    )
    IS
        SELECT /*+
                 index(ge_contrato IDX_GE_CONTRATO02)
                 index(ge_acta IDX_GE_ACTA_01)
                 index(ct_order_certifica IDX_CT_ORDER_CERTIFICA01)
                 index(or_order IDX_OR_ORDER01)
                 leading(ge_contrato)
                 use_nl(ge_contrato ge_acta)
                 use_nl(ge_acta ct_order_certifica)
                 use_nl(ct_order_certifica or_order)
              */
              'X'
        FROM  ge_contrato
            , ge_acta
            , ct_order_certifica
            , or_order
        WHERE ge_contrato.id_tipo_contrato = inuContractTypeId
          AND ge_acta.id_contrato = ge_contrato.id_contrato
          AND ct_order_certifica.certificate_id = ge_acta.id_acta
          AND or_order.order_id = ct_order_certifica.order_id
          AND or_order.task_type_id = inuTaskTypeId
          AND ge_acta.estado = 'A'
          AND ROWNUM = 1;



BEGIN
    ut_trace.trace('INICIO Trigger trgbdrLDC_TASKTYPE_CONTYPE ',10);

    --Si esta abierto el CURSOR lo cierra.
    if cuExistTasktype%isopen Then
        close cuExistTasktype;
    END if;

    open cuExistTasktype(:OLD.task_type_id, :OLD.contract_type_id);
    fetch cuExistTasktype INTO sbResult;
    close cuExistTasktype;

    if sbResult IS not null Then
        --No se puede eliminar el registro [%s1]
        Errors.SetError(nuERROR_EXISTS_CERT);
        raise ex.CONTROLLED_ERROR;
    else

      insert into LDC_TASKTYPE_CONTYPE_HIST values(SQ_LDC_TASKTYPE_CONTYPE_HIST.NextVal,
                                                   :OLD.task_type_id,
                                                   :OLD.contract_type_id,
                                                   :OLD.Contract_Id,
                                                   'E',
                                                   SYSDATE,
                                                   USER,
                                                   (SELECT MACHINE FROM V$SESSION H WHERE H.AUDSID = USERENV('SESSIONID') AND H.USERNAME=USER)
                                                    );


    END if;

    ut_trace.trace('FIN Trigger trgbdrLDC_TASKTYPE_CONTYPE',10);


EXCEPTION
    when others then
        if cuExistTasktype%isopen then
            close cuExistTasktype;
        END if;
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
End;
/
