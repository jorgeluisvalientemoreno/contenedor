select *
from dba_dependencies@osfpl
where name in ('FBLVALIDNUMFACTMIN','FDTGETDUEDATE','FNUGETAPPLYACT','FNUGETBESTFINANCINGPLAN','FNUGETCANTCONSMETCALC','FNUGETCOPRFACT','FNUGETNPREVPERIFACT','FNUGETNPREVPERIOD','FNUGETNUMCUONEG','FNUGETORDERFINISHED')
 and referenced_owner='OPEN'
 and exists(select null from dba_synonyms s where s.synonym_name=referenced_name and s.owner='ADM_PERSON')
 and not exists(select null from dba_synonyms@osfpl s where s.synonym_name=referenced_name and s.owner='ADM_PERSON')
 and referenced_name='CONSTANTS'; 
 
 
 
 
 select *
from dba_synonyms
where synonym_name!=table_name
and table_owner in ('OPEN','ADM_PERSON','PERSONALIZACIONES')
and owner in ('OPEN','ADM_PERSON','PERSONALIZACIONES')
