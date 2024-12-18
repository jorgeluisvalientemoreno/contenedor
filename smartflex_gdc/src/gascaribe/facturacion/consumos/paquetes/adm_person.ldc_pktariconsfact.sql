CREATE OR REPLACE PACKAGE adm_person.LDC_PKTARICONSFACT is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCCREG_B
    Descripcion    : Paquete donde se implementa para llenar tabla durante cierre comercial para reporte CREG
    Autor          : Sayra Ocoro
    Fecha          : 11/02/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prFillSnapshotCreg
    Descripcion    : Procedimiento donde se implementa para llenar tabla durante cierre comercial para reporte CREG
    Autor          : Sayra Ocoro
    Fecha          : 11/02/2014

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================*/

    -- tabla para
   TYPE rccart IS RECORD
  (nro_usu_con_deuda_reg number(7),
   nro_usu_con_deuda_noreg number(7),
   nro_usu_con_dife_reg number(7),
   nro_usu_con_dife_noreg number(7),
   nro_usu_deu_corr_reg number(7),
   nro_usu_deu_corr_noreg number(7),
   vlr_deu_dife_reg number(15,2),
   vlr_deu_dife_noreg number(15,2),
   vlr_deu_corr_reg number(15,2),
   vlr_deu_corr_noreg number(15,2),
   nro_deu_m90_reg number(7),
   vlr_deu_m90_reg number(15,2),
   nro_deu_m90_noreg number(7),
   vlr_deu_m90_noreg number(15,2));

  TYPE tbcart IS TABLE OF rccart INDEX BY binary_integer ;
  tcart tbcart;

  nuIndex binary_integer;



   -- tabla para
   TYPE rcflag IS RECORD
  (sbdeudareg varchar2(1),
   sbdeudanoreg varchar2(1),
   sbDeudaCorrReg varchar2(1),
   sbDeudaCorrNoReg varchar2(1),
   sbM90Reg  varchar2(1),
   sbM90NoReg  varchar2(1),
   sbDeudaDifeReg varchar2(1),
   sbDeudaDifeNoReg varchar2(1));

  TYPE tbflag IS TABLE OF rcflag INDEX BY binary_integer ;
  tflag tbflag;



 PROCEDURE ProcessLDTCFA;



function fnuGetTariApli                 (inusesu servsusc.sesunuse%type,
                                             inucate number,
                                             inusuca number,
                                             idtfeini date,
                                             idtfefin date) return varchar2;

function fnugetTarifa (inusesu in number,
                       inupefa in number,
                       inupeco in number,
                       inuunli in number,
                       onuliir out number,
                       onulisr out number,
                       onuvaul out number) return number;

PROCEDURE GenDatos (inuano in number, inumes in number);

  procedure prFillTabla_Hilos (idtfecini date,
                             idtfecfin date,
                             idttoday date,
                             innuNroHilo number,
                             innuTotHilos number,
                             innusesion number) ;

 procedure pro_grabalog(inusesion  number,
                         inuproceso varchar2,
                         inuano     number,
                         inumes     number,
                         idtfecha   date,
                         inuhilo    number,
                         inuresult  number,
                         isbobse    varchar2);



end LDC_PKTARICONSFACT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKTARICONSFACT is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_CALIDAD_CARTERA
    Descripcion    : Paquete donde
    Autor          : F.Castro
    Fecha          : 14/12/2016

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    *****************************************************************************/


    dtToday date := sysdate;
    nusesion  number;


