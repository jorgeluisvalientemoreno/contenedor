create or replace TRIGGER LDC_TRGAU_ASIGAUTO

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRGAU_ASIGAUTO
    Descripcion    : Este trigger fue generado para asignacion automatica
                     ya que el proceso de asignacion automatica de SmartFelx
                     no permite asignar la unidad operativa como se plantea
                     la necesidad de las GASERAS
    Autor          : Jorge Valiente
    Fecha          : 02/11/2013

    Historia de Modificaciones
      Fecha                Autor             Modificacion
    =========            =========         ====================
    16-Enero-2014       Jorge Valiente     NC 2493. Se realizo la modificacion del trigger para que
                                           identifique si el producto es generico o no.
                                           Esto con el fin de cubrir la ceracion del producto generico
                                           de la herramienta de SMARTFLEX a la cual no le asigna una
                                           categoria al momento de la venta de solo interna.
                                           La solucion es crear 2 cursores.
                                           - El 1er cursor que identifique si el prodcuto es generico.
                                           - El 2do cursor que obtenga la categoria con base a la direccion de la orden
    12-Febrero-2014     Jorge Valiente     ARANDA 2767: Se modifico el cursor llamado CUGE_SECTOROPE_ZONA
                                           para que el codigo de la zona y el sector operativo se utilizaran mediante
                                           variables de entrada en la consulta del cursor.
                                           ya que por recomendaciones de OPEN defnieron no utilizar su servicios de DA
                                           de los paquetes de primer nivel de las entidades
    15-Marzo-2014       Jorge Valiente     ARANDA 2786:PROCESO QUE PERMITIRA ASIGNAR A LA ORDEN
                                           LA UNIDAD OPERATIVA DEFINIDA EN POR UOBYSOL.
                                           ESTE SERVICIO FUE CREADO POR LA ANULACION DE LA
                                           LOGICA DE ASIGNACION AUTOMATICA YA QUE LOS PROCESOS
                                           DE MANEJO DE ORDENES DE OPEN EN SMARTFLEX
                                           NO PERMITE TENER TRIGGERS QUE PERMITAN REALIZAR
                                           DE FORMA AUTOAMTICA EL PROCESO DE ASIGNACIO.
    27-Septiembre-2016  Caren Berdejo      CA 200-308 Se agrega condicion para bloqueos de ordenes
    09-Julio-2018       Jorge Valiente     CASO 200-1962: Ultizar el campo LEGALICE_TRY_TIMES para
                                                          establecer el bloqueo o no de la orden generada.
                                                          Se colocara la logica establecida por la N1 Diana Saltarin
                                                          -El llamdo del cursor CUOR_RELATED_ORDER del CASO 200-1334
                                                          sera colocado en comentario para que no sea valido
	17-Octubre-2018    Diana Saltarin	Caso 200-2230 Se modifica para que cuando se bloquee la orden se guarde el estado anterior.

	15-Mayo-2019        Eduardo Ceron   Caso 200-2550 Validacion para cambiar el estado de una orden.
  ******************************************************************/

  AFTER UPDATE ON OPEN.OR_ORDER_ACTIVITY
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW



when ((OLD.ORDER_ID IS NULL AND NEW.ORDER_ID IS NOT NULL) OR
       (NVL(OLD.PACKAGE_ID, 0) <> NVL(NEW.PACKAGE_ID, 0)))
