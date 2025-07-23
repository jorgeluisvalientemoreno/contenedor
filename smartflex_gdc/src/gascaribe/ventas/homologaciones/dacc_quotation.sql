
DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FSBOBTDESCRIPTION');

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
       UPPER('dacc_quotation.FSBGETDESCRIPTION'),
       'Obtener Descripcion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FSBOBTDESCRIPTION'),
       'Obtener Descripcion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTDESCRIPTION fue homologado al servicio origen dacc_quotation.FSBGETDESCRIPTION de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTDESCRIPTION ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTDESCRIPTION ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACDESCRIPTION');

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
       UPPER('dacc_quotation.UPDDESCRIPTION'),
       'Actualizar Descripcion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACDESCRIPTION'),
       'Actualizar Descripcion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACDESCRIPTION fue homologado al servicio origen dacc_quotation.UPDDESCRIPTION de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACDESCRIPTION ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACDESCRIPTION ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FDTOBTREGISTER_DATE');

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
       UPPER('dacc_quotation.FDTGETREGISTER_DATE'),
       'Obtener Fecha de registro',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FDTOBTREGISTER_DATE'),
       'Obtener Fecha de registro',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTREGISTER_DATE fue homologado al servicio origen dacc_quotation.FDTGETREGISTER_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTREGISTER_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTREGISTER_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACREGISTER_DATE');

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
       UPPER('dacc_quotation.UPDREGISTER_DATE'),
       'Actualizar Fecha de registro',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACREGISTER_DATE'),
       'Actualizar Fecha de registro',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACREGISTER_DATE fue homologado al servicio origen dacc_quotation.UPDREGISTER_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACREGISTER_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACREGISTER_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FSBOBTSTATUS');

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
       UPPER('dacc_quotation.FSBGETSTATUS'),
       'Obtener Estado (R-Registrada, A-Aprobada, C-Aceptada, N-Anulada)',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FSBOBTSTATUS'),
       'Obtener Estado (R-Registrada, A-Aprobada, C-Aceptada, N-Anulada)',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTSTATUS fue homologado al servicio origen dacc_quotation.FSBGETSTATUS de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTSTATUS ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTSTATUS ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACSTATUS');

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
       UPPER('dacc_quotation.UPDSTATUS'),
       'Actualizar Estado (R-Registrada, A-Aprobada, C-Aceptada, N-Anulada)',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACSTATUS'),
       'Actualizar Estado (R-Registrada, A-Aprobada, C-Aceptada, N-Anulada)',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACSTATUS fue homologado al servicio origen dacc_quotation.UPDSTATUS de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACSTATUS ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACSTATUS ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTSUBSCRIBER_ID');

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
       UPPER('dacc_quotation.FNUGETSUBSCRIBER_ID'),
       'Obtener Identificador del cliente',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTSUBSCRIBER_ID'),
       'Obtener Identificador del cliente',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTSUBSCRIBER_ID fue homologado al servicio origen dacc_quotation.FNUGETSUBSCRIBER_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTSUBSCRIBER_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTSUBSCRIBER_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACSUBSCRIBER_ID');

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
       UPPER('dacc_quotation.UPDSUBSCRIBER_ID'),
       'Actualizar Identificador del cliente',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACSUBSCRIBER_ID'),
       'Actualizar Identificador del cliente',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACSUBSCRIBER_ID fue homologado al servicio origen dacc_quotation.UPDSUBSCRIBER_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACSUBSCRIBER_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACSUBSCRIBER_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTREGISTER_PERSON_ID');

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
       UPPER('dacc_quotation.FNUGETREGISTER_PERSON_ID'),
       'Obtener Funcionario que registra',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTREGISTER_PERSON_ID'),
       'Obtener Funcionario que registra',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTREGISTER_PERSON_ID fue homologado al servicio origen dacc_quotation.FNUGETREGISTER_PERSON_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTREGISTER_PERSON_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTREGISTER_PERSON_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACREGISTER_PERSON_ID');

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
       UPPER('dacc_quotation.UPDREGISTER_PERSON_ID'),
       'Actualizar Funcionario que registra',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACREGISTER_PERSON_ID'),
       'Actualizar Funcionario que registra',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACREGISTER_PERSON_ID fue homologado al servicio origen dacc_quotation.UPDREGISTER_PERSON_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACREGISTER_PERSON_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACREGISTER_PERSON_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTPACKAGE_ID');

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
       UPPER('dacc_quotation.FNUGETPACKAGE_ID'),
       'Obtener Solicitud asociada',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTPACKAGE_ID'),
       'Obtener Solicitud asociada',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPACKAGE_ID fue homologado al servicio origen dacc_quotation.FNUGETPACKAGE_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPACKAGE_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPACKAGE_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACPACKAGE_ID');

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
       UPPER('dacc_quotation.UPDPACKAGE_ID'),
       'Actualizar Solicitud asociada',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACPACKAGE_ID'),
       'Actualizar Solicitud asociada',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPACKAGE_ID fue homologado al servicio origen dacc_quotation.UPDPACKAGE_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPACKAGE_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPACKAGE_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FDTOBTEND_DATE');

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
       UPPER('dacc_quotation.FDTGETEND_DATE'),
       'Obtener Fecha final de vigencia',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FDTOBTEND_DATE'),
       'Obtener Fecha final de vigencia',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTEND_DATE fue homologado al servicio origen dacc_quotation.FDTGETEND_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTEND_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTEND_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACEND_DATE');

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
       UPPER('dacc_quotation.UPDEND_DATE'),
       'Actualizar Fecha final de vigencia',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACEND_DATE'),
       'Actualizar Fecha final de vigencia',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACEND_DATE fue homologado al servicio origen dacc_quotation.UPDEND_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACEND_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACEND_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTUPDATE_PERSON_ID');

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
       UPPER('dacc_quotation.FNUGETUPDATE_PERSON_ID'),
       'Obtener Funcionario que modifica',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTUPDATE_PERSON_ID'),
       'Obtener Funcionario que modifica',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTUPDATE_PERSON_ID fue homologado al servicio origen dacc_quotation.FNUGETUPDATE_PERSON_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTUPDATE_PERSON_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTUPDATE_PERSON_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACUPDATE_PERSON_ID');

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
       UPPER('dacc_quotation.UPDUPDATE_PERSON_ID'),
       'Actualizar Funcionario que modifica',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACUPDATE_PERSON_ID'),
       'Actualizar Funcionario que modifica',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACUPDATE_PERSON_ID fue homologado al servicio origen dacc_quotation.UPDUPDATE_PERSON_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACUPDATE_PERSON_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACUPDATE_PERSON_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FDTOBTUPDATE_DATE');

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
       UPPER('dacc_quotation.FDTGETUPDATE_DATE'),
       'Obtener Fecha de modificacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FDTOBTUPDATE_DATE'),
       'Obtener Fecha de modificacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTUPDATE_DATE fue homologado al servicio origen dacc_quotation.FDTGETUPDATE_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTUPDATE_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FDTOBTUPDATE_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACUPDATE_DATE');

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
       UPPER('dacc_quotation.UPDUPDATE_DATE'),
       'Actualizar Fecha de modificacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACUPDATE_DATE'),
       'Actualizar Fecha de modificacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACUPDATE_DATE fue homologado al servicio origen dacc_quotation.UPDUPDATE_DATE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACUPDATE_DATE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACUPDATE_DATE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTINITIAL_PAYMENT');

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
       UPPER('dacc_quotation.FNUGETINITIAL_PAYMENT'),
       'Obtener Anticipo',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTINITIAL_PAYMENT'),
       'Obtener Anticipo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTINITIAL_PAYMENT fue homologado al servicio origen dacc_quotation.FNUGETINITIAL_PAYMENT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTINITIAL_PAYMENT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTINITIAL_PAYMENT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACINITIAL_PAYMENT');

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
       UPPER('dacc_quotation.UPDINITIAL_PAYMENT'),
       'Actualizar Anticipo',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACINITIAL_PAYMENT'),
       'Actualizar Anticipo',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACINITIAL_PAYMENT fue homologado al servicio origen dacc_quotation.UPDINITIAL_PAYMENT de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACINITIAL_PAYMENT ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACINITIAL_PAYMENT ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTDISCOUNT_PERCENTAGE');

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
       UPPER('dacc_quotation.FNUGETDISCOUNT_PERCENTAGE'),
       'Obtener Porcentaje de descuento',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTDISCOUNT_PERCENTAGE'),
       'Obtener Porcentaje de descuento',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTDISCOUNT_PERCENTAGE fue homologado al servicio origen dacc_quotation.FNUGETDISCOUNT_PERCENTAGE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTDISCOUNT_PERCENTAGE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTDISCOUNT_PERCENTAGE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACDISCOUNT_PERCENTAGE');

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
       UPPER('dacc_quotation.UPDDISCOUNT_PERCENTAGE'),
       'Actualizar Porcentaje de descuento',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACDISCOUNT_PERCENTAGE'),
       'Actualizar Porcentaje de descuento',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACDISCOUNT_PERCENTAGE fue homologado al servicio origen dacc_quotation.UPDDISCOUNT_PERCENTAGE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACDISCOUNT_PERCENTAGE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACDISCOUNT_PERCENTAGE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FSBOBTGENERATED_CHARGES');

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
       UPPER('dacc_quotation.FSBGETGENERATED_CHARGES'),
       'Obtener Indica si ya se genero el cobro por la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FSBOBTGENERATED_CHARGES'),
       'Obtener Indica si ya se genero el cobro por la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTGENERATED_CHARGES fue homologado al servicio origen dacc_quotation.FSBGETGENERATED_CHARGES de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTGENERATED_CHARGES ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTGENERATED_CHARGES ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACGENERATED_CHARGES');

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
       UPPER('dacc_quotation.UPDGENERATED_CHARGES'),
       'Actualizar Indica si ya se genero el cobro por la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACGENERATED_CHARGES'),
       'Actualizar Indica si ya se genero el cobro por la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACGENERATED_CHARGES fue homologado al servicio origen dacc_quotation.UPDGENERATED_CHARGES de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACGENERATED_CHARGES ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACGENERATED_CHARGES ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FSBOBTINIT_PAYMENT_MODE');

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
       UPPER('dacc_quotation.FSBGETINIT_PAYMENT_MODE'),
       'Obtener Forma de pago de cuota inicial',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FSBOBTINIT_PAYMENT_MODE'),
       'Obtener Forma de pago de cuota inicial',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTINIT_PAYMENT_MODE fue homologado al servicio origen dacc_quotation.FSBGETINIT_PAYMENT_MODE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTINIT_PAYMENT_MODE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTINIT_PAYMENT_MODE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACINIT_PAYMENT_MODE');

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
       UPPER('dacc_quotation.UPDINIT_PAYMENT_MODE'),
       'Actualizar Forma de pago de cuota inicial',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACINIT_PAYMENT_MODE'),
       'Actualizar Forma de pago de cuota inicial',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACINIT_PAYMENT_MODE fue homologado al servicio origen dacc_quotation.UPDINIT_PAYMENT_MODE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACINIT_PAYMENT_MODE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACINIT_PAYMENT_MODE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTTOTAL_ITEMS_VALUE');

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
       UPPER('dacc_quotation.FNUGETTOTAL_ITEMS_VALUE'),
       'Obtener Valor de los items de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTTOTAL_ITEMS_VALUE'),
       'Obtener Valor de los items de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_ITEMS_VALUE fue homologado al servicio origen dacc_quotation.FNUGETTOTAL_ITEMS_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_ITEMS_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_ITEMS_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACTOTAL_ITEMS_VALUE');

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
       UPPER('dacc_quotation.UPDTOTAL_ITEMS_VALUE'),
       'Actualizar Valor de los items de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACTOTAL_ITEMS_VALUE'),
       'Actualizar Valor de los items de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_ITEMS_VALUE fue homologado al servicio origen dacc_quotation.UPDTOTAL_ITEMS_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_ITEMS_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_ITEMS_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTTOTAL_DISC_VALUE');

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
       UPPER('dacc_quotation.FNUGETTOTAL_DISC_VALUE'),
       'Obtener Valor de descuentos de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTTOTAL_DISC_VALUE'),
       'Obtener Valor de descuentos de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_DISC_VALUE fue homologado al servicio origen dacc_quotation.FNUGETTOTAL_DISC_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_DISC_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_DISC_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACTOTAL_DISC_VALUE');

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
       UPPER('dacc_quotation.UPDTOTAL_DISC_VALUE'),
       'Actualizar Valor de descuentos de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACTOTAL_DISC_VALUE'),
       'Actualizar Valor de descuentos de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_DISC_VALUE fue homologado al servicio origen dacc_quotation.UPDTOTAL_DISC_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_DISC_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_DISC_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTTOTAL_TAX_VALUE');

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
       UPPER('dacc_quotation.FNUGETTOTAL_TAX_VALUE'),
       'Obtener Valor de impuestos de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTTOTAL_TAX_VALUE'),
       'Obtener Valor de impuestos de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_TAX_VALUE fue homologado al servicio origen dacc_quotation.FNUGETTOTAL_TAX_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_TAX_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_TAX_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACTOTAL_TAX_VALUE');

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
       UPPER('dacc_quotation.UPDTOTAL_TAX_VALUE'),
       'Actualizar Valor de impuestos de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACTOTAL_TAX_VALUE'),
       'Actualizar Valor de impuestos de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_TAX_VALUE fue homologado al servicio origen dacc_quotation.UPDTOTAL_TAX_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_TAX_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_TAX_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FSBOBTCOMMENT_');

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
       UPPER('dacc_quotation.FSBGETCOMMENT_'),
       'Obtener Comentario',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FSBOBTCOMMENT_'),
       'Obtener Comentario',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTCOMMENT_ fue homologado al servicio origen dacc_quotation.FSBGETCOMMENT_ de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTCOMMENT_ ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTCOMMENT_ ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACCOMMENT_');

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
       UPPER('dacc_quotation.UPDCOMMENT_'),
       'Actualizar Comentario',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACCOMMENT_'),
       'Actualizar Comentario',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACCOMMENT_ fue homologado al servicio origen dacc_quotation.UPDCOMMENT_ de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACCOMMENT_ ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACCOMMENT_ ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTPAY_MODALITY');

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
       UPPER('dacc_quotation.FNUGETPAY_MODALITY'),
       'Obtener Modalidad de Pago (1. Antes de hacer los Trabajos, 2. Al Finalizar Trabajos, 3. Segun Avance de Obra)',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTPAY_MODALITY'),
       'Obtener Modalidad de Pago (1. Antes de hacer los Trabajos, 2. Al Finalizar Trabajos, 3. Segun Avance de Obra)',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPAY_MODALITY fue homologado al servicio origen dacc_quotation.FNUGETPAY_MODALITY de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPAY_MODALITY ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPAY_MODALITY ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACPAY_MODALITY');

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
       UPPER('dacc_quotation.UPDPAY_MODALITY'),
       'Actualizar Modalidad de Pago (1. Antes de hacer los Trabajos, 2. Al Finalizar Trabajos, 3. Segun Avance de Obra)',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACPAY_MODALITY'),
       'Actualizar Modalidad de Pago (1. Antes de hacer los Trabajos, 2. Al Finalizar Trabajos, 3. Segun Avance de Obra)',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPAY_MODALITY fue homologado al servicio origen dacc_quotation.UPDPAY_MODALITY de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPAY_MODALITY ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPAY_MODALITY ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTPRODUCT_TYPE_ID');

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
       UPPER('dacc_quotation.FNUGETPRODUCT_TYPE_ID'),
       'Obtener Tipo de Producto',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTPRODUCT_TYPE_ID'),
       'Obtener Tipo de Producto',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPRODUCT_TYPE_ID fue homologado al servicio origen dacc_quotation.FNUGETPRODUCT_TYPE_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPRODUCT_TYPE_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTPRODUCT_TYPE_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACPRODUCT_TYPE_ID');

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
       UPPER('dacc_quotation.UPDPRODUCT_TYPE_ID'),
       'Actualizar Tipo de Producto',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACPRODUCT_TYPE_ID'),
       'Actualizar Tipo de Producto',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPRODUCT_TYPE_ID fue homologado al servicio origen dacc_quotation.UPDPRODUCT_TYPE_ID de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPRODUCT_TYPE_ID ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACPRODUCT_TYPE_ID ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FSBOBTNO_QUOT_ITEM_CHARGE');

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
       UPPER('dacc_quotation.FSBGETNO_QUOT_ITEM_CHARGE'),
       'Obtener Indica que se cobran los items que no se encuentran en la cotizacion.',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FSBOBTNO_QUOT_ITEM_CHARGE'),
       'Obtener Indica que se cobran los items que no se encuentran en la cotizacion.',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTNO_QUOT_ITEM_CHARGE fue homologado al servicio origen dacc_quotation.FSBGETNO_QUOT_ITEM_CHARGE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTNO_QUOT_ITEM_CHARGE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FSBOBTNO_QUOT_ITEM_CHARGE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACNO_QUOT_ITEM_CHARGE');

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
       UPPER('dacc_quotation.UPDNO_QUOT_ITEM_CHARGE'),
       'Actualizar Indica que se cobran los items que no se encuentran en la cotizacion.',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACNO_QUOT_ITEM_CHARGE'),
       'Actualizar Indica que se cobran los items que no se encuentran en la cotizacion.',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACNO_QUOT_ITEM_CHARGE fue homologado al servicio origen dacc_quotation.UPDNO_QUOT_ITEM_CHARGE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACNO_QUOT_ITEM_CHARGE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACNO_QUOT_ITEM_CHARGE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTAUI_PERCENTAGE');

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
       UPPER('dacc_quotation.FNUGETAUI_PERCENTAGE'),
       'Obtener Porcentaje de AUI de la Cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTAUI_PERCENTAGE'),
       'Obtener Porcentaje de AUI de la Cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTAUI_PERCENTAGE fue homologado al servicio origen dacc_quotation.FNUGETAUI_PERCENTAGE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTAUI_PERCENTAGE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTAUI_PERCENTAGE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACAUI_PERCENTAGE');

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
       UPPER('dacc_quotation.UPDAUI_PERCENTAGE'),
       'Actualizar Porcentaje de AUI de la Cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACAUI_PERCENTAGE'),
       'Actualizar Porcentaje de AUI de la Cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACAUI_PERCENTAGE fue homologado al servicio origen dacc_quotation.UPDAUI_PERCENTAGE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACAUI_PERCENTAGE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACAUI_PERCENTAGE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.FNUOBTTOTAL_AIU_VALUE');

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
       UPPER('dacc_quotation.FNUGETTOTAL_AIU_VALUE'),
       'Obtener Valor de AIU de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.FNUOBTTOTAL_AIU_VALUE'),
       'Obtener Valor de AIU de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_AIU_VALUE fue homologado al servicio origen dacc_quotation.FNUGETTOTAL_AIU_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_AIU_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.FNUOBTTOTAL_AIU_VALUE ya fue homologado a un servicio origen.');
END;
/

DECLARE
  NUCANTIDAD NUMBER;
BEGIN

  SELECT COUNT(1) INTO NUCANTIDAD
  FROM HOMOLOGACION_SERVICIOS HS
  WHERE UPPER(HS.SERVICIO_DESTINO) = UPPER('pkg_cc_quotation.PRACTOTAL_AIU_VALUE');

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
       UPPER('dacc_quotation.UPDTOTAL_AIU_VALUE'),
       'Actualizar Valor de AIU de la cotizacion',
       'ADM_PERSON',
       UPPER('pkg_cc_quotation.PRACTOTAL_AIU_VALUE'),
       'Actualizar Valor de AIU de la cotizacion',
       NULL);

    COMMIT;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_AIU_VALUE fue homologado al servicio origen dacc_quotation.UPDTOTAL_AIU_VALUE de forma exisosa');
  ELSE
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_AIU_VALUE ya fue homologado a un servicio origen.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.put_line('El servicio destino pkg_cc_quotation.PRACTOTAL_AIU_VALUE ya fue homologado a un servicio origen.');
END;
/