--------------------------------------------------------------------------------------------------------------
    PROCEDURE ProcessLDTCFA
    IS

   cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBJECT_TYPE_ID ge_boInstanceControl.stysbValue;
    sbTEPFANO ge_boInstanceControl.stysbValue;
    sbTEPFMES ge_boInstanceControl.stysbValue;

    sbEnEjec      ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('FLAG_EJEC_LDTCFA');

    BEGIN


        sbTEPFANO := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAANO');
        sbTEPFMES := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFAMES');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------


        if (sbTEPFANO is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'A?o');
            raise ex.CONTROLLED_ERROR;
        end if;

        if (sbTEPFMES is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Mes');
            raise ex.CONTROLLED_ERROR;
        end if;

        if sbEnEjec = 'S' then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'PROCESO ESTA EN EJECUCION ... DEBE ESPERAR QUE TERMINE');
            raise ex.CONTROLLED_ERROR;
        end if;
        ------------------------------------------------
        -- User code
        ------------------------------------------------

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDTCFA;
------------------------------------------------------------------------------
function fnuGetTariApli                 (inusesu servsusc.sesunuse%type,
                                             inucate number,
                                             inusuca number,
                                             idtfeini date,
                                             idtfefin date) return varchar2 is

sbtariapli varchar2(4000);
sbdetalle  varchar2(4000);


nurangoini number;
nurangofin number;
valconsumo number;
nutarifa   number;
sbperiodo  varchar2(6);

consmayor VARCHAR2(1);
ajuste    VARCHAR2(1);

cursor cucargos is
SELECT CARGCUCO,CARGNUSE,CARGPEFA,CARGPECO,CARGCONC,CARGSIGN,CARGUNID,
       CARGVALO,CARGDOSO,CARGTIPR,CARGPROG,CARGFECR
  FROM CARGOS
 WHERE CARGNUSE=inusesu
   AND CARGCONC in (31,200)
   AND CARGSIGN IN ('DB','CR')
   AND SUBSTR(CARGDOSO,1,3) = 'CO-'
   and cargfecr >= idtfeini
   and cargfecr < idtfefin + 1
   and cargprog in (5,2014)  -- se limita a generado por fact normal?  no incluye notas por ej?
 --  AND cargcuco = inucuco
 order by cargnuse, cargtipr;

begin
  sbtariapli := null;
  sbdetalle := null;

  for rg in cucargos loop
     consmayor := 'N';
     ajuste    := 'N';
     if rg.cargtipr = 'A' and rg.cargprog=5 and substr(rg.cargdoso,1,4) = 'CO-2' and
        rg.cargsign='DB' and nvl(rg.cargunid,0) != 0 then -- CO-2 consumo 2016 o 2017 etc o sea no CO-PR que es recuperado
       sbtariapli := 'F' || '|' || rg.cargunid || '|' || rg.cargvalo || '|' || to_char(rg.cargfecr,'dd/mm/yyyy') || '|';
       if inucate = 1 and inusuca in (1,2) then
        if rg.cargunid <= 20 then
          nutarifa := fnugettarifa (inusesu, rg.cargpefa, rg.cargpeco, rg.cargunid, nurangoini, nurangofin, valconsumo);
          sbtariapli := sbtariapli || nurangoini || '-' || nurangofin || '|' || nutarifa ||  '|' ;

        else -- > 20
          consmayor := 'S';
          nutarifa := fnugettarifa (inusesu, rg.cargpefa, rg.cargpeco, 20, nurangoini, nurangofin, valconsumo);
          sbtariapli := sbtariapli || nurangoini || '-' || nurangofin || '|' || nutarifa ||  '|' ;

          nutarifa := fnugettarifa (inusesu, rg.cargpefa, rg.cargpeco, rg.cargunid -20, nurangoini, nurangofin, valconsumo);
          sbtariapli := sbtariapli || nurangoini || '-' || nurangofin || '|' || nutarifa ||  '|' ;

        end if;
        if consmayor = 'N' then
          sbtariapli := sbtariapli || '|' ||  '|' ; -- rango y tarifa 2 nulas
        end if;

       else -- cat 2,3 o cat 1 est 3,4,5,6
        if rg.cargunid <= 90000 then
          nutarifa := fnugettarifa (inusesu, rg.cargpefa, rg.cargpeco, rg.cargunid, nurangoini, nurangofin, valconsumo);
          sbtariapli := sbtariapli || nurangoini || '-' || nurangofin || '|' || nutarifa ||  '|' ;

        else -- > 90000
          consmayor := 'S';
          nutarifa := fnugettarifa (inusesu, rg.cargpefa, rg.cargpeco, 90000, nurangoini, nurangofin, valconsumo);
          sbtariapli := sbtariapli || nurangoini || '-' || nurangofin || '|' || nutarifa ||  '|' ;

          nutarifa := fnugettarifa (inusesu, rg.cargpefa, rg.cargpeco, rg.cargunid -90000, nurangoini, nurangofin, valconsumo);
          sbtariapli := sbtariapli || nurangoini || '-' || nurangofin || '|' || nutarifa ||  '|' ;

          sbtariapli := sbtariapli || '|' ||  '|' ; -- rango y tarifa 2 nulas
        end if;
        if consmayor = 'N' then
          sbtariapli := sbtariapli || '|' ||  '|' ; -- rango y tarifa 2 nulas
        end if;
      end if;
    else -- CO-201611-TC-0001  CO-PR-201610-TC-0001

      if substr(rg.cargdoso,1,4) = 'CO-2' then
        sbperiodo := substr(rg.cargdoso,4,6);
      elsif substr(rg.cargdoso,1,5) = 'CO-PR' then
        sbperiodo := substr(rg.cargdoso,7,6);
      else
        sbperiodo := null;
      end if;
      if sbperiodo is not null then
        ajuste    := 'S';
        nutarifa := ROUND(rg.cargvalo / rg.cargunid,2);
        sbdetalle := sbdetalle || substr(sbperiodo,1,4) || '-'  || substr(sbperiodo,5,2) || '  ' ||  rg.cargsign || '  ' || rg.cargunid || ' M3   $ ' || nutarifa || '; ';

      end if;

    end if;
   end loop;

   if nvl(ajuste,'N') = 'N' then
     sbtariapli := sbtariapli || 'N' || '|' || '|';
   else
     sbtariapli := sbtariapli || 'S' || '|'  || sbdetalle || '|';
   end if;


   if substr(sbtariapli,1,1) != 'F' then
     sbtariapli := 'F' || '|' || '|' || '|' || '|' || '|' || '|' || '|' || '|' || sbtariapli;
   end if;


  return sbtariapli;
