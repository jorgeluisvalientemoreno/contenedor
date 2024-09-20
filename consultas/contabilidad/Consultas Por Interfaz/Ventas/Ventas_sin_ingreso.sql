select * from (
select hcecnuse,
       (select distinct p.package_type_id from open.or_order_activity a, open.mo_packages p 
         where a.product_id = hcecnuse and a.package_id = p.package_id and p.package_type_id in (100271,323,271)) tipo,
       (select sum(c.cargvalo) from open.cargos c 
         where cargnuse = hcecnuse and cargconc = 19 and cargsign = 'DB' and cargcaca = 53) val_interna,
       (select c.cargfecr from open.cargos c 
         where cargnuse = hcecnuse and cargconc = 19 and cargsign = 'DB' and cargcaca = 53) fec_interna,
       (select sum(c.cargvalo) from open.cargos c 
         where cargnuse = hcecnuse and cargconc = 30 and cargsign = 'DB' and cargcaca = 53) val_cxc,
       (select c.cargfecr from open.cargos c 
         where cargnuse = hcecnuse and cargconc = 30 and cargsign = 'DB' and cargcaca = 53) fec_cxc                    
  from (SELECT distinct hcecnuse
          FROM open.hicaesco h
         WHERE hcececan = 96
           AND hcececac = 1
           AND hcecserv = 7014
           AND hcecfech >= '01-08-2015' and hcecfech < '01-09-2015'))
 where tipo = 271     
order by val_interna desc     
