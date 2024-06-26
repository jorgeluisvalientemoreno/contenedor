select *
  from gv$session s
 where upper(s.MODULE) like upper('%demonio%')
