CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_RESETINTMENSCAJAGRIS is

  /********************************************************************************
      Propiedad intelectual de Gases del Caribe E.S.P (c).

  Unidad         : Ldci_ResetIntMensCajaGris
  Descripcion    : PB LDCIMCG
                   Muestra los mensajes de la caja gris con el numero maximo de reintentos
                   y coloca el numero de intntos en nulo


  Autor          : F.Castro
  Fecha          :

  ***********************************************************************************/

  -----------------------
  -- Constants
  -----------------------
  -- Constante con el SAO de la ultima version aplicada

  -----------------------
  --------------------------------------------------------------------
  -- Variables
  --------------------------------------------------------------------
  --------------------------------------------------------------------
  -- Cursores
  --------------------------------------------------------------------
  -----------------------------------
  -- Metodos publicos del package
  -----------------------------------
  Function ConsMensCGEncolados return pkConstante.tyRefCursor;


  Procedure ResetReintentos(InMesacodi      number,
                           InuActReg       number,
                            InuTotalReg     number,
                          OnuErrorCode    out number,
                          OsbErrorMessage out varchar2);



END LDCI_RESETINTMENSCAJAGRIS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_RESETINTMENSCAJAGRIS is


  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ConsMensCGEncolados
   Descripcion    : Muestra mensajes de la Caja Gris con el numero maximo de reintentos


   Autor          : gdc
   Fecha          : 19/05/2016

   Parametros       Descripcion
   ============     ===================


   Historia de Modificaciones
   Fecha            Autor                 Modificacion
   =========        =========             ====================
  ******************************************************************/
  Function ConsMensCGEncolados return pkConstante.tyRefCursor is

    rfcursor   pkConstante.tyRefCursor;
    sbWebServ  ge_boInstanceControl.stysbValue;
    dtIni     ge_boInstanceControl.stysbValue;
    dtFin     ge_boInstanceControl.stysbValue;

    nuMaxRein number;

  begin

    ut_trace.trace('Inicio Ldci_ResetIntMensCajaGris.ConsMensCGEncolados', 10);

    /*obtener los valores ingresados en la aplicacion PB */
    sbWebServ := ge_boInstanceControl.fsbGetFieldValue('IN_INTERFACE_HISTORY','EXTERNAL_TERMINAL');

    dtIni := ge_boInstanceControl.fsbGetFieldValue('IN_INTERFACE_HISTORY', 'SEND_DATE_ORIGIN');

    dtFin := ge_boInstanceControl.fsbGetFieldValue('IN_INTERFACE_HISTORY', 'INSERTING_DATE');



    if (sbWebServ is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'El Servicio Web no debe ser nulo');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (dtIni is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'La Fecha Inicial no debe ser nula');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (dtFin is null) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'La Fecha Final no debe ser nula');
      raise ex.CONTROLLED_ERROR;
    end if;

    if (dtFin < dtIni) then
      Errors.SetError(Ld_Boconstans.cnuGeneric_Error,
                      'La Fecha Final debe ser posterior a la Inicial');
      raise ex.CONTROLLED_ERROR;
    end if;

    -- se halla el numero maximo de reintentos
    nuMaxRein  := dald_parameter.fnuGetNumeric_Value('NRO_MAX_REINT_MENS');

    OPEN rfcursor FOR
      SELECT mesacodi codigo,
             mesafech  Fecha,
             mesadefi Servicio,
             to_char(substr(mesaxmlenv,1,4000)) paquete_de_envio,
             mesaintentos "NroIntentos",
             mesahttperror Error_Http,
             mesatraceerror Traza_Error,
             to_char(substr(mesasoaperror,1,4000)) Error_Soap,
             to_char(substr(mesaxmlpayload,1,4000))  Datos_Xml,
             mesafechaini Fecha_Ini_Envio,
             mesafechafin Fecha_Fin_Envio,
             mesaproc Codigo_Estaproc
        FROM LDCI_MESAENVWS
       where mesaestado = -1
         and mesaintentos > nuMaxRein
         and mesadefi = sbWebServ
           and mesafech >= dtIni
           and mesafech <= dtFin
       order by mesafech;

    ut_trace.trace('Fin Ldci_ResetIntMensCajaGris.ConsMensCGEncolados', 10);

    return rfcursor;

  exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  end ConsMensCGEncolados;

  /*****************************************************************
   Propiedad intelectual de Open International Systems (c).

   Unidad         : ResetReintentos
   Descripción    : Proceso que coloca numero de reintentos en nulo

   Autor          : F.Castro
   Fecha          : 19/05/2016

   Parámetros          Descripción
   ============        ===================
   InMesacodi          Codigo del registro
   InuActReg           Registro actual
   InuTotalReg         Total de registros a procesar
   OnuErrorCode        Código de error
   OsbErrorMessage     Mensaje de error

   Historia de Modificaciones
   Fecha            Autor                 Modificación
   =========        =========             ====================
   10/06/2015       gdc                   Creación
  ******************************************************************/
  Procedure ResetReintentos(InMesacodi      number,
                           InuActReg       number,
                          InuTotalReg     number,
                          OnuErrorCode    out number,
                          OsbErrorMessage out varchar2) is

    /*Variables de instancia*/





  BEGIN

    ut_trace.trace('Inicio Ldci_ResetIntMensCajaGris.ResetReintentos', 10);


    update LDCI_MESAENVWS
       set mesaestado = -1,
           MESAINTENTOS = null
       where mesacodi = InMesacodi;



    /*Hacer commit si todo OK*/
    commit;

    ut_trace.trace('Fin Ldci_ResetIntMensCajaGris.ResetReintentos', 10);
  Exception
    When ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    When others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ResetReintentos;


END LDCI_RESETINTMENSCAJAGRIS;
/

PROMPT Asignación de permisos para el paquete LDCI_RESETINTMENSCAJAGRIS
begin
  pkg_utilidades.prAplicarPermisos('LDCI_RESETINTMENSCAJAGRIS', 'ADM_PERSON');
end;
/
