--
SELECT TIPO, Servicio, Des_Servicio, Producto, nombre, categoria, 
       Est_Corte, (select e.escodesc from open.estacort e where e.escocodi = est_corte) des_corte,
       Est_Produc, (select ps.description from OPEN.PS_PRODUCT_STATUS ps where ps.product_status_id = est_produc) des_produc,
       SAFAFECH, proceso, total
  from (
        SELECT TIPO, sesuserv Servicio, (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Des_Servicio,
               SAFASESU Producto, s.subscriber_name|| ' ' || s.subs_last_name nombre, sesucate categoria, 
               (SELECT h.hcececac from open.hicaesco h 
                 where h.hcecnuse = SAFASESU 
                   and h.hcecfech = (select max(hc.hcecfech) from open.hicaesco hc 
                                      where hc.hcecnuse = SAFASESU and h.hcecfech < '01-08-2016')) Est_Corte,       
               SAFAFECH, 
               (select procdesc from open.procesos p where p.proccodi = safaprog) Proceso,
               (select p.product_status_id from open.pr_product p where p.product_id = SAFASESU) Est_Produc,               
               TOTAL
          FROM (
                select SAFASESU, SAFAFECH, SUM(MOSFVALO) TOTAL, safaprog, decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO
                  from open.saldfavo s, open.movisafa m
                 where s.safacons = m.mosfsafa
                   and s.safafecr < '01-08-2016'
                   --and NVL(s.safaorig, 'x') = 'DE'
                GROUP BY SAFASESU, SAFAFECH, safaprog, safaorig 
               ), open.servsusc c, open.ge_subscriber s, open.suscripc p
         where total != 0 
           and safasesu = c.sesunuse
           and c.sesususc = p.susccodi
           and p.suscclie = s.subscriber_id
       )
