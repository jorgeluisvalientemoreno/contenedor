with auditoria as(
SELECT  rowid, to_char(previous_text) previous_text,
               upper(to_char(current_text)) current_text,  
               au.current_date, 
               au.current_user_mask
 FROM OPEN.AU_AUDIT_POLICY_LOG au
   where AUDIT_LOG_ID IN (321) 
    and au.current_date>=to_date('01/01/2022','dd/mm/yyyy')
    and au.current_user_mask in ('EIDROJ','KARMEJ')),
listas as(
select a.*,

       substr(current_text,instr(current_text,'|',1)+1,instr(current_text,'|',instr(current_text,'|',1) )) lista2,
       to_number(REGEXP_SUBSTR (current_text, '[^|]+', 1, 1)) lista,
       REGEXP_SUBSTR (current_text, '[^|]+', 1, 2) desc_lista,
       to_date(REGEXP_SUBSTR (current_text, '[^|]+', 1, 3),'dd/mm/yyyy hh24:mi:ss') fech_ini,
       to_date(REGEXP_SUBSTR (current_text, '[^|]+', 1, 4),'dd/mm/yyyy hh24:mi:ss') fech_fin,
       to_number(REGEXP_SUBSTR (current_text, '[^|]+', 1, 5)) unidad
from auditoria a )
select *
from listas
inner join open.ge_list_unitary_cost l on l.list_unitary_cost_id=listas.lista and l.operating_unit_id is not null --and trunc(l.validity_start_date)=trunc(listas.fech_ini) and trunc(l.validity_final_date) =trunc(listas.fech_fin)

;

SELECT COUNT(1)
              INTO nuExiste
              FROM (SELECT to_number(regexp_substr(sbEstaCort,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS estacort
                      FROM dual
                    CONNECT BY regexp_substr(sbEstaCort, '[^,]+', 1, LEVEL) IS NOT NULL)
             WHERE estacort = nuestacorte;
