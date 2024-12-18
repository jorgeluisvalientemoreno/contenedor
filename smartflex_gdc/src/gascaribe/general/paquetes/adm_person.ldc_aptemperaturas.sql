CREATE OR REPLACE package adm_person.ldc_aptemperaturas is

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  20/06/2024   Adrianavg   OSF-2848: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  /**********************************************************************************

  Propiedad intelectual de Gases del Caribe E.S.P (c).



  Unidad         : LDC_ApTemperaturas

  Descripcion    : Realiza aprobacion de las temperaturas y variables fijas configurados por localidad

                   tabla LDC_TEMP_VAVAFACO



  Autor          : Ronald Colpas Cantillo

  Fecha          : 10/01/2018



  Historia de Modificaciones

  Fecha             Autor                 Modificacion

  =========       ====================   ===========================================

  **********************************************************************************/



  Function funConsultaApT return pkConstante.tyRefCursor;



  procedure proAprobarApT(InConSe         number,

                          InuActReg       number,

                          InuTotalReg     number,

                          OnuErrorCode    out number,

                          OsbErrorMessage out varchar2);

end LDC_ApTemperaturas;
/
CREATE OR REPLACE package body adm_person.LDC_ApTemperaturas is



  /**********************************************************************************

  Propiedad intelectual de Gases del Caribe E.S.P (c).



  Unidad         : LDC_ApTemperaturas

  Descripcion    : Realiza aprobacion de las temperaturas y variables fijas configurados por localidad

                   tabla LDC_TEMP_VAVAFACO



  Autor          : Ronald Colpas Cantillo

  Fecha          : 10/01/2018



  Historia de Modificaciones

  Fecha             Autor                 Modificacion

  =========       ====================   ===========================================

  24-06-2018      RONCOL                 Se modifica para que consulte las capitales con

                                         localidades pendiente por aprobar.

  **********************************************************************************/



  Function funConsultaApT return pkConstante.tyRefCursor is



    rfcursor pkConstante.tyRefCursor;

    nuAno    ldc_templocfaco.temp_ano%type;

    nuMes    ldc_templocfaco.temp_mes%type;

    nuCap    ldc_templocfaco.capital%type;



    nuCont   number;



  begin

    ut_trace.trace('Inicio LDC_ApTemperaturas.funConsultaApT', 10);



    /*obtener los valores ingresados en la aplicacion PB LDCATEMPVF Aprobacion Temperaturas y Variables fijas*/

    nuAno := ge_boInstanceControl.fsbGetFieldValue('LDC_TEMPLOCFACO',

                                                      'TEMP_ANO');



    nuMes := ge_boInstanceControl.fsbGetFieldValue('LDC_TEMPLOCFACO',

                                                      'TEMP_MES');



    nuCap := ge_boInstanceControl.fsbGetFieldValue('LDC_TEMPLOCFACO',

                                                      'CAPITAL');



    if (nuAno is null) then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'El a?o no debe ser nulo');

      raise ex.CONTROLLED_ERROR;

    end if;



    if (nuMes is null) then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'El mes no debe ser nulo');

      raise ex.CONTROLLED_ERROR;

    end if;



    if (nuCap is null) then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'La capital no debe ser nula');

      raise ex.CONTROLLED_ERROR;

    end if;



    --Valida que haya registro de capitales por aprobar

    select count(*) into nuCont

      from ldc_templocfaco

    where temp_ano = nuAno

      and temp_mes = numes

      and capital = decode(nuCap, -1, capital, nuCap);



    if nuCont = 0 then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'No hay registro temperaturas de capitales por aprobar, para el periodo digitado.');

      raise ex.CONTROLLED_ERROR;

    end if;



    --Valida que haya registro de localidades por aprobar

    select count(*) into nuCont

      from ldc_templocacapi

    where temp_ano = nuAno

      and temp_mes = numes

      and capital = decode(nuCap, -1, capital, nuCap)

      and estado_apro in ('P', 'R');



    if nuCont = 0 then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'No hay registro temperaturas de localidades por aprobar, para el periodo digitado.');

      raise ex.CONTROLLED_ERROR;

    end if;



    OPEN rfcursor FOR

    select t.capital              Cod_Capital,

           g.description          Nom_Capital,

           t.variable_temperatura Variable,

           t.fecha_ini            Fecha_Inicial,

           t.fecha_fin            Fecha_Final,

           t.valor                Valor,

           t.valor_prom           Promedio

      from ldc_templocfaco t, ge_geogra_location g

     where t.temp_ano = nuAno

       and t.temp_mes = nuMes

       and t.capital = decode(nuCap, -1, t.capital, nuCap)

       and t.capital = g.geograp_location_id

       and exists (select 1

              from ldc_templocacapi

             where temp_ano = nuAno

               and temp_mes = nuMes

               and capital = t.capital

               and estado_apro in ('P', 'R'));





    ut_trace.trace('Fin LDC_ApTemperaturas.funConsultaApT', 10);



    return rfcursor;



  exception

    When ex.CONTROLLED_ERROR then

      raise ex.CONTROLLED_ERROR;

    When others then

      Errors.setError;

      raise ex.CONTROLLED_ERROR;

  end funConsultaApT;



  /**********************************************************************************

  Propiedad intelectual de Gases del Caribe E.S.P (c).



  Unidad         : proAprobarApT

  Descripcion    : Realiza  proceso de aprobacion de las temperaturas y variables fijas

                   configuradas por localidad tabla LDC_TEMP_VAVAFACO



  Autor          : Ronald Colpas Cantillo

  Fecha          : 10/01/2018



  Historia de Modificaciones

  Fecha             Autor                 Modificacion

  =========       ====================   ===========================================

  24-06-2018      RONCOL                 Se modifica para que haga la aprobacion de temperaturas

                                         por a?o, mes y cap?tal seleccionada.

                                         Valida que haya temperaturas pendientes por aprobar por localidad

  16-04-2019      RONCOL.C200-2551       Se corrige para que se procese las variables fijas para las localidad

                                         y no que se duplique en las capitales.

  28-04-2019      RONCOL.C200-2551       Se modifica para que cuando se apruben los valores de las variables fijas

                                         antes de hacer el registro, ajuste la fecha final de la vigencia anterior

                                         se le resta un dia de la fecha inicial de la vigencia que se este aprobando.

  **********************************************************************************/

  procedure proAprobarApT(InConSe         number,

                          InuActReg       number,

                          InuTotalReg     number,

                          OnuErrorCode    out number,

                          OsbErrorMessage out varchar2) is



    nuAno      ldc_templocfaco.temp_ano%type;

    nuMes      ldc_templocfaco.temp_mes%type;

    nuCap      ldc_templocfaco.capital%type;

    nuSec      cm_vavafaco.vvfccons%type;

    sbAprueb   conssesu.cossflli%type;

    nuCont     Number;



    --Se consultan las temperaturas de las capitales

    cursor cuTempCap is

      select *

        from ldc_templocfaco

       where temp_ano = nuAno

         and temp_mes = nuMes

         and capital  = decode(nuCap, -1, capital, nuCap);



    --Se consulta las temperaturas de las localidades asociadas a la capital

    cursor cuTempLoc(nuLoc ldc_templocacapi.capital%type) is

     select *

        from ldc_templocacapi

       where temp_ano = nuAno

         and temp_mes = nuMes

         and capital  = nuLoc

         and estado_apro in ('P', 'R');



    --Se consulta las variables fijas de las localidades

    cursor cuValorVariables(nuLoc ldc_varifacolo.ubicacion_localidad%type) is

      select *

         from ldc_varifacolo t

        where t.ubicacion_localidad = nuLoc;



    rg cuValorvariables%rowtype;



  begin





    ut_trace.trace('Inicio LDC_ApTemperaturas.proAprobarApT', 10);



    sbAprueb := ge_boInstanceControl.fsbGetFieldValue('CONSSESU',

                                                      'COSSFLLI');



    nuAno := ge_boInstanceControl.fsbGetFieldValue('LDC_TEMPLOCFACO',

                                                      'TEMP_ANO');



    nuMes := ge_boInstanceControl.fsbGetFieldValue('LDC_TEMPLOCFACO',

                                                      'TEMP_MES');



    nuCap := ge_boInstanceControl.fsbGetFieldValue('LDC_TEMPLOCFACO',

                                                      'CAPITAL');



    if (nuAno is null) then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'El a?o no debe ser nulo');

      raise ex.CONTROLLED_ERROR;

    end if;



    if (nuMes is null) then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'El mes no debe ser nulo');

      raise ex.CONTROLLED_ERROR;

    end if;



    if (nuCap is null) then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'La capital no debe ser nula');

      raise ex.CONTROLLED_ERROR;

    end if;



    nuCap := InConSe;



    --Valida que haya registro de capitales por aprobar

    select count(*) into nuCont

      from ldc_templocfaco

    where temp_ano = nuAno

      and temp_mes = numes

      and capital = decode(nuCap, -1, capital, nuCap);



    if nuCont = 0 then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'No hay registro temperaturas de capitales por aprobar, para el periodo digitado.');

      raise ex.CONTROLLED_ERROR;

    end if;



    --Valida que haya registro de localidades por aprobar

    select count(*) into nuCont

      from ldc_templocacapi

    where temp_ano = nuAno

      and temp_mes = numes

      and capital = decode(nuCap, -1, capital, nuCap)

      and estado_apro in ('P', 'R');



    if nuCont = 0 then

      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'No hay registro temperaturas de localidades por aprobar, para el periodo digitado.');

      raise ex.CONTROLLED_ERROR;

    end if;



    if upper(sbAprueb) = 'N' then



      select count(*) into nuCont

        from ldc_templocfaco

       where temp_ano = nuAno

         and temp_mes = numes

         and capital = decode(nuCap, -1, capital, nuCap)

         and estado_apro = 'A';



      if nuCont != 0 then

        Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                        'No es permitido realizar el rechazo si se encuentra aprobada la TEMPERATURA de la capital.');

        raise ex.CONTROLLED_ERROR;

      end if;



      --Realiza rechazo de las localides asociadas a la capital.

      for rgC in cuTempCap loop



        --Registramos la temperatura de la capital, si no esta aprobada.

        if rgC.Estado_Apro in ('P', 'R') then

          --Actualizar el estado de aprobacion de la capital

          update ldc_templocfaco t

             set estado_apro = 'R',

                 fecha_apro = sysdate

           where temp_ano = nuAno

             and temp_mes = nuMes

             and capital = rgc.capital;

        end if;



        --Actualiza el estado de a rechazado de las localidades pendientes

        for rgL in cuTempLoc(rgc.capital) loop



          update ldc_templocacapi

             set estado_apro = 'R',

                 fech_apro = sysdate

           where temp_ano = nuAno

             and temp_mes = nuMes

             and capital = rgl.capital

             and localidad = rgl.localidad;



        end loop;

      end loop;



      commit;



      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'Valores de Temperaturas y Variables fijas no fueron aprobadas, verifique.');

      raise ex.CONTROLLED_ERROR;

    end if;



    --Procesar la informacion de las temperaturas

    for rgC in cuTempCap loop



      --Registramos la temperatura de la capital, si no esta aprobada.

      if rgC.Estado_Apro in ('P', 'R') then

        --C200-2551 Actualiza la vigencia anterior su fecha final anterior se le asigna la inicial actual - 1
        update ldc_templocfaco
           set fecha_fin = rgc.fecha_ini - 1
         where consecutivo in
               (select consecutivo
                  from ldc_templocfaco
                 where capital = rgc.capital
                   and variable_temperatura = 'TEMPERATURA'
                   and (temp_ano != nuAno or temp_mes != nuMes)
                   and fecha_fin =
                       (select max(fecha_fin)
                          from ldc_templocfaco
                         where capital = rgc.capital
                           and variable_temperatura = 'TEMPERATURA'
                           and (temp_ano != nuAno or temp_mes != nuMes))
                   and fecha_fin > rgc.fecha_ini);

        --Actualizar el estado de aprobacion de la capital

        update ldc_templocfaco t

           set estado_apro = 'A',

               fecha_apro = sysdate

         where temp_ano = nuAno

           and temp_mes = nuMes

           and capital = rgc.capital;

        --C200-2551 La antes de registrar la vigencia a la fecha final anterior se le asigna la inicial actual - 1
        update cm_vavafaco
           set vvfcfefv = rgc.fecha_ini - 1
         where vvfccons in
               (select vvfccons
                  from cm_vavafaco
                 where vvfcubge = rgc.capital
                   and vvfcvafc = rgc.variable_temperatura
                   and vvfcfefv = (select max(vvfcfefv)
                                     from cm_vavafaco
                                    where vvfcubge = rgc.capital
                                      and vvfcvafc = rgc.variable_temperatura)
                   and vvfcfefv > rgc.fecha_ini);

        begin

          nuSec := OPEN.PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SQ_CM_VAVAFACO_198733');

          insert into cm_vavafaco

            (vvfccons,

             vvfcvafc,

             vvfcfeiv,

             vvfcfefv,

             vvfcvalo,

             vvfcvapr,

             vvfcubge,

             vvfcsesu)

          values

            (nuSec,

             rgc.variable_temperatura,

             rgc.fecha_ini,

             rgc.fecha_fin,

             rgc.valor,

             rgc.valor_prom,

             rgc.capital,

             null);

        exception when others then

          Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'Error al insertar los datos en cm_vavafaco. '||sqlerrm);

          raise ex.CONTROLLED_ERROR;

        end;

        --procesamos las variables fijas para la capital

        for rgV in cuValorVariables(rgc.capital) loop

          --C200-2551 La antes de registrar la vigencia a la fecha final anterior se le asigna la inicial actual - 1
          update cm_vavafaco
             set vvfcfefv = rgc.fecha_ini - 1
           where vvfccons in
                 (select vvfccons
                    from cm_vavafaco
                   where vvfcubge = rgc.capital
                     and vvfcvafc = rgv.variable
                     and vvfcfefv = (select max(vvfcfefv)
                                       from cm_vavafaco
                                      where vvfcubge = rgc.capital
                                        and vvfcvafc = rgv.variable)
                     and vvfcfefv > rgc.fecha_ini);

          begin

            nuSec := OPEN.PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SQ_CM_VAVAFACO_198733');

            insert into cm_vavafaco

              (vvfccons,

               vvfcvafc,

               vvfcfeiv,

               vvfcfefv,

               vvfcvalo,

               vvfcvapr,

               vvfcubge,

               vvfcsesu)

            values

              (nuSec,

               rgv.variable,

               rgc.fecha_ini,

               rgc.fecha_fin,

               rgv.valor_variable,

               rgv.promedio_variable,

               rgc.capital,

               null);

          exception when others then

            Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'Error al insertar los datos en cm_vavafaco. '||sqlerrm);

            raise ex.CONTROLLED_ERROR;

          end;

        end loop;

      end if;



      for rgL in cuTempLoc(rgc.capital) loop



        update ldc_templocacapi

           set estado_apro = 'A',

               fech_apro = sysdate

         where temp_ano = nuAno

           and temp_mes = nuMes

           and capital = rgl.capital

           and localidad = rgl.localidad;


        --C200-2551 La antes de registrar la vigencia a la fecha final anterior se le asigna la inicial actual - 1
        update cm_vavafaco
           set vvfcfefv = rgc.fecha_ini - 1
         where vvfccons in
               (select vvfccons
                  from cm_vavafaco
                 where vvfcubge = rgl.localidad
                   and vvfcvafc = rgc.variable_temperatura
                   and vvfcfefv = (select max(vvfcfefv)
                                     from cm_vavafaco
                                    where vvfcubge = rgl.localidad
                                      and vvfcvafc = rgc.variable_temperatura)
                   and vvfcfefv > rgc.fecha_ini);

        begin

          --Registramos la temperatura de la localidad.

          nuSec := OPEN.PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SQ_CM_VAVAFACO_198733');

          insert into cm_vavafaco

            (vvfccons,

             vvfcvafc,

             vvfcfeiv,

             vvfcfefv,

             vvfcvalo,

             vvfcvapr,

             vvfcubge,

             vvfcsesu)

          values

            (nuSec,

             rgc.variable_temperatura,

             rgc.fecha_ini,

             rgc.fecha_fin,

             rgc.valor,

             rgc.valor_prom,

             rgl.localidad,

             null);

        exception when others then

          Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                      'Error al insertar los datos en cm_vavafaco. '||sqlerrm);

          raise ex.CONTROLLED_ERROR;

        end;



        --procesamos las variables fijas para la localidad

        for rgV in cuValorVariables(rgl.localidad) loop

          --C200-2551 La antes de registrar la vigencia a la fecha final anterior se le asigna la inicial actual - 1
          update cm_vavafaco
             set vvfcfefv = rgc.fecha_ini - 1
           where vvfccons in
                 (select vvfccons
                    from cm_vavafaco
                   where vvfcubge = rgl.localidad
                     and vvfcvafc = rgv.variable
                     and vvfcfefv = (select max(vvfcfefv)
                                       from cm_vavafaco
                                      where vvfcubge = rgl.localidad
                                        and vvfcvafc = rgv.variable)
                     and vvfcfefv > rgc.fecha_ini);


          begin

            nuSec := OPEN.PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SQ_CM_VAVAFACO_198733');

            insert into cm_vavafaco

              (vvfccons,

               vvfcvafc,

               vvfcfeiv,

               vvfcfefv,

               vvfcvalo,

               vvfcvapr,

               vvfcubge,

               vvfcsesu)

            values

              (nuSec,

               rgv.variable,

               rgc.fecha_ini,

               rgc.fecha_fin,

               rgv.valor_variable,

               rgv.promedio_variable,

               rgl.localidad, --C200-2551 --rgc.capital,

               null);

          exception when others then

            Errors.SetError(Ld_Boconstans.cnuGeneric_Error,

                        'Error al insertar los datos en cm_vavafaco. '||sqlerrm);

            raise ex.CONTROLLED_ERROR;

          end;

        end loop;

      end loop;

    end loop;







   commit;





    ut_trace.trace('Fin LDC_ApTemperaturas.proAprobarApT', 10);



  exception

    When ex.CONTROLLED_ERROR then

      rollback;

      raise ex.CONTROLLED_ERROR;

    When others then

      rollback;

      Errors.setError;

      raise ex.CONTROLLED_ERROR;

  end proAprobarApT;

end LDC_ApTemperaturas;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_APTEMPERATURAS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_APTEMPERATURAS', 'ADM_PERSON'); 
END;
/
