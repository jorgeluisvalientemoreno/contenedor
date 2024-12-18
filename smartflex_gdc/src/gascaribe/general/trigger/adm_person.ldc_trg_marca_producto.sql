CREATE OR REPLACE TRIGGER adm_person.LDC_TRG_MARCA_PRODUCTO

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_TRG_MARCA_PRODUCTO
  Descripcion    : Disparador que elimina el registro asociado al producto cada vez que se actualiza la tabla
                   ldc_plazos_cert
  Autor          : Sayra Ocoro
  Fecha          : 14/05/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  16/01/2018        Sebastian Tapias  Caso 200-1518 se comenta la logica que corresponde a GDC
  12/07/2017        Jorge Valiente    Caso 200-1320: Se cambia la logica del CASO 200-529 y se validara dentro de cada
                                                     logica asignada a cada gasera.
                                                     Se adciono nueva logica silicitada por el funcionario de GDC para que
                                                     ademas de la logica NO permitir anular y atender solcitude.
                                                     Se debe validar unidad opertaiva asiganda a la orden
  20/12/2016        Jorge Valiente    Caso 200-529: Se tomara el TRIGGER fuente de EFIGAS y a este
                                                    se le unificara el codigo existente en el fuente de GDC.
                                                    Se modificaran los cursores para identificar que todas las ordenes
                                                    en estado 0 o 5. Anulan la solicitud.
                                                    En caso de haber almenos una orden en estado diferente a 0 o 5 la
                                                    solicitud sera atendida
  26-05-2015       Sergio Gomez      Se quitan las validaciones para que se cancelen las ordenes cuando se legalize
                                      una orden certificacion, se modifica la condicion y se agregan cursores
                                      para que la validacion cuando se ejecute el trigger sea efectiva. SAO 317066
  18-06-2014        Sayra Ocoro       Se incluye la anulacion de solicitudes de  Notificacion de Suspension
                                      por ausencia de certificado y el cierre de solicitud
  18-10-2024        Lubin Pineda    OSF-3383: Se migra a ADM_PERSON
  ******************************************************************/
  AFTER update or insert on ldc_plazos_cert
  for each row

