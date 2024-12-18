CREATE OR REPLACE procedure GENIFRS(inuschedule in ge_process_schedule.process_schedule_id%TYPE) is
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2021-12-06
   Ticket      : 906
   Proceso     : GENIFRS
   Descripcion : Procedimiento para la provision de loa perdida esperada

   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  --Variables para ESTAPROC
  nuparano  NUMBER(4);
  nuparmes  NUMBER(2);
  nutsess   NUMBER;
  sbparuser VARCHAR2(30);
  --Varibles para Valores en Instancia
  rcProcSched   dage_process_schedule.styge_process_schedule;
  sbFormValue   VARCHAR2(400);
  nuDirectoryid number;
  nuAnoSel      number;
  nuMesSel      number;
  --Variables del Servicio
  nuHaveCloseCom number;
  sbCORREOIFRS   ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('CORREOIFRS',
                                                                                   null);
  --Cursores para el Servicio
  cursor curDestinatarios is
    select column_value
      from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CORREOIFRS'),
                                              ','));
  --Variables para la Excepcion
  sbMsgError VARCHAR2(4000) := null;
  --Servicio para el envio de Correo
  PROCEDURE sendmail(isbasunto in varchar2, isbmsg in varchar2) IS
    sbDestinatariomail varchar2(1000);
  BEGIN
    OPEN curDestinatarios;
    Loop
      FETCH curDestinatarios
        INTO sbDestinatariomail;
      Exit when curDestinatarios%notfound;
      ldc_sendemail(sbDestinatariomail, isbasunto, isbmsg);
    end loop;
    close curDestinatarios;
  END sendmail;
begin
  /*El proceso dejara una traza en ESTAPROC para validar el inicio, fin y avance del proceso.*/
  -- Consultamos datos para inicializar el proceso
  SELECT to_number(to_char(SYSDATE, 'YYYY')),
         to_number(to_char(SYSDATE, 'MM')),
         userenv('SESSIONID'),
         USER
    INTO nuparano, nuparmes, nutsess, sbparuser
    FROM dual;
  -- Inicializamos el proceso
  ldc_proinsertaestaprog(nuparano,
                         nuparmes,
                         'GENIFRS',
                         'En ejecucion',
                         nutsess,
                         sbparuser);
  --
  /*Se instanciar¿n los datos ingresados en el PB y en la fecha establecida en la programaci¿n ejecutara en secuencia los procesos ejecutados en los JOB descritos en el levantamiento para el a¿o y el mes seleccionados en el PB.*/
  -- Instancia el proceso programado
  GE_BOSchedule.InstanceSchedule(inuschedule);
  -- carga el registro de programacion
  rcProcSched := dage_process_schedule.frcGetRecord(inuSchedule);
  -- Carga los parametros de la programacion
  sbFormValue    := UT_String.GetParameterValue(rcProcSched.parameters_,
                                                'ALIAS',
                                                '|',
                                                '=');
  nuAnoSel       := to_number(sbFormValue);
  sbFormValue    := UT_String.GetParameterValue(rcProcSched.parameters_,
                                                'STATUS',
                                                '|',
                                                '=');
  nuMesSel       := to_number(sbFormValue);
  sbFormValue    := UT_String.GetParameterValue(rcProcSched.parameters_,
                                                'DIRECTORY_ID',
                                                '|',
                                                '=');
  nuDirectoryid  := TO_NUMBER(sbFormValue);
  --El proceso notificara por correo electr¿nico a los correos definidos en el par¿metro CORREOIFRS el inicio de la ejecuci¿n del proceso.
  if sbCORREOIFRS is not null then
    sendmail('Inicio del Proceso de IFRS',
             'Se notifica el inicio del proceso de IFRS');
    --Se validar¿ en la tabla LDC_CIERCOME si el periodo seleccionado ha sido cerrado comercialmente
    select count(1)
      into nuHaveCloseCom
      from LDC_CIERCOME l
     where l.cicoano = nuAnoSel
       and l.cicomes = nuMesSel;
    if nuHaveCloseCom > 0 then
      --Se ejecutar¿ el servicio PKGLDC_IFRS.PREXECUTEIFRS
      pkgldc_ifrs.prExecuteIFRS(nuAnoSel, nuMesSel, 0);
      --Luego de este ¿ltimo se ejecutar¿ el servicio PKGLDC_IFRS.PROIFRSBRILLAFILE.
      pkgldc_ifrs.proifrsbrillafile(nuAnoSel, nuMesSel, nuDirectoryid);
      --Al final se enviar¿ una notificaci¿n por correo electr¿nico a los correos definidos en el par¿metro CORREOIFRS de la finalizaci¿n del proceso IFRS. (Punto 7)
      --En el mensaje del correo se deber¿ especificar si termino con ¿xito o Fallo
      --En caso de Fallo se incluir¿ una breve descripci¿n.
      sendmail('Ejecucion IFRS Exitosa',
               'Se ha ejecutado de forma Exitosa la provision IFRS de Perdida Esperada para el periodo ' ||
               nuAnoSel || to_char(nuMesSel, '00') || '.');
      ldc_proactualizaestaprog(nutsess,
                               'El proceso IFRS ha finalizado de forma Exitosa',
                               'GENIFRS',
                               'Ok');
    else
      sendmail('Ejecucion IFRS fallida',
               'No es posible ejecutar la provision IFRS de Perdida Esperada, ya que el cierre comercial del periodo ' ||
               nuAnoSel || to_char(nuMesSel, '00') ||
               ' no ha culminado. Por favor reprograme la ejecucion del proceso, una vez haya finalizado el cierre del mismo');
      ldc_proactualizaestaprog(nutsess,
                               'El periodo seleccionado [ A¿o ' || nuAnoSel ||
                               ' - Mes ' || nuMesSel ||
                               ' ] aun no ha sido cerrado Comercialmente',
                               'GENIFRS',
                               'Finalizo con Errores');
    end if;
  else
    ldc_proactualizaestaprog(nutsess,
                             'El parametro CORREOIFRS no tiene definidos Destinatarios a notificar',
                             'GENIFRS',
                             'Finalizo con Errores');
  end if;
EXCEPTION
  WHEN OTHERS THEN
    sbMsgError := SQLERRM;
    sendmail('Ejecucion IFRS fallida',
             'Se presentaron Errores al ejecutar la provision IFRS de Perdida Esperada para el periodo ' ||
             nuAnoSel || to_char(nuMesSel, '00') ||
             '. Valide en ESTAPROC el error presentado.');
    ldc_proactualizaestaprog(nutsess,
                             'Error en el Proceso - ' || sbMsgError,
                             'GENIFRS',
                             'Error - Se detuvo el Proceso');
    RAISE ex.controlled_error;
end GENIFRS;
/
