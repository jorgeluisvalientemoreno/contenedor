SELECT *
FROM OPEN.MOEXCORE;

SELECT *
FROM OPEN.EXCOCORE E
--WHERE E.ECCRFECA IS NULL;
WHERE E.ECCRSUSC IN ( 313546 );



SELECT *
FROM OPEN.EXCOCORE E, OPEN.SERVSUSC S
WHERE E.ECCRFECA IS NULL
  AND E.ECCRSESU=S.SESUNUSE;
select *
from open.servsusc
where sesususc=59733;


SELECT *
FROM  open.RECAESCO
WHERE RCECSERV = 7014
AND   RCECCOEC = 1
AND   RCECFUFA IS NOT NULL
GROUP BY RCECFUFA ;


SELECT *
FROM OPEN.HICAEXCR R
WHERE R.HCECECCR IN (822, 846);

SELECT *
FROM OPEN.CONFCOSE;

SELECT *
FROM OPEN.CONFESCO;

SELECT *
FROM OPEN.BI_PACKAGE_SEND



  SELECT  SUSCCODI, SUSCCLIE, SUSCCICL
  FROM    OPEN.SUSCRIPC    --+ pkSuspConnServiceMgr.GetContracts (1)
  WHERE   SUSCCODI > INUMINCONTRACT
  AND     SUSCCODI IN
  (   SELECT  /*+ index(servsusc IX_SERVSUSC02) index(recaesco pk_recaesco)*/
              SESUSUSC
      FROM    OPEN.SERVSUSC, OPEN.RECAESCO
      WHERE   SESUSERV = RCECSERV
      AND     SESUESCO = RCECCOER
      AND     SESUESCO = 1
      AND     RCECCOEC = INUAPPLYEVENT
      AND     RCECCOER = INUREQSTATE
  )