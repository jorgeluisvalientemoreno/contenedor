select pefacodi, 
       pefaano, 
       pefames, 
       pefacicl, 
       c.cicldesc,
       (select count(distinct(factsusc))
        from open.factura 
        where factprog = 6
        and   factpefa = pefacodi) TOTAL_FGCC,        
       (select count(1)
        from  open.ed_document
        inner join open.cupon on docucodi = cupodocu
        where docupefa = pefacodi 
        and   cupoprog = 'FIDF'
        and   docutido = 66) TOTAL_FIDF      
from open.perifact p
inner join open.ciclo c on p.pefacicl = c.ciclcodi 
where pefacodi in (select esprpefa
                   from open.estaprog
                   where esprprog like 'FIDF%'
                   and   esprfein >= trunc(sysdate-60)
                   and   esprpefa in (select regexp_substr(:PERIODOS,'[^,]+', 1, level) from dual
                    connect by regexp_substr(:PERIODOS, '[^,]+', 1, level) is not null))