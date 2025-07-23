
DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FSBOBTPLDIDESC');

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
       UPPER('pktblplandife.FSBGETPLDIDESC'),
       'Obtener Descripcion Del Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.FSBOBTPLDIDESC'),
       'Obtener Descripcion Del Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIDESC fue homologado al servicio origen pktblplandife.FSBGETPLDIDESC de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIDESC ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIDESC ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIDESC');

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
       UPPER('pktblplandife.UPDPLDIDESC'),
       'Actualizar Descripcion Del Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIDESC'),
       'Actualizar Descripcion Del Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIDESC fue homologado al servicio origen pktblplandife.UPDPLDIDESC de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIDESC ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIDESC ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FDTOBTPLDIFECR');

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
       UPPER('pktblplandife.FDTGETPLDIFECR'),
       'Obtener Fecha De Creacion Del Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.FDTOBTPLDIFECR'),
       'Obtener Fecha De Creacion Del Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFECR fue homologado al servicio origen pktblplandife.FDTGETPLDIFECR de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFECR ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFECR ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIFECR');

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
       UPPER('pktblplandife.UPDPLDIFECR'),
       'Actualizar Fecha De Creacion Del Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIFECR'),
       'Actualizar Fecha De Creacion Del Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFECR fue homologado al servicio origen pktblplandife.UPDPLDIFECR de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFECR ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFECR ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FDTOBTPLDIFEIN');

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
       UPPER('pktblplandife.FDTGETPLDIFEIN'),
       'Obtener Fecha Inicial Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.FDTOBTPLDIFEIN'),
       'Obtener Fecha Inicial Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFEIN fue homologado al servicio origen pktblplandife.FDTGETPLDIFEIN de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFEIN ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFEIN ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIFEIN');

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
       UPPER('pktblplandife.UPDPLDIFEIN'),
       'Actualizar Fecha Inicial Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIFEIN'),
       'Actualizar Fecha Inicial Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFEIN fue homologado al servicio origen pktblplandife.UPDPLDIFEIN de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFEIN ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFEIN ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FDTOBTPLDIFEFI');

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
       UPPER('pktblplandife.FDTGETPLDIFEFI'),
       'Obtener Fecha Final Vigencia Del Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.FDTOBTPLDIFEFI'),
       'Obtener Fecha Final Vigencia Del Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFEFI fue homologado al servicio origen pktblplandife.FDTGETPLDIFEFI de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFEFI ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FDTOBTPLDIFEFI ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIFEFI');

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
       UPPER('pktblplandife.UPDPLDIFEFI'),
       'Actualizar Fecha Final Vigencia Del Plan',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIFEFI'),
       'Actualizar Fecha Final Vigencia Del Plan',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFEFI fue homologado al servicio origen pktblplandife.UPDPLDIFEFI de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFEFI ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFEFI ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDICUMI');

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
       UPPER('pktblplandife.FNUGETPLDICUMI'),
       'Obtener Numero Minimo De Cuotas',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDICUMI'),
       'Obtener Numero Minimo De Cuotas',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUMI fue homologado al servicio origen pktblplandife.FNUGETPLDICUMI de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUMI ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUMI ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDICUMI');

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
       UPPER('pktblplandife.UPDPLDICUMI'),
       'Actualizar Numero Minimo De Cuotas',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDICUMI'),
       'Actualizar Numero Minimo De Cuotas',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUMI fue homologado al servicio origen pktblplandife.UPDPLDICUMI de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUMI ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUMI ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDICUMA');

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
       UPPER('pktblplandife.FNUGETPLDICUMA'),
       'Obtener Numero Maximo De Cuotas',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDICUMA'),
       'Obtener Numero Maximo De Cuotas',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUMA fue homologado al servicio origen pktblplandife.FNUGETPLDICUMA de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUMA ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUMA ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDICUMA');

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
       UPPER('pktblplandife.UPDPLDICUMA'),
       'Actualizar Numero Maximo De Cuotas',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDICUMA'),
       'Actualizar Numero Maximo De Cuotas',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUMA fue homologado al servicio origen pktblplandife.UPDPLDICUMA de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUMA ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUMA ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDIPOIN');

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
       UPPER('pktblplandife.FNUGETPLDIPOIN'),
       'Obtener Porcentaje De Interes',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDIPOIN'),
       'Obtener Porcentaje De Interes',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPOIN fue homologado al servicio origen pktblplandife.FNUGETPLDIPOIN de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPOIN ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPOIN ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIPOIN');

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
       UPPER('pktblplandife.UPDPLDIPOIN'),
       'Actualizar Porcentaje De Interes',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIPOIN'),
       'Actualizar Porcentaje De Interes',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPOIN fue homologado al servicio origen pktblplandife.UPDPLDIPOIN de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPOIN ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPOIN ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDIMCCD');

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
       UPPER('pktblplandife.FNUGETPLDIMCCD'),
       'Obtener Metodo de Calculo',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDIMCCD'),
       'Obtener Metodo de Calculo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIMCCD fue homologado al servicio origen pktblplandife.FNUGETPLDIMCCD de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIMCCD ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIMCCD ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIMCCD');

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
       UPPER('pktblplandife.UPDPLDIMCCD'),
       'Actualizar Metodo de Calculo',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIMCCD'),
       'Actualizar Metodo de Calculo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIMCCD fue homologado al servicio origen pktblplandife.UPDPLDIMCCD de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIMCCD ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIMCCD ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FSBOBTPLDIGECO');

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
       UPPER('pktblplandife.FSBGETPLDIGECO'),
       'Obtener Genera Pagare?',
       'ADM_PERSON',
       UPPER('pkg_plandife.FSBOBTPLDIGECO'),
       'Obtener Genera Pagare?',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIGECO fue homologado al servicio origen pktblplandife.FSBGETPLDIGECO de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIGECO ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIGECO ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIGECO');

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
       UPPER('pktblplandife.UPDPLDIGECO'),
       'Actualizar Genera Pagare?',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIGECO'),
       'Actualizar Genera Pagare?',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIGECO fue homologado al servicio origen pktblplandife.UPDPLDIGECO de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIGECO ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIGECO ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDICEMA');

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
       UPPER('pktblplandife.FNUGETPLDICEMA'),
       'Obtener Numero Maximo De Cuotas Extras',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDICEMA'),
       'Obtener Numero Maximo De Cuotas Extras',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICEMA fue homologado al servicio origen pktblplandife.FNUGETPLDICEMA de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICEMA ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICEMA ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDICEMA');

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
       UPPER('pktblplandife.UPDPLDICEMA'),
       'Actualizar Numero Maximo De Cuotas Extras',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDICEMA'),
       'Actualizar Numero Maximo De Cuotas Extras',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICEMA fue homologado al servicio origen pktblplandife.UPDPLDICEMA de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICEMA ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICEMA ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FSBOBTPLDIDOSO');

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
       UPPER('pktblplandife.FSBGETPLDIDOSO'),
       'Obtener Documento Soporte  De Creacion Del Plan De Diferidos',
       'ADM_PERSON',
       UPPER('pkg_plandife.FSBOBTPLDIDOSO'),
       'Obtener Documento Soporte  De Creacion Del Plan De Diferidos',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIDOSO fue homologado al servicio origen pktblplandife.FSBGETPLDIDOSO de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIDOSO ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FSBOBTPLDIDOSO ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIDOSO');

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
       UPPER('pktblplandife.UPDPLDIDOSO'),
       'Actualizar Documento Soporte  De Creacion Del Plan De Diferidos',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIDOSO'),
       'Actualizar Documento Soporte  De Creacion Del Plan De Diferidos',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIDOSO fue homologado al servicio origen pktblplandife.UPDPLDIDOSO de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIDOSO ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIDOSO ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDISPMA');

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
       UPPER('pktblplandife.FNUGETPLDISPMA'),
       'Obtener Valor De Spread Maximo',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDISPMA'),
       'Obtener Valor De Spread Maximo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDISPMA fue homologado al servicio origen pktblplandife.FNUGETPLDISPMA de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDISPMA ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDISPMA ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDISPMA');

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
       UPPER('pktblplandife.UPDPLDISPMA'),
       'Actualizar Valor De Spread Maximo',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDISPMA'),
       'Actualizar Valor De Spread Maximo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDISPMA fue homologado al servicio origen pktblplandife.UPDPLDISPMA de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDISPMA ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDISPMA ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDISPMI');

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
       UPPER('pktblplandife.FNUGETPLDISPMI'),
       'Obtener Valor De Spread Minimo',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDISPMI'),
       'Obtener Valor De Spread Minimo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDISPMI fue homologado al servicio origen pktblplandife.FNUGETPLDISPMI de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDISPMI ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDISPMI ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDISPMI');

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
       UPPER('pktblplandife.UPDPLDISPMI'),
       'Actualizar Valor De Spread Minimo',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDISPMI'),
       'Actualizar Valor De Spread Minimo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDISPMI fue homologado al servicio origen pktblplandife.UPDPLDISPMI de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDISPMI ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDISPMI ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDITAIN');

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
       UPPER('pktblplandife.FNUGETPLDITAIN'),
       'Obtener Tasa de Interes',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDITAIN'),
       'Obtener Tasa de Interes',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDITAIN fue homologado al servicio origen pktblplandife.FNUGETPLDITAIN de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDITAIN ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDITAIN ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDITAIN');

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
       UPPER('pktblplandife.UPDPLDITAIN'),
       'Actualizar Tasa de Interes',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDITAIN'),
       'Actualizar Tasa de Interes',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDITAIN fue homologado al servicio origen pktblplandife.UPDPLDITAIN de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDITAIN ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDITAIN ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDIFAGR');

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
       UPPER('pktblplandife.FNUGETPLDIFAGR'),
       'Obtener Valor Del Factor Gradiente',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDIFAGR'),
       'Obtener Valor Del Factor Gradiente',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIFAGR fue homologado al servicio origen pktblplandife.FNUGETPLDIFAGR de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIFAGR ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIFAGR ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIFAGR');

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
       UPPER('pktblplandife.UPDPLDIFAGR'),
       'Actualizar Valor Del Factor Gradiente',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIFAGR'),
       'Actualizar Valor Del Factor Gradiente',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFAGR fue homologado al servicio origen pktblplandife.UPDPLDIFAGR de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFAGR ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIFAGR ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDICUVE');

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
       UPPER('pktblplandife.FNUGETPLDICUVE'),
       'Obtener Numero De Cuotas Vencidas',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDICUVE'),
       'Obtener Numero De Cuotas Vencidas',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUVE fue homologado al servicio origen pktblplandife.FNUGETPLDICUVE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUVE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDICUVE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDICUVE');

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
       UPPER('pktblplandife.UPDPLDICUVE'),
       'Actualizar Numero De Cuotas Vencidas',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDICUVE'),
       'Actualizar Numero De Cuotas Vencidas',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUVE fue homologado al servicio origen pktblplandife.UPDPLDICUVE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUVE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDICUVE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDINCVS');

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
       UPPER('pktblplandife.FNUGETPLDINCVS'),
       'Obtener Cuentas Vencidas Suspension',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDINCVS'),
       'Obtener Cuentas Vencidas Suspension',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDINCVS fue homologado al servicio origen pktblplandife.FNUGETPLDINCVS de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDINCVS ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDINCVS ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDINCVS');

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
       UPPER('pktblplandife.UPDPLDINCVS'),
       'Actualizar Cuentas Vencidas Suspension',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDINCVS'),
       'Actualizar Cuentas Vencidas Suspension',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDINCVS fue homologado al servicio origen pktblplandife.UPDPLDINCVS de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDINCVS ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDINCVS ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDINVRE');

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
       UPPER('pktblplandife.FNUGETPLDINVRE'),
       'Obtener Numero De Veces A Refinanciar',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDINVRE'),
       'Obtener Numero De Veces A Refinanciar',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDINVRE fue homologado al servicio origen pktblplandife.FNUGETPLDINVRE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDINVRE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDINVRE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDINVRE');

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
       UPPER('pktblplandife.UPDPLDINVRE'),
       'Actualizar Numero De Veces A Refinanciar',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDINVRE'),
       'Actualizar Numero De Veces A Refinanciar',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDINVRE fue homologado al servicio origen pktblplandife.UPDPLDINVRE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDINVRE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDINVRE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDIPMIF');

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
       UPPER('pktblplandife.FNUGETPLDIPMIF'),
       'Obtener Porcentaje Minimo A Financiar',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDIPMIF'),
       'Obtener Porcentaje Minimo A Financiar',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPMIF fue homologado al servicio origen pktblplandife.FNUGETPLDIPMIF de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPMIF ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPMIF ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIPMIF');

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
       UPPER('pktblplandife.UPDPLDIPMIF'),
       'Actualizar Porcentaje Minimo A Financiar',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIPMIF'),
       'Actualizar Porcentaje Minimo A Financiar',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPMIF fue homologado al servicio origen pktblplandife.UPDPLDIPMIF de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPMIF ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPMIF ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDIPMAF');

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
       UPPER('pktblplandife.FNUGETPLDIPMAF'),
       'Obtener Porcentaje Maximo A Financiar',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDIPMAF'),
       'Obtener Porcentaje Maximo A Financiar',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPMAF fue homologado al servicio origen pktblplandife.FNUGETPLDIPMAF de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPMAF ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPMAF ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIPMAF');

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
       UPPER('pktblplandife.UPDPLDIPMAF'),
       'Actualizar Porcentaje Maximo A Financiar',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIPMAF'),
       'Actualizar Porcentaje Maximo A Financiar',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPMAF fue homologado al servicio origen pktblplandife.UPDPLDIPMAF de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPMAF ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPMAF ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDIPRMO');

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
       UPPER('pktblplandife.FNUGETPLDIPRMO'),
       'Obtener porcentaje de recargo por mora',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDIPRMO'),
       'Obtener porcentaje de recargo por mora',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPRMO fue homologado al servicio origen pktblplandife.FNUGETPLDIPRMO de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPRMO ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPRMO ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIPRMO');

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
       UPPER('pktblplandife.UPDPLDIPRMO'),
       'Actualizar porcentaje de recargo por mora',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIPRMO'),
       'Actualizar porcentaje de recargo por mora',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPRMO fue homologado al servicio origen pktblplandife.UPDPLDIPRMO de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPRMO ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPRMO ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.FNUOBTPLDIPEGR');

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
       UPPER('pktblplandife.FNUGETPLDIPEGR'),
       'Obtener id del periodo de gracia',
       'ADM_PERSON',
       UPPER('pkg_plandife.FNUOBTPLDIPEGR'),
       'Obtener id del periodo de gracia',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPEGR fue homologado al servicio origen pktblplandife.FNUGETPLDIPEGR de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPEGR ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.FNUOBTPLDIPEGR ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_plandife.PRACPLDIPEGR');

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
       UPPER('pktblplandife.UPDPLDIPEGR'),
       'Actualizar id del periodo de gracia',
       'ADM_PERSON',
       UPPER('pkg_plandife.PRACPLDIPEGR'),
       'Actualizar id del periodo de gracia',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPEGR fue homologado al servicio origen pktblplandife.UPDPLDIPEGR de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPEGR ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_plandife.PRACPLDIPEGR ya fue homologado a un servicio origen.');
END;
/
