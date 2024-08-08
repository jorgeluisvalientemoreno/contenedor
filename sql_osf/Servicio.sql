select count(a.Sesunuse), A.SESUSUSC from open.SERVSUSC a group by A.SESUSUSC; 
       SELECT p.product_id PRODUCT_ID, s.servdesc DESCRIPTION 
         FROM pr_product p, servicio s 
        WHERE s.servcodi = p.product_type_id AND lower(s.servflac)= ('s') 
          AND p.subscription_id = subscriptionId;
select a.Sesunuse, A.SESUCATE from open.SERVSUSC a where a.Sesususc in (100861) and a.Sesuserv= 7014;
select a.Sesunuse, A.SESUCATE from open.SERVSUSC a where a.Sesususc in (1155258,1999619) and a.Sesuserv= 7014; 
select a.Sesunuse, A.SESUCATE from open.SERVSUSC a where a.Sesuserv= 7014 AND A.SESUCATE IN (1,2) AND ROWNUM <= 5
UNION ALL
select a.Sesunuse, A.SESUCATE from open.SERVSUSC a where a.Sesuserv= 7014 AND A.SESUCATE IN (6) AND ROWNUM <= 5;

--FA_BOAccountStatusToDate.ProductBalanceAccountsToDate
