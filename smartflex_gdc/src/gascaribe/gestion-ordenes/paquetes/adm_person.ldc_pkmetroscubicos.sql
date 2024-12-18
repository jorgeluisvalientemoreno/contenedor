create or replace PACKAGE adm_person.LDC_PKMETROSCUBICOS is
  /*****************************************************************
  Unidad         : LDC_PKMETROSCUBICOS
  Descripcion    : Paquete para manejo de generacion y legalizacion de ordenes adicionales
  Autor          : Jorge Valiente
  Fecha          : 04/08/2017
  CASO           : 316

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  23/07/2024    PAcosta                 OSF-2952: Cambio de esquema ADM_PERSON
  ******************************************************************/

  TYPE tyRefCursor IS REF CURSOR;

  procedure proPROMETCUB(v_periodo     number,
                         v_anno        number,
                         v_mes         number,
                         v_contrato    number,
                         v_producto    number,
                         v_observacion varchar2,
                         v_accion      number);

  procedure proPROMETCUBAccion(v_periodo     number,
                               v_anno        number,
                               v_mes         number,
                               v_contrato    number,
                               v_producto    number,
                               v_observacion varchar2,
                               v_accion      number);

  FUNCTION FRFESTMETCUBACCION(InuTipoBusqueda number) RETURN tyRefCursor;

  PROCEDURE PRESTMETCUBACCION(v_periodo       number,
                              v_anno          number,
                              v_mes           number,
                              v_contrato      number,
                              v_producto      number,
                              v_observacion   varchar2,
                              v_accion        number,
                              InuTipoBusqueda number,
                              v_ciclo         number,
                              v_proceso      number);

  PROCEDURE PRPERIODOACTIVO(v_ciclo number);

