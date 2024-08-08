select a.name
  from dba_source a
 where upper(a.TEXT) like upper('%ldci_pkfactkiosco_gdc%')
 group by a.name;
select a.*
  from OPEN.GE_OBJECT a
 where a.name_ like upper('%ldci_pkfactkiosco_gdc%');
select gce.*, rowid
  from open.gr_config_expression gce
 where upper(gce.expression) like upper('%ldci_pkfactkiosco_gdc%')
    or upper(gce.code) like upper('%ldci_pkfactkiosco_gdc%');
select *
  from dba_dependencies dd
 where 
 --upper(dd.name) like upper('%ldci_pkfactkiosco_gdc%')
 upper(dd.REFERENCED_NAME) like upper('%ldci_pkfactkiosco_gdc%')
