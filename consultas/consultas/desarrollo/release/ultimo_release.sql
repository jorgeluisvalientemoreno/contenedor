select *
from (
select *
from open.ge_database_Version
where version_name like '7.07.046_%'
order by install_init_date desc)
where rownum=1
