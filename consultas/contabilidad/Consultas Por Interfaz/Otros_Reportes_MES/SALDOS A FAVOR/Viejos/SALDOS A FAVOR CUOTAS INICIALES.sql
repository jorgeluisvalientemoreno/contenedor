-- SALDOS A FAVOR CUOTAS INICIALES
select 'SA_CI' Tipo, servicio, Des_Servicio, producto, nombre, categoria, consecutivo, Fecha, proceso, total,
       est_corte, (select e.escodesc from open.estacort e where e.escocodi = est_corte) des_corte,
       est_produc, (select ps.description from OPEN.PS_PRODUCT_STATUS ps where ps.product_status_id = est_produc) des_produc
  from (
        select servicio, Des_Servicio, producto, nombre, categoria, consecutivo, Fecha, proceso, total,
               (SELECT h.hcececac from open.hicaesco h 
                 where h.hcecnuse = producto 
                   and h.hcecfech = (select max(hc.hcecfech) from open.hicaesco hc 
                                      where hc.hcecnuse = producto and h.hcecfech < '01-08-2015')) Est_Corte,
               (select p.product_status_id from open.pr_product p where p.product_id = producto) Est_Produc
          from (
                select sesuserv servicio, (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Des_Servicio,
                       mosfsesu producto, s.subscriber_name|| ' ' || s.subs_last_name nombre, sesucate categoria, 
                       (select c.cargconc from open.cargos c
                         where cargnuse = mosfsesu and cargconc = 301 and cargsign = 'SA'
                           and cargvalo = total and rownum = 1 and cargfecr < '01-08-2015') inicial,
                       mosfsafa consecutivo, 
                       (select trunc(sv.safafecr) from open.saldfavo sv where sv.safacons = mosfsafa) Fecha,
                       (select procdesc 
                          from open.procesos p 
                       where p.proccodi in (select s.safaprog from open.saldfavo s where s.safacons = mosfsafa)) Proceso,
                       Total
                  from (
                        select mosfsesu, m.mosfsafa, sum(mosfvalo) Total
                          from open.movisafa m
                         where m.mosffecr < '01-08-2015'
                        group by mosfsesu, m.mosfsafa
                        ), open.servsusc c, open.ge_subscriber s, open.suscripc p
                where Total > 0
                   and mosfsesu = c.sesunuse
                   and c.sesususc = p.susccodi
                   and p.suscclie = s.subscriber_id
                order by mosfsesu
               )
         where inicial is not null
       )
