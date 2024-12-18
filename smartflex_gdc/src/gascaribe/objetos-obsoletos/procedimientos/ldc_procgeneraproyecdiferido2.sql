CREATE OR REPLACE Procedure ldc_procgeneraproyecdiferido2(inano      In Number,
                                                         inmes      In Number,
                                                         inservicio In Number,
                                                         merro      Out Varchar2) Is

  /**************************************************************************
    Autor       : Caren Berdejo
    Fecha       : 2016-07-08
    Descripcion : Generamos informacion para reportes de Proyeccion de Diferidos
                  CA 200-297
    Parametros Entrada
      inuano A?o
      inumes Mes
      inuserv  Tipo Producto


    Valor de salida
      merror  codigo del error

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR          DESCRIPCION


  ***************************************************************************/

  nusession Number;
  sbperi    Varchar2(100);
  mes       Varchar2(30);
  varano    Integer := inano;
  varmes    Integer := inmes;
  fecha     Date;

  capital    Number;
  cp         Number;
  max_cuota  Number;
  tasa       Number;
  cuotas     Number;
  intereses  Number;
  tasa_int   Number;
  cuotas2    Number;
  intereses2 Number;

  vcap0 Number;
  vcap1 Number;
  vcap2 Number;
  vcap3 Number;
  vcap4 Number;
  vcap5 Number;
  vcap6 Number;

  vint0 Number;
  vint1 Number;
  vint2 Number;
  vint3 Number;
  vint4 Number;
  vint5 Number;
  vint6 Number;
  nuconta NUMBER(10);

