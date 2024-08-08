    select perifact.pefacodi
     from perifact, ldc_pecofact
     where perifact.pefacicl = 2201
       and perifact.pefaactu = 'S'
       and ldc_pecofact.pcfapefa = perifact.pefacodi
       and ldc_pecofact.pcfaesta = 'T'
       and not exists
     (select 1
              from periodo_factelect
             where periodo_factelect.periodo = perifact.pefacodi)
