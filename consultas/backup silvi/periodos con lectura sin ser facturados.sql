select pefacodi , pefames, pefaano , pefafimo , pefaffmo , pefacicl ,EMPRESA
from perifact pf
INNER JOIN CICLO_FACTURACION ON PEFACICL = CICLO
where not exists ( select null from procejec p  where p.prejcope = pf.pefacodi  and prejprog ='FGCA' AND prejespr = 'T'  )
and EMPRESA= 'GDCA' 
and  pf.pefaffmo >= '09/01/2026'
and  exists ( select null from procejec p3  where p3.prejcope = pf.pefacodi  and prejprog ='FCRI' AND prejespr = 'T'  )
and exists ( select null from procejec p2 , perifact pf2 
            where pf2.pefacodi= p2.prejcope 
            and  pf2.pefaffmo < pf.pefafimo 
            and pf.pefacicl= pf2.pefacicl
            and pf2.pefafimo = (select max( pf3.pefafimo)
                                from  perifact pf3 where pf2.pefacicl= pf3.pefacicl
                               and pf3.pefacodi < pf.pefacodi and  pf3.pefaffmo <  pf.pefaffmo)
            and p2.prejprog ='FGCC' 
            AND p2.prejespr = 'T'      )
