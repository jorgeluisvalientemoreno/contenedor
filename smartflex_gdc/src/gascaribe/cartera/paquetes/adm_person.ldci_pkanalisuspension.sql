CREATE OR REPLACE Package ADM_PERSON.LDCI_PKANALISUSPENSION As
  /*****************************************************************
    Propiedad intelectual de Gases del Caribe / Efigas S.A.

    Nombre del Proceso: LDCI_PKAnalisuspension
    Descripcion: Paquete con Proceso de Consultas y Analisis de Evolucion de Suspensiones
    Autor  : Ing.Francisco Jose Romero Romero, Ludycom S.A.
    Fecha  : 05-05-2016 (Fecha Creacion Paquete)  No Tiquete CA()

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.        Modificacion
    -----------  -------------------    -------------------------------------

  ******************************************************************/
  /*Procedure proanalisuspension(nuanoini        In Number,
  numesini        In Number,
  nuanofin        In Number,
  numesfin        In Number,
  onuerrorcode    Out Number,
  osberrormessage Out Varchar2);*/

  Procedure proanalisuspension2(nuanoini        In Number,
                                numesini        In Number,
                                nuanofin        In Number,
                                numesfin        In Number);

End LDCI_PKANALISUSPENSION;
/
CREATE OR REPLACE Package Body ADM_PERSON.LDCI_PKANALISUSPENSION As

  ------------------------------------------------------------------------
  /*Procedure proanalisuspension(nuanoini        In Number,
                               numesini        In Number,
                               nuanofin        In Number,
                               numesfin        In Number,
                               onuerrorcode    Out Number,
                               osberrormessage Out Varchar2) Is

    \*****************************************************************
    Propiedad intelectual de Gases del Caribe / Efigas S.A.

    Nombre del Proceso: proAnalisuspension
    Descripcion: Este proceso llenara la informacion en la tabla LDC_ANSU. Para ello el proceso
                 debe buscar de buscar la informacion de las suspensiones en la tabla de ordenes y otras complementarias.

    Autor  : Ing.Francisco Jose Romero Romero, Ludycom S.A.
    Fecha  : 06-05-2016 (Fecha Creacion Procedimiento)  No Tiquete CA()

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.        Modificacion
    -----------  -------------------    -------------------------------------

    ******************************************************************\
    nucontrato    suscripc.susccodi%Type; --Obtener Contrato
    nuestacort    servsusc.sesuesco%Type; --Obtener Estado de Corte
    nuestafina    servsusc.sesuesfn%Type; --Obtener Estado financiero
    nulocalidad   ge_geogra_location.geograp_location_id%Type; --Obtener Localidad
    nucategoria   servsusc.sesucate%Type; --Obtener Categoria
    nusubcateg    servsusc.sesusuca%Type; --Obtener Subcategoria
    dtpefafimoi   perifact.pefafimo%Type; --Obtener Fecha Inicial del periodo inicial
    dtpefafimof   perifact.pefafimo%Type; --Obtener Fecha Inicial del periodo final
    dtpefaffmoi   perifact.pefaffmo%Type; --Obtener Fecha fin del periodo inicial
    dtpefaffmof   perifact.pefaffmo%Type; --Obtener Fecha fin del periodo final
    sbdebeconex   Varchar(2); --Identificador si a la fecha final del periodo de evaluacion debe la conexion
    nuctasaldo    ldc_osf_sesucier.nro_ctas_con_saldo%Type; --Obtener numero de cuentas con saldo periodo inicial
    nuctasaldofin ldc_osf_sesucier.nro_ctas_con_saldo%Type; --Obtener numero de cuentas con saldo periodo final
    sbrefini      Varchar(2); --Identificador si fue refinanciado en el periodo inicial
    sbreffin      Varchar(2); --Identificador si fue refinanciado en el periodo final
    nudeudaini    Number(15, 2); --Deuda en el periodo inicial
    nudeudafin    Number(15, 2); --Deuda en el periodo final
    nufacturado   Number(15, 2); --Obtener facturado entre periodos
    nupagado      Number(15, 2); --Obtener pagado entre periodos
    dtpripago     Date; --Obtener fecha primer pago post-asignacion de la suspension
    nutimepp      Number(15, 2); --Obtener tiempo transcurrido del primer pago desde la fecha asignacion de la suspension

    --Recorre datos base para llenado de tabla
    Cursor cudatosbase(cnuano Number, cnumes Number) Is
      Select o.order_id, oa.product_id, o.created_date, o.assigned_date
        From open.or_order o, open.or_order_activity oa
       Where o.task_type_id = 12526
         And o.order_status_id = 8
         And oa.order_id = o.order_id
         And o.created_date =
             (Select Min(o1.created_date)
                From open.or_order          o1,
                     open.or_order_activity oa1,
                     open.servsusc          s,
                     open.perifact          pf
               Where o1.order_id = oa1.order_id
                 And o1.task_type_id = 12526
                 And o1.order_status_id = 8
                 And oa1.product_id = oa.product_id
                 And s.sesunuse = oa1.product_id
                 And pf.pefacicl = s.sesucicl
                 And pf.pefaano = cnuano
                 And pf.pefames = cnumes
                 And o1.created_date Between pf.pefafimo And pf.pefaffmo);

  Begin
    onuerrorcode    := 0;
    osberrormessage := Null;

    If onuerrorcode = 0 Then
      For reg In cudatosbase(nuanoini, numesini) Loop
        --------------------------------------------------
        --Obtener de periodo inicial
        Begin
          Select pf.pefafimo, pf.pefaffmo
            Into dtpefafimoi, dtpefaffmoi
            From open.perifact pf, open.servsusc s
           Where s.sesunuse = reg.product_id
             And pf.pefacicl = s.sesucicl
             And pf.pefaano = nuanoini
             And pf.pefames = numesini
             And rownum = 1;
        Exception
          When Others Then
            dtpefafimoi := Null;
            dtpefaffmoi := Null;
        End;
        --------------------------------------------------
        --Obtener de periodo final
        Begin
          Select pf.pefaffmo
            Into dtpefaffmof
            From open.perifact pf, open.servsusc s
           Where s.sesunuse = reg.product_id
             And pf.pefacicl = s.sesucicl
             And pf.pefaano = nuanofin
             And pf.pefames = numesfin
             And rownum = 1;
        Exception
          When Others Then
            dtpefaffmof := Null;
        End;
        --------------------------------------------------
        --Obtener contrato, estado corte y financiero, categoria, subcategoria
        Begin
          Select s.sesususc,
                 s.sesuesco,
                 s.sesuesfn,
                 s.sesucate,
                 s.sesusuca
            Into nucontrato,
                 nuestacort,
                 nuestafina,
                 nucategoria,
                 nusubcateg
            From open.servsusc s
           Where s.sesunuse = reg.product_id;
        Exception
          When Others Then
            nucontrato  := Null;
            nuestacort  := Null;
            nuestafina  := Null;
            nucategoria := Null;
            nusubcateg  := Null;
        End;
        --------------------------------------------------
        --Obtener localidad
        Begin
          Select l.geograp_location_id
            Into nulocalidad
            From open.pr_product         p,
                 open.ab_address         b,
                 open.ge_geogra_location l
           Where p.product_id = reg.product_id
             And b.address_id = p.address_id
             And l.geograp_location_id = b.geograp_location_id;
        Exception
          When Others Then
            nulocalidad := Null;
        End;
        --------------------------------------------------
        --Obtener si Debe Conexion
        Begin
          Select Case
                   When Count(df.difecodi) > 0 Then
                    'SI'
                   Else
                    'NO'
                 End
            Into sbdebeconex
            From open.diferido df
           Where df.difenuse = reg.product_id
             And df.difeconc = 19
             And df.difesape > 0
             And df.difefein <= dtpefaffmof;
        Exception
          When Others Then
            sbdebeconex := 'NO';
        End;
        --Sino se encontro diferido evaluar algun cargo por conexion durante el periodo de evaluacion
        If sbdebeconex = 'NO' Then
          Begin
            Select Case
                     When Sum(decode(c.cargsign,
                                     'CR',
                                     (c.cargvalo) * -1,
                                     c.cargvalo)) > 0 Then
                      'SI'
                     Else
                      'NO'
                   End
              Into sbdebeconex
              From open.cargos c
             Where c.cargnuse = reg.product_id
               And c.cargconc = 19
               And c.cargvalo > 0
               And c.cargfecr >= dtpefafimoi
               And c.cargfecr <= dtpefaffmof;
          Exception
            When Others Then
              sbdebeconex := 'NO';
          End;
        End If;
        --------------------------------------------------
        --Obtener cuentas con saldo del periodo inicial
        Begin
          Select c.nro_ctas_con_saldo,
                 nvl(c.sesusape, 0) + nvl(c.deuda_no_corriente, 0)
            Into nuctasaldo, nudeudaini
            From open.ldc_osf_sesucier c
           Where c.producto = reg.product_id
             And c.nuano = nuanoini
             And c.numes = numesini
             And rownum = 1;
        Exception
          When Others Then
            nuctasaldo := 0;
            nudeudaini := 0;
        End;
        --------------------------------------------------
        --Obtener si fue refinanciado en periodo inicial
        Begin
          Select Case
                   When Count(rf.financing_id) > 0 Then
                    'SI'
                   Else
                    'NO'
                 End
            Into sbrefini
            From open.cc_financing_request rf
           Where rf.record_program = 'GCNED'
             And rf.subscription_id = nucontrato
             And rf.record_date <= dtpefaffmoi;
        Exception
          When Others Then
            sbrefini := 'NO';
        End;
        --------------------------------------------------
        --Obtener cuentas con saldo del periodo final
        Begin
          Select c.nro_ctas_con_saldo,
                 nvl(c.sesusape, 0) + nvl(c.deuda_no_corriente, 0)
            Into nuctasaldofin, nudeudafin
            From open.ldc_osf_sesucier c
           Where c.producto = reg.product_id
             And c.nuano = nuanofin
             And c.numes = numesfin
             And rownum = 1;
        Exception
          When Others Then
            nuctasaldofin := 0;
            nudeudafin    := 0;
        End;
        --------------------------------------------------
        --Obtener si fue refinanciado en periodo final
        Begin
          Select Case
                   When Count(rf.financing_id) > 0 Then
                    'SI'
                   Else
                    'NO'
                 End
            Into sbreffin
            From open.cc_financing_request rf
           Where rf.record_program = 'GCNED'
             And rf.subscription_id = nucontrato
             And rf.record_date > dtpefaffmoi
             And rownum = 1;
        Exception
          When Others Then
            sbreffin := 'NO';
        End;
        --------------------------------------------------
        --Obtener el facturado acumulado entre periodos
        Begin
          Select Sum(decode(c.cargsign,
                            'DB',
                            c.cargvalo,
                            (c.cargvalo) * -1))
            Into nufacturado
            From open.cargos c
           Where c.cargnuse = reg.product_id
             And c.cargprog In (5, 6)
             And c.cargvalo > 0
             And c.cargfecr >= dtpefafimoi
             And c.cargfecr <= dtpefaffmof;
        Exception
          When Others Then
            nufacturado := 0;
        End;
        --------------------------------------------------
        --Obtener el pagado acumulado entre periodos
        Begin
          Select Sum(c.cargvalo)
            Into nupagado
            From open.cargos c
           Where c.cargnuse = reg.product_id
             And c.cargsign = 'PA'
             And c.cargfecr >= dtpefafimoi
             And c.cargfecr <= dtpefaffmof;
        Exception
          When Others Then
            nupagado := 0;
        End;
        --------------------------------------------------
        --Obtener tiempo transcurrido del primer pago
        Begin
          Select Min(c.cargfecr)
            Into dtpripago
            From open.cargos c
           Where c.cargnuse = reg.product_id
             And c.cargsign = 'PA'
             And c.cargfecr >= reg.assigned_date;
        Exception
          When Others Then
            dtpripago := Null;
        End;
        If dtpripago Is Not Null Then
          nutimepp := open.ldc_boutilities.fnudiashabiles(reg.assigned_date,
                                                          dtpripago);
        End If;
        --------------------------------------------------
        --Se inserta el registro en la tabla de resultados
        Begin
          Insert Into open.ldc_ansu
            (contrato,
             producto,
             estacort,
             estafina,
             localidad,
             categoria,
             subcateg,
             debeconex,
             ctasaldo,
             refini,
             deudaini,
             ctasaldofin,
             reffin,
             deudafin,
             facturado,
             pagado,
             feciniord,
             timepp)
          Values
            (nucontrato,
             reg.product_id,
             nuestacort,
             nuestafina,
             nulocalidad,
             nucategoria,
             nusubcateg,
             sbdebeconex,
             nuctasaldo,
             sbrefini,
             nudeudaini,
             nuctasaldofin,
             sbreffin,
             nudeudafin,
             nufacturado,
             nupagado,
             reg.created_date,
             nutimepp);
        Exception
          When Others Then
            onuerrorcode    := Sqlcode;
            osberrormessage := Sqlerrm;
            Goto abortar;
        End;
        --------------------------------------------------
      End Loop;
    End If;

    <<abortar>>
    Null;

  Exception
    When Others Then
      onuerrorcode    := Sqlcode;
      osberrormessage := Sqlerrm;
  End proanalisuspension;*/

  Procedure proanalisuspension2(nuanoini        In Number,
                                numesini        In Number,
                                nuanofin        In Number,
                                numesfin        In Number) Is

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe / Efigas S.A.

    Nombre del Proceso: proAnalisuspension
    Descripcion: Este proceso llenara la informacion en la tabla LDC_ANSU. Para ello el proceso
                 debe buscar de buscar la informacion de las suspensiones en la tabla de ordenes y otras complementarias.

    Autor  : Sandra Lemus, Ludycom S.A.
    Fecha  : 20-05-2016 (Fecha Creacion Procedimiento)  No Tiquete CA()

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.        Modificacion
    -----------  -------------------    -------------------------------------

    ******************************************************************/
    nucontrato    suscripc.susccodi%Type; --Obtener Contrato
    nuestacort    servsusc.sesuesco%Type; --Obtener Estado de Corte
    nuestafina    servsusc.sesuesfn%Type; --Obtener Estado financiero
    nulocalidad   ge_geogra_location.geograp_location_id%Type; --Obtener Localidad
    nucategoria   servsusc.sesucate%Type; --Obtener Categoria
    nusubcateg    servsusc.sesusuca%Type; --Obtener Subcategoria
    dtpefafimoi   perifact.pefafimo%Type; --Obtener Fecha Inicial del periodo inicial
    --dtpefafimof   perifact.pefafimo%Type; --Obtener Fecha Inicial del periodo final
    dtpefaffmoi   perifact.pefaffmo%Type; --Obtener Fecha fin del periodo inicial
    dtpefaffmof   perifact.pefaffmo%Type; --Obtener Fecha fin del periodo final
    sbdebeconex   Varchar(2); --Identificador si a la fecha final del periodo de evaluacion debe la conexion
    nuctasaldo    ldc_osf_sesucier.nro_ctas_con_saldo%Type; --Obtener numero de cuentas con saldo periodo inicial
    nuctasaldofin ldc_osf_sesucier.nro_ctas_con_saldo%Type; --Obtener numero de cuentas con saldo periodo final
    sbrefini      Varchar(2); --Identificador si fue refinanciado en el periodo inicial
    sbreffin      Varchar(2); --Identificador si fue refinanciado en el periodo final
    nudeudaini    Number(15, 2); --Deuda en el periodo inicial
    nudeudafin    Number(15, 2); --Deuda en el periodo final
    --nudeudvenc    Number(15,2);
    nuvalprom     Number(15,2); --PRomedio de Facturas Vencidas
    nufacturado   Number(15, 2); --Obtener facturado entre periodos
    nupagado      Number(15, 2); --Obtener pagado entre periodos
    dtpripago     Date; --Obtener fecha primer pago post-asignacion de la suspension
    nutimepp      Number(15, 2); --Obtener tiempo transcurrido del primer pago desde la fecha asignacion de la suspension
    nususpcump    Number(15, 2);
    nususpincu    Number(15, 2);
    diapro1       Number(15, 2);
    diapro2       Number(15, 2);
    diasisus      Number(15, 2);
    disusref      Number(15, 2);
    norsusas      Number(15, 2);
    norsusge      Number(15, 2);
    norsusins     Number(15, 2);
    norsusinc     Number(15, 2);
    norsusleg     Number(15, 2);
    norreco       Number(15, 2);
    norrecoex     Number(15, 2);
    norviosus     Number(15, 2);
    norviosuin1   Number(15, 2);
    norviosuin2   Number(15, 2);
    cuotamens     Number(15, 2);
    conspro       Number(15, 2);
    norgenan      Number(15, 2);
    norsusda      Number(15, 2);
    sumdiasure    Number(15, 2);
    diaprosure    Number(15, 2);
    diaprogele    Number(15, 2);
    diaprogeas    Number(15, 2);
    norgeanpa     Number(15, 2);
    norgenoas     Number(15, 2);
    fecprisusp    Date; --fecha primera suspensión
    fecprirefi    Date; --fecha primera refinanciación
    nucuvenc      ic_cartcoco.cacccuco%Type;
    nusalven      ic_cartcoco.caccsape%Type;
    pericoac      pericose.pecscons%Type;
    pericoan      pericose.pecscons%Type;
    nucicl        pericose.pecscico%Type;
    nuperi        pericose.pecscons%Type;
    nurefini      Number(10);
    nureffin      Number(10);
    onuerrorcode    Number;
    osberrormessage Varchar2(2000);
    nucount         Number;

    --Recorre datos base para llenado de tabla
    Cursor cudatosbase Is
      Select o.order_id,
             o.created_date,
             o.assigned_date,
             (Select oa.product_id
                From open.or_order_activity oa
               Where o.order_id = oa.order_id) product_id
        From open.or_order o
       Where o.task_type_id = 12526
         And Not Exists
       (Select 'x'
                From open.or_related_order ro
               Where ro.related_order_id = o.order_id)
         And o.created_date >= to_date('01/05/2015', 'dd/mm/yyyy')
         And o.created_date < to_date('31/05/2015', 'dd/mm/yyyy');

  Begin
   --onuerrorcode    := 0;
    --osberrormessage := Null;

    --If onuerrorcode = 0 Then
    nucount := 0;
      For reg In cudatosbase Loop
        --------------------------------------------------
        --Obtener de periodo inicial
        Begin
          Select pf.pefacicl , pf.pefacodi, pf.pefafimo, pf.pefaffmo
            Into nucicl, nuperi, dtpefafimoi, dtpefaffmoi
            From open.perifact pf, open.servsusc s
           Where s.sesunuse = reg.product_id
             And pf.pefacicl = s.sesucicl
             And pf.pefaano = nuanoini
             And pf.pefames = numesini
             And rownum = 1;
        Exception
          When Others Then
            dtpefafimoi := Null;
            dtpefaffmoi := Null;
        End;

       Begin
         Select pecscons
           Into pericoac
           From pericose pc, perifact pf, open.servsusc s
          Where pf.pefacicl = pecscico
            And pecsfecf Between pefafimo And pefaffmo
            And pf.pefacicl = nucicl
            And s.sesucicl = pf.pefacicl
            And s.sesunuse = reg.product_id
            And pefacodi = nuperi;
       End;

        getprevconsperiod(pericoac,pericoan);

        Begin
          Select hcppcopr
            Into conspro
            From hicoprpm
           Where hcpppeco = pericoan
             And hcppsesu = reg.product_id;
        Exception
          When Others Then
            conspro := -1;
        End;
        --------------------------------------------------
        --Obtener de periodo final
        Begin
          Select pf.pefaffmo
            Into dtpefaffmof
            From open.perifact pf, open.servsusc s
           Where s.sesunuse = reg.product_id
             And pf.pefacicl = s.sesucicl
             And pf.pefaano = nuanofin
             And pf.pefames = numesfin
             And rownum = 1;
        Exception
          When Others Then
            dtpefaffmof := Null;
        End;

        -------------------------------------------------------
        --obtener periodo de consumo


        --------------------------------------------------
        --Obtener de periodo final
        Begin
          Select pf.pefaffmo
            Into dtpefaffmof
            From open.perifact pf, open.servsusc s
           Where s.sesunuse = reg.product_id
             And pf.pefacicl = s.sesucicl
             And pf.pefaano = nuanofin
             And pf.pefames = numesfin
             And rownum = 1;
        Exception
          When Others Then
            dtpefaffmof := Null;
        End;
        --------------------------------------------------
        --------------------------------------------------
        --Obtener contrato, estado corte y financiero, categoria, subcategoria
        Begin
          Select s.sesususc,
                 s.sesuesco,
                 s.sesuesfn,
                 s.sesucate,
                 s.sesusuca
            Into nucontrato,
                 nuestacort,
                 nuestafina,
                 nucategoria,
                 nusubcateg
            From open.servsusc s
           Where s.sesunuse = reg.product_id;
        Exception
          When Others Then
            nucontrato  := Null;
            nuestacort  := Null;
            nuestafina  := Null;
            nucategoria := Null;
            nusubcateg  := Null;
        End;
        --------------------------------------------------
        --Obtener localidad
        Begin
          Select l.geograp_location_id
            Into nulocalidad
            From open.pr_product         p,
                 open.ab_address         b,
                 open.ge_geogra_location l
           Where p.product_id = reg.product_id
             And b.address_id = p.address_id
             And l.geograp_location_id = b.geograp_location_id;
        Exception
          When Others Then
            nulocalidad := Null;
        End;
        --------------------------------------------------
        --Obtener si Debe Conexion
        Begin
          Select Case
                   When Count(df.difecodi) > 0 Then
                    'SI'
                   Else
                    'NO'
                 End
            Into sbdebeconex
            From open.diferido df
           Where df.difenuse = reg.product_id
             And df.difeconc = 19
             And df.difesape > 0
             And df.difefein <= dtpefaffmof;
        Exception
          When Others Then
            sbdebeconex := 'NO';
        End;
        --Sino se encontro diferido evaluar algun cargo por conexion durante el periodo de evaluacion
        If sbdebeconex = 'NO' Then
          Begin
            Select Case
                     When Sum(decode(c.cargsign,
                                     'CR',
                                     (c.cargvalo) * -1,
                                     c.cargvalo)) > 0 Then
                      'SI'
                     Else
                      'NO'
                   End
              Into sbdebeconex
              From open.cargos c
             Where c.cargnuse = reg.product_id
               And c.cargconc = 19
               And c.cargvalo > 0
               And c.cargfecr >= dtpefafimoi
               And c.cargfecr <= dtpefaffmof;
          Exception
            When Others Then
              sbdebeconex := 'NO';
          End;
        End If;
        --------------------------------------------------
