CREATE OR REPLACE PROCEDURE ldc_progencarttipoconc(nupano NUMBER,nupmes NUMBER,sbpmensa OUT VARCHAR2,nuperror OUT NUMBER) IS
/***********************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2015-01-20
  Descripcion : Generamos informacion de indicador cartera por departamento, localidad y tipo de concepto

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION
 **********************************************************************************************************/

 CURSOR cudatosdeploctipo IS
  SELECT c.departamento
        ,c.localidad
        ,r.conctico tipo_concepto
        ,SUM(c.valor_causado+c.valor_diferido) total_deuda
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nupano
     AND c.numes        = nupmes
     AND c.concepto     = r.conccodi
   GROUP BY c.departamento,c.localidad,r.conctico;

 nutotalmespres       NUMBER(15,2);
 nutotalmesante       NUMBER(15,2);
 nuvariacitotal       NUMBER(15,2);
 nucarporctotal       NUMBER(7,2);
 nutotalvenpres       NUMBER(15,2);
 nutotalvenante       NUMBER(15,2);
 nuvariacitoven       NUMBER(15,2);
 nucarporctoven       NUMBER(7,2);
 nuporcenvenprm       NUMBER(7,2);
 nuporcenvenman       NUMBER(7,2);
 nutotalcacam90prm    NUMBER(15,2);
 nutotalcacam90mea    NUMBER(15,2);
 nuvariaciocacam90    NUMBER(15,2);
 nuvariaporcacam90    NUMBER(7,2);
 nuporcacam90preme    NUMBER(7,2);
 nuporcacam90meame    NUMBER(7,2);
 nutotalcam90prm      NUMBER(15,2);
 nutotalcam90mea      NUMBER(15,2);
 nuvariaciocam90      NUMBER(15,2);
 nuvariaporcam90      NUMBER(7,2);
 nutotaluscam90prm    NUMBER(15,2);
 nutotaluscam90mea    NUMBER(15,2);
 nuvariaciototusum90  NUMBER(15,2);
 nuvariacioporcusum90 NUMBER(15,2);
 nutotalcontactprm    NUMBER(10);
 nutotalcontactmea    NUMBER(10);
 nuvarcantusuacum     NUMBER(10);
 nuvarporcantusuacum  NUMBER(7,2);
 nuporcusuma90prm     NUMBER(7,2);
 nuporcusuma90mea     NUMBER(7,2);
 nuconta              NUMBER(10) DEFAULT 0;
 nuerror              NUMBER(4);
 nuanoant             NUMBER(4);
 numesant             NUMBER(2);
 nupergasplus         NUMBER(6);
 nupermesant          NUMBER(6);
