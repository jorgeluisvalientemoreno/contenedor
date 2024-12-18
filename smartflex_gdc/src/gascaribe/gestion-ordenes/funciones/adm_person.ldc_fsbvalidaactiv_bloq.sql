CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBVALIDAACTIV_BLOQ" (inuactividad   In open.or_order_activity.activity_id%Type,
                                                   inuestadoorden In Number) Return Varchar2 Is
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe S.A.

  Unidad         : Ldc_FsbValidaActiv_Bloq
  Descripcion    : Valida si una actividad tiene un bloqueo configurado para las formas OSF.
                   Configurador Restricciones: Forma ORCREST
                   Devuelve S/N

  Autor          : Oscar Ospino P.
  Fecha          : 20-09-2016

  Parametros         Descripcion
  ============   ===================
  inuactividad   Identificador de la Actividad
  inuestadoorden Identificador del estado de la Orden

  Historia de Modificaciones
  Fecha          Autor                     Modificacion
  ==========     ==================        =================================

  ******************************************************************/

  --Flags Accion Restringida de la Actividad
  sbresultado Varchar2(1) := 'N';

  --Estados Ordenes

  cnuestadoregistrada   Number := 0;
  cnuestadoasignada     Number := 5;
  cnuestadoen_ejecucion Number := 6;
  cnuestadoejecutada    Number := 7;
  cnuestadolegalizada   Number := 8;

Begin
  ut_trace.trace('Inicia Ldc_FsbValidaActiv_Bloq', 10);

  Begin

    Select Case
           --Generada
             When inuestadoorden = cnuestadoregistrada Then
              nvl(tb.bloq_gen, 'N')
           --Asignada
             When inuestadoorden = cnuestadoasignada Then
              nvl(tb.bloq_asig, 'N')
           --En Ejecucion
             When inuestadoorden = cnuestadoen_ejecucion Then
              nvl(tb.bloq_ejec, 'N')
           --Ejecutada
             When inuestadoorden = cnuestadoejecutada Then
              nvl(tb.bloq_ejec, 'N')
           --Legalizada
             When inuestadoorden = cnuestadolegalizada Then
              nvl(tb.bloq_leg, 'N')
             Else
              'N'
           End
      Into sbresultado
      From open.ldc_osf_conf_bloqact tb
     Where tb.activity_id = inuactividad;

  Exception
    When Others Then
      sbresultado := 'N';
  End;

  ut_trace.trace('Fin Ldc_FsbValidaActiv_Bloq ', 10);

  Return(sbresultado);

Exception

  When Others Then
    --osberror := Sqlerrm;
    Return(sbresultado);

End ldc_fsbvalidaactiv_bloq;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBVALIDAACTIV_BLOQ', 'ADM_PERSON');
END;
/
