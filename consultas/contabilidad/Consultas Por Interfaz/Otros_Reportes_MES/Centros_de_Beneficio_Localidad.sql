select l.celocebe, (select f.cebedesc from open.ldci_centrobenef f where f.cebecodi = l.celocebe) Desc_Cebe,
       l.celodpto, (select g.description from open.ge_geogra_location g where g.geograp_location_id = l.celodpto) Desc_Dpto,
       l.celoloca, (select g.description from open.ge_geogra_location g where g.geograp_location_id = l.celoloca) Desc_Loca
  from open.ldci_centbenelocal l
