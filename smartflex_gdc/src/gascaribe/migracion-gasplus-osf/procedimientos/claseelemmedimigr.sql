CREATE OR REPLACE procedure CLASEELEMMEDIMigr (inubasedato number)
as

nuComplementoPR number;
nuComplementoSU number;
nuComplementoFA number;
nuComplementoCU number;
nuComplementoDI number;

cursor cumedidor
is
select emsscoem from 
pr_product,elmesesu, ldc_temp_servsusc_sge
where
sesunuse+nuComplementoPR=product_id
and sesueste in (23,30,31,32,9)
and product_type_id=7014
and emsssesu=product_id
and basedato=inubasedato
and emssfere>sysdate;

begin

 pkg_constantes.COMPLEMENTO(inubasedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
    
    for r in cumedidor
    loop
        update elemmedi set elmeclem=4 where elmecodi=r.emsscoem;
        commit;
    end loop;
end; 
/
