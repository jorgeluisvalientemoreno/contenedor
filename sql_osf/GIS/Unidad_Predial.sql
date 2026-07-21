with direccion as
 (select aa.address_id
    from OPEN.AB_ADDRESS aa
    left join OPEN.AB_SEGMENTS as_
      on as_.segments_id = aa.segment_id
   where as_.route_id = -1)
select d.address_id, a2.direccion, a2.tag
  from direccion d
 inner join unidadpredial@db_giscar a2
    on a2.idaddress = d.address_id
