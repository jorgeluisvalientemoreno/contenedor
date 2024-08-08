select *
from PERSONALIZACIONES.lote_fact_electronica;

SELECT perifact.pefacodi,
               perifact.pefaano,
               perifact.pefames,
               perifact.pefacicl
        FROM perifact, ldc_pecofact
        WHERE perifact.pefaactu = 'S'
         AND  ldc_pecofact.pcfapefa = perifact.pefacodi
         AND NOT EXISTS ( SELECT 1
                          FROM lote_fact_electronica
                          WHERE lote_fact_electronica.periodo_facturacion = ldc_pecofact.pcfapefa
                                AND (lote_fact_electronica.flag_terminado = 'S'
                                OR lote_fact_electronica.intentos >= 4));