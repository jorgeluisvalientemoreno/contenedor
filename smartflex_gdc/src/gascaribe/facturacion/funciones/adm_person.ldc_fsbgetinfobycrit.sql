CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBGETINFOBYCRIT" 
(
    inutacocons ta_tariconc.tacocons%type,
    inucotcdect ta_conftaco.cotcdect%type,
    inuType     number
)
RETURN ta_tariconc.tacocr01%type
/*****************************************************************
Propiedad intelectual de GDO (c).

Unidad         : ldc_fsbGetInfoByCrit
Descripcion    : Retorna el valor del campo de la entidad ta_taricopc, dependiendo
                 si el criterio es Mercado Relevante, Categoria o Subcategoria
Autor          : Carlos Alberto Ramirez Herrera
Fecha          : 05-08-2013

Parametros         Descripcion
============	===================
    inutacocons   Id de la tarifa
    inuType       Tipo de criterio
                      1 - Mercado Relevante
                      2 - Categoria
                      3 - SubCategoria


Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
29-10-2013   carlosr
Se modifica para que devuelva la posicion exacamente segun el valor del criterio

05-08-2013   carlosr  Creacion
12-11-2013   cdominguez Se cambia la referencia a la tabla TA_TARICOPR pop
                        la tabla TA_TARICONC
-----------  -------------------    -------------------------------------

******************************************************************/
IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

    type tyrcData IS record
    (
        coctdecb ta_confcrta.coctdect%type,
        coctprio ta_confcrta.coctdecb%type
    );

    type tytbData IS table of tyrcData index BY binary_integer;

    tbData          tytbData;
    cuNumbOfCrit    number;
    nuPos           number := 0;

    CURSOR cuFieldNumber --- Con este se obtiene la prioridad
    IS
        SELECT  coctdecb,coctprio
        FROM    open.ta_confcrta
        WHERE   coctdect = inucotcdect
        AND     coctdecb = decode(inuType,1,22,2,7,3,8) -- Prioridad segun el tipo
        ORDER BY coctprio asc;

    rcRecord    ta_tariconc%rowtype;


BEGIN                         -- ge_module

    pkErrors.push('ldc_fsbGetInfoByCrit');

    rcRecord := pktblta_tariconc.frcgetrecord(inutacocons);

    open  cuFieldNumber;
    fetch cuFieldNumber bulk collect INTO tbData;
    close cuFieldNumber;

    nuPos :=  tbData(1).coctprio; -- por la configuracion solo deberia traer un registro

    if (nuPos = 1) then
        pkErrors.pop;
        return rcRecord.tacocr01;
    elsif (nuPos = 2) then
        pkErrors.pop;
        return rcRecord.tacocr02;
    elsif (nuPos = 3) then
        pkErrors.pop;
        return rcRecord.tacocr03;
    elsif (nuPos = 4) then
        pkErrors.pop;
        return rcRecord.tacocr04;
    elsif (nuPos = 5) then
        pkErrors.pop;
        return rcRecord.tacocr05;
    elsif (nuPos = 6) then
        pkErrors.pop;
        return rcRecord.tacocr06;
    elsif (nuPos = 7) then
        pkErrors.pop;
        return rcRecord.tacocr07;
    elsif (nuPos = 8) then
        pkErrors.pop;
        return rcRecord.tacocr08;
    elsif (nuPos = 9) then
        pkErrors.pop;
        return rcRecord.tacocr09;
    elsif (nuPos = 10) then
        pkErrors.pop;
        return rcRecord.tacocr10;
    elsif (nuPos = 11) then
        pkErrors.pop;
        return rcRecord.tacocr11;
    elsif (nuPos = 12) then
        pkErrors.pop;
        return rcRecord.tacocr12;
    elsif (nuPos = 13) then
        pkErrors.pop;
        return rcRecord.tacocr13;
    elsif (nuPos = 14) then
        pkErrors.pop;
        return rcRecord.tacocr14;
    elsif (nuPos = 15) then
        pkErrors.pop;
        return rcRecord.tacocr15;
    elsif (nuPos = 16) then
        pkErrors.pop;
        return rcRecord.tacocr16;
    end if;

    pkErrors.pop;
    return null;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        pkErrors.pop;
        return '';
    when others then
        Errors.setError;
        pkErrors.pop;
        return '';
END ldc_fsbGetInfoByCrit;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBGETINFOBYCRIT', 'ADM_PERSON');
END;
/
