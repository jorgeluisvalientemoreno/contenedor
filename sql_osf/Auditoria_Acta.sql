--125 y 430 audita contrato
select  rowid, 
        to_char(previous_text), 
        to_char(current_text),  
        to_date(to_char(au.current_date,'DD/MM/YYYY, HH24:MI:SS'))
 from open.au_audit_policy_log au
   where audit_log_id in (125)--(430) --
    and current_text like '9321%'
order by to_date(to_char(au.current_date,'DD/MM/YYYY, HH24:MI:SS')) desc;

--206 Audita Acta
SELECT xml_log,
       l.current_date,
       l.current_user_mask,
       l.xml_log,
       tabla_ante.*
  FROM OPEN.AU_AUDIT_POLICY_LOG l,
       xmltable('AU_LOG' passing xml_log columns ID_ACTA number path
                '//PREVIOUS_VALUES//MODIFICACIONES//ID_ACTA',
                ID_TIPO_ACTA_PREVIO varchar2(4000) path
                '//PREVIOUS_VALUES//MODIFICACIONES//ID_TIPO_ACTA',
                ESTADO_PREVIO varchar2(4000) path
                '//PREVIOUS_VALUES//MODIFICACIONES//ESTADO',
                VALOR_TOTAL_PREVIO varchar2(4000) path
                '//PREVIOUS_VALUES//MODIFICACIONES//VALOR_TOTAL',
                
                ID_TIPO_ACTA_ACTUAL varchar2(4000) path
                '//ACTUAL_VALUES//MODIFICACIONES//ID_TIPO_ACTA',
                ESTADO_ACTUAL varchar2(4000) path
                '//ACTUAL_VALUES//MODIFICACIONES//ESTADO',
                VALOR_TOTAL_ACTUAL varchar2(4000) path
                '//ACTUAL_VALUES//MODIFICACIONES//VALOR_TOTAL',
                
                ID_CONTRATO varchar2(4000) path
                '//PREVIOUS_VALUES//MODIFICACIONES//ID_CONTRATO') tabla_ante
 where l.AUDIT_LOG_ID IN (206)
      --and tabla_ante.ESTADO_PREVIO in ('C')
   and tabla_ante.ID_CONTRATO = '9321'
   and l.current_date >= to_date('01/09/2022', 'dd/mm/yyyy');
SELECT *
  FROM OPEN.AU_AUDIT_POLICY_LOG au
 where
--AUDIT_LOG_ID IN (321) 
 au.current_date >= to_date('01/09/2022', 'dd/mm/yyyy')
 and au.current_user_mask in ('EIDROJ', 'KARMEJ');
