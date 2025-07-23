
DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTFINANCING_PLAN_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETFINANCING_PLAN_ID'),
       'Obtener PLAN DE FINANCIACION',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTFINANCING_PLAN_ID'),
       'Obtener PLAN DE FINANCIACION',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTFINANCING_PLAN_ID fue homologado al servicio origen dacc_sales_financ_cond.FNUGETFINANCING_PLAN_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTFINANCING_PLAN_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTFINANCING_PLAN_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACFINANCING_PLAN_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDFINANCING_PLAN_ID'),
       'Actualizar PLAN DE FINANCIACION',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACFINANCING_PLAN_ID'),
       'Actualizar PLAN DE FINANCIACION',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFINANCING_PLAN_ID fue homologado al servicio origen dacc_sales_financ_cond.UPDFINANCING_PLAN_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFINANCING_PLAN_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFINANCING_PLAN_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTCOMPUTE_METHOD_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETCOMPUTE_METHOD_ID'),
       'Obtener METODO DE CALCULO DE CUOTA DE FINANCIACION',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTCOMPUTE_METHOD_ID'),
       'Obtener METODO DE CALCULO DE CUOTA DE FINANCIACION',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTCOMPUTE_METHOD_ID fue homologado al servicio origen dacc_sales_financ_cond.FNUGETCOMPUTE_METHOD_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTCOMPUTE_METHOD_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTCOMPUTE_METHOD_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACCOMPUTE_METHOD_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDCOMPUTE_METHOD_ID'),
       'Actualizar METODO DE CALCULO DE CUOTA DE FINANCIACION',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACCOMPUTE_METHOD_ID'),
       'Actualizar METODO DE CALCULO DE CUOTA DE FINANCIACION',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACCOMPUTE_METHOD_ID fue homologado al servicio origen dacc_sales_financ_cond.UPDCOMPUTE_METHOD_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACCOMPUTE_METHOD_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACCOMPUTE_METHOD_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTINTEREST_RATE_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETINTEREST_RATE_ID'),
       'Obtener CODIGO DE LA TASA DE INTERES',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTINTEREST_RATE_ID'),
       'Obtener CODIGO DE LA TASA DE INTERES',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINTEREST_RATE_ID fue homologado al servicio origen dacc_sales_financ_cond.FNUGETINTEREST_RATE_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINTEREST_RATE_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINTEREST_RATE_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACINTEREST_RATE_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDINTEREST_RATE_ID'),
       'Actualizar CODIGO DE LA TASA DE INTERES',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACINTEREST_RATE_ID'),
       'Actualizar CODIGO DE LA TASA DE INTERES',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINTEREST_RATE_ID fue homologado al servicio origen dacc_sales_financ_cond.UPDINTEREST_RATE_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINTEREST_RATE_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINTEREST_RATE_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FDTOBTFIRST_PAY_DATE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FDTGETFIRST_PAY_DATE'),
       'Obtener FECHA DE COBRO DE LA PRIMERA CUOTA',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FDTOBTFIRST_PAY_DATE'),
       'Obtener FECHA DE COBRO DE LA PRIMERA CUOTA',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FDTOBTFIRST_PAY_DATE fue homologado al servicio origen dacc_sales_financ_cond.FDTGETFIRST_PAY_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FDTOBTFIRST_PAY_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FDTOBTFIRST_PAY_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACFIRST_PAY_DATE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDFIRST_PAY_DATE'),
       'Actualizar FECHA DE COBRO DE LA PRIMERA CUOTA',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACFIRST_PAY_DATE'),
       'Actualizar FECHA DE COBRO DE LA PRIMERA CUOTA',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFIRST_PAY_DATE fue homologado al servicio origen dacc_sales_financ_cond.UPDFIRST_PAY_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFIRST_PAY_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFIRST_PAY_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTPERCENT_TO_FINANCE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETPERCENT_TO_FINANCE'),
       'Obtener PORCENTAJE A FINANCIAR',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTPERCENT_TO_FINANCE'),
       'Obtener PORCENTAJE A FINANCIAR',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTPERCENT_TO_FINANCE fue homologado al servicio origen dacc_sales_financ_cond.FNUGETPERCENT_TO_FINANCE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTPERCENT_TO_FINANCE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTPERCENT_TO_FINANCE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACPERCENT_TO_FINANCE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDPERCENT_TO_FINANCE'),
       'Actualizar PORCENTAJE A FINANCIAR',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACPERCENT_TO_FINANCE'),
       'Actualizar PORCENTAJE A FINANCIAR',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACPERCENT_TO_FINANCE fue homologado al servicio origen dacc_sales_financ_cond.UPDPERCENT_TO_FINANCE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACPERCENT_TO_FINANCE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACPERCENT_TO_FINANCE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTINTEREST_PERCENT');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETINTEREST_PERCENT'),
       'Obtener PORCENTAJE DE INTERES',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTINTEREST_PERCENT'),
       'Obtener PORCENTAJE DE INTERES',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINTEREST_PERCENT fue homologado al servicio origen dacc_sales_financ_cond.FNUGETINTEREST_PERCENT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINTEREST_PERCENT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINTEREST_PERCENT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACINTEREST_PERCENT');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDINTEREST_PERCENT'),
       'Actualizar PORCENTAJE DE INTERES',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACINTEREST_PERCENT'),
       'Actualizar PORCENTAJE DE INTERES',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINTEREST_PERCENT fue homologado al servicio origen dacc_sales_financ_cond.UPDINTEREST_PERCENT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINTEREST_PERCENT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINTEREST_PERCENT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTSPREAD');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETSPREAD'),
       'Obtener PUNTOS ADICIONALES',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTSPREAD'),
       'Obtener PUNTOS ADICIONALES',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTSPREAD fue homologado al servicio origen dacc_sales_financ_cond.FNUGETSPREAD de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTSPREAD ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTSPREAD ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACSPREAD');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDSPREAD'),
       'Actualizar PUNTOS ADICIONALES',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACSPREAD'),
       'Actualizar PUNTOS ADICIONALES',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACSPREAD fue homologado al servicio origen dacc_sales_financ_cond.UPDSPREAD de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACSPREAD ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACSPREAD ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTQUOTAS_NUMBER');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETQUOTAS_NUMBER'),
       'Obtener NUMERO DE CUOTAS',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTQUOTAS_NUMBER'),
       'Obtener NUMERO DE CUOTAS',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTQUOTAS_NUMBER fue homologado al servicio origen dacc_sales_financ_cond.FNUGETQUOTAS_NUMBER de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTQUOTAS_NUMBER ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTQUOTAS_NUMBER ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACQUOTAS_NUMBER');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDQUOTAS_NUMBER'),
       'Actualizar NUMERO DE CUOTAS',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACQUOTAS_NUMBER'),
       'Actualizar NUMERO DE CUOTAS',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACQUOTAS_NUMBER fue homologado al servicio origen dacc_sales_financ_cond.UPDQUOTAS_NUMBER de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACQUOTAS_NUMBER ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACQUOTAS_NUMBER ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FSBOBTTAX_FINANCING_ONE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FSBGETTAX_FINANCING_ONE'),
       'Obtener FINANCIAR IVA A UNA CUOTA',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FSBOBTTAX_FINANCING_ONE'),
       'Obtener FINANCIAR IVA A UNA CUOTA',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FSBOBTTAX_FINANCING_ONE fue homologado al servicio origen dacc_sales_financ_cond.FSBGETTAX_FINANCING_ONE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FSBOBTTAX_FINANCING_ONE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FSBOBTTAX_FINANCING_ONE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACTAX_FINANCING_ONE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDTAX_FINANCING_ONE'),
       'Actualizar FINANCIAR IVA A UNA CUOTA',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACTAX_FINANCING_ONE'),
       'Actualizar FINANCIAR IVA A UNA CUOTA',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACTAX_FINANCING_ONE fue homologado al servicio origen dacc_sales_financ_cond.UPDTAX_FINANCING_ONE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACTAX_FINANCING_ONE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACTAX_FINANCING_ONE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTVALUE_TO_FINANCE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETVALUE_TO_FINANCE'),
       'Obtener VALOR A FINANCIAR',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTVALUE_TO_FINANCE'),
       'Obtener VALOR A FINANCIAR',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTVALUE_TO_FINANCE fue homologado al servicio origen dacc_sales_financ_cond.FNUGETVALUE_TO_FINANCE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTVALUE_TO_FINANCE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTVALUE_TO_FINANCE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACVALUE_TO_FINANCE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDVALUE_TO_FINANCE'),
       'Actualizar VALOR A FINANCIAR',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACVALUE_TO_FINANCE'),
       'Actualizar VALOR A FINANCIAR',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACVALUE_TO_FINANCE fue homologado al servicio origen dacc_sales_financ_cond.UPDVALUE_TO_FINANCE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACVALUE_TO_FINANCE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACVALUE_TO_FINANCE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FSBOBTDOCUMENT_SUPPORT');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FSBGETDOCUMENT_SUPPORT'),
       'Obtener DOCUMENTO DE SOPORTE',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FSBOBTDOCUMENT_SUPPORT'),
       'Obtener DOCUMENTO DE SOPORTE',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FSBOBTDOCUMENT_SUPPORT fue homologado al servicio origen dacc_sales_financ_cond.FSBGETDOCUMENT_SUPPORT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FSBOBTDOCUMENT_SUPPORT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FSBOBTDOCUMENT_SUPPORT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACDOCUMENT_SUPPORT');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDDOCUMENT_SUPPORT'),
       'Actualizar DOCUMENTO DE SOPORTE',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACDOCUMENT_SUPPORT'),
       'Actualizar DOCUMENTO DE SOPORTE',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACDOCUMENT_SUPPORT fue homologado al servicio origen dacc_sales_financ_cond.UPDDOCUMENT_SUPPORT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACDOCUMENT_SUPPORT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACDOCUMENT_SUPPORT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTINITIAL_PAYMENT');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETINITIAL_PAYMENT'),
       'Obtener VALOR A PAGAR',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTINITIAL_PAYMENT'),
       'Obtener VALOR A PAGAR',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINITIAL_PAYMENT fue homologado al servicio origen dacc_sales_financ_cond.FNUGETINITIAL_PAYMENT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINITIAL_PAYMENT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTINITIAL_PAYMENT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACINITIAL_PAYMENT');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDINITIAL_PAYMENT'),
       'Actualizar VALOR A PAGAR',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACINITIAL_PAYMENT'),
       'Actualizar VALOR A PAGAR',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINITIAL_PAYMENT fue homologado al servicio origen dacc_sales_financ_cond.UPDINITIAL_PAYMENT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINITIAL_PAYMENT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACINITIAL_PAYMENT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTAVERAGE_QUOTE_VALUE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETAVERAGE_QUOTE_VALUE'),
       'Obtener Valor Promedio De La Cuota',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTAVERAGE_QUOTE_VALUE'),
       'Obtener Valor Promedio De La Cuota',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTAVERAGE_QUOTE_VALUE fue homologado al servicio origen dacc_sales_financ_cond.FNUGETAVERAGE_QUOTE_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTAVERAGE_QUOTE_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTAVERAGE_QUOTE_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACAVERAGE_QUOTE_VALUE');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDAVERAGE_QUOTE_VALUE'),
       'Actualizar Valor Promedio De La Cuota',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACAVERAGE_QUOTE_VALUE'),
       'Actualizar Valor Promedio De La Cuota',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACAVERAGE_QUOTE_VALUE fue homologado al servicio origen dacc_sales_financ_cond.UPDAVERAGE_QUOTE_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACAVERAGE_QUOTE_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACAVERAGE_QUOTE_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.FNUOBTFINAN_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.FNUGETFINAN_ID'),
       'Obtener Codigo agrupador de la financiacion',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.FNUOBTFINAN_ID'),
       'Obtener Codigo agrupador de la financiacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTFINAN_ID fue homologado al servicio origen dacc_sales_financ_cond.FNUGETFINAN_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTFINAN_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.FNUOBTFINAN_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_sales_financ_cond.PRACFINAN_ID');

  IF NUCANTIDAD = 0 THEN
    INSERT INTO HOMOLOGACION_SERVICIOS
      (ESQUEMA_ORIGEN,
       SERVICIO_ORIGEN,
       DESCRIPCION_ORIGEN,
       ESQUEMA_DESTINO,
       SERVICIO_DESTINO,
       DESCRIPCION_DESTINO,
       OBSERVACION)
    VALUES
      ('OPEN',
       UPPER('dacc_sales_financ_cond.UPDFINAN_ID'),
       'Actualizar Codigo agrupador de la financiacion',
       'ADM_PERSON',
       UPPER('pkg_cc_sales_financ_cond.PRACFINAN_ID'),
       'Actualizar Codigo agrupador de la financiacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFINAN_ID fue homologado al servicio origen dacc_sales_financ_cond.UPDFINAN_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFINAN_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_sales_financ_cond.PRACFINAN_ID ya fue homologado a un servicio origen.');
END;
/