declare
  PRAGMA AUTONOMOUS_TRANSACTION;

  --Cursor para validar gasera
  cursor cusistema is
    select s.sistnitc from sistema s where rownum = 1;

  rfcusistema cusistema%rowtype;
  --

  nuPackageId        mo_packages.package_id%type;
  nuProductStatus    pr_product.product_status_id%type;
  nuProdSuspensionId pr_prod_suspension.prod_suspension_id%type;
  nuSuspensionType   pr_prod_suspension.suspension_type_id%type;
  nuNotas            number;
  nuPlanId           wf_instance.instance_id%type;

  --Variables originales desarrollo SAO 317066
  --nuYearCerti variable numerica que guarda el ultimo a?o que un producto se va a certificar
  nuYearCerti number;

  --daFechaeCerti variable la siguiente fecha en la cual se debera certificar
  daFechaeCerti date;

  --CURSOR cufechaCertifi Cursor que trae la proxima fecha de certificacion de un producto
  CURSOR cufechaCertifi(Idproducto in number) IS
    SELECT *
      FROM (SELECT unique pr.estimated_end_date
              FROM pr_certificate pr
             where product_id = Idproducto
             ORDER BY pr.estimated_end_date desc)
     where ROWNUM = 1;

  onuErrorCode    number(18);
  osbErrorMessage varchar2(2000);
  cnuCommentType constant number := 83;

  --El cursor cuOrdAnula busca las ordenes que se necesitan anular por medio de la solicitud
  CURSOR cuOrdAnula(packageId in number) IS
    select oa.*, ord.order_status_id estado_inicial
      from or_order_activity oa, or_order ord
     where oa.package_id = packageId
          --and oa.task_type_id in (10450, 12457, 10449)
       and oa.order_id = ord.order_id
       and ord.order_status_id in
           (dald_parameter.fnuGetNumeric_Value('COD_STATUS_REG'), --0 Orden registrada
            dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')); --5 Orden Asignada

  --cuSolAnula Buscar una solicitud que este registrada o anulada pero que las ordenes
  --de esa solicitud todavia esten asignadas o registradas para anularlas
  --Nota: se busca en estado anulada la solicitud porque en ocasiones viene en ese estado
  --y las ordenes todavia estan registradas.
  CURSOR cuSolAnula(productoId in number) IS
    select mp.package_id
      from mo_packages mp, mo_motive mo, or_order_activity oa, or_order ord
     where mo.product_id = productoId
       and mp.motive_status_id in
           (dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA',
                                               null), --32. ESTADO ANULADO DE LA SOLICITUD
            dald_parameter.fnuGetNumeric_Value('FNB_ESTADOSOL_REG', null)) -- 13. Estado registrado de una solicitud
       and mp.package_type_id in
           (dald_parameter.fnuGetNumeric_Value('LDC_SUSP_ADMIN_XML', null), --100156
            dald_parameter.fnuGetNumeric_Value('LDC_SUSP_ADMIN', null), --100013
            dald_parameter.fnuGetNumeric_Value('LDC_NOT_SUSP_CERTIFI', null)) --100246 Tipos de Solicitudes para anular
       and mp.package_id = mo.package_id
       and oa.package_id = mp.package_id
       and oa.task_type_id in
           (dald_parameter.fnuGetNumeric_Value('LDC_TT_NOTIF_SUSP', null), --10449 SUSPENSION NO CERTIFICADO
            dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_SUSP_REVI_RP',
                                               null), --10450 SUSPENSION X REVISION DE RP
            dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_ACOM_CERT_RP',
                                               null)) --12457 SUSPENSION NO CERTIFICADO --tipos de trabajo para anular
       and oa.order_id = ord.order_id
       and ord.order_status_id in
           (dald_parameter.fnuGetNumeric_Value('COD_STATUS_REG'), --0 Orden registrada
            dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')); --5 Orden Asignada
  --

  --Inicio CASO 200-529
  --Cursor para identificar solicitudes para ser anuladas
  cursor cusolicitudesanula is
    select distinct mp.package_id
      from mo_packages mp, mo_motive mo, or_order_activity oa, or_order ord
     where mo.product_id = :new.id_producto --productoId
       and mp.motive_status_id in (
                                   --dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), --32. ESTADO ANULADO DE LA SOLICITUD
                                   dald_parameter.fnuGetNumeric_Value('FNB_ESTADOSOL_REG')) -- 13. Estado registrado de una solicitud
       and mp.package_type_id IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_SOL_ANU_TRG_MAR_PRO',
                                                                                       NULL),

                                                      ',')))
       and mp.package_id = mo.package_id
       and oa.package_id = mp.package_id
          --and oa.task_type_id in
          --    (dald_parameter.fnuGetNumeric_Value('LDC_TT_NOTIF_SUSP'), --10449 SUSPENSION NO CERTIFICADO
          --     dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_SUSP_REVI_RP'), --10450 SUSPENSION X REVISION DE RP
          --     dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_ACOM_CERT_RP')) --12457 SUSPENSION NO CERTIFICADO --tipos de trabajo para anular
       and oa.order_id = ord.order_id
       and ord.order_status_id in
           (dald_parameter.fnuGetNumeric_Value('COD_STATUS_REG'), --0 Orden registrada
            dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')); --5 Orden Asignada

  rfcusolicitudesanula cusolicitudesanula%rowtype;

  --cursor para identificar las ordenes a anular del paquete de venta de servicio de ingenieria.
  cursor cuotanulasolicitud100101 is
    select distinct mp.package_id
      from mo_packages mp, mo_motive mo, or_order_activity oa, or_order ord
     where mo.product_id = :new.id_producto --productoId
       and mp.motive_status_id in
           (dald_parameter.fnuGetNumeric_Value('FNB_ESTADOSOL_REG')) -- 13. Estado registrado de una solicitud
       and mp.package_type_id = 100101
       and mp.package_id = mo.package_id
       and oa.package_id = mp.package_id
       and oa.task_type_id IN
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TIP_TRA_SOL_VEN_SER_ING',
                                                                                       NULL),

                                                      ',')))
       and oa.order_id = ord.order_id
       and ord.order_status_id in
           (dald_parameter.fnuGetNumeric_Value('COD_STATUS_REG'), --0 Orden registrada
            dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')); --5 Orden Asignada

  rfcuotanulasolicitud100101 cuotanulasolicitud100101%rowtype;

  SBNIT_EFIGAS ld_parameter.value_chain%type := nvl(dald_parameter.fsbGetValue_Chain('NIT_EFIGAS',
                                                                                     null),
                                                    '800202395-3');

  SBNIT_GDC ld_parameter.value_chain%type := nvl(dald_parameter.fsbGetValue_Chain('NIT_GDC',
                                                                                  null),
                                                 '890101691-2');

  --El cursor cuOrdAnula busca las ordenes que se necesitan anular por medio de la solicitud
  CURSOR cuCantOrd(packageId in number) IS
    select (select Count(oa.order_id)
              from or_order_activity oa, or_order ord
             where oa.package_id = packageId
                  --and oa.task_type_id in (10450, 12457, 10449)
               and oa.order_id = ord.order_id) CantidadOTTodos,
           (select Count(oa.order_id)
              from or_order_activity oa, or_order ord
             where oa.package_id = packageId
                  --and oa.task_type_id in (10450, 12457, 10449)
               and oa.order_id = ord.order_id
               and ord.order_status_id in
                   (dald_parameter.fnuGetNumeric_Value('COD_STATUS_REG'), --0 Orden registrada
                    dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT'))) CantidadOTEstado
      from dual; --5 Orden Asignada

  rfcuCantOrd cuCantOrd%rowtype;

  --Cursor para identificar la solicitud de la OT legalizada
  CURSOR cuSolOTLeg(NuOrden in number) IS
    select ooa.*
      from open.Or_Order_Activity ooa
     where ooa.order_id = NuOrden;

  rfcuSolOTLeg cuSolOTLeg%rowtype;

  nuOrderId     number;
  nuSolicitudId number;

  --Fin CASO 200-529

  --Inicio CASO 200-1320
  --Cursor para identificar solicitudes para ser anuladas con ordenes en estado 7 Ejecutada
  cursor cuordenesexcluidas(inupackage_id number) is
    select COUNT(ORD.ORDER_ID) CANTIDAD
      from mo_packages mp, mo_motive mo, or_order_activity oa, or_order ord
     where mo.package_id = inupackage_id
       and mp.package_id = mo.package_id
       and oa.package_id = mp.package_id
       and oa.order_id = ord.order_id
       and ord.order_status_id in
           (dald_parameter.fnuGetNumeric_Value('COD_ESTADO_OT_EJE')); --7 Orden Ejecutada

  frcuordenesexcluidas cuordenesexcluidas%rowtype;

  --Cursor para obtener datos para el cambio de estado de la orden
  cursor cudatosadcionales is
    select su.mask USER_ID, sys_context('USERENV', 'TERMINAL') TERMINAL
      from sa_user su
     where su.user_id in (SELECT gp.user_id
                            FROM ge_person gp
                           WHERE person_id = GE_BOPersonal.fnuGetPersonId
                             AND rownum = 1)
       AND rownum = 1;

  rfcudatosadcionales cudatosadcionales%rowtype;

  --Cursor identificar las solicitudes qeu seran excluidas del paramtro  COD_TIP_SOL_EXC_ANU y
  --minimo una de sus ordenes no este asignada a la unidad opertavi configurada en COD_UNI_OPE_EXC_SOL_ANU
  cursor cuexluirexiste(packageId in number) is
    select count(1) cantidad -- ooa.*
      from open.Or_Order_Activity ooa, or_order oo
     where ooa.package_id = packageId --9003916 --15409739
       and ooa.package_id in
           (select mp.package_id
              from open.mo_packages mp
             where mp.package_type_id in
                   (SELECT column_value
                      from table(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_TIP_SOL_EXC_ANU'),
                                                              ',')))
               and mp.motive_status_id = 13)
       and oo.order_id = ooa.order_id
       and oo.order_status_id =
           dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')
       and oo.operating_unit_id in
           (SELECT column_value
              from table(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_UNI_OPE_EXC_SOL_ANU'),
                                                      ',')));
  rfcuexluirexiste cuexluirexiste%rowtype;
  --Fin CASO 200-1320

begin
  ut_trace.trace('Inicio LDC_TRG_MARCA_PRODUCTO', 10);
  ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO :NEW.PLAZO_MAXIMO => ' ||
                 :NEW.PLAZO_MAXIMO,
                 10);
  ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO :OLD.PLAZO_MAXIMO  => ' ||
                 NVL(:OLD.PLAZO_MAXIMO, :NEW.PLAZO_MAXIMO-1),
                 10);

  --/*
  open cusistema;
  fetch cusistema
    into rfcusistema;
  close cusistema;
  --*/
  --condicion para validar si esta en EFIGAS
  If rfcusistema.sistnitc = SBNIT_EFIGAS Then
  --if fblAplicaEntrega('OSS_RP_JM_200_529_4') then

    dbms_output.put_line('Logica EFIGAS');

    --CASO 200-1320 cambiar la logica de validacion de plazo maximo como solicita N1 de EFIGAS
    --if :NEW.PLAZO_MAXIMO != :OLD.PLAZO_MAXIMO or :OLD.PLAZO_MAXIMO is null then
    dbms_output.put_line(':NEW.PLAZO_MAXIMO[' || :NEW.PLAZO_MAXIMO ||
                         '] > :OLD.PLAZO_MAXIMO[' || NVL(:OLD.PLAZO_MAXIMO, :NEW.PLAZO_MAXIMO-1) || ']');
    if :NEW.PLAZO_MAXIMO > NVL(:OLD.PLAZO_MAXIMO, :NEW.PLAZO_MAXIMO-1) then

      dbms_output.put_line('Logica EFIGAS - 1');

      --CASO 200-1320 el proceso DELETE pasa a estar antes de la validacion IF a colocarla despues como
      --Solicita N1 EFIGAS
      --borrar marca asociada al producto
      delete from ldc_marca_producto where id_producto = :new.ID_PRODUCTO;

      --borrar marca asociada al producto
      --delete from ldc_marca_producto where id_producto = :new.ID_PRODUCTO;
      ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO delete sobre ldc_marca_producto ejecutado',
                     10);
      --Obtener Estado del Producto
      nuProductStatus := dapr_product.fnugetproduct_status_id(:NEW.ID_PRODUCTO);
      ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO nuProductStatus  => ' ||
                     nuProductStatus,
                     10);
      --Validar si el producto esta suspendido
      dbms_output.put_line('Logica EFIGAS - 2');
      if nuProductStatus =
         DALD_parameter.fnuGetNumeric_Value('ID_PRODUCT_STATUS_SUSP') then
        dbms_output.put_line('Logica EFIGAS - 2.1');
        nuProdSuspensionId := to_number(ldc_boutilities.fsbgetvalorcampostabla('pr_prod_suspension',
                                                                               'PRODUCT_ID',
                                                                               'prod_suspension_id',
                                                                               :new.ID_PRODUCTO,
                                                                               'ACTIVE',
                                                                               'Y'));
        --Validar si existe una suspension activa
        if nuProdSuspensionId is not null and nuProdSuspensionId <> -1 then
          nuSuspensionType := dapr_prod_suspension.fnugetsuspension_type_id(nuProdSuspensionId);
          --Validar si la suspension esta relacionada con tipo de suspension " 101: Suspension por Inspeccion
          --102: Suspension por Reparacion
          --103: Suspension por Certificacion
          --104: Suspension por OIA
          if instr(DALD_PARAMETER.fsbGetValue_Chain('ID_RP_SUSPENSION_TYPE'),
                   to_char(nuSuspensionType)) > 0 then
            --Buscar tramite de Suspension Administrativa por XML 100156 -  100013
            nuPackageId := mo_bopackages.fnugetidpackage(:NEW.ID_PRODUCTO,
                                                         100156,
                                                         13);
            if nuPackageId is null then
              nuPackageId := mo_bopackages.fnugetidpackage(:NEW.ID_PRODUCTO,
                                                           100013,
                                                           13);
            end if;
            if nuPackageId is not null then
              --Se realiza la transicion de estados de la solicitud y el producto
              MO_BOANNULMENT.PACKAGEINTTRANSITION(nuPackageId,
                                                  GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
              -- se reversan los cargos generados
              nuNotas := FNUREQCHARGESCANCELL(nuPackageId);
              -- se anulan las ordenes
              or_boanullorder.anullactivities(nuPackageId, null, null);
              -- Se obtiene el plan de wf
              nuPlanId := wf_boinstance.fnugetplanid(nuPackageId, 17);
              -- anula el plan de wf
              mo_boannulment.annulwfplan(nuPlanId);
            end if;
          end if;
        end if;
      else
        dbms_output.put_line('Logica EFIGAS - 2.2');
        --Buscar tramite Notificacion por Ausencia de Certificado - 100246
        ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO Notificacion por Ausencia de Certificado',
                       10);
        nuPackageId := mo_bopackages.fnugetidpackage(:NEW.ID_PRODUCTO,
                                                     100246,
                                                     13);
        ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO nuPackageId  => ' ||
                       nuPackageId,
                       10);
        if nuPackageId is not null then
          dbms_output.put_line('Logica EFIGAS - 2.2.1');
          --Se realiza la transicion de estados de la solicitud y el producto
          MO_BOANNULMENT.PACKAGEINTTRANSITION(nuPackageId,
                                              GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
          -- se reversan los cargos generados
          nuNotas := FNUREQCHARGESCANCELL(nuPackageId);
          -- se anulan las ordenes
          or_boanullorder.anullactivities(nuPackageId, null, null);
          -- Se obtiene el plan de wf
          nuPlanId := wf_boinstance.fnugetplanid(nuPackageId, 17);
          ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => ' ||
                         nuPlanId,
                         10);
          -- anula el plan de wf
          mo_boannulment.annulwfplan(nuPlanId);
        end if; --if nuPackageId is not null then
      end if; --if nuProductStatus = DALD_parameter.fnuGetNumeric_Value('ID_PRODUCT_STATUS_SUSP') then
      commit;

      dbms_output.put_line('Logica EFIGAS - 3');
      dbms_output.put_line('Inicia proceso de anular o atender solicitud');
      ----Logica CASO 200-1320
      --Inicio CASO 200-1320
      --Inicio CASO 200-529 --modificacion de logica para el CASO 200-1320

      --Cusor para obtener lso datos de la orden legalizada en especial
      --la solicitud a la que esta asociada
      begin
        nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
        open cuSolOTLeg(nuOrderId);
        fetch cuSolOTLeg
          into rfcuSolOTLeg;
        close cuSolOTLeg;
        nuSolicitudId := nvl(rfcuSolOTLeg.Package_Id, 0);
      exception
        when others then
          nuSolicitudId := 0;
      end;
      --

      --CASO 200-1320
      ---cursor para obtener datos del sistema
      open cudatosadcionales;
      fetch cudatosadcionales
        into rfcudatosadcionales;
      close cudatosadcionales;
      ------
      --FIN CASO 200-1320

      FOR rfcusolicitudesanula in cusolicitudesanula LOOP

        dbms_output.put_line('Solicitud del cursor[' ||
                             rfcusolicitudesanula.package_id || ']');
        dbms_output.put_line('Solicitud de orden instanciada[' ||
                             nuSolicitudId || ']');

        if nvl(rfcusolicitudesanula.package_id, 0) <> nvl(nuSolicitudId, 0) then

          dbms_output.put_line('Paso 3');

          BEGIN

            --Validar que el nuPackageId no sea null
            if rfcusolicitudesanula.package_id is not null then

              --cursor para erstablecer la cantidad de ordenes en estado 7 Ejecutadas y
              --en caso de haber uan cantidad de ordenes que sean mayor a 1 de estas ordenes
              --la solicitude sea ignorada para noser anulada o atendida.
              open cuordenesexcluidas(rfcusolicitudesanula.package_id);
              fetch cuordenesexcluidas
                into frcuordenesexcluidas;
              close cuordenesexcluidas;

              dbms_output.put_line('Cantidad ordenes en estado 7[' ||
                                   frcuordenesexcluidas.cantidad || ']');

              --(:new.ID_PRODUCTO) LOOP
              if frcuordenesexcluidas.cantidad = 0 then
                --Se realiza la transicion de estados de la solicitud y el producto
                --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||j.package_id , 1);

                --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuNotas , 1);

                --Saber si todas las ordenes de la solicitud estan o no en estado 0 o 5
                open cuCantOrd(rfcusolicitudesanula.package_id);
                fetch cuCantOrd
                  into rfcuCantOrd;
                close cuCantOrd;
                -------------------------------------------------------------------------
                dbms_output.put_line('cusolicitudesanula');
                dbms_output.put_line('if rfcuCantOrd.Cantidadottodos[' ||
                                     rfcuCantOrd.Cantidadottodos ||
                                     '] = rfcuCantOrd.Cantidadotestado[' ||
                                     rfcuCantOrd.Cantidadotestado ||
                                     '] then');

                if rfcuCantOrd.Cantidadottodos =
                   rfcuCantOrd.Cantidadotestado then

                  dbms_output.put_line('CAMBIO ESTADO DE LA SOLICITUD[' ||
                                       rfcusolicitudesanula.package_id ||
                                       '] ANULADA');
                  --CAMBIO ESTADO DE LA SOLICITUD
                  Update open.mo_packages
                     set MOTIVE_STATUS_ID = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                   where package_id in (rfcusolicitudesanula.package_id);

                  --CAMBIO ESTADO DEl MOTIVO
                  Update open.mo_motive
                     set ANNUL_DATE         = sysdate,
                         STATUS_CHANGE_DATE = sysdate,
                         ANNUL_CAUSAL_ID    = GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                         MOTIVE_STATUS_ID   = 5,
                         CAUSAL_ID          = 287
                   where package_id in (rfcusolicitudesanula.package_id);

                  --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);

                  -- Inicio se anulan las ordenes
                  FOR i in cuOrdAnula(rfcusolicitudesanula.package_id) LOOP
                    BEGIN
                      --ut_trace.trace(' FOR i in cuOrdAnula => '||i.order_id , 1);
                      LDC_CANCEL_ORDER(i.order_id,
                                       GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                       'Anulacion de orden por actualizacion sobre la tabla ldc_plazos_cert',
                                       cnuCommentType,
                                       onuErrorCode,
                                       osbErrorMessage);

                    exception
                      when others then
                        ut_trace.trace('Error LDC_CANCEL_ORDER  ANNUL_CAUSAL ' ||
                                       GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                       1);
                    END;
                    --Actualizar actividades en F
                    UPDATE or_order_activity
                       SET status = 'F'
                     WHERE order_id = i.order_id;
                    --Cambia estado a la Orden
                    UPDATE or_order
                       SET ORDER_STATUS_ID = dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT')
                     WHERE order_id = i.order_id;

                    dbms_output.put_line('Orden[' || i.order_id ||
                                         '] Anulada');

                    ---Inicio porceos de Registrar cambio de estado de orden
                    begin
                      insert into or_order_stat_change
                        (order_stat_change_id,
                         action_id,
                         initial_status_id,
                         final_status_id,
                         order_id,
                         stat_chg_date,
                         user_id,
                         terminal,
                         execution_date,
                         range_description,
                         programing_class_id,
                         initial_oper_unit_id,
                         final_oper_unit_id,
                         comment_type_id,
                         causal_id)
                      values
                        (seq_or_order_stat_change.nextval, --v_order_stat_change_id,
                         107, --v_action_id,
                         i.estado_inicial, --v_initial_status_id,
                         dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT'), --v_final_status_id,
                         i.order_id, --v_order_id,
                         sysdate, --v_stat_chg_date,
                         rfcudatosadcionales.user_id, --v_user_id,
                         rfcudatosadcionales.terminal, --v_terminal,
                         sysdate, --v_execution_date,
                         null, --v_range_description,
                         null, --v_programing_class_id,
                         i.operating_unit_id, --v_initial_oper_unit_id,
                         i.operating_unit_id, --v_final_oper_unit_id,
                         null, --v_comment_type_id,
                         null --v_causal_id
                         );
                    exception
                      when others then
                        dbms_output.put_line('Error[' || sqlerrm || ']');
                        null;
                    end;
                    ---Fin porceos de Registrar cambio de estado de orden

                  END LOOP;
                  -- Fin proceso se anulan las ordenes

                  -- Se obtiene el plan de wf
                  nuPlanId := wf_boinstance.fnugetplanid(rfcusolicitudesanula.package_id,
                                                         17);

                  --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);
                  -- anula el plan de wf
                  mo_boannulment.annulwfplan(nuPlanId);
                  --ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);

                else
                  dbms_output.put_line('CAMBIO ESTADO DE LA SOLICITUD[' ||
                                       rfcusolicitudesanula.package_id ||
                                       '] ATENDIDA');

                  --CAMBIO ESTADO DE LA SOLICITUD
                  Update open.mo_packages
                     set MOTIVE_STATUS_ID = 14 --dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                   where package_id in (rfcusolicitudesanula.package_id);

                  --CAMBIO ESTADO DEl MOTIVO
                  Update open.mo_motive
                     set ANNUL_DATE         = sysdate,
                         STATUS_CHANGE_DATE = sysdate,
                         --ANNUL_CAUSAL_ID    = GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                         MOTIVE_STATUS_ID = 11 --,
                  --CAUSAL_ID          = 287
                   where package_id in (rfcusolicitudesanula.package_id);

                  -- Inicio se anulan las ordenes
                  FOR i in cuOrdAnula(rfcusolicitudesanula.package_id) LOOP
                    BEGIN
                      --ut_trace.trace(' FOR i in cuOrdAnula => '||i.order_id , 1);
                      LDC_CANCEL_ORDER(i.order_id,
                                       GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                       'Anulacion de orden por actualizacion sobre la tabla ldc_plazos_cert',
                                       cnuCommentType,
                                       onuErrorCode,
                                       osbErrorMessage);

                    exception
                      when others then
                        ut_trace.trace('Error LDC_CANCEL_ORDER  ANNUL_CAUSAL ' ||
                                       GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                       1);
                    END;
                    --Actualizar actividades en F
                    UPDATE or_order_activity
                       SET status = 'F'
                     WHERE order_id = i.order_id;
                    --Cambia estado a la Orden
                    UPDATE or_order
                       SET ORDER_STATUS_ID = dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT')
                     WHERE order_id = i.order_id;

                    dbms_output.put_line('Orden[' || i.order_id ||
                                         '] Anulada');

                    ---Inicio porceos de Registrar cambio de estado de orden
                    begin
                      insert into or_order_stat_change
                        (order_stat_change_id,
                         action_id,
                         initial_status_id,
                         final_status_id,
                         order_id,
                         stat_chg_date,
                         user_id,
                         terminal,
                         execution_date,
                         range_description,
                         programing_class_id,
                         initial_oper_unit_id,
                         final_oper_unit_id,
                         comment_type_id,
                         causal_id)
                      values
                        (seq_or_order_stat_change.nextval, --v_order_stat_change_id,
                         107, --v_action_id,
                         i.estado_inicial, --v_initial_status_id,
                         dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT'), --v_final_status_id,
                         i.order_id, --v_order_id,
                         sysdate, --v_stat_chg_date,
                         rfcudatosadcionales.user_id, --v_user_id,
                         rfcudatosadcionales.terminal, --v_terminal,
                         sysdate, --v_execution_date,
                         null, --v_range_description,
                         null, --v_programing_class_id,
                         i.operating_unit_id, --v_initial_oper_unit_id,
                         i.operating_unit_id, --v_final_oper_unit_id,
                         null, --v_comment_type_id,
                         null --v_causal_id
                         );
                    exception
                      when others then
                        dbms_output.put_line('Error[' || sqlerrm || ']');
                        null;
                    end;
                    ---Fin porceos de Registrar cambio de estado de orden

                  END LOOP;
                  -- Fin proceso se anulan las ordenes

                end if; --if rfcuCantOrd.Cantidadottodos = rfcuCantOrd.Cantidadotestado then

                --ut_trace.trace('ID_ESTADO_PKG_ANULADA '||dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), 1);
              end if; --if rfcuordenesexcluidas.cantidad = 0 then

            end if; --if rfcusolicitudesanula.package_id is not null then

          exception
            when others then
              ut_trace.trace('LDC_TRG_MARCA_PRODUCTO Falla busqueda de solicitud para Anular',
                             1);
          END;

        end if; --if rfcusolicitudesanula.package_id <> nuSolicitudId then
      END LOOP;

      --Fin CASO 200-529
      --Fin CASO 200-1320
      ----Fin logcia 200-1320
      dbms_output.put_line('Finaliza proceso de anular o atender solicitud');

    end if; --if :NEW.PLAZO_MAXIMO > :OLD.PLAZO_MAXIMO then
    commit;
  else
    -- Se omite logica de GDC || Caso 200-1518
    dbms_output.put_line('Logica GASCARIBE');
    /*--Logica de GASCARIBE
    ---logica y codigo fuente SAO
    --se obtiene el proximo a?o de certificacion del producto
    OPEN cufechaCertifi(:NEW.ID_PRODUCTO);
    FETCH cufechaCertifi
      INTO daFechaeCerti;
    CLOSE cufechaCertifi;

    \*CASO 200-1320
    Bloqueafo para cambiarlo con la misma logica de EFIGAS
    --se obtiene el a?o de la proxima certificacion
    SELECT TO_CHAR(daFechaeCerti, 'YYYY') into nuYearCerti FROM DUAL;

    --ut_trace.trace('4.1.1 TO_CHAR(:NEW.PLAZO_MAXIMO '|| TO_CHAR(:NEW.PLAZO_MAXIMO,'YYYY') , 1);
    --ut_trace.trace(' 4.2 nuYearCerti '||nuYearCerti , 1);

    if (TO_CHAR(:NEW.PLAZO_MAXIMO, 'YYYY') > nuYearCerti) then
    *\

    --CASO 200-1320 cambiar la logica de validacion de plazo maximo como solicita N1 de EFIGAS
    --if :NEW.PLAZO_MAXIMO != :OLD.PLAZO_MAXIMO or :OLD.PLAZO_MAXIMO is null then
    dbms_output.put_line(':NEW.PLAZO_MAXIMO[' || :NEW.PLAZO_MAXIMO ||
                         '] > :OLD.PLAZO_MAXIMO[' || :OLD.PLAZO_MAXIMO || ']');
    if :NEW.PLAZO_MAXIMO > :OLD.PLAZO_MAXIMO then

      --borrar marca asociada al producto
      delete from ldc_marca_producto where id_producto = :new.ID_PRODUCTO;
      --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO delete sobre ldc_marca_producto ejecutado '||:new.ID_PRODUCTO , 1);

      --Se buscan las solicitudes que se deben anular

      FOR j in cuSolAnula(:new.ID_PRODUCTO) LOOP
        BEGIN
          --Validar que el nuPackageId no sea null
          if j.package_id is not null then
            --Se realiza la transicion de estados de la solicitud y el producto
            --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||j.package_id , 1);

            BEGIN
              ldc_pkg_changstatesolici.PACKAGEINTTRANSITION(j.package_id,
                                                            GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
            exception
              when others then
                ut_trace.trace('Error ldc_pkg_changstatesolici.PACKAGEINTTRANSITION ',
                               1);
            END;

            --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||j.package_id , 1);
            -- se reversan los cargos generados
            nuNotas := FNUREQCHARGESCANCELL(j.package_id);

            --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuNotas , 1);

            -- se anulan las ordenes
            FOR i in cuOrdAnula(j.package_id) LOOP
              BEGIN
                --ut_trace.trace(' FOR i in cuOrdAnula => '||i.order_id , 1);
                LDC_CANCEL_ORDER(i.order_id,
                                 GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                 'Anulacion de orden por certificacion',
                                 cnuCommentType,
                                 onuErrorCode,
                                 osbErrorMessage);

              exception
                when others then
                  ut_trace.trace('Error LDC_CANCEL_ORDER  ANNUL_CAUSAL ' ||
                                 GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                 1);
              END;
              --Actualizar actividades en F
              UPDATE or_order_activity
                 SET status = 'F'
               WHERE order_id = i.order_id;
              --Cambia estado a la Orden
              UPDATE or_order
                 SET ORDER_STATUS_ID = dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT')
               WHERE order_id = i.order_id;
            END LOOP;

            --ut_trace.trace('ID_ESTADO_PKG_ANULADA '||dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), 1);

            --CAMBIO ESTADO DE LA SOLICITUD
            Update open.mo_packages
               set MOTIVE_STATUS_ID = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
             where package_id in (j.package_id);

            --CAMBIO ESTADO DEl MOTIVO
            Update open.mo_motive
               set ANNUL_DATE         = sysdate,
                   STATUS_CHANGE_DATE = sysdate,
                   ANNUL_CAUSAL_ID    = GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                   MOTIVE_STATUS_ID   = 5,
                   CAUSAL_ID          = 287
             where package_id in (j.package_id);

            --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);

            -- Se obtiene el plan de wf
            nuPlanId := wf_boinstance.fnugetplanid(j.package_id, 17);

            --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);
            -- anula el plan de wf
            mo_boannulment.annulwfplan(nuPlanId);
            --ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);
          end if;

        exception
          when others then
            ut_trace.trace('LDC_TRG_MARCA_PRODUCTO Falla busqueda de solicitud para Anular',
                           1);
        END;
      END LOOP;

      ----Inicio logcia 200-1320
      dbms_output.put_line('Inicio proceso de anular o atender solicitud');

      --Inicio CASO 200-1320
      --Inicio CASO 200-529 --modificacion de logica para el CASO 200-1320

      --Cusor para obtener lso datos de la orden legalizada en especial
      --la solicitud a la que esta asociada
      begin
        nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
        open cuSolOTLeg(nuOrderId);
        fetch cuSolOTLeg
          into rfcuSolOTLeg;
        close cuSolOTLeg;
        nuSolicitudId := nvl(rfcuSolOTLeg.Package_Id, 0);
      exception
        when others then
          nuSolicitudId := 0;
      end;
      --

      --CASO 200-1320
      ---cursor para obtener datos del sistema
      open cudatosadcionales;
      fetch cudatosadcionales
        into rfcudatosadcionales;
      close cudatosadcionales;
      ------
      --FIN CASO 200-1320

      dbms_output.put_line('Usuario [' || rfcudatosadcionales.user_id || ']');
      dbms_output.put_line('Terminal [' || rfcudatosadcionales.terminal || ']');
      dbms_output.put_line('Logica GASCARIBE - 2');

      FOR rfcusolicitudesanula in cusolicitudesanula LOOP

        dbms_output.put_line('Solicitud del cursor[' ||
                             rfcusolicitudesanula.package_id || ']');
        dbms_output.put_line('Solicitud de orden instanciada[' ||
                             nuSolicitudId || ']');

        if nvl(rfcusolicitudesanula.package_id, 0) <> nvl(nuSolicitudId, 0) then

          dbms_output.put_line('Paso 3');

          BEGIN

            --Validar que el nuPackageId no sea null
            if rfcusolicitudesanula.package_id is not null then

              --cursor para erstablecer la cantidad de ordenes en estado 7 Ejecutadas y
              --en caso de haber uan cantidad de ordenes que sean mayor a 1 de estas ordenes
              --la solicitude sea ignorada para noser anulada o atendida.
              open cuordenesexcluidas(rfcusolicitudesanula.package_id);
              fetch cuordenesexcluidas
                into frcuordenesexcluidas;
              close cuordenesexcluidas;

              dbms_output.put_line('Cantidad ordenes en estado 7[' ||
                                   frcuordenesexcluidas.cantidad || ']');

              --(:new.ID_PRODUCTO) LOOP
              if frcuordenesexcluidas.cantidad = 0 then

                open cuexluirexiste(rfcusolicitudesanula.package_id);
                fetch cuexluirexiste
                  into rfcuexluirexiste;
                close cuexluirexiste;

                if nvl(rfcuexluirexiste.cantidad, 0) = 0 then

                  --Se realiza la transicion de estados de la solicitud y el producto
                  --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||j.package_id , 1);

                  --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuNotas , 1);

                  --Saber si todas las ordenes de la solicitud estan o no en estado 0 o 5
                  open cuCantOrd(rfcusolicitudesanula.package_id);
                  fetch cuCantOrd
                    into rfcuCantOrd;
                  close cuCantOrd;
                  -------------------------------------------------------------------------
                  dbms_output.put_line('cusolicitudesanula');
                  dbms_output.put_line('if rfcuCantOrd.Cantidadottodos[' ||
                                       rfcuCantOrd.Cantidadottodos ||
                                       '] = rfcuCantOrd.Cantidadotestado[' ||
                                       rfcuCantOrd.Cantidadotestado ||
                                       '] then');

                  if rfcuCantOrd.Cantidadottodos =
                     rfcuCantOrd.Cantidadotestado then

                    dbms_output.put_line('CAMBIO ESTADO DE LA SOLICITUD[' ||
                                         rfcusolicitudesanula.package_id ||
                                         '] ANULADA');
                    --CAMBIO ESTADO DE LA SOLICITUD
                    Update open.mo_packages
                       set MOTIVE_STATUS_ID = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                     where package_id in (rfcusolicitudesanula.package_id);

                    --CAMBIO ESTADO DEl MOTIVO
                    Update open.mo_motive
                       set ANNUL_DATE         = sysdate,
                           STATUS_CHANGE_DATE = sysdate,
                           ANNUL_CAUSAL_ID    = GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                           MOTIVE_STATUS_ID   = 5,
                           CAUSAL_ID          = 287
                     where package_id in (rfcusolicitudesanula.package_id);

                    --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);

                    -- Inicio se anulan las ordenes
                    FOR i in cuOrdAnula(rfcusolicitudesanula.package_id) LOOP
                      BEGIN
                        --ut_trace.trace(' FOR i in cuOrdAnula => '||i.order_id , 1);
                        LDC_CANCEL_ORDER(i.order_id,
                                         GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                         'Anulacion de orden por actualizacion sobre la tabla ldc_plazos_cert',
                                         cnuCommentType,
                                         onuErrorCode,
                                         osbErrorMessage);

                      exception
                        when others then
                          ut_trace.trace('Error LDC_CANCEL_ORDER  ANNUL_CAUSAL ' ||
                                         GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                         1);
                      END;
                      --Actualizar actividades en F
                      UPDATE or_order_activity
                         SET status = 'F'
                       WHERE order_id = i.order_id;
                      --Cambia estado a la Orden
                      UPDATE or_order
                         SET ORDER_STATUS_ID = dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT')
                       WHERE order_id = i.order_id;

                      dbms_output.put_line('Orden[' || i.order_id ||
                                           '] Anulada');

                      dbms_output.put_line('Antes de registrar en or_order_stat_change');
                      ---Inicio porceos de Registrar cambio de estado de orden
                      begin
                        insert into or_order_stat_change
                          (order_stat_change_id,
                           action_id,
                           initial_status_id,
                           final_status_id,
                           order_id,
                           stat_chg_date,
                           user_id,
                           terminal,
                           execution_date,
                           range_description,
                           programing_class_id,
                           initial_oper_unit_id,
                           final_oper_unit_id,
                           comment_type_id,
                           causal_id)
                        values
                          (seq_or_order_stat_change.nextval, --v_order_stat_change_id,
                           107, --v_action_id,
                           i.estado_inicial, --v_initial_status_id,
                           dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT'), --v_final_status_id,
                           i.order_id, --v_order_id,
                           sysdate, --v_stat_chg_date,
                           rfcudatosadcionales.user_id, --v_user_id,
                           rfcudatosadcionales.terminal, --v_terminal,
                           sysdate, --v_execution_date,
                           null, --v_range_description,
                           null, --v_programing_class_id,
                           i.operating_unit_id, --v_initial_oper_unit_id,
                           i.operating_unit_id, --v_final_oper_unit_id,
                           null, --v_comment_type_id,
                           null --v_causal_id
                           );
                      exception
                        when others then
                          dbms_output.put_line('Error[' || sqlerrm || ']');
                          null;
                      end;
                      dbms_output.put_line('Fin de registrar en or_order_stat_change');
                      ---Fin porceos de Registrar cambio de estado de orden

                    END LOOP;
                    -- Fin proceso se anulan las ordenes

                    -- Se obtiene el plan de wf
                    nuPlanId := wf_boinstance.fnugetplanid(rfcusolicitudesanula.package_id,
                                                           17);

                    --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);
                    -- anula el plan de wf
                    mo_boannulment.annulwfplan(nuPlanId);
                    --ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);

                  else
                    dbms_output.put_line('CAMBIO ESTADO DE LA SOLICITUD[' ||
                                         rfcusolicitudesanula.package_id ||
                                         '] ATENDIDA');

                    --CAMBIO ESTADO DE LA SOLICITUD
                    Update open.mo_packages
                       set MOTIVE_STATUS_ID = 14 --dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                     where package_id in (rfcusolicitudesanula.package_id);

                    --CAMBIO ESTADO DEl MOTIVO
                    Update open.mo_motive
                       set ANNUL_DATE         = sysdate,
                           STATUS_CHANGE_DATE = sysdate,
                           --ANNUL_CAUSAL_ID    = GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                           MOTIVE_STATUS_ID = 11 --,
                    --CAUSAL_ID          = 287
                     where package_id in (rfcusolicitudesanula.package_id);

                    -- Inicio se anulan las ordenes
                    FOR i in cuOrdAnula(rfcusolicitudesanula.package_id) LOOP
                      BEGIN
                        --ut_trace.trace(' FOR i in cuOrdAnula => '||i.order_id , 1);
                        LDC_CANCEL_ORDER(i.order_id,
                                         GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                         'Anulacion de orden por actualizacion sobre la tabla ldc_plazos_cert',
                                         cnuCommentType,
                                         onuErrorCode,
                                         osbErrorMessage);

                      exception
                        when others then
                          ut_trace.trace('Error LDC_CANCEL_ORDER  ANNUL_CAUSAL ' ||
                                         GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                         1);
                      END;
                      --Actualizar actividades en F
                      UPDATE or_order_activity
                         SET status = 'F'
                       WHERE order_id = i.order_id;
                      --Cambia estado a la Orden
                      UPDATE or_order
                         SET ORDER_STATUS_ID = dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT')
                       WHERE order_id = i.order_id;

                      dbms_output.put_line('Orden[' || i.order_id ||
                                           '] Anulada');

                      ---Inicio porceos de Registrar cambio de estado de orden
                      begin
                        insert into or_order_stat_change
                          (order_stat_change_id,
                           action_id,
                           initial_status_id,
                           final_status_id,
                           order_id,
                           stat_chg_date,
                           user_id,
                           terminal,
                           execution_date,
                           range_description,
                           programing_class_id,
                           initial_oper_unit_id,
                           final_oper_unit_id,
                           comment_type_id,
                           causal_id)
                        values
                          (seq_or_order_stat_change.nextval, --v_order_stat_change_id,
                           107, --v_action_id,
                           i.estado_inicial, --v_initial_status_id,
                           dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT'), --v_final_status_id,
                           i.order_id, --v_order_id,
                           sysdate, --v_stat_chg_date,
                           rfcudatosadcionales.user_id, --v_user_id,
                           rfcudatosadcionales.terminal, --v_terminal,
                           sysdate, --v_execution_date,
                           null, --v_range_description,
                           null, --v_programing_class_id,
                           i.operating_unit_id, --v_initial_oper_unit_id,
                           i.operating_unit_id, --v_final_oper_unit_id,
                           null, --v_comment_type_id,
                           null --v_causal_id
                           );
                      exception
                        when others then
                          dbms_output.put_line('Error[' || sqlerrm || ']');
                          null;
                      end;
                      ---Fin porceos de Registrar cambio de estado de orden

                    END LOOP;
                    -- Fin proceso se anulan las ordenes

                  end if; --if rfcuCantOrd.Cantidadottodos = rfcuCantOrd.Cantidadotestado then

                end if; --if nvl(cuexluirexiste.cantidad,0) = 0 then
                --ut_trace.trace('ID_ESTADO_PKG_ANULADA '||dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), 1);
              end if; --if rfcuordenesexcluidas.cantidad = 0 then

            end if; --if rfcusolicitudesanula.package_id is not null then

          exception
            when others then
              dbms_output.put_line('LDC_TRG_MARCA_PRODUCTO Falla busqueda de solicitud para Anular');
              ut_trace.trace('LDC_TRG_MARCA_PRODUCTO Falla busqueda de solicitud para Anular',
                             1);
          END;

        end if; --if rfcusolicitudesanula.package_id <> nuSolicitudId then
      END LOOP;
      commit;

      dbms_output.put_line('FOR rfcuotanulasolicitud100101 in cuotanulasolicitud100101 LOOP');

      FOR rfcuotanulasolicitud100101 in cuotanulasolicitud100101 LOOP
        --(:new.ID_PRODUCTO) LOOP
        BEGIN
          --Validar que el nuPackageId no sea null
          if rfcuotanulasolicitud100101.package_id is not null then

            dbms_output.put_line('rfcuotanulasolicitud100101.package_id[' ||
                                 rfcuotanulasolicitud100101.package_id ||
                                 '] Anulada');

            open cuexluirexiste(rfcuotanulasolicitud100101.package_id);
            fetch cuexluirexiste
              into rfcuexluirexiste;
            close cuexluirexiste;

            dbms_output.put_line('CANTIDAD rfcuexluirexiste.cantidad[' ||
                                 rfcuexluirexiste.cantidad || '] Anulada');

            if nvl(rfcuexluirexiste.cantidad, 0) = 0 then

              --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuNotas , 1);

              --Saber si todas las ordenes de la solicitud estan o no en estado 0 o 5
              open cuCantOrd(rfcuotanulasolicitud100101.package_id);
              fetch cuCantOrd
                into rfcuCantOrd;
              close cuCantOrd;
              -------------------------------------------------------------------------
              dbms_output.put_line('cuotanulasolicitud100101');
              dbms_output.put_line('if rfcuCantOrd.Cantidadottodos[' ||
                                   rfcuCantOrd.Cantidadottodos ||
                                   '] = rfcuCantOrd.Cantidadotestado[' ||
                                   rfcuCantOrd.Cantidadotestado ||
                                   '] then');

              if rfcuCantOrd.Cantidadottodos = rfcuCantOrd.Cantidadotestado then

                --CAMBIO ESTADO DE LA SOLICITUD
                Update open.mo_packages
                   set MOTIVE_STATUS_ID = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                 where package_id in
                       (rfcuotanulasolicitud100101.package_id);

                --CAMBIO ESTADO DEl MOTIVO
                Update open.mo_motive
                   set ANNUL_DATE         = sysdate,
                       STATUS_CHANGE_DATE = sysdate,
                       ANNUL_CAUSAL_ID    = GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                       MOTIVE_STATUS_ID   = 5,
                       CAUSAL_ID          = 287
                 where package_id in
                       (rfcuotanulasolicitud100101.package_id);

                -- Inicio se anulan las ordenes
                FOR i in cuOrdAnula(rfcuotanulasolicitud100101.package_id) LOOP
                  BEGIN
                    --ut_trace.trace(' FOR i in cuOrdAnula => '||i.order_id , 1);
                    LDC_CANCEL_ORDER(i.order_id,
                                     GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                     'Anulacion de orden por actualizacion sobre la tabla ldc_plazos_cert',
                                     cnuCommentType,
                                     onuErrorCode,
                                     osbErrorMessage);

                  exception
                    when others then
                      ut_trace.trace('Error LDC_CANCEL_ORDER  ANNUL_CAUSAL ' ||
                                     GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                     1);
                  END;
                  --Actualizar actividades en F
                  UPDATE or_order_activity
                     SET status = 'F'
                   WHERE order_id = i.order_id;
                  --Cambia estado a la Orden
                  UPDATE or_order
                     SET ORDER_STATUS_ID = dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT')
                   WHERE order_id = i.order_id;

                  dbms_output.put_line('Orden[' || i.order_id ||
                                       '] Anulada');

                  ---Inicio porceos de Registrar cambio de estado de orden
                  begin
                    insert into or_order_stat_change
                      (order_stat_change_id,
                       action_id,
                       initial_status_id,
                       final_status_id,
                       order_id,
                       stat_chg_date,
                       user_id,
                       terminal,
                       execution_date,
                       range_description,
                       programing_class_id,
                       initial_oper_unit_id,
                       final_oper_unit_id,
                       comment_type_id,
                       causal_id)
                    values
                      (seq_or_order_stat_change.nextval, --v_order_stat_change_id,
                       107, --v_action_id,
                       i.estado_inicial, --v_initial_status_id,
                       dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT'), --v_final_status_id,
                       i.order_id, --v_order_id,
                       sysdate, --v_stat_chg_date,
                       rfcudatosadcionales.user_id, --v_user_id,
                       rfcudatosadcionales.terminal, --v_terminal,
                       sysdate, --v_execution_date,
                       null, --v_range_description,
                       null, --v_programing_class_id,
                       i.operating_unit_id, --v_initial_oper_unit_id,
                       i.operating_unit_id, --v_final_oper_unit_id,
                       null, --v_comment_type_id,
                       null --v_causal_id
                       );
                  exception
                    when others then
                      dbms_output.put_line('Error[' || sqlerrm || ']');
                      null;
                  end;
                  ---Fin porceos de Registrar cambio de estado de orden

                END LOOP;
                -- Fin proceso se anulan las ordenes

                --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);

                -- Se obtiene el plan de wf
                nuPlanId := wf_boinstance.fnugetplanid(rfcuotanulasolicitud100101.package_id,
                                                       17);

                --ut_trace.trace(' Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);
                -- anula el plan de wf
                mo_boannulment.annulwfplan(nuPlanId);
                --ut_trace.trace('Ejecucion LDC_TRG_MARCA_PRODUCTO nuPlanId  => '||nuPlanId , 1);

              else

                dbms_output.put_line('rfcuotanulasolicitud100101.package_id[' ||
                                     rfcuotanulasolicitud100101.package_id ||
                                     '] Atender');

                --CAMBIO ESTADO DE LA SOLICITUD
                Update open.mo_packages
                   set MOTIVE_STATUS_ID = 14 --dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                 where package_id in
                       (rfcuotanulasolicitud100101.package_id);

                --CAMBIO ESTADO DEl MOTIVO
                Update open.mo_motive
                   set ANNUL_DATE         = sysdate,
                       STATUS_CHANGE_DATE = sysdate,
                       --ANNUL_CAUSAL_ID    = GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                       MOTIVE_STATUS_ID = 11 --,
                --CAUSAL_ID          = 287
                 where package_id in
                       (rfcuotanulasolicitud100101.package_id);

                -- Inicio se anulan las ordenes
                FOR i in cuOrdAnula(rfcuotanulasolicitud100101.package_id) LOOP
                  BEGIN
                    --ut_trace.trace(' FOR i in cuOrdAnula => '||i.order_id , 1);
                    LDC_CANCEL_ORDER(i.order_id,
                                     GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                     'Anulacion de orden por actualizacion sobre la tabla ldc_plazos_cert',
                                     cnuCommentType,
                                     onuErrorCode,
                                     osbErrorMessage);

                  exception
                    when others then
                      ut_trace.trace('Error LDC_CANCEL_ORDER  ANNUL_CAUSAL ' ||
                                     GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'),
                                     1);
                  END;
                  --Actualizar actividades en F
                  UPDATE or_order_activity
                     SET status = 'F'
                   WHERE order_id = i.order_id;
                  --Cambia estado a la Orden
                  UPDATE or_order
                     SET ORDER_STATUS_ID = dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT')
                   WHERE order_id = i.order_id;

                  dbms_output.put_line('Orden[' || i.order_id ||
                                       '] Anulada');

                  ---Inicio porceos de Registrar cambio de estado de orden
                  begin
                    insert into or_order_stat_change
                      (order_stat_change_id,
                       action_id,
                       initial_status_id,
                       final_status_id,
                       order_id,
                       stat_chg_date,
                       user_id,
                       terminal,
                       execution_date,
                       range_description,
                       programing_class_id,
                       initial_oper_unit_id,
                       final_oper_unit_id,
                       comment_type_id,
                       causal_id)
                    values
                      (seq_or_order_stat_change.nextval, --v_order_stat_change_id,
                       107, --v_action_id,
                       i.estado_inicial, --v_initial_status_id,
                       dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT'), --v_final_status_id,
                       i.order_id, --v_order_id,
                       sysdate, --v_stat_chg_date,
                       rfcudatosadcionales.user_id, --v_user_id,
                       rfcudatosadcionales.terminal, --v_terminal,
                       sysdate, --v_execution_date,
                       null, --v_range_description,
                       null, --v_programing_class_id,
                       i.operating_unit_id, --v_initial_oper_unit_id,
                       i.operating_unit_id, --v_final_oper_unit_id,
                       null, --v_comment_type_id,
                       null --v_causal_id
                       );
                  exception
                    when others then
                      dbms_output.put_line('Error[' || sqlerrm || ']');
                      null;
                  end;
                  ---Fin porceos de Registrar cambio de estado de orden

                END LOOP;
                -- Fin proceso se anulan las ordenes

              end if; --if rfcuCantOrd.Cantidadottodos = rfcuCantOrd.Cantidadotestado then

              --ut_trace.trace('ID_ESTADO_PKG_ANULADA '||dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), 1);
            end if; --if nvl(rfcuexluirexiste.cantidad, 0) = 0 then

          end if;

        exception
          when others then
            ut_trace.trace('LDC_TRG_MARCA_PRODUCTO Falla busqueda de solicitud para Anular',
                           1);
        END;
      END LOOP;
      commit;

      --Fin CASO 200-529
      --Fin CASO 200-1320

      ----Fin logcia 200-1320
      dbms_output.put_line('Finaliza proceso de anular o atender solicitud');
      --commit;
      ----

    end if; --if :NEW.PLAZO_MAXIMO > :OLD.PLAZO_MAXIMO then
    --commit;*/

  end if; --if fblAplicaEntrega('OSS_RP_JM_200_529_4') then

  commit;
  --rollback;
  --Fin CASO 200-529

  ut_trace.trace('Fin LDC_TRG_MARCA_PRODUCTO', 10);
exception
  when others then
    rollback;
end LDC_TRG_MARCA_PRODUCTO;
/