Declare

  --CURSOR PARA VALIDAR SI LA ORDEN YA TIENE
  --UNIDAD OPERATIVA ASIGNADA.
  Cursor cuor_order Is
    Select oo.*
      From or_order oo
     Where oo.order_id = :new.order_id
       And oo.operating_unit_id Is Null;

  tempcuor_order cuor_order%Rowtype;

  --CURSOR PARA VALIDAR SI LA ORDEN YA TIENE
  --UNIDAD OPERATIVA ASIGNADA.
  Cursor culdc_order Is
    Select lo.* From ldc_order lo Where lo.order_id = :new.order_id;

  tempculdc_order culdc_order%Rowtype;

  --CURSOR PARA PERMITIR REGISTRAR EN LA ENTIDAD
  --LDC_ORDER LAS ORDENES CON ACTIVIDAD CONFIGURADAS EN UOBYSOL
  Cursor culdc_orderexist Is
    Select items_id
      From ldc_package_type_oper_unit t
     Where t.items_id Is Not Null
       And t.items_id = decode(:new.activity_id,
                               Null,
                               :old.activity_id,
                               :new.activity_id)
     Group By items_id;

  tempculdc_orderexist culdc_orderexist%Rowtype;

  sbexecservicio    Varchar2(4000);
  sbunidadoperativa Varchar2(4000);
  sbdatain          Varchar2(4000);

  id_paramtram    Number;
  id_tramite      Number;
  onuerrorcode    Number;
  osberrormessage Varchar2(4000);
  v1              Number;
  v2              Number;
  v3              Number;
  v4              Number;
  v5              Number;
  v6              Number;

  --INICIO CASO 200-1334
  CURSOR CUOR_RELATED_ORDER (inuOrderId number) is
    select count(OR_RELATED_ORDER.ORDER_ID) cantidad
      FROM OR_RELATED_ORDER
     WHERE OR_RELATED_ORDER.RELATED_ORDER_ID = inuOrderId
       and OR_RELATED_ORDER.RELA_ORDER_TYPE_ID = 2;


  rfCUOR_RELATED_ORDER CUOR_RELATED_ORDER%rowtype;
  causal_id_paramtram    Number;
  nuCOD_EST_BLO_OT       number := nvl(open.dald_parameter.fnuGetNumeric_Value('COD_EST_BLO_OT',null),11);
  --FIN CASO 200-1334
  nuEstadoAnte open.or_order.prev_order_status_id%type;--200-2230

  /*Caso 200-2550*/
  nuTypePackage mo_packages.package_type_id%type;
  nuValActRequest NUMBER;
  nuValOrderActivity NUMBER;

