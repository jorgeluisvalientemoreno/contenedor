CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_OSSPKEVALUAMETODOSAVC
AS
    /**********************************************************************
    Propiedad intelectual de Peti (c).

    Unidad          : LDC_OSSPkEvaluaMetodosAVC
    Autor           : Jhon Jairo Soto
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        1. DISMINUCION CONSUMO - PROMEDIO
                        2. AUMENTO CONSUMO - PROMEDIO
                        3. DISMINUCION CONSUMO - MES ANTERIOR
                        4. AUMENTO CONSUMO - MES ANTERIOR
                        5. CONSUMO CERO
                        6. CONSUMO MINIMO
                        7. CONSUMO MAXIMO
                        8. METODO PREDICTIVO
                        9. CONSUMO CERO NUEVO

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================
        25/02/2015      Mmejia.NC3401       Modificacion <<fsbRutaLectura>>
        06/02/2015      Mmejia.NC3401       Modificacion <<fsbRutaLectura>>
        29/07/2013        JSOTO             Se modifica para que el parametro de consumo cero
                                            tenga en cuenta el numero de meses a revisar segun el parametro
                                            sin contar el consumo actual()
        18/11/2015       jjjm               se colococa en comentario la funcion fblvalidaotrasordenes para el metodo de calcuclo 5 y 9
    **********************************************************************/

FUNCTION    fsbVersion return varchar2;

  PROCEDURE prEstadporProducto
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date,
        onuAverageConsump   out number,
        onuVarianceConsump  out number,
        onuStandDevConsump  out number,
        onuStandDevConsump7  out number,
        onuCountConsump     out number,
        onuSumTotalConsump  out number,
        onuConsActual out number,
        onuConsAnterior out number
    );


  procedure prDatosPeriodo(inuPeriodo      in pericose.pecscons%type, --Codigo del periodo
                           inuproduct in pr_product.product_id%type, --Numero del producto
                           odtFechaInicial out pericose.pecsfeci%type, --Fecha inicial del Periodo
                           odtFechaFinal   out pericose.pecsfecf%type, -- Fecha final del periodo
                           onuobselect out lectelme.leemoble%type
                           );
  function fblStateOrders(isbParametro    in varchar2, -- Nombre de la variable o parametro
                          isbIndica       in varchar2, -- S para valor string,N para numerico
                          idtFechaInicial in date, -- Fecha inicial del periodo
                          idtFechaFinal   in date,
                          nuNumeroservicio in servsusc.sesunuse%type -- Fecha final del periodo
                          ) return boolean;

    FUNCTION fnuEvalMetodo1
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date
    ) return number;
    FUNCTION fnuEvalMetodo2
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date
    ) return number;
    FUNCTION fnuEvalMetodo3
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date,
        inuCategori in servsusc.sesucate%type
    ) return number;

    FUNCTION fnuEvalMetodo4
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date,
        inuCategori in servsusc.sesucate%type
    ) return number;

    FUNCTION fnuEvalMetodo6
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date
    ) return number;

   FUNCTION fnuEvalMetodo7
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date
    ) return number;

   FUNCTION fnuEvalMetodo8
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date
    ) return number;

    FUNCTION fnuEvalMetodo5
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date
    ) return number;

  FUNCTION fnuHistConsumo
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date,
        innumConsumo in number
    ) return number;

function fsbRutaLectura(nuContrato   suscripc.susccodi%type)
    return number;

function fsbNumMedidor(nuContrato   suscripc.susccodi%type)
    return Varchar2;

  function fblValidaOtrasOrdenes(nuproducto servsusc.sesunuse%type
                          ) return boolean;

   FUNCTION fnuEvalMetodo9
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date
    ) return number;

