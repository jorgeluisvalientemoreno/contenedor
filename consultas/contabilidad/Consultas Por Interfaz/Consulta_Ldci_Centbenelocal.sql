select celodpto,(select g.description from open.ge_geogra_location g where g.geograp_location_id = celodpto) nom_dpto,
       celoloca,(select g.description from open.ge_geogra_location g where g.geograp_location_id = celoloca) nom_loca,
       celocebe,(select b.cebedesc from open.ldci_centrobenef b where b.cebecodi = celocebe) nom_cebe
  from open.ldci_centbenelocal l
