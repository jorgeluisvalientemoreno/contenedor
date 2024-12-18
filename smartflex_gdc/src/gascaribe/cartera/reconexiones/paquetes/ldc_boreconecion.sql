CREATE OR REPLACE PACKAGE OPEN.LDC_BORECONECION AS
    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  LDC_BORECONECION
    Descripcion :
    Autor       : Alexandra Gordillo
    Fecha       : 17-07-2013

    Historia de Modificaciones
      Fecha               Autor                   Modificacion
    =========           =========               ====================
    17-07-2013          agordillo               Creacion.
    25-02-2014          smejia                  Aran 2931. Se crea la funcion fsbValidaCasual
    17-09-2014          acardenas               NC2410. Se modifica funcion fsbValidaCasual
	18-06-2015          KCienfuegos.SAO329310   Se modifica metodo <<revEstadoProducto>>
	10-04-2023			cgonzalez (Horbath)		OSF-923: Se modifica el servicio ReconexionPorPago y udtEstadoProducto
	31-05-2023			cgonzalez (Horbath)		OSF-1173: Se modifica el servicio ReconexionPorPago y revEstadoProducto
    05-06-2023          felipe.valencia         OSF-1121 Se agrega el procedimiento
                                                prudtEstadoProducto
    **************************************************************************/

    /*Funcion que devuelve la version del pkg*/
    FUNCTION fsbVersion RETURN VARCHAR2;

    PROCEDURE udtEstadoProducto(inuPackage in mo_packages.package_id%type);

    FUNCTION fsbValidaNivelSupencionCM(
        inuProductId in pr_product.product_id%type
    )
    RETURN VARCHAR2;

    FUNCTION fsbValidaNivelSupencionAcom(inuProductId in pr_product.product_id%type)
    RETURN VARCHAR2;

    FUNCTION fsbValidaPago(isbExternalId in VARCHAR2)
    RETURN number;

    PROCEDURE ReconexionPorPago(
        inuPackage in mo_packages.package_id%type
    );

    FUNCTION fsbValidaCasual(
        inuPackage in mo_packages.package_id%type
    ) return varchar2;

    PROCEDURE revEstadoProducto(inuPackage in mo_packages.package_id%type);

    PROCEDURE prudtEstadoProducto
    (
        inuProduct IN mo_motive.product_id%TYPE
    ) ;

