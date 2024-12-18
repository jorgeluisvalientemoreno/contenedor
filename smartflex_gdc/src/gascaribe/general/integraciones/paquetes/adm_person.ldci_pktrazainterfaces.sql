CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKTRAZAINTERFACES
/************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PACKAGE      : ldci_pktrazainterfaces
   AUTOR        : Heiber Barco
   FECHA        : 02-08-2012
   TIQUETE      :
   DESCRIPCION  : Paquete para el manejo de trazas para los procesos
                  de interfaces

  Parametros de Entrada

  Parametros de Salida

  Historia de Modificaciones
  Autor     Fecha       Descripcion
  --------- ----------- ------------------------------------------------
************************************************************************/

IS
  --<<
  --Metodos publicos
  -->>
  PROCEDURE pRegiMensaje(ivaPrograma   IN ldci_logsproc.LOPRPROC%TYPE,
                         ivaMensaje0   IN ldci_logsproc.loprmen0%TYPE DEFAULT NULL,
                         ivaMensaje1   IN ldci_logsproc.loprmen1%TYPE DEFAULT NULL,
                         ivaMensaje2   IN ldci_logsproc.loprmen2%TYPE DEFAULT NULL,
                         ivaMensaje3   IN ldci_logsproc.loprmen3%TYPE DEFAULT NULL,
                         ivaTerminal   IN ldci_logsproc.loprterm%TYPE DEFAULT NULL);

END LDCI_PKTRAZAINTERFACES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKTRAZAINTERFACES
/************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PACKAGE      : ldci_pktrazainterfaces
   AUTOR        : Heiber Barco
   FECHA        : 02-08-2012
   TIQUETE      :
   DESCRIPCION  : Paquete para el manejo de trazas para los procesos
                  de interfaces

  Parametros de Entrada

  Parametros de Salida

  Historia de Modificaciones
  Autor     Fecha       Descripcion
  --------- ----------- ------------------------------------------------
************************************************************************/
IS

  FUNCTION fnuSeqTrazInte
  /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

    Procedimiento  : fnuSeqTrazInte
    AUTOR          : Heiber Barco
    FECHA          : 02-08-2012
    TIQUETE        :
    DESCRIPCION    : Obtiene el consecutivo de la tabla de trazas de interfaz

    Historia de Modificaciones
    Autor      Fecha       Descripcion
    ---------  ----------- ------------------------------------------------
  ************************************************************************/
  RETURN NUMBER

  IS

    --<<
    -- Variables
    -->>
    nuTrintCodi      ldci_logsproc.loprcodi%TYPE;

  BEGIN

    --<<
    -- Se obtiene el siguiente consecutivo
    -->>
    SELECT ldci_seqtrazaint.NEXTVAL INTO nuTrintCodi FROM dual;

    RETURN(nuTrintCodi);

  END fnuSeqTrazInte;


  PROCEDURE pRegiMensaje(ivaPrograma   IN ldci_logsproc.LOPRPROC%TYPE,
                         ivaMensaje0   IN ldci_logsproc.loprmen0%TYPE DEFAULT NULL,
                         ivaMensaje1   IN ldci_logsproc.loprmen1%TYPE DEFAULT NULL,
                         ivaMensaje2   IN ldci_logsproc.loprmen2%TYPE DEFAULT NULL,
                         ivaMensaje3   IN ldci_logsproc.loprmen3%TYPE DEFAULT NULL,
                         ivaTerminal   IN ldci_logsproc.loprterm%TYPE DEFAULT NULL)
  /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P

    Procedimiento  : pRegiMensaje
    AUTOR          : Heiber Barco
    FECHA          : 02-08-2012
    TIQUETE        :
    DESCRIPCION    : Registra los dos mensajes enviados como parametros en
                     la tabla de trazas de interfaz

    Historia de Modificaciones
    Autor      Fecha       Descripcion
    ---------  ----------- ------------------------------------------------
  ************************************************************************/
  IS
  PRAGMA AUTONOMOUS_TRANSACTION;

    --<<
    -- Variables
    -->>
    nuTrintCodi      ldci_logsproc.loprcodi%TYPE;
    nuActivo        NUMBER := 0;

    --<<
    -- Cursor para la configuracion de trazas para el proceso puntual
    -->>
    CURSOR cuActiTrInt
    IS
    SELECT prmofein, prmofefi, prmoflac
      FROM ldci_procmoni
     WHERE prmocodi = ivaPrograma;

    recuActiTrInt    cuActiTrInt%ROWTYPE;

  BEGIN

      --<<
      -- Se obtiene la configuracion de trazas para el proceso
      -- ingresado como parametro
      -->>
      OPEN cuActiTrInt;
      FETCH cuActiTrInt INTO recuActiTrInt;
      CLOSE cuActiTrInt;

      --<<
      -- Se valida que el flag de registrar trazas este activo
      -->>
      IF (recuActiTrInt.prmoflac = 'S') THEN

          --<<
          -- Se valida que la fecha actual se encuentre en el rango de fechas valido
          -- para registro de tazas para el programa que esta regitrando la traza.
          -->>
          IF (TRUNC(SYSDATE) >= recuActiTrInt.prmofein  AND TRUNC(SYSDATE) <= recuActiTrInt.prmofefi) THEN

              --<<
              --Obtencion del consecutivo de la secuencia
              -->>
              nuTrintCodi := ldci_pktrazainterfaces.fnuSeqTrazInte;

              --<<
              --Insercion del registro en la tabla de depuracion
              -->>
              INSERT INTO ldci_logsproc (loprproc, loprcodi, lopridse, loprfech, loprmen0, loprmen1, loprmen2, loprmen3, loprterm)
              VALUES (ivaPrograma, nuTrintCodi, TO_NUMBER(USERENV('SESSIONID')), SYSDATE, ivaMensaje0, ivaMensaje1, ivaMensaje2, ivaMensaje3, ivaTerminal);
--                dbms_output.put_line('PRUEBAS');
              COMMIT;

          END IF;

      END IF;

  EXCEPTION
  When Others then
      rollback;
      raise_application_error(-20000,'ldci_pktrazainterfaces.pRegiMensaje '||SQLERRM);

  END pRegiMensaje;

END ldci_pktrazainterfaces;
/

PROMPT Asignación de permisos para el método LDCI_PKTRAZAINTERFACES
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKTRAZAINTERFACES', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKTRAZAINTERFACES to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKTRAZAINTERFACES to INTEGRADESA;
/