exception when others then
  return ('|' || '|' || '|' || '|' || '|' || '|' || '|' || '|' || '|' || '|');
end fnuGetTariApli;
------------------------------------------------------------------------------
function fnugetTarifa (inusesu in number,
                       inupefa in number,
                       inupeco in number,
                       inuunli in number,
                       onuliir out number,
                       onulisr out number,
                       onuvaul out number) return number is

  nuvalor  number;

  cursor curangliqu is
  select raliliir, ralilisr, ralivalo, ralivaul
   from rangliqu
  where RALICONC = 31
    and RALIPEFA = inupefa
    AND RALIPECO = inupeco
    and RALISESU = inusesu
    and raliunli = inuunli;
  begin

    open curangliqu;
    fetch curangliqu into onuliir, onulisr, nuvalor, onuvaul;
    if curangliqu%notfound then
      onuliir := null;
      onulisr := null;
      nuvalor := null;
      onuvaul := null;
    end if;
    close curangliqu;
    return (nuvalor);
 exception when others then
   return null;
 end fnugetTarifa;
------------------------------------------------------------------------------
PROCEDURE GenDatos (inuano in number, inumes in number) IS


 nuHilos        number;
 nuTotReg               number;
 nuFinJobs              number(1);
 nuCont                 number;
 nuresult               number(5);


 dtfechaini date;
 dtfechafin date;


 cursor cucuentas (dtfeini date, dtfefin date) is
  select /*cuconuse,cucocodi,factfege*/ count(1)
    from cuencobr, factura, servsusc
   where cuconuse=sesunuse
     and cucofact=factcodi
     and sesuserv=7014
     and factprog=6
     AND FACTCONS=66
     and factfege >= dtfeini
     and factfege < dtfefin + 1;


      --and rownum < 20
      --AND CACCNUSE IN (460,476,1172131,2084134)


 cursor cuJobs (nuInd number, cnuyear number, cnumonth number) is
 select resultado
   from LDC_LOG_LDTCFA
  where sesion = nusesion
    and fecha_inicio = dtToday
    and ano = cnuYear
    and mes = cnuMonth
    and proceso = 'LDTCFA'
    and hilo = nuind
    AND resultado in (-1,2); -- -1 Termino con errores, 2 termino OK


    nujob         number;
    sbWhat        varchar2(4000);

