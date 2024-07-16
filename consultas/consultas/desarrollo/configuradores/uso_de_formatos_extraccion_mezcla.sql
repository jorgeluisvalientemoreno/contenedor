select *
from dba_dependencies d
inner join dba_source s on s.name=d.name and upper(s.TEXT) like '%PKBODATAEXTRACTOR.EXECUTERULES%'
where referenced_name='PKBODATAEXTRACTOR'