SELECT perifact.pefacodi
    FROM perifact, ldc_pecofact
    WHERE perifact.pefacicl =2201
     AND perifact.pefaactu = 'S'
     AND ldc_pecofact.pcfapefa = perifact.pefacodi
     AND ldc_pecofact.pcfaesta = 'T'
     AND  NOT EXISTS ( SELECT 1
                        FROM periodo_factelect
                        WHERE periodo_factelect.periodo = perifact.pefacodi
                       );
                       
select * from ldc_pecofact l where l.pcfapefa= 110952 ;
SELECT * FROM periodo_factelect WHERE periodo_factelect.periodo=110952;