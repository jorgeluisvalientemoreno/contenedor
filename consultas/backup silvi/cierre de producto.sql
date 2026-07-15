select * from  ic_cartcoco where caccfege  >= '18/09/2023'
select * from ge_error_log g where g.error_log_id in (114628493,114628494,114628492,114628491);

select * from procejec p where UPPER(p.prejprog) like '%ICBGIC%' AND prejfech >='03/11/2023';
SELECT * FROM ESTAPROG E WHERE E.ESPRPROG like '%ICBGIC%' AND E.ESPRFEIN>='15/11/2023';

select sysdate from dual;

select * from IC_TIPOMOVI;

select * from ic_cartcoco i where i.caccfege >='03/11/2023'