Begin

  vcap0 := 0;
  vcap1 := 0;
  vcap2 := 0;
  vcap3 := 0;
  vcap4 := 0;
  vcap5 := 0;
  vcap6 := 0;

  vint0 := 0;
  vint1 := 0;
  vint2 := 0;
  vint3 := 0;
  vint4 := 0;
  vint5 := 0;
  vint6 := 0;
  nuconta := 0;
  Select userenv('sessionid') Into nusession From dual;
  ldc_proinsertaestaprog(inano,
                         inmes,
                         'LDRGPRCB',
                         'Inicia ejecucion (Servicio ' || inservicio ||
                         ')..',
                         nusession,
                         User);

  Delete From open.ldc_osf_proyrecar_temp
   Where ano = inano
     And mes = inmes;

  Delete From open.ldc_osf_proyrecar
   Where anogene = inano
     And mesgene = inmes
     And servgene = inservicio;

  Commit;

  fecha := to_date('01' || lpad(varmes, 2, '0') || varano,
                   'ddMMyyyy',
                   'NLS_DATE_LANGUAGE = SPANISH');

  mes := Trim(to_char(fecha, 'Month', 'NLS_DATE_LANGUAGE = SPANISH'));

  Select cotiporc
    Into tasa
    From open.conftain
   Where cotitain = 2
     And inano Between to_char(cotifein, 'YYYY') And
         to_char(cotifefi, 'YYYY')
     And inmes Between to_char(cotifein, 'MM') And to_char(cotifefi, 'MM');

  tasa_int := (power(1 + (tasa / 100), 1 / 12) - 1);

  Select Max(difenucu - difecupa)
    Into max_cuota
    From open.ldc_osf_diferido,open.servsusc
   Where difeano = inano
     And difemes = inmes
     and sesuserv = inservicio
     And difenuse = sesunuse
     -- jjjm   (Select sesunuse From servsusc Where sesuserv = inservicio)
     ;

  For i In 1 .. max_cuota Loop
   For j In i .. max_cuota Loop
      select Sum(difesape)
        Into cp
        From open.ldc_osf_diferido,open.servsusc
       Where difeano = inano
         And difemes = inmes
         And difenucu - difecupa = j
         and sesuserv = inservicio
         And difenuse = sesunuse
      -- jjjm       (Select sesunuse From servsusc Where sesuserv = inservicio)
      ;
      capital := cp/j;

      intereses := capital * (((tasa_int) * power(1 + (tasa_int), j)) /
                   (power(1 + (tasa_int), j - 1)));

      cuotas := capital - intereses;

      Insert Into open.ldc_osf_proyrecar_temp
        (ano, mes, nucuota_i, nucuata_j, capital, cuota, interes)
      Values
        (inano, inmes, i, j, capital, cuotas, intereses);
      Commit;
      nuconta := nuconta +1;
    End Loop;
    UPDATE ldc_osf_estaproc l
       SET estado = 'Proceso ejecutandose. Registros procesados : '||to_char(nuconta)||' espere a que termine el proceso.'
     WHERE l.sesion  = nusession
       AND l.proceso = 'LDRGPRCB';
 COMMIT;
  End Loop;

  For a In 1 .. max_cuota Loop

    Select Sum(cuota), Sum(interes)
      Into cuotas2, intereses2
      From open.ldc_osf_proyrecar_temp
     Where nucuota_i = a;

    If a <= 12 Then
      vcap0 := vcap0 + nvl(cuotas2, 0);
      vint0 := vint0 + nvl(intereses2, 0);
    Else
      If a Between 13 And 24 Then
        vcap1 := vcap1 + nvl(cuotas2, 0);
        vint1 := vint1 + nvl(intereses2, 0);
      Else
        If a Between 25 And 36 Then
          vcap2 := vcap2 + nvl(cuotas2, 0);
          vint2 := vint2 + nvl(intereses2, 0);
        Else
          If a Between 37 And 48 Then
            vcap3 := vcap3 + nvl(cuotas2, 0);
            vint3 := vint3 + nvl(intereses2, 0);
          Else
            If a Between 49 And 60 Then
              vcap4 := vcap4 + nvl(cuotas2, 0);
              vint4 := vint4 + nvl(intereses2, 0);
            Else
              If a Between 61 And 72 Then
                vcap5 := vcap5 + nvl(cuotas2, 0);
                vint5 := vint5 + nvl(intereses2, 0);
              Else
                If a > 72 Then
                  vcap6 := vcap6 + nvl(cuotas2, 0);
                  vint6 := vint6 + nvl(intereses2, 0);
                End If;
              End If;
            End If;
          End If;
        End If;
      End If;
    End If;
   nuconta := nuconta + 1;
   UPDATE ldc_osf_estaproc l
       SET estado = 'Proceso ejecutandose. Registros procesados : '||to_char(nuconta)||' espere a que termine el proceso.'
     WHERE l.sesion  = nusession
       AND l.proceso = 'LDRGPRCB';
  End Loop;

  -- se agrega el campo de interes a los Insert (CA 200-297)
  sbperi := 'De ' || mes || ' de ' || (varano + 0) || ' A ' || mes ||
            ' de ' || (varano + 1);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes)
  Values
    (inano, inmes, inservicio, sbperi, vcap0, vint0);

  sbperi := 'De ' || mes || ' de ' || (varano + 1) || ' A ' || mes ||
            ' de ' || (varano + 2);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes)
  Values
    (inano, inmes, inservicio, sbperi, vcap1, vint1);

  sbperi := 'De ' || mes || ' de ' || (varano + 2) || ' A ' || mes ||
            ' de ' || (varano + 3);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes)
  Values
    (inano, inmes, inservicio, sbperi, vcap2, vint2);

  sbperi := 'De ' || mes || ' de ' || (varano + 3) || ' A ' || mes ||
            ' de ' || (varano + 4);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes)
  Values
    (inano, inmes, inservicio, sbperi, vcap3, vint3);

  sbperi := 'De ' || mes || ' de ' || (varano + 4) || ' A ' || mes ||
            ' de ' || (varano + 5);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes)
  Values
    (inano, inmes, inservicio, sbperi, vcap4, vint4);

  sbperi := 'De ' || mes || ' de ' || (varano + 5) || ' A ' || mes ||
            ' de ' || (varano + 6);
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes)
  Values
    (inano, inmes, inservicio, sbperi, vcap5, vint5);

  sbperi := 'De ' || mes || ' de ' || (varano + 6) || ' en adelante : ';
  Insert Into open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes)
  Values
    (inano, inmes, inservicio, sbperi, vcap6, vint6);

  Commit;

  merro := 'Proceso termino Ok. Total registros procesados : '||to_char(nuconta)||'. (Servicio ' || inservicio || ')';
  ldc_proactualizaestaprog(nusession,merro,'LDRGPRCB','Ok');
-- jjjm ldc_proinsertaestaprog(inano, inmes, 'LDRGPRCB', merro, nusession, User);

/*Exception
  When Others Then
    merro := 'Error en LDRGPRCB (Servicio ' || inservicio || ')' ||
             ;
             ldc_proactualizaestaprog(nusession,merro,'LDRGPRCB','Ok');*/
End ldc_procgeneraproyecdiferido2;
/