Begin

  ut_trace.trace('INICIO LDC_TRGAU_ASIGAUTO', 10);
  v1 := :new.order_activity_id;
  v2 := :new.order_id;
  v3 := :new.activity_id;
  v4 := :old.order_id;
  v5 := :new.package_id;
  v6 := :old.package_id;

  If fblaplicaentrega('OSS_CON_CBB_200308_5') Then

   UT_TRACE.TRACE('ingreso aqui ',10);
    Begin
      Select package_type_id
        Into id_tramite
        From mo_packages
       Where package_id = :new.package_id;
    Exception
      When no_data_found Then
        id_tramite := Null;
      When Others Then
        id_tramite := Null;
    End;
    If id_tramite Is Not Null Then
        UT_TRACE.TRACE('ingreso 1 '||id_tramite,10);
      Begin
        Select id, nvl(causal_id,0)
          Into id_paramtram, causal_id_paramtram
          From ldc_paramtram
         Where tramite = id_tramite
           And actividad = :new.activity_id
           --CASO 200-1334 No estaba incluido en la cotizacion pero hay que retornar la causal de fallo configurada
           and rownum = 1
           --CASO 200-1334 No estaba incluido en la cotizacion pero hay que retornar la causal de fallo configurada
           ;
      Exception
        When no_data_found Then
          id_paramtram := Null;
        When Others Then
          id_paramtram := Null;
      End;

      --CAOS 200-1962
      --Agregar logica a la condicion de validacion solicitado
      --If id_paramtram Is Not Null Then
      If id_paramtram Is Not Null and :new.order_id is not null /*and nvl(:new.legalize_try_times,0) = 0*/ Then
           UT_TRACE.TRACE('ingreso 2 '||:new.order_id ,10);
		   
		      ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'INICIO LDC_TRGAU_ASIGAUTO ');
			  sbdatain := 'PETI ACTIVIDAD OLD [' || :old.activity_id ||
                    '] - ACTIVIDAD NEW [' || :new.activity_id ||
                    '] - PRODUCTO OLD [' || :old.product_id ||
                    '] - PRODUCTO NEW [' || :new.product_id ||
					  '] - ORDEN OLD [' || :old.ORDER_ID ||
                    '] - ORDEN NEW [' || :new.ORDER_ID ||
					'] - ORDEN NEW [' || :new.ORDER_ID ||
                    '] - id_paramtram  [' || id_paramtram ||
                     '] - ORDER ACT ID OLD [' || :old.ORDER_ACTIVITY_ID ||
                      '] - ORDER ACT ID  NEW [' || :NEW.ORDER_ACTIVITY_ID ||
                    '] - DIRECCION NEW [' || :new.address_id || ']';

        ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'INICIO LDC_TRGAU_ASIGAUTO ' ||
                                             sbdatain);
											 
        /*--Comnetariado por CASO 200-1962
        --CASO 200-1334
        open CUOR_RELATED_ORDER(v2);
        fetch CUOR_RELATED_ORDER into rfCUOR_RELATED_ORDER;
        if CUOR_RELATED_ORDER%found then
          if rfCUOR_RELATED_ORDER.Cantidad = 0 then
        --CASO 200-1334
        */

            --CASO 200-1334 cambiar el llamado del servicio de OPEN con un servicio con PRAGMA para evitar el
            -- inconveninte de error de COMMITo ROLLBAK por medio del TGRIGGER
            --or_bofwlockorder.lockorder(v2,1296,'ORDEN BLOQUEDA POR CONFIGURACION DE LA FORMA FCBOG');
             --200-2230
             --LDC_prBloqueaOrden(v2);
              begin
              select order_status_id into nuEstadoAnte
              from open.or_order o
              where o.order_id=v2;
              exception
                when others then
                  nuEstadoAnte := null;
              end;
              --200-2230
            if causal_id_paramtram > 0 then
              UT_TRACE.TRACE('ingreso 3 '||causal_id_paramtram,10 );
			  
              /*Caso 200-2550*/
              UT_TRACE.TRACE('VALIDACION CASO 200-2550',10);
                IF :NEW.PACKAGE_ID IS NOT NULL THEN

                    SELECT PACKAGE_TYPE_ID
                    INTO nuTypePackage
                    FROM MO_PACKAGES
                    WHERE PACKAGE_ID = :NEW.PACKAGE_ID;

                END IF;

                select count(1)
                into nuValActRequest
                from ldc_paramtram
                where tramite = nuTypePackage
                and actividad = :NEW.ACTIVITY_ID;
                UT_TRACE.TRACE('ingreso 4 '||nuValActRequest,10 );
                UT_TRACE.TRACE('VALIDACION SI EXISTE CONFIGURACION EN ldc_paramtram',10);
				
				ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'PROCESO DE BLOQUEO' ||
                                             causal_id_paramtram||' '||nuTypePackage);
                IF nuValActRequest > 0 THEN
                
                   IF nuTypePackage <> 323 THEN
                     nuValOrderActivity :=  LDC_FNUGETCANTACTXPROD(:NEW.PACKAGE_ID,:NEW.PRODUCT_ID, :NEW.ACTIVITY_ID );
                   ELSE
                      IF :NEW.PRODUCT_ID <> :OLD.PRODUCT_ID AND :OLD.PRODUCT_ID IS NOT NULL THEN
                        nuValOrderActivity :=  LDC_FNUGETCANTACTXPROD(:NEW.PACKAGE_ID,:NEW.PRODUCT_ID, :NEW.ACTIVITY_ID );
                      ELSE
                         nuValOrderActivity :=  LDC_FNUGETCANTACTXPROD(:NEW.PACKAGE_ID,:OLD.PRODUCT_ID , :NEW.ACTIVITY_ID );
                      END IF;
                      
                   END IF;
                     UT_TRACE.TRACE('VALIDACION SI ES LA PRIMERA ORDEN',10);
                       dbms_output.put_line(' actividad '||nuValOrderActivity);
					 ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'PROCESO DE ORDEN DE ACTIVIDAD ' ||
                                             nuValOrderActivity);
											 
                    IF nuValOrderActivity = 0 THEN

                        update open.or_order oo set oo.causal_id = causal_id_paramtram , oo.order_status_id = nuCOD_EST_BLO_OT,
    					           prev_order_status_id = nuEstadoAnte --200-2230
    			               where oo.order_id= v2;
                           UT_TRACE.TRACE('ingreso 6 '||nuValOrderActivity ,10);
                    END IF;

                END IF;

            end if;

        /*--Comnetariado por CASO 200-1962
        --CASO 200-1334
          end if;
        end if;
        --CASO 200-1334
        */

      Else

        ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'INICIO LDC_TRGAU_ASIGAUTO ');

        sbdatain := 'PETI ACTIVIDAD OLD [' || :old.activity_id ||
                    '] - ACTIVIDAD NEW [' || :new.activity_id ||
                    '] - PRODUCTO OLD [' || :old.product_id ||
                    '] - PRODUCTO NEW [' || :new.product_id ||
                    '] - DIRECCION OLD [' || :old.address_id ||
       
                    '] - DIRECCION NEW [' || :new.address_id || ']';

        ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'INICIO LDC_TRGAU_ASIGAUTO ' ||
                                             sbdatain);

        --CURSOR PARA VALIDAR SI LA ACTIVIDAD
        --ESTA CONFIGURADA EN UOBYSOL
        Open culdc_orderexist;
        Fetch culdc_orderexist
          Into tempculdc_orderexist;
        If culdc_orderexist%Found Then
          ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                               :new.order_id,
                                               'PASO CURSOR CULDC_ORDEREXIST');

          --VALIDA SI LA ORDEN YA TIENE UNA
          --UNIDAD OPERATIVA ASIGNADA
          Open cuor_order;
          Fetch cuor_order
            Into tempcuor_order;
          If cuor_order%Found Then
            ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                                 :new.order_id,
                                                 'PASO CURSOR CUOR_ORDER');

            Open culdc_order;
            Fetch culdc_order
              Into tempculdc_order;
            If culdc_order%Found Then
              If nvl(tempculdc_order.package_id, 0) = 0 Then
                Update ldc_order
                   Set package_id = :new.package_id
                 Where order_id = :new.order_id;
                ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                                     :new.order_id,
                                                     'ACTUALIZO');

              End If;
            Else
              Insert Into ldc_order
                (order_id, package_id)
              Values
                (:new.order_id, :new.package_id);
              ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                                   :new.order_id,
                                                   'INSERTO');
            End If;

          Else
            ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                                 :new.order_id,
                                                 'LA ORDEN NO EXISTE');

          End If; --FIN VALIDACION ORDEN CON UNIDAD OPERATIVE
          Close cuor_order;

        Else
          ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                               :new.order_id,
                                               'LA CONFIGURACION EN UOBYSOL NO EXISTE');

        End If;
        Close culdc_orderexist;
        --FIN CURSOR CULDC_ORDEREXIST

      End If;
    Else

      ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                           :new.order_id,
                                           'INICIO LDC_TRGAU_ASIGAUTO ');

      sbdatain := 'PETI ACTIVIDAD OLD [' || :old.activity_id ||
                  '] - ACTIVIDAD NEW [' || :new.activity_id ||
                  '] - PRODUCTO OLD [' || :old.product_id ||
                  '] - PRODUCTO NEW [' || :new.product_id ||
                  '] - DIRECCION OLD [' || :old.address_id ||
                  '] - DIRECCION NEW [' || :new.address_id || ']';

      ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                           :new.order_id,
                                           'INICIO LDC_TRGAU_ASIGAUTO ' ||
                                           sbdatain);

      --CURSOR PARA VALIDAR SI LA ACTIVIDAD
      --ESTA CONFIGURADA EN UOBYSOL
      Open culdc_orderexist;
      Fetch culdc_orderexist
        Into tempculdc_orderexist;
      If culdc_orderexist%Found Then
        ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'PASO CURSOR CULDC_ORDEREXIST');

        --VALIDA SI LA ORDEN YA TIENE UNA
        --UNIDAD OPERATIVA ASIGNADA
        Open cuor_order;
        Fetch cuor_order
          Into tempcuor_order;
        If cuor_order%Found Then
          ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                               :new.order_id,
                                               'PASO CURSOR CUOR_ORDER');

          Open culdc_order;
          Fetch culdc_order
            Into tempculdc_order;
          If culdc_order%Found Then
            If nvl(tempculdc_order.package_id, 0) = 0 Then
              Update ldc_order
                 Set package_id = :new.package_id
               Where order_id = :new.order_id;
              ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                                   :new.order_id,
                                                   'ACTUALIZO');

            End If;
          Else
            Insert Into ldc_order
              (order_id, package_id)
            Values
              (:new.order_id, :new.package_id);
            ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                                 :new.order_id,
                                                 'INSERTO');
          End If;

        Else
          ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                               :new.order_id,
                                               'LA ORDEN NO EXISTE');

        End If; --FIN VALIDACION ORDEN CON UNIDAD OPERATIVE
        Close cuor_order;

      Else
        ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'LA CONFIGURACION EN UOBYSOL NO EXISTE');

      End If;
      Close culdc_orderexist;
      --FIN CURSOR CULDC_ORDEREXIST

    End If;
  Else

    ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                         :new.order_id,
                                         'INICIO LDC_TRGAU_ASIGAUTO ');

    sbdatain := 'PETI ACTIVIDAD OLD [' || :old.activity_id ||
                '] - ACTIVIDAD NEW [' || :new.activity_id ||
                '] - PRODUCTO OLD [' || :old.product_id ||
                '] - PRODUCTO NEW [' || :new.product_id ||
                '] - DIRECCION OLD [' || :old.address_id ||
                '] - DIRECCION NEW [' || :new.address_id || ']';

    ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                         :new.order_id,
                                         'INICIO LDC_TRGAU_ASIGAUTO ' ||
                                         sbdatain);

    --CURSOR PARA VALIDAR SI LA ACTIVIDAD
    --ESTA CONFIGURADA EN UOBYSOL
    Open culdc_orderexist;
    Fetch culdc_orderexist
      Into tempculdc_orderexist;
    If culdc_orderexist%Found Then
      ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                           :new.order_id,
                                           'PASO CURSOR CULDC_ORDEREXIST');

      --VALIDA SI LA ORDEN YA TIENE UNA
      --UNIDAD OPERATIVA ASIGNADA
      Open cuor_order;
      Fetch cuor_order
        Into tempcuor_order;
      If cuor_order%Found Then
        ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'PASO CURSOR CUOR_ORDER');

        Open culdc_order;
        Fetch culdc_order
          Into tempculdc_order;
        If culdc_order%Found Then
          If nvl(tempculdc_order.package_id, 0) = 0 Then
            Update ldc_order
               Set package_id = :new.package_id
             Where order_id = :new.order_id;
            ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                                 :new.order_id,
                                                 'ACTUALIZO');

          End If;
        Else
          Insert Into ldc_order
            (order_id, package_id)
          Values
            (:new.order_id, :new.package_id);
          ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                               :new.order_id,
                                               'INSERTO');
        End If;

      Else
        ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                             :new.order_id,
                                             'LA ORDEN NO EXISTE');

      End If; --FIN VALIDACION ORDEN CON UNIDAD OPERATIVE
      Close cuor_order;

    Else
      ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                           :new.order_id,
                                           'LA CONFIGURACION EN UOBYSOL NO EXISTE');

    End If;
    Close culdc_orderexist;
    --FIN CURSOR CULDC_ORDEREXIST

  End If;

  ut_trace.trace('FIN LDC_TRGAU_ASIGAUTO', 10);



Exception
  When Others Then

    sbdatain := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                dbms_utility.format_error_stack || '] - [' ||
                dbms_utility.format_error_backtrace || ']';
    Dbms_Output.Put_line( 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                dbms_utility.format_error_stack || '] - [' ||
                dbms_utility.format_error_backtrace || ']');

    ldc_boasigauto.prregsitroasigautolog(:new.package_id,
                                         :new.order_id,
                                         sbdatain);
End ldc_trgau_asigauto;
/