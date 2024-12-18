CREATE OR REPLACE PROCEDURE adm_person.ldc_proregcalcamortanoano(
                                                         inano       IN NUMBER,
                                                         inmes       IN NUMBER,
                                                         inservicio  IN NUMBER,
                                                         itipodif    IN VARCHAR2,
														                             max_cuota   IN NUMBER,
														                             sbmensaje  OUT VARCHAR2
                                                       ) IS
/******************************************************************************************************************
    Autor       : John Jairo Jimenez Marim?n
    Fecha       : 2020-Oct-24
    Descripcion : Registra calculo amortizaci?n a?o a a?o
                  CA 533
    Parametros Entrada
      inano       A?o
      inmes       Mes
      inservicio  Tipo Producto
      innrocuota   Nro cuota
      itipodif     Tipo de calcuclo(Diferido total, Diferido Corriente y Diferido no-corriente)

    Valor de salida
      sbmensaje
   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR          DESCRIPCION
   20/05/2024     Adrianavg      OSF-2673: Migrar del esquema OPEN al esquema ADM_PERSOM     
******************************************************************************************************************/
 TYPE t_ano_ano IS TABLE OF ldc_proyrecar_temp%ROWTYPE INDEX BY BINARY_INTEGER;
 v_ano_ano t_ano_ano;
 cuotas2    NUMBER;
 intereses2 NUMBER;
 sbperi     VARCHAR2(100);
 mes        VARCHAR2(30);
 fecha      DATE;
 nmposi     NUMBER(4);
 ncact      NUMBER(4);
 ncsig      NUMBER(4);
 vcap       NUMBER;
 vint       NUMBER;
BEGIN
 sbmensaje := NULL;
 fecha := to_date('01' || lpad(inmes, 2, '0') || inano,
                   'ddMMyyyy',
                   'NLS_DATE_LANGUAGE = SPANISH');

  mes := TRIM(to_char(fecha, 'Month', 'NLS_DATE_LANGUAGE = SPANISH'));
 FOR a In 1 .. max_cuota LOOP
   ldc_prodevuelvevalorescuotas(inano,inmes,inservicio,a,itipodif,'N',cuotas2, intereses2);
   IF a <= 12 THEN
     nmposi := 1;
   ElSIF a BETWEEN 13 AND 24 THEN
    nmposi := 2;
   ELSIF a BETWEEN 25 AND 36 THEN
    nmposi := 3;
   ELSIF a BETWEEN 37 AND 48 THEN
    nmposi := 4;
   ELSIF a BETWEEN 49 AND 60 THEN
    nmposi := 5;
   ELSIF a BETWEEN 61 AND 72 THEN
    nmposi := 6;
   ELSIF a >= 73 THEN
    nmposi := 7;
   END IF;
   IF itipodif = 'DCO' AND a <= 12 THEN
      vcap := nvl(cuotas2,0);
      vint := nvl(intereses2,0);
   ELSIF itipodif = 'DCO' AND a >= 13 THEN
      vcap := 0;
      vint := 0;
   ELSIF itipodif = 'DNC' AND a <= 12 THEN
     vcap := 0;
     vint := 0;
   ELSIF itipodif = 'DNC' AND a >= 13 THEN
     vcap := nvl(cuotas2,0);
     vint := nvl(intereses2,0);
   ELSIF itipodif = 'DTO' THEN
     vcap := nvl(cuotas2,0);
     vint := nvl(intereses2,0);
   END IF;
   IF v_ano_ano.exists(nmposi) THEN
    v_ano_ano(nmposi).cuota :=  v_ano_ano(nmposi).cuota + vcap;
    v_ano_ano(nmposi).interes :=  v_ano_ano(nmposi).interes + vint;
   ELSE
    v_ano_ano(nmposi).cuota := vcap;
    v_ano_ano(nmposi).interes := vint;
   END IF;
  END LOOP;
  ncact := 0;
  ncsig := 1;
  FOR i IN 1..v_ano_ano.count LOOP
   IF i = v_ano_ano.count THEN
     sbperi := 'De ' || mes || ' de ' || (inano + ncact) || ' en adelante : ';
   ELSE
    sbperi := 'De ' || mes || ' de ' || (inano + ncact) || ' A ' || mes ||
            ' de ' || (inano + ncsig);
   END IF;
   INSERT INTO open.ldc_osf_proyrecar
    (anogene, mesgene, servgene, periodo, valor, interes,tipo_calculo,amort_mes_mes)
   VALUES
    (inano, inmes, inservicio, sbperi, v_ano_ano(i).cuota, v_ano_ano(i).interes,itipodif,'N');
   ncact := ncact + 1;
   ncsig := ncsig + 1;
  END LOOP;
 sbmensaje := NULL;
EXCEPTION
 WHEN OTHERS THEN
  sbmensaje := 'Error en ldc_proregcalcamortanoano : '||sqlerrm;
END ldc_proregcalcamortanoano;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PROREGCALCAMORTANOANO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROREGCALCAMORTANOANO', 'ADM_PERSON'); 
END;
/
