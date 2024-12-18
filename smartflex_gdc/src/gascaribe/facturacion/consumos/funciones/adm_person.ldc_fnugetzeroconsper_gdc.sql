CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETZEROCONSPER_GDC" 
(
    inuSesu in servsusc.sesunuse%type,
    inuAno  in NUMBER,
    inuMes  in NUMBER
)
RETURN number
/*****************************************************************
Propiedad intelectual de LDC (c).

Unidad         : fnuGetZeroConsPer
Descripcion    : retorna el numero de periodos en 0, desde la fecha actual hasta
                 el a?o mes ingresados como parametros

Autor          : Carlos Alberto Ramirez Herrera
Fecha          : 23-07-2013

Parametros         Descripcion
============	===================


Historia de Modificaciones

12/08/2015  alvaroez
se modifica el cursor para consultar solamente los productos tipo GAS

17/10/2013  carlosr
Se modifica para que traer los peridos ordenados y para que cuente los consumos
a partir del de la fecha final.

23-07-2013  carlosr
Creacion

******************************************************************/
IS
    CURSOR cuGetConsTot
    IS

/*        SELECT  cosspefa,cosssesu, sum(cosscoca)
        FROM    open.conssesu, open.perifact
        WHERE   cosspefa = pefacodi
        AND     ((pefaano = inuAno AND pefames <= inuMes)or(pefaano < inuAno))
        AND     cosssesu = inuSesu
        GROUP BY cosspefa, cosssesu
        ORDER BY cosspefa desc;*/

--Alvaroez: se modifica el cursor para consultar solamente los productos tipo GAS
        SELECT  cosspefa,cosssesu, sum(cosscoca)
        FROM    open.conssesu A, open.perifact B, OPEN.servsusc ss
        WHERE   A.cosspefa = B.pefacodi
        AND     A.COSSSESU = SS.SESUNUSE
        AND     ((B.pefaano = inuAno AND B.pefames <= inuMes)or(B.pefaano < inuAno))
        AND     SS.SESUSERV = 7014
        AND     A.cosssesu = inuSesu
        GROUP BY A.cosspefa, A.cosssesu
        ORDER BY A.cosspefa desc;

    type tyrcData IS record
    (
         cosspefa   conssesu.cosspefa%type,
         cosssesu   conssesu.cosssesu%type,
         cosscoca   conssesu.cosscoca%type
    );

    type tytbData IS table of tyrcData index BY binary_integer;

    tbData    tytbData;

    -- Variable para mensajes de Error
    sbErrMsg    ge_error_log.description%type;

    nuIndex     number;

    nuCont      number := 0;

BEGIN
    pkErrors.Push ('ldc_fnuGetZeroConsPer_gdc');

    if(cuGetConsTot%isopen) then
            close cuGetConsTot;
    end if;

    open    cuGetConsTot;
    fetch   cuGetConsTot bulk collect INTO tbData;
    close   cuGetConsTot;

    nuIndex := tbData.first;

    loop
        exit when nuIndex IS null;
        if(tbData(nuIndex).cosscoca = 0)then
            nuCont := nuCont+1;
        else
            pkErrors.Pop;
            return nuCont;
        end if;
        nuIndex := tbData.next(nuIndex);
    end loop;

    pkErrors.Pop;

    return nuCont;

EXCEPTION
    when LOGIN_DENIED then
        if(cuGetConsTot%isopen) then
            close cuGetConsTot;
        end if;
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        -- Error Oracle nivel dos
        if(cuGetConsTot%isopen) then
            close cuGetConsTot;
        end if;
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        if(cuGetConsTot%isopen) then
            close cuGetConsTot;
        end if;
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);

END ldc_fnuGetZeroConsPer_gdc;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETZEROCONSPER_GDC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FNUGETZEROCONSPER_GDC TO REXEREPORTES;
/
