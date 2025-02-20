--sectores_por_ciclo
select  distinct s.sesucicl,d.operating_sector_id, d.category_, count(1)
    from  or_route a, or_route_premise b, ab_premise c,ab_segments d, or_route_zone t,
            ab_address ab, pr_product pr, servsusc s
    where b.route_id = a.route_id
    and    c.premise_id = b.premise_id
    and     d.segments_id = c.segments_id
    and     t.route_id = a.route_id
    and     ab.segment_id = d.segments_id
    and     pr.address_id = ab.address_id
    and     s.sesunuse = pr.product_id
    and     s.sesuserv = 7014
    and     t.operating_zone_id in (174,175,176)
    --and     a.route_id in (55500000,18500000,19010000,90500000,20500000,18010000,27010000,55020000,90140000,89140000,24010000)
    and     d.category_  in (2/*,3*/)
    and     s.sesucicl not in (5502)
    and     d.operating_sector_id in (748)
    group by s.sesucicl,d.operating_sector_id, d.category_
    order by s.sesucicl;
    
    
/*1850,2050,2401,2402,5550,9050,*/

--Cliclos: 1801,1901,5502,8914
