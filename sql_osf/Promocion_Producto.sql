select * from pr_promotion pp where pp.product_id = 50366875;
SELECT PECSFEAI --+ INDEX (PERICOSE IX_PERICOSE01)
--*
  FROM PERICOSE
 WHERE PECSCICO = 1801
   --AND PECSFEAI >= sysdate
 ORDER BY PECSFEAI desc;
