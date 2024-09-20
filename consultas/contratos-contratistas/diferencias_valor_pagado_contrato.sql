with base as (
SELECT CAST(l.current_date AS DATE) fecha,
       l.current_user_mask,
       tabla_ante.ID_CONTRATO,
       to_number(tabla_ante.VALOR_PAGADO_ANTES) valor_pagado_antes,
       to_number(tabla_ante.VALOR_LIQUIDADO_ANTES) valor_liq_antes,
       to_number(tabla_ante.VALOR_PAGADO_DESPUES) valo_pagado_despues,
       to_number(tabla_ante.VALOR_LIQUIDADO_DESPUES) valor_liq_despues
  FROM OPEN.AU_AUDIT_POLICY_LOG l,
       xmltable('AU_LOG' passing xml_log columns
                ID_CONTRATO number path
                '//PREVIOUS_VALUES//MODIFICACIONES//ID_CONTRATO',
                VALOR_PAGADO_ANTES varchar2(4000) path
                '//PREVIOUS_VALUES//MODIFICACIONES//VALOR_TOTAL_PAGADO',
                VALOR_LIQUIDADO_ANTES varchar2(4000) path
                '//PREVIOUS_VALUES//MODIFICACIONES//VALOR_LIQUIDADO',
                VALOR_PAGADO_DESPUES varchar2(4000) path
                '//ACTUAL_VALUES//MODIFICACIONES//VALOR_TOTAL_PAGADO',
                VALOR_LIQUIDADO_DESPUES varchar2(4000) path
                '//ACTUAL_VALUES//MODIFICACIONES//VALOR_LIQUIDADO') tabla_ante
 where l.AUDIT_LOG_ID IN (125, 430)
   and to_number(tabla_ante.VALOR_PAGADO_ANTES)!=to_number(tabla_ante.VALOR_PAGADO_DESPUES)
   order by CAST(l.current_date AS DATE))
, acta as(
select base.*,
       (select a.valor_liquidado from open.ge_acta a where a.id_contrato=base.id_contrato and a.fecha_cierre=base.fecha) val_liq_acta
from base
order by fecha)
select acta.*, acta.valor_pagado_antes+acta.val_liq_acta -acta.valo_pagado_despues diferencia
from acta
where val_liq_acta is not null
 and acta.valor_pagado_antes+acta.val_liq_acta!=acta.valo_pagado_despues