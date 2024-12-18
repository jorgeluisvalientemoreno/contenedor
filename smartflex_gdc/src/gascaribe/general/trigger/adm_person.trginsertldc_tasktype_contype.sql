CREATE OR REPLACE TRIGGER ADM_PERSON.trginsertLDC_TASKTYPE_CONTYPE
AFTER INSERT ON CT_TASKTYPE_CONTYPE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
/*****************************************************************
Propiedad intelectual de redi gascaribe.

Unidad         : trginsertLDC_TASKTYPE_CONTYPE
Descripcion    : INSERTAR REGISTRO EN LDC_TASKTYPE_CONTYPE_HIST

Autor          : Viviana Barrag?n G?mez.
Fecha          : 19-04-2016

Historia de Modificaciones
Fecha        Autor                   Modificacion
=========    ======================  ====================

******************************************************************/
DECLARE


    --



BEGIN
    ut_trace.trace('INICIO Trigger trginsertLDC_TASKTYPE_CONTYPE ',10);



      insert into LDC_TASKTYPE_CONTYPE_HIST values(SQ_LDC_TASKTYPE_CONTYPE_HIST.NextVal,
                                                   :NEW.task_type_id,
                                                   :NEW.contract_type_id,
                                                   :NEW.Contract_Id,
                                                   'I',
                                                   SYSDATE,
                                                   USER,
                                                   (SELECT MACHINE FROM V$SESSION H WHERE H.AUDSID = USERENV('SESSIONID') AND H.USERNAME=USER)
                                                    );

   EXCEPTION
    when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;


    ut_trace.trace('FIN Trigger trginsertLDC_TASKTYPE_CONTYPE',10);



End;
/
