--las lecturas se generan en cmlec
--se obtiene el periodo previo
select cm_bcreglect.fnugetprevconsperiod(inupericose => 89244,--periodo de consumo actual,
                                               idtinitialdate => '21/05/2020',--:idtinitialdate,
                                               inuciclcons => 1313--:inuciclcons
                                               ) from dual;
---se obtiene el periodo de facturación del periodo previo
select  pkbcperifact.fnubillperbyconsper(inuconsper => 88881) from dual ; -- se pasa el periodo de consumo obtentido en funcion anterior                                               

SELECT /*+ index(procejec IX_PREJ_COPE_PROG) */
                 *
            FROM   PROCEJEC
                   /*+ CM_BCChangeMeter.fblCriticIsClosed SAO179784 */
            WHERE  PROCEJEC.PREJPROG = 'FCRI'
              AND  PROCEJEC.PREJCOPE = 89629; --periodo de facturación consulta anterior