END LDC_BORECONECION;
/
CREATE OR REPLACE PACKAGE BODY OPEN.LDC_BORECONECION AS
    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  LDC_BORECONECION
    Descripcion :
    Autor       : AGORDILLO
    Fecha       : 17-07-2013

    Historia de Modificaciones
      Fecha               Autor                  Modificacion
    =========           =========               ====================
    17-07-2013          agordillo               Creacion.
	18-06-2015          KCienfuegos.SAO329310   Se modifica metodo <<revEstadoProducto>>
	10-04-2023			cgonzalez (Horbath)		OSF-923: Se modifica el servicio ReconexionPorPago
	31-05-2023			cgonzalez (Horbath)		OSF-1173: Se modifica el servicio ReconexionPorPago y revEstadoProducto
    **************************************************************************/

    /*Variable global*/
    CSBVERSION                CONSTANT        varchar2(40)  := 'OSF-1173';

    /* Tipo de Causal de Anulacion */
    CNUCAUSANUL     CONSTANT    number := 18;

    /* Tipo de Causal de Fallo*/
    CNUCAUSFAIL     CONSTANT    number := 2;

    CNUESTADCONORDEN  CONSTANT  NUMBER := 6;

    /*Funcion que devuelve la version del pkg*/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
         return CSBVERSION;
    END FSBVERSION;


    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  udtEstadoProducto
    Descripcion :
    Autor       : Alexandra Gordillo
    Fecha       : 17-07-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    17-07-2013          agordillo          Creacion.
	15-07-2016          socoro             CA 200-565 Se adicionan logica para insertar registro en suspcone al crear la orden de reconexion.
	10-04-2023			cgonzalez (Horbath)	OSF-923: Se modifica para no actualizar la fecha de corte del producto
    05-06-2023          felipe.valencia     OSF-1121 Se elimina la actualización del producto
    **************************************************************************/
    PROCEDURE udtEstadoProducto(inuPackage in mo_packages.package_id%type) AS

        nuProductID          mo_motive.product_id%type;
				rcServsusc           servsusc%rowtype;
				nuAddressId          pr_product.address_id%type;
				inuDepa              ge_geogra_location.geograp_location_id%type;
				inuLocaId            ge_geogra_location.geograp_location_id%type;
				nuOrder              or_order.order_id%type;
				nuBeforeState        hicaesco.hcececan%type;



				cursor cuOrdenReconex
				is
				select order_id from or_order_activity
				where task_type_id in (12527, 12529)
				and package_id = inuPackage;
				 ---Cursor para obtener el estado de corte anterior asociado al producto
						cursor cuBeforeStatus (inuProductId servsusc.sesunuse%type) is
						select HCECECAN
						from hicaesco
						where hcecnuse = inuProductId
						and hcecfech = (select max (hcecfech) from hicaesco where  hcecnuse = inuProductId);
          --Datos del procedimiento programado
           onuScheduleProcessAux Ge_process_schedule.process_schedule_id%type;
	inuExecutable Sa_executable.executable_id%type := 185;
	isbParameters Ge_process_schedule.parameters_%type;

	isbWhat                                        Ge_process_schedule.what%type;
  inuFrecuenciValue                              ge_proc_sche_cond.frequency_value%type := 1;
  isbFrecuency                                   Ge_process_schedule.Frequency%type := 'UV';
  idtNextDate                                    Ge_process_schedule.Start_Date_%type := sysdate + (3 * (1/24/60));
	inuYearCond                                    ge_proc_sche_cond.year_cond%type := -1;
	isbMonthrCond                                  ge_proc_sche_cond.months_cond%type := null;
	isbWeekCond                                    ge_proc_sche_cond.week_cond%type := 7;
	inuDayInitialCond                              ge_proc_sche_cond.day_initial_cond%type := null;
	inuDayFinalCond                                ge_proc_sche_cond.day_final_cond%type := null;
	inuHourInitialCond                             ge_proc_sche_cond.hour_initial_cond%type := null;
	inuHourFinalCond                               ge_proc_sche_cond.hour_final_cond%type := null;
	inuMinutesInitialCond                          ge_proc_sche_cond.minutes_initial_cond%type := null;
	inuMinutesFinalCond                            ge_proc_sche_cond.minutes_final_cond%type := null;
  inuPackageId                                   mo_packages.package_id%type;

    BEGIN

    UT_Trace.Trace('Inicia LDC_BORECONECION.udtEstadoProducto ',8);
    UT_Trace.Trace('Package '||inuPackage,8);

        pkerrors.setapplication('LDCRECONEX');

    -- Obtiene el producto del motivo
        BEGIN
            select product_id into nuProductID from mo_motive
            where package_id=  inuPackage;  --OR_BOINSTANCE.fnugetextsysidfrominstance;

        EXCEPTION
            when no_data_found then
            UT_Trace.Trace('No se encuentra producto en el motivo ',8);
        END;

       -- nuProductID := damo_motive.fnugetproduct_id(inumotivo);

        IF (nuProductID is not null) THEN

           --Obtine el siguiente valor para el id de Ge_process_schedule
             select max(process_schedule_id)+1 into onuScheduleProcessAux from Ge_process_schedule;
             --Parametros
             isbParameters := 'PACKAGE_ID='||to_char(inuPackage);
             --Bloque anonimo con el que se fija la frecuencia de ejecucion del job
             isbWhat := 'BEGIN SetSystemEnviroment;
            Errors.Initialize;
            ldc_insertSuspcone( '||onuScheduleProcessAux||' );
            if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
              GE_BOSchedule.InactiveSchedule( '||onuScheduleProcessAux||' );
            end if;
          EXCEPTION
           when OTHERS then
              Errors.SetError;
              if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                GE_BOSchedule.DropSchedule( '||onuScheduleProcessAux||' );
              end if;
              END;';


		 	--Inserta en la tabla GE_Process_Schedule un registro con la
  	--informacin basica para la programacion de un proceso.
    dbms_output.put_Line(onuScheduleProcessAux);
  	GE_BOSchedule.PrepareSchedule(inuExecutable,isbParameters,isbWhat,onuScheduleProcessAux);
    --Fijar frecuencia de ejecucion
    GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);
  	-- Inserta las condiciones de la frecuencia para la
  	-- programacion de tarea desde el GEMPS.
    dbms_output.put_Line(onuScheduleProcessAux);
  	GE_BOSchedule.ConditionScheduled(onuScheduleProcessAux,inuFrecuenciValue,inuYearCond,isbMonthrCond,isbWeekCond,inuDayInitialCond,
  									inuDayFinalCond,inuHourInitialCond,inuHourFinalCond,inuMinutesInitialCond, inuMinutesFinalCond);
    dbms_output.put_Line(onuScheduleProcessAux);
	--Inserta en la tabla GE_Proc_Sche_Detail un registro con un
	--detalle de los parmetros del proceso.
    --ESTE ESTA COMENTADO PORQUE NO APLICA
	--GE_BOSchedule.ScheduleDetail(onuScheduleProcessAux,inuSequence,isbParameter);

	--Programa la Tarea en el Job de Oracle, con el procedimiento de intervalo
	--y el procedimiento del what que indica que har la tarea.
    GE_BOSchedule.ScheduleProcessGEMPS(onuScheduleProcessAux);
		--insert into ldc_seguimiento_codigo(cadena,fecha) values ('FINALIZA ldc_legalizeOrImp',sysdate);

          ---------------------------------------------------

					--CA 200-565 15-07-2016 Fin
        END IF;

        commit;

        UT_Trace.Trace('Finaliza LDC_BORECONECION.udtEstadoProducto ',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END udtEstadoProducto;

    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  fsbValidaNivelSupencionCM
    Descripcion : Valida si el producto fue suspendido a nivel del Centro de Medicion.
                  Entrada: Identificador del producto
                  Salida: 'Y' si la suspencion del producto se realizo a nivel de Centro de Medicion
    Autor       : Sergio Mejia Rivera - Optima Consulting
    Fecha       : 07-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    07-09-2013          sergiom             Creacion.
    **************************************************************************/
    FUNCTION fsbValidaNivelSupencionCM(inuProductId in pr_product.product_id%type)
    RETURN VARCHAR2
    IS
        sbEsSuspensionCM varchar2(2):= 'N';
        sbParameter             ld_parameter.value_chain%type;
    BEGIN
        sbParameter := dald_parameter.fsbGetValue_Chain('LDC_ACTIVIDADES_SUSPENSION_CM');
       BEGIN
            SELECT 'Y'
            INTO sbEsSuspensionCM
            FROM pr_product PR, OR_order_activity ORD, (SELECT column_value
                                                        from table (ldc_boutilities.splitStrings(sbParameter,'|'))) PAR
            WHERE PR.product_id = inuProductId
            AND PR.suspen_ord_act_id = ORD.order_activity_id
            AND ORD.activity_id =  PAR.column_value
            AND rownum = 1;
        EXCEPTION
            when no_data_found then
                sbEsSuspensionCM := 'N';
        END;

        RETURN sbEsSuspensionCM;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbValidaNivelSupencionCM;


    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  fsbValidaNivelSupencionAcom
    Descripcion : Valida si el producto fue suspendido a nivel del Acometida.
                  Entrada: Identificador del producto
                  Salida: 'Y' si la suspencion del producto se realizo a nivel de Acometida
    Autor       : Sergio Mejia Rivera - Optima Consulting
    Fecha       : 07-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    07-09-2013          sergiom             Creacion.
    **************************************************************************/
    FUNCTION fsbValidaNivelSupencionAcom(inuProductId in pr_product.product_id%type)
    RETURN VARCHAR2
    IS
        sbEsSuspensionAcometida varchar2(2):= 'N';
        sbParameter             ld_parameter.value_chain%type;
    BEGIN
        sbParameter := dald_parameter.fsbGetValue_Chain('LDC_ACTIVIDADES_SUSPENSION_ACO');
       BEGIN
            SELECT 'Y'
            INTO sbEsSuspensionAcometida
            FROM pr_product PR, OR_order_activity ORD, (SELECT column_value
                                                        from table (ldc_boutilities.splitStrings(sbParameter,'|'))) PAR
            WHERE PR.product_id = inuProductId
            AND PR.suspen_ord_act_id = ORD.order_activity_id
            AND ORD.activity_id =  PAR.column_value
            AND rownum = 1;
        EXCEPTION
            when no_data_found then
                sbEsSuspensionAcometida := 'N';
        END;

        RETURN sbEsSuspensionAcometida;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbValidaNivelSupencionAcom;


    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  fsbValidaPago
    Descripcion : Valida si se ingreso un pago en fechas posteriores a la
                  fecha de registro de la solicitud.
                  Entrada: Identificador de la solicitud
                  Salida: 'SI' si se registro un pago en fechas posteriores a la
                  fecha de registro de la solicitud.
    Autor       : Sergio Mejia Rivera - Optima Consulting
    Fecha       : 07-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    07-09-2013          sergiom             Creacion.
    **************************************************************************/
    FUNCTION fsbValidaPago(isbExternalId in VARCHAR2)
    RETURN NUMBER
    IS
        inuPackage mo_packages.package_id%type;
        nuPagado number := 0;
    BEGIN
        inuPackage := ut_convert.fnuchartonumber(isbExternalId);
       BEGIN
           SELECT 1
            INTO nuPagado
            FROM pr_prod_suspension PS, pr_product PR, pagos PG, mo_motive MO
            WHERE  PS.product_id = PR.product_id
            AND PR.subscription_id = PG.pagosusc
            AND PG.pagofegr > PS.aplication_date
            AND PR.product_id = MO.product_id
            AND MO.package_id = inuPackage
            AND PS.suspension_type_id = 2
            AND PS.active = ge_boconstants.getyes
            AND rownum = 1;
        EXCEPTION
            when no_data_found then
                nuPagado := 0;
        END;

        RETURN nuPagado;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbValidaPago;


    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  AtenderMotivo
    Descripcion : Atiende el motivo y la solicitud de reconexion
    Autor       : Sergio Mejia Rivera - Optima Consulting
    Fecha       : 07-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    07-09-2013          sergiom             Creacion.
    **************************************************************************/
    PROCEDURE AtenderMotivo
    (
        inuMotiveId         mo_motive.motive_id%type
    )
    IS
        cdtSYSDATE          constant date := UT_Date.fdtSysdate;
        rcMotive            DAMO_MOtive.styMO_Motive;
        rcPackage           damo_packages.styMO_packages;

    BEGIN

        -- Obtiene el registro del motivo (MO_MOTIVE)
        DAMO_Motive.getRecord(inuMotiveId, rcMotive);

        -- Valida si el motivo no esta atendido o en anulacion
        IF  (not PS_BOMotivestatus.fblIsFinalStatus(rcMotive.motive_status_id)) and
            (rcMotive.motive_status_id != mo_boConstants.cnuSTATUS_IN_ANNUL_MOT)
        THEN

            -- Se actualiza la fecha de atencion del motivo
            IF  (rcMotive.attention_date IS NULL) THEN
                DAMO_Motive.updAttention_date(rcMotive.motive_id, cdtSYSDATE);
            END IF;

            -- Se ejecuta la transicion de estados del motivo
            MO_BOMotiveActionUtil.ExecTranStatusForMot(rcMotive.motive_id, MO_BOActionParameter.fnuGetACTION_ATTEND);
        END IF;

        --Obtiene el registro de la solicitud (MO_PACKAGES)
        damo_packages.getRecord(rcMotive.package_id, rcPackage);

         -- Valida si el paquete no esta atendido o en anulacion
        IF  (not PS_BOMotivestatus.fblIsFinalStatus(rcPackage.Motive_Status_Id)) and
            (rcPackage.motive_status_id != mo_boConstants.cnuSTATUS_IN_ANNUL_PACK)
        THEN
            -- Se actualiza la fecha de atencion de la solicitud
            IF  (rcPackage.attention_date IS NULL) THEN
                damo_packages.updAttention_date(rcPackage.package_id, cdtSYSDATE);
            END IF;

            -- Se ejecuta la transicion de estados del paquete.
            MO_BOMotiveActionUtil.ExecTranStatusForPack(rcPackage.package_id, MO_BOActionParameter.fnuGetACTION_ATTEND);
        END IF;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END AtenderMotivo;


    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  ReconexionPorPago
    Descripcion : Inactiva las suspenciones por no pago asociadas al producto, y
                    realiza la reconexion del producto y sus componentes.
                  Entrada: Identificador de la solicitud
    Autor       : Sergio Mejia Rivera - Optima Consulting
    Fecha       : 07-09-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    07-09-2013          sergiom             Creacion.
    19-11-2014          agordillo TS3088    Se modifica para que el procedimiento no atienda
                                            la solicitud dado que este paso se separa en otra
                                            actividad en el flujo de la solicitud de reconexion
	10-04-2023			cgonzalez (Horbath)	OSF-923: Se modifica para actualizar estado de componentes, 
											actividad de suspension del producto y atender SUSPCONE
	31-05-2023			cgonzalez (Horbath)	OSF-1173: Se modifica para actualizar todas las ordenes de SUSPCONE
    **************************************************************************/
    PROCEDURE ReconexionPorPago(inuPackage in mo_packages.package_id%type)
    AS
        nuMotiveId          mo_motive.motive_id%type;
        nuProductID 		mo_motive.product_id%type;
        prodSuspensionId 	pr_prod_suspension.prod_suspension_id%type;
        nuContSusp      	NUMBER;

        type tytbCompSuspensions IS table of pr_comp_suspension.comp_suspension_id%type index BY binary_integer;

        type tytbComponentes IS table of pr_component.component_id%type index BY binary_integer;

        tbCompSuspensions   tytbCompSuspensions;

        tbComponentes       tytbComponentes;
			
		CURSOR cuCompsesu(inuProductId in pr_product.product_id%TYPE) IS
            SELECT 	cmssidco
            FROM 	compsesu C
            WHERE  	cmsssesu = inuProductId;
			
		type tytbCompsesu IS table of compsesu.cmssidco%type index BY binary_integer;
		tbCompsesu   tytbCompsesu;
		
		CURSOR cuCompSuspensions(inuProductId in pr_product.product_id%type)
        IS
            SELECT comp_suspension_id
            FROM pr_comp_suspension CS, pr_component C
            WHERE  CS.component_id = C.component_id
            AND C.product_id = inuProductId
            AND CS.suspension_type_id = 2
            AND CS.active = 'Y';
    BEGIN

		pkerrors.setapplication('LDCRECONEX');
		UT_Trace.Trace('Inicia LDC_BORECONECION.ReconexionPorPago ',8);
		UT_Trace.Trace('Package '||inuPackage,8);

        -- Obtiene el producto asociado al motivo
        BEGIN
            select product_id, motive_id
            into nuProductID, nuMotiveId
            from mo_motive
            where package_id=  inuPackage
            AND rownum = 1;

        EXCEPTION
            when no_data_found then
                UT_Trace.Trace('No se encuentra producto en el motivo ',8);
        END;
        -- obtiene el identificador de las suspencion por no pago del producto
        BEGIN
            SELECT prod_suspension_id
            INTO  prodSuspensionId
            FROM pr_prod_suspension
            WHERE suspension_type_id = 2
            AND active = ge_boconstants.getyes
            AND product_id = nuProductID
			AND inactive_date IS NULL
            AND rownum = 1;
        EXCEPTION
            when no_data_found then
                UT_Trace.Trace('No se encuentra una suspencion por falta de pago activa',8);
        END;

        -- obtiene la cantidad de suspenciones activas del producto, diferentes a la generada por no pago
        BEGIN
            SELECT count(1)
            INTO nuContSusp
            FROM pr_prod_suspension
            WHERE product_id = nuProductID
            AND suspension_type_id <> 2
            AND active = ge_boconstants.getyes
			AND inactive_date IS NULL;
        EXCEPTION
            when no_data_found then
                nuContSusp:=0;
        END;

        IF (prodSuspensionId IS not null) then
            -- Inactiva las suspenciones por no pago asociadas al producto
            dapr_prod_suspension.updactive(prodSuspensionId, ge_boconstants.getno );
            dapr_prod_suspension.updinactive_date(prodSuspensionId, sysdate);

            OPEN cuCompSuspensions(nuProductID);
            fetch cuCompSuspensions bulk collect into tbCompSuspensions;
            CLOSE  cuCompSuspensions;

            FOR indx IN 1 .. tbCompSuspensions.COUNT
            LOOP
                -- Inactiva las suspenciones por no pago de los componentes del producto
                dapr_comp_suspension.updactive(tbCompSuspensions(indx), ge_boconstants.getno );
                dapr_comp_suspension.updinactive_date(tbCompSuspensions(indx), sysdate);
            END LOOP;
            --Cambia el estado de suspencion del producto
            PKTBLSERVSUSC.upsuspensionstatus(nuProductID, 1);

        END if;

        -- Cambia el estado de corte del producto, si este no tiene otras suspenciones activas
        IF (nuProductID is not null) THEN
            if nuContSusp = 0 then
                dapr_product.updproduct_status_id(nuProductID, 1);
				
				--Actualiza actividad de suspension
				dapr_product.updsuspen_ord_act_id(nuProductID, NULL);
				--Actualiza fecha de corte del producto
				PKTBLSERVSUSC.UPDSESUFECO(nuProductID, NULL);
				
				OPEN cuCompsesu(nuProductID);
                fetch cuCompsesu bulk collect into tbCompsesu;
                CLOSE  cuCompsesu;
				
				FOR indx IN 1 .. tbCompsesu.COUNT
                LOOP
                    -- Actualiza el estado de los componentes del producto
                    dacompsesu.updcmssescm(tbCompsesu(indx), 5);
					-- actualiza el estado de corte de los componentes del producto
                    dapr_component.updcomponent_status_id(tbCompsesu(indx), 5);
                END LOOP;
				
				UPDATE 	suspcone
				SET 	sucofeat = SYSDATE
				WHERE 	suconuse = nuProductID
				AND 	sucofeat IS NULL
				AND		sucotipo = 'C'
				AND 	suconuor IN (select order_id 
									from or_order_activity 
									where task_type_id in (select unique task_Type_id
															from or_task_types_items i, or_act_by_task_mod c
															where i.items_id = c.items_id
															and c.task_code = 100561)
									and package_id = inuPackage);
            else

                UT_Trace.Trace('No se pudo cambiar el estado de corte del producto, ya que tiene suspenciones activas',8);
            END if;
        END IF;
        --Atiende el motivo y la solicitud de reconexion
        -- Agordillo TS3088 se comenta el procedimiento que permite atender la solicitud
        --AtenderMotivo(nuMotiveId);

        COMMIT;

        UT_Trace.Trace('Finaliza LDC_BORECONECION.ReconexionPorPago ',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ReconexionPorPago;

    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  fsbValidaCasual
    Descripcion : Valida la causal con la que se legalizo la orden de reconexion.
                  Retorna 'Y', si se legalizo con exito
                  Retorna 'N', si se legalizo con fallo
    Autor       : Sergio Mejia Rivera - Optima Consulting
    Fecha       : 25-02-2014

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    25-02-2014          sergiom             Creacion.
    17-09-2014          acardenas           Se modifica para tener en cuenta el tipo
                                            de causal de legalizacion.
    **************************************************************************/
    FUNCTION fsbValidaCasual(
        inuPackage in mo_packages.package_id%type
    ) return varchar2
    AS
        sbCausalDeExito varchar2(10) := 'N';
    BEGIN

        BEGIN
            SELECT  'Y'
            INTO    sbCausalDeExito
            FROM    OR_order_activity A, OR_order O, ge_causal C
            WHERE   A.package_id = inuPackage
                    AND A.order_id = O.order_id
                    AND C.causal_id = O.causal_id
                    AND C.class_causal_id = 1
                    AND c.causal_type_id not in (CNUCAUSFAIL, CNUCAUSANUL) -- Causal de Fallo y Anulacion
                    AND rownum = 1;
        EXCEPTION
            when no_data_found then
               sbCausalDeExito:= 'N';
        END;

        return sbCausalDeExito;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbValidaCasual;


     /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  revEstadoProducto
    Descripcion :  Permite reversar el estado de producto al anterior cuando la
                   causal de legalizacion es de fallo. Se devuelve el producto a su estado anterior
    Autor       : Alexandra Gordillo
    Fecha       : 19-11-2014

    Historia de Modificaciones
      Fecha               Autor                   Modificacion
    =========           =========               ====================
	31-05-2023			cgonzalez (Horbath)		OSF-1173: Se modifica para actualizar todas las ordenes de SUSPCONE
    18-06-2015          KCienfuegos.SAO329310   Se valida si el estado de corte actual es igual a 6,
                                                para reversar.
    19-11-2014          agordillo               Creacion.
    **************************************************************************/
    PROCEDURE revEstadoProducto(inuPackage in mo_packages.package_id%type) AS
        nuProductID     mo_motive.product_id%type;
        nuEstAnterior   number;
        nuCurrentState  servsusc.sesuesco%type;
    BEGIN

		UT_Trace.Trace('Inicia LDC_BORECONECION.revEstadoProducto ',8);
		UT_Trace.Trace('Package '||inuPackage,8);
		pkerrors.setapplication('LDCRECONEX');

        -- Obtiene el producto del motivo
        BEGIN
            select product_id into nuProductID from mo_motive
            where package_id=  inuPackage;
        EXCEPTION
            when no_data_found then
            UT_Trace.Trace('No se encuentra producto en el motivo ',8);
        END;

        --SAO.329310
        if nuProductID is not null then
		  nuCurrentState := personalizaciones.ldc_bcConsGenerales.fsbValorColumna('OPEN.SERVSUSC', 'SESUESCO', 'SESUNUSE', nuProductID);
        end if;
        --FIN SAO.329310

        -- Estado de Corte Anterior
        BEGIN
            select estado_anterior into nuEstAnterior
            from (  select hcececan estado_anterior
                    from hicaesco
                    where hcecnuse=nuProductID
                    order by hcecfech desc)
            where rownum=1;

        EXCEPTION
            when no_data_found then
            UT_Trace.Trace('No Estado de corte anterior ',8);
        END;

        --- Reversa el estado de corte del producto
        --SAO 329310 Se valida que el estado actual sea 6-Con orden de conexion
        IF (nuProductID is not null and nuCurrentState = CNUESTADCONORDEN) THEN
            PKTBLSERVSUSC.upsuspensionstatus(nuProductID, nuEstAnterior);
        END IF;
		
		UPDATE 	suspcone
		SET 	sucofeat = SYSDATE, sucotipo = 'A'
		WHERE 	suconuse = nuProductID
		AND 	sucofeat IS NULL
		AND		sucotipo = 'C'
		AND 	suconuor IN (select order_id 
							from or_order_activity 
							where task_type_id in (select unique task_Type_id
													from or_task_types_items i, or_act_by_task_mod c
													where i.items_id = c.items_id
													and c.task_code = 100561)
							and package_id = inuPackage);
		
        commit;

        UT_Trace.Trace('Finaliza LDC_BORECONECION.revEstadoProducto ',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END revEstadoProducto;
/*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : ValidateEstadoProducto
  Descripcion    : Procedimiento para Valida que el producto tenga un estado de corte valido
                   para generar el tramite 100240
  Autor          : Manuel Mejia
  Fecha          : 07/07/2015

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE ValidateEstadoProducto
  IS

      --Variables
      sbproductid         ge_boinstancecontrol.stysbvalue := NULL;
      sbprocessinstance   ge_boinstancecontrol.stysbname;
      sbidindex           VARCHAR2(100);
      nuindex             ge_boinstancecontrol.stynuindex;
      nuproductid         pr_product.product_id%TYPE;
      SBMENSAJE           VARCHAR2(3000);

      --Cursores
      CURSOR cuInfoProduct
      IS
      SELECT *
      FROM servsusc
      WHERE sesunuse=nuproductid
       AND sesuesco IN
                    ( SELECT To_Char(COLUMN_VALUE)
                        FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.fsbGetValue_Chain('ESTA_CORT_VAL_PAQ_100240',NULL),',')
                        )
                    );

     rccuInfoProduct cuInfoProduct%ROWTYPE;

  BEGIN
    ut_trace.trace('Inicio LDC_BORECONECION.ValidateEstadoProducto', 10);

      --Obtiene atributo producto  de la instancia WORK_INSTENCE
      IF (ge_boinstancecontrol.fblacckeyattributestack
                                (mo_bouncompositionconstants.csbwork_instance,
                                 NULL,
                                 'PR_PRODUCT',
                                 'PRODUCT_ID',
                                 sbidindex
                                ) = ge_boconstants.gettrue
         )
      THEN
         ge_boinstancecontrol.getattributenewvalue
                               (mo_bouncompositionconstants.csbwork_instance,
                                NULL,
                                'PR_PRODUCT',
                                'PRODUCT_ID',
                                sbproductid
                               );
      END IF;

      ut_trace.TRACE ('--> [PR_PRODUCT_WI]  sbProductId: ['|| sbproductid|| '] ',10);
      --Valida si el producto en nulo
      --Obtiene atributo producto  de la instancia PROCESS_INSTENCE
      IF (sbproductid IS NULL)
      THEN
         ge_boinstancecontrol.getcurrentinstance (sbprocessinstance);

         IF (ge_boinstancecontrol.fblacckeyattributestack (sbprocessinstance,
                                                           NULL,
                                                           'MO_PACKAGES',
                                                           'PRODUCT_ID',
                                                           nuindex
                                                          ) =
                                                        ge_boconstants.gettrue
            )
         THEN
            ge_boinstancecontrol.getattributenewvalue (sbprocessinstance,
                                                       NULL,
                                                       'MO_PACKAGES',
                                                       'PRODUCT_ID',
                                                       sbproductid
                                                      );
         END IF;

         ut_trace.TRACE (   '--> [MO_PACKAGES_CI]  sbProductId: ['|| sbproductid|| '] ',10);
      END IF;

      IF (sbproductid IS NULL)THEN
         ge_boinstancecontrol.getcurrentinstance (sbprocessinstance);

         IF (ge_boinstancecontrol.fblacckeyattributestack (sbprocessinstance,
                                                           NULL,
                                                           'MO_MOTIVE',
                                                           'PRODUCT_ID',
                                                           nuindex
                                                          ) =
                                                        ge_boconstants.gettrue
            )
         THEN
            ge_boinstancecontrol.getattributenewvalue (sbprocessinstance,
                                                       NULL,
                                                       'MO_MOTIVE',
                                                       'PRODUCT_ID',
                                                       sbproductid
                                                      );
         END IF;

         ut_trace.TRACE (   '--> [MO_MOTIVE_CI]  sbProductId: ['
                         || sbproductid
                         || '] ',
                         6
                        );
      END IF;

      IF (sbproductid IS NULL)THEN
         ut_trace.TRACE ('--> Sale sin validar debido a producto nulo. ', 6);
         ut_trace.TRACE
            ('==> LDC_BORECONECION.ValidateEstadoProducto Instance <FIN>',
             8
            );
         RETURN;
      END IF;
      --Numero de producto
      nuproductid := ut_convert.fnuchartonumber (sbproductid);

      --Valida si el producto tiene marca por suspension 102  o  103
      OPEN cuInfoProduct;
      FETCH cuInfoProduct INTO rccuInfoProduct;
      IF(cuInfoProduct%NOTFOUND)THEN
         --ge_boerrors.seterrorcode (cnuproductstatecutnodamage);
         SBMENSAJE := 'El producto ['||nuproductid||']'||' se encuentra en estado de corte ['||rccuInfoProduct.sesuesco||']';
         errors.seterror(Ld_Boconstans.cnuGeneric_Error,SBMENSAJE);
         RAISE ex.CONTROLLED_ERROR;
      END IF;
      CLOSE cuInfoProduct ;

    ut_trace.trace('Fin LDC_BORECONECION.ValidateEstadoProducto', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ValidateEstadoProducto;

    /**************************************************************************
    Propiedad Intelectual de PETI
    package     :  prudtEstadoProducto
    Descripcion : Actualiza estado de l producto
    Autor       : Luis Felipe Valencia
    Fecha       : 05-06-2023

    Historia de Modificaciones
    Fecha               Autor                Modificacion
    =========           =========          ====================
    05-06-2023          felipe.valencia    Creacion.
    **************************************************************************/
    PROCEDURE prudtEstadoProducto
    (
        inuProduct IN mo_motive.product_id%TYPE
    ) 
    AS
    BEGIN

        UT_Trace.Trace('Inicia LDC_BORECONECION.prudtEstadoProducto ',8);
        UT_Trace.Trace('inuProduct '||inuProduct,8);

        pkerrors.setapplication('LDCRECONEX');

        IF (inuProduct is not null) THEN
            PKTBLSERVSUSC.upsuspensionstatus(inuProduct, 6);
        END IF;

        COMMIT;

        UT_Trace.Trace('Finaliza LDC_BORECONECION.prudtEstadoProducto ',8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END prudtEstadoProducto;
END LDC_BORECONECION;
/