BEGIN
 sbpmensa := NULL;
 nuperror := 0;
 nuerror  := -1;
 IF nupmes = 1 THEN
  nuanoant := nupano - 1;
  numesant := 12;
 ELSE
  nuanoant := nupano;
  numesant := nupmes - 1;
 END IF;
 -- Periodo cierre gasplus
 nupergasplus := open.dald_parameter.fnuGetNumeric_Value('ANO_CIERRE_GASPLUS',NULL);
 nupermesant  := to_number(nuanoant||numesant);
 -- Borramos los datos de la tabla
  DELETE open.ldc_osf_cartticonc h WHERE h.nuano = nupano AND h.numes = nupmes;
  COMMIT;
 FOR i IN cudatosdeploctipo LOOP
 -- Cartera causada + diferida presente mes
  nutotalmespres := NVL(i.total_deuda,0);
 -- Cartera causada + diferida mes anterior
  SELECT SUM(c.valor_causado+c.valor_diferido) INTO nutotalmesante
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nuanoant
     AND c.numes        = numesant
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
  nutotalmesante := NVL(nutotalmesante,0);
   nuerror  := -2;
  -- Variacion en $ total cartera
  nuvariacitotal := nutotalmespres - nutotalmesante;
  -- Variacion en % total cartera
  IF NVL(nutotalmesante,0) = 0 THEN
     nucarporctotal := 0;
  ELSE
   nucarporctotal := round((nuvariacitotal/nutotalmesante)*100,2);
  END IF;
   nuerror  := -3;
  -- Total vencido mes presente
  SELECT SUM(c.valor_causado+c.valor_diferido) INTO nutotalvenpres
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nupano
     AND c.numes        = nupmes
     AND c.nuedad       >= open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A_30',NULL)
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
  nutotalvenpres := nvl(nutotalvenpres,0);
   nuerror  := -4;
    -- Total vencido mes anterior
  SELECT SUM(c.valor_causado+c.valor_diferido) INTO nutotalvenante
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nuanoant
     AND c.numes        = numesant
     AND c.nuedad       >= decode(nupermesant,nupergasplus,30+30,open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A_30',NULL))
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
   nutotalvenante := nvl(nutotalvenante,0);
    nuerror  := -5;
   -- Variacion en pesos total vencido
   nuvariacitoven := nutotalvenpres - nutotalvenante;
   -- Variacion en % total vencido
   IF NVL(nutotalvenante,0) = 0 THEN
     nucarporctoven := 0;
   ELSE
    nucarporctoven := ROUND((nuvariacitoven/nutotalvenante)*100,2);
   END IF;
    nuerror  := -6;
   -- % vencido presente mes
   IF NVL(nutotalmespres,0) = 0 THEN
     nuporcenvenprm := 0;
   ELSE
    nuporcenvenprm := ROUND((nutotalvenpres/nutotalmespres) * 100,2);
   END IF;
    nuerror  := -7;
   -- % vencido mes anterior
   IF NVL(nutotalmesante,0) = 0 THEN
    nuporcenvenman := 0;
   ELSE
    nuporcenvenman := ROUND((nutotalvenante/nutotalmesante) * 100,2);
   END IF;
     nuerror  := -8;
  -- Total cartera causada a + 90 mes presente
  SELECT SUM(c.valor_causado) INTO nutotalcacam90prm
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nupano
     AND c.numes        = nupmes
     AND c.nuedad       >= open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A',NULL)
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
  nutotalcacam90prm := nvl(nutotalcacam90prm,0);
   nuerror  := -9;
    -- Total cartera causada a + 90 mes anterior
  SELECT SUM(c.valor_causado) INTO nutotalcacam90mea
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nuanoant
     AND c.numes        = numesant
     AND c.nuedad       >= decode(nupermesant,nupergasplus,90+30,open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A',NULL))
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
   nutotalcacam90mea := nvl(nutotalcacam90mea,0);
    nuerror  := -10;
  -- variacion en pesos cartera causada + 90 dias
   nuvariaciocacam90 := nutotalcacam90prm - nutotalcacam90mea;
    nuerror  := -11;
  -- variacion en % cartera causada + 90 dias
  IF NVL(nutotalcacam90mea,0) = 0 THEN
     nuvariaporcacam90 := 0;
  ELSE
   nuvariaporcacam90 := round((nuvariaciocacam90/nutotalcacam90mea)*100,2);
  END IF;
   nuerror  := -12;
  -- % Cartera causada + 90 dias presente mes
   nuporcacam90preme := round((nutotalcacam90prm/nutotalmespres)*100,2);
    nuerror  := -13;
  -- % Cartera causada + 90 dias mes anterior
   nuporcacam90meame := round((nutotalcacam90mea/nutotalmesante)*100,2);
    nuerror  := -14;
   -- Total cartera a + 90 mes presente
  SELECT SUM(c.valor_causado+c.valor_diferido) INTO nutotalcam90prm
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nupano
     AND c.numes        = nupmes
     AND c.nuedad       >= open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A',NULL)
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
  nutotalcam90prm := nvl(nutotalcam90prm,0);
   nuerror  := -15;
    -- Total cartera a + 90 mes anterior
  SELECT SUM(c.valor_causado+c.valor_diferido) INTO nutotalcam90mea
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nuanoant
     AND c.numes        = numesant
     AND c.nuedad       >= decode(nupermesant,nupergasplus,90+30,open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A',NULL))
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
   nutotalcam90mea := nvl(nutotalcam90mea,0);
    nuerror  := -16;
  -- variacion en pesos cartera + 90 dias
   nuvariaciocam90 := nutotalcam90prm - nutotalcam90mea;
    nuerror  := -17;
  -- variacion en % cartera + 90 dias
  IF NVL(nutotalcam90mea,0) = 0 THEN
     nuvariaporcam90 := 0;
  ELSE
   nuvariaporcam90 := round((nuvariaciocam90/nutotalcam90mea)*100,2);
  END IF;
   nuerror  := -18;
  -- Total usuarios cartera a + 90 mes presente
  SELECT SUM(c.cant_contratos) INTO nutotaluscam90prm
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nupano
     AND c.numes        = nupmes
     AND c.nuedad       >= decode(nupermesant,nupergasplus,90,open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A',NULL))
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
  nutotaluscam90prm := nvl(nutotaluscam90prm,0);
   nuerror  := -19;
  -- Total usuarios cartera a + 90 mes anterior
  SELECT SUM(c.cant_contratos) INTO nutotaluscam90mea
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano        = nuanoant
     AND c.numes        = numesant
     AND c.nuedad       >= decode(nupermesant,nupergasplus,90+30,open.dald_parameter.fnuGetNumeric_Value('EDAD_MORA_MAYOR_A',NULL))
     AND c.departamento = i.departamento
     AND c.localidad    = i.localidad
     AND r.conctico     = i.tipo_concepto
     AND c.concepto     = r.conccodi;
   nutotaluscam90mea := nvl(nutotaluscam90mea,0);
    nuerror  := -20;
  -- Variacion total usuarios +90
  nuvariaciototusum90 := nutotaluscam90prm - nutotaluscam90mea;
   nuerror  := -21;
  -- Variacion % usuarios + 90
  IF NVL(nutotaluscam90mea,0) = 0 THEN
     nuvariacioporcusum90 := 0;
  ELSE
   nuvariacioporcusum90 := round((nuvariaciototusum90/nutotaluscam90mea)*100,2);
  END IF;
   nuerror  := -22;
  -- Total contratos activos a cierre
  SELECT SUM(c.cant_contratos) INTO nutotalcontactprm
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano           = nupano
     AND c.numes           = nupmes
     AND c.estado_corte NOT IN(95,110)
     AND c.departamento    = i.departamento
     AND c.localidad       = i.localidad
     AND r.conctico        = i.tipo_concepto
     AND c.concepto        = r.conccodi;
  nutotalcontactprm := nvl(nutotalcontactprm,0);
   nuerror  := -23;
  -- Total usuarios activos mes anterior
  SELECT SUM(c.cant_contratos) INTO nutotalcontactmea
    FROM open.ldc_osf_cartconci c
        ,open.concepto r
   WHERE c.nuano           = nuanoant
     AND c.numes           = numesant
     AND c.estado_corte NOT IN(95,110)
     AND c.departamento    = i.departamento
     AND c.localidad       = i.localidad
     AND r.conctico        = i.tipo_concepto
     AND c.concepto        = r.conccodi;
   nutotalcontactmea := nvl(nutotalcontactmea,0);
    nuerror  := -24;
   -- Variacion cantidad usuarios acumulados
   nuvarcantusuacum := nutotalcontactprm - nutotalcontactmea;
    nuerror  := -25;
   -- Variacion cantidad usuarios acumulados
   IF NVL(nutotalcontactmea,0) = 0 THEN
     nuvarporcantusuacum := 0;
   ELSE
    nuvarporcantusuacum := round((nuvarcantusuacum/nutotalcontactmea)*100,2);
   END IF;
    nuerror  := -26;
   -- % Usuarios a + de 90 dias presente mes
   IF NVL(nutotalcontactprm,0) = 0 THEN
      nuporcusuma90prm := 0;
   ELSE
     nuporcusuma90prm := round((nutotaluscam90prm/nutotalcontactprm)*100,2);
   END IF;
    nuerror  := -27;
   -- % Usuarios a + de 90 dias mes anterior
   IF NVL(nutotalcontactmea,0) = 0 THEN
      nuporcusuma90mea := 0;
   ELSE
     nuporcusuma90mea := round((nutotaluscam90mea/nutotalcontactmea)*100,2);
   END IF;
    nuerror  := -28;
 -- Insertamos registro
    INSERT INTO ldc_osf_cartticonc
                                 (
                                  nuano
                                 ,numes
                                 ,nuanoant
                                 ,numesant
                                 ,departamento
                                 ,localidad
                                 ,tipo_conc
                                 ,total_cartera
                                 ,total_cart_anterior
                                 ,vari_$_total_cartera
                                 ,vari_porc_total_cartera
                                 ,total_vencido
                                 ,total_vencido_anterior
                                 ,vari_$_total_vencido
                                 ,vari_porc_total_venc
                                 ,porc_vencido
                                 ,porc_vencido_anterior
                                 ,cartera_caus_mas_90_dias
                                 ,cartera_caus_mas_90_ante
                                 ,vari_$_mas_90_caus
                                 ,porc_caus_mas_90
                                 ,porc_causad_mas_90
                                 ,porc_causad_mas_90_ante
                                 ,cartera_total_mas_90
                                 ,cartera_total_mas_90_ante
                                 ,variacion_carte_total_90
                                 ,variacion_porc_cart_tot_90
                                 ,canti_contratos_act
                                 ,canti_contratos_ant
                                 ,variacion_usu
                                 ,porc_vari_ucus
                                 ,total_contr_act_acum
                                 ,total_contr_act_acum_ante
                                 ,variacion_cont_acum
                                 ,porc_varia_usua_acum
                                 ,porc_usua_mas_90_pre
                                 ,porc_usua_mas_90_ante
                                 )
                          VALUES
                                (
                                 nupano
                                ,nupmes
                                ,nuanoant
                                ,numesant
                                ,i.departamento
                                ,i.localidad
                                ,i.tipo_concepto
                                ,nvl(nutotalmespres,0)
                                ,nvl(nutotalmesante,0)
                                ,nvl(nuvariacitotal,0)
                                ,nvl(nucarporctotal,0)
                                ,nvl(nutotalvenpres,0)
                                ,nvl(nutotalvenante,0)
                                ,nvl(nuvariacitoven,0)
                                ,nvl(nucarporctoven,0)
                                ,nvl(nuporcenvenprm,0)
                                ,nvl(nuporcenvenman,0)
                                ,nvl(nutotalcacam90prm,0)
                                ,nvl(nutotalcacam90mea,0)
                                ,nvl(nuvariaciocacam90,0)
                                ,nvl(nuvariaporcacam90,0)
                                ,nvl(nuporcacam90preme,0)
                                ,nvl(nuporcacam90meame,0)
                                ,nvl(nutotalcam90prm,0)
                                ,nvl(nutotalcam90mea,0)
                                ,nvl(nuvariaciocam90,0)
                                ,nvl(nuvariaporcam90,0)
                                ,nvl(nutotaluscam90prm,0)
                                ,nvl(nutotaluscam90mea,0)
                                ,nvl(nuvariaciototusum90,0)
                                ,nvl(nuvariacioporcusum90,0)
                                ,nvl(nutotalcontactprm,0)
                                ,nvl(nutotalcontactmea,0)
                                ,nvl(nuvarcantusuacum,0)
                                ,nvl(nuvarporcantusuacum,0)
                                ,nvl(nuporcusuma90prm,0)
                                ,nvl(nuporcusuma90mea,0)
                                );
   nuconta := nuconta + 1;
  COMMIT;
 END LOOP;
 nuperror := 0;
 sbpmensa := 'Proceso termino Ok. Se procesaron : '||to_char(nuconta)||' registros.';
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbpmensa := 'Error en ldc_progencarttipoconc lineas error '||nuerror||' '||sqlerrm;
  nuperror := -1;
END;
/
