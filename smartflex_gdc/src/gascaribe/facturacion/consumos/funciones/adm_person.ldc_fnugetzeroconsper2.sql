CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETZEROCONSPER2" 
(
    inuSesu in servsusc.sesunuse%type,
    inuAno  in NUMBER,
    inuMes  in NUMBER
)
RETURN number
/*****************************************************************
Propiedad intelectual de LDC (c).

Unidad         : ldc_fnuGetZeroConsPer2
Descripción    : retorna el número de periodos en 0, desde la fecha actual hasta
                 el año mes ingresados como parámetros
                 29-04-2015 -> SE CREA ESTA SEGUNDA FUNCION "COPIA" de ldc_fnuGetZeroConsPer pero TENIENDO EN CUENTA SOLO LOS METODOS 4

Autor Original         : Carlos Alberto Ramírez Herrera (Arquitecsoft)
Autor Copia            : Francisco Romero Romero (Ludycom S.A.)
Fecha                  : 23-07-2013
Fecha Copia            : 29-04-2015

Parametros         Descripcion
============  ===================


Historia de Modificaciones


******************************************************************/
IS

    CURSOR cuGetConsTot
    IS
        SELECT  cosspecs,cosssesu, sum(cosscoca)
        FROM    open.conssesu,open.perifact
        WHERE   cosspefa = pefacodi
        AND     ((pefaano = inuAno AND pefames <= inuMes)or(pefaano < inuAno))
        AND     cosssesu = inuSesu
        AND     cossmecc = 4
        GROUP BY cosspecs,cosssesu
        ORDER BY cosspecs desc;

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
--{

    pkErrors.Push ('ldc_fnuGetZeroConsPer2');

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
--}
END ldc_fnuGetZeroConsPer2;

/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETZEROCONSPER2', 'ADM_PERSON');
END;
/