END LDC_OSSPKEVALUAMETODOSAVC;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_OSSPKEVALUAMETODOSAVC
IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).

    Unidad          : LDC_OSSPkEvaluaMetodosAVC
    Autor           : Jhon Jairo Soto
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        1. DISMINUCION CONSUMO - PROMEDIO
                        2. AUMENTO CONSUMO - PROMEDIO
                        3. DISMINUCION CONSUMO - MES ANTERIOR
                        4. AUMENTO CONSUMO - MES ANTERIOR
                        5. CONSUMO CERO
                        6. CONSUMO MINIMO
                        7. CONSUMO MAXIMO
                        8. METODO PREDICTIVO
                        9. CONSUMO CERO NUEVO

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================
        25/02/2015      Mmejia.NC3401       Modificacion <<fsbRutaLectura>>
        06/02/2015      Mmejia.NC3401       Modificacion <<fsbRutaLectura>>
        29/07/2013        JSOTO             Se modifica para que el parametro de consumo cero
                                            tenga en cuenta el numero de meses a revisar segun el parametro
                                            sin contar el consumo actual()
    **********************************************************************/

       csbVersion  CONSTANT VARCHAR2(250)  := 'LDC_OSSPkEvaluaMetodosAVC - ADC_JJSU_NC_561_2';

   FUNCTION fsbVersion return varchar2 IS
    BEGIN
        return csbVersion;
    END;

  PROCEDURE prEstadporProducto
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date,
        onuAverageConsump   out number,
        onuVarianceConsump  out number,
        onuStandDevConsump  out number,
        onuStandDevConsump7  out number,
        onuCountConsump     out number,
        onuSumTotalConsump  out number,
        onuConsActual out number,
        onuConsAnterior out number
    )
    is
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  RETORNA DATOS ESTADISTICOS PARA EL PERIODO

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================
        15/11/2013       Jsoto              Se modifica para que el consumo promedio retornado
                                            sea el mismo calculado por el aplicativo smartflex
                                            para la diferencia de lectura del periodo actual.
    **********************************************************************/
     dtFechaPerIni date;
     dtFechaPerFin date;
     nuContador number;
     nuConsumo1 number :=0;
     nuConsumo2 number :=0;
     nuConsumo3 number :=0;
     nuConsumo4 number :=0;
     nuConsumo5 number :=0;
     vnuConConSA   number;
     vnuCoPrSiAc   number;
     vnuDeEsSiAc   number;
     vnuConConCA   number;
     vnuCoPrCoAc   number;
     vnuDeEsCoAc   number;
     vnuContador   number;


    cursor cuConsumos (innuproduct in servsusc.sesunuse%type,dtFechaFinal in date) is
         select subtabla.pecsfeci,subtabla.cosspecs, subtabla.consumo
         from
          (SELECT
                pericose.pecsfeci,conssesu.cosspecs, sum(conssesu.cosscoca) consumo
           FROM open.conssesu, open.pericose
           WHERE conssesu.cosssesu = innuProduct
             AND pericose.pecsfeci <= dtFechaFinal
             AND pericose.pecscons = conssesu.cosspecs
             AND conssesu.cossmecc <> 4
           group by pericose.pecsfeci,conssesu.cosspecs
           order by 1 desc
           ) subtabla
          where ceil(rownum/8) = 1;

         RcConsumos  cuConsumos%rowtype;

    BEGIN
      dtFechaPerFin := add_months(dtFechaIni, +1);
      nuContador := 1;
      onuConsActual := 0;
      onuConsAnterior :=0;
      nuConsumo5 := 0;
      nuConsumo4 := 0;
      nuConsumo3 := 0;
      nuConsumo2 := 0;
      nuConsumo1 := 0;

            -- Obtengo el consumo actual y  los ultimos seis consumos para el periodo evaluado
            open cuConsumos(inuproduct, dtFechaPerFin);
            loop
                fetch cuConsumos
                into rcConsumos;
                if nuContador = 1 then
                    onuConsActual := nvl(rcConsumos.consumo,0);
                    onuAverageConsump := open.pkbchicoprpm.getavgconsumpbyproduct(inuProduct,1,rcConsumos.cosspecs);
                elsif nuContador = 2 then
                    onuConsAnterior := nvl(rcConsumos.consumo,0);
                elsif nuContador = 3 then
                     nuConsumo5 := nvl(rcConsumos.consumo,0);
                elsif nuContador = 4 then
                     nuConsumo4 := nvl(rcConsumos.consumo,0);
                elsif nuContador = 5 then
                     nuConsumo3 := nvl(rcConsumos.consumo,0);
                elsif nuContador = 6 then
                     nuConsumo2 := nvl(rcConsumos.consumo,0);
                elsif nuContador = 7 then
                     nuConsumo1 := nvl(rcConsumos.consumo,0); -- Consumo mas antiguo para el periodo evaluado
                end if;
                exit when nucontador = 7;
                nuContador := nuContador+1;
                rcConsumos.consumo := 0;
            end loop;


        vnuCoPrSiAc := 0;   -- Consumo Promedio sin el consumo actual
        vnuDeEsSiAc := 0;   -- Desviacion Estandar sin el consumo actual
        select decode(nuConsumo1,0,0,1)+decode(nuConsumo2,0,0,1)+
          decode(nuConsumo3,0,0,1)+decode(nuConsumo4,0,0,1)+
          decode(nuConsumo5,0,0,1)+decode(onuConsAnterior,0,0,1)
          into vnuConConSA
        from dual;
        onuCountConsump := vnuConConSA ;  -- Contador de consumos con valor mayor a cero sin incluir el actual

       if onuAverageConsump is null then
          onuAverageConsump := 0;
       end if;

        if vnuConConSA > 0 then
          vnuCoPrSiAc := (nuConsumo1+nuConsumo2+nuConsumo3+
            nuConsumo4+nuConsumo5+onuConsAnterior) / 6; --vnuConConSA; NC 1576 el consumo promedio incluira los ceros
        end if;

      onuSumTotalConsump := (nuConsumo1+nuConsumo2+nuConsumo3+
            nuConsumo4+nuConsumo5+onuConsAnterior);

        if vnuConConSA > 1 then
          vnuDeEsSiAc := power((power(nuConsumo1-vnuCoPrSiAc,2)+
            power(nuConsumo2-vnuCoPrSiAc,2)+power(nuConsumo3-vnuCoPrSiAc,2)+
            power(nuConsumo4-vnuCoPrSiAc,2)+power(nuConsumo5-vnuCoPrSiAc,2)+
            power(onuConsAnterior-vnuCoPrSiAc,2))/(5),0.5);--(vnuConConSA-1),0.5);Desviaci?n estandar incluya los consumos con cero
            onuStandDevConsump := vnuDeEsSiAc;
        end if;

        vnuCoPrCoAc := 0;  -- Consumo promedio incluyendo el consumo actual
        vnuDeEsCoAc := 0;  -- Desviacion estandar incluyendo el consumo actual
        select decode(nuConsumo1,0,0,1)+decode(nuConsumo2,0,0,1)+
          decode(nuConsumo3,0,0,1)+decode(nuConsumo4,0,0,1)+
          decode(nuConsumo5,0,0,1)+decode(onuConsAnterior,0,0,1)+
          decode(onuConsActual,0,0,1) into vnuConConCA
        from dual;
        if vnuConConCA > 0 then
          vnuCoPrCoAc := (nuConsumo1+nuConsumo2+nuConsumo3+
            nuConsumo4+nuConsumo5+onuConsAnterior+onuConsActual)/vnuConConCA;
        end if;
        if vnuConConCA > 1 then
          vnuDeEsCoAc := power((power(nuConsumo1-vnuCoPrCoAc,2)+
            power(nuConsumo2-vnuCoPrCoAc,2)+power(nuConsumo3-vnuCoPrCoAc,2)+
            power(nuConsumo4-vnuCoPrCoAc,2)+power(nuConsumo5-vnuCoPrCoAc,2)+
            power(onuConsAnterior-vnuCoPrCoAc,2)+
            power(onuConsActual-vnuCoPrCoAc,2))/(vnuConConCA-1),0.5);
            onuStandDevConsump7 := vnuDeEsCoAc;
        end if;

    EXCEPTION
       when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END prEstadporProducto;

  procedure prDatosPeriodo(inuPeriodo      in pericose.pecscons%type, --Codigo del periodo
                           inuproduct in pr_product.product_id%type, --Numero del producto
                           odtFechaInicial out pericose.pecsfeci%type, --Fecha inicial del Periodo
                           odtFechaFinal   out pericose.pecsfecf%type, -- Fecha final del periodo
                           onuobselect out lectelme.leemoble%type
                           ) is
    cnuNO_DATA_FOUND constant number := -1; --Mensaje de error
  BEGIN
    --  {
    pkErrors.Push('LDC_OSSPkEvaluaMetodosAvc.prDatosPeriodo');
    SELECT pecsfeci, pecsfecf
      INTO odtFechaInicial, odtFechaFinal
      FROM pericose
     WHERE pecscons = inuPeriodo;

    begin
     select nvl(a.leemoble,-1)
     into onuobselect
     from open.lectelme a
     where a.leempecs = inuPeriodo
     and a.leemclec = 'F'
     and a.leemsesu = inuproduct
     and rownum = 1;
     /*and trunc(a.leemfele) = (select trunc(max(b.leemfele))
                            from open.lectelme b
                            where b.leempecs = inuPeriodo
                            and b.leemclec = 'F'
                            and a.leemsesu = b.leemsesu)
     order by a.leemfele desc;*/
    exception
     when others then
     onuobselect := -1;
    end;

    pkErrors.pop;
  EXCEPTION
    when no_data_found then
      pkErrors.SetErrorCode(cnuNO_DATA_FOUND);
      raise LOGIN_DENIED;
  END prDatosPeriodo;

/******************************************************************************
*******************************************************************************/

  function fblStateOrders(isbParametro    in varchar2, -- Nombre de la variable o parametro
                          isbIndica       in varchar2, -- S para valor string,N para numerico
                          idtFechaInicial in date, -- Fecha inicial del periodo
                          idtFechaFinal   in date, -- Fecha final del periodo
                          nuNumeroservicio in servsusc.sesunuse%type
                          ) return boolean is
    ------------
    -- Variables
    ------------
    nuValorNumerico ld_parameter.numeric_value%type; -- Valor numerico del parametro
    sbValorCaracter ld_parameter.value_chain%type; -- Valor caracter del parametro
    nuContador      number(4); -- Contador de ordenes de un motivo
    cnuCero constant number := 0; -- Valor minimo de ordenes
  BEGIN
    --  {
    pkErrors.Push('LDC_OSSPkEvaluaMetodosAvc.fblStateOrders');


    sbValorCaracter := Dald_parameter.fsbGetValue_chain(isbParametro,null);-- Obtenemos parametros


            SELECT nvl(count(*), 0)
             INTO nuContador
            from ge_causal, or_order, or_order_activity
            where ge_causal.causal_id = or_order.causal_id
            and ge_causal.class_causal_id = 1
            and or_order_activity.order_id = or_order.order_id
            and or_order.task_type_id in (select to_number(column_value)
                                From table(ldc_boutilities.splitstrings(sbValorCaracter, ',')))
            and or_order.legalization_date between idtFechaInicial and idtFechaFinal
            and or_order_activity.product_id = nuNumeroServicio;
             if (nuContador > cnuCero) then
                pkErrors.pop;
                return(false);
             end if;
            pkErrors.pop;
            return(true);
  Exception
       when zero_divide then
          return false;
       when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
  END fblStateOrders;

/******************************************************************************
*******************************************************************************/

  FUNCTION fnuEvalMetodo1
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  1. DISMINUCION CONSUMO - PROMEDIO

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     dtFechaFin date;
     dtFechaPerIni date;
     dtFechaInicial date;
     dtFechaFinal date;
     nuValorNumerico number;
     nuDatoCons number;
     nuConsEsta number;
     Cv number;
     Ko number;
     blexisteOrdenes boolean;
     blexisteTipoTrab   boolean;
     nuContador  number;


    -- Consumos facturados durante los periodos de consumo registrados antes de la fecha de la variable idtFechaInicial
     cursor cuConsumosValidos(inuNumeroServicio in servsusc.sesunuse%type, idtFechaInicial in pericose.pecsfeci%type) is
         select subtabla.pecsfeci,subtabla.periodo, subtabla.consumo from
          ( SELECT
              pericose.pecsfeci,conssesu.cosspecs periodo, sum(conssesu.cosscoca) consumo
            FROM open.conssesu, open.pericose
            WHERE conssesu.cosssesu = inuNumeroServicio
            AND pericose.pecsfeci <= idtFechaInicial
            AND pericose.pecscons = conssesu.cosspecs
            AND conssesu.cossmecc <> 4
            group by pericose.pecsfeci,conssesu.cosspecs
            order by 1 desc
          ) subtabla
         where ceil(rownum/4) = 1;

        blConsumoValido   boolean; --Verdadero si el consumo es valido
        rcConsumosValidos cuConsumosValidos%rowtype; -- Registro del cursor
        onuobselect lectelme.leemoble%type;


    BEGIN

      blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;

      dtFechaPerIni := add_months(dtFechaIni, -1);
      nuContador    := 1;

          open cuConsumosValidos(inuproduct, dtFechaIni);
            loop
                fetch cuConsumosValidos
                into rcConsumosValidos;
                exit when cuConsumosValidos%notfound or cuConsumosValidos%notfound is null;

                   prDatosPeriodo(rcConsumosValidos.Periodo,
                                  inuproduct,
                                  dtFechaInicial,
                                  dtFechaFinal,
                                  onuobselect);
                   blexisteTipoTrab := fblStateOrders('TIPO_TRAB_CAMBIO_CATEGORIA',
                                                      'N',
                                                      dtFechaInicial,
                                                      dtFechaFinal+(Dald_parameter.fnuGetNumeric_Value('DIAS_ADICIONALES_AVC')),
                                                      inuproduct);
                   if not(blexisteTipoTrab) then
                    return 1;
                   end if;

               nuContador := nuContador + 1 ;
               exit when nuContador = 3;
            end loop;
          close cuConsumosValidos;

      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto

     nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_DISM_PERM_F1');-- Obtenemos parametros

     if onuCountConsump > 0 then
        nuDatoCons := (onuSumTotalConsump/onuCountConsump);
        nuConsEsta := ((onuConsActual-nuDatoCons)/onuStandDevConsump);  -- Obtiene consumo estandarizado (gasplus)

       Cv := onuStandDevConsump / onuAverageConsump;
       Ko := (nuValorNumerico / 100) / Cv;


        if nuConsEsta < Ko then
          return 0;   -- Generar Orden
        else
          return 1;
        end if;
     end if;

     return 1;

    EXCEPTION
       when zero_divide then
          return 1;
       when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo1;
/******************************************************************************
*******************************************************************************/
    FUNCTION fnuEvalMetodo2
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni date
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        2. AUMENTO CONSUMO - PROMEDIO

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuDatoCons number;
     nuConsEsta number;
     dtFechaPerIni date;
     dtFechaPerFin date;
     dtFechaInicial date;
     dtFechaFinal date;
     Cv number;
     Ko number;

     blexisteOrdenes boolean;
     blexisteTipoTrab boolean;
     nuContador number;

     -- Consumos facturados durante los periodos de consumo registrados antes de la fecha de la variable idtFechaInicial
     cursor cuConsumosValidos(inuNumeroServicio in servsusc.sesunuse%type, idtFechaInicial in pericose.pecsfeci%type) is
         select subtabla.pecsfeci,subtabla.periodo, subtabla.consumo from
          ( SELECT
              pericose.pecsfeci,conssesu.cosspecs periodo, sum(conssesu.cosscoca) consumo
            FROM open.conssesu, open.pericose
            WHERE conssesu.cosssesu = inuNumeroServicio
            AND pericose.pecsfeci <= idtFechaInicial
            AND pericose.pecscons = conssesu.cosspecs
            AND conssesu.cossmecc <> 4
            group by pericose.pecsfeci,conssesu.cosspecs
            order by 1 desc
          ) subtabla
         where ceil(rownum/4) = 1;

        blConsumoValido   boolean; --Verdadero si el consumo es valido
        rcConsumosValidos cuConsumosValidos%rowtype; -- Registro del cursor
        onuobselect lectelme.leemoble%type;

    BEGIN

      blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;

      dtFechaPerIni := add_months(dtFechaIni, -1);
      nuContador    := 1;

          open cuConsumosValidos(inuproduct, dtFechaIni);
            loop
                fetch cuConsumosValidos
                into rcConsumosValidos;
                exit when cuConsumosValidos%notfound or cuConsumosValidos%notfound is null;

                   prDatosPeriodo(rcConsumosValidos.Periodo,
                                  inuproduct,
                                  dtFechaInicial,
                                  dtFechaFinal,
                                  onuobselect);
                   blexisteTipoTrab := fblStateOrders('TIPO_TRAB_CAMBIO_CATEGORIA',
                                                      'N',
                                                      dtFechaInicial,
                                                      dtFechaFinal+(Dald_parameter.fnuGetNumeric_Value('DIAS_ADICIONALES_AVC')),
                                                      inuproduct);
                   if not(blexisteTipoTrab) then
                    return 1;
                   end if;

               nuContador := nuContador + 1 ;
               exit when nuContador = 3;
            end loop;
          close cuConsumosValidos;


      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto


     nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_AUME_PERM_F2');-- Obtenemos parametros

     if onuCountConsump > 0 then
        nuDatoCons := (onuSumTotalConsump/onuCountConsump);
        nuConsEsta := ((onuConsActual-nuDatoCons)/onuStandDevConsump);  -- Obtiene consumo estandarizado (gasplus)

       Cv := onuStandDevConsump / onuAverageConsump;
       Ko := (nuValorNumerico / 100) / Cv;

        if nuConsEsta > Ko then
          return 0;   -- Generar Orden
        else
          return 1;
        end if;
     end if;

     return 1;

    EXCEPTION
       when zero_divide then
          return 1;
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo2;
/******************************************************************************
*******************************************************************************/
    FUNCTION fnuEvalMetodo3
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date,
        inuCategori in servsusc.sesucate%type
    ) return number
    IS
        /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        3. DISMINUCION CONSUMO - MES ANTERIOR
       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuDatoCons number;
     nuConsEsta number;
     Cv number;
     Ko number;
     Ko2 number;
     Kya           number;
     Kya1          number;
     vp            number;
     dtFechaPerIni date;
     dtFechaInicial date;
     dtFechaFinal date;
     blexisteOrdenes boolean;
     blexisteTipoTrab boolean;
     nuContador number;

     -- Consumos facturados durante los periodos de consumo registrados antes de la fecha de la variable idtFechaInicial
     cursor cuConsumosValidos(inuNumeroServicio in servsusc.sesunuse%type, idtFechaInicial in pericose.pecsfeci%type) is
         select subtabla.pecsfeci,subtabla.periodo, subtabla.consumo from
          ( SELECT
              pericose.pecsfeci,conssesu.cosspecs periodo, sum(conssesu.cosscoca) consumo
            FROM open.conssesu, open.pericose
            WHERE conssesu.cosssesu = inuNumeroServicio
            AND pericose.pecsfeci <= idtFechaInicial
            AND pericose.pecscons = conssesu.cosspecs
            AND conssesu.cossmecc <> 4
            group by pericose.pecsfeci,conssesu.cosspecs
            order by 1 desc
          ) subtabla
         where ceil(rownum/4) = 1;

        blConsumoValido   boolean; --Verdadero si el consumo es valido
        rcConsumosValidos cuConsumosValidos%rowtype; -- Registro del cursor
        onuobselect lectelme.leemoble%type;

    BEGIN

      blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;

      dtFechaPerIni := add_months(dtFechaIni, -1);
      nuContador    := 1;

          open cuConsumosValidos(inuproduct, dtFechaIni);
            loop
                fetch cuConsumosValidos
                into rcConsumosValidos;
                exit when cuConsumosValidos%notfound or cuConsumosValidos%notfound is null;

                   prDatosPeriodo(rcConsumosValidos.Periodo,
                                  inuproduct,
                                  dtFechaInicial,
                                  dtFechaFinal,
                                  onuobselect);
                   blexisteTipoTrab := fblStateOrders('TIPO_TRAB_CAMBIO_CATEGORIA',
                                                      'N',
                                                      dtFechaInicial,
                                                      dtFechaFinal+(Dald_parameter.fnuGetNumeric_Value('DIAS_ADICIONALES_AVC')),
                                                      inuproduct);
                   if not(blexisteTipoTrab) then
                    return 1;
                   end if;

               nuContador := nuContador + 1 ;
               exit when nuContador = 3;
            end loop;
          close cuConsumosValidos;



      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto


        if inucategori = 1 then
            nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_DISM_PERM_F3_RES');-- Obtenemos parametros  para categoria residencial
        else
            nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_DISM_PERM_F3');-- Obtenemos parametros diferente a residencial
        end if;

     if onuCountConsump > 0 then
        nuDatoCons := (onuSumTotalConsump/onuCountConsump);  -- suma de ultimos 6 consumos /  De los ultimos 6 consumos cuantos son diferentes de 0
        nuConsEsta := ((onuConsActual-nuDatoCons)/onuStandDevConsump);  -- Obtiene consumo estandarizado (gasplus)

       Cv := onuStandDevConsump / onuConsAnterior;
       Ko := (nuValorNumerico / 100) / Cv;
       kya := (onuConsActual - onuConsAnterior) /
                  onuStandDevConsump;

        if kya < Ko then
            begin
                  prEstadporProducto(
                        inuProduct,
                        add_months(dtFechaPerIni,-12),
                        onuAverageConsump,
                        onuVarianceConsump,
                        onuStandDevConsump,
                        onuStandDevConsump7,
                        onuCountConsump,
                        onuSumTotalConsump,
                        onuConsActual,
                        onuConsAnterior); -- Obtenemos datos estadisticos del consumo para el producto para el mismo periodo del a?o anterior
                        if onuConsActual = 0 and onuConsAnterior = 0 then
                           return(0);
                        end if;

            exception
                when no_data_found then
                return 0;
            end;
            Cv   := onuStandDevConsump / onuConsAnterior;  -- Consumo6 de hace un a?o
            Ko2  := (nuValorNumerico / 100) / Cv;
            kya1 := (onuConsActual - onuConsAnterior) /
                        onuStandDevConsump;
            if kya1 < Ko2 then
                nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('VARI_PORC_PERM_F3');-- Obtenemos parametros
                vp := abs((kya - kya1) / kya);
             if vp > (nuValorNumerico / 100) then
                return 0;
             else
                return 1;
             end if;
            else
            return 0;
            end if;
        else
         return 1;
        end if;

     end if;

     return 1;

    EXCEPTION
       when zero_divide then
          return 1;
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo3;

/******************************************************************************
*******************************************************************************/
    FUNCTION fnuEvalMetodo4  -- aumento consumo constante
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date,
        inuCategori in servsusc.sesucate%type
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        4. AUMENTO CONSUMO - MES ANTERIOR

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuDatoCons number;
     nuConsEsta number;
     Cv number;
     Ko number;
     Ko2 number;
     Kya           number;
     Kya1          number;
     vp            number;
     dtFechaPerIni date;
     dtFechaInicial date;
     dtFechaFinal date;
     blexisteOrdenes boolean;
     blexisteTipoTrab boolean;
     nuContador number;

     -- Consumos facturados durante los periodos de consumo registrados antes de la fecha de la variable idtFechaInicial
     cursor cuConsumosValidos(inuNumeroServicio in servsusc.sesunuse%type, idtFechaInicial in pericose.pecsfeci%type) is
         select subtabla.pecsfeci,subtabla.periodo, subtabla.consumo from
          ( SELECT
              pericose.pecsfeci,conssesu.cosspecs periodo, sum(conssesu.cosscoca) consumo
            FROM open.conssesu, open.pericose
            WHERE conssesu.cosssesu = inuNumeroServicio
            AND pericose.pecsfeci <= idtFechaInicial
            AND pericose.pecscons = conssesu.cosspecs
            AND conssesu.cossmecc <> 4
            group by pericose.pecsfeci,conssesu.cosspecs
            order by 1 desc
          ) subtabla
         where ceil(rownum/4) = 1;

        blConsumoValido   boolean; --Verdadero si el consumo es valido
        rcConsumosValidos cuConsumosValidos%rowtype; -- Registro del cursor
        onuobselect lectelme.leemoble%type;



    BEGIN

      blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;

      dtFechaPerIni := add_months(dtFechaIni, -1);
      nuContador    := 1;

          open cuConsumosValidos(inuproduct, dtFechaIni);
            loop
                fetch cuConsumosValidos
                into rcConsumosValidos;
                exit when cuConsumosValidos%notfound or cuConsumosValidos%notfound is null;

                   prDatosPeriodo(rcConsumosValidos.Periodo,
                                  inuproduct,
                                  dtFechaInicial,
                                  dtFechaFinal,
                                  onuobselect);
                   blexisteTipoTrab := fblStateOrders('TIPO_TRAB_CAMBIO_CATEGORIA',
                                                      'N',
                                                      dtFechaInicial,
                                                      dtFechaFinal+(Dald_parameter.fnuGetNumeric_Value('DIAS_ADICIONALES_AVC')),
                                                      inuproduct);
                   if not(blexisteTipoTrab) then
                    return 1;
                   end if;

               nuContador := nuContador + 1 ;
               exit when nuContador = 3;
            end loop;
          close cuConsumosValidos;


      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto

       nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_AUME_PERM_F4');-- Obtenemos parametros

     if onuCountConsump > 0 then
        nuDatoCons := (onuSumTotalConsump/onuCountConsump);  -- suma de ultimos 6 consumos /  De los ultimos 6 consumos cuantos son diferentes de 0
        nuConsEsta := ((onuConsActual-nuDatoCons)/onuStandDevConsump);  -- Obtiene consumo estandarizado (gasplus)

       Cv := onuStandDevConsump / onuConsAnterior;
       Ko := (nuValorNumerico / 100) / Cv;
       kya := (onuConsActual - onuConsAnterior) /
                  onuStandDevConsump;

        if kya > Ko then
            begin
                  prEstadporProducto(
                        inuProduct,
                        add_months(dtFechaPerIni,-12),
                        onuAverageConsump,
                        onuVarianceConsump,
                        onuStandDevConsump,
                        onuStandDevConsump7,
                        onuCountConsump,
                        onuSumTotalConsump,
                        onuConsActual,
                        onuConsAnterior); -- Obtenemos datos estadisticos del consumo para el producto para el mismo periodo del a?o anterior
                        if onuConsActual = 0 and onuConsAnterior = 0 then
                           return(0);
                        end if;

            exception
                when no_data_found then
                return 0;
            end;
            Cv   := onuStandDevConsump / onuConsAnterior;  -- Consumo6 de hace un a?o
            Ko2  := (nuValorNumerico / 100) / Cv;
            kya1 := (onuConsActual - onuConsAnterior) /
                        onuStandDevConsump;
            if kya1 > Ko2 then
                nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('VARI_PORC_PERM_F4');-- Obtenemos parametros
                vp := abs((kya - kya1) / kya);
             if vp > (nuValorNumerico / 100) then
                return 0;
             else
                return 1;
             end if;
            else
            return 0;
            end if;
        else
         return 1;
        end if;

     end if;

     return 1;

    EXCEPTION
       when zero_divide then
          return 1;
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo4;

/******************************************************************************
*******************************************************************************/
    FUNCTION fnuEvalMetodo6
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        6- CONSUMO MINIMO
       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================
        17/10/2013  Se modifica la formula y se crea el parametro para categoria comercial
    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuDatoCons number;
     nuConsEsta number;
     Ko number;
     nuConsProm number;  -- consumo promedio por tipo suscripcion (producto)
     dtFechaPerIni date;
     nuano number;
     numes number;
     nuCategoria pr_product.category_id%type;
     nuSubcategoria pr_product.subcategory_id%type;
     blexisteOrdenes boolean;
     nuAddressId pr_product.address_id%type;
     nuGeographID ab_address.neighborthood_id%type;
     nuLocalidad ge_geogra_location.geo_loca_father_id%type;
     dtFechaConsProm  date;

    BEGIN

      blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;

      dtFechaPerIni := add_months(dtFechaIni, -1);

      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto



        dtFechaConsProm := add_months(dtFechaPerIni, Dald_parameter.fnuGetNumeric_Value('MESES_ATRAS_OBTENER_CP'));

        select to_number(to_char(dtFechaConsProm,'yyyy')) into nuano from dual;
        select to_number(to_char(dtFechaConsProm,'mm')) into numes from dual;

        nucategoria := dapr_product.fnugetcategory_id(inuproduct,null);
        nusubcategoria := dapr_product.fnugetsubcategory_id(inuproduct,null);
        nuAddressId := dapr_product.fnugetaddress_id(inuproduct,null);
        nuGeographID := daab_address.fnugetneighborthood_id(nuAddressId,null);
        nuLocalidad := dage_geogra_location.fnugetgeo_loca_father_id (nuGeographID,null);

        if nucategoria = 1 then
            nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_DESV_PERM_F6');-- Obtenemos parametros
        else
            nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_DESV_PERM_F6_COM');-- Obtenemos parametros
        end if;



        begin
            select round(nvl(avg(cpsccoto) / avg(cpscprod),0),2) into nuconsprom from coprsuca
            where cpsccate = nucategoria
            and cpscsuca = nusubcategoria
            and cpscanco = nuano
            and cpscmeco = numes
            and cpscubge = nuLocalidad;
        exception
           when no_data_found then
           nuconsprom := 0;
        end;



     if onuCountConsump > 0 then
        nuDatoCons := (onuSumTotalConsump/onuCountConsump);  -- suma de ultimos 6 consumos /  De los ultimos 6 consumos cuantos son diferentes de 0
        nuConsEsta := ((onuConsActual-nuDatoCons)/onuStandDevConsump);  -- Obtiene consumo estandarizado (gasplus)

                Ko := ((nuconsprom / onuAverageConsump -1)*100);

        if Ko >= nuValorNumerico then
          return 0;   -- Generar Orden
        else
          return 1;
        end if;

     end if;

     return 1;

    EXCEPTION
       when zero_divide then
          return 1;
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo6;

/******************************************************************************
*******************************************************************************/
    FUNCTION fnuEvalMetodo7
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        7. CONSUMO MAXIMO
       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuDatoCons number;
     nuConsEsta number;
     Ko number;
     nuConsProm number;  -- consumo promedio por tipo suscripcion (producto)
     dtFechaPerIni date;
     dtFechaPerFin date;
     nuano number;
     numes number;
     nuCategoria pr_product.category_id%type;
     nuSubcategoria pr_product.subcategory_id%type;
     blexisteOrdenes boolean;
     nuAddressId pr_product.address_id%type;
     nuGeographID ab_address.neighborthood_id%type;
     nuLocalidad ge_geogra_location.geo_loca_father_id%type;
     dtFechaConsProm  date;

    BEGIN

      blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;

      dtFechaPerIni := add_months(dtFechaIni, -1);

      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto

      dtFechaConsProm := add_months(dtFechaPerIni, Dald_parameter.fnuGetNumeric_Value('MESES_ATRAS_OBTENER_CP'));

        select to_number(to_char(dtFechaConsProm,'yyyy')) into nuano from dual;
        select to_number(to_char(dtFechaConsProm,'mm')) into numes from dual;

        nucategoria := dapr_product.fnugetcategory_id(inuproduct,null);
        nusubcategoria := dapr_product.fnugetsubcategory_id(inuproduct,null);
        nuAddressId := dapr_product.fnugetaddress_id(inuproduct,null);
        nuGeographID := daab_address.fnugetneighborthood_id(nuAddressId,null);
        nuLocalidad := dage_geogra_location.fnugetgeo_loca_father_id (nuGeographID,null);

        begin
            select round(nvl(avg(cpsccoto) / avg(cpscprod),0),2) into nuconsprom from coprsuca
            where cpsccate = nucategoria
            and cpscsuca = nusubcategoria
            and cpscanco = nuano
            and cpscmeco = numes
            and cpscubge = nuLocalidad;
        exception
           when no_data_found then
           nuconsprom := 0;
        end;

       nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('MAXI_PORC_DESV_PERM_F7');-- Obtenemos parametros

     if onuCountConsump > 0 then
        nuDatoCons := (onuSumTotalConsump/onuCountConsump);  -- suma de ultimos 6 consumos /  De los ultimos 6 consumos cuantos son diferentes de 0
        nuConsEsta := ((onuConsActual-nuDatoCons)/onuStandDevConsump);  -- Obtiene consumo estandarizado (gasplus)

        Ko := nuconsprom + ((nuValorNumerico / 100) * onuStandDevConsump);

        if nuConsEsta > Ko then
          return 0;   -- Generar Orden
        else
          return 1;
        end if;


     end if;

     return 1;

    EXCEPTION
       when zero_divide then
          return 1;
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo7;

/******************************************************************************
*******************************************************************************/

    FUNCTION fnuEvalMetodo8
    (
        inuProduct in pr_product.product_id%type,
        dtFechaini in date
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  Evalua los metodos de analisis de variacion de consumo
                        8. VARIACION DE CONSUMO -  METODO PREDICTIVO
       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7  number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuStdPopulConsump7  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuDatoCons number;
     nuConsEsta number;
    Ko            NUMBER;
    m             number;
    ye            number;
    ky            number;
    suma          number;
    suma1         number;
    nucontador     number;
    dtFechaPerIni date;
    nuParametro_1 number;
    nuParametro_2 number;
    nuParametro_3 number;

        cursor cuConsumos is
         select subtabla.pecsfeci,subtabla.cosspecs, subtabla.cosscoca from
          ( SELECT
              pericose.pecsfeci,conssesu.cosspecs, sum(conssesu.cosscoca) cosscoca
            FROM open.conssesu, open.pericose
            WHERE conssesu.cosssesu = inuProduct
            AND pericose.pecsfeci <= add_months(dtFechaini, -1)
            AND pericose.pecscons = conssesu.cosspecs
            AND conssesu.cossmecc <> 4
            group by pericose.pecsfeci,conssesu.cosspecs
            order by 1 desc
          ) subtabla
         where ceil(rownum/8) = 1;



        reg_Consumos  cuConsumos%rowtype;
     blexisteOrdenes boolean;

    BEGIN

      blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;

      dtFechaPerIni := add_months(dtFechaIni, -1);

      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto

      nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('CONSTANTE_VARIACION_CONSUMO');-- Obtenemos parametros
      nuParametro_1 :=  Dald_parameter.fnuGetNumeric_Value('PARAMETRO_1_MET_PREDICTIVO');-- Obtenemos parametros
      nuParametro_2 :=  Dald_parameter.fnuGetNumeric_Value('PARAMETRO_2_MET_PREDICTIVO');-- Obtenemos parametros
      nuParametro_3 :=  Dald_parameter.fnuGetNumeric_Value('PARAMETRO_3_MET_PREDICTIVO');-- Obtenemos parametros

     if onuCountConsump > 0 then
        nuDatoCons := (onuSumTotalConsump/onuCountConsump);  -- suma de ultimos 6 consumos /  De los ultimos 6 consumos cuantos son diferentes de 0
        nuConsEsta := ((onuConsActual-nuDatoCons)/onuStandDevConsump);  -- Obtiene consumo estandarizado (gasplus)

        Ko := (onuConsActual / onuStandDevConsump7) + nuValorNumerico;

            if cuConsumos%ISOPEN
            THEN
            CLOSE cuConsumos;
            END IF;

            nuContador := 7;
            suma := 0;
            open cuConsumos;
            while nuContador > 0
                loop
                fetch cuConsumos into reg_consumos;
                      if nucontador < 7 then
                        suma1 := (reg_consumos.cosscoca*nuContador);
                        suma := suma + suma1;
                      end if;
                    nuContador := nuContador -1;
            end loop;
            close cuConsumos;

        m := (((-nuParametro_1 * onuAverageConsump) + (suma)) / nuParametro_2);

        ye := (nuParametro_3 * m) + onuAverageConsump;

        ky := (onuConsActual - ye) / onuStandDevConsump;

        if (abs(nuConsEsta) > Ko) and (abs(ky) > ko) then
            return 0;
        else
            return 1;
        end if;

     end if;

     return 1;

    EXCEPTION
       when zero_divide then
          return 1;
        when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo8;

/******************************************************************************
*******************************************************************************/

  FUNCTION fnuEvalMetodo5
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  5. CONSUMO CERO

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuestaprod pr_product.product_status_id%type;
     nuindice number;
     nuContador number;
     dtFechaInicial date;
     dtFechaFinal date;
     dtFechaPerIni date;
     dtFechaPerFin date;

    -- Consumos facturados durante los periodos de consumo registrados antes de la fecha de la variable idtFechaInicial
    cursor cuConsumosValidos(inuNumeroServicio in servsusc.sesunuse%type, idtFechaInicial in pericose.pecsfeci%type, nuValParametro in number) is
         select subtabla.pecsfeci,subtabla.periodo, subtabla.consumo from
          ( SELECT
              pericose.pecsfeci,conssesu.cosspecs periodo, sum(conssesu.cosscoca) consumo
            FROM open.conssesu, open.pericose
            WHERE conssesu.cosssesu = inuNumeroServicio
            AND pericose.pecsfeci <= idtFechaInicial
            AND pericose.pecscons = conssesu.cosspecs
            AND conssesu.cossmecc <> 4
            group by pericose.pecsfeci,conssesu.cosspecs
            order by 1 desc
          ) subtabla
         where ceil(rownum/(nuValParametro+1)) = 1;

        blConsumoValido   boolean; --Verdadero si el consumo es valido
        rcConsumosValidos cuConsumosValidos%rowtype; -- Registro del cursor
        onuobselect lectelme.leemoble%type;
   --  blexisteOrdenes boolean;

    BEGIN

     /* jjjm blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;*/

      dtFechaPerIni := add_months(dtFechaIni, -1);
      dtFechaPerFin := add_months(dtFechaIni, -7);

      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto

     nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('PERIODOS_CONSUMO_CERO');-- Obtenemos parametros

    -- Obtenemos el estado de corte del producto
     nuestaprod := dapr_product.fnugetproduct_status_id(inuproduct);

        if nuestaprod not in (15,17,2,8,3) and onuConsActual = 0 then   -- Si los estados no son "Pendiente de instalacion, suspendido"

            --nuValorNumerico := nuValorNumerico - 1;
            nuIndice       := 1;
            nuContador    := 1;
            open cuConsumosValidos(inuproduct, dtFechaIni,(nuValorNumerico+1));
            loop
                fetch cuConsumosValidos
                into rcConsumosValidos;
                exit when cuConsumosValidos%notfound or cuConsumosValidos%notfound is null;
                exit when nuIndice > nuValorNumerico;
                prDatosPeriodo(rcConsumosValidos.Periodo,
                                inuproduct,
                               dtFechaInicial,
                               dtFechaFinal,
                               onuobselect);
                blConsumoValido := fblStateOrders('CODI_TRAB_SUSP_SERV',
                                              'N',
                                              dtFechaInicial,
                                              dtFechaFinal,
                                              inuproduct);
                if (blCOnsumoValido) then
                    blConsumoValido := fblStateOrders('CODI_TRAB_RECO_SERV',
                                                  'N',
                                                  dtFechaInicial,
                                                  dtFechaFinal+(Dald_parameter.fnuGetNumeric_Value('DIAS_ADICIONALES_AVC')),
                                                  inuproduct);
                    if (blCOnsumoValido) then
                        nuIndice := nuIndice + 1;
                        if (rcConsumosValidos.consumo <> 0) then
                            pkErrors.pop;
                            return(1);
                        end if;
                    end if;
                end if;

                if onuobselect = 17  then --si es diferente a desocupado "CASA VACIA"
                    return(1);
                end if;

                if not(blCOnsumoValido) then
                       pkErrors.pop;
                       return(1);
                end if;
                nuContador := nuContador + 1 ;
                exit when nuContador = nuValorNumerico+1;
            end loop;
        close cuConsumosValidos;
            if (nuIndice <= nuValorNumerico) then
                pkErrors.pop;
                return(1);
            end if;

            return(0);
        else
            pkErrors.pop;
            return(1);
        end if;

        return(1);

    EXCEPTION
       when zero_divide then
          return 1;
       when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo5;
/******************************************************************************
*******************************************************************************/
  FUNCTION fnuHistConsumo
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date,
        innumConsumo in number
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  Retorna el ultimo consumo de su historial
                            Usado desde la sentencia principal del reporte LDCAVC

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================
    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7  number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     dtFechaPerIni date;


    BEGIN
      dtFechaPerIni := add_months(dtFechaIni, -1);

      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto

      if innumConsumo = 6 then
         return(onuConsActual);
      elsif innumConsumo = 5 then
         return (onuConsAnterior);
      end if;

       return(0);

    EXCEPTION
       when zero_divide then
          return 1;
       when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuHistConsumo;
/**********************************************************************
Propiedad intelectual de Peti (c).
Descripcion    :  Retorna la ruta de lectura
                        Usado desde la sentencia principal del reporte LDCAVC

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    06/02/2015      Mmejia.NC3401       Se modifica el cursor que obtiene los
                                        datos para que haga el JOIN entre ab_segments
                                        y  ab_address.
    25/02/2015      Mmejia.NC3401       Se modifica el cursor que obtiene los
                                        datos para que haga el JOIN entre ab_segments
                                        y  ab_address, luego se toma el consecutivo
                                        de ab_premise.
**********************************************************************/
function fsbRutaLectura(nuContrato suscripc.susccodi%type)
    return number
is
    cursor cuRutaLectura is
      SELECT abp.consecutive  ruta
      FROM ab_address ad, suscripc sc,ab_premise abp
     WHERE ad.address_id = sc.susciddi
       AND sc.susccodi = nuContrato
       AND abp.premise_id =  ad.estate_number
       AND ROWNUM < 2;

    nuruta number;

begin

    for rcRutaLectura in cuRutaLectura loop
         nuruta := rcRutaLectura.ruta;
    end loop;

    -- Retorna el valor calculado
    return nuruta;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbRutaLectura;


function fsbNumMedidor(nuContrato   suscripc.susccodi%type)
    return Varchar2
is
    cursor cuNumMedidor is
        select el.emsscoem  description
          from servsusc ss,elmesesu el
         where ss.sesunuse = el.emsssesu
           and ss.sesususc = nuContrato
           and ss.sesuserv = 7014
           and sysdate between EL.EMSSFEIN and EL.EMSSFERE
           and rownum < 2;

    sbCadeana Varchar2(2000);
begin

    for rcNumMedidor in cuNumMedidor loop
         sbCadeana := rcNumMedidor.description;
    end loop;

    -- Retorna el valor calculado
    return sbCadeana;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    raise;
  when others then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     'erro al obtener el valor');
    raise;
end fsbNumMedidor;

  function fblValidaOtrasOrdenes(nuproducto servsusc.sesunuse%type
                          ) return boolean is
    ------------
    -- Variables
    ------------
    cnuCero number := 0;
    nuContador number;
    nuContador1 number;

  BEGIN
    --  {
    pkErrors.Push('LDC_OSSPkEvaluaMetodosAvc.fblValidaOtrasOrdenes');

            -- Busca ordenes en estado no finalizado para el producto
            SELECT nvl(count(*), 0)
             INTO nuContador
             FROM or_order, or_order_activity
            WHERE or_order.task_type_id in (select to_number(column_value)
                                From table(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('LISTA_TRAB_AVC'), ',')))
             and or_order.order_id = or_order_activity.order_id
             and  or_order.order_status_id in (0,1,6,5,11,20)
             and or_order_activity.product_id = nuproducto;

            SELECT nvl(count(*), 0)
             INTO nuContador1
             FROM or_order, or_order_activity
            WHERE or_order.task_type_id in (select to_number(column_value)
                                From table(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('LISTA_TRAB_AVC'), ',')))
             and or_order.order_id = or_order_activity.order_id
             and or_order.order_status_id =8
             and or_order.legalization_date >= (sysdate-(dald_parameter.fnuGetnumeric_value('DIAS_EXCL_USU_OT_LEG_AVC',null)))
             and or_order_activity.product_id = nuproducto;


             if (nuContador > cnuCero) or (nuContador1 > cnuCero) then
                pkErrors.pop;
                return(true);
             end if;
            pkErrors.pop;
            return(false);

  Exception
       when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
  END fblValidaOtrasOrdenes;

  FUNCTION fnuEvalMetodo9
    (
        inuProduct in pr_product.product_id%type,
        dtFechaIni in date
    ) return number
    IS
    /**********************************************************************
    Propiedad intelectual de Peti (c).
    Descripcion    :  9. CONSUMO CERO NUEVO

       Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================

    **********************************************************************/
     onuAverageConsump   number;
     onuVarianceConsump  number;
     onuStandDevConsump  number;
     onuStandDevConsump7 number;
     onuMaxConsump       number;
     onuMinConsump       number;
     onuMedianConsump    number;
     onuCountConsump     number;
     onuStdPopulConsump  number;
     onuSumTotalConsump  number;
     onuConsActual number;
     onuConsAnterior number;
     nuValorNumerico number;
     nuestaprod pr_product.product_status_id%type;
     nuindice number;
     nuContador number;
     dtFechaInicial date;
     dtFechaFinal date;
     dtFechaPerIni date;
     dtFechaPerFin date;

    -- Consumos facturados durante los periodos de consumo registrados antes de la fecha de la variable idtFechaInicial
    cursor cuConsumosValidos(inuNumeroServicio in servsusc.sesunuse%type, idtFechaInicial in pericose.pecsfeci%type, nuValParametro in number) is
         select subtabla.pecsfeci,subtabla.periodo, subtabla.consumo from
          ( SELECT
              pericose.pecsfeci,conssesu.cosspecs periodo, sum(conssesu.cosscoca) consumo
            FROM open.conssesu, open.pericose
            WHERE conssesu.cosssesu = inuNumeroServicio
            AND pericose.pecsfeci <= idtFechaInicial
            AND pericose.pecscons = conssesu.cosspecs
            AND conssesu.cossmecc <> 4
            group by pericose.pecsfeci,conssesu.cosspecs
            order by 1 desc
          ) subtabla
         where ceil(rownum/(nuValParametro+1)) = 1;

        blConsumoValido   boolean; --Verdadero si el consumo es valido
        rcConsumosValidos cuConsumosValidos%rowtype; -- Registro del cursor
        onuobselect lectelme.leemoble%type;
   --  blexisteOrdenes boolean;

    BEGIN

    /* jjjm blexisteOrdenes:= fblValidaOtrasOrdenes(inuProduct);

      if (blexisteOrdenes) then
         return 1;
      end if;*/

      dtFechaPerIni := add_months(dtFechaIni, -1);
      dtFechaPerFin := add_months(dtFechaIni, -7);

      prEstadporProducto(
      inuProduct,
      dtFechaPerIni,
      onuAverageConsump,
      onuVarianceConsump,
      onuStandDevConsump,
      onuStandDevConsump7,
      onuCountConsump,
      onuSumTotalConsump,
      onuConsActual,
      onuConsAnterior);  -- Obtenemos datos estadisticos del consumo para el producto

     nuValorNumerico := Dald_parameter.fnuGetNumeric_Value('PERIODOS_CONSUMO_CERO_NUEVO');-- Obtenemos parametros

    -- Obtenemos el estado de corte del producto
     nuestaprod := dapr_product.fnugetproduct_status_id(inuproduct);

        if nuestaprod not in (15,17,2,8,3) and onuConsActual = 0 and onuConsAnterior <> 0 then   -- Si los estados no son "Pendiente de instalacion, suspendido"

            --nuValorNumerico := nuValorNumerico - 1;
            nuIndice       := 1;
            nuContador     := 1;
            open cuConsumosValidos(inuproduct, dtFechaIni,(nuValorNumerico+1));
            loop
                fetch cuConsumosValidos
                into rcConsumosValidos;
                exit when cuConsumosValidos%notfound or cuConsumosValidos%notfound is null;
                exit when nuIndice > nuValorNumerico;
                prDatosPeriodo(rcConsumosValidos.Periodo,
                                inuproduct,
                               dtFechaInicial,
                               dtFechaFinal,
                               onuobselect);
                blConsumoValido := fblStateOrders('CODI_TRAB_SUSP_SERV',
                                              'N',
                                              dtFechaInicial,
                                              dtFechaFinal,
                                              inuproduct);
                if (blCOnsumoValido) then
                    blConsumoValido := fblStateOrders('CODI_TRAB_RECO_SERV',
                                                  'N',
                                                  dtFechaInicial,
                                                  dtFechaFinal+(Dald_parameter.fnuGetNumeric_Value('DIAS_ADICIONALES_AVC')),
                                                  inuproduct);
                    if (blCOnsumoValido) then
                        nuIndice := nuIndice + 1;
                        if (rcConsumosValidos.consumo <> 0) then
                            pkErrors.pop;
                            return(1);
                        end if;
                    end if;
                end if;

                if onuobselect = 17  then --si es diferente a desocupado "CASA VACIA"
                    return(1);
                end if;

                if not(blCOnsumoValido) then
                       pkErrors.pop;
                       return(1);
                end if;
                nuContador := nuContador + 1 ;
                exit when nuContador = nuValorNumerico+1;

            end loop;
        close cuConsumosValidos;
            if (nuIndice <= nuValorNumerico) then
                pkErrors.pop;
                return(1);
            end if;

            return(0);
        else
            pkErrors.pop;
            return(1);
        end if;

          return(1);


    EXCEPTION
       when zero_divide then
          return 1;
       when ex.CONTROLLED_ERROR then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuEvalMetodo9;
/******************************************************************************/


END LDC_OSSPKEVALUAMETODOSAVC;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_OSSPKEVALUAMETODOSAVC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_OSSPKEVALUAMETODOSAVC TO REXEREPORTES;
/