/*        --Obtener cuentas con saldo del periodo inicial
        Begin
          Select c.nro_ctas_con_saldo,
                 nvl(c.sesusape, 0) + nvl(c.deuda_no_corriente, 0)
            Into nuctasaldo, nudeudaini
            From open.ldc_osf_sesucier c
           Where c.producto = reg.product_id
             And c.nuano = nuanoini
             And c.numes = numesini
             And rownum = 1;
        Exception
          When Others Then
            nuctasaldo := 0;
            nudeudaini := 0;
        End;*/
        ------------------------------------------------------
        Begin
          Select Count(Distinct(cacccuco)), nvl(Sum(caccsape), 0)
            Into nuctasaldo, nudeudaini
            From open.ic_cartcoco
           Where caccfege = to_date('31/05/2015', 'dd/mm/yyyy')
             And caccnuse = reg.product_id
             And caccfeve <= to_date('31/05/2015', 'dd/mm/yyyy')
             And caccnaca = 'N';
        Exception
          When Others Then
            nucuvenc := 0;
            nusalven := 0;
        End;

        Begin
        nuvalprom := nudeudaini/nuctasaldo;
        Exception When Others Then
          nuvalprom := 0;
        End;
        --------------------------------------------------
        --Obtener nmro refinanciado antes de primera suspensión
        Begin
          Select Count(*)
            Into nurefini
            From open.cc_financing_request rf
           Where rf.record_program = 'GCNED'
             And rf.subscription_id = nucontrato
             And rf.record_date <= reg.created_date;
        Exception
          When Others Then
            nurefini := 0;
        End;

        --------------------------------------------------
        --Obtener nmro refinanciado hasta periodo inicial
        Begin
          Select Count(*)
            Into nureffin
            From open.cc_financing_request rf
           Where rf.record_program = 'GCNED'
             And rf.subscription_id = nucontrato;
        Exception
          When Others Then
            nureffin := 0;
        End;


        --------------------------------------------------
        --Obtener cuentas con saldo del periodo final
        Begin
          Select c.nro_ctas_con_saldo,
                 nvl(c.sesusape, 0) + nvl(c.deuda_no_corriente, 0)
            Into nuctasaldofin, nudeudafin
            From open.ldc_osf_sesucier c
           Where c.producto = reg.product_id
             And c.nuano = nuanofin
             And c.numes = numesfin
             And rownum = 1;
        Exception
          When Others Then
            nuctasaldofin := 0;
            nudeudafin    := 0;
        End;
        --------------------------------------------------
        --Obtener si fue refinanciado en periodo final
        Begin
          Select Case
                   When Count(rf.financing_id) > 0 Then
                    'SI'
                   Else
                    'NO'
                 End
            Into sbreffin
            From open.cc_financing_request rf
           Where rf.record_program = 'GCNED'
             And rf.subscription_id = nucontrato
             And rf.record_date > dtpefaffmoi
             And rownum = 1;
        Exception
          When Others Then
            sbreffin := 'NO';
        End;
        --------------------------------------------------
        --Obtener el facturado acumulado entre periodos
        Begin
          Select Sum(decode(c.cargsign,
                            'DB',
                            c.cargvalo,
                            (c.cargvalo) * -1))
            Into nufacturado
            From open.cargos c
           Where c.cargnuse = reg.product_id
             And c.cargprog In (5, 6)
             And c.cargvalo > 0
             And c.cargfecr >= dtpefafimoi
             And c.cargfecr <= dtpefaffmof;
        Exception
          When Others Then
            nufacturado := 0;
        End;
        --------------------------------------------------
        --Obtener el pagado acumulado entre periodos
        Begin
          Select Sum(c.cargvalo)
            Into nupagado
            From open.cargos c
           Where c.cargnuse = reg.product_id
             And c.cargsign = 'PA'
             And c.cargfecr >= dtpefafimoi
             And c.cargfecr <= dtpefaffmof;
        Exception
          When Others Then
            nupagado := 0;
        End;
        --------------------------------------------------
        --Obtener tiempo transcurrido del primer pago
        Begin
          Select Min(c.cargfecr)
            Into dtpripago
            From open.cargos c
           Where c.cargnuse = reg.product_id
             And c.cargsign = 'PA'
             And c.cargfecr >= reg.assigned_date;
        Exception
          When Others Then
            dtpripago := Null;
        End;
        If dtpripago Is Not Null Then
          nutimepp := open.ldc_boutilities.fnudiashabiles(reg.assigned_date,
                                                          dtpripago);
        End If;
        --------------------------------------------------

        --------------------------------------------------
        --Obtener nmro de suspensiones cumplidas
        Begin
          Select Count(*)
            Into nususpcump
            From open.pr_prod_suspension
           Where product_id = reg.product_id;
        Exception
          When Others Then
            nususpcump := Null;
        End;

         --------------------------------------------------
         --Obtener nmro de suspensiones incumplidas
         Begin
          Select Count(*)
          Into NUSUSPINCU
          From open.or_order o, open.or_order_activity oa
          Where o.order_id = oa.order_id
           And oa.product_id = reg.product_id
           And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
           And o.causal_id In (2016,3256,3315,3316,
                           3322,3324,3394,3396,3397,
                           3398,3443,9384,9386,9387,
                           9392,9393,9777,9780,9794,
                           9795,9799,9803,9811,9818,
                           9821,9822,9823,9824,9826,
                           9828); -- Ordenes de suspension incumplidas
        Exception
          When Others Then
            NUSUSPINCU := 0;
        End;

        ----------------------------------------------------
        --Nro. de órdenes de suspensión asignadas.

        Begin
          Select Count(*)
            Into norsusas
            From open.or_order o, open.or_order_activity oa
              Where o.order_id = oa.order_id
               And oa.product_id = reg.product_id
               And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
               And o.assigned_date Is Not Null;
        Exception
          When Others Then
            norsusas := 0;
        End;
        --------------------------------------------------------------
        --Nro. de órdenes de suspensión generadas.

        Begin
          Select Count(*)
            Into norsusge
            From open.or_order o, open.or_order_activity oa
           Where o.order_id = oa.order_id
              And oa.product_id = reg.product_id
              And o.task_type_id In (12528, 10058, 10547, 12526, 10546);
        Exception
          When Others Then
            norsusge := 0;
        End;

        --------------------------------------------------------------
        --Nro. de órdenes de suspensión incumplidas por el sistema.

         Begin
           Select Count(*)
             Into norsusins
             From open.or_order o, open.or_order_activity oa
            Where o.order_id = oa.order_id
              And oa.product_id = reg.product_id
              And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
              And o.causal_id In (3396, 3316, 3397);
         Exception
           When Others Then
             norsusins := 0;
         End;

           --------------------------------------------------------------
        --Nro. de órdenes de suspensión incumplidas por el contratista.

         Begin
           Select Count(*)
             Into norsusinc
             From open.or_order o, open.or_order_activity oa
             Where o.order_id = oa.order_id
              And oa.product_id = reg.product_id
              And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
              And o.causal_id In (2016,3256,3315,
                       3322,3324,3394,
                       3398,3443,9384,9386,9387,
                       9392,9393,9777,9780,9794,
                       9795,9799,9803,9811,9818,
                       9821,9822,9823,9824,9826,
                       9828);
         Exception
           When Others Then
             norsusinc := 0;
         End;

        --------------------------------------------------------------
        --Nro. de órdenes de suspensión legalizadas exitosas por el contratista.

         Begin
           Select Count(*)
             Into norsusleg
             From open.or_order o, open.or_order_activity oa
             Where o.order_id = oa.order_id
                And oa.product_id = reg.product_id
                And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
                And o.causal_id In (2016,3256,3315,
                       3322,3324,3394,
                       3398,3443,9384,9386,9387,
                       9392,9393,9777,9780,9794,
                       9795,9799,9803,9811,9818,
                       9821,9822,9823,9824,9826,
                       9828);
         Exception
           When Others Then
             norsusleg := 0;
         End;
         --------------------------------------------------
        Begin
          Select Avg(tiempo)
            Into diapro1
            From (Select o.created_date,
                         o.assigned_date,
                         oa.register_date,
                         open.ldc_boutilities.fnudiashabiles(o.created_date,
                                                             o.assigned_date) tiempo
                    From open.or_order o, open.or_order_activity oa
                   Where o.task_type_id In
                         (12528, 10058, 10547, 12526, 10546)
                     And o.order_id = oa.order_id
                     And product_id = reg.product_id
                     And assigned_date Is Not Null);
        Exception
          When Others Then
            diapro1 := Null;
        End;
        ----------------------------------------------------------------------
        Begin
          Select Avg(tiempo)
            Into diapro2
            From (Select o.created_date,
                         o.assigned_date,
                         oa.register_date,
                         open.ldc_boutilities.fnudiashabiles(o.created_date,
                                                             o.assigned_date) tiempo
                    From open.or_order o, open.or_order_activity oa
                   Where o.task_type_id In
                         (12528, 10058, 10547, 12526, 10546)
                     And o.order_status_id = 8
                     And o.order_id = oa.order_id
                     And product_id = reg.product_id
                     And assigned_date Is Not Null);
        Exception
          When Others Then
            diapro2 := Null;
        End;
        ----------------------------------------------------------------------
        --primera suspensión
        Begin

           Select Min(register_date) suspension
           Into fecprisusp
            From open.pr_prod_suspension
           Where product_id = reg.product_id
             And register_date >= reg.created_date;
        Exception When Others Then
          fecprisusp := Null;
        End;
        -----------------------------------------------------------------------------------------
         -- Días transcurridos desde la asignación de la primera orden hasta la primera suspensión.
         Begin
          Select open.ldc_boutilities.fnudiashabiles(reg.created_date,
                                                     fecprisusp)
            Into diasisus
            From dual;
        Exception
          When Others Then
            diasisus := Null;
        End;

        -------------------------------------------------------------------------------------------
        -- Días transcurridos desde la visita de suspensión cumplida hasta su refinanciación, si existe.

        Begin
          Select record_date
          Into fecprirefi
          From open.cc_financing_request rf, open.servsusc s
          Where rf.record_date >= reg.created_date
          And rf.record_program = 'GCNED'
          And s.sesususc = rf.subscription_id
          And s.sesunuse = reg.product_id;
        Exception
          When Others Then
            fecprirefi := Null;
        End;

        Begin
            Select open.ldc_boutilities.fnudiashabiles(fecprisusp,
                                                       fecprirefi)
            Into disusref
            From dual;
        Exception
          When Others Then
            disusref := Null;
        End;

        ----------------------------------------------------------------------
        --Nro. de órdenes de reconexiones.

        Begin
          Select Count(*)
            Into norreco
            From open.or_order o, open.or_order_activity oa
           Where o.task_type_id In
                 (10598, 10597, 12529, 10060, 10559, 12527)
             And o.order_id = oa.order_id
             And product_id = reg.product_id
             And o.created_date >= reg.created_date;
        Exception
          When Others Then
            norreco := Null;
        End;
        ----------------------------------------------------------------------
        --Nro. de órdenes de reconexión exitosas
        Begin
          Select Count(*)
            Into norrecoex
            From open.suspcone
           Where suconuse = reg.product_id
             And sucotipo = 'C'
             And sucofeat Is Not Null
             And sucofeor >= reg.created_date;
        Exception
          When Others Then
            norrecoex := Null;
        End;
        ----------------------------------------------------------------------
        -- Nro. de órdenes de violación de suspensión generadas.
        Begin
          Select Count(*)
            Into norviosus
            From open.or_order o, open.or_order_activity oa
           Where o.task_type_id In (12521,10169)
             And o.order_id = oa.order_id
             And product_id = reg.product_id
             And o.created_date >= reg.created_date;
        Exception
          When Others Then
            norviosus := Null;
        End;
        ----------------------------------------------------------------------
        -- Nro. de órdenes de violación de suspensión incumplidas por el sistema.
        /*Begin
          Select Count(*)
            Into norviosuin1
            From open.or_order o, open.or_order_activity oa
           Where o.task_type_id In (12521, 10169)
             And o.order_id = oa.order_id
             And product_id = reg.product_id
             And o.causal_id In (9809, 9791)
             And o.created_date >= reg.created_date;
        Exception
          When Others Then
            norviosuin1 := Null;
        End;*/
        norviosuin1 := Null;
        ------------------------------------------------------------------
        -- Nro. de órdenes de violación de incumplidas por el contratista.
        Begin
          Select Count(*)
            Into NORGENAN
            From open.or_order o, open.or_order_activity oa
           Where o.task_type_id In (12521, 10169)
             And o.order_id = oa.order_id
             And product_id = reg.product_id
             And o.causal_id In (3251,3253,3254,3255,3256,
                                 3264,3264,9384,9794,9805,
                                 9808,9818,9821,9822,9826,9828)
             And o.created_date >= reg.created_date;
        Exception
          When Others Then
            NORGENAN := Null;
        End;

        ------------------------------------------------------------------
        -- Nro. de órdenes de anuladas antes de ser asignadas
         Begin
           Select Count(*)
             Into norsusins
             From open.or_order o, open.or_order_activity oa
            Where o.order_id = oa.order_id
              And oa.product_id = reg.product_id
              And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
              And o.causal_id In (3396, 3316, 3397)
              And o.assigned_date Is Null;
         Exception
           When Others Then
             norsusins := 0;
         End;
         -----------------------------------------------------------
         -- Nro. de órdenes de suspension de dos años atras
         Begin
          Select Count(*)
            Into norsusda
            From open.or_order o, open.or_order_activity oa
              Where o.order_id = oa.order_id
               And oa.product_id = reg.product_id
               And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
               And o.created_date <= reg.created_date
               And o.created_date >=  ADD_MONTHS(reg.created_date, -24);
        Exception
          When Others Then
            norsusda := 0;
        End;

        ---------------------------------------------------
        --Dias total suspendido
      Begin
        Select round(Sum(inactive_date - aplication_date)),
               round(Sum(inactive_date - aplication_date)) / Count(*)
          Into sumdiasure,diaprosure
          From open.pr_prod_suspension
         Where product_id = reg.product_id;
      Exception
        When Others Then
          sumdiasure := -1;
          diaprosure := -1;
      End;
         -----------------------------------------------------------
         -- Nro. de Ordenes generadas y no se asignadas por pago.
         Begin
          Select Count(*)
            Into norsusda
            From open.or_order o, open.or_order_activity oa
              Where o.order_id = oa.order_id
               And oa.product_id = reg.product_id
               And o.task_type_id In (12528, 10058, 10547, 12526, 10546)
               And o.order_status_id = 12
               And o.assigned_date Is Null;
        Exception
          When Others Then
            norsusda := 0;
        End;
        --------------------------------------------------
        --Se inserta el registro en la tabla de resultados
        Begin
          Insert Into open.ldc_ansu
            (contrato,
             producto,
             estacort,
             estafina,
             localidad,
             categoria,
             subcateg,
             debeconex,
             ctasaldo,
             refini,
             deudaini,
             ctasaldofin,
             reffin,
             deudafin,
             facturado,
             pagado,
             feciniord,
             timepp,
             nususpcump,
             nususpincu,
             diapro1,
             diapro2,
             diasisus,
             disusref,
             norsusas,
             norsusge,
             norsusins,
             norsusinc,
             norsusleg,
             norreco,
             norrecoex,
             norviosus,
             norviosuin1,
             norviosuin2,
             cuotamens,
             conspro,
             norgenan,
             norsusda,
             sumdiasure,
             diaprosure,
             diaprogele,
             diaprogeas,
             norgeanpa,
             norgenoas,
             norefini,
             noreffin)
          Values
            (nucontrato,
             reg.product_id,
             nuestacort,
             nuestafina,
             nulocalidad,
             nucategoria,
             nusubcateg,
             sbdebeconex,
             nuctasaldo,
             sbrefini,
             nudeudaini,
             nuctasaldofin,
             sbreffin,
             nudeudafin,
             nufacturado,
             nupagado,
             reg.created_date,
             nutimepp,
             nususpcump,
             nususpincu,
             diapro1,
             diapro2,
             diasisus,
             disusref,
             norsusas,
             norsusge,
             norsusins,
             norsusinc,
             norsusleg,
             norreco,
             norrecoex,
             norviosus,
             norviosuin1,
             norviosuin2,
             nuvalprom,
             conspro,
             norgenan,
             norsusda,
             sumdiasure,
             diaprosure,
             diaprogele,
             diaprogeas,
             norgeanpa,
             norgenoas,
             nurefini,
             nureffin);
        Exception
          When Others Then
            onuerrorcode    := Sqlcode;
            osberrormessage := Sqlerrm;
            Goto abortar;
        End;
        --------------------------------------------------
        If nucount = 1000 Then
          nucount := 0;
          Commit;
        End If;
      End Loop;
      Commit;
    --End If;

    <<abortar>>
    Null;

  Exception
    When Others Then
      onuerrorcode    := Sqlcode;
      osberrormessage := Sqlerrm;
  End proanalisuspension2;
End LDCI_PKANALISUSPENSION;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKANALISUSPENSION', 'ADM_PERSON'); 
END;
/

