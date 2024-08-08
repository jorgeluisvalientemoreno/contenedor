select a.*, rowid
  from open.cargos a
 where a.cargnuse in (select s.sesunuse
                        from open.servsusc s
                       where s.sesususc in ( --78642
                                            726689))
   and a.cargfecr > '30/07/2024'
 order by a.cargfecr desc;
