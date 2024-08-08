select *
  from dba_jobs a
 where upper(a.WHAT) like upper('%pkgldc_ifrs.prExecuteIFRS%')
   and a.THIS_DATE > to_date('19/12/2022')
   and a.LOG_USER = 'OPEN'
 order by a.THIS_DATE desc;

select /*+ index (a TMPINFPROVCARTPROD)*/ count(1)--*
  from open.TMP_INFORME_PROV_CART a
 where a.ano = 2022
   and a.mes = 11
