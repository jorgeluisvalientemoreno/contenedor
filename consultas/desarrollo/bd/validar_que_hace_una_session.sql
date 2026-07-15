

-- What SQL statement is being executed?

SELECT s.sid                   "sid",
       s.username              "usuario",
       substr(s.status,1,4)    "status",
       q.sql_text              "texto"
  FROM gv$session s,
       gv$sqltext q
 WHERE  s.sql_hash_value = q.hash_value
   AND s.sql_address = q.address
   AND s.sid in (4961   )

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

