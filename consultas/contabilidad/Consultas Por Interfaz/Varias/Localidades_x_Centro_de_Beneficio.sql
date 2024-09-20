select celodpto, (select g.description from open.ge_geogra_location g where g.geograp_location_id = celodpto) desc_dpto,
       l.celoloca, (select g.description from open.ge_geogra_location g where g.geograp_location_id = l.celoloca) desc_loca,
       l.celocebe, (select b.cebedesc from open.ldci_centrobenef b where b.cebecodi = l.celocebe) desc_cebe
  from open.ldci_centbenelocal l
order by celodpto, celoloca
