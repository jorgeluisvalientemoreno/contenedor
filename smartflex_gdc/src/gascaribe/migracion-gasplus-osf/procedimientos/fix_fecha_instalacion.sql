CREATE OR REPLACE procedure FIX_FECHA_INSTALACION
as

cursor cuprcomponent
is
select component_id
from pr_component
where creation_date >sysdate;

cursor cucompsesu
is
select cmssidco
from compsesu
where cmssfein >sysdate+1;

begin

    for r in  cuprcomponent
    loop
        update pr_component set creation_date=sysdate where component_id=r.component_id;
        commit;
    END LOOP;

    for r in  cucompsesu
    loop
        update compsesu set cmssfein=sysdate where cmssidco=r.cmssidco;
        commit;
    end loop;

end;
/
