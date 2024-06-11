

-- What SQL statement is being executed?

SELECT s.sid                   "sid",
       s.username              "usuario",
       substr(s.status,1,4)    "status",
       q.sql_text              "texto"
  FROM gv$session s,
       gv$sqltext q
 WHERE  s.sql_hash_value = q.hash_value
   AND s.sql_address = q.address
   AND s.sid in (2830
-- ,8769,7926,7652,7626,7363,3681,2553,2284,1153,1133,585,313,8784,8763,8190,7931,7349,7054,5959,4829,3956,3705,3400,2823,1736,1427,1171,605,572,302
   )
   and s.INST_ID=2
   --AND UPPER(q.sql_text) LIKE '%SERVICIO%'
order by q.piece;
/
declare
-- nuevo

variable addr varchar2(20);
variable hash number

begin
select distinct q.hash_value, q.address
  into :hash, :addr
  FROM v$session s,
       v$sqltext q
 WHERE  s.sql_hash_value = q.hash_value
   AND s.sql_address = q.address
   AND s.sid = &1 ;
end;
/

