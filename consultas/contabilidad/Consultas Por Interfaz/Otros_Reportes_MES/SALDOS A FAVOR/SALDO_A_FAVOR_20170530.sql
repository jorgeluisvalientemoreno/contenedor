-- Saldo a Favor
SELECT TIPO, Servicio, Des_Servicio, Producto, nombre, categoria,
       Est_Corte, (select e.escodesc from open.estacort e where e.escocodi = est_corte) des_corte,
       Est_Produc, (select ps.description from OPEN.PS_PRODUCT_STATUS ps where ps.product_status_id = est_produc) des_produc,
       SAFAFECH, proceso, total
  from (
        SELECT TIPO, sesuserv Servicio, (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Des_Servicio,
               SAFASESU Producto, s.subscriber_name|| ' ' || s.subs_last_name nombre, sesucate categoria,
               (SELECT h.hcececac from open.hicaesco h
                 where h.hcecnuse = SAFASESU
                   and h.hcecfech = (select max(hc.hcecfech) from open.hicaesco hc where hc.hcecnuse = SAFASESU and h.hcecfech < '01-05-2017')
                   and rownum = 1) Est_Corte,
               SAFAFECH,
               (select procdesc from open.procesos p where p.proccodi = safaprog) Proceso,
               (select p.product_status_id from open.pr_product p where p.product_id = SAFASESU) Est_Produc,
               TOTAL
          FROM (
                select SAFASESU, SAFAFECH, SUM(MOSFVALO) TOTAL, safaprog, decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO
                  from open.saldfavo SF, open.movisafa m
                 where SF.safacons = m.mosfsafa
                   and SF.safasesu = m.mosfsesu
                   and SF.safafecr < '01-05-2017'
                   and m.mosffecr  < '01-05-2017'
                   --and NVL(sf.safaorig, 'x') IN ('DE')
                GROUP BY SF.SAFASESU, SF.SAFAFECH, SF.safaprog, SF.safaorig
                HAVING SUM(MOSFVALO) != 0
               ), open.servsusc c, open.ge_subscriber s, open.suscripc p
         where total != 0
           and safasesu = c.sesunuse
           and c.sesususc = p.susccodi
           and p.suscclie = s.subscriber_id
       )