begin

  nuHilos := dald_parameter.fnuGetNumeric_Value('LDTCFA_HILOS');

  select userenv('SESSIONID') into nusesion from dual;

  dtfechaini := to_date('01/'||inumes||'/'||inuano,'dd/mm/yyyy');
  dtfechafin := last_day(dtfechaini);

  ldc_proinsertaestaprog(inuano,
                           inumes,
                           'LDTCFA',
                           'Inicia ejecucion...',
                           nusesion,
                           USER);

    pro_grabalog(nusesion,
                 'LDTCFA',
                 inuano,
                 inumes,
                 dtToday,
                 0,
                 0,
                 'Inicia Proceso');

    -- setea el flag de ejecucion en proceso
    update ld_parameter
       set value_chain = 'S'
     where parameter_id = 'FLAG_EJEC_LDTCFA';
    COMMIT;

   -- borra los datos del periodo para reprocesarlos
  delete from LDC_TARICONSFACT where ano = inuano and mes=inumes;
  commit;

    -- se halla el total de registros a procesar
    open cucuentas(dtfechaini,dtfechafin);
    fetch cucuentas into nuTotReg;
    if nuTotReg is null then
      nuTotReg := -1;
    end if;
    close cucuentas;

  if nuTotReg > 0 then
    -- Si el numero de regs a procesar es menor o igual al Nro de hilos, se ejecutara en uno solo
     if nuTotReg <= nuHilos then
       nuHilos := 1;
     end if;

    -- se crean los jobs y se ejecutan
    for rgJob in 1 .. nuHilos loop
          sbWhat := 'BEGIN'                                           || chr(10) ||
            '   SetSystemEnviroment;'                         || chr(10) ||
            '   LDC_PKTARICONSFACT.prFillTabla_Hilos(' ||
            '                                to_date(''' ||to_char(dtfechaini,'DD/MM/YYYY')||'''),' || chr(10) ||
            '                                to_date(''' ||to_char(dtfechafin,'DD/MM/YYYY')||'''),' || chr(10) ||
            '                                to_date(''' ||to_char(dtToday,'DD/MM/YYYY  HH24:MI:SS')||'''),' || chr(10) ||
            '                                ' || rgJob || ',' || chr(10) ||
            '                                ' || nuHilos || ',' || chr(10) ||
            '                                ' || nusesion || ');' || chr(10) ||
            'END;';
        dbms_job.submit (nujob,
                         sbWhat,
                         sysdate + 1/3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;
     end loop;

    -- se verifica si terminaron los jobs
    nuFinJobs := 0;
    while nuFinJobs = 0 loop
      nucont    := 0;
      for i in 1 .. nuHilos loop
        open cujobs (i, inuano, inumes);
        fetch cujobs into nuresult;
        if cujobs%found then
            nucont := nucont + 1;
         end if;
         close cujobs;
       end loop;
       if nucont = nuHilos then
         nuFinJobs := 1;
       else
         DBMS_LOCK.SLEEP(60);
       end if;
     end loop;

     pro_grabalog (nusesion, 'LDTCFA', inuano, inumes, dtToday, 0, 0, 'Terminaron todos los hilos');


  else
    pro_grabalog (nusesion, 'LDTCFA', inuano, inumes, dtToday, 0, 0, 'LDC_BCCREG_B.GenDatos con cero registros a procesar');

  end if;

  ldc_proinsertaestaprog(inuano,
                           inumes,
                           'LDTCFA',
                           'Termino ejecucion...',
                           nusesion,
                           USER);

    pro_grabalog(nusesion,
                 'LDTCFA',
                 inuano,
                 inumes,
                 dtToday,
                 0,
                 0,
                 'Termino Proceso');

    -- setea el flag de ejecucion en proceso
    update ld_parameter
       set value_chain = 'N'
     where parameter_id = 'FLAG_EJEC_LDTCFA';
    COMMIT;

  exception
    WHEN ex.CONTROLLED_ERROR then
      pro_grabalog (nusesion, 'LDTCFA', inuano, inumes, dtToday, 0, 0, 'Error: ' || sqlerrm);
      ldc_proinsertaestaprog(inuano,
                           inumes,
                           'LDTCFA',
                           'Termino con Errores ... ' || sqlerrm,
                           nusesion,
                           USER);

      rollback;

      -- setea el flag de ejecucion en proceso
    update ld_parameter
       set value_chain = 'N'
     where parameter_id = 'FLAG_EJEC_LDTCFA';
    COMMIT;

      raise;
    When others then
      pro_grabalog (nusesion, 'LDTCFA', inuano, inumes, dtToday, 0, 0, 'Error: ' || sqlerrm);
      ldc_proinsertaestaprog(inuano,
                           inumes,
                           'LDTCFA',
                           'Termino con Errores ... ' || sqlerrm,
                           nusesion,
                           USER);
      rollback;

      -- setea el flag de ejecucion en proceso
    update ld_parameter
       set value_chain = 'N'
     where parameter_id = 'FLAG_EJEC_LDTCFA';
    COMMIT;
    --  gw_boerrors.checkerror(SQLCODE, SQLERRM);


END GenDatos;

------------------------------------------------------------------------------
procedure prFillTabla_Hilos (idtfecini date,
                             idtfecfin date,
                             idttoday date,
                             innuNroHilo number,
                             innuTotHilos number,
                             innusesion number)  is

nususc   number;
nucont   number := 0;
nulineaerror NUMBER(5);
nuyear                 number(4);
numonth                number(2);
sbTarifas              varchar2(4000);
i                      number;
nuvolfac               number;
nurango1               varchar2(100);
nutari1                number;
nurango2               varchar2(100);
nutari2                number;
nuvalfac               number;
dtfecargo              date;
sbrecuperado           varchar2(1);
sbdetrecu              varchar2(4000);


 cursor cucuentas is
 select cuconuse,cucocodi,factfege, sesususc
    from cuencobr, factura, servsusc
   where cuconuse=sesunuse
     and cucofact=factcodi
     and sesuserv=7014
     and factprog=6
     AND FACTCONS=66
     and factfege >= idtfecini
     and factfege < idtfecfin + 1
    -- and rownum < 500
    -- and cuconuse in (533321);
     AND   mod(cucocodi,innuTotHilos)+innuNroHilo= innuTotHilos;

  cursor cuDatos (nuprod number, nuano number, numes number) is
   select c.departamento, c.localidad, c.categoria, c.subcategoria, m.lomrmeco mercado
     from ldc_osf_Sesucier c, fa_locamere m
    where c.localidad = m.lomrloid
      and c.nuano=nuano
      and c.numes=numes
      and c.producto = nuprod;
  rgD cuDatos%rowtype;

cursor cuTarifas (sbtari varchar2) is
 select *
   from table(ldc_boutilities.splitstrings(sbtari, '|'));

begin

   nulineaerror := 1;
   nuyear := to_number(TO_CHAR(idtfecini, 'YYYY'));
   numonth := to_number(TO_CHAR(idtfecini, 'MM'));


  pro_grabalog (innusesion, 'LDTCFA', nuYear, nuMonth, idttoday, innuNroHilo, 1, 'Inicia Hilo: ' || innuNroHilo);
  nulineaerror := 2;

  nucont := 0;
  for rg in cucuentas loop
    nususc := rg.sesususc;
    nulineaerror := 3;
    open cuDatos(rg.cuconuse, nuyear, numonth);
    fetch cuDatos into rgD;
    if cuDatos%notfound then
      NULL;
    end if;
    close cuDatos;
    nulineaerror := 4;
    sbTarifas := fnuGetTariApli(rg.cuconuse, rgD.categoria, rgD.subcategoria, idtfecini, idtfecfin);
    nulineaerror := 5;
    i := 1;
    for rg in cutarifas (sbTarifas) loop
      nulineaerror := 6;
      if i=1 then
        null;
      elsif i=2 then
        nulineaerror := 7;
        nuvolfac := rg.column_Value;
      elsif i=3 then
        nulineaerror := 8;
        nuvalfac := rg.column_Value;
      elsif i=4 then
        nulineaerror := 9;
        dtfecargo := to_Date(rg.column_Value,'dd/mm/yyyy');

      elsif i=5 then
        nulineaerror := 10;
        nurango1 := rg.column_Value;

      elsif i=6 then
        nulineaerror := 11;
        nutari1 := rg.column_Value;

      elsif i=7 then
        nulineaerror := 12;
        nurango2 := rg.column_Value;

      elsif i = 8 then
        nulineaerror := 13;
        nutari2 := rg.column_Value;

      elsif i = 9 then -- 9
        nulineaerror := 14;
        sbrecuperado := rg.column_Value;
      elsif i = 10 then
        nulineaerror := 15;
        sbdetrecu := rg.column_Value;
      else
        null;
      end if;
      i := i + 1;
    end loop;
    nulineaerror := 16;
    if nuvolfac is not null  or  sbdetrecu is not null then
      insert into LDC_TARICONSFACT (ano, mes, contrato, producto, departamento, localidad, categoria,
                                    mercado, volumen_fact, rango_liquidado_1, tarifa_aplicada_1,
                                    rango_liquidado_2, tarifa_aplicada_2, valor_facturado, fecha_cargo,
                                    recuperado, detalle_recuperado)
            values                  (nuyear, numonth, rg.sesususc, rg.cuconuse, rgD.departamento,
                                     rgD.localidad, rgD.categoria,
                                     rgD.mercado, nuvolfac, nurango1, nutari1, nurango2, nutari2,
                                     nuvalfac, dtfecargo, sbrecuperado, sbdetrecu);

      nucont := nucont + 1;
      if mod(nucont,2000) = 0 then
        commit;
      end if;
    end if;
   end loop;
   commit;

   nulineaerror := 17;

  pro_grabalog (innusesion, 'LDTCFA', nuYear, nuMonth, idttoday, innuNroHilo, 2, 'Termino Hilo: ' || innuNroHilo || ' - Proceso Ok');

  exception when others then
   pro_grabalog (innusesion, 'LDTCFA', nuYear, nuMonth, idttoday, innuNroHilo, -1, 'Hilo: ' || innuNroHilo ||
                             ' Termino con errores (en el Contrato : ' || TO_CHAR(nususc) || 'LINEA ERROR : '||TO_CHAR(nulineaerror)||'). LA INFORMACION PUEDE NO ESTAR COMPLETA: ' || sqlerrm);
   rollback;
 end prFillTabla_Hilos;

/**************************************************************************************************/

  procedure pro_grabalog(inusesion  number,
                         inuproceso varchar2,
                         inuano     number,
                         inumes     number,
                         idtfecha   date,
                         inuhilo    number,
                         inuresult  number,
                         isbobse    varchar2) is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    insert into LDC_LOG_LDTCFA
      (sesion,
       proceso,
       usuario,
       ano,
       mes,
       fecha_inicio,
       fecha_final,
       hilo,
       resultado,
       observacion)
    values
      (inusesion,
       inuproceso,
       user,
       inuano,
       inumes,
       idtfecha,
       sysdate,
       inuhilo,
       inuresult,
       isbobse);
    commit;
  end pro_grabalog;

/**************************************************************************************************/


end LDC_PKTARICONSFACT;
/
Prompt Otorgando permisos sobre ADM_PERSON.LDC_PKTARICONSFACT
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('LDC_PKTARICONSFACT'), 'ADM_PERSON');
END;
/