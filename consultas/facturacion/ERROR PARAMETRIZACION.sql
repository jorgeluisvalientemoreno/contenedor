select *
from open.ge_error_log
  where error_log_id in (190938388,190938389);
SELECT *
  FROM OPEN.GE_MESSAGE
  WHERE UPPER(DESCRIPTION) LIKE '%NO%EXISTE%REGLA%';
SELECT * FROM OPEN.remevaco  WHERE rmvcmevc = 4   AND rmvctico = 1;
SELECT * FROM OPEN.TIPOCONS WHERE TCONCODI=1;
SELECT * FROM OPEN.MEANVACO;
SELECT * FROM OPEN.CARAVACO;
SELECT * FROM OPEN.GE_ITEMS WHERE ITEMS_ID in (4000053, 102008,
4000044,
4000054);

SELECT *
FROM OPEN.SA_EXECUTABLE

WHERE NAME='FRMV';

select *
from open.ge_message
where upper(description) like '%NO%EXISTE%REGLA%';

select *
from open.or_order_activity
where order_id=15132535;

select sesucate, sesusuca, SESUMECV
from open.servsusc
--where sesunuse=50900352;
where sesucate=3
  and sesusuca=1;
select *
from open.categori;


SELECT *
FROM OPEN.OR_ORDER_ACTIVITY
WHERE ORDER_ID=15132535;
