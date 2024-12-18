CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBACTIV_BLOQ_OSF" (inuorden     In open.or_order.order_id%Type,
                                                 inuevoestado In Number )
  Return Varchar2 Is
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe S.A.

  Unidad         : Ldc_FsbActiv_Bloq_OSF
  Descripcion    : Valida si se permite generar, asignar, ejecutar o legalizar ordenes por las Formas OSF
                   segun las actividades configuradas en la tabla LDC_OR_CONF_BLOQ_ACT.
                   Devuelve S >> La orden tiene por lo menos una actividad Restringida
                            N >> Sin ACtividades restringidas
                   Configurador Restricciones: Forma ORCREST

  Autor          : Oscar Ospino P.
  Fecha          : 20-09-2016

  Parametros         Descripcion
  ============   ===================
  inuorden       Identificador de la Orden
  inuevoestado    Nuevo estado que tomara la orden

  Historia de Modificaciones
  Fecha          Autor                     Modificacion
  ==========     ==================        =================================
  25/04/2018	dsaltarin				200-1902. Se modifica para que solo valide actividaes registradas en or_order_items
										para evitar el error de validacion cuando se ha realizado cambio de tipo de trabajo.

  ******************************************************************/

  --Aplicacion que Ejecuta
  sbapp Varchar2(100) := ut_session.getmodule;
  --Flag Forma OSF
  nues_osf Number := 0;
  --Flags Accion Restringida de la Actividad
  sbacc_restr Varchar2(1) := 'N';
  --Actividad Restringida en la Orden
  sbactivrestringida open.or_order_activity.activity_id%Type;
  --Formas donde estan restringidas las actividades
  sbformasrestringidas Varchar2(4000) := open.dald_parameter.fsbgetvalue_chain('LDC_EXEBLOQLEGA',
                                                                               Null);
  --Estados Ordenes
  cnuestadoregistrada   Number := 0;
  cnuestadoasignada     Number := 5;
  cnuestadoen_ejecucion Number := 6;
  cnuestadoejecutada    Number := 7;
  cnuestadolegalizada   Number := 8;
  --Mensage Log
  sblog Varchar2(4000);

  --Cursor Actividades de la Orden
  --200-1902-------
  Cursor cuactiv Is
    Select Distinct oa.activity_id From open.or_order_activity oa Where oa.order_id = inuorden
	and exists(select null from open.or_order_items oi where oa.order_id=oi.order_id and oi.items_id=oa.activity_id
                    and oi.legal_item_amount>=0);
  --200-1902-------
Begin
  ut_trace.trace('Inicia Ldc_FsbActiv_Bloq_OSF', 10);
  Begin

    --Pruebas
    --sbapp := 'ORAMA';

    --Se valida si el proceso se esta llamando desde OSF
    --Select Count(*) Into nues_osf From sa_executable s Where s.name = sbapp;

    --Se valida si el proceso se esta llamando desde las formas OSF parametrizadas.
    If instr(sbformasrestringidas, sbapp) > 0 Then
      nues_osf := 1;
    End If;

    --log
    sblog := sbformasrestringidas || chr(10) || 'Aplicacion: ' || sbapp || ' | Es OSF: ' ||
             nues_osf /*|| '  [ 1 >> SI ] [ 0 >> NO ]'*/
             || chr(10);

  Exception
    When Others Then
      nues_osf := 0;
  End;

  --Log
  sblog := sblog || 'Orden: ' || inuorden || ' | Nuevo Estado: ' || inuevoestado ||
           ' | Actividades ';

  If nues_osf = 1 Then
    --Se validan las restricciones solo si la Accion es ejecutada en una Forma OSF

    For rcordact In cuactiv Loop
      --Por cada actividad de la orden, la accion restringida segun el nuevo estado que tendra la orden
      --(Triggers)

      Begin

        --Log
        sblog := sblog || '-' || rcordact.activity_id || '-';

        Select Case
               --Generada
                 When inuevoestado = cnuestadoregistrada Then
                 --decode(tb.bloq_gen, 'S', 1, 'N', 0, 0)
                  nvl(tb.bloq_gen, 'N')
               --Asignada
                 When inuevoestado = cnuestadoasignada Then
                 --decode(tb.bloq_asig, 'S', 1, 'N', 0, 0)
                  nvl(tb.bloq_asig, 'N')
               --En Ejecucion
                 When inuevoestado = cnuestadoen_ejecucion Then
                 --decode(tb.bloq_ejec, 'S', 1, 'N', 0, 0)
                  nvl(tb.bloq_ejec, 'N')
               --Ejecutada
                 When inuevoestado = cnuestadoejecutada Then
                 --decode(tb.bloq_ejec, 'S', 1, 'N', 0, 0)
                  nvl(tb.bloq_ejec, 'N')
               --Legalizada
                 When inuevoestado = cnuestadolegalizada Then
                 --decode(tb.bloq_leg, 'S', 1, 'N', 0, 0)
                  nvl(tb.bloq_leg, 'N')
                 Else
                  'N'
               End
          Into sbacc_restr
          From open.ldc_osf_conf_bloqact tb
         Where tb.activity_id = rcordact.activity_id;

        --Almaceno la actividad que tiene la restriccion
        sbactivrestringida := rcordact.activity_id;

        --Se sale del ciclo cuando haya por lo menos una actividad restringida
        --para la orden
        Exit When sbacc_restr = 'S';

      Exception
        When Others Then
          sbacc_restr := 'N';
      End;

    End Loop;

  End If;

  --Log
  If sbacc_restr = 'S' Then
    sblog := sblog || ' | Actividades Restringidas: ' || sbactivrestringida || chr(10);
  Else
    sblog := sblog || ' | Actividades Restringidas: ' || ' Ninguna' || chr(10);
  End If;

  --Mostrar Log
  dbms_output.put_line(sblog);
  ut_trace.trace(sblog, 10);

  ut_trace.trace('Fin Ldc_FsbActiv_Bloq_OSF ', 10);

  Return(sbacc_restr);

Exception

  When Others Then
    --osberror := Sqlerrm;
    Return(sbacc_restr);

End ldc_fsbactiv_bloq_osf;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBACTIV_BLOQ_OSF', 'ADM_PERSON');
END;
/
