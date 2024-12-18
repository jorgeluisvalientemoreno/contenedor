CREATE OR REPLACE Package adm_person.ldc_pkcm_rescalcvar Is
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   26/06/2024   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
  Function fnucalcvartemp(inuproducto  In servsusc.sesunuse%Type,
                          inupericons  In open.pericose.pecscons%Type,
                          inuraiserror Number Default 1) Return Number;

  Function fnucalcvarpresionatm(inuproducto  In servsusc.sesunuse%Type,
                                inutempprod  In open.cm_vavafaco.vvfcvalo%Type,
                                inuraiserror Number Default 1) Return Number;

  Procedure proaplicacreg_033_2015(inuproducto In servsusc.sesunuse%Type,
                                   inupericons In open.pericose.pecscons%Type);

End ldc_pkcm_rescalcvar;
/
CREATE OR REPLACE Package Body adm_person.ldc_pkcm_rescalcvar Is

  /***********************************************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: Ldc_Pkcm_ResCalcVar
  Descripcion:        Paquete que contiene la logica para gestionar las resoluciones CREG
                      de manera centralizada

  Autor    : Oscar Ospino P. / Ludycom S.A
  Fecha    : 28-09-2016 CA200-731

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------

  ***********************************************************************************************/

  /* Variables Generales */
  --gnusesion        Constant Number := userenv('sessionid');
  gsbpaquete       Constant Varchar2(30) := 'LDC_PKCM_RESCALCVAR';
  csbentrega200731 Constant Varchar2(100) := 'OSS_OPE_OOP_200731_1';

  /* Variables Resoluciones CREG */
  --Resolucion CREG 033/2015 --CA 200-731
  cnupresionatm Constant Number(14, 4) := dald_parameter.fnugetnumeric_value('PRESIONATM', 0); --Presion Atmosferica
  cnugravedad   Constant Number(4, 1) := dald_parameter.fnugetnumeric_value('GRAVEDAD', 0); --Gravedad Standar de la Tierra (M/s2)
  cnuaireseco   Constant Number(14, 4) := dald_parameter.fnugetnumeric_value('AIRESECO', 0); --Aire Seco
  cnueuler      Constant Number(14, 13) := 2.7182818284590; --Constante Euler
  gnutempproducto    Number(10, 4); --Temperatura calculada para el Producto
  gnupresatmproducto Number(10, 4); --Presion Atmosferica calculada para el Producto

  bocreg_033_2015 Constant Boolean := Case
                                        When open.dald_parameter.fsbgetvalue_chain('CM_RESOLU_CREG_033_2015', 0) =
                                             'TRUE' Then
                                         True
                                        Else
                                         False
                                      End;

  Procedure prologtrace(isbmensaje Varchar2) As
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: ProLogTrace
    Descripcion:        Proceso para unificar la sentencia para mostrar mensaje en el output y la traza.

    Autor    : Oscar Ospino P. / Ludycom S.A
    Fecha    : 29-09-2016 CA200-731

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------

    ***********************************************************************************************/
    sberror Varchar2(30000);
  Begin

    dbms_output.put_line(isbmensaje);
    ut_trace.trace(isbmensaje, 10);

  Exception
    When Others Then
      sberror := 'Error no Controlado | No se pudo mostrar el mensaje en el Output/Trace. | Detalle: ' ||
                 Sqlerrm;
      dbms_output.put_line(sberror);
      ut_trace.trace(sberror, 10);
  End;

  Function fnucalcvartemp(inuproducto  In servsusc.sesunuse%Type,
                          inupericons  In open.pericose.pecscons%Type,
                          inuraiserror In Number Default 1) Return Number Is

    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: FnuCalcVarTemp
    Descripcion:        Funcion para calcular la variable Temperatura para un producto segun resolucion
                        CREG 033/2015.

    Parametros
    ----------
    inuproducto :       Producto
    inupericons :       Periodo de Consumo
    inuraiserror:       Flag para indicar si la funcion instancia el error

    Autor       :       Oscar Ospino P. / Ludycom S.A
    Fecha       :       03-10-2016 CA200-731

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------

    ***********************************************************************************************/

    --Producto
    --inuproducto servsusc.sesunuse%Type := 201820;
    --Periodo de consumo
    --inupericons open.pericose.pecscons%Type := 34378;

    sbproceso Varchar2(4000) := gsbpaquete || '.' || 'FnuCalcVarTemp';
    nupaso    Number; -- Ultimo paso ejecutado antes de ocurrir el error

    nucant Number := 0; --Contador de Registros
    --Rango Fechas Periodo COnsumo
    dtpecofeini open.pericose.pecsfeci%Type;
    dtpecofefin open.pericose.pecsfecf%Type;
    --Numero de dias Periodo
    nudiaspeco Number;

    -- Inicio Variables Segmento A del Periodo de Consumo
    nuconsseg_a   Number; --Consecutivo Variable Temp Segmento A Periodo
    numesa        Number; --Mes del Segmento
    numesadias    Number; --Numero de Dias del Segmento
    numesavaltemp Number(10, 4); --Variable temperatura Segmento A
    --dtvar_rangoa_feini open.pericose.pecsfeci%Type; --Fechas Segmento (Para dias del mes anterior)
    dtvar_rangoa_fefin open.pericose.pecsfecf%Type; --Fechas Segmento (Para dias del mes anterior)
    -- Fin Variables Segmento A

    -- Inicio Variables Segmento B del Periodo de Consumo
    nuconsseg_b        Number; --Consecutivo Variable Temp Segmento B Periodo
    numesb             Number; --Mes del Segmento
    numesbdias         Number; --Numero de Dias del Segmento
    numesbvaltemp      Number(10, 4); --Variable temperatura Segmento B
    dtvar_rangob_feini open.pericose.pecsfeci%Type; --Fechas Segmento (Para dias del mes posterior)
    --dtvar_rangob_fefin open.pericose.pecsfecf%Type; --Fechas Segmento (Para dias del mes posterior)
    -- Fin Variables Segmento B

    --Localidad del producto
    nuloca open.ab_address.geograp_location_id%Type;

    --Control Errores
    nuerror Number;
    sberror Varchar2(4000);
  Begin
    prologtrace(chr(10) || 'Inicia ' || sbproceso);

    --obtengo la localidad del producto -52
    nupaso := 10;
    Select Count(ad.geograp_location_id)
      Into nucant
      From open.pr_product pr, open.ab_address ad
     Where pr.address_id = ad.address_id
       And pr.product_id = inuproducto;
    If nucant > 0 Then
      Select ad.geograp_location_id
        Into nuloca
        From open.pr_product pr, open.ab_address ad
       Where pr.address_id = ad.address_id
         And pr.product_id = inuproducto;
    Else
      nuerror := nupaso;
      sberror := 'Paso ' || nuerror || ' | Error al obtener la localidad del Producto. | ' ||
                 Sqlerrm;
      prologtrace(sberror); --Log
      Raise ex.controlled_error;
    End If;

    prologtrace('Localidad: ' || nuloca);

    --Obtener el periodo consumo, validar periodo Consumo
    Begin
      nupaso := 20;
      Select Distinct p.pecsfeci, p.pecsfecf, round(p.pecsfecf - p.pecsfeci)
        Into dtpecofeini, dtpecofefin, nudiaspeco
        From pericose p
       Where p.pecscons = inupericons;
    Exception
      When Others Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror ||
                   ' | Error al obtener el rango de fechas del Periodo de Consumo. | ' || Sqlerrm;
        prologtrace(sberror); --Log
        Raise ex.controlled_error;
    End;

    --Log
    prologtrace('Periodo de Consumo: ' || inupericons || ' | Rango: ' ||
                to_char(dtpecofeini, 'dd/mm/yyyy') || ' - ' || to_char(dtpecofefin, 'dd/mm/yyyy') ||
                ' | Num Dias Peco: ' || nudiaspeco);

    --Nota: Los periodos de consumo generalmente tienen dias en diferentes meses.

    --obtengo el mes de la fecha de inicio del periodo
    Select to_number(to_char(dtpecofeini, 'MM')) Into numesa From dual;
    --obtengo el mes de la fecha de final del periodo
    Select to_number(to_char(dtpecofefin, 'MM')) Into numesb From dual;

    --obtengo el valor de la Variable temperatura de la localidad en el rango de fechas del Segmento A
    Begin
      nupaso := 30;
      Select v.vvfccons, v.vvfcvalo, v.vvfcfefv, v.vvfcfefv - dtpecofeini + 1
        Into nuconsseg_a, numesavaltemp, dtvar_rangoa_fefin, numesadias
        From open.cm_vavafaco v
       Where v.vvfcubge = nuloca
         And v.vvfcvafc = open.cm_bccorrectfactorsvars.csbtemperatura
         And (dtpecofeini Between v.vvfcfeiv And v.vvfcfefv);

      --Log
      prologtrace('Vvfccons:' || nuconsseg_a || ' | Temperatura Localidad: ' || numesavaltemp ||
                  ' | Rango de Variable dentro del Pericons: ' ||
                  to_char(dtpecofeini, 'dd/mm/yyyy') || ' - ' ||
                  to_char(dtvar_rangoa_fefin, 'dd/mm/yyyy') || ' | # Dias: ' || numesadias);
    Exception
      When no_data_found Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror ||
                   ' | Error: No se encontró un registro de TEMPERATURA para la Localidad ' ||
                   nuloca || ' en el periodo de consumo ' || inupericons || ' | Segmento ' ||
                   to_char(dtpecofeini, 'dd/mm/yyyy') || ' - ' ||
                   to_char(dtvar_rangoa_fefin, 'dd/mm/yyyy');
        prologtrace(sberror); --Log
        Raise ex.controlled_error;

      When too_many_rows Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror ||
                   ' | Error: Existe mas de un registro de TEMPERATURA para la Localidad ' ||
                   nuloca || ' en el periodo de consumo ' || inupericons || ' | Segmento ' ||
                   to_char(dtpecofeini, 'dd/mm/yyyy') || ' - ' ||
                   to_char(dtvar_rangoa_fefin, 'dd/mm/yyyy');
        prologtrace(sberror); --Log
        Raise ex.controlled_error;

      When ex.controlled_error Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror || ' | Error: temperatura de la Localidad ' || nuloca ||
                   ' no valida ' || ' | Segmento ' || to_char(dtpecofeini, 'dd/mm/yyyy') || ' - ' ||
                   to_char(dtvar_rangoa_fefin, 'dd/mm/yyyy');
        prologtrace(sberror); --Log
        Raise ex.controlled_error;

      When Others Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror ||
                   ' | Error no controlado al obtener la temperatura de la Localidad ' || nuloca ||
                   ' | Segmento ' || to_char(dtpecofeini, 'dd/mm/yyyy') || ' - ' ||
                   to_char(dtvar_rangoa_fefin, 'dd/mm/yyyy') || ' | ' || Sqlerrm;
        prologtrace(sberror); --Log
        Raise ex.controlled_error;
    End;

    --obtengo el valor de la Variable temperatura de la localidad en el rango de fechas del Segmento B
    Begin
      nupaso := 40;
      Select c2.vvfccons, c2.vvfcvalo, c2.vvfcfeiv, trunc(dtpecofefin) - dtvar_rangoa_fefin
        Into nuconsseg_b, numesbvaltemp, dtvar_rangob_feini, numesbdias
        From (Select v.vvfccons, v.vvfcvalo, v.vvfcfeiv
                From open.cm_vavafaco v
               Where v.vvfcubge = nuloca
                 And v.vvfcvafc = open.cm_bccorrectfactorsvars.csbtemperatura
                 And (trunc(dtvar_rangoa_fefin) + 1 Between v.vvfcfeiv And v.vvfcfefv Or
                     trunc(dtpecofefin) Between v.vvfcfeiv And v.vvfcfefv)
               Order By v.vvfccons Desc) c2
       Where rownum <= 1;

      --Log
      prologtrace('Vvfccons:' || nuconsseg_b || ' | Temperatura Localidad: ' || numesbvaltemp ||
                  numesbdias || ' | Rango de Variable dentro del Pericons: ' ||
                  to_char(dtvar_rangoa_fefin + 1, 'dd/mm/yyyy') || ' - ' ||
                  to_char(dtpecofefin, 'dd/mm/yyyy') || ' | # Dias: ' || numesbdias);

      If nvl(numesavaltemp, 0) = 0 Or nvl(numesbvaltemp, 0) = 0 Then
        --Temperatura localidad con dato invalido
        Raise ex.controlled_error;
      End If;

    Exception
      When no_data_found Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror ||
                   ' | Error: No se encontró un registro de TEMPERATURA para la Localidad ' ||
                   nuloca || ' en el periodo de consumo ' || inupericons || ' | Segmento ' ||
                   to_char(dtvar_rangoa_fefin + 1, 'dd/mm/yyyy') || ' - ' ||
                   to_char(dtpecofefin, 'dd/mm/yyyy');
        prologtrace(sberror); --Log
        Raise ex.controlled_error;

      When too_many_rows Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror ||
                   ' | Error: Existe mas de un registro de TEMPERATURA para la Localidad ' ||
                   nuloca || ' en el periodo de consumo ' || inupericons || ' | Segmento ' ||
                   to_char(dtvar_rangoa_fefin + 1, 'dd/mm/yyyy') || ' - ' ||
                   to_char(dtpecofefin, 'dd/mm/yyyy');
        prologtrace(sberror); --Log
        Raise ex.controlled_error;

      When ex.controlled_error Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror || ' | Error: temperatura de la Localidad ' || nuloca ||
                   ' no valida ' || ' | Segmento ' || to_char(dtvar_rangoa_fefin + 1, 'dd/mm/yyyy') ||
                   ' - ' || to_char(dtpecofefin, 'dd/mm/yyyy');
        prologtrace(sberror); --Log
        Raise ex.controlled_error;

      When Others Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror ||
                   ' | Error no controlado al obtener la temperatura de la Localidad ' || nuloca ||
                   ' | Segmento ' || to_char(dtvar_rangoa_fefin + 1, 'dd/mm/yyyy') || ' - ' ||
                   to_char(dtpecofefin, 'dd/mm/yyyy') || ' | ' || Sqlerrm;
        prologtrace(sberror); --Log
        Raise ex.controlled_error;
    End;

    Begin
      nupaso := 50;

      gnutempproducto := ((numesavaltemp * numesadias) + (numesbvaltemp * numesbdias)) / nudiaspeco;

      prologtrace(chr(10) || '--<< Temperatura del Producto: ' || gnutempproducto || ' >>--' ||
                  chr(10));

    Exception
      When Others Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror || ' | Error al calcular la temperatura de para el producto ' ||
                   inuproducto || ' | ' || Sqlerrm;
        prologtrace(sberror); --Log
        Raise ex.controlled_error;
    End;

    prologtrace('Fin ' || sbproceso);

    Return gnutempproducto;

  Exception
    When ex.controlled_error Then
      If inuraiserror = 1 Then
        sberror := 'Error Proceso: ' || sbproceso || ' | Paso ' || nupaso || ' | ' || sberror ||
                   chr(10) || Sqlerrm;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, chr(10) || 'Error: ' ||
                                          nuerror || ' - ' ||
                                          sberror || chr(10));
      Else
        Return Null;
      End If;
    When Others Then
      If inuraiserror = 1 Then
        sberror := ' Error No Controlado | ' || 'Proceso: ' || sbproceso || ' | Paso ' || nupaso ||
                   ' | ' || sberror || chr(10) || Sqlerrm;
        prologtrace(sberror); --Log
        errors.seterror;
        Raise ex.controlled_error;
      Else
        Return Null;
      End If;

  End fnucalcvartemp;

  Function fnucalcvarpresionatm(inuproducto  In servsusc.sesunuse%Type,
                                inutempprod  In open.cm_vavafaco.vvfcvalo%Type,
                                inuraiserror In Number Default 1) Return Number Is
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: FnuCalcVarPresionAtm
    Descripcion:        Funcion para calcular la variable PRESION_ATMOSFERICA para un producto segun
                        resolucion CREG 033/2015.

    inuproducto :       Producto
    inutempprod :       Temperatura del producto (Calculada con FnuCalcVarTemp)
    inuraiserror:       Flag para indicar si la funcion instancia el error

    Autor       :       Oscar Ospino P. / Ludycom S.A
    Fecha       :       03-10-2016 CA200-731

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------

    ***********************************************************************************************/

    sbproceso Varchar2(4000) := gsbpaquete || '.' || 'FnuCalcVarPresionAtm';
    nupaso    Number := 0; -- Ultimo paso ejecutado antes de ocurrir el error
    nucant    Number := 0; -- Contador de Registros

    nuloca   open.ab_address.geograp_location_id%Type; --Localidad del producto
    nupredio open.ldc_info_predio.premise_id%Type;
    --Predio del Producto
    nualtura            Number(10, 4); --Altura
    nutemperaturakelvin Number(10, 4); --Temperatura Convertida a Kelvin
    --Control Errores
    nuerror Number;
    sberror Varchar2(4000);
  Begin

    prologtrace(chr(10) || 'Inicia ' || sbproceso);

    nupaso   := 10;
    nupredio := open.daab_address.fnugetestate_number(dapr_product.fnugetaddress_id(inuproducto, 0), 0);
    prologtrace('Producto: ' || inuproducto || ' | ID Predio: ' || nupredio); --Log

    nupaso := 20;
    prologtrace('Obtengo la altura del Predio en LDC_INFO_PREDIO'); --Log

    Select Count(altura_predio)
      Into nucant
      From open.ldc_info_predio ip
     Where ip.premise_id = nupredio;
    If nucant > 0 Then
      nupaso := 30;
      --Se toma el Minimo valor (Hoja 4 Resol CREG 033/2015)
      Select Min(altura_predio)
        Into nualtura
        From open.ldc_info_predio ip
       Where ip.premise_id = nupredio;
      prologtrace('Altura Predio: --<<' || nualtura || '>>--');
    Else
      --No Altura de Producto, obtener Altura de la Localidad
      prologtrace('Paso ' || nupaso || ' | No se pudo obtener la Altura del Producto ' ||
                  inuproducto || ' en LDC_INFO_PREDIO | Se tomara de la Localidad del Producto'); --Log

      --obtengo la localidad del producto -52
      nupaso := 40;
      Select Count(ad.geograp_location_id)
        Into nucant
        From open.pr_product pr, open.ab_address ad
       Where pr.address_id = ad.address_id
         And pr.product_id = inuproducto;
      If nucant > 0 Then
        nupaso := 50;
        Select Distinct ad.geograp_location_id
          Into nuloca
          From open.pr_product pr, open.ab_address ad
         Where pr.address_id = ad.address_id
           And pr.product_id = inuproducto;
      Else
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror || ' | Error al obtener la localidad del Producto.';
        prologtrace(sberror); --Log
        Raise ex.controlled_error;
      End If;

      --Altura de la localidad
      nupaso := 60;
      Select Count(altura) Into nucant From ldc_altura_loc al Where al.localidad = nuloca;
      If nucant > 0 Then
        --Se toma el Minimo valor (Hoja 4 Resol CREG 033/2015)
        nupaso := 70;
        Select Min(altura) Into nualtura From ldc_altura_loc al Where al.localidad = nuloca;
        prologtrace('Localidad: ' || nuloca || ' | Altura Localidad: --<<' || nualtura || '>>--');
      Else
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror || ' | Error al obtener la Altura de la localidad.';
        prologtrace(sberror); --Log
        Raise ex.controlled_error;
      End If;
    End If;

    nupaso := 80;
    --gnutempproducto := fnucalcvartemp(inuproducto, inupericons, 0);
    If nvl(inutempprod, 0) > 0 Then
      Begin
        --Log
        prologtrace('--<< Convirtiendo temperatura de Grados Fahrenheit a Grados Kelvin >>--');
        nutemperaturakelvin := (inutempprod + 459.67) / 1.8;

        prologtrace('Temperatura en Fahrenheit: ' || inutempprod ||
                    ' | Nueva temperatura en Kelvin: ' || nutemperaturakelvin); --Log
      Exception
        When Others Then
          nuerror := nupaso;
          sberror := 'Paso ' || nuerror ||
                     ' | Error al convertir la temperatura del producto a Grados Kelvin. | ' ||
                     Sqlerrm;
          prologtrace(sberror); --Log
          Raise ex.controlled_error;
      End;
    Else
      --Error al Validar la temperatura
      prologtrace('Temperatura en Fahrenheit: ' || inutempprod);
      nuerror := nupaso;
      sberror := 'Paso ' || nuerror || ' | Error: Temperatura no Valida: <<' || inutempprod ||
                 '>> | No se podra calcular la Presion Atmosferica. Division entre Cero.';
      prologtrace(sberror); --Log
      Raise ex.controlled_error;
    End If;

    prologtrace('--<< Calculando Presion Atmosferica para el producto >>--'); --Log
    prologtrace('Constantes:' || chr(10) || 'Presion Atmosferica de la Tierra: ' || cnupresionatm ||
                chr(10) || 'Gravedad: ' || cnugravedad || chr(10) || 'Aire Fresco: ' ||
                cnuaireseco || chr(10) || 'Numero Euler: ' || cnueuler || chr(10) || 'Altura: ' ||
                nualtura || chr(10) || 'Temperatura Kelvin Producto: ' || nutemperaturakelvin); --Log

    nupaso := 90;
    Begin
      --https://efrainpuerto.wordpress.com/2011/02/26/f1-2/
      gnupresatmproducto := cnupresionatm *
                            power(cnueuler, ((-cnugravedad * nualtura) /
                                   (cnuaireseco * nutemperaturakelvin)));
      gnupresatmproducto := gnupresatmproducto * 0.00014503773773;

    Exception
      When Others Then
        nuerror := nupaso;
        sberror := 'Paso ' || nuerror || ' | Error al calcular la Presion Atmosferica. | ' ||
                   Sqlerrm;
        prologtrace(sberror); --Log
        Raise ex.controlled_error;
    End;

    prologtrace(chr(10) || '--<< Presion Atmosferica Producto: ' || gnupresatmproducto || ' >>--' ||
                chr(10)); --Log

    prologtrace('Fin ' || sbproceso);

    Return gnupresatmproducto;

  Exception
    When ex.controlled_error Then
      If inuraiserror = 1 Then
        sberror := 'Error Proceso: ' || sbproceso || ' | Paso ' || nupaso || ' | ' || sberror ||
                   chr(10) || Sqlerrm;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, chr(10) || 'Error: ' ||
                                          nuerror || ' - ' ||
                                          sberror || chr(10));
      Else
        Return Null;
      End If;
    When Others Then
      If inuraiserror = 1 Then
        sberror := ' Error No Controlado | ' || 'Proceso: ' || sbproceso || ' | Paso ' || nupaso ||
                   ' | ' || sberror || chr(10) || Sqlerrm;
        prologtrace(sberror); --Log
        errors.seterror;
        Raise ex.controlled_error;
      Else
        Return Null;
      End If;

  End;

  Procedure proactvarprod(inuproducto In servsusc.sesunuse%Type,
                          isbvariable In cm_vavafaco.vvfcvafc%Type,
                          inuvalor    In cm_vavafaco.vvfcvalo%Type,
                          onuerror    Out Number,
                          osberror    Out Varchar2) Is

    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: ProActVarProd
    Descripcion:        Proceso para Crear/Actualizar las variables de consumo para un producto en CM_VAVAFACO.
                        Valida si para el producto existe un registro vigente de la variable con valor
                        diferente al pasado por parametro.
                        El proceso esta marcado como Transaccion Autonoma.

    inuproducto       : Producto
    isbvariable       : Nombre de la Variable que se crear? o Actualizar?.
    inuvalor          : Nuevo valor vigente para la Variable
    onuerror          : Numero del error/Ultimo Paso ejecutado
    osberror          : Mensaje del error

    Autor       :       Oscar Ospino P. / Ludycom S.A
    Fecha       :       03-10-2016 CA200-731

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------

    ***********************************************************************************************/

    Pragma Autonomous_Transaction;

    nucant         Number := 0;
    rcvavafaco     cm_vavafaco%Rowtype;
    nuvarid        cm_vavafaco.vvfccons%Type;
    bodebeinsertar Boolean := False;
    --    temperatura_anterior rcvavafaco.vvfcvalo%Type;

    sbproceso Varchar2(4000) := gsbpaquete || '.' || 'ProActVarProd';
    nupaso    Number := 0; -- Ultimo paso ejecutado antes de ocurrir el err

  Begin

    prologtrace(chr(10) || 'Inicia ' || sbproceso);

    --valida si el producto tiene vigente la variable
    nupaso := 10;
    Select Count(*)
      Into nucant
      From open.cm_vavafaco v
     Where v.vvfcvafc = isbvariable
       And v.vvfcsesu = inuproducto
       And (Sysdate Between v.vvfcfeiv And v.vvfcfefv)
     Order By v.vvfccons Desc;

    If nucant > 0 Then
      --
      prologtrace('Producto tiene variable ' || isbvariable || ' vigente'); --Log
      nupaso := 20;
      Begin
        Select Max(v.vvfccons)
          Into nuvarid
          From open.cm_vavafaco v
         Where v.vvfcvafc = isbvariable
           And v.vvfcsesu = inuproducto
           And v.vvfcfefv >= Sysdate;

        --Obtengo el record de la variable
        nupaso     := 30;
        rcvavafaco := pktblcm_vavafaco.frcgetrecord(nuvarid);

      Exception
        When Others Then
          onuerror := nupaso;
          osberror := 'Paso ' || onuerror || ' | Error al obtener el record de la variable ' ||
                      isbvariable || ' en CM_VAVAFACO. | ' || Sqlerrm;
          prologtrace(osberror); --Log
          Raise ex.controlled_error;
      End;

      nupaso := 40;

      If rcvavafaco.vvfcvalo <> inuvalor Then
        --<< si es diferente >>--

        nupaso := 50;
        Begin
          If trunc(rcvavafaco.vvfcfeiv) = trunc(Sysdate) Then
            --A. Si la variable fue creada hoy, solo actualiza el valor
            rcvavafaco.vvfcvalo := inuvalor; --nuevo valor vigente
            rcvavafaco.vvfcvapr := inuvalor; --nuevo valor vigente
            prologtrace('--<< Vigencia inicial de la Variable ' || isbvariable || ': ' ||
                        rcvavafaco.vvfcfeiv || ' | Solo se actualiza el Valor a ' || inuvalor); --Log
          Else
            --B. A la variable antigua, se le actualiza la Fecha Inicial de vigencia del registro antiguo de la variable a sysdate-1
            rcvavafaco.vvfcfefv := trunc(Sysdate - 1);
            --C. Activa el Flag de Insercion
            bodebeinsertar := True;

            prologtrace('--<< Se actualiza vigencia Final de la Variable ' || isbvariable ||
                        ' Actual '); --Log
            prologtrace('Vigencia | Inicio: ' || rcvavafaco.vvfcfeiv || ' Fin: ' ||
                        rcvavafaco.vvfcfefv || chr(10)); --Log
          End If;
          pktblcm_vavafaco.uprecord(rcvavafaco);
        Exception
          When Others Then
            onuerror := nupaso;
            osberror := 'Paso ' || onuerror || ' | Error al actualizar la vigencia de la variable ' ||
                        isbvariable || ' a sysdate-1. | ' || Sqlerrm;
            prologtrace(osberror); --Log
            Raise ex.controlled_error;
        End;

      Else
        prologtrace('Valor anterior (' || rcvavafaco.vvfcvalo || ') es igual al nuevo (' ||
                    inuvalor || '), no se modifica.'); --Log
      End If;
    Else
      --Si no tiene variable vigente, Activa el Flag de Insercion
      bodebeinsertar := True;
    End If;

    If bodebeinsertar = True Then
      --< Inserta un nuevo registro vigente para la variable>--
      nupaso := 60;
      Begin
        rcvavafaco.vvfccons := open.SQ_CM_VAVAFACO_198733.nextval;
        rcvavafaco.vvfcvafc := isbvariable;
        rcvavafaco.vvfcfeiv := Sysdate; --Fecha Inicial de vigencia
        rcvavafaco.vvfcfefv := to_date('31/12/4732', 'dd/mm/yyyy'); --Fecha Final de vigencia
        rcvavafaco.vvfcvalo := inuvalor; --nuevo valor vigente
        rcvavafaco.vvfcvapr := inuvalor; --nuevo valor vigente
        rcvavafaco.vvfcubge := Null;
        rcvavafaco.vvfcsesu := inuproducto;
        pktblcm_vavafaco.insrecord(rcvavafaco);
        prologtrace('--<< Nuevo registro de ' || isbvariable || ' en CM_VAVAFACO. ID: ' ||
                    rcvavafaco.vvfccons || ' | Producto ' || inuproducto || '>>--'); --Log
        prologtrace('Vigencia | Inicio: ' || rcvavafaco.vvfcfeiv || ' Fin: ' ||
                    rcvavafaco.vvfcfefv || chr(10)); --Log
      Exception
        When Others Then
          onuerror := nupaso;
          osberror := 'Paso ' || onuerror || ' | Error al Insertar un nuevo registro vigente de ' ||
                      isbvariable || ' en CM_VAVAFACO. | ' || Sqlerrm;
          prologtrace(osberror); --Log
          Raise ex.controlled_error;
      End;
    End If;

    --Confirmo la instruccion
    Commit;

    prologtrace('Fin ' || sbproceso);

  Exception
    When ex.controlled_error Then
      osberror := 'Error Proceso: ' || sbproceso || ' | Paso ' || nupaso || ' | ' || osberror ||
                  chr(10) || Sqlerrm;
      prologtrace(osberror); --Log
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, chr(10) || 'Error: ' ||
                                        onuerror || ' - ' ||
                                        osberror || chr(10));
      Raise ex.controlled_error;
    When Others Then
      osberror := ' Error No Controlado | ' || 'Proceso: ' || sbproceso || ' | Paso ' || nupaso ||
                  ' | ' || osberror || chr(10) || Sqlerrm;
      prologtrace(osberror); --Log
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, chr(10) || 'Error: ' ||
                                        onuerror || ' - ' ||
                                        osberror || chr(10));
      Raise ex.controlled_error;

  End;

  Procedure proaplicacreg_033_2015(inuproducto In servsusc.sesunuse%Type,
                                   inupericons In open.pericose.pecscons%Type) As
    /***********************************************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: ProAplicaCreg_033_2015
    Descripcion:        Proceso para ejecutar todas las acciones correspondientes a un producto segun
                        resolucion CREG 033/2015.

    Parametros
    ----------
    inuproducto :       Producto
    inupericons :       Periodo de Consumo
    onuerror    :       Numero del error/Ultimo Paso ejecutado
    osberror    :       Mensaje del error

    Autor       :       Oscar Ospino P. / Ludycom S.A
    Fecha       :       03-10-2016 CA200-731

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------

    ***********************************************************************************************/

    sbproceso Varchar2(4000) := gsbpaquete || '.' || 'ProAplicaCreg_033_2015';
    nupaso    Number := 0; -- Ultimo paso ejecutado antes de ocurrir el err
    nuerror   Number;
    sberror   Varchar2(4000);
  Begin

    prologtrace(chr(10) || 'Inicia ' || sbproceso);

    --Valida Entrega CA 200-731
    If fblaplicaentrega(csbentrega200731) = True Then

      --Valida CREG 033/2015 este activa
      If bocreg_033_2015 = True Then
        --Obtengo la TEMPERATURA calculada para el producto
        prologtrace('Producto: ' || inuproducto);
        nupaso          := 10;
        gnutempproducto := fnucalcvartemp(inuproducto, inupericons, 0); --Enviar 3er param con cero para no elevar excepcion
        If nvl(gnutempproducto, 0) > 0 Then
          --Actualizo el valor y la vigencia de la variable TEMPERATURA para el producto.
          nupaso := 20;
          proactvarprod(inuproducto, open.cm_bccorrectfactorsvars.csbtemperatura, gnutempproducto, nuerror, sberror);
        Else
          nuerror := nupaso;
          sberror := 'Error: Temperatura calculada es cero o NULL. No se creo/actualizo CM_VAVAFACO.';
          Raise ex.controlled_error;
        End If;

        --Valido si las constantes para calcular la PRESION_ATMOSFERICA tiene datos validos
        nupaso := 25;
        If Not nvl(cnupresionatm, 0) > 0 Or Not nvl(cnugravedad, 0) > 0 Or
           Not nvl(cnuaireseco, 0) > 0 Then
          nuerror := nupaso;
          sberror := 'Error: No se puede calcular la PRESION_ATMOSFERICA para el producto. Validar los parametros PRESIONATM,GRAVEDAD,AIRESECO';
          Raise ex.controlled_error;
        End If;

        --Obtengo la PRESION_ATMOSFERICA calculada para el producto
        nupaso             := 30;
        gnupresatmproducto := fnucalcvarpresionatm(inuproducto, gnutempproducto, 0); --Enviar 3er param con cero para no elevar excepcion
        If nvl(gnupresatmproducto, 0) > 0 Then
          --Actualizo el valor y la vigencia de la variable PRESION_ATMOSFERICA para el producto.
          proactvarprod(inuproducto, cm_bccorrectfactorsvars.csbpresion_atmosferica, gnupresatmproducto, nuerror, sberror);
        Else
          nuerror := nupaso;
          sberror := 'Error: Presion Atmosferica calculada es cero o NULL. No se creo/actualizo CM_VAVAFACO.';
          Raise ex.controlled_error;
        End If;

      Else
        --Resolucion CREG 033/2015 no esta Activa
        prologtrace('*** Resolucion CREG 033/2015 no esta Activa ***'); --Log
      End If;
    Else
      --La entrega CA 200-731 no esta activa
      prologtrace('*** La entrega ' || csbentrega200731 ||
                  ' no esta aplicada o esta desactivada. ***');
    End If;

    prologtrace(chr(10) || 'Fin ' || sbproceso || chr(10));

  Exception
    When ex.controlled_error Then
      sberror := csbentrega200731 || chr(10) || sberror;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, chr(10) || 'Error: ' ||
                                        nuerror || ' - ' || sberror ||
                                        chr(10));
      Raise ex.controlled_error;
    When Others Then
      sberror := ' Error No Controlado | ' || 'Proceso: ' || sbproceso || ' | Paso ' || nupaso ||
                 ' | ' || sberror || chr(10) || Sqlerrm;
      prologtrace(sberror); --Log
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, chr(10) || 'Error: ' ||
                                        nuerror || ' - ' || sberror ||
                                        chr(10));
      Raise;

  End;

End LDC_PKCM_RESCALCVAR;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKCM_RESCALCVAR
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKCM_RESCALCVAR', 'ADM_PERSON'); 
END;
/