End LDC_PKMETROSCUBICOS;
/
create or replace PACKAGE BODY adm_person.LDC_PKMETROSCUBICOS AS

  /*****************************************************************
  Unidad         : LDC_PKMETROSCUBICOS
  Descripcion    : Paquete para manejo de generacion y legalizacion de ordenes adicionales
  Autor          : Jorge Valiente
  Fecha          : 04/08/2017
  CASO           : 316

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  /*****************************************************************.
  Unidad         : proPROMETCUB
  Descripcion    : Serivicio para actualizar informacion del producto con los MT3
                   del concepto consumo inconsistente cuando accion es NULL

  Autor          : HORBATH
  Fecha          : 21/09/2020

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure proPROMETCUB(v_periodo     number,
                         v_anno        number,
                         v_mes         number,
                         v_contrato    number,
                         v_producto    number,
                         v_observacion varchar2,
                         v_accion      number) is
    --PRAGMA AUTONOMOUS_TRANSACTION;

    cursor cuDATA is
      select user USUARIO, sys_context('USERENV', 'TERMINAL') TERMINAL
        from dual;

    sbUsuario  varchar2(30);
    sbTerminal varchar2(200);

  begin

    OPEN cuDATA;
    FETCH cuDATA
      INTO sbUsuario, sbTerminal;
    CLOSE cuDATA;

    update ldc_prometcub lp
       set lp.observacion = v_observacion,
           lp.accion      = v_accion,
           lp.usuario     = sbUsuario,
           lp.maquina     = sbTerminal,
           lp.fecultactu  = sysdate
     where lp.periodo = v_periodo
       and lp.anno = v_anno
       and lp.mes = v_mes
       and lp.contrato = v_contrato
       and lp.producto = v_producto
       and lp.accion is null;

    commit;

  exception
    when others then
      null;
  end proPROMETCUB;

  /*****************************************************************.
  Unidad         : proPROMETCUBAccion
  Descripcion    : Serivicio para actualizar informacion del producto con los MT3
                   del concepto consumo inconsistente cuando accion es igual a 1

  Autor          : HORBATH
  Fecha          : 21/09/2020

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  procedure proPROMETCUBAccion(v_periodo     number,
                               v_anno        number,
                               v_mes         number,
                               v_contrato    number,
                               v_producto    number,
                               v_observacion varchar2,
                               v_accion      number) is
    --PRAGMA AUTONOMOUS_TRANSACTION;

    cursor cuDATA is
      select user USUARIO, sys_context('USERENV', 'TERMINAL') TERMINAL
        from dual;

    sbUsuario  varchar2(30);
    sbTerminal varchar2(200);

  begin

    OPEN cuDATA;
    FETCH cuDATA
      INTO sbUsuario, sbTerminal;
    CLOSE cuDATA;

    update ldc_prometcub lp
       set lp.observacion = v_observacion,
           lp.accion      = v_accion,
           lp.usuario     = sbUsuario,
           lp.maquina     = sbTerminal,
           lp.fecultactu  = sysdate
     where lp.periodo = v_periodo
       and lp.anno = v_anno
       and lp.mes = v_mes
       and lp.contrato = v_contrato
       and lp.producto = v_producto
       and lp.accion = 1;

    commit;

  exception
    when others then
      null;
  end proPROMETCUBAccion;

  /*****************************************************************.
  Unidad         : PRESTMETCUBPERIODO
  Descripcion    : Este Este servicio se encargara de validar si cada
                   periodo de cada producto que fue procesado cumple
                   con la condiciones de cambiar el estado del periodo

  Autor          : HORBATH
  Fecha          : 22/09/2020

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRESTMETCUBPERIODO(v_periodo number) is
    --PRAGMA AUTONOMOUS_TRANSACTION;
    nuCotrol number := 0;

    cursor CUCONTROLPERIODO is
      select count(t.periodo)
        from LDC_PROMETCUB t
       where t.periodo = v_periodo
         and (t.accion is null or t.accion = 1);

    nuCantidadPeriodo number;

    procedure proUpdCodperfact(nuPeriodo PROCEJEC.PREJCOPE%type,
                               Estado    LDC_CODPERFACT.ESTADPROCESS%type) is
      --PRAGMA AUTONOMOUS_TRANSACTION;

    begin

      update LDC_CODPERFACT
         set ESTADPROCESS = Estado
       where cod_perfact = nuPeriodo
         and TYPEPROCESS = 'FGCA';

      commit;

    exception
      when others then
        null;
    end;

    ----Porcesos
    -- Procedimiento para validar la inserccion o update de la tabla LDC_VALIDGENAUDPREVIAS

    procedure proUpdValidGenaudposterior(nuPeriodo PROCEJEC.PREJCOPE%type) is
      PRAGMA AUTONOMOUS_TRANSACTION;
      x number;
    begin

      select count(*)
        into x
        from LDC_VALIDGENAUDPREVIAS
       where COD_PEFACODI = nuPeriodo
         AND PROCESO = 'AUDPOST';

      if x = 0 then
        insert into LDC_VALIDGENAUDPREVIAS
          (cod_pefacodi, fecha_audprevia, PROCESO)
        VALUES
          (nuPeriodo, SYSDATE, 'AUDPOST');
      else
        update LDC_VALIDGENAUDPREVIAS
           set fecha_audprevia = sysdate
         where cod_pefacodi = nuperiodo
           AND PROCESO = 'AUDPOST';
      end if;

      commit;

    exception
      when others then
        null;
    end;
    ---------------------

  begin

    open CUCONTROLPERIODO;
    fetch CUCONTROLPERIODO
      into nuCantidadPeriodo;
    close CUCONTROLPERIODO;

    if nuCantidadPeriodo = 0 then
      -- se llama al procedimiento que actualiza el estado del periodo a terminado, para indicar que el proceso termino correctamente
      --proUpdCodperfact(v_periodo, 'T');
      proUpdValidGenaudposterior(v_periodo);
    end if;

  exception
    when others then
      null;
  end PRESTMETCUBPERIODO;

  /*****************************************************************.
  Unidad         : FRFESTMETCUBACCION
  Descripcion    : Este servicio retornara toda la DATA de la entidad LDC_PROMETCUB
                   donde el campo ACCION a¿¿n no sea definido (NULL)

  Autor          : HORBATH
  Fecha          : 21/09/2020

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  23/11/2020     horbath               ca 461 se agrega nuevo campo proceso
  ******************************************************************/
  FUNCTION FRFESTMETCUBACCION(InuTipoBusqueda number) RETURN tyRefCursor IS
    rfQuery tyRefCursor;

  BEGIN

    ut_trace.trace('Inicio LDC_PKMETROSCUBICOS.FRFESTMETCUBACCION', 10);

    if InuTipoBusqueda = 1 then
      open rfQuery for
        select periodo,
               anno,
               mes,
               (select c.ciclcodi || ' - ' || c.cicldesc
                  from ciclo c
                 where c.ciclcodi = ciclo
                   and rownum = 1) ciclo,
               contrato,
               producto,
               (select cp.conccodi || ' - ' || cp.concdesc
                  from concepto cp
                 where cp.conccodi = concepto
                   and rownum = 1) concepto,
               volliq,
               valliq,
               (select ct.catecodi || ' - ' || ct.catedesc
                  from categori ct
                 where ct.catecodi = categoria) categoria,
               (select sct.sucacodi || ' - ' || sct.sucadesc
                  from subcateg sct
                 where sct.sucacate = categoria
                   and sct.sucacodi = subcategoria) subcategoria,
               (select pps.product_status_id || ' - ' || pps.description
                  from PS_PRODUCT_STATUS pps
                 where pps.product_status_id = estado_producto
                   and rownum = 1) estado_producto,
               ciclo codigociclo,
               decode(proceso, 1, 'Aud. Posteriores', 2, 'Ambos', 'Metros Cubicos') proceso,
               nvl(proceso,0) procesoCod
          from ldc_prometcub lpmc
         where lpmc.accion is null;
    else
      open rfQuery for
        select periodo,
               anno,
               mes,
               (select c.ciclcodi || ' - ' || c.cicldesc
                  from ciclo c
                 where c.ciclcodi = ciclo
                   and rownum = 1) ciclo,
               contrato,
               producto,
               (select cp.conccodi || ' - ' || cp.concdesc
                  from concepto cp
                 where cp.conccodi = concepto
                   and rownum = 1) concepto,
               volliq,
               valliq,
               (select ct.catecodi || ' - ' || ct.catedesc
                  from categori ct
                 where ct.catecodi = categoria) categoria,
               (select sct.sucacodi || ' - ' || sct.sucadesc
                  from subcateg sct
                 where sct.sucacate = categoria
                   and sct.sucacodi = subcategoria) subcategoria,
               (select pps.product_status_id || ' - ' || pps.description
                  from PS_PRODUCT_STATUS pps
                 where pps.product_status_id = estado_producto
                   and rownum = 1) estado_producto,
               ciclo codigociclo,
               decode(proceso, 1, 'Aud. Posteriores', 2, 'Ambos', 'Metros Cubicos') proceso,
               nvl(proceso,0) procesoCod
          from ldc_prometcub lpmc
         where lpmc.accion = 1;
    end if;

    ut_trace.trace('Fin LDC_PKMETROSCUBICOS.FrfOrdenTrabajo', 10);

    return(rfQuery);
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END FRFESTMETCUBACCION;

  /*****************************************************************.
  Unidad         : PRESTMETCUBACCION
  Descripcion    : Este servicio se encargara de reversar los cargos a un
                   contrato o establecer que la DATA del cargo de consumo es v¿¿lida

  Autor          : HORBATH
  Fecha          : 22/09/2020

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  23/11/2020       horbath            CA 461 se agrega filtro de proceso
  10/08/2021        ljlb              ca 696 se ajusta porceso de reversion de cargos
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRESTMETCUBACCION(v_periodo       number,
                              v_anno          number,
                              v_mes           number,
                              v_contrato      number,
                              v_producto      number,
                              v_observacion   varchar2,
                              v_accion        number,
                              InuTipoBusqueda number,
                              v_ciclo         number,
                              v_proceso      number) IS

    NuPrograma ld_parameter.numeric_value%type := nvl(dald_parameter.fnuGetNumeric_Value('LDC_CARGPROG',
                                                                                         null),
                                                      0);

    EX_ERROR exception;
    onuerrorcode    number;
    osberrormessage varchar2(4000);

    nuCotrol number := 0;



    cursor cuCATMETCUB is
      select t.*, t.rowid from LDC_CATMETCUB t;

    rfcuCATMETCUB cuCATMETCUB%rowtype;

    cursor cucargosconsumo(InuPeriodo   number,
                           InuCiclo     number,
                           Inuanno      number,
                           Inumes       number,
                           Inucategoria number,
                           InuMT3       number,
                           InuValorMT3  number,
                           InuContrato  number) is
      select pf.pefaano           ano,
             pf.pefames           mes,
             pf.pefacicl          Ciclo,
             ss.sesususc          Contrato,
             ss.sesunuse          Producto,
             c.cargunid           volumen,
             c.CARGVALO           Valor,
             ss.sesucate          Categoria,
             ss.sesusuca          Subcategoria,
             pr.product_status_id EstadoProducto,
             c.cargconc           concepto
        from open.cargos            c,
             open.SERVSUSC          ss,
             open.SUSCRIPC          su,
             open.pr_product        pr,
             open.SERVICIO          se,
             open.CONCEPTO          CO,
             open.PERIFACT          pf,
             open.PS_PRODUCT_STATUS e
       where pr.product_status_id = e.product_status_id
         and ss.sesunuse = pr.product_id
         and c.cargnuse = ss.sesunuse
         and ss.SESUSUSC = InuContrato
         and ss.SESUSUSC = su.susccodi
         and pr.PRODUCT_TYPE_ID = se.servcodi
         and c.CARGCONC = CO.CONCCODI
         and c.CARGPEFA = pf.pefacodi
         and ss.sesucate = Inucategoria
         and pf.pefacodi = InuPeriodo
         and pf.pefacicl = InuCiclo
         and pf.pefaano = Inuanno
         and pf.pefames = Inumes
         and c.CARGCUCO = -1
		 AND c.cargcaca = 15
         and (c.cargunid > InuMT3 or c.cargvalo > InuValorMT3)
         and c.cargconc =
             nvl(dald_parameter.fnuGetNumeric_Value('LDC_CONMETCUB', null),
                 0);

    rfcucargosconsumo cucargosconsumo%rowtype;

    --INICIA CA 461
      onuValida NUMBER;
	    --variables de programcion
    onuScheduleProcessAux Ge_process_schedule.process_schedule_id%type;
    nuScheduleProcessAux Ge_process_schedule.process_schedule_id%type;
    inuExecutable     Sa_executable.executable_id%type := 5258;
    isbParameters     Ge_process_schedule.parameters_%type;

    isbWhat           Ge_process_schedule.what%type;
    isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';
    idtNextDate       Ge_process_schedule.Start_Date_%type ;

	CURSOR cuInfoPeriodo IS
    SELECT pefacodi periodo, PEFAANO, PEFAMES, PEFACICL, PEFADESC
    FROM PERIFACT
    WHERE PEFACODI = v_periodo;

	regperiodo cuInfoPeriodo%rowtype;

	CURSOR cuGetNombre IS
	SELECT SUBSCRIBER_NAME||' '|| SUBS_LAST_NAME
		FROM GE_SUBSCRIBER, SUSCRIPC
	   WHERE SUBSCRIBER_ID = SUSCCLIE
		 AND SUSCCODI = v_contrato;

	sbNombre VARCHAR2(4000);
    --FIN CA 461
    ----
    procedure proPROMETCUBLDCEMC(v_periodo         number,
                                 v_anno            number,
                                 v_mes             number,
                                 v_ciclo           number,
                                 v_contrato        number,
                                 v_producto        number,
                                 v_concepto        number,
                                 v_volliq          number,
                                 v_valliq          number,
                                 v_categoria       number,
                                 v_subcategoria    number,
                                 v_estado_producto number) is

    begin

      insert into ldc_prometcub
        (periodo,
         anno,
         mes,
         ciclo,
         contrato,
         producto,
         concepto,
         volliq,
         valliq,
         categoria,
         subcategoria,
         estado_producto)
      values
        (v_periodo,
         v_anno,
         v_mes,
         v_ciclo,
         v_contrato,
         v_producto,
         v_concepto,
         v_volliq,
         v_valliq,
         v_categoria,
         v_subcategoria,
         v_estado_producto);

      commit;

    exception
      when others then
        null;
    end;

     procedure proPROMETCUBLDCEMCAUD(v_periodo         number,
                                     v_anno            number,
                                     v_mes             number,
                                     v_ciclo           number,
                                     v_contrato        number,
                                     v_producto        number,
                                     v_concepto        number,
                                     v_volliq          number,
                                     v_valliq          number,
                                     v_categoria       number,
                                     v_subcategoria    number,
                                     v_estado_producto number) is

      CURSOR cugetValidRegistro(inuProdu NUMBER) IS
        SELECT 'X'
        FROM ldc_prometcub
        WHERE PERIODO = v_periodo
          AND ANNO = v_anno
          AND MES =  v_mes
          AND PRODUCTO = inuProdu;

        sbExiste VARCHAR2(1);

    begin

      --se valida si existe proceso
         OPEN cugetValidRegistro(v_producto);
         FETCH cugetValidRegistro INTO sbExiste;
         IF cugetValidRegistro%NOTFOUND THEN
              insert into ldc_prometcub
                (periodo,
                 anno,
                 mes,
                 ciclo,
                 contrato,
                 producto,
                 concepto,
                 volliq,
                 valliq,
                 categoria,
                 subcategoria,
                 estado_producto)
              values
                (v_periodo,
                 v_anno,
                 v_mes,
                 v_ciclo,
                 v_contrato,
                 v_producto,
                 v_concepto,
                 v_volliq,
                 v_valliq,
                 v_categoria,
                 v_subcategoria,
                 v_estado_producto);
          ELSE
            UPDATE ldc_prometcub SET PROCESO = 2
            WHERE PERIODO = v_periodo
                AND ANNO = v_anno
                AND MES =  v_mes
                AND PRODUCTO = v_producto;
          END IF;
          CLOSE cugetValidRegistro;

      commit;

    exception
      when others then
        null;
    end proPROMETCUBLDCEMCAUD;

  BEGIN

    ut_trace.trace('Inicio LDC_PKMETROSCUBICOS.PRESTMETCUBACCION', 10);

    if InuTipoBusqueda = 1 then

      proPROMETCUB(v_periodo,
                   v_anno,
                   v_mes,
                   v_contrato,
                   v_producto,
                   v_observacion,
                   v_accion);

      --Accion para reersar so cargos a la -1 de un contrato
      if v_accion = 1 then

        begin

		   idtNextDate := SYSDATE + 0.001;

		   OPEN cuInfoPeriodo;
		   FETCH cuInfoPeriodo INTO  regperiodo;
		   CLOSE cuInfoPeriodo;

		   OPEN cuGetNombre;
		   FETCH cuGetNombre INTO sbNOmbre;
		   CLOSE cuGetNombre;

       --select max(process_schedule_id)+1 into onuScheduleProcessAux
      -- from Ge_process_schedule;
		   nuScheduleProcessAux :=   PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('seq_ge_process_schedule');

		   --Parametros
		   isbParameters := 'SUSCCODI='||v_contrato||'|BIINCAUS='||sbNOmbre||'|PEFACODI='||regPeriodo.periodo||'|PEFADESC='||regPeriodo.PEFADESC||'|PEFACICL='||regPeriodo.pefacicl||'|PEFAANO='||regPeriodo.PEFAANO||'|PEFAMES='||regPeriodo.PEFAMES||'|';
		   ut_trace.trace('isbParameters ['||isbParameters||'] onuScheduleProcessAux '||nuScheduleProcessAux, 10);
		   --Bloque anonimo con el que se fija la frecuencia de ejecucion del job
		   isbWhat := 'BEGIN
						SetSystemEnviroment;
						Errors.Initialize;
						FBCC( '||nuScheduleProcessAux||' );
						if( DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
						  GE_BOSchedule.InactiveSchedule( '||nuScheduleProcessAux||' );
						end if;
					  EXCEPTION
						when OTHERS then
						  Errors.SetError;
						  if( DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
							GE_BOSchedule.DropSchedule( '||nuScheduleProcessAux||' );
						  end if;
					  END;';
		 ut_trace.trace('isbWhat ['||isbWhat||']', 10);
		  --  DBMS_OUTPUT.PUT_LINE('isbWhat ['||isbWhat||']');
		 GE_BOSchedule.PrepareSchedule( INUEXECUTABLE => inuExecutable,
										ISBPARAMETERS  => isbParameters,
										ISBWHAT  => isbWhat,
										INUSCHEDULEPROCESS => nuScheduleProcessAux ,
										ONUSCHEDULEPROCESS => onuScheduleProcessAux
									   );
		  ut_trace.trace(' onuScheduleProcessAux '||onuScheduleProcessAux, 10);
			--se crea programacion
		  GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);

         /* --Elimina todos los cargos del contrato con el cunsmo y/o valor inconsistententes.
          delete cargos c
           where c.cargcuco = -1
             and c.cargnuse in
                 (select s.sesunuse
                    from servsusc s
                   where s.sesususc = v_contrato);

          --Permite al servicio indicarele al sistem OSF que se puede volver a generar el concepto de consumo
          update conssesu
             set cossflli = 'N'
           where cosssesu = v_producto
             and cosspefa = v_periodo
             and cossmecc = 4;

          --Le indica al sismta que puede cvolver a genera cargos a este contrato
          update suscripc set suscnupr = 0 where susccodi = v_contrato;

		  update ldc_prometcub
			set volliq = 0,
				valliq = 0
		  WHERE PERIODO = v_periodo
                AND ANNO = v_anno
                AND MES =  v_mes
                AND PRODUCTO = v_producto;

          --INICIO CA 696
          DELETE FROM RANGLIQU WHERE RALISESU = v_producto  AND RALIPEFA = v_periodo;
          --FIN CA 696*/




          commit;
        exception
          when others then
            rollback;
            GI_BOERRORS.SETERRORCODEARGUMENT(Ld_Boconstans.cnuGeneric_Error,
                                             'Error en la reversion de CARGOS del contrato ' ||
                                             v_contrato);
        end;

      end if;

    else
      if InuTipoBusqueda = 2 then
        --Llamar al servicio de OPEN para generar cargos por contrato
        pkfgca.liqbycontract(inucontrato     => v_contrato,
                             idtfechgene     => sysdate,
                             idtfechcont     => sysdate,
                             inuprograma     => NuPrograma,
                             onuerrorcode    => onuerrorcode,
                             osberrormessage => osberrormessage);

        if onuerrorcode <> 0 then
          raise ex_error;
        else
          proPROMETCUBAccion(v_periodo,
                             v_anno,
                             v_mes,
                             v_contrato,
                             v_producto,
                             v_observacion,
                             v_accion);

            --INICIO CA 461
            IF  NOT FBLAPLICAENTREGAXCASO('0000461') THEN
               ---Validar si el nuevo cargo de conumo cumple con las condiciones de configuracion
                  for rfcuCATMETCUB in cuCATMETCUB loop
                    for rfcucargosconsumo in cucargosconsumo(v_periodo,
                                                             v_ciclo,
                                                             v_anno,
                                                             v_mes,
                                                             rfcuCATMETCUB.Categoria,
                                                             rfcuCATMETCUB.Metroscubicos,
                                                             rfcuCATMETCUB.Valormetrocubico,
                                                             v_contrato) loop

                      /*dbms_output.put_line('Contrato[' ||
                      rfcucargosconsumo.contrato || '] - ' ||
                      'MT3[' || rfcucargosconsumo.volumen ||
                      ' - ' || rfcuCATMETCUB.Metroscubicos ||
                      '] - ' || 'ValorMT3[' ||
                      rfcucargosconsumo.valor || ' - ' ||
                      rfcuCATMETCUB.Valormetrocubico || ']');*/

                      proPROMETCUBLDCEMC(v_periodo,
                                         v_anno,
                                         v_mes,
                                         v_ciclo,
                                         rfcucargosconsumo.contrato,
                                         rfcucargosconsumo.producto,
                                         rfcucargosconsumo.concepto,
                                         rfcucargosconsumo.volumen,
                                         rfcucargosconsumo.valor,
                                         rfcucargosconsumo.categoria,
                                         rfcucargosconsumo.subcategoria,
                                         rfcucargosconsumo.estadoproducto);
                    end loop;
                  end loop;
            ELSE
              IF v_proceso <> 1 THEN
                  ---Validar si el nuevo cargo de conumo cumple con las condiciones de configuracion
                  for rfcuCATMETCUB in cuCATMETCUB loop
                    for rfcucargosconsumo in cucargosconsumo(v_periodo,
                                                             v_ciclo,
                                                             v_anno,
                                                             v_mes,
                                                             rfcuCATMETCUB.Categoria,
                                                             rfcuCATMETCUB.Metroscubicos,
                                                             rfcuCATMETCUB.Valormetrocubico,
                                                             v_contrato) loop

                      /*dbms_output.put_line('Contrato[' ||
                      rfcucargosconsumo.contrato || '] - ' ||
                      'MT3[' || rfcucargosconsumo.volumen ||
                      ' - ' || rfcuCATMETCUB.Metroscubicos ||
                      '] - ' || 'ValorMT3[' ||
                      rfcucargosconsumo.valor || ' - ' ||
                      rfcuCATMETCUB.Valormetrocubico || ']');*/

                      proPROMETCUBLDCEMC(v_periodo,
                                         v_anno,
                                         v_mes,
                                         v_ciclo,
                                         rfcucargosconsumo.contrato,
                                         rfcucargosconsumo.producto,
                                         rfcucargosconsumo.concepto,
                                         rfcucargosconsumo.volumen,
                                         rfcucargosconsumo.valor,
                                         rfcucargosconsumo.categoria,
                                         rfcucargosconsumo.subcategoria,
                                         rfcucargosconsumo.estadoproducto);
                    end loop;
                  end loop;
            END IF;
            --se llama proceso de auditoria posteriores
            IF v_proceso <> 0 THEN
                 LDC_PKFAPC.PRGENEAUDPOSTXPROD( v_anno,
                                                v_mes,
												v_ciclo,
                                                v_producto,
                                                onuValida);

                IF onuValida = 1 THEN
                  proPROMETCUBLDCEMCAUD(v_periodo,
                                         v_anno,
                                         v_mes,
                                         v_ciclo,
                                         v_contrato,
                                         v_producto,
                                        NULL,
                                         0,
                                         0,
                                         DAPR_PRODUCT.FNUGETCATEGORY_ID(v_producto, NULL),
                                         DAPR_PRODUCT.FNUGETSUBCATEGORY_ID(v_producto, NULL),
                                         DAPR_PRODUCT.FNUGETPRODUCT_STATUS_ID(v_producto, NULL));
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------
          END IF;

        end if;

      end if;
    end if;

    --Validar estado de cada periodo
    PRESTMETCUBPERIODO(v_periodo);

    ut_trace.trace('Fin LDC_PKMETROSCUBICOS.PRESTMETCUBACCION', 10);

  EXCEPTION
    when EX_ERROR then
      GI_BOERRORS.SETERRORCODEARGUMENT(Ld_Boconstans.cnuGeneric_Error,
                                       osberrormessage);
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PRESTMETCUBACCION;

  /*****************************************************************.
  Unidad         : PRPERIODOACTIVO
  Descripcion    : Este servicio se encargara de validar si el ciclo tiene periodo activo
                   y si la fecha del ssitema esta dentro de la fecna inicial y fecha final
                   del periodo activo.

  Autor          : HORBATH
  Fecha          : 30/11/2020

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRPERIODOACTIVO(v_ciclo number) IS

    EX_ERROR exception;
    onuerrorcode    number;
    osberrormessage varchar2(4000);

    nuCotrol number := 0;

    cursor cuperifact is
      select (select count(pf.pefacodi)
                from perifact pf
               where pf.pefaactu = 'S'
                 and pf.pefacicl = v_ciclo) activo,
             (select count(pf.pefacodi)
                from perifact pf
               where pf.pefaactu = 'S'
                 and pf.pefacicl = v_ciclo
                 and trunc(sysdate) between pf.pefafimo and pf.pefaffmo) fechasistema
        from dual;

    nuactivo number;
    nufechasistema number;

  BEGIN

    ut_trace.trace('Inicio LDC_PKMETROSCUBICOS.PRPERIODOACTIVO', 10);

      open cuperifact;
      fetch cuperifact into nuactivo,nufechasistema;
      close cuperifact;

      if nuactivo = 0 then
        osberrormessage := 'El ciclo [' || v_ciclo || '] no tiene periodo activo.';
        raise ex_error;
      end if;

      if nufechasistema = 0 then
        osberrormessage := 'La fecha del sistema no esta dentro de la fecha inicial y final del periodo activo del ciclo [' || v_ciclo || '].';
        raise ex_error;
      end if;

    ut_trace.trace('Fin LDC_PKMETROSCUBICOS.PRPERIODOACTIVO', 10);

  EXCEPTION
    when EX_ERROR then
      GI_BOERRORS.SETERRORCODEARGUMENT(Ld_Boconstans.cnuGeneric_Error,
                                       osberrormessage);
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END PRPERIODOACTIVO;

END LDC_PKMETROSCUBICOS;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKMETROSCUBICOS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKMETROSCUBICOS', 'ADM_PERSON');
END;
/