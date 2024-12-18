create or replace PROCEDURE ADM_PERSON.LDC_INSERTSUSPCONE
(
    inuProgramacion  in ge_process_schedule.process_schedule_id%type
)
AS

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : ldc_insertSuspcone
  Descripcion    : Procedimiento inserta registro en suspcone a partir de una regla pre de actividad de flujo
  Autor          : socoro@horbath.com CA 200-565
  Fecha          : 28/09/2016-

  Historia de Modificaciones
	Fecha       Autor               	Modificacion
    ==========	=================== 	====================================================================
    17-07-2013  cgonzalez (Horbath)     OSF-923: Se ajusta para que el cursor cuOrdenReconex tenga en cuenta los tipos de trabajos
										configurados la funcionalidad ORMTB sistema 100561 
  ******************************************************************/




  sbParametros          GE_PROCESS_SCHEDULE.PARAMETERS_%type;
  sbPACKAGE_ID          ge_boInstanceControl.stysbValue;
  inuPackageId          mo_packages.package_id%type;

  ----
   nuProductID          mo_motive.product_id%type;
				rcServsusc           servsusc%rowtype;
				nuAddressId          pr_product.address_id%type;
				inuDepa              ge_geogra_location.geograp_location_id%type;
				inuLocaId            ge_geogra_location.geograp_location_id%type;
				nuOrder              or_order.order_id%type;
				nuBeforeState        hicaesco.hcececan%type;



cursor cuOrdenReconex(inuPackage number)
       is
       select order_id 
	   from or_order_activity
       where task_type_id in (select unique task_Type_id
								from or_task_types_items i, or_act_by_task_mod c
								where i.items_id = c.items_id
								and c.task_code = 100561)
       and package_id = inuPackage;
---Cursor para obtener el estado de corte anterior asociado al producto
cursor cuBeforeStatus (inuProductId servsusc.sesunuse%type) is
       select HCECECAN
              from hicaesco
                   where hcecnuse = inuProductId
                         and hcecfech = (select max (hcecfech) from hicaesco where  hcecnuse = inuProductId);
cursor cu_or_order_activity(vinuorder or_order.order_id%type) is
       select ORDER_ACTIVITY_ID 
              from OR_ORDER_ACTIVITY
              WHERE ORDER_ID=vINUORDER;
ex  exception;
NU_OR_ORDER_ACTIVITY OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
begin

            sbParametros := dage_process_schedule.fsbgetparameters_(inuProgramacion);
            sbPACKAGE_ID := ut_string.getparametervalue  (sbParametros,'PACKAGE_ID','|','=');
            inuPackageId := to_number (sbPACKAGE_ID);
            dbms_output.put_line('inuPackageId => '||to_char(inuPackageId));

            -- Obtiene el producto del motivo
            BEGIN
                select product_id into nuProductID from mo_motive
                where package_id=  inuPackageId;  --OR_BOINSTANCE.fnugetextsysidfrominstance;

            EXCEPTION
                when no_data_found then
                UT_Trace.Trace('No se encuentra producto en el motivo ',8);
            END;

            ---Insertar en SUSPCONE un registro
            --Obtener dirección del producto
            nuAddressId := dapr_product.fnugetaddress_id(nuProductID,null);
            dbms_output.put_line('nuAddressId => '||to_char(nuAddressId));
            --Obtener localidad
            inuLocaId := daab_address.fnugetGEOGRAP_LOCATION_ID(nuAddressId,null);
            --Obtener Departamento
            inuDepa := dage_geogra_location.fnugetgeo_loca_father_id(inuLocaId,null);
            --Obtener orden de reconexión
            open cuOrdenReconex(inuPackageId);
            fetch cuOrdenReconex into nuOrder;
            close cuOrdenReconex;
            --obtener registro del producto
            select *
                   into rcServsusc
                   from servsusc
                   where servsusc.sesunuse = nuProductID;
            --Obtener estado anterior
            nuBeforeState := NULL;
            OPEN cuBeforeStatus (nuProductId);
            FETCH cuBeforeStatus INTO nuBeforeState;
            CLOSE cuBeforeStatus;

            NU_OR_ORDER_ACTIVITY:=NULL;
            OPEN cu_or_order_activity(NUORDER);
            FETCH cu_or_order_activity INTO NU_OR_ORDER_ACTIVITY;
            CLOSE cu_or_order_activity;
            ut_trace.trace('Ejecucion proceso Insercuin nuBeforeState => '||nuBeforeState,10);
            ldc_CREATESUSPCONE(
							INUSUSPIDSC    =>    SQIDSUSPCONE.NEXTVAL(),
							INUDEPAORDE    =>    inuDepa,
							INULOCAORDE    =>    inuLocaId,
							INUNUMEORDE    =>    nuOrder,
							INUEVENAPLI    =>    nuBeforeState,--CONFESCO.COECCODI%TYPE,
							INUCAUSDESC    =>    2,--SUSPCONE.SUCOCACD%TYPE,
							ISBSUCOTIPO    =>    'C',
							ISBOBSERVAC    =>    'Inserción desde regla POST de flujo' ,
							IRCSERVSUSC    =>    rcServsusc,
							INUCICLO       =>    rcServsusc.Sesucicl, --.SUSCCICL
                                                        INUORDER_ACTIVITY_ID => NU_OR_ORDER_ACTIVITY
						);
            commit;

   exception
     
      when ex then
        dbms_output.put_line('No se encuentra la orden');
        rollback;
       when others then
        dbms_output.put_line(sqlerrm);
        dbms_output.put_line(sqlerrm);
        rollback;
         
end ldc_insertSuspcone;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_INSERTSUSPCONE', 'ADM_PERSON');
END;
/
