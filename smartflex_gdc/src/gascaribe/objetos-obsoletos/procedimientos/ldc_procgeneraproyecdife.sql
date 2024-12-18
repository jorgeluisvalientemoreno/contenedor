CREATE OR REPLACE Procedure ldc_procgeneraproyecdife(inano      In Number,
                                                     inmes      In Number,
                                                     inservicio In Number,
                                                     merro      Out Varchar2) Is

  /**************************************************************************
    Autor       : Miguel Angel Lopez Santos
    Fecha       : 2015-08-28
    Descripcion : Generamos informacion para reportes de Proyeccion de Diferidos

    Parametros Entrada
      inuano A?o
      inumes Mes
      inuserv  Tipo Producto


    Valor de salida
      merror  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR          DESCRIPCION

  ***************************************************************************/

  --nucont1   Number := 0;
  nusession Number;
  sbperi    Varchar2(100);

  Cursor curdiferido Is
    Select difecodi,
           difenuse,
           difefein,
           difefumo,
           difeconc,
           difesape,
           difeinte,
           difenucu - difecupa cuotas,
           difevacu,
           difemeca
      From ldc_osf_diferido
     Where difeano = inano
       And difemes = inmes
       And difenuse In
           (Select sesunuse From servsusc Where sesuserv = inservicio);

  inx   Number;
  cp    Number;
  vacu  Number;
  saldo Number;
  vcap0 Number;
  vcap1 Number;
  vcap2 Number;
  vcap3 Number;
  vcap4 Number;
  vcap5 Number;
  vcap6 Number;

  tvcap0 Number := 0;
  tvcap1 Number := 0;
  tvcap2 Number := 0;
  tvcap3 Number := 0;
  tvcap4 Number := 0;
  tvcap5 Number := 0;
  tvcap6 Number := 0;

  int_mes Number :=0;

  varano Integer := inano;
  varmes Integer := inmes;
  fecha  Date;
  mes    Varchar2(30);

Begin

  Select userenv('sessionid') Into nusession From dual;
  ldc_proinsertaestaprog(inano,
                         inmes,
                         'LDRGPRCB',
                         'Inicia ejecucion (Servicio ' || inservicio ||
                         ')..',
                         nusession,
                         User);

  -- Borramos los datos del periodo y servicio
  Delete open.ldc_osf_proyrecar rc
   Where rc.anogene = inano
     And rc.mesgene = inmes
     And rc.servgene = inservicio;
  Commit;

  fecha := to_date('01' || lpad(varmes, 2, '0') || varano,
                   'ddMMyyyy',
                   'NLS_DATE_LANGUAGE = SPANISH');

  mes := Trim(to_char(fecha, 'Month', 'NLS_DATE_LANGUAGE = SPANISH'));
  For indife In curdiferido Loop
    vcap0 := 0;
    vcap1 := 0;
    vcap2 := 0;
    vcap3 := 0;
    vcap4 := 0;
    vcap5 := 0;
    vcap6 := 0;

    vacu  := indife.difevacu;
    saldo := indife.difesape;

    int_mes := (power(1 + (indife.difeinte/100), 1/12) - 1);

    For nucuota In 1 .. indife.cuotas Loop
      inx := round((indife.difeinte / 100 / 12) * saldo, 0);

      cp := vacu - inx;

      If cp > saldo Or nucuota = indife.cuotas Then
        cp := saldo;
      End If;

      Case
        When (nucuota <= 12) Then
          vcap0 := vcap0 + nvl(cp, 0);
        When (nucuota Between 13 And 24) Then
          vcap1 := vcap1 + nvl(cp, 0);
        When (nucuota Between 25 And 36) Then
          vcap2 := vcap2 + nvl(cp, 0);
        When (nucuota Between 37 And 48) Then
          vcap3 := vcap3 + nvl(cp, 0);
        When (nucuota Between 49 And 60) Then
          vcap4 := vcap4 + nvl(cp, 0);
        When (nucuota Between 61 And 72) Then
          vcap5 := vcap5 + nvl(cp, 0);
        When (nucuota > 72) Then
          vcap6 := vcap6 + nvl(cp, 0);
      End Case;

      saldo := saldo - cp;
      If saldo <= 0 Then
        Exit;
      End If;

    End Loop;

    tvcap0 := tvcap0 + vcap0;
    tvcap1 := tvcap1 + vcap1;
    tvcap2 := tvcap2 + vcap2;
    tvcap3 := tvcap3 + vcap3;
    tvcap4 := tvcap4 + vcap4;
    tvcap5 := tvcap5 + vcap5;
    tvcap6 := tvcap6 + vcap6;

  End Loop;

  sbperi := 'De ' || mes || ' de ' || (varano + 0) || ' A ' || mes ||
            ' de ' || (varano + 1);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor)
  Values
    (inano, inmes, inservicio, sbperi, tvcap0);

  sbperi := 'De ' || mes || ' de ' || (varano + 1) || ' A ' || mes ||
            ' de ' || (varano + 2);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor)
  Values
    (inano, inmes, inservicio, sbperi, tvcap1);

  sbperi := 'De ' || mes || ' de ' || (varano + 2) || ' A ' || mes ||
            ' de ' || (varano + 3);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor)
  Values
    (inano, inmes, inservicio, sbperi, tvcap2);

  sbperi := 'De ' || mes || ' de ' || (varano + 3) || ' A ' || mes ||
            ' de ' || (varano + 4);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor)
  Values
    (inano, inmes, inservicio, sbperi, tvcap3);

  sbperi := 'De ' || mes || ' de ' || (varano + 4) || ' A ' || mes ||
            ' de ' || (varano + 5);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor)
  Values
    (inano, inmes, inservicio, sbperi, tvcap4);

  sbperi := 'De ' || mes || ' de ' || (varano + 5) || ' A ' || mes ||
            ' de ' || (varano + 6);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor)
  Values
    (inano, inmes, inservicio, sbperi, tvcap5);

  sbperi := 'De ' || mes || ' de ' || (varano + 6) || ' en adelante : ';
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor)
  Values
    (inano, inmes, inservicio, sbperi, tvcap6);

  Commit;

  merro := 'Proceso termino Ok (Servicio ' || inservicio || ')';
  ldc_proinsertaestaprog(inano, inmes, 'LDRGPRCB', merro, nusession, User);

Exception
  When Others Then
    merro := 'Error en LDRGPRCB (Servicio ' || inservicio || ')' ||
             Sqlerrm;
    ldc_proinsertaestaprog(inano,
                           inmes,
                           'LDRGPRCB',
                           'Error en LDRGPRCB (Servicio ' || inservicio || ')',
                           nusession,
                           User);

End ldc_procgeneraproyecdife;
/
