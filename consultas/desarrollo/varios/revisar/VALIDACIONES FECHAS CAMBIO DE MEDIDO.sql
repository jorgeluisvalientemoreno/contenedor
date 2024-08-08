 select
                LEEMFELE FECHALECTURA,
                LEEMLETO  LECTURAACTUAL
        FROM    open.vw_cmprodconsumptions, open.LECTELME, open.PERIFACT
            /*+ CM_BCConsumosPorServSusc.Childs_ConsByProduct */
        WHERE   LECTELME.LEEMTCON = 1
        AND     LECTELME.LEEMSESU = vw_cmprodconsumptions.cosssesu
        AND     LECTELME.LEEMPECS = vw_cmprodconsumptions.COSSPECS
        AND     vw_cmprodconsumptions.cosssesu = 1120355
        and     LECTELME.leemelme = 762025
        and     cossmecc = 1
        and     LECTELME.leemclec = 'F'
        AND     pecsfecf >= pefafimo
        AND     pecsfecf <= pefaffmo
        AND     PERIFACT.pefacicl = vw_cmprodconsumptions.pecscico
        ORDER BY pecsfeci desc, cossfere desc;
        
 select trunc(leemfele)
        from open.lectelme
        where leemsesu = 1120355
        and leemelme = 762025
        AND leemclec = 'F'
        and trunc(leemfele) > '22/05/2015'
        and rownum < 2;
        




